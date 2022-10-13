Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCD55FD8B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiJMMBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJMMA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:00:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399265C9EA;
        Thu, 13 Oct 2022 05:00:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD7F261789;
        Thu, 13 Oct 2022 12:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1ADC433B5;
        Thu, 13 Oct 2022 12:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665662455;
        bh=+FCy9IpzXmx7uHtC4ADYUS2asoMbszf5dCx25y+DTvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=avM1qtvVrCgJBog2hWrTT8iYRENiXteug4Qx4h0lBouKxxaD1c3FUguc79DwjLLp7
         ml3PLpHoilngfJ0oiy3p+j+reVoSGzBJF5qCciAbBHwk9aCRzQr/awfopOLRUyLWEl
         R3C40mtr83LYIezuxhbeNTcEq6mFCX1jgL51NiQJqbj3JIyxkFJeGYyAeCizC8PM21
         0lubI6T0Y73jKXOsK+JPzYB3NtzieuEjbyocFFD8m1EF5DdOKy+OJuN6OcxvyNh1c/
         OBJZqBWrOQGX7iW4Gx9dCqZLfUILt48DcZew/YCcnXIWuSsjS1hOarWy92Ng1138zQ
         MAUJpQFkOkUiQ==
Date:   Thu, 13 Oct 2022 13:00:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jeff Chang <richtek.jeff.chang@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, jeff_chang@ricthek.com,
        Jeff <jeff_chang@richtek.com>
Subject: Re: [PATCH] ASoC: Add Richtek RT5512 Speaker Amp Driver
Message-ID: <Y0f98d0A04f8dzQV@sirena.org.uk>
References: <20221013080643.6509-1-richtek.jeff.chang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EXtVRUMqXconVGNq"
Content-Disposition: inline
In-Reply-To: <20221013080643.6509-1-richtek.jeff.chang@gmail.com>
X-Cookie: Do you like "TENDER VITTLES"?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EXtVRUMqXconVGNq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 13, 2022 at 04:06:43PM +0800, Jeff Chang wrote:
> From: Jeff <jeff_chang@richtek.com>
>=20
> The RT5512 is a boosted class-D amplifier with V/I sensing.
> A built-in DC-DC step-up converter is used to provide efficient power for
> class-D amplifier with multi-level class-H operation. The digital audio

There's a few issues to clean up here but they're mostly stylistic for
the upstream kernel rather than major structural things I think.

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/richtek,rt5512.yaml

The DT bindings seem fine but normally they'd be sent as a separate
patch so it's easier for the DT reviewers to find them.

> +config SND_SOC_RT5512
> +	tristate "Mediatek RT5512 speaker amplifier"

Looks like there's some Richtek/Mediatek branding confusion with this -
it's a bit unclear.  It's all the same company in the end I guess so it
doesn't matter.

> @@ -0,0 +1,860 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 Mediatek Inc.
> + */

Please make the entire comment a C++ one so things look more
intentional.

> +static int rt5512_codec_dac_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *component =3D
> +		snd_soc_dapm_to_component(w->dapm);
> +	int ret =3D 0;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		/* un-mute */
> +		ret =3D snd_soc_component_update_bits(component, 0x03, 0x0002, 0);
> +		break;

I'm not seeing what turns the mute on?  I'm also not loving all the
magic numbers in code here, these don't look like things that I'd expect
to be undocumented and it's an issue through the code.

> +						     0xf9fc);
> +		mdelay(11);
> +
> +		dev_info(component->dev, "%s rt5512 update bst mode %d\n",
> +			 __func__, chip->bst_mode);

All these dev_info() prints during normal operation are going to be way
too noisy, at most they should be dev_dbg().

> +static int rt5512_set_bstmode(struct snd_kcontrol *kcontrol,
> +			      struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component =3D
> +		snd_soc_kcontrol_component(kcontrol);
> +	struct rt5512_chip *chip =3D snd_soc_component_get_drvdata(component);
> +	int ret =3D 0;
> +
> +	chip->bst_mode =3D ucontrol->value.integer.value[0];
> +	dev_info(component->dev, "%s, bst_mode =3D %d\n", __func__,
> +		 chip->bst_mode);
> +	return ret;
> +}

You should run the ALSA kselftests on a system with this driver loaded -
this should tell you that the driver needs to return a 1 when the value
is changed so that events are generated and will also identify a bunch
of other issues.

I'd also expect to see some validation of the value set, I'm guessing
that there's only a limited set of modes?

> +static int rt5512_codec_put_istcbypass(struct snd_kcontrol *kcontrol,
> +				       struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component =3D
> +		snd_soc_kcontrol_component(kcontrol);
> +	int ret;
> +
> +	pm_runtime_get_sync(component->dev);
> +	if (ucontrol->value.integer.value[0]) {
> +		ret =3D snd_soc_component_update_bits(component,
> +						    RT5512_REG_PATH_BYPASS,
> +						    0x0004, 0x0004);
> +	} else {
> +		ret =3D snd_soc_component_update_bits(component,
> +						    RT5512_REG_PATH_BYPASS,
> +						    0x0004, 0x0000);
> +	}
> +	if (ret)
> +		dev_err(component->dev, "%s set CC Max Failed\n", __func__);
> +	pm_runtime_put_sync(component->dev);
> +	return ret;
> +}

Why is this a custom control?  It looks like a normal mux.

> +static int rt5512_codec_put_volsw(struct snd_kcontrol *kcontrol,
> +				  struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component =3D
> +		snd_soc_kcontrol_component(kcontrol);
> +	int  put_ret =3D 0;
> +
> +	pm_runtime_get_sync(component->dev);
> +	put_ret =3D snd_soc_put_volsw(kcontrol, ucontrol);
> +	if (put_ret < 0)
> +		dev_err(component->dev, "%s put volsw fail\n", __func__);
> +	pm_runtime_put_sync(component->dev);
> +	return put_ret;
> +}

