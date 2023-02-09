Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DA76902B3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBIJAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBIJAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:00:21 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553F46A50
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:00:19 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-310-f-7qB-QRPTeL7-rfR361BA-1; Thu, 09 Feb 2023 09:00:16 +0000
X-MC-Unique: f-7qB-QRPTeL7-rfR361BA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Thu, 9 Feb
 2023 09:00:13 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Thu, 9 Feb 2023 09:00:13 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Guo Ren' <guoren@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Evgenii Shatokhin <e.shatokhin@yadro.com>,
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
Thread-Index: AQHZO2Vv8FsBcndYrkieV7dCV5LmRa7FoF6ggAA6xYCAAHaDsA==
Date:   Thu, 9 Feb 2023 09:00:13 +0000
Message-ID: <f00256bcbe114669acca1b0105cefb99@AcuMS.aculab.com>
References: <20230112090603.1295340-1-guoren@kernel.org>
 <c68bac83-5c88-80b1-bac9-e1fd4ea8f07e@yadro.com>
 <CAJF2gTQm11px3mqyrNk1SRiJZud1yeY2avK99UX9KetWAGe5BA@mail.gmail.com>
 <Y+DOyqehZvBJlb8N@FVFF77S0Q05N>
 <CAJF2gTQ6U1vH79Mu53eQ-GVaFx36C-hEt9Qf6=_vAkHfmgFh1Q@mail.gmail.com>
 <Y+IXB4xQ7ACQWC9U@FVFF77S0Q05N>
 <CAJF2gTTrX+8wCm-g=L9+3BkCRrZ8SCUM2w1e5duq-+Bsa213mA@mail.gmail.com>
 <8154e7e618d84e298bad1dc95f26c000@AcuMS.aculab.com>
 <CAJF2gTQGxxgusRgPdNaw4-d+o0a4vefUj7PNpZuym6VKQC4dhw@mail.gmail.com>
In-Reply-To: <CAJF2gTQGxxgusRgPdNaw4-d+o0a4vefUj7PNpZuym6VKQC4dhw@mail.gmail.com>
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

RnJvbTogR3VvIFJlbg0KPiBTZW50OiAwOSBGZWJydWFyeSAyMDIzIDAxOjUxDQouLi4NCj4gWW91
cnMgY29zdCBvbmUgbW9yZSBpbnN0cnVjdGlvbiwgcmlnaHQ/DQo+ICAgICAgICAgIGFkZHItMTIg
IGF1aXBjDQo+ICAgICAgICAgIGFkZHItOCAgICBqYWxyDQo+ICAgICAgICAgIGFkZHItNCAgICAv
LyBMaXRlcmFsICgzMi1iaXRzKQ0KPiAgICAgICAgICBhZGRyKzAgICBub3Agb3Igam1wIGFkZHIt
biAvLyBvbmUgbW9yZT8NCj4gICAgICAgICAgYWRkcis0ICAgZnVuY3Rpb25fY29kZQ0KDQpZZXMs
IGl0IGlzIDQgYnl0ZXMgbGFyZ2VyIGJ1dCB0aGVyZSBpcyBvbmUgbGVzcw0KaW5zdHJ1Y3Rpb24g
ZXhlY3V0ZWQgKG9ubHkgb25lIG5vcCkgd2hlbiBmdHJhY2UgaXMgZGlzYWJsZWQuDQpUaGF0IHBy
b2JhYmx5IG1hdHRlcnMgbW9yZSB0aGFuIGFueXRoaW5nIGluIHRoZSBmdHJhY2UNCidwcm9sb2d1
ZScgY29kZS4NCg0KSSBhbHNvIHN1c3BlY3QgdGhhdCB5b3UgY2FuIHVzZSBhIDMyYml0IGludGVn
ZXIgYXMNCmEgdGFibGUgaW5kZXggaW4gNjRiaXQgbW9kZSB0byBzYXZlIGEgd29yZCB0aGVyZS4N
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==

