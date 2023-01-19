Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6BD67467A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjASW52 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Jan 2023 17:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjASW5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:57:00 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822874EFF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:40:18 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-287-3P_nEL3mOAutjlywxieM1A-1; Thu, 19 Jan 2023 22:40:13 +0000
X-MC-Unique: 3P_nEL3mOAutjlywxieM1A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 19 Jan
 2023 22:40:12 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Thu, 19 Jan 2023 22:40:12 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/9] pktcdvd: replace sscanf() by kstrtoul()
Thread-Topic: [PATCH v1 2/9] pktcdvd: replace sscanf() by kstrtoul()
Thread-Index: AQHZLFSz0l2dbTPDaEqI/WBYs5oAkq6mVGBQ
Date:   Thu, 19 Jan 2023 22:40:12 +0000
Message-ID: <4f4c89f2c0924f05a894a1457c63ee4c@AcuMS.aculab.com>
References: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
 <20230119220809.5518-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230119220809.5518-2-andriy.shevchenko@linux.intel.com>
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
> Sent: 19 January 2023 22:08
> 
> The checkpatch.pl warns: "Prefer kstrto<type> to single variable sscanf".
> Fix the code accordingly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/block/pktcdvd.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> index 0ec8dc8ee5ed..ad4336ae9927 100644
> --- a/drivers/block/pktcdvd.c
> +++ b/drivers/block/pktcdvd.c
> @@ -236,15 +236,16 @@ static ssize_t congestion_off_store(struct device *dev,
>  				    const char *buf, size_t len)
>  {
>  	struct pktcdvd_device *pd = dev_get_drvdata(dev);
> -	int val;
> +	int val, ret;
> 
> -	if (sscanf(buf, "%d", &val) == 1) {
> -		spin_lock(&pd->lock);
> -		pd->write_congestion_off = val;
> -		init_write_congestion_marks(&pd->write_congestion_off,
> -					&pd->write_congestion_on);
> -		spin_unlock(&pd->lock);
> -	}
> +	ret = kstrtoint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	spin_lock(&pd->lock);
> +	pd->write_congestion_off = val;
> +	init_write_congestion_marks(&pd->write_congestion_off, &pd->write_congestion_on);
> +	spin_unlock(&pd->lock);
>  	return len;
>  }

These don't look directly equivalent.
The sscanf() version silently ignores trailing characters.
I think kstrtoint() will generate an error.
Have you actually checked that the caller allows for
an error return.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

