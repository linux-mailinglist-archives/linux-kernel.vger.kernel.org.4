Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893476E3D07
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 02:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjDQAzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 20:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQAzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 20:55:14 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2048.outbound.protection.outlook.com [40.107.14.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC6730C6;
        Sun, 16 Apr 2023 17:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/e09byb6saT9GSxOLIv15KwGjhzJoCDYLYxXmg9OhJsz/cfiVTe4mtn+sVPoIpY6SJYyKKuh32zZxWoUhtiFOFQbhR6oNkhdPQ/rhS2g2Z+ODDAIIVDN23PVUMNeLeETsvpqifHUxjG+tfnf30CTva6ETSejKb22lSpI3+PNWwypBfJiddgowKPKPCdmQTsIsjCBeAHW4pA1DW29zLo/cjLLIJRnLUqzgC9/QL3dQBVM3JIgUNTS7DtcrClBw/UClJxERBSsxUK4wo4GMipQxBHw6TmVPguMRuM1IOTrUAVwBwqtg27+GpEkFOXIoftsLuV88HgRSLdlLenmd/mlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/smfzzE488cR+9TxllPSjdDkx5j1+1cv2Dr9KtJwyPo=;
 b=aWG2pXZmBP7VdKEy7gJJqxBTZ70hva//NOyJwIwSMbAIBGd/ryCQ9+Z+9kDBHYLpLQArDjzHF8EBE9sOT0rRdX3vmXcXK9PUn09CTovXAvbH7E8foRro5DMHhCd0ME2I07/qNHf6MkpBOONiW++gOyhv+r3QfiVP39u1y4hF4/1SJOqvwWaV+xdypegP2zESwWupEKgDfLGkqiSHOgjjLZh6U4Cmo081R6pQdRwUdtWQ6V7NuwW9fgQV/If6lqjbfktdJTsczou0sI45CS0d2SIFhuh9oGqWFzKBKWMK37cUwFw7oWqDA/XzJ0dwQ7OloPUNpNxHKAafFVrktSSEbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/smfzzE488cR+9TxllPSjdDkx5j1+1cv2Dr9KtJwyPo=;
 b=EltWIKXsDQHNe0E/CFBDR1u0hxe7kYOf/Wo8oxQ460pdVetAZ4xsp7XKhWpPvOai7RnUr8VUZr445kuCcfK3zQ065nKaWP8Ma1kjJPNudJKwSY3ApNxjRXMokZfkE53DSK5rQyAXhW7HfH8lER1J4gZLlN0VRPnRqOx4Bybb238=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 00:55:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6277.036; Mon, 17 Apr 2023
 00:55:06 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Adam Ford <aford173@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "aford@beaconembedded.com" <aford@beaconembedded.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: composite-8m:  Fix clock divisions greater than
 8
Thread-Topic: [PATCH] clk: imx: composite-8m:  Fix clock divisions greater
 than 8
Thread-Index: AQHZcJcyD+u9fdjl0kGyfYxulAld2K8urL9w
Date:   Mon, 17 Apr 2023 00:55:06 +0000
Message-ID: <DU0PR04MB9417F545EDAF40730E1C872D889C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230416191051.106513-1-aford173@gmail.com>
In-Reply-To: <20230416191051.106513-1-aford173@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8404:EE_
x-ms-office365-filtering-correlation-id: e4431e39-9fe0-498c-2db7-08db3ede62bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TO89G9G6RaYH+SpRA7d9RrSFytho5nKyi7mcjh3bGG8bl3OEzz+rPS5HtFSwj1JbDKtavxcJpagO5eNzFbUgSHjhaOilV3wMpQTtJwCsCmZVtQKDsjAdq63atKCYCe1aYK/L9cAq2LKO/QsJNkRPY4ot5KF+MOetjpu9J6MaPhS1iKsYUKBD3r16tEqqqLz88x2J6rzXmxWy/Ua8cXHvVAwwMjM6zSdGOOdKplQ/evw0Tyz5Rb+tPWUffwWtLPRflKJ61B6JuOKykml5Rek2zuHaLY9BimVmRSGPRcR/fKZCJDcz0AApNu1YZZZlNnEF3CHbpuOlKujSlGSSRWqBMaI4FRTQRccuubJ/QOc1UBecC9/5+NyHL6SbtpF1eLORdxTuhz9oBcG6FTMDAW/4lnxKbd7ygu31VWA2BeCHyKL3i7H7b/S5P8togry/JMuBuQFCW4NQz/4mvoFhN4TD1SKjhq2+5rJWEaLxYS8LygbX0KDz3/+mS/mnIbDXkSXTVnVsgoXPxfpsQknst9n2/o6BEONFHkxBNAo7ttjMSq0ehLFz3xWuzbcWFsxWnj034cbQx1ig44EFEfNQeZwwOhq+kCNGX5gxDUkOIFfu6sa9Ll3zV9y0WCqSj5PeV5+H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199021)(71200400001)(41300700001)(122000001)(38100700002)(7416002)(5660300002)(52536014)(55016003)(2906002)(38070700005)(33656002)(8676002)(86362001)(66446008)(8936002)(44832011)(4326008)(66556008)(64756008)(66946007)(66476007)(54906003)(76116006)(6506007)(83380400001)(110136005)(26005)(478600001)(186003)(9686003)(7696005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d63a+braDFa7zC/VTam8DHHItKjBCI8/RKc4yfWi168R9THFco6qTgQPKVTr?=
 =?us-ascii?Q?1c/UrceUFX7bWbZhZidF7HKUVuDaHmBEPEAjXOWBLYLQdEGhMGJ/WtGQt/w9?=
 =?us-ascii?Q?N+Si/aTvBdJEhEXRICaqxtjMUKkMkINiBz9rfa9YZrDMvClI6oxTBg9g0J0H?=
 =?us-ascii?Q?aGiIlZ5aBw4sUA+SKtPNN3VR8WJSfkZPwHQ8VVx5TDqO6pBCsez9wxjlsILD?=
 =?us-ascii?Q?NtnyJlneRORCOZitgcBkVfn8M3rpME3/x+rf6EkSOjpBd26RF6GSO8ik0ukI?=
 =?us-ascii?Q?EuNoS7iER9URsX9UlswxoSux4tUOZgMLadxvDdvdBnvKj4tnqI7h1k/rs7s1?=
 =?us-ascii?Q?hoOxlEytGVqgF7y/0mnLGf1iMayQNpBLFWlWDJbGMbR4EjpSs1r56vaeKjiw?=
 =?us-ascii?Q?Nf3ZP/GF7W3VcQUYp0Gc6IhRstr6Lrsik0T/NqP/UgHVAQkrAdmgTn5lz+0i?=
 =?us-ascii?Q?kPTnNwBn1Vy6eeQNbYOnTDEiBkPoiDaOjrmDgSHUdhRzwqYvwCU0BTGry7jS?=
 =?us-ascii?Q?ovCxaD4VeUCKIBG6ZHtFL3IECnsxqWgZmQLUAXcCVFdxtRJyqUAtDSMQKus6?=
 =?us-ascii?Q?AT7e7TmpX6UpjZFuqHeyhxaSjPT52WlxM1L24hOzpECqri4QIyvmsXFa4hiz?=
 =?us-ascii?Q?/KwlKzJchtKZtcBYuNua+i8tQBJtxHsyuGKbcaKPFrxUsmpI6icK2Rbaa259?=
 =?us-ascii?Q?IHYn9TVQA2eXHBMPQqeD+BBHbRdbQ6ClyuVONkyT7z+viPm5b5d34CZrw2P4?=
 =?us-ascii?Q?f+1Qq1Opro2ZqLRCJbUOMSRn1X+8OzqtH2vnjExHieyvrQKTjlkj0acKcf4p?=
 =?us-ascii?Q?nu0i4C7hpOpFIbr7ZkDld4a9zLki8Rgg7yD0htOikObFCvFFIJVASeOYsVtf?=
 =?us-ascii?Q?qLuBUfkAdnjapqAXAybvS8Fe2bsS0MOBFooW48MdrH+MaHkSlRfUGXYwP+gf?=
 =?us-ascii?Q?GMYDgmG1Ra7qvJ5KqhXNRol0cWrq5AyP8etD071gnBPrueZaOPlb3D82qkZ6?=
 =?us-ascii?Q?yTVT/SyfwZzymdAF6GcFhDXKdPxleGtgSLlCLsUCtr5Tu9v2eepNiqFysbqq?=
 =?us-ascii?Q?WmVQy7/Xx4IjhRAEbYjlxxFBrQGZhx8cI2w4V+mEQEAbgggUEBdyMAx5Qt8h?=
 =?us-ascii?Q?2Ghsz0sTzIusmh8sERc2Yjir5njMqTIUCAHQSztJBw3odEU11sA1Yc6Te07S?=
 =?us-ascii?Q?ByqNQ/E7Owc1cBSHlZ4bZAqFw7UuVi+ZgBR59H596gS90bRN4mxGXDh02SrA?=
 =?us-ascii?Q?Z/TMRhwnIxNNfDukaWx9hMfmMa75MLrzNOT55fmvNaSRzLO2y+B4gDuYhxM5?=
 =?us-ascii?Q?RSUCBXBrwi4YYEZx4DVaUIai9RntJELofOFhsVkcL0I8xRY8M8ZkWvdOtMli?=
 =?us-ascii?Q?aF/W9U0c9Vj/+GJ6v7N6EAt/qMAozDnr3fX5dwbn3KdJ8yPfqm79klxZAxbG?=
 =?us-ascii?Q?TH9EOnJT3Keqz3MsfVbz9w2hAqtgUI0PnzIBpbvPNcuJTdph3TRRQyoC8F+a?=
 =?us-ascii?Q?UGKt5IkoTqp7Vp7JMjpNOCsIrwoDbbkYqZimbgjUj/JTzacXJepv9DadjTcf?=
 =?us-ascii?Q?IzUea4zF+LyG1EIXcak=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4431e39-9fe0-498c-2db7-08db3ede62bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 00:55:06.3102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01S42ANH0fA4u6SqMPFTDyduXF8As7lZsHmdATuRwaainN7aRf0IufQljZc6GdgxLg3hsVgU1CeLAQWCwKwwXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8404
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] clk: imx: composite-8m: Fix clock divisions greater than=
 8
