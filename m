Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB905FF452
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiJNUJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiJNUJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:09:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4301B1D3476
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665778168; x=1697314168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7jM/CiHxN+gWkR7IJ+ClWDUqoyWEdL8oPVI2Lk2Mu6Q=;
  b=AnvZbh29a9jr//r66CVoZLsy5b3G9dvHSQsvtHzKYdVDL4J58VpVpmVV
   4R+wE9CNYUaaSovRFR2erfjy1ORGDtdwJiBKnlAjFiB9d/kFEbLXDPFmf
   CPHH14VieePTOnvjkpDMW50SAlqO8qpkbpuII8TvrZ8QTOPzfeD0UGai0
   WfaCJuw/6UwuU/25dGr0ujKHFBeJDfDaxYpFgugiW6klF02t4UU/TcvMX
   HzcvPLYwPuWd+7xmopRaTyr83B/OlRaV9Cgd0+moVeQznlbFFhJCjbNoq
   HeLJUpAbHjz95F4zD7hljBBmuh2y8sjEqlA0QoFTZBf5aIDKxB2dlMODA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="304202154"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="304202154"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="716870144"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="716870144"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:27 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 03/13] x86/microcode/intel: Fix a hang if early loading microcode fails
Date:   Fri, 14 Oct 2022 13:09:03 -0700
Message-Id: <20221014200913.14644-4-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221014200913.14644-1-ashok.raj@intel.com>
References: <20221014200913.14644-1-ashok.raj@intel.com>
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

When early loading of microcode fails for any reason other than the wrong
family-model-stepping, Linux can get into an infinite loop retrying the
same failed load.

A single retry is needed to handle any mixed stepping case.

Assume we have a microcode that fails to load for some reason.
load_ucode_ap() seems to retry if the loading fails. But it searches for
a new rev, but ends up finding the same copy. Hence it appears to repeat
the same load, retry loop for ever.

We can fix it as follows.

1) When the load_ucode_intel_bsp() fails, record the revision that failed.
2) In load_ucode_intel_ap() check if AP is same FMS as BP, and the code
that failed earlier isn't going to apply anyway. So use the saved
information to abort loading on AP's altogether.

load_ucode_intel_ap()
{
..
reget:
        if (!*iup) {
                patch = __load_ucode_intel(&uci);
		^^^^^ Finds the same patch every time.

                if (!patch)
                        return;

                *iup = patch;
        }

        uci.mc = *iup;

        if (apply_microcode_early(&uci, true)) {
	^^^^^^^^^^^^ apply fails
              /* Mixed-silicon system? Try to refetch the proper patch: */
              *iup = NULL;

              goto reget;
	      ^^^^^ Rince repeat.
        }

}

Fixes: 06b8534cb728 ("x86/microcode: Rework microcode loading")
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index cf1e2c30b230..0f7e4ba05c39 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -606,6 +606,7 @@ void __init load_ucode_intel_bsp(void)
 {
 	struct microcode_intel *patch;
 	struct ucode_cpu_info uci;
+	int rev, ret;
 
 	patch = __load_ucode_intel(&uci);
 	if (!patch)
@@ -613,13 +614,18 @@ void __init load_ucode_intel_bsp(void)
 
 	uci.mc = patch;
 
-	apply_microcode_early(&uci, true);
+	ret = apply_microcode_early(&uci, true);
+	if (ret) {
+		rev = patch->hdr.rev;
+		pr_err("Revision 0x%x failed during early loading\n", rev);
+	}
 }
 
 void load_ucode_intel_ap(void)
 {
 	struct microcode_intel *patch, **iup;
 	struct ucode_cpu_info uci;
+	bool retried = false;
 
 	if (IS_ENABLED(CONFIG_X86_32))
 		iup = (struct microcode_intel **) __pa_nodebug(&intel_ucode_patch);
@@ -638,9 +644,13 @@ void load_ucode_intel_ap(void)
 	uci.mc = *iup;
 
 	if (apply_microcode_early(&uci, true)) {
+		if (retried)
+			return;
+
 		/* Mixed-silicon system? Try to refetch the proper patch: */
 		*iup = NULL;
 
+		retried = true;
 		goto reget;
 	}
 }
-- 
2.34.1

