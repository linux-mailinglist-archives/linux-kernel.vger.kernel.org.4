Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5B46C2B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCUHIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCUHIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:08:21 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805F99028;
        Tue, 21 Mar 2023 00:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgv60nJP97o/CeF3HxBObj4HiuI5PXhUcF6poo4jgbhrG7kqy9gIj5ZlX44NFF779pWeA9fXjN71dl8x4s+SnrhHRcg+Jf853FmTr13RguU+midNo2MQKQ5ydbd6pJOn2Iwo0qL70HamG/h15B2ICsFr/xtKGwpUV2JBlc+C7rkGcyjn00KPuI3LUQvgaL4AQJNIzUhZPwzTXV6V4w8cI3BgnzTKtXhFnNLZOodobVsfFIyyhniUBkAyeKC7Cl8gq4PzMN+KpePAlOPr1IVTI/wNlN4882vqCMhofcc/T38YFfp+CfIB1dq/57C3he19ljJvjOdwRVcjmrFTkbmzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+leO8vxYIDiILoYgUsvDWSUAXACUs5aoEP9n0fn1j64=;
 b=d6UP6jzIg434EnPODk4Qsj9KUTNCA0fJQjCVRhi5L54gITuv9EoorgsCoiwp9+K3K2MG+Dw5AuZtlwxEuHGN6UBVyz2K07cedwqcecyduEIReM5uXHqsqAoLEurAqKy3MJQ3FHVAqjDndvtPoYdDq3/st+lRonFYdIAAicloyGQDK/HfwMcLcCd21tkc6R/vleiq61+Z60b6enw3qs3L3k7MKvd4zYbJ3oB32sk4WdvO4pXP9Dm7Ygq5kypPnvx/tKGdbJPmFaOrZdL6M4aeRrZjR7YwLm/3aCQHAceD1Mxof/cHe2zySEORCoG6lBYgQjziyVkXRhu89hwU3ICsYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+leO8vxYIDiILoYgUsvDWSUAXACUs5aoEP9n0fn1j64=;
 b=FF3lt5TlMlglLyiLVXv+drnE/XneDAwodkP/F4MzEoSRZG9snHtdKvCJ3KhHDAn5SF/AhqWjvd//0umhhANp2ZZrPFX3no3KPa27BN0AjxCXT9/VjDYMNEXdvexvYoHOqh3MKPzLSdumlVSd7u98PCYDDCRaRGUh7h/Tw7m/PKc=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 07:08:15 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::c2c7:5798:7033:5f87]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::c2c7:5798:7033:5f87%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 07:08:15 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kim.phillips@freescale.com" <kim.phillips@freescale.com>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [EXT] [PATCH v2] crypto: caam: Clear some memory in
 instantiate_rng()
Thread-Topic: [EXT] [PATCH v2] crypto: caam: Clear some memory in
 instantiate_rng()
