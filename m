Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B2E5EB7E6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiI0Cto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiI0CsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:48:21 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00086.outbound.protection.outlook.com [40.107.0.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0788672D;
        Mon, 26 Sep 2022 19:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnP5boW5o+bOoYOrT+CacMcYdPLu89ibkDuNUdP4GNQndegp4WgVizRKJaGfA4YlYRmmnC3XmP6H+E7Wf6t8vqr8zgS0Rn8lytLFXLrrE6HenNGeT24XW9KDPAzPsKqVvaajKrhN96NFrPey3CQ4sEaltAVDmCVNBNsBbSz1+Ua7UxrMFSLFVLRa/4yBgYQ6+Qohdc/XxZlzgyOFsyKlXvBGuVy7HjeH/bbK4MZZev7/UbT11odJ/M3ARVPrzUfbCwGZkpo6GtRihws1RO8VkFzNGLpYiGgd/RWrKlX8oHUiRsNhyqFBX/dEO+MzADpan5cn35gx0hwxtSB3ufMt+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyK+NCGyXsjgEIhk6QvI2vwmTTObaWP4Sd25klNejD8=;
 b=dFx2LqA87L4ELW447lBLgXjh84WLHATCg0w/f4AGZ6SB2Htm3MnGjJfCmc3jxlDFh67X80vitedxFeGsF511Tdhid550lnIjYJD+aV95UYJnVmrla7bXKpCOkfzRQZ/a505CiumsTD73HeQs9G3iayoU8oANwqccHMaBjAS//98aicCCym1V4TyieQAx+imeVdQYNISfgJ5SzZoFTmlZ+7fx1hlLug2/JUmhaGWRbOcZetSFsz9kZkptP/OaUMM9vdd0w7rt+Z/+E3cmHSuKzjRqv7dl58GLCO9v/HgafIe/myH9LFuYn5tAWmLwigtZosdo6dnIiKhtq8GFZSakkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyK+NCGyXsjgEIhk6QvI2vwmTTObaWP4Sd25klNejD8=;
 b=MsWw5tm+0PrQdW7JyNIyW2gVkrp/98ljOdgFw4N8iaQZuvz5aurDyuYW3MyMJJKB/Cci95bElyAKuoRnCPXcXETVjA/DGmnEuhKuvXii89nCojXK8z8hfL2hHk46wnim+t+q+GpiprqY11pFvoN2lQylKtEqAKwCClTxAozLvL0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7840.eurprd04.prod.outlook.com (2603:10a6:102:ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 02:48:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 02:48:02 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "bjorn.andersson@kernel.org" <bjorn.andersson@kernel.org>,
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
Subject: RE: [PATCH V5 3/6] remoteproc: imx_rproc: support attaching to
 i.MX8QXP M4
Thread-Topic: [PATCH V5 3/6] remoteproc: imx_rproc: support attaching to
 i.MX8QXP M4
Thread-Index: AQHYt1YYYWV783i6iEKFTZ1KuPZo+K3yjrqAgAA2iDA=
Date:   Tue, 27 Sep 2022 02:48:02 +0000
Message-ID: <DU0PR04MB9417EABB1B0A9B550E94236288559@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
 <20220824011023.1493050-4-peng.fan@oss.nxp.com>
 <20220926232127.GB2817947@p14s>
In-Reply-To: <20220926232127.GB2817947@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB7840:EE_
x-ms-office365-filtering-correlation-id: 241184f0-5df6-4d7a-346a-08daa032b238
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IOKLGkHZHAkS0+lNV+va2/NoIMihIWBfdiFA1IgIf83OmzvLCYUukQZCU6faTFfwxUpsyuqXTk/uzf+B77v5PYc/Um6J8Xr3J0oIL7q4lJ8mncCfRg5CiXYWb2TZ67wcImGgKKLbQem+9l749IIfRdygGw0fV4NawT/aNB6KMfMyyKU/JF4/34oseMBKB37WL1PjvLnY66Qv6mOjdgnreK41CBu9iXvTRg3C94iLpIAD8xHQnxUPhVKlv03lNFRFfUx6RCqK6HObmG/L+BqGyN+XfAYiaPp02EK0mBZOUX4Cx+3+zNXSF652eXmZMZG1X+hACzcul5mT8zz/hJLdZS6RkLFMAhEU1JVx0PvCIlBqpGAJ51EKS00z3RHGPrcVVBYK0HyZFuempxFGtVg/YP7iioLlki7HL6mWEISHJztW75KzlGMF47zm3F9pYg9GGekU59aEdqh+MKs31nwI2MQvhUMNSid7tBkuCLjr5ZUUzOYC+apMCl09Tl/U1erKBtGiHp7PV1+V3wBGG7d76t6Dn/NEHKAmFx5POhgjSLZD6M+Izy/t6OBpGw9HSbhZBbtIElPi6ovt9mjdCev9RPF+78Y4aWZ4I9aOt1tlF3+LUbJvKxoc/VjZK5tp/eErnKBbfTEepy0LZCzQxsrTSlbSlAukF+i3fs6/H9vJTDgGZgP74bVhRciIlg8LGWfruKj51iFuarYbFIGNuB7WXrHCKLMNMyA2YmimjRoLTa7aHfYfgbNc6B+qZpqQ2vTWRY9ekN+t+SlEX8IbkA61X69oNEydTtI/kPBdVbSkq60=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199015)(110136005)(54906003)(316002)(38070700005)(55016003)(66946007)(7416002)(52536014)(8936002)(5660300002)(33656002)(44832011)(86362001)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(76116006)(2906002)(41300700001)(9686003)(26005)(186003)(71200400001)(478600001)(6506007)(7696005)(966005)(122000001)(38100700002)(83380400001)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DUNQQh3pg1jPtZ3kWF1bf7lAbS6atB7aWtL0cLwbVQTdQa37Ab5BEt/X6+uo?=
 =?us-ascii?Q?zvDjBOKv6Z+wa3rtQcRwotawkda2WAISTDHjlf/rAfqd4qQUcOeGFLJ98Oql?=
 =?us-ascii?Q?3Vzk21xJ7R/AfS3O9QA0yX/1nNJLp1ucbqeP1GMVzBIL3jp593oE0ABp29Pw?=
 =?us-ascii?Q?M0J9slbAUT0TYja8QcQPRdD8tqojugeiv4qyGp7JB/Ro9ST7+fEmW6tn/jik?=
 =?us-ascii?Q?gvGajonlxd9akoKlrYrjscQDdq6oaugzgUzfaDbm8L69qCVfrRhm0b688DQw?=
 =?us-ascii?Q?VteelBDaQFqNtH0czg5/UAlkDSuwjBCqGLCf3DpICY6wAz0Y2od3gnVlaW3K?=
 =?us-ascii?Q?8McvkMXTVFjqGkPA2YN5Zo0sFshLeksFUjswfGyz+OGIjXg9pQSXWSD7HY6d?=
 =?us-ascii?Q?QU8SK7w7L3wOTsBV0PXZR18xr8SxewsnSA2NwJw8mF6rivEhHgc1YdTQh3A0?=
 =?us-ascii?Q?DfGY6w1Ft8nIYPou8F0aQF9gee8gN2RAGZB2BGiseIYbHfPL96GAmoWgTSXz?=
 =?us-ascii?Q?wCBeS4dV21TY0kffgg0NzWziZPTdH6dFOOt7MTYIgu2MhvuLpkIrwcjiOJH0?=
 =?us-ascii?Q?Nv8Sp6/4EcJM2DIM/Wv4ocO5C8GyzBdkHNeX41ZlGBM1zG4C1f9GcavLEGn7?=
 =?us-ascii?Q?51kP2x+QFE4j+OHozy59Ju1ilUWEOSMVcZHQcf7Zse0xlKOHps09yrd4ujet?=
 =?us-ascii?Q?cNXqW5ujeVkEgB8DiGO0ybTe7aolzQtXG4Z8jrW2ovUoTZLPtVKDOa4uAUDM?=
 =?us-ascii?Q?tF8KGLxOf4Bu4+aIO3zZqj1GV57mAC8HzaSiPB/4pES1YMJO0N+UDV73eV9v?=
 =?us-ascii?Q?yWfVZnndTJ4hOcUlWfhNzMPbteaaFCwnlCsv6X8pgr+9ettFu9ZNL1OZSRP7?=
 =?us-ascii?Q?IX/YUHW8eWD84LC9fLR/no/jblLZ9IhEJK/4V5vxKaywDQBHSWwj6RVPLbSZ?=
 =?us-ascii?Q?fl5t5yJgg4HTALWuR8ImK+eSOBXgA77HALhz2Wik1jATb/NhzwukDsmz89ai?=
 =?us-ascii?Q?yQBH8Ls2z67emLjptvfWEefmk+5+wDFCrpHW3LwSYFy1DIZnsEcGsTtkzFO7?=
 =?us-ascii?Q?3oMmOKFiORE4K2n9GQEfuZpr76mHQthNPu42x00PtUKtoRQn6zsz4V29H797?=
 =?us-ascii?Q?Ek2ByZFCe6aTf80BwQgalAGLF1SD1zx1e3Dt3H7iyT+nUDS2WQYkdDMgGaDk?=
 =?us-ascii?Q?UvtI4LSkiSCR46Dc2QjtfDzHNEeIJNHqk9WAXEwqwc7+8Ak93taY4tPrWhrm?=
 =?us-ascii?Q?ZuavFBojshJkVD6e/WdgOxf6hBNC2oSD1zv+Z0RDUYqmyCln9TK9OZWNgxF6?=
 =?us-ascii?Q?oRfMpSp539b8NmXSO7ylEeuWUaO9fMjs1yidwNhIe4ioxI6ub203AHvYiEa9?=
 =?us-ascii?Q?CcevD4MndyFvxZgAw3HmEZtJVepn4vZj2B31Gi+2kG/8UTY6OzViSc6Y/F+t?=
 =?us-ascii?Q?QkhXVaVx0CtMxmLBafHb+lD9FJ/y9GIh6l4w/+GWR/cTiD9VhX1/VYD3u7MV?=
 =?us-ascii?Q?hUutI2/4jD9CXgguund6ETzvZBW9LwHSSiuOrDQQGxVvh/wo9Pq2QguvBwKG?=
 =?us-ascii?Q?tGwsbSpsNgYhTdrHfLI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241184f0-5df6-4d7a-346a-08daa032b238
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 02:48:02.4870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L8+mnwLHJIzR4hIMM/z2IZ7Dh8AgE0s5zpo9z3MHEVO3fQEqmxPiHXgHbwCzHrBldbpSeAWIQeJkHDf1Axkphg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7840
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

Thanks for reviewing this patchset.
> Subject: Re: [PATCH V5 3/6] remoteproc: imx_rproc: support attaching to
> i.MX8QXP M4
>=20
> On Wed, Aug 24, 2022 at 09:10:20AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > When M4 is kicked by SCFW, M4 runs in its own hardware partition,
> > Linux could only do IPC with M4, it could not start, stop, update image=
.
> >
> > We disable recovery reboot when M4 is managed by SCFW, because
> > remoteproc core still not support M4 auto-recovery without loading
> > image.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/imx_rproc.c | 108
> > ++++++++++++++++++++++++++++++++-
> >  1 file changed, 107 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index 7cc4fd207e2d..bcba74e90020
> > 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/arm-smccc.h>
> >  #include <linux/clk.h>
> >  #include <linux/err.h>
> > +#include <linux/firmware/imx/sci.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/kernel.h>
> >  #include <linux/mailbox_client.h>
> > @@ -59,6 +60,8 @@
> >  #define IMX_SIP_RPROC_STARTED		0x01
> >  #define IMX_SIP_RPROC_STOP		0x02
> >
> > +#define IMX_SC_IRQ_GROUP_REBOOTED	5
> > +
> >  /**
> >   * struct imx_rproc_mem - slim internal memory structure
> >   * @cpu_addr: MPU virtual address of the memory region @@ -89,6
> > +92,10 @@ struct imx_rproc {
> >  	struct work_struct		rproc_work;
> >  	struct workqueue_struct		*workqueue;
> >  	void __iomem			*rsc_table;
> > +	struct imx_sc_ipc		*ipc_handle;
> > +	struct notifier_block		rproc_nb;
> > +	u32				rproc_pt;	/* partition id */
> > +	u32				rsrc_id;	/* resource id */
> >  };
> >
> >  static const struct imx_rproc_att imx_rproc_att_imx93[] =3D { @@ -117,=
6
> > +124,18 @@ static const struct imx_rproc_att imx_rproc_att_imx93[] =3D =
{
> >  	{ 0xD0000000, 0xa0000000, 0x10000000, 0 },  };
> >
> > +static const struct imx_rproc_att imx_rproc_att_imx8qxp[] =3D {
> > +	{ 0x08000000, 0x08000000, 0x10000000, 0 },
> > +	/* TCML/U */
> > +	{ 0x1FFE0000, 0x34FE0000, 0x00040000, ATT_OWN | ATT_IOMEM },
> > +	/* OCRAM(Low 96KB) */
> > +	{ 0x21000000, 0x00100000, 0x00018000, 0 },
> > +	/* OCRAM */
> > +	{ 0x21100000, 0x00100000, 0x00040000, 0 },
> > +	/* DDR (Data) */
> > +	{ 0x80000000, 0x80000000, 0x60000000, 0 }, };
> > +
> >  static const struct imx_rproc_att imx_rproc_att_imx8mn[] =3D {
> >  	/* dev addr , sys addr  , size	    , flags */
> >  	/* ITCM   */
> > @@ -255,6 +274,12 @@ static const struct imx_rproc_dcfg
> imx_rproc_cfg_imx8mq =3D {
> >  	.method		=3D IMX_RPROC_MMIO,
> >  };
> >
> > +static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp =3D {
> > +	.att		=3D imx_rproc_att_imx8qxp,
> > +	.att_size	=3D ARRAY_SIZE(imx_rproc_att_imx8qxp),
> > +	.method		=3D IMX_RPROC_SCU_API,
> > +};
> > +
> >  static const struct imx_rproc_dcfg imx_rproc_cfg_imx8ulp =3D {
> >  	.att		=3D imx_rproc_att_imx8ulp,
> >  	.att_size	=3D ARRAY_SIZE(imx_rproc_att_imx8ulp),
> > @@ -680,6 +705,37 @@ static void imx_rproc_free_mbox(struct rproc
> *rproc)
> >  	mbox_free_channel(priv->rx_ch);
> >  }
> >
> > +static void imx_rproc_put_scu(struct rproc *rproc) {
> > +	struct imx_rproc *priv =3D rproc->priv;
> > +	const struct imx_rproc_dcfg *dcfg =3D priv->dcfg;
> > +
> > +	if (dcfg->method !=3D IMX_RPROC_SCU_API)
> > +		return;
> > +
> > +	if (!imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
> > +		return;
> > +
> > +	imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED,
> BIT(priv->rproc_pt), false);
> > +	imx_scu_irq_unregister_notifier(&priv->rproc_nb);
> > +}
> > +
> > +static int imx_rproc_partition_notify(struct notifier_block *nb,
> > +				      unsigned long event, void *group) {
> > +	struct imx_rproc *priv =3D container_of(nb, struct imx_rproc,
> > +rproc_nb);
> > +
> > +	/* Ignore other irqs */
> > +	if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group =3D=3D
> IMX_SC_IRQ_GROUP_REBOOTED)))
> > +		return 0;
> > +
> > +	rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
> > +
> > +	pr_info("Partition%d reset!\n", priv->rproc_pt);
> > +
> > +	return 0;
> > +}
> > +
> >  static int imx_rproc_detect_mode(struct imx_rproc *priv)  {
> >  	struct regmap_config config =3D { .name =3D "imx-rproc" }; @@ -689,6
> > +745,7 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
> >  	struct arm_smccc_res res;
> >  	int ret;
> >  	u32 val;
> > +	u8 pt;
> >
> >  	switch (dcfg->method) {
> >  	case IMX_RPROC_NONE:
> > @@ -699,6 +756,51 @@ static int imx_rproc_detect_mode(struct
> imx_rproc *priv)
> >  		if (res.a0)
> >  			priv->rproc->state =3D RPROC_DETACHED;
> >  		return 0;
> > +	case IMX_RPROC_SCU_API:
> > +		ret =3D imx_scu_get_handle(&priv->ipc_handle);
> > +		if (ret)
> > +			return ret;
> > +		ret =3D of_property_read_u32(dev->of_node, "fsl,resource-id",
> &priv->rsrc_id);
> > +		if (ret) {
> > +			dev_err(dev, "No fsl,resource-id property\n");
> > +			return ret;
> > +		}
> > +
> > +		/*
> > +		 * If Mcore resource is not owned by Acore partition, It is
> kicked by ROM,
> > +		 * and Linux could only do IPC with Mcore and nothing else.
> > +		 */
> > +		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv-
> >rsrc_id))
> > +			return 0;
>=20
> If imx_sc_rm_is_resource_owned() return '1' than the remote processor is
> under Linux's control and what follows below is not needed.  That is also
> coherent with the comment in [1].

