Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794D96FEC7A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbjEKHNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237287AbjEKHNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:13:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9F861B4;
        Thu, 11 May 2023 00:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683789213; x=1715325213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kQ6bOp51j+wxWxjJPy3B5NdRPxWxbmqROqWc/HTwHTA=;
  b=UrHJeIEoJJWzXBLYO5ED+WnxoFODQYsbDvc9KW8u4xXF208pC+Z0P/Q1
   mc40EssYvdvTQV3MDZC1hxjKf0QdSJkjIfWPSbhxPkB/uFwC6aYwfWpHK
   ekEiBwfrir+SDLRz9LMr/1EumRDeDrnVdN6YbXAYGAlTgbgdYEdPBTZRg
   kKovoGvyNxJmBb35p1KTrELfRv94Mbip5F8To1fSTNKIrZMJ2hBsA0E5e
   +2N+5OdoF6t/uz6kOFBHCM2ii6SBRLLdHmCrainWb9nsyHMbIXJ2kkoJZ
   Cw7orLgoGvGUNli7smLssc2wVbSGex1PV4sQFm9wi90D+nLTZ0Pdcgoaj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="334896571"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="334896571"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 00:13:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="1029512343"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="1029512343"
Received: from embargo.jf.intel.com ([10.165.9.183])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 00:13:22 -0700
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, rppt@kernel.org, binbin.wu@linux.intel.com,
        rick.p.edgecombe@intel.com, weijiang.yang@intel.com,
        john.allen@amd.com, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: [PATCH v3 02/21] x86/cpufeatures: Add CPU feature flags for shadow stacks
Date:   Thu, 11 May 2023 00:08:38 -0400
Message-Id: <20230511040857.6094-3-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230511040857.6094-1-weijiang.yang@intel.com>
References: <20230511040857.6094-1-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

The Control-Flow Enforcement Technology contains two related features,
one of which is Shadow Stacks. Future patches will utilize this feature
for shadow stack support in KVM, so add a CPU feature flags for Shadow
Stacks (CPUID.(EAX=7,ECX=0):ECX[bit 7]).

To protect shadow stack state from malicious modification, the registers
are only accessible in supervisor mode. This implementation
context-switches the registers with XSAVES. Make X86_FEATURE_SHSTK depend
on XSAVES.

The shadow stack feature, enumerated by the CPUID bit described above,
encompasses both supervisor and userspace support for shadow stack. In
near future patches, only userspace shadow stack will be enabled. In
expectation of future supervisor shadow stack support, create a software
CPU capability to enumerate kernel utilization of userspace shadow stack
support. This user shadow stack bit should depend on the HW "shstk"
capability and that logic will be implemented in future patches.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230319001535.23210-4-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/cpufeatures.h       | 2 ++
 arch/x86/include/asm/disabled-features.h | 8 +++++++-
 arch/x86/kernel/cpu/cpuid-deps.c         | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 97327a1e3aff..3993ea7c6312 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -308,6 +308,7 @@
 #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
 #define X86_FEATURE_SMBA		(11*32+21) /* "" Slow Memory Bandwidth Allocation */
 #define X86_FEATURE_BMEC		(11*32+22) /* "" Bandwidth Monitoring Event Configuration */
+#define X86_FEATURE_USER_SHSTK		(11*32+23) /* Shadow stack support for user mode applications */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
@@ -379,6 +380,7 @@
 #define X86_FEATURE_OSPKE		(16*32+ 4) /* OS Protection Keys Enable */
 #define X86_FEATURE_WAITPKG		(16*32+ 5) /* UMONITOR/UMWAIT/TPAUSE Instructions */
 #define X86_FEATURE_AVX512_VBMI2	(16*32+ 6) /* Additional AVX512 Vector Bit Manipulation Instructions */
+#define X86_FEATURE_SHSTK		(16*32+ 7) /* "" Shadow stack */
 #define X86_FEATURE_GFNI		(16*32+ 8) /* Galois Field New Instructions */
 #define X86_FEATURE_VAES		(16*32+ 9) /* Vector AES */
 #define X86_FEATURE_VPCLMULQDQ		(16*32+10) /* Carry-Less Multiplication Double Quadword */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 5dfa4fb76f4b..505f78ddca82 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -99,6 +99,12 @@
 # define DISABLE_TDX_GUEST	(1 << (X86_FEATURE_TDX_GUEST & 31))
 #endif
 
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+#define DISABLE_USER_SHSTK	0
+#else
+#define DISABLE_USER_SHSTK	(1 << (X86_FEATURE_USER_SHSTK & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -114,7 +120,7 @@
 #define DISABLED_MASK9	(DISABLE_SGX)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
-			 DISABLE_CALL_DEPTH_TRACKING)
+			 DISABLE_CALL_DEPTH_TRACKING|DISABLE_USER_SHSTK)
 #define DISABLED_MASK12	0
 #define DISABLED_MASK13	0
 #define DISABLED_MASK14	0
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index f6748c8bd647..e462c1d3800a 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -81,6 +81,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_XFD,			X86_FEATURE_XGETBV1   },
 	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
+	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
 	{}
 };
 
-- 
2.27.0

