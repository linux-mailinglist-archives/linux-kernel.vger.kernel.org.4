Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BC671776C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbjEaHAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjEaHAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:00:42 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8D011F;
        Wed, 31 May 2023 00:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6c9Pd9b/IHhrjOUymJb+/0XJFWAjiacI2HITDRI+kEx7gRiK8moro6fRAYM+DyDIoFdXr2Dx+XNXBpzJLOOCdInPrw3lP0YFQ26vS9IBwDotKmYjs19KpOW5SCsy56COnZqgEp4PeFaB6zlFepGtQotREqjZR1NFOl6PRplOE7gQFPYT1itBSUnE+z0yZp76u9TB4P57PwNMxN8rntBWGklkkl6Cv8xY6Pld47ON18FeQEntmzYDFC3cpiRLrsm1X82gjDP54o8U7xqAtdYjhn5dZxFbUaaDk8/bgjUz7PHSH9pY7pMIwtq7Pg0BydcOeTaisH7RKClDcN4XbnmDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bg2vN2uwsEDVNfTFzyrEIv01ekUkOySztEYgghdjymg=;
 b=LL4ZQujQjkj+JY772IydYu+4XuSuvZ9RhhykNx0BzxEPTV019H304B2h1cPtIjAdjx1s5izUy9k8QjCDBqyudoZ+n75E+NOXZ55I/kVKcsZ34lp7JN/9kDoWZXwERaDiLcZh1zrHdiDkKeuxrUnCw0KgB4BoM56StfUGH2guaux4AH3mHlsboT75IT0gpPR9CRp2F23We/FmOVV57kAdC+00FeCXHI441LE6Tg2d3SpCBKWA6tL+CmNUc2rKSmeQpIjij3SPCnndZrWsBN8QsaYM7hBzpNBuKrG1TWZ5eYpJEjt8HO4/6g+0TL+waMHrZihfPPZfun8sUfJuFGw4Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bg2vN2uwsEDVNfTFzyrEIv01ekUkOySztEYgghdjymg=;
 b=ad2meu0npjcVWWP8TKVYaKeZDHQi/wdqn/Yra767YY8/vzOv2yZfUX04DJWTb46zrcu6OO9skLrOGtBDOzuAgRmicwbqppRgo+qDWBtTpcQg9e9L0HEz7AVoj2BtYAmArIkEmmJSyYjeMFHAZCcLjyv6g5iEOw8imlY8r99w5gE=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by VE1PR04MB7294.eurprd04.prod.outlook.com (2603:10a6:800:1a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 07:00:27 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::1a8e:7e33:7f24:d77c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::1a8e:7e33:7f24:d77c%5]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 07:00:27 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v1 1/3] dt-bindings: regulator: pca9450: add
 pca9451a support
Thread-Topic: [EXT] Re: [PATCH v1 1/3] dt-bindings: regulator: pca9450: add
 pca9451a support
Thread-Index: AQHZk4yOFzh1S8pCcU2cJ06GozpCXq9z8twAgAAAtAA=
Date:   Wed, 31 May 2023 07:00:27 +0000
Message-ID: <AM6PR04MB592550F359F2DE8F7F0F0AC7E1489@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20230531065724.3671795-1-joy.zou@nxp.com>
 <20230531065724.3671795-2-joy.zou@nxp.com>
 <f343458e-519c-1e5c-e48f-acfed2c00ad7@linaro.org>
