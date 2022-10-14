Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91BD5FECD2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJNLBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJNLBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:01:20 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A24C1C880B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 04:01:17 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-91-GFLKovP8PUiYyqSFZun4Kw-1; Fri, 14 Oct 2022 12:01:15 +0100
X-MC-Unique: GFLKovP8PUiYyqSFZun4Kw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Fri, 14 Oct
 2022 12:01:13 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Fri, 14 Oct 2022 12:01:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Jason A. Donenfeld'" <Jason@zx2c4.com>,
        Robert Elliott <elliott@hpe.com>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 04/19] crypto: x86/sha - limit FPU preemption
Thread-Topic: [PATCH v2 04/19] crypto: x86/sha - limit FPU preemption
Thread-Index: AQHY3p5YDK4bZkqaZ0OuLicTma4hgK4NuQjg
Date:   Fri, 14 Oct 2022 11:01:12 +0000
Message-ID: <96ed3206ef2a499f9bf95476e21608c0@AcuMS.aculab.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-5-elliott@hpe.com> <Y0deya7WnwS0HMwl@zx2c4.com>
In-Reply-To: <Y0deya7WnwS0HMwl@zx2c4.com>
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

RnJvbTogSmFzb24gQS4gRG9uZW5mZWxkDQo+IFNlbnQ6IDEzIE9jdG9iZXIgMjAyMiAwMTo0Mg0K
Li4uDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2NyeXB0by9zaGExX3Nzc2UzX2dsdWUuYyBi
L2FyY2gveDg2L2NyeXB0by9zaGExX3Nzc2UzX2dsdWUuYw0KPiA+IGluZGV4IDQ0MzQwYTExMzll
MC4uYTlmNTc3OWI0MWNhIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2NyeXB0by9zaGExX3Nz
c2UzX2dsdWUuYw0KPiA+ICsrKyBiL2FyY2gveDg2L2NyeXB0by9zaGExX3Nzc2UzX2dsdWUuYw0K
PiA+IEBAIC0yNiw2ICsyNiw4IEBADQo+ID4gICNpbmNsdWRlIDxjcnlwdG8vc2hhMV9iYXNlLmg+
DQo+ID4gICNpbmNsdWRlIDxhc20vc2ltZC5oPg0KPiA+DQo+ID4gKyNkZWZpbmUgRlBVX0JZVEVT
IDQwOTZVIC8qIGF2b2lkIGtlcm5lbF9mcHVfYmVnaW4vZW5kIHNjaGVkdWxlci9yY3Ugc3RhbGxz
ICovDQo+IA0KPiBEZWNsYXJlIHRoaXMgaW5zaWRlIHRoZSBmdW5jdGlvbiBpdCdzIHVzZWQgYXMg
YW4gdW50eXBlZCBlbnVtLCBhbmQgZ2l2ZQ0KPiBpdCBhIGJldHRlciBuYW1lLCBsaWtlIEJZVEVT
X1BFUl9GUFUuDQoNCklzbid0ICdieXRlcycgdGhlIHdyb25nIHVuaXQgYW55d2F5Pw0KQXQgbGVh
c3QgaXQgb3VnaHQgdG8gYmUgJ2Nsb2Nrcycgc28gaXQgY2FuIGJlIGRpdmlkZWQgYnkgdGhlDQoo
YXBwcm94aW1hdGUpICdjbG9ja3MgcGVyIGJ5dGUnIG9mIHRoZSBhbGdvcml0aG0uDQoNClNvbWV0
aGluZyBsaWtlIGEgY3JjIGlzIGxpa2VseSB0byBiZSBmYXIgZmFzdGVyIHRoYW4gQUVTLg0KDQpD
bGVhcmx5IHRoZSBhY3R1YWwgcmVxdWlyZWQgdW5pdHMgYXJlIG1pY3Jvc2Vjb25kcy4NCkJ1dCBk
ZXBlbmRpbmcgb24gdGhlIGFjdHVhbCBjcHUgZnJlcXVlbmN5IGlzIGEgYml0IGhhcmQuDQpBbmQg
cGVvcGxlIHJ1bm5pbmcgZmFzdGVyIGNwdSBtYXkgd2FudCBsb3dlciBsYXRlbmN5IGFueXdheS4N
ClNvIGEgdHlwaWNhbCBzbG93IGNwdSBmcmVxdWVuY3kgaXMgcHJvYmFibHkgb2suDQoNClRoZSBh
Y3R1YWwgYXJjaGl0ZWN0dXJlIGRlcGVuZGFudCBjb25zdGFudCByZWFsbHkgb3VnaHQNCnRvIGJl
IGRlZmluZWQgd2l0aCBrZXJuZWxfZnB1X2JlZ2luKCkuDQoNCglEYXZpZA0KDQotDQpSZWdpc3Rl
cmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtl
eW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

