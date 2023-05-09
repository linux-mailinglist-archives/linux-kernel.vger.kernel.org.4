Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28236FC17F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjEIINk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbjEIINg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:13:36 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2119.outbound.protection.outlook.com [40.107.114.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDB22117;
        Tue,  9 May 2023 01:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SU766fLvwwXMx9zKrjhVneAIymGE3+5Gvc/ej+5x14ymCDYHYUq2on8TSD/5LYLLS/9JsRNL0g6t8hloCO40E2g0PoF/LyJa+gyhCEPbskYVQZjpYB5lP85N1jDh+74HTYY2hrkTkRaQauV1wg7JJThP59aiI4MU0m5CN2Uh9Qw8VUNsySuw8vxco+rwBSG5mp2yv3+UgTRyDuGKN5eH/T1aNO7qHRwUCMSIIwUa54OSrgs6aU3Dh8Q0P8z51p8BiH/KCVYiDVNM/JjZwbdh2E8QDUlvv7AIXwUa1Mp122RDSXzrNYrYw2d58/EHSdm/cd4C+WfThaOkUWHjM+D47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIJUwG0fTXWQP5ya3l9bB1lPCJLma7r0OpACfg5Odk0=;
 b=nwnp8iEcYfw3bqHlfYGywCamyNltc+It0/RnH285V1NTX7IUdiDKqHo2x3QcFTSJUips8gZuPD+6EBzbdSRvJwZ6jMw2dXzFWMWy0f5ZtzUbLXFnLY5KY61rr+hsB29pPc6KrKvjsZYZ0QuF/2uURT8/m8h/UwGzZ17RvO4ylc5rVwN+wzWdDZ1iU1BW9rzFkwfzWJkFIJEFZ+/e/88PPtA60Br2qe+/hIMb9fdNGZze1wSK6P4Y2efe3oMff3H0bbdU/m1V3OJAMxQcom6YwGQ0GUjDvf0Y0vLTR/nu7UG5k8oNcJHV4dPc/XjHG9C2wzby+GmZDujDylKALZ2QOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIJUwG0fTXWQP5ya3l9bB1lPCJLma7r0OpACfg5Odk0=;
 b=KAKdy18gou0bzwwe3w6Qn6PmyuZRmp6/j71te5d4ZOuCbOlriXkXdmS4RYBSHZtwjj76klVEfJ6xc2lmOhyDCMcI01c3Zd9i0/G73H3mJk+3h+qg3i0xOvUi6Fwu+m9hK6haof8p4VKgO13ewAmTNbaxZEuAFlfJsg2ZCjk89ko=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by OSYPR01MB5333.jpnprd01.prod.outlook.com (2603:1096:604:84::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 08:13:30 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::f687:2c30:bf97:7ca2]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::f687:2c30:bf97:7ca2%5]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 08:13:30 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
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
Thread-Index: AQHY79U/DwHbR6F/y0yl0C11fUlkPa5ADIuAgAMEP/CBDQLogIABbsaAgAE6CfA=
Date:   Tue, 9 May 2023 08:13:30 +0000
Message-ID: <TYWPR01MB8775789B33D4A13660017290C2769@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221103223956.50575-1-fabrizio.castro.jz@renesas.com>
 <20221103223956.50575-2-fabrizio.castro.jz@renesas.com>
 <20221115132811.GA4189373@roeck-us.net>
 <TYWPR01MB87753203F46FA9C744FEF7E6C2069@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <20230507153625.GA3135@www.linux-watchdog.org>
 <7d3b2991-f755-42e5-87ca-727fd8fb9164@roeck-us.net>
