Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8177363AE5F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiK1RFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbiK1REa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:04:30 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9139CCEC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669655061; x=1701191061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sUd8PGcLmf0h62X2Ul4CkTQ5DWirdTdZV87aw11N5nY=;
  b=SeENT9wRuVYo1IoYbol0al8zOBBc1HxFC0xSt+QjJEY09AZ1bYxnNBF9
   xS1nZrbp38cQ79YMuSa9jXcpzdRSWx56hLRWtbqTGE5fc4I3qfL4E2KyC
   FwdjLZizE2aqOtGLvVvKtLEFTQeKnlfm52xeUDQ/K45BbvBJsREZD998M
   znGnBk1uRNdMtDUSinOekiWg2/hhw5e8Prdol+Gq5cw8d3xY5B2aaAeKb
   JOiqyOpb+chw+RR/QYsd8lYtzjaZ4TyhNd0KLgmNloIgTWtNb2ur4u53J
   xZTvaj92t2UJmd/AllSvzvQL6SrDQ/RPzenbDsIez57fgvxFAF1LIH0dw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="313591618"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="313591618"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 09:04:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="706864621"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="706864621"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 28 Nov 2022 09:04:19 -0800
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        brgerst@gmail.com, chang.seok.bae@intel.com, jgross@suse.com
Subject: [PATCH v5 1/5] x86/cpufeature: add the cpu feature bit for LKGS
Date:   Mon, 28 Nov 2022 08:40:24 -0800
Message-Id: <20221128164028.4570-2-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128164028.4570-1-xin3.li@intel.com>
References: <20221128164028.4570-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Add the CPU feature bit for LKGS (Load "Kernel" GS).

LKGS instruction is introduced with Intel FRED (flexible return and
event delivery) specificaton
https://cdrdv2.intel.com/v1/dl/getContent/678938.

LKGS behaves like the MOV to GS instruction except that it loads
the base address into the IA32_KERNEL_GS_BASE MSR instead of the
GS segment’s descriptor cache, which is exactly what Linux kernel
does to load a user level GS base.  Thus, with LKGS, there is no
need to SWAPGS away from the kernel GS base.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---

Change since V2:
* add "" not to show "lkgs" in /proc/cpuinfo (Chang S. Bae).
---
 arch/x86/include/asm/cpufeatures.h       | 1 +
 tools/arch/x86/include/asm/cpufeatures.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index b2da7cb64b31..29f53b31056e 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -311,6 +311,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_LKGS		(12*32+ 18) /* "" Load "kernel" (userspace) gs */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index b71f4f2ecdd5..3dc1a48c2796 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -308,6 +308,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_LKGS		(12*32+ 18) /* "" Load "kernel" (userspace) gs */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
-- 
2.34.1

