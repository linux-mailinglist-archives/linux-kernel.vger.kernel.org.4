Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29016055EC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 05:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJTDZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 23:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiJTDY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 23:24:58 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3900342D6B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 20:24:56 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id n130so21481722oia.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 20:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OczjChBmGkUsoBfYt2005Z8T2ggpJvwmMFUd3PcsLKA=;
        b=Tc1hvzFMF23lt+BFLnxI7WX4sMpYoLkFxJzxHhJETh1MSfcQuJmAP341e2KQwFTJsJ
         EmLReN2GxQD4lz92lcUHSQnuNWQr+mBaXao4mrC+eJMAnpohWbG/2WgPmvzOzZWHP9wH
         6y5TEKgsLspmLNtSj9KNcWSRSj7Z8e8+O1Mq6mXoC8pfEJhSTLc1v96I+wIo4/qn6tsh
         Y/p71MWFrA/EB1d1oVFjdb10h2jTvoId9QBa67aCSbWtUNWbJSY/syidxU0LOd2jj0qi
         Z7ElXW8pg1UF7dTM0vhyEWbpSjd3/yZWoC4ApPo5xsHPCego3IonNbj+cWRTaZVgR0tl
         1sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OczjChBmGkUsoBfYt2005Z8T2ggpJvwmMFUd3PcsLKA=;
        b=t/9fn/lelGXNp8Kx6fe72kmoDF/cPzlAVKtE6qlcfB9WwBfytNauvxCfJzXmef+Yiy
         Z6+5xGv7KNRT/SMF5Y6F1P0zBkKuRZ5+O+BRhtuZU9Lyqw8pVSV3aBsVx21oegUhLj/L
         sHALfVSmnMV/7e7BsDJNF2TyO1G84gba6Jl5CL+NvjYqb+9pqJSwHI/52Pen7u8YsB+G
         77KqbfvjSdd+HmftQUjikxNdE8qDYyY7eGRzbSc9EllMiJcSWIDC7KHIsaue53pOfdyF
         B0UMs8drQsZd1Dh8B+reUhFJarxRTg3F8362hP0UI3E9uZFBs2yPWGwD8nUWqp4DjZwa
         rSMg==
X-Gm-Message-State: ACrzQf1fpYLH942fsUz8t/7cC8yzwjG3NuhYxzMKO0CSUUxg6LHiWDK8
        4QOwkjCNPyiKPXpj/L4YElY=
X-Google-Smtp-Source: AMsMyM4YQSPRdBzk2mRZPiUYN065g9bPt1mlN95Zv1RoRTX0R7OQlWZ+UIEQbpb+X8hjxt3dEjGzog==
X-Received: by 2002:aca:df8b:0:b0:350:e9a8:1627 with SMTP id w133-20020acadf8b000000b00350e9a81627mr20314745oig.68.1666236295217;
        Wed, 19 Oct 2022 20:24:55 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id y3-20020a056870418300b0011f400edb17sm8450627oac.4.2022.10.19.20.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 20:24:54 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 1/2] bitmap: add sanity check function for find_bit()
Date:   Wed, 19 Oct 2022 20:20:23 -0700
Message-Id: <20221020032024.1804535-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221020032024.1804535-1-yury.norov@gmail.com>
References: <20221020032024.1804535-1-yury.norov@gmail.com>
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

find_bit() requires a pointer aligned to it's size. However some
subsystems (fs, for example) cast char* variables to unsigned long*
before passing them to find_bit(). Many architectures allow unaligned
pointers with the cost of performance degradation.

This patch adds runtime check for the pointers to be aligned.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/find.h | 35 +++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug    |  7 +++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/find.h b/include/linux/find.h
index ccaf61a0f5fd..2d8f5419d787 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -7,6 +7,7 @@
 #endif
 
 #include <linux/bitops.h>
+#include <linux/bug.h>
 
 unsigned long _find_next_bit(const unsigned long *addr1, unsigned long nbits,
 				unsigned long start);
