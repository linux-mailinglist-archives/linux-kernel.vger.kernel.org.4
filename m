Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4A573A0F4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjFVMcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFVMcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:32:39 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FFADE;
        Thu, 22 Jun 2023 05:32:37 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687437156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8mMm1b7kxk016SextcassDxegbQZRgmEVemL7uAX+0Y=;
        b=ipp3WrZXrj9HYwIAvfArw2G+hdUR0coeEKL4tVIgdSZ75sIlcMWOvkLQIW2tebHSriqNqT
        MeN90wAwBxTi4nEEGCW5c7+tjn+ddQJz9N5mjO2eTXwRE0c1iKazsyTrPzokSYa7YXej+I
        NHjBh1AZ9d9TRh8mXtuMmnnH5Y/5Oj/iDceVBGw2XC5tCctD4QpQ5M05RokmRf35Vi77Ec
        +vAa+wAOPIEhewjf6jLb8Y3CVIc27kodxUPjErqgkfTIcoqf+zWSmC9o/qagbEdvrSffLz
        hCGlz5rVK0I/mjQkynD+nSV1FlRlfh2Acm0XJ6cm+DwyamcyOjgqMC6W+Q8uVw==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E69971BF206;
        Thu, 22 Jun 2023 12:32:33 +0000 (UTC)
Date:   Thu, 22 Jun 2023 14:32:33 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 07/13] minmax: Introduce {min,max}_array()
Message-ID: <20230622143233.7300a813@bootlin.com>
In-Reply-To: <70697b976107473b8779eea7d6c8a189@AcuMS.aculab.com>
References: <20230615152631.224529-1-herve.codina@bootlin.com>
        <20230615152631.224529-8-herve.codina@bootlin.com>
        <70697b976107473b8779eea7d6c8a189@AcuMS.aculab.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, Andy

On Tue, 20 Jun 2023 11:45:01 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Herve Codina
> > Sent: 15 June 2023 16:26
> > 
> > Introduce min_array() (resp max_array()) in order to get the
> > minimal (resp maximum) of values present in an array.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> >  include/linux/minmax.h | 64 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> > 
> > diff --git a/include/linux/minmax.h b/include/linux/minmax.h
> > index 396df1121bff..1672985b02a3 100644
> > --- a/include/linux/minmax.h
> > +++ b/include/linux/minmax.h
> > @@ -133,6 +133,70 @@
> >   */
> >  #define max_t(type, x, y)	__careful_cmp((type)(x), (type)(y), >)
> > 
> > +/*
> > + * Remove a const qualifier from integer types
> > + * _Generic(foo, type-name: association, ..., default: association) performs a
> > + * comparison against the foo type (not the qualified type).
> > + * Do not use the const keyword in the type-name as it will not match the
> > + * unqualified type of foo.
> > + */
> > +#define __unconst_integer_type_cases(type)	\
> > +	unsigned type:  (unsigned type)0,	\
> > +	signed type:    (signed type)0
> > +
> > +#define __unconst_integer_typeof(x) typeof(			\
> > +	_Generic((x),						\
> > +		char: (char)0,					\
> > +		__unconst_integer_type_cases(char),		\
> > +		__unconst_integer_type_cases(short),		\
> > +		__unconst_integer_type_cases(int),		\
> > +		__unconst_integer_type_cases(long),		\
> > +		__unconst_integer_type_cases(long long),	\
> > +		default: (x)))  
> 
> Those are probably more generally useful and belong elsewhere.

Yes but it is only used here.
It can be move somewhere, in a common place, when necessary.

> 
> > +
> > +/*
> > + * Do not check the array parameter using __must_be_array().
> > + * In the following legit use-case where the "array" passed is a simple pointer,
> > + * __must_be_array() will return a failure.
> > + * --- 8< ---
> > + * int *buff
> > + * ...
> > + * min = min_array(buff, nb_items);
> > + * --- 8< ---  
> 
> Is that needed in the .h file?
> 
> > + *
> > + * The first typeof(&(array)[0]) is needed in order to support arrays of both
> > + * 'int *buff' and 'int buf[N]' types.
> > + *
> > + * The array can be an array of const items.
> > + * typeof() keeps the const qualifier. Use __unconst_typeof() in order to
> > + * discard the const qualifier for the __element variable.
> > + */
> > +#define __minmax_array(op, array, len) ({				\
> > +	typeof(&(array)[0]) __array = (array);				\
> > +	typeof(len) __len = (len);					\
> > +	__unconst_integer_typeof(__array[0]) __element = __array[--__len]; \  
> 
> s/__element/__bound/
> 
> > +	while (__len--)							\
> > +		__element = op(__element, __array[__len]);		\
> > +	__element; })  
> 
> I'm not all sure that all the shenanigans required to use min()
> is really needed here.
> 
> It would also be generally better to process the array forwards.
> So something like:
> 	typeof (&array[0]) __ptr = array, __limit = array + len;
> 	typeof (array[0] + 0) __element, __bound = *__ptr++;
> 	while (ptr < __limit) {
> 		__element = *__ptr++;
> 		if (__element > __bound)
> 			__bound = __element;
> 	}
> 	(typeof (array[0]))__bound; })
> seems fine to me.
> The final cast is there to convert 'int' back to un/signed char|short.
> Not really needed and might generate worse code.
> 
> But if you insist on using min/max ignore this bit.

I didn't plan to change the {min,max}_array() macros in this series as you
suggest.

Maybe min()/max() is too strict but it's a way to be sure about the type
used. Also the current version doesn't need any extra cast to get rid of
the integer promotion as the integer promotion doesn't occur.

Is it ok for you if we keep as it ?

Thanks for your feedback,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
