Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3E6630F76
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbiKSQY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbiKSQYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:24:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD7D53ECB;
        Sat, 19 Nov 2022 08:24:13 -0800 (PST)
Date:   Sat, 19 Nov 2022 16:24:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668875051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y85SXMqNVywsopsLacss/swAPpJRL4GCyhCe1FMYkxg=;
        b=V961SuXfZEiXXCb6RE8iiSS0Z0B6U7lboAB8Ftmo3KnkQWCGRxjR1YzfJMm4mdZcuyb/+W
        TqpI43iR5rTFjLjvX9ZJbVfoHS5gGpJR/kMza/QzDhCA0nqHX6ceet1ZyuOP5meouSpW43
        tnq8dbfKUhEcm41ODo4otGqVrUSxzF480UjWNhQJkpGTdFxyEoOqkAhBq0wSLnwdQgg4jK
        8XfwiNTkrm8gdBMVr74zp3zRTxcW2incbcCUNvWsbgxWGkNw/Bce+lHSlLrvxtgXaaekmG
        +uInwjIsrPSmx5gXihLlokY2vKJphzhEnuMlRH9UQgNLF4ZeHWL9t35mQROrvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668875051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y85SXMqNVywsopsLacss/swAPpJRL4GCyhCe1FMYkxg=;
        b=NZca6g8T2d8sKb6scuna2T6rmPdcxi3tir8UWCunMcHVKWRRo/EDM2RjrkJ5IWyibYkdt5
        mukpf21m/JaDH8CA==
From:   "tip-bot2 for Jithu Joseph" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Reuse find_matching_signature()
Cc:     Jithu Joseph <jithu.joseph@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117035935.4136738-6-jithu.joseph@intel.com>
References: <20221117035935.4136738-6-jithu.joseph@intel.com>
MIME-Version: 1.0
Message-ID: <166887505019.4906.12287352480309171663.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     716f380275866350ee44447b3c7c999f39c3178d
Gitweb:        https://git.kernel.org/tip/716f380275866350ee44447b3c7c999f39c3178d
Author:        Jithu Joseph <jithu.joseph@intel.com>
AuthorDate:    Wed, 16 Nov 2022 19:59:24 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Nov 2022 21:50:01 +01:00

x86/microcode/intel: Reuse find_matching_signature()

IFS uses test images provided by Intel that can be regarded as firmware.
An IFS test image carries microcode header with an extended signature
table.

Reuse find_matching_signature() for verifying if the test image header
or the extended signature table indicate whether that image is fit to
run on a system.

No functional changes.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20221117035935.4136738-6-jithu.joseph@intel.com
---
 arch/x86/include/asm/cpu.h            |  1 +-
 arch/x86/kernel/cpu/intel.c           | 29 +++++++++++++++++-
 arch/x86/kernel/cpu/microcode/intel.c | 44 ++++----------------------
 3 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index b472ef7..e853440 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -95,5 +95,6 @@ static inline bool intel_cpu_signatures_match(unsigned int s1, unsigned int p1,
 }
 
 extern u64 x86_read_arch_cap_msr(void);
+int intel_find_matching_signature(void *mc, unsigned int csig, int cpf);
 
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index beb8ca5..c7331ec 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -215,6 +215,35 @@ int intel_cpu_collect_info(struct ucode_cpu_info *uci)
 }
 EXPORT_SYMBOL_GPL(intel_cpu_collect_info);
 
