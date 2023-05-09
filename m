Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497DE6FC171
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjEIINF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEIIND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:13:03 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2096.outbound.protection.outlook.com [40.107.113.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8527798;
        Tue,  9 May 2023 01:13:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmUO2W3qKRrHLlyCC3qebcDcMABxo8qeMtP/cdzSPT92BUfAAgEOL8SfkLhYW3736zvohY8X1GDQPBSVdbZmqhphVV6z1Xomj2lhn8ytzm6AG51g0ge6QOmiOnXwPwo6OM6GT8atQRkJEDMoUr3f7QtSAw84oC5pQEEeQuC6kdokXTd/YA3ZONhQiOyzc+SSEm5HKNBmpLkpQ5oZAxw/6anoYAIU69qR6BxoqWewhZvW/asvvf8wISZaHs7EjAxYQOwApPU4eXzGBZyj4yNvU/QULJrtzh0wr0hHPHkvQRoX6UGe/cKaOfVNuUIeAu57/lFia9LHhH7C9MrTomlFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NB0gL/65mv34IF3eF9pSbjOJ6vMwFEVn8s2ZRYANquw=;
 b=Rrq2pBeEfdEwPtWboya8dCxmAl2AGAvImb4ZkbsiqJpI47khPtEZ+GokrAfMNQ+hECn3PcQ7ObS60Pn4BWaRSv+DDfLJQcbhWJEuQYKhxJoFZrVZ6oKiYGNAkkNmOqceg+B5AWaUbGuN/aJZhlyN+x2b2XprUZPjz5cvwitye5lPC43MZGM+6fhTyWOAYP1JOljaUDNm8cXbMVf7VATrmcuaJxa3YAmIR9Nm84aOQtSo2v58uiq3gkodSWEuIRVeHYhT0B7nsfhu/cVKkJn2S98ejv++tOZvd8dp1Xtehoxus1avSIDoAHLzMBvRXqyEBt+UXXaWL5pG/7BUXKsZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NB0gL/65mv34IF3eF9pSbjOJ6vMwFEVn8s2ZRYANquw=;
 b=AZSPneMHuL6Epw3VYm3L47R6g3/0wqwp4K4GDYyJiWgpq2Z3zCeYMgEGUQdA8AePrD61LsnTdITdPeg7icrx0Wrbp/MDJ7cx/FY496UIcTNwUjGMBqG0Kq2GAjvWfBjF5d5BblA571tigtOD4keI4ZCy3lhpQ0ku7+Qz64vuMIk=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYCPR01MB11449.jpnprd01.prod.outlook.com (2603:1096:400:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 08:12:57 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::f687:2c30:bf97:7ca2]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::f687:2c30:bf97:7ca2%5]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 08:12:57 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: RE: [PATCH 1/3] watchdog: rzg2l_wdt: Fix reboot for RZ/V2M
Thread-Topic: [PATCH 1/3] watchdog: rzg2l_wdt: Fix reboot for RZ/V2M
Thread-Index: AQHY79U/DwHbR6F/y0yl0C11fUlkPa5ADIuAgAMEP/CBDQLogIACpVbw
Date:   Tue, 9 May 2023 08:12:57 +0000
Message-ID: <TYWPR01MB877515B62E4610EEDAD4759CC2769@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221103223956.50575-1-fabrizio.castro.jz@renesas.com>
 <20221103223956.50575-2-fabrizio.castro.jz@renesas.com>
 <20221115132811.GA4189373@roeck-us.net>
 <TYWPR01MB87753203F46FA9C744FEF7E6C2069@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <20230507153625.GA3135@www.linux-watchdog.org>
