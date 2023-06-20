Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19E7736997
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjFTKlu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 06:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjFTKls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:41:48 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D909D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 03:41:46 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-200-3m5ZqeQDNFqRLkrPQhChcg-1; Tue, 20 Jun 2023 11:41:43 +0100
X-MC-Unique: 3m5ZqeQDNFqRLkrPQhChcg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 20 Jun
 2023 11:41:41 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 20 Jun 2023 11:41:41 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Morton' <akpm@linux-foundation.org>,
        Wang Ming <machel@vivo.com>
CC:     Mike Rapoport <rppt@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: RE: [PATCH v1] mm:Using div64_ul replaces do_div() function
Thread-Topic: [PATCH v1] mm:Using div64_ul replaces do_div() function
Thread-Index: AQHZoIwRQASXgZQ+1kWZyPY+ePpnl6+ThGqw
Date:   Tue, 20 Jun 2023 10:41:41 +0000
Message-ID: <5c04998fb225430e8e4966cc95f8a0ea@AcuMS.aculab.com>
References: <20230615075127.6832-1-machel@vivo.com>
 <20230616125219.dc2346534d6f279a7527c0b0@linux-foundation.org>
In-Reply-To: <20230616125219.dc2346534d6f279a7527c0b0@linux-foundation.org>
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

From: Andrew Morton
> Sent: 16 June 2023 20:52
> 
> On Thu, 15 Jun 2023 15:51:14 +0800 Wang Ming <machel@vivo.com> wrote:
> 
> > Fix the following coccicheck warning:
> >
> > mm/mm_init.c:2492:2-8: WARNING: do_div() does a
> > 64-by-32 division, please consider using div64_ul instead.
> 
> I guess coccicheck was fooled by the incorrect comment over do_div().
> do_div() returns an unsigned long.

IIRC do_div() does an in-place update, but div64_ul() returns the result.
So the 'fixed' code is entirely broken.

The coccicheck message should really be 'check the domain/type of the divisor'.

> alloc_large_system_hash() should be using a u64 for `max'.  Nobody uses
> unsigned long long any more.

Probably makes no difference.
The issue is with 'buckesize' - probably 'long' so 64bit on 64bit systems.

I guess 'max' can overflow 'long' on 32bit PAE.
Although using min(nr_all_pages, 0x80000000UL >> PAGE_SHIFT >> 4)
and doing everything as 'unsigned long' might be better.

	David

> 
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -2508,7 +2508,7 @@ void *__init alloc_large_system_hash(const char *tablename,
> >         /* limit allocation size to 1/16 total memory by default */
> >         if (max == 0) {
> >                 max = ((unsigned long long)nr_all_pages << PAGE_SHIFT) >> 4;
> > -               do_div(max, bucketsize);
> > +               div64_ul(max, bucketsize);
> >         }
> >         max = min(max, 0x80000000ULL);

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

