Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339036C3B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjCUUQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjCUUQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:16:57 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160ED584B5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 13:16:22 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D953B2C03CB;
        Wed, 22 Mar 2023 09:16:14 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1679429774;
        bh=2E+muZ+SNGSbSIRWhCWpuxZUgnodn4QdFDvO6YaPAhI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=w0d32/4bh+64CuKVgQYKdds/LAOFwA5IUPMFwEhkSNH8pyyJIPt8arWzSggkArNex
         OkdbjCUn7ahI1gU1abmlO8vFeLolhT2oax+ywdAynkRGZLns5TSeCQTVxZq6oXRQPW
         oxUmNoHb0ahQ/oZlnCxOLv2kotfhI3Y5LFeSRyFp0815JYE7bSV8ExSC87rJYgwaUb
         z9LJ6SCIAsZKROi6nVIzz8ezsznfNrfoRq6Lgm5zGX3yCGdBL0MHbbm3RaYjMS3TeM
         wsK0U8nZutCKiIuGktLFAHc/SmkQnI/eqGA3ewVPHtg1StmB3ZXQlW6jJIvjAyK6eI
         Fw7dIm4tE4mKA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B641a108e0001>; Wed, 22 Mar 2023 09:16:14 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Wed, 22 Mar 2023 09:16:14 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.048; Wed, 22 Mar 2023 09:16:14 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: Support CMDLINE_EXTEND
Thread-Topic: [PATCH] arm64: Support CMDLINE_EXTEND
Thread-Index: AQHZW3EHE9ArhMxkL0ikRTN5JhaMAa8EPVCAgACCeQCAABNfAA==
Date:   Tue, 21 Mar 2023 20:16:14 +0000
Message-ID: <cc0596ad-2cb3-2ffd-3e24-de4d034f0b84@alliedtelesis.co.nz>
References: <20230320211451.2512800-1-chris.packham@alliedtelesis.co.nz>
 <ZBmS28ciIei5sKHY@FVFF77S0Q05N>
 <10ecb85e-232a-4176-bca5-6c393200b291@sirena.org.uk>
