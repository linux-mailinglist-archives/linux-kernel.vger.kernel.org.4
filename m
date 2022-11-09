Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A58622AEF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiKILvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiKILvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:51:01 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFAA2CDD3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:51:00 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id l2so16831295pld.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2STvSSncO0NE+Pc4XM/M24vXge8hgNvkyOrZLLo09CU=;
        b=Gnj8YxkZmSXisqpa9f9O26JNP3w9Jr92llhfl96tANf3bFA1UUpYeanXW/x1XBpd1T
         ReKNHsqAsLWVqB7RONpDvI1p9U74iuIlieuE7HOpICpJzJKH1kBktLXfHl103bUf82Lr
         eDAqyc0zNwuD4OrOAil0SbC8M8KIN6gRnOxnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2STvSSncO0NE+Pc4XM/M24vXge8hgNvkyOrZLLo09CU=;
        b=QV6BWdO7MKeO8Ww84dIxpPU86fV+Px/mVnSr9bBFmMlJBepXBKhio2JFUUioZ30dGe
         ABrtGf2QxQI/3dAr8+9StByq+lOeIGIZmNErNJT7RRiDyQCFRwYq1z/E0TO+NmkwLQ+W
         cf8YvHvrbUmRP9fXhhczbdEZZCqspkxf79cVfXscJJUdKfisqys2jgltj5slH+SJaVTv
         z+u424S2ADZfHcDmdtvbv9C6jZUwy0WviCAKIMOBPKtDQt5iZ/GgbwLjPeUq6R6Pdr6k
         WpGFUKt8utfBHPeHZFxcIMBHBnVRkL5fDNZ+YJRKEgkgc/yL1d2BSkNeR7/vDHckhUTF
         7gjQ==
X-Gm-Message-State: ACrzQf1n05vlxGvYz4m9EJYqAsfuKRdVo7SnTL5OurIqeroBHKZakt8D
        qbcc56KZMl2i1LZlfp45hEHdcQ==
X-Google-Smtp-Source: AMsMyM6xPKvI1rFKl5nOfDTS3HUFzInmPELN0OJL4VTq5t1OcpxDaMsalY0qlRJ2qAgEQis7z+sUuA==
X-Received: by 2002:a17:90b:3113:b0:213:82ad:9bc7 with SMTP id gc19-20020a17090b311300b0021382ad9bc7mr71655635pjb.131.1667994659864;
        Wed, 09 Nov 2022 03:50:59 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:61f1:44d3:3f47:2cdb])
        by smtp.gmail.com with ESMTPSA id f5-20020a655505000000b00434760ee36asm7292311pgr.16.2022.11.09.03.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:50:59 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 02/13] zram: Add recompression algorithm sysfs knob
Date:   Wed,  9 Nov 2022 20:50:36 +0900
Message-Id: <20221109115047.2921851-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221109115047.2921851-1-senozhatsky@chromium.org>
References: <20221109115047.2921851-1-senozhatsky@chromium.org>
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

We will support up to 3 secondary compression algorithms
which are sorted in order of their priority. To select an
algorithm user has to provide its name and priority:

  echo "algo=zstd priority=1" > /sys/block/zramX/recomp_algorithm
  echo "algo=deflate priority=2" > /sys/block/zramX/recomp_algorithm

During recompression zram iterates through the list of registered
secondary algorithms in order of their priorities.

We also have a short version for cases when there is only
one secondary compression algorithm:

  echo "algo=zstd" > /sys/block/zramX/recomp_algorithm

This will register zstd as the secondary algorithm with priority 1.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 124 ++++++++++++++++++++++++++++------
 1 file changed, 105 insertions(+), 19 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 5371ed63c785..56026a6deb70 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1000,31 +1000,28 @@ static ssize_t max_comp_streams_store(struct device *dev,
 	return len;
 }
 
