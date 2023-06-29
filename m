Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0DB742551
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjF2MGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjF2MFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:05:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB963C12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 05:05:19 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-15--5xlMR_NMheo5ckPJhB_mw-1; Thu, 29 Jun 2023 13:05:16 +0100
X-MC-Unique: -5xlMR_NMheo5ckPJhB_mw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 29 Jun
 2023 13:05:14 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 29 Jun 2023 13:05:14 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Evan Green' <evan@rivosinc.com>,
        Jessica Clarke <jrtc27@jrtc27.com>
CC:     Palmer Dabbelt <palmer@rivosinc.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Yangyu Chen <cyy@cyyself.name>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Simon Hosie <shosie@rivosinc.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        "Ley Foon Tan" <leyfoon.tan@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andy Chiu <andy.chiu@sifive.com>
Subject: RE: [PATCH 1/2] RISC-V: Probe for unaligned access speed
Thread-Topic: [PATCH 1/2] RISC-V: Probe for unaligned access speed
Thread-Index: AQHZqSszK74IXZi1x0Sk5pxi8WFXO6+hr6jw
Date:   Thu, 29 Jun 2023 12:05:14 +0000
Message-ID: <53dc6959cc8849d6b66676ad48c1376a@AcuMS.aculab.com>
References: <20230623222016.3742145-1-evan@rivosinc.com>
 <20230623222016.3742145-2-evan@rivosinc.com>
 <64F2D853-61E5-49CF-BAB5-AAFB8697683E@jrtc27.com>
 <CALs-HssZG8daTJaRK8JPT0VRk=23CtO6B_5kq4Xa_DdLELjaZw@mail.gmail.com>
In-Reply-To: <CALs-HssZG8daTJaRK8JPT0VRk=23CtO6B_5kq4Xa_DdLELjaZw@mail.gmail.com>
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

