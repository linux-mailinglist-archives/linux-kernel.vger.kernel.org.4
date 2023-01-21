Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3246766D5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 15:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjAUOyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 09:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjAUOyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 09:54:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E4B1C33E;
        Sat, 21 Jan 2023 06:54:30 -0800 (PST)
Date:   Sat, 21 Jan 2023 14:54:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674312868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tWBKl1UuzhL2R2rSpoOl8gKRWg72KzOBUffsfHCo8OQ=;
        b=pRAoVIJRbnaVp0+IjX120L6dNcQTjkKqjkpdllbkxqu47PgRDTNF50OdwzSOTb5gniqWvE
        JrhpD3bGE3kf0J2QpUqp9jgS3GVTv2Bl/SO+UK0fTS63DvPZNCxSM8Icff53IDvIU4KljK
        foyaFmlufjNX4oVn9CltpJcLxfrYS1DpoODkKB9FZdDd5wDaCvbbUOBnc4a3UOND3MQHtS
        pGk3lhWZ860VbU3LrIlm4sM+2D5sRabHGateIWk7kgzKmuwGB4pFrrr0+0djcC/cM8K5yQ
        FaT7YUllutMMOpfrYeI/7tB592Jgg3YrpvCSEaCs4tsoE/l1LAhKzQhuWyDEeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674312868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tWBKl1UuzhL2R2rSpoOl8gKRWg72KzOBUffsfHCo8OQ=;
        b=ENc9qjHRPxGXuBPsdzXtfLnj0DtlKGT6Rb6ydPPCYJ9Cx2nDwnlUszRuA9hoqMgkaicBhb
        FAVWRALWyPDRAqAA==
From:   "tip-bot2 for Ashok Raj" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Pass the microcode revision
 to print_ucode_info() directly
Cc:     Ashok Raj <ashok.raj@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230120161923.118882-5-ashok.raj@intel.com>
References: <20230120161923.118882-5-ashok.raj@intel.com>
MIME-Version: 1.0
Message-ID: <167431286787.4906.11043739743543659187.tip-bot2@tip-bot2>
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

Commit-ID:     174f1b909ab0984e5369a634971fb14a618ca797
Gitweb:        https://git.kernel.org/tip/174f1b909ab0984e5369a634971fb14a618ca797
Author:        Ashok Raj <ashok.raj@intel.com>
AuthorDate:    Mon, 09 Jan 2023 07:35:53 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 21 Jan 2023 14:55:20 +01:00

x86/microcode/intel: Pass the microcode revision to print_ucode_info() directly

print_ucode_info() takes a struct ucode_cpu_info pointer as parameter.
Its sole purpose is to print the microcode revision.

The only available ucode_cpu_info always describes the currently loaded
microcode revision. After a microcode update is successful, this is the
new revision, or on failure it is the original revision.

In preparation for future changes, replace the struct ucode_cpu_info
pointer parameter with a plain integer which contains the revision
number and adjust the call sites accordingly.

No functional change.

  [ bp:
    - Fix + cleanup commit message.
    - Revert arbitrary, unrelated change.
  ]

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230120161923.118882-5-ashok.raj@intel.com
---
 arch/x86/kernel/cpu/microcode/intel.c | 30 +++++++-------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index cac2bdb..9dbd007 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -308,11 +308,10 @@ static bool load_builtin_intel_microcode(struct cpio_data *cp)
 /*
  * Print ucode update info.
  */
-static void
-print_ucode_info(struct ucode_cpu_info *uci, unsigned int date)
+static void print_ucode_info(unsigned int new_rev, unsigned int date)
 {
 	pr_info_once("microcode updated early to revision 0x%x, date = %04x-%02x-%02x\n",
-		     uci->cpu_sig.rev,
+		     new_rev,
 		     date & 0xffff,
 		     date >> 24,
 		     (date >> 16) & 0xff);
@@ -332,7 +331,7 @@ void show_ucode_info_early(void)
 
 	if (delay_ucode_info) {
 		intel_cpu_collect_info(&uci);
-		print_ucode_info(&uci, current_mc_date);
+		print_ucode_info(uci.cpu_sig.rev, current_mc_date);
 		delay_ucode_info = 0;
 	}
 }
@@ -341,33 +340,22 @@ void show_ucode_info_early(void)
  * At this point, we can not call printk() yet. Delay printing microcode info in
  * show_ucode_info_early() until printk() works.
  */
-static void print_ucode(struct ucode_cpu_info *uci)
+static void print_ucode(int new_rev, int date)
 {
-	struct microcode_intel *mc;
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
 
@@ -407,9 +395,9 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 	uci->cpu_sig.rev = rev;
 
 	if (early)
-		print_ucode(uci);
+		print_ucode(uci->cpu_sig.rev, mc->hdr.date);
 	else
-		print_ucode_info(uci, mc->hdr.date);
+		print_ucode_info(uci->cpu_sig.rev, mc->hdr.date);
 
 	return 0;
 }
