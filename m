Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A5A6AF91A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjCGWnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjCGWmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:42:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F2559407;
        Tue,  7 Mar 2023 14:41:56 -0800 (PST)
Date:   Tue, 07 Mar 2023 22:41:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678228890;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fNE135kfip+/55i0Uctu9VE1eiRjfeodH4xQSM4wxck=;
        b=AP0qFDjqhVNIt/H65GJ8kqa3v+coTqM73tPhB++rb9PWWh0CCL0IWpZ+sYZ+ylw648E8jN
        bm4FUkbUeggQMn2lNhpBgh7HG3rgzEvTP05KrHnXRyeKkpiJnp4/eKPiAbK8NdqPxUNlE8
        PCYMiakXn3IEh2bEnLntVfr/Mnkny1nxDLKg1VV95BjstOHzqLFLqGJYwRKO/TLvGyBD2Y
        RLNyl++UjQ5Wg2KzeA0c1ZhMPDO+eWnFrkreey2zY86XO95y9TVvDXsR9Q/Gw8F8bSRPFt
        D+bQrdXQlGNKQDf+/nrDf0WPhbjWC5t/+p+LNej6I00ACFQRbSf25QngwR/zYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678228890;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fNE135kfip+/55i0Uctu9VE1eiRjfeodH4xQSM4wxck=;
        b=I/3uVJJD/bfgPvbsvQNtMLWYFu4V4sBMMWXJnnbOuJCNuLnxlalNAZEdllijS6zFXo35vb
        IFN8A+4eonmo+4Cg==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] tools/x86/kcpuid: Dump the CPUID function in detailed view
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Terry Bowman <terry.bowman@amd.com>,
        Feng Tang <feng.tang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230206141832.4162264-4-terry.bowman@amd.com>
References: <20230206141832.4162264-4-terry.bowman@amd.com>
MIME-Version: 1.0
Message-ID: <167822889002.5837.2464794663329420874.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     cd3ad6619517cda3a055d864a85cebbd434dba9a
Gitweb:        https://git.kernel.org/tip/cd3ad6619517cda3a055d864a85cebbd434dba9a
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 06 Feb 2023 08:18:32 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 07 Mar 2023 23:35:44 +01:00

tools/x86/kcpuid: Dump the CPUID function in detailed view

Sometimes it is useful to know which CPUID leaf contains the fields so
add it to -d output so that it looks like this:

  CPUID_0x8000001e_ECX[0x0]:
           extended_apic_id       : 0x8           - Extended APIC ID
           core_id                : 0x4           - Identifies the logical core ID
           threads_per_core       : 0x1           - The number of threads per core is threads_per_core + 1
           node_id                : 0x0           - Node ID
           nodes_per_processor    : 0x0           - Nodes per processor { 0: 1 node, else reserved }

  CPUID_0x8000001f_ECX[0x0]:
           sme                 -  Secure Memory Encryption

...

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Feng Tang <feng.tang@intel.com>
Link: https://lore.kernel.org/r/20230206141832.4162264-4-terry.bowman@amd.com
---
 tools/arch/x86/kcpuid/kcpuid.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index dae7551..416f5b3 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -33,7 +33,7 @@ struct reg_desc {
 	struct bits_desc descs[32];
 };
 
-enum {
+enum cpuid_reg {
 	R_EAX = 0,
 	R_EBX,
 	R_ECX,
@@ -41,6 +41,10 @@ enum {
 	NR_REGS
 };
 
+static const char * const reg_names[] = {
+	"EAX", "EBX", "ECX", "EDX",
+};
+
 struct subleaf {
 	u32 index;
 	u32 sub;
@@ -428,12 +432,18 @@ static void parse_text(void)
 
 
 /* Decode every eax/ebx/ecx/edx */
-static void decode_bits(u32 value, struct reg_desc *rdesc)
+static void decode_bits(u32 value, struct reg_desc *rdesc, enum cpuid_reg reg)
 {
 	struct bits_desc *bdesc;
 	int start, end, i;
 	u32 mask;
 
+	if (!rdesc->nr) {
+		if (show_details)
+			printf("\t %s: 0x%08x\n", reg_names[reg], value);
+		return;
+	}
+
 	for (i = 0; i < rdesc->nr; i++) {
 		bdesc = &rdesc->descs[i];
 
@@ -468,13 +478,21 @@ static void show_leaf(struct subleaf *leaf)
 	if (!leaf)
 		return;
 
-	if (show_raw)
+	if (show_raw) {
 		leaf_print_raw(leaf);
+	} else {
+		if (show_details)
+			printf("CPUID_0x%x_ECX[0x%x]:\n",
+				leaf->index, leaf->sub);
+	}
+
+	decode_bits(leaf->eax, &leaf->info[R_EAX], R_EAX);
+	decode_bits(leaf->ebx, &leaf->info[R_EBX], R_EBX);
+	decode_bits(leaf->ecx, &leaf->info[R_ECX], R_ECX);
+	decode_bits(leaf->edx, &leaf->info[R_EDX], R_EDX);
 
-	decode_bits(leaf->eax, &leaf->info[R_EAX]);
-	decode_bits(leaf->ebx, &leaf->info[R_EBX]);
-	decode_bits(leaf->ecx, &leaf->info[R_ECX]);
-	decode_bits(leaf->edx, &leaf->info[R_EDX]);
+	if (!show_raw && show_details)
+		printf("\n");
 }
 
 static void show_func(struct cpuid_func *func)
