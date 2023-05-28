Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA2371407E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 23:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjE1VFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 17:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjE1VE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 17:04:58 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81968BD
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 14:04:55 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 679442C0547;
        Mon, 29 May 2023 09:04:41 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685307881;
        bh=EgCyR4qAqshNKE0iQkAecNkOYcsrlHzkrPMCzEGjCpE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=aTaCH8h1ANpWjZ2BJAxS+1tREtPViSI+bBc4+fAFYYIVNoSzlgIEejsV9RBN5+Clj
         6RMihdSj1icXRrK4lbfoTvNozOqUAiGgZzhS6IbRZ4yJcCzdKyo5W7WuXpIWgXDhV6
         bf3kyHxPZZAYJN9MJ568mA4rWCVeSD89v6KeRnFW4LNckzSpgN+ngrDz9LCbwkHysT
         Pl6vkKT7Ul/cl+SPwnjyDfdh5NmhC5yKrjK3KQgYLwHmlmOGoN9LB6JE5iJlbmCpGL
         NyuB+vFF33JwK91mfauofNYbgpQyX3/4YwPja3GLtkTNsJkRB0ggpK9BXhgIhMSg6A
         k6oJx2qt4Eywg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6473c1e90001>; Mon, 29 May 2023 09:04:41 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Mon, 29 May 2023 09:04:41 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Mon, 29 May 2023 09:04:41 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Mon, 29 May 2023 09:04:40 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "johan@kernel.org" <johan@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        Ben Brown <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Thread-Topic: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Thread-Index: AQHZhIoofApft8Zm8kuYZtpxH+f53K9VfDeAgAQYHQCAApZDgIAAjA4AgAAH1ICAABG6AIAAmBEAgADTMYCACRxagIAATeQAgACMzYCAA5twAIADr9oA
Date:   Sun, 28 May 2023 21:04:40 +0000
Message-ID: <6f168d68-35fc-3411-25d5-5b1295798fb8@alliedtelesis.co.nz>
References: <ZGzsD_HMbMGhGwcr@surfacebook>
 <72990baf-6964-01ad-d891-7090831d0310@alliedtelesis.co.nz>
 <ZG2jgwjK+CBmOk3G@sol>
 <CAMRc=Mf4+uYuwHACF3arkwhx2sXmTAJL-t1nVk-Xbg6tVy4WFQ@mail.gmail.com>
