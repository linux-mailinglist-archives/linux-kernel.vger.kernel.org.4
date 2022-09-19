Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3765BD5C0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiISUf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiISUfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:35:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76984422EE;
        Mon, 19 Sep 2022 13:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663619734;
        bh=/+kP9rMClMnsKcSoEfXWuweDzgcX2Kw+ngU9i330SUc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=DquKJmXoj3eWX1OjT7GepMMQQwmPRIOEBWwV6ED1N6jaSXlaPQuG3ZWsY2VoUgUsm
         EAJ60NcBMYdBbNRqPB6g6f57FXgkkqumSGwgxpC8h/zNBa227hrn4XIL4U9ABNvzDv
         fxPwKpZbQ9Nlgnl5eOqdFstVDRQVJn2m6dUNIpY4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXp5Q-1omRGU2oBQ-00YAhv; Mon, 19
 Sep 2022 22:35:34 +0200
Subject: Re: [PATCH 1/5] ACPI: battery: Do not unload battery hooks on single
 error
From:   Armin Wolf <W_Armin@gmx.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>, Len Brown <lenb@kernel.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Matan Ziv-Av <matan@svgalib.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Jeremy Soller <jeremy@system76.com>, productdev@system76.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220912125342.7395-1-W_Armin@gmx.de>
 <20220912125342.7395-2-W_Armin@gmx.de>
 <f8fa6d10-6eb1-7fa7-80eb-ea190d29ba4a@redhat.com>
 <CAJZ5v0jWVMMTjc+KtBRS86f8kYpbPcDCH9JV2ZgeN4f-MSO8rQ@mail.gmail.com>
 <f2af5d01-a2cd-ae96-24c7-d61f5f0d0bc3@gmx.de>
