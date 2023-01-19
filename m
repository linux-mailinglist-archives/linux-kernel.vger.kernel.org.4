Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7BB6738F2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjASMrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjASMrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:47:37 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6905B97
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:47:35 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-59-4Uba05ctMYy3YSG9K0IoGw-1; Thu, 19 Jan 2023 12:47:32 +0000
X-MC-Unique: 4Uba05ctMYy3YSG9K0IoGw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 19 Jan
 2023 12:47:32 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Thu, 19 Jan 2023 12:47:32 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Uros Bizjak' <ubizjak@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
Thread-Topic: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
Thread-Index: AQHZK4esPiXIxoxXL0qMusgAkdAn7q6lrzIw
Date:   Thu, 19 Jan 2023 12:47:31 +0000
Message-ID: <913c01d41f824fa8b3400384437fa0d8@AcuMS.aculab.com>
References: <20230118150703.4024-1-ubizjak@gmail.com>
 <20230118131825.c6daea81ea1e2dc6aa014f38@linux-foundation.org>
 <CAFULd4ZQGG+N3f7xDuoiNG1jY128pqaH0F4eLKO+fhvSNAbKfA@mail.gmail.com>
 <CAFULd4b5szcTHTVbGJ9WiciG_+8kANiPZYP_pkEZUhnz_HHy-g@mail.gmail.com>
In-Reply-To: <CAFULd4b5szcTHTVbGJ9WiciG_+8kANiPZYP_pkEZUhnz_HHy-g@mail.gmail.com>
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

PiBCVFc6IFJlY2VudGx5LCBpdCB3YXMgZGV0ZXJtaW5lZCBbMV0gdGhhdCB0aGUgdXNhZ2Ugb2Yg
Y3B1X3JlbGF4KCkNCj4gaW5zaWRlIHRoZSBjbXB4Y2hnIGxvb3AgY2FuIGJlIGhhcm1mdWwgZm9y
IHBlcmZvcm1hbmNlLiBXZSBhY3R1YWxseQ0KPiBoYXZlIHRoZSBzYW1lIHNpdHVhdGlvbiBoZXJl
LCBzbyBwZXJoYXBzIGNwdV9yZWxheCgpIHNob3VsZCBiZSByZW1vdmVkDQo+IGluIHRoZSBzYW1l
IHdheSBpdCB3YXMgcmVtb3ZlZCBmcm9tIHRoZSBsb2NrcmVmLg0KDQpJJ20gbm90IHN1cmUgeW91
IGNhbiBldmVyIHdhbnQgYSBjcHVfcmVsYXgoKSBpbiBhIGxvb3AgdGhhdA0KaXMgaW1wbGVtZW50
aW5nIGFuIGF0b21pYyBvcGVyYXRpb24uDQpFdmVuIHRoZSBpYTY0IChkaWUuLi4pIGlzc3VlIHdh
cyB3aXRoIGEgbG9vcCB0aGF0IHdhcyB3YWl0aW5nDQpmb3IgYW5vdGhlciBjcHUgdG8gY2hhbmdl
IHRoZSBsb2NhdGlvbiAoZWcgYSBzcGlubG9jaykuDQoNCkZvciBhbiBhdG9taWMgb3BlcmF0aW9u
IGFuIGltbWVkaWF0ZSByZXRyeSBpcyBsaWtlbHkgdG8gc3VjY2VlZC4NCkFueSBraW5kIG9mIGRl
ZmVycmFsIHRvIGFuIGFub3RoZXIgY3B1IGNhbiBvbmx5IG1ha2UgaXQgd29yc2UuDQoNCkNsZWFy
bHkgaWYgeW91IGhhdmUgMTAwcyBvZiBjcHUgbG9vcGluZyBkb2luZyBhdG9taWMgb3BlcmF0aW9u
DQpvbiB0aGUgc2FtZSBjYWNoZSBsaW5lIGl0IGlzIGxpa2VseSB0aGF0IHNvbWUgZ2V0IHN0YXJ2
ZWQuDQpCdXQgdG8gZml4IHRoYXQgeW91IG5lZWQgdG8gaW5jcmVhc2UgdGhlIHRpbWUgYmV0d2Vl
biBzdWNjZXNzZnVsDQpvcGVyYXRpb25zLCBub3QgZGVsYXkgb24gZmFpbHVyZS4NCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==

