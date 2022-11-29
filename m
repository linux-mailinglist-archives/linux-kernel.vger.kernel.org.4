Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D2A63BCFA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 10:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiK2JbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 04:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiK2JbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:31:08 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9645BD78
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 01:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669714267; x=1701250267;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zn3TgpOyCXFjKnPgeNLXh/qa7scJstQOq8wptR6uaRs=;
  b=ZwIOuJmVRSftgKimfFx42E5ofmTP29mP/LNyR12jCuOwyyQPjpwdIfgd
   rp+TQuzRLDd8k5mSAokt9bPqPkb+rgl+JPRbhAgvpzCQdQX4bq9kKFduj
   gfmKIp45/KOKtozL6ssk4zxJirjCzS6+K/p2YsXHxTHKW2tzj9ghFbMLE
   j0Q9zlaiWmJgaYcMNt+wH2dcUNe9APDFSXyyK9l05sEtqtrA7Xg55ffQy
   34dCHhmuDQhLEfNY9M0P0z+MIifhzUq3UkMGoqyIwcon062e6iNtn+JEk
   THV38e6z8/ZciZ5uvi738KROIfCmyJkYTOl4jF9fP3pxVHpvCKGWnCTp+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="313768965"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="313768965"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 01:31:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="785974964"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="785974964"
Received: from louislifei-optiplex-7090.sh.intel.com ([10.239.146.218])
  by fmsmga001.fm.intel.com with ESMTP; 29 Nov 2022 01:31:04 -0800
From:   Fei Li <fei1.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     bp@alien8.de, peterz@infradead.org, dave.hansen@intel.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, yu1.wang@intel.com,
        conghui.chen@intel.com, fengwei.yin@intel.com, junjie.mao@intel.com
Subject: [PATCH v3] x86/acrn: Set X86_FEATURE_TSC_KNOWN_FREQ
Date:   Tue, 29 Nov 2022 17:40:25 +0800
Message-Id: <20221129094025.907760-1-fei1.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using hypervisor-provided TSC frequency is common practice for guests.
However, for a Linux guest, it may still to reclibrate the ACRN-specific
TSC frequency if X86_FEATURE_TSC_KNOWN_FREQ flag is not set.

When TSC frequency is known (retrieved from ACRN hypervisor), skip TSC
refined calibration by setting X86_FEATURE_TSC_KNOWN_FREQ.

Also remove `inline` for acrn_get_tsc_khz() since it doesn't make sense.

Signed-off-by: Fei Li <fei1.li@intel.com>
Reviewed-by: Yin, Fengwei <fengwei.yin@intel.com>

---
v3: Update the commit message base on Borislav's comments
v2: Detail the commit message
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

base-commit: b7b275e60bcd5f89771e865a8239325f86d9927d
-- 
2.34.1

