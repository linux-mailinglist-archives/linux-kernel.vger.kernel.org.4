Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90235E7E9C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiIWPkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbiIWPkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:40:05 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81A13ECE0;
        Fri, 23 Sep 2022 08:39:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQXQbp-_1663947595;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQXQbp-_1663947595)
          by smtp.aliyun-inc.com;
          Fri, 23 Sep 2022 23:39:56 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V6 3/7] ublk_drv: requeue rqs with recovery feature enabled
Date:   Fri, 23 Sep 2022 23:39:15 +0800
Message-Id: <20220923153919.44078-4-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220923153919.44078-1-ZiyangZhang@linux.alibaba.com>
References: <20220923153919.44078-1-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With recovery feature enabled, in ublk_queue_rq or task work
(in exit_task_work or fallback wq), we requeue rqs instead of
ending(aborting) them. Besides, No matter recovery feature is enabled
or disabled, we schedule monitor_work immediately.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 05bfbaa49696..9ce5617d21df 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -655,10 +655,21 @@ static void ubq_complete_io_cmd(struct ublk_io *io, int res)
 
 #define UBLK_REQUEUE_DELAY_MS	3
 
+static inline void __ublk_abort_rq(struct ublk_queue *ubq,
+		struct request *rq)
+{
+	/* We cannot process this rq so just requeue it. */
+	if (ublk_queue_can_use_recovery(ubq))
+		blk_mq_requeue_request(rq, false);
+	else
+		blk_mq_end_request(rq, BLK_STS_IOERR);
+
+	mod_delayed_work(system_wq, &ubq->dev->monitor_work, 0);
+}
+
 static inline void __ublk_rq_task_work(struct request *req)
 {
 	struct ublk_queue *ubq = req->mq_hctx->driver_data;
-	struct ublk_device *ub = ubq->dev;
 	int tag = req->tag;
 	struct ublk_io *io = &ubq->ios[tag];
 	unsigned int mapped_bytes;
@@ -677,8 +688,7 @@ static inline void __ublk_rq_task_work(struct request *req)
 	 * (2) current->flags & PF_EXITING.
 	 */
 	if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING)) {
-		blk_mq_end_request(req, BLK_STS_IOERR);
-		mod_delayed_work(system_wq, &ub->monitor_work, 0);
+		__ublk_abort_rq(ubq, req);
 		return;
 	}
 
@@ -768,8 +778,8 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	if (unlikely(ubq_daemon_is_dying(ubq))) {
  fail:
-		mod_delayed_work(system_wq, &ubq->dev->monitor_work, 0);
-		return BLK_STS_IOERR;
+		__ublk_abort_rq(ubq, rq);
+		return BLK_STS_OK;
 	}
 
 	if (ublk_can_use_task_work(ubq)) {
-- 
2.27.0

