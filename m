Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472137284E0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbjFHQ0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjFHQZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:25:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104B52D77
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:25:47 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-180-7GgM7L5QM4ebJO7aNat22A-1; Thu, 08 Jun 2023 17:25:45 +0100
X-MC-Unique: 7GgM7L5QM4ebJO7aNat22A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 8 Jun
 2023 17:25:41 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 8 Jun 2023 17:25:41 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "longman@redhat.com" <longman@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] Lock and Pointer guards
Thread-Topic: [PATCH v2 0/2] Lock and Pointer guards
Thread-Index: AQHZmI4JX03CRQdMAEiMc4oxzAWNOq+BFX9g
Date:   Thu, 8 Jun 2023 16:25:41 +0000
Message-ID: <1a9a927f94cc4a8fa2d5de8c660f6d09@AcuMS.aculab.com>
References: <20230526205204.861311518@infradead.org>
 <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net>
 <20230606094251.GA907347@hirez.programming.kicks-ass.net>
 <202306060829.C2FD998CF@keescook>
 <CAHk-=wh=vs298o0gewFH725pQAYQ57CAQzj05FOx_VZubZ3jiA@mail.gmail.com>
In-Reply-To: <CAHk-=wh=vs298o0gewFH725pQAYQ57CAQzj05FOx_VZubZ3jiA@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDYgSnVuZSAyMDIzIDE2OjQ2DQo+IA0KPiBP
biBUdWUsIEp1biA2LCAyMDIzIGF0IDg6MzHigK9BTSBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9t
aXVtLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBuaXQ6IExpbnVzJ3MgZXhhbXBsZSB3YXMgIih2b2lk
ICopOCIgKGluc3RlYWQgb2YgMSkgYmVjYXVzZSB3ZSd2ZSBoYWQNCj4gPiBpc3N1ZXMgaW4gdGhl
IHBhc3Qgd2l0aCBhbGlnbm1lbnQgd2FybmluZ3Mgb24gYXJjaHMgdGhhdCBhcmUgc2Vuc2l0aXZl
DQo+ID4gdG8gaXQuIChlLmcuIHNlZSB0aGUgX19pc19jb25zdGV4cHIoKSBtYWNybyB3aGljaCBp
cyBkb2luZyBOVUxMLyFOVUxMDQo+ID4gY29tcGFyaXNvbnMuKQ0KDQpfX2lzX2NvbnN0ZXhwcigp
IGlzIHBsYXlpbmcgZW50aXJlbHkgZGlmZmVyZW50IGdhbWVzLg0KQmFzaWNhbGx5IHRoZSB0eXBl
IG9mICh4ID8gKHZvaWQgKil5IDogKGludCAqKXopDQpkZXBlbmRzIG9uIHdoZXRoZXIgJ3knIGlz
IGEgY29tcGlsZS10aW1lIDAgKGludCAqKSBvciBub3QgKHZvaWQgKikuDQoNCi4uLg0KPiBTbyBJ
J20gbm90IHN1cmUgdGhlIDEtdnMtOCBhY3R1YWxseSBtYXR0ZXJzLiBXZSBkbyBvdGhlciB0aGlu
Z3MgdGhhdA0KPiBhc3N1bWUgdGhhdCBsb3cgYml0cyBpbiBhIHBvaW50ZXIgYXJlIHJldGFpbmVk
IGFuZCB2YWxpZCwgZXZlbiBpZiBpbg0KPiB0aGVvcnkgdGhlIEMgdHlwZSBzeXN0ZW0gbWlnaHQg
aGF2ZSBpc3N1ZXMgd2l0aCBpdC4NCg0KWWVzLCBnaXZlbiB0aGF0IGdjYyB3aWxsIGFzc3VtZSBh
IHBvaW50ZXIgaXMgYWxpZ25lZCBpZiB5b3UgdHJ5DQp0byBtZW1jcHkoKSBmcm9tIGl0LCBJJ20g
c3VycHJpc2VkIGl0IGRvZXNuJ3QgYWx3YXlzIGFzc3VtZSB0aGF0Lg0KSW4gd2hpY2ggY2FzZSAo
bG9uZylwdHJfdG9faW50ICYgMyBjYW4gYmUgdmFsaWRseSBhc3N1bWVkIHRvIGJlIHplcm8uDQoN
CkkndmUgZm91bmQgc29tZSAnZGF5IGpvYicgY29kZSB0aGF0IHBhc3NlZCB0aGUgYWRkcmVzcyBv
ZiBhDQptZW1iZXIgb2YgYSAncGFja2VkJyBzdHJ1Y3R1cmUgdG8gYSBmdW5jdGlvbiB3aGljaCB0
aGVuIHVzZWQNCmhvc3Qgb3JkZXJlZCB1bnNpZ25lZCBjaGFyW10gYWNjZXNzZXMuDQpUaGUgY29t
cGlsZXIgaXMgY2VydGFpbmx5IGFsbG93ZWQgdG8gY29udmVydCB0aGF0IGJhY2sgdG8NCmEgd29y
ZCB3cml0ZSAtIHdoaWNoIHdvdWxkIHRoZW4gZmF1bHQuDQooSSd2ZSBub3QgbG9va2VkIHRvIHNl
ZSBpZiBhbnkgbW9kZXJuIGNvbXBpbGVycyBkby4pDQpPZiBjb3Vyc2UgdGhlIHNpbXBsZSBwdHIt
Pm1lbWJlciB3b3VsZCBoYXZlIGJlIGZpbmUuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFk
ZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywg
TUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

