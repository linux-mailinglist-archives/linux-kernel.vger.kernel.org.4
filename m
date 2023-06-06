Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328FD723B69
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbjFFIYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjFFIYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:24:20 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92600E6A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:24:00 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-27-nSSzYmyDMbyDTK30Pb0fqg-1; Tue, 06 Jun 2023 09:23:54 +0100
X-MC-Unique: nSSzYmyDMbyDTK30Pb0fqg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 6 Jun
 2023 09:23:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 6 Jun 2023 09:23:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'H. Peter Anvin'" <hpa@zytor.com>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
CC:     Steven Noonan <steven@uplinklabs.net>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: RE: Direct rdtsc call side-effect
Thread-Topic: Direct rdtsc call side-effect
Thread-Index: AQHZlHOrHGvpd378GUKTvqmuipgWK698BnPAgAA4NYCAACHzkP///FcAgAEVfSA=
Date:   Tue, 6 Jun 2023 08:23:52 +0000
Message-ID: <cabfcf8a8840410399d2bfc1202e77ce@AcuMS.aculab.com>
References: <6719fb05-382c-8ec4-ccda-72798906a54b@collabora.com>
 <87mt1jeax1.ffs@tglx> <353732783fde46919fdcf698c326b7ed@AcuMS.aculab.com>
 <87jzwi55qo.ffs@tglx> <a39d90e45212461bb31738b7156b60a6@AcuMS.aculab.com>
 <4ea6e82c-4761-e0c9-3e75-8ec39eecb30a@zytor.com>
In-Reply-To: <4ea6e82c-4761-e0c9-3e75-8ec39eecb30a@zytor.com>
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

RnJvbTogSC4gUGV0ZXIgQW52aW4NCj4gU2VudDogMDUgSnVuZSAyMDIzIDE3OjMyDQouLi4NCj4g
VGhlIFRTQyBpcyBjZXJ0YWlubHkgbm90IHBlcmZlY3Q7IHBhcnRseSBiZWNhdXNlLCBpcm9uaWNh
bGx5IGVub3VnaCwgaXQNCj4gd2FzIGludHJvZHVjZWQganVzdCAqYmVmb3JlKiBvdXQgb2Ygb3Jk
ZXIgYW5kIHBvd2VyIG1hbmFnZW1lbnQgZW50ZXJlZA0KPiB0aGUgeDg2IHdvcmxkLg0KDQpBbm90
aGVyIGlzc3VlIGlzIHRoYXQgdGhlIGNyeXN0YWwgdXNlZCBmb3IgdGhlIGNwdSBjbG9jayB3b24n
dCBiZQ0KdGhhdCBhY2N1cmF0ZSAoaW4gdGVybXMgb2YgcHBtIGVycm9yIHJhdGUpLCBhbmQgd2ls
bCBoYXZlIHNpZ25pZmljYW50DQp0ZW1wZXJhdHVyZSBkcmlmdC4NCk9UT0ggdGhlIGNyeXN0YWwg
aW4gdGhlIHRyYWRpdGlvbmFsIHg4NiBtb3RoZXJib2FyZCAnY2xvY2snIGNoaXANCmlzIChtZWFu
dCB0byBiZSkgZGVzaWduZWQgdG8gaGF2ZSBsb25nIHRlcm0gYWNjdXJhY3kuDQpXaGlsZSByZWFk
aW5nIHRoZSBUU0MgaXMgYSBsb3QgZmFzdGVyIHRoZXJlIG91Z2h0IHRvIGhhdmUgYmVlbg0Kc29t
ZSBraW5kIG9mIFBMTCB0byBjb250aW51b3VzbHkgYWRqdXN0IHRoZSBtZWFzdXJlZCBUU0MgZnJl
cXVlbmN5DQp0byBrZWVwIHN5bmNocm9uaXNlZCB3aXRoIHRoZSB0aW1lciBjaGlwLg0KKEluc3Rl
YWQga2VybmVscyBlbmQgdXAgd3JpdGluZyB0aGUgZHJpZnRlZCBUU0MgYmFzZWQgdGltZSBiYWNr
IHRvDQp0aGUgdGltZXIgY2hpcCBkdXJpbmcgc2h1dGRvd24uKSANCg0KPiBJdCBpcyBubyBzZWNy
ZXQgdGhhdCBpdCBoYXMgYmVlbiBzbG93IHRvIGNhdGNoIHVwLiBJdCB3YXMgZWFzeSB0byBwdXQg
YQ0KPiBjb3VudGVyIGluOyBpdCBpcyBhICpsb3QqIGhhcmRlciB0byBtYWtlIGl0IHdvcmsgaW4g
YWxsIHRoZSBwb3NzaWJsZQ0KPiBzY2VuYXJpb3MgaW4gdGhlIHBvd2VyLW1hbmFnZWQsIG91dC1v
Zi1vcmRlciB3b3JsZC4NCg0KVGhhdCByYXRoZXIgZGVwZW5kcyBvbiB3aGF0IHlvdSBtZWFuIGJ5
ICd3b3JrJyA6LSkNCg0KPiBJdCBpcyBvbmUgb2YgbXkgcGVyc29uYWwgcGV0IHByb2plY3RzIGlu
IHRoZSBhcmNoaXRlY3R1cmUgd29yayB0byBwdXNoDQo+IHRvIGdldCB0aGF0IGxhc3QgZGlzdGFu
Y2U7IHdlIGFyZSBub3QgeWV0IHRoZXJlLg0KDQpGb3IgcGVyZm9ybWFuY2UgbWVhc3VyZW1lbnRz
IHBvc3NpYmx5IHdoYXQgeW91IHdhbnQgaXMgYSBzaW1wbGUNCmNsb2NrIGNvdW50ZXIgd2hpY2gg
aXMgZGVwZW5kZW50IG9uIGFuIGEgcmVnaXN0ZXIuDQpTbyBwcmV0dHkgbXVjaCB6ZXJvIG92ZXJo
ZWFkIGJ1dCBpcyBndWFyYW50ZWVkIHRvIGhhcHBlbiBhZnRlcg0Kc29tZSBvdGhlciBpbnN0cnVj
dGlvbiB3aXRob3V0IHJlYWxseSBhZmZlY3RpbmcgdGhlIHBpcGVsaW5lLg0KDQpJSVJDIHRoZSB4
ODYgcGVyZm9ybWFuY2UgY291bnRlcnMgYXJlbid0IGRlcGVuZGVudCBvbiBhbnl0aGluZw0Kc28g
dGhleSB0ZW5kIHRvIGV4ZWN1dGUgbXVjaCBlYXJsaWVyIHRoYW4geW91IHdhbnQuDQpPVE9IIHJk
dHNjIGlzIGxpa2VseSB0byBiZSBzeW5jaHJvbmlzaW5nIGFuZCBhZmZlY3Qgd2hhdCBmb2xsb3dz
Lg0KSVNUUiB1c2luZyByZHRzYyB0byB3YWl0IGZvciBpbnN0cnVjdGlvbnMgdG8gY29tcGxldGUg
YW5kIHRoZW4NCnRoZSBwZXJmb3JtYW5jZSBjbG9jayBjb3VudGVyIHRvIHNlZSBob3cgbG9uZyBp
dCB0b29rLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFt
bGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3Ry
YXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

