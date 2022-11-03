Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0558B6186D0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiKCSAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiKCR73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:59:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE662BE9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667498360; x=1699034360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tprEQhizZvNJCMWGXO2qdM0qzd8PBoK3akX16cVKTX0=;
  b=S0IhcWb82g6gPmeGXgWVm8G8YpKbKEoNpaWSdjG0t4iuJSBLCTMZR7BM
   SHWCFga6P2Bajv0dM13PE2we5ZsZ7tdhhqMidPTZb82HS0dFPDIP4iHUz
   x/5/wDSZs2LzLXkOc2OscVPxoffkurZpmwCjpBA7z25pfZ2pgT9d3C6y5
   lK32tE2D15+V+Jw+6GWfl75jOvgjo/JWNUWMXZrGc/AiCK2VGZ313hSGm
   StFKDdam9JUdvoYLOjZcoIIwpcOm9H9UEQHkUvGUeVxp7PDbbYW4LzE8S
   Z58ABG2ZendIBDnAlYQ1VXGQGBFQjhFvfIuGo6g87S8ZAnvbVbGVB3HbL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="310878484"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="310878484"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:19 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809762574"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="809762574"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:18 -0700
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
Subject: [v2 12/13] x86/microcode: Display revisions only when update is successful
Date:   Thu,  3 Nov 2022 17:59:00 +0000
Message-Id: <20221103175901.164783-13-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103175901.164783-1-ashok.raj@intel.com>
References: <20221103175901.164783-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display the update message only when its successful

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 17dba13d397d..a7d0cbbb2505 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -591,11 +591,11 @@ static int microcode_reload_late(void)
 	if (ret == 0)
 		microcode_check(&info);
 
-	pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
-		old, boot_cpu_data.microcode);
-
 	unregister_nmi_handler(NMI_LOCAL, "ucode_nmi");
 
+	if (!ret)
+		pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
+			old, boot_cpu_data.microcode);
 done:
 	return ret;
 }
-- 
2.34.1

