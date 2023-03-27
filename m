Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA74D6CA0B3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjC0KAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjC0KA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:00:27 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA95319AC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqVMEKpGWjQ/pkwx20lM9DdsR/ZqvDGUu1A3KHrw6gpraSYLCBZHki31T/F+8UyLCwwenUEox1oNooQjzrvKt5ATaP/NagJ52N3Qn1o7tqpYBr1pqm+8K60KihaG64l60SivYY9saEDX3jciE3uR3cH4nnTqS8/HM+5fjZ99em93CgcoeU/wGGJVScn8OHVAK+hsLypAziatTcFp1WfqI0v96M1aXv6vuN2J5j/cYzoLY58S8OdHLNXtwTWujbj0ishYPkgokub3DqVGUKJc3/Ismezs23TrHMrSePUk0e0eASZZnU3BcVy1W3VwyXbcmXAYA47jNiP4vz5flEFm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAzgzLKwlyXcC5cv+X5EUr64WZApKwq5jFEgwWjYjTU=;
 b=ZX8rHPvJhFN4x0rqqAiea4nGdpMANVX6APcdqzr8NCAGDuTwlBeT0TmJ8LM9x8NM6AOzLcZiClqHcoi7cBolsW/t+MS7v8rK5uJRldEWHTVBeVJ1MCXvxPoh4qC3HengZ6xQ2h2JJkNLvEF/hBaNQ7GKehU13pADQ6Z43BdhXwGqIw0LTIotucGzJhj7xKEDF4MdtKDFJOoYK1qRLO8i7QkrL2qYd4qhhvniUvNHol96I7wfNUAYsBfkrM/vfA4SMW7m72lGbFIEqrcw3UsLUyDGOCG/NUVpqabR/BQ2ljJG+98kOzLS5CH9PHZrfB/KJEdDQiOE5S8aSvECSyhuFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAzgzLKwlyXcC5cv+X5EUr64WZApKwq5jFEgwWjYjTU=;
 b=e/n/2X7hPN6KtOcg1GvXLl3jGS7lx6h9REhf9BG+owWjV3NL6NTyHDEnK9vcogyQfT9f8+vAI3ErNH9WDeYtXWi1JlKNjfNcgsYkvsAZR8DSC9g8BO7jncuqg0hdiQSDeerrJToOJh+tTUg/fve3sKGYnLYTSkR0KY7jVNOiOR0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7395.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Mon, 27 Mar
 2023 10:00:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Mon, 27 Mar 2023
 10:00:20 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] arm64: dts: imx8mn-evk: update i2c pinctrl to match
 dtschema
Thread-Topic: [PATCH] arm64: dts: imx8mn-evk: update i2c pinctrl to match
 dtschema
Thread-Index: AQHZXXiekdyOQbnQMkqzSx0+H1Iuy68OGvqAgABPwOA=
Date:   Mon, 27 Mar 2023 10:00:20 +0000
Message-ID: <DU0PR04MB9417EDFAD943EBF9F0EB2A35888B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230323111924.102541-1-peng.fan@oss.nxp.com>
 <20230327051409.GO3364759@dragon>
