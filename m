Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52E1602390
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 06:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiJRE4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 00:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiJRE4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 00:56:01 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CF4A02C0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 21:55:57 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e129so12315121pgc.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 21:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6FdlTaAeoJZnsdClOVvKEq4lJg+XPWe1oKWdw8/hCk=;
        b=mGht8IGExOGxSDdSigMACLR7r+oqEPBhqmdFZwzcCZbnhwEIwDlx8IUzwUJ2oNN4mf
         yI7zRshfGlUr4VjyEIYcQm9A+xqAcUqq0SHRcig+dl2PYPG/RiYazZ4zPKWAYc9FFzju
         6vDXIdBf+phqB93FKQYUwUmhyALJr9U293+wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6FdlTaAeoJZnsdClOVvKEq4lJg+XPWe1oKWdw8/hCk=;
        b=6q00BR2suOJifYFsWMFM8Ktm96gW+5lpXiIbbwxd0K2sD9md9r4uSadVMg53o+VO0a
         0OoCYOASM3a6DmnFEtbmYB56I9mwYwhiVSFBANOh87u58VUKfI0YnAVv8ClEe7aFxwOI
         Lb9eOYGlmWy5PVWbzuCIUlkQzyyQpx0/hN71zw2AaUfYLj18ie50SMO4StXF02DNrE5H
         66gLAp1Q+En+mLUEnxJC4796D9PGN7hOQXW4zF4zZ3PwoXEhD3piVVYjoHclN5yOLWOr
         XsL9igpexD13c9WZJqVYYKqj1mHdW8fcGJZY0UICWCEfx4+f6aZ5+bq4NMF+VXrYFDPF
         wKpA==
X-Gm-Message-State: ACrzQf1OXPOxNgE49vD8qgkapKcIZAfiBuwDOrvQnj3QQM5kOcVZLypD
        YLonoAV+cYX53SkTwyESHvVRnw==
X-Google-Smtp-Source: AMsMyM6g/QL3RczfjsbLh8zvYrP191iu/ZlPb5PzgxBWDVBC98pOVFGn60QYUSh3PKf4EuHzV0UVLw==
X-Received: by 2002:a05:6a00:1ad0:b0:564:a791:42dc with SMTP id f16-20020a056a001ad000b00564a79142dcmr1116320pfv.50.1666068956740;
        Mon, 17 Oct 2022 21:55:56 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:17a9:73b0:c262:eccd])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b0017b69f99321sm7549220plf.219.2022.10.17.21.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:55:56 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 6/9] zram: Add recompression algorithm choice to Kconfig
Date:   Tue, 18 Oct 2022 13:55:30 +0900
Message-Id: <20221018045533.2396670-7-senozhatsky@chromium.org>
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

Make (secondary) recompression algorithm selectable just like
we do it for the (primary) default one.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig    | 40 +++++++++++++++++++++++++++++++++++
 drivers/block/zram/zram_drv.c |  2 +-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 3e00656a6f8a..076a76cd1664 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -93,3 +93,43 @@ config ZRAM_MULTI_COMP
 
 	SIZE (in bytes) parameter sets the object size watermark: idle
 	objects that are of a smaller size will not get recompressed.
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
index da11560ecf70..1e9561217466 100644
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
2.38.0.413.g74048e4d9e-goog

