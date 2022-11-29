Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4663663CA1C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 22:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbiK2VJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 16:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236770AbiK2VJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:09:07 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5DD1275C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 13:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669756146; x=1701292146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mNhSx3Rnv+AmLrb00ne/8ykmg4QVntYPSdnoX8ENEXo=;
  b=L1ZVpALiyIZ01wWHD/CvedubZSeHxDnirkWpr80wydZs/IHz3QJJQ59/
   bkrezCihOAQokgGMDW5disB/YbnSqu9I1/17T18cE2Ddy5Y5TWECaZJDQ
   EC2K0kckbnWkWi99Ab9B99g+9Av8RnkcFW7n1oNWh90pjlWbZUhRoTzYu
   Dnkz85CuGHg1MUY6DawNmrI6xB58tl7UxiM/knpNdsQB+NIWLf4LG4oYU
   cl5hC70awS6xBTLpuXluy/oCLb92dZ5UNECLB1BcTjabFaoqG29qxmxWj
   181IKXuEYvQwvd5I284451TEf23Jm4zMtZLUh769o38g6H5/SnJ67E/Yl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="317083145"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="317083145"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 13:09:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="646066219"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="646066219"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 13:09:05 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, alison.schofield@intel.com,
        reinette.chatre@intel.com
Subject: [Patch V1 6/7] x86/microcode/intel: Print old and new rev during early boot
Date:   Tue, 29 Nov 2022 13:08:31 -0800
Message-Id: <20221129210832.107850-7-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221129210832.107850-1-ashok.raj@intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make early loading message to match late loading messages. Print
both old and new revisions.

This is helpful to know what the BIOS loaded revision is before an early
update.

microcode: early update: 0x2b000041 -> 0x2b000070 date = 2000-01-01

Store the early BIOS revision and change the print format to match late
loading message from microcode/core.c

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 0a4f511e39ea..3dbcf457f45d 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -309,10 +309,10 @@ static bool load_builtin_intel_microcode(struct cpio_data *cp)
  * Print ucode update info.
  */
 static void
-print_ucode_info(unsigned int new_rev, unsigned int date)
+print_ucode_info(int old_rev, int new_rev, unsigned int date)
 {
-	pr_info_once("microcode updated early to revision 0x%x, date = %04x-%02x-%02x\n",
-		     new_rev,
+	pr_info_once("early update: 0x%x -> 0x%x, date = %04x-%02x-%02x\n",
+		     old_rev, new_rev,
 		     date & 0xffff,
 		     date >> 24,
 		     (date >> 16) & 0xff);
@@ -322,6 +322,7 @@ print_ucode_info(unsigned int new_rev, unsigned int date)
 
 static int delay_ucode_info;
 static int current_mc_date;
+static int early_old_rev;
 
 /*
  * Print early updated ucode info after printk works. This is delayed info dump.
@@ -332,7 +333,7 @@ void show_ucode_info_early(void)
 
 	if (delay_ucode_info) {
 		intel_cpu_collect_info(&uci);
-		print_ucode_info(uci.cpu_sig.rev. current_mc_date);
+		print_ucode_info(early_old_rev, uci.cpu_sig.rev, current_mc_date);
 		delay_ucode_info = 0;
 	}
 }
@@ -341,30 +342,33 @@ void show_ucode_info_early(void)
  * At this point, we can not call printk() yet. Delay printing microcode info in
  * show_ucode_info_early() until printk() works.
  */
-static void print_ucode(int new_rev, int date)
+static void print_ucode(int old_rev, int new_rev, int date)
 {
 	struct microcode_intel *mc;
 	int *delay_ucode_info_p;
 	int *current_mc_date_p;
+	int *early_old_rev_p;
 
 	delay_ucode_info_p = (int *)__pa_nodebug(&delay_ucode_info);
 	current_mc_date_p = (int *)__pa_nodebug(&current_mc_date);
+	early_old_rev_p = (int *)__pa_nodebug(&early_old_rev);
 
 	*delay_ucode_info_p = 1;
 	*current_mc_date_p = date;
+	*early_old_rev_p = old_rev;
 }
 #else
 
-static inline void print_ucode(int new_rev, int date)
+static inline void print_ucode(int old_rev, int new_rev, int date)
 {
-	print_ucode_info(new_rev, date);
+	print_ucode_info(old_rev, new_rev, date);
 }
 #endif
 
 static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 {
 	struct microcode_intel *mc;
-	u32 rev;
+	u32 rev, old_rev;
 
 	mc = uci->mc;
 	if (!mc)
@@ -390,6 +394,7 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 	/* write microcode via MSR 0x79 */
 	native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
+	old_rev = rev;
 	rev = intel_get_microcode_revision();
 	if (rev != mc->hdr.rev)
 		return -1;
@@ -397,9 +402,9 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 	uci->cpu_sig.rev = rev;
 
 	if (early)
-		print_ucode(uci->cpu_sig.rev, mc->hdr.date);
+		print_ucode(old_rev, uci->cpu_sig.rev, mc->hdr.date);
 	else
-		print_ucode_info(uci->cpu_sig.rev, mc->hdr.date);
+		print_ucode_info(old_rev, uci->cpu_sig.rev, mc->hdr.date);
 
 	return 0;
 }
-- 
2.34.1

