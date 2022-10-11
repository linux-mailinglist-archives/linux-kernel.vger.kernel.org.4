Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB925FAA23
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 03:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiJKBdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 21:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJKBcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 21:32:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919AB78BF1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 18:32:53 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MmdVs70xTzpTKb;
        Tue, 11 Oct 2022 09:29:41 +0800 (CST)
Received: from huawei.com (10.67.175.88) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 11 Oct
 2022 09:32:50 +0800
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
Subject: [PATCH -next v4 1/2] x86/boot: Remove unused variables
Date:   Tue, 11 Oct 2022 01:29:03 +0000
Message-ID: <20221011012904.2330473-2-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012904.2330473-1-lizetao1@huawei.com>
References: <202210090815.526C76396@keescook>
 <20221011012904.2330473-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Gcc report warning as follows:

arch/x86/boot/compressed/efi.c: In function ‘efi_get_system_table’:
arch/x86/boot/compressed/efi.c:62:23: warning: unused variable ‘et’
  [-Wunused-variable]

arch/x86/boot/compressed/efi.c: In function ‘efi_get_conf_table’:
arch/x86/boot/compressed/efi.c:134:13: warning: unused variable
  ‘ret’ [-Wunused-variable]

arch/x86/boot/compressed/acpi.c: In function ‘__efi_get_rsdp_addr’:
arch/x86/boot/compressed/acpi.c:27:13: warning: unused variable
  ‘ret’ [-Wunused-variable]

arch/x86/boot/compressed/acpi.c: In function ‘efi_get_rsdp_addr’:
arch/x86/boot/compressed/acpi.c:55:22: warning: unused variable
  ‘nr_tables’ [-Wunused-variable]

arch/x86/boot/compressed/sev.c: In function ‘enforce_vmpl0’:
arch/x86/boot/compressed/sev.c:256:13: error: unused variable ‘err’
  [-Werror=unused-variable]

Fix these warnings by removing unused variables.

Fixes: 58f3e6b71f42 ("x86/compressed/acpi: Move EFI system table lookup to helper")
Fixes: 61c14ceda840 ("x86/compressed/acpi: Move EFI config table lookup to helper")
Fixes: dee602dd5d14 ("x86/compressed/acpi: Move EFI vendor table lookup to helper")
Fixes: f9d230e893e8 ("x86/boot: Correct RSDP parsing with 32-bit EFI")
Fixes: 81cc3df9a90e ("x86/sev: Check the VMPL level")
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
v1 -> v2: Remove unused variables "et" in efi_get_system_table(), "ret" in
efi_get_conf_table(), "ret" in __efi_get_rsdp_addr() and  "nr_tables" in
efi_get_rsdp_addr()
v2 -> v3: None
v3 -> v4: Put this patch in front

 arch/x86/boot/compressed/acpi.c | 2 --
 arch/x86/boot/compressed/efi.c  | 2 --
 arch/x86/boot/compressed/sev.c  | 1 -
 3 files changed, 5 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 9caf89063e77..21febd9f21ab 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -24,7 +24,6 @@ __efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len)
 {
 #ifdef CONFIG_EFI
 	unsigned long rsdp_addr;
-	int ret;
 
 	/*
 	 * Search EFI system tables for RSDP. Preferred is ACPI_20_TABLE_GUID to
@@ -52,7 +51,6 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	unsigned long cfg_tbl_pa = 0;
 	unsigned int cfg_tbl_len;
 	unsigned long systab_pa;
-	unsigned int nr_tables;
 	enum efi_type et;
 	int ret;
 
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index 6edd034b0b30..6ffd22710ed2 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -59,7 +59,6 @@ unsigned long efi_get_system_table(struct boot_params *bp)
 {
 	unsigned long sys_tbl_pa;
 	struct efi_info *ei;
-	enum efi_type et;
 
 	/* Get systab from boot params. */
 	ei = &bp->efi_info;
@@ -131,7 +130,6 @@ int efi_get_conf_table(struct boot_params *bp, unsigned long *cfg_tbl_pa,
 {
 	unsigned long sys_tbl_pa;
 	enum efi_type et;
-	int ret;
 
 	if (!cfg_tbl_pa || !cfg_tbl_len)
 		return -EINVAL;
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index c93930d5ccbd..b9451761a69a 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -253,7 +253,6 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 static void enforce_vmpl0(void)
 {
 	u64 attrs;
-	int err;
 
 	/*
 	 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
-- 
2.34.1

