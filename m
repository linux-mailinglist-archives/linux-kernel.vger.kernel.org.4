Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB2965C5A2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238602AbjACSCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238527AbjACSC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:02:27 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A72A11A2A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672768944; x=1704304944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ksdr92gH6DZ8dyITiXCe+MBzgbUi62N2nRt+rCqGjeE=;
  b=U47aOgG99MHa+KoPh5oq37PvW/zwKn/8w2g/HoY1b/2kOqYLWB+nBY21
   NgGKLb57YQCAaKMxhTQWSe7ed6uGkIkmE0ccT+85RMBFQHgw/J5h2xT9f
   t1N4WqUXgqnhBEJMl/zl0rQOWUTcXMusZcdQ3N+AdGVnGu563NBkoDHNf
   qUEA7LgXahVoMjy1Gsg1zdXQOYt8GSx5fV131RZfzCtwRgdHDLyqonoe1
   L6bQLIFT3WLF5VM06ajQC+EFyQn4oekejpHGMkIzP1jcqx1XXk8XpNnja
   yBX6Z8H9+SJhXCrvTuDM6oPFgXc19nrt3h+m60WD7DrLWOpWcPLXS7vSp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="384010646"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="384010646"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 10:02:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="654876885"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="654876885"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 10:02:24 -0800
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
Subject: [PATCH v3 3/6] x86/microcode: Display revisions only when update is successful
Date:   Tue,  3 Jan 2023 10:02:09 -0800
Message-Id: <20230103180212.333496-4-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103180212.333496-1-ashok.raj@intel.com>
References: <20230103180212.333496-1-ashok.raj@intel.com>
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
index 14d9031ed68a..e67f8923f119 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -455,11 +455,12 @@ static int microcode_reload_late(void)
 	microcode_store_cpu_caps(&info);
 
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

