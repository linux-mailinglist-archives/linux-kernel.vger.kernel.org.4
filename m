Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C247C61DA99
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 14:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiKENaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 09:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKEN36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 09:29:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C537DFFF
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 06:29:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDBA8B82D6B
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 13:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B8FC433D6;
        Sat,  5 Nov 2022 13:29:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hjcmsaqx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667654991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R8ndFeWwtbidwmu8ZqWvQNw9vpteG/tvbT1CnALU5sI=;
        b=hjcmsaqxZPJdNb/SShsGMITrrANeiPj7TEDeov/h5qjjSx35qyF/bbDL+rKwFHLBcZXap/
        x5QfUFasXInh1eguji7rbPDV99dvXawiiWB9WQp3JE4dXklrhu+cF23SckzuMZZi6yuzPm
        RAabW9uqEENLVS2JPtg0zCTbsamtm7E=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 091ecb54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 5 Nov 2022 13:29:50 +0000 (UTC)
Date:   Sat, 5 Nov 2022 14:29:47 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de
Subject: Re: [PATCH 11/13] x86_64: Remove pointless set_64bit() usage
Message-ID: <Y2ZlS3SHeAPOkVmN@zx2c4.com>
References: <20221022111403.531902164@infradead.org>
 <20221022114425.168036718@infradead.org>
 <Y2QR/BRHjjYUNszh@dev-arch.thelio-3990X>
 <CAFULd4bkn3i0ds1ywhxAZBQH+1O-zbPWscUqjoEcv4xvnxOnSw@mail.gmail.com>
 <Y2QYHZsZNs33NXZB@dev-arch.thelio-3990X>
 <CAHk-=wjCBOwSWec+=h08q3Gbr4UjSfX46GrQjzHZLFokziS7nA@mail.gmail.com>
 <Y2U3WdU61FvYlpUh@hirez.programming.kicks-ass.net>
 <CAHk-=wggJFQJmWtvsFVt69hzRXW3zD5+9q-1Laz=NoZQ8Fy9Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wggJFQJmWtvsFVt69hzRXW3zD5+9q-1Laz=NoZQ8Fy9Ag@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 10:15:08AM -0700, Linus Torvalds wrote:
> On Fri, Nov 4, 2022 at 9:01 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > So cmpxchg_double() does a cmpxchg on a double long value and is
> > currently supported by: i386, x86_64, arm64 and s390.
> >
> > On all those, except i386, two longs are u128.
> >
> > So how about we introduce u128 and cmpxchg128 -- then it directly
> > mirrors the u64 and cmpxchg64 usage we already have. It then also
> > naturally imposses the alignment thing.
> 
> Ack, except that we might have some "u128" users that do *not*
> necessarily want any alignment thing.
> 
> But maybe we could at least start with an u128 type that is marked as
> being fully aligned, and if some other user comes in down the line
> that wants relaxed alignment we can call it "u128_unaligned" or
> something.

Hm, sounds maybe not so nice for another use case: arithmetic code that
makes use of u128 for efficient computations, but otherwise has
no particular alignment requirements. For example, `typedef __uint128_t
u128;` in:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/crypto/poly1305-donna64.c
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/crypto/curve25519-hacl64.c

I always thought it'd be nice to see that typedef alongside the others
in the shared kernel headers, but figured the requirement for 64-bit and
libgcc for some operations on some architectures made it a bit less
general purpose, so I never proposed it.

Jason
