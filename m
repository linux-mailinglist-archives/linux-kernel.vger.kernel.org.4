Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B237619EDD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiKDRfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiKDRfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:35:38 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE3C31FBA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:35:37 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id i12so3672083qvs.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7JBbJ2Fvdhb3EiG7i7cT3Xt7aRcECjo+Ml9qZORLks=;
        b=QtMfbnehToVkf5LyUXFO65eJG6We/YS6qgzH8Z2QVSs2weEaaF7YugQA4+T+JfaIPw
         6dimRZa67FxZZM+NBrxbn3JA/iGOuUs1OWmETpF/W40mXdVqlUFdgDVv7Dko3fTRTMqj
         2E8UHpNacdU4QteBhPkPgS/IGURatVauQnjJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7JBbJ2Fvdhb3EiG7i7cT3Xt7aRcECjo+Ml9qZORLks=;
        b=oJNhGuB8dYvKy8lm8p3ReKOjoscvwF1qhxb3WEevFmAy//mcGCqqcdYdslYVfpShrl
         m60RczG1T4NFgqmpUtmyPv7mVkn/bUjLUx1Hgn13mQAfz2obLfeNYTlMsaD6PIjiDBKD
         B/tFO5FrDkHpbXTda72zBJRHY3KZsJvPwnYQZIACKPy66eGiWJbE27osaUgaJnbrHd1W
         LcRpdLLivllUkRe3XqJM7jDtEEYqskz1gYUEsuC4Tkxqhu393QZt3E87oekLHaINCyAd
         1BMKJ313fZjdhjkfkiLkkTUbqgXQz4u1TDEjkdilZbCmvBcjN2R+H94d/ouTDBXqzd+2
         0D4A==
X-Gm-Message-State: ACrzQf3/iqGT5VLNIUnAtHqSzMmE0fY++sGErvdBGDh4KyIkW4h104R5
        OnvlBjA7dvDUvhg5Pe4oNFtiBCoAPU+N9A==
X-Google-Smtp-Source: AMsMyM5rP49rFAMEO/typtj47FR8kNDcyjkXR4KnmHz5E0FRrfaucKg5DAE+vqWpjiwtsBFhABz/ZA==
X-Received: by 2002:a05:6214:e46:b0:4bc:c9b:6972 with SMTP id o6-20020a0562140e4600b004bc0c9b6972mr22826476qvc.113.1667583336609;
        Fri, 04 Nov 2022 10:35:36 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id o2-20020ac85a42000000b003a4f6a566e9sm2869938qta.83.2022.11.04.10.35.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 10:35:35 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id j130so6594095ybj.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:35:35 -0700 (PDT)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr37488759ybu.310.1667583334773; Fri, 04
 Nov 2022 10:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
 <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com> <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
 <Y1+XCALog8bW7Hgl@hirez.programming.kicks-ass.net> <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
 <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com> <Y2SyJuohLFLqIhlZ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
In-Reply-To: <Y2SyJuohLFLqIhlZ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Nov 2022 10:35:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjzp65=-QE1dg8KfqG-tVHiT+yAfHXGx9sro=8yOceELg@mail.gmail.com>
Message-ID: <CAHk-=wjzp65=-QE1dg8KfqG-tVHiT+yAfHXGx9sro=8yOceELg@mail.gmail.com>
Subject: Re: mm: delay rmap removal until after TLB flush
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Uros Bizjak <ubizjak@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        linux-arch <linux-arch@vger.kernel.org>
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

On Thu, Nov 3, 2022 at 11:33 PM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> I rather have a question to the generic part (had to master the code quotting).

Sure.

Although now I think the series in in Andrew's -mm tree, or just about
to get moved in there, so I'm not going to touch my actual branch any
more.

> > static void clean_and_free_pages_and_swap_cache(struct encoded_page **pages, unsigned int nr)
> > {
> >       for (unsigned int i = 0; i < nr; i++) {
> >               struct encoded_page *encoded = pages[i];
> >               unsigned int flags = encoded_page_flags(encoded);
> >               if (flags) {
> >                       /* Clean the flagged pointer in-place */
> >                       struct page *page = encoded_page_ptr(encoded);
> >                       pages[i] = encode_page(page, 0);
> >
> >                       /* The flag bit being set means that we should zap the rmap */
>
> Why TLB_ZAP_RMAP bit is not checked explicitly here, like in s390 version?
> (I assume, when/if ENCODE_PAGE_BITS is not TLB_ZAP_RMAP only, calling
> page_zap_pte_rmap() without such a check would be a bug).

No major reason. This is basically the same issue as the naming, which
I touched on in

  https://lore.kernel.org/all/CAHk-=wiDg_1up8K4PhK4+kzPN7xJG297=nw+tvgrGn7aVgZdqw@mail.gmail.com/

and the follow-up note about how I hope the "encoded page pointer with
flags" thing gets used by the mlock code some day too.

IOW, there's kind of a generic "I have extra flags associated with the
pointer", and then the specific "this case uses this flag", and
depending on which mindset you have at the time, you might do one or
the other.

So in that clean_and_free_pages_and_swap_cache(), the code basically
knows "I have a pointer with extra flags", and it's written that way.
And that's partly historical, because it actually started with the
original code tracking the dirty bit as the extra piece of
information, and then transformed into this "no, the information is
TLB_ZAP_RMAP".

So "unsigned int flags" at one point was "bool dirty" instead, but
then became more of a "I think this whole page pointer with flags is
general", and the naming changed, and I had both cases in mind, and
then the code is perhaps not so specifically named. I'm not sure the
zap_page_range() case will ever use more than one flag, but the mlock
case already has two different flags. So the "encode_page" thing is
very much written to be about more than just the zap_page_range()
case.

But yes, that code could (and maybe should) use "if (flags &
TLB_ZAP_RMAP)" to make it clear that in this case, the single flags
bit is that one bit.

But the "if ()" there actually does two conceptually *separate*
things: it needs to clean the pointer in-place (which is regardless of
"which" flag bit is set, and then it does that page_zap_pte_rmap(),
which is just for the TLB_ZAP_RMAP bit.

So to be really explicit about it, you'd have two different tests: one
for "do I have flags that need to be cleaned up" and then an inner
test for each flag. And since there is only one flag in this
particular use case, it's essentially that inner test that I dropped
as pointless.

In contrast, in the s390 version, that bit was never encoded as a a
general "flags associated with a page pointer" in the first place, so
there was never any such duality. There is only TLB_ZAP_RMAP.

Hope that explains the thinking.

                 Linus
