Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C426E02FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 02:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjDMAHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 20:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDMAG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 20:06:58 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02847448F;
        Wed, 12 Apr 2023 17:06:58 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id kh6so11636557plb.0;
        Wed, 12 Apr 2023 17:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681344417; x=1683936417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+c1yUpkzswmzq/oMrJxXHf4ZggUo4IZgO2KUwSt5A/4=;
        b=VLtSIZymPOxj5fb0NSKxrUzsmKlOO0xUCBks6vYGJpb25czz5XiWa812SUs7RjyOZa
         BKFa1UXONpNf3P76SXq4ZK6owNzs3QosAXdpYc/m3XKy2GVCbCIezHzndHeU1lG2HEsp
         ebkviD/eIEndrW/8/N863hw5FYz7jBm4tn9lneqLIftYtMgyLk/t0Ge39rD/JGw0CvQa
         Bcs9/6F1btD+Kxpp0NuBlZiCjGa2PZF4l1vcPgAWA4f6ssqEH/ISC+i+RisrA6F50To4
         K+uK6SsOVSOOajB23lhnWkwDmDSvCVMK5n2lyEQuuDuv6iHCMKEatWXRpQlZYSWm5Nvk
         z+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681344417; x=1683936417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+c1yUpkzswmzq/oMrJxXHf4ZggUo4IZgO2KUwSt5A/4=;
        b=Zw6zy/tjN2JjknKEWIfrGIZboVpRAcFVO/qsVY7BsDpyue9HM6uaM2wDUX20VWtUw2
         zab/JWg5dEPU6YdmzW472DsR8DTqBCQgaaL5H6b+wa/6YQIu13my7Cw69UxXKDwGo4Ux
         y++7aGrsG6Ik7JKp7MKZoZqaNePqby5vxF2C37OIAGHmv6JOO8syxasS5JMhsFZrTyjY
         s6YofVz+B7HVNMzQrIiEiGGKIY9M7gJZE1U/iRAaZNWSbUX6wWwluwrQ9CL2VyvLgbMS
         051y5Ii3IJ/G8W/kC59Jv1mnerks5upPLuwkVVUO9Mg+j9pQwvFTUsNXQOJYxQwJsa0d
         BbeA==
X-Gm-Message-State: AAQBX9dnWN01tJrZeOYjn3dRGNYp44IPac8eba++DPWZ5vpoKcPG9dRZ
        Zo9UZVVoheZop/oZ4I01Zfc=
X-Google-Smtp-Source: AKy350YDLlg0qRTKX3Voc4vDlbECcwCD//NpNhmfQJwJ7widmWUrX0ZepcpGPCbp56HaPMmeXLqTFw==
X-Received: by 2002:a17:90a:e545:b0:240:5c46:e9b0 with SMTP id ei5-20020a17090ae54500b002405c46e9b0mr4963211pjb.2.1681344417156;
        Wed, 12 Apr 2023 17:06:57 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090a2f8d00b002349fcf17f8sm1979486pjd.15.2023.04.12.17.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 17:06:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/4] blkcg: Drop unnecessary RCU read [un]locks from blkg_conf_prep/finish()
Date:   Wed, 12 Apr 2023 14:06:46 -1000
Message-Id: <20230413000649.115785-2-tj@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230413000649.115785-1-tj@kernel.org>
References: <20230413000649.115785-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all RCU flavors have been combined either holding a spin lock,
disabling irq or disabling preemption implies RCU read lock, so there's no
need to use rcu_read_[un]lock() explicitly while holding queue_lock. This
shouldn't cause any behavior changes.

v2: Description updated. Leave __acquires/release on queue_lock alone.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 18331cb92914..0a2c19d74d95 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -699,12 +699,12 @@ struct block_device *blkcg_conf_open_bdev(char **inputp)
  *
  * Parse per-blkg config update from @input and initialize @ctx with the
  * result.  @ctx->blkg points to the blkg to be updated and @ctx->body the
- * part of @input following MAJ:MIN.  This function returns with RCU read
- * lock and queue lock held and must be paired with blkg_conf_finish().
+ * part of @input following MAJ:MIN.  This function returns with queue lock
+ * held and must be paired with blkg_conf_finish().
  */
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   char *input, struct blkg_conf_ctx *ctx)
-	__acquires(rcu) __acquires(&bdev->bd_queue->queue_lock)
+	__acquires(&bdev->bd_queue->queue_lock)
 {
 	struct block_device *bdev;
 	struct gendisk *disk;
@@ -726,7 +726,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	if (ret)
 		goto fail;
 
-	rcu_read_lock();
 	spin_lock_irq(&q->queue_lock);
 
 	if (!blkcg_policy_enabled(q, pol)) {
@@ -755,7 +754,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 
 		/* Drop locks to do new blkg allocation with GFP_KERNEL. */
 		spin_unlock_irq(&q->queue_lock);
-		rcu_read_unlock();
 
 		new_blkg = blkg_alloc(pos, disk, GFP_KERNEL);
 		if (unlikely(!new_blkg)) {
@@ -769,7 +767,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			goto fail_exit_queue;
 		}
 
-		rcu_read_lock();
 		spin_lock_irq(&q->queue_lock);
 
 		if (!blkcg_policy_enabled(q, pol)) {
@@ -805,7 +802,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	radix_tree_preload_end();
 fail_unlock:
 	spin_unlock_irq(&q->queue_lock);
-	rcu_read_unlock();
 fail_exit_queue:
 	blk_queue_exit(q);
 fail:
@@ -832,10 +828,9 @@ EXPORT_SYMBOL_GPL(blkg_conf_prep);
  * with blkg_conf_prep().
  */
 void blkg_conf_finish(struct blkg_conf_ctx *ctx)
-	__releases(&ctx->bdev->bd_queue->queue_lock) __releases(rcu)
+	__releases(&ctx->bdev->bd_queue->queue_lock)
 {
 	spin_unlock_irq(&bdev_get_queue(ctx->bdev)->queue_lock);
-	rcu_read_unlock();
 	blkdev_put_no_open(ctx->bdev);
 }
 EXPORT_SYMBOL_GPL(blkg_conf_finish);
-- 
2.40.0

