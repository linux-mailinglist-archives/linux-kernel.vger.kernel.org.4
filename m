Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CA26005A0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 05:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiJQDN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 23:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiJQDNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 23:13:22 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749394C2CD;
        Sun, 16 Oct 2022 20:13:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkEnGKyUymMscUBC5VaNR3FMM2q4gxf3aPq+A4GWV8yPjJIywmf1g4hqKYnUdxCdFqh/1AEQJYhM3kyxmuwDJiJKHDSg4V0EuAeekl5Fhgh8fuX6nFTXYwISOKZkX4UoupOy1k3ZvuYVdOwId7EGyTQRWTIufRwuRKb00O4wDnXNszpn4ymzYdoBqtibFN6gdVg7urKRuOmhTUvNJNY4bUmkML3fjBIzfrKUIB89R3OOUIESQ6M0HcH11WMPqQZ9bQOJSPppr52IphjWEc4znZs+zcSd8J0uoVp0XJFlm3QisPVM+mIlwneGYKf0hxnrehAdbTgfD+dzEM2la5V4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olo9duJ6DDgcrWTO8gWLkS9yn3CP4W91wIAR0asDanc=;
 b=V2UwiHjbC4APVFh/n+y7XFLHhrqf1vT1WSLg05KvIsw9YUJ8HURvvkvAY1dWmPqAtzas1dFYMYo47TxrYRDgejMquUMRKgUkV417OpqgToBYXgfRb3y5XfmH5gbOxvQKVNs5SZDwNW3whhsgMIVHxxhBr99PVN2ZIaU0x+1TbZpKoR04WlPPYQbAc9OGxcPPsxQrANZM32BG3kAdpr14wATOTbGFFJO/YswVIwNzyDAEsU+3ElRupK9hwOMFJXEwRf8luETPa2twTMvpW1TagFc2LVTi1hxFsghGR+qrmQdjDT+3UIgVqcx54i3hL7qXI+Dwm3xDu+2TjjdkKWs40A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olo9duJ6DDgcrWTO8gWLkS9yn3CP4W91wIAR0asDanc=;
 b=p9q2DyLlVMBGGkpq0/rYWU5X1X7X/c/pD3Iz/BduD/NuW4KNp/pC1rRIa9bvSWEy2mnVxVbtPEQxiMf2pFM46ZWDwNERgIPAKv+Ct1vIzdUM7AYzBMsKB1HmUzrGeYQxQHjT4FwWx3Kylnqy8X9OtkXFWoa9klQIRDfrrgYKBnQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8540.eurprd04.prod.outlook.com (2603:10a6:20b:437::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 03:13:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 03:13:16 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "andersson@kernel.org" <andersson@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V7 6/7] remoteproc: imx_rproc: request mbox channel later
Thread-Topic: [PATCH V7 6/7] remoteproc: imx_rproc: request mbox channel later
Thread-Index: AQHY33pjL4ioJSeYvkqlTZaiTg9KJa4OK4mAgAO85tA=
Date:   Mon, 17 Oct 2022 03:13:16 +0000
Message-ID: <DU0PR04MB94179580E85C888CDAA8EAA788299@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221014031037.1070424-1-peng.fan@oss.nxp.com>
 <20221014031037.1070424-7-peng.fan@oss.nxp.com>
 <20221014174903.GA4125124@p14s>
