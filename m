Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5B5625552
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbiKKIa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiKKIaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:30:52 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazolkn19012038.outbound.protection.outlook.com [52.103.11.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687C07B23C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:30:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeLdWix83QRypx8thBE0h6KZxgvCS4zWfNQ80m0Vgrh+xvkfymh1xwg8r4nf3c5CWsNx8wbFz3EJYl4ZGzOPwPPMfHKVne1nFBx20pTpOOIGn+oG6aGpXMH0IF8dMvr+w6vMLoeilDpheJaIks7oGwxOhseyKortXSVJ2WhL9SYdTPk0WzUfAYLXj3JNSaUyIx4gqBOoZucOTHKl8knPNu1eSwpcNsoe+VgPsaDWvKGH+/FUcXNEnzMH/G+W5JyrZpqXCqXPxE7P8lLeero6zA+AZlnjruUtV5dp+/a1MGtnrokWDu04G4fTzQcJK2ztO9R1pD97hvn0r3Q2ksuo7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+LzC7pSlzQ4sCW2bRqdurHRWbSBVXgCvE6kGrWwSXQ=;
 b=ZySV93K03uJvAwJotOls7aPDi16FO560HFxAdFQDQ53WtLODDLBAv7fVhjm/6NTcmJhnqb9I8SE83nhJfhuPq8mtlxIA4O0dU+RcbrzMnL7fhY4chYBL+NUjF/O8ys58BhryBSbe01vVexz+typfSuexFsc1z/dF6GYDVa2+ccnSicSfZIeP6tLeVRlNX8ofI2CAmJaDMylJhMuYkDyjYz4Pe+BmHfc7UFXXf3U5wicznHEPKilSh+j+CAlgkHnuL76CteB6n+xAPss4T4CQcOBnTTRkdfvZdPtSVdqRnhF7FePkt59JEfKesX9p6GT1NexU4x1BNA6UBrJMn5FJgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DS0PR05MB9544.namprd05.prod.outlook.com (2603:10b6:8:11f::15)
 by SJ0PR05MB8518.namprd05.prod.outlook.com (2603:10b6:a03:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Fri, 11 Nov
 2022 08:30:47 +0000
Received: from DS0PR05MB9544.namprd05.prod.outlook.com
 ([fe80::33e4:cb6f:e54a:778f]) by DS0PR05MB9544.namprd05.prod.outlook.com
 ([fe80::33e4:cb6f:e54a:778f%4]) with mapi id 15.20.5791.020; Fri, 11 Nov 2022
 08:30:47 +0000
From:   Soha Jin <soha@lohu.info>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wende Tan <twd2.me@gmail.com>
Subject: RE: [PATCH v2] platform: use fwnode_irq_get_byname instead of
 of_irq_get_byname to get irq
Thread-Topic: [PATCH v2] platform: use fwnode_irq_get_byname instead of
 of_irq_get_byname to get irq
Thread-Index: AQJW0/kaaJVFezSz0P9aVK3IkiqSVK09pPAA
Sender: Soha Jin <soha@live.cn>
Date:   Fri, 11 Nov 2022 08:30:46 +0000
Message-ID: <DS0PR05MB95440932459F31AA76618A75DA009@DS0PR05MB9544.namprd05.prod.outlook.com>
References: <20221028164120.2798-1-soha@lohu.info>
In-Reply-To: <20221028164120.2798-1-soha@lohu.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 2
x-tmn:  [gYb8kVloOvRePrUNsJRbqaXlloeAl1zqHq0+4cSUlv9zVbEq/xVivoFTknBCd5Jp]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR05MB9544:EE_|SJ0PR05MB8518:EE_
x-ms-office365-filtering-correlation-id: 8bddf18f-df98-47ee-7416-08dac3bf083e
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vng9ju5JVDxZcYApoVeyLqTUC+CCvw3bM844C4aiBFuBYg9oZtvJK6pfxBQtfRcGH344PE1FvALq0/qDf3mxfpYPN430sT237enfkmlYyLxU3kdJuGCmRa+8+RokQ67Lh3HS4o2MYNnZ43hNYrugdnRBgObw8UK+FTXKjvDBiQFUisLaf9MZOHzEC+AF0N0JtC8FPBEj/3s+ZYY4ritNnp/UZ0M0X2eHa/+c9XcC6zHKmbcekHVlhUwNKFLqyEJ8OPiijnl7m8rCKXVCHAClwL7/Qqih8XUiW2Wu6saDeLntYdMQ1hgePjGjNCaM9hUry5gmpavmKIc1xYej763GTIu/cZckYFzUJJ+4XYs+4ZPhSHQEZCTlJkFDzbh1UgpRF6N4xys13CL/kVk6i8NoTZGKpG0KI08WnT6DpF6KRDe98D1hUxIUoc1ryQcNHJKHzahJDrjEDBiVVqELfzARtT+vX0TLcyyjatZjAOI26jjS7ntypRkryKZmeRvPjLYB2gFnhxiP619sW7PF3yx6N0/5eO5nIWMHlbWHcyToM61ix+hSJybbTfmLuBuzJQ7Rw8XW4Sm6gg0qfdJ2wjstJIZIkHSG+sgqJnHCS8G1JGOHc6FrHajbA+XPNSM1WZhn99TMBcim4e0MnGUg48qpgqPoTfMjDep3wGjamesvCuekZ2S2V2+lsvCJsLOKHGI0
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlN3ZTVqK3dCTUQxZWViVm1RcmZnYnVRdHIvcGFzSFROMUhpUWt3MVBqZkcx?=
 =?utf-8?B?QmJQMGdDbk10ZUQ3bGFhVlhHaHFtajRGNXd3c2poU2x4NDl1UzNRVUh4dmxs?=
 =?utf-8?B?amhNcDhrUURLQVJRUTZmWnBjSjNQMFlydVdIN3pURjIzazdBSFFFZThabWNM?=
 =?utf-8?B?RWxUU1VIZk4zU3YwSEMxdTIwc0pPclBXMzc4TWc2dG9XeWdOOFdZZ2dxK1NF?=
 =?utf-8?B?aHJieUV0QlJTS3djdURFcUpvTTNnZ3VOUTg3UjF6V3dxUVI1SjBRQTZEWnBt?=
 =?utf-8?B?dEVKWExGSVFvdTFsenhuR1VzMlZqaGJidWs5VHIvSHpCSE16N3ZVc3dNelps?=
 =?utf-8?B?VGkwNTY1VzQrdHRiZUpPbllqYk81REtSQnBOQUpxbXdLZUh2bGJYODcvRldV?=
 =?utf-8?B?Y1BITDBoN09Pbno4K3Q2a1l4WDllT096ZThiM1ZrWit4M3BIWWMxQ3JzNk1h?=
 =?utf-8?B?NnNMb21oMnB3N2sraEJvZnB3ZHcxMzlBVGVVRXh3MkYzTmx6WjFJNFJRcHhO?=
 =?utf-8?B?ZVFuNG14U1RVWlQ0QlNsSVM3aE9wMzBPeit0bm1TNUVwNkNhMjF0SHEwNnRF?=
 =?utf-8?B?WFRqRjQxcFdwNDNiWjdoKzVPalpVZ3lWRkMzcDRDaGQ2SEtxTEZiMC9qZW9D?=
 =?utf-8?B?M3d3akp3eDk4WDhXR2RqSk9FRFUzVDlCOVk3YVBpNlM0NWZONXRJRFFPY0VS?=
 =?utf-8?B?QjQxYW5pMnk2RjNGRmNMV2hoYlllZXprYVQxM0QvRmxWTG1RanZxbGNaalh5?=
 =?utf-8?B?eGt5RnA5bWJJWmZpc2xXeExzM3U0R3lSYkI4MVo0N3lCOVBSTVRMQnFjWkMx?=
 =?utf-8?B?UlRPQnBYc3AzY2N2MFVsV3Z1YjdmZGphbHZDUlBscCtMeURpTitqTUFzYVpn?=
 =?utf-8?B?MFRvSG1sSXNqWkREZjVxVGZlMmJUYm5BbURIeUpsMmw2RTl1S1pQeFZQYngx?=
 =?utf-8?B?QWpxWG9iZkJmK0poMFRuVFdYdlAycFNhRU03RGg0ZEhnYUdVNUgrSEwwVi9C?=
 =?utf-8?B?VjFJZ01iVWNmNW1NUVR1SC9kNDcxNHQyQUNrMkNua0RyeU11M3R1em9BOUZ5?=
 =?utf-8?B?WjFDNGVWNjFuRXZINW1pbzh2c1ZPRlVCVHplZ0hSTDJOdXk1UmVTTyt4VSs4?=
 =?utf-8?B?cnVCNk9jUFhYUm1BbWllZTI2SnVkRG9hdm5La1ljTFNLK0IyOVVJdVVGUjd1?=
 =?utf-8?B?TTBIRHVENGhoK2p0SDJtRE5ON2piaFU4em1GRTJVWmYybHdmV2NPWnpieGQ0?=
 =?utf-8?B?aFBDUE1CR2V0UmVZK3A2d3ZvV0VVNU92TjdhK3pCb0NLT2I2ZzJSakZkZTl6?=
 =?utf-8?B?VVJUNVptT3llVGNsYlVnTVhJMUVteC9lMVRSSWxqbllOZHJXSERGdERsVE9N?=
 =?utf-8?B?cFZEM0E0VXYwT0lrbjVHZU9pR3JCR0tKWWhSNi96TnAyREFhaHhRUG4xRytQ?=
 =?utf-8?B?NEswMFNIWVF1VTlObVdTbnpWZDd2QWt1VUxXM0F5WHZJY0JKUGYvcWZWVk50?=
 =?utf-8?B?WEJQdHllN1NXcEdqVHNYQzcwbjk5dHJ1RytWdi9VbmF6Qk1hNnJKTVFqeUlo?=
 =?utf-8?B?WnRpZmcwTTdZYU9yMnpUZ0hpNE1TV1JQZk1CZGVKM0hWVkNoT2VRc1pCOWdi?=
 =?utf-8?B?TlMrMjJ6Y2NSZUNLaFBmdUhMOFpsb3p5VHNTTW5KU0kzU1FVTVV4T2VETlYw?=
 =?utf-8?B?UWlPT01yQWhVdmFtankrN0lDL0xTZ2craXdVRWh5WnZJN2NzRFZFK1RBd3RO?=
 =?utf-8?Q?x4STrlxLerdCUqpqvI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR05MB9544.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bddf18f-df98-47ee-7416-08dac3bf083e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 08:30:47.0201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB8518
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTb2hhIEppbiA8c29oYUBsb2h1
LmluZm8+DQo+IFNlbnQ6IFNhdHVyZGF5LCBPY3RvYmVyIDI5LCAyMDIyIDEyOjQxIEFNDQo+IA0K
PiBOb3Qgb25seSBwbGF0Zm9ybSBkZXZpY2VzIGRlc2NyaWJlZCBieSBPRiBoYXZlIG5hbWVkIGlu
dGVycnVwdHMsIGJ1dA0KPiBkZXZpY2VzIGRlc2NyaWJlZCBieSBBQ1BJIGFsc28gaGF2ZSBuYW1l
ZCBpbnRlcnJ1cHRzLiBUaGUgZndub2RlIGlzIGFuDQo+IGFic3RyYWN0aW9uIHRvIGRpZmZlcmVu
dCBzdGFuZGFyZHMsIGFuZCB1c2luZyBmd25vZGVfaXJxX2dldF9ieW5hbWUgY2FuDQo+IHN1cHBv
cnQgbW9yZSBkZXZpY2VzLg0KPiANCj4gTW9yZW92ZXIsIHdoZW4gQ09ORklHX09GX0lSUSBpcyBu
b3QgZW5hYmxlZCwgdGhlcmUgd2lsbCBiZSBhIHN0dWIgbWV0aG9kDQo+IGFsd2F5cyByZXR1cm5p
bmcgMCwgdGhlIGlmIHN0YXRlbWVudCBjYW4gYmUgcmVtb3ZlZCBzYWZlbHkuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBTb2hhIEppbiA8c29oYUBsb2h1LmluZm8+DQo+IFRlc3RlZC1ieTogV2VuZGUg
VGFuIDx0d2QyLm1lQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2Jhc2UvcGxhdGZvcm0u
YyB8IDggKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDUgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9iYXNlL3BsYXRmb3JtLmMgYi9k
cml2ZXJzL2Jhc2UvcGxhdGZvcm0uYyBpbmRleA0KPiA1MWJiMjI4OTg2NWMuLjZjZDdmZDQ3OGM1
ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9iYXNlL3BsYXRmb3JtLmMNCj4gKysrIGIvZHJpdmVy
cy9iYXNlL3BsYXRmb3JtLmMNCj4gQEAgLTQ0MSwxMSArNDQxLDkgQEAgc3RhdGljIGludCBfX3Bs
YXRmb3JtX2dldF9pcnFfYnluYW1lKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKmRldiwNCj4g
IAlzdHJ1Y3QgcmVzb3VyY2UgKnI7DQo+ICAJaW50IHJldDsNCj4gDQo+IC0JaWYgKElTX0VOQUJM
RUQoQ09ORklHX09GX0lSUSkgJiYgZGV2LT5kZXYub2Zfbm9kZSkgew0KPiAtCQlyZXQgPSBvZl9p
cnFfZ2V0X2J5bmFtZShkZXYtPmRldi5vZl9ub2RlLCBuYW1lKTsNCj4gLQkJaWYgKHJldCA+IDAg
fHwgcmV0ID09IC1FUFJPQkVfREVGRVIpDQo+IC0JCQlyZXR1cm4gcmV0Ow0KPiAtCX0NCj4gKwly
ZXQgPSBmd25vZGVfaXJxX2dldF9ieW5hbWUoZGV2X2Z3bm9kZSgmZGV2LT5kZXYpLCBuYW1lKTsN
Cj4gKwlpZiAocmV0ID4gMCB8fCByZXQgPT0gLUVQUk9CRV9ERUZFUikNCj4gKwkJcmV0dXJuIHJl
dDsNCj4gDQo+ICAJciA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZV9ieW5hbWUoZGV2LCBJT1JFU09V
UkNFX0lSUSwgbmFtZSk7DQo+ICAJaWYgKHIpIHsNCj4gLS0NCj4gMi4zMC4yDQo+IA0KDQpIZWxs
byBHcmVnLA0KDQpJIG5vdGljZWQgdGhlIG9yaWdpbmFsIHBhdGNoIGlzIG1lcmdlZCBpbnRvIC1u
ZXh0IGJyYW5jaCwgYnV0IGFzIEkgc2FpZCBpbg0KdGhlIG1haWwgeWVzdGVyZGF5IChtYXliZSB5
b3UgZGlkIG5vdCBzZWUgaXQpLCBJIGFscmVhZHkgY29tcG9zZWQgYSB2Mg0KcGF0Y2ggMiB3ZWVr
cyBhZ28uIEV4Y2VwdCB0aGUgZm9ybWF0dGluZyBmaXgsIHRoaXMgcGF0Y2ggYWxzbyByZW1vdmVk
IGENCnVzZWxlc3MgaWYtYnJhbmNoLg0KDQpBcmUgdGhlcmUgYW55IGNoYW5jZSB0byBjb3JyZWN0
IHRoaXMgbWlzdGFrZT8NCg0KUmVnYXJkcywNClNvaGENCg0K
