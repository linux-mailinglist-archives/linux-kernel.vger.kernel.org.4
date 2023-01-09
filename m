Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE26662A41
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbjAIPlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbjAIPkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:40:18 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF0C40C18
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 07:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673278578; x=1704814578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oyjz6XJwnWS6TtsCd6s9DEyvm+PHR2WDUT1F7iZ6FqM=;
  b=UklwSdFWE8e8lGt6XHSRo/YZ6RGdRgVP8qLKeqzDv7hkfP+eIeDdUNSe
   1dHe04NLldtZIaqfs8VPpxlaPx9xzSX9ZcDi+21dRCZVm0ck3SuXLTy69
   kKr5bidWpgN4ZrVNJWobHHUOEmuPy3I89lHEGLMV58D+bjvmj/5lpZ5Yx
   PTivUlxuWhhF8/ojcSgeQCNwcsrxhxpXNoZCyYIpjADPwEpKxC96pS2U+
   h2T88zv/UEZ6l+jjDlcD09xhvVKaa+RVqxFVHRuWMPgbZQqxWyrRX9rT/
   +rEyUx4epiC9grBQUawj5g8YfYAM3Olu1lw/Y7ScwkCtkYr6RKvtZuvgv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="385203578"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="385203578"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 07:36:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="902023890"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="902023890"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 07:36:12 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, alison.schofield@intel.com,
        reinette.chatre@intel.com, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v4 4/6] x86/microcode/intel: Use a plain revision argument for print_ucode_rev()
Date:   Mon,  9 Jan 2023 07:35:53 -0800
Message-Id: <20230109153555.4986-5-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230109153555.4986-1-ashok.raj@intel.com>
References: <20230109153555.4986-1-ashok.raj@intel.com>
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

print_ucode_rev() takes a struct ucode_cpu_info argument. The sole purpose
of it is to print the microcode revision.

The only available ucode_cpu_info always describes the currently loaded
microcode revision. After a microcode update is successful, this is the new
revision, or on failure it is the original revision.

Subsequent changes need to print both the original and new revision, but
the original version will be cached in a plain integer, which makes the
code inconsistent.

Replace the struct ucode_cpu_info argument with a plain integer which
contains the revision number and adjust the call sites accordingly.

No functional change.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: x86 <x86@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
Changes since V1:

Thomas:
 - Updated commit log as suggested
 - Remove the line break after static void before print_ucode_info
---
 arch/x86/kernel/cpu/microcode/intel.c | 31 ++++++++-------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 6bebc46ad8b1..1d709b72cfd0 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -310,13 +310,10 @@ static bool load_builtin_intel_microcode(struct cpio_data *cp)
 /*
  * Print ucode update info.
  */
-static void
-print_ucode_info(struct ucode_cpu_info *uci, unsigned int date)
+static void print_ucode_info(unsigned int new_rev, unsigned int date)
 {
 	pr_info_once("microcode updated early to revision 0x%x, date = %04x-%02x-%02x\n",
-		     uci->cpu_sig.rev,
-		     date & 0xffff,
-		     date >> 24,
+		     new_rev, date & 0xffff, date >> 24,
 		     (date >> 16) & 0xff);
 }
 
@@ -334,7 +331,7 @@ void show_ucode_info_early(void)
 
 	if (delay_ucode_info) {
 		intel_cpu_collect_info(&uci);
-		print_ucode_info(&uci, current_mc_date);
+		print_ucode_info(uci.cpu_sig.rev. current_mc_date);
 		delay_ucode_info = 0;
 	}
 }
@@ -343,33 +340,23 @@ void show_ucode_info_early(void)
  * At this point, we can not call printk() yet. Delay printing microcode info in
  * show_ucode_info_early() until printk() works.
  */
-static void print_ucode(struct ucode_cpu_info *uci)
+static void print_ucode(int new_rev, int date)
 {
 	struct microcode_intel *mc;
 	int *delay_ucode_info_p;
 	int *current_mc_date_p;
 
-	mc = uci->mc;
-	if (!mc)
-		return;
-
 	delay_ucode_info_p = (int *)__pa_nodebug(&delay_ucode_info);
 	current_mc_date_p = (int *)__pa_nodebug(&current_mc_date);
 
 	*delay_ucode_info_p = 1;
-	*current_mc_date_p = mc->hdr.date;
+	*current_mc_date_p = date;
 }
 #else
 
-static inline void print_ucode(struct ucode_cpu_info *uci)
+static inline void print_ucode(int new_rev, int date)
 {
-	struct microcode_intel *mc;
-
-	mc = uci->mc;
-	if (!mc)
-		return;
-
-	print_ucode_info(uci, mc->hdr.date);
+	print_ucode_info(new_rev, date);
 }
 #endif
 
@@ -409,9 +396,9 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 	uci->cpu_sig.rev = rev;
 
 	if (early)
-		print_ucode(uci);
+		print_ucode(uci->cpu_sig.rev, mc->hdr.date);
 	else
-		print_ucode_info(uci, mc->hdr.date);
+		print_ucode_info(uci->cpu_sig.rev, mc->hdr.date);
 
 	return 0;
 }
-- 
2.34.1

