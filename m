Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8325B5FAA24
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 03:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJKBdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 21:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiJKBc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 21:32:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EB97A741
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 18:32:54 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MmdTR5PPMzVhnD;
        Tue, 11 Oct 2022 09:28:27 +0800 (CST)
Received: from huawei.com (10.67.175.88) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 11 Oct
 2022 09:32:51 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <keescook@chromium.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <kirill.shutemov@linux.intel.com>,
        <tony.luck@intel.com>, <masahiroy@kernel.org>,
        <michael.roth@amd.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>
CC:     <lizetao1@huawei.com>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <brijesh.singh@amd.com>,
        <peterz@infradead.org>, <venu.busireddy@oracle.com>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>
Subject: [PATCH -next v4 2/2] x86/boot/compressed: Add "-Wall" flag to Makefile
Date:   Tue, 11 Oct 2022 01:29:04 +0000
Message-ID: <20221011012904.2330473-3-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012904.2330473-1-lizetao1@huawei.com>
References: <202210090815.526C76396@keescook>
 <20221011012904.2330473-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.88]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
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
---
v1 -> v2: Patch is new
v2 -> v3: Resolve extra warnings after "-Wall" flag added
v3 -> v4: Put this patch at the end

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
index 21febd9f21ab..c062a8230e9c 100644
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
 
 	/*
@@ -41,9 +41,10 @@ __efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len)
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

