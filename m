Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E9472F7BA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbjFNIYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbjFNIYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:24:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFB9A1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:24:01 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-279-1vOAtSfnMLG7mYuL-2bvgA-1; Wed, 14 Jun 2023 09:23:59 +0100
X-MC-Unique: 1vOAtSfnMLG7mYuL-2bvgA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 14 Jun
 2023 09:23:56 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 14 Jun 2023 09:23:56 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Demi Marie Obenour' <demi@invisiblethingslab.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: RE: [PATCH v3 0/4] Make sscanf() stricter
Thread-Topic: [PATCH v3 0/4] Make sscanf() stricter
Thread-Index: AQHZnXRzYKsBWmeEwU2LY4YQ5TFW+a+Is3nggAAaG4CAASnjAA==
Date:   Wed, 14 Jun 2023 08:23:56 +0000
Message-ID: <23df90dd35874fd89c64906e6a6de164@AcuMS.aculab.com>
References: <6ab6adce-2318-4ae6-bde6-4317485639fd@p183>
 <ZId/IA41c2sJyvE0@itl-email> <ZIeHfBf3aB3vUgRM@smile.fi.intel.com>
 <ZIeMyQXU49OcoxY2@itl-email>
 <ec3d7ebe62654e949329785bb32c3822@AcuMS.aculab.com>
 <ZIiMrDxI5Ts0s8fK@itl-email>
In-Reply-To: <ZIiMrDxI5Ts0s8fK@itl-email>
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

RnJvbTogRGVtaSBNYXJpZSBPYmVub3VyDQo+IFNlbnQ6IDEzIEp1bmUgMjAyMyAxNjozNQ0KPiAN
Cj4gT24gVHVlLCBKdW4gMTMsIDIwMjMgYXQgMDE6MDI6NTlQTSArMDAwMCwgRGF2aWQgTGFpZ2h0
IHdyb3RlOg0KPiA+IEZyb206IERlbWkgTWFyaWUgT2Jlbm91cg0KPiA+ID4gU2VudDogMTIgSnVu
ZSAyMDIzIDIyOjIzDQo+ID4gLi4uLg0KPiA+ID4gc3NjYW5mKCksIGV4Y2VwdCB0byB0aGUgZXh0
ZW50IHRoYXQgLVdlcnJvcj1mb3JtYXQgY2FuIGtlZXAgd29ya2luZy4NCj4gPiA+IFVzZXJzcGFj
ZSBzc2NhbmYoKSBpcyBhbG1vc3QgdXNlbGVzczogaXQgaGFzIHVuZGVmaW5lZCBiZWhhdmlvciBv
bg0KPiA+ID4gaW50ZWdlciBvdmVyZmxvdyBhbmQgc3dhbGxvd3Mgc3BhY2VzIHRoYXQgc2hvdWxk
IHVzdWFsbHkgYmUgcmVqZWN0ZWQuDQo+ID4NCj4gPiBzY2FuZigpIGlzIGRlc2lnbmVkIGZvciBw
YXJzaW5nIHNwYWNlIHNlcGFyYXRlZCBkYXRhLg0KPiA+IEVhdGluZyBzcGFjZXMgaXQgcGFydCBv
ZiBpdHMgam9iIGRlc2NyaXB0aW9uLg0KPiA+DQo+ID4gCURhdmlkDQo+IA0KPiBJbiB0aGlzIGNh
c2UgSSB3b3VsZCBwcmVmZXIgdG8gaGF2ZSB0d28gdmVyc2lvbnM6IG9uZSB0aGF0IGVhdHMgc3Bh
Y2VzDQo+IGFuZCBvbmUgdGhhdCBkb2VzIG5vdC4gIEZvciBpbnN0YW5jZSwgSSBkb27igJl0IHRo
aW5rIGFueSB1c2VyIG9mDQo+IHhlbmJ1c19zY2FuZigpIHdhbnRzIHRoZSBzcGFjZS1zd2FsbG93
aW5nIGJlaGF2aW9yLiAgVGhpcyBjYW4gYmUgd29ya2VkDQo+IGFyb3VuZCBpbiB4ZW5idXNfc2Nh
bmYoKSwgb2YgY291cnNlLCBieSBoYXZpbmcgaXQgcmVqZWN0IHN0cmluZ3Mgd2l0aA0KPiBzcGFj
ZXMgKGFzIGRldGVybWVuZWQgYnkgaXNzcGFjZSgpKSBiZWZvcmUgY2FsbGluZyB2c3NjYW5mKCku
DQoNCldoYXQgc29ydCBvZiBmb3JtYXRzIGFuZCBkYXRhIGFyZSBiZWluZyB1c2VkPw0KVGhlICIl
cyIgZm9ybWF0IHRlcm1pbmF0ZXMgb24gd2hpdGVzcGFjZS4NCkV2ZW4gc3Ryb3VsKCkgKGFuZCBm
cmllbmRzKSB3aWxsIHNraXAgbGVhZGluZyB3aGl0ZXNwYWNlLg0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

