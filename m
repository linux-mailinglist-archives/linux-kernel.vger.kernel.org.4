Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667A66E0306
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 02:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjDMAHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 20:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjDMAHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 20:07:05 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5D07290;
        Wed, 12 Apr 2023 17:07:03 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w11so13219495plp.13;
        Wed, 12 Apr 2023 17:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681344423; x=1683936423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6a22uOlRjDtJ8Fbi9zx7mQDhRHqsq8ulm+wYpcSlrL4=;
        b=nf7U8/vw1JXB5hQIi0zWYWw5ZPhjDCJtGW3DpoxfqeVVj8t09FSkjnxwrOA+mMLVkk
         BTzi3yVizrqTLQv4IlPg4/pL+zlCPeyVgA+uq9NN2Wb/UfUFEHpoCh2GSaI5Rldwx7zV
         Pkpznn6YxU+c7712ZZRfj3w3x1rQVz46EtIatX6/2nMrd/aNb7y16CyZGQE0kpXxmIas
         JPCoLErPvoJeHHuJW6tb1Ep54Lk3u3XIoxQw4HBwojb33fZMnyTTrtFZHFgZ1YDj0IUv
         BkdJxlSsh6fc3In0b7dCzZ9BdCo2seKA4FIsz04hg79dTTotlHAybz1oAtvYG+FU6+pT
         F83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681344423; x=1683936423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6a22uOlRjDtJ8Fbi9zx7mQDhRHqsq8ulm+wYpcSlrL4=;
        b=VkRm/ZjL5cl6RadmP4GmabA+P8igHmgGshWN2ME8se1fwgMsyI7fqN5KQI5yU4AQ/j
         oDmhhofCFB4QD9PmXespm/9WrRtAg+WI14Mr2e31WusJdLD5mKw1fTWr93tfxpw7dKHI
         IMc2jNsV26Awg2hK0HIm5iAaadhkm/U6XTDEiwOtNBTNv1J62lYYHdM76lZO892LPEUK
         /ddoxwEuh8RUlylnF386lZ00VgM7rN9dhtLu9aYY8oECcx14fVglG0otu1POGrqKJAvh
         2ZaXmLohYpUAdsbt9T2dhx09WNHKLbRm4h9jNuNuSdLFv0RzBQ2pUQT1rc2tBs8FWBpm
         vo3A==
X-Gm-Message-State: AAQBX9fqRE9eStglKy/bBOXcTulx+EX8IeQxWtAhs9qEnpnJ9omZhe8N
        K2J/JIgAmxDsWBeth8avI/I=
X-Google-Smtp-Source: AKy350brOmX8aAGegEFStx3AvYebyWfnUrUl3m5QZ6vV8rtiDpufL8rfyiB+6H/LHV3E0fNGAp0ZSg==
X-Received: by 2002:a17:903:230a:b0:1a5:2a50:e177 with SMTP id d10-20020a170903230a00b001a52a50e177mr40928plh.55.1681344422711;
        Wed, 12 Apr 2023 17:07:02 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b00192aa53a7d5sm161665plw.8.2023.04.12.17.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 17:07:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/4] blk-iolatency: Make initialization lazy
Date:   Wed, 12 Apr 2023 14:06:49 -1000
Message-Id: <20230413000649.115785-5-tj@kernel.org>
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
index c154b08a7e92..1c1ebeb51003 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -33,7 +33,6 @@
 #include "blk-cgroup.h"
 #include "blk-ioprio.h"
 #include "blk-throttle.h"
-#include "blk-rq-qos.h"
 
 /*
  * blkcg_pol_mutex protects blkcg_policy[] and policy [de]activation.
@@ -1350,14 +1349,8 @@ int blkcg_init_disk(struct gendisk *disk)
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
@@ -1373,7 +1366,6 @@ int blkcg_init_disk(struct gendisk *disk)
 void blkcg_exit_disk(struct gendisk *disk)
 {
 	blkg_destroy_all(disk);
-	rq_qos_exit(disk->queue);
 	blk_throtl_exit(disk);
 }
 
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 2560708b9109..fd5fec989e39 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -755,7 +755,7 @@ static void blkiolatency_enable_work_fn(struct work_struct *work)
 	}
 }
 
-int blk_iolatency_init(struct gendisk *disk)
+static int blk_iolatency_init(struct gendisk *disk)
 {
 	struct blk_iolatency *blkiolat;
 	int ret;
@@ -824,6 +824,29 @@ static void iolatency_clear_scaling(struct blkcg_gq *blkg)
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
@@ -838,6 +861,10 @@ static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
 
 	blkg_conf_init(&ctx, buf);
 
+	ret = blk_iolatency_try_init(&ctx);
+	if (ret)
+		goto out;
+
 	ret = blkg_conf_prep(blkcg, &blkcg_policy_iolatency, &ctx);
 	if (ret)
 		goto out;
diff --git a/block/blk.h b/block/blk.h
index d65d96994a94..62fca868bc61 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -399,12 +399,6 @@ static inline struct bio *blk_queue_bounce(struct bio *bio,
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
2.40.0

