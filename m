Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE12E65A5C1
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 17:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiLaQox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 11:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLaQou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 11:44:50 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F726584
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 08:44:48 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-7-Ol7Icuy6OlKckfPU2enxww-1; Sat, 31 Dec 2022 16:44:46 +0000
X-MC-Unique: Ol7Icuy6OlKckfPU2enxww-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 31 Dec
 2022 16:44:45 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Sat, 31 Dec 2022 16:44:45 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Herbert Xu' <herbert@gondor.apana.org.au>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Anders Roxell <anders.roxell@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        =?utf-8?B?SG9yaWEgR2VhbnTEgw==?= <horia.geanta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        "kernel test robot" <lkp@intel.com>
Subject: RE: [PATCH] crypto: caam - Avoid GCC memset bug warning
Thread-Topic: [PATCH] crypto: caam - Avoid GCC memset bug warning
Thread-Index: AQHZGye3tmYlgJJWpEm0756mILvCfK6INU/Q
Date:   Sat, 31 Dec 2022 16:44:45 +0000
Message-ID: <f3e9add2210a46af99cf0fc79121c7db@AcuMS.aculab.com>
References: <20221222162513.4021928-1-u.kleine-koenig@pengutronix.de>
 <Y6VK4IJkHiawAbJz@gondor.apana.org.au>
 <20221223174719.4n6pmwio4zycj2qm@pengutronix.de>
 <Y6wCbyttJ+WVzmZX@gondor.apana.org.au>
 <20221228113035.ups6echnsmo4flnz@pengutronix.de>
 <Y6zx9H7pZZ6VTzUd@gondor.apana.org.au>
In-Reply-To: <Y6zx9H7pZZ6VTzUd@gondor.apana.org.au>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSGVyYmVydCBYdQ0KPiBTZW50OiAyOSBEZWNlbWJlciAyMDIyIDAxOjQ5DQo+IA0KPiBP
biBXZWQsIERlYyAyOCwgMjAyMiBhdCAxMjozMDozNVBNICswMTAwLCBVd2UgS2xlaW5lLUvDg8K2
bmlnIHdyb3RlOg0KPiA+DQo+ID4gPiAtCWlmIChsZW4pIC8qIGF2b2lkIHNwYXJzZSB3YXJuaW5n
OiBtZW1jcHkgd2l0aCBieXRlIGNvdW50IG9mIDAgKi8NCj4gPiA+ICsJLyogQXZvaWQgZ2NjIHdh
cm5pbmc6IG1lbWNweSB3aXRoIGRhdGEgPT0gTlVMTCAqLw0KPiA+ID4gKwlpZiAoIUlTX0VOQUJM
RUQoQ09ORklHX0NSWVBUT19ERVZfRlNMX0NBQU1fREVCVUcpIHx8IGRhdGEpDQo+ID4NCj4gPiBJ
IGp1c3QgdHJpZWQ6IEZvciBtZSBhIHBsYWluDQo+ID4NCj4gPiAJaWYgKGRhdGEpDQo+ID4NCj4g
PiBpcyBhbHNvIGVub3VnaCB0byBtYWtlIGJvdGggZ2NjIGFuZCBzcGFyc2UgaGFwcHkuDQo+IA0K
PiBPZiBjb3Vyc2UgaXQgaXMuICBUaGUgcG9pbnQgb2YgdGhlIGV4dHJhIGNvbmRpdGlvbiBpcyB0
byByZW1vdmUNCj4gdGhlIHVubmVjZXNzYXJ5IGNoZWNrIG9uIGRhdGEgdW5sZXNzIHdlIGFyZSBp
biBkZWJ1Z2dpbmcgbW9kZQ0KPiAoYXMgaXQgaXMgb25seSBuZWVkZWQgaW4gZGVidWdnaW5nIG1v
ZGUgdG8gd29yayBhcm91bmQgdGhlIGJ1Z2d5DQo+IGNvbXBpbGVyKS4NCg0KSUlSQyB0aGUgJ3By
b2JsZW1hdGljJyBjYXNlIGlzIG9uZSB3aGVyZSAnbGVuJyBhbmQgJ2RhdGEnDQphcmUgYWN0dWFs
bHkgY29tcGlsZS10aW1lIHplcm9zIC0gaW4gd2hpY2ggY2FzZSB5b3UgZG9uJ3QNCndhbnQgdG8g
Y2FsbCBtZW1jcHkoKSBhdCBhbGwuDQpJbiBhbGwgb3RoZXIgY2FzZXMgSSB0aGluayB0aGVyZSBp
cyBzb21ldGhpbmcgdG8gY29weSBzbyB5b3UNCmRvbid0IHJlYWxseSB3YW50IHRoZSBjaGVjayAo
b3IgdGhlIG9uZSBpbiBtZW1jcHkoKSB3aWxsIGRvKS4NCg0KV2hldGhlciAoYnVpbHRpbl9jb25z
dGFudF9wKGRhdGEpICYmICFkYXRhKSBpcyBnb29kIGVub3VnaCBpcw0KYW5vdGhlciBtYXR0ZXIu
DQpJdCBtaWdodCBuZWVkIHRoZSAoc2l6ZW9mICooMSA/ICh2b2lkICopKGRhdGEpIDogKGludCAq
KTApID09IDEpDQp0ZXN0Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

