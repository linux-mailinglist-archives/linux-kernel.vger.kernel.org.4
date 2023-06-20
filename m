Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476DF736B95
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjFTMHI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 08:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjFTMG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:06:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D79CE7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:06:54 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-212-qWok5JaiM8qFyY53-503-g-1; Tue, 20 Jun 2023 13:06:52 +0100
X-MC-Unique: qWok5JaiM8qFyY53-503-g-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 20 Jun
 2023 13:06:49 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 20 Jun 2023 13:06:49 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] pktcdvd: Use clamp_val() instead of min()+max()
Thread-Topic: [PATCH v1 1/1] pktcdvd: Use clamp_val() instead of min()+max()
Thread-Index: AQHZoF6FIyAIB0qgg0eyK+mA2nZIdK+TnYVA
Date:   Tue, 20 Jun 2023 12:06:49 +0000
Message-ID: <9258be5d31104805b63bb1a64317a448@AcuMS.aculab.com>
References: <20230616142614.36206-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230616142614.36206-1-andriy.shevchenko@linux.intel.com>
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

From: Andy Shevchenko
> Sent: 16 June 2023 15:26
> 
> In a couple of places replace min()+max() pair by clamp_val().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/block/pktcdvd.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> index a1428538bda5..18a960bb6165 100644
> --- a/drivers/block/pktcdvd.c
> +++ b/drivers/block/pktcdvd.c
> @@ -208,14 +208,11 @@ static DEVICE_ATTR_RO(size);
>  static void init_write_congestion_marks(int* lo, int* hi)
>  {
>  	if (*hi > 0) {
> -		*hi = max(*hi, 500);
> -		*hi = min(*hi, 1000000);
> +		*hi = clamp_val(*hi, 500, 1000000);

(standard rant about minmax.h)

clamp_val() is pretty much broken by design.
It MIGHT be ok here but it casts both limits to the
type of the value being compared.
In general that is just plain wrong.

Like min_t() it is generally ok because the kernel only uses
unsigned values between 0 and MAXINT.

If min/max were ok, then using clamp() should also be ok.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

