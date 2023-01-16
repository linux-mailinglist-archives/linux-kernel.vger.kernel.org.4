Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5748F66C3F5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjAPPcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjAPPc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:32:27 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2104.outbound.protection.outlook.com [40.107.114.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0045723C7B;
        Mon, 16 Jan 2023 07:28:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEFlcSZF+KSe+6ahu9dqNlp0GYR0AGSr/Xf5Gi0kzVyAHHRjC8BsNf4l7iqAi+tET4AEPBtrypMzHffC/pkrx3G0/jvO34CqqzcJJAB19SJJfVMuANV5u/H8hJHsOUXK1/8+/O+iNkDKo7EbuShjgMWh+hqB8tJMq72N5ihwe0aSz6LcNt8kFhNUn2VHQ3i1rVfi08pKx3jxOve96tKKNO8EhgjKjceDSyDPzwsZNJcAgXZWT6qKrhlsv4VrqyAB9eGtM726kRl8eOHe6hInw6t1rd7roST+9KELQyMhs9YJQlNDqTQiAcxE6VWHTnPJf1uXGBBraqmge2VN61zXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRjwtj6a28AZV9ac2d6DqzYm1P4TTM6xG0MCZ+GmqQY=;
 b=H55X7g2w0ZFZm1sTz7xpBm2fspdFjVsN0g9aKgoBuIHKlH37qIoVrYaVV8KcTJU8nFDSXudtHP6hGk6ZEGz3YfR7Y/oW2UHjd23BeMmQ8O2DMssJZyjY2dV31Jt9HxRsK9DFJd/9zb96TnmeaRAKr1S2Xn2WiRz/HTXnpqdwIRlIVHR5z6+t5UPM6VXcNeqiZovIZ8W/PZmg0wJf0CrrkQsBp8Mpf1V0qYUHMvOJjwUikjjV6JhoFif0hUvDGeKmcQNpW8v2561qjuitxu3zIf8Z0Nnm1xc3XwJl1bjMLH5mBRwIS30pnwe5pQyTjiRkm2GRsI78eSBd0cSVfuQL2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRjwtj6a28AZV9ac2d6DqzYm1P4TTM6xG0MCZ+GmqQY=;
 b=TsYSnU9Cjonf0E12nuEgldQX01kj8ZxLOOEa8E6c4VsXG7+I0T0MCUmrVejJ+bhpIqTOaDiVKcHc9N6Vq9//H8K51kRcI1VpM8uaKNT+eJv2OAENx8Fx4jyB3STsDkI0EBPA4QcJ0wEt5Gs2olPbfqDiYPoXZObdHDBE+xDgFsI=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by OSZPR01MB7841.jpnprd01.prod.outlook.com (2603:1096:604:1b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Mon, 16 Jan
 2023 15:28:16 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%3]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 15:28:16 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: RE: [PATCH 1/2] watchdog: rzg2l_wdt: Issue a reset before we put the
 PM clocks
Thread-Topic: [PATCH 1/2] watchdog: rzg2l_wdt: Issue a reset before we put the
 PM clocks
Thread-Index: AQHY+nqlXRu/6yqD8kG6N6RyQH2tma6hiOYw
Date:   Mon, 16 Jan 2023 15:28:16 +0000
Message-ID: <TYWPR01MB8775AD226DC8128F3B353AEDC2C19@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221117114907.138583-1-fabrizio.castro.jz@renesas.com>
 <20221117114907.138583-2-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20221117114907.138583-2-fabrizio.castro.jz@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|OSZPR01MB7841:EE_
