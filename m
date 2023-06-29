Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F287427EB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjF2OEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjF2OEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:04:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00DA26B6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:04:34 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-230-5oQ8jz6OMYi6w2bJDof4Jw-1; Thu, 29 Jun 2023 15:04:32 +0100
X-MC-Unique: 5oQ8jz6OMYi6w2bJDof4Jw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 29 Jun
 2023 15:04:31 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 29 Jun 2023 15:04:31 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: RE: x86/csum: Remove unnecessary odd handling
Thread-Topic: x86/csum: Remove unnecessary odd handling
Thread-Index: AQHZqaKlrhaTNuKhJ0qJMNdg92SDBq+hy3VQ
Date:   Thu, 29 Jun 2023 14:04:30 +0000
Message-ID: <a6fce3b915e04125b15aa33317ce07ff@AcuMS.aculab.com>
References: <20230628020657.957880-1-goldstein.w.n@gmail.com>
 <20230628091241.GAZJv5ie0xVGvnMKIM@fat_crate.local>
In-Reply-To: <20230628091241.GAZJv5ie0xVGvnMKIM@fat_crate.local>
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

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDI4IEp1bmUgMjAyMyAxMDoxMw0KPiANCj4g
KyBMaW51cyB3aG8ncyBiZWVuIHBva2luZyBhdCB0aGlzIHllc3RlcmRheS4NCj4gDQo+ICsgbGtt
bC4gUGxlYXNlIGFsd2F5cyBDQyBsa21sIHdoZW4gc2VuZGluZyBwYXRjaGVzLg0KPiANCj4gT24g
VHVlLCBKdW4gMjcsIDIwMjMgYXQgMDk6MDY6NTdQTSAtMDUwMCwgTm9haCBHb2xkc3RlaW4gd3Jv
dGU6DQo+ID4gVGhlIHNwZWNpYWwgY2FzZSBmb3Igb2RkIGFsaWduZWQgYnVmZmVycyBpcyB1bm5l
Y2Vzc2FyeSBhbmQgbW9zdGx5DQo+ID4ganVzdCBhZGRzIG92ZXJoZWFkLiBBbGlnbmVkIGJ1ZmZl
cnMgaXMgdGhlIGV4cGVjdGF0aW9ucywgYW5kIGV2ZW4gZm9yDQo+ID4gdW5hbGlnbmVkIGJ1ZmZl
ciwgdGhlIG9ubHkgY2FzZSB0aGF0IHdhcyBoZWxwZWQgaXMgaWYgdGhlIGJ1ZmZlciB3YXMNCj4g
PiAxLWJ5dGUgZnJvbSB3b3JkIGFsaWduZWQgd2hpY2ggaXMgfjEvNyBvZiB0aGUgY2FzZXMuIE92
ZXJhbGwgaXQgc2VlbXMNCj4gPiBoaWdobHkgdW5saWtlbHkgdG8gYmUgd29ydGggdG8gZXh0cmEg
YnJhbmNoLg0KPiA+DQo+ID4gSXQgd2FzIGxlZnQgaW4gdGhlIHByZXZpb3VzIHBlcmYgaW1wcm92
ZW1lbnQgcGF0Y2ggYmVjYXVzZSBJIHdhcw0KPiA+IGVycm9uZW91c2x5IGNvbXBhcmluZyB0aGUg
ZXhhY3Qgb3V0cHV0IG9mIGBjc3VtX3BhcnRpYWwoLi4uKWAsIGJ1dA0KPiA+IHJlYWxseSB3ZSBv
bmx5IG5lZWQgYGNzdW1fZm9sZChjc3VtX3BhcnRpYWwoLi4uKSlgIHRvIG1hdGNoIHNvIGl0cw0K
PiA+IHNhZmUgdG8gcmVtb3ZlLg0KDQpJJ20gc3VyZSBJJ3ZlIHN1Z2dlc3RlZCB0aGlzIGJlZm9y
ZS4NClRoZSAnb2RkJyBjaGVjayB3YXMgbmVlZGVkIGJ5IGFuIGVhcmxpZXIgaW1wbGVtZW50YXRp
b24uDQoNCk1pc2FsaWduZWQgYnVmZmVycyBhcmUgKGp1c3QgYWJvdXQpIG1lYXN1cmFibHkgc2xv
d2VyLg0KQnV0IGl0IGlzIHByZXR0eSBtdWNoIG5vaXNlIGFuZCB0aGUgZXh0cmEgY29kZSBpbiB0
aGUNCmFsaWduZWQgY2FzZSB3aWxsIGNvZGUgbW9yZS4NCg0KSXQgaXMgcHJldHR5IG11Y2ggaW1w
b3NzaWJsZSB0byBmaW5kIG91dCB3aGF0IHRoZSBjcHUgaXMgZG9pbmcsDQpidXQgaWYgeW91IGRv
IG1pc2FsaWduZWQgYWNjZXNzZXMgdG8gYSBQQ0llIHRhcmdldCB5b3UgY2FuDQood2l0aCBzdWl0
YWJsZSBoYXJkd2FyZSkgbG9vayBhdCB0aGUgZ2VuZXJhdGVkIFRMUC4NCg0KV2hhdCB0aGF0IHNo
b3dzIGlzIG1pc2FsaWduZWQgdHJhbnNmZXJzIGJlaW5nIGRvbmUgaW4gOC1ieXRlDQpjaHVua3Mg
YW5kIGJlaW5nIHNwbGl0IGludG8gdHdvIFRMUCBpZiB0aGV5IGNyb3NzIGEgNjQgYnl0ZQ0KKHBy
b2JhYmx5IGNhY2hlIGxpbmUpIGJvdW5kYXJ5Lg0KDQpJdCBpcyBsaWtlbHkgdGhhdCB0aGUgc2Ft
ZSBoYXBwZW5zIGZvciBjYWNoZWQgYWNjZXNzZXMuDQoNCkdpdmVuIHRoYXQgdGhlIGNwdSBjYW4g
ZG8gdHdvIG1lbW9yeSByZWFkcyBlYWNoIGNsb2NrDQppdCBpc24ndCBzdXJwcmlzaW5nIHRoYXQg
dGhlIGNoZWNrc3VtIGxvb3AgKHdoaWNoIGRvZXNuJ3QNCmV2ZW4gbWFuYWdlIGEgcmVhZCBldmVy
eSBjbG9jaykgaXMgc2xvd2VyIGJ5IGxlc3MgdGhhbg0Kb25lIGNsb2NrIGV2ZXJ5IGNhY2hlIGxp
bmUuDQoNClNvbWVvbmUgbWlnaHQgYWxzbyB3YW50IHRvIHVzZSB0aGUgJ2FyYycgQyB2ZXJzaW9u
IG9mIGNzdW1fZm9sZCgpDQpvbiBwcmV0dHkgbXVjaCBldmVyeSBhcmNoaXRlY3R1cmUgWzFdLg0K
SXQgaXM6DQoJcmV0dXJuICh+c3VtIC0gcm9yMzIoc3VtLCAxNikpID4+IDE2Ow0Kc2lnbmlmaWNh
bnRseSBiZXR0ZXIgdGhhbiB0aGUgeDg2IGFzbSAoZXZlbiBvbiBtb3JlIHJlY2VudA0KY3B1IHRo
YXQgZG9uJ3QgdGFrZSAyIGNsb2NrcyBmb3IgYW4gJ2FkYycpLg0KDQpbMV0gYXJtIGNhbiBkbyBh
IGJpdCBiZXR0ZXIgYmVjYXVzZSBvZiB0aGUgYmFycmVsIHNoaWZ0ZXIuDQogICAgc3BhcmMgaXMg
c2xvd2VyIGJlY2F1c2UgaXQgaGFzIGEgY2FycnkgZmxhZyBidXQgbm8gcm90YXRlLg0KDQoJRGF2
aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K

