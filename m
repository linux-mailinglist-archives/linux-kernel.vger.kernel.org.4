Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36466202BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiKGWzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiKGWys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:54:48 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367A9CE0D;
        Mon,  7 Nov 2022 14:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667861687; x=1699397687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ar0/IOLoKpjgwdmneDbn5qh+QIaaJXDpP25wZqaQ0CU=;
  b=AgBqnE4Wz+MWshklAVbE93xkVOvs999vPyB7l7QRcElD3IILTY5kCgEH
   HvZh5mxKnu1pmo/+5PErtgLTAvQc7gNA3EOOMwK1cWhLWtcZoEV2IZr3L
   BpiY1xt8lvWPHyyCNWHdd2lUN5FRXGRfh1qTSiTHbktCo9Kq1b8IZOsaP
   49SAQhbO/YNKBj2toG6ZFtf/GNAu5lywMG0kTiIGhCA/85gVQeOIp9DMA
   Iv7KPKUa2A/lS8J8BZV/y7s+FOfXmY7/pN98wYnwMzxpdwwhoJ/1e3/Lg
   TMKsT4OUGZpAJHX4fSpMCfM/t439xhOMfkvA9HxMUtdaTKl1WUW3sOPsq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="293911829"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="293911829"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="811012975"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="811012975"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:46 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: [PATCH v2 06/14] x86/microcode/intel: Expose microcode_sanity_check()
Date:   Mon,  7 Nov 2022 14:53:15 -0800
Message-Id: <20221107225323.2733518-7-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107225323.2733518-1-jithu.joseph@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IFS test image carries the same microcode header as regular Intel
microcode blobs. Microcode blobs  use header version of 1,
whereas IFS test images will use header version of 2.

microcode_sanity_check() can be used by IFS driver to perform
sanity check of the IFS test images too.

Refactor header version as a parameter, move it to cpu/intel.c
and expose this function. Qualify the function name with intel.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 arch/x86/include/asm/cpu.h             |   1 +
 arch/x86/include/asm/microcode_intel.h |   1 +
 arch/x86/kernel/cpu/intel.c            | 100 ++++++++++++++++++++++++
 arch/x86/kernel/cpu/microcode/intel.c  | 102 +------------------------
 4 files changed, 104 insertions(+), 100 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index e853440b5c65..4aff5f263973 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -96,5 +96,6 @@ static inline bool intel_cpu_signatures_match(unsigned int s1, unsigned int p1,
 
 extern u64 x86_read_arch_cap_msr(void);
 int intel_find_matching_signature(void *mc, unsigned int csig, int cpf);
+int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_ver);
 
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index 4c92cea7e4b5..6626744c577b 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -41,6 +41,7 @@ struct extended_sigtable {
 #define DEFAULT_UCODE_TOTALSIZE (DEFAULT_UCODE_DATASIZE + MC_HEADER_SIZE)
 #define EXT_HEADER_SIZE		(sizeof(struct extended_sigtable))
 #define EXT_SIGNATURE_SIZE	(sizeof(struct extended_signature))
+#define MICROCODE_HEADER_VER_UCODE	1
 
 #define get_totalsize(mc) \
 	(((struct microcode_intel *)mc)->hdr.datasize ? \
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index b6f9210fb31a..f8a5a25ab502 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -245,6 +245,106 @@ int intel_find_matching_signature(void *mc, unsigned int csig, int cpf)
 }
 EXPORT_SYMBOL_GPL(intel_find_matching_signature);
 
+int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_ver)
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
+			pr_err("Error: invalid/unknown microcode update format.\n");
+		return -EINVAL;
+	}
+
+	if (mc_header->ldrver != 1 || mc_header->hdrver != hdr_ver) {
+		if (print_err)
+			pr_err("Error: invalid/unknown microcode update format. Header version %d\n",
+			       mc_header->hdrver);
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
index 234b163806ea..8cd6ecf7dae1 100644
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
+		    intel_microcode_sanity_check(data, false, MICROCODE_HEADER_VER_UCODE) < 0)
 			break;
 
 		size -= mc_size;
@@ -792,7 +694,7 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 		memcpy(mc, &mc_header, sizeof(mc_header));
 		data = mc + sizeof(mc_header);
 		if (!copy_from_iter_full(data, data_size, iter) ||
-		    microcode_sanity_check(mc, true) < 0) {
+		    intel_microcode_sanity_check(mc, true, MICROCODE_HEADER_VER_UCODE) < 0) {
 			break;
 		}
 
-- 
2.25.1

