Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDB26A126A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjBWV5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBWV5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:57:44 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A90196A6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 13:57:42 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F15B72C0650;
        Fri, 24 Feb 2023 10:57:38 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1677189458;
        bh=NanjMPGPESIK+CNTa6AmGEKImCFQUu+FEQ970rFagjo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ymvdG4C3DtwEv4djMLJcFVdG3lw4LkZPZ96ImHG1kuiiOFNh7wFHNbnAwzu17QWKF
         3wRZBtuLxo6Lw6sq8mKF5giUAxC8eiFgSLkgVoAaa/9SlVQUbmRDxYuX3rJ3mAKi7n
         zKtnMuOiDQIm7E+HItLYoZAeTmP1HF3/FuHTKr4Mw4hTiGpoSXzyPn6XnHm244x2jv
         o06mzVfjNLZgoezUe0HlK4qY8EmcWt0RZ1pNcP+4Y6HrtnhQzQ4daR9SKBxNTorb4S
         mg882G0fEa5ZmEjA0cAwiTUWVGvezMAyEdIJTcTqiT2E/+a86EqYpQcrOV1wzrpCya
         Ww78x0JLV3gcA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B63f7e1520001>; Fri, 24 Feb 2023 10:57:38 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.47; Fri, 24 Feb 2023 10:57:38 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.047; Fri, 24 Feb 2023 10:57:38 +1300
From:   Tony O'Brien <Tony.OBrien@alliedtelesis.co.nz>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "jordan.crouse@amd.com" <jordan.crouse@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] hwmon: (adt7475) Fix setting of hysteresis registers
Thread-Topic: [PATCH 2/2] hwmon: (adt7475) Fix setting of hysteresis registers
Thread-Index: AQHZRTTMlkXNzCAiSUmyuIMWTHJwBq7Yy+0AgANzawA=
Date:   Thu, 23 Feb 2023 21:57:38 +0000
Message-ID: <57d90678-4d1f-2aa7-aca2-6218894a91c6@alliedtelesis.co.nz>
References: <20230219232956.23784-1-tony.obrien@alliedtelesis.co.nz>
 <20230219232956.23784-3-tony.obrien@alliedtelesis.co.nz>
 <20230220140826.GA4009286@roeck-us.net>
 <628cd274-38a2-fd67-3cea-eef5837f58a5@roeck-us.net>
