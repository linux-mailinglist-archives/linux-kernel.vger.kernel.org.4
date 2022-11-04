Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9648B619E3E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiKDRPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiKDRPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:15:31 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D082731ED0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:15:27 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 8so3475800qka.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3HUn0bx/DAdGh10erDX6/ij0JMTkQvrZRJ0YE9oyOkg=;
        b=NRUvfFrDFHOS0DexelZeJzCweg+FOTiOHPh4mO/e5pN+PvA2OQBrv+Abt7svyOW3sY
         f2GMbHGcprDFQDdi6ml/VW3skdY1t8KuguOR6TfcMgi4Unm+Sw46QMJL/NVwXnPEYDS5
         5sHLJKU0WuCEL0dz78hapCmxnIaZgfpGnVlv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HUn0bx/DAdGh10erDX6/ij0JMTkQvrZRJ0YE9oyOkg=;
        b=lTVI4AqA5zKFHV03cJcjV28933DIkRE15ld7Jo3gfGbSMqnPLK9S5n4Tg14295QL12
         jbv3QQ1F3EcymGZ0d9ihvPr0jlhuOedSXuplw5HTu+mM5IQsOxKCV9O01EyKZ4jtb1eN
         jbiur/jkpg6va+rMEpOoBmBSMza2YHA+KmUmiWhEYR/nViWcEf54zZfGO/7icKrFaejT
         JDF+wiCQf7fX7FG9sxcRWpbKMIIsh3TP4LnQIjAqwYC81fGVmQT6nYzEvoKzJJWB0zwm
         3ig0c48vEM8ruzhTOct0L6wG318mNqLuHXgKcWhZZvCy/GYOebj2VWTdhagp+hUzyK7p
         GU1A==
X-Gm-Message-State: ACrzQf3pctqkzDeUISLPTtHsC5oi+rI1AsrBvKFNi1BqM7+3Zqf1K1PU
        Lh8pX3nyaU491SJOH9ckZ4NiD0k49PViOA==
X-Google-Smtp-Source: AMsMyM45ZuT4YBsmHxyzVQw+Y6YxuJm7HLQkWc/mH30YrIh/7eZsMhE4B+SNhWKK1mGIw0RVLsfUUw==
X-Received: by 2002:a37:b1c4:0:b0:6fa:996f:2279 with SMTP id a187-20020a37b1c4000000b006fa996f2279mr2013902qkf.607.1667582126499;
        Fri, 04 Nov 2022 10:15:26 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id i18-20020a05620a405200b006fa8299b4d5sm2878487qko.100.2022.11.04.10.15.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 10:15:25 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-3701a0681daso49576087b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:15:25 -0700 (PDT)
X-Received: by 2002:a81:114e:0:b0:36a:fc80:fa62 with SMTP id
 75-20020a81114e000000b0036afc80fa62mr36113103ywr.58.1667582124813; Fri, 04
 Nov 2022 10:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114425.168036718@infradead.org>
 <Y2QR/BRHjjYUNszh@dev-arch.thelio-3990X> <CAFULd4bkn3i0ds1ywhxAZBQH+1O-zbPWscUqjoEcv4xvnxOnSw@mail.gmail.com>
 <Y2QYHZsZNs33NXZB@dev-arch.thelio-3990X> <CAHk-=wjCBOwSWec+=h08q3Gbr4UjSfX46GrQjzHZLFokziS7nA@mail.gmail.com>
 <Y2U3WdU61FvYlpUh@hirez.programming.kicks-ass.net>
In-Reply-To: <Y2U3WdU61FvYlpUh@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Nov 2022 10:15:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wggJFQJmWtvsFVt69hzRXW3zD5+9q-1Laz=NoZQ8Fy9Ag@mail.gmail.com>
Message-ID: <CAHk-=wggJFQJmWtvsFVt69hzRXW3zD5+9q-1Laz=NoZQ8Fy9Ag@mail.gmail.com>
Subject: Re: [PATCH 11/13] x86_64: Remove pointless set_64bit() usage
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de
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

On Fri, Nov 4, 2022 at 9:01 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> So cmpxchg_double() does a cmpxchg on a double long value and is
> currently supported by: i386, x86_64, arm64 and s390.
>
> On all those, except i386, two longs are u128.
>
> So how about we introduce u128 and cmpxchg128 -- then it directly
> mirrors the u64 and cmpxchg64 usage we already have. It then also
> naturally imposses the alignment thing.

Ack, except that we might have some "u128" users that do *not*
necessarily want any alignment thing.

But maybe we could at least start with an u128 type that is marked as
being fully aligned, and if some other user comes in down the line
that wants relaxed alignment we can call it "u128_unaligned" or
something.

That would have avoided the pain we have on x86-32 where "u64" in a
UAPI structure is differently aligned than it is on actual 64-bit
architectures.

> Of those slub.c is the only one that cares about 32bit and would need
> some 'compat' code to pick between cmpxchg64 / cmpxchg128, but it
> already has everything wrapped in helpers so that shouldn't be too big
> of a worry.

Ack. Special case, and we can call it something very clear, and in
fact it would clean up the slab code too if we actually used some
explicit type for this.

Right now, slab does

        /* Double-word boundary */
        void *freelist;         /* first free object */
        union {
                unsigned long counters;
                struct {

where the alignment constraints are just a comment, and then it passes
pointers to the two words around manually.

But it should be fairly straightforward to make it use an actual
properly typed thing, and using an unnamed union member, do something
that takes an explicitly aligned "two word" thing instead.

IOW, make the 'compat' case *not* use those stupid two separate
pointers (that have to be consecutive and aligned), but actually do
something like

        struct cmpxchg_double_long {
                unsigned long a,b;
        } __aligned(2*sizeof(long));

and then the slab case can use that union of that and the existing
"freelist+word-union" to make this all not just a comment to people,
but something the compiler sees too.

            Linus
