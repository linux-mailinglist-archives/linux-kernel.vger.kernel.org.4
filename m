Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE23772DCD6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241464AbjFMIlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239369AbjFMIkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:40:15 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB226BB;
        Tue, 13 Jun 2023 01:40:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vl1Wf-S_1686645609;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vl1Wf-S_1686645609)
          by smtp.aliyun-inc.com;
          Tue, 13 Jun 2023 16:40:10 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com,
        xiang@kernel.org, casey@schaufler-ca.com
Subject: [PATCH v3 1/2] block: disallow Persistent Reservation on partitions
Date:   Tue, 13 Jun 2023 16:40:07 +0800
Message-Id: <20230613084008.93795-2-jefflexu@linux.alibaba.com>
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

Refuse Persistent Reservation operations on partitions as reservation
on partitions doesn't make sense.

Besides, introduce blkdev_pr_allowed() helper, where more policies could
be placed here later.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 block/ioctl.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 61bb94fd4281..c75299006bdd 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -254,13 +254,25 @@ int blkdev_compat_ptr_ioctl(struct block_device *bdev, blk_mode_t mode,
 EXPORT_SYMBOL(blkdev_compat_ptr_ioctl);
 #endif
 
+static bool blkdev_pr_allowed(struct block_device *bdev)
+{
+	/* no sense to make reservations for partitions */
+	if (bdev_is_partition(bdev))
+		return false;
+
+	if (capable(CAP_SYS_ADMIN))
+		return true;
+
+	return false;
+}
+
 static int blkdev_pr_register(struct block_device *bdev,
 		struct pr_registration __user *arg)
 {
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_registration reg;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!blkdev_pr_allowed(bdev))
 		return -EPERM;
 	if (!ops || !ops->pr_register)
 		return -EOPNOTSUPP;
@@ -278,7 +290,7 @@ static int blkdev_pr_reserve(struct block_device *bdev,
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_reservation rsv;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!blkdev_pr_allowed(bdev))
 		return -EPERM;
 	if (!ops || !ops->pr_reserve)
 		return -EOPNOTSUPP;
@@ -296,7 +308,7 @@ static int blkdev_pr_release(struct block_device *bdev,
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_reservation rsv;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!blkdev_pr_allowed(bdev))
 		return -EPERM;
 	if (!ops || !ops->pr_release)
 		return -EOPNOTSUPP;
@@ -314,7 +326,7 @@ static int blkdev_pr_preempt(struct block_device *bdev,
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_preempt p;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!blkdev_pr_allowed(bdev))
 		return -EPERM;
 	if (!ops || !ops->pr_preempt)
 		return -EOPNOTSUPP;
@@ -332,7 +344,7 @@ static int blkdev_pr_clear(struct block_device *bdev,
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_clear c;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!blkdev_pr_allowed(bdev))
 		return -EPERM;
 	if (!ops || !ops->pr_clear)
 		return -EOPNOTSUPP;
-- 
2.19.1.6.gb485710b