Thread-Index: AQHZW8K09e6A1RSc2UaITMBvYljIxq8E0CVg
Date:   Tue, 21 Mar 2023 07:08:14 +0000
Message-ID: <AM0PR04MB600410A6F69AB790A3646B6BE7819@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <41a7e41bb5a14f1e6e68a81c16c90e3ad4542ab1.1679381782.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <41a7e41bb5a14f1e6e68a81c16c90e3ad4542ab1.1679381782.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|PAXPR04MB9398:EE_
x-ms-office365-filtering-correlation-id: a91ee63b-8246-4076-b288-08db29db0a41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lTmz0bHd+VLUUj4cxUEqXat8T+7FDfJb8PKZfT4E8xWy7e7Cxd46UtwiqE6ewmylwULT8dZuHAF2u8jlqzity7bK83P6sQpHx1AYreSw/MTdUXnTpEOQn2VRchLiIxKnLDuWBKgxvBKkBU4X02tfIejOAseg7nT46SEqO+oO0pcUzkm65Lg0DFowHhvJjbznoKz+j0EEnfA07JnZ+EuJq1bnG5yBsg1pkaYkbyhv38BVVPCqX1Drcntx97qYgYLFS6g4x5vNwSpQ3n+q2hdayjQOsDk532S8O2mR8vvroD4VYVXBKqJ8Ymk2N6cAR/0p3F1xBuO+dP39xVQEsvcFswZNah27Dzk1eMgkkDd1TSKEG9lZuvQC/l34dZKI8jQ5I/s+sUqYrrC+qtJsv1fdzaSQPCx3gyUI2OKe1cEXRQmQKHoF5AnQg0QYYOguuRVhMOQPI5yuHhgM18aDKENFWbL0BMI5qcGCcB9PbmvCXPzCOJmWUaLCUS364x2Vkkrlqk0WDPB6n1JgLzoC1Rf/viducKzi78bS58OXmjR17Xx5z1F4jzdG71iyyUc2bAZc11JB/O/djFrf/MNipuSmx2CLUWe8B+VIrpo+XmWnmWu5Hj+wIDf2mb4oJfC9Jsthf0zuN30+ZDl/lWPpxb/fY6pA2bb5xGPkIklSmzCps51y/riAiRmNf23y/EGrP9KO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199018)(41300700001)(4326008)(8676002)(76116006)(64756008)(66556008)(66476007)(66446008)(38100700002)(66946007)(2906002)(52536014)(44832011)(55016003)(122000001)(8936002)(5660300002)(26005)(6506007)(38070700005)(53546011)(71200400001)(966005)(7696005)(33656002)(186003)(45080400002)(86362001)(83380400001)(9686003)(316002)(478600001)(54906003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bjTPIXUlyieLP4kyE36xfRy9XbgADU8gL+5mrA9EKL8vLCHZmQUFaLHI0arB?=
 =?us-ascii?Q?OdEEmcjib5Pl/bK4E7PgSiwxWrSemHDv8pZHFBjb1vvT40tRe5w8f5gZsADJ?=
 =?us-ascii?Q?vRX/Mb5/89X8HhPkZeP79PLecUCFQ+P/BGUCOyeu5fklsIOp4hM5ZmXjXC/O?=
 =?us-ascii?Q?HDhVdzvwS8XGzGcqBu/4DE5GEMLMqdbu/W4ewfrbesnZbB+pqp3Cytylu9QX?=
 =?us-ascii?Q?ebr/R3JHSUINoav991Bkuut0ljMhlTtPZc9keAUzk0C6hv+R5GcC/dCjFveB?=
 =?us-ascii?Q?IIXxbNK5ck+LGdTaP4CsFwcClLqKedXmKrR2F5DeQAhzj74lVdx+XmwE8Un4?=
 =?us-ascii?Q?92H1SlZTZ8XCKueWe5UaO2fQFXgUkOLpwCaBAwXNEsh+P7hQ/nYFycxFlMZt?=
 =?us-ascii?Q?mmO7RrARpYUKBqGfKw50VS8nrlb5NPStPZnjMdBGNKq24/1lfOUKbBMCGJTN?=
 =?us-ascii?Q?wfTrL+4ouneM1YQ1LHIqmsO3ivolFI6y3K36wEYjoYyZjh9gF2eJaNnNQa1t?=
 =?us-ascii?Q?eNUZpSiSGInEgFolS7Dep7RfGKT7iAA3ZAp76JGXtBlYsWY6oa+HVoNgkIcH?=
 =?us-ascii?Q?/lCDZjQMCK7xLWNh5uMVKLEXoDJpHIzia1oN6hwPA3iF1d+cLMtuhQJ09HCS?=
 =?us-ascii?Q?vk/YNsirQ/fqd5LinyLc8atX7pOCvYUP0V0MknGtzzgzqKLSqu7uW53Yuctn?=
 =?us-ascii?Q?scxnB5M9xNCLj9nyds0gnfQkRjwjBPsYw2evP+CQreoGIc9nwP/5GIW282E+?=
 =?us-ascii?Q?INN4AsPEazH1Y6hdtE6bhtEPwlW+l6op9kfmxJ/PNIUillggl3o0foVgAmgh?=
 =?us-ascii?Q?AKxOgY834i0uChgVZaUZdCgr2YNGI1oa+mbRQvHl7c4MeRRVkDJr36os61RW?=
 =?us-ascii?Q?aHll4Yn+tqNhjNUOlhSpJ4jA/H7j8C5hj4cMLNJlat0WOs/uwzd/jtMnEHkE?=
 =?us-ascii?Q?fFcGrohhnUw77XztMl7tUorn6qaxrTSN2Ul2kKNj7OzEkkC6qrDe345TKXxe?=
 =?us-ascii?Q?vovaHIzCsibdG9aL1FudMOpHZwryzG6KWaffWAx07avQovEisbtQND7QGDAc?=
 =?us-ascii?Q?YLX6Qe+YNxpkucFxCh4ee+O6nuo91X1E9l/hksRV1zW8szmSTzl0UfU5qVtp?=
 =?us-ascii?Q?Xuak6WA2dRX8MoLlmMM2SlzXXOUTHrBRCV6v+F6Dj7F/JPkWgFUpy3d0cG1B?=
 =?us-ascii?Q?MO6gvvgyz4Qr7MaKrQuetFbiR8r5vq0tywP7J6lG6SdOCUtDdoytTueFFIKO?=
 =?us-ascii?Q?zvKSqG4xC5y+kuhVqLEx5sXA6tNUqDLakwjfvcaPQJ2Zeu3sYOix0nZ7UbrE?=
 =?us-ascii?Q?v776v3KsL2uEVax0IC4TuwKUJmRCjyk+fsFbPlnp88PQ+/LnFDTsv3yIZooM?=
 =?us-ascii?Q?WrT+1pKWU4A5KS/Xo2iq3SiTOLepDKYEwKlXUHKX1OPhJbVfB53fIKNQ0fUQ?=
 =?us-ascii?Q?wCC/C03RcefNSHRbzCJ1bybJRB/DBqyYNI1aRMhBfluVWYsviP7tbbQHykjp?=
 =?us-ascii?Q?QlpgnEmc7QvJs4kvpvfIxyHOTPWPeKrvTrpuTowy5skEeHWREZvMJukLVREl?=
 =?us-ascii?Q?82sIrJ4vzdyGBX7BTKTZjRVACEDfjTFhv8UlRZGl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91ee63b-8246-4076-b288-08db29db0a41
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 07:08:14.9086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e3xA1wMOBk3zGtcskS2dYw+ZW14eTUs7I+ecNT84yxQa3uDu9ZpYQhuEI6IjJFv7FadHiZsKbyF0QMKtKFkegw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9398
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>

> -----Original Message-----
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Sent: Tuesday, March 21, 2023 12:30 PM
> To: Horia Geanta <horia.geanta@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> herbert@gondor.apana.org.au; davem@davemloft.net;
> kim.phillips@freescale.com
> Cc: linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org; kernel-
> janitors@vger.kernel.org; Christophe JAILLET <christophe.jaillet@wanadoo.=
fr>
> Subject: [EXT] [PATCH v2] crypto: caam: Clear some memory in
> instantiate_rng()
>=20
> Caution: EXT Email
>=20
> According to the comment at the end of the 'for' loop just a few lines be=
low,
> it looks needed to clear 'desc'.
>=20
> So it should also be cleared for the first iteration.
>=20
> Move the memset() to the beginning of the loop to be safe.
>=20
> Fixes: 281922a1d4f5 ("crypto: caam - add support for SEC v5.x RNG4")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v1 --> v2:
>    - move the memset() instead of doing s/kmalloc/kzalloc/
>    - adding a Fixes tag
>=20
> v1:
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Fall%2F16d6bf3bd7a6e96a8262fcd4680e3ccbb5a50478.16793558
> 49.git.christophe.jaillet%40wanadoo.fr%2F&data=3D05%7C01%7Cgaurav.jain%
> 40nxp.com%7Ca1c8a2f58318494a475008db29d9d586%7C686ea1d3bc2b4c6f
> a92cd99c5c301635%7C0%7C0%7C638149787790408570%7CUnknown%7CTW
> FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> VCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DUruZict6nLO%2FncETIzKtbI7wBET
> K7%2BfcAEzQyxcS5rU%3D&reserved=3D0
>=20
> For for loop has been introduceD in commit 1005bccd7a4a ("crypto: caam -
> enable instantiation of all RNG4 state handles"). But if 'desc' really ne=
eds to
> be cleared, the issue was there before (thus the Fixes tag in the commit =
log)
> ---
>  drivers/crypto/caam/ctrl.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c inde=
x
> 6278afb951c3..71b14269a997 100644
> --- a/drivers/crypto/caam/ctrl.c
> +++ b/drivers/crypto/caam/ctrl.c
> @@ -284,6 +284,10 @@ static int instantiate_rng(struct device *ctrldev, i=
nt
> state_handle_mask,
>                 const u32 rdsta_if =3D RDSTA_IF0 << sh_idx;
>                 const u32 rdsta_pr =3D RDSTA_PR0 << sh_idx;
>                 const u32 rdsta_mask =3D rdsta_if | rdsta_pr;
> +
> +               /* Clear the contents before using the descriptor */
> +               memset(desc, 0x00, CAAM_CMD_SZ * 7);
> +
>                 /*
>                  * If the corresponding bit is set, this state handle
>                  * was initialized by somebody else, so it's left alone.
> @@ -327,8 +331,6 @@ static int instantiate_rng(struct device *ctrldev, in=
t
> state_handle_mask,
>                 }
>=20
>                 dev_info(ctrldev, "Instantiated RNG4 SH%d\n", sh_idx);
> -               /* Clear the contents before recreating the descriptor */
> -               memset(desc, 0x00, CAAM_CMD_SZ * 7);
>         }
>=20
>         kfree(desc);
> --
> 2.32.0

