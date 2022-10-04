Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CEB5F49CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJDTly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJDTlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:41:49 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116B6659E6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 12:41:46 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0611D2C086D;
        Tue,  4 Oct 2022 19:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1664912503;
        bh=6IqgVbdhLz9OrNFN0tfeK07OsAPFk28C+tCPdsx8Rec=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GkNYQDHVTUAB4OvDUaO2eH2g2db7ChzA8ZVOOMLIuMfyS/M8+fGR0QmyDCAU25KiQ
         Y8BF2zmBbOg5biKY1tYujvG2lj9BZhT0Ne1dgPNgciwES2KGVnpbnPxYzbApu7UJfi
         eOGbFT25KFFELCLfhTlzymz3qosi+7JfcQ59McT5a7Mk4CMbG/Pn0+oJa/RotR5ZRt
         lW+Kh141js/Ja3Rjd3KCz0zdPTSsETqd3hRn4P3dNIiszcuyUavkydaGyhCBB5ebdV
         2rNe+Qx/nNZtlVVdYTWe03OkIgi9Oeq8DiqLGGd7IwY/l0Ypw9Ia2GZs/cVy0t28+s
         mUcgCJKCkrJ4g==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B633c8c760001>; Wed, 05 Oct 2022 08:41:42 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.38; Wed, 5 Oct 2022 08:41:42 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.040; Wed, 5 Oct 2022 08:41:42 +1300
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
Thread-Index: AQHY0huGvn+cu0p4h0STUiMnaqi9wa3xutQAgAt3xQCAAKHogA==
Date:   Tue, 4 Oct 2022 19:41:42 +0000
Message-ID: <953cbfc0-1ac0-9bc8-155f-57e1cd37dc70@alliedtelesis.co.nz>
References: <20220927024728.28447-1-chris.packham@alliedtelesis.co.nz>
 <e234270c-4169-bddb-5c2d-9c6ac48467b6@alliedtelesis.co.nz>
 <20221004120212.6389b96a@xps-13>
