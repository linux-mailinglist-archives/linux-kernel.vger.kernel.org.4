Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452296FEC55
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbjEKHGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237200AbjEKHGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:06:09 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAFA6E87;
        Thu, 11 May 2023 00:05:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0ViJb7g-_1683788728;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0ViJb7g-_1683788728)
          by smtp.aliyun-inc.com;
          Thu, 11 May 2023 15:05:29 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Frederick Lawler <fred@cloudflare.com>,
        Jens Axboe <axboe@kernel.dk>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH 2/2] block: use block_admin_capable() for Persistent Reservations
Date:   Thu, 11 May 2023 15:05:20 +0800
Message-Id: <20230511070520.72939-3-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230511070520.72939-1-tianjia.zhang@linux.alibaba.com>
References: <20230511070520.72939-1-tianjia.zhang@linux.alibaba.com>
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

Use the newly introduced capability CAP_BLOCK_ADMIN for Persistent
Reservations.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 block/ioctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 9c5f637ff153..83af050eaa42 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -260,7 +260,7 @@ static int blkdev_pr_register(struct block_device *bdev,
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_registration reg;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!block_admin_capable())
 		return -EPERM;
 	if (!ops || !ops->pr_register)
 		return -EOPNOTSUPP;
@@ -278,7 +278,7 @@ static int blkdev_pr_reserve(struct block_device *bdev,
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_reservation rsv;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!block_admin_capable())
 		return -EPERM;
 	if (!ops || !ops->pr_reserve)
 		return -EOPNOTSUPP;
@@ -296,7 +296,7 @@ static int blkdev_pr_release(struct block_device *bdev,
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_reservation rsv;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!block_admin_capable())
 		return -EPERM;
 	if (!ops || !ops->pr_release)
 		return -EOPNOTSUPP;
@@ -314,7 +314,7 @@ static int blkdev_pr_preempt(struct block_device *bdev,
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_preempt p;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!block_admin_capable())
 		return -EPERM;
 	if (!ops || !ops->pr_preempt)
 		return -EOPNOTSUPP;
@@ -332,7 +332,7 @@ static int blkdev_pr_clear(struct block_device *bdev,
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_clear c;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!block_admin_capable())
 		return -EPERM;
 	if (!ops || !ops->pr_clear)
 		return -EOPNOTSUPP;
-- 
2.24.3 (Apple Git-128)

