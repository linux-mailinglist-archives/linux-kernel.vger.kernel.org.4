Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C84E70FE44
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 21:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjEXTKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 15:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjEXTKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 15:10:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A62712E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 12:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684955383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RLt1jUkMRuYsgAKC2Cdank6FFEsvFTMJq5xzMGDDBh0=;
        b=JqtQ89PtZSL/UYjISHbiASty/O7umRgIaChcN/5nZU7fPQqM9AVIAWgGzmJpssiKXAZ8zr
        xkYP7pyamPYoAmF+KOGkUWbDss1ysfbYMS3TwMcLaDaUJaq7tL0rshj8DrE3xJZpZqnQI9
        1UZquFwRB0tV8kcZawZfhpsvDvajmak=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-4FxUtHIeNnyiKgI2f1FlVA-1; Wed, 24 May 2023 15:09:36 -0400
X-MC-Unique: 4FxUtHIeNnyiKgI2f1FlVA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f7d72d552fso453081cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 12:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684955375; x=1687547375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLt1jUkMRuYsgAKC2Cdank6FFEsvFTMJq5xzMGDDBh0=;
        b=KhylxJciq3B24LAb/ysZsmh7VpQN4zs+4tcbnvCZYr0EcesV4d/Nxu6mLE/yRWzj1Z
         WytuW0IY4PLg7eaeVXHDklAEgABJw/HUYpxv8w/Vq6IE1A2Wjq1u5IFbqemlhYVxxsLx
         YkBS/IrLkHJ369T6eGXJjCEDHDF6/Ew4Jt6cGLQHs/AtaPaZbQaRQ6JJo1UUfl4EoBvB
         xxb7Um0WfLMmVd8xOQaiMr/Witw86b+OVlThzinUN+QQ4L/XBvxj2Y8Vw6lSAcQm8w3p
         e6UDfD8YYbWV0Agwx5oUM5+0ZLc/uYg6nlT9/rY3PKCxhyMKlioQMcSRXG2qulQfsKKy
         i7IQ==
X-Gm-Message-State: AC+VfDxR5FlxICBwZTIN5mDeXegGEn48nfUOz56gITbElvA9NuKY5034
        n0O7Bp8Rgpr7KD+WhVOXvWEiDzDnMEcgy1faw71nfX3n6rMg/6scV/2l0s9bfH/tdEAN3cgoJVZ
        8u6ZmSNTkB9Mi3wSc7FKEk20xl9ZVwl1o
X-Received: by 2002:a05:622a:1a91:b0:3f4:fdaa:8e14 with SMTP id s17-20020a05622a1a9100b003f4fdaa8e14mr4565646qtc.2.1684955375204;
        Wed, 24 May 2023 12:09:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7BwuqNh4b6tgKt0w1lmfeAbL8sRjfw3morvt4PO25eB8mOzI2e/Sm85Z9xwtVdn4gN42cjgA==
X-Received: by 2002:a05:622a:1a91:b0:3f4:fdaa:8e14 with SMTP id s17-20020a05622a1a9100b003f4fdaa8e14mr4565606qtc.2.1684955374809;
        Wed, 24 May 2023 12:09:34 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id r11-20020ac85e8b000000b003f6be76a5c1sm1315507qtx.6.2023.05.24.12.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 12:09:34 -0700 (PDT)
Date:   Wed, 24 May 2023 15:09:33 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     David Stevens <stevensd@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v6 1/4] KVM: mmu: introduce new gfn_to_pfn_noref functions
Message-ID: <ZG5g7bhAlsli+Pao@x1n>
References: <20230330085802.2414466-1-stevensd@google.com>
 <20230330085802.2414466-2-stevensd@google.com>
 <ZGvUsf7lMkrNDHuE@google.com>
 <ZG45q0xJSnA6NKQN@x1n>
 <ZG4/VdHu2LqLTlct@google.com>
 <ZG5F3igFgdIAwrn4@x1n>
 <ZG5XmdYy3VtcyPAL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZG5XmdYy3VtcyPAL@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 11:29:45AM -0700, Sean Christopherson wrote:
