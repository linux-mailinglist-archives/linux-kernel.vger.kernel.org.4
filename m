Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329BB60CA31
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiJYKgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbiJYKgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:36:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A03C19C33
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:36:21 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-262-G6iVHj6SMLOPnkHFIe-Tag-1; Tue, 25 Oct 2022 11:36:18 +0100
X-MC-Unique: G6iVHj6SMLOPnkHFIe-Tag-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 25 Oct
 2022 11:36:16 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Tue, 25 Oct 2022 11:36:16 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ian Rogers' <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: RE: [PATCH v1 0/8] Update to C11, fix signal undefined behavior
Thread-Topic: [PATCH v1 0/8] Update to C11, fix signal undefined behavior
Thread-Index: AQHY5+lTLr/+qf0VWkOOFBdGRxn7ca4e6Yww
Date:   Tue, 25 Oct 2022 10:36:16 +0000
Message-ID: <7b0769b35f124869b4e30ddcc20a5985@AcuMS.aculab.com>
References: <20221024173523.602064-1-irogers@google.com>
 <Y1bQlxxABicj4k3+@kernel.org>
 <CAP-5=fWPdmHPXc9D2LP6TVmhuNf93gZCnogWXCVGytkhuqi2uQ@mail.gmail.com>
 <CAP-5=fVGicObnifnUzDXjbkGOVtmNaLKcfqpGeTwnFw2zsOuDQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVGicObnifnUzDXjbkGOVtmNaLKcfqpGeTwnFw2zsOuDQ@mail.gmail.com>
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
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSWFuIFJvZ2Vycw0KPiBTZW50OiAyNCBPY3RvYmVyIDIwMjIgMTk6MTINCj4gDQo+IE9u
IE1vbiwgT2N0IDI0LCAyMDIyIGF0IDEwOjU5IEFNIElhbiBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xl
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBNb24sIE9jdCAyNCwgMjAyMiBhdCAxMDo1MSBBTSBB
cm5hbGRvIENhcnZhbGhvIGRlIE1lbG8NCj4gPiA8YWNtZUBrZXJuZWwub3JnPiB3cm90ZToNCj4g
PiA+DQo+ID4gPiBFbSBNb24sIE9jdCAyNCwgMjAyMiBhdCAxMDozNToxNUFNIC0wNzAwLCBJYW4g
Um9nZXJzIGVzY3JldmV1Og0KPiA+ID4gPiBUaGUgdXNlIG9mIEMxMSBpcyBtYWluc3RyZWFtIGlu
IHRoZSBrZXJuZWwgWzFdLiBUaGVyZSB3YXMgc29tZQ0KPiA+ID4gPiBjb25mdXNpb24gb24gdm9s
YXRpbGUgYW5kIHNpZ25hbCBoYW5kbGVycyBpbiBbMl0uIFN3aXRjaCB0byB1c2luZw0KPiA+ID4g
PiBzdGRhdG9taWMuaCAocmVxdWlyZXMgQzExKSBhbmQgc2lnX2F0b21pY190IGFzIHBlciBbM10u
IFRoYW5rcyB0byBMZW8NCj4gPiA+ID4gWWFuIDxsZW8ueWFuQGxpbmFyby5vcmc+IGZvciB0aGUg
c3VnZ2VzdGlvbnMuDQo+ID4gPiA+DQo+ID4gPiA+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sa21sL0NBSGstPXdoV2JFTlJ6LQ0KPiB2TFk2dnBFU0RMajZrR1VUS08za2hHdFZmaXBIcXdl
d2gySFFAbWFpbC5nbWFpbC5jb20vDQo+ID4gPiA+IFsyXSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sa21sLzIwMjIxMDI0MDExMDI0LjQ2MjUxOC0xLWlyb2dlcnNAZ29vZ2xlLmNvbS8NCj4gPiA+
ID4gWzNdIGh0dHBzOi8vd2lraS5zZWkuY211LmVkdS9jb25mbHVlbmNlL2Rpc3BsYXkvYy9TSUcz
MS0NCj4gQy4rRG8rbm90K2FjY2VzcytzaGFyZWQrb2JqZWN0cytpbitzaWduYWwraGFuZGxlcnMN
Cj4gPiA+DQo+ID4gPiBJIHRoaW5rIEknbGwgYXBwbHkgdGhpcyB0byBwZXJmL2NvcmUsIGkuZS4g
Zm9yIDYuMywgb2s/DQo+ID4NCj4gPiBTb3VuZHMgZ29vZCB0byBtZS4gNi4zIG9yIDYuMj8gSSBz
dXNwZWN0IHRoZXJlIGlzIG1vcmUgY2xlYW51cCBsaWtlDQo+ID4gdGhpcyBhbmQgdG8gdGhlIGl0
ZXJhdG9ycyAoZnJvbSBDMTEpIHRoYXQgY2FuIGJlIGRvbmUuDQo+ID4NCj4gPiBUaGFua3MsDQo+
ID4gSWFuDQo+IA0KPiBTbyBJIG5vdGljZWQgYSBmZXcgY2hhbmdlcyBtaXNzaW5nICNpbmNsdWRl
LWluZyBzdGRhdG9taWMuaCBhbmQNCj4gc2lnX2F0b21pY190IGlzIGFjdHVhbGx5IGluIHNpZ25h
bC5oLiBJJ20gbm90IHN1cmUgd2UgbmVlZCB0aGUgQzExDQo+IGNoYW5nZSB0aGVuLCBidXQgaXQg
c2VlbXMgbGlrZSB0aGUgcmlnaHQgdGhpbmcgdG8gZG8gYW55d2F5LiBJJ2xsIGRvIGENCj4gdjIg
dG8gZHJvcCB0aGUgdW5uZWVkZWQgKGN1cnJlbnRseSkgaW5jbHVkZSBvZiBzdGRhdG9taWMuaC4N
Cg0KV2hpbGUgdGhlIEMgc3RhbmRhcmQgcmVxdWlyZXMgeW91IHVzZSBzaWdfYXRvbWljX3QgKHRv
IGF2b2lkDQp3aWRlciBSTVcgYmVpbmcgZG9uZSBmb3Igd3JpdGVzKSB0aGUga2VybmVsIHZlcnkg
bXVjaCByZXF1aXJlcw0KdGhhdCB2b2xhdGlsZXMgYWNjZXNzZXMgYXJlIGF0b21pYy4NClNvIHRo
ZSBjb21waWxlcnMgdXNlZCB3aWxsIGRvIHRoYXQgZXZlbiB3aGVuIHRoZSBDIHN0YW5kYXJkDQp3
b3VsZCBhbGxvdyB0aGVtIHRvIGRvIG90aGVyd2lzZS4NCg0KUHJldHR5IG11Y2ggdGhlIGxhc3Qg
bWFpbnN0cmVhbSBjcHUgdGhhdCBjb3VsZG4ndCBkbyBhdG9taWMNCmJ5dGUgd3JpdGVzIHdhcyBh
biBvbGQgYWxwaGEuDQoNClNvIGZvciBhbnl0aGluZyB0aGF0IExpbnV4IGlzIGdvaW5nIHRvIHJ1
biBvbiB0aGVzZSBjaGFuZ2VzDQphcmVuJ3QgcmVhbGx5IG5lZWRlZC4NCg0KCURhdmlkDQoNCi0N
ClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBN
aWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxl
cykNCg==

