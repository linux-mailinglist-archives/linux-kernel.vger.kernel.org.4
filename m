Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33CA7484B1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjGENMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjGENMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:12:52 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3421700;
        Wed,  5 Jul 2023 06:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1688562768; x=1720098768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u+CYWz+wrcDqdmitNpoma5P/Hi2wWpeXsryCS80wey4=;
  b=jZ7C2VT6VNRddGpy6yHIOoK/qjwEin8mwNjfO8SIKKFTDibIFNiM0cad
   ybgCuXYPoreiGjocv4Kib5y9QSzX3OlmsSEMvDKLe1hoIl7UKsfcOVXLO
   v8WT9eAknjA0UzV+OB20nEJ9XyRhD991E7OkFiD2Cmp4yzBU04M2M9mAr
   Hvn06LZrQaNzLWztdtZkx5/u+n9Av60X5pV+tEThAYoqK8XOXK3XN+7ku
   DJwZoZx0bJ/STnpHUi+GO+i3gZiQ7SAqSm/A+4esN9+hFJ4pPgOA/vvgh
   LR7ne13EsSrogyAGtkh2ibMwTd68XhofDmUSLi/q5c1z92XF7ivvOPbza
   A==;
X-IronPort-AV: E=Sophos;i="6.01,183,1684792800"; 
   d="scan'208";a="31771723"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 05 Jul 2023 15:12:46 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 24CFD280078;
        Wed,  5 Jul 2023 15:12:46 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Jacky Bai <ping.bai@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Joy Zou <joy.zou@nxp.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] regulator: pca9450: add pca9451a support
Date:   Wed, 05 Jul 2023 15:12:45 +0200
Message-ID: <4630917.iIbC2pHGDl@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <VI1PR04MB5936370C11D1523558437D9BE12FA@VI1PR04MB5936.eurprd04.prod.outlook.com>
References: <20230531065724.3671795-1-joy.zou@nxp.com> <3505527.iIbC2pHGDl@steina-w> <VI1PR04MB5936370C11D1523558437D9BE12FA@VI1PR04MB5936.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Am Mittwoch, 5. Juli 2023, 08:50:24 CEST schrieb Joy Zou:
>=20
> > -----Original Message-----
> > From: Alexander Stein <alexander.stein@ew.tq-group.com>
> > Sent: 2023=E5=B9=B45=E6=9C=8831=E6=97=A5 19:35
> > To: Jacky Bai <ping.bai@nxp.com>; lgirdwood@gmail.com;
> > broonie@kernel.org; robh+dt@kernel.org;
> > krzysztof.kozlowski+dt@linaro.org;
> > conor+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > linux-arm-kernel@lists.infradead.org
> > Cc: kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
> > <linux-imx@nxp.com>; devicetree@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Joy
> > Zou
 <joy.zou@nxp.com>
> > Subject: [EXT] Re: [PATCH v1 2/3] regulator: pca9450: add pca9451a
> > support
> >
> >
> >
> > Caution: This is an external email. Please take care when clicking links
> > or
 opening attachments. When in doubt, report the message using the
