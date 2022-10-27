Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4952F6102B6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbiJ0Ubp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbiJ0Ubl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:31:41 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CED7646A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:31:40 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id ml12so2535732qvb.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=40/NzUhqBfpBB930IrYklEEa68Z0CgmOyOOoo4pZLBo=;
        b=f3ObglpSHvlAmkyYbSNMXkn3I28foU8FiO9qbDYRaBj2NoxEHo/iigszE2yQs0TSKW
         Evu731JN6+9voVpQZrxahvnki+UtO9PruUqprG4YisNFTi9d2MFS5AWdI4374Pg51fP3
         ABAe6o3LkroGX/O2nx+pllOZLvY2b8mEFq11g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40/NzUhqBfpBB930IrYklEEa68Z0CgmOyOOoo4pZLBo=;
        b=edVe8N1OKgCic0abfQwyOdKMzbuCO5nKqbDgGzDwsKZnbz3mdvy5V4UqrpGJpVOuSP
         UxrCNKs0Jp2bENelXTPUuIMRW/5/ocpcRqf5ljzsq+gMQTNst5/4tM/7MGGzwO9b5OKq
         ZMyko+WxymS77X3sBrANgQRKOuUbAB/iaTGVaTiBdrMbKGgZmiO9iYskCnQYPbJ6/d0B
         vLTLqF/M/hzHdap4zc0FO8Hgp4PT/Y+ZdlkiJIJLK6SykO/O2c/CZL8XAwGAC6Tzvsud
         Wg8XWiu7jvegDVISvIsPOWjvhQYwP8Gg9aT/DfFexL1HMgKgcGK3GSW0ewVIpEeuKDRC
         t0yg==
X-Gm-Message-State: ACrzQf1E0rgdSoiVE/IoDBpeGP6Q96TTy2cByI5PG91Cz2ZfVxfe43OF
        ZwqAWm2iZRbtNQW41hE3QxGIK+aDl9knEQ==
X-Google-Smtp-Source: AMsMyM52L4uQkjpJD40JWlqupuRQawlf9kUckg7hcQRbIFA/ACzc1FIQoA/wzT1xZRIeo8X+9EmnGw==
X-Received: by 2002:a05:6214:1c81:b0:4af:664c:2913 with SMTP id ib1-20020a0562141c8100b004af664c2913mr43247990qvb.103.1666902699260;
        Thu, 27 Oct 2022 13:31:39 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a29ca00b006eea4b5abcesm1602044qkp.89.2022.10.27.13.31.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 13:31:38 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-333a4a5d495so27876477b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:31:38 -0700 (PDT)
X-Received: by 2002:a81:555:0:b0:36b:2d71:5861 with SMTP id
 82-20020a810555000000b0036b2d715861mr27546294ywf.340.1666902698189; Thu, 27
 Oct 2022 13:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com> <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net> <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net> <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
 <Y1oub9MvqwGBlHkq@hirez.programming.kicks-ass.net> <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
 <6C548A9A-3AF3-4EC1-B1E5-47A7FFBEB761@gmail.com>
In-Reply-To: <6C548A9A-3AF3-4EC1-B1E5-47A7FFBEB761@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Oct 2022 13:31:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh8oi0qQtYDFTfm7d1s5C8mG7ig=NfzGWt4zbjXMzcdqQ@mail.gmail.com>
Message-ID: <CAHk-=wh8oi0qQtYDFTfm7d1s5C8mG7ig=NfzGWt4zbjXMzcdqQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, x86@kernel.org,
        willy@infradead.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
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

On Thu, Oct 27, 2022 at 1:15 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> I think it might be easier to come up with new rules instead of phrasing the
> existing ones.

I'm ok with that, but I think you are missing a very important issue:
all the cases where we can short-circuit TLB invalidations *entirely*.

You don't mention those at all.

Those optimizations are *very* important. Process exit is one of the
most performance-critical pieces of code in the kernel on some loads,
because a lot of traditional unix loads have a *ton* of small
fork/exec/exit sequences, and the whole "do just one TLB flush" was at
least historically quite a big deal.

So one very big issue here is when zap_page_tables() can end up
skipping TLB flushes entirely, because nobody cares.

And no, the fix is not to turn it into some "just increment a
generation number".

We want to avoid *even that* cost for the whole "we don't actually
need a TLB flush at all, until we actually free the pages".

So there are two levels of tlb flush optimizations

 (a) avoiding them entirely in the first place

 (b) the whole "once you have to flush, keep track of lazy modes and
TLB generations, and flush ranges"

And honestly, I think you ignored (a), and that's where we do exactly
those kinds of "this case doesn't need to flush AT ALL" things.

So when you say

>       The thing I like about this scheme
> the most is that it avoids relying on almost all the OS data-structures
> (e.g., PageAnon()), making it much easier to grasp.

I think it's because you've ignored a big part of the whole issue.

               Linus
