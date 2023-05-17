Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B99705C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjEQBHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjEQBHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:07:31 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263EE469A
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 18:07:29 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 30D592C04E1;
        Wed, 17 May 2023 13:07:26 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1684285646;
        bh=c8UJGbkF8OoBnUkGP2NeuGGC2+opPlu3tHTRdpNEip0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=vRqKoqE+OL7ptImQ1uob4S6+QvUCql8MuUKOuYs1csOuBo/I/XQhMxsBSUmHWGMR9
         8hge4dHKYtoTh8+qZ/VnLE2SOpFol1oVd8/fP0PCKeqa1+tJav7b/hdjjv24qHoqY0
         BlkBeRXlQYQcYVWycSQYo9ukBlDnJNfkuah6jJWNtWJE7tQ0s/H5ETZEYidrr4jzT6
         0oCq0eYfmQ6iBkUwlcit95JPG8B51+w18rtyfpKQdyRce6BpvIqHHJVw5Dv+TNd9Xe
         ms451K+IL9CpO5GdFjw3PQfdG3SftvM28Qz2oucUW8KJZzxA7PK+gnvWjbj76/r8n3
         t3aGfqBaPFCTg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B646428ce0000>; Wed, 17 May 2023 13:07:26 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Wed, 17 May 2023 13:07:25 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Wed, 17 May 2023 13:07:25 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Wed, 17 May 2023 13:07:25 +1200
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
Thread-Index: AQHZhIoofApft8Zm8kuYZtpxH+f53K9VfDeAgAQYHQCAApZDgIAAjA4AgAAH1ICAABG6AIAAD8uAgAAFpYA=
Date:   Wed, 17 May 2023 01:07:25 +0000
Message-ID: <457859be-257a-5528-d5dd-d59c4c9c0636@alliedtelesis.co.nz>
References: <20230512042806.3438373-1-chris.packham@alliedtelesis.co.nz>
 <CACRpkdYz9ipNTo2ORXKWy5Q4uCpKL=9Gd+kK76pestX7Onuz-Q@mail.gmail.com>
 <b36fcdf1-45ab-0c06-efe4-237df0612466@alliedtelesis.co.nz>
 <CACRpkdbiSAFoJP_JB1d_6gQ+Xx7Y+mLAh=C6Za+fpyWuRe6Gbw@mail.gmail.com>
 <31a23398-9b0e-4a19-3576-84fcfd3ce4b5@alliedtelesis.co.nz>
 <ZGQH8/hH0Llx3rzZ@sol>
 <a61415db-fa3f-2fce-9c21-08d8dd026960@alliedtelesis.co.nz>
 <ZGQkEdZ6DoJbgiFh@sol>
In-Reply-To: <ZGQkEdZ6DoJbgiFh@sol>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9061E8A7DC59CC4FB9DEA0D44ABE06D1@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=cY_208gLpoYmvvQ1rHAA:9 a=QEXdDO2ut3YA:10
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

