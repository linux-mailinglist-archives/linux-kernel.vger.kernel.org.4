Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599B1691D9B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjBJLIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjBJLIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:08:20 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59DBE068
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:08:18 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-306-jgSE72GeOa-T0HoHuh_z1g-1; Fri, 10 Feb 2023 11:08:16 +0000
X-MC-Unique: jgSE72GeOa-T0HoHuh_z1g-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Fri, 10 Feb
 2023 11:08:15 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Fri, 10 Feb 2023 11:08:15 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'maobibo' <maobibo@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
CC:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] LoongArch: add checksum optimization for 64-bit system
Thread-Topic: [PATCH v2] LoongArch: add checksum optimization for 64-bit
 system
Thread-Index: AQHZPDrPjnYkuPc3GUK7DnTa61yn8K7GU7lQgAAunoCAAAOYoIABcE8jgAAK1MA=
Date:   Fri, 10 Feb 2023 11:08:15 +0000
Message-ID: <b17430342e9e4c39b53004d842ea9c55@AcuMS.aculab.com>
References: <20230209035839.2610277-1-maobibo@loongson.cn>
 <e6bb59c32134477aa4890047ae5ad51b@AcuMS.aculab.com>
 <741b2246-d609-ccc6-bf55-d6b0b5e54b54@loongson.cn>
 <2aa6243491784e74960182dc12968170@AcuMS.aculab.com>
 <CAAhV-H7BgBASt_CpSQgS6MNbzxODhoq8ykK5ZAn2y3ZOekXM9g@mail.gmail.com>
 <0fe7ed7c-7161-65d5-a09f-12db6ccda05a@loongson.cn>
In-Reply-To: <0fe7ed7c-7161-65d5-a09f-12db6ccda05a@loongson.cn>
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

