Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2550568F099
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjBHOT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjBHOTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:19:33 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14DD4671E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 06:19:31 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-262-H5cJoUZoPCauX5L41XFgjQ-1; Wed, 08 Feb 2023 14:19:28 +0000
X-MC-Unique: H5cJoUZoPCauX5L41XFgjQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Wed, 8 Feb
 2023 14:19:27 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Wed, 8 Feb 2023 14:19:27 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'WANG Xuerui' <kernel@xen0n.name>,
        'Bibo Mao' <maobibo@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
CC:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] LoongArch: add checksum optimization for 64-bit system
Thread-Topic: [PATCH] LoongArch: add checksum optimization for 64-bit system
Thread-Index: AQHZOqjw3I588J9fP0akyPjC04Hova7FBpIAgAAMDwCAAAcXoA==
Date:   Wed, 8 Feb 2023 14:19:27 +0000
Message-ID: <7636a7bebfd44e378c5b16d6fd355232@AcuMS.aculab.com>
References: <20230207040148.1801169-1-maobibo@loongson.cn>
 <8fa91bca5e624861b190917933951c7e@AcuMS.aculab.com>
 <5b3c9b61-7fd5-f50c-32ba-e857090b71bc@xen0n.name>
In-Reply-To: <5b3c9b61-7fd5-f50c-32ba-e857090b71bc@xen0n.name>
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

RnJvbTogV0FORyBYdWVydWkNCj4gU2VudDogMDggRmVicnVhcnkgMjAyMyAxMzo0OA0KLi4uDQo+
IFllYWggTG9vbmdBcmNoIGNhbiBkbyByb3RhdGVzLCBhbmQgeW91ciBzdWdnZXN0aW9uIGNhbiBp
bmRlZWQgcmVkdWNlIG9uZQ0KPiBpbnNuIGZyb20gZXZlcnkgaW52b2NhdGlvbiBvZiBjc3VtX2Zv
bGQuDQo+IA0KPiAgRnJvbSB0aGlzOg0KPiANCj4gMDAwMDAwMDAwMDAwMDk2YyA8Y3N1bV9mb2xk
PjoNCj4gICAgICAgICAgc3VtICs9IChzdW0gPj4gMTYpIHwgKHN1bSA8PCAxNik7DQo+ICAgOTZj
OiAgIDAwNGNjMDhjICAgICAgICByb3RyaS53ICAgICAgICAgJHQwLCAkYTAsIDB4MTANCj4gICA5
NzA6ICAgMDAxMDExODQgICAgICAgIGFkZC53ICAgICAgICAgICAkYTAsICR0MCwgJGEwDQo+ICAg
ICAgICAgIHJldHVybiB+KF9fZm9yY2UgX19zdW0xNikoc3VtID4+IDE2KTsNCj4gICA5NzQ6ICAg
MDA0NGMwODQgICAgICAgIHNybGkudyAgICAgICAgICAkYTAsICRhMCwgMHgxMA0KPiAgIDk3ODog
ICAwMDE0MTAwNCAgICAgICAgbm9yICAgICAgICAgICAgICRhMCwgJHplcm8sICRhMA0KPiB9DQo+
ICAgOTdjOiAgIDAwNmY4MDg0ICAgICAgICBic3RycGljay53ICAgICAgJGEwLCAkYTAsIDB4Ziwg
MHgwDQo+ICAgOTgwOiAgIDRjMDAwMDIwICAgICAgICBqaXJsICAgICAgICAgICAgJHplcm8sICRy
YSwgMA0KPiANCj4gVG86DQo+IA0KPiAwMDAwMDAwMDAwMDAwOTg0IDxjc3VtX2ZvbGQyPjoNCj4g
ICAgICAgICAgcmV0dXJuICh+c3VtIC0gcm9sMzIoc3VtLCAxNikpID4+IDE2Ow0KPiAgIDk4NDog
ICAwMDE0MTAwYyAgICAgICAgbm9yICAgICAgICAgICAgICR0MCwgJHplcm8sICRhMA0KPiAgICAg
ICAgICByZXR1cm4gKHggPDwgYW10KSB8ICh4ID4+ICgzMiAtIGFtdCkpOw0KPiAgIDk4ODogICAw
MDRjYzA4NCAgICAgICAgcm90cmkudyAgICAgICAgICRhMCwgJGEwLCAweDEwDQo+ICAgICAgICAg
IHJldHVybiAofnN1bSAtIHJvbDMyKHN1bSwgMTYpKSA+PiAxNjsNCj4gICA5OGM6ICAgMDAxMTEx
ODQgICAgICAgIHN1Yi53ICAgICAgICAgICAkYTAsICR0MCwgJGEwDQo+IH0NCj4gICA5OTA6ICAg
MDBkZjQwODQgICAgICAgIGJzdHJwaWNrLmQgICAgICAkYTAsICRhMCwgMHgxZiwgMHgxMA0KPiAg
IDk5NDogICA0YzAwMDAyMCAgICAgICAgamlybCAgICAgICAgICAgICR6ZXJvLCAkcmEsIDANCg0K
SXQgaXMgYWN0dWFsbHkgc2xpZ2h0bHkgYmV0dGVyIHRoYW4gdGhhdC4NCkluIHRoZSBjc3VtX2Zv
bGQyIHZlcnNpb24gdGhlIGZpcnN0IHR3byBpbnN0cnVjdGlvbnMNCmFyZSBpbmRlcGVuZGVudCAt
IHNvIGNhbiBleGVjdXRlIGluIHBhcmFsbGVsIG9uIHNvbWUgY3B1Lg0KDQoJRGF2aWQNCg0KLQ0K
UmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1p
bHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVz
KQ0K

