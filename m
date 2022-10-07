Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2600B5F7A34
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiJGPDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiJGPDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC26EDD88C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 08:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665155025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G8ttGtE2a2pTgoA/DqN+azedYAoX3sBGph+P0+5Qq/M=;
        b=WDKng4SfpMwQctJO1joseSzf02e3hIWfQisCKzp3ivLH6Pg5kouzktGJJrgopqB3J4oI7y
        69s5z4zzta+pkhmM1P6KD06xiRirTFFg7ZH7tEU3WrZNHplZvgiHbBym1yydqnmiUbcQKk
        DyFEUvqocOtD37RBwKGfeRjC327sI8k=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-500-_W7al9XuO-m-9MJk3OAWhw-1; Fri, 07 Oct 2022 11:03:43 -0400
X-MC-Unique: _W7al9XuO-m-9MJk3OAWhw-1
Received: by mail-qk1-f200.google.com with SMTP id h8-20020a05620a284800b006b5c98f09fbso3981044qkp.21
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 08:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8ttGtE2a2pTgoA/DqN+azedYAoX3sBGph+P0+5Qq/M=;
        b=wK46LuNJ/W31V9w+tMD4ELTL3PIfVths5aD2INhQxXrUHOERttVQY2rt/7yOz0hYzI
         ei+MkHUcl2KgaC62EWY2imXu3DDoG8qXvw0woZW88n8XAO0DJzCt3gBOluqp67pcNrDU
         AXUxSg3glKxmoCs+noS4mu1oXV54d99U4rl0mbMXAumzw5IXIGNvol+t3Be2g+uFL77Y
         ORWbMV5sxf6TlRtd4EN8F4SKHTalTFBI2mTG65kJ9g82r2ByQHUkcvukrGzjqMnV2Vae
         Ja6WQauYNR/N6O7OWDgxKlcwly2DqyfaZ7lVwN6PraYhw4UTHydHXePjvWjyFal612wo
         KpQQ==
X-Gm-Message-State: ACrzQf25al9xjIiNyyE+2iuC+Q6PJn+B+GUPkGp8hUO7BsjAoaWI154k
        O7amJjF+eNxb+q52YSOxwNoGGBOSIBp2ulcmcQGRcJoSFIxYtue7SRMK1rfaiqA+ApeC6fhan/S
        NE5IzyWFXyXWD8m69BVbzDPym
X-Received: by 2002:a05:622a:5cb:b0:394:8a8c:7063 with SMTP id d11-20020a05622a05cb00b003948a8c7063mr4558080qtb.330.1665155023532;
        Fri, 07 Oct 2022 08:03:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6rKdQz36a0mgxBntg7slDBs/JqYYsZlFJrYaDVhGwd+e+Z7Fl4Xv1Pf4YaXvUgtvGqcQ2Dsg==
X-Received: by 2002:a05:622a:5cb:b0:394:8a8c:7063 with SMTP id d11-20020a05622a05cb00b003948a8c7063mr4558054qtb.330.1665155023292;
        Fri, 07 Oct 2022 08:03:43 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id v1-20020a05620a0f0100b006bb8b5b79efsm2339333qkl.129.2022.10.07.08.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 08:03:42 -0700 (PDT)
Date:   Fri, 7 Oct 2022 11:03:41 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 2/3] kvm: Add new pfn error KVM_PFN_ERR_SIGPENDING
Message-ID: <Y0A/zTD/KhiyLkcg@x1n>
References: <20220817003614.58900-1-peterx@redhat.com>
 <20220817003614.58900-3-peterx@redhat.com>
 <Yz+DRTfdFGmSR7Mq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yz+DRTfdFGmSR7Mq@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 01:39:17AM +0000, Sean Christopherson wrote:
> On Tue, Aug 16, 2022, Peter Xu wrote:
> > Since at it, renaming kvm_handle_bad_page to kvm_handle_error_pfn assuming
> 
> Please put parantheses after function names, e.g. kvm_handle_bad_page().
> 
> > that'll match better with what it does, e.g. KVM_PFN_ERR_SIGPENDING is not
> > accurately a bad page but just one kind of errors.
> 
> ...
> 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 3e1317325e1f..23dc46da2f18 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -3134,8 +3134,13 @@ static void kvm_send_hwpoison_signal(unsigned long address, struct task_struct *
> >  	send_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, PAGE_SHIFT, tsk);
> >  }
> >  
> > -static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> > +static int kvm_handle_error_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> >  {
> > +	if (is_sigpending_pfn(pfn)) {
> > +		kvm_handle_signal_exit(vcpu);
> > +		return -EINTR;
> > +	}
> 
> ...
> 
> > @@ -2648,9 +2651,12 @@ kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool *async,
> >  	if (atomic)
> >  		return KVM_PFN_ERR_FAULT;
> >  
> > -	npages = hva_to_pfn_slow(addr, async, write_fault, writable, &pfn);
> > +	npages = hva_to_pfn_slow(addr, async, write_fault, interruptible,
> > +				 writable, &pfn);
> >  	if (npages == 1)
> >  		return pfn;
> > +	if (npages == -EINTR)
> > +		return KVM_PFN_ERR_SIGPENDING;
> 
> This patch should be split into 3 parts:
> 
>   1. Add KVM_PFN_ERR_SIGPENDING and the above code
>   2. Add the interruptible flag
>   3. Add handling in x86 and rename kvm_handle_bad_page()
> 
> With #3 merged with patch 3.
> 
> That was if there's oddball arch code that reacts poorly to KVM_PFN_ERR_SIGPENDING,
> those errors will bisect to #1.
> 
> And if there's a typo in the plumbing, that bisects to #2.
> 
> And if something goes sideways in x86, those bugs bisect to #3 (patch 3), and it's
> easy to revert just the x86 changes (though I can't imagine that's likely).

Yeah the x86 change in this patch is indeed a bit weird with the generic
subject.  All points taken, thanks.

-- 
Peter Xu

