Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5E474FC41
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 02:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjGLAj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 20:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjGLAj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 20:39:56 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2086.outbound.protection.outlook.com [40.107.6.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700C899;
        Tue, 11 Jul 2023 17:39:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+zFAA9pCksPb/KCMgFJFZHfcKXof12yoU7tjuw/OPhYQzvKKhn7GKu4ulnkvQMxyDHjrYC2SfP3sKxz/5RaOw2OyNXMdCOcjzs6OcV06A5xXpQCBPamGXpW1zlgGXnbv8q6IjnjGiEw+zKXl29Ys6dfsISRzzRhuY5waqDDm+RV8mQvNJxgdRfbxGAezUpLkvqE6yXMP43tYMCY6rsWenzOzQA0SGJd8bE7vDMPhUDb55/Hf7qrwedPC+uexf3jszsOHI+A4avbkBTucoNezSzU2dpLf2FL7rrycaQzq4lQk0fWyUW3OkZqlq7Dz9aDMjv5Uu9J29ycKTsQ+49Myg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DG0MRFtOUfqUYcYR6bUfTVPbBf60Z/twTr9QRNrYDaw=;
 b=A7RFtbYpKCtwnn7EZXEEAe5F1F+f+w+X0tFuY1+uVVFbaF0HxbOcDzsh2kIkMFSvaKpK6l6A0nKv7Erl/ata0PE3btjPjIVh7EiImqG3C+CfgpPf6J/63kmVkz5hvCkKsu++bWO1XmQde57hmdiTEO3tu16gTm3zCiUxFhCKDcenqbRiLyHguI4798E3Vp0jEpbbdgQ80Zr89VmCBiFDZBNHZqO68KVtLc3mykNQDz1IAi19PUuC0pkptjwf8w1unSgFGsJvMdzeF+dfy4UHk0ex0qp957wczY9I4u+D4KpPk1pKS/WojP2YLzeF3i63HH3FaEvCufsQX9eWUcMVKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DG0MRFtOUfqUYcYR6bUfTVPbBf60Z/twTr9QRNrYDaw=;
 b=gQmeov/ysIXnyb9EPBEEavcGVkK5aM+8S6h/uQf0sPiXFfqDwX90idg5Tdy3o0lqDbZtbYRguROy/CY2FKpQQqaKwUW0xGZKPugZQazbp054fhU8zWZYKmZHxIYHMw88PJte+Fz8OKG0WDAGb+1OABlh4mxVSAB6ZrBCA37UNno=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS5PR04MB9731.eurprd04.prod.outlook.com (2603:10a6:20b:654::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 00:39:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0%3]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 00:39:51 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Zhanhao Hu <zero12113@hust.edu.cn>,
        Abel Vesa <abelvesa@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        kernel test robot <lkp@intel.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx93: Propagate correct error in
 imx93_clocks_probe()
Thread-Topic: [PATCH] clk: imx93: Propagate correct error in
 imx93_clocks_probe()
Thread-Index: AQHZtAmKC0oqBI2330u+pCopqaVPfq+1Sorw
Date:   Wed, 12 Jul 2023 00:39:51 +0000
Message-ID: <DU0PR04MB9417D2DAD115175B829D42118836A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230711150812.3562221-1-geert+renesas@glider.be>
In-Reply-To: <20230711150812.3562221-1-geert+renesas@glider.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS5PR04MB9731:EE_
x-ms-office365-filtering-correlation-id: cb3c2820-1e33-4c0d-8ac8-08db82708117
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z7m3bDx4Z5UqBaCIvCpK1uHeWzqXIgcjUHCoDO8TTsUtzHgJe7RXwsYswnTC1hIF6UszxwZSzYQF/5DlMVPCPFFQ3imeaIruBfznbaBV5c9KMsv1ebTC0iFsqATxvihgLHMhCKqe4Kz4fmXC9VGbDJKmK+hVfRcLfk4RHn8wyovcnBPqa58EZoLQtvTA5tDIKU1A0xXkhRUtJkd7chcHhWVYARA5IEjDxTGN1qj40juED3pCDV0SOveA5pcI/sqNTiX4IldoZp78Dtdse1qu4sQF452lJKkss6ccOl1ZaBEu8eJ7VQB5i2+yhc0VvaCIFA2LpTjsF5cF8m191L3mfO7+f7+dWaATjjEjipKBBLHZWt8/ZobprXLmadGZY0IysZWwPgZCaLUo9E+VxB54UhCJiWh1TBoU8xpmu5v20L35hvgSqEkKuvafJ0mF53w3KLr327jCCofI0EZqdwNAKB6KDN5gFX3IT+8/Tu22632DMo7gEDhdmfUjUbGgIvmSGTgtQMBN+JRInkB7WOpn63ATFmxl6u1vZ07Rbys7qV0kcqQhMyJxgBWIBvAoLf9Bhat+vDY9QXf2aUxyeVPyx66wro7vUIKZc4gkQ7KK8SuIf+5WSooILd9A12K6qk9/v2eIYOB2usvEO32Ul4p0mw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199021)(2906002)(55016003)(122000001)(921005)(966005)(38100700002)(83380400001)(186003)(26005)(53546011)(9686003)(86362001)(6506007)(52536014)(33656002)(5660300002)(38070700005)(8936002)(8676002)(44832011)(7416002)(110136005)(54906003)(71200400001)(7696005)(45080400002)(478600001)(41300700001)(66556008)(66446008)(66476007)(66946007)(76116006)(64756008)(316002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TFgvWHVNeWhQSkUzaHoxY1FrMHBXZmY0ejh2N0c4Y3BwNmZMeDk1b2wrQjVL?=
 =?gb2312?B?dWhLSGFGSkJDMVlubjVEU3F4dVo1c3BDUmJXaXZSSktzTjBlSGVqZGl5VmV3?=
 =?gb2312?B?bzJmdnNVaGYyeWFWQ1R6Vk9ULzM0WTFzY3lyTkdXNTZTbFAwVWhENUdkOXhL?=
 =?gb2312?B?K3BUaE5vYnZ3TG16c0Q4VEp1bHgwcnNlOENmZ0hMdDFtcWdId2pOY3hHYnlq?=
 =?gb2312?B?MDJpTUZ6T3B3WmFQUnU2S25Tc2c3ZmFyS2txTFlEMllpUFdjNVNpb1JEbHlR?=
 =?gb2312?B?RlM4Y09XVERWb1RMRDRnRmo4SEl5NFVzN2lST1hDTGJsKzU0VWFCbkpGUHJY?=
 =?gb2312?B?SlM1OWpKaFBtOEdNNkJkOEluLzI2UW5IRlQ0UXBGQzFSMENuYmZrcFB5VlVP?=
 =?gb2312?B?UTdpakJEeUh4dnlsWERZNzFremxoQytVOTlYVmwvb0dYTUFZK21sb1hNS21X?=
 =?gb2312?B?ZVFvRXVDVUtESnEweFBJdi9PelA4WWQ3THNwOGpkM1I5NTE0cEMwUnlWbEpG?=
 =?gb2312?B?SWtQZHdJbFRrZmd0bUs3L2NTQWVUZkYzb3lwT2crbTVkUm1EQVQvV0tZMHll?=
 =?gb2312?B?Q1JmWTVIZnJmVXNkcXFVR29FZnBZZXJZUnVkbE15VUZmZlFDcEpSM0kxYy9V?=
 =?gb2312?B?czF5dGxtOWhiL3pPWU8wZTRHOGszNGVORnVrUWdLR3Y5Tis0ZXhicC9CODFh?=
 =?gb2312?B?eWJaRVRGcWhrSTBXR1UrVTFjaTlwZzR2cXNyNjgrL1M3Zndqd2hhYXFqUTM5?=
 =?gb2312?B?a2pZZzlNUXRXVHNveTdsQ0thRllPKzZyM2YzRmhhMjkvL2VPNEV5Y3ZraDJI?=
 =?gb2312?B?OHBOTVBhUHJKaUNqOVlaZUoxcFpjczlGRzU2anZHOFpYSUVWS2RiRC9HME1o?=
 =?gb2312?B?c1FBQ0MwWDVGL3FJamc1ZzBNcUhSOHllcllIZzhRN0xZTjFtaVY0S0NaVzBO?=
 =?gb2312?B?cklVRjI0NytXaTFHdDFOYkpFYUoxTnNMS0dDc2tENGFFeVQ5djZyTm9IS0dU?=
 =?gb2312?B?a1daaTNvbzhXVXJyK2RCUHNseEMvMGlyNndvOXIrMHBrSTJGdzk2eUxYZ09T?=
 =?gb2312?B?Tm9pR2NSWTd0NG8weHVsMzNwbGtyZTQyUkkzQ2JhdW02WkF5U2VRdVl3MlhR?=
 =?gb2312?B?RGZBWGdlZFZDRHlrY0I5WlZSeUJldE1EbWxNMjFlUEhlb29rc1p5OCtmVENS?=
 =?gb2312?B?NHdXVzYzSThXaEpTSy9ZbUh2RU1Kc1FtQnp1Q0hkVjBMekhtdmlSd2dDeHRJ?=
 =?gb2312?B?TG95emREZ2dTa1R5QTRWU1hWdmNKOTMxanRhdkZibk9CVVFwTFdnWWRPdTNL?=
 =?gb2312?B?LzlrMVQwbHllZUV3Y01HR3MvWnpRRFZORmxONkkvYWRTc0JETEFOTi9wUndQ?=
 =?gb2312?B?M3MrYWlCR3A3RFJCSVVQbVcrSXIvcXZ3eWEwZERMVDRzOHRlRkRHNnE5ZlJK?=
 =?gb2312?B?SVdwczNYZDkxTVN1OExweHMyOHViL3VGZ21FMis3K1JnelU4TXVTa1pWc25p?=
 =?gb2312?B?dXd2MTRCYzFYSldtWjhEQ2huRDhXbW9CS3ZuRWdoRDJ2WjNtYWtjS0NNWm05?=
 =?gb2312?B?RHdiejRmd1NYSUt0Wi9PSWlBT1NrR1pITmhnOFJvT2lKRGcrbnNveTB3Vksx?=
 =?gb2312?B?VjliaWFhR0dBWE96SGNIWUk0Mk5pL3BDSWNvMm5sMHB5MXpUbjJEdnNVWWlv?=
 =?gb2312?B?OTB6bjNNcXlLa1FlQ2VTM29QblNlQWNpSXN5dXJ3bm9odEJEZnNLVFRPOUFs?=
 =?gb2312?B?eTVnMUlrblRBQURLMUFZd2xJT08yN3plRnlnbUpWcUZvdnUyUmZzNnU3a0hN?=
 =?gb2312?B?NzhVQmdzUXFYU0Y1Q1MwaFJJd3RXY2xla1RQaTIwVkRES0dvWVVQZm1LbVZj?=
 =?gb2312?B?ek90TWxFNUhlRWlLSE9KYzlMcVhUNmVIY3FCMjhMeVRqNXAwT3pOUzE4QTFh?=
 =?gb2312?B?NkQ5cm9EY0xoWVRESm5tZFN6YzA5OE9udTdqa1lmS1Y1WUJvQUUxbkpMWGg5?=
 =?gb2312?B?ZmdDNjJHWGIxdjgvRVQ3dXp2Y0I1TTloZ3dLRnl1dURNWmhMcWJGYVJOSmNH?=
 =?gb2312?B?MzJjdXcxQXIvRWQ2MDVzT1VOd0NMcys1Q1psa3d1M1FDMHRrQlpyUHM1dm1N?=
 =?gb2312?Q?zhkM=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3c2820-1e33-4c0d-8ac8-08db82708117
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 00:39:51.6522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Ld4LrtpnJUNw3gW3FCZt5jKKMO+1c1gYS/NUJYoQ9VSnqs3QNmgX6+KQvEUuHxLrK+YO6aDhc0TeJPhgrxc2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9731
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQgVXl0dGVyaG9l
dmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gU2VudDogMjAyM8TqN9TCMTHI1SAyMzow
OA0KPiBUbzogWmhhbmhhbyBIdSA8emVybzEyMTEzQGh1c3QuZWR1LmNuPjsgQWJlbCBWZXNhDQo+
IDxhYmVsdmVzYUBrZXJuZWwub3JnPjsgRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5h
cm8ub3JnPjsgUGVuZw0KPiBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBNaWNoYWVsIFR1cnF1ZXR0
ZSA8bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb20+Ow0KPiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5l
bC5vcmc+OyBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+Ow0KPiBTYXNjaGEgSGF1ZXIg
PHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBQZW5ndXRyb25peCBLZXJuZWwgVGVhbQ0KPiA8a2Vy
bmVsQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0K
PiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IGtlcm5lbCB0ZXN0IHJvYm90
IDxsa3BAaW50ZWwuY29tPjsNCj4gbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gU3Vi
amVjdDogW1BBVENIXSBjbGs6IGlteDkzOiBQcm9wYWdhdGUgY29ycmVjdCBlcnJvciBpbiBpbXg5
M19jbG9ja3NfcHJvYmUoKQ0KPiANCj4gc21hdGNoIHJlcG9ydHM6DQo+IA0KPiAgICAgZHJpdmVy
cy9jbGsvaW14L2Nsay1pbXg5My5jOjI5NCBpbXg5M19jbG9ja3NfcHJvYmUoKSBlcnJvcjogdW5p
bml0aWFsaXplZA0KPiBzeW1ib2wgJ2Jhc2UnLg0KPiANCj4gSW5kZWVkLCBpbiBjYXNlIG9mIGFu
IGVycm9yLCB0aGUgd3JvbmcgKHlldCB1bmluaXRpYWxpemVkKSB2YXJpYWJsZSBpcw0KPiBjb252
ZXJ0ZWQgdG8gYW4gZXJyb3IgY29kZSBhbmQgcmV0dXJuZWQuDQo+IEZpeCB0aGlzIGJ5IHByb3Bh
Z2F0aW5nIHRoZSBlcnJvciBjb2RlIGluIHRoZSBjb3JyZWN0IHZhcmlhYmxlLg0KPiANCj4gRml4
ZXM6IGUwMmJhMTFiNDU3NjQ3MDUgKCJjbGs6IGlteDkzOiBmaXggbWVtb3J5IGxlYWsgYW5kIG1p
c3NpbmcgdW53aW5kDQo+IGdvdG8gaW4gaW14OTNfY2xvY2tzX3Byb2JlIikNCj4gUmVwb3J0ZWQt
Ynk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4NCj4gQ2xvc2VzOg0K
PiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cHMlM0ElMkYlMkZsb3JlLg0KPiBrZXJuZWwub3JnJTJGYWxsJTJGOWMyYWNkODEtM2FkOC00ODVk
LTgxOWUtDQo+IDllNDIwMTI3NzgzMSU0MGthZGFtLm1vdW50YWluJmRhdGE9MDUlN0MwMSU3Q3Bl
bmcuZmFuJTQwbnhwLmNvDQo+IG0lN0NhYWM0MjYyNzAwZmQ0ZDg5MjZjODA4ZGI4MjIwYWJlOCU3
QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5DQo+IGM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4MjQ2ODQ5
MDU2ODIwNDcwJTdDVW5rbm93biU3Q1RXRnBiR1pzDQo+IGIzZDhleUpXSWpvaU1DNHdMakF3TURB
aUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNDQo+IG4wJTNEJTdDMzAw
MCU3QyU3QyU3QyZzZGF0YT1mQnRXZ0xFY2lXakRsc3I5c2tsTUolMkJnUTlXVmdCbA0KPiBxJTJG
ZFNLOTJzbzBLMEUlM0QmcmVzZXJ2ZWQ9MA0KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9i
b3QgPGxrcEBpbnRlbC5jb20+DQo+IENsb3NlczoNCj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG9yZS4NCj4ga2VybmVs
Lm9yZyUyRmFsbCUyRjIwMjMwNjE2MTUzMy40WURtTDIyYi0NCj4gbGtwJTQwaW50ZWwuY29tJTJG
JmRhdGE9MDUlN0MwMSU3Q3BlbmcuZmFuJTQwbnhwLmNvbSU3Q2FhYzQyNjINCj4gNzAwZmQ0ZDg5
MjZjODA4ZGI4MjIwYWJlOCU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDDQo+
IDAlN0MwJTdDNjM4MjQ2ODQ5MDU2ODIwNDcwJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJ
am9pDQo+IE1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZD
STZNbjAlM0QlN0MzMA0KPiAwMCU3QyU3QyU3QyZzZGF0YT1id2llYjQ2c25VMlo3V0NWUzNjYTRz
cUt5RiUyRlYwYXhDWG9rSUFnVnINCj4gZEdZJTNEJnJlc2VydmVkPTANCj4gU2lnbmVkLW9mZi1i
eTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gLS0tDQo+
ICBkcml2ZXJzL2Nsay9pbXgvY2xrLWlteDkzLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2Nsay9pbXgvY2xrLWlteDkzLmMgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDkzLmMgaW5kZXgN
Cj4gYjZjN2MyNzI1OTA2YzU3NC4uNDRmNDM1MTAzYzY1YThlZSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9jbGsvaW14L2Nsay1pbXg5My5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14
OTMuYw0KPiBAQCAtMjkxLDcgKzI5MSw3IEBAIHN0YXRpYyBpbnQgaW14OTNfY2xvY2tzX3Byb2Jl
KHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJYW5hdG9wX2Jhc2UgPSBkZXZt
X29mX2lvbWFwKGRldiwgbnAsIDAsIE5VTEwpOw0KPiAgCW9mX25vZGVfcHV0KG5wKTsNCj4gIAlp
ZiAoV0FSTl9PTihJU19FUlIoYW5hdG9wX2Jhc2UpKSkgew0KPiAtCQlyZXQgPSBQVFJfRVJSKGJh
c2UpOw0KPiArCQlyZXQgPSBQVFJfRVJSKGFuYXRvcF9iYXNlKTsNCj4gIAkJZ290byB1bnJlZ2lz
dGVyX2h3czsNCj4gIAl9DQo+IA0KDQpSZXZpZXdlZC1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54
cC5jb20+DQo+IC0tDQo+IDIuMzQuMQ0KDQo=
