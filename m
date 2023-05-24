Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA92E70FC42
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbjEXRKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbjEXRKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:10:22 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF0113E;
        Wed, 24 May 2023 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684948220; x=1716484220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=EqZrJYyo/GziPMZxaJs9+u1mtCZh0+buRAvMpDKc0L8=;
  b=IL0cchXpaBMLR1XJRQi1/ZFvICeVWDfCKeQrvFoV3bqWsySDZ7s01vOU
   NsJQTcd08I2I/W7zoxHiogB9ZkQxn/OPdJHD8AR/L+fz+Rulm2jxRTqio
   K4rGeXDbKg9tlcLE7ig3xzH6J0gsyhAbMFOb0xPX0Kxz9XS7czeA3hoWQ
   QHcJWBKdZU6IQAMJ5wHxvQuZKWl+LYFDGcFqozbfkHj2zXzMFTagTkmx7
   qnKq0ATnt9NLLobUu3TnERDmygxMIig77sc32ob4gxIjt1pHHClu67RTR
   0z/MNMBox8+BJ+55xetAFRwfLyisP35U1yiIya5HgkHbS3bbcUTn2T2Qd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="338206669"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="338206669"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:09:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="704427337"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="704427337"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga002.jf.intel.com with ESMTP; 24 May 2023 10:09:50 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com
Cc:     ebiggers@kernel.org, elliott@hpe.com, gmazyland@gmail.com,
        luto@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, mingo@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au, ardb@kernel.org,
        dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com, nhuck@google.com,
        chang.seok.bae@intel.com, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v7 02/12] x86/cpufeature: Enumerate Key Locker feature
Date:   Wed, 24 May 2023 09:57:07 -0700
Message-Id: <20230524165717.14062-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230524165717.14062-1-chang.seok.bae@intel.com>
References: <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230524165717.14062-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Key Locker is a CPU feature to minimize exposure of clear-text key
material. An encoded form, called 'key handle', is referenced for data
encryption or decryption instead of accessing the clear text key.

A wrapping key loaded in the CPU's software-inaccessible state is used
to transform a user key into a key handle. On rarely unexpected
hardware failure, the key could be lost.

Here enumerate this hardware capability. It will not be shown up in
/proc/cpuinfo as userspace usage is not supported. This is because
there is no ABI to coordinate the wrapping-key failure.

The feature supports Advanced Encryption Standard (AES) cipher
algorithm with new SIMD instruction set like its predecessor (AES-NI).
Mark the feature depending on XMM2. The new AES implementation will be
in the crypto library.

Add X86_FEATURE_KEYLOCKER to the disabled features mask at the moment.
It will be enabled under a new config option.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v6:
* Massage the changelog -- re-organize the change descriptions

Changes from RFC v2:
* Do not publish the feature flag to userspace.
* Update the changelog.

Changes from RFC v1:
* Updated the changelog.
---
 arch/x86/include/asm/cpufeatures.h          | 1 +
 arch/x86/include/asm/disabled-features.h    | 8 +++++++-
 arch/x86/include/uapi/asm/processor-flags.h | 2 ++
 arch/x86/kernel/cpu/cpuid-deps.c            | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index cb8ca46213be..4a12673df7e9 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -389,6 +389,7 @@
 #define X86_FEATURE_AVX512_VPOPCNTDQ	(16*32+14) /* POPCNT for vectors of DW/QW */
 #define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
+#define X86_FEATURE_KEYLOCKER		(16*32+23) /* "" Key Locker */
 #define X86_FEATURE_BUS_LOCK_DETECT	(16*32+24) /* Bus Lock detect */
 #define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
 #define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index fafe9be7a6f4..eb841d694ed9 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -38,6 +38,12 @@
 # define DISABLE_OSPKE		(1<<(X86_FEATURE_OSPKE & 31))
 #endif /* CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS */
 
+#ifdef CONFIG_X86_KEYLOCKER
+# define DISABLE_KEYLOCKER	0
+#else
+# define DISABLE_KEYLOCKER	(1<<(X86_FEATURE_KEYLOCKER & 31))
+#endif /* CONFIG_X86_KEYLOCKER */
+
 #ifdef CONFIG_X86_5LEVEL
 # define DISABLE_LA57	0
 #else
@@ -126,7 +132,7 @@
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
-			 DISABLE_ENQCMD)
+			 DISABLE_ENQCMD|DISABLE_KEYLOCKER)
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	0
 #define DISABLED_MASK19	0
diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
index d898432947ff..262348aeaad1 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -128,6 +128,8 @@
 #define X86_CR4_PCIDE		_BITUL(X86_CR4_PCIDE_BIT)
 #define X86_CR4_OSXSAVE_BIT	18 /* enable xsave and xrestore */
 #define X86_CR4_OSXSAVE		_BITUL(X86_CR4_OSXSAVE_BIT)
+#define X86_CR4_KEYLOCKER_BIT	19 /* enable Key Locker */
+#define X86_CR4_KEYLOCKER	_BITUL(X86_CR4_KEYLOCKER_BIT)
 #define X86_CR4_SMEP_BIT	20 /* enable SMEP support */
 #define X86_CR4_SMEP		_BITUL(X86_CR4_SMEP_BIT)
 #define X86_CR4_SMAP_BIT	21 /* enable SMAP support */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index f6748c8bd647..200c5e69f78c 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -81,6 +81,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_XFD,			X86_FEATURE_XGETBV1   },
 	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
+	{ X86_FEATURE_KEYLOCKER,		X86_FEATURE_XMM2      },
 	{}
 };
 
-- 
2.17.1

