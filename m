Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937E562E984
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 00:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240484AbiKQXXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 18:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbiKQXXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 18:23:14 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE88742DD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:23:13 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id k8so6480145wrh.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=To+1hKZHNGliAAsi3sjlLMbkRpr0UyHLDkyr8XsSEH4=;
        b=qpqdZ0sqb/StH3lCysYFk74dHUJh7EZV2fUhEEVHMn80HcqT9aJ8kHz28WVtNYnon7
         iVPoihuR+QYXMiA7Ak+I3j+7ZZukwg/8E4VqY2WibVFfszYGO3Q43ZLIJoI44o8mHdWA
         5E15D3LyRolOWgZGiC16oXnyv64RBOgy+sd/WTsdf6pr9swHoqqmSmTP5pYtd3WUdqqA
         A5SjgOZrJxCzWiTq/8M91jgz2jw7FIa/lSmu6zbmJO46o39gOeN5tQ2M2BV1hAo0yEmK
         +v/dJI/Q0Le/WyZsqDRpwTaLC4CoEjRfw1LE7Mhy/g22lh1f86JVRp1D77JPTcfHzo4y
         sPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=To+1hKZHNGliAAsi3sjlLMbkRpr0UyHLDkyr8XsSEH4=;
        b=JZjhFz4Ox6/g3Ay1+bE+qCAXPLfPDN+u7InMYY3A/ne3NhuPmgFB5xnmFW6T7sSVyZ
         7MenCtWTtqdJuoO29fKGQYxGTirh+vtPewhqGOebpeB9iNcg3jPz1/SL65DBtauzCih6
         SoMsK/BLltzuFZ7Xn87vAxOgpbw35q2Um/kAX6mJQGphMKHRvdPaxpwAwwQgC+Uvc6oT
         CuxW4bijc3Tl3+qAK8/NRFg0buRhYq/rLNlTSEK77mr8e+AfXb68Ze9Mq5w/fzSVJ1Hz
         9YolZzW3s9rVtdkq3ikdoMCi9ZsEEO4/gPdEJRaUTMeK8kNnyEDeBj5TlJrGpTtfVbP3
         rz6g==
X-Gm-Message-State: ANoB5pmOqtxGwnvS5JoFdrQkkOTLQqznC6JA39hmvuf+SBHR8xXBh231
        R95Ni8ereBeaFmR+otQBTLvs3A==
X-Google-Smtp-Source: AA0mqf5MqYZmGGq4x1Tmt014mbnl6hcoMvKbKayoFXRl6fajhYj0DuK6Sfc8tc7ZgsN7NJ0Qjpo9cA==
X-Received: by 2002:adf:e103:0:b0:22e:3180:f75a with SMTP id t3-20020adfe103000000b0022e3180f75amr2743740wrz.340.1668727391387;
        Thu, 17 Nov 2022 15:23:11 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:4799:a943:410e:976])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d6281000000b0022ae0965a8asm2062148wru.24.2022.11.17.15.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 15:23:10 -0800 (PST)
Date:   Fri, 18 Nov 2022 00:23:03 +0100
From:   Marco Elver <elver@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>, X86 ML <x86@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: WARNING: CPU: 0 PID: 0 at arch/x86/include/asm/kfence.h:46
 kfence_protect
Message-ID: <Y3bCV6VckVUEF7Pq@elver.google.com>
References: <CA+G9fYuFxZTxkeS35VTZMXwQvohu73W3xbZ5NtjebsVvH6hCuA@mail.gmail.com>
 <Y3Y+DQsWa79bNuKj@elver.google.com>
 <4208866d-338f-4781-7ff9-023f016c5b07@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4208866d-338f-4781-7ff9-023f016c5b07@intel.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
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

