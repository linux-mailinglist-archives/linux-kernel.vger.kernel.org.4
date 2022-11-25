Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA8F638D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiKYP1O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Nov 2022 10:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKYP1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:27:13 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5534221888
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:27:12 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-98-qxRf-fgQM2mvgZarnXUlzg-1; Fri, 25 Nov 2022 15:27:09 +0000
X-MC-Unique: qxRf-fgQM2mvgZarnXUlzg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 25 Nov
 2022 15:27:07 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Fri, 25 Nov 2022 15:27:07 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "'Joe Perches'" <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: [PATCH 0/1] Slightly relax the type checking done by min() and
 max().
Thread-Topic: [PATCH 0/1] Slightly relax the type checking done by min() and
 max().
Thread-Index: AdkA3hAUrkOWi1xYRg2SAA6P778SAwAA2U8AAAAaTjA=
Date:   Fri, 25 Nov 2022 15:27:07 +0000
Message-ID: <7e594ad64e444d448c747688b8f28249@AcuMS.aculab.com>
References: <cfc6c0f0fd4c4724890be8a8397c2cbe@AcuMS.aculab.com>
 <Y4DdQIMiFGk7YYcJ@smile.fi.intel.com>
In-Reply-To: <Y4DdQIMiFGk7YYcJ@smile.fi.intel.com>
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

From: Andy Shevchenko
> Sent: 25 November 2022 15:21
> 
> On Fri, Nov 25, 2022 at 03:00:40PM +0000, David Laight wrote:
> > The min() and max() defines include a type check to avoid the unexpected
> >   behaviour when a negative value is compared against and unsigned value.
> > However a lot of code hits this check and uses min_t() to avoid the error.
> > Many of these are just plain wrong.
> >
> > Those casting to u8 or u16 are particularly suspect, eg:
> > drivers/usb/misc/usb251xb.c:528:
> > 		hub->max_current_sp = min_t(u8, property_u32 / 2000, 50);
> 
> I don't buy this. What's exactly wrong with this code?

Consider what happens if propery_u32 is 512000.
The returned value is 0 not 50.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

