Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53ED35F6251
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJFIMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJFIMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:12:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50193326D3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:12:09 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-81-ecYf1g42M7WCiHz6PXlHAA-1; Thu, 06 Oct 2022 09:12:06 +0100
X-MC-Unique: ecYf1g42M7WCiHz6PXlHAA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 6 Oct
 2022 09:12:04 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Thu, 6 Oct 2022 09:12:04 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Desaulniers' <ndesaulniers@google.com>,
        YingChi Long <me@inclyc.cn>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: RE: [PATCH v2] x86/fpu: use _Alignof to avoid UB in TYPE_ALIGN
Thread-Topic: [PATCH v2] x86/fpu: use _Alignof to avoid UB in TYPE_ALIGN
Thread-Index: AQHY2OxpWhPzSK6onk63/aasphivCa4BAxaA
Date:   Thu, 6 Oct 2022 08:12:04 +0000
Message-ID: <aa329b6fa5764e03ad6891142c2311fc@AcuMS.aculab.com>
References: <20220927153338.4177854-1-me@inclyc.cn>
 <20221005072913.982634-1-me@inclyc.cn>
 <CAKwvOdm6wSgG-_HrRR_9+mLnksbK4qNA8-F--bAVTjwY1C4brA@mail.gmail.com>
 <CAKwvOdnDKSdw4fh+FQWNgPNMnLuD=YBhKQHaxtkXJO7DWK_zpA@mail.gmail.com>
 <CAKwvOd=H5kB=nsParYME2KoQxj-eDC_DAN09y1T2E7yqS43H4Q@mail.gmail.com>
In-Reply-To: <CAKwvOd=H5kB=nsParYME2KoQxj-eDC_DAN09y1T2E7yqS43H4Q@mail.gmail.com>
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

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAwNSBPY3RvYmVyIDIwMjIgMTk6NTgNCi4u
Lg0KPiBodHRwczovL3d3dy5vcGVuLXN0ZC5vcmcvanRjMS9zYzIyL3dnMTQvd3d3L2RvY3MvbjMw
NTQucGRmDQo+IFNlY3Rpb24gNi4yLjggIkFsaWdubWVudCBvZiBvYmplY3RzIiByZWZlcnMgdG8g
ImZ1bmRhbWVudGFsIGFsaWdubWVudCINCj4gYW5kICJleHRlbmRlZCBhbGlnbm1lbnQuIg0KPiAN
Cj4gSSB3b25kZXIgaWYgaXQgd291bGQgYmUgcHJlY2lzZSB0byBzYXkgdGhhdCAiX0FsaWdub2Yg
ZXZhbHVhdGVzIHRvIHRoZQ0KPiBmdW5kYW1lbnRhbCBhbGlnbm1lbnQgd2hpbGUgX19hbGlnbm9m
X18gZXZhbHVhdGVzIHRvIHRoZSBleHRlbmRlZA0KPiBhbGlnbm1lbnQgKHdoaWNoIGlzIGltcGxl
bWVudGF0aW9uIGRlZmluZWQsIHR5cGljYWxseSBieSB0aGUgbWFjaGluZQ0KPiBzcGVjaWZpYyBB
QkkpLiIgVGhvdWdoIGV2ZW4gdGhhdCBzZWVtcyBpbXByZWNpc2Ugc2luY2UgaXQgc291bmRzIGxp
a2UNCj4gYSBmdW5kYW1lbnRhbCBhbGlnbm1lbnQgY291bGQgYmUgbGVzcyB0aGFuIG9yIGVxdWFs
IHRvIHdoYXQgYWxpZ25vZg0KPiBldmFsdWF0ZXMgdG8uDQoNCkV4Y2VwdCB0aGF0IG5laXRoZXIg
b2YgdGhvc2UgdGVybXMgbWFrZXMgYW55IHNlbnNlIHRvIG1vc3QNCnBlb3BsZS4NClNvbWV0aGlu
ZyBsaWtlICJfX2FsaWdub2ZfXygpIGlzIHRoZSBwcmVmZXJyZWQgYWxpZ25tZW50IGFuZA0KX0Fs
aWdub2YoKSB0aGUgbWluaW1hbCBhbGlnbm1lbnQuIEZvciAnbG9uZyBsb25nJyBvbiB4ODYgdGhl
c2UNCmFyZSA4IGFuZCA0IHJlc3BlY3RpdmVseS4iDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

