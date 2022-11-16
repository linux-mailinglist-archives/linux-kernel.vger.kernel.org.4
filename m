Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3037F62B151
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 03:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiKPCb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 21:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiKPCbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:31:55 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD0B29811
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 18:31:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NB58SEdA1Yv1yi1fKhevbcfhoSCtHLCQE+dlKTn2a9l3fg5byrJ5cq7lkBkRl2hRN4Y/IWzrpQoXaAFgH/g2SQcqLMn7KLcU5ih3R/ATx4TuyhK8HEDMft/SfjZDBJbuZ0l/s8G9IrqWbfX94WJgSf9AEh5QqK+3c5Eb247LM1ST6nOL8AKWfjCkmu9EqCnqLjTIGlKQj6lQ3VDR7c0y1h41lYt0mdt8L7Y0jYFrvymoAEIYwY6eqxiKEAl12E+9RVPbT9GjCpuCDH8/SAiXH4CDXglPnb6q7h9qHtUKVA1FDmdgj/m46KchkEsxLH/z45MRFPV+JN4zEhQcA7v5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juEKoyPwCFQLMcdl9Lu34KeIl7OHnXF3JTDWKFaiX3U=;
 b=fIbc2Y29tHXsLEbkQS1mXPmPUC2oLjXeP58MNJR5tAepbWXqdc8PIyQIzTOSdzXiS7zU7zjMgU+jhyfel61PxOhCRYUXF+s+s0RpWbcJNdD5DIZ5fj5Zq/WNKkMuaK+obpELDA3/YjbvGO/paQFki2tYLQD+3IQ2Noi93pc+b8mwrc9MdSvK/ytIvn1wez7/S4iV9uIvYlxUyb7aFmXCPVV9AeZOeUhF5K8QakZKz/nGRuY5Qza98Nx9Hbfi/mhPfLDyyjztCwHXIT+EGTgSPW8HUl+Y330SmR8e7cfREBjuS9MHraRlnlmMuzIm4v9AmEDtO8bN2BEVEdHZCpwaTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juEKoyPwCFQLMcdl9Lu34KeIl7OHnXF3JTDWKFaiX3U=;
 b=LnLs2psI0AWNa2tDeb5/Fanl/03GezbhSj5uQcs+mmWZZ8A+z5x0U8Fuf4ytRGAXGoCn9ENexmuyh6iEpZGMYtjean8Nx/4aWiKzYdml99FJygD/4ZQPWqjIRaE0ezCpTqCODV3P4IfpgUd1TTSbrp5DcjyuoG6bCMZaQRGTye0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7535.eurprd04.prod.outlook.com (2603:10a6:102:e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Wed, 16 Nov
 2022 02:31:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Wed, 16 Nov 2022
 02:31:49 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V5 07/12] arm64: dts: imx8mn-evk: update vdd_soc dvs
 voltage
Thread-Topic: [PATCH V5 07/12] arm64: dts: imx8mn-evk: update vdd_soc dvs
 voltage
Thread-Index: AQHY+NLkMsIJTWCTDE+Rd0hYrBnN864/wTKAgAETwlA=
Date:   Wed, 16 Nov 2022 02:31:49 +0000
Message-ID: <DU0PR04MB941782A4B6323FB9405808B588079@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
 <20221115091709.2865997-8-peng.fan@oss.nxp.com>
 <20221115100251.7hwpnodgxzirgpw6@pengutronix.de>
