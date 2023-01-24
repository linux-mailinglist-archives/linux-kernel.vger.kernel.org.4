Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A9E67A03C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbjAXRdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjAXRdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:33:04 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B376F4617F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:33:01 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-251-fBkA3j84PYaFbklymm6IJA-1; Tue, 24 Jan 2023 17:32:58 +0000
X-MC-Unique: fBkA3j84PYaFbklymm6IJA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Tue, 24 Jan
 2023 17:32:57 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Tue, 24 Jan 2023 17:32:57 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     Mateusz Guzik <mjguzik@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Uros Bizjak" <ubizjak@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
Thread-Topic: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
Thread-Index: AQHZK4esPiXIxoxXL0qMusgAkdAn7q6lrzIwgAcKieqAAI8WsIAAikgAgAAIuxA=
Date:   Tue, 24 Jan 2023 17:32:57 +0000
Message-ID: <1d272a31a0494c4b8b1b86d1a79f1b96@AcuMS.aculab.com>
References: <20230118150703.4024-1-ubizjak@gmail.com>
 <20230118131825.c6daea81ea1e2dc6aa014f38@linux-foundation.org>
 <CAFULd4ZQGG+N3f7xDuoiNG1jY128pqaH0F4eLKO+fhvSNAbKfA@mail.gmail.com>
 <CAFULd4b5szcTHTVbGJ9WiciG_+8kANiPZYP_pkEZUhnz_HHy-g@mail.gmail.com>
 <913c01d41f824fa8b3400384437fa0d8@AcuMS.aculab.com>
 <CAFULd4aDORSrq7zf_LcAZRP8HOHcrq2-rGMaroKyG2zQDHNpOA@mail.gmail.com>
 <CAGudoHF6zbyzza6xysuCjcxjHAUgeAVvgW0sqxDAFQNwz9u7wg@mail.gmail.com>
 <CAHk-=whUSZk1dZrJuhxeb4qB3POstVRwOZCN8PXd3W7ztbqQBg@mail.gmail.com>
 <CAGudoHH+SmRoyXvppjBEoK=dvVdy1jvKNHDLEVf9mLnzsEds6Q@mail.gmail.com>
 <7d506ede564d425db116ff646f267f4f@AcuMS.aculab.com>
 <CAHk-=wiqpD6F0ript8y29X_ijwsBmK_ZDVy_bOBMPr2zb09B5A@mail.gmail.com>
In-Reply-To: <CAHk-=wiqpD6F0ript8y29X_ijwsBmK_ZDVy_bOBMPr2zb09B5A@mail.gmail.com>
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

PiAoT2J2aW91c2x5IGl0J3Mgc3RpbGwgZmFzdGVyIHRvIG5vdCBoYXZlIHRvIGV2ZW4gc2VhcmNo
IGF0IGFsbCwgYW5kDQo+IHB1dCBldmVyeXRoaW5nIGluIG9uZSBkaXJlY3RvcnkgYW5kIG5vdCBo
YXZlIGEgc2VhcmNoIHBhdGggYXQgYWxsLCBidXQNCj4gaXQgZG9lcyBoYXZlIGl0cyBvd24gc2Vy
aW91cyBkb3duc2lkZXMsIG5vdGFibHkgdGhlIHdob2xlICJub3cgd2UgaGF2ZQ0KPiB0byBrZWVw
IHRoYXQgdW5pb24gZGlyZWN0b3J5IGluIHN5bmMgd2l0aCBhbGwgdGhlIHNvdXJjZSBkaXJlY3Rv
cmllcyIpDQoNCkkndmUgdXNlZCBtYWtlIHRvIGRvIHRoZSBjb3BpZXMgZm9yIGEgJ2RheSBqb2In
IHByb2plY3QuDQpKdXN0IGEgbWF0dGVyIG9mIGlkZW50aWZ5aW5nIHRoZSAuaCBmaWxlcyB0aGF0
IG5lZWQgY29weWluZw0KdG8gb2JqL2luY2x1ZGUuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

