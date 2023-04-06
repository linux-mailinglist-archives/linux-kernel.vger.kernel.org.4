Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745A36D8CE0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjDFBl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjDFBl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:41:26 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2787AAC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 18:41:15 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTP id 3361cDJL007981;
        Thu, 6 Apr 2023 09:38:13 +0800 (+08)
        (envelope-from Ziwei.Dai@unisoc.com)
Received: from BJMBX01.spreadtrum.com (10.0.64.7) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 6 Apr 2023
 09:38:09 +0800
Received: from BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7]) by
 BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7%16]) with mapi id
 15.00.1497.023; Thu, 6 Apr 2023 09:38:09 +0800
From:   =?utf-8?B?5Luj5a2Q5Li6IChaaXdlaSBEYWkp?= <Ziwei.Dai@unisoc.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
CC:     "urezki@gmail.com" <urezki@gmail.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?546L5Y+MIChTaHVhbmcgV2FuZyk=?= <shuang.wang@unisoc.com>,
        =?utf-8?B?6L6b5L6d5YehIChZaWZhbiBYaW4p?= <Yifan.Xin@unisoc.com>,
        =?utf-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>,
        =?utf-8?B?6Zer5a2m5paHIChYdWV3ZW4gWWFuKQ==?= 
        <Xuewen.Yan@unisoc.com>,
        =?utf-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= 
        <Zhiguo.Niu@unisoc.com>,
        =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= 
        <zhaoyang.huang@unisoc.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggVjJdIHJjdTogTWFrZSBzdXJlIG5ldyBrcmNwIGZy?=
 =?utf-8?B?ZWUgYnVzaW5lc3MgaXMgaGFuZGxlZCBhZnRlciB0aGUgd2FudGVkIHJjdSBn?=
 =?utf-8?Q?race_period.?=
Thread-Topic: [PATCH V2] rcu: Make sure new krcp free business is handled
 after the wanted rcu grace period.
Thread-Index: AQHZY847pmipC6SE2kaEv39cR2hMwK8cfXOAgAAJEQCAAAmggIAA+KkQ
Date:   Thu, 6 Apr 2023 01:38:09 +0000
Message-ID: <94c28b46617e46d1804a397a54f9fd8d@BJMBX01.spreadtrum.com>
References: <1680266529-28429-1-git-send-email-ziwei.dai@unisoc.com>
 <CAEXW_YR5MZhHuDsMVEB8A=80k3sjecp-yTXNLv6XCaq9h2JH2A@mail.gmail.com>
 <CAEXW_YRtV7pAYR-UyVNNsgPJ2dmBGrV+DkNROOivXj3MChDgGw@mail.gmail.com>
 <a1e006af-c935-4246-a239-669debb4717d@paulmck-laptop>
