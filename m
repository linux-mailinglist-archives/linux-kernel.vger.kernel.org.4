Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7540628878
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbiKNSmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiKNSmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:42:23 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2135.outbound.protection.outlook.com [40.107.114.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B4723BDE;
        Mon, 14 Nov 2022 10:42:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeFaw4mqG25FgY+S5ll8F65I24r+cIEzC+VgZ1pryDD9OQH5kW4hvjeS2BH7JV2EOzDAoFopIBwkx/9QG5p/7oa3r/m67Et/m0fykNf01omTqTdnMQnwCIqaL3wxHSDzoP7qGDGXnxGnrbzKqj/70TboZHbO2ODMpiUF3xgXb06cuOc6QgmC2NTDMYlSvP/i8SjJ1lK5NjkkEwZwwawoAhbOiLVXSLHrAzsREh2rcu1IUNIJdX9FpqeSU6LMJmQ3S7qr6SkGfGKRmdDIgcfQ4ybe9wqO5IzbjKJkXg8g13x95LqX2ecTKx7kSlMc/VKF1imx3flN0GTQX37cxnfjaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Y1FzjSXP00zDYmzjbqIHtVy6Tx4fOnxqd3f6/yXZ2E=;
 b=P11akwrP8wNkDP1lP8eXFfozFgIqOJ0k1Ix1xkkDGoHWr1SZ1/LO012Bbw4VUMunDPX4qCMvc2hpQ+x8wd49AKVJNbZz+99EQzhlizTK0IixjGbc7Z1N5AEVBEFDDtJIXmgLsPGKlglBAT3KfKRrPm05wGsWrEHc1g85Q0uP27jyb06aiXLDxolVQwt3rn8aS2cN7vGnbLqozM4pNky9yuEIyUc2svESYazIxq7giynC4JqYDBK6W0VvTFWIFJqpu0bx17CYTi+ESSGXVU3VHzJI+VdkhZhm8z+oVmojul2gnCmdhIF9D3vaEzIf0qtQh/HGh+vs+rqqjkzkabenNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Y1FzjSXP00zDYmzjbqIHtVy6Tx4fOnxqd3f6/yXZ2E=;
 b=iVobLkK9KpirSETYK1X7fNGFtTsH3hm3JgVdiF0p2FRvHbRiBdB+dCAFTdp5LYEmEpotJpa5t4ntqxpzZS4rk8F2+f/o0Xzaa7VEY3krgfoHYL0dlB736wWd6lycLfzLyk5nNmMd/VzZcLuw4ge7ddX7BL1yBCYpmo3Y1x0t1yE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB5466.jpnprd01.prod.outlook.com (2603:1096:404:803b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 18:42:20 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5813.018; Mon, 14 Nov 2022
 18:42:18 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put the PM
 clocks
Thread-Topic: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put the PM
 clocks
Thread-Index: AQHY+FQ3i7+8G/jXAEWaK/AAUJtKua4+wHcg
Date:   Mon, 14 Nov 2022 18:42:18 +0000
Message-ID: <OS0PR01MB5922DDCE24ED6F6DD44B4B3F86059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221114180843.1125308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221114180843.1125308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB5466:EE_
x-ms-office365-filtering-correlation-id: 47a44ddd-71b8-4cfc-2718-08dac66ff524
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sEWnpd4GJKiyvTpQNAiIKQD0kxsJ0tN7tQhtDOBiQe2ceay7QW/mUB5GYo6BM4tbmdZT7gnaZlCG5LDMPmcw9AiXnvjcqpo9x5M3HSLtWNceo10oeaLVDRYA4Wv2IjvtUkcwkWPoKUPorQK09J167GoJXMWLnoxBZoaNOGimN1yIyKf+2EUjJx4I93buuLyVbfnXR7N9YVVEXZVZ4y/CWhBfb3ymsc4m8rKIs8OlpqwmOntPVCorwF256bQIKrtyBs9V0dPuNFj8dz9NXsKLKaQVdFNemLajG3WodGv5VD8L3Xd7Fbu3WaQEE82R9VdHKDLrdVcnunHV03Hx6z1JJ+xfKcel0iF36oN261RQBEDmJ9mPUhmb2gCep3l/8xYWqhmrs/6ia1d1d2vfyPZjFmTH5590l/rfPvrSh9UDXC8B7EiJJvfV2WrhXchb0/1gLX70q7p19QcuNvStF2WRNyQ1HbeaKm0ugmEUIPJ+B7xWBagzuEtD3wni7w1u1stgyDySBImUS1LMMz1aW4WLYD8Lc1HjVlZoTlwcQBYweiQQvT9sF/fGYfyzcQvNHko0Madhsh47A/dwnnBuz9Hxawm+Hx5Iz5GYzzng8HKHNlvCqXFAzKf/NDUwt5sp00zF9Wo45p13tfuLfPCJkwB5e3zjAZ6YWras0EUB+GETpM5akEKAD9+nS7YzOJ2qdjdAmcuwdvMdWYOyfiKzt5q1T40P3c2KZqkYkxtuknXBd1lqI4dNkqZm9KW7SKmuL2MCUEWvcbF9u6HokAVQeak2bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199015)(55016003)(64756008)(66946007)(9686003)(76116006)(66446008)(66556008)(66476007)(26005)(8676002)(4326008)(8936002)(186003)(52536014)(5660300002)(41300700001)(316002)(122000001)(53546011)(33656002)(38100700002)(86362001)(83380400001)(2906002)(38070700005)(6506007)(478600001)(107886003)(71200400001)(7696005)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ap5rfgmRKO/TKPtHSySdTas5cgA3YINaBLGUN5zB3gpnc09NqeYkgKk9U0Ga?=
 =?us-ascii?Q?Qf4BSiriwMkO94c/Ws3Rhrs+9sx3WFfGG1tazDBcLHtkEB29qnu6tqRVywO6?=
 =?us-ascii?Q?f7wVb9gHwMa7m89ag9A2LGly/D5XjpFlISkhHmalT6Y/c7/AdWTHIUhMsTxU?=
 =?us-ascii?Q?b+CZE6RcHZvVV5GHVn3AvsLrevQ60+GmZksYgzF5rg2TR/91JnsL4hwx3rDQ?=
 =?us-ascii?Q?TdWtGmIAYpnUEbyheghSVK2Fr5WfoDGM8OsN/rNrtiFMx/JGuwJhK4XZKJwF?=
 =?us-ascii?Q?BCjMEGD0h1YKZlWbZ6npoLfyGKdi+WS4Eh3Y+MeLD+871Msw+RRBNvfmM25+?=
 =?us-ascii?Q?mUyfebJcub81W9rogLtu/qx9jfWfcxHQFoCBYMv2G+IyjTupvDe2Tvmbd04u?=
 =?us-ascii?Q?Eikf2pr1UP5GMdTyWdx5pg6JkUoFrL4tU4dBiZguB4SQ/cba9mb+An6fukxf?=
 =?us-ascii?Q?y7yDYHwDkNoSbLwryYdFzQOdtK1qIUYrRFVqPHBDYcQq8JZ4HhRGo+0otrri?=
 =?us-ascii?Q?yLqa7CLONlNUghLf6V/PDRsYzK0AHqxLsBMi5AqdmIdu/fMbYjHPDUCqFPZr?=
 =?us-ascii?Q?MvBUzFmb2nEpMUK9NS55H/N8QlGLXnFgsss/Yoy+pCL86eI93bLq/LN0YEMO?=
 =?us-ascii?Q?1H0FCXsbApa8KL0ko5D6UTGOuNzoP0iBYCwQojGo0HVqOrD0xU4dhePbVnVT?=
 =?us-ascii?Q?r0Rjp3NiFaQ083Fe93Ez3diRUl3WMWb5CRtQZg5RHf6+lqwXyHfV5+Fr9sAb?=
 =?us-ascii?Q?xmSPlKJ6qDjQFZHvumxZkht9CTgrQRgYCG7Z5+CBNIKYfQsZDoLz8h1JkR6Y?=
 =?us-ascii?Q?qLKOl8mGMeQH2NjP/jS3bMiNRmO9Na162wE5d5HHcXrTZopZNgkIdu3MFr8R?=
 =?us-ascii?Q?sY0V6dFFsTKnaqiyBbaWyOzzrHv3twvgS4pccEcDkLpta8ZbZvk3cnKkCwIt?=
 =?us-ascii?Q?p8++cmvLkAQ27mbN+lA1xZtuuGC+BUxjirENjZ8upHWeIZfPVRySfZb2L5lM?=
 =?us-ascii?Q?cKEhYlnYVMWnhE+4AQJ+Ls45tI0rjLVo66VFJX73TzwU7UT862zqtEV/UWee?=
 =?us-ascii?Q?Ak40Vc6dVPLCdtXAOiFiRljBDlB8L/ih3QkpcS90WjYcoDlF7UXVv/49X5sf?=
 =?us-ascii?Q?DgoWer7BVUiSnWtIow8rlI1qE1vVRSjVIvroAapxIXz9oxoce4vmmZTywpEF?=
 =?us-ascii?Q?hnmyZtOB+xlfYyRu+rsyqszrF0+Y55lvhcFq/LNR3Ot5+ia7uVgdviYDsRCd?=
 =?us-ascii?Q?WjSAcrSgIMhEL0hm0foHKDwToDjp637U6Jp6aKgtI0J14RPgErEIWCTwxjiS?=
 =?us-ascii?Q?x5ex59EEK0Uef6Z5RlV9GUfMB4/DAeJghLHsJpSPksw7W4s+57HR9B6SHnfq?=
 =?us-ascii?Q?Gfp7gN54FPCMspJLrq/LPOGWOzx/LsMA0X/7d5zv+/FA4cpYvcTjmulRHIiK?=
 =?us-ascii?Q?SLnekNhVagA+91T6zk1WRQpdi925yH1kgYcHlwDfDF9Vce32WJkQh0bXe7UN?=
 =?us-ascii?Q?QMCi1RNTH3wro2s29UOmYEK5j5Seuv1oszVfwFxzcidSVauSiWS4RfElZ8ik?=
 =?us-ascii?Q?NAXC9UotLF9fNKP4KsNb1vkXdUceq9FHK+f7EQ/N1sgj/gvq3JOZIXpR95Wr?=
 =?us-ascii?Q?Zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a44ddd-71b8-4cfc-2718-08dac66ff524
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 18:42:18.2178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h9UAESrcU4QvocAMv1CSghNKH7GOufPGgUp8Jt993zPFMSbY++CiDaa03428G9YXRqNTCEcYVyNEvmBf539tDrExHKe7RLVG2L8RSucfsek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5466
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Prabhakar <prabhakar.csengg@gmail.com>
> Sent: 14 November 2022 18:09
> To: Geert Uytterhoeven <geert+renesas@glider.be>; Wim Van Sebroeck
> <wim@linux-watchdog.org>; Guenter Roeck <linux@roeck-us.net>; Philipp Zab=
el
> <p.zabel@pengutronix.de>; linux-watchdog@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-renesas-soc@vger.kernel.org;
> Prabhakar <prabhakar.csengg@gmail.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>; Prabhakar Mahadev Lad <prabhakar.mahade=
v-
> lad.rj@bp.renesas.com>
> Subject: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put the PM
> clocks
>=20
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> On RZ/Five SoC it was observed that setting timeout (to say 1 sec) wouldn=
't
> reset the system. To fix this we make sure we issue a reset before puttin=
g
> the PM clocks to make sure the registers have been cleared.
>=20
> While at it re-used rzg2l_wdt_stop() in rzg2l_wdt_set_timeout() as we wer=
e
> calling the same functions here.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Note,
> - This patch has been tested on RZ/G2L, RZ/V2M and RZ/Five.
> - My initial investigation showed adding the delay after
> pm_runtime_get_sync()
>   also fixed this issue.
> - Do I need add the fixes tag ? what should be the operation PUT-
> >RESET/RESET->PUT?

It looks like timing issue, None of the previous devices are affected by th=
is.

>   in case we need the tag is:
>   Fixes: 4055ee81009e6 ("watchdog: rzg2l_wdt: Add set_timeout callback")
> ---
>  drivers/watchdog/rzg2l_wdt.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> index 00438ceed17a..d1271cc7750f 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -115,16 +115,14 @@ static int rzg2l_wdt_stop(struct watchdog_device *w=
dev)
> {
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
> @@ -132,8 +130,7 @@ static int rzg2l_wdt_set_timeout(struct watchdog_devi=
ce
> *wdev, unsigned int time
>  	 * register so that it is updated with new timeout values.
>  	 */


Maybe update the comment above with new code change.

Cheers,
Biju

>  	if (watchdog_active(wdev)) {
> -		pm_runtime_put(wdev->parent);
> -		reset_control_reset(priv->rstc);
> +		rzg2l_wdt_stop(wdev);
>  		rzg2l_wdt_start(wdev);
>  	}
>=20
> --
> 2.25.1

