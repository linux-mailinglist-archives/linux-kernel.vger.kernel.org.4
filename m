Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EED65F5B4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbjAEVY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbjAEVYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:24:48 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCE32F795;
        Thu,  5 Jan 2023 13:24:47 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id z4-20020a17090a170400b00226d331390cso2283135pjd.5;
        Thu, 05 Jan 2023 13:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptP+TRS/lGASh4wVWy3dTAfwv7VhGgtUgLBdAb814ZI=;
        b=V7T0Xn1YdlFcaVEgPKSUl8rZlRg3c67hT1gEvABoMED52yoSZTGLsKP/5fmVcP8GjN
         nqbdzjRpwoF6vrnnuJcKluCYDHOGqepCifxWkuL6gVqmPGz4ZCkrHTsG8r2+R+oW0K17
         8LDDEMfCkh9D5QNAEPexlTwfdi1OlNTwsuc8bnf92AcZgL+SBVU62W9pPy1VKQp0MncR
         YzeenEu2xyKEmAlPCT88MOb+oJk20xKflj9qbJSLZCULPGgvQSAXYr/Vk23TKgDcbpUJ
         qaMBMxRLOj1uAlPqv+GcZu26tVU49iiiYjGRyx54DxB8ZlUACWfTBARjjw+IWlOgJ6XS
         NVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ptP+TRS/lGASh4wVWy3dTAfwv7VhGgtUgLBdAb814ZI=;
        b=NpoDgZutX5RJFrB+VigjzRoGeVSjMb3JajH7QFkuIyKS1b6Ys/mmhGPPapyvKKMtM5
         5X+B3XXK8h1a+09U/bXsSACeGzudoII9Vw2P9M/ijpGuvuyCHlT7TM5D6Z9p3DRPWwkk
         2kT0m8nVn/qgNQHBzqmRomT++FVNLO44BXTg0hATMvIezuQwqq5qcJ6JF5iWXwOAbvL3
         BWRxoV57ExQCg9r3sHf2GjU5ImTls1+6+c3yPWNiDZ73Z8l5DVWv5cGu4y4gxjsAhHsE
         jkvNYOMGU2QeSAkCoRza4O1ZtVBCT0tszLLJNhyJL1mheA1rByFwSe0ntnadsx5slIXe
         8KeA==
X-Gm-Message-State: AFqh2kqKfYV05gwaf2sTQhcbiIo6yc2pJ5s1WgHCozK2lE+6COl1a3ZY
        RFjlie61yViuuxsa3GonhDI=
X-Google-Smtp-Source: AMrXdXsK3z8WPZqVWjPtPqP3vCNRacedh6LJsHsPm3ZgpPyCKjlF7RTeV3Ef3amQLbetdglMcN2iFA==
X-Received: by 2002:a17:90b:215:b0:225:bf26:4928 with SMTP id fy21-20020a17090b021500b00225bf264928mr54101453pjb.38.1672953886879;
        Thu, 05 Jan 2023 13:24:46 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x5-20020a17090aa38500b00219cf5c3829sm1732645pjp.57.2023.01.05.13.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 13:24:46 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/4] blk-iolatency: Make initialization lazy
Date:   Thu,  5 Jan 2023 11:24:32 -1000
Message-Id: <20230105212432.289569-5-tj@kernel.org>
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

