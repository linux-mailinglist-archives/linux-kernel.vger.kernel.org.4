Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1FD61EE76
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiKGJOc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Nov 2022 04:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiKGJOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:14:30 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C672B3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:14:29 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-225-AnRwuhTfMWGD1U-3qJHg_A-1; Mon, 07 Nov 2022 09:14:26 +0000
X-MC-Unique: AnRwuhTfMWGD1U-3qJHg_A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 7 Nov
 2022 09:14:24 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Mon, 7 Nov 2022 09:14:24 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "jroedel@suse.de" <jroedel@suse.de>
Subject: RE: [PATCH 11/13] x86_64: Remove pointless set_64bit() usage
Thread-Topic: [PATCH 11/13] x86_64: Remove pointless set_64bit() usage
Thread-Index: AQHY8Slas2UAHB8/vU20d4zgnfqWVa4zL9Vw
Date:   Mon, 7 Nov 2022 09:14:24 +0000
Message-ID: <d5ed7c4dca774e1a858ac19f5fde291f@AcuMS.aculab.com>
References: <20221022111403.531902164@infradead.org>
 <20221022114425.168036718@infradead.org>
 <Y2QR/BRHjjYUNszh@dev-arch.thelio-3990X>
 <CAFULd4bkn3i0ds1ywhxAZBQH+1O-zbPWscUqjoEcv4xvnxOnSw@mail.gmail.com>
 <Y2QYHZsZNs33NXZB@dev-arch.thelio-3990X>
 <CAHk-=wjCBOwSWec+=h08q3Gbr4UjSfX46GrQjzHZLFokziS7nA@mail.gmail.com>
 <Y2U3WdU61FvYlpUh@hirez.programming.kicks-ass.net>
 <CAHk-=wggJFQJmWtvsFVt69hzRXW3zD5+9q-1Laz=NoZQ8Fy9Ag@mail.gmail.com>
 <Y2ZlS3SHeAPOkVmN@zx2c4.com>
 <Y2Z9yzmtYtmYi5rx@hirez.programming.kicks-ass.net>
In-Reply-To: <Y2Z9yzmtYtmYi5rx@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 05 November 2022 15:14
> 
> On Sat, Nov 05, 2022 at 02:29:47PM +0100, Jason A. Donenfeld wrote:
> > On Fri, Nov 04, 2022 at 10:15:08AM -0700, Linus Torvalds wrote:
> > > On Fri, Nov 4, 2022 at 9:01 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > So cmpxchg_double() does a cmpxchg on a double long value and is
> > > > currently supported by: i386, x86_64, arm64 and s390.
> > > >
> > > > On all those, except i386, two longs are u128.
> > > >
> > > > So how about we introduce u128 and cmpxchg128 -- then it directly
> > > > mirrors the u64 and cmpxchg64 usage we already have. It then also
> > > > naturally imposses the alignment thing.
> > >
> > > Ack, except that we might have some "u128" users that do *not*
> > > necessarily want any alignment thing.
> > >
> > > But maybe we could at least start with an u128 type that is marked as
> > > being fully aligned, and if some other user comes in down the line
> > > that wants relaxed alignment we can call it "u128_unaligned" or
> > > something.
> >
> > Hm, sounds maybe not so nice for another use case: arithmetic code that
> > makes use of u128 for efficient computations, but otherwise has
> > no particular alignment requirements. For example, `typedef __uint128_t
> > u128;` in:
> 
> Natural alignment is... natural. Making it unaligned is quite mad. That
> whole u64 is not naturally aligned on i386 thing Linus referred to is a
> sodding pain in the backside.
> 
> If the code has no alignment requirements, natural alignment is as good
> as any. And if it does have requirements, you can use u128_unaligned.
> 
> Also:
> 
> $ ./align
> 16, 16
> 
> ---
> 
> #include <stdio.h>
> 
> int main(int argx, char **argv)
> {
> 	__int128 a;
> 
> 	printf("%d, %d\n", sizeof(a), __alignof(a));
> 	return 0;
> }

Well, __alignof() doesn't return the required value.
(cf 'long long' on 32bit x86).
But the alignment of __int128 is 16 :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

