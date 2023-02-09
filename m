Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01376913B1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjBIWrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjBIWrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:47:01 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544DA21A10
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 14:46:58 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-120-y9Hy2ItONBePGdE4Dx08xA-1; Thu, 09 Feb 2023 22:46:55 +0000
X-MC-Unique: y9Hy2ItONBePGdE4Dx08xA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Thu, 9 Feb
 2023 22:46:53 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Thu, 9 Feb 2023 22:46:53 +0000
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
Thread-Index: AQHZPCY58FsBcndYrkieV7dCV5LmRa7HNcCg
Date:   Thu, 9 Feb 2023 22:46:53 +0000
Message-ID: <90ad3009049e4d39a952b6e4c170740b@AcuMS.aculab.com>
References: <20230112090603.1295340-1-guoren@kernel.org>
 <c68bac83-5c88-80b1-bac9-e1fd4ea8f07e@yadro.com>
 <CAJF2gTQm11px3mqyrNk1SRiJZud1yeY2avK99UX9KetWAGe5BA@mail.gmail.com>
 <Y+DOyqehZvBJlb8N@FVFF77S0Q05N>
 <CAJF2gTQ6U1vH79Mu53eQ-GVaFx36C-hEt9Qf6=_vAkHfmgFh1Q@mail.gmail.com>
 <Y+IXB4xQ7ACQWC9U@FVFF77S0Q05N>
 <CAJF2gTTrX+8wCm-g=L9+3BkCRrZ8SCUM2w1e5duq-+Bsa213mA@mail.gmail.com>
 <Y+O1qY453BnhqgQZ@FVFF77S0Q05N.cambridge.arm.com>
 <CAJF2gTT_aMBx3mPnzWWqj6uGM75yT_62x+_wZ4HkWd7BqEzvug@mail.gmail.com>
In-Reply-To: <CAJF2gTT_aMBx3mPnzWWqj6uGM75yT_62x+_wZ4HkWd7BqEzvug@mail.gmail.com>
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

RnJvbTogR3VvIFJlbg0KPiBTZW50OiAwOSBGZWJydWFyeSAyMDIzIDAxOjMxDQouLi4NCj4gPiBJ
J20gYSBiaXQgY29uZnVzZWQgdGhlcmU7IEkgdGhvdWdodCB0aGF0IHRoZSBgc3ltYm9sKHJlZylg
IGFkZHJlc3NpbmcgbW9kZSB3YXMNCj4gPiBnZW5lcmF0aW5nIGFkZGl0aW9uYWwgYml0cyB0aGF0
IHRoZSBBVVBJQyBkaWRuJ3QgLS0gaGF2ZSBJIGdvdCB0aGF0IHdyb25nPw0KPiA+DQo+ID4gV2hh
dCBzcGVjaWZpZXMgd2hpY2ggcmVnaXN0ZXIgdGhlIEpBTFIgd2lsbCB3cml0ZSB0aGUgbGluayBh
ZGRyZXNzIHRvPw0KPg0KPiBBY2NvcmRpbmcgdG8gdGhlIHNwZWMsIGF1aXBjIHQxLDB4MCBzaG91
bGQgd3JpdGUgUEMgKyAweDA8PDEyICh3aGljaA0KPiBpcyBlcXVhbCB0byBQQykgdG8gdDEgYW5k
IHRoZW4gamFsciB0MCwgKHQwKTAganVtcHMgdG8gdGhlIGFkZHJlc3MNCj4gc3RvcmVkIGluIHQw
ICsgMHgwIGFuZCBzdG9yZXMgdGhlIHJldHVybiBhZGRyZXNzIHRvIHQwLg0KPiANCj4gVGhhdCBt
ZWFucyBhdWlwYyBkZWZpbmVzIHh4eCA8PCAxMiBiaXRzLCBqYWxyIGRlZmluZXMgbG93ZXN0IDEy
IGJpdHMuDQoNCi4uLg0KPiBXaGF0IEkgd2FudCB0byBwb2ludCBvdXQ6DQo+IElmIHdlIGtlZXAg
ImF1aXBjIChhZGRyKzAwKSIgZml4ZWQsIHdlIGNvdWxkIHVzZSB0aGUgZGlmZmVyZW50DQo+IHRy
YW1wb2xpbmVzIGF0ICJqYWxyIChhZGRyKzB4NCkiIChBbGwgb2YgdGhlbSBtdXN0IGJlIGluIG9u
ZSAyaw0KPiBhbGlnbmVkIGFyZWEpLg0KDQpJIGxvb2tlZCB1cCBhdWlwYzoNCiJBVUlQQyBpcyB1
c2VkIHRvIGJ1aWxkIFBDLXJlbGF0aXZlIGFkZHJlc3NlcyBhbmQgdXNlcyB0aGUgVS10eXBlIGZv
cm1hdC4NCkFVSVBDIGZvcm1zIGEgMzItYml0IG9mZnNldCBmcm9tIHRoZSBVLWltbWVkaWF0ZSwg
ZmlsbGluZyBpbiB0aGUgbG93ZXN0DQoxMiBiaXRzIHdpdGggemVyb3MsIGFkZHMgdGhpcyBvZmZz
ZXQgdG8gdGhlIGFkZHJlc3Mgb2YgdGhlIEFVSVBDIGluc3RydWN0aW9uLA0KdGhlbiBwbGFjZXMg
dGhlIHJlc3VsdCBpbiByZC4iDQoNClNvIGl0IGdlbmVyYXRlcyAncGMgKyAodmFsIDw8IDEyKScu
DQpBbmQgdGhlIGphbHIgdGhlbiBhZGRzIGluIGEgMTJiaXQgb2Zmc2V0Lg0KDQpJIHRoaW5rIHRo
YXQgbWVhbnMgdGhhdCBpZiB5b3UgaGF2ZSB0d28gdHJhbXBvbGluZXMgeW91IG1pZ2h0IG5lZWQN
CnRvIGNoYW5nZSBib3RoIGluc3RydWN0aW9ucyBldmVuIGlmIHRoZSB0d28gdHJhbXBvbGluZXMg
YXJlIGFjdHVhbGx5DQphZGphY2VudCBpbnN0cnVjdGlvbnMuDQpJdCBpcyB0aGUgZGlzdGFuY2Ug
ZnJvbSB0aGUgY2FsbCBzaXRlIHRoYXQgbXVzdG4ndCBjcm9zcyBhIDJrDQpib3VuZGFyeSAtIG5v
dCB0aGUgYWJzb2x1dGUgYWRkcmVzcyBvZiB0aGUgdHJhbXBvbGluZSBpdHNlbGYuDQoNCglEYXZp
ZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=

