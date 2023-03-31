Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0316D1B02
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjCaI7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjCaI64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:58:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D62B93D8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:58:49 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-244-VN9U7afANy2G9I0ztqm7nA-1; Fri, 31 Mar 2023 09:58:44 +0100
X-MC-Unique: VN9U7afANy2G9I0ztqm7nA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 31 Mar
 2023 09:58:43 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 31 Mar 2023 09:58:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        Jiangshan Yi <yijiangshan@kylinos.cn>
CC:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "13667453960@163.com" <13667453960@163.com>
Subject: RE: [PATCH] ACPI: thermal: replace ternary operator with min_t()
Thread-Topic: [PATCH] ACPI: thermal: replace ternary operator with min_t()
Thread-Index: AQHZYyq+oyUap8XuYUy0mbivn7h4t68UlpOA
Date:   Fri, 31 Mar 2023 08:58:42 +0000
Message-ID: <8781eb11ce42448aa9cd206168cb22db@AcuMS.aculab.com>
References: <20230328031629.202268-1-yijiangshan@kylinos.cn>
 <CAJZ5v0hPbH9BMOLbrGOKcy1sGAXbq=7OTyFECA966i37wBp_AQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hPbH9BMOLbrGOKcy1sGAXbq=7OTyFECA966i37wBp_AQ@mail.gmail.com>
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
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUmFmYWVsIEouIFd5c29ja2kNCj4gU2VudDogMzAgTWFyY2ggMjAyMyAxODoxMg0KPiAN
Cj4gT24gVHVlLCBNYXIgMjgsIDIwMjMgYXQgNToxN+KAr0FNIEppYW5nc2hhbiBZaSA8eWlqaWFu
Z3NoYW5Aa3lsaW5vcy5jbj4gd3JvdGU6DQo+ID4NCj4gPiBGaXggdGhlIGZvbGxvd2luZyBjb2Nj
aWNoZWNrIHdhcm5pbmc6DQo+IA0KPiBUaGlzIGlzIG5vdCBhIGZpeCwgYmVjYXVzZSB0aGUgY3Vy
cmVudCBjb2RlIGlzIGNvcnJlY3QgQUZBSUNTLg0KPiANCj4gSXQgbWVyZWx5IG1ha2VzIHRoZSBj
b2RlIGZvbGxvdyB0aGUgY29jY2ljaGVjayByZWNvbW1lbmRhdGlvbiwgd2hpY2gNCj4gaXMgYSBj
bGVhbnVwIChhbHRob3VnaCBhcmd1YWJseSBhIGdvb2Qgb25lKS4NCj4gDQo+IEJ1dCBiZWNhdXNl
IHRoZSBuZXcgY29kZSBpcyB3YXkgbW9yZSByZWFkYWJsZSwgSSd2ZSBhcHBsaWVkIHRoaXMgYXMN
Cj4gNi40IG1hdGVyaWFsICh3aXRoIGVkaXRzIGluIHRoZSBjaGFuZ2Vsb2cpLg0KDQpBbHNvIGlm
IHlvdSBuZWVkIHRvIHVzZSBtaW5fdCgpIHRoZXJlIGlzIHJlYWxseSBzb21ldGhpbmcgd3JvbmcN
CndpdGggeW91ciB0eXBlcy4NCg0KPiA+IGRyaXZlcnMvYWNwaS90aGVybWFsLmM6NDIyOiBXQVJO
SU5HIG9wcG9ydHVuaXR5IGZvciBtaW4oKS4NCj4gPg0KPiA+IG1pbl90KCkgbWFjcm8gaXMgZGVm
aW5lZCBpbiBpbmNsdWRlL2xpbnV4L21pbm1heC5oLiBJdCBhdm9pZHMgbXVsdGlwbGUNCj4gPiBl
dmFsdWF0aW9ucyBvZiB0aGUgYXJndW1lbnRzIHdoZW4gbm9uLWNvbnN0YW50IGFuZCBwZXJmb3Jt
cyBzdHJpY3QNCj4gPiB0eXBlLWNoZWNraW5nLg0KDQptaW5fdCgpIGNhc3RzIHRoZSBhcmd1bWVu
dHMgYW5kIHBlcmZvcm1zIGFic29sdXRlbHkgbm8gdHlwZS1jaGVja2luZy4NClRoZSBjYXN0cyBj
YW4gZXZlbiBtYXNrIG9mZiBoaWdoIGJpdHMgdGhhdCBvdWdodCB0byBiZSBjaGVja2VkLg0KDQoJ
RGF2aWQNCg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhbmdzaGFuIFlpIDx5aWppYW5nc2hh
bkBreWxpbm9zLmNuPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2FjcGkvdGhlcm1hbC5jIHwgNyAr
KystLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3RoZXJtYWwuYyBiL2RyaXZl
cnMvYWNwaS90aGVybWFsLmMNCj4gPiBpbmRleCAwYjRiODQ0ZjlkNGMuLjE3OWY0MTE5NmE5ZCAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2FjcGkvdGhlcm1hbC5jDQo+ID4gKysrIGIvZHJpdmVy
cy9hY3BpL3RoZXJtYWwuYw0KPiA+IEBAIC00MTksMTAgKzQxOSw5IEBAIHN0YXRpYyBpbnQgYWNw
aV90aGVybWFsX3RyaXBzX3VwZGF0ZShzdHJ1Y3QgYWNwaV90aGVybWFsICp0eiwgaW50IGZsYWcp
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIHRoZSBuZXh0
IGhpZ2hlciB0cmlwIHBvaW50DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAqLw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0
ei0+dHJpcHMuYWN0aXZlW2ktMV0udGVtcGVyYXR1cmUgPQ0KPiA+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICh0ei0+dHJpcHMuYWN0aXZlW2ktMl0udGVt
cGVyYXR1cmUgPA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGNlbHNpdXNfdG9fZGVjaV9rZWx2aW4oYWN0KSA/DQo+ID4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHotPnRyaXBzLmFjdGl2ZVtpLTJdLnRl
bXBlcmF0dXJlIDoNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjZWxzaXVzX3RvX2RlY2lfa2VsdmluKGFjdCkpOw0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1pbl90KHVuc2lnbmVkIGxvbmcsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dHotPnRyaXBzLmFjdGl2ZVtpLTJdLnRlbXBlcmF0dXJlLA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNlbHNpdXNfdG9fZGVjaV9rZWx2
aW4oYWN0KSk7DQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFr
Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+ID4gLS0NCj4gPiAyLjI1
LjENCj4gPg0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzog
MTM5NzM4NiAoV2FsZXMpDQo=

