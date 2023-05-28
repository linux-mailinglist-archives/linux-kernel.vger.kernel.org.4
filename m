Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163A7714090
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 23:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjE1VVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 17:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjE1VVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 17:21:36 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38830B8
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 14:21:34 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BD57E2C0547;
        Mon, 29 May 2023 09:21:32 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685308892;
        bh=yCRJ2MVcZlpE9xqH4gn7t7dUZnonVkElKjiIxNhzjaI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=xWmSUtj9twtoV1vJHe6cAbWzpTtzgMMWEcJlY/M9nb9sM1X6JlSHIBvTCkqYUTEoL
         EKGdraFXfhOhlwvEPbWxpC/QyweIQJjYI44ru+JFeYYLxKlFJnBjkW/H6Y0YTmzZQh
         HZ+cEHrBpsJ35Lzjrcj1KN9Y7FqHZy+fmvT5KKQCtDs1IcRnrWFtk1LYbmxaMCDIbz
         cwLJZpP+cwMOaBGNkqeqmzqA2EICRKOBGGj0A/e/r229XTeww+oowY558AY6nwByYg
         AcBo2RwWbQUIQbYgL9O862s/seEUGURDE433pEl9NJ/kUxKZc043Cqev1mIcUOk0fZ
         VmmB1PqGL1IjA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6473c5dc0001>; Mon, 29 May 2023 09:21:32 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 29 May 2023 09:21:32 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Mon, 29 May 2023 09:21:32 +1200
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
Thread-Index: AQHZig/BTFGZ3AxBtUaao6thQCRKf69gloYAgAswboCAAAZKAIADqjcA
Date:   Sun, 28 May 2023 21:21:32 +0000
Message-ID: <47cf842e-5ff5-e185-6f8f-351e886047b6@alliedtelesis.co.nz>
References: <20230519050702.3681791-1-chris.packham@alliedtelesis.co.nz>
 <CAHp75Vcd8Q+-XMyfg3Y_hv_AL00PGgqg0jo7Yd7TTC4GrxPOuQ@mail.gmail.com>
 <CAMRc=MdHMiqhcpd2rFwjfKvwMWtTeTxG4fK+7zbzgSq9MHmGew@mail.gmail.com>
 <ZHCy1PhyNAOCsalJ@hovoldconsulting.com>
In-Reply-To: <ZHCy1PhyNAOCsalJ@hovoldconsulting.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <90B372F230570F469B1065936B6A1CB6@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=pGLkceISAAAA:8 a=0nnCTZ3YY-g4gahm2lQA:9 a=QEXdDO2ut3YA:10
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

