Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308F372AE80
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 21:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjFJTvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 15:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFJTvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 15:51:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7DB30ED
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 12:51:07 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-191-aQsr8P1pPA2zGT4voRzmug-1; Sat, 10 Jun 2023 20:51:04 +0100
X-MC-Unique: aQsr8P1pPA2zGT4voRzmug-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 10 Jun
 2023 20:50:58 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 10 Jun 2023 20:50:58 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Cooper' <andrew.cooper3@citrix.com>,
        Yunhong Jiang <yunhong.jiang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        "Arjan van de Veen" <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Paul McKenney" <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Sean Christopherson" <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Russell King <linux@armlinux.org.uk>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: RE: [patch] x86/realmode: Make stack lock work in trampoline_compat()
Thread-Topic: [patch] x86/realmode: Make stack lock work in
 trampoline_compat()
Thread-Index: AQHZmmUgtDGga6k1FUelCeu8f3dcaq+Ecr5A
Date:   Sat, 10 Jun 2023 19:50:58 +0000
Message-ID: <67f939e112cc4578833ca74123bee402@AcuMS.aculab.com>
References: <20230508181633.089804905@linutronix.de>
 <20230508185218.962208640@linutronix.de>
 <20230524204818.3tjlwah2euncxzmh@box.shutemov.name> <87y1lbl7r6.ffs@tglx>
 <87sfbhlwp9.ffs@tglx> <20230529023939.mc2akptpxcg3eh2f@box.shutemov.name>
 <87bki3kkfi.ffs@tglx> <20230529203129.sthnhzgds7ynddxd@box.shutemov.name>
 <87h6rujdvl.ffs@tglx> <20230608233402.GA3430@yjiang5-mobl.amr.corp.intel.com>
 <a56a06c2-73fd-5295-3f6c-922ccb078488@citrix.com>
In-Reply-To: <a56a06c2-73fd-5295-3f6c-922ccb078488@citrix.com>
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

RnJvbTogQW5kcmV3IENvb3Blcg0KPiBTZW50OiAwOSBKdW5lIDIwMjMgMDA6NTgNCj4gDQouLi4N
Cj4gVGhlIGltcG9ydGFudCBwb2ludCBpcyB0aGUgbCBzdWZmaXggb24gYnRzbCwgd2hpY2ggZm9y
Y2VzIGl0IHRvIGJlIGxvbmcNCj4gKDMyYml0KSBpcnJlc3BlY3RpdmUgb2YgdGhlIGRlZmF1bHQg
b3BlcmFuZCBzaXplLg0KDQpEb2VzIHRoYXQgbWF0dGVyIGF0IGFsbD8NClRoZSAnYml0JyBvcGNv
ZGVzIChJJ20gc3VyZSAnYnRzJyBpcyAnYml0IHRlc3QgYW5kIHNldCcpIHRha2UNCmEgYml0IG9m
ZnNldCBmcm9tIHRoZSBiYXNlIGFkZHJlc3MuDQpUaGlzIGFjY2Vzc2VzIHRoZSBzYW1lIGJpdCBy
ZWdhcmRsZXNzIG9mIHRoZSBvcGVyYW5kIHNpemUuDQoNClRoZSBvbmUgcmVhbCBpc3N1ZSBpcyB0
aGF0IGEgYnl0ZSBvcGVyYW5kIHdpbGwgb25seSBsb2NrIHRoZSBvbmUgYnl0ZS4NClRoaXMgbWln
aHQgYmUgcHJvYmxlbWF0aWMgaWYgbm9uLWJpdCBsb2NrZWQgYWNjZXNzZXMgYXJlIGFsc28gdXNl
ZC4NCkFsdGhvdWdoIGl0IHdvdWxkIG5lZWQgdG8gYmUgcmF0aGVyIG9ic2N1cmUgdXNlLg0KKFRo
aXMgbWF5IGJlIG9uZSBvZiB0aGVtLi4uKQ0KDQpUaGUgb25seSBvdGhlciBwcm9ibGVtIGlzIHRo
YXQgYnRzbCBhbHdheXMgZG9lcyBhIGxvY2tlZCAzMmJpdA0KYWNjZXNzLiBJZiB0aGUgYmFzZSBh
ZGRyZXNzIGlzIG1pc2FsaWduZWQgdGhpcyBpcyBhIG1pc2FsaWduZWQNCmxvY2tlZCBhY2Nlc3Mg
LSBwcm9ibGVtYXRpYyBpZiBpdCBjcm9zc2VzIGEgY2FjaGUgbGluZSBib3VuZGFyeS4NCg0KCURh
dmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3Vu
dCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3
Mzg2IChXYWxlcykNCg==

