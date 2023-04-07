Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50836DA7C8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 04:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239568AbjDGCnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 22:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbjDGCnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 22:43:06 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485AC171C;
        Thu,  6 Apr 2023 19:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2I4pXGEY0XzEKp7Cekdne9Ob4cdU2WnSRNuir7KlBQB6yA7tTE49iYsOWAQOoNLOom2WTvdTWhbbe85hWW7OvjMYqYbjfo4/hyKITr0Qwgiv5tn2MsXKryFDMmeuHz0syVK6MjtAvGV9GtakLUlJV/DhUnoMb8SeF2Z+vN1VWY7VcfBQPtbBzZbsSs7BTMDP/4yp7WsXp3JQfxHiBnVRaPS760l7zCB68NSH5k0ierycO/KC9Q/U9LJErq3fl2V2xjd9klJkg6r8iw2nAenfCt5eWZJFSC/6urLIahU+Jv3yuiWzd+2vKtYNOwJlsZ2vPd7daLDQ4sK6MF/2zpo2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOeypu2z62pgy9lswp4WN46mT/1nVvSmfADDJbNoWnc=;
 b=KpqqfZ5o4GwJrywiCQF+WLlXpTCCbdT2pyd8jDqLbfwqXplmWiBiM8utQv3edya2CArwq/QnVX1SGJaQh0pkPTA2DH16324Jy5neBU2ArhWEf/xQHe65SKWUYIXOBn1DZX9DR9i0CXgZ1C8OrczFlkZsGrtWWUy6iGzn2z/VYVFZGNLrgXi2H7cCANPPv3rGIeHB7fIw5AdVWKClJo1B8ifxZMoguJnyqHmF6VGhKzpqP0DNg6Kbfcr6b/8Sdsdq5DiNv9PemrWbwvC8zX0UdADfn3VVFpaW3Qc/kB9+8rucWwZ5NCACJ3UEJRGbWPlRCXwlbMlqeccik/0X9Zh/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOeypu2z62pgy9lswp4WN46mT/1nVvSmfADDJbNoWnc=;
 b=cToasc9WjFvmxHQAhoQe1mAVDeMV4pE4/rXjZ0vfUFslexjy7nWzthTBzJ2tl7VCiIWYySGJ4L69ZmZu1Oj6J5bKdmkdVG0XmIJuOBX1NMXIkJxy0H1S+YJpQKG0mGeM205ExKWakDcylMYtA8TLyfxg3zf3jL0RHPW+1/FGPpw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8669.eurprd04.prod.outlook.com (2603:10a6:102:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Fri, 7 Apr
 2023 02:43:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Fri, 7 Apr 2023
 02:43:02 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Hao Luo <m202171776@hust.edu.cn>, Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "hust-os-kernel-patches@googlegroups.com" 
        <hust-os-kernel-patches@googlegroups.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: clk-imx8mn: fix memory leak in
 imx8mn_clocks_probe
Thread-Topic: [PATCH] clk: imx: clk-imx8mn: fix memory leak in
 imx8mn_clocks_probe
Thread-Index: AQHZaPK9fbFOGC9h40WaOb3C1vgrr68fIxvw
Date:   Fri, 7 Apr 2023 02:43:02 +0000
Message-ID: <DU0PR04MB9417B63DE97D4A2A77B4176C88969@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230407014414.22237-1-m202171776@hust.edu.cn>
In-Reply-To: <20230407014414.22237-1-m202171776@hust.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8669:EE_
x-ms-office365-filtering-correlation-id: dba0b3f7-f6c5-43d0-fa85-08db3711ce93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 92IpNGjPR8aHdKWFRVfO2y/wCdK0eZ3o31J6zgnlP1sQKkfNrMjMQMJS9sGRrtLqhtXoOBbYKwQvGvsM6n+XRFMitwfxiyG6XAvlSSVs+lGZbnnKO4/Z6hx3BzBorEfUORr7gL7+R1WREKTp0RFZcAlDFnLjgbivgAB36xIFiSJtVEETVVF24RTBgx1iNZGFKa3w8HfkCTWSYhPMQ6OEBKoYqQKayzAXxCOFWZ3cxoPqwWQEoFiX2OMKz4DnjlBYjkF12iMYx8jlbOP9ShpJEq6kgO9yzBuCw6vhXZDszoEAh19bwUaur4PPM7fGWxAEuqxXa6YHeKJ4VMqjp1f5cdY8wDU6VgGeDTZrfWvbaMAlMIkMpf8tiy70KRnDpedBGKkDFxGucWplhSBgixY/G62BkVXsVOReC8YBB+LOVBNzRGiHQkZO9eYLiyV0eh5Dlr8kMXIte6cPP09cl7SRDW+tWeen+kCJ8CTCfjdJYctNqVyGw/zLvVuXycm6ObaD7VxttqmTYgTIFhRkXiue47/7Axsd2IARnBCdGR2loAmDui2AWBvkaNwe2GNbLyzAXeWJp7DJ/u3Ebsu7MSpApSXAdLAXBwTd8EhbvXVYg/g0CbRWcSfAMVQIU0dO6nD+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199021)(26005)(9686003)(6506007)(33656002)(86362001)(83380400001)(186003)(122000001)(38070700005)(2906002)(44832011)(52536014)(5660300002)(7696005)(7416002)(38100700002)(478600001)(8676002)(71200400001)(8936002)(110136005)(54906003)(6636002)(316002)(41300700001)(76116006)(64756008)(66556008)(66446008)(66476007)(66946007)(4326008)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vi9JQsQXhwmsKzd07CjLH3ED01AhQYjG//4lcPP7KfDD5gLuVlLi5/0NZw4U?=
 =?us-ascii?Q?T4g2eM81/gL1c2yuE0pIfnhHNCLls690V8GEspZL+G1fcOzugO99QA5EhE7C?=
 =?us-ascii?Q?vU0/fp2q/RY1r6zyagadCDnptJtNlYYVLrBOhQC/FLLQ8ylu+ARwLLStWGTw?=
 =?us-ascii?Q?3EVM0DoBcCx5Dkx87DYUf2aNuOaVURJWe71ion3Dm6xfx0Ej1BntkelS5vCl?=
 =?us-ascii?Q?xVnK3xhQw6YxB4GYqD3PCnqLszrpbZsEsRAYw27qHcGihY9N2qilmQi4hpPR?=
 =?us-ascii?Q?ZUoCfXmZ5FilB2he1T/rs10TqbSqXGn/zvF8jKdc0ZPZdluUxrYRyguDZlHw?=
 =?us-ascii?Q?hxNcKqNYlXJcO3sobnO93l1sR23v860lOAcoWMODwalzA8xV/Otqcd9rR8In?=
 =?us-ascii?Q?rvItOTjbKfJQHtAgh+jKPHJW+HofUjBOU+qU2uqisq/2ZgQcgkO9AQp3/V5D?=
 =?us-ascii?Q?CXBm6UyCLqqAGwqHwLmB/Mhqne6poeMvISfAd5+hADM0TZLWAAahKpZDKZJC?=
 =?us-ascii?Q?/6uJzOKuNKrmovMM9hidLAm2tGi1L1gOHPjV+Dp2GZKuJJnXYtmvwy/9g/mn?=
 =?us-ascii?Q?5ARuZZ7eFRM1NLaWffEhVQGcYSzr4hq1eNaxcl9mbvBtpcSO44RS1jncmtGR?=
 =?us-ascii?Q?p9OmFaHQCtjIwqc2MlXYiLtFHdEsvCzc04PpaRZYfBBtQkHk8nJd+CBGswb6?=
 =?us-ascii?Q?Gjvds9A3LX74Lqn5M/jel8Efwix0zon0gJidYGzVXxNk0s1FbP6lNWXWVQV7?=
 =?us-ascii?Q?hRIDt7tkrNDtRqi4S1xBNMIsNko2bRFcgZnvg4HHclOJRFNm7nWzajPqh1Ey?=
 =?us-ascii?Q?BHvzW8cfwdamiMaoJhVJu4gfWG86+gZflXwlMmapQavAZl0cr7teNkFwblZZ?=
 =?us-ascii?Q?GDKw/5+lMuKzi1QlG9PE5FCkh3bCLuGsal43SO4xtGhjKXyKCmCvXPHQtj0u?=
 =?us-ascii?Q?FfGxKJ3FEL5A1EvITV6WvJ6Kc2dX3KE10ZhJYcVbs/+J0mBo8qmNVsrb7BjO?=
 =?us-ascii?Q?GIXD3eBb+AZy4lu0Z3ZyZ7Pw1MNykGw+eqrU23iQNY/tWFbIzj8IByDDc0sJ?=
 =?us-ascii?Q?ZKMOiKnaClHR4S7em2STb1pUtd114eJpUeWWdaV8Q5FujV7wDzqOrGfuKuac?=
 =?us-ascii?Q?0E0CzE9rffkfYEHew0m8+Ja6akfIrgpnKVUmuSzjLBdkzcay75dXB70GE60x?=
 =?us-ascii?Q?XPqmDDs4fpN9wVvQi9UuWQKg61hdJ5moOJyqOuRBBewwlNPG1mP1ZP3IwVLr?=
 =?us-ascii?Q?MvPM4pqiDQd3emeE5n7UUynlgEwKJaK4dW7yhttjmwz57esLtc5JaW5i4UAS?=
 =?us-ascii?Q?uEcJfoNRTvjQMX1vNbQm6f/hLYKrU2P/CMG6YEvZCrK4C53nvICHttX7r2Hz?=
 =?us-ascii?Q?Qj9QD9kyahZ8zPqB40t47KcDrFrlc1IfZ/6SX8fiJ/LwjgbXesenwQIhZ7mz?=
 =?us-ascii?Q?JoaBTnoVX8dX1WWQGua/Mw6/lMAlF5CzE2ek6iq0MuaHYpooqCMzuFnjqxPy?=
 =?us-ascii?Q?392OW9cLycbvVYNPUHDthlvEdZrMpsU0eWMtd4mS70Teb524TeJ6hkQiLIlT?=
 =?us-ascii?Q?wINKQhgEmmob175Rv0I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba0b3f7-f6c5-43d0-fa85-08db3711ce93
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 02:43:02.2685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7nONopyg03V5kS5Jnquuy4Z4GyLz7aG3CK6sQMNA848zJoBVvoqy3/roKAaTm5JXOjs6mp5Xc+cHt/yzyt9iBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8669
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] clk: imx: clk-imx8mn: fix memory leak in
> imx8mn_clocks_probe
>=20
> Use devm_platform_ioremap_resource() instead of of_iomap() to
> automatically
>=20
> handle the unused ioremap region. If any error occurs, regions allocated =
by
>=20
> kzalloc() will leak, but using devm_kzalloc() instead will automatically
>=20
> free the memory using devm_kfree().
>=20
> Signed-off-by: Hao Luo <m202171776@hust.edu.cn>
> ---
>  drivers/clk/imx/clk-imx8mn.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index a042ed3a9d6c..b054412f6373 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -323,7 +323,7 @@ static int imx8mn_clocks_probe(struct
> platform_device *pdev)
>  	void __iomem *base;
>  	int ret;
>=20
> -	clk_hw_data =3D kzalloc(struct_size(clk_hw_data, hws,
> +	clk_hw_data =3D devm_kzalloc(dev, struct_size(clk_hw_data, hws,
>  					  IMX8MN_CLK_END), GFP_KERNEL);
>  	if (WARN_ON(!clk_hw_data))
>  		return -ENOMEM;
> @@ -340,10 +340,10 @@ static int imx8mn_clocks_probe(struct
> platform_device *pdev)
>  	hws[IMX8MN_CLK_EXT4] =3D imx_get_clk_hw_by_name(np,
> "clk_ext4");
>=20
>  	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx8mn-anatop");
> -	base =3D of_iomap(np, 0);
> +	base =3D devm_platform_ioremap_resource(pdev, 0);

This is wrong. Here is to map anatop register space, not ccm register space=
.

Regards,
Peng.

>  	of_node_put(np);
> -	if (WARN_ON(!base)) {
> -		ret =3D -ENOMEM;
> +	if (WARN_ON(IS_ERR(base))) {
> +		ret =3D PTR_ERR(base);
>  		goto unregister_hws;
>  	}
>=20
> --
> 2.34.1

