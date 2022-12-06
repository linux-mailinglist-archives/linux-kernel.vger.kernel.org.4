Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A641644E3A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 22:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiLFVxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 16:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiLFVxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 16:53:22 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651AA42F7C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 13:53:21 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id x66so15806865pfx.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 13:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rR7AezfryDSZesedhBewMciK+qFNUMypeH+qg8UKslY=;
        b=jOzVZpcNG3thP3z85CN8Tvgokln54TFy5mIRBK7HOtwTvfLKN5gaJokT130HHKKQZh
         ibOQ0ipxGG5qoIYaKmWyjz/yx8eXeSO4iTiWbmAo5+LcQqFUgU8iWtfi4KuP4H6oT0PH
         R4Ta21bKoaOorIvBvc+uK1d4AkkxdtzpnLhN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rR7AezfryDSZesedhBewMciK+qFNUMypeH+qg8UKslY=;
        b=5WKNoHULGluB3OPO0TKE/VXfypp6/I3UTExvBfihsrnhKnY3YzJkX/UAUNi7XFLhv8
         Ojz0ySH4lGYg3lSHXMW/ueQmNXK0Db+sboNYrmgUHcaS3G88Bo6Agb6fKhl6ZYbu2L1A
         LQVtTHg16SRuHcHZH4ZKDUgXfb918Xgo70NC3e0RI2o8at53hjKUPolqAXn+ybqoEewR
         sPl9nwPrO/IdY1yc4Nryso1QsGFZ19KEzL0D0FGIadEhpj2jmKJRpX0rDrQ/HDU3sgZS
         DLIOlGyhtaEUWqP5cswnca8vpC3RjQY5LCb/d5QXhZGxEossnI0feWf9i45Sf9w6sbeu
         0ZXw==
X-Gm-Message-State: ANoB5pnwIytMetE5hfo+rLSQn3W2eQBDHxV9WpQF0UxSIiI5WEOFx4Kv
        K/yTfMzoISF4x8hUCBmDSCudAA==
X-Google-Smtp-Source: AA0mqf4KsT5qv1qb2rSbbKG1mjZtwWikGqgMdjgeun2HsjE+5jdNvFH5zWXJao5tB5J8wzB4yu9Yqw==
X-Received: by 2002:aa7:8e54:0:b0:574:fddf:9946 with SMTP id d20-20020aa78e54000000b00574fddf9946mr48212025pfr.79.1670363600855;
        Tue, 06 Dec 2022 13:53:20 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:11a:201:cb30:cf01:5668:eda7])
        by smtp.gmail.com with ESMTPSA id z4-20020a170902d54400b001769206a766sm13034661plf.307.2022.12.06.13.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 13:53:20 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-modules@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Nick Terrell <terrelln@fb.com>
Subject: [PATCH] module/decompress: Support zstd in-kernel decompression
Date:   Tue,  6 Dec 2022 13:53:18 -0800
Message-Id: <20221206215318.3955400-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
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

Add support for zstd compressed modules to the in-kernel decompression
code. This allows zstd compressed modules to be decompressed by the
kernel, similar to the existing support for gzip and xz compressed
modules.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Piotr Gorski <lucjan.lucjanov@gmail.com>
Cc: Nick Terrell <terrelln@fb.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 kernel/module/Kconfig      |  3 +-
 kernel/module/decompress.c | 92 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 26ea5d04f56c..424b3bc58f3f 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -221,9 +221,10 @@ endchoice
 
 config MODULE_DECOMPRESS
 	bool "Support in-kernel module decompression"
-	depends on MODULE_COMPRESS_GZIP || MODULE_COMPRESS_XZ
+	depends on MODULE_COMPRESS_GZIP || MODULE_COMPRESS_XZ || MODULE_COMPRESS_ZSTD
 	select ZLIB_INFLATE if MODULE_COMPRESS_GZIP
 	select XZ_DEC if MODULE_COMPRESS_XZ
+	select ZSTD_DECOMPRESS if MODULE_COMPRESS_ZSTD
 	help
 
 	  Support for decompressing kernel modules by the kernel itself
diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index c033572d83f0..44f14643d014 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -50,7 +50,7 @@ static struct page *module_get_next_page(struct load_info *info)
 	return page;
 }
 
