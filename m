Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6781C6CA2CB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjC0Ls7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjC0Ls4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:48:56 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A06359A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b21Gr2cRN5EZK2nbCKyTnleUytJA4DOC9Lm9P778j67twVUFQf3V1qJYpR59kfeknC9612g8EbkBlV9nsUAA9Ie9udQ1A6senIAF0RMFMLpu7dGLbYwXB2bYQ39x6ETpGWZ45BCzIQwWy1+/bpmhVBWpoNmZPI68zkMCh/ji8nyzaTm6PttuSeOOIMVP+SGQGgrevTKFaKxfLKSAnTQIA9zHvHvfP0j7lE8xTF3caVUuQGPZvb/QlF6eDwHJ8s13Ap77L6UB7Ly20hfM5vkGKtXIdW6HP7//5WbN/Pdl9nUWjWhYY+lReT095eeu0F/48ECwX157vdIpwXTREERZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBr7FE41OFU3VVJTCupmVRgBVcgJIhCLULGlSFMr/mc=;
 b=QB5BPZDTFinIRRqZxIAJsup4AaBDpyMxMij4tzbvt+sVHdUFuW3Gs/Z9NWuJ99zE1vkg29bHsvCq31u/7DJmAJtdpfi7DyXwkeADzMYuv68dFX36qhLA+OuJ0Fq4G6DIYUjp/KSNBZwglKOexmyftjkIAO9GiU7tCTLdK9zl5Tf8qLNkDdLmrby/+sOTSOnQAQAUKXiqnlGeGRscj0vNEs7V+rKBCkbfRyz5zfmMHugGfkBpe9jZd515e8+M1S0Ux01w/YS4BljgM7TBgOM9K4Q+Mstha79xW98wTc2nqEZ8kPKd1f6eO9j1FWOundwsywG4ASDZ4NIslOJaeKKyLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBr7FE41OFU3VVJTCupmVRgBVcgJIhCLULGlSFMr/mc=;
 b=guc+3HSQRbFtRwveepf68OBzjM2aUZ3KbOw6oYydUFERkgDYfddKxwYeNQyWVi96FyWkDEr6WwavQYWqUs+Us2PmKBJ5GiQ89PBmQNUf2mk92Eb1Ci6mLHaIXGvSQnI5wmtANo/DYulULhTMEzm1Wlp+Fo6j09L5T01NA6ehJag=
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by AS8PR04MB7638.eurprd04.prod.outlook.com (2603:10a6:20b:291::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 11:48:51 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::8e85:409:6bbd:aa9f]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::8e85:409:6bbd:aa9f%8]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 11:48:51 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Andreas Henriksson <andreas@fatal.se>,
        Marco Felsch <m.felsch@pengutronix.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Xu Yang <xu.yang_2@nxp.com>
Subject: RE: [PATCH] arm64: dts: imx8mp-evk: add dual-role usb port1 support
Thread-Topic: [PATCH] arm64: dts: imx8mp-evk: add dual-role usb port1 support
Thread-Index: AQHZXXZt5pMZSwGyAE6437fZs85FYq8JtdDggAShbYCAACxV0A==
Date:   Mon, 27 Mar 2023 11:48:51 +0000
Message-ID: <DB9PR04MB96282C22D3AC853F325373CD898B9@DB9PR04MB9628.eurprd04.prod.outlook.com>
References: <20230323105826.2058003-1-m.felsch@pengutronix.de>
 <PA4PR04MB964081F4DB2E16D8E300B08389849@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <20230327084947.dcguxgyo2lfen2ms@fatal.se>
