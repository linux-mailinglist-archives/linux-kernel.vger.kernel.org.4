Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D2A679383
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjAXIyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjAXIy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:54:29 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B5D38039
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:54:27 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-122-9RJp0W1SNBKAvoVKfHTvLQ-1; Tue, 24 Jan 2023 08:54:25 +0000
X-MC-Unique: 9RJp0W1SNBKAvoVKfHTvLQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Tue, 24 Jan
 2023 08:54:25 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Tue, 24 Jan 2023 08:54:25 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mateusz Guzik' <mjguzik@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>, Uros Bizjak <ubizjak@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
Thread-Topic: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
Thread-Index: AQHZK4esPiXIxoxXL0qMusgAkdAn7q6lrzIwgAcKieqAAI8WsA==
Date:   Tue, 24 Jan 2023 08:54:24 +0000
Message-ID: <7d506ede564d425db116ff646f267f4f@AcuMS.aculab.com>
References: <20230118150703.4024-1-ubizjak@gmail.com>
 <20230118131825.c6daea81ea1e2dc6aa014f38@linux-foundation.org>
 <CAFULd4ZQGG+N3f7xDuoiNG1jY128pqaH0F4eLKO+fhvSNAbKfA@mail.gmail.com>
 <CAFULd4b5szcTHTVbGJ9WiciG_+8kANiPZYP_pkEZUhnz_HHy-g@mail.gmail.com>
 <913c01d41f824fa8b3400384437fa0d8@AcuMS.aculab.com>
 <CAFULd4aDORSrq7zf_LcAZRP8HOHcrq2-rGMaroKyG2zQDHNpOA@mail.gmail.com>
 <CAGudoHF6zbyzza6xysuCjcxjHAUgeAVvgW0sqxDAFQNwz9u7wg@mail.gmail.com>
 <CAHk-=whUSZk1dZrJuhxeb4qB3POstVRwOZCN8PXd3W7ztbqQBg@mail.gmail.com>
 <CAGudoHH+SmRoyXvppjBEoK=dvVdy1jvKNHDLEVf9mLnzsEds6Q@mail.gmail.com>
In-Reply-To: <CAGudoHH+SmRoyXvppjBEoK=dvVdy1jvKNHDLEVf9mLnzsEds6Q@mail.gmail.com>
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

RnJvbTogTWF0ZXVzeiBHdXppaw0KPiBTZW50OiAyNCBKYW51YXJ5IDIwMjMgMDA6MTENCi4uLg0K
PiBTbyBpZiB5b3Ugc3RyYWNlIHNvbWV0aGluZyBsaWtlIGdjYyBjb21waWxpbmcgc3R1ZmYgeW91
IHdpbGwgZmluZDoNCj4gLSBzb21lIGFjY2VzcyBjYWxscyBvbiBzaGFyZWQgZGlycywgZm9yIGV4
YW1wbGU6DQo+IDc4NTMzIGFjY2VzcygiL3Vzci9saWIvZ2NjL3g4Nl82NC1saW51eC1nbnUvMTEv
IiwgWF9PSykgPSAwDQo+IDc4NTMzIGFjY2VzcygiL3Vzci9saWIvZ2NjL3g4Nl82NC1saW51eC1n
bnUvMTEvIiwgWF9PSykgPSAwDQo+IDc4NTMzIGFjY2VzcygiL3Vzci9saWIvZ2NjL3g4Nl82NC1s
aW51eC1nbnUvMTEvIiwgWF9PSykgPSAwDQoNCkFyZSB0aGV5IGJhY2sgdG8gYmFjaz8gV2hpY2gg
aXMganVzdCBzdHVwaWQuDQpPbmNlIHBlciBpbnZvY2F0aW9uIG9mIGdjYyB3b3VsZCBiZSBub2lz
ZS4NCg0KPiAtIHNhbWUgd2l0aCBuZXdmc3RhdGF0Og0KPiA4NzQyOCBuZXdmc3RhdGF0KEFUX0ZE
Q1dELCAiLi9hcmNoL3g4Ni9pbmNsdWRlIiwge3N0X21vZGU9U19JRkRJUnwwNzU1LCBzdF9zaXpl
PTQwOTYsIC4uLn0sIDApID0gMA0KPiA4NzQyOCBuZXdmc3RhdGF0KEFUX0ZEQ1dELCAiLi9hcmNo
L3g4Ni9pbmNsdWRlL2dlbmVyYXRlZCIsIHtzdF9tb2RlPVNfSUZESVJ8MDc1NSwgc3Rfc2l6ZT00
MDk2LCAuLi59LCAwKSA9IDANCj4gODc0MjggbmV3ZnN0YXRhdChBVF9GRENXRCwgIi4vaW5jbHVk
ZSIsIHtzdF9tb2RlPVNfSUZESVJ8MDc1NSwgc3Rfc2l6ZT00MDk2LCAuLi59LCAwKSA9IDANCj4g
ODc0MjggbmV3ZnN0YXRhdChBVF9GRENXRCwgIi4vYXJjaC94ODYvaW5jbHVkZS91YXBpIiwge3N0
X21vZGU9U19JRkRJUnwwNzU1LCBzdF9zaXplPTQwOTYsIC4uLn0sIDApID0gMA0KPiAtIHRoZXJl
IGlzIGFsc28gcXVpdGUgYSBiaXQgb2YgcmVhZGxpbms6DQo+IDg3NTAyIHJlYWRsaW5rKCIvdG1w
IiwgMHg3ZmZlMjg4NDdhYzAsIDEwMjMpID0gLTEgRUlOVkFMIChJbnZhbGlkIGFyZ3VtZW50KQ0K
PiA4NzUwMiByZWFkbGluaygiL3RtcC9jY1RoMzdvSS5zIiwgMHg3ZmZlMjg4NDdhYzAsIDEwMjMp
ID0gLTEgRUlOVkFMIChJbnZhbGlkIGFyZ3VtZW50KQ0KPiANCj4gdGhhdCBsYXN0IGJpdCBpcyBn
bGliYyBkb2luZyByZWFscGF0aCgpLiBBIGNhc2UgY2FuIGJlIG1hZGUgZm9yIG1ha2luZw0KPiBy
ZWFscGF0aCBpbnRvIGEgc3lzY2FsbCBpbnN0ZWFkLCBidXQgSSdtIG5vdCBnb2luZyB0byBmbGFt
ZSBvdmVyIGZvcg0KPiB0aGUgdGltZSBiZWluZy4gOikNCg0KSSByZW1lbWJlciBsb29raW5nIGF0
IHN5c2NhbGwgY291bnRzIGR1cmluZyBhIChOZXRCU0QpIGJ1aWxkDQphbmQgZGVjaWRpbmcgdGhh
dCB0aGUgZG9taW5hbnQgc3lzdGVtIGNhbGwgd2FzIGFjdHVhbGx5IGZhaWxlZA0Kb3BlbnMgZnJv
bSB0aGUgY29tcGlsZXIgc2VhcmNoaW5nIGxvbmcgLUkgcGF0aHMgbG9va2luZyBmb3INCmhlYWRl
cnMuDQpZb3UgY2FuIHNwZWVkIHRoaW5ncyB1cCBieSBjb3B5aW5nIGFsbCB0aGUgLmggZmlsZXMg
ZnJvbSB0aGUNCmZpeGVkIC1JIHBhdGggbGlzdCBpbnRvIGEgc2luZ2xlIGRpcmVjdG9yeS4NCg0K
CURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBN
b3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAx
Mzk3Mzg2IChXYWxlcykNCg==

