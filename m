Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419425F4057
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJDJwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiJDJv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:51:29 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B58B14086
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:50:28 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-255-MG7cYJhuPgCC3BXGXVgJRg-1; Tue, 04 Oct 2022 10:50:25 +0100
X-MC-Unique: MG7cYJhuPgCC3BXGXVgJRg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 4 Oct
 2022 10:50:23 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Tue, 4 Oct 2022 10:50:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'John Stultz' <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Connor O'Brien <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
        Chris Redpath <chris.redpath@arm.com>,
        "Abhijeet Dharmapurikar" <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "J . Avila" <elavila@google.com>
Subject: RE: [RFC PATCH v3 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
Thread-Topic: [RFC PATCH v3 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
Thread-Index: AQHY10jsHNFiDQffOUaXThhlaEqTKa39+a/w
Date:   Tue, 4 Oct 2022 09:50:23 +0000
Message-ID: <efbeb4b069384aa39a80d606d14ec833@AcuMS.aculab.com>
References: <20220921012550.3288570-1-jstultz@google.com>
 <20220921012550.3288570-3-jstultz@google.com>
 <20220928125517.ei64pxfucaem55cr@wubuntu>
 <CANDhNCpLp+St4U_fjs+W8HXT-2ff4gpkx0P6vDnrX0CcesiQfA@mail.gmail.com>
In-Reply-To: <CANDhNCpLp+St4U_fjs+W8HXT-2ff4gpkx0P6vDnrX0CcesiQfA@mail.gmail.com>
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

RnJvbTogSm9obiBTdHVsdHoNCj4gU2VudDogMDMgT2N0b2JlciAyMDIyIDE3OjU1DQo+IA0KPiBP
biBXZWQsIFNlcCAyOCwgMjAyMiBhdCA1OjU1IEFNIFFhaXMgWW91c2VmIDxxYWlzLnlvdXNlZkBh
cm0uY29tPiB3cm90ZToNCj4gPiBPbiAwOS8yMS8yMiAwMToyNSwgSm9obiBTdHVsdHogd3JvdGU6
DQo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pbnRlcnJ1cHQuaCBiL2luY2x1ZGUv
bGludXgvaW50ZXJydXB0LmgNCj4gPiA+IGluZGV4IGE3NDlhODY2Mzg0MS4uMWQxMjZiODQ5NWJj
IDEwMDY0NA0KPiA+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9pbnRlcnJ1cHQuaA0KPiA+ID4gKysr
IGIvaW5jbHVkZS9saW51eC9pbnRlcnJ1cHQuaA0KPiA+ID4gQEAgLTU4Miw2ICs1ODIsMTIgQEAg
ZW51bQ0KPiA+ID4gICAqIF8gSVJRX1BPTEw6IGlycV9wb2xsX2NwdV9kZWFkKCkgbWlncmF0ZXMg
dGhlIHF1ZXVlDQo+ID4gPiAgICovDQo+ID4gPiAgI2RlZmluZSBTT0ZUSVJRX0hPVFBMVUdfU0FG
RV9NQVNLIChCSVQoUkNVX1NPRlRJUlEpIHwgQklUKElSUV9QT0xMX1NPRlRJUlEpKQ0KPiA+ID4g
Ky8qIFNvZnRpcnEncyB3aGVyZSB0aGUgaGFuZGxpbmcgbWlnaHQgYmUgbG9uZzogKi8NCj4gPiA+
ICsjZGVmaW5lIExPTkdfU09GVElSUV9NQVNLICgoMSA8PCBORVRfVFhfU09GVElSUSkgICAgICAg
fCBcDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgKDEgPDwgTkVUX1JYX1NPRlRJUlEp
ICAgICAgIHwgXA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICgxIDw8IEJMT0NLX1NP
RlRJUlEpICAgICAgICB8IFwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAoMSA8PCBJ
UlFfUE9MTF9TT0ZUSVJRKSB8IFwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAoMSA8
PCBUQVNLTEVUX1NPRlRJUlEpKQ0KPiA+DQo+ID4gSSdtIG5vdCBzdXJlIGFib3V0IHRoZSBUQVNL
TEVULiBJIGNhbiB1bmRlcnN0YW5kIE5FVCBhbmQgQkxPQ0sgcmVxdWlyZSBoaWdoDQo+ID4gdGhy
b3VnaHB1dCwgaGVuY2UgY291bGQgZW5kIHVwIGluIHNvZnRpcnEgZm9yIGEgbG9uZyB0aW1lLiBC
dXQgVEFTS0xFVCBzZWVtcw0KPiA+IGFsbG93aW5nIHNsb3BwaW5lc3MuIEkgZG9uJ3QgZmVlbCBz
dHJvbmdseSBhYm91dCBpdCwgYnV0IHdvcnRoIGRlYmF0aW5nIGlmIHdlDQo+ID4gcmVhbGx5IG5l
ZWQgdG8gaW5jbHVkZSBpdC4NCj4gDQo+IFRoYXQncyBmYWlyLiBEaWdnaW5nIHRocm91Z2ggdGhl
IHBhdGNoIGhpc3RvcnkgaW4gdGhlIEFuZHJvaWQgdHJlZXMsDQo+IHRoZSBmaXJzdCBwYXNzIHdh
cyBmb3IgYWxsIHNvZnRpcnFzIGJ1dCB0aGVuIHJlc3RyaWN0ZWQgdG8gcmVtb3ZlDQo+IGtub3du
IHNob3J0LXJ1bm5pbmcgb25lcy4NCj4gRnJvbSB0aGUgYnVnIGhpc3RvcnkgYW5kIHdoYXQgSSBj
YW4gZGlyZWN0bHkgcmVwcm9kdWNlLCB0aGUgbmV0IGFuZA0KPiBibG9jayBzb2Z0aXJxcyBoYXZl
IGRlZmluaXRlbHkgY2F1c2VkIHRyb3VibGUsIGJ1dCBJIGRvbid0IHNlZSBhDQo+IHNwZWNpZmlj
IGV4YW1wbGUgZnJvbSBUQVNLTEVULCAgc28gSSdtIG9rIGRyb3BwaW5nIHRoYXQgZm9yIG5vdywg
YW5kDQo+IHNob3VsZCB3ZSBnZXQgc3BlY2lmaWMgZXZpZGVuY2Ugd2UgY2FuIGFyZ3VlIGZvciBp
dCBpbiBhIGZ1dHVyZSBwYXRjaC4NCj4gDQo+IFNvIEknbGwgZHJvcCBUQVNLTEVUIGZyb20gdGhl
IGxpc3QgaGVyZS4gVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbiENCg0KSSd2ZSBhbHNvIHNlZW4g
dGhlIGNvZGUgdGhhdCBmaW5hbGx5IGZyZWVzIG1lbW9yeSBmcmVlZCB1bmRlciByY3UNCnRha2Ug
YSBsb25nIHRpbWUuDQpUaGF0IHdhcyBhIHdvcmtsb2FkIHNlbmRpbmcgYSBsb3Qgb2YgVURQL1JU
UCBmcm9tIGEgcmF3IHNvY2tldCB1c2luZw0KSVBfSERSSU5DIC0gZWFjaCBzZW5kIGFsbG9jYXRl
ZCBhIHN0cnVjdHVyZSAoZmliPykgdGhhdCB3YXMgZnJlZWQgZnJvbQ0KdGhlIHJjdSAodGltZXI/
KSBzb2Z0aW50IGNhbGxiYWNrLg0KDQpCdXQsIGFjdHVhbGx5LCBvbmUgb2YgdGhlIGJpZ2dlc3Qg
Y2F1c2VzIG9mIFJUIHdha2V1cCBsYXRlbmN5DQp3YXMgYSBub3JtYWwgdGhyZWFkIGxvb3Bpbmcg
d2l0aG91dCBhIGNvbmRfcmVzY2hlZCgpIGNhbGwuDQpJbiBteSBjYXNlIHNvbWUgZ3JhcGhpY3Mg
ZHJpdmVyIGRvaW5nIHBhZ2UgZmx1c2hlcyBvZiB0aGUNCmRpc3BsYXkgbWVtb3J5Lg0KDQouLi4N
Cj4gPiA+ICAgICAgICAgICAgICAgaW50IHRhcmdldCA9IGZpbmRfbG93ZXN0X3JxKHApOw0KPiA+
ID4gQEAgLTE2NTYsMTEgKzE2OTksMTQgQEAgc2VsZWN0X3Rhc2tfcnFfcnQoc3RydWN0IHRhc2tf
c3RydWN0ICpwLCBpbnQgY3B1LCBpbnQgZmxhZ3MpDQo+ID4gPiAgICAgICAgICAgICAgICAgICAg
ICAgZ290byBvdXRfdW5sb2NrOw0KPiA+ID4NCj4gPiA+ICAgICAgICAgICAgICAgLyoNCj4gPiA+
IC0gICAgICAgICAgICAgICogRG9uJ3QgYm90aGVyIG1vdmluZyBpdCBpZiB0aGUgZGVzdGluYXRp
b24gQ1BVIGlzDQo+ID4gPiArICAgICAgICAgICAgICAqIElmIGNwdSBpcyBub24tcHJlZW1wdGli
bGUsIHByZWZlciByZW1vdGUgY3B1DQo+ID4gPiArICAgICAgICAgICAgICAqIGV2ZW4gaWYgaXQn
cyBydW5uaW5nIGEgaGlnaGVyLXByaW8gdGFzay4NCj4gPiA+ICsgICAgICAgICAgICAgICogT3Ro
ZXJ3aXNlOiBEb24ndCBib3RoZXIgbW92aW5nIGl0IGlmIHRoZSBkZXN0aW5hdGlvbiBDUFUgaXMN
Cj4gPiA+ICAgICAgICAgICAgICAgICogbm90IHJ1bm5pbmcgYSBsb3dlciBwcmlvcml0eSB0YXNr
Lg0KPiA+ID4gICAgICAgICAgICAgICAgKi8NCj4gPiA+ICAgICAgICAgICAgICAgaWYgKHRhcmdl
dCAhPSAtMSAmJg0KPiA+ID4gLSAgICAgICAgICAgICAgICAgcC0+cHJpbyA8IGNwdV9ycSh0YXJn
ZXQpLT5ydC5oaWdoZXN0X3ByaW8uY3VycikNCj4gPiA+ICsgICAgICAgICAgICAgICAgIChtYXlf
bm90X3ByZWVtcHQgfHwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICBwLT5wcmlvIDwgY3B1X3Jx
KHRhcmdldCktPnJ0LmhpZ2hlc3RfcHJpby5jdXJyKSkNCj4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICBjcHUgPSB0YXJnZXQ7DQo+ID4NCj4gPiBJJ20gbm90IHN1cmUgdGhpcyBtYWtlcyBzZW5z
ZS4gWW91IGFzc3VtZSBhIGhpZ2hlciBwcmlvcml0eSB0YXNrIHdpbGwgY2F1c2UNCj4gPiBsZXNz
IGRlbGF5IHRoYW4gc29mdGlycXMuIFdoaWNoIEkgdGhpbmsgaXMgYW4gb3B0aW1pc3RpYyBhc3N1
bXB0aW9uPw0KPiA+DQo+ID4gSSB0aGluayB3ZSBzaG91bGQganVzdCBtaW1pYyB0aGUgc2FtZSBm
YWxsYmFjayBiZWhhdmlvciB3aGVuIHdlIGZhaWwgdG8gZmluZA0KPiA+IGEgQ1BVIHRoYXQgZml0
cyB0aGUgY2FwYWNpdHkgcmVxdWlyZW1lbnQuIEtlZXBzIHRoaW5ncyBtb3JlIGNvbnNpc3RlbnQg
SU1PLg0KPiANCj4gVGhpcyBzb3VuZHMgcmVhc29uYWJsZS4gIEkgZG8gZnJldCB0aGF0IGxvbmct
cnVubmluZyBydCB0YXNrcyBhcmUgbGVzcw0KPiBjb21tb24gdGhlbiB0aGUgbG9uZyBydW5uaW5n
IHNvZnRpcnFzLCBzbyB0aGlzIG1heSBoYXZlIGFuIGltcGFjdCB0bw0KPiB0aGUgZWZmZWN0aXZl
bmVzcyBvZiB0aGUgcGF0Y2gsIGJ1dCBJIGFsc28gc3VzcGVjdCBpdCdzIGV2ZW4gbW9yZSByYXJl
DQo+IHRvIGhhdmUgYWxsIHRoZSBvdGhlciBjcHVzIGJ1c3kgd2l0aCBydCB0YXNrcywgc28gaXRz
IHByb2JhYmx5IHZlcnkNCj4gdW5saWtlbHkuDQoNCkkndmUgYSB3b3JrbG9hZCB0aGF0IGlzIHZl
cnkgbXVjaCBsaWtlIHRoYXQgOi0pDQpUaGUgc2FtZSBSVFAgYXVkaW8gcHJvZ3JhbS4NClJ1bm5p
bmcgMzUgUlQgdGhyZWFkcyAob24gNDAgY3B1KSB0aGF0IGFsbCBtaWdodCBydW4gZm9yDQo5bXMg
aW4gZXZlcnkgMTBtcy4NClRoZSBvdGhlciA1IGNwdSBtaWdodCBhbHNvIGJlIHJ1bm5pbmcgUlQg
dGhyZWFkcyBzaW5jZSBJDQpoYXZlIHRvIHVzZSB0aHJlYWRlZCBOQVBJIGFuZCBtYWtlIHRoZSBO
QVBJIHRocmVhZHMgUlQNCmluIG9yZGVyIHRvIGF2b2lkIGRyb3BwaW5nIHBhY2tldHMuDQpNb3N0
IG9mIHRoZSB3YWtldXBzIGNhbiBqdXN0IHdhaXQgZm9yIHRoZSBwcmV2aW91cyBjcHUNCnRvIGJl
Y29tZSBhdmFpbGFibGUsIG9ubHkgdGhlIHNsZWVwIG9uIGEgaGlnaC1yZXMgdGltZXINCndvdWxk
IGJlbmVmaXQgZnJvbSBjaGFuZ2luZyB0aGUgY3B1Lg0KDQpUaGUgcmVhbCBzY2hlZHVsaW5nIHBy
b2JsZW0gd2Fzbid0IGFjdHVhbGx5IHdha2V1cHMgYXQgYWxsLg0KVGhlIHByb2JsZW0gaXMgdGhl
IHNvZnRpbnQgY29kZSBydW5uaW5nIHdoaWxlIHRoZSBSVCB0aHJlYWQNCmhlbGQgYSBjdiAtIHdo
aWNoIHN0b3BwZWQgYWxsIHRoZSBvdGhlciB0aHJlYWRzIGluIHRoZWlyDQp0cmFja3MuDQpJIGhh
ZCB0byByZXBsYWNlIGFsbCB0aGUgJ2hvdCcgY3Ygd2l0aCBhdG9taWMgb3BlcmF0aW9ucy4NCg0K
VGhlIG9ubHkgJ3dha2V1cCcgcHJvYmxlbSBJIGhhZCB3YXMgdGhhdCBjdl9icm9hZGNhc3QoKSB3
b2tlDQplYWNoIFJUIHRhc2sgaW4gdHVybiAtIHNvIGlmIG9uZSB3YWl0ZWQgZm9yIHRoZSBzb2Z0
aW50IGNvZGUNCnRvIGZpbmlzaCB0aGVuIHNvIHdvdWxkIGFsbCB0aGUgcmVzdC4NCihGaXhlZCBi
eSB1c2luZyBhIHNlcGFyYXRlIGN2IGZvciBlYWNoIHRocmVhZC4pDQoNCglEYXZpZA0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=

