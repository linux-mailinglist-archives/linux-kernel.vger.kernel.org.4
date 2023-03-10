Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6345D6B3865
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCJIUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCJIUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:20:09 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9568FFAEE9;
        Fri, 10 Mar 2023 00:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678436407; x=1709972407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q2F5jQ+UF6+ouYmpPp9MVX0qcP1dWeBaAnFIKouhEoc=;
  b=dSqjDJeFOBWKmGzgFeSbFOidRnb88T+CIo4Mq0Ox5oU2IfvQC9gJi9fo
   k4R+e3Z3tdFoqWZW8VYGtwa/BWcHPdMH8bc86YF90d7+GaxnU6naY5AaP
   WDcyS1dNIAVv5+0HiYVYDe3/y+HTlw+jM6MPsDAcTZltOBuJToHIHiZls
   TJGxlzT/rbZaVw4Ix5Q81fwVOY20Bxzv7qu4V862NFyz/Iiica8XAz3/t
   3FUPbHuxqbvoVXhl6FLSuaKo82M8Zj17KgtoxhhagkmTd9jxcQ9XkRi4I
   KqeU1PltS8YcMMvR8KVx2OA1+KVZ7xZtJmDVHbpcCCqe8Jl2GnF1DFeay
   g==;
X-IronPort-AV: E=Sophos;i="5.98,249,1673910000"; 
   d="scan'208";a="29598330"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 10 Mar 2023 09:20:05 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 10 Mar 2023 09:20:04 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 10 Mar 2023 09:20:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678436405; x=1709972405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q2F5jQ+UF6+ouYmpPp9MVX0qcP1dWeBaAnFIKouhEoc=;
  b=b+tp6csmpS5lUKfWdXwkoGvgfS2cff3gzgN/Gasm2ogHg0XZZk/0I3Hc
   RPhyBF3jBq5bWfZRebj6+de4f7kDOVGcPg1yiz9RyeMzYJbwn4qqZgQFu
   mv3je/jMtiCsmFJryADDudsgXAXewKnjAmsvsXjnYMBaXNhsGzA/loNfH
   xC90YUj6TaJRWN00GWvZ3K4aAbFocu4Qtbs9gr2oJyelfGXAZh0ncHj2V
   UKKnxUtGwG23sG4wlfOf/5FFo+ly6tMeSGgOdAo27eNfSwOT5eIFPn9wq
   LHqByresjpLHB2Fo6kElmkNxb2/vL7zKOtSY2YhfSDqvcjEw4x3BDivJD
   A==;
X-IronPort-AV: E=Sophos;i="5.98,249,1673910000"; 
   d="scan'208";a="29598328"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Mar 2023 09:20:04 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 5918F280056;
        Fri, 10 Mar 2023 09:20:04 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-imx@nxp.com, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Subject: Re: [PATCH v1 2/4] thermal: qoriq: add i.MX93 TMU support
