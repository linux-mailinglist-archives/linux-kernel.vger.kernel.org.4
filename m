Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55726C286D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 04:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjCUDAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 23:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCUDAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 23:00:08 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2064.outbound.protection.outlook.com [40.107.105.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA50F2CC66;
        Mon, 20 Mar 2023 20:00:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJ2AeNQk6UWeQexcq9Ks3Jwi4GsoedEa1roUOzMaJiwWtAyMkX2wWTsd2ivhesxdxtZJiHyyr6jeOal3mMytud9ajmmrgTOm3Xb3rg+9+E+baPMny7CDwd0YaFy15qdPRx3qybjqHaR+cuucYb6iI9l453e0pp9tKiAWqQLD3UdFovrnp/fm2RzKEvBouS0VG785z08x6Rx0eknBz4pchkIUV81WSDfGYm+NwtUGskf4bD1LcxLYVaoFDI2b4dogBvN7EbtMY5nQw6ttaxwU1svLuPqF6uRraCQPsDfFZrj3K+6NwOCdmSXkM+r4ZmwTSA6CDeyaIZQZEU8pr3oILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJ6+a+bTcJ8ub/ni8okEcgamMFUx7i7cAun3nU2Qves=;
 b=mSt02XdSg9pDQptuBFH440Yxie42MabOo0NvvPGTHekBm+g1jLyPQF1uaEO17lyNy615rEBa2qlJriTkn4cXhslF3CYjgcNVNQJysK7Sn0VFASWPG502krkT9RnBYkFsUlONkJAjD9LmurcXhluO4wK9Sy9WzLcmcWjRCGhmd//zYf2fz/UWzSdnwSxrU4+qTS5hVbbPBjZPwYM/UjUUqlPjY+QZHhSoEQsRkt/RHsgi8LkjUhvlFIh0lFEFeK4folgAWrPxi98gnEoxVBZy1wT06qepODZNIbhsNwQBvadRcrWRUzpcxtKIizsPgwjKpiiWE02QCmf1HVpDU4XNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJ6+a+bTcJ8ub/ni8okEcgamMFUx7i7cAun3nU2Qves=;
 b=BYU7yOb6IFdhio0+N7Y7g0FcUgQDjY2Qt1QyY2BFxsflvn+z8l+A7ateaGiTv8iRoGnC1ryR4FfHp/ctO8R1jI8Vbaofp0PPIIIlrRVXQM3DhnIYIM1u+Qr6VMdHGYJoy4kgiu9Fa5+fszPvJj0BWseGpjPkbaKT9cXKsPmZpBs=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7564.eurprd04.prod.outlook.com (2603:10a6:10:1f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 03:00:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 03:00:02 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "andersson@kernel.org" <andersson@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "patrice.chotard@foss.st.com" <patrice.chotard@foss.st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "arnaud.pouliquen@st.com" <arnaud.pouliquen@st.com>,
        Hongxing Zhu <hongxing.zhu@nxp.com>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/5] remoteproc: imx_rproc: Call of_node_put() on
 iteration error
Thread-Topic: [PATCH 4/5] remoteproc: imx_rproc: Call of_node_put() on
 iteration error
Thread-Index: AQHZW3npeLvbR93VJ06DycG3baoUhK8Eixew
Date:   Tue, 21 Mar 2023 03:00:02 +0000
Message-ID: <DU0PR04MB941720004CECD8CFC6AE5B5A88819@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230320221826.2728078-1-mathieu.poirier@linaro.org>
 <20230320221826.2728078-5-mathieu.poirier@linaro.org>
In-Reply-To: <20230320221826.2728078-5-mathieu.poirier@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBBPR04MB7564:EE_
x-ms-office365-filtering-correlation-id: b77f1791-d251-4730-09cb-08db29b85d9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UtTQ/rNXzR/IhiVLQbud7VqsfLoN8ayWheJwV0pjaFf8ZUyMhvi34EOvIFGgKtLZL/fPoRaoHKmOoN8l5Ns4O8qoT++QAx04aoi76S0CLl7hGyouMsC1tSeu3lOAqo1+/9bhSgLnE0Kkq564swFPO9KbmVbL6taCeQ3O/GoaGpCln1YsarZxTxtTBP6pAJoPBlCCyrrw2MvE9xEDYs3wEa9Up+TpjoR9BBgnB8UMQVKzWwrEMQgI/s98gYwh4wwlCtm7B+TnUNLbNIbaGQMDCBOLBKRvEh4F62i5bQVpx4pQtMIvR3a2wDGSNDhb2zAk3MA97kHPq7RsegBxxc5RMlEZ1LUNsiF0J+Unc5lOWVncjeCJPbVxZa4VYaIFNgeIKcYelSkyTZMZCdQN/2MtgQ0XGPeeI9cdUBsbybP9EfojtlnRVhRxYS9ze1DyCaRImWXB98jTj3R9MXtVEQxj0GSNXG9nUuPKH8lShtjdqkjtnG6tU5bjUCcNiYItrxlKIhf6HaXnSbZA0e2GxOFK45iUfIUhN8doN4O+qh+QVHKHFsCy4o8qh46RzJHDyAJAuhUcbB5zIviX5njF980Tm7/jM8/vGuhlKXTCNm9/+64BmK3PEDNUFf1hO7vnqK1P/Ft2DabjDlxaEnjUj/zeaHg6eeuMr1w9l4Fo5at9kG8gozRsF4ikLWZuSGcw8XfcJPjztm3FpXToSVgcIOLmJEeQDuitlan4fPv4l2iwdGIC7p3BzZmD345HGP7T3YPG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199018)(8936002)(7416002)(5660300002)(44832011)(52536014)(41300700001)(55016003)(33656002)(86362001)(122000001)(38100700002)(38070700005)(2906002)(4326008)(186003)(83380400001)(478600001)(7696005)(71200400001)(6506007)(26005)(54906003)(110136005)(316002)(66946007)(8676002)(66476007)(66556008)(66446008)(76116006)(9686003)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bEWpMj0yJVFr0U6aZ9h1V51N4ySXA8D2Xt2cqJDiNyxla37rSbdtScDtf514?=
 =?us-ascii?Q?cxY2H0+fifa6PWGkv/SjGhBGx90+ERInd2c2tWhrtMU+a5OeHaGzcoLBij7o?=
 =?us-ascii?Q?UbMTRj5idrgFEYohYNhbMpMMNFvbrrf7xWHRpepPhTbfO5LoRLemAg759l1z?=
 =?us-ascii?Q?oypxu4IRiAqhDrlE479ixiczPBKMnQ01Hqr5Fvs25izAdLtofo1x6Q4NaAng?=
 =?us-ascii?Q?4UJhnnqvDn1plJSteoa4HJV9MNHwd/IHS+gSQoQf0q5SLZLLKGQdTmfj0vqd?=
 =?us-ascii?Q?uwiAX3/0FBvGzlDLYhY4UbsyUmK8H0zCwRh85+2u1tKVmmraQlVFVAKK4lvy?=
 =?us-ascii?Q?zIJVC+s6GnreAn7I7lwxVDdG8nojTq4PpTXjM+w9cHPky6U23yhuu2TVX1cY?=
 =?us-ascii?Q?JnRPXoJNlLw0vxwXfchjTNuKE5gUcFJVDI16J0o2p6Trf7mbUJOfLYRmsYXu?=
 =?us-ascii?Q?Zid9O4UxoIuly0fKPwjjR6tn1cqD1vLk8tp+1CMykQVtvyE0lu6478nIEbCB?=
 =?us-ascii?Q?8EewfCita4npkKtXNVzloQ3cVTLfxKANeMVDvpir5GbLJeqPpOy1xrDnsnuf?=
 =?us-ascii?Q?3xGtRetNOPbT03847wqAOrYt3WTwvevGMxmW7n4UZz+wIijK1KAow5AmRMQA?=
 =?us-ascii?Q?aUG6A86nUdI7yTK8WZmf375M69oSq5Y1BSkiBH6XPEnHY3TgfNhrSFr8YXER?=
 =?us-ascii?Q?+H4AmtGIt8yI6JDyiLYA3baF05i7cJf0cYcSvW8YwrK7Chb3oDLvz1uQoWdB?=
 =?us-ascii?Q?/cTZ/IONNByPUGUd21hm5IZ39vFzpdSBdMJO7+xFf8Irrqd8uEqbVwKIo7Pw?=
 =?us-ascii?Q?JPfTwCXIkrruBrU9aNzFcSSo/AVLZvkzd3Tsftxu3C4LCD+RUb+xZd7zeP/1?=
 =?us-ascii?Q?U1ORPQFCm8YYNMwDrJNCjRPvzD7502jktCdDTHElod6C5X5FScgKL6FTV6G6?=
 =?us-ascii?Q?SXUYGRKq4B5YCHweGNXWdVVs/YNtbv7iWfE76NwLAlPOlsFn5vKWtAOVBzel?=
 =?us-ascii?Q?7s6a/YXpgaATUi3OwZi+2jW35BOi8MS+/dKFvg9Zy5tO8rbeEUHgwr39Gxxm?=
 =?us-ascii?Q?JU+wrcDEgdoJf4iChDomOffACbTcZqfPSB/zKP0gXMAYGdZg8qfE9+n/DP+p?=
 =?us-ascii?Q?im63BeJX0+0GQJYfdfmFbz6tzJkfeOruwskJ/XX3znbCRkdjo6Dkv8puwFxX?=
 =?us-ascii?Q?0bgR1mfESAZQ4Yp3/dfyiRKkXu2WUcPsCj5AHgt8RetMp2HMxXcCGPKl1RNt?=
 =?us-ascii?Q?aCfiUZ3WxnTDpuPc1Z3EIffEWH5ioF0YEdXqKx4UYQhu76vMJJ5JXgyNNj/Q?=
 =?us-ascii?Q?izU2q1tmz4/m+0ADuYA6iinIIUj0ZhpbJ6ANgQwdUWJs/ugsBzx2YLYEPUZy?=
 =?us-ascii?Q?HDdkicwl0lWuZVwcCOW4HnN8ThscdlN4raweSvqlTYuEGMtDKSLq09MRusHa?=
 =?us-ascii?Q?NKkFbgzHaxXYk/+s2WfLZoym2/Vg+rePBns+YViwriqyAq5oz/jA1oGZwtzr?=
 =?us-ascii?Q?jibQ3JNla8zO/QPlfeyir/Q9g6/4No8Dy1HDW0XpyiOLeoQUixZyAM9Sn4mT?=
 =?us-ascii?Q?gowX4HM1OlGGzBodbKA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b77f1791-d251-4730-09cb-08db29b85d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 03:00:02.3998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01lI+N3xtxfxhLxZPERGXI01Hx2Zz5MSTz6YIc8Qa67sbGIvvGug5qM9+opy+rWz5gcKCl+PnWo1875KTnqyRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7564
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 4/5] remoteproc: imx_rproc: Call of_node_put() on
> iteration error
>=20
> Function of_phandle_iterator_next() calls of_node_put() on the last
> device_node it iterated over, but when the loop exits prematurely it has =
to
> be called explicitly.
>=20
> Fixes: b29b4249f8f0 ("remoteproc: imx_rproc: add i.MX specific parse fw
> hook")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

LGTM:
Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
>  drivers/remoteproc/imx_rproc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/remoteproc/imx_rproc.c
> b/drivers/remoteproc/imx_rproc.c index 9fc978e0393c..0ab840dc7e97
> 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -541,6 +541,7 @@ static int imx_rproc_prepare(struct rproc *rproc)
>=20
>  		rmem =3D of_reserved_mem_lookup(it.node);
>  		if (!rmem) {
> +			of_node_put(it.node);
>  			dev_err(priv->dev, "unable to acquire memory-
> region\n");
>  			return -EINVAL;
>  		}
> @@ -553,10 +554,12 @@ static int imx_rproc_prepare(struct rproc *rproc)
>  					   imx_rproc_mem_alloc,
> imx_rproc_mem_release,
>  					   it.node->name);
>=20
> -		if (mem)
> +		if (mem) {
>  			rproc_coredump_add_segment(rproc, da, rmem-
> >size);
> -		else
> +		} else {
> +			of_node_put(it.node);
>  			return -ENOMEM;
> +		}
>=20
>  		rproc_add_carveout(rproc, mem);
>  	}
> --
> 2.25.1

