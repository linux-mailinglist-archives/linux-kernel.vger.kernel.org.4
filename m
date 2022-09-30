Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B04E5F0359
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 05:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiI3Dba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 23:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiI3DbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 23:31:25 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6151E8D93
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 20:31:24 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MdwdN0Rtvz1P6pW;
        Fri, 30 Sep 2022 11:27:04 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 11:31:22 +0800
Received: from huawei.com (10.67.175.88) by kwepemm600017.china.huawei.com
 (7.193.23.234) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 30 Sep
 2022 11:31:21 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <kirill.shutemov@linux.intel.com>, <akpm@linux-foundation.org>,
        <michael.roth@amd.com>
CC:     <lizetao1@huawei.com>, <nathan@kernel.org>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <masahiroy@kernel.org>, <ndesaulniers@google.com>,
        <brijesh.singh@amd.com>, <peterz@infradead.org>,
        <keescook@chromium.org>, <venu.busireddy@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next v3 1/2] x86/boot/compressed: Add "-Wall" flag to Makefile
Date:   Fri, 30 Sep 2022 03:27:26 +0000
Message-ID: <20220930032727.3451619-2-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930032727.3451619-1-lizetao1@huawei.com>
References: <20220927081512.2456624-1-lizetao1@huawei.com>
 <20220930032727.3451619-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.88]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compressed/Makefile does not have "-Wall" flag, this is the old problem of
x86 not sharing makefiles. Fix by adding "-Wall" flag to Makefile. But when
"-Wall" flag added to Makefile, a few extra warnings were found.

1.
In file included from arch/x86/boot/compressed/misc.c:15:
  In file included from arch/x86/boot/compressed/misc.h:24:
  In file included from ./include/linux/elf.h:6:
  In file included from ./arch/x86/include/asm/elf.h:8:
  In file included from ./include/linux/thread_info.h:60:
  ./arch/x86/include/asm/thread_info.h:175:13: warning: calling
  "__builtin_frame_address" with a nonzero argument is unsafe
  [-Wframe-address]
    oldframe = __builtin_frame_address(1);
               ^~~~~~~~~~~~~~~~~~~~~~~~~~

./arch/x86/include/asm/thread_info.h:177:11: warning: calling
  "__builtin_frame_address" with a nonzero argument is unsafe
  [-Wframe-address]
    frame = __builtin_frame_address(2);
            ^~~~~~~~~~~~~~~~~~~~~~~~~~

This warning is disabled in the main Makefile for this reason so we
should just be able to disable it, adding "frame-address" flag to
Makefile.

2.
arch/x86/boot/compressed/kaslr.c:627:6: warning: unused variable
  "i" [-Wunused-variable]
    int i;
        ^

This happens when CONFIG_MEMORY_HOTREMOVE or CONFIG_ACPI are "n".
Fix by adding "-std=gnu11" flag to Makefile, and we should put
the variable "i" within the for loop.

3.
arch/x86/boot/compressed/acpi.c:23:1: warning: unused function
  "__efi_get_rsdp_addr" [-Wunused-function]

This happens when CONFIG_EFI is disabled for the reason that
function "__efi_get_rsdp_addr" is only called in efi_get_rsdp_addr
when CONFIG_EFI enable. So function "__efi_get_rsdp_addr" should
not be defined when CONFIG_EFI is disabled.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
---
v1 -> v2: patch is new
v2 -> v3: resolve extra warnings after "-Wall" flag added.

 arch/x86/boot/compressed/Makefile | 3 ++-
 arch/x86/boot/compressed/acpi.c   | 5 +++--
 arch/x86/boot/compressed/kaslr.c  | 3 +--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 3a261abb6d15..8918a8306dff 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -35,7 +35,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 # be valid.
 KBUILD_CFLAGS := -m$(BITS) -O2 $(CLANG_FLAGS)
 KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
-KBUILD_CFLAGS += -Wundef
+KBUILD_CFLAGS += -Wundef -Wall -std=gnu11
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 cflags-$(CONFIG_X86_32) := -march=i386
 cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
@@ -44,6 +44,7 @@ KBUILD_CFLAGS += -mno-mmx -mno-sse
 KBUILD_CFLAGS += -ffreestanding -fshort-wchar
 KBUILD_CFLAGS += -fno-stack-protector
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
+KBUILD_CFLAGS += $(call cc-disable-warning, frame-address)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
 KBUILD_CFLAGS += -Wno-pointer-sign
 KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 9caf89063e77..79742ab34e3f 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -19,10 +19,10 @@
  */
 struct mem_vector immovable_mem[MAX_NUMNODES*2];
 
+#ifdef CONFIG_EFI
 static acpi_physical_address
 __efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len)
 {
-#ifdef CONFIG_EFI
 	unsigned long rsdp_addr;
 	int ret;
 
@@ -42,9 +42,10 @@ __efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len)
 		return (acpi_physical_address)rsdp_addr;
 
 	debug_putstr("Error getting RSDP address.\n");
-#endif
+
 	return 0;
 }
+#endif
 
 static acpi_physical_address efi_get_rsdp_addr(void)
 {
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index e476bcbd9b42..4abc9c42cf4d 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -625,7 +625,6 @@ static bool process_mem_region(struct mem_vector *region,
 			       unsigned long minimum,
 			       unsigned long image_size)
 {
-	int i;
 	/*
 	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
 	 * use @region directly.
@@ -645,7 +644,7 @@ static bool process_mem_region(struct mem_vector *region,
 	 * If immovable memory found, filter the intersection between
 	 * immovable memory and @region.
 	 */
-	for (i = 0; i < num_immovable_mem; i++) {
+	for (int i = 0; i < num_immovable_mem; i++) {
 		u64 start, end, entry_end, region_end;
 		struct mem_vector entry;
 
-- 
2.34.1

