Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE225BFBEB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiIUKBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiIUKBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:01:15 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAA7923F0;
        Wed, 21 Sep 2022 03:00:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQNuDmx_1663754450;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQNuDmx_1663754450)
          by smtp.aliyun-inc.com;
          Wed, 21 Sep 2022 18:00:56 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V4 7/8] ublk_drv: allow new process to open ublk chardev with recovery feature enabled
Date:   Wed, 21 Sep 2022 17:58:48 +0800
Message-Id: <20220921095849.84988-8-ZiyangZhang@linux.alibaba.com>
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

With recovery feature enabled, if ublk chardev is ready to be released
and quiesce_work has been scheduled, we:
(1) cancel monitor_work to avoid UAF on ubq && ublk_io.
(2) reinit all ubqs, including:
    (a) put the task_struct and reset ->ubq_daemon to NULL.
    (b) reset all ublk_io.
(3) reset ub->mm to NULL.
Then ublk chardev is released and new process can open it.

RESTART_DEV is introduced as a new ctrl-cmd for recovery feature.
After the chardev is opened and all ubqs are ready, user should send
RESTART_DEV to:
(1) wait until all new ubq_daemons getting ready.
(2) update ublksrv_pid
(3) unquiesce the request queue and expect incoming ublk_queue_rq()
(4) convert ub's state to UBLK_S_DEV_LIVE
(5) reschedule monitor_work

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c      | 109 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h |   1 +
 2 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index dc33ebc20c01..871cd48503a2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -912,10 +912,67 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
+{
+	int i;
+
+	WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
+	pr_devel("%s: prepare for recovering qid %d\n", __func__, ubq->q_id);
+	/* old daemon is PF_EXITING, put it now */
+	put_task_struct(ubq->ubq_daemon);
+	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
+	ubq->ubq_daemon = NULL;
+
+	for (i = 0; i < ubq->q_depth; i++) {
+		struct ublk_io *io = &ubq->ios[i];
+
+		/* forget everything now and be ready for new FETCH_REQ */
+		io->flags = 0;
+		io->cmd = NULL;
+		io->addr = 0;
+	}
+	ubq->nr_io_ready = 0;
+}
+
 static int ublk_ch_release(struct inode *inode, struct file *filp)
 {
 	struct ublk_device *ub = filp->private_data;
+	int i;
+
+	/* lockless fast path */
+	if (!unlikely(ublk_can_use_recovery(ub) && ub->dev_info.state == UBLK_S_DEV_QUIESCED))
+		goto out_clear;
+
+	mutex_lock(&ub->mutex);
+	/*
+	 * USER_RECOVERY is only allowd after UBLK_S_DEV_QUIESCED is set,
+	 * which means that:
+	 *     (a) request queue has been quiesced
+	 *     (b) no inflight rq exists
+	 *     (c) all ioucmds owned by ther dying process are completed
+	 */
+	if (!(ublk_can_use_recovery(ub) && ub->dev_info.state == UBLK_S_DEV_QUIESCED))
+		goto out_unlock;
+	pr_devel("%s: reinit queues for dev id %d.\n", __func__, ub->dev_info.dev_id);
+	/* we are going to release task_struct of ubq_daemon and resets
+	 * ->ubq_daemon to NULL. So in monitor_work, check on ubq_daemon causes UAF.
+	 * Besides, monitor_work is not necessary in QUIESCED state since we have
+	 * already scheduled quiesce_work and quiesced all ubqs.
+	 *
+	 * Do not let monitor_work schedule itself if state it QUIESCED. And we cancel
+	 * it here and re-schedule it in RESTART_DEV to avoid UAF.
+	 */
+	cancel_delayed_work_sync(&ub->monitor_work);
 
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
+	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
+	ub->mm = NULL;
+	ub->nr_queues_ready = 0;
+	init_completion(&ub->completion);
+ out_unlock:
+	mutex_unlock(&ub->mutex);
+ out_clear:
 	clear_bit(UB_STATE_OPEN, &ub->state);
 	return 0;
 }
@@ -1199,9 +1256,14 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 		ubq->ubq_daemon = current;
 		get_task_struct(ubq->ubq_daemon);
 		ub->nr_queues_ready++;
+		pr_devel("%s: ub %d qid %d is ready.\n",
+				__func__, ub->dev_info.dev_id, ubq->q_id);
 	}
-	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
+	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues) {
+		pr_devel("%s: ub %d all ubqs are ready.\n",
+				__func__, ub->dev_info.dev_id);
 		complete_all(&ub->completion);
+	}
 	mutex_unlock(&ub->mutex);
 }
 
@@ -1903,6 +1965,48 @@ static int ublk_ctrl_set_params(struct io_uring_cmd *cmd)
 	return ret;
 }
 
+static int ublk_ctrl_restart_dev(struct io_uring_cmd *cmd)
+{
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	int ublksrv_pid = (int)header->data[0];
+	struct ublk_device *ub;
+	int ret = -EINVAL;
+
+	ub = ublk_get_device_from_id(header->dev_id);
+	if (!ub)
+		return ret;
+
+	pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev id %d...\n",
+			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
+	/* wait until new ubq_daemon sending all FETCH_REQ */
+	wait_for_completion_interruptible(&ub->completion);
+	pr_devel("%s: All new ubq_daemons(nr: %d) are ready, dev id %d\n",
+			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
+
+	mutex_lock(&ub->mutex);
+	if (!ublk_can_use_recovery(ub))
+		goto out_unlock;
+
+	if (ub->dev_info.state != UBLK_S_DEV_QUIESCED) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	ub->dev_info.ublksrv_pid = ublksrv_pid;
+	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",
+			__func__, ublksrv_pid, header->dev_id);
+	blk_mq_unquiesce_queue(ub->ub_disk->queue);
+	pr_devel("%s: queue unquiesced, dev id %d.\n",
+			__func__, header->dev_id);
+	blk_mq_kick_requeue_list(ub->ub_disk->queue);
+	ub->dev_info.state = UBLK_S_DEV_LIVE;
+	schedule_delayed_work(&ub->monitor_work, UBLK_DAEMON_MONITOR_PERIOD);
+	ret = 0;
+ out_unlock:
+	mutex_unlock(&ub->mutex);
+	ublk_put_device(ub);
+	return ret;
+}
+
 static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
@@ -1944,6 +2048,9 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	case UBLK_CMD_SET_PARAMS:
 		ret = ublk_ctrl_set_params(cmd);
 		break;
+	case UBLK_CMD_RESTART_DEV:
+		ret = ublk_ctrl_restart_dev(cmd);
+		break;
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 332370628757..a088f374c0f6 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -17,6 +17,7 @@
 #define	UBLK_CMD_STOP_DEV	0x07
 #define	UBLK_CMD_SET_PARAMS	0x08
 #define	UBLK_CMD_GET_PARAMS	0x09
+#define UBLK_CMD_RESTART_DEV	0x10
 
 /*
  * IO commands, issued by ublk server, and handled by ublk driver.
-- 
2.27.0

