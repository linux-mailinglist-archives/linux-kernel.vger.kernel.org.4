Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF99618B9F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiKCWfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKCWfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:35:14 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450651FCE7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 15:35:13 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-108-jjXBwe61OA2r_dWCY7x20Q-1; Thu, 03 Nov 2022 22:35:10 +0000
X-MC-Unique: jjXBwe61OA2r_dWCY7x20Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 3 Nov
 2022 22:35:09 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Thu, 3 Nov 2022 22:35:09 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'AngeloGioacchino Del Regno' 
        <angelogioacchino.delregno@collabora.com>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Mark Brown <broonie@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: RE: [PATCH v1] spi: spi-mtk-nor: Optimize timeout for dma read
Thread-Topic: [PATCH v1] spi: spi-mtk-nor: Optimize timeout for dma read
Thread-Index: AQHY72jIBAhQmgXzVUCnGozhoMFIG64tyFhQ
Date:   Thu, 3 Nov 2022 22:35:09 +0000
Message-ID: <c612cc0eb4fc463a9bfd9094ff652ac9@AcuMS.aculab.com>
References: <20221103052843.2025-1-bayi.cheng@mediatek.com>
 <20221103052843.2025-2-bayi.cheng@mediatek.com>
 <10529948-a9b8-2121-7adb-0e94cf3cbf6a@collabora.com>
