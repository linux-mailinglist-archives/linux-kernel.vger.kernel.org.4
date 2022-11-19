Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A011630F74
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiKSQYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbiKSQYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:24:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB6E317D3;
        Sat, 19 Nov 2022 08:24:10 -0800 (PST)
Date:   Sat, 19 Nov 2022 16:24:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668875049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwyuqEhU+GvDTJulpvizxyswJIqY1VXbnCAgfmRLe2U=;
        b=BBF9Psl6GBMoVDTMPLEeV69PTnrwmBPVs6XXXHXhdzwSLenoMTvMF24bIAXv2gJvlLq3As
        u7ihvT+9S2Mo/NDV2i1qNlmGCCz/OilAcw5EBfZm7RtZD3p8qjDmN+uMn/XFXOMm2XeZz1
        9O3buDdrYuQUo8Ax5XXj6auHsI/OFHbfpNKgxOIstHm7K0p+U+vDM+JhUHAfhKBQwWJZm2
        yQmiTBCdCPpUv/HuYeZHg98hMIwAd9tzpuiX85Vd/OW+5gTxCLq+tO59x+OWLpp3g0mRcL
        HypztyHtMDpaZu3dpG4TEiU4++lg+ihvll8rLk4I49uYSExjlK19Kj7Xbfg2Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668875049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwyuqEhU+GvDTJulpvizxyswJIqY1VXbnCAgfmRLe2U=;
        b=pI3Z5rDpR5dioXkH3Vy8AI8Fd33/RgP9XUg5NCOEolJ9avKKmXMsmL38F3pJkHE8FsOgH5
        RR1pYCN/npbwB5CQ==
From:   "tip-bot2 for Jithu Joseph" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Reuse microcode_sanity_check()
Cc:     Jithu Joseph <jithu.joseph@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117035935.4136738-8-jithu.joseph@intel.com>
References: <20221117035935.4136738-8-jithu.joseph@intel.com>
MIME-Version: 1.0
Message-ID: <166887504795.4906.14701553568395487074.tip-bot2@tip-bot2>
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

Commit-ID:     514ee839c6d0750c1c4456502e6fa08599e57931
Gitweb:        https://git.kernel.org/tip/514ee839c6d0750c1c4456502e6fa08599e57931
Author:        Jithu Joseph <jithu.joseph@intel.com>
AuthorDate:    Wed, 16 Nov 2022 19:59:26 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Nov 2022 22:00:17 +01:00

x86/microcode/intel: Reuse microcode_sanity_check()

IFS test image carries the same microcode header as regular Intel
microcode blobs.

Reuse microcode_sanity_check() in the IFS driver to perform sanity check
of the IFS test images too.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20221117035935.4136738-8-jithu.joseph@intel.com
---
 arch/x86/include/asm/cpu.h            |   1 +-
 arch/x86/kernel/cpu/intel.c           |  99 ++++++++++++++++++++++++-
 arch/x86/kernel/cpu/microcode/intel.c | 102 +-------------------------
 3 files changed, 102 insertions(+), 100 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index e853440..9e3ac95 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -96,5 +96,6 @@ static inline bool intel_cpu_signatures_match(unsigned int s1, unsigned int p1,
 
 extern u64 x86_read_arch_cap_msr(void);
 int intel_find_matching_signature(void *mc, unsigned int csig, int cpf);
+int intel_microcode_sanity_check(void *mc, bool print_err);
 
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index c7331ec..bef06a1 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -244,6 +244,105 @@ int intel_find_matching_signature(void *mc, unsigned int csig, int cpf)
 }
 EXPORT_SYMBOL_GPL(intel_find_matching_signature);
 
