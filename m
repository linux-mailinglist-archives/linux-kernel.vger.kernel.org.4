Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25E55F3810
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJCVr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiJCVrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:47:23 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38874BA4C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:46:34 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 96BD92C068D;
        Mon,  3 Oct 2022 21:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1664833591;
        bh=nCLnLqHdonwr1+7NWZcYuA2lkeak07sLYiUs0PjOmmY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ML+GcHc2WbEy5oDM43Nx2/9px4lotS5Zd1mTh/n0fOggfOYWLWNPqeJRiXshyvK+u
         bOWGW7rImkrnRWBi4bA0VYGJCedEycTOM1BZuKL4y/3/q+MKtJjHfoRa5mNAaf2m3u
         YDauHQoR3Zw+4CCYClCLj2MRSz1lVEROG3nbEsUYXOl9MTDxz9RMKkM+aRS+iA6HPB
         BOMZnAcDfPqx6+G9z+pOdzw1eZxIXlNI4RKz77+y8qjRYdsznDDK1ySr9YqTzsEZcM
         R2YwdvMpUdnQk+dadnd7h0ITs4Xbw1fmbK8nTvhxXSagsHulp0+vLM7HwClbNIEC8I
         0j8SJzo4hxacA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B633b58370001>; Tue, 04 Oct 2022 10:46:31 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.38; Tue, 4 Oct 2022 10:46:31 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.040; Tue, 4 Oct 2022 10:46:31 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>
CC:     Tony O'Brien <Tony.OBrien@alliedtelesis.co.nz>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: rawnand: marvell: Use correct logic for
 nand-keep-config
Thread-Topic: [PATCH] mtd: rawnand: marvell: Use correct logic for
 nand-keep-config
