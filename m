Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056D85F080A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiI3Jzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiI3Jzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:55:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4204101329
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:55:33 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-120-36BsWVuQPhi0hJ_WTZLnVw-1; Fri, 30 Sep 2022 10:55:31 +0100
X-MC-Unique: 36BsWVuQPhi0hJ_WTZLnVw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Fri, 30 Sep
 2022 10:55:27 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Fri, 30 Sep 2022 10:55:27 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Desaulniers' <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Andy Lutomirski <luto@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: RE: [PATCH v4] x86, mem: move memmove to out of line assembler
Thread-Topic: [PATCH v4] x86, mem: move memmove to out of line assembler
Thread-Index: AQHY037pE1P6FVCPj0CNx24XV/n/hK33u1Gw
Date:   Fri, 30 Sep 2022 09:55:27 +0000
Message-ID: <5672845ec66744df9ee0f0c56031ab00@AcuMS.aculab.com>
References: <CAKwvOdkaKTa2aiA90VzFrChNQM6O_ro+b7VWs=op70jx-DKaXA@mail.gmail.com>
 <20220928210512.642594-1-ndesaulniers@google.com>
In-Reply-To: <20220928210512.642594-1-ndesaulniers@google.com>
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

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAyOCBTZXB0ZW1iZXIgMjAyMiAyMjowNQ0K
Li4uDQo+IG1lbW1vdmUgaXMgcXVpdGUgbGFyZ2UgYW5kIHByb2JhYmx5IHNob3VsZG4ndCBiZSBp
bmxpbmVkIGR1ZSB0byBzaXplDQo+IGFsb25lDQouLg0KPiArCS8qIERlY2lkZSBmb3J3YXJkL2Jh
Y2t3YXJkIGNvcHkgbW9kZSAqLw0KPiArCWNtcGwJZGVzdCwgc3JjDQo+ICsJamIJLkxiYWNrd2Fy
ZHNfaGVhZGVyDQoNCkl0IGhhcyB0byBiZSBiZXR0ZXIgdG8gZG8gdGhlIHNsaWdodGx5IG1vcmUg
Y29tcGxpY2F0ZWQNCnRlc3QgJ2Rlc3QgLSBzcmMgPCBzaXplJyAoYXMgdW5zaWduZWQpIHNvIHRo
YXQgcmV2ZXJzZQ0KY29waWVzIGFyZSBvbmx5IGRvbmUgd2hlbiBhYnNvbHV0ZWx5IG5lY2Vzc2Fy
eS4NCg0KSWdub3JpbmcgcGF0aG9sb2dpY2FsIGNhc2VzIG9uIHNvbWUgY3B1IGZhbWlsaWVzIHRo
ZQ0KZm9yd2FyZHMgY29weSB3aWxsIGJlbmVmaXQgZnJvbSBoYXJkd2FyZSBjYWNoZSBwcmVmZXRj
aC4NCg0KSSBhbHNvIGhhdmUgYSB2YWd1ZSByZWNvbGxlY3Rpb24gb2Ygc3RkIGFuZCBjbGQgYmVp
bmcgc2xvdy4NCg0KT2ggLSBhbmQgd2h5IGRvIGFsbCB0aGUgbGFiZWxzIGhhdmUgJ2J5dGVzd2Fw
JyBpbiB0aGVtPw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