DQpPbiAxNy8wNS8yMyAxMjo0NywgS2VudCBHaWJzb24gd3JvdGU6DQo+IE9uIFR1ZSwgTWF5IDE2
LCAyMDIzIGF0IDExOjUwOjQyUE0gKzAwMDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBIaSBL
ZW50LA0KPj4NCj4+IE9uIDE3LzA1LzIzIDEwOjQ3LCBLZW50IEdpYnNvbiB3cm90ZToNCj4+PiBP
biBUdWUsIE1heSAxNiwgMjAyMyBhdCAxMDoxOToxNFBNICswMDAwLCBDaHJpcyBQYWNraGFtIHdy
b3RlOg0KPj4+PiBPbiAxNy8wNS8yMyAwMTo1NywgTGludXMgV2FsbGVpaiB3cm90ZToNCj4+Pj4+
IE9uIE1vbiwgTWF5IDE1LCAyMDIzIGF0IDEyOjI34oCvQU0gQ2hyaXMgUGFja2hhbQ0KPj4+Pj4g
PENocmlzLlBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4gd3JvdGU6DQo+Pj4+Pg0KPj4+Pj4+
IEluIG15IG9yaWdpbmFsIGNhc2Ugd2hpY2ggaXMgYSBrZXJuZWwgbW9kdWxlIHRoYXQgZXhwb3J0
cyBhIEdQSU8gZm9yDQo+Pj4+Pj4gdXNlcnNwYWNlIHVzaW5nIGdwaW9kX2V4cG9ydCgpDQo+Pj4+
PiBXZSBzaG91bGQgbm90IGFkZCBuZXcgdXNlcnMgZm9yIHRoYXQgQVBJIGFzIGl0IGluY3JlYXNl
IHRoZSB1c2FnZQ0KPj4+Pj4gb2YgdGhlIHN5c2ZzIEFCSSBidXQgaWYgaXQncyBhbiBleGlzdGlu
ZyBpbi10cmVlIHVzZWNhc2UgSSBidXkgaXQuDQo+Pj4+Pg0KPj4+Pj4+IFRoZSBjcnV4IG9mIHRo
ZSBwcm9ibGVtIGlzIHRoYXQgdGhlIGlycV9kZXNjIGlzIGNyZWF0ZWQgd2hlbiBpdCBoYXNuJ3QN
Cj4+Pj4+PiBiZWVuIHJlcXVlc3RlZC4NCj4+Pj4+IFRoZSByaWdodCBzb2x1dGlvbiB0byBtZSBz
ZWVtcyB0byBiZSB0byBub3QgdXNlIGdwaW9kX2V4cG9ydCgpDQo+Pj4+PiBhbmQgbm90IHVzZSBz
eXNmcyBUQkguDQo+Pj4+IFRoYXQncyBub3QgcmVhbGx5IGEgZmVhc2libGUgc29sdXRpb24uIEkn
bSBkZWFsaW5nIHdpdGggYXBwbGljYXRpb24gY29kZQ0KPj4+PiB0aGF0IGhhcyBiZWVuIGhhcHBp
bHkgdXNpbmcgdGhlIHN5c2ZzIGludGVyZmFjZSBmb3IgbWFueSB5ZWFycy4NCj4+Pj4NCj4+Pj4g
SSBhY3R1YWxseSBkaWQgbG9vayBhdCBnZXR0aW5nIHRoYXQgY29kZSB1cGRhdGVkIHRvIHVzZSBs
aWJncGlvIGVhcmxpZXINCj4+Pj4gdGhpcyB5ZWFyIGJ1dCBmb3VuZCB0aGUgQVBJIHdhcyBpbiBh
IHN0YXRlIG9mIGZsdXggYW5kIEkgd2Fzbid0IGdvaW5nIHRvDQo+Pj4+IHJlY29tbWVuZCByZS13
cml0aW5nIHRoZSBhcHBsaWNhdGlvbiBjb2RlIHRvIHVzZSBsaWJncGlvIGlmIEkga25ldyB0aGUN
Cj4+Pj4gQVBJIHdhcyBnb2luZyB0byBjaGFuZ2UgYW5kIHdlJ2QgaGF2ZSB0byByZS13cml0ZSBp
dCBhZ2Fpbi4NCj4+Pj4NCj4+PiBJdHMgJ2xpYmdwaW9kJy4NCj4+Pg0KPj4+PiBFdmVuIG5vdyB3
aXRoIHRoZSAyLjAuMSBsaWJncGlvIHRoZXJlIGRvZXNuJ3Qgc2VlbSB0byBiZSBhIHdheSBvZiBh
c2tpbmcNCj4+Pj4gYWJvdXQganVzdCBHUElPIGxpbmVzIGluIHRoZSBzeXN0ZW0sIGFwcGxpY2F0
aW9uIGNvZGUgd291bGQgc3RpbGwgbmVlZA0KPj4+PiB0byBvcGVuIGV2ZXJ5IC9kZXYvZ3Bpb2No
aXBOIGRldmljZSBhbmQgYXNrIHdoYXQgbGluZXMgYXJlIG9uIHRoZSBjaGlwDQo+Pj4+IGFuZCBr
ZWVwIHRoZSBmZHMgb3BlbiBmb3IgdGhlIGNoaXBzIHRoYXQgaGF2ZSBsaW5lcyB0aGUgYXBwbGlj
YXRpb24NCj4+Pj4gY2FyZXMgYWJvdXQgYnV0IG1ha2Ugc3VyZSB0byBjbG9zZSB0aGUgZmQgZm9y
IHRoZSBvbmVzIHRoYXQgZG9uJ3QuIFNvDQo+Pj4+IG5vdyB0aGUgYXBwbGljYXRpb24gY29kZSBo
YXMgdG8gY2FyZSBhYm91dCBHUElPIGNoaXBzIGluIGFkZGl0aW9uIHRvIHRoZQ0KPj4+PiBHUElP
IGxpbmVzLg0KPj4+Pg0KPj4+IFRyeWluZyB0byBiZXR0ZXIgdW5kZXJzdGFuZCB5b3VyIHVzZSBj
YXNlIC0gaG93IGRvZXMgeW91ciBhcHBsaWNhdGlvbg0KPj4+IGlkZW50aWZ5IGxpbmVzIG9mIGlu
dGVyZXN0IC0ganVzdCB3aGF0ZXZlciBsaW5lcyBwb3AgdXAgaW4NCj4+PiAvc3lzL2NsYXNzL2dw
aW8/DQo+PiBUaGFua3MgZm9yIHRha2luZyBhbiBpbnRlcmVzdC4gV2UgYWN0dWFsbHkgaGF2ZSAy
IGFwcGxpY2F0aW9ucyB0aGF0IG1ha2UNCj4+IHVzZSBvZiB0aGlzIGZ1bmN0aW9uYWxpdHkNCj4+
DQo+PiBUaGUgZmlyc3QgaXMgYSB1c2Vyc3BhY2UgZHJpdmVyIGZvciBhIFBvd2VyIE92ZXIgRXRo
ZXJuZXQgQ29udHJvbGxlcitQU0UNCj4+IGNoaXBzZXQgKEknbGwgcmVmZXIgdG8gdGhpcyBhcyBh
biBNQ1Ugc2luY2UgdGhlIHRoaW5nIHdlIHRhbGsgdG8gaXMNCj4+IHJlYWxseSBhIG1pY3JvIGNv
bnRyb2xsZXIgd2l0aCBhIHZlbmRvciBzdXBwbGllZCBmaXJtd2FyZSBvbiBpdCB0aGF0DQo+PiBk
b2VzIG1vc3Qgb2YgdGhlIFBvRSBzdHVmZikuIENvbW11bmljYXRpb24gdG8gdGhlIE1DVSBpcyBi
YXNlZCBhcm91bmQNCj4+IGNvbW1hbmRzIHNlbnQgdmlhIGkyYy4gQnV0IHRoZXJlIGFyZSBhIGZl
dyBleHRyYSBHUElPcyB0aGF0IGFyZSB1c2VkIHRvDQo+PiByZXNldCB0aGUgTUNVIGFzIHdlbGwg
YXMgcHJvdmlkZSBhIG1lY2hhbmlzbSBmb3IgcXVpY2tseSBkcm9wcGluZyBwb3dlcg0KPj4gb24g
Y2VydGFpbiBldmVudHMgKGUuZy4gaWYgdGhlIHRlbXBlcmF0dXJlIG1vbml0b3JpbmcgZGV0ZWN0
cyBhIHByb2JsZW0pLg0KPj4NCj4+IFdlIGRvIGhhdmUgYSBzbWFsbCBrZXJuZWwgbW9kdWxlIHRo
YXQgZ3JhYnMgdGhlIEdQSU9zIGJhc2VkIG9uIHRoZQ0KPj4gZGV2aWNlIHRyZWUgYW5kIGV4cG9y
dHMgdGhlbSB3aXRoIGEga25vd24gbmFtZXMgKGUuZy4gInBvZS1yZXNldCIsDQo+PiAicG9lLWRp
cyIpIHRoYXQgdGhlIHVzZXJzcGFjZSBkcml2ZXIgY2FuIHVzZS4gQmFjayB3aGVuIHRoYXQgY29k
ZSB3YXMNCj4+IHdyaXR0ZW4gd2UgZGlkIGNvbnNpZGVyIG5vdCBleHBvcnRpbmcgdGhlIEdQSU9z
IGFuZCBpbnN0ZWFkIGhhdmluZyBzb21lDQo+PiBvdGhlciBzeXNmcy9pb2N0bCBpbnRlcmZhY2Ug
aW50byB0aGlzIGtlcm5lbCBtb2R1bGUgYnV0IHRoYXQgc2VlbWVkIG1vcmUNCj4+IHdvcmsgdGhh
biBqdXN0IGNhbGxpbmcgZ3Bpb2RfZXhwb3J0KCkgZm9yIGxpdHRsZSBnYWluLiBUaGlzIGlzIHdo
ZXJlDQo+PiBhZGRpbmcgdGhlIGdwaW8tbmFtZXMgcHJvcGVydHkgaW4gb3VyIC5kdHMgd291bGQg
YWxsb3cgbGliZ3Bpb2QgdG8gZG8NCj4+IHNvbWV0aGluZyBzaW1pbGFyLg0KPj4NCj4gQWgsIHNv
IHlvdSB1c2UgZ3Bpb19leHBvcnRfbGluaygpIHRvIHByb3ZpZGUgdGhlIHdlbGwga25vd24gbmFt
ZT8NCg0KWWVzIGNvcnJlY3QuIEkgZGlkIHdvbmRlciBhdCBvbmUgcG9pbnQgYWJvdXQgcHJvcG9z
aW5nIGEgZHRzIHByb3BlcnR5IHRvIA0KYXV0b21hZ2ljYWxseSBleHBvcnQgdGhlIGdwaW8gd2l0
aCBhIGJldHRlciBuYW1lIHRoYW4gZ3BpbzEyMzQgKGxpa2UgYSANCmdwaW8taG9nIGJ1dCBhbGxv
d2luZyB1c2Vyc3BhY2UgdG8gcG9rZSBhdCBpdCkgYnV0IEknbSBwcmV0dHkgc3VyZSB0aGF0IA0K
d291bGQgaGF2ZSBiZWVuIHJlYnVmZmVkLg0KDQo+PiBIYXZpbmcgdGhlIEdQSU9zIGluIHN5c2Zz
IGlzIGFsc28gY29udmVuaWVudCBhcyB3ZSBjYW4gaGF2ZSBhIHN5c3RlbWQNCj4+IEV4ZWNTdG9w
UG9zdCBzY3JpcHQgdGhhdCBjYW4gZHJvcCBwb3dlciBhbmQvb3IgcmVzZXQgdGhlIE1DVSBpZiBv
dXINCj4+IGFwcGxpY2F0aW9uIGNyYXNoZXMuIEknbSBub3Qgc3VyZSBpZiB0aGUgR1BJTyBjaGFy
ZGV2IGludGVyZmFjZSBkZWFscw0KPj4gd2l0aCByZWxlYXNpbmcgdGhlIEdQSU8gbGluZXMgaWYg
dGhlIHByb2Nlc3MgdGhhdCByZXF1ZXN0ZWQgdGhlbSBleGl0cw0KPj4gYWJub3JtYWxseSAoSSBh
c3N1bWUgaXQgZG9lcykgYW5kIG9idmlvdXNseSBvdXIgRXhlY1N0b3BQb3N0IHNjcmlwdA0KPj4g
d291bGQgbmVlZCB1cGRhdGluZyB0byB1c2Ugc29tZSBvZiB0aGUgbGliZ3Bpb2QgYXBwbGljYXRp
b25zIHRvIGRvIHdoYXQNCj4+IGl0IGN1cnJlbnRseSBkb2VzIHdpdGggYSBzaW1wbGUgJ2VjaG8g
MSA+Li4uL3BvZS1yZXNldCcNCj4+DQo+IElyb25pY2FsbHksIHRoZSB1c3VhbCBjb21wbGFpbnQg
d3J0IHBvd2VyL3Jlc2V0IGxpbmVzIGlzIHRoYXQgdXNlcnMNCj4gZG9uJ3Qgd2FudCBpdCB0byBi
ZSByZXNldCBiYWNrIHRvIGRlZmF1bHQgd2hlbiB0aGVpciBhcHAgY3Jhc2hlcy4NCg0KWWVhaCBp
dCdzIGltcG9zc2libGUgdG8gcGxlYXNlIGV2ZXJ5b25lLiBNaWdodCBiZSB0aGUga2luZCBvZiB0
aGluZyB0aGF0IA0KY291bGQgYmUgc2V0IGJ5IHRoZSBhcHBsaWNhdGlvbiB3aGVuIHJlcXVlc3Rp
bmcgdGhlIGxpbmUgKGUuZyBtYWtlIHRoaXMgDQpoaWdoIG9uIGNsb3NlKCksIGxlYXZlIGl0IGFz
LWlzKS4NCg0KPiBXaGF0IGhhcHBlbnMgd2hlbiB0aGUgbGluZSBpcyByZWxlYXNlZCBpcyBkcml2
ZXIgZGVwZW5kZW50Lg0KPiBUaGUgdUFQSSBjYW4ndCBtYWtlIGFueSBndWFyYW50ZWVzLCBhcyBp
dCByZWxlYXNlcyB0aGUgbGluZSBiYWNrIHRvIHRoZQ0KPiBkZXZpY2UgZHJpdmVyLiBUeXBpY2Fs
bHkgaXMgaXQgc2V0IGJhY2sgdG8gaXRzIGRlZmF1bHQgc3RhdGUsIHNvIHRoYXQNCj4gbWlnaHQg
ZG8gZXhhY3RseSB3aGF0IHlvdSB3YW50IG91dCBvZiB0aGUgYm94IC0gbm8gRXhlY1N0b3BQb3N0
IHJlcXVpcmVkLg0KPiBCdXQgeW91IHdvdWxkIG5lZWQgdG8gY29uZmlybSBvbiB5b3VyIGhhcmR3
YXJlLg0KV2l0aCBhIHBjYTk1NTUgSSB0aGluayBpdCdkIGp1c3Qgc3RheSBpbiB3aGF0ZXZlciBz
dGF0ZSB3YXMgbGFzdCBkcml2ZW4uIA0KSXQgbWlnaHQgZ28gYmFjayB0byBhbiBpbnB1dCB3aGlj
aCB3b3VsZCBsZXQgdGhlIHB1bGwtdXBzIHRha2Ugb3Zlci4NCj4gVGhlcmUgd2FzIGFsc28gc29t
ZSBkaXNjdXNzaW9uIG9uIG1ha2luZyB0aGUgZGVmYXVsdCBzdGF0ZSBjb25maWd1cmFibGUNCj4g
dmlhIGR0c1sxXSwgYnV0IEknbSBub3Qgc3VyZSB3aGF0IGhhcHBlbmVkIHRvIHRoYXQuDQo+DQo+
PiBUaGUgc2Vjb25kIGFwcGxpY2F0aW9uIGlzIGEgdXNlcnNwYWNlIGRyaXZlciBmb3IgYSBMMyBu
ZXR3b3JrIHN3aXRjaA0KPj4gKGFjdHVhbGx5IHR3byBvZiB0aGVtIGZvciBkaWZmZXJlbnQgc2ls
aWNvbiB2ZW5kb3JzKS4gQWdhaW4gdGhpcyBuZWVkcw0KPj4gdG8gZGVhbCB3aXRoIHJlc2V0cyBm
b3IgUEhZcyBjb25uZWN0ZWQgdG8gdGhlIHN3aXRjaCB0aGF0IHRoZSBrZXJuZWwgaGFzDQo+PiBu
byB2aXNpYmlsaXR5IG9mIGFzIHdlbGwgYXMgdGhlIEdQSU9zIGZvciB0aGUgU0ZQIGNhZ2VzLiBB
Z2FpbiB3ZSBoYXZlIGENCj4+IHNsaWdodGx5IGxlc3Mgc2ltcGxlIGtlcm5lbCBtb2R1bGUgdGhh
dCBncmFicyBhbGwgdGhlc2UgR1BJT3MgYW5kDQo+PiBleHBvcnRzIHRoZW0gd2l0aCBrbm93biBu
YW1lcy4gVGhpcyB0aW1lIHRoZXJlIGFyZSBjb25zaWRlcmFibHkgbW9yZSBvZg0KPj4gdGhlc2Ug
R1BJT3MgKG91ciBsYXJnZXN0IHN5c3RlbSBjdXJyZW50bHkgaGFzIDk2IFNGUCsgcG9ydHMgd2l0
aCA0IEdQSU9zDQo+PiBwZXIgcG9ydCkgc28gd2UncmUgbXVjaCBtb3JlIHJlbGlhbnQgb24gYmVp
bmcgYWJsZSB0byBkbyB0aGluZ3MgbGlrZQ0KPj4gYGZvciB4IGluIHBvcnQqdHgtZGlzOyBkbyBl
Y2hvIDEgPiR4OyBkb25lYA0KPj4NCj4gR2l2ZW4gYXBwcm9wcmlhdGUgbGluZSBuYW1lcywgdGhh
dCBpcyBhbHJlYWR5IHNvbWV0aGluZyB5b3UgY2FuIGRvIHdpdGgNCj4gdGhlIGxpYmdwaW9kIHYy
IHRvb2xzLiAgU29tZXRoaW5nIGxpa2U6DQo+DQo+IGBmb3IgeCBpbiBncGlvY2hpcCo7IGRvIGdw
aW9zZXQgLWMgeCB0eC1kaXM9MTsgZG9uZWANCldvdWxkIHRoYXQgZGVhbCB3aXRoIHRoZSBmYWN0
IHRoZSBHUElPIGxpbmVzIGFyZSBwb3J0MS10eC1kaXMsIA0KcG9ydDItdHgtZGlzLCAuLi4gcG9y
dDk2LXR4LWRpcz8NCj4gQmVoaW5kIHRoZSBzY2VuZXMgZ3Bpb3NldCBpcyBkb2luZyB0aGUgbmFt
ZSB0byBvZmZzZXQgbWFwcGluZywgd2hpY2ggaXMNCj4gbGVzcyBlZmZpY2VudCB0aGFuIGlkZW50
aWZ5aW5nIHRoZSBsaW5lIGJ5IG9mZnNldCwgYnV0IGdpdmVuIHlvdSBhcmUNCj4gY2FsbGluZyBm
cm9tIHNoZWxsIHBlcmZvcm1hbmNlIHByb2JhYmx5IGlzbid0IGFuIGlzc3VlLg0KDQpZZWFoIGl0
J3MgYSBzY3JpcHQgb2YgbGFzdCByZXNvcnQgc28gaXQncyBwZXJmb3JtYW5jZSBpcyBub3QgdG9v
IA0KY3JpdGljYWwuIFByb2JhYmx5IG9uLXBhciB3aXRoIGZpbGUgZ2xvYmluZyBvZiBpbmRpdmlk
dWFsIGxpbmVzIGFueXdheS4NCg0KPg0KPj4gSSdtIHN1cmUgYm90aCBvZiB0aGVzZSBhcHBsaWNh
dGlvbnMgY291bGQgYmUgcmUtd3JpdHRlbiBhcm91bmQgbGliZ3Bpb2QNCj4+IGJ1dCB0aGF0IHdv
dWxkIGluY3VyIGEgc2lnbmlmaWNhbnQgYW1vdW50IG9mIHJlZ3Jlc3Npb24gdGVzdGluZyBvbg0K
Pj4gZXhpc3RpbmcgcGxhdGZvcm1zLiBBbmQgSSBzdGlsbCBjb25zaWRlciBkZWFsaW5nIHdpdGgg
R1BJTyBjaGlwcyBhbg0KPj4gZXh0cmEgaGVhZGFjaGUgdGhhdCB0aGUgYXBwbGljYXRpb25zIGRv
bid0IG5lZWQgKHBhcnRpY3VsYXJseSB3aXRoIHRoZQ0KPj4gc2hlZXIgbnVtYmVyIG9mIHRoZW0g
dGhlIFNGUCBjYXNlKS4NCj4+DQo+IFN0cmljdGx5IHNwZWFraW5nIHlvdSBoYXZlIHJlZ3Jlc3Np
b24gdGVzdGluZyB0byBkZWFsIHdpdGggd2hpY2ggZXZlcg0KPiB3YXkgeW91IGdvLiBUaG91Z2gg
d291bGRuJ3QgcmVncmVzc2lvbiB0ZXN0aW5nIGZvciBhIGtlcm5lbCBjaGFuZ2UgYmUgbW9yZQ0K
PiB3b3JrIHRoYW4gdGhlIGFwcCBhbG9uZT8NCg0KV2VsbCB0aGVyZSdzIHRlc3RpbmcgdGhlIGV4
aXN0aW5nIGFwcCBvbiBuZXcgaGFyZHdhcmUgdnMgdGVzdGluZyB0aGUgDQpyZS13cml0dGVuIGFw
cCBvbiBhbGwgZXhpc3RpbmcgaGFyZHdhcmUgYW5kIHRoZSBuZXcgaGFyZHdhcmUuIEJ1dCB0aGF0
J3MgDQphbHdheXMgdGhlIHRyYWRlIG9mZiB3aXRoIHByZXR0eSBtdWNoIGFueSBzeXN0ZW0gd2lk
ZSBpbXByb3ZlbWVudC4NCg==
