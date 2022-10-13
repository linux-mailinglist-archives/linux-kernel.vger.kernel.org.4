Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212C85FD9FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJMNLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJMNLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:11:04 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B028BDD88F;
        Thu, 13 Oct 2022 06:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrouMMhMJtCubbHbdCHn5lxWGvaD3wHM7dVmOGIXEa24tJtwfwzOuFLD/k1QN84bdUD9iYwrhRriJqvV7lWnJz4IUM35ieDzQny165KbLits9HkjiFtqrG/zdxp+3YzmaPJ2l4pxbvWRICqNiJXkrpbmvs6Y1gAFUNjOUDEezoT6uRSz1HdclZ7eJXAima5GTjshBBBNN8UbfbE4c+hlUBTKzO3KyhC1it70XLWyX2j9i5KobnXA8KunWjJ2EUoZlE2uPy2W8BoJECAQE03BazoFaLvP4K4W6+ou3VZc//9EnojDlGKRduaSNJ56x+zPURsLSu+gVdg8TaudGnuSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A04tgZRSpnd1mH5f2USd/p6h1t+1aPPOR8Tr31i5lAk=;
 b=OdLti3VPDYL6kayFaiPvkjedntHvXIqlnfvMM/r+SUMiHKBgWighvqDPMdNBxWT/8C6HMJfwa/7jjyXTJGk+aM3ovNUMJkqDuFheUeRnhb5pZMg4ElYaEGc8iRaspOm/qHsWBmmWC0OMgwQyM6LIwolXdRx1IR9sUefe2R8I4+LtoDITx09qwxRlNn6Vv6DFzkDKPpIilU3A7g1cYGal7OjnD1Uv3+V6AyUXM2ZDzPGHo8kBJn8Mb/613X6n4coTfRgiT0at47sd5NAbNNbc/tiJVZvPL/y78/uJpmNbODa6LzxZZLIZFy2EyXbpwYVys+ZryaoEdrqGV8b29bkZag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A04tgZRSpnd1mH5f2USd/p6h1t+1aPPOR8Tr31i5lAk=;
 b=lPg5yNnxqYxJjrLyuIW/wV58YWZh4RBPf0GBopqf6s5utIqF6jjC6SFFZ6czWAFl8Zn4cGstHQodKB5n9kk/UHjlJGas+AgN8+DH7RwGqhBZA56s19oT7pfWRRqs6kURXmQmQ5DMxOPmEwbWR6hNbpYQc8av4LSPggoQ2ZOyWXA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7918.eurprd04.prod.outlook.com (2603:10a6:102:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 13:11:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Thu, 13 Oct 2022
 13:11:00 +0000
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
Subject: RE: [PATCH V6 7/7] remoteproc: imx_rproc: Enable attach recovery for
 i.MX8QM/QXP
Thread-Topic: [PATCH V6 7/7] remoteproc: imx_rproc: Enable attach recovery for
 i.MX8QM/QXP
Thread-Index: AQHY08r2gmnMju/tqkuS6OOPEOGgs64LbWAAgAD0beA=
Date:   Thu, 13 Oct 2022 13:11:00 +0000
Message-ID: <DU0PR04MB9417D403F16C843AF0E2472E88259@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220929061704.1571746-1-peng.fan@oss.nxp.com>
 <20220929061704.1571746-8-peng.fan@oss.nxp.com>
 <20221012223216.GE1196937@p14s>
In-Reply-To: <20221012223216.GE1196937@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB7918:EE_
x-ms-office365-filtering-correlation-id: 4486ae67-57d6-4d95-4904-08daad1c5fb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2tv5TEUwyh28Qq4nKuxc1zju0R+a8SDRwZHLkfevB8UZEUZwe2Y+EOaTtGQk6isVlWQSqmUJX1oB3uygRQfdIbWr7DVRN3DlkdGEiL0SyjH8EaZx9RkiPHIPrTUmFPSDlzNVnY8NAXfNoePG3UOQwF/VWLOEumjCMzw3WwJHRCc2N4nj7/TXOnBDlyvvOoFzF13dyjcxQd0yqHaNw18j7CV8T55rnAKZwIOzeRUD1ypUrTcqLodqquIcQma1nBzvfAzZukXpks1H1Ql6whppIQ4GxfDIZS3J55kv8ZFIid+27Qx7gUTp3O2M239qRMpIJ7iWTDcEKXVwAhFFoHOC21F5bVVif0vFVTIWMA9/N23YkhpFRbWK1Jc/krZ8a3xlTzjmoK/njNmQYKRki+pv/DgqAuLz4rsyEhbCIZ6/Et5cQWI7r95XxjIUZFmPWDJhgNa4Xye7/+a9GM9zmrJ7xpAba7mBbiLbJoP+3QVfe/EC8+Rm4hGeBwlrTpPIdRsqIAIwB6Sj4KapymdhhEZIGa2t7NTxk6KSOFGJJ+3XLAjDqaSOrPR6EjXX/2FkztAxPDydurzCHzCwFliJ1bfVOtxslCXQqyYlAIwhwrA9s6UwkSrxMLrRdi82NiT3tkOpD91E+JM/8vlk/B+eb0ErAWmZLvZlS7K5LhlGGntBIuviSYAC2u6h5l6/GqO7wIvlw5gcLmf8uOBwTRw0KjOKXPbUbD7c9cPwfYlYcXX9Hl3W4w3yFBVUHdUnjKXlJ/xhrJL6o8EOhi00NaxBm1HBow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199015)(38070700005)(122000001)(38100700002)(8936002)(33656002)(55016003)(478600001)(316002)(110136005)(6506007)(86362001)(54906003)(7696005)(71200400001)(52536014)(76116006)(5660300002)(2906002)(64756008)(8676002)(66556008)(66476007)(4326008)(66946007)(41300700001)(186003)(83380400001)(44832011)(66446008)(7416002)(26005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o/0/alIwuku1glJpk3l15OqteJ+LxosktfQ+RwMcBN49bouxHPYi6V2Oz6U3?=
 =?us-ascii?Q?Qd4P7M1Q5LUfMzIr0f87bNKMwSsi6DpTkNn8muiAaplmsjFK842ict7unJW/?=
 =?us-ascii?Q?IXAI71FOSStJLoJxo0Ga5iLXxaDiKp38iFpmRWI8oEHFznONwgpZ7G9BguZZ?=
 =?us-ascii?Q?/cCitGDVfzLWmZKJzpPXQIIA4Qvf9Do7fHGoPRNmfCDoGzjI8fZurSOb17fe?=
 =?us-ascii?Q?ah7XQt5oPbHURz0zuX7Q6admaD+EkgbP9xC8z0z+SMevWQ8IwP7mBJjuZfn3?=
 =?us-ascii?Q?VfoHWrOY/kABaswaESSqn8+p5BIQAlrJ8xUXUs3vJlrGJ8xp4G/3SLhJCUn1?=
 =?us-ascii?Q?T9bURXUonrDLnttBxDTkmFQugLlVICYRESkFRjyK/no/FVw1NGelLJd6KRQb?=
 =?us-ascii?Q?NmPEL2oT266M30i3Qi8niERqXb3J7Ac+P7IYk68W3kLZhJCBVxFtdIoRfmwY?=
 =?us-ascii?Q?0TcbdMlpqWGtanJKEZu/Y5au0rmg2Sh3EWATuCsQdmMaUWlNse+LxJ513rTE?=
 =?us-ascii?Q?bu9JOlYWibP9ftkuKHxaoF2bw+baZHbedUVjUYRjA2+mnJpD/BBgCLmTY6fd?=
 =?us-ascii?Q?aqqM/w1iPpkBXKCzSzIRmHx5An+v3I1/21OM+8CibZHAB45vXESvJ8Wr9BvW?=
 =?us-ascii?Q?iZBXCE6kc04RuIw+s/xM/fmmvpvO1o1lng53+R7/f18uUSIkIS60/dSrF7p+?=
 =?us-ascii?Q?MwNN1+gDuwNhJbx9o4W80EJcuFUJhx+qw0y1EM4/Lr17b7SMbAlT2vbNvccV?=
 =?us-ascii?Q?GUYszhUA/VqmuJusI/TVO5L7/76YfwQWR5G9Y7RjV1Kc2XrkF4kY4l9TB0T8?=
 =?us-ascii?Q?X+RROIAH4xtEFTR6bow3gAAIvY4BRO35pBMUVa1WSiLvk53G1AzSWxS5iTwa?=
 =?us-ascii?Q?BXxhKOedi7I04sUNqKHREXLaNIECyKGGVolE08slbQtDPRJFFc4nyTt2GSrd?=
 =?us-ascii?Q?QXE6sBGWkJSHrWeZ5B7Ov3nveW56mIY2eX5bsVCuP3fkqmzA4LFkIK/4DJ99?=
 =?us-ascii?Q?HVBiNxl4v7WF3ZwGnDUF7fizC8gT8QgDPHegNuMzllW/Hp1J3EuKMzNuZZQl?=
 =?us-ascii?Q?d/SPPsaQMydSP6df8f5fjp89tPeGteqP+TuX6p6+Ld8SGwQFKsK8qEuvq8LL?=
 =?us-ascii?Q?z7BrBJEHRbuo46G73anKCBJRtF6H63RDImEeEHfQjmDhddbDjcZw5GzFpcwn?=
 =?us-ascii?Q?A0W3RUua0PgUa4VLRKn+TvzrLPM2e35r/BM4BsbSe2uLbz2e3aM4NgBzR0JV?=
 =?us-ascii?Q?gQUjm8I6/CNiaQqFNEw4imU6jTZXhIR9A3nMoGQF3NsW8Qbi9pTpqcE1EOor?=
 =?us-ascii?Q?CQhNvzRymNSc4z9DpnW0pJ7/0EWQL8fUFCx5OK9IWyTaASMiNU4JTlfJfZYU?=
 =?us-ascii?Q?83W87SX+pZIWkoy6FB5oM60rUOSxhgXJwffzUPSJz0aqjMDb+pJ/1JTToWAp?=
 =?us-ascii?Q?6dXBYIync9ZeTTijNS+4pigxz+IK2GE4RGCx4KPrSkp4esoXwoO5A48ihTwE?=
 =?us-ascii?Q?glf1WWy8X8tCkonf+8gGxeJxtKYoMSlzFMDSmnhYz6TNXTwDfZY97s7Zwm9/?=
 =?us-ascii?Q?FOLpQZfCcpKpiBiZjfnL0sW6ybZnw4X3VmYpU8Ha?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4486ae67-57d6-4d95-4904-08daad1c5fb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 13:11:00.2374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QLVSuxbhCaimDEJ4GI27msMXuUXQ67V34FpWUPUtGLpv5RqI+3zFTDhxJMfcr8M1Z3UbWAXuJW+MfaiZ/PqiNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7918
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

> Subject: Re: [PATCH V6 7/7] remoteproc: imx_rproc: Enable attach recovery
> for i.MX8QM/QXP
>=20
> On Thu, Sep 29, 2022 at 02:17:04PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX8QM/QXP M4 could recover without help from Linux, so to support it:
> >  - enable feature RPROC_FEAT_ATTACH_ON_RECOVERY
> >  - add detach hook
> >  - Since we have detach callback, we could move the free mbox
> > operation  from partition reset notify to detach callback.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/imx_rproc.c | 22 +++++++++++++++++++---
> >  1 file changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index bece44b46719..4057d6f33813
> > 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -603,6 +603,22 @@ static int imx_rproc_attach(struct rproc *rproc)
> >  	return imx_rproc_xtr_mbox_init(rproc);  }
> >
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
>=20
> Which is exactly what you did here.
>=20
> I really don't understand what you did in patch 6/7...  Anyways, I sugges=
t to
> add support for the detached scenario and then fix the mailbox corruption
> problem.

