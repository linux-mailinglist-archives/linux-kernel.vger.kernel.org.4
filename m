Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490A4702072
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 00:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjENW1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 18:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjENW1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 18:27:44 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB7110F0
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 15:27:41 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BC2272C0616;
        Mon, 15 May 2023 10:27:39 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1684103259;
        bh=+AvGVwzEf60CveOQLLysrbI7WP5AXv+puofwPzspQHs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=K4DiqR3puC7ofTBnyUtnjQNYssQsW/7nCjYroRY+TX/OeqlZ37l9SjhRNu0ggWtsG
         AqrHdhF4DFDbXjMd4rVuqDVYRAq7LqhvkLZc8+4/2qHZr2ImiJOO2BPqtd8oMgEDOD
         MUkJxB1CwFZn0UtOO8/2RaBN2VaLjiV1uyIXdXpbvQlVyl6DJSKsWXaki6DbMOrTO0
         Xu1Q0lZtzEYZsJTZY3lAGm/u/XALkjink+cp2QgEafTdoKwOFgAiqmVQ22ZggtGZaz
         Mcs9gJLiP9BNFFCXWVG+0PMsE/OwdsgWEM/yvHMCC2XXw/XoUjKv6R3eJK7+L+UgTs
         JZdqkHtZUQnsA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6461605b0001>; Mon, 15 May 2023 10:27:39 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Mon, 15 May 2023 10:27:39 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Mon, 15 May 2023 10:27:39 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Mon, 15 May 2023 10:27:39 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "johan@kernel.org" <johan@kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "maz@kernel.org" <maz@kernel.org>,
        Ben Brown <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Thread-Topic: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Thread-Index: AQHZhIoofApft8Zm8kuYZtpxH+f53K9VfDeAgAQYHQA=
Date:   Sun, 14 May 2023 22:27:39 +0000
Message-ID: <b36fcdf1-45ab-0c06-efe4-237df0612466@alliedtelesis.co.nz>
References: <20230512042806.3438373-1-chris.packham@alliedtelesis.co.nz>
 <CACRpkdYz9ipNTo2ORXKWy5Q4uCpKL=9Gd+kK76pestX7Onuz-Q@mail.gmail.com>
