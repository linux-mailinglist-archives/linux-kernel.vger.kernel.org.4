Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9FA5EE36E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbiI1Rrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbiI1Rrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:47:49 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B05F6873
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:47:48 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id s9so8338528qkg.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=aA3qVwDfXk6gW3N9gfO3b8QmZQDBhWPw3YeAgQkYfwk=;
        b=Xt66a5RMHJ0ao0Cd4AzI7ZuexcX0+6IVNNW7P7uC/Xew/iC+lAk/vR31HaXK5rkLni
         SJUqJCS2D9UiHL9AVArzhPKwKZzIueHl5SZxl+geV4I8SPat50IjTEWr8EI//i9ZCrs7
         +1QB4YUQBMCHjgG+JWIS5NcqDOb1zXG/7i20OHevZ16sQkkLF0OXv15Vj3avp1+ChjQX
         8zmg25tlP4IAhT9QKEadyduEigVT/wE4cKo+h5YIkpIXq8P858DhNqfPi3rSNrCevxU7
         7RYiTdjOLQffEfsiXwhShvWmYOaSmzmlJjUlU0+Fn/f6JX6zL+9UtqowlhguFOWB8gMU
         lG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=aA3qVwDfXk6gW3N9gfO3b8QmZQDBhWPw3YeAgQkYfwk=;
        b=h7CXp36bvUVi/NwZ6MBG/0gUoiAK0f3/QczV6QIo2/4Gl74hjzO7LPnFKxBbw2yBff
         1kPTnEqQ+ovpuK1rk0axo/VSHy/sE7HwqrxdMilAYg5EKlixfdVt73rwwgvNJtzdUZoA
         rePVDGkRVn6JfOA0Hxwln9ufj3NMUgASRw6sddhHsHdVCyZOezPC22za+cSjNcFRvE2S
         nGSnKCqoh+G8IYXIMxV1C03n4RrfQwbhymPlenjAgkMlbMORJ7Riv/+DZxUu0l12CVEG
         CXVdz6aIa628NBj3HNiVPhZ6ILwnU+trRwr0uUR2fYNeffqzL0QUfOEs2AQYX5rsMGSV
         aG9g==
X-Gm-Message-State: ACrzQf0gerqx8cmhvMrLdkqWsKZ30DXc6pUXilJvHnjJ2esxnxQ3XXT4
        6ctFhRm35w2o7C8xHwOsWUo=
X-Google-Smtp-Source: AMsMyM6xP437moLPf6m7CNUHbTWnkEWBM8cY6GdSmMeceQYwjFhYL9mh+tPZDb+xpl1HrLBR7f6v5w==
X-Received: by 2002:a05:620a:458a:b0:6ce:be36:a1f8 with SMTP id bp10-20020a05620a458a00b006cebe36a1f8mr22643075qkb.525.1664387267896;
        Wed, 28 Sep 2022 10:47:47 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bl18-20020a05620a1a9200b006ce30a5f892sm3375945qkb.102.2022.09.28.10.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 10:47:47 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Seung-Woo Kim <sw0312.kim@samsung.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        John Crispin <john@phrozen.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <n.schier@avm.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org (open list),
        bcm-kernel-feedback-list@broadcom.com, anand.gore@broadcom.com,
        william.zhang@broadcom.com
Subject: [PATCH] ARM: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
Date:   Wed, 28 Sep 2022 10:47:39 -0700
Message-Id: <20220928174739.802806-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Seung-Woo Kim <sw0312.kim@samsung.com>

To enable UBSAN on ARM, this patch enables ARCH_HAS_UBSAN_SANITIZE_ALL
from arm confiuration. Basic kernel bootup test is passed on arm with
CONFIG_UBSAN_SANITIZE_ALL enabled.

Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
[florian: rebased against v6.0-rc7]
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/Kconfig                  | 1 +
 arch/arm/boot/compressed/Makefile | 1 +
 arch/arm/vdso/Makefile            | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 87badeae3181..c90aa58eab7f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -27,6 +27,7 @@ config ARM
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if CPU_V7 || CPU_V7M || CPU_V6K
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_KEEP_MEMBLOCK
+	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_NO_SG_CHAIN if !ARM_HAS_SG_CHAIN
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 41bcbb460fac..2cc2af13779e 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -27,6 +27,7 @@ KASAN_SANITIZE		:= n
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
 KCOV_INSTRUMENT		:= n
+UBSAN_SANITIZE		:= n
 
 #
 # Architecture dependencies
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index 8ca1c9f262a2..a7ec06ce3785 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -37,6 +37,7 @@ endif
 
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
+UBSAN_SANITIZE := n
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
 KCOV_INSTRUMENT := n
-- 
2.25.1

