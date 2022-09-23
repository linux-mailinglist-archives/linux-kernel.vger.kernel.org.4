Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FFF5E7E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiIWPkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiIWPkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:40:08 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D053678E;
        Fri, 23 Sep 2022 08:40:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQXQbpI_1663947596;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQXQbpI_1663947596)
          by smtp.aliyun-inc.com;
          Fri, 23 Sep 2022 23:40:01 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V6 4/7] ublk_drv: consider recovery feature in aborting mechanism
Date:   Fri, 23 Sep 2022 23:39:16 +0800
Message-Id: <20220923153919.44078-5-ZiyangZhang@linux.alibaba.com>
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

With USER_RECOVERY feature enabled, the monitor_work schedules
quiesce_work after finding a dying ubq_daemon. The monitor_work
should also abort all rqs issued to userspace before the ubq_daemon is
dying. The quiesce_work's job is to:
(1) quiesce request queue.
(2) check if there is any INFLIGHT rq. If so, we retry until all these
    rqs are requeued and become IDLE. These rqs should be requeued by
	ublk_queue_rq(), task work, io_uring fallback wq or monitor_work.
(3) complete all ioucmds by calling io_uring_cmd_done(). We are safe to
    do so because no ioucmd can be referenced now.
(5) set ub's state to UBLK_S_DEV_QUIESCED, which means we are ready for
    recovery. This state is exposed to userspace by GET_DEV_INFO.

The driver can always handle STOP_DEV and cleanup everything no matter
ub's state is LIVE or QUIESCED. After ub's state is UBLK_S_DEV_QUIESCED,
user can recover with new process.

Note: we do not change the default behavior with reocvery feature
disabled. monitor_work still schedules stop_work and abort inflight
rqs. And finally ublk_device is released.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 116 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 110 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9ce5617d21df..3cdcc9bd635f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -120,7 +120,7 @@ struct ublk_queue {
 
 	unsigned long io_addr;	/* mapped vm address */
 	unsigned int max_io_sz;
-	bool abort_work_pending;
+	bool force_abort;
 	unsigned short nr_io_ready;	/* how many ios setup */
 	struct ublk_device *dev;
 	struct ublk_io ios[0];
@@ -162,6 +162,7 @@ struct ublk_device {
 	 * monitor each queue's daemon periodically
 	 */
 	struct delayed_work	monitor_work;
+	struct work_struct	quiesce_work;
 	struct work_struct	stop_work;
 };
 
@@ -773,6 +774,17 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	res = ublk_setup_iod(ubq, rq);
 	if (unlikely(res != BLK_STS_OK))
 		return BLK_STS_IOERR;
+	/* With recovery feature enabled, force_abort is set in
+	 * ublk_stop_dev() before calling del_gendisk(). We have to
+	 * abort all requeued and new rqs here to let del_gendisk()
+	 * move on. Besides, we cannot not call io_uring_cmd_complete_in_task()
+	 * to avoid UAF on io_uring ctx.
+	 *
+	 * Note: force_abort is guaranteed to be seen because it is set
+	 * before request queue is unqiuesced.
+	 */
+	if (ublk_queue_can_use_recovery(ubq) && unlikely(ubq->force_abort))
+		return BLK_STS_IOERR;
 
 	blk_mq_start_request(bd->rq);
 
@@ -966,7 +978,10 @@ static void ublk_daemon_monitor_work(struct work_struct *work)
 		struct ublk_queue *ubq = ublk_get_queue(ub, i);
 
 		if (ubq_daemon_is_dying(ubq)) {
-			schedule_work(&ub->stop_work);
+			if (ublk_queue_can_use_recovery(ubq))
+				schedule_work(&ub->quiesce_work);
+			else
+				schedule_work(&ub->stop_work);
 
 			/* abort queue is for making forward progress */
 			ublk_abort_queue(ub, ubq);
@@ -974,12 +989,13 @@ static void ublk_daemon_monitor_work(struct work_struct *work)
 	}
 
 	/*
-	 * We can't schedule monitor work after ublk_remove() is started.
+	 * We can't schedule monitor work after ub's state is not UBLK_S_DEV_LIVE.
+	 * after ublk_remove() or __ublk_quiesce_dev() is started.
 	 *
 	 * No need ub->mutex, monitor work are canceled after state is marked
-	 * as DEAD, so DEAD state is observed reliably.
+	 * as not LIVE, so new state is observed reliably.
 	 */
-	if (ub->dev_info.state != UBLK_S_DEV_DEAD)
+	if (ub->dev_info.state == UBLK_S_DEV_LIVE)
 		schedule_delayed_work(&ub->monitor_work,
 				UBLK_DAEMON_MONITOR_PERIOD);
 }
@@ -1016,12 +1032,97 @@ static void ublk_cancel_dev(struct ublk_device *ub)
 		ublk_cancel_queue(ublk_get_queue(ub, i));
 }
 
