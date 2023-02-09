Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAB1691358
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjBIW1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjBIW1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:27:15 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55736ADDA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 14:27:09 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-263-qxkzVVPDNT-g-ECj9MjTaw-1; Thu, 09 Feb 2023 22:27:07 +0000
X-MC-Unique: qxkzVVPDNT-g-ECj9MjTaw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Thu, 9 Feb
 2023 22:27:05 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Thu, 9 Feb 2023 22:27:05 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Andrew.Cooper3@citrix.com'" <Andrew.Cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>
Subject: RE: [PATCH v3 3/4] x86/alternative: Rewrite optimize_nops() some
Thread-Topic: [PATCH v3 3/4] x86/alternative: Rewrite optimize_nops() some
Thread-Index: AQHZPCNpCLmxNXlmiUO26BXbwYgbs67HLM5Q
Date:   Thu, 9 Feb 2023 22:27:05 +0000
Message-ID: <a12179a9f31b4b05b7430d5ba743d615@AcuMS.aculab.com>
References: <20230208171050.490809180@infradead.org>
 <20230208171431.373412974@infradead.org>
 <f0b54521-26cf-ed38-d805-3a8eef3b3103@citrix.com>
 <Y+QGIiOupDKxlKKR@hirez.programming.kicks-ass.net>
 <Y+QHyF5K5hSN0ziP@hirez.programming.kicks-ass.net>
 <Y+QJlK637EYg/Zst@hirez.programming.kicks-ass.net>
 <Y+QPPFQ4DzSaJC3m@hirez.programming.kicks-ass.net>
 <Y+QSSFEfA5oXdKUS@hirez.programming.kicks-ass.net>
 <c23540da-5f73-dede-124f-529b01ce5273@citrix.com>
In-Reply-To: <c23540da-5f73-dede-124f-529b01ce5273@citrix.com>
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

RnJvbTogQW5kcmV3LkNvb3BlcjNAY2l0cml4LmNvbQ0KPiBTZW50OiAwOSBGZWJydWFyeSAyMDIz
IDAxOjExDQouLi4NCj4gPj4gVU5UUkFJTl9SRVQgLS0gc3BlY2lmaWNhbGx5IFJFU0VUX0NBTExf
REVQVEgNCj4gPiAxOTogICAgICAgNDggYzcgYzAgODAgMDAgMDAgMDAgICAgbW92ICAgICQweDgw
LCVyYXgNCj4gPiAyMDogICAgICAgNDggYzEgZTAgMzggICAgICAgICAgICAgc2hsICAgICQweDM4
LCVyYXgNCj4gPiAyNDogICAgICAgNjUgNDggODkgMDQgMjUgMDAgMDAgMDAgMDAgICAgICBtb3Yg
ICAgJXJheCwlZ3M6MHgwICAgICAyOTogUl9YODZfNjRfMzJTDQo+IHBjcHVfaG90KzB4MTANCj4g
Pg0KPiA+IElzIG9mYyBhbiBhdHJvY2l0eS4NCj4gPg0KPiA+IFdlIGNhbiBlYXNpbHkgdHJpbSB0
aGF0IGJ5IDUgYnl0ZXMgdG86DQo+ID4NCj4gPiAwOiAgIGIwIDgwICAgICAgICAgICAgICAgICAg
IG1vdiAgICAkMHg4MCwlYWwNCj4gPiAyOiAgIDQ4IGMxIGUwIDM4ICAgICAgICAgICAgIHNobCAg
ICAkMHgzOCwlcmF4DQo+ID4gNjogICA2NSA0OCA4OSAwNCAyNSAwMCAwMCAwMCAwMCAgICAgIG1v
diAgICAlcmF4LCVnczoweDANCj4gPg0KPiA+IFdobyBjYXJlcyBhYm91dCB0aGUgdG9wIGJ5dGVz
LCB3ZSdyZSBleHBsaWNpdGx5IHNoaWZ0aW5nIHRoZW0gb3V0DQo+ID4gYW55d2F5LiBCdXQgdGhh
dCdzIHN0aWxsIDE1IGJ5dGVzIG9yIHNvLg0KPiA+DQo+ID4gSWYgaXQgd2VyZW4ndCBmb3IgdGhv
c2UgcGVza3kgcHJlZml4IHBlbmFsdGllcyB0aGF0IHdvdWxkIG1ha2UgZXhhY3RseQ0KPiA+IG9u
ZSBpbnN0cnVjdGlvbiA6LSkNCj4gDQo+IFllYWgsIGJ1dCB0aGVuIHlvdSdyZSB0YWtpbmcgYSBt
ZXJnZSBwZW5hbHR5IGluc3RlYWQuDQo+IA0KPiBHaXZlbiB0aGF0IHlvdSBjYW4ndCByZWR1Y2Ug
ZW5vdWdoIGFueXdheSwgd2hpbGUgb25seSBhIDQgYnl0ZSByZWR1Y3Rpb24NCj4gcmF0aGVyIHRo
YW4gNSwgeW91J3JlIHByb2JhYmx5IGJldHRlciBvZmYgd2l0aDoNCj4gDQo+IDA6wqDCoCAzMSBj
MCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHhvciDCoMKgICVlYXgsJWVheA0K
PiAyOsKgwqAgNDggMGYgYmEgZTggM2bCoMKgwqDCoMKgwqDCoMKgwqAgYnRzIMKgwqAgJDB4M2Ys
JXJheA0KPiA3OsKgwqAgNjUgNDggODkgMDQgMjUgMDAgMDAgMDAgMDDCoMKgwqDCoMKgIG1vdsKg
wqDCoCAlcmF4LCVnczoweDANCj4gDQo+IGJlY2F1c2Ugb2YgdGhlIHplcm9pbmcgaWRpb20gc3Bs
aXR0aW5nIHRoZXNlIDMgaW5zdHJ1Y3Rpb25zIGF3YXkgZnJvbQ0KPiB0aGUgcHJldmlvdXMgb3Bl
cmF0aW9uIG9uIHJheC4NCg0KSG93IGFib3V0Og0KCQkzMSBjMCAgICAgeG9yICVlYXgsJWVheA0K
CQlmOSAgICAgICAgc3RjDQoJCTQ4IGQxIGQ4ICByY3IgJDEsJXJheA0KU28gNiBieXRlcyB0b3Rh
bC4NCkJ1dCB0aGF0IG1pZ2h0IGJlIGEgcGFydGlhbCBkZXBlbmRlbmN5IG9uIGZsYWdzLg0KKEFs
dGhvdWdoIHRoYXQgaXNuJ3QgYW55IHdvcnNlIHRoYW4gdGhlIHhvci4pDQpJdCBpcyBhbHNvIGEg
bG9uZ2VyIGRlcGVuZGVuY3kgY2hhaW4gLSBzbyB0aGUgZXhlY3V0aW9uIHRpbWUNCnJhdGhlciBk
ZXBlbmRzIG9uIHdoYXQgZWxzZSBpcyBnb2luZyBvbi4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVy
ZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5
bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