In-Reply-To: <20230327051409.GO3364759@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM8PR04MB7395:EE_
x-ms-office365-filtering-correlation-id: d26a4e70-cadc-45de-dbe8-08db2eaa1340
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ws5FmhGn0Anp19Uba/KhqZLQRyU7eOLQhr5o9K2ZVmY9xn3jlTBouftxIYOOWny+rL7sAQbUa+oo4utGSfNYPpen4DWJKs2nAdbt0q/Fv9SZCPonGVSCUVQK651tRyHqGDieRXCmpY0mXRbO/FFg8GZ77xSaoJSjds5muHb/1htltQ4QFpTGpzk4zq9Pho4GsXpbhCTyfk/ssY+bcETSIiYq9OABmPYFe5IbZPGsAkokLcPa+v92H4lWcwxbW0H9SQtMv19asMYncD9AyK41tjrbSiK2LBgPTbUYt9P/Uwhf66dwFKMOMoStDY/emxZmK5cf04N6hdKcnFmuz0WCUSO+thQmiMFmPz2Rf84VQv4ZhJnEU14mZ01ifTjjKEAnk0bBMqkcnOVm8jYRunxgcEMIQwOPqCci3P7dl/JPghBuBwsmPSUR9PeF+5CXKAub0LByGIT2iW49MwztgSFepk9VoZxGtmX9I+mgJUncsdmiUNzdRKtsO+U2+FkCpBGE7gVSOQvj+oGWdAraFBagMlX7iCs2lX4yOnrRlQCWia8/3Lzh+yml0GoOvlXTCnd5d0ogJkDZTap4MUQo1q8EOgb1J3MC3JW8tL5D6Uf/EBxMdKWR7IBhTphHgxR+Y/zF2uFHMBXnAa+FC7GCzpr2Qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199021)(83380400001)(2906002)(15650500001)(86362001)(33656002)(7696005)(26005)(44832011)(186003)(110136005)(316002)(71200400001)(54906003)(478600001)(55016003)(38070700005)(9686003)(122000001)(38100700002)(4326008)(8676002)(52536014)(5660300002)(66446008)(64756008)(66946007)(76116006)(66476007)(66556008)(41300700001)(8936002)(6506007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Rq50sftCrBZjYDYlu9vwKjjd4PwAQNJG/+7mQtFGD/Uq6q869SaQLH9A3uU?=
 =?us-ascii?Q?7M8DrciMYY6OhJNWtV42d3x5mvZZtfK1GSaAwl2zsb0ox79fUmo88wDUSV8R?=
 =?us-ascii?Q?xAVGTre1U98PdEWi8lSjGYPn+75GYKlgS/T/IW9OD0LbDs4V12Pnt+gwU70C?=
 =?us-ascii?Q?s1hdTrSwghwsao7ayjTk2UfimXpEjOb17i4SshXNdlW0n74rUm/BTN2/qwsD?=
 =?us-ascii?Q?ZVt6m4Jz1TA92PXa65Mi/AsPkGN+R/+a0XCWoKl0WoaS+nLN/Xh/SwBbXDxY?=
 =?us-ascii?Q?3o4KNhVv6h0EhPmjLFG7QZZs+tYzYzScBCCM7hGU+9DwJKkTfOn+P0ZILb0z?=
 =?us-ascii?Q?Fn16Thca6oSh8z+5i4g9MdTeKsY6fVvcJBA9z6z3lZyvMgKYVVGUKFab5EuZ?=
 =?us-ascii?Q?RggcuafsjyUPsW6NM90oFI7lqxnNjtL7x62EEE9y34QVYlFYdzKx8qppuSV8?=
 =?us-ascii?Q?2PS2fHtwbvR+wLO4eJZap68QG2O/rt4M8pIrCXvAl9aP8PVqeF76p++kYk+6?=
 =?us-ascii?Q?Pw5DnXrvAM/K0hg/dpPr1QsdskmfYztVgJxiZsaHXT8vzGLPz62UbF7EI7j/?=
 =?us-ascii?Q?7WclSzVdUKVxCF4OUhP8hGyMTyIlut3KYmnHaWOB0o3/lT37unbEj0ONEUos?=
 =?us-ascii?Q?rM0s+zrwwoL4osYJxFqSCDymDK8M8GStv3vxDVNYNYVK0yl9TfrOBnIE8Zt5?=
 =?us-ascii?Q?aOWY+ZfdqpvIeLrTqt98I67CizTHj6CF6k/Fjl1m6Q4kyp46NnD3MuYVLKbg?=
 =?us-ascii?Q?KaVI33gWOKjZF3jchUbVAVZaf4BbfL0LzdPf5ErdFzUSfe7XSC9fsgMh5b/t?=
 =?us-ascii?Q?9AnLgrUI7JT/mRs1VbUc/HkccQi/cmHHYHHNC6Ucb2+y9g/kwoe/KOvl7fae?=
 =?us-ascii?Q?uZFhkO+QLBl4KR/cASvcohRrYyjx2C0coi9Ma95RVGtXdiJayF7iwIezfE+i?=
 =?us-ascii?Q?4rQQXmXhAq7d8+qtldDEfFuJT/9VIrHgh1RYCcGhL/hOUmN76AbR6ATELJbJ?=
 =?us-ascii?Q?KtHi2d3h5kq07XYVaHhfzypFdADVZ8fW5y4b061er8R2if/h0sA8R2wqg0MC?=
 =?us-ascii?Q?x5mf5L4xy9aiUwHvLuXiYV+0vQFBTFT97N9hLqK3JWDA+nO0PRyAjqUQACQX?=
 =?us-ascii?Q?SlYxLMEZ/7aDuE2OxDFlWLtpXVwLBSCMPyXFSUH/WC3YYhGXs3OGlmF038JH?=
 =?us-ascii?Q?F1TkHHNPmmpTUKF11Ba7f3un051UixxH7JS3Km62i1KlVtSbnhzHJeK8DuWG?=
 =?us-ascii?Q?ZsyjB65zWZTSqL6osM0UDueEkT+H0DmDFix5W7lTnAwOe2pwxFZ+tzUCHcYx?=
 =?us-ascii?Q?6dwEtDnA/uxssaZA0jBTItI0b8xjABPbMZ4Y3oxn31teAYIR+BqOeEF6sbLH?=
 =?us-ascii?Q?UnUBdfFwzQaLsanpPj8c+DeZ1RcKw3541oPsmlvtb8dfbVGMLb11DySULLjk?=
 =?us-ascii?Q?7n83O72ZOxD4LSJTZeJnVfA9iaf6a8S2EHK66ddeZ/sBQtk6GcPa2rAmbo/w?=
 =?us-ascii?Q?3t7LZAto0BC/nVRI//U4eNpjng0Bxxh5USVjVKrTh5+Ddbr5cgNd9FiLFHic?=
 =?us-ascii?Q?2OfI0NV+W5hGyDhAHmA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26a4e70-cadc-45de-dbe8-08db2eaa1340
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 10:00:20.5266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7xgJFVwb2mjMoZJ8j1Hp4eNvnxLt/QMJrHXjZEhhv8WyVEuJEzRoSvw/CUkYHmAq1N9QLABXQRJz5Ek5PcX5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7395
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn,

> Subject: Re: [PATCH] arm64: dts: imx8mn-evk: update i2c pinctrl to match
> dtschema
>=20
> On Thu, Mar 23, 2023 at 07:19:24PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The dtschema requires 'grp' in the end, so update the name.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> > index 8fef980c4ab2..876eb5da5e2d 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> > @@ -389,7 +389,7 @@ MX8MN_IOMUXC_I2C2_SDA_I2C2_SDA
> 	0x400001c3
> >  		>;
> >  	};
> >
> > -	pinctrl_i2c2_gpio: i2c2grp-gpio {
> > +	pinctrl_i2c2_gpio: i2c2gpriogrp {
>=20
> i2c2gpiogrp
=20
Sorry, I not get your point, I already use i2c2gpiogrp.

Thanks,
Peng.

>=20
> Shawn
>=20
> >  		fsl,pins =3D <
> >  			MX8MN_IOMUXC_I2C2_SCL_GPIO5_IO16
> 	0x1c3
> >  			MX8MN_IOMUXC_I2C2_SDA_GPIO5_IO17
> 	0x1c3
> > @@ -403,7 +403,7 @@ MX8MN_IOMUXC_I2C3_SDA_I2C3_SDA
> 	0x400001c3
> >  		>;
> >  	};
> >
> > -	pinctrl_i2c3_gpio: i2c3grp-gpio {
> > +	pinctrl_i2c3_gpio: i2c3gpiogrp {
> >  		fsl,pins =3D <
> >  			MX8MN_IOMUXC_I2C3_SCL_GPIO5_IO18
> 	0x1c3
> >  			MX8MN_IOMUXC_I2C3_SDA_GPIO5_IO19
> 	0x1c3
> > --
> > 2.37.1
> >
