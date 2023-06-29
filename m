Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C278B74284B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjF2O2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjF2O2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:28:00 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F22E1BCC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:27:59 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-218-mBomV2FQM-mvbb6y2FOIGg-1; Thu, 29 Jun 2023 15:27:56 +0100
X-MC-Unique: mBomV2FQM-mvbb6y2FOIGg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 29 Jun
 2023 15:27:55 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 29 Jun 2023 15:27:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: RE: x86/csum: Remove unnecessary odd handling
Thread-Topic: x86/csum: Remove unnecessary odd handling
Thread-Index: AQHZqaKlrhaTNuKhJ0qJMNdg92SDBq+h1o1A
Date:   Thu, 29 Jun 2023 14:27:55 +0000
Message-ID: <5b04b05ecd3e4111bb12ac0c7317933e@AcuMS.aculab.com>
References: <20230628020657.957880-1-goldstein.w.n@gmail.com>
 <20230628091241.GAZJv5ie0xVGvnMKIM@fat_crate.local>
In-Reply-To: <20230628091241.GAZJv5ie0xVGvnMKIM@fat_crate.local>
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li4uDQo+ID4gQWxsIGNzdW0ga3VuaXQgdGVzdHMgcGFzcy4NCg0KTGFzdCB0aW1lIEkgbG9va2Vk
IEkgY291bGRuJ3Qgc2VlIHdoZXJlIGdlbmVyYXRlZCBJUHY2DQpjaGVja3N1bXMgZ2V0IGNoYW5n
ZWQgZnJvbSAweDAwMDAgKGZyb20gfmNzdW1fZm9sZCgpIHVzaW5nDQphZGMpIHRvIDB4ZmZmZiAt
IHdoaWNoIEkgdGhpbmsgdGhlIHByb3RvY29sIHJlcXVpcmVzLg0KDQpUaGUgdHJpdmlhbCB3YXkg
dG8gZG8gdGhpcyBpcyB0byBpbml0aWFsaXNlIHRoZSBzdW0gdG8gMQ0KKGluc3RlYWQgb3IgMCBv
ciAweGZmZmYpIGFuZCB0aGVuIGFkZCAxIGFmdGVyIHRoZSBpbnZlcnQuDQoNCkl0IGRvZXNuJ3Qg
bWF0dGVyIChtdWNoKSBmb3IgSVB2NCBiZWNhdXNlIDB4MDAwMCBpcyAnbm8gY2hlY2tzdW0nDQpy
YXRoZXIgdGhhbiAnaW52YWxpZCcuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