In-Reply-To: <20221014174903.GA4125124@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8540:EE_
x-ms-office365-filtering-correlation-id: a4584d34-400f-4f2f-3acc-08daafed88dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Futj3jXLTORLSRLpXQgblsScrcQepLKaIQ74JonmLf3pRKSThuf/MUthgiuQlSAuH2hO3r7BBFnQxmIDQGZ66G/4cRiipEoHk3isgfIwWJfw0kJmlU7SPGdUOXes8zE9FA19W+gn8UZifiUPXpBVZJGVNJTqUVd73dDGxdnOo3dZ5+FqsIpZKmYwNTHwk6dRcnA0DC++wgWzbxN77wveVzxuhoMAyCr/1JiQq0bfZOZMlGg+JovBIJWvTr3uQT1BOP6p+Iz9EaCQ3UYD4Ct0kUUjw5Cyq1/9KDDx+5lmWicdPcDBqwsOuAHzPPFBztB6c4gH0fcJwuDyaiB8t5DEzVTNKZsZ9VIYeJ24YusmM3LwKGc81sE9NxBcbveABOB2NL0XDP/KA96V5ewQeeoVgsfg7Tqdk5CJ+HmfLk/6Vi8vfr4jtE2UjeK6kYxmd4b+lVRDqvpU0mJ63fKihweb0TcoufTefR1Fx6kdUTwiIB5McQh6mKpAxYddmRL6RIf5j9+uFdtLHsM2v6PTQsGCx7tCB83XocYXt9xUyZCV7LHnwNwYlPZBZhynQwKFJxi8k+PYuVpkZmIxHd6VqXEWkP8IYeqr2yt0WS+JCO3qaFW7LDU1F1vYreksK9Huub67hMC/xuBdEvG2CWDgOv3azsaojV0R3mVML4VlXVhC/wQXjfIsXYxSjBDmj5DoISfaLK/mnmezkwJPhZsoHCBXVEiJ/zlotewmo00uCAQYyD8RPn2k+mFzIDoWmkae0NniRNj1jykGkcP+FffAIM+fMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199015)(33656002)(86362001)(2906002)(7416002)(5660300002)(44832011)(38100700002)(122000001)(186003)(83380400001)(38070700005)(26005)(6506007)(7696005)(316002)(478600001)(9686003)(71200400001)(54906003)(66556008)(66476007)(66446008)(76116006)(66946007)(55016003)(8936002)(41300700001)(52536014)(4326008)(64756008)(110136005)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8IJrOpX0LUQotVh41f5WKL6YM39fr2DAmWitgAIVCFpwsFAklkRiMZ2dC0aP?=
 =?us-ascii?Q?HXq7xSG9+GP1FuLqCM/8hvxulnuVg63/ZF/6v/Bdbh6VnU3YKVgXEOQGVA1q?=
 =?us-ascii?Q?aa2rqG1s83RRMH2OjsHYPuNNRXUjnpbaQ/2rQkzZ8bPyvcX3bog4WMxc3auU?=
 =?us-ascii?Q?X/9QT2/XYUBoVFBWctS3FyrmRVgN1zlWS7jvpVNydwnEc+HEgwNRLp6sD7Ys?=
 =?us-ascii?Q?s5qV6dze+ozSHcGRmE68Yc3dG4k2Y8VEcvAEK10CxnuTd0KjGq47cclyQiZ5?=
 =?us-ascii?Q?Ztk04wrXe/L9BnbHxTzG9yVlTyr+usc3n4bewjb5OezqbCTAEddV1mydkvDj?=
 =?us-ascii?Q?imRq8RaXCKUFg9kEjHmh1bFvpPKhbChp0oX5+c73uZkuMlYAQUkSmn0CP0hW?=
 =?us-ascii?Q?msbBY/VeRQc9Uc7K9kcM0IylyC1lC5efXzEhjrDeWWRMH0myKK8W+5lQjwHU?=
 =?us-ascii?Q?0gtymD/ZCX39ddI8Jk0YmXWExUBG0ImUdKRpq+47BkuTAZKwh9H+c45Pl6NN?=
 =?us-ascii?Q?mrmfb/aMCGFJ6LmFq+aJQuSsBTwwGAsY3+bmQTyn5lB9lLBnl30EF+cyIkat?=
 =?us-ascii?Q?fx04PtMklHFMl+TslC9zQNrptmL+JOCevPNdhwEbGNwDnnXSJmoXILgGwuVE?=
 =?us-ascii?Q?llnZSEPkj4E27AGmB6bkZO6zMaT8HCu+PqRg6XbpVT+xK18bBR15ni1asF48?=
 =?us-ascii?Q?KpdkgmZQGxe4UXrscOA44adDd8YHq93+SeQSrOehiXdsVJcK903HXii+OqfK?=
 =?us-ascii?Q?P/eLPyJdi3WlnJ/Kk5xBqL6F7sMadYLXYgaHSK2UImD5Hpt7gdavBePfker6?=
 =?us-ascii?Q?ZwEXHU9pLT5I5q5dKCUpM3vccGPgb6Jp2YLgbR4u5sReX4eVqXKzLKVV3XCs?=
 =?us-ascii?Q?NTj9jHlOMNML6Rakb2y6HGvqoU2vTtUW7gn5oi96WIhvkN7D/Z7D7bW+ONkU?=
 =?us-ascii?Q?upcPuj3we6OpxeVci2jYr9c0grMHeqOVbyqIE95mb4UBUrZ4YKx5mi8VyyUI?=
 =?us-ascii?Q?mvHFXSIrfCncNRzzt4zqXXs33KBLZ55EQGc+9YxcsszAN2huCq8lVB8HFZIx?=
 =?us-ascii?Q?HSuSqxccpvLpPAJLsNuI/vwAVsY35uFte1FoLdNgflXJRCx/szCy82EDO/0b?=
 =?us-ascii?Q?ACyAASuQqKvNjR9wG7Obr9d/r9JhVKEhNvOLIBWJNsQPAo7WsYAkwiqPrCnM?=
 =?us-ascii?Q?ewcDuk6iOduYhV9EaClhQ59c7cVnpMT1r/3k+vMhYp9hW074JlVT/h537rPb?=
 =?us-ascii?Q?GeqJ7vMmWc4lmQYLl6dbHi0Md17dgKlDKbMhedPl8cwXp9+Eh0nszMB+/bYN?=
 =?us-ascii?Q?Wrq01QNKcdimJHR1jRL/OJCBLMm/9lRgKR14X+5HOnhh9jZbZaE7OA9camjN?=
 =?us-ascii?Q?nLPQizDrFoAUrvznTdpqHFHAGBUJSNPOM9XWuyFEYEaBo68MZr+ns+nF6c+X?=
 =?us-ascii?Q?bEYfLvFuLzhjlEicAaUOUtzcXK8X1ftcAmTvjbQpPMX8/a8MgYrF6ATLw8xI?=
 =?us-ascii?Q?T2JuJbWlHh70+EqPq/wU39yFJlc1g6sKET7WMJTG8oJJvKnQLrCIHsdESK8M?=
 =?us-ascii?Q?fegX5lEuUVKqloRF3XU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4584d34-400f-4f2f-3acc-08daafed88dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 03:13:16.4500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+mnYDl9yO+Ij6wQv/kAo4aLxZKgPZp+x55WuNP+5WNdKcMw7K757ANULoMNrGsfcXxDxnh+bAd0CwdQuC5clw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8540
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

