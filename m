Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAC3694F94
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjBMSnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBMSnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:43:21 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB901C5B4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:43:20 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A80D21EC0854;
        Mon, 13 Feb 2023 19:43:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676313798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qKRBuWMiSybC4tH9nU+jPPER1x7YmEq5bpWJr9SaMxw=;
        b=Ao1+wg8mFc5mt4AvLNIg8BEcW0ssuxmPh4+Y7lV9mTsbWWs9VtqHkI9cqU9KKXypHrXKea
        UArtg7VFLpdjcAAwVThd4OSKpBiBq3pldxmwvT595OI89UKEVQn8kDdIMz/VMTsg4+Yk9V
        SiDb9GVjIKjb2ijYMQXaB1eV7dPzWG8=
Date:   Mon, 13 Feb 2023 19:43:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
Message-ID: <Y+qEwtzCV65s+ZFq@zn.tnic>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com>
 <Y+ohfE/wICFKO/93@zn.tnic>
 <6257114d-a957-f586-145c-d2a885417360@suse.com>
 <Y+pRK6a419jenR9R@zn.tnic>
 <13520f45-7f4d-417e-f9a2-40c32cd0e739@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13520f45-7f4d-417e-f9a2-40c32cd0e739@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 04:36:12PM +0100, Juergen Gross wrote:
> In the end I wouldn't mind dropping the fixed MTRRs from the interface, as
> they are currently not needed at all.

Yes, the less the better.

> I'd say we go with what is needed right now. And having a single interface
> makes all the sanity checking you are asking for easier.

I guess I need to remember to finish designing this if more users
appear...

> What are you especially asking for?
> 
> With my current patches Xen PV dom0 will call mtrr_overwrite_state() before
> x86_hyper_type is set, while a Hyper-V SEV-SNP guest will make the call after
> it has been set. Both calls happen before cache_bp_init().
> 
> So I could move the mtrr_overwrite_state() call for Xen PV dom0 into its
> init_platform() callback and check in mtrr_overwrite_state() x86_hyper_type
> to be set,

I believe that is good enough, see below.

> or I could reject a call of mtrr_overwrite_state() after the call of
> cache_bp_init() has happened, or I could do both.

I think one thing is enough as we'll be loud enough.

---
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index b73fe243c7fd..2dbe2c10e959 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -49,6 +49,7 @@
 #include <asm/cacheinfo.h>
 #include <asm/cpufeature.h>
 #include <asm/e820/api.h>
+#include <asm/hypervisor.h>
 #include <asm/mtrr.h>
 #include <asm/msr.h>
 #include <asm/memtype.h>
@@ -668,7 +669,12 @@ void __init mtrr_bp_init(void)
 	const char *why = "(not available)";
 	unsigned int phys_addr;
 
+#ifdef CONFIG_HYPERVISOR_GUEST
 	if (mtrr_state.enabled) {
+
+		/* This should not happen without a hypervisor present. */
+		WARN_ON_ONCE(!x86_hyper_type);
+
 		/* Software overwrite of MTRR state, only for generic case. */
 		mtrr_calc_physbits(true);
 		init_table();
@@ -676,6 +682,7 @@ void __init mtrr_bp_init(void)
 
 		return;
 	}
+#endif
 
 	phys_addr = mtrr_calc_physbits(boot_cpu_has(X86_FEATURE_MTRR));
 




-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
