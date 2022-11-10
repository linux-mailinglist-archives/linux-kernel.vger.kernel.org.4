Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22BA6240A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiKJLEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKJLES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:04:18 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80045.outbound.protection.outlook.com [40.107.8.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884A511825;
        Thu, 10 Nov 2022 03:04:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beNjQQoKg6A4T2v34EFqtnXPlWMURxF6KJ4KKVmrv5e8Kj5ejwc2yfMXAceNbm6EpcsClasGlquH7lGdZ9+xE+GygIN0qRAq0e3HZWWQhIFBOqAEwmuwFNpmvetblU1tK84GXYoUJUWpWeiifYZ8j6mm3qK/ZOqlQjoOF5TSZAhCXtiO6xZaTR5majVgl7Ofn8MPQL3aqqScixA5Ylydx97UTtOpTA4fOWw8/M7uk7pmdODA11pmg9nUWuFGwDjudNeKVcTrsfK3syzl4t9xDUq+vuSiamQVYlSpmaNaL29zZfBzoQZnVPmIaR2yyypo9k11ISoNzqq/2I3jeodhgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqW4QqDhhmTOvw7z9U/Hd8JO4jTZc9OmH4xEfCLfEaA=;
 b=NfwT+v2LYcJhvhoVq0HU06MoxK0upez/btzL/07ML3wVBs1nYwVk2kTyBBey348UuNCvfu2VoCxqpE3hzPL9D0mLaZpueUE/yaXmCDXprdn5KIcVa3fFTL3Y5KVunx0+lzSTm5Ll4MnMdN2BWT1g2FmlknNYJK3gSeHL/rJZ+Q+WLcpZfUnoFMFUh1WW25n6kXyoMRQMag3ePGBUNItk6MimgQqONYQ1aShj8zNA+IHCuGQ4B1alNQUzlMapQA8Q7L5TrYyaCsB4xq5KQQGuV9QEVHr/JRLyhk6h6ZifkHurIrTnaWN25JvpzL2iLcA1t8W896P7AVBrtnpAbYOgwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqW4QqDhhmTOvw7z9U/Hd8JO4jTZc9OmH4xEfCLfEaA=;
 b=CetZ5qJErJBhu1SP7CAb0cRhmNXrPkkHhHP0lapvYoDREtC7Zo4chKcCULwb5WRXu6x9Euv7Y46qoeOBmfoReYxumqrONE8N61PcupM5/geJmoCD0uXwZZKlSuCB+qX6RJbu9AY0Cf3HCVJAwUtN4X0n59QZHdk5qEknEvFi/70=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB7975.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 11:04:14 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d%3]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 11:04:13 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] tty: serial: fsl_lpuart: Add runtime pm support
Thread-Topic: [PATCH 2/2] tty: serial: fsl_lpuart: Add runtime pm support
Thread-Index: AQHY9CpKH/ErgyZCK06ksJmZ1l7xoK42iAwAgAF3blA=
Date:   Thu, 10 Nov 2022 11:04:13 +0000
Message-ID: <AS8PR04MB84042672C50AA5F26B0A68BE92019@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20221109105659.17381-1-sherry.sun@nxp.com>
 <20221109105659.17381-3-sherry.sun@nxp.com>
 <50752c1b-fea-af8b-6efd-ef0cd594cb@linux.intel.com>