-static void ublk_stop_dev(struct ublk_device *ub)
+static bool ublk_check_inflight_rq(struct request *rq, void *data)
+{
+	bool *idle = data;
+
+	if (blk_mq_request_started(rq)) {
+		*idle = false;
+		return false;
+	}
+	return true;
+}
+
+static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
+{
+	bool idle;
+
+	WARN_ON_ONCE(!blk_queue_quiesced(ub->ub_disk->queue));
+	while (true) {
+		idle = true;
+		blk_mq_tagset_busy_iter(&ub->tag_set,
+				ublk_check_inflight_rq, &idle);
+		if (idle)
+			break;
+		msleep(UBLK_REQUEUE_DELAY_MS);
+	}
+}
+
+static void __ublk_quiesce_dev(struct ublk_device *ub)
 {
+	pr_devel("%s: quiesce ub: dev_id %d state %s\n",
+			__func__, ub->dev_info.dev_id,
+			ub->dev_info.state == UBLK_S_DEV_LIVE ?
+			"LIVE" : "QUIESCED");
+	blk_mq_quiesce_queue(ub->ub_disk->queue);
+	ublk_wait_tagset_rqs_idle(ub);
+	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
+	ublk_cancel_dev(ub);
+	/* we are going to release task_struct of ubq_daemon and resets
+	 * ->ubq_daemon to NULL. So in monitor_work, check on ubq_daemon causes UAF.
+	 * Besides, monitor_work is not necessary in QUIESCED state since we have
+	 * already scheduled quiesce_work and quiesced all ubqs.
+	 *
+	 * Do not let monitor_work schedule itself if state it QUIESCED. And we cancel
+	 * it here and re-schedule it in END_USER_RECOVERY to avoid UAF.
+	 */
+	cancel_delayed_work_sync(&ub->monitor_work);
+}
+
+static void ublk_quiesce_work_fn(struct work_struct *work)
+{
+	struct ublk_device *ub =
+		container_of(work, struct ublk_device, quiesce_work);
+
 	mutex_lock(&ub->mutex);
 	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
 		goto unlock;
+	__ublk_quiesce_dev(ub);
+ unlock:
+	mutex_unlock(&ub->mutex);
+}
 
+static void ublk_unquiesce_dev(struct ublk_device *ub)
+{
+	int i;
+
+	pr_devel("%s: unquiesce ub: dev_id %d state %s\n",
+			__func__, ub->dev_info.dev_id,
+			ub->dev_info.state == UBLK_S_DEV_LIVE ?
+			"LIVE" : "QUIESCED");
+	/* quiesce_work has run. We let requeued rqs be aborted
+	 * before running fallback_wq. "force_abort" must be seen
+	 * after request queue is unqiuesced. Then del_gendisk()
+	 * can move on.
+	 */
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+		ublk_get_queue(ub, i)->force_abort = true;
+
+	blk_mq_unquiesce_queue(ub->ub_disk->queue);
+	/* We may have requeued some rqs in ublk_quiesce_queue() */
+	blk_mq_kick_requeue_list(ub->ub_disk->queue);
+}
+
+static void ublk_stop_dev(struct ublk_device *ub)
+{
+	mutex_lock(&ub->mutex);
+	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
+		goto unlock;
+	if (ublk_can_use_recovery(ub)) {
+		if (ub->dev_info.state == UBLK_S_DEV_LIVE)
+			__ublk_quiesce_dev(ub);
+		ublk_unquiesce_dev(ub);
+	}
 	del_gendisk(ub->ub_disk);
 	ub->dev_info.state = UBLK_S_DEV_DEAD;
 	ub->dev_info.ublksrv_pid = -1;
@@ -1345,6 +1446,7 @@ static void ublk_remove(struct ublk_device *ub)
 {
 	ublk_stop_dev(ub);
 	cancel_work_sync(&ub->stop_work);
+	cancel_work_sync(&ub->quiesce_work);
 	cdev_device_del(&ub->cdev, &ub->cdev_dev);
 	put_device(&ub->cdev_dev);
 }
@@ -1521,6 +1623,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		goto out_unlock;
 	mutex_init(&ub->mutex);
 	spin_lock_init(&ub->mm_lock);
+	INIT_WORK(&ub->quiesce_work, ublk_quiesce_work_fn);
 	INIT_WORK(&ub->stop_work, ublk_stop_work_fn);
 	INIT_DELAYED_WORK(&ub->monitor_work, ublk_daemon_monitor_work);
 
@@ -1641,6 +1744,7 @@ static int ublk_ctrl_stop_dev(struct io_uring_cmd *cmd)
 
 	ublk_stop_dev(ub);
 	cancel_work_sync(&ub->stop_work);
+	cancel_work_sync(&ub->quiesce_work);
 
 	ublk_put_device(ub);
 	return 0;
-- 
2.27.0

