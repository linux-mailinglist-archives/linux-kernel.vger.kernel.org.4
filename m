Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760745BFBD9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiIUJ7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiIUJ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:59:43 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B2B388E;
        Wed, 21 Sep 2022 02:59:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQNuD7z_1663754364;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQNuD7z_1663754364)
          by smtp.aliyun-inc.com;
          Wed, 21 Sep 2022 17:59:37 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V4 1/8] ublk_drv: check 'current' instead of 'ubq_daemon'
Date:   Wed, 21 Sep 2022 17:58:42 +0800
Message-Id: <20220921095849.84988-2-ZiyangZhang@linux.alibaba.com>
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

This check is not atomic. So with recovery feature, ubq_daemon may be
modified simultaneously by recovery task. Instead, check 'current' is
safe here because 'current' never changes.

Also add comment explaining this check, which is really important for
understanding recovery feature.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6a4a94b4cdf4..c39b67d7133d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -645,14 +645,22 @@ static inline void __ublk_rq_task_work(struct request *req)
 	struct ublk_device *ub = ubq->dev;
 	int tag = req->tag;
 	struct ublk_io *io = &ubq->ios[tag];
-	bool task_exiting = current != ubq->ubq_daemon || ubq_daemon_is_dying(ubq);
 	unsigned int mapped_bytes;
 
 	pr_devel("%s: complete: op %d, qid %d tag %d io_flags %x addr %llx\n",
 			__func__, io->cmd->cmd_op, ubq->q_id, req->tag, io->flags,
 			ublk_get_iod(ubq, req->tag)->addr);
 
-	if (unlikely(task_exiting)) {
+	/*
+	 * Task is exiting if either:
+	 *
+	 * (1) current != ubq_daemon.
+	 * io_uring_cmd_complete_in_task() tries to run task_work
+	 * in a workqueue if ubq_daemon(cmd's task) is PF_EXITING.
+	 *
+	 * (2) current->flags & PF_EXITING.
+	 */
+	if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING)) {
 		blk_mq_end_request(req, BLK_STS_IOERR);
 		mod_delayed_work(system_wq, &ub->monitor_work, 0);
 		return;
-- 
2.27.0

