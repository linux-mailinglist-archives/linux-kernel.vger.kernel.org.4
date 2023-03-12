Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0212E6B6611
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 13:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCLM56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 08:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCLM5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 08:57:55 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED734BEA7;
        Sun, 12 Mar 2023 05:57:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHoR1GDIbv+kUpRW40R+sqfQeqm0a2otfKYYE3984XSOYJkWLZMevw6aWh4AkOZ/NvBxYckcf4VKRFpTiBG6EInLRfV2BNYdcBuF/pTfR8bFWOaQTsm6pjYzPbBWdg2PddrU7W3P5jJkkMc5zYUqgnAq1fQzCj3xwYC6ZuN1z48fbqvLhPjGkjInwM3bRahqzOPXArgK9kcgnd5g7WAAgRK9NfHn9K7JKE1iZJ4jZYHmRkEh+bDPTfWvTaKNnNlESgJS9QFhRNNCiSPlVtiRi7/Yi9NMGOG5JEqtIrzL4Cbj6s9WahiACkJUSqU1RSbzmMZEq2Z3XPwpz1QJ+07DcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSlr+lNbeD1aiiqo/GcwkDy3znpnfzOMtiCJAg3PW/M=;
 b=LBL1RyczmtynmP7jNq2kI7fWkTCCgZAaVVE/UJEm+STiz17QSoUXLayj23mxJgs4IUWNIJ+yaGhakykCP3SBwn8OM7s2xNpkQHjap5GJZE8AF6r0D9ulIKBL7O43waVxVzaUEoj4a1gEULI33DbM1YJlN/lFgTjOkOxb1u4bo649uPN33roCzAIABUpxGQE4ndglihLSaXDIcplCriGH6qLsjyAqZbS2GvsnX7Nyp2yRj9BihlqtxThNXwgUsF0nWOzY3APpfRdmpw49YzB1ZS2767x8ZpXihBorzdQQGHQcLrcowzMfllfzVKSwAmzKuIkIomif+vqQGMxTVXUudg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSlr+lNbeD1aiiqo/GcwkDy3znpnfzOMtiCJAg3PW/M=;
 b=RyadmFDAslBq4reSCCXBoBV7O7/UKW2eFtBhr6gR54y1iw2gzS619+zDpSPzbVrJCBY8UtJGbHks/qLCw/fh7gfhTMi13ISPsdL4CWx2gysyfJC9oEVawqiaPF4+uWx9XgYinOYVVNGtTKUn7GTRnibfcDazAdIBqqBVwVAmQWM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Sun, 12 Mar
 2023 12:57:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.024; Sun, 12 Mar 2023
 12:57:51 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1] clk: imx6ul: fix "failed to get parent" error
