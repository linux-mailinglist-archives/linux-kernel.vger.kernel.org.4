Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D7B6101EA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbiJ0TnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbiJ0TnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:43:22 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD5D80484
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:43:21 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id t16so2343669qvm.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u5WV0fN4ArkrzknOWlVXairTOGe+oE0SgEdnrwAT0fQ=;
        b=PgC9fn7D8Pv3QW3LbTscPthfBT03SvxrZhga/+9qUt92e4hANFEMmShtrwv+hZmOkD
         c+x6P5DXf49yiOOlImuPHVf51/ucyxNwZcAqMuLweZiWm9eBv566KvERROVEAOknj5uP
         xWIcpidBKZW02pfeL6mmtPCiWD0jzIW6ZS7ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5WV0fN4ArkrzknOWlVXairTOGe+oE0SgEdnrwAT0fQ=;
        b=EtVo3Y8tzA3Z1bgRmOpoMYUgSJ7MBVq8Z1RNZyJTUG2VajEvKESJAK/DS1TiUD5Nu8
         9pMIxZqcOr0xScTuwa8AlhQcPnFfLrwcHQsOeuiDqd9oy4mLAiQ14EGNzfZ/gQkPEjXT
         P/1iOKeJZuuip2IQ1L+SsjnLNE5TzF2sxgq/A5aOJV9vVOWeSc4PPP1S9ngA/ceGVHwm
         8jkpFgLx2Hy7N7kWAzuPWMy5dCYrv1VO3gtZNg54HJ+gKnFW3VXzAoYul6TpwLzKJr0Q
         +dL8ktCF+3ZU/f4pak3oi/vkZ4wR08X4qzV86XPlITiCyqePWIZUt8OPNY3/gLhtdzzE
         MJ2A==
X-Gm-Message-State: ACrzQf2jxbBaVTkZtEEr0MAVdLkxMckgO96L6VSF/DEItGR+4N5DGqRA
        fFXjiFQ/x/DWzYSBEbS+6qLiWHEvhG0BvA==
X-Google-Smtp-Source: AMsMyM5EZxIm5I78E82zxz17t4286cyiPhiDvln/3nxe232yVtviz8fJFmbeizfPydLYuZGsV6KzJg==
X-Received: by 2002:a05:6214:e4a:b0:4b1:d684:f72f with SMTP id o10-20020a0562140e4a00b004b1d684f72fmr43333469qvc.3.1666899798944;
        Thu, 27 Oct 2022 12:43:18 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id t40-20020a05622a182800b003995f6513b9sm1291368qtc.95.2022.10.27.12.43.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 12:43:17 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-36a4b86a0abso26649147b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:43:17 -0700 (PDT)
X-Received: by 2002:a81:11d0:0:b0:35b:dd9f:5358 with SMTP id
 199-20020a8111d0000000b0035bdd9f5358mr46239372ywr.401.1666899797074; Thu, 27
 Oct 2022 12:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221022114424.515572025@infradead.org> <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
 <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net> <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net> <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net> <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
 <Y1oub9MvqwGBlHkq@hirez.programming.kicks-ass.net> <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
 <Y1rdeFdYSBXOvTXz@hirez.programming.kicks-ass.net>
In-Reply-To: <Y1rdeFdYSBXOvTXz@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Oct 2022 12:43:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=win7Z=afpjQysvSsE8G8Vg-V5iN1P2F94e+E99USYo-Aw@mail.gmail.com>
Message-ID: <CAHk-=win7Z=afpjQysvSsE8G8Vg-V5iN1P2F94e+E99USYo-Aw@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>, John Hubbard <jhubbard@nvidia.com>,
        x86@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, ubizjak@gmail.com
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

On Thu, Oct 27, 2022 at 12:35 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Oct 27, 2022 at 11:13:55AM -0700, Linus Torvalds wrote:
>
> > But "fullmm" is probably even stronger than "mmap write-lock" in that
> > it should also mean "no other CPU can be actively using this" - either
> > for hardware page table walking, or for GUP.
>
> IIRC fullmm is really: this is the last user and we're taking the whole
> mm down -- IOW exit().

Yes.

But that doesn't mean that it's entirely "just ours" - vmscan can
still see the entries due to rmap, I think. So there can still be some
concurrency concerns, but it's limited.

> Do we worry about CPU errata where things go side-ways if multiple CPUs
> have inconsistent TLB state?

Yeah, we should definitely worry about those, since I think they have
been known to cause machine checks etc, which then crashes the machine
because the machine check architecture is broken garbage.

"User gets the odd memory ordering they asked for" is different from
"user can crash machine because of bad machine check architecture" ;)

That said, I don't think this is a real worry here. Because if I
recall the errata correctly, they are not about "different TLB
contents", but "different cacheability for the same physical page".

Because different TLB contents are normal and even expected, I think.
Things like kmap_local etc already end up doing some lazy TLB
flushing. No?

I think it's only "somebody did an UC access to a cacheline I have"
that ends up being bad.

Note the *WILD HANDWAVING* above - I didn't actually look up the
errata. The above is from my dim memories of the issues we had, and I
might just be wrong.

               Linus
