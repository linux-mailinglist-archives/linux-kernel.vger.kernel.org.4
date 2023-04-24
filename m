Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744E56EC374
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 03:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjDXBnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 21:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDXBns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 21:43:48 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F37E10CC;
        Sun, 23 Apr 2023 18:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lC5f/a0ks1pcJHXRCgK60K4zSpTXNVFNbckyu6STTvdjZT6aKfQGH3UqxH5naAvttGhfFzu+MRevfIxCIwHvOsnhmdWuB3PR5KVeQs3w85neNdhvWSlnI70UUcs6uLIWOik7oDxidYqBu2564gfgMJAdEbbfwrGP0m0aYd5urmF+8JjreksPsjXVpOrhP1fqQXrrsOi0IzblupAVPCctgPnWPrX5r74eEMgHtkRoya8v+20cp9t3ywWGg2F5WVodJhgEA+a5Hx+t/ISJ2QGoMvkdDvMVakoWGH2fkZIAPVnEyiN3FjIevm3SCrXlLIwmw+r9hD22sUY4VahvRGnmiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rWOklSGbPxym2TeSAwtd8vbSKRQ0+lDcwyLDzH+aPU=;
 b=ZnbRU7TqUh7eNRPLNjDD/85EYLAZmTb+YKo7ya3CsYBR42gYzBT+O21uvNBxwx+/d1yG/fvePrU/cPiKSI2zw91qViUinrTov8V9DY/Egzl2NxT9HnR1xCIkhbGU7bLMAl+xJLgJfQPEK5elH8gbERxTqjB5weoXCofXVBC/k9t86uT3ocDmoVkK061lBXilnVVC+3vfcEcElKj0ukS0mXUM/2aFsZnNTA08H/QaqVKdAGvDM/lV69MMNn8vl/PqjJ32UdBRVP/HjWKpiqnY42jm/QABIVO0T06ndwrA/QMWItWivUeXT48cBVHeIU9nWQ0M++VOJjJBJGK2g0c2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rWOklSGbPxym2TeSAwtd8vbSKRQ0+lDcwyLDzH+aPU=;
 b=h2N48gqJZmQU+KpKsla9fHlNaGNQpQNpLrTF/pUZ+vpKzpilj5XJFLwOfx9qe0jInAwK3dhibbJ5dBk1UxgikLcp5iwmVSwSNpnMLztZB2qOWKfr9PqNo1cYhHfgjzfe7CTjMjNlDczoeY4cF6dtkueM8fYTRQ8Xt3ZYEpbWiVU=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB7141.eurprd04.prod.outlook.com (2603:10a6:20b:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 01:43:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6319.032; Mon, 24 Apr 2023
 01:43:43 +0000
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
Subject: RE: [PATCH] Revert "clk: imx: composite-8m: Add support to
 determine_rate"
Thread-Topic: [PATCH] Revert "clk: imx: composite-8m: Add support to
 determine_rate"
Thread-Index: AQHZdeCGmyhtR4qStEaNJuTFpNoNjK85sGqw
Date:   Mon, 24 Apr 2023 01:43:43 +0000
Message-ID: <DU0PR04MB9417FF20BEDB110DE49FB7F388679@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230423123828.1346511-1-aford173@gmail.com>
In-Reply-To: <20230423123828.1346511-1-aford173@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM7PR04MB7141:EE_
x-ms-office365-filtering-correlation-id: 3ce8222f-a7e0-47df-a1dc-08db44655692
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b4L2LDkkBsldH4ZoiyZKg1SD4WM6b2nD/tHIRbkK4YpGEaHj+1KW4tuhoCsArG/LqIOZ/vSoljn0Z2oaPWIoHP88oZTX2sGnj9Yhh6hdweFEZrEdWFnnvNjv358pw5f+BxlJSb21XlNiBM+54LkVdsp17EJ2b9ly+EbMGoK6TmbUAhpuBrltnYw2D0jRdwmAhnX0Y3pm9QBSE/5QbpYSnhyGLpJYWcetN/lDu3mRh/RwB9XRlLp3ErilexvijqITZfEvWMXxh3Nju8a4J+PExpsnfs3Y1XSGnZen6G1iJbFvQrv935ZWEkAbUS8LJvhz3vkPgbw5/aaUywU1ENoqonM0djB9JTmVdjkE9xsD7cOaUKkLDorNBQgmfp0sWZ9wsOkKuHHhKRDN+qp7mDzWFS/M4UiltJnOrlznNNzklOK2DtHQdAJQaX5dp9GwLDab5XujvFenYE30UOfFvO8iA99phWTTL6HjkhQ+fc2aIi72EZvrSSPjU5ZCwb61y4v8Xo3Dn4BLa8yDWu2rQUO5PFWjKPOdV5jhXRq5vTe6YOuxFVDjo6PetkuB12HvG7nKznlclOx1wyw3D/6Z1lZoUb2U8ATn0sPQcgHIV6lwnWEMxkh0/TKksg2kKx9aRYT2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(376002)(346002)(136003)(366004)(451199021)(2906002)(7696005)(71200400001)(55016003)(9686003)(6506007)(26005)(186003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(8936002)(316002)(41300700001)(4326008)(478600001)(44832011)(5660300002)(52536014)(7416002)(54906003)(110136005)(38070700005)(38100700002)(122000001)(86362001)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+2gJmC7e1VbpjQu0YBQQuKbD447XMbLwfZIxZwK3agPhsM/V8tHQgpxEiMoE?=
 =?us-ascii?Q?PPUbdZxkKBoWF5y5D6IKcW8BImGGd5h39yPm6SuC+mVBmVT+N0kVKLx1igu3?=
 =?us-ascii?Q?Lq9dkIdGQbZfdcFJPbyPjO41/mkF+t++haeyLGnk0azAn8Fe++znLz5JZYcC?=
 =?us-ascii?Q?+nlTLjMG2AGrzCLYk4U3yBp0Qf94SBuGOVfoPfYAmiXILKDTOZboJWlGOd61?=
 =?us-ascii?Q?Dybs8S5mWqzL9WS1rjkT/hZ/Hy6rD2X20Sw5h5G5NpEuyI1Uqdg2FXkxWEly?=
 =?us-ascii?Q?/J0fNAITio686oyA2N94O35Rvv5T5diqlQuB9H8IZ1qxsGIOIwxBVC97Ojm6?=
 =?us-ascii?Q?LCqd+SbVQhShCTczN3RRZwvo4LwlN0lk5s9PTyvqorL2zjOhjlP+Srp9twRN?=
 =?us-ascii?Q?TPX4KTzStXcvostDtA3luwZZZuDBhCHYjmnqlTefvDbtvLORrdtTEIvSU3AI?=
 =?us-ascii?Q?xZYOgWZElnqZZBXWk9aWXYG4tyzztbo1HYanFI6efddjqebPqNbGsaQbiMDv?=
 =?us-ascii?Q?0xNo+23jeC1Iudijs4w9t99zTbcXe2F2fDo/Wuq8wbGBqDb7ObvLSbJMza8Q?=
 =?us-ascii?Q?vakVt9N+dnJ1apvb1azuE+YQUtVSEcogKNn+hATwK/viZlS1GaFqoFOM6jMU?=
 =?us-ascii?Q?f+eeTqS03qINPYHhV4VLTF600/s6ZB0gM59kPdjrH/dOneZtG+6m/Mb7CkUG?=
 =?us-ascii?Q?4Rv62D5XWX1lKJoObp8GUM4qa0fiIZSJqdaS8UtM6+nm08B7njVcW2EVa94S?=
 =?us-ascii?Q?pXCuqvS/Y8k/zT3oIZUHBuictQ/2foyZqLc+yVFIrJ0IkBf0TijSaIWGxaoH?=
 =?us-ascii?Q?Lt08LzfzkT6Q9E7phvPgn8Z1goJ/rK8qIlj8/ASAgYHW5jyWYOtAmiGblMVr?=
 =?us-ascii?Q?YWnrBx43a4M78Dd86jWgOcUF62dXGb4bLC228zqEB5pCppbkTM2uxodZe8mn?=
 =?us-ascii?Q?lGGgK+1/OqxHAWrEyyZMhXmZMqV9+NFeFcS/3Pl/id0OpSasAw7GGbq+Chby?=
 =?us-ascii?Q?IzTJp4Jyewlxorz+UN3W/49OFBBcgjejX0WtNat2j9oJclBOKH95yn8ACMiz?=
 =?us-ascii?Q?JlSzTE7jF9x+YktyTTLAgEBtnhKoXRibipKwiX589gSRKy+AU8QqVKHJ37HD?=
 =?us-ascii?Q?rdroFIk7bO4s1rzr/NxI8ypCa9Qv3l4xP/vPc6sgvOxsba9JKu0TnWNgDWFj?=
 =?us-ascii?Q?W3EkIFl27wOSWv666dGfH8lHSsFWgLNe37XioaAnBYNZDdIqXZHoEocFxcMI?=
 =?us-ascii?Q?p/gHR+dAvGL4gnhi6eo1PYqfqIeU5enMU+GsAkuPAeI8WKp/lBQ479f6d92d?=
 =?us-ascii?Q?6gCvLk8sUyMeeLElxzGCk21tGQJ0y6LlrgCjsS4emlM81JAiPlM/ogOgS914?=
 =?us-ascii?Q?VoSfygJjcBfu1CMi9mtQZXPYY9wvoqZUzV+csDhLt1ee998cSB1MlS6QH9hW?=
 =?us-ascii?Q?vOeQRlPXIrfaO8GM7If3IXrZ8qDVNR9ENJ+aRRlzOtMfGIrRpQdJBgA6MjaV?=
 =?us-ascii?Q?NSTtqOU3GTmtqYiVxUm32zODdX9MnuXraOZdn78Qek4aEdTX5I9kFUeRB0Hb?=
 =?us-ascii?Q?ewRtP3igtfNyjRY9UVM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce8222f-a7e0-47df-a1dc-08db44655692
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 01:43:43.7542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9XrFdfGupSYfpWeIHnmz1secGDh9zq7dO1OVkuGE7IHs2l1UABE1S0rX4pxSJW1BckM1YtlrKD/tJJkFwrCDVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] Revert "clk: imx: composite-8m: Add support to
> determine_rate"
>=20
> This reverts commit 156e96ff2172518b6f83e97d8f11f677bc668e22.
>=20
> This patch was found to cause some division issues on the i.MX8MP which
> causes the video clocks to not properly divide when division was greate t=
han
> 8.  This causes video failures on disp1_pix and disp2_pix clocks.
>=20
> Until a better solution is found, we'll have to revert this.
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>

Indeed we already see issue in NXP local CI with the previous patch.

Acked-by: Peng Fan <peng.fan@nxp.com>

>=20
> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-
> composite-8m.c
> index 6883a8199b6c..cbf0d7955a00 100644
> --- a/drivers/clk/imx/clk-composite-8m.c
> +++ b/drivers/clk/imx/clk-composite-8m.c
> @@ -119,17 +119,10 @@ static int
> imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
>  	return ret;
>  }
>=20
> -static int imx8m_clk_divider_determine_rate(struct clk_hw *hw,
> -				      struct clk_rate_request *req)
> -{
> -	return clk_divider_ops.determine_rate(hw, req);
> -}
> -
>  static const struct clk_ops imx8m_clk_composite_divider_ops =3D {
>  	.recalc_rate =3D imx8m_clk_composite_divider_recalc_rate,
>  	.round_rate =3D imx8m_clk_composite_divider_round_rate,
>  	.set_rate =3D imx8m_clk_composite_divider_set_rate,
> -	.determine_rate =3D imx8m_clk_divider_determine_rate,
>  };
>=20
>  static u8 imx8m_clk_composite_mux_get_parent(struct clk_hw *hw)
> --
> 2.39.2

