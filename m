Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA895B6672
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 06:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiIMETa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 00:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiIMETA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:19:00 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D989253D23;
        Mon, 12 Sep 2022 21:18:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VPccyHb_1663042734;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VPccyHb_1663042734)
          by smtp.aliyun-inc.com;
          Tue, 13 Sep 2022 12:18:56 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V3 5/7] ublk_drv: consider recovery feature in aborting mechanism
Date:   Tue, 13 Sep 2022 12:17:05 +0800
Message-Id: <20220913041707.197334-6-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
References: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With USER_RECOVERY feature enabled, the monitor_work schedules
quiesce_work after finding a dying ubq_daemon. The quiesce_work's job
is to:
(1) quiesce request queue.
(2) check if there is any INFLIGHT rq with UBLK_IO_FLAG_ACTIVE unset.
    If so, we retry until all these rqs are requeued by ublk_queue_rq()
    and task_work and become IDLE.
(3) requeue/abort inflight rqs issued to the crash ubq_daemon before. If
    UBLK_F_USER_RECOVERY_REISSUE is set, rq is requeued; or it is
    aborted.
(4) complete all ioucmds by calling io_uring_cmd_done(). We are safe to
    do so because no ioucmd can be referenced now.
(5) set ub's state to UBLK_S_DEV_QUIESCED, which means we are ready for
    recovery. This state is exposed to userspace by GET_DEV_INFO.

The driver can always handle STOP_DEV and cleanup everything no matter
ub's state is LIVE or QUIESCED. After ub's state is UBLK_S_DEV_QUIESCED,
user can recover with new process by sending START_USER_RECOVERY.

Note: we do not change the default behavior with reocvery feature
disabled. monitor_work still schedules stop_work and abort inflight
rqs. Finally ublk_device is released.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 168 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 161 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b067f33a1913..4409a130d0b6 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -121,7 +121,7 @@ struct ublk_queue {
 
 	unsigned long io_addr;	/* mapped vm address */
 	unsigned int max_io_sz;
-	bool abort_work_pending;
+	bool force_abort;
 	unsigned short nr_io_ready;	/* how many ios setup */
 	struct ublk_device *dev;
 	struct ublk_io ios[0];
@@ -163,6 +163,7 @@ struct ublk_device {
 	 * monitor each queue's daemon periodically
 	 */
 	struct delayed_work	monitor_work;
+	struct work_struct	quiesce_work;
 	struct work_struct	stop_work;
 };
 
@@ -660,6 +661,11 @@ static void __ublk_fail_req(struct ublk_io *io, struct request *req)
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
 
 	if (!(io->flags & UBLK_IO_FLAG_ABORTED)) {
+		pr_devel("%s: abort rq: qid %d tag %d io_flags %x\n",
+				__func__,
+				((struct ublk_queue *)req->mq_hctx->driver_data)->q_id,
+				req->tag,
+				io->flags);
 		io->flags |= UBLK_IO_FLAG_ABORTED;
 		blk_mq_end_request(req, BLK_STS_IOERR);
 	}
@@ -820,6 +826,21 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	res = ublk_setup_iod(ubq, rq);
 	if (unlikely(res != BLK_STS_OK))
 		return BLK_STS_IOERR;
+    /* With recovery feature enabled, force_abort is set in
+     * ublk_stop_dev() before calling del_gendisk() if ub's state
+     * is QUIESCED. We have to abort all requeued and new rqs here
+     * to let del_gendisk() move on. Besides, we do not call
+     * io_uring_cmd_complete_in_task() to avoid UAF on io_uring ctx.
+     *
+     * Note: force_abort is guaranteed to be seen because it is set
+     * before request queue is unqiuesced.
+     */
+	if (unlikely(ubq->force_abort)) {
+		pr_devel("%s: abort rq: qid %d tag %d io_flags %x\n",
+				__func__, ubq->q_id, rq->tag,
+				ubq->ios[rq->tag].flags);
+		return BLK_STS_IOERR;
+	}
 
 	blk_mq_start_request(bd->rq);
 
@@ -1003,6 +1024,101 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 	ublk_put_device(ub);
 }
 
