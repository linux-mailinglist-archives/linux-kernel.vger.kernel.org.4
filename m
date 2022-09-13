Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55735B666C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 06:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiIMETJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 00:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiIMESz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:18:55 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A691F4D150;
        Mon, 12 Sep 2022 21:18:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VPccyFG_1663042729;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VPccyFG_1663042729)
          by smtp.aliyun-inc.com;
          Tue, 13 Sep 2022 12:18:50 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V3 3/7] ublk_drv: define macros for recovery feature and check them
Date:   Tue, 13 Sep 2022 12:17:03 +0800
Message-Id: <20220913041707.197334-4-ZiyangZhang@linux.alibaba.com>
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

Define some macros for recovery feature. Especially define a new state:
UBLK_S_DEV_QUIESCED which implies that ublk_device is quiesced
and is ready for recovery. This state can be observed by userspace.

UBLK_F_USER_RECOVERY implies that:
(1) ublk_drv enables recovery feature. It won't let monitor_work to
    automatically abort rqs and release the device.
(2) With a dying ubq_daemon, ublk_drv ends(aborts) rqs issued to
    userspace(ublksrv) before crash.
(3) With a dying ubq_daemon, in task work and ublk_queue_rq(),
    ublk_drv requeues rqs.

UBLK_F_USER_RECOVERY_REISSUE implies that:
(1) everything UBLK_F_USER_RECOVERY implies except
(2) With a dying ubq_daemon, ublk_drv requeues rqs issued to
    userspace(ublksrv) before crash.

UBLK_F_USER_RECOVERY_REISSUE is designed for backends which:
(1) tolerates double-writes because ublk_drv may issue the same rq
    twice.
(2) does not let frontend users get I/O error. such as read-only FS
    and VM backend.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c      | 45 ++++++++++++++++++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h |  7 ++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0c6db0978ed0..23337bd7c105 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -49,7 +49,9 @@
 /* All UBLK_F_* have to be included into UBLK_F_ALL */
 #define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY \
 		| UBLK_F_URING_CMD_COMP_IN_TASK \
-		| UBLK_F_NEED_GET_DATA)
+		| UBLK_F_NEED_GET_DATA \
+		| UBLK_F_USER_RECOVERY \
+		| UBLK_F_USER_RECOVERY_REISSUE)
 
 /* All UBLK_PARAM_TYPE_* should be included here */
 #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
@@ -323,6 +325,47 @@ static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub, int q_id)
 			PAGE_SIZE);
 }
 
+static inline bool ublk_queue_can_use_recovery(
+		struct ublk_queue *ubq)
+{
+	if (ubq->flags & UBLK_F_USER_RECOVERY)
+		return true;
+	return false;
+}
+
+static inline void ublk_disable_recovery(struct ublk_device *ub)
+{
+	int i;
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		ubq->flags &= ~UBLK_F_USER_RECOVERY;
+	}
+}
+
+static inline bool ublk_can_use_recovery(struct ublk_device *ub)
+{
+	int i;
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		if (!ublk_queue_can_use_recovery(ubq))
+			return false;
+	}
+	return true;
+}
+
+static inline bool ublk_queue_can_use_recovery_reissue(
+		struct ublk_queue *ubq)
+{
+	if (ublk_queue_can_use_recovery(ubq) &&
+			(ubq->flags & UBLK_F_USER_RECOVERY_REISSUE))
+		return true;
+	return false;
+}
+
 static void ublk_free_disk(struct gendisk *disk)
 {
 	struct ublk_device *ub = disk->private_data;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 677edaab2b66..87204c39f1ee 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -17,6 +17,8 @@
 #define	UBLK_CMD_STOP_DEV	0x07
 #define	UBLK_CMD_SET_PARAMS	0x08
 #define	UBLK_CMD_GET_PARAMS	0x09
+#define	UBLK_CMD_START_USER_RECOVERY	0x10
+#define UBLK_CMD_END_USER_RECOVERY	0x11
 
 /*
  * IO commands, issued by ublk server, and handled by ublk driver.
@@ -74,9 +76,14 @@
  */
 #define UBLK_F_NEED_GET_DATA (1UL << 2)
 
+#define UBLK_F_USER_RECOVERY	(1UL << 3)
+
+#define UBLK_F_USER_RECOVERY_REISSUE	(1UL << 4)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
+#define UBLK_S_DEV_QUIESCED	2
 
 /* shipped via sqe->cmd of io_uring command */
 struct ublksrv_ctrl_cmd {
-- 
2.27.0

