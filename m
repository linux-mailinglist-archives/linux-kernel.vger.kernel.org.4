Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA0972DCD4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241722AbjFMIlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241689AbjFMIkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:40:15 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7DFCA;
        Tue, 13 Jun 2023 01:40:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vl1XjjM_1686645610;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vl1XjjM_1686645610)
          by smtp.aliyun-inc.com;
          Tue, 13 Jun 2023 16:40:11 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com,
        xiang@kernel.org, casey@schaufler-ca.com
Subject: [PATCH v3 2/2] block: fine-granular CAP_SYS_ADMIN for Persistent Reservation
Date:   Tue, 13 Jun 2023 16:40:08 +0800
Message-Id: <20230613084008.93795-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230613084008.93795-1-jefflexu@linux.alibaba.com>
References: <20230613084008.93795-1-jefflexu@linux.alibaba.com>
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

Allow of unprivileged Persistent Reservation operations on devices
if the write permission check on the device node has passed.

brw-rw---- 1 root disk 259, 0 Jun 13 07:09 /dev/nvme0n1

In the example above, the "disk" group of nvme0n1 is also allowed to
make reservations on the device even without CAP_SYS_ADMIN.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 block/ioctl.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index c75299006bdd..3be11941fb2d 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -254,7 +254,7 @@ int blkdev_compat_ptr_ioctl(struct block_device *bdev, blk_mode_t mode,
 EXPORT_SYMBOL(blkdev_compat_ptr_ioctl);
 #endif
 
-static bool blkdev_pr_allowed(struct block_device *bdev)
+static bool blkdev_pr_allowed(struct block_device *bdev, blk_mode_t mode)
 {
 	/* no sense to make reservations for partitions */
 	if (bdev_is_partition(bdev))
@@ -262,17 +262,20 @@ static bool blkdev_pr_allowed(struct block_device *bdev)
 
 	if (capable(CAP_SYS_ADMIN))
 		return true;
-
-	return false;
+	/*
+	 * Only allow unprivileged reservations if the file descriptor is open
+	 * for writing.
+	 */
+	return mode & BLK_OPEN_WRITE;
 }
 
-static int blkdev_pr_register(struct block_device *bdev,
+static int blkdev_pr_register(struct block_device *bdev, blk_mode_t mode,
 		struct pr_registration __user *arg)
 {
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_registration reg;
 
-	if (!blkdev_pr_allowed(bdev))
+	if (!blkdev_pr_allowed(bdev, mode))
 		return -EPERM;
 	if (!ops || !ops->pr_register)
 		return -EOPNOTSUPP;
@@ -284,13 +287,13 @@ static int blkdev_pr_register(struct block_device *bdev,
 	return ops->pr_register(bdev, reg.old_key, reg.new_key, reg.flags);
 }
 
-static int blkdev_pr_reserve(struct block_device *bdev,
+static int blkdev_pr_reserve(struct block_device *bdev, blk_mode_t mode,
 		struct pr_reservation __user *arg)
 {
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_reservation rsv;
 
-	if (!blkdev_pr_allowed(bdev))
+	if (!blkdev_pr_allowed(bdev, mode))
 		return -EPERM;
 	if (!ops || !ops->pr_reserve)
 		return -EOPNOTSUPP;
@@ -302,13 +305,13 @@ static int blkdev_pr_reserve(struct block_device *bdev,
 	return ops->pr_reserve(bdev, rsv.key, rsv.type, rsv.flags);
 }
 
-static int blkdev_pr_release(struct block_device *bdev,
+static int blkdev_pr_release(struct block_device *bdev, blk_mode_t mode,
 		struct pr_reservation __user *arg)
 {
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_reservation rsv;
 
-	if (!blkdev_pr_allowed(bdev))
+	if (!blkdev_pr_allowed(bdev, mode))
 		return -EPERM;
 	if (!ops || !ops->pr_release)
 		return -EOPNOTSUPP;
@@ -320,13 +323,13 @@ static int blkdev_pr_release(struct block_device *bdev,
 	return ops->pr_release(bdev, rsv.key, rsv.type);
 }
 
-static int blkdev_pr_preempt(struct block_device *bdev,
+static int blkdev_pr_preempt(struct block_device *bdev, blk_mode_t mode,
 		struct pr_preempt __user *arg, bool abort)
 {
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_preempt p;
 
-	if (!blkdev_pr_allowed(bdev))
+	if (!blkdev_pr_allowed(bdev, mode))
 		return -EPERM;
 	if (!ops || !ops->pr_preempt)
 		return -EOPNOTSUPP;
@@ -338,13 +341,13 @@ static int blkdev_pr_preempt(struct block_device *bdev,
 	return ops->pr_preempt(bdev, p.old_key, p.new_key, p.type, abort);
 }
 
-static int blkdev_pr_clear(struct block_device *bdev,
+static int blkdev_pr_clear(struct block_device *bdev, blk_mode_t mode,
 		struct pr_clear __user *arg)
 {
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_clear c;
 
-	if (!blkdev_pr_allowed(bdev))
+	if (!blkdev_pr_allowed(bdev, mode))
 		return -EPERM;
 	if (!ops || !ops->pr_clear)
 		return -EOPNOTSUPP;
@@ -546,17 +549,17 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 	case BLKTRACETEARDOWN:
 		return blk_trace_ioctl(bdev, cmd, argp);
 	case IOC_PR_REGISTER:
-		return blkdev_pr_register(bdev, argp);
+		return blkdev_pr_register(bdev, mode, argp);
 	case IOC_PR_RESERVE:
-		return blkdev_pr_reserve(bdev, argp);
+		return blkdev_pr_reserve(bdev, mode, argp);
 	case IOC_PR_RELEASE:
-		return blkdev_pr_release(bdev, argp);
+		return blkdev_pr_release(bdev, mode, argp);
 	case IOC_PR_PREEMPT:
-		return blkdev_pr_preempt(bdev, argp, false);
+		return blkdev_pr_preempt(bdev, mode, argp, false);
 	case IOC_PR_PREEMPT_ABORT:
-		return blkdev_pr_preempt(bdev, argp, true);
+		return blkdev_pr_preempt(bdev, mode, argp, true);
 	case IOC_PR_CLEAR:
-		return blkdev_pr_clear(bdev, argp);
+		return blkdev_pr_clear(bdev, mode, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.19.1.6.gb485710b

