Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6400765B2F1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 14:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbjABNzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 08:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbjABNzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 08:55:12 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314CA6545
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 05:55:11 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-239-Pc-0eKEyPu6bdtk5ZckanA-1; Mon, 02 Jan 2023 13:55:08 +0000
X-MC-Unique: Pc-0eKEyPu6bdtk5ZckanA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 2 Jan
 2023 13:55:05 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Mon, 2 Jan 2023 13:55:05 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Kostya Serebryany" <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Rick Edgecombe" <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv13 05/16] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
Thread-Topic: [PATCHv13 05/16] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
Thread-Index: AQHZHLDUcIP+F/h/PEiAwEZ6SoBjkq6LJK3g
Date:   Mon, 2 Jan 2023 13:55:05 +0000
Message-ID: <4cf29f7a1a0041da818ac7ef598d142e@AcuMS.aculab.com>
References: <20221227030829.12508-1-kirill.shutemov@linux.intel.com>
 <20221227030829.12508-6-kirill.shutemov@linux.intel.com>
 <CAHk-=wgKTcOx1hhWAGJ-g9_9o7xiGJ9v9n2RskBSCkaUMBxDkw@mail.gmail.com>
 <20221231001029.5nckrhtmwahb65jo@box>
 <CAHk-=wgmGqwDD0kvjZxekU6uYR2x6+QgRHeMKy3snL2XYEzwEw@mail.gmail.com>
In-Reply-To: <CAHk-=wgmGqwDD0kvjZxekU6uYR2x6+QgRHeMKy3snL2XYEzwEw@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMzEgRGVjZW1iZXIgMjAyMiAwMDo0Mg0KPiAN
Ci4uLg0KPiBBbmQgb24gNjQtYml0LCB3ZSByZWFsbHkgb25seSBuZWVkIHRvIGNoZWNrIHRoZSBo
aWdoIGJpdC4NCj4gDQo+IEluIGZhY3QsIHdlIGRvbid0IGV2ZW4gd2FudCB0byAqY2hlY2sqIGl0
LCBiZWNhdXNlIHRoZW4gd2UgbmVlZCB0byBkbw0KPiB0aGF0IGRpc2d1c3RpbmcgYXJyYXlfaW5k
ZXhfbWFza19ub3NwZWMgdGhpbmcgdG8gbWFzayB0aGUgYml0cyBmb3IgaXQsDQo+IHNvIGl0IHdv
dWxkIGJlIGV2ZW4gYmV0dGVyIHRvIHVzZSBwdXJlbHkgYXJpdGhtZXRpYyB3aXRoIG5vDQo+IGNv
bmRpdGlvbmFscyBhbnl3aGVyZS4NCj4gDQo+IEFuZCB0aGF0J3MgZXhhY3RseSB3aGF0IHdlIGNv
dWxkIGRvIG9uIHg4Ni02NDoNCj4gDQo+ICAgICAgICAgbW92cSAlcmR4LCVyYXgNCj4gICAgICAg
ICBzaHJxICQ2MywlcmF4DQo+ICAgICAgICAgb3JxICVyYXgsJXJkeA0KPiANCj4gd291bGQgYWN0
dWFsbHkgYmUgbm90aWNlYWJseSBiZXR0ZXIgdGhhbiB3aGF0IHdlIGRvIG5vdyBmb3IgZm9yDQo+
IFRBU0tfU0laRSBjaGVja2luZyBfYW5kXyBmb3IgdGhlIGFycmF5IGluZGV4IG1hc2tpbmcgKGZv
ciBwdXR1c2VyLlMsDQo+IHdlJ2QgdXNlICVyYnggaW5zdGVhZCBvZiAlcmF4IGluIHRoYXQgc2Vx
dWVuY2UpLg0KLi4uDQo+IEl0IHdvdWxkIGp1c3QgdHVybiBhbGwga2VybmVsIGFkZHJlc3NlcyBp
bnRvIGFsbCBvbmVzLCB3aGljaCBpcyB0aGVuDQo+IGd1YXJhbnRlZWQgdG8gZmF1bHQuIFNvIG5v
IG5lZWQgZm9yIGFueSBjb25kaXRpb25hbCB0aGF0IG5ldmVyDQo+IHRyaWdnZXJzIGluIHJlYWwg
bGlmZSBhbnl3YXkuDQoNCkFyZSBieXRlIGxvYWRzIGd1YXJhbnRlZWQgdG8gZmF1bHQ/DQpJIHN1
c3BlY3QgdGhlICdhbGwgb25lcycgYWRkcmVzcyBjYW4gYmUgYXNzaWduZWQgdG8gaW8uDQpTbyBn
ZXQvcHV0X3VzZXIgZm9yIGEgYnl0ZSBwcm9iYWJseSBuZWVkcyBhICdqcycgdGVzdCBhZnRlciB0
aGUgJ29ycScuDQooSSBkb24ndCB0aGluayB5b3UgbmVlZCB0byB3b3JyeSBhYm91dCBhIGFwZWN1
bGF0aXZlIGxvYWQgZnJvbSBhbg0KdW5jYWNoZWQgYWRkcmVzcy4pDQoNCi4uLg0KPiBBbmQgb25j
ZSB3ZSBkb24ndCB0ZXN0IGFnYWluc3QgVEFTS19TSVpFLCB0aGUgbmVlZCBmb3IgVU5UQUdfQURE
UiBqdXN0DQo+IGdvZXMgYXdheSwgc28gbm93IExBTSBpcyBiZXR0ZXIgdG9vLg0KPiANCj4gSW4g
b3RoZXIgd29yZHMsIHdlIGNvdWxkIGFjdHVhbGx5IGltcHJvdmUgb24gb3VyIGN1cnJlbnQgY29k
ZSBfYW5kXw0KPiBzaW1wbGlmeSB0aGUgTEFNIHNpdHVhdGlvbi4gV2luLXdpbi4NCg0KUHJlc3Vt
YWJseSB0aGUgZmF1bHQgaGFuZGxlciBhbHJlYWR5IGhhcyB0aGUgY29kZSB0byB1bnRhZyBhZGRy
ZXNzZXMuDQoNCkl0IGhhcyB0byBiZSBzYWlkIHRoYXQgSSBkb24ndCByZWFsbHkgc2VlIHdoeSB0
YWdnaW5nIGFkZHJlc3NlcyBpcyBhDQpzaWduaWZpY2FudCBiZW5lZml0IHVubGVzcyB0aGUgaGFy
ZHdhcmUgY2hlY2tzIHRoYW4gdGhlIFBURS9UTEIgaXMNCmFsc28gc2V0IHdpdGggdGhlIGNvcnJl
Y3QgdGFnLg0KQWxsIGl0IHNlZW1zIHRvIG1lIHRoYXQgaXQgZG9lcyBpdCBtYWtlIG1vcmUgJ3Jh
bmRvbSBhZGRyZXNzZXMnIHZhbGlkLg0KDQpDbGVhcmx5IGludGVycHJldGVycyBjYW4gc2V0IGFu
ZCBjaGVjayB0aGUgaGlnaCBhZGRyZXNzIGJpdHMsIGJ1dCB0aGV5DQpjYW4gYWxzbyBtYXNrIHRo
ZW0gYWZ0ZXIgdGhlIGNoZWNrcyAob3IgdXNlIHhvciB0byBmbGlwIHRoZSBiaXRzIGFuZA0KbGV0
IHRoZSBjcHUgZmF1bHQgb24gZXJyb3JzKS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRk
cmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBN
SzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

