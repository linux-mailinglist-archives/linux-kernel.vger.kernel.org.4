Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A3E6992B5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjBPLHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjBPLHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:07:40 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24BED199
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 03:07:29 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1112)
        id 9DC522011247; Thu, 16 Feb 2023 03:07:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9DC522011247
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1676545648;
        bh=jcLHWxG2QdRLedl8Yx8Cuagw6dzTIWzWdtfr68oqv6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i7HStZqbzBW2Y1TFNHeJzzdlIqvUo8+djAESxgF9mW42xxS1E0N1W007uCJ3tFiwo
         hIQ/WzLr7g97EF3YR9BNTkjtUK4ZfS9ebKcKKKiC91IlpVN2szdkuZLEBV1UpzCwQY
         9NpFezfXiZ57HxabJAeUBhbv8Uzuk9cEIzJRyFQo=
Date:   Thu, 16 Feb 2023 03:07:28 -0800
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
Message-ID: <20230216110728.GB3949@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com>
 <Y+ohfE/wICFKO/93@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+ohfE/wICFKO/93@zn.tnic>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 12:39:40PM +0100, Borislav Petkov wrote:
> On Thu, Feb 09, 2023 at 08:22:14AM +0100, Juergen Gross wrote:
> > When running virtualized, MTRR access can be reduced (e.g. in Xen PV
> > guests or when running as a SEV-SNP guest under Hyper-V). Typically
> > the hypervisor will reset the MTRR feature in cpuid data, resulting
> > in no MTRR memory type information being available for the kernel.
> > 
> > This has turned out to result in problems:
> > 
> > - Hyper-V SEV-SNP guests using uncached mappings where they shouldn't
> > - Xen PV dom0 mapping memory as WB which should be UC- instead
> > 
> > Solve those problems by supporting to set a fixed MTRR state,
> > overwriting the empty state used today. In case such a state has been
> > set, don't call get_mtrr_state() in mtrr_bp_init(). The set state
> > will only be used by mtrr_type_lookup(), as in all other cases
> > mtrr_enabled() is being checked, which will return false. Accept the
> > overwrite call only in case of MTRRs being disabled in cpuid.
> 
> s/cpuid/CPUID/g
> 
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> > ---
> > V2:
> > - new patch
> > ---
> >  arch/x86/include/asm/mtrr.h        |  2 ++
> >  arch/x86/kernel/cpu/mtrr/generic.c | 38 ++++++++++++++++++++++++++++++
> >  arch/x86/kernel/cpu/mtrr/mtrr.c    |  9 +++++++
> >  3 files changed, 49 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
> > index f0eeaf6e5f5f..0b8f51d683dc 100644
> > --- a/arch/x86/include/asm/mtrr.h
> > +++ b/arch/x86/include/asm/mtrr.h
> > @@ -31,6 +31,8 @@
> >   */
> >  # ifdef CONFIG_MTRR
> >  void mtrr_bp_init(void);
> > +void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
> > +			  mtrr_type *fixed, mtrr_type def_type);
> >  extern u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform);
> >  extern void mtrr_save_fixed_ranges(void *);
> >  extern void mtrr_save_state(void);
> > diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
> > index ee09d359e08f..788bc16888a5 100644
> > --- a/arch/x86/kernel/cpu/mtrr/generic.c
> > +++ b/arch/x86/kernel/cpu/mtrr/generic.c
> > @@ -240,6 +240,44 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
> >  	return mtrr_state.def_type;
> >  }
> >  
> > +/**
> > + * mtrr_overwrite_state - set fixed MTRR state
> 
> fixed only? You pass in variable too...
> 
> > + *
> > + * Used to set MTRR state via different means (e.g. with data obtained from
> > + * a hypervisor).
> > + */
> > +void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
> > +			  mtrr_type *fixed, mtrr_type def_type)
> > +{
> > +	unsigned int i;
> > +
> > +	if (boot_cpu_has(X86_FEATURE_MTRR))
> 
> check_for_deprecated_apis: WARNING: arch/x86/kernel/cpu/mtrr/generic.c:254: Do not use boot_cpu_has() - use cpu_feature_enabled() instead.
> 

Hi Boris,

Where does this check come from? I can't find a source for it.

Jeremi