In-Reply-To: <f343458e-519c-1e5c-e48f-acfed2c00ad7@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5925:EE_|VE1PR04MB7294:EE_
x-ms-office365-filtering-correlation-id: b9d110cf-213b-497b-f99c-08db61a4b6d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b2LVLPSGpKdpGxRJArydzS4eZTUSIJy5d+OvO6URLsglHXDGLXMx3Jst24Tlvnv93u/46SCkugcZogz1a4jrLaHuDx22WtGmVROGV8WhVQvffi29WQu6vobIwHa1sv91XdN9Qig2A/DuySnRZlBatpto47YRiTv7v+XNFsmBgUkb1+UlBsijK3VNpjh3YUU//wSKVx4xTp7d1ZOTwu9LDRt3ey9g4P+c6FMAK1fVpVLHbwlIyVBqJ6j80Xm155BAAjFWw6otibJxa83D1khCu7PCaDvG7PfJQu5OsKsfTc9AZfEaWGWiTevCm6wwCKMZzg0w7ehjtjRM59h6IiJUi2npGQ+DP5aroNWmO41DvhD4s/a6eGjm+H++ttfJdr8Uh17a4cbtmgh+nrnt7odUV64p8wid+16T2XW22hpQ3jAbnRXIPBBfUjkIXsEMOlRfrTL04XP18OJRfoiQG3Djf0y+DblXzQvC1C+KgzHOl1V08SLFdAUO0UqDc40PwOiRQWCeQ6dfyDPLajABP6/jhVexQ7jrtBzRdO7exdSCqhUhjKu6rw9IlPR00KGhfrhJcUDaxxBsB3NL1ACJ3BQEsMQFpiyUMUQwR0P+wJ8a6dd9I5xiZ9t3Knayp3VPBzCR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199021)(186003)(38100700002)(41300700001)(83380400001)(9686003)(26005)(6506007)(53546011)(7696005)(478600001)(110136005)(54906003)(71200400001)(4326008)(122000001)(76116006)(64756008)(66446008)(66476007)(66946007)(66556008)(55016003)(316002)(52536014)(8936002)(5660300002)(8676002)(7416002)(44832011)(2906002)(33656002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MG4zcTBWdENxNThBYlpMcmd6a0hMQnFuOE80SEM4NFdPeTRVTFVqWTh2V2d3?=
 =?utf-8?B?S0pCakhDZUZyQmV4dzF5OVhFZ2MvRDJaRDRNZXN0T0FjTDBXb0wra3M2eWdZ?=
 =?utf-8?B?M3VOekdkbktsSGZvanlnbTN4d0EzbjhJUG9rbWc4MWRUVXR4Q1FjaENscll2?=
 =?utf-8?B?bk9FTFFPWkhmakdsMllxOUNSbjRjcnhLN2dOcXlFOEtpaktIMUZzWUZYRFVX?=
 =?utf-8?B?SWpscTh3T2pSVy9uUmUzRERwR2RaTkNUbDFGMlFCWHYxYWNaR0ZydDltdnFW?=
 =?utf-8?B?VzVnb3daMGJ3cEcwOWlhUTUybnB1Vk5MSWV6MUtPbXdxbm0wVUQ3WGF0YUFD?=
 =?utf-8?B?K3pDbVZDZDhoVnNucWUwcHlPWHVxSUcxMDE0T2xzWnQxc0ZiNnIvWmg4aTVk?=
 =?utf-8?B?NTN1S0JxUVYvK2ZxdkNpMXNzTWdGVWxRUHp5aHJqOGpYWXpzTDF1YWtubGx6?=
 =?utf-8?B?dGJ0SDBMOUNsa2N6cHh3ZnBwZjM3SWpSVlNDTHJjTUF3VE0vcUE0UDJNeXk3?=
 =?utf-8?B?NWZuZ0F4dWgvY2d2K3FOTXJpQmFsbWFUbVV4c0xvaHlwaW83THRYZUVGM0pZ?=
 =?utf-8?B?cVNDcXVWMjJ0bFkySDQ2c2tDdkF1ZythWWEwTGRYOHNsc1FlRC9pOHlyaHk3?=
 =?utf-8?B?Yzhkc09JdjQ3WlYxT1FkdStqT012aDR2REtFWWpVOE1jMjZoUzhKZmwyM1k2?=
 =?utf-8?B?Z2VFRVlINjZ2M2JVcDQ0ejh2bk9RalI1R2xDNW8rS0czTmsxT0h3ZExyaVdZ?=
 =?utf-8?B?WlZVSmF4Z2NxL2JQZlRObjNPSGZPWjZGcVlaYitSd1VqZDVkamd5UWV1VHV5?=
 =?utf-8?B?ajd1RVR6NWp0WDVFOVJrdzAvc1pYa0xGcUdrcksyNWZhNUpLUE14R2dQMmFX?=
 =?utf-8?B?eHZuaVlXdnN0N2l0TS9va3B1NHN0RUxBNWVNRStoYUpYcGdGRy9pYmttbDUz?=
 =?utf-8?B?SUhZVFFjMDZlZkNUZ0M0aXNjS1hGdjFjQWd6bzhCRFp0YmIvdEZFRStyQUN1?=
 =?utf-8?B?bWo3UW1Sck1qbDZJM1FqcVVodVA3TzYxZEdhYVd0czA5bWp0T05CeitML1RL?=
 =?utf-8?B?V2dyTHhHOU54RmRFWWI2bjhYMGRUdzJkd0ovR213cnZRUlQ5V1B4TlN5OCs2?=
 =?utf-8?B?MEt1VlRxWURyTmovQ1VVQWRaamJuUTh4WFhtYk1UWUFaWTFrZWwrcVJ3elJk?=
 =?utf-8?B?QnJXV2VXRHMrVFovSWxab3NYNzl4b0lzRjV0K2xwUm9jRjc1MGpOQnl4L2Vi?=
 =?utf-8?B?d2hyYVp4djkrWFpabDY3M1duME9Zd0pIMVY0VFJBakxwNGR0ZmRwVW5WM1JX?=
 =?utf-8?B?bkVIdnZWTlpQY2tvLzBUZnFZRmpKRXlDZEZpSk9MOFQ0VVJNR0pGeGxlT0Zq?=
 =?utf-8?B?WVV2S1lndVllY05VWTRPQ1lvWEwxOW9kQ0kyUW91NUxLdncxVGUxOW5wek1P?=
 =?utf-8?B?NmpWTXFhSzNMRnJDWE9qS1o0VEo4elRPMmFiaE1NNmx1QzMvUTM1RjIxMmpo?=
 =?utf-8?B?SVFaRE0xeW1zZnNXT2R2NXF3Mk9wZXg4RWl6ZWMzbEFUSU0zd0FHdjdVRUxQ?=
 =?utf-8?B?U2JHWnhZWUFRYjZ1aUtINUVkWVRzWG04Mk9LZ2krSHNEOGNZOFJOWkRDQ2p6?=
 =?utf-8?B?blNBOHZvcFV2Vk9qcEFBd1BqMnNFZTAreTVYQ0ltK2w1eWRwTnRoSHYwWWli?=
 =?utf-8?B?VUtKVy9STjMxMURUWEpwcitjTTkyWjc5a1NsRGkxTVlBVWc4V25JTytOT0Q3?=
 =?utf-8?B?cnZUR1RoT0pNYjBPa3R1SmJSZnh1U1JPS1lKZmJhdE4wOTFZZHRRS1hTYS8w?=
 =?utf-8?B?Z2oxdlc0T0JpM2JyUngyYjY5TG1hRjA2bExIejduaUlFZWU2U0hxeUp2bTh4?=
 =?utf-8?B?MHp5eXVSWEV6NWw1aUprMWpyTit3TFN4M0lRc0RERGhXbHZYcHY4OEdBaFly?=
 =?utf-8?B?NnFqLzZLalBST0NJZzg1b3AxTWV4dWhGdExHbFpYMnl1MzBqd2lBNkVzQS9j?=
 =?utf-8?B?eXAzUjV1dWQweUcxL2dlQ0FyMVRvRVN4T2ZqS05EdHpWR3hCMUZpUFE1ekY2?=
 =?utf-8?B?Tm1ZaEhXS0ZzMWNabitvYlJFZWc0Q21BSnJDSTlLTTdPanQ5Vy9VMjI2TUNz?=
 =?utf-8?Q?ocgw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d110cf-213b-497b-f99c-08db61a4b6d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 07:00:27.3060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: spJlzuhxwk7JWnUEig+AlLzkFOtkxrKCHKrxyuDZqDzJ69/NlKOVMUHJRCISTWrt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7294
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogMjAyM+W5tDXmnIgz
MeaXpSAxNDo1Ng0KPiBUbzogSm95IFpvdSA8am95LnpvdUBueHAuY29tPjsgSmFja3kgQmFpIDxw
aW5nLmJhaUBueHAuY29tPjsNCj4gbGdpcmR3b29kQGdtYWlsLmNvbTsgYnJvb25pZUBrZXJuZWwu
b3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJv
Lm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVl
ckBwZW5ndXRyb25peC5kZQ0KPiBDYzoga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBn
bWFpbC5jb207IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFU
Q0ggdjEgMS8zXSBkdC1iaW5kaW5nczogcmVndWxhdG9yOiBwY2E5NDUwOiBhZGQNCj4gcGNhOTQ1
MWEgc3VwcG9ydA0KPiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxl
YXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVu
dHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydA0K
PiB0aGlzIGVtYWlsJyBidXR0b24NCj4gDQo+IA0KPiBPbiAzMS8wNS8yMDIzIDA4OjU3LCBKb3kg
Wm91IHdyb3RlOg0KPiA+IFVwZGF0ZSBwY2E5NDUwIGJpbmRpbmdzLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogSm95IFpvdSA8am95LnpvdUBueHAuY29tPg0KPiA+IC0tLQ0KPiANCj4gU3ViamVj
dCBwcmVmaXggaXM6IHJlZ3VsYXRvcjogZHQtYmluZGluZ3M6IHBjYTk0NTA6DQpJIHdpbGwgZml4
IGl0IGluIHBhdGNoIHYyLg0KVGhhbmtzIEtyenlzenRvZiBLb3psb3dza2khDQpCUg0KSm95IFpv
dQ0KPiANCj4gQWNrZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dz
a2lAbGluYXJvLm9yZz4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
