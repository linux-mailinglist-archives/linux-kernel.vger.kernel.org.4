Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9B6715DA2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjE3Ln4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjE3LnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:43:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B3C18F
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685446980; x=1716982980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lxQeiW6JYz/pE6TkWEBlLtlDS7c64gZ+78ayHEGM6PI=;
  b=c1rSG/rk7gHyDpi1kScvnhxzQucKjXzQb1HTqgvfXriNcoS16gN7oQ/5
   WbIG0LrEeBIBEHyDDECzR92vcthOxHCO1aFr09JeoU+4VCxkM2af7YSt0
   kepIKCxeyqYsXua6mmVsG1Rpm6mtfv2rAa6jdkHmp8xCOrpa1bP+im52A
   sBpXcU2ucyM/dHZ/94IFrkUBZ/5JW7QVU3rzHKbdUQKDNVGizhNEs3bZ8
   /CuH6032R0x21wwAP0O2uJCDUz7ArGpF0rMZm1kJO1nkuuEtIjq3c0BFg
   +q4iuCL67Q4nY3gw/LI3t2mYIpNDt7bBHc5Ni8MvY1DxkOqlEiYK2aI2b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="383145337"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="383145337"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 04:42:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="700588607"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="700588607"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 May 2023 04:42:57 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
Cc:     Yian Chen <yian.chen@intel.com>
Subject: [PATCH v2 01/12] x86/cpu: Enumerate the LASS feature bits
Date:   Tue, 30 May 2023 14:42:36 +0300
Message-Id: <20230530114247.21821-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530114247.21821-1-alexander.shishkin@linux.intel.com>
References: <20230530114247.21821-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sohil Mehta <sohil.mehta@intel.com>

Linear Address Space Separation (LASS) is a security feature that
intends to prevent malicious virtual address space accesses across
user/kernel mode.

Such mode based access protection already exists today with paging and
features such as SMEP and SMAP. However, to enforce these protections,
the processor must traverse the paging structures in memory.  Malicious
software can use timing information resulting from this traversal to
determine details about the paging structures, and these details may
also be used to determine the layout of the kernel memory.

The LASS mechanism provides the same mode-based protections as paging
but without traversing the paging structures. Because the protections
enforced by LASS are applied before paging, software will not be able to
derive paging-based timing information from the various caching
structures such as the TLBs, mid-level caches, page walker, data caches,
etc.

LASS enforcement relies on the typical kernel implementation to divide
the 64-bit virtual address space into two halves:
  Addr[63]=0 -> User address space
  Addr[63]=1 -> Kernel address space

Any data access or code execution across address spaces typically
results in a #GP fault.

The LASS enforcement for kernel data access is dependent on CR4.SMAP
being set. The enforcement can be disabled by toggling the RFLAGS.AC bit
similar to SMAP.

Define the CPU feature bits to enumerate this feature and include
feature dependencies to reflect the same.

Co-developed-by: Yian Chen <yian.chen@intel.com>
Signed-off-by: Yian Chen <yian.chen@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/include/asm/cpufeatures.h          | 1 +
 arch/x86/include/asm/disabled-features.h    | 4 +++-
 arch/x86/include/asm/smap.h                 | 4 ++++
 arch/x86/include/uapi/asm/processor-flags.h | 2 ++
 arch/x86/kernel/cpu/cpuid-deps.c            | 1 +
 tools/arch/x86/include/asm/cpufeatures.h    | 1 +
 6 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index cb8ca46213be..47e775144a34 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -312,6 +312,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_LASS		(12*32+ 6) /* Linear Address Space Separation */
 #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* "" CMPccXADD instructions */
 #define X86_FEATURE_ARCH_PERFMON_EXT	(12*32+ 8) /* "" Intel Architectural PerfMon Extension */
 #define X86_FEATURE_FZRM		(12*32+10) /* "" Fast zero-length REP MOVSB */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index fafe9be7a6f4..6535e5192082 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -22,12 +22,14 @@
 # define DISABLE_CYRIX_ARR	(1<<(X86_FEATURE_CYRIX_ARR & 31))
 # define DISABLE_CENTAUR_MCR	(1<<(X86_FEATURE_CENTAUR_MCR & 31))
 # define DISABLE_PCID		0
+# define DISABLE_LASS		0
 #else
 # define DISABLE_VME		0
 # define DISABLE_K6_MTRR	0
 # define DISABLE_CYRIX_ARR	0
 # define DISABLE_CENTAUR_MCR	0
 # define DISABLE_PCID		(1<<(X86_FEATURE_PCID & 31))
+# define DISABLE_LASS		(1<<(X86_FEATURE_LASS & 31))
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
@@ -122,7 +124,7 @@
 #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
 			 DISABLE_CALL_DEPTH_TRACKING)
 #define DISABLED_MASK12	(DISABLE_LAM)
-#define DISABLED_MASK13	0
+#define DISABLED_MASK13	(DISABLE_LASS)
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index bab490379c65..776dce849a58 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -27,6 +27,10 @@
 
 #else /* __ASSEMBLY__ */
 
+/*
+ * The CLAC/STAC instructions toggle enforcement of X86_FEATURE_SMAP as well as
+ * X86_FEATURE_LASS.
+ */
 static __always_inline void clac(void)
 {
 	/* Note: a barrier is implicit in alternative() */
diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
index d898432947ff..1d2405869c7a 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -136,6 +136,8 @@
 #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
 #define X86_CR4_CET_BIT		23 /* enable Control-flow Enforcement Technology */
 #define X86_CR4_CET		_BITUL(X86_CR4_CET_BIT)
+#define X86_CR4_LASS_BIT	27 /* enable Linear Address Space Separation support */
+#define X86_CR4_LASS		_BITUL(X86_CR4_LASS_BIT)
 #define X86_CR4_LAM_SUP_BIT	28 /* LAM for supervisor pointers */
 #define X86_CR4_LAM_SUP		_BITUL(X86_CR4_LAM_SUP_BIT)
 
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index f6748c8bd647..722020b2e837 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -81,6 +81,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_XFD,			X86_FEATURE_XGETBV1   },
 	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
+	{ X86_FEATURE_LASS,			X86_FEATURE_SMAP      },
 	{}
 };
 
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index b89005819cd5..59d2880be0e0 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -311,6 +311,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_LASS		(12*32+ 6) /* Linear Address Space Separation */
 #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* "" CMPccXADD instructions */
 #define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
-- 
2.39.2