Thread-Index: AQHY0huGvn+cu0p4h0STUiMnaqi9wa38ZQwA
Date:   Mon, 3 Oct 2022 21:46:31 +0000
Message-ID: <482a4114-eeb1-2303-2896-8e480abda876@alliedtelesis.co.nz>
References: <20220927024728.28447-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20220927024728.28447-1-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFDBC8737F22B045A9F8726F41803F21@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=UKij4xXy c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=Qawa6l4ZSaYA:10 a=nZ5tDJ4FkKnVFCT0SwEA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxsLA0KDQpPbiAyNy8wOS8yMiAxNTo0NywgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4gRnJv
bTogVG9ueSBPJ0JyaWVuIDx0b255Lm9icmllbkBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPg0KPiBP
cmlnaW5hbGx5IHRoZSBhYnNlbmNlIG9mIHRoZSBtYXJ2ZWxsLG5hbmQta2VlcC1jb25maWcgcHJv
cGVydHkgY2F1c2VkDQo+IHRoZSBzZXR1cF9kYXRhX2ludGVyZmFjZSBmdW5jdGlvbiB0byBiZSBw
cm92aWRlZC4gSG93ZXZlciB3aGVuDQo+IHNldHVwX2RhdGFfaW50ZXJmYWNlIHdhcyBtb3ZlZCBp
bnRvIG5hbmRfY29udHJvbGxlcl9vcHMgdGhlIGxvZ2ljIHdhcw0KPiB1bmludGVudGlvbmFsbHkg
aW52ZXJ0ZWQuIFVwZGF0ZSB0aGUgbG9naWMgc28gdGhhdCBvbmx5IGlmIHRoZQ0KPiBtYXJ2ZWxs
LG5hbmQta2VlcC1jb25maWcgcHJvcGVydHkgaXMgcHJlc2VudCB0aGUgYm9vdGxvYWRlciBOQU5E
IGNvbmZpZw0KPiBrZXB0Lg0KPg0KPiBGaXhlczogN2EwOGRiYWVkZDM2ICgibXRkOiByYXduYW5k
OiBNb3ZlIC0+c2V0dXBfZGF0YV9pbnRlcmZhY2UoKSB0byBuYW5kX2NvbnRyb2xsZXJfb3BzIikN
Cj4gU2lnbmVkLW9mZi1ieTogVG9ueSBPJ0JyaWVuIDx0b255Lm9icmllbkBhbGxpZWR0ZWxlc2lz
LmNvLm56Pg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFs
bGllZHRlbGVzaXMuY28ubno+DQoNCkp1c3QgZm9sbG93aW5nIHVwIG9uIHRoaXMuIEkga25vdyB0
aGluZ3MgaGF2ZSBwcm9iYWJseSBiZWVuIGJ1c3kgd2l0aCANCnRoZSA2LjAgcmVsZWFzZSBidXQg
aXQncyBiZWVuIGEgd2VlayBzbyBJIGZpZ3VyZWQgSSdkIGdpdmUgdGhpcyBhIGJ1bXAuDQoNCj4g
LS0tDQo+DQo+IE5vdGVzOg0KPiAgICAgIEkgdGhpbmsgdGhpcyBpcyBhIGJ1ZyB0aGF0J3MgYmVl
biBsdXJraW5nIGZvciA0IHllYXJzIG9yIHNvLiBJJ20gbm90DQo+ICAgICAgc3VyZSB0aGF0J3Mg
cGFydGljdWxhcmx5IGxvbmcgaW4gdGhlIGxpZmUgb2YgYW4gZW1iZWRkZWQgZGV2aWNlIGJ1dCBp
dA0KPiAgICAgIGRvZXMgbWFrZSBtZSB3b25kZXIgaWYgdGhlcmUgaGF2ZSBiZWVuIG90aGVyIGJ1
ZyByZXBvcnRzIGFib3V0IGl0Lg0KPiAgICAgIA0KPiAgICAgIFdlIG5vdGljZWQgdGhpcyBiZWNh
dXNlIHdlIGhhZCBhIGJvb3Rsb2FkZXIgdGhhdCB1c2VkIG1heGVkIG91dCBOQU5EDQo+ICAgICAg
dGltaW5ncyB3aGljaCBtYWRlIHRoZSB0aW1lIGl0IHRvb2sgdGhlIGtlcm5lbCB0byBkbyBhbnl0
aGluZyBvbiB0aGUNCj4gICAgICBmaWxlIHN5c3RlbSBsb25nZXIgdGhhbiB3ZSBleHBlY3RlZC4N
Cj4NCj4gICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9tYXJ2ZWxsX25hbmQuYyB8IDIgKy0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L21hcnZlbGxfbmFuZC5jIGIvZHJpdmVycy9tdGQv
bmFuZC9yYXcvbWFydmVsbF9uYW5kLmMNCj4gaW5kZXggMjQ1NWE1ODFmZDcwLi5iMjQ4YzVmNjU3
ZDUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L21hcnZlbGxfbmFuZC5jDQo+
ICsrKyBiL2RyaXZlcnMvbXRkL25hbmQvcmF3L21hcnZlbGxfbmFuZC5jDQo+IEBAIC0yNjcyLDcg
KzI2NzIsNyBAQCBzdGF0aWMgaW50IG1hcnZlbGxfbmFuZF9jaGlwX2luaXQoc3RydWN0IGRldmlj
ZSAqZGV2LCBzdHJ1Y3QgbWFydmVsbF9uZmMgKm5mYywNCj4gICAJY2hpcC0+Y29udHJvbGxlciA9
ICZuZmMtPmNvbnRyb2xsZXI7DQo+ICAgCW5hbmRfc2V0X2ZsYXNoX25vZGUoY2hpcCwgbnApOw0K
PiAgIA0KPiAtCWlmICghb2ZfcHJvcGVydHlfcmVhZF9ib29sKG5wLCAibWFydmVsbCxuYW5kLWtl
ZXAtY29uZmlnIikpDQo+ICsJaWYgKG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwgIm1hcnZlbGws
bmFuZC1rZWVwLWNvbmZpZyIpKQ0KPiAgIAkJY2hpcC0+b3B0aW9ucyB8PSBOQU5EX0tFRVBfVElN
SU5HUzsNCj4gICANCj4gICAJbXRkID0gbmFuZF90b19tdGQoY2hpcCk7
