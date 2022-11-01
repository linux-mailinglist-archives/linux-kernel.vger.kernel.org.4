Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB1B614436
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 06:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiKAFYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 01:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiKAFYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 01:24:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CE213CD8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 22:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667280265; x=1698816265;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0x5C1nQK2uQCFLLwOkAmqcIqfySyFJsnR0olbPOIh0w=;
  b=GY2mCd+kbHSGOeOLi04lhqBHk6Wdcn76slKyFugBR9UHpSipGWem7+n7
   +3HE3Pd+PsPQLb7H4lDIrFtf02GqsTK3OapyWxehht6g1qFp+B+XhbPk5
   2kLF62qkzBCLyTgcJgHzlCuVKXBHSfx2nDdK7jIPj91brtMexsc95a2gN
   GacJH168tmDrgVlk1ALkvu8Ys1rPJJWxFF3GbF2/UCyPudd2P/Y4yOJ6h
   UdAcwtxG3bn5IIpxVbCIeHrCBJ7Sm5YK/dhAzD0bqyHitldrTB0kBraXC
   0/KQXdgmTSVhsyPqvecAWiF0YjVz1G/GEEqwrob7t0ijwL5SkjRvZ5seg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="292371390"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="292371390"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 22:24:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="759080366"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="759080366"
Received: from louislifei-optiplex-7090.sh.intel.com ([10.239.146.218])
  by orsmga004.jf.intel.com with ESMTP; 31 Oct 2022 22:24:22 -0700
From:   Fei Li <fei1.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org
Cc:     dave.hansen@intel.com, gregkh@linuxfoundation.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, Yu1.Wang@intel.com,
        conghui.chen@intel.com, fengwei.yin@intel.com
Subject: [PATCH v2] x86/acrn: Set X86_FEATURE_TSC_KNOWN_FREQ
Date:   Tue,  1 Nov 2022 13:30:19 +0800
Message-Id: <20221101053019.174948-1-fei1.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the TSC frequency is known from the acrn_get_tsc_khz(),
the TSC frequency does not need to be recalibrated.

Avoiding recalibration by setting X86_FEATURE_TSC_KNOWN_FREQ.
This patch also removes `inline` for acrn_get_tsc_khz() since
it doesn't make sense.

Signed-off-by: Fei Li <fei1.li@intel.com>
Reviewed-by: Yin, Fengwei <fengwei.yin@intel.com>

---
v2:
- Detail the commit message
---
 arch/x86/include/asm/acrn.h | 5 -----
 arch/x86/kernel/cpu/acrn.c  | 6 ++++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
index 1dd14381bcb6..aa12c74ea959 100644
--- a/arch/x86/include/asm/acrn.h
+++ b/arch/x86/include/asm/acrn.h
@@ -30,11 +30,6 @@ static inline u32 acrn_cpuid_base(void)
 	return 0;
 }
 
-static inline unsigned long acrn_get_tsc_khz(void)
-{
-	return cpuid_eax(ACRN_CPUID_TIMING_INFO);
-}
-
 /*
  * Hypercalls for ACRN
  *
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 485441b7f030..c5ff75b6a949 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -24,6 +24,12 @@ static u32 __init acrn_detect(void)
 	return acrn_cpuid_base();
 }
 
+static unsigned long acrn_get_tsc_khz(void)
+{
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+	return cpuid_eax(ACRN_CPUID_TIMING_INFO);
+}
+
 static void __init acrn_init_platform(void)
 {
 	/* Setup the IDT for ACRN hypervisor callback */

base-commit: 5aaef24b5c6d4246b2cac1be949869fa36577737
-- 
2.34.1

