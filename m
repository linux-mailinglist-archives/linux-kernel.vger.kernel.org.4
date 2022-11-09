Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1D1622632
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiKIJEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiKIJEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:04:42 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DC51A20D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:04:40 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-56-F6hqTQPdMNuxkLz7d09ESQ-1; Wed, 09 Nov 2022 09:04:37 +0000
X-MC-Unique: F6hqTQPdMNuxkLz7d09ESQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 9 Nov
 2022 09:04:36 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Wed, 9 Nov 2022 09:04:36 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jann Horn' <jannh@google.com>
CC:     Kees Cook <keescook@chromium.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] exit: Put an upper limit on how often we can oops
Thread-Topic: [PATCH] exit: Put an upper limit on how often we can oops
Thread-Index: AQHY8uVtJeqm4QnZJEegjt8nfpQUG640wW1QgABcZ4CAAS8xAA==
Date:   Wed, 9 Nov 2022 09:04:36 +0000
Message-ID: <d88999d8e9ec486bb1a0f75911457985@AcuMS.aculab.com>
References: <20221107201317.324457-1-jannh@google.com>
 <3e2f7e2cb4f6451a9ef5d0fb9e1f6080@AcuMS.aculab.com>
 <CAG48ez3AGh-R+deQMbNPt6PCQazOz8a96skW+qP3_HmUaANmmQ@mail.gmail.com>
In-Reply-To: <CAG48ez3AGh-R+deQMbNPt6PCQazOz8a96skW+qP3_HmUaANmmQ@mail.gmail.com>
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

RnJvbTogSmFubiBIb3JuDQo+IFNlbnQ6IDA4IE5vdmVtYmVyIDIwMjIgMTQ6NTMNCj4gDQo+IE9u
IFR1ZSwgTm92IDgsIDIwMjIgYXQgMTA6MjYgQU0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRA
YWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4gPiBNYW55IExpbnV4IHN5c3RlbXMgYXJlIGNvbmZpZ3Vy
ZWQgdG8gbm90IHBhbmljIG9uIG9vcHM7IGJ1dCBhbGxvd2luZyBhbg0KPiA+ID4gYXR0YWNrZXIg
dG8gb29wcyB0aGUgc3lzdGVtICoqcmVhbGx5Kiogb2Z0ZW4gY2FuIG1ha2UgZXZlbiBidWdzIHRo
YXQgbG9vaw0KPiA+ID4gY29tcGxldGVseSB1bmV4cGxvaXRhYmxlIGV4cGxvaXRhYmxlIChsaWtl
IE5VTEwgZGVyZWZlcmVuY2VzIGFuZCBzdWNoKSBpZg0KPiA+ID4gZWFjaCBjcmFzaCBlbGV2YXRl
cyBhIHJlZmNvdW50IGJ5IG9uZSBvciBhIGxvY2sgaXMgdGFrZW4gaW4gcmVhZCBtb2RlLCBhbmQN
Cj4gPiA+IHRoaXMgY2F1c2VzIGEgY291bnRlciB0byBldmVudHVhbGx5IG92ZXJmbG93Lg0KPiA+
ID4NCj4gPiA+IFRoZSBtb3N0IGludGVyZXN0aW5nIGNvdW50ZXJzIGZvciB0aGlzIGFyZSAzMiBi
aXRzIHdpZGUgKGxpa2Ugb3Blbi1jb2RlZA0KPiA+ID4gcmVmY291bnRzIHRoYXQgZG9uJ3QgdXNl
IHJlZmNvdW50X3QpLiAoVGhlIGxkc2VtIHJlYWRlciBjb3VudCBvbiAzMi1iaXQNCj4gPiA+IHBs
YXRmb3JtcyBpcyBqdXN0IDE2IGJpdHMsIGJ1dCBwcm9iYWJseSBub2JvZHkgY2FyZXMgYWJvdXQg
MzItYml0IHBsYXRmb3Jtcw0KPiA+ID4gdGhhdCBtdWNoIG5vd2FkYXlzLikNCj4gPiA+DQo+ID4g
PiBTbyBsZXQncyBwYW5pYyB0aGUgc3lzdGVtIGlmIHRoZSBrZXJuZWwgaXMgY29uc3RhbnRseSBv
b3BzaW5nLg0KPiA+DQo+ID4gSSB0aGluayB5b3UgYXJlIHByZXR0eSBtdWNoIGd1YXJhbnRlZWQg
dG8gcnVuIG91dCBvZiBtZW1vcnkNCj4gPiAob3IgYXQgbGVhc3QgS1ZBKSBiZWZvcmUgYW55IDMy
Yml0IGNvdW50ZXIgd3JhcHMuDQo+IA0KPiBOb3QgaWYgeW91IHJlcGVhdGVkbHkgdGFrZSBhIHJl
ZmVyZW5jZSBhbmQgdGhlbiBvb3BzIHdpdGhvdXQgZHJvcHBpbmcNCj4gdGhlIHJlZmVyZW5jZSwg
YW5kIHRoZSBvb3BzIHBhdGggY2xlYW5zIHVwIGFsbCB0aGUgcmVzb3VyY2VzIHRoYXQgd2VyZQ0K
PiBhbGxvY2F0ZWQgZm9yIHRoZSBjcmFzaGluZyB0YXNrcy4gSW4gdGhhdCBjYXNlLCBlYWNoIG9v
cHMgaW5jcmVtZW50cw0KPiB0aGUgcmVmZXJlbmNlIGNvdW50IGJ5IDEgd2l0aG91dCBjYXVzaW5n
IG1lbW9yeSBhbGxvY2F0aW9uLg0KDQpJJ2QgaGF2ZSB0aG91Z2h0IHRoYXQgdGhlIGtlcm5lbCBz
dGFjayBhbmQgcHJvY2VzcyBhcmVhcyBjb3VsZG4ndA0KYmUgZnJlZWQgYmVjYXVzZSB0aGV5IG1p
Z2h0IGNvbnRhaW4gJ2xpdmUgZGF0YScuDQpUaGVyZSBpcyBhbHNvIHRoZSBtdWNoIHNtYWxsZXIg
cGlkX3Qgc3RydWN0dXJlLg0KDQpPZiBjb3Vyc2UgSSBtaWdodCBiZSB3cm9uZy4uLg0KQnV0IEkn
bSBzdXJlIC9wcm9jL3BpZC9zdGFjayBpcyB2YWxpZCBmb3IgYW4gb29wc2VkIHByb2Nlc3MuDQoN
CglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzog
MTM5NzM4NiAoV2FsZXMpDQo=