Same here.  The runtime PM stuff here and in all the controls looks
wasteful as well, why would you need to power up the device here?

> +static const DECLARE_TLV_DB_SCALE(vol_ctl_tlv, -1155, 5, 0);
> +static const struct snd_kcontrol_new rt5512_component_snd_controls[] =3D=
 {
> +	SOC_SINGLE_EXT_TLV("Volume_Ctrl", RT5512_REG_VOL_CTRL, 0, 255,
> +			   1, rt5512_codec_get_volsw, rt5512_codec_put_volsw,
> +			   vol_ctl_tlv),

Volume controls should end in Volume as per control-names.rst, most of
the controls here don't seem to follow the ALSA naming coventions at all.

> +static int rt5512_component_setting(struct snd_soc_component *component)
> +{
> +	struct rt5512_chip *chip =3D snd_soc_component_get_drvdata(component);
> +	int ret =3D 0;
> +
> +	ret =3D snd_soc_component_read(component, 0x4d);
> +	if (ret < 0)
> +		return -EIO;
> +	chip->ff_gain =3D ret;
> +	if (chip->chip_rev =3D=3D RT5512_REV_A) {

It would be more idiomatic to do a switch statement here.

> +	.idle_bias_on =3D false,

No need to explicitly set things to false, that's the defualt for
statics.

> +	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> +		dev_info(dai->dev, "format: 0x%08x, rate: 0x%08x, word_len: %d, aud_bi=
t: %d\n",
> +			 params_format(hw_params), params_rate(hw_params), word_len,
> +			 aud_bit);
> +	if (word_len > 32 || word_len < 16) {
> +		dev_err(dai->dev, "not supported word length\n");
> +		return -ENOTSUPP;
> +	}

This could use some blank lines between blocks (as could a lot of the
rest), and it's not clear why there's a check for playback here
(especially not without reporting an error).

> +static int rt5512_component_aif_hw_free(struct snd_pcm_substream *substr=
eam,
> +				    struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_dapm_context *dapm =3D
> +				snd_soc_component_get_dapm(dai->component);
> +	int ret =3D 0;
> +	char *tmp =3D "SPK";
> +
> +	if (substream->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE)
> +		return 0;
> +	dev_info(dai->dev, "%s successfully start\n", __func__);
> +
> +	ret =3D snd_soc_dapm_disable_pin(dapm, tmp);
> +	if (ret < 0)
> +		return ret;
> +	return snd_soc_dapm_sync(dapm);

The driver should be doing no DAPM management in PCM operations, the
core will manage DAPM for the PCM itself.

> +static inline int _rt5512_chip_sw_reset(struct rt5512_chip *chip)
> +{
> +	int ret;
> +	u8 data[2] =3D {0x00, 0x00};
> +	u8 reg_data[2] =3D {0x00, 0x80};
> +
> +	/* turn on main pll first, then trigger reset */
> +	ret =3D i2c_smbus_write_i2c_block_data(chip->i2c, RT5512_REG_SYSTEM_CTR=
L,
> +					     2, data);
> +	if (ret < 0)
> +		return ret;

Why is this bypassing regmap?

> +	chip->chip_rev =3D id[1];
> +	if (chip->chip_rev !=3D RT5512_REV_A && chip->chip_rev !=3D RT5512_REV_=
B) {
> +		dev_err(chip->dev, "%s chip rev not match, rev =3D %d\n",
> +			__func__, chip->chip_rev);
> +		return -ENODEV;
> +	}

Use a switch statement for exensibility here.

> +static inline int rt5512_component_register(struct rt5512_chip *chip)
> +{
> +	return devm_snd_soc_register_component(chip->dev,
> +					       &rt5512_component_driver,
> +					       rt5512_codec_dai,
> +					       ARRAY_SIZE(rt5512_codec_dai));
> +}

This may as well just be inlined.

> +	/* register qos to prevent deep idle during transfer */
> +	cpu_latency_qos_add_request(&chip->rt5512_qos_request,
> +				    PM_QOS_DEFAULT_VALUE);

This looks like it's trying to work around some bug in the I2C
controller driver perhaps?  In any case it needs a lot more explanation
if it's sensible to have in a CODEC driver, there's nothing unusual here.

> +	ret =3D rt5512_component_register(chip);
> +	if (!ret) {
> +		pm_runtime_set_active(chip->dev);
> +		pm_runtime_enable(chip->dev);
> +	}

The driver uses runtime PM operations so you should enable runtime PM
before registering the component, it might be used immediately.

--EXtVRUMqXconVGNq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNH/fAACgkQJNaLcl1U
h9DvAgf/XLUWD3Br2PBnK1JqEZo/j7NBqiVlaRir3GZFW2v/ypVjMVTnPYPcLKyR
RTfpEDY7liwQKeV12mL4eGKGgtm3dItwriVOSxYs7853H3327Vzo/D6cXC9dingu
0ByeJrIcTdjP5bRrx647MEMbxQCh8ntjTKThwO9l0HK8jwBDZv6KxHWcf5cFE5EI
J//UrFVNZN2IEtwle6F6Mp/ivtF9pxNp8fVapFMRQ6yluLQOwv5GbUCt625En8Fv
PT6arOkrQrsNsaof32v/8ByInyihojxZDJc9DxSk5NJ92qQQmQZo2zMKtouqKWR1
jukWTr6LvmJfnwr9pm9EAGHph5gaoQ==
=1cIs
-----END PGP SIGNATURE-----

--EXtVRUMqXconVGNq--