In-Reply-To: <20230507153625.GA3135@www.linux-watchdog.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYCPR01MB11449:EE_
x-ms-office365-filtering-correlation-id: 38dcf6c5-a049-4c6f-ac2f-08db506532d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m3rd9yg7CEysUXYgnQyNmufzn+kIze4vKAwwox9ya3oFZdL0kr0j4/hrh81No7hoGUakEr16ND3QqTDk4EzhzOzDEd7ZjXSpmYhGCshAjgzre9zA16PePRYY68tPvDQ/BuT8oUnUIq0K0WZJqz7WrdPEUDxm6YmCH2KUuaLvbTGjv5dm70579iUkAj/UtFOm0QmELJY2DqjDEJj8iF118odYvHRyPkbRVQil6dCBO0QlS3r1P23bXgJkIRmMsuPmQK3EQQaUPXgmrKG33/ysYQb/rlYY0hJMnj/jMetnDYE4KuDLb9omtliLS1+ocFD0sLmAol6dEXOsHFDeBWy1bVpFq8OLiaqZ8AcxHcwm/16uhgbMxdBt4bOvKB8VgyuxPFUKDLidmP8AuCcJesCeKCusZN3mjbVJU07gzg6sY6XYGrwUQ2m8a1c7//Vs4cFIBh0de1hV1hX0ZqLXvb7MKumM4Eq8VN4X+UjGIAf0Xb3EJlS2reXpakrKiepnAPPJugeLTC2hdsZhb0NoDK4zAtYlbHhheMJspVUPLCOsPV0XzFTu2BVvtsZ6RqZMgQZN2DOJbdbHP4KKb+1EFOSWYLI7cFxYoYfZCaeNqe+aW7o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(966005)(86362001)(54906003)(110136005)(316002)(71200400001)(38070700005)(7696005)(66446008)(41300700001)(76116006)(66476007)(66946007)(64756008)(66556008)(4326008)(8936002)(52536014)(5660300002)(8676002)(478600001)(7416002)(53546011)(33656002)(9686003)(6506007)(26005)(2906002)(186003)(122000001)(38100700002)(55016003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zBNFkRIuwcg17JvuL2G8Lzjjs+JvbqtqMUCRkrGF5w5Unc+LUEzGOp1D+cm2?=
 =?us-ascii?Q?NgB7kgKcRkQ5VO7fo2J3FBvjhxLPKdR0fR7aQbSQSYjtJ9sxgxNHcMFOt+lj?=
 =?us-ascii?Q?bEI3ZCSQPHOgWRN6UPJALynDu2qdFbLyGzWtUpn3F4uTimSvNVlfe0ciGdRr?=
 =?us-ascii?Q?DTgE3pd0mVgqzgdiNWnwPh6YgyCxCcuf0GUAIFxXDHkYFvAwYLOgN3CPRvWP?=
 =?us-ascii?Q?Frys5a27ml38onzrUNsBJHtwCObF1yUbqwDmJF3urYTNunwkRsqgD1jvmiJc?=
 =?us-ascii?Q?Bu2FK6kvNh5jcy2SXBWQ0qJGyvLPVWioOZDE8OUxlB3Vx9GIpvPAcnGLQHtG?=
 =?us-ascii?Q?HFBc5znwGu8Fv8wAPGNV+1mX8qzBGzOcX3NnGzSTL/hTNX8BUAeA7MAzNrNq?=
 =?us-ascii?Q?69pjbxMq7/UdxPVO3Ay8El6qZs96qXh4O7n3tJKPyqXFfq0qIhzkfxxcRWGX?=
 =?us-ascii?Q?7tBhf4Uh934qOdzghCqwNNY/lt0gGtdCO8ekdc7d3qL4fNIOD6MqtQTGgcMQ?=
 =?us-ascii?Q?ebaKW0OXHFTF0iD5FpglMwEbGDaJg9yXWkpxLDxvWHC8yMROTJ9GbG9GgA+P?=
 =?us-ascii?Q?puxFiEYO0KjG/YIOamH9e1xEzzoue04Qua+3H/8lbzIEhF8hQAWiaoNGdCGP?=
 =?us-ascii?Q?Ou49Ml3LYczEt2+ZUnKhSX0Tn6f/pHsdNqmKRc28CV9gyEqdqXFoOXs12HWy?=
 =?us-ascii?Q?firngVkEOHgLJFJ5VsFHj7VbKab217fRZqY+scK9JNEE0Oj/7GKz6e3QFYqc?=
 =?us-ascii?Q?nKpXNtYpSXmaojbWvCy8Y6zEQbWp8NBKGGMfW0KYVKIC8wLC5t7/vfoMcCXs?=
 =?us-ascii?Q?M1mrlFtNE4sViC/SEFT2ZmHm7XSmUbvmnYgDaePLbMzcQZ8is6QExxZpPa4i?=
 =?us-ascii?Q?KPcjfdh60/WsZYfp+1X4qrgBY6HYtRHyBIQCx5kWUqVHnr0MNByMY+ZwMQ+m?=
 =?us-ascii?Q?HZ0fKRXdSu0/KYocglYMF32kYg4a6SaDy/+Q8GTFnatP3XR/szCHXJvfPVLF?=
 =?us-ascii?Q?pQSg0G7ua2JvkSMMDftIk2e8N89syVLEM/c0VnKgXSxVcmOI0z2I14IM7TrO?=
 =?us-ascii?Q?FAQGKWE46ZMLfk0Yy2JZLTiWDzdyLR4esMqd309msP8883B7nM3WrrxAcqfg?=
 =?us-ascii?Q?MizE+Rm2bq6RsUbSLA+CGOnghSjqAv92bUmujOJ5Q6rI3ELuUnH4tvGTXsQO?=
 =?us-ascii?Q?f0uxr89vTHZZE1ZDtEdb0YZ6Z1NFxnR/IB3JOnrz9Ld7zWr8zTxcBdSIet59?=
 =?us-ascii?Q?co68pkCAKHhtM6N4WFwLOhxD+J/oG+8BIj2cgBEo3jfKUwSKUyZnpsF7x1iR?=
 =?us-ascii?Q?Qp2Av28dBMVCKGr/mtMcTLmJztMLRccbqLEtNdxU6tDhGtPYp99LIfU8FUgD?=
 =?us-ascii?Q?i7TInydJqErQR2Lnt37FazPN6lV9MAecmLENgUY5K4AVqagnlaQHm7pYP5x1?=
 =?us-ascii?Q?TbUpWA9pRZCZSRIa8UZuIjGajMIJR9sEd8aUVRhgnCpYCd3ITzn8viV7kdY2?=
 =?us-ascii?Q?aUqphR+tpdFBkETg9zGAi8Ng0IleBU2DVbHfqJ8vYwN05UhI7157bZDuDZmH?=
 =?us-ascii?Q?wvkmUxE9R/cIkfiYYKlji1hBU+zlYLGhNpjGCblL0I+YwDDwETyiOZjle///?=
 =?us-ascii?Q?SQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38dcf6c5-a049-4c6f-ac2f-08db506532d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 08:12:57.8085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/fh8/LHJoZetrHQONrvGv89IyltqsUOUx65ijqq8hFo+PvwkvIghlah3rT/Hj2OL9Q561mZuXGb6FnmtrGxOzYIlmHnojiQi8EAKRQlGDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11449
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wim,

