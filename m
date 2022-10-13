Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B93E5FD9E5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiJMNGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiJMNGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:06:12 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430C6C90C9;
        Thu, 13 Oct 2022 06:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcoH7+hRwFwdi9AaIhsWN2Q3of0C4zWyJaxiHU9h8yeFMGgHHugiEgKyS+59ezTlXvkGPJiOON3EqoEtqyYV5teUahtcZ1XAaHWR36eSGCHe7XfKJ1oEpNKB0Lp5Dq6E65vCGvyghJFDOU6+EREyQsD3ItcqMjQDcjsuVd6v8ipqYlEDPGwcShKbF2pJXbNEPL7VYo0tczp9ZCIx53Ruf3DaCpsGVH3u3EtUtuxwU5g3/dUOf/ZM7P5Yos146qCi2DR2rxsajK2SXLu+e2DL8TAN6FvUpuU0YBg1wLexBSXDxMP+7jBzjjV2Ym12Ty9yjk3Q9eq6rzNjpUiRvaTPOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+tzyCRIpo2ghlKtEt2P1PniFu45ZhMce74ZwYgH3MQ=;
 b=QxsyBLN+srAnUxaGs5N9iNSCzAi376TZxVH8zwrXbS+U92fC22B3f0lknZTlUjK9Zqn8haJXcWhiiKpfWMii4DK8UOACJsnuRHOceK23tKorXv+IrLebbqOd9pZoV6X2B3D7bxSh/X5AbWRDYWFeXYuFO9R4PBCXCHGyw8ndGJ3u31W6yEGxCbi9K1KGMIqhZHCs1N1bE9yug2dPQoQJMtyNwOoat2cPTNpaYVHlrwdFAgtQ/CTzW4J41axDZ7qZWEFUe+/kFQUwIGnEAKIK+IKIKQ5kNharDG4Tbupr8CJf6DEEj6Du28Y8FJXSUc6Dz6bvbaLLKFmqjeAS0q33ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+tzyCRIpo2ghlKtEt2P1PniFu45ZhMce74ZwYgH3MQ=;
 b=juHaeExMeLqiMSyx80fHbZD0d/4RRJAsYBaJnGc7SGKe+9/rY01XAxnL7J/rBcDMdyO/X13pxVSQ/IkXsl33NcLZTz7A6xw8cAW+kdmlA+YpgA31Suj2EzqrOzz4JZbAaKXE6kQ6UFUfWarjzMrYz/N53lMeDz+rMkXwPWBxyRE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8765.eurprd04.prod.outlook.com (2603:10a6:102:20c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 13:06:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Thu, 13 Oct 2022
 13:06:08 +0000
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
Subject: RE: [PATCH V6 6/7] remoteproc: imx_rproc: request mbox channel later
Thread-Topic: [PATCH V6 6/7] remoteproc: imx_rproc: request mbox channel later
Thread-Index: AQHY08rzgZTJs7ARWkyyLey1gVYdSK4La+AAgADzGFA=
Date:   Thu, 13 Oct 2022 13:06:08 +0000
Message-ID: <DU0PR04MB941713DAE0A61BD58312AEF888259@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220929061704.1571746-1-peng.fan@oss.nxp.com>
 <20220929061704.1571746-7-peng.fan@oss.nxp.com>
 <20221012222654.GD1196937@p14s>
In-Reply-To: <20221012222654.GD1196937@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8765:EE_
x-ms-office365-filtering-correlation-id: 091c7ca5-709d-485f-2f27-08daad1bb1bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kt7KAHROkD9x0Z0XbYvJR5O1k6F/qKrYwkerQxO1RUntmiL7Fw2revtWwoYviyp1Gdv1SCY3/rswW1EBRl6CMf+l44+Dup9XrFNcrzPVOOIgjAlWdCQE0QAo2vH6lIEabZa0fyPLmTHKUp+xicy68ObUXJOWxJjE0pJM9/TIm9UMIqJKxE3mODNg6VOg6js6h3rk/UP56nWFCIZ0CBlXf522ZNMtsTMi4+m35zCUJIuxNhSNw4S5gZKvgA9eC7VSsNr0mblPLn7a9SrEIs+prdtrZhB8wscl9V+YzJrJvpy5kGP7AC6IyOCOHZ1WeLxp/YBBkGuPJiFACeBzpehsatnPS7HNSFyDy8W7Jk69odklRTOrzPqxPhu6ttYAaPzEwkEHxOZddtAvIYK5ZCnVCNLzkh2SAMjLFoe5edRvNPgTXr48HLbmJgGN04iRcWNxToHOoPIhOv8qs31BSY+VofG/SXZKyhW7wrdPnn0WPYMcFTMg9finpT/rJ5T9oi+fo/EFBNHB4k1rdNensz+WkjCPreF9Xsy2OYSWJFBbJ/wmX56bKUKoNEczyTPPuUcnMfn4M4Wis1QvowTLu3V7yz+7U7uBV/Phz7f9dHhmP873YqAHDblQs9EZMxD/gwYSBADy2nEau6M+6o/TuN8kZLXDP7tLR7ZMGD4AuJekAGGALb6EA3M4ZP9jWNxq+ZQ88JIliDMjvgtK6tJwcrhNLhAJCjaFTHi4RmrqFUBU7V42RgL4/SWW0cu6VmbMpzt1M9HrzLKIywa2o7LjBuPtkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199015)(186003)(41300700001)(86362001)(110136005)(26005)(5660300002)(44832011)(54906003)(316002)(33656002)(7416002)(8676002)(66946007)(71200400001)(64756008)(4326008)(76116006)(66476007)(478600001)(66446008)(122000001)(38100700002)(38070700005)(9686003)(83380400001)(66556008)(55016003)(6506007)(7696005)(8936002)(52536014)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BIljQcvQ9KxZ2y8tJc4LYLyuK2hWehXY1jaKt7al7qUKQ/H2g7dNoghXQolG?=
 =?us-ascii?Q?EhCZjQ62pZ5IX65IzszuJNoKQFcE1CbjKU77v9j68rfZRhM1k8U7gG+4CAFt?=
 =?us-ascii?Q?UEwaYLYGt899+Zy+ndAS5zpb8VfgS2KP4ul5geg+0dTqG3NAdudO9ZiPAUg3?=
 =?us-ascii?Q?KvFGiheKlmcyrdPTzug4PQSdMBKvWfLGOhFvia6Aa+Yhv98CiAO4OlEqY/Um?=
 =?us-ascii?Q?YQhFpYL+k88W1kVJlnFMgYVZQJv5pCIUvDwOFu8MJ9/owvZqLG33gzWmRDL4?=
 =?us-ascii?Q?C6mBjP706PX7N72NQZS0kmnMRubS4NSV1H24Z4IESUT97pvTxd7KYIpt62/m?=
 =?us-ascii?Q?AwsdwHSbJ5Lrr+8l6qQBUhvLZyn6Ba0ZrMlvGKNHFHjGyp0KxlXgqDUoCshs?=
 =?us-ascii?Q?N6oYrQEFujQut+bwlfIY0Fusht909TbAV8rw9oZT2MfxWGv9+Z4i4ignw3YS?=
 =?us-ascii?Q?RrSBfR7lQIqCPH1/gne2UTLiB4p0Pm73i4/ta07GZJEb+7YcmnR360aJAgQ5?=
 =?us-ascii?Q?ok9Z7dO3rwXJp48/M+xtg48XE7XJtCJyxUBv1IYPEK+ReDKFdJ+YWJnfaGdv?=
 =?us-ascii?Q?u1Wf57wf3x0DRUD7WnWnWkAHGqbtb096KX4LwC0jecIgqp1ahTrRtSGY9kGR?=
 =?us-ascii?Q?DMZAE5PTUtRhuhWYa57vyJaSzGobkEVjtuAoryc0dwl9P3I7Dv4tDYpwqR2e?=
 =?us-ascii?Q?kOGm4DhO5Zk0/hSr6FOv3SFvSyKCzRB4jVu2I02MVYUy22//NRUMGlZycgN9?=
 =?us-ascii?Q?+r4hMlcQlcKG13Ly2/qk5QoRfD8WYFjAD/yX+1E06LADuZpPBHiTmtYkQ5zI?=
 =?us-ascii?Q?yrpmi/10nvy/zemhGrufWJLI83CvsupGGn++p9lv5QUNAViw82ofC0S2dr8U?=
 =?us-ascii?Q?U+J1exG8y53s+syB8SAe7L4lQyGJXY5Y4s6iBodTgndJqNyeMEOnGOu+App5?=
 =?us-ascii?Q?vQ60x39SOwixVxcNzDWe6mnvXepx+qdnX+tXOn9VpGaT5AKBAxAOVyKhE7nq?=
 =?us-ascii?Q?KD1O5uB+vYxk9cXXYAWSa4coWKub1kD6Gbp6Tv6n0HfguXMCYn3oJKmrpvcV?=
 =?us-ascii?Q?ri78/5hQPt/BXsaJ4t1RXsCcg6IsHVzYG4lCHdyCrwQUowf8IdHLz5Dvxlym?=
 =?us-ascii?Q?ePx3ulhvRO5lMnwasCAhQ/hHA69he1IowV5sCcIEuaWbrjbVz3DZDHT5jAkN?=
 =?us-ascii?Q?VpZXBuVUjnIAV+T9MNgHJ2VwZGwamnp7zDHlBA7BRIFzr1/asvgJpK7QjqME?=
 =?us-ascii?Q?Z0+H995bHHBq/Oz9X4CXnu7EsGGLOxEDGQdQflwpNJw+rokQF6QCVFE+Dury?=
 =?us-ascii?Q?bUn57zhn2BokgLhnoN4RcYw4pDD4u9jg3w1xmyfryeD3UDTqV+GRQQJ2Ase9?=
 =?us-ascii?Q?T11FVMP8/DTFSgrgWVWfKhX+taQ9s28SLZzPzblR1VkG8+9ubF3vl9KIW65Y?=
 =?us-ascii?Q?zNsLYiIGLv4OOg0p0CDgfZruFFGDceTbl34geJ7Qf8whlC+5BChTrLisN4ta?=
 =?us-ascii?Q?1uUfpEduU6J2Mi+j9pf1+8EWZPdIYazdeNRly8jhByhr74zQA8cotHDKMvb9?=
 =?us-ascii?Q?GKzJCZp6F7Ztmfq5WOUTy9BvtLtPAT0hOWkIP/yO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091c7ca5-709d-485f-2f27-08daad1bb1bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 13:06:08.3409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cMNbOym+liOkEFgWwGUi6Ck3Gp7SSfG7SKgDnBwqaKZV4Jx8Y5Onz0lpGWBCWa4A2hGyuiZw1ZslCnHjIxEV0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8765
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