In-Reply-To: <a1e006af-c935-4246-a239-669debb4717d@paulmck-laptop>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.93.65]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: SHSQR01.spreadtrum.com 3361cDJL007981
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IFBhdWwgRS4gTWNLZW5u
ZXkgPHBhdWxtY2tAa2VybmVsLm9yZz4NCj4g5Y+R6YCB5pe26Ze0OiAyMDIz5bm0NOaciDbml6Ug
Mjo0Ng0KPiDmlLbku7bkuro6IEpvZWwgRmVybmFuZGVzIDxqb2VsQGpvZWxmZXJuYW5kZXMub3Jn
Pg0KPiDmioTpgIE6IOS7o+WtkOS4uiAoWml3ZWkgRGFpKSA8Wml3ZWkuRGFpQHVuaXNvYy5jb20+
OyB1cmV6a2lAZ21haWwuY29tOyBmcmVkZXJpY0BrZXJuZWwub3JnOyBxdWljX25lZXJhanVAcXVp
Y2luYy5jb207DQo+IGpvc2hAam9zaHRyaXBsZXR0Lm9yZzsgcm9zdGVkdEBnb29kbWlzLm9yZzsg
bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tOyBqaWFuZ3NoYW5sYWlAZ21haWwuY29tOyBy
Y3VAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyDnjovl
j4wgKFNodWFuZyBXYW5nKSA8c2h1YW5nLndhbmdAdW5pc29jLmNvbT47IOi+m+S+neWHoSAoWWlm
YW4gWGluKSA8WWlmYW4uWGluQHVuaXNvYy5jb20+OyDnjovnp5ENCj4gKEtlIFdhbmcpIDxLZS5X
YW5nQHVuaXNvYy5jb20+OyDpl6vlrabmlocgKFh1ZXdlbiBZYW4pIDxYdWV3ZW4uWWFuQHVuaXNv
Yy5jb20+OyDniZvlv5flm70gKFpoaWd1byBOaXUpDQo+IDxaaGlndW8uTml1QHVuaXNvYy5jb20+
OyDpu4TmnJ3pmLMgKFpoYW95YW5nIEh1YW5nKSA8emhhb3lhbmcuaHVhbmdAdW5pc29jLmNvbT4N
Cj4g5Li76aKYOiBSZTogW1BBVENIIFYyXSByY3U6IE1ha2Ugc3VyZSBuZXcga3JjcCBmcmVlIGJ1
c2luZXNzIGlzIGhhbmRsZWQgYWZ0ZXIgdGhlIHdhbnRlZCByY3UgZ3JhY2UgcGVyaW9kLg0KPiAN
Cj4gDQo+IOazqOaEjzog6L+Z5bCB6YKu5Lu25p2l6Ieq5LqO5aSW6YOo44CC6Zmk6Z2e5L2g56Gu
5a6a6YKu5Lu25YaF5a655a6J5YWo77yM5ZCm5YiZ5LiN6KaB54K55Ye75Lu75L2V6ZO+5o6l5ZKM
6ZmE5Lu244CCDQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUg
b2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlDQo+IHNlbmRlciBhbmQga25vdyB0aGUgY29udGVu
dCBpcyBzYWZlLg0KPiANCj4gDQo+IA0KPiBPbiBXZWQsIEFwciAwNSwgMjAyMyBhdCAwMjoxMjow
MlBNIC0wNDAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToNCj4gPiBPbiBXZWQsIEFwciA1LCAyMDIz
IGF0IDE6MznigK9QTSBKb2VsIEZlcm5hbmRlcyA8am9lbEBqb2VsZmVybmFuZGVzLm9yZz4gd3Jv
dGU6DQo+ID4gPg0KPiA+ID4gT24gRnJpLCBNYXIgMzEsIDIwMjMgYXQgODo0M+KAr0FNIFppd2Vp
IERhaSA8eml3ZWkuZGFpQHVuaXNvYy5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBJbiBr
ZnJlZV9yY3VfbW9uaXRvcigpLCBuZXcgZnJlZSBidXNpbmVzcyBhdCBrcmNwIGlzIGF0dGFjaGVk
IHRvDQo+ID4gPiA+IGFueSBmcmVlIGNoYW5uZWwgYXQga3J3cC4ga2ZyZWVfcmN1X21vbml0b3Io
KSBpcyByZXNwb25zaWJsZSB0bw0KPiA+ID4gPiBtYWtlIHN1cmUgbmV3IGZyZWUgYnVzaW5lc3Mg
aXMgaGFuZGxlZCBhZnRlciB0aGUgcmN1IGdyYWNlIHBlcmlvZC4NCj4gPiA+ID4gQnV0IGlmIHRo
ZXJlIGlzIGFueSBub25lLWZyZWUgY2hhbm5lbCBhdCBrcndwIGFscmVhZHksIHRoYXQgbWVhbnMN
Cj4gPiA+ID4gdGhlcmUgaXMgYW4gb24tZ29pbmcgcmN1IHdvcmssIHdoaWNoIHdpbGwgY2F1c2Ug
dGhlDQo+ID4gPiA+IGt2ZnJlZV9jYWxsX3JjdSgpLXRyaWdnZXJlZCBmcmVlIGJ1c2luZXNzIGlz
IGRvbmUgYmVmb3JlIHRoZSB3YW50ZWQgcmN1IGdyYWNlIHBlcmlvZCBlbmRzLg0KPiA+ID4gPg0K
PiA+ID4gPiBUaGlzIGNvbW1pdCBpZ25vcmUga3J3cCB3aGljaCBoYXMgbm9uLWZyZWUgY2hhbm5l
bCBhdA0KPiA+ID4gPiBrZnJlZV9yY3VfbW9uaXRvcigpLCB0byBmaXggdGhlIGlzc3VlIHRoYXQg
a3ZmcmVlX2NhbGxfcmN1KCkgbG9zZXMgZWZmZWN0aXZlbmVzcy4NCj4gPiA+ID4NCj4gPiA+ID4g
QmVsb3cgaXMgdGhlIGNzc19zZXQgb2JqICJmcm9tX2NzZXQiIHVzZS1hZnRlci1mcmVlIGNhc2Ug
Y2F1c2VkIGJ5DQo+ID4gPiA+IGt2ZnJlZV9jYWxsX3JjdSgpIGxvc2luZyBlZmZlY3RpdmVuZXNz
Lg0KPiA+ID4gPiBDUFUgMCBjYWxscyByY3VfcmVhZF9sb2NrKCksIHRoZW4gdXNlICJmcm9tX2Nz
ZXQiLCB0aGVuIGhhcmQgaXJxDQo+ID4gPiA+IGNvbWVzLCB0aGUgdGFzayBpcyBzY2hlZHVsZSBv
dXQuDQo+ID4gPiA+IENQVSAxIGNhbGxzIGtmcmVlX3JjdShjc2V0LCByY3VfaGVhZCksIHdpbGxp
bmcgdG8gZnJlZSAiZnJvbV9jc2V0IiBhZnRlciBuZXcgZ3AuDQo+ID4gPiA+IEJ1dCAiZnJvbV9j
c2V0IiBpcyBmcmVlZCByaWdodCBhZnRlciBjdXJyZW50IGdwIGVuZC4gImZyb21fY3NldCIgaXMg
cmVhbGxvY2F0ZWQuDQo+ID4gPiA+IENQVSAwICdzIHRhc2sgYXJyaXZlcyBiYWNrLCByZWZlcmVu
Y2VzICJmcm9tX2NzZXQiJ3MgbWVtYmVyLCB3aGljaCBjYXVzZXMgY3Jhc2guDQo+ID4gPiA+DQo+
ID4gPiA+IENQVSAwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUgMQ0KPiA+
ID4gPiBjb3VudF9tZW1jZ19ldmVudF9tbSgpDQo+ID4gPiA+IHxyY3VfcmVhZF9sb2NrKCkgIDwt
LS0NCj4gPiA+ID4gfG1lbV9jZ3JvdXBfZnJvbV90YXNrKCkNCj4gPiA+ID4gIHwvLyBjc3Nfc2V0
X3B0ciBpcyB0aGUgImZyb21fY3NldCIgbWVudGlvbmVkIG9uIENQVSAxDQo+ID4gPiA+IHxjc3Nf
c2V0X3B0ciA9IHJjdV9kZXJlZmVyZW5jZSgodGFzayktPmNncm91cHMpICB8Ly8gSGFyZCBpcnEN
Cj4gPiA+ID4gY29tZXMsIGN1cnJlbnQgdGFzayBpcyBzY2hlZHVsZWQgb3V0Lg0KPiA+ID4gPg0K
PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2dyb3VwX2F0
dGFjaF90YXNrKCkNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHxjZ3JvdXBfbWlncmF0ZSgpDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8Y2dyb3VwX21pZ3JhdGVfZXhlY3V0ZSgpDQo+ID4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8Y3NzX3NldF9tb3ZlX3Rhc2sodGFzaywg
ZnJvbV9jc2V0LCB0b19jc2V0LCB0cnVlKQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfGNncm91cF9tb3ZlX3Rhc2sodGFzaywgdG9fY3NldCkNCj4gPiA+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHxyY3VfYXNzaWduX3Bv
aW50ZXIoLi4sIHRvX2NzZXQpDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8Li4uDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8Y2dyb3VwX21pZ3JhdGVfZmluaXNoKCkNCj4gPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHxwdXRfY3NzX3NldF9sb2NrZWQoZnJvbV9jc2V0KQ0K
PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfGZyb21fY3Nl
dC0+cmVmY291bnQgcmV0dXJuIDANCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHxrZnJlZV9yY3UoY3NldCwgcmN1X2hlYWQpIC8vIG1lYW5zIHRvIGZyZWUg
ZnJvbV9jc2V0IGFmdGVyIG5ldyBncA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfGFkZF9wdHJfdG9fYnVsa19rcmNfbG9jaygpDQo+ID4gPiA+DQo+ID4g
PiA+IHxzY2hlZHVsZV9kZWxheWVkX3dvcmsoJmtyY3AtPm1vbml0b3Jfd29yaywgLi4pDQo+ID4g
PiA+DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBrZnJl
ZV9yY3VfbW9uaXRvcigpDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8a3JjcC0+YnVsa19oZWFkWzBdJ3Mgd29yayBhdHRhY2hlZCB0byBrcndwLT5idWxr
X2hlYWRfZnJlZVtdDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8cXVldWVfcmN1X3dvcmsoc3lzdGVtX3dxLCAma3J3cC0+cmN1X3dvcmspDQo+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8aWYgcndvcmstPnJjdS53
b3JrIGlzIG5vdCBpbiBXT1JLX1NUUlVDVF9QRU5ESU5HX0JJVCBzdGF0ZSwNCj4gPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHxjYWxsX3JjdSgmcndvcmstPnJj
dSwNCj4gPiA+ID4gcmN1X3dvcmtfcmN1Zm4pIDwtLS0gcmVxdWVzdCBhIG5ldyBncA0KPiA+ID4g
Pg0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLy8gVGhl
cmUgaXMgYSBwZXJpb3VzIGNhbGxfcmN1KC4uLCByY3Vfd29ya19yY3VmbikNCj4gPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8vIGdwIGVuZCwgcmN1X3dvcmtf
cmN1Zm4oKSBpcyBjYWxsZWQuDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICByY3Vfd29ya19yY3VmbigpDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8X19xdWV1ZV93b3JrKC4uLA0KPiA+ID4gPiByd29yay0+d3Es
ICZyd29yay0+d29yayk7DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8a2ZyZWVfcmN1X3dvcmsoKQ0KPiA+ID4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfGtyd3AtPmJ1bGtfaGVhZF9mcmVlWzBdIGJ1bGsg
aXMgZnJlZWQgYmVmb3JlIG5ldyBncCBlbmQhISENCj4gPiA+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHxUaGUgImZyb21fY3NldCIgaXMgZnJlZWQgYmVmb3JlIG5l
dyBncCBlbmQuDQo+ID4gPiA+DQo+ID4gPiA+IC8vIHRoZSB0YXNrIGlzIHNjaGVkdWxlZCBpbiBh
ZnRlciBtYW55IG1zLg0KPiA+ID4gPiAgfGNzc19zZXRfcHRyLT5zdWJzeXNbKHN1YnN5c19pZCkg
PC0tLSBDYXVzZWQga2VybmVsIGNyYXNoLCBiZWNhdXNlIGNzc19zZXRfcHRyIGlzIGZyZWVkLg0K
PiA+ID4gPg0KPiA+ID4gPiB2MjogVXNlIGhlbHBlciBmdW5jdGlvbiBpbnN0ZWFkIG9mIGluc2Vy
dGVkIGNvZGUgYmxvY2sgYXQga2ZyZWVfcmN1X21vbml0b3IoKS4NCj4gPiA+ID4NCj4gPiA+ID4g
Rml4ZXM6IGMwMTRlZmVlZjc2YSAoInJjdTogQWRkIG11bHRpcGxlIGluLWZsaWdodCBiYXRjaGVz
IG9mDQo+ID4gPiA+IGtmcmVlX3JjdSgpIHdvcmsiKQ0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBa
aXdlaSBEYWkgPHppd2VpLmRhaUB1bmlzb2MuY29tPg0KPiA+ID4NCj4gPiA+IFBsZWFzZSB1cGRh
dGUgdGhlIGZpeGVzIHRhZyB0bzoNCj4gPiA+IDVmM2M4ZDYyMDQ0NyAoInJjdS90cmVlOiBNYWlu
dGFpbiBzZXBhcmF0ZSBhcnJheSBmb3Igdm1hbGxvYyBwdHJzIikNCj4gPg0KPiA+IFZsYWQgcG9p
bnRlZCBvdXQgaW4gYW5vdGhlciB0aHJlYWQgdGhhdCB0aGUgZml4IGlzIGFjdHVhbGx5IHRvIDM0
Yzg4MTc0NTU0OS4NCj4gPg0KPiA+IFNvIGp1c3QgdG8gYmUgc3VyZSwgaXQgY291bGQgYmUgdXBk
YXRlZCB0bzoNCj4gPiBGaXhlczogMzRjODgxNzQ1NTQ5ICgicmN1OiBTdXBwb3J0IGtmcmVlX2J1
bGsoKSBpbnRlcmZhY2UgaW4NCj4gPiBrZnJlZV9yY3UoKSIpDQo+ID4gRml4ZXM6IDVmM2M4ZDYy
MDQ0NyAoInJjdS90cmVlOiBNYWludGFpbiBzZXBhcmF0ZSBhcnJheSBmb3Igdm1hbGxvYw0KPiA+
IHB0cnMiKQ0KPiANCj4gWml3ZWkgRGFpLCBkb2VzIHRoaXMgY2hhbmdlIGluIEZpeGVzIGxvb2sg
Z29vZCB0byB5b3U/DQo+IA0KPiBJZiBzbywgSSB3aWxsIHVwZGF0ZSB0aGUgY29tbWl0IGxvZyBp
biB0aGlzIGNvbW1pdCB0aGF0IEkgYW0gcGxhbm5pbmcgdG8gc3VibWl0IGludG8gdjYuMy4gIEl0
IGlzIHN0cmljdGx5IHNwZWFraW5nIG5vdCBhIHY2LjMgcmVncmVzc2lvbiwNCj4gYnV0IGl0IGlz
IHN0YXJ0aW5nIHRvIHNob3cgdXAgaW4gdGhlIHdpbGQgYW5kIHRoZSBwYXRjaCBpcyBjb250YWlu
ZWQgZW5vdWdoIHRvIGJlIGNvbnNpZGVyZWQgYW4gdXJnZW50IGZpeC4NCj4gDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVGhhbngsIFBh
dWwNCg0KSGkgUGF1bCwgaXQgbG9va3MgZ29vZCB0byBtZSBhbmQgdGhhbmtzIQ0KDQo=
