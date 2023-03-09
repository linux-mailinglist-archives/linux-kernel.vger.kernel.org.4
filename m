Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F81D6B308B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjCIW0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjCIW0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:26:03 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689BBA72B5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 14:26:02 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-16-mytVSe0nOmGLnDgiSo5IHA-1; Thu, 09 Mar 2023 22:19:46 +0000
X-MC-Unique: mytVSe0nOmGLnDgiSo5IHA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Thu, 9 Mar
 2023 22:19:44 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Thu, 9 Mar 2023 22:19:44 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Walleij' <linus.walleij@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>
Subject: RE: [v5 PATCH 7/7] crypto: stm32 - Save and restore between each
 request
Thread-Topic: [v5 PATCH 7/7] crypto: stm32 - Save and restore between each
 request
Thread-Index: AQHZUlnVfe29z1dm7kSSXyVRszx6pK7zBGDQ
Date:   Thu, 9 Mar 2023 22:19:44 +0000
Message-ID: <dac62e9452a5417e9de00546d1aae1f4@AcuMS.aculab.com>
References: <E1pZ2fs-000e27-4H@formenos.hmeau.com>
 <CACRpkdY8iN_ga0VuQ-z=8KUWaJ6=5rh2vZEwcp+oNgcBuPFk=g@mail.gmail.com>
 <ZAcNhtm/+mik1N2m@gondor.apana.org.au>
 <CACRpkdbcrCa9v82xVWtixWdDPvCu6E6Rkw-3Vg3APisdvYGwqQ@mail.gmail.com>
 <ZAf/rAbc3bMIwBcr@gondor.apana.org.au> <ZAgDku9htWcetafb@gondor.apana.org.au>
 <CACRpkdZ-zPZG4jK-AF2YF0wUFb8qrKBeoa4feb1qJ9SPusjv+Q@mail.gmail.com>
 <ZAhfBmlNHUpGEwW3@gondor.apana.org.au> <ZAhhGch6TtI8LA6x@gondor.apana.org.au>
 <CACRpkdabjrpsiVgm=EyGrTK7PGXth6FdvxSp=QULA+LyqtdBgg@mail.gmail.com>
 <ZAl1gGCv51FKOXtm@gondor.apana.org.au>
 <CACRpkdY4gAT7RUtL6ctcsqxEX2_rZMyjMktPta7e4UB19OyGow@mail.gmail.com>
In-Reply-To: <CACRpkdY4gAT7RUtL6ctcsqxEX2_rZMyjMktPta7e4UB19OyGow@mail.gmail.com>
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

RnJvbTogTGludXMgV2FsbGVpag0KPiBTZW50OiAwOSBNYXJjaCAyMDIzIDA3OjM1DQouLi4NCj4g
QnV0IGFjdHVhbGx5IEkgdGhpbmsgdGhlIGJ1ZyB3aWxsIG5ldmVyIHRyaWdnZXIsIGJlY2F1c2Ug
dGhlIGRhdGFzaGVldA0KPiBmb3IgdGhlIERCODUwMCAoVXg1MDApIHNheXMgdGhpczoNCj4gDQo+
ICJUaGVuIHRoZSBtZXNzYWdlIGNhbiBiZSBzZW50LCBieSB3cml0aW5nIGl0IHdvcmQgcGVyIHdv
cmQgaW50byB0aGUNCj4gSEFTSF9ESU4gcmVnaXN0ZXIuDQo+IFdoZW4gYSBibG9jayBvZiA1MTIg
Yml0cywgaS5lLiAxNiB3b3JkcyBoYXZlIGJlZW4gd3JpdHRlbiwgYSBwYXJ0aWFsDQo+IGRpZ2Vz
dCBjb21wdXRhdGlvbiB3aWxsDQo+IHN0YXJ0IHVwb24gd3JpdGluZyB0aGUgZmlyc3QgZGF0YSBv
ZiB0aGUgbmV4dCBibG9jay4gVGhlIEFIQiBidXMgd2lsbA0KPiBiZSBidXN5IGZvciA4MiBjeWNs
ZXMgZm9yDQo+IFNIQS0xIGFsZ29yaXRobSAoNjYgY3ljbGVzIGZvciBTSEEtMjU2IGFsZ29yaXRo
bSkuIg0KDQpXaGF0IHNwZWVkIGNsb2NrIGlzIHRoYXQ/DQoNCjQgb3IgNSBleHRyYSBjbG9ja3Mv
d29yZCBtYXkgKG9yIG1heSBub3QpIGJlIHNpZ25pZmljYW50Lg0KDQpJbiB0ZXJtcyBvZiBsYXRl
bmN5IGl0IG1heSBiZSBub2lzZSBjb21wYXJlZCB0byBzb21lIFBDSWUNCnJlYWRzIGRvbmUgYnkg
aGFyZHdhcmUgaW50ZXJydXB0IGhhbmRsZXJzLg0KU29tZSBzbG93IFBDSWUgdGFyZ2V0cyAobGlr
ZSB0aGUgZnBnYSBvbmUgd2UgdXNlKSBwcmV0dHkNCm11Y2ggdGFrZSAxdXMgdG8gaGFuZGxlIGEg
cmVhZCBjeWNsZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

