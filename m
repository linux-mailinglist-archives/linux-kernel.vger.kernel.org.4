Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498E96A0E58
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 18:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjBWRJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 12:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBWRJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 12:09:42 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC346190
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 09:09:40 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536c039f859so135158177b3.21
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 09:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESEYfucHSnOWaZatj5hNQPiLl3UqdNvq9+VGnD33XD0=;
        b=eacT4PM6bk+JAGYX8AtEreTJLTfD+mSJsjox9puZbiJhIzz/wIxHhoNqBFIAXYayu7
         ix2AdCa9GlyQPz6wKG3LR8o4NT+280wasX8/AykGzPPWlG6F17mnxqyPEg7H8lCLwAiX
         eXH6zqI0g24xM5ZEDyA5U2YNv7s9H603+yWuiAeHry6HpCAAUQ5/Ypm3z9qWSoASZAJv
         GIl+kmJbNVHeS7mmPwXAdOExvjZqQ9ItW1uw3DrabrHDmj3KBFLmoGmyQYc+K7/u+5MN
         XBySfkomcCwXORKGamuW5yTLWSpURcpZFsI0uJbe36YJ/e/6tvZI8z6lN62S38fr6TXv
         yALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESEYfucHSnOWaZatj5hNQPiLl3UqdNvq9+VGnD33XD0=;
        b=RlvQ3kiVZTLteOe8crzkQbWeaWeiAI0kxRk/IhAOWIKh9t2llFGKQT314czL7gblb5
         IT467XuwzLgRWLcECT//GW7DT8U8RLYbgLOc3YPBWBsySVEs6BGiFJxd6Fu90UtMI7UX
         kiOPfIgp1VU1IZUEb7CyQsQs3T/3WLqHvRe3u13z05iGDxvoOYlHK3bCUoFZTpB+4ATy
         DxUDUEHpM6eEGtvF+IWZtwyFpYfpKXxWJC3fXuVu/elBIQTdgBLOFlN6Gw5PAcivLsZO
         2NGqNXxHzNYl4/e3/5Re/CcHRM6GWBOeTeHAyXrq4UFZvELi3FMXor3lKL8v3ESvwJRg
         nd0Q==
X-Gm-Message-State: AO0yUKW5WUneSG9ZVF4D9aMMs+lScvpz+OLp2jGcqBDtj0omMeq5B3NC
        naTzXnmTsA19w8U2jo37yV4kkEOFaNI=
X-Google-Smtp-Source: AK7set+o4nZnorUIfwBQUKqlnrrJeoYQJz7sG9NME5jj+i7H5Ea4MTUvMN+YCmQEaMe31ZnG3Fe5siKK8IQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b60b:0:b0:52f:45a:5b00 with SMTP id
 u11-20020a81b60b000000b0052f045a5b00mr2611344ywh.2.1677172179211; Thu, 23 Feb
 2023 09:09:39 -0800 (PST)
Date:   Thu, 23 Feb 2023 09:09:37 -0800
In-Reply-To: <CAOUHufaK-BHdajDZJKjn_LU-gMkUTKa_9foMB8g-u9DyrVhPwg@mail.gmail.com>
Mime-Version: 1.0
References: <20230217041230.2417228-1-yuzhao@google.com> <20230217041230.2417228-3-yuzhao@google.com>
 <Y++q/lglE6FJBdjt@google.com> <CAOUHufaK-BHdajDZJKjn_LU-gMkUTKa_9foMB8g-u9DyrVhPwg@mail.gmail.com>
Message-ID: <Y/ed0XYAPx+7pukA@google.com>
Subject: Re: [PATCH mm-unstable v1 2/5] kvm/x86: add kvm_arch_test_clear_young()
From:   Sean Christopherson <seanjc@google.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Larabel <michael@michaellarabel.com>,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-mm@google.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023, Yu Zhao wrote:
> On Fri, Feb 17, 2023 at 9:27 AM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Thu, Feb 16, 2023, Yu Zhao wrote:
> > > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > > index 6aaae18f1854..d2995c9e8f07 100644
> > > --- a/arch/x86/include/asm/kvm_host.h
> > > +++ b/arch/x86/include/asm/kvm_host.h
> > > @@ -1367,6 +1367,12 @@ struct kvm_arch {
> > >        *      the MMU lock in read mode + the tdp_mmu_pages_lock or
> > >        *      the MMU lock in write mode
> > >        *
> > > +      * kvm_arch_test_clear_young() is a special case. It relies on two
> >
> > No, it's not.  The TDP MMU already employs on RCU and CMPXCHG.
> 
> It is -- you read it out of context :)

Ah, the special case is that it's fully lockless.  That's still not all that
special, e.g. see kvm_tdp_mmu_walk_lockless_{begin,end}().

>          * For reads, this list is protected by:
>          *      the MMU lock in read mode + RCU or
>          *      the MMU lock in write mode
>          *
>          * For writes, this list is protected by:
>          *      the MMU lock in read mode + the tdp_mmu_pages_lock or
>          *      the MMU lock in write mode
>          *
>          * kvm_arch_test_clear_young() is a special case.
>          ...
> 
>         struct list_head tdp_mmu_roots;
> 
> > Just drop the
> > entire comment.
> 
> Let me move it into kvm_arch_test_clear_young().

No, I do not want kvm_arch_test_clear_young(), or any other one-off function, to
be "special".  I love the idea of a lockless walk, but I want it to be a formal,
documented way to walk TDP MMU roots.  I.e. add macro to go with for_each_tdp_mmu_root()
and the yield-safe variants.

/* blah blah blah */
#define for_each_tdp_mmu_root_lockless(_kvm, _root, _as_id)		\
	list_for_each_entry_rcu(_root, &kvm->arch.tdp_mmu_roots, link)	\
		if (refcount_read(&root->tdp_mmu_root_count) &&		\
		    kvm_mmu_page_as_id(_root) != _as_id) {		\
		} else

> Also I want to be clear:
> 1. We can't just focus on here and now; we need to consider the distant future.

I 100% agree, but those words need to be backed up by actions.  This series is
littered with code that is not maintainable long term, e.g. open coding stuff
that belongs in helpers and/or for which KVM already provides helpers, copy-pasting
__kvm_handle_hva_range() instead of extending it to have a lockless option, poking
directly into KVM from mm/ code, etc.

I apologize for being so blunt.  My intent isn't to be rude/snarky, it's to set
very clear expectations for getting any of these changes merges.  I asbolutely do
want to land improvments to KVM's test+clear young flows, but it needs to be done
in a way that is maintainable and doesn't saddle KVM with more tech debt.

> 2. From my POV, "see the comments on ..." is like the index of a book.

And my _very_ strong preference is to provide the "index" via code, not comments.

> > Clearing a single bit doesn't need a CMPXCHG.  Please weigh in on a relevant series
> > that is modifying the aging flows[*], I want to have exactly one helper for aging
> > TDP MMU SPTEs.
> >
> > [*] https://lore.kernel.org/all/20230211014626.3659152-5-vipinsh@google.com
> 
> I'll take a look at that series. clear_bit() probably won't cause any
> practical damage but is technically wrong because, for example, it can
> end up clearing the A-bit in a non-leaf PMD. (cmpxchg will just fail
> in this case, obviously.)

Eh, not really.  By that argument, clearing an A-bit in a huge PTE is also technically
wrong because the target gfn may or may not have been accessed.  The only way for
KVM to clear a A-bit in a non-leaf entry is if the entry _was_ a huge PTE, but was
replaced between the "is leaf" and the clear_bit().
