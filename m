Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170BF664ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbjAJW17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbjAJW1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:27:39 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9044610F0;
        Tue, 10 Jan 2023 14:27:29 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 17so14786973pll.0;
        Tue, 10 Jan 2023 14:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=As6nNAmXM4tdIzqTWu5Dx71F5R4c768lyUE/zpN/pFA=;
        b=kSqHHe1tiriRF7t2MDLU28ZAjUnWsk+aXHgU2P+dCTranSh9oubRYirI7n3bN1tdXS
         dx4Sm9EGx2OAqqKerRQPKwCGPyP5APrAh3l2UkMAEBzmfS0RSuy8Cco64YbkZirRN6tz
         nHz50rbnq1rG33kHpvhEU1oeAcYymFSD1uqRL4sNRb0bms347/hxbn/GvrMWa/cx4owX
         TjfkM3SxDcCCs++qLNYcD6hvkBvotdhbiM75CqulAiPtRkidueuC0OjLbaqhgFMEYzI0
         9uBTSVjPb22Urb+mbBue/hkv7YmntKdLzrkpLQR+6DOhU8PAYJkLh3A4N0h0JhVJkgV+
         Qchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=As6nNAmXM4tdIzqTWu5Dx71F5R4c768lyUE/zpN/pFA=;
        b=4HSmYbJMeecR2x4tBYKSbCLHVNkTp5iypLvEuXk1EW0cHuII4ObB1e5aHMzTmGjKtX
         o24bnePJWh4bV14Mss0C2nld5Z/On/VTpOJjcLCwQtjBcpBHYgRZlfOtMP57IvYo4rJ5
         HiFDq83zl9xoUYuFvwOLflS+ha01l/CBury5toDrbhGjOs4lAA07q+5mbacFvmTEMz5+
         FK46b3SfQzsYsBmSfARuGRB8Unug0vtR/65kvyKMLaDNIlaZ7AmmO/L3ZgaQDCcp1FYv
         vmgEYSrfX52l5kV9W03F05e0mk/mga/hSa5nyN+ysXUa7zSDKOUTUGhtJlcbKxO1XprM
         UXzQ==
X-Gm-Message-State: AFqh2krrFNjO0uuaAhXFUuAiUaEk5xq0VLFQ/T8w7JFB+PfnW91JJHve
        uvyOFKhWPx54guMAPBtyJR8=
X-Google-Smtp-Source: AMrXdXsYlPW0VH/0oKoavsb9npQ+pXKm/9qLaBGLhUpZw+iw6G3kwBYD89PTxAxMTAATn5obdFDAmw==
X-Received: by 2002:a05:6a21:9986:b0:b6:1425:55df with SMTP id ve6-20020a056a21998600b000b6142555dfmr196751pzb.59.1673389648863;
        Tue, 10 Jan 2023 14:27:28 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902f14d00b001873aa85e1fsm8516012plb.305.2023.01.10.14.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 14:27:28 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/4] blk-iolatency: Make initialization lazy
Date:   Tue, 10 Jan 2023 12:27:14 -1000
Message-Id: <20230110222714.552241-5-tj@kernel.org>
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

Other rq_qos policies such as wbt and iocost are lazy-initialized when they
are configured for the first time for the device but iolatency is
initialized unconditionally from blkcg_init_disk() during gendisk init. Lazy
init is beneficial because rq_qos policies add runtime overhead when
initialized as every IO has to walk all registered rq_qos callbacks.

This patch switches iolatency to lazy initialization too so that it only
registered its rq_qos policy when it is first configured.

Note that there is a known race condition between blkcg config file writes
and del_gendisk() and this patch makes iolatency susceptible to it by
exposing the init path to race against the deletion path. However, that
problem already exists in iocost and is being worked on.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-cgroup.c    |  8 --------
 block/blk-iolatency.c | 29 ++++++++++++++++++++++++++++-
 block/blk.h           |  6 ------
 3 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 18fbdea1f756..54e3ab68a9ac 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -33,7 +33,6 @@
 #include "blk-cgroup.h"
 #include "blk-ioprio.h"
 #include "blk-throttle.h"
-#include "blk-rq-qos.h"
 
 /*
  * blkcg_pol_mutex protects blkcg_policy[] and policy [de]activation.
@@ -1324,14 +1323,8 @@ int blkcg_init_disk(struct gendisk *disk)
 	if (ret)
 		goto err_ioprio_exit;
 
-	ret = blk_iolatency_init(disk);
-	if (ret)
-		goto err_throtl_exit;
-
 	return 0;
 
-err_throtl_exit:
-	blk_throtl_exit(disk);
 err_ioprio_exit:
 	blk_ioprio_exit(disk);
 err_destroy_all:
@@ -1347,7 +1340,6 @@ int blkcg_init_disk(struct gendisk *disk)
 void blkcg_exit_disk(struct gendisk *disk)
 {
 	blkg_destroy_all(disk);
-	rq_qos_exit(disk->queue);
 	blk_throtl_exit(disk);
 }
 
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 3601345808d2..3484393dbc4a 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -755,7 +755,7 @@ static void blkiolatency_enable_work_fn(struct work_struct *work)
 	}
 }
 
-int blk_iolatency_init(struct gendisk *disk)
+static int blk_iolatency_init(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	struct blk_iolatency *blkiolat;
@@ -830,6 +830,29 @@ static void iolatency_clear_scaling(struct blkcg_gq *blkg)
 	}
 }
 
+static int blk_iolatency_try_init(struct blkg_conf_ctx *ctx)
+{
+	static DEFINE_MUTEX(init_mutex);
+	int ret;
+
+	ret = blkg_conf_open_bdev(ctx);
+	if (ret)
+		return ret;
+
+	/*
+	 * blk_iolatency_init() may fail after rq_qos_add() succeeds which can
+	 * confuse iolat_rq_qos() test. Make the test and init atomic.
+	 */
+	mutex_lock(&init_mutex);
+
+	if (!iolat_rq_qos(ctx->bdev->bd_queue))
+		ret = blk_iolatency_init(ctx->bdev->bd_disk);
+
+	mutex_unlock(&init_mutex);
+
+	return ret;
+}
+
 static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
 			     size_t nbytes, loff_t off)
 {
@@ -844,6 +867,10 @@ static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
 
 	blkg_conf_init(&ctx, buf);
 
+	ret = blk_iolatency_try_init(&ctx);
+	if (ret)
+		goto out;
+
 	ret = blkg_conf_prep(blkcg, &blkcg_policy_iolatency, &ctx);
 	if (ret)
 		goto out;
diff --git a/block/blk.h b/block/blk.h
index 4c3b3325219a..78f1706cddca 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -392,12 +392,6 @@ static inline struct bio *blk_queue_bounce(struct bio *bio,
 	return bio;
 }
 
-#ifdef CONFIG_BLK_CGROUP_IOLATENCY
-int blk_iolatency_init(struct gendisk *disk);
-#else
-static inline int blk_iolatency_init(struct gendisk *disk) { return 0; };
-#endif
-
 #ifdef CONFIG_BLK_DEV_ZONED
 void disk_free_zone_bitmaps(struct gendisk *disk);
 void disk_clear_zone_settings(struct gendisk *disk);
-- 
2.39.0

