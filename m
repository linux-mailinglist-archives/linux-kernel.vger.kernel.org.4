Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8368970E6C8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbjEWUnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbjEWUnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:43:04 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62ED1B0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 13:42:53 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 94C632C0547
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:42:45 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1684874565;
        bh=3HCt0RYcLOHl/7lJu7nobUDi+DXbc9VyRc22PcCTlRk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Imfpo1jLM1UalciAyS5Gp5zlm1UGJQ0xpEmu7AnhV0LCiJYQKIGbzD7rc8KDo+9SJ
         3oG3vfebNNAFlwMUvcQeO9+K69/9ifZ/SO2UFQAzodIuzETPxX04hNSUXg+xKz/WdQ
         cVhWMxnQEBsWt06RAVfwwJ2cBub3XyiVocPLHAy+ntgBAOWVlwGj0tNdnx1i1mSOB/
         gXdmGp6Z7JuC8g0m5LS64YeMUJeGQStnRueJls56SSUVd8rYFDuciMpS6b6ImsU6oJ
         hhVXbfvCsm0/i0/sJgQbOyM/kX+9wFy2WDf+y5R+FOHR9x7xEk1MxQi1Vh0zgOR9la
         fHUsOvZReg3/w==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B646d25450001>; Wed, 24 May 2023 08:42:45 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 May 2023 08:42:45 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Wed, 24 May 2023 08:42:45 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: rawnand: marvell: ensure timing values are written
Thread-Topic: [PATCH] mtd: rawnand: marvell: ensure timing values are written
Thread-Index: AQHZjSWbCBLJ6S7Zo0GoZVnN6RU0wK9m0XwAgAC5T4A=
Date:   Tue, 23 May 2023 20:42:45 +0000
Message-ID: <1c039840-25a4-875c-7dc5-f13c522b8156@alliedtelesis.co.nz>
References: <20230523032103.208213-1-chris.packham@alliedtelesis.co.nz>
 <20230523113930.48c631d4@xps-13>
In-Reply-To: <20230523113930.48c631d4@xps-13>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1847FA52AD787439652913AD4779671@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=P-IC7800AAAA:8 a=yPUIj7xwZ9JUL6fvYTsA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
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

