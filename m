Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBC76186CB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiKCR76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiKCR71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:59:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C972628
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667498359; x=1699034359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IRafYvcGTb3XRIZ8BF10OMlvhWCpsdfukSgZuf8/1v8=;
  b=bIWFEOAeCGrPWyjKFHyXRC4UxDwtcJ3DglJJHuWAwJfDXrfHh9E0/wzM
   trifDp6L+lVtU0fBUvQ5Q7Bm3oo8D9P1ku7GM/7Dof/TFIDbcEP5hbH2a
   bJx26hsohmpVTRpjjlsgmpOJuX3nS6ZgnQTD94ipwORzdSsjEyi7uOSK5
   D4RGpriRcl2eKseFNp7gwzunTi9DEMmJbX5mcjBE0FH2eDDr3TcKFCarr
   Vu33aq6MzyuvE4diI2KHzIG84wOodvOrlVbp5Pt08yB7TLE6KxxwrsE4R
   lV2a0xwfrJE2c11Hmyn87LlaPGd6NmvLC4ewGKnUBYjJusjTp/HY3PLUw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="308476963"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="308476963"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809762540"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="809762540"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:17 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [v2 01/13] x86/microcode/intel: Prevent printing updated microcode rev multiple times
Date:   Thu,  3 Nov 2022 17:58:49 +0000
Message-Id: <20221103175901.164783-2-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103175901.164783-1-ashok.raj@intel.com>
References: <20221103175901.164783-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b6f86689d5b7 ("x86/microcode: Rip out the subsys interface gunk")
introduced a race where all CPUs follow this call chain:

microcode_init()->schedule_on_each_cpu(setup_online_cpu)->collect_cpu_info

This results in console spam where multiple CPUs print the signature.

[   33.688639] microcode: sig=0x50654, pf=0x80, revision=0x2006e05
[   33.688659] microcode: sig=0x50654, pf=0x80, revision=0x2006e05
[   33.688660] microcode: sig=0x50654, pf=0x80, revision=0x2006e05

Fix by making sure only boot CPU prints the message.

Fixes: b6f86689d5b7 ("x86/microcode: Rip out the subsys interface gunk")
Reported-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 8c35c70029bf..8f7f8dd6680e 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -680,6 +680,7 @@ void reload_ucode_intel(void)
 
 static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
 {
+	bool bsp = cpu_num == boot_cpu_data.cpu_index;
 	static struct cpu_signature prev;
 	struct cpuinfo_x86 *c = &cpu_data(cpu_num);
 	unsigned int val[2];
@@ -696,8 +697,7 @@ static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
 
 	csig->rev = c->microcode;
 
-	/* No extra locking on prev, races are harmless. */
-	if (csig->sig != prev.sig || csig->pf != prev.pf || csig->rev != prev.rev) {
+	if (bsp && csig->rev != prev.rev) {
 		pr_info("sig=0x%x, pf=0x%x, revision=0x%x\n",
 			csig->sig, csig->pf, csig->rev);
 		prev = *csig;
-- 
2.34.1