In-Reply-To: <50752c1b-fea-af8b-6efd-ef0cd594cb@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|AS8PR04MB7975:EE_
x-ms-office365-filtering-correlation-id: 579c0f18-df3c-46f0-b524-08dac30b4d87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5GQ6xpngcIGrrmG5kX/G8CPla1kkuNvghsQwmcZ7TaHGUS+85PaZTg/ECtCNGsD3UGIDQvABFHIMxPJ3nAlisTKFdAjVDdinJ9PYpSzwElE6ykz/QKcvTq1AYmUy+AYKgTjdGjXQ30BnM119vxYE6u/yCuLttigu1u8YXFSYB4iuXt+om0mEtnzLEiwTLpfphcIj+jZLUbReG34NCC59C/cMftB9NSRGUQOmFeLOo4Fg2G7DpaaxlY6++WaafKdihHqDVjaGIAB3VVDpUTz59/dWD/66cXSiaI3agpPKjhplvSk7kw5wHtnmFDK4GRDJv6m6ERYKHraTqiRT5DP+KHSUTG4bOstbD/fHFEDwR2Awr8bQpkb6tDHTWKnhQkWE61rg0OMMJRQ4cOWaJL1rvcB5zi+IovVy/Dn5GKvb5x5pS3+nrKiqlr1C59ROAQSERC61caJ0eTWiAPBgBBXa3kZduU6rTaiyjtfzGTWodJSwu7s8r8kmVihX2kaCeFXMU4ry3LvU56BhqAXBWBz3cuEEK44o8UjbaHnaE7Gf+rkKVh542EcuOlvnjg6iIhholmOrfMteJE0eEFRG/AVlPjBselzV7y4zHCbv9VHKkwhowSiYPpw42CykqR1tqGREV8Jl2m3Mneayj46WH1QxSBJbHFxerpnVQAPHreKS0xQDvqI/CzNtgK1/KCnbenwn5EQiC0+Bl1JgTnpUQei2YUOPw3NbUeTfw8IUM3w5TFurqSGuCnDl/MmbBwBhtTXUDQfmCLhzbOjW+pvJtNPq/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199015)(55016003)(54906003)(66946007)(86362001)(6916009)(41300700001)(8936002)(52536014)(5660300002)(71200400001)(38070700005)(38100700002)(76116006)(478600001)(2906002)(44832011)(33656002)(9686003)(53546011)(6506007)(64756008)(7696005)(8676002)(26005)(4326008)(66556008)(66476007)(66446008)(316002)(66574015)(83380400001)(186003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2ZxM3dnM1NEU3dnaDRuNnBzN1l2VE9yZGhsT0QzZTUzNjF4OTJWL3pRT1RW?=
 =?utf-8?B?c3hpaStTQTlzWWp4TEtUYjdTK290cFZTNlYzWXRXVmpHVjU4d0NTQmRYdk1H?=
 =?utf-8?B?QlFoNmxwSFN1bUJvTytOZkVVWHJBVlBiSUZyWlhJVTZoUGw2aXl3K1hYeTZz?=
 =?utf-8?B?V25BT1l6N0RMUkNDSEJQc0gzMkFteXdWWjFlV2I0d1ZoenBvZmVjcjdRNUht?=
 =?utf-8?B?cTNabFJJaDREaWVpWlpmMnpFKzU0Wlcza3JQYkRjUHJPWXdYaUlxOFh0V1l6?=
 =?utf-8?B?dE5nd0dTZG5tMml2UHV0UUNPNmNQWlU3R2tTM3d0dmF1MlBJQmpNUVVHQXV2?=
 =?utf-8?B?TjdhY29qWDJwZTE0UkZrb3lIQkV1VThlTUNIYlY2MjFsTU5haHNjZk1lK1d0?=
 =?utf-8?B?UWdSVUdwWk44bk1hbTU0c1cyV1ptakJGaVF3UC9Ua1FqbElpZDNTbWlBck9R?=
 =?utf-8?B?QW5uVTJ6YWI5TlZiN0xlT0xwU3ovZUluWlJIMHgyR2J3OU8zalVKeitmbTNN?=
 =?utf-8?B?VktOK2wwZ2pqNGs4QWdhUEFDY0lnM1RWWjgxTmlyeHpDcGNnaEovYVFqOWlZ?=
 =?utf-8?B?NjJsdXpvVUtCQnFhNk5ENUExMHFpUGx0b203aWtMT1dJOS9SZXllNDRTK1BS?=
 =?utf-8?B?bVRnK2FONCtzQjhRM3hZWFE1QU0zQU9EanhDQXJkcVl1Z3J5TTdtS0xhNm94?=
 =?utf-8?B?RndQN1M4WmFUUFViV01oMndVRGRZVDlNVWtjbXl0SGFOYThadE1OcnlsWXBV?=
 =?utf-8?B?Y0tKbFF5cTJGT2dDTjFmNkhBeVRMRzJmSkhTSGlDQTNyN203TTNpWFNVNXRv?=
 =?utf-8?B?d25LU2s3cVNvVlhzRTFnWGljU080Z042Z0RJRnJNK3NvSkh4R1U1VFpHakRh?=
 =?utf-8?B?NG5lbEVHRjcxY1cvT0MvZ3dsbFR5clZ3VUNQNHFsM2loVTFuRitMRDA1ejd2?=
 =?utf-8?B?bHlXRGVOZGQ0RUF2Sm1NS25wS1RtdGZBS3AzQkRGNzJ1a0VuKzZheUJVZ3dC?=
 =?utf-8?B?MEt6cVhZMkVtbjFMeWtia0IrcW1aTlROZlpnaHh1bkI2L1NiNXpGQlZLa2Fh?=
 =?utf-8?B?RWhLNFdqdnpQWXdzYncxdG4vZUZDb2pUcm84K1RFSkt5aGcvbmNUSGlCUTNZ?=
 =?utf-8?B?SGVpQlNwSTkrNlg2aHNkc1h4UGczNU1mRjdMZFRHRU9NSmRYZlZxdTBONzh4?=
 =?utf-8?B?WWdES3JpT2NEY2dpcUhVTHZRMG41WlJVNmNnamtHR0dYa1ZWaHVzU2Z4ckw2?=
 =?utf-8?B?TUt3MmdVdmU0KzVWZGIrblh2VnozRHBSQ3lJNG5DRUNrU0ljV25ZeHJSb0Vw?=
 =?utf-8?B?TnNiNER4UnJvQWdsMnliYTkwbkZoTEErcWdtcHdUUStDekRHMzFEOEIwbGdX?=
 =?utf-8?B?Vy9BS3YxSk40OWNoOGtoSlp3QnoxNWdqM3pHY1ZYTTJFY1RrTHh6SEZ0Z1pQ?=
 =?utf-8?B?WDRzbEpNcW9aaWVDSWRmWU9yOEJpZ0twSGF4RGU0Nkp1bVBGS3BMdzhNUUdq?=
 =?utf-8?B?UVZDeUpPaktSazJDWlp6Wm5EQkFyaW45WGpFOER1N05yZ0V3THRVRGt2ZTM4?=
 =?utf-8?B?d0wrL21yemIxaWlnUENKZnJxclRYeUV0cHAzc3lkZkdRL01Mb0tJWWlLSlkr?=
 =?utf-8?B?VDh1QXFvcFlHY0pxVE5wMHM2K1VPVnFWb09VUXNFa1I4UGpBQ0h6bFdBRWhy?=
 =?utf-8?B?WUl3Q2Q1Y2NobVFyM3kxbkkzYWo3YkhHUlhtMXFRU0pWWUxpVUdGUXozc2Mr?=
 =?utf-8?B?bHRXcDloYkUxR0g1OFh4akZ5Q1ZYa01lZmVUdFpjZDM3QWtDMFlRMGxDcE9j?=
 =?utf-8?B?S3lPaWgrWm4zeDJsUXhiTGlQZWdSSWNRelUxNERiNGoydEc3UkVtVTlqQTlK?=
 =?utf-8?B?Y0VnSjE2OWp5RndodEpzK25WVXRZOXBXUXRTTGhKeHJ1bExVbGtxUXl5Y2Q3?=
 =?utf-8?B?T3U5MmE4Qis2WllDLzZnNUcyR2ZrVlpmZGtGclF5dTVyUlVEanFRbnA1a245?=
 =?utf-8?B?aU5mUjhVeW9BSUpmaUNpQm1YZThDM2x3czR5SDJzS3NjTW40UEF0a0hhVHNT?=
 =?utf-8?B?MU16NStGeEViYXYzUWlIaWEyM2k0NDVIKzJNbWFNQVU4c3MxcXUwWVJyTWM1?=
 =?utf-8?Q?kA1BSqeeXAroXxBZWNEDqilC0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579c0f18-df3c-46f0-b524-08dac30b4d87
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 11:04:13.8673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9LGxZxVP2UDCfuvpctu89BIBJpo8suv5uLfA8Fwmk8cfFood2t7OjXl/J2/1PnnQP8cMS5sj5JY2eo3rE2S0Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7975
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWxwbyBKw6RydmluZW4g
PGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPg0KPiBTZW50OiAyMDIy5bm0MTHmnIg55pel
IDIwOjM5DQo+IFRvOiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+IENjOiBHcmVn
IEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgSmlyaSBTbGFieQ0K
PiA8amlyaXNsYWJ5QGtlcm5lbC5vcmc+OyBsaW51eC1zZXJpYWwgPGxpbnV4LXNlcmlhbEB2Z2Vy
Lmtlcm5lbC5vcmc+OyBMS01MDQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgZGwt
bGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJd
IHR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0OiBBZGQgcnVudGltZSBwbSBzdXBwb3J0DQo+IA0KPiBP
biBXZWQsIDkgTm92IDIwMjIsIFNoZXJyeSBTdW4gd3JvdGU6DQo+IA0KPiA+IEFkZCBydW50aW1l
IHBtIHN1cHBvcnQgdG8gbWFuYWdlIHRoZSBscHVhcnQgY2xvY2suDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMgfCA2MA0KPiA+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMNCj4g
PiBiL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMgaW5kZXggNDc0OTQzY2IwNmIyLi5l
Njc4YTdhYWY3ZTQNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvZnNs
X2xwdWFydC5jDQo+ID4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0KPiA+
IEBAIC0xOSw2ICsxOSw3IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4g
PiAgI2luY2x1ZGUgPGxpbnV4L29mX2RtYS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcGluY3Ry
bC9jb25zdW1lci5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPg0KPiA+ICAj
aW5jbHVkZSA8bGludXgvc2VyaWFsX2NvcmUuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3NsYWIu
aD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3R0eV9mbGlwLmg+DQo+ID4gQEAgLTIzNSw2ICsyMzYs
NyBAQA0KPiA+DQo+ID4gIC8qIFJ4IERNQSB0aW1lb3V0IGluIG1zLCB3aGljaCBpcyB1c2VkIHRv
IGNhbGN1bGF0ZSBSeCByaW5nIGJ1ZmZlciBzaXplICovDQo+ID4gICNkZWZpbmUgRE1BX1JYX1RJ
TUVPVVQJCSgxMCkNCj4gPiArI2RlZmluZSBVQVJUX0FVVE9TVVNQRU5EX1RJTUVPVVQJMzAwMA0K
PiA+DQo+ID4gICNkZWZpbmUgRFJJVkVSX05BTUUJImZzbC1scHVhcnQiDQo+ID4gICNkZWZpbmUg
REVWX05BTUUJInR0eUxQIg0KPiA+IEBAIC03OTUsNiArNzk3LDIwIEBAIHN0YXRpYyB2b2lkIGxw
dWFydDMyX3N0YXJ0X3R4KHN0cnVjdCB1YXJ0X3BvcnQNCj4gKnBvcnQpDQo+ID4gIAl9DQo+ID4g
IH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZA0KPiA+ICtscHVhcnRfdWFydF9wbShzdHJ1Y3QgdWFy
dF9wb3J0ICpwb3J0LCB1bnNpZ25lZCBpbnQgc3RhdGUsIHVuc2lnbmVkDQo+ID4gK2ludCBvbGRz
dGF0ZSkgew0KPiA+ICsJc3dpdGNoIChzdGF0ZSkgew0KPiA+ICsJY2FzZSBVQVJUX1BNX1NUQVRF
X09GRjoNCj4gPiArCQlwbV9ydW50aW1lX21hcmtfbGFzdF9idXN5KHBvcnQtPmRldik7DQo+ID4g
KwkJcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQocG9ydC0+ZGV2KTsNCj4gPiArCQlicmVhazsN
Cj4gPiArCWRlZmF1bHQ6DQo+ID4gKwkJcG1fcnVudGltZV9nZXRfc3luYyhwb3J0LT5kZXYpOw0K
PiA+ICsJCWJyZWFrOw0KPiA+ICsJfQ0KPiA+ICt9DQo+ID4gKw0KPiA+ICAvKiByZXR1cm4gVElP
Q1NFUl9URU1UIHdoZW4gdHJhbnNtaXR0ZXIgaXMgbm90IGJ1c3kgKi8gIHN0YXRpYw0KPiA+IHVu
c2lnbmVkIGludCBscHVhcnRfdHhfZW1wdHkoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkgIHsgQEAg
LTIyNDMsNg0KPiA+ICsyMjU5LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB1YXJ0X29wcyBscHVh
cnRfcG9wcyA9IHsNCj4gPiAgCS5zdGFydHVwCT0gbHB1YXJ0X3N0YXJ0dXAsDQo+ID4gIAkuc2h1
dGRvd24JPSBscHVhcnRfc2h1dGRvd24sDQo+ID4gIAkuc2V0X3Rlcm1pb3MJPSBscHVhcnRfc2V0
X3Rlcm1pb3MsDQo+ID4gKwkucG0JCT0gbHB1YXJ0X3VhcnRfcG0sDQo+ID4gIAkudHlwZQkJPSBs
cHVhcnRfdHlwZSwNCj4gPiAgCS5yZXF1ZXN0X3BvcnQJPSBscHVhcnRfcmVxdWVzdF9wb3J0LA0K
PiA+ICAJLnJlbGVhc2VfcG9ydAk9IGxwdWFydF9yZWxlYXNlX3BvcnQsDQo+ID4gQEAgLTIyNjcs
NiArMjI4NCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdWFydF9vcHMgbHB1YXJ0MzJfcG9wcyA9
IHsNCj4gPiAgCS5zdGFydHVwCT0gbHB1YXJ0MzJfc3RhcnR1cCwNCj4gPiAgCS5zaHV0ZG93bgk9
IGxwdWFydDMyX3NodXRkb3duLA0KPiA+ICAJLnNldF90ZXJtaW9zCT0gbHB1YXJ0MzJfc2V0X3Rl
cm1pb3MsDQo+ID4gKwkucG0JCT0gbHB1YXJ0X3VhcnRfcG0sDQo+ID4gIAkudHlwZQkJPSBscHVh
cnRfdHlwZSwNCj4gPiAgCS5yZXF1ZXN0X3BvcnQJPSBscHVhcnRfcmVxdWVzdF9wb3J0LA0KPiA+
ICAJLnJlbGVhc2VfcG9ydAk9IGxwdWFydF9yZWxlYXNlX3BvcnQsDQo+ID4gQEAgLTI3NDcsNiAr
Mjc2NSwxMSBAQCBzdGF0aWMgaW50IGxwdWFydF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
DQo+ICpwZGV2KQ0KPiA+ICAJCWhhbmRsZXIgPSBscHVhcnRfaW50Ow0KPiA+ICAJfQ0KPiA+DQo+
ID4gKwlwbV9ydW50aW1lX3VzZV9hdXRvc3VzcGVuZCgmcGRldi0+ZGV2KTsNCj4gPiArCXBtX3J1
bnRpbWVfc2V0X2F1dG9zdXNwZW5kX2RlbGF5KCZwZGV2LT5kZXYsDQo+IFVBUlRfQVVUT1NVU1BF
TkRfVElNRU9VVCk7DQo+ID4gKwlwbV9ydW50aW1lX3NldF9hY3RpdmUoJnBkZXYtPmRldik7DQo+
ID4gKwlwbV9ydW50aW1lX2VuYWJsZSgmcGRldi0+ZGV2KTsNCj4gPiArDQo+ID4gIAlyZXQgPSBs
cHVhcnRfZ2xvYmFsX3Jlc2V0KHNwb3J0KTsNCj4gPiAgCWlmIChyZXQpDQo+ID4gIAkJZ290byBm
YWlsZWRfcmVzZXQ7DQo+ID4gQEAgLTI3NzEsNiArMjc5NCw5IEBAIHN0YXRpYyBpbnQgbHB1YXJ0
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gPiAqcGRldikNCj4gPiAgZmFpbGVkX2F0
dGFjaF9wb3J0Og0KPiA+ICBmYWlsZWRfZ2V0X3JzNDg1Og0KPiA+ICBmYWlsZWRfcmVzZXQ6DQo+
ID4gKwlwbV9ydW50aW1lX2Rpc2FibGUoJnBkZXYtPmRldik7DQo+ID4gKwlwbV9ydW50aW1lX3Nl
dF9zdXNwZW5kZWQoJnBkZXYtPmRldik7DQo+ID4gKwlwbV9ydW50aW1lX2RvbnRfdXNlX2F1dG9z
dXNwZW5kKCZwZGV2LT5kZXYpOw0KPiA+ICAJbHB1YXJ0X2Rpc2FibGVfY2xrcyhzcG9ydCk7DQo+
ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4gQEAgLTI3ODksOSArMjgxNSwzMCBAQCBzdGF0
aWMgaW50IGxwdWFydF9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4g
PiAgCWlmIChzcG9ydC0+ZG1hX3J4X2NoYW4pDQo+ID4gIAkJZG1hX3JlbGVhc2VfY2hhbm5lbChz
cG9ydC0+ZG1hX3J4X2NoYW4pOw0KPiA+DQo+ID4gKwlwbV9ydW50aW1lX2Rpc2FibGUoJnBkZXYt
PmRldik7DQo+ID4gKwlwbV9ydW50aW1lX3NldF9zdXNwZW5kZWQoJnBkZXYtPmRldik7DQo+ID4g
KwlwbV9ydW50aW1lX2RvbnRfdXNlX2F1dG9zdXNwZW5kKCZwZGV2LT5kZXYpOw0KPiA+ICAJcmV0
dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGxwdWFy
dF9ydW50aW1lX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiANCj4gSUlSQywgdGhlIFBN
X09QUyBtYWNyb3MgY29udGFpbiBzcGVjaWFsIGxvZ2ljIHRvIG1ha2UgX19tYXliZV91bnVzZWQN
Cj4gdW5uZWNlc3NhcnkgZm9yIHRoZXNlIGZ1bmN0aW9ucy4NCj4gDQoNCkhJIElscG8sIHlvdSBh
cmUgcmlnaHQsIHNlZW1zIHVzZSBwbV9wdHIoKSBjYW4gcmVtb3ZlIHRoZSBuZWVkIHRvIG1hcmsg
dGhlIHBtIGZ1bmN0aW9ucyBhcyBfX21heWJlX3VudXNlZC4NCkkgd2lsbCBjaGFuZ2UgdGhpcyBp
biBWMiBwYXRjaC4NCg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCg0KDQo+IC0tDQo+ICBpLg0KPiAN
Cj4gDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSB0b19wbGF0
Zm9ybV9kZXZpY2UoZGV2KTsNCj4gPiArCXN0cnVjdCBscHVhcnRfcG9ydCAqc3BvcnQgPSBwbGF0
Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gPiArDQo+ID4gKwlscHVhcnRfZGlzYWJsZV9jbGtz
KHNwb3J0KTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0
YXRpYyBpbnQgX19tYXliZV91bnVzZWQgbHB1YXJ0X3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZp
Y2UgKmRldikNCj4gPiArew0KPiA+ICsJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiA9IHRv
X3BsYXRmb3JtX2RldmljZShkZXYpOw0KPiA+ICsJc3RydWN0IGxwdWFydF9wb3J0ICpzcG9ydCA9
IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KPiA+ICsNCj4gPiArCXJldHVybiBscHVhcnRf
ZW5hYmxlX2Nsa3Moc3BvcnQpOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgc3RhdGljIHZvaWQgc2Vy
aWFsX2xwdWFydF9lbmFibGVfd2FrZXVwKHN0cnVjdCBscHVhcnRfcG9ydCAqc3BvcnQsIGJvb2wg
b24pDQo+ID4gIHsNCj4gPiAgCXVuc2lnbmVkIGludCB2YWwsIGJhdWQ7DQo+ID4gQEAgLTI5Mzcs
NiArMjk4NCwxMCBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkDQo+IGxwdWFydF9zdXNwZW5k
KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgCQkJc3BvcnQtPmRtYV90eF9pbl9wcm9ncmVzcyA9
IGZhbHNlOw0KPiA+ICAJCQlkbWFlbmdpbmVfdGVybWluYXRlX2FsbChzcG9ydC0+ZG1hX3R4X2No
YW4pOw0KPiA+ICAJCX0NCj4gPiArCX0gZWxzZSBpZiAocG1fcnVudGltZV9hY3RpdmUoc3BvcnQt
PnBvcnQuZGV2KSkgew0KPiA+ICsJCWxwdWFydF9kaXNhYmxlX2Nsa3Moc3BvcnQpOw0KPiA+ICsJ
CXBtX3J1bnRpbWVfZGlzYWJsZShzcG9ydC0+cG9ydC5kZXYpOw0KPiA+ICsJCXBtX3J1bnRpbWVf
c2V0X3N1c3BlbmRlZChzcG9ydC0+cG9ydC5kZXYpOw0KPiA+ICAJfQ0KPiA+DQo+ID4gIAlyZXR1
cm4gMDsNCj4gPiBAQCAtMjk3MSwxMiArMzAyMiwxOSBAQCBzdGF0aWMgdm9pZCBscHVhcnRfY29u
c29sZV9maXh1cChzdHJ1Y3QNCj4gbHB1YXJ0X3BvcnQgKnNwb3J0KQ0KPiA+ICBzdGF0aWMgaW50
IF9fbWF5YmVfdW51c2VkIGxwdWFydF9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICB7
DQo+ID4gIAlzdHJ1Y3QgbHB1YXJ0X3BvcnQgKnNwb3J0ID0gZGV2X2dldF9kcnZkYXRhKGRldik7
DQo+ID4gKwlpbnQgcmV0Ow0KPiA+DQo+ID4gIAlpZiAobHB1YXJ0X3Vwb3J0X2lzX2FjdGl2ZShz
cG9ydCkpIHsNCj4gPiAgCQlpZiAobHB1YXJ0X2lzXzMyKHNwb3J0KSkNCj4gPiAgCQkJbHB1YXJ0
MzJfaHdfc2V0dXAoc3BvcnQpOw0KPiA+ICAJCWVsc2UNCj4gPiAgCQkJbHB1YXJ0X2h3X3NldHVw
KHNwb3J0KTsNCj4gPiArCX0gZWxzZSBpZiAocG1fcnVudGltZV9hY3RpdmUoc3BvcnQtPnBvcnQu
ZGV2KSkgew0KPiA+ICsJCXJldCA9IGxwdWFydF9lbmFibGVfY2xrcyhzcG9ydCk7DQo+ID4gKwkJ
aWYgKHJldCkNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArCQlwbV9ydW50aW1lX3NldF9hY3Rp
dmUoc3BvcnQtPnBvcnQuZGV2KTsNCj4gPiArCQlwbV9ydW50aW1lX2VuYWJsZShzcG9ydC0+cG9y
dC5kZXYpOw0KPiA+ICAJfQ0KPiA+DQo+ID4gIAlscHVhcnRfY29uc29sZV9maXh1cChzcG9ydCk7
DQo+ID4gQEAgLTI5ODYsNiArMzA0NCw4IEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgbHB1
YXJ0X3Jlc3VtZShzdHJ1Y3QNCj4gZGV2aWNlICpkZXYpDQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0
aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgbHB1YXJ0X3BtX29wcyA9IHsNCj4gPiArCVNFVF9S
VU5USU1FX1BNX09QUyhscHVhcnRfcnVudGltZV9zdXNwZW5kLA0KPiA+ICsJCQkgICBscHVhcnRf
cnVudGltZV9yZXN1bWUsIE5VTEwpDQo+ID4gIAlTRVRfTk9JUlFfU1lTVEVNX1NMRUVQX1BNX09Q
UyhscHVhcnRfc3VzcGVuZF9ub2lycSwNCj4gPiAgCQkJCSAgICAgIGxwdWFydF9yZXN1bWVfbm9p
cnEpDQo+ID4gIAlTRVRfU1lTVEVNX1NMRUVQX1BNX09QUyhscHVhcnRfc3VzcGVuZCwgbHB1YXJ0
X3Jlc3VtZSkNCj4gPg0KDQo=
