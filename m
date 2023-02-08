Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C614468FA42
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 23:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjBHW3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 17:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjBHW3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 17:29:47 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2057F2106
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 14:29:45 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-62-7A3AGomqMleUYNu3luwyAg-1; Wed, 08 Feb 2023 22:29:43 +0000
X-MC-Unique: 7A3AGomqMleUYNu3luwyAg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Wed, 8 Feb
 2023 22:29:41 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Wed, 8 Feb 2023 22:29:41 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Guo Ren' <guoren@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC:     Evgenii Shatokhin <e.shatokhin@yadro.com>,
        "suagrfillet@gmail.com" <suagrfillet@gmail.com>,
        "andy.chiu@sifive.com" <andy.chiu@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>, "bp@suse.de" <bp@suse.de>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "linux@yadro.com" <linux@yadro.com>
Subject: RE: [PATCH -next V7 0/7] riscv: Optimize function trace
Thread-Topic: [PATCH -next V7 0/7] riscv: Optimize function trace
Thread-Index: AQHZO2Vv8FsBcndYrkieV7dCV5LmRa7FoF6g
Date:   Wed, 8 Feb 2023 22:29:41 +0000
Message-ID: <8154e7e618d84e298bad1dc95f26c000@AcuMS.aculab.com>
References: <20230112090603.1295340-1-guoren@kernel.org>
 <c68bac83-5c88-80b1-bac9-e1fd4ea8f07e@yadro.com>
 <CAJF2gTQm11px3mqyrNk1SRiJZud1yeY2avK99UX9KetWAGe5BA@mail.gmail.com>
 <Y+DOyqehZvBJlb8N@FVFF77S0Q05N>
 <CAJF2gTQ6U1vH79Mu53eQ-GVaFx36C-hEt9Qf6=_vAkHfmgFh1Q@mail.gmail.com>
 <Y+IXB4xQ7ACQWC9U@FVFF77S0Q05N>
 <CAJF2gTTrX+8wCm-g=L9+3BkCRrZ8SCUM2w1e5duq-+Bsa213mA@mail.gmail.com>
In-Reply-To: <CAJF2gTTrX+8wCm-g=L9+3BkCRrZ8SCUM2w1e5duq-+Bsa213mA@mail.gmail.com>
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

PiA+ICAgIyBOb3RlOiBhbGlnbmVkIHRvIDggYnl0ZXMNCj4gPiAgIGFkZHItMDggICAgICAgICAg
ICAgICAvLyBMaXRlcmFsIChmaXJzdCAzMi1iaXRzKSAgICAgIC8vIHBhdGNoZWQgdG8gb3BzIHB0
cg0KPiA+ICAgYWRkci0wNCAgICAgICAgICAgICAgIC8vIExpdGVyYWwgKGxhc3QgMzItYml0cykg
ICAgICAgLy8gcGF0Y2hlZCB0byBvcHMgcHRyDQo+ID4gICBhZGRyKzAwICAgICAgIGZ1bmM6ICAg
bXYgICAgICB0MCwgcmENCj4gV2UgbmVlZG4ndCAibXYgdDAsIHJhIiBoZXJlIGJlY2F1c2Ugb3Vy
ICJqYWxyIiBjb3VsZCB3b3JrIHdpdGggdDAgYW5kDQo+IHdvbid0IGFmZmVjdCByYS4gTGV0J3Mg
ZG8gaXQgaW4gdGhlIHRyYW1wb2xpbmUgY29kZSwgYW5kIHRoZW4gd2UgY2FuDQo+IHNhdmUgYW5v
dGhlciB3b3JkIGhlcmUuDQo+ID4gICBhZGRyKzA0ICAgICAgICAgICAgICAgYXVpcGMgICB0MSwg
ZnRyYWNlX2NhbGxlcg0KPiA+ICAgYWRkciswOCAgICAgICAgICAgICAgIGphbHIgICAgZnRyYWNl
X2NhbGxlcih0MSkNCg0KSXMgdGhhdCBzb21lIGtpbmQgb2YgJ2xvYWQgaGlnaCcgYW5kICdhZGQg
b2Zmc2V0JyBwYWlyPw0KSSBndWVzcyA2NGJpdCBrZXJuZWxzIGd1YXJhbnRlZSB0byBwdXQgYWxs
IG1vZHVsZSBjb2RlDQp3aXRoaW4gKy0yRyBvZiB0aGUgbWFpbiBrZXJuZWw/IA0KDQo+IEhlcmUg
aXMgdGhlIGNhbGwtc2l0ZToNCj4gICAgIyBOb3RlOiBhbGlnbmVkIHRvIDggYnl0ZXMNCj4gICAg
YWRkci0wOCAgICAgICAgICAgICAgIC8vIExpdGVyYWwgKGZpcnN0IDMyLWJpdHMpICAgICAgLy8g
cGF0Y2hlZCB0byBvcHMgcHRyDQo+ICAgIGFkZHItMDQgICAgICAgICAgICAgICAvLyBMaXRlcmFs
IChsYXN0IDMyLWJpdHMpICAgICAgIC8vIHBhdGNoZWQgdG8gb3BzIHB0cg0KPiAgICBhZGRyKzAw
ICAgICAgICAgICAgICAgYXVpcGMgICB0MCwgZnRyYWNlX2NhbGxlcg0KPiAgICBhZGRyKzA0ICAg
ICAgICAgICAgICAgamFsciAgICBmdHJhY2VfY2FsbGVyKHQwKQ0KDQpDb3VsZCB5b3UgZXZlbiBk
byBzb21ldGhpbmcgbGlrZToNCglhZGRyLW4JY2FsbCBmdHJhY2UtZnVuY3Rpb24NCglhZGRyLW4r
eAlsaXRlcmFscw0KCWFkZHIrMAlub3Agb3Igam1wIGFkZHItbg0KCWFkZHIrNAlmdW5jdGlvbl9j
b2RlDQpTbyB0aGF0IGFsbCB0aGUgY29kZSBleGVjdXRlZCB3aGVuIHRyYWNpbmcgaXMgZW5hYmxl
ZA0KaXMgYmVmb3JlIHRoZSBsYWJlbCBhbmQgb25seSBvbmUgJ25vcCcgaXMgaW4gdGhlIGJvZHku
DQpUaGUgY2FsbGVkIGNvZGUgY2FuIHVzZSB0aGUgcmV0dXJuIGFkZHJlc3MgdG8gZmluZCB0aGUN
CmxpdGVyYWxzIGFuZCB0aGVuIG1vZGlmeSBpdCB0byByZXR1cm4gdG8gYWRkcis0Lg0KVGhlIGNv
ZGUgY29zdCB3aGVuIHRyYWNlIGlzIGVuYWJsZWQgaXMgcHJvYmFibHkgaXJyZWxldmFudA0KaGVy
ZSAtIGRvbWluYXRlZCBieSB3aGF0IGhhcHBlbnMgbGF0ZXIuDQpJdCBwcm9iYWJseSBpc24ndCBl
dmVuIHdvcnRoIGFsaWduaW5nIGEgNjRiaXQgY29uc3RhbnQuDQpEb2luZyB0d28gcmVhZHMgcHJv
YmFibHkgd29uJ3QgYmUgbm90aWNhYmxlLg0KDQpXaGF0IHlvdSBkbyB3YW50IHRvIGVuc3VyZSBp
cyB0aGF0IHRoZSBpbml0aWFsIHBhdGNoIGlzDQpvdmVyd3JpdGluZyBub3AgLSBqdXN0IGluIGNh
c2UgdGhlIGdhcCBpc24ndCB0aGVyZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

