Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5C868DDB4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjBGQOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjBGQOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:14:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C164E055
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:13:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 77F46CE1DFA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 16:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49F3C433D2;
        Tue,  7 Feb 2023 16:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675786433;
        bh=DQ1CJxcjsi3b+zqgaRiU3Jl5v/BM3ICCZKlhKghFh0M=;
        h=From:To:Cc:Subject:Date:From;
        b=DE3g6e+J+twxY5iQXeiCiS+916bB/3gIK508QO16HKNA9TOuv0k/FRrTm7HPd0ktF
         r70sg7p3xeFPTV15xJDQPZDPq+HHpmLHcCxRq/9gb9IMRf8oGiUWG/G0O4px2hTJqW
         J6aQjfA6tsc2SlQkawRpi9+vdao8xyLmKUP7+v44ztj7clMM4hw+1f6QsD/LzPE5MH
         6Eibdp9yNk/kfLNMzfefvhpoO4qoaO2h6HQKwCUVFCB/lB03RH8JUmSKvegtZtUVcl
         MltwtVrcGh/Rvth5lCojNAf0jARdFgRjn1kuBDV5CfPK5Ds/Y5xMqd06HrPQr4uDfE
         sxffkOhc8VIuw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] x86: vdso: sanitize asm helpers for vgetcpu.c
Date:   Tue,  7 Feb 2023 17:13:41 +0100
Message-Id: <20230207161349.309901-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The x86 vdso implementation includes a few include/linux/*.h kernel
headers outside of the include/vdso/*.h space.  This causes a new
warning when building with clang, after the vgetcpu code is added
to the vdso32 support on 64-bit kernels:

In file included from arch/x86/entry/vdso/vdso32/vgetcpu.c:2:
In file included from arch/x86/entry/vdso/vdso32/../vgetcpu.c:8:
In file included from include/linux/kernel.h:22:
In file included from include/linux/bitops.h:68:
In file included from arch/x86/include/asm/bitops.h:420:
arch/x86/include/asm/arch_hweight.h:49:15: error: invalid input size for constraint 'D'
                         : REG_IN (w));
                                   ^
In file included from arch/x86/entry/vdso/vdso32/vgetcpu.c:2:
In file included from arch/x86/entry/vdso/vdso32/../vgetcpu.c:8:
In file included from include/linux/kernel.h:25:
In file included from include/linux/math.h:6:
arch/x86/include/asm/div64.h:85:34: error: invalid output size for constraint '=a'
        asm ("mulq %2; divq %3" : "=a" (q)
                                        ^

Unlike gcc, clang checks inline asm constraints before dead code
elimination, which breaks both __arch_hweight64() and mul_u64_u64_div_u64()
when these are included with CONFIG_64BIT set but compiled with clang -m32,
even when there are no callers.

Change both affected headers to the check for 32-bit vs 64-bit is done
correctly for vdso32. It would be nice to also limit the included headers
further, to avoid subtle differences in the header contents, but that
requires a larger cleanup.

Fixes: 92d33063c081 ("x86/vdso: Provide getcpu for x86-32.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/entry/vdso/vdso32/vgetcpu.c | 2 ++
 arch/x86/include/asm/arch_hweight.h  | 4 ++--
 arch/x86/include/asm/div64.h         | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso32/vgetcpu.c b/arch/x86/entry/vdso/vdso32/vgetcpu.c
index b777f84ffae9..9f8cf77c7077 100644
--- a/arch/x86/entry/vdso/vdso32/vgetcpu.c
+++ b/arch/x86/entry/vdso/vdso32/vgetcpu.c
@@ -1,2 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
+#define BUILD_VDSO32
+
 #include "../vgetcpu.c"
diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index ba88edd0d58b..cca0941673e0 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -4,7 +4,7 @@
 
 #include <asm/cpufeatures.h>
 
-#ifdef CONFIG_64BIT
+#if defined(CONFIG_64BIT) && !defined(BUILD_VDSO32)
 #define REG_IN "D"
 #define REG_OUT "a"
 #else
@@ -33,7 +33,7 @@ static inline unsigned int __arch_hweight8(unsigned int w)
 	return __arch_hweight32(w & 0xff);
 }
 
-#ifdef CONFIG_X86_32
+#if defined(CONFIG_X86_32) || defined(BUILD_VDSO32)
 static inline unsigned long __arch_hweight64(__u64 w)
 {
 	return  __arch_hweight32((u32)w) +
diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
index b8f1dc0761e4..97bd076db0b2 100644
--- a/arch/x86/include/asm/div64.h
+++ b/arch/x86/include/asm/div64.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_DIV64_H
 #define _ASM_X86_DIV64_H
 
-#ifdef CONFIG_X86_32
+#if defined(CONFIG_X86_32) || defined(BUILD_VDSO32)
 
 #include <linux/types.h>
 #include <linux/log2.h>
-- 
2.39.1