In-Reply-To: <20230327084947.dcguxgyo2lfen2ms@fatal.se>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9628:EE_|AS8PR04MB7638:EE_
x-ms-office365-filtering-correlation-id: 6a64751b-6365-444f-38ec-08db2eb93c30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uJR2kpe+GQAHx63tZ+ORBeQtL2KKxhKBKv7HdrBCMTeDFY2uRYax8uD9AZ7wAP9iZqwdfODgyxMuI9WcCdOAwF7Pe6mNAZqpJsWP0d7yvthPIpyuLrUN+OqyGE8xlvm8q5XXofDWUBfg7L1jGYnOKXTgM9izO2iOuSHx0rfnvRWrrnhcs5HbIlCuYHQDGsSBcDrCTBnZheMOXB8dMrWa85wUQBdzpam71BVyygnEUOJ7kNXPCcyhwKCRlVSeMDbzjCxpRkS5Xr3dFN/04BumyxPtXr2Qy2ELQvT5TftMBeVcPgprQzj9X3Ov67Rl9Bgw5AHcTuw6DvWUfhvqo+RN7t+e2CBG+bL8DoOfxABBCLN9BpEPr3IX5xfPSPIzZ62vTjg95TT+dXNsOwGTMz0PP4j4XzfqfW9oXp1rgVggyxYNfuihMRA+vcIdCavlW7Nrk22RHsbejW8t3gn6Uloi1cR4leNJXNjf9SRcIxoyHJQxQ/TVSlMWwQJKVz++BTz6nMZc0GewYcQLVU4XJ+8fK56rQgvRCBpWzVGyGyIOQXgcJJXjygEEbYyXmUslsQTju6Vku3H/0byZWbiv3ZZ02XAhM4bWcLhyzeHMexpabTCxm6fUEqYLeqBnxt8vqnANKgl+BDfppPLTU0rLLFDrgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(110136005)(316002)(54906003)(478600001)(52536014)(8936002)(5660300002)(122000001)(38070700005)(86362001)(44832011)(38100700002)(66446008)(2906002)(4326008)(64756008)(8676002)(33656002)(66556008)(76116006)(66476007)(66946007)(41300700001)(186003)(55016003)(6506007)(26005)(9686003)(53546011)(83380400001)(71200400001)(7696005)(32563001)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C2fQFrwXaE9Cc3I3HL6Uo0lckNkTFUF6JQv0sBg14sAuIy0dAXNwLp63k4cE?=
 =?us-ascii?Q?ZMv0jmfuzmhlHLGmfsr8U7yzeLYvaChMXfvwqrrEu8pXwoQSrnCyvM4weRCo?=
 =?us-ascii?Q?I2nfXajbTBcAGZYPfj8DxRtsCXOvLW1Zo262ZbCdmlxC9mqM215MIJHwBU11?=
 =?us-ascii?Q?w5yroRrTgRXMLCKqF9PqODNQ4BW08EjhcGr9S0Vl3fCniIB22IkAhUIuhWJO?=
 =?us-ascii?Q?PV9uR43O/ehLKLVRBvsiCGw8rrjzoorhoiwkrhqMk9XR8S6QvHdx6t1dUsMB?=
 =?us-ascii?Q?Do//D8xSDZ7NsR6IiGXHrjOVXof3DpaDj7tXs09gPnRp66LolNLSwWrSV7A2?=
 =?us-ascii?Q?giiiczeeGQGld05pppO0SPRQHEgGBT1a3N+5Dp7WFgByH1ZSyLzY4P81lxw3?=
 =?us-ascii?Q?tsVaDN67fpg0MJ8G8mHgGqTQftFCTqrwy52fFfJ3moGKAgrNcoiaXFALXcC3?=
 =?us-ascii?Q?JuFXmacKmbGG7PK0TfrdPUlmgWlSbnsKPzMQXBuoaXVoaon/Oit74BzPpyX2?=
 =?us-ascii?Q?QHqTN6vWuJXRiV3pNmX5MwbT00DvQtfkpNCGqVlFe8yEHPgakdf20Q893uoB?=
 =?us-ascii?Q?2Iq7LmEEfjPQWiFsyro0EIkJ25NBmXOSIwcnseTvoCTiJpyTrN/weuM+gjwo?=
 =?us-ascii?Q?EaxIbOb1WDRbmudqRyhFbWMrr7o6JUBiMXbrEOykOGtavWCuOYwmgECH7jQK?=
 =?us-ascii?Q?rm0oqn11OhgkaJNeW4x8f2eUaC4YGiwhOeFdngO3C3wtnxLoJ8oca4z7EWGO?=
 =?us-ascii?Q?InG1RfXp0tO6duzsN/1fUGc5rKS2Va/rc4zfd+k54ivqpUQA1IW2PELG+FdY?=
 =?us-ascii?Q?p1RNb38Bh2eGrKtpfN6TGb2GqlDfsbfpAJ8I+lfg45vZGuP+jwDT1jQESzV6?=
 =?us-ascii?Q?wWCJiODguPhzSDAd7BKj733/PaWwDtvx+tFINe4phEDOylesJXHXxok0bx4B?=
 =?us-ascii?Q?SVwPZNU8lp6aLwRSNc5wjm4iDZa/3bpu/VQAj3RejFeg74rAB9B3YKLa5ce1?=
 =?us-ascii?Q?T+Rlph6s4E4KTmbFwUrsdCCMKo8a48pQMLyndR95s92olP3QBD2cerTy046J?=
 =?us-ascii?Q?3nNGd6VScylUwb2ihlxNxSNX5ghx1Rnwf4c0nCjr7dYbhwW89WffXjO9gHXg?=
 =?us-ascii?Q?17QI2RzyJ/Gh3NSzZDvCy4qZ/SU2aZzAlFnYTbCD1hA4teLIBDclenYQF99t?=
 =?us-ascii?Q?nGpdrAp4zL8yYT3lV+5UUXWxRiNAIgmDZ3c+JnlDpBYhrRnZQPsAM9ExFjAG?=
 =?us-ascii?Q?AJcOQPjhqV450WbOzA6E7nT059oaAams43iBqWXnHFaMg1h6/FJuo+ftTxri?=
 =?us-ascii?Q?P9RfFy2eU+f8Hl4Fy0HOmcyFtqPHAhqbr3lfXQ52+cZm0TLs/dNQA3imyvIf?=
 =?us-ascii?Q?Yvl1AcvVegrnouH2rIw4hbcYM3UstDZQCwyhdxYyx5iJ0yN6oq1FJAYPhE/H?=
 =?us-ascii?Q?M+SpWAFXjKpmB+P3+HRs63n1xfSUCyr9nPygoQaJeLDMvNvxM7PUOhM8nvtb?=
 =?us-ascii?Q?4CsGts7Qjk9+WSmCWXe8FIgmtpV9pkLWMZuipdAfVFzr4FmUMCozW/xz8lE1?=
 =?us-ascii?Q?ILDumNOSTtvArfibDgA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a64751b-6365-444f-38ec-08db2eb93c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 11:48:51.6521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1JLeQkAd1AUUl98llf6aVHECj2iRgUa6BDOZ5qxoAEP1Q/VHK5ejmEgWKW8pk2PV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7638
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andreas Henriksson <andreas@fatal.se>
> Sent: Monday, March 27, 2023 4:50 PM
> To: Jun Li <jun.li@nxp.com>; Marco Felsch <m.felsch@pengutronix.de>
> Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> shawnguo@kernel.org; dl-linux-imx <linux-imx@nxp.com>; festevam@gmail.com=
;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de; Xu Yang <xu.yang_2@nxp.com>
> Subject: Re: [PATCH] arm64: dts: imx8mp-evk: add dual-role usb port1 supp=
ort
>=20
> On Fri, Mar 24, 2023 at 10:18:17AM +0000, Jun Li wrote:
> >
> >
> > > -----Original Message-----
> > > From: Marco Felsch <m.felsch@pengutronix.de>
> > > Sent: Thursday, March 23, 2023 6:58 PM
> > > To: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > shawnguo@kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> > > festevam@gmail.com
> > > Cc: linux-arm-kernel@lists.infradead.org;
> > > linux-kernel@vger.kernel.org; kernel@pengutronix.de
> > > Subject: [PATCH] arm64: dts: imx8mp-evk: add dual-role usb port1
> > > support
> > >
> > > The i.MX8MP-EVK has a dual-role usb-type-c port marked as PORT1. By
> > > this commit the dual-role support is added which allows the
> > > user-space to assign usb-gadget functions to it via the configFS.
> >
> > So just ignore the orientation switch will make this port cannot work
> > at super speed, this is actually why this port is not enabled at upstre=
am.
> > I see the orientation switch via GPIO for SBU is already merged:
> > drivers/usb/typec/mux/gpio-sbu-mux.c
> > Do you have interest to expand this driver to support super speed
> > switch for this case?
> [...]
>=20
> FWIW This is what I ended up with (after backporting the gpio-sbu-mux pat=
ches)
> a little while ago trying to get the usb-c ports going on imx8mp-evk. I'v=
e
> not yet had the time to fully test this (only done host/device, not teste=
d:
> SS, orientation, etc), so beware that it might be completely wrong.

