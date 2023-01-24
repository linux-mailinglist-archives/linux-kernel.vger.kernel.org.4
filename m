Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E3B67A0F6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjAXSNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjAXSNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:13:16 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BDA1B564
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:13:14 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 42AFE1EC052A;
        Tue, 24 Jan 2023 19:13:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1674583993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3OaM/Y7cpBAJC25XKxOdjIh925a815HwLPCmt8PUDd8=;
        b=p3MCMLxU/XSZCSU4FcOfH7BSFsLViqs0jWglNhNj9YL9CH0VdQ78XOJjxu/3xrO80+jlUU
        EckGi1HJUI+t2niKhmrv307y1fR4fT3hMyCK4YtYSS5+OfdQgNSBREzzGTa5AXnlR/i9F9
        ecPGlkkj9ttT7s96xe1lGeVQS0gUOIs=
Date:   Tue, 24 Jan 2023 19:13:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Babu Moger <babu.moger@amd.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH] x86/resctrl: Fix a silly -Wunused-but-set-variable warning
Message-ID: <Y9AftBkWXcFflHbm@zn.tnic>
References: <202301242015.kbzkVteJ-lkp@intel.com>
 <Y8/XoT23HVXHSY73@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8/XoT23HVXHSY73@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

clang correctly complains

  arch/x86/kernel/cpu/resctrl/rdtgroup.c:1456:6: warning: variable \
     'h' set but not used [-Wunused-but-set-variable]
          u32 h;
              ^

but it can't know whether this use is innocuous or really a problem.
There's a reason why those warning switches are behind a W=1 and not
enabled by default - yes, one needs to do:

  make W=1 CC=clang HOSTCC=clang arch/x86/kernel/cpu/resctrl/

with clang 14 in order to trigger it.

I would normally not take a silly fix like that but this one is simple
and doesn't make the code uglier so...

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/202301242015.kbzkVteJ-lkp@intel.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5990589f8a21..e2c1599d1b37 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1453,17 +1453,17 @@ static void mon_event_config_read(void *info)
 {
 	struct mon_config_info *mon_info = info;
 	unsigned int index;
-	u32 h;
+	u64 msrval;
 
 	index = mon_event_config_index_get(mon_info->evtid);
 	if (index == INVALID_CONFIG_INDEX) {
 		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
 		return;
 	}
-	rdmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, h);
+	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
 
 	/* Report only the valid event configuration bits */
-	mon_info->mon_config &= MAX_EVT_CONFIG_BITS;
+	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
 }
 
 static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
-- 
2.35.1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