In-Reply-To: <7d3b2991-f755-42e5-87ca-727fd8fb9164@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|OSYPR01MB5333:EE_
x-ms-office365-filtering-correlation-id: 377793bf-fe93-47d3-c9b8-08db50654643
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Edf3pXCNogUx54wvscsjFjck4nhUNxdGVPlqGhpPSGiYpwp0KTFIXchv4k9HKaFJw6ep5BOdVqupCEYUAmZ9knuDQ1t47dLoDRglMnv0PGyRkvZ9qFLSAOciKyBMe6hyvhunZ5NkXTSHoMx1ZV+Lgm4BCMcMrFjCSr7BmHc0zk7OO35PwXaA6zUW716s4alTSpDdjeLr/k2hi4RXGp7wzbce54cz9v4ltaJuYxGwCO1ylmHTFYECwHxCVF7UVDJ4SX6+fbSD0NOUvMkMCndKT6IOUl40gJ0/L72DUDAy6dSolmwVZq/nJovI+FcwPVwKvlKit8i17uxgseWuJ44+X9jZjCaXhbmtXRmOkIsdLCs9OVljDxRvc3bZOJeNA36VdthqvFtVuC3IpI9pbpzn3+WNgTf6+Ei5T2MCmV7WBKeCF/NJGG6AHYr7adsYo3nyc5J8VNcAJOe8EFm836KsAr2SNBMoAvvSculHunElz8ICWskoIcGCeoeyKRM0H6xZIJp2orGdkmZkl7OpC2UGf6p1x2Ri6EmrBjJMoF7JbLA1r9pnDv/nsSanblbkeglikdDgZPr1oPJ2jx+1QR819MG4SXwXaelFqoBZjZh2tMJobnkMjoW7saSHiw3jEknQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(76116006)(66946007)(478600001)(66476007)(64756008)(66556008)(66446008)(7696005)(4326008)(316002)(110136005)(54906003)(86362001)(33656002)(71200400001)(83380400001)(53546011)(9686003)(6506007)(26005)(8676002)(8936002)(5660300002)(52536014)(41300700001)(7416002)(55016003)(2906002)(186003)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gfMc7x6mFhp7actay2HP9mm//YTUEjY1vK2XEZH5J3Wv92CqTNYysD/GxzSA?=
 =?us-ascii?Q?PhCCon+tkPY+8wiPYjsEyuPF/nSnOToUya8/m3aqhLSFj/3NI/8AiPm3QozD?=
 =?us-ascii?Q?am/vz9pDgeJCNAkqr2d9BR8N4RsaX1usxbVCri9qK4H9AWKfD2FveRMTUoFE?=
 =?us-ascii?Q?+Wd1V4C81/vjGny7WngPjRbGuWHeERxXUiPUDwNTQyHcK+4ctk8l/A4CFrSV?=
 =?us-ascii?Q?g6b0SH8V26mIxkb1mzcXNmX/32H0rpMBes55I8+cEyERq5zH6BjzDNsuWgys?=
 =?us-ascii?Q?s27l07wtjrdsjdPuv4iPRHF3rAwWZ4ebQC9gdDq3mwRjeXM2vRTOIVpE5R7p?=
 =?us-ascii?Q?H/gqwP+bNqTNW0nzutkspthOP1muq83GiS5/sp2mYpPICDyme8MHm8vHyf23?=
 =?us-ascii?Q?vaUEFu4rPvC1nJzCzEGFfNEA3sB+ggbbfhhdgz+ddc9sIfmph8PqEBdtpXRg?=
 =?us-ascii?Q?fh7V17tUlqWzZPAxqM0ir3hBEMw10Suai4nSTwV+eQM2ahZu5WYEWyxPr4mP?=
 =?us-ascii?Q?4Q7xoMpe6Qc9FuzHkwMTTFmDdrSFmiqWz9UuqohdduoQbnJ0gy6yfcoX2m7r?=
 =?us-ascii?Q?XkZF+x3Xkn3p4SBh2hvxRQr0zK/JSNK75X/4dLOpVzraDj/RCJtcvdM1KMtq?=
 =?us-ascii?Q?I4526o3Za94YVljEp+irtxKMh3yH6yACW/SP1eKocyLbBGo5MwfBPsUNrriA?=
 =?us-ascii?Q?8LmCNnG66eSgBsZEOZhNFTSgpUEav6B34ra/7Gx4ZDRJ/oAboFJZ9RrrpvBN?=
 =?us-ascii?Q?u9IjF19LnYqAfuE9LKSU7GScjFu/Lp2/snQXZturk7LLtQxMbzoDgXdjvJlT?=
 =?us-ascii?Q?+/zb6zjbFXSuMnJiG1ZoLSowXe3BrvShu5ZBHcANeyXn9kXpTeOdqm325T0Z?=
 =?us-ascii?Q?XNlD5pYEDhWUzBQwDdHUtrqMC1bws4CvLfD+V5ztQ0gCgfw0o8i5j9gwyF5E?=
 =?us-ascii?Q?EGcBiRH3VAafsbPM++CxnFeQlt6y/462k2wc9aefic6UOSGd7jY81UtQIWUj?=
 =?us-ascii?Q?XWaOZTfdYrh59DZEG0s+p1TaWsnQibo6BXxwMNfF7oW/p4hmt8QefoNFy/Hg?=
 =?us-ascii?Q?4StxM1cZS2cWbG/LKyJcP0sjWRl0nc9bCzqE+H1NSk6PESlL+HgNIM1vqyiw?=
 =?us-ascii?Q?RS4HXjzNOhTXcPRum0vLQhog4TF4U9s5+4lOQKgLXjTcqe9hgCbl2l2IYRWX?=
 =?us-ascii?Q?0aYtzJLs2Nekns5rVxX/admkgWLLS5YZNsQCcZsWN7a5jJdxaYnVQPvEE5OP?=
 =?us-ascii?Q?Jh+Vv0UVbwVAHscJBPuXHtFsa2SawMsiKt6/ypuLOW0oTMbdBvauZzxGZ/gz?=
 =?us-ascii?Q?KiMhupWZ44oRqnRiunrNUivz+AqI6netsdjyoE0NWtRys++l/gkCvj1bm0b1?=
 =?us-ascii?Q?All0Zc+FkedYo1dRqB6ErctEl05bp1SCZLM1DyOmeQ3ceZY3UyaRB7PCuj2W?=
 =?us-ascii?Q?P7xu4oPOg0lvv1QPIZn5ccpM6xVH151LzxQdQJDjQ8JdQN+PNHXRl03yYSJA?=
 =?us-ascii?Q?BQLl3DrtgupCeGlEMvjsjXT/MZDVxKEJzL1S+C46h6BXiWjeNtqHDWK2IaZ7?=
 =?us-ascii?Q?TGO+Oxo2Vl2IWAxvkzC4Iz/SOFQkY2LeAbRV0QO1Bn0lKLG5z1Yl4YOM27HG?=
 =?us-ascii?Q?Ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377793bf-fe93-47d3-c9b8-08db50654643
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 08:13:30.3472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vbV00OzaNc3CkMEAtFQAti1DH789eH6aWKCZXTQevPzaIlCeiJXxyhPcYR0fQKPtXCHuk355CgJQtD1CY6cjVi95TaTAopn7K7p04lF7pr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5333
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Guenter.

