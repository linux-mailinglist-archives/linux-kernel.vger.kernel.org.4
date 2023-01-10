Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205FB663E85
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbjAJKri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjAJKr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:47:28 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0A9F70
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:47:26 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g10so8463576wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gESL4Bz9iT6dePdLePM4h7JabsGSyML/EeyVybNxskM=;
        b=SRqofO9ATd9Ldza2B+Wj+vdImzxrntJRgue/R2kPGwsyThBEO2uzWud8Adve7Gm3Ei
         PlqOXpeeuLE4eGMfZ2mQTWlWI8W25BufFol5P7xY1P0U/FfEIfR8Zvgj+63TCjYhC2f+
         bufDaUjYAQWIpX+ZMq/6nDleWdz8ZdS7515Hh2eWMDJiUbsS+8urSrGH19TpZ2AV92fP
         Mrz25y6zhwItZ7AuHJ3/9PEVUwaYiXBEweeSORzzcNO/lVONiyqsFqHrW5ko/bKfzqrI
         B66WTSZsRuKSQgbU09czv5Pkd81RE0aouQMc/p+iTRQj/0ScsY5bzDIY92llj2+oX08+
         MiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gESL4Bz9iT6dePdLePM4h7JabsGSyML/EeyVybNxskM=;
        b=jceF4k1ya2kgn1LDuhPAPWXO5kbcUHpN9h/DJ6AbPb5RF/qEBd21W/KpSXVPp+7S7U
         vAOwzdXk5txEHGPhYqyZGeQUqk8nXQwfx8tP8ZM2tSQ90Upv4UkAsPEftMTW3iTitALe
         F7WgwKQ5t7Fs+8qyHQoZcT24USxPfJg5Am2YjOYLIIQvxJIrlt6Ov64U19agyTPMhbDx
         9e7Y8Wy5LT0b7LKruCBLWRTGnqHgMGMLa735G/Q7LmvwcdYfX5nyzQqWZeSUx7jb9L6j
         CltBftZJLFEBSX8+fSJMOEltrcaemHlg1SBp1zTI/i3nztYF9UzXieYp4sVCBxJ85SJz
         Vzfg==
X-Gm-Message-State: AFqh2kpDD/qOCXEu5M5lRXV6B8p67S2DvhfiKUkwkQ6PNBq8OMkN8oh0
        WhBE39HtkfO+D2EboxmOB80=
X-Google-Smtp-Source: AMrXdXudS0DuPvKsVgA6ulADB8fD5UrQQlUPlzWQDyYBxNf3uv2mRLsCBdbTzPyQW/qKC3VIIfMFTw==
X-Received: by 2002:a05:600c:3b21:b0:3d9:bad8:4e9e with SMTP id m33-20020a05600c3b2100b003d9bad84e9emr21614905wms.40.1673347644883;
        Tue, 10 Jan 2023 02:47:24 -0800 (PST)
Received: from gmail.com (1F2EF2EB.nat.pool.telekom.hu. [31.46.242.235])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c020200b003d9ef8ad6b2sm6504035wmi.13.2023.01.10.02.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 02:47:23 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 10 Jan 2023 11:47:21 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Disable kernel stack offset randomization for
 !TSC
Message-ID: <Y71COYApLufn2SLu@gmail.com>
References: <alpine.DEB.2.21.2301082113350.65308@angie.orcam.me.uk>
 <Y7vvKHYXpe7KmwCI@gmail.com>
 <alpine.DEB.2.21.2301091946360.65308@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2301091946360.65308@angie.orcam.me.uk>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Maciej W. Rozycki <macro@orcam.me.uk> wrote:

> Jason,
> 
>  Would you mind commenting on the below?
> 
> On Mon, 9 Jan 2023, Ingo Molnar wrote:
> 
> > > For x86 kernel stack offset randomization uses the RDTSC instruction, 
> > > which causes an invalid opcode exception with hardware that does not 
> > > implement this instruction:
> > 
> > > @@ -85,7 +86,8 @@ static inline void arch_exit_to_user_mod
> > >  	 * Therefore, final stack offset entropy will be 5 (x86_64) or
> > >  	 * 6 (ia32) bits.
> > >  	 */
> > > -	choose_random_kstack_offset(rdtsc() & 0xFF);
> > > +	if (cpu_feature_enabled(X86_FEATURE_TSC))
> > > +		choose_random_kstack_offset(rdtsc() & 0xFF);
> > >  }
> > 
> > While this is an obscure corner case, falling back to 0 offset silently 
> > feels a bit wrong - could we at least attempt to generate some 
> > unpredictability in this case?
> > 
> > It's not genuine entropy, but we could pass in a value that varies from 
> > task to task and which is not an 'obviously known' constant value like the 
> > 0 fallback?
> > 
> > For example the lowest 8 bits of the virtual page number of the current 
> > task plus the lowest 8 bits of jiffies should vary from task to task, has 
> > some time dependence and is cheap to compute:
> > 
> > 	(((unsigned long)current >> 12) + jiffies) & 0xFF
> > 
> > This combined with the per-CPU forward storage of previous offsets:
> > 
> > #define choose_random_kstack_offset(rand) do {                          \
> >         if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT, \
> >                                 &randomize_kstack_offset)) {            \
> >                 u32 offset = raw_cpu_read(kstack_offset);               \
> >                 offset ^= (rand);                                       \
> >                 raw_cpu_write(kstack_offset, offset);                   \
> >         }                                                               \
> > 
> > Should make this reasonably hard to guess for long-running tasks even if 
> > there's no TSC - and make it hard to guess even for tasks whose creation an 
> > attacker controls, unless there's an info-leak to rely on.
> 
> Sure, I'm fine implementing it, even in such a way so as not to cause a 
> code size/performance regression for X86_TSC configurations.  But is the 
> calculation really unpredictable enough? [...]

It's not binary: it's obviously not as good as a TSC, but my point is that 
'something cheap & variable' is clearly better than 'zero offset all the 
time'.

Thanks,

	Ingo
