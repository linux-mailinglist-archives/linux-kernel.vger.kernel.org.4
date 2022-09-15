Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01E55B99F8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiIOLng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiIOLlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:41:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C14476D3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=PttSBmv1nrCBKdNV+5UgP0hR8DiTZQTnX48tg0+k45o=; b=cKLjLJMTseOLhdjYDU7Ie6f2Xt
        uOHOUKbjKGt66gPvobKLBAyoxTF1MD8vJmExIXpd/s6F3Xe5YM4+r6rWhliI9yGyxHrFTef8tI61u
        fHXRjmofDgqWCNKzD8yYZBbKNjZJJZKaQkCDQCgV5UC0IfnRSuST8GTd2D6FmB/da2iG6CLW0+M1H
        YdJxCg838qlvBqfzfBzygc06hA8vAvatKqzy+igtGLpaL5TXAVzeqQ1EOioAPTPTDERg+1jBNmlXQ
        EpFCDiodf1CAoXMBRnxaMBKk4TQuxiUCYer9vEGWhZVeruOy1867PaSwlGRioessTDi08HH2rd6Ds
        Km/zxQcg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDZ-00Caak-30; Thu, 15 Sep 2022 11:39:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B54E3300C1E;
        Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 01ACC29AADBED; Thu, 15 Sep 2022 13:39:38 +0200 (CEST)
Message-ID: <20220915111143.719248727@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:10:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v3 08/59] arch: Introduce CONFIG_FUNCTION_ALIGNMENT
References: <20220915111039.092790446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Generic function-alignment infrastructure.

Architectures can select FUNCTION_ALIGNMENT_xxB symbols; the
FUNCTION_ALIGNMENT symbol is then set to the largest such selected
size, 0 otherwise.

>From this the -falign-functions compiler argument and __ALIGN macro
are set.

This incorporates the DEBUG_FORCE_FUNCTION_ALIGN_64B knob and future
alignment requirements for x86_64 (later in this series) into a single
place.

NOTE: also removes the 0x90 filler byte from the generic __ALIGN
      primitive, that value makes no sense outside of x86.

NOTE: .balign 0 reverts to a no-op.

Requested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Makefile                          |    4 ++--
 arch/Kconfig                      |   24 ++++++++++++++++++++++++
 arch/ia64/Kconfig                 |    1 +
 arch/ia64/Makefile                |    2 +-
 arch/x86/Kconfig                  |    2 ++
 arch/x86/include/asm/linkage.h    |    4 +---
 include/asm-generic/vmlinux.lds.h |    4 ++--
 include/linux/linkage.h           |    4 ++--
 lib/Kconfig.debug                 |    1 +
 9 files changed, 36 insertions(+), 10 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -937,8 +937,8 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_CFI)
 export CC_FLAGS_CFI
 endif
 
-ifdef CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B
-KBUILD_CFLAGS += -falign-functions=64
+ifneq ($(CONFIG_FUNCTION_ALIGNMENT),0)
+KBUILD_CFLAGS += -falign-functions=$(CONFIG_FUNCTION_ALIGNMENT)
 endif
 
 # arch Makefile may override CC so keep this after arch Makefile is included
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1419,4 +1419,28 @@ source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
 
+config FUNCTION_ALIGNMENT_4B
+	bool
+
+config FUNCTION_ALIGNMENT_8B
+	bool
+
+config FUNCTION_ALIGNMENT_16B
+	bool
+
+config FUNCTION_ALIGNMENT_32B
+	bool
+
+config FUNCTION_ALIGNMENT_64B
+	bool
+
+config FUNCTION_ALIGNMENT
+	int
+	default 64 if FUNCTION_ALIGNMENT_64B
+	default 32 if FUNCTION_ALIGNMENT_32B
+	default 16 if FUNCTION_ALIGNMENT_16B
+	default 8 if FUNCTION_ALIGNMENT_8B
+	default 4 if FUNCTION_ALIGNMENT_4B
+	default 0
+
 endmenu
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -63,6 +63,7 @@ config IA64
 	select NUMA if !FLATMEM
 	select PCI_MSI_ARCH_FALLBACKS if PCI_MSI
 	select ZONE_DMA32
+	select FUNCTION_ALIGNMENT_32B
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
--- a/arch/ia64/Makefile
+++ b/arch/ia64/Makefile
@@ -23,7 +23,7 @@ KBUILD_AFLAGS_KERNEL := -mconstant-gp
 EXTRA		:=
 
 cflags-y	:= -pipe $(EXTRA) -ffixed-r13 -mfixed-range=f12-f15,f32-f127 \
-		   -falign-functions=32 -frename-registers -fno-optimize-sibling-calls
+		   -frename-registers -fno-optimize-sibling-calls
 KBUILD_CFLAGS_KERNEL := -mconstant-gp
 
 GAS_STATUS	= $(shell $(srctree)/arch/ia64/scripts/check-gas "$(CC)" "$(OBJDUMP)")
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -283,6 +283,8 @@ config X86
 	select X86_FEATURE_NAMES		if PROC_FS
 	select PROC_PID_ARCH_STATUS		if PROC_FS
 	select HAVE_ARCH_NODE_DEV_GROUP		if X86_SGX
+	select FUNCTION_ALIGNMENT_16B		if X86_64 || X86_ALIGNMENT_16
+	select FUNCTION_ALIGNMENT_4B
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 
 config INSTRUCTION_DECODER
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -14,10 +14,8 @@
 
 #ifdef __ASSEMBLY__
 
-#if defined(CONFIG_X86_64) || defined(CONFIG_X86_ALIGNMENT_16)
-#define __ALIGN		.p2align 4, 0x90
+#define __ALIGN		.balign CONFIG_FUNCTION_ALIGNMENT, 0x90;
 #define __ALIGN_STR	__stringify(__ALIGN)
-#endif
 
 #if defined(CONFIG_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define RET	jmp __x86_return_thunk
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -81,8 +81,8 @@
 #define RO_EXCEPTION_TABLE
 #endif
 
-/* Align . to a 8 byte boundary equals to maximum function alignment. */
-#define ALIGN_FUNCTION()  . = ALIGN(8)
+/* Align . function alignment. */
+#define ALIGN_FUNCTION()  . = ALIGN(CONFIG_FUNCTION_ALIGNMENT)
 
 /*
  * LD_DEAD_CODE_DATA_ELIMINATION option enables -fdata-sections, which
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -69,8 +69,8 @@
 #endif
 
 #ifndef __ALIGN
-#define __ALIGN		.align 4,0x90
-#define __ALIGN_STR	".align 4,0x90"
+#define __ALIGN			.balign CONFIG_FUNCTION_ALIGNMENT
+#define __ALIGN_STR		__stringify(__ALIGN)
 #endif
 
 #ifdef __ASSEMBLY__
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -459,6 +459,7 @@ config SECTION_MISMATCH_WARN_ONLY
 config DEBUG_FORCE_FUNCTION_ALIGN_64B
 	bool "Force all function address 64B aligned"
 	depends on EXPERT && (X86_64 || ARM64 || PPC32 || PPC64 || ARC)
+	select FUNCTION_ALIGNMENT_64B
 	help
 	  There are cases that a commit from one domain changes the function
 	  address alignment of other domains, and cause magic performance


