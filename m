Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640D17244F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjFFNyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjFFNyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:54:12 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3941483;
        Tue,  6 Jun 2023 06:54:09 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686059647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SAhoSqGeAkfXPjkbbMuSr5Vpspi7VqAd/1OCMoVSMQI=;
        b=lFDCNIwYTXXY3EsOHA8kz+XStHjjrzljUTbDoxAtgSr4GJEJYQXHeyrdjEzj457b9yKekc
        yO8KmG7ay0HhebF7nIA1fCRk50oKmItgXzWG2OsMyLli5WDozzodqD5R8UTUAaztRe3TYv
        JQIxBmOlQ81IBhb9zRTEisNVJ+Cq0iZFgtVp2JgUUdXFkXGLNaodXPat6py6ds//t8XpIP
        B0ibMMPLIre1pzHE4nfLEJdOqRtwbXpRQbeaKu0WIPMem+y+ni+shghIj72ST7kI2JLIa/
        2jz7LsM/vBTBKuLk/of+AeYR2hlGmhO8AzkLSZQQ5JPJEdNpi9+JuKqs1Sl/Jg==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 243ADC0010;
        Tue,  6 Jun 2023 13:54:05 +0000 (UTC)
Date:   Tue, 6 Jun 2023 15:54:04 +0200
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
Subject: Re: [PATCH v2 7/9] ASoC: codecs: Add support for the generic IIO
 auxiliary devices
Message-ID: <20230606155404.28ada064@bootlin.com>
In-Reply-To: <ZHuFywIrTnEFpX6e@surfacebook>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
        <20230523151223.109551-8-herve.codina@bootlin.com>
        <ZHuFywIrTnEFpX6e@surfacebook>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Sat, 3 Jun 2023 21:26:19 +0300
andy.shevchenko@gmail.com wrote:

> Tue, May 23, 2023 at 05:12:21PM +0200, Herve Codina kirjoitti:
> > Industrial I/O devices can be present in the audio path.
> > These devices needs to be used as audio components in order to be fully
> > integrated in the audio path.
> > 
> > This support allows to consider these Industrial I/O devices as auxliary
> > audio devices and allows to control them using mixer controls.  
> 
> ...
> 
> > +// audio-iio-aux.c  --  ALSA SoC glue to use IIO devices as audio components  
> 
> Putting file name into file is not a good idea in case the file will be renamed
> in the future.

Indeed, the file name will be removed in the nest iteration.

