Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372355F8A44
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 11:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiJIJHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 05:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiJIJHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 05:07:33 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2852723390
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 02:07:32 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id i6so8465202pfb.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 02:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxrqiw0cbhfXN4+OelLD9+srPRQcNc3GlNvIAj2f+tU=;
        b=oe5qxBC1H4qUilQPWPy/moxJ4w1ln70cLpRc/Wk8jkmt3TBM5d7VJNyft5SpWN8+Hr
         V+SK/9WSNTNYqY8WLXByi/u6h7gRuxPzVFGafKEyR+Y8/tLdczZTPqNCD93xhD5PTkaY
         XKLkVqBfhhtAFrvw7K6Y4FSE3vUclNw6hsVzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxrqiw0cbhfXN4+OelLD9+srPRQcNc3GlNvIAj2f+tU=;
        b=g0aHrsQ8Sx2+UH2uUrcdJWBbqNrYMD4sZ6G0EOBfpVk+YwCa0bUXiq+5/EoMKSKAYA
         BX/ScaDybuRseS9KkygbrK4g24TGDfJL3RpMbKz2S86iENoOe1R7kzNGUYZJGArAd6De
         8re994jQLC6KJ+olegbuA6IVDmjaer8PfPE+LKuJFqz0wscaxEqwVpLNkEMJJuWeirbU
         sCVIqcppX+y4L7TDqkKbkI0hz/Ux34cvFOJNmDSJaembkzWtmL4Nmln5IZMYh9AY/Ml4
         1jpHr+Dh/GlPtDAvI0DGrZWdJmyGydV9oTQHlDGtBkVu5H5X/XiJJLM6ua29Bc8/E4i8
         j39Q==
X-Gm-Message-State: ACrzQf15bv9pb7BvY77pPwPB24bzcsb6kgpJHPIfFEkKTGJAFeG1WqiK
        X6uoTuAHAh3sk5jUjMpJeIFbQA==
X-Google-Smtp-Source: AMsMyM6C8IGN2Dj12wvsCAFdbafvyBhEfZJPCUlA+MTMr1Fg8ofJtLAKdkOUiWQsDUoA0tspOCcD7g==
X-Received: by 2002:a63:b4d:0:b0:454:d8b4:285 with SMTP id a13-20020a630b4d000000b00454d8b40285mr11989075pgl.410.1665306451631;
        Sun, 09 Oct 2022 02:07:31 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:8517:d51e:5fe9:9be7])
        by smtp.gmail.com with ESMTPSA id q194-20020a632acb000000b00439d071c110sm4335148pgq.43.2022.10.09.02.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 02:07:31 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 2/8] zram: Add recompression algorithm sysfs knob
Date:   Sun,  9 Oct 2022 18:07:14 +0900
Message-Id: <20221009090720.1040633-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221009090720.1040633-1-senozhatsky@chromium.org>
References: <20221009090720.1040633-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce recomp_algorithm sysfs knob that controls
secondary algorithm selection used for recompression.
This device attribute works in a similar way with
comp_algorithm attribute.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 111 +++++++++++++++++++++++++++-------
 1 file changed, 90 insertions(+), 21 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 770ea3489eb6..a8ef3c0c3dae 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -41,7 +41,12 @@ static DEFINE_IDR(zram_index_idr);
 static DEFINE_MUTEX(zram_index_mutex);
 
 static int zram_major;
-static const char *default_compressor = CONFIG_ZRAM_DEF_COMP;
+static const char *default_comp_algs[ZRAM_MAX_ZCOMPS] = {
+	CONFIG_ZRAM_DEF_COMP,
+#ifdef CONFIG_ZRAM_MULTI_COMP
+	"zstd",
+#endif
+};
 
 /* Module params (documentation at end) */
 static unsigned int num_devices = 1;
@@ -1000,31 +1005,37 @@ static ssize_t max_comp_streams_store(struct device *dev,
 	return len;
 }
 
-static ssize_t comp_algorithm_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static void comp_algorithm_set(struct zram *zram, u32 idx, const char *alg)
 {
-	size_t sz;
-	struct zram *zram = dev_to_zram(dev);
+	bool default_alg = false;
+	int i;
 
-	down_read(&zram->init_lock);
-	sz = zcomp_available_show(zram->comp_algs[ZRAM_PRIMARY_ZCOMP], buf);
-	up_read(&zram->init_lock);
+	/* Do not kfree() algs that we didn't allocate, IOW the default ones */
+	for (i = 0; i < ZRAM_MAX_ZCOMPS; i++) {
+		if (zram->comp_algs[idx] == default_comp_algs[i]) {
+			default_alg = true;
+			break;
+		}
+	}
 
-	return sz;
+	if (!default_alg)
+		kfree(zram->comp_algs[idx]);
+	zram->comp_algs[idx] = alg;
 }
 
