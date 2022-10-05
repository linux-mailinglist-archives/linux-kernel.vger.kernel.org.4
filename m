Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E1A5F4DD7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 04:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiJEClM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 22:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJECkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 22:40:51 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3FB726B0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 19:40:38 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 8-20020a17090a0b8800b00205d8564b11so538713pjr.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 19:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XWoWvn6QLYmkZfKsLskYp8R1UWJ07QB0khsqO1xI030=;
        b=j9KV+AyeW0jwezvi5/7/uJWlhOJi/pvUDSLhxR2V+HoNvgDu2rKXYpM/RnnkoJ1D3r
         2feDyqGE61vObJ5SyznPn+z9BypLv8OcLdJiHqiobO2nXUfYZ2ulMO00MrxBOUET2b7L
         7JirWhoT/PetJ3qKcOXBnlXsKhCJe0WXcJqiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XWoWvn6QLYmkZfKsLskYp8R1UWJ07QB0khsqO1xI030=;
        b=WYpvfoAB9rstlbkTivFj4ScUnZD56jggVIYuhGiHHCfwXat/WmsRe439h2jVrw/0Gv
         0FP0vrUs2k3aO6nk/OlOsYLwrLSGkYI5IC/0c8FhQmpNTuibXf+9uv3UWhm+S6bar9uZ
         eSoZmej76frKBbPlW0REmoWG0EQxgEoOlXngt7V3NPVADtR9cbyoRMvJJOLwPT6AWsGw
         rI9MBVamILdFoW+1Hui08JsZnjxIsZDz9mVnnrK6py97xnk98jkXjuw8Prcs8YDpXNGk
         OBSuZG66XJWpKhJP77Lhhdaa08KJpMaKXn/jD2g+UCctZf5FbRqggt4F8X8qZDHwlAv5
         sZAQ==
X-Gm-Message-State: ACrzQf3Gz9g2sMyi2o+v5o7IQGn2FTQkcE5/Cx6cuYSUmHX0LhwamXBy
        B0fDGV7r7W2XzUmZ1QMfabF3teS3AYm80g==
X-Google-Smtp-Source: AMsMyM7sTr5/lG0VbDXKXmsnvqJ4QLG7VodsT4AHL9ItMxEzciwN7QsvDq5BXnvrwAaOhOdYV7NqTg==
X-Received: by 2002:a17:903:2684:b0:17b:7568:ffea with SMTP id jf4-20020a170903268400b0017b7568ffeamr29040217plb.128.1664937637205;
        Tue, 04 Oct 2022 19:40:37 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:a9d9:6396:ee12:8be8])
        by smtp.gmail.com with ESMTPSA id a14-20020aa794ae000000b00561e010a309sm1673579pfl.19.2022.10.04.19.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 19:40:36 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 6/8] zram: Add recompression algorithm choice to Kconfig
Date:   Wed,  5 Oct 2022 11:40:12 +0900
Message-Id: <20221005024014.22914-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221005024014.22914-1-senozhatsky@chromium.org>
References: <20221005024014.22914-1-senozhatsky@chromium.org>
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

Make (secondary) recompression algorithm selectable just like
we do it for the (primary) default one.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig    | 40 +++++++++++++++++++++++++++++++++++
 drivers/block/zram/zram_drv.c |  2 +-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 7febf36e93eb..442885ac72ca 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -90,3 +90,43 @@ config ZRAM_MULTI_COMP
 
           echo TIMEOUT > /sys/block/zramX/idle
           echo SIZE > /sys/block/zramX/recompress
+
+choice
+	prompt "Default zram recompression algorithm"
+	default ZRAM_DEF_RECOMP_ZSTD
+	depends on ZRAM && ZRAM_MULTI_COMP
+
+config ZRAM_DEF_RECOMP_LZORLE
+	bool "lzo-rle"
+	depends on CRYPTO_LZO
+
+config ZRAM_DEF_RECOMP_ZSTD
+	bool "zstd"
+	depends on CRYPTO_ZSTD
+
+config ZRAM_DEF_RECOMP_LZ4
+	bool "lz4"
+	depends on CRYPTO_LZ4
+
+config ZRAM_DEF_RECOMP_LZO
+	bool "lzo"
+	depends on CRYPTO_LZO
+
+config ZRAM_DEF_RECOMP_LZ4HC
+	bool "lz4hc"
+	depends on CRYPTO_LZ4HC
+
+config ZRAM_DEF_RECOMP_842
+	bool "842"
+	depends on CRYPTO_842
+
+endchoice
+
+config ZRAM_DEF_RECOMP
+	string
+	default "lzo-rle" if ZRAM_DEF_RECOMP_LZORLE
+	default "zstd" if ZRAM_DEF_RECOMP_ZSTD
+	default "lz4" if ZRAM_DEF_RECOMP_LZ4
+	default "lzo" if ZRAM_DEF_RECOMP_LZO
+	default "lz4hc" if ZRAM_DEF_RECOMP_LZ4HC
+	default "842" if ZRAM_DEF_RECOMP_842
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 077a0bc60b8d..75fc89de21e3 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -44,7 +44,7 @@ static int zram_major;
 static const char *default_comp_algs[ZRAM_MAX_ZCOMPS] = {
 	CONFIG_ZRAM_DEF_COMP,
 #ifdef CONFIG_ZRAM_MULTI_COMP
-	"zstd",
+	CONFIG_ZRAM_DEF_RECOMP,
 #endif
 };
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

