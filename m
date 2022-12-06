Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D2A6445EE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbiLFOo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiLFOoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:44:23 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530FC23145
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:44:21 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-281-LsLMPZAZOU6vU66casKxsQ-1; Tue, 06 Dec 2022 14:44:18 +0000
X-MC-Unique: LsLMPZAZOU6vU66casKxsQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 6 Dec
 2022 14:44:17 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Tue, 6 Dec 2022 14:44:17 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Lafreniere' <peter@n8pjl.ca>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
Thread-Topic: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
Thread-Index: AQHZCXuUthnlIbrum024abYi187HBa5g7Jiw
Date:   Tue, 6 Dec 2022 14:44:17 +0000
Message-ID: <4f72e36f960347b29d1d6b3e59cdb8a2@AcuMS.aculab.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
 <20221116041342.3841-11-elliott@hpe.com> <Y3TF7/+DejcnN0eV@zx2c4.com>
 <Y4B/kjS0lgzdUJHG@gondor.apana.org.au>
 <MW5PR84MB1842C2D1EA00D5EF65784E25AB179@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <Y4nEcV4w3eOEFYze@gondor.apana.org.au>
 <MW5PR84MB184215302DC8E824812D6B13AB179@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <Y47El6TRitHm7Xz9@gondor.apana.org.au>
 <5TnEjVPNm7Eyw-GH7C0LeJJvgRSpOLb2NUshnG407s3TGTXL1lq4RpsoAMTpVGKWk7tVxDI5f2G9aH6lDbATR6QqXXkE7q54o7TUzO91ibI=@n8pjl.ca>
In-Reply-To: <5TnEjVPNm7Eyw-GH7C0LeJJvgRSpOLb2NUshnG407s3TGTXL1lq4RpsoAMTpVGKWk7tVxDI5f2G9aH6lDbATR6QqXXkE7q54o7TUzO91ibI=@n8pjl.ca>
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

