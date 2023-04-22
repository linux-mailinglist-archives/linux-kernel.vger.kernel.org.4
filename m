Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965576EBA7D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 18:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjDVQwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 12:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjDVQwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 12:52:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C4F192;
        Sat, 22 Apr 2023 09:52:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6344F60C99;
        Sat, 22 Apr 2023 16:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A691C433D2;
        Sat, 22 Apr 2023 16:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682182359;
        bh=USbzMDpWmqLHzS8mB8GSdrvOVhkMDW3xYNC5hT360CE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r61KzvaicstLGxo56lP7QOsEbvIIXPIwEMselHjmn5voL3MdUrl3Ob/pdRJ6KWmpN
         VLE+x7pR3KWNd3VEMu5uUVpF2MwfBJvrtpPNunNVl1o6YAQCKUdF0uLDvFuHSSdJW0
         PEyM08omMZF5/rwWu2vozPw98lymU1xphi9/raiv85FWHKAiA3XGQ34QsEpook7u8A
         IgMKW0oC2jjxfOpanSNIdZ6ujGHmDeBLrk5IJFQBSumbQiPvImvPJdSrr1IdLBPLNA
         LEjZij5GqCp53pqHNxoE5980uTCZaNcLtf4LoH9tPmxBcn2HK/57KvVsNUPrA8U8ly
         XQpRCGmfS2o0g==
Date:   Sat, 22 Apr 2023 18:08:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 4/4] ASoC: codecs: Add support for the generic IIO
 auxiliary devices
Message-ID: <20230422180814.61d24aa3@jic23-huawei>
In-Reply-To: <20230421124122.324820-5-herve.codina@bootlin.com>
References: <20230421124122.324820-1-herve.codina@bootlin.com>
        <20230421124122.324820-5-herve.codina@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 14:41:22 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> Industrial I/O devices can be present in the audio path.
> These devices needs to be used as audio components in order to be fully
> integrated in the audio path.
> 
> This support allows to consider these Industrial I/O devices as auxliary
> audio devices and allows to control them using mixer controls.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Hi Herve,

There are some other IIO devices that might turn up in audio paths. In theory
someone might put an IIO supported amplifier in there (though current ones are
far to high frequency and expensive for that to make sense).  For now it
probably makes sense to support potentiometers as you are doing here,
though I'm guessing that in many cases they would be used with some other
analog components. Does the transfer function matter at all?

Been many years since I last touched anything in ASoC so questions may
be silly ;)

A few comments inline.

Jonathan

