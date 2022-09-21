Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427995BFBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiIUKAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiIUKAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:00:06 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344C07CA80;
        Wed, 21 Sep 2022 03:00:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQNuDHH_1663754385;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQNuDHH_1663754385)
          by smtp.aliyun-inc.com;
          Wed, 21 Sep 2022 17:59:59 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V4 3/8] ublk_drv: define macros for recovery feature and check them
Date:   Wed, 21 Sep 2022 17:58:44 +0800
Message-Id: <20220921095849.84988-4-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220921095849.84988-1-ZiyangZhang@linux.alibaba.com>
References: <20220921095849.84988-1-ZiyangZhang@linux.alibaba.com>
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

Define some macros for recovery feature.

UBLK_S_DEV_QUIESCED implies that ublk_device is quiesced
and is ready for recovery. This state can be observed by userspace.

UBLK_F_USER_RECOVERY implies that:
(1) ublk_drv enables recovery feature. It won't let monitor_work to
    automatically abort rqs and release the device.
(2) With a dying ubq_daemon, ublk_drv ends(aborts) rqs issued to
    userspace(ublksrv) before crash.
(3) With a dying ubq_daemon, in task work and ublk_queue_rq(),
    ublk_drv requeues rqs.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c      | 18 +++++++++++++++++-
 include/uapi/linux/ublk_cmd.h |  3 +++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0c6db0978ed0..3bdac4bdf46f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -49,7 +49,8 @@
 /* All UBLK_F_* have to be included into UBLK_F_ALL */
 #define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY \
 		| UBLK_F_URING_CMD_COMP_IN_TASK \
-		| UBLK_F_NEED_GET_DATA)
+		| UBLK_F_NEED_GET_DATA \
+		| UBLK_F_USER_RECOVERY)
 
 /* All UBLK_PARAM_TYPE_* should be included here */
 #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
@@ -323,6 +324,21 @@ static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub, int q_id)
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
+static inline bool ublk_can_use_recovery(struct ublk_device *ub)
+{
+	if (ub->dev_info.flags & UBLK_F_USER_RECOVERY)
+		return true;
+	return false;
+}
+
 static void ublk_free_disk(struct gendisk *disk)
 {
 	struct ublk_device *ub = disk->private_data;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 677edaab2b66..340ff14bde49 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -74,9 +74,12 @@
  */
 #define UBLK_F_NEED_GET_DATA (1UL << 2)
 
+#define UBLK_F_USER_RECOVERY	(1UL << 3)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
+#define UBLK_S_DEV_QUIESCED	2
 
 /* shipped via sqe->cmd of io_uring command */
 struct ublksrv_ctrl_cmd {
-- 
2.27.0

