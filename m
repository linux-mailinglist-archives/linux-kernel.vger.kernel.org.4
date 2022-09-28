Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602505ED81C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiI1Iqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbiI1IqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:46:19 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2136.outbound.protection.outlook.com [40.107.114.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3676DDC10B;
        Wed, 28 Sep 2022 01:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkK/H1KXKGjT9a1iXXCi/AiiBA0UHbXoI4t2/qU5sfzfK6yjHwKrwaZFRMQb4XtuHBsayrcUt+GEC6YXTnzDAvVKTuQ6ts6YjFeZreBQ5IeNRT1svbcYGNooiEWoz4XrmZAl03F1wV+ZNZN3W7jI0D5NxeuPdRE8snWYSUMCQGxJftmxCTy+YR7tHT8YnqYuO9+hjD/SenoKYK5C52X4XhbD3W6BHwqIz2jTZjtsmhybGcoDwSo8KLbAruPfquIWPYTXD97OOa/MowD3OPCUH5abBK8Qq5Cs7kz8p3eK7r/zsB/5dEtKPZi4Fp0O8DFjFmR2eu09yfQkIudUEldkDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKXGKF4bIEJ8SGzt8OkrON94ee9xKSVD5/TqUByJieE=;
 b=G2XerfTkAxR0W2q1FFC2xmHTkLm/T52sQt2+s6MX5qCmIlz7Yybfu4MoE+8Hte0iFPMPCo0/qQPnZcGWkw1k5NvNrjDQlU5R9k1oqbx12sV+Pg8wyPyChAKFUL09dBOKC25nyW8BrVvNGPmyXfSRVloJPxb4R9ENNA/rFEjjy+Ip0JbJvO8ow8DhuFRajxBcJZI13JfJvPsYUYngVGuoUTS+hgaPku8QZntFDwu3pi7OzXk4gTm2UqZxNb7Y/Zz5cl5rw7cvA1SuPoRoofvTA+Z/Yml1B/I2lTCrxY+c5HRZfiVdIuAwwtFZ8YG6nAF74o7LjW3ee7Xieo8JDe0QkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKXGKF4bIEJ8SGzt8OkrON94ee9xKSVD5/TqUByJieE=;
 b=V2/Zn6KQtdy8+n9QRyEx6qCub8atGKAnK0om4EOCGd4GI1aaoo549my/MdURDupi4HXFVKtTn/6EcQB+1JisoN1j9HGlRnBxT8iMemAi2X6KVdyeORv2ckOYRn6rak2/I3qCrcTXDhK6eLPgep2aL0iasKQSceI8vZxGCYmuXHs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY1PR01MB10689.jpnprd01.prod.outlook.com (2603:1096:400:31c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.30; Wed, 28 Sep
 2022 08:42:54 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%7]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 08:42:53 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [RFC PATCH 1/2] clk: renesas: rzg2l: Don't assume all CPG_MOD
 clocks support PM
Thread-Topic: [RFC PATCH 1/2] clk: renesas: rzg2l: Don't assume all CPG_MOD
 clocks support PM
Thread-Index: AQHY0rAT5OHSv2fHs0yDbVRpX5zXfq30aRrQgAAaOwCAAAMn0A==
Date:   Wed, 28 Sep 2022 08:42:53 +0000
Message-ID: <OS0PR01MB5922D5A259A77D22ED91E87286549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220927203044.751611-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220927203044.751611-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922BE73295E3562DC3FBA6E86549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8s=wqGpfWBv7+=tG1pu6fZCL7EtRoTEmo-wjK5CGZyLnQ@mail.gmail.com>
In-Reply-To: <CA+V-a8s=wqGpfWBv7+=tG1pu6fZCL7EtRoTEmo-wjK5CGZyLnQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY1PR01MB10689:EE_
x-ms-office365-filtering-correlation-id: a202c239-40f0-4163-a595-08daa12d6f44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pt+qAj6yq289sy2GrxElU68J70nqLzwjiGOfbhqlwbZzhq7cdnrW/j4VwSWBXuFF4RMLluFFibexU0PLngouJI4sn5vrq4oQBk/y8YJBRDeNU0DgtWgrRkHny/y1D1o0FPvB6iC2r4o+LSI2OVuI5Xo1yROcMd3WX1TIWNg1uFZacInDcpvYA7d3IVLyCpQan3NLj+dPNors/+IUjUOGK+qf/kPOrQdJGodr5cIG1tKes1WH/ROmw0iSyj2Vnwq/BNARVI/Sl4IBTRNXPggX8TJLcZqCZU1AdL+WBdStY7Wbah1yRQB6I7rHbfJTsl0lWaTru83Z5GMwC96Sfm8ZCSA9wLD0hnrLXsqLNm0WjYzJuPAO+hfw3QMSQx2gxGXjMTEqFt8953fJjZHMXbjo8ddYIFDJJsD5EkAHVpYHE+3zzsm+Kh9LthNDfj7XYBAZL3MLziscB3gtgPyLb2KXQ2NBnvx3M3KqgbONdyfm++mPF1SBO76OmUl8tbbVQPzHy2YV/WekB3f1r85+yEftIothOixrxgEbeGZ1eb5LKPWdp6WKvxlLIChgTqK5x/eTFXP22STQ3Xehrrdrmxq4Tg9H1r79ey5ffovX9M91GYwhFOWnnycvPxysjG0JXMA5rORF5vr9SRwv5tBv/ZAIsFMMC3otwveJD+Oo9mvfa6qrEhct3k1bcTQ8xYeYfeZiKutJil76EGfndd+1INMrr7XQGHvcfjjsXEk6/eX+X0LPBmrYpQWnAy+dJ54GX1Cey2zioEhfPfDB69BnLW99/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199015)(6916009)(71200400001)(54906003)(316002)(478600001)(53546011)(8936002)(6506007)(7696005)(76116006)(107886003)(64756008)(4326008)(8676002)(66946007)(66446008)(66476007)(66556008)(41300700001)(26005)(2906002)(9686003)(38070700005)(52536014)(5660300002)(186003)(86362001)(122000001)(55016003)(33656002)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eERXLzhOKzdOcFlMTVE1dWJrbW5MbXBlSksyRjRGaTAvdEVWR2tReDBiZ2Rk?=
 =?utf-8?B?d0t2bkNsS255QkdablEvSTllZ1hzSm9KZ1V5SjNob2E0dEx3OGsrRXhacUph?=
 =?utf-8?B?LzhBMWxlTHZwWXVQVFZQa0ZDWXpxWTNxaUloQ2d1cSt1eHhaQlNlcjZRT2Ns?=
 =?utf-8?B?NDV3NzJudmNwSi9KRWlaNnJKaTZnM0hVTlN5RGhVUjFRQSthZjZKVDJPeWJr?=
 =?utf-8?B?STRFRU1nTWtOU1BiVW5FOGdsbnJ0SnVldlc5Q1JFVVYzWTcrSFlQTENZdTYr?=
 =?utf-8?B?Zm5RUG54SlNSUnFnMHNxbVJleHZoZVB6cnJuY1A1UjJyeW5uNUJRblZ5ZlR6?=
 =?utf-8?B?VUxqeHJrTUNjN01QVjkweEQwYUJRVHJCaHpsakpzayt5NjZ3Q2tjQXJydWNq?=
 =?utf-8?B?QTVSMnc3SmZ4U0RnMWdnOUNpK0FUc1dFSk5OQWQxbnRkekdsVWRueWpxYmxm?=
 =?utf-8?B?YnVpNVpBWGJXSG94QUcza3RSR3p3RFdHTXN4UkhmR2JwTGU4N2NZUENxZnps?=
 =?utf-8?B?OVBybU1JakJNUWZ2NkFCbzk0WUhJOENvTVhBYWZseThDQjlLWUtVcnZQTzMy?=
 =?utf-8?B?T2ltQVRYVHVnaDA2clBqdElrQTY4bjcrUnRTT0RNMlNoWmYrbENTYWdXeVVT?=
 =?utf-8?B?ZG9GbHJ5a2tnMDYyblhsbmhINStTdzAxZTA3TVhKcHd6OGhQcm5iMTl4ajlq?=
 =?utf-8?B?Um5Zc0hHMXE5Y1dvbzdQbE9ONFh2NmM1VTRmaVhLenVpTExUREtMYnFmV2sy?=
 =?utf-8?B?MUtockFVK3JicXRuVUNwbm9UclVRdklINExHTmZSWFJITExUdmJJSzlyR1RO?=
 =?utf-8?B?SEFtOVZJbWRiaVZzbGswZ28xMEQ1NUFBOHhyNXExRnREb3lEY2lZWDV3UVI3?=
 =?utf-8?B?bkd5c3ArSUpUK3BSejB0MklyRUxQbzNDaFRYSnNzU3RBekdUTmJoaXZaWFVE?=
 =?utf-8?B?aExpc0RRY0ZoSXBXNkkwMWhWdHJSaUxTM28vL09zeFk3UXZXbHExME9WTDNq?=
 =?utf-8?B?Nzd5K01Eb3ptOHlhV21tMFdMRlBYcFVFSFVibkY1TzBlem1uTXdUYmhrOUUr?=
 =?utf-8?B?QjR4dDNQVk5XYjZRb2FqSEZ4ZG04dnkrZkhQeENQb211dElQSGZqU1h1bTJP?=
 =?utf-8?B?QmNDNUVFRkJuRWZnU0JtcTQ5SG4xcTRZN2tUZDhuZjdaSlNNbG1SeU5KNFRH?=
 =?utf-8?B?VmZGbCtjWlZkb1FnYm5MajJNNGtnOU5WZFRXQTlJcFpxbHVXaEJ6RDZBb0xX?=
 =?utf-8?B?K1lOZlpyTGUvNWZDWktQc010ajRTV1lhQnc1QXBaOEV5TmJManEydGlaYSt4?=
 =?utf-8?B?U0NZQ1RpblRZQm1nTHNHT2dMcXRQSHpTZWlqR3JRa0t2K3I3TlR5UlArUDBt?=
 =?utf-8?B?V3JIaFJTdndIdzRZWUptT2Q1UlcyUi9mMXNHL1Nwc251OFFnUUFjb0E0ZGNy?=
 =?utf-8?B?aUpwL3RMa3BPQTlTZ0NqT3JRUWdEWU5NV3kvcHBDZVlBQjFSSmZaQzFndFVm?=
 =?utf-8?B?UXhEVmlTUi9peVhZTlpDQmZaN1pCbWNlS2VzUmNnUEhVdXV4bGFFZnRDblIx?=
 =?utf-8?B?eFp2d3hpb0FVbFhoQzBsQXFjYVZwZ0VCTE51eUlxNVBobmh0YmhnU0d3Z29Y?=
 =?utf-8?B?MjMxTFBCN3FzcTZDRkJ5ZHpJNXZSNHF5V3lyamlhLzk4US94UWZhOThxUkFD?=
 =?utf-8?B?T3lYSUtFMmNNeVY5SUlsK1Z6aDB0cnRDS2pJa09wZWtkSk9veHNITDB5RXF5?=
 =?utf-8?B?a2RldUhnQ0I4SFVJd284RkZaVHdicFJERXVaTzdMV3NhU2NoSnJ3UkQ4MjFk?=
 =?utf-8?B?YTM4UjBaZHR4VXlsRFRSS0srSDg5MkVKQmhoaUltK0didnQxMmt0eTBCcnFH?=
 =?utf-8?B?eEwycitUQlY2eS9Jc2dsejdJZ2YvZlQyWkpEbVlldmNLc2xqRU05MEZhbUQ5?=
 =?utf-8?B?MzNReDI3OUlSSzBkNmhUcGJ5VWlwN2t5NVlEblYyQkgwYjcwdW9aeE1Wb2RT?=
 =?utf-8?B?cDBXbEhwQndLLy9YcUZmRXdHRFZNZExPWDIzc1lHd0FEcTdJSHg3RTVYaWUw?=
 =?utf-8?B?RVZUM01RbnVrM0NRbkVONG42ZmtFYllVWEhuYk5vQ3NEUFZXQWtwdWt2Tm9M?=
 =?utf-8?Q?TbzDJ3xluv2QKBVWY+IA6Wabp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a202c239-40f0-4163-a595-08daa12d6f44
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 08:42:53.8560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tdYWKcflrMvz17+ocoINh0E7IzEwUJMd5GTNyx/Ckn/AgBRxibx3vy2lRs+uJ3hVoBFFSSvIqq7n0AZeIaqzyCAEnDFctZQsS1tMOgQ22dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10689
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAxLzJdIGNsazogcmVuZXNhczogcnpnMmw6IERvbid0
IGFzc3VtZSBhbGwNCj4gQ1BHX01PRCBjbG9ja3Mgc3VwcG9ydCBQTQ0KPiANCj4gSGkgQmlqdSwN
Cj4gDQo+IFRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCj4gDQo+IE9uIFdlZCwgU2VwIDI4LCAy
MDIyIGF0IDg6MDIgQU0gQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3
cm90ZToNCj4gPg0KPiA+IEhpIFByYWJoYWthciwNCj4gPg0KPiA+ID4gU3ViamVjdDogW1JGQyBQ
QVRDSCAxLzJdIGNsazogcmVuZXNhczogcnpnMmw6IERvbid0IGFzc3VtZSBhbGwNCj4gPiA+IENQ
R19NT0QgY2xvY2tzIHN1cHBvcnQgUE0NCj4gPiA+DQo+ID4gPiBGcm9tOiBMYWQgUHJhYmhha2Fy
IDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+ID4gPg0KPiA+ID4g
VGhlcmUgYXJlIGNhc2VzIHdoZXJlIG5vdCBhbGwgQ1BHX01PRCBjbG9ja3Mgc2hvdWxkIGJlIGFz
c3VtZWQgdG8NCj4gPiA+IHN1cHBvcnQgUE0uIEZvciBleGFtcGxlIG9uIHRoZSBDUlUgYmxvY2sg
dGhlcmUgaXMgYSBwYXJ0aWN1bGFyDQo+ID4gPiBzZXF1ZW5jZSB0aGF0IG5lZWRzIHRvIGJlIGZv
bGxvd2VkIHRvIGluaXRpYWxpemUgdGhlIENTSS0yIEQtUEhZDQo+IGluDQo+ID4gPiB3aGljaCBp
bmRpdmlkdWFsIGNsb2NrcyBuZWVkIHRvIGJlIHR1cm5lZCBPTi9PRkYsIGR1ZSB0byB3aGljaA0K
PiA+ID4gUnVudGltZSBQTSBzdXBwb3J0IHdhc24ndCB1c2VkIGJ5IHRoZSBDUlUgQ1NJLTIgZHJp
dmVyLg0KPiA+ID4NCj4gPiA+IFRoaXMgcGF0Y2ggYWRkcyBzdXBwb3J0IHRvIGFsbG93IGluZGlj
YXRpbmcgaWYgUE0gaXMgc3VwcG9ydGVkIGJ5DQo+ID4gPiB0aGUgQ1BHX01PRCBjbG9ja3MuIEEg
bmV3IG1hY3JvIGlzIERFRl9OT19QTSgpIGlzIGFkZGVkIHdoaWNoIHNldHMNCj4gPiA+IHRoZSBu
b19wbSBmbGFnIGluIHN0cnVjdCByemcybF9tb2RfY2xrIGFuZCB3aGVuIHRoZSBkcml2ZXIgdXNl
cw0KPiA+ID4gUnVudGltZSBQTSBzdXBwb3J0IG5vX3BtIGZsYWcgaXMgY2hlY2tlZCB0byBzZWUg
aWYgdGhlIGNsayBuZWVkcw0KPiB0bw0KPiA+ID4gaW5jbHVkZWQgYXMgcGFydCBvZiBSdW50aW1l
IFBNLg0KPiA+ID4NCj4gPiA+IENQR19NT0QgY2xvY2tzIHdpdGggbm9fcG0gZmxhZyBzZXQgbmVl
ZCB0byBiZSBpbmRpdmlkdWFsbHkgdHVybmVkDQo+ID4gPiBPTi9PRkYgZGVwZW5kaW5nIG9uIHRo
ZSByZXF1aXJlbWVudCBvZiB0aGUgZHJpdmVyLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6
IExhZCBQcmFiaGFrYXINCj4gPiA+IDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNh
cy5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL2Nsay9yZW5lc2FzL3J6ZzJsLWNwZy5j
IHwgMzUNCj4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ID4gPiAtICBk
cml2ZXJzL2Nsay9yZW5lc2FzL3J6ZzJsLWNwZy5oIHwgMTIgKysrKysrKystLS0NCj4gPiA+ICAy
IGZpbGVzIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4gPg0K
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL3JlbmVzYXMvcnpnMmwtY3BnLmMNCj4gPiA+
IGIvZHJpdmVycy9jbGsvcmVuZXNhcy9yemcybC1jcGcuYyBpbmRleCAzZmY2ZWNkNjE3NTYuLmQy
NzUzMjQ5MDllNw0KPiA+ID4gMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2Nsay9yZW5lc2Fz
L3J6ZzJsLWNwZy5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2Nsay9yZW5lc2FzL3J6ZzJsLWNwZy5j
DQo+ID4gPiBAQCAtMTE0LDYgKzExNCw4IEBAIHN0cnVjdCByemcybF9jcGdfcHJpdiB7DQo+ID4g
PiAgICAgICBzdHJ1Y3QgcnpnMmxfcGxsNV9tdXhfZHNpX2Rpdl9wYXJhbSBtdXhfZHNpX2Rpdl9w
YXJhbXM7ICB9Ow0KPiA+ID4NCj4gPiA+ICtzdGF0aWMgc3RydWN0IHJ6ZzJsX2NwZ19wcml2ICpy
emcybF9jcGdfcHJpdjsNCj4gPiA+ICsNCj4gPiA+ICBzdGF0aWMgdm9pZCByemcybF9jcGdfZGVs
X2Nsa19wcm92aWRlcih2b2lkICpkYXRhKSAgew0KPiA+ID4gICAgICAgb2ZfY2xrX2RlbF9wcm92
aWRlcihkYXRhKTsNCj4gPiA+IEBAIC0xMjIzLDE4ICsxMjI1LDQyIEBAIHN0YXRpYyBpbnQNCj4g
PiA+IHJ6ZzJsX2NwZ19yZXNldF9jb250cm9sbGVyX3JlZ2lzdGVyKHN0cnVjdCByemcybF9jcGdf
cHJpdiAqcHJpdikNCj4gPiA+ICAgICAgIHJldHVybiBkZXZtX3Jlc2V0X2NvbnRyb2xsZXJfcmVn
aXN0ZXIocHJpdi0+ZGV2LA0KPiA+ID4gJnByaXYtPnJjZGV2KTsgfQ0KPiA+ID4NCj4gPiA+ICtz
dGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCByemcybF9tb2RfY2xrICpyemcybF9nZXRfbW9kX2Ns
ayhjb25zdA0KPiA+ID4gK3N0cnVjdCByemcybF9jcGdfaW5mbyAqaW5mbywgaW50IGlkKSB7DQo+
ID4gPiArICAgICB1bnNpZ25lZCBpbnQgaTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIGlkICs9IGlu
Zm8tPm51bV90b3RhbF9jb3JlX2Nsa3M7DQo+ID4gPiArICAgICBmb3IgKGkgPSAwOyBpIDwgaW5m
by0+bnVtX21vZF9jbGtzOyBpKyspIHsNCj4gPiA+ICsgICAgICAgICAgICAgaWYgKGluZm8tPm1v
ZF9jbGtzW2ldLmlkID09IGlkKQ0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiAm
aW5mby0+bW9kX2Nsa3NbaV07DQo+ID4gPiArICAgICB9DQo+ID4NCj4gPiBNYXkgYmUgYXMgYW4g
b3B0aW1pemF0aW9uIGFkZCBJRCBhbmQgY2xrIHRvIGEgc2VwYXJhdGUgbGlzdCBhbmQNCj4gPiB0
cmF2ZXJzZSB0aGF0IHNtYWxsZXIgbGlzdCBmb3IgREVGX05PX1BNIGNhc2UuDQo+ID4NCj4gPiBj
YXNlIENQR19NT0Q6DQo+ID4gICAgICAgICByZXR1cm4gcnpnMmxfY3BnX2lzX3BtX21vZChjbGtz
cGVjLT5hcmdzWzFdKTsNCj4gPg0KPiBBcmUgeW91IHN1Z2dlc3RpbmcgYWRkaW5nIG5vX3BtX21v
ZF9jbGtzIGFuZCBub19wbV9tb2RfY2xrcyBvcg0KPiBidWlsZGluZyBhbiBpbnRlcm5hbCBzdHJ1
Y3R1cmUgaW4gc3RydWN0IHJ6ZzJsX2NwZ19wcml2IHdoaWxlIGNhbGxpbmcNCj4gcnpnMmxfY3Bn
X3JlZ2lzdGVyX21vZF9jbGsoKSBmb3IgZWFjaCBtb2QgY2xvY2s/DQoNCkxhdGVyIG9uZS4gVG8g
aGF2ZSBhIHNtYWxsZXIgbGlzdCBvZiBub19wbV9tb2RfY2xrcyB3aGlsZSByZWdpc3RlcmluZyBh
cyBNT0QNCkNsb2NrcyBhbmQgbGF0ZXIgYWRkIFBNIGNsb2NrcyB3aWxsIGNoZWNrIGZvciB0aGUg
bWF0Y2hpbmcgY2xvY2sgSUQgYW5kDQpleGNsdWRlcyBpdC4NCg0KQ2hlZXJzLA0KQmlqdQ0KDQo+
IA0KPiBDaGVlcnMsDQo+IFByYWJoYWthcg0K