Fab

> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Subject: Re: [PATCH 1/3] watchdog: rzg2l_wdt: Fix reboot for RZ/V2M
>=20
> On Sun, May 07, 2023 at 05:36:25PM +0200, Wim Van Sebroeck wrote:
> > Hi Fabrizio,
> >
> > Based on below e-mail I excluded this patch from the merge window.
> > I saw that Guenter still has it in his branch.
>=20
> Thanks for the note. I'll drop it.
>=20
> Guenter
>=20
> > So can we have an update on this please?
> >
> > Thanks in advance,
> > Wim.
> >
> > > Hi Geert and Guenter,
> > >
> > > Thank you for your reviews!
> > >
> > > As it turns out, the rzg2l_wdt driver has some reset related
> issues
> > > (currently not addressed by the driver) for the RZ/V2M and RZ/Five
> > > SoCs. More specifically to this patch, there is a better way to
> fix
> > > the restart callback by addressing the way the reset is handled
> > > for the watchdog IP.
> > >
> > > I am dropping this patch, and I'll send out a series to address
> > > the above concerns (which will tackle the issues with the restart
> > > callback in a better way).
> > >
> > >
> > > Thanks,
> > > Fab
> > >
> > >
> > > > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter
> Roeck
> > > > Sent: 15 November 2022 13:28
> > > > Subject: Re: [PATCH 1/3] watchdog: rzg2l_wdt: Fix reboot for
> RZ/V2M
> > > >
> > > > On Thu, Nov 03, 2022 at 10:39:54PM +0000, Fabrizio Castro wrote:
> > > > > The setting for the RZ/V2M watchdog cannot be changed once
> > > > > the watchdog has been enabled, unless the IP gets reset.
> > > > > The current implementation of the restart callback assumes
> > > > > that the watchdog is not enabled, but that's not always the
> > > > > case, and it leads to longer than necessary reboot times if
> > > > > the watchdog is already running.
> > > > >
> > > > > Always reset the RZ/V2M watchdog first, so that we can always
> > > > > restart quickly.
> > > > >
> > > > > Fixes: ec122fd94eeb ("watchdog: rzg2l_wdt: Add rzv2m support")
> > > > > Signed-off-by: Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>
> > > >
> > > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > >
> > > > > ---
> > > > >  drivers/watchdog/rzg2l_wdt.c | 11 ++++++++---
> > > > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/watchdog/rzg2l_wdt.c
> b/drivers/watchdog/rzg2l_wdt.c
> > > > > index 974a4194a8fd..00438ceed17a 100644
> > > > > --- a/drivers/watchdog/rzg2l_wdt.c
> > > > > +++ b/drivers/watchdog/rzg2l_wdt.c
> > > > > @@ -145,10 +145,10 @@ static int rzg2l_wdt_restart(struct
> > > > watchdog_device *wdev,
> > > > >  {
> > > > >  	struct rzg2l_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> > > > >
> > > > > -	clk_prepare_enable(priv->pclk);
> > > > > -	clk_prepare_enable(priv->osc_clk);
> > > > > -
> > > > >  	if (priv->devtype =3D=3D WDT_RZG2L) {
> > > > > +		clk_prepare_enable(priv->pclk);
> > > > > +		clk_prepare_enable(priv->osc_clk);
> > > > > +
> > > > >  		/* Generate Reset (WDTRSTB) Signal on parity error */
> > > > >  		rzg2l_wdt_write(priv, 0, PECR);
> > > > >
> > > > > @@ -157,6 +157,11 @@ static int rzg2l_wdt_restart(struct
> watchdog_device
> > > > *wdev,
> > > > >  	} else {
> > > > >  		/* RZ/V2M doesn't have parity error registers */
> > > > >
> > > > > +		reset_control_reset(priv->rstc);
> > > > > +
> > > > > +		clk_prepare_enable(priv->pclk);
> > > > > +		clk_prepare_enable(priv->osc_clk);
> > > > > +
> > > > >  		wdev->timeout =3D 0;
> > > > >
> > > > >  		/* Initialize time out */
> > > > > --
> > > > > 2.34.1
> > > > >
