Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD74974E8C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjGKIOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjGKIOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:14:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B930E3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:14:34 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-185-M_PXxWRcOzG00qjvR3g-fg-1; Tue, 11 Jul 2023 09:14:31 +0100
X-MC-Unique: M_PXxWRcOzG00qjvR3g-fg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 11 Jul
 2023 09:14:30 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 11 Jul 2023 09:14:30 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Azeem Shaikh' <azeemshaikh38@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] kobject: Replace strlcpy with strscpy
Thread-Topic: [PATCH] kobject: Replace strlcpy with strscpy
Thread-Index: AQHZrdj8Qo2zsxXODk+YaMEZxqXK9K+zA4WggABClwCAAP0w0A==
Date:   Tue, 11 Jul 2023 08:14:30 +0000
Message-ID: <0aaa9355aa714e608091af2a5fca1373@AcuMS.aculab.com>
References: <20230703180528.3709258-1-azeemshaikh38@gmail.com>
 <ad25bb8552704028860cf7a419c54fa3@AcuMS.aculab.com>
 <CADmuW3XOcGDBszYw80Dy03DXk3T25k8FNUrJWLKU9tL2znzanw@mail.gmail.com>
In-Reply-To: <CADmuW3XOcGDBszYw80Dy03DXk3T25k8FNUrJWLKU9tL2znzanw@mail.gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQXplZW0gU2hhaWtoDQo+IFNlbnQ6IDEwIEp1bHkgMjAyMyAxOTowNw0KPiANCj4gT24g
TW9uLCBKdWwgMTAsIDIwMjMgYXQgOToxM+KAr0FNIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0
QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiAgICAgICBpbnQgbGVuOw0KPiA+ID4NCj4g
PiA+IC0gICAgIGxlbiA9IHN0cmxjcHkoJmVudi0+YnVmW2Vudi0+YnVmbGVuXSwgc3Vic3lzdGVt
LCBidWZmZXJfc2l6ZSk7DQo+ID4gPiAtICAgICBpZiAobGVuID49IGJ1ZmZlcl9zaXplKSB7DQo+
ID4gPiArICAgICBsZW4gPSBzdHJzY3B5KCZlbnYtPmJ1ZltlbnYtPmJ1Zmxlbl0sIHN1YnN5c3Rl
bSwgYnVmZmVyX3NpemUpOw0KPiA+ID4gKyAgICAgaWYgKGxlbiA8IDApIHsNCj4gPiA+ICAgICAg
ICAgICAgICAgcHJfd2FybigiaW5pdF91ZXZlbnRfYXJndjogYnVmZmVyIHNpemUgb2YgJWQgdG9v
IHNtYWxsLCBuZWVkZWQgJWRcbiIsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgYnVmZmVy
X3NpemUsIGxlbik7DQo+ID4gPiAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+DQo+
ID4gVGhlIHNpemUgaW4gdGhlIGVycm9yIG1lc3NhZ2UgaXMgbm93IHdyb25nLg0KPiANCj4gVGhh
bmtzIGZvciBjYXRjaGluZyB0aGlzLg0KPiANCj4gPiBJdCBoYXMgdG8gYmUgc2FpZCB0aGF0IG1v
c3RseSBhbGwgdGhlIHN0cmluZ3MgdGhhdCBnZXQgY29waWVkDQo+ID4gaW4gdGhlIGtlcm5lbCBh
cmUgJ1wwJyB0ZXJtaW5hdGVkIC0gc28gbWF5YmUgaXQgaXMgYWxsIG1vb3QuDQo+ID4gT1RPSCBw
cmludGluZyAoYXQgbGVhc3Qgc29tZSBvZikgdGhlIHN0cmluZyB0aGF0IGRpZG4ndCBmaXQNCj4g
PiBpcyBhIGxvdCBtb3JlIHVzZWZ1bCB0aGFuIGl0cyBsZW5ndGguDQo+IA0KPiBIb3cgYWJvdXQg
cHJpbnRpbmcgb3V0IHN0cmxlbihzdWJzeXN0ZW0pIGFsb25nIHdpdGggdGhlIGVudGlyZSB2YWx1
ZQ0KPiBvZiBAc3Vic3lzdGVtPyBTbyB0aGF0IHRoZSB3YXJuIHJlYWRzOg0KPiANCj4gcHJfd2Fy
bigiaW5pdF91ZXZlbnRfYXJndjogYnVmZmVyIHNpemUgb2YgJWQgdG9vIHNtYWxsIGZvciAlcywg
bmVlZGVkDQo+ICVkXG4iLCBidWZmZXJfc2l6ZSwgc3Vic3lzdGVtLCBzdHJsZW4oc3Vic3lzdGVt
KSk7DQo+IA0KPiBEb2VzIHRoYXQgc2VlbSBiZXR0ZXI/DQoNCk5vdCB3aXRoIHRoZSBqdXN0aWZp
Y2F0aW9uIGZvciBub3QgdXNpbmcgc3RybGNweSgpIDotKQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

