Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D6565E16F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjAEAUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbjAEAU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:20:29 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8259143A3C;
        Wed,  4 Jan 2023 16:20:22 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id c8-20020a17090a4d0800b00225c3614161so331850pjg.5;
        Wed, 04 Jan 2023 16:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptP+TRS/lGASh4wVWy3dTAfwv7VhGgtUgLBdAb814ZI=;
        b=dHNJ4c9N/rgKzU5mtTSooEkFrH5UUxnDD5nGsNE5EId51rvRAEFyfAhXtEHSuvkEKt
         RQz0VvO9DgyXJyASACy+XR9jh21vRfPCoARuGggEn39kVznbeaIPpd6rMRw4tjNmUCYm
         uBSmkRkD3cTjynubwMsNDNlz4T4XY46wAvHyPdrx9w42VdVsHJUc9afbLDTU0tQ9/GyG
         uyRaYYarCYHh2NnTTqGV1R2DmL3a6E0Prs0NT6N59/co9PipQTULQbl7fzcdJoGH5VpW
         dAjfqAdwLn8Rg8Cf4ug5jxxSD5fTa7wQnfSeB4fwd/CsfBd6LttTmZ7MDhjB0PJOagPf
         BeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ptP+TRS/lGASh4wVWy3dTAfwv7VhGgtUgLBdAb814ZI=;
        b=rSHLgAHtkO4Mh9RiwECNtMG+X7GzrPCTea1fWs7CTTbpyeeuK9V2k71wSau1YxJRaL
         XOQZ64nuswJFtPvqpXAEPASi93/uWBUB0FEwUmmMBFmwF/cW/CGlTH0WIg4E7mrZoDsR
         5YZIuaLKIxLIUwnwYoy+UXaTpwp2k78BXAwaePncrBwpKVObmHTRiK3bqBgsWJ06TNMy
         vONkf26pIPoKxQcxKo4DZYnHsYBTf27cEmwse+69pwKJsYC6WMnoVQt2XVfOQPSod8tW
         saKDYjC3tVe0uPmMytVp2u4VLSavNUvs8SL4/XK9n7auy+qdvfi4RuTuq+e4/1+qv1Sw
         ByfQ==
X-Gm-Message-State: AFqh2kqfs5goS4qxRKTTvICYtXZg8jEcJDEM4o1TBIprvVjQj/3xQUKr
        hAPm2uzfszTlOEsC4MpVDWE=
X-Google-Smtp-Source: AMrXdXthf3BY6LGdsiU2Y84F3Su70EFygCAjFiOluzrSPRnj8T0e52EAujhenJDphU/3eUAoL6xaVw==
X-Received: by 2002:a17:902:7d8e:b0:191:11ec:2028 with SMTP id a14-20020a1709027d8e00b0019111ec2028mr51457490plm.46.1672878021769;
        Wed, 04 Jan 2023 16:20:21 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x22-20020a63db56000000b004a737a6e62fsm371525pgi.14.2023.01.04.16.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 16:20:21 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/4] blk-iolatency: Make initialization lazy
Date:   Wed,  4 Jan 2023 14:20:07 -1000
Message-Id: <20230105002007.157497-5-tj@kernel.org>
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
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c    |  8 --------
 block/blk-iolatency.c | 29 ++++++++++++++++++++++++++++-
 block/blk.h           |  6 ------
 3 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index d8e0625cd12d..844579aff363 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -33,7 +33,6 @@
 #include "blk-cgroup.h"
 #include "blk-ioprio.h"
 #include "blk-throttle.h"
-#include "blk-rq-qos.h"
 
 /*
  * blkcg_pol_mutex protects blkcg_policy[] and policy [de]activation.
@@ -1322,14 +1321,8 @@ int blkcg_init_disk(struct gendisk *disk)
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
@@ -1345,7 +1338,6 @@ int blkcg_init_disk(struct gendisk *disk)
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

