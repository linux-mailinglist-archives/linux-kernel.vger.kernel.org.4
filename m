Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E31973172F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344114AbjFOLk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344024AbjFOLjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:39:01 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DD23589
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:38:19 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-155-mKsAI_mHNQGBHsCOtbe2aQ-1; Thu, 15 Jun 2023 12:38:16 +0100
X-MC-Unique: mKsAI_mHNQGBHsCOtbe2aQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 15 Jun
 2023 12:38:13 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 15 Jun 2023 12:38:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
CC:     'Demi Marie Obenour' <demi@invisiblethingslab.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
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
Thread-Index: AQHZnXRzYKsBWmeEwU2LY4YQ5TFW+a+Is3nggAAaG4CAASnjAIAAtO+AgADXzkCAACfhgIAAEh0g
Date:   Thu, 15 Jun 2023 11:38:13 +0000
Message-ID: <721db7fc08f640baa1c806e23549220a@AcuMS.aculab.com>
References: <6ab6adce-2318-4ae6-bde6-4317485639fd@p183>
 <ZId/IA41c2sJyvE0@itl-email> <ZIeHfBf3aB3vUgRM@smile.fi.intel.com>
 <ZIeMyQXU49OcoxY2@itl-email>
 <ec3d7ebe62654e949329785bb32c3822@AcuMS.aculab.com>
 <ZIiMrDxI5Ts0s8fK@itl-email>
 <23df90dd35874fd89c64906e6a6de164@AcuMS.aculab.com>
 <ZIoeVjC6offUywop@itl-email>
 <e354268a4efe48c9a8023a30c7292d12@AcuMS.aculab.com>
 <ZIr0z6u17xogE5+n@smile.fi.intel.com>
In-Reply-To: <ZIr0z6u17xogE5+n@smile.fi.intel.com>
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

RnJvbTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+
DQo+IFNlbnQ6IDE1IEp1bmUgMjAyMyAxMjoyNA0KPiAuLi4NCj4gDQo+ID4gPiA+IFdoYXQgc29y
dCBvZiBmb3JtYXRzIGFuZCBkYXRhIGFyZSBiZWluZyB1c2VkPw0KPiA+ID4NCj4gPiA+IEJhc2Ut
MTAgb3IgYmFzZS0xNiBpbnRlZ2Vycywgd2l0aCB3aGl0ZXNwYWNlIG5ldmVyIGJlaW5nIHZhbGlk
Lg0KPiA+DQo+ID4gSW4gd2hpY2ggY2FzZSBzc2NhbmYoKSByZWFsbHkgaXNuJ3Qgd2hhdCB5b3Ug
YXJlIGxvb2tpbmcgZm9yLg0KPiA+DQo+ID4gPiA+IFRoZSAiJXMiIGZvcm1hdCB0ZXJtaW5hdGVz
IG9uIHdoaXRlc3BhY2UuDQo+ID4gPiA+IEV2ZW4gc3Ryb3VsKCkgKGFuZCBmcmllbmRzKSB3aWxs
IHNraXAgbGVhZGluZyB3aGl0ZXNwYWNlLg0KPiA+ID4NCj4gPiA+IFllcywgd2hpY2ggaXMgYSBy
ZWFzb24gdGhhdCBzdHJ0bypsKCkgYXJlIGp1c3QgYnJva2VuIElNTy4NCj4gPg0KPiA+IFRoZXkg
YXJlIG5vdCAnYnJva2VuJywgdGhhdCBpcyB3aGF0IGlzIHVzZWZ1bCBtb3N0IG9mIHRoZSB0aW1l
Lg0KPiA+IFRoZSB1c3VhbCBwcm9ibGVtIGlzIHRoYXQgIjAyMCIgaXMgdHJlYXRlZCBhcyBvY3Rh
bC4NCj4gPg0KPiA+ID4gSeKAmW0gdHJ5aW5nIHRvIHJlcGxhY2UgdGhlaXIgdXNlcyBpbiBYZW4g
d2l0aCBjdXN0b20gcGFyc2luZyBjb2RlLg0KPiA+DQo+ID4gVGhlbiB3cml0ZSBhIGN1c3RvbSBw
YXJzZXIgOi0pDQo+IA0KPiBIbW0uLi4gVXN1YWxseSB3ZSBhcmUgYWdhaW5zdCB6aWxsaW9uIGlt
cGxlbWVudGF0aW9ucyBvZiB0aGUgc2FtZSB3aXRoIHppbGxpb24NCj4gYnVncyBoaWRkZW4gKGVh
Y2ggYnVnZ3kgaW1wbGVtZW50YXRpb24gd2l0aCBpdHMgb3duIGJ1Z3MpLg0KDQpVc2luZyBzdHJ0
b3VsbCgpIGZvciB0aGUgYWN0dWFsIG51bWVyaWMgY29udmVyc2lvbiByZW1vdmVzIG1vc3Qgb2Yg
dGhhdC4NCg0KSSBhbSBpbnRyaWd1ZWQgYWJvdXQgd2h5IHlvdSB3YW50IHRvIGVycm9yIGxlYWRp
bmcgd2hpdGVzcGFjZS4NCkkgYmV0IHlvdSdsbCBmaW5kIHNvbWV0aGluZyB0aGF0IGlzIHBhc3Np
bmcgc3BhY2UtcGFkZGVkIGlucHV0Lg0KSXQgbWlnaHQgYmUgYWdhaW5zdCB0aGUgbGV0dGVyIG9m
IHRoZSBzcGVjIC0gYnV0IGl0IGRvZXNuJ3QgbWVhbg0KaXQgZG9lc24ndCBoYXBwZW4uDQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=

