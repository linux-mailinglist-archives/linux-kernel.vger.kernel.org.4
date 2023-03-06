Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB9D6AB4DB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 04:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjCFDEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 22:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCFDEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 22:04:06 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB8E9757
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 19:03:52 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id oj5so8370807pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 19:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678071832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uajbUQnIewe2JrUK08Rp36GBFla2nyzidVlnhov4v/M=;
        b=WZrdj+Isk4V/hOXFfckOgIgGy2pe/UdwvvkYcjTx/ES3KpvHXYilLIihzQhVPAkbWK
         lRifRyBwzy0RYLjGmoSGWipsoXivSfkd9bF9QBKrG78Wg/xlcl5BTzQov+qetNjMIlxZ
         AFTwx1JskAjmAv824RVbHx5NE8menYuABnFqROV9p/yVqcha8fdwsZjGqSQGzfHCM7kp
         W8kjUxAmlWqI0aQsNB7ixF0CFaB3WxCH8HAkPk7p22i0bWO9wSoXtCp7ISf1Wosqf9MS
         8keWuJWbTGBuk5y9Dvf96qEB16dNVJEFH4c48AELbRLjqOBB5xM/HIMaV/BC2xwUlkaM
         Ur9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678071832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uajbUQnIewe2JrUK08Rp36GBFla2nyzidVlnhov4v/M=;
        b=4yxjt45fQHNC3BaOKk6qy37vZ8p6ockI7vEhoIxjBXwKCV0DmvtmqOXh5kpFnYJjXZ
         LUxuixTZrfrFJ05HLBbVIz504N3XbKg0IXQPun9jBN7do9joIEyWDBZlLrQ2O+D69A3z
         RgM/egEDqt/a1k6h2bH61UpPH6BcoyMhXZfRPwLeMfImA8iOVafRL8mbpynCSN4hMdLd
         N9hwVEdxNLktul1cvRGoTsHM/eM4Y92fOLoJQamxfk4XxAWhzwGjq9S1TOrOutTScIvW
         +T9dpm7HyOOuXrFY3c2PxNTfuOIdiZgxNlG/TKA6thD9PvBmxTEU2fn42fCe9dC+t12D
         JQQA==
X-Gm-Message-State: AO0yUKWP8Z+NtngYI8MKjs411K4Q5b9nusO1uVvzp0lssQXxW60Z/TYf
        C6oL4Ak6gDoaINxSo6o9OQ==
X-Google-Smtp-Source: AK7set8hmMUrNWIc99n8GyLvy/rglRTI9XgR+b/60jnclG8T/yq3ZeWruKe+7SgPeOeOv8u/sIa7qA==
X-Received: by 2002:a17:903:244c:b0:19e:3b41:1828 with SMTP id l12-20020a170903244c00b0019e3b411828mr10432774pls.22.1678071832295;
        Sun, 05 Mar 2023 19:03:52 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id jy16-20020a17090342d000b0019719f752c5sm5410439plb.59.2023.03.05.19.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 19:03:51 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, kexec@lists.infradead.org
Subject: [PATCH 6/6] init/Kconfig: Select decompressing method if compressing kernel
Date:   Mon,  6 Mar 2023 11:03:05 +0800
Message-Id: <20230306030305.15595-7-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306030305.15595-1-kernelfans@gmail.com>
References: <20230306030305.15595-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If choosing an EFI_ZBOOT image, the corresponding decompressing method
should be selected so that kexec can load that zboot image.

This can be achieved when "Kernel compression mode" is determined.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: kexec@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 init/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 44e90b28a30f..046724208645 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -269,6 +269,7 @@ choice
 config KERNEL_GZIP
 	bool "Gzip"
 	depends on HAVE_KERNEL_GZIP
+	select KEXEC_DECOMPRESS_GZIP if KEXEC_FILE && EFI_ZBOOT
 	help
 	  The old and tried gzip compression. It provides a good balance
 	  between compression ratio and decompression speed.
@@ -276,6 +277,7 @@ config KERNEL_GZIP
 config KERNEL_BZIP2
 	bool "Bzip2"
 	depends on HAVE_KERNEL_BZIP2
+	select KEXEC_DECOMPRESS_BZIP2 if KEXEC_FILE && EFI_ZBOOT
 	help
 	  Its compression ratio and speed is intermediate.
 	  Decompression speed is slowest among the choices.  The kernel
@@ -286,6 +288,7 @@ config KERNEL_BZIP2
 config KERNEL_LZMA
 	bool "LZMA"
 	depends on HAVE_KERNEL_LZMA
+	select KEXEC_DECOMPRESS_LZMA if KEXEC_FILE && EFI_ZBOOT
 	help
 	  This compression algorithm's ratio is best.  Decompression speed
 	  is between gzip and bzip2.  Compression is slowest.
@@ -294,6 +297,7 @@ config KERNEL_LZMA
 config KERNEL_XZ
 	bool "XZ"
 	depends on HAVE_KERNEL_XZ
+	select KEXEC_DECOMPRESS_XZ if KEXEC_FILE && EFI_ZBOOT
 	help
 	  XZ uses the LZMA2 algorithm and instruction set specific
 	  BCJ filters which can improve compression ratio of executable
@@ -309,6 +313,7 @@ config KERNEL_XZ
 config KERNEL_LZO
 	bool "LZO"
 	depends on HAVE_KERNEL_LZO
+	select KEXEC_DECOMPRESS_LZO if KEXEC_FILE && EFI_ZBOOT
 	help
 	  Its compression ratio is the poorest among the choices. The kernel
 	  size is about 10% bigger than gzip; however its speed
@@ -317,6 +322,7 @@ config KERNEL_LZO
 config KERNEL_LZ4
 	bool "LZ4"
 	depends on HAVE_KERNEL_LZ4
+	select KEXEC_DECOMPRESS_LZ4 if KEXEC_FILE && EFI_ZBOOT
 	help
 	  LZ4 is an LZ77-type compressor with a fixed, byte-oriented encoding.
 	  A preliminary version of LZ4 de/compression tool is available at
@@ -329,6 +335,7 @@ config KERNEL_LZ4
 config KERNEL_ZSTD
 	bool "ZSTD"
 	depends on HAVE_KERNEL_ZSTD
+	select KEXEC_DECOMPRESS_ZSTD if KEXEC_FILE && EFI_ZBOOT
 	help
 	  ZSTD is a compression algorithm targeting intermediate compression
 	  with fast decompression speed. It will compress better than GZIP and
-- 
2.31.1

