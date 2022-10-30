Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C295612C55
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 19:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJ3SwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 14:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3SwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 14:52:06 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F9895B3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 11:52:06 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id w10so7239054qvr.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 11:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sGJoZ3wR3C11xvb7GaIg6baorbhSsKxe2IOKOLyB7c0=;
        b=eCoZ3hMHphyp8KZRGL74Bxq12EtKF7LycFxetVP38YeAh77jx8lE0W6TIpMSyXgkw3
         gk95GDzPoo4LNTdqUIaNHzANbkU32txnpbsaYOlLYpC01QCNI/o9G8a2/513H6cNImg5
         wplL7HkmDP3UbHq9YI3ASdy3oSUO6in9YjJJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGJoZ3wR3C11xvb7GaIg6baorbhSsKxe2IOKOLyB7c0=;
        b=5d/bf6Y9tvnCkRZSRWU8YeEWKaaeKe4hujHcEMw48ZoG0XEQ1DY0SSyfBbU+amNNcO
         N3SD2EeI/pJYCOINIg3FLjgt7GNIYuhfP5/37+UgiIDqmtrORhXJ6tRIPuTMxMTDFdSZ
         8PiUNWH/Gc39o1mD948cX1GuHtRQD2Ma2XxAmv9sQPnSXIlmJ98cJGk5RVvTa4Q3XWRB
         dLvwp6Hx0rULYkAzcNL63oy5x/g6n2Yq26m8fSLInNgSYm8wmfvrwWJqB95WK34L3jhg
         xQ8DjLNKe5v4dbYzDNraDiLomMMgZJAB+BisQWIXjjDXyrflydtkSyFjOKkYmyPzERuT
         PBow==
X-Gm-Message-State: ACrzQf2YWHwqhZCydS0byusIRdqy4x4u9mivmUHQut9Ui6Q2JzEuUMlY
        NdtINExtSJXuoZTKBA5bMMXWyUx9EyGsRg==
X-Google-Smtp-Source: AMsMyM5gKOG34VR2UtLof3RcaVNU7ed0j2K4VBgXV3ivhGtoK4DWICv9feie8O5exN4T0Pkn+lyolQ==
X-Received: by 2002:a05:6214:2528:b0:4b8:2025:5f6b with SMTP id gg8-20020a056214252800b004b820255f6bmr7937814qvb.47.1667155925219;
        Sun, 30 Oct 2022 11:52:05 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id q40-20020a05620a2a6800b006cfc9846594sm2576252qkp.93.2022.10.30.11.52.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 11:52:05 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-333a4a5d495so90823497b3.10
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 11:52:04 -0700 (PDT)
X-Received: by 2002:a81:555:0:b0:36b:2d71:5861 with SMTP id
 82-20020a810555000000b0036b2d715861mr9438354ywf.340.1667155924532; Sun, 30
 Oct 2022 11:52:04 -0700 (PDT)
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
In-Reply-To: <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 30 Oct 2022 11:51:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
Message-ID: <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 11:19 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And we'd _like_ to do the TLB flush before the remove_rmap(), but we
> *really* don't want to do that for every page.

Hmm. I have yet another crazy idea.

We could keep the current placement of the TLB flush, to just before
we drop the page table lock.

And we could do all the things we do in 'page_remove_rmap()' right now
*except* for the mapcount stuff.

And only move the mapcount code to the page freeing stage.

Because all the rmap() walk synchronization really needs is that
'page->_mapcount' is still elevated, and if it is it will serialize
with the page table lock.

And it turns out that 'page_remove_rmap()' already treats the case we
care about differently, and all it does is

        lock_page_memcg(page);

        if (!PageAnon(page)) {
                page_remove_file_rmap(page, compound);
                goto out;
        }
       ...
out:
        unlock_page_memcg(page);

        munlock_vma_page(page, vma, compound);

for that case.

And that 'page_remove_file_rmap()' is literally the code that modifies
the _mapcount.

Annoyingly, this is all complicated by that 'compound' argument, but
that's always false in that zap_page_range() case.

So what we *could* do, is make a new version of page_remove_rmap(),
which is specialized for this case: no 'compound' argument (always
false), and doesn't call 'page_remove_file_rmap()', because we'll do
that for the !PageAnon(page) case later after the TLB flush.

That would keep the existing TLB flush logic, keep the existing 'mark
page dirty' and would just make sure that 'folio_mkclean()' ends up
being serialized with the TLB flush simply because it will take the
page table lock because we delay the '._mapcount' update until
afterwards.

Annoyingly, the organization of 'page_remove_rmap()' is a bit ugly,
and we have several other callers that want the existing logic, so
while the above sounds conceptually simple, I think the patch would be
a bit messy.

                  Linus
