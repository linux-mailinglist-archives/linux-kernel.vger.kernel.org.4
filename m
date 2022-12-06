Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535BE6449E6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiLFRCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbiLFRCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:02:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015612AEB;
        Tue,  6 Dec 2022 09:02:36 -0800 (PST)
Received: from mercury (dyndsl-091-096-035-193.ewe-ip-backbone.de [91.96.35.193])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ED6786602B7B;
        Tue,  6 Dec 2022 17:02:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670346155;
        bh=iR10PwThoLooaPdACXm0Wp7rdMnryxQTrPmCRLMlsc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJFq0Xs02iRgwLDcna+J7uKQR4JhKQ8bNtiLJ5abud/VNu5M7JYE1DU9Ndv8CLP+w
         84LUtlJAzeZuwSrF7Cte96U877r5ti6VSNENTmaSa0awpRp5od2qM2982JEVHz7XDt
         i7nSkSUSoQ9l4umYJXPYoSd8HqcT7I0a8qMKCRO4Tyw9pfe1pctNT7X3Wbk16dNqs6
         p+19RrFDCdhYDMg8M/D9lrBFJe9Ti6zlEyx7BbQcXEVzU1yUBi4aua7XGKUF3/dYqC
         mt0WJLRrEdFIH0UXao2vRnX/UPS9ipwyryz0WJIJk5iJSexEfy13ZZaysQ1POI3yUm
         FG6wTQALaS+Xw==
Received: by mercury (Postfix, from userid 1000)
        id AF7F91060F2F; Tue,  6 Dec 2022 18:02:32 +0100 (CET)
Date:   Tue, 6 Dec 2022 18:02:32 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 4/7] thermal: rockchip: Simplify channel id logic
Message-ID: <20221206170232.xsm4kcbfwrmlrriw@mercury.elektranox.org>
References: <20221031175058.175698-1-sebastian.reichel@collabora.com>
 <20221031175058.175698-5-sebastian.reichel@collabora.com>
 <3601039.e9J7NaK4W3@phil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jqofcsecvyrpcmbz"
Content-Disposition: inline
In-Reply-To: <3601039.e9J7NaK4W3@phil>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jqofcsecvyrpcmbz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 15, 2022 at 12:30:51PM +0100, Heiko Stuebner wrote:
> Am Montag, 31. Oktober 2022, 18:50:55 CET schrieb Sebastian Reichel:
> > Replace the channel ID lookup table by a simple offset, since
> > the channel IDs are consecutive.
>=20
> Hmm, I don't really like going this way.
>=20
> While it may be true _right now_ that all tsadcs have the cpu-sensor
> at channel "x" and the gpu-sensor at "x+1", hardware engineers are
> always waaaaay too creative in what they do.
>=20
> So I really expect a future soc to turn this around or add other
> "interesting" variants.

It's totally fine to have it the other way around. Then the first
channel will be the GPU (or even the first channels if there are
multiple measurement points for the GPU). Those are just arbitrary
numbers. The only requirement of this patch is that there are no
gaps.

Supporting gaps can only be done with a lookup table, which wastes
memory. Considering there are no such devices right now and there
never might be any, is there a good reason for the added complexity?

-- Sebastian

> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  drivers/thermal/rockchip_thermal.c | 48 +++++++++++++-----------------
> >  1 file changed, 21 insertions(+), 27 deletions(-)
> >=20
> > diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockc=
hip_thermal.c
> > index 3dab31f163b3..a547e44e2b64 100644
> > --- a/drivers/thermal/rockchip_thermal.c
> > +++ b/drivers/thermal/rockchip_thermal.c
> > @@ -39,15 +39,6 @@ enum tshut_polarity {
> >  	TSHUT_HIGH_ACTIVE,
> >  };
> > =20
> > -/*
> > - * The system has two Temperature Sensors.
> > - * sensor0 is for CPU, and sensor1 is for GPU.
> > - */
> > -enum sensor_id {
> > -	SENSOR_CPU =3D 0,
> > -	SENSOR_GPU,
> > -};
> > -
> >  /*
> >   * The conversion table has the adc value and temperature.
> >   * ADC_DECREMENT: the adc value is of diminishing.(e.g. rk3288_code_ta=
ble)
> > @@ -82,7 +73,7 @@ struct chip_tsadc_table {
> > =20
> >  /**
> >   * struct rockchip_tsadc_chip - hold the private data of tsadc chip
> > - * @chn_id: array of sensor ids of chip corresponding to the channel
> > + * @chn_offset: the channel offset of the first channel
> >   * @chn_num: the channel number of tsadc chip
> >   * @tshut_temp: the hardware-controlled shutdown temperature value
> >   * @tshut_mode: the hardware-controlled shutdown mode (0:CRU 1:GPIO)
> > @@ -98,7 +89,7 @@ struct chip_tsadc_table {
> >   */
> >  struct rockchip_tsadc_chip {
> >  	/* The sensor id of chip correspond to the ADC channel */
> > -	int chn_id[SOC_MAX_SENSORS];
> > +	int chn_offset;
> >  	int chn_num;
> > =20
> >  	/* The hardware-controlled tshut property */
> > @@ -925,8 +916,8 @@ static void rk_tsadcv2_tshut_mode(int chn, void __i=
omem *regs,
> >  }
> > =20
> >  static const struct rockchip_tsadc_chip px30_tsadc_data =3D {
> > -	.chn_id[SENSOR_CPU] =3D 0, /* cpu sensor is channel 0 */
> > -	.chn_id[SENSOR_GPU] =3D 1, /* gpu sensor is channel 1 */
> > +	/* cpu, gpu */
> > +	.chn_offset =3D 0,
> >  	.chn_num =3D 2, /* 2 channels for tsadc */
> > =20
> >  	.tshut_mode =3D TSHUT_MODE_CRU, /* default TSHUT via CRU */
> > @@ -949,7 +940,8 @@ static const struct rockchip_tsadc_chip px30_tsadc_=
data =3D {
> >  };
> > =20
> >  static const struct rockchip_tsadc_chip rv1108_tsadc_data =3D {
> > -	.chn_id[SENSOR_CPU] =3D 0, /* cpu sensor is channel 0 */
> > +	/* cpu */
> > +	.chn_offset =3D 0,
> >  	.chn_num =3D 1, /* one channel for tsadc */
> > =20
> >  	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC =
*/
> > @@ -973,7 +965,8 @@ static const struct rockchip_tsadc_chip rv1108_tsad=
c_data =3D {
> >  };
> > =20
> >  static const struct rockchip_tsadc_chip rk3228_tsadc_data =3D {
> > -	.chn_id[SENSOR_CPU] =3D 0, /* cpu sensor is channel 0 */
> > +	/* cpu */
> > +	.chn_offset =3D 0,
> >  	.chn_num =3D 1, /* one channel for tsadc */
> > =20
> >  	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC =
*/
> > @@ -997,8 +990,8 @@ static const struct rockchip_tsadc_chip rk3228_tsad=
c_data =3D {
> >  };
> > =20
> >  static const struct rockchip_tsadc_chip rk3288_tsadc_data =3D {
> > -	.chn_id[SENSOR_CPU] =3D 1, /* cpu sensor is channel 1 */
> > -	.chn_id[SENSOR_GPU] =3D 2, /* gpu sensor is channel 2 */
> > +	/* cpu, gpu */
> > +	.chn_offset =3D 1,
> >  	.chn_num =3D 2, /* two channels for tsadc */
> > =20
> >  	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC =
*/
> > @@ -1022,7 +1015,8 @@ static const struct rockchip_tsadc_chip rk3288_ts=
adc_data =3D {
> >  };
> > =20
> >  static const struct rockchip_tsadc_chip rk3328_tsadc_data =3D {
> > -	.chn_id[SENSOR_CPU] =3D 0, /* cpu sensor is channel 0 */
> > +	/* cpu */
> > +	.chn_offset =3D 0,
> >  	.chn_num =3D 1, /* one channels for tsadc */
> > =20
> >  	.tshut_mode =3D TSHUT_MODE_CRU, /* default TSHUT via CRU */
> > @@ -1045,8 +1039,8 @@ static const struct rockchip_tsadc_chip rk3328_ts=
adc_data =3D {
> >  };
> > =20
> >  static const struct rockchip_tsadc_chip rk3366_tsadc_data =3D {
> > -	.chn_id[SENSOR_CPU] =3D 0, /* cpu sensor is channel 0 */
> > -	.chn_id[SENSOR_GPU] =3D 1, /* gpu sensor is channel 1 */
> > +	/* cpu, gpu */
> > +	.chn_offset =3D 0,
> >  	.chn_num =3D 2, /* two channels for tsadc */
> > =20
> >  	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC =
*/
> > @@ -1070,8 +1064,8 @@ static const struct rockchip_tsadc_chip rk3366_ts=
adc_data =3D {
> >  };
> > =20
> >  static const struct rockchip_tsadc_chip rk3368_tsadc_data =3D {
> > -	.chn_id[SENSOR_CPU] =3D 0, /* cpu sensor is channel 0 */
> > -	.chn_id[SENSOR_GPU] =3D 1, /* gpu sensor is channel 1 */
> > +	/* cpu, gpu */
> > +	.chn_offset =3D 0,
> >  	.chn_num =3D 2, /* two channels for tsadc */
> > =20
> >  	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC =
*/
> > @@ -1095,8 +1089,8 @@ static const struct rockchip_tsadc_chip rk3368_ts=
adc_data =3D {
> >  };
> > =20
> >  static const struct rockchip_tsadc_chip rk3399_tsadc_data =3D {
> > -	.chn_id[SENSOR_CPU] =3D 0, /* cpu sensor is channel 0 */
> > -	.chn_id[SENSOR_GPU] =3D 1, /* gpu sensor is channel 1 */
> > +	/* cpu, gpu */
> > +	.chn_offset =3D 0,
> >  	.chn_num =3D 2, /* two channels for tsadc */
> > =20
> >  	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC =
*/
> > @@ -1120,8 +1114,8 @@ static const struct rockchip_tsadc_chip rk3399_ts=
adc_data =3D {
> >  };
> > =20
> >  static const struct rockchip_tsadc_chip rk3568_tsadc_data =3D {
> > -	.chn_id[SENSOR_CPU] =3D 0, /* cpu sensor is channel 0 */
> > -	.chn_id[SENSOR_GPU] =3D 1, /* gpu sensor is channel 1 */
> > +	/* cpu, gpu */
> > +	.chn_offset =3D 0,
> >  	.chn_num =3D 2, /* two channels for tsadc */
> > =20
> >  	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC =
*/
> > @@ -1406,7 +1400,7 @@ static int rockchip_thermal_probe(struct platform=
_device *pdev)
> >  	for (i =3D 0; i < thermal->chip->chn_num; i++) {
> >  		error =3D rockchip_thermal_register_sensor(pdev, thermal,
> >  						&thermal->sensors[i],
> > -						thermal->chip->chn_id[i]);
> > +						thermal->chip->chn_offset + i);
> >  		if (error)
> >  			return dev_err_probe(&pdev->dev, error,
> >  				"failed to register sensor[%d].\n", i);
> >=20
>=20
>=20
>=20
>=20
>=20
> --=20
> To unsubscribe, send mail to kernel-unsubscribe@lists.collabora.co.uk.

--jqofcsecvyrpcmbz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOPdaMACgkQ2O7X88g7
+pp0Mw//WC4aTgggT1BQggQ8Nm9pQKnVrD2gsyd5ncHPA6JRhAnv/0KDq4/K1ZPc
riYsqKFTbd/oyJ4fFziBa+xy0BxZ/mgk2CsYfM1ojqFWCLnUkyfY3DM3nyw3A+TN
UCLA/wm0uYpk43swmng4DL5pTlS31/PmafdNMTxXCOvLidEfpcI+ldDVEoRzIwRT
POPYOfnyOyyWdL0ihMiuGMbmHp4HIb+NkJgWKBIwjLfCWw2Crb3kxZlCHsn2T8fn
AJlbL2JDhfcBOQ85xSXUywlmMU00q2qk3QNlV3ZgeDO0sld/pNrnhO1YoIvL98qT
atpP3n3+ZXgbWjKvZlIP2M3jkjVLSW/hWQSmQVD3jPhmaFInuGDcSYT+510VUiv2
uQo1dUoKcHujVWWdfzKxImmsYIUkyteJpNgIBYsgSxxL2Hcu4wKBTSBcEcnhta7a
XXYXerxUnl2jEsdTaJJw1jt5pVZFCDTEZWXCQMJjmVXUHORDSTI3I6WYoXKr14DP
d0D7bOHdhO/gNpzoJRP9D0lEhvS8uZGViTiUt6TrmahdEvZFFXqm9Kz3ouqKEEQh
PfoVKyLcobKcA78b+9YlWRXLiAJpHgbxQR4JvxpIVtDTQyS6eCDQHVFH4SEuOv/m
VT08A9T4XoKICcmPOacoi6EQYg+mnZ41Zv9Za11Kc/+H0A12b6g=
=0Yok
-----END PGP SIGNATURE-----

--jqofcsecvyrpcmbz--
