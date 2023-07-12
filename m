Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8323B7500E1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjGLIMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjGLIMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:12:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0D8135
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:12:10 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-237-8QJPqqfFPTWNQbESOh-rFA-1; Wed, 12 Jul 2023 09:12:08 +0100
X-MC-Unique: 8QJPqqfFPTWNQbESOh-rFA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 12 Jul
 2023 09:12:07 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 12 Jul 2023 09:12:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'John Paul Adrian Glaubitz' <glaubitz@physik.fu-berlin.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
Thread-Topic: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
Thread-Index: AQHZsfHdmuMwibd1MUyQs4RUtwxCnq+1y++Q
Date:   Wed, 12 Jul 2023 08:12:06 +0000
Message-ID: <c5ad5c59fcfa4888bd03fb8a855c989c@AcuMS.aculab.com>
References: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
         <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com>
         <7b2c0d812280afaefee0c70a9aea00a0fcf84e3a.camel@physik.fu-berlin.de>
         <cd1caa5d-fbd8-c3fe-29e9-b848ddd5634c@omp.ru>
         <1178f8d0-be70-c088-ee6a-8b421b290624@roeck-us.net>
 <a0a0d4d06eecc9c3194afe2cee0b61ebed5e0392.camel@physik.fu-berlin.de>
In-Reply-To: <a0a0d4d06eecc9c3194afe2cee0b61ebed5e0392.camel@physik.fu-berlin.de>
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

RnJvbTogSm9obiBQYXVsIEFkcmlhbiBHbGF1Yml0eg0KPiBTZW50OiAwOSBKdWx5IDIwMjMgMDA6
MTMNCi4uLi4NCj4gTG9va2luZyBhdCBhcmNoL3NoL2JvYXJkcy9tYWNoLXIyZC9pcnEuYywgdGhl
cmUgaXMgc29tZSBJUlEgdHJhbnNsYXRpb24gZ29pbmcNCj4gb24gYW5kIG1heWJlIHRoYXQncyB0
aGUgcGFydCB3aGVyZSB3ZSBuZWVkIHRvIGNvcnJlY3QgdGhlIG9mZnNldCBieSAxNj8NCg0KV291
bGQgaXQgYmUgbGVzcyBwcm9ibGVtYXRpYyB0byB1c2UgKHNheSkgMTYgZm9yIElSUV8wDQpsZWF2
aW5nIElSUV8xKyBhcyAxKyA/DQoNCkF0IGxlYXN0IHRoYXQgd291bGQgb25seSBjYXVzZSBpc3N1
ZXMgZm9yIGNvZGUgdGhhdCBuZWVkZWQNCnRvIHVzZSBJUlFfMC4NCg0KKEl0IGhhcyB0byBiZSBz
YWlkIHRoYXQgbWFraW5nIElSUSAwIGludmFsaWQgc2VlbWVkIHdyb25nDQp0byBtZS4geDg2IChJ
Qk0gUEMpIGdldHMgYXdheSB3aXRoIGl0IGJlY2F1c2UgSVJRIDAgaXMNCmFsd2F5cyBhc3NpZ25l
ZCB0byBwbGF0Zm9ybSBzcGVjaWZpYyBoYXJkd2FyZS4pDQoNCglEYXZpZA0KDQotDQpSZWdpc3Rl
cmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtl
eW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

