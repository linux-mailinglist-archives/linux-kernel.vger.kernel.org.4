Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A8B613C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiJaRUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiJaRUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:20:05 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9DB13CE0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:20:02 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id i12so8774207qvs.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hD1Ogw5vFYWjfneHEDapbTXtrffLP/E4Nia3oOQ8AoU=;
        b=f0RU/VFeJ5For2WO7vDA7iIYnLqEaKTc1Lu+Sqwru2eHZ1BUFcvUTeCJDJqpztdBJz
         Q/PTWoHIaFg/GB7Own09eaHoSjsljb+/OLn3aHJiqk3rkksti+XYFdWc4Abc0trCKxRT
         aAu2j6YLmIKVA5dcfpud7vVJ2diaqeZHqDiZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hD1Ogw5vFYWjfneHEDapbTXtrffLP/E4Nia3oOQ8AoU=;
        b=I6QA3KSeVbuFoJGkwfcnZEE4ej4ZQeM//EsHqe0kUNVh4b3P0LUSWrHvwlHJMxvZFs
         qICHtqIQsdugNFiETmmly+Lv0Qi+0QgK7xJsirkIikAtdXHen1ShSkBYB3QCgEvnE8RW
         i0xZ18SPTLiDfvlHOwj/AtZfz9Wl1fpCcWj1WcfGZQuSdoRdG1RLX+VYSsOP05VT/h+N
         PYSi+yAwy4w6edyPpTNLKeD/S980CfaQ6W/gh3UD85AuZTh4Fw1bpB0pP7vC7X8JTiOL
         dNIDN3H0fsVZwsj2sEigGopxcwzXDZ3gphia8Lk4VDBqk6CB/1YfmJzF27JFP5qfvGXl
         DeSg==
X-Gm-Message-State: ACrzQf1+3rSHNqjORyp2eG41Md0k0HJAHlWBrECcwbxlm+mo96gqjUvF
        GUC/qewiSo1eePBRkRvnA4kituMKyLvIVw==
X-Google-Smtp-Source: AMsMyM5SpSeMvjeluigDAqGFzpGndF9jnsgKJQlfRg7uZfQCwQnW4AXOXn502UcvV7RfNKHZ2qdl0g==
X-Received: by 2002:ad4:5eca:0:b0:4ba:535a:6d45 with SMTP id jm10-20020ad45eca000000b004ba535a6d45mr11875894qvb.56.1667236801600;
        Mon, 31 Oct 2022 10:20:01 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id h14-20020ac8714e000000b003a4f14378d1sm3911067qtp.33.2022.10.31.10.19.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 10:20:00 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id r3so14456035yba.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:19:59 -0700 (PDT)
X-Received: by 2002:a25:bb02:0:b0:6ca:9345:b2ee with SMTP id
 z2-20020a25bb02000000b006ca9345b2eemr2591588ybg.362.1667236799371; Mon, 31
 Oct 2022 10:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <F9E42822-DA1D-4192-8410-3BAE42E9E4A9@gmail.com>
 <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com> <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com> <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
 <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com> <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com> <Y1+VWfNC7BvP8Pr2@hirez.programming.kicks-ass.net>
In-Reply-To: <Y1+VWfNC7BvP8Pr2@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Oct 2022 10:19:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiuVAHSqQdGX837J279WaXXmOk883PmYojRihYC4oCLNg@mail.gmail.com>
Message-ID: <CAHk-=wiuVAHSqQdGX837J279WaXXmOk883PmYojRihYC4oCLNg@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>, Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jroedel@suse.de, ubizjak@gmail.com,
        Alistair Popple <apopple@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 2:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, Oct 30, 2022 at 03:47:36PM -0700, Linus Torvalds wrote:
>
> > + * This is the simplified form of page_remove_rmap(), that only
> > + * deals with last-level pages, so 'compound' is always false,
> > + * and the caller does 'munlock_vma_page(page, vma, compound)'
> > + * separately.
> > + *
> > + * This allows for a much simpler calling convention and code.
> > + *
> > + * The caller holds the pte lock.
> > + */
> > +void page_zap_pte_rmap(struct page *page)
> > +{
>
> One could consider adding something like:
>
> #ifdef USE_SPLIT_PTE_PTLOCKS
>         lockdep_assert_held(ptlock_ptr(page))
> #endif

Yes, except that the page lock goes away in the next few patches and
gets replaced by just using the safe dec_lruvec_page_state() instead,
so it's not really worth it.

> > +     if (!atomic_add_negative(-1, &page->_mapcount))
> > +             return;
> > +
> > +     lock_page_memcg(page);
> > +     __dec_lruvec_page_state(page,
> > +             PageAnon(page) ? NR_ANON_MAPPED : NR_FILE_MAPPED);
> > +     unlock_page_memcg(page);
> > +}
>
> Took me a little while, but yes, .compound=false seems to reduce to
> this.

Yeah - it's why I kept that thing as three separate patches, because
even if each of the patches isn't "immediately obvious", you can at
least go back and follow along and see what I did.

The *full* simplification end result just looks like magic.

Admittedly, I think a lot of that "looks like magic" is because the
rmap code has seriously cruftified over the years. We had that time
when we actually

Go back a decade, and we literally used to do pretty much exactly what
the simplified form does. The transformation to complexity hell starts
with commit 89c06bd52fb9 ("memcg: use new logic for page stat
accounting"), but just look at what it looked like before that:

  git show 89c06bd52fb9^:mm/rmap.c

gets you the state back when it was simple. And look at what it did:

        void page_remove_rmap(struct page *page)
        {
                /* page still mapped by someone else? */
                if (!atomic_add_negative(-1, &page->_mapcount))
                        return;
                ... statistics go here ..

so in the end the simplified form of this page_zap_pte_rmap() really
isn't *that* surprising.

In fact, that old code handled PageHuge() fairly naturally too, and
almost all the mess comes from the memcg accounting - and locking -
changes.

And I actually really wanted to one step further, and try to then
batch up the page state accounting too. It's kind of stupid how we do
all that memcg locking for each page, and with this new setup we have
one nice array of pages that we *could* try to just batch things with.

The pages in normal situations *probably* mostly all share the same
memcg and node, so just optimistically trying to do something like "as
long as it's the same memcg as last time, just keep the lock".

Instead of locking and unlocking for every single page.

But just looking at it exhausted me enough that I don't think I'll go there.

Put another way: after this series, it's not the 'rmap' code that
makes me go Ugh, it's the memcg tracking..

(But the hugepage rmap code is incredibly nasty stuff still, and I
think the whole 'compound=true' case would be better with somebody
taking a look at that case too, but that somebody won't be me).

                  Linus
