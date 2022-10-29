Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D79261252F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 22:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJ2UPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 16:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiJ2UPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 16:15:46 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1614846D8A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 13:15:45 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id c8so6179738qvn.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 13:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pOXPiJ97dYIJF5yPIrXfj+CbshJ1dELixNePC6rvELQ=;
        b=QuhkfR4DG5JSax+cs/4Iz+A4JTkwrDL98mjgZZJwGTBrfhi8q29mGRVGWLSgAqOeDQ
         EZpgJqrD8KkrGhk77/r92K0hKjO8mLLMSpXTzkSFFrWhdMeDHM4davim/T5Pq8x0MRQ5
         qoUEkHYof5agkUHAe5RZ1J/IBHxNXICf8IzeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOXPiJ97dYIJF5yPIrXfj+CbshJ1dELixNePC6rvELQ=;
        b=SczXvT/EpFzANy1RbqVPK38U5Rabw+9ETfwviXTDwkpZlePzbRkiDpCXI+1FDwbGBo
         HVn1thfQAgksxCvPyYDU0E7LnfoTqGquT4THMjRlZASGFp8qKaJaPU1a+viqDZGz7CZj
         fyQKDj2gKU1LPcBOlWSQiou+OMXvdZFG+NWk80uX6jmyGSPoRsv4un6gZCKPBHVrpFki
         /xxYPErz/lyyvdEl5L67EPo/h/ze7FE9unEXGtZBG6DP74/YHv4lSe5Beo3jK6CfPIv+
         lvXawwqbAoFDswXBVr7/BnIWawrtsxCCSmCW1jxprkfm+1QgpwInw5pgmAGFtN/T39Oq
         qj7A==
X-Gm-Message-State: ACrzQf03rpJci0RgnmWO/D9OZedIfsCAGNs7fa8xvdPQpt/xOPudYdNe
        EKk6/i0PrWSmmqXufK7k/x7+2QnQkkqScA==
X-Google-Smtp-Source: AMsMyM6xKgQ3aHf4kOcsKONZGoaBoWmXIu1n6/ObNdkMT4mYn2tsmOdxCLiuqtVHC84+wEXhWRdAGw==
X-Received: by 2002:a05:6214:2505:b0:4bb:8927:872e with SMTP id gf5-20020a056214250500b004bb8927872emr4853075qvb.93.1667074543880;
        Sat, 29 Oct 2022 13:15:43 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id r16-20020ac87ef0000000b0039cc7ebf46bsm1233518qtc.93.2022.10.29.13.15.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 13:15:43 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-3704852322fso5508177b3.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 13:15:43 -0700 (PDT)
X-Received: by 2002:a81:114e:0:b0:36a:fc80:fa62 with SMTP id
 75-20020a81114e000000b0036afc80fa62mr5636780ywr.58.1667074542712; Sat, 29 Oct
 2022 13:15:42 -0700 (PDT)
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
 <3a57cfc5-5db4-bdc9-1ddf-5305a37ffa62@nvidia.com>
In-Reply-To: <3a57cfc5-5db4-bdc9-1ddf-5305a37ffa62@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 29 Oct 2022 13:15:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6EJvTtTeYQvkX3aOw6Q1SRYRV6xJP1+uHNvfAocO1hw@mail.gmail.com>
Message-ID: <CAHk-=wj6EJvTtTeYQvkX3aOw6Q1SRYRV6xJP1+uHNvfAocO1hw@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 12:39 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> ext4 has since papered over the problem, by soldiering on if it finds a
> page without writeback buffers when it expected to be able to writeback
> a dirty page. But you get the idea.

I suspect that "soldiering on" is the right thing to do, but yes, our
'mkdirty' vs 'mkclean' thing has always been problematic.

I think we always needed a page lock for it, but PG_lock itself
doesn't work (as mentioned earlier) because the VM can't serialize
with IO, and needs the lock to basically be a spinlock.

The page table lock kind of took its place, and then the rmap removal
makes for problems (since it is what basically ends up being the
shared place to look it upo).

I can think of three options:

 (a) filesystems just deal with it

 (b) we could move the "page_remove_rmap()" into the "flush-and-free" path too

 (c) we could actually add a spinlock (hashed on the page?) for this

I think (a) is basically our current expectation.

And (b) would be fairly easy - same model as that dirty bit patch,
just a 'do page_remove_rmap too' - except page_remove_rmap() wants the
vma as well (and we delay the TLB flush over multiple vma's, so it's
not just a "save vma in mmu_gather").

Doing (c) doesn't look hard, except for the "new lock" thing, which is
always a potential huge disaster. If it's only across set_page_dirty()
and page_mkclean(), though, and uses some simple page-based hash, it
sounds fairly benign.

                  Linus



              Linus
