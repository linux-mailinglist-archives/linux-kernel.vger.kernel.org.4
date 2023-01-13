Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1C5668A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 04:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjAMDa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 22:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjAMDaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 22:30:25 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB48E022;
        Thu, 12 Jan 2023 19:30:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vl51qxA0/UJPIiYY7I0/7aaOipyydRnVkJPIXKYHUBe6dCW4YxLYEaTEoifF6yOZyHUBNFrImROEI+g7NEjuFx7uI6YNBPrhUk86mJPYSHMCqB4mDML14A4MeMhfvDl34zyYtQB/uKx4vMkeZjQ7RzL10DiestuKAZQgck9ecH1/rjkM3Tr0tq0RLKi3vtMo+foJwnnX0VEc1rhoMQf78Fd4xLYXwOlS/6L+iLCcHifFJ0oD2U1mfIPtwGMKUXofMebr3JRQEFpssGaT2hUqg5OkPanDEEaUz1y4WtVtVnmUsdcN58iBLChTyKETU4gjX3v+eGqSyizLNGp/Ra3fzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezEPbetx4jmbS8Xn2lpQ7dsuIc8mgG3jAFzE+/zZFNM=;
 b=Ki49ZjdndDXdVBPHzsdTOQQCcPkgXeEXlbV6KEhiKvveTfVpF638/5873u3pLdZhC5bjJzFMeMt7Ej3jM1OlkYDNex8XSgT22nPJj2iOecALqqbb17UGu+E6b9ecicESEjSQUQDxMnbrtMxBGxyqfG1zNfmV7+KxDdM/jG6rn3RBPBrBbuNnIK1gVkYo1DTpWEDdHPRwkpZMJ7cAQpq5xFCcsj+M0Cv9ZaogrBP6vwx4vtaYVGIeVRLbm5LxMKCd+DdEUM9+1WUS8IPIWej9Fk0TkOjs+yv7VQN+OkslgGnJzevOklaFhEZPXerGvkMY+wqj4V2MHfYQYX3mCuToZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezEPbetx4jmbS8Xn2lpQ7dsuIc8mgG3jAFzE+/zZFNM=;
 b=b5/cCXJzL7dHlTEDnWYMXgrw0vjVwe7mwheJZ4tNDkRnYWp3JI5vtbFqa1FK46Y+zPxZbljwHQCSaH7RBe/8YA+KMbqABDECAx3jAiy1vg7tl59N2TMC1YzYsfmW2TALtElHKuTG/uCjwV88p3Bosy5+psqGn5xM1zVX/gVZJvg=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AS8PR04MB8117.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 03:30:21 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.6002.012; Fri, 13 Jan 2023
 03:30:21 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