> Subject: Re: [PATCH V6 6/7] remoteproc: imx_rproc: request mbox channel
> later
>=20
> On Thu, Sep 29, 2022 at 02:17:03PM +0800, Peng Fan (OSS) wrote:
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
> >  drivers/remoteproc/imx_rproc.c | 26 +++++++++++++++++++++++---
> >  1 file changed, 23 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index 8175c4c9aa22..bece44b46719
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
> > @@ -592,7 +600,7 @@ static void imx_rproc_kick(struct rproc *rproc,
> > int vqid)
> >
> >  static int imx_rproc_attach(struct rproc *rproc)  {
> > -	return 0;
> > +	return imx_rproc_xtr_mbox_init(rproc);
> >  }
> >
> >  static struct resource_table *imx_rproc_get_loaded_rsc_table(struct
> > rproc *rproc, size_t *table_sz) @@ -720,6 +728,9 @@ static int
> imx_rproc_xtr_mbox_init(struct rproc *rproc)
> >  	struct device *dev =3D priv->dev;
> >  	struct mbox_client *cl;
> >
> > +	if (priv->tx_ch && priv->rx_ch)
> > +		return 0;
> > +
>=20
> Why is this needed?  The remoteproc core's state machine driven by rproc-
> >state guarantees that imx_rproc_start(), imx_rproc_stop() and
> imx_rproc_attach are not called more than once.
>=20
> And why is imx_rproc_xtr_mbox_init() in imx_rproc_probe() not removed?

