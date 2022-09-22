Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551FA5E5B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiIVGSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiIVGSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:18:17 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FC2B56CC;
        Wed, 21 Sep 2022 23:18:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQRHxVq_1663827489;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQRHxVq_1663827489)
          by smtp.aliyun-inc.com;
          Thu, 22 Sep 2022 14:18:11 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V5 6/7] ublk_drv: allow new process to open ublk chardev with recovery feature enabled
Date:   Thu, 22 Sep 2022 14:17:33 +0800
Message-Id: <20220922061734.21625-7-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220922061734.21625-1-ZiyangZhang@linux.alibaba.com>
References: <20220922061734.21625-1-ZiyangZhang@linux.alibaba.com>
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

With recovery feature enabled, if ublk chardev is ready to be released
and quiesce_work has been scheduled, we:
(1) reinit all ubqs, including:
    (a) put the task_struct and reset ->ubq_daemon to NULL.
    (b) reset all ublk_io.
(2) reset ub->mm to NULL.
Then ublk chardev is released and new process can open it.

RECOVER_DEV is introduced as a new ctrl-cmd for recovery feature.
After the chardev is opened and all ubqs are ready, user should send
RECOVER_DEV to:
(1) wait until all new ubq_daemons getting ready.
(2) update ublksrv_pid
(3) unquiesce the request queue and expect incoming ublk_queue_rq()
(4) convert ub's state to UBLK_S_DEV_LIVE
(5) reschedule monitor_work

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c      | 67 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/ublk_cmd.h |  1 +
 2 files changed, 68 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3977869d2bc4..ac8bf497567f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -898,10 +898,40 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
+{
+	int i;
+
+	/* old daemon is PF_EXITING, put it now */
+	if (ubq->ubq_daemon) {
+		put_task_struct(ubq->ubq_daemon);
+		/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
+		ubq->ubq_daemon = NULL;
+	}
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
 
+	pr_devel("%s: reinit queues for dev id %d.\n", __func__, ub->dev_info.dev_id);
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
+	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
+	ub->mm = NULL;
+	ub->nr_queues_ready = 0;
+	init_completion(&ub->completion);
 	clear_bit(UB_STATE_OPEN, &ub->state);
 	return 0;
 }
@@ -1873,6 +1903,40 @@ static int ublk_ctrl_set_params(struct io_uring_cmd *cmd)
 	return ret;
 }
 
+static int ublk_ctrl_recover_dev(struct io_uring_cmd *cmd)
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
+	/* wait until new ubq_daemon sending all FETCH_REQ */
+	wait_for_completion_interruptible(&ub->completion);
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
+	blk_mq_unquiesce_queue(ub->ub_disk->queue);
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
@@ -1914,6 +1978,9 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	case UBLK_CMD_SET_PARAMS:
 		ret = ublk_ctrl_set_params(cmd);
 		break;
+	case UBLK_CMD_RECOVER_DEV:
+		ret = ublk_ctrl_recover_dev(cmd);
+		break;
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 332370628757..deb674f1fbc9 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -17,6 +17,7 @@
 #define	UBLK_CMD_STOP_DEV	0x07
 #define	UBLK_CMD_SET_PARAMS	0x08
 #define	UBLK_CMD_GET_PARAMS	0x09
+#define UBLK_CMD_RECOVER_DEV	0x10
 
 /*
  * IO commands, issued by ublk server, and handled by ublk driver.
-- 
2.27.0

