Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33DB6B6D85
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 03:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCMCaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 22:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCMCaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 22:30:15 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B89279A9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 19:30:12 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A7DE72C05F3;
        Mon, 13 Mar 2023 15:30:09 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1678674609;
        bh=TCB+oOL3AmP8xAYR9XQS9bPYP9L337PgciAAc9DV86Y=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=orBjQ8JDkBKYlVyOz2kDboi1hFN9iU8haFSon8C3KW2skwva6KaFTI+/M1YtKe3AV
         HzQFZPPHzVu0AATU/itsLYhFKZvEwsPkhyE3WwVO2gj0jbQs87mDGLjb2/LIJS1DuY
         Y2aHvNPNATZZ6zvDsp6EvkOeTKmcnhB1COsrceJjdaGEVn8YFznRKjSgl1J3nGDDDf
         ygggrDgdxgqagjDhPWU/flXsuc0fL8K3NqWUEn27YH7PVTZ3UsDi9dbZpAmP/xvrYD
         IXhu9Fsj0o/z8hgZVrrKKHHMzwlas/ci5chKZDMBwwum3jMkCXTkTEU1RSv0wdFlSb
         p/nzR2R0tnG8Q==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B640e8ab10001>; Mon, 13 Mar 2023 15:30:09 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.47; Mon, 13 Mar 2023 15:30:09 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.047; Mon, 13 Mar 2023 15:30:09 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
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
        "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v3 1/2] drivers: rtc: add max313xx series rtc driver
Thread-Topic: [PATCH v3 1/2] drivers: rtc: add max313xx series rtc driver
Thread-Index: AQHZQLLY3ijYBbo43E6McZa87qvtIa7Sap6AgCTdZwCAAAFbgIAAAsKA
Date:   Mon, 13 Mar 2023 02:30:09 +0000
Message-ID: <630c70a9-f82e-fe3d-324a-041cde8f5deb@alliedtelesis.co.nz>
References: <20221108122254.1185-1-Ibrahim.Tilki@analog.com>
 <20221108122254.1185-2-Ibrahim.Tilki@analog.com>
 <68ddb833-f38e-a05b-82c4-ce12330410a5@alliedtelesis.co.nz>
 <CY4PR03MB2488B54E722831F0375430CA96A19@CY4PR03MB2488.namprd03.prod.outlook.com>
 <52382400-5abd-b473-6cf7-333e7deab2d4@alliedtelesis.co.nz>
 <20230313022017afe9a8fe@mail.local>