Case 1: If M4 is owned by Linux, here directly return 0.
Case 2: If M4 is not owned by Linux, the following code after this line wil=
l set
state as RPROC_DETACHED.

Patch 3/6(this patch) is only to support case 2.
Patch 4/6 is to support case 1.

>=20
> That is in contrast with what is happening in imx_rproc_put_scu().  There=
, if
> the remote processor is _not_ owned by Linux than the condition returns
> without calling imx_scu_irq_group_enable() and
> imx_scu_irq_unregister_notifier().  That seems to be a bug.

No. The two functions only needed when M4 is in a separate hardware partiti=
on.

The scu irq is only needed when M4 is out of linux control and need some
notification such as M4 is reset by SCU(System Control Unit). That linux go=
t
notification that M4 is reset by SCU.

>=20
> There is also a problem in patch 4/6 associated to that.

If the upper explanation eliminate your concern, "a problem in patch 4/6" s=
hould
not be a problem.

When M4 is owned by Linux, Linux need handle the power domain. If M4 is not=
 owned
by Linux, SCU firmware will handle the power domain, and Linux has no permi=
ssion to
touch that.

Thanks
Peng

>=20
> Thanks,
> Mathieu
>=20
>=20
> [1].
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Felixi=
r
> .bootlin.com%2Flinux%2Fv6.0-
> rc7%2Fsource%2Fdrivers%2Ffirmware%2Fimx%2Frm.c%23L24&amp;data=3D0
> 5%7C01%7Cpeng.fan%40nxp.com%7Cbe679e9a409a48b834b908daa015d92
> c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637998312946913
> 710%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D
> JDRvoDGGgEiSmbhj3410V2DNxamZbDmMS0U2GvBnI74%3D&amp;reserved
> =3D0
>=20
> > +
> > +		priv->rproc->state =3D RPROC_DETACHED;
> > +		priv->rproc->recovery_disabled =3D true;
> > +
> > +		/* Get partition id and enable irq in SCFW */
> > +		ret =3D imx_sc_rm_get_resource_owner(priv->ipc_handle,
> priv->rsrc_id, &pt);
> > +		if (ret) {
> > +			dev_err(dev, "not able to get resource owner\n");
> > +			return ret;
> > +		}
> > +
> > +		priv->rproc_pt =3D pt;
> > +		priv->rproc_nb.notifier_call =3D imx_rproc_partition_notify;
> > +
> > +		ret =3D imx_scu_irq_register_notifier(&priv->rproc_nb);
> > +		if (ret) {
> > +			dev_warn(dev, "register scu notifier failed.\n");
> > +			return ret;
> > +		}
> > +
> > +		ret =3D
> imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED, BIT(priv-
> >rproc_pt),
> > +					       true);
> > +		if (ret) {
> > +			imx_scu_irq_unregister_notifier(&priv->rproc_nb);
> > +			dev_warn(dev, "Enable irq failed.\n");
> > +			return ret;
> > +		}
> > +
> > +		return 0;
> >  	default:
> >  		break;
> >  	}
> > @@ -803,7 +905,7 @@ static int imx_rproc_probe(struct platform_device
> > *pdev)
> >
> >  	ret =3D imx_rproc_clk_enable(priv);
> >  	if (ret)
> > -		goto err_put_mbox;
> > +		goto err_put_scu;
> >
> >  	INIT_WORK(&priv->rproc_work, imx_rproc_vq_work);
> >
> > @@ -820,6 +922,8 @@ static int imx_rproc_probe(struct platform_device
> > *pdev)
> >
> >  err_put_clk:
> >  	clk_disable_unprepare(priv->clk);
> > +err_put_scu:
> > +	imx_rproc_put_scu(rproc);
> >  err_put_mbox:
> >  	imx_rproc_free_mbox(rproc);
> >  err_put_wkq:
> > @@ -837,6 +941,7 @@ static int imx_rproc_remove(struct
> platform_device
> > *pdev)
> >
> >  	clk_disable_unprepare(priv->clk);
> >  	rproc_del(rproc);
> > +	imx_rproc_put_scu(rproc);
> >  	imx_rproc_free_mbox(rproc);
> >  	destroy_workqueue(priv->workqueue);
> >  	rproc_free(rproc);
> > @@ -852,6 +957,7 @@ static const struct of_device_id
> imx_rproc_of_match[] =3D {
> >  	{ .compatible =3D "fsl,imx8mm-cm4", .data =3D
> &imx_rproc_cfg_imx8mq },
> >  	{ .compatible =3D "fsl,imx8mn-cm7", .data =3D
> &imx_rproc_cfg_imx8mn },
> >  	{ .compatible =3D "fsl,imx8mp-cm7", .data =3D
> &imx_rproc_cfg_imx8mn },
> > +	{ .compatible =3D "fsl,imx8qxp-cm4", .data =3D
> &imx_rproc_cfg_imx8qxp },
> >  	{ .compatible =3D "fsl,imx8ulp-cm33", .data =3D
> &imx_rproc_cfg_imx8ulp },
> >  	{ .compatible =3D "fsl,imx93-cm33", .data =3D &imx_rproc_cfg_imx93 },
> >  	{},
> > --
> > 2.37.1
> >
