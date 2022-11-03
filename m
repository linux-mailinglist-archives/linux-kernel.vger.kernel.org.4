Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D9F6186CE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiKCSAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiKCR72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:59:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D7921AA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667498360; x=1699034360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lKzd4BANu2bgNbu2ahohiJ2FtGh1ZWNJCmGjkxUmCxo=;
  b=nHG1xY6DflcvwbmEo/G9ydT0VEuCl/6t+lPle6eaxcw9ux/UaEoBOYSL
   FfL/srFnUKAmglho7bHlDnp3/fI1pXCAnbAzH0F7jFiPfnP4QBpTp7YLU
   T0JjHzR4AMVvJTeplEVgi8AnvP/3kEdZG05oiB58AgDE5tbtvRgzz58eV
   kIGY7JYlP2xKLgPTMuh0s+Je0X9svnHrJxyerluUVqMUIOA9GZ5QKw0I/
   mudviqL3ezeBPB+y241/dTY8rcTsKKydZdVSemmyOe6dYDMKOVsrilEx5
   evIUQkSXTtnayXSXm2H/OE1U1iPOQ0mNzhvDA2a0pfnG3CjFR9d6GVuj9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="308476964"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="308476964"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809762544"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="809762544"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:17 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [v2 02/13] x86/microcode/intel: Print old and new rev after early microcode update
Date:   Thu,  3 Nov 2022 17:58:50 +0000
Message-Id: <20221103175901.164783-3-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103175901.164783-1-ashok.raj@intel.com>
References: <20221103175901.164783-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print the old and new versions of microcode after an early load is
complete. This is useful to know what version was loaded by BIOS before an
early microcode load.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
v2:
 - (Boris) Fix microcode update message consistent for early and late.
 - apply_microcode_intel(): prev_rev isn't set until the first update.

 arch/x86/kernel/cpu/microcode/intel.c | 32 +++++++++++++++++----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 8f7f8dd6680e..733b5eac0444 100644
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
+	pr_info_once("early update: 0x%x -> 0x%x, date = %04x-%02x-%02x\n",
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
@@ -739,6 +744,9 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		goto out;
 	}
 
+	if (!prev_rev)
+		prev_rev = rev;
+
 	/*
 	 * Writeback and invalidate caches before updating microcode to avoid
 	 * internal issues depending on what the microcode is updating.
@@ -757,8 +765,8 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	}
 
 	if (bsp && rev != prev_rev) {
-		pr_info("updated to revision 0x%x, date = %04x-%02x-%02x\n",
-			rev,
+		pr_info("update 0x%x -> 0x%x, date = %04x-%02x-%02x\n",
+			prev_rev, rev,
 			mc->hdr.date & 0xffff,
 			mc->hdr.date >> 24,
 			(mc->hdr.date >> 16) & 0xff);
-- 
2.34.1

