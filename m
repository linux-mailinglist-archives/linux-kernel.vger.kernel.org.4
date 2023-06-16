Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D48732B25
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245558AbjFPJKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344261AbjFPJJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:09:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C17735A0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:08:28 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-25-AX0ny6iUOu2l40pxf4kpiA-1; Fri, 16 Jun 2023 10:08:25 +0100
X-MC-Unique: AX0ny6iUOu2l40pxf4kpiA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 16 Jun
 2023 10:08:22 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 16 Jun 2023 10:08:22 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Herve Codina' <herve.codina@bootlin.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: RE: [PATCH v4 07/13] minmax: Introduce {min,max}_array()
Thread-Topic: [PATCH v4 07/13] minmax: Introduce {min,max}_array()
Thread-Index: AQHZn2z+IMzVucn/mECJ0o8xQC0QeK+NI4Pg
Date:   Fri, 16 Jun 2023 09:08:22 +0000
Message-ID: <6c7fe34f7b65421ab618d33ba907ae09@AcuMS.aculab.com>
References: <20230614074904.29085-1-herve.codina@bootlin.com>
        <20230614074904.29085-8-herve.codina@bootlin.com>
        <CAHp75Vcur=H_2mBm5Ztuvd7Jnvmr6+tvCbEkFtmaVLsEjXr8NQ@mail.gmail.com>
        <20230614114214.1371485e@bootlin.com>
        <CAHp75VcmW2StPqb_LtKFyNyJ2+jz3c19zNRDiSuGs06Bseq04w@mail.gmail.com>
        <20230614223418.0d7e355d@bootlin.com>
        <CAHp75VfFyDzr4qHNssXZ8RLy0gxMWdjBgac4JLd7grRLEG-vyw@mail.gmail.com>
 <20230615113512.07967677@bootlin.com>
