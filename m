Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D89743728
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 10:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjF3IaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 04:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjF3I3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:29:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8072C35A1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 01:29:46 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-272-sTh1UJeJMDO3OsTYjnjZSA-1; Fri, 30 Jun 2023 09:29:43 +0100
X-MC-Unique: sTh1UJeJMDO3OsTYjnjZSA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 30 Jun
 2023 09:29:42 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 30 Jun 2023 09:29:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Evan Green' <evan@rivosinc.com>
CC:     Jessica Clarke <jrtc27@jrtc27.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Yangyu Chen <cyy@cyyself.name>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Xianting Tian" <xianting.tian@linux.alibaba.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Simon Hosie <shosie@rivosinc.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Andy Chiu" <andy.chiu@sifive.com>
Subject: RE: [PATCH 1/2] RISC-V: Probe for unaligned access speed
Thread-Topic: [PATCH 1/2] RISC-V: Probe for unaligned access speed
Thread-Index: AQHZqSszK74IXZi1x0Sk5pxi8WFXO6+hr6jwgACq1QCAAKe+MA==
Date:   Fri, 30 Jun 2023 08:29:42 +0000
Message-ID: <b9a23f8947014fdbb625d67134ed796d@AcuMS.aculab.com>
References: <20230623222016.3742145-1-evan@rivosinc.com>
 <20230623222016.3742145-2-evan@rivosinc.com>
 <64F2D853-61E5-49CF-BAB5-AAFB8697683E@jrtc27.com>
 <CALs-HssZG8daTJaRK8JPT0VRk=23CtO6B_5kq4Xa_DdLELjaZw@mail.gmail.com>
 <53dc6959cc8849d6b66676ad48c1376a@AcuMS.aculab.com>
 <CALs-HstgcnK=prSHm9D7bqWc05q52ObA5kozmxzr-euR=CFfKw@mail.gmail.com>
In-Reply-To: <CALs-HstgcnK=prSHm9D7bqWc05q52ObA5kozmxzr-euR=CFfKw@mail.gmail.com>
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

Li4uDQo+IFllYWgsIG9uZSB0aGluZyBJIGNvdWxkIGRvIGlzIGRpc2FibGUgaW50ZXJydXB0cywg
bWVhc3VyZSB0aGUgY3ljbGUNCj4gY291bnQgb2YgZG9pbmcgYW4gaW5kaXZpZHVhbCBpdGVyYXRp
b24sIGRvIHRoaXMgTiB0aW1lcywgYW5kIHRha2UgdGhlDQo+IG1pbmltdW0gdmFsdWUgYXMgdGhl
IHRpbWUgdG8gY29tcGFyZS4gSW4gdGhlIGVuZCBJJ2xsIHRoZW4gaGF2ZSB0d28NCj4gbnVtYmVy
cyB0byBjb21wYXJlLCBsaWtlIEkgZG8gaW4gdGhpcyBwYXRjaC4gSW4gdGhlb3J5IHRoZSB2YXJp
YW5jZSBvbg0KPiB0aGF0IHNob3VsZCBiZSByZWFsbHkgdGlnaHQuIE4gd2lsbCBoYXZlIHRvIGRl
cGVuZCBvbiB0aGUgb3ZlcmFsbA0KPiBhbW91bnQgb2YgdGltZSBJJ20gdGFraW5nIHNvIGFzIG5v
dCB0byBzaHV0IGludGVycnVwdHMgb2ZmIGZvciB2ZXJ5DQo+IGxvbmcuIExldCBtZSBleHBlcmlt
ZW50IHdpdGggdGhpcyBhbmQgc2VlIGhvdyB0aGUgcmVzdWx0cyBsb29rLg0KPiAtRXZhbg0KDQpJ
IGRvdWJ0IHlvdSdsbCBuZWVkIG1hbnkgaXRlcmF0aW9ucyBvciBhIGxvbmcgdGVzdC4NCg0KWW91
IGNhbiBkbyB0ZXN0cyBpbiB1c2Vyc3BhY2Ugd2l0aG91dCBkaXNhYmxpbmcgcHJlLWVtcHRpb24N
Cm9yIGludGVycnVwdHMgLSB0aGUgbGFyZ2Uvc2lsbHkgdmFsdWVzIHRoZXkgZ2VuZXJhdGUgYXJl
DQplYXNpbHkgaWdub3JlZC4NCg0KSSBzdXNwZWN0IHlvdSdsbCBnZXQgZW5vdWdoIGluZm8gZnJv
bSBzb21ldGhpbmcgbGlrZToNCgl1bnNpZ25lZCBsb25nIHhbMl07DQoJdm9sYXRpbGUgdW5zaWdu
ZWQgbG9uZyAqcCA9ICh2b2lkICopKCh1bnNpZ25lZCBjaGFyICopeCArIDEpOw0KCWZ1bGxfY3B1
X2JhcnJpZXIoKQ0KCXN0YXJ0ID0gcmR0c2MoKTsNCglmdWxsX2NwdV9iYXJyaWVyKCk7DQoJKnA7
ICpwOyAqcDsgKnA7ICpwOyAqcDsgKnA7ICpwOw0KCSpwOyAqcDsgKnA7ICpwOyAqcDsgKnA7ICpw
OyAqcDsNCglmdWxsX2NwdV9iYXJyaWVyKCkNCgllbGFwc2VkID0gcmR0c2MoKSAtIHN0YXJ0Ow0K
T25jZSB0aGUgaS1jYWNoZSBpcyBsb2FkZWQgaXQgc2hvdWxkIGJlIHByZXR0eSBjb25zdGFudC4N
CkZvciBhbGlnbmVkIGFkZHJlc3NlcyBJJ2QgZXhwZWN0IGVhY2ggZXh0cmEgJypwJyB0byBiZQ0K
b25lIG1vcmUgY2xvY2suDQpXaXRoIGhhcmR3YXJlIHN1cHBvcnQgZm9yIG1pc2FsaWduZWQgdHJh
bnNmZXJzIGF0IG1vc3QNCjIgY2xvY2tzICh0ZXN0IG9uIHg4NiBhbmQgaXQgd2lsbCBiZSAxIGNs
b2NrKS4NClRoZSBlbXVsYXRlZCB2ZXJzaW9uIHdpbGwgYmUgMTAwcyBvciAxMDAwcy4NCgkNCkkn
bSBub3Qgc3VyZSBob3cgbXVjaCBvZiBhIGNwdSBiYXJyaWVyIHlvdSBuZWVkLg0KRGVmaW5pdGVs
eSBuZWVkcyB0byB3YWl0IGZvciBhbGwgbWVtb3J5IGFjY2Vzc2VzDQphbmQgdGhlIHJkdHNjKCku
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=

