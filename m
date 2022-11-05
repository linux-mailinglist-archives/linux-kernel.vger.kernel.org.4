Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7332461DB94
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiKEPOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiKEPOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:14:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174821EEC0
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ekr6Ag+B1UJpoeicPPmJBxRvs9MjSDhSR1SM46lu9oA=; b=YUqkdhzPuj35LQ0nNTHFA1lrVd
        lxWzXxqhhIDwXpczLn5LEZceWYVlkhiZgdtoHk5rKZVZrN/d85dNKSe8YMVYdY9qUDiwXZr6bAj84
        6jm3QKVzj5fkHWEtwWFBNVabQAJGPKjC40kSlyQnkfhHju3GqZIEH4vbNPzHIpfZXbukY4bGbgmMt
        c9C4pthYgjx7fo8+YNitrMIdNGlkwO+yJKL2tYB2Mc39TD9uG0YaiTihVGb97wt31a8u1kj6pOYRe
        IA8f1u1tk+2EGvQC0ZCiwR7561IXwZHSVBWgrsf4B9SFrhsA6jPaLVNOwTHab/t8MjD849pDgbh1m
        za019YGQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1orKsM-008GWE-O3; Sat, 05 Nov 2022 15:14:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E03C930007E;
        Sat,  5 Nov 2022 16:14:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA99C209E95D6; Sat,  5 Nov 2022 16:14:19 +0100 (CET)
Date:   Sat, 5 Nov 2022 16:14:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de
Subject: Re: [PATCH 11/13] x86_64: Remove pointless set_64bit() usage
Message-ID: <Y2Z9yzmtYtmYi5rx@hirez.programming.kicks-ass.net>
References: <20221022111403.531902164@infradead.org>
 <20221022114425.168036718@infradead.org>
 <Y2QR/BRHjjYUNszh@dev-arch.thelio-3990X>
 <CAFULd4bkn3i0ds1ywhxAZBQH+1O-zbPWscUqjoEcv4xvnxOnSw@mail.gmail.com>
 <Y2QYHZsZNs33NXZB@dev-arch.thelio-3990X>
 <CAHk-=wjCBOwSWec+=h08q3Gbr4UjSfX46GrQjzHZLFokziS7nA@mail.gmail.com>
 <Y2U3WdU61FvYlpUh@hirez.programming.kicks-ass.net>
 <CAHk-=wggJFQJmWtvsFVt69hzRXW3zD5+9q-1Laz=NoZQ8Fy9Ag@mail.gmail.com>
 <Y2ZlS3SHeAPOkVmN@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2ZlS3SHeAPOkVmN@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 02:29:47PM +0100, Jason A. Donenfeld wrote:
> On Fri, Nov 04, 2022 at 10:15:08AM -0700, Linus Torvalds wrote:
> > On Fri, Nov 4, 2022 at 9:01 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > So cmpxchg_double() does a cmpxchg on a double long value and is
> > > currently supported by: i386, x86_64, arm64 and s390.
> > >
> > > On all those, except i386, two longs are u128.
> > >
> > > So how about we introduce u128 and cmpxchg128 -- then it directly
> > > mirrors the u64 and cmpxchg64 usage we already have. It then also
> > > naturally imposses the alignment thing.
> > 
> > Ack, except that we might have some "u128" users that do *not*
> > necessarily want any alignment thing.
> > 
> > But maybe we could at least start with an u128 type that is marked as
> > being fully aligned, and if some other user comes in down the line
> > that wants relaxed alignment we can call it "u128_unaligned" or
> > something.
> 
> Hm, sounds maybe not so nice for another use case: arithmetic code that
> makes use of u128 for efficient computations, but otherwise has
> no particular alignment requirements. For example, `typedef __uint128_t
> u128;` in:

Natural alignment is... natural. Making it unaligned is quite mad. That
whole u64 is not naturally aligned on i386 thing Linus referred to is a
sodding pain in the backside.

If the code has no alignment requirements, natural alignment is as good
as any. And if it does have requirements, you can use u128_unaligned.

Also:

$ ./align
16, 16

---

#include <stdio.h>

int main(int argx, char **argv)
{
	__int128 a;

	printf("%d, %d\n", sizeof(a), __alignof(a));
	return 0;
}
