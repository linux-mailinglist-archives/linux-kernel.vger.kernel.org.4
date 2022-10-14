Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092735FF460
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiJNUOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiJNUOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:14:10 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6664101D2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:14:08 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 88-20020a17090a09e100b00208c35d9452so3051637pjo.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xSZQdVus5Bc10Nyq9KzLPWg8hzLcHTiPyHVyqpOguK4=;
        b=kD2tnNrehBli3cgB0QmimYdhfvTNc37MT2v7KLpXOBTBhb0BLBdEHaiuHQYJ9qaedM
         Wu3dyR+bDoP4WxYvgg5pmzR8h0c5XrATYiA1Rqo4u8keEfE8ZV3TEqhaHV6RL5HLtEAC
         ZT0KzCT10tTowbh0A2WW5JPaazN2RXzmLslOBUMsqxsfmWPZzW91OzdYu01JGs3+xnGo
         pQt+PsxEwOygchY3h0Ikw5gx2rEArPwKo8UqMhgDbyVMCcQXH0hTIk03Vsc3I9Kz/qfF
         JD23wKrPN3Owdyz3bAiAB4/zHJIksYkPPNqwFKz7QwFUkDE1uMfXbmizikJoE1nUgxyv
         qCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSZQdVus5Bc10Nyq9KzLPWg8hzLcHTiPyHVyqpOguK4=;
        b=nnkxhdXis5PE2tYCTib1vLt5bYJbZW7YQiPNdJo9lbZgAEswWSXRzw8gxapE6p8uIh
         gzF0V6linpAZrs2IXNeWBI/qTWyqL0GtbhN7fdEq0N5CpdLe4EmPiQ5NrLzO/uj+J0x+
         M+Gnzmzfgtxvdyb3oimXw85LvNTDYe+hOcq7ZK0h1bK2x1JPySPMyv5zpS5X24WJXRXv
         6a067wq5Sua4m6a4VJk5PcjSesPq3z81cL4XSQvU5WmnOjYdAlDaGrf13Iv7RrXyuUVH
         sAUiDCtMqF9lyiH5PyNn+tjemOX0gwyV/uj+YNETefHj+dqZUKqPaiufjk/2hb0Hh/zQ
         5MIQ==
X-Gm-Message-State: ACrzQf3DyOPKupy5ZvqbNEyuVxD0Lg62+uquFX9s/ndGNaVgC4H0EGw/
        ipTqPDJelEayCAXBDNlaDgpj2y3aMoI1ui9L1nI=
X-Google-Smtp-Source: AMsMyM73DcgZrlWR8kfVR813JbsSNHdsmxcyyERaCCsZM7LVFiONrXCBEEsLWHtBjfINZLNG+FfdH9eX3bVIyuo/8fs=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:0:100e:712:2ba5:63af:4077:4515])
 (user=ndesaulniers job=sendgmr) by 2002:a17:903:2351:b0:181:68a8:9f9c with
 SMTP id c17-20020a170903235100b0018168a89f9cmr7043437plh.115.1665778448305;
 Fri, 14 Oct 2022 13:14:08 -0700 (PDT)
Date:   Fri, 14 Oct 2022 13:13:51 -0700
In-Reply-To: <20221014201354.3190007-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20221014201354.3190007-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1665778433; l=4007;
 i=ndesaulniers@google.com; s=20220923; h=from:subject; bh=XFiK8v7Ofros3NhMcAkCbMIm1L6g9zzm1gIpb9nZops=;
 b=UCUZB8NQR1HsjQzqCH+jS/nqSRc0/wpX9vPy7Pb2Ols3E7tqNnIHUsF81BE/YEh0EcS1X2Ky6URN
 rEa2p/CSCRh53eRwp3EI5XU3oR0m7boibgTA/jRIyZ6/nsDQOts8
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221014201354.3190007-2-ndesaulniers@google.com>
Subject: [PATCH v4 1/4] ARM: remove lazy evaluation in Makefile
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch-y and tune-y used lazy evaluation since they used to contain
cc-option checks. They don't any longer, so just eagerly evaluate these
command line flags.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
No change from v3.

 arch/arm/Makefile | 60 +++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c846119c448f..8dd943b50b7d 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -63,44 +63,38 @@ KBUILD_CFLAGS	+= $(call cc-option,-fno-ipa-sra)
 # Note that GCC does not numerically define an architecture version
 # macro, but instead defines a whole series of macros which makes
 # testing for a specific architecture or later rather impossible.
-arch-$(CONFIG_CPU_32v7M)	=-D__LINUX_ARM_ARCH__=7 -march=armv7-m
-arch-$(CONFIG_CPU_32v7)		=-D__LINUX_ARM_ARCH__=7 -march=armv7-a
-arch-$(CONFIG_CPU_32v6)		=-D__LINUX_ARM_ARCH__=6 -march=armv6
-# Only override the compiler option if ARMv6. The ARMv6K extensions are
+arch-$(CONFIG_CPU_32v7M)	:=-D__LINUX_ARM_ARCH__=7 -march=armv7-m
+arch-$(CONFIG_CPU_32v7)		:=-D__LINUX_ARM_ARCH__=7 -march=armv7-a
+arch-$(CONFIG_CPU_32v6)		:=-D__LINUX_ARM_ARCH__=6 -march=armv6
+# Only override the compiler opt:ion if ARMv6. The ARMv6K extensions are
 # always available in ARMv7
 ifeq ($(CONFIG_CPU_32v6),y)
