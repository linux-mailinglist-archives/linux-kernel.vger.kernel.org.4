Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFFA72E3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242592AbjFMNDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242502AbjFMND0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:03:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEBC1FDB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:03:09 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-92-cdkeahV1M1Wxdgybzmjttw-1; Tue, 13 Jun 2023 14:03:03 +0100
X-MC-Unique: cdkeahV1M1Wxdgybzmjttw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 13 Jun
 2023 14:02:59 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 13 Jun 2023 14:02:59 +0100
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
Thread-Index: AQHZnXRzYKsBWmeEwU2LY4YQ5TFW+a+Is3ng
Date:   Tue, 13 Jun 2023 13:02:59 +0000
Message-ID: <ec3d7ebe62654e949329785bb32c3822@AcuMS.aculab.com>
References: <6ab6adce-2318-4ae6-bde6-4317485639fd@p183>
 <ZId/IA41c2sJyvE0@itl-email> <ZIeHfBf3aB3vUgRM@smile.fi.intel.com>
 <ZIeMyQXU49OcoxY2@itl-email>
In-Reply-To: <ZIeMyQXU49OcoxY2@itl-email>
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

RnJvbTogRGVtaSBNYXJpZSBPYmVub3VyDQo+IFNlbnQ6IDEyIEp1bmUgMjAyMyAyMjoyMw0KLi4u
Lg0KPiBzc2NhbmYoKSwgZXhjZXB0IHRvIHRoZSBleHRlbnQgdGhhdCAtV2Vycm9yPWZvcm1hdCBj
YW4ga2VlcCB3b3JraW5nLg0KPiBVc2Vyc3BhY2Ugc3NjYW5mKCkgaXMgYWxtb3N0IHVzZWxlc3M6
IGl0IGhhcyB1bmRlZmluZWQgYmVoYXZpb3Igb24NCj4gaW50ZWdlciBvdmVyZmxvdyBhbmQgc3dh
bGxvd3Mgc3BhY2VzIHRoYXQgc2hvdWxkIHVzdWFsbHkgYmUgcmVqZWN0ZWQuDQoNCnNjYW5mKCkg
aXMgZGVzaWduZWQgZm9yIHBhcnNpbmcgc3BhY2Ugc2VwYXJhdGVkIGRhdGEuDQpFYXRpbmcgc3Bh
Y2VzIGl0IHBhcnQgb2YgaXRzIGpvYiBkZXNjcmlwdGlvbi4NCg0KCURhdmlkDQoNCi0NClJlZ2lz
dGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24g
S2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

