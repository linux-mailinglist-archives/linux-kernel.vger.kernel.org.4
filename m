Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1958C70D7F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbjEWIzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbjEWIza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:55:30 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2BD109
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:55:27 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-114-wfYMCpxpPx2Orn_grdK5TA-1; Tue, 23 May 2023 09:55:10 +0100
X-MC-Unique: wfYMCpxpPx2Orn_grdK5TA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 23 May
 2023 09:55:08 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 23 May 2023 09:55:08 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Geert Uytterhoeven' <geert@linux-m68k.org>
CC:     Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@kernel.org>,
        "Tomasz Figa" <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] iopoll: Call cpu_relax() in busy loops
Thread-Topic: [PATCH v2 1/2] iopoll: Call cpu_relax() in busy loops
Thread-Index: AQHZg9SqgvUK/klkyEy9n2eMPFqMgK9U5DUggBKUGYCAACeioA==
Date:   Tue, 23 May 2023 08:55:08 +0000
Message-ID: <515a4c94ce764c58ab9a311d6cc5187f@AcuMS.aculab.com>
References: <cover.1683722688.git.geert+renesas@glider.be>
 <fe235a1f65bb6c86d2afcdf52d85f80ae728dcc5.1683722688.git.geert+renesas@glider.be>
 <20230511064839.GG14287@atomide.com>
 <494a000774b546e4aae00ae0a7dfeae4@AcuMS.aculab.com>
 <CAMuHMdXttS3mkA+BNC69e6MYniRyGtR2vde35BYgBZ_+SuYs_Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXttS3mkA+BNC69e6MYniRyGtR2vde35BYgBZ_+SuYs_Q@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuDQo+IFNlbnQ6IDIzIE1heSAyMDIzIDA4OjMwDQo+IA0K
PiBIaSBEYXZpZCwNCj4gDQo+IE9uIFRodSwgTWF5IDExLCAyMDIzIGF0IDEyOjQ54oCvUE0gRGF2
aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4gPiAqIEdlZXJ0
IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+IFsyMzA1MTAgMTM6MjNdOg0K
PiA+ID4gPiBJdCBpcyBjb25zaWRlcmVkIGdvb2QgcHJhY3RpY2UgdG8gY2FsbCBjcHVfcmVsYXgo
KSBpbiBidXN5IGxvb3BzLCBzZWUNCj4gPiA+ID4gRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3ZvbGF0
aWxlLWNvbnNpZGVyZWQtaGFybWZ1bC5yc3QuICBUaGlzIGNhbiBub3QNCj4gPiA+ID4gb25seSBs
b3dlciBDUFUgcG93ZXIgY29uc3VtcHRpb24gb3IgeWllbGQgdG8gYSBoeXBlcnRocmVhZGVkIHR3
aW4NCj4gPiA+ID4gcHJvY2Vzc29yLCBidXQgYWxzbyBhbGxvd3MgYW4gYXJjaGl0ZWN0dXJlIHRv
IG1pdGlnYXRlIGhhcmR3YXJlIGlzc3Vlcw0KPiA+ID4gPiAoZS5nLiBBUk0gRXJyYXR1bSA3NTQz
MjcgZm9yIENvcnRleC1BOSBwcmlvciB0byByMnAwKSBpbiB0aGUNCj4gPiA+ID4gYXJjaGl0ZWN0
dXJlLXNwZWNpZmljIGNwdV9yZWxheCgpIGltcGxlbWVudGF0aW9uLg0KPiA+DQo+ID4gRG9uJ3Qg
eW91IGFsc28gbmVlZCB0byBjYWxsIGNvbmRfcmVzY2hlZCgpIChhdCBsZWFzdCBzb21lIHRpbWVz
KS4NCj4gPiBPdGhlcndpc2UgdGhlIHByb2Nlc3MgY2FuJ3QgYmUgcHJlLWVtcHRlZCBhbmQgYSBS
VCBwcm9jZXNzDQo+ID4gdGhhdCBsYXN0IHJhbiBvbiB0aGF0IGNwdSB3aWxsIG5ldmVyIGJlIHNj
aGVkdWxlZC4NCj4gDQo+IEFjY29yZGluZyB0byBbMV0sIGNvbmRfcmVzY2hlZCgpIG11c3QgYmUg
Y2FsbGVkIGF0IGxlYXN0IG9uY2UgcGVyIGZldw0KPiB0ZW5zIG9mIG1pbGxpc2Vjb25kcy4NCg0K
SG1tbS4uLi4gdGVucyBvZiBtaWxsaXNlY29uZHMgaXMgcmVhbGx5IG11Y2ggdG9vIGxvbmcgZm9y
IFJUIHRocmVhZHMuDQpBIGxpbWl0IG5lYXJlciAxbXMgd291bGQgYmUgYmFyZWx5IGFjY2VwdGFi
bGUuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=

