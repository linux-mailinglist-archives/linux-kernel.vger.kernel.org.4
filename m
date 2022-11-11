Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042A5625964
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiKKLbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKKLbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:31:38 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F1E1C0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:31:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9pf8rkyiwFLmIEnD9Erx85fGTbiZLoy7j29GWIEDSG6ckQhKu56rNf/6fDZidadfu632ol9HtRZxDGm9r4ahWARElnuS238ZFdFdCLkRPfs9Epfp0i+txK4pSmwa+glFa8KOTYbMJOmHWCvh35055DTiINL9NZLHchTHmp+WGQDh5F1/MGtsfW6NZOe22+qGYinJsKtFLsX2MDjMOOJ7DRoRt8PkTCYwXe1937SF0OIDHXIu0TPAsluMIQfEleKq9P6BEkAAlkU+m0LCTitSbEYZCgNFbElH6UZQj/lM+ijV8FUnSRhLnuNo+tmRJvZ94rtsZT47Q6QZK5XwjV7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rM2fktFb49KW3nTtP2x7RH9bW0ei0FooGdFwaM1/gI=;
 b=Xv4/5RKsc/R5bAm7doMN6QPJWATyvq/dzvmHAIaHMa4vE5n+xAzXg+yoaHUTXFkEPFrqFP2ntApdDKDYfcsQIq5CHQZDABLt9nRYbO0oEa4+IgC3w/ogLhP9WD040Ub545Rfdi0SkHPkbqhqdq6431sIKt1XK+Qu+rlKsGps9rECEV5vcVABhOY1MtGjHkWY96IAO9mM4etja16BFEyX4fM2YSPZpv03ukel3BMiUyhYbnCQAMoeJfWPvUtZY/rtkQLCyUl2GPMrNKKQ+iLiERTZyEjsMdFaP9akmf+W2+mmWwxhCDVJmJSwFelSLaH2ZuMmNqjUbCFyuiKU8E0v/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rM2fktFb49KW3nTtP2x7RH9bW0ei0FooGdFwaM1/gI=;
 b=G/7idDD2kcO86P6Xa8QmIGeF/Nz2SqBfy/83nkizl95qGpU5YRZSJ/1JlZvPuWItJAeue2d4zsViP0s30lsmARJDFVS07FGVUum988RoUvc9KSUrs+2hzq7U1TGYlpGeZuRtKSvPSkO+D6mkU4VIECVsvVKu0Ad2Z6E5OS0uolw=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 11:31:25 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d%3]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 11:31:25 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 12/14] arm64: dts: imx8mm-evk: Enable usdhc1 to support
 wifi
Thread-Topic: [PATCH V4 12/14] arm64: dts: imx8mm-evk: Enable usdhc1 to
 support wifi
Thread-Index: AQHY9X2Dj+CW2j9Q9EuU87U+PYFMtq45ba8AgAABpYCAAAG/0IAABEsAgAAfdCA=
Date:   Fri, 11 Nov 2022 11:31:25 +0000
Message-ID: <AS8PR04MB8404B33905D685F820A6F07D92009@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20221111032811.2456916-1-peng.fan@oss.nxp.com>
 <20221111032811.2456916-13-peng.fan@oss.nxp.com>
 <20221111090232.6ibqzoivfqsndhxg@pengutronix.de>
 <DU0PR04MB94177ED8966506D445CFBA5688009@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <AS8PR04MB8404426EC83A75A3058F774192009@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <20221111093002.dpp73hkef6ihkduk@pengutronix.de>
