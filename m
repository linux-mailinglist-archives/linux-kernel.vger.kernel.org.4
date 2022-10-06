Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35A85F6B28
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJFQD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiJFQDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:03:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9CFB1BB8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 09:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665072226; x=1696608226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UDzg+9uANYdDBV+Ra3lQotFnvAmXOEkeoHs76rgla5s=;
  b=i9mtznLfYzD/k+LIldIHb7B3DihI2xGbwXQnlyRDCv5od7RrW+A+LjVs
   Z1n9wNaR4fU07fyiGbNfg9I6Ng46kMAkap2brJ47vcfJrXQs5mErEjEIO
   EIpl4/b9BYdlzmYML6fqI0A+hk/FXuav8OZm2LVbTFkL9SC3TfAzEmqGv
   QMcXL9TF+4UjL3C7xN9R0JUSgp4DpVnDEd07SLQZxV3MIzzXgYQm0Aylu
   8O/FlVWLdhR/o0SMb7Q/41wWNyB+1GMMbITtqR55uy4BUFl3B4vB+SC5n
   loOHwAD1+AqX0oNMFrUiIZXNoH+IJccbsLa7rSSfbfB98YsbsyshhBHYs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="304480698"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="304480698"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 09:02:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="687486224"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="687486224"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 06 Oct 2022 09:02:35 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Subject: [PATCH 1/6] x86/cpufeature: add cpu feature bit for LKGS
Date:   Thu,  6 Oct 2022 08:40:36 -0700
Message-Id: <20221006154041.13001-2-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006154041.13001-1-xin3.li@intel.com>
References: <20221006154041.13001-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
 arch/x86/include/asm/cpufeatures.h       | 1 +
 tools/arch/x86/include/asm/cpufeatures.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index ef4775c6db01..459fb0c21dd4 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -308,6 +308,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_LKGS		(12*32+ 18) /* Load "kernel" (userspace) gs */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index ef4775c6db01..459fb0c21dd4 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -308,6 +308,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_LKGS		(12*32+ 18) /* Load "kernel" (userspace) gs */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
-- 
2.34.1

