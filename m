Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00544702010
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 23:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjENV6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 17:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjENV6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 17:58:05 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DEE1B1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 14:58:02 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A546C2C0616;
        Mon, 15 May 2023 09:57:59 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1684101479;
        bh=JeDX45idLyAjJeK4Qpwm2w1/vop2BI8SWEa3eOTQ/4k=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=E8aXm5JTSLl9mZugZJgeNLfzDQGW/WSHeKZJsDR1Ugt4AY7Ivjm2EXCuRULFTKbM9
         fo4RledFP9AMlSMDfDYuDfuMpnFyH1CQOQOgchFRfgUfQkoDS3njYyZ5t62JGWUNZB
         XDTaEP7gYXnzHgJamYmH20+Ex8OYFgqqNIvYw1fPTghM5tVlWaEWBmzLSZk5lcVGzF
         Q5/qd2bgdmnbfN1+F7eBOeiZon1FDVkis5xysK1CxpzKKv47eDfXDvWLw2qiMY+g7K
         oSeQlPe2mHT/ZxVCQqWW9tOxXGrGXjxxGrGo08i9wJqGUV1jEjm066kaBkAIZPI7Fs
         mLIXReplQ6EFw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B646159670001>; Mon, 15 May 2023 09:57:59 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Mon, 15 May 2023 09:57:59 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Mon, 15 May 2023 09:57:59 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Mon, 15 May 2023 09:57:59 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Johan Hovold <johan@kernel.org>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "maz@kernel.org" <maz@kernel.org>,
        Ben Brown <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Thread-Topic: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Thread-Index: AQHZhIoofApft8Zm8kuYZtpxH+f53K9Vc1EAgAQYugA=
Date:   Sun, 14 May 2023 21:57:58 +0000
Message-ID: <2265adee-e003-08ae-e66d-fb41bdd79122@alliedtelesis.co.nz>
References: <20230512042806.3438373-1-chris.packham@alliedtelesis.co.nz>
 <ZF3pqvOVv6eZl62y@hovoldconsulting.com>
