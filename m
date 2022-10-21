Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5F8606D25
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 03:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJUBq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 21:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJUBqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:46:51 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2155A226592;
        Thu, 20 Oct 2022 18:46:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fX6//82JSx9ke2gCriBVz06UgXMJqQ7uwUe6lOUwX+Asyyp6z65W/1f7iYG6M0kigVsIKU9wnPbJemWGa7H4D/bkKW9QpCjr/OMQr1M12WEuj0l4kcTx/sh3zcTo2sMvAG+N/1LX6WOZlWVem8m/Qcq53TxH42+crWvNTWiDYIIoztMwvZW8mu6qMUTX+rrpXq1voSIZVXwWqQ2OEytns97sqWUSrk4CzCgojQjix1VoDICSKW0YmPH0Gd/raH7x2KwW+YlI0cMR/WpghXGRkP6gM1NFgk9XBI6jqJLAvouGVMNYIxOMDMfGR0elnwTLHevfqxaQkK0y4CLU7MK93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9tZ9jV93bQ9P9GBUbOfVpkA07fCJFi6T2R1LeP6Nag=;
 b=Tpw/PSYqwNy3UsUd82QcOeptH63mTO0qunsMjBqR9fq2iPQsTaCu4WVAWwY5x3O0NkVqrqyiLVPHBJLFkfT1j7uT8l2HTd6oEH3pSOSsfxMWXWvG0pNyal38KrcGWhFH3IrQBpMfQNhwk8EP8gwEMEADPOjOnyACr+Sb+SuXC5QOQ/Wn9cqJB6qZV8DMNJXYDtA9gX40t4B13cS0Rj0fs5xe4hWq0wsSrYSNqiWPuj74uTKpzLQyIV64BrRT+1Uq/+wePr7oFiDXThMLH+P0ONmB8DEPSXjw0Owg45LamLnIBoZmlVAzcqP+KoX55l4oJ/jkP83xpUkqrMW9EbetNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9tZ9jV93bQ9P9GBUbOfVpkA07fCJFi6T2R1LeP6Nag=;
 b=sw2vze73NQvionva4V0hqez5Kqkn+NPD28kWR4vwOAMVEpOqJ/Q6VWTsiBJUTsTfvqG2bq4d/+cb+vMkTusPdTn2NAdtoj5AfycWN5uXDTGDE03TiJtaxIwfYd46vJ2ycRiz0ovm2pOCnmFQlbI/0SCYraeJP8gOPRQkQgs7RjM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8204.eurprd04.prod.outlook.com (2603:10a6:10:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 01:46:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 01:46:46 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: spi: fsl-imx-cspi: update i.MX8MP
 binding
Thread-Topic: [PATCH 1/2] dt-bindings: spi: fsl-imx-cspi: update i.MX8MP
 binding
Thread-Index: AQHY5G78ayDcx+I0EU6hKLmDPIgYmq4XPdiAgADW+vA=
Date:   Fri, 21 Oct 2022 01:46:46 +0000
Message-ID: <DU0PR04MB9417FFB2605B8026312EE831882D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221020103158.2273874-1-peng.fan@oss.nxp.com>
 <20221020103158.2273874-2-peng.fan@oss.nxp.com>
 <166626975547.1096642.8539184924637719626.robh@kernel.org>
In-Reply-To: <166626975547.1096642.8539184924637719626.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB8204:EE_
x-ms-office365-filtering-correlation-id: abe2e4da-3dbc-4a12-c813-08dab3061cf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sikapDkWUA3+kwCkd9gMYv7CvFWQIgtSgdzNFverH3xU9tqjpexiehRCSzN8uRevQVN3pYTL6M5VQuCt2Gzi1ra0DsDlhPVxdCCKdps8xvrOx2rMoczOWirccCxnHwR718dVD2PFSW8GqELwPKeyvKAR16PXtP6blHJ/u6vUVXLzOJ9iS5scepQdp3euZIvrmVN+sJ0eYPs1/hwiSVTeGpAQox8RjVjMRHD8TSEFx5UBraj1VqNFuMfz03cbLwBgLjGg8aRwZmX/X9+b6z+0qEtlaYBsQMI1LZxZwaSLlRfwGqxYnUCyXTciO55u4M/zenJl5gaJk1chTWwyjYDFYBI3J70y4kLF+7v/nNRIkOQrAbhjA/UGXvVYHGiOhmlm8tODziZ3l0VUtLAL+dTWMAfmV9T1jR7tz9fbQgGXApNNb17YNrhwjrezlFgpz+f9P2MBidxHE5FAQVxZMEQd8g8cITXZvjL56dU7Hocb41VOHzzgPdoT0DAlwbaWAMS2iFhPnxormNY0nulkYXPwkTFZFkSoUJmsjX1SY1M9YbS4UPMU8aTp2obZtKVewGmLohqSAWYqtmDGf2N8TUxiUbJ0aXvmfyVg0oAsSEtKjjwVGkEUN/9DHP+GiubqfxL1ZXBbKa1O3POTUDkm9bj+YbUyXOOpXKJwHsI2T9YI6ym4QEYTUA5ugqimry8QqriGIpKtLTYjP8qra4+07GvbW6kbTIa2+TKsejwZw3so7UvrMYDxzfznkn0I0BcU44BAwVf+Mpm1f+1sEgOp3heUy0zxXIUbV+CvLZhTy7eo2fs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199015)(38070700005)(122000001)(38100700002)(86362001)(33656002)(55016003)(2906002)(71200400001)(30864003)(45080400002)(15650500001)(44832011)(478600001)(966005)(66446008)(316002)(41300700001)(64756008)(4326008)(8676002)(66556008)(76116006)(66476007)(8936002)(66946007)(7416002)(52536014)(54906003)(5660300002)(110136005)(83380400001)(9686003)(26005)(7696005)(6506007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YR5ETb6Q9CZvXpjA/CTwsGfGMleB9yA+KOG8J6hIFY2Bam8Xw4yWuxIM8ONW?=
 =?us-ascii?Q?Wj9M9st1dx/Yv4HW7h4JZztHdIEJRLOvfjzkNmbB4VIhQyZLCNP63zOH+kIi?=
 =?us-ascii?Q?Ev3QeghUUQ/Xcw5bEQeZPeolyeDTTtYEe61I/6m+p7WHqUvBx2RXOtIvkpz6?=
 =?us-ascii?Q?zVt0tDIPVwtLb2OuX1iUt9bFf7H9hGOaXx6uTewggW9JY5B1VGz+E3cpR9Zo?=
 =?us-ascii?Q?IE0iz/9udV/AHB0xumTplRw0UkIbDRueXJLwLK+7BYanWYBs5rK2CdwoarfB?=
 =?us-ascii?Q?q8eV+S8seJNCeDmSLtIBDLSfe/h5lOTjGOtw1FNUKvcXaXTS0kmOM/7YW353?=
 =?us-ascii?Q?sFDslJ3F1hT/RmngMZac7WWcTaH2jd/NLd9ZKvxylixs/51Kzl9LRvreS41a?=
 =?us-ascii?Q?GlA0S4h4j5geSKUm7F9GICuTaPbr8Rx2ahCIS0iPY+qHkLXFXvbEoOe+ZOZz?=
 =?us-ascii?Q?tCfHCOBXIchgUK9SkFF2240ynI6D77s1YTm5lW4yZ6Nf2U45QuhR5y0bh2pr?=
 =?us-ascii?Q?jSD6JnwXKPwAacIFY8KP1vFw9le/D1QjUYkKInrhjPlJOzEkAS002ZPTzMBZ?=
 =?us-ascii?Q?2BuZarXv+33NTeVCgnL/1LEJv9hxOlPcQEuFE6DL3sLL65Vev1jmpZKM/rIu?=
 =?us-ascii?Q?evKMMfDvIUcBvis/oa+sxWm9YK3U1XwND8+fQvpIittD+E4/EMGMjgnV8AYo?=
 =?us-ascii?Q?hx+a/ygmh/uQXw3lp0HE0JFeEGci8cKeoMOhkHH4/q5y8rL/z+HZAduIv4ux?=
 =?us-ascii?Q?t07qMlc+HsCymaIopfWxPkJlbODw1N5iXddzHHFF1KxrI+nvqOjHUs4nSr+J?=
 =?us-ascii?Q?omrEMDVEkfVdMwuZRgkUfz9YuosgLhhKHtfWUZe3MOkfaFsAmJ5Y599UDZp/?=
 =?us-ascii?Q?FPYlGGbn/Bzcl1ScvwM00SF8//OyiKSZMLozOQijie6kqEhLe0GNNR6lqz4Q?=
 =?us-ascii?Q?06Yb0s/u2+hnDQTenB16CJ2sBFjJdBuknEJoBEDLExbRaPl6ZHVY7DpP3bc5?=
 =?us-ascii?Q?mVls/fEN++4W1LoSVbATru/cQR//foCTOVYtYe3KmI9AX6V/urAZLCT/ShZi?=
 =?us-ascii?Q?Es1EaNaoR9MSLc6JuVNpUkYo56llYQl3Fk4Z24mXC0mayRoJ/0q0brLiV8s2?=
 =?us-ascii?Q?eqN7XgNRoDWGZMUSyVpPDiGDkjmxEegsS15fgeNf4xXT3fppFhrHtuLNeQ0m?=
 =?us-ascii?Q?sRIryrw9LNeXoeliP7jTxSZoEBuClNvlGZO3deROAvviB7XstaXqa0UAPxJP?=
 =?us-ascii?Q?fCdvkJsXYt5S9zXgyhzFFBOKIIKct8JSqche3FRVFcrvB5yx34f5B4kLoIsw?=
 =?us-ascii?Q?sbwI7zocARTBVm/41+l2t5TofDVFxe2mtV203eIDbudfLDi3A0nFJHOUDyXA?=
 =?us-ascii?Q?/5DmIFxBltty5IoliqhGW5mUv32myYlRZOOOjKMTakjs9oUkA1VdOJqsI/e8?=
 =?us-ascii?Q?V5dRt+YHqi3jCccoArSZMmTuLW4VZsWQ7uAfePPH+y2NAJCuZwHrf4feeeWX?=
 =?us-ascii?Q?kRrmxQIpCwUHUo3tDgnUNMe1lCznqdYV6cwo9ivTyS1DtsgpsCrDSoEfuO/8?=
 =?us-ascii?Q?t04f/qKfVyncHxRbXCo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe2e4da-3dbc-4a12-c813-08dab3061cf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 01:46:46.3497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KgBqd/g+2ztndfcqo0ZMKEnwj49ZUMpjUiobWqchaQqVzjWEzA4DnZn9DjtYDHZIMaAkX58RmxdBpvNW1TGgTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8204
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> Subject: Re: [PATCH 1/2] dt-bindings: spi: fsl-imx-cspi: update i.MX8MP
> binding
>=20
> On Thu, 20 Oct 2022 18:31:57 +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX8MP ECSPI is derived from i.MX6UL, so update the binding.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
>=20
> Running 'make dtbs_check' with the schema in this patch gives the followi=
ng
> warnings. Consider if they are expected or the schema is incorrect. These
> may not be new warnings.

Patch 2/2 updates the compatible string which could resolved the dtbs_check
failure for i.MX8MP boards.

Thanks,
Peng.

>=20
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
>=20
> Full log is available here:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatc
> hwork.ozlabs.org%2Fpatch%2F&amp;data=3D05%7C01%7Cpeng.fan%40nxp.c
> om%7Cbd5f3e7566774254285308dab29a7eb5%7C686ea1d3bc2b4c6fa92cd
> 99c5c301635%7C0%7C1%7C638018673864797750%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> 6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DZawGt%2BSCPrZkiNU3WYRy%
> 2F2JqCVY%2FtRWfVC%2BCTRcC0Fs%3D&amp;reserved=3D0
>=20
>=20
> spi@30630000: Unevaluated properties are not allowed ('num-chipselects'
> was unexpected)
> 	arch/arm/boot/dts/imx7d-flex-concentrator.dtb
> 	arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dtb
>=20
> spi@30820000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-
> edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-
> mba8mpxl.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb
>=20
> spi@30820000: Unevaluated properties are not allowed ('compatible' was
> unexpected)
> 	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-
> edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-
> mba8mpxl.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb
>=20
> spi@30830000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-
> edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-
> mba8mpxl.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb
>=20
> spi@30830000: Unevaluated properties are not allowed ('compatible' was
> unexpected)
> 	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-
> edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-
> mba8mpxl.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb
>=20
> spi@30830000: Unevaluated properties are not allowed ('num-chipselects'
> was unexpected)
> 	arch/arm/boot/dts/imx7d-flex-concentrator.dtb
> 	arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dtb
>=20
> spi@30840000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-
> edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-
> mba8mpxl.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb
>=20
> spi@30840000: Unevaluated properties are not allowed ('compatible' was
> unexpected)
> 	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-
> edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-
> mba8mpxl.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb
>=20
> spi@43fa4000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-
> qvga.dtb
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-
> svga.dtb
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-
> vga.dtb
> 	arch/arm/boot/dts/imx25-karo-tx25.dtb
> 	arch/arm/boot/dts/imx25-pdk.dtb
>=20
> spi@43fa4000: Unevaluated properties are not allowed ('compatible' was
> unexpected)
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-
> qvga.dtb
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-
> svga.dtb
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-
> vga.dtb
> 	arch/arm/boot/dts/imx25-karo-tx25.dtb
> 	arch/arm/boot/dts/imx25-pdk.dtb
>=20
> spi@50004000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-
> qvga.dtb
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-
> svga.dtb
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-
> vga.dtb
> 	arch/arm/boot/dts/imx25-karo-tx25.dtb
> 	arch/arm/boot/dts/imx25-pdk.dtb
>=20
> spi@50004000: Unevaluated properties are not allowed ('compatible' was
> unexpected)
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-
> qvga.dtb
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-
> svga.dtb
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-
> vga.dtb
> 	arch/arm/boot/dts/imx25-karo-tx25.dtb
> 	arch/arm/boot/dts/imx25-pdk.dtb
>=20
> spi@50010000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-
> qvga.dtb
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-
> svga.dtb
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-
> vga.dtb
> 	arch/arm/boot/dts/imx25-karo-tx25.dtb
> 	arch/arm/boot/dts/imx25-pdk.dtb
> 	arch/arm/boot/dts/imx53-ard.dtb
> 	arch/arm/boot/dts/imx53-cx9020.dtb
> 	arch/arm/boot/dts/imx53-kp-ddc.dtb
> 	arch/arm/boot/dts/imx53-kp-hsc.dtb
> 	arch/arm/boot/dts/imx53-m53evk.dtb
> 	arch/arm/boot/dts/imx53-m53menlo.dtb
> 	arch/arm/boot/dts/imx53-mba53.dtb
> 	arch/arm/boot/dts/imx53-ppd.dtb
> 	arch/arm/boot/dts/imx53-qsb.dtb
> 	arch/arm/boot/dts/imx53-qsrb.dtb
> 	arch/arm/boot/dts/imx53-smd.dtb
> 	arch/arm/boot/dts/imx53-tx53-x03x.dtb
> 	arch/arm/boot/dts/imx53-tx53-x13x.dtb
> 	arch/arm/boot/dts/imx53-usbarmory.dtb
> 	arch/arm/boot/dts/imx53-voipac-bsb.dtb
>=20
> spi@50010000: Unevaluated properties are not allowed ('compatible' was
> unexpected)
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-
> qvga.dtb
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-
> svga.dtb
> 	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-
> vga.dtb
> 	arch/arm/boot/dts/imx25-karo-tx25.dtb
> 	arch/arm/boot/dts/imx25-pdk.dtb
> 	arch/arm/boot/dts/imx53-ard.dtb
> 	arch/arm/boot/dts/imx53-cx9020.dtb
> 	arch/arm/boot/dts/imx53-kp-ddc.dtb
> 	arch/arm/boot/dts/imx53-kp-hsc.dtb
> 	arch/arm/boot/dts/imx53-m53evk.dtb
> 	arch/arm/boot/dts/imx53-m53menlo.dtb
> 	arch/arm/boot/dts/imx53-mba53.dtb
> 	arch/arm/boot/dts/imx53-ppd.dtb
> 	arch/arm/boot/dts/imx53-qsb.dtb
> 	arch/arm/boot/dts/imx53-qsrb.dtb
> 	arch/arm/boot/dts/imx53-smd.dtb
> 	arch/arm/boot/dts/imx53-tx53-x03x.dtb
> 	arch/arm/boot/dts/imx53-tx53-x13x.dtb
> 	arch/arm/boot/dts/imx53-usbarmory.dtb
> 	arch/arm/boot/dts/imx53-voipac-bsb.dtb
>=20
> spi@63fac000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	arch/arm/boot/dts/imx53-ard.dtb
> 	arch/arm/boot/dts/imx53-cx9020.dtb
> 	arch/arm/boot/dts/imx53-kp-ddc.dtb
> 	arch/arm/boot/dts/imx53-kp-hsc.dtb
> 	arch/arm/boot/dts/imx53-m53evk.dtb
> 	arch/arm/boot/dts/imx53-m53menlo.dtb
> 	arch/arm/boot/dts/imx53-mba53.dtb
> 	arch/arm/boot/dts/imx53-ppd.dtb
> 	arch/arm/boot/dts/imx53-qsb.dtb
> 	arch/arm/boot/dts/imx53-qsrb.dtb
> 	arch/arm/boot/dts/imx53-smd.dtb
> 	arch/arm/boot/dts/imx53-tx53-x03x.dtb
> 	arch/arm/boot/dts/imx53-tx53-x13x.dtb
> 	arch/arm/boot/dts/imx53-usbarmory.dtb
> 	arch/arm/boot/dts/imx53-voipac-bsb.dtb
>=20
> spi@63fac000: Unevaluated properties are not allowed ('compatible' was
> unexpected)
> 	arch/arm/boot/dts/imx53-ard.dtb
> 	arch/arm/boot/dts/imx53-cx9020.dtb
> 	arch/arm/boot/dts/imx53-kp-ddc.dtb
> 	arch/arm/boot/dts/imx53-kp-hsc.dtb
> 	arch/arm/boot/dts/imx53-m53evk.dtb
> 	arch/arm/boot/dts/imx53-m53menlo.dtb
> 	arch/arm/boot/dts/imx53-mba53.dtb
> 	arch/arm/boot/dts/imx53-ppd.dtb
> 	arch/arm/boot/dts/imx53-qsb.dtb
> 	arch/arm/boot/dts/imx53-qsrb.dtb
> 	arch/arm/boot/dts/imx53-smd.dtb
> 	arch/arm/boot/dts/imx53-tx53-x03x.dtb
> 	arch/arm/boot/dts/imx53-tx53-x13x.dtb
> 	arch/arm/boot/dts/imx53-usbarmory.dtb
> 	arch/arm/boot/dts/imx53-voipac-bsb.dtb
>=20
> spi@63fc0000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	arch/arm/boot/dts/imx50-evk.dtb
> 	arch/arm/boot/dts/imx50-kobo-aura.dtb
> 	arch/arm/boot/dts/imx53-ard.dtb
> 	arch/arm/boot/dts/imx53-cx9020.dtb
> 	arch/arm/boot/dts/imx53-kp-ddc.dtb
> 	arch/arm/boot/dts/imx53-kp-hsc.dtb
> 	arch/arm/boot/dts/imx53-m53evk.dtb
> 	arch/arm/boot/dts/imx53-m53menlo.dtb
> 	arch/arm/boot/dts/imx53-mba53.dtb
> 	arch/arm/boot/dts/imx53-ppd.dtb
> 	arch/arm/boot/dts/imx53-qsb.dtb
> 	arch/arm/boot/dts/imx53-qsrb.dtb
> 	arch/arm/boot/dts/imx53-smd.dtb
> 	arch/arm/boot/dts/imx53-tx53-x03x.dtb
> 	arch/arm/boot/dts/imx53-tx53-x13x.dtb
> 	arch/arm/boot/dts/imx53-usbarmory.dtb
> 	arch/arm/boot/dts/imx53-voipac-bsb.dtb
>=20
> spi@63fc0000: Unevaluated properties are not allowed ('compatible' was
> unexpected)
> 	arch/arm/boot/dts/imx50-evk.dtb
> 	arch/arm/boot/dts/imx50-kobo-aura.dtb
> 	arch/arm/boot/dts/imx53-ard.dtb
> 	arch/arm/boot/dts/imx53-cx9020.dtb
> 	arch/arm/boot/dts/imx53-kp-ddc.dtb
> 	arch/arm/boot/dts/imx53-kp-hsc.dtb
> 	arch/arm/boot/dts/imx53-m53evk.dtb
> 	arch/arm/boot/dts/imx53-m53menlo.dtb
> 	arch/arm/boot/dts/imx53-mba53.dtb
> 	arch/arm/boot/dts/imx53-ppd.dtb
> 	arch/arm/boot/dts/imx53-qsb.dtb
> 	arch/arm/boot/dts/imx53-qsrb.dtb
> 	arch/arm/boot/dts/imx53-smd.dtb
> 	arch/arm/boot/dts/imx53-tx53-x03x.dtb
> 	arch/arm/boot/dts/imx53-tx53-x13x.dtb
> 	arch/arm/boot/dts/imx53-usbarmory.dtb
> 	arch/arm/boot/dts/imx53-voipac-bsb.dtb
>=20
> spi@83fc0000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	arch/arm/boot/dts/imx51-apf51dev.dtb
> 	arch/arm/boot/dts/imx51-apf51.dtb
> 	arch/arm/boot/dts/imx51-babbage.dtb
> 	arch/arm/boot/dts/imx51-digi-connectcore-jsk.dtb
> 	arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dtb
> 	arch/arm/boot/dts/imx51-ts4800.dtb
> 	arch/arm/boot/dts/imx51-zii-rdu1.dtb
> 	arch/arm/boot/dts/imx51-zii-scu2-mezz.dtb
> 	arch/arm/boot/dts/imx51-zii-scu3-esb.dtb
>=20
> spi@83fc0000: Unevaluated properties are not allowed ('compatible' was
> unexpected)
> 	arch/arm/boot/dts/imx51-apf51dev.dtb
> 	arch/arm/boot/dts/imx51-apf51.dtb
> 	arch/arm/boot/dts/imx51-babbage.dtb
> 	arch/arm/boot/dts/imx51-digi-connectcore-jsk.dtb
> 	arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dtb
> 	arch/arm/boot/dts/imx51-ts4800.dtb
> 	arch/arm/boot/dts/imx51-zii-rdu1.dtb
> 	arch/arm/boot/dts/imx51-zii-scu2-mezz.dtb
> 	arch/arm/boot/dts/imx51-zii-scu3-esb.dtb

