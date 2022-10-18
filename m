Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDCF60238C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 06:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJRE4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 00:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJREzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 00:55:48 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E6A45F7C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 21:55:47 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o17-20020a17090aac1100b0020d98b0c0f4so14860921pjq.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 21:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFk+eNUXynOg9IsBl0rempe5RZozp8YcQAw5rmNlx7E=;
        b=iCGJlVBxWRXpUIMQsucXw6YsDvNwLojnvvHiyGxBI3A/0Gu/oRlJYCwhdk46CgBA65
         G6Rw7zcaSq3YmH1fwtlCqV00WL7d4C9edtJW+4+FF8gYtdPa3nCAphCfMsd0+7AXr5+5
         D+9Azge2plTkQRyHGI6hzyYkTVAtM2V+Jzlo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFk+eNUXynOg9IsBl0rempe5RZozp8YcQAw5rmNlx7E=;
        b=UDjrEsxklTC+6BaRp/dlIQ76MaPDqsM65G4eozGhIx4HWi+bgMIoK16OVUNbFvVoGk
         fdMTGK9ao3+XFA7sd905eL4UWhNOVGG41uOG+9/pbwRM2xqBNKwhEnoxosjNx9QWjgsc
         NxhCNVjgEzkuH/q7ImN9mtRONHIRgGF6alt9Pj30ClTqRrOaJ8LoZ3iF6blz7eTQc1Di
         ZZg6ZHhg5+20kvrvOreIqT9mAHEznF7nVU5hOysUY5cjELyFttw1m9OfrKEqH9VeC4U0
         OE2iDPFn0GdBe1FjZSPGBx2P4vDwpoU4Gujy//amecL/5fFv/0GYhYweMS+78CXV1GXT
         9Pwg==
X-Gm-Message-State: ACrzQf2EMbwpEOnwYrztPEDiWiVrfhyIdL63nZ2Nnc9pEIC5ftcBPsgl
        SJ5Mofg12gg8jZZDtm+aW96IAw==
X-Google-Smtp-Source: AMsMyM4qw2KQWg1A7qtGIj8f0nG7xq3qtR/3RNoXQuSnVGVdaqSzgZw9BR0qelI0lapfk4C3bR5Dlw==
X-Received: by 2002:a17:903:124b:b0:179:da2f:2457 with SMTP id u11-20020a170903124b00b00179da2f2457mr1175806plh.156.1666068946825;
        Mon, 17 Oct 2022 21:55:46 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:17a9:73b0:c262:eccd])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b0017b69f99321sm7549220plf.219.2022.10.17.21.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:55:46 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Date:   Tue, 18 Oct 2022 13:55:26 +0900
Message-Id: <20221018045533.2396670-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221018045533.2396670-1-senozhatsky@chromium.org>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.38.0.413.g74048e4d9e-goog