In-Reply-To: <20221004120212.6389b96a@xps-13>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A92C56141AADF4CAEACB9BE5AC11359@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=UKij4xXy c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=Qawa6l4ZSaYA:10 a=KHPOhyJBeUAlEMsQnP4A:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA0LzEwLzIyIDIzOjAyLCBNaXF1ZWwgUmF5bmFsIHdyb3RlOg0KPiBIaSBDaHJpcywNCj4N
Cj4gQ2hyaXMuUGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56IHdyb3RlIG9uIFR1ZSwgMjcgU2Vw
IDIwMjIgMDI6NTQ6NDANCj4gKzAwMDA6DQo+DQo+PiBPbiAyNy8wOS8yMiAxNTo0NywgQ2hyaXMg
UGFja2hhbSB3cm90ZToNCj4+PiBGcm9tOiBUb255IE8nQnJpZW4gPHRvbnkub2JyaWVuQGFsbGll
ZHRlbGVzaXMuY28ubno+DQo+Pj4NCj4+PiBPcmlnaW5hbGx5IHRoZSBhYnNlbmNlIG9mIHRoZSBt
YXJ2ZWxsLG5hbmQta2VlcC1jb25maWcgcHJvcGVydHkgY2F1c2VkDQo+Pj4gdGhlIHNldHVwX2Rh
dGFfaW50ZXJmYWNlIGZ1bmN0aW9uIHRvIGJlIHByb3ZpZGVkLiBIb3dldmVyIHdoZW4NCj4+PiBz
ZXR1cF9kYXRhX2ludGVyZmFjZSB3YXMgbW92ZWQgaW50byBuYW5kX2NvbnRyb2xsZXJfb3BzIHRo
ZSBsb2dpYyB3YXMNCj4+PiB1bmludGVudGlvbmFsbHkgaW52ZXJ0ZWQuIFVwZGF0ZSB0aGUgbG9n
aWMgc28gdGhhdCBvbmx5IGlmIHRoZQ0KPj4+IG1hcnZlbGwsbmFuZC1rZWVwLWNvbmZpZyBwcm9w
ZXJ0eSBpcyBwcmVzZW50IHRoZSBib290bG9hZGVyIE5BTkQgY29uZmlnDQo+Pj4ga2VwdC4NCj4+
Pg0KPj4+IEZpeGVzOiA3YTA4ZGJhZWRkMzYgKCJtdGQ6IHJhd25hbmQ6IE1vdmUgLT5zZXR1cF9k
YXRhX2ludGVyZmFjZSgpIHRvIG5hbmRfY29udHJvbGxlcl9vcHMiKQ0KPj4+IFNpZ25lZC1vZmYt
Ynk6IFRvbnkgTydCcmllbiA8dG9ueS5vYnJpZW5AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4+PiBT
aWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMu
Y28ubno+DQo+Pj4gLS0tDQo+Pj4NCj4+PiBOb3RlczoNCj4+PiAgICAgICBJIHRoaW5rIHRoaXMg
aXMgYSBidWcgdGhhdCdzIGJlZW4gbHVya2luZyBmb3IgNCB5ZWFycyBvciBzby4gSSdtIG5vdA0K
Pj4+ICAgICAgIHN1cmUgdGhhdCdzIHBhcnRpY3VsYXJseSBsb25nIGluIHRoZSBsaWZlIG9mIGFu
IGVtYmVkZGVkIGRldmljZSBidXQgaXQNCj4+PiAgICAgICBkb2VzIG1ha2UgbWUgd29uZGVyIGlm
IHRoZXJlIGhhdmUgYmVlbiBvdGhlciBidWcgcmVwb3J0cyBhYm91dCBpdC4NCj4+PiAgICAgICAN
Cj4+PiAgICAgICBXZSBub3RpY2VkIHRoaXMgYmVjYXVzZSB3ZSBoYWQgYSBib290bG9hZGVyIHRo
YXQgdXNlZCBtYXhlZCBvdXQgTkFORA0KPj4+ICAgICAgIHRpbWluZ3Mgd2hpY2ggbWFkZSB0aGUg
dGltZSBpdCB0b29rIHRoZSBrZXJuZWwgdG8gZG8gYW55dGhpbmcgb24gdGhlDQo+Pj4gICAgICAg
ZmlsZSBzeXN0ZW0gbG9uZ2VyIHRoYW4gd2UgZXhwZWN0ZWQuDQo+PiBJIHRoaW5rIHRoZXJlIG1p
Z2h0IGJlIGEgc2ltaWxhciBsb2dpYyBpbnZlcnNpb24gYnVnIGluDQo+PiBkcml2ZXJzL210ZC9u
YW5kL3Jhdy9kZW5hbGkuYyBidXQgSSBsYWNrIHRoZSBhYmlsaXR5IHRvIHRlc3QgZm9yIHRoYXQN
Cj4+IHBsYXRmb3JtLg0KPiBBZ3JlZWQsIHRoZSBkZW5hbGkgZHJpdmVyIGhhcyB0aGUgc2FtZSBp
c3N1ZS4gQ291bGQgeW91IHBsZWFzZSBzZW5kIGENCj4gcGF0Y2g/DQpTdXJlIGFsdGhvdWdoIGl0
J2xsIGJlIGNvbXBpbGUgdGVzdGVkIG9ubHkuDQo+Pj4gICAgZHJpdmVycy9tdGQvbmFuZC9yYXcv
bWFydmVsbF9uYW5kLmMgfCAyICstDQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFu
ZC9yYXcvbWFydmVsbF9uYW5kLmMgYi9kcml2ZXJzL210ZC9uYW5kL3Jhdy9tYXJ2ZWxsX25hbmQu
Yw0KPj4+IGluZGV4IDI0NTVhNTgxZmQ3MC4uYjI0OGM1ZjY1N2Q1IDEwMDY0NA0KPj4+IC0tLSBh
L2RyaXZlcnMvbXRkL25hbmQvcmF3L21hcnZlbGxfbmFuZC5jDQo+Pj4gKysrIGIvZHJpdmVycy9t
dGQvbmFuZC9yYXcvbWFydmVsbF9uYW5kLmMNCj4+PiBAQCAtMjY3Miw3ICsyNjcyLDcgQEAgc3Rh
dGljIGludCBtYXJ2ZWxsX25hbmRfY2hpcF9pbml0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0
IG1hcnZlbGxfbmZjICpuZmMsDQo+Pj4gICAgCWNoaXAtPmNvbnRyb2xsZXIgPSAmbmZjLT5jb250
cm9sbGVyOw0KPj4+ICAgIAluYW5kX3NldF9mbGFzaF9ub2RlKGNoaXAsIG5wKTsNCj4+PiAgICAN
Cj4+PiAtCWlmICghb2ZfcHJvcGVydHlfcmVhZF9ib29sKG5wLCAibWFydmVsbCxuYW5kLWtlZXAt
Y29uZmlnIikpDQo+Pj4gKwlpZiAob2ZfcHJvcGVydHlfcmVhZF9ib29sKG5wLCAibWFydmVsbCxu
YW5kLWtlZXAtY29uZmlnIikpDQo+Pj4gICAgCQljaGlwLT5vcHRpb25zIHw9IE5BTkRfS0VFUF9U
SU1JTkdTOw0KPj4+ICAgIA0KPj4+ICAgIAltdGQgPSBuYW5kX3RvX210ZChjaGlwKQ0KPg0KPiBU
aGFua3MsDQo+IE1pcXXDqGw=
