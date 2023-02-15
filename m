Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BD4697CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbjBONKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbjBONK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:10:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9553A87
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 05:10:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A90161B8F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2A3C433EF;
        Wed, 15 Feb 2023 13:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676466626;
        bh=yGMYIvD8L9/V5mZqDcVK02ng1QBdRoo8WXJJ/Bb9AdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DYcnaAa+6SCgfyMXq8QIFDIjLUEJPmSRvyIscrjRNf7ZFZ/1wz4ftUzyAjOloE26f
         Ihqj8lUZ6Erj4DtEbXanrGzb2cjOBZYKyrR6OmoVwXkr/e/6wl476U1lLxyHqkly4t
         BRLGr+6058RbjMlsea0OMFAckTTvKEALuc/CxVKpsnRRZvOa50cY5B8g8fuF/fj+uQ
         NBOWXsYXOrMTV51gYSHB4xmDXpkW9df1Ndv+8uAswW7yxCUQkRDK4WMh1fEori1gWn
         Bc/3wBea7mVvugsOKYQB+OOqj5/zDSvsocPpnjVxdw1xfMrJ3tXMp/sc6jzTDyuRsi
         9/rf5RSUKlO6g==
Date:   Wed, 15 Feb 2023 13:10:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     David Rau <David.Rau.opensource@dm.renesas.com>
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, bailideng@google.com,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] ASoC: da7219: Improve the IRQ process to increase the
 stability
Message-ID: <Y+zZwKFX1gMC5/ac@sirena.org.uk>
References: <20230215101045.21456-1-David.Rau.opensource@dm.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nNyJ0KxUtl0X7eDe"
Content-Disposition: inline
In-Reply-To: <20230215101045.21456-1-David.Rau.opensource@dm.renesas.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nNyJ0KxUtl0X7eDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2023 at 10:10:45AM +0000, David Rau wrote:
> Remove the sleep control in IRQ thread
> and create an individual task to handel it for Jack plug in event.
>=20
> This commit improves the control of ground switches in the AAD IRQ.

Copying in Guenter given the issues he raised with this, not
deleting context for his benefit.  It looks like this should
avoid the issues with the interrupt appearing locked up.

> Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
> ---
>  sound/soc/codecs/da7219-aad.c | 41 +++++++++++++++++++++++++++++------
>  sound/soc/codecs/da7219-aad.h |  4 ++++
>  2 files changed, 38 insertions(+), 7 deletions(-)
>=20
> diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
> index c55b033d89da..4a4f09f924bc 100644
> --- a/sound/soc/codecs/da7219-aad.c
> +++ b/sound/soc/codecs/da7219-aad.c
> @@ -339,11 +339,39 @@ static void da7219_aad_hptest_work(struct work_stru=
ct *work)
>  				    SND_JACK_HEADSET | SND_JACK_LINEOUT);
>  }
> =20
> +static void da7219_aad_jack_det_work(struct work_struct *work)
> +{
> +	struct da7219_aad_priv *da7219_aad =3D
> +		container_of(work, struct da7219_aad_priv, jack_det_work);
> +	struct snd_soc_component *component =3D da7219_aad->component;
> +	u8 srm_st;
> +
> +	mutex_lock(&da7219_aad->jack_det_mutex);
> +
> +	srm_st =3D snd_soc_component_read(component, DA7219_PLL_SRM_STS) & DA72=
19_PLL_SRM_STS_MCLK;
> +	msleep(da7219_aad->gnd_switch_delay * ((srm_st =3D=3D 0x0) ? 2 : 1) - 4=
);
> +	/* Enable ground switch */
> +	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
> +
> +	mutex_unlock(&da7219_aad->jack_det_mutex);

This mutex is only held by this work function - is it needed?

> +}
> +
> =20
>  /*
>   * IRQ
>   */
> =20
> +static irqreturn_t da7219_aad_pre_irq_thread(int irq, void *data)
> +{
> +
> +	struct da7219_aad_priv *da7219_aad =3D data;
> +
> +	if (!da7219_aad->jack_inserted)
> +		schedule_work(&da7219_aad->jack_det_work);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
>  static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
>  {
>  	struct da7219_aad_priv *da7219_aad =3D data;
> @@ -351,14 +379,9 @@ static irqreturn_t da7219_aad_irq_thread(int irq, vo=
id *data)
>  	struct snd_soc_dapm_context *dapm =3D snd_soc_component_get_dapm(compon=
ent);
>  	struct da7219_priv *da7219 =3D snd_soc_component_get_drvdata(component);
>  	u8 events[DA7219_AAD_IRQ_REG_MAX];
> -	u8 statusa, srm_st;
> +	u8 statusa;
>  	int i, report =3D 0, mask =3D 0;
> =20
> -	srm_st =3D snd_soc_component_read(component, DA7219_PLL_SRM_STS) & DA72=
19_PLL_SRM_STS_MCLK;
> -	msleep(da7219_aad->gnd_switch_delay * ((srm_st =3D=3D 0x0) ? 2 : 1) - 4=
);
> -	/* Enable ground switch */
> -	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
> -
>  	/* Read current IRQ events */
>  	regmap_bulk_read(da7219->regmap, DA7219_ACCDET_IRQ_EVENT_A,
>  			 events, DA7219_AAD_IRQ_REG_MAX);
> @@ -377,6 +400,9 @@ static irqreturn_t da7219_aad_irq_thread(int irq, voi=
d *data)
>  		events[DA7219_AAD_IRQ_REG_A], events[DA7219_AAD_IRQ_REG_B],
>  		statusa);
> =20
> +	if (!da7219_aad->jack_inserted)
> +		cancel_work_sync(&da7219_aad->jack_det_work);
> +
>  	if (statusa & DA7219_JACK_INSERTION_STS_MASK) {
>  		/* Jack Insertion */
>  		if (events[DA7219_AAD_IRQ_REG_A] &
> @@ -940,8 +966,9 @@ int da7219_aad_init(struct snd_soc_component *compone=
nt)
> =20
>  	INIT_WORK(&da7219_aad->btn_det_work, da7219_aad_btn_det_work);
>  	INIT_WORK(&da7219_aad->hptest_work, da7219_aad_hptest_work);
> +	INIT_WORK(&da7219_aad->jack_det_work, da7219_aad_jack_det_work);
> =20
> -	ret =3D request_threaded_irq(da7219_aad->irq, NULL,
> +	ret =3D request_threaded_irq(da7219_aad->irq, da7219_aad_pre_irq_thread,
>  				   da7219_aad_irq_thread,
>  				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>  				   "da7219-aad", da7219_aad);
> diff --git a/sound/soc/codecs/da7219-aad.h b/sound/soc/codecs/da7219-aad.h
> index 21fdf53095cc..be87ee47edde 100644
> --- a/sound/soc/codecs/da7219-aad.h
> +++ b/sound/soc/codecs/da7219-aad.h
> @@ -11,6 +11,7 @@
>  #define __DA7219_AAD_H
> =20
>  #include <linux/timer.h>
> +#include <linux/mutex.h>
>  #include <sound/soc.h>
>  #include <sound/jack.h>
>  #include <sound/da7219-aad.h>
> @@ -196,6 +197,9 @@ struct da7219_aad_priv {
> =20
>  	struct work_struct btn_det_work;
>  	struct work_struct hptest_work;
> +	struct work_struct jack_det_work;
> +
> +	struct mutex  jack_det_mutex;
> =20
>  	struct snd_soc_jack *jack;
>  	bool micbias_resume_enable;
> --=20
> 2.17.1
>=20

--nNyJ0KxUtl0X7eDe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPs2b8ACgkQJNaLcl1U
h9DmzAf/b0iZYV4mjBsAbKWuRquUakQQrSzDTy5BxiRkd0vtvdSIYthXkhTwfw2V
9b6iL3JKJcfqX1FGMP+64wGBsZndF8UfpOHLtHN6QJEPnYbMkHiqzb0u8+Z/OiqK
KtR3MvRcKa6D4Mb++rmQF0wdiESTkEkKqr60HsahnxCX7qyA1w0koWOGPHYb3Unk
CVb3ecodxa99NQIxVcnPDLWlw0npXUQOl+JUWIXJ66iIZ2D0WyIIB48EG/gw5tk5
QD49XA/WY0TdiLmi8LMFcNTfNqmhjCDRa52SyxP+3MfWC0Nxjo3R+CFPMLLvA+Iv
B3sWOwytF9uM4qcVvsIegXmCiMgRNw==
=sfnV
-----END PGP SIGNATURE-----

--nNyJ0KxUtl0X7eDe--
