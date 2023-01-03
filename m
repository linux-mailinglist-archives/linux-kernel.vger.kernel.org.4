Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD4765C29F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjACPAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjACPAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:00:11 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2137.outbound.protection.outlook.com [40.107.114.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650FC2AEB;
        Tue,  3 Jan 2023 07:00:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcY5jeEb7VfBuapSgTUg2kgb+pvq0C5+fjbpUsKnAPrmexvMbRIDvZD6edvLUWYnuwOhpBpuYdontUzs3Lip479iDPH3InFSeh50Un9pfn84mDD9mc80aVveBHfsYd9VTh9mRFVJw//K8c/DKcBmF0RK4HhuhMVSiRiiq6ffZfnUzJchcX1xgQgQ/MZxhxFxklWB1CvHNCN1rseUHCzJJZm3B23aDcyw3/9ZOexkIKVKSYFp8w4iWhP4+Hz9tzmaL5aB5Fj2WKwzqFJDfPf3dzdhsQv3Qz82jLl3Bt/Nn8ttnv2xbOYFJREJiMC6+SVOjDJxkEs9TugLDjdWIGCIOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pFHSCk/1xIoQr2ueNarb/CeyZ3i+r8e+Au02vyBma8=;
 b=g45QHay0B5qEqiPXi7pmj+Nx06s+4DK8PowaW5Ua05uA6Cpv43dzp04APu8EDeMU0FqP0jl42gfzNHZaTfynjbU/TQQvDaZ2IdW0EAcIJYgyZtrVT4RVx+SW1Tln1ckfk9YGCc/9RIIKzrPNvNMDHdSL/MWWQ1Jq5xDevjtiwoE/5NXU4pfTemS7raZohRjmZmu822jSx2okbPWoKla4fFaqBjy45v30ZMoZU5cT5nomE6+0l2x/iFL2KpBY1GO2Z1fFpXbdHYh1zNRA3HR/bsJhglsq3H79INJYZI2YT2xCoqIxhKJfCWuj1wq/VWAoUEB0EUcOrBvbrw/pOD/Azw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pFHSCk/1xIoQr2ueNarb/CeyZ3i+r8e+Au02vyBma8=;
 b=lHQ9uz7XFYA2nQHRv8DcGsFVUxIJ8RPKdlEupjqt9HDfes7OS4rTqYyJ2bMlhHLjY+muHluo7gHA5bKzB9HpayhuE0ZLf6VJyrQCk+IOcAWf8dqiJN3MMIxTqviUCstrezPrDbwnxniAfTJqo73USvmpVXPij04P0SVU89O81A4=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYWPR01MB9631.jpnprd01.prod.outlook.com (2603:1096:400:1a5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 15:00:06 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%3]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 15:00:06 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: RE: [PATCH v2 2/4] mfd: Add RZ/V2M PWC core driver
Thread-Topic: [PATCH v2 2/4] mfd: Add RZ/V2M PWC core driver
Thread-Index: AQHZFYCNlCsLkG/3E0Cexn6vTGGaoK6McgmAgAAOnPCAAC0SgIAALvHg
Date:   Tue, 3 Jan 2023 15:00:06 +0000
Message-ID: <TYWPR01MB8775DB97CD956756C7224440C2F49@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221221210917.458537-1-fabrizio.castro.jz@renesas.com>
 <20221221210917.458537-3-fabrizio.castro.jz@renesas.com>
 <CAMuHMdXDwEUzBpG+w_G6=CzKo=n92cdVw6v8JwOwf9o86HnOZQ@mail.gmail.com>
 <TYWPR01MB87758FB15ED12D396AE738DDC2F49@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <CAMuHMdU=Kwi80akxRUFUYz4QKQBkSog2xb4tw=DjJApAr-n5Lw@mail.gmail.com>
In-Reply-To: <CAMuHMdU=Kwi80akxRUFUYz4QKQBkSog2xb4tw=DjJApAr-n5Lw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYWPR01MB9631:EE_
x-ms-office365-filtering-correlation-id: 11cdc64a-b4b8-4d37-e60d-08daed9b337a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JxOY/57jF/jlU7iydM5F5OzVBMOqhUIgLnO3rSa2pE1xcQv0FrxebZi/mx3ZWe1Z2XNQ+Xx06F3vBXPhc5XQHU5rt/tLhWye9DZVXkn5nHJCRkLAehLlZaQ+eCbABFd9JNX770rGH3/KDJLOimjCkgexCT/F/kPiq6f/XI7LD4b9c+QHbKAY+1kRp0z4HZdCl/71ezohNWZzCUH6oIj28Al+Bk9UI/LgLj0HvLqEinCim+W9F4vSKICdkgSHhQxga1y6fVhoV5ZBCSKW+N8URVdsh1pTcJRYlG4ddD4nKzZxNT18KlFDLuF1D3gnbhWlv9GAiShA5HSNQYEhhml7CR8BfJ9FCh5P0fBFjN+QnNzLcEruHGhccsWMAWYWr2Tc2vbzRdBCCg2UgRWfqgwTErIy2q/Lm1OCov8iAbzd0UlSkJ8XG0lyeg2EM0PUxWVyqLInoCU8mxU78Ed7LRhpXlKNPi7x+B714LHVhr8FP9LZZbZOm1xtwaWKm6Xrz0iBS1jR32bEm37SjS9n8KGgEhJ/yI6W/DM1viT922zcwlv04Z7kN2dTAATVO+lDxOkqpSA+Lb+egIvxIoX+9fsEvYR1PipF19tolbKchLK1RdfV2azj6bw4PUkElusaRD1atAd8PjRVhtqMr0UD7wa3euDu9XK7/0aX8z7Y8O+VfrUcVRjqY5eiFyxMtLfWFLU4lfWh4GGHphdKcRcwQ2QwNUkUfP9W3n3vMlMWUrENXdI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199015)(33656002)(86362001)(54906003)(6916009)(478600001)(316002)(38070700005)(55016003)(122000001)(38100700002)(6506007)(26005)(9686003)(7696005)(53546011)(186003)(2906002)(7416002)(5660300002)(71200400001)(41300700001)(4326008)(66476007)(66556008)(66446008)(64756008)(8676002)(52536014)(8936002)(66946007)(76116006)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elJCbU1ST1VjYUZReUZSbjVzWGZPdmlTV2FmcE1UK3luUGdLazZINCtuYnNK?=
 =?utf-8?B?Uzk5QVNvUXN1UEZxSkpmdHVISDdad2JkbHpsa05sbnBnZE1SbVVqWHFWMFZp?=
 =?utf-8?B?VnVSZjQ5dk95ZGcrbDMxbFhMeXhnaU5HQ2loWUhnVHUrbjhKUjhucVNycUd2?=
 =?utf-8?B?eEFWRTg4WWdHRzNUTXNUM1UybDdOdUZwb2xjdFVSNVhRL3pPeDhLdEEzd1Ry?=
 =?utf-8?B?dEdWM2FKNjdBOGNHWTRVbmhNalRZMlI4elVKRnB1aW4vREozbExIdkROeVZU?=
 =?utf-8?B?d1pFMTFTSUNNbmgrZytyZEpxT0Y3a3ZVUWUwZnh4SDJVN1l0MjlSa0VUV1Z1?=
 =?utf-8?B?MnRTRFFxcXBFRlBSZ0lHRzUwUklZc1AvWVdIcDFuZlc1MnJQYTF2N0xRL3l4?=
 =?utf-8?B?OTlwcXlqN1NndWJrYk5wakVJMzg3ZTJDekJ5OWNwZkxyYU8rNjRJbDN4T0kx?=
 =?utf-8?B?RTdJbmFEbFdTM3BublVBQVRoMFdGNlB4Mlh5K0JIOEtsdHJKUmh3Y2tWVGhr?=
 =?utf-8?B?OE1CWjY0ZEpjMmJSamRiTFpZY1Q1R2hvTm9xQVc0MXRrRFZCditqcEFWWFk3?=
 =?utf-8?B?Y2pNYitUK080RU9BbWkvaWhQZ3NSVi8yMXY0SElLOVFmTEVxSG9jam04amdw?=
 =?utf-8?B?bVlXVVJMM0lUNkJNNFFtelFpSmN2MUJuMWVwUFlXVjNwcnVRL3R4bmxEQWt1?=
 =?utf-8?B?ZFlGd3l1WWZqV2xnZHZXOUVJNWhSY0ZDZmN5YWNNZmU3N2REeGtjNURkSHZ5?=
 =?utf-8?B?Y2VFVUhjZnBCbUpoQ3l4VTdNY0UrRHU2SkVndzhLbUNIcGo3K1RuTUR0MjRY?=
 =?utf-8?B?NEZzaGlFaU0xTzJmalhCbk0zT3lnTHhJT1p2aEo3Z3BBeWl0VTF2Nnl4OWdm?=
 =?utf-8?B?R3RsWGNhQm5NQ3NybkxVVnFPb1pLMFNMQzZYTUp5VVV4cEZkdFYxb0Z2QVpG?=
 =?utf-8?B?dTFkczJpOUdQNTUwd1hQVW1OQVJ1NVhWRkJrSkpycTdsZ1lIbjVlVjgxeDB5?=
 =?utf-8?B?dFFVYW1EK1hQMlZEV2ltVHdwWHIwc0Ewa2lXOVdKMjk5ekVmVjgyMHpNZjRk?=
 =?utf-8?B?OWlLN25vM1pSZ1orR294NDBya1dJMGxFbXlTTlpUczR3RHc3SzNmS1Joa00w?=
 =?utf-8?B?aTUwUGZsb2Qremg0aHlVenNac2lVcU80WTZrOFQ4OWJXcWw2Y3R5UC9aYTBk?=
 =?utf-8?B?cUxMcUZJVm9Pc2dkRXJHVFhKNjZjVlNKb3JMOW1JVC9oVFE5NDVpY2VBc0VP?=
 =?utf-8?B?bHRxTEgySkVlQ2d2UXJBckd4SGc5Y1I0aFVRTmRKMXc0SzY3ZWx1dTVHU0xl?=
 =?utf-8?B?S1J4Ui85SFVqRHZCcm9sSGd6Yzk4SVFhRlNkWkFDb1VpVG1DZmtHNXFmRWdw?=
 =?utf-8?B?K3ZRU2RLbCs5SUFjazU4VnowU3FwcnFPY0FZaUY5OW8vSVpwRVp5WnZUZ0NU?=
 =?utf-8?B?MEhaMTJHNzVIckFBK3hJMDFZVTVYeXJiRzlaYXh1YU9HZ2VtaGdsVUU1bjFw?=
 =?utf-8?B?QnFOVk1EMTJoUlRaVTNDZWgyVTR1NWN2amhXekZ6Y2M0TW1SVWVOR2JxbCsw?=
 =?utf-8?B?eW1zSExnQUJYTFFVRkdpaTdUY2kvMWcycGNqVi80WHM1WkRuQWNBVnN6Tmgw?=
 =?utf-8?B?Z1RqcEQ2OG5XTkNTQ3pIV3BVS2ZYMlRDVWhYNGd4RGVhZlZrWHRaMVdESnkv?=
 =?utf-8?B?Mk9nQUlFdTJsNG83WXg4V2JsRVByOGdGbTlYQXpWa0F4Zk8wQ1VsSTlVNVpn?=
 =?utf-8?B?c3ViK0krNlhuUkpoMzJGZWMxUW9vQ1NrSUlseFpCRVN0cXhtVkRxaHNSR3Z5?=
 =?utf-8?B?Rk9TMW9XTmhkbmk0NXZMVmVjNzJvbmFBT3czN2gyd1RPUTNTdmxuSVFHRHIz?=
 =?utf-8?B?Q1hFRHZPVmJJOTFvdk52Q0ZBeEViNW1DK2t6Y0VIeUtDUGdvaG1GQTZNdWZT?=
 =?utf-8?B?ckd1WUdPb0dpaG5CeXpMaFlvZzZ3dEFJdU1sbUo0SjlKaHBpaWFWZWFmeEt2?=
 =?utf-8?B?bWpzcnNIUnFZem1HSEhnOFVkMjVNK25Db3FvekNPYWNkNzlNeXVFOVNucjRP?=
 =?utf-8?B?Zlp2Ui8wdk5EQ0k3aXoyL0xKRm1WRUMyWXArcTNYemZGeUhwQlNqVnVOUkV4?=
 =?utf-8?B?U0FNcVFoRmtIMlpNbTZNaXIyZnBsWlZnbUsrL0VBNHdHWWJ6c25jeVdnSzJW?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cdc64a-b4b8-4d37-e60d-08daed9b337a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 15:00:06.5271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UfT9HE7Zyiu1KnfwKA1NJ33b9rbg7eCAStAwPyfOhW2jiOVGdFGz9/L0UhiABibRChO+qmyMWNDavPo4i5IS76QKqvn/7g0CJH5k/RYoTIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9631
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjayENCg0KPiBGcm9tOiBHZWVy
dCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTZW50OiAwMyBKYW51YXJ5
IDIwMjMgMTI6MTANCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzRdIG1mZDogQWRkIFJaL1Yy
TSBQV0MgY29yZSBkcml2ZXINCj4gDQo+IEhpIEZhYnJpemlvLA0KPiANCj4gT24gVHVlLCBKYW4g
MywgMjAyMyBhdCAxOjA1IFBNIEZhYnJpemlvIENhc3Rybw0KPiA8ZmFicml6aW8uY2FzdHJvLmp6
QHJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiA+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2Vl
cnRAbGludXgtbTY4ay5vcmc+DQo+ID4gPiBPbiBXZWQsIERlYyAyMSwgMjAyMiBhdCAxMDowOSBQ
TSBGYWJyaXppbyBDYXN0cm8NCj4gPiA+IDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+
IHdyb3RlOg0KPiA+ID4gPiBUaGUgRXh0ZXJuYWwgUG93ZXIgU2VxdWVuY2UgQ29udHJvbGxlciAo
UFdDKSBJUCAoZm91bmQgaW4gdGhlDQo+ID4gPiA+IFJaL1YyTSBTb0MpIGlzIGEgY29udHJvbGxl
ciBmb3IgZXh0ZXJuYWwgcG93ZXIgc3VwcGxpZXMgKHJlZ3VsYXRvcnMNCj4gPiA+ID4gYW5kIHBv
d2VyIHN3aXRjaGVzKSwgYW5kIGl0IHN1cHBvcnRzIHRoZSBmb2xsb3dpbmcgZmVhdHVyZXM6IGl0
DQo+ID4gPiA+IGdlbmVyYXRlcyBhIHBvd2VyIG9uL29mZiBzZXF1ZW5jZSBmb3IgZXh0ZXJuYWwg
cG93ZXIgc3VwcGxpZXMsDQo+ID4gPiA+IGl0IGdlbmVyYXRlcyBhbiBvbi9vZmYgc2VxdWVuY2Ug
Zm9yIHRoZSBMUEREUjQgY29yZSBwb3dlciBzdXBwbHkNCj4gPiA+ID4gKExQVkREKSwgaXQgY29t
ZXMgd2l0aCBHZW5lcmFsLVB1cnBvc2UgT3V0cHV0cywgYW5kIGl0IHByb2Nlc3Nlcw0KPiA+ID4g
PiBrZXkgaW5wdXQgc2lnbmFscy4NCj4gPiA+DQo+ID4gPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2gh
DQo+ID4gPg0KPiA+ID4gPiBUaGUgUFdDIGlzIGJhc2ljYWxseSBhIE11bHRpLUZ1bmN0aW9uIERl
dmljZSAoTUZEKSwgaXRzIHNvZnR3YXJlDQo+ID4gPiA+IHN1cHBvcnQgY29tZXMgd2l0aCBhIGNv
cmUgZHJpdmVyLCBhbmQgc3BlY2lhbGl6ZWQgZHJpdmVycyBmb3INCj4gPiA+ID4gaXRzIHNwZWNp
ZmljIGZlYXR1cmVzLg0KPiA+ID4NCj4gPiA+IEkgaGF2ZSB0byBhZG1pdCBJJ20gbm90IHN1Y2gg
YSBiaWcgZmFuIG9mIE1GRC4gIEluIHRoaXMgZHJpdmVyLA0KPiA+ID4geW91IGFyZSBub3QgZXZl
biBzaGFyaW5nIHJlc291cmNlcyBpbiB0aGUgTUZEIGNlbGxzLCBqdXN0IHRoZSBtYXBwZWQNCj4g
PiA+IHJlZ2lzdGVyIGJhc2UuICBTbyBJIHRoaW5rIHlvdSBjYW4gZWFzaWx5IHNhdmUgKzEwMCBM
b0MgYW5kIHJlZHVjZQ0KPiA+ID4gbWFpbnRlbmFuY2Ugc3luY2hyb25pemF0aW9uIG92ZXJoZWFk
IGFjcm9zcyBzdWJzeXN0ZW1zIGJ5IGp1c3QgaGF2aW5nDQo+ID4gPiBhIHNpbmdsZSBub24tTUZE
IGRyaXZlciBpbnN0ZWFkLg0KPiA+ID4NCj4gPiA+IERpZCB5b3UgcGljayBNRkQgYmVjYXVzZSB0
aGUgUFdDIHBvd2Vyb2ZmIGZlYXR1cmUgZGVwZW5kcyBvbiBib2FyZA0KPiA+ID4gd2lyaW5nLCBh
bmQgdGh1cyBpcyBvcHRpb25hbD8NCj4gPg0KPiA+IEkgYW0gbm90IGEgYmlnIGZhbiBvZiBNRkQs
IGVpdGhlci4NCj4gPiBJIHBpY2tlZCBNRkQgYmVjYXVzZSB3ZSB3ZXJlIG5vdCAxMDAlIHN1cmUg
b2Ygd2hhdCB0aGUgSVAgY291bGQgZG8NCj4gPiB3aGVuIHdlIHN0YXJ0ZWQgd29ya2luZyBvbiBp
dC4NCj4gPiBJIGhhdmUgcmVjZWl2ZWQgbW9yZSBpbmZvcm1hdGlvbiByZWdhcmRpbmcgdGhlIElQ
IG5vdyAod2hpY2ggSSBkb24ndA0KPiA+IGhhdmUgdGhlIGxpYmVydHkgdG8gZGlzY3VzcyksIEkg
YW0gc3RpbGwgbm90IDEwMCUgc3VyZSB0aGF0J3MgYWxsDQo+ID4gb2YgaXQsIGJ1dCBiYXNpY2Fs
bHkgaXRzIHN1cHBvcnQgbWF5IHJlcXVpcmUgZXhwYW5zaW9uIGxhdGVyIG9uLg0KPiA+DQo+ID4g
SSBsaWtlZCB0aGUgc29sdXRpb24gYmFzZWQgb24gc3lzY29uIGFuZCBzaW1wbGUtbWZkIGZvciBz
ZXZlcmFsIHJlYXNvbnMsDQo+ID4gYnV0IGhhdmluZyBkcm9wcGVkIHN5c2NvbiBhbmQgc2ltcGxl
LW1mZCBkdWUgdG8gaXNzdWVzIHdpdGggdGhlIGR0LQ0KPiBiaW5kaW5ncw0KPiA+IEkgaGF2ZSBt
b3ZlZCBvbiB3aXRoIGEgY29yZSBkcml2ZXIgdG8gaW5zdGFudGlhdGUgdGhlIHJlcXVpcmVkIFNX
DQo+IHN1cHBvcnQuDQo+ID4gV2UgY291bGQgb2YgY291cnNlIG1vdmUgdG8gYSB1bmlmaWVkIGRy
aXZlciBpZiB0aGF0IG1ha2VzIG1vcmUgc2Vuc2U/DQo+ID4gSWYgd2Ugd2VyZSB0byBtb3ZlIHRv
IHVuaWZpZWQgZHJpdmVyLCB1bmRlciB3aGljaCBkaXJlY3Rvcnkgd291bGQgeW91DQo+ID4gc3Vn
Z2VzdCB3ZSBwdXQgaXQ/DQo+IA0KPiBBcyB0aGUgR1BJTyBwYXJ0IGlzIGxhcmdlciB0aGFuIHRo
ZSBwb3dlcm9mZiBwYXJ0LCBJIHdvdWxkIHB1dCBpdCB1bmRlcg0KPiBkcml2ZXJzL2dwaW8vLiAg
QWx0aG91Z2ggZHJpdmVycy9zb2MvcmVuZXNhcy8gY291bGQgYmUgYW4gb3B0aW9uLCB0b28uDQoN
CkknbGwgdHJ5IHRoZSB1bmlmaWVkIGFwcHJvYWNoIHRoZW4sIHVuZGVyIGRyaXZlcnMvc29jL3Jl
bmVzYXMgLg0KDQpUaGFua3MsDQpGYWIgDQoNCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiAN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRl
cmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGlu
dXgtDQo+IG02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVj
aG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4NCj4gQnV0DQo+IHdoZW4gSSdt
IHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRo
aW5nIGxpa2UNCj4gdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBM
aW51cyBUb3J2YWxkcw0K
