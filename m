Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F4C65E165
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbjAEAUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjAEAUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:20:16 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167404318D;
        Wed,  4 Jan 2023 16:20:15 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id cl14so1700461pjb.2;
        Wed, 04 Jan 2023 16:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrXn/UsH93lS2A5CebmmFeBERFF7L0+KOIci0sQ1Uks=;
        b=J1k7jrDwLvhrkklIO+4FmsuN9uB78Outh0/hx/c8Z1UJpFK4SEV/OxPdNdKjEw7YBX
         7OSqOziXo58sgBqFndekeZGgYWmddYPn/GbxUccsuibDNq9cKE1ts//NdSwTmakWeIld
         L6CR/HHaAHEn2vB5/H+U6wVss0atLd7GB3UHPKluuXHn1tx9CHG4vkpHB+dA+XGGyQ5T
         yxLOXwm1hRobGAHOYhtIKfLpWO3WQMrWvU211f9X9ckEPTgCqOC9aouMjVs5sfzAVK3g
         bGgaUHpPpDiZkMniECTu1mMhqrslj0ArqGkjO8oif+0Z0XPGxdyOpFQJZkr/lByNZywL
         WE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TrXn/UsH93lS2A5CebmmFeBERFF7L0+KOIci0sQ1Uks=;
        b=pJIU1uhiBnBZVgkh8s8T2Kx2NaVJ6GcNwSBp+qjazZMKXhRrAg3fQKpT17G88qmU0g
         hzMm4q1KjX70/+QRCvE5BBGKL//x0AGOr6k0KbrshcCdsETtpa3B0rKMcpNty87LPClE
         L+SA53A4rMiMrkL9V2FVSdqz785MzVueOtpOjDWPK4X1i62oKCNsOE/8TelxXR/wdeED
         p36tpiv07Pw5DQ82OvS2FYF3enTB2bVjVRfRjrmD4QpTEy8iP8psxoWR5PqI0qpE5WDm
         fAAFDYFh6SewH61Pn+65jWxl3pHze1cSAbOGCZ9uBK3E2pFxj4fj3ZsxpsuEX2xIBi/i
         clvw==
X-Gm-Message-State: AFqh2krnJT+rVyQXmzIlnLKILfzMPre/Vww/oXucMc46IoIgEfD1QasC
        o9tlfKbSmLffENVRSOti6LI=
X-Google-Smtp-Source: AMrXdXsrd7kyt1Mnrh8HeCZLy/eCkntDUgy7vpFm0DZRqUI0uISKErArimtz9/xAvJsdV1nzHfr0tg==
X-Received: by 2002:a17:903:130d:b0:192:490b:a207 with SMTP id iy13-20020a170903130d00b00192490ba207mr54258769plb.33.1672878014356;
        Wed, 04 Jan 2023 16:20:14 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id h27-20020a63385b000000b0045dc85c4a5fsm20729695pgn.44.2023.01.04.16.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 16:20:13 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/4] blkcg: Drop unnecessary RCU read [un]locks from blkg_conf_prep/finish()
Date:   Wed,  4 Jan 2023 14:20:04 -1000
Message-Id: <20230105002007.157497-2-tj@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105002007.157497-1-tj@kernel.org>
References: <20230105002007.157497-1-tj@kernel.org>
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

