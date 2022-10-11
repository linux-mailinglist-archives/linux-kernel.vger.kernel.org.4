Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DFB5FBA2A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiJKSRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJKSRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:17:19 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEB5F012
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:17:18 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r17so33209623eja.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s61i+pH9FZB5bmErB62bJ6mkpIWasrC0YJTzljapRO0=;
        b=Xim7TYvCya4GVHh39kMEmXRdXmFH/PR994kU/2snslQ6CKiKjnm84UmFO3P3+sYmaO
         vRV+rIhg6nb959wZXfzeHAfUgIME0yMc/0X8r+Jym1knbtCtlDKF2q37ZqWx3zHRB+e4
         qjxPkDUoZLI+9wqn7QzzlJj9TCG9ZrQGyxTjcKi5H386CXM3a+SHqsAWr/71HIpbFbaN
         pZMd6RoHJamw478D93N2pXiLctNOcaW5QYXNrTZRW3tPiD1nEjr0/mKO3vP8/NLJ5x4U
         haxoVML4Zc3nUXZ27QIrhYOOhg9aBmS1hr83y70hfE3hW8p+n090VkHUA/aDSaX5D1KF
         seCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s61i+pH9FZB5bmErB62bJ6mkpIWasrC0YJTzljapRO0=;
        b=CHPaFDUVoy4n0VbkB3YuzwjP4MTxW6eEkjz+Dphn0fwdtH41fCbOok4qLlRY2mVFnF
         SmtMCb6VTTE3wxtW0E1PWTN14gDod0NP0+YxYOc1SQMxnuTzcN9L4gOHmHKGcCvYmGa9
         w/o0vWCdO8RKZ7I3eFxak+II3jH3vRTUy95yapt5AD30Qj2SkqTRiXA4rHVavrqJ+H2c
         qIEtVfKQa9h8X0knWzR03fjvQBnWm/gE6/TctjosfIVOeiwnDii5jcI2fV5sXE63bR6s
         UkMC4see8V5hY7UxgOYpCajWO6ZReGO56p9Ri6fjeZIl6jQMs9xIGwnGieUahDPkrNpu
         hJ3Q==
X-Gm-Message-State: ACrzQf0HcfAGSmqr084M/U4pUsAT+YqCs5/afX4l4JvqRlEhZAHTlaLD
        A7lcx7xAIDesFC1NLBR7y0E/Tj7xcRVv/g==
X-Google-Smtp-Source: AMsMyM6QeD0epfM203Pe/bLJJa6W/QhR+KGtuNfJJkrmmA+3VHA67IIHvGa9wwgyrAz6zmtP58PZ9w==
X-Received: by 2002:a17:907:2d8b:b0:781:c864:fffd with SMTP id gt11-20020a1709072d8b00b00781c864fffdmr19090020ejc.681.1665512237210;
        Tue, 11 Oct 2022 11:17:17 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id b17-20020a50b411000000b00454546561cfsm9618273edh.82.2022.10.11.11.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:17:16 -0700 (PDT)
Date:   Tue, 11 Oct 2022 20:17:15 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <20221011181715.dpayrpjueha7kxoj@kamzik>
References: <20221011175031.1782748-1-ajones@ventanamicro.com>
 <Y0WvX9Mp0kuohNdq@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0WvX9Mp0kuohNdq@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 08:01:03PM +0200, Borislav Petkov wrote:
> On Tue, Oct 11, 2022 at 07:50:31PM +0200, Andrew Jones wrote:
> > Upcoming cpumask changes will start issuing warnings[*] when cpu
> 
> What upcoming changes?
> 
> This needs a concrete pointer to a commit or so.

Hi Boris,

Sorry, I should have pointed this out. The upcoming change is

linux-next/master commit a314123c8bdb ("cpumask: fix checking valid cpu
range")

And also an ongoing discussion here
https://lore.kernel.org/lkml/20221011170949.upxk3tcfcwnkytwm@kamzik/

I'm hoping that Yury will pick these patches up and integrate
them at the front of his series when introducing the warnings.
I wasn't sure how to call that out other than with the generic
"upcoming change".

> 
> > indices equal to nr_cpu_ids are passed to cpumask_next* functions.
> 
> How do those indices get passed here? I think you need to explain how
> exactly this happens.

I took a stab at explaining it in the discussion thread[1] just now and I
can bring that explanation into the commit message for v2.

[1] https://lore.kernel.org/lkml/20221011180442.cwjtcvjioias3qt6@kamzik/

> 
> > Ensure we don't generate a warning when reading /proc/cpuinfo by
> 
> Please use passive voice in your commit message: no "we" or "I", etc,
> and describe your changes in imperative mood.

I'll change to "Ensure no warning is generated ..."

> 
> > validating the cpu index before calling cpumask_next().
> 
> s/cpu/CPU/g
> 
> > [*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.
> > 
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > Cc: Yury Norov <yury.norov@gmail.com>
> > ---
> >  arch/x86/kernel/cpu/proc.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
> > index 099b6f0d96bd..584ae6cb5b87 100644
> > --- a/arch/x86/kernel/cpu/proc.c
> > +++ b/arch/x86/kernel/cpu/proc.c
> > @@ -153,9 +153,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
> >  
> >  static void *c_start(struct seq_file *m, loff_t *pos)
> >  {
> > -	*pos = cpumask_next(*pos - 1, cpu_online_mask);
> > -	if ((*pos) < nr_cpu_ids)
> > -		return &cpu_data(*pos);
> > +	if (*pos < nr_cpu_ids) {
> > +		*pos = cpumask_next(*pos - 1, cpu_online_mask);
> > +		if (*pos < nr_cpu_ids)
> > +			return &cpu_data(*pos);
> > +	}
> 
> Simpler: on function entry:
> 
> 	if (*pos >= nr_cpu_ids)
> 		return NULL;
> 
> 	 /* the rest remains unchanged */

Will do for v2.

Thanks,
drew
