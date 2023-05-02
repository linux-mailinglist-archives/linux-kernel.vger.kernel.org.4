Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A273A6F4386
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjEBMQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbjEBMQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:16:41 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE0E9B
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:16:39 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTP id 342CCTeq008795;
        Tue, 2 May 2023 20:12:29 +0800 (+08)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from BJMBX01.spreadtrum.com (10.0.64.7) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 2 May 2023
 20:12:28 +0800
Received: from BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7]) by
 BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7%16]) with mapi id
 15.00.1497.023; Tue, 2 May 2023 20:12:29 +0800
From:   =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= 
        <zhaoyang.huang@unisoc.com>
To:     "'Roman Gushchin'" <roman.gushchin@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        =?utf-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIG1tOiBvcHRpbWl6YXRpb24gb24gcGFnZSBhbGxv?=
 =?utf-8?Q?cation_when_CMA_enabled?=
Thread-Topic: [PATCH] mm: optimization on page allocation when CMA enabled
Thread-Index: AQHZfFAdfKMKvIudzkyaBTzwMCVkSq9G1QKw
Date:   Tue, 2 May 2023 12:12:28 +0000
Message-ID: <e0bd4476c7854cbfafea0ced9569220c@BJMBX01.spreadtrum.com>
References: <1682679641-13652-1-git-send-email-zhaoyang.huang@unisoc.com>
 <ZE/y5wMggipQrKvb@P9FQF9L96D>
