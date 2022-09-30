Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15BD5F084B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 12:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiI3KOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 06:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiI3KOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 06:14:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23D214A7A7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:14:31 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-17-B0DimJooNkqDfXWRKMPRaA-1; Fri, 30 Sep 2022 11:14:29 +0100
X-MC-Unique: B0DimJooNkqDfXWRKMPRaA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Fri, 30 Sep
 2022 11:14:25 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Fri, 30 Sep 2022 11:14:25 +0100
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
Thread-Index: AQHY037pE1P6FVCPj0CNx24XV/n/hK33wjDg
Date:   Fri, 30 Sep 2022 10:14:25 +0000
Message-ID: <35ab0ccca42b4b4695f6c99b6d741b8f@AcuMS.aculab.com>
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
Li4uDQoNClJlYWRpbmcgaXQgYWdhaW4sIHdoYXQgaXMgdGhpcyB0ZXN0IHN1cHBvc2VkIHRvIGFj
aGlldmU/DQoNCj4gKwkvKg0KPiArCSAqIG1vdnMgaW5zdHJ1Y3Rpb24gaXMgb25seSBnb29kIGZv
ciBhbGlnbmVkIGNhc2UuDQo+ICsJICovDQo+ICsJbW92bAlzcmMsIHRtcDANCj4gKwl4b3JsCWRl
c3QsIHRtcDANCj4gKwlhbmRsCSQweGZmLCB0bXAwDQo+ICsJanoJLkxmb3J3YXJkX21vdnMNCg0K
VGhlICdhbGlnbmVkJyB0ZXN0IHdvdWxkIGJlICcoc3JjIHwgZGVzdCkgJiAzJy4NCihPciBtYXli
ZSAnJiA3JyBzaW5jZSBzb21lIDMyYml0IHg4NiBjcHUgYWN0YWxseQ0KZG8gOCBieXRlIGFsaWdu
ZWQgJ3JlcCBtb3ZzbCcgZmFzdGVyIHRoYW4gNCBieXRlDQphbGlnbmVkIG9uZXMuDQpPVE9IIHRo
ZSBjb2RlIGxvb3AgaXMgbGlrZWx5IHRvIGJlIHNsb3dlciBzdGlsbC4NCg0KSSd2ZSBub3QgdHJp
ZWQgbWVhc3VyaW5nIG1pc2FsaWduZWQgJ3JlcCBtb3ZzdycgYnV0DQpvbiBzb21lIHJlY2VudCBp
bnRlbCBjcHUgbm9ybWFsIG1pc2FsaWduZWQgcmVhZHMgY29zdA0KYWxtb3N0IG5vdGhpbmcgLSBl
dmVuIHdoZW4gZG9pbmcgdHdvIHJlYWRzL2Nsb2NrLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

