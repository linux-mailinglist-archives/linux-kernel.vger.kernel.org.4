Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8E16E6F42
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjDRWOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbjDRWOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:14:01 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C43AD13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:13:58 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7D4792C0580;
        Wed, 19 Apr 2023 10:13:56 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1681856036;
        bh=/JK9pfG8TUx2/bezsPuKHeUXvLuZyy39hGstKjovsKg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=briJDumVdXVsweed85aUbCmm2N9KGacLAokFv0qbpc4LhHHs5W+kt3rkHdCSYTNCa
         N7x8Kn1z7hrTv/4q23Bs8GD5OPrT2iyduNbtSflgzWkwrEDfpwng1IMPuDYdRClGjR
         xS4pbLoe2IalokKdlia9HO3h5OR/re/XcLqV6rm+/JpV8P9RE/vTFMu3Nhexb4JVzS
         7JFZsk1+yUs80z8rBffPls/6iPcTElbO1cp6GesDopJarfXc1jnm2WZEWju9g2zBnq
         /IQlZVrjnMsiPcS0ozJ23CaqoerS5tM6c7Vt+QSimya2JqYEbBdWk43Stm+/UEpzZ5
         E5jZ7r/+jV0cA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B643f16240001>; Wed, 19 Apr 2023 10:13:56 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Wed, 19 Apr 2023 10:13:56 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Wed, 19 Apr 2023 10:13:56 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Wed, 19 Apr 2023 10:13:55 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "manio@skyboo.net" <manio@skyboo.net>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon: (adt7475) Handle DT unaware platforms
