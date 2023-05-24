Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E067101D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 01:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjEXXxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 19:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjEXXxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 19:53:17 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE1C99
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 16:53:14 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4161E2C02E0;
        Thu, 25 May 2023 11:53:13 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1684972393;
        bh=aZBFDPi6Djr1Z9fNprDllT8CaCwGkXUfyrN/ij0abtg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=X9h4vst3O31GQP4+gnv/vWTL+PUiulzZxWzXWQZckNMLagdTlrjekDkoB0WDk5tQd
         LBV8pJKzspaXnB2Rc99717UeteMvbEAR2aQqKvjD0VfMIEh7ESSb1QGwRy2qZNcmvh
         KxxZd4uGboFEQq9/B2dV0JilUE6d0KmzQ4HMA4R/qyOCWh+WH8VHUZSbakGAn9st03
         hWML25L6QfDJwkyjOEdHlrO6YAHMWfjT0JeC9UvxmHA4DqR2gFTv0Z2Wb7eqvJouDd
         jhdw41ef0WdZZsYElfbLm7c6SDER1telMy8CI7MgXnoOzsHi/3xO7pfW3kSaZQaNe2
         4jU+xHEZOGPXw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B646ea3690001>; Thu, 25 May 2023 11:53:13 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Thu, 25 May 2023 11:53:13 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Thu, 25 May 2023 11:53:12 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Thu, 25 May 2023 11:53:12 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Kent Gibson <warthog618@gmail.com>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: using libgpiod to replace sysfs ABI (was Re: [PATCH] gpiolib: Avoid
 side effects in gpio_is_visible())
Thread-Topic: using libgpiod to replace sysfs ABI (was Re: [PATCH] gpiolib:
 Avoid side effects in gpio_is_visible())
Thread-Index: AQHZjprmqsS+N7nfWEWkADlDhs1wpA==
Date:   Wed, 24 May 2023 23:53:12 +0000
Message-ID: <f9006a57-4c67-c8a0-badc-84b3292aa686@alliedtelesis.co.nz>
References: <ZGzsD_HMbMGhGwcr@surfacebook>
 <72990baf-6964-01ad-d891-7090831d0310@alliedtelesis.co.nz>
 <ZG2jgwjK+CBmOk3G@sol>
