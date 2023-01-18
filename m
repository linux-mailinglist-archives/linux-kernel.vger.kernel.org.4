Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF3E672513
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjARRg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjARRgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:36:25 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5863801D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:36:24 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o13so33021502pjg.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a4q1xtD/CKeMJmqJVdndBp4lLHmpRzPtOcKZfvWbSM8=;
        b=IqhVEgZYxeoqosmDrZw0VHcez/IWLXpDhpBV/8crQnWyCyw+YtF6atjKQ0KTCsY/tb
         kiue/gcjDKIc8xRpCUGofqg+ybpedxX7giMLGocFT4Hp0F9aPwnteOFVvz6GOYUKlLuc
         gP5kzL9C/n9N8yqQEsMBhzMA+yC16QKARYH0oxlkoKJgVrbrkOz0QSzAUItKBKlXB7wA
         Lan65hXI7kmWH+xgSIqwqL73ZDcdbX6EyallD/VjWK7saodHhzFCy+I1fPtx1PhtdDQ+
         PQmrHWMHtKIkbkRqXNF07+SNQN8BOEY3Wst1+siC7nwXrr2BkVqEuLSK75giYJmjoCof
         WqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4q1xtD/CKeMJmqJVdndBp4lLHmpRzPtOcKZfvWbSM8=;
        b=x760ws7wavCrFGxw/Sev29VXk38ynd6fBp54v+N3yzW9j+tO5/I/AWAa+dJaeZdLy7
         jyz5SY97TeyKB7wrRRquQFn5rlU9mvd7DnlN6tpaVFVI4SxVAKfeudHudw5S/EgZ1eYU
         Gqn0X7H+UdSeZZh0a31RKvnbsbAWQL0qb8msJP78yzO1gG3yyBd5/CzlIsMQQRQe0QMn
         hZ+SuLYIOoTIoelJKP4dEbysWs/A4p/xaOdZ8KDhWfN7+5NMa++bylTw27PfwHiXSd59
         9i8WFD1QnoyNEHO9d6E95ciogDdz0vDWGn5/gV5msvgxly8zJefmgok3k/tqhfTJmmTr
         /r5A==
X-Gm-Message-State: AFqh2kqYF2eLj0vegS10sJbg0alQ5yK8b25Iz6vbKREsSDk+/OZoopGV
        z1SShExLz1oP0jgtKHtoZeVUEw==
X-Google-Smtp-Source: AMrXdXt3mAzgoOCRxsiIt2Jb+Ic9VnnOQcLmwqxkvTu7BgYy3xQwH+s2Ogh3uKQJZ2dbF4Xt1c5+Lw==
X-Received: by 2002:a17:90a:fd12:b0:226:5758:a57f with SMTP id cv18-20020a17090afd1200b002265758a57fmr3223912pjb.2.1674063383696;
        Wed, 18 Jan 2023 09:36:23 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id q93-20020a17090a4fe600b00229094aabd0sm1592729pjh.35.2023.01.18.09.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 09:36:23 -0800 (PST)
Date:   Wed, 18 Jan 2023 17:36:19 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Vipin Sharma <vipinsh@google.com>, pbonzini@redhat.com,
        bgardon@google.com, dmatlack@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 1/9] KVM: x86/mmu: Repurpose KVM MMU shrinker to purge
 shadow page caches
Message-ID: <Y8guE+d22xf0RePz@google.com>
References: <20221222023457.1764-1-vipinsh@google.com>
 <20221222023457.1764-2-vipinsh@google.com>
 <CAL715WKT_WbaUHT++tvnKr9fhGObiJpyKdD-zMmmcZnt4Bc=Gg@mail.gmail.com>
 <CAHVum0f9kxHBBR8mBQrA3FrNHvPvqkGE8qXxKJhrnKoE6XkySg@mail.gmail.com>
 <CAL715W+UjRqqs4aJHoGDf+1c1OMHp8LhhSNgtjkGD5TbFVW_ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL715W+UjRqqs4aJHoGDf+1c1OMHp8LhhSNgtjkGD5TbFVW_ng@mail.gmail.com>
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

On Tue, Jan 03, 2023, Mingwei Zhang wrote:
> On Tue, Jan 3, 2023 at 5:00 PM Vipin Sharma <vipinsh@google.com> wrote:
> > > I think the mmu_cache allocation and deallocation may cause the usage
> > > of GFP_ATOMIC (as observed by other reviewers as well). Adding a new
> > > lock would definitely sound like a plan, but I think it might affect
> > > the performance. Alternatively, I am wondering if we could use a
> > > mmu_cache_sequence similar to mmu_notifier_seq to help avoid the
> > > concurrency?
> > >
> >
> > Can you explain more about the performance impact? Each vcpu will have
> > its own mutex. So, only contention will be with the mmu_shrinker. This
> > shrinker will use mutex_try_lock() which will not block to wait for
> > the lock, it will just pass on to the next vcpu. While shrinker is
> > holding the lock, vcpu will be blocked in the page fault path but I
> > think it should not have a huge impact considering it will execute
> > rarely and for a small time.
> >
> > > Similar to mmu_notifier_seq, mmu_cache_sequence should be protected by
> > > mmu write lock. In the page fault path, each vcpu has to collect a
> > > snapshot of  mmu_cache_sequence before calling into
> > > mmu_topup_memory_caches() and check the value again when holding the
> > > mmu lock. If the value is different, that means the mmu_shrinker has
> > > removed the cache objects and because of that, the vcpu should retry.
> > >
> >
> > Yeah, this can be one approach. I think it will come down to the
> > performance impact of using mutex which I don't think should be a
> > concern.
> 
> hmm, I think you are right that there is no performance overhead by
> adding a mutex and letting the shrinker using mutex_trylock(). The
> point of using a sequence counter is to avoid the new lock, since
> introducing a new lock will increase management burden.

No, more locks doesn't necessarily mean higher maintenance cost.  More complexity
definitely means more maintenance, but additional locks doesn't necessarily equate
to increased complexity.

Lockless algorithms are almost always more difficult to reason about, i.e. trying
to use a sequence counter for this case would be more complex than using a per-vCPU
mutex.  The only complexity in adding another mutex is understanding why an additional
lock necessary, and IMO that's fairly easy to explain/understand (the shrinker will
almost never succeed if it has to wait for vcpu->mutex to be dropped).

> So unless it is necessary, we probably should choose a simple solution first.
> 
> In this case, I think we do have such a choice and since a similar
> mechanism has already been used by mmu_notifiers.

The mmu_notifier case is very different.  The invalidations affect the entire VM,
notifiers _must_ succeed, may or may not allowing sleeping, the readers (vCPUs)
effectively need protection while running in the guest, and practically speaking
holding a per-VM (or global) lock of any kind while a vCPU is running in the guest
is not viable, e.g. even holding kvm->srcu is disallowed.

In other words, using a traditional locking scheme to serialize guest accesses
with host-initiated page table (or memslot) updates is simply not an option.