RnJvbTogRXZhbiBHcmVlbg0KPiBTZW50OiAyNyBKdW5lIDIwMjMgMjA6MTINCj4gDQo+IE9uIE1v
biwgSnVuIDI2LCAyMDIzIGF0IDI6NDLigK9QTSBKZXNzaWNhIENsYXJrZSA8anJ0YzI3QGpydGMy
Ny5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gMjMgSnVuIDIwMjMsIGF0IDIzOjIwLCBFdmFuIEdy
ZWVuIDxldmFuQHJpdm9zaW5jLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gUmF0aGVyIHRoYW4g
ZGVmZXJyaW5nIG1pc2FsaWduZWQgYWNjZXNzIHNwZWVkIGRldGVybWluYXRpb25zIHRvIGEgdmVu
ZG9yDQo+ID4gPiBmdW5jdGlvbiwgbGV0J3MgcHJvYmUgdGhlbSBhbmQgZmluZCBvdXQgaG93IGZh
c3QgdGhleSBhcmUuIElmIHdlDQo+ID4gPiBkZXRlcm1pbmUgdGhhdCBhIG1pc2FsaWduZWQgd29y
ZCBhY2Nlc3MgaXMgZmFzdGVyIHRoYW4gTiBieXRlIGFjY2Vzc2VzLA0KPiA+ID4gbWFyayB0aGUg
aGFyZHdhcmUncyBtaXNhbGlnbmVkIGFjY2VzcyBhcyAiZmFzdCIuDQo+ID4NCj4gPiBIb3cgc3Vy
ZSBhcmUgeW91IHRoYXQgeW91ciBtZWFzdXJlbWVudHMgY2FuIGJlIGV4dHJhcG9sYXRlZCBhbmQg
YXJlbuKAmXQNCj4gPiBhbiBhcnRlZmFjdCBvZiB0aGUgdGVzdGluZyBwcm9jZXNzPyBGb3IgZXhh
bXBsZSwgb2ZmIHRoZSB0b3Agb2YgbXkgaGVhZDoNCj4gPg0KPiA+ICogVGhlIGZpcnN0IHJ1biB3
aWxsIHBvdGVudGlhbGx5IGJlIHBlbmFsaXNlZCBieSBkYXRhIGNhY2hlIG1pc3NlcywNCj4gPiAg
IHVudHJhaW5lZCBwcmVmZXRjaGVycywgVExCIG1pc3NlcywgYnJhbmNoIHByZWRpY3RvcnMsIGV0
Yy4gY29tcGFyZWQNCj4gPiAgIHdpdGggbGF0ZXIgcnVucy4gWW91IGhhdmUgb25lIHdhcm11cCwg
YnV0IHdobyBrbm93cyBob3cgbWFueQ0KPiA+ICAgaXRlcmF0aW9ucyBpdCB3aWxsIHRha2UgdG8g
Y29udmVyZ2U/DQo+IA0KPiBJJ2QgZXhwZWN0IHRoZSBjYWNoZSBwZW5hbHRpZXMgdG8gYmUgcmVh
c29uYWJseSBjb3ZlcmVkIGJ5IGEgc2luZ2xlDQo+IHdhcm11cC4gWW91J3JlIHJpZ2h0IGFib3V0
IGJyYW5jaCBwcmVkaWN0aW9uLCB3aGljaCBpcyB3aHkgSSB0cmllZCB0bw0KPiB1c2UgYSBsYXJn
ZS1pc2ggYnVmZmVyIHNpemUsIG1pbmltaXplIHRoZSByYXRpbyBvZiBjb25kaXRpb25hbHMgdG8N
Cj4gbG9hZHMvc3RvcmVzLCBhbmQgZG8gdGhlIHRlc3QgZm9yIGEgZGVjZW50IG51bWJlciBvZiBp
dGVyYXRpb25zIChvbiBteQ0KPiBUSGVhZCwgYWJvdXQgMTgwMCBhbmQgNDAwIGZvciB3b3JkcyBh
bmQgYnl0ZXMpLg0KPiANCj4gV2hlbiBJIHJhbiB0aGUgdGVzdCBhIGhhbmRmdWwgb2YgdGltZXMs
IEkgZGlkIHNlZSB2YXJpYXRpb24gb24gdGhlDQo+IG9yZGVyIG9mIH41JS4gQnV0IHRoZSBjb21w
YXJpc29uIG9mIHRoZSB0d28gbnVtYmVycyBkb2Vzbid0IHNlZW0gdG8gYmUNCj4gYW55d2hlcmUg
bmVhciB0aGF0IG1hcmdpbiAoVEhlYWQgQzkwNiB3YXMgfjR4IGZhc3RlciBkb2luZyBtaXNhbGln
bmVkDQo+IHdvcmQgYWNjZXNzZXMsIG90aGVycyB3aXRoIHNsb3cgbWlzYWxpZ25lZCBhY2Nlc3Nl
cyBhbHNvIHJlcG9ydGluZw0KPiBudW1iZXJzIG5vdCBhbnl3aGVyZSBjbG9zZSB0byBlYWNoIG90
aGVyKS4NCg0KSXNuJ3QgdGhlIEVNVUxBVEVEIGNhc2Ugc28gbXVjaCBzbG93ZXIgdGhhbiBhbnl0
aGluZyBlbHNlIHRoYXQNCml0IGlzIGV2ZW4gcHJldHR5IG9idmlvdXMgZnJvbSBhIHNpbmdsZSBh
Y2Nlc3M/DQooUG9zc2libHkgdGhlIDJuZCBhY2Nlc3MgdG8gYXZvaWQgJ2NvbGQgY2FjaGUnLikN
Cg0KT25lIG9mIHRoZSB0aGluZ3MgdGhhdCBjYW4gcGVydHVyYiBtZWFzdXJlbWVudHMgaXMgaGFy
ZHdhcmUNCmludGVycnVwdHMuIFRoYXQgY2FuIGJlIG1pdGlnYXRlZCBieSBjb3VudGluZyBjbG9j
a3MgZm9yIGEgZmV3DQooMTAgaXMgcGxlbnR5KSBpdGVyYXRpb25zIG9mIGEgc2hvcnQgcmVxdWVz
dCBhbmQgdGFraW5nIHRoZQ0KZmFzdGVzdCB2YWx1ZS4NCkZvciBzaG9ydCBob3QtY2FjaGUgY29k
ZSBzZXF1ZW5jZXMgeW91IGNhbiBhY3R1YWxseSBjb21wYXJlIHRoZQ0KYWN0dWFsIGNsb2NrIGNv
dW50cyB3aXRoIHRoZW9yZXRpY2FsIG1pbmltdW0gdmFsdWVzLg0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

