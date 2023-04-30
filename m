Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046646F28A8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 13:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjD3L7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 07:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjD3L7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 07:59:22 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFD72693
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 04:59:21 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-403-6JDYqp_lNlWX5TmoN08BwA-1; Sun, 30 Apr 2023 12:59:18 +0100
X-MC-Unique: 6JDYqp_lNlWX5TmoN08BwA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 30 Apr
 2023 12:59:17 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 30 Apr 2023 12:59:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vernon Lovejoy <vlovejoy@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/show_trace_log_lvl: ensure stack pointer is aligned,
 again
Thread-Topic: [PATCH] x86/show_trace_log_lvl: ensure stack pointer is aligned,
 again
Thread-Index: AQHZei1BLgvPQksxmEaOh5pjR+4dkK9DwORQ
Date:   Sun, 30 Apr 2023 11:59:17 +0000
Message-ID: <aa8537d81dc747a097e9e30491b5081b@AcuMS.aculab.com>
References: <20230427140054.GA17800@redhat.com>
 <20230428043158.r5omehiaqawcac2y@treble> <20230428065513.GA22111@redhat.com>
 <20230428235747.b5smutdttv5eeopi@treble>
In-Reply-To: <20230428235747.b5smutdttv5eeopi@treble>
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

RnJvbTogSm9zaCBQb2ltYm9ldWYNCj4gU2VudDogMjkgQXByaWwgMjAyMyAwMDo1OA0KPiANCj4g
T24gRnJpLCBBcHIgMjgsIDIwMjMgYXQgMDg6NTU6MTNBTSArMDIwMCwgT2xlZyBOZXN0ZXJvdiB3
cm90ZToNCj4gPiBPbiAwNC8yNywgSm9zaCBQb2ltYm9ldWYgd3JvdGU6DQo+ID4gPg0KPiA+ID4g
T24gVGh1LCBBcHIgMjcsIDIwMjMgYXQgMDQ6MDA6NTRQTSArMDIwMCwgT2xlZyBOZXN0ZXJvdiB3
cm90ZToNCj4gPiA+ID4gKwlzdGFjayA9IFBUUl9BTElHTihzdGFjaywgc2l6ZW9mKGxvbmcpKTsN
Cj4gPiA+ID4gIAlmb3IgKCA7IHN0YWNrOyBzdGFjayA9IFBUUl9BTElHTihzdGFja19pbmZvLm5l
eHRfc3AsIHNpemVvZihsb25nKSkpIHsNCj4gPiA+ID4gIAkJY29uc3QgY2hhciAqc3RhY2tfbmFt
ZTsNCj4gPiA+DQo+ID4gPiBTZWVtcyByZWFzb25hYmxlLCB0aG91Z2ggJ3N0YWNrJyBpcyBhbHJl
YWR5IGluaXRpYWxpemVkIGEgZmV3IGxpbmVzDQo+ID4gPiBhYm92ZSB0aGlzLCBzbyBpdCB3b3Vs
ZCBiZSBjbGVhbmVyIHRvIGRvIHRoZSBQVFJfQUxJR04gdGhlbi4gIE9yIGV2ZW4NCj4gPiA+IGJl
dHRlciwganVzdCBtb3ZlIGl0IGFsbCB0byB0aGUgZm9yIGxvb3A6DQo+ID4gPg0KPiA+ID4gCWZv
ciAoc3RhY2sgPSBQVFJfQUxJR04oc3RhY2sgPyA6IGdldF9zdGFja19wb2ludGVyKHRhc2ssIHJl
Z3MpKTsNCj4gPiA+IAkgICAgIHN0YWNrOw0KPiA+ID4gCSAgICAgc3RhY2sgPSBQVFJfQUxJR04o
c3RhY2tfaW5mby5uZXh0X3NwLCBzaXplb2YobG9uZykpKSB7DQo+ID4NCj4gPiBXZSBkZWNpZGVk
IHRvIG1ha2UgdGhlIHNpbXBsZXN0IG9uZS1saW5lciBmaXgsIGJ1dCBJIHdhcyB0aGlua2luZyBh
Ym91dA0KPiA+DQo+ID4gCWZvciAoIHN0YWNrID0gc3RhY2sgPyA6IGdldF9zdGFja19wb2ludGVy
KHRhc2ssIHJlZ3MpOw0KPiA+IAkgICAgIChzdGFjayA9IFBUUl9BTElHTihzdGFjaywgc2l6ZW9m
KGxvbmcpKSk7DQo+ID4gCSAgICAgIHN0YWNrID0gc3RhY2tfaW5mby5uZXh0X3NwKQ0KPiA+IAl7
DQo+ID4gCQkuLi4NCj4gPg0KPiA+IHRvIGZhY3RvdXQgb3V0IHRoZSBhbm5veWluZyBQVFJfQUxJ
R04oKS4gV2lsbCBpdCB3b3JrIGZvciB5b3U/DQo+IA0KPiBJJ2QgcmF0aGVyIG5vdCwgdGhhdCdz
IGEgbGl0dGxlICp0b28qIGNsZXZlciwgSU1PLg0KDQpJJ2QgbGVhdmUgdGhlIGluaXRpYWxpc2F0
aW9uIG91dHNpZGUgdGhlIGxvb3AgYW5kIG1vdmUNCnRoZSBQVFJfQUxJR04oKSBpbnRvIHRoZSBs
b29wIHNvIHRoYXQgdGhlICdmb3InIGZpdHMgb24gb25lIGxpbmU6DQoJaWYgKCFzdGFjaykNCgkJ
c3RhY2sgPSBnZXRfc3RhY2tfcG9pbnRlcih0YXNrLCByZWdzKTsNCglmb3IgKDsgc3RhY2s7IHN0
YWNrID0gc3RhY2tfaW5mby5uZXh0X3NwKSB7DQoJCWNvbnN0IGNoYXIgLi4uDQoJCXN0YWNrID0g
UFRSX0FMSUdOKHN0YWNrLCBzaXplb2YobG9uZykpOw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

