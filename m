Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEF6740752
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 02:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjF1Azg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 20:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjF1Azd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 20:55:33 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C730296D;
        Tue, 27 Jun 2023 17:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4oHqQtUSIQ0p/FXlAN+AJDX8Mtnr09gJMxvnLuD7Bq8Z1e5hZxDkSce+BNlRy/84NHowMIGkE7RX2+xF6Me5LiR9yaKxp9oCbCegGntRdcEIVMacpl3Ggn1HAYEzYhDDYCNE1nhFzfNKZJKoBEaTskpWxMnXLlsdt/h+EYUMc/ESDR1HfJhUmyScTBuoyaN/yel6AK62jtApc5sfEo4UpkmRIsaEiYTN5Xum9TR6+GvwP3uiksOVGI5XII60FShdXMsFW8tjzujEvQX887pjAqqEAUqc6+QRdPKcU3DQM5wSI1jw9Gro205umd197tNEPPR+9C+j7lIRZ9JL2bhfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpxK59v1gfsVJ32zzTFacrlCJiFCPznb+RW201HEGe0=;
 b=cUAkXUVoyTfASoFqHys+oWuT0lqJgtAFx+ahkpcXECuUJvi/7FSs3GiiAi7gGTghzfM32YyH3SDpkVevfcC2uDF9NQ48lruKPTJr2kpRop3OkDuPFpxt3LAp5I7ySIu9oT6KR2rpevlvMZJUI4xgpawwP+qy14bnmoW5KSYTImqWXNi2d8oFjYOQInqz2qFzOsUrW/cHFHqc02byQuyUTWgxzElJ1TY4osbW7lGotRZkygO3Waw/yYlLKGAo4k6wb7RG0PpL3oT6jyc3YZresapey3vwRTndPBleVNzaxKPYuE0eFbi1aXjwcCHSOm+ZJG/QJ9b0drIaRTDRwUf78Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpxK59v1gfsVJ32zzTFacrlCJiFCPznb+RW201HEGe0=;
 b=sPkoSpmHxaOX6fjeVyu10r/JwO8hIBl0chflq0z2JYEDAcQ/cba9LJvVR4yX0Kf263H6Q5e0rHSevnmFcziozQaBz2iIUtuuRKOnW+TfVCvBxXyGKTMecKdvtGl88m/YDkZW+wcmYwaiX2j7kOCjVGashbx+lKcUMUWpWdR28Nc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB7031.eurprd04.prod.outlook.com (2603:10a6:20b:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 00:55:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 00:55:29 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "andersson@kernel.org" <andersson@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] remoteproc: imx_rproc: iterate all notifiyids in rx
 callback
Thread-Topic: [PATCH] remoteproc: imx_rproc: iterate all notifiyids in rx
 callback
Thread-Index: AQHZp2DQuc+kJnrKn0KcjnqxB9xv5K+fQaqAgAAlHdA=
Date:   Wed, 28 Jun 2023 00:55:28 +0000
Message-ID: <DU0PR04MB94177CF1F7EEBD1EBF4B177A8824A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230625123514.4069724-1-peng.fan@oss.nxp.com>
 <ZJtlF/tzh0ZMXji4@p14s>