> On Wed, May 24, 2023, Peter Xu wrote:
> > On Wed, May 24, 2023 at 09:46:13AM -0700, Sean Christopherson wrote:
> > > If we hack kvm_pfn_to_refcounted_page(), then all of those protections are lost
> > > because KVM would drop its assertions and also skip dirtying pages, i.e. would
> > > effectively suppress the latent detection by check_new_page_bad().
> > 
> > So it's probably that I totally have no idea what are the attributes for
> > those special pages so I don't understand enough on why we need to handle
> > those pages differently from e.g. PFNMAP pages, and also the benefits.
> > 
> > I think what I can tell is that they're pages that doesn't have
> > PageCompound bits set on either head or tails, however it's still a
> > multi-2-order large page.  Is there an example on how these pages are used
> > and allocated?  Why would we need those pages, and whether these pages need
> > to be set dirty/accessed after all?
> 
> The use case David is interested in is where an AMD GPU driver kmallocs() a
> chunk of memory, let's it be mmap()'d by userspace, and userspace then maps it
> into the guest for a virtual (passthrough?) GPU.  For all intents and purposes,
> it's normal memory, just not refcounted.

I'm not familiar enough with kmalloc, but what I think is kmalloc for large
chunks will be the same as alloc_pages, and I thought it should also be a
compound page already.  If that needs to be mmap()ed to userapp then I
assume it mostly should be kmalloc_large().

kmalloc -> kmalloc_large -> __kmalloc_large_node:

	flags |= __GFP_COMP;

Then when the new page allocated and being prepared (prep_new_page):

	if (order && (gfp_flags & __GFP_COMP))
		prep_compound_page(page, order);

I assume prep_compound_page() will make PageCompound return true for those
pages returned.  So I know I still miss something, but not sure
where.. because IIRC we're at least talking about !PageCompound pages.

> 
> > >  static bool kvm_is_ad_tracked_page(struct page *page)
> > >  {
> > > +       /*
> > > +        * Assert that KVM isn't attempting to mark a freed page as Accessed or
> > > +        * Dirty, i.e. that KVM's MMU doesn't have a use-after-free bug.  KVM
> > > +        * (typically) doesn't pin pages that are mapped in KVM's MMU, and
> > > +        * instead relies on mmu_notifiers to know when a mapping needs to be
> > > +        * zapped/invalidated.  Unmapping from KVM's MMU must happen _before_
> > > +        * KVM returns from its mmu_notifier, i.e. the page should have an
> > > +        * elevated refcount at this point even though KVM doesn't hold a
> > > +        * reference of its own.
> > > +        */
> > > +       if (WARN_ON_ONCE(!page_count(page)))
> > > +               return false;
> > > +
> > >         /*
> > >          * Per page-flags.h, pages tagged PG_reserved "should in general not be
> > >          * touched (e.g. set dirty) except by its owner".
> > > 
> > 
> > This looks like a good thing to have, indeed.  But again it doesn't seem
> > like anything special to the pages we're discussing here, say, !Compound &&
> > refcount==0 ones.
> 
> The problem is that if KVM ignores refcount==0 pages, then KVM can't distinguish
> between the legitimate[*] refcount==0 AMD GPU case and a buggy refcount==0
> use-after-free scenario.  I don't want to make that sacrifice as the legimiate
> !refcounted use case is a very specific use case, whereas consuming refcounted
> memory is ubiquituous (outside of maybe AWS).
> 
> [*] Consuming !refcounted pages is safe only for flows that are tied into the
>     mmu_notifiers.  The current proposal/plan is to add an off-by-default module
>     param that let's userspace opt-in to kmap() use of !refcounted memory, e.g.
>     this case and PFNMAP memory.

I see.

I think you mentioned that we can use one special bit in the shadow pte to
mark such special pages.  Does it mean that your above patch will still
cover what you wanted to protect even if we use the trick?  Because then
kvm_is_ad_tracked_page() should only be called when we're sure the special
bit is not set.  IOW, we can still rule out these pages already and
page_count()==0 check here can still be helpful to track kvm bugs?

-- 
Peter Xu

