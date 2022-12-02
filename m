Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEE96406DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbiLBMau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiLBMar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:30:47 -0500
X-Greylist: delayed 359 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Dec 2022 04:30:44 PST
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E846C8D648
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:30:44 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1669983879; bh=DhGdxpJEkjYywcSuSWVbyLC7MtBW/7xgB641h9cKPo4=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=IL4kNpSFC8k/yBhtt9cknfsI2E6UirQsg42bUDsGBfK8kpkUktkO+W+rP+2ILv1fB
         XmTr7UuDGZXD1uNc5DmvPyPPHCTujbiM1DfbpzmH3SLsrsFhG1ydwVW1Y1Wy2BorM8
         RhKQFoGpme26jd+CHWig9w1cloA39sPCcuwkqT04=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] ASoC: tas27{64,70}: fix PM ops ordering
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20221202115855.16483-1-jcalligeros99@gmail.com>
Date:   Fri, 2 Dec 2022 13:24:38 +0100
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        shenghao-ding@ti.com, kevin-lu@ti.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <642B09FF-E7CC-481A-9EC7-88B74FA830CB@cutebit.org>
References: <20221202115855.16483-1-jcalligeros99@gmail.com>
To:     James Calligeros <jcalligeros99@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Copying in some TI addresses which may be interested.)

> On 2. 12. 2022, at 12:58, James Calligeros <jcalligeros99@gmail.com> =
wrote:
>=20
> On both tas2764 and tas2770, a write to PWR_CTRL is attempted
> on resume before syncing the regcache to the chip, potentially leaving
> it in an undefined state that causes resume to fail. The codec
> is then unavailable until the next system reset.

I think we need to split this into separate tas2764 and tas2770 changes.
So, concentrating on tas2764 first:

The issue here isn=E2=80=99t that a write is attempted before the device =
is synced
and while the regcache is in cache-only state. That=E2=80=99s on its own =
OK.
The issue here is that all registers including PWR_CTRL are restored in
one go, and that can cause issues since we need the device properly
configured before raising its power state.

> On tas2770 specifically, both suspend and resume ops attempt useless
> register writes on unrestored registers. This causes its state to be
> desynchronised from what ASoC expects it to be in.
>=20
> These two codecs are almost identical, so unify their behaviour
> and reorder the ops so that the codec is always suspended and
> resumed in a known/expected state.

I suggest we make the first commit fix up tas2764 suspend/resume
code to a state that=E2=80=99s OK, then second commit copies that over
to tas2770 to replace what=E2=80=99s there now. (Pointing out some of =
the
things that=E2=80=99s wrong with the old code.)

> Suggested-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
> ---
> sound/soc/codecs/tas2764.c | 11 +++++++----
> sound/soc/codecs/tas2770.c | 40 ++++++++++++++++++++------------------
> 2 files changed, 28 insertions(+), 23 deletions(-)
>=20
> diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
> index 2e0ed3e68fa5..51c6b3a940c4 100644
> --- a/sound/soc/codecs/tas2764.c
> +++ b/sound/soc/codecs/tas2764.c
> @@ -32,7 +32,7 @@ struct tas2764_priv {
> 	struct regmap *regmap;
> 	struct device *dev;
> 	int irq;
> -=09
> +

Stray whiteline change here

> 	int v_sense_slot;
> 	int i_sense_slot;
>=20
> @@ -157,14 +157,17 @@ static int tas2764_codec_resume(struct =
snd_soc_component *component)
> 		usleep_range(1000, 2000);
> 	}
>=20
> -	ret =3D tas2764_update_pwr_ctrl(tas2764);
> +	regcache_cache_only(tas2764->regmap, false);
>=20
> +	ret =3D regcache_sync(tas2764->regmap);
> 	if (ret < 0)
> 		return ret;
>=20
> -	regcache_cache_only(tas2764->regmap, false);
> +	ret =3D tas2764_update_pwr_ctrl(tas2764);
> +	if (ret < 0)
> +		return ret;
>=20
> -	return regcache_sync(tas2764->regmap);
> +	return 0;
> }
> #else
> #define tas2764_codec_suspend NULL
> diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
> index 8557759acb1f..5c9e8419b387 100644
> --- a/sound/soc/codecs/tas2770.c
> +++ b/sound/soc/codecs/tas2770.c
> @@ -72,25 +72,21 @@ static int tas2770_codec_suspend(struct =
snd_soc_component *component)
> 	struct tas2770_priv *tas2770 =3D =
snd_soc_component_get_drvdata(component);
> 	int ret =3D 0;
>=20
> +	ret =3D snd_soc_component_update_bits(component, =
TAS2770_PWR_CTRL,
> +						TAS2770_PWR_CTRL_MASK,
> +						=
TAS2770_PWR_CTRL_SHUTDOWN);
> +
> +	if (ret < 0)
> +		return ret;
> +
> 	regcache_cache_only(tas2770->regmap, true);
> -	regcache_mark_dirty(tas2770->regmap);
> +	regcache_sync(tas2770->regmap);
>=20
> -	if (tas2770->sdz_gpio) {
> +	if (tas2770->sdz_gpio)
> 		gpiod_set_value_cansleep(tas2770->sdz_gpio, 0);
> -	} else {
> -		ret =3D snd_soc_component_update_bits(component, =
TAS2770_PWR_CTRL,
> -						    =
TAS2770_PWR_CTRL_MASK,
> -						    =
TAS2770_PWR_CTRL_SHUTDOWN);
> -		if (ret < 0) {
> -			regcache_cache_only(tas2770->regmap, false);
> -			regcache_sync(tas2770->regmap);
> -			return ret;
> -		}
>=20
> -		ret =3D 0;
> -	}
>=20
> -	return ret;
> +	return 0;
> }
>=20
> static int tas2770_codec_resume(struct snd_soc_component *component)
> @@ -98,18 +94,24 @@ static int tas2770_codec_resume(struct =
snd_soc_component *component)
> 	struct tas2770_priv *tas2770 =3D =
snd_soc_component_get_drvdata(component);
> 	int ret;
>=20
> +
> 	if (tas2770->sdz_gpio) {
> 		gpiod_set_value_cansleep(tas2770->sdz_gpio, 1);
> 		usleep_range(1000, 2000);
> -	} else {
> -		ret =3D tas2770_update_pwr_ctrl(tas2770);
> -		if (ret < 0)
> -			return ret;
> 	}
>=20
> 	regcache_cache_only(tas2770->regmap, false);
>=20
> -	return regcache_sync(tas2770->regmap);
> +	ret =3D regcache_sync(tas2770->regmap);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D tas2770_update_pwr_ctrl(tas2770);
> +	if (ret < 0)
> +		return ret;
> +
> +
> +	return 0;
> }
> #else
> #define tas2770_codec_suspend NULL
> --=20
> 2.38.1
>=20