In-Reply-To: <10ecb85e-232a-4176-bca5-6c393200b291@sirena.org.uk>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F28B221F027FA4EB1C9306B405CCC96@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=F6spiZpN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=k__wU0fu6RkA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=AUd_NHdVAAAA:8 a=voM4FWlXAAAA:8 a=eVAQrPGaCP7k1_kGyvoA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=IC2XNlieTeVoXbcui8wp:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyMi8wMy8yMyAwODowNiwgTWFyayBCcm93biB3cm90ZToNCj4gT24gVHVlLCBNYXIgMjEs
IDIwMjMgYXQgMTE6MTk6NTVBTSArMDAwMCwgTWFyayBSdXRsYW5kIHdyb3RlOg0KPg0KPj4gV2Ug
ZGVsaWJlcmF0ZWx5IGRyb3BwZWQgc3VwcG9ydCBmb3IgQ01ETElORV9FWFRFTkQgaW4gY29tbWl0
Og0KPj4gICAgY2FlMTE4YjZhY2MzICgiYXJtNjQ6IERyb3Agc3VwcG9ydCBmb3IgQ01ETElORV9F
WFRFTkQiKQ0KPj4gLi4uIHdoaWNoIHdhcyBtZW50aW9uZWQgdGhlIGxhc3QgdGltZSBzb21vbmUg
dHJpZWQgdG8gcmUtYWRkIGl0Og0KPj4gICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
YXJtLWtlcm5lbC9aQWg4ZFd2Yk5rVlFUMTFDQGFybS5jb20vDQo+PiBIYXMgc29tZXRoaW5nIGNo
YW5nZXMgc3VjaCB0aGF0IHRob3NlIGlzc3VlcyBubyBsb25nZXIgYXBwbHk/DQoNCkknbSBub3Qg
c3VyZSBJIHNlZSBhbnkgImlzc3VlcyIgKGFsdGhvdWdoIHBlcmhhcHMgdGhhdCdzIGp1c3QgbWUg
bm90IA0KYmVpbmcgYWJsZSB0byBmaW5kIHRoZSByZXN0IG9mIHRoZSBzZXJpZXMgb24gbG9yZSku
DQoNCk15IHNwZWNpZmljIHVzZSBjYXNlIGlzIHRoYXQgSSB3YW50IHRvIGhhdmUgdGhlwqAgc2Jz
YV9nd2R0IHdhdGNoZG9nIA0KZHJpdmVyIGJ1aWx0LWluIHRvIHRoZSBrZXJuZWwgYnV0IEkgYWxz
byB3YW50IGl0IHRvIHByb2R1Y2UgcGFuaWMgb3V0cHV0IA0KaW5zdGVhZCBvZiBzaWxlbnRseSBy
ZXNldHRpbmcgdGhlIGJvYXJkIHNvIEkgd2FudCB0byBoYXZlIA0Kc2JzYV9nd2R0LmFjdGlvbj0x
IGluIG15IGtlcm5lbCBjb21tYW5kIGxpbmUuIEVpdGhlciBhcHBlbmRpbmcgb3IgDQpwcmVwZW5k
aW5nIHRoYXQgb24gdGhlIGNvbW1hbmQgbGluZSB3b3VsZCB3b3JrIGZvciBtZS4NCg0KPj4gICBJ
ZiBzbywgcGxlYXNlDQo+PiBjYWxsIHRoYXQgb3V0IGV4cGxpY2l0bHkgaW4gdGhlIGNvbW1pdCBt
ZXNzYWdlLiBJZiBub3QsIEkgZG8gbm90IHRoaW5rIHdlDQo+PiBzaG91bGQgdGFrZSB0aGlzIHBh
dGNoLg0KDQpUbyBzYXZlIGEgY2xpY2sgaGVyZSBpcyB0aGUgcmVsZXZhbnQgcGFydCBmcm9tIGNh
ZTExOGI2YWNjMw0KDQogwqDCoMKgIFRoZSBkb2N1bWVudGVkIGJlaGF2aW91ciBmb3IgQ01ETElO
RV9FWFRFTkQgaXMgdGhhdCB0aGUgYXJndW1lbnRzIGZyb20NCiDCoMKgwqAgdGhlIGJvb3Rsb2Fk
ZXIgYXJlIGFwcGVuZGVkIHRvIHRoZSBidWlsdC1pbiBrZXJuZWwgY29tbWFuZCBsaW5lLiBUaGlz
DQogwqDCoMKgIGFsc28gbWF0Y2hlcyB0aGUgb3B0aW9uIHBhcnNpbmcgYmVoYXZpb3VyIGZvciB0
aGUgRUZJIHN0dWIgYW5kIGVhcmx5IElEDQogwqDCoMKgIHJlZ2lzdGVyIG92ZXJyaWRlcy4NCg0K
IMKgwqDCoCBCaXphcnJlbHksIHRoZSBmZHQgYmVoYXZpb3VyIGlzIHRoZSBvdGhlciB3YXkgYXJv
dW5kOiBhcHBlbmRpbmcgdGhlDQogwqDCoMKgIGJ1aWx0LWluIGNvbW1hbmQgbGluZSB0byB0aGUg
Ym9vdGxvYWRlciBhcmd1bWVudHMsIHJlc3VsdGluZyBpbiBhDQogwqDCoMKgIGNvbW1hbmQtbGlu
ZSB0aGF0IGRvZXNuJ3QgbmVjZXNzYXJpbHkgbGluZS11cCB3aXRoIHRoZSBwYXJzaW5nIA0Kb3Jk
ZXIgYW5kDQogwqDCoMKgIGRlZmluaXRlbHkgZG9lc24ndCBsaW5lLXVwIHdpdGggdGhlIGRvY3Vt
ZW50ZWQgYmVoYXZpb3VyLg0KDQpUaGlzIGFwcGVhcnMgdG8gYmUgYSBjdXJyZW50IHByb2JsZW0g
Zm9yIGFybSBhbiBwb3dlcnBjLiBJZiBpdCB3ZXJlbid0IA0KZm9yIHRoZSBmYWN0IHRoYXQgRUZJ
IHZlcnNpb24gaGFkIGRpZmZlcmVudCBiZWhhdmlvdXIgSSdkIGJlIHN1Z2dlc3RpbmcgDQpqdXN0
IHVwZGF0aW5nIHRoZSBoZWxwIHRleHQuIE1heWJlIHRoYXQgc2hvdWxkIGJlIGRvbmUgYW55d2F5
IHJlZ2FyZGxlc3MgDQpvZiBhbnkgdW5pZmljYXRpb24gc28gdGhhdCB0aGUgZG9jdW1lbnRhdGlv
biByZWZsZWN0cyByZWFsaXR5Lg0KDQo+IEdpdmVuIHRoYXQgdGhlcmUgaGF2ZSBiZWVuIG11bHRp
cGxlIGF0dGVtcHRzIHRvIHJlYWRkIGl0IGlzIGl0IHdvcnRoDQo+IGRvY3VtZW50aW5nIHRoaXMg
aW4gdGhlIGNvZGU/DQoNClRoZSBwcm9wb3NlZCBDTURMSU5FX0FQUEVORCB3b3VsZCB3b3JrIHdl
bGwgZm9yIG15IHVzZS1jYXNlIGJ1dCB0d28gDQphdHRlbXB0cyBhdCBsYW5kaW5nIHN1Y2ggZ2Vu
ZXJpYyBzdXBwb3J0IHNlZW0gdG8gaGF2ZSBmYWlsZWQuIEkgY291bGQgDQphdHRlbXB0IHRvIHJl
c3VycmVjdCBbMV0gb3IgdGhlIGFsdGVybmF0aXZlIFsyXSBidXQgSSdtIHdvcnJpZWQgSSdsbCBl
bmQgDQp1cCB3aXRoIHRoZSBzYW1lIHJvYWQgYmxvY2tzLiBBbHNvIGxvb2tzIGxpa2UgSSBqdXN0
IGZvdW5kIGEgM3JkIFszXS4NCg0KSSBob3BlIEkgaGF2ZW4ndCBraWNrZWQgYSBob3JuZXRzIG5l
c3QgaGVyZS4NCg0KLS0NCg0KWzFdIC0gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIw
MTkwMzE5MjMyNDQ4LjQ1OTY0LTItZGFuaWVsd2FAY2lzY28uY29tLw0KWzJdIC0gDQpodHRwczov
L3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbGludXhwcGMtZGV2L2NvdmVyL2NvdmVyLjE1
NTQxOTU3OTguZ2l0LmNocmlzdG9waGUubGVyb3lAYy1zLmZyLw0KWzNdIC0gDQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9sa21sLzIwMjEwNDE2MDQwOTI0LjI4ODI3NzEtMS1kYW5pZWx3YUBjaXNj
by5jb20vDQo=