In-Reply-To: <20221115100251.7hwpnodgxzirgpw6@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB7535:EE_
x-ms-office365-filtering-correlation-id: ed43bd97-f14e-4b7e-74ec-08dac77ab718
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: guxdSY8RZWt/SPiEDCcP1VdPsqPExiHGu0SKbMxf9wvp8bJcybM/Z9Fzv7eipmMEWqvJq71gIn63RRNx6VvSY+2n5aVy2LC4QddGMBF08/LsGdkAR2r50TLMMovudmiNYMd56uCAoY8hZq/RVG84stWQz0nZRQQXedOwPW2gOnuIHINtdQ81Am71R9KPXSX5xawxLqvDK0wPP8WUnWco5T/00ChblYWbW65QfS2F/b0E6PteJjLp9T39BdwQdmoSrN1Hy3BnSEysA9wHwGY5SWZtFFLwkGvw10O6NE2HO8NxnSJ8AJo1oDWxr3toGjfbJEz1Lo6VMq+BbEDn8V2Md0oMV99j/alK+VfDp7j3be6FWev0vxPgh/FIINqv44UbmrO/umD0jk4eQid8e+4XawNFEDGk+MAhz8ydzjB1ziMTYbIVvnbFK3Rb1av2rLQGzAeSwUJrx4ddTAuTv7MV9oYJ4sb+n+RgmI0xAurR20BJGIOSbJyNx+1rL774e+fNHoe/B/r9PtXES5twcMEYahfCUDbRVj+OfXClfOPEHICgDrpUps7M+zzy1WFZf4kkxYEnfE/lcrk0mq2tOUk8fmcmLigr5xRGDDRn4BuK6q6sZqk7nSFf5LChrKPLPTTIyI8fUZs/JSVVTKUU1J3nklKNYkbmlYa8q7cDb4J64DqRK7TVZJ8zpfrHle/U9E13GuzEVdn+C01UKatPPEFot/iYAekvWjAfsmfLgZXLyVQnyh4/SNC6jO1RBBjlXRHXO9r5wGsceHHcbRe06WpAR1nkoS9PGbTRwXv7B1tIENk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199015)(316002)(66476007)(2906002)(6506007)(66446008)(7696005)(26005)(66946007)(9686003)(54906003)(66556008)(71200400001)(110136005)(8676002)(4326008)(52536014)(8936002)(5660300002)(186003)(478600001)(15650500001)(76116006)(44832011)(41300700001)(64756008)(83380400001)(55016003)(86362001)(38070700005)(33656002)(122000001)(38100700002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tWGUR7++aULAmHU4vjXR/TaqW8EqlLnHy+5cSHvjo4fXtkTgcFudm+k0mBdS?=
 =?us-ascii?Q?0R2rgl5+yG8QEffXvRRjuoWQEV95HT7zxSxNKhHVpyYuLdXc9ojywIvU/ulF?=
 =?us-ascii?Q?S/ITVQ2QJNonH/4qdiw5IepSOrV/2WFnDtriwaUwwKkOITIUIh6sgJiT/OmQ?=
 =?us-ascii?Q?4bYLTw8MpasUMwKkHJiGOpIx/KiD5hPY8hmeQmgk4oyZkSxrfJDVCDsWXbIO?=
 =?us-ascii?Q?izz2FByksUB+/y1LslgMoCV0lbfPuaS35bMyFJpylEHhQUEvfQ0QXOQUdpie?=
 =?us-ascii?Q?xZg69LEkv4C+a7UzzpgdrDr0HKsf4spEOtqTP8glECrX01pmEM9wpEqL8/KA?=
 =?us-ascii?Q?qJsT4o7bwQX9yk2ueYrsGmab/23ClOyTxu0VBzGUqChM1TfO6so7fGQObVGO?=
 =?us-ascii?Q?tqXcvYQaHtc2RLU70VVBI8VD3kA9zYFKMRFiaDwfkAMFlq4k8JqEZfqw68CT?=
 =?us-ascii?Q?wRQwd/IwCtl6T14fS167JTGE9aenOYx/trva8QNCerlh7OvnzRHmypxioy1a?=
 =?us-ascii?Q?DjwJftL1p00Q42toj+SX2LS0yOaiKd2dywoKyRw0QlfiDbe+LjfWS1T/sP5T?=
 =?us-ascii?Q?oMMnD2TVy8gD6u5YbsM3aAwX0kouoePKV2cPowGKv2H3ANkYGN3KR9R3mPmv?=
 =?us-ascii?Q?tWSfoLWglPqCqC6Je1yo+6iQZ8A/BezGJA7rTl9F1PDBLo8idZZMBm4gIsxJ?=
 =?us-ascii?Q?6YCZT3ey0VANMYH3Ae72idMi+JgTeclL2zNJP0ZMp6okfdW+DPhAbP71xv7r?=
 =?us-ascii?Q?ncAcyO9vU67NgKCxa4T93u47qn7a4lhNPHxZNCrPcRHIs+i0+1OiTh2klKlf?=
 =?us-ascii?Q?7VikY9IAHDlDYIzfYiPRJGDG4QRENP8uxGZy49F5oo62aiRtTxHjCIzRC9kF?=
 =?us-ascii?Q?2EQJ+IKOcwkqg6V+4xBzo9yANoF05D/Uo+HV4sQWM9FUynxUHlYwYTYNvXXJ?=
 =?us-ascii?Q?LkPbV0jx/TD4aftFcEvAKp74ZVyEbxZA19lF8QN7Fm7hF7seTb2oNvntaSAM?=
 =?us-ascii?Q?GViEVVPdtQtZngvpiQS4SpcCt5iywsK54eqod0IS1ddvzlVoXEat8+bO7gL0?=
 =?us-ascii?Q?6JSZZ3At99avgpfe4+ToJB0PxW0w2VVzO2XE81fSKCHVgesAquOpHwGgs7ha?=
 =?us-ascii?Q?3cEJrQLtSYWFQGom71Wlfk+g3OwsmsL3PpWm11W57u0h8MmfQinfX6lpkFIw?=
 =?us-ascii?Q?ipRTdWdWwcuxfI97aeHrlR9CnJidnDu0dkjaPkMgktBU1k4MEqSbz0+tHpar?=
 =?us-ascii?Q?642Fx4HLhOFEz02SyNughFTMr2Jn+veF+VUtTCuZdCy6CdE+NTv+tL7E9buH?=
 =?us-ascii?Q?S4PUDIYzMfM5NI50DyypcVFXudK6qS6K6oBAlNkGGccpP7lKyP+IwC6YBlbH?=
 =?us-ascii?Q?mI2gAqJUm2Dwgn+jt0teCvMJi2Y4+ZMOjGLwdg7dnlj71eXhon7orlPY9l25?=
 =?us-ascii?Q?5/+LaCdoripD5L3Gy9hYARzdwWGRwmHgOrbLMJTyY/sOMjjxKyqQtRCfLVqV?=
 =?us-ascii?Q?ksqGEl/aXuIUa7zCrnDX2UtDijM/5oGF22Yh7WFtlObYz/EMF/rdvP0OMGoh?=
 =?us-ascii?Q?Lfwo9BN3GBMHaxigIxM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed43bd97-f14e-4b7e-74ec-08dac77ab718
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 02:31:49.7492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jMdyVmhINwZYiWbsg7TuWxEr6S8QZEpFCNq42r9OG+RWBPzV0QI8be+lZSYk/BJCHYr8AgM+a3zhEUXi9D87PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7535
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V5 07/12] arm64: dts: imx8mn-evk: update vdd_soc dvs
> voltage
>=20
> Hi Peng,
>=20
> On 22-11-15, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Per schematic, BUCK1 is for VDD_SOC&DRAM&PU_0V9. The
> > nxp,dvs-run-voltage and nxp,dvs-standby-voltage need set for BUCK1, not
> BUCK2.
> > BUCK2 is for A53, which is handled by DVFS, so no need dvs property.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mn-evk.dts | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> > b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> > index 4eb467df5ba7..a5a7d74ec1d5 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> > @@ -47,6 +47,8 @@ buck1: BUCK1{
> >  				regulator-boot-on;
> >  				regulator-always-on;
> >  				regulator-ramp-delay =3D <3125>;
> > +				nxp,dvs-run-voltage =3D <950000>;
>=20
> One last question on this. According the schematic the max should be
> 0.88/0.945V and you are going to set it to 0.950V.

No, my schematic shows the TYP voltage is 0.85/0.95V.
>=20
> According the driver the nxp,dvs-run-voltage is just the same as the norm=
al
> regulator voltage. So I would suggest to just use the nxp,dvs-standby-
> voltage property to enable the DVS feature since the run voltage is alrea=
dy
> handled by the regulator-min-microvolt/regulator-max-microvolt. So it
> would be just:
It should be fine to not set nxp,dvs-run-voltage, because bootloader alread=
y
set that.

Thanks,
Peng.
>=20
> > +				nxp,dvs-standby-voltage =3D <750000>;
>=20
> Regards,
>   Marco
>=20
> >  			};
> >
> >  			buck2: BUCK2 {
> > @@ -56,8 +58,6 @@ buck2: BUCK2 {
> >  				regulator-boot-on;
> >  				regulator-always-on;
> >  				regulator-ramp-delay =3D <3125>;
> > -				nxp,dvs-run-voltage =3D <950000>;
> > -				nxp,dvs-standby-voltage =3D <850000>;
> >  			};
> >
> >  			buck4: BUCK4{
> > --
> > 2.37.1
> >
> >
> >