> 
> ...
> 
> > +struct audio_iio_aux_chan {
> > +	struct iio_channel *iio_chan;
> > +	const char *name;
> > +	bool is_invert_range;  
> 
> If you put bool after int:s it may save a few bytes in some cases.

I will mode is_invert_range after the int members.

> 
> > +	int max;
> > +	int min;  
> 
> Wondering if there is already a data type for the ranges (like linear_range.h,
> but not sure it's applicable here).

Seems not applicable here.
 - IIO does not use linear_range or something similar. It just uses simple int.
 - ASoC does not use linear_range or something similar. It just uses simple long.

So, I keep the simple int min and max.

> 
> > +};  
> 
> ...
> 
> > +	if (val < 0)
> > +		return -EINVAL;
> > +	if (val > max - min)  
> 
> Btw, who will validate that max > min?

By construction,
min = 0
max = iio_read_max_channel_raw() - iio_read_min_channel_raw()

and iio_read_max_channel_raw() returns a value greater or equal to
iio_read_min_channel_raw().

But to be sure, I will check the last asumption at probe() and swap
the minimum and maximum values if needed.

> 
> > +		return -EINVAL;  
> 
> ...
> 
> > +	return 1; /* The value changed */  
> 
> Perhaps this 1 needs a definition?

Yes but to be coherent, in ASoC code, many places need to be changed too
in order to use the newly defined value.
I don't think these modifications should be part of this series.

> 
> ...
> 
> > +static struct snd_soc_dapm_widget widgets[3] = {0};
> > +static struct snd_soc_dapm_route routes[2] = {0};  
> 
> 0:s are not needed. Moreover, the entire assingments are redundant
> as this is guaranteed by the C standard.

Indeed, the 0 assignment will be removed in the next iteration.

> 
> ...
> 
> > +	char *input_name = NULL;
> > +	char *output_name = NULL;
> > +	char *pga_name = NULL;  
> 
> Redundant assignments if you properly label the freeing.

I will rework the error paths (gotos) to avoid these assignement.

> 
> ...
> 
> > +	BUILD_BUG_ON(ARRAY_SIZE(widgets) < 3);  
> 
> Use static_assert() at the place where the array is defined.

Will be done in next iteration.

> 
> ...
> 
> > +	BUILD_BUG_ON(ARRAY_SIZE(routes) < 2);  
> 
> Ditto.
Will be done in next iteration.

> 
> ...
> 
> > +end:  
> 
> out_free:
> 
> > +	/* Allocated names are no more needed (duplicated in ASoC internals) */
> > +	kfree(pga_name);
> > +	kfree(output_name);
> > +	kfree(input_name);
> > +
> > +	return ret;  
> 
> ...
> 
> > +	for (i = 0; i < iio_aux->num_chans; i++) {
> > +		chan = iio_aux->chans + i;
> > +
> > +		ret = iio_read_max_channel_raw(chan->iio_chan, &chan->max);
> > +		if (ret) {
> > +			dev_err(component->dev, "chan[%d] %s: Cannot get max raw value (%d)\n",
> > +				i, chan->name, ret);
> > +			return ret;  
> 
> It sounds like a part of ->probe() flow, correct?
> Can dev_err_probe() be used here?

Will be changed in the next iteration.

> 
> > +		}
> > +
> > +		ret = iio_read_min_channel_raw(chan->iio_chan, &chan->min);
> > +		if (ret) {
> > +			dev_err(component->dev, "chan[%d] %s: Cannot get min raw value (%d)\n",
> > +				i, chan->name, ret);
> > +			return ret;  
> 
> Ditto.

Will be changed in the next iteration.

> 
> > +		}
> > +
> > +		/* Set initial value */
> > +		ret = iio_write_channel_raw(chan->iio_chan,
> > +					    chan->is_invert_range ? chan->max : chan->min);
> > +		if (ret) {
> > +			dev_err(component->dev, "chan[%d] %s: Cannot set initial value (%d)\n",
> > +				i, chan->name, ret);
> > +			return ret;  
> 
> Ditto.

Will be changed in the next iteration.

> 
> > +		}  
> 
> ...
> 
> > +		dev_dbg(component->dev, "chan[%d]: Added %s (min=%d, max=%d, invert=%s)\n",
> > +			i, chan->name, chan->min, chan->max,
> > +			chan->is_invert_range ? "on" : "off");  
> 
> str_on_off()

Indeed, I didn't know str_on_off().
Thanks for pointing.
Will be use in next iteration.

> 
> > +	}  
> 
> ...
> 
> > +	count = of_property_count_strings(np, "io-channel-names");
> > +	if (count < 0) {  
> 
> > +		dev_err(iio_aux->dev, "%pOF: failed to read io-channel-names\n", np);
> > +		return count;  
> 
> 		return dev_err_probe();
Will be changed in next iteration.
> 
> > +	}  
> 
> ...
> 
> > +	for (i = 0; i < iio_aux->num_chans; i++) {
> > +		iio_aux_chan = iio_aux->chans + i;
> > +
> > +		ret = of_property_read_string_index(np, "io-channel-names", i,
> > +						    &iio_aux_chan->name);
> > +		if (ret < 0) {
> > +			dev_err(iio_aux->dev, "%pOF: failed to read io-channel-names[%d]\n", np, i);
> > +			return ret;  
> 
> Ditto.
Will be changed in next iteration.
> 
> > +		}  
> 
> > +		tmp = 0;
> > +		of_property_read_u32_index(np, "snd-control-invert-range", i, &tmp);  
> 
> > +		iio_aux_chan->is_invert_range = tmp;  
> 
> You can use this variable directly.

Not sure, is_invert_range is a bool and tmp is a u32.

In previous iteration, I wrote
  iio_aux_chan->is_invert_range = !!tmp;

> 
> > +	}  
> 
> Btw, can you avoid using OF APIs? It's better to have device property/fwnode
> API to be used from day 1.

Hum, this comment was raised in the previous iteration
  https://lore.kernel.org/linux-kernel/20230501162456.3448c494@jic23-huawei/

I didn't find any equivalent to of_property_read_u32_index() in the 
device_property_read_*() function family.
I mean I did find anything available to get a value from an array using an index.

In the previous iteration it was concluded that keeping OF APIs in this series
seemed "reasonable".

> 
> ...
> 
> > +	platform_set_drvdata(pdev, iio_aux);  
> 
> Which callback is using this driver data?

None -> I will remove platform_set_drvdata().

> 
> ...
> 
> > +static const struct of_device_id audio_iio_aux_ids[] = {
> > +	{ .compatible = "audio-iio-aux", },  
> 
> Inner comma is not needed.

Will be fixed.

> 
> > +	{ }
> > +};  
> 
> ...
> 
> > +static struct platform_driver audio_iio_aux_driver = {
> > +	.driver = {
> > +		.name = "audio-iio-aux",
> > +		.of_match_table = audio_iio_aux_ids,
> > +	},
> > +	.probe = audio_iio_aux_probe,
> > +};  
> 
> > +  
> 
> Redundant blank line

Will be fixed.

> 
> > +module_platform_driver(audio_iio_aux_driver);  
> 



-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
