Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2DF67C89F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbjAZKe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjAZKe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:34:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF61D3EC4B;
        Thu, 26 Jan 2023 02:34:23 -0800 (PST)
Date:   Thu, 26 Jan 2023 10:34:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674729262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FcbMsLxLzSVPi5YivDAULjGl6AaAwxfLVanRJMCxmNw=;
        b=S9Wx+Z6ICh5lyAV/fbKXOpGic9/RmLVdm23I9lGxRVMtAQVPJLs/Dv3TTsUszrudLvpaIQ
        hzLDx9IR0mn4Xw4P4ou/NMdZX4lxepq7SOJOzpUEy9n93Z2zIcs4ESNJ5R774HetqCI1Tz
        D7HgENQ1JcE/65y4wkcnMdmFR4ymD42cFhVLXtA/aK+tQzvrEI/5egxvZrRGYoWlF0ayZT
        isS43jIU1cB1Yj7LLjVS4xN2vWvrj6WddcPVgYWXjv8ZxNICxJL8aR/bVC5lP0DsGsXkAl
        o6IHYgwHAC1YSrDHkCIhd5GdZNT0U9Z891dWJrH7HLMJQSk/DTKam7kcmNgZsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674729262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FcbMsLxLzSVPi5YivDAULjGl6AaAwxfLVanRJMCxmNw=;
        b=UaSBV2tS3Baf60PnBbp9XNzmzh5w8sby7nZaTyzYwrayG9qnXg+diYPj91BIRlvFYqE78/
        H86WIElhuLpZ+gDw==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Fix a silly -Wunused-but-set-variable warning
Cc:     kernel test robot <lkp@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <202301242015.kbzkVteJ-lkp@intel.com>
References: <202301242015.kbzkVteJ-lkp@intel.com>
MIME-Version: 1.0
Message-ID: <167472926132.4906.9798540795502253502.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     793207bad71c5339c614d12ac21d627da7bf771d
Gitweb:        https://git.kernel.org/tip/793207bad71c5339c614d12ac21d627da7bf771d
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 24 Jan 2023 19:01:05 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 26 Jan 2023 11:15:20 +01:00

x86/resctrl: Fix a silly -Wunused-but-set-variable warning

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
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/202301242015.kbzkVteJ-lkp@intel.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5990589..e2c1599 100644
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
