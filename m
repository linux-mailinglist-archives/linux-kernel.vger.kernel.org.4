Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF6C65C7F7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbjACUSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238039AbjACUSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:18:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CFE2AF8;
        Tue,  3 Jan 2023 12:18:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F982B81101;
        Tue,  3 Jan 2023 20:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D2CC433EF;
        Tue,  3 Jan 2023 20:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672777088;
        bh=aefyPZ3j7hvwG7QeijhHyzMLOESfZrmBbDDV3DnBE8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SeDJIBfBQdHWF4D8+asO8g+zjYRW3ez4WunybsCHniOSdXzojNEdord+O7fSPBLHN
         o8/JoP+nx8C0MDn29nlDrwA9NSiDa+uOHtKDdMdBwrhMvxvM7qKsyG/ErOHq38u6v5
         zBGEG67cwmWqfrobFGesRBY7X/uB3YMVHoU44EPBDS0Oju+ke5Gu4+Q6ITlATIJz77
         bwAjXmjMedUIUa6bZu8dUZud/ApkUiN9fxVWrqqE5/N/7SRYtwBOGXSS0BLAu+EZCq
         PywsppgqVNyW4MEo9Q1K72JRqEkKs7bp5gO7L+GPFzzW3TERIkeiOdiWpRENsjL6lF
         BCUGvWJrq/gmw==
Date:   Tue, 3 Jan 2023 20:17:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     wangweidong.a@awinic.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com,
        povik+lin@cutebit.org, pierre-louis.bossart@linux.intel.com,
        james.schulman@cirrus.com, flatmax@flatmax.com,
        cezary.rojewski@intel.com, srinivas.kandagatla@linaro.org,
        tanureal@opensource.cirrus.com, steve@sk2.org, stephan@gerhold.net,
        zhuning0077@gmail.com, shumingf@realtek.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhaolei@awinic.com,
        liweilei@awinic.com, yijiangtao@awinic.com, duanyibo@awinic.com
Subject: Re: [PATCH V8 1/5] ASoC: codecs: Add i2c and codec registration for
 aw883xx and their associated operation functions
Message-ID: <Y7SNdgU6b5r+YsWK@sirena.org.uk>
References: <20221230093454.190579-1-wangweidong.a@awinic.com>
 <20221230093454.190579-2-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="929h2gIydsuzAm1i"
Content-Disposition: inline
In-Reply-To: <20221230093454.190579-2-wangweidong.a@awinic.com>
X-Cookie: So many men
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--929h2gIydsuzAm1i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 30, 2022 at 05:34:50PM +0800, wangweidong.a@awinic.com wrote:

This looks mostly good, there's a few small nits below but nothing too
huge:

> +++ b/sound/soc/codecs/aw883xx/aw883xx.c
> @@ -0,0 +1,667 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * aw883xx.c --  ALSA SoC AW883XX codec support

Please make the entire comment a C++ one so things look more
intentional.

> +static int aw883xx_startup(struct snd_pcm_substream *substream,
> +			struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *codec = dai->component;
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
> +
> +	mutex_lock(&aw883xx->lock);
> +	aw883xx_start(aw883xx, AW_ASYNC_START);
> +	mutex_unlock(&aw883xx->lock);
> +
> +	return 0;
> +}

I would not expect power management to be done in the startup and
shutdown callbacks, this should be done in set_bias_level() or DAPM like
with other drivers.

> +static int aw883xx_set_fade_in_time(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{

> +	time = ucontrol->value.integer.value[0];
> +
> +	if (time < mc->min || time > mc->max)
> +		return 0;

That's in spec, but it's a bit nicer to return an error so that people
are more likely to notice that their attempt to set a value didn't do
what they asked.

> +static int aw883xx_switch_get(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
> +
> +	ucontrol->value.integer.value[0] = aw883xx->allow_power;
> +
> +	return 0;
> +}

Let the system deal with adding a control that lets the output path be
powered off if that's needed, the driver shouldn't be open coding that -
it's just extra and redundant complexity.  If users do need this then
DAPM is probably a better fit than set_bias_level().

> +	dev_info(aw883xx->aw_pa->dev, "%s : bin load success\n", __func__);

Lower this to a dev_dbg()

> +static void aw883xx_i2c_remove(struct i2c_client *i2c)
> +{
> +	struct aw883xx *aw883xx = i2c_get_clientdata(i2c);
> +
> +	aw883xx_deinit(aw883xx->aw_pa);
> +	snd_soc_unregister_component(&i2c->dev);

I'd expect these to be in the other order, otherwise something could be
using the device while it's partially initialised which probably won't
go well.  Unregistering the component will detach userspace and the card
avoiding that problem.

--929h2gIydsuzAm1i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO0jXUACgkQJNaLcl1U
h9CN2gf/TOQnuPxL2AA3udiB5SD+QAMkx6soCgpSdYQhUmLA1PK1tZOrfxK5q5ci
g/6SdR+XIF/lbO2Yy2q9HP8lYelnmJg0KWZvoY8lCmxWhGsirEenA3fz0ce8mHXl
L/RaWnOIEH1nKo7SW1BSHeJ3hblXaqJ+egDuaJ5Rl+ouUIKVoK9PfuLXTeBoJtRZ
OWpd9fT650Lk0hES7oOFnaFNLOYI9mmE1ir3t0WUioBlqUWhcbo+D2wvAJvG0XzY
Cu5DJ8FfLtws39/PlguaFy0lLCkLGogPG7FuUmlwfLnp5CsY+q09R4WUO9apuYD7
+C/m98h3/y8TIW2EnpDGWxCMKdaWtQ==
=ZN+S
-----END PGP SIGNATURE-----

--929h2gIydsuzAm1i--