In-Reply-To: <CACRpkdYz9ipNTo2ORXKWy5Q4uCpKL=9Gd+kK76pestX7Onuz-Q@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5931000D419CE41BC4D2C25AD53F2D6@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=wZaDqkZhScmTiNAJxg4A:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMi8wNS8yMyAxOTo1NiwgTGludXMgV2FsbGVpaiB3cm90ZToNCj4gT24gRnJpLCBNYXkg
MTIsIDIwMjMgYXQgNjoyOOKAr0FNIENocmlzIFBhY2toYW0NCj4gPGNocmlzLnBhY2toYW1AYWxs
aWVkdGVsZXNpcy5jby5uej4gd3JvdGU6DQo+DQo+PiBDYWxsaW5nIGdwaW9kX3RvX2lycSgpIGNy
ZWF0ZXMgYW4gaXJxX2Rlc2MgZm9yIHRoZSBHUElPLg0KPiBOb3JtYWxseSBncGlvZF90b19pcnEo
KSBzaG91bGQgbm90IGhhdmUgc2lkZSBlZmZlY3RzLCBpdCdzIGp1c3QNCj4gYSBoZWxwZXIgZnVu
Y3Rpb24gdGhhdCBpcyB0aGVyZSB0byB0cmFuc2xhdGUgYSBkZXNjcmlwdG9yIHRvIHRoZQ0KPiBj
b3JyZXNwb25kaW5nIElSUSBudW1iZXIuDQo+DQo+PiBUaGlzIGlzIG5vdA0KPj4gc29tZXRoaW5n
IHRoYXQgc2hvdWxkIGhhcHBlbiB3aGVuIGp1c3QgZXhwb3J0aW5nIHRoZSBHUElPIHZpYSBzeXNm
cy4gVGhlDQo+PiBlZmZlY3Qgb2YgdGhpcyB3YXMgb2JzZXJ2ZWQgYXMgdHJpZ2dlcmluZyBhIHdh
cm5pbmcgaW4NCj4+IGdwaW9jaGlwX2Rpc2FibGVfaXJxKCkgd2hlbiBrZXhlYygpaW5nIGFmdGVy
IGV4cG9ydGluZyBhIEdQSU8uDQoNCkZvciBjbGFyaXR5IHRoaXMgaXMgdGhlIHByb2JsZW0gSSBz
ZWUgb24ga2V4ZWMNCg0KV0FSTklORzogQ1BVOiAxIFBJRDogMjM1IGF0IGRyaXZlcnMvZ3Bpby9n
cGlvbGliLmM6MzQ0MCANCmdwaW9jaGlwX2Rpc2FibGVfaXJxKzB4NjQvMHg2Yw0KQ2FsbCB0cmFj
ZToNCiDCoGdwaW9jaGlwX2Rpc2FibGVfaXJxKzB4NjQvMHg2Yw0KIMKgbWFjaGluZV9jcmFzaF9z
aHV0ZG93bisweGFjLzB4MTE0DQogwqBfX2NyYXNoX2tleGVjKzB4NzQvMHgxNTQNCiDCoHBhbmlj
KzB4MzAwLzB4MzcwDQogwqBzeXNycV9yZXNldF9zZXFfcGFyYW1fc2V0KzB4MC8weDhjDQogwqBf
X2hhbmRsZV9zeXNycSsweGI4LzB4MWI4DQogwqB3cml0ZV9zeXNycV90cmlnZ2VyKzB4NzQvMHhh
MA0KIMKgcHJvY19yZWdfd3JpdGUrMHg5Yy8weGYwDQogwqB2ZnNfd3JpdGUrMHhjNC8weDI5OA0K
IMKga3N5c193cml0ZSsweDY4LzB4ZjQNCiDCoF9fYXJtNjRfc3lzX3dyaXRlKzB4MWMvMHgyOA0K
IMKgaW52b2tlX3N5c2NhbGwrMHg0OC8weDExNA0KIMKgZWwwX3N2Y19jb21tb24uY29uc3Rwcm9w
LjArMHg0NC8weGY0DQogwqBkb19lbDBfc3ZjKzB4M2MvMHhhOA0KIMKgZWwwX3N2YysweDJjLzB4
ODQNCiDCoGVsMHRfNjRfc3luY19oYW5kbGVyKzB4YmMvMHgxMzgNCiDCoGVsMHRfNjRfc3luYysw
eDE5MC8weDE5NA0KDQo+PiBSZW1vdmUgdGhlIGNhbGwgdG8gZ3Bpb2RfdG9faXJxKCkgZnJvbSBn
cGlvX2lzX3Zpc2libGUoKS4gVGhlIGFjdHVhbA0KPj4gaW50ZW5kZWQgY3JlYXRpb24gb2YgdGhl
IGlycV9kZXNjIGNvbWVzIHZpYSBlZGdlX3N0b3JlKCkgd2hlbiByZXF1ZXN0ZWQNCj4+IGJ5IHRo
ZSB1c2VyLg0KPj4NCj4+IEZpeGVzOiBlYmJlYmExMjBhYjIgKCJncGlvOiBzeXNmczogZml4IGdw
aW8gYXR0cmlidXRlLWNyZWF0aW9uIHJhY2UiKQ0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFj
a2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPiBJIGhhdmUgYSBoYXJk
IHRpbWUgdW5kZXJzdGFuZGluZyB0aGlzIGZpeC4NCg0KVGhlIHByb2JsZW0gKGFzIEkgZmFyIGFz
IEkndmUgYmVlbiBhYmxlIHRvIGRldGVybWluZSkuIElzIHRoYXQgDQpncGlvX2lzX3Zpc2libGUo
KSB1c2VzIGdwaW9kX3RvX2lycSgpIHRvIGRlY2lkZSB3aGV0aGVyIHRvIHByb3ZpZGUgdGhlIA0K
ImVkZ2UiIGF0dHJpYnV0ZS4gVGhlIHByb2JsZW0gaXMgdGhhdCBpbnN0ZWFkIG9mIGp1c3QgbG9v
a2luZyB1cCB0aGUgDQppcnFfZGVzYyBmcm9tIHRoZSBHUElPIHBpbiBncGlvZF90b19pcnEoKSBh
Y3R1YWxseSBjcmVhdGVzIHRoZSBpcnFfZGVzYyANCih2aWHCoCBncGlvY2hpcF90b19pcnEoKSku
DQoNCkJlY2F1c2UgZ3Bpb19zeXNmc19yZXF1ZXN0X2lycSgpIGNhbGxzIGdwaW9jaGlwX3RvX2ly
cSgpIGFueXdheSB0byANCmNyZWF0ZSB0aGUgaXJxX2Rlc2MgSSB0aG91Z2h0IHJlbW92aW5nIGdw
aW9jaGlwX3RvX2lycSgpIGZyb20gDQpncGlvX2lzX3Zpc2libGUoKSBzaG91bGQgYmUgc2FmZS4N
Cg0KPg0KPiBUaGUgcHJvYmxlbSBpcyByYXRoZXIgdGhpcyBzZWUgZ3Bpb2xpYi5jOg0KPg0KPiBp
bnQgZ3Bpb2RfdG9faXJxKGNvbnN0IHN0cnVjdCBncGlvX2Rlc2MgKmRlc2MpDQo+IHsNCj4gICAg
ICAgICAgc3RydWN0IGdwaW9fY2hpcCAqZ2M7DQo+ICAgICAgICAgIGludCBvZmZzZXQ7DQo+DQo+
ICAgICAgICAgIC8qDQo+ICAgICAgICAgICAqIENhbm5vdCBWQUxJREFURV9ERVNDKCkgaGVyZSBh
cyBncGlvZF90b19pcnEoKSBjb25zdW1lciBzZW1hbnRpY3MNCj4gICAgICAgICAgICogcmVxdWly
ZXMgdGhpcyBmdW5jdGlvbiB0byBub3QgcmV0dXJuIHplcm8gb24gYW4gaW52YWxpZCBkZXNjcmlw
dG9yDQo+ICAgICAgICAgICAqIGJ1dCByYXRoZXIgYSBuZWdhdGl2ZSBlcnJvciBudW1iZXIuDQo+
ICAgICAgICAgICAqLw0KPiAgICAgICAgICBpZiAoIWRlc2MgfHwgSVNfRVJSKGRlc2MpIHx8ICFk
ZXNjLT5nZGV2IHx8ICFkZXNjLT5nZGV2LT5jaGlwKQ0KPiAgICAgICAgICAgICAgICAgIHJldHVy
biAtRUlOVkFMOw0KPg0KPiAgICAgICAgICBnYyA9IGRlc2MtPmdkZXYtPmNoaXA7DQo+ICAgICAg
ICAgIG9mZnNldCA9IGdwaW9fY2hpcF9od2dwaW8oZGVzYyk7DQo+ICAgICAgICAgIGlmIChnYy0+
dG9faXJxKSB7DQo+ICAgICAgICAgICAgICAgICAgaW50IHJldGlycSA9IGdjLT50b19pcnEoZ2Ms
IG9mZnNldCk7DQo+DQo+IEhlcmUgZ2MtPnRvX2lycSgpIGlzIGNhbGxlZCB1bmNvbmRpdGlvbmFs
bHkuDQo+DQo+IFNpbmNlIHRoaXMgaXMgdXNpbmcgZ3Bpb2xpYl9pcnFjaGlwIHRoaXMgLT50b19p
cnEoKSB3aWxsIGJlDQo+IGdwaW9jaGlwX3RvX2lycSgpIGFuZCB0aGF0IGZpbmFsbHkgZW5kcyBp
biB0aGUgY2FsbDoNCj4NCj4gcmV0dXJuIGlycV9jcmVhdGVfbWFwcGluZyhkb21haW4sIG9mZnNl
dCk7DQo+DQo+IHdoaWNoIHNlZW1zIHRvIGJlIHRoZSBwcm9ibGVtIGhlcmUuIFdoeSBpcyB0aGlz
IGEgcHJvYmxlbT8NCj4gVGhlIElSUSBtYXBwaW5ncyBhcmUgZHluYW1pYywgbWVhbmluZyB0aGV5
IGFyZSBjcmVhdGVkDQo+IG9uLWRlbWFuZCwgYnV0IGZvciB0aGlzIGhhcmR3YXJlIGl0IHNob3Vs
ZCBiZSBmaW5lIHRvIGVzc2VudGlhbGx5DQo+IGp1c3QgY2FsbCBpcnFfY3JlYXRlX21hcHBpbmco
KSBvbiBhbGwgb2YgdGhlbSBhcyB0aGUgZGV2aWNlDQo+IGlzIGNyZWF0ZWQsIHdlIGp1c3QgZG9u
J3QgZG8gaXQgaW4gb3JkZXIgdG8gc2F2ZSBzcGFjZS4NCg0KSW4gbXkgb3JpZ2luYWwgY2FzZSB3
aGljaCBpcyBhIGtlcm5lbCBtb2R1bGUgdGhhdCBleHBvcnRzIGEgR1BJTyBmb3IgDQp1c2Vyc3Bh
Y2UgdXNpbmcgZ3Bpb2RfZXhwb3J0KCkgaXQncyBpbmFwcHJvcHJpYXRlIGJlY2F1c2UgdGhlIEdQ
SU8gaW4gDQpxdWVzdGlvbiBpcyBjb25maWd1cmVkIGFzIGFuIG91dHB1dCBidXQgZ3Bpb19pc192
aXNpYmxlKCkgc3RpbGwgY2F1c2VzIA0KYW4gaXJxX2Rlc2MgdG8gYmUgY3JlYXRlZCBldmVuIHRo
b3VnaCB0aGUgdmVyeSBuZXh0IGxpbmUgb2YgY29kZSBrbm93cyANCnRoYXQgaXQgc2hvdWxkIG5v
dCBtYWtlIHRoZSBlZGdlIGF0dHJpYnV0ZSB2aXNpYmxlLg0KDQpUaGUgbWFudWFsbHkgZXhwb3J0
aW5nIHRoaW5ncyB2aWEgc3lzZnMgY2FzZSBpcyBhIGJpdCBtb3JlIG11cmt5IGJlY2F1c2UgDQpp
dCdzIG5vdCBrbm93biBpZiB0aGUgR1BJTyBpcyBhbiBpbnB1dCBvciBvdXRwdXQgc28gdGhlIGNv
ZGUgbXVzdCBhc3N1bWUgDQpib3RoIGFyZSBwb3NzaWJsZSAob2J2aW91c2x5IHRoaXMgaXMgb25l
IHRoaW5nIGxpYmdwaW8gZml4ZXMpLiBJIHN0aWxsIA0KdGhpbmsgY3JlYXRpbmcgdGhlIGlycV9k
ZXNjIG9uIGV4cG9ydCBpcyB3cm9uZywgaXQgc2VlbXMgdW5uZWNlc3NhcnkgYXMgDQppdCdsbCBo
YXBwZW4gaWYgYW4gaW50ZXJydXB0IGlzIGFjdHVhbGx5IHJlcXVlc3RlZCB2aWEgZWRnZV9zdG9y
ZSgpLg0KDQo+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgY2FsbGluZyBpcnFfY3JlYXRlX21hcHBp
bmcoZG9tYWluLCBvZmZzZXQpOw0KPiBjcmVhdGVzIGEgcHJvYmxlbT8gSXQncyBqdXN0IGEgbWFw
cGluZyBiZXR3ZWVuIGEgR1BJTyBhbmQgdGhlDQo+IGNvcnJlc3BvbmRpbmcgSVJRLiBXaGF0IGFt
IEkgbWlzc2luZyBoZXJlPw0KDQpUaGUgY3J1eCBvZiB0aGUgcHJvYmxlbSBpcyB0aGF0IHRoZSBp
cnFfZGVzYyBpcyBjcmVhdGVkIHdoZW4gaXQgaGFzbid0IA0KYmVlbiByZXF1ZXN0ZWQuIEluIHNv
bWUgY2FzZXMgd2Uga25vdyB0aGUgR1BJTyBwaW4gaXMgYW4gb3V0cHV0IHNvIHdlIA0KY291bGQg
YXZvaWQgaXQsIGluIG90aGVycyB3ZSBjb3VsZCBkZWxheSB0aGUgY3JlYXRpb24gdW50aWwgYW4g
aW50ZXJydXB0IA0KaXMgYWN0dWFsbHkgcmVxdWVzdGVkICh3aGljaCBpcyB3aGF0IEknbSBhdHRl
bXB0aW5nIHRvIGRvKS4NCg0KPg0KPiBZb3VycywNCj4gTGludXMgV2FsbGVpag==
