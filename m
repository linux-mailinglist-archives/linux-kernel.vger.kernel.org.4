Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6395C5FF450
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiJNUJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiJNUJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:09:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECE21DA362
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665778167; x=1697314167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c7e6tnykc4mVE2lOrJC5yfRma2B2qJ8DsHSzErtQPMA=;
  b=LRVpq6a7TboItEby168TF8j0almAvuDu3ppAlYb+JHrioj32F9qk6Eoz
   WL9tYrjuDeDpBlllfoNj2pOh4XSfXMbjP/QkAOH4PzbdILwsrkRdz2zgL
   9pL1msJ5p3hWgnQi5GUNamjAvVyv6nc36a875bsaKlSARwUD5Qltv7VUl
   o7yVF3Cg+I1KErNZyGnmaebTtg22ITOmHgUKA6Xd3R+k62qhHv5WWS5m3
   4A6oXkfVrGpIWjwtamyiD2eM1CJiKdR901E2sYYwEKwA1oBcwpYXb+nKT
   9uvE/ectMxeo5ll9E1it4vNLpIuizRjEHJhv8pD+/pJCWm8YNkPXjHw39
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="304202151"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="304202151"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="716870137"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="716870137"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:27 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 01/13] x86/microcode/intel: Print old and new rev after early microcode update
Date:   Fri, 14 Oct 2022 13:09:01 -0700
Message-Id: <20221014200913.14644-2-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221014200913.14644-1-ashok.raj@intel.com>
References: <20221014200913.14644-1-ashok.raj@intel.com>
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

Print the old and new versions of microcode after an early load is
complete. This is useful to know what version was loaded by BIOS before an
early microcode load.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 1fcbd671f1df..cf1e2c30b230 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -435,10 +435,10 @@ static bool load_builtin_intel_microcode(struct cpio_data *cp)
  * Print ucode update info.
  */
 static void
-print_ucode_info(struct ucode_cpu_info *uci, unsigned int date)
+print_ucode_info(u32 old_rev, struct ucode_cpu_info *uci, unsigned int date)
 {
-	pr_info_once("microcode updated early to revision 0x%x, date = %04x-%02x-%02x\n",
-		     uci->cpu_sig.rev,
+	pr_info_once("microcode updated early from 0x%x to revision 0x%x, date = %04x-%02x-%02x\n",
+		     old_rev, uci->cpu_sig.rev,
 		     date & 0xffff,
 		     date >> 24,
 		     (date >> 16) & 0xff);
@@ -448,6 +448,7 @@ print_ucode_info(struct ucode_cpu_info *uci, unsigned int date)
 
 static int delay_ucode_info;
 static int current_mc_date;
+static u32 early_old_rev;
 
 /*
  * Print early updated ucode info after printk works. This is delayed info dump.
@@ -458,7 +459,7 @@ void show_ucode_info_early(void)
 
 	if (delay_ucode_info) {
 		intel_cpu_collect_info(&uci);
-		print_ucode_info(&uci, current_mc_date);
+		print_ucode_info(early_old_rev, &uci, current_mc_date);
 		delay_ucode_info = 0;
 	}
 }
@@ -467,11 +468,12 @@ void show_ucode_info_early(void)
  * At this point, we can not call printk() yet. Delay printing microcode info in
  * show_ucode_info_early() until printk() works.
  */
-static void print_ucode(struct ucode_cpu_info *uci)
+static void print_ucode(u32 old_rev, struct ucode_cpu_info *uci)
 {
 	struct microcode_intel *mc;
 	int *delay_ucode_info_p;
 	int *current_mc_date_p;
+	u32 *old_rev_p;
 
 	mc = uci->mc;
 	if (!mc)
@@ -479,13 +481,15 @@ static void print_ucode(struct ucode_cpu_info *uci)
 
 	delay_ucode_info_p = (int *)__pa_nodebug(&delay_ucode_info);
 	current_mc_date_p = (int *)__pa_nodebug(&current_mc_date);
+	old_rev_p = (u32 *)__pa_nodebug(&early_old_rev);
 
 	*delay_ucode_info_p = 1;
 	*current_mc_date_p = mc->hdr.date;
+	*old_rev_p = old_rev;
 }
 #else
 
-static inline void print_ucode(struct ucode_cpu_info *uci)
+static inline void print_ucode(u32 old_rev, struct ucode_cpu_info *uci)
 {
 	struct microcode_intel *mc;
 
@@ -493,14 +497,14 @@ static inline void print_ucode(struct ucode_cpu_info *uci)
 	if (!mc)
 		return;
 
-	print_ucode_info(uci, mc->hdr.date);
+	print_ucode_info(old_rev, uci, mc->hdr.date);
 }
 #endif
 
 static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 {
 	struct microcode_intel *mc;
-	u32 rev;
+	u32 old_rev, rev;
 
 	mc = uci->mc;
 	if (!mc)
@@ -517,6 +521,7 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 		return UCODE_OK;
 	}
 
+	old_rev = rev;
 	/*
 	 * Writeback and invalidate caches before updating microcode to avoid
 	 * internal issues depending on what the microcode is updating.
@@ -533,9 +538,9 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 	uci->cpu_sig.rev = rev;
 
 	if (early)
-		print_ucode(uci);
+		print_ucode(old_rev, uci);
 	else
-		print_ucode_info(uci, mc->hdr.date);
+		print_ucode_info(old_rev, uci, mc->hdr.date);
 
 	return 0;
 }
-- 
2.34.1

