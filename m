Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FCA72241B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjFELDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjFELDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:03:38 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85934BD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:03:36 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-128-_ofKSFr2OpKNCh_xjBwMWA-1; Mon, 05 Jun 2023 12:03:33 +0100
X-MC-Unique: _ofKSFr2OpKNCh_xjBwMWA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 5 Jun
 2023 12:03:22 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 5 Jun 2023 12:03:22 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>
CC:     Jakub Kicinski <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        "Boris Pismenny" <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: RE: Bug in short splice to socket?
Thread-Topic: Bug in short splice to socket?
Thread-Index: AQHZlJtzNwrvw6NqbEOlRWOj/YHtG698Dbjg
Date:   Mon, 5 Jun 2023 11:03:21 +0000
Message-ID: <e94820ba53924e96b31ac983c84269f8@AcuMS.aculab.com>
References: <20230524153311.3625329-1-dhowells@redhat.com>
 <20230524153311.3625329-10-dhowells@redhat.com>
 <20230526180844.73745d78@kernel.org>
 <499791.1685485603@warthog.procyon.org.uk>
 <CAHk-=wgeixW3cc=Ys8eL0_+22FUhqeEru=nzRrSXy1U4YQdE-w@mail.gmail.com>
 <CAHk-=wghhHghtvU_SzXxAzfaX35BkNs-x91-Vj6+6tnVEhPrZg@mail.gmail.com>
 <832277.1685630048@warthog.procyon.org.uk>
 <CAHk-=wji_2UwFMkUYkygsYRek05NwaQkH-vA=yKQtQS9Js+urQ@mail.gmail.com>
