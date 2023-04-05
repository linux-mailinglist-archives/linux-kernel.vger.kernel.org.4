Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF4D6D7A27
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 12:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbjDEKpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 06:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237250AbjDEKpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:45:42 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECBD19B2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 03:45:41 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-158-QrVyRzgdOBaHChDADgWO2w-1; Wed, 05 Apr 2023 11:45:38 +0100
X-MC-Unique: QrVyRzgdOBaHChDADgWO2w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 5 Apr
 2023 11:45:36 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 5 Apr 2023 11:45:36 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexey Dobriyan' <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] string: implement streq()
Thread-Topic: [PATCH] string: implement streq()
Thread-Index: AQHZZwV5Ya2vbUrSK0i2c63OpoVNQq8ciTUQ
Date:   Wed, 5 Apr 2023 10:45:36 +0000
Message-ID: <64f79f9610284091863ec8ce54660b85@AcuMS.aculab.com>
References: <4b595ab9-238c-43a5-aba0-be5d6afc0f87@p183>
 <20230403141641.6ace0d85fd48fbed5c02d7ef@linux-foundation.org>
 <db6ce106-a5fc-4742-a59e-ccbd39dfd69d@p183>
In-Reply-To: <db6ce106-a5fc-4742-a59e-ccbd39dfd69d@p183>
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
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWxleGV5IERvYnJpeWFuDQo+IFNlbnQ6IDA0IEFwcmlsIDIwMjMgMTU6NTUNCj4gDQo+
IE9uIE1vbiwgQXByIDAzLCAyMDIzIGF0IDAyOjE2OjQxUE0gLTA3MDAsIEFuZHJldyBNb3J0b24g
d3JvdGU6DQo+ID4gT24gU2F0LCAxIEFwciAyMDIzIDIwOjQ4OjA1ICswMzAwIEFsZXhleSBEb2Jy
aXlhbiA8YWRvYnJpeWFuQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IE1vc3Qgb2YgdGhl
IHRpbWUgc3RyY21wKCkgaXMgYmVpbmcgdXNlZCwgc3RyaW5ncyBhcmUgY2hlY2tlZCBmb3IgZXF1
YWxpdHkuDQo+ID4gPiBBZGQgd3JhcHBlciB0byByZWxheSBzdWNoIGludGVudCAoaXQgaXMgc2hv
cnRlciB0byB0eXBlLCB0b28pLg0KPiA+ID4NCj4gPiA+IFVzZQ0KPiA+ID4gCWlmIChzdHJlcShz
LCAicyIpKSB7DQo+ID4gPiAJfQ0KPiA+ID4gb3INCj4gPiA+IAlpZiAoIXN0cmVxKHMsICJzIikp
IHsNCj4gPiA+IAl9DQo+ID4NCj4gPiBHZWUsIGRvIHdlIHJlYWxseSB3YW50IHRoaXM/ICBJIG1l
YW4sIHdlIGFsbCBrbm93IGhvdyBzdHJjbXAoKSB3b3JrcywNCj4gPiBkb24ndCB3ZT8NCj4gPg0K
PiA+IEknbSB0aGlua2luZyBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gcmVtb3ZlIHRoZSB2YXJpb3Vz
IGN1dGUgbGl0dGxlDQo+ID4gc3RyZXEoKSBtYWNyb3MgYW5kIG9wZW4tY29kZSBzdHJjbXAoLi4u
KT09MC4NCj4gDQo+IE5vISBJdCdzIGNvb2wsIHRydXN0IG1lLiBUcnkgaXQgb3V0LCB5b3UnbGwg
bGlrZSBpdC4NCj4gV2UgImtub3ciIGhvdyBzdHJjbXAoKSB3b3JrcyBiZWNhdXNlIEMgZGlkbid0
IGhhdmUgc3RyZXEoKSBmcm9tDQo+IHRoZSB2ZXJ5IGJlZ2lubmluZy4NCj4gDQo+IHN0cmNtcCgp
IGlzIG9ubHkgZm9yIGluc2VydGlvbiBpbnRvIHRyZWVzLiBIYWxmIG9mIHRoZSB0aW1lIHlvdSBu
ZWVkDQo+IHRvIHJlYWQgdG8gdGhlIGVuZCBvZiB0aGUgZXhwcmVzc2lvbiB0byBrbm93IGlmIGl0
IGlzIGNoZWNrIGZvciBlcXVhbGl0eQ0KPiBvciBpbmVxdWFsaXR5LiBXaXRoIHN0cmVxKCksIHlv
dSBkb24ndC4NCg0KSW5zdGVhZCB5b3UgaGF2ZSB0byBnbyBhd2F5IGFuZCBsb29rIHVwIHdoYXQg
YSBmdW5jdGlvbg0KeW91J3ZlIG5ldmVyIGhlYXJkIG9mIGRvZXMuDQoNCkxpdmUgd2l0aCBzdHJj
bXAoKS4uLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFt
bGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3Ry
YXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

