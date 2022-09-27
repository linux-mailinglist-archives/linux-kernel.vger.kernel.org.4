Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3726B5EB801
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiI0C7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiI0C6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:58:21 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710E15F87
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:54:44 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 429D22C0655;
        Tue, 27 Sep 2022 02:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1664247281;
        bh=x6rLsjU8n4jK+ehuEmcUEt5EsONMMCmZGKiq+TmClpc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=rwpgkgMT+RTSYx9ibufWkrqd1ME2wnPUWLq17Kz9o1TiAkRPbG2ueUHMliNa/zcrg
         FR55iaLR3e17e1PZoD/AgNa4CsH+Ld/CzwmrByMjkwx7iqar2n6wUcQOxu2Q7cWL4a
         kTxEWXM74coRqXNdmZ7ev2MkRVEBOtW8n+coMD9DxB6ceHCUOfTJVlfM7d+679CpnE
         1kswTYRB344oiIZWDldp1uUWRtmybvYHwMn08LCjnqX12pdxdOFqZb/BYyQXhXxYt0
         YlLirxJgYu1lE4YhvAWPZg0Ub5PoQoz1AXfeXSTA1PfMYHaaKg8TFGWbQwiCpnYkLU
         VNNB+WzyZgT8w==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B633265f10001>; Tue, 27 Sep 2022 15:54:41 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 27 Sep 2022 15:54:40 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.040; Tue, 27 Sep 2022 15:54:40 +1300
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
Thread-Index: AQHY0huGvn+cu0p4h0STUiMnaqi9wa3xutQA
Date:   Tue, 27 Sep 2022 02:54:40 +0000
Message-ID: <e234270c-4169-bddb-5c2d-9c6ac48467b6@alliedtelesis.co.nz>
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
Content-ID: <9665FE8B14A88C4891D7CFA1E0C7CA91@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=UoQdyN4B c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=xOM3xZuef0cA:10 a=nZ5tDJ4FkKnVFCT0SwEA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyNy8wOS8yMiAxNTo0NywgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4gRnJvbTogVG9ueSBP
J0JyaWVuIDx0b255Lm9icmllbkBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPg0KPiBPcmlnaW5hbGx5
IHRoZSBhYnNlbmNlIG9mIHRoZSBtYXJ2ZWxsLG5hbmQta2VlcC1jb25maWcgcHJvcGVydHkgY2F1
c2VkDQo+IHRoZSBzZXR1cF9kYXRhX2ludGVyZmFjZSBmdW5jdGlvbiB0byBiZSBwcm92aWRlZC4g
SG93ZXZlciB3aGVuDQo+IHNldHVwX2RhdGFfaW50ZXJmYWNlIHdhcyBtb3ZlZCBpbnRvIG5hbmRf
Y29udHJvbGxlcl9vcHMgdGhlIGxvZ2ljIHdhcw0KPiB1bmludGVudGlvbmFsbHkgaW52ZXJ0ZWQu
IFVwZGF0ZSB0aGUgbG9naWMgc28gdGhhdCBvbmx5IGlmIHRoZQ0KPiBtYXJ2ZWxsLG5hbmQta2Vl
cC1jb25maWcgcHJvcGVydHkgaXMgcHJlc2VudCB0aGUgYm9vdGxvYWRlciBOQU5EIGNvbmZpZw0K
PiBrZXB0Lg0KPg0KPiBGaXhlczogN2EwOGRiYWVkZDM2ICgibXRkOiByYXduYW5kOiBNb3ZlIC0+
c2V0dXBfZGF0YV9pbnRlcmZhY2UoKSB0byBuYW5kX2NvbnRyb2xsZXJfb3BzIikNCj4gU2lnbmVk
LW9mZi1ieTogVG9ueSBPJ0JyaWVuIDx0b255Lm9icmllbkBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0K
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVz
aXMuY28ubno+DQo+IC0tLQ0KPg0KPiBOb3RlczoNCj4gICAgICBJIHRoaW5rIHRoaXMgaXMgYSBi
dWcgdGhhdCdzIGJlZW4gbHVya2luZyBmb3IgNCB5ZWFycyBvciBzby4gSSdtIG5vdA0KPiAgICAg
IHN1cmUgdGhhdCdzIHBhcnRpY3VsYXJseSBsb25nIGluIHRoZSBsaWZlIG9mIGFuIGVtYmVkZGVk
IGRldmljZSBidXQgaXQNCj4gICAgICBkb2VzIG1ha2UgbWUgd29uZGVyIGlmIHRoZXJlIGhhdmUg
YmVlbiBvdGhlciBidWcgcmVwb3J0cyBhYm91dCBpdC4NCj4gICAgICANCj4gICAgICBXZSBub3Rp
Y2VkIHRoaXMgYmVjYXVzZSB3ZSBoYWQgYSBib290bG9hZGVyIHRoYXQgdXNlZCBtYXhlZCBvdXQg
TkFORA0KPiAgICAgIHRpbWluZ3Mgd2hpY2ggbWFkZSB0aGUgdGltZSBpdCB0b29rIHRoZSBrZXJu
ZWwgdG8gZG8gYW55dGhpbmcgb24gdGhlDQo+ICAgICAgZmlsZSBzeXN0ZW0gbG9uZ2VyIHRoYW4g
d2UgZXhwZWN0ZWQuDQoNCkkgdGhpbmsgdGhlcmUgbWlnaHQgYmUgYSBzaW1pbGFyIGxvZ2ljIGlu
dmVyc2lvbiBidWcgaW4gDQpkcml2ZXJzL210ZC9uYW5kL3Jhdy9kZW5hbGkuYyBidXQgSSBsYWNr
IHRoZSBhYmlsaXR5IHRvIHRlc3QgZm9yIHRoYXQgDQpwbGF0Zm9ybS4NCg0KPiAgIGRyaXZlcnMv
bXRkL25hbmQvcmF3L21hcnZlbGxfbmFuZC5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
dGQvbmFuZC9yYXcvbWFydmVsbF9uYW5kLmMgYi9kcml2ZXJzL210ZC9uYW5kL3Jhdy9tYXJ2ZWxs
X25hbmQuYw0KPiBpbmRleCAyNDU1YTU4MWZkNzAuLmIyNDhjNWY2NTdkNSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvbWFydmVsbF9uYW5kLmMNCj4gKysrIGIvZHJpdmVycy9t
dGQvbmFuZC9yYXcvbWFydmVsbF9uYW5kLmMNCj4gQEAgLTI2NzIsNyArMjY3Miw3IEBAIHN0YXRp
YyBpbnQgbWFydmVsbF9uYW5kX2NoaXBfaW5pdChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBt
YXJ2ZWxsX25mYyAqbmZjLA0KPiAgIAljaGlwLT5jb250cm9sbGVyID0gJm5mYy0+Y29udHJvbGxl
cjsNCj4gICAJbmFuZF9zZXRfZmxhc2hfbm9kZShjaGlwLCBucCk7DQo+ICAgDQo+IC0JaWYgKCFv
Zl9wcm9wZXJ0eV9yZWFkX2Jvb2wobnAsICJtYXJ2ZWxsLG5hbmQta2VlcC1jb25maWciKSkNCj4g
KwlpZiAob2ZfcHJvcGVydHlfcmVhZF9ib29sKG5wLCAibWFydmVsbCxuYW5kLWtlZXAtY29uZmln
IikpDQo+ICAgCQljaGlwLT5vcHRpb25zIHw9IE5BTkRfS0VFUF9USU1JTkdTOw0KPiAgIA0KPiAg
IAltdGQgPSBuYW5kX3RvX210ZChjaGlwKTs=
