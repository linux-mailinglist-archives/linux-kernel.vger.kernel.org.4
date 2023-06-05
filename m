Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12264721FF9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjFEHrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjFEHqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:46:47 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291DABD;
        Mon,  5 Jun 2023 00:46:43 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685951201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SlBav5nmnLSs3742Oa+RNb+C2ZOGfMv2RNAb/qlmli0=;
        b=oKYSHjATjHe/mpW5BUc7jaaWak/2Cl2sDlR/4Ife5K5BaNWsG9z9+auIvUR1zSXAwn0Rlb
        RSfKmu9pNwmD5wO9asXH57ydw3X6eihak9sl3swCRPRJEAvx9jARuGhEZAIwIAYP+6M4JP
        HRs5zrys2q1PS+q4WZsJN02PIB3NvPC8UMQsIC6vWg5DBlkBkEGDnv8iTcaUctTKKPb52y
        egmdoFHIco10kAUYMkDMRWv9WGZRdMzw3DmPBTZ2ACB1C47iy0c7JP+ZCMFUk+rMk81ZLO
        zfcdFiV0S46qH/TM/he8icXthfqHhVEqBot6X6KuVNG/Km5DXXLmR1JB189f9A==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6B4982000D;
        Mon,  5 Jun 2023 07:46:38 +0000 (UTC)
Date:   Mon, 5 Jun 2023 09:46:37 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     andy.shevchenko@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 5/9] iio: inkern: Add a helper to query an available
 minimum raw value
Message-ID: <20230605094637.7615b689@bootlin.com>
In-Reply-To: <ZHtIdTZbULl6t4RT@surfacebook>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
        <20230523151223.109551-6-herve.codina@bootlin.com>
        <ZHtIdTZbULl6t4RT@surfacebook>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jun 2023 17:04:37 +0300
andy.shevchenko@gmail.com wrote:

> Tue, May 23, 2023 at 05:12:19PM +0200, Herve Codina kirjoitti:
> > A helper, iio_read_max_channel_raw() exists to read the available
> > maximum raw value of a channel but nothing similar exists to read the
> > available minimum raw value.
> > 
> > This new helper, iio_read_min_channel_raw(), fills the hole and can be
> > used for reading the available minimum raw value of a channel.
> > It is fully based on the existing iio_read_max_channel_raw().  
> 
> ...
> 
> > +static int iio_channel_read_min(struct iio_channel *chan,
> > +				int *val, int *val2, int *type,
> > +				enum iio_chan_info_enum info)
> > +{
> > +	int unused;
> > +	const int *vals;
> > +	int length;
> > +	int ret;  
> 
> > +	if (!val2)
> > +		val2 = &unused;  
> 
> It's a single place, where this is used, can you move it there?

I will do that in the next iteration.
Also, I will do the same modification in iio_channel_read_max() as it has
exactly the same code.

> 
> > +	ret = iio_channel_read_avail(chan, &vals, type, &length, info);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	switch (ret) {
> > +	case IIO_AVAIL_RANGE:
> > +		switch (*type) {
> > +		case IIO_VAL_INT:
> > +			*val = vals[0];
> > +			break;
> > +		default:
> > +			*val = vals[0];
> > +			*val2 = vals[1];
> > +		}
> > +		return 0;
> > +
> > +	case IIO_AVAIL_LIST:
> > +		if (length <= 0)
> > +			return -EINVAL;
> > +		switch (*type) {
> > +		case IIO_VAL_INT:
> > +			*val = vals[--length];  
> 
> > +			while (length) {  
> 
> 			while (length--) {
> 
> will do the job and at the same time...
> 
> 
> > +				if (vals[--length] < *val)
> > +					*val = vals[length];  
> 
> ...this construction becomes less confusing (easier to parse).

Indeed, I will change in the next iteration.

> 
> > +			}
> > +			break;
> > +		default:
> > +			/* FIXME: learn about min for other iio values */  
> 
> I believe in a final version this comment won't be here.

We have the same FIXME comment in the iio_channel_read_max() function I
copied to create this iio_channel_read_min() and, to be honest, I
don't really know how to handle these other cases.

In this series, I would prefer to keep this FIXME.

> 
> > +			return -EINVAL;
> > +		}
> > +		return 0;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}  
> 

Thanks for the review,
Hervé
