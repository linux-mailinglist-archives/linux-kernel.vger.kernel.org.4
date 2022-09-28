Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704125EE1AF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbiI1QUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbiI1QUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:20:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89671ADAA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:20:04 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-50-e1uNPggpM8-UOm_MCvz0uA-1; Wed, 28 Sep 2022 17:20:01 +0100
X-MC-Unique: e1uNPggpM8-UOm_MCvz0uA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 28 Sep
 2022 17:19:51 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Wed, 28 Sep 2022 17:19:51 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Qais Yousef' <qais.yousef@arm.com>
CC:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Connor O'Brien <connoro@google.com>,
        "Rick Yiu" <rickyiu@google.com>, John Kacur <jkacur@redhat.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: RE: [RFC][PATCH v3 0/3] Softirq -rt Optimizations
Thread-Topic: [RFC][PATCH v3 0/3] Softirq -rt Optimizations
Thread-Index: AQHY0zpmJr2Dk0yW7UGHJ33kyoWYZa300JwAgAAd3ACAABOvMA==
Date:   Wed, 28 Sep 2022 16:19:51 +0000
Message-ID: <c5c8218e587941bc91a2cc49883235d0@AcuMS.aculab.com>
References: <20220921012550.3288570-1-jstultz@google.com>
 <20220928130043.d6ijyxbq43tfvqg7@wubuntu>
 <529cd76702b44678a4d4abe539105942@AcuMS.aculab.com>
 <20220928155618.ylyns4x4tog34zui@wubuntu>
In-Reply-To: <20220928155618.ylyns4x4tog34zui@wubuntu>
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

