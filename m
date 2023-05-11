Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DDC6FEFB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbjEKKN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbjEKKNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:13:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62175A1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:13:24 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-311-LyBOZeqoPaWomRdUL1eB4A-1; Thu, 11 May 2023 11:13:21 +0100
X-MC-Unique: LyBOZeqoPaWomRdUL1eB4A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 11 May
 2023 11:13:20 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 11 May 2023 11:13:20 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Pavel Tikhomirov' <ptikhomirov@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com" 
        <syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        "Michael Kerrisk" <mtk.manpages@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        "Christian Brauner" <brauner@kernel.org>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Pavel Emelyanov <xemul@openvz.org>
Subject: RE: [RFD] posix-timers: CRIU woes
Thread-Topic: [RFD] posix-timers: CRIU woes
Thread-Index: AQHZgvkS9FkXfpzWe0mDw5RKx9AGK69U2eWg
Date:   Thu, 11 May 2023 10:13:20 +0000
Message-ID: <8a42097629844e5eacf733328eac2d02@AcuMS.aculab.com>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de> <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx> <87v8h62vwp.ffs@tglx> <878rdy32ri.ffs@tglx>
 <87v8h126p2.ffs@tglx> <875y911xeg.ffs@tglx> <87ednpyyeo.ffs@tglx>
 <009e7658-1377-cc79-7a42-4dda8fec5af0@virtuozzo.com>
In-Reply-To: <009e7658-1377-cc79-7a42-4dda8fec5af0@virtuozzo.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGF2ZWwgVGlraG9taXJvdg0KPiBTZW50OiAxMCBNYXkgMjAyMyAwNTozNw0KLi4uDQo+
ID4gICAgICBBIGRlbnNlIElEIHNwYWNlIGFwcHJvYWNoIGNhbiBjcmVhdGUgaG9sZXMgdG9vLCBi
dXQgdGhleSBhcmUNCj4gPiAgICAgIHJlY292ZXJhYmxlIGFuZCB3ZWxsIHdpdGhpbiB0aGUgcmVz
b3VyY2UgbGltaXRzLCBiZWNhdXNlIHRoZSBwcm9jZXNzDQo+ID4gICAgICBoYXMgdG8gYmUgYWJs
ZSB0byBjcmVhdGUgZW5vdWdoIHRpbWVycyBpbiB0aGUgZmlyc3QgcGxhY2UgaW4gb3JkZXINCj4g
PiAgICAgIHRvIHJlbGVhc2UgdGhvc2UgaW4gdGhlIG1pZGRsZS4NCg0KV2hpbGUgaXQgZG9lc24n
dCBoZWxwIGF0IGFsbCBmb3IgY3JlYXRpbmcgaXRlbXMgd2l0aCBmaXhlZCBpZHMsDQpteSAnZmF2
b3VyaXRlJyBzY2hlbWUgZm9yIGFsbG9jYXRpbmcgaWRzIGl0IHRvIGFsbG9jYXRlIGEgbnVtYmVy
DQp0aGF0IHdpbGwgYmUgYSBwZXJmZWN0IGhhc2ggb250byBhbiBlbXB0eSBoYXNoIHRhYmxlIHNs
b3QuDQoNClRoZSBsb29rdXAgY2hlY2sgaXMgdGhlbiBqdXN0IGFycmF5W2lkICYgbWFza10uaWQg
PT0gaWQuDQpBIEZJRk8gZnJlZWxpc3QgY2FuIGJlIHJ1biB0aHJvdWdoIHRoZSBmcmVlIGVudHJp
ZXMgYW5kDQp0aGUgaGlnaCBiaXRzIGluY3JlbWVudGVkIGVhY2ggdGltZSBhIHNsb3QgaXMgdXNl
ZC4NClNvIGFsbG9jYXRpb24gaXMgdXN1YWxseSBmaXhlZCBjb3N0Lg0KDQpJZiB0aGUgdGFibGUg
aXMgZnVsbCBpdCdzIHNpemUgY2FuIGVhc2lseSBiZSBkb3VibGVkLg0KSWYgdGhlIG51bWJlciBv
ZiB1bnVzZWQgZW50cmllcyBpcyBkb3VibGVkIGVhY2ggdGltZQ0KdGhlIHRhYmxlIHNpemUgaXMg
ZG91YmxlZCB0aGVuIHRoZSB5b3UgKG1vcmUgb3IgbGVzcykNCmd1YXJhbnRlZSB0aGF0IGFuIGlk
IHdvbid0IGdldCByZXVzZWQgYW55IHRpbWUgc29vbg0KYWZ0ZXIgaXQgaXMgZnJlZWQuDQoNClRo
aXMgd291bGQgYmUgb2sgZm9yIHJlc3RvcmluZyBpZHMgYWxsb2NhdGVkIGJ5IHRoZSBzYW1lDQpz
Y2hlbWUuIEJ1dCB3b3VsZCBuZWVkIGEgZmFsbGJhY2sgZm9yIHJlc3RvcmluZyBwYXRob2xvZ2lj
YWwNCmxpc3Qgb2YgaWRzLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