Thanks for checking on this.

This patch was superseded by:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Df769f97917c1e756e12ff042a93f6e3167254b5b=20

Therefore, the right thing to do is to get rid of this patch.

Thanks,
Fab

> From: Wim Van Sebroeck <wim@linux-watchdog.org>
> Subject: Re: [PATCH 1/3] watchdog: rzg2l_wdt: Fix reboot for RZ/V2M
>=20
> Hi Fabrizio,
>=20
> Based on below e-mail I excluded this patch from the merge window.
> I saw that Guenter still has it in his branch.
> So can we have an update on this please?
>=20
> Thanks in advance,
> Wim.
>=20
> > Hi Geert and Guenter,
> >
> > Thank you for your reviews!
> >
> > As it turns out, the rzg2l_wdt driver has some reset related issues
> > (currently not addressed by the driver) for the RZ/V2M and RZ/Five
> > SoCs. More specifically to this patch, there is a better way to fix
> > the restart callback by addressing the way the reset is handled
> > for the watchdog IP.
> >
> > I am dropping this patch, and I'll send out a series to address
> > the above concerns (which will tackle the issues with the restart
> > callback in a better way).
> >
> >
> > Thanks,
> > Fab
> >
> >
> > > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> > > Sent: 15 November 2022 13:28
> > > Subject: Re: [PATCH 1/3] watchdog: rzg2l_wdt: Fix reboot for
> RZ/V2M
> > >
> > > On Thu, Nov 03, 2022 at 10:39:54PM +0000, Fabrizio Castro wrote:
> > > > The setting for the RZ/V2M watchdog cannot be changed once
> > > > the watchdog has been enabled, unless the IP gets reset.
> > > > The current implementation of the restart callback assumes
> > > > that the watchdog is not enabled, but that's not always the
> > > > case, and it leads to longer than necessary reboot times if
> > > > the watchdog is already running.
> > > >
> > > > Always reset the RZ/V2M watchdog first, so that we can always
> > > > restart quickly.
> > > >
> > > > Fixes: ec122fd94eeb ("watchdog: rzg2l_wdt: Add rzv2m support")
> > > > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > >
> > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > >
> > > > ---
> > > >  drivers/watchdog/rzg2l_wdt.c | 11 ++++++++---
> > > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/watchdog/rzg2l_wdt.c
> b/drivers/watchdog/rzg2l_wdt.c
> > > > index 974a4194a8fd..00438ceed17a 100644
> > > > --- a/drivers/watchdog/rzg2l_wdt.c
> > > > +++ b/drivers/watchdog/rzg2l_wdt.c
> > > > @@ -145,10 +145,10 @@ static int rzg2l_wdt_restart(struct
> > > watchdog_device *wdev,
> > > >  {
> > > >  	struct rzg2l_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> > > >
> > > > -	clk_prepare_enable(priv->pclk);
> > > > -	clk_prepare_enable(priv->osc_clk);
> > > > -
> > > >  	if (priv->devtype =3D=3D WDT_RZG2L) {
> > > > +		clk_prepare_enable(priv->pclk);
> > > > +		clk_prepare_enable(priv->osc_clk);
> > > > +
> > > >  		/* Generate Reset (WDTRSTB) Signal on parity error */
> > > >  		rzg2l_wdt_write(priv, 0, PECR);
> > > >
> > > > @@ -157,6 +157,11 @@ static int rzg2l_wdt_restart(struct
> watchdog_device
> > > *wdev,
> > > >  	} else {
> > > >  		/* RZ/V2M doesn't have parity error registers */
> > > >
> > > > +		reset_control_reset(priv->rstc);
> > > > +
> > > > +		clk_prepare_enable(priv->pclk);
> > > > +		clk_prepare_enable(priv->osc_clk);
> > > > +
> > > >  		wdev->timeout =3D 0;
> > > >
> > > >  		/* Initialize time out */
> > > > --
> > > > 2.34.1
> > > >