> +static int simple_iio_aux_get_volsw(struct snd_kcontrol *kcontrol,
> +				    struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct simple_iio_aux_chan *chan = (struct simple_iio_aux_chan *)kcontrol->private_value;
> +	int max = chan->max;
> +	int min = chan->min;
> +	unsigned int mask = (1 << fls(max)) - 1;

As below. I'm not following reason for use of mask

> +	unsigned int invert = chan->is_inverted;
> +	int ret;
> +	int val;
> +
> +	ret = iio_read_channel_raw(chan->iio_chan, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ucontrol->value.integer.value[0] = (val & mask) - min;
> +	if (invert)
> +		ucontrol->value.integer.value[0] = max - ucontrol->value.integer.value[0];
> +
> +	return 0;
> +}
> +
> +static int simple_iio_aux_put_volsw(struct snd_kcontrol *kcontrol,
> +				    struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct simple_iio_aux_chan *chan = (struct simple_iio_aux_chan *)kcontrol->private_value;
> +	int max = chan->max;
> +	int min = chan->min;
> +	unsigned int mask = (1 << fls(max)) - 1;

Why is mask needed?  Also seems like handling is making
some strong assumptions on form of max and min.
So at minimum some comments on reasoning needed.

> +	unsigned int invert = chan->is_inverted;
> +	int val;
> +	int ret;
> +	int tmp;
> +
> +	val = ucontrol->value.integer.value[0];
> +	if (val < 0)
> +		return -EINVAL;
> +	if (val > max - min)
> +		return -EINVAL;
> +
> +	val = (val + min) & mask;
> +	if (invert)
> +		val = max - val;
> +
> +	ret = iio_read_channel_raw(chan->iio_chan, &tmp);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (tmp == val)
> +		return 0;
> +
> +	ret = iio_write_channel_raw(chan->iio_chan, val);
> +	if (ret)
> +		return ret;
> +
> +	return 1; /* The value changed */
> +}
> +

...



> +static int simple_iio_aux_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct simple_iio_aux_chan *iio_aux_chan;
> +	struct simple_iio_aux *iio_aux;
> +	int count;
> +	u32 tmp;
> +	int ret;
> +	int i;
> +
> +	iio_aux = devm_kzalloc(&pdev->dev, sizeof(*iio_aux), GFP_KERNEL);
> +	if (!iio_aux)
> +		return -ENOMEM;
> +
> +	iio_aux->dev = &pdev->dev;
> +
> +	count = of_property_count_strings(np, "io-channel-names");
> +	if (count < 0) {
> +		dev_err(iio_aux->dev, "%pOF: failed to read io-channel-names\n", np);
> +		return count;
> +	}
> +
> +	iio_aux->chans = devm_kmalloc_array(&pdev->dev, count,
> +					    sizeof(*iio_aux->chans), GFP_KERNEL);
> +	if (!iio_aux->chans)
> +		return -ENOMEM;
> +	iio_aux->num_chans = count;
> +
> +	for (i = 0; i < iio_aux->num_chans; i++) {
> +		iio_aux_chan = iio_aux->chans + i;
> +
> +		ret = of_property_read_string_index(np, "io-channel-names", i,
> +						    &iio_aux_chan->name);

Whilst today this will be tightly couple with of, if you can use generic firmware
handling where possible (from linux/property.h) it will reduce what needs
to be tidied up if anyone fills in the gaps for IIO consumer bindings in ACPI
and then someone uses PRP0001 based ACPI bindings.

> +		if (ret < 0) {
> +			dev_err(iio_aux->dev, "%pOF: failed to read io-channel-names[%d]\n", np, i);

dev_err_probe() would simplify these cases a little.  Not sure on ASOC view on using
that for cases that won't defer.  I tend to take the view it's nicer everywhere
for calls in probe() functions.


> +			return ret;
> +		}
> +
> +		iio_aux_chan->iio_chan = devm_iio_channel_get(iio_aux->dev, iio_aux_chan->name);
> +		if (IS_ERR(iio_aux_chan->iio_chan)) {
> +			ret = PTR_ERR(iio_aux_chan->iio_chan);

Put that inline instead of setting ret here.

> +			return dev_err_probe(iio_aux->dev, ret,
> +					     "get IIO channel '%s' failed (%d)\n",
> +					     iio_aux_chan->name, ret);
> +		}
> +
> +		tmp = 0;
> +		of_property_read_u32_index(np, "invert", i, &tmp);
> +		iio_aux_chan->is_inverted = !!tmp;

As it's a bool this is the same as 
		iio_aux_chan->is_inverted = tmp;

> +	}
> +
> +	platform_set_drvdata(pdev, iio_aux);
> +
> +	return devm_snd_soc_register_component(iio_aux->dev,
> +					       &simple_iio_aux_component_driver,
> +					       NULL, 0);
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id simple_iio_aux_ids[] = {
> +	{ .compatible = "simple-iio-aux", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, simple_iio_aux_ids);
> +#endif
> +
> +static struct platform_driver simple_iio_aux_driver = {
> +	.driver = {
> +		.name = "simple-iio-aux",
> +		.of_match_table = of_match_ptr(simple_iio_aux_ids),

I'd just drop the of_match_ptr()  Whilst this won't work today with other
firmwares, we might enable the missing parts at some stage. Also the
driver is somewhat pointless without DT so I'd just assume it's always
built with it.  Cost is a tiny array on systems with a weird
.config

> +	},
> +	.probe = simple_iio_aux_probe,
> +};
> +
> +module_platform_driver(simple_iio_aux_driver);
> +
> +MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
> +MODULE_DESCRIPTION("IIO ALSA SoC aux driver");
> +MODULE_LICENSE("GPL");