In-Reply-To: <20230615113512.07967677@bootlin.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSGVydmUgQ29kaW5hDQo+IFNlbnQ6IDE1IEp1bmUgMjAyMyAxMDozNQ0KPiA+IC4uLg0K
PiA+DQo+ID4gPiA+ID4gPiA+ICsgICAgICAgdHlwZW9mKF9fYXJyYXlbMF0gKyAwKSBfX2VsZW1l
bnQgPSBfX2FycmF5Wy0tX19sZW5dOyAgICBcDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gRG8g
d2UgbmVlZCB0aGUgJyArIDAnIHBhcnQ/DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBZZXMuDQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBfX2FycmF5IGNhbiBiZSBhbiBhcnJheSBvZiBjb25zdCBpdGVtcyBh
bmQgaXQgaXMgbGVnaXRpbWF0ZSB0byBnZXQgdGhlDQo+ID4gPiA+ID4gbWluaW11bSB2YWx1ZSBm
cm9tIGNvbnN0IGl0ZW1zLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gdHlwZW9mKF9fYXJyYXlbMF0p
IGtlZXBzIHRoZSBjb25zdCBxdWFsaWZpZXIgYnV0IHdlIG5lZWQgdG8gYXNzaWduIF9fZWxlbWVu
dA0KPiA+ID4gPiA+IGluIHRoZSBsb29wLg0KPiA+ID4gPiA+IE9uZSB3YXkgdG8gZHJvcCB0aGUg
Y29uc3QgcXVhbGlmaWVyIGlzIHRvIGdldCB0aGUgdHlwZSBmcm9tIGEgcnZhbHVlIGNvbXB1dGVk
DQo+ID4gPiA+ID4gZnJvbSBfX2FycmF5WzBdLiBUaGlzIHJ2YWx1ZSBoYXMgdG8gaGF2ZSB0aGUg
ZXhhY3Qgc2FtZSB0eXBlIHdpdGggb25seSB0aGUgY29uc3QNCj4gPiA+ID4gPiBkcm9wcGVkLg0K
PiA+ID4gPiA+ICdfX2FycmF5WzBdICsgMCcgd2FzIGEgcGVyZmVjdCBjYW5kaXRhdGUuDQo+ID4g
PiA+DQo+ID4gPiA+IFNlZW1zIGxpa2UgdGhpcyBhbHNvIGRlc2VydmVzIGEgY29tbWVudC4gQnV0
IGlmIHRoZSBzZXJpZXMgaXMgYWNjZXB0ZWQNCj4gPiA+ID4gYXMgaXMsIGl0IG1heSBiZSBkb25l
IGFzIGEgZm9sbG93IHVwLg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IEZpbmFsbHkgbm90IHNvIHNp
bXBsZSAuLi4NCj4gPiA+IEkgZGlkIHNvbWUgZGVlcGVyIHRlc3RzIGFuZCB0aGUgbWFjcm9zIG5l
ZWQgdG8gYmUgZml4ZWQuDQo+ID4gPg0KPiA+ID4gSSBob3BlIHRoaXMgb25lICh3aXRoIGNvbW1l
bnRzIGFkZGVkKSBpcyBjb3JyZWN0Og0KPiA+ID4gLS0tIDggLS0tDQo+ID4gPiAvKg0KPiA+ID4g
ICogRG8gbm90IGNoZWNrIHRoZSBhcnJheSBwYXJhbWV0ZXIgdXNpbmcgX19tdXN0X2JlX2FycmF5
KCkuDQo+ID4gPiAgKiBJbiB0aGUgZm9sbG93aW5nIGxlZ2l0IHVzZS1jYXNlIHdoZXJlIHRoZSAi
YXJyYXkiIHBhc3NlZCBpcyBhIHNpbXBsZSBwb2ludGVyLA0KPiA+ID4gICogX19tdXN0X2JlX2Fy
cmF5KCkgd2lsbCByZXR1cm4gYSBmYWlsdXJlLg0KPiA+ID4gICogLS0tIDg8IC0tLQ0KPiA+ID4g
ICogaW50ICpidWZmDQo+ID4gPiAgKiAuLi4NCj4gPiA+ICAqIG1pbiA9IG1pbl9hcnJheShidWZm
LCBuYl9pdGVtcyk7DQo+ID4gPiAgKiAtLS0gODwgLS0tDQo+ID4gPiAgKg0KPiA+ID4gICogVGhl
IGZpcnN0IHR5cGVvZigmKGFycmF5KVswXSkgaXMgbmVlZGVkIGluIG9yZGVyIHRvIHN1cHBvcnQg
YXJyYXlzIG9mIGJvdGgNCj4gPiA+ICAqICdpbnQgKmJ1ZmYnIGFuZCAnaW50IGJ1ZltOXScgdHlw
ZXMuDQo+ID4gPiAgKg0KPiA+ID4gICogdHlwZW9mKF9fYXJyYXlbMF0gKyAwKSB1c2VkIGZvciBf
X2VsZW1lbnQgaXMgbmVlZGVkIGFzIHRoZSBhcnJheSBjYW4gYmUgYW4NCj4gPiA+ICAqIGFycmF5
IG9mIGNvbnN0IGl0ZW1zLg0KPiA+ID4gICogSW4gb3JkZXIgdG8gZGlzY2FyZCB0aGUgY29uc3Qg
cXVhbGlmaWVyIHVzZSBhbiBhcml0aG1ldGljIG9wZXJhdGlvbiAocnZhbHVlKS4NCj4gPg0KPiA+
DQo+ID4gPiAgKiBUaGlzIGFyaXRobWV0aWMgb3BlcmF0aW9uIGRpc2NhcmQgdGhlIGNvbnN0IGJ1
dCBhbHNvIGNhbiBsZWFkIHRvIGFuIGludGVnZXINCj4gPg0KPiA+IGRpc2NhcmRzDQo+ID4NCj4g
PiA+ICAqIHByb21vdGlvbi4gRm9yIGluc3RhbmNlLCBhIGNvbnN0IHM4IF9fYXJyYXlbMF0gbGVh
ZCB0byBhbiBpbnQgX19lbGVtZW50IGR1ZQ0KPiA+DQo+ID4gbGVhZHMNCj4gPg0KPiA+ID4gICog
dG8gdGhlIHByb21vdGlvbi4NCj4gPiA+ICAqIEluIHRoaXMgY2FzZSwgc2ltcGxlIG1pbigpIG9y
IG1heCgpIG9wZXJhdGlvbiBmYWlscyAodHlwZSBtaXNtYXRjaCkuDQo+ID4gPiAgKiBVc2UgbWlu
X3QoKSBvciBtYXhfdCgpIChvcF90IHBhcmFtZXRlcikgZW5mb3JjaW5nIHRoZSB0eXBlIGluIG9y
ZGVyIHRvIGF2b2lkDQo+ID4gPiAgKiB0aGUgbWluKCkgb3IgbWF4KCkgZmFpbHVyZS4NCj4gPg0K
PiA+IFRoaXMgcGFydCBwZXJoYXBzIGNhbiBiZSBhdm9pZGVkLiBTZWUgYmVsb3cuDQo+ID4NCj4g
PiA+ICAqLw0KPiA+ID4gI2RlZmluZSBfX21pbm1heF9hcnJheShvcF90LCBhcnJheSwgbGVuKSAo
eyAgICAgICAgICAgICAgICAgICAgIFwNCj4gPiA+ICAgICAgICAgdHlwZW9mKCYoYXJyYXkpWzBd
KSBfX2FycmF5ID0gKGFycmF5KTsgICAgICAgICAgICAgICAgICBcDQo+ID4gPiAgICAgICAgIHR5
cGVvZihsZW4pIF9fbGVuID0gKGxlbik7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0K
PiA+ID4gICAgICAgICB0eXBlb2YoX19hcnJheVswXSArIDApIF9fZWxlbWVudCA9IF9fYXJyYXlb
LS1fX2xlbl07ICAgIFwNCj4gPiA+ICAgICAgICAgd2hpbGUgKF9fbGVuLS0pICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ID4gPiAgICAgICAgICAgICAgICAgX19l
bGVtZW50ID0gb3BfdCh0eXBlb2YoX19hcnJheVswXSksIF9fZWxlbWVudCwgX19hcnJheVtfX2xl
bl0pOyBcDQo+ID4NCj4gPiBCdXQgY2FuJ3Qgd2UgaW5zdGVhZCBoYXZlIHR5cGVvZigrKGFycmF5
WzBdKSkgaW4gdGhlIGRlZmluaXRpb24gb2YgX19lbGVtZW50Pw0KPiA+IFRoZXJlIGFyZSBhbHNv
IG90aGVyIHBvc3NpYmxlIHNvbHV0aW9uczogYSkgX0dlbmVyaWMoKSB3aXRoIGxpc3RlZA0KPiA+
IGNvbnN0IHR5cGVzIHRvIG1vdmUgdGhlbSB0byBub24tY29uc3QsIGFuZCBiKSBfX2F1dG9fdHlw
ZSAod2hpY2ggaXMNCj4gPiBzdXBwb3J0ZWQgYnkgR0NDIDQuOSBhbmQgY2xhbmcsIGJ1dCBub3Qg
aW4gdGhlIEMxMSBzdGFuZGFyZCkuDQo+IA0KPiB0eXBlb2YoKyhhcnJheVswXSkpIGtlZXBzIHRo
ZSBwcm9tb3Rpb24uDQo+IA0KPiBfX2F1dG9fdHlwZSB3b3JrcyB3aXRoIG15IGdjYy0xMiBidXQg
bm90IHdpdGggYSBnY2MtNS41LiBEZXBlbmRpbmcgb24gdGhlDQo+IGNvbXBpbGVyIHZlcnNpb24s
IGl0IGRpc2NhcmRzIG9yIGtlZXBzIHRoZSBjb25zdCBxdWFsaWZpZXIuIEZvciB0aGlzIHJlYXNv
bg0KPiBJIHdvdWxkIHByZWZlciB0byBub3QgdXNlIGl0Lg0KDQpKdXN0IGRlZmluZSB0d28gdmFy
aWFibGVzIHR5cGVvZihfX2FycmF5WzBdICsgMCkgb25lIGZvciBhbiBlbGVtZW50DQphbmQgb25l
IGZvciB0aGUgbGltaXQuDQpUaGUganVzdCB0ZXN0IChlZyk6DQoJaWYgKGxpbWl0ID4gaXRlbSkg
bGltaXQgPSBpdGVtOw0KZmluYWxseSBjYXN0IHRoZSBsaW1pdCBiYWNrIHRvIHRoZSBvcmlnaW5h
bCB0eXBlLg0KVGhlIHByb21vdGlvbnMgb2YgY2hhci9zaG9ydCB0byBzaWduZWQgaW50IHdvbid0
IG1hdHRlci4NClRoZXJlIGlzIG5vIG5lZWQgZm9yIGFsbCB0aGUgdHlwZS1jaGVja2luZyBpbiBt
aW4vbWF4Lg0KDQpJbmRlZWQsIGlmIG1pbl90KHR5cGUsIGEsIGIpIGlzIGluIGFueXdheSBzYW5l
IGl0IHNob3VsZA0KZXhwYW5kIHRvOg0KCXR5cGUgX2EgPSBhLCBfYiA9IGI7DQoJX2EgPCBfYiA/
IF9hIDogX2INCndpdGhvdXQgYW55IG9mIHRoZSBjaGVja3MgdGhhdCBtaW4oKSBkb2VzLg0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K

