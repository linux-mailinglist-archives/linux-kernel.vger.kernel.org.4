Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5020F72AE8E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 22:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjFJUJi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 10 Jun 2023 16:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjFJUJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 16:09:37 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5483358E
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 13:09:35 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-310-2DLACrxANTCZx5d8sgYTVQ-1; Sat, 10 Jun 2023 21:09:32 +0100
X-MC-Unique: 2DLACrxANTCZx5d8sgYTVQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 10 Jun
 2023 21:09:28 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 10 Jun 2023 21:09:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Lorenzo Stoakes' <lstoakes@gmail.com>,
        Lu Hongfei <luhongfei@vivo.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "open list:VMALLOC" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: RE: [PATCH] mm/vmalloc: Replace the ternary conditional operator with
 min()
Thread-Topic: [PATCH] mm/vmalloc: Replace the ternary conditional operator
 with min()
Thread-Index: AQHZmq9RsZ2mMErDwEmVNd3QmnYBSK+Ed3Zw
Date:   Sat, 10 Jun 2023 20:09:28 +0000
Message-ID: <f53f28de489f4c209776e404323ef5a1@AcuMS.aculab.com>
References: <20230609061309.42453-1-luhongfei@vivo.com>
 <832d7c69-ffd5-4764-8ffe-3a02bef0efb0@lucifer.local>
 <3fc87d60-4e81-4f49-95f0-0503ad5cdf35@lucifer.local>
In-Reply-To: <3fc87d60-4e81-4f49-95f0-0503ad5cdf35@lucifer.local>
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
> Sent: 09 June 2023 09:49
> On Fri, Jun 09, 2023 at 08:09:45AM +0100, Lorenzo Stoakes wrote:
> > On Fri, Jun 09, 2023 at 02:13:09PM +0800, Lu Hongfei wrote:
> > > It would be better to replace the traditional ternary conditional
> > > operator with min() in zero_iter
> > >
> > > Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> > > ---
> > >  mm/vmalloc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 29077d61ff81..42df032e6c27
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3571,7 +3571,7 @@ static size_t zero_iter(struct iov_iter *iter, size_t count)
> > >  	while (remains > 0) {
> > >  		size_t num, copied;
> > >
> > > -		num = remains < PAGE_SIZE ? remains : PAGE_SIZE;
> > > +		num = min(remains, PAGE_SIZE);
> 
> OK, as per the pedantic test bot, you'll need to change this to:-
> 
> num = min_t(size_t, remains, PAGE_SIZE);

There has to be a valid reason why min/max have strong type checks.
Using min_t() all the time is just subverting them and means that
bugs are more likely than if the extra tests in min() were absent.

The problem here is that size_t is 'unsigned int' but PAGE_SIZE
'unsigned long'.
A 'safe' change is min(remains + 0ULL, PAGE_SIZE).

But, in reality, min/max should always be valid when one
value is a constant between 0 and MAX_INT.
The constant just needs forcing to 'signed int' (eg assigning
to a temporary on that type) before the comparison (etc).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

