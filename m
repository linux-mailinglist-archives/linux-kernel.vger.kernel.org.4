Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1AF705B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 01:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjEPXuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 19:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEPXuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 19:50:50 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AB7527C
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:50:47 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D6FDB2C04E1;
        Wed, 17 May 2023 11:50:43 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1684281043;
        bh=3D1Qeg9Vdm2SO2BYRMW3uU/dp1GudVa7VV/Yx6qdljs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=EIimZDitC0lLMiMFeO6XI8fLS3c/bvjuKrlKKoY11IIfwx6vTAwEMA6nQcYs1BCdl
         4hxn3dfwcNBeRVLv9Rb/GQcsdY0VsmbxJhYWpxFnOquqB1RbS9/rCwp1RR+rq6x+dR
         +w/LNysmOuBg5TLBGEXcPyj5SLR9xy+R2zeEtCe5fk6ccu0aTL8Q2plPbiHpq4GV+u
         hgLt6VzjNtJ6zgZREjQneCWB49pXodYdIKnw+wX6yFNfvHnQFw77I1VbITgW3aJIRA
         lzj+gPoo6KWQvqXl0vJy0R1v7f+r0ufKZ+DGp7NK2D99o7B0C+rZ+4BJK/odgKV3WS
         JAKmFAvYCesXA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B646416d30001>; Wed, 17 May 2023 11:50:43 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Wed, 17 May 2023 11:50:43 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Wed, 17 May 2023 11:50:43 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Wed, 17 May 2023 11:50:42 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Kent Gibson <warthog618@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "johan@kernel.org" <johan@kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "maz@kernel.org" <maz@kernel.org>,
        Ben Brown <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Thread-Topic: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Thread-Index: AQHZhIoofApft8Zm8kuYZtpxH+f53K9VfDeAgAQYHQCAApZDgIAAjA4AgAAH1ICAABG6AA==
Date:   Tue, 16 May 2023 23:50:42 +0000
Message-ID: <a61415db-fa3f-2fce-9c21-08d8dd026960@alliedtelesis.co.nz>
References: <20230512042806.3438373-1-chris.packham@alliedtelesis.co.nz>
 <CACRpkdYz9ipNTo2ORXKWy5Q4uCpKL=9Gd+kK76pestX7Onuz-Q@mail.gmail.com>
 <b36fcdf1-45ab-0c06-efe4-237df0612466@alliedtelesis.co.nz>
 <CACRpkdbiSAFoJP_JB1d_6gQ+Xx7Y+mLAh=C6Za+fpyWuRe6Gbw@mail.gmail.com>
 <31a23398-9b0e-4a19-3576-84fcfd3ce4b5@alliedtelesis.co.nz>
 <ZGQH8/hH0Llx3rzZ@sol>
In-Reply-To: <ZGQH8/hH0Llx3rzZ@sol>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <84A7B75C14345E4490F53D57F5980578@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=ZguqjsaIh1nrprT209UA:9 a=QEXdDO2ut3YA:10
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

