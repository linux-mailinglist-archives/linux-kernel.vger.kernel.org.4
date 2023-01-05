Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E5B65F5AE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbjAEVYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbjAEVYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:24:42 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD1E6319A;
        Thu,  5 Jan 2023 13:24:41 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so3381322pjj.4;
        Thu, 05 Jan 2023 13:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrXn/UsH93lS2A5CebmmFeBERFF7L0+KOIci0sQ1Uks=;
        b=TH3z2zdM6CYRaMvFVyXRvtLK7NTJD3DGsChzYPOzW0OE4ZDlFOsOzaP6/eB4Ul1i0S
         RvBDUXmn0foulgSyG8vos47nKdRPIfR1ZnRG9+QooLDJD4bl8UGdwD2Ekgoiq64Pj6Ct
         4g73y9tPKA7rpecPy84mOTVWDD66qkegYW7JiecBtg/BMFhtOseOae82jL/t556MGJ2f
         cqQuDHRAVVGGiSwrS54wu2eiQnpNHtlF5dvuGzJnlPp6fh07+vN8MTivXhRuStVsOX8q
         fksqIdmbke68jfL5DfePwyqOxw1Aee4pUqlp9fy6nBSDR0SbpZYaxXJRiu/eeaT8u9e9
         SB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TrXn/UsH93lS2A5CebmmFeBERFF7L0+KOIci0sQ1Uks=;
        b=I+/tTGlUU+EIQSyTTzNSVgBM/y7AXwxrk4b4CzIjw4VKKst5lcYABqd07RGGpvmK67
         ohfQg/rgTsQKbexbzjSZnKoYy28W1Q1zptV5x6CQVQi0Sawwb5gvcWyQbg+OR2KF4ZjK
         dwwZ64hhxkSRAJlPSVT3V3HbcBNosfHKR+Z5m7/06Q8PP2F4m5zlrv1KbMOL9LH8ebAS
         4SfyVHTHR9SzysnRLyuNoZGEerF0XXx0GaQARlgYsRg+78mQlUvfPuqCuviMwhtRTrzZ
         IxCTTdb7Q9ie4oFQstL1P+2fyZJeoVUxjCX+3HcV+eOGYJCqo4PT6XLzRl5ypxGAUXPP
         IOig==
X-Gm-Message-State: AFqh2kq7hHcKwZDjHFnoOsklK+cqHOVLSDCst0ZRFPYTqi0Uyy4EPWVl
        CPq7qa77GPBLAcofVc2RUZM=
X-Google-Smtp-Source: AMrXdXuyJ1YtBdHGDBrXpTjR4oFElnKEIBA94XIVucv+SZ35U5AmIuwdEI9LLOpzEQXjNNyrwP0wag==
X-Received: by 2002:a17:90a:f80e:b0:225:d290:dcb0 with SMTP id ij14-20020a17090af80e00b00225d290dcb0mr44797327pjb.4.1672953881187;
        Thu, 05 Jan 2023 13:24:41 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090a134100b002260b06befbsm1736859pjf.16.2023.01.05.13.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 13:24:40 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/4] blkcg: Drop unnecessary RCU read [un]locks from blkg_conf_prep/finish()
Date:   Thu,  5 Jan 2023 11:24:29 -1000
Message-Id: <20230105212432.289569-2-tj@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105212432.289569-1-tj@kernel.org>
References: <20230105212432.289569-1-tj@kernel.org>
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

Holding the queue lock now implies RCU read lock, so no need to use
rcu_read_[un]lock() explicitly. This shouldn't cause any behavior changes.

While at it, drop __acquires() annotation on the queue lock too. The
__acquires() part was already out of sync and it doesn't catch anything that
lockdep can't.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index ce6a2b7d3dfb..99674e23cf88 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -672,12 +672,11 @@ struct block_device *blkcg_conf_open_bdev(char **inputp)
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
 {
 	struct block_device *bdev;
 	struct gendisk *disk;
@@ -699,7 +698,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	if (ret)
 		goto fail;
 
-	rcu_read_lock();
 	spin_lock_irq(&q->queue_lock);
 
 	if (!blkcg_policy_enabled(q, pol)) {
@@ -728,7 +726,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 
 		/* Drop locks to do new blkg allocation with GFP_KERNEL. */
 		spin_unlock_irq(&q->queue_lock);
-		rcu_read_unlock();
 
 		new_blkg = blkg_alloc(pos, disk, GFP_KERNEL);
 		if (unlikely(!new_blkg)) {
@@ -742,7 +739,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			goto fail_exit_queue;
 		}
 
-		rcu_read_lock();
 		spin_lock_irq(&q->queue_lock);
 
 		if (!blkcg_policy_enabled(q, pol)) {
@@ -778,7 +774,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	radix_tree_preload_end();
 fail_unlock:
 	spin_unlock_irq(&q->queue_lock);
-	rcu_read_unlock();
 fail_exit_queue:
 	blk_queue_exit(q);
 fail:
@@ -805,10 +800,8 @@ EXPORT_SYMBOL_GPL(blkg_conf_prep);
  * with blkg_conf_prep().
  */
 void blkg_conf_finish(struct blkg_conf_ctx *ctx)
-	__releases(&ctx->bdev->bd_queue->queue_lock) __releases(rcu)
 {
 	spin_unlock_irq(&bdev_get_queue(ctx->bdev)->queue_lock);
-	rcu_read_unlock();
 	blkdev_put_no_open(ctx->bdev);
 }
 EXPORT_SYMBOL_GPL(blkg_conf_finish);
-- 
2.39.0