RnJvbTogUWFpcyBZb3VzZWYNCj4gU2VudDogMjggU2VwdGVtYmVyIDIwMjIgMTY6NTYNCj4gDQo+
IE9uIDA5LzI4LzIyIDEzOjUxLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4gRnJvbTogUWFpcyBZ
b3VzZWYNCj4gPiA+IFNlbnQ6IDI4IFNlcHRlbWJlciAyMDIyIDE0OjAxDQo+ID4gPg0KPiA+ID4g
SGkgSm9obg0KPiA+ID4NCj4gPiA+IE9uIDA5LzIxLzIyIDAxOjI1LCBKb2huIFN0dWx0eiB3cm90
ZToNCj4gPiA+ID4gSGV5IGFsbCwNCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyBzZXJpZXMgaXMgYSBz
ZXQgb2YgcGF0Y2hlcyB0aGF0IG9wdGltaXplIHNjaGVkdWxlciBkZWNpc2lvbnMgYXJvdW5kDQo+
ID4gPiA+IHJlYWx0aW1lIHRhc2tzIGFuZCBzb2Z0aXJxcy4gIFRoaXMgc2VyaWVzIGlzIGEgcmVi
YXNlZCBhbmQgcmV3b3JrZWQgc2V0DQo+ID4gPiA+IG9mIGNoYW5nZXMgdGhhdCBoYXZlIGJlZW4g
c2hpcHBpbmcgb24gQW5kcm9pZCBkZXZpY2VzIGZvciBhIG51bWJlciBvZg0KPiA+ID4gPiB5ZWFy
cywgb3JpZ2luYWxseSBjcmVhdGVkIHRvIHJlc29sdmUgYXVkaW8gZ2xpdGNoZXMgc2VlbiBvbiBk
ZXZpY2VzDQo+ID4gPiA+IGNhdXNlZCBieSBzb2Z0aXJxcyBmb3IgbmV0d29yayBvciBzdG9yYWdl
IGRyaXZlcnMuDQo+ID4gPiA+DQo+ID4gPiA+IExvbmcgcnVubmluZyBzb2Z0aXJxcyBjYXVzZSBp
c3N1ZXMgYmVjYXVzZSB0aGV5IGFyZW7igJl0IGN1cnJlbnRseSB0YWtlbg0KPiA+ID4gPiBpbnRv
IGFjY291bnQgd2hlbiBhIHJlYWx0aW1lIHRhc2sgaXMgd29rZW4gdXAsIGJ1dCB0aGV5IHdpbGwg
ZGVsYXkNCj4gPiA+ID4gcmVhbHRpbWUgdGFza3MgZnJvbSBydW5uaW5nIGlmIHRoZSByZWFsdGlt
ZSB0YXNrcyBhcmUgcGxhY2VkIG9uIGEgY3B1DQo+ID4gPiA+IGN1cnJlbnRseSBydW5uaW5nIGEg
c29mdGlycS4NCj4gPiA+DQo+ID4gPiBUaGFua3MgYSBsb3QgZm9yIHNlbmRpbmcgdGhpcyBzZXJp
ZXMuIEkndmUgcmFpc2VkIHRoaXMgcHJvYmxlbSBpbiB2YXJpb3VzDQo+ID4gPiB2ZW51ZXMgaW4g
dGhlIHBhc3QsIGJ1dCBpdCBzZWVtcyBpdCBpcyBoYXJkIHRvIGRvIHNvbWV0aGluZyBiZXR0ZXIg
dGhhbiB3aGF0DQo+ID4gPiB5b3UgcHJvcG9zZSBoZXJlLg0KPiA+ID4NCj4gPiA+IEJvcnJvd2lu
ZyBzb21lIGJlaGF2aW91cnMgZnJvbSBQUkVFTVBUX1JUIChsaWtlIHRocmVhZGVkaXJxcykgd29u
J3QgY3V0IGl0DQo+ID4gPiBvdXRzaWRlIFBSRUVNUFRfUlQgQUZBSVUuDQo+ID4gPg0KPiA+ID4g
UGV0ZXIgZGlkIHN1Z2dlc3QgYW4gYWx0ZXJuYXRpdmUgYXQgb25lIHBvaW50IGluIHRoZSBwYXN0
IHRvIGJlIG1vcmUgYWdncmVzc2l2ZQ0KPiA+ID4gaW4gbGltaXRpbmcgc29mdGlycXMgWzFdIGJ1
dCBJIG5ldmVyIG1hbmFnZWQgdG8gZmluZCB0aGUgdGltZSB0byB2ZXJpZnkgaXQNCj4gPiA+IC0g
ZXNwZWNpYWxseSBpdHMgaW1wYWN0IG9uIG5ldHdvcmsgdGhyb3VnaHB1dCBhcyB0aGlzIHNlZW1z
IHRvIGJlIHRoZSB0cmlja3kNCj4gPiA+IHRyYWRlLW9mIChhbmQgdHJpY2t5IHRoaW5nIHRvIHZl
cmlmeSBmb3IgbWUgYXQgbGVhc3QpLiBJJ20gbm90IHN1cmUgaWYgQkxPQ0sNCj4gPiA+IHNvZnRp
cnFzIGFyZSBhcyBzZW5zaXRpdmUuDQo+ID4NCj4gPiBJJ3ZlIGhhZCBpc3N1ZXMgd2l0aCB0aGUg
b3Bwb3NpdGUgcHJvYmxlbS4NCj4gPiBMb25nIHJ1bm5pbmcgUlQgdGFza3Mgc3RvcHBpbmcgdGhl
IHNvZnRpbnQgY29kZSBydW5uaW5nLg0KPiA+DQo+ID4gSWYgYW4gUlQgdGFzayBpcyBydW5uaW5n
LCB0aGUgc29mdGludCB3aWxsIHJ1biBpbiB0aGUgY29udGV4dCBvZiB0aGUNCj4gPiBSVCB0YXNr
IC0gc28gaGFzIHByaW9yaXR5IG92ZXIgaXQuDQo+ID4gSWYgdGhlIFJUIHRhc2sgaXNuJ3QgcnVu
bmluZyB0aGUgc29mdGludCBzdG9wcyB0aGUgUlQgdGFzayBiZWluZyBzY2hlZHVsZWQuDQo+ID4g
VGhpcyBpcyByZWFsbHkganVzdCB0aGUgc2FtZS4NCj4gPg0KPiA+IElmIHRoZSBzb2Z0aW50IGRl
ZmVycyBiYWNrIHRvIHRocmVhZCBjb250ZXh0IGl0IHdvbid0IGJlIHNjaGVkdWxlZA0KPiA+IHVu
dGlsIGFueSBSVCB0YXNrIGZpbmlzaGVzLiBUaGlzIGlzIHRoZSBvcHBvc2l0ZSBwcmlvcml0eS4N
Cj4gDQo+IElmIHdlIGNhbiBnZXQgYSBzdWJzZXQgb2YgdGhyZWFkZWRpcnFzIChjYWxsIGl0IHRo
cmVhZGVkc29mdGlycXMpIGZyb20NCj4gUFJFRU1QVF9SVCB3aGVyZSBzb2Z0aXJxcyBjYW4gYmUg
Y29udmVydGVkIGludG8gUlQga3RocmVhZHMsIHRoYXQnbGwgYWxsZXZpYXRlDQo+IGJvdGggc2lk
ZXMgb2YgdGhlIHByb2JsZW0gSU1PLiBCdXQgbGFzdCBJIGNoZWNrZWQgd2l0aCBUaG9tYXMgdGhp
cyB3b24ndCBiZQ0KPiBwb3NzaWJsZS4gQnV0IHRoaW5ncyBtaWdodCBoYXZlIGNoYW5nZWQgc2lu
Y2UgdGhlbi4uDQoNClBhcnQgb2YgdGhlIHByb2JsZW0gaXMgdGhhdCBjYW4gc2lnbmlmaWNhbnRs
eSBpbmNyZWFzZSBsYXRlbmN5Lg0KU29tZSBzb2Z0aXJxIGNhbGxzIHdpbGwgYmUgbGF0ZW5jeSBz
ZW5zaXRpdmUuDQoNCj4gPiBJSVJDIHRoZXJlIGlzIGFub3RoZXIgc3RyYW5nZSBjYXNlIHdoZXJl
IHRoZSBSVCB0aHJlYWQgaGFzIGJlZW4gd29rZW4NCj4gPiBidXQgaXNuJ3QgeWV0IHJ1bm5pbmcg
LSBjYW4ndCByZW1lbWJlciB0aGUgZXhhY3QgZGV0YWlscy4NCj4gPg0KPiA+IEkgY2FuIChtb3N0
bHkpIGhhbmRsZSB0aGUgUlQgdGFzayBiZWluZyBkZWxheWVkICh0aGVyZSBhcmUgYSBsb3Qgb2Yg
UlQNCj4gPiB0aHJlYWRzIHNoYXJpbmcgdGhlIHdvcmspIGJ1dCBpdCBpcyBwYXJhbW91bnQgdGhh
dCB0aGUgZXRoZXJuZXQgcmVjZWl2ZQ0KPiA+IGNvZGUgYWN0dWFsbHkgcnVucyAtIEkgY2FuJ3Qg
YWZmb3JkIHRvIGRyb3AgcGFja2V0cyAodGhleSBjb250YWluIGF1ZGlvDQo+ID4gdGhlIFJUIHRo
cmVhZHMgYXJlIHByb2Nlc3NpbmcpLg0KPiA+DQo+ID4gSW4gbXkgY2FzZSB0aHJlYWRlZCBOQVBJ
IChtb3N0bHkpIGZpeGVzIGl0IC0gcHJvdmlkZWQgdGhlIE5BUEkgdGhyZWFkIGFyZSBSVC4NCj4g
DQo+IFRoZXJlJ3MgYSBuZXRkZXZfYnVkZ2V0IGFuZCBuZXRkZXZfYnVnZGV0X3VzZWNzIHBhcmFt
cyBpbiBwcm9jZnMgdGhhdCBjb250cm9sDQo+IGhvdyBsb25nIHRoZSBORVRfUlggc3BlbmRzIGlu
IHRoZSBzb2Z0aXJxLiBNYXliZSB5b3UgbmVlZCB0byB0d2VhayB0aG9zZSB0b28uDQo+IEluIHlv
dXIgY2FzZSwgeW91IHByb2JhYmx5IHdhbnQgdG8gaW5jcmVhc2UgdGhlIGJ1ZGdldC4NCg0KTWF5
YmUsIGJ1dCB0aGUgcHJvYmxlbSBpcyB0aGF0IHRoZSBzb2Z0aW50IGNvZGUgaXMgZmFyIHRvbyB3
aWxsaW5nDQp0byBkcm9wIHRvIGt0aHJlYWQgY29udGV4dC4NCkVyaWMgbWFkZSBhIGNoYW5nZSB0
byByZWR1Y2UgdGhhdCAodG8gYXZvaWQgbG9zaW5nIGV0aGVybmV0IHBhY2tldHMpDQpidXQgdGhl
IG9yaWdpbmFsIHRlc3QgZ290IGFkZGVkIGJhY2sgLSB0aGVyZSBhcmUgbm93IHR3byB0ZXN0cywg
YnV0DQp0aGUgb3JpZ2luYWwgb25lIGRvbWluYXRlcy4gRXJpYydzIGJ1ZyBmaXggZ290IHJldmVy
dGVkICh3aXRoIGV4dHJhDQp0ZXN0cyB0aGF0IG1ha2UgdGhlIGNvZGUgc2xvd2VyKS4NCg0KSSBk
aWQgdGVzdCB3aXRoIHRoYXQgY2hhbmdlZCwgYnV0IHN0aWxsIGdvdCBzb21lIGxvc3QgcGFja2V0
cy4NClRyeWluZyB0byByZWNlaXZlIDUwMDAwMCBVRFAgcGFja2V0cy9zZWMgaXMgcXVpdGUgaGFy
ZCENClRoZXkgYXJlIGFsc28gc3BsaXQgYWNyb3NzIDEwayB1bmNvbm5lY3RlZCBzb2NrZXRzLg0K
DQo+IE5vdGUgdGhhdCBpbiBBbmRyb2lkIHRoZSBCTE9DSyBsYXllciBzZWVtcyB0byBjYXVzZSBz
aW1pbGFyIHByb2JsZW1zIHdoaWNoDQo+IGRvbid0IGhhdmUgdGhlc2UgTkVUIGZhY2lsaXRpZXMu
IFNvIE5FVCBpcyBvbmx5IG9uZSBzaWRlIG9mIHRoZSBwcm9ibGVtLg0KDQpJc24ndCB0aGUgYmxv
Y2sgbGF5ZXIgc29mdGludHMgc3RvcHBpbmcgb3RoZXIgY29kZT8NCkknZCByZWFsbHkgZ290IHRo
ZSBvdGhlciBwcm9ibGVtLg0KQWx0aG91Z2ggSSBkbyBoYXZlIGEgMTBtcyB0aW1lciB3YWtldXAg
dGhhdCByZWFsbHkgbmVlZHMgbm90IHRvIGJlIGRlbGF5ZWQuDQoNCglEYXZpZA0KDQotDQpSZWdp
c3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9u
IEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