-arch-$(CONFIG_CPU_32v6K)	=-D__LINUX_ARM_ARCH__=6 -march=armv6k
+arch-$(CONFIG_CPU_32v6K)	:=-D__LINUX_ARM_ARCH__=6 -march=armv6k
 endif
-arch-$(CONFIG_CPU_32v5)		=-D__LINUX_ARM_ARCH__=5 -march=armv5te
-arch-$(CONFIG_CPU_32v4T)	=-D__LINUX_ARM_ARCH__=4 -march=armv4t
-arch-$(CONFIG_CPU_32v4)		=-D__LINUX_ARM_ARCH__=4 -march=armv4
-arch-$(CONFIG_CPU_32v3)		=-D__LINUX_ARM_ARCH__=3 -march=armv3m
-
-# Evaluate arch cc-option calls now
-arch-y := $(arch-y)
+arch-$(CONFIG_CPU_32v5)		:=-D__LINUX_ARM_ARCH__=5 -march=armv5te
+arch-$(CONFIG_CPU_32v4T)	:=-D__LINUX_ARM_ARCH__=4 -march=armv4t
+arch-$(CONFIG_CPU_32v4)		:=-D__LINUX_ARM_ARCH__=4 -march=armv4
+arch-$(CONFIG_CPU_32v3)		:=-D__LINUX_ARM_ARCH__=3 -march=armv3m
 
 # This selects how we optimise for the processor.
-tune-$(CONFIG_CPU_ARM7TDMI)	=-mtune=arm7tdmi
-tune-$(CONFIG_CPU_ARM720T)	=-mtune=arm7tdmi
-tune-$(CONFIG_CPU_ARM740T)	=-mtune=arm7tdmi
-tune-$(CONFIG_CPU_ARM9TDMI)	=-mtune=arm9tdmi
-tune-$(CONFIG_CPU_ARM940T)	=-mtune=arm9tdmi
-tune-$(CONFIG_CPU_ARM946E)	=-mtune=arm9e
-tune-$(CONFIG_CPU_ARM920T)	=-mtune=arm9tdmi
-tune-$(CONFIG_CPU_ARM922T)	=-mtune=arm9tdmi
-tune-$(CONFIG_CPU_ARM925T)	=-mtune=arm9tdmi
-tune-$(CONFIG_CPU_ARM926T)	=-mtune=arm9tdmi
-tune-$(CONFIG_CPU_FA526)	=-mtune=arm9tdmi
-tune-$(CONFIG_CPU_SA110)	=-mtune=strongarm110
-tune-$(CONFIG_CPU_SA1100)	=-mtune=strongarm1100
-tune-$(CONFIG_CPU_XSCALE)	=-mtune=xscale
-tune-$(CONFIG_CPU_XSC3)		=-mtune=xscale
-tune-$(CONFIG_CPU_FEROCEON)	=-mtune=xscale
-tune-$(CONFIG_CPU_V6)		=-mtune=arm1136j-s
-tune-$(CONFIG_CPU_V6K)		=-mtune=arm1136j-s
-
-# Evaluate tune cc-option calls now
-tune-y := $(tune-y)
+tune-$(CONFIG_CPU_ARM7TDMI)	:=-mtune=arm7tdmi
+tune-$(CONFIG_CPU_ARM720T)	:=-mtune=arm7tdmi
+tune-$(CONFIG_CPU_ARM740T)	:=-mtune=arm7tdmi
+tune-$(CONFIG_CPU_ARM9TDMI)	:=-mtune=arm9tdmi
+tune-$(CONFIG_CPU_ARM940T)	:=-mtune=arm9tdmi
+tune-$(CONFIG_CPU_ARM946E)	:=-mtune=arm9e
+tune-$(CONFIG_CPU_ARM920T)	:=-mtune=arm9tdmi
+tune-$(CONFIG_CPU_ARM922T)	:=-mtune=arm9tdmi
+tune-$(CONFIG_CPU_ARM925T)	:=-mtune=arm9tdmi
+tune-$(CONFIG_CPU_ARM926T)	:=-mtune=arm9tdmi
+tune-$(CONFIG_CPU_FA526)	:=-mtune=arm9tdmi
+tune-$(CONFIG_CPU_SA110)	:=-mtune=strongarm110
+tune-$(CONFIG_CPU_SA1100)	:=-mtune=strongarm1100
+tune-$(CONFIG_CPU_XSCALE)	:=-mtune=xscale
+tune-$(CONFIG_CPU_XSC3)		:=-mtune=xscale
+tune-$(CONFIG_CPU_FEROCEON)	:=-mtune=xscale
+tune-$(CONFIG_CPU_V6)		:=-mtune=arm1136j-s
+tune-$(CONFIG_CPU_V6K)		:=-mtune=arm1136j-s
 
 ifeq ($(CONFIG_AEABI),y)
 CFLAGS_ABI	:=-mabi=aapcs-linux -mfpu=vfp
-- 
2.38.0.413.g74048e4d9e-goog

