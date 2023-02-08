Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED94468FA6C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 23:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjBHWuC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Feb 2023 17:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjBHWuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 17:50:00 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CBD1F5FE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 14:49:57 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-136-ULMWmCnbPdqcPO_ejgvR-Q-1; Wed, 08 Feb 2023 22:49:55 +0000
X-MC-Unique: ULMWmCnbPdqcPO_ejgvR-Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Wed, 8 Feb
 2023 22:49:53 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Wed, 8 Feb 2023 22:49:53 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: RE: [PATCH v1 1/1] media: i2c: imx290: Make use of
 get_unaligned_le24(), put_unaligned_le24()
Thread-Topic: [PATCH v1 1/1] media: i2c: imx290: Make use of
 get_unaligned_le24(), put_unaligned_le24()
Thread-Index: AQHZO7CvZGRxViq4Fk6IGHHe5gfM5a7FprYA
Date:   Wed, 8 Feb 2023 22:49:53 +0000
Message-ID: <3e2edbf4530345d7a0a04c0dc68ae65a@AcuMS.aculab.com>
References: <20230208112957.15563-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230208112957.15563-1-andriy.shevchenko@linux.intel.com>
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko
> Sent: 08 February 2023 11:30
> 
> Since we have a proper endianness converters for LE 24-bit data use
> them. While at it, format the code using switch-cases as it's done
> for the rest of the endianness handlers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/media/i2c/imx290.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
> index 49d6c8bdec41..330098a0772d 100644
> --- a/drivers/media/i2c/imx290.c
> +++ b/drivers/media/i2c/imx290.c
> @@ -16,6 +16,9 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +
> +#include <asm/unaligned.h>
> +
>  #include <media/media-entity.h>
>  #include <media/v4l2-ctrls.h>
>  #include <media/v4l2-device.h>
> @@ -466,18 +469,20 @@ static int __always_unused imx290_read(struct imx290 *imx290, u32 addr, u32 *val
>  		return ret;
>  	}
> 
> -	*value = (data[2] << 16) | (data[1] << 8) | data[0];
> +	*value = get_unaligned_le24(data);
>  	return 0;
>  }
> 
>  static int imx290_write(struct imx290 *imx290, u32 addr, u32 value, int *err)
>  {
> -	u8 data[3] = { value & 0xff, (value >> 8) & 0xff, value >> 16 };
> +	u8 data[3];
>  	int ret;
> 
>  	if (err && *err)
>  		return *err;
> 
> +	put_unaligned_le24(value, data);
> +
>  	ret = regmap_raw_write(imx290->regmap, addr & IMX290_REG_ADDR_MASK,
>  			       data, (addr >> IMX290_REG_SIZE_SHIFT) & 3);

Why not just use an le32, htole32() and take the address of the low byte?

Anything doing put/get on a 24bit value is pretty much required
to do byte accesses anyway.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

