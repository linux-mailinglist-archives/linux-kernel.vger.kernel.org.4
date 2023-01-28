Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89EE67FB60
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 23:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjA1Wf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 17:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA1WfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 17:35:25 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA63B3A93
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 14:35:23 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-113-5yLzffXWPLWbScFAP9AvvQ-1; Sat, 28 Jan 2023 22:35:20 +0000
X-MC-Unique: 5yLzffXWPLWbScFAP9AvvQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Sat, 28 Jan
 2023 22:35:20 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Sat, 28 Jan 2023 22:35:20 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andy.shevchenko@gmail.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH v1 1/1] lib/string: Use strchr() in strpbrk()
Thread-Topic: [PATCH v1 1/1] lib/string: Use strchr() in strpbrk()
Thread-Index: AQHZMmcwwuoXGWmDc06Jaw4hqxFhbK6z5+FwgABYDACAACoagA==
Date:   Sat, 28 Jan 2023 22:35:19 +0000
Message-ID: <d36a45b689e84ae7b9c1079221e054da@AcuMS.aculab.com>
References: <20230127155135.27153-1-andriy.shevchenko@linux.intel.com>
 <a903947619f94dfa88d3dd147b7a5e95@AcuMS.aculab.com>
 <CAHp75VcZgkuOA3pSrg7cN36EAB4Y0jV2xFNfj-sGp_C17J2yAQ@mail.gmail.com>
In-Reply-To: <CAHp75VcZgkuOA3pSrg7cN36EAB4Y0jV2xFNfj-sGp_C17J2yAQ@mail.gmail.com>
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

RnJvbTogQW5keSBTaGV2Y2hlbmtvDQo+IFNlbnQ6IDI4IEphbnVhcnkgMjAyMyAxOTo1NQ0KPiAN
Cj4gT24gU2F0LCBKYW4gMjgsIDIwMjMgYXQgNDo1MSBQTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxh
aWdodEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IEFuZHkgU2hldmNoZW5rbw0K
PiA+ID4gU2VudDogMjcgSmFudWFyeSAyMDIzIDE1OjUyDQo+ID4gPg0KPiA+ID4gVXNlIHN0cmNo
cigpIGluc3RlYWQgb2Ygb3BlbiBjb2RpbmcgaXQgYXMgaXQncyBkb25lIGVsc2V3aGVyZSBpbg0K
PiA+ID4gdGhlIHNhbWUgZmlsZS4gRWl0aGVyIHdlIHdpbGwgaGF2ZSBzaW1pbGFyIHRvIHdoYXQg
aXQgd2FzIG9yIHBvc3NpYmx5DQo+ID4gPiBiZXR0ZXIgcGVyZm9ybWFuY2UgaW4gY2FzZSBhcmNo
aXRlY3R1cmUgaW1wbGVtZW50cyBpdHMgb3duIHN0cmNocigpLg0KPiA+DQo+ID4gRXhjZXB0IHRo
YXQgeW91IGdldCBhIHdob2xlIGxvYWQgb2YgY2FsbHMgdG8gc3RyY2hyKCkgZm9yICh0eXBpY2Fs
bHkpDQo+ID4gdmVyeSBmZXcgY2hhcmFjdGVycy4NCj4gPiBTbyB0aGUgY29zdCBvZiB0aGUgY2Fs
bHMgZG9taW5hdGVzLCBhbnl0aGluZyB0aGF0IHRyaWVzIHRvIHNwZWVkIHVwDQo+ID4gc3RyY2hy
KCkgZm9yIGxvbmcgc3RyaW5ncyB3aWxsIGFsc28gc2xvdyB0aGluZ3MgZG93bi4NCj4gDQo+IEht
bS4uLiBJIGhhdmVuJ3Qgc2VlbiB0aGUgY2FsbHMsIEkgYXNzdW1lIGdjYyBzaW1wbHkgaW5saW5l
ZCBhIGNvcHkgb2YgdGhhdC4NCg0KQW55dGhpbmcgZ2NjIGl0c2VsZiBpbmxpbmVzIGlzIGxpa2Vs
eSB0byBiZSBvcHRpbWlzZWQgZm9yIGxvbmcgc3RyaW5ncw0KKHdoZXJlIGlubGluaW5nIHByb2Jh
Ymx5IG1ha2VzIGxlc3MgZGlmZmVyZW5jZSkuDQpJbiBhbnkgY2FzZSB0aGF0IHdpbGwgYmxvYXQg
dGhlIGZ1bmN0aW9uIC0gYW5kIHlvdSBzYXcgYSBzaXplIHJlZHVjdGlvbi4NCg0KQWJvdXQgdGhl
IHdvcnN0IHRoaW5nIHRoYXQgY2FuIGhhcHBlbiBoZXJlIGlzIHRoYXQgZ2NjIHJlYWxpc2VzIHRo
ZSBvcGVuDQpjb2RlZCBsb29wIGlzIHN0cmNocigpIGFuZCB0aGVuIGlubGluZXMgaXRzIG93biAn
ZmFzdCcgY29weS4NCldoaWNoIGlzIHRoZSBsYXN0IHRoaW5nIHlvdSB3YW50IGlmIHRoZSBzdHJp
bmcgaXMgb25seSBhIGZldyBjaGFyYWN0ZXJzDQpsb25nLg0KDQo+IA0KPiAuLi4NCj4gDQo+ID4g
QWx0aG91Z2ggSSB2ZXJ5IG11Y2ggZG91YnQgc3RycGJyaygpIGlzIHVzZWQgYW55d2hlcmUgd2hl
cmUNCj4gPiBwZXJmb3JtYW5jZSBtYXR0ZXJzLg0KPiANCj4gc3Ryc2VwKCkvc3Ryc3BuKCkgYXJl
IHRoZSB1c2Vycy4NCg0KSSBiZXQgdGhleSBhcmVuJ3QgY2FsbGVkIGFueXdoZXJlIHRoYXQgbWF0
dGVycy4NClRoZXJlIGlzIGFsc28gYSBzaWduaWZpY2FudCBkaWZmZXJlbnQuDQpzdHJzZXAoKSBp
cyBwcm9iYWJseSBsb29raW5nIGZvciBhIHZlcnkgc21hbGwgbnVtYmVyIG9mIGNoYXJhY3RlcnMu
DQpzdHJzcG4oKSBjb3VsZCBlYXNpbHkgaGF2ZSBhbGwgYWxwaGFiZXRpY3MuDQoNCkZvciBsb25n
IHN0cmluZ3MgeW91IGNhbiBhY3R1YWxseSB1c2UgYSBiaXRtYXAgb2YgdGhlIGNoYXJhY3RlcnMu
DQpPbiA2NGJpdCB0aGlzIGNhbiwgd2l0aCBjYXJlLCBiZSBoZWxkIGluIDQgcmVnaXN0ZXJzLg0K
MzJiaXQgaXMgbW9yZSBwcm9ibGVtYXRpYy4NCkJ1dCBpcyB5b3UgYXJlIGp1c3QgbG9va2luZyBm
b3IgIiBcdCIgdGhlIG92ZXJoZWFkcyBhcmUgbWFzc2l2ZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lz
dGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24g
S2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

