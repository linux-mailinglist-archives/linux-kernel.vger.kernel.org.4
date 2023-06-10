Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5152672AF80
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 00:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjFJW3d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 10 Jun 2023 18:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjFJW3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 18:29:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCDD3584
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 15:29:29 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-202-XgiTLAFcNSyLSvWHXgvipg-1; Sat, 10 Jun 2023 23:29:27 +0100
X-MC-Unique: XgiTLAFcNSyLSvWHXgvipg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 10 Jun
 2023 23:29:22 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 10 Jun 2023 23:29:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Morton' <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
CC:     Lu Hongfei <luhongfei@vivo.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "open list:VMALLOC" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: RE: [PATCH] mm/vmalloc: Replace the ternary conditional operator with
 min()
Thread-Topic: [PATCH] mm/vmalloc: Replace the ternary conditional operator
 with min()
Thread-Index: AQHZm+gKsZ2mMErDwEmVNd3QmnYBSK+Emzhg
Date:   Sat, 10 Jun 2023 22:29:21 +0000
Message-ID: <84a2c079fcd44b8490eaf039cd20d2bf@AcuMS.aculab.com>
References: <20230609061309.42453-1-luhongfei@vivo.com>
        <832d7c69-ffd5-4764-8ffe-3a02bef0efb0@lucifer.local>
        <3fc87d60-4e81-4f49-95f0-0503ad5cdf35@lucifer.local>
        <f53f28de489f4c209776e404323ef5a1@AcuMS.aculab.com>
        <ba45584f-41a2-4d06-8443-e7e64375b07f@lucifer.local>
 <20230610150809.babdc5a7919258f066c8637e@linux-foundation.org>
In-Reply-To: <20230610150809.babdc5a7919258f066c8637e@linux-foundation.org>
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

From: Andrew Morton <akpm@linux-foundation.org>
> Sent: 10 June 2023 23:08
> 
> On Sat, 10 Jun 2023 22:06:35 +0100 Lorenzo Stoakes <lstoakes@gmail.com> wrote:
> 
> > > > OK, as per the pedantic test bot, you'll need to change this to:-
> > > >
> > > > num = min_t(size_t, remains, PAGE_SIZE);
> 
> PAGE_SIZE is a nuisance.  It _usually_ creates the need for a
> cast:
> 
> hp2:/usr/src/linux-6.4-rc4> grep -r "min(.*PAGE_SIZE" . | wc -l
> 117
> hp2:/usr/src/linux-6.4-rc4> grep -r "min_t(.*PAGE_SIZE" . | wc -l
> 279
> 
> Perhaps it should always have been size_t.
> 
> I suppose we could do
> 
> #define PAGE_SIZE_T (size_t)PAGE_SIZE
> 
> And use that where needed.  Mainly because I like the name ;)

Or someone take my patches to relax the checks min() does a bit.
I think I last posted them in January.
Basically:
- unsigned v unsigned is always ok.
- signed v signed is always ok.
- unsigned v signed is ok provided one value is in [0..INT_MAX].
  this can be allowed for compile-time constants.

The usual 'error case' is unsigned v signed when the values
are known (by the person writing the code) to be non-negative.
Doing '(x) + 0u + 0ul + 0ull' zero extends the value without
ever masking it or 'accidentally' converting a pointer.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

