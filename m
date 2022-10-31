Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D22612F94
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 06:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJaFAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 01:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJaFAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 01:00:53 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823806142
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:00:52 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id z1so1111632qkl.9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMoYPf5QlXxpUEaNojn2TFOmvOKnRgIek8nj+6VnLpI=;
        b=gDfyWnj8mazCtlw/gyjBjCoBw+EAoW04RRcZ+OnjPIkjADjY+8JLLNDXRI4fHh9aHW
         c5LKzgN4CbVicZAJMiq0u6LN3wVFv1CsntXdZyXlxitg+Jl6emrhrhtudeT5+5pmWQNb
         xDFlixN7NTaGR92MioTb0yjQ7OeVPhlyfUpUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMoYPf5QlXxpUEaNojn2TFOmvOKnRgIek8nj+6VnLpI=;
        b=wM+e7bLa6BVsvc9OeUxuK/XOIoPCC9AFekMgAEbfMrZhYvAStB6DXCICqAW25N6YLr
         ZK6rXZhXR3YsFBc7EwCsecdPjdbXmDsAgZHwGk+VWomjoMCFcJ7vmxmJF69lqfGdtmFO
         YDuXgJCq96VY8/glzt+hqSinrQAsuPaXZNyO7gUwrSphmwXTkWwcmGEOAD7R1ZAL8Zvp
         ST6PdxlXKZa+bFUDyMswkb/gA3DGORYQ/B7g2I3XrQU2o6r4S6x0PgK8vLG1NtuXhb/8
         pEtr64yT1a167o4Gr3+34scJsEczTUpVopBDkqQ9IA2kPfpEbVYZqZLBymuWnfxzG6Tu
         +0GA==
X-Gm-Message-State: ACrzQf3Jhc1SMHkvSX0zIiP2jImQLCT3QaWNBnVBrgXTuTba1/TLFBsV
        jPmDfj3NVmr5jxV99iRc3genLKDKw/7Cpw==
X-Google-Smtp-Source: AMsMyM4R1jKKgXOY7Y7zmVf9Y1MC1jwTJUF9xsUggvEmJE79jsYUSJiEX+h6r1gHsmCIWB8V6BqNrw==
X-Received: by 2002:a05:620a:797:b0:6fa:1b5a:2e51 with SMTP id 23-20020a05620a079700b006fa1b5a2e51mr5322402qka.686.1667192451360;
        Sun, 30 Oct 2022 22:00:51 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id j6-20020a05620a288600b006fa00941e9dsm3928956qkp.136.2022.10.30.22.00.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 22:00:49 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id j130so12469496ybj.9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:00:49 -0700 (PDT)
X-Received: by 2002:a25:bb02:0:b0:6ca:9345:b2ee with SMTP id
 z2-20020a25bb02000000b006ca9345b2eemr93317ybg.362.1667192449279; Sun, 30 Oct
 2022 22:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com> <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net> <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net> <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
 <Y1oub9MvqwGBlHkq@hirez.programming.kicks-ass.net> <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
 <6C548A9A-3AF3-4EC1-B1E5-47A7FFBEB761@gmail.com> <CAHk-=wh8oi0qQtYDFTfm7d1s5C8mG7ig=NfzGWt4zbjXMzcdqQ@mail.gmail.com>
 <F9E42822-DA1D-4192-8410-3BAE42E9E4A9@gmail.com> <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com> <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
 <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com> <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com> <A48A5CEB-2C02-4101-B315-6792D042C605@gmail.com>
In-Reply-To: <A48A5CEB-2C02-4101-B315-6792D042C605@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 30 Oct 2022 22:00:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZnVURfhWMmWiDX3D0kuqnJ0PLM_Na-U7ufzqPMxucjw@mail.gmail.com>
Message-ID: <CAHk-=wjZnVURfhWMmWiDX3D0kuqnJ0PLM_Na-U7ufzqPMxucjw@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 9:09 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> I am sorry for not managing to make it reproducible on your system.

Heh, that's very much *not* your fault. Honestly, I didn't try very
much or very hard.

I felt like I understood the problem cause sufficiently that I didn't
really need to have a reproducer, and I much prefer to just think the
solution through and try to make it really robust.

Or, put another way - I'm just lazy.

> Anyhow, I ran the tests with the patches and there are no failures.

Lovely.

> Thanks for addressing this issue.

Well, I'm not sure the issue is "addressed" yet. I think the patch
series is likely the right thing to do, but others may disagree with
this approach.

And regardless of that, this still leaves some questions open.

 (a) there's the issue of s390, which does its own version of
__tlb_remove_page_size.

I *think* s390 basically does the TLB flush synchronously in
zap_pte_range(), and that it would be for that reason trivial to just
add that 'flags' argument to the s390 __tlb_remove_page_size(), and
make it do

        if (flags & TLB_ZAP_RMAP)
                page_zap_pte_rmap(page);

at the top synchronously too. But some s390 person would need to look at it=
.

I *think* the issue is literally that straightforward and not a big
deal, but it's probably not even worth bothering the s390 people until
VM people have decided "yes, this makes sense".

 (b) the issue I mentioned with the currently useless
"page_mapcount(page) < 0" test with that patch.

Again, this is mostly just janitorial stuff associated with that patch seri=
es.

 (c) whether to worry about back-porting

I don't *think* this is worth backporting, but if it causes other
changes, then maybe..

> I understand from the code that you decided to drop the deferring of
> set_page_dirty(), which could - at least for the munmap case (where
> mmap_lock is taken for write) - prevent the need for =E2=80=9Cforce_flush=
=E2=80=9D and
> potentially save TLB flushes.

I really liked my dirty patch, but your warning case really made it
obvious that it was just broken.

The thing is, moving the "set_page_dirty()" to later is really nice,
and really makes a *lot* of sense from a conceptual standpoint: only
after that TLB flush do we really have no more people who can dirty
it.

BUT.

Even if we just used another bit for in the array for "dirty", and did
the set_page_dirty() later (but still before getting rid of the rmap),
that wouldn't actually *work*.

Why? Because the race with folio_mkclean() would just come back. Yes,
now we'd have the rmap data, so mkclean would be forced to serialize
with the page table lock.

But if we get rid of the "force_flush" for the dirty bit, that
serialization won't help, simply because we've *dropped* the page
table lock before we actually then do the set_page_dirty() again.

So the mkclean serialization needs *both* the late rmap dropping _and_
the page table lock being kept.

So deferring set_page_dirty() is conceptually the right thing to do
from a pure "just track dirty bit" standpoint, but it doesn't work
with the way we currently expect mkclean to work.

> I was just wondering whether the reason for that is that you wanted
> to have small backportable and conservative patches, or whether you
> changed your mind about it.

See above: I still think it would be the right thing in a perfect world.

But with the current folio_mkclean(), we just can't do it. I had
completely forgotten / repressed that horror-show.

So the current ordering rules are basically that we need to do
set_page_dirty() *and* we need to flush the TLB's before dropping the
page table lock. That's what gets us serialized with "mkclean".

The whole "drop rmap" can then happen at any later time, the only
important thing was that it was kept to at least after the TLB flush.

We could do the rmap drop still inside the page table lock, but
honestly, it just makes more sense to do as we free the batched pages
anyway.

Am I missing something still?

And again, this is about our horrid serialization between
folio_mkclean and set_page_dirty(). It's related to how GUP +
set_page_dirty() is also fundamentally problematic. So that dirty bit
situation *may* change if the rules for folio_mkclean() change...

                Linus