I not remove it, code piece in probe function:

        ret =3D imx_rproc_xtr_mbox_init(rproc);
        if (ret)
                goto err_put_wkq;

        ret =3D imx_rproc_addr_init(priv, pdev);
        if (ret) {
                dev_err(dev, "failed on imx_rproc_addr_init\n");
                goto err_put_mbox;
        }

        ret =3D imx_rproc_detect_mode(priv);
        if (ret)
                goto err_put_mbox;
>=20
> >  	if (!of_get_property(dev->of_node, "mbox-names", NULL))
> >  		return 0;
> >
> > @@ -749,8 +760,15 @@ static void imx_rproc_free_mbox(struct rproc
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
> >  static void imx_rproc_put_scu(struct rproc *rproc) @@ -779,6 +797,8
> > @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
> >  	if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group =3D=3D
> IMX_SC_IRQ_GROUP_REBOOTED)))
> >  		return 0;
> >
> > +	imx_rproc_free_mbox(priv->rproc);
>=20
> Why putting this here when it will be called again in imx_rproc_stop()?  =
If
> you need it for the attached scenario, create imx_rproc_detach() and add =
it
> there.

This is when got notification from CM4, Linux free the mbox channel.=20
The noficiation only work when CM4 runs in separated partition, linux not
able to start/stop CM4.
Patch 7/7 attach recovery will move this out. Here is just free mbox after =
CM4
crash, and linux not has permission to stop CM4.

Thanks,
Peng.
>=20
> > +
> >  	rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
> >
> >  	pr_info("Partition%d reset!\n", priv->rproc_pt);
> > --
> > 2.37.1
> >
