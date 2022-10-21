Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A290607FF3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJUUkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJUUj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:39:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515614B0E1;
        Fri, 21 Oct 2022 13:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666384795; x=1697920795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RDEkaaUj9KHHIXsWt/PpifWBMvlEQIpGtFe7sanP2/w=;
  b=RV5+3YpzSU15kabu9tqArP2OVtik/BHYe8dMvQGLqgyYSLBbT4I2XvbK
   ZMiDV9hNs371H/NCwuTzS8ptEGhUsUVP1Kc2sCiNweNOaPvFPG1NEHsIu
   l4dImo6INhas9Df6Pw2SKswRQvDbcCkSWqswIbfCkVZxfVI9vqh3Bg4/v
   X+RiAmFjG1nnkFEDm31j7cz/yW3HiEByJlcyLBDrv6F8GHxeb5lpSFnuq
   G4scU6X8IudolnE0hbKc1mWldz3j3+m7hxZFyVyaf/nId56skOMt72Eqw
   pOhXNe0H1eJvIVKc+6N4YAtTCREwiozhrkxgE1RjrJ7PE1KQpFfTjhfYj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="369161177"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="369161177"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:35:35 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="735701008"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="735701008"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:35:34 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com
Subject: [PATCH 05/14] x86/microcode/intel: Expose find_matching_signature() for IFS
Date:   Fri, 21 Oct 2022 13:34:04 -0700
Message-Id: <20221021203413.1220137-6-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221021203413.1220137-1-jithu.joseph@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
is fit to run on a system. Add microcode_intel_ prefix to the
function name.

No functional change

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 arch/x86/include/asm/microcode_intel.h |  3 +++
 arch/x86/kernel/cpu/microcode/intel.c  | 19 ++++++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index 4c92cea7e4b5..33db2a62ed34 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -74,12 +74,15 @@ extern void load_ucode_intel_ap(void);
 extern void show_ucode_info_early(void);
 extern int __init save_microcode_in_initrd_intel(void);
 void reload_ucode_intel(void);
+int microcode_intel_find_matching_signature(void *mc, unsigned int csig, int cpf);
 #else
 static inline __init void load_ucode_intel_bsp(void) {}
 static inline void load_ucode_intel_ap(void) {}
 static inline void show_ucode_info_early(void) {}
 static inline int __init save_microcode_in_initrd_intel(void) { return -EINVAL; }
 static inline void reload_ucode_intel(void) {}
+static inline int microcode_intel_find_matching_signature(void *mc, unsigned int csig, int cpf)
+	{ return 0; }
 #endif
 
 #endif /* _ASM_X86_MICROCODE_INTEL_H */
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 025c8f0cd948..f0cc60d92dfc 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -48,7 +48,7 @@ static int llc_size_per_core;
 /*
  * Returns 1 if update has been found, 0 otherwise.
  */
-static int find_matching_signature(void *mc, unsigned int csig, int cpf)
+int microcode_intel_find_matching_signature(void *mc, unsigned int csig, int cpf)
 {
 	struct microcode_header_intel *mc_hdr = mc;
 	struct extended_sigtable *ext_hdr;
@@ -72,6 +72,7 @@ static int find_matching_signature(void *mc, unsigned int csig, int cpf)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(microcode_intel_find_matching_signature);
 
 /*
  * Returns 1 if update has been found, 0 otherwise.
@@ -83,7 +84,7 @@ static int has_newer_microcode(void *mc, unsigned int csig, int cpf, int new_rev
 	if (mc_hdr->rev <= new_rev)
 		return 0;
 
-	return find_matching_signature(mc, csig, cpf);
+	return microcode_intel_find_matching_signature(mc, csig, cpf);
 }
 
 static struct ucode_patch *memdup_patch(void *data, unsigned int size)
@@ -117,7 +118,7 @@ static void save_microcode_patch(struct ucode_cpu_info *uci, void *data, unsigne
 		sig	     = mc_saved_hdr->sig;
 		pf	     = mc_saved_hdr->pf;
 
-		if (find_matching_signature(data, sig, pf)) {
+		if (microcode_intel_find_matching_signature(data, sig, pf)) {
 			prev_found = true;
 
 			if (mc_hdr->rev <= mc_saved_hdr->rev)
@@ -149,7 +150,7 @@ static void save_microcode_patch(struct ucode_cpu_info *uci, void *data, unsigne
 	if (!p)
 		return;
 
-	if (!find_matching_signature(p->data, uci->cpu_sig.sig, uci->cpu_sig.pf))
+	if (!microcode_intel_find_matching_signature(p->data, uci->cpu_sig.sig, uci->cpu_sig.pf))
 		return;
 
 	/*
@@ -286,8 +287,8 @@ scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
 
 		size -= mc_size;
 
-		if (!find_matching_signature(data, uci->cpu_sig.sig,
-					     uci->cpu_sig.pf)) {
+		if (!microcode_intel_find_matching_signature(data, uci->cpu_sig.sig,
+							     uci->cpu_sig.pf)) {
 			data += mc_size;
 			continue;
 		}
@@ -652,9 +653,9 @@ static struct microcode_intel *find_patch(struct ucode_cpu_info *uci)
 		if (phdr->rev <= uci->cpu_sig.rev)
 			continue;
 
-		if (!find_matching_signature(phdr,
-					     uci->cpu_sig.sig,
-					     uci->cpu_sig.pf))
+		if (!microcode_intel_find_matching_signature(phdr,
+							     uci->cpu_sig.sig,
+							     uci->cpu_sig.pf))
 			continue;
 
 		return iter->data;
-- 
2.25.1

