Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3B971427E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 06:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjE2EIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 00:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjE2EIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 00:08:19 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9D1AF
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 21:08:16 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 191472C0596;
        Mon, 29 May 2023 16:08:14 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685333294;
        bh=oKlYQC0LT6sfil+DPN2R63ASzsz4+4zowbTWgSU7fY8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=q8eE82hfZHB/48waBxAYHQeP0R0gMP6+Ou/5fjSBck72VnFnYbEwHOyBGCoxsdDE3
         eRq+i5wIh1ivcURrQP3S9uzqBLSZEHe9cv9PS3J0Mgaok7ds7Wm5LOwacsAtFVEDXb
         1CBDAbr35lSPNJ3oKAFVcvmtZ3fjpK53Dbij1RZmmUHGP7BrT5f0WhWWj9CrjYhvOa
         jgm054H0xXjqjJMrN3kJ+uisoMKIybH4snCzUKVgOsW7sjY4e23XplqUlRQXU8ACLR
         tE4SXRE5f48T+5x9NZhs0yevOhOhO/MBqAPdHeRZ7dCSmq24VPhqyz7oqx9RUQVU5X
         /LIFIjMxqNlKQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6474252e0000>; Mon, 29 May 2023 16:08:14 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Mon, 29 May 2023 16:08:13 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Mon, 29 May 2023 16:08:13 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Mon, 29 May 2023 16:08:13 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Johan Hovold <johan@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "warthog618@gmail.com" <warthog618@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gpiolib: Avoid side effects in gpio_is_visible()
Thread-Topic: [PATCH v2] gpiolib: Avoid side effects in gpio_is_visible()
Thread-Index: AQHZig/BTFGZ3AxBtUaao6thQCRKf69gloYAgAswboCAAAZKAIADqjcAgABxoIA=
Date:   Mon, 29 May 2023 04:08:13 +0000
Message-ID: <f8894ec1-0af4-9566-5836-30b23bf40110@alliedtelesis.co.nz>
References: <20230519050702.3681791-1-chris.packham@alliedtelesis.co.nz>
 <CAHp75Vcd8Q+-XMyfg3Y_hv_AL00PGgqg0jo7Yd7TTC4GrxPOuQ@mail.gmail.com>
 <CAMRc=MdHMiqhcpd2rFwjfKvwMWtTeTxG4fK+7zbzgSq9MHmGew@mail.gmail.com>
 <ZHCy1PhyNAOCsalJ@hovoldconsulting.com>
 <47cf842e-5ff5-e185-6f8f-351e886047b6@alliedtelesis.co.nz>
