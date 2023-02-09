Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0863A690908
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBIMjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBIMjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:39:15 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C391B575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:39:13 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-246-maV0mZRmMnWCaAOCB0EZVA-1; Thu, 09 Feb 2023 12:39:11 +0000
X-MC-Unique: maV0mZRmMnWCaAOCB0EZVA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Thu, 9 Feb
 2023 12:39:07 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Thu, 9 Feb 2023 12:39:07 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'maobibo' <maobibo@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>
CC:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] LoongArch: add checksum optimization for 64-bit system
Thread-Topic: [PATCH v2] LoongArch: add checksum optimization for 64-bit
 system
Thread-Index: AQHZPDrPjnYkuPc3GUK7DnTa61yn8K7GU7lQgAAunoCAAAOYoA==
Date:   Thu, 9 Feb 2023 12:39:07 +0000
Message-ID: <2aa6243491784e74960182dc12968170@AcuMS.aculab.com>
References: <20230209035839.2610277-1-maobibo@loongson.cn>
 <e6bb59c32134477aa4890047ae5ad51b@AcuMS.aculab.com>
 <741b2246-d609-ccc6-bf55-d6b0b5e54b54@loongson.cn>
In-Reply-To: <741b2246-d609-ccc6-bf55-d6b0b5e54b54@loongson.cn>
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