DQpPbiAyNy8wNS8yMyAwMToyMywgSm9oYW4gSG92b2xkIHdyb3RlOg0KPiBPbiBGcmksIE1heSAy
NiwgMjAyMyBhdCAwMzowMTowMVBNICswMjAwLCBCYXJ0b3N6IEdvbGFzemV3c2tpIHdyb3RlOg0K
Pj4gT24gRnJpLCBNYXkgMTksIDIwMjMgYXQgMTI6MDnigK9QTSBBbmR5IFNoZXZjaGVua28NCj4+
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPiB3cm90ZToNCj4+PiBPbiBGcmksIE1heSAxOSwg
MjAyMyBhdCA4OjA34oCvQU0gQ2hyaXMgUGFja2hhbQ0KPj4+IDxjaHJpcy5wYWNraGFtQGFsbGll
ZHRlbGVzaXMuY28ubno+IHdyb3RlOg0KPj4+PiBPbiBhIHN5c3RlbSB3aXRoIHBjYTk1NTUgR1BJ
T3MgdGhhdCBoYXZlIGJlZW4gZXhwb3J0ZWQgdmlhIHN5c2ZzIHRoZQ0KPj4+PiBmb2xsb3dpbmcg
d2FybmluZyBjb3VsZCBiZSB0cmlnZ2VyZWQgb24ga2V4ZWMoKS4NCj4+Pj4NCj4+Pj4gICAgV0FS
TklORzogQ1BVOiAwIFBJRDogMjY1IGF0IGRyaXZlcnMvZ3Bpby9ncGlvbGliLmM6MzQxMSBncGlv
Y2hpcF9kaXNhYmxlX2lycQ0KPj4+PiAgICBDYWxsIHRyYWNlOg0KPj4+PiAgICAgZ3Bpb2NoaXBf
ZGlzYWJsZV9pcnENCj4+Pj4gICAgIG1hY2hpbmVfY3Jhc2hfc2h1dGRvd24NCj4+Pj4gICAgIF9f
Y3Jhc2hfa2V4ZWMNCj4+Pj4gICAgIHBhbmljDQo+Pj4+ICAgICBzeXNycV9yZXNldF9zZXFfcGFy
YW1fc2V0DQo+Pj4+ICAgICBfX2hhbmRsZV9zeXNycQ0KPj4+PiAgICAgd3JpdGVfc3lzcnFfdHJp
Z2dlcg0KPj4+Pg0KPj4+PiBUaGUgd2FybmluZyBpcyB0cmlnZ2VyZWQgYmVjYXVzZSB0aGVyZSBp
cyBhbiBpcnFfZGVzYyBmb3IgdGhlIEdQSU8gYnV0DQo+Pj4+IGl0IGRvZXMgbm90IGhhdmUgdGhl
IEZMQUdfVVNFRF9BU19JUlEgc2V0LiBUaGlzIGlzIGJlY2F1c2Ugd2hlbiB0aGUgR1BJTw0KPj4+
PiBpcyBleHBvcnRlZCB2aWEgZ3Bpb2RfZXhwb3J0KCksIGdwaW9faXNfdmlzaWJsZSgpIGlzIHVz
ZWQgdG8gZGV0ZXJtaW5lDQo+Pj4+IGlmIHRoZSAiZWRnZSIgYXR0cmlidXRlIHNob3VsZCBiZSBw
cm92aWRlZCBidXQgaW4gZG9pbmcgc28gaXQgZW5kcyB1cA0KPj4+PiBjYWxsaW5nIGdwaW9jaGlw
X3RvX2lycSgpIHdoaWNoIGNyZWF0ZXMgdGhlIGlycV9kZXNjLg0KPj4+Pg0KPj4+PiBSZW1vdmUg
dGhlIGNhbGwgdG8gZ3Bpb2RfdG9faXJxKCkgZnJvbSBncGlvX2lzX3Zpc2libGUoKS4gVGhlIGFj
dHVhbA0KPj4+PiBpbnRlbmRlZCBjcmVhdGlvbiBvZiB0aGUgaXJxX2Rlc2MgY29tZXMgdmlhIGVk
Z2Vfc3RvcmUoKSB3aGVuIHJlcXVlc3RlZA0KPj4+PiBieSB0aGUgdXNlci4NCj4+PiBUbyBtZSBp
dCBzdGlsbCBzb3VuZHMgbGlrZSBhIGhhY2sgYW5kIHRoZSByZWFsIHNvbHV0aW9uIHNob3VsZCBi
ZSBkb25lDQo+Pj4gZGlmZmVyZW50bHkvZWxzZXdoZXJlLg0KPj4+DQo+Pj4gQWxzbyBJJ20gd29y
cnlpbmcgdGhhdCBub3QgaGF2aW5nIHRoaXMgZmlsZSB2aXNpYmxlIG9yIG5vdCBtYXkgYWZmZWN0
DQo+Pj4gZXhpc3RpbmcgdXNlciBzcGFjZSBjdXN0b20gc2NyaXB0cyB3ZSB3aWxsIG5ldmVyIGhl
YXIgYWJvdXQuDQo+Pj4NCj4+PiBQLlMuIFRCSCwgSSBkb24ndCBjYXJlIG11Y2ggYWJvdXQgc3lz
ZnMsIHNvIGlmIHRoaXMgcGF0Y2ggZmluZHMgaXRzDQo+Pj4gd2F5IHVwc3RyZWFtLCBJIHdvbid0
IGJlIHVuaGFwcHkuDQo+Pj4NCj4+IFNhbWUuIFdoaWNoIGlzIHdoeSAtIGlmIHRoZXJlJ2xsIGJl
IG5vIG1vcmUgb2JqZWN0aW9ucywgSSB3aWxsIGFwcGx5IGl0Lg0KPiBJIGRvbid0IHRoaW5rIHRo
aXMgc2hvdWxkIGJlIGFwcGxpZWQuDQo+DQo+IEl0J3Mgc3RpbGwgbm90IGNsZWFyIGZyb20gdGhl
IGNvbW1pdCBtZXNzYWdlIHdoeSBncGlvY2hpcF9kaXNhYmxlX2lycSgpDQo+IGlzIGNhbGxlZCBm
b3IgYSBsaW5lIHdoaWNoIGhhcyBub3QgYmVlbiByZXF1ZXN0ZWQuDQoNClRoZSBjb2RlIHRoYXQg
ZG9lcyB0aGUgY2FsbGluZyBpcyBpbiBtYWNoaW5lX2tleGVjX21hc2tfaW50ZXJydXB0cygpLiAN
ClRoZSBwcm9ibGVtIGlzIHRoYXQgZm9yIHNvbWUgaXJxX2NoaXBzIGlycV9tYXNrIGlzIHNldCB0
byB0aGUgZGlzYWJsZSANCmZ1bmN0aW9uLiBUaGUgZGlzYWJsZSBjYWxsIGltbWVkaWF0ZWx5IGFm
dGVyIHRoZSBtYXNrIGNhbGwgZG9lcyBjaGVjayB0byANCnNlZSBpZiB0aGUgaXJxIGlzIG5vdCBh
bHJlYWR5IGRpc2FibGVkLg0KDQo+ICAgVGhhdCBzZWVtcyBsaWtlIHdoYXQNCj4gc2hvdWxkIGJl
IGZpeGVkLCBub3QgY2hhbmdpbmcgc29tZSBiZWhhdmlvdXIgaW4gdGhlIGdwaW8gc3lzZnMgaW50
ZXJmYWNlDQo+IHdoaWNoIGhhcyBiZWVuIHRoZXJlIHNpbmNlIGZvcmV2ZXIgKGUuZy4gZG8gbm90
IGNyZWF0ZSB0aGUgZWRnZQ0KPiBhdHRyaWJ1dGVzIGZvciBncGlvcyB0aGF0IGNhbm5vdCBiZSB1
c2VkIGFzIGludGVycnVwdHMpLg0KDQpJIGRvbid0IGRpc2FncmVlIHdpdGggdGhlIHNlbnRpbWVu
dC4gVGhlIHByb2JsZW0gaXMgdGhlcmUgZG9lc24ndCBhcHBlYXIgDQp0byBiZSBhbiBBUEkgdGhh
dCBjYW4gdGVsbCBpZiBhIEdQSU8gcGluIGlzIGNhcGFibGUgb2YgYmVpbmcgYW4gaXJxIA0Kd2l0
aG91dCBhY3R1YWxseSBjb252ZXJ0aW5nIGl0IGludG8gb25lLg0KDQo+IFRoZXJlIGFyZSBvdGhl
ciB3YXlzIHRoYXQgbWFwcGluZ3MgY2FuIGJlIGNyZWF0ZWQgKGUuZy4gYSBncGlvIHRoYXQNCj4g
cmVxdWVzdGVkIGFzIGFzIGludGVycnVwdCBhbmQgdGhlbiByZWxlYXNlZCkgd2hpY2ggd291bGQg
dHJpZ2dlciB0aGUNCj4gc2FtZSB3YXJuaW5nIGl0IHNlZW1zLg0KSSd2ZSB0cmllZCBhIGZldyBv
ZiB0aG9zZSBjYXNlcyBhbmQgaGF2ZW4ndCBiZWVuIGFibGUgdG8gcHJvdm9rZSB0aGUgDQpzYW1l
IHdhcm5pbmcuIGdwaW9fc3lzZnNfZnJlZV9pcnEoKSBzZWVtcyB0byBjbGVhciB3aGF0ZXZlciBm
bGFncyANCmdwaW9jaGlwX2Rpc2FibGVfaXJxKCkgaXMgY29tcGxhaW5pbmcgYWJvdXQuDQo+IEZp
eCB0aGUgcm9vdCBjYXVzZSwgZG9uJ3QganVzdCBwYXBlciBvdmVyIHRoZSBzeW1wdG9tLg0KSSB0
aGluayBtYXliZSB0aGVyZSBpcyBhIGNvbXByb21pc2Ugd2hlcmUgSSBkbyBzb21ldGhpbmcgaW4g
DQpncGlvY2hpcF90b19pcnEoKSBpbnN0ZWFkIG9mIGdwaW9faXNfdmlzaWJsZSgpLiBJJ20gbm90
IGVudGlyZWx5IHN1cmUgDQp3aGF0IHRoYXQgc29tZXRoaW5nIGlzDQo+DQo+IEpvaGFu
