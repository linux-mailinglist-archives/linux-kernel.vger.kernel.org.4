Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543486EAB2A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjDUNCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjDUNB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:01:59 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7434E139
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 06:01:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4ec817735a7so1621736e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 06:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682082115; x=1684674115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2+pWrcmsJUX8U6gG47Cy8fz3Wshzrb7IqPV8c+anomU=;
        b=yKE17/lzivMJk61HwSk2EqY4iWCRK1T8NXenmV6C6bSY0NM3mB/nf+31qChrFoFszg
         07cNFN1c8X5MSC1CaN7fL+RlFflAPQoGGw1ptclfPydQBGzueBKQvVYIvZ/Rk8rZVr5G
         xsWY66ijl6krJ1w/cbbUsV+cw+BdKiZ2kzi3nZc6P25Fm/lEufU96f73kv0wva756fO3
         ECMRLCiZU6dWP9UlCkSsu5hhJC8nsLy47n3EJFp0kJs1nribgKts+erNkoQeYjYrBQEu
         myfi/dGW47jn+Ck1nE2cCSZva2KUPlz3mI4E7NPIgpILRZfBCcBHcwNe0nTzn+xJfdjp
         /jxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682082115; x=1684674115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+pWrcmsJUX8U6gG47Cy8fz3Wshzrb7IqPV8c+anomU=;
        b=l1suZvDGwXVlNvYRR3jbZvR4/ZWSWo8N0pGiIDJ2ki1U2xmQR+mktA0uA/oxGVG8fd
         UVztjztsMULkmPYemjlpkXB8jg71f1CjtdeaMQpmJZG7XtxRrP/mGTOC5OxWrGe3B4XL
         blz2/7nkDEtN/2dVdJu+4287Jir+YAmWR/nIHOMaWa1EfPxwYVJPbgDq9+CEUdDCHoc8
         RPWCLcS9+XgrQ9VPfrmB9GxzyFzfGNtRWnw6DxIicBh3dNubwbhnuCCvCCAGC08K2l3I
         omZq4fHQEBSgiPMRCx2/A26NwE2hAFRTsEHHzl9cvd5sDHG07HRJum9vfhud4CIRW9Pp
         W+NQ==
X-Gm-Message-State: AAQBX9c/7iU0ahEs52w47zgvXDtC4EGGKPwglHMLq6j4urFfIyo34S2/
        iVavsBMvuc8L40mck1pySxq84g==
X-Google-Smtp-Source: AKy350a8bqdgRrM6tQZzeOHfajjyD8LhZPR6WtO2lESmG4CApYidT2Meawa9DvC56LrLN7sIUiRuPg==
X-Received: by 2002:ac2:5ddc:0:b0:4e0:b407:fdf4 with SMTP id x28-20020ac25ddc000000b004e0b407fdf4mr1180562lfq.37.1682082114673;
        Fri, 21 Apr 2023 06:01:54 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id y14-20020ac2446e000000b004edb2620375sm552906lfl.283.2023.04.21.06.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 06:01:54 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        akpm@linux-foundation.org
Cc:     arnd@arndb.de, joneslee@google.com, peterz@infradead.org,
        keescook@chromium.org, jpoimboe@kernel.org,
        zhaoyang.huang@unisoc.com, liam.howlett@oracle.com,
        rdunlap@infradead.org, geert+renesas@glider.be,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        broonie@kernel.org, dvyukov@google.com, nogikh@google.com,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] Kconfig.debug: disable CONFIG_FRAME_WARN for KASAN_STACK && CC_IS_CLANG by default
Date:   Fri, 21 Apr 2023 13:01:11 +0000
Message-ID: <20230421130111.4041641-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with clang-15 a x86_64_defconfig kernel were CONFIG_KASAN
and CONFIG_KASAN_STACK are enabled resulted in the following errors:

