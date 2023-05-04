Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429EE6F6829
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjEDJRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjEDJRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:17:31 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA4F468E;
        Thu,  4 May 2023 02:17:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxroru/tK3XGrseEKMCEKIYWgXkqbdhHHhpLO0BcU+f6W0vqeJsQtDC0OGGdxklvP+WrlzHRtBAwatI28mNItMS+cTMy/OuhdXn+iLPgN80po4VoBcKe1GPjMxMEIccNXzDC5wpNhrJ/v/+MbW/lp4ca875ITjfZbltFmiNfzc8rMmEWhtYqtt2ZINZ/DN0LBuuTaYjO7SLYJjhhK3+ZxQ995UbV2PKyD4KGVTJmYcBowS+l1ubLNf0dOndm54PrO31WPy4aZmmh5qaSC3kM45n8Nn2z3p9GEbJP4GJ1845rqh6pEOFDfE9e9TSfxhL/1uI2NIU1IT7v6cPRnePSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0eGde0McaA2hdKy7cV4ufiDqzeO5/nZperkzILYv1w=;
 b=C3Gv9azxDz7Z8x+Xt8BJEvNqYWUuxRAOGKoKnPttAw18dWUgCO8a3U3wRl+9IzsOHAwHPzlCzT5itVWYtCpTOEwSmFoKFgKWiO2a0vSxWNUSeGz58ESYM6DxAnOX3tgz/rjS1ZFl6blN5Q1Wi89Pfe0cjMvwL1ujjF5ctYXSs4r8KJa37XLQKBpCCDe/7z0uCyGb5DHifkln9Y79p1cCFQiMhjgOysGCyqXuljNQbxxsrWz3JWDbbMEkkHM7hKkDmkEXcpLFTGiMJ6UAoBxGAzqGLrx5ttpkQZeesiJ03tAwDsdYsWby4Qqequ6hn0pd5jxi9+ga27os5hZMkjoANQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0eGde0McaA2hdKy7cV4ufiDqzeO5/nZperkzILYv1w=;
 b=kQXtV9BrdQ+sqfCb8xCRa6rdOtUjtzewGK6giLXqhOmsXlKvaKKtVlP2fjPh2S59d2bIEj2kKVXMDHlWArtKMuYLbnagIIlMgpbXp6dcFQxxSBe3eMqV7udbKrZH58ZSfdP1k7QM8BN8NbKj8qkNrCGavPqVzXLm1F7wd5E1eh8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9319.eurprd04.prod.outlook.com (2603:10a6:102:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 09:17:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6340.031; Thu, 4 May 2023
 09:17:08 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Greg KH <greg@kroah.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: imx93: introduce clk_bypassed module parameter
Thread-Topic: [PATCH] clk: imx: imx93: introduce clk_bypassed module parameter
Thread-Index: AQHZfmVsUoWhON65f0ewGxlg24Oc/K9J088AgAAAwyA=
Date:   Thu, 4 May 2023 09:17:08 +0000
Message-ID: <DU0PR04MB9417F9CBB5C9EE1FC85B10A2886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230504085506.504474-1-peng.fan@oss.nxp.com>
 <2023050410-rejoin-vocation-8560@gregkh>
In-Reply-To: <2023050410-rejoin-vocation-8560@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB9319:EE_
x-ms-office365-filtering-correlation-id: 35d531c6-775b-4762-76c1-08db4c805628
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h1SOD6d8CAMVJR2zl2l743GIflqbTA2jHkVtuxYZvuKWazkowgDITV5Cm3JWMF7MKQmOjeHOtKn5B84Eywdv6CkwJLoZconNnvIlY4qclcvXnxYRsOULr+SI1wKHdymCG2wo0efaYRT57I2ScuAODxVYmBze27Qq7wrA3KdNXjDqpJxkMI1YAXKc0/hD34xo3idUa4DuD2TqtYgriZoW7A2x6Xdjq1awOPqNwAgbu1r2wvbDNF7rhRGE5cBmB6PPT4V4Cke2JLiPdiTIhaZ3iHTw44tf2n/vdV6wv6SI672gBj8YbapQOX6lSJs/zZVMZaZGTaFdfGsuwLWP3XcdPoVxC3/Cx7dbtn3SgYZaajeqDgK2+1e4OcqUepSD/C+CEXjLbu9l7cRPyz0ysqnfdq8HdNuDhKFpa6+lrGkK6OfbUJW652lnCCE6gMqy+QKbDyHSPk6TsqVPS0dizfTjeZRpeoQxpJwPOVo8JcXZF3jkTbwF5ksr7GfUasFgRN72SB4LUKHh2ZarDaVQQJJWQXnadDITDFBBC5rFyYEuf/LeE5gTu1wl4eGZLbgjS6p+upPKETrphp7p2g77D2HEzUyx+WpAcjgJNpcw/CaHahDTOjlnM8hnPPa6IKin5wAR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199021)(110136005)(54906003)(26005)(6506007)(9686003)(38100700002)(83380400001)(2906002)(44832011)(186003)(7416002)(52536014)(122000001)(66946007)(76116006)(66476007)(478600001)(5660300002)(64756008)(66446008)(66556008)(55016003)(8936002)(8676002)(33656002)(41300700001)(71200400001)(316002)(86362001)(38070700005)(7696005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N40CXMkAqiDNivK5NIF17I+2aPh2tXWiNJTHBKbiyR0oJe4HQ8d/yN+0okT6?=
 =?us-ascii?Q?9g2i/otRbM2KYuGBjypNyL9U/ISsUEE1ACajN8gRWV7TjQY1dy0Hztbk/3C0?=
 =?us-ascii?Q?xBFjBnzjnE3h9gIqzN1Ii+C0GxD1Tk1MFHH68O9Dt15qrIO4e8+vh4IZYXJL?=
 =?us-ascii?Q?CiUGKUiPJ7cEowTcxMG9VtESVwJoHT79OOXOYsAoy1R8iVm+0DxdDjd9m/Zf?=
 =?us-ascii?Q?09xvsf4i8fLAeWGScyuE5frvmJAKIivVC5IS84fer5Z2Vrt5ctej3CyxL4K4?=
 =?us-ascii?Q?Q2fcSVw82xcozknuWSppewdj7Lm2fSI5aTBgZKWz1rOmHKKqvOZ1OYdX7GHD?=
 =?us-ascii?Q?g1ptVqiubvAIXUI2iGhNsHaC+TnN8n0C3EJJKiFIb6ZY9Y44Ou6gwXwLlwPj?=
 =?us-ascii?Q?kpVPD2+kt8m7PtegmySD9HKPeM2Tr2GTysYEz9XgcIDho+1savJkbu9wYJpq?=
 =?us-ascii?Q?o+Pg85QKd71gE7/xh563bAmGNLdOYDhLYokj0NsgLrunpw32PsjbNKshzrcs?=
 =?us-ascii?Q?0lWuz5srhh9T/JuYOpeoe/bA2mI0PeQg3UaKfMM6eCbsP8GB0fvpvaKgEvoA?=
 =?us-ascii?Q?zt6if6WTxMYs49Flc4zM7z0IhqCmlNRdB9LQk/X6GgNg4b7cMeK3qWb43Tyh?=
 =?us-ascii?Q?zrkGlYLbWkYtpMKRXuNoehejkCFmGd//ErGhHVoBNtkc92QJybUWW4M4nwok?=
 =?us-ascii?Q?RGRkPs+if5XRHVocr/mLmTipkp5HT1mB5S7lzyqd8MGcj8v0Y/ajSIt+OaZD?=
 =?us-ascii?Q?nrV0JDU5Z8/iurZSlv7zLJZjPIzHxLlm+0bJyidG13d5dkM7Xl5TpXdCcrmV?=
 =?us-ascii?Q?nbwDpilt7bZc2PhZ2atmdVHtr0OHaGxTTBUA0mr4gHuV/JKkBm3TYw8gpUwp?=
 =?us-ascii?Q?DMxzwmluvsY67GzniWxRt2vbGdAFUSJXWHGpdDxTwZQx2eW71QLbD/SCKDVC?=
 =?us-ascii?Q?M763oPrvs7wC6HBRkCspkarw80X4n6+o32rL3kOlYOzHyxMmBgN/2hrN/mKr?=
 =?us-ascii?Q?/MYBi06SzGVQdbZvEck8AAeikMu4HaiO3R7BP6l4PG+JF4xDMnEZY5ptcEK3?=
 =?us-ascii?Q?iaAM/utNKxE57VQ5x3fz4F0EGQR0L4fBWSJ6MxPo6/dJQ4sb9oigYsoXXgIO?=
 =?us-ascii?Q?i/ZjTFtokOmmKytbR9VMg6ufH1q1lUysWOTsmeO1+akecfnK5SjZlNNsmsK3?=
 =?us-ascii?Q?7kQAHdXeOcLVwt+Vq44iWwJHRDdWjFeBfO3LHDiF27qznurUafST+rtWervF?=
 =?us-ascii?Q?bklXEyYKhH9MK8uuxBHT9WtOem+qEmZF9ONTmPamuNroeeCbcXTuHKOkFXoq?=
 =?us-ascii?Q?dewl6K0PQED6yncenTyPXFbE9zEAx15L7KSf81aAdFuodNzX8SbtJKKaMDlK?=
 =?us-ascii?Q?aOWaoP6kjZnqRpfMI+DgfZNB3SAFf/mQ4c0GcmSp23v7VP3LTFQEhJTmQ+zG?=
 =?us-ascii?Q?eywjvhKKxIH0RD8fr2/GkEae4UeLJ2C88Exxb/XXygPvDdNXgu7SY0vLZANv?=
 =?us-ascii?Q?jJaJbEDG2Q3zRstTxOLju5ip98dQcAp8qPvL+ZjC28QB8R1LhWiUgDhr/b9u?=
 =?us-ascii?Q?t9jGXR9Q4i3Na2GwgR8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d531c6-775b-4762-76c1-08db4c805628
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 09:17:08.7699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wsQzB4ootbrzNllzlus4WlhcJM8pRp5bp+NcY9t8MQfIFl7pxfsec3nlIEe0Ia/DLDSLNwG6hUn11F1Kc0ghrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9319
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ DT maintainers.

> Subject: Re: [PATCH] clk: imx: imx93: introduce clk_bypassed module
> parameter
>=20
> On Thu, May 04, 2023 at 04:55:06PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > With the clk names specified in clk_bypassed module parameter, give
> > user an option to bypass the clk from managing them by Linux kernel.
>=20
> As I said on another email, no, please do not add new module parameters
> for drivers, this is not the 1990s

ok, but this is for boot, so only DT could be considered.

But DT is to describe hardware, here I just wanna give user
an option to bypass some clocks. Is it ok to add a DT property
saying "fsl,imx93-bypass-clks =3D <IMX93_CLK_X>, <IMX93_CLK_Y>" ?

Thanks,
Peng.

>=20
> Also, another comment below:
>=20
> > @@ -310,6 +357,8 @@ static int imx93_clocks_probe(struct
> > platform_device *pdev)
> >
> >  	for (i =3D 0; i < ARRAY_SIZE(root_array); i++) {
> >  		root =3D &root_array[i];
> > +		if (unlikely(imx_clk_bypass_check(root->name)))
> > +			continue;
>=20
> Only ever use likely/unlikely if you can measure the difference.  Here on=
 a
> probe function, you can not, this is not needed at all, the compiler and =
CPU
> will do a better job over time than you can guess at this.
>=20
> But as this change isn't needed, this shouldn't be an issue either.
>=20
> thanks,
>=20
> greg k-h