In-Reply-To: <ZG2jgwjK+CBmOk3G@sol>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DEA3330C4909344AE981403CE311017@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=pGLkceISAAAA:8 a=go7DDdlL3tKfwstDA4MA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KGN1bGxlZCB0aGUgQ2MgbGlzdCBidXQgaG9wZWZ1bGx5IHRob3NlIHRoYXQgbWlnaHQgd2FudCB0
byBjaGltZSBpbiBhcmUgDQpvbiBsaW51eC1ncGlvKQ0KDQpPbiAyNC8wNS8yMyAxNzo0MSwgS2Vu
dCBHaWJzb24gd3JvdGU6DQo+IE9uIFR1ZSwgTWF5IDIzLCAyMDIzIGF0IDA5OjE3OjI2UE0gKzAw
MDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBPbiAyNC8wNS8yMyAwNDozOCwgYW5keS5zaGV2
Y2hlbmtvQGdtYWlsLmNvbSB3cm90ZToNCj4+PiBXZWQsIE1heSAxNywgMjAyMyBhdCAwOTozMDo1
MVBNICswMDAwLCBDaHJpcyBQYWNraGFtIGtpcmpvaXR0aToNCj4+Pj4gT24gMTcvMDUvMjMgMjA6
NTQsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4+Pj4+IE9uIFdlZCwgTWF5IDE3LCAyMDIzIGF0
IDI6NTDigK9BTSBDaHJpcyBQYWNraGFtDQo+Pj4+PiA8Q2hyaXMuUGFja2hhbUBhbGxpZWR0ZWxl
c2lzLmNvLm56PiB3cm90ZToNCj4+Pj4+PiBPbiAxNy8wNS8yMyAxMDo0NywgS2VudCBHaWJzb24g
d3JvdGU6DQo+Pj4gLi4uDQo+Pj4NCj4+Pj4gQWdhaW4gdGhlIHByb2JsZW0gYm9pbHMgZG93biB0
byB0aGUgZmFjdCB0aGF0IHdlIGhhdmUgYSB1c2Vyc3BhY2Ugc3dpdGNoDQo+Pj4+IGRyaXZlciAo
d2hpY2ggdXNlcyBhIHZlbmRvciBzdXBwbGllZCBub24tZnJlZSBTREspLiBTbyBkZXNwaXRlIHRo
ZQ0KPj4+PiBrZXJuZWwgaGF2aW5nIHF1aXRlIGdvb2Qgc3VwcG9ydCBmb3IgU0ZQcyBJIGNhbid0
IHVzZSBpdCB3aXRob3V0IGENCj4+Pj4gbmV0ZGV2IHRvIGF0dGFjaCBpdCB0by4NCj4+PiBUaGF0
IHVzZXIgc3BhY2UgZHJpdmVyIGlzIHVzaW5nIHdoYXQgZnJvbSB0aGUga2VybmVsPyBHUElPIHN5
c2ZzPw0KPj4gWWVzIEdQSU8gc3lzZnMgYW5kIGV4cG9ydGVkIGxpbmtzIHdpdGgga25vd24gbmFt
ZXMsIHdoaWNoIGFsbG93cyB0aGluZ3MNCj4+IHRvIGJlIGRvbmUgcGVyLXBvcnQgYnV0IGFsc28g
d2lsZGNhcmRlZCBmcm9tIHNoZWxsIHNjcmlwdHMgaWYgbmVjZXNzYXJ5Lg0KPj4gSSB0aGluayB0
aGUga2V5IHBvaW50IGhlcmUgaXMgdGhhdCBpdCBkb2Vzbid0IGNhcmUgYWJvdXQgdGhlIEdQSU8g
Y2hpcHMNCj4+IGp1c3QgdGhlIGluZGl2aWR1YWwgR1BJTyBsaW5lcy4gQW55dGhpbmcgaW52b2x2
aW5nIGxpYmdwaW9kIGN1cnJlbnRseQ0KPj4gaGFzIHRvIHN0YXJ0IGNhcmluZyBhYm91dCBHUElP
IGNoaXBzIChvciBJJ20gbWlzcmVhZGluZyB0aGUgZG9jcykuDQo+Pg0KPiBBcyBwcmV2aW91c2x5
IG1lbnRpb25lZCwgdGhlIGxpYmdwaW9kIHRvb2xzIG5vdyBzdXBwb3J0IGlkZW50aWZpY2F0aW9u
IG9mDQo+IGxpbmVzIGJ5IG5hbWUuDQoNClRoZSBsaWJncGlvZCB0b29scyBkbyBidXQgbm90IGxp
YmdwaW9kIGl0c2VsZi4gVGhlIHRvb2xzIGFyZSByZWFzb25hYmxlIA0KcmVwbGFjZW1lbnRzIGZv
ciB0aGluZ3MgdGhhdCBhcmUgY3VycmVudGx5IGRvbmUgaW4gc2hlbGwgc2NyaXB0cyBidXQgDQp0
aGVyZSBpcyBhbHNvIGFwcGxpY2F0aW9uIGNvZGUgdGhhdCBuZWVkcyB0byBjYXJlIGFib3V0IEdQ
SU8gbGluZXMgYnV0IA0KaWRlYWxseSBpdCBzaG91bGRuJ3QgbmVlZCB0byBjYXJlIGFib3V0IEdQ
SU8gY2hpcHMuDQoNCj4gQXMgbG9uZyBhcyB5b3VyIGxpbmUgbmFtZXMgYXJlIHVuaXF1ZSBhdCBz
eXN0ZW0gc2NvcGUgeW91IHNob3VsZCBiZQ0KPiBnb29kLiAgT3RoZXJ3aXNlIHlvdSBoYXZlIG5v
IG9wdGlvbiBidXQgdG8gaWRlbnRpZnkgYnkgKGNoaXAsb2Zmc2V0KS4NCj4NCj4gV3J0IHRoZSBs
aWJyYXJ5IGl0c2VsZiwgSSB3YXMgdGhpbmtpbmcgYWJvdXQgcmVsb2NhdGluZyB0aGUgbGluZSBu
YW1lDQo+IHJlc29sdXRpb24gbG9naWMgZnJvbSB0aGUgdG9vbHMgaW50byB0aGUgbGlicmFyeSBp
dHNlbGYsIHNvIGl0IHdvdWxkIGJlDQo+IG1vcmUgZ2VuZXJhbGx5IGFjY2Vzc2libGUsIGJ1dCBo
YXZlbid0IGdvdHRlbiB0aGVyZSB5ZXQuDQoNClllcyBJIHRoaW5rIHRoYXQnZCBoZWxwIG15IHVz
ZS1jYXNlLiBFdmVuIGlmIHRoZXJlIHdlcmUgQVBJcyB0byBpdGVyYXRlIA0Kb3ZlciBhbGwgcG9z
c2libGUgR1BJTyBsaW5lcyBhbmQgbGV0IHRoZSBhcHBsaWNhdGlvbiB3b3JyeSBhYm91dCBob3cg
dG8gDQptYXRjaCB0aGUgbmFtZXMuDQoNCj4gSSdtIGFsc28gb2YgdGhlIG9waW5pb24gdGhhdCBs
aWJncGlvZCBpcyB0b28gbG93IGxldmVsIGZvciBjb21tb24NCj4gdGFza3MuICBUaGF0IGlzIG5l
Y2Vzc2FyeSB0byBhY2Nlc3MgYWxsIHRoZSBmZWF0dXJlcyBvZiB0aGUgdUFQSSwgYnV0DQo+IGZv
ciBiYXNpYyB0YXNrcyBpdCB3b3VsZCBiZSBuaWNlIHRvIGhhdmUgYSBoaWdoZXIgbGV2ZWwgYWJz
dHJhY3Rpb24gdG8NCj4gcmVkdWNlIHRoZSBiYXJyaWVyIHRvIGVudHJ5Lg0KPg0KPiBlLmcuIGlu
IFJ1c3QgSSBjYW4gZG8gdGhpczoNCj4NCj4gICAgICBsZXQgbGVkMCA9IGdwaW9jZGV2OjpmaW5k
X25hbWVkX2xpbmUoIkxFRDAiKS51bndyYXAoKTsNCj4gICAgICBsZXQgcmVxID0gUmVxdWVzdDo6
YnVpbGRlcigpDQo+ICAgICAgICAgIC53aXRoX2ZvdW5kX2xpbmUoJmxlZDApDQo+ICAgICAgICAg
IC5hc19vdXRwdXQoVmFsdWU6OkFjdGl2ZSkNCj4gICAgICAgICAgLnJlcXVlc3QoKT87DQo+DQo+
ICAgICAgLy8gY2hhbmdlIHZhbHVlIGxhdGVyDQo+ICAgICAgcmVxLnNldF92YWx1ZShsZWQwLm9m
ZnNldCwgVmFsdWU6OkluYWN0aXZlKQ0KPg0KPiB3aGljaCBpcyB0aGUgZXF1aXZhbGVudCBvZiB0
aGUgc3lzZnMNCj4NCj4gZWNobyAxID4gL3NvbWUvc3lzZnMvbGluZQ0KPiAuLi4NCj4gZWNobyAw
ID4gL3NvbWUvc3lzZnMvbGluZQ0KPg0KPiBUaGF0IGlzIGJhZCBlbm91Z2guIEl0IHBhaW5zIG1l
IHRvIHNlZSBob3cgY29tcGxleCB0aGUgZXF1aXZhbGVudCBpcyB1c2luZw0KPiB0aGUgbGliZ3Bp
b2QgdjIgQVBJIChvciB2MSksIGFuZCB0aGF0IGlzIG5vdCBwdXR0aW5nIGFueSBzaGFkZSBvbiBC
YXJ0IG9yDQo+IGFueW9uZSBlbHNlIHdobyB3b3JrZWQgb24gaXQgLSB0aGVyZSBhcmUgYSBsb3Qg
b2YgY29uc3RyYWludHMgb24gaG93IGl0DQo+IGlzIGRlc2lnbmVkLiAgSXQganVzdCBkb2Vzbid0
IGZlZWwgY29tcGxldGUgeWV0LCBwYXJ0aWN1bGFybHkgZnJvbSBhDQo+IGNhc3VhbCB1c2VyJ3Mg
cGVyc3BlY3RpdmUuDQo+DQo+IE9uZSBvZiB0aGUgdGhpbmdzIEkgd291bGQgbGlrZSB0byBzZWUg
YWRkZWQgdG8gbGliZ3Bpb2QgaXMgYSBzZXQgb2Ygd29ya2luZw0KPiBleGFtcGxlcyBvZiBzaW1w
bGUgdXNlIGNhc2VzLiAgRm9ybWVybHkgdGhlIHRvb2xzIHRvb2sgZG91YmxlIGR1dHkgdG8NCj4g
ZmlsbCB0aGF0IHJvbGUsIGJ1dCB0aGV5J3ZlIG5vdyBncm93biB0b28gY29tcGxleC4NCj4gVGhv
c2UgZXhhbXBsZXMgd291bGQgaGlnaGxpZ2h0IHdoZXJlIHdlIGNvdWxkIHByb3ZpZGUgc2ltcGxp
ZmllZA0KPiBoaWdoZXIgbGV2ZWwgQVBJcy4NCj4gVGhlbiByaW5zZSBhbmQgcmVwZWF0IHVudGls
IHRoZSBzaW1wbGUgdXNlIGNhc2VzIGFyZSBzaW1wbGUuDQoNCkkgd2FzIGEgbGl0dGxlIHB1dC1v
ZmYgd2hlbiBJIG5vdGljZWQgdGhlcmUgd2FzIGFuIGxvb21pbmcgQVBJIGNoYW5nZSANCnRoZSBs
YXN0IHRpbWUgSSBsb29rZWQgYXQgbGliZ3Bpb2QgYW5kIHVuZm9ydHVuYXRlbHkgYW55IHRpbWUg
SSBoYWQgdG8gDQpzcGVuZCBvbiB1cGRhdGluZyB0aGUgYXBwbGljYXRpb24gY29kZSBoYXMgbm93
IHBhc3NlZC4NCg0KSSB0aGluayBtb2R1bG8gdGhlIHByb2JsZW0gb2YgbGluZSBkaXNjb3Zlcnkg
dGhlIGN1cnJlbnQgQVBJIHdvdWxkIGRvIA0Kd2hhdCBJIG5lZWQuIEFzIHlvdSd2ZSBzYWlkIGhh
dmluZyBzb21lIGV4YW1wbGVzIGluIHRoZSBkb2NzIHdvdWxkIGdvIGEgDQpsb25nIHdheS4NCg0K
SXQnZCBhbHNvIGJlIGdyZWF0IGlmIHRoZXJlIHdhcyBzb21lIHdheSBvZiBlbnN1cmluZyB0aGF0
IGEgbGluZSdzIHN0YXRlIA0KaXMga2VwdCBhZnRlciB0aGUgYXBwbGljYXRpb24gaGFzIHJlbGVh
c2VkIHRoZSByZXF1ZXN0IChpLmUuIHRoZSB0eGRpcyANCmNhc2UgSSBtZW50aW9uZWQpLiBCdXQg
dGhhdCBwcm9iYWJseSBuZWVkcyB3b3JrIG9uIHRoZSBrZXJuZWwgc2lkZSB0byANCm1ha2Ugc3Vj
aCBndWFyYW50ZWVzLg0K