In-Reply-To: <20230313022017afe9a8fe@mail.local>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C66490394C18B040B7FCBCAACE57B2DC@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=GdlpYjfL c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=k__wU0fu6RkA:10 a=gAnH3GRIAAAA:8 a=6rO8HCioFkcRVP0wza0A:9 a=QEXdDO2ut3YA:10 a=oVHKYsEdi7-vN-J5QA_j:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMy8wMy8yMyAxNToyMCwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IEhlbGxvLA0K
Pg0KPiBPbiAxMy8wMy8yMDIzIDAyOjE1OjI2KzAwMDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+
PiBIaSBJYnJhaGltLA0KPj4NCj4+IE9uIDE4LzAyLzIzIDA0OjE3LCBUaWxraSwgSWJyYWhpbSB3
cm90ZToNCj4+Pj4gSGkgSWJyYWhpbSwNCj4+Pj4NCj4+Pj4gT24gOS8xMS8yMiAwMToyMiwgSWJy
YWhpbSBUaWxraSB3cm90ZToNCj4+Pj4+IEFkZGluZyBzdXBwb3J0IGZvciBBbmFsb2cgRGV2aWNl
cyBNQVgzMTNYWCBzZXJpZXMgUlRDcy4NCj4+Pj4+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBJYnJh
aGltIFRpbGtpIDxJYnJhaGltLlRpbGtpQGFuYWxvZy5jb20+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5
OiBaZXluZXAgQXJzbGFuYmVuemVyIDxaZXluZXAuQXJzbGFuYmVuemVyQGFuYWxvZy5jb20+DQo+
Pj4+PiAtLS0NCj4+Pj4+ICAgICBkcml2ZXJzL3J0Yy9LY29uZmlnICAgICAgICB8ICAgMTEgKw0K
Pj4+Pj4gICAgIGRyaXZlcnMvcnRjL01ha2VmaWxlICAgICAgIHwgICAgMSArDQo+Pj4+PiAgICAg
ZHJpdmVycy9ydGMvcnRjLW1heDMxM3h4LmMgfCAxMDcwICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPj4+Pj4gICAgIDMgZmlsZXMgY2hhbmdlZCwgMTA4MiBpbnNlcnRpb25z
KCspDQo+Pj4+PiAgICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcnRjL3J0Yy1tYXgzMTN4
eC5jDQo+Pj4+IFdoYXQgaXMgdGhlIGN1cnJlbnQgc3RhdGUgb2YgdGhpcyB3b3JrPyBJIHNlZSB0
aGVyZSBhcmUgc29tZSBjb21tZW50cyBvbg0KPj4+PiB0aGlzIHYzIGl0ZXJhdGlvbiBmcm9tIGxh
dGUgbGFzdCB5ZWFyIGFuZCBJIGNvdWxkbid0IGZpbmQgYW55IG5ld2VyDQo+Pj4+IGl0ZXJhdGlv
biBvbiBhbnkgbWFpbGluZyBsaXN0LiBXZSd2ZSBnb3Qgc29tZSBuZXcgaGFyZHdhcmUgYXJyaXZp
bmcgc29vbg0KPj4+PiB0aGF0IHdpbGwgaGF2ZSB0aGUgTUFYMzEzMzEgUlRDIGFuZCBJJ20ga2Vl
biB0byBzZWUgdGhpcyBwYXRjaCBzZXJpZXMNCj4+Pj4gbGFuZC4gSXMgdGhlcmUgYW55dGhpbmcg
SSBjYW4gZG8gdG8gaGVscCBpdCBhbG9uZz8gSSBjYW4ndCBiZSB2ZXJ5DQo+Pj4+IHNwZWNpZmlj
IGFib3V0IHdoZW4gSSdsbCBzZWUgdGhlIG5ldyBoYXJkd2FyZSAod2hvIGNhbiB0aGVzZSBkYXlz
KSwgdGhlDQo+Pj4+IGxhc3QgdXBkYXRlIHdhcyAiYm9hcmRzIGFyZSBkdWUgaW4gTWFyY2giLg0K
Pj4+Pg0KPj4+PiBGb3IgdGhlIG1haW50YWluZXJzIG9uIHRoZSBDYyBsaXN0IG9uY2UgdGhlIGR1
c3Qgc2V0dGxlcyBob3cgd291bGQgSSBnZXQNCj4+Pj4gdGhpcyBzdXBwb3J0ZWQgaW4gYSBMVFMg
a2VybmVsICh3ZSdyZSBjdXJyZW50bHkgdXNpbmcgdGhlIDUuMTUgc2VyaWVzKT8NCj4+Pj4gT3Ig
aXMgdG90YWxseSBvdXQgb2YgdGhlIHF1ZXN0aW9uIGJlY2F1c2UgaXQncyBub3QganVzdCBhIG5l
dyBkZXZpY2UgaWQ/DQo+Pj4gSGkgQ2hyaXMsDQo+Pj4NCj4+PiBQYXRjaCB2NCBpcyBvbiB0aGUg
d2F5LCBJIHdpbGwgYmUgc2VuZGluZyBpdCBpbiBhIGZldyB3ZWVrcy4NCj4+PiBJdCBpcyBoYXJk
IHRvIHRlbGwgd2hlbiBpdCBpcyBnb2luZyB0byBsYW5kIGJ1dCBJIGV4cGVjdCB0byBiZSBtb3Jl
IHJlc3BvbnNpdmUNCj4+PiB0byByZXZpZXdzIGFmdGVyIHBhdGNoIHY0Lg0KPj4gRllJIEkndmUg
bm93IGdvdCBzb21lIGJvYXJkcyB3aXRoIGEgTUFYMzEzMzEuIEkndmUgZ2l2ZW4gdjMgYSBxdWlj
ayB0ZXN0DQo+PiBhbmQgaXQgd29ya3MgZm9yIG1lLg0KPj4NCj4+IEFyZSB5b3UgYWxzbyBsb29r
aW5nIGF0IGEgdS1ib290IGRyaXZlcj8gSWYgbm90IEkgY2FuIHBvcnQgeW91ciBkcml2ZXINCj4+
IGFjcm9zcyByZWFzb25hYmx5IGVhc2lseS4NCj4+DQo+IEknbSBjdXJpb3VzIHdoeSB3b3VsZCB5
b3UgbmVlZCBhbiBSVEMgZHJpdmVyIGZvciB1LWJvb3Q/DQoNClNob3J0IGFuc3dlciBpcyBiZWNh
dXNlIHUtYm9vdCBoYXMgUlRDIGRyaXZlcnMgYW5kIGNvbW1hbmRzIHRvIHNldC9yZWFkIA0KdGhl
bS4NCg0KU2xpZ2h0bHkgbG9uZ2VyIGFuc3dlciBpcyB0aGF0IGZvciBvdXIgY3VycmVudCBwcm9k
dWN0cyAobW9zdCB3aXRoIGEgDQpEUzEzNDAgb3Igc29tZXRoaW5nIGNsb3NlKSBvdXIgaW5pdGlh
bCBtYW51ZmFjdHVyaW5nIHByb2Nlc3MgaW5jbHVkZXMgDQpzZXR0aW5nIHRoZSBSVEMgZnJvbSB1
LWJvb3QuIEl0J3MgbW9zdGx5IGEgImJlY2F1c2Ugd2UndmUgYWx3YXlzIGRvbmUgaXQgDQp0aGF0
IHdheSIgYnV0IGl0IGRvZXMgaGF2ZSB0aGUgYWR2YW50YWdlIHRoYXQgYW55IGxvZ3Mgb3IgZmls
ZXMgY3JlYXRlZCANCm9uIGZpcnN0IGJvb3QgZ2V0IHRpbWVzdGFtcGVkIGNvcnJlY3RseS4gWWVz
IHdlIGNvdWxkIHNldCB0aGUgY2xvY2sgZnJvbSANCnVzZXJsYW5kIG9uIGZpcnN0IGJvb3QgYnV0
IHRoZXJlIHdvdWxkIGJlIGEgZmV3IG9kZCBsb2cgZW50cmllcyBmcm9tIA0KYmVmb3JlIHRoZSBS
VEMgd2FzIHNldC4NCg==
