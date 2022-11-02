Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD879616FFE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiKBVly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBVlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:41:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4B26428
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 14:41:48 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-113-H_Ns1qzeOZy9zA3lcEYQCQ-1; Wed, 02 Nov 2022 21:41:45 +0000
X-MC-Unique: H_Ns1qzeOZy9zA3lcEYQCQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 2 Nov
 2022 21:41:45 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Wed, 2 Nov 2022 21:41:45 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>, YingChi Long <me@inclyc.cn>
CC:     "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH RESEND v3] x86/fpu: use _Alignof to avoid UB in TYPE_ALIGN
Thread-Topic: [PATCH RESEND v3] x86/fpu: use _Alignof to avoid UB in
 TYPE_ALIGN
Thread-Index: AQHY7tv1cHXXelDx7UO8GrKC3QIm9K4sJ2Ig
Date:   Wed, 2 Nov 2022 21:41:44 +0000
Message-ID: <1f8cc34bc3af40468e9de6307ff4ad1a@AcuMS.aculab.com>
References: <20221006141442.2475978-1-me@inclyc.cn>
 <20221029122552.2855941-1-me@inclyc.cn> <Y2KhCyofvfG5W5hE@zn.tnic>
In-Reply-To: <Y2KhCyofvfG5W5hE@zn.tnic>
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

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDAyIE5vdmVtYmVyIDIwMjIgMTY6NTYNCj4g
DQo+IE9uIFNhdCwgT2N0IDI5LCAyMDIyIGF0IDA4OjI1OjUyUE0gKzA4MDAsIFlpbmdDaGkgTG9u
ZyB3cm90ZToNCj4gPiBXRzE0IE4yMzUwIG1hZGUgdmVyeSBjbGVhciB0aGF0IGl0IGlzIGFuIFVC
IGhhdmluZyB0eXBlIGRlZmluaXRpb25zDQo+ID4gd2l0aCBpbiAib2Zmc2V0b2YiLg0KPiANCj4g
UGxzIHB1dCB0aGUgd29ya2luZyBncm91cCBVUkwgbm90ZSBoZXJlLCBub3QgYmVsb3cgaW4gYSBM
aW5rIHRhZy4NCj4gDQo+IEFsc28sIHdyaXRlIG91dCAiVUIiIHBscy4NCg0KSSdtIGFsc28gcHJl
dHR5IHN1cmUgaXQgaXMgb25seSB1bmRlZmluZWQgYmVjYXVzZSBhIGNvbXBpbGVyDQppcyBhbGxv
d2VkIHRvIGFkZCBwYWRkaW5nIGJldHdlZW4gc3RydWN0dXJlIG1lbWJlcnMuDQpTbyB0aGUgdHlw
ZSBkZWZpbml0aW9uIGluc2lkZSBvZmZzZXRvZigpIGNvdWxkIGJlIGxhaWQgb3V0DQpkaWZmZXJl
bnRseSBmcm9tIGFueSBvdGhlciBzaW1pbGFyIGRlZmluaXRpb24uDQoNCkhvd2V2ZXIgdGhlIGtl
cm5lbCByZXF1aXJlcyB0aGF0IHRoZSBjb21waWxlciBvbmx5IGFkZHMgdGhlDQptaW5pbXVtIHBh
ZGRpbmcgcmVxdWlyZWQgdG8gYWxpZ24gbWVtYmVycy4NClNvIGluIHRoZSBrZXJuZWwgaXQgaXMg
YWN0dWFsbHkgZmluZS4NCg0KT1RPSCB1c2luZyBBbGlnbm9mKCkgKGV0YykgaXMgY2xlYW5lci4N
Cg0KVGhpcyBpcyBhbGwgc2ltaWxhciB0byAocHJvYmFibHkpIHdoeSBjbGFuZyBvYmplY3RzIHRv
IGFyaXRobWV0aWMNCm9uIE5VTEwgKGllIGltcGxlbWVudGluZyBvZmZzZXRvZiBieSBsb29raW5n
IGF0IHRoZSBhZGRyZXNzIG9mDQphIGZpZWxkIHdoZW4gTlVMTCBpcyBjYXN0IHRvIHRoZSBzdHJ1
Y3QgdHlwZSkuDQpUaGlzIGlzIG9ubHkgdW5kZWZpbmVkIGJlY2F1c2UgdGhlIE5VTEwgcG9pbnRl
ciBtaWdodCBub3QNCmhhdmUgdGhlIGFsbC16ZXJvIGJpdCBwYXR0ZXJuLg0KQnV0IHByZXR0eSBt
dWNoIGV2ZXJ5IEMgQUJJIHVzZXMgdGhlIHplcm8gYml0IHBhdHRlcm4gZm9yIE5VTEwuDQpJZiBp
dCB1c2VkIGFueSBvdGhlciB2YWx1ZSB0aGVuIG1vc3Qgb2YgdGhlIG1lbXNldCgpIG9mIHN0cnVj
dHVyZXMNCndvdWxkIG5lZWQgY2hhbmdpbmcuIFNvIGZvciBwb3J0YWJpbGl0eSB0aGV5IG91Z2h0
IHRvIGdlbmVyYXRlDQp3YXJuaW5ncyBhcyB3ZWxsLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

