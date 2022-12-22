Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CC9653E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbiLVK3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbiLVK3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:29:46 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8577C1A214;
        Thu, 22 Dec 2022 02:29:43 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 4C1D024E347;
        Thu, 22 Dec 2022 18:29:42 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 22 Dec
 2022 18:29:42 +0800
Received: from EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4]) by
 EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4%16]) with mapi id
 15.00.1497.044; Thu, 22 Dec 2022 18:29:42 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 2/3] hwrng: starfive - Add TRNG driver for StarFive SoC
Thread-Topic: [PATCH 2/3] hwrng: starfive - Add TRNG driver for StarFive SoC
Thread-Index: AQHZFRwx15kE4gLKu0uxN2CW96B+Oa53kqwAgAIT3RD//3zVgIAAklKA
Date:   Thu, 22 Dec 2022 10:29:41 +0000
Message-ID: <2684abf708f145f4b49ec1680c1ddb87@EXMBX168.cuchost.com>
References: <20221221090819.1259443-1-jiajie.ho@starfivetech.com>
 <20221221090819.1259443-3-jiajie.ho@starfivetech.com>
 <05aaa9f8-7a97-51c9-e18a-1c3753f2006b@linaro.org>
 <69dca1be673a40729d750c00d927b437@EXMBX168.cuchost.com>
 <27f1c084-60b4-daeb-0ffe-c0500aecbd49@linaro.org>
In-Reply-To: <27f1c084-60b4-daeb-0ffe-c0500aecbd49@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [161.142.229.243]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwg
RGVjZW1iZXIgMjIsIDIwMjIgNTo0NCBQTQ0KPiBUbzogSmlhSmllIEhvIDxqaWFqaWUuaG9Ac3Rh
cmZpdmV0ZWNoLmNvbT47IE9saXZpYSBNYWNrYWxsDQo+IDxvbGl2aWFAc2VsZW5pYy5jb20+OyBI
ZXJiZXJ0IFh1IDxoZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU+OyBSb2INCj4gSGVycmluZyA8
cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6eXN6dG9mLmtv
emxvd3NraStkdEBsaW5hcm8ub3JnPg0KPiBDYzogRW1pbCBSZW5uZXIgQmVydGhpbmcgPGtlcm5l
bEBlc21pbC5kaz47IENvbm9yIERvb2xleQ0KPiA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+
OyBsaW51eC1jcnlwdG9Admdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHJpc2N2QGxpc3Rz
LmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzNdIGh3cm5nOiBzdGFyZml2
ZSAtIEFkZCBUUk5HIGRyaXZlciBmb3IgU3RhckZpdmUgU29DDQo+IA0KPiA+IEhvdyBkbyBJIHBy
b3Blcmx5IGhhbmRsZSBfX21heWJlX3VudXNlZCBmdW5jdGlvbnMgaW4gdGhpcyBzY2VuYXJpbz8N
Cj4gDQo+IFRoZSBzYW1lIGFzIGluIG90aGVyIGZpbGVzLiBVc2UgYGdpdCBncmVwYA0KPiANCj4g
PiBXaWxsIGl0IGhlbHAgaWYgSSBhZGQgI2RlZmluZSBhcyBmb2xsb3dzOg0KPiA+DQo+ID4gI2lm
ZGVmIENPTkZJR19QTQ0KPiA+ICNkZWZpbmUgU1RBUkZJVkVfUk5HX1BNX09QUyAoJnN0YXJmaXZl
X3JuZ19wbV9vcHMpICNlbHNlICNkZWZpbmUNCj4gPiBTVEFSRklWRV9STkdfUE1fT1BTIE5VTEwg
I2VuZGlmDQo+IA0KPiBJIHRhbGtlZCBvbmx5IGFib3V0IG9mX21hdGNoX3B0cigpLiBUaGlzIGlz
IG5vdCBvZl9tYXRjaF9wdHIgYW5kIHNob3VsZCBoYXZlDQo+IGl0cyBvd24gc3ludGF4IChwbV9z
bGVlcF9wdHIgKyBzdGF0aWMgREVGSU5FX1NJTVBMRV9ERVZfUE1fT1BTKQ0KPiANCj4gPg0KPiA+
IHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHN0YXJmaXZlX3RybmdfZHJpdmVyID0gew0K
PiA+ICAgICAgICAgLnByb2JlICA9IHN0YXJmaXZlX3RybmdfcHJvYmUsDQo+ID4gICAgICAgICAu
ZHJpdmVyID0gew0KPiA+ICAgICAgICAgICAgICAgICAubmFtZSAgICAgICAgICAgPSAic3RhcmZp
dmUtdHJuZyIsDQo+ID4gICAgICAgICAgICAgICAgIC5wbSAgICAgICAgICAgICA9IFNUQVJGSVZF
X1JOR19QTV9PUFMsDQo+ID4gICAgICAgICAgICAgICAgIC5vZl9tYXRjaF90YWJsZSA9IG9mX21h
dGNoX3B0cih0cm5nX2R0X2lkcyksDQo+ID4gICAgICAgICB9LA0KPiA+IH07DQo+ID4NCj4gPiBJ
IGRpZCBidWlsZCB0aGUgcGF0Y2hlcyB3aXRoIHRoZSB0b29scyBtZW50aW9uZWQgYnV0IGRpZCBu
b3QgZ2V0IHdhcm5pbmdzLg0KPiA+IERvIEkgbmVlZCBhIHNwZWNpZmljIHZlcnNpb24sIG9yIGhh
dmUgSSBkb25lIHNvbWV0aGluZyB3cm9uZz8NCj4gDQo+IFlvdSBqdXN0IG5lZWQgcHJvcGVyIENP
TVBJTEVfVEVTVCBjb25maWcgd2l0aCBPRiBkaXNhYmxlZC4NCj4gDQoNCkknbGwgdXBkYXRlIHRo
ZSBwYXRjaCBhY2NvcmRpbmdseS4NClRoYW5rcyBhZ2FpbiBmb3IgdGhlIGNvbW1lbnRzIGFuZCBz
dWdnZXN0aW9ucy4NCg0KUmVnYXJkcywNCkppYSBKaWUNCg==
