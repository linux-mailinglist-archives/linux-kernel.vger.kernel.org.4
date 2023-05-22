Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD6070CD7A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbjEVWFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbjEVWFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:05:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656E4FE
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 15:05:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684793109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wpJPjBbO36YZsQB1wleZ2Bxu2UdyRVdF2s/GAkF1LgA=;
        b=f5uM/5MIW0ZkXJ9BPDjgcMNARkDHM2QetrKjkOB1cVAqL7vbg19E6CkXwdoHwQHtTnmHuf
        or3nmZ8kdIbB9QKEqw5QhRqrNdvP1ToeDz/z25//8J4uppaLJf0Lh8q8Li9RLRTvOXKhHV
        8Punl3e6gqtDEAQQlzbGvGV5iptxcJtzq2wO5AqA0FZiqdov0RL51r1XTAFqPbEwOwJYKN
        3cavbhBQJP8AxMSA9umnVFXipxHSFpITBZgPOUXTfOwG4hyz7o+UXXKM5rzt6Q79mYtVOO
        AfSsGOGmmxcy5uEtOma5DHqP5wmaQMwFQtin5g4wPd18/yyfkBFC6JaM6q15ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684793109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wpJPjBbO36YZsQB1wleZ2Bxu2UdyRVdF2s/GAkF1LgA=;
        b=oqtmX16LwEasfr+qYEpMoInQ/KL5S5cOZa9a7pH56YdtXnXfrgw5DUgsCI/DNjnyTm+6di
        xkLcVzBgYHGZRaDQ==
To:     Song Liu <song@kernel.org>, Mike Rapoport <rppt@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
In-Reply-To: <CAPhsuW6xsHupB2EGGrgEdd+13ORSvPAymRgnrAfxG2U0Jfo4vQ@mail.gmail.com>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
 <ZGWdHC3Jo7tFUC59@moria.home.lan> <20230518152354.GD4967@kernel.org>
 <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com>
 <ZGZW0v3nRShO7r+Z@moria.home.lan>
 <CAPhsuW5BbbxinaH2aO=2Wa0aSQ3pkNwvnrgJv7fG4QcPr_j7+Q@mail.gmail.com>
 <ZGZfLHA8vuRJwa0f@moria.home.lan> <20230519082945.GE4967@kernel.org>
 <CAPhsuW6xsHupB2EGGrgEdd+13ORSvPAymRgnrAfxG2U0Jfo4vQ@mail.gmail.com>
Date:   Tue, 23 May 2023 00:05:08 +0200
Message-ID: <878rdgvx7v.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19 2023 at 08:42, Song Liu wrote:
> On Fri, May 19, 2023 at 1:30=E2=80=AFAM Mike Rapoport <rppt@kernel.org> w=
rote:
>> What I was thinking is that we can replace module_alloc() calls in your
>> allocator with something based on my unmapped_alloc(). If we make the pa=
rt
>> that refills the cache also take care of creating the mapping in the
>> module address space, that should cover everything.
>
> Here are what I found as I work more on the code:
>
> 1. It takes quite some work to create a clean interface and make sure
>     all the users of module_alloc can use the new allocator on all archs.
>     (archs with text poke need to work with ROX memory from the
>     allocator; archs without text poke need to have a clean fall back
>     mechanism, etc.). Most of this work is independent of the actual
>     allocator, so we can do this part and plug in whatever allocator we
>     want (buddy+slab or vmap-based or any other solutions).
>
> 2. vmap_area based solution will work. And it will be one solution for
>     both < PAGE_SIZE and > PAGE_SIZE allocations. Given
>     module_alloc is not in any hot path (AFAIK), I don't see any
>     practical issues with this solution. It will be a little tricky to pl=
ace
>     and name the code, as it uses vmalloc logic, but it is technically a
>     module allocator.
>
> I will prioritize building the interface, and migrating users to it. If we
> do this part right, changing the underlying allocator should be
> straightforward.

Correct, that's the only workable approach.

Once you have solved #1 the mechanism of the underlying allocator (#2)
is pretty much exchangeable.

Any attempt to solve #2 before #1 is doomed by definition.

Thanks,

        tglx
