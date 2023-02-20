Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B3469C76B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjBTJON convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Feb 2023 04:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBTJOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:14:10 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8FE1025D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:14:08 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-2-K5H9GH6lPTyS8OSzeTeCZA-1; Mon, 20 Feb 2023 09:14:05 +0000
X-MC-Unique: K5H9GH6lPTyS8OSzeTeCZA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Mon, 20 Feb
 2023 09:14:04 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Mon, 20 Feb 2023 09:14:04 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Willy Tarreau' <w@1wt.eu>, Vincent Dagonneau <v@vda.io>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 2/4] tools/nolibc: add integer types and integer limit
 macros
Thread-Topic: [RFC PATCH 2/4] tools/nolibc: add integer types and integer
 limit macros
Thread-Index: AQHZRJM8DwKbMDfmokCJ3dN/cEFOta7Xiaig
Date:   Mon, 20 Feb 2023 09:14:04 +0000
Message-ID: <4da90248dbe94c5db1036cd873dfd910@AcuMS.aculab.com>
References: <20230219185133.14576-1-w@1wt.eu>
 <20230219185133.14576-3-w@1wt.eu>
In-Reply-To: <20230219185133.14576-3-w@1wt.eu>
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

From: Willy Tarreau
> Sent: 19 February 2023 18:52
> 
> This commit adds some of the missing integer types to stdint.h and adds
> limit macros (e.g. INTN_{MIN,MAX}).
> 
...
> 
> +typedef   int8_t       int_least8_t;
> +typedef  uint8_t      uint_least8_t;
> +typedef  int16_t      int_least16_t;
> +typedef uint16_t     uint_least16_t;
> +typedef  int32_t      int_least32_t;
> +typedef uint32_t     uint_least32_t;
> +typedef  int64_t      int_least64_t;
> +typedef uint64_t     uint_least64_t;

The are also the 'fast' variants.
Although I'd be tempted to either not define the 'least'
or 'fast' types (or maybe define them all as 'long').
The only code I've ever seen that used uint_fast32_t
got 'confused' when it was 64 bits.

...
> +/* limits of integral types */
> +
> +#define        INT8_MIN  (-128)
> +#define       INT16_MIN  (-32767-1)
> +#define       INT32_MIN  (-2147483647-1)
> +#define       INT64_MIN  (-9223372036854775807LL-1)

Those big decimal numbers are difficult to check!
A typo would be unfortunate!
Maybe (eg):
#define	INT64_MIN	(-INT64_MAX - 1)

> +#define        INT8_MAX  (127)
> +#define       INT16_MAX  (32767)
> +#define       INT32_MAX  (2147483647)
> +#define       INT64_MAX  (9223372036854775807LL)
> +
> +#define       UINT8_MAX  (255)
> +#define      UINT16_MAX  (65535)
> +#define      UINT32_MAX  (4294967295U)
> +#define      UINT64_MAX  (18446744073709551615ULL)

None of those need brackets.
Defining in hex would be more readable.
Although all the 'f' get hard to count as well.
Given that the types are defined in the same file, why
not use ~0u and ~0ull for UINT32_MAX and UINT64_MAX.

Should UINT8_MAX and UINT16_MAX be unsigned constants?
(Or even be cast to the corresponding type?)
It doesn't affect arithmetic, but would make a difference
to the over-zealous type checking in the kernel min/max
defines.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

