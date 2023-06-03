Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAA972118A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 20:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjFCS0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 14:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjFCS0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 14:26:35 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1A8C2
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 11:26:33 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 228430b1-023c-11ee-abf4-005056bdd08f;
        Sat, 03 Jun 2023 21:26:20 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 21:26:19 +0300
To:     Herve Codina <herve.codina@bootlin.com>
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
Message-ID: <ZHuFywIrTnEFpX6e@surfacebook>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
 <20230523151223.109551-8-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523151223.109551-8-herve.codina@bootlin.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, May 23, 2023 at 05:12:21PM +0200, Herve Codina kirjoitti:
> Industrial I/O devices can be present in the audio path.
> These devices needs to be used as audio components in order to be fully
> integrated in the audio path.
> 
> This support allows to consider these Industrial I/O devices as auxliary
> audio devices and allows to control them using mixer controls.

...

> +// audio-iio-aux.c  --  ALSA SoC glue to use IIO devices as audio components

Putting file name into file is not a good idea in case the file will be renamed
in the future.

...

> +struct audio_iio_aux_chan {
> +	struct iio_channel *iio_chan;
> +	const char *name;
> +	bool is_invert_range;

If you put bool after int:s it may save a few bytes in some cases.

> +	int max;
> +	int min;

Wondering if there is already a data type for the ranges (like linear_range.h,
but not sure it's applicable here).

> +};

...

> +	if (val < 0)
> +		return -EINVAL;
> +	if (val > max - min)

Btw, who will validate that max > min?

> +		return -EINVAL;

...

> +	return 1; /* The value changed */

Perhaps this 1 needs a definition?

...

> +static struct snd_soc_dapm_widget widgets[3] = {0};
> +static struct snd_soc_dapm_route routes[2] = {0};

0:s are not needed. Moreover, the entire assingments are redundant
as this is guaranteed by the C standard.

...

> +	char *input_name = NULL;
> +	char *output_name = NULL;
> +	char *pga_name = NULL;

Redundant assignments if you properly label the freeing.

...

> +	BUILD_BUG_ON(ARRAY_SIZE(widgets) < 3);

Use static_assert() at the place where the array is defined.

...

> +	BUILD_BUG_ON(ARRAY_SIZE(routes) < 2);

Ditto.

...

> +end:

out_free:

> +	/* Allocated names are no more needed (duplicated in ASoC internals) */
> +	kfree(pga_name);
> +	kfree(output_name);
> +	kfree(input_name);
> +
> +	return ret;

...

> +	for (i = 0; i < iio_aux->num_chans; i++) {
> +		chan = iio_aux->chans + i;
> +
> +		ret = iio_read_max_channel_raw(chan->iio_chan, &chan->max);
> +		if (ret) {
> +			dev_err(component->dev, "chan[%d] %s: Cannot get max raw value (%d)\n",
> +				i, chan->name, ret);
> +			return ret;

It sounds like a part of ->probe() flow, correct?
Can dev_err_probe() be used here?

> +		}
> +
> +		ret = iio_read_min_channel_raw(chan->iio_chan, &chan->min);
> +		if (ret) {
> +			dev_err(component->dev, "chan[%d] %s: Cannot get min raw value (%d)\n",
> +				i, chan->name, ret);
> +			return ret;

Ditto.

> +		}
> +
> +		/* Set initial value */
> +		ret = iio_write_channel_raw(chan->iio_chan,
> +					    chan->is_invert_range ? chan->max : chan->min);
> +		if (ret) {
> +			dev_err(component->dev, "chan[%d] %s: Cannot set initial value (%d)\n",
> +				i, chan->name, ret);
> +			return ret;

Ditto.

> +		}

...

> +		dev_dbg(component->dev, "chan[%d]: Added %s (min=%d, max=%d, invert=%s)\n",
> +			i, chan->name, chan->min, chan->max,
> +			chan->is_invert_range ? "on" : "off");

str_on_off()

> +	}

...

> +	count = of_property_count_strings(np, "io-channel-names");
> +	if (count < 0) {

> +		dev_err(iio_aux->dev, "%pOF: failed to read io-channel-names\n", np);
> +		return count;

		return dev_err_probe();

> +	}

...

> +	for (i = 0; i < iio_aux->num_chans; i++) {
> +		iio_aux_chan = iio_aux->chans + i;
> +
> +		ret = of_property_read_string_index(np, "io-channel-names", i,
> +						    &iio_aux_chan->name);
> +		if (ret < 0) {
> +			dev_err(iio_aux->dev, "%pOF: failed to read io-channel-names[%d]\n", np, i);
> +			return ret;

Ditto.

> +		}

> +		tmp = 0;
> +		of_property_read_u32_index(np, "snd-control-invert-range", i, &tmp);

> +		iio_aux_chan->is_invert_range = tmp;

You can use this variable directly.

> +	}

Btw, can you avoid using OF APIs? It's better to have device property/fwnode
API to be used from day 1.

...

> +	platform_set_drvdata(pdev, iio_aux);

Which callback is using this driver data?

...

> +static const struct of_device_id audio_iio_aux_ids[] = {
> +	{ .compatible = "audio-iio-aux", },

Inner comma is not needed.

> +	{ }
> +};

...

> +static struct platform_driver audio_iio_aux_driver = {
> +	.driver = {
> +		.name = "audio-iio-aux",
> +		.of_match_table = audio_iio_aux_ids,
> +	},
> +	.probe = audio_iio_aux_probe,
> +};

> +

Redundant blank line

> +module_platform_driver(audio_iio_aux_driver);

-- 
With Best Regards,
Andy Shevchenko