RnJvbTogUGV0ZXIgTGFmcmVuaWVyZQ0KPiBTZW50OiAwNiBEZWNlbWJlciAyMDIyIDE0OjA0DQo+
DQo+ID4gPiA+IEJUVywganVzdCBhIG1pbm9yIG5pdCBidXQgeW91IGNhbiBkZWxldGUgdGhlIGNv
bmRfcmVzY2hlZCgpIGNhbGwNCj4gPiA+ID4gYmVjYXVzZSBrZXJuZWxfZnB1X2VuZCgpL3ByZWVt
cHRfZW5hYmxlKCkgd2lsbCBkbyBpdCBhbnl3YXkuDQo+ID4gPg0KPiA+ID4gVGhhdCBoYXBwZW5z
IHVuZGVyDQo+ID4gPiBDT05GSUdfUFJFRU1QVElPTj15DQo+ID4gPiAoZnJvbSBpbmNsdWRlL0xp
bnV4L3ByZWVtcHQuaCBhbmQgYXJjaC94ODYvaW5jbHVkZS9hc20vcHJlZW1wdC5oKQ0KPiA+ID4N
Cj4gPiA+IElzIGNhbGxpbmcgY29uZF9yZXNjaGVkKCkgc3RpbGwgaGVscGZ1bCBpZiB0aGF0IGlz
IG5vdCB0aGUgY29uZmlndXJhdGlvbj8NCj4gPg0KPiA+DQo+ID4gUGVyaGFwcywgYnV0IHRoZW4g
YWdhaW4gcGVyaGFwcyBpZiBwcmVlbXB0aW9uIGlzIG9mZiwgbWF5YmUgd2UNCj4gPiBzaG91bGRu
J3QgZXZlbiBib3RoZXIgd2l0aCB0aGUgNEsgc3BsaXQuIFdlcmUgdGhlIGluaXRpYWwNCj4gPiB3
YXJuaW5ncyB3aXRoIG9yIHdpdGhvdXQgcHJlZW1wdGlvbj8NCj4gPg0KPiA+IFBlcnNvbmFsbHkg
SSBkb24ndCByZWFsbHkgY2FyZSBzaW5jZSBJIGFsd2F5cyB1c2UgcHJlZW1wdGlvbi4NCj4gPg0K
PiA+IFRoZSBQUkVFTVBUIEtjb25maWdzIGRvIHByb3ZpZGUgYSBiaXQgb2YgbnVhbmNlIHdpdGgg
dGhlIHNwbGl0DQo+ID4gYmV0d2VlbiBQUkVFTVBUX05PTkUgdnMuIFBSRUVNUFRfVk9MVU5UQVJZ
LiBCdXQgcGVyaGFwcyB0aGF0IGlzDQo+ID4ganVzdCBvdmVya2lsbCBmb3Igb3VyIHNpdHVhdGlv
bi4NCj4gDQo+IEkgd2FzIHRoaW5raW5nIGFib3V0IHRoaXMgYSBmZXcgZGF5cyBhZ28sIGFuZCBt
eSAywqIgaXMgdGhhdCBpdCdzDQo+IHByb2JhYmx5IGJlc3QgdG8gbm90IHByZWVtcHQgdGhlIGtl
cm5lbCBpbiB0aGUgbWlkZGxlIG9mIGEgY3J5cHRvDQo+IG9wZXJhdGlvbiB1bmRlciBQUkVFTVBU
X1ZPTFVOVEFSWS4gV2UncmUgYWxyZWFkeSBub3QgcHJlZW1wdGluZyBkdXJpbmcNCj4gdGhlc2Ug
b3BlcmF0aW9ucywgYW5kIHRoZXJlIGhhdmVuJ3QgYmVlbiBjb21wbGFpbnRzIG9mIGV4Y2Vzc2l2
ZSBsYXRlbmN5DQo+IGJlY2F1c2Ugb2YgdGhlc2UgY3J5cHRvIG9wZXJhdGlvbnMuDQouLi4NCg0K
UHJvYmFibHkgYmVjYXVzZSB0aGUgcGVvcGxlIHdobyBoYXZlIGJlZW4gc3VmZmVyaW5nIGZyb20g
KGFuZA0KbG9va2luZyBmb3IpIGxhdGVuY3kgaXNzdWVzIGFyZW4ndCBydW5uaW5nIGNyeXB0byB0
ZXN0cy4NCg0KSSd2ZSBmb3VuZCBzb21lIHRlcnJpYmxlIHByZS1lbXB0aW9uIGxhdGVuY3kgaXNz
dWVzIHRyeWluZw0KdG8gZ2V0IFJUIHByb2Nlc3NlcyBzY2hlZHVsZWQgaW4gYSBzZW5zaWJsZSB0
aW1lZnJhbWUuDQpJIHdvdWxkbid0IHdvcnJ5IGFib3V0IDEwMHVzIC0gSSdtIGRvaW5nIGF1ZGlv
IHByb2Nlc3NpbmcNCmV2ZXJ5IDEwbXMsIGJ1dCBhbnl0aGluZyBtdWNoIGxvbmdlciBjYXVzZXMg
cHJvYmxlbXMgd2hlbg0KdHJ5aW5nIHRvIHVzZSA5MCslIG9mIHRoZSBjcHUgdGltZSBmb3IgbG90
cyBvZiBhdWRpbyBjaGFubmVscy4NCg0KSSBkaWRuJ3QgdHJ5IGEgQ09ORklHX1JUIGtlcm5lbCwg
dGhlIGFwcGxpY2F0aW9uIG5lZWRzIHRvIHJ1bg0Kb24gYSBzdGFuZGFyZCAnZGlzdHJvJyBrZXJu
ZWwuIEluIGFueSBjYXNlIEkgc3VzcGVjdCBhbGwgdGhlDQpleHRyYSBwcm9jZXNzZXMgc3dpdGNo
ZXMgKGV0YykgdGhlIFJUIGtlcm5lbCBhZGRzIHdpbGwgY29tcGxldGVseQ0Ka2lsbCBwZXJmb3Jt
YW5jZS4NCg0KSSB3b25kZXIgaG93IG11Y2ggaXQgd291bGQgY29zdCB0byBtZWFzdXJlIHRoZSB0
aW1lIHNwZW50IHdpdGgNCnByZS1lbXB0IGRpc2FibGVkIChhbmQgbm90IGNoZWNrZWQpIGFuZCB0
byB0cmFjZSBsb25nIGludGVydmFscy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

