Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4986766D2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 15:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjAUOyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 09:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjAUOyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 09:54:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C871A967;
        Sat, 21 Jan 2023 06:54:30 -0800 (PST)
Date:   Sat, 21 Jan 2023 14:54:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674312868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1nCB5yYS/tkI5VyimcBNhdMpiz8n9jB8G7ssJJ7+P5w=;
        b=z4qVJH2G8oMoCQvmRkskhatBlRdn0Y7TiusQ26Xbu1owAsz0zxLTw6yuN3bDgri/SVeHKK
        FXdiCEBwQuGGh1xkGE8PvXkJpLm1+LjYKV466GfS0dmcgBjH+Yvg+OjC+8sbJbXeHa0OE+
        UC6L6st4uwa3uN7aaxvDyNUYQ43YiXhc050cYwoRDrLU0K1Y/BLEFtOlZ3fs6xGPQLSL2o
        oo6K1HSN1Fv5J3StjOiCV0fIpSJ9a5reLlQrk/GRwkV01B9TO3p/weWJ5qsTdBm2EZS9Ra
        eD0CLOO2VVfkUmfwUFjtlXF2UN1vi8qGW3hNS9EPi3G2fs8oLwa1j7EVwIeupg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674312868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1nCB5yYS/tkI5VyimcBNhdMpiz8n9jB8G7ssJJ7+P5w=;
        b=w+zMIFSSpg2SDeIEQt/vrbnp3BzOqWtAZMzsMN0TuijBjkw6ZtteRtlHSRhyOSHGWXKwbT
        bj8PsRC5tbBq5rBA==
From:   "tip-bot2 for Ashok Raj" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Print old and new revision
 during early boot
Cc:     Ashok Raj <ashok.raj@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230120161923.118882-6-ashok.raj@intel.com>
References: <20230120161923.118882-6-ashok.raj@intel.com>
MIME-Version: 1.0
Message-ID: <167431286745.4906.3764375388680449088.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     a9a5cac225b0830d1879640e25231a37e537f0da
Gitweb:        https://git.kernel.org/tip/a9a5cac225b0830d1879640e25231a37e537f0da
Author:        Ashok Raj <ashok.raj@intel.com>
AuthorDate:    Sun, 15 Jan 2023 19:57:27 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 21 Jan 2023 14:55:21 +01:00

x86/microcode/intel: Print old and new revision during early boot

Make early loading message match late loading message and print both old
and new revisions.

This is helpful to know what the BIOS loaded revision is before an early
update.

Cache the early BIOS revision before the microcode update and have
print_ucode_info() print both the old and new revision in the same
format as microcode_reload_late().

  [ bp: Massage, remove useless comment. ]

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230120161923.118882-6-ashok.raj@intel.com
---
 arch/x86/kernel/cpu/microcode/intel.c | 28 ++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 9dbd007..467cf37 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -305,12 +305,10 @@ static bool load_builtin_intel_microcode(struct cpio_data *cp)
 	return false;
 }
 
-/*
- * Print ucode update info.
- */
-static void print_ucode_info(unsigned int new_rev, unsigned int date)
+static void print_ucode_info(int old_rev, int new_rev, unsigned int date)
 {
-	pr_info_once("microcode updated early to revision 0x%x, date = %04x-%02x-%02x\n",
+	pr_info_once("updated early: 0x%x -> 0x%x, date = %04x-%02x-%02x\n",
+		     old_rev,
 		     new_rev,
 		     date & 0xffff,
 		     date >> 24,
@@ -321,6 +319,7 @@ static void print_ucode_info(unsigned int new_rev, unsigned int date)
 
 static int delay_ucode_info;
 static int current_mc_date;
+static int early_old_rev;
 
 /*
  * Print early updated ucode info after printk works. This is delayed info dump.
@@ -331,7 +330,7 @@ void show_ucode_info_early(void)
 
 	if (delay_ucode_info) {
 		intel_cpu_collect_info(&uci);
-		print_ucode_info(uci.cpu_sig.rev, current_mc_date);
+		print_ucode_info(early_old_rev, uci.cpu_sig.rev, current_mc_date);
 		delay_ucode_info = 0;
 	}
 }
@@ -340,29 +339,32 @@ void show_ucode_info_early(void)
  * At this point, we can not call printk() yet. Delay printing microcode info in
  * show_ucode_info_early() until printk() works.
  */
-static void print_ucode(int new_rev, int date)
+static void print_ucode(int old_rev, int new_rev, int date)
 {
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
@@ -379,6 +381,8 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 		return UCODE_OK;
 	}
 
+	old_rev = rev;
+
 	/*
 	 * Writeback and invalidate caches before updating microcode to avoid
 	 * internal issues depending on what the microcode is updating.
@@ -395,9 +399,9 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 	uci->cpu_sig.rev = rev;
 
 	if (early)
-		print_ucode(uci->cpu_sig.rev, mc->hdr.date);
+		print_ucode(old_rev, uci->cpu_sig.rev, mc->hdr.date);
 	else
-		print_ucode_info(uci->cpu_sig.rev, mc->hdr.date);
+		print_ucode_info(old_rev, uci->cpu_sig.rev, mc->hdr.date);
 
 	return 0;
 }