x-ms-office365-filtering-correlation-id: 5f4dc40c-f2b4-47b9-8dff-08daf7d64a49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FQsFlypiiix1S8YABvQBLJIsdinb1BgvYhm22rZkAbX0n8XU1ZzTztpQXhonnQeEsmlgyA2tWD7x7mhDVi/RouOcwmBaMSyvrH1O6hdWEBw5gvfjQXizcbZLbJEEPnX0x+XYkA5LKC9BNyuuF+pGQ8CXdlz96Ij/q7uKBUmrFf+zuvPChJ9hl77Vm1lr4ZdVYIdvgG2nmtw1aIhAfzgAkyUkbPNGU1e7JWqI83iG926mm+CWCxqIv8kJfN6PlmoqCvzXbEazkavoPjpHdd3lQ31zA5wD/JoO3GVAzKDejkHOZGp92YZ68SgMKKUixEhH1u4j/J/+ff93PInERhzfP1yBek5310yH1QXpF2CWNRKYwRC3pOfOjh/b5UYQ0hPjnD5QGeoJIIwlh5L+83cWhnx173rV9nZTjl1s1HcIM0HZJM49cMbPcnI2YJyLdPoQ/A46lbxA14L0v48BhWlhNj2eLJcX9Mcj9hYTvb0U1jEFxLFUXDhvq4GM0dj2VjEn+9hE76Bc7xqhyk0i+mJhKYQBDhIAv+WtT70lD5KVzRbbG9rSDD7kja392D1T/ZVD/1WlnrVnp3VHGTQdoirskqXQHjq2/0efyEkDj9KI/tWSkotmw2c5S7EashGxzaEU/mH24ljFWZsC8VgcrUqMnZFixnQn6bCd3bp3+Xelb3QlHHJptK5cdm0il6qNlEu3jLkKvVqwUBd+hV3cZfFeFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199015)(6506007)(5660300002)(2906002)(76116006)(64756008)(66446008)(8676002)(8936002)(52536014)(122000001)(83380400001)(66476007)(66556008)(38100700002)(478600001)(4326008)(33656002)(41300700001)(38070700005)(66946007)(26005)(9686003)(86362001)(186003)(55016003)(7696005)(71200400001)(54906003)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qi5u+/xlS+ewjcdtPHynggjrhE1qs9HxL6JtrHwljaIHm7MPeNtzw7SvwrW+?=
 =?us-ascii?Q?khnA7J7WGRjGwPdcYVF+mAO5nuV9URbntCYRQ+EO8wB/MylDDxgTCHXpFC7W?=
 =?us-ascii?Q?JiIU3lkorGw3dtJhL+DffBgsT3q/TbV/VZLHfTKmoLyczV85TClJmUBAAt/H?=
 =?us-ascii?Q?eKD2JSF5EZB2FmPoGpMF+nhCgRUGbM25X6WTJMTH61CPojdUt0ubP+T/t0mw?=
 =?us-ascii?Q?5IIRkctiv++/0ugNkn5NvP+iE1OGl8CGw6kMc92KV36aPW8l/qGwzVqbRpEJ?=
 =?us-ascii?Q?M6BK2ePdQ2T89eoaYigbEekG01dCmINoVAmOeF6INR5UcEEwMRa/LuEWYpj/?=
 =?us-ascii?Q?JMsaAL+/k5pQ1lM9htzK4SU5K+a1vu82zK3Q8gEX5H0s0qX8J+e8YZfqRIFW?=
 =?us-ascii?Q?Q6i2As1shDW4imVqHo4mi1iAATboxgpkiaPlg1kUkk+3KwevK/q0L2VKAkGO?=
 =?us-ascii?Q?7yvSavO+ZGNPqYwNLOlceN7FY2EZkR6d2A2iIAofq7uE78YhCjDrh3PhzN+M?=
 =?us-ascii?Q?6+Ee61WdsbyOG2M11XqPxUe0vsexgCG9yEI2aHqXUC9fXTmIKBOHg06LFsFk?=
 =?us-ascii?Q?Cl+Z0QFzC/ck5AExfmz691mesNfF3iCAA8aRW+v9LB2l6SWjGVwR1P4La44J?=
 =?us-ascii?Q?sNmVm7OUICF8q9cFVIvc5n+Zq6BPnxfKw47UJcSWYZx0eMtJ5pkwuJId49bX?=
 =?us-ascii?Q?5qkCp/8He9BJXbP6FXZxPKssaa/Nb+wesGPiZyolWX+hyj3ZQNTDvTENK3nS?=
 =?us-ascii?Q?nL1qq6XsKhaXr6QSv5nWEUQJisjCB9rZVX7Ihq762n21YrC6cclx5lHBlF/M?=
 =?us-ascii?Q?f7EaU28e7uB1PwWhwx487n6yktii0bucECbDKPELu+oIdOiQ8A81XutKoKsX?=
 =?us-ascii?Q?THMb84dgMhaXF3ltc0LxTZ0Gyhn26hWhpDBONiJ9Nrsgmh9fduk+FwELXnWQ?=
 =?us-ascii?Q?g+/itogmvf3nnHIGYwv1Aw4eOOIFkbHUE4tGDp4xuwRE+1658Z9N1Qqj44/T?=
 =?us-ascii?Q?YL+hKdUkmSfrMg+Neml9RhyL7Fr8nMevLxTxzzWYokHTfMWkrE4/xs2VeVBe?=
 =?us-ascii?Q?tS+6depPalZjk6sLhlFINrvEdM2hWVkcjssTaKomMV1kVAFbpY9GBkMaGp/g?=
 =?us-ascii?Q?EIfU5aSQalEFfiy6LfaWJLwdhZyxYivx4tGLY57hdmZVEAQDOJUK9reXqFPn?=
 =?us-ascii?Q?zNhIiExmrUvQZpy7IvQJbRRKehtiWg7QfQo2nHce2VBy4fH9J12xJ+sS0U+q?=
 =?us-ascii?Q?dnqTYhUIgP9hZKrZOi3JgaajNXT6kBs+G+evTFSCIhK0eHL2N/o8giZNeCCV?=
 =?us-ascii?Q?jaJ7wnqunEIj/DAp770UV1KplVSfMBcEFUyWM5QSCuPQMRVNDdUZ24qoWasM?=
 =?us-ascii?Q?x0ZhaLd72GroESZHuOetWAgt3Lpjglp/XBaoDKUMFaG3tKd8BtnXcgJnF6R4?=
 =?us-ascii?Q?9Lsmf3kCgxuGzR9yP0RzuwiWh++80bMR/wQxgPlRFwPlQl6vC7UtZPWLJHJv?=
 =?us-ascii?Q?GqNFbhDaIOiyFqLEZeWasFjjCmPpVM1arNNzbjZ0ulMD5vN4eQa6QyCqmVUh?=
 =?us-ascii?Q?9Hh9DNx/b7x4AA/O8xegGKeZGR3RNuYnHE0llqqWD5jC2d9gVNYb0GmDbzrq?=
 =?us-ascii?Q?jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4dc40c-f2b4-47b9-8dff-08daf7d64a49
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 15:28:16.7430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H0UYvD7mIsoqVXkvck272cYlXeeNrjYuPvdwASq3G4fSuQZ2F3V0fp/3aQorxsd8sa/hkLX0XI24dbeizVIakM3tYX1khsriaVyYKXaSLE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7841
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

