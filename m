Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2B86889A2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjBBWVS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Feb 2023 17:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjBBWVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:21:16 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1764361D6E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:21:14 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-6-NIErQV5sM7O9WZeEFgFa4A-1; Thu, 02 Feb 2023 22:21:11 +0000
X-MC-Unique: NIErQV5sM7O9WZeEFgFa4A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Thu, 2 Feb
 2023 22:21:09 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Thu, 2 Feb 2023 22:21:09 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-1?Q?J=F3_=C1gila_Bitsch?= <jgilab@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] usb: gadget: configfs: Use memcpy_and_pad()
Thread-Topic: [PATCH v1 1/1] usb: gadget: configfs: Use memcpy_and_pad()
Thread-Index: AQHZNxm+l/T4NTiDmECVJ2T25+K0iq68OOyQ
Date:   Thu, 2 Feb 2023 22:21:09 +0000
Message-ID: <c97c4048109242228b0af3199a67f0bc@AcuMS.aculab.com>
References: <20230202151736.64552-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230202151736.64552-1-andriy.shevchenko@linux.intel.com>
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

From: Andy Shevchenko
> Sent: 02 February 2023 15:18
> 
> Instead of zeroing some memory and then copying data in part or all of it,
> use memcpy_and_pad().
> This avoids writing some memory twice and should save a few cycles.

Maybe, maybe not.
It rather depends on the lengths involved (the code doesn't seem to be in the
main tree).

The cost of the conditionals and the misaligned length/start for the
memset() could easily overwhelm any apparent saving.

A memset() of a constant whole number of words is going to be significantly
faster than the partial one.

	David

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/usb/gadget/configfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
> index 1346b330b358..0ee47e4c22cb 100644
> --- a/drivers/usb/gadget/configfs.c
> +++ b/drivers/usb/gadget/configfs.c
> @@ -909,8 +909,7 @@ static ssize_t webusb_landingPage_store(struct config_item *item, const char *pa
> 
>  	mutex_lock(&gi->lock);
>  	// ensure 0 bytes are set, in case the new landing page is shorter then the old one.
> -	memset(gi->landing_page, 0, sizeof(gi->landing_page));
> -	memcpy(gi->landing_page, page, l);
> +	memcpy_and_pad(gi->landing_page, sizeof(gi->landing_page), page, l, 0);
>  	mutex_unlock(&gi->lock);
> 
>  	return len;
> --
> 2.39.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

