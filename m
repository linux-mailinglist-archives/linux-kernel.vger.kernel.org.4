Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995E06F8034
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjEEJkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjEEJkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:40:47 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716B1150E6;
        Fri,  5 May 2023 02:40:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bk4s6cFaWc9YvbSUEdG4138s+N5GwmX6sWen0QiEn+snwU2xhWSxYXQLCg1oNsKfb6cLHtmLtPzxHBeTKOmD6NEyaEwbDFuRCVbUdhC03viHWST/n5CpvFgvIPcr/KKLGZXXLSv1RgKPohiERcYGA1NjdFdzgHOxjndE0uW7hk+mwlw5SmwXyMTvia+abifnlmIp/tHLzvykg0woDDlhptMBmVGP9ZgYz4ejCkhPRwhy7DGS7tm/04jJGQcpQgUtezKZqm7bjLWuvquAuxG0ksi8Y+b0Pir+JBca8w+O6u9lQJCv6za5OMOcIn2eJMVQwwvR41Erb1ITi6ITpGEdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lt25NvgWp3FD1IVBnAuWu3Fzety83C//AqUachGXh7I=;
 b=f7Ex5Us/mV+vP4qOLUyRSyHQBUcSc8o7RCeIXTKbU4CW17vqB6e0JrZtrcfhUxyS84LNc/Jyjjm3asQoTH9uC4DJDLcs+oMLV673DpYj6e1xECKVecYbng6x0TSdh83mPM1HhEDAGgPLGJzYswaZGL2/9bWFdVZ8dfDWAxpTlbBUxyE2KNGbEdFWmbIvh0loX5j2pC1wZfjohWS+zkXhrhxZk5n4JHO4I3DMJ3hs+iWDsN6svVC0UgySVaw6fYnBrBdsX83c0zeuANf/Yqjtn17Oe0A44cHrd+z8bivzaRtT8ssKtWZfAyg3wMpKp8Jo3jQxYLCyk1seEeHOvuioBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lt25NvgWp3FD1IVBnAuWu3Fzety83C//AqUachGXh7I=;
 b=rI+NoSFzDI67ovEVJbQuDCDErFcOo/vSBhPBr5cjCBIhrXCEe2O7RxynP5iZ7Nx0wzQoiL22QijuFV3dydDFPq2rBtYJq6aQvUe57hRB+vm5PEVD4nf7qT9D1WhRqoYo4g8ZFovUWMVc9DE8JCA+b1XMXwB7KlhJjDRPnyNtHfY=
