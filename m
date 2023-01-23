Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94D067802E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjAWPmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjAWPmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:42:18 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B427C2B09E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:42:11 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-87-3IbaZKCYO-KMWW2A3FYeeA-1; Mon, 23 Jan 2023 15:42:09 +0000
X-MC-Unique: 3IbaZKCYO-KMWW2A3FYeeA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Mon, 23 Jan
 2023 15:42:08 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Mon, 23 Jan 2023 15:42:08 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Uros Bizjak' <ubizjak@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
Thread-Topic: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
Thread-Index: AQHZK4esPiXIxoxXL0qMusgAkdAn7q6lrzIwgAZxyoCAAARj8A==
Date:   Mon, 23 Jan 2023 15:42:08 +0000
Message-ID: <efcf1ad325064d47ba027db9a98222ac@AcuMS.aculab.com>
References: <20230118150703.4024-1-ubizjak@gmail.com>
 <20230118131825.c6daea81ea1e2dc6aa014f38@linux-foundation.org>
 <CAFULd4ZQGG+N3f7xDuoiNG1jY128pqaH0F4eLKO+fhvSNAbKfA@mail.gmail.com>
 <CAFULd4b5szcTHTVbGJ9WiciG_+8kANiPZYP_pkEZUhnz_HHy-g@mail.gmail.com>
 <913c01d41f824fa8b3400384437fa0d8@AcuMS.aculab.com>
 <CAFULd4aDORSrq7zf_LcAZRP8HOHcrq2-rGMaroKyG2zQDHNpOA@mail.gmail.com>
In-Reply-To: <CAFULd4aDORSrq7zf_LcAZRP8HOHcrq2-rGMaroKyG2zQDHNpOA@mail.gmail.com>
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