In-Reply-To: <10529948-a9b8-2121-7adb-0e94cf3cbf6a@collabora.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8NCj4gU2VudDogMDMgTm92ZW1iZXIgMjAy
MiAwOTo0NA0KPiANCj4gSWwgMDMvMTEvMjIgMDY6MjgsIEJheWkgQ2hlbmcgaGEgc2NyaXR0bzoN
Cj4gPiBGcm9tOiBiYXlpIGNoZW5nIDxiYXlpLmNoZW5nQG1lZGlhdGVrLmNvbT4NCj4gPg0KPiA+
IFRoZSB0aW1lb3V0IHZhbHVlIG9mIHRoZSBjdXJyZW50IGRtYSByZWFkIGlzIHVucmVhc29uYWJs
ZS4gRm9yIGV4YW1wbGUsDQo+ID4gSWYgdGhlIHNwaSBmbGFzaCBjbG9jayBpcyAyNk1oeiwgSXQg
d2lsbCB0YWtlcyBhYm91dCAxLjNtcyB0byByZWFkIGENCj4gPiA0S0IgZGF0YSBpbiBzcGkgbW9k
ZS4gQnV0IHRoZSBhY3R1YWwgbWVhc3VyZW1lbnQgZXhjZWVkcyA1MHMgd2hlbiBhDQo+ID4gZG1h
IHJlYWQgdGltZW91dCBpcyBlbmNvdW50ZXJlZC4NCj4gPg0KPiA+IEluIG9yZGVyIHRvIGJlIG1v
cmUgYWNjdXJhdGVseSwgSXQgaXMgbmVjZXNzYXJ5IHRvIHVzZSBtc2Vjc190b19qaWZmaWVzLA0K
PiA+IEFmdGVyIG1vZGlmaWNhdGlvbiwgdGhlIG1lYXN1cmVkIHRpbWVvdXQgdmFsdWUgaXMgYWJv
dXQgMTMwbXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBiYXlpIGNoZW5nIDxiYXlpLmNoZW5n
QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvc3BpL3NwaS1tdGstbm9yLmMg
fCA3ICsrKystLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLW10ay1ub3Iu
YyBiL2RyaXZlcnMvc3BpL3NwaS1tdGstbm9yLmMNCj4gPiBpbmRleCBkMTY3Njk5YTFhOTYuLjNk
OTg5ZGI4MGVlOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktbXRrLW5vci5jDQo+
ID4gKysrIGIvZHJpdmVycy9zcGkvc3BpLW10ay1ub3IuYw0KPiA+IEBAIC0zNTQsNyArMzU0LDcg
QEAgc3RhdGljIGludCBtdGtfbm9yX2RtYV9leGVjKHN0cnVjdCBtdGtfbm9yICpzcCwgdTMyIGZy
b20sIHVuc2lnbmVkIGludCBsZW5ndGgsDQo+ID4gICAJCQkgICAgZG1hX2FkZHJfdCBkbWFfYWRk
cikNCj4gPiAgIHsNCj4gPiAgIAlpbnQgcmV0ID0gMDsNCj4gPiAtCXVsb25nIGRlbGF5Ow0KPiA+
ICsJdWxvbmcgZGVsYXksIHRpbWVvdXQ7DQo+ID4gICAJdTMyIHJlZzsNCj4gPg0KPiA+ICAgCXdy
aXRlbChmcm9tLCBzcC0+YmFzZSArIE1US19OT1JfUkVHX0RNQV9GQURSKTsNCj4gPiBAQCAtMzc2
LDE1ICszNzYsMTYgQEAgc3RhdGljIGludCBtdGtfbm9yX2RtYV9leGVjKHN0cnVjdCBtdGtfbm9y
ICpzcCwgdTMyIGZyb20sIHVuc2lnbmVkIGludCBsZW5ndGgsDQo+ID4gICAJbXRrX25vcl9ybXco
c3AsIE1US19OT1JfUkVHX0RNQV9DVEwsIE1US19OT1JfRE1BX1NUQVJULCAwKTsNCj4gPg0KPiA+
ICAgCWRlbGF5ID0gQ0xLX1RPX1VTKHNwLCAobGVuZ3RoICsgNSkgKiBCSVRTX1BFUl9CWVRFKTsN
Cj4gPiArCXRpbWVvdXQgPSAoZGVsYXkgKyAxKSAqIDEwMDsNCj4gPg0KPiA+ICAgCWlmIChzcC0+
aGFzX2lycSkgew0KPiA+ICAgCQlpZiAoIXdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmc3At
Pm9wX2RvbmUsDQo+ID4gLQkJCQkJCSAoZGVsYXkgKyAxKSAqIDEwMCkpDQo+ID4gKwkJICAgIG1z
ZWNzX3RvX2ppZmZpZXMobWF4X3Qoc2l6ZV90LCB0aW1lb3V0IC8gMTAwMCwgMTApKSkpDQo+IA0K
PiBZb3UncmUgZ2l2aW5nIGEgYHNpemVfdGAgdmFyaWFibGUgdG8gbXNlY3NfdG9famlmZmllcygp
LCBidXQgY2hlY2tpbmcgYGppZmZpZXMuaGAsDQo+IHRoaXMgZnVuY3Rpb24gdGFrZXMgYSBgY29u
c3QgdW5zaWduZWQgaW50YCBwYXJhbS4NCj4gUGxlYXNlIGNoYW5nZSB0aGUgdHlwZSB0byBtYXRj
aCB0aGF0Lg0KDQpUaGUgdHlwZSBzaG91bGRuJ3QgbWF0dGVyIGF0IGFsbC4NCldoYXQgbWF0dGVy
cyBpcyB0aGUgZG9tYWluIG9mIHRoZSB2YWx1ZS4NCg0KUXVpdGUgd2h5IHlvdSBuZWVkIHRvIHVz
ZSBtYXhfdChzaXplX3QsIC4uLikgaXMgYW5vdGhlciBtYXR0ZXIuDQp0aW1lb3V0IGlzIHVsb25n
IHNvIG1heCh0aW1lb3V0LzEwMDAsIDEwdWwpIHNob3VsZCBiZSBmaW5lLg0KDQpCdXQgaXMgdWxv
bmcgZXZlbiByaWdodD8NClRoZSBkb21haW4gb2YgdGhlIHZhbHVlIGlzIGFsbW9zdCBjZXJ0YWlu
bHkgdGhlIHNhbWUgb24gMzJiaXQgYW5kIDY0Yml0Lg0KU28geW91IGFsbW9zdCBjZXJ0YWlubHkg
bmVlZCB1MzIgb3IgdTY0Lg0KDQoJRGF2aWQNCg0KPiANCj4gQXNpZGUgZnJvbSB0aGF0LCB5b3Vy
IGB0aW1lb3V0YCB2YXJpYWJsZSBjb250YWlucyBhIHRpbWVvdXQgaW4gbWljcm9zZWNvbmRzIGFu
ZA0KPiB0aGlzIG1lYW5zIHRoYXQgYWN0dWFsbHkgdXNpbmcgbXNlY3NfdG9famlmZmllcygpIGlz
IHN1Ym9wdGltYWwgaGVyZS4NCj4gDQo+IFBsZWFzZSB1c2UgdXNlY3NfdG9famlmZmllcygpIGlu
c3RlYWQuDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

