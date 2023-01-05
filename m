Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D9A65E16D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbjAEAU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbjAEAUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:20:18 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C581D0CB;
        Wed,  4 Jan 2023 16:20:17 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b2so37755854pld.7;
        Wed, 04 Jan 2023 16:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ts0rVlkmgS/XPggqVjv7cJVPKi0SCbA4jUZjRT1Ws4=;
        b=EzlQfEhiPKE+3WEwi6W3NYIs6mO8zpre4HhW2fmiaSCbylT9DTLWVp8UvA1K/H9Dhe
         BWM0LJfKlgx+qXt2VCmI+KaVsTN5R1D5xz1Zr5/sos7+LGis+Qfis5wxtd420skJ0ujZ
         6vsIF54RQN3iF4AHF2oRgiKYFpI1TkBScTIRzXawhR7/zOSIPrsLPoDXuRJCoED722lK
         Xg1R+dVn3bQbPGIOh2zUetFFDhrATqkdPymgPuTYf1gjPIhgB+k0UsKzc36hZQEzYh5I
         cyfvmV4f7w7rawc/R23eUVs7k/taqu0aqjEgbBWdW9ejpscDpzw5UPo6cBvVFqiEU7Wh
         gSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Ts0rVlkmgS/XPggqVjv7cJVPKi0SCbA4jUZjRT1Ws4=;
        b=Yj5+qOt2I6UQQydgiq+r0OjhSrWlahi+AlRyZA3DK89OUeJB2cI+OqGOVea/I9gXJL
         CMtSqpliTsHPnlr6BEGHrpAsqY4ywJrhPmeHXyLNP7+5bKL9pPNNT+4bkqIYZ4JDmp/o
         00CcShZ8QlqbAm0grMNbJXR/ChgN9PxmC0FlUyai1OusTQOGO2TcFLUdIR4EGygAyHs9
         nju82r1aBh5ehSxLUQpz+PC/ZLZx6WoONZdgnI3ZfCq6xEB/L/5vVChfzKoARPAsjPPU
         Fahjl0ftFgxYWal6FEpThP711uuXguXRX+7FfzmGVnwVd5r4JaCcTrZZ/jD86G2BoeJP
         jxHg==
X-Gm-Message-State: AFqh2kqL8uMFDDgFvX5ROaC8+NkzrFHE77w4OLKujABWJ1rFPeeHblGW
        Ohz98ltTQRU44awC22bVIik=
X-Google-Smtp-Source: AMrXdXvosqUIN/kXLTaakeZK8FseoGw7jR3WUpS6RRILGeb2UeSriRhfvZOZdD/2bh83BKloIQMdkg==
X-Received: by 2002:a05:6a20:1455:b0:af:e13e:cd67 with SMTP id a21-20020a056a20145500b000afe13ecd67mr76879982pzi.6.1672878016768;
        Wed, 04 Jan 2023 16:20:16 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b00176dc67df44sm24755160plf.132.2023.01.04.16.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 16:20:15 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/4] blkcg: Restructure blkg_conf_prep() and friends
Date:   Wed,  4 Jan 2023 14:20:05 -1000
Message-Id: <20230105002007.157497-3-tj@kernel.org>
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

We want to support lazy init of rq-qos policies so that iolatency is enabled
lazily on configuration instead of gendisk initialization. The way blkg
config helpers are structured now is a bit awkward for that. Let's
restructure:

* blkcg_conf_open_bdev() is renamed to blkg_conf_open_bdev(). The blkcg_
  prefix was used because the bdev opening step is blkg-independent.
  However, the distinction is too subtle and confuses more than helps. Let's
  switch to blkg prefix so that it's consistent with the type and other
  helper names.

* struct blkg_conf_ctx now remembers the original input string and is always
  initialized by the new blkg_conf_init().

* blkg_conf_open_bdev() is updated to take a pointer to blkg_conf_ctx like
  blkg_conf_prep() and can be called multiple times safely. Instead of
  modifying the double pointer to input string directly,
  blkg_conf_open_bdev() now sets blkg_conf_ctx->body.

