Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C857C72DBFD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbjFMIGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbjFMIGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:06:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E8E11D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:05:57 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-311-UA6G7ItlP1ewooZVyM1W0A-1; Tue, 13 Jun 2023 09:05:43 +0100
X-MC-Unique: UA6G7ItlP1ewooZVyM1W0A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 13 Jun
 2023 09:05:27 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 13 Jun 2023 09:05:27 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Stephen Boyd' <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Christopher Obbard <chris.obbard@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: RE: [PATCH v2 2/2] clk: divider: Fix divisions
Thread-Topic: [PATCH v2 2/2] clk: divider: Fix divisions
Thread-Index: AQHZnY/ao7Gg3fNCxki9HY0rumOgxq+IX4vg
Date:   Tue, 13 Jun 2023 08:05:27 +0000
Message-ID: <919a361dd5f54e738d4824f8096d243c@AcuMS.aculab.com>
References: <20230526171057.66876-1-sebastian.reichel@collabora.com>
 <20230526171057.66876-3-sebastian.reichel@collabora.com>
 <5e9e776db6628d02d7081292b81ab102.sboyd@kernel.org>
In-Reply-To: <5e9e776db6628d02d7081292b81ab102.sboyd@kernel.org>
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3RlcGhlbiBCb3lkDQo+IFNlbnQ6IDEzIEp1bmUgMjAyMyAwMTo0Mg0KPiANCj4gUXVv
dGluZyBTZWJhc3RpYW4gUmVpY2hlbCAoMjAyMy0wNS0yNiAxMDoxMDo1NykNCj4gPiBUaGUgY2xv
Y2sgZnJhbWV3b3JrIGhhbmRsZXMgY2xvY2sgcmF0ZXMgYXMgInVuc2lnbmVkIGxvbmciLCBzbyB1
MzIgb24NCj4gPiAzMi1iaXQgYXJjaGl0ZWN0dXJlcyBhbmQgdTY0IG9uIDY0LWJpdCBhcmNoaXRl
Y3R1cmVzLg0KPiA+DQo+ID4gVGhlIGN1cnJlbnQgY29kZSBwb2ludGxlc3NseSBjYXN0cyB0aGUg
ZGl2aWRlbmQgdG8gdTY0IG9uIDMyLWJpdA0KPiA+IGFyY2hpdGVjdHVyZXMgYW5kIHRodXMgcG9p
bnRsZXNzbHkgcmVkdWNpbmcgdGhlIHBlcmZvcm1hbmNlLg0KPiANCj4gSXQgbG9va3MgbGlrZSB0
aGF0IHdhcyBkb25lIHRvIG1ha2UgdGhlIERJVl9ST1VORF9VUCgpIG1hY3JvIG5vdA0KPiBvdmVy
ZmxvdyB0aGUgZGl2aWRlbmQgb24gMzItYml0IG1hY2hpbmVzIChmcm9tIDk1NTZmOWRhZDhmNSk6
DQo+IA0KPiAgIERJVl9ST1VORF9VUCgzMDAwMDAwMDAwLCAxNTAwMDAwMDAwKSA9ICgzLjBHICsg
MS41RyAtIDEpIC8gMS41Rw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA9IE9WRVJGTE9XIC8gMS41Rw0KDQpNYXliZSBhZGQ6DQojZGVmaW5lIERJVl9ST1VORF9VUF9O
Wih4LCB5KSAoKCh4KSAtIDEpLyh5KSArIDEpDQp3aGljaCBkb2Vzbid0IG92ZXJmbG93IGJ1dCBy
ZXF1aXJlcyB4ICE9IDAuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

