Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCFC627CC8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbiKNLq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbiKNLqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:46:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98790233BD;
        Mon, 14 Nov 2022 03:45:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCE9C61087;
        Mon, 14 Nov 2022 11:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731AFC433D7;
        Mon, 14 Nov 2022 11:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426307;
        bh=rax9Sk0B97anfjE870tVIfylOGOMvkqIjn17Y4+e0zw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ig5CDdXql15Gd4fTP+IlvjoNHuzHJ1zDAzs4QbD1+lazKnKCGuM6a3Uft+OMx66Xt
         8U15M+SeRg6aVyP0214WZo5NmzOwzkrpzlLdbt6OLr1347K9G60URIFBT2/NARAjcD
         pycuPOnQGZmhBS/w2xZXJquS8UwgI3vi0Zc1ItKB2gra8PWZ/qPLncpVkxiczC9CJr
         j9/JIbQMIt/EEdfFRm9cP8A+6YX4oU5qO6oEBnbkU3+FZQEE4MrOHFVE0I5u0Pxf+N
         E9RFsrchKpk8KrzeUB7FDEDS2psNEjuwE451izXf/2+67zbtlMJtUy5FXJyWrNSZEt
         O9bKWwNdvdvuw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 29/46] scripts, lto: use CONFIG_LTO for many LTO specific actions
Date:   Mon, 14 Nov 2022 12:43:27 +0100
Message-Id: <20221114114344.18650-30-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
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

From: Andi Kleen <ak@linux.intel.com>

The clang LTO and the gcc LTO share some changes in Makefiles and build
scripts. Change the common ones to use CONFIG_LTO instead of
CONFIG_LTO_CLANG so that they can be used by gcc too.

[js] fix scripts/link-vmlinux.sh too

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Makefile                          | 2 +-
 include/asm-generic/vmlinux.lds.h | 2 +-
 kernel/kallsyms.c                 | 2 +-
 scripts/Makefile.build            | 2 +-
 scripts/Makefile.lib              | 2 +-
 scripts/link-vmlinux.sh           | 2 +-
 scripts/module.lds.S              | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 58cd4f5e1c3a..0b723c903819 100644
--- a/Makefile
+++ b/Makefile
@@ -992,7 +992,7 @@ endif
 endif
 endif
 
-ifdef CONFIG_LTO
+ifdef CONFIG_LTO_CLANG
 KBUILD_CFLAGS	+= -fno-lto $(CC_FLAGS_LTO)
 KBUILD_AFLAGS	+= -fno-lto
 export CC_FLAGS_LTO
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3dc5824141cd..5e2179dd41d5 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -96,7 +96,7 @@
  * RODATA_MAIN is not used because existing code already defines .rodata.x
  * sections to be brought in with rodata.
  */
-#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
+#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO)
 #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
 #define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliteral* .data.$__unnamed_* .data.$L*
 #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 60c20f301a6b..1d4557ae090f 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -167,7 +167,7 @@ static bool cleanup_symbol_name(char *s)
 {
 	char *res;
 
-	if (!IS_ENABLED(CONFIG_LTO_CLANG))
+	if (!IS_ENABLED(CONFIG_LTO))
 		return false;
 
 	/*
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 564a20ce2667..0a28e3884efe 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -153,7 +153,7 @@ is-single-obj-m = $(and $(part-of-module),$(filter $@, $(obj-m)),y)
 
 # When a module consists of a single object, there is no reason to keep LLVM IR.
 # Make $(LD) covert LLVM IR to ELF here.
-ifdef CONFIG_LTO_CLANG
+ifdef CONFIG_LTO
 cmd_ld_single_m = $(if $(is-single-obj-m), ; $(LD) $(ld_flags) -r -o $(tmp-target) $@; mv $(tmp-target) $@)
 endif
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3aa384cec76b..ac918fd84d96 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -269,7 +269,7 @@ objtool-args = $(objtool-args-y)					\
 	$(if $(delay-objtool), --link)					\
 	$(if $(part-of-module), --module)
 
-delay-objtool := $(or $(CONFIG_LTO_CLANG),$(CONFIG_X86_KERNEL_IBT))
+delay-objtool := $(or $(CONFIG_LTO),$(CONFIG_X86_KERNEL_IBT))
 
 cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool-args) $@)
 cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 918470d768e9..652f33be9549 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -60,7 +60,7 @@ vmlinux_link()
 	# skip output file argument
 	shift
 
-	if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; then
+	if is_enabled CONFIG_LTO || is_enabled CONFIG_X86_KERNEL_IBT; then
 		# Use vmlinux.o instead of performing the slow LTO link again.
 		objs=vmlinux.o
 		libs=
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index da4bddd26171..b36b0527b0a8 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -27,7 +27,7 @@ SECTIONS {
 	__kcfi_traps 		: { KEEP(*(.kcfi_traps)) }
 #endif
 
-#ifdef CONFIG_LTO_CLANG
+#ifdef CONFIG_LTO
 	/*
 	 * With CONFIG_LTO_CLANG, LLD always enables -fdata-sections and
 	 * -ffunction-sections, which increases the size of the final module.
-- 
2.38.1