* blkg_conf_finish() is renamed to blkg_conf_exit() for symmetry and now
  must be called on all blkg_conf_ctx's which were initialized with
  blkg_conf_init().

Combined, this allows the users to either open the bdev first or do it
altogether with blkg_conf_prep() which will help implementing lazy init of
rq-qos policies.

Users are updated accordingly. No behavior change is intended by this patch.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c    | 105 +++++++++++++++++++++++++++---------------
 block/blk-cgroup.h    |  10 ++--
 block/blk-iocost.c    |  58 +++++++++++++----------
 block/blk-iolatency.c |   8 ++--
 block/blk-throttle.c  |  16 ++++---
 5 files changed, 122 insertions(+), 75 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 99674e23cf88..d8e0625cd12d 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -626,68 +626,92 @@ u64 __blkg_prfill_u64(struct seq_file *sf, struct blkg_policy_data *pd, u64 v)
 EXPORT_SYMBOL_GPL(__blkg_prfill_u64);
 
 /**
- * blkcg_conf_open_bdev - parse and open bdev for per-blkg config update
- * @inputp: input string pointer
+ * blkg_conf_init - initialize a blkg_conf_ctx
+ * @ctx: blkg_conf_ctx to initialize
+ * @input: input string
  *
- * Parse the device node prefix part, MAJ:MIN, of per-blkg config update
- * from @input and get and return the matching bdev.  *@inputp is
- * updated to point past the device node prefix.  Returns an ERR_PTR()
- * value on error.
+ * Initialize @ctx which can be used to parse blkg config input string @input.
+ * Once initialized, @ctx can be used with blkg_conf_open_bdev() and
+ * blkg_conf_prep(), and must be cleaned up with blkg_conf_exit().
+ */
+void blkg_conf_init(struct blkg_conf_ctx *ctx, char *input)
+{
+	*ctx = (struct blkg_conf_ctx){ .input = input };
+}
+EXPORT_SYMBOL_GPL(blkg_conf_init);
+
+/**
+ * blkg_conf_open_bdev - parse and open bdev for per-blkg config update
+ * @ctx: blkg_conf_ctx initialized with blkg_conf_init()
  *
- * Use this function iff blkg_conf_prep() can't be used for some reason.
+ * Parse the device node prefix part, MAJ:MIN, of per-blkg config update from
+ * @ctx->input and get and store the matching bdev in @ctx->bdev. @ctx->body is
+ * set to point past the device node prefix.
+ *
+ * This function may be called multiple times on @ctx and the extra calls become
+ * NOOPs. blkg_conf_prep() implicitly calls this function. Use this function
+ * explicitly if bdev access is needed without resolving the blkcg / policy part
+ * of @ctx->input. Returns -errno on error.
  */