SGkgS2VudCwNCg0KT24gMTcvMDUvMjMgMTA6NDcsIEtlbnQgR2lic29uIHdyb3RlOg0KPiBPbiBU
dWUsIE1heSAxNiwgMjAyMyBhdCAxMDoxOToxNFBNICswMDAwLCBDaHJpcyBQYWNraGFtIHdyb3Rl
Og0KPj4gT24gMTcvMDUvMjMgMDE6NTcsIExpbnVzIFdhbGxlaWogd3JvdGU6DQo+Pj4gT24gTW9u
LCBNYXkgMTUsIDIwMjMgYXQgMTI6MjfigK9BTSBDaHJpcyBQYWNraGFtDQo+Pj4gPENocmlzLlBh
Y2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4gd3JvdGU6DQo+Pj4NCj4+Pj4gSW4gbXkgb3JpZ2lu
YWwgY2FzZSB3aGljaCBpcyBhIGtlcm5lbCBtb2R1bGUgdGhhdCBleHBvcnRzIGEgR1BJTyBmb3IN
Cj4+Pj4gdXNlcnNwYWNlIHVzaW5nIGdwaW9kX2V4cG9ydCgpDQo+Pj4gV2Ugc2hvdWxkIG5vdCBh
ZGQgbmV3IHVzZXJzIGZvciB0aGF0IEFQSSBhcyBpdCBpbmNyZWFzZSB0aGUgdXNhZ2UNCj4+PiBv
ZiB0aGUgc3lzZnMgQUJJIGJ1dCBpZiBpdCdzIGFuIGV4aXN0aW5nIGluLXRyZWUgdXNlY2FzZSBJ
IGJ1eSBpdC4NCj4+Pg0KPj4+PiBUaGUgY3J1eCBvZiB0aGUgcHJvYmxlbSBpcyB0aGF0IHRoZSBp
cnFfZGVzYyBpcyBjcmVhdGVkIHdoZW4gaXQgaGFzbid0DQo+Pj4+IGJlZW4gcmVxdWVzdGVkLg0K
Pj4+IFRoZSByaWdodCBzb2x1dGlvbiB0byBtZSBzZWVtcyB0byBiZSB0byBub3QgdXNlIGdwaW9k
X2V4cG9ydCgpDQo+Pj4gYW5kIG5vdCB1c2Ugc3lzZnMgVEJILg0KPj4gVGhhdCdzIG5vdCByZWFs
bHkgYSBmZWFzaWJsZSBzb2x1dGlvbi4gSSdtIGRlYWxpbmcgd2l0aCBhcHBsaWNhdGlvbiBjb2Rl
DQo+PiB0aGF0IGhhcyBiZWVuIGhhcHBpbHkgdXNpbmcgdGhlIHN5c2ZzIGludGVyZmFjZSBmb3Ig
bWFueSB5ZWFycy4NCj4+DQo+PiBJIGFjdHVhbGx5IGRpZCBsb29rIGF0IGdldHRpbmcgdGhhdCBj
b2RlIHVwZGF0ZWQgdG8gdXNlIGxpYmdwaW8gZWFybGllcg0KPj4gdGhpcyB5ZWFyIGJ1dCBmb3Vu
ZCB0aGUgQVBJIHdhcyBpbiBhIHN0YXRlIG9mIGZsdXggYW5kIEkgd2Fzbid0IGdvaW5nIHRvDQo+
PiByZWNvbW1lbmQgcmUtd3JpdGluZyB0aGUgYXBwbGljYXRpb24gY29kZSB0byB1c2UgbGliZ3Bp
byBpZiBJIGtuZXcgdGhlDQo+PiBBUEkgd2FzIGdvaW5nIHRvIGNoYW5nZSBhbmQgd2UnZCBoYXZl
IHRvIHJlLXdyaXRlIGl0IGFnYWluLg0KPj4NCj4gSXRzICdsaWJncGlvZCcuDQo+DQo+PiBFdmVu
IG5vdyB3aXRoIHRoZSAyLjAuMSBsaWJncGlvIHRoZXJlIGRvZXNuJ3Qgc2VlbSB0byBiZSBhIHdh
eSBvZiBhc2tpbmcNCj4+IGFib3V0IGp1c3QgR1BJTyBsaW5lcyBpbiB0aGUgc3lzdGVtLCBhcHBs
aWNhdGlvbiBjb2RlIHdvdWxkIHN0aWxsIG5lZWQNCj4+IHRvIG9wZW4gZXZlcnkgL2Rldi9ncGlv
Y2hpcE4gZGV2aWNlIGFuZCBhc2sgd2hhdCBsaW5lcyBhcmUgb24gdGhlIGNoaXANCj4+IGFuZCBr
ZWVwIHRoZSBmZHMgb3BlbiBmb3IgdGhlIGNoaXBzIHRoYXQgaGF2ZSBsaW5lcyB0aGUgYXBwbGlj
YXRpb24NCj4+IGNhcmVzIGFib3V0IGJ1dCBtYWtlIHN1cmUgdG8gY2xvc2UgdGhlIGZkIGZvciB0
aGUgb25lcyB0aGF0IGRvbid0LiBTbw0KPj4gbm93IHRoZSBhcHBsaWNhdGlvbiBjb2RlIGhhcyB0
byBjYXJlIGFib3V0IEdQSU8gY2hpcHMgaW4gYWRkaXRpb24gdG8gdGhlDQo+PiBHUElPIGxpbmVz
Lg0KPj4NCj4gVHJ5aW5nIHRvIGJldHRlciB1bmRlcnN0YW5kIHlvdXIgdXNlIGNhc2UgLSBob3cg
ZG9lcyB5b3VyIGFwcGxpY2F0aW9uDQo+IGlkZW50aWZ5IGxpbmVzIG9mIGludGVyZXN0IC0ganVz
dCB3aGF0ZXZlciBsaW5lcyBwb3AgdXAgaW4NCj4gL3N5cy9jbGFzcy9ncGlvPw0KDQpUaGFua3Mg
Zm9yIHRha2luZyBhbiBpbnRlcmVzdC4gV2UgYWN0dWFsbHkgaGF2ZSAyIGFwcGxpY2F0aW9ucyB0
aGF0IG1ha2UgDQp1c2Ugb2YgdGhpcyBmdW5jdGlvbmFsaXR5DQoNClRoZSBmaXJzdCBpcyBhIHVz
ZXJzcGFjZSBkcml2ZXIgZm9yIGEgUG93ZXIgT3ZlciBFdGhlcm5ldCBDb250cm9sbGVyK1BTRSAN
CmNoaXBzZXQgKEknbGwgcmVmZXIgdG8gdGhpcyBhcyBhbiBNQ1Ugc2luY2UgdGhlIHRoaW5nIHdl
IHRhbGsgdG8gaXMgDQpyZWFsbHkgYSBtaWNybyBjb250cm9sbGVyIHdpdGggYSB2ZW5kb3Igc3Vw
cGxpZWQgZmlybXdhcmUgb24gaXQgdGhhdCANCmRvZXMgbW9zdCBvZiB0aGUgUG9FIHN0dWZmKS4g
Q29tbXVuaWNhdGlvbiB0byB0aGUgTUNVIGlzIGJhc2VkIGFyb3VuZCANCmNvbW1hbmRzIHNlbnQg
dmlhIGkyYy4gQnV0IHRoZXJlIGFyZSBhIGZldyBleHRyYSBHUElPcyB0aGF0IGFyZSB1c2VkIHRv
IA0KcmVzZXQgdGhlIE1DVSBhcyB3ZWxsIGFzIHByb3ZpZGUgYSBtZWNoYW5pc20gZm9yIHF1aWNr
bHkgZHJvcHBpbmcgcG93ZXIgDQpvbiBjZXJ0YWluIGV2ZW50cyAoZS5nLiBpZiB0aGUgdGVtcGVy
YXR1cmUgbW9uaXRvcmluZyBkZXRlY3RzIGEgcHJvYmxlbSkuDQoNCldlIGRvIGhhdmUgYSBzbWFs
bCBrZXJuZWwgbW9kdWxlIHRoYXQgZ3JhYnMgdGhlIEdQSU9zIGJhc2VkIG9uIHRoZSANCmRldmlj
ZSB0cmVlIGFuZCBleHBvcnRzIHRoZW0gd2l0aCBhIGtub3duIG5hbWVzIChlLmcuICJwb2UtcmVz
ZXQiLCANCiJwb2UtZGlzIikgdGhhdCB0aGUgdXNlcnNwYWNlIGRyaXZlciBjYW4gdXNlLiBCYWNr
IHdoZW4gdGhhdCBjb2RlIHdhcyANCndyaXR0ZW4gd2UgZGlkIGNvbnNpZGVyIG5vdCBleHBvcnRp
bmcgdGhlIEdQSU9zIGFuZCBpbnN0ZWFkIGhhdmluZyBzb21lIA0Kb3RoZXIgc3lzZnMvaW9jdGwg
aW50ZXJmYWNlIGludG8gdGhpcyBrZXJuZWwgbW9kdWxlIGJ1dCB0aGF0IHNlZW1lZCBtb3JlIA0K
d29yayB0aGFuIGp1c3QgY2FsbGluZyBncGlvZF9leHBvcnQoKSBmb3IgbGl0dGxlIGdhaW4uIFRo
aXMgaXMgd2hlcmUgDQphZGRpbmcgdGhlIGdwaW8tbmFtZXMgcHJvcGVydHkgaW4gb3VyIC5kdHMg
d291bGQgYWxsb3cgbGliZ3Bpb2QgdG8gZG8gDQpzb21ldGhpbmcgc2ltaWxhci4NCg0KSGF2aW5n
IHRoZSBHUElPcyBpbiBzeXNmcyBpcyBhbHNvIGNvbnZlbmllbnQgYXMgd2UgY2FuIGhhdmUgYSBz
eXN0ZW1kIA0KRXhlY1N0b3BQb3N0IHNjcmlwdCB0aGF0IGNhbiBkcm9wIHBvd2VyIGFuZC9vciBy
ZXNldCB0aGUgTUNVIGlmIG91ciANCmFwcGxpY2F0aW9uIGNyYXNoZXMuIEknbSBub3Qgc3VyZSBp
ZiB0aGUgR1BJTyBjaGFyZGV2IGludGVyZmFjZSBkZWFscyANCndpdGggcmVsZWFzaW5nIHRoZSBH
UElPIGxpbmVzIGlmIHRoZSBwcm9jZXNzIHRoYXQgcmVxdWVzdGVkIHRoZW0gZXhpdHMgDQphYm5v
cm1hbGx5IChJIGFzc3VtZSBpdCBkb2VzKSBhbmQgb2J2aW91c2x5IG91ciBFeGVjU3RvcFBvc3Qg
c2NyaXB0IA0Kd291bGQgbmVlZCB1cGRhdGluZyB0byB1c2Ugc29tZSBvZiB0aGUgbGliZ3Bpb2Qg
YXBwbGljYXRpb25zIHRvIGRvIHdoYXQgDQppdCBjdXJyZW50bHkgZG9lcyB3aXRoIGEgc2ltcGxl
ICdlY2hvIDEgPi4uLi9wb2UtcmVzZXQnDQoNClRoZSBzZWNvbmQgYXBwbGljYXRpb24gaXMgYSB1
c2Vyc3BhY2UgZHJpdmVyIGZvciBhIEwzIG5ldHdvcmsgc3dpdGNoIA0KKGFjdHVhbGx5IHR3byBv
ZiB0aGVtIGZvciBkaWZmZXJlbnQgc2lsaWNvbiB2ZW5kb3JzKS4gQWdhaW4gdGhpcyBuZWVkcyAN
CnRvIGRlYWwgd2l0aCByZXNldHMgZm9yIFBIWXMgY29ubmVjdGVkIHRvIHRoZSBzd2l0Y2ggdGhh
dCB0aGUga2VybmVsIGhhcyANCm5vIHZpc2liaWxpdHkgb2YgYXMgd2VsbCBhcyB0aGUgR1BJT3Mg
Zm9yIHRoZSBTRlAgY2FnZXMuIEFnYWluIHdlIGhhdmUgYSANCnNsaWdodGx5IGxlc3Mgc2ltcGxl
IGtlcm5lbCBtb2R1bGUgdGhhdCBncmFicyBhbGwgdGhlc2UgR1BJT3MgYW5kIA0KZXhwb3J0cyB0
aGVtIHdpdGgga25vd24gbmFtZXMuIFRoaXMgdGltZSB0aGVyZSBhcmUgY29uc2lkZXJhYmx5IG1v
cmUgb2YgDQp0aGVzZSBHUElPcyAob3VyIGxhcmdlc3Qgc3lzdGVtIGN1cnJlbnRseSBoYXMgOTYg
U0ZQKyBwb3J0cyB3aXRoIDQgR1BJT3MgDQpwZXIgcG9ydCkgc28gd2UncmUgbXVjaCBtb3JlIHJl
bGlhbnQgb24gYmVpbmcgYWJsZSB0byBkbyB0aGluZ3MgbGlrZSANCmBmb3IgeCBpbiBwb3J0KnR4
LWRpczsgZG8gZWNobyAxID4keDsgZG9uZWANCg0KSSdtIHN1cmUgYm90aCBvZiB0aGVzZSBhcHBs
aWNhdGlvbnMgY291bGQgYmUgcmUtd3JpdHRlbiBhcm91bmQgbGliZ3Bpb2QgDQpidXQgdGhhdCB3
b3VsZCBpbmN1ciBhIHNpZ25pZmljYW50IGFtb3VudCBvZiByZWdyZXNzaW9uIHRlc3Rpbmcgb24g
DQpleGlzdGluZyBwbGF0Zm9ybXMuIEFuZCBJIHN0aWxsIGNvbnNpZGVyIGRlYWxpbmcgd2l0aCBH
UElPIGNoaXBzIGFuIA0KZXh0cmEgaGVhZGFjaGUgdGhhdCB0aGUgYXBwbGljYXRpb25zIGRvbid0
IG5lZWQgKHBhcnRpY3VsYXJseSB3aXRoIHRoZSANCnNoZWVyIG51bWJlciBvZiB0aGVtIHRoZSBT
RlAgY2FzZSkuDQoNCj4NCj4gQ2hlZXJzLA0KPiBLZW50Lg==
