Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4365F690F09
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjBIRSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjBIRSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:18:17 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3450866ED1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 09:18:14 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id a8-20020a17090a6d8800b002336b48f653so920239pjk.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 09:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4gplrw9K/LNmXo2eFqFFcRnUsvrIP0/iiac+RPCSgM=;
        b=hsZBy6lYEKKD//uOR6CyCFawmqreCyDqxhsMHMz1/yUaWYmTCt8UpYki8WhS336Yb3
         DRRF5Ze/OXRsVML7ObwhverPLTU1EOIZPSmixobKwRoXKu7y7pvLrADdRRJXDpoANsSU
         j/cclOUaIP6RxVnn2zdiZzZo15G2UEvlL3uss14FrzB0xfCCW1oL8/QHt8xLXnfyjKUt
         B+6FMENvmHHRxmDSkb4l3EJPZUF2f35PAKtXRFUVpwwviVP2bgborXWySxGNO5jTrSK2
         7/HycEehBErYPuz+GuQo6WfUkxc4yxJgz81SizZEO1Z29RSCcLllwYHUoV4sdFfuTpRr
         sHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4gplrw9K/LNmXo2eFqFFcRnUsvrIP0/iiac+RPCSgM=;
        b=OWDG2KT9yxySqsVsxUd48+W7h03VtMuFewFf9PG5VCqiRsWBynAfBf8rk5+bJAyyMD
         n6kILEzXoKBkw8D0gehe64gSjfM/Y/4cL9lwijBKl2hOOQyjO2y9QdiZzqUG6BfmX+af
         olChsKlFSXNdDk3qKpoj8Y9OFxdJzBqQNz9Ejk38FdYYY0DUwyLfVKJKJF7tCb6GrhsB
         7CrxweyJgE7SkrcZ/G2E9Vk22Id1VVtMeweNwnibMSno/B+1ycFpSqLb0rJpAvV3hx6u
         RYCWV9XlaB17HiQHi5haszWh91wZrpsbWwpxgjusoM/mmnInwCq8me8n1Co7oe19zCM2
         r9XQ==
X-Gm-Message-State: AO0yUKU8E4VQ1UFh+evFOetAIGlcNi1/1HFPxMY7/WuqoXH5DDA4Dntb
        UDz0IQL5WGy+Ykr6lT15KhHYXWY8FfLPojtIH3E=
X-Google-Smtp-Source: AK7set/BAFjDMlvMSR9e+or/RlpSPnPCUcKSfPCphUxNYx8VpNpY2KlPcv6C6t1SbT8AJ53e39HlMw==
X-Received: by 2002:a17:902:d58a:b0:192:8a1e:9bc7 with SMTP id k10-20020a170902d58a00b001928a1e9bc7mr197909plh.0.1675963093223;
        Thu, 09 Feb 2023 09:18:13 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id gn24-20020a17090ac79800b0023114357761sm1613600pjb.40.2023.02.09.09.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 09:18:11 -0800 (PST)
Date:   Thu, 9 Feb 2023 17:18:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Wang, Lei" <lei4.wang@intel.com>
Cc:     Yian Chen <yian.chen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
Subject: Re: [PATCH 7/7] x86/kvm: Expose LASS feature to VM guest
Message-ID: <Y+Uq0JOEmmdI0YwA@google.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-8-yian.chen@intel.com>
 <faac69f3-3885-8cab-ea33-49922d7a6b6d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faac69f3-3885-8cab-ea33-49922d7a6b6d@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023, Wang, Lei wrote:
> Could you also CC the KVM mailing list (kvm@vger.kernel.org) for KVM guys to review?

As Sohil pointed out[*], use scripts/get_maintainer.pl.  Cc'ing kvm@ on random
bits of the series isn't sufficient, e.g. I completely missed Sohil's Cc on the
cover letter.  For me personally at least, if I'm Cc'd on one patch then I want
to be Cc'd on all patches.

That's somewhat of a moot point for the future of LASS enabling, because the KVM
enabling needs to be a separate series.

[*] https://lore.kernel.org/all/66857084-fbed-3e9a-ed2c-7167010cbad9@intel.com

> On 1/10/2023 1:52 PM, Yian Chen wrote:
> > From: Paul Lai <paul.c.lai@intel.com>
> > 
> > Expose LASS feature which is defined in the CPUID.7.1.EAX
> > bit and enabled via the CR4 bit for VM guest.
> > 
> > Signed-off-by: Paul Lai <paul.c.lai@intel.com>
> > Signed-off-by: Yian Chen <yian.chen@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>

So I'm pretty sure this "review" was to satisfy Intel's requirements to never post
anything to x86@ that wasn't reviewed internally by one of a set of select
individuals.  Please drop that requirement for KVM x86, I truly think it's doing
more harm than good.

This is laughably inadqueate "enabling".  This has architecturally visible effects
on _all_ guest virtual/linear accesses.  That statement alone should set off alarms
left and right that simply advertising support via KVM_GET_SUPPORTED_CPUID and
marking the CR4 bit as not unconditionally reserved is insufficient.

My recommendation is to look at the touchpoints for X86_CR4_LA57 and follow the
various breadcrumbs to identify what all needs to be done to properly support LASS.

More importantly, I want tests.  There's _zero_ chance this was reasonably tested.
E.g. the most basic negative testcase of attempting to set X86_CR4_LASS on a host
without LASS is missed (see __cr4_reserved_bits()).

I will not so much as glance at future versions of LASS enabling if there aren't
testscases in KVM-unit-tests and/or selftests that give me a high level of confidence
that KVM correctly handles the various edge cases, e.g. that KVM correctly handles
an implicit supervisor access from user mode while in the emulator.

That goes a for all new hardware enabling: no tests, no review.  Please relay that
message to managers, leadership, and everyone working on KVM.  Ample warning has
been given that new KVM features need to be accompanied by tests.

> > ---
> >  arch/x86/include/asm/kvm_host.h | 3 ++-
> >  arch/x86/kvm/cpuid.c            | 2 +-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index f35f1ff4427b..bd39f45e9b5a 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -125,7 +125,8 @@
> >  			  | X86_CR4_PGE | X86_CR4_PCE | X86_CR4_OSFXSR | X86_CR4_PCIDE \
> >  			  | X86_CR4_OSXSAVE | X86_CR4_SMEP | X86_CR4_FSGSBASE \
> >  			  | X86_CR4_OSXMMEXCPT | X86_CR4_LA57 | X86_CR4_VMXE \
> > -			  | X86_CR4_SMAP | X86_CR4_PKE | X86_CR4_UMIP))
> > +			  | X86_CR4_SMAP | X86_CR4_PKE | X86_CR4_UMIP \
> > +			  | X86_CR4_LASS))
> >  
> >  #define CR8_RESERVED_BITS (~(unsigned long)X86_CR8_TPR)
> >  
> > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > index b14653b61470..e0f53f85f5ae 100644
> > --- a/arch/x86/kvm/cpuid.c
> > +++ b/arch/x86/kvm/cpuid.c
> > @@ -664,7 +664,7 @@ void kvm_set_cpu_caps(void)
> >  
> >  	kvm_cpu_cap_mask(CPUID_7_1_EAX,
> >  		F(AVX_VNNI) | F(AVX512_BF16) | F(CMPCCXADD) | F(AMX_FP16) |
> > -		F(AVX_IFMA)
> > +		F(AVX_IFMA) | F(LASS)
> >  	);
> >  
> >  	kvm_cpu_cap_init_kvm_defined(CPUID_7_1_EDX,
