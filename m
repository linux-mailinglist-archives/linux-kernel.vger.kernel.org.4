Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868E665FE29
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjAFJkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjAFJju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:39:50 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2112.outbound.protection.outlook.com [40.107.113.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715BE6B5F9;
        Fri,  6 Jan 2023 01:32:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k19VeLrQVqwKPwO6SYlEkEmUFgoTRkoA4PSbZWR3ju/Sv23WX+VRh4IF28BmulyiDaAd1yNbRxDuejBXGTPaxd1uHbGaNDNtapWNi/4S4AcsbqHvf42cY37BHPxirjn1aozDZySC2+Vty26icVFCO1Ba9xUAv/nGlaI0rWw8QJNOQzYd0N3F1yfvdIy76eEUWM6GudtlE9jbNNG4+j5I0zG1PE+FjjdhVAHikrFoJzkn0arghet3Y4pMYm2m0x0dLvUJnCUDcWsjXIvwzWVTlnAYCCacBuuq8nQZ1jFVBXAiPdl23kmuq1RW6bChSZQp8qLHI+UBt5N4LrglzJw8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwuBjuR6nfhcIIuofivoEBXtNlLo6vzajgLwp/OYAj8=;
 b=Cx8akVz5jk/TEG9zXy9p35kPNIbWmZdqfrl0yDZiVOBWa8OqRC+7TrSkEyqDEVe4ey2us2s/i2+4+MBVxjtrkeE86hS1Yijif5lmE0CisXUDRmHmax7DPOhBtIfkSY82hOrJEF+ngvxQc2TDF6w8snyVE+vVPIDEywWsXwGCQWKOIwTReEOuER5OeR6iAFQni7xBgihUW6HY33hyQJXYC7geC6tR6YNFIqI5YF0+QwPhs2qvNbo6bk7aE6fExDeuL5ZXxla0//0LReoPHMeK8NhXip1ax6KT/syS/PJ2Vknt44EA5f/uRe6m0+J9T+JyLLxY4LmH5rFVWIu9qya0jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwuBjuR6nfhcIIuofivoEBXtNlLo6vzajgLwp/OYAj8=;
 b=U7JtS0IXwnUsuqTO3pOnP5NkWbKCB2E8BOyLniTeBG3N0F3FZsZeZMf6cRTxj6DRkXT9DA++PWAetJsfgzcJNx+RiRMyjuzRPVAPFauATePSBZuqBRV2IoQmRqaRLWFbcNL1eS0ZFp1F7HJgsmQeYcr4Eo5Befjpa2wxuVeHob4=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYWPR01MB9453.jpnprd01.prod.outlook.com (2603:1096:400:1a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 09:32:34 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%3]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 09:32:34 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Lee Jones <lee@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>, Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v4 1/2] dt-bindings: mfd: Add RZ/V2M PWC
Thread-Topic: [PATCH v4 1/2] dt-bindings: mfd: Add RZ/V2M PWC
Thread-Index: AQHZIUIasjbZxcaztEq2NK44HKcSHK6RHBmAgAAEtlA=
Date:   Fri, 6 Jan 2023 09:32:34 +0000
Message-ID: <TYWPR01MB87753A724D502CD3279CDB27C2FB9@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230105201242.189195-1-fabrizio.castro.jz@renesas.com>
 <20230105201242.189195-2-fabrizio.castro.jz@renesas.com>
 <Y7fmgWzR5Pyu3O1A@google.com>
