Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A97651DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiLTJk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiLTJku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:40:50 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E7AC2B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:40:45 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Nbs536mN1z9t40;
        Tue, 20 Dec 2022 10:40:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lqi_5GhCUETs; Tue, 20 Dec 2022 10:40:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Nbs4p1bZQz9t45;
        Tue, 20 Dec 2022 10:40:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 282498B763;
        Tue, 20 Dec 2022 10:40:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NhVeD4Sy-4k5; Tue, 20 Dec 2022 10:40:26 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.18])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E3D898B773;
        Tue, 20 Dec 2022 10:40:25 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2BJIkGNJ1709620
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 19:46:16 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2BJIkGMk1709619;
        Mon, 19 Dec 2022 19:46:16 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, jbglaw@lug-owl.de
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 2/5] powerpc: Pass correct CPU reference to assembler
Date:   Mon, 19 Dec 2022 19:45:57 +0100
Message-Id: <758ad54128fa9dd2fdedc4c511592111cbded900.1671475543.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <38a8d765ed9149bc6b5484a7142e3bc59ffa3b1a.1671475543.git.christophe.leroy@csgroup.eu>
References: <38a8d765ed9149bc6b5484a7142e3bc59ffa3b1a.1671475543.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671475558; l=4614; s=20211009; h=from:subject:message-id; bh=l8wdi5+s2kfCSCn+DsLcZJMj33y1G4oMBcfHAvJqBZM=; b=QcFBsWl1YT5kOhKZM4Z1PxMRqhIQC0hSGgiIfTk92jcLY/Eq+zej+RGskddYw8tkmR/XEjSX9wS+ 37rGjU61CFmXZg7QnmRzVjblXsLDSYCo2yVy+NK+J8kapRTMIeRY
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
expected CPU, it is used for GCC. Once GCC knows the target CPU, it adds
the correct CPU option to assembler, no need to add it explicitely.

With that change (And also commit 825eada7717c ("powerpc/64: Set
default CPU in Kconfig")), it now is:

  powerpc64-linux-gcc -Wp,-MMD,arch/powerpc/kernel/vdso/.gettimeofday-64.o.d -nostdinc -I./arch/powerpc/include -I./arch/powerpc/include/generated  -I./include -I./arch/powerpc/include/uapi -I./arch/powerpc/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h -D__KERNEL__ -I ./arch/powerpc -DHAVE_AS_ATHIGH=1 -fmacro-prefix-map=./= -D__ASSEMBLY__ -fno-PIE -m64 -Wl,-a64 -mabi=elfv1 -mcpu=e500mc64 -mabi=elfv1 -mbig-endian    -Wl,-soname=linux-vdso64.so.1 -D__VDSO64__ -s -c -o arch/powerpc/kernel/vdso/gettimeofday-64.o arch/powerpc/kernel/vdso/gettimeofday.S

Reported-by: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3: Remove -Wa,-mXXX completery as there are additional mismatches between -mcpu and -Wa-m (eg: 8540 vs e500). When given the proper -mcpu=, GCC gives the correct option to assembler.

v2: When target cpu is powerpc, the option to be used is -mppc

Commit 825eada7717c is in powerpc/next-test branch. Make sure the SHA doesn't change when it goes into powerpc/next
---
 arch/powerpc/Makefile | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index bf5f0a998273..0f9f291895cb 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -201,18 +201,14 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 # often slow when they are implemented at all
 KBUILD_CFLAGS		+= $(call cc-option,-mno-string)
 
-cpu-as-$(CONFIG_40x)		+= -Wa,-m405
-cpu-as-$(CONFIG_44x)		+= -Wa,-m440
 cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
-cpu-as-$(CONFIG_PPC_E500)		+= -Wa,-me500
 
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