+int intel_microcode_sanity_check(void *mc, bool print_err)
+{
+	unsigned long total_size, data_size, ext_table_size;
+	struct microcode_header_intel *mc_header = mc;
+	struct extended_sigtable *ext_header = NULL;
+	u32 sum, orig_sum, ext_sigcount = 0, i;
+	struct extended_signature *ext_sig;
+
+	total_size = get_totalsize(mc_header);
+	data_size = get_datasize(mc_header);
+
+	if (data_size + MC_HEADER_SIZE > total_size) {
+		if (print_err)
+			pr_err("Error: bad microcode data file size.\n");
+		return -EINVAL;
+	}
+
+	if (mc_header->ldrver != 1 || mc_header->hdrver != 1) {
+		if (print_err)
+			pr_err("Error: invalid/unknown microcode update format.\n");
+		return -EINVAL;
+	}
+
+	ext_table_size = total_size - (MC_HEADER_SIZE + data_size);
+	if (ext_table_size) {
+		u32 ext_table_sum = 0;
+		u32 *ext_tablep;
+
+		if (ext_table_size < EXT_HEADER_SIZE ||
+		    ((ext_table_size - EXT_HEADER_SIZE) % EXT_SIGNATURE_SIZE)) {
+			if (print_err)
+				pr_err("Error: truncated extended signature table.\n");
+			return -EINVAL;
+		}
+
+		ext_header = mc + MC_HEADER_SIZE + data_size;
+		if (ext_table_size != exttable_size(ext_header)) {
+			if (print_err)
+				pr_err("Error: extended signature table size mismatch.\n");
+			return -EFAULT;
+		}
+
+		ext_sigcount = ext_header->count;
+
+		/*
+		 * Check extended table checksum: the sum of all dwords that
+		 * comprise a valid table must be 0.
+		 */
+		ext_tablep = (u32 *)ext_header;
+
+		i = ext_table_size / sizeof(u32);
+		while (i--)
+			ext_table_sum += ext_tablep[i];
+
+		if (ext_table_sum) {
+			if (print_err)
+				pr_warn("Bad extended signature table checksum, aborting.\n");
+			return -EINVAL;
+		}
+	}
+
+	/*
+	 * Calculate the checksum of update data and header. The checksum of
+	 * valid update data and header including the extended signature table
+	 * must be 0.
+	 */
+	orig_sum = 0;
+	i = (MC_HEADER_SIZE + data_size) / sizeof(u32);
+	while (i--)
+		orig_sum += ((u32 *)mc)[i];
+
+	if (orig_sum) {
+		if (print_err)
+			pr_err("Bad microcode data checksum, aborting.\n");
+		return -EINVAL;
+	}
+
+	if (!ext_table_size)
+		return 0;
+
+	/*
+	 * Check extended signature checksum: 0 => valid.
+	 */
+	for (i = 0; i < ext_sigcount; i++) {
+		ext_sig = (void *)ext_header + EXT_HEADER_SIZE +
+			  EXT_SIGNATURE_SIZE * i;
+
+		sum = (mc_header->sig + mc_header->pf + mc_header->cksum) -
+		      (ext_sig->sig + ext_sig->pf + ext_sig->cksum);
+		if (sum) {
+			if (print_err)
+				pr_err("Bad extended signature checksum, aborting.\n");
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(intel_microcode_sanity_check);
+
 static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index e48f05e..fb6ff71 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -135,104 +135,6 @@ static void save_microcode_patch(struct ucode_cpu_info *uci, void *data, unsigne
 		intel_ucode_patch = p->data;
 }
 
-static int microcode_sanity_check(void *mc, bool print_err)
-{
-	unsigned long total_size, data_size, ext_table_size;
-	struct microcode_header_intel *mc_header = mc;
-	struct extended_sigtable *ext_header = NULL;
-	u32 sum, orig_sum, ext_sigcount = 0, i;
-	struct extended_signature *ext_sig;
-
-	total_size = get_totalsize(mc_header);
-	data_size = get_datasize(mc_header);
-
-	if (data_size + MC_HEADER_SIZE > total_size) {
-		if (print_err)
-			pr_err("Error: bad microcode data file size.\n");
-		return -EINVAL;
-	}
-
-	if (mc_header->ldrver != 1 || mc_header->hdrver != 1) {
-		if (print_err)
-			pr_err("Error: invalid/unknown microcode update format.\n");
-		return -EINVAL;
-	}
-
-	ext_table_size = total_size - (MC_HEADER_SIZE + data_size);
-	if (ext_table_size) {
-		u32 ext_table_sum = 0;
-		u32 *ext_tablep;
-
-		if ((ext_table_size < EXT_HEADER_SIZE)
-		 || ((ext_table_size - EXT_HEADER_SIZE) % EXT_SIGNATURE_SIZE)) {
-			if (print_err)
-				pr_err("Error: truncated extended signature table.\n");
-			return -EINVAL;
-		}
-
-		ext_header = mc + MC_HEADER_SIZE + data_size;
-		if (ext_table_size != exttable_size(ext_header)) {
-			if (print_err)
-				pr_err("Error: extended signature table size mismatch.\n");
-			return -EFAULT;
-		}
-
-		ext_sigcount = ext_header->count;
-
-		/*
-		 * Check extended table checksum: the sum of all dwords that
-		 * comprise a valid table must be 0.
-		 */
-		ext_tablep = (u32 *)ext_header;
-
-		i = ext_table_size / sizeof(u32);
-		while (i--)
-			ext_table_sum += ext_tablep[i];
-
-		if (ext_table_sum) {
-			if (print_err)
-				pr_warn("Bad extended signature table checksum, aborting.\n");
-			return -EINVAL;
-		}
-	}
-
-	/*
-	 * Calculate the checksum of update data and header. The checksum of
-	 * valid update data and header including the extended signature table
-	 * must be 0.
-	 */
-	orig_sum = 0;
-	i = (MC_HEADER_SIZE + data_size) / sizeof(u32);
-	while (i--)
-		orig_sum += ((u32 *)mc)[i];
-
-	if (orig_sum) {
-		if (print_err)
-			pr_err("Bad microcode data checksum, aborting.\n");
-		return -EINVAL;
-	}
-
-	if (!ext_table_size)
-		return 0;
-
-	/*
-	 * Check extended signature checksum: 0 => valid.
-	 */
-	for (i = 0; i < ext_sigcount; i++) {
-		ext_sig = (void *)ext_header + EXT_HEADER_SIZE +
-			  EXT_SIGNATURE_SIZE * i;
-
-		sum = (mc_header->sig + mc_header->pf + mc_header->cksum) -
-		      (ext_sig->sig + ext_sig->pf + ext_sig->cksum);
-		if (sum) {
-			if (print_err)
-				pr_err("Bad extended signature checksum, aborting.\n");
-			return -EINVAL;
-		}
-	}
-	return 0;
-}
-
 /*
  * Get microcode matching with BSP's model. Only CPUs with the same model as
  * BSP can stay in the platform.
@@ -253,7 +155,7 @@ scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
 		mc_size = get_totalsize(mc_header);
 		if (!mc_size ||
 		    mc_size > size ||
-		    microcode_sanity_check(data, false) < 0)
+		    intel_microcode_sanity_check(data, false) < 0)
 			break;
 
 		size -= mc_size;
@@ -792,7 +694,7 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 		memcpy(mc, &mc_header, sizeof(mc_header));
 		data = mc + sizeof(mc_header);
 		if (!copy_from_iter_full(data, data_size, iter) ||
-		    microcode_sanity_check(mc, true) < 0) {
+		    intel_microcode_sanity_check(mc, true) < 0) {
 			break;
 		}
 