In-Reply-To: <ZF3pqvOVv6eZl62y@hovoldconsulting.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7073B9F3EF69294B989A10B1BB7B59F2@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=62ntRvTiAAAA:8 a=VwQbUJbxAAAA:8 a=7-fA9F3rEMDvrztMVqEA:9 a=QEXdDO2ut3YA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMi8wNS8yMyAxOToyNCwgSm9oYW4gSG92b2xkIHdyb3RlOg0KPiBPbiBGcmksIE1heSAx
MiwgMjAyMyBhdCAwNDoyODowNlBNICsxMjAwLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4gQ2Fs
bGluZyBncGlvZF90b19pcnEoKSBjcmVhdGVzIGFuIGlycV9kZXNjIGZvciB0aGUgR1BJTy4gVGhp
cyBpcyBub3QNCj4+IHNvbWV0aGluZyB0aGF0IHNob3VsZCBoYXBwZW4gd2hlbiBqdXN0IGV4cG9y
dGluZyB0aGUgR1BJTyB2aWEgc3lzZnMuIFRoZQ0KPj4gZWZmZWN0IG9mIHRoaXMgd2FzIG9ic2Vy
dmVkIGFzIHRyaWdnZXJpbmcgYSB3YXJuaW5nIGluDQo+PiBncGlvY2hpcF9kaXNhYmxlX2lycSgp
IHdoZW4ga2V4ZWMoKWluZyBhZnRlciBleHBvcnRpbmcgYSBHUElPLg0KPiBZb3UgbmVlZCBhIGJl
dHRlciBleHBsYW5hdGlvbiBhcyB0byB3aHkgdGhpcyBpcyBhbiBpc3N1ZS4gV2hhdCBkb2VzIHRo
ZQ0KPiB3YXJuaW5nIGxvb2sgbGlrZSBmb3IgZXhhbXBsZT8NCg0KSXJvbmljYWxseSBJIGhhZCB0
aGF0IGluIG15IGZpcnN0IGF0dGVtcHQgdG8gYWRkcmVzcyB0aGUgaXNzdWUgYnV0IHdhcyANCnRv
bGQgaXQgd2FzIHRvbyBtdWNoIGRldGFpbC4gU28gbm93IEkndmUgZ29uZSB0b28gZmFyIHRoZSBv
dGhlciB3YXkuIA0KSSdsbCBpbmNsdWRlIGl0IGluIHRoZSByZXNwb25zZSBJJ20gYWJvdXQgdG8g
c2VuZCB0byBMaW51c1cuDQoNCj4+IFJlbW92ZSB0aGUgY2FsbCB0byBncGlvZF90b19pcnEoKSBm
cm9tIGdwaW9faXNfdmlzaWJsZSgpLiBUaGUgYWN0dWFsDQo+PiBpbnRlbmRlZCBjcmVhdGlvbiBv
ZiB0aGUgaXJxX2Rlc2MgY29tZXMgdmlhIGVkZ2Vfc3RvcmUoKSB3aGVuIHJlcXVlc3RlZA0KPj4g
YnkgdGhlIHVzZXIuDQo+IEFuZCB3aHkgZG9lcyB0aGF0IGF2b2lkIHdoYXRldmVyIHByb2JsZW0g
eW91J3JlIHNlZWluZz8NCj4NCj4+IEZpeGVzOiBlYmJlYmExMjBhYjIgKCJncGlvOiBzeXNmczog
Zml4IGdwaW8gYXR0cmlidXRlLWNyZWF0aW9uIHJhY2UiKQ0KPiBUaGlzIGlzIGNsZWFybHkgbm90
IHRoZSByaWdodCBGaXhlcyB0YWcuIFRoZSBhYm92ZSBjb21taXQgb25seSBtb3ZlZCB0aGUNCj4g
Y3JlYXRpb24gb2YgdGhlIGF0dHJpYnV0ZSB0byBiZWZvcmUgcmVnaXN0ZXJpbmcgdGhlIHN5c2Zz
IGRldmljZSBhbmQNCj4gc3BlY2lmaWNhbGx5IGdwaW9kX3RvX2lycSgpIHdhcyB1c2VkIGFsc28g
cHJpb3IgdG8gdGhhdCBjb21taXQuDQo+DQo+IEFzIGEgbWF0dGVyIG9mIGZhY3QsIGJhY2sgdGhl
biB0aGVyZSB3YXMgbm8gY2FsbCB0bw0KPiBpcnFfY3JlYXRlX21hcHBpbmcoKSBpbiBncGlvZF90
b19pcnEoKSBlaXRoZXIuIFRoYXQgd2FzIGFkZGVkIHllYXJzDQo+IGxhdGVyIGJ5IGNvbW1pdA0K
Pg0KPiAJZGM3NDlhMDllYTVlICgiZ3Bpb2xpYjogYWxsb3cgZ3BpbyBpcnFjaGlwIHRvIG1hcCBp
cnFzIGR5bmFtaWNhbGx5IikNCg0KT0sgdGhhbmtzIGZvciBkb2luZyBiZXR0ZXIgcmVzZWFyY2gu
IEkga25vdyB0aGlzIGlzIGEgcHJvYmxlbSBhdCBsZWFzdCANCmFzIGZhciBiYWNrIGFzIDUuMTUg
YnV0IGl0J3MgaGFyZCB0byB0cmFjayBkb3duIGV4YWN0bHkgaG93IGZhciBiYWNrIGl0IA0KZ29l
cyBhcyB0aGVyZSBhcHBlYXJzIHRvIGJlIG11bHRpcGxlIGNoYW5nZXMgaW52b2x2ZWQuIEkgc2hv
dWxkIHByb2JhYmx5IA0KbGVhdmUgb3V0IHRoZSBmaXhlcyB0YWcgdW50aWwgSSd2ZSBhY3R1YWxs
eSBjb252aW5jZWQgcGVvcGxlIHRoZXJlIGlzIGEgDQpwcm9ibGVtIHRvIGJlIGZpeGVkLg0KDQo+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRl
bGVzaXMuY28ubno+DQo+PiAtLS0NCj4+DQo+PiBOb3RlczoNCj4+ICAgICAgVGhpcyBpcyB0ZWNo
bmljYWxseSBhIHYyIG9mDQo+PiAgICAgIGh0dHBzOi8vc2Nhbm1haWwudHJ1c3R3YXZlLmNvbS8/
Yz0yMDk4OCZkPWx1bmQ1SUpCRW1tR2pHNmQ4T3M1YTJJWWxTUTkzOFJmQ0F1WldtZGV5QSZ1PWh0
dHBzJTNhJTJmJTJmbG9yZSUyZWtlcm5lbCUyZW9yZyUyZmxrbWwlMmYyMDIzMDUxMDAwMTE1MSUy
ZTM5NDY5MzEtMS1jaHJpcyUyZXBhY2toYW0lNDBhbGxpZWR0ZWxlc2lzJTJlY28lMmVueiUyZg0K
Pj4gICAgICBidXQgdGhlIHNvbHV0aW9uIGlzIHNvIGRpZmZlcmVudCBpdCdzIHByb2JhYmx5IGJl
c3QgdG8gdHJlYXQgaXQgYXMgYSBuZXcNCj4+ICAgICAgcGF0Y2guDQo+Pg0KPj4gICBkcml2ZXJz
L2dwaW8vZ3Bpb2xpYi1zeXNmcy5jIHwgMiAtLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncGlvL2dwaW9saWItc3lzZnMu
YyBiL2RyaXZlcnMvZ3Bpby9ncGlvbGliLXN5c2ZzLmMNCj4+IGluZGV4IDUzMGRmZDE5ZDdiNS4u
Zjg1OWRjZDFjYmYzIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncGlvL2dwaW9saWItc3lzZnMu
Yw0KPj4gKysrIGIvZHJpdmVycy9ncGlvL2dwaW9saWItc3lzZnMuYw0KPj4gQEAgLTM2Miw4ICsz
NjIsNiBAQCBzdGF0aWMgdW1vZGVfdCBncGlvX2lzX3Zpc2libGUoc3RydWN0IGtvYmplY3QgKmtv
YmosIHN0cnVjdCBhdHRyaWJ1dGUgKmF0dHIsDQo+PiAgIAkJaWYgKCFzaG93X2RpcmVjdGlvbikN
Cj4+ICAgCQkJbW9kZSA9IDA7DQo+PiAgIAl9IGVsc2UgaWYgKGF0dHIgPT0gJmRldl9hdHRyX2Vk
Z2UuYXR0cikgew0KPj4gLQkJaWYgKGdwaW9kX3RvX2lycShkZXNjKSA8IDApDQo+PiAtCQkJbW9k
ZSA9IDA7DQo+PiAgIAkJaWYgKCFzaG93X2RpcmVjdGlvbiAmJiB0ZXN0X2JpdChGTEFHX0lTX09V
VCwgJmRlc2MtPmZsYWdzKSkNCj4+ICAgCQkJbW9kZSA9IDA7DQo+PiAgIAl9DQo+IEpvaGFu
