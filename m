Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E01D72AF72
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 00:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjFJWSv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 10 Jun 2023 18:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjFJWSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 18:18:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A66B35A9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 15:18:42 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-130-z7zOhKmQOuS4sGCuOuqKdg-1; Sat, 10 Jun 2023 23:18:39 +0100
X-MC-Unique: z7zOhKmQOuS4sGCuOuqKdg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 10 Jun
 2023 23:18:34 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 10 Jun 2023 23:18:34 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Lorenzo Stoakes' <lstoakes@gmail.com>
CC:     Lu Hongfei <luhongfei@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "open list:VMALLOC" <linux-mm@kvack.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: RE: [PATCH] mm/vmalloc: Replace the ternary conditional operator with
 min()
Thread-Topic: [PATCH] mm/vmalloc: Replace the ternary conditional operator
 with min()
Thread-Index: AQHZmq9RsZ2mMErDwEmVNd3QmnYBSK+Ed3ZwgAABSICAAB600A==
Date:   Sat, 10 Jun 2023 22:18:34 +0000
Message-ID: <3e35b679f17a434b9da2ceffba086bfa@AcuMS.aculab.com>
References: <20230609061309.42453-1-luhongfei@vivo.com>
 <832d7c69-ffd5-4764-8ffe-3a02bef0efb0@lucifer.local>
 <3fc87d60-4e81-4f49-95f0-0503ad5cdf35@lucifer.local>
 <f53f28de489f4c209776e404323ef5a1@AcuMS.aculab.com>
 <ba45584f-41a2-4d06-8443-e7e64375b07f@lucifer.local>
In-Reply-To: <ba45584f-41a2-4d06-8443-e7e64375b07f@lucifer.local>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Stoakes
> Sent: 10 June 2023 22:07
...
> > > OK, as per the pedantic test bot, you'll need to change this to:-
> > >
> > > num = min_t(size_t, remains, PAGE_SIZE);
> >
> 
> Ordinarily I wouldn't respond to this (I go into why I feel this is not
> useful commentary below) but I am concerned Lu will take you seriously.
> 
> > There has to be a valid reason why min/max have strong type checks.
> 
> I really don't know what you mean by this? Yes there is a reason, I imagine
> it's to avoid unfortunate and invalid type comparisons.

Indeed, the 'unfortunate conversion' is a negative value
being converted to a large positive one.
That doesn't require anything like the type checking that min/max do.

> This is not applicable here (explained below...)
> 
> > Using min_t() all the time is just subverting them and means that
> > bugs are more likely than if the extra tests in min() were absent.
> 
> 'All the time' - are you just having a general whine + moan about perceived
> kernel practices? Can you please keep it focused on the actual issues at
> hand? I am not Linus and therefore not responsible for the entirety of the
> kernel.

I see a general problem (that Linus ought to worried about)
is that whenever min() reports a type error the answer is
do immediately drop in a min_t() instead of looking at the
type of the values and fixing them to that min() doesn't complain.
(Or fixing min() so it doesn't object to a much larger class
of comparisons.0

...
> > A 'safe' change is min(remains + 0ULL, PAGE_SIZE).
> 
> So now we're promoting an unsigned int (and sometimes unsigned long of
> course) to an unsigned long long (for reasons unknown) and comparing it
> with an unsigned long? Wouldn't this trigger the sensitive type check
> anyway?

PAGE size is defined to be 'long long' - so min() will be happy.
The compiler will just DTRT, even if 'remains' is 32bit it will
optimise away all the implied 64-bit extension.

Almost all the min_t() are min_t((some unsigned type),a,b).
If the values are known to be positive then:
#define min_unsigned(a, b) min((a) + 0u + 0ul + 0ull, (b) + 0u + 0ul + 0ull))
will zero extend whatever type is supplied before the comparison.
The compiler will just discard zero extensions.

> To be clear, I'd nack any such ridiculous change unless a hugely compelling
> reason is given (you've not given any). That's horrific. And again, you've
> not provided one single example of an _actual_ bug or situation where the
> 'problem' you tiresomely raise would occur.

The (size_t) cast isn't in itself a problem - provided you've
checked that it is larger than the types of both sides.
But search the kernel and you'll find places when min_t((u8),a,b)
is used.
This all follows the same pattern of min() gave a warning so
so use min_t().

...
> > But, in reality, min/max should always be valid when one
> > value is a constant between 0 and MAX_INT.
> 
> This is getting at a signed/unsigned comparison issue here afaict which is
> not the one we're dealing with here.

But it is exactly what min() is checking for and almost why min()
exists.
A min_unsafe() that didn't try to do any checks would be better
than train wreck that min_t() can create.

...
> Now since you kicked off this 'all the time' stuff I feel like I have been
> given permission to make some broad comments myself...
> 
> David, I am not one to commit-shame being a minor contributor myself buuuut
> I see 7,610 messages from you on lore and 4 commits, all from 4 years ago
> (please correct me if I'm wrong).

I don't work for google, intel, aws (etc).
Getting patches accepted is surprisingly hard.

I've been writing device driver and comms protocol stack code
for best part of 40 years.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