Thread-Topic: [PATCH] hwmon: (adt7475) Handle DT unaware platforms
Thread-Index: AQHZckFPa8P/N8ngkEyU/9VnhDdh9K8w2HSA
Date:   Tue, 18 Apr 2023 22:13:55 +0000
Message-ID: <545dcd1d-886f-b3d5-962f-b7f2bb7f7bfa@alliedtelesis.co.nz>
References: <20230418220109.787907-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20230418220109.787907-1-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <320BDF1377FCB1468F2C91BFE4BF6D45@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=VfuJw2h9 c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=dKHAf1wccvYA:10 a=GF2wAtdHAAAA:8 a=eOB9M3Q5tXBq76BNRBUA:9 a=QEXdDO2ut3YA:10 a=Vv19E3DM6UNVh-gFiZZL:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxOS8wNC8yMyAxMDowMSwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4gQ29uZmlndXJpbmcg
dGhlIHB3bSBwb2xhcml0eSB2aWEgdGhlIGFkaSxwd20tYWN0aXZlLXN0YXRlIHByb3BlcnR5IGlz
IGFuDQo+IG9wdGlvbmFsIGZlYXR1cmUuIE9uIERUIGF3YXJlIHBsYXRmb3JtcyBvZl9wcm9wZXJ0
eV9yZWFkX3UzMl9hcnJheSgpDQo+IHJldHVybnMgLUVJTlZBTCB3aGVuIHRoZSBwcm9wZXJ0eSBp
cyBhYnNlbnQgdGhpcyBpcyBjaGVja2VkIGZvciBhbmQgdGhlDQo+IGRyaXZlciBwcm9iZSBjb250
aW51ZXMgd2l0aG91dCBpc3N1ZS4NCj4NCj4gT24gRFQgdW5hd2FyZSBwbGF0ZnJvbXMgb2ZfcHJv
cGVydHlfcmVhZF91MzJfYXJyYXkoKSByZXR1cm5zIC1FTk9TWVMNCj4gd2hpY2ggY2F1c2VkIHRo
ZSBkcml2ZXIgcHJvYmUgdG8gZGV2X3dhcm4oKS4gVXBkYXRlIHRoZSBjb2RlIHRvIGRlYWwNCj4g
d2l0aCAtRU5PU1lTIHNvIHRoYXQgdGhlIGRldl93YXJuKCkgb25seSBvY2N1cnMgd2hlbiB0aGVy
ZSBpcyBhIGdlbnVpbmUNCj4gaXNzdWUuDQo+DQo+IEZpeGVzOiA4NmRhMjhlZWQ0ZmIgKCJod21v
bjogKGFkdDc0NzUpIEFkZCBzdXBwb3J0IGZvciBpbnZlcnRpbmcgcHdtIG91dHB1dCIpDQo+IFJl
cG9ydGVkLWJ5OiBNYXJpdXN6IEJpYcWCb8WEY3p5ayA8bWFuaW9Ac2t5Ym9vLm5ldD4NCj4gU2ln
bmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNv
Lm56Pg0KPiAtLS0NCj4gICBkcml2ZXJzL2h3bW9uL2FkdDc0NzUuYyB8IDkgKysrKysrKystDQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9od21vbi9hZHQ3NDc1LmMgYi9kcml2ZXJzL2h3bW9uL2FkdDc0
NzUuYw0KPiBpbmRleCA2ZTRjOTJiNTAwYjguLmFmOTA2ZWVlNDgwZSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9od21vbi9hZHQ3NDc1LmMNCj4gKysrIGIvZHJpdmVycy9od21vbi9hZHQ3NDc1LmMN
Cj4gQEAgLTE2MDcsNiArMTYwNywxMyBAQCBzdGF0aWMgaW50IGFkdDc0NzVfc2V0X3B3bV9wb2xh
cml0eShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KQ0KPiAgIAlyZXQgPSBvZl9wcm9wZXJ0eV9y
ZWFkX3UzMl9hcnJheShjbGllbnQtPmRldi5vZl9ub2RlLA0KPiAgIAkJCQkJICJhZGkscHdtLWFj
dGl2ZS1zdGF0ZSIsIHN0YXRlcywNCj4gICAJCQkJCSBBUlJBWV9TSVpFKHN0YXRlcykpOw0KPiAr
CS8qDQo+ICsJICogLUVJTlZBTCBpbmRpY2F0ZXMgdGhhdCB0aGUgcHJvcGVydHkgaXMgYWJzZW50
LCAtRU5PU1lTIGluZGljYXRlcw0KPiArCSAqIHRoYXQgdGhlIHBsYXRmb3JtIGxhY2tzIERUIGF3
YXJlbmVzcy4gTmVpdGhlciBvZiB0aGVzZSBhcmUgZXJyb3JzDQo+ICsJICogZm9yIHRoZSBvcHRp
b25hbCBwd20gcG9sYXJpdHkgc3VwcG9ydC4NCj4gKwkgKi8NCj4gKwlpZiAocmV0ID09IC1FSU5W
QUwgfHwgcmV0ID09IC1FTk9TWVMpDQo+ICsJCXJldHVybiAwOw0KSSB3YXMgbG9va2luZyBhcm91
bmQgZm9yIHdoeSB0aGVyZSB3ZXJlbid0IG1vcmUgY2hlY2tzIG9mIC1FTk9TWVMgYW5kIEkgDQpz
dXNwZWN0IHRoZSBhbnN3ZXIgaXMgSSBzaG91bGQgYmUgdXNpbmcgZGV2aWNlX3Byb3BlcnR5X3Jl
YWRfdTMyX2FycmF5KCkgDQppbnN0ZWFkLiBXaXRoIHRoZSBpbmRpcmVjdGlvbiBJJ20gbm90IDEw
MCUgc3VyZSB0aGF0IEknbGwgYWN0dWFsbHkgZ2V0IA0KdGhlIC1FSU5WQUwgb24gYSBEVCB1bmF3
YXJlIHBsYXRmb3JtLCBjYW4gYW55b25lIGNvbmZpcm0gdGhpcz8NCj4gICAJaWYgKHJldCkNCj4g
ICAJCXJldHVybiByZXQ7DQo+ICAgDQo+IEBAIC0xNzQxLDcgKzE3NDgsNyBAQCBzdGF0aWMgaW50
IGFkdDc0NzVfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCkNCj4gICAJCWFkdDc0NzVf
cmVhZF9wd20oY2xpZW50LCBpKTsNCj4gICANCj4gICAJcmV0ID0gYWR0NzQ3NV9zZXRfcHdtX3Bv
bGFyaXR5KGNsaWVudCk7DQo+IC0JaWYgKHJldCAmJiByZXQgIT0gLUVJTlZBTCkNCj4gKwlpZiAo
cmV0KQ0KPiAgIAkJZGV2X3dhcm4oJmNsaWVudC0+ZGV2LCAiRXJyb3IgY29uZmlndXJpbmcgcHdt
IHBvbGFyaXR5XG4iKTsNCj4gICANCj4gICAJLyogU3RhcnQgbW9uaXRvcmluZyAqLw==