RnJvbTogbWFvYmlibw0KPiBTZW50OiAxMCBGZWJydWFyeSAyMDIzIDEwOjA2DQo+IA0KPiBXaXRo
IHRoZSB0ZXN0IGNhc2VzDQo+ICAgaHR0cHM6Ly9naXRodWIuY29tL2JpYm8tbWFvL2JlbmNoL3Ry
ZWUvbWFzdGVyL2NzdW0NCj4gDQo+IFRlc3RlZCB3aXRoIGRpZmZlcmVudCBidWZmZXIgc2l6ZSA0
MDk2LzE0NzIvMjUwLzQwLCBoZXJlIGlzIHRoZSBvdXRwdXQgb24gbXkNCj4gbG9vbmdhcmNoIG1h
Y2hpbmUuIExvb3BzIHRpbWVzIGlzIDB4MTAwMDAwLCBhbmQgdGltZSBjb3N0IHVuaXQgaXMgbWls
bGlzZWNvbmRzLA0KPiBhbmQgdGhlIHNtYWxsZXIgdmFsdWUgd2lsbCBiZSBiZXR0ZXIuDQo+IA0K
PiANCj4gYnVmIHNpemVbNDA5Nl0gbG9vcHNbMHgxMDAwMDBdIHRpbWVzW3VzXTogY3N1bSB1aW50
MTI4IDM0NDQ3MyBhc20gbWV0aG9kIDM3MzM5MSB1aW50NjQgNzQxNDEyDQo+IGJ1ZiBzaXplWzE0
NzJdIGxvb3BzWzB4MTAwMDAwXSB0aW1lc1t1c106IGNzdW0gdWludDEyOCAxMzE4NDkgYXNtIG1l
dGhvZCAxMzg1MzMgdWludDY0IDI3MTMxNw0KPiBidWYgc2l6ZVsgMjUwXSBsb29wc1sweDEwMDAw
MF0gdGltZXNbdXNdOiBjc3VtIHVpbnQxMjggMzQ1MTIgYXNtIG1ldGhvZCAzNjI5NCB1aW50NjQg
NTE1NzYNCj4gYnVmIHNpemVbICA0MF0gbG9vcHNbMHgxMDAwMDBdIHRpbWVzW3VzXTogY3N1bSB1
aW50MTI4IDEyMTgyIGFzbSBtZXRob2QgMjM4NzQgdWludDY0IDE1NzY5DQoNCldoYXQgZG8gdGhv
c2Ugd29yayBvdXQgYXMgaW4gYnl0ZXMvY2xvY2s/DQoNClJhdGhlciB0aGFuIHJ1biAxMDAwcyBv
ZiBpdGVyYXRpb25zIChhbmQgYmUgaGl0IGJ5IGludGVycnVwdHMgZXRjKQ0KSSBzb21ldGltZXMg
anVzdCB1c2UgYW4gYWNjdXJhdGUgY3ljbGUgY291bnRlciBhbmQgbWVhc3VyZSB0aGUNCnRpbWUg
Zm9yIGEgc2luZ2xlIGJ1ZmZlciAob3IgdmFyeWluZyBsZW5ndGgpLg0KU2F2ZSBhbmQgcHJpbnQg
dGhlIHZhbHVlcyBvZiAxMCBjYWxscyBhbmQgeW91J2xsIGdldCBwcmV0dHkNCmNvbnNpc3RlbnQg
dmFsdWVzIGFmdGVyIHRoZSBmaXJzdCBjb3VwbGUgKGNvbGQgY2FjaGUpLg0KVGhlbiB5b3UgY2Fu
IHdvcmsgb3V0IGhvdyBsb25nIGVhY2ggaXRlcmF0aW9uIG9mIHRoZSBtYWluIGxvb3AgY29zdHMu
DQoNCkkgdGhpbmsgeW91IGhhdmUgdG8gZXhlY3V0ZSA0IGluc3RydWN0aW9ucyBmb3IgZWFjaCA2
NGJpdCB3b3JkLg0KT25lIG1lbW9yeSByZWFkLCB0aGUgbWFpbiBhZGQsIGEgc2V0bGUgYW5kIHRo
ZSBhZGQgb2YgdGhlIGNhcnJ5Lg0KDQpGb3IgYSBzaW1wbGUgY3B1IHRoYXQgaXMgYWx3YXlzIGdv
aW5nIHRvIGJlIDQgY2xvY2tzLg0KQnV0IGlmIHRoZXJlIGFyZSBkZWxheSBzbG90cyBhZnRlciB0
aGUgbWVtb3J5IHJlYWQgeW91IGNhbg0KZmlsbCB0aGVtIHdpdGggdGhlIGFsdSBpbnN0cnVjdGlv
bnMgZm9yIGFuIGVhcmxpZXIgcmVhZC4NCllvdSBhbHNvIG5lZWQgYW4gYWRkIGFuZCBibmUgZm9y
IHRoZSBhZGRyZXNzIGZvciBlYWNoIGl0ZXJhdGlvbi4NClNvIHVucm9sbGluZyB0aGUgbG9vcCBm
dXJ0aGVyIHdpbGwgaGVscC4NCg0KT1RPSCBpZiB5b3VyIGNwdSBjYW4gZXhlY3V0ZSBtdWx0aXBs
ZSBpbnN0cnVjdGlvbnMgaW4gb25lIGNsb2NrDQp5b3UgY2FuIGV4cGVjdCB0byBkbyBhIGxvdCBi
ZXR0ZXIuDQpXaXRoIDMgQUxVIGluc3RydWN0aW9ucyAoYW5kIG9uZSByZWFkKSB5b3Ugc2hvdWxk
IGJlIGFibGUgdG8NCmZpbmQgYSBjb2RlIHNlcXVlbmNlIHRoYXQgd2lsbCBydW4gYXQgOCBieXRl
cy9jbG9jay4NCldpdGggNCBBTFUgaXQgaXMgbGlrZWx5IHRoYXQgdGhlIGxvb3AgaW5zdHJ1Y3Rp
b25zIGNhbiBhbHNvDQpleGVjdXRlIGluIHBhcmFsbGVsIC0gc28geW91IGRvbid0IG5lZWQgbWFz
c2l2ZSBsb29wIHVucm9sbGluZy4NCg0KVW5sZXNzIHRoZSBjcHUgaXMgbWFzc2l2ZWx5ICdvdXQg
b2Ygb3JkZXInIChsaWtlIHNvbWUgeDg2KQ0KSSdkIGV4cGVjdCB0aGUgYmVzdCBjb2RlIHRvIGlu
dGVybGVhdmUgdGhlIHJlYWRzIGFuZCBhbHUNCm9wZXJhdGlvbnMgZm9yIGVhcmxpZXIgdmFsdWVz
IC0gcmF0aGVyIHRoYW4gaGF2aW5nIGFsbA0KdGhlIHJlYWRzIGF0IHRoZSB0b3Agb2YgdGhlIGxv
b3AuDQpTbyB0aGUgbG9vcCB3b3VsZCBiZSBhIHJlcGVhdGluZyBwYXR0ZXJuIG9mIGluc3RydWN0
aW9ucw0Kd2l0aCBzb21lIHZhbHVlcyBiZWluZyBjYXJyaWVkIGJldHdlZW4gaXRlcmF0aW9ucy4N
Cg0KSSBkb3VidCB5b3UnbGwgZ2V0IGEgbG9vcCB0byBleGVjdXRlIGV2ZXJ5IGNsb2NrLCBidXQN
CmEgdHdvIGNsb2NrIGxvb3AgaXMgZW50aXJlbHkgcG9zc2libGUuDQpJdCByYXRoZXIgZGVwZW5k
cyBob3cgZmFzdCB0aGUgaW5zdHJ1Y3Rpb24gZGVjb2Rlcg0KaGFuZGxlcyB0aGUgKHByZWRpY3Rl
ZCkgYnJhbmNoLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