-struct block_device *blkcg_conf_open_bdev(char **inputp)
+int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
 {
-	char *input = *inputp;
+	char *input = ctx->input;
 	unsigned int major, minor;
 	struct block_device *bdev;
 	int key_len;
 
+	if (ctx->bdev)
+		return 0;
+
 	if (sscanf(input, "%u:%u%n", &major, &minor, &key_len) != 2)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	input += key_len;
 	if (!isspace(*input))
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	input = skip_spaces(input);
 
 	bdev = blkdev_get_no_open(MKDEV(major, minor));
 	if (!bdev)
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 	if (bdev_is_partition(bdev)) {
 		blkdev_put_no_open(bdev);
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 	}
 
-	*inputp = input;
-	return bdev;
+	ctx->body = input;
+	ctx->bdev = bdev;
+	return 0;
 }
 
 /**
  * blkg_conf_prep - parse and prepare for per-blkg config update
  * @blkcg: target block cgroup
  * @pol: target policy
- * @input: input string
- * @ctx: blkg_conf_ctx to be filled
+ * @ctx: blkg_conf_ctx initialized with blkg_conf_init()
+ *
+ * Parse per-blkg config update from @ctx->input and initialize @ctx
+ * accordingly. On success, @ctx->body points to the part of @ctx->input
+ * following MAJ:MIN, @ctx->bdev points to the target block device and
+ * @ctx->blkg to the blkg being configured.
  *
- * Parse per-blkg config update from @input and initialize @ctx with the
- * result.  @ctx->blkg points to the blkg to be updated and @ctx->body the
- * part of @input following MAJ:MIN.  This function returns with queue lock
- * held and must be paired with blkg_conf_finish().
+ * blkg_conf_open_bdev() may be called on @ctx beforehand. On success, this
+ * function returns with queue lock held and must be followed by
+ * blkg_conf_exit().
  */
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
-		   char *input, struct blkg_conf_ctx *ctx)
+		   struct blkg_conf_ctx *ctx)
 {
-	struct block_device *bdev;
 	struct gendisk *disk;
 	struct request_queue *q;
 	struct blkcg_gq *blkg;
 	int ret;
 
-	bdev = blkcg_conf_open_bdev(&input);
-	if (IS_ERR(bdev))
-		return PTR_ERR(bdev);
-	disk = bdev->bd_disk;
+	ret = blkg_conf_open_bdev(ctx);
+	if (ret)
+		return ret;
+
+	disk = ctx->bdev->bd_disk;
 	q = disk->queue;
 
 	/*
@@ -765,9 +789,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	}
 success:
 	blk_queue_exit(q);
-	ctx->bdev = bdev;
 	ctx->blkg = blkg;
-	ctx->body = input;
 	return 0;
 
 fail_preloaded:
@@ -777,7 +799,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 fail_exit_queue:
 	blk_queue_exit(q);
 fail:
-	blkdev_put_no_open(bdev);
 	/*
 	 * If queue was bypassing, we should retry.  Do so after a
 	 * short msleep().  It isn't strictly necessary but queue
@@ -793,18 +814,26 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 EXPORT_SYMBOL_GPL(blkg_conf_prep);
 
 /**
- * blkg_conf_finish - finish up per-blkg config update
- * @ctx: blkg_conf_ctx initialized by blkg_conf_prep()
+ * blkg_conf_exit - clean up per-blkg config update
+ * @ctx: blkg_conf_ctx initialized with blkg_conf_init()
  *
- * Finish up after per-blkg config update.  This function must be paired
- * with blkg_conf_prep().
+ * Clean up after per-blkg config update. This function must be called on all
+ * blkg_conf_ctx's initialized with blkg_conf_init().
  */
-void blkg_conf_finish(struct blkg_conf_ctx *ctx)
+void blkg_conf_exit(struct blkg_conf_ctx *ctx)
 {
-	spin_unlock_irq(&bdev_get_queue(ctx->bdev)->queue_lock);
-	blkdev_put_no_open(ctx->bdev);
+	if (ctx->blkg) {
+		spin_unlock_irq(&bdev_get_queue(ctx->bdev)->queue_lock);
+		ctx->blkg = NULL;
+	}
+
+	if (ctx->bdev) {
+		blkdev_put_no_open(ctx->bdev);
+		ctx->body = NULL;
+		ctx->bdev = NULL;
+	}
 }
-EXPORT_SYMBOL_GPL(blkg_conf_finish);
+EXPORT_SYMBOL_GPL(blkg_conf_exit);
 
 static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
 {
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 1e94e404eaa8..fe09e8b4c2a8 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -208,15 +208,17 @@ void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
 u64 __blkg_prfill_u64(struct seq_file *sf, struct blkg_policy_data *pd, u64 v);
 
 struct blkg_conf_ctx {
+	char				*input;
+	char				*body;
 	struct block_device		*bdev;
 	struct blkcg_gq			*blkg;
-	char				*body;
 };
 
-struct block_device *blkcg_conf_open_bdev(char **inputp);
+void blkg_conf_init(struct blkg_conf_ctx *ctx, char *input);
+int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx);
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
-		   char *input, struct blkg_conf_ctx *ctx);
-void blkg_conf_finish(struct blkg_conf_ctx *ctx);
+		   struct blkg_conf_ctx *ctx);
+void blkg_conf_exit(struct blkg_conf_ctx *ctx);
 
 /**
  * bio_issue_as_root_blkg - see if this bio needs to be issued as root blkg
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 6955605629e4..22a3639a7a05 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3091,9 +3091,11 @@ static ssize_t ioc_weight_write(struct kernfs_open_file *of, char *buf,
 		return nbytes;
 	}
 
-	ret = blkg_conf_prep(blkcg, &blkcg_policy_iocost, buf, &ctx);
+	blkg_conf_init(&ctx, buf);
+
+	ret = blkg_conf_prep(blkcg, &blkcg_policy_iocost, &ctx);
 	if (ret)
-		return ret;
+		goto err;
 
 	iocg = blkg_to_iocg(ctx.blkg);
 
@@ -3112,12 +3114,14 @@ static ssize_t ioc_weight_write(struct kernfs_open_file *of, char *buf,
 	weight_updated(iocg, &now);
 	spin_unlock(&iocg->ioc->lock);
 
-	blkg_conf_finish(&ctx);
+	blkg_conf_exit(&ctx);
 	return nbytes;
 
 einval:
-	blkg_conf_finish(&ctx);
-	return -EINVAL;
+	ret = -EINVAL;
+err:
+	blkg_conf_exit(&ctx);
+	return ret;
 }
 
 static u64 ioc_qos_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
@@ -3172,19 +3176,22 @@ static const match_table_t qos_tokens = {
 static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 			     size_t nbytes, loff_t off)
 {
-	struct block_device *bdev;
+	struct blkg_conf_ctx ctx;
 	struct gendisk *disk;
 	struct ioc *ioc;
 	u32 qos[NR_QOS_PARAMS];
 	bool enable, user;
-	char *p;
+	char *body, *p;
 	int ret;
 
-	bdev = blkcg_conf_open_bdev(&input);
-	if (IS_ERR(bdev))
-		return PTR_ERR(bdev);
+	blkg_conf_init(&ctx, input);
 
-	disk = bdev->bd_disk;
+	ret = blkg_conf_open_bdev(&ctx);
+	if (ret)
+		goto err;
+
+	body = ctx.body;
+	disk = ctx.bdev->bd_disk;
 	ioc = q_to_ioc(disk->queue);
 	if (!ioc) {
 		ret = blk_iocost_init(disk);
@@ -3201,7 +3208,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	enable = ioc->enabled;
 	user = ioc->user_qos_params;
 
-	while ((p = strsep(&input, " \t\n"))) {
+	while ((p = strsep(&body, " \t\n"))) {
 		substring_t args[MAX_OPT_ARGS];
 		char buf[32];
 		int tok;
@@ -3290,7 +3297,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	blk_mq_unquiesce_queue(disk->queue);
 	blk_mq_unfreeze_queue(disk->queue);
 
-	blkdev_put_no_open(bdev);
+	blkg_conf_exit(&ctx);
 	return nbytes;
 einval:
 	spin_unlock_irq(&ioc->lock);
@@ -3300,7 +3307,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 
 	ret = -EINVAL;
 err:
-	blkdev_put_no_open(bdev);
+	blkg_conf_exit(&ctx);
 	return ret;
 }
 
@@ -3351,22 +3358,25 @@ static const match_table_t i_lcoef_tokens = {
 static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 				    size_t nbytes, loff_t off)
 {
-	struct block_device *bdev;
+	struct blkg_conf_ctx ctx;
 	struct request_queue *q;
 	struct ioc *ioc;
 	u64 u[NR_I_LCOEFS];
 	bool user;
-	char *p;
+	char *body, *p;
 	int ret;
 
-	bdev = blkcg_conf_open_bdev(&input);
-	if (IS_ERR(bdev))
-		return PTR_ERR(bdev);
+	blkg_conf_init(&ctx, input);
+
+	ret = blkg_conf_open_bdev(&ctx);
+	if (ret)
+		goto err;
 
-	q = bdev_get_queue(bdev);
+	body = ctx.body;
+	q = bdev_get_queue(ctx.bdev);
 	ioc = q_to_ioc(q);
 	if (!ioc) {
-		ret = blk_iocost_init(bdev->bd_disk);
+		ret = blk_iocost_init(ctx.bdev->bd_disk);
 		if (ret)
 			goto err;
 		ioc = q_to_ioc(q);
@@ -3379,7 +3389,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	memcpy(u, ioc->params.i_lcoefs, sizeof(u));
 	user = ioc->user_cost_model;
 
-	while ((p = strsep(&input, " \t\n"))) {
+	while ((p = strsep(&body, " \t\n"))) {
 		substring_t args[MAX_OPT_ARGS];
 		char buf[32];
 		int tok;
@@ -3426,7 +3436,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	blk_mq_unquiesce_queue(q);
 	blk_mq_unfreeze_queue(q);
 
-	blkdev_put_no_open(bdev);
+	blkg_conf_exit(&ctx);
 	return nbytes;
 
 einval:
@@ -3437,7 +3447,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 
 	ret = -EINVAL;
 err:
-	blkdev_put_no_open(bdev);
+	blkg_conf_exit(&ctx);
 	return ret;
 }
 
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index ecdc10741836..3b3667f397a9 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -842,9 +842,11 @@ static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
 	u64 oldval;
 	int ret;
 
-	ret = blkg_conf_prep(blkcg, &blkcg_policy_iolatency, buf, &ctx);
+	blkg_conf_init(&ctx, buf);
+
+	ret = blkg_conf_prep(blkcg, &blkcg_policy_iolatency, &ctx);
 	if (ret)
-		return ret;
+		goto out;
 
 	iolat = blkg_to_lat(ctx.blkg);
 	p = ctx.body;
@@ -880,7 +882,7 @@ static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
 		iolatency_clear_scaling(blkg);
 	ret = 0;
 out:
-	blkg_conf_finish(&ctx);
+	blkg_conf_exit(&ctx);
 	return ret ?: nbytes;
 }
 
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 6fb5a2f9e1ee..75841d1d9bf4 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1369,9 +1369,11 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 	int ret;
 	u64 v;
 
-	ret = blkg_conf_prep(blkcg, &blkcg_policy_throtl, buf, &ctx);
+	blkg_conf_init(&ctx, buf);
+
+	ret = blkg_conf_prep(blkcg, &blkcg_policy_throtl, &ctx);
 	if (ret)
-		return ret;
+		goto out_finish;
 
 	ret = -EINVAL;
 	if (sscanf(ctx.body, "%llu", &v) != 1)
@@ -1390,7 +1392,7 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 	tg_conf_updated(tg, false);
 	ret = 0;
 out_finish:
-	blkg_conf_finish(&ctx);
+	blkg_conf_exit(&ctx);
 	return ret ?: nbytes;
 }
 
@@ -1562,9 +1564,11 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	int ret;
 	int index = of_cft(of)->private;
 
-	ret = blkg_conf_prep(blkcg, &blkcg_policy_throtl, buf, &ctx);
+	blkg_conf_init(&ctx, buf);
+
+	ret = blkg_conf_prep(blkcg, &blkcg_policy_throtl, &ctx);
 	if (ret)
-		return ret;
+		goto out_finish;
 
 	tg = blkg_to_tg(ctx.blkg);
 	tg_update_carryover(tg);
@@ -1663,7 +1667,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 		tg->td->limit_valid[LIMIT_LOW]);
 	ret = 0;
 out_finish:
-	blkg_conf_finish(&ctx);
+	blkg_conf_exit(&ctx);
 	return ret ?: nbytes;
 }
 
-- 
2.39.0

