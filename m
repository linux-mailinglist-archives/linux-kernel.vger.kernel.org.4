Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ED86D3F1A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjDCIgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjDCIgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:36:18 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2080.outbound.protection.outlook.com [40.107.6.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5224B125;
        Mon,  3 Apr 2023 01:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJwCNhaDVfdULCqnwkn/RVSeXthOYUE1JhZKRJe6JiSD3jTRqHTne++mcqAtHklVfIIY6czCX+OlKOvCphEndeTzkzNIrearmJrv7Oi/RrEMsrVcX17NhanjosUIrvIPIhvOv7YibtTR84+DH7dx8bI9DOe/5OTvNGf2xB6oYHTtsdn4rOZ/erCbEnm16K8LAZ9QW+AEF2Dnw/IbLiVYITNtFGK1sFKcpEdmPCwAv1nsvFfB1GqkIHIOCKb7GJpRvw4/dSlih/L8+fxIElWobLZhrrZ43XB0xJPU9nQJI7QRnpqIYz1bDpMkbGaZkf5nEmR3+5Cs2XcnarLaRTsJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7Ov48L47vA7Bu0/dmoBkwTSojFepmz95z0R6PuEPsA=;
 b=jJhaghvkyqkK1+vVc/8iSkgbg5wPuUROdhi44g1pzOWVacIkL/22k6zYlWwwJ8WHKsFnXapMSp4MFPjM4+qn/Lee7cbOFn5U7Y/BzPZMvEe7aBl5ZTTmiwwX0n6cIkqbcJL1Oqgo3zypeFaJiD5PukDUueNyXZy7C22VzWQw6x333mJIjH1VNN/vS3H++VNHNoPA2oEEaKcFABGYjT0bZJTS2j8RojCfxircdmTXW3/wQMy9td3I/Iyi1yBxnablm+AkWO82VaOItUVHPjh2i2IKATFIufpk4RS2R3VA1hHdubq7dudNSGBziNunGGOVuANzX7i9z2Vj6gLlFLqIag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7Ov48L47vA7Bu0/dmoBkwTSojFepmz95z0R6PuEPsA=;
 b=eGm40rQNZU7RdeDgdOQlAI8b2m2bdlPJ5XAcfE7KmL62B5VbPQlkYAAr7BNE30hQaA8w5ijTtyvn7CVsZ1hUNxAiehFeOIXJwe29JwVH3kbsyOmtbvlv30J6ZhI6bTv3dUR7VuEDGUmr+xF/MU9ntqRfTatuDXZeQc2eKv7+Nt0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7052.eurprd04.prod.outlook.com (2603:10a6:10:12d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 08:36:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 08:36:15 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "S.J. Wang" <shengjiu.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V2] clk: imx: imx6sx: spdif clock rate is too high for
 asrc
Thread-Topic: [PATCH V2] clk: imx: imx6sx: spdif clock rate is too high for
 asrc
Thread-Index: AQHZZgSayzp/Lo7FJUqg93MtztPgx68ZQhWAgAAAXkA=
Date:   Mon, 3 Apr 2023 08:36:14 +0000
Message-ID: <DU0PR04MB9417853B92B651A69452006088929@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230403082138.3195452-1-peng.fan@oss.nxp.com>
 <a23f486a-e08f-f1ce-5f1b-bc34e4c92e67@pengutronix.de>
In-Reply-To: <a23f486a-e08f-f1ce-5f1b-bc34e4c92e67@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB8PR04MB7052:EE_
x-ms-office365-filtering-correlation-id: 545e3060-afef-4872-e0c8-08db341e7cba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Ow8l/Cj0eIORF/5QBgDZs4kL9cOpXKdjyJDpquQuTBYJaE2Rr1eHJXJYa9v6OZGr0LbueDXOT9qTsWzbAcBf1HBEvw28fhfMkr5K7KXXggt4CwRVvt7/WQmYfOL1O+mpdxpPFg24FMQBRF1/wdTF5mmUBfXCVeBLUGfhkY0JZGA58V0pSNBq2wNKwk1U2ADtp3XVRbLjfHdcsNJecSTZZGTV4E0wp2sq+egFcANTMoKdgVFP63eT3pIAH6lgxsJu4uVCbA21eTyJMlbSIjche6geocl2aeDza3B1AT9l3V63zyGDNiWQ1AHFvEA44sf3kuBVbOJp9AYWUUcw1/le1yVmxxLZug3Unl6+5Xsj3tCFkxPBXqxBrvPylKssGeTHkvuYOap5b0WxLggSeWXpPCiPECDoB+CcEdsdWifstsvnBoIS82FHJM7lHbYE+jcYOUbk1NyIi1UPNAIuPOcmx88jXHSe1AbieM2s2zIGpb1dv7SBwEsnZIGsQtZlTkVzkR7pg/dfXPrC7z69sDPk5mqkSyI7rPYvaZpsfZiE/Ybjc8T8YH16vm1NM+8ktHgFr8yWwsUyRnb2fd4YRIrzTKpc2kIuaQFOVsHBIBTBh8Fw94sSa5HH8SIJttoazeqA6VNiBYGu/UStRnhg8w0UQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199021)(45080400002)(7416002)(4326008)(2906002)(316002)(8676002)(52536014)(5660300002)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(478600001)(54906003)(44832011)(8936002)(110136005)(71200400001)(7696005)(66899021)(41300700001)(86362001)(966005)(33656002)(38070700005)(9686003)(6506007)(26005)(83380400001)(55016003)(122000001)(186003)(38100700002)(53546011)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?neKOpGdcicB2ruHag05XbfXADp/XGP2caUhGsJdI+rmutdThmL8fh7o0QQB1?=
 =?us-ascii?Q?sSrcz8Dt264hVUGDVCh1TS6qtcph9AEWuPCIYCQBWN6yKcK6uy2h7kZ6XmPr?=
 =?us-ascii?Q?Rqw20jXRU3TE2dPOz6auFGQ6lB4b8zRnC3d+J1NWpKHoylGNReXiw0ZDZyNZ?=
 =?us-ascii?Q?dCRDd62J8KS7MFrKKYPvbqFFvdeIJQ9WTa7NweG/CiRwv5bH33Y9Q1VHh0tO?=
 =?us-ascii?Q?hsMmkyRnNBrGYIF/VOSqeuZNC5zrGm2Nuh3I/NO88MjBpafH/T68q016F6zv?=
 =?us-ascii?Q?W9O8ImpLr4LLGLfFprA5dbqBroCJ1lqSqxtchjmwhMmhTbVHuKLNwmzxvIm8?=
 =?us-ascii?Q?/ZHyMXEzuLziRKxzdQsqGxeHTAZhf6BYhnBUpMj703RyXt/1vgol3YT//7Gw?=
 =?us-ascii?Q?NzVRqUDe9cCkFBfUdG/URg8qAOtU8aPkh7+1xinGGUwov+XSfP6WJMh5CHAY?=
 =?us-ascii?Q?OKc0lYekouCKSOsrsC3QYNjaz9XB7D5aDGhgMzjk8iIiWy6fkW7SDij0xMAG?=
 =?us-ascii?Q?B+NmFrWmvJ5S2ZKi5287/yHOBFoom4FhB48L8iXMuW8H9VeQZ6wG0qrI09OY?=
 =?us-ascii?Q?wQJ5QI1ATy+/fvR4+ncAx/0UNXELbGEY74gYogWyTW3mCL2l9KBf0XJeL+1y?=
 =?us-ascii?Q?A3sqff+gUBCg94AXRj09bGQYWc/sNT9JcGxixQASWcpnxxjjeaHv+8NsYeXq?=
 =?us-ascii?Q?L14BxrZ+A45VrOgIFfHGNjoTYHv55VQfcEu84UpRBxgwQAqksAPyIa+qfQ5L?=
 =?us-ascii?Q?wxAoqQ9zjEMXAbo8C++1pwCjSVWlV0BmRMB88ySCwx8veu/qZIFrnji6Gre2?=
 =?us-ascii?Q?UT/VLjN46KvLXTnHMbUU/s/C2UFlw7yh4aAjW1tXft/DbdXCUGT6KycOR6qr?=
 =?us-ascii?Q?cfHNXtmscJsQpIGTQqA+qhCBKezoO9l5hoKf3hxvsG4HbwqOjkBT15Elq9E1?=
 =?us-ascii?Q?LFDPmxL1no833b3yNF4AJaCB/EPAduMa4bkG6jr++N5JWsE6HpRz2bpzz8am?=
 =?us-ascii?Q?1Ak1y45BdT3oILt4TEOKtZEhtg7KSTwClPqzVpZbVrSKHqNs2jfsk+EaidEu?=
 =?us-ascii?Q?DTKL5bAcT6tdZPMOEZvg/XHAQfHrBqG4hjLdrxcu14CplnAh1D+5Nv8oD80v?=
 =?us-ascii?Q?gGQKgzoGkw9O5/OZZSYu1/BZy+qhSxRmjjQvwpYXRAS4537FJfTa2s/TIto9?=
 =?us-ascii?Q?PkS9psmbKpf2TfKM7yZjLrDy+XvfSZsrFWPOF40zNrK0M6Xj8QDlqs6z3Vb4?=
 =?us-ascii?Q?01eFVIAyPVqt+BrQcV8SC5whYFFP3PjK43RRWt+uctPfTX8FO7X/QJnE+JVM?=
 =?us-ascii?Q?CN8AbJZ5pJgqpFKnITV9NQ1cLSpp/QlbPGctFGa8/s2wINDuRbjUHMUVLAbx?=
 =?us-ascii?Q?kuRRZstUlh9SttdhtyvOJZksp0c4ZEa9ILyJekvqykpC9oK1TvPKHDYSGt6K?=
 =?us-ascii?Q?3q1LwxF98Uij/I2x1I3ZrDZiM/aw/gmfnUnt3VwMeFxn5xUG+n1xPu2qAC3n?=
 =?us-ascii?Q?tewcZsiqWEvS9VblXYOwIMy2h74t1heN68eSUun/x6lZEZ/Vo68IS4W7RqMD?=
 =?us-ascii?Q?Om2iuOi6L1pxJGNtK/c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545e3060-afef-4872-e0c8-08db341e7cba
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 08:36:14.8771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k6SC/gXFXPUDRCcS4JKlTIJPMJywsCUWO36GjWmyd19r1AE6iukbpgq2OC34/ycei0bcC1Cnr4M4qa+ktfzo4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7052
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2] clk: imx: imx6sx: spdif clock rate is too high fo=
r asrc
>=20
> Hello Peng,
>=20
> On 03.04.23 10:21, Peng Fan (OSS) wrote:
> > From: Shengjiu Wang <shengjiu.wang@nxp.com>
> >
> > spdif clock is one of the asrc clock source, which is used for ideal
> > ratio mode. when set to 98.304MHz, it cause the divider of asrc input
> > clock and output clock exceed the maximum value, and asrc driver
> > saturate the value to maximum value, which will cause the ASRC's
> > performance very bad.
> > So we need to set spdif clock to a proper rate. which make asrc
> > divider not exceed maximum value, at least one of divider not exceed
> > maximum value.
> > The target is spdif clock rate / output(or input) sample rate less
> > than 1024(which is maximum divider).
> >
> > Fixes: f1541e15e38e ("clk: imx6sx: Switch to clk_hw based API")
>=20
> Before referenced commit, it looked like this:
>=20
>   clk_set_rate(clks[IMX6SX_CLK_SPDIF_PODF], 98304000);
>=20
> I think commit d55135689019 ("ARM: imx: add clock driver for imx6sx") is
> what you're after.