Thanks for the advice.

*reuse* compatible =3D "gpio-sbu-mux"; can make the basic *function* work,
but that's not the right direction, SBU has its own signal in typec connect=
or,
here what we need is the Super Speed signal switch, you can see iMX8MP EVK
use 2 GPIOs control the SS for 3 states(normal orientation, reserve orienta=
tion,
places all channels in high impedance state), but SBU will disable both cha=
nnels
at TYPEC_STATE_USB, this is not correct for USB data, so logically we canno=
t
reuse SBU either. But I think this gpio-sbu-mux.c driver can be extended to
add support super speed signal orientation.

Li Jun=20

>=20
> #include "dt-bindings/usb/pd.h"
>=20
> &usb3_phy0 {
>     vbus-power-supply =3D <&ptn5110>;
>     status =3D "okay";
> };
>=20
> &usb3_0 {
>     status =3D "okay";
> };
>=20
> &usb_dwc3_0 {
>     dr_mode =3D "otg";
>     hnp-disable;
>     srp-disable;
>     adp-disable;
>     usb-role-switch;
>     role-switch-default-mode =3D "peripheral";
>     snps,dis-u1-entry-quirk;
>     snps,dis-u2-entry-quirk;
>     status =3D "okay";
>=20
>     port {
>         usb3_drd_sw: endpoint {
>             remote-endpoint =3D <&typec_dr_sw>;
>         };
>     };
> };
>=20
> &i2c2 {
>     clock-frequency =3D <100000>;
>     pinctrl-names =3D "default";
>     pinctrl-0 =3D <&pinctrl_i2c2>;
>     status =3D "okay";
>=20
>     ptn5110: tcpc@50 {
>         compatible =3D "nxp,ptn5110";
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_typec>;
>         reg =3D <0x50>;
>=20
>         interrupt-parent =3D <&gpio4>;
>         interrupts =3D <19 IRQ_TYPE_LEVEL_LOW>;
>         status =3D "okay";
>=20
>         port {
>             typec_dr_sw: endpoint {
>                 remote-endpoint =3D <&usb3_drd_sw>;
>             };
>         };
>=20
>         usb_con: connector {
>             compatible =3D "usb-c-connector";
>             label =3D "USB-C";
>             power-role =3D "dual";
>             data-role =3D "dual";
>             try-power-role =3D "sink";
>             source-pdos =3D <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
>             sink-pdos =3D <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
>                      PDO_VAR(5000, 20000, 3000)>;
>             op-sink-microwatt =3D <15000000>;
>             self-powered;
>=20
>             ports {
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>=20
>                 port@1 {
>                     reg =3D <1>;
>                     typec_con_ss: endpoint {
>                         remote-endpoint =3D <&usb3_data_ss>;
>                     };
>                 };
>             };
>         };
>     };
>=20
> };
>=20
> &iomuxc {
>     pinctrl_typec: typec1grp {
>         fsl,pins =3D <
>             MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19    0x1c4
>         >;
>     };
>=20
>     pinctrl_typec_mux: typec1muxgrp {
>         fsl,pins =3D <
>             MX8MP_IOMUXC_SAI1_MCLK__GPIO4_IO20    0x16
>             MX8MP_IOMUXC_SD2_WP__GPIO2_IO20        0x16
>         >;
>     };
>=20
>=20
>     pinctrl_i2c2: i2c2grp {
>         fsl,pins =3D <
>             MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL        0x400001c2
>             MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA        0x400001c2
>         >;
>     };
> };
>=20
> / {
>     gpio-sbu-mux {
>         compatible =3D "gpio-sbu-mux";
>=20
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_typec_mux>;
>         select-gpios =3D <&gpio4 20 GPIO_ACTIVE_LOW>; // (PAD_)SAI1_MCLK =
->
> USB1_SS_SEL
>         enable-gpios =3D <&gpio2 20 GPIO_ACTIVE_LOW>; // (PAD_)SD2_WP ->
> USB1_TYPEC_EN_B -> TYPEC_EN_B
>=20
>         //mode-switch;
>         orientation-switch;
>=20
>         port {
>             usb3_data_ss: endpoint {
>                 remote-endpoint =3D <&typec_con_ss>;
>             };
>         };
>     };
> };
>=20
> Hope it might help.
>=20
> Regards,
> Andreas Henriksson