Received: from DB7PR04MB5098.eurprd04.prod.outlook.com (2603:10a6:10:1c::18)
 by AS8PR04MB8850.eurprd04.prod.outlook.com (2603:10a6:20b:42d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 09:40:43 +0000
Received: from DB7PR04MB5098.eurprd04.prod.outlook.com
 ([fe80::6418:d0b1:6971:5da0]) by DB7PR04MB5098.eurprd04.prod.outlook.com
 ([fe80::6418:d0b1:6971:5da0%5]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 09:40:43 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     Dhruva Gole <d-gole@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] spi: lpspi: disable lpspi module irq in DMA mode
Thread-Topic: [PATCH] spi: lpspi: disable lpspi module irq in DMA mode
Thread-Index: AQHZfxvY0j+jfq9kLEK49Xg9td4Vpa9LZj4AgAADadA=
Date:   Fri, 5 May 2023 09:40:43 +0000
Message-ID: <DB7PR04MB5098E2E44D74474BF98F8620F3729@DB7PR04MB5098.eurprd04.prod.outlook.com>
References: <20230505063557.3962220-1-xiaoning.wang@nxp.com>
 <0608e366-1b0e-d387-569a-9ed123bc4d69@ti.com>
In-Reply-To: <0608e366-1b0e-d387-569a-9ed123bc4d69@ti.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB5098:EE_|AS8PR04MB8850:EE_
x-ms-office365-filtering-correlation-id: acc8cd80-531f-412b-841a-08db4d4ccbcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v3G82Y5cThuClIb1gwRIigOeb7mowdj1WF6Qb3OV0VmC3B8FmwP2MKCIdJ+cT4ZBzrxEJoLfHpqqWx3tNZNQMKqdmcEq8W8z6F6Wdls2hwbQ12uz6CWGxxe8lRNmkkdhCga2bIqanw/w49oIMzn3WKyUS6WTTEq9UiIi5pYMCsJPHe9KTwX+bSJu3uS8PW5GXTIlLM0KLMfRxLQoHb5sIeiFU0n8aEdW6/cU0g0F07BmXlodOGBnnum+2ym4ebp9CjldAjAAnSLlomo2soPj0gqPTkx5ZRHDnYcKAECAg756wj+lh2Xl8NFPi1QgxgQ6iJg7jyzV/aTpyd3+XEDzYNvk1s3Y+JptToWzxdScz8CuXXsAZ+c2dpbMGUAdUdNFIcRWgEsQ8yNAKl5KU7HboCwI0Jdxu2THQisGIa7Bd3R08OQt6OegdmgRtDQl6RghOxYGzcGIY55cADHc3fzT+zSGj5I8l2OVZPYMoc/F2+aqQUHgYcqS2aMzHr7bzsMMUUU6tOPywNUFvHkp9U+4uumb0HEEtlFEutMC1vfFUSu6GbkV4RI4n6sKhFy8jYXvFLYYM9PUxusi4MHBd6azdawxLUC174qm+0JTUIFt8SmeyhMAEZn360k7Q37qpy5O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5098.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199021)(7696005)(4326008)(76116006)(66946007)(66556008)(66446008)(66476007)(64756008)(71200400001)(478600001)(316002)(54906003)(110136005)(33656002)(86362001)(83380400001)(9686003)(53546011)(6506007)(8936002)(5660300002)(52536014)(8676002)(2906002)(41300700001)(55016003)(38100700002)(38070700005)(186003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3NmNlhWUVg3MlJjUnZSQmQ2ajM0VE9TK2lqSDRiR3I0aFN3alMvUnh3Y24w?=
 =?utf-8?B?VDZ6OU42aGk5OXB1Y2VQVGJKaVNuSGFUL202a2dvTnpxR3E4RUVkSnFLUnFq?=
 =?utf-8?B?V1RFUjh6NFRVbnRlZ000bDE4azZPU1pqMGZPWWwzd1F3dUpCREVWVnBURlZG?=
 =?utf-8?B?ejhtV2NJWGxramIvbnFWbjFpZHdZVDhzQXFUZUhwK0NDaVVmc2VNem1BK09h?=
 =?utf-8?B?aDg0L2tXRWZUNEVoSGYwSVl1RVA3SkxFckpEN0dERDE2ejAyYURRWkRlcStp?=
 =?utf-8?B?dTVtbFBEb0ZTSFNwZ04xYlpPTzZQSVJEUFR1aGxTeEoxenpCTFZlVDE0VmRO?=
 =?utf-8?B?dkpKTkU5K1oyTFhzTEVuLzdDUVBMNHdyYU82YzVwYkIvSjBjd2F0VU1yS3hI?=
 =?utf-8?B?aEdReWdvYnNuL2J0V1RBWm9sSVhYczNQSENUbkdBamRNU2dTU3NrbVdDM2ll?=
 =?utf-8?B?aGFsSUtneGNKRDdZMkt6a28wc2pvOEIzaUFaSFZrSWR0VkF4Y241N3VFTW9J?=
 =?utf-8?B?N2VEd1lWT2Z4cXpTMzB6Um9UZzM5UlYvbGkreEoza1lwc2pRNkdkbnJFcm0w?=
 =?utf-8?B?QlBsOFpXeVlIb2lKN1pJZzZ4Ni9jN1hrajAwUm1xOHM4R2REZ3BaWis1cnpC?=
 =?utf-8?B?TVBteVhNU2MyRmFHZEpTUnVab1o3VW1pbkZSVDdPSWJvaUxFbmt1Wm5yakEr?=
 =?utf-8?B?UDdTcTR0a2xrQUNobmVOYjFoUndJWnh5RkFLVTRkaUI1QVFtc3VWQXpCWCt3?=
 =?utf-8?B?QnQ0ZVJTaFhGcUlXMGxpRVkrZTl4eURrYkkwQS9RUkJERVBEeG9NREFEcUFM?=
 =?utf-8?B?a0Z0eXh2TTBDT3BoUzcveUpHbjYwNVRWd244TjJXUU43SHIwU1RQSWQ0SWxt?=
 =?utf-8?B?S2Vrc2hjL3pUb2Z4Q3BwNlgyZzRueHZ4c3k4RXdtYmpwNStKdGJsbXl4dFg2?=
 =?utf-8?B?RGN0TlJSZ3hYZzBKcnpkMytUVEI3UFBRL25QQTZmZFFSSnN6eVZ4UnpCaEc5?=
 =?utf-8?B?MjM2RE9ab0gvRmE0NXhSZ0QxbkkvWkJFR0J3ZjUwYkI3aExjVThYOFRyT2V2?=
 =?utf-8?B?cnNhU1I2Z294eHpQNnpYMHgzVDk4OTBVV0lxYk5ld1JINitnVE12TlFNUGly?=
 =?utf-8?B?Q0RHZVFsRXlsNmhsUWp3R2ZJeEVHM0pVbjcxRWYraWR5MDRYYnJ1TC9oSFVY?=
 =?utf-8?B?SXIzNHdWT3NWc3RNb1hudWt4QWJhMFQ5Z0NpRjhleG03WWtTelVuV1YxRWVr?=
 =?utf-8?B?U0JnKzlTdHlhd1VuYWtKSHRrSys0d1hHUy83UW5kVzNyR1FrMHRLY3pVUVdJ?=
 =?utf-8?B?dzFiWlo5SkRBMXFYaGx2SXNLd0VKckwwUGFjVXpVNXlscS9xUWZETGo0d0Y1?=
 =?utf-8?B?TSt0bkdxNXplbGoxVG8yd0JGRkorMnlIY2hGdW1hRlJaQVF1cyt1QlZ2dEE2?=
 =?utf-8?B?OHBtYmFKSTdmWncxSWVUMkl3NUFkbkh3eDFOa1N0MzZnOGlzMm4wbnEycU9t?=
 =?utf-8?B?L0VIM04xbW5OWGxnSWdGWGEwRFRaSVROMHlLTVNlaU5rcSsyQUVrcUJFUWVD?=
 =?utf-8?B?WmdSbkVPRUZqekFRMlpUN0ZnajgrRnljaCtWMWMrWmdvRG10Z3VTTjh3TS90?=
 =?utf-8?B?TDJKYWJEekhDc1I3NVlVNFFhVHRzV0xQbWlaa0MvZDhEV1kya21kSUYzQkIw?=
 =?utf-8?B?SUR1ZkMvODZXaDc4eEdKYnRCMlhlT0h1RmpzclBUSWczU0R3MjhMU0p1UUJJ?=
 =?utf-8?B?SW0xaVJNU0VZOGhIY2J4SmhYbUk1YVdLalJLTUVvdWR0QlF1QTFjaWVmQktp?=
 =?utf-8?B?YU8xWUlNc0NnYzFQMzFLTTNFQXlMdS9pTDVtenZZazhmSXpKYWxWeU91bTI1?=
 =?utf-8?B?aElQei9oYXp3YmxpalRLczFEZ0N5OTY5OS9tZGxaYWlnZmtSNEZxTWVkOTdW?=
 =?utf-8?B?ZVBlSWNJeUZLZGh6VE9oZExzRHhzYmRiQk9QUXhtSE1VYnNRN2twRngxU1Q0?=
 =?utf-8?B?TGQ4ZnB0NlBsb25iUVlwU0tUZWhodVdWbFNLcU9BSGliRFZsUjB5bmFEM1k4?=
 =?utf-8?B?UnZvS0xmUzByMEYvbjVIdDcvSExlK1daUEJ6dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5098.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc8cd80-531f-412b-841a-08db4d4ccbcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 09:40:43.4799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/sNtLpGNWaJQYjTUjGjnDHdHDYmVZemfXx8oc9QVgXYU0dAZMdwvM6T7103y4HgGnPlmvnXFDFcPzrM7PNtEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8850
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGhydXZhLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERocnV2
YSBHb2xlIDxkLWdvbGVAdGkuY29tPg0KPiBTZW50OiAyMDIz5bm0NeaciDXml6UgMTc6MTYNCj4g
VG86IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT47IGJyb29uaWVAa2VybmVsLm9y
Zw0KPiBDYzogbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBzcGk6IGxwc3BpOiBkaXNhYmxlIGxwc3Bp
IG1vZHVsZSBpcnEgaW4gRE1BIG1vZGUNCj4gDQo+IA0KPiANCj4gT24gMDUvMDUvMjMgMTI6MDUs
IENsYXJrIFdhbmcgd3JvdGU6DQo+ID4gV2hlbiBhbGwgYml0cyBvZiBJRVIgYXJlIHNldCB0byAw
LCB3ZSBzdGlsbCBjYW4gb2JzZXJ2ZSB0aGUgbHBzcGkgaXJxDQo+ID4gZXZlbnRzIHdoZW4gdXNp
bmcgRE1BIG1vZGUgdG8gdHJhbnNmZXIgZGF0YS4NCj4gPg0KPiA+IFNvIGRpc2FibGUgaXJxIHRv
IGF2b2lkIHRoZSB0b28gbXVjaCBpcnEgZXZlbnRzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
Q2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVy
cy9zcGkvc3BpLWZzbC1scHNwaS5jIHwgNyArKysrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zcGkvc3BpLWZzbC1scHNwaS5jIGIvZHJpdmVycy9zcGkvc3BpLWZzbC1scHNwaS5jDQo+
ID4gaW5kZXggZjIzNDFhYjk5NTU2Li40YjcwMDM4Y2ViNmIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9zcGkvc3BpLWZzbC1scHNwaS5jDQo+ID4gKysrIGIvZHJpdmVycy9zcGkvc3BpLWZzbC1s
cHNwaS5jDQo+ID4gQEAgLTkxMCw5ICs5MTAsMTQgQEAgc3RhdGljIGludCBmc2xfbHBzcGlfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gPiAgIAlyZXQgPSBmc2xfbHBz
cGlfZG1hX2luaXQoJnBkZXYtPmRldiwgZnNsX2xwc3BpLCBjb250cm9sbGVyKTsNCj4gPiAgIAlp
ZiAocmV0ID09IC1FUFJPQkVfREVGRVIpDQo+ID4gICAJCWdvdG8gb3V0X3BtX2dldDsNCj4gPiAt
DQo+IA0KPiBBbnkgcmVhc29uIHRvIGRlbGV0ZSB0aGlzIGxpbmU/DQoNCkJvdGggb2YgdGhlIGlm
IHN0YXRlbWVudHMgYXJlIHVzZWQgdG8gZGV0ZXJtaW5lIHRoZSByZXR1cm4gdmFsdWUgb2YgZnNs
X2xwc3BpX2RtYV9pbml0KCksIHNvIEkgcmVtb3ZlIHRoaXMgbGluZS4NCg0KPiANCj4gPiAgIAlp
ZiAocmV0IDwgMCkNCj4gPiAgIAkJZGV2X2VycigmcGRldi0+ZGV2LCAiZG1hIHNldHVwIGVycm9y
ICVkLCB1c2UgcGlvXG4iLCByZXQpOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCS8qDQo+ID4gKwkJICog
ZGlzYWJsZSBMUFNQSSBtb2R1bGUgSVJRIHdoZW4gZW5hYmxlIERNQSBtb2RlIHN1Y2Nlc3NmdWxs
eSwNCj4gPiArCQkgKiB0byBwcmV2ZW50IHRoZSB1bmV4cGVjdGVkIExQU1BJIG1vZHVsZSBJUlEg
ZXZlbnRzLg0KPiA+ICsJCSAqLw0KPiA+ICsJCWRpc2FibGVfaXJxKGlycSk7DQo+IA0KPiBKdXN0
IHdvbmRlcmluZywgaGF2ZSB5b3UgYWN0dWFsbHkgc2VlbiBhbnkgdW5leHBlY3RlZCBMUFNQSSBt
b2R1bGUgSVJRDQo+IGV2ZW50cz8gSWYgdGhpcyB3YXMgY2F1c2luZyBpc3N1ZXMgZWFybGllciB0
aGVuIG1heWJlIGFkZCBhIGZpeGVzIHRhZz8NCg0KWWVzLCBJIGhhdmUgb2JzZXJ2ZWQgdGhpcyBp
c3N1ZS4gDQpUaGUgcmVhc29uIGZvciB0aGlzIHByb2JsZW0gaXMgdGhhdCBzb21lIG9sZGVyIHBs
YXRmb3JtcyBhcmUgZGVzaWduZWQgdG8gY29tYmluZSBMUFNQSSBpbnRlcnJ1cHQgYW5kIExQU1BJ
IERNQSBjaGFubmVsIGludGVycnVwdCBpbnRvIG9uZSBzaGFyZWQgaW50ZXJydXB0IG51bWJlciBi
ZWNhdXNlIHRoZSBJUlEgaW50ZXJydXB0IG51bWJlciBpcyBub3QgZW5vdWdoLg0KV2hlbiB0aGUg
cHJvYmxlbSBvY2N1cnMsIHdlIGNhbiBvYnNlcnZlIHRoYXQgaWYgdGhlIGludGVycnVwdCBjb21l
cyB0b28gbWFueSB0aW1lcyBhbmQgdG9vIHF1aWNrbHksIGl0IHdpbGwgdHJpZ2dlciB0aGUgSVJR
IGluIHRoZSBMUFNQSSBkcml2ZXIgd2hpbGUgRE1BIGlzIHN0aWxsIHByb2Nlc3NpbmcgdGhlIHBy
ZXZpb3VzIERNQSByZXF1ZXN0KHRocm91Z2ggdGhlIHNoYXJlZCBkbWEgY2hhbm5lbCBpbnRlcnJ1
cHQpLCByZXN1bHRpbmcgaW4gZGF0YSBtZXNzaW5nLg0KDQpCZXN0IFJlZ2FyZHMsDQpDbGFyayBX
YW5nDQo+IA0KPiA+DQo+ID4gICAJcmV0ID0gZGV2bV9zcGlfcmVnaXN0ZXJfY29udHJvbGxlcigm
cGRldi0+ZGV2LCBjb250cm9sbGVyKTsNCj4gPiAgIAlpZiAocmV0IDwgMCkgew0KPiANCj4gLS0N
Cj4gVGhhbmtzIGFuZCBSZWdhcmRzLA0KPiBEaHJ1dmEgR29sZQ0K
