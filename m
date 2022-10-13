Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE5C5FE332
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiJMUXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJMUXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:23:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B67159D4B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665692610; x=1697228610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8RCzjNFiyTPAxja/GnLMgLgcV2ZImlmdTYbAFnTLKSI=;
  b=T2jo2jPYSGKBo149pgoWpiFM20creK0j/M1nT1o7lNOG0g3x3+RQVtMG
   ya0V45VnvkCAcqtWQXRMeP2wvaMjAcKM1eyaWxrn9FEl05vsp9PT3kUvV
   WaK9ssyed3dsWGOyl7/cnar3LkqYLrDTxJLTGg9HRfPClj7zXmoOpscoG
   cMXj7kqpnBDa8ycoMa3GPqg80ImsBYl0ao+eOdSdoJR5zCqxlNpgSWV4Z
   0hVO/qtBuB+vcl46rrJ9lBwxTyi0Z6Lh+qjdyfJswr6Ym3lnIJbH7Wuoi
   OBqXMEwpTZL1ZZR+tmJ/Dt7TeTgjiuCh45eSSn5vCvxtM6ZatxKdzAUhf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="302808955"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="302808955"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 13:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="690271039"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="690271039"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 13 Oct 2022 13:23:27 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        brgerst@gmail.com, chang.seok.bae@intel.com
Subject: [PATCH v3 1/6] x86/cpufeature: add cpu feature bit for LKGS
Date:   Thu, 13 Oct 2022 13:01:29 -0700
Message-Id: <20221013200134.1487-2-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013200134.1487-1-xin3.li@intel.com>
References: <20221013200134.1487-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Link: https://lkml.org/lkml/2022/10/11/1139
---
 arch/x86/include/asm/cpufeatures.h       | 1 +
 tools/arch/x86/include/asm/cpufeatures.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index b71f4f2ecdd5..3dc1a48c2796 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -308,6 +308,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_LKGS		(12*32+ 18) /* "" Load "kernel" (userspace) gs */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index ef4775c6db01..9d45071d1730 100644
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

