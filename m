Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205D065F6ED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbjAEWip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbjAEWij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:38:39 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA931BE87
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 14:38:37 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so3563465pjj.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 14:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zEu5HU2IeEKGpRdbjERsv9p6QJoIHh3mf8ocawMLHBw=;
        b=Fzec5p5c1DPBISgiuME4ApitKn75gZMe6plHlj1IaigkZELpDNS6GC3jjl7RiKEii6
         kOW1yg7QRv8wtlrBui43lZWM6JJEY1Yv3/o0V/R3ea6kPrBwk/mb6Ir94otk41UYTAx3
         QX983PTakWqXPx+WTlSp5pZaN2Z3T1guICiGkn1C0CBVbDYuxQqTWr3fUERRgQowWTNH
         0bbIF78RViaaw6i2QjPUwV0Z6TRYM6PDi+fyZj9HphkS07muEoW3a3yS2vQ5RvGK9Ryu
         GeATfieUAQm/s5I6+e5pIPVvsOVVTQrVgzt5jnUgOVXCPpYctHB5/AXEdanjfLKjH9uh
         xmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEu5HU2IeEKGpRdbjERsv9p6QJoIHh3mf8ocawMLHBw=;
        b=4yHC/N1PiQ4pvUOqEzvtq/RrYLKK2T/RsJcHoOJcFevrSeC1SnzR/S1+6bDiaHshbP
         jgEwt2I1sC61B7AYcLxeaFPe0kRfZ57Y8bPEIKGPQRrKDi/Ghkp+eEKWZ7WGEaB/ukEi
         I52So2EgRlKdk3Oecy/aqdsoJ0Fg6rACNbbbmgGGhj+99vAnK9dzzuGpcyRQUHFr/Utq
         Cx7yzdtp6tL47axJGfKQGSSwk+B+640Fv/FNz9TYcdNWIynrq78SuWDQXtnrmLX5jZus
         y1VPg5kdgF8DkvZKT33XuGkD0ZJ0RL22wn5J0i14T8YkpH4rcC0wGOmo9R/llgOForIW
         ZyZw==
X-Gm-Message-State: AFqh2krQf2ziwdJE+hDcP3GyX2mkm0cOZDxfOnEqCUvJvd6w1YoXp4wA
        srTP5yFoOUcorwBo4421Eyqxcg==
X-Google-Smtp-Source: AMrXdXsBTgnpOVsWhYqqxFvRAk1tPJTHO/p2Rdb/Hu8HdC2k0k9yHjvfTjTVRVrrnz6RNB/y3kimIg==
X-Received: by 2002:a05:6a20:c187:b0:9d:b8e6:d8e5 with SMTP id bg7-20020a056a20c18700b0009db8e6d8e5mr130066pzb.2.1672958317258;
        Thu, 05 Jan 2023 14:38:37 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709027ec800b001929f0b4582sm15295773plb.300.2023.01.05.14.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 14:38:36 -0800 (PST)
Date:   Thu, 5 Jan 2023 22:38:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] Documentation: kvm: clarify SRCU locking order
Message-ID: <Y7dRaY+spKan+VcV@google.com>
References: <20221228110410.1682852-2-pbonzini@redhat.com>
 <Y7RpB+trpnhVRhQW@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7RpB+trpnhVRhQW@google.com>
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

On Tue, Jan 03, 2023, Sean Christopherson wrote:
> On Wed, Dec 28, 2022, Paolo Bonzini wrote:
> > Currently only the locking order of SRCU vs kvm->slots_arch_lock
> > and kvm->slots_lock is documented.  Extend this to kvm->lock
> > since Xen emulation got it terribly wrong.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  Documentation/virt/kvm/locking.rst | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/virt/kvm/locking.rst b/Documentation/virt/kvm/locking.rst
> > index 845a561629f1..a3ca76f9be75 100644
> > --- a/Documentation/virt/kvm/locking.rst
> > +++ b/Documentation/virt/kvm/locking.rst
> > @@ -16,17 +16,26 @@ The acquisition orders for mutexes are as follows:
> >  - kvm->slots_lock is taken outside kvm->irq_lock, though acquiring
> >    them together is quite rare.
> >  
> > -- Unlike kvm->slots_lock, kvm->slots_arch_lock is released before
> > -  synchronize_srcu(&kvm->srcu).  Therefore kvm->slots_arch_lock
> > -  can be taken inside a kvm->srcu read-side critical section,
> > -  while kvm->slots_lock cannot.
> > -
> >  - kvm->mn_active_invalidate_count ensures that pairs of
> >    invalidate_range_start() and invalidate_range_end() callbacks
> >    use the same memslots array.  kvm->slots_lock and kvm->slots_arch_lock
> >    are taken on the waiting side in install_new_memslots, so MMU notifiers
> >    must not take either kvm->slots_lock or kvm->slots_arch_lock.
> >  
> > +For SRCU:
> > +
> > +- ``synchronize_srcu(&kvm->srcu)`` is called _inside_
> > +  the kvm->slots_lock critical section, therefore kvm->slots_lock
> > +  cannot be taken inside a kvm->srcu read-side critical section.
> > +  Instead, kvm->slots_arch_lock is released before the call
> > +  to ``synchronize_srcu()`` and _can_ be taken inside a
> > +  kvm->srcu read-side critical section.
> > +
> > +- kvm->lock is taken inside kvm->srcu, therefore
> 
> Prior to the recent Xen change, is this actually true?

I was thinking of a different change, but v5.19 is still kinda recent, so I'll
count it.  Better to be lucky than good :-)

Commit 2fd6df2f2b47 ("KVM: x86/xen: intercept EVTCHNOP_send from guests") introduced
the only case I can find where kvm->srcu is taken inside kvm->lock.

> There are many instances where kvm->srcu is taken inside kvm->lock, but I
> can't find any existing cases where the reverse is true.  Logically, it makes
> sense to take kvm->lock first since kvm->srcu can be taken deep in helpers,
> e.g. for accessing guest memory.  It's also more consistent to take kvm->lock
> first since kvm->srcu is taken inside vcpu->mutex, and vcpu->mutex is taken
> inside kvm->lock.
> 
> Disallowing synchronize_srcu(kvm->srcu) inside kvm->lock isn't probelmatic per se,
> but it's going to result in a weird set of rules because synchronize_scru() can,
> and is, called while holding a variety of other locks.
> 
> In other words, IMO taking kvm->srcu outside of kvm->lock in the Xen code is the
> real bug.

I'm doubing down on this.  Taking kvm->srcu outside of kvm->lock is all kinds of
sketchy, and likely indicates a larger problem.  The aformentioned commit that
introduced the problematic kvm->srcu vs. kvm->lock also blatantly violates ordering
between kvm->lock and vcpu->mutex.  Details in the link[*].

The vast majority of flows that take kvm->srcu will already hold a lock of some
kind, otherwise the task can't safely deference any VM/vCPU/device data and thus
has no reason to acquire kvm->srcu.  E.g. taking kvm->srcu to read guest memory
is nonsensical without a stable guest physical address to work with.

There are exceptions, e.g. evtchn_set_fn() and maybe some ioctls(), but in most
cases, taking kvm->lock inside kvm->srcu is just asking for problems.

[*] https://lore.kernel.org/all/Y7dN0Negds7XUbvI@google.com
