Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C70F6806AC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 08:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbjA3Hob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 02:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjA3Ho3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 02:44:29 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2104.outbound.protection.outlook.com [40.107.22.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B911630A;
        Sun, 29 Jan 2023 23:44:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vmcy2civU3LRFCyL0XYssw/x040OmRbIzgNm6fh4H5R7K2XwJKRKmK34T5LZRP9X0BmILJ5Qbrb6FWxb0YTzXmT7wYBznw3qPwi8NHYiKccz1Y/Z2Gvo3Zyk+kyoqaYLOiRLKDtCTBasIQl/+ckcthimpM905jsMrZOw2iGBYcjSuSMukiYeiNBxhPZyjKG5iUqqDGNtrDfBMJFdERC3nwQvDYnIqPHUglhX6+ic6M2gG/baEqCuDte4xVyOS9fto/uG+shVm/AFA/9EkpE1t00y8E5OeRMwO5y0mp02i5gyVeJkxvtJ/L1CdZKsPFW8WivztHispQ4rDRPX+aj48Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XD6GJMDCQp9QwWA5z4sif2q4wZQdn7/h5rFqQKdWWg=;
 b=V5RoE/+0C5Is5uj47xZ/w8cp98Sa7dxZrnYwO2GACz/FuVQjxkzpOKJezUwAr5wiuEDji7eQT0GX0TIk2rDJtz5vw0tpcQnD0m6I7Jt2Q8MyR/FHBdfOQyPyObA6J7+1oMf4oWkyj4rFDladE7Jr9jb2Gi/O8RJTNh3TDXeEDtTZrESQUxCNynBOormaD781n+mcZCskyob9ziGM6OZRImpoOHVXnN5Z2fVs0WVIeCmMSZtvrx1xI/SIbm16PXzseTNVBVEbtc/2vXzBzTZ9GyEAAMLbdh2OIVuSAt/ALozsaUEGUWoID4ge7NnVoJGa4QCusXPpZmnuGyDmWMuVPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass action=none
 header.from=leica-geosystems.com.cn; dkim=pass
 header.d=leica-geosystems.com.cn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XD6GJMDCQp9QwWA5z4sif2q4wZQdn7/h5rFqQKdWWg=;
 b=YhTBb4zOvslh8u/YuzkaJjIjqw0ux6ccaPCP0UfBLHS4P9hAHQqpUkvf/TC4MAdjhZqWTeOsp2KVCWJnCvnFomElav2hyzo3LHRgP2oLU5SnyoczLtI34wysLsdCwAOecWv0asW78Gf7dYvWSZugXqSrQ8cBA5AK7O9rfEIj6Ws=
Received: from AS8PR06MB7432.eurprd06.prod.outlook.com (2603:10a6:20b:319::19)
 by VI1PR06MB6048.eurprd06.prod.outlook.com (2603:10a6:803:d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 07:44:22 +0000
Received: from AS8PR06MB7432.eurprd06.prod.outlook.com
 ([fe80::f9f3:1817:9d70:9ae3]) by AS8PR06MB7432.eurprd06.prod.outlook.com
 ([fe80::f9f3:1817:9d70:9ae3%8]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 07:44:22 +0000
From:   LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
To:     Abel Vesa <abel.vesa@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
        Peng Fan <peng.fan@nxp.com>
CC:     "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "18701859600@163.com" <18701859600@163.com>,
        GEO-CHHER-bsp-development 
        <bsp-development.geo@leica-geosystems.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: RE: [PATCH V5 1/1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
Thread-Topic: [PATCH V5 1/1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
Thread-Index: AQHZJaUE7c3fVoklQk2J+dEYTT71AK6hIlWAgANwrACAD7E5AIACRXHA
Date:   Mon, 30 Jan 2023 07:44:22 +0000
Message-ID: <AS8PR06MB74325B5E249EC287F052518BD7D39@AS8PR06MB7432.eurprd06.prod.outlook.com>
References: <20230111101030.686885-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20230111101030.686885-2-Qing-wu.Li@leica-geosystems.com.cn>
 <Y8VfEfnWwt8+QB1W@linaro.org>
 <a1285cb87151130de782fc1941b13f34.sboyd@kernel.org>
 <Y9VruNgUuA5h3d70@linaro.org>
In-Reply-To: <Y9VruNgUuA5h3d70@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com.cn;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR06MB7432:EE_|VI1PR06MB6048:EE_
x-ms-office365-filtering-correlation-id: 67f43707-e8ad-4d99-9b35-08db0295cdb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rfF2+Nk8I+TZGpsmRzwGbCGzbcJxFELiT9iup2vPkJYpQNprrsWQfOSgDD8q7mbL45tCQDXzMoyuFHIf7GjMzF3ufHmtcTgJay61r1BVsH2p5S3+kfHjeVaTuwg9ZlmNnZL3H3Au9HGTBHJ0GuGkt7Mcq2PbxnByqV6luWfg+mcla2tvxUmwbKYNrh/mwCvK0ZzJhpz6R1mA7jYbAmXrUfldpGNM7A93FdbqcG2hIqL+TujLo5XZrAHYxR/OdxwnnmgC79qM5BZ/PZfBpZ+BXacBC0A/k3z45XRCkmW0lKLNergeMWz9x0/OJSCt0oNCbnPRsESAcoDjRGVlQmmclfTfWhoJGN3c3hv2XJfzgDEY1NAhgZ+UdRxpe5JWxSLemNH7+LT0jLVQmmftUh0a8VAs962NBLwrTes0IRYngQGTAoNbil7wkETgD0JYIAJHao9kEaqcYczPVHFMso03oVYwBXTcyji3SbcApwkY+cyemfUv6G2AZv1bNIs/DmcTKqRfm37cCgZV8Oixhp+m32cfXJt9RlUcx5UtdWkLtyEzJtwe767zfNUkHVnRkqM3hny9PNPEYhcYjG0gKytTGzZJnM5omc1Ik09uHSftBMJMPedjDN1gmDN+RXBzt/svHz4j5uLBavj1wbMq99AFlDUfN9kimIzOR/QThhLb6xVwSE7AhqqylFzuJTe9VAQ3vNDSYhtyXYdSkjWHfPLBoDFpGAjXH8BHW7IoUgihpIM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR06MB7432.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199018)(8936002)(52536014)(38070700005)(9686003)(186003)(26005)(53546011)(6506007)(7696005)(110136005)(71200400001)(7416002)(54906003)(55016003)(5660300002)(33656002)(478600001)(45080400002)(2906002)(86362001)(316002)(966005)(4326008)(64756008)(66556008)(66476007)(8676002)(66946007)(66446008)(76116006)(83380400001)(122000001)(41300700001)(38100700002)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xLbe72SPlB+B9G4/xuSc5350rUber6bSpS9JvOWyJeBCoX+8e11Qu9kofgCT?=
 =?us-ascii?Q?mWFwnTvqWum81KrJA5lsxVowIIITxuq9F3GscIBR3dXxI5Y4nAjWWNPjqM+P?=
 =?us-ascii?Q?RhYs3lcHHdP2uc7ybIVDe9cxKTa66KLQGCelTiQTti4BDhWNiTC0BKBa4zhy?=
 =?us-ascii?Q?/VwoZdpB+4kTM1CGDNtO5MD8cZun/MZ0Tn8DeQdnwVWNQ660VAP8BAFxU/cd?=
 =?us-ascii?Q?B3YydWAJh2xJdG4fd/GW/YGs63GCfBUsqCD5l2IQIbqXGP3TLdpoDfzSfm7E?=
 =?us-ascii?Q?0IJgZzGi37wrEKff2eT4/6fgxQXS8D9z+eAnnhKB7zh+YJuryyaBzCDyAwsR?=
 =?us-ascii?Q?OkHnvQjbs5dgKiBES0cQNTBtV+bcMgy4nlQLLf3J0Fw84Zchxlcc4T/R5Mmb?=
 =?us-ascii?Q?ydJ4C81XggS3J1vg+Gob9GaVGv2+XLRUTmM8d11L7kEcuEOLShMwTManlMdR?=
 =?us-ascii?Q?mHQ4NvTci/pZz2api+K3X+3z18nAcL7aOAlQKjJyRwB7E9zth+UauudGbLiR?=
 =?us-ascii?Q?pt60yu45edIcG5vZ9TBDj4TERA2FZaQmu3WIESm41GQ2AaOjlA+xjn3ZX1xh?=
 =?us-ascii?Q?jjzB8pVKq9O4308kqbW2BNeTAmbglfq504VjAZnLjaeNOD3jo7+ja36QKgtX?=
 =?us-ascii?Q?jarhS58QS7fkrF9VlpUBr6ft+8HbWCPqqpSF36lGf1QTcQxZEt6ga0JCu676?=
 =?us-ascii?Q?XlUmRnBZxx4n3K/WKLTDtvFzhYOnLWZ8pFAMNJjZA+6bL0K2g1QF31XGSVQq?=
 =?us-ascii?Q?0llG3qLZf5Tvuh0o3RLyTTyRs2DknsZ2jpFN+rCXZ3NCgJQRz1e6PgY6Htn7?=
 =?us-ascii?Q?ZvlVU8HaU+Lj71YXnkgNiQISY+S0ZUThs3xwGfC4kph2Xk3VuLXOnksHkL83?=
 =?us-ascii?Q?3xRC5JhFsiQiXOf9TYEAO23+cXX8PpNqqdPcoIO3BM7M/fXEmO9A8SLdEqQD?=
 =?us-ascii?Q?1I2dIVevfY5oYI97GxcFhF6XBWaXg87C9klAjQm+ntkCTTUyGCdqPGVcQRLS?=
 =?us-ascii?Q?46xJKtsYL+31fkS/lVgJ0elZXhn/WRt2Je+nZjHo+Ry6BTIgE/uSFnkQfEcD?=
 =?us-ascii?Q?lCmRNzJjbJSIENsVaKciypO/WKBHCgpMqlLHACRb8Vg+xDb2ZdFt9XR4citw?=
 =?us-ascii?Q?ORwu0wumV68GC+hbHaA9RLYI3M6UmuxGbjvbySncpSZWBwgpx+MFiT/Eudes?=
 =?us-ascii?Q?4Q1XHcazBKcgkTr7O3prVfSq46srOKCb7jKN0nYL9y34qci/p8r4kbSfs8KF?=
 =?us-ascii?Q?mam0ElNXqS8CHYq+PoSj6Tver/oED9D0VpQ5MQZCbKS+Avba67jrVE8XpVQe?=
 =?us-ascii?Q?4+9xyOqYOL3lslcwVzs0zebL3d7Imu3/G455mmGwNdgcb/6bYb8iAWQ8AFDy?=
 =?us-ascii?Q?y39sLdy/O+A3eFS15JweB3Z5EfdHFlAPAU97pK8bO+Opw+zpjeEYurx25kHU?=
 =?us-ascii?Q?kJvKZqau0kgtc6D2w+BCfBfbSwB2i0esCTD61yfufI+7h59yeAPU4o77bzuA?=
 =?us-ascii?Q?wzSsAb7/QZ1MByLG5YA6JhKuSVWpEUM3MZSwFTXp36z01/NB2/tYpmW2AIpA?=
 =?us-ascii?Q?e9anVlOh6kHXnK/JPuNduvdj7UywP84gijgS0VNgQeewWyYGyXDzFnPxsxph?=
 =?us-ascii?Q?Gf+ZeOU/M/qjLr7tLzVd8ks=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR06MB7432.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f43707-e8ad-4d99-9b35-08db0295cdb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 07:44:22.7227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6BDN5ADMviFQWuVeKVOnl2WgI3672mG1vRwtcQslMJUWQwB0ZKzY3+nS7PaqpkHcRViJ2bB1iUgf/jbvIWKJiIDu67uZwIPad7hFDbuvC+mccALFVlCRKCZijm+TVThM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Abel Vesa <abel.vesa@linaro.org>
> Sent: Sunday, January 29, 2023 2:39 AM
> To: Stephen Boyd <sboyd@kernel.org>; LI Qingwu
> <Qing-wu.Li@leica-geosystems.com.cn>; Peng Fan <peng.fan@nxp.com>
> Cc: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>; abelvesa@kernel.org;
> mturquette@baylibre.com; shawnguo@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com; linux-imx@nxp.com;
> linux-clk@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; 18701859600@163.com;
> GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>;
> Marco Felsch <m.felsch@pengutronix.de>
> Subject: Re: [PATCH V5 1/1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
>=20
> [Some people who received this message don't often get email from
> abel.vesa@linaro.org. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> This email is not from Hexagon's Office 365 instance. Please be careful w=
hile
> clicking links, opening attachments, or replying to this email.
>=20
>=20
> On 23-01-18 11:00:36, Stephen Boyd wrote:
> > Quoting Abel Vesa (2023-01-16 06:28:33)
> > > On 23-01-11 11:10:30, LI Qingwu wrote:
> > > > Defined IMX8MP_CLK_M7_SRC and IMX8MP_CLK_M7_DIV in
> imx8mp-clock.h
> > > > but never assigned. It will cause the system to hang if using them.
> > > > Alias IMX8MP_CLK_M7_SRC and IMX8MP_CLK_M7_DIV to
> > > > IMX8MP_CLK_M7_CORE for backward compatibility.
> > > >
> > > > Fixes: 8c83a8ff4dd9 (clk: imx8mp: use imx8m_clk_hw_composite_core
> > > > to simplify code)
> > > > Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> > > > Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> > > > Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> > >
> > > Stephen, can you please pick this up yourself?
> > >
> >
> > Is it needed for clk-fixes? When did the system start hanging?
>=20
> Li, Peng, can you provide some details here?

Since IMX8MP_CLK_M7_SRC and IMX8MP_CLK_M7_DIV were not assigned,
if using any one of them in device tree, Linux system hanging after start M=
7 core.