It looks like this patch has been reviewed by both Guenter Roeck
and Geert Uytterhoeven, any chance that it can be taken for v6.3?

Thanks,
Fab

>=20
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> On RZ/Five SoC it was observed that setting timeout (to say 1 sec)
> wouldn't
> reset the system.
>=20
> The procedure described in the HW manual (Procedure for Activating
> Modules)
> for activating the target module states we need to start supply of the
> clock module before applying the reset signal. This patch makes sure we
> follow the same procedure to clear the registers of the WDT module, fixin=
g
> the issues seen on RZ/Five SoC.
>=20
> While at it re-used rzg2l_wdt_stop() in rzg2l_wdt_set_timeout() as it has
> the same function calls.
>=20
> Fixes: 4055ee81009e ("watchdog: rzg2l_wdt: Add set_timeout callback")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/watchdog/rzg2l_wdt.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> index 974a4194a8fd..ceca42db0837 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -115,25 +115,23 @@ static int rzg2l_wdt_stop(struct watchdog_device
> *wdev)
>  {
>  	struct rzg2l_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
>=20
> -	pm_runtime_put(wdev->parent);
>  	reset_control_reset(priv->rstc);
> +	pm_runtime_put(wdev->parent);
>=20
>  	return 0;
>  }
>=20
>  static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned
> int timeout)
>  {
> -	struct rzg2l_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> -
>  	wdev->timeout =3D timeout;
>=20
>  	/*
>  	 * If the watchdog is active, reset the module for updating the
> WDTSET
> -	 * register so that it is updated with new timeout values.
> +	 * register by calling rzg2l_wdt_stop() (which internally calls
> reset_control_reset()
> +	 * to reset the module) so that it is updated with new timeout
> values.
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

