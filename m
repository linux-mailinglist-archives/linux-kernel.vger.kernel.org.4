Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C70F61EF38
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiKGJjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiKGJiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:38:55 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2128.outbound.protection.outlook.com [40.107.113.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8652217077;
        Mon,  7 Nov 2022 01:38:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiC4bNQ1nf5kFa2hk5GiESP5XaqoRqN1yfWP1J199uUHQpRblZKfSTYCJ+ICXHpPivjLjc/fJlhf635pUtD0WfCE6X69Ih04OMFw84rk9LQpEQP9+80Zb5lCjrCaEiuX9PEEMiY/VNB8qCQw3sR5XfnlkgtRsHPn1OJYFbp8dY2viJ3/kNRFxNJNYfrWfT0w/q4xvRZ4F0t72eM8HTb5l00KwffLMCiblgtiQcDWfuE8K9HmlAtM9TDrcinwF3CCxEgxqQaitS1oCAueRKZM0HkNzvcrUTDz5MgOjjA8LMYVMwjcV59CX648zPXn7wXqSoLF2Xk6+b4MSdjuQNK4UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJNhhxw06O9jXD2nWuiAYyyR1VKSWFLbf9+GxRg+K5s=;
 b=Nm5JL7PgyOw+B/cmrjzOkq3nlTRjY+92sRI8ItWz/9nZRbKQrZKMNlgTxIoeSJCcSwxImAMzyLdGqQnZEwwX9zJ7S5rhvcW93l5BsGkFtkZ9iM2OYmOVf8bo+oRCGjF8yPbXHKuam7CaFymQi0KsTITkDr+sK72BTWy3NspHBbD0RAMgF+7KfuWEvbNahrTXmXcG+1i0ZwZX48IAtYs/EVHpSVeuUaxAvTimvwIOBOfZTIWbxOVaCbo1HHmFJNYyMUhue4UH2P8pwOeqbR7jrdo6APTvlgPtFkDUhKm2acPd1xFFHWx7tx6p3O5kLxkBxg4gM/shM2Dw+esYZt1CfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJNhhxw06O9jXD2nWuiAYyyR1VKSWFLbf9+GxRg+K5s=;
 b=nW5Qo3wivmqI65pT+EcwLJ0BEYVUgWuWkaUdSxVT+1lJawN8caCKrLchzpj6T0ERWi1QePn0FLlFTHCfcrLQLwxfCxx2H8Lj/VSu6eyTjbIrN95YbmuFQGJlpaeuj6ZIlpH0sjBNtkY1m3oOEBngphnDgEO1IWv0uBYxfx3pZLQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB9289.jpnprd01.prod.outlook.com (2603:1096:400:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 09:38:45 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 09:38:45 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Billy Tsai <billy_tsai@aspeedtech.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "garnermic@meta.com" <garnermic@meta.com>
CC:     kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: RE: [v3 2/3] pwm: Add Aspeed ast2600 PWM support
Thread-Topic: [v3 2/3] pwm: Add Aspeed ast2600 PWM support
Thread-Index: AQHY7p7kl1T9YGA12UCEvmgRzmEVOa4ryCswgAdlwYCAAAAiYIAACn6AgAAAV3CAAAJ98A==
Date:   Mon, 7 Nov 2022 09:38:44 +0000
Message-ID: <OS0PR01MB592234A33E67C1318F58135A863C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221102083601.10456-1-billy_tsai@aspeedtech.com>
 <20221102083601.10456-3-billy_tsai@aspeedtech.com>
 <OS0PR01MB5922014A7D74A884D2E7BDC286399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <C7224BE1-D81E-4FE0-8B7C-5A3CA69898D2@aspeedtech.com>
 <OS0PR01MB5922EC7AB73207DF30F42A0A863C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <E3A2DC80-3D8D-451F-9EA1-A3262F4A3C43@aspeedtech.com>
 <OS0PR01MB59228483527685F943A3F5D4863C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59228483527685F943A3F5D4863C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB9289:EE_
x-ms-office365-filtering-correlation-id: 00bfea41-40e3-4826-647d-08dac0a3dd39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M2GWcQt8COeaNjCPp7B1L2d4kNMYTK91R7EbILrcS1UYF6TrqVwHAP8REi2f4gn5QOkWhcPHZYniJSDMCyLnucEJJHRcnFr6khxEI0Q0zQrScOzOPFuzB3vutxnhuqQevxio1oM+xHVHdMgaYGeD2YP11IDbCLwjW6V+MYbJyE45x2Y1o/j3w2/m+TX2Xg1u0arUTf8KG38NbRbQlhWnlzkZWZMF0pz3afGrrhUz0g0aNiokkZb36z/Ox4u+d8bYlYgOaPV4nEJI8Dxa+yVzA5po5ugfYkyvcN2eTQ+MVOf3uvQTedrp6/VI1CB7QB0i7yrw5GYjMIF8/BiRz8boRYURSdKLuvR52AL9aZNTudyaPryznUhmwZyaXqNE7LLJGTU0JjjnWtt3WUfBuMtzWx4l+YV/XLHKLRqeUlYBitmxGe+ASuqaxldO3Pl8px8i6knlPjAWRCOdNIVLhzbq6s2hL6h8gW0e8hvxT5BtWq0FazUpSFeJ+LiWGqAFRvl7bC0rtUbaK3WyOfvobnE1x3pWxRY+hLtfYhH2BrxHYxB2p8U5Ukt8iCpbqHKqiFee5i4OUPk1v68aL25rReGcBBBv+j4HrTyK9csGDemt0CQ1SYmOn4snAiLglQbejPagn9Ddu82GMKv+V3tZfu0hDgSs1GaEwtbg+ab1i2zpaxiUUX9IyKWcO4x9F6OIxfIQDs4rxj5b7aTold4GDFjfgoqegzMwALNY0Qav3QsUoxaFI12Bkm4z4WiDqFX5WoxDzMBJBTIsM3i6FQxsRygRgVO1/9gfGA78dAkyAMAkc2s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(53546011)(9686003)(26005)(2940100002)(186003)(7696005)(6506007)(122000001)(83380400001)(2906002)(55016003)(8676002)(110136005)(7416002)(316002)(54906003)(478600001)(71200400001)(38100700002)(5660300002)(41300700001)(52536014)(8936002)(4326008)(76116006)(64756008)(66476007)(66946007)(66556008)(66446008)(33656002)(921005)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3d2YXdaMldmZlo0c1JUZEFoeVVwVDl6Rm1WZDNERkp6eVdrV2xHRnV5bTFE?=
 =?utf-8?B?bUx2VTlOWVJXRGhBdGJKckZYcWlreUJCOUcwZVBRV2M2Tmk3MHpYM04xWlpX?=
 =?utf-8?B?QmNvU1YzZ3B6R3lJak5HSml2L3A4ayt3OHBhczVWNUJGK2R5SUg5aWw5SDZD?=
 =?utf-8?B?VE9IanhvZ1lHQ1l0aWdlTEo5aDh6ZmJseTJwN1FXOE9zamJoSkRYM2RtQmJK?=
 =?utf-8?B?SlZ3cE1Caml5Y1dLNFdzclJMNGlSNm55QncvVUp1ZnNCSG1FaXFQWVk4OVh2?=
 =?utf-8?B?Wm9TM1VhR0NqQ0F3d0JUbnNEWDNkU2paeThlUmZBcWVQWXNheEhxWmxIZUJj?=
 =?utf-8?B?TkF4ZGp4RERWbzZ4VXUxZDFYVU5hRWMvMmZrWC85TjVWUXRTZzlQbGRpS05k?=
 =?utf-8?B?Uk9JSk94b3lBSzZVRHFJd1FaN1JIa2kxL3BvcHdLcUNQRHRvcTArZXRNTDdB?=
 =?utf-8?B?QXhYRk5NeUIyd0w5V0k4QW5Gd0ZSaGJaOEpub3hpN01BTDVuK1EwV0ZkcVU4?=
 =?utf-8?B?a01IU210TkdlaWZha1V3WVFRUkNIUlR1elF0d1ZZbEFHc2dPdm4wbk1yaUxN?=
 =?utf-8?B?VDZIK2ZDdGN1NVRpd2IzV3cxSVdtNlRxS3BnTERxMGpXSHB5YW1UdzVZZmxu?=
 =?utf-8?B?OERVOC9OampuT1BDS00wc25EWEFBL2ttREVHZ3RnTmxiT1pzcXhYYzh1Ynls?=
 =?utf-8?B?VE1wb1hUaGFZcnE5NmhmS2graWxDb3Vxb2M4Mi8rc1pGVTE0YTZMWWNpN2hl?=
 =?utf-8?B?NW9LVGFDcmdJemdYWUFmRDdwbmJEa2ZRRFBFR1BlZ1Q5ZEpmTnFtRktyaEZG?=
 =?utf-8?B?WldqZHhMSXQ3WVZ3S0h4bWNlRDhNOThTcU5BZFhJcTkycVUxVjBlTHBTZFB4?=
 =?utf-8?B?dFY3dXZnZ1FzcWZIbTZndG1sY1hiRCszbDhVT3pTQ3M4Y1Z6V3NhcERMd3FP?=
 =?utf-8?B?U2grUkJBTDFaSkt2L1hwRGZqRmJkOXVtRGxDZ1hqRXBuRE5pZmZmMHpkMlBq?=
 =?utf-8?B?OFdqZUJEeDBBRmp3akJIY1VuVmxDMW5JZUx0S21nZHpFbFFjUWpYNGF4ci9n?=
 =?utf-8?B?SjZVeWxvQThyK1VEVk9YYk56ck1mZmhnQ0JmR2Z6UGhFdnJHYnBraHljVzR6?=
 =?utf-8?B?ZlpLbjdGYUFsSFhxRVhPNk8zcFpWNENxS3hFLzFRZGVWSVhSZTducHhUTW5w?=
 =?utf-8?B?OEZRbURsVVI5dWpCQTBnVnlCTWxDQUF2MkcreWUyalFsbXNqcERLcWx3STYz?=
 =?utf-8?B?Z0pYZzFqSGsyWE1yRCtXNE5kbERSTW5wemdIQTNOUHY5M3hXZmwycmJmMWxh?=
 =?utf-8?B?RlVnb0UvYmFQME8vWG8rQUhhdXgvc1dQQW5MVmRkcWx6aE9hMzFnVHlEQU1x?=
 =?utf-8?B?NlFlR2doaHZhZUYvZVE2SXcyUzV0Wkl1Um5pUnhhY0NWS3IxOFlwei82bVB2?=
 =?utf-8?B?Vm82UHFZSUtHelE5RWRLOC9OZDVJeG4wSzZySVpuSVo0bXpWUjVjbktvNVlt?=
 =?utf-8?B?Uk1TQU5RcVRGaTQ2bkkyZzhiekVGS3JabkJhajlXdTFOY1V6dmQzWm5TcTBT?=
 =?utf-8?B?VW5FTXV5bGVwR3M1eHhkOTZCaDcyRUIwZEZRZXZrSzJZTkhJbGJONUV0a01r?=
 =?utf-8?B?V0JRNlE5WWo0VkEvSzVqWm02SU10OTArNzVsbGVjYzdleHQxL1RwWExpRElx?=
 =?utf-8?B?TmhtU2lNWWlvRWR1d0NWV0NDays3a3pOVFFIM0VlQnMxSS82WjZ0SC84Wm96?=
 =?utf-8?B?N0ZyczlGYVR2SHpkcWZ2NFlyejFVcXAxWEgyVldWWEZjRUdVSGpBL1hUdTRq?=
 =?utf-8?B?OTlYTkEyQXZxcFR1RTJZcFpLYXVobDkzVFdQRGpYVXVFWm5VOXBnb0RtZnhJ?=
 =?utf-8?B?a0VadVMyMndXK0tUSEFJdUU4U0VJeTVkZ1F4ckhNTFhsZ2gvTHh5bjJBNmh1?=
 =?utf-8?B?U1ZxdnExNmx2eXFFa25YYW93TlhLM2hQQkNhM3RYZUxYd2x5ZGJ1dFNTRXJp?=
 =?utf-8?B?MFRNaEp1cGFVandUS0hHb2w4TnNLZnd5V01HWGNuSjhQMXRGM3hJWWFqV2Zr?=
 =?utf-8?B?YzlleE9PWFBtd2hZTGxKTm9WdVA4MXhLSXozMnNHZkJ1UE82MS9IRUhKSVRU?=
 =?utf-8?B?aHZITVVqWWxCeGhiMndqRTJEcnlpSzkzaVUwMnBJbVo5S1RGU1JvNG9vdmZK?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00bfea41-40e3-4826-647d-08dac0a3dd39
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 09:38:44.9762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hfOVX/DI4HT93qdl3tzqkyRUKL9b6j3IEKTEp3ZJE0BGK5aUsgKqE61F8j/W+CSMSK8gaQjY1Px5uPXJbiToFEJeyRhVuSEjfzDG+HX1R3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9289
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSRTogW3YzIDIvM10gcHdtOiBBZGQgQXNwZWVkIGFzdDI2MDAgUFdNIHN1cHBv
cnQNCj4gDQo+IEhpIEJpbGx5IFRzYWksDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4gRnJvbTogQmlsbHkgVHNhaSA8YmlsbHlfdHNhaUBhc3BlZWR0ZWNoLmNvbT4NCj4g
PiBTZW50OiAwNyBOb3ZlbWJlciAyMDIyIDA5OjI2DQo+ID4gVG86IEJpanUgRGFzIDxiaWp1LmRh
cy5qekBicC5yZW5lc2FzLmNvbT47IGpkZWx2YXJlQHN1c2UuY29tOw0KPiA+IGxpbnV4QHJvZWNr
LSB1cy5uZXQ7IHJvYmgrZHRAa2VybmVsLm9yZzsgam9lbEBqbXMuaWQuYXU7DQo+ID4gYW5kcmV3
QGFqLmlkLmF1OyBsZWUuam9uZXNAbGluYXJvLm9yZzsgdGhpZXJyeS5yZWRpbmdAZ21haWwuY29t
Ow0KPiA+IHUua2xlaW5lLSBrb2VuaWdAcGVuZ3V0cm9uaXguZGU7IHAuemFiZWxAcGVuZ3V0cm9u
aXguZGU7DQo+ID4gbGludXgtaHdtb25Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsNCj4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxp
bnV4LSBhc3BlZWRAbGlzdHMub3psYWJzLm9yZzsNCj4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC0gcHdtQHZnZXIua2VybmVsLm9yZzsgQk1DLVNXDQo+ID4gPEJNQy1TV0Bh
c3BlZWR0ZWNoLmNvbT47IGdhcm5lcm1pY0BtZXRhLmNvbQ0KPiA+IENjOiBrZXJuZWwgdGVzdCBy
b2JvdCA8bGtwQGludGVsLmNvbT47IEdlZXJ0IFV5dHRlcmhvZXZlbg0KPiA+IDxnZWVydCtyZW5l
c2FzQGdsaWRlci5iZT4NCj4gPiBTdWJqZWN0OiBSZTogW3YzIDIvM10gcHdtOiBBZGQgQXNwZWVk
IGFzdDI2MDAgUFdNIHN1cHBvcnQNCj4gPg0KPiA+IE9uIDIwMjIvMTEvNywgNDo1NSBQTSwgIkJp
anUgRGFzIiA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gICAg
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ICAgICA+ID4gRnJvbTogQmlsbHkg
VHNhaSA8YmlsbHlfdHNhaUBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAgICAgPiA+IFNlbnQ6IDA3IE5v
dmVtYmVyIDIwMjIgMDg6NDgNCj4gPiAgICAgPiA+IFRvOiBCaWp1IERhcyA8YmlqdS5kYXMuanpA
YnAucmVuZXNhcy5jb20+OyBqZGVsdmFyZUBzdXNlLmNvbTsNCj4gPiBsaW51eEByb2Vjay0NCj4g
PiAgICAgPiA+IHVzLm5ldDsgcm9iaCtkdEBrZXJuZWwub3JnOyBqb2VsQGptcy5pZC5hdTsgYW5k
cmV3QGFqLmlkLmF1Ow0KPiA+ICAgICA+ID4gbGVlLmpvbmVzQGxpbmFyby5vcmc7IHRoaWVycnku
cmVkaW5nQGdtYWlsLmNvbTsgdS5rbGVpbmUtDQo+ID4gICAgID4gPiBrb2VuaWdAcGVuZ3V0cm9u
aXguZGU7IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LQ0KPiA+IGh3bW9uQHZnZXIua2Vy
bmVsLm9yZzsNCj4gPiAgICAgPiA+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPiBsaW51eC0NCj4gPiAgICAg
PiA+IGFzcGVlZEBsaXN0cy5vemxhYnMub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC0NCj4gPiAgICAgPiA+IHB3bUB2Z2VyLmtlcm5lbC5vcmc7IEJNQy1TVyA8Qk1DLVNX
QGFzcGVlZHRlY2guY29tPjsNCj4gPiBnYXJuZXJtaWNAbWV0YS5jb20NCj4gPiAgICAgPiA+IENj
OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gPiAgICAgPiA+IFN1YmplY3Q6
IFJlOiBbdjMgMi8zXSBwd206IEFkZCBBc3BlZWQgYXN0MjYwMCBQV00gc3VwcG9ydA0KPiA+ICAg
ICA+ID4NCj4gPiAgICAgPiA+IE9uIDIwMjIvMTEvMiwgMTE6NTYgUE0sICJCaWp1IERhcyINCj4g
PiA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gd3JvdGU6DQo+ID4gICAgID4gPg0K
PiA+ICAgICA+ID4gICAgID4gPiArCXBhcmVudF9kZXYgPSBvZl9maW5kX2RldmljZV9ieV9ub2Rl
KG5wKTsNCj4gPiAgICAgPiA+ICAgICA+ID4gKwlwcml2LT5jbGsgPSBkZXZtX2Nsa19nZXRfZW5h
YmxlZCgmcGFyZW50X2Rldi0+ZGV2LA0KPiBOVUxMKTsNCj4gPiAgICAgPiA+ICAgICA+ID4gKwlp
ZiAoSVNfRVJSKHByaXYtPmNsaykpDQo+ID4gICAgID4gPiAgICAgPiA+ICsJCXJldHVybiBkZXZf
ZXJyX3Byb2JlKGRldiwgUFRSX0VSUihwcml2LT5jbGspLA0KPiA+ICAgICA+ID4gICAgID4gPiAr
CQkJCSAgICAgIkNvdWxkbid0IGdldCBjbG9ja1xuIik7DQo+ID4gICAgID4gPg0KPiA+ICAgICA+
ID4gICAgID4gV2hhdCBpcyB0aGUgdXNlIGNhc2U/DQo+ID4gICAgID4gPg0KPiA+ICAgICA+ID4g
ICAgID4gSXMgcHdtIGNvbmZpZ3VyZWQgYnkgYm9vdCBsb2FkZXIgaW5pdGlhbGx5ID8NCj4gPiAg
ICAgPiA+DQo+ID4gICAgID4gPiAgICAgPiBPcg0KPiA+ICAgICA+ID4NCj4gPiAgICAgPiA+ICAg
ICA+IHB3bSBjb25maWd1cmVkIGJ5IExpbnV4LCBub3QgYnkgdGhlIGJvb3Rsb2FkZXIgaW5pdGlh
bGx5Pw0KPiA+ICAgICA+ID4NCj4gPiAgICAgPiA+ICAgICA+IE9yDQo+ID4gICAgID4gPg0KPiA+
ICAgICA+ID4gICAgID4gRHJpdmVyIG5lZWRzIHRvIGhhbmRsZSBib3RoIGNhc2VzPw0KPiA+ICAg
ICA+ID4NCj4gPiAgICAgPiA+ICAgICA+IEp1c3QgYXNraW5nLCBiZWNhdXNlIHlvdSBhcmUgdHVy
bmluZyBvbiB0aGUgY2xvY2sNCj4gdW5uZWNlc3NhcmlseQ0KPiA+IGhlcmUsDQo+ID4gICAgID4g
PiAgICAgPiBJZiB5b3UgbmVlZCB0byBhZGRyZXNzIGFsbCB0aGUgdXNlIGNhc2VzLiBJZiBpdCBp
cyBqdXN0IGZpcnN0DQo+ID4gb25lLCB0aGVuDQo+ID4gICAgID4gPiAgICAgPiBJdCBpcyBvay4N
Cj4gPiAgICAgPiA+DQo+ID4gICAgID4gPiBIaSBCaWp1LA0KPiA+ICAgICA+ID4NCj4gPiAgICAg
PiA+IFRoZSBkcml2ZXIgd2FudCB0byBoYW5kbGUgYWxsIG9mIHRoZSB1c2UgY2FzZXMuIENhbiB5
b3UgdGVsbA0KPiA+IG1lIHdoeSB0dXJuaW5nDQo+ID4gICAgID4gPiBvbiB0aGUgY2xvY2sgaXMg
dW5uZWNlc3NhcmlseSBoZXJlPw0KPiA+DQo+ID4gICAgID4gRm9yIHRoZSB1c2UgY2FzZSwgInB3
bSBjb25maWd1cmVkIGJ5IExpbnV4LCBub3QgYnkgdGhlDQo+ID4gYm9vdGxvYWRlciBpbml0aWFs
bHkiLA0KPiA+DQo+ID4gICAgID4gWW91IGFyZSB1bm5lY2Vzc2FyaWx5IHR1cm5pbmcgb24gdGhl
IGNsb2Nrcy4gWW91IGNvdWxkDQo+ID4NCj4gPiAgICAgPiBlbmFibGUgaXQgZHVyaW5nIHB3bV9l
bmFibGUNCj4gPiAgICAgPiBhbmQgZGlzYWJsZSBpdCBkdXJpbmcgcHdtX2Rpc2FibGUuDQo+ID4N
Cj4gPiAgICAgPiBGb3IgY29uZmlndXJpbmcgcmVnaXN0ZXJzLCB3aGlsZSBwd20gaXMgaW4gZGlz
YWJsZSBzdGF0ZSwNCj4gPiAgICAgPiB5b3UgY291bGQganVzdCB0dXJuIG9uIHRoZSBjbG9jayBh
bmQgZG8gdGhlIHJlZ2lzdGVyDQo+ID4gY29uZmlndXJhdGlvbnMgYW5kIHR1cm4gaXQgb2ZmLg0K
PiA+DQo+ID4gICAgID4gQnkgdGhpcyB3YXkgeW91IGFyZSBzYXZpbmcgcG93ZXIuDQo+ID4NCj4g
PiBIaSBCaWp1LA0KPiA+DQo+ID4gVGhpcyBjbG9jayBpcyB0aGUgc291cmNlIGNsb2NrIGZvciB0
aGUgcHdtIGNvbnRyb2xsZXIgKGluY2x1ZGUgdGhlDQo+ID4gYWNjZXNzaW5nIGZvciB0aGUgcmVn
aXN0ZXIpLg0KPiANCj4gT0ssIEJ1dCB0aGUgZHJpdmVyIGhhcyBvbmx5IG9uZSBjbG9jayAocHJp
di0+Y2xrID0NCj4gZGV2bV9jbGtfZ2V0X2VuYWJsZWQoJnBhcmVudF9kZXYtPmRldiwgTlVMTCkp
Lg0KPiBZb3UgYXJlIGFsd2F5cyB0dXJuaW5nIGl0IG9uIGR1cmluZyBwcm9iZS4NCg0KWW91ciBz
eXN0ZW0gbmVlZHMgdGhpcyBjbG9jayBhbHdheXMgb24sIHRoZW4gaXQgaXMgT0suDQoNCkNoZWVy
cywNCkJpanUNCg0KDQo=
