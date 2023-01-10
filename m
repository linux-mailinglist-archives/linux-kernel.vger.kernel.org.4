Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CDE6638F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 06:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjAJF5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 00:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbjAJF4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 00:56:23 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E49DC3F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 21:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673330152; x=1704866152;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=lgcnknU6x6SUKKapMholbQrdWhgTRn5H0KqHPrXRFC4=;
  b=j1xcbUPQEaNcBBPnQxBKVAaOQGJbVvAFVQqA24Nm2D6E41fYxzOB7ZOb
   vKOeLbGHAYOa4pLCD4NggY1yZILXd28Fs3UV9WfmZxYXlW0CTE0nYGeAQ
   d2Dezi/hbmF5Q/6Akqdfb1ADEDwqbZdThzMHeSdix0i3cjoDm2Sg1HPqN
   bhycFL9dfmnbuaFPTUB6ueh8ax78win2g+Thb2r4KfOmj3hKtLRApTrhJ
   g9LuzVXj7FMNnQ8xOuLaM0EixF/CwEW2eTu/sVklNIC/u3RgsnCHrVmxg
   gHCK1c9bNOfPb9nly7xOW+AXy33M97PPrHlmsWCG9gk8LrwOjodGHfPpH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="350289965"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="350289965"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 21:55:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="634483749"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="634483749"
Received: from oux.sc.intel.com ([10.3.52.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 21:55:40 -0800
From:   Yian Chen <yian.chen@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Paul Lai <paul.c.lai@intel.com>,
        Yian Chen <yian.chen@intel.com>
Subject: [PATCH 5/7] x86/cpu: Enable LASS (Linear Address Space Separation)
Date:   Mon,  9 Jan 2023 21:52:02 -0800
Message-Id: <20230110055204.3227669-6-yian.chen@intel.com>
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

LASS is enabled via setting a CR4 bit if the platform
supports the feature.

LASS may be disabled in early boot time, for example,
by command line parameter clearcpuid=lass/390 or
vsyscall flag. In such cases, the CPU feature and CR4
bits will be cleared.

Signed-off-by: Yian Chen <yian.chen@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/common.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9cfca3d7d0e2..efc7c7623968 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -412,6 +412,23 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 	cr4_clear_bits(X86_CR4_UMIP);
 }
 
+static __always_inline void setup_lass(struct cpuinfo_x86 *c)
+{
+	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
+		cr4_set_bits(X86_CR4_LASS);
+	} else {
+		/*
+		 * only clear the feature and cr4 bits when hardware
+		 * supports LASS, in case it was enabled in a previous
+		 * boot (e.g., via kexec)
+		 */
+		if (cpu_has(c, X86_FEATURE_LASS)) {
+			cr4_clear_bits(X86_CR4_LASS);
+			clear_cpu_cap(c, X86_FEATURE_LASS);
+		}
+	}
+}
+
 /* These bits should not change their value after CPU init is finished. */
 static const unsigned long cr4_pinned_mask =
 	X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
@@ -1848,6 +1865,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_smep(c);
 	setup_smap(c);
 	setup_umip(c);
+	setup_lass(c);
 
 	/* Enable FSGSBASE instructions if available. */
 	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
-- 
2.34.1

