Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4249368E957
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjBHHwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBHHwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:52:15 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2107.outbound.protection.outlook.com [40.107.255.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1936EBD;
        Tue,  7 Feb 2023 23:52:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsQScuTckuqqrfMWgYKQBRhaI9AsCDAe5aywNlMR1259B0Mm8VZ7ADb0Jgcq2bpx2CIB4QYgv5BssgOhOlSD3sZ/4QqTV1OiliDzLO6hfXf8b0B+vioeywiPBHlHNNnJ9Nigp4A8eoXhrGj/TTldmnmmGVMSwpluVA/m223MDBNFrJrgdUEnVLM9QGvKRnTa/f2HrKIMSngc9WVaQJ8J728uIdCV62ZHtUERhlDehxwCGXX72+Nd1pbbxhqOkkwYWlSE0pIJuTXPrMSpPpl8y6m86rkteq4RppbjJz78woZmnyG4bmmMgsLjrMee8o4LUlU2lbB/cZrNbnBC5oJwNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGx077sAU1rhf8KZlIh2aK4qze+uFVjdpWYpD1jIzX8=;
 b=dy//MrvjdV0QxFftTSbQq/S0G8rCooH7sfmGHt3XRf5Hgj95qm63ALtZhFVUZOo+UMhk4ibRSjvkivF/F27Jwigo+Y5dAfSfMCEsaFZ1WiBa5nGVVRv0mF2XIqrOhO1Gq561JSpTMm76XZ8tmSV1qk8RNntpQmJN/57Pk+e5qsfdxWWHI/wOsiSJkwVesl1YkLwoVT8ilFUUN4PwGHQTPZOUOyOLX7Bbcd/nNfGFixZcuc/XwmunhTPqV3M2YB0/Br0rSuQVUDBoyx8YfKT454cuwa61DBCFUYpS+Vt73ocsAINcGlCPDmnYMIAxAIwzPSmnYci0cbnMwpzfb67pSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGx077sAU1rhf8KZlIh2aK4qze+uFVjdpWYpD1jIzX8=;
 b=j53IUplbrm4ZsNWvavl60aZeWT5H0et+9ZnNsVqfGfYFydnDkyIk+YDhWYkpoPVncK1uuCPaEFceXNUGMcfVPzvVp+vDnuhyFfkxIV+6Njj5DLVvNKXnN/UM4lKiQw5jNVLqol2bzltcoWNEQHmOJ0lOmYazwnul/KUSVnaZC1E=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB7850.jpnprd01.prod.outlook.com (2603:1096:604:177::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Wed, 8 Feb
 2023 07:52:07 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%7]) with mapi id 15.20.6064.035; Wed, 8 Feb 2023
 07:52:06 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: RE: [PATCH 1/2] watchdog: rzg2l_wdt: Issue a reset before we put the
 PM clocks
Thread-Topic: [PATCH 1/2] watchdog: rzg2l_wdt: Issue a reset before we put the
 PM clocks
Thread-Index: AQHY+nqlN8PVH6kQBUuXev2WjyIal67FLjeA
Date:   Wed, 8 Feb 2023 07:52:06 +0000
Message-ID: <OS0PR01MB5922D6BBEF769694B8846A7086D89@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221117114907.138583-1-fabrizio.castro.jz@renesas.com>
 <20221117114907.138583-2-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20221117114907.138583-2-fabrizio.castro.jz@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB7850:EE_