In-Reply-To: <CAMRc=Mf4+uYuwHACF3arkwhx2sXmTAJL-t1nVk-Xbg6tVy4WFQ@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE41452A99F3A148AF7CCDD2A0784474@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=pGLkceISAAAA:8 a=EZTzexkD_WjTGE8n2dAA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFydCwNCg0KT24gMjcvMDUvMjMgMDA6NDYsIEJhcnRvc3ogR29sYXN6ZXdza2kgd3JvdGU6
DQo+IE9uIFdlZCwgTWF5IDI0LCAyMDIzIGF0IDc6NDHigK9BTSBLZW50IEdpYnNvbiA8d2FydGhv
ZzYxOEBnbWFpbC5jb20+IHdyb3RlOg0KPj4gT24gVHVlLCBNYXkgMjMsIDIwMjMgYXQgMDk6MTc6
MjZQTSArMDAwMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+PiBPbiAyNC8wNS8yMyAwNDozOCwg
YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbSB3cm90ZToNCj4+Pj4gV2VkLCBNYXkgMTcsIDIwMjMg
YXQgMDk6MzA6NTFQTSArMDAwMCwgQ2hyaXMgUGFja2hhbSBraXJqb2l0dGk6DQo+Pj4+PiBPbiAx
Ny8wNS8yMyAyMDo1NCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPj4+Pj4+IE9uIFdlZCwgTWF5
IDE3LCAyMDIzIGF0IDI6NTDigK9BTSBDaHJpcyBQYWNraGFtDQo+Pj4+Pj4gPENocmlzLlBhY2to
YW1AYWxsaWVkdGVsZXNpcy5jby5uej4gd3JvdGU6DQo+Pj4+Pj4+IE9uIDE3LzA1LzIzIDEwOjQ3
LCBLZW50IEdpYnNvbiB3cm90ZToNCj4+Pj4gLi4uDQo+Pj4+DQo+Pj4+PiBBZ2FpbiB0aGUgcHJv
YmxlbSBib2lscyBkb3duIHRvIHRoZSBmYWN0IHRoYXQgd2UgaGF2ZSBhIHVzZXJzcGFjZSBzd2l0
Y2gNCj4+Pj4+IGRyaXZlciAod2hpY2ggdXNlcyBhIHZlbmRvciBzdXBwbGllZCBub24tZnJlZSBT
REspLiBTbyBkZXNwaXRlIHRoZQ0KPj4+Pj4ga2VybmVsIGhhdmluZyBxdWl0ZSBnb29kIHN1cHBv
cnQgZm9yIFNGUHMgSSBjYW4ndCB1c2UgaXQgd2l0aG91dCBhDQo+Pj4+PiBuZXRkZXYgdG8gYXR0
YWNoIGl0IHRvLg0KPj4+PiBUaGF0IHVzZXIgc3BhY2UgZHJpdmVyIGlzIHVzaW5nIHdoYXQgZnJv
bSB0aGUga2VybmVsPyBHUElPIHN5c2ZzPw0KPj4+IFllcyBHUElPIHN5c2ZzIGFuZCBleHBvcnRl
ZCBsaW5rcyB3aXRoIGtub3duIG5hbWVzLCB3aGljaCBhbGxvd3MgdGhpbmdzDQo+Pj4gdG8gYmUg
ZG9uZSBwZXItcG9ydCBidXQgYWxzbyB3aWxkY2FyZGVkIGZyb20gc2hlbGwgc2NyaXB0cyBpZiBu
ZWNlc3NhcnkuDQo+Pj4gSSB0aGluayB0aGUga2V5IHBvaW50IGhlcmUgaXMgdGhhdCBpdCBkb2Vz
bid0IGNhcmUgYWJvdXQgdGhlIEdQSU8gY2hpcHMNCj4+PiBqdXN0IHRoZSBpbmRpdmlkdWFsIEdQ
SU8gbGluZXMuIEFueXRoaW5nIGludm9sdmluZyBsaWJncGlvZCBjdXJyZW50bHkNCj4+PiBoYXMg
dG8gc3RhcnQgY2FyaW5nIGFib3V0IEdQSU8gY2hpcHMgKG9yIEknbSBtaXNyZWFkaW5nIHRoZSBk
b2NzKS4NCj4+Pg0KPj4gQXMgcHJldmlvdXNseSBtZW50aW9uZWQsIHRoZSBsaWJncGlvZCB0b29s
cyBub3cgc3VwcG9ydCBpZGVudGlmaWNhdGlvbiBvZg0KPj4gbGluZXMgYnkgbmFtZS4NCj4+IEFz
IGxvbmcgYXMgeW91ciBsaW5lIG5hbWVzIGFyZSB1bmlxdWUgYXQgc3lzdGVtIHNjb3BlIHlvdSBz
aG91bGQgYmUNCj4+IGdvb2QuICBPdGhlcndpc2UgeW91IGhhdmUgbm8gb3B0aW9uIGJ1dCB0byBp
ZGVudGlmeSBieSAoY2hpcCxvZmZzZXQpLg0KPj4NCj4+IFdydCB0aGUgbGlicmFyeSBpdHNlbGYs
IEkgd2FzIHRoaW5raW5nIGFib3V0IHJlbG9jYXRpbmcgdGhlIGxpbmUgbmFtZQ0KPj4gcmVzb2x1
dGlvbiBsb2dpYyBmcm9tIHRoZSB0b29scyBpbnRvIHRoZSBsaWJyYXJ5IGl0c2VsZiwgc28gaXQg
d291bGQgYmUNCj4+IG1vcmUgZ2VuZXJhbGx5IGFjY2Vzc2libGUsIGJ1dCBoYXZlbid0IGdvdHRl
biB0aGVyZSB5ZXQuDQo+Pg0KPj4gSSdtIGFsc28gb2YgdGhlIG9waW5pb24gdGhhdCBsaWJncGlv
ZCBpcyB0b28gbG93IGxldmVsIGZvciBjb21tb24NCj4+IHRhc2tzLiAgVGhhdCBpcyBuZWNlc3Nh
cnkgdG8gYWNjZXNzIGFsbCB0aGUgZmVhdHVyZXMgb2YgdGhlIHVBUEksIGJ1dA0KPj4gZm9yIGJh
c2ljIHRhc2tzIGl0IHdvdWxkIGJlIG5pY2UgdG8gaGF2ZSBhIGhpZ2hlciBsZXZlbCBhYnN0cmFj
dGlvbiB0bw0KPj4gcmVkdWNlIHRoZSBiYXJyaWVyIHRvIGVudHJ5Lg0KPj4NCj4+IGUuZy4gaW4g
UnVzdCBJIGNhbiBkbyB0aGlzOg0KPj4NCj4+ICAgICAgbGV0IGxlZDAgPSBncGlvY2Rldjo6Zmlu
ZF9uYW1lZF9saW5lKCJMRUQwIikudW53cmFwKCk7DQo+PiAgICAgIGxldCByZXEgPSBSZXF1ZXN0
OjpidWlsZGVyKCkNCj4+ICAgICAgICAgIC53aXRoX2ZvdW5kX2xpbmUoJmxlZDApDQo+PiAgICAg
ICAgICAuYXNfb3V0cHV0KFZhbHVlOjpBY3RpdmUpDQo+PiAgICAgICAgICAucmVxdWVzdCgpPzsN
Cj4+DQo+IEkgd291bGQgYXJndWUgdGhhdCBleGlzdGluZyBoaWdoLWxldmVsIGJpbmRpbmdzIGZv
ciBtYWlubGluZSBsaWJncGlvZA0KPiAoQysrIGFuZCBQeXRob24pIGFsbG93IHNpbWlsYXIgZnVu
Y3Rpb25hbGl0eSBpbiBhIGNvbXBhcmFibGUgbnVtYmVyIG9mDQo+IExPQy4gT24gdGhlIG90aGVy
IGhhbmQgLSBjb3JlIEMgbGlicmFyeSBzaG91bGQgcmVtYWluIHJlbGF0aXZlbHkNCj4gc2ltcGxl
IGFuZCBsaW1pdGVkIGluIGZlYXR1cmVzLg0KPg0KPiBDaHJpczogYXJlIHlvdSBmb3JjZWQgdG8g
dXNlIEMgb3IgY291bGQgeW91IHVzZSBDKysgZm9yIGxpbmUgbG9va3VwDQo+IGFuZCBtYW5hZ2Vt
ZW50Pw0KDQpXZSdyZSB0YWxraW5nIGVtYmVkZGVkIGRldmljZXMgc28gdGhlIG1ham9yaXR5IG9m
IHN0dWZmIGlzIHdyaXR0ZW4gaW4gQy4gDQpDKysgaXMgYXZhaWxhYmxlIGJ1dCB3ZSdkIG5lZWQg
dG8gaW50ZXJmYWNlIGZyb20gYW4gZXhpc3RpbmcgYXBwbGljYXRpb24gDQp3cml0dGVuIGluIEMu
IFB5dGhvbi9SdXN0IGFyZSBwcm9iYWJseSBvdXQgZm9yIHRoZSB0aW1lIGJlaW5nIChSdXN0IA0K
cHJvYmFibHkgd2lsbCBoYXBwZW4gZXZlbnR1YWxseSkuDQoNCj4gSSdtIGFsc28gaW4gdGhlIHBy
b2Nlc3Mgb2YgZGVzaWduaW5nIHRoZSBEQnVzIEFQSSBhbmQgdGhlIGJhc2UgZm9yIGl0DQo+IHdp
bGwgYmUgR0xpYi9HT2JqZWN0IGJpbmRpbmdzIGZvciB0aGUgY29yZSBDIGxpYi4gTWF5YmUgdGhp
cyBpcyB0aGUNCj4gcGxhY2Ugd2hlcmUgd2UgY291bGQgcGxhY2UgbW9yZSBhZHZhbmNlZCBmZWF0
dXJlcyBpbiBDIGFzIEdMaWIgYWxyZWFkeQ0KPiBtYWtlcyBDIGNvZGluZyBzbyBtdWNoIGVhc2ll
ci4NCg0KVGhhdCdkIHdvcmsgdG9vLiBXZSBhbHJlYWR5IHVzZSBHTGliIHF1aXRlIGEgbG90Lg0K
DQo+IEJhcnQNCj4NCj4+ICAgICAgLy8gY2hhbmdlIHZhbHVlIGxhdGVyDQo+PiAgICAgIHJlcS5z
ZXRfdmFsdWUobGVkMC5vZmZzZXQsIFZhbHVlOjpJbmFjdGl2ZSkNCj4+DQo+PiB3aGljaCBpcyB0
aGUgZXF1aXZhbGVudCBvZiB0aGUgc3lzZnMNCj4+DQo+PiBlY2hvIDEgPiAvc29tZS9zeXNmcy9s
aW5lDQo+PiAuLi4NCj4+IGVjaG8gMCA+IC9zb21lL3N5c2ZzL2xpbmUNCj4+DQo+PiBUaGF0IGlz
IGJhZCBlbm91Z2guIEl0IHBhaW5zIG1lIHRvIHNlZSBob3cgY29tcGxleCB0aGUgZXF1aXZhbGVu
dCBpcyB1c2luZw0KPj4gdGhlIGxpYmdwaW9kIHYyIEFQSSAob3IgdjEpLCBhbmQgdGhhdCBpcyBu
b3QgcHV0dGluZyBhbnkgc2hhZGUgb24gQmFydCBvcg0KPj4gYW55b25lIGVsc2Ugd2hvIHdvcmtl
ZCBvbiBpdCAtIHRoZXJlIGFyZSBhIGxvdCBvZiBjb25zdHJhaW50cyBvbiBob3cgaXQNCj4+IGlz
IGRlc2lnbmVkLiAgSXQganVzdCBkb2Vzbid0IGZlZWwgY29tcGxldGUgeWV0LCBwYXJ0aWN1bGFy
bHkgZnJvbSBhDQo+PiBjYXN1YWwgdXNlcidzIHBlcnNwZWN0aXZlLg0KPj4NCj4+IE9uZSBvZiB0
aGUgdGhpbmdzIEkgd291bGQgbGlrZSB0byBzZWUgYWRkZWQgdG8gbGliZ3Bpb2QgaXMgYSBzZXQg
b2Ygd29ya2luZw0KPj4gZXhhbXBsZXMgb2Ygc2ltcGxlIHVzZSBjYXNlcy4gIEZvcm1lcmx5IHRo
ZSB0b29scyB0b29rIGRvdWJsZSBkdXR5IHRvDQo+PiBmaWxsIHRoYXQgcm9sZSwgYnV0IHRoZXkn
dmUgbm93IGdyb3duIHRvbyBjb21wbGV4Lg0KPj4gVGhvc2UgZXhhbXBsZXMgd291bGQgaGlnaGxp
Z2h0IHdoZXJlIHdlIGNvdWxkIHByb3ZpZGUgc2ltcGxpZmllZA0KPj4gaGlnaGVyIGxldmVsIEFQ
SXMuDQo+PiBUaGVuIHJpbnNlIGFuZCByZXBlYXQgdW50aWwgdGhlIHNpbXBsZSB1c2UgY2FzZXMg
YXJlIHNpbXBsZS4NCj4+DQo+Pj4+Pj4+IEknbSBzdXJlIGJvdGggb2YgdGhlc2UgYXBwbGljYXRp
b25zIGNvdWxkIGJlIHJlLXdyaXR0ZW4gYXJvdW5kIGxpYmdwaW9kDQo+Pj4+Pj4+IGJ1dCB0aGF0
IHdvdWxkIGluY3VyIGEgc2lnbmlmaWNhbnQgYW1vdW50IG9mIHJlZ3Jlc3Npb24gdGVzdGluZyBv
bg0KPj4+Pj4+PiBleGlzdGluZyBwbGF0Zm9ybXMuIEFuZCBJIHN0aWxsIGNvbnNpZGVyIGRlYWxp
bmcgd2l0aCBHUElPIGNoaXBzIGFuDQo+Pj4+Pj4+IGV4dHJhIGhlYWRhY2hlIHRoYXQgdGhlIGFw
cGxpY2F0aW9ucyBkb24ndCBuZWVkIChwYXJ0aWN1bGFybHkgd2l0aCB0aGUNCj4+Pj4+Pj4gc2hl
ZXIgbnVtYmVyIG9mIHRoZW0gdGhlIFNGUCBjYXNlKS4NCj4+Pj4+PiBJdCBzZWVtcyB0byBtZSB0
aGF0IGhhdmluZyBubyBpbi1rZXJuZWwgZHJpdmVyIGZvciB5b3VyIHN0dWZmIGlzIHRoZQ0KPj4+
Pj4+IG1haW4gcG9pbnQgb2YgYWxsIGhlYWRhY2hlIGhlcmUuIEJ1dCBJIG1pZ2h0IGJlIG1pc3Rh
a2VuLg0KPj4+Pj4gSXQgY2VydGFpbmx5IGRvZXNuJ3QgaGVscCwgYnV0IEkgZG8gdGhpbmsgdGhh
dCBpcyBhbGwgb3J0aG9nb25hbCB0byB0aGUNCj4+Pj4+IGZhY3QgdGhhdCBncGlvX2lzX3Zpc2li
bGUoKSBjaGFuZ2VzIHRoaW5ncyByYXRoZXIgdGhhbiBqdXN0IGRldGVybWluaW5nDQo+Pj4+PiBp
ZiBhbiBhdHRyaWJ1dGUgc2hvdWxkIGJlIGV4cG9ydGVkIG9yIG5vdC4NCj4+Pj4gU29ycnkgZm9y
IGJlaW5nIHVuaGVscGZ1bCBoZXJlLiBCdXQgd2l0aG91dCB1bmRlcnN0YW5kaW5nIHRoZSBpc3N1
ZSB3ZSBjYW4ndA0KPj4+PiBwcm9wb3NlIGJldHRlciBzb2x1dGlvbnMuDQo+Pj4gTm8gcHJvYmxl
bSwgdGhpcyBpcyBwcm9iYWJseSB0aGUgbW9zdCBlbmdhZ2VtZW50IEkndmUgaGFkIG91dCBvZiBh
IExpbnV4DQo+Pj4gcGF0Y2ggc3VibWlzc2lvbi4gSG9wZWZ1bGx5IGl0J3Mgbm90IHRvbyBhbm5v
eWluZyBmb3IgdGhvc2Ugb24gdGhlIENjIGxpc3QuDQo+PiBXZWxsLCBub3cgeW91IG1lbnRpb24g
aXQuLi4uDQo+Pg0KPj4gQWxvbmcgdGhlIHNhbWUgbGluZXMgYXMgQW5keSwgaXQgaXMgYWx3YXlz
IHVzZWZ1bCB0byBnZXQgZmVlZGJhY2sgYWJvdXQNCj4+IHByb2JsZW1zIHBlb3BsZSBhcmUgZmFj
aW5nLCBhbmQgaG93IHRoZSBhdmFpbGFibGUgc29sdXRpb25zIGFyZW4ndA0KPj4gd29ya2luZyBm
b3IgdGhlbS4NCj4+IElmIHdlIGRvbid0IGtub3cgdGhlIHByb2JsZW0gZXhpc3RzIHRoZW4gd2Ug
Y2FuJ3QgZml4IGl0IC0gZXhjZXB0IGJ5DQo+PiBhY2NpZGVudC4NCj4+DQo+PiBDaGVlcnMsDQo+
PiBLZW50Lg==
