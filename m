Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B926C290E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 05:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCUEQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 00:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCUEPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 00:15:41 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDE940EC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 21:15:04 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A66E32C0487;
        Tue, 21 Mar 2023 17:15:01 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1679372101;
        bh=C0kYpG6RbVmBdQtvUf7HL++l1mtwt1ijWGgEsmhRdGI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=RTfjyFoNCWxXzuh3rbjBi/AU9c06rSQSCilaenL5cxmlBvPbtHpz+2x/7WrXZXvKK
         8/E+MsVzYAzMNXX3POASXzuEfEl3WF7bAcqbJkAz4teeMJHzagRM4Xf6MHKS5/7LlN
         QU57hs4WmJbPge8waCF13D/cSK1+tweBidnCtI1yYM236uiGl5ff8cDa7ZxuWOHDjO
         wKXArWUN9WD20jSHZG43AEETLna0GuS7LXT/YcpPgc9cggD5+Y5XVQFqtF39yPCaU5
         WnH3aPGBfLQ3YVy5mSGZBFgRritlIG5W16/pOOMN4MTtYcKN7B8Qk55HJBl9gQHfZO
         Ihl+07Xt2LtzA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B64192f450001>; Tue, 21 Mar 2023 17:15:01 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Tue, 21 Mar 2023 17:15:01 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.048; Tue, 21 Mar 2023 17:15:01 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: Support CMDLINE_EXTEND
Thread-Topic: [PATCH] arm64: Support CMDLINE_EXTEND
Thread-Index: AQHZW3EHE9ArhMxkL0ikRTN5JhaMAa8DwLwAgAAF2wA=
Date:   Tue, 21 Mar 2023 04:15:00 +0000
Message-ID: <8b4fb239-ba11-616f-9d0a-5cc009d047a4@alliedtelesis.co.nz>
References: <20230320211451.2512800-1-chris.packham@alliedtelesis.co.nz>
 <730417dd-43b6-67f4-922a-97d2ceb298bc@arm.com>
