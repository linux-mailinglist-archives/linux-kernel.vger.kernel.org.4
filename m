Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1300760BD1A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiJXWHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiJXWH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:07:26 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBEE857FF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:20:43 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id c8so6518924qvn.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=91T5Fm7XnNKkoCT04MlZt8PlvkehhJwmM3iCe4VSqZ0=;
        b=Z9EeVyBXNd9oUt/ydVxYIH3o38pxdMklbwkGV3LphkIsAwNPQJzioPy3DaRn0rGhQS
         5EC/Dkdzr01glyKtRiGRMcMFUbDMBjL8eclmj0LTgBEgatwemSsYk+8YMsBS+gH4sggw
         d21ZWPaAQBrNoqlvhKiAZug3pAo8fhsTAqsHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91T5Fm7XnNKkoCT04MlZt8PlvkehhJwmM3iCe4VSqZ0=;
        b=0n2fGJB2JZevt7YNeHG0SqBDxP13cKNdZAkEoy7hm4uVAjNy7GLaOQRuEyL0U5+C5i
         Y9q9I308pmYnb8BTd8rrt316HeOuLMo4WDQVVMM9rnZ0jmzONFWTj/aQLK9Z0BV0Tu5j
         hH0lwO3TEPnJZ/1hbcArA14Xw7ZwX6E3kWgKjOdfeJv5DAxM8amlHpz3mcYdEWKLAbdg
         UEPgt19CZ70mgdtRv9rYkQ4YaYiUWOdCwoZewP1cdtfOhaHbouJpOENutrfXBOBnBXfj
         MUuDv+mNmMoZCVHXow9QpSi4eTA0puUGQEl7jCCzXdb47NBWGxUTx/ApFAtFWDDyL/HO
         4MtA==
X-Gm-Message-State: ACrzQf1NePnC757TbkfayOxY9vltkdDZ7xB44cOkRA5IDvC0eLa1fACB
        xrpi4MSiFaNlLuEaxH2dvKlFYHTZBS5hVA==
X-Google-Smtp-Source: AMsMyM537NiO4jwx6C+H1w5pkik3hzpPRGKwNAjgc5lLxuI3lVEprUFSSpfn9/cY4HSr4xgvML7kmQ==
X-Received: by 2002:a0c:a79a:0:b0:4b1:ca99:177 with SMTP id v26-20020a0ca79a000000b004b1ca990177mr28986832qva.34.1666642781059;
        Mon, 24 Oct 2022 13:19:41 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id x11-20020a05620a258b00b006ceb933a9fesm611217qko.81.2022.10.24.13.19.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 13:19:39 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-36847dfc5ccso96268657b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:19:39 -0700 (PDT)
X-Received: by 2002:a81:114e:0:b0:36a:fc80:fa62 with SMTP id
 75-20020a81114e000000b0036afc80fa62mr12975148ywr.58.1666642779066; Mon, 24
 Oct 2022 13:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com> <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
In-Reply-To: <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 13:19:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjoGnHVVp5pcb69C6HtnJ_avqQo_b5NK-X9bgoDDw_XbA@mail.gmail.com>
Message-ID: <CAHk-=wjoGnHVVp5pcb69C6HtnJ_avqQo_b5NK-X9bgoDDw_XbA@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
To:     Jann Horn <jannh@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>, x86@kernel.org,
        willy@infradead.org, akpm@linux-foundation.org,
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

On Mon, Oct 24, 2022 at 12:58 PM Jann Horn <jannh@google.com> wrote:
>
> Unless I'm completely misunderstanding what's going on here, the whole
> "remove_table" thing only happens when you "remove a table", meaning
> you free an entire *pagetable*. Just zapping PTEs doesn't trigger that
> logic.

I do have to admit that I'd be happier if this code - and the GUP code
that also relies on "interrupts off" behavior - would just use a
sequence counter instead.

Relying on blocking IPI's is clever, but also clearly very subtle and
somewhat dangerous.

I think our GUP code is a *lot* more important than some "legacy
x86-32 has problems in case you have an incredibly unlikely race that
re-populates the page table with a different page that just happens to
be exactly the same MOD-4GB", so honestly, I don't think the
load-tearing is even worth worrying about - if you have hardware that
is good enough at virtualizing things, it's almost certainly already
64-bit, and running 32-bit virtual machines with PAE you really only
have yourself to blame.

So I can't find it in myself to care about the 32-bit tearing thing,
but this discussion makes me worried about Fast GUP.

Note that even with proper atomic

                pte_t pte = ptep_get_lockless(ptep);

in gup_pte_range(), and even if the page tables are RCU-free'd, that
just means that the 'ptep' access itself is safe.

But then you have the whole "the lookup of the page pointer is not
atomic" wrt that. And right now that GUP code does rely on the "block
IPI" to make it basically valid.

I don't think it matters if GUP races with munmap or madvise() or
something like that - if you get the old page, that's still a valid
page, and the user only has himself to blame.

But if we have memory pressure that causes vmscan to push out a page,
and it gets replaced with a new page, and GUP gets the old page with
no serialization, that sounds like a possible source of data
inconsistency.

I don't know if this can happen, but the whole "interrupts disabled
doesn't actually block IPI's and synchronize with TLB flushes" really
sounds like it would affect GUP too. And be much more serious there
than on some x86-32 platform that nobody should be using anyway.

               Linus
