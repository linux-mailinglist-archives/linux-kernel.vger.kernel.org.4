Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79ED64E82B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 09:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLPIgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 03:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPIgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 03:36:18 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C3431DE4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 00:36:17 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4NYMrb43BGz9swJ;
        Fri, 16 Dec 2022 09:36:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZVV7Q_2gDyTG; Fri, 16 Dec 2022 09:36:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4NYMrb37jZz9svq;
        Fri, 16 Dec 2022 09:36:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5B9E58B77D;
        Fri, 16 Dec 2022 09:36:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id q8d1mazGsJcf; Fri, 16 Dec 2022 09:36:15 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.7.183])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2217B8B764;
        Fri, 16 Dec 2022 09:36:15 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2BG8Zvwu1184359
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 09:35:57 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2BG8ZtRh1184326;
        Fri, 16 Dec 2022 09:35:55 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: [PATCH v2] powerpc: Pass correct CPU reference to assembler
Date:   Fri, 16 Dec 2022 09:35:50 +0100
Message-Id: <01fe73614988e2402a7526fb6b6e903bc3777bb5.1671179743.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671179748; l=4545; s=20211009; h=from:subject:message-id; bh=uEgRQbc9vmLV1F3vTqBoGDj7Z21M05//0e1ScoBT3gE=; b=Bq+rjTOnTECHkVN81bSpCar4bIIeCHQ7VmxGgghh8JjLFXyDjGF25i5JtCvg4NdGcds+dSypyLqy a+lxgg85COsubDLG4SWeMlO85sZifyOufOgjDQMIhwlBhqkPIfa3
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict reported issue with building ppc64e_defconfig
with mainline GCC work:

  powerpc64-linux-gcc -Wp,-MMD,arch/powerpc/kernel/vdso/.gettimeofday-64.o.d -nostdinc -I./arch/powerpc/include -I./arch/powerpc/include/generated  -I./include -I./arch/powerpc/include/uapi -I./arch/powerpc/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h -D__KERNEL__ -I ./arch/powerpc -DHAVE_AS_ATHIGH=1 -fmacro-prefix-map=./= -D__ASSEMBLY__ -fno-PIE -m64 -Wl,-a64 -mabi=elfv1 -Wa,-me500 -Wa,-me500mc -mabi=elfv1 -mbig-endian    -Wl,-soname=linux-vdso64.so.1 -D__VDSO64__ -s -c -o arch/powerpc/kernel/vdso/gettimeofday-64.o arch/powerpc/kernel/vdso/gettimeofday.S
	arch/powerpc/kernel/vdso/gettimeofday.S: Assembler messages:
	arch/powerpc/kernel/vdso/gettimeofday.S:72: Error: unrecognized opcode: `stdu'
	arch/powerpc/kernel/vdso/gettimeofday.S:72: Error: unrecognized opcode: `stdu'
	arch/powerpc/kernel/vdso/gettimeofday.S:72: Error: unrecognized opcode: `std'
	arch/powerpc/kernel/vdso/gettimeofday.S:72: Error: unrecognized opcode: `std'
	arch/powerpc/kernel/vdso/gettimeofday.S:72: Error: unrecognized opcode: `ld'
	arch/powerpc/kernel/vdso/gettimeofday.S:72: Error: unrecognized opcode: `ld'
	...
	make[1]: *** [arch/powerpc/kernel/vdso/Makefile:76: arch/powerpc/kernel/vdso/gettimeofday-64.o] Error 1
	make: *** [arch/powerpc/Makefile:387: vdso_prepare] Error 2

This is due to assembler being called with -me500mc which is
a 32 bits target.

The problem comes from the fact that CONFIG_PPC_E500MC is selected for
both the e500mc (32 bits) and the e5500 (64 bits), and therefore the
following makefile rule is wrong:

  cpu-as-$(CONFIG_PPC_E500MC)    += $(call as-option,-Wa$(comma)-me500mc)

Today we have CONFIG_TARGET_CPU which provides the identification of the
expected CPU, it is used for GCC. Use it as well for the assembler.

With that change (And also commit 825eada7717c ("powerpc/64: Set
default CPU in Kconfig")), it now is:

  powerpc64-linux-gcc -Wp,-MMD,arch/powerpc/kernel/vdso/.gettimeofday-64.o.d -nostdinc -I./arch/powerpc/include -I./arch/powerpc/include/generated  -I./include -I./arch/powerpc/include/uapi -I./arch/powerpc/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h -D__KERNEL__ -I ./arch/powerpc -DHAVE_AS_ATHIGH=1 -fmacro-prefix-map=./= -D__ASSEMBLY__ -fno-PIE -m64 -Wl,-a64 -mabi=elfv1 -mcpu=e500mc64 -Wa,-me500mc64 -mabi=elfv1 -mbig-endian    -Wl,-soname=linux-vdso64.so.1 -D__VDSO64__ -s -c -o arch/powerpc/kernel/vdso/gettimeofday-64.o arch/powerpc/kernel/vdso/gettimeofday.S

Reported-by: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: When target cpu is powerpc, the option to be used is -mppc

Commit 825eada7717c is in powerpc/next-test branch. Make sure the SHA doesn't change when it goes into powerpc/next
---
 arch/powerpc/Makefile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index bf5f0a998273..528452ce80b4 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -201,18 +201,20 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 # often slow when they are implemented at all
 KBUILD_CFLAGS		+= $(call cc-option,-mno-string)
 
-cpu-as-$(CONFIG_40x)		+= -Wa,-m405
-cpu-as-$(CONFIG_44x)		+= -Wa,-m440
 cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
-cpu-as-$(CONFIG_PPC_E500)		+= -Wa,-me500
+
+ifeq ($(CONFIG_TARGET_CPU),powerpc)
+cpu-as-$(CONFIG_TARGET_CPU_BOOL)	+= -Wa,-mppc
+else
+cpu-as-$(CONFIG_TARGET_CPU_BOOL)	+= -Wa,-m$(CONFIG_TARGET_CPU)
+endif
 
 # When using '-many -mpower4' gas will first try and find a matching power4
 # mnemonic and failing that it will allow any valid mnemonic that GAS knows
 # about. GCC will pass -many to GAS when assembling, clang does not.
 # LLVM IAS doesn't understand either flag: https://github.com/ClangBuiltLinux/linux/issues/675
 # but LLVM IAS only supports ISA >= 2.06 for Book3S 64 anyway...
-cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= $(call as-option,-Wa$(comma)-mpower4) $(call as-option,-Wa$(comma)-many)
-cpu-as-$(CONFIG_PPC_E500MC)	+= $(call as-option,-Wa$(comma)-me500mc)
+cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= $(call as-option,-Wa$(comma)-many)
 
 KBUILD_AFLAGS += $(cpu-as-y)
 KBUILD_CFLAGS += $(cpu-as-y)
-- 
2.38.1