@@ -35,6 +36,14 @@ unsigned long _find_next_bit_le(const unsigned long *addr, unsigned
 				long size, unsigned long offset);
 #endif
 
+static __always_inline
+void check_find_bit(const unsigned long *addr)
+{
+#ifdef CONFIG_DEBUG_BITMAP
+	WARN_ON_ONCE(!IS_ALIGNED((unsigned long)addr, sizeof(unsigned long)));
+#endif
+}
+
 #ifndef find_next_bit
 /**
  * find_next_bit - find the next set bit in a memory region
@@ -49,6 +58,8 @@ static inline
 unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 			    unsigned long offset)
 {
+	check_find_bit(addr);
+
 	if (small_const_nbits(size)) {
 		unsigned long val;
 
@@ -79,6 +90,9 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long size,
 		unsigned long offset)
 {
+	check_find_bit(addr1);
+	check_find_bit(addr2);
+
 	if (small_const_nbits(size)) {
 		unsigned long val;
 
@@ -138,6 +152,8 @@ static inline
 unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 				 unsigned long offset)
 {
+	check_find_bit(addr);
+
 	if (small_const_nbits(size)) {
 		unsigned long val;
 
@@ -164,6 +180,8 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 static inline
 unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
 {
+	check_find_bit(addr);
+
 	if (small_const_nbits(size)) {
 		unsigned long val = *addr & GENMASK(size - 1, 0);
 
@@ -270,6 +288,9 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
 				 const unsigned long *addr2,
 				 unsigned long size)
 {
+	check_find_bit(addr1);
+	check_find_bit(addr2);
+
 	if (small_const_nbits(size)) {
 		unsigned long val = *addr1 & *addr2 & GENMASK(size - 1, 0);
 
@@ -292,6 +313,8 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
 static inline
 unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 {
+	check_find_bit(addr);
+
 	if (small_const_nbits(size)) {
 		unsigned long val = *addr | ~GENMASK(size - 1, 0);
 
@@ -313,6 +336,8 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 static inline
 unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
 {
+	check_find_bit(addr);
+
 	if (small_const_nbits(size)) {
 		unsigned long val = *addr & GENMASK(size - 1, 0);
 
@@ -417,18 +442,24 @@ extern unsigned long find_next_clump8(unsigned long *clump,
 static inline unsigned long find_next_zero_bit_le(const void *addr,
 		unsigned long size, unsigned long offset)
 {
+	check_find_bit(addr);
+
 	return find_next_zero_bit(addr, size, offset);
 }
 
 static inline unsigned long find_next_bit_le(const void *addr,
 		unsigned long size, unsigned long offset)
 {
+	check_find_bit(addr);
+
 	return find_next_bit(addr, size, offset);
 }
 
 static inline unsigned long find_first_zero_bit_le(const void *addr,
 		unsigned long size)
 {
+	check_find_bit(addr);
+
 	return find_first_zero_bit(addr, size);
 }
 
@@ -439,6 +470,8 @@ static inline
 unsigned long find_next_zero_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
 {
+	check_find_bit(addr);
+
 	if (small_const_nbits(size)) {
 		unsigned long val = *(const unsigned long *)addr;
 
@@ -472,6 +505,8 @@ static inline
 unsigned long find_next_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
 {
+	check_find_bit(addr);
+
 	if (small_const_nbits(size)) {
 		unsigned long val = *(const unsigned long *)addr;
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3fc7abffc7aa..1c7dcd33fc2a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -543,6 +543,13 @@ endmenu # "Compiler options"
 
 menu "Generic Kernel Debugging Instruments"
 
+config DEBUG_BITMAP
+       bool "Debug bitmaps"
+       help
+         Say Y here if you want to check bitmap functions parameters at
+         the runtime. Enable CONFIG_DEBUG_BITMAP only for debugging because
+         it may affect performance.
+
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
 	depends on !UML
-- 
2.34.1

