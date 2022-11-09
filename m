Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CEC62307E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiKIQwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiKIQwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:52:10 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B161116C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668012729; x=1699548729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7qeZVouD+LQqNvYdTdPAJZv4Un9wdAzppe5kV3GbELE=;
  b=Bq1/t/8K4e8jOpLMqy0ba0hZ4c8OW+QLTeg80JNpE9fmsO+eHOP8+8UZ
   ri5ln/IY3aKOEmCogI1lAjMoeBuKq5cAsxPFODL9MdawxIcYYD76R7IF+
   P8ivRCm/YiXeOGO2un/V5GRrtnGB/Ezw536dBMX68yyTU9yfbsThWpN/I
   1eOJUuPfSaMKOXX5r5SuBSwa+8br/gqnNdUj07oxDfGSovIwUKwNsu1NG
   ABeOIr1hqbgEDMTboFIVxSrScZX9cu9uawwKyqJCa9lr7FQznTySAOyZB
   K6V7BA5Z30C4YD6OKw2RKXwhXfswD1/7xF3cfmFr+FPtH8m+SIzdeuMaR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="294405264"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="294405264"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:52:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="700426421"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="700426421"
Received: from dschramm-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.219.85])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:52:03 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 6D74B10946E; Wed,  9 Nov 2022 19:52:00 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv12 02/16] x86: CPUID and CR3/CR4 flags for Linear Address Masking
Date:   Wed,  9 Nov 2022 19:51:26 +0300
Message-Id: <20221109165140.9137-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221109165140.9137-1-kirill.shutemov@linux.intel.com>
References: <20221109165140.9137-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enumerate Linear Address Masking and provide defines for CR3 and CR4
flags.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/cpufeatures.h          | 1 +
 arch/x86/include/asm/processor-flags.h      | 2 ++
 arch/x86/include/uapi/asm/processor-flags.h | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index b71f4f2ecdd5..265805e71806 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -308,6 +308,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_LAM			(12*32+26) /* Linear Address Masking */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
diff --git a/arch/x86/include/asm/processor-flags.h b/arch/x86/include/asm/processor-flags.h
index a7f3d9100adb..d8cccadc83a6 100644
--- a/arch/x86/include/asm/processor-flags.h
+++ b/arch/x86/include/asm/processor-flags.h
@@ -28,6 +28,8 @@
  * On systems with SME, one bit (in a variable position!) is stolen to indicate
  * that the top-level paging structure is encrypted.
  *
+ * On systemms with LAM, bits 61 and 62 are used to indicate LAM mode.
+ *
  * All of the remaining bits indicate the physical address of the top-level
  * paging structure.
  *
diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
index c47cc7f2feeb..d898432947ff 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -82,6 +82,10 @@
 #define X86_CR3_PCID_BITS	12
 #define X86_CR3_PCID_MASK	(_AC((1UL << X86_CR3_PCID_BITS) - 1, UL))
 
+#define X86_CR3_LAM_U57_BIT	61 /* Activate LAM for userspace, 62:57 bits masked */
+#define X86_CR3_LAM_U57		_BITULL(X86_CR3_LAM_U57_BIT)
+#define X86_CR3_LAM_U48_BIT	62 /* Activate LAM for userspace, 62:48 bits masked */
+#define X86_CR3_LAM_U48		_BITULL(X86_CR3_LAM_U48_BIT)
 #define X86_CR3_PCID_NOFLUSH_BIT 63 /* Preserve old PCID */
 #define X86_CR3_PCID_NOFLUSH    _BITULL(X86_CR3_PCID_NOFLUSH_BIT)
 
@@ -132,6 +136,8 @@
 #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
 #define X86_CR4_CET_BIT		23 /* enable Control-flow Enforcement Technology */
 #define X86_CR4_CET		_BITUL(X86_CR4_CET_BIT)
+#define X86_CR4_LAM_SUP_BIT	28 /* LAM for supervisor pointers */
+#define X86_CR4_LAM_SUP		_BITUL(X86_CR4_LAM_SUP_BIT)
 
 /*
  * x86-64 Task Priority Register, CR8
-- 
2.38.0