In-Reply-To: <CAHk-=wji_2UwFMkUYkygsYRek05NwaQkH-vA=yKQtQS9Js+urQ@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDEgSnVuZSAyMDIzIDE2OjEyDQo+IA0KPiBP
biBUaHUsIEp1biAxLCAyMDIzIGF0IDEwOjM04oCvQU0gRGF2aWQgSG93ZWxscyA8ZGhvd2VsbHNA
cmVkaGF0LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBBdCB0aGUgbW9tZW50LCBpdCB0cmFuc2NyaWJl
cyAxNiBwYWdlcyBhdCBhIHRpbWUuICBJIGNvdWxkIG1ha2UgaXQgc2V0DQo+ID4gTVNHX01PUkUg
b25seSBpZiAoYSkgU1BMSUNFX0ZfTU9SRSB3YXMgcGFzc2VkIGludG8gdGhlIHNwbGljZSgpIHN5
c2NhbGwgb3IgKGIpDQo+ID4gdGhlcmUncyB5ZXQgbW9yZSBkYXRhIGluIHRoZSBidWZmZXIuDQo+
IA0KPiBUaGF0IHdvdWxkIGF0IGxlYXN0IGJlIGEgZ29vZCBmaXJzdCBzdGVwLg0KPiANCj4gPiBI
b3dldmVyLCB0aGlzIG1pZ2h0IHdlbGwgY2F1c2UgYSBtYWxmdW5jdGlvbiBpbiBVRFAsIGZvciBl
eGFtcGxlLiAgTVNHX01PUkUNCj4gPiBjb3JrcyB0aGUgY3VycmVudCBwYWNrZXQsIHNvIGlmIEkg
YXNrIHNlbmRmaWxlKCkgc2F5IHNob3ZlIDMySyBpbnRvIGEgcGFja2V0LA0KPiA+IGlmLCBzYXks
IDE2SyBpcyByZWFkIGZyb20gdGhlIHNvdXJjZSBhbmQgZW50aXJlbHkgdHJhbnNjcmliZWQgaW50
byB0aGUgcGFja2V0LA0KPiANCj4gSWYgeW91IHVzZSBzcGxpY2UoKSBmb3IgVURQLCBJIGRvbid0
IHRoaW5rIHlvdSB3b3VsZCBub3JtYWxseSBleHBlY3QNCj4gdG8gZ2V0IGFsbCB0aGF0IHdlbGwt
ZGVmaW5lZCBwYWNrZXQgYm91bmRhcmllcy4NCg0KRXNwZWNpYWxseSBzaW5jZSAoYXNzdW1pbmcg
SSd2ZSB1bmRlcnN0b29kIG90aGVyIGJpdHMgb2YgdGhpcyB0aHJlYWQpDQp0aGUgc3BsaWNlKCkg
Y2FuIGdldCBzcGxpdCBpbnRvIG11bHRpcGxlIHNlbmRtc2coKSBjYWxscyBmb3Igb3RoZXINCnJl
YXNvbnMuDQoNCldoYXQgc2VtYW50aWNzIGFyZSB5b3UgdHJ5aW5nIHRvIGltcGxlbWVudCBmb3Ig
QUZfVExTPw0KTVNHX01PUkUgaGFzIGRpZmZlcmVudCBlZmZlY3RzIG9uIGRpZmZlcmVudCBwcm90
b2NvbHMuDQoNCkZvciBVRFAgdGhlIG5leHQgZGF0YSBpcyBhcHBlbmRlZCB0byB0aGUgZGF0YWdy
YW0gYmVpbmcgYnVpbHQuDQooVGhpcyBpcyByZWFsbHkgcHJldHR5IHBvaW50bGVzcywgZG9pbmcg
aXQgaW4gdGhlIGNhbGxlciB3aWxsIGJlIGZhc3RlciEpDQoNCkZvciBUQ1AgaXQgc3RvcHMgdGhl
IHBlbmRpbmcgZGF0YSBiZWluZyBzZW50IGltbWVkaWF0ZWx5Lg0KQW5kIG1vcmUgZGF0YSBpcyBh
cHBlbmRlZC4NCkknbSBwcmV0dHkgc3VyZSBpdCBnZXRzIHNlbnQgb24gdGltZW91dC4NCg0KRm9y
IFNDVFAgdGhlIGRhdGEgY2h1bmsgY3JlYXRlZCBmb3IgdGhlIHNlbmRtc2coKSBpc24ndCBzZW50
IGltbWVkaWF0ZWx5Lg0KQW55IG1vcmUgc2VuZG1zZyhNU0dfTU9SRSkgZ2V0IHF1ZXVlZCB1bnRp
bCBhIGZ1bGwgZXRoZXJuZXQgcGFja2V0DQppcyBidWZmZXJlZC4NClRoZSBwZW5kaW5nIGRhdGEg
aXMgc2VudCBvbiB0aW1lb3V0Lg0KVGhpcyBpcyBwcmV0dHkgbXVjaCB0aGUgb25seSB3YXkgdG8g
Z2V0IHR3byAob3IgbW9yZSkgREFUQSBjaHVua3MNCmludG8gYW4gZXRoZXJuZXQgZnJhbWUgd2hl
biBOYWdsZSBpcyBkaXNhYmxlZC4NCg0KQnV0IEkgZ2V0IHRoZSBpbXByZXNzaW9uIEFGX1RMUyBp
cyBkZWNpZGluZyBub3QgdG8gZW5jb2RlL3NlbmQNCnRoZSBkYXRhIGJlY2F1c2UgJ3RoZXJlIGlz
bid0IGVub3VnaCcuDQpUaGF0IHNlZW1zIHdyb25nLg0KDQpOb3RlIHRoYXQgeW91IGNhbid0IHVz
ZSBhIHplcm8gbGVuZ3RoIHNlbmRtc2coKSB0byBmbHVzaCBwZW5kaW5nDQpkYXRhIC0gaWYgdGhl
cmUgaXMgbm8gcGVuZGluZyBkYXRhIHNvbWUgcHJvdG9jb2xzIHdpbGwgc2VuZCBhIA0KemVybyBs
ZW5ndGggZGF0YSBtZXNzYWdlLg0KQSBzb2NrZXQgb3B0aW9uL2lvY3RsIChlZyBVTkNPUkspIGNv
dWxkIGJlIChhYil1c2VkIHRvIGZvcmNlDQpxdWV1ZWQgZGF0YSBiZSBzZW50Lg0KDQoJRGF2aWQN
Cg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZh
cm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYg
KFdhbGVzKQ0K

