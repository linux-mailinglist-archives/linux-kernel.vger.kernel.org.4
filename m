Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AF76256F2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiKKJhR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Nov 2022 04:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbiKKJhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:37:14 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288FC6EB4E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:37:11 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-97-8TJG0fauNZW-nVbR3oMe2A-1; Fri, 11 Nov 2022 09:37:09 +0000
X-MC-Unique: 8TJG0fauNZW-nVbR3oMe2A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 11 Nov
 2022 09:37:08 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Fri, 11 Nov 2022 09:37:08 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthew Wilcox' <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
CC:     Theodore Ts'o <tytso@mit.edu>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "cl@linux.com" <cl@linux.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "rkovhaev@gmail.com" <rkovhaev@gmail.com>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        Feng Tang <feng.tang@intel.com>
Subject: RE: Deprecating and removing SLOB
Thread-Topic: Deprecating and removing SLOB
Thread-Index: AQHY9SBUoMjUW3vwt0m3f4uC9hH+/a45b0ow
Date:   Fri, 11 Nov 2022 09:37:07 +0000
Message-ID: <b6d691573f544a4ea44338430edb6911@AcuMS.aculab.com>
References: <K5M3LR.3O50LSSSY5L3@crapouillou.net>
 <CAHk-=wjBqwJk9RgfoBuM00T49M7uQiLnOvLST7L6v5rhS7fkDA@mail.gmail.com>
 <20221109234832.GE307514@darkstar.musicnaut.iki.fi>
 <Y2yArTbOpKd6ASkd@mit.edu> <e610b6fa-aa71-d612-0eb2-03ba6c4a6b46@suse.cz>
 <Y20ktNwgPqUbOwxH@casper.infradead.org>
In-Reply-To: <Y20ktNwgPqUbOwxH@casper.infradead.org>
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

From: Matthew Wilcox
> Sent: 10 November 2022 16:20
> 
> On Thu, Nov 10, 2022 at 08:31:31AM +0100, Vlastimil Babka wrote:
> > >     octeon-hcd will crash the kernel when SLOB is used. This usually happens
> > >     after the 18-byte control transfer when a device descriptor is read.
> > >     The DMA engine is always transfering full 32-bit words and if the
> > >     transfer is shorter, some random garbage appears after the buffer.
> > >     The problem is not visible with SLUB since it rounds up the allocations
> > >     to word boundary, and the extra bytes will go undetected.
> >
> > Ah, actually it wouldn't *now* as SLUB would make the allocation fall into
> > kmalloc-32 cache and only add redzone beyond 32 bytes. But with upcoming
> > changes by Feng Tang, this should work.
> 
> This is kind of "if a bug stings a tree in a forest, does it hurt"
> problem.  If all allocations of 18 bytes are rounded up to 20 or more
> bytes, then it doesn't matter that the device has this bug.  Sure, it
> may end up hurting in the future if we decide to create 18-byte slab
> caches, but it's not actually going to affect anything today (and we
> seem to be moving towards less precision in order to get more
> performance)

Yes, even on dma-coherent systems allocated blocks have to be
moderately aligned - so the space after an 18 byte block can't be used.
I also doubt there is any benefit (and many bugs) from allowing
2 bytes alignment on m68k.
So the 'overwrite to a whole number of words' maybe reasonably expected
to not cause any real bugs.

x86 (even 32bit) probably requires 16 byte alignment (for some corner
cases) - ok for a power-of-2 allocator that doesn't add a header.
(Although 1, 2, 4 and 8 byte allocates are valid.)

To reduce memory wastage what you really don't want is an allocator
that adds a header/trailer and then rounds up to a power of 2.
Coders write in binary and do kmalloc(256) not kmalloc(200) and
rounding 256 up to 512 is rather wasteful.
(Search for the kmalloc(PAGE_SIZE+1) :-)

I also think that one of the allocators only cuts pages into
power-of-2 sizes.
It is probably sensible to return cache-aligned (probably 64 byte)
buffers for requests larger than a cache line.
But a 4k page can be split into 21 192-byte buffers.
As well as using less memory for allocates between 129 and 192 bytes
it may reduce pressure on the d-cache by evening out cache line usage.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

