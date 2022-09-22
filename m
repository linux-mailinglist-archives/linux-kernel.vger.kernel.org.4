Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D755E5B39
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiIVGSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiIVGSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:18:13 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770BBB5176;
        Wed, 21 Sep 2022 23:18:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQRHxUi_1663827487;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQRHxUi_1663827487)
          by smtp.aliyun-inc.com;
          Thu, 22 Sep 2022 14:18:09 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V5 5/7] ublk_drv: support UBLK_F_USER_RECOVERY_REISSUE
Date:   Thu, 22 Sep 2022 14:17:32 +0800
Message-Id: <20220922061734.21625-6-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220922061734.21625-1-ZiyangZhang@linux.alibaba.com>
References: <20220922061734.21625-1-ZiyangZhang@linux.alibaba.com>
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

UBLK_F_USER_RECOVERY_REISSUE implies that:
With a dying ubq_daemon, ublk_drv let monitor_work requeues rq issued to
userspace(ublksrv) before the ubq_daemon is dying.

UBLK_F_USER_RECOVERY_REISSUE is designed for backends which:
(1) tolerate double-write since ublk_drv may issue the same rq
    twice.
(2) does not let frontend users get I/O error, such as read-only FS
    and VM backend.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 22 ++++++++++++++++++----
 include/uapi/linux/ublk_cmd.h |  2 ++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 888ad16c5dd8..3977869d2bc4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -50,7 +50,8 @@
 #define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY \
 		| UBLK_F_URING_CMD_COMP_IN_TASK \
 		| UBLK_F_NEED_GET_DATA \
-		| UBLK_F_USER_RECOVERY)
+		| UBLK_F_USER_RECOVERY \
+		| UBLK_F_USER_RECOVERY_REISSUE)
 
 /* All UBLK_PARAM_TYPE_* should be included here */
 #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
@@ -325,6 +326,15 @@ static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub, int q_id)
 			PAGE_SIZE);
 }
 
+static inline bool ublk_queue_can_use_recovery_reissue(
+		struct ublk_queue *ubq)
+{
+	if ((ubq->flags & UBLK_F_USER_RECOVERY) &&
+			(ubq->flags & UBLK_F_USER_RECOVERY_REISSUE))
+		return true;
+	return false;
+}
+
 static inline bool ublk_queue_can_use_recovery(
 		struct ublk_queue *ubq)
 {
@@ -629,13 +639,17 @@ static void ublk_complete_rq(struct request *req)
  * Also aborting may not be started yet, keep in mind that one failed
  * request may be issued by block layer again.
  */
-static void __ublk_fail_req(struct ublk_io *io, struct request *req)
+static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
+		struct request *req)
 {
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
 
 	if (!(io->flags & UBLK_IO_FLAG_ABORTED)) {
 		io->flags |= UBLK_IO_FLAG_ABORTED;
-		blk_mq_end_request(req, BLK_STS_IOERR);
+		if (ublk_queue_can_use_recovery_reissue(ubq))
+			blk_mq_requeue_request(req, false);
+		else
+			blk_mq_end_request(req, BLK_STS_IOERR);
 	}
 }
 
@@ -973,7 +987,7 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 			 */
 			rq = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], i);
 			if (rq)
-				__ublk_fail_req(io, rq);
+				__ublk_fail_req(ubq, io, rq);
 		}
 	}
 	ublk_put_device(ub);
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 340ff14bde49..332370628757 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -76,6 +76,8 @@
 
 #define UBLK_F_USER_RECOVERY	(1UL << 3)
 
+#define UBLK_F_USER_RECOVERY_REISSUE	(1UL << 4)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
-- 
2.27.0

