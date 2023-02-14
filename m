Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFD46970CC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjBNWhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjBNWg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:36:58 -0500
X-Greylist: delayed 7724 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Feb 2023 14:36:54 PST
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D141B2F7B9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:36:54 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F2D6D2C049F;
        Wed, 15 Feb 2023 11:36:51 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1676414211;
        bh=cyDTL/yYDuqCMGb1II30ndoGbPuz+1qrXx6xn9H+EoU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=bYFpDGLzLZIkgkVR+s0EQFhtgEG3NKIAt5CpBBYwxNP/4OjpiKrAnH1N50xE8kDF+
         WWLDl5XtUA2yNtZ6Ha7/UqwEqcYCZS/f0CbfLLz20rciXa4r+K3dAyiZ3r+gY4L2eA
         xksK5CrdbW9YWKW+lYyFg2/sjeb2r1NeeuWGVnry34JE/eYrhANd0+LO7Dj2a16Tcx
         1ja/8Qu/ZrO7h2UzM6wWd6nUxCQFq+W9/+AeFcUE6LmO6ENOVjbw6Rx2IwoG8n3pA5
         V+mOfckKhSxXF7CIfXsotWLNBJ6Y1keGxTIfEnFMqiAnrCHprMOZu+765vesdxyxHI
         7pTtraI0SmdVA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B63ec0d030002>; Wed, 15 Feb 2023 11:36:51 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.45; Wed, 15 Feb 2023 11:36:51 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.045; Wed, 15 Feb 2023 11:36:51 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v3 1/2] drivers: rtc: add max313xx series rtc driver
Thread-Topic: [PATCH v3 1/2] drivers: rtc: add max313xx series rtc driver
Thread-Index: AQHZQLLY3ijYBbo43E6McZa87qvtIa7OHnUAgAAP3wA=
Date:   Tue, 14 Feb 2023 22:36:51 +0000
Message-ID: <8ffabc0d-73ca-27c6-5244-95e29901c60a@alliedtelesis.co.nz>
References: <20221108122254.1185-1-Ibrahim.Tilki@analog.com>
 <20221108122254.1185-2-Ibrahim.Tilki@analog.com>
 <68ddb833-f38e-a05b-82c4-ce12330410a5@alliedtelesis.co.nz>
 <Y+v/suob0EN1REX4@mail.local>
In-Reply-To: <Y+v/suob0EN1REX4@mail.local>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5D9E7D68209B645A1B54DA70F7B870B@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=U+ns8tju c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=m04uMKEZRckA:10 a=gAnH3GRIAAAA:8 a=_pSrP_Kwfl6zvDA_82YA:9 a=QEXdDO2ut3YA:10 a=oVHKYsEdi7-vN-J5QA_j:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxNS8wMi8yMyAxMDo0MCwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IE9uIDE0LzAy
LzIwMjMgMjA6Mjg6MDUrMDAwMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+IEhpIElicmFoaW0s
DQo+Pg0KPj4gT24gOS8xMS8yMiAwMToyMiwgSWJyYWhpbSBUaWxraSB3cm90ZToNCj4+PiBBZGRp
bmcgc3VwcG9ydCBmb3IgQW5hbG9nIERldmljZXMgTUFYMzEzWFggc2VyaWVzIFJUQ3MuDQo+Pj4N
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBJYnJhaGltIFRpbGtpIDxJYnJhaGltLlRpbGtpQGFuYWxvZy5j
b20+DQo+Pj4gU2lnbmVkLW9mZi1ieTogWmV5bmVwIEFyc2xhbmJlbnplciA8WmV5bmVwLkFyc2xh
bmJlbnplckBhbmFsb2cuY29tPg0KPj4+IC0tLQ0KPj4+ICAgIGRyaXZlcnMvcnRjL0tjb25maWcg
ICAgICAgIHwgICAxMSArDQo+Pj4gICAgZHJpdmVycy9ydGMvTWFrZWZpbGUgICAgICAgfCAgICAx
ICsNCj4+PiAgICBkcml2ZXJzL3J0Yy9ydGMtbWF4MzEzeHguYyB8IDEwNzAgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4gICAgMyBmaWxlcyBjaGFuZ2VkLCAxMDgyIGlu
c2VydGlvbnMoKykNCj4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ydGMvcnRjLW1h
eDMxM3h4LmMNCj4+IFdoYXQgaXMgdGhlIGN1cnJlbnQgc3RhdGUgb2YgdGhpcyB3b3JrPyBJIHNl
ZSB0aGVyZSBhcmUgc29tZSBjb21tZW50cyBvbg0KPj4gdGhpcyB2MyBpdGVyYXRpb24gZnJvbSBs
YXRlIGxhc3QgeWVhciBhbmQgSSBjb3VsZG4ndCBmaW5kIGFueSBuZXdlcg0KPj4gaXRlcmF0aW9u
IG9uIGFueSBtYWlsaW5nIGxpc3QuIFdlJ3ZlIGdvdCBzb21lIG5ldyBoYXJkd2FyZSBhcnJpdmlu
ZyBzb29uDQo+PiB0aGF0IHdpbGwgaGF2ZSB0aGUgTUFYMzEzMzEgUlRDIGFuZCBJJ20ga2VlbiB0
byBzZWUgdGhpcyBwYXRjaCBzZXJpZXMNCj4+IGxhbmQuIElzIHRoZXJlIGFueXRoaW5nIEkgY2Fu
IGRvIHRvIGhlbHAgaXQgYWxvbmc/IEkgY2FuJ3QgYmUgdmVyeQ0KPj4gc3BlY2lmaWMgYWJvdXQg
d2hlbiBJJ2xsIHNlZSB0aGUgbmV3IGhhcmR3YXJlICh3aG8gY2FuIHRoZXNlIGRheXMpLCB0aGUN
Cj4+IGxhc3QgdXBkYXRlIHdhcyAiYm9hcmRzIGFyZSBkdWUgaW4gTWFyY2giLg0KPj4NCj4+IEZv
ciB0aGUgbWFpbnRhaW5lcnMgb24gdGhlIENjIGxpc3Qgb25jZSB0aGUgZHVzdCBzZXR0bGVzIGhv
dyB3b3VsZCBJIGdldA0KPj4gdGhpcyBzdXBwb3J0ZWQgaW4gYSBMVFMga2VybmVsICh3ZSdyZSBj
dXJyZW50bHkgdXNpbmcgdGhlIDUuMTUgc2VyaWVzKT8NCj4+IE9yIGlzIHRvdGFsbHkgb3V0IG9m
IHRoZSBxdWVzdGlvbiBiZWNhdXNlIGl0J3Mgbm90IGp1c3QgYSBuZXcgZGV2aWNlIGlkPw0KPiBU
aGlzIHdpbGwgbm90IGhhcHBlbiwgeW91IHdpbGwgaGF2ZSB0byB1cGRhdGUgdG8gdGhlIG5leHQg
TFRTICh3aGljaCB5b3UNCj4gc2hvdWxkIGRvIGFueXdheSkNCkkgd2FzIGFmcmFpZCB0aGF0IHdh
cyBnb2luZyB0byBiZSB0aGUgYW5zd2VyLiBXZSdsbCBoYXZlIHRvIGNhcnJ5IGl0IGFzIA0KYSBs
b2NhbCBwYXRjaCB1bnRpbCB0aGVyZSBpcyBhIExUUyB2ZXJzaW9uIHdpdGggdGhlIGRyaXZlciBz
dXBwb3J0IHdlIA0KbmVlZCBpbiBpdC4=