+static bool ublk_check_inflight_rq(struct request *rq, void *data)
+{
+	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
+	struct ublk_io *io = &ubq->ios[rq->tag];
+	bool *busy = data;
+
+	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
+		*busy = true;
+		return false;
+	}
+	return true;
+}
+
+static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
+{
+	bool busy = false;
+
+	WARN_ON_ONCE(!blk_queue_quiesced(ub->ub_disk->queue));
+	while (true) {
+		blk_mq_tagset_busy_iter(&ub->tag_set,
+				ublk_check_inflight_rq, &busy);
+		if (busy)
+			msleep(UBLK_REQUEUE_DELAY_MS);
+		else
+			break;
+	}
+}
+
+static void ublk_quiesce_queue(struct ublk_device *ub,
+		struct ublk_queue *ubq)
+{
+	int i;
+
+	for (i = 0; i < ubq->q_depth; i++) {
+		struct ublk_io *io = &ubq->ios[i];
+
+		if (!(io->flags & UBLK_IO_FLAG_ACTIVE)) {
+			struct request *rq = blk_mq_tag_to_rq(
+					ub->tag_set.tags[ubq->q_id], i);
+
+			WARN_ON_ONCE(!rq);
+			pr_devel("%s: %s rq: qid %d tag %d io_flags %x\n", __func__,
+					ublk_queue_can_use_recovery_reissue(ubq) ?
+					"requeue" : "abort",
+					ubq->q_id, i, io->flags);
+			if (ublk_queue_can_use_recovery_reissue(ubq))
+				blk_mq_requeue_request(rq, false);
+			else
+				__ublk_fail_req(io, rq);
+		} else {
+			pr_devel("%s: done old cmd: qid %d tag %d\n",
+					__func__, ubq->q_id, i);
+			io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, 0);
+			io->flags &= ~UBLK_IO_FLAG_ACTIVE;
+		}
+		ubq->nr_io_ready--;
+	}
+	WARN_ON_ONCE(ubq->nr_io_ready);
+}
+
+static void ublk_quiesce_dev(struct ublk_device *ub)
+{
+	int i;
+
+	mutex_lock(&ub->mutex);
+	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
+		goto unlock;
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		if (!ubq_daemon_is_dying(ubq))
+			goto unlock;
+	}
+	blk_mq_quiesce_queue(ub->ub_disk->queue);
+	ublk_wait_tagset_rqs_idle(ub);
+	pr_devel("%s: quiesce ub: dev_id %d\n",
+			__func__, ub->dev_info.dev_id);
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+		ublk_quiesce_queue(ub, ublk_get_queue(ub, i));
+
+	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
+ unlock:
+	mutex_unlock(&ub->mutex);
+}
+
+static void ublk_quiesce_work_fn(struct work_struct *work)
+{
+	struct ublk_device *ub =
+		container_of(work, struct ublk_device, quiesce_work);
+
+	ublk_quiesce_dev(ub);
+}
+
 static void ublk_daemon_monitor_work(struct work_struct *work)
 {
 	struct ublk_device *ub =
@@ -1013,10 +1129,14 @@ static void ublk_daemon_monitor_work(struct work_struct *work)
 		struct ublk_queue *ubq = ublk_get_queue(ub, i);
 
 		if (ubq_daemon_is_dying(ubq)) {
-			schedule_work(&ub->stop_work);
-
-			/* abort queue is for making forward progress */
-			ublk_abort_queue(ub, ubq);
+			if (ublk_queue_can_use_recovery(ubq)) {
+				schedule_work(&ub->quiesce_work);
+			} else {
+				schedule_work(&ub->stop_work);
+
+				/* abort queue is for making forward progress */
+				ublk_abort_queue(ub, ubq);
+			}
 		}
 	}
 
@@ -1080,12 +1200,43 @@ static void ublk_cancel_dev(struct ublk_device *ub)
 		ublk_cancel_queue(ublk_get_queue(ub, i));
 }
 
+static void ublk_unquiesce_dev(struct ublk_device *ub)
+{
+	int i;
+
+	pr_devel("%s: ub state %s\n", __func__,
+			ub->dev_info.state == UBLK_S_DEV_LIVE ?
+			"LIVE" : "QUIESCED");
+	if (ub->dev_info.state == UBLK_S_DEV_LIVE) {
+		/*
+		 * quiesce_work cannot be running. We let monitor_work,
+		 * ublk_queue_rq() and task_work abort rqs instead of
+		 * requeuing them with a dying ubq_daemon. Then
+		 * del_gendisk() can move on.
+		 */
+		ublk_disable_recovery(ub);
+	} else {
+		/* quiesce_work has run. We let requeued rqs be aborted
+		 * before running fallback_wq. "force_abort" must be seen
+		 * after request queue is unqiuesced. Then del_gendisk()
+		 * can move on.
+		 */
+		for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+			ublk_get_queue(ub, i)->force_abort = true;
+
+		blk_mq_unquiesce_queue(ub->ub_disk->queue);
+		/* We may have requeued some rqs in ublk_quiesce_queue() */
+		blk_mq_kick_requeue_list(ub->ub_disk->queue);
+	}
+}
+
 static void ublk_stop_dev(struct ublk_device *ub)
 {
 	mutex_lock(&ub->mutex);
-	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
+	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
 		goto unlock;
-
+	if (ublk_can_use_recovery(ub))
+		ublk_unquiesce_dev(ub);
 	del_gendisk(ub->ub_disk);
 	ub->dev_info.state = UBLK_S_DEV_DEAD;
 	ub->dev_info.ublksrv_pid = -1;
@@ -1409,6 +1560,7 @@ static void ublk_remove(struct ublk_device *ub)
 {
 	ublk_stop_dev(ub);
 	cancel_work_sync(&ub->stop_work);
+	cancel_work_sync(&ub->quiesce_work);
 	cdev_device_del(&ub->cdev, &ub->cdev_dev);
 	put_device(&ub->cdev_dev);
 }
@@ -1585,6 +1737,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		goto out_unlock;
 	mutex_init(&ub->mutex);
 	spin_lock_init(&ub->mm_lock);
+	INIT_WORK(&ub->quiesce_work, ublk_quiesce_work_fn);
 	INIT_WORK(&ub->stop_work, ublk_stop_work_fn);
 	INIT_DELAYED_WORK(&ub->monitor_work, ublk_daemon_monitor_work);
 
@@ -1705,6 +1858,7 @@ static int ublk_ctrl_stop_dev(struct io_uring_cmd *cmd)
 
 	ublk_stop_dev(ub);
 	cancel_work_sync(&ub->stop_work);
+	cancel_work_sync(&ub->quiesce_work);
 
 	ublk_put_device(ub);
 	return 0;
-- 
2.27.0

