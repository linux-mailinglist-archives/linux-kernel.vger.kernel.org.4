Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C636C3BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjCUUVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjCUUVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:21:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12121205D;
        Tue, 21 Mar 2023 13:20:37 -0700 (PDT)
Date:   Tue, 21 Mar 2023 20:20:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679430025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DkfAA7kabvZ6a7Gv4ZIn9g9p4FKM0I5uVnIERk3tnK4=;
        b=cY0RtZMeHfK+akbj4BmYbKVr4M2zpm1oBSiSTZyRH21d0k44lDCRQfdqyQ2vYUKnBjROMS
        ATyhv8uFjydEvbqdfhd7baJhfsUD63s+nlE42g12oI26QLZVA8rh6wcqHLiuC3x5KsCz6N
        ipiz6GJr+oBdmWROXp2G+hB3LAGsuxzCcyYsf9Irm1rp66gWysMtbg2cfxHLvKc4T857At
        fgLgd9f6mQhB8wMAce37TameE0b8hwL7//5AnumEvF8xOsx2qD7QCDaT1m3jD0HVjwMTq7
        gWXB6oDtAtHqwo6FkaifrjdzzVTli2HWpooPCbdWbkbgRm4zhh6IX1UZj1AR4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679430025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DkfAA7kabvZ6a7Gv4ZIn9g9p4FKM0I5uVnIERk3tnK4=;
        b=Kg2jT7PS3H8lVi+yUFycnDR9W9jqUr0SEsvYG0Mmq/gkAw/QCUSxhNBjxkKTIGposCa0hS
        EPLueEVpnTBZ2kDw==
From:   "tip-bot2 for Fangrui Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] vdso: Improve cmd_vdso_check to check all dynamic
 relocations
Cc:     Fangrui Song <maskray@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230310190750.3323802-1-maskray@google.com>
References: <20230310190750.3323802-1-maskray@google.com>
MIME-Version: 1.0
Message-ID: <167943002433.5837.13753758233638866340.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     aff69273af61f5d1c8fb401d6f19148d11629b41
Gitweb:        https://git.kernel.org/tip/aff69273af61f5d1c8fb401d6f19148d11629b41
Author:        Fangrui Song <maskray@google.com>
AuthorDate:    Fri, 10 Mar 2023 19:07:50 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 21 Mar 2023 21:15:34 +01:00

vdso: Improve cmd_vdso_check to check all dynamic relocations

The actual intention is that no dynamic relocation exists in the VDSO. For
this the VDSO build validates that the resulting .so file does not have any
relocations which are specified via $(ARCH_REL_TYPE_ABS) per architecture,
which is fragile as e.g. ARM64 lacks an entry for R_AARCH64_RELATIVE. Aside
of that ARCH_REL_TYPE_ABS is a misnomer as it checks for relative
relocations too.

However, some GNU ld ports produce unneeded R_*_NONE relocation entries. If
a port fails to determine the exact .rel[a].dyn size, the trailing zeros
become R_*_NONE relocations. E.g. ld's powerpc port recently fixed
https://sourceware.org/bugzilla/show_bug.cgi?id=29540). R_*_NONE are
generally a no-op in the dynamic loaders. So just ignore them.

Remove the ARCH_REL_TYPE_ABS defines and just validate that the resulting
.so file does not contain any R_* relocation entries except R_*_NONE.

Signed-off-by: Fangrui Song <maskray@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com> # for aarch64
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com> # for vDSO, aarch64
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Link: https://lore.kernel.org/r/20230310190750.3323802-1-maskray@google.com

---
 arch/arm/vdso/Makefile            |  4 +---
 arch/arm64/kernel/vdso/Makefile   |  4 +---
 arch/arm64/kernel/vdso32/Makefile |  3 ---
 arch/csky/kernel/vdso/Makefile    |  4 +---
 arch/loongarch/vdso/Makefile      |  4 +---
 arch/mips/vdso/Makefile           |  4 +---
 arch/powerpc/kernel/vdso/Makefile |  2 +-
 arch/riscv/kernel/vdso/Makefile   |  4 +---
 arch/s390/kernel/vdso32/Makefile  |  3 +--
 arch/s390/kernel/vdso64/Makefile  |  3 +--
 arch/x86/entry/vdso/Makefile      |  5 +----
 lib/vdso/Makefile                 | 13 ++++---------
 12 files changed, 14 insertions(+), 39 deletions(-)

diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index a7ec06c..515ca33 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
-# the inclusion of generic Makefile.
-ARCH_REL_TYPE_ABS := R_ARM_JUMP_SLOT|R_ARM_GLOB_DAT|R_ARM_ABS32
+# Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
 
 hostprogs := vdsomunge
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index beaf958..fe7a53c 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -6,9 +6,7 @@
 # Heavily based on the vDSO Makefiles for other archs.
 #
 
-# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
-# the inclusion of generic Makefile.
-ARCH_REL_TYPE_ABS := R_AARCH64_JUMP_SLOT|R_AARCH64_GLOB_DAT|R_AARCH64_ABS64
+# Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
 
 obj-vdso := vgettimeofday.o note.o sigreturn.o
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index f59bd1a..d014162 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -3,9 +3,6 @@
 # Makefile for vdso32
 #
 
-# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
-# the inclusion of generic Makefile.
-ARCH_REL_TYPE_ABS := R_ARM_JUMP_SLOT|R_ARM_GLOB_DAT|R_ARM_ABS32
 include $(srctree)/lib/vdso/Makefile
 
 # Same as cc-*option, but using CC_COMPAT instead of CC
