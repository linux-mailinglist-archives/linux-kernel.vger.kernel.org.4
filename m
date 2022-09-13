Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7555B6945
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiIMINy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiIMINv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:13:51 -0400
Received: from condef-05.nifty.com (condef-05.nifty.com [202.248.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837D85A819;
        Tue, 13 Sep 2022 01:13:49 -0700 (PDT)
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-05.nifty.com with ESMTP id 28D8AWoq009223;
        Tue, 13 Sep 2022 17:10:33 +0900
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 28D87jCf012679;
        Tue, 13 Sep 2022 17:07:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 28D87jCf012679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1663056466;
        bh=hRKy+xo91mWnaRkbQI9H0BNDjBw4xFC3PaudVH84uKI=;
        h=From:To:Cc:Subject:Date:From;
        b=yNo192wRuaSEhwqz7Jo8da84KuMEajeifSpBAT169iQ62zrvK+SonqP89FxangvIr
         wbPKULN2CWPJMgvuSjz+t25TRjr9rUdf+govCwoYsVXB/SORJ6os0IGJV9L5xEH+/y
         wC/cJQQlhLwBCtYuxhsLfzVzx2f27W+JyMYw8jj5DgvlZLQItTvrqpLtnazYJ480Bq
         W/1gted+z6CmebVkUdaVNWYRgdG7e7L6P1fenC4I7RShjZSd3nViUnfX/VvmrjYuEu
         ZOEW1EyIsCbjHZlkcmg0D3pAkHDbnk7GmtcqOF4gtvbVeJ9T2AgVaEfUAmdIudHFu+
         ms6D1GOMMWHmw==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: [PATCH v2] kbuild: move -Wundef from KBUILD_CFLAGS to KBUILD_CPPFLAGS
Date:   Tue, 13 Sep 2022 17:07:27 +0900
Message-Id: <20220913080727.608495-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of an undefined macro in an #if directive is warned, but only
in *.c files. No warning from other files such as *.S, *.lds.S.

Since -Wundef is a preprocessor-related warning, it should be added to
KBUILD_CPPFLAGS instead of KBUILD_CFLAGS.

Fix some uncovered issues.

[1] Add -D__LINUX_ARM_ARCH__=* to KBUILD_CPPFLAGS

In file included from arch/arm/kernel/vmlinux.lds.S:13:
./arch/arm/include/asm/cache.h:23:31: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
   23 | #if defined(CONFIG_AEABI) && (__LINUX_ARM_ARCH__ >= 5)
      |                               ^~~~~~~~~~~~~~~~~~

[2] Add missing #include <asm/pgtable.h>

In file included from arch/arm/mm/cache-v7.S:17:
arch/arm/mm/proc-macros.S:109:5: warning: "L_PTE_SHARED" is not defined, evaluates to 0 [-Wundef]
  109 | #if L_PTE_SHARED != PTE_EXT_SHARED
      |     ^~~~~~~~~~~~
arch/arm/mm/proc-macros.S:109:21: warning: "PTE_EXT_SHARED" is not defined, evaluates to 0 [-Wundef]
  109 | #if L_PTE_SHARED != PTE_EXT_SHARED
      |                     ^~~~~~~~~~~~~~
arch/arm/mm/proc-macros.S:113:10: warning: "L_PTE_XN" is not defined, evaluates to 0 [-Wundef]
  113 |         (L_PTE_XN+L_PTE_USER+L_PTE_RDONLY+L_PTE_DIRTY+L_PTE_YOUNG+\
      |          ^~~~~~~~
arch/arm/mm/proc-macros.S:113:19: warning: "L_PTE_USER" is not defined, evaluates to 0 [-Wundef]
  113 |         (L_PTE_XN+L_PTE_USER+L_PTE_RDONLY+L_PTE_DIRTY+L_PTE_YOUNG+\
      |                   ^~~~~~~~~~
arch/arm/mm/proc-macros.S:113:30: warning: "L_PTE_RDONLY" is not defined, evaluates to 0 [-Wundef]
  113 |         (L_PTE_XN+L_PTE_USER+L_PTE_RDONLY+L_PTE_DIRTY+L_PTE_YOUNG+\
      |                              ^~~~~~~~~~~~
arch/arm/mm/proc-macros.S:113:43: warning: "L_PTE_DIRTY" is not defined, evaluates to 0 [-Wundef]
  113 |         (L_PTE_XN+L_PTE_USER+L_PTE_RDONLY+L_PTE_DIRTY+L_PTE_YOUNG+\
      |                                           ^~~~~~~~~~~
arch/arm/mm/proc-macros.S:113:55: warning: "L_PTE_YOUNG" is not defined, evaluates to 0 [-Wundef]
  113 |         (L_PTE_XN+L_PTE_USER+L_PTE_RDONLY+L_PTE_DIRTY+L_PTE_YOUNG+\
      |                                                       ^~~~~~~~~~~
arch/arm/mm/proc-macros.S:114:10: warning: "L_PTE_PRESENT" is not defined, evaluates to 0 [-Wundef]
  114 |          L_PTE_PRESENT) > L_PTE_SHARED
      |          ^~~~~~~~~~~~~
arch/arm/mm/proc-macros.S:114:27: warning: "L_PTE_SHARED" is not defined, evaluates to 0 [-Wundef]
  114 |          L_PTE_PRESENT) > L_PTE_SHARED
      |                           ^~~~~~~~~~~~

[3] #if -> #ifdef

arch/riscv/kernel/head.S:329:5: warning: "CONFIG_RISCV_BOOT_SPINWAIT" is not defined, evaluates to 0 [-Wundef]
  329 | #if CONFIG_RISCV_BOOT_SPINWAIT
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~

[4] #elif -> #elif defined()

arch/s390/boot/decompressor.c:28:7: warning: "CONFIG_KERNEL_ZSTD" is not defined, evaluates to 0 [-Wundef]
   28 | #elif CONFIG_KERNEL_ZSTD
      |       ^~~~~~~~~~~~~~~~~~

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Fix warnings

 Makefile                      | 4 ++--
 arch/arm/Makefile             | 1 +
 arch/arm/mm/proc-macros.S     | 1 +
 arch/riscv/kernel/head.S      | 2 +-
 arch/s390/boot/decompressor.c | 2 +-
 5 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 4beeb96f9d81..bf4328535cf9 100644
--- a/Makefile
+++ b/Makefile
@@ -523,12 +523,12 @@ LINUXINCLUDE    := \
 		$(USERINCLUDE)
 
 KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
-KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
+KBUILD_CFLAGS   := -Wall -Werror=strict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
 		   -Werror=implicit-function-declaration -Werror=implicit-int \
 		   -Werror=return-type -Wno-format-security \
 		   -std=gnu11
-KBUILD_CPPFLAGS := -D__KERNEL__
+KBUILD_CPPFLAGS := -D__KERNEL__ -Wundef
 KBUILD_AFLAGS_KERNEL :=
 KBUILD_CFLAGS_KERNEL :=
 KBUILD_AFLAGS_MODULE  := -DMODULE
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 29d15c9a433e..4bb5743fe3a4 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -129,6 +129,7 @@ AFLAGS_ISA	:=$(CFLAGS_ISA)
 endif
 
 # Need -Uarm for gcc < 3.x
+KBUILD_CPPFLAGS	+= $(filter -D%, $(arch-y))
 KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
 KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
 
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index fa6999e24b07..e43f6d716b4b 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -6,6 +6,7 @@
  *  VM_EXEC
  */
 #include <asm/asm-offsets.h>
+#include <asm/pgtable.h>
 #include <asm/thread_info.h>
 
 #ifdef CONFIG_CPU_V7M
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index b865046e4dbb..4bf6c449d78b 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -326,7 +326,7 @@ clear_bss_done:
 	call soc_early_init
 	tail start_kernel
 
-#if CONFIG_RISCV_BOOT_SPINWAIT
+#ifdef CONFIG_RISCV_BOOT_SPINWAIT
 .Lsecondary_start:
 	/* Set trap vector to spin forever to help debug */
 	la a3, .Lsecondary_park
diff --git a/arch/s390/boot/decompressor.c b/arch/s390/boot/decompressor.c
index e27c2140d620..f96657faffdc 100644
--- a/arch/s390/boot/decompressor.c
+++ b/arch/s390/boot/decompressor.c
@@ -25,7 +25,7 @@
 
 #ifdef CONFIG_KERNEL_BZIP2
 #define BOOT_HEAP_SIZE	0x400000
-#elif CONFIG_KERNEL_ZSTD
+#elif defined(CONFIG_KERNEL_ZSTD)
 #define BOOT_HEAP_SIZE	0x30000
 #else
 #define BOOT_HEAP_SIZE	0x10000
-- 
2.34.1

