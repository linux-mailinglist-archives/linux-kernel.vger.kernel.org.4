Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923EC698F39
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjBPJDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBPJDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:03:13 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ECE171A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:03:12 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-82-NNoxohhnO26LHaxwi1IFYA-1; Thu, 16 Feb 2023 09:03:10 +0000
X-MC-Unique: NNoxohhnO26LHaxwi1IFYA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Thu, 16 Feb
 2023 09:03:08 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Thu, 16 Feb 2023 09:03:08 +0000
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
Thread-Index: AQHZPDrPjnYkuPc3GUK7DnTa61yn8K7GU7lQgAAunoCAAAOYoIABcE8jgAAK1MCABa59gIAAfSaggABZcICAAsbaQA==
Date:   Thu, 16 Feb 2023 09:03:08 +0000
Message-ID: <8bc06b0ef9c243b087e944e0611b54b5@AcuMS.aculab.com>
References: <20230209035839.2610277-1-maobibo@loongson.cn>
 <e6bb59c32134477aa4890047ae5ad51b@AcuMS.aculab.com>
 <741b2246-d609-ccc6-bf55-d6b0b5e54b54@loongson.cn>
 <2aa6243491784e74960182dc12968170@AcuMS.aculab.com>
 <CAAhV-H7BgBASt_CpSQgS6MNbzxODhoq8ykK5ZAn2y3ZOekXM9g@mail.gmail.com>
 <0fe7ed7c-7161-65d5-a09f-12db6ccda05a@loongson.cn>
 <b17430342e9e4c39b53004d842ea9c55@AcuMS.aculab.com>
 <ec49593a-60a4-be91-0fb2-af517eaf6d6a@loongson.cn>
 <5dc1c39bbaf149f78c132f4467cdb365@AcuMS.aculab.com>
 <0d591c10-e897-d00a-dbf0-a069389ef196@loongson.cn>
In-Reply-To: <0d591c10-e897-d00a-dbf0-a069389ef196@loongson.cn>
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

RnJvbTogbWFvYmlibw0KPiBTZW50OiAxNCBGZWJydWFyeSAyMDIzIDE0OjE5DQouLi4NCj4gR290
IGl0LiBJdCBtYWtlcyB1c2Ugb2YgcGlwZWxpbmUgYmV0dGVyLCByYXRoZXIgdGhhbiBudW1iZXIg
b2YgQUxVcyBmb3INCj4gZGlmZmVyZW50IG1pY3JvLWFyY2hpdGVjdHVyZXMuIEkgd2lsbCB0cnkg
dGhpcyBtZXRob2QsIHRoYW5rcyBhZ2FpbiBmb3INCj4ga2luZGx5IGhlbHAgYW5kIGV4cGxhbmF0
aW9uIHdpdGggcGF0aWVuY2UuDQoNCkl0IGlzIGFsc28gd29ydGggcG9pbnRpbmcgb3V0IHRoYXQg
aWYgdGhlIGNwdSBkb2VzICdvdXQgb2Ygb3JkZXInDQpleGVjdXRpb24gaXQgbWF5IGJlIGp1c3Qg
YXMgZ29vZCB0byBqdXN0IHJlcGVhdCBibG9ja3Mgb2Y6DQoJbG9hZAl2MCwgYWRkciwgMCo4DQoJ
YWRkCXN1bTAsIHYwDQoJc2x0dQl2MCwgc3VtMCwgdjANCglhZGQJY2FycnkwLCB2MA0KDQpBc3N1
bWluZyB0aGUgcHJlZmV0Y2gvZGVjb2RlIGxvZ2ljIGNhbiBwcmVkaWN0IHRoZSBsb29wDQphbmQg
Z2VuZXJhdGUgZW5vdWdoIGRlY29kZWQgaW5zdHJ1Y3Rpb24gZm9yIGFsbCB0aGUgYWx1IHVuaXRz
Lg0KDQpUaGUgYWRkL3NsdHUvYWRkIHdpbGwgYmUgcXVldWVkIHVudGlsIHRoZSBsb2FkIGNvbXBs
ZXRlcw0KYW5kIHRoZW4gZXhlY3V0ZSBpbiB0aGUgbmV4dCB0aHJlZSBjbG9ja3MuDQpUaGUgbG9h
ZCBmb3IgdGhlIG5leHQgYmxvY2sgd2lsbCBiZSBzY2hlZHVsZWQgYXMgc29vbiBhcw0KdGhlIGxv
YWQvc3RvcmUgdW5pdCBoYXMgZmluaXNoZWQgcHJvY2Vzc2luZyB0aGUgcHJldmlvdXMgbG9hZC4N
ClNvIGFsbCB0aGUgYWx1IGluc3RydWN0aW9ucyBqdXN0IHdhaXQgZm9yIHRoZSByZXF1aXJlZCBp
bnB1dA0KdG8gYmUgYXZhaWxhYmxlIGFuZCBhIG1lbW9yeSBsb2FkIGV4ZWN1dGVzIGV2ZXJ5IGNs
b2NrLg0KDQpNdWx0aXBsZSBzdW0wIGFuZCBjYXJyeTAgcmVnaXN0ZXJzIGFyZW4ndCBhY3R1YWxs
eSBuZWVkZWQuDQpCdXQgaGF2aW5nIDIgb2YgZWFjaCAoZXZlbiBpZiB0aGUgbG9vcCBpcyB1bnJv
bGxlZCA0IHRpbWVzKQ0KbWlnaHQgaGVscCBhIGJpdC4NCg0KSWYgdGhlIGNwdSBkb2VzICdyZWdp
c3RlciByZW5hbWluZycgKGFzIG1vc3QgeDg2IGRvKSB5b3UNCmNhbiB1c2UgdGhlIHNhbWUgcmVn
aXN0ZXIgbmFtZSBmb3IgJ3YwJyBpbiBhbGwgdGhlIGJsb2Nrcw0KKGV2ZW4gdGhvdWdoIGl0IGlz
IGFsaXZlIHdpdGggbXVsdGlwbGUgdmFsdWVzKS4NCg0KQnV0IGEgc2ltcGxlciBpbi1vcmRlciBt
dWx0aS1pc3N1ZSBjcHUgd2lsbCBuZWVkIHlvdSB0bw0KY29ycmVjdGx5IGludGVybGVhdmUgdGhl
IGluc3RydWN0aW9ucyBmb3IgbWF4aW11bSB0aHJvdWdocHV0Lg0KSXQgYWxzbyBkb2VzIG5vIGhh
cmQgZm9yIGEgdmVyeSBzaW1wbGUgY3B1IHRoYXQgaGFzIGRlbGF5cw0KYmVmb3JlIGEgcmVhZCB2
YWx1ZSBjYW4gYmUgdXNlZC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