When CM4 doing attach recovery, the mbox channel needs to be released,
then attach function will request the mbox channel again.

So the flow is=20
CM4(attach->request mbox)->CM4 crash notify Linux[1]->Linux got notificatio=
n
->Linux detach(release mbox)[2]->Linux re-attach(request mbox)

Since patch 7/7 is to support attach recovery, so I move mbox free
from [1] to [2].

>=20
> I am done reviewing this set.

Thanks for your time.

Thanks,
Peng.
>=20
> > +
> > +	return 0;
> > +}
> > +
> >  static struct resource_table *imx_rproc_get_loaded_rsc_table(struct
> > rproc *rproc, size_t *table_sz)  {
> >  	struct imx_rproc *priv =3D rproc->priv; @@ -618,6 +634,7 @@ static
> > struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc
> > *rproc  static const struct rproc_ops imx_rproc_ops =3D {
> >  	.prepare	=3D imx_rproc_prepare,
> >  	.attach		=3D imx_rproc_attach,
> > +	.detach		=3D imx_rproc_detach,
> >  	.start		=3D imx_rproc_start,
> >  	.stop		=3D imx_rproc_stop,
> >  	.kick		=3D imx_rproc_kick,
> > @@ -797,8 +814,6 @@ static int imx_rproc_partition_notify(struct
> notifier_block *nb,
> >  	if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group =3D=3D
> IMX_SC_IRQ_GROUP_REBOOTED)))
> >  		return 0;
> >
> > -	imx_rproc_free_mbox(priv->rproc);
> > -
> >  	rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
> >
> >  	pr_info("Partition%d reset!\n", priv->rproc_pt); @@ -916,7 +931,8
> @@
> > static int imx_rproc_detect_mode(struct imx_rproc *priv)
> >  		}
> >
> >  		priv->rproc->state =3D RPROC_DETACHED;
> > -		priv->rproc->recovery_disabled =3D true;
> > +		priv->rproc->recovery_disabled =3D false;
> > +		rproc_set_feature(priv->rproc,
> RPROC_FEAT_ATTACH_ON_RECOVERY);
> >
> >  		/* Get partition id and enable irq in SCFW */
> >  		ret =3D imx_sc_rm_get_resource_owner(priv->ipc_handle,
> priv->rsrc_id,
> > &pt);
> > --
> > 2.37.1
> >
