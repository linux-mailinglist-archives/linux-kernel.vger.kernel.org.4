Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8CA6A2688
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 02:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBYBcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 20:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBYBcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:32:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D97827483;
        Fri, 24 Feb 2023 17:32:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F614618C4;
        Sat, 25 Feb 2023 01:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFCFC433EF;
        Sat, 25 Feb 2023 01:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677288725;
        bh=Y31rE2YdqVX6Eu1AV4fYqkgcnglNl8cm+1m1hh+YDZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SvlF8tDkPDnkS4uomH9hWkp3drVLnEc3aZuZd1igY1Z1oBLkTjNv0J16SQpqyctQa
         3mpIfQjaXjxrutW0cIxhPld6LjhmHO2LWolnqfthtYkDIO/ZkwbAldESkvDvA62XsX
         obfHMw4om4IhI870D2YrfsdWwxInnfTpw8m/vmWpdJtO7jduH4Q/eEAFJdyzHASKis
         uzh6GDLTY4lGgykNeYCaQOjbPn3jfDfdS1rWoE+RQYpiEVnGoD23JztD/4S6nNKHBy
         3nMrv0zvwG1BQKaZQvozjAd+01rQTbRNw44SjezGgSU/PAi46QXWrIRsMetE7RTIY0
         +8sEYiyoUAEyQ==
Date:   Fri, 24 Feb 2023 17:32:02 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Kim Phillips <kim.phillips@amd.com>, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Alexey Kardashevskiy <aik@amd.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/CPU/AMD: Make sure EFER[AIBRSE] is set
Message-ID: <20230225013202.g7tibykvylprsxs5@treble>
References: <20230124163319.2277355-1-kim.phillips@amd.com>
 <20230124163319.2277355-8-kim.phillips@amd.com>
 <20230224185257.o3mcmloei5zqu7wa@treble>
 <Y/knUC0s+rg6ef2r@zn.tnic>
 <Y/k/ZXUXOFiBhOiI@zn.tnic>
 <20230225000931.wrednfun4jifkqau@treble>
 <Y/lUSC5x2ZkTIGu4@zn.tnic>
 <20230225005221.425yahqvxb57c43x@desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230225005221.425yahqvxb57c43x@desk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 04:52:21PM -0800, Pawan Gupta wrote:
> On Sat, Feb 25, 2023 at 01:20:24AM +0100, Borislav Petkov wrote:
> > On Fri, Feb 24, 2023 at 04:09:31PM -0800, Josh Poimboeuf wrote:
> > > Ah, I had to stare it that for a bit to figure out how it works.
> > 
> > Yeah, it is a bit "hidden". :)
> > 
> > > setup_real_mode() reads MSR_EFER from the boot CPU and stores it in
> > > trampoline_header->efer.  Then the other CPUs read that stored value in
> > > startup_32() and write it into their MSR.
> > 
> > Exactly.
> > 
> > > Yeah, I think that would be good.  Otherwise it's rather magical.
> > 
> > Yap, see below.
> > 
> > > That EFER MSR is a surprising place to put that bit.
> > 
> > That MSR is very important on AMD. Consider it AMD's CR4. :-)
> > 
> > Thx.
> > 
> > ---
> > From: "Borislav Petkov (AMD)" <bp@alien8.de>
> > Date: Sat, 25 Feb 2023 01:11:31 +0100
> > Subject: [PATCH] x86/CPU/AMD: Make sure EFER[AIBRSE] is set
> > 
> > The AutoIBRS bit gets set only on the BSP as part of determining which
> > mitigation to enable on AMD. Setting on the APs relies on the
> > circumstance that the APs get booted through the trampoline and EFER
> > - the MSR which contains that bit - gets replicated on every AP from the
> > BSP.
> > 
> > However, this can change in the future and considering the security
> > implications of this bit not being set on every CPU, make sure it is set
> > by verifying EFER later in the boot process and on every AP.
> > 
> > Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> > Link: https://lore.kernel.org/r/20230224185257.o3mcmloei5zqu7wa@treble
> > ---
> >  arch/x86/kernel/cpu/amd.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> > index 380753b14cab..de624c1442c2 100644
> > --- a/arch/x86/kernel/cpu/amd.c
> > +++ b/arch/x86/kernel/cpu/amd.c
> > @@ -996,6 +996,16 @@ static void init_amd(struct cpuinfo_x86 *c)
> >  		msr_set_bit(MSR_K7_HWCR, MSR_K7_HWCR_IRPERF_EN_BIT);
> >  
> >  	check_null_seg_clears_base(c);
> > +
> > +	/*
> > +	 * Make sure EFER[AIBRSE - Automatic IBRS Enable] is set. The APs are brought up
> > +	 * using the trampoline code and as part of it, EFER gets prepared there in order
> > +	 * to be replicated onto them. Regardless, set it here again, if not set, to protect
> > +	 * against any future refactoring/code reorganization which might miss setting
> > +	 * this important bit.
> > +	 */
> > +	if (cpu_has(c, X86_FEATURE_AUTOIBRS))
> > +		msr_set_bit(MSR_EFER, _EFER_AUTOIBRS);
> 
> Is it intended to be set regardless of the spectre_v2 mitigation status?

Right, it needs to check spectre_v2_enabled.

Also, this code might be a better fit in identify_secondary_cpu() with
the other MSR-writing bug-related code.

-- 
Josh