In-Reply-To: <ZE/y5wMggipQrKvb@P9FQF9L96D>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.93.65]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: SHSQR01.spreadtrum.com 342CCTeq008795
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIaSBaaGFveWFuZyENCj4gDQo+IE9uIEZyaSwgQXByIDI4LCAyMDIzIGF0IDA3OjAwOjQxUE0g
KzA4MDAsIHpoYW95YW5nLmh1YW5nIHdyb3RlOg0KPiA+IEZyb206IFpoYW95YW5nIEh1YW5nIDx6
aGFveWFuZy5odWFuZ0B1bmlzb2MuY29tPg0KPiA+DQo+ID4gUGxlYXNlIGJlIG5vdGljZSBiZWxs
b3dpbmcgdHlwaWNhbCBzY2VuYXJpbyB0aGF0IGNvbW1pdCAxNjg2NzY2NDkNCj4gPiBpbnRyb2R1
Y2UsIHRoYXQgaXMsIDEyTUIgZnJlZSBjbWEgcGFnZXMgJ2hlbHAnIEdGUF9NT1ZBQkxFIHRvIGtl
ZXANCj4gPiBkcmFpbmluZy9mcmFnbWVudGluZyBVJlIgcGFnZSBibG9ja3MgdW50aWwgdGhleSBz
aHJpbmsgdG8gMTJNQiB3aXRob3V0DQo+ID4gZW50ZXIgc2xvd3BhdGggd2hpY2ggYWdhaW5zdCBj
dXJyZW50IHJlY2xhaW1pbmcgcG9saWN5LiBUaGlzIGNvbW1pdCBjaGFuZ2UNCj4gdGhlIGNyaXRl
cmlhIGZyb20gaGFyZCBjb2RlZCAnMS8yJw0KPiA+IHRvIHdhdGVybWFyayBjaGVjayB3aGljaCBs
ZWF2ZSBVJlIgZnJlZSBwYWdlcyBzdGF5IGFyb3VuZCBXTUFSS19MT1cNCj4gPiB3aGVuIGJlaW5n
IGZhbGxiYWNrLg0KPiANCj4gQ2FuIHlvdSwgcGxlYXNlLCBleHBsYWluIHRoZSBwcm9ibGVtIHlv
dSdyZSBzb2x2aW5nIGluIG1vcmUgZGV0YWlscz8NCkkgYW0gdHJ5aW5nIHRvIHNvbHZlIGEgT09N
IHByb2JsZW0gY2F1c2VkIGJ5IHNsYWIgYWxsb2NhdGlvbiBmYWlsIGFzIGFsbCBmcmVlIHBhZ2Vz
IGFyZSBNSUdSQVRFX0NNQSBieSBhcHBseWluZyAxNjg2NzY2NDksIHdoaWNoIGNvdWxkIGhlbHAg
dG8gcmVkdWNlIHRoZSBmYXVsdCByYXRpb24gZnJvbSAxMi8yMCB0byAyLzIwLiBJIG5vdGljZWQg
aXQgaW50cm9kdWNlIHRoZSBwaGVub21lbm9uIHdoaWNoIEkgZGVzY3JpYmUgYWJvdmUuDQo+IA0K
PiBJZiBJIHVuZGVyc3RhbmQgeW91ciBjb2RlIGNvcnJlY3RseSwgeW91J3JlIGVmZmVjdGl2ZWx5
IHJlZHVjaW5nIHRoZSB1c2Ugb2YgY21hDQo+IGFyZWFzIGZvciBtb3ZhYmxlIGFsbG9jYXRpb25z
LiBXaHkgaXQncyBnb29kPw0KTm90IGV4YWN0bHkuIEluIGZhY3QsIHRoaXMgY29tbWl0IGxlYWQg
dG8gdGhlIHVzZSBvZiBjbWEgZWFybHkgdGhhbiBpdCBpcyBub3csIHdoaWNoIGNvdWxkIGhlbHAg
dG8gcHJvdGVjdCBVJlIgYmUgJ3N0b2xlbicgYnkgR0ZQX01PVkFCTEUuIEltYWdpbmUgdGhpcyBz
Y2VuYXJpbywgMzBNQiB0b3RhbCBmcmVlIHBhZ2VzIGNvbXBvc2VkIG9mIDEwTUIgQ01BIGFuZCAy
ME1CIFUmUiwgd2hpbGUgem9uZSdzIHdhdGVybWFyayBsb3cgaXMgMjVNQi4gQW4gR0ZQX01PVkFC
TEUgYWxsb2NhdGlvbiBjYW4ga2VlcCBzdGVhbGluZyBVJlIgcGFnZXMoZG9uJ3QgbWVldCAxLzIg
Y3JpdGVyaWEpIHdpdGhvdXQgZW50ZXIgc2xvd3BhdGgoem9uZV93YXRlcm1hcmtfb2soV01BUktf
TE9XKSBpcyB0cnVlKSB1bnRpbCB0aGV5IHNocmluayB0byAxNU1CLiBJbiBteSBvcGluaW9uLCBp
dCBtYWtlcyBtb3JlIHNlbnNlIHRvIGhhdmUgQ01BIHRha2UgaXRzIGR1dHkgdG8gaGVscCBtb3Zh
YmxlIGFsbG9jYXRpb24gd2hlbiBVJlIgbG93ZXIgdG8gY2VydGFpbiB6b25lJ3Mgd2F0ZXJtYXJr
IGluc3RlYWQgb2Ygd2hlbiB0aGVpciBzaXplIGJlY29tZSBzbWFsbGVyIHRoYW4gQ01BLg0KPiBB
bHNvLCB0aGlzIGlzIGEgaG90IHBhdGgsIHBsZWFzZSwgbWFrZSBzdXJlIHlvdSdyZSBub3QgYWRk
aW5nIG11Y2ggb3ZlcmhlYWQuDQpJIHdvdWxkIGxpa2UgdG8gdGFrZSBtb3JlIHRob3VnaHQuDQo+
IA0KPiBBbmQgcGxlYXNlIHVzZSBzY3JpcHRzL2NoZWNrcGF0Y2gucGwgbmV4dCB0aW1lLCB0aGVy
ZSBhcmUgbWFueSBjb2RlIHN0eWxlDQo+IGlzc3Vlcy4NCm9rDQoNCj4gDQo+IFRoYW5rcyENCj4g
DQo+ID4NCj4gPiBETUEzMiBmcmVlOjI1OTAwa0IgYm9vc3Q6MGtCIG1pbjo0MTc2a0IgbG93OjI1
ODU2a0IgaGlnaDoyOTUxNmtCDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGFveWFuZyBIdWFu
ZyA8emhhb3lhbmcuaHVhbmdAdW5pc29jLmNvbT4NCj4gPiAtLS0NCj4gPiAgbW0vcGFnZV9hbGxv
Yy5jIHwgNDAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9tbS9wYWdlX2FsbG9jLmMgYi9tbS9wYWdlX2FsbG9jLmMgaW5kZXggMDc0
NWFlZC4uOTc3NjhmZQ0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL21tL3BhZ2VfYWxsb2MuYw0KPiA+
ICsrKyBiL21tL3BhZ2VfYWxsb2MuYw0KPiA+IEBAIC0zMDcxLDYgKzMwNzEsMzkgQEAgc3RhdGlj
IGJvb2wNCj4gPiB1bnJlc2VydmVfaGlnaGF0b21pY19wYWdlYmxvY2soY29uc3Qgc3RydWN0IGFs
bG9jX2NvbnRleHQgKmFjLA0KPiA+DQo+ID4gIH0NCj4gPg0KPiA+ICsjaWZkZWYgQ09ORklHX0NN
QQ0KPiA+ICtzdGF0aWMgYm9vbCBfX2lmX3VzZV9jbWFfZmlyc3Qoc3RydWN0IHpvbmUgKnpvbmUs
IHVuc2lnbmVkIGludCBvcmRlciwNCj4gPiArdW5zaWduZWQgaW50IGFsbG9jX2ZsYWdzKSB7DQo+
ID4gKyAgICAgdW5zaWduZWQgbG9uZyBjbWFfcHJvcG9ydGlvbiA9IDA7DQo+ID4gKyAgICAgdW5z
aWduZWQgbG9uZyBjbWFfZnJlZV9wcm9wb3J0aW9uID0gMDsNCj4gPiArICAgICB1bnNpZ25lZCBs
b25nIHdhdGVybWFyayA9IDA7DQo+ID4gKyAgICAgdW5zaWduZWQgbG9uZyB3bV9mYWN0W0FMTE9D
X1dNQVJLX01BU0tdID0gezEsIDEsIDJ9Ow0KPiA+ICsgICAgIGxvbmcgY291bnQgPSAwOw0KPiA+
ICsgICAgIGJvb2wgY21hX2ZpcnN0ID0gZmFsc2U7DQo+ID4gKw0KPiA+ICsgICAgIHdhdGVybWFy
ayA9IHdtYXJrX3BhZ2VzKHpvbmUsIGFsbG9jX2ZsYWdzICYNCj4gQUxMT0NfV01BUktfTUFTSyk7
DQo+ID4gKyAgICAgLypjaGVjayBpZiBHRlBfTU9WQUJMRSBwYXNzIHByZXZpb3VzIHdhdGVybWFy
ayBjaGVjayB2aWEgdGhlIGhlbHANCj4gb2YgQ01BKi8NCj4gPiArICAgICBpZiAoIXpvbmVfd2F0
ZXJtYXJrX29rKHpvbmUsIG9yZGVyLCB3YXRlcm1hcmssIDAsIGFsbG9jX2ZsYWdzICYNCj4gKH5B
TExPQ19DTUEpKSkNCj4gPiArICAgICB7DQo+ID4gKyAgICAgICAgICAgICBhbGxvY19mbGFncyAm
PSBBTExPQ19XTUFSS19NQVNLOw0KPiA+ICsgICAgICAgICAgICAgLyogV01BUktfTE9XIGZhaWxl
ZCBsZWFkIHRvIHVzaW5nIGNtYSBmaXJzdCwgdGhpcyBoZWxwcw0KPiBVJlIgc3RheQ0KPiA+ICsg
ICAgICAgICAgICAgICogYXJvdW5kIGxvdyB3aGVuIGJlaW5nIGRyYWluZWQgYnkgR0ZQX01PVkFC
TEUNCj4gPiArICAgICAgICAgICAgICAqLw0KPiA+ICsgICAgICAgICAgICAgaWYgKGFsbG9jX2Zs
YWdzIDw9IEFMTE9DX1dNQVJLX0xPVykNCj4gPiArICAgICAgICAgICAgICAgICAgICAgY21hX2Zp
cnN0ID0gdHJ1ZTsNCj4gPiArICAgICAgICAgICAgIC8qY2hlY2sgcHJvcG9ydGlvbiBmb3IgV01B
UktfSElHSCovDQo+ID4gKyAgICAgICAgICAgICBlbHNlIHsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgY291bnQgPQ0KPiBhdG9taWNfbG9uZ19yZWFkKCZ6b25lLT5tYW5hZ2VkX3BhZ2VzKTsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgY21hX3Byb3BvcnRpb24gPSB6b25lLT5jbWFfcGFn
ZXMgKiAxMDAgLyBjb3VudDsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgY21hX2ZyZWVfcHJv
cG9ydGlvbiA9IHpvbmVfcGFnZV9zdGF0ZSh6b25lLA0KPiBOUl9GUkVFX0NNQV9QQUdFUykgKiAx
MDANCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvICB6b25lX3BhZ2Vfc3RhdGUo
em9uZSwNCj4gTlJfRlJFRV9QQUdFUyk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNtYV9m
aXJzdCA9IChjbWFfZnJlZV9wcm9wb3J0aW9uID49DQo+IHdtX2ZhY3RbYWxsb2NfZmxhZ3NdICog
Y21hX3Byb3BvcnRpb24NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHx8IGNtYV9mcmVlX3Byb3BvcnRpb24gPj0NCj4gNTApOw0KPiA+ICsgICAgICAgICAgICAgfQ0K
PiA+ICsgICAgIH0NCj4gPiArICAgICByZXR1cm4gY21hX2ZpcnN0Ow0KPiA+ICt9DQo+ID4gKyNl
bmRpZg0KPiA+ICAvKg0KPiA+ICAgKiBEbyB0aGUgaGFyZCB3b3JrIG9mIHJlbW92aW5nIGFuIGVs
ZW1lbnQgZnJvbSB0aGUgYnVkZHkgYWxsb2NhdG9yLg0KPiA+ICAgKiBDYWxsIG1lIHdpdGggdGhl
IHpvbmUtPmxvY2sgYWxyZWFkeSBoZWxkLg0KPiA+IEBAIC0zMDg3LDEwICszMTIwLDkgQEAgc3Rh
dGljIGJvb2wNCj4gdW5yZXNlcnZlX2hpZ2hhdG9taWNfcGFnZWJsb2NrKGNvbnN0IHN0cnVjdCBh
bGxvY19jb250ZXh0ICphYywNCj4gPiAgICAgICAgICAgICAgICAqIGFsbG9jYXRpbmcgZnJvbSBD
TUEgd2hlbiBvdmVyIGhhbGYgb2YgdGhlIHpvbmUncyBmcmVlDQo+IG1lbW9yeQ0KPiA+ICAgICAg
ICAgICAgICAgICogaXMgaW4gdGhlIENNQSBhcmVhLg0KPiA+ICAgICAgICAgICAgICAgICovDQo+
ID4gLSAgICAgICAgICAgICBpZiAoYWxsb2NfZmxhZ3MgJiBBTExPQ19DTUEgJiYNCj4gPiAtICAg
ICAgICAgICAgICAgICB6b25lX3BhZ2Vfc3RhdGUoem9uZSwgTlJfRlJFRV9DTUFfUEFHRVMpID4N
Cj4gPiAtICAgICAgICAgICAgICAgICB6b25lX3BhZ2Vfc3RhdGUoem9uZSwgTlJfRlJFRV9QQUdF
UykgLyAyKSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIHBhZ2UgPSBfX3JtcXVldWVfY21h
X2ZhbGxiYWNrKHpvbmUsIG9yZGVyKTsNCj4gPiArICAgICAgICAgICAgIGlmIChtaWdyYXRldHlw
ZSA9PSBNSUdSQVRFX01PVkFCTEUpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgYm9vbCBj
bWFfZmlyc3QgPSBfX2lmX3VzZV9jbWFfZmlyc3Qoem9uZSwgb3JkZXIsDQo+IGFsbG9jX2ZsYWdz
KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgcGFnZSA9IGNtYV9maXJzdCA/IF9fcm1xdWV1
ZV9jbWFfZmFsbGJhY2soem9uZSwNCj4gPiArIG9yZGVyKSA6IE5VTEw7DQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgIGlmIChwYWdlKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiBwYWdlOw0KPiA+ICAgICAgICAgICAgICAgfQ0KPiA+IC0tDQo+ID4gMS45LjENCj4g
Pg0KPiA+DQo=