RnJvbTogVXJvcyBCaXpqYWsNCj4gU2VudDogMjMgSmFudWFyeSAyMDIzIDE1OjA1DQo+IA0KPiBP
biBUaHUsIEphbiAxOSwgMjAyMyBhdCAxOjQ3IFBNIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0
QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiBCVFc6IFJlY2VudGx5LCBpdCB3YXMgZGV0
ZXJtaW5lZCBbMV0gdGhhdCB0aGUgdXNhZ2Ugb2YgY3B1X3JlbGF4KCkNCj4gPiA+IGluc2lkZSB0
aGUgY21weGNoZyBsb29wIGNhbiBiZSBoYXJtZnVsIGZvciBwZXJmb3JtYW5jZS4gV2UgYWN0dWFs
bHkNCj4gPiA+IGhhdmUgdGhlIHNhbWUgc2l0dWF0aW9uIGhlcmUsIHNvIHBlcmhhcHMgY3B1X3Jl
bGF4KCkgc2hvdWxkIGJlIHJlbW92ZWQNCj4gPiA+IGluIHRoZSBzYW1lIHdheSBpdCB3YXMgcmVt
b3ZlZCBmcm9tIHRoZSBsb2NrcmVmLg0KPiA+DQo+ID4gSSdtIG5vdCBzdXJlIHlvdSBjYW4gZXZl
ciB3YW50IGEgY3B1X3JlbGF4KCkgaW4gYSBsb29wIHRoYXQNCj4gPiBpcyBpbXBsZW1lbnRpbmcg
YW4gYXRvbWljIG9wZXJhdGlvbi4NCj4gPiBFdmVuIHRoZSBpYTY0IChkaWUuLi4pIGlzc3VlIHdh
cyB3aXRoIGEgbG9vcCB0aGF0IHdhcyB3YWl0aW5nDQo+ID4gZm9yIGFub3RoZXIgY3B1IHRvIGNo
YW5nZSB0aGUgbG9jYXRpb24gKGVnIGEgc3BpbmxvY2spLg0KPiA+DQo+ID4gRm9yIGFuIGF0b21p
YyBvcGVyYXRpb24gYW4gaW1tZWRpYXRlIHJldHJ5IGlzIGxpa2VseSB0byBzdWNjZWVkLg0KPiA+
IEFueSBraW5kIG9mIGRlZmVycmFsIHRvIGFuIGFub3RoZXIgY3B1IGNhbiBvbmx5IG1ha2UgaXQg
d29yc2UuDQo+ID4NCj4gPiBDbGVhcmx5IGlmIHlvdSBoYXZlIDEwMHMgb2YgY3B1IGxvb3Bpbmcg
ZG9pbmcgYXRvbWljIG9wZXJhdGlvbg0KPiA+IG9uIHRoZSBzYW1lIGNhY2hlIGxpbmUgaXQgaXMg
bGlrZWx5IHRoYXQgc29tZSBnZXQgc3RhcnZlZC4NCj4gPiBCdXQgdG8gZml4IHRoYXQgeW91IG5l
ZWQgdG8gaW5jcmVhc2UgdGhlIHRpbWUgYmV0d2VlbiBzdWNjZXNzZnVsDQo+ID4gb3BlcmF0aW9u
cywgbm90IGRlbGF5IG9uIGZhaWx1cmUuDQo+IA0KPiBJIHdvdWxkIGxpa2UgdG8gcG9pbnQgb3V0
IHRoYXQgdGhlIHdpa2lwZWRpYSBhcnRpY2xlIG9uDQo+IGNvbXBhcmUtYW5kLXN3YXAgY2xhaW1z
IFsxXSB0aGF0Og0KPiANCj4gSW5zdGVhZCBvZiBpbW1lZGlhdGVseSByZXRyeWluZyBhZnRlciBh
IENBUyBvcGVyYXRpb24gZmFpbHMsDQo+IHJlc2VhcmNoZXJzIGhhdmUgZm91bmQgdGhhdCB0b3Rh
bCBzeXN0ZW0gcGVyZm9ybWFuY2UgY2FuIGJlIGltcHJvdmVkDQo+IGluIG11bHRpcHJvY2Vzc29y
IHN5c3RlbXPigJR3aGVyZSBtYW55IHRocmVhZHMgY29uc3RhbnRseSB1cGRhdGUgc29tZQ0KPiBw
YXJ0aWN1bGFyIHNoYXJlZCB2YXJpYWJsZeKAlGlmIHRocmVhZHMgdGhhdCBzZWUgdGhlaXIgQ0FT
IGZhaWwgdXNlDQo+IGV4cG9uZW50aWFsIGJhY2tvZmbigJRpbiBvdGhlciB3b3Jkcywgd2FpdCBh
IGxpdHRsZSBiZWZvcmUgcmV0cnlpbmcgdGhlDQo+IENBUyBbMl0uDQoNClByb2JhYmx5LCBidXQg
dGhlIHJlYWwgc29sdXRpb24gaXMgJ2Rvbid0IGRvIHRoYXQnLg0KSW4gYW55IGNhc2UgSSBzdXNw
ZWN0IHRoZSBjcHVfcmVsYXgoKSBleHBsaWNpdGx5IGxldHMgdGhlDQpvdGhlciBoeXBlcnRocmVh
ZGluZyBjcHUgcnVuIC0gd2hpY2ggaXNuJ3QgdXNlZnVsIGF0IGFsbC4NCg0KV2hhdCB5b3UgYWN0
dWFsbHkgd2FudCBpZiBmb3IgdGhlIGNhY2hlIGxvZ2ljIHRvIGF2b2lkIGxvc2luZw0KJ2V4Y2x1
c2l2ZScgYWNjZXNzIHRvIHRoZSBjYWNoZSBsaW5lIGZvciBlbm91Z2ggY2xvY2tzIGFmdGVyIGEN
CmZhaWxlZCBjb21wYXJlK2V4Y2hhbmdlIHRvIGFsbG93IHRoZSBjcHUgdG8gcmUtaXNzdWUgdGhl
IG1lbW9yeQ0KY3ljbGUgd2l0aCBhbiB1cGRhdGVkIHZhbHVlLg0KWW91IGNhbid0IGRvIGFueXRo
aW5nIGFib3V0IG9uZSBjcHUgYmVpbmcgc3RhcnZlZCwgYnV0IGEgc2hvcnQNCmRlbGF5IHRoZXJl
IGlzIGFsbW9zdCBjZXJ0YWlubHkgYmVuZWZpY2lhbC4NCihTb21lIGhhcmR3YXJlIGNhY2hlIGVu
Z2luZWVyIHdpbGwgcHJvYmFibHkgc2F5IG90aGVyd2lzZS4pDQoNCglEYXZpZA0KDQotDQpSZWdp
c3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9u
IEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