CC:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: NXP imx6ull nonalignment buffer question
Thread-Topic: NXP imx6ull nonalignment buffer question
Thread-Index: AQHZJCqfilmTz1JUB0Cl7AgFtNcXnq6btY6w
Date:   Fri, 13 Jan 2023 03:30:21 +0000
Message-ID: <DB7PR04MB4010D6ABA0D10AB826F468CC90C29@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <CAOf5uwns3YZMY5xhM+o0rNvtTqEDwCbua5HuSy-LBwgZq_eWYg@mail.gmail.com>
In-Reply-To: <CAOf5uwns3YZMY5xhM+o0rNvtTqEDwCbua5HuSy-LBwgZq_eWYg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|AS8PR04MB8117:EE_
x-ms-office365-filtering-correlation-id: c16e2146-04e1-4ff4-1c0e-08daf5168004
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IIFpkAssN+vEuyWry1gUpHL/Qqm8DbZ5oorg8Zgd3tPekANqtRrtp6NO0oFYuMmflVYmoFxccEbDqdn6CUEKON6V2YO00vprcOquUtTa4/18TGbAxT197gw9AKE8SKo7PuJlrnQn+KQysiS2TH39bAmh+G2DIgH9U7OTvv3sODRxCOm8uKzWc0NjTBkGQtUv0p80/ndfn+uzqcj4qOGLWhv3zUUvMNdZOtsjSyjrvq4F7o9GsCx7KptTnDzLzIc3IfuGHal49Um7itxVoqGQCCVk4Rr7EIG6yrbdzP7xD2de8yrlbFcI3mYEiQVyc39kOrP0ymcuvCfRaPZdyDWZUqWtBvEj6/FsSWVBjJCEDJnqOcLs+53e+SAsAU+DaIVVluH4AMIAC6lKnEU8xAJCHXmKayMxP72+h2gjgpQxw64CEqKuUmS3wjz2HYW2HIUHtMewT6k25pany42D2DhpvKmvaC/nzLV3+2wtM3gbNK2gB6UJYEiiEUJQ0PmH7liY3MHkoGXBLZ+EGxpbM4XVY5mRBuphYet8lwropmGH/KUr0Hw8gR3qF/ydoSovl02KGeUKoj+2d2BE+c4qvGWdTxkDot5fF974p3up9m8fQBRjcgHgpGh39X0zlE5ApmpY5amn70aFdFRF4087B8uFzEvdZAhPh/Yv7konQ8fjufhjqX7n0raB1m3XyMD4OHu9WVHAOa41NXama8lZr4QuQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199015)(52536014)(5660300002)(8936002)(54906003)(41300700001)(316002)(76116006)(66946007)(2906002)(66556008)(110136005)(4326008)(8676002)(64756008)(66476007)(66446008)(71200400001)(7696005)(478600001)(122000001)(38100700002)(186003)(26005)(9686003)(53546011)(6506007)(33656002)(55016003)(38070700005)(86362001)(83380400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVp5RlZMYW05emNsQWMveHBlWEtQOXBUREYyaDVJenplbTB4M0F6M3pRZlpZ?=
 =?utf-8?B?aXRkaEZuNWR5bitIcjlvdG8vMWZWR0NuUE00VTBkSkxrMTFCLzRBK2RjK0RT?=
 =?utf-8?B?ejhLTFpRWFdWVUJ0TEUvWEM2anpTNElYdzlqT0dQdjAvdFVTc0FUN1FaSTlC?=
 =?utf-8?B?UGo0Z01GbllxR0JqeWFWeWQ5Ym91YW0xMDNCVzVjY0FqMVE0aGEwS2FFOWEz?=
 =?utf-8?B?NVpvcW9rZytRN1BqTCtIYXk0NmFGZ2xwNGFzTVBCWlBIQ3lTS1MxRzdXVnE5?=
 =?utf-8?B?SVRxVzI1V0xBYTQ0YkREUXh6aUw0UW5qZ0h4dWkyMk5UaUtLam14c0R1UkFR?=
 =?utf-8?B?WlBhS2k1UDZHN21VYU56S0xNQS8yZk5DS1ErUDBWTjNFTjZnT2h5YmhnNDZo?=
 =?utf-8?B?cE9nQUR4ZEl1c21sbGFWRTNTYVlJTzlRZDYxVks5QlYyWkhvd0ZkSUZHMDJp?=
 =?utf-8?B?RUdkVzEzVDhXY2NIQ01KTmZTU1A4TDEzQkJDVGhCVFArZHhHN1BmU0ZMQUMz?=
 =?utf-8?B?b1VGcWc1dFovcjRkL3NiSjRKYlJvRUoydVBCbkNNWTJZQlZsQTlDczJjMENZ?=
 =?utf-8?B?dDVKRlZ6eTl4N0hZV1JVSjVWVUlaR2c2UEJrU3d4MlNYWllTQW1Fd2UwRmhF?=
 =?utf-8?B?d3NmYnRtSWxBYWR4V3EyZDBOTWVSSmtSa0x2WExBa2lTOTNDZ2ovZHkwekJ6?=
 =?utf-8?B?eFJTT2IxS2svTkNNYkhRdkRGN0cydVdGMG1xUjlxZmZBdkc4VXM0Wng1ODk4?=
 =?utf-8?B?TFJTL09Ea0VvelRvUFY1bUZ3RmgvZWllRU5WQWpFTFczNURjcS9BblNNcVVV?=
 =?utf-8?B?cCtrMk05VnY3Sko4MHdsRXR1eTVIQnhSZmI4Zy9kUkJKNWRuQ05XYzZ3aXB2?=
 =?utf-8?B?L2RkWkQ3VmxETEdWVXlmQ0RCNUw1ck02eW1EdXlqcXBRU1Vsd3J1VUEzb05y?=
 =?utf-8?B?OEtUcEE5aVo0Yi9ELzFoK1phSjUyVEg4WFcxbDE2V1ZkMXRkUG5iV05ZRnJR?=
 =?utf-8?B?WGtuVnk3WjZYWWdkd21QWW5YOVA4bktHMmdzd1VZZkJtR0d5ZGlua25Mc05l?=
 =?utf-8?B?bGJkdFkySFdoaEwwcUJKQThxYUtqNk5vd1ZidjR5eVdLUGFXTjQxNnRaVWZK?=
 =?utf-8?B?VmloY09CZG5tVlF3d0puOFhYZWt3aUhnU0piL1NtNm9yTEZzT3dwbnNOSmZX?=
 =?utf-8?B?SlYvSXVYRmMwalJ1Z0s5SGUvNnI0R3Y1NmN4dnQ4S2pxQjhsaEI2cmVNSDJS?=
 =?utf-8?B?VDRuVW1Wc2VRdm1BZjBlZlBvK041QUs2cFNwclVkZ2NsNnlYYVVlc09va2FP?=
 =?utf-8?B?TktPemVQQW1Yb01vSGJkWjd1WTlxcjdXUldIL2IvMUMwT0NhT0wzc3ZWd2hC?=
 =?utf-8?B?dXZYOHJHRkhuZFIrdFA0cUVKa09adHFXaHhqZm1IQXE2cGowT2N1UDNJOHFH?=
 =?utf-8?B?QktZeVNvRG9lRWhpVk0vSUFETXEwaWgyYnp1WmtoNWpmMXdHUk03SUZhK21p?=
 =?utf-8?B?YkVoSFRxSnRsZy9lR1VvRS9iRmgyWlFHSWFUcGNWTWhwUlBMNkFxMkhHcUZM?=
 =?utf-8?B?M0JSWC9INTY4ZDZGc0hocjYwaWxkUWxUS0NySEdLclhRYnVGMXRFK0dUaVc3?=
 =?utf-8?B?YW0zNTdrYzdhY3RsT3UvUFVEOFprNm9CTHk4TFc2dThFZWJFU3dNYzQrdDNo?=
 =?utf-8?B?QzhNcVEybUhHVDUrd2QycVlLamZ3ZlRINGQ3UUtkSFFCMmIvaUhiTkIxQkcy?=
 =?utf-8?B?U2JZWGttN1NIaUJwd3lNMHlIWnFpV1VxemR6QjZ6RFV5Ukc0MXJqa0VralIy?=
 =?utf-8?B?bFNteW0zS0ZyanVXRUxOV3BPSEtFQmJ5a04xcmJGUEJRNzBJcWFMYngrOHY1?=
 =?utf-8?B?M3FSdkFhUzVOQ2VPOFVoMDMyOEFFcjN5YWN2UHNGS3Q2cmV4VWFkZWhVb0xs?=
 =?utf-8?B?L3JIN0U1aFQwNm02N1VzelZRRno1R1puTFNEQ0QwZzNuUE5iRlMrK2tUM1Z3?=
 =?utf-8?B?OWJMOWErZjM2WEIvUFhEVDR2MGZDT05jaDZrUExQWXZKVDRjZldvTHFxQUwr?=
 =?utf-8?B?YmVsT2pPQUlMNHdWZkM0ZWVkY2JMYWx1TXhKVmxMVmZuSU9TcDh3ZjJDQk8z?=
 =?utf-8?Q?MFaysvS3K1n4WgIj936hLs1a1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16e2146-04e1-4ff4-1c0e-08daf5168004
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 03:30:21.1716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B2vWS+Jm02nleKFoWeAWSDHzoKNwcKmisW1zq1uKIvYqU41QbzwoZk4AHICAx3Ac9qObMFbZMv+vh8i8NxRu2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8117
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoYWVsIE5henphcmVubyBU
cmltYXJjaGkgPG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20+DQo+IFNlbnQ6IDIwMjPlubQx
5pyIOeaXpSAyMTowMg0KPiBUbzogQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPjsgU2hh
d24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsNCj4gRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1A
Z21haWwuY29tPjsgTEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gQ2M6IGxp
bnV4LWFybS1rZXJuZWwgPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47DQo+
IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5h
cm8ub3JnPg0KPiBTdWJqZWN0OiBOWFAgaW14NnVsbCBub25hbGlnbm1lbnQgYnVmZmVyIHF1ZXN0
aW9uDQo+IA0KPiBIaSBIYWlibw0KPiANCj4gV29ya2luZyBvbiBpbXg2dWx6IGRlc2lnbiBhbmQg
Zm91bmQgdGhhdCBpZiBJIHNlbmQgYSBzZGlvIHBhY2tldCB1c2luZyB0aGUNCj4gc2Rpb193cml0
ZXNiIHRoZSBhZG1hIGRyaXZlciB0cmllcyB0byBoYW5kbGUgaXQgd2l0aCB0d28gZG1hIGRlc2Ny
aXB0b3JzLiBUaGUNCj4gZmlyc3Qgb25lIGZpbGxlZCB3aXRoIHRoZSBieXRlcyB1cCB0byAzIHRv
IGNvdmVyIHRoZSBtaXNhbGlnbiBhbmQgdGhlbiBhbm90aGVyDQo+IGJ1ZmZlciBkZXNjcmlwdG9y
DQo+IA0KPiAgIG9mZnNldCA9IChTREhDSV9BRE1BMl9BTElHTiAtIChhZGRyICYgU0RIQ0lfQURN
QTJfTUFTSykpICYNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIFNESENJX0FETUEyX01BU0s7
DQo+ICAgICAgICAgICAgICAgICBpZiAob2Zmc2V0KSB7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGlmIChkYXRhLT5mbGFncyAmIE1NQ19EQVRBX1dSSVRFKSB7DQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYnVmZmVyID0gc2RoY2lfa21hcF9hdG9taWMoc2cpOw0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1lbWNweShhbGlnbiwgYnVmZmVyLCBvZmZzZXQp
Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNkaGNpX2t1bm1hcF9hdG9taWMo
YnVmZmVyKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiANCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgLyogdHJhbiwgdmFsaWQgKi8NCj4gICAgICAgICAgICAgICAgICAgICAgICAg
X19zZGhjaV9hZG1hX3dyaXRlX2Rlc2MoaG9zdCwgJmRlc2MsDQo+IGFsaWduX2FkZHIsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9mZnNldCwNCj4g
QURNQTJfVFJBTl9WQUxJRCk7DQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBCVUdfT04o
b2Zmc2V0ID4gNjU1MzYpOw0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgYWxpZ24gKz0g
U0RIQ0lfQURNQTJfQUxJR047DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGFsaWduX2FkZHIg
Kz0gU0RIQ0lfQURNQTJfQUxJR047DQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBhZGRy
ICs9IG9mZnNldDsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgbGVuIC09IG9mZnNldDsNCj4g
ICAgICAgICAgICAgICAgIH0NCj4gDQo+IEluIDQ4LjcuNCBEYXRhIExlbmd0aCBTZXR0aW5nDQo+
IEZvciBlaXRoZXIgQURNQSAoQURNQTEgb3IgQURNQTIpIHRyYW5zZmVyLCB0aGUgZGF0YSBpbiB0
aGUgZGF0YSBidWZmZXIgbXVzdA0KPiBiZSB3b3JkIGFsaWduZWQsIHNvIHRoZSBkYXRhIGxlbmd0
aCBzZXQgaW4gdGhlIGRlc2NyaXB0b3IgbXVzdCBiZSBhIG11bHRpcGxlIG9mIDQuDQo+IEkgaGF2
ZSBub3RpY2VkIHRoYXQgdGhpcyBjb2RlIGRvZXMgbm90IHdvcmsgYXMgZXhwZWN0ZWQuDQoNCkhp
IE1pY2hhZWwsDQoNCk15IHVuZGVyc3RhbmRpbmcgaXM6IGZvciB0aGUgc2VudGVuY2UgIiB0aGUg
ZGF0YSBpbiB0aGUgZGF0YSBidWZmZXIgbXVzdCBiZSB3b3JkIGFsaWduZWQiLCB0aGlzIG1lYW5z
IHRoZSBzdGFydCBhZGRyZXNzIG9mIHRoZSBkYXRhIG11c3QgYmUgd29yZCBhbGlnbmVkLCBidXQg
bm90IGxpbWl0IHRoZSBkYXRhIGxlbmd0aC4NCg0KQmVzdCBSZWdhcmRzDQpIYWlibyBDaGVuDQo+
IA0KPiBEaWQgeW91IGhhdmUgYW55IGZlZWRiYWNrPw0KPiANCj4gTWljaGFlbA0K
