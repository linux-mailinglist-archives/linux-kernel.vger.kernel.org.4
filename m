Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D1B67F8D4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 15:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjA1Ovz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 28 Jan 2023 09:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjA1Ovx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 09:51:53 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E052A985
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 06:51:51 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-102-OIU3GEihP6Ga3CaU9PHDDw-1; Sat, 28 Jan 2023 14:51:48 +0000
X-MC-Unique: OIU3GEihP6Ga3CaU9PHDDw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Sat, 28 Jan
 2023 14:51:47 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Sat, 28 Jan 2023 14:51:47 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andy@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH v1 1/1] lib/string: Use strchr() in strpbrk()
Thread-Topic: [PATCH v1 1/1] lib/string: Use strchr() in strpbrk()
Thread-Index: AQHZMmcwwuoXGWmDc06Jaw4hqxFhbK6z5+Fw
Date:   Sat, 28 Jan 2023 14:51:47 +0000
Message-ID: <a903947619f94dfa88d3dd147b7a5e95@AcuMS.aculab.com>
References: <20230127155135.27153-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230127155135.27153-1-andriy.shevchenko@linux.intel.com>
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
> Sent: 27 January 2023 15:52
> 
> Use strchr() instead of open coding it as it's done elsewhere in
> the same file. Either we will have similar to what it was or possibly
> better performance in case architecture implements its own strchr().

Except that you get a whole load of calls to strchr() for (typically)
very few characters.
So the cost of the calls dominates, anything that tries to speed up
strchr() for long strings will also slow things down.

Plausibly this version (untested) is faster!

char *strbprk(const char *str, const char *seps)
{
	const char *found, *try;

	do {
		if (*!seps)
			return NULL;
		found = strchr(str, *seps++);
	} while (!found);

	while (*seps) {
		try = memchr(str, *seps++, found - str);
		if (try)
			found = try;
	}

	return (char *)found;
}

Although I very much doubt strpbrk() is used anywhere where
performance matters.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

