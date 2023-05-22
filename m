Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6611770B76F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjEVITT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 May 2023 04:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjEVITP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:19:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58909C7
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:19:14 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-147-ariLRcbvMsic7sM9JfpM6Q-1; Mon, 22 May 2023 09:18:59 +0100
X-MC-Unique: ariLRcbvMsic7sM9JfpM6Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 22 May
 2023 09:18:53 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 22 May 2023 09:18:53 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sebastian Reichel' <sebastian.reichel@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kernel@collabora.com" <kernel@collabora.com>
Subject: RE: [PATCH v1 2/2] clk: divider: Properly handle rates exceeding
 UINT_MAX
Thread-Topic: [PATCH v1 2/2] clk: divider: Properly handle rates exceeding
 UINT_MAX
Thread-Index: AQHZioTsgOA8rKF4Y0+0s2ErF0La269l9j4w
Date:   Mon, 22 May 2023 08:18:53 +0000
Message-ID: <1b74d2ea2c3a458694c4c74f2381fcab@AcuMS.aculab.com>
References: <20230519190522.194729-1-sebastian.reichel@collabora.com>
 <20230519190522.194729-3-sebastian.reichel@collabora.com>
In-Reply-To: <20230519190522.194729-3-sebastian.reichel@collabora.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Reichel
> Sent: 19 May 2023 20:05
> 
> Requesting rates exceeding UINT_MAX (so roughly 4.3 GHz) results
> in very small rate being chosen instead of very high ones, since
> DIV_ROUND_UP_ULL takes a 32 bit integer as second argument.
> 
> Correct this by using DIV64_U64_ROUND_UP instead, which takes proper
> 64 bit values for dividend and divisor.

This doesn't look right on 32-bit architectures.
While you really don't want to be doing full 64bit divides
there is also the problem that any input values over 4.3Ghz
have already been masked.

In the values can be over 4.3GHz then the function arguments
need to be 64bit - not long.

	David

> 
> Note, that this is usually not an issue. ULONG_MAX sets the lower
> 32 bits and thus effectively requests UINT_MAX. On most platforms
> that is good enough. To trigger a real bug one of the following
> conditions must be met:
> 
>  * A parent clock with more than 8.5 GHz is available
>  * Instead of ULONG_MAX a specific frequency like 4.3 GHz is
>    requested. That would end up becoming 5 MHz instead :)
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/clk/clk-divider.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index a2c2b5203b0a..dddaaf0f9d25 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -220,7 +220,7 @@ static int _div_round_up(const struct clk_div_table *table,
>  			 unsigned long parent_rate, unsigned long rate,
>  			 unsigned long flags)
>  {
> -	int div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
> +	int div = DIV64_U64_ROUND_UP(parent_rate, rate);
> 
>  	if (flags & CLK_DIVIDER_POWER_OF_TWO)
>  		div = __roundup_pow_of_two(div);
> @@ -237,7 +237,7 @@ static int _div_round_closest(const struct clk_div_table *table,
>  	int up, down;
>  	unsigned long up_rate, down_rate;
> 
> -	up = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
> +	up = DIV64_U64_ROUND_UP(parent_rate, rate);
>  	down = parent_rate / rate;
> 
>  	if (flags & CLK_DIVIDER_POWER_OF_TWO) {
> @@ -473,7 +473,7 @@ int divider_get_val(unsigned long rate, unsigned long parent_rate,
>  {
>  	unsigned int div, value;
> 
> -	div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
> +	div = DIV64_U64_ROUND_UP(parent_rate, rate);
> 
>  	if (!_is_valid_div(table, div, flags))
>  		return -EINVAL;
> --
> 2.39.2

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

