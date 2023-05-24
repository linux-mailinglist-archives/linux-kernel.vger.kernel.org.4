Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632067101CD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 01:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbjEXXuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 19:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEXXuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 19:50:04 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DF3132
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 16:50:01 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3581C2C02E0;
        Thu, 25 May 2023 11:49:47 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1684972187;
        bh=4a27tZpGUeVAxwbKAxTrxpyuPQrRyNv6hwKJVC39hRU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=fnWb9dxs2Y/WJyV8dK/t5Ogo1L0uvd9MOaeY/oyMOG8rKpqL2222aPCU3dqccjWhm
         WmStHOAINnNHWI1K1v6ArXpYiyAJn6FIbka14mYkwLQm5piQKaJWVxsPIzonOIaief
         zGTyBhIuaNSQ5HKDqFoLdUdIYDUSU4L8qW0TnZYz5hoplBVSZg6G84+TaHW2ooKcc9
         rFEEQB/JVZRidJgAKZvnqvJ86YiIkCjUNUGfOrDSOeoUY6nFqcRPAs8VfUba2fDivF
         1vB4GRG+uwISfLS72w+P+8pobpMxYalYXnRKmFx0LEn7HpzVUKL98GzDIgs/ExVteR
         ncka8Fej8qCRw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B646ea29b0001>; Thu, 25 May 2023 11:49:47 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 May 2023 11:49:46 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Thu, 25 May 2023 11:49:46 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: rawnand: marvell: ensure timing values are
 written
Thread-Topic: [PATCH v2] mtd: rawnand: marvell: ensure timing values are
 written
