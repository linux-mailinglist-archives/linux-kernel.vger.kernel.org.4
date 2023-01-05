Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA5365F2C9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbjAEReK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbjAERds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:33:48 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2108.outbound.protection.outlook.com [40.107.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA4B2DE1;
        Thu,  5 Jan 2023 09:33:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIPADfOEK6IM/Umi3xJIGD8/C6gEtfS6FkVicUTpGRWIijDDuh4TWj6ajyv+v1Hj4emSufsW7P5ifZLSxGGrLuMPdB2olsjX1sywdEfLi8S3iuwbXE8odeA9DpMkTcsf6gx4DJZwCnuTYAJLlsMyfKAbzXMmLY2b+u9nr0UNg0ULd3ekPBHhwdmoPLRP5UylqQENIE/NSyh0NMf8PZHLGjnkmOfl+dqDmqT/lVOaDL7CZipK8lVTQ55pG7v70hEVw6qXVI9DgHH7K4dtDt4CwNgt1n6CSQgsRGUTMOvxRmERbCXgQqxfMKIMUwD3Ow2i+i96HHUeKxkvR386QqdlFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjSnWxigMrJ9sMkSrTVwHsgc++yae5I6Rr0sDZ4BS8s=;
 b=SzzXetcuvJzGDG7oFqQlpetLR7/vajHJC7uMdtnc7hYutFIAlRiJOK+CcBUR+WosQdTS79jY1krKr1o5Us7TXYBWpB3cxPzNjt22VTI4xzEnZQiq2gXgTdI1GOVWuVDxoeW+G5we0TYyuiapg+oVeW3RUYqyLO27b+woQCPdHI5639Nn5NsmkjEDglL2GosK926/Jp3FwJDDAFvyKMnIHybxggAEkLM3nqB8ooEUaoDAauLq5lmyVPh0QIWHHaXOz7d8SY6YZAHe/BJVcvyjJHuaG0JAKkn6nwFdZUbWGb6taYvohy3dC79/Fga5LyDdn/l29+IYzCp9yFqbXXFozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjSnWxigMrJ9sMkSrTVwHsgc++yae5I6Rr0sDZ4BS8s=;
 b=fLPYN5xFyDLwPyJBgir4KSe6AIRDVO4KyfRYoKMascq/rpXA+0JJfKdwtFBWMCnLI80YUZ+wRhK5aHYyzqNYef+2TX4XQ6z0/W8NMmA6egLkTZ0gY0SZnr6qWJYtCECQmPj8c9rBc3QJrh/YY1NZVKvtNr1f/iC90H+glxhkmlU=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYWPR01MB8676.jpnprd01.prod.outlook.com (2603:1096:400:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 17:33:43 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 17:33:43 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
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
Subject: RE: [PATCH v2 4/4] power: reset: Add new driver for RZ/V2M PWC
 poweroff
Thread-Topic: [PATCH v2 4/4] power: reset: Add new driver for RZ/V2M PWC
 poweroff
Thread-Index: AQHZFYCV5NSzFEQ8qkubGaRjrZRhrK6MbxOAgAO9ZaA=
Date:   Thu, 5 Jan 2023 17:33:43 +0000
Message-ID: <TYWPR01MB87751FA389AD31380F625501C2FA9@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221221210917.458537-1-fabrizio.castro.jz@renesas.com>
 <20221221210917.458537-5-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUv41kssEnat9PFTcb11sYCP3_9p=5hQFAVRqRa-G7gSg@mail.gmail.com>
In-Reply-To: <CAMuHMdUv41kssEnat9PFTcb11sYCP3_9p=5hQFAVRqRa-G7gSg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYWPR01MB8676:EE_
x-ms-office365-filtering-correlation-id: 776a47f7-bf57-4913-5bfd-08daef42fe26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 13mOER1LR3448oDLTMSmLFCJhvFXlO+9IOyk1xsg3hoANklIgvI1J3zRNlU8YzEwPV8KcFD/uY8r+sX7qDK4n66Fl+WCtYGDYo34Qo0lgqalkZVv6bQCPy04IShhmPmJ8U7YD3Byraq+rOZOX1ABv159uBSaF4A5++mcuoX63UntTVO55kY09wetjVIzWja+NzDDBRg4d2EsWo2PRflgwzsHALPirgi8v4sdNyZZ1DxGfKwSM/ebuyUxSQRyZJ8ysXD/KyE75umGBJJ2+zuo2MJ9PWJxlgY4ARzmb0NOEMUxc95fXbhoFHuD7hIHhhtXcMfJGxsQtwjaqwhElhq9XCyDeMmpnMrCCJ4ounHZuyp6Zp9/BFgkg3sA29W7iLYoBag4M4C6OOSmJF1hFKA5Mv0lcfz+oVDoVevdAtO2szI7BgLt44DrpeiQqzpIoIRr9oT7VVV304eukCaTRTxHpYWe14ToP8S4rBJUSogpM3LHi9PY4Zv++aGpzmCuZDhR927c4HKz/9XFILvOy2F3oIKGsCqIxIZUijLlj+nOTm0kXFJkRIBOtDkmLiNAIdsGZvebBT0xDDp8PLgK5QD7fdnYxgI3TgJNdKH2Fjzt5LBz0/Xzucnh6cciOSk3YJ5oMRroq9VFbuh7OVAnX5T9STr2CY8+dNkN7GOb2c7TE4LxQ1TB7z2J6gc75vTdcdP6hEm0dXQyKA5EaGU2/6mNUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(38100700002)(8936002)(7696005)(6506007)(76116006)(122000001)(54906003)(71200400001)(33656002)(86362001)(52536014)(26005)(186003)(9686003)(55016003)(38070700005)(478600001)(6916009)(316002)(53546011)(2906002)(41300700001)(7416002)(66946007)(5660300002)(64756008)(8676002)(4326008)(66556008)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXNDTXZOZkp2T0tiNGUySjM1a2JYR1k0ckdOY1VyQnlIK0ZWdXhLSG1OSnZn?=
 =?utf-8?B?bjZKTFdyeGNHNVpsTWVsQ1JEVERma29QV1NtQ3Z1MytLNWtPVWl5RzArSHUz?=
 =?utf-8?B?bEZheGVxRTBLT3JNT2ZVTGgzcFNFWWxoaTFWa0NMWVZNaDJyYk9TRGQ0T3Nn?=
 =?utf-8?B?WnFubEViUFB0Z2QxVFd3STl5amY3bGk2cXhtSlV4WTNGV1ZzekMwZkQvcHU4?=
 =?utf-8?B?YkxIcWhpbnJNNTd1Z0o4NUpFd1ZQVFA5WWQrbitZU0p1TmhIQnlWckR5RUZx?=
 =?utf-8?B?V2Zub01xcEQ5VzdvcGJKNVpOS0wvdWlOWUFLZk8zWTU1SUsrQU9hZk1uVjJY?=
 =?utf-8?B?alprQWRqTEFQU1o3bEhBSnNaajc0NUtMYkJrS1dZOXpHK3N3TVp4R2tCM2Zm?=
 =?utf-8?B?NVhyVWNSemw1RUhiZnp3YytKU3I3c2JzREdHUElIRTJBUEVCV3g1YkJaenFC?=
 =?utf-8?B?RUZ2UHg3VjJBdUN6ZWpRak14aDdodGd6YjhBL2VscjFlREZCK05TUFJWekMz?=
 =?utf-8?B?Q2d0bzlFYU5pT3cyUEpjNTVHODB3TWtLMTBDNEJpcVQxRjdNTHVpTVdIZElr?=
 =?utf-8?B?VkhnaTdDWjhobkhqUXd6OGxkNzNwelFoV0xHalZtQTQ5VmFVMGdsYnpYYTJn?=
 =?utf-8?B?MVFJdlNNbjgyZzZQL0w3M1RpMXBQRHRvM1VVcUg3aE0rRmVFL1B2cEFURzVv?=
 =?utf-8?B?ODVQOVhVM1R2cWtLQ1pnZjFlRkNVdEpKRU9aYkppVDU1dDVmb1lDUTJmTGVX?=
 =?utf-8?B?U0pRYWZsdVhaN1VNMTc5RnowMnR1czFJbXhjZFg2dkFucjY1dWVZeVFoVU5i?=
 =?utf-8?B?UDJpUFZNdm55enk2ZDBaUjRQNVJtY0pwT2Jvb1VRRWJ0eTJ1NjgxZjAxM215?=
 =?utf-8?B?dFdjVml2ZUM3VDBJaVkwZTUxelZqcmRwdXUzQVoxOWU3RG1mMVU3WUZCMjRm?=
 =?utf-8?B?TjdYNFhEQ1BBWkUyUHQ5MENNaHI2VXRVclJqRkxybzVSUk4vdEZwSy9GcTZy?=
 =?utf-8?B?bmRPUitaTkdHQjQyRTB4Q3ZnUlordjhqR0lEVTJwSmszOVN1UWgzZDZtWlBH?=
 =?utf-8?B?MDV5ODRhQVpYakVBT0ZSYVRXdXh3b3liRlJVNDdGdm1NVUhqSXdNbWdPTEov?=
 =?utf-8?B?QkdCZjl3NndEMVg2SXVBTjBNZUY1Y3oxMHR2aFU1aDUvWjd6MkNCcHhmcmMw?=
 =?utf-8?B?NkV0K2NmYWNuWDBoMi9EaEdSQWpiMVpEM3YwMjJhbFkvVDZDbHRYbHBWbVB4?=
 =?utf-8?B?MDJMa3c1MHAvVHpseWs1a0h4KysyOVdsRmdGemxnL3MwR3c4ZHprUk1EVVB1?=
 =?utf-8?B?Y21YanM1Y2x0ZDRhMlFwSXYvRFNuVzQ3U3ByUHM0blhFSTB5Q2FubmYwNjUx?=
 =?utf-8?B?Q2Q2ckJNNGdCTHlPQ2FlQml0OGtMUmxqWnNXbGh4UTlXeUN0MnpDK3JPRThV?=
 =?utf-8?B?aGhiRk1pTDJDL1NEek8xSy9MVm5aYm9iak4xZlFaeGVmL2lwM0FzY1M5ckZZ?=
 =?utf-8?B?NDFPZFJhbkhGeFBlSXFUSS9NRHlYVDMveXI1R3IyZWNqM0tEeVh3V3V2bmR3?=
 =?utf-8?B?b0grSURaWm54Q2UwQWVIMWJHcjhOL1B4TU5LWldWMDBZbUNvWk85QTdpWGI2?=
 =?utf-8?B?K1RUcURtckhURFZKazRqYVVwakVsbDRYaW1kUk9Hd3RnTlhqWGt3a2NaVVJG?=
 =?utf-8?B?ZCt4STZWeTVxSGl3Umt5dkx2MlZXVlpDbEtWaVY0OE5HVUtubVJFUVhMSlB6?=
 =?utf-8?B?eHhRWnlFS1NsazArOW93dFd4RExjdUFyNTYyRmM0ZVBHbWc5WVVmL3VLTlgz?=
 =?utf-8?B?VDJ1c1BDMnBoMjhIbVBFRkhCQmk5VUNCNVpUa0NuV2d3MU5tcG41SWMreUdx?=
 =?utf-8?B?ckNoNWRGblprMlhONWFaOVlVVzJUR3dCQlhyTWhTVDRNa3JnbDZBMS9KQ2M3?=
 =?utf-8?B?eVQ1cUVoKytyYmlWV0V1OGU0VUF1ZVpicVNnSWIxQm5Yd2lUekdqWTVCT3Uz?=
 =?utf-8?B?MHp3cTh5aFBVVGVWWEo0cXhxQUdybjZPZERxSG5MWSt3YlltaCtld25nSGI4?=
 =?utf-8?B?K2trb1plVmMxemxWRDZmY2VTalBsRVl6NGJycGZsR094M3FnSzRVVTRtU2tC?=
 =?utf-8?B?T1VqN3pEYW9hRStRZ051NXgxWDhMaU1OZTk3ZHNybW0wQ1F5bGd3S1dsUVRX?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776a47f7-bf57-4913-5bfd-08daef42fe26
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 17:33:43.6528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J5mVmbChe2o2IehbVbRJ8HhSuggZbw025hGRKlVSB9aV4p+HIvXr0F9qUiYqoZkTA9J5DPZ0vMmodzP+yoBPsSKFB8Kw+c2KROhKMzDGrgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8676
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjayENCg0KPiANCj4gSGkgRmFicml6
aW8sDQo+IA0KPiBPbiBXZWQsIERlYyAyMSwgMjAyMiBhdCAxMDowOSBQTSBGYWJyaXppbyBDYXN0
cm8NCj4gPGZhYnJpemlvLmNhc3Ryby5qekByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gVGhlIFJa
L1YyTSBQV0MgSVAgY29udHJvbHMgZXh0ZXJuYWwgcG93ZXIgc3VwcGxpZXMgYW5kIHRoZXJlZm9y
ZQ0KPiA+IGNhbiB0dXJuIHRoZSBwb3dlciBzdXBwbGllcyBvZmYgd2hlbiBwb3dlcmluZyBkb3du
IHRoZSBzeXN0ZW0uDQo+ID4NCj4gPiBBZGQgZHJpdmVyIHRvIHBvd2Vyb2ZmIHRoZSBzeXN0ZW0u
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBGYWJyaXppbyBDYXN0cm8gPGZhYnJpemlvLmNhc3Ry
by5qekByZW5lc2FzLmNvbT4NCj4gPiAtLS0NCj4gPg0KPiA+IHYxLT52MjogRHJvcHBlZCBPRiBt
YXRjaCB0YWJsZSBhbmQgc3lzY29uIGFzIGEgcmVzdWx0IG9mIHRoZSBjaGFuZ2UgaW4NCj4gPiAg
ICAgICAgIERUIG1vZGVsDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiA+IC0t
LSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL3Bvd2VyL3Jlc2V0L3J6djJtLXB3Yy1wb3dl
cm9mZi5jDQo+ID4gQEAgLTAsMCArMSw2NyBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMC1vbmx5DQo+ID4gKy8qDQo+ID4gKyAqIENvcHlyaWdodCAoQykgMjAyMiBS
ZW5lc2FzIEVsZWN0cm9uaWNzIENvcnBvcmF0aW9uDQo+ID4gKyAqDQo+ID4gKyAqIFJlc2V0IGRy
aXZlciBmb3IgUmVuZXNhcyBSWi9WMk0gRXh0ZXJuYWwgUG93ZXIgU2VxdWVuY2UgQ29udHJvbGxl
cg0KPiAoUFdDKQ0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9kZWxheS5o
Pg0KPiA+ICsjaW5jbHVkZSA8bGludXgvaW8uaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3BsYXRm
b3JtX2RldmljZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcmVib290Lmg+DQo+ID4gKyNpbmNs
dWRlICIuLi8uLi9tZmQvcnp2Mm0tcHdjLmgiDQo+ID4gKw0KPiA+ICsjZGVmaW5lIFBXQ19QV0NS
U1RfUlNUU09GVEFYICAgICAgICAgICAweDENCj4gPiArI2RlZmluZSBQV0NfUFdDQ0tFTl9FTkdD
S01BSU4gICAgICAgICAgMHgxDQo+ID4gKyNkZWZpbmUgUFdDX1BXQ0NUTF9QV09GRiAgICAgICAg
ICAgICAgIDB4MQ0KPiA+ICsNCj4gPiArc3RydWN0IHJ6djJtX3B3Y19wb3dlcm9mZl9wcml2IHsN
Cj4gPiArICAgICAgIHZvaWQgX19pb21lbSAqYmFzZTsNCj4gPiArICAgICAgIHN0cnVjdCBkZXZp
Y2UgKmRldjsNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgcnp2Mm1fcHdjX3Bvd2Vy
b2ZmKHN0cnVjdCBzeXNfb2ZmX2RhdGEgKmRhdGEpDQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVj
dCByenYybV9wd2NfcG93ZXJvZmZfcHJpdiAqcHJpdiA9DQo+ID4gKyAgICAgICAgICAgICAgIChz
dHJ1Y3Qgcnp2Mm1fcHdjX3Bvd2Vyb2ZmX3ByaXYgKilkYXRhLT5jYl9kYXRhOw0KPiANCj4gTm8g
bmVlZCBmb3IgdGhpcyBjYXN0Lg0KDQpUaGFua3MgZm9yIHBvaW50aW5nIHRoaXMgb3V0LiBJJ2xs
IGZpeCB0aGF0IGluIHYzLg0KDQpUaGFua3MsDQpGYWINCg0KPiANCj4gPiArDQo+ID4gKyAgICAg
ICB3cml0ZWwoUFdDX1BXQ1JTVF9SU1RTT0ZUQVgsIHByaXYtPmJhc2UgKyBQV0NfUFdDUlNUKTsN
Cj4gPiArICAgICAgIHdyaXRlbChQV0NfUFdDQ0tFTl9FTkdDS01BSU4sIHByaXYtPmJhc2UgKyBQ
V0NfUFdDQ0tFTik7DQo+ID4gKyAgICAgICB3cml0ZWwoUFdDX1BXQ0NUTF9QV09GRiwgcHJpdi0+
YmFzZSArIFBXQ19QV0NDVEwpOw0KPiA+ICsNCj4gPiArICAgICAgIG1kZWxheSgxNTApOw0KPiA+
ICsNCj4gPiArICAgICAgIGRldl9lcnIocHJpdi0+ZGV2LCAiRmFpbGVkIHRvIHBvd2VyIG9mZiB0
aGUgc3lzdGVtIik7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIE5PVElGWV9ET05FOw0KPiA+
ICt9DQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3Rz
IG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LQ0KPiBtNjhrLm9yZw0KPiANCj4g
SW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBt
eXNlbGYgYSBoYWNrZXIuDQo+IEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3Rz
IEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlDQo+IHRoYXQuDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==