Message-ID: <f0b17ba6-3d3c-cbc1-ec0d-ec59c73f06f6@gmx.de>
Date:   Mon, 19 Sep 2022 22:35:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f2af5d01-a2cd-ae96-24c7-d61f5f0d0bc3@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: base64
Content-Language: en-US
X-Provags-ID: V03:K1:ruqWwzPKwO85xkBBLmbyTcUzY6sMsVpMZNxLfLi7MRiSoV3t3N/
 UY4xEuk6jvNVAto+rpUY680wtAvMCRT9EyWNrvTIgyVTokyoruqVsWbZmYp4PPpKH5qlMhQ
 a3v9HJLAFs2UggpVuIUa0Ekwp7nZl8wxg4ELAkH/6S/qpuAgm0aescD7p6W3YSqsu4ABPAB
 1a8W08KwwjjP624a/51/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tGTcBPSPyYk=:EH2d3fuqmPGQve1Sgzx44Z
 8XzURljy47gqYH2zYkTwyj0xOh1aepCX+4k5TO6/Gd73Pqrlryf5egsOFZqcNPF+JBxvF2VRl
 ggsD+hBd319Owwy8h1iO4b3+EtZuFVCHPgfN5zw+9K8pgOMRTNsNss81p1lGuY3j02xQRUkZd
 SxSxJRzbFO6iplFgKLp3bXvmQbMuDRlN3wV9zBChABq6UMZ/Raky9AzatI2dnZXmK/YpxsteJ
 tpEH7g5QNgBfmR/yrHht8rKIPzVJ6wvZBz9T5A3Gf8lLB7pMtoqLGAvsI6bGered3x6BkNnBe
 kyCQKqLhO1UlkItokmYk+DRFsgHv5yBTfx+4lsNdeXVKuskEahiKFQwx9FK+uPd1CVfNh+AEz
 Iad8354uCMqWpqX9Dl+7PWIWVY+AVImhd4jW3H3yHuMB53s0V/xwgcdLZ05UHNSkMUALgPiIb
 B+LC0xRn+01cVmtU1xlLkHXkHz/IuGdG0HHywizNBY77PalxOahRDLduBRekamSgUVTh01MRr
 +y7uA7/iz+ln+WvAEQiqs1HRIHg9IB5ay1lZmHW2ZN1kFHbXMn2MLmxJHjOVUDc0GYRSKKATn
 SlFrI2r7xmZ7TaAxR2dBvkt6k6uOKG5BBaDBhjKXON0yjo8z64F2+rImb5lOqZAHGPOugb4XD
 /rxZL3LSJd2aaETx62BpL8ged4vSuA7O1JGiK0CfFM/TOuds+FzQ2seya8aoZYc5BQPSbGyzm
 zmafvlf4IOQMfVmYFvDe0QQO4WGkGegJBRyRZiUTf4HFh3nv1FnMXaL5/lioVM68+fyLMAelb
 Qrdy8MEO+jUpSAeVJeuvL2ZudEVV1N6uStYsaQwKHzFoa4yo3YctDomIeAvv0JhX91tq3Ieou
 hau3mR37Azo4tkeFezUGU/fLVUPOtJsQn+yOZSexpXo5ntQf66hC2a2i10Jrf9pGQ8/fWG/q6
 riTx0T/PdDUlDZwK2MTeSC2HEIzPofB6R6N93oWXztnBxRYFO8CadZL4fIhVyLd9OzvUL9L/b
 KoXWCJAZ6kJBQuio69aj/47KNqxpCSKe2dcRrqjqv//dH2Az3rdafEVfkrTa2GtBsrb7SqtEq
 zSXalWauE0gWDVEwpHjNW5PBz+m1puAa0KIdfYSFCpeWV29YgAEoPCfyRLEd/4BoUccdL+Ur0
 UqiMxEL5hM9bMevECH5KAiGNjv
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMTkuMDkuMjIgdW0gMjE6MTIgc2NocmllYiBBcm1pbiBXb2xmOg0KDQo+IEFtIDE5LjA5LjIy
IHVtIDE4OjI3IHNjaHJpZWIgUmFmYWVsIEouIFd5c29ja2k6DQo+DQo+PiBPbiBNb24sIFNlcCAx
OSwgMjAyMiBhdCAxMjo0MiBQTSBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPiAN
Cj4+IHdyb3RlOg0KPj4+IEhpLA0KPj4+DQo+Pj4gT24gOS8xMi8yMiAxMzo1MywgQXJtaW4gV29s
ZiB3cm90ZToNCj4+Pj4gQ3VycmVudGx5LCBiYXR0ZXJ5IGhvb2tzIGFyZSBiZWluZyB1bmxvYWRl
ZCBpZiB0aGV5IHJldHVybg0KPj4+PiBhbiBlcnJvciB3aGVuIGFkZGluZyBhIHNpbmdsZSBiYXR0
ZXJ5Lg0KPj4+PiBUaGlzIGhvd2V2ZXIgYWxzbyBjYXVzZXMgdGhlIHJlbW92YWwgb2Ygc3VjY2Vz
c2Z1bGx5IGFkZGVkDQo+Pj4+IGhvb2tzIGlmIHRoZXkgcmV0dXJuIC1FTk9ERVYgZm9yIGEgc2lu
Z2xlIHVuc3VwcG9ydGVkDQo+Pj4+IGJhdHRlcnkuDQo+Pj4+DQo+Pj4+IERvIG5vdCB1bmxvYWQg
YmF0dGVyeSBob29rcyBpbiBzdWNoIGNhc2VzIHNpbmNlIHRoZSBob29rDQo+Pj4+IGhhbmRsZXMg
YW55IGNsZWFudXAgYWN0aW9ucy4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogQXJtaW4gV29s
ZiA8V19Bcm1pbkBnbXguZGU+DQo+Pj4gTWF5YmUgaW5zdGVhZCBvZiByZW1vdmluZyBhbGwgZXJy
b3IgY2hlY2tpbmcsIGFsbG93IC1FTk9ERVYNCj4+PiBhbmQgYmVoYXZlIGFzIGJlZm9yZSB3aGVu
IHRoZSBlcnJvciBpcyBub3QgLUVOT0RFViA/DQo+Pj4NCj4+PiBPdGhlcndpc2Ugd2Ugc2hvdWxk
IHByb2JhYmx5IG1ha2UgdGhlIGFkZCAvIHJlbW92ZSBjYWxsYmFja3MNCj4+PiB2b2lkIHRvIGlu
ZGljYXRlIHRoYXQgYW55IGVycm9ycyBhcmUgaWdub3JlZC4NCj4+Pg0KPj4+IFJhZmFlbCwgZG8g
eW91IGhhdmUgYW55IG9waW5pb24gb24gdGhpcz8NCj4+IElNViB0aGlzIGlzIG5vdCBhIGNvbXBs
ZXRlbHkgc2FmZSBjaGFuZ2UsIGJlY2F1c2UgdGhpbmdzIG1heSBzaW1wbHkNCj4+IG5vdCB3b3Jr
IGluIHRoZSBjYXNlcyBpbiB3aGljaCBhbiBlcnJvciBpcyByZXR1cm5lZC4NCj4+DQo+PiBJdCB3
b3VsZCBiZSBzb21ld2hhdCBiZXR0ZXIgdG8gdXNlIGEgc3BlY2lhbCBlcnJvciBjb2RlIHRvIGlu
ZGljYXRlDQo+PiAibm8gc3VwcG9ydCIgKGVnLiAtRU5PVFNVUFApIGFuZCBpZ25vcmUgdGhhdCBv
bmUgb25seS4NCj4NCj4gSSB3b3VsZCBmYXZvciAtRU5PREVWIHRoZW4sIHNpbmNlIGl0IGlzIGFs
cmVhZHkgdXNlZCBieSBxdWlldCBhIGZldyANCj4gZHJpdmVycw0KPiB0byBpbmRpY2F0ZSBhIHVu
c3VwcG9ydGVkIGJhdHRlcnkuDQo+DQo+IEFybWluIFdvbGYNCj4NCldoaWxlIGNoZWNraW5nIGFs
bCBpbnN0YW5jZXMgd2hlcmUgdGhlIGJhdHRlcnkgaG9vayBtZWNoYW5pc20gaXMgY3VycmVudGx5
IHVzZWQsDQppIGZvdW5kIG91dCB0aGF0IGFsbCBidXQgYSBzaW5nbGUgYmF0dGVyeSBob29rIHJl
dHVybiAtRU5PREVWIGZvciBhbGwgZXJyb3JzIHRoZXkNCmVuY291bnRlciwgdGhlIGV4Y2VwdGlv
biBiZWluZyB0aGUgaHVhd2VpLXdtaSBkcml2ZXIuDQoNCkkgZG8gbm90IGtub3cgdGhlIHJlYXNv
biBmb3IgdGhpcywgYnV0IGkgZmVhciB1bmxvYWRpbmcgdGhlIGV4dGVuc2lvbiBvbiBmb3INCmV4
YW1wbGUgLUVOT1RTVVAgd2lsbCByZXN1bHQgaW4gc2ltaWxhciBiZWhhdmlvciBieSBob29rcyB3
YW50aW5nIHRvIGF2b2lkIGJlaW5nDQp1bmxvYWRlZCBvbiBoYXJtbGVzcyBlcnJvcnMuDQoNCkhv
d2V2ZXIsIGkgYWdyZWUgdGhhdCB3aGVuIGlnbm9yaW5nIGFsbCBlcnJvcnMsIGJhdHRlcnkgZXh0
ZW5zaW9ucyB3aGljaCBwcm92aWRlDQpzaW1pbGFyIGF0dHJpYnV0ZXMgbWF5IGN1cnJlbnRseSBk
ZWxldGUgZWFjaCBvdGhlcnMgYXR0cmlidXRlcy4NCg0KQW55IGlkZWEgb24gaG93IHRvIHNvbHZl
IHRoaXM/DQoNCkFybWluIFdvbGYNCg0KPj4+PiAtLS0NCj4+Pj4gwqAgZHJpdmVycy9hY3BpL2Jh
dHRlcnkuYyB8IDI0ICsrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+PiDCoCAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvYWNwaS9iYXR0ZXJ5LmMgYi9kcml2ZXJzL2FjcGkvYmF0dGVyeS5jDQo+
Pj4+IGluZGV4IDMwNjUxM2ZlYzFlMS4uZTU5YzI2MWM3YzU5IDEwMDY0NA0KPj4+PiAtLS0gYS9k
cml2ZXJzL2FjcGkvYmF0dGVyeS5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvYWNwaS9iYXR0ZXJ5LmMN
Cj4+Pj4gQEAgLTcyNCwyMCArNzI0LDEwIEBAIHZvaWQgYmF0dGVyeV9ob29rX3JlZ2lzdGVyKHN0
cnVjdCANCj4+Pj4gYWNwaV9iYXR0ZXJ5X2hvb2sgKmhvb2spDQo+Pj4+IMKgwqDCoMKgwqDCoMKg
ICogaXRzIGF0dHJpYnV0ZXMuDQo+Pj4+IMKgwqDCoMKgwqDCoMKgICovDQo+Pj4+IMKgwqDCoMKg
wqDCoCBsaXN0X2Zvcl9lYWNoX2VudHJ5KGJhdHRlcnksICZhY3BpX2JhdHRlcnlfbGlzdCwgbGlz
dCkgew0KPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChob29rLT5hZGRfYmF0dGVy
eShiYXR0ZXJ5LT5iYXQpKSB7DQo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC8qDQo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKiBJZiBhIGFkZC1iYXR0ZXJ5IHJldHVybnMgbm9uLXplcm8sDQo+Pj4+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB0aGUgcmVnaXN0cmF0aW9uIG9m
IHRoZSBleHRlbnNpb24gaGFzIGZhaWxlZCwNCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqIGFuZCB3ZSB3aWxsIG5vdCBhZGQgaXQgdG8gdGhlIGxpc3Qg
b2YgbG9hZGVkDQo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKiBob29rcy4NCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqLw0KPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBw
cl9lcnIoImV4dGVuc2lvbiBmYWlsZWQgdG8gbG9hZDogJXMiLCANCj4+Pj4gaG9vay0+bmFtZSk7
DQo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fYmF0dGVy
eV9ob29rX3VucmVnaXN0ZXIoaG9vaywgMCk7DQo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZW5kOw0KPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIH0NCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBob29rLT5hZGRfYmF0dGVyeShi
YXR0ZXJ5LT5iYXQpOw0KPj4+PiDCoMKgwqDCoMKgwqAgfQ0KPj4+PiDCoMKgwqDCoMKgwqAgcHJf
aW5mbygibmV3IGV4dGVuc2lvbjogJXNcbiIsIGhvb2stPm5hbWUpOw0KPj4+PiAtZW5kOg0KPj4+
PiArDQo+Pj4+IMKgwqDCoMKgwqDCoCBtdXRleF91bmxvY2soJmhvb2tfbXV0ZXgpOw0KPj4+PiDC
oCB9DQo+Pj4+IMKgIEVYUE9SVF9TWU1CT0xfR1BMKGJhdHRlcnlfaG9va19yZWdpc3Rlcik7DQo+
Pj4+IEBAIC03NjIsMTUgKzc1Miw3IEBAIHN0YXRpYyB2b2lkIGJhdHRlcnlfaG9va19hZGRfYmF0
dGVyeShzdHJ1Y3QgDQo+Pj4+IGFjcGlfYmF0dGVyeSAqYmF0dGVyeSkNCj4+Pj4gwqDCoMKgwqDC
oMKgwqAgKiBkdXJpbmcgdGhlIGJhdHRlcnkgbW9kdWxlIGluaXRpYWxpemF0aW9uLg0KPj4+PiDC
oMKgwqDCoMKgwqDCoCAqLw0KPj4+PiDCoMKgwqDCoMKgwqAgbGlzdF9mb3JfZWFjaF9lbnRyeV9z
YWZlKGhvb2tfbm9kZSwgdG1wLCAmYmF0dGVyeV9ob29rX2xpc3QsIA0KPj4+PiBsaXN0KSB7DQo+
Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGhvb2tfbm9kZS0+YWRkX2JhdHRlcnko
YmF0dGVyeS0+YmF0KSkgew0KPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAvKg0KPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICogVGhlIG5vdGlmaWNhdGlvbiBvZiB0aGUgZXh0ZW5zaW9ucyBoYXMgDQo+Pj4+IGZhaWxl
ZCwgdG8NCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAq
IHByZXZlbnQgZnVydGhlciBlcnJvcnMgd2Ugd2lsbCB1bmxvYWQgdGhlIA0KPj4+PiBleHRlbnNp
b24uDQo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8N
Cj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfZXJyKCJl
cnJvciBpbiBleHRlbnNpb24sIHVubG9hZGluZzogJXMiLA0KPj4+PiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGhvb2tfbm9kZS0+bmFtZSk7DQo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIF9fYmF0dGVyeV9ob29rX3VucmVnaXN0ZXIoaG9va19ub2RlLCAwKTsNCj4+Pj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaG9va19ub2RlLT5hZGRfYmF0dGVyeShiYXR0ZXJ5LT5iYXQpOw0KPj4+PiDCoMKgwqDCoMKg
wqAgfQ0KPj4+PiDCoMKgwqDCoMKgwqAgbXV0ZXhfdW5sb2NrKCZob29rX211dGV4KTsNCj4+Pj4g
wqAgfQ0KPj4+PiAtLSANCj4+Pj4gMi4zMC4yDQo+Pj4+DQo=
