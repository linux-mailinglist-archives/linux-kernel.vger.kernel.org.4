Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85206B0350
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjCHJod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjCHJoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:44:15 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0D84ECD5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:43:09 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-33-CAryPP8kPFqZSO2VJYhQlQ-1; Wed, 08 Mar 2023 09:42:45 +0000
X-MC-Unique: CAryPP8kPFqZSO2VJYhQlQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Wed, 8 Mar
 2023 09:42:43 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Wed, 8 Mar 2023 09:42:43 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Keguang Zhang' <keguang.zhang@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Subject: RE: [PATCH v2 2/5] gpio: loongson1: Use readl() & writel()
Thread-Topic: [PATCH v2 2/5] gpio: loongson1: Use readl() & writel()
Thread-Index: AQHZUKdVlp3MaV2isEWZMPAiZIsbQK7woloA
Date:   Wed, 8 Mar 2023 09:42:43 +0000
Message-ID: <2d5521ff21ea4b99be3dd2e449f53934@AcuMS.aculab.com>
References: <20230302125215.214014-1-keguang.zhang@gmail.com>
 <20230302125215.214014-3-keguang.zhang@gmail.com>
 <CAMRc=Me3yVwQm8=CmUVM2gyYnFxntW47-OOPdmq1TzXTJB5ETg@mail.gmail.com>
 <CAJhJPsX1q6PGSb+eoCSdCC2_vDtbaShLLzEbuNOqD_Jzd8Ozdw@mail.gmail.com>