RnJvbTogbWFvYmlibw0KPiBTZW50OiAwOSBGZWJydWFyeSAyMDIzIDExOjU1DQo+IA0KPiANCj4g
5ZyoIDIwMjMvMi85IDE3OjM1LCBEYXZpZCBMYWlnaHQg5YaZ6YGTOg0KPiA+IEZyb206IEJpYm8g
TWFvDQo+ID4+IFNlbnQ6IDA5IEZlYnJ1YXJ5IDIwMjMgMDM6NTkNCj4gPj4NCj4gPj4gbG9vbmdB
cmNoIHBsYXRmb3JtIGlzIDY0LWJpdCBzeXN0ZW0sIHdoaWNoIHN1cHBvcnRzIDggYnl0ZXMgbWVt
b3J5DQo+ID4+IGFjY2Vzc2luZywgZ2VuZXJpYyBjaGVja3N1bSBmdW5jdGlvbiB1c2VzIDQgYnl0
ZSBtZW1vcnkgYWNjZXNzLg0KPiA+PiBUaGlzIHBhdGNoIGFkZHMgOC1ieXRlcyBtZW1vcnkgYWNj
ZXNzIG9wdGltaXphdGlvbiBmb3IgY2hlY2tzdW0NCj4gPj4gZnVuY3Rpb24gb24gbG9vbmdBcmNo
LiBBbmQgdGhlIGNvZGUgY29tZXMgZnJvbSBhcm02NCBzeXN0ZW0uDQo+ID4NCj4gPiBIb3cgZmFz
dCBkbyB0aGVzZSBmdW5jdGlvbnMgYWN0dWFsbHkgcnVuIChpbiBieXRlcy9jbG9jayk/DQo+IFdp
dGggdWludDEyOCBtZXRob2QsIHRoZXJlIHdpbGwgdW5yb2xsZWQgbG9vcCwgaW5zdHJ1Y3Rpb24N
Cj4gY2FuIGV4ZWN1dGUgaW4gcGFyYWxsZWwuIEl0IGdldHMgdGhlIGJlc3QgcmVzdWx0IG9uIGxv
b25nYXJjaA0KPiBzeXN0ZW0gd2hlcmUgdGhlcmUgaXMgbm8gbmVpdGhlciBjYXJyeSBmbGFnIG5v
ciBwb3N0LWluZGV4DQo+IGFkZHJlc3NpbmcgbW9kZXMuDQoNCldlJ3JlIHByb2JhYmx5IGFsbW9z
dCBhZ3JlZWluZy4uLg0KDQo+IEhlcmUgaXMgdGhlIHBpZWNlIG9mIGRpc2Fzc2VtYmxlIGNvZGUg
d2l0aCB1aW50MTI4IG1ldGhvZDoNCg0KTG9hZCA4IHZhbHVlczoNCg0KPiAgICAxMjAwMDBhNDA6
ICAgMjhjMDIyMmYgICAgICAgIGxkLmQgICAgJHIxNSwkcjE3LDgoMHg4KQ0KPiAgICAxMjAwMDBh
NDQ6ICAgMjhjMDYyMmEgICAgICAgIGxkLmQgICAgJHIxMCwkcjE3LDI0KDB4MTgpDQo+ICAgIDEy
MDAwMGE0ODogICAyOGMwYTIzMCAgICAgICAgbGQuZCAgICAkcjE2LCRyMTcsNDAoMHgyOCkNCj4g
ICAgMTIwMDAwYTRjOiAgIDI4YzBlMjMyICAgICAgICBsZC5kICAgICRyMTgsJHIxNyw1NigweDM4
KQ0KPiAgICAxMjAwMDBhNTA6ICAgMjhjMDAyMmUgICAgICAgIGxkLmQgICAgJHIxNCwkcjE3LDAN
Cj4gICAgMTIwMDAwYTU0OiAgIDI4YzA0MjJkICAgICAgICBsZC5kICAgICRyMTMsJHIxNywxNigw
eDEwKQ0KPiAgICAxMjAwMDBhNTg6ICAgMjhjMDgyMmIgICAgICAgIGxkLmQgICAgJHIxMSwkcjE3
LDMyKDB4MjApDQo+ICAgIDEyMDAwMGE1YzogICAyOGMwYzIyYyAgICAgICAgbGQuZCAgICAkcjEy
LCRyMTcsNDgoMHgzMCkNCg0KUGFpcndpc2UgYWRkIHRoZW0NCg0KPiAgICAxMjAwMDBhNjA6ICAg
MDAxMGI5ZjcgICAgICAgIGFkZC5kICAgJHIyMywkcjE1LCRyMTQNCj4gICAgMTIwMDAwYTY0OiAg
IDAwMTBiNTRkICAgICAgICBhZGQuZCAgICRyMTMsJHIxMCwkcjEzDQo+ICAgIDEyMDAwMGE2ODog
ICAwMDEwYjI0YyAgICAgICAgYWRkLmQgICAkcjEyLCRyMTgsJHIxMg0KPiAgICAxMjAwMDBhNmM6
ICAgMDAxMGFlMGIgICAgICAgIGFkZC5kICAgJHIxMSwkcjE2LCRyMTENCg0KR2VuZXJhdGUgNCAn
Y2FycnknIGJpdHMNCg0KPiAgICAxMjAwMDBhNzA6ICAgMDAxMmM5OTIgICAgICAgIHNsdHUgICAg
JHIxOCwkcjEyLCRyMTgNCj4gICAgMTIwMDAwYTc0OiAgIDAwMTJiZWVlICAgICAgICBzbHR1ICAg
ICRyMTQsJHIyMywkcjE1DQo+ICAgIDEyMDAwMGE3ODogICAwMDEyYzE3MCAgICAgICAgc2x0dSAg
ICAkcjE2LCRyMTEsJHIxNg0KPiAgICAxMjAwMDBhN2M6ICAgMDAxMmE5YWEgICAgICAgIHNsdHUg
ICAgJHIxMCwkcjEzLCRyMTANCg0KQWRkIHRoZSBjYXJyeSBiaXRzIG9udG8gdGhlIHN1bXMuDQpJ
J3ZlIG5vdCBxdWl0ZSB3b3JrZWQgb3V0IHdoaWNoIGFkZCBpcyB3aGljaCENCkJ1dCBJIHRoaW5r
IHlvdSd2ZSBtaXNzZWQgYSBmZXcgYWRkcyBoZXJlLg0KDQo+ICAgIDEyMDAwMGE4MDogICAwMDEw
YWUwZiAgICAgICAgYWRkLmQgICAkcjE1LCRyMTYsJHIxMQ0KPiAgICAxMjAwMDBhODQ6ICAgMDAx
MGRkY2UgICAgICAgIGFkZC5kICAgJHIxNCwkcjE0LCRyMjMNCj4gICAgMTIwMDAwYTg4OiAgIDAw
MTBiMjUwICAgICAgICBhZGQuZCAgICRyMTYsJHIxOCwkcjEyDQo+ICAgIDEyMDAwMGE4YzogICAw
MDEwYjU0ZCAgICAgICAgYWRkLmQgICAkcjEzLCRyMTAsJHIxMw0KPiAgICAxMjAwMDBhOTA6ICAg
MDAxMGI1ZDIgICAgICAgIGFkZC5kICAgJHIxOCwkcjE0LCRyMTMNCj4gICAgMTIwMDAwYTk0OiAg
IDAwMTBjMWYwICAgICAgICBhZGQuZCAgICRyMTYsJHIxNSwkcjE2DQoNClNvbWV3aGVyZSBlYWNo
IHZhbHVlIG5lZWRzIGFuIGFkZCwgYW4gc2x0dSB0byBnZW5lcmF0ZSB0aGUgJ2NhcnJ5JywNCmFu
ZCBhbiBhZGQgZm9yIHRoZSBjYXJyeSBpdHNlbGYuDQpJZiB5b3Ugc3VtIHRoZSBjYXJyeSBiaXRz
IGludG8gYSBzZXBhcmF0ZSByZWdpc3RlciBpdCBpcw0KcG9zc2libGUgdG8gZ2V0IGEgYm90aCBh
ZGRzIGFuZCB0aGUgc2x0dSAoZm9yIGRpZmZlcmVudCB2YWx1ZXMpDQp0byBydW4gaW4gdGhlIHNh
bWUgY2xvY2sgKG9uIGEgc3VpdGFibGUgY3B1KS4NCklmIHRoZXJlIGFyZSA0IGludGVnZXIgdW5p
dHMgeW91IGNhbiBhbHNvIGdldCB0aGUgbG9vcCBpbnN0cnVjdGlvbnMNCidmb3IgZnJlZScgYW5k
IHVucm9sbGluZyA4IHRpbWVzIG1heSBub3QgYmUgbmVlZGVkIGF0IGFsbC4NCg0KLi4uDQo+IFRo
ZXJlIGlzIG5vIHBvc3QtaW5kZXggYWRkcmVzc2luZyBtb2RlcyBvbiBsb29uZ2FyY2gsDQo+ICAJ
dmFsID0gKm1lbTsgIC8vIDY0Yml0IHJlYWQNCj4gICAgICAgICBtZW0rKzsNCj4gIAlzdW0gKz0g
dmFsOw0KPiAgCWNhcnJ5ID0gc3VtIDwgdmFsOw0KPiAgCWNhcnJ5X3N1bSArPSBjYXJyeTsNCj4g
aXQgdGFrZXMgNSBpbnN0cnVjdGlvbiBhbmQgdGhlc2UgNSBpbnN0cnVjdGlvbnMgZGVwZW5kcyBv
biBwcmV2aW91cyBpbnN0ci4NCg0KSSdkIGFzc3VtZSB0aGUgbG9vcCB3YXMgdW5yb2xsZWQgZW5v
dWdoIHNvIHRoZSBhZGRyZXNzDQppbmNyZW1lbnQgZG9lc24ndCBtYXR0ZXIuDQoNCj4gVGhlcmUg
aXMgdGhlIHBpZWNlIG9mIGRpc2Fzc2VtYmxlIGNvZGU6DQo+ICAgIDEyMDAwMGQ5MDogICAyOGMw
MDFmMCAgICAgICAgbGQuZCAgICAkcjE2LCRyMTUsMA0KPiAgICAxMjAwMDBkOTQ6ICAgMDAxMGM1
OGMgICAgICAgIGFkZC5kICAgJHIxMiwkcjEyLCRyMTcNCj4gICAgMTIwMDAwZDk4OiAgIDAyYzAy
MWVmICAgICAgICBhZGRpLmQgICRyMTUsJHIxNSw4KDB4OCkNCg0KVGhvc2UgdGhyZWUgaW5zdHJ1
Y3Rpb25zIGFyZSBpbmRlcGVuZGVudC4NCg0KPiAgICAxMjAwMDBkOWM6ICAgMDAxMGIyMGMgICAg
ICAgIGFkZC5kICAgJHIxMiwkcjE2LCRyMTINCg0KdGhhdCBvbmUgZGVwZW5kcyBvbiB0aGUgbGQu
ZA0KDQo+ICAgIDEyMDAwMGRhMDogICAwMDEyYzE5MSAgICAgICAgc2x0dSAgICAkcjE3LCRyMTIs
JHIxNg0KDQp0aGF0IGRlcGVuZHMgb24gdGhlIGFkZC5kDQpidXQgaXQgY291bGQgYmUgZXhlY3V0
ZSBhZnRlciB0aGUgJ2JuZScgaW4gcGFyYWxsZWwgd2l0aCB0aGUgbGQuZA0KDQo+ICAgIDEyMDAw
MGRhNDogICA1ZmZmZWRmMiAgICAgICAgYm5lICAgICAkcjE1LCRyMTgsLTIwKDB4M2ZmZWMpICMg
MTIwMDAwZDkwIDxkb19jc3VtXzY0KzB4OTA+DQoNCklmIHlvdSB0d2VhayB0aGUgY29kZSBpdCBp
cyBwb3NzaWJsZSB0byBnZXQgZG93biB0byBqdXN0DQp0aGUgYWRkaS5kIGFuZCBibmUgY29uc3Ry
YWluaW5nIHRoZSBkZXBlbmRlbmN5IGNoYWluLg0KKEFzc3VtaW5nIHRoZXJlIGlzIG5vIGRlbGF5
IG9uIHRoZSByZWFkIGFuZCB0aGVyZSBhcmUgYW4gaW5maW5pdGUNCm51bWJlciBvZiBleGVjdXRp
b24gdW5pdHMuKQ0KVW5yb2xsIG9uY2UgYW5kIGRvOg0KCWxkLmQgcixhZGRyLDANCglhZGRpLmQg
YWRkciwxNg0KCWxkLmQgcixhZGRyLC04DQoJYm5lIGFkZHIsbGltaXQsbG9vcF90b3ANCmFuZCB5
b3UgbWlnaHQgZ2V0IGEgbG9vcCB0aGF0IGRvZXMgYSBtZW1vcnkgcmVhZCBldmVyeSBjbG9jay4N
Cg0KU28geW91IGVuZCB1cCB3b3JyeWluZyBhYm91dCBob3cgdGhlIG1lbW9yeSByZWFkIGRlbGF5
cyBhZmZlY3QNCnRoZSBpbnN0cnVjdGlvbiBwaXBlbGluZS4NClRoZSBJbnRlbCB4ODYgY3B1IEkn
dmUgZ290IGp1c3QgcGlsZSB1cCB0aGUgYXJpdGhtZXRpYyBpbnN0cnVjdGlvbnMNCndhaXRpbmcg
Zm9yIHRoZSBkYXRhIHRvIGJlIHJlYWQuDQpJZiB5b3UgZ2V0IGEgbWVtb3J5IHJlYWQgcmVxdWVz
dGVkIGV2ZXJ5IGNsb2NrIGV2ZXJ5dGhpbmcgZWxzZQ0KZm9sbG93cyAtIHByb3ZpZGVkIHlvdSBk
b24ndCB0cnkgdG8gZXhlY3V0ZSB0b28gbWFueSBpbnN0cmN1dGlvbnMNCmF0IG9uY2UuDQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=