In-Reply-To: <Y7fmgWzR5Pyu3O1A@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYWPR01MB9453:EE_
x-ms-office365-filtering-correlation-id: c015ad8a-83d5-4fd1-0667-08daefc8f106
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oqbnCo9eXq2SFdSLeeJxtIyW1NlC1/U1Mk3RbmnbF+tubY4MJmrg0EuODOLAFE3X6INQpkndKZnnnhUewM896cJk/qJ+Z3jtAHI8dgKXv3So1Hg6GHFmPBwyZr7AztHvZOSv5WNrhIkhWs+Yg8GAgEXSaSRBNJ7V8/+2XRiKkkHcA/DyPX+G18yzY/wwdTeVSyCfHmzT3Lb/F3UEtHdsyA03eSYgrQATDTFd9bff37WXuxz9UxicfPXPCURT4V93uj7QVI2QTdB7KoiwBPYFnvIuLKf3/VsLaXLOvqG6H2ng8ceqIgq/QRVv+taI5EqNcgXR/feyahktZhYysn1zcP5HS8tY7vrHaq4W5KzK95F5L1/8lppWAR7d57a6kI8Ug5/dLkAoQDwdMxjNeFmDXp3gTWR4dHvKjXnmT/qpz3XqtdlnGh+hlCehx2CGtsZ77+VPWioLQ5IWaXThW1gsCIhMf91LzRQDdtgYOGMF4RvgK3jWUWhyf9tycIHuLceoQAgspnFdhDwm/qgXNJLYqNkfqAl92Kd3SGoZyB5Z+ZVBCDnRBT/DmMiEQnu1bcqoSQ0GsI1O9ND8LTaD/Rb0d2g52KVuYNnifxHqNoGiJOlNqgGzPkhIXFvc/ThWoOMc8yLrR9qSkaLybU8g0nM8HJvH2w1RfrgKEVPKEJ6ht5RHyc+AnKKFG1ObsBZ91y0naAeEyayNbMPQ6Zlc6ahcGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199015)(9686003)(55016003)(26005)(33656002)(6506007)(186003)(86362001)(38070700005)(122000001)(38100700002)(316002)(52536014)(4326008)(8676002)(41300700001)(5660300002)(7416002)(7696005)(2906002)(66476007)(71200400001)(8936002)(66946007)(76116006)(66446008)(66556008)(64756008)(478600001)(6916009)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVVLV3I3OHI5Y2ZSVnVvbjdnZnBFTUZUb0ZTeVAwTUt2RnJaWVNaN3c5SktK?=
 =?utf-8?B?YzJxeDltc3kvTDFsS0p3SWlBZXpRU3BvYmxjaVp6ZG9XMjh5S3p6WTJJYVNq?=
 =?utf-8?B?cE1Lb0R1QmE3OHVldFpxZDZWaTc3MDAzRlphc1VHSGlrTWs3TURiamVmcFdU?=
 =?utf-8?B?WGg4aGhPbXNlbzllbDhBa3ZuV3ZCWWVVYmVmZFBoTHlQL1hQbURURzczYXJm?=
 =?utf-8?B?L1FHeFNBNkM4NnMrN1g0Z3dwUGJjZEtWZExST0xlcVhEU0lZakVaaHlPTzlB?=
 =?utf-8?B?YmJ2VSt0eDZ3UVpEK2t6eXlndktUSDYrM3VIRk9Salg5R0ptYW8wS1VnelNy?=
 =?utf-8?B?WW5mZ1ZlTVRYWmwwZ1VkSG9uemhCRitIOThlVldHOWFmb2dTSCtLc05HSURI?=
 =?utf-8?B?MjRmdDdDQUNtZUdSeFRnQ1dpRjBuQjJPVk9lQ09HaFBWdHp2RkwwV2dueFFB?=
 =?utf-8?B?Z2hkYjFOL1RsaGp0QVo2V3pkcGRyLzNTUjJPczgrY3hKRFZZelc4VWZPNi80?=
 =?utf-8?B?UyswTkdLVXVSWC95Y1V5c3NlWkp4U2RmTUJoRHU5RmRiT1RWY3NoV0gwc0NE?=
 =?utf-8?B?aEpTQks4YlhyZmE4VGc0dXFndjhzOVczblZKNEdUTkhtZldBMjl2UGtCMUdF?=
 =?utf-8?B?S0JYbHFyYWJEQVJWalQvdzVNWkRwbEJ3TmFScGhMVUphWUF6MDNsWEZSTUc2?=
 =?utf-8?B?dER4OUJMWVd2REFGaXpUdy9oeGN4ZUJhdGZJVUx4cTQyWWNnL1lIVWtrN0Mz?=
 =?utf-8?B?Q1VCem80dTd6NkpiRlhBaXZEdUpWYTE5aksvSVh5dkkyQ1lUNmcwNXhpWGFP?=
 =?utf-8?B?WlpJQ2FLOHBnby9pK3B0SDEvREEzVFAyRVVyUU9vRVBERlRMdnZGTjYwNi9q?=
 =?utf-8?B?SUo2Z1FxalNrd1BnWVp1eTZSckVQaXZ3dUNqdm5FV1pDSTUxaU9qSExINkxP?=
 =?utf-8?B?Q3gzOEdUa3pHVGhEYmJBUkR4TlpMa0RodnU3c01jYnQ4RXk2amM1ZGErUTFz?=
 =?utf-8?B?bzdaRFdyZUZFNkhKSEpTcmhZK2hJRkk4ZjJCcFBZTndQL0VZckRCd3RoQ1p1?=
 =?utf-8?B?M3dPdElnckFyMlY5UG52LzJDYnV6d3hrMG12SExwd2NhRi9mVVA4VzVVVjIv?=
 =?utf-8?B?TzB3c1IwbG5kYUZPV2YyVy9RQTJXVnlmRmo1bm5KdVVBanlXcUlpQ3ZDUlc1?=
 =?utf-8?B?ZnJKY2ptcFdIVmM1OUZ2bVlvMVhLQSthclA4L2dFU3BrY2xpS2J0QVdMK2R4?=
 =?utf-8?B?ejRBd05wR1lwZ3RnTTFwUTVsaTlhbWxRSWE3QzRycGxmblVtU2tWM2ZxU01r?=
 =?utf-8?B?emZLZlhLTVpWZmcvNWFCVlprOHpaS3A0VWxUdFZJVlZzNWlGb0VYcHZiZDQw?=
 =?utf-8?B?VlNCKzF1NWNmNWN5VUR1cXRBeml4ZU1sTy9GZyt3aUpObjlUYVdKamE1WFJu?=
 =?utf-8?B?WUVVY1J4Y3BCbXM4bUpvdkE4dEpVZ0NJVm5DejNmOFFDK3hqWkVLTExlTVBX?=
 =?utf-8?B?ckI0VmdoZHhKWUFuWkFqdDNDRXRzaUh2UjNMb1Rpa3d6UEo0WFhKQXBaS3ZL?=
 =?utf-8?B?QW1PTGtMVy9yQ0hFaC92ejduU29ESXFHTHlDdjNmZG9Fd2RlQ2w4NGE4ZENH?=
 =?utf-8?B?YUlmZWF4R1JnUnJEbG5TTFBMeFB2Si81SXdoMmY2RE1zeGhreTJYNk11SW9k?=
 =?utf-8?B?MTRjdDF2Sjh6RnoyZXBpQm0xQm1GSWhnK2U0QzNUOHM1a2RqeU84d1RPaFZM?=
 =?utf-8?B?YlFvUHdranBlNXR1cm91MVR6WDFpRmhtck5hdDJEK3RiNDNBTGgxaEJZV3R4?=
 =?utf-8?B?WTU4M2YwMlBTU3RGd29GRkw1TE1kRXovNERoWjhrRDgvS2Q2T1VaekUwd08z?=
 =?utf-8?B?QlZYc2pJMWJ4WWZGRWVkMUlndEhVSndieDk1TmloeHAxZnRnU01OTVdQb0ZB?=
 =?utf-8?B?aHc1d0dPKzNHemQxN0pvZGhDMUlJd0FsbzBlNkVXVTRMbU5rNWxyU3N3Q2NI?=
 =?utf-8?B?U0NvY084TER2V21tN3V2WVRobVFhbFV2eFZWZEo5MU5vQ0ZCMTdla010ZlFO?=
 =?utf-8?B?bHdpQXJMK1Y5bWN4bTBFSndyUGZHTU40eGh4b212VU5Ickx5YVI2WDdldmh4?=
 =?utf-8?B?YjlqR2krd1FlVmFiMXlxTFlaS0tjMnYzQ0cwTUZQRW51QVdGdHV5elB4UnVB?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c015ad8a-83d5-4fd1-0667-08daefc8f106
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 09:32:34.1922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gt0SnaFjslT4ou6d5fof9elnalsdhXRcccrn1y7XhVYCXpundSGyUpkQWqDPWLtYzBkHcWLRlhIjfKzzaDJzHeSvUIeo3RLPV84iVbsxE68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9453
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVlLA0KDQpUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2shDQoNCj4gDQo+IE9uIFRodSwgMDUg
SmFuIDIwMjMsIEZhYnJpemlvIENhc3RybyB3cm90ZToNCj4gDQo+ID4gVGhlIFJlbmVzYXMgUlov
VjJNIEV4dGVybmFsIFBvd2VyIFNlcXVlbmNlIENvbnRyb2xsZXIgKFBXQykNCj4gPiBJUCBpcyBh
IG11bHRpLWZ1bmN0aW9uIGRldmljZSwgYW5kIGl0J3MgY2FwYWJsZSBvZjoNCj4gPiAqIGV4dGVy
bmFsIHBvd2VyIHN1cHBseSBvbi9vZmYgc2VxdWVuY2UgZ2VuZXJhdGlvbg0KPiA+ICogb24vb2Zm
IHNpZ25hbCBnZW5lcmF0aW9uIGZvciB0aGUgTFBERFI0IGNvcmUgcG93ZXIgc3VwcGx5IChMUFZE
RCkNCj4gPiAqIGtleSBpbnB1dCBzaWduYWxzIHByb2Nlc3NpbmcNCj4gPiAqIGdlbmVyYWwtcHVy
cG9zZSBvdXRwdXQgcGlucw0KPiANCj4gVGhlIHN1YmplY3QgbGluZSBub3cgbmVlZHMgY2hhbmdp
bmcuDQo+IA0KPiBUaGlzIHBhdGNoIGRvZXNuJ3QgaGF2ZSBhbnl0aGluZyB0byBkbyB3aXRoIE1G
RC4NCg0KRG9oLCB5b3UgYXJlIGFic29sdXRlbHkgcmlnaHQsIEknbGwgc2VuZCBhIHY1IHRvIGFk
ZHJlc3MgdGhhdC4NCg0KVGhhbmtzLA0KRmFiDQoNCj4gDQo+ID4gQWRkIHRoZSBjb3JyZXNwb25k
aW5nIGR0LWJpbmRpbmdzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRmFicml6aW8gQ2FzdHJv
IDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFJvYiBI
ZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gLS0tDQo+ID4NCj4gPiB2MS0+djI6IEkgaGF2
ZSBkcm9wcGVkIHN5c2Nvbiwgc2ltcGxlLW1mZCwgcmVnbWFwLCBvZmZzZXQsIGFuZCB0aGUgY2hp
bGQNCj4gbm9kZXMuDQo+ID4gdjItPnYzOiBObyBjaGFuZ2UuDQo+ID4gdjMtPnY0OiBNb3ZlZCBm
aWxlIHVuZGVyIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvcmVuZXNhcywN
Cj4gPiAgICAgICAgIGFuZCBjaGFuZ2VkICRpZCBhY2NvcmRpbmdseS4gUm9iLCBJIGhhdmUga2Vw
dCB5b3VyIFJldmlld2VkLWJ5DQo+ID4gICAgICAgICB0YWcgYXNzdW1pbmcgeW91IGFyZSBzdGls
bCBoYXBweSwgcGxlYXNlIGRvIGp1bXAgaW4gaWYgeW91IHRoaW5rDQo+ID4gICAgICAgICB0aGF0
J3Mgbm90IGFwcHJvcHJpYXRlIGFueW1vcmUuDQo+ID4NCj4gPiAgLi4uL3NvYy9yZW5lc2FzL3Jl
bmVzYXMscnp2Mm0tcHdjLnlhbWwgICAgICAgIHwgNTYgKysrKysrKysrKysrKysrKysrKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2
NDQNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9yZW5lc2FzL3JlbmVz
YXMscnp2Mm0tcHdjLnlhbWwNCj4gDQo+IC0tDQo+IExlZSBKb25lcyBb5p2O55C85pavXQ0K
