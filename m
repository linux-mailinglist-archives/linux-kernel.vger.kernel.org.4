Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9288067775B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjAWJ0Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Jan 2023 04:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAWJ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:26:23 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D511554E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:26:21 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-170-pWK5ZHwsNsOHzMuVCmnqRQ-1; Mon, 23 Jan 2023 09:26:18 +0000
X-MC-Unique: pWK5ZHwsNsOHzMuVCmnqRQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Mon, 23 Jan
 2023 09:26:18 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Mon, 23 Jan 2023 09:26:18 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Javier Martinez Canillas' <javierm@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH] drm/ssd130x: Silence a `dubious: x & !y` warning
Thread-Topic: [PATCH] drm/ssd130x: Silence a `dubious: x & !y` warning
Thread-Index: AQHZLcwEpBlghOuKm0WPZwn3mEYKGa6rvUhg
Date:   Mon, 23 Jan 2023 09:26:17 +0000
Message-ID: <e5279ea9dfab400c8e6cd9346fb41a1d@AcuMS.aculab.com>
References: <20230121190930.2804224-1-javierm@redhat.com>
In-Reply-To: <20230121190930.2804224-1-javierm@redhat.com>
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

From: Javier Martinez Canillas
> Sent: 21 January 2023 19:10
> 
> The sparse tool complains with the following warning:
> 
> $ make M=drivers/gpu/drm/solomon/ C=2
>   CC [M]  drivers/gpu/drm/solomon/ssd130x.o
>   CHECK   drivers/gpu/drm/solomon/ssd130x.c
> drivers/gpu/drm/solomon/ssd130x.c:363:21: warning: dubious: x & !y
> 
> This seems to be a false positive in my opinion but still we can silence
> the tool while making the code easier to read. Let's also add a comment,
> to explain why the "com_seq" logical not is used rather than its value.
> 
> Reported-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
> 
>  drivers/gpu/drm/solomon/ssd130x.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
> index c3bf3a18302e..b16330a8b624 100644
> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c
> @@ -81,7 +81,7 @@
>  #define SSD130X_SET_PRECHARGE_PERIOD2_MASK	GENMASK(7, 4)
>  #define SSD130X_SET_PRECHARGE_PERIOD2_SET(val)	FIELD_PREP(SSD130X_SET_PRECHARGE_PERIOD2_MASK, (val))
>  #define SSD130X_SET_COM_PINS_CONFIG1_MASK	GENMASK(4, 4)
> -#define SSD130X_SET_COM_PINS_CONFIG1_SET(val)	FIELD_PREP(SSD130X_SET_COM_PINS_CONFIG1_MASK, !(val))
> +#define SSD130X_SET_COM_PINS_CONFIG1_SET(val)	FIELD_PREP(SSD130X_SET_COM_PINS_CONFIG1_MASK, (val))

How about just changing !(val) to (val) ? 0 : 1
It should shut the compiler up and is probably more descriptive.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

