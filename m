Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D2A65BC55
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbjACIhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbjACIhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:37:51 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBC7D92
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:37:50 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-91-9nkBtqfRMfet6_rK_0JW4A-2; Tue, 03 Jan 2023 08:37:47 +0000
X-MC-Unique: 9nkBtqfRMfet6_rK_0JW4A-2
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 3 Jan
 2023 08:37:46 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Tue, 3 Jan 2023 08:37:46 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv13 05/16] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
Thread-Topic: [PATCHv13 05/16] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
Thread-Index: AQHZHLDUcIP+F/h/PEiAwEZ6SoBjkq6LJK3ggABcQgCAAN3HwA==
Date:   Tue, 3 Jan 2023 08:37:46 +0000
Message-ID: <35b24dab4dc5451a86ef87f93088e0b7@AcuMS.aculab.com>
References: <20221227030829.12508-1-kirill.shutemov@linux.intel.com>
 <20221227030829.12508-6-kirill.shutemov@linux.intel.com>
 <CAHk-=wgKTcOx1hhWAGJ-g9_9o7xiGJ9v9n2RskBSCkaUMBxDkw@mail.gmail.com>
 <20221231001029.5nckrhtmwahb65jo@box>
 <CAHk-=wgmGqwDD0kvjZxekU6uYR2x6+QgRHeMKy3snL2XYEzwEw@mail.gmail.com>
 <4cf29f7a1a0041da818ac7ef598d142e@AcuMS.aculab.com>
 <CAHk-=wgh9zNsFX0gSfMBfJBxOOTztsZ6NZc5pvzCikB1Gz8B3A@mail.gmail.com>
In-Reply-To: <CAHk-=wgh9zNsFX0gSfMBfJBxOOTztsZ6NZc5pvzCikB1Gz8B3A@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDIgSmFudWFyeSAyMDIzIDE5OjA1DQouLi4N
Cj4gPiBBcmUgYnl0ZSBsb2FkcyBndWFyYW50ZWVkIHRvIGZhdWx0Pw0KPiANCj4gWWVhaCwgd2Ug
ZG9uJ3QgbWFwIHRoZSBoaWdoZXN0IGFkZHJlc3Mgb24geDg2LTY0LiBBbmQgd2UgZG9uJ3Qgd2Fu
dCB0bw0KPiBpbiB0aGUgZnV0dXJlIGVpdGhlciwgYmVjYXVzZSBvZiBob3cgb3VyIGVycm9yIHBv
aW50ZXJzIHdvcmsgKGllIGlmDQo+IHNvbWVib2R5IG1pc3NlcyBhbiAiSVNfRVJSKCkiIGNoZWNr
IGFuZCB1c2VzIGFuIGVycm9yIHBvaW50ZXIgYXMgYQ0KPiBwb2ludGVyLCB3ZSB3YW50IHRoYXQg
dG8gZmF1bHQsIHJhdGhlciB0aGFuIGRvIHJhbmRvbSB0aGluZ3MpLg0KPiANCj4gSXQncyBub3Qg
YSBoYXJkIHJlcXVpcmVtZW50IGFyY2hpdGVjdHVyYWxseSAoZWl0aGVyIGhhcmR3YXJlIG9yDQo+
IHNvZnR3YXJlKSwgYW5kIGlpcmMgb24gMzItYml0IHdlIHVzZWQgdG8gdXNlIHRoZSBsYXN0IHZp
cnR1YWwgcGFnZSBmb3INCj4gc29tZXRoaW5nLCBzbyBtYXliZSBJJ20gbWlzc2luZyBzb21lIG9k
ZCB1c2Ugb24gNjQtYml0IHRvbywgYnV0DQo+IGFjY2Vzc2luZyB0aGUgdG9wLW9mLXZpcnR1YWwg
YWRkcmVzcyBzcGFjZSBvbiB4ODYtNjQgc2hvdWxkIGFsd2F5cw0KPiBjYXVzZSBhIGNsZWFyIGZh
dWx0IGFmYWlrLg0KPiANCj4gQSBieXRlIGFjY2VzcyB3b3VsZCBhbHdheXMgYmUgYSBwYWdlIGZh
dWx0LCB3aGlsZSBhIHdyYXBwaW5nIGFjY2Vzcw0KPiBtaWdodCB0cmlnZ2VyIGEgR1AgZmF1bHQg
Zmlyc3QgKHByb2JhYmx5IG5vdCAtIG9uIDMyLWJpdCBpdCB3b3VsZCBiZSBhDQo+IHNlZ21lbnQg
c2l6ZSB2aW9sYXRpb24sIG9uIDY0LWJpdCB3ZSd2ZSBsZWZ0IHRob3NlIGJhZCBvbGQgZGF5cyBi
ZWhpbmQNCj4gYW5kIEkgZG9uJ3QgdGhpbmsgd3JhcHBpbmcgbWF0dGVycyBlaXRoZXIpDQoNCkZv
ciBzb21lIHJlYXNvbiBJIHdhcyB0aGlua2luZyB5b3Ugd2VyZSByZWx5aW5nIG9uIHRoZSB3cmFw
cGluZyBhY2Nlc3MuDQoNClRoZSBvdGhlciBjaGVjayBpcyBhY2Nlc3Nfb2soKSBmb3IgbG9uZ2Vy
IGNvcGllcy4NCklmIHlvdSBtYWtlIHRoZSBhc3N1bXB0aW9uIHRoYXQgdGhlIGNvcHkgaXMgJ3Jl
YXNvbmFibHkgc2VxdWVudGlhbCcNCnRoZW4gdGhlIGxlbmd0aCBjYW4gYmUgaWdub3JlZCBwcm92
aWRlZCB0aGF0IHRoZSBib3R0b20gb2YgJ2tlcm5lbA0Kc3BhY2UnIGlzIHVubWFwcGVkLg0KRm9y
IHg4Ni02NCB0cmVhdGluZyAtdmUgdmFsdWVzIGFzIGtlcm5lbCB0aGF0IGlzIHByZXR0eSB0cnVl
Lg0KMzItYml0IHdvdWxkIG5lZWQgYXQgbGVhc3Qgb25lIHVubWFwcGVkIHBhZ2UgYmV0d2VlbiB1
c2VyIGFuZCBrZXJuZWwuDQpJIHN1c3BlY3QgdGhlIGtlcm5lbCBpcyBsb2FkZWQgYXQgMHhjMDAw
MDAwMCBtYWtpbmcgdGhhdCBkaWZmaWN1bHQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFk
ZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywg
TUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

