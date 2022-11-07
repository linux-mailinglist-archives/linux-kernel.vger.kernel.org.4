Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68E16202BA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiKGWzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiKGWyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:54:47 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE17A2A248;
        Mon,  7 Nov 2022 14:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667861686; x=1699397686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xedD5rsR2yMai2pvQoz8bo86kLt8JC/fqw5ikRQeXNM=;
  b=VW9GzDD9imMwClBKMRKA3mN8/e45msywwT5iLftdbHWpC6vj3TQNWbDg
   rTsFqPeMJ5SI+uQl/VMBXA3MLpGGxE/nKprCHfWhu8LD+ixPgz7I079SX
   8fJeaFADI54H6qxef4IxdZYWn+2K1dPIxAp4voSQTSp5fhr9CqXs3okWb
   AHoHQWGCEtNcQsqkzZgCyjw+MIClY9ORPBvU8Jrjlmiq9rB2V9nza1wSS
   oh5j0qi73THOQmQ5pUBC3U9SmvQzVdmjcx/tlZdKQqrABR4dkSozjhs+8
   R5/FweD9DV6Rb9qtJh9e99zRzFYuVd2UQUgEMti1yS0wQtZn+UMm4wWfv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="293911826"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="293911826"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="811012966"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="811012966"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:45 -0800
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
Subject: [PATCH v2 04/14] x86/microcode/intel: Expose find_matching_signature() for IFS
Date:   Mon,  7 Nov 2022 14:53:13 -0800
Message-Id: <20221107225323.2733518-5-jithu.joseph@intel.com>
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

IFS uses 'scan test images' provided by Intel that can be regarded as
firmware. IFS test image carries microcode header with extended signature
table.

Expose find_matching_signature() for verifying if the test image
header or the extended signature table indicate whether an IFS test image
is fit to run on a system. Move the function to cpu/intel.c and
add intel_ prefix to the function name.

No functional change

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 arch/x86/include/asm/cpu.h            |  1 +
 arch/x86/kernel/cpu/intel.c           | 29 ++++++++++++++++++
 arch/x86/kernel/cpu/microcode/intel.c | 44 +++++----------------------
 3 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index b472ef76826a..e853440b5c65 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -95,5 +95,6 @@ static inline bool intel_cpu_signatures_match(unsigned int s1, unsigned int p1,
 }
 
 extern u64 x86_read_arch_cap_msr(void);
+int intel_find_matching_signature(void *mc, unsigned int csig, int cpf);
 
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 2d7ea5480ec3..b6f9210fb31a 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -216,6 +216,35 @@ int intel_cpu_collect_info(struct ucode_cpu_info *uci)
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
index 1fcbd671f1df..4e611a708718 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -45,34 +45,6 @@ static struct microcode_intel *intel_ucode_patch;
 /* last level cache size per core */
 static int llc_size_per_core;
 
-/*
- * Returns 1 if update has been found, 0 otherwise.
- */
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
 /*
  * Returns 1 if update has been found, 0 otherwise.
  */
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
-- 
2.25.1

