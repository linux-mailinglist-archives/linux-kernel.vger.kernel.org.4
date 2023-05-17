Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977D1707449
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjEQVa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEQVa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:30:57 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F571724
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:30:54 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E49C12C0242;
        Thu, 18 May 2023 09:30:51 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1684359051;
        bh=uaLfshQsijw42P1izxjKfIRT8z/MvUgrihYe8sQ80sU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=bIR26eaIelAv92HluJlmUL1oPdAOSMMYMA7imOV5QmOYUXMbNntTJIDPQDZGQLyJU
         2yKr6DVELOqvZLXbSyIsanaLVHgMu6v0Lo/73ETh9Mu1VLecfKvcJdvcazdgU9U0hj
         YWrhwoHITmkxu9Zccd4hbKqjpvdPej7/LNlP7mRef+1NwNDOBJYvIdYNMzYP7bhxfH
         g70lClSBFAJ4GZCFFHULJO3vPTfTi3IahzCSWmRN0l9eBQMGcfOdyAJBQ4iBXyO823
         wJpyDMTgeDnAuSrHbe8/mecr6BdYq1J1Hvku06aAU1c+4Co3EFng0YX3KovqngFTzb
         olDkMXZZb098Q==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6465478b0001>; Thu, 18 May 2023 09:30:51 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 18 May 2023 09:30:51 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Thu, 18 May 2023 09:30:51 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "johan@kernel.org" <johan@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "Ben Brown" <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Thread-Topic: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Thread-Index: AQHZhIoofApft8Zm8kuYZtpxH+f53K9VfDeAgAQYHQCAApZDgIAAjA4AgAAH1ICAABG6AIAAmBEAgADTMYA=
Date:   Wed, 17 May 2023 21:30:51 +0000
Message-ID: <604467c7-c5d6-38b1-be98-42c7da031416@alliedtelesis.co.nz>
References: <20230512042806.3438373-1-chris.packham@alliedtelesis.co.nz>
 <CACRpkdYz9ipNTo2ORXKWy5Q4uCpKL=9Gd+kK76pestX7Onuz-Q@mail.gmail.com>
 <b36fcdf1-45ab-0c06-efe4-237df0612466@alliedtelesis.co.nz>
 <CACRpkdbiSAFoJP_JB1d_6gQ+Xx7Y+mLAh=C6Za+fpyWuRe6Gbw@mail.gmail.com>
 <31a23398-9b0e-4a19-3576-84fcfd3ce4b5@alliedtelesis.co.nz>
 <ZGQH8/hH0Llx3rzZ@sol>
 <a61415db-fa3f-2fce-9c21-08d8dd026960@alliedtelesis.co.nz>
 <CAHp75VfSnb2DWX8iMZ7BiSnrEquZdbzvTD+bcHk_Oc_rh7ectw@mail.gmail.com>
In-Reply-To: <CAHp75VfSnb2DWX8iMZ7BiSnrEquZdbzvTD+bcHk_Oc_rh7ectw@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <64B13A9E2A6A024D9D35E388AD734664@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=qhQ5e7nFYrnAy3rom44A:9 a=QEXdDO2ut3YA:10
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