x-ms-office365-filtering-correlation-id: 86af9f97-9e8e-4cb9-6ac8-08db09a95fe2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Ok1IFGDQ5qtHgtzwpFu++tJzpB2A/HUiepSW1HF/QDdKGKSWbaYJT10kB6/1AEdu85SM6RNO4jmSoZisBlBqcOfd7Rg7SIMLuLF4yZLAw+j7Cq5LQb4Tqt55ibLcRKiqEq8azi5gQgvwuhwJWpGtT+u3Vzq7+p/LWbmX/nzag7AzY6030EDgSmx5SVT8JZqhRs9wNKWlToOEv0rCY9nwnGPJrwTu28GCLLF4QnW5ynsmPvSR2CII3loYrc6q6aPgCrk8Diib+tsz80BoID76FypeI/YBuqIfGn5EKYDPC7gbcLUCXUHVsaG0J30N64DKR8tv5i5qXfuC2fdpaYfbEW85gU4B/d7isU7jaxXYeb1UKOxf2oFIUMXPYvIhW36I8Ua/YJNpKIzBRmYVwrHHcHwsVUiejGNzcNrw8AfuYHlCXOAvxXHdVpSswCnkxUz7auO1EsvGRhR9EwpZkE1ct+EFhqTUBcipA22jURLLX0JwvL2P+OF2yrCQcEYZgOOkIL7+wRfFpTRYnu8nbZUAhgcQ/5rMeSQVmequEuRgMlvFNuP8HW9pEkLsNVHeKCX7M6BFDn+LCKI0THihDEGVVztS/Sdy2tR5EXlAVu3raAUSZUzDUJ9C9MAfxX5BWjQNnC5Yc/f3qwZc3YLFR+xB/lCihssKikPCh+zcSRYOGVKfcAG7t+eAZt5WcCI/IifRuZF7cC4dHI11klUuS5UHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199018)(7696005)(38100700002)(122000001)(71200400001)(316002)(54906003)(86362001)(110136005)(478600001)(41300700001)(38070700005)(83380400001)(2906002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(5660300002)(33656002)(8936002)(52536014)(55016003)(9686003)(26005)(6506007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DagTCLA9MxVYRjM0+bWv7fciEY2gCrv5Gdq4R2uzk7PZyw+qjwSbOXpjfDvo?=
 =?us-ascii?Q?6TWs/v+VHoRBJaG/AvyH01EEYhMBZjR5yMA4/gjrP3/GfZX9Mq/R+X+zAxiQ?=
 =?us-ascii?Q?R8ul3uLZz4XqRx5PQcPQ7HQfXqIDnoDgQvyHwZlhPrGz1UtRDNcGYf/q+TVq?=
 =?us-ascii?Q?Cr8qroFrZcgEs7jAkODCO6uA9Kn9/anqC4/0culLsWyYoqp5+Tm0uxtC+Mca?=
 =?us-ascii?Q?ewZ9aZKEnowIf/en1ZZWgwIvWTMczHkgp9VlxIsglxQURwmL9h8OiSjf8BaS?=
 =?us-ascii?Q?rXyBbO4Ej6dTQn7q1IIemval9TBBEZhP4Tydios1b18rGFz/68xXKh06iv9G?=
 =?us-ascii?Q?YupFgN/MjV8Pt3u4L9ptYp8q0iPYMB/K/VpVSwNsPZSegrloBtE2pQYmv9O4?=
 =?us-ascii?Q?akGv6d91cGcKnMvCLxMCFn483ni6D6sRtVNtU+rpD6nAdSvs/479VH/Xz6Ha?=
 =?us-ascii?Q?LPiwDgnoaJ5jecJ82v7AIrLL57ZYrBXn/nFnvY4UOY4qRHQH1/5J11AdTQrh?=
 =?us-ascii?Q?DfclTbs2OCsm2n/0Cpajw+GwXPhCVFYyFC3prNOcGNWK1iCadPJUzMbdoVSu?=
 =?us-ascii?Q?BD3c0H4uNHSMNxrCVXbUlLW5/n49DMo7zQS+lGIGV3FFq8Dcr61PG8NFACrj?=
 =?us-ascii?Q?MknmtKICVGTIvWxvaJlnVYloYOJZZ+U6HOwLl9jC/Qfa+7yjomt/Yp1bSuhv?=
 =?us-ascii?Q?CEc1jO0/jd9XeHIbXJ46pqG1BleLSE/Flir3S/wf/5h76lxv0ye/MwUrMTNu?=
 =?us-ascii?Q?3/biANFva/jwHBg6mc1HWheIC/c0nJUqcwvPJOLWdckMTgR49Pb/sF/v/et8?=
 =?us-ascii?Q?HIGWOIcBDM31Is2vGnpig9ALROIO0ljjw2JclDg0RuByYOwk0aC918JXWImm?=
 =?us-ascii?Q?7iDiSBV7w3ut+OcfAoCNaoMBT0PUSGXYhA3aSbRU4JCcP3xrvrUMETM9J3fs?=
 =?us-ascii?Q?nkBUs97NvEAawX+EoTHoGZLEY0EGsbVy6n6dkSIHIwcoGDb88x8QSbleg2Gh?=
 =?us-ascii?Q?1fYdTYOPmHG4Ou5/+G3p6BJkoYPnS0MV3wafDoCfercmAZFGjHcbLCuDKDgZ?=
 =?us-ascii?Q?5tyfpK/vu74nJCyTv96m6IEcwkLtGyWFVNgN+mb7rjBvRg1VEAvdabJyrKiO?=
 =?us-ascii?Q?0stylbVtnZjRAsYmmfXVFJogHxm6fW1NXss+FccMufcMBwcMHaLFzeweWJe3?=
 =?us-ascii?Q?l5FScOP1OeaFYYvHTXZLEVuoY9ubFKQpXRvkSwhGnf2jfgF+a+SugyDP7p6a?=
 =?us-ascii?Q?78SvZ61Iussyo7exb1tGUXdRROiF1zBHn2cu4wmHemdx32ixjfbCVa9RPBd+?=
 =?us-ascii?Q?Zf1Q0QzdAmWsv3Qrz6i50sMDX5oJmZQ3/3Kngpvys03M5YZe+DjAT8qAMkNP?=
 =?us-ascii?Q?qDpenktTHN+lUQ6W65Yr5oFOxVxk/iRPAo/J4QZuF6Cc8DiI9XV4jLFn5ibC?=
 =?us-ascii?Q?0zg6eLL84puL0sLpyPlQu8YhULl9vUXYLw+VwmQ4SZkEIlGrXf9+iE4Mlzis?=
 =?us-ascii?Q?mK9zSGDRtYw8opIpzPuPJUxcXyBPvE7mnnkvejuEdowrVckZ39Xh8WvEPSby?=
 =?us-ascii?Q?mgRlJ07FthrGmjh+gDmu8Y/GkEWBZXWqHOvmw0oPknW+EKY19LQyNY1lLwQQ?=
 =?us-ascii?Q?aA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86af9f97-9e8e-4cb9-6ac8-08db09a95fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 07:52:06.5229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4e8suEt7U1cv7ETdpW8E+JD35ZcBnda1oRUnkwvRK8tGxPU/2UJKB8l5IadWH2icwUS6KkHzLbtY3hX72qU+E9h54SZD6qj1VMlSstVo4j4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7850
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

Thanks for the patch.

> Subject: [PATCH 1/2] watchdog: rzg2l_wdt: Issue a reset before we put the=
 PM
> clocks
>=20
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> On RZ/Five SoC it was observed that setting timeout (to say 1 sec) wouldn=
't
> reset the system.
>=20
> The procedure described in the HW manual (Procedure for Activating Module=
s)
> for activating the target module states we need to start supply of the cl=
ock
> module before applying the reset signal. This patch makes sure we follow =
the
> same procedure to clear the registers of the WDT module, fixing the issue=
s
> seen on RZ/Five SoC.
>=20
> While at it re-used rzg2l_wdt_stop() in rzg2l_wdt_set_timeout() as it has
> the same function calls.
>=20
> Fixes: 4055ee81009e ("watchdog: rzg2l_wdt: Add set_timeout callback")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

> ---
>  drivers/watchdog/rzg2l_wdt.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> index 974a4194a8fd..ceca42db0837 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -115,25 +115,23 @@ static int rzg2l_wdt_stop(struct watchdog_device
> *wdev)  {
>  	struct rzg2l_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
>=20
> -	pm_runtime_put(wdev->parent);
>  	reset_control_reset(priv->rstc);
> +	pm_runtime_put(wdev->parent);
>=20
>  	return 0;
>  }
>=20
>  static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned =
int
> timeout)  {
> -	struct rzg2l_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> -
>  	wdev->timeout =3D timeout;
>=20
>  	/*
>  	 * If the watchdog is active, reset the module for updating the WDTSET
> -	 * register so that it is updated with new timeout values.
> +	 * register by calling rzg2l_wdt_stop() (which internally calls
> reset_control_reset()
> +	 * to reset the module) so that it is updated with new timeout values.
>  	 */
>  	if (watchdog_active(wdev)) {
> -		pm_runtime_put(wdev->parent);
> -		reset_control_reset(priv->rstc);
> +		rzg2l_wdt_stop(wdev);
>  		rzg2l_wdt_start(wdev);
>  	}
>=20
> --
> 2.34.1