> Subject: Re: [PATCH V7 6/7] remoteproc: imx_rproc: request mbox channel
> later
>=20
> On Fri, Oct 14, 2022 at 11:10:36AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > It is possible that when remote processor crash, the communication
> > channel will be broken with garbage value in mailbox, such as when
> > Linux is issuing a message through mailbox, remote processor crashes,
> > we need free & rebuild the mailbox channels to make sure no garbage
> > value in mailbox channels.
> >
> > So move the request/free to start/stop for managing remote procesosr
> > in Linux, move to attach/detach for remote processor is out of control
> > of Linux.
> >
> > Previous, we just request mbox when attach for CM4 boot early before
> > Linux, but if mbox defer probe, remoteproc core will do resource
> > cleanup and corrupt resource table for later probe.
> >
> > So move request mbox ealier and still keep mbox request when attach
> > for self recovery case, but keep a check when request/free mbox.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/imx_rproc.c | 39
> > ++++++++++++++++++++++++++++++++--
> >  1 file changed, 37 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index 917e6db39572..1183de84a4c0
> > 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -84,6 +84,8 @@ struct imx_rproc_mem {
> >  #define ATT_CORE_MASK   0xffff
> >  #define ATT_CORE(I)     BIT((I))
> >
> > +static int imx_rproc_xtr_mbox_init(struct rproc *rproc); static void
> > +imx_rproc_free_mbox(struct rproc *rproc);
> >  static int imx_rproc_detach_pd(struct rproc *rproc);
> >
> >  struct imx_rproc {
> > @@ -357,6 +359,10 @@ static int imx_rproc_start(struct rproc *rproc)
> >  	struct arm_smccc_res res;
> >  	int ret;
> >
> > +	ret =3D imx_rproc_xtr_mbox_init(rproc);
> > +	if (ret)
> > +		return ret;
> > +
> >  	switch (dcfg->method) {
> >  	case IMX_RPROC_MMIO:
> >  		ret =3D regmap_update_bits(priv->regmap, dcfg->src_reg,
> > dcfg->src_mask, @@ -407,6 +413,8 @@ static int imx_rproc_stop(struct
> > rproc *rproc)
> >
> >  	if (ret)
> >  		dev_err(dev, "Failed to stop remote core\n");
> > +	else
> > +		imx_rproc_free_mbox(rproc);
> >
> >  	return ret;
> >  }
> > @@ -592,6 +600,22 @@ static void imx_rproc_kick(struct rproc *rproc,
> > int vqid)
> >
> >  static int imx_rproc_attach(struct rproc *rproc)  {
> > +	return imx_rproc_xtr_mbox_init(rproc); }
> > +
> > +static int imx_rproc_detach(struct rproc *rproc) {
> > +	struct imx_rproc *priv =3D rproc->priv;
> > +	const struct imx_rproc_dcfg *dcfg =3D priv->dcfg;
> > +
> > +	if (dcfg->method !=3D IMX_RPROC_SCU_API)
> > +		return -EOPNOTSUPP;
> > +
> > +	if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
> > +		return -EOPNOTSUPP;
> > +
> > +	imx_rproc_free_mbox(rproc);
> > +
> >  	return 0;
> >  }
> >
> > @@ -610,6 +634,7 @@ static struct resource_table
> > *imx_rproc_get_loaded_rsc_table(struct rproc *rproc  static const struc=
t
> rproc_ops imx_rproc_ops =3D {
> >  	.prepare	=3D imx_rproc_prepare,
> >  	.attach		=3D imx_rproc_attach,
> > +	.detach		=3D imx_rproc_detach,
> >  	.start		=3D imx_rproc_start,
> >  	.stop		=3D imx_rproc_stop,
> >  	.kick		=3D imx_rproc_kick,
> > @@ -720,6 +745,9 @@ static int imx_rproc_xtr_mbox_init(struct rproc
> *rproc)
> >  	struct device *dev =3D priv->dev;
> >  	struct mbox_client *cl;
> >
> > +	if (priv->tx_ch && priv->rx_ch)
> > +		return 0;
> > +
>=20
> You did exactly the same things as in V6.  I asked you why this is needed=
 and
> all you did is point me to the code in _probe(), which I can read on my o=
wn.
>=20

Sorry for not wrote down clear.

> Again - why is this needed when we know it will be done in start() and
> attach()?

start() and attach() not able to handle mbox defer probe. So I add
the mbox requesting in probe to handle mbox defer probe, and add
a check when requesting mbox channel in start/attach. During first
time attach/start remote core, the imx_rproc_xtr_mbox_init just
return, because channel requested in probe flow.=20

Since mbox requested in probe, why still add it in start() and attach()?
It is to support runtime stop and start(M4 is under control of Linux),
to support runtime detach(only for i.MX8QM/QXP attach recovery,
m4 out of control from linux) and attach.

Thanks,
Peng.
>=20
>=20
> >  	if (!of_get_property(dev->of_node, "mbox-names", NULL))
> >  		return 0;
> >
> > @@ -749,8 +777,15 @@ static void imx_rproc_free_mbox(struct rproc
> > *rproc)  {
> >  	struct imx_rproc *priv =3D rproc->priv;
> >
> > -	mbox_free_channel(priv->tx_ch);
> > -	mbox_free_channel(priv->rx_ch);
> > +	if (priv->tx_ch) {
> > +		mbox_free_channel(priv->tx_ch);
> > +		priv->tx_ch =3D NULL;
> > +	}
> > +
> > +	if (priv->rx_ch) {
> > +		mbox_free_channel(priv->rx_ch);
> > +		priv->rx_ch =3D NULL;
> > +	}
> >  }
> >
> >  static void imx_rproc_put_scu(struct rproc *rproc)
> > --
> > 2.37.1
> >
