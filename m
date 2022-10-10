Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA115FA29E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJJRSv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Oct 2022 13:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJJRSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:18:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFBF74DE9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:18:43 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-173-85kE4w7ePByO9GmJH6Worw-1; Mon, 10 Oct 2022 18:18:41 +0100
X-MC-Unique: 85kE4w7ePByO9GmJH6Worw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Mon, 10 Oct
 2022 18:18:40 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Mon, 10 Oct 2022 18:18:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "zx2c4@kernel.org" <zx2c4@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [crng-random:jd/get_random_u32_below 23/23]
 include/linux/random.h:64:69: sparse: sparse: cast truncates bits from
 constant value (1f4 becomes f4)
Thread-Topic: [crng-random:jd/get_random_u32_below 23/23]
 include/linux/random.h:64:69: sparse: sparse: cast truncates bits from
 constant value (1f4 becomes f4)
Thread-Index: AQHY3DtVD69rv9eDCUyAI1FFBLG+sa4H2CJg
Date:   Mon, 10 Oct 2022 17:18:40 +0000
Message-ID: <a473cc4da4874235b2b98fd1a57e782e@AcuMS.aculab.com>
References: <202210100722.Wc2gmfS6-lkp@intel.com>
In-Reply-To: <202210100722.Wc2gmfS6-lkp@intel.com>
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

From: kernel test robot <lkp@intel.com>
> Sent: 10 October 2022 00:32
> To: Jason A. Donenfeld <zx2c4@kernel.org>
...

I'm missing the main mailing list email for this change.
I'm guessing the non-inlined code for non-constant ceil
is similar.

> vim +64 include/linux/random.h
> 
>     53
>     54	u32 __get_random_u32_below(u32 ceil);
>     55	/* Returns a random integer in the interval [0, ceil), with uniform distribution. */
>     56	static inline u32 get_random_u32_below(u32 ceil)
>     57	{
>     58		if (!__builtin_constant_p(ceil))
>     59			return __get_random_u32_below(ceil);
>     60
>     61		for (;;) {
>     62			if (ceil <= 1U << 8) {
>     63				u32 mult = ceil * get_random_u8();
>   > 64				if (is_power_of_2(ceil) || (u8)mult >= -(u8)ceil % ceil)
>     65					return mult >> 8;

If you are going to check is_power_of_2() then you might as well do:
		u32 val = get_random_u8();
		if (is_power_of_2(ceil))
			return ceil == 0x100 ? val : val & (ceil - 1);
Except that you don't want to loop on zero - so !(ceil & (ceil - 1))
is arguably better since it is absolutely explicit.
Or (for the constant case) a BUILD_BUG_ON(ceil == 0)?

Notwithstanding the completely untested code the bot complained about
doing a division here is unnecessary and expensive.
(Except this is the constant path...)
I think:
		val *= ceil;
		if ((val + ceil - 1) >> 8 == val >> 8)
			return val >> 8;
has the desired property.

It is also definitely worth a comment like:
	/* In the worst case this loops 50% of the time.
	 * While the loop is unbounded the average number
	 * of iterations (for the worst ceil) is 2. */

There are also a lot of places where having the values
evenly spread is enough - even if some values are returned
one more time than others.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

