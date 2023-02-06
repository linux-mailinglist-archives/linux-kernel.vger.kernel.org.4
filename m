Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC14E68C125
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjBFPQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBFPQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:16:06 -0500
Received: from exchange.fintech.ru (e10edge.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD65EEFA6;
        Mon,  6 Feb 2023 07:16:03 -0800 (PST)
Received: from Ex16-02.fintech.ru (10.0.10.19) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 6 Feb
 2023 18:15:54 +0300
Received: from Ex16-01.fintech.ru (10.0.10.18) by Ex16-02.fintech.ru
 (10.0.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 6 Feb 2023
 18:15:54 +0300
Received: from Ex16-01.fintech.ru ([fe80::2534:7600:5275:d3f9]) by
 Ex16-01.fintech.ru ([fe80::2534:7600:5275:d3f9%7]) with mapi id
 15.01.2242.004; Mon, 6 Feb 2023 18:15:54 +0300
From:   =?utf-8?B?0J/QtdGC0YDQvtCy0LAg0J3QsNGC0LDQu9C40Y8g0JzQuNGF0LDQudC70L4=?=
         =?utf-8?B?0LLQvdCw?= <n.petrova@fintech.ru>
To:     Ilya Dryomov <idryomov@gmail.com>
CC:     Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Jens Axboe <axboe@kernel.dk>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "Alexey Khoroshilov" <khoroshilov@ispras.ru>
Subject: RE: [PATCH] rbd: avoid double free memory on error path in
 rbd_dev_create()
Thread-Topic: [PATCH] rbd: avoid double free memory on error path in
 rbd_dev_create()
Thread-Index: AQHZN9nxgAE2L2YDAUOtBDoC3Rb6ma7Boq2AgABcKRA=
Date:   Mon, 6 Feb 2023 15:15:54 +0000
Message-ID: <c01e807428894bef8fed628df0b8f4b6@fintech.ru>
References: <20230203141515.125205-1-n.petrova@fintech.ru>
 <CAOi1vP_7Oaw8O-p2X1xymzym1Xf_RZeN0u=SeE4Zbc2y+AfgYA@mail.gmail.com>
In-Reply-To: <CAOi1vP_7Oaw8O-p2X1xymzym1Xf_RZeN0u=SeE4Zbc2y+AfgYA@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.253.125]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSWx5YSENClRoYW5rcyBmb3IgeW91ciByZXNwb25zZSEgSSBkb24ndCBxdWl0ZSB1bmRlcnN0
YW5kIHlvdXIgaWRlYSBhbmQgc3VnZ2VzdGlvbi4gVGhlIHBhdGNoIGlzIGRlc2lnbmVkIHRvIGF2
b2lkIGRvdWJsZSBmcmVlIG1lbW9yeS4gSSBleHBsb3JlZCB0aGUgY29kZSBhZ2FpbiBhbmQgc3Vw
cG9zZSB0aGVyZSBpcyBhbm90aGVyIHNpdHVhdGlvbiBmb3IgcmJkX2Rldi0+cmJkX2NsaWVudCBh
bmQgcmJkX2Rldi0+c3BlYy4gRnJlZSBtZW1vcnkgb2YgdGhlc2UgcG9pbnRlcnMgaXMgcG9zc2li
bGUgb25seSBvbmNlIGluIHJiZF9kZXZfZnJlZSgpIGZ1bmN0aW9uLiBJbiBkb19yYmRfYWRkKCkg
ZGVhbGxvY2F0aW9uIG1lbW9yeSBpcyBvbmx5IGZvciByYmRfb3B0czogZHJpdmVycy9ibG9jay9y
YmQuYyA3MTU3Lg0KQ29ycmVjdCBtZSBpZiBJJ20gd3JvbmcuDQoNClRoYW5rcywgDQpOYXRhbGlh
DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBJbHlhIERyeW9tb3YgPGlkcnlv
bW92QGdtYWlsLmNvbT4gDQpTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDYsIDIwMjMgMjo1OSBQTQ0K
VG86INCf0LXRgtGA0L7QstCwINCd0LDRgtCw0LvQuNGPINCc0LjRhdCw0LnQu9C+0LLQvdCwIDxu
LnBldHJvdmFAZmludGVjaC5ydT4NCkNjOiBEb25nc2hlbmcgWWFuZyA8ZG9uZ3NoZW5nLnlhbmdA
ZWFzeXN0YWNrLmNuPjsgSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPjsgY2VwaC1kZXZlbEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWJsb2NrQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgbHZjLXByb2plY3RAbGludXh0ZXN0aW5nLm9yZzsgQWxleGV5IEto
b3Jvc2hpbG92IDxraG9yb3NoaWxvdkBpc3ByYXMucnU+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBy
YmQ6IGF2b2lkIGRvdWJsZSBmcmVlIG1lbW9yeSBvbiBlcnJvciBwYXRoIGluIHJiZF9kZXZfY3Jl
YXRlKCkNCg0KT24gRnJpLCBGZWIgMywgMjAyMyBhdCAzOjE1IFBNIE5hdGFsaWEgUGV0cm92YSA8
bi5wZXRyb3ZhQGZpbnRlY2gucnU+IHdyb3RlOg0KPg0KPiBJZiByYmRfZGV2X2NyZWF0ZSgpIGZh
aWxzIGFmdGVyIGFzc2lnbm1lbnQgJ29wdHMnIHRvICdyYmRfZGV2LT5vcHRzJywgDQo+IGRvdWJs
ZSBmcmVlIG9mICdyYmRfb3B0aW9ucycgaGFwcGVuczoNCj4gb25lIGlzIGluIHJiZF9kZXZfZnJl
ZSgpIGFuZCBhbm90aGVyIG9uZSBpcyBpbiBkb19yYmRfYWRkKCkuDQo+DQo+IEZvdW5kIGJ5IExp
bnV4IFZlcmlmaWNhdGlvbiBDZW50ZXIgKGxpbnV4dGVzdGluZy5vcmcpIHdpdGggU1ZBQ0UuDQo+
DQo+IEZpeGVzOiAxNjQzZGZhNGMyYzggKCJyYmQ6IGludHJvZHVjZSBhIHBlci1kZXZpY2Ugb3Jk
ZXJlZCB3b3JrcXVldWUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBOYXRhbGlhIFBldHJvdmEgPG4ucGV0
cm92YUBmaW50ZWNoLnJ1Pg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4ZXkgS2hvcm9zaGlsb3YgPGto
b3Jvc2hpbG92QGlzcHJhcy5ydT4NCj4gLS0tDQo+ICBkcml2ZXJzL2Jsb2NrL3JiZC5jIHwgMiAr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL3JiZC5jIGIvZHJpdmVycy9ibG9jay9yYmQuYyBp
bmRleCANCj4gMDQ0NTNmNGEzMTljLi5hYjZiZmMzNTJjZGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvYmxvY2svcmJkLmMNCj4gKysrIGIvZHJpdmVycy9ibG9jay9yYmQuYw0KPiBAQCAtNTM1Nyw3
ICs1MzU3LDYgQEAgc3RhdGljIHN0cnVjdCByYmRfZGV2aWNlICpyYmRfZGV2X2NyZWF0ZShzdHJ1
Y3QgcmJkX2NsaWVudCAqcmJkYywNCj4gICAgICAgICBpZiAoIXJiZF9kZXYpDQo+ICAgICAgICAg
ICAgICAgICByZXR1cm4gTlVMTDsNCj4NCj4gLSAgICAgICByYmRfZGV2LT5vcHRzID0gb3B0czsN
Cj4NCj4gICAgICAgICAvKiBnZXQgYW4gaWQgYW5kIGZpbGwgaW4gZGV2aWNlIG5hbWUgKi8NCj4g
ICAgICAgICByYmRfZGV2LT5kZXZfaWQgPSBpZGFfc2ltcGxlX2dldCgmcmJkX2Rldl9pZF9pZGEs
IDAsIEBAIA0KPiAtNTM3Miw2ICs1MzcxLDcgQEAgc3RhdGljIHN0cnVjdCByYmRfZGV2aWNlICpy
YmRfZGV2X2NyZWF0ZShzdHJ1Y3QgcmJkX2NsaWVudCAqcmJkYywNCj4gICAgICAgICBpZiAoIXJi
ZF9kZXYtPnRhc2tfd3EpDQo+ICAgICAgICAgICAgICAgICBnb3RvIGZhaWxfZGV2X2lkOw0KPg0K
PiArICAgICAgIHJiZF9kZXYtPm9wdHMgPSBvcHRzOw0KPiAgICAgICAgIC8qIHdlIGhhdmUgYSBy
ZWYgZnJvbSBkb19yYmRfYWRkKCkgKi8NCj4gICAgICAgICBfX21vZHVsZV9nZXQoVEhJU19NT0RV
TEUpOw0KPg0KPiAtLQ0KPiAyLjM0LjENCj4NCg0KSGkgTmF0YWxpYSwNCg0KSXQgc2VlbXMgbGlr
ZSBhIHNpbWlsYXIgaXNzdWUgaXMgYWZmZWN0aW5nIHJiZF9kZXYtPnJiZF9jbGllbnQgYW5kIHJi
ZF9kZXYtPnNwZWMuICBVbmxpa2UgcmJkX2Rldi0+b3B0cywgdGhleSBhcmUgcmVmLWNvdW50ZWQg
YW5kIEknbSBndWVzc2luZyB0aGF0IHRoZSB2ZXJpZmljYXRpb24gdG9vbCBkb2Vzbid0IGdvIHRo
YXQgZGVlcC4NCg0KSSdkIHByZWZlciBhbGwgdGhyZWUgdG8gYmUgYWRkcmVzc2VkIGluIHRoZSBz
YW1lIGNoYW5nZSwgc2luY2UgaXQncyB0aGUgc2FtZSBlcnJvciBwYXRoLiAgV291bGQgeW91IGJl
IHdpbGxpbmcgdG8gbG9vayBpbnRvIHRoYXQgYW5kIHBvc3QgYSBuZXcgcmV2aXNpb24gb3Igc2hv
dWxkIEkgdHJlYXQganVzdCB0aGlzIHBhdGNoIGFzIGEgYnVnIHJlcG9ydD8NCg0KVGhhbmtzLA0K
DQogICAgICAgICAgICAgICAgSWx5YQ0K
