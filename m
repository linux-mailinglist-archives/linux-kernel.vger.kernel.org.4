Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7AA662A43
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbjAIPlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjAIPkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:40:19 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB7040C1A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 07:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673278579; x=1704814579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QXXGi44wA/1GusubxcaRaGB7tWBbRqkEstVsOgmVeSs=;
  b=WN+p0Lo1aXEdTYaFloozKoHzX2EocmSvk3Ntfa6qW3o1/r4dW2+pocez
   EFk5PFqttOFe3lDtF5O9XW3Totq86Ew8IB6nqkGX0uAxnoXqjv6I1tIaL
   pGOepCCeEscv53fPszjRlT+24InFpn86iw4LjamiCrLiNL91dnPdEppHB
   LjbzyP4gcc69U5ykTEaGL44/kGAEzvXxvaYdxyQot9A4DIPwc2/YUAhS/
   /Z8ffwF4acSKfbzaOVkRcenv/r4kSfrStkMEVne9/T6AMicTKyr8QA02t
   QYyCGZL87fGqiaL5cvji1havSqtdIr8kz8B4qeFfGe1T9JXePdEGMu9ZA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="385203590"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="385203590"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 07:36:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="902023896"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="902023896"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 07:36:13 -0800
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
Subject: [PATCH v4 6/6] x86/microcode/intel: Print when early microcode loading fails
Date:   Mon,  9 Jan 2023 07:35:55 -0800
Message-Id: <20230109153555.4986-7-ashok.raj@intel.com>
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

Currently when early microcode loading fails there is no way for the
user to know that the update failed.

Store the failed status and pass it to print_ucode_info() so that early
loading failures are captured in dmesg.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
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

Thomas: Fix commit log as suggested.
---
 arch/x86/kernel/cpu/microcode/intel.c | 28 +++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index f24300830ed7..0cdff9ed2a4e 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -310,11 +310,11 @@ static bool load_builtin_intel_microcode(struct cpio_data *cp)
 /*
  * Print ucode update info.
  */
-static void print_ucode_info(int old_rev, int new_rev, unsigned int date)
+static void print_ucode_info(bool failed, int old_rev, int new_rev, unsigned int date)
 {
-	pr_info_once("early update: 0x%x -> 0x%x, date = %04x-%02x-%02x\n",
+	pr_info_once("early update: 0x%x -> 0x%x, date = %04x-%02x-%02x %s\n",
 		     old_rev, new_rev, date & 0xffff, date >> 24,
-		     (date >> 16) & 0xff);
+		     (date >> 16) & 0xff, failed ? "FAILED" : "");
 }
 
 #ifdef CONFIG_X86_32
@@ -322,6 +322,7 @@ static void print_ucode_info(int old_rev, int new_rev, unsigned int date)
 static int delay_ucode_info;
 static int current_mc_date;
 static int early_old_rev;
+static bool early_failed;
 
 /*
  * Print early updated ucode info after printk works. This is delayed info dump.
@@ -332,7 +333,7 @@ void show_ucode_info_early(void)
 
 	if (delay_ucode_info) {
 		intel_cpu_collect_info(&uci);
-		print_ucode_info(early_old_rev, uci.cpu_sig.rev, current_mc_date);
+		print_ucode_info(early_failed, early_old_rev, uci.cpu_sig.rev, current_mc_date);
 		delay_ucode_info = 0;
 	}
 }
@@ -341,26 +342,28 @@ void show_ucode_info_early(void)
  * At this point, we can not call printk() yet. Delay printing microcode info in
  * show_ucode_info_early() until printk() works.
  */
-static void print_ucode(int old_rev, int new_rev, int date)
+static void print_ucode(bool failed, int old_rev, int new_rev, int date)
 {
-	struct microcode_intel *mc;
 	int *delay_ucode_info_p;
 	int *current_mc_date_p;
 	int *early_old_rev_p;
+	bool *early_failed_p;
 
 	delay_ucode_info_p = (int *)__pa_nodebug(&delay_ucode_info);
 	current_mc_date_p = (int *)__pa_nodebug(&current_mc_date);
 	early_old_rev_p = (int *)__pa_nodebug(&early_old_rev);
+	early_failed_p = (bool *)__pa_nodebug(&early_failed);
 
 	*delay_ucode_info_p = 1;
 	*current_mc_date_p = date;
 	*early_old_rev_p = old_rev;
+	*early_failed_p = failed;
 }
 #else
 
-static inline void print_ucode(int old_rev, int new_rev, int date)
+static inline void print_ucode(bool failed, int old_rev, int new_rev, int date)
 {
-	print_ucode_info(old_rev, new_rev, date);
+	print_ucode_info(failed, old_rev, new_rev, date);
 }
 #endif
 
@@ -368,6 +371,7 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 {
 	struct microcode_intel *mc;
 	u32 rev, old_rev;
+	int retval = 0;
 
 	mc = uci->mc;
 	if (!mc)
@@ -396,16 +400,16 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 	old_rev = rev;
 	rev = intel_get_microcode_revision();
 	if (rev != mc->hdr.rev)
-		return -1;
+		retval = -1;
 
 	uci->cpu_sig.rev = rev;
 
 	if (early)
-		print_ucode(old_rev, uci->cpu_sig.rev, mc->hdr.date);
+		print_ucode(retval, old_rev, mc->hdr.rev, mc->hdr.date);
 	else
-		print_ucode_info(old_rev, uci->cpu_sig.rev, mc->hdr.date);
+		print_ucode_info(retval, old_rev, uci->cpu_sig.rev, mc->hdr.date);
 
-	return 0;
+	return retval;
 }
 
 int __init save_microcode_in_initrd_intel(void)
-- 
2.34.1

