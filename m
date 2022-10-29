Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9402A612569
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 23:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJ2VMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 17:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ2VMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 17:12:37 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9453CBF5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 14:12:35 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id mi9so6231625qvb.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 14:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETLKPxqsaGal116jans0YIcCD8eWvXgEySs7gsIGlTM=;
        b=b5x6oR4FXTWYPUc99zNzOcMHWWo3ItbOwAwf5GbuPqbyB1Eqo7uDya7OFTrl2yOVqJ
         +lmCdLemihCs18tijDGR3C4GbKAsmQe+VZrVW21/hfaBLzgFm3ux7f5Z/+CBvC5Yt/EN
         /tOuOnWSkaTKDnGdFqcTNc7EHxP5eGtM3HIPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETLKPxqsaGal116jans0YIcCD8eWvXgEySs7gsIGlTM=;
        b=Aq7nt1v6AHM7wdJ0YgPwTzox5FZu2x79uUo6m+0gA2N8jmBmASatWgSaVEzJRW1WoZ
         Qx4hVw9L1kQGCoHFaaxJwOdD+kIlRpBDA/kubBAUbSyJFCaA6huK4YP2wV/0MnYROA6j
         pbMSnMYWjrx2AhShB4GA7l0pE7ogPMgr1lleI+/NFWNT4SVtWtn04pzHzERFA6E2zQhc
         XFtSFBa87vnh+CBR66iKEYmuZxM/e4xRZMD/N5Mat5lUMn7umX6DwuxWXP6Ne6FH6fX7
         BljTwmk7HE6M4/zb6RHnJBN+d6jkVAPtbBF0neffTVzhWg8RJ4xJyqOKsVwg4kCM+Hgg
         4Rdg==
X-Gm-Message-State: ACrzQf2zwIeiCAmF6ZTU37dA82NEHLUWPccI2XEX9FOsgrlYQF+MvdP7
        Xn22EgJeIRYAB2ZIraP/HOWEtMJWKw/TZQ==
X-Google-Smtp-Source: AMsMyM5jrPGr5tCt4fZEfFxb344tqMfu9KkyrFlpsiRY7btqiTEr2AS8QlaD64pooqDov/Cc8W1ygg==
X-Received: by 2002:a05:6214:19c2:b0:4b1:7a38:49c1 with SMTP id j2-20020a05621419c200b004b17a3849c1mr4960845qvc.1.1667077954417;
        Sat, 29 Oct 2022 14:12:34 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id i22-20020a05620a405600b006cbe3be300esm1783224qko.12.2022.10.29.14.12.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 14:12:32 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-367cd2807f2so76737017b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 14:12:32 -0700 (PDT)
X-Received: by 2002:a0d:fe07:0:b0:360:c3e9:fc8a with SMTP id
 o7-20020a0dfe07000000b00360c3e9fc8amr5619835ywf.441.1667077952153; Sat, 29
 Oct 2022 14:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
 <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net> <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net> <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net> <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
 <Y1oub9MvqwGBlHkq@hirez.programming.kicks-ass.net> <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
 <6C548A9A-3AF3-4EC1-B1E5-47A7FFBEB761@gmail.com> <CAHk-=wh8oi0qQtYDFTfm7d1s5C8mG7ig=NfzGWt4zbjXMzcdqQ@mail.gmail.com>
 <F9E42822-DA1D-4192-8410-3BAE42E9E4A9@gmail.com> <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com> <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <3a57cfc5-5db4-bdc9-1ddf-5305a37ffa62@nvidia.com> <CAHk-=wj6EJvTtTeYQvkX3aOw6Q1SRYRV6xJP1+uHNvfAocO1hw@mail.gmail.com>
 <B39368D9-7E5D-4864-819C-CDEEAB4BD92D@gmail.com>
In-Reply-To: <B39368D9-7E5D-4864-819C-CDEEAB4BD92D@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 29 Oct 2022 14:12:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-SqWifNOnZ49zvGP9h06mJ36PDWkcMbfjnt=2gvE+ig@mail.gmail.com>
Message-ID: <CAHk-=wj-SqWifNOnZ49zvGP9h06mJ36PDWkcMbfjnt=2gvE+ig@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>, X86 ML <x86@kernel.org>,
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

On Sat, Oct 29, 2022 at 1:56 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> On Oct 29, 2022, at 1:15 PM, Linus Torvalds <torvalds@linux-foundation.or=
g> wrote:
>
> > (b) we could move the "page_remove_rmap()" into the "flush-and-free" pa=
th too
> >
> > And (b) would be fairly easy - same model as that dirty bit patch,
> > just a 'do page_remove_rmap too' - except page_remove_rmap() wants the
> > vma as well (and we delay the TLB flush over multiple vma's, so it's
> > not just a "save vma in mmu_gather=E2=80=9D).
>
> (b) sounds reasonable and may potentially allow future performance
> improvements (batching, doing stuff without locks).

So the thing is, I think (b) makes sense from a TLB flush standpoint,
but as mentioned, if filesystems _really_ want to feel in control,
none of these locks fundamentally help, because the whole "gup +
set_page_dirty()" situation still exists.

And that fundamentally does not hold any locks between the lookup and
the set_page_dirty(), and fundamentally doesn't stop an rmap from
happening in between, so while the zap_page_range() and dirty TLB case
case be dealt with that way, you don't actually fix any fundamental
issues.

Now, neither does my (c) case on its own, but as John Hubbard alluded
to, *if* we had some sane serialization for a struct page, maybe that
could then be used to at least avoid the issue with "rmap no longer
exists", and make the filesystem handling case a bit better.

IOW, I really do think that not only is (a) the current solution, it's
the *correct* solution.

But it is possible that (c) could then be used as a way to make (a)
more palatable to filesystems, in that at least then there would be
some way to serialize with "set_page_dirty()".

But (b) cannot be used for that - because GUP fundamentally breaks
that rmap association.

It's all nasty.

                Linus
