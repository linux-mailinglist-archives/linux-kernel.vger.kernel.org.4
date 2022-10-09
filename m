Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DAB5F8A48
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 11:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiJIJIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 05:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiJIJHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 05:07:55 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173B131346
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 02:07:41 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x6so8034539pll.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 02:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cZ+puyQMSIB+n8E0d97j6XHSOdtq59YpKkyki1VJU8=;
        b=EgKwRSilPm7p4CO1u8/fIzwBKtIVXSWTmIsbJOKy4/04UduO4fKhE+2bWFSK6PWTy7
         MUs1CmVg66IhdIP7LBiQ3/atcqWn26lPXRjdKFSnnEXRcmOc+F9INsSAneuaKX1eiKEB
         7yEG45dA0ijTgitSeK72Gyqzf24vDXZ6hjyLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cZ+puyQMSIB+n8E0d97j6XHSOdtq59YpKkyki1VJU8=;
        b=VkTA0F/pm6fzfJt55GuLAFkuzgKtLPJBEC44npohhPPt+QCE2RqIPrNViCSNQsBZgh
         sLxWynGARCaT0GJl4LsY8q9r0IoPFNj0Xz6ODxaYVmZgfyW4cIF4m/qzP+oZsAIrBj6H
         lW5ZpxRtA5xecushkETxV1efJ6mTJo89p2VKCMGRyJHQZFvVlG5GDgdAAcoiXrkqP6gA
         022Z0J6fdCOog4ZNRYXHneOp2yEVuJQvbTBxqvgz+X0c12cO16QEhRPi2Ez9Rl7Lq2qs
         7J3xZjDD+cO8Qrvo2upU95sE61wUUaNo0t2LDqygrW3UZ8vtT1bPL1+2CgJyu3RmLCkE
         JW1A==
X-Gm-Message-State: ACrzQf1VRXAnsgqKUKIw19sqgr3V+8XXAJgs+VkYA0isjmPM51NaQnu4
        Kvn4HyWTKNOaNwL5+7A1b/V/GnlFvQHanw==
X-Google-Smtp-Source: AMsMyM6wBamnMbzu7YlLUOWaIL8i996NZuN+u1yUYf1GbwAo3RpqMwn47tLv84VDFkbJMphI+eG9ag==
X-Received: by 2002:a17:902:ec83:b0:17c:afb3:d1ec with SMTP id x3-20020a170902ec8300b0017cafb3d1ecmr13185807plg.172.1665306461306;
        Sun, 09 Oct 2022 02:07:41 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:8517:d51e:5fe9:9be7])
        by smtp.gmail.com with ESMTPSA id q194-20020a632acb000000b00439d071c110sm4335148pgq.43.2022.10.09.02.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 02:07:41 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 6/8] zram: Add recompression algorithm choice to Kconfig
Date:   Sun,  9 Oct 2022 18:07:18 +0900
Message-Id: <20221009090720.1040633-7-senozhatsky@chromium.org>
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
index 143c33bd6783..7285a85b4054 100644
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

