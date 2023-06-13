Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF46D72E33E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240061AbjFMMnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjFMMnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:43:08 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64146AD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:43:07 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-311-rnUksceOM2-gkIbIoMQNcA-1; Tue, 13 Jun 2023 13:43:04 +0100
X-MC-Unique: rnUksceOM2-gkIbIoMQNcA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 13 Jun
 2023 13:42:59 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 13 Jun 2023 13:42:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rasmus Villemoes' <linux@rasmusvillemoes.dk>,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
CC:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Christoph Hellwig" <hch@lst.de>
Subject: RE: [PATCH v3 3/4] vsscanf(): do not skip spaces
Thread-Topic: [PATCH v3 3/4] vsscanf(): do not skip spaces
Thread-Index: AQHZnR4ovdHGuD5F0k2o+1T0Ru69aa+Iri8A
Date:   Tue, 13 Jun 2023 12:42:59 +0000
Message-ID: <32e8b52d64b642608595142ab2952f16@AcuMS.aculab.com>
References: <20230610204044.3653-1-demi@invisiblethingslab.com>
 <20230610204044.3653-4-demi@invisiblethingslab.com>
 <546e2ab5-f520-c85e-d6f4-ca7b02457d4c@rasmusvillemoes.dk>
In-Reply-To: <546e2ab5-f520-c85e-d6f4-ca7b02457d4c@rasmusvillemoes.dk>
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

RnJvbTogUmFzbXVzIFZpbGxlbW9lcw0KPiBTZW50OiAxMiBKdW5lIDIwMjMgMTI6MDgNCj4gDQo+
IE9uIDEwLzA2LzIwMjMgMjIuNDAsIERlbWkgTWFyaWUgT2Jlbm91ciB3cm90ZToNCj4gPiBQYXNz
aW5nIHNwYWNlcyBiZWZvcmUgZS5nLiBhbiBpbnRlZ2VyIGlzIHVzdWFsbHkNCj4gPiBub3QgaW50
ZW5kZWQuDQo+IA0KPiBNYXliZSwgbWF5YmUgbm90LiBCdXQgaXQncyBtYW5kYXRlZCBieSBQT1NJ
WC9DOTkuDQo+IA0KPiBBbmQgb2YgY291cnNlIHdlIGFyZSBmcmVlIHRvIGlnbm9yZSB0aGF0IGFu
ZCBpbXBsZW1lbnQgb3VyIG93biBzZW1hbnRpY3MNCj4gKHRob3VnaCB3aXRoaW4gdGhlIGNvbnN0
cmFpbnRzIHRoYXQgd2UgcmVhbGx5IHdhbnQgLVdmb3JtYXQgdG8gaGVscCB1cyksDQo+IGJ1dCB0
aGVyZSBzZWVtcyB0byBiZSBleGlzdGluZyBjb2RlIGluLXRyZWUgdGhhdCByZWxpZXMgb24gdGhp
cw0KPiBiZWhhdmlvci4gRm9yIGV4YW1wbGUgSSB0aGluayB0aGlzIHdpbGwgYnJlYWsNCj4gZnNs
X3NhdGFfaW50cl9jb2FsZXNjaW5nX3N0b3JlKCkgd2hpY2ggdXNlcyBhIHNjYW5mIGZvcm1hdCBv
ZiAiJXUldSIuDQo+IA0KPiBTdXJlLCB0aGF0IGNvdWxkIGp1c3Qgc2F5ICIldSAldSIgaW5zdGVh
ZCwgYnV0IHRoZSBwb2ludCBpcyB0aGF0DQo+IGN1cnJlbnRseSBpdCBkb2Vzbid0LiBTbyB3aXRo
b3V0IHNvbWUgcmVhc29uYWJseSB0aG9yb3VnaCBhbmFseXNpcw0KPiBhY3Jvc3MgdGhlIHRyZWUs
IGFuZCB1cGRhdGVzIG9mIGFmZmVjdGVkIGNhbGxlcnMsIE5BSy4NCg0KSXQgd291bGQgYWxtb3N0
IGNlcnRhaW5seSBuZWVkIHRvIGJlICIgJXUgJXUiIHRvIGFsbG93IGZvcg0KdXNlcnNwYWNlIGdl
bmVyYXRpbmcgdGhlIGlucHV0IHdpdGggIiU2dSAlNnUiLA0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