-static ssize_t comp_algorithm_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static void comp_algorithm_set(struct zram *zram, u32 prio, const char *alg)
 {
-	size_t sz;
-	struct zram *zram = dev_to_zram(dev);
+	/* Do not free statically defined compression algorithms */
+	if (zram->comp_algs[prio] != default_compressor)
+		kfree(zram->comp_algs[prio]);
+
+	zram->comp_algs[prio] = alg;
+}
+
+static ssize_t __comp_algorithm_show(struct zram *zram, u32 prio, char *buf)
+{
+	ssize_t sz;
 
 	down_read(&zram->init_lock);
-	sz = zcomp_available_show(zram->comp_algs[ZRAM_PRIMARY_COMP], buf);
+	sz = zcomp_available_show(zram->comp_algs[prio], buf);
 	up_read(&zram->init_lock);
 
 	return sz;
 }
 
-static void comp_algorithm_set(struct zram *zram, u32 prio, const char *alg)
+static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 {
-	/* Do not kfree() algs that we didn't allocate, IOW the default ones */
-	if (zram->comp_algs[prio] != default_compressor)
-		kfree(zram->comp_algs[prio]);
-	zram->comp_algs[prio] = alg;
-}
-
-static ssize_t comp_algorithm_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
-{
-	struct zram *zram = dev_to_zram(dev);
 	char *compressor;
 	size_t sz;
 
@@ -1053,11 +1050,94 @@ static ssize_t comp_algorithm_store(struct device *dev,
 		return -EBUSY;
 	}
 
-	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, compressor);
+	comp_algorithm_set(zram, prio, compressor);
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
+	return __comp_algorithm_show(zram, ZRAM_PRIMARY_COMP, buf);
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
+	ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_COMP, buf);
+	return ret ? ret : len;
 }
 
+#ifdef CONFIG_ZRAM_MULTI_COMP
+static ssize_t recomp_algorithm_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct zram *zram = dev_to_zram(dev);
+	ssize_t sz = 0;
+	u32 prio;
+
+	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
+		if (!zram->comp_algs[prio])
+			continue;
+
+		sz += scnprintf(buf + sz, PAGE_SIZE - sz - 2, "#%d: ", prio);
+		sz += __comp_algorithm_show(zram, prio, buf + sz);
+	}
+
+	return sz;
+}
+
+static ssize_t recomp_algorithm_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	int prio = ZRAM_SECONDARY_COMP;
+	char *args, *param, *val;
+	char *alg = NULL;
+	int ret;
+
+	args = skip_spaces(buf);
+	while (*args) {
+		args = next_arg(args, &param, &val);
+
+		if (!*val)
+			return -EINVAL;
+
+		if (!strcmp(param, "algo")) {
+			alg = val;
+			continue;
+		}
+
+		if (!strcmp(param, "priority")) {
+			ret = kstrtoint(val, 10, &prio);
+			if (ret)
+				return ret;
+			continue;
+		}
+	}
+
+	if (!alg)
+		return -EINVAL;
+
+	if (prio < ZRAM_SECONDARY_COMP || prio >= ZRAM_MAX_COMPS)
+		return -EINVAL;
+
+	ret = __comp_algorithm_store(zram, prio, alg);
+	return ret ? ret : len;
+}
+#endif
+
 static ssize_t compact_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
@@ -1898,6 +1978,9 @@ static DEVICE_ATTR_WO(writeback);
 static DEVICE_ATTR_RW(writeback_limit);
 static DEVICE_ATTR_RW(writeback_limit_enable);
 #endif
+#ifdef CONFIG_ZRAM_MULTI_COMP
+static DEVICE_ATTR_RW(recomp_algorithm);
+#endif
 
 static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_disksize.attr,
@@ -1921,6 +2004,9 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_bd_stat.attr,
 #endif
 	&dev_attr_debug_stat.attr,
+#ifdef CONFIG_ZRAM_MULTI_COMP
+	&dev_attr_recomp_algorithm.attr,
+#endif
 	NULL,
 };
 
@@ -2000,7 +2086,7 @@ static int zram_add(void)
 	if (ret)
 		goto out_cleanup_disk;
 
-	zram->comp_algs[ZRAM_PRIMARY_COMP] = default_compressor;
+	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
 
 	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
-- 
2.38.1.431.g37b22c650d-goog

