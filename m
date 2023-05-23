Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418A370E73B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238408AbjEWVRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEWVRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:17:31 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F295FA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:17:29 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 23D8F2C0547;
        Wed, 24 May 2023 09:17:27 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1684876647;
        bh=ZvXitr014EREBUifBncsKvKKnEFL9Kh1HAGb9bEhHis=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=fEZNX6Ni9/wa04cjBAj6H274iIhgY+Eo3s1cBLVNP0TgZQ9iXVY8xBgAMPXDdRTGx
         zxwtLSxsKgB7Y3/eEsl2ngHj6cBCbWBzHX9JhT/ziUiM9k7Qnv21vHgM6XC+RPmqLL
         dxCnrm4pynpTcFD9udxZ/HHGZMDup7L1ljjPYmJ3HXe+npWVbCfRUOPNeWoJ7KocZj
         DIeHs+xCnF7lQM8q+nvudksjR1iC0Dqi0dIt8ZPAdCf2nUOiweiXg5eLpmA9X6n53s
         LIDV0GoIjEALNJRHK9em+7FkiV47cfRFiqulvna1+ckSkki5WcTVebIQTtWak+Re+0
         kxYlerXosE5pQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B646d2d670000>; Wed, 24 May 2023 09:17:27 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Wed, 24 May 2023 09:17:26 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Wed, 24 May 2023 09:17:26 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Wed, 24 May 2023 09:17:26 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "johan@kernel.org" <johan@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        Ben Brown <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Thread-Topic: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Thread-Index: AQHZhIoofApft8Zm8kuYZtpxH+f53K9VfDeAgAQYHQCAApZDgIAAjA4AgAAH1ICAABG6AIAAmBEAgADTMYCACRxagIAATeQA
Date:   Tue, 23 May 2023 21:17:26 +0000
Message-ID: <72990baf-6964-01ad-d891-7090831d0310@alliedtelesis.co.nz>
References: <ZGzsD_HMbMGhGwcr@surfacebook>
In-Reply-To: <ZGzsD_HMbMGhGwcr@surfacebook>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <80F6D28F8932D6449F0394320FBA0349@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=pGLkceISAAAA:8 a=FI1P0K7GtinFDTRE2UUA:9 a=QEXdDO2ut3YA:10
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