In-Reply-To: <CAJhJPsX1q6PGSb+eoCSdCC2_vDtbaShLLzEbuNOqD_Jzd8Ozdw@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogS2VndWFuZyBaaGFuZw0KPiBTZW50OiAwNyBNYXJjaCAyMDIzIDAzOjQ2DQo+IA0KPiBP
biBNb24sIE1hciA2LCAyMDIzIGF0IDU6MzDigK9QTSBCYXJ0b3N6IEdvbGFzemV3c2tpIDxicmds
QGJnZGV2LnBsPiB3cm90ZToNCj4gPg0KPiA+IE9uIFRodSwgTWFyIDIsIDIwMjMgYXQgMTo1MuKA
r1BNIEtlZ3VhbmcgWmhhbmcgPGtlZ3VhbmcuemhhbmdAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+
DQo+ID4gPiBUaGlzIHBhdGNoIHJlcGxhY2UgX19yYXdfcmVhZGwoKSAmIF9fcmF3X3dyaXRlbCgp
IHdpdGggcmVhZGwoKSAmIHdyaXRlbCgpLg0KPiA+ID4NCj4gPg0KPiA+IFBsZWFzZSBzYXkgV0hZ
IHlvdSdyZSBkb2luZyB0aGlzLg0KPiA+DQo+IHJlYWRsICYgd3JpdGVsIGNvbnRhaW4gbWVtb3J5
IGJhcnJpZXJzIHdoaWNoIGNhbiBndWFyYW50ZWUgYWNjZXNzIG9yZGVyLg0KDQpTbyB3aGF0Li4u
DQoNClRoZXJlIGlzIGEgZGF0YSBkZXBlbmRlbmN5IGJldHdlZW4gdGhlIHJlYWQgYW5kIHdyaXRl
Lg0KVGhlIHJlYWQgY2FuJ3QgYmUgc2NoZWR1bGVkIGJlZm9yZSB0aGUgbG9jayBpcyBhY3F1aXJl
ZC4NClRoZSB3cml0ZSBjYW4ndCBiZSBzY2hlZHVsZWQgYWZ0ZXIgdGhlIGxvY2sgaXMgcmVsZWFz
ZWQuDQoNClNvIGFueSBiYXJyaWVycyBpbiByZWFkbCgpL3dyaXRlbCgpIGFyZW4ndCBuZWVkZWQu
DQoNCklmIHRoZXkgYXJlIG9ubHkgY29tcGlsZSBiYXJyaWVycyB0aGV5J2xsIGhhdmUgbm8gcmVh
bCBlZmZlY3QuDQpPVE9IIGlmIHRoZSBjcHUgbmVlZHMgYWN0dWFsIHN5bmNocm9uaXNpbmcgaW5z
dHJ1Y3Rpb25zIChhcyBzb21lDQpwcGMgZG8pIHRoZW4gdGhleSB3aWxsIHNsb3cgdGhpbmdzIGRv
d24uDQoNCglEYXZpZA0KDQo+IA0KPiA+IEJhcnQNCj4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
S2VndWFuZyBaaGFuZyA8a2VndWFuZy56aGFuZ0BnbWFpbC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+
IFYxIC0+IFYyOiBTcGxpdCB0aGlzIGNoYW5nZSB0byBhIHNlcGFyYXRlIHBhdGNoDQo+ID4gPiAt
LS0NCj4gPiA+ICBkcml2ZXJzL2dwaW8vZ3Bpby1sb29uZ3NvbjEuYyB8IDggKysrKy0tLS0NCj4g
PiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+
ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwaW8vZ3Bpby1sb29uZ3NvbjEuYyBiL2Ry
aXZlcnMvZ3Bpby9ncGlvLWxvb25nc29uMS5jDQo+ID4gPiBpbmRleCA4ODYyYzllYTBkNDEuLmI2
YzExY2FhM2FkZSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvZ3Bpby9ncGlvLWxvb25nc29u
MS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2dwaW8vZ3Bpby1sb29uZ3NvbjEuYw0KPiA+ID4gQEAg
LTIzLDggKzIzLDggQEAgc3RhdGljIGludCBsczF4X2dwaW9fcmVxdWVzdChzdHJ1Y3QgZ3Bpb19j
aGlwICpnYywgdW5zaWduZWQgaW50IG9mZnNldCkNCj4gPiA+ICAgICAgICAgdW5zaWduZWQgbG9u
ZyBmbGFnczsNCj4gPiA+DQo+ID4gPiAgICAgICAgIHJhd19zcGluX2xvY2tfaXJxc2F2ZSgmZ2Mt
PmJncGlvX2xvY2ssIGZsYWdzKTsNCj4gPiA+IC0gICAgICAgX19yYXdfd3JpdGVsKF9fcmF3X3Jl
YWRsKGdwaW9fcmVnX2Jhc2UgKyBHUElPX0NGRykgfCBCSVQob2Zmc2V0KSwNCj4gPiA+IC0gICAg
ICAgICAgICAgICAgICAgIGdwaW9fcmVnX2Jhc2UgKyBHUElPX0NGRyk7DQo+ID4gPiArICAgICAg
IHdyaXRlbChyZWFkbChncGlvX3JlZ19iYXNlICsgR1BJT19DRkcpIHwgQklUKG9mZnNldCksDQo+
ID4gPiArICAgICAgICAgICAgICBncGlvX3JlZ19iYXNlICsgR1BJT19DRkcpOw0KPiA+ID4gICAg
ICAgICByYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZ2MtPmJncGlvX2xvY2ssIGZsYWdzKTsN
Cj4gPiA+DQo+ID4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+ID4gQEAgLTM1LDggKzM1LDggQEAg
c3RhdGljIHZvaWQgbHMxeF9ncGlvX2ZyZWUoc3RydWN0IGdwaW9fY2hpcCAqZ2MsIHVuc2lnbmVk
IGludCBvZmZzZXQpDQo+ID4gPiAgICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gPg0K
PiA+ID4gICAgICAgICByYXdfc3Bpbl9sb2NrX2lycXNhdmUoJmdjLT5iZ3Bpb19sb2NrLCBmbGFn
cyk7DQo+ID4gPiAtICAgICAgIF9fcmF3X3dyaXRlbChfX3Jhd19yZWFkbChncGlvX3JlZ19iYXNl
ICsgR1BJT19DRkcpICYgfkJJVChvZmZzZXQpLA0KPiA+ID4gLSAgICAgICAgICAgICAgICAgICAg
Z3Bpb19yZWdfYmFzZSArIEdQSU9fQ0ZHKTsNCj4gPiA+ICsgICAgICAgd3JpdGVsKHJlYWRsKGdw
aW9fcmVnX2Jhc2UgKyBHUElPX0NGRykgJiB+QklUKG9mZnNldCksDQo+ID4gPiArICAgICAgICAg
ICAgICBncGlvX3JlZ19iYXNlICsgR1BJT19DRkcpOw0KPiA+ID4gICAgICAgICByYXdfc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmZ2MtPmJncGlvX2xvY2ssIGZsYWdzKTsNCj4gPiA+ICB9DQo+ID4g
Pg0KPiA+ID4gLS0NCj4gPiA+IDIuMzQuMQ0KPiA+ID4NCj4gDQo+IA0KPiANCj4gLS0NCj4gQmVz
dCByZWdhcmRzLA0KPiANCj4gS2VsdmluIENoZXVuZw0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