In-Reply-To: <ZJtlF/tzh0ZMXji4@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM7PR04MB7031:EE_
x-ms-office365-filtering-correlation-id: 5ca1de8a-10fb-439e-a705-08db77725dfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 798uHIBJP1BHT59DDlvd4nwoFzMhTpuiQ1eznoFoJ/cETQ9ftPZEaxdVFWPkU58qURLsxHeAXDxkCPi+6YZTqAOVtWjUbOaW76+OUJl2Z5IDD8eOXAIbNGabjHlqcWjuPQb3MzefOf34vUPB5rK7v24PU5pYXov17hdY+sGB17WM7jY7mSIrkKdf35xukrYb3UJILuCgKGVUMmLqHtjYs3nW3hMnb8+rsXAS3qZOnoyY6xMaUjVno5/BDidL2ZjOaXOEnVTvh+YeZne2tDpzClzkPEIqFbbOcWrcKWXdE9FIIX3vOGToqB2mWSdzjDNyOO6lGz4LVM+ZlgEUHUUuKXn/dGLHVpN4ZBRn8YI7uXBF3VGsaMna4g/QULwJFH5FMorZTSXGgqqmGUJsTxTGyAzl6abIZPGP0KLv819RK5V4lBgI2NIQZjiuwkeHurYoFL+uISNttEmQbF2YBEde2sBTe89XcFCUHqGLgnblAO4535SvCRhQJDbEtUkmnMIHP8jSQoVgcUNSPYUcDS5qjjPjL8drm6aaShGJt14QZjMoglUtTQbbi0bcPR0YLR7gKEgja6qaSp23ESXrd/cbowHpIoM3p4X6SgPt95OWeqwVt/pz2E60lZsbbtz0nWgA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(64756008)(26005)(33656002)(44832011)(5660300002)(52536014)(66476007)(8676002)(66946007)(38070700005)(66556008)(76116006)(38100700002)(86362001)(4326008)(55016003)(122000001)(8936002)(66446008)(41300700001)(316002)(9686003)(2906002)(6506007)(83380400001)(186003)(71200400001)(54906003)(7696005)(478600001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ypE3D1ttCiNe3nhcDWNAXZTAOXf/z6JpRSuRTypoBkzKSFcQyUa5+pwMJTmM?=
 =?us-ascii?Q?gUzlNU+oNlpe7eir7InFw/dMPOb66O+NUDp23dUH2UXMtu74hbWVUjVP+QMF?=
 =?us-ascii?Q?B2VRL+JTCWkIJbLpiUbAdATvSWafsMa/exsqVmlWvv6UBIgukPYhvVJH6d/W?=
 =?us-ascii?Q?o7X5aGWM1EsnejEdVAEaidj5VVi42C6Chj8NHHFymV+wgLpuWEjvV1VnqeCi?=
 =?us-ascii?Q?zbXfSVBmKhiMXOvHC5n0L+pFdU1NjSsnPKcqllS45hmH6ESSk0WJ6HenvPm6?=
 =?us-ascii?Q?SRTq+hNRbqh4a0Wm6BYjfiW0MPKxjAcFoM6CNXWl20sdqKbk/pp8QhFEeaUU?=
 =?us-ascii?Q?DLGElSiZ3z8cdzFsKeV5b6rdZbRrj303DEYyHwXyHrejvJqZ38WaEiBAiCcl?=
 =?us-ascii?Q?73JgDE8hBTZ4Z/Co6ayUDoY/Xkl5NRbxXGHvWvr2gva0rhAAGxemgObNz5k+?=
 =?us-ascii?Q?Tosi/krj2LYAY6avqevqa28kxkznkvsPSq9E+WfZ0uw4JSCOABs6bRbhV3S1?=
 =?us-ascii?Q?7OjZoBAXKcDNcqBb9oKsYvDCAOLCXKugKrAPhY0KcDGilrD4+TKV5Cs2kFDN?=
 =?us-ascii?Q?KRPPOIAuKyLMyopNflqgyuIXyWWc6ChzmHH9rZ1MZPt20il5M8B56QAVqNkL?=
 =?us-ascii?Q?BMnXLJLuHMeL/HxZF23EbEDh6nbkT8Yg3oI8+5qMXP3s+mJOk34/u0ospBKo?=
 =?us-ascii?Q?bgZmfdenrYQDd1jsvvVEgtQewNDGrrXLLW4rYPLY/RYMWSgFc+v++i22E49o?=
 =?us-ascii?Q?ylFl2UbgPfufLcYg9FRuMhtzw/6SF8QY6WTvUb1Nvs/RFAXdPJecPeoYeiay?=
 =?us-ascii?Q?MzvwvGOvOfiOhNYbuu34nASX/99zF1aIrzId3VXYDp5VPaVLZtAcvgU3O4Sm?=
 =?us-ascii?Q?gDRkx6Myuc2UViLnDJH4lpL/4j01dF9fPlQ1xUpcY1YimpoKXhSn1SS3R587?=
 =?us-ascii?Q?KUpPXh5rJJ/b7Llw1z+/2GlYPkiqn19f8j+Q4ssw3kJxZjN9l36eZYd/r8Wc?=
 =?us-ascii?Q?rftEcMv0lArTdev21/vxSVOm2aym81E6yzMktc8WrlZohMKVBkrN8grFbncI?=
 =?us-ascii?Q?b6mXC7sqLS64M0tqe1LqKiZDjs2053Mm/grh7mshJpfeEOqMOaEoTtvIPsBX?=
 =?us-ascii?Q?J4GCep3B2CiIHX4lsBKpZbB3WxA0YBEOf2Iw69x/K+ISLxQYq5AyOHHwfhxg?=
 =?us-ascii?Q?ywJcANfqiP3vuf/rXWpKIPkVSHyUh8wyNJMwUF8S2TARkjJKU76M9he179v0?=
 =?us-ascii?Q?+1eK3Q91Nos1uPRz/Au7Hn7tXp+mmE0TrohUedRV3nzvnGzZYywiayzXQHF5?=
 =?us-ascii?Q?E9P+9ASUE0QRQjcYWhoFHMzM9hUP0kXJP4rLthYNzbVG/KAvmfn7weZGzqfv?=
 =?us-ascii?Q?Bfs+0JUKaN9wKgUtSZXJ7Nyeq33oq3j3+5EyaRiljDhELRVPaVmfPh5wA9T8?=
 =?us-ascii?Q?ywPgFUf4SzrqsxFZ1FUXS+w0LcqsWqxFsbrcwT/lvSlFAZc8hsaR0dijyKyP?=
 =?us-ascii?Q?D3uCTL8tn/ZbQ5zP9RN4mVPAvNftZVCKR2iJ0rQW0kUQoSrEwENG9SX3JEDt?=
 =?us-ascii?Q?CXhKaFMm3aCSdBvLNOc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca1de8a-10fb-439e-a705-08db77725dfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 00:55:28.9636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kVHaNuEQ2p2uwVGERcqAO3ETADy7VRF9BGCKLvPZRi+DpHIcInSmGtD5Ecb4iIj0Jt9OHOUZU1eVvMuTPPVNyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] remoteproc: imx_rproc: iterate all notifiyids in rx
