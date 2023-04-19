Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B869D6E82DE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjDSUtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDSUtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:49:12 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B106E59F0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 13:49:09 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A58342C086F;
        Thu, 20 Apr 2023 08:49:07 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1681937347;
        bh=5QLbHzZbmoF6XA59JsTipch5kBSEti+i3vdZmvqNkG8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=hzm8d69Aa4FkTvr6Wi97FdYRmmBRbPPZdnn/OZ82N5OY0n/XlhxQZ5dhKP+bIite0
         LxXXSqNI3ZqRwTJ7UN3eZCPsCGmdayDxGsAOfBM6mo65iZ7VbvebaM1k5BLgp3/74D
         jGIyHu0tW5pESKhd8TB9mEhqOitxvCCspVchbrFD13kjjdbgFN0AV7P+LQ+SG2l22f
         u8V9WpfmwKMScx+otnEaK9JGpSDXegQyrMDROlJEz6VVmjXQHF0aZl6iSkwdhJn3yG
         Hwved8F4Sb6RnwrECfmhaqpDYZTm6QdRLlN8ntw1IvhNN3Twu5AvFuNMqJSO0CbwjK
         yr49p67iGaLyg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B644053c30002>; Thu, 20 Apr 2023 08:49:07 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Thu, 20 Apr 2023 08:49:07 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Thu, 20 Apr 2023 08:49:07 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Thu, 20 Apr 2023 08:49:07 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "manio@skyboo.net" <manio@skyboo.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] hwmon: (adt7475) Convert to use device_property
 APIs
Thread-Topic: [PATCH v2 2/2] hwmon: (adt7475) Convert to use device_property
 APIs
Thread-Index: AQHZck6xRuzquzHgrUGfwiTzPsRMfq8yA+2AgABPDgA=
Date:   Wed, 19 Apr 2023 20:49:07 +0000
Message-ID: <9ad2433a-676f-0a90-809c-f256d2b9ba79@alliedtelesis.co.nz>
References: <20230418233656.869055-1-chris.packham@alliedtelesis.co.nz>
 <20230418233656.869055-3-chris.packham@alliedtelesis.co.nz>
 <4d78b62f-1592-45d9-874a-30f1906cd2d3@roeck-us.net>
In-Reply-To: <4d78b62f-1592-45d9-874a-30f1906cd2d3@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA1D1EFD1A4E554DBCA2A90BE6D72833@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=VfuJw2h9 c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=dKHAf1wccvYA:10 a=A0rPyryzaggc0u45cKAA:9 a=QEXdDO2ut3YA:10
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

