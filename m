Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5D4662A3E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjAIPky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237264AbjAIPkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:40:17 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5255B40C0C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 07:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673278578; x=1704814578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z6CTujcMHROo8G6A9RLI+GRnUF8GPfe/fb1oxgWV3u0=;
  b=D7g61m+3ySQMlN4ebKkALhQ0JGlZQTWtQvRq8tC8tav/u4oMCrqui+ki
   mdeSa1leYgTZwcAz0sbjL3blVz+IyvTaoedqDYcgb5VbIX3xSJF7K7H5x
   eQTQaz/8okWR4VfdNXBP7zPjIpOgRRGRhC/kGV+m+a3EsVp16NgcgtYpz
   7gLfQWeHlBAL+PUcu1ghYD+S4u61sdfP2VGevRIHIOGty8tyvS1FMG98Y
   XOZ0cB4ohebjB3jlHdHxkRMM6pzSXqSGm5PKQ1UQ7dOBxnpBLWL0pm9LS
   7mFENRjgNQMz2NvpNKacVrdRSRibph1G5iBLHTb23/6iCLtD+CRqrRB8U
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="385203571"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="385203571"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 07:36:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="902023886"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="902023886"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 07:36:12 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, alison.schofield@intel.com,
        reinette.chatre@intel.com, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v4 3/6] x86/microcode: Display revisions only when update is successful
Date:   Mon,  9 Jan 2023 07:35:52 -0800
Message-Id: <20230109153555.4986-4-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230109153555.4986-1-ashok.raj@intel.com>
References: <20230109153555.4986-1-ashok.raj@intel.com>
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
Display "Reload completed" only if the update was successful, otherwise
report the update failed.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Fixes: 9bd681251b7c ("x86/microcode: Announce reload operation's completion")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
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
Cc: Ingo Molnar <mingo@kernel.org>
---
Changes since V3:

Tony, Ingo
	- Print clear message if the update was successful or not.
---
 arch/x86/kernel/cpu/microcode/core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index bb943a91a364..d7cbc83df9b6 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -455,11 +455,15 @@ static int microcode_reload_late(void)
 	store_cpu_caps(&prev_info);
 
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
-	if (ret == 0)
-		microcode_check(&prev_info);
 
-	pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
-		old, boot_cpu_data.microcode);
+	if (ret == 0) {
+		pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
+			old, boot_cpu_data.microcode);
+		microcode_check(&prev_info);
+	} else {
+		pr_info("Reload failed, current microcode revision: 0x%x\n",
+			boot_cpu_data.microcode);
+	}
 
 	return ret;
 }
-- 
2.34.1

