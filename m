Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B059656E47
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiL0TYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiL0TX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:23:57 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564007655
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672169037; x=1703705037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iKTyz4kG5wNghmRCTt8/fCMlWiOtY5ulPwSrncqRr5Q=;
  b=ZoD7EV9Z2HYQx7bnX8OHrr89HAc5SfAtsuZcY/TxHoAPmUNHoYBX67KK
   5wfqDnqDV54AVqTw2n6BelTU97TgI9hnx/z5RPITAg21To35GhrZGHgOt
   x6XYxpPraVWYN2OgS24mSdJdxHeODMjdJSDebNFmc1FJ1MKZQqiJPAF5z
   r2WxsFqK3Z4RJkAJ3HT3GscaxfFzb3QwbkLMsBtnMsKYizJk6olfSYMSk
   9sh6gx5dwmlytW29yXZnnnnXfJvIwv0Zt35qg02OwGI3hIbY+CcKY9vBv
   Cr162bL7i3P+eKkQRjU0NjkXpCDKKb6OGF/6cLmVkQtNpSrF6H09FHz/m
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="407011183"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="407011183"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 11:23:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="777234206"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="777234206"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 11:23:54 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v2 5/6] x86/microcode/intel: Print old and new rev during early boot
Date:   Tue, 27 Dec 2022 11:23:39 -0800
Message-Id: <20221227192340.8358-6-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221227192340.8358-1-ashok.raj@intel.com>
References: <20221227192340.8358-1-ashok.raj@intel.com>
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

New dmesg log is shown below.

microcode: early update: 0x2b000041 -> 0x2b000070 date = 2000-01-01

Cache the early BIOS revision before the microcode update and change the
print_ucode_info() so it prints both the old and new revision in the same
format as microcode_reload_late().

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
---
Updates since previous post.

Thomas: Commit log updates as suggested.
---
 arch/x86/kernel/cpu/microcode/intel.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 1d709b72cfd0..f24300830ed7 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -310,10 +310,10 @@ static bool load_builtin_intel_microcode(struct cpio_data *cp)
 /*
  * Print ucode update info.
  */
-static void print_ucode_info(unsigned int new_rev, unsigned int date)
+static void print_ucode_info(int old_rev, int new_rev, unsigned int date)
 {
-	pr_info_once("microcode updated early to revision 0x%x, date = %04x-%02x-%02x\n",
-		     new_rev, date & 0xffff, date >> 24,
+	pr_info_once("early update: 0x%x -> 0x%x, date = %04x-%02x-%02x\n",
+		     old_rev, new_rev, date & 0xffff, date >> 24,
 		     (date >> 16) & 0xff);
 }
 
@@ -321,6 +321,7 @@ static void print_ucode_info(unsigned int new_rev, unsigned int date)
 
 static int delay_ucode_info;
 static int current_mc_date;
+static int early_old_rev;
 
 /*
  * Print early updated ucode info after printk works. This is delayed info dump.
@@ -331,7 +332,7 @@ void show_ucode_info_early(void)
 
 	if (delay_ucode_info) {
 		intel_cpu_collect_info(&uci);
-		print_ucode_info(uci.cpu_sig.rev. current_mc_date);
+		print_ucode_info(early_old_rev, uci.cpu_sig.rev, current_mc_date);
 		delay_ucode_info = 0;
 	}
 }
@@ -340,30 +341,33 @@ void show_ucode_info_early(void)
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
@@ -389,6 +393,7 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 	/* write microcode via MSR 0x79 */
 	native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
+	old_rev = rev;
 	rev = intel_get_microcode_revision();
 	if (rev != mc->hdr.rev)
 		return -1;
@@ -396,9 +401,9 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
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