DQpPbiAxNy8wNS8yMyAyMDo1NCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBPbiBXZWQsIE1h
eSAxNywgMjAyMyBhdCAyOjUw4oCvQU0gQ2hyaXMgUGFja2hhbQ0KPiA8Q2hyaXMuUGFja2hhbUBh
bGxpZWR0ZWxlc2lzLmNvLm56PiB3cm90ZToNCj4+IE9uIDE3LzA1LzIzIDEwOjQ3LCBLZW50IEdp
YnNvbiB3cm90ZToNCj4gLi4uDQo+DQo+PiBUaGUgZmlyc3QgaXMgYSB1c2Vyc3BhY2UgZHJpdmVy
IGZvciBhIFBvd2VyIE92ZXIgRXRoZXJuZXQgQ29udHJvbGxlcitQU0UNCj4+IGNoaXBzZXQgKEkn
bGwgcmVmZXIgdG8gdGhpcyBhcyBhbiBNQ1Ugc2luY2UgdGhlIHRoaW5nIHdlIHRhbGsgdG8gaXMN
Cj4+IHJlYWxseSBhIG1pY3JvIGNvbnRyb2xsZXIgd2l0aCBhIHZlbmRvciBzdXBwbGllZCBmaXJt
d2FyZSBvbiBpdCB0aGF0DQo+PiBkb2VzIG1vc3Qgb2YgdGhlIFBvRSBzdHVmZikuIENvbW11bmlj
YXRpb24gdG8gdGhlIE1DVSBpcyBiYXNlZCBhcm91bmQNCj4+IGNvbW1hbmRzIHNlbnQgdmlhIGky
Yy4gQnV0IHRoZXJlIGFyZSBhIGZldyBleHRyYSBHUElPcyB0aGF0IGFyZSB1c2VkIHRvDQo+PiBy
ZXNldCB0aGUgTUNVIGFzIHdlbGwgYXMgcHJvdmlkZSBhIG1lY2hhbmlzbSBmb3IgcXVpY2tseSBk
cm9wcGluZyBwb3dlcg0KPj4gb24gY2VydGFpbiBldmVudHMgKGUuZy4gaWYgdGhlIHRlbXBlcmF0
dXJlIG1vbml0b3JpbmcgZGV0ZWN0cyBhIHByb2JsZW0pLg0KPiBXaHkgZG9lcyB0aGUgTUNVIGhh
dmUgbm8gaW4ta2VybmVsIGRyaXZlcj8NCg0KVGhlcmUgaXNuJ3QgYW55IFBvRSBQU0UgaW5mcmFz
dHJ1Y3R1cmUgaW4gdGhlIGtlcm5lbC4gSSdtIG5vdCByZWFsbHkgDQpzdXJlIHdoYXQgaXQnZCBs
b29rIGxpa2UgZWl0aGVyIGFzIHRoZSBoYXJkd2FyZSBkZXNpZ25zIGFyZSBhbGwgaGlnaGx5IA0K
Y3VzdG9taXplZCBhbmQgb2Z0ZW4gaGF2ZSB2ZXJ5IHNwZWNpYWxpemVkIHJlcXVpcmVtZW50cy4g
RXZlbiB0aGUgdmVuZG9yIA0KcmVmZXJlbmNlIGJvYXJkcyB0ZW5kIHRvIHVzZSB0aGUgaTJjIHVz
ZXJzcGFjZSBpbnRlcmZhY2UgYW5kIHB1bnQgDQpldmVyeXRoaW5nIHRvIGEgc3BlY2lhbGlzdCBh
cHBsaWNhdGlvbi4NCg0KT2YgY291cnNlIGlmIGFueW9uZSBpcyB0aGlua2luZyBhYm91dCBhZGRp
bmcgUG9FIFBTRSBzdXBwb3J0IGluLWtlcm5lbCANCkknZCBiZSB2ZXJ5IGtlZW4gdG8gYmUgaW52
b2x2ZWQuDQoNCj4+IFdlIGRvIGhhdmUgYSBzbWFsbCBrZXJuZWwgbW9kdWxlIHRoYXQgZ3JhYnMg
dGhlIEdQSU9zIGJhc2VkIG9uIHRoZQ0KPj4gZGV2aWNlIHRyZWUgYW5kIGV4cG9ydHMgdGhlbSB3
aXRoIGEga25vd24gbmFtZXMgKGUuZy4gInBvZS1yZXNldCIsDQo+PiAicG9lLWRpcyIpIHRoYXQg
dGhlIHVzZXJzcGFjZSBkcml2ZXIgY2FuIHVzZS4NCj4gU28sIGJlc2lkZXMgdGhhdCB5b3UgcmVw
ZWF0IGdwaW8tYWdncmVnYXRvciBmdW5jdGlvbmFsaXR5LCB5b3UgYWxyZWFkeQ0KPiBoYXZlIGEg
InByb3h5IiBkcml2ZXIgaW4gdGhlIGtlcm5lbC4gV2hhdCBwcmV2ZW50cyB5b3UgZnJvbSBkb2lu
ZyBtb3JlDQo+IGluLWtlcm5lbD8NCg0KWWVzIHRydWUuIFRoZSBtYWluIGlzc3VlIGlzIHRoYXQg
d2l0aG91dCB0b3RhbCBzdXBwb3J0IGZvciB0aGUgY2xhc3Mgb2YgDQpkZXZpY2UgaW4gdGhlIGtl
cm5lbCB0aGVyZSdzIGxpdHRsZSBtb3JlIHRoYXQgeW91IGNhbiBkbyBvdGhlciB0aGFuIA0KZXhw
b3NpbmcgZ3Bpb3MgKGVpdGhlciBhcyBncGlvX2V4cG9ydF9saW5rKCkgb3Igc29tZSBvdGhlciBi
ZXNwb2tlIA0KaW50ZXJmYWNlKS4NCg0KPj4gICBCYWNrIHdoZW4gdGhhdCBjb2RlIHdhcw0KPj4g
d3JpdHRlbiB3ZSBkaWQgY29uc2lkZXIgbm90IGV4cG9ydGluZyB0aGUgR1BJT3MgYW5kIGluc3Rl
YWQgaGF2aW5nIHNvbWUNCj4+IG90aGVyIHN5c2ZzL2lvY3RsIGludGVyZmFjZSBpbnRvIHRoaXMg
a2VybmVsIG1vZHVsZSBidXQgdGhhdCBzZWVtZWQgbW9yZQ0KPj4gd29yayB0aGFuIGp1c3QgY2Fs
bGluZyBncGlvZF9leHBvcnQoKSBmb3IgbGl0dGxlIGdhaW4uIFRoaXMgaXMgd2hlcmUNCj4+IGFk
ZGluZyB0aGUgZ3Bpby1uYW1lcyBwcm9wZXJ0eSBpbiBvdXIgLmR0cyB3b3VsZCBhbGxvdyBsaWJn
cGlvZCB0byBkbw0KPj4gc29tZXRoaW5nIHNpbWlsYXIuDQo+Pg0KPj4gSGF2aW5nIHRoZSBHUElP
cyBpbiBzeXNmcyBpcyBhbHNvIGNvbnZlbmllbnQgYXMgd2UgY2FuIGhhdmUgYSBzeXN0ZW1kDQo+
PiBFeGVjU3RvcFBvc3Qgc2NyaXB0IHRoYXQgY2FuIGRyb3AgcG93ZXIgYW5kL29yIHJlc2V0IHRo
ZSBNQ1UgaWYgb3VyDQo+PiBhcHBsaWNhdGlvbiBjcmFzaGVzLg0KPiBJJ20gYSBiaXQgbG9zdC4g
V2hhdCB5b3VyIGFwcCBpcyBkb2luZyBhbmQgaG93IHRoYXQgaXMgcmVsYXRlZCB0byB0aGUNCj4g
KHVzZXJzcGFjZSkgZHJpdmVycz8NCg0KUHJvYmFibHkgb25lIG9mIHRoZSBwcmltYXJ5IHRoaW5n
cyBpdCdzIGRvaW5nIGlzIGJyaW5naW5nIHRoZSBjaGlwIG91dCANCm9mIHJlc2V0IGJ5IGRyaXZp
bmcgdGhlIEdQSU8gKHdlIGRvbid0IHdhbnQgdGhlIFBvRSBQU0Ugc3VwcGx5aW5nIHBvd2VyIA0K
aWYgbm90aGluZyBpcyBtb25pdG9yaW5nIHRoZSB0ZW1wZXJhdHVyZSBvZiB0aGUgc3lzdGVtKS4g
VGhlcmUncyBhbHNvIA0Kc29tZSBjb3JuZXIgY2FzZXMgaW52b2x2aW5nIG5vdCByZXNldHRpbmcg
dGhlIFBvRSBjaGlwc2V0IG9uIGEgaG90IHJlc3RhcnQuDQoNCj4NCj4+IEknbSBub3Qgc3VyZSBp
ZiB0aGUgR1BJTyBjaGFyZGV2IGludGVyZmFjZSBkZWFscw0KPj4gd2l0aCByZWxlYXNpbmcgdGhl
IEdQSU8gbGluZXMgaWYgdGhlIHByb2Nlc3MgdGhhdCByZXF1ZXN0ZWQgdGhlbSBleGl0cw0KPj4g
YWJub3JtYWxseSAoSSBhc3N1bWUgaXQgZG9lcykgYW5kIG9idmlvdXNseSBvdXIgRXhlY1N0b3BQ
b3N0IHNjcmlwdA0KPj4gd291bGQgbmVlZCB1cGRhdGluZyB0byB1c2Ugc29tZSBvZiB0aGUgbGli
Z3Bpb2QgYXBwbGljYXRpb25zIHRvIGRvIHdoYXQNCj4+IGl0IGN1cnJlbnRseSBkb2VzIHdpdGgg
YSBzaW1wbGUgJ2VjaG8gMSA+Li4uL3BvZS1yZXNldCcNCj4+DQo+PiBUaGUgc2Vjb25kIGFwcGxp
Y2F0aW9uIGlzIGEgdXNlcnNwYWNlIGRyaXZlciBmb3IgYSBMMyBuZXR3b3JrIHN3aXRjaA0KPj4g
KGFjdHVhbGx5IHR3byBvZiB0aGVtIGZvciBkaWZmZXJlbnQgc2lsaWNvbiB2ZW5kb3JzKS4gQWdh
aW4gdGhpcyBuZWVkcw0KPj4gdG8gZGVhbCB3aXRoIHJlc2V0cyBmb3IgUEhZcyBjb25uZWN0ZWQg
dG8gdGhlIHN3aXRjaCB0aGF0IHRoZSBrZXJuZWwgaGFzDQo+PiBubyB2aXNpYmlsaXR5IG9mIGFz
IHdlbGwgYXMgdGhlIEdQSU9zIGZvciB0aGUgU0ZQIGNhZ2VzLiBBZ2FpbiB3ZSBoYXZlIGENCj4+
IHNsaWdodGx5IGxlc3Mgc2ltcGxlIGtlcm5lbCBtb2R1bGUgdGhhdCBncmFicyBhbGwgdGhlc2Ug
R1BJT3MgYW5kDQo+PiBleHBvcnRzIHRoZW0gd2l0aCBrbm93biBuYW1lcy4gVGhpcyB0aW1lIHRo
ZXJlIGFyZSBjb25zaWRlcmFibHkgbW9yZSBvZg0KPj4gdGhlc2UgR1BJT3MgKG91ciBsYXJnZXN0
IHN5c3RlbSBjdXJyZW50bHkgaGFzIDk2IFNGUCsgcG9ydHMgd2l0aCA0IEdQSU9zDQo+PiBwZXIg
cG9ydCkgc28gd2UncmUgbXVjaCBtb3JlIHJlbGlhbnQgb24gYmVpbmcgYWJsZSB0byBkbyB0aGlu
Z3MgbGlrZQ0KPj4gYGZvciB4IGluIHBvcnQqdHgtZGlzOyBkbyBlY2hvIDEgPiR4OyBkb25lYA0K
PiBIbW0uLi4gSGF2ZSB5b3UgdGFsa2VkIHRvIHRoZSBuZXQgc3Vic3lzdGVtIGd1eXM/IEkga25v
dyB0aGF0IHRoZXJlIGlzDQo+IGEgbG90IGdvaW5nIG9uIGFyb3VuZCBTRlAgY2FnZSBlbnVtZXJh
dGlvbiBmb3Igc29tZSBvZiB0aGUgbW9kdWxlcw0KPiAoTWFydmVsbD8pIGFuZCBwZXJoYXBzIHRo
ZXkgY2FuIGFkdmlzZSBzb21ldGhpbmcgZGlmZmVyZW50Lg0KDQpZZXMgSSdtIGF3YXJlIG9mIHRo
ZSBzd2l0Y2hkZXYgd29yayBhbmQgSSdtIHZlcnkgZW50aHVzaWFzdGljIGFib3V0IGl0IA0KKGFz
IGFuIGFzaWRlIEkgZG8gaGF2ZSBhIGZhaXJseSBmdW5jdGlvbmFsIHN3aXRjaGRldiBkcml2ZXIg
Zm9yIHNvbWUgb2YgDQp0aGUgb2xkZXIgTWFydmVsbCBQb25jYXQyIHNpbGljb24sIG5ldmVyIHF1
aXRlIGdvdCB0byBzdWJtaXR0aW5nIGl0IA0KdXBzdHJlYW0gYmVmb3JlIHdlIHJhbiBvdXQgb2Yg
dGltZSBvbiB0aGUgcHJvamVjdCkuDQoNCkFnYWluIHRoZSBwcm9ibGVtIGJvaWxzIGRvd24gdG8g
dGhlIGZhY3QgdGhhdCB3ZSBoYXZlIGEgdXNlcnNwYWNlIHN3aXRjaCANCmRyaXZlciAod2hpY2gg
dXNlcyBhIHZlbmRvciBzdXBwbGllZCBub24tZnJlZSBTREspLiBTbyBkZXNwaXRlIHRoZSANCmtl
cm5lbCBoYXZpbmcgcXVpdGUgZ29vZCBzdXBwb3J0IGZvciBTRlBzIEkgY2FuJ3QgdXNlIGl0IHdp
dGhvdXQgYSANCm5ldGRldiB0byBhdHRhY2ggaXQgdG8uDQoNCj4+IEknbSBzdXJlIGJvdGggb2Yg
dGhlc2UgYXBwbGljYXRpb25zIGNvdWxkIGJlIHJlLXdyaXR0ZW4gYXJvdW5kIGxpYmdwaW9kDQo+
PiBidXQgdGhhdCB3b3VsZCBpbmN1ciBhIHNpZ25pZmljYW50IGFtb3VudCBvZiByZWdyZXNzaW9u
IHRlc3Rpbmcgb24NCj4+IGV4aXN0aW5nIHBsYXRmb3Jtcy4gQW5kIEkgc3RpbGwgY29uc2lkZXIg
ZGVhbGluZyB3aXRoIEdQSU8gY2hpcHMgYW4NCj4+IGV4dHJhIGhlYWRhY2hlIHRoYXQgdGhlIGFw
cGxpY2F0aW9ucyBkb24ndCBuZWVkIChwYXJ0aWN1bGFybHkgd2l0aCB0aGUNCj4+IHNoZWVyIG51
bWJlciBvZiB0aGVtIHRoZSBTRlAgY2FzZSkuDQo+IEl0IHNlZW1zIHRvIG1lIHRoYXQgaGF2aW5n
IG5vIGluLWtlcm5lbCBkcml2ZXIgZm9yIHlvdXIgc3R1ZmYgaXMgdGhlDQo+IG1haW4gcG9pbnQg
b2YgYWxsIGhlYWRhY2hlIGhlcmUuIEJ1dCBJIG1pZ2h0IGJlIG1pc3Rha2VuLg0KDQpJdCBjZXJ0
YWlubHkgZG9lc24ndCBoZWxwLCBidXQgSSBkbyB0aGluayB0aGF0IGlzIGFsbCBvcnRob2dvbmFs
IHRvIHRoZSANCmZhY3QgdGhhdCBncGlvX2lzX3Zpc2libGUoKSBjaGFuZ2VzIHRoaW5ncyByYXRo
ZXIgdGhhbiBqdXN0IGRldGVybWluaW5nIA0KaWYgYW4gYXR0cmlidXRlIHNob3VsZCBiZSBleHBv
cnRlZCBvciBub3QuDQoNCg==