drivers/block/loop.c:1531:12: error: stack frame size (2616) exceeds limit (2048) in 'lo_ioctl'
drivers/gpu/drm/i915/gt/intel_workarounds.c:964:6: error: stack frame size (3032) exceeds limit (2048) in 'intel_engine_init_ctx_wa'
drivers/gpu/drm/i915/gt/intel_workarounds.c:1818:6: error: stack frame size (5496) exceeds limit (2048) in 'intel_gt_init_workarounds'
drivers/gpu/drm/i915/gt/intel_workarounds.c:3153:6: error: stack frame size (5848) exceeds limit (2048) in 'intel_engine_init_workarounds'
drivers/usb/core/devio.c:2801:13: error: stack frame size (2104) exceeds limit (2048) in 'usbdev_ioctl'

With Clang, stack instrumentation has a problem that causes excessive
stack usage, see https://bugs.llvm.org/show_bug.cgi?id=38809.
KASAN_STACK with clang is deemed unsafe and disabled when
compile-testing. However when !COMPILE_TEST the errors are hit because
CONFIG_FRAME_WARN is not disabled.

Looking into the errors, they are indeed caused by compiling with clang
and KASAN_STACK enabled. I determined KASAN_STACK's bloat by lowering
the CONFIG_FRAME_WARN limit. Thus when KASAN and KASAN_STACK are
disabled the same stack frames have the following sizes:

drivers/block/loop.c:1531:12: error: stack frame size (528) exceeds limit (50) in 'lo_ioctl'
drivers/gpu/drm/i915/gt/intel_workarounds.c:964:6: error: stack frame size (72) exceeds limit (50) in 'intel_engine_init_ctx_wa'
drivers/gpu/drm/i915/gt/intel_workarounds.c:1818:6: error: stack frame size (104) exceeds limit (50) in 'intel_gt_init_workarounds'
drivers/gpu/drm/i915/gt/intel_workarounds.c:3153:6: error: stack frame size (88) exceeds limit (50) in 'intel_engine_init_workarounds'
drivers/usb/core/devio.c:2801:13: error: stack frame size (416) exceeds limit (50) in 'usbdev_ioctl'

When KASAN is enabled and KASAN_STACK is disabled the same stack frames
have the following sizes:

drivers/block/loop.c:1531:12: error: stack frame size (600) exceeds limit (50) in 'lo_ioctl'
drivers/gpu/drm/i915/gt/intel_workarounds.c:964:6: error: stack frame size (120) exceeds limit (50) in 'intel_engine_init_ctx_wa'
drivers/gpu/drm/i915/gt/intel_workarounds.c:1818:6: error: stack frame size (136) exceeds limit (50) in 'intel_gt_init_workarounds'
drivers/gpu/drm/i915/gt/intel_workarounds.c:3153:6: error: stack frame size (128) exceeds limit (50) in 'intel_engine_init_workarounds'
drivers/usb/core/devio.c:2801:13: error: stack frame size (480) exceeds limit (50) in 'usbdev_ioctl'

The conclusion is that when KASAN is enabled the stack usage increases a
bit, but nothing unmanageable ~30-70 bytes, whereas when enabling
KASAN_STACK the stack usage is excessive, from ~1.7K to ~5.8K for these
cases.

Disable CONFIG_FRAME_WARN for KASAN_STACK && CC_IS_CLANG by default.
Adventurers can still override the default value by input prompt or
explicit values in defconfigs in case they feel that some real warnings
are missed.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 lib/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 39d1d93164bd..c5e8b76737af 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -430,6 +430,7 @@ config FRAME_WARN
 	int "Warn for stack frames larger than"
 	range 0 8192
 	default 0 if KMSAN
+	default 0 if KASAN_STACK && CC_IS_CLANG
 	default 2048 if GCC_PLUGIN_LATENT_ENTROPY
 	default 2048 if PARISC
 	default 1536 if (!64BIT && XTENSA)
-- 
2.40.0.634.g4ca3ef3211-goog