In-Reply-To: <628cd274-38a2-fd67-3cea-eef5837f58a5@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9A39EC6D03D334EA3B05A781A495635@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=GdlpYjfL c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=m04uMKEZRckA:10 a=1cIUIJCp_7cGnt0_jAgA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIvMDIvMjMgMDY6MTUsIEd1ZW50ZXIgUm9lY2sgd3JvdGU6DQo+IE9uIDIvMjAvMjMgMDY6
MDgsIEd1ZW50ZXIgUm9lY2sgd3JvdGU6DQo+PiBPbiBNb24sIEZlYiAyMCwgMjAyMyBhdCAxMjoy
OTo1NlBNICsxMzAwLCBUb255IE8nQnJpZW4gd3JvdGU6DQo+Pj4gSW4gdGVtcF9zdG9yZSgpLCBm
b3IgdGhlIGh5c3RlcmVzaXMgc2V0dGluZyBjYWxjdWxhdGlvbiB0aGVyZSB3ZXJlIHR3bw0KPj4+
IGVycm9ycy7CoCBUaGUgZmlyc3QgdHJpZXMgdG8gY2xhbXAgdGhlIGh5c3RlcmVzaXMgdmFsdWUg
YnkgY29tcGFyaW5nIHRoZQ0KPj4+IHJlcXVpcmVkIGh5c3RlcmVzaXMgdmFsdWUgdG8gVEhFUk0g
LSAxNUMuwqAgVGhpcyBpcyBpbmNvcnJlY3Qgc2luY2UgdGhlDQo+Pj4gaHlzdGVyZXNpcyB2YWx1
ZSBpcyBhIHJlbGF0aXZlIHZhbHVlIHdoZXJlYXMgVEhFUk0gLSAxNUMgaXMgYW4gYWJzb2x1dGUN
Cj4+DQo+PiBObywgaXQgaXNuJ3QuIFRoZSBoeXN0ZXJlc2lzIGF0dHJpYnV0ZSBpcyBhbiBhYnNv
bHV0ZSB0ZW1wZXJhdHVyZS4NCj4+IFRoZSB2YWx1ZSB3cml0dGVuIGludG8gdGhlIGF0dHJpYnV0
ZSBpcyBleHBlY3RlZCB0byBiZSBpbiB0aGUgcmFuZ2UNCj4+IFtUSEVSTSAtIDE1LCBUSEVSTV0g
KGluIGRlZ3JlZXMgQykuIFRoZSB2YWx1ZSB3cml0dGVuIGludG8gdGhlIHJlZ2lzdGVyDQo+PiBp
cyB0aGVuIGluIHRoZSByYW5nZSBbMTUsIDBdLiBJIHNlZSBub3RoaW5nIHdyb25nIHdpdGggdGhl
IGN1cnJlbnQgY29kZS4NCj4+DQo+Pj4gdmFsdWUuIFRoaXMgY2F1c2VzIGl0IHRvIGFsd2F5cyBz
ZWxlY3QgMTVDIGZvciBoeXN0ZXJlc2lzLsKgIENoYW5nZSB0aGUNCj4+PiBmaXJzdCBwYXJhbWV0
ZXIgdG8gVEhFUk0gLSB2YWwgdG8gY29tcGFyZSB0d28gYWJzb2x1dGUgdGVtcGVyYXR1cmVzLg0K
Pj4+IFRoZSBzZWNvbmQgZXJyb3IgbWFza3MgdGhlIHdyb25nIGJpdHMgaW4gdGhlIGh5c3RlcmVz
aXMgcmVnaXN0ZXI7IA0KPj4+IGluZGljZXMNCj4+PiAwIGFuZCAyIHNob3VsZCB6ZXJvIGJpdHMg
Wzc6NF0gYW5kIHByZXNlcnZlIGJpdHMgWzM6MF0sIGFuZCBpbmRleCAxIA0KPj4+IHNob3VsZA0K
Pj4+IHplcm8gYml0cyBbMzowXSBhbmQgcHJlc2VydmUgYml0cyBbNzo0XS4NCj4+DQo+PiBJJ2xs
IGhhdmUgdG8gdmVyaWZ5IHRoYXQgd2l0aCB0aGUgZGF0YXNoZWV0LiBFaXRoZXIgY2FzZSwgb25l
IGxvZ2ljYWwgDQo+PiBjaGFuZ2UNCj4+IHBlciBwYXRjaCwgcGxlYXNlLg0KPj4NCj4gDQo+IEFj
dHVhbGx5LCB0aGUgcHJvYmxlbSBpcyBvYnZpb3VzIGZyb20gdGhlIGNvZGUuIFN0aWxsLCBlaXRo
ZXIgZHJvcCB0aGUgDQo+IGZpcnN0DQo+IHBhcnQgb2YgdGhlIHBhdGNoIG9yIHNlcGFyYXRlIGlu
dG8gdHdvIHBhdGNoZXMgYW5kIGV4cGxhaW4gaW4gZGV0YWlsIHdoYXQNCj4geW91IHRoaW5rIGlz
IHdyb25nIGluIHRoZSBmaXJzdCBwYXJ0LiBUaGVyZSBpcyBhIGNvbW1lbnQgaW4gdGhlIGNvZGUN
Cj4gDQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoNCj4gIMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICogVGhlIHZhbHVlIHdpbGwgYmUgZ2l2ZW4gYXMgYW4gYWJz
b2x1dGUgdmFsdWUsIHR1cm4gaXQNCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICogaW50byBhbiBvZmZzZXQgYmFzZWQgb24gVEhFUk0NCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICovDQo+IA0KPiBNYXliZSBJIGFtIG1pc3Npbmcgc29tZXRoaW5nLCBidXQg
SSB0aGluayB0aGF0IGlzIGV4YWN0bHkgd2hhdCB0aGUgY3VycmVudA0KPiBjb2RlIGlzIGRvaW5n
Lg0KU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5LCBteSBlbWFpbCB3YXNuJ3Qgd29ya2luZyBwcm9w
ZXJseS4NCg0KWW91IGFyZSBjb3JyZWN0LCBhbmQgc28gaXMgdGhlIGNvZGUuICBJIGFzc3VtZWQg
dGhlIGh5c3RlcmVzaXMgd291bGQgYmUgDQp3cml0dGVuIHRvIHRoZSBzeXNmcyB0ZW1wI19jcml0
X2h5c3QgZmlsZSBhcyBhIHJlbGF0aXZlIHRlbXBlcmF0dXJlLCANCihiZWluZyBjYWxsZWQgJ2h5
c3QnKSBub3QgYW4gYWJzb2x1dGUgdmFsdWUuICBJIGhhdmUgZml4ZWQgb3VyIGhvc3QgY29kZSAN
CnRvIHdyaXRlIHRoaXMgY29ycmVjdGx5IGFuZCBpdCB3b3JrcyBmaW5lIG5vdy4gIFRoaXMgcGFy
dCBvZiB0aGUgcGF0Y2ggDQpoYXMgYmVlbiBkcm9wcGVkIGFuZCB2MiBoYXMgYmVlbiBzZW50LiAg
VGhhbmtzIGZvciB5b3VyIGhlbHAuDQoNCkNoZWVycywNClRvbnkuDQo+IA0KPiBUaGFua3MsDQo+
IEd1ZW50ZXINCj4gDQo+PiBUaGFua3MsDQo+PiBHdWVudGVyDQo+Pg0KPj4+DQo+Pj4gRml4ZXM6
IDFjMzAxZmM1Mzk0ZiAoImh3bW9uOiBBZGQgYSBkcml2ZXIgZm9yIHRoZSBBRFQ3NDc1IGhhcmR3
YXJlIA0KPj4+IG1vbml0b3JpbmcgY2hpcCIpDQo+Pj4gU2lnbmVkLW9mZi1ieTogVG9ueSBPJ0Jy
aWVuIDx0b255Lm9icmllbkBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPj4+IC0tLQ0KPj4+IMKgIGRy
aXZlcnMvaHdtb24vYWR0NzQ3NS5jIHwgNiArKystLS0NCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaHdtb24vYWR0NzQ3NS5jIGIvZHJpdmVycy9od21vbi9hZHQ3NDc1LmMNCj4+PiBpbmRl
eCA3NzIyMmMzNWEzOGUuLjY4MjMzMTkxNzk4ZSAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL2h3
bW9uL2FkdDc0NzUuYw0KPj4+ICsrKyBiL2RyaXZlcnMvaHdtb24vYWR0NzQ3NS5jDQo+Pj4gQEAg
LTQ4NCwxNCArNDg0LDE0IEBAIHN0YXRpYyBzc2l6ZV90IHRlbXBfc3RvcmUoc3RydWN0IGRldmlj
ZSAqZGV2LCANCj4+PiBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgYWR0NzQ3NV9yZWFkX2h5c3RlcnNpcyhjbGllbnQpOw0KPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCB0ZW1wID0gcmVnMnRlbXAoZGF0YSwgZGF0YS0+dGVtcFtUSEVSTV1bc2F0dHIt
PmluZGV4XSk7DQo+Pj4gLcKgwqDCoMKgwqDCoMKgIHZhbCA9IGNsYW1wX3ZhbCh2YWwsIHRlbXAg
LSAxNTAwMCwgdGVtcCk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHZhbCA9IGNsYW1wX3ZhbCh0ZW1w
IC0gdmFsLCB0ZW1wIC0gMTUwMDAsIHRlbXApOw0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB2YWwg
PSAodGVtcCAtIHZhbCkgLyAxMDAwOw0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoc2F0dHIt
PmluZGV4ICE9IDEpIHsNCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkYXRhLT50ZW1wW0hZ
U1RFUlNJU11bc2F0dHItPmluZGV4XSAmPSAweEYwOw0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGRhdGEtPnRlbXBbSFlTVEVSU0lTXVtzYXR0ci0+aW5kZXhdICY9IDB4MEY7DQo+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGF0YS0+dGVtcFtIWVNURVJTSVNdW3NhdHRyLT5pbmRl
eF0gfD0gKHZhbCAmIDB4RikgPDwgNDsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsN
Cj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkYXRhLT50ZW1wW0hZU1RFUlNJU11bc2F0dHIt
PmluZGV4XSAmPSAweDBGOw0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRhdGEtPnRlbXBb
SFlTVEVSU0lTXVtzYXR0ci0+aW5kZXhdICY9IDB4RjA7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZGF0YS0+dGVtcFtIWVNURVJTSVNdW3NhdHRyLT5pbmRleF0gfD0gKHZhbCAmIDB4
Rik7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+PiAtLSANCj4+PiAyLjM5LjINCj4+Pg0K
PiANCg==
