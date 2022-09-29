Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA5E5EF722
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbiI2OEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiI2OEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:04:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AF921AE
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:04:37 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-93-KvRyHvuCNsKu02WK6qGEow-1; Thu, 29 Sep 2022 15:04:34 +0100
X-MC-Unique: KvRyHvuCNsKu02WK6qGEow-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 29 Sep
 2022 15:04:32 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Thu, 29 Sep 2022 15:04:32 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vlastimil Babka' <vbabka@suse.cz>,
        'Hugh Dickins' <hughd@google.com>
CC:     Joel Fernandes <joel@joelfernandes.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Thread-Topic: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Thread-Index: AQHY02LHNvo5HN+EEECxPXiP8YKQXa32TN+QgAACrACAACIzUA==
Date:   Thu, 29 Sep 2022 14:04:31 +0000
Message-ID: <67f53a71f7ae4f518c7e953b8cfce58a@AcuMS.aculab.com>
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
 <YzPgTtFzpKEfwPbK@hyeyoo> <YzRQvoVsnJzsauwb@google.com>
 <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
 <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
 <9368c760191448bba0e062709cc7c799@AcuMS.aculab.com>
 <ea6e7b10-c514-8320-05c2-4a18391a7079@suse.cz>
In-Reply-To: <ea6e7b10-c514-8320-05c2-4a18391a7079@suse.cz>
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

RnJvbTogVmxhc3RpbWlsIEJhYmthDQo+IFNlbnQ6IDI5IFNlcHRlbWJlciAyMDIyIDE0OjAxDQo+
IA0KPiBPbiA5LzI5LzIyIDEzOjUzLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4+IC1zdGF0aWMg
dm9pZCByY3VfZnJlZV9zbGFiKHN0cnVjdCByY3VfaGVhZCAqaCkNCj4gPj4gKy8qDQo+ID4+ICsg
KiByY3VfZnJlZV9zbGFiKCkgbXVzdCBiZSBfX2FsaWduZWQoNCkgYmVjYXVzZSBpdHMgYWRkcmVz
cyBpcyBzYXZlZA0KPiA+PiArICogaW4gdGhlIHJjdV9oZWFkIGZpZWxkLCB3aGljaCBjb2luY2lk
ZXMgd2l0aCBwYWdlLT5tYXBwaW5nLCB3aGljaA0KPiA+PiArICogY2F1c2VzIHRyb3VibGUgaWYg
Y29tcGFjdGlvbiBtaXN0YWtlcyBpdCBmb3IgUEFHRV9NQVBQSU5HX01PVkFCTEUuDQo+ID4+ICsg
Ki8NCj4gPj4gK19fYWxpZ25lZCg0KSBzdGF0aWMgdm9pZCByY3VfZnJlZV9zbGFiKHN0cnVjdCBy
Y3VfaGVhZCAqaCkNCj4gPj4gIHsNCj4gPj4gIAlzdHJ1Y3Qgc2xhYiAqc2xhYiA9IGNvbnRhaW5l
cl9vZihoLCBzdHJ1Y3Qgc2xhYiwgcmN1X2hlYWQpOw0KPiA+Pg0KPiA+DQo+ID4gSXNuJ3QgdGhh
dCBnb2luZyB0byBjYXVzZSBncmllZiB3aXRoIG9wdGlvbnMgdGhhdCBhbGlnbg0KPiA+IGZ1bmN0
aW9ucyBvbiAxNi8zMmJ5dGUgYm91bmRhcmllcyB3aGVuIGFkZGluZyBzcGFjZSBmb3INCj4gPiAn
b3RoZXIgc3R1ZmYnPw0KPiANCj4gSG93IGlzIHRoYXQgZG9uZSBleGFjdGx5PyBBbHNvIGhhdmlu
ZyBoaWdoZXIgYWxpZ25tZW50ICgxNi8zMikgaXMgbm90IGluDQo+IGNvbmZsaWN0IHdpdGggYXNr
aW5nIGZvciA0Pw0KDQpJdCBkZXBlbmRzIG9uIHdoaWNoIG9uZSBpcyBhY3R1YWxseSB1c2VkLg0K
VGhlIF9fYWxpZ25lZCg0KSBtaWdodCB0YWtlIHByZWNlZGVuY2Ugb3ZlciB0aGUgZGVmYXVsdCBh
bGlnbm1lbnQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