In-Reply-To: <730417dd-43b6-67f4-922a-97d2ceb298bc@arm.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FC14EA06282C2478570ACA551E75A8F@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=F6spiZpN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=k__wU0fu6RkA:10 a=jHtdZCjugMObr7JKxaMA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDIxLzAzLzIzIDE2OjU0LCBBbnNodW1hbiBLaGFuZHVhbCB3cm90ZToNCj4gSGVs
bG8gQ2hyaXMsDQo+DQo+IE9uIDMvMjEvMjMgMDI6NDQsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+
PiBTdXBwb3J0IGV4dGVuZGluZyB0aGUgYm9vdGxvYWRlciBwcm92aWRlZCBjb21tYW5kIGxpbmUg
Zm9yIGFybTY0DQo+PiB0YXJnZXRzLiBUaGlzIHN1cHBvcnQgaXMgYWxyZWFkeSBwcmVzZW50IHZp
YSBnZW5lcmljIERUL0VGSSBjb2RlIHRoZQ0KPj4gb25seSB0aGluZyByZXF1aXJlZCBpcyBmb3Ig
dGhlIGFyY2hpdGVjdHVyZSB0byBtYWtlIGl0IHNlbGVjdGFibGUuDQo+IERvZXMgdGhpcyBjb25m
aWcgcmVhbGx5IGRlcGVuZCBvbiBnaXZlbiBwbGF0Zm9ybSdzIGFjdGl2ZSBzdXBwb3J0IG9yDQo+
IGl0IGlzIGp1c3QgbWF0dGVyIG9mIHNlbGVjdGluZyB0aGlzIGZvciBpbnRlcmVzdGVkIHBsYXRm
b3JtcyA/DQpNb3N0IG1vZGVybiBwbGF0Zm9ybXMgdXNpbmcgRFQgb3IgVUVGSSBzaG91bGQgYmUg
YWJsZSB0byB1c2UgdGhlIGNvbW1vbiANCmNvZGUuIFRoZXJlIGFyZSBzb21lIG9sZGVyIG9uZXMg
KGFybSBhbmQgcG93ZXJwYykgdGhhdCBoYXZlIG90aGVyL2xlZ2FjeSANCm1ldGhvZHMgb2YgcGFz
c2luZyB0aGUga2VybmVsIGNvbW1hbmQgbGluZSBzbyByZXRhaW5pbmcgc3VwcG9ydCBmb3IgdGhh
dCANCndoaWxlIGF0IHRoZSBzYW1lIHRpbWUgcHJvdmlkaW5nIHN1cHBvcnQgZm9yIHRoZSBnZW5l
cmljIG1ldGhvZHMgYXMgd2VsbCANCmNvdWxkIGdldCB0cmlja3kuIEl0IGxvb2tzIGFzIHRob3Vn
aCBpdCB3b24ndCBiZSB0b28gYmFkIGFzIHRoZSBjb2RlIA0Kc2VlbXMgdG8gdXNlIHRoZSBzYW1l
IEtjb25maWcgb3B0aW9ucy4NCj4gQ291bGQNCj4gdGhpcyBjb25maWcgZGVmaW5pdGlvbiBiZSB1
bmlmaWVkIGluIGEgc2luZ2xlIHBsYWNlIGkuZSBhcmNoL0tjb25maWcNCj4gYW5kIGJlIHNlbGVj
dGVkICh1bmNvbmRpdGlvbmFsbHkgb3IgY29uZGl0aW9uYWxseSkgb24gYWxsIHN1YnNjcmliaW5n
DQo+IHBsYXRmb3Jtcy4gVGhlcmUgc2VlbXMgdG8gYmUgYSByZWR1bmRhbmN5IGluIGRlZmluaW5n
IHRoZSBleGFjdCBzYW1lDQo+IGNvbmZpZyB0aGUgc2FtZSB3YXksIG9uIG11bHRpcGxlIHBsYXRm
b3Jtcy4NCj4NCj4gJGdpdCBncmVwICJjb25maWcgQ01ETElORV9FWFRFTkQiDQo+DQo+IGFyY2gv
YXJtL0tjb25maWc6Y29uZmlnIENNRExJTkVfRVhURU5EDQo+IGFyY2gvbG9vbmdhcmNoL0tjb25m
aWc6Y29uZmlnIENNRExJTkVfRVhURU5EDQo+IGFyY2gvcG93ZXJwYy9LY29uZmlnOmNvbmZpZyBD
TURMSU5FX0VYVEVORA0KPiBhcmNoL3Jpc2N2L0tjb25maWc6Y29uZmlnIENNRExJTkVfRVhURU5E
DQo+IGFyY2gvc2gvS2NvbmZpZzpjb25maWcgQ01ETElORV9FWFRFTkQNCg0KU2FtZSBhcHBsaWVz
IHRvIENNRExJTkVfRlJPTV9CT09UTE9BREVSL0NNRExJTkVfRk9SQ0UuIEFsdGhvdWdoIHNoIHVz
ZXMgDQpDTURMSU5FX09WRVJXUklURSBpbnN0ZWFkIG9mIENNRExJTkVfRk9SQ0UuIEkgZ3Vlc3Mg
aXQnZCBiZSBwb3NzaWJsZSB0byANCm1vdmUgaXQgdG8gc29tZSBjb21tb24gcGxhY2UgYW5kIGhh
dmUgdGhlIGFyY2hlcyBzb3VyY2UgaXQgbGlrZSB0aGV5IGRvIA0KZm9yIHRoaW5ncyBsaWtlIHBv
d2VyIG1hbmFnZW1lbnQuDQoNCj4gSSBndWVzcyB0aGlzIHJlZHVuZGFuY3kgc2hvdWxkIGJlIHJl
bW92ZWQgYXMgYSBwcmUtcmVxdWlzaXRlLCBiZWZvcmUNCj4gZW5hYmxpbmcgaXQgb24gYXJtNjQg
YXMgcHJvcG9zZWQgaGVyZSwgd2hpY2ggaW4gaXRzZWxmIHNlZW1zIGFscmlnaHQuDQpJIHdhcyBr
aW5kIG9mIGhvcGluZyBpdCB3b3VsZG4ndCBiZSBhIHByZS1yZXF1aXNpdGUgbWFpbmx5IGJlY2F1
c2UgaXQgDQp0dXJucyBhIHF1aWNrIHBhdGNoIEkgY2FuIGFjdHVhbGx5IHRlc3Qgb24gaGFyZHdh
cmUgSSBoYXZlIGluIGZyb250IG9mIA0KbWUgdG8gc29tZXRoaW5nIHRoYXQgSSBjYW4ndCB0ZXN0
IG9uIGhhbGYgdGhlIHBsYXRmb3JtcyB0aGF0IGFyZSANCmFmZmVjdGVkLiBJIGFsc28gaGF2ZW4n
dCBoYWQgdG8gY28tb3JkaW5hdGUgYSBjaGFuZ2UgYWNyb3NzIDYgbWFpbnRhaW5lciANCnRyZWVz
IGJlZm9yZS4gQnV0IEkgZ3Vlc3MgSSBjYW4gZ2l2ZSBpdCBhIHRyeSBpZiB0aGF0J3MgdGhlIG9u
bHkgd2F5IG9mIA0KZ2V0dGluZyBpdCBpbi4NCj4NCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzIFBh
Y2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4+IC0tLQ0KPj4gICBh
cmNoL2FybTY0L0tjb25maWcgfCA2ICsrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvS2NvbmZpZyBiL2FyY2gv
YXJtNjQvS2NvbmZpZw0KPj4gaW5kZXggMTAyM2U4OTZkNDZiLi4zYzgzN2IwODVmMjEgMTAwNjQ0
DQo+PiAtLS0gYS9hcmNoL2FybTY0L0tjb25maWcNCj4+ICsrKyBiL2FyY2gvYXJtNjQvS2NvbmZp
Zw0KPj4gQEAgLTIyMjgsNiArMjIyOCwxMiBAQCBjb25maWcgQ01ETElORV9GUk9NX0JPT1RMT0FE
RVINCj4+ICAgCSAgdGhlIGJvb3QgbG9hZGVyIGRvZXNuJ3QgcHJvdmlkZSBhbnksIHRoZSBkZWZh
dWx0IGtlcm5lbCBjb21tYW5kDQo+PiAgIAkgIHN0cmluZyBwcm92aWRlZCBpbiBDTURMSU5FIHdp
bGwgYmUgdXNlZC4NCj4+ICAgDQo+PiArY29uZmlnIENNRExJTkVfRVhURU5EDQo+PiArCWJvb2wg
IkV4dGVuZCBib290bG9hZGVyIGtlcm5lbCBhcmd1bWVudHMiDQo+PiArCWhlbHANCj4+ICsJICBU
aGUgY29tbWFuZC1saW5lIGFyZ3VtZW50cyBwcm92aWRlZCBieSB0aGUgYm9vdCBsb2FkZXIgd2ls
bCBiZQ0KPj4gKwkgIGFwcGVuZGVkIHRvIHRoZSBkZWZhdWx0IGtlcm5lbCBjb21tYW5kIHN0cmlu
Zy4NCj4+ICsNCj4+ICAgY29uZmlnIENNRExJTkVfRk9SQ0UNCj4+ICAgCWJvb2wgIkFsd2F5cyB1
c2UgdGhlIGRlZmF1bHQga2VybmVsIGNvbW1hbmQgc3RyaW5nIg0KPj4gICAJaGVscA==