-static void comp_algorithm_set(struct zram *zram, u32 idx, const char *alg)
+static ssize_t __comp_algorithm_show(struct zram *zram, u32 idx, char *buf)
 {
-	/* Do not kfree() algs that we didn't allocate, IOW the default ones */
-	if (zram->comp_algs[idx] != default_compressor)
-		kfree(zram->comp_algs[idx]);
-	zram->comp_algs[idx] = alg;
+	ssize_t sz;
+
+	down_read(&zram->init_lock);
+	sz = zcomp_available_show(zram->comp_algs[idx], buf);
+	up_read(&zram->init_lock);
+
+	return sz;
 }
 
-static ssize_t comp_algorithm_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+static int __comp_algorithm_store(struct zram *zram, u32 idx, const char *buf)
 {
-	struct zram *zram = dev_to_zram(dev);
 	char *compressor;
 	size_t sz;
 
@@ -1053,11 +1064,55 @@ static ssize_t comp_algorithm_store(struct device *dev,
 		return -EBUSY;
 	}
 
-	comp_algorithm_set(zram, ZRAM_PRIMARY_ZCOMP, compressor);
+	comp_algorithm_set(zram, idx, compressor);
 	up_write(&zram->init_lock);
-	return len;
+	return 0;
+}
+
+static ssize_t comp_algorithm_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct zram *zram = dev_to_zram(dev);
+
+	return __comp_algorithm_show(zram, ZRAM_PRIMARY_ZCOMP, buf);
+}
+
+static ssize_t comp_algorithm_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf,
+				    size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	int ret;
+
+	ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_ZCOMP, buf);
+	return ret ? ret : len;
 }
 
+#ifdef CONFIG_ZRAM_MULTI_COMP
+static ssize_t recomp_algorithm_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct zram *zram = dev_to_zram(dev);
+
+	return __comp_algorithm_show(zram, ZRAM_SECONDARY_ZCOMP, buf);
+}
+
+static ssize_t recomp_algorithm_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	int ret;
+
+	ret = __comp_algorithm_store(zram, ZRAM_SECONDARY_ZCOMP, buf);
+	return ret ? ret : len;
+}
+#endif
+
 static ssize_t compact_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
@@ -1762,7 +1817,11 @@ static void zram_reset_device(struct zram *zram)
 	memset(&zram->stats, 0, sizeof(zram->stats));
 	reset_bdev(zram);
 
-	comp_algorithm_set(zram, ZRAM_PRIMARY_ZCOMP, default_compressor);
+	comp_algorithm_set(zram, ZRAM_PRIMARY_ZCOMP,
+			   default_comp_algs[ZRAM_PRIMARY_ZCOMP]);
+	if (IS_ENABLED(CONFIG_ZRAM_MULTI_COMP))
+		comp_algorithm_set(zram, ZRAM_SECONDARY_ZCOMP,
+				   default_comp_algs[ZRAM_SECONDARY_ZCOMP]);
 	up_write(&zram->init_lock);
 }
 
@@ -1895,6 +1954,9 @@ static DEVICE_ATTR_WO(writeback);
 static DEVICE_ATTR_RW(writeback_limit);
 static DEVICE_ATTR_RW(writeback_limit_enable);
 #endif
+#ifdef CONFIG_ZRAM_MULTI_COMP
+static DEVICE_ATTR_RW(recomp_algorithm);
+#endif
 
 static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_disksize.attr,
@@ -1918,6 +1980,9 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_bd_stat.attr,
 #endif
 	&dev_attr_debug_stat.attr,
+#ifdef CONFIG_ZRAM_MULTI_COMP
+	&dev_attr_recomp_algorithm.attr,
+#endif
 	NULL,
 };
 
@@ -1997,7 +2062,11 @@ static int zram_add(void)
 	if (ret)
 		goto out_cleanup_disk;
 
-	zram->comp_algs[ZRAM_PRIMARY_ZCOMP] = default_compressor;
+	zram->comp_algs[ZRAM_PRIMARY_ZCOMP] =
+		default_comp_algs[ZRAM_PRIMARY_ZCOMP];
+	if (IS_ENABLED(CONFIG_ZRAM_MULTI_COMP))
+		zram->comp_algs[ZRAM_SECONDARY_ZCOMP] =
+			default_comp_algs[ZRAM_SECONDARY_ZCOMP];
 
 	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
-- 
2.38.0.rc1.362.ged0d419d3c-goog