> callback
>=20
> On Sun, Jun 25, 2023 at 08:35:14PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The current code has an assumption that there is one tx and one rx
> > vring, but it is not always true. There maybe more vrings. So iterate
> > all notifyids to not miss any vring events.
>=20
> Can you be more specific on the use case where more than 2 virqueues are
> allocated?  The remoteproc core can handle more than 2 but right now the
> only configuration I see doesn't support more than that.

In downstream tree, we have below remoteproc node. It use
vdev0 vring0/vring1 for vdev0, vdev1 vring0/vring1 for vdev1.
vdev0 and vdev1 are for different services, saying vdev0 for gpio rpmsg,
vdev1 for i2c rpmsg.
	cm33: imx93-cm33 {
		compatible =3D "fsl,imx93-cm33";
		mbox-names =3D "tx", "rx", "rxdb";
		mboxes =3D <&mu1 0 1
			  &mu1 1 1
			  &mu1 3 1>;
		memory-region =3D <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
				<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
		fsl,startup-delay-ms =3D <500>;
	};

Thanks,
Peng.

>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/imx_rproc.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index f9874fc5a80f..e3f40d0e9f3d
> > 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -725,13 +725,23 @@ static int imx_rproc_addr_init(struct imx_rproc
> *priv,
> >  	return 0;
> >  }
> >
> > +static int imx_rproc_notified_idr_cb(int id, void *ptr, void *data) {
> > +	struct rproc *rproc =3D data;
> > +
> > +	if (rproc_vq_interrupt(rproc, id) =3D=3D IRQ_NONE)
> > +		dev_dbg(&rproc->dev, "no message in vqid: %d\n", id);
> > +
> > +	return 0;
> > +}
> > +
> >  static void imx_rproc_vq_work(struct work_struct *work)  {
> >  	struct imx_rproc *priv =3D container_of(work, struct imx_rproc,
> >  					      rproc_work);
> > +	struct rproc *rproc =3D priv->rproc;
> >
> > -	rproc_vq_interrupt(priv->rproc, 0);
> > -	rproc_vq_interrupt(priv->rproc, 1);
> > +	idr_for_each(&rproc->notifyids, imx_rproc_notified_idr_cb, rproc);
> >  }
> >
> >  static void imx_rproc_rx_callback(struct mbox_client *cl, void *msg)
> > --
> > 2.37.1
> >