> > 'Report this email' button
> >
> >
> >
> >
> > Hi,
> >
> >
> >
> > Am Mittwoch, 31. Mai 2023, 08:57:23 CEST schrieb Joy Zou:
> >=20
> > > Adding support for pmic pca9451a.
> > >
> > >
> > >
> > > This patch support old and new pmic pca9451a. The new pmic trimed
> >=20
> > BUCK1.
> >=20
> > > The default value of Toff_Deb is used to distinguish the old and new
> > > pmic.
> > >
> > >
> > >
> > > Signed-off-by: Joy Zou <joy.zou@nxp.com>
> > > ---
> > >=20
> > >  drivers/regulator/pca9450-regulator.c | 262
> >=20
> > ++++++++++++++++++++++++--
> >=20
> > >  include/linux/regulator/pca9450.h     |   2 +
> > >  2 files changed, 252 insertions(+), 12 deletions(-)
> > >
> > >
> > >
> > > diff --git a/drivers/regulator/pca9450-regulator.c
> > > b/drivers/regulator/pca9450-regulator.c index
> > > 91bfb7e026c9..654aa4fbe494
> > > 100644
> > > --- a/drivers/regulator/pca9450-regulator.c
> > > +++ b/drivers/regulator/pca9450-regulator.c
> > > @@ -104,7 +104,15 @@ static const struct regulator_ops
> > > pca9450_ldo_regulator_ops =3D { * 0.60 to 2.1875V (12.5mV step)
> > >=20
> > >   */
> > > =20
> > >  static const struct linear_range pca9450_dvs_buck_volts[] =3D {
> > >=20
> > > -     REGULATOR_LINEAR_RANGE(600000,  0x00, 0x7F, 12500),
> > > +     REGULATOR_LINEAR_RANGE(600000, 0x00, 0x7F, 12500), };
> > > +
> > > +/*
> > > + * BUCK1/3
> > > + * 0.65 to 2.2375V (12.5mV step)
> >
> >
> >
> > Reading this comment, it seems the same distinction needs to be done for
> > BUCK3 as well, no?
>=20
> Sorry for the late reply!
> The BUCK1 and BUCK3 are dual phase, so don't need to be done for BUCK3.
>=20
> >
> >
> > > + */
> > > +static const struct linear_range pca9450_trim_dvs_buck_volts[] =3D {
> > > +     REGULATOR_LINEAR_RANGE(650000, 0x00, 0x7F, 12500),
> > >=20
> > >  };
> > >
> > >
> > >
> > >  /*
> > >=20
> > > @@ -663,6 +671,207 @@ static const struct pca9450_regulator_desc
> > > pca9450bc_regulators[] =3D { },  };
> > >
> > >
> > >
> > > +static const struct pca9450_regulator_desc pca9451a_regulators[] =3D=
 {
> > > +     {
> > > +             .desc =3D {
> > > +                     .name =3D "buck1",
> > > +                     .of_match =3D of_match_ptr("BUCK1"),
> > > +                     .regulators_node =3D of_match_ptr("regulators"),
> > > +                     .id =3D PCA9450_BUCK1,
> > > +                     .ops =3D &pca9450_dvs_buck_regulator_ops,
> > > +                     .type =3D REGULATOR_VOLTAGE,
> > > +                     .n_voltages =3D PCA9450_BUCK1_VOLTAGE_NUM,
> > > +                     .linear_ranges =3D pca9450_dvs_buck_volts,
> > > +                     .n_linear_ranges =3D
> >=20
> > ARRAY_SIZE(pca9450_dvs_buck_volts),
> >=20
> > > +                     .vsel_reg =3D PCA9450_REG_BUCK1OUT_DVS0,
> > > +                     .vsel_mask =3D BUCK1OUT_DVS0_MASK,
> > > +                     .enable_reg =3D PCA9450_REG_BUCK1CTRL,
> > > +                     .enable_mask =3D BUCK1_ENMODE_MASK,
> > > +                     .enable_val =3D BUCK_ENMODE_ONREQ,
> > > +                     .ramp_mask =3D BUCK1_RAMP_MASK,
> > > +                     .ramp_delay_table =3D
> >=20
> > pca9450_dvs_buck_ramp_table,
> >=20
> > > +                     .n_ramp_values =3D
> >=20
> > ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
> >=20
> > > +                     .owner =3D THIS_MODULE,
> > > +                     .of_parse_cb =3D pca9450_set_dvs_levels,
> > > +             },
> > > +             .dvs =3D {
> > > +                     .run_reg =3D PCA9450_REG_BUCK1OUT_DVS0,
> > > +                     .run_mask =3D BUCK1OUT_DVS0_MASK,
> > > +                     .standby_reg =3D PCA9450_REG_BUCK1OUT_DVS1,
> > > +                     .standby_mask =3D BUCK1OUT_DVS1_MASK,
> > > +             },
> > > +     },
> > > +     {
> > > +             .desc =3D {
> > > +                     .name =3D "buck1_trim",
> > > +                     .of_match =3D of_match_ptr("BUCK1"),
> > > +                     .regulators_node =3D of_match_ptr("regulators"),
> > > +                     .id =3D PCA9450_BUCK1,
> > > +                     .ops =3D &pca9450_dvs_buck_regulator_ops,
> > > +                     .type =3D REGULATOR_VOLTAGE,
> > > +                     .n_voltages =3D PCA9450_BUCK1_VOLTAGE_NUM,
> > > +                     .linear_ranges =3D pca9450_trim_dvs_buck_volts,
> > > +                     .n_linear_ranges =3D
> >=20
> > ARRAY_SIZE(pca9450_trim_dvs_buck_volts),
> >=20
> > > +                     .vsel_reg =3D PCA9450_REG_BUCK1OUT_DVS0,
> > > +                     .vsel_mask =3D BUCK1OUT_DVS0_MASK,
> > > +                     .enable_reg =3D PCA9450_REG_BUCK1CTRL,
> > > +                     .enable_mask =3D BUCK1_ENMODE_MASK,
> > > +                     .enable_val =3D BUCK_ENMODE_ONREQ,
> > > +                     .ramp_mask =3D BUCK1_RAMP_MASK,
> > > +                     .ramp_delay_table =3D
> >=20
> > pca9450_dvs_buck_ramp_table,
> >=20
> > > +                     .n_ramp_values =3D
> >=20
> > ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
> >=20
> > > +                     .owner =3D THIS_MODULE,
> > > +                     .of_parse_cb =3D pca9450_set_dvs_levels,
> > > +             },
> > > +             .dvs =3D {
> > > +                     .run_reg =3D PCA9450_REG_BUCK1OUT_DVS0,
> > > +                     .run_mask =3D BUCK1OUT_DVS0_MASK,
> > > +                     .standby_reg =3D PCA9450_REG_BUCK1OUT_DVS1,
> > > +                     .standby_mask =3D BUCK1OUT_DVS1_MASK,
> > > +             },
> > > +     },
> > > +     {
> > > +             .desc =3D {
> > > +                     .name =3D "buck2",
> > > +                     .of_match =3D of_match_ptr("BUCK2"),
> > > +                     .regulators_node =3D of_match_ptr("regulators"),
> > > +                     .id =3D PCA9450_BUCK2,
> > > +                     .ops =3D &pca9450_dvs_buck_regulator_ops,
> > > +                     .type =3D REGULATOR_VOLTAGE,
> > > +                     .n_voltages =3D PCA9450_BUCK2_VOLTAGE_NUM,
> > > +                     .linear_ranges =3D pca9450_dvs_buck_volts,
> > > +                     .n_linear_ranges =3D
> >=20
> > ARRAY_SIZE(pca9450_dvs_buck_volts),
> >=20
> > > +                     .vsel_reg =3D PCA9450_REG_BUCK2OUT_DVS0,
> > > +                     .vsel_mask =3D BUCK2OUT_DVS0_MASK,
> > > +                     .enable_reg =3D PCA9450_REG_BUCK2CTRL,
> > > +                     .enable_mask =3D BUCK2_ENMODE_MASK,
> > > +                     .enable_val =3D BUCK_ENMODE_ONREQ_STBYREQ,
> > > +                     .ramp_mask =3D BUCK2_RAMP_MASK,
> > > +                     .ramp_delay_table =3D
> >=20
> > pca9450_dvs_buck_ramp_table,
> >=20
> > > +                     .n_ramp_values =3D
> >=20
> > ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
> >=20
> > > +                     .owner =3D THIS_MODULE,
> > > +                     .of_parse_cb =3D pca9450_set_dvs_levels,
> > > +             },
> > > +             .dvs =3D {
> > > +                     .run_reg =3D PCA9450_REG_BUCK2OUT_DVS0,
> > > +                     .run_mask =3D BUCK2OUT_DVS0_MASK,
> > > +                     .standby_reg =3D PCA9450_REG_BUCK2OUT_DVS1,
> > > +                     .standby_mask =3D BUCK2OUT_DVS1_MASK,
> > > +             },
> > > +     },
> > > +     {
> > > +             .desc =3D {
> > > +                     .name =3D "buck4",
> > > +                     .of_match =3D of_match_ptr("BUCK4"),
> > > +                     .regulators_node =3D of_match_ptr("regulators"),
> > > +                     .id =3D PCA9450_BUCK4,
> > > +                     .ops =3D &pca9450_buck_regulator_ops,
> > > +                     .type =3D REGULATOR_VOLTAGE,
> > > +                     .n_voltages =3D PCA9450_BUCK4_VOLTAGE_NUM,
> > > +                     .linear_ranges =3D pca9450_buck_volts,
> > > +                     .n_linear_ranges =3D
> >=20
> > ARRAY_SIZE(pca9450_buck_volts),
> >=20
> > > +                     .vsel_reg =3D PCA9450_REG_BUCK4OUT,
> > > +                     .vsel_mask =3D BUCK4OUT_MASK,
> > > +                     .enable_reg =3D PCA9450_REG_BUCK4CTRL,
> > > +                     .enable_mask =3D BUCK4_ENMODE_MASK,
> > > +                     .enable_val =3D BUCK_ENMODE_ONREQ,
> > > +                     .owner =3D THIS_MODULE,
> > > +             },
> > > +     },
> > > +     {
> > > +             .desc =3D {
> > > +                     .name =3D "buck5",
> > > +                     .of_match =3D of_match_ptr("BUCK5"),
> > > +                     .regulators_node =3D of_match_ptr("regulators"),
> > > +                     .id =3D PCA9450_BUCK5,
> > > +                     .ops =3D &pca9450_buck_regulator_ops,
> > > +                     .type =3D REGULATOR_VOLTAGE,
> > > +                     .n_voltages =3D PCA9450_BUCK5_VOLTAGE_NUM,
> > > +                     .linear_ranges =3D pca9450_buck_volts,
> > > +                     .n_linear_ranges =3D
> >=20
> > ARRAY_SIZE(pca9450_buck_volts),
> >=20
> > > +                     .vsel_reg =3D PCA9450_REG_BUCK5OUT,
> > > +                     .vsel_mask =3D BUCK5OUT_MASK,
> > > +                     .enable_reg =3D PCA9450_REG_BUCK5CTRL,
> > > +                     .enable_mask =3D BUCK5_ENMODE_MASK,
> > > +                     .enable_val =3D BUCK_ENMODE_ONREQ,
> > > +                     .owner =3D THIS_MODULE,
> > > +             },
> > > +     },
> > > +     {
> > > +             .desc =3D {
> > > +                     .name =3D "buck6",
> > > +                     .of_match =3D of_match_ptr("BUCK6"),
> > > +                     .regulators_node =3D of_match_ptr("regulators"),
> > > +                     .id =3D PCA9450_BUCK6,
> > > +                     .ops =3D &pca9450_buck_regulator_ops,
> > > +                     .type =3D REGULATOR_VOLTAGE,
> > > +                     .n_voltages =3D PCA9450_BUCK6_VOLTAGE_NUM,
> > > +                     .linear_ranges =3D pca9450_buck_volts,
> > > +                     .n_linear_ranges =3D
> >=20
> > ARRAY_SIZE(pca9450_buck_volts),
> >=20
> > > +                     .vsel_reg =3D PCA9450_REG_BUCK6OUT,
> > > +                     .vsel_mask =3D BUCK6OUT_MASK,
> > > +                     .enable_reg =3D PCA9450_REG_BUCK6CTRL,
> > > +                     .enable_mask =3D BUCK6_ENMODE_MASK,
> > > +                     .enable_val =3D BUCK_ENMODE_ONREQ,
> > > +                     .owner =3D THIS_MODULE,
> > > +             },
> > > +     },
> > > +     {
> > > +             .desc =3D {
> > > +                     .name =3D "ldo1",
> > > +                     .of_match =3D of_match_ptr("LDO1"),
> > > +                     .regulators_node =3D of_match_ptr("regulators"),
> > > +                     .id =3D PCA9450_LDO1,
> > > +                     .ops =3D &pca9450_ldo_regulator_ops,
> > > +                     .type =3D REGULATOR_VOLTAGE,
> > > +                     .n_voltages =3D PCA9450_LDO1_VOLTAGE_NUM,
> > > +                     .linear_ranges =3D pca9450_ldo1_volts,
> > > +                     .n_linear_ranges =3D
> >=20
> > ARRAY_SIZE(pca9450_ldo1_volts),
> >=20
> > > +                     .vsel_reg =3D PCA9450_REG_LDO1CTRL,
> > > +                     .vsel_mask =3D LDO1OUT_MASK,
> > > +                     .enable_reg =3D PCA9450_REG_LDO1CTRL,
> > > +                     .enable_mask =3D LDO1_EN_MASK,
> > > +                     .owner =3D THIS_MODULE,
> > > +             },
> > > +     },
> > > +     {
> > > +             .desc =3D {
> > > +                     .name =3D "ldo4",
> > > +                     .of_match =3D of_match_ptr("LDO4"),
> > > +                     .regulators_node =3D of_match_ptr("regulators"),
> > > +                     .id =3D PCA9450_LDO4,
> > > +                     .ops =3D &pca9450_ldo_regulator_ops,
> > > +                     .type =3D REGULATOR_VOLTAGE,
> > > +                     .n_voltages =3D PCA9450_LDO4_VOLTAGE_NUM,
> > > +                     .linear_ranges =3D pca9450_ldo34_volts,
> > > +                     .n_linear_ranges =3D
> >=20
> > ARRAY_SIZE(pca9450_ldo34_volts),
> >=20
> > > +                     .vsel_reg =3D PCA9450_REG_LDO4CTRL,
> > > +                     .vsel_mask =3D LDO4OUT_MASK,
> > > +                     .enable_reg =3D PCA9450_REG_LDO4CTRL,
> > > +                     .enable_mask =3D LDO4_EN_MASK,
> > > +                     .owner =3D THIS_MODULE,
> > > +             },
> > > +     },
> > > +     {
> > > +             .desc =3D {
> > > +                     .name =3D "ldo5",
> > > +                     .of_match =3D of_match_ptr("LDO5"),
> > > +                     .regulators_node =3D of_match_ptr("regulators"),
> > > +                     .id =3D PCA9450_LDO5,
> > > +                     .ops =3D &pca9450_ldo_regulator_ops,
> > > +                     .type =3D REGULATOR_VOLTAGE,
> > > +                     .n_voltages =3D PCA9450_LDO5_VOLTAGE_NUM,
> > > +                     .linear_ranges =3D pca9450_ldo5_volts,
> > > +                     .n_linear_ranges =3D
> >=20
> > ARRAY_SIZE(pca9450_ldo5_volts),
> >=20
> > > +                     .vsel_reg =3D PCA9450_REG_LDO5CTRL_H,
> > > +                     .vsel_mask =3D LDO5HOUT_MASK,
> > > +                     .enable_reg =3D PCA9450_REG_LDO5CTRL_H,
> > > +                     .enable_mask =3D LDO5H_EN_MASK,
> > > +                     .owner =3D THIS_MODULE,
> > > +             },
> > > +     },
> > > +};
> > > +
> > >=20
> > >  static irqreturn_t pca9450_irq_handler(int irq, void *data)  {
> > > =20
> > >       struct pca9450 *pca9450 =3D data;
> > >=20
> > > @@ -708,8 +917,9 @@ static int pca9450_i2c_probe(struct i2c_client
> > > *i2c)
> > >=20
> > >       const struct pca9450_regulator_desc     *regulator_desc;
> > >       struct regulator_config config =3D { };
> > >       struct pca9450 *pca9450;
> > >=20
> > > -     unsigned int device_id, i;
> > > +     unsigned int device_id, i, val;
> > >=20
> > >       unsigned int reset_ctrl;
> > >=20
> > > +     bool pmic_trim =3D false;
> > >=20
> > >       int ret;
> > >
> > >
> > >
> > >       if (!i2c->irq) {
> > >=20
> > > @@ -721,6 +931,22 @@ static int pca9450_i2c_probe(struct i2c_client
> > > *i2c)
> > >=20
> > >       if (!pca9450)
> > >      =20
> > >               return -ENOMEM;
> > >
> > >
> > >
> > > +     pca9450->regmap =3D devm_regmap_init_i2c(i2c,
> > > +
> >=20
> > &pca9450_regmap_config);
> >=20
> > > +     if (IS_ERR(pca9450->regmap)) {
> > > +             dev_err(&i2c->dev, "regmap initialization failed\n");
> > > +             return PTR_ERR(pca9450->regmap);
> > > +     }
> > > +
> > > +     ret =3D regmap_read(pca9450->regmap, PCA9450_REG_PWRCTRL,
> >=20
> > &val);
> >=20
> > > +     if (ret) {
> > > +             dev_err(&i2c->dev, "Read device id error\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     if (val & PCA9450_REG_PWRCTRL_TOFF_DEB)
> > > +             pmic_trim =3D true;
> >
> >
> >
> > PCA9450_REG_PWRCTRL is a read/write register. How is it possible to det=
ect
> > a chip revision using a bit which can be changed by software e.g.
> > bootloader? Despite that this bit sets debounce time for PMIC_ON_REQ, h=
ow
> > is this related to BUCK1 voltage range?
>=20
> There are old and new two kind PMIC pca9451a.=20

There is only one part mentioned in the ordering options. How can I=20
distinguish them? Any chip ID, date codes, markings?

> This bit sets debounce time in
> PCA9450_REG_PWRCTRL was set different value by hardware in order to only
> distinguish the old and new PMIC. This bit isn't related to the BUCK1
> voltage range. If the pmic_trim is true that means it's new pca9451a.

But this bit is writable. How do you know it has not been modified since=20
reset?

Best regards,
Alexander

> > > +
> > >=20
> > >       switch (type) {
> > >       case PCA9450_TYPE_PCA9450A:
> > >      =20
> > >               regulator_desc =3D pca9450a_regulators; @@ -730,6 +956,=
10
> > >=20
> > > @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
> > >=20
> > >               regulator_desc =3D pca9450bc_regulators;
> > >               pca9450->rcnt =3D ARRAY_SIZE(pca9450bc_regulators);
> > >               break;
> > >=20
> > > +     case PCA9450_TYPE_PCA9451A:
> > > +             regulator_desc =3D pca9451a_regulators;
> > > +             pca9450->rcnt =3D ARRAY_SIZE(pca9451a_regulators);
> > > +             break;
> > >=20
> > >       default:
> > >      =20
> > >               dev_err(&i2c->dev, "Unknown device type");
> > >               return -EINVAL;
> > >=20
> > > @@ -741,13 +971,6 @@ static int pca9450_i2c_probe(struct i2c_client
> > > *i2c)
> > >
> > >
> > >
> > >       dev_set_drvdata(&i2c->dev, pca9450);
> > >
> > >
> > >
> > > -     pca9450->regmap =3D devm_regmap_init_i2c(i2c,
> > > -
> >=20
> > &pca9450_regmap_config);
> >=20
> > > -     if (IS_ERR(pca9450->regmap)) {
> > > -             dev_err(&i2c->dev, "regmap initialization failed\n");
> > > -             return PTR_ERR(pca9450->regmap);
> > > -     }
> > > -
> > >=20
> > >       ret =3D regmap_read(pca9450->regmap, PCA9450_REG_DEV_ID,
> >=20
> > &device_id);
> >=20
> > >       if (ret) {
> > >      =20
> > >               dev_err(&i2c->dev, "Read device id error\n"); @@ -756,7
> > >=20
> > > +979,8 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
> > >
> > >
> > >
> > >       /* Check your board and dts for match the right pmic */
> > >       if (((device_id >> 4) !=3D 0x1 && type =3D=3D PCA9450_TYPE_PCA9=
450A) ||
> > >=20
> > > -         ((device_id >> 4) !=3D 0x3 && type =3D=3D PCA9450_TYPE_PCA9=
450BC))
> >=20
> > {
> >=20
> > > +         ((device_id >> 4) !=3D 0x3 && type =3D=3D PCA9450_TYPE_PCA9=
450BC)
> > >=20
> > ||
> > ||
> > > +         ((device_id >> 4) !=3D 0x9 && type =3D=3D PCA9450_TYPE_PCA9=
451A))
> > > + {
> > >=20
> > >               dev_err(&i2c->dev, "Device id(%x) mismatched\n",
> > >              =20
> > >                       device_id >> 4);
> > >              =20
> > >               return -EINVAL;
> > >=20
> > > @@ -767,7 +991,16 @@ static int pca9450_i2c_probe(struct i2c_client
> > > *i2c)
> > >=20
> > >               struct regulator_dev *rdev;
> > >               const struct pca9450_regulator_desc *r;
> > >
> > >
> > >
> > > -             r =3D &regulator_desc[i];
> > > +             if (type =3D=3D PCA9450_TYPE_PCA9451A &&
> > > +                 !strcmp((&regulator_desc[i])->desc.name, "buck1") &&
> >=20
> > pmic_trim) {
> >=20
> > > +                     r =3D &regulator_desc[i + 1];
> > > +                     i =3D i + 1;
> > > +             } else if (type =3D=3D PCA9450_TYPE_PCA9451A &&
> > > +                        !strcmp((&regulator_desc[i])->desc.name,
> >=20
> > "buck1")) {
> >=20
> > > +                     r =3D &regulator_desc[i];
> > > +                     i =3D i + 1;
> >
> >
> >
> > I would put this in a single 'type =3D=3D PCA9450_TYPE_PCA9451A' branch=
, to
> > indicate that only PCA9451A needs some kind of special handling.
>=20
> Yes, this makes the logic clearer. I will change in next version.
>=20
> >
> >
> > > +             } else
> > > +                     r =3D &regulator_desc[i];
> > >=20
> > >               desc =3D &r->desc;
> > >
> > >
> > >
> > >               config.regmap =3D pca9450->regmap; @@ -847,7 +1080,8
> >=20
> > @@
> >=20
> > > static int pca9450_i2c_probe(struct i2c_client *i2c)
> > >=20
> > >       }
> > >
> > >
> > >
> > >       dev_info(&i2c->dev, "%s probed.\n",
> > >=20
> > > -             type =3D=3D PCA9450_TYPE_PCA9450A ? "pca9450a" :
> >=20
> > "pca9450bc");
> >=20
> > > +             type =3D=3D PCA9450_TYPE_PCA9450A ? "pca9450a" :
> > > +             (type =3D=3D PCA9450_TYPE_PCA9451A ? "pca9451a" :
> >=20
> > "pca9450bc"));
> >=20
> > >
> > >
> > >       return 0;
> > > =20
> > >  }
> > >=20
> > > @@ -865,6 +1099,10 @@ static const struct of_device_id
> > > pca9450_of_match[] =3D { .compatible =3D "nxp,pca9450c",
> > >=20
> > >               .data =3D (void *)PCA9450_TYPE_PCA9450BC,
> > >      =20
> > >       },
> > >=20
> > > +     {
> > > +             .compatible =3D "nxp,pca9451a",
> > > +             .data =3D (void *)PCA9450_TYPE_PCA9451A,
> > > +     },
> > >=20
> > >       { }
> > > =20
> > >  };
> > >  MODULE_DEVICE_TABLE(of, pca9450_of_match); diff --git
> > >=20
> > > a/include/linux/regulator/pca9450.h
> > > b/include/linux/regulator/pca9450.h index 3c01c2bf84f5..5dd79f52165a
> > > 100644
> > > --- a/include/linux/regulator/pca9450.h
> > > +++ b/include/linux/regulator/pca9450.h
> > > @@ -9,6 +9,7 @@
> > >=20
> > >  enum pca9450_chip_type {
> > > =20
> > >       PCA9450_TYPE_PCA9450A =3D 0,
> > >       PCA9450_TYPE_PCA9450BC,
> > >=20
> > > +     PCA9450_TYPE_PCA9451A,
> > >=20
> > >       PCA9450_TYPE_AMOUNT,
> > > =20
> > >  };
> > >
> > >
> > >
> > > @@ -93,6 +94,7 @@ enum {
> > >=20
> > >       PCA9450_MAX_REGISTER        =3D 0x2F,
> > > =20
> > >  };
> > >
> > >
> > >
> > > +#define PCA9450_REG_PWRCTRL_TOFF_DEB    BIT(5)
> >
> >
> >
> > Newline here please.
>=20
> Ok, will modify it.
> Thank you very much for your comments and efforts.
> BR
> Joy Zou
>=20
> >
> >
> > Best regards,
> > Alexander
> >
> >
> >
> > >  /* PCA9450 BUCK ENMODE bits */
> > >  #define BUCK_ENMODE_OFF                      0x00
> > >  #define BUCK_ENMODE_ONREQ            0x01
> >
> >
> >
> >
> > --
> > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, =
Germany
> > Amtsgericht M=C3=BCnchen, HRB 105018
> > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan=
 Schneider
> > http://www.tq-/
> > group.com%2F&data=3D05%7C01%7Cjoy.zou%40nxp.com%7C1ecbe75c432d464
> > cb45f08db61cb08bc%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
> > C638211296883052738%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> > MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%
> > 7C&sdata=3Dmz7vtBiDvAxY9FO7tTZO3oPBA8zvYS6f8hLgAwrU8uk%3D&reserved
> > =3D0
> >
> >
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/


