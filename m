Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA0A736B52
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjFTLpK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 07:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjFTLpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:45:08 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE4AA1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:45:07 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-183-CwR9mL0JPti0FE6q9jlz4w-1; Tue, 20 Jun 2023 12:45:04 +0100
X-MC-Unique: CwR9mL0JPti0FE6q9jlz4w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 20 Jun
 2023 12:45:02 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 20 Jun 2023 12:45:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Herve Codina' <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: RE: [PATCH v5 07/13] minmax: Introduce {min,max}_array()
Thread-Topic: [PATCH v5 07/13] minmax: Introduce {min,max}_array()
Thread-Index: AQHZn535xpz9i2gsDE6nNaGlDsvHDa+TlXFw
Date:   Tue, 20 Jun 2023 11:45:01 +0000
Message-ID: <70697b976107473b8779eea7d6c8a189@AcuMS.aculab.com>
References: <20230615152631.224529-1-herve.codina@bootlin.com>
 <20230615152631.224529-8-herve.codina@bootlin.com>
In-Reply-To: <20230615152631.224529-8-herve.codina@bootlin.com>
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

From: Herve Codina
> Sent: 15 June 2023 16:26
> 
> Introduce min_array() (resp max_array()) in order to get the
> minimal (resp maximum) of values present in an array.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  include/linux/minmax.h | 64 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/include/linux/minmax.h b/include/linux/minmax.h
> index 396df1121bff..1672985b02a3 100644
> --- a/include/linux/minmax.h
> +++ b/include/linux/minmax.h
> @@ -133,6 +133,70 @@
>   */
>  #define max_t(type, x, y)	__careful_cmp((type)(x), (type)(y), >)
> 
> +/*
> + * Remove a const qualifier from integer types
> + * _Generic(foo, type-name: association, ..., default: association) performs a
> + * comparison against the foo type (not the qualified type).
> + * Do not use the const keyword in the type-name as it will not match the
> + * unqualified type of foo.
> + */
> +#define __unconst_integer_type_cases(type)	\
> +	unsigned type:  (unsigned type)0,	\
> +	signed type:    (signed type)0
> +
> +#define __unconst_integer_typeof(x) typeof(			\
> +	_Generic((x),						\
> +		char: (char)0,					\
> +		__unconst_integer_type_cases(char),		\
> +		__unconst_integer_type_cases(short),		\
> +		__unconst_integer_type_cases(int),		\
> +		__unconst_integer_type_cases(long),		\
> +		__unconst_integer_type_cases(long long),	\
> +		default: (x)))

Those are probably more generally useful and belong elsewhere.

> +
> +/*
> + * Do not check the array parameter using __must_be_array().
> + * In the following legit use-case where the "array" passed is a simple pointer,
> + * __must_be_array() will return a failure.
> + * --- 8< ---
> + * int *buff
> + * ...
> + * min = min_array(buff, nb_items);
> + * --- 8< ---

Is that needed in the .h file?

> + *
> + * The first typeof(&(array)[0]) is needed in order to support arrays of both
> + * 'int *buff' and 'int buf[N]' types.
> + *
> + * The array can be an array of const items.
> + * typeof() keeps the const qualifier. Use __unconst_typeof() in order to
> + * discard the const qualifier for the __element variable.
> + */
> +#define __minmax_array(op, array, len) ({				\
> +	typeof(&(array)[0]) __array = (array);				\
> +	typeof(len) __len = (len);					\
> +	__unconst_integer_typeof(__array[0]) __element = __array[--__len]; \

s/__element/__bound/

> +	while (__len--)							\
> +		__element = op(__element, __array[__len]);		\
> +	__element; })

I'm not all sure that all the shenanigans required to use min()
is really needed here.

It would also be generally better to process the array forwards.
So something like:
	typeof (&array[0]) __ptr = array, __limit = array + len;
	typeof (array[0] + 0) __element, __bound = *__ptr++;
	while (ptr < __limit) {
		__element = *__ptr++;
		if (__element > __bound)
			__bound = __element;
	}
	(typeof (array[0]))__bound; })
seems fine to me.
The final cast is there to convert 'int' back to un/signed char|short.
Not really needed and might generate worse code.

But if you insist on using min/max ignore this bit.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