DQpPbiAyMy8wNS8yMyAyMTozOSwgTWlxdWVsIFJheW5hbCB3cm90ZToNCj4gSGkgQ2hyaXMsDQo+
DQo+IGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5ueiB3cm90ZSBvbiBUdWUsIDIzIE1h
eSAyMDIzIDE1OjIxOjAzDQo+ICsxMjAwOg0KPg0KPj4gV2hlbiBuZXcgdGltaW5nIHZhbHVlcyBh
cmUgY2FsY3VsYXRlZCBpbiBtYXJ2ZWxsX25mY19zZXR1cF9pbnRlcmZhY2UoKQ0KPj4gZW5zdXJl
IHRoYXQgdGhleSB3aWxsIGJlIGFwcGxpZWQgaW4gbWFydmVsbF9uZmNfc2VsZWN0X3RhcmdldCgp
IGJ5DQo+PiBjbGVhcmluZyB0aGUgc2VsZWN0ZWRfY2hpcCBwb2ludGVyLg0KPj4NCj4+IFN1Z2dl
c3RlZC1ieTogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4+IFNp
Z25lZC1vZmYtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5j
by5uej4NCj4gSSBiZWxpZXZlIHRoaXMgcGF0Y2ggZGVzZXJ2ZXMgRml4ZXMrQ2M6c3RhYmxlPw0K
DQpJIGFncmVlLiBJIGp1c3Qgd2Fzbid0IHN1cmUgd2hhdCB0byBwb2ludCBhdCB3aXRoIHRoZSBm
aXhlcyB0YWcgc2luY2UgDQp5b3UgbWVudGlvbmVkIHRoYXQgaXQncyBwcm9iYWJseSBhIHJlc3Vs
dCBpbiBzb21lIG9mIHRoZSBjb3JlIE5BTkQgDQppbmZyYXN0cnVjdHVyZSBjaGFuZ2luZy4NCg0K
TWF5YmUgYjI1MjUxNDE0ZjZlMDAgKCJtdGQ6IHJhd25hbmQ6IG1hcnZlbGw6IFN0b3AgaW1wbGVt
ZW50aW5nIA0KLT5zZWxlY3RfY2hpcCgpIikgaXMgdGhlIGNvcnJlY3QgY2hhbmdlIHRvIHBvaW50
IGF0Lg0KDQo+PiAtLS0NCj4+DQo+PiBOb3RlczoNCj4+ICAgICAgVGhpcyBhdCBsZWFzdCBnZXRz
IG1lIHRvIGEgcG9pbnQgd2hlcmUgSSBjYW4gaWxsdXN0cmF0ZWQgdGhlIHByb2JsZW0NCj4+ICAg
ICAgcmVwb3J0ZWQgdG8gbWUuIEl0IGFwcGVhcnMgdGhhdCBkZXNwaXRlIHRoZSBjaGlwIGNvcnJl
Y3RseSByZXBvcnRpbmcNCj4+ICAgICAgc3VwcG9ydCBmb3IgU0RSIHRpbWluZyBtb2RlcyB1cCB0
byA0IHRoZSBvYnNlcnZlZCB0V0MgaXMgMjBucy4gSSd2ZSBub3QNCj4+ICAgICAgc2VlbiBhbnkg
YWN0dWFsIHByb2JsZW0gcnVubmluZyBpbiB0aGlzIHN0YXRlIHRoZSBvbmx5IGNvbXBsYWludCBp
cyB0aGF0DQo+PiAgICAgIHRoZSBkYXRhc2hlZXQgc2F5cyB0aGUgbWluaW11bSB0V0MgaXMgMjVu
cy4NCj4+ICAgICAgDQo+PiAgICAgIElmIEkgbWFrZSBhIGNoYW5nZSB0byBteSBib290bG9hZGVy
IHN1Y2ggdGhhdCB0aGUgTkFORCBDbG9jayBGcmVxdWVuY3kNCj4+ICAgICAgU2VsZWN0IGJpdCAo
MHhGMjQ0MDcwMDowKSB0byAxIGJlZm9yZSBib290aW5nIHRoZSBrZXJuZWwgX2FuZF8gSSByZW1v
dmUNCj4+ICAgICAgdGhlIGV4dHJhIGZhY3RvciBvZiAyIGZyb20gdGhlIHBlcmlvZF9ucyBjYWxj
dWxhdGlvbiBJIG9ic2VydmUgdFdDIG9mDQo+PiAgICAgIGFib3V0IDYwbnMuIElmIEkgZG9uJ3Qg
cmVtb3ZlIHRoZSBmYWN0b3Igb2YgMiB0aGUgTkFORCBpbnRlcmZhY2UgZG9lc24ndA0KPj4gICAg
ICB3b3JrIChjYW4ndCB3cml0ZSBCQlQpLg0KPj4NCj4+ICAgZHJpdmVycy9tdGQvbmFuZC9yYXcv
bWFydmVsbF9uYW5kLmMgfCA2ICsrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L21hcnZlbGxf
bmFuZC5jIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvbWFydmVsbF9uYW5kLmMNCj4+IGluZGV4IGFm
YjQyNDU3OWYwYi4uM2I1ZTRkNWQyMjBmIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tdGQvbmFu
ZC9yYXcvbWFydmVsbF9uYW5kLmMNCj4+ICsrKyBiL2RyaXZlcnMvbXRkL25hbmQvcmF3L21hcnZl
bGxfbmFuZC5jDQo+PiBAQCAtMjQ1Nyw2ICsyNDU3LDEyIEBAIHN0YXRpYyBpbnQgbWFydmVsbF9u
ZmNfc2V0dXBfaW50ZXJmYWNlKHN0cnVjdCBuYW5kX2NoaXAgKmNoaXAsIGludCBjaGlwbnIsDQo+
PiAgIAkJCU5EVFIxX1dBSVRfTU9ERTsNCj4+ICAgCX0NCj4+ICAgDQo+PiArCS8qDQo+PiArCSAq
IFJlc2V0IG5mYy0+c2VsZWN0ZWRfY2hpcCBzbyB0aGUgbmV4dCBjb21tYW5kIHdpbGwgY2F1c2Ug
dGhlIHRpbWluZw0KPj4gKwkgKiByZWdpc3RlcnMgdG8gYmUgcmVzdG9yZWQgaW4gbWFydmVsbF9u
ZmNfc2VsZWN0X3RhcmdldCgpLg0KPj4gKwkgKi8NCj4gcy9yZXN0b3JlZC91cGRhdGVkLyA/DQo+
DQo+IFJlc3RvcmVkIGZlZWxzIGxpa2UgdGhlIGNvbnRlbnQgdmFuaXNoZWQuDQpPSy4gV2lsbCBz
ZW5kIGEgdjIgbGF0ZXIgdG9kYXkuDQo+PiArCW5mYy0+c2VsZWN0ZWRfY2hpcCA9IE5VTEw7DQo+
PiArDQo+PiAgIAlyZXR1cm4gMDsNCj4+ICAgfQ0KPj4gICANCj4NCj4gVGhhbmtzLA0KPiBNaXF1
w6hs