>=20
> When adding imx8m_clk_divider_determine_rate to let the imx8mm and
> imx8mn get finer granulatiry of video clocks, it accidentally broke the
> imx8mp ability to divide clocks by more than 8 on clocks when the
> CLK_SET_RATE_PARENT flag is not set.
>=20
> On the imx8mp, the CLK_SET_RATE_PARENT flag cannot be set on either
> media_disp1_pix or media_disp2_pix, because they both share the
> video_pll as a common clock, and if two displays are used, the parent clo=
ck
> needs to be something that both child clocks can divide.
>=20
> imx8m_clk_divider_determine_rate ends up calling clk_divider_bestdiv
> which uses the value of 'width' to setup the maximum divisor.  The clk-
> composite-8m driver sets the with to 3 which means the maximum divisor is
> 8, but these clocks can divide by up to 64.
>=20
> Currently, if the video_pll is set to 1039500000, the slowest clock rate
> achievable is 129937500 which breaks a whole bunch of lower resolution
> and refresh options for both media_disp1_pix and media_disp2_pix.
>=20
> By changing the 'width' variable to PCG_DIV_WIDTH, the maximum divisor
> becomes 64 which allows the clocks to divide down more, so the lower
> resolutions and refresh rates are achievable again.
>=20
> Fixes: 156e96ff2172 ("clk: imx: composite-8m: Add support to
> determine_rate")
> Signed-off-by: Adam Ford <aford173@gmail.com>
>=20
> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-
> composite-8m.c
> index 6883a8199b6c..805e6aada83d 100644
> --- a/drivers/clk/imx/clk-composite-8m.c
> +++ b/drivers/clk/imx/clk-composite-8m.c
> @@ -47,6 +47,7 @@ static unsigned long
> imx8m_clk_composite_divider_recalc_rate(struct clk_hw *hw,
>  				   divider->flags, PCG_DIV_WIDTH);
>  }
>=20
> +
>  static int imx8m_clk_composite_compute_dividers(unsigned long rate,
>  						unsigned long parent_rate,
>  						int *prediv, int *postdiv)
> @@ -215,12 +216,12 @@ struct clk_hw *__imx8m_clk_hw_composite(const
> char *name,
>  		mux_ops =3D &imx8m_clk_composite_mux_ops;
>  	} else if (composite_flags & IMX_COMPOSITE_BUS) {
>  		div->shift =3D PCG_PREDIV_SHIFT;
> -		div->width =3D PCG_PREDIV_WIDTH;
> +		div->width =3D PCG_DIV_WIDTH;
This is wrong. Pre divider width is 3, not 6.

>  		divider_ops =3D &imx8m_clk_composite_divider_ops;
>  		mux_ops =3D &imx8m_clk_composite_mux_ops;
>  	} else {
>  		div->shift =3D PCG_PREDIV_SHIFT;
> -		div->width =3D PCG_PREDIV_WIDTH;
> +		div->width =3D PCG_DIV_WIDTH;
Ditto.

You need find the other way to resolve the regression.

Regards,
Peng.

>  		divider_ops =3D &imx8m_clk_composite_divider_ops;
>  		mux_ops =3D &clk_mux_ops;
>  		if (!(composite_flags & IMX_COMPOSITE_FW_MANAGED))
> --
> 2.39.2

