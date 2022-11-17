Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EF162D20F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 05:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbiKQECQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 23:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbiKQEA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 23:00:59 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CE629C89;
        Wed, 16 Nov 2022 20:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668657658; x=1700193658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/jKnZF0EI/Ul02v4UXArfpNKSjRtLlzyX8+VCj36w9M=;
  b=kjUYeysXtixzUGK76MTdMHAqL0oBOOSvtqMwgV9/jDB6NHuYKNL6HuCf
   ixA3t9/a1nR3XczL5CfHoPco1O0Q8dSOMYrsFLgf3pg6naicekOvNzhvv
   s07+q2OBHPoqjWaEItZRGfTD4wcmc+tTEF18OWJTfKMN5lmyLzzXSMIK/
   Og9Q9+AF1alRXy5MSqMtqNdC85ARZsrdPi2wkPfzQt21r5QvNv6OqF6GB
   nXfLoICCqk2U2Jxlkq5/zdtCN1Dph1yh+Hx+ifmWCC0gwrzfXZCsUTWJ/
   nq9oFT+xHnp9bCJQXjEHfj99iBy+beF6nVjdhqb3atPIpD/tu6TBuOhT/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="292455968"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="292455968"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 20:00:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590462690"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="590462690"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 20:00:57 -0800
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
Subject: [PATCH v3 08/16] x86/microcode/intel: Add hdr_type to intel_microcode_sanity_check()
Date:   Wed, 16 Nov 2022 19:59:27 -0800
Message-Id: <20221117035935.4136738-9-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117035935.4136738-1-jithu.joseph@intel.com>
References: <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221117035935.4136738-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IFS test images and microcode blobs use the same header format.
Microcode blobs use header type of 1, whereas IFS test images
will use header type of 2.

In preparation for IFS reusing intel_microcode_sanity_check(),
add header type as a parameter for sanity check.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 arch/x86/include/asm/cpu.h             |  2 +-
 arch/x86/include/asm/microcode_intel.h |  1 +
 arch/x86/kernel/cpu/intel.c            | 19 ++++++++++++++++---
 arch/x86/kernel/cpu/microcode/intel.c  |  4 ++--
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 9e3ac95acf2d..78796b98a544 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -96,6 +96,6 @@ static inline bool intel_cpu_signatures_match(unsigned int s1, unsigned int p1,
 
 extern u64 x86_read_arch_cap_msr(void);
 int intel_find_matching_signature(void *mc, unsigned int csig, int cpf);
-int intel_microcode_sanity_check(void *mc, bool print_err);
+int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type);
 
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index 4c92cea7e4b5..2a999bf91ef0 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -41,6 +41,7 @@ struct extended_sigtable {
 #define DEFAULT_UCODE_TOTALSIZE (DEFAULT_UCODE_DATASIZE + MC_HEADER_SIZE)
 #define EXT_HEADER_SIZE		(sizeof(struct extended_sigtable))
 #define EXT_SIGNATURE_SIZE	(sizeof(struct extended_signature))
+#define MC_HEADER_TYPE_MICROCODE	1
 
 #define get_totalsize(mc) \
 	(((struct microcode_intel *)mc)->hdr.datasize ? \
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 01e73ec1d585..ff305e3784d1 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -245,7 +245,19 @@ int intel_find_matching_signature(void *mc, unsigned int csig, int cpf)
 }
 EXPORT_SYMBOL_GPL(intel_find_matching_signature);
 
-int intel_microcode_sanity_check(void *mc, bool print_err)
+/**
+ * intel_microcode_sanity_check() - Sanity check microcode file.
+ * @mc: Pointer to the microcode file contents.
+ * @print_err: Display failure reason if true, silent if false.
+ * @hdr_type: Type of file, i.e. normal microcode file or In Field Scan file.
+ *            Validate if the microcode header type matches with the type specified here.
+ *
+ * Validate certain header fields and verify if computed checksum matches
+ * with the one specified in the header.
+ *
+ * Return: 0 if the file passes all the checks, -ERR for invalid files
+ */
+int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type)
 {
 	unsigned long total_size, data_size, ext_table_size;
 	struct microcode_header_intel *mc_header = mc;
@@ -262,9 +274,10 @@ int intel_microcode_sanity_check(void *mc, bool print_err)
 		return -EINVAL;
 	}
 
-	if (mc_header->ldrver != 1 || mc_header->hdrver != 1) {
+	if (mc_header->ldrver != 1 || mc_header->hdrver != hdr_type) {
 		if (print_err)
-			pr_err("Error: invalid/unknown microcode update format.\n");
+			pr_err("Error: invalid/unknown microcode update format. Header type %d\n",
+			       mc_header->hdrver);
 		return -EINVAL;
 	}
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index af7134073e65..bf8026304f6f 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -155,7 +155,7 @@ scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
 		mc_size = get_totalsize(mc_header);
 		if (!mc_size ||
 		    mc_size > size ||
-		    intel_microcode_sanity_check(data, false) < 0)
+		    intel_microcode_sanity_check(data, false, MC_HEADER_TYPE_MICROCODE) < 0)
 			break;
 
 		size -= mc_size;
@@ -694,7 +694,7 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 		memcpy(mc, &mc_header, sizeof(mc_header));
 		data = mc + sizeof(mc_header);
 		if (!copy_from_iter_full(data, data_size, iter) ||
-		    intel_microcode_sanity_check(mc, true) < 0) {
+		    intel_microcode_sanity_check(mc, true, MC_HEADER_TYPE_MICROCODE) < 0) {
 			break;
 		}
 
-- 
2.25.1

