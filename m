Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409246CD646
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjC2JVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjC2JVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:21:11 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2054.outbound.protection.outlook.com [40.107.13.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225342D41;
        Wed, 29 Mar 2023 02:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNnuwcKIDCrs3oqmzxH0ztNVjqyxWonukcYsmKc2m8gxJVzXcZ79nd7m8fSv10vA7/kOElTouIJjJnltxmalts4gq6Sn4G/FphrmZv+JoJ06KUCUCkWuduJyuJhN5Ouviysaeb8aWa9cWu5C5qzfcJww8lZ23mBofTJbbozK0YF4N/dHYLiVw7ev+vQfXmkV/nCFC5v7vKyyFfccDe6lsBfecXzsHwB9i/AUMJazYv8ZDh3rX5hpI8Fnn7oJZRumwvqz0ccnNkv1gE6Se1aqQcQJ46cye5A3ZZVYi0ajaUqzwL4lWBZeJxsKHD7+8L+FNFimUpAy5EJoHpC5kHJWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kyI1bj8I+snjeXLKLx6lqqUZp+jauT0QyPj0tAi5G8=;
 b=FVNdhLsfdni1m84aU7KrD4oqxaf1OY/YSsL7zx8U3lP03fbHYFj4P0D/oMD6qLWEEG2NfQZIhFAitRFtPufHFv9vNVS7kbvVmbgXFJZn5qUpeSd45kx51x9wsFawO4YvCHqgDAoMuHv0HoTmY9oKHAie9eCrr8VCc6pDK39URchVaS47lwO3P6PX4G0PYudSR9EGBL0eptGRudBmqiDVE/DO3/x+mPoIjGb7su7PxVQG6CV64WZCiK0sNC2TKK03UzpKJyz59+NjVjDVQ7CIwLN5TcrCIxKnnO2axSsV2k9pnPeFBOOPVXa3dBzdB+GepeENRzIbqs02tLg2dZpHaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kyI1bj8I+snjeXLKLx6lqqUZp+jauT0QyPj0tAi5G8=;
 b=YEvOW1sy44MbCA77NS6s57PDXRwilgqT0zJGvTfi/x3qc5gGuNHYTUk7gaC9TP6VkKoZoMI9bIR7pGaMEGpNfhdW2vFFe6hGUp535QG5oxokcOELIBcP1H6SdAa2u0vdyurPhfr7o25up9R4x6oJPMaTGva6ndzZyBeyNHSjitE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8271.eurprd04.prod.outlook.com (2603:10a6:102:1ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 09:21:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Wed, 29 Mar 2023
 09:21:07 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] dt-bindings: gpio: vf610: update gpio-ranges
Thread-Topic: [PATCH 2/2] dt-bindings: gpio: vf610: update gpio-ranges
Thread-Index: AQHZYTWHlLJfadkgwkCFXG+MNPJ2Yq8QRiwAgAE1mCA=
Date:   Wed, 29 Mar 2023 09:21:07 +0000
Message-ID: <DU0PR04MB9417F31D78A9C998FE3E519888899@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230328052912.1957000-1-peng.fan@oss.nxp.com>
 <20230328052912.1957000-2-peng.fan@oss.nxp.com>
 <de82d0ff-3e2f-4822-8430-13e2b1633b3a@lunn.ch>
In-Reply-To: <de82d0ff-3e2f-4822-8430-13e2b1633b3a@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8271:EE_
x-ms-office365-filtering-correlation-id: f71f579d-a9d0-413a-777c-08db3036ed5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BU27LpNuV94SzcRT3mB+eQJWENBXi0Cx26wKiAIgRDLjwfK8SP7PgaNVjoSta0PR833OU/dUnt3jdovhQr8gGrT2brf7QSBYL8jl4e+PdH/Zo3mc27Gf1jJzXU+7ufIolG02dfc4tqwZ4Qp54xPXPO5S2UQ/4CQ817vYQV82B8Xe5RN4p18t/GYR96Zg3LQtxnJXkb1cbZ2sRtdOeZZCfj3JNKzd1Jty9odG2WIh6kCfVi/Kbp9FrVA0GCmK/lz3rna3xh3Pp1vLhdR4JKt3l3LonOJyrbSBAD32brM02cQhtnudiuNe9nwZmreVR15+eAmBaKmDF6NbEmF458XxBtqtATMTRHOXfzjsjUyC6p1V0p/71tk1SPnaYwOcQh4be5mpG8qmaQG2lDtFbe6tQxll51woD7BsCCSOiRZk1mVpj6ZmQ7TRuccqEZYNirypoqZMnGkQrRn88Z3P0+/VfElz8mnXZ6OvhStRhUeDf6XdBi6EsXdxbCYO+BuC6SpH50QWM46LAJ55gO+2Lrc9xmTYI0fj+rL6udZAxAredyxyl7zpA7s1AFGVeKmp3YC7v42qIZl3JQixHSUn9YmiOdvXOaSybXbwcOCls9Z0gXcFynZX4jjmj5ST9qAcZCPI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199021)(83380400001)(6506007)(122000001)(26005)(53546011)(478600001)(54906003)(38070700005)(316002)(7696005)(110136005)(7416002)(52536014)(66946007)(66446008)(64756008)(8676002)(66556008)(76116006)(66476007)(71200400001)(55016003)(4326008)(86362001)(41300700001)(9686003)(38100700002)(44832011)(33656002)(15650500001)(8936002)(2906002)(5660300002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?R1J6WXltSjVha0ZqQ0pFS1A2RzJiU2FBSWJOejh4VUp1ZmVOM0xSWDQ5YzhM?=
 =?gb2312?B?VDMxUWtZOHdMUEJaUkJrQ3FYTUJJYk85Vy9wL0pCSnJSV0dEdjBDNys2eVoz?=
 =?gb2312?B?bERoM3NjVzZMR3hwaW1wZENXM2tOTU1LNGtKbWpaK01yKzlyM0U4eTB0Tmph?=
 =?gb2312?B?NEF0ejhoUGI1eWFVR1dEbXo5cEVWMXhheGhIWDJIWlgyQlZQSzVTUk1NWG42?=
 =?gb2312?B?OFBzQ3B4ZCtSMVd0Z3EyejIwd1Y0VkVwZkI3TVB6WnZENVFzL3lXWVl0NWxo?=
 =?gb2312?B?TkNITTFOWXllNElseU5nUnVwRm1WQzVCdU5MZVZORzZvVzNHWDhKQTBLOUZs?=
 =?gb2312?B?OHYwMHo5QUhCOGJWQVJORnpRRHlqdDcxY291RUtkVDV5RmswRXRpRVlCaTFu?=
 =?gb2312?B?dWJyQklCQkw5OWNVSkZUL0ptcVNXUG0rT3BxWjRGWVB1SGZ5a0RwdklaMnNo?=
 =?gb2312?B?elFsYXZoTytYOE0zdDV2RksrODJHWExOZStqbUoveWFzaWp1UytuRVM1VXlR?=
 =?gb2312?B?UEoxcDZwSmVGYmM0aVBWbzhSQVBKK2hid1NERHZCMUhCd0Q3VU5XWXZoUnkx?=
 =?gb2312?B?anJRZ29Fc29ibWRuaDkxV1VhS292eVFUUGpnYVpCNWg0RERNSDR4NnJvNFVk?=
 =?gb2312?B?YVVoNzhhcExIVHBTRWhheWpBV09jYVdrRnptSzdoREd3ZUM2bHNKcENVUVNu?=
 =?gb2312?B?M2UrOGJFQW1IaXYzaTBZdkRMLzBNR3h5ZHNLS05mcHRBM0IveVVCMTN2K0Zn?=
 =?gb2312?B?MXZWVGZka1ZEM3lHWFEwMnlJNVdIdHprdDBFZjF1TTVkdFRlV2V5ZVo3N21D?=
 =?gb2312?B?Y0JMMENwU2NDaXNYZC9lYi9Ea29LRURYOTczSk5kcVd5dVB2VEpYZ2tmZXNj?=
 =?gb2312?B?ZjA1M0J2SEtzK084a3orTlFLVTdFaTREWnR5NzkvRkFMMlV3L2E3MjBXR0wz?=
 =?gb2312?B?bFBMMGJxdkRxclhWQUh4WGxQc0JudXJPb253cGw0SUlidEFMNlRzWlFHT255?=
 =?gb2312?B?MzBvZlA0QzBWWTl1V293UnA0WStiUHRPWjQvZzBFTEJLU1d4TFh6Q3lXdHRW?=
 =?gb2312?B?Zk1VVHFHeE45UG5remQ0K0NjYjZQbHMwMzMyT3hSNTBqdE9KODJic245T25r?=
 =?gb2312?B?ZDJyNWdKSUNMenBCQXgyUWFNZlc3QmpYZE92M05BNW5aK0REVFRkaFZXOUJp?=
 =?gb2312?B?TGZjK0g3TUo4VkJhSGdLS05jYllhNXluQlpBejh1cVZwNnNibjhOTXBYSWhm?=
 =?gb2312?B?Tkpsc25PYUN2dHhZNm1NOHFOdkZOVWZ6N3hTTU55b2krOGErVjdkL09PRStI?=
 =?gb2312?B?elplYXpZdElrUThUb1V3Z1FkMERoKzVLM3RsVGdBZ2ZROUxiTkNRZ1pOVGJI?=
 =?gb2312?B?NkM3WkZ2aFF6cmlqaXI2eWxBcnF3aUdENXJRYmNWWWJ1WldyZXBhamg4cXBE?=
 =?gb2312?B?RHNWbndnK1IzbUs3M3huT3o3LzlucEI4WkZjUWNwb2ZZdk9wdDFYMllMR1Jr?=
 =?gb2312?B?Vm42Yng2NkswOERtZkVZOUVHZmZMZFdCQ1ErRDZmc1FGbk9FVVNZa0RNcENj?=
 =?gb2312?B?b0V3cTVJbnVKMFZyVWYrcjNxR3ZNcy9obGs1SzVldStvaUxnWWV4TUFXWndu?=
 =?gb2312?B?YkpjaVJQaHMyeHUxb1ZIVHZhQmc1bWFtVXFJWUwxcTYxWm5tN1pLNUUzVjFz?=
 =?gb2312?B?TUovZ1RxZFlINVRac2dKTlhrMld0SURiaDFUei9zWHJBZmFpZzl4czBJalVs?=
 =?gb2312?B?M3QwdG5UTWk4d2hJUU1KL1VJbkhDbjkwaitwL2VSckVDZkx2ek4yQmlva2Ew?=
 =?gb2312?B?ZGhtOWo0S1AxS3hDWDFwdVBkK0MyT0l4M2V5M3NyZmhvdllVOUZmUVBZUWRG?=
 =?gb2312?B?NWNxWjlnQk9mZXZkNTlmRnUvK3dReUo1T0xhSGhOSHJnVzZSNDNXN3NmR3Y4?=
 =?gb2312?B?M3dMOXJ6bDZDQlZGQnBiM1kvZnl0b0hNb1FCN0YzNHZqaXZpb0ZSbGNBeEFG?=
 =?gb2312?B?SzhNUkdvck1WUUY0WXZTTEtWL09ydzN2QTJSM3h4T25TMXNIbEpLWXBBV0pX?=
 =?gb2312?B?UW9zUnZEYXR6Ym5RdVpxbFZ1ODZKendzaE0xOUFKQjFZd1hQeStvNDFKNDRM?=
 =?gb2312?Q?3aT4=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71f579d-a9d0-413a-777c-08db3036ed5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 09:21:07.1329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9NjXVBOi8gM1Oa2RJPQQI5rZHjnTafxBcrPXLAXVwG663/FLPr+4NqOKtBC+3VJE9432+SaOBx8G+DTJal/1pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8271
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEx1bm4gPGFu
ZHJld0BsdW5uLmNoPg0KPiBTZW50OiAyMDIzxOoz1MIyOMjVIDIyOjQ4DQo+IFRvOiBQZW5nIEZh
biAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+IENjOiBsaW51cy53YWxsZWlqQGxpbmFy
by5vcmc7IGJyZ2xAYmdkZXYucGw7IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtv
emxvd3NraStkdEBsaW5hcm8ub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBl
bmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsN
Cj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IHN0ZWZhbkBhZ25lci5jaDsgbGlu
dXgtDQo+IGdwaW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgUGVuZyBGYW4NCj4gPHBlbmcuZmFuQG54cC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMi8yXSBkdC1iaW5kaW5nczogZ3BpbzogdmY2MTA6IHVwZGF0ZSBncGlvLXJh
bmdlcw0KPiANCj4gT24gVHVlLCBNYXIgMjgsIDIwMjMgYXQgMDE6Mjk6MTJQTSArMDgwMCwgUGVu
ZyBGYW4gKE9TUykgd3JvdGU6DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+
DQo+ID4NCj4gPiAxIGlzIG5vdCBlbm91Z2ggZm9yIGkuTVg5LCBlbmxhcmdlIGl0Lg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gLS0tDQo+
ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncGlvL2dwaW8tdmY2MTAueWFt
bCB8IDMgKystDQo+IA0KPiBJJ20gbm90IHRoYXQga25vd2xlZGdlYWJsZSBhYm91dCBpLk1YOSwg
YnV0IGkgdGhvdWdodCB2ZjYxMCB3YXMgVnlicmlkLA0KPiB3aGljaCBpcyBub3QgYW4gaS5NWDku
IERvZXMgaS5NWDkgcmV1c2UgdGhlIFZ5YnJpZCBHUElPIGNvbnRyb2xsZXI/IElzIHRoaXMNCj4g
Y2hhbmdlIGFsc28gdmFsaWQgZm9yIHRoZSBWeWJyaWQ/DQpbUGVuZyBGYW5dIA0KDQppLk1YOSBy
ZXVzZSB0aGUgZ3Bpby12ZjYxMCBkcml2ZXIgYW5kIHlhbWwgZHRzY2hlbWEuIFRoZXJlIGFyZSBz
b21lDQptaW5vciBkaWZmZXJlbmNlcyBmcm9tIGhhcmR3YXJlIGxldmVsLiBUaGUgZ3Bpby1yYW5n
ZXMgd2lsbCBhbHNvIGltcGFjdA0KdnlicmlkLCBidXQgdGhpcyBtYXkgbm90IG1hdHRlci4NCg0K
UmVnYXJkcywNClBlbmcuDQo+IA0KPiAJQW5kcmV3DQo=
