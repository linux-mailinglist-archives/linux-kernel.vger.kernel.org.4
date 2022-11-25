Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE4D638CD7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiKYPAz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Nov 2022 10:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKYPAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:00:51 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3009332060
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:00:49 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-233-_fQABpPHMNKhxMHqvcLVOg-1; Fri, 25 Nov 2022 15:00:44 +0000
X-MC-Unique: _fQABpPHMNKhxMHqvcLVOg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 25 Nov
 2022 15:00:41 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Fri, 25 Nov 2022 15:00:41 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        'Joe Perches' <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/1] Slightly relax the type checking done by min() and max().
Thread-Topic: [PATCH 0/1] Slightly relax the type checking done by min() and
 max().
Thread-Index: AdkA3hAUrkOWi1xYRg2SAA6P778SAw==
Date:   Fri, 25 Nov 2022 15:00:40 +0000
Message-ID: <cfc6c0f0fd4c4724890be8a8397c2cbe@AcuMS.aculab.com>
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

The min() and max() defines include a type check to avoid the unexpected
  behaviour when a negative value is compared against and unsigned value.
However a lot of code hits this check and uses min_t() to avoid the error.
Many of these are just plain wrong.

Those casting to u8 or u16 are particularly suspect, eg:
drivers/usb/misc/usb251xb.c:528:
		hub->max_current_sp = min_t(u8, property_u32 / 2000, 50);

This patch does two changes:
- Replace typeof(x) with typeof((x) + 0) to promote char/short to int.
- Add an (int) cast to constants between 0 and MAX_INT so the compiler
  doesn't promote the 'other side' of the comparison to an unsinged type.
  If this is done the type test is arranged to always succeed.

The following can also be done (with some lateral thought):
- Allow all comparisons where both types are signed. 
- Allow all comparisons where both types are unsigned. 
- Allow comparisons where the larger type is signed.

In addition most of the min_t() calls are there to compare a signed type
(that holds a non-negative value) with an unsigned value.
The definition:
#define min_unsigned(x,y) min((x) + 0u + 0ull, (y) + 0u + 0ull)
will do an unsigned comparision without 'accidentally' masking off
any non-zero high bits.

With those extra changes there can be a 'duck shoot' on min_t().

David Laight (1):
  Slightly relax the type checking done by min() and max().

 include/linux/minmax.h | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

-- 
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