-#ifdef CONFIG_MODULE_COMPRESS_GZIP
+#if defined(CONFIG_MODULE_COMPRESS_GZIP)
 #include <linux/zlib.h>
 #define MODULE_COMPRESSION	gzip
 #define MODULE_DECOMPRESS_FN	module_gzip_decompress
@@ -141,7 +141,7 @@ static ssize_t module_gzip_decompress(struct load_info *info,
 	kfree(s.workspace);
 	return retval;
 }
-#elif CONFIG_MODULE_COMPRESS_XZ
+#elif defined(CONFIG_MODULE_COMPRESS_XZ)
 #include <linux/xz.h>
 #define MODULE_COMPRESSION	xz
 #define MODULE_DECOMPRESS_FN	module_xz_decompress
@@ -199,6 +199,94 @@ static ssize_t module_xz_decompress(struct load_info *info,
 	xz_dec_end(xz_dec);
 	return retval;
 }
+#elif defined(CONFIG_MODULE_COMPRESS_ZSTD)
+#include <linux/zstd.h>
+#define MODULE_COMPRESSION	zstd
+#define MODULE_DECOMPRESS_FN	module_zstd_decompress
+
+static ssize_t module_zstd_decompress(struct load_info *info,
+				    const void *buf, size_t size)
+{
+	static const u8 signature[] = { 0x28, 0xb5, 0x2f, 0xfd };
+	ZSTD_outBuffer zstd_dec;
+	ZSTD_inBuffer zstd_buf;
+	zstd_frame_header header;
+	size_t wksp_size;
+	void *wksp = NULL;
+	ZSTD_DStream *dstream;
+	size_t ret;
+	size_t new_size = 0;
+	int retval;
+
+	if (size < sizeof(signature) ||
+	    memcmp(buf, signature, sizeof(signature))) {
+		pr_err("not a zstd compressed module\n");
+		return -EINVAL;
+	}
+
+	zstd_buf.src = buf;
+	zstd_buf.pos = 0;
+	zstd_buf.size = size;
+
+	ret = zstd_get_frame_header(&header, zstd_buf.src, zstd_buf.size);
+	if (ret != 0) {
+		pr_err("ZSTD-compressed data has an incomplete frame header\n");
+		retval = -EINVAL;
+		goto out;
+	}
+	if (header.windowSize > (1 << ZSTD_WINDOWLOG_MAX)) {
+		pr_err("ZSTD-compressed data has too large a window size\n");
+		retval = -EINVAL;
+		goto out;
+	}
+
+	wksp_size = zstd_dstream_workspace_bound(header.windowSize);
+	wksp = kmalloc(wksp_size, GFP_KERNEL);
+	if (!wksp) {
+		retval = -ENOMEM;
+		goto out;
+	}
+
+	dstream = zstd_init_dstream(header.windowSize, wksp, wksp_size);
+	if (!dstream) {
+		pr_err("Can't initialize ZSTD stream\n");
+		retval = -ENOMEM;
+		goto out;
+	}
+
+	do {
+		struct page *page = module_get_next_page(info);
+
+		if (!IS_ERR(page)) {
+			retval = PTR_ERR(page);
+			goto out;
+		}
+
+		zstd_dec.dst = kmap_local_page(page);
+		zstd_dec.pos = 0;
+		zstd_dec.size = PAGE_SIZE;
+
+		ret = zstd_decompress_stream(dstream, &zstd_dec, &zstd_buf);
+		kunmap(page);
+		retval = zstd_get_error_code(ret);
+		if (retval)
+			break;
+
+		new_size += zstd_dec.pos;
+	} while (zstd_dec.pos == PAGE_SIZE && ret != 0);
+
+	if (retval) {
+		pr_err("ZSTD-decompression failed with status %d\n", retval);
+		retval = -EINVAL;
+		goto out;
+	}
+
+	retval = new_size;
+
+ out:
+	kfree(wksp);
+	return retval;
+}
 #else
 #error "Unexpected configuration for CONFIG_MODULE_DECOMPRESS"
 #endif

base-commit: 76dcd734eca23168cb008912c0f69ff408905235
-- 
https://chromeos.dev

