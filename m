Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FEE72AE6A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 21:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjFJTby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 15:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFJTbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 15:31:52 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922E9AD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 12:31:50 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-133-ozbbM19YMVelK_WrTOSHKw-1; Sat, 10 Jun 2023 20:31:48 +0100
X-MC-Unique: ozbbM19YMVelK_WrTOSHKw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 10 Jun
 2023 20:31:42 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 10 Jun 2023 20:31:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rasmus Villemoes' <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>
CC:     Richard Weinberger <richard@nod.at>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Sergey Senozhatsky" <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Subject: RE: [RFC PATCH 0/1] Integer overflows while scanning for integers
Thread-Topic: [RFC PATCH 0/1] Integer overflows while scanning for integers
Thread-Index: AQHZmrqmhOoyRHuWh0WX/GnnSQjPva+ET1HA
Date:   Sat, 10 Jun 2023 19:31:42 +0000
Message-ID: <17e5e7c31b2347a6b87c6533c59899d0@AcuMS.aculab.com>
References: <20230607223755.1610-1-richard@nod.at>
 <202306071634.51BBAFD14@keescook> <ZIHzbBXlxEz6As9N@alley>
 <9cd596d9-0ecb-29fc-fe18-f19b86a5ba44@rasmusvillemoes.dk>
In-Reply-To: <9cd596d9-0ecb-29fc-fe18-f19b86a5ba44@rasmusvillemoes.dk>
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

RnJvbTogUmFzbXVzIFZpbGxlbW9lcw0KPiBTZW50OiAwOSBKdW5lIDIwMjMgMTE6MTANCj4gDQo+
IE9uIDA4LzA2LzIwMjMgMTcuMjcsIFBldHIgTWxhZGVrIHdyb3RlOg0KPiA+IE9uIFdlZCAyMDIz
LTA2LTA3IDE2OjM2OjEyLCBLZWVzIENvb2sgd3JvdGU6DQo+IA0KPiA+IEl0IHNlZW1zIHRoYXQg
dXNlcnNwYWNlIGltcGxlbWVudGF0aW9uIG9mIHNzY2FuZigpIGFuZCB2c3NjYW5mKCkNCj4gPiBy
ZXR1cm5zIC1FUkFOR0UgaW4gdGhpcyBjYXNlLiBJdCBtaWdodCBiZSBhIHJlYXNvbmFibGUgc29s
dXRpb24uDQo+IA0KPiBXZWxsLiBfU29tZV8gdXNlcnNwYWNlIGltcGxlbWVudGF0aW9uIGRvZXMg
dGhhdC4gSXQncyBub3QgaW4gUE9TSVguDQo+IFdoaWxlICJtYW4gc2NhbmYiIGxpc3RzIHRoYXQg
RVJBTkdFIGVycm9yLCBpdCBhbHNvIGV4cGxpY2l0bHkgc2F5cyB0aGF0Og0KPiANCj4gQ09ORk9S
TUlORyBUTw0KPiAgICAgICAgVGhlIGZ1bmN0aW9ucyBmc2NhbmYoKSwgc2NhbmYoKSwgYW5kIHNz
Y2FuZigpIGNvbmZvcm0gdG8gQzg5IGFuZA0KPiBDOTkgYW5kIFBPU0lYLjEtMjAwMS4gIFRoZXNl
IHN0YW5kYXJkcyBkbyAgbm90ICBzcGVjaWZ5ICB0aGUNCj4gICAgICAgIEVSQU5HRSBlcnJvci4N
Cj4gDQo+IEkgY2FuJ3QgZmlndXJlIG91dCB3aGF0IFBPU0lYIGFjdHVhbGx5IHNheXMgc2hvdWxk
IG9yIGNvdWxkIGhhcHBlbiB3aXRoDQo+IHNzY2FuZigiOTk5OTk5OTk5OTk5OTkiLCAiJWkiLCAm
eCk7DQoNClBvc3NpYmx5ICd1bmRlZmluZWQgYmVoYXZpb3VyJyAtIHRoZXkgbGlrZSB0aGF0IG9u
ZS4NCg0KQnV0IEknbSBzdXJlIEkgcmVtZW1iZXIgdGhlIFRvRyAnVW5peCcgZGVmaW5pdGlvbiBu
b3QgcmVxdWlyaW5nIHRoYXQNCid1dGlsaXRpZXMnIGNoZWNrIGZvciBvdmVyZmxvdyBvbiBudW1l
cmljIGNvbW1hbmQgbGluZSBwYXJhbWV0ZXJzLg0KKEl0IG1pZ2h0IGV2ZW4gaGF2ZSBzYWlkIHRo
ZXkgd291bGRuJ3QgY2hlY2suKQ0KU28gaXQgd2FzIHBlcmZlY3RseSB2YWxpZCBmb3IgYSBzdHVw
aWRseSBvdXQgb2YgcmFuZ2UgdmFsdWUNCnRvIGJlIHRyZWF0ZWQgYXMgYSBkaWZmZXJlbnQgKHBv
c3NpYmx5IHZhbGlkKSB2YWx1ZS4NCg0KV2hhdCBpcyBjbGVhcmx5IHdyb25nIGlzIHRvIGp1c3Qg
c3RvcCBwcm9jZXNzaW5nIHRoZQ0KaW5wdXQgc3RyaW5nLg0Kc3NjYW5mKCI5OTk5OTk5OTk5OTk5
OTk5OTk5c2NhbGUiLCAiJWklcyIsICZ4LCAmc2NhbGUpDQp3cml0aW5nIGFueSAnOScgdG8gc2Nh
bGUgaXMgY2xlYXJseSBicm9rZW4uDQoNClBlcnNvbmFsbHkgSSBhdm9pZCBzY2FuZigpIC0gaXQg
aXMgZmFyIHRvbyBlYXN5IGZvciBpdCB0byBkbw0Kc29tZXRoaW5nIHlvdSBkaWRuJ3QgcmVhbGx5
IGludGVuZC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