In-Reply-To: <20221111093002.dpp73hkef6ihkduk@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|AS8PR04MB8513:EE_
x-ms-office365-filtering-correlation-id: cdd07da0-ad45-4f24-3d93-08dac3d8444d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WOfZky5dAu8WF7tisDV/XR/Y4s93CKwXXQPw2gtVP6iQEODy2YgyI2aNsTOn/5YAkCRtThvpK/kxpW7cCptsphh1Xbr42HCwELRCb9tReRihbw39erLy6PP1PA9QEz4Ef7a1Sfl3lrzibS0F93n9VGltkI6lC4QGuQ1fOnU6cfZEuHfRkogCk71/1FMJtVEUy1shBWr7IUx05E8Cb+NJ8ZXxlrIzro3DoY+iu9GWXWuf0qoV452Enfa5IFxIDl4oQ+DOzBkxhQSjDffp9/0IyM4cvmXLRWEGkyhSJYHbId/uqUsVbvqD/b9/4gRmHw3awYtfYukO8t1SR9RQ+yPXiQVsy8kEuc4x6/AOOz91vk36/nYrxfBE1OiruYDJUhh25l0zsyQv6Me/Y+x3Mqg62B3Ur00gmgXT2gcOrNRBijnV/JFHJBl2e8xBqgND3zVKF/bSaAzwsp5/ND+Q+GpsCziDm+MBrvlPkfiLtTTTAD4sUVkDThXVKpm+TxBfLMiIJSqmPq1PEmZgDA5i6C00m7P5uzzJjB7bLYxp3c/+gvYzi+5cizB9SU6VV+gQwte5Jm46589jJTOK37Amh42ISqMemO+O5e95Eyp5Ouy1t4cuOy6OUmTuJEdifLu9TZ9fEeL6MM9JlFyXH+x2q1h2f+IgSwSvYv/W7pyny8Lra5RrIl6Ao7WO2n7W9Pbf4nQJXs5hK9hgCgmmCBB8TmwbHfI3wmnM4pYN0/pQcoueTuZPG1szOABMUhsETTQJw5/clVOGRS2G/2by3UVq5VU1X8tvCms1XUaNrbmZGjPIUZw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199015)(33656002)(38070700005)(86362001)(6506007)(186003)(66556008)(2906002)(5660300002)(44832011)(26005)(9686003)(83380400001)(53546011)(122000001)(38100700002)(8676002)(316002)(64756008)(52536014)(76116006)(66476007)(66446008)(66946007)(8936002)(55016003)(7696005)(6916009)(54906003)(71200400001)(41300700001)(4326008)(478600001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGkyL1lxRVI4SFpoL0I4MXRDZGxzUnowNzI0NWxWQVBkeTNOZFYzbjB3Q0tY?=
 =?utf-8?B?R3hSRkhldURWbmEwVXplbm41QXM0ai9yVkU3YWRSQVNaRXJSaEdoOFRBcHJI?=
 =?utf-8?B?bU1NZjFRM3g0bnBXWnFCU1lxNzV4emJhNnBiZkY3S1diVDcySDV2TVlDSEUx?=
 =?utf-8?B?VnFOVnBYZkM2dDFXT3VQZjdGblZXdWQ2RTQ1ZEUxUkxsRHlSd3RoSk5nV1NX?=
 =?utf-8?B?UUFXbFRDMTIrL0ZLMG9MTnZYTGg2N3hFWEV2bVNobUtMeEtwVW92NjFpK054?=
 =?utf-8?B?UlQxL2JsVDRQMGFNUlllenNlSjZhWWVrdEFqdlA1RXBpMDV3dFdiVVhicXpW?=
 =?utf-8?B?TUtIVmJzZ01OZmJNR29LSHpqb1dudTgzOFRFTE16WVBiQXZ6RmhsY2dmbC9G?=
 =?utf-8?B?d01kMVA3TlhsWXdXSEQrblkrUE1yLzB4U3RpWE03bHRvSGhOdktrNmVmVWRG?=
 =?utf-8?B?QmQySXNHS2N2Wll5NFFIZ2N6N2s0NGI4MThHa1VUSGtMUnBmQkdEZXQzVmhD?=
 =?utf-8?B?VzF0NVdUb29ZZzl3dFJKcU5EWlFoRXRxem5ySHhsbVhRdWFrbWZ2UVltL3FF?=
 =?utf-8?B?bWNTYVQ4bFErVVFXQ21nRTQxbnNEeFJudmg2ajBLdDdlSlRZaDJwRGxSU3dB?=
 =?utf-8?B?c2NodllLVW52a1FuZktWMWJLZisvbW4zcjRUdkpDQzY5b2R6Rkc1SmFlWG42?=
 =?utf-8?B?Zyt4bTR2clN5TjBRRjlUbjVqb1pVTTdzL3J1V1UyVGlNU3FZMFNmcnMvaWYz?=
 =?utf-8?B?SkNtUDRGZEZtUWg1cCtnRE1paHVFMWozZkFLY1lTQ1pCRDlBQW5ySkEzUDN1?=
 =?utf-8?B?SW83NDF1RjN3RDdxeTdxVllKZGZSUUt0cnV4SXJYZlFucW5sd1NDSWZ3TEVm?=
 =?utf-8?B?dVZHUG05SW43ditSZTIxWFRHcVNYa0tLNzZoLzZOMUhybFVnMlV3Q2xaa2hl?=
 =?utf-8?B?MzY2N0JVWUlxVlJyNVI2Wm9WbXR3MmZCaWl1M29XdC8rcGs5djVPeFNjUWpw?=
 =?utf-8?B?MDZZOFFDbmhBZEFMRlc5MFcxTzFSQTEyZmpUaW92Y1BWelBOcHNpUkkydVBZ?=
 =?utf-8?B?Mkd0WGllNk9OUCtQVDlWUlRVOE9CNWlDTDFPeFRCTVFHM3BiWEJYcnRYQnNp?=
 =?utf-8?B?Y2pZUU1SRmttWmVHNWFWOVN3UzFIbjk2bEs5N2JNZ0pOWTIzdy96Qlh0Ulhl?=
 =?utf-8?B?YkE0di9VNGFITHM5SjV0dGhLRzJ5RXVnTXRiNkxacDFYSjJBSmZkZjBIWlZJ?=
 =?utf-8?B?ZUIyU1BaalNWTCtDK3NNVlJ5T2FIaDdjalArRFczOUlOd2hudVF2WXhZZ0Zh?=
 =?utf-8?B?b3dDNFczZzBJZmxreEdqTFdEN2YyWUxWdFR5UmUyeFkrdjVWVHVQanNSZjFx?=
 =?utf-8?B?a002eGpkbXRKLzhzcDMxUm03ZU9OU1NlcHNxUTdtNU5KT3ZISmYwS0tkMWk2?=
 =?utf-8?B?eEdoK2JrOTZOVHJvVTNVV0VzYkV5cFRqcHlNekNjMWxjT213SFo3ZEFIWmN6?=
 =?utf-8?B?ZmRpSjg0eFJLSW4vQUVWSjAvaGpsREFVcHJZb3l2NDV3ZXlEU2dGbTBsaEI2?=
 =?utf-8?B?anVMZ01tQWovYkFsUGpPZzNnckFEUmNDalNYSUUrUlkrWXp5MnFUdjBSdE13?=
 =?utf-8?B?dWpzeXl6UDE1M3RtS3d1d1MvaWtJMXJUL2I2OU43RWQ0OFpxTExlbXpkM29Z?=
 =?utf-8?B?Vjg1UC8vZXc0WHF3VFJLa1hIampJWk9iR3FsZGJiVy9KUWJjOHl6NkxpRklL?=
 =?utf-8?B?SUJvVnNhWFpiMVM4bkdibTJJRHJTaWVsQ0k5bkF2ZzhuRzBPWTQ4QVF1S3Mr?=
 =?utf-8?B?RHdZdEdjMkJXSzE2bEQwbGxYay91RmZrK0RjMEdhb2x5Sjl2amRUeTlMVW1p?=
 =?utf-8?B?WWVjZGpDMkI3QmY1ODBPRk9JdFJnWVdtZWltSDFGRlA5MHJqLzRKUHVjZjRz?=
 =?utf-8?B?aFl2VTFvWTlIUlZURFFDTWdHZTFBN3N1dEVvbFYwZk9SZHVaV2FPNERnS2pB?=
 =?utf-8?B?Z2FaWCtzdG9zZU53aGswUzJrZ01YN0xMRjdvZTRMcFFQRWhNTTBIK3Bwakpz?=
 =?utf-8?B?TzlZZVFGYUw0VHhiOXlTVldIMHNObU9EYkx4T09PZ2t0ZGlodDdYRTNRY2Ew?=
 =?utf-8?Q?tTaGBzd2b92l05jjyr7REWk88?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd07da0-ad45-4f24-3d93-08dac3d8444d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 11:31:25.2299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VRPQGM6YZL/X/SHIptn4Qgs9/BFP/skyb0jTsvBlX/RNMiPPFFUGC36xinKrqKXiEWSIv0ON/zzWr1bm6UeSRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyY28gRmVsc2NoIDxt
LmZlbHNjaEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDEx5pyIMTHml6UgMTc6MzAN
Cj4gVG86IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gQ2M6IFBlbmcgRmFuIDxw
ZW5nLmZhbkBueHAuY29tPjsgUGVuZyBGYW4gKE9TUykNCj4gPHBlbmcuZmFuQG9zcy5ueHAuY29t
Pjsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4gbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBn
bWFpbC5jb207DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGwtbGlu
dXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNCAxMi8x
NF0gYXJtNjQ6IGR0czogaW14OG1tLWV2azogRW5hYmxlIHVzZGhjMSB0bw0KPiBzdXBwb3J0IHdp
ZmkNCj4gDQo+IE9uIDIyLTExLTExLCBTaGVycnkgU3VuIHdyb3RlOg0KPiA+DQo+ID4NCj4gPiA+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5m
YW5AbnhwLmNvbT4NCj4gPiA+IFNlbnQ6IDIwMjLlubQxMeaciDEx5pelIDE3OjA4DQo+ID4gPiBU
bzogTWFyY28gRmVsc2NoIDxtLmZlbHNjaEBwZW5ndXRyb25peC5kZT47IFBlbmcgRmFuIChPU1Mp
DQo+ID4gPiA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+ID4gPiBDYzogc2hhd25ndW9Aa2VybmVs
Lm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsgbGludXgtDQo+ID4gPiBrZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+Ow0KPiA+ID4ga2VybmVs
QHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4LWFybS0NCj4gPiA+IGtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29t
Pg0KPiA+ID4gU3ViamVjdDogUkU6IFtQQVRDSCBWNCAxMi8xNF0gYXJtNjQ6IGR0czogaW14OG1t
LWV2azogRW5hYmxlIHVzZGhjMQ0KPiA+ID4gdG8gc3VwcG9ydCB3aWZpDQo+ID4gPg0KPiA+ID4g
U2hlcnJ5LA0KPiA+ID4NCj4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCBWNCAxMi8xNF0gYXJt
NjQ6IGR0czogaW14OG1tLWV2azogRW5hYmxlDQo+ID4gPiA+IHVzZGhjMSB0byBzdXBwb3J0IHdp
ZmkNCj4gPiA+ID4NCj4gPiA+ID4gSGkgUGVuZywNCj4gPiA+ID4NCj4gPiA+ID4gT24gMjItMTEt
MTEsIFBlbmcgRmFuIChPU1MpIHdyb3RlOg0KPiA+ID4gPiA+IEZyb206IFNoZXJyeSBTdW4gPHNo
ZXJyeS5zdW5AbnhwLmNvbT4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEVuYWJsZSB1c2RoYzEgd2hp
Y2ggaXMgdXNlZCBmb3Igd2lmaS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAg
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHMgIHwgMjcNCj4gPiA+
ID4gPiArKysrKysrKysrKysrIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1l
dmsuZHRzaSB8DQo+IDM5DQo+ID4gPiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gPiAg
MiBmaWxlcyBjaGFuZ2VkLCA2NiBpbnNlcnRpb25zKCspDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHMN
Cj4gPiA+ID4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1ldmsuZHRz
DQo+ID4gPiA+ID4gaW5kZXggYTJiMjRkNGQ0ZTNlLi43YjgwZjE0NDMyN2QgMTAwNjQ0DQo+ID4g
PiA+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHMN
Cj4gPiA+ID4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZr
LmR0cw0KPiA+ID4gPiA+IEBAIC0xNSw2ICsxNSwxMyBAQCAvIHsNCj4gPiA+ID4gPiAgCWFsaWFz
ZXMgew0KPiA+ID4gPiA+ICAJCXNwaTAgPSAmZmxleHNwaTsNCj4gPiA+ID4gPiAgCX07DQo+ID4g
PiA+ID4gKw0KPiA+ID4gPiA+ICsJdXNkaGMxX3B3cnNlcTogdXNkaGMxX3B3cnNlcSB7DQo+ID4g
PiA+ID4gKwkJY29tcGF0aWJsZSA9ICJtbWMtcHdyc2VxLXNpbXBsZSI7DQo+ID4gPiA+ID4gKwkJ
cGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiA+ID4gPiArCQlwaW5jdHJsLTAgPSA8JnBp
bmN0cmxfdXNkaGMxX2dwaW8+Ow0KPiA+ID4gPiA+ICsJCXJlc2V0LWdwaW9zID0gPCZncGlvMiAx
MCBHUElPX0FDVElWRV9MT1c+Ow0KPiA+ID4gPiA+ICsJfTsNCj4gPiA+ID4gPiAgfTsNCj4gPiA+
ID4gPg0KPiA+ID4gPiA+ICAmZGRyYyB7DQo+ID4gPiA+ID4gQEAgLTUzLDYgKzYwLDE5IEBAIGZs
YXNoQDAgew0KPiA+ID4gPiA+ICAJfTsNCj4gPiA+ID4gPiAgfTsNCj4gPiA+ID4gPg0KPiA+ID4g
PiA+ICsmdXNkaGMxIHsNCj4gPiA+ID4gPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJz
dGF0ZV8xMDBtaHoiLCAic3RhdGVfMjAwbWh6IjsNCj4gPiA+ID4gPiArCXBpbmN0cmwtMCA9IDwm
cGluY3RybF91c2RoYzE+LCA8JnBpbmN0cmxfd2xhbj47DQo+ID4gPiA+ID4gKwlwaW5jdHJsLTEg
PSA8JnBpbmN0cmxfdXNkaGMxXzEwMG1oej4sIDwmcGluY3RybF93bGFuPjsNCj4gPiA+ID4gPiAr
CXBpbmN0cmwtMiA9IDwmcGluY3RybF91c2RoYzFfMjAwbWh6PiwgPCZwaW5jdHJsX3dsYW4+Ow0K
PiA+ID4gPiA+ICsJYnVzLXdpZHRoID0gPDQ+Ow0KPiA+ID4gPiA+ICsJa2VlcC1wb3dlci1pbi1z
dXNwZW5kOw0KPiA+ID4gPiA+ICsJbW1jLXB3cnNlcSA9IDwmdXNkaGMxX3B3cnNlcT47DQo+ID4g
PiA+ID4gKwlub24tcmVtb3ZhYmxlOw0KPiA+ID4gPiA+ICsJd2FrZXVwLXNvdXJjZTsNCj4gPiA+
ID4gPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gPiA+ID4gPiArfTsNCj4gPiA+ID4gPiArDQo+ID4g
PiA+ID4gICZ1c2RoYzMgew0KPiA+ID4gPiA+ICAJYXNzaWduZWQtY2xvY2tzID0gPCZjbGsgSU1Y
OE1NX0NMS19VU0RIQzNfUk9PVD47DQo+ID4gPiA+ID4gIAlhc3NpZ25lZC1jbG9jay1yYXRlcyA9
IDw0MDAwMDAwMDA+OyBAQCAtMTI1LDQgKzE0NSwxMSBAQA0KPiA+ID4gPiA+IE1YOE1NX0lPTVVY
Q19OQU5EX0NMRV9VU0RIQzNfREFUQTcNCj4gPiA+ID4gMHgxZDYNCj4gPiA+ID4gPiAgCQkJTVg4
TU1fSU9NVVhDX05BTkRfQ0UxX0JfVVNESEMzX1NUUk9CRQ0KPiA+ID4gPiAweDE5Ng0KPiA+ID4g
PiA+ICAJCT47DQo+ID4gPiA+ID4gIAl9Ow0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArCXBpbmN0
cmxfd2xhbjogd2xhbmdycCB7DQo+ID4gPiA+ID4gKwkJZnNsLHBpbnMgPSA8DQo+ID4gPiA+ID4g
Kw0KPiA+ID4gPiAJTVg4TU1fSU9NVVhDX0dQSU8xX0lPMDBfQU5BTUlYX1JFRl9DTEtfMzJLDQo+
ID4gPiA+IAkweDE0MQ0KPiA+ID4gPiA+ICsJCQlNWDhNTV9JT01VWENfU0QxX0RBVEE3X0dQSU8y
X0lPOQ0KPiA+ID4gPiAJMHgxNTkNCj4gPiA+ID4gPiArCQk+Ow0KPiA+ID4gPiA+ICsJfTsNCj4g
PiA+ID4NCj4gPiA+ID4gT3V0IG9mIGN1cmlvdXNpdHksIHRoaXMgaXMgbm90IHNoYXJlYWJsZSB3
aXRoIHRoZSBvdGhlciBkZHI0IGV2az8NCj4gPiA+IFtQZW5nIEZhbl0NCj4gPiA+DQo+ID4gPiBD
b3VsZCB5b3UgcGxlYXNlIGhlbHAgYW5zd2VyPw0KPiA+ID4NCj4gPg0KPiA+IEhpIFBlbmcsIEkg
c3VnZ2VzdCB0byByZW1vdmUgdGhlIHBpbmN0cmxfd2xhbiBjb25maWd1cmUgaGVyZSwgaXQgc2hv
dWxkIGJlDQo+IGFkZGVkIGFsb25nIHdpdGggdGhlIHdpZmkgd293bGFuIHN1Ym5vZGUgbGF0ZXIu
DQo+IA0KPiBEb2VzIHRoaXMgYXBwbHkgdG8gdGhlIGlteDhtbi1ldmsgcGF0Y2ggYXMgd2VsbD8N
Cj4gDQo+IEFsc28gaWYgdGhlIHVzZGhjMSBpcyB1c2VkIG9ubHkgZm9yIFdMQU4gYW5kIHRoaXMg
cGF0Y2ggc2VyaWVzIGRvbid0IGFkZCB0aGUNCj4gV0xBTiBzdWJub2RlLCB3ZSBjb3VsZCByZW1v
dmUgdGhpcyBwYXRjaCBhbmQgdGhlIGlteDhtbi1ldmsgdXNkaGMxDQo+IHBhdGNoIGNvbXBsZXRl
bHkgdGlsbCB5b3UgaGF2ZSBhIGNvbXBsZXRlIHBhdGNoc2V0IGFkZGluZyB0aGUgZnVsbCBXTEFO
DQo+IHN1cHBvcnQuDQo+IA0KDQpIaSBNYXJjbywgYWN0dWFsbHkgaGVyZSBlbmFibGUgdXNkaGMx
IGNhbiBzdXBwb3J0IHRoZSB3aWZpIGJhc2ljIGZ1bmN0aW9uLCBzbyB0aGlzIHBhdGNoIGlzIG9r
IHRvIGVuYWJsZSB3aWZpIG9uIDhtbSwgc2FtZSBmb3IgOG1uLg0KQnV0IHBpbmN0cmxfd2xhbiBp
cyB1c2VkIHRvIHN1cHBvcnQgdGhlIG91dC1vZi1iYW5kIFdvV0xBTiBmZWF0dXJlLCBuZWVkcyB0
byBiZSB1c2VkIHdpdGggd2lmaSBjaGlsZCBkdHMgbm9kZSwgd2hpY2ggbG9va3MgbGlrZSB0aGUg
Zm9sbG93aW5nIGNvZGUuDQoNClNvIEkgc3VnZ2VzdCB0byBhZGQgdGhlIHBpbmN0cmxfd2xhbiBh
bG9uZyB3aXRoIHRoZSB3aWZpX3dha2VfaG9zdCBjaGlsZCBub2RlIGxhdGVyIHRvIHN1cHBvcnQg
dGhlIHdpZmkgV29XTEFOIGZ1bmN0aW9uLiBIZXJlIG9ubHkgbmVlZCB0byBlbmFibGUgdGhlIHVz
ZGhjMSB0byBzdXBwb3J0IHdpZmkgYmFzaWMgZnVuY3Rpb24sIG5vIG5lZWQgdG8gYWRkIHBpbmN0
cmxfd2xhbi4NCg0KJnVzZGhjMSB7DQogICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IiwgInN0
YXRlXzEwMG1oeiIsICJzdGF0ZV8yMDBtaHoiOw0KICAgIHBpbmN0cmwtMCA9IDwmcGluY3RybF91
c2RoYzE+LCA8JnBpbmN0cmxfd2xhbj47DQogICAgcGluY3RybC0xID0gPCZwaW5jdHJsX3VzZGhj
MV8xMDBtaHo+LCA8JnBpbmN0cmxfd2xhbj47DQogICAgcGluY3RybC0yID0gPCZwaW5jdHJsX3Vz
ZGhjMV8yMDBtaHo+LCA8JnBpbmN0cmxfd2xhbj47DQogICAgYnVzLXdpZHRoID0gPDQ+Ow0KICAg
IGtlZXAtcG93ZXItaW4tc3VzcGVuZDsNCiAgICBub24tcmVtb3ZhYmxlOw0KICAgIHdha2V1cC1z
b3VyY2U7DQogICAgbW1jLXB3cnNlcSA9IDwmdXNkaGMxX3B3cnNlcT47DQogICAgc3RhdHVzID0g
Im9rYXkiOw0KDQogICAgd2lmaV93YWtlX2hvc3Qgew0KICAgICAgICBjb21wYXRpYmxlID0gIm54
cCx3aWZpLXdha2UtaG9zdCI7DQogICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8JmdwaW8yPjsN
CiAgICAgICAgaW50ZXJydXB0cyA9IDw5IElSUV9UWVBFX0xFVkVMX0xPVz47DQogICAgICAgIGlu
dGVycnVwdC1uYW1lcyA9ICJob3N0LXdha2UiOw0KICAgIH07DQp9Ow0KDQpCZXN0IFJlZ2FyZHMN
ClNoZXJyeQ0K