In-Reply-To: <47cf842e-5ff5-e185-6f8f-351e886047b6@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2028263B5443BF45B4A64C2ACC63421F@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=pGLkceISAAAA:8 a=K8AQLKREUDc6VxAMmqQA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyOS8wNS8yMyAwOToyMSwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4NCj4gT24gMjcvMDUv
MjMgMDE6MjMsIEpvaGFuIEhvdm9sZCB3cm90ZToNCj4+IE9uIEZyaSwgTWF5IDI2LCAyMDIzIGF0
IDAzOjAxOjAxUE0gKzAyMDAsIEJhcnRvc3ogR29sYXN6ZXdza2kgd3JvdGU6DQo+Pj4gT24gRnJp
LCBNYXkgMTksIDIwMjMgYXQgMTI6MDnigK9QTSBBbmR5IFNoZXZjaGVua28NCj4+PiA8YW5keS5z
aGV2Y2hlbmtvQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4+IE9uIEZyaSwgTWF5IDE5LCAyMDIzIGF0
IDg6MDfigK9BTSBDaHJpcyBQYWNraGFtDQo+Pj4+IDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVz
aXMuY28ubno+IHdyb3RlOg0KPj4+Pj4gT24gYSBzeXN0ZW0gd2l0aCBwY2E5NTU1IEdQSU9zIHRo
YXQgaGF2ZSBiZWVuIGV4cG9ydGVkIHZpYSBzeXNmcyB0aGUNCj4+Pj4+IGZvbGxvd2luZyB3YXJu
aW5nIGNvdWxkIGJlIHRyaWdnZXJlZCBvbiBrZXhlYygpLg0KPj4+Pj4NCj4+Pj4+IMKgwqAgV0FS
TklORzogQ1BVOiAwIFBJRDogMjY1IGF0IGRyaXZlcnMvZ3Bpby9ncGlvbGliLmM6MzQxMSANCj4+
Pj4+IGdwaW9jaGlwX2Rpc2FibGVfaXJxDQo+Pj4+PiDCoMKgIENhbGwgdHJhY2U6DQo+Pj4+PiDC
oMKgwqAgZ3Bpb2NoaXBfZGlzYWJsZV9pcnENCj4+Pj4+IMKgwqDCoCBtYWNoaW5lX2NyYXNoX3No
dXRkb3duDQo+Pj4+PiDCoMKgwqAgX19jcmFzaF9rZXhlYw0KPj4+Pj4gwqDCoMKgIHBhbmljDQo+
Pj4+PiDCoMKgwqAgc3lzcnFfcmVzZXRfc2VxX3BhcmFtX3NldA0KPj4+Pj4gwqDCoMKgIF9faGFu
ZGxlX3N5c3JxDQo+Pj4+PiDCoMKgwqAgd3JpdGVfc3lzcnFfdHJpZ2dlcg0KPj4+Pj4NCj4+Pj4+
IFRoZSB3YXJuaW5nIGlzIHRyaWdnZXJlZCBiZWNhdXNlIHRoZXJlIGlzIGFuIGlycV9kZXNjIGZv
ciB0aGUgR1BJTyANCj4+Pj4+IGJ1dA0KPj4+Pj4gaXQgZG9lcyBub3QgaGF2ZSB0aGUgRkxBR19V
U0VEX0FTX0lSUSBzZXQuIFRoaXMgaXMgYmVjYXVzZSB3aGVuIA0KPj4+Pj4gdGhlIEdQSU8NCj4+
Pj4+IGlzIGV4cG9ydGVkIHZpYSBncGlvZF9leHBvcnQoKSwgZ3Bpb19pc192aXNpYmxlKCkgaXMg
dXNlZCB0byANCj4+Pj4+IGRldGVybWluZQ0KPj4+Pj4gaWYgdGhlICJlZGdlIiBhdHRyaWJ1dGUg
c2hvdWxkIGJlIHByb3ZpZGVkIGJ1dCBpbiBkb2luZyBzbyBpdCBlbmRzIHVwDQo+Pj4+PiBjYWxs
aW5nIGdwaW9jaGlwX3RvX2lycSgpIHdoaWNoIGNyZWF0ZXMgdGhlIGlycV9kZXNjLg0KPj4+Pj4N
Cj4+Pj4+IFJlbW92ZSB0aGUgY2FsbCB0byBncGlvZF90b19pcnEoKSBmcm9tIGdwaW9faXNfdmlz
aWJsZSgpLiBUaGUgYWN0dWFsDQo+Pj4+PiBpbnRlbmRlZCBjcmVhdGlvbiBvZiB0aGUgaXJxX2Rl
c2MgY29tZXMgdmlhIGVkZ2Vfc3RvcmUoKSB3aGVuIA0KPj4+Pj4gcmVxdWVzdGVkDQo+Pj4+PiBi
eSB0aGUgdXNlci4NCj4+Pj4gVG8gbWUgaXQgc3RpbGwgc291bmRzIGxpa2UgYSBoYWNrIGFuZCB0
aGUgcmVhbCBzb2x1dGlvbiBzaG91bGQgYmUgZG9uZQ0KPj4+PiBkaWZmZXJlbnRseS9lbHNld2hl
cmUuDQo+Pj4+DQo+Pj4+IEFsc28gSSdtIHdvcnJ5aW5nIHRoYXQgbm90IGhhdmluZyB0aGlzIGZp
bGUgdmlzaWJsZSBvciBub3QgbWF5IGFmZmVjdA0KPj4+PiBleGlzdGluZyB1c2VyIHNwYWNlIGN1
c3RvbSBzY3JpcHRzIHdlIHdpbGwgbmV2ZXIgaGVhciBhYm91dC4NCj4+Pj4NCj4+Pj4gUC5TLiBU
QkgsIEkgZG9uJ3QgY2FyZSBtdWNoIGFib3V0IHN5c2ZzLCBzbyBpZiB0aGlzIHBhdGNoIGZpbmRz
IGl0cw0KPj4+PiB3YXkgdXBzdHJlYW0sIEkgd29uJ3QgYmUgdW5oYXBweS4NCj4+Pj4NCj4+PiBT
YW1lLiBXaGljaCBpcyB3aHkgLSBpZiB0aGVyZSdsbCBiZSBubyBtb3JlIG9iamVjdGlvbnMsIEkg
d2lsbCBhcHBseSANCj4+PiBpdC4NCj4+IEkgZG9uJ3QgdGhpbmsgdGhpcyBzaG91bGQgYmUgYXBw
bGllZC4NCj4+DQo+PiBJdCdzIHN0aWxsIG5vdCBjbGVhciBmcm9tIHRoZSBjb21taXQgbWVzc2Fn
ZSB3aHkgZ3Bpb2NoaXBfZGlzYWJsZV9pcnEoKQ0KPj4gaXMgY2FsbGVkIGZvciBhIGxpbmUgd2hp
Y2ggaGFzIG5vdCBiZWVuIHJlcXVlc3RlZC4NCj4NCj4gVGhlIGNvZGUgdGhhdCBkb2VzIHRoZSBj
YWxsaW5nIGlzIGluIG1hY2hpbmVfa2V4ZWNfbWFza19pbnRlcnJ1cHRzKCkuIA0KPiBUaGUgcHJv
YmxlbSBpcyB0aGF0IGZvciBzb21lIGlycV9jaGlwcyBpcnFfbWFzayBpcyBzZXQgdG8gdGhlIGRp
c2FibGUgDQo+IGZ1bmN0aW9uLiBUaGUgZGlzYWJsZSBjYWxsIGltbWVkaWF0ZWx5IGFmdGVyIHRo
ZSBtYXNrIGNhbGwgZG9lcyBjaGVjayANCj4gdG8gc2VlIGlmIHRoZSBpcnEgaXMgbm90IGFscmVh
ZHkgZGlzYWJsZWQuDQo+DQo+PiDCoCBUaGF0IHNlZW1zIGxpa2Ugd2hhdA0KPj4gc2hvdWxkIGJl
IGZpeGVkLCBub3QgY2hhbmdpbmcgc29tZSBiZWhhdmlvdXIgaW4gdGhlIGdwaW8gc3lzZnMgaW50
ZXJmYWNlDQo+PiB3aGljaCBoYXMgYmVlbiB0aGVyZSBzaW5jZSBmb3JldmVyIChlLmcuIGRvIG5v
dCBjcmVhdGUgdGhlIGVkZ2UNCj4+IGF0dHJpYnV0ZXMgZm9yIGdwaW9zIHRoYXQgY2Fubm90IGJl
IHVzZWQgYXMgaW50ZXJydXB0cykuDQo+DQo+IEkgZG9uJ3QgZGlzYWdyZWUgd2l0aCB0aGUgc2Vu
dGltZW50LiBUaGUgcHJvYmxlbSBpcyB0aGVyZSBkb2Vzbid0IA0KPiBhcHBlYXIgdG8gYmUgYW4g
QVBJIHRoYXQgY2FuIHRlbGwgaWYgYSBHUElPIHBpbiBpcyBjYXBhYmxlIG9mIGJlaW5nIGFuIA0K
PiBpcnEgd2l0aG91dCBhY3R1YWxseSBjb252ZXJ0aW5nIGl0IGludG8gb25lLg0KPg0KPj4gVGhl
cmUgYXJlIG90aGVyIHdheXMgdGhhdCBtYXBwaW5ncyBjYW4gYmUgY3JlYXRlZCAoZS5nLiBhIGdw
aW8gdGhhdA0KPj4gcmVxdWVzdGVkIGFzIGFzIGludGVycnVwdCBhbmQgdGhlbiByZWxlYXNlZCkg
d2hpY2ggd291bGQgdHJpZ2dlciB0aGUNCj4+IHNhbWUgd2FybmluZyBpdCBzZWVtcy4NCj4gSSd2
ZSB0cmllZCBhIGZldyBvZiB0aG9zZSBjYXNlcyBhbmQgaGF2ZW4ndCBiZWVuIGFibGUgdG8gcHJv
dm9rZSB0aGUgDQo+IHNhbWUgd2FybmluZy4gZ3Bpb19zeXNmc19mcmVlX2lycSgpIHNlZW1zIHRv
IGNsZWFyIHdoYXRldmVyIGZsYWdzIA0KPiBncGlvY2hpcF9kaXNhYmxlX2lycSgpIGlzIGNvbXBs
YWluaW5nIGFib3V0Lg0KPj4gRml4IHRoZSByb290IGNhdXNlLCBkb24ndCBqdXN0IHBhcGVyIG92
ZXIgdGhlIHN5bXB0b20uDQo+IEkgdGhpbmsgbWF5YmUgdGhlcmUgaXMgYSBjb21wcm9taXNlIHdo
ZXJlIEkgZG8gc29tZXRoaW5nIGluIA0KPiBncGlvY2hpcF90b19pcnEoKSBpbnN0ZWFkIG9mIGdw
aW9faXNfdmlzaWJsZSgpLiBJJ20gbm90IGVudGlyZWx5IHN1cmUgDQo+IHdoYXQgdGhhdCBzb21l
dGhpbmcgaXMNCj4+DQpJcm9uaWNhbGx5IEkgdHJpZWQgdG8gcmV2aXNpdCBteSBmaXggYnV0IGZv
dW5kIEkgd2FzIG5vIGxvbmdlciBhYmxlIHRvIA0KcmVwcm9kdWNlIHRoZSBpc3N1ZS4gVHVybnMg
b3V0IGNvbW1pdCA3ZGQzZDliZDg3M2YgKCJncGlvbGliOiBmaXggDQphbGxvY2F0aW9uIG9mIG1p
eGVkIGR5bmFtaWMvc3RhdGljIEdQSU9zIikgaGFzIGZpeGVkIGl0IGZvciBtZSBidXQgSSANCmRv
bid0IGVudGlyZWx5IHVuZGVyc3RhbmQgaG93Lg==
