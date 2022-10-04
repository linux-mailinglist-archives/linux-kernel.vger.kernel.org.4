Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBE45F4AD6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJDVVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJDVVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:21:45 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F48A6C762
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 14:21:44 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C2EB02C0650;
        Tue,  4 Oct 2022 21:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1664918498;
        bh=cF+SiZNF5YflofZHlizubshEdYlI8nuUEdGGUdT0vCo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=g+/LsIv5ZjCl67ficXE8dqACB7yBrOIrdn6ypCr75BuKI5i0pS2YEA4syO0iOXKw3
         SGGQPFn2GgWC7xn23ntvFOePTnowgZp7/TERSICRPUuqwRvfduhWq+25BU55KRCwM5
         W1COB7phKC5Ib8NTMf7BhKARNz22kGWvrPFa18cU3Z3a8LySB6haeD4Bz3oQU/mFxz
         25p44mJ+H84qw3KfCGmraS2l86VHPS1TChG/9tafK9VMa4bsIfSXQE71M4JmotyOSj
         NtcdUV9pzPEr+TecARqamgP8m1Kme8PxuNUVM7uBD2khl/8xSLqJnc3faaZQv1uiLA
         Ru49/v9n5luBw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B633ca3e20001>; Wed, 05 Oct 2022 10:21:38 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.38; Wed, 5 Oct 2022 10:21:38 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.040; Wed, 5 Oct 2022 10:21:38 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        Tony O'Brien <Tony.OBrien@alliedtelesis.co.nz>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: rawnand: marvell: Use correct logic for
 nand-keep-config
Thread-Topic: [PATCH] mtd: rawnand: marvell: Use correct logic for
 nand-keep-config
Thread-Index: AQHY0huGvn+cu0p4h0STUiMnaqi9wa3xutQAgAt3xQCAAKHogIAAG+yA
Date:   Tue, 4 Oct 2022 21:21:37 +0000
Message-ID: <55e5672f-b3e5-4c14-b5e9-01cdde2f4472@alliedtelesis.co.nz>
References: <20220927024728.28447-1-chris.packham@alliedtelesis.co.nz>
 <e234270c-4169-bddb-5c2d-9c6ac48467b6@alliedtelesis.co.nz>
 <20221004120212.6389b96a@xps-13>
 <953cbfc0-1ac0-9bc8-155f-57e1cd37dc70@alliedtelesis.co.nz>
