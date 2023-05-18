Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F17708B46
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjERWDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjERWDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:03:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15BCE61;
        Thu, 18 May 2023 15:03:17 -0700 (PDT)
Date:   Thu, 18 May 2023 22:03:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684447395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CVVhUaVpd99ia/UHaFKuasy0L+DSdo1nXROm6c19S8s=;
        b=BJHh4I6KTyln6s4ZrKUMz3X5OeC0hWIZLSZSk64KJKWRjLiqoMPZKTw30htJr+JbBqolJx
        3MlpkXZb4comMsXzKfMUdgy2msXxGQ41ULvrwMCsFKJGx4R3FlXaoeFpcYZwYqg4vxbx8r
        EZ/Fj8ic09gwdXsY+cJzxEz9aWlYEyP1G3kUoq3hjOywLxnpPSoMK70q8sejNay7U66fF9
        iFwIPrz37BvxCZCHI6zdEcxMThj3qFZ/jW/eYLAjOu94u76uMtFSv+pvXtJXTwfSFXFeki
        jMuhgKO7pdtjNITnFDFNuHO/4K7R/Vo3OFproZKABB0iwTBij03yOLuG/BZhCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684447395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CVVhUaVpd99ia/UHaFKuasy0L+DSdo1nXROm6c19S8s=;
        b=FBcYtLYDj02ZBXy/qtJlUyj65uO5semr1KWF4RmmXHVBWslw5k9DBvXvuxzCpuH4ZoC3i6
        J/bYCAi8oh6LkIAQ==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Avoid missing-prototype warnings for
 doublefault code
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168444739461.404.1026256630293999646.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     c9664839305dfaccd098b1606c197b0eb21056dc
Gitweb:        https://git.kernel.org/tip/c9664839305dfaccd098b1606c197b0eb21056dc
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 16 May 2023 21:35:36 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 18 May 2023 11:56:18 -07:00

x86: Avoid missing-prototype warnings for doublefault code

Two functions in the 32-bit doublefault code are lacking a prototype:

arch/x86/kernel/doublefault_32.c:23:36: error: no previous prototype for 'doublefault_shim' [-Werror=missing-prototypes]
   23 | asmlinkage noinstr void __noreturn doublefault_shim(void)
      |                                    ^~~~~~~~~~~~~~~~
arch/x86/kernel/doublefault_32.c:114:6: error: no previous prototype for 'doublefault_init_cpu_tss' [-Werror=missing-prototypes]
  114 | void doublefault_init_cpu_tss(void)

The first one is only called from assembler, while the second one is
declared in doublefault.h, but this file is not included.

Include the header file and add the other declaration there as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Link: https://lore.kernel.org/all/20230516193549.544673-8-arnd%40kernel.org
---
 arch/x86/include/asm/doublefault.h | 4 ++++
 arch/x86/kernel/doublefault_32.c   | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/doublefault.h b/arch/x86/include/asm/doublefault.h
index 54a6e4a..de0e88b 100644
--- a/arch/x86/include/asm/doublefault.h
+++ b/arch/x86/include/asm/doublefault.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_DOUBLEFAULT_H
 #define _ASM_X86_DOUBLEFAULT_H
 
+#include <linux/linkage.h>
+
 #ifdef CONFIG_X86_32
 extern void doublefault_init_cpu_tss(void);
 #else
@@ -10,4 +12,6 @@ static inline void doublefault_init_cpu_tss(void)
 }
 #endif
 
+asmlinkage void __noreturn doublefault_shim(void);
+
 #endif /* _ASM_X86_DOUBLEFAULT_H */
diff --git a/arch/x86/kernel/doublefault_32.c b/arch/x86/kernel/doublefault_32.c
index 3b58d87..6eaf9a6 100644
--- a/arch/x86/kernel/doublefault_32.c
+++ b/arch/x86/kernel/doublefault_32.c
@@ -9,6 +9,7 @@
 #include <asm/processor.h>
 #include <asm/desc.h>
 #include <asm/traps.h>
+#include <asm/doublefault.h>
 
 #define ptr_ok(x) ((x) > PAGE_OFFSET && (x) < PAGE_OFFSET + MAXMEM)
 
