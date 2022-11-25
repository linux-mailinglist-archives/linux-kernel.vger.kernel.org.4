Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B4B63905C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 20:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiKYTrX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Nov 2022 14:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiKYTrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 14:47:21 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B82A554F7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 11:47:19 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-132-xJfD25wcPYW28K4UU6qvFg-1; Fri, 25 Nov 2022 19:47:16 +0000
X-MC-Unique: xJfD25wcPYW28K4UU6qvFg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 25 Nov
 2022 19:47:14 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Fri, 25 Nov 2022 19:47:14 +0000
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
Thread-Index: AdkA3hAUrkOWi1xYRg2SAA6P778SAwAA2U8AAAAaTjAAATacgAAAJxcAAAOumYAAAtABMA==
Date:   Fri, 25 Nov 2022 19:47:14 +0000
Message-ID: <03db8d2f34fa4bffada8b34ee87b090a@AcuMS.aculab.com>
References: <cfc6c0f0fd4c4724890be8a8397c2cbe@AcuMS.aculab.com>
 <Y4DdQIMiFGk7YYcJ@smile.fi.intel.com>
 <7e594ad64e444d448c747688b8f28249@AcuMS.aculab.com>
 <Y4DmFfj6G6+niZ+t@smile.fi.intel.com>
 <0b38ced96519407e95962aef2771bbc6@AcuMS.aculab.com>
 <Y4D/0dqOODs4ZHQM@smile.fi.intel.com>
In-Reply-To: <Y4D/0dqOODs4ZHQM@smile.fi.intel.com>
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

From: 'Andy Shevchenko'
> Sent: 25 November 2022 17:48
> 
> On Fri, Nov 25, 2022 at 04:14:58PM +0000, David Laight wrote:
> > From: 'Andy Shevchenko'
> > > Sent: 25 November 2022 15:58
> > > On Fri, Nov 25, 2022 at 03:27:07PM +0000, David Laight wrote:
> 
> ...
> 
> > > Any better example, please?
> >
> > How about:
> 
> Better, indeed.
> 
> > data_size = min_t(u16, buf_size, len);
> >
> > https://elixir.bootlin.com/linux/v6.1-rc6/source/kernel/printk/printk_ringbuffer.c#L1738
> >
> > Now, maybe, you could claim that buf_size > 64k never happens.
> > But the correct cast here is u32 to match buf_size.
> > len (being u16) will be promoted to int before the compare.
> >
> > Just search the kernel for "min_t(u8," or "min_t(u16," while some might
> > be ok, I really wouldn't want to verify each case.
> >
> > If you look hard enough there are also some:
> > 	u32_var = min_t(u32, u32_val, u64_val);
> > where the intent is to limit values that might be invalid for u32.
> 
> Wouldn't be better to actually issue a warning if the desired type is shorter
> than one of the min_t() arguments?
> 
> Then you go through all cases and fix them accordingly.

That is an option, but that is separate from this change.

> Blindly relaxing the rules is not an option in my opinion.

The point is I'm not really relaxing the rules.
If anything I'm actually tightening them by allowing min() to
be used in more cases - so letting the buggy min_t() casts be
removed at some point in the future.

The purpose of the type check is to error code like:
	int x = -4;
	x = min(x, 100u);
where integer promotion changes the comparison 'x < 100u' to
the unexpected '(unsigned int)x < 100u' so x is set to 100.

However is also errors the opposite:
	unsigned int x = 4;
	x = min(x, 100);
But, in this case, the compiler just converts 100 to 100u and
everything is fine.

It also errors the perfectly valid (and reasonable looking):
	unsigned char x = 4;
	x = min(x, 100u);
because 100u is 'unsigned int'.
Indeed, 'x' gets converted to 'signed int' for the comparison.

When the (usually) RHS is a compile-time constant that is known
to be positive (and less than 2^31) I'm just changing the test to:
	if (variable < (int)constant)
If 'variable' is a signed type this always generates the
required signed compare.
If 'variable is 'unsigned char' or 'unsigned short' then it
gets promoted to signed int and a signed compare of positive
values is done.
If variable is 'unsigned int', 'unsigned long' or 'unsigned long long'
then the RHS is converted to unsigned - but keeps its value since
it is known to be positive.
In all cases the outcome is exactly what is required.
No change of putting in the wrong cast.

There are a few other common cases that are valid but currently
generate an error:
	min(s8_var, int_expr)
	min(u8_var, int_expr)
	min(u8_var, unsigned_int_expr)
These generate an error regardless of whether the sizes match:
	min(int_expr, long_expr)
	min(unsigned_int_expr, unsigned_long_expr)
	min(unsigned_long_expr, unsigned_long_long_expr)
This is less common but should also be allowed:
	min(long_long_int_expr, unsigned_int_expr)
(ie when the signed type is larger than the unsigned one)

I have a plan for how to allow all those as well.

Checking typeof((x) + 0) against typeof((y) + 0) allows for the
promotion of char/short to signed int - but not any of the
other comparisons that never implicitly convert a signed value
to unsigned (and hence negative values to large positive ones).

	David

	

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