DQpPbiAyNC8wNS8yMyAwNDozOCwgYW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbSB3cm90ZToNCj4g
V2VkLCBNYXkgMTcsIDIwMjMgYXQgMDk6MzA6NTFQTSArMDAwMCwgQ2hyaXMgUGFja2hhbSBraXJq
b2l0dGk6DQo+PiBPbiAxNy8wNS8yMyAyMDo1NCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPj4+
IE9uIFdlZCwgTWF5IDE3LCAyMDIzIGF0IDI6NTDigK9BTSBDaHJpcyBQYWNraGFtDQo+Pj4gPENo
cmlzLlBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4gd3JvdGU6DQo+Pj4+IE9uIDE3LzA1LzIz
IDEwOjQ3LCBLZW50IEdpYnNvbiB3cm90ZToNCj4gLi4uDQo+DQo+Pj4+IFRoZSBmaXJzdCBpcyBh
IHVzZXJzcGFjZSBkcml2ZXIgZm9yIGEgUG93ZXIgT3ZlciBFdGhlcm5ldCBDb250cm9sbGVyK1BT
RQ0KPj4+PiBjaGlwc2V0IChJJ2xsIHJlZmVyIHRvIHRoaXMgYXMgYW4gTUNVIHNpbmNlIHRoZSB0
aGluZyB3ZSB0YWxrIHRvIGlzDQo+Pj4+IHJlYWxseSBhIG1pY3JvIGNvbnRyb2xsZXIgd2l0aCBh
IHZlbmRvciBzdXBwbGllZCBmaXJtd2FyZSBvbiBpdCB0aGF0DQo+Pj4+IGRvZXMgbW9zdCBvZiB0
aGUgUG9FIHN0dWZmKS4gQ29tbXVuaWNhdGlvbiB0byB0aGUgTUNVIGlzIGJhc2VkIGFyb3VuZA0K
Pj4+PiBjb21tYW5kcyBzZW50IHZpYSBpMmMuIEJ1dCB0aGVyZSBhcmUgYSBmZXcgZXh0cmEgR1BJ
T3MgdGhhdCBhcmUgdXNlZCB0bw0KPj4+PiByZXNldCB0aGUgTUNVIGFzIHdlbGwgYXMgcHJvdmlk
ZSBhIG1lY2hhbmlzbSBmb3IgcXVpY2tseSBkcm9wcGluZyBwb3dlcg0KPj4+PiBvbiBjZXJ0YWlu
IGV2ZW50cyAoZS5nLiBpZiB0aGUgdGVtcGVyYXR1cmUgbW9uaXRvcmluZyBkZXRlY3RzIGEgcHJv
YmxlbSkuDQo+Pj4gV2h5IGRvZXMgdGhlIE1DVSBoYXZlIG5vIGluLWtlcm5lbCBkcml2ZXI/DQo+
PiBUaGVyZSBpc24ndCBhbnkgUG9FIFBTRSBpbmZyYXN0cnVjdHVyZSBpbiB0aGUga2VybmVsLiBJ
J20gbm90IHJlYWxseQ0KPj4gc3VyZSB3aGF0IGl0J2QgbG9vayBsaWtlIGVpdGhlciBhcyB0aGUg
aGFyZHdhcmUgZGVzaWducyBhcmUgYWxsIGhpZ2hseQ0KPj4gY3VzdG9taXplZCBhbmQgb2Z0ZW4g
aGF2ZSB2ZXJ5IHNwZWNpYWxpemVkIHJlcXVpcmVtZW50cy4gRXZlbiB0aGUgdmVuZG9yDQo+PiBy
ZWZlcmVuY2UgYm9hcmRzIHRlbmQgdG8gdXNlIHRoZSBpMmMgdXNlcnNwYWNlIGludGVyZmFjZSBh
bmQgcHVudA0KPj4gZXZlcnl0aGluZyB0byBhIHNwZWNpYWxpc3QgYXBwbGljYXRpb24uDQo+Pg0K
Pj4gT2YgY291cnNlIGlmIGFueW9uZSBpcyB0aGlua2luZyBhYm91dCBhZGRpbmcgUG9FIFBTRSBz
dXBwb3J0IGluLWtlcm5lbA0KPj4gSSdkIGJlIHZlcnkga2VlbiB0byBiZSBpbnZvbHZlZC4NCj4g
QnV0IHdoYXQgZG8gbmV0IHN1YnN5c3RlbSBndXlzIGtub3cgYWJvdXQgdGhpcz8gSGF2ZSB5b3Ug
aGFkIGEgY2hhbmNlDQo+IHRvIGFzayB0aGVtPw0KDQpJIGhhdmVuJ3QgcmVhbGx5IHRhbGtlZCB0
byBhbnkgbmV0IHN1YnN5c3RlbSBkZXZlbG9wZXJzIGFib3V0IFBvRS4gDQpUaGVyZSdzIGFkZGVk
IGNvbXBsaWNhdGlvbnMgdGhhdCB0aGUgbmV3ZXIgUG9FIHN0YW5kYXJkcyByZXF1aXJlIExMRFAg
DQooYnV0IEkgdGhpbmsgdGhhdCBjb3VsZCBiZSBkb25lIGluIHVzZXJsYW5kIGlmIHRoZSBrZXJu
ZWwgcHJvdmlkZWQgdGhlIA0KcmlnaHQgaW50ZXJmYWNlIHRvIHRoZSBoYXJkd2FyZSkuDQoNCkkn
bSBub3Qgc3VyZSBob3cgc3VjaCBhIGNvbnZlcnNhdGlvbiB3b3VsZCBldmVuIGdvLCBmZWVscyBs
aWtlIHNvbWV0aGluZyANCnRoYXQgd291bGQgYmUgYmV0dGVyIGZhY2UgdG8gZmFjZSByYXRoZXIg
dGhhbiBvbiBhIG1haWxpbmcgbGlzdC4gDQpQcmUtY292aWQgSSBtYXkgaGF2ZSBiZWVuIGFibGUg
dG8gY2hhdCB0byBzb21lb25lIGluIHRoZSBoYWxsd2F5IHRyYWNrIA0KYXQgTENBIGJ1dCB0aGUg
b3Bwb3J0dW5pdGllcyBmb3IgdGhpcyBraW5kIG9mIHRoaW5nIGhhdmUgZHJpZWQgdXAgaW4gbXkg
DQpjb3JuZXIgb2YgdGhlIGdsb2JlLg0KDQo+Pj4+IFdlIGRvIGhhdmUgYSBzbWFsbCBrZXJuZWwg
bW9kdWxlIHRoYXQgZ3JhYnMgdGhlIEdQSU9zIGJhc2VkIG9uIHRoZQ0KPj4+PiBkZXZpY2UgdHJl
ZSBhbmQgZXhwb3J0cyB0aGVtIHdpdGggYSBrbm93biBuYW1lcyAoZS5nLiAicG9lLXJlc2V0IiwN
Cj4+Pj4gInBvZS1kaXMiKSB0aGF0IHRoZSB1c2Vyc3BhY2UgZHJpdmVyIGNhbiB1c2UuDQo+Pj4g
U28sIGJlc2lkZXMgdGhhdCB5b3UgcmVwZWF0IGdwaW8tYWdncmVnYXRvciBmdW5jdGlvbmFsaXR5
LCB5b3UgYWxyZWFkeQ0KPj4+IGhhdmUgYSAicHJveHkiIGRyaXZlciBpbiB0aGUga2VybmVsLiBX
aGF0IHByZXZlbnRzIHlvdSBmcm9tIGRvaW5nIG1vcmUNCj4+PiBpbi1rZXJuZWw/DQo+PiBZZXMg
dHJ1ZS4gVGhlIG1haW4gaXNzdWUgaXMgdGhhdCB3aXRob3V0IHRvdGFsIHN1cHBvcnQgZm9yIHRo
ZSBjbGFzcyBvZg0KPj4gZGV2aWNlIGluIHRoZSBrZXJuZWwgdGhlcmUncyBsaXR0bGUgbW9yZSB0
aGF0IHlvdSBjYW4gZG8gb3RoZXIgdGhhbg0KPj4gZXhwb3NpbmcgZ3Bpb3MgKGVpdGhlciBhcyBn
cGlvX2V4cG9ydF9saW5rKCkgb3Igc29tZSBvdGhlciBiZXNwb2tlDQo+PiBpbnRlcmZhY2UpLg0K
Pj4NCj4+Pj4gICAgQmFjayB3aGVuIHRoYXQgY29kZSB3YXMNCj4+Pj4gd3JpdHRlbiB3ZSBkaWQg
Y29uc2lkZXIgbm90IGV4cG9ydGluZyB0aGUgR1BJT3MgYW5kIGluc3RlYWQgaGF2aW5nIHNvbWUN
Cj4+Pj4gb3RoZXIgc3lzZnMvaW9jdGwgaW50ZXJmYWNlIGludG8gdGhpcyBrZXJuZWwgbW9kdWxl
IGJ1dCB0aGF0IHNlZW1lZCBtb3JlDQo+Pj4+IHdvcmsgdGhhbiBqdXN0IGNhbGxpbmcgZ3Bpb2Rf
ZXhwb3J0KCkgZm9yIGxpdHRsZSBnYWluLiBUaGlzIGlzIHdoZXJlDQo+Pj4+IGFkZGluZyB0aGUg
Z3Bpby1uYW1lcyBwcm9wZXJ0eSBpbiBvdXIgLmR0cyB3b3VsZCBhbGxvdyBsaWJncGlvZCB0byBk
bw0KPj4+PiBzb21ldGhpbmcgc2ltaWxhci4NCj4+Pj4NCj4+Pj4gSGF2aW5nIHRoZSBHUElPcyBp
biBzeXNmcyBpcyBhbHNvIGNvbnZlbmllbnQgYXMgd2UgY2FuIGhhdmUgYSBzeXN0ZW1kDQo+Pj4+
IEV4ZWNTdG9wUG9zdCBzY3JpcHQgdGhhdCBjYW4gZHJvcCBwb3dlciBhbmQvb3IgcmVzZXQgdGhl
IE1DVSBpZiBvdXINCj4+Pj4gYXBwbGljYXRpb24gY3Jhc2hlcy4NCj4+PiBJJ20gYSBiaXQgbG9z
dC4gV2hhdCB5b3VyIGFwcCBpcyBkb2luZyBhbmQgaG93IHRoYXQgaXMgcmVsYXRlZCB0byB0aGUN
Cj4+PiAodXNlcnNwYWNlKSBkcml2ZXJzPw0KPj4gUHJvYmFibHkgb25lIG9mIHRoZSBwcmltYXJ5
IHRoaW5ncyBpdCdzIGRvaW5nIGlzIGJyaW5naW5nIHRoZSBjaGlwIG91dA0KPj4gb2YgcmVzZXQg
YnkgZHJpdmluZyB0aGUgR1BJTyAod2UgZG9uJ3Qgd2FudCB0aGUgUG9FIFBTRSBzdXBwbHlpbmcg
cG93ZXINCj4+IGlmIG5vdGhpbmcgaXMgbW9uaXRvcmluZyB0aGUgdGVtcGVyYXR1cmUgb2YgdGhl
IHN5c3RlbSkuIFRoZXJlJ3MgYWxzbw0KPj4gc29tZSBjb3JuZXIgY2FzZXMgaW52b2x2aW5nIG5v
dCByZXNldHRpbmcgdGhlIFBvRSBjaGlwc2V0IG9uIGEgaG90IHJlc3RhcnQuDQo+IFNvLCBkbyBJ
IHVuZGVyc3RhbmQgY29ycmVjdCB0aGUgZm9sbG93aW5nPw0KPiBUaGVyZSBpcyBhIFBvRSBQU0Ug
d2hpY2ggaGFzIGEgcHJvcHJpZXRhcnkgdXNlciBzcGFjZSBkcml2ZXIgYW5kIHRvIG1ha2UgaXQN
Cj4gd29yayByZWxpYWJseSB3ZSBoYXZlIHRvIGFkZCBhIHF1aXJrIHdoaWNoIHV0aWxpemVzIHRo
ZSBHUElPIHN5c2ZzPw0KDQpJdCdzIG5vdCByZWFsbHkgYWRkaW5nIGFueXRoaW5nIHRvIHN1cHBv
cnQgdGhlIHByb3ByaWV0YXJ5IHVzZXJzcGFjZSANCmRyaXZlci4gSXQncyBtYWtpbmcgdXNlIG9m
IGEgbG9uZyBlc3RhYmxpc2hlZCAoYWxiZWl0IGRlcHJlY2F0ZWQpIEFCSS4NCg0KPj4+PiBJJ20g
bm90IHN1cmUgaWYgdGhlIEdQSU8gY2hhcmRldiBpbnRlcmZhY2UgZGVhbHMNCj4+Pj4gd2l0aCBy
ZWxlYXNpbmcgdGhlIEdQSU8gbGluZXMgaWYgdGhlIHByb2Nlc3MgdGhhdCByZXF1ZXN0ZWQgdGhl
bSBleGl0cw0KPj4+PiBhYm5vcm1hbGx5IChJIGFzc3VtZSBpdCBkb2VzKSBhbmQgb2J2aW91c2x5
IG91ciBFeGVjU3RvcFBvc3Qgc2NyaXB0DQo+Pj4+IHdvdWxkIG5lZWQgdXBkYXRpbmcgdG8gdXNl
IHNvbWUgb2YgdGhlIGxpYmdwaW9kIGFwcGxpY2F0aW9ucyB0byBkbyB3aGF0DQo+Pj4+IGl0IGN1
cnJlbnRseSBkb2VzIHdpdGggYSBzaW1wbGUgJ2VjaG8gMSA+Li4uL3BvZS1yZXNldCcNCj4+Pj4N
Cj4+Pj4gVGhlIHNlY29uZCBhcHBsaWNhdGlvbiBpcyBhIHVzZXJzcGFjZSBkcml2ZXIgZm9yIGEg
TDMgbmV0d29yayBzd2l0Y2gNCj4+Pj4gKGFjdHVhbGx5IHR3byBvZiB0aGVtIGZvciBkaWZmZXJl
bnQgc2lsaWNvbiB2ZW5kb3JzKS4gQWdhaW4gdGhpcyBuZWVkcw0KPj4+PiB0byBkZWFsIHdpdGgg
cmVzZXRzIGZvciBQSFlzIGNvbm5lY3RlZCB0byB0aGUgc3dpdGNoIHRoYXQgdGhlIGtlcm5lbCBo
YXMNCj4+Pj4gbm8gdmlzaWJpbGl0eSBvZiBhcyB3ZWxsIGFzIHRoZSBHUElPcyBmb3IgdGhlIFNG
UCBjYWdlcy4gQWdhaW4gd2UgaGF2ZSBhDQo+Pj4+IHNsaWdodGx5IGxlc3Mgc2ltcGxlIGtlcm5l
bCBtb2R1bGUgdGhhdCBncmFicyBhbGwgdGhlc2UgR1BJT3MgYW5kDQo+Pj4+IGV4cG9ydHMgdGhl
bSB3aXRoIGtub3duIG5hbWVzLiBUaGlzIHRpbWUgdGhlcmUgYXJlIGNvbnNpZGVyYWJseSBtb3Jl
IG9mDQo+Pj4+IHRoZXNlIEdQSU9zIChvdXIgbGFyZ2VzdCBzeXN0ZW0gY3VycmVudGx5IGhhcyA5
NiBTRlArIHBvcnRzIHdpdGggNCBHUElPcw0KPj4+PiBwZXIgcG9ydCkgc28gd2UncmUgbXVjaCBt
b3JlIHJlbGlhbnQgb24gYmVpbmcgYWJsZSB0byBkbyB0aGluZ3MgbGlrZQ0KPj4+PiBgZm9yIHgg
aW4gcG9ydCp0eC1kaXM7IGRvIGVjaG8gMSA+JHg7IGRvbmVgDQo+Pj4gSG1tLi4uIEhhdmUgeW91
IHRhbGtlZCB0byB0aGUgbmV0IHN1YnN5c3RlbSBndXlzPyBJIGtub3cgdGhhdCB0aGVyZSBpcw0K
Pj4+IGEgbG90IGdvaW5nIG9uIGFyb3VuZCBTRlAgY2FnZSBlbnVtZXJhdGlvbiBmb3Igc29tZSBv
ZiB0aGUgbW9kdWxlcw0KPj4+IChNYXJ2ZWxsPykgYW5kIHBlcmhhcHMgdGhleSBjYW4gYWR2aXNl
IHNvbWV0aGluZyBkaWZmZXJlbnQuDQo+PiBZZXMgSSdtIGF3YXJlIG9mIHRoZSBzd2l0Y2hkZXYg
d29yayBhbmQgSSdtIHZlcnkgZW50aHVzaWFzdGljIGFib3V0IGl0DQo+PiAoYXMgYW4gYXNpZGUg
SSBkbyBoYXZlIGEgZmFpcmx5IGZ1bmN0aW9uYWwgc3dpdGNoZGV2IGRyaXZlciBmb3Igc29tZSBv
Zg0KPj4gdGhlIG9sZGVyIE1hcnZlbGwgUG9uY2F0MiBzaWxpY29uLCBuZXZlciBxdWl0ZSBnb3Qg
dG8gc3VibWl0dGluZyBpdA0KPj4gdXBzdHJlYW0gYmVmb3JlIHdlIHJhbiBvdXQgb2YgdGltZSBv
biB0aGUgcHJvamVjdCkuDQo+Pg0KPj4gQWdhaW4gdGhlIHByb2JsZW0gYm9pbHMgZG93biB0byB0
aGUgZmFjdCB0aGF0IHdlIGhhdmUgYSB1c2Vyc3BhY2Ugc3dpdGNoDQo+PiBkcml2ZXIgKHdoaWNo
IHVzZXMgYSB2ZW5kb3Igc3VwcGxpZWQgbm9uLWZyZWUgU0RLKS4gU28gZGVzcGl0ZSB0aGUNCj4+
IGtlcm5lbCBoYXZpbmcgcXVpdGUgZ29vZCBzdXBwb3J0IGZvciBTRlBzIEkgY2FuJ3QgdXNlIGl0
IHdpdGhvdXQgYQ0KPj4gbmV0ZGV2IHRvIGF0dGFjaCBpdCB0by4NCj4gVGhhdCB1c2VyIHNwYWNl
IGRyaXZlciBpcyB1c2luZyB3aGF0IGZyb20gdGhlIGtlcm5lbD8gR1BJTyBzeXNmcz8NCg0KWWVz
IEdQSU8gc3lzZnMgYW5kIGV4cG9ydGVkIGxpbmtzIHdpdGgga25vd24gbmFtZXMsIHdoaWNoIGFs
bG93cyB0aGluZ3MgDQp0byBiZSBkb25lIHBlci1wb3J0IGJ1dCBhbHNvIHdpbGRjYXJkZWQgZnJv
bSBzaGVsbCBzY3JpcHRzIGlmIG5lY2Vzc2FyeS4gDQpJIHRoaW5rIHRoZSBrZXkgcG9pbnQgaGVy
ZSBpcyB0aGF0IGl0IGRvZXNuJ3QgY2FyZSBhYm91dCB0aGUgR1BJTyBjaGlwcyANCmp1c3QgdGhl
IGluZGl2aWR1YWwgR1BJTyBsaW5lcy4gQW55dGhpbmcgaW52b2x2aW5nIGxpYmdwaW9kIGN1cnJl
bnRseSANCmhhcyB0byBzdGFydCBjYXJpbmcgYWJvdXQgR1BJTyBjaGlwcyAob3IgSSdtIG1pc3Jl
YWRpbmcgdGhlIGRvY3MpLg0KDQo+Pj4+IEknbSBzdXJlIGJvdGggb2YgdGhlc2UgYXBwbGljYXRp
b25zIGNvdWxkIGJlIHJlLXdyaXR0ZW4gYXJvdW5kIGxpYmdwaW9kDQo+Pj4+IGJ1dCB0aGF0IHdv
dWxkIGluY3VyIGEgc2lnbmlmaWNhbnQgYW1vdW50IG9mIHJlZ3Jlc3Npb24gdGVzdGluZyBvbg0K
Pj4+PiBleGlzdGluZyBwbGF0Zm9ybXMuIEFuZCBJIHN0aWxsIGNvbnNpZGVyIGRlYWxpbmcgd2l0
aCBHUElPIGNoaXBzIGFuDQo+Pj4+IGV4dHJhIGhlYWRhY2hlIHRoYXQgdGhlIGFwcGxpY2F0aW9u
cyBkb24ndCBuZWVkIChwYXJ0aWN1bGFybHkgd2l0aCB0aGUNCj4+Pj4gc2hlZXIgbnVtYmVyIG9m
IHRoZW0gdGhlIFNGUCBjYXNlKS4NCj4+PiBJdCBzZWVtcyB0byBtZSB0aGF0IGhhdmluZyBubyBp
bi1rZXJuZWwgZHJpdmVyIGZvciB5b3VyIHN0dWZmIGlzIHRoZQ0KPj4+IG1haW4gcG9pbnQgb2Yg
YWxsIGhlYWRhY2hlIGhlcmUuIEJ1dCBJIG1pZ2h0IGJlIG1pc3Rha2VuLg0KPj4gSXQgY2VydGFp
bmx5IGRvZXNuJ3QgaGVscCwgYnV0IEkgZG8gdGhpbmsgdGhhdCBpcyBhbGwgb3J0aG9nb25hbCB0
byB0aGUNCj4+IGZhY3QgdGhhdCBncGlvX2lzX3Zpc2libGUoKSBjaGFuZ2VzIHRoaW5ncyByYXRo
ZXIgdGhhbiBqdXN0IGRldGVybWluaW5nDQo+PiBpZiBhbiBhdHRyaWJ1dGUgc2hvdWxkIGJlIGV4
cG9ydGVkIG9yIG5vdC4NCj4gU29ycnkgZm9yIGJlaW5nIHVuaGVscGZ1bCBoZXJlLiBCdXQgd2l0
aG91dCB1bmRlcnN0YW5kaW5nIHRoZSBpc3N1ZSB3ZSBjYW4ndA0KPiBwcm9wb3NlIGJldHRlciBz
b2x1dGlvbnMuDQpObyBwcm9ibGVtLCB0aGlzIGlzIHByb2JhYmx5IHRoZSBtb3N0IGVuZ2FnZW1l
bnQgSSd2ZSBoYWQgb3V0IG9mIGEgTGludXggDQpwYXRjaCBzdWJtaXNzaW9uLiBIb3BlZnVsbHkg
aXQncyBub3QgdG9vIGFubm95aW5nIGZvciB0aG9zZSBvbiB0aGUgQ2MgbGlzdC4=
