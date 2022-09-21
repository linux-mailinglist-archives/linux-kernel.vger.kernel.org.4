Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A2A5BFBDD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiIUKAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiIUJ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:59:57 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ED21659B;
        Wed, 21 Sep 2022 02:59:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQNuDE2_1663754378;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQNuDE2_1663754378)
          by smtp.aliyun-inc.com;
          Wed, 21 Sep 2022 17:59:45 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V4 2/8] ublk_drv: refactor ublk_cancel_queue()
Date:   Wed, 21 Sep 2022 17:58:43 +0800
Message-Id: <20220921095849.84988-3-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220921095849.84988-1-ZiyangZhang@linux.alibaba.com>
References: <20220921095849.84988-1-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assume only a few FETCH_REQ ioucmds are sent to ublk_drv, then the
ubq_daemon exits, We have to call io_uring_cmd_done() for all ioucmds
received so that io_uring ctx will not leak.

ublk_cancel_queue() may be called before START_DEV or after STOP_DEV,
we decrease ubq->nr_io_ready and clear UBLK_IO_FLAG_ACTIVE so that we
won't call io_uring_cmd_done() twice for one ioucmd to avoid UAF. Also
clearing UBLK_IO_FLAG_ACTIVE makes the code more reasonable.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c39b67d7133d..0c6db0978ed0 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -963,22 +963,39 @@ static inline bool ublk_queue_ready(struct ublk_queue *ubq)
 	return ubq->nr_io_ready == ubq->q_depth;
 }
 
+/* If ublk_cancel_queue() is called before sending START_DEV(), ->mutex
+ * provides protection on above update.
+ *
+ * If ublk_cancel_queue() is called after sending START_DEV(), disk is
+ * deleted first, UBLK_IO_RES_ABORT is returned so that any new io
+ * command can't be issued to driver, so updating on io flags and
+ * nr_io_ready is safe here.
+ *
+ * Also ->nr_io_ready is guaranteed to become zero after ublk_cance_queue()
+ * returns since request queue is either frozen or not present in both two
+ * cases.
+ */
 static void ublk_cancel_queue(struct ublk_queue *ubq)
 {
 	int i;
 
-	if (!ublk_queue_ready(ubq))
+	if (!ubq->nr_io_ready)
 		return;
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
 
-		if (io->flags & UBLK_IO_FLAG_ACTIVE)
+		if (io->flags & UBLK_IO_FLAG_ACTIVE) {
+			pr_devel("%s: done old cmd: qid %d tag %d\n",
+					__func__, ubq->q_id, i);
 			io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, 0);
+			io->flags &= ~UBLK_IO_FLAG_ACTIVE;
+			ubq->nr_io_ready--;
+		}
 	}
 
 	/* all io commands are canceled */
-	ubq->nr_io_ready = 0;
+	WARN_ON_ONCE(ubq->nr_io_ready);
 }
 
 /* Cancel all pending commands, must be called after del_gendisk() returns */
-- 
2.27.0