+/*
+ * Returns 1 if update has been found, 0 otherwise.
+ */
+int intel_find_matching_signature(void *mc, unsigned int csig, int cpf)
+{
+	struct microcode_header_intel *mc_hdr = mc;
+	struct extended_sigtable *ext_hdr;
+	struct extended_signature *ext_sig;
+	int i;
+
+	if (intel_cpu_signatures_match(csig, cpf, mc_hdr->sig, mc_hdr->pf))
+		return 1;
+
+	/* Look for ext. headers: */
+	if (get_totalsize(mc_hdr) <= get_datasize(mc_hdr) + MC_HEADER_SIZE)
+		return 0;
+
+	ext_hdr = mc + get_datasize(mc_hdr) + MC_HEADER_SIZE;
+	ext_sig = (void *)ext_hdr + EXT_HEADER_SIZE;
+
+	for (i = 0; i < ext_hdr->count; i++) {
+		if (intel_cpu_signatures_match(csig, cpf, ext_sig->sig, ext_sig->pf))
+			return 1;
+		ext_sig++;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(intel_find_matching_signature);
+
 static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 8c35c70..c77ec1b 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -48,34 +48,6 @@ static int llc_size_per_core;
 /*
  * Returns 1 if update has been found, 0 otherwise.
  */
-static int find_matching_signature(void *mc, unsigned int csig, int cpf)
-{
-	struct microcode_header_intel *mc_hdr = mc;
-	struct extended_sigtable *ext_hdr;
-	struct extended_signature *ext_sig;
-	int i;
-
-	if (intel_cpu_signatures_match(csig, cpf, mc_hdr->sig, mc_hdr->pf))
-		return 1;
-
-	/* Look for ext. headers: */
-	if (get_totalsize(mc_hdr) <= get_datasize(mc_hdr) + MC_HEADER_SIZE)
-		return 0;
-
-	ext_hdr = mc + get_datasize(mc_hdr) + MC_HEADER_SIZE;
-	ext_sig = (void *)ext_hdr + EXT_HEADER_SIZE;
-
-	for (i = 0; i < ext_hdr->count; i++) {
-		if (intel_cpu_signatures_match(csig, cpf, ext_sig->sig, ext_sig->pf))
-			return 1;
-		ext_sig++;
-	}
-	return 0;
-}
-
-/*
- * Returns 1 if update has been found, 0 otherwise.
- */
 static int has_newer_microcode(void *mc, unsigned int csig, int cpf, int new_rev)
 {
 	struct microcode_header_intel *mc_hdr = mc;
@@ -83,7 +55,7 @@ static int has_newer_microcode(void *mc, unsigned int csig, int cpf, int new_rev
 	if (mc_hdr->rev <= new_rev)
 		return 0;
 
-	return find_matching_signature(mc, csig, cpf);
+	return intel_find_matching_signature(mc, csig, cpf);
 }
 
 static struct ucode_patch *memdup_patch(void *data, unsigned int size)
@@ -117,7 +89,7 @@ static void save_microcode_patch(struct ucode_cpu_info *uci, void *data, unsigne
 		sig	     = mc_saved_hdr->sig;
 		pf	     = mc_saved_hdr->pf;
 
-		if (find_matching_signature(data, sig, pf)) {
+		if (intel_find_matching_signature(data, sig, pf)) {
 			prev_found = true;
 
 			if (mc_hdr->rev <= mc_saved_hdr->rev)
@@ -149,7 +121,7 @@ static void save_microcode_patch(struct ucode_cpu_info *uci, void *data, unsigne
 	if (!p)
 		return;
 
-	if (!find_matching_signature(p->data, uci->cpu_sig.sig, uci->cpu_sig.pf))
+	if (!intel_find_matching_signature(p->data, uci->cpu_sig.sig, uci->cpu_sig.pf))
 		return;
 
 	/*
@@ -286,8 +258,8 @@ scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
 
 		size -= mc_size;
 
-		if (!find_matching_signature(data, uci->cpu_sig.sig,
-					     uci->cpu_sig.pf)) {
+		if (!intel_find_matching_signature(data, uci->cpu_sig.sig,
+						   uci->cpu_sig.pf)) {
 			data += mc_size;
 			continue;
 		}
@@ -652,9 +624,9 @@ static struct microcode_intel *find_patch(struct ucode_cpu_info *uci)
 		if (phdr->rev <= uci->cpu_sig.rev)
 			continue;
 
-		if (!find_matching_signature(phdr,
-					     uci->cpu_sig.sig,
-					     uci->cpu_sig.pf))
+		if (!intel_find_matching_signature(phdr,
+						   uci->cpu_sig.sig,
+						   uci->cpu_sig.pf))
 			continue;
 
 		return iter->data;