Date:   Fri, 10 Mar 2023 09:20:00 +0100
Message-ID: <2379970.Icojqenx9y@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230105101748.6714-3-alice.guo@oss.nxp.com>
References: <20230105101748.6714-1-alice.guo@oss.nxp.com> <20230105101748.6714-3-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Donnerstag, 5. Januar 2023, 11:17:46 CET schrieb Alice Guo (OSS):
> From: Alice Guo <alice.guo@nxp.com>
>=20
> The procedure to program the calibration table of i.MX93 TMU:
> 1. disable monitoring mode
> 2. configure TCMCFG
> 3. write TTCFGR with TTCFGR[CAL_PT] =3D n
> 4. write TSCFGR with the sensor value of the calibration point n
> 5. write TTRCRn associated with the calibration point n
> Need to repeat steps 3=E2=80=945 for all calibration points from the cali=
bration
> table provided by the TMU device node.
>=20
> When TRITSR[V] =3D 1 and TRITSR[TP5] =3D 1, need to add 0.5K to
> TRITSR[TEMP].
>=20
> IPBRR0s of lx2160ardb, lx2162aqds and i.MX93 have the same value
> 0x01900201 so that use the compatible to determine whether the current
> TMU belongs to i.MX93 or not.
>=20
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> ---
>  drivers/thermal/qoriq_thermal.c | 56 ++++++++++++++++++++++++++++++---
>  1 file changed, 52 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/thermal/qoriq_thermal.c
> b/drivers/thermal/qoriq_thermal.c index d111e218f362..18030bd68687 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -24,9 +24,11 @@
>  #define TMTMIR_DEFAULT	0x0000000f
>  #define TIER_DISABLE	0x0
>  #define TEUMR0_V2		0x51009c00
> +#define TEUMR0_V21		0x55010c00
>  #define TMSARA_V2		0xe
>  #define TMU_VER1		0x1
>  #define TMU_VER2		0x2
> +#define TMU_VER93		0x3
>=20
>  #define REGS_TMR	0x000	/* Mode Register */
>  #define TMR_DISABLE	0x0
> @@ -52,6 +54,7 @@
>  					    * Site Register
>  					    */
>  #define TRITSR_V	BIT(31)
> +#define TRITSR_TP5	BIT(9)
>  #define REGS_V2_TMSAR(n)	(0x304 + 16 * (n))	/* TMU monitoring
>  						* site adjustment=20
register
>  						*/
> @@ -114,10 +117,16 @@ static int tmu_get_temp(struct thermal_zone_device
> *tz, int *temp) 10 * USEC_PER_MSEC))
>  		return -ENODATA;
>=20
> -	if (qdata->ver =3D=3D TMU_VER1)
> +	if (qdata->ver =3D=3D TMU_VER1) {
>  		*temp =3D (val & GENMASK(7, 0)) * MILLIDEGREE_PER_DEGREE;
> -	else
> +	} else if (qdata->ver =3D=3D TMU_VER93) {
> +		if (val & TRITSR_TP5)
> +			*temp =3D milli_kelvin_to_millicelsius((val &=20
GENMASK(8, 0)) *
> MILLIDEGREE_PER_DEGREE + 500); +		else
> +			*temp =3D kelvin_to_millicelsius(val & GENMASK(8,=20
0));
> +	} else {
>  		*temp =3D kelvin_to_millicelsius(val & GENMASK(8, 0));
> +	}
>=20
>  	return 0;
>  }
> @@ -207,6 +216,33 @@ static int qoriq_tmu_calibration(struct device *dev,
>  	return 0;
>  }
>=20
> +static int imx93_tmu_calibration(struct device *dev,
> +				 struct qoriq_tmu_data *data)
> +{
> +	const u32 *calibration =3D NULL;

This should be __be32 instead of u32.

> +	u32 cal_pt =3D 0;
> +	u32 val =3D 0;
> +	unsigned int len =3D 0;
> +	unsigned int i =3D 0;
> +
> +	calibration =3D of_get_property(dev->of_node, "fsl,tmu-calibration",=20
&len);
> +	if (calibration =3D=3D NULL || len / 8 > 16 || len % 8) {
> +		dev_err(dev, "invalid tmu calibration\n");
> +		return -ENODEV;
> +	}
> +
> +	for (i =3D 0; i < len; i +=3D 0x8, calibration +=3D 2) {
> +		cal_pt =3D i / 8;
> +		regmap_write(data->regmap, REGS_TTCFGR, cal_pt);
> +		val =3D of_read_number(calibration, 1);

of_read_number is actually expecting a __be32.

Best regards,
Alexander

> +		regmap_write(data->regmap, REGS_TSCFGR, val);
> +		val =3D of_read_number(calibration + 1, 1);
> +		regmap_write(data->regmap, REGS_TTRnCR(cal_pt), val);
> +	}
> +
> +	return 0;
> +}
> +
>  static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
>  {
>  	int i;
> @@ -218,6 +254,11 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_d=
ata
> *data)
>=20
>  	if (data->ver =3D=3D TMU_VER1) {
>  		regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
> +	} else if (data->ver =3D=3D TMU_VER93) {
> +		regmap_write(data->regmap, REGS_V2_TMTMIR,=20
TMTMIR_DEFAULT);
> +		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V21);
> +		for (i =3D 0; i < SITES_MAX; i++)
> +			regmap_write(data->regmap, REGS_V2_TMSAR(i),=20
TMSARA_V2);
>  	} else {
>  		regmap_write(data->regmap, REGS_V2_TMTMIR,=20
TMTMIR_DEFAULT);
>  		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
> @@ -231,7 +272,7 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_da=
ta
> *data)
>=20
>  static const struct regmap_range qoriq_yes_ranges[] =3D {
>  	regmap_reg_range(REGS_TMR, REGS_TSCFGR),
> -	regmap_reg_range(REGS_TTRnCR(0), REGS_TTRnCR(3)),
> +	regmap_reg_range(REGS_TTRnCR(0), REGS_TTRnCR(15)),
>  	regmap_reg_range(REGS_V2_TEUMR(0), REGS_V2_TEUMR(2)),
>  	regmap_reg_range(REGS_V2_TMSAR(0), REGS_V2_TMSAR(15)),
>  	regmap_reg_range(REGS_IPBRR(0), REGS_IPBRR(1)),
> @@ -319,9 +360,15 @@ static int qoriq_tmu_probe(struct platform_device
> *pdev) }
>  	data->ver =3D (ver >> 8) & 0xff;
>=20
> +	if (of_find_compatible_node(NULL, NULL, "fsl,imx93-tmu"))
> +		data->ver =3D TMU_VER93;
> +
>  	qoriq_tmu_init_device(data);	/* TMU initialization */
>=20
> -	ret =3D qoriq_tmu_calibration(dev, data);	/* TMU calibration */
> +	if (data->ver =3D=3D TMU_VER93)
> +		ret =3D imx93_tmu_calibration(dev, data);
> +	else
> +		ret =3D qoriq_tmu_calibration(dev, data);	/* TMU=20
calibration */
>  	if (ret < 0)
>  		return ret;
>=20
> @@ -369,6 +416,7 @@ static SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
>  static const struct of_device_id qoriq_tmu_match[] =3D {
>  	{ .compatible =3D "fsl,qoriq-tmu", },
>  	{ .compatible =3D "fsl,imx8mq-tmu", },
> +	{ .compatible =3D "fsl,imx93-tmu", },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, qoriq_tmu_match);


=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/