On Thu, Nov 17, 2022 at 06:34AM -0800, Dave Hansen wrote:
> On 11/17/22 05:58, Marco Elver wrote:
> > [    0.663761] WARNING: CPU: 0 PID: 0 at arch/x86/include/asm/kfence.h:46 kfence_protect+0x7b/0x120
> > [    0.664033] WARNING: CPU: 0 PID: 0 at mm/kfence/core.c:234 kfence_protect+0x7d/0x120
> > [    0.664465] kfence: kfence_init failed
> 
> Any chance you could add some debugging and figure out what actually
> made kfence call over?  Was it the pte or the level?
> 
>         if (WARN_ON(!pte || level != PG_LEVEL_4K))
>                 return false;
> 
> I can see how the thing you bisected to might lead to a page table not
> being split, which could mess with the 'level' check.

Yes - it's the 'level != PG_LEVEL_4K'.

We do actually try to split the pages in arch_kfence_init_pool() (above
this function) - so with "x86/mm: Inhibit _PAGE_NX changes from
cpa_process_alias()" this somehow fails...

> Also, is there a reason this code is mucking with the page tables
> directly?  It seems, uh, rather wonky.  This, for instance:
> 
> >         if (protect)
> >                 set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_PRESENT));
> >         else
> >                 set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
> > 
> >         /*
> >          * Flush this CPU's TLB, assuming whoever did the allocation/free is
> >          * likely to continue running on this CPU.
> >          */
> >         preempt_disable();
> >         flush_tlb_one_kernel(addr);
> >         preempt_enable();
> 
> Seems rather broken.  I assume the preempt_disable() is there to get rid
> of some warnings.  But, there is nothing I can see to *keep* the CPU
> that did the free from being different from the one where the TLB flush
> is performed until the preempt_disable().  That makes the
> flush_tlb_one_kernel() mostly useless.
> 
> Is there a reason this code isn't using the existing page table
> manipulation functions and tries to code its own?  What prevents it from
> using something like the attached patch?

Yes, see the comment below - it's to avoid the IPIs and TLB shoot-downs,
because KFENCE _can_ tolerate the inaccuracy even if we hit the wrong
TLB or other CPUs' TLBs aren't immediately flushed - we trade a few
false negatives for minimizing performance impact.

> diff --git a/arch/x86/include/asm/kfence.h b/arch/x86/include/asm/kfence.h
> index ff5c7134a37a..5cdb3a1f3995 100644
> --- a/arch/x86/include/asm/kfence.h
> +++ b/arch/x86/include/asm/kfence.h
> @@ -37,34 +37,13 @@ static inline bool arch_kfence_init_pool(void)
>  	return true;
>  }
>  
> -/* Protect the given page and flush TLB. */
>  static inline bool kfence_protect_page(unsigned long addr, bool protect)
>  {
> -	unsigned int level;
> -	pte_t *pte = lookup_address(addr, &level);
> -
> -	if (WARN_ON(!pte || level != PG_LEVEL_4K))
> -		return false;
> -
> -	/*
> -	 * We need to avoid IPIs, as we may get KFENCE allocations or faults
> -	 * with interrupts disabled. Therefore, the below is best-effort, and
> -	 * does not flush TLBs on all CPUs. We can tolerate some inaccuracy;
> -	 * lazy fault handling takes care of faults after the page is PRESENT.
> -	 */
> -

^^ See this comment. Additionally there's a real performance concern,
and the inaccuracy is something that we deliberately accept.

>  	if (protect)
> -		set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_PRESENT));
> +		set_memory_np(addr, addr + PAGE_SIZE);
>  	else
> -		set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
> +		set_memory_p(addr, addr + PAGE_SIZE);

Isn't this going to do tons of IPIs and shoot down other CPU's TLBs?
KFENCE shouldn't incur this overhead on large machines with >100 CPUs if
we can avoid it.

What does "x86/mm: Inhibit _PAGE_NX changes from cpa_process_alias()" do
that suddenly makes all this fail?

What solution do you prefer that both fixes the issue and avoids the
IPIs?

Thanks,
-- Marco