In-Reply-To: <953cbfc0-1ac0-9bc8-155f-57e1cd37dc70@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC1FF87CD584A041A313B040495802F9@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=UKij4xXy c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=Qawa6l4ZSaYA:10 a=T4fsLpPXdGlGkUi-FR8A:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA1LzEwLzIyIDA4OjQxLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPg0KPiBPbiA0LzEwLzIy
IDIzOjAyLCBNaXF1ZWwgUmF5bmFsIHdyb3RlOg0KPj4gSGkgQ2hyaXMsDQo+Pg0KPj4gQ2hyaXMu
UGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56IHdyb3RlIG9uIFR1ZSwgMjcgU2VwIDIwMjIgMDI6
NTQ6NDANCj4+ICswMDAwOg0KPj4NCj4+PiBPbiAyNy8wOS8yMiAxNTo0NywgQ2hyaXMgUGFja2hh
bSB3cm90ZToNCj4+Pj4gRnJvbTogVG9ueSBPJ0JyaWVuIDx0b255Lm9icmllbkBhbGxpZWR0ZWxl
c2lzLmNvLm56Pg0KPj4+Pg0KPj4+PiBPcmlnaW5hbGx5IHRoZSBhYnNlbmNlIG9mIHRoZSBtYXJ2
ZWxsLG5hbmQta2VlcC1jb25maWcgcHJvcGVydHkgY2F1c2VkDQo+Pj4+IHRoZSBzZXR1cF9kYXRh
X2ludGVyZmFjZSBmdW5jdGlvbiB0byBiZSBwcm92aWRlZC4gSG93ZXZlciB3aGVuDQo+Pj4+IHNl
dHVwX2RhdGFfaW50ZXJmYWNlIHdhcyBtb3ZlZCBpbnRvIG5hbmRfY29udHJvbGxlcl9vcHMgdGhl
IGxvZ2ljIHdhcw0KPj4+PiB1bmludGVudGlvbmFsbHkgaW52ZXJ0ZWQuIFVwZGF0ZSB0aGUgbG9n
aWMgc28gdGhhdCBvbmx5IGlmIHRoZQ0KPj4+PiBtYXJ2ZWxsLG5hbmQta2VlcC1jb25maWcgcHJv
cGVydHkgaXMgcHJlc2VudCB0aGUgYm9vdGxvYWRlciBOQU5EIA0KPj4+PiBjb25maWcNCj4+Pj4g
a2VwdC4NCj4+Pj4NCj4+Pj4gRml4ZXM6IDdhMDhkYmFlZGQzNiAoIm10ZDogcmF3bmFuZDogTW92
ZSAtPnNldHVwX2RhdGFfaW50ZXJmYWNlKCkgDQo+Pj4+IHRvIG5hbmRfY29udHJvbGxlcl9vcHMi
KQ0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBUb255IE8nQnJpZW4gPHRvbnkub2JyaWVuQGFsbGllZHRl
bGVzaXMuY28ubno+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBh
Y2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4+Pj4gLS0tDQo+Pj4+DQo+Pj4+IE5vdGVzOg0K
Pj4+PiDCoMKgwqDCoMKgIEkgdGhpbmsgdGhpcyBpcyBhIGJ1ZyB0aGF0J3MgYmVlbiBsdXJraW5n
IGZvciA0IHllYXJzIG9yIHNvLiANCj4+Pj4gSSdtIG5vdA0KPj4+PiDCoMKgwqDCoMKgIHN1cmUg
dGhhdCdzIHBhcnRpY3VsYXJseSBsb25nIGluIHRoZSBsaWZlIG9mIGFuIGVtYmVkZGVkIA0KPj4+
PiBkZXZpY2UgYnV0IGl0DQo+Pj4+IMKgwqDCoMKgwqAgZG9lcyBtYWtlIG1lIHdvbmRlciBpZiB0
aGVyZSBoYXZlIGJlZW4gb3RoZXIgYnVnIHJlcG9ydHMgDQo+Pj4+IGFib3V0IGl0Lg0KPj4+PiDC
oMKgwqDCoMKgIMKgwqDCoMKgwqAgV2Ugbm90aWNlZCB0aGlzIGJlY2F1c2Ugd2UgaGFkIGEgYm9v
dGxvYWRlciB0aGF0IHVzZWQgDQo+Pj4+IG1heGVkIG91dCBOQU5EDQo+Pj4+IMKgwqDCoMKgwqAg
dGltaW5ncyB3aGljaCBtYWRlIHRoZSB0aW1lIGl0IHRvb2sgdGhlIGtlcm5lbCB0byBkbyBhbnl0
aGluZyANCj4+Pj4gb24gdGhlDQo+Pj4+IMKgwqDCoMKgwqAgZmlsZSBzeXN0ZW0gbG9uZ2VyIHRo
YW4gd2UgZXhwZWN0ZWQuDQo+Pj4gSSB0aGluayB0aGVyZSBtaWdodCBiZSBhIHNpbWlsYXIgbG9n
aWMgaW52ZXJzaW9uIGJ1ZyBpbg0KPj4+IGRyaXZlcnMvbXRkL25hbmQvcmF3L2RlbmFsaS5jIGJ1
dCBJIGxhY2sgdGhlIGFiaWxpdHkgdG8gdGVzdCBmb3IgdGhhdA0KPj4+IHBsYXRmb3JtLg0KPj4g
QWdyZWVkLCB0aGUgZGVuYWxpIGRyaXZlciBoYXMgdGhlIHNhbWUgaXNzdWUuIENvdWxkIHlvdSBw
bGVhc2Ugc2VuZCBhDQo+PiBwYXRjaD8NCj4gU3VyZSBhbHRob3VnaCBpdCdsbCBiZSBjb21waWxl
IHRlc3RlZCBvbmx5Lg0KQWN0dWFsbHkgbG9va3MgbGlrZSBpdCB3YXMgYWxyZWFkeSBmaXhlZCBp
biBjb21taXQgZDMxMWUwYzI3YjhmICgibXRkOiANCnJhd25hbmQ6IGRlbmFsaTogZ2V0IC0+c2V0
dXBfZGF0YV9pbnRlcmZhY2UoKSB3b3JraW5nIGFnYWluIikuDQo+Pj4+IMKgwqAgZHJpdmVycy9t
dGQvbmFuZC9yYXcvbWFydmVsbF9uYW5kLmMgfCAyICstDQo+Pj4+IMKgwqAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9tYXJ2ZWxsX25hbmQuYyANCj4+Pj4gYi9kcml2ZXJzL210
ZC9uYW5kL3Jhdy9tYXJ2ZWxsX25hbmQuYw0KPj4+PiBpbmRleCAyNDU1YTU4MWZkNzAuLmIyNDhj
NWY2NTdkNSAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvbWFydmVsbF9u
YW5kLmMNCj4+Pj4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvbWFydmVsbF9uYW5kLmMNCj4+
Pj4gQEAgLTI2NzIsNyArMjY3Miw3IEBAIHN0YXRpYyBpbnQgbWFydmVsbF9uYW5kX2NoaXBfaW5p
dChzdHJ1Y3QgDQo+Pj4+IGRldmljZSAqZGV2LCBzdHJ1Y3QgbWFydmVsbF9uZmMgKm5mYywNCj4+
Pj4gwqDCoMKgwqDCoMKgIGNoaXAtPmNvbnRyb2xsZXIgPSAmbmZjLT5jb250cm9sbGVyOw0KPj4+
PiDCoMKgwqDCoMKgwqAgbmFuZF9zZXRfZmxhc2hfbm9kZShjaGlwLCBucCk7DQo+Pj4+IMKgwqAg
LcKgwqDCoCBpZiAoIW9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwgIm1hcnZlbGwsbmFuZC1rZWVw
LWNvbmZpZyIpKQ0KPj4+PiArwqDCoMKgIGlmIChvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobnAsICJt
YXJ2ZWxsLG5hbmQta2VlcC1jb25maWciKSkNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2hp
cC0+b3B0aW9ucyB8PSBOQU5EX0tFRVBfVElNSU5HUzsNCj4+Pj4gwqDCoCDCoMKgwqDCoMKgwqAg
bXRkID0gbmFuZF90b19tdGQoY2hpcCkNCj4+DQo+PiBUaGFua3MsDQo+PiBNaXF1w6hs
