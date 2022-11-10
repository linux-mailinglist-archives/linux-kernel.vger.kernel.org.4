Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8345C624664
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiKJPz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKJPzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:55:25 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437531F2E4;
        Thu, 10 Nov 2022 07:55:24 -0800 (PST)
Received: from mercury (unknown [37.81.43.100])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 06029660292B;
        Thu, 10 Nov 2022 15:55:20 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668095722;
        bh=OX9OfRqc+VB9/F7DcCVWxUZz/S1CEOIqVmASyc7jTqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=flO3EQr1yjtiYFwr9/yHXQBMSr/3+2JhQrULwbm3cePUFJElZSJZBMQf1Th5i9ku1
         3PIKiePo3VL8cGZMdjB0nbyP3yPLFbjDpgVXKpfY5MNM2CtqOXEhQ9c4LI15PpVHTo
         kLzLsqe3anEYPihKt561G4Xzv33XyEzm/K8bQ6hH2tAMH7pkuOxobuFp+DjMRdRZ4/
         9+UBWqry3YkViBtFahNezoy3Fa6Qnp2itbh7wyQ5OClhHibrvzc9DKCFLaohlL66cX
         eLNcECVdBMY/rii7fozyDgD7cjLcpWjvrTXSZGRQLO4Fdi+/LZaJVEsEyouBIvKeD6
         Eum4QVNIhBR/w==
Received: by mercury (Postfix, from userid 1000)
        id 22759106B5DE; Thu, 10 Nov 2022 16:55:10 +0100 (CET)
Date:   Thu, 10 Nov 2022 16:55:10 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, philipp@uvos.xyz
Subject: Re: [PATCH 1/3] power: cpcap-battery: Do not issue low signal too
 frequently
Message-ID: <20221110155510.tobdbaabjoe7ugvl@mercury.elektranox.org>
References: <1667647544-12945-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1667647544-12945-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4foyvbnipb47rca7"
Content-Disposition: inline
In-Reply-To: <1667647544-12945-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4foyvbnipb47rca7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 05, 2022 at 01:25:42PM +0200, Ivaylo Dimitrov wrote:
> It seems that low battery irq may be generated tens of times per second,
> leading to userspace being flooded with unnecessary events.
>=20
> Fix that by preventing such events being generated more than once every 30
> seconds.
>=20
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---

Concept looks ok to me, but the code is slightly racy, since the
thread is flushed before the IRQ is disabled in the remove routine.

>  drivers/power/supply/cpcap-battery.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/=
cpcap-battery.c
> index 4676560..8869067 100644
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -137,6 +137,7 @@ struct cpcap_battery_ddata {
>  	struct power_supply *psy;
>  	struct cpcap_battery_config config;
>  	struct cpcap_battery_state_data state[CPCAP_BATTERY_STATE_NR];
> +	struct delayed_work low_irq_work;
>  	u32 cc_lsb;		/* =CE=BCAms per LSB */
>  	atomic_t active;
>  	int charge_full;
> @@ -914,9 +915,13 @@ static irqreturn_t cpcap_battery_irq_thread(int irq,=
 void *data)
>  		dev_info(ddata->dev, "Coulomb counter calibration done\n");
>  		break;
>  	case CPCAP_BATTERY_IRQ_ACTION_BATTERY_LOW:
> -		if (latest->current_ua >=3D 0)
> +		if (latest->current_ua >=3D 0 &&
> +		    !delayed_work_pending((&ddata->low_irq_work))) {
>  			dev_warn(ddata->dev, "Battery low at %imV!\n",
>  				latest->voltage / 1000);
> +			schedule_delayed_work(&ddata->low_irq_work, 30 * HZ);
> +			disable_irq_nosync(d->irq);
> +		}
>  		break;
>  	case CPCAP_BATTERY_IRQ_ACTION_POWEROFF:
>  		if (latest->current_ua >=3D 0 && latest->voltage <=3D 3200000) {
> @@ -1087,6 +1092,21 @@ static int cpcap_battery_calibrate(struct cpcap_ba=
ttery_ddata *ddata)
>  	return error;
>  }
> =20
> +static void cpcap_battery_lowbph_enable(struct work_struct *work)
> +{
> +	struct delayed_work *d_work =3D to_delayed_work(work);
> +	struct cpcap_battery_ddata *ddata =3D container_of(d_work,
> +			struct cpcap_battery_ddata, low_irq_work);
> +	struct cpcap_interrupt_desc *d;
> +
> +	list_for_each_entry(d, &ddata->irq_list, node) {
> +		if (d->action =3D=3D CPCAP_BATTERY_IRQ_ACTION_BATTERY_LOW)
> +			break;
> +	}
> +
> +	enable_irq(d->irq);
> +}
> +
>  #ifdef CONFIG_OF
>  static const struct of_device_id cpcap_battery_id_table[] =3D {
>  	{
> @@ -1118,6 +1138,8 @@ static int cpcap_battery_probe(struct platform_devi=
ce *pdev)
>  	if (!ddata)
>  		return -ENOMEM;
> =20
> +	INIT_DELAYED_WORK(&ddata->low_irq_work, cpcap_battery_lowbph_enable);

use devm_delayed_work_autocancel() and put it directly before
cpcap_battery_init_interrupts().

>  	cpcap_battery_detect_battery_type(ddata);
> =20
>  	INIT_LIST_HEAD(&ddata->irq_list);
> @@ -1185,6 +1207,9 @@ static int cpcap_battery_remove(struct platform_dev=
ice *pdev)
>  	if (error)
>  		dev_err(&pdev->dev, "could not disable: %i\n", error);
> =20
> +	/* make sure to call enable_irq() if needed */
> +	flush_delayed_work(&ddata->low_irq_work);

and this can be dropped afterwards.

> +
>  	return 0;
>  }

Thanks,

-- Sebastian

--4foyvbnipb47rca7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNtHtoACgkQ2O7X88g7
+ppZ6xAAjdiPS9r50NFa3FNvdWJvwj1rXMo07HX+eYS2XslwjSqtwJifAOZt+a4c
ftp9FPZsEm2ct0ALlAOS6r5MngFiqJZOexeHWf3Fy1LZcNFUTLdGFNdISRM2ZUR+
YSqU91kkcVB0dzQy/lNUwSvxNbtqntNz3AMGoYk3++TMby/JL1e1f/0aWh9D+18p
wJJtPDAU1O1eM1/sTMIaiNO1ywcog/qjOiurZAkYE62vQDlaKUx8MiiWp5ngwIdO
fDUuqv+LZJmeuAtitiwNR67C6F4wlrCN8/ju4sH2VGCVu1s1FafFKuqTkF+QcgyM
tXavAWmR9z22bw5Xy3u1wFXcM1u8PWop3Q9N5CX4HBtS2SCp1IgdYoy4fQSlF0UW
KUpkoYXdIkMSqc1zU4fT2Pns+DG8Szc6x46clyYMcohssGUwzX2zMdQeeE4d8dXq
ybDLTM9E97mlL/aowh/CO1Vfw/A62zDbDdCshd9avbf8HEaOUCaeCtejkZY0gZWn
f+LGdyT78lhaURrZ12eQQPUst3UIQ+MvhCl5h1uqDyKDauRiQRpW802pvu4i6ySj
oZ+i2ByCkDF0TzHKhH1OG5WUrZ5NFdF2ltX65agJpmmTv5m+LD+3uRdVWY900BKm
G4N4zqe/ItcOP+6br6dwMnA9vKxOplX0eB+2C+CsSWUcHYosypI=
=vPuE
-----END PGP SIGNATURE-----

--4foyvbnipb47rca7--