Thread-Index: AQHZjdODNtokZcXnnEuLkFH94ISxpa9pUAUA
Date:   Wed, 24 May 2023 23:49:46 +0000
Message-ID: <9372c8df-5604-0284-ba3a-74af4ca435e3@alliedtelesis.co.nz>
References: <20230524000551.581491-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20230524000551.581491-1-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E716FB8D48E644196FB08B558227153@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=P-IC7800AAAA:8 a=CjQ7iZMe9_sfGYb6nLMA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyNC8wNS8yMyAxMjowNSwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4gV2hlbiBuZXcgdGlt
aW5nIHZhbHVlcyBhcmUgY2FsY3VsYXRlZCBpbiBtYXJ2ZWxsX25mY19zZXR1cF9pbnRlcmZhY2Uo
KQ0KPiBlbnN1cmUgdGhhdCB0aGV5IHdpbGwgYmUgYXBwbGllZCBpbiBtYXJ2ZWxsX25mY19zZWxl
Y3RfdGFyZ2V0KCkgYnkNCj4gY2xlYXJpbmcgdGhlIHNlbGVjdGVkX2NoaXAgcG9pbnRlci4NCj4N
Cj4gRml4ZXM6IGIyNTI1MTQxNGY2ZSAoIm10ZDogcmF3bmFuZDogbWFydmVsbDogU3RvcCBpbXBs
ZW1lbnRpbmcgLT5zZWxlY3RfY2hpcCgpIikNCj4gU3VnZ2VzdGVkLWJ5OiBNaXF1ZWwgUmF5bmFs
IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNr
aGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+IC0tLQ0KPg0KPiBOb3Rl
czoNCj4gICAgICBUaGlzIGF0IGxlYXN0IGdldHMgbWUgdG8gYSBwb2ludCB3aGVyZSBJIGNhbiBp
bGx1c3RyYXRlZCB0aGUgcHJvYmxlbQ0KPiAgICAgIHJlcG9ydGVkIHRvIG1lLiBJdCBhcHBlYXJz
IHRoYXQgZGVzcGl0ZSB0aGUgY2hpcCBjb3JyZWN0bHkgcmVwb3J0aW5nDQo+ICAgICAgc3VwcG9y
dCBmb3IgU0RSIHRpbWluZyBtb2RlcyB1cCB0byA0IHRoZSBvYnNlcnZlZCB0V0MgaXMgMjBucy4g
SSd2ZSBub3QNCj4gICAgICBzZWVuIGFueSBhY3R1YWwgcHJvYmxlbSBydW5uaW5nIGluIHRoaXMg
c3RhdGUgdGhlIG9ubHkgY29tcGxhaW50IGlzIHRoYXQNCj4gICAgICB0aGUgZGF0YXNoZWV0IHNh
eXMgdGhlIG1pbmltdW0gdFdDIGlzIDI1bnMuDQo+ICAgICAgDQo+ICAgICAgSWYgSSBtYWtlIGEg
Y2hhbmdlIHRvIG15IGJvb3Rsb2FkZXIgc3VjaCB0aGF0IHRoZSBOQU5EIENsb2NrIEZyZXF1ZW5j
eQ0KPiAgICAgIFNlbGVjdCBiaXQgKDB4RjI0NDA3MDA6MCkgdG8gMSBiZWZvcmUgYm9vdGluZyB0
aGUga2VybmVsIF9hbmRfIEkgcmVtb3ZlDQo+ICAgICAgdGhlIGV4dHJhIGZhY3RvciBvZiAyIGZy
b20gdGhlIHBlcmlvZF9ucyBjYWxjdWxhdGlvbiBJIG9ic2VydmUgdFdDIG9mDQo+ICAgICAgYWJv
dXQgNjBucy4gSWYgSSBkb24ndCByZW1vdmUgdGhlIGZhY3RvciBvZiAyIHRoZSBOQU5EIGludGVy
ZmFjZSBkb2Vzbid0DQo+ICAgICAgd29yayAoY2FuJ3Qgd3JpdGUgQkJUKS4NCj4gICAgICANCj4g
ICAgICBDaGFuZ2VzIGluIHYyOg0KPiAgICAgIC0gcmV3b3JkIGNvbW1lbnQgcGVyIHN1Z2dlc3Rp
b24gZnJvbSBNaXF1ZWwsIGFkZCBmaXhlcyB0YWcNCg0KQWN0dWFsbHkgdGhpbmtpbmcgYWJvdXQg
dGhpcyBJIHNob3VsZCBwcm9iYWJseSBhbHNvIGluY2x1ZGUgYSBjaGFuZ2UgdG8gDQpkcm9wIHRo
ZSB1bmNvbmRpdGlvbmFsIE5BTkQgQ2xvY2sgRnJlcXVlbmN5IHNlbGVjdC4gU29tZSBtYXJ2ZWxs
X25hbmQgDQp1c2VycyBwcm9iYWJseSBhcmVuJ3QgZ2V0dGluZyB0aGUgYmVzdCB0aW1pbmdzIHdp
dGhvdXQgdGhpcyBjaGFuZ2UgYnV0IA0KdGhvc2Ugd2l0aCBhIHN5c3RlbSBjb250cm9sbGVyIHdp
bGwgcHJvYmFibHkgZW5kIHVwIHdpdGggdGltaW5ncyBmYXN0ZXIgDQp0aGFuIGludGVuZGVkICh3
aGljaCBtYXkgd29yayBkZXBlbmRpbmcgb24gZGVzaWduIHRvbGVyYW5jZXMpLg0KDQo+DQo+ICAg
ZHJpdmVycy9tdGQvbmFuZC9yYXcvbWFydmVsbF9uYW5kLmMgfCA2ICsrKysrKw0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRk
L25hbmQvcmF3L21hcnZlbGxfbmFuZC5jIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvbWFydmVsbF9u
YW5kLmMNCj4gaW5kZXggYWZiNDI0NTc5ZjBiLi5mMWZjZjEzNmFkMDMgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbXRkL25hbmQvcmF3L21hcnZlbGxfbmFuZC5jDQo+ICsrKyBiL2RyaXZlcnMvbXRk
L25hbmQvcmF3L21hcnZlbGxfbmFuZC5jDQo+IEBAIC0yNDU3LDYgKzI0NTcsMTIgQEAgc3RhdGlj
IGludCBtYXJ2ZWxsX25mY19zZXR1cF9pbnRlcmZhY2Uoc3RydWN0IG5hbmRfY2hpcCAqY2hpcCwg
aW50IGNoaXBuciwNCj4gICAJCQlORFRSMV9XQUlUX01PREU7DQo+ICAgCX0NCj4gICANCj4gKwkv
Kg0KPiArCSAqIFJlc2V0IG5mYy0+c2VsZWN0ZWRfY2hpcCBzbyB0aGUgbmV4dCBjb21tYW5kIHdp
bGwgY2F1c2UgdGhlIHRpbWluZw0KPiArCSAqIHJlZ2lzdGVycyB0byBiZSB1cGRhdGVkIGluIG1h
cnZlbGxfbmZjX3NlbGVjdF90YXJnZXQoKS4NCj4gKwkgKi8NCj4gKwluZmMtPnNlbGVjdGVkX2No
aXAgPSBOVUxMOw0KPiArDQo+ICAgCXJldHVybiAwOw0KPiAgIH0NCj4gICA=
