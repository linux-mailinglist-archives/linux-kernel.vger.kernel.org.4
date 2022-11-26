Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB449639543
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 11:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiKZKVh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 26 Nov 2022 05:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKZKVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 05:21:35 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C092EE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 02:21:33 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-7-PEJrQAPKM0-7aEaY7vS11A-1; Sat, 26 Nov 2022 10:21:29 +0000
X-MC-Unique: PEJrQAPKM0-7aEaY7vS11A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 26 Nov
 2022 10:21:28 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Sat, 26 Nov 2022 10:21:28 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Morton' <akpm@linux-foundation.org>
CC:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "'Joe Perches'" <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: [PATCH 0/1] Slightly relax the type checking done by min() and
 max().
Thread-Topic: [PATCH 0/1] Slightly relax the type checking done by min() and
 max().
Thread-Index: AdkA3hAUrkOWi1xYRg2SAA6P778SAwAA2U8AAAAaTjAAATacgAAAJxcAAAOumYAAAtABMAAKQvIAABTU1NA=
Date:   Sat, 26 Nov 2022 10:21:28 +0000
Message-ID: <a8b96c909ed741398435d21b43a93523@AcuMS.aculab.com>
References: <cfc6c0f0fd4c4724890be8a8397c2cbe@AcuMS.aculab.com>
        <Y4DdQIMiFGk7YYcJ@smile.fi.intel.com>
        <7e594ad64e444d448c747688b8f28249@AcuMS.aculab.com>
        <Y4DmFfj6G6+niZ+t@smile.fi.intel.com>
        <0b38ced96519407e95962aef2771bbc6@AcuMS.aculab.com>
        <Y4D/0dqOODs4ZHQM@smile.fi.intel.com>
        <03db8d2f34fa4bffada8b34ee87b090a@AcuMS.aculab.com>
 <20221125160222.9d69bb5d54a0304e0f476f67@linux-foundation.org>
In-Reply-To: <20221125160222.9d69bb5d54a0304e0f476f67@linux-foundation.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton
> Sent: 26 November 2022 00:02
> 
> On Fri, 25 Nov 2022 19:47:14 +0000 David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > > Blindly relaxing the rules is not an option in my opinion.
> >
> > The point is I'm not really relaxing the rules.
> > If anything I'm actually tightening them by allowing min() to
> > be used in more cases - so letting the buggy min_t() casts be
> > removed at some point in the future.
> 
> That sounds very virtuous.

Indeed.

> It would be helpful to see a few "convert min_t to min" patches
> to see this proposal in action.

I did try building a kernel with '#define min_t min' and then
picking up the pieces.
Doable but there are still too many false positives.
That is when I found some of the 'broken' uses of min_t().

I'd rather get this patch accepted and then build on top of it.
Then it should be possible to work out which min_t() actually
need to stay - I suspect very few.

It might even be worth converting min_t(type,x,y) to
min_t_type(x,y) and then converting the min_t_u[0-9]*(x,y) to
#define min_unsigned(x,y) min((x) + 0u + 0ull, (y) + 0u + 0ull)
I think that efficiently converts both values to an unsigned
type without masking the value.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

