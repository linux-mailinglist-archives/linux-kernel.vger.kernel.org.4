Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A663973CEB9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 08:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjFYGjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 02:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjFYGja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 02:39:30 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2048.outbound.protection.outlook.com [40.107.105.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33568E48;
        Sat, 24 Jun 2023 23:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mg6ontY7Q7Mk2Enor+FBpCpur0oXTrF0mZDla21K8coVSgRDuT3pOZ6f6oqp1wlLmuVVanJk5PdMq4Sml7Xa08UyHkMWo4MZgiFt5dQ7p6IGrizlBvvBMZJngsNklWtSZ1ddi27/15rqxQpQaUUOyw29lykaLVNvw/17q4DE2aZyu3AllEs6jeFuFfTdyGf1ANJNqX6OkuCUb9BfHVu1Tyz4YnZBtpUdBboc9RuXHM7P6HLfMVDwLpaAXgqx3bFdRcr60iLMekeLyUMtzGc6JSeG7XCoz+TAsbNNd0LZUzycMj4RUFMYoMKo7fDR+axX0Ho57c7yIc6FDq/n/7Uvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnbtrdkaGMYVzD8xxGmEOdfwBZAW+qjyv0Z1mUCuZOc=;
 b=EICUDtUZsCeaZkUzf9fXlKlyGunY7tk9HXAnvI0BDose6+DymkjCkYoBAGQ+dnc4HtYEiVdQPDbpbALcPLFM0r59upLrnlrJ0dOVRsOpc4y1BSRgiljGLDRVTp7bYeKUR+Bjs4heUJDnCIhshuglfDxl3B+MvudQlRHLTKgeF/c8fFD6cl/R3Yv7W3Mq9JD0MXuklgG5Nni0soLPI9lNJH9RUJpk42JejXcwtL/doYR28U6sn5JmYjmVBe6oqCMHg+NpCHGSxWz5vUHJkpzO8qERX5p1GxFOSgt53Q2iqoHSpA9iecw6H9qUsynD2s68MTTP+4Q7d0uLLhwU7waTTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnbtrdkaGMYVzD8xxGmEOdfwBZAW+qjyv0Z1mUCuZOc=;
 b=o5J7MKThSQSfp/w/o6123ho9vRiXWGzkz4aNDQPeqRQWFBI0R/8qsS0H4+mYmw0gCjsiyIcFzo2PIZxQO6t/aRF3dYZHw0x6iZSHAZGu9l07alzIurShyX0gz2QAwhZmpbRJhyhSlqkaN24MIHMKcTsA464j5wpXp6j6mKldc9o=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8601.eurprd04.prod.outlook.com (2603:10a6:20b:438::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 06:39:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 06:39:25 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: Drop inclusion of unused header
 <soc/imx/timer.h>
Thread-Topic: [PATCH] clk: imx: Drop inclusion of unused header
 <soc/imx/timer.h>
Thread-Index: AQHZpaMedkhHZ3HAHE6EuqlG5Jyx46+bFCFg
Date:   Sun, 25 Jun 2023 06:39:25 +0000
Message-ID: <DU0PR04MB9417BDB41092A477CC025CA98821A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230623071948.3254789-1-arnd@kernel.org>
In-Reply-To: <20230623071948.3254789-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8601:EE_
x-ms-office365-filtering-correlation-id: 3dbe95d2-d890-43fc-bc4d-08db7546eb20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1YadYOJrRzjC6bagPD9IHD537kPu5LY/r1ziscSvEomRXf2x4AkeV2a9p45BfOue1VNESfEdJVngNGk9xhaa5/Jzsds/6oTO84SNrLM8UcNDlMYSZ+1uYE9XmeKQ10H3dYNOejtpKR8sX7EhEmEEFR5m4GrZLCF77fmMr+uly091ACB+IIvpW88rLPO90uMW8ZoB4G9d6O+LDkATe715TDU3FHh0dyx/UU4Rd81kUdfn76P2PZRp8bA21i5C5rHZcSI86so4uFKhfvU5wA5XjtKvj4nGtdx5Aj7UnM8pZygolpip9h8IY5jVsNBlSTF2o0cN/eeS8CtYuEVr/zLvSW4Aj3jHGsOKBskaNkW6qQh/dDmUC6troteuViwT5GaOQHWrp5Nx43Y2Q3PtJCGSYrOLj2giy2iR2iClwOGm0GSoorEFJPbJGz6uozjQnALCQ0jiSqNaDpkX+ofc0VcKAMEudksAaRjdmrltLTZ4eZTFMT+y8Y+47e/TZyDRj/1hby+Ad/icGHKGh12OyoktJDROAqOQT8B0JpBpDOec9VVkRB+bl/T5sIYhrCqV+ZeqHnxHd+FowwdGf3/6qdVuUYtyzTZ8VCN4w+idvcLRLzRMLiOHk2pF2eoHMmETtX6m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(966005)(478600001)(45080400002)(7696005)(71200400001)(54906003)(110136005)(83380400001)(26005)(9686003)(6506007)(186003)(2906002)(5660300002)(52536014)(44832011)(7416002)(33656002)(38100700002)(122000001)(76116006)(4326008)(66946007)(55016003)(316002)(86362001)(8936002)(8676002)(41300700001)(66556008)(64756008)(66476007)(38070700005)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LQQaba8HIWx90uXfFsVETUzObUAfh0yOufaKj2fd+yrZaKlQOS0RUOjyzP?=
 =?iso-8859-1?Q?5at0FwxUV+DRZnIJZtZ84PHWgfFDvU0IXxPqvN0Ren4fWe/O/iA/9VoBme?=
 =?iso-8859-1?Q?xknqwwzOYJ39B9LHQHU8RCLrHi/O93VIplXpqEwddz1KiDygFldjUNLTwZ?=
 =?iso-8859-1?Q?7SkTaLxsXkRD1aUGw9V6uFJxktkzNANahWddrv0gcpg4/83hnDA4JAcntC?=
 =?iso-8859-1?Q?fIrIzzSOWeobE5BFaMtSjv2hhfbVClQ2uuflX3YeBiAbwgZboksENJTmi3?=
 =?iso-8859-1?Q?FrK/8M3wLWeYuYU/GcxcHoyiSuCK2HfPdcoKB0lDNJCHPmROwCceKTun9n?=
 =?iso-8859-1?Q?RqjEyJWBdeck00DoPPVZY7B7uRhsMr97NKc0KW2xIHf1YUxCr8OedI7Ad6?=
 =?iso-8859-1?Q?xXeyskLBgJG6++1G/zQB0ZGbvvxdZgT/NTzYnRM+eARJZhGeiD37ZXvdWa?=
 =?iso-8859-1?Q?pytDZmzGRdDm9zf+gLLPPTGJpzVGek99dAxoAvpw/ZBri6/jaWAtYU1ze6?=
 =?iso-8859-1?Q?ye5nrcL0/0VYPjYr0iwpwgmx52Ptd7+wWUkClBNswz6sv/xQbTJe0+KS80?=
 =?iso-8859-1?Q?IYM+K3Gv4K6Mr5HLKsz18rdv+PyLm4QAZrADwEPnbOTQIv/UBDa2+VQRMo?=
 =?iso-8859-1?Q?msC0kDYEBDifxewa5nH0mphBInKdNRx2seF8DeS9AvuEk9sHZOB1ouBR0W?=
 =?iso-8859-1?Q?VfY0U41LFVLV/0oUH6Syv3vnLI+u/ITWA/4hkcYvzOVixKexpqHrRXkejP?=
 =?iso-8859-1?Q?w5FoYzzbwT2to2D18N30++0/oxTCAY7TYxSQ2wB8NIUvCsXQyVTAs9WaQB?=
 =?iso-8859-1?Q?CQrqD2TodhIZXFiwT0g2wNSd+qR16TD39QhEPs19XO1fZo/OMpcK7KDujK?=
 =?iso-8859-1?Q?keQnbAUr1ol3fLeTWaJuFLbtk8iuz3Prg7PfYnXWm3llRlVIAMELmwSb6p?=
 =?iso-8859-1?Q?qWqxctUhvddI19/7QkRF/9PeIntvmJ7PU8i7ZsP0Y3FeCyKhtJgTfKpa4u?=
 =?iso-8859-1?Q?E8yk8geRG+5a3yutghzqOYFgnzUFbY1TSvik4CYjyE3L9qI1eMBKuS7vYE?=
 =?iso-8859-1?Q?I7CTRHv4jXItgY44t3F052d+WXDap88015++eRAKzwO2X4fe4NzcWsSIci?=
 =?iso-8859-1?Q?JlqIqOS/xj8l0p+m0hBHsTk4rN0TMX85GM8FeZNZdfuHdgKbjvOE7GcHKu?=
 =?iso-8859-1?Q?cZ5/7BtF67Ccx6XwIC4Dw0Nkx/fEBXGKdXN5nX2lvXrHnFyFLJ3dCJLUlM?=
 =?iso-8859-1?Q?Wse/FvZ9Q6JISCuXAlhNFrSTrqBYV36aM0qkRAxsoDcQZWPFiyuGuFi/M0?=
 =?iso-8859-1?Q?hJusBkQnYK0qpWcpyii1pIsZoEzuCccBv2n7REqr89NwbyeG0OGZJEQ5Op?=
 =?iso-8859-1?Q?bpiHPh2zjVZUp/DD26htA+M2HMRfXFjxW6vsJFogGqCkvzCVP9/BvnUlxF?=
 =?iso-8859-1?Q?3HbWHSy2Kp+Lx6sCEwnbzW3F2crLCHIX46aKJslMngwtKRp9pu/n6bmczd?=
 =?iso-8859-1?Q?yXn8RQ8UZC/1X07HGvHv3ZxHiqLdp+4NfHoCfpxU68wO8rzy/UWELIQYm9?=
 =?iso-8859-1?Q?fOHwWkq/AogGhT7dsX319mqFtOoIXyIwK7ug+ouF6nL+NYihPr2rw/Nnfy?=
 =?iso-8859-1?Q?jAJKciWjfcAb8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbe95d2-d890-43fc-bc4d-08db7546eb20
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2023 06:39:25.5916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zkMzIW41bEFWf6NfJyAtSlfPABLlkzXWk26+T6n3Zc6vk+32G6p/pisfCBdTKodSk7xdJPVDj5Vo/zmX5yUvTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8601
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] clk: imx: Drop inclusion of unused header
> <soc/imx/timer.h>
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> After removing this header in the clocksource tree, the clk drivers no lo=
nger
> build:
>=20
> drivers/clk/imx/clk-imx1.c:13:10: fatal error: 'soc/imx/timer.h' file not=
 found
> drivers/clk/imx/clk-imx27.c:11:10: fatal error: 'soc/imx/timer.h' file no=
t
> found
>=20
> This patch was originally posted as part of a three-patch series, but onl=
y
> patches 1 and 3 got applied.
>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Fixes: 9e9d7570485d7 ("clocksource/drivers/imx-gpt: Fold <soc/imx/timer.h=
>
> into its only user")
> Link:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fall%2F20230328100531.879485-2-u.kleine-
> koenig%40pengutronix.de%2F&data=3D05%7C01%7Cpeng.fan%40nxp.com%7
> C0a6773bdefa4449eee7808db73ba4024%7C686ea1d3bc2b4c6fa92cd99c5c3
> 01635%7C0%7C0%7C638231016000018002%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C3000%7C%7C%7C&sdata=3DK5mxemLNLHcXR%2B5b1DwuZJH9X%2Fd%
> 2BTaZSQ7tZ8x8BqTk%3D&reserved=3D0
> Signed-off-by: "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Peng Fan <peng.fan@nxp.com>
