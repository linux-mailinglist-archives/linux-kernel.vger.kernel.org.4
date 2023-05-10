Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7ED6FD88D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbjEJHt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbjEJHtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:49:25 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2069.outbound.protection.outlook.com [40.107.104.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52624CD;
        Wed, 10 May 2023 00:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxVJ+oIeCLF5cEyLc2RTTSIImZdcVcPxCD37mr0oCY7BRSTnS+JhHh02u/tfXgAoW80DBZScccfir8QBnX6BDxRMkJKidW8ORPGC1Y86UkI58wMz502amsczR3eBXl9gpQZo8uLoF7KQRV1BUDTkNuImIas/WrKZIqQH6VzcnEMa+K2R0jByyZHdYikGOZT72S7rmHwK50g5hO9Nrh7PXMT6Qx5cS54IUcT9oZ2CrAhVLQitHP7ErXIx4Ac3dzu0koxpgi40u40ChhEbCLVBxxVl46kccrbJGClVomdFzRWI4YacQG6CW3GVjckO0iINOVqTb8wSHjafyisPYTUutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQ79UQ7rxhBHkDAnxNqkOxC1gyXxLjAGETb57h7weKg=;
 b=N0zlL/C4wMFvi2mLPOO+zBajOh0z6wf012sLzBPR1oiRIQh5kbWMuv+y/INrvII2Lf2m09532DawMDmzCD4759ed0qgybLfpfLe3YGpH9Ck/31pWzqAvPbY3gQUOAM3nt+sFYqHF7CPlCRZNEvCuOfwB53bY0B7mV6mLhAQfHIMNORrWWSIVVv8V0B5gsf3bWx7wu9RXK033iRUP6oHgS/f3Bj1RY3kqElpLjbVhuE05iS0QpwsPUP9CIofbso8fQY6VgdH0eBWEdkGM1meVIXP1LdhSzxFZhM2DZ8ba4TrrtkQFKnd7jo0Ds03REBwzaRpjav/B5DKaBnC502eHDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQ79UQ7rxhBHkDAnxNqkOxC1gyXxLjAGETb57h7weKg=;
 b=M9OwFp3HNa/ZmI3gvxeL0XAsSKaaOSUg/Bx0IG2QkGn/CcMCrdgLFeTpUoU0ZdYMcsgqrQ4IHYaLKL0SeqmlwtzOYhsxkXsNY3Jt42nzVQ4cDNHZ8qloc0QaNF8zMQAUDC0TLyzFK8VKarPmiOWFXKTQD6wBovfR54Wa3PBPn7c=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB10061.eurprd04.prod.outlook.com (2603:10a6:10:4df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 07:49:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 07:49:20 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Greg KH <greg@kroah.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
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
Thread-Index: AQHZfmVsUoWhON65f0ewGxlg24Oc/K9J088AgAlWulA=
Date:   Wed, 10 May 2023 07:49:20 +0000
Message-ID: <DU0PR04MB9417FE67ABF9A2B1EE4DEBA088779@DU0PR04MB9417.eurprd04.prod.outlook.com>
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
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DUZPR04MB10061:EE_
x-ms-office365-filtering-correlation-id: 0da4e355-95e2-4919-90a8-08db512b108c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b0wuIN59Hr5PqMEflqIV8OKId1fzxH2sJgmLWyThM1+TSwnTlVZlttXPQxklnXF4IY5zlMpRkPZgxETHMCncDzkWUSFSrX9cM8Oszb0dpFUkZ33W5NI4mtC9WO1iD2TJsIPun/oW+iWxoxeLMfgtbJCVZ19wzQao3GyM/fkzbqxoVoH90UdHyNyggvHL5k+UqJsah/TjYAoM2KKC6kliBXB+Sxilyim9HJDoy94lSipRwiJoEKtPQkSt2/aAlNb61gvQvJv3xqzUu2juxID5A/pjIIZYx/yMQ1xRtAnVz+YsrsLbuwlI5JxNv6ZTVWWP+PKsBW2nXaEHYg2f6SVzt7UaBrNU1XKEfb44HksUEoToiQiH7JK3+aXakuSUS4y10NyjHPZBB+REz+GKVA8IuQ2crTASSN3CHnipS5yV2S4saGjn9JP66AyQepOrkPZDOxZl/gMIp6EQZesxrsfEEHM9ZXZXRbE84/K67F/69ySJcTYardNZHXgAoRLMf8s1mGIGhFc26dF0oscFDLU+wzcDQS2hliplK40F6UiX/+opFemvHQ7c2vMqcb4YhPJjr8OKN8gXTZBdzPs1FJzsjn88h09+bcakhQmimlg8MJw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199021)(71200400001)(41300700001)(66476007)(64756008)(66446008)(4326008)(66556008)(76116006)(316002)(66946007)(55016003)(6506007)(26005)(110136005)(478600001)(7696005)(54906003)(9686003)(8676002)(966005)(8936002)(44832011)(52536014)(7416002)(5660300002)(86362001)(186003)(33656002)(2906002)(83380400001)(122000001)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C4FGobatGfJ8ms9fsvCLYb5dYfKJRG2aB+Oxd6LUvYpFVDz5UZSnL+av7kn4?=
 =?us-ascii?Q?rzthoMJlFfW55kH1mqMn1NIkOtLGQAzrTGiIe/Q7JXgydvChUDGLd0VWtMFt?=
 =?us-ascii?Q?ReIpMv1BmIBisq52yT0dHRXQACox/3dVY9Uw3Y/ndhAxr0RKMBP7zKDk1SIu?=
 =?us-ascii?Q?/ziV+PbQfOUJnJbV3n44ayIsiaPQeGGihqsSDPERvzbbwAPIY3jRzBocskWa?=
 =?us-ascii?Q?9H9KhA2QcTxiQvQfxekDklPcI2OYtsiEjCc7WahiAjux6ZzC0KOryBrnxaTI?=
 =?us-ascii?Q?hMTsgZxUyIW4TKgQUqhGgGgh+aYrsCijP6eTF6d8h89TwXxFx2KYDot4K+1d?=
 =?us-ascii?Q?vm4RRXLXlNjerGmvbXvYveKy3HaEoQtHEAdRdlVTRUQdA/SG9lyg5OaGdLzl?=
 =?us-ascii?Q?YZOdiJFezdU+dG2lk0vI6V1FS8Bk4PO0pFtY+BWsQe/KkSkR4M0ihLkY1hm4?=
 =?us-ascii?Q?OfyeEh8aGz+PXYyKhVJj8jg9Qz5cUkGBiUSRcAQgWlfsb1RigLi+yQpeg7B2?=
 =?us-ascii?Q?y0AjxxQW0U+K12pHWOrTCsFoP7M4//RftRUYgoGiQFznq0juqdFNHhfgRGE+?=
 =?us-ascii?Q?yKSNDNxDlWp8dWdbUQ3GQi2qiighMSAEqz5VJxW5ZakVuYD0hJ7oRuMFddRG?=
 =?us-ascii?Q?Y0rtZKmbBl5F8pI1FN1+oWXmz+DUL1qpDOpykdubGnn+yuemvZJTwK/6uxDD?=
 =?us-ascii?Q?H9HdqupBTLzJxF5UpYAJRRRLTOsY/hzdaFvBnVyk3BdNGq+5NbiI1r61EVjU?=
 =?us-ascii?Q?dXRjsrFauucQx2UmXqlK5crLTv0I5Dbnb2P9OvLYYaO1LsMV6NlU8iVCyHIU?=
 =?us-ascii?Q?nYHZUTAm2tLBha7ylXn8xT67Jq/dGt3DXtZOQ+jOYhqyCExoH8mRp+GLFoEd?=
 =?us-ascii?Q?je0rg/XibWGdHyVH7JWXmmgonvLST+MYx52qwg/cgczfJc0jshA6PKbyplvr?=
 =?us-ascii?Q?YH/a9Wl5YekiyeWOMBiSBLTCFc56gthrRJK+ig9mgb/OzCsu3hfYii5O0bia?=
 =?us-ascii?Q?MtTsCwZKnrGpa1xliL64+W1OcCfT+Q4bzkAR0/zSUmeHeQAM5dX6lalICCeE?=
 =?us-ascii?Q?lQndsAkGn4znwtdxvCztiq04hWCQaZaRxROnUPZ8oi/ijHcuvgXWy4DnCs9A?=
 =?us-ascii?Q?ga9CXGDGA58rEcp9LHL/qy9adsYDe5b4gJ5oKx0ikiGz4QqJA6CoUqV9/yDC?=
 =?us-ascii?Q?YtewoIL5zHHnj09hzDR5DqQQgiilEyVGKbyjfoyjZtippcNCyTSrAISsDZqv?=
 =?us-ascii?Q?ceaePEqy9g2zlkOIROR4jE1t0Oh8tHBr1GepP4ObRzqVRLyu6Jhx75ksmVDu?=
 =?us-ascii?Q?HggkkzU3J/w+p8jwtn/iMYSXMyKjrX3QheE2Zo69GMb3ABG5G0nhPG11lWNg?=
 =?us-ascii?Q?su9yMDNmMyis0c2JsV1SI75axrMWu8LhzXadCULzULqAC38TsDc8it+FSZFN?=
 =?us-ascii?Q?YWSmr4X8bJ/jORfRp3HtoqQW/BcdqLH88k2Ljul8WYg1auhPetMHRexKw0Uu?=
 =?us-ascii?Q?PPBV17Ktx+uxr9JmYasJkhp2dvoiTXWrYSCocj5nwYuxVBC2qj/zPOUUWF1i?=
 =?us-ascii?Q?VckGsrovmqZNBUjrgDI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da4e355-95e2-4919-90a8-08db512b108c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 07:49:20.5669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrNUzqvheeXceHBtJ9RchUtSkZOuN7/Yn7LdCoaMBZgKXt61ufGVdibg1NYk+magYGVNxFE6a8+M7Z/5oowCMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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

After a search of the list,
https://lore.kernel.org/all/?q=3Dmodule_param

I still see many drivers are adding module_param.

Is this is strict ban that new platform driver should not add
module_param?

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
