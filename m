Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984175EBD1B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiI0IUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiI0IUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:20:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C743A6C4E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:20:45 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-310-Qdzirnz2PdetQmdwpyNdtA-1; Tue, 27 Sep 2022 09:20:42 +0100
X-MC-Unique: Qdzirnz2PdetQmdwpyNdtA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 27 Sep
 2022 09:20:39 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Tue, 27 Sep 2022 09:20:39 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'YingChi Long' <me@inclyc.cn>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/fpu: use __alignof__ to avoid UB in TYPE_ALIGN
Thread-Topic: [PATCH] x86/fpu: use __alignof__ to avoid UB in TYPE_ALIGN
Thread-Index: AQHY0bfRNKadILb+rU6iQrBlkJqLV63y7+SQ
Date:   Tue, 27 Sep 2022 08:20:39 +0000
Message-ID: <40fca2eef36a40f4b9a4145a0f7fe57c@AcuMS.aculab.com>
References: <20220925153151.2467884-1-me@inclyc.cn>
 <YzFqXbVptttrzoDe@hirez.programming.kicks-ass.net>
 <0ed40d5b-a404-f424-c9c4-2adf1bf9750b@inclyc.cn>
In-Reply-To: <0ed40d5b-a404-f424-c9c4-2adf1bf9750b@inclyc.cn>
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

RnJvbTogWWluZ0NoaSBMb25nDQo+IFNlbnQ6IDI2IFNlcHRlbWJlciAyMDIyIDE0OjE4DQo+IA0K
PiBTZWVtcyBHQ0MgX19hbGlnbm9mX18gaXMgbm90IGV2YWx1YXRlZCB0byB0aGUgbWluaW11bSBh
bGlnbm1lbnQgb2Ygc29tZQ0KPiBUWVBFLCBhbmQgZGVwZW5kcyBvbiBmaWVsZHMgb2YgdGhlIHN0
cnVjdC4NCj4gDQo+ICA+IE5vdGFibHkgSSB0aGluayAnbG9uZyBsb25nJyBoYXMgNCBieXRlIGFs
aWdubWVudCBvbiBpMzg2IGFuZCBzb21lIG90aGVyDQo+ICA+IDMyYml0IGFyY2hzLg0KPiANCj4g
QzExIF9BbGlnbm9mIG1hdGNoZXMgaW4gdGhlIGNhc2UgKHNlZSBnb2Rib2x0IGxpbmsgYmVsb3cp
LiBIb3cgYWJvdXQNCj4gc3dpdGNoIHRvIF9BbGlnbm9mPw0KDQpfX2FsaWdub2ZfXygpIHJldHVy
bnMgdGhlIHByZWZlcnJlZCBhbGlnbm1lbnQsIG5vdCB0aGUgbWluaW1hbCBvbmUuDQpTbyBvbmUg
aTM4NiBpdCByZXR1cm5zIDggZm9yICdsb25nIGxvbmcnIHJhdGhlciB0aGFuIDQuDQoNClVzaW5n
IGFsaWdub2Yoc3RydWN0e2xvbmcgbG9uZyB4O30pIGRvZXMgZ2l2ZSB0aGUgcmVxdWlyZWQgNC4N
CihhcyBkb2VzIF9BbGlnbm9mKCkpLg0KDQpTZWUgaHR0cHM6Ly9nb2Rib2x0Lm9yZy96LzEzeFRZ
WWQxMQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K