diff --git a/arch/csky/kernel/vdso/Makefile b/arch/csky/kernel/vdso/Makefile
index 0b6909f..299e4e4 100644
--- a/arch/csky/kernel/vdso/Makefile
+++ b/arch/csky/kernel/vdso/Makefile
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
-# the inclusion of generic Makefile.
-ARCH_REL_TYPE_ABS := R_CKCORE_ADDR32|R_CKCORE_JUMP_SLOT
+# Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
 
 # Symbols present in the vdso
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index d89e2ac..461240a 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -1,9 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Objects to go into the VDSO.
 
-# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
-# the inclusion of generic Makefile.
-ARCH_REL_TYPE_ABS := R_LARCH_32|R_LARCH_64|R_LARCH_MARK_LA|R_LARCH_JUMP_SLOT
+# Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
 
 obj-vdso-y := elf.o vgetcpu.o vgettimeofday.o sigreturn.o
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 18af947..eb56581 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -4,9 +4,7 @@
 # Sanitizer runtimes are unavailable and cannot be linked here.
  KCSAN_SANITIZE			:= n
 
-# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
-# the inclusion of generic Makefile.
-ARCH_REL_TYPE_ABS := R_MIPS_JUMP_SLOT|R_MIPS_GLOB_DAT
+# Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
 
 obj-vdso-y := elf.o vgettimeofday.o sigreturn.o
diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
index 66f723f..4c3f344 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -2,7 +2,7 @@
 
 # List of files in the vdso, has to be asm only for now
 
-ARCH_REL_TYPE_ABS := R_PPC_JUMP_SLOT|R_PPC_GLOB_DAT|R_PPC_ADDR32|R_PPC_ADDR24|R_PPC_ADDR16|R_PPC_ADDR16_LO|R_PPC_ADDR16_HI|R_PPC_ADDR16_HA|R_PPC_ADDR14|R_PPC_ADDR14_BRTAKEN|R_PPC_ADDR14_BRNTAKEN|R_PPC_REL24
+# Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
 
 obj-vdso32 = sigtramp32-32.o gettimeofday-32.o datapage-32.o cacheflush-32.o note-32.o getcpu-32.o
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 06e6b27..a04b3bc 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -1,9 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # Copied from arch/tile/kernel/vdso/Makefile
 
-# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
-# the inclusion of generic Makefile.
-ARCH_REL_TYPE_ABS := R_RISCV_32|R_RISCV_64|R_RISCV_JUMP_SLOT
+# Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
 # Symbols present in the vdso
 vdso-syms  = rt_sigreturn
diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makefile
index 245bddf..bafd314 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -2,9 +2,8 @@
 # List of files in the vdso
 
 KCOV_INSTRUMENT := n
-ARCH_REL_TYPE_ABS := R_390_COPY|R_390_GLOB_DAT|R_390_JMP_SLOT|R_390_RELATIVE
-ARCH_REL_TYPE_ABS += R_390_GOT|R_390_PLT
 
+# Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
 obj-vdso32 = vdso_user_wrapper-32.o note-32.o
 
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index 34f9542..a766d28 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -2,9 +2,8 @@
 # List of files in the vdso
 
 KCOV_INSTRUMENT := n
-ARCH_REL_TYPE_ABS := R_390_COPY|R_390_GLOB_DAT|R_390_JMP_SLOT|R_390_RELATIVE
-ARCH_REL_TYPE_ABS += R_390_GOT|R_390_PLT
 
+# Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
 obj-vdso64 = vdso_user_wrapper.o note.o
 obj-cvdso64 = vdso64_generic.o getcpu.o
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 1506a22..6a1821b 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -3,10 +3,7 @@
 # Building vDSO images for x86.
 #
 
-# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
-# the inclusion of generic Makefile.
-ARCH_REL_TYPE_ABS := R_X86_64_JUMP_SLOT|R_X86_64_GLOB_DAT|R_X86_64_RELATIVE|
-ARCH_REL_TYPE_ABS += R_386_GLOB_DAT|R_386_JMP_SLOT|R_386_RELATIVE
+# Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
 
 # Sanitizer runtimes are unavailable and cannot be linked here.
diff --git a/lib/vdso/Makefile b/lib/vdso/Makefile
index e814061..9f031ea 100644
--- a/lib/vdso/Makefile
+++ b/lib/vdso/Makefile
@@ -5,18 +5,13 @@ GENERIC_VDSO_DIR := $(dir $(GENERIC_VDSO_MK_PATH))
 
 c-gettimeofday-$(CONFIG_GENERIC_GETTIMEOFDAY) := $(addprefix $(GENERIC_VDSO_DIR), gettimeofday.c)
 
-# This cmd checks that the vdso library does not contain absolute relocation
+# This cmd checks that the vdso library does not contain dynamic relocations.
 # It has to be called after the linking of the vdso library and requires it
 # as a parameter.
 #
-# $(ARCH_REL_TYPE_ABS) is defined in the arch specific makefile and corresponds
-# to the absolute relocation types printed by "objdump -R" and accepted by the
-# dynamic linker.
-ifndef ARCH_REL_TYPE_ABS
-$(error ARCH_REL_TYPE_ABS is not set)
-endif
-
+# As a workaround for some GNU ld ports which produce unneeded R_*_NONE
+# dynamic relocations, ignore R_*_NONE.
 quiet_cmd_vdso_check = VDSOCHK $@
-      cmd_vdso_check = if $(OBJDUMP) -R $@ | grep -E -h "$(ARCH_REL_TYPE_ABS)"; \
+      cmd_vdso_check = if $(READELF) -rW $@ | grep -v _NONE | grep -q " R_\w*_"; \
 		       then (echo >&2 "$@: dynamic relocations are not supported"; \
 			     rm -f $@; /bin/false); fi