Should I add both the commits as Fixes? Or only the one your listed?

Thanks,
Peng.

>=20
> Cheers,
> Ahmad
>=20
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  Add Fixes tag
> >
> >  drivers/clk/imx/clk-imx6sx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/imx/clk-imx6sx.c
> > b/drivers/clk/imx/clk-imx6sx.c index 7cf86707bc39..3face052527d 100644
> > --- a/drivers/clk/imx/clk-imx6sx.c
> > +++ b/drivers/clk/imx/clk-imx6sx.c
> > @@ -520,7 +520,7 @@ static void __init imx6sx_clocks_init(struct
> device_node *ccm_node)
> >  	clk_set_rate(hws[IMX6SX_CLK_PLL4_AUDIO_DIV]->clk, 393216000);
> >
> >  	clk_set_parent(hws[IMX6SX_CLK_SPDIF_SEL]->clk,
> hws[IMX6SX_CLK_PLL4_AUDIO_DIV]->clk);
> > -	clk_set_rate(hws[IMX6SX_CLK_SPDIF_PODF]->clk, 98304000);
> > +	clk_set_rate(hws[IMX6SX_CLK_SPDIF_PODF]->clk, 24576000);
> >
> >  	clk_set_parent(hws[IMX6SX_CLK_AUDIO_SEL]->clk,
> hws[IMX6SX_CLK_PLL3_USB_OTG]->clk);
> >  	clk_set_rate(hws[IMX6SX_CLK_AUDIO_PODF]->clk, 24000000);
>=20
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.
> pengutronix.de%2F&data=3D05%7C01%7Cpeng.fan%40nxp.com%7Cc7131cb2
> 058346303de208db341e3824%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
> 0%7C0%7C638161076614883851%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30
> 00%7C%7C%7C&sdata=3DbmXiNAsD5SCoNrZF7pTgPFpjbColwBdBsO2qxR0KVO
> U%3D&reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

