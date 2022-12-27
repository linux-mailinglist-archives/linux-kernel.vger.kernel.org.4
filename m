Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C10656E43
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiL0TYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiL0TX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:23:57 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0576572
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672169036; x=1703705036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RGIUoDUWMennNq2BZ7d/bh2PdiZqgI1/L+XCRzyCHqE=;
  b=jznyb4w5iIJ2SmzUetS3e6lPFSMafkRTHLlThFjWn9ilcA0f6mcXvWVZ
   ne4c4yVSV8DByxod4vXd7+htqwyCNzFbfsjtYk81WSzQR2r/DrII/rkhf
   eJ+1JrtUVXe2OQciWt+3v0oFrlkAV+4wXjBDTzqOg6y6NQgDR3hXqHdaN
   UFWhS0VVjxtBptH8R7XH9N7NLTo8L2+1bST21NEBesg41N2aZLVyxdcA6
   x6jfJelQ8KDjGphrPBuMhGZf8p2PFSkellTzsXXxfM13HvK68l5SKCFnG
   MD0mtaSRZYJizFWlhqjDBO8QXEDYfZVEncK5Ps2SO1ZuqrUBEr2nrNeqU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="407011170"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="407011170"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 11:23:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="777234197"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="777234197"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 11:23:54 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v2 3/6] x86/microcode: Display revisions only when update is successful
Date:   Tue, 27 Dec 2022 11:23:37 -0800
Message-Id: <20221227192340.8358-4-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221227192340.8358-1-ashok.raj@intel.com>
References: <20221227192340.8358-1-ashok.raj@intel.com>
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

Right now, microcode loading failures and successes print the same
message "Reloading completed". This is misleading to users.

Display the updated revision number only if an update was successful.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/lkml/874judpqqd.ffs@tglx/
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: x86 <x86@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index e2cdf3e989e7..e60cf0f66bf5 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -500,11 +500,12 @@ static int microcode_reload_late(void)
 	store_cpu_caps(&info);
 
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
-	if (ret == 0)
-		microcode_check(&info);
 
-	pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
-		old, boot_cpu_data.microcode);
+	if (ret == 0) {
+		pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
+			old, boot_cpu_data.microcode);
+		microcode_check(&info);
+	}
 
 	return ret;
 }
-- 
2.34.1

