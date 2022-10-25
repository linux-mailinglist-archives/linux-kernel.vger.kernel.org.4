Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF5360C696
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJYIg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiJYIgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:36:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D24B1B97
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666686959; x=1698222959;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=06nalujSve5fq7Zr8pswHrs1yGAHFNbk4ISagSP3o7w=;
  b=ijfPwmJOHDN9eFDM9cC4uxtbCkGfDpfdF8qpOLuE/HjS7EvprS8IpP48
   BTmupnFeNDqT2HrxrJOeV7B8kgFV97nO8WmV3gpSNcPhG3er+Fve53R12
   bSfuJT7tKjd/A9+9hNnjyKPs6ACxCS2oXWaeFnF1WFml89jAFaczDfRj+
   j1JTAofwosILuP8Cx6MesRd0aJNTbMs3RTqLRsG/h7R7KWoTOVvirT5Pc
   Vv9rK2/mYvszwyxzuKoWm9jjYGHrMyGpj+ZHYcU/8IKQFTbhKCQkt28uI
   Lp5U4wA/nrGXtJEFniA+9LWmRdB/Qfd4aX7CFz4DbHfaNhGgW96VqPwVe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="309310189"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="309310189"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 01:35:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="774117588"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="774117588"
Received: from louislifei-optiplex-7090.sh.intel.com ([10.239.146.218])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2022 01:35:48 -0700
From:   Fei Li <fei1.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     dave.hansen@intel.com, gregkh@linuxfoundation.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, Yu1.Wang@intel.com,
        conghui.chen@intel.com, fengwei.yin@intel.com
Subject: [PATCH] x86/acrn: Set X86_FEATURE_TSC_KNOWN_FREQ
Date:   Tue, 25 Oct 2022 16:41:47 +0800
Message-Id: <20221025084147.4118463-1-fei1.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoiding recalibration by setting X86_FEATURE_TSC_KNOWN_FREQ.
This patch also removes `inline` for acrn_get_tsc_khz() since
it doesn't make sense.

Signed-off-by: Fei Li <fei1.li@intel.com>
Reviewed-by: Yin, Fengwei <fengwei.yin@intel.com>
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

base-commit: 1a2dcbdde82e3a5f1db9b2f4c48aa1aeba534fb2
-- 
2.34.1

