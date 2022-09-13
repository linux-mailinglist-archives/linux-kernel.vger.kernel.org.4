Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775D65B666B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 06:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiIMETD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 00:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiIMESx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:18:53 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB7C5467D;
        Mon, 12 Sep 2022 21:18:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VPccyDn_1663042725;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VPccyDn_1663042725)
          by smtp.aliyun-inc.com;
          Tue, 13 Sep 2022 12:18:48 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V3 2/7] ublk_drv: refactor ublk_cancel_queue()
Date:   Tue, 13 Sep 2022 12:17:02 +0800
Message-Id: <20220913041707.197334-3-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
References: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

