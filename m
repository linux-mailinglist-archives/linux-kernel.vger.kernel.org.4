Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6FA7342D8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346387AbjFQSBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjFQSBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:01:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C7A1729;
        Sat, 17 Jun 2023 11:01:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3B4B61041;
        Sat, 17 Jun 2023 18:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7239DC433C0;
        Sat, 17 Jun 2023 18:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687024894;
        bh=RERf5RbZg+WAAGOHyyxJF20kJeK52BhhW35kQfeQM6A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=naqtaYMtiG5Uj7Vcbfv5sFoudBw/ld7Tbza9e3k0Dm/mu0TFQTeFwwLOi5X4neHZK
         /oUtLmYcSs9tVImqb2mepYCsGWcrp4ecdegIft6Lot0hW1FBGd80W7W4OigegE+hnH
         2BzNqbzmpDWcjEQlTfLzayMrraXefq8eYb+5kLSFBFMKYjWdpfboJrwyfKUXndVWTN
         TpY62tY3WHS0bOfK8PXcP4KrHdNg+np5G2hRKdhgshbRk3CqPbZQ66R2nnA0Qw+gt+
         Ff5WO+rqV2wykkDcWOCBr5uEK4+3Ho4/o5tEvIQ4HM/d6ARMGZFcQv//KHcvGVYfCN
         yQiWsQiRcX7ZA==
Date:   Sat, 17 Jun 2023 19:01:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 12/13] ASoC: codecs: Add support for the generic IIO
 auxiliary devices
Message-ID: <20230617190125.147434b9@jic23-huawei>
In-Reply-To: <20230615152631.224529-13-herve.codina@bootlin.com>
References: <20230615152631.224529-1-herve.codina@bootlin.com>
        <20230615152631.224529-13-herve.codina@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 17:26:30 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> Industrial I/O devices can be present in the audio path.
> These devices needs to be used as audio components in order to be
> fully integrated in the audio path.
> 
> This support allows to consider these Industrial I/O devices as
> auxiliary audio devices and allows one to control them using mixer
> controls.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

A few trivial things inline.
With those tidied up, (for the IIO bits and general code - but I don't know
the snd part well enough to review that).

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> index 000000000000..b9d72cbb85f2
> --- /dev/null
> +++ b/sound/soc/codecs/audio-iio-aux.c
> @@ -0,0 +1,338 @@

...

