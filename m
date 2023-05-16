Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE6B70579D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjEPTlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjEPTle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:41:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CF5AD13;
        Tue, 16 May 2023 12:41:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99DB16324B;
        Tue, 16 May 2023 19:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31695C4339B;
        Tue, 16 May 2023 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684266022;
        bh=jJJcduVZoL7FA07spYoM0rBgXI6P51X+u5P3BZBB8fU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VvSe0V1IjrV/xFL3ACCeditJS5NKMhIffRaUX/X6MOSnLt3NG4iN/7P07PEq9pQtu
         mgSLVxphCbj7fdh/UKsfk4HjiIZn3RbHL2pzJsNvwWK9RGRlnkdKkt/raraPfB1sV7
         daSCbdfM8GNCmhkkqjzctsDV1Za66AzuIgNvxQey4QHzPIKUBL4pjQqIfFUKPRKSgm
         hqkWcOL5VzJqBx02Wp1bdFEUVZVM1sydcwWi5ZYIcpGKU5hiP2BLDNwn8jOYCFS6fC
         PuGngq4gX5q3w8wm49Uba4ldqZPo4CoWWIPblDRg3VnuR8EO4m4GiCOWyoqIPyghap
         IGuGelICq4oJA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mips: asm-offsets: add missing prototypes
Date:   Tue, 16 May 2023 21:39:43 +0200
Message-Id: <20230516194000.548487-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516194000.548487-1-arnd@kernel.org>
References: <20230516194000.548487-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building with -Werror and W=1 fails entirely because of warnings in
asm-offsets.c:

arch/mips/kernel/asm-offsets.c:26:6: error: no previous prototype for 'output_ptreg_defines' [-Werror=missing-prototypes]
arch/mips/kernel/asm-offsets.c:78:6: error: no previous prototype for 'output_task_defines' [-Werror=missing-prototypes]
arch/mips/kernel/asm-offsets.c:92:6: error: no previous prototype for 'output_thread_info_defines' [-Werror=missing-prototypes]
arch/mips/kernel/asm-offsets.c:108:6: error: no previous prototype for 'output_thread_defines' [-Werror=missing-prototypes]
arch/mips/kernel/asm-offsets.c:136:6: error: no previous prototype for 'output_thread_fpu_defines' [-Werror=missing-prototypes]

Nothing actually calls these functions, so just add prototypes to shut
up the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/kernel/asm-offsets.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 40fd4051bb3d..d1b11f66f748 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -23,6 +23,7 @@
 
 #include <linux/kvm_host.h>
 
+void output_ptreg_defines(void);
 void output_ptreg_defines(void)
 {
 	COMMENT("MIPS pt_regs offsets.");
@@ -75,6 +76,7 @@ void output_ptreg_defines(void)
 	BLANK();
 }
 
+void output_task_defines(void);
 void output_task_defines(void)
 {
 	COMMENT("MIPS task_struct offsets.");
@@ -89,6 +91,7 @@ void output_task_defines(void)
 	BLANK();
 }
 
+void output_thread_info_defines(void);
 void output_thread_info_defines(void)
 {
 	COMMENT("MIPS thread_info offsets.");
@@ -105,6 +108,7 @@ void output_thread_info_defines(void)
 	BLANK();
 }
 
+void output_thread_defines(void);
 void output_thread_defines(void)
 {
 	COMMENT("MIPS specific thread_struct offsets.");
@@ -133,6 +137,7 @@ void output_thread_defines(void)
 }
 
 #ifdef CONFIG_MIPS_FP_SUPPORT
+void output_thread_fpu_defines(void);
 void output_thread_fpu_defines(void)
 {
 	OFFSET(THREAD_FPU, task_struct, thread.fpu);
@@ -176,6 +181,7 @@ void output_thread_fpu_defines(void)
 }
 #endif
 
+void output_mm_defines(void);
 void output_mm_defines(void)
 {
 	COMMENT("Size of struct page");
@@ -210,6 +216,7 @@ void output_mm_defines(void)
 }
 
 #ifdef CONFIG_32BIT
+void output_sc_defines(void);
 void output_sc_defines(void)
 {
 	COMMENT("Linux sigcontext offsets.");
@@ -232,6 +239,7 @@ void output_sc_defines(void)
 #endif
 
 #ifdef CONFIG_64BIT
+void output_sc_defines(void);
 void output_sc_defines(void)
 {
 	COMMENT("Linux sigcontext offsets.");
@@ -245,6 +253,7 @@ void output_sc_defines(void)
 }
 #endif
 
+void output_signal_defined(void);
 void output_signal_defined(void)
 {
 	COMMENT("Linux signal numbers.");
@@ -284,6 +293,7 @@ void output_signal_defined(void)
 }
 
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
+void output_octeon_cop2_state_defines(void);
 void output_octeon_cop2_state_defines(void)
 {
 	COMMENT("Octeon specific octeon_cop2_state offsets.");
@@ -315,6 +325,7 @@ void output_octeon_cop2_state_defines(void)
 #endif
 
 #ifdef CONFIG_HIBERNATION
+void output_pbe_defines(void);
 void output_pbe_defines(void)
 {
 	COMMENT(" Linux struct pbe offsets. ");
@@ -327,6 +338,7 @@ void output_pbe_defines(void)
 #endif
 
 #ifdef CONFIG_CPU_PM
+void output_pm_defines(void);
 void output_pm_defines(void)
 {
 	COMMENT(" PM offsets. ");
@@ -341,6 +353,7 @@ void output_pm_defines(void)
 #endif
 
 #ifdef CONFIG_MIPS_FP_SUPPORT
+void output_kvm_defines(void);
 void output_kvm_defines(void)
 {
 	COMMENT(" KVM/MIPS Specific offsets. ");
@@ -385,6 +398,7 @@ void output_kvm_defines(void)
 #endif
 
 #ifdef CONFIG_MIPS_CPS
+void output_cps_defines(void);
 void output_cps_defines(void)
 {
 	COMMENT(" MIPS CPS offsets. ");
-- 
2.39.2

