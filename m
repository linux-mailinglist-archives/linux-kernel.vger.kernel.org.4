Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA26F6798E5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjAXNFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjAXNFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:05:44 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA55510ED
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:05:43 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2459B1EC0622;
        Tue, 24 Jan 2023 14:05:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1674565542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PmF6+4QENiIdARF8/6Ph7VMasHMPcP62KrTC+HYAlLQ=;
        b=go5y2Q1CaMrGAiq492t0yOEMROdHZfy1Vo5Njpqq8/d833YSgIKF1e8pG1YrEWH86RXPTh
        aQxbtvMs0JqgcBgeXQRAB/QQqDM3KmbVgCKKvJIeDckH626AJjObA68lgTQ+iILADH83c6
        Evxn+c4TkTquumzjiXrcOLbFlwOe7Ek=
Date:   Tue, 24 Jan 2023 14:05:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Babu Moger <babu.moger@amd.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [tip:x86/cache 9/13]
 arch/x86/kernel/cpu/resctrl/rdtgroup.c:1456:6: warning: variable 'h' set but
 not used
Message-ID: <Y8/XoT23HVXHSY73@zn.tnic>
References: <202301242015.kbzkVteJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202301242015.kbzkVteJ-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 08:37:14PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
> head:   0a363fb23ee2f7beb08437ad7db86d195878d79f
> commit: dc2a3e857981f859889933cf66ded117d74edff1 [9/13] x86/resctrl: Add interface to read mbm_total_bytes_config

These patches have been around for a long while now. How come you test them just
now, after I take them?

> >> arch/x86/kernel/cpu/resctrl/rdtgroup.c:1456:6: warning: variable 'h' set but not used [-Wunused-but-set-variable]
>            u32 h;
>                ^

The fix is simple - use rsmsrl(), see below.

If it weren't that simple I'd simply ignore this warning altogether. Yes, it is
unused because the damn high MSR value needs to go somewhere, for chrissakes.
And if it didn't need that masking with MAX_EVT_CONFIG_BITS but the low 32-bit
MSR value would fit right into mon_info->mon_config, then I would've ignored
this one even faster.

And besides, I'm wondering if you're spending your 0day resources properly if
you're testing patches one-by-one for W=1 warnings?!

If it were me, I'd prefer if you build-test patches on lkml for build *errors*,
*before* they get picked up in some tree instead of testing the applied branches
already for some questionable warnings...

Thx.

---

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index cd4e668e5019..9bd0eb050e7a 100644
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
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
