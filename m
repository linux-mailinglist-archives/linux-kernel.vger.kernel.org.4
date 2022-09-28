Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1733C5ED5A4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbiI1HDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiI1HCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:02:39 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2125.outbound.protection.outlook.com [40.107.114.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891D2B40E7;
        Wed, 28 Sep 2022 00:02:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjaNmtbJqWNK8gKdRbPcCiefV2JXfzE8mmNMQQPMUBl4ptCeIS2mQmFw2+fRoBwW9Kb3xcDJ4Nm7A7cBSwkc2Chy73HN4+EDNAsvLPGRKnoRIhqSBUgYjXQkzwIQROLEfHYRd6cxRpAVz6WafvjWj0bvi7HFCw/lPVY+NxnstK08oOdL8KXsjpGxh5xuNOslg5iO0HUBbhjppyMzEz5TW2PqYCIZPKjgIYIdsAEXj82/76pFYdwPTi65iAqwmzf5tue6dZRtnh610kG888BLId3pzkTqCqMui9Sy30Cmi/LwbKVIcO0xrLHqM74WQ2P4RH2bFJII7OuJmRra0m4auw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApE1WhhEDtlgBKk0pLJkNFTlSmq4CMAfhV4tKtPwvv8=;
 b=GfOaZdDUVJu8im+Lj48p6h2phbqN1FFilyMP1udAJi7qnYvzh6I7GRzKicBzNQ8BAw19+RhFpOH2gwl9/8P/Y3BUwyVCpYFZTBmhC8vT0e752JLbpxaVceTQUiEh8p3yKrxd7RsWOrFxCYw5/XVrs15sv1GLlRTQiMoS5XOeCIuHblDmGggR56daMiQi7oX4a3UHXfxPfRCZ+C5cRUFRnDzAS7n4dTz2wfAZvF4F3m6xCYCQgHczwTslaYAoJuKUkS3RJhf+57Nk98dYDwBdjLlalFas3fDQDXDfv+LpHTfuxEQ4QRUtYlZ6KQYPDt9Fd3Ge1Jc9anoeD9WB6dRI5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApE1WhhEDtlgBKk0pLJkNFTlSmq4CMAfhV4tKtPwvv8=;
 b=OSi3zIf6BC1axIqtog1iYkziprcFWYW0OqvDapj0kewoJQs6eZpytX0iO30sqzOBf1peWUFDPiN0ETKfX0nTCcnxorhqPFO3y3gZVvrnOMGhfoDhVkC+RusEEeL1v9USSXBLGhnl7BKdMslIMbbwqlP4sTRw54A+MRlcZGwCLV8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYBPR01MB5408.jpnprd01.prod.outlook.com (2603:1096:404:801c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 07:02:29 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%7]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 07:02:29 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [RFC PATCH 1/2] clk: renesas: rzg2l: Don't assume all CPG_MOD
 clocks support PM
Thread-Topic: [RFC PATCH 1/2] clk: renesas: rzg2l: Don't assume all CPG_MOD
 clocks support PM
Thread-Index: AQHY0rAT5OHSv2fHs0yDbVRpX5zXfq30aRrQ
Date:   Wed, 28 Sep 2022 07:02:29 +0000
Message-ID: <OS0PR01MB5922BE73295E3562DC3FBA6E86549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220927203044.751611-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220927203044.751611-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220927203044.751611-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYBPR01MB5408:EE_
x-ms-office365-filtering-correlation-id: b65d8875-3ccc-4df5-177b-08daa11f687d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M3epZheM/d51XpQbWU3t4zNyWKIaRxEqu8gUbPQRLMz7rZjV3CwyBy4OZu7ueRWJJowceX4mowZHm4DobVyjgTrxibptc/z/u+i175sWnurd0E33GHiqk/snBtBYy5u3qDVRZkM0pz43jVL613GtcAkxjpU/qkLj9i6JhhODFITBM9H/kS9j+OAyI5J9JoQuOHqdObDRNJGG/ceq0BxPpaUBdpm29O/W3s1OkMVDVLWoLC6MbcafNByZSNErT3Kfk1ENZuENp4UuuAfvHuTppfWLxJAYba3z6qgJ8SS1GY8EMt6BF/LWww1vCU8KUB4UZL3jD4VvVJRcOfJ0qc8MFq3dJVSyM2KwoBw9gvIWjK8DtGsGL1XFRi7QeNKOuBaaTdo7XwXlRNPMvtNp39rNUFV8NPGrGgkZhZJABN0rDJw9YXFNhtFcV8KhfxOlckilNdKAqjOBFmj5hB5suaj3OfB4SgsrfaI78T97xobfGb693jKFYQ4wG4SCZJ0EGLNqzVZe77cjjf/4+pJR0m58xL7CRBbxUJpVP6C/wH5DkZ3Xhrl1pWIab0nc0zD9e5FmRQI4FoHjLnk0cjcTMtijoHlS5wGj3spzS+eZPZh405jBB93M+gUkff+Adk+UaMQYwZeyYTz9Ifq+mzJODsbUatCpdHsT8AvRo1JNmbxlgq/UTPfXWwrLdgiOb1tODNSOc6WEgKJJ+A+8MjxYGqhY2zjib7m7oIGrrV8H4jBrPKFnjvuMjl3oyO+jsNsIPpwEtA0De+3ict0SwJOxWWTK7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(451199015)(6506007)(26005)(9686003)(7696005)(38100700002)(122000001)(71200400001)(316002)(186003)(86362001)(38070700005)(55016003)(33656002)(83380400001)(478600001)(52536014)(107886003)(5660300002)(54906003)(110136005)(8936002)(76116006)(4326008)(2906002)(41300700001)(66556008)(66946007)(66446008)(66476007)(64756008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lj9hkM9VNPoMmWeANATmbFB6w1bvj/vDI9fsEk78bTIOg8O54bJIvXBcVP6q?=
 =?us-ascii?Q?8jV1Wl4s2QVOHoxjL12h0o4F326q+9KeVik6sud+df54QO4vwOt+RxiwM7cb?=
 =?us-ascii?Q?TI6C2MdRdzSHcb+aXmdqokv7dUm72BI6sSU78s9I3i+ZuteJtGtG5xWebai8?=
 =?us-ascii?Q?YA60Ix26WZaql5NymVouQ6xJ/0lp5tbMpJatHgITmAMkxC88OJy93MharRJg?=
 =?us-ascii?Q?fbO9WtlQNGl4KHGO2UU0b42Kv128whrXfZ4k6HIe4JtIabcdmfqUqzUXkMMe?=
 =?us-ascii?Q?qBRzLs4lF4rzF4R0R6+4sdxcfDqzxdzPCXNE7XB8wwQ/cyzgyrna7w5YDYVK?=
 =?us-ascii?Q?tGTAg3tihNtc0XQAM2HdGlE55S0yJenggl7eEUvX5VaZUyFXMMfJQuh4slt1?=
 =?us-ascii?Q?pYtbcvwaURUqSdSpVkTNlAmcKOSMsw+CdtKTCqxMYA16PXYms2xuNrABsM/n?=
 =?us-ascii?Q?/Kov7rg7R8ErUD9N1pH4NZHU8nxwBOi/BDnWXtPN7K3U4oUzey4MiPlDJcV3?=
 =?us-ascii?Q?MDjhmNyWlaoXGBVEsrorVIbbdYlgv2KduUG0m1D/XGmg+nG8KSwVolAeovE1?=
 =?us-ascii?Q?yLLujptv0NR34jlyznpiCx9p00HOeE3qEgoeiuxAtsRIwYS74TmaL55+gnIQ?=
 =?us-ascii?Q?4LFzUB87txo+4YPO4CIZv6Ev9RuxY/BXxcBgy2hYrSXn2USdWD7HlHmtDcV5?=
 =?us-ascii?Q?aAm/f5RBfP/a1dNyTp7/LlmspndKcu7HPk1KK3Tk8wAMw42BReioSjQ4QC82?=
 =?us-ascii?Q?h46zcT9akbrBKmTyq+OAwndoSobfFltC2cJwDyTYabnORsqH3g18qYbAfsGD?=
 =?us-ascii?Q?1bI1hgXvTQ5539lkSAKHeQ01KpJIzlBu/RjBA0WLZw3hktAbZmCXA3EP7XwI?=
 =?us-ascii?Q?39zpZND5F+JeavgZMPXu439c+/X6S+NYGQZUHw98e0szCcD7uVUOaHAeDIP7?=
 =?us-ascii?Q?OuYwHcFoFA0LhQ+YeHeDBnp/ZQlEeR/8tskQzWCN7KnlxBji5XedHWDF0bK8?=
 =?us-ascii?Q?Gpk2p79rXR60nLmJSaPFRzSgWrL9SC3LzGUf21W1HtClzaVP1h6fZ/bNcXSH?=
 =?us-ascii?Q?MhLIOzyeb2tHiCtF6A0iCEgIeMa7PaOXCegD0puYq08g9Td6vA97Z12aF9P6?=
 =?us-ascii?Q?9dlXXUwBkjLGMvNwrWbNjhUbsWQo34F49al7u2hYLIvDV4JfvS8aL1Guysyi?=
 =?us-ascii?Q?LOEi/Pxt8Y3+Knc/gJR1KQXmAqn5tXC2cm+qVVpH2Q/Dpisf3ALccInF4v1o?=
 =?us-ascii?Q?7IcJCmQEL6HCyxwZi6dB/hKWbsBOKxqN7SUhtG1DSonUktMb4eow6RWTw68g?=
 =?us-ascii?Q?VF8xTGj11zrMkm48q/66SaVHBoP8E9GZB6X+m5s6mxbGOEe4i5UV4qreDNvK?=
 =?us-ascii?Q?elvY1u+OyS2aLXwQ3NJs3Oi43GOtm27dVHk4KsXNla9MTEnT8O7jYP9LG1h8?=
 =?us-ascii?Q?TKqGiwXiGizMHPUZXv4pNSdof9r/eFKJsAlfkmY+ihlymdj55odp5sMG7PuU?=
 =?us-ascii?Q?dd603s1hwYJPmwfWVQCmPw+B3X2e9zfRIV2zxan5DvIQ/ijzz57Yr2uE48Tx?=
 =?us-ascii?Q?nfSnMJtC82KxD2WaKYO2TPsrtoyr5XR1yUx/PADz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65d8875-3ccc-4df5-177b-08daa11f687d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 07:02:29.5276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nxCVPnDRQo2u67y3p3fjw6f3ekuBZ9na0I/gpVN3jMotqrDA9j2MNpP21vCXCFfS18xzvOtOmoMevzVIdTcg+AXG3aQbUTc95ZR/w7OhyOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5408
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

> Subject: [RFC PATCH 1/2] clk: renesas: rzg2l: Don't assume all CPG_MOD
> clocks support PM
>=20
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> There are cases where not all CPG_MOD clocks should be assumed to
> support PM. For example on the CRU block there is a particular
> sequence that needs to be followed to initialize the CSI-2 D-PHY in
> which individual clocks need to be turned ON/OFF, due to which Runtime
> PM support wasn't used by the CRU CSI-2 driver.
>=20
> This patch adds support to allow indicating if PM is supported by the
> CPG_MOD clocks. A new macro is DEF_NO_PM() is added which sets the
> no_pm flag in struct rzg2l_mod_clk and when the driver uses Runtime PM
> support no_pm flag is checked to see if the clk needs to included as
> part of Runtime PM.
>=20
> CPG_MOD clocks with no_pm flag set need to be individually turned
> ON/OFF depending on the requirement of the driver.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/clk/renesas/rzg2l-cpg.c | 35 +++++++++++++++++++++++++++++---
> -  drivers/clk/renesas/rzg2l-cpg.h | 12 ++++++++---
>  2 files changed, 40 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/clk/renesas/rzg2l-cpg.c
> b/drivers/clk/renesas/rzg2l-cpg.c index 3ff6ecd61756..d275324909e7
> 100644
> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -114,6 +114,8 @@ struct rzg2l_cpg_priv {
>  	struct rzg2l_pll5_mux_dsi_div_param mux_dsi_div_params;  };
>=20
> +static struct rzg2l_cpg_priv *rzg2l_cpg_priv;
> +
>  static void rzg2l_cpg_del_clk_provider(void *data)  {
>  	of_clk_del_provider(data);
> @@ -1223,18 +1225,42 @@ static int
> rzg2l_cpg_reset_controller_register(struct rzg2l_cpg_priv *priv)
>  	return devm_reset_controller_register(priv->dev, &priv->rcdev);
> }
>=20
> +static inline const struct rzg2l_mod_clk *rzg2l_get_mod_clk(const
> +struct rzg2l_cpg_info *info, int id) {
> +	unsigned int i;
> +
> +	id +=3D info->num_total_core_clks;
> +	for (i =3D 0; i < info->num_mod_clks; i++) {
> +		if (info->mod_clks[i].id =3D=3D id)
> +			return &info->mod_clks[i];
> +	}

May be as an optimization add ID and clk to a separate list
and traverse that smaller list for DEF_NO_PM case.

case CPG_MOD:
	return rzg2l_cpg_is_pm_mod(clkspec->args[1]);

Cheers,
Biju

> +
> +	return NULL;
> +}
> +
>  static bool rzg2l_cpg_is_pm_clk(const struct of_phandle_args
> *clkspec)  {
> +	struct rzg2l_cpg_priv *priv =3D rzg2l_cpg_priv;
> +	const struct rzg2l_cpg_info *info =3D priv->info;
> +	const struct rzg2l_mod_clk *mod_clk;
> +
>  	if (clkspec->args_count !=3D 2)
>  		return false;
>=20
> -	switch (clkspec->args[0]) {
> -	case CPG_MOD:
> -		return true;
> +	if (clkspec->args[0] !=3D CPG_MOD)
> +		return false;
>=20
> -	default:
> +	if (clkspec->args[1] >=3D info->num_hw_mod_clks) {
> +		dev_err(priv->dev, "Invalid clk index\n");
>  		return false;
>  	}
> +
> +	mod_clk =3D rzg2l_get_mod_clk(info, clkspec->args[1]);
> +	if (mod_clk && mod_clk->no_pm)
> +		return false;
> +
> +	return true;
>  }
>=20
>  static int rzg2l_cpg_attach_dev(struct generic_pm_domain *unused,
> struct device *dev) @@ -1348,6 +1374,7 @@ static int __init
> rzg2l_cpg_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->base))
>  		return PTR_ERR(priv->base);
>=20
> +	rzg2l_cpg_priv =3D priv;
>  	nclks =3D info->num_total_core_clks + info->num_hw_mod_clks;
>  	clks =3D devm_kmalloc_array(dev, nclks, sizeof(*clks), GFP_KERNEL);
>  	if (!clks)
> diff --git a/drivers/clk/renesas/rzg2l-cpg.h
> b/drivers/clk/renesas/rzg2l-cpg.h index cecbdf5e4f93..1d68d3838392
> 100644
> --- a/drivers/clk/renesas/rzg2l-cpg.h
> +++ b/drivers/clk/renesas/rzg2l-cpg.h
> @@ -176,6 +176,7 @@ enum clk_types {
>   * @off: register offset
>   * @bit: ON/MON bit
>   * @is_coupled: flag to indicate coupled clock
> + * @no_pm: flag to indicate if clock doesn't support PM
>   */
>  struct rzg2l_mod_clk {
>  	const char *name;
> @@ -184,9 +185,10 @@ struct rzg2l_mod_clk {
>  	u16 off;
>  	u8 bit;
>  	bool is_coupled;
> +	bool no_pm;
>  };
>=20
> -#define DEF_MOD_BASE(_name, _id, _parent, _off, _bit, _is_coupled)	\
> +#define DEF_MOD_BASE(_name, _id, _parent, _off, _bit, _is_coupled,
> _no_pm)	\
>  	{ \
>  		.name =3D _name, \
>  		.id =3D MOD_CLK_BASE + (_id), \
> @@ -194,13 +196,17 @@ struct rzg2l_mod_clk {
>  		.off =3D (_off), \
>  		.bit =3D (_bit), \
>  		.is_coupled =3D (_is_coupled), \
> +		.no_pm =3D (_no_pm), \
>  	}
>=20
>  #define DEF_MOD(_name, _id, _parent, _off, _bit)	\
> -	DEF_MOD_BASE(_name, _id, _parent, _off, _bit, false)
> +	DEF_MOD_BASE(_name, _id, _parent, _off, _bit, false, false)
>=20
>  #define DEF_COUPLED(_name, _id, _parent, _off, _bit)	\
> -	DEF_MOD_BASE(_name, _id, _parent, _off, _bit, true)
> +	DEF_MOD_BASE(_name, _id, _parent, _off, _bit, true, false)
> +
> +#define DEF_NO_PM(_name, _id, _parent, _off, _bit)	\
> +	DEF_MOD_BASE(_name, _id, _parent, _off, _bit, false, true)
>=20
>  /**
>   * struct rzg2l_reset - Reset definitions
> --
> 2.25.1