Thread-Topic: [PATCH v1] clk: imx6ul: fix "failed to get parent" error
Thread-Index: AQHZU2+8jn4VzPFqR0+ypgqiFldpoa73HYTQ
Date:   Sun, 12 Mar 2023 12:57:51 +0000
Message-ID: <DU0PR04MB9417D33088377F41D33EF33088B89@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230310164523.534571-1-o.rempel@pengutronix.de>
In-Reply-To: <20230310164523.534571-1-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8963:EE_
x-ms-office365-filtering-correlation-id: d9b4da7f-daff-4923-b4b3-08db22f96385
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gGAy+G5e+CY2GAzPv26A/ewSIlv0aFg+fUBJ8QE1Dda9yf+uob72t7qg7O6q7YnbEwsLGj4sBWt5ZUuChET4ePO9eL8jAeO73+9u9VvftQ0TQ6TaekJY1PvNxsE8Wv1IsRZQGtZllObjuBxT5oRXODHTJ5Me58nPZ8UZU794+gaIKmYoH/Tbm3xM4s72zNjYDqa0fKbMBx5gQSAMVrKbwFwZwXLcknrQfeA5WNkhIJZAEdAIuc3aAYWxY74vY9jqZK75u4JJqSvzZOzNZioI2TcCXF4pht/xjEzPnmFAJvCPyFl3kFZqDseg0aeYkYbziwwifY/DGKosR5d1bd+Ax4Z3Uu1SH1PGo+iJbDsP2axTaVGDGwpVE7VyE4cqxc9qDH86nuyC7K170c6XcTG9eRO//g2AuI1RQ02ZK+hlvseR2+iOtwygJWHH+K3k6zS+kxMpkXMaAvs93BJ47DrcBOywypmlgyCiCAqCTwzWnjmFgGd5X90IUQukW7dtybsxvBOyMxR3yTccFiXbq2ZVLQ1a7hQExwEKaoFC6Nvbr1nz3+nQRFSQBELCL/BK8W/PDCLuy4BK2qFf0//XIJnL9lkA9z/gkLljvdEBE1PycqMScFwcmxhidE2jeW92EdlmPJ7xyrHgN88mXJe9W01wBC90H7rkT3ateryfqnXnij4kTgZHNv8imEYTjH5Jtnnr/D6xHzx5yGYg862ydr00oT47t7FehynRcuomeH7Um5s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199018)(38070700005)(71200400001)(2906002)(66946007)(41300700001)(76116006)(7696005)(66446008)(66476007)(66556008)(55016003)(64756008)(8676002)(33656002)(4326008)(478600001)(316002)(110136005)(86362001)(54906003)(122000001)(38100700002)(5660300002)(44832011)(26005)(6506007)(186003)(9686003)(7416002)(52536014)(8936002)(83380400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qyb6LpxPMFpAgcS4mDuN+J6DCflR9s/GAajIIg/h5xPJ1OVuorus/T7Ot1LI?=
 =?us-ascii?Q?8HvdsZRAPQ28OSkay69pnEBZjp3Sc6uZFWkIXuKU9JMsbUyzLr5jYV1Hpycr?=
 =?us-ascii?Q?x5sg5jj6TCau/6j0dU+JChcJXhfErYxJm1JmZ/Lf3pHPoWjha/6fOmMcRZtr?=
 =?us-ascii?Q?f8OsimOJL2zsRYMeF3z+igBpHEBQGbwl0QZBQ+KphgB1PLtkG/yB2oj0+Z1v?=
 =?us-ascii?Q?bkY9ebUng7Uh4I2H6O4jPWHpjmk3572aRd1TB0dwW/0NA6WLYMgO2+OMowMV?=
 =?us-ascii?Q?rGcw8BTfX8N820SDLXxT8YGkLX4rU+DL9jt0NDbjsjvmyirxeqsJ/CsmUBSB?=
 =?us-ascii?Q?o+53l1GxVCNtd9J0nT9DVSrRZivPW44CGyMw5lAH0fgIvrzr+j3VTZLuuogb?=
 =?us-ascii?Q?vzvtJ7qFZ3mLqnPHqKWocr2KLIb1h10sgZ3d57oNJb8QcierfwQ+DAfcu7ht?=
 =?us-ascii?Q?W0cdfBdZuPBJXOrWX/50fhlHJQts8JTs2GZ6CbTUT9j7gC+9ybw/wFU/cctK?=
 =?us-ascii?Q?6MedEI+BbXMmjyJfYtjJHS+AGr+JvwsewIMRkdGWo1+ttNT1Dpu6ca8f1KKV?=
 =?us-ascii?Q?5RKcDBokc+l0BWMDAYL5Ej2tG+CUH+JQTugz8G7Ywn/XAIEYQX8o2LX+eqyl?=
 =?us-ascii?Q?V/GYSCS6obuxrZ72C+ZZ4FKzP+lrZ92g023nJXkXS7mCD+alZhanjwLZWcU4?=
 =?us-ascii?Q?QdYsmx+wkTF8Gn6qH0rvlpTTx5sPzIwpjmIGYAtrdYFverwfuzhmdABupvVa?=
 =?us-ascii?Q?RFhOs5k0wDKamPF4W8rdWMoOjqYib8ZH7FBwJ+bWQPlqrrzEfdskvz/MDOn9?=
 =?us-ascii?Q?qdxQ43oyFQeJvL2vso2d1XRUhfW3sY7mmFzRR4WvLHNhodxVK7C9WrsIjjAu?=
 =?us-ascii?Q?8Z/dxgkr1gXihJV/WW0JpC+pNGxhyLIkNHXMTdaXG8KyFCAJANH1v18E/JTT?=
 =?us-ascii?Q?YHAcBF/VjBGCP0siPr12Fx7US+VYvOhbbOeXF7xXxSGYnZISof0Nm+c0B4NB?=
 =?us-ascii?Q?b3bBSu9I5qDZTUX8pF+9g5mItm4PUlFUgOjhqMRe+dMdOPSIvaiwcrzIWu6F?=
 =?us-ascii?Q?MYETkPqN3hvC4RQxEqoXfBqxAEE0ly/m/htF0ml655AOh6UHzrgttBE9IHHp?=
 =?us-ascii?Q?tFjNw2//3EiHd2tsfJ5ry8piDtRnslhxKCkFf6WxBEEU9PnNjnchWeXflSVl?=
 =?us-ascii?Q?YTSFgYSz1NBRewOJBpdzTiUv5pCN2lKf5+ivMSjQyoBb+/VZ4r18gLJuxmTN?=
 =?us-ascii?Q?IbaWGPnLiKpz/vfDjYrqMdE5ILdW3Ria7ocp0qxYT8VMudXvQY7g46cMVHvq?=
 =?us-ascii?Q?EyN4ja3cIw6ELWaHKiLTyhhSk+5NWmFT49I64nLUuw8AZ5QVwhh6MukixjCG?=
 =?us-ascii?Q?MI4cUumWLe1dwJ8g9fUSmBlpnJoK87MEyxCYW/F/jShsWjFHA+kt/fMV/OFM?=
 =?us-ascii?Q?Gkks/4ESKGQXF///R5CSxNseI14bI5n2i/mvFaRU6O0agzrDZWPuPaou54gI?=
 =?us-ascii?Q?//fmU9MCTAdXkal3wJb/5M9lMh801zSjmSo9QANMeh9TsN5hybuO6d60OJiy?=
 =?us-ascii?Q?nOKLd8ByUkie9qMjWio=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b4da7f-daff-4923-b4b3-08db22f96385
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2023 12:57:51.4340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtkbKdKIhZkLSNjiPWIGGgrhXTPXp4N6Sf0NsN0qYILl6r6XSxqHn2DyGkHyZ3qwpIhSpVh/kN/rMFgyThSMqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8963
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v1] clk: imx6ul: fix "failed to get parent" error
>=20
> On some configuration we may get following error:
> [    0.000000] imx:clk-gpr-mux: failed to get parent (-EINVAL)
>=20
> This happens if selector is configured to not supported value. To avoid t=
his
> warnings add dummy parents for not supported values.
>=20
> Fixes: 4e197ee880c2 ("clk: imx6ul: add ethernet refclock mux support")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
[Peng Fan]=20

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-imx6ul.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c =
index
> 2836adb817b7..e3696a88b5a3 100644
> --- a/drivers/clk/imx/clk-imx6ul.c
> +++ b/drivers/clk/imx/clk-imx6ul.c
> @@ -95,14 +95,16 @@ static const struct clk_div_table video_div_table[] =
=3D {
>  	{ }
>  };
>=20
> -static const char * enet1_ref_sels[] =3D { "enet1_ref_125m",
> "enet1_ref_pad", };
> +static const char * enet1_ref_sels[] =3D { "enet1_ref_125m",
> +"enet1_ref_pad", "dummy", "dummy"};
>  static const u32 enet1_ref_sels_table[] =3D
> { IMX6UL_GPR1_ENET1_TX_CLK_DIR,
> -					    IMX6UL_GPR1_ENET1_CLK_SEL };
> +					    IMX6UL_GPR1_ENET1_CLK_SEL, 0,
> +
> IMX6UL_GPR1_ENET1_TX_CLK_DIR | IMX6UL_GPR1_ENET1_CLK_SEL };
>  static const u32 enet1_ref_sels_table_mask =3D
> IMX6UL_GPR1_ENET1_TX_CLK_DIR |
>  					     IMX6UL_GPR1_ENET1_CLK_SEL;
> -static const char * enet2_ref_sels[] =3D { "enet2_ref_125m",
> "enet2_ref_pad", };
> +static const char * enet2_ref_sels[] =3D { "enet2_ref_125m",
> +"enet2_ref_pad", "dummy", "dummy"};
>  static const u32 enet2_ref_sels_table[] =3D
> { IMX6UL_GPR1_ENET2_TX_CLK_DIR,
> -					    IMX6UL_GPR1_ENET2_CLK_SEL };
> +					    IMX6UL_GPR1_ENET2_CLK_SEL, 0,
> +
> IMX6UL_GPR1_ENET2_TX_CLK_DIR | IMX6UL_GPR1_ENET2_CLK_SEL };
>  static const u32 enet2_ref_sels_table_mask =3D
> IMX6UL_GPR1_ENET2_TX_CLK_DIR |
>  					     IMX6UL_GPR1_ENET2_CLK_SEL;
>=20
> --
> 2.30.2