> +static int audio_iio_aux_add_controls(struct snd_soc_component *component,
> +				      struct audio_iio_aux_chan *chan)
> +{
> +	struct snd_kcontrol_new control = {};

Why not:

	struct snd_kcontrol_new control = {
		.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
		.name = chan->name;
		.info = audio_iio_aux_info_volsw;
		.get = audio_iio_aux_get_volsw;
		.put = audio_iio_aux_put_volsw;
		.private_value = (unsigned long)chan;
	};

> +
> +	control.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
> +	control.name = chan->name;
> +	control.info = audio_iio_aux_info_volsw;
> +	control.get = audio_iio_aux_get_volsw;
> +	control.put = audio_iio_aux_put_volsw;
> +	control.private_value = (unsigned long)chan;
> +
> +	return snd_soc_add_component_controls(component, &control, 1);
> +}
> +
> +/*
> + * These data could be on stack but they are pretty big.
> + * As ASoC internally copy them and protect them against concurrent accesses
> + * (snd_soc_bind_card() protects using client_mutex), keep them in the global
> + * data area.
> + */
> +static struct snd_soc_dapm_widget widgets[3];
> +static struct snd_soc_dapm_route routes[2];
> +
> +/* Be sure sizes are correct (need 3 widgets and 2 routes) */
> +static_assert(ARRAY_SIZE(widgets) >= 3, "3 widgets are needed");
> +static_assert(ARRAY_SIZE(routes) >= 2, "2 routes are needed");
> +
> +static int audio_iio_aux_add_dapms(struct snd_soc_component *component,
> +				   struct audio_iio_aux_chan *chan)
> +{
> +	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
> +	char *output_name;
> +	char *input_name;
> +	char *pga_name;
> +	int ret;
> +
> +	input_name = kasprintf(GFP_KERNEL, "%s IN", chan->name);
> +	if (!input_name)
> +		return -ENOMEM;
> +
> +	output_name = kasprintf(GFP_KERNEL, "%s OUT", chan->name);
> +	if (!output_name) {
> +		ret = -ENOMEM;
> +		goto out_free_input_name;
> +	}

Trivial but a blank line here would be nice.

> +	pga_name = kasprintf(GFP_KERNEL, "%s PGA", chan->name);
> +	if (!pga_name) {
> +		ret = -ENOMEM;
> +		goto out_free_output_name;
> +	}
> +
> +	widgets[0] = SND_SOC_DAPM_INPUT(input_name);
> +	widgets[1] = SND_SOC_DAPM_OUTPUT(output_name);
> +	widgets[2] = SND_SOC_DAPM_PGA(pga_name, SND_SOC_NOPM, 0, 0, NULL, 0);
> +	ret = snd_soc_dapm_new_controls(dapm, widgets, 3);
> +	if (ret)
> +		goto out_free_pga_name;
> +
> +	routes[0].sink = pga_name;
> +	routes[0].control = NULL;
> +	routes[0].source = input_name;
> +	routes[1].sink = output_name;
> +	routes[1].control = NULL;
> +	routes[1].source = pga_name;
> +	ret = snd_soc_dapm_add_routes(dapm, routes, 2);
> +
> +	/* Allocated names are no more needed (duplicated in ASoC internals) */
> +
> +out_free_pga_name:
> +	kfree(pga_name);
> +out_free_output_name:
> +	kfree(output_name);
> +out_free_input_name:
> +	kfree(input_name);
> +	return ret;
> +}
> +
> +static int audio_iio_aux_component_probe(struct snd_soc_component *component)
> +{
> +	struct audio_iio_aux *iio_aux = snd_soc_component_get_drvdata(component);
> +	struct audio_iio_aux_chan *chan;
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < iio_aux->num_chans; i++) {
> +		chan = iio_aux->chans + i;
> +
> +		ret = iio_read_max_channel_raw(chan->iio_chan, &chan->max);
> +		if (ret)
> +			return dev_err_probe(component->dev, ret,
> +					     "chan[%d] %s: Cannot get max raw value\n",
> +					     i, chan->name);
> +
> +		ret = iio_read_min_channel_raw(chan->iio_chan, &chan->min);
> +		if (ret)
> +			return dev_err_probe(component->dev, ret,
> +					     "chan[%d] %s: Cannot get min raw value\n",
> +					     i, chan->name);
> +
> +		if (chan->min > chan->max) {
> +			dev_dbg(component->dev, "chan[%d] %s: Swap min and max\n",
> +				i, chan->name);

Why?  I'd like a comment here on what circumstances could cause this to happen.

> +			swap(chan->min, chan->max);
> +		}
> +
> +		/* Set initial value */
> +		ret = iio_write_channel_raw(chan->iio_chan,
> +					    chan->is_invert_range ? chan->max : chan->min);
> +		if (ret)
> +			return dev_err_probe(component->dev, ret,
> +					     "chan[%d] %s: Cannot set initial value\n",
> +					     i, chan->name);
> +
> +		ret = audio_iio_aux_add_controls(component, chan);
> +		if (ret)
> +			return ret;
> +
> +		ret = audio_iio_aux_add_dapms(component, chan);
> +		if (ret)
> +			return ret;
> +
> +		dev_dbg(component->dev, "chan[%d]: Added %s (min=%d, max=%d, invert=%s)\n",
> +			i, chan->name, chan->min, chan->max,
> +			str_on_off(chan->is_invert_range));
> +	}
> +
> +	return 0;
> +}

