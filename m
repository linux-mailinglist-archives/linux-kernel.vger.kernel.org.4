Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D71610000
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbiJ0SOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbiJ0SOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:14:19 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4BB6BD52
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:14:14 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id h10so2102000qvq.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c9TtS5EyPfrJtXKFUijRKZY8i/FB2qm2pzEph6K2Voc=;
        b=OGWIzf//yDrzpIU5CUpEyJ7Dm5rnyRzXTwtOsRe4hwmqHu+knWWFjSY5Bsl8zdN2JR
         AbhywM5MxQHd0TDQb+wMPn9yzk03EzWqxeNIV3iaekqGTUDPJgEKXXQd5WJ0UVzk037R
         SPcYzev0TYZ8UCj2B/vUiwWZh4URP/tTZ7s+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9TtS5EyPfrJtXKFUijRKZY8i/FB2qm2pzEph6K2Voc=;
        b=3uU94nNKABbQYpds2HIMBuoDkjBfMZ2AT8E8HctlI2OCEbXbqGoKKrqWollWzjsxm8
         LYs8kj2AgCP9HboEHtLTZeR7a7hBJ39uHXtnDz2aVA9RqmAwmpzEz06jjxW+uFrGjgWE
         2J2BDC2XUoNKgB+PgwYC/YQnXpn1oXepa43QvjbJopRnOgoPO4z1Fm5dfXBwOjcq6EIe
         PgxNyQzur1BnO9ED4Ixb7qDBM4lW3VHbeLK+UHRtgq9n6V/6ijnJTBc0O/Na6llE0Jkv
         eDE0hGVjkH+xClHN4UpGMe834trrWqzBnDUq18I4al2jVXlAQMglJ5bg/9P3kQm7iHC7
         TjkA==
X-Gm-Message-State: ACrzQf3ZRqrPuMmNkRPzRH7IkWyQtHPzH0ZaeUr+vhidqnXTfveht7Ay
        pdrsaPpceDZGoceT8auPNqUjpYGp+5GJ8A==
X-Google-Smtp-Source: AMsMyM4dcADglt6lTaRVmHmJuQwxNXcB6MLJcainOGSTDWo6e3r3Snqwh/z0kZ4HUyOFb4MO78ZYMQ==
X-Received: by 2002:a05:6214:1d02:b0:4b7:6a28:3e85 with SMTP id e2-20020a0562141d0200b004b76a283e85mr34793041qvd.88.1666894453319;
        Thu, 27 Oct 2022 11:14:13 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id ff12-20020a05622a4d8c00b0039cb5c9dbacsm1230641qtb.22.2022.10.27.11.14.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 11:14:12 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id m125so3186348ybb.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:14:12 -0700 (PDT)
X-Received: by 2002:a5b:984:0:b0:6ca:9345:b2ee with SMTP id
 c4-20020a5b0984000000b006ca9345b2eemr8216571ybq.362.1666894452121; Thu, 27
 Oct 2022 11:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com> <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net> <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net> <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
 <Y1oub9MvqwGBlHkq@hirez.programming.kicks-ass.net>
In-Reply-To: <Y1oub9MvqwGBlHkq@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Oct 2022 11:13:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
Message-ID: <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
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

On Thu, Oct 27, 2022 at 12:08 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> So I thought the general rule was that if you modify a PTE and have not
> unmapped things -- IOW, there's actual concurrency possible on the
> thing, then the TLB invalidate needs to happen under pte_lock, since
> that is what controls concurrency at the pte level.

Yeah, I think we should really think about the TLB issue and make the
rules very clear.

A lot of our thinking behind "fix TLB races" have been about
"use-after-free wrt TLB on another CPU", and the design in
zap_page_ranges() is almost entirely about that: making sure that the
TLB flush happens before the underlying pages are free'd.

I say "almost entirely", because you can see the effects of the
*other* kind of race in

                        if (!PageAnon(page)) {
                                if (pte_dirty(ptent)) {
                                        force_flush = 1;
                                        set_page_dirty(page);
                                }

where it isn't about the lifetime of the page, but about the state
coherency wrt other users.

But I think even that code is quite questionable, and we really should
write down the rules much more strictly somewhere.

For example, wrt that pte_dirty() causing force_flush, I'd love to
have some core set of rules that would explain

 (a) why it is only relevant for shared pages

 (b) do even shared pages need it for the "fullmm" case when we tear
down the whole VM?

 (c) what are the force_flush interactions wrt holding the mmap lock
for writing vs reading?

In the above, I think (b)/(c) are related - I suspect "fullmm" is
mostly equivalent to "mmap held for writing", in that it guarantees
that there should be no concurrent faults or other active sw ops on
the table.

But "fullmm" is probably even stronger than "mmap write-lock" in that
it should also mean "no other CPU can be actively using this" - either
for hardware page table walking, or for GUP.

Both both have the vmscan code and rmap that can still get to the
pages - and the vmscan code clearly only cares about the page table
lock. But the vmscan code itself also shouldn't care about some stale
TLB value, so ...

> As it stands MADV_DONTNEED seems to blatatly violate that general rule.

So let's talk about exactly what and why the TLB would need to be
flushed before dropping the page table lock.

For example, MADV_DONTNEED does this all with just the mmap lock held
for reading, so we *unless* we have that 'force_flush', we can

 (a) have another CPU continue to use the old stale TLB entry for quite a while

 (b) yet another CPU (that didn't have a TLB entry, or wanted to write
to a read-only one ) could take a page fault, and install a *new* PTE
entry in the same slot, all at the same time.

Now, that's clearly *very* confusing. But being confusing may not mean
"wrong" - we're still delaying the free of the old entry, so there's
no use-after-free.

The biggest problem I can see is that this means that user space
memory ordering might be screwed up: the CPU in (a) will see not just
an old TLB entry, but simply old *data*, when the CPU in (b) may be
writing to that same address with new data.

So I think we clearly do *NOT* serialize as much as we could for
MADV_DONTNEED, and I think the above is a real semantic result of
that.

But equally arguably if you do this kind of unserialized MADV_DONTNEED
in user space, that's a case of "you asked for the breakage - you get
to keep both pieces".

So is that ever an actual problem? If the worst issue is that some
CPU's may see old ("pre-DONTNEED") data, while other CPU's then see
new data while the MADV_DONTNEED is executing, I think maybe *THAT*
part is fine.

But because it's so very confusing, maybe we have other problems in
this area, which is why I think it would be really good to have an
actual set of real hard documented rules about this all, and exactly
when we need to flush TLBs synchronously with the page table lock, and
when we do not.

Anybody willing to try to write up the rules (and have each rule
document *why* it's a rule - not just "by fiat", but an actual "these
are the rules and this is *why* they are the rules").

Because right now I think all of our rules are almost entirely just
encoded in the code, with a couple of comments, and a few people who
just remember why we do what we do.

                   Linus
