Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69069647434
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiLHQ0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiLHQ0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:26:35 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BB04A075
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:26:34 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y17so1992714plp.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 08:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lTgWx4scVyEdnNwP8DjnL1zHNWGeK2kwc0Zp2eRMXQk=;
        b=DtPAybS0x/Bv9SwEFO8iJm3Nt7GLaKJyB5eY3bSfC+VBuMJsbkTJk+3VLNLVGY97gW
         YROZkWwojaG47GUXQLrCTFJjvlpv88vKyYmpnOc7FWDgCcttWvm89GqcBOgYh8KN/QL8
         /9v/7LFByFTev9BlbnpF8R4jmudaKyQI6sPde3SvQxBvwc2GOTI4GXI5zvbTLRFvcEGx
         AGbHbEnLGeCwOozEKpTvyUxotEiTTnNjv6inA0lwY/Qszez/CUSG9OWGrms3an78tEEn
         tTpwS66zjdSS3hLf/dvzM1UXX6tyn+ws0DYwdZ39fO40IVLomt9gYa9j4OrSf3Oy0wmR
         g5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTgWx4scVyEdnNwP8DjnL1zHNWGeK2kwc0Zp2eRMXQk=;
        b=u+f5X4oTAdz5LeFoHHPeczAHk7fy8aqlhXpeRCfrA1wuOgFgWM2+D2s5rXYHV5ERco
         2cb/jy8zSfgfCxa29RIXbY6TMtdX8IPq6KpBsl5KKymxmt80Y16FPuafUN2i7jWL1eE8
         i1igZd3ivDe0iDdUNqgXzoOUFF4C3scnDvO5DyiwoCIiDYC1Iuo0cR7iLmUXDxGQsqbU
         HGK1j6WzY6TklfblMljjtL6hcbP2fyrcCY6NpcWAD8SMKsviovBvJJ2TGqWFEeW2TwNZ
         loQYKSHAoFO9087+inWcD7jordE3blg4rro4lmX/40MobCRzjDufTIWgRROEILXBZKHz
         GzJw==
X-Gm-Message-State: ANoB5pmTLRU4cs8SV8fQl+KA7X7GD3db6vgm0OfhMXwVR/8J1RCwxnBL
        ZZ7ZWlDSWL/sJf7OkA/ZFpKR4tjyfzFT/MxT
X-Google-Smtp-Source: AA0mqf7Bf1kskqLUj18tNkAcl3wyAWmGfpn9j1mAuma80CPFVrsgkisnFLZddTsm/ZeRKXFPmZsm1A==
X-Received: by 2002:a17:90a:fd0d:b0:219:828e:ba2 with SMTP id cv13-20020a17090afd0d00b00219828e0ba2mr1449958pjb.0.1670516794018;
        Thu, 08 Dec 2022 08:26:34 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id h13-20020a65468d000000b00477f5ae26bbsm13286522pgr.50.2022.12.08.08.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:26:33 -0800 (PST)
Date:   Thu, 8 Dec 2022 16:26:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/cpu: Process all CPUID dependencies after
 identifying CPU info
Message-ID: <Y5IQNY/fZw2JFA0B@google.com>
References: <20221203003745.1475584-1-seanjc@google.com>
 <20221203003745.1475584-2-seanjc@google.com>
 <Y5INU3o+SFReGkLz@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5INU3o+SFReGkLz@zn.tnic>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022, Borislav Petkov wrote:
> On Sat, Dec 03, 2022 at 12:37:43AM +0000, Sean Christopherson wrote:
> > Process all CPUID dependencies to ensure that a dependent is disabled if
> > one or more of its parent features is unsupported.
> 
> Just out of curiosity: this is some weird guest configuration, right?

No, it's also relevant for bare metal.

> Not addressing a real hw issue...

But it's not really a hardware issue either.  More like an admin/user issue.

The problem is that if a kernel is built for subset of CPU types, e.g. just Intel
or just Centaur, and then booted on an "unsupported" CPU type, init_ia32_feat_ctl()
will never be invoked because ->c_init() will point a default_init(), and so the
kernel never checks MSR_IA32_FEAT_CTL to see if VMX and/or SGX are fully enabled.

E.g. if someone booted an "unsupported" kernel and also disabled VMX in BIOS, then
the CPU will enumerate support for VMX in CPUID, but attempting to actually enable
VMX will fail due to VMX being disabled in MSR_IA32_FEAT_CTL.

> > diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> > index bf4ac1cb93d7..094fc69dba63 100644
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -1887,6 +1887,12 @@ static void identify_cpu(struct cpuinfo_x86 *c)
> >  
> >  	ppin_init(c);
> >  
> > +	/*
> > +	 * Apply CPUID dependencies to ensure dependent features are disabled
> > +	 * if a parent feature is unsupported but wasn't explicitly disabled.
> > +	 */
> > +	apply_cpuid_deps(c);
> 
> I'd probably call that resolve_cpuid_deps()...

"resolve" works for me.
