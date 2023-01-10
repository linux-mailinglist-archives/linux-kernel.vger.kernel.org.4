Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDEE664EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjAJW12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbjAJW1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:27:25 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013861001;
        Tue, 10 Jan 2023 14:27:24 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id s3so7474687pfd.12;
        Tue, 10 Jan 2023 14:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V71fAY4MFk3dJ0CASh+6M8Ag40kWVpFvHImvXgxVZzg=;
        b=Ucj4vMeUNfuTtkkX87ovhBXhpOPRwDUQWOgfIaOY/xOiPMEJ+KwmJiIpKuHd2e5zFq
         kLyjxE737kxjzxCoocDbVscbOL0p66kBMWGnOIRwcqwZugqO2hHtBuqyIcuqWXEGERxp
         mwHVa7JFN1QRNDtG22EU+qFIXbeLyTIv8j36HkMQCso3g1ejuFUvgPa3iG5nheoIhAoq
         fanXotRVjjmBhQDiZKJ3Wec+/vke6TFtFWhv39ulpzepxGWbwvcvnT932FZu/gJnnGAN
         1ll6LrAU2HQSeP+5uQT7GSIcoQoXMtKn9yqpgoi8IeFwx7vj/VQYT9L+8KYK1y7Svv3s
         CmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V71fAY4MFk3dJ0CASh+6M8Ag40kWVpFvHImvXgxVZzg=;
        b=odPeVRj5suaz6QZeMr6MIuqlOijS/9s7jQ5nZ7N4M3sK5RexLCFr4BN7dXXQN9mXpp
         Hi1ADQM0RYiaa27BApD8ryNuc8nLoLYgbZ+4Ss41IAHcLc1V77PGpLb/IZct94+s5Gnj
         dexW0TMkqfk42QI9V5iK5RmjgS1p8L2tKI7k1A8rvh2c7dDBy5yEJE532IQooYNMVx1a
         +CjTij39wNHARlZUj1r/wUAR/9Uyxp9W8uLn7g1vkblMurZW3iNH09N+ub0DVrE+TxYj
         jFBCCNj9tmRWEOkZCDWH/IKaGCIBRoIL6bueIU/du7MgBbR15LHMJ6F/fz12Z/uV6Roe
         Xw8w==
X-Gm-Message-State: AFqh2kpRjYPJR7Bi+OPc7TfdpaTw0gF6zd0hRm8wZWRHdzeANvHOjGhm
        nKZylWvYAT7X3bdJMfbNS9k=
X-Google-Smtp-Source: AMrXdXv16X7Z5h/Vu/hJ3FoBiww67aXvypfcDbXctYCfyvWKDqkVz7yzOQ0qQZEEOlOdsseGyTd96w==
X-Received: by 2002:a05:6a00:f92:b0:582:a224:e740 with SMTP id ct18-20020a056a000f9200b00582a224e740mr30097176pfb.27.1673389643263;
        Tue, 10 Jan 2023 14:27:23 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 2-20020a620502000000b00580cf1be16csm8555886pff.137.2023.01.10.14.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 14:27:22 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/4] blkcg: Drop unnecessary RCU read [un]locks from blkg_conf_prep/finish()
Date:   Tue, 10 Jan 2023 12:27:11 -1000
Message-Id: <20230110222714.552241-2-tj@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110222714.552241-1-tj@kernel.org>
References: <20230110222714.552241-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
index ce6a2b7d3dfb..7d338bc84387 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -672,12 +672,12 @@ struct block_device *blkcg_conf_open_bdev(char **inputp)
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
@@ -699,7 +699,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	if (ret)
 		goto fail;
 
-	rcu_read_lock();
 	spin_lock_irq(&q->queue_lock);
 
 	if (!blkcg_policy_enabled(q, pol)) {
@@ -728,7 +727,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 
 		/* Drop locks to do new blkg allocation with GFP_KERNEL. */
 		spin_unlock_irq(&q->queue_lock);
-		rcu_read_unlock();
 
 		new_blkg = blkg_alloc(pos, disk, GFP_KERNEL);
 		if (unlikely(!new_blkg)) {
@@ -742,7 +740,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			goto fail_exit_queue;
 		}
 
-		rcu_read_lock();
 		spin_lock_irq(&q->queue_lock);
 
 		if (!blkcg_policy_enabled(q, pol)) {
@@ -778,7 +775,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	radix_tree_preload_end();
 fail_unlock:
 	spin_unlock_irq(&q->queue_lock);
-	rcu_read_unlock();
 fail_exit_queue:
 	blk_queue_exit(q);
 fail:
@@ -805,10 +801,9 @@ EXPORT_SYMBOL_GPL(blkg_conf_prep);
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
2.39.0