DQpPbiAyMC8wNC8yMyAwNDowNiwgR3VlbnRlciBSb2VjayB3cm90ZToNCj4gT24gV2VkLCBBcHIg
MTksIDIwMjMgYXQgMTE6MzY6NTZBTSArMTIwMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+IElu
c3RlYWQgb2Ygb2ZfcHJvcGVydHlfcmVhZF8qKCkgdXNlIHRoZSBlcXVpdmFsZW50DQo+PiBkZXZp
Y2VfcHJvcGVydHlfcmVhZF8qKCkgQVBJLiBUaGlzIHdpbGwgYWxsb3cgdGhlc2UgcHJvcGVydGll
cyB0byBiZQ0KPj4gdXNlZCBvbiBEVCB1bmF3YXJlIHBsYXRmb3Jtcy4gRm9yIERUIGF3YXJlIHBs
YXRmb3JtcyB0aGlzIHdpbGwgYmUgYQ0KPj4gbm9vcC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBD
aHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+PiAtLS0N
Cj4+DQo+PiBOb3RlczoNCj4+ICAgICAgVGhpcyBpcyBhbiBhZGRpdGlvbmFsIHVwZGF0ZSBmb3Ig
bWFzdGVyIGZyb20gdGhlIHByZWNlZWRpbmcgYnVnZml4DQo+PiAgICAgIGNvbW1pdC4gSSd2ZSBu
b3QgYWRkZWQgYSBmaXhlcyB0YWcgZm9yIHRoaXMgb25lIGJlY2F1c2UgSSBkb24ndCB0aGluaw0K
Pj4gICAgICB0aGVyZSB3aWxsIGJlIGEgYmVoYXZpb3VyIGNoYW5nZSBmb3IgZXhpc3RpbmcgdXNh
Z2VzLg0KPj4gICAgICANCj4+ICAgICAgSSBrbm93IHdlIGhhdmUgb25lIHVwY29taW5nIERUIHVu
YXdhcmUgcGxhdGZvcm0gdGhhdCB3ZSBtYXkgd2FudCB0byB1c2UNCj4+ICAgICAgc29tZSBvZiB0
aGVzZSBwcm9wZXJ0aWVzIHZpYSBBQ1BJIHRhYmxlcyBzbyBJIHdvbid0IG9iamVjdCBpZiB0aGlz
IGVuZHMNCj4+ICAgICAgdXAgb24gdGhlIHN0YWJsZSB0cmFjayBidXQgSSBkb24ndCB0aGluayBp
dCBtZWV0cyB0aGUgY3JpdGVyaWEgZm9yDQo+PiAgICAgIHN0YWJsZS4NCj4+DQo+PiAgIGRyaXZl
cnMvaHdtb24vYWR0NzQ3NS5jIHwgOCArKysrLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2h3bW9uL2FkdDc0NzUuYyBiL2RyaXZlcnMvaHdtb24vYWR0NzQ3NS5jDQo+PiBpbmRleCA2YTZl
YmNjODk2YjEuLjNiOTI4OWJjNTk5NyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvaHdtb24vYWR0
NzQ3NS5jDQo+PiArKysgYi9kcml2ZXJzL2h3bW9uL2FkdDc0NzUuYw0KPj4gQEAgLTE0NjgsNyAr
MTQ2OCw3IEBAIHN0YXRpYyBpbnQgbG9hZF9jb25maWczKGNvbnN0IHN0cnVjdCBpMmNfY2xpZW50
ICpjbGllbnQsIGNvbnN0IGNoYXIgKnByb3BuYW1lKQ0KPj4gICAJdTggY29uZmlnMzsNCj4+ICAg
CWludCByZXQ7DQo+PiAgIA0KPj4gLQlyZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3N0cmluZyhjbGll
bnQtPmRldi5vZl9ub2RlLCBwcm9wbmFtZSwgJmZ1bmN0aW9uKTsNCj4+ICsJcmV0ID0gZGV2aWNl
X3Byb3BlcnR5X3JlYWRfc3RyaW5nKCZjbGllbnQtPmRldiwgcHJvcG5hbWUsICZmdW5jdGlvbik7
DQo+IFVuZm9ydHVuYXRlbHkgdGhhdCBpcyBhIHByb2JsZW0gYmVjYXVzZSB0aGUgcGFyYW1ldGVy
IHBhc3NlZCB0bw0KPiBsb2FkX2NvbmZpZzMgaXMgYSBwb2ludGVyIHRvIGEgY29uc3QgZGF0YSBz
dHJ1Y3R1cmUgYW5kDQo+IGRldmljZV9wcm9wZXJ0eV9yZWFkX3N0cmluZyBkb2Vzbid0IGxpa2Ug
dGhhdCAoYWZhaWNzIGZvcg0KPiBubyBnb29kIHJlYXNvbikuIFlvdSdsbCBhbHNvIGhhdmUgdG8g
Y2hhbmdlIHRoZSBjbGllbnQgcGFyYW1ldGVyDQo+IHRvIGxvYWRfY29uZmlnKCkgYW5kIGZyaWVu
ZHMgdG8gbm90IGJlIGNvbnN0Lg0KDQpOb3Qgc3VyZSBob3cgSSBkaWRuJ3Qgbm90aWNlIHRoYXQu
IFByb2JhYmx5IHJ1c2hpbmcgdG8gZ2V0IHRoZSBmaXggcGFydCBvdXQuDQoNCkkgZG8gaGF2ZSBh
IHYzIHRoYXQgZHJvcHMgdGhlIGNvbnN0IHdoZXJlIG5lZWRlZCB0byBzaWxlbmNlIHRoZSB3YXJu
aW5ncyANCmJ1dCBJJ2xsIHNpdCBvbiB0aGF0IGZvciBub3cgaW4gdGhlIGhvcGUgdGhhdCB5b3Vy
IHBhdGNoIGdldHMgYWNjZXB0ZWQuDQoNCj4gR3VlbnRlcg==
