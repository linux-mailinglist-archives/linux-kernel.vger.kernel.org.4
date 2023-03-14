Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E5A6B89B2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 05:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCNEje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 00:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCNEja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 00:39:30 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2060e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1b::60e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E91E32525;
        Mon, 13 Mar 2023 21:39:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OolOnbWzyLMF/G/8yA1Vn7oApWKJGnxtewD5psJtlfV4ewUEFi7TAhZI/M1uPkJ1BVplcIGhixZEYspoo3EF3JOuGUNVAjAhHDBXfbw6Rx5UGGrwfVwMHdKhCSUWJyPh5EEzwtzqrasVFOXAmgHnfVtEL8jQ1+Abz62gasENdLSq45fJGsedAgdZPenWcPprcxJwg3zAIjXoXxwqSdQ1Xc4qeOJ8i4HbP1iaAsPh65HSSbPn1XT9uj+8NMXx/m5BwePBg7JnHlWH43zF4WuPVd/YgvSyAL57lDeiBBCMMvDzRyKCGKNULhRT/yXvVOBWvvQ5EbML7PjklGkytvVTzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMq91vTmwSHmsrPVvgMIeWFLJVkLNm9eR0MkRnbAJ60=;
 b=cNp7KEw27G5V853zpNdHnKlfUFaeusUbVQUbu8C7qHH3K8Ur8F8IEfmy5avT2t5i5g8bGTbGJjOjjMeLGfwUvZ026XiiQzMLTeHucymsDw7Hv7+ufZEq+J8a1M5/gj0xR7Kl5kJvOzxHCRZLjK14pMP8M0fFBckP2KuetYm9kx47lypPJdyO0Nfi0IkI4f9M+MaZv9WeJVSRDdezr6E00AmJjMAOZBgbdofCLMpwVYSxXtE9DpQbcZdNi+RZiyiZ2giSrzufopZMAhlbC805jS7ZFXf9cvBUDZ0gWlMR0dejnfqxluyFTVXc2l7Zoj+Kacu4b8ORe+USEU4RF3oIZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMq91vTmwSHmsrPVvgMIeWFLJVkLNm9eR0MkRnbAJ60=;
 b=aRGUe4Jvjy+aie3V5C9k4tcOf1EfW5nBbZDodNof/Ew6i+ISIOBNWWKmlnvjKDrTzFGI7Dv/n+01SLC/CgNOCdFhJpghceFsxgvvrs6VOrZTHZKifI5nNpiTNWwXTg8Y/Z2CRgrWRzgJzSYBai0h1tUMVwpAPHqUF1O8uXrv5Ss=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7524.eurprd04.prod.outlook.com (2603:10a6:20b:286::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 04:39:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 04:39:24 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Adam Ford <aford173@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
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
Subject: RE: [RFC] clk: imx: Let IMX8MN_CLK_DISP_PIXEL set parent rate
Thread-Topic: [RFC] clk: imx: Let IMX8MN_CLK_DISP_PIXEL set parent rate
Thread-Index: AQHZVh755FFcwu4ibEmsRm2CLElfAK75sXLA
Date:   Tue, 14 Mar 2023 04:39:24 +0000
Message-ID: <DU0PR04MB9417C49457C9E60898E6A92188BE9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230314024449.50151-1-aford173@gmail.com>
In-Reply-To: <20230314024449.50151-1-aford173@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB7524:EE_
x-ms-office365-filtering-correlation-id: cfbf02ef-4240-4a1f-1664-08db24461654
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GFBx+5Supapzq8r1V7dzD/+aXTw5y659uc/9DrmMUTI5qdvjRLoeVB4K4Bm9lfL/xMEy7EVzgvfBZ1gNPGoG8w+sF0sNGUYul0/wJPL1bhMiarUT8Pd0bDxjOHFr96AAq45HqEg8wJsQobO4XMKByuD+SNytT1/14ztRUIP9w2YDX0WGmx8FdRsoOSvaKEtmK/N/S8sU4F9JeG3kux5gfJrv/BqN3ESpdaqTDcJTWnmnjEERnkpbkRMBJXua4eK+40LyPw7JkD3ZLi0Py2Yb/qq9HA88p/gQm9nqXm6Zz/uio2z/y1pdxQsiPn4Dm9/J1OMbm8EFQL4sxCjAtWlCR4/A9auwHL3Y0u1OQW6HqHmYxnlGAqmabBhjn0zFbxBjKZhfUbk8xedyrdU6ig/rahFnZEqa9qcFGRHw9lwClWWgamk4Ag0CR04vcKctEwhef8nBqveWFj4Yj9xn1JULqtO1ZmGDFLKkoVnJl3Qrnyh4LXXaaL5cRUnQ19hn3z2KULykAMwHidfeBuTAkY+QTO3s0o748LCf26JzztNLUDcg0Lo6FmAbT0P8vei7FsD2Ec1qvakegG4tZUjyIy0ve5WQt8vRsYtfE4xqC0xZh1vQ1VSx+gwYEoUZ3ew5A9UQ9iR+lndA9fn+lyj3OSpTdcxJFGJCEb+63X2u2RzlGDZyijd4rEhSt3tfT5wwDkX6l+x+tFGmTDP5U6TYYqQvcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199018)(122000001)(66946007)(66556008)(66446008)(66476007)(64756008)(76116006)(38100700002)(4326008)(41300700001)(110136005)(8936002)(316002)(38070700005)(54906003)(52536014)(83380400001)(8676002)(478600001)(5660300002)(9686003)(71200400001)(86362001)(7416002)(44832011)(55016003)(6506007)(33656002)(186003)(7696005)(2906002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1vWFMUYZu2GnCaHMBk65CgbiuqYv/fNSq/ykXGfMrhgQ8N2i/82H8G352Gdw?=
 =?us-ascii?Q?gLCD768GyKg+x4+8uWq7xNaAyDg2hwEBlAV85g8DHhhfkjI7BPA7j1Wf5HAh?=
 =?us-ascii?Q?5xBt7tsNGSCyA059FyRhIf0uAtv1INUsEVxe0lEVmIQGv+00YgxC/gVK/pdB?=
 =?us-ascii?Q?vXzYjvrEiUWkkJnxbHb1LVw/iBQlKxwT8yJnXK8KvyPR9BeWcZyp/9+YQQSu?=
 =?us-ascii?Q?wkQxoSblp6ml4snA3dP+VhsQ2E9aqHQIb9GaMPnZd828/U0TKRcXiYIvf805?=
 =?us-ascii?Q?gzMYjVwspfzGtnp7wh/AjpNRQW4blkNXSOYuanAHyWzpHuQNeRcLNSaAWBzX?=
 =?us-ascii?Q?628JL00AXwcZDY7jyHjxg3TiNtJcJo26zSRIJIRZFtbC8i2fituQzzDosQJE?=
 =?us-ascii?Q?ijTcTybonhnNvU473vG8BczKe1EyEwVcVAr0VRxPFbT/unfUbWlECAmF/fE2?=
 =?us-ascii?Q?SmH26q4cPhYRF9YZyq6ghUxmiX2kU1aW1iCLVJxEFoHl0+vltfsVMr+x0jCS?=
 =?us-ascii?Q?ke8rPuKSmCB6LSpA5Xtr+YqLpLJoJ70/RHGKJdlU/CRAjKHQ1rMVjwuoJb9b?=
 =?us-ascii?Q?PzA83P8O82/uGDq2Nw+62M3I+S9por+z0A4ouWQwPRmc1q2VEPv7roHfupvr?=
 =?us-ascii?Q?CRwFhrxGCB8w3igrb11jtKdmBL/822jX4yF3ngnIDAu+CHBhcowwqBEpyULJ?=
 =?us-ascii?Q?HhdquEZM2Y2JMQQtPlLDwrsSa350oTHXZiDTLFCoSN6b5JJChxpktMfe6Fmn?=
 =?us-ascii?Q?RraC7G+gSpu4ACo7Uy8zezeLVbFlqXQ3FyrRmA39Cdx00msm4qRyKcCIFO02?=
 =?us-ascii?Q?sW5/F2HXWSXulSIEKOBMrdz5x3M94QRzey4CevDJWvh6OWSE5VcMeX0BONns?=
 =?us-ascii?Q?Qsj7zx+Mvrkf+3GJUnCjyjf1QpIfOo/9jnFBq/D2wt4w6Tmair7g+0Zux+iN?=
 =?us-ascii?Q?QysLXbwDB96xEddS8tl5gwZ1TkjyzsMLw+a45xLBfP0EP2FyUFSZgGr5yW60?=
 =?us-ascii?Q?fv/IR7HoihDCFJxzlcsMBo7quVex2nhima6u7aU/ZKnkGQuPGBo0GIXQGp26?=
 =?us-ascii?Q?fTCApc5N2Ug2ZFYvjnaXvhi5gA5jd+AsjKD/eKFITM1XOzVn0Ezj9Y5irES9?=
 =?us-ascii?Q?QY1RvrevCAN5VihCMB1dk3KBr0drF5/2vylP0UYZ17CqtTIRx3FrkJaSPGFr?=
 =?us-ascii?Q?CDrkJEB4fs+DsMEydfOt0txHD3JuMEM4IduMvcCvOt3mfdjGsKcVconGPI2a?=
 =?us-ascii?Q?qz9OclrUeVO8+q7ojFysSe9R1kWFIp4RvVty+IIdn19rAC186mcZamczBYJg?=
 =?us-ascii?Q?sGo6vbeDkhBerHG9/1Q9J0q3n6KW9hsW3bPY2lm6gQuLO5bNxztvvxC0ScuB?=
 =?us-ascii?Q?VdYNhDAfASt4s8tJldW7sTMXzwHSgawCvFdICzS69KTtb0qb1WbOy2Shkxmo?=
 =?us-ascii?Q?gJV8go742pP3sHODcLjGRb8tSOu2YG5ttH9uzdufdabPgV/u7nV0gr4fltLC?=
 =?us-ascii?Q?J5US1EhakDBGtDP5F/ntXu4IlfRYptoAJirL01R7Wk4fp4RKCl/ONGmp5KQF?=
 =?us-ascii?Q?Qvgz40MFy55FR+pDzoU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbf02ef-4240-4a1f-1664-08db24461654
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 04:39:24.3664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pd3aSvyuPtbcEp6rkT8VynHuV95cfGzjT30H9PzkWf77S6s+RgY+K+VxT4nZN1gZebtknEytfmQUD4edsblFsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7524
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [RFC] clk: imx: Let IMX8MN_CLK_DISP_PIXEL set parent rate
>=20
> By default the display pixel clock needs to be evenly divide down from
> 594MHz which rules out a significant number of resolution and refresh rat=
es.
> The current clock tree looks something like:
>=20
>  video_pll                594000000
>   video_pll_bypass        594000000
>    video_pll_out          594000000
>     disp_pixel            148500000
>      disp_pixel_clk       148500000
>=20
> To enable CLK_SET_RATE_PARENT on disp_pixel, a helper function needs to
> be added called imx8m_clk_hw_composite_flags which can pass the
> additional flag to the clock controller. Letting disp_pixel set video_pll=
_out
> rate should actually lower the clock rates of video_pll_bypass and video_=
pll
> as well, since those clocks are already configured to enable
> CLK_SET_RATE_PARENT.
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>=20
> This is an RFC, because even with this patch, the video_pll_out clock doe=
s
> not drop to 148500000 like I would expect.  The video_pll clock is a
> fractional pll, so it should be able to generate a significant number of
> optional clock frequencies to facilitate video.
[Peng Fan]=20

Have you ever tried to directly set video pll out clk to the freq that you =
wanna?

Regards,
Peng.

>=20
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index af256ade554f..a116cc40d7d0 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -470,7 +470,7 @@ static int imx8mn_clocks_probe(struct
> platform_device *pdev)
>  	hws[IMX8MN_CLK_DRAM_ALT] =3D
> imx8m_clk_hw_fw_managed_composite("dram_alt",
> imx8mn_dram_alt_sels, base + 0xa000);
>  	hws[IMX8MN_CLK_DRAM_APB] =3D
> imx8m_clk_hw_fw_managed_composite_critical("dram_apb",
> imx8mn_dram_apb_sels, base + 0xa080);
>=20
> -	hws[IMX8MN_CLK_DISP_PIXEL] =3D
> imx8m_clk_hw_composite("disp_pixel", imx8mn_disp_pixel_sels, base +
> 0xa500);
> +	hws[IMX8MN_CLK_DISP_PIXEL] =3D
> +imx8m_clk_hw_composite_flags("disp_pixel", imx8mn_disp_pixel_sels,
> base
> ++ 0xa500, CLK_SET_RATE_PARENT);
>  	hws[IMX8MN_CLK_SAI2] =3D imx8m_clk_hw_composite("sai2",
> imx8mn_sai2_sels, base + 0xa600);
>  	hws[IMX8MN_CLK_SAI3] =3D imx8m_clk_hw_composite("sai3",
> imx8mn_sai3_sels, base + 0xa680);
>  	hws[IMX8MN_CLK_SAI5] =3D imx8m_clk_hw_composite("sai5",
> imx8mn_sai5_sels, base + 0xa780); diff --git a/drivers/clk/imx/clk.h
> b/drivers/clk/imx/clk.h index 689b3ad927c0..9977b512845b 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -414,6 +414,10 @@ struct clk_hw *__imx8m_clk_hw_composite(const
> char *name,
>  	_imx8m_clk_hw_composite(name, parent_names, reg, \
>  			0, IMX_COMPOSITE_CLK_FLAGS_DEFAULT)
>=20
> +#define imx8m_clk_hw_composite_flags(name, parent_names, reg, flags)
> \
> +	_imx8m_clk_hw_composite(name, parent_names, reg, \
> +			0, IMX_COMPOSITE_CLK_FLAGS_DEFAULT |  flags)
> +
>  #define imx8m_clk_hw_composite_critical(name, parent_names, reg) \
>  	_imx8m_clk_hw_composite(name, parent_names, reg, \
>  			0, IMX_COMPOSITE_CLK_FLAGS_CRITICAL)
> --
> 2.37.2

