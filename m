Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE686638EE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 06:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjAJF5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 00:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjAJF4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 00:56:07 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1733D1F1
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 21:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673330140; x=1704866140;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=R7MJCu3ZiDY9rM5MlAs/0RBtzhmJ5gjCS2Zlw2Bmc6I=;
  b=T4h4aQUGXN4mKJGTV0Hz5xqQJ9/IuLj2GeY5MMRQsOAkhoAuk441Sct/
   wf6NoHRL42+CzlNT8X1ZHbB3FzBsK+nafud6x1Xsq6MMCKBryvvRmCDF/
   69gibfUhzNfPUJ6njNf04ksotI76NwjUH60p0t3Og8ma95hE+AWtHiylL
   4m95HsvSb3LM1LQ9z5g40uOJNWlIWvmEmfWyOAiJS3O+LbS1tE/UGnpWV
   QWHIB6MrzW+lkhYAKKajNJn1CRP64/oGi2/3kq8aRDNCh2mj/mIr5oxLR
   y9/PE8xRkahgdi+NmWUm/QmOsyZqzkGxvjhpPrgpDAvbAQBuFzySzCWiX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="350289954"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="350289954"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 21:55:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="634483733"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="634483733"
Received: from oux.sc.intel.com ([10.3.52.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 21:55:38 -0800
From:   Yian Chen <yian.chen@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Paul Lai <paul.c.lai@intel.com>,
        Yian Chen <yian.chen@intel.com>
Subject: [PATCH 1/7] x86/cpu: Enumerate LASS CPUID and CR4 bits
Date:   Mon,  9 Jan 2023 21:51:58 -0800
Message-Id: <20230110055204.3227669-2-yian.chen@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110055204.3227669-1-yian.chen@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
MIME-Version: 1.0
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

LASS (Linear Address Space Separation) is a CPU feature to
prevent speculative address access in user/kernel mode.

LASS partitions 64-bit virtual address space into two
halves, lower address (LA[63]=0) and upper address
(LA[63]=1). It stops any data access or code execution
    1. from upper half address space to any lower half address
    2, from lower half address space to any upper half address
and generates #GP fault for a violation.

In Linux, this means LASS does not allow both kernel code
to access any user space address and user code to access
any kernel space address.

Signed-off-by: Yian Chen <yian.chen@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/cpufeatures.h          | 1 +
 arch/x86/include/uapi/asm/processor-flags.h | 2 ++
 tools/arch/x86/include/asm/cpufeatures.h    | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 61012476d66e..03b375db026b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -311,6 +311,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_LASS		(12*32+ 6) /* Linear address space separation */
 #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* "" CMPccXADD instructions */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD52[H,L]UQ */
diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
index c47cc7f2feeb..fd84ea8240fc 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -132,6 +132,8 @@
 #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
 #define X86_CR4_CET_BIT		23 /* enable Control-flow Enforcement Technology */
 #define X86_CR4_CET		_BITUL(X86_CR4_CET_BIT)
+#define X86_CR4_LASS_BIT	27 /* enable LASS support */
+#define X86_CR4_LASS		_BITUL(X86_CR4_LASS_BIT)
 
 /*
  * x86-64 Task Priority Register, CR8
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 61012476d66e..03b375db026b 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -311,6 +311,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_LASS		(12*32+ 6) /* Linear address space separation */
 #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* "" CMPccXADD instructions */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD52[H,L]UQ */
-- 
2.34.1

