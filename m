Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231EC6CF4A7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjC2UrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjC2UrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:47:09 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29751985
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 13:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1680122826; x=1711658826;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=eTjC1UdTvLK5zPpXv7l3TkZpy7dew4PiGY8pOMl/axs=;
  b=P3a4z0Gcq60ipwJYs3P/FHqi7kJbhz0fTNahl/hz+ietbnrQfeVmsUPw
   cvDt3E+e8RvwtNbErCliW+RYkkG6s+Wi5oey54JrwMTaobGOdYhIGpR1s
   qUJd2ivhvLjaOorGkAa3mw7cUvW/7ssbDiG3FUjCbmrLdHpQ9nUEtZwNS
   I=;
X-IronPort-AV: E=Sophos;i="5.98,301,1673913600"; 
   d="scan'208";a="1117676147"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 20:46:55 +0000
Received: from EX19D013EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com (Postfix) with ESMTPS id 7FFE8819B0;
        Wed, 29 Mar 2023 20:46:54 +0000 (UTC)
Received: from EX19D030EUC003.ant.amazon.com (10.252.61.173) by
 EX19D013EUA004.ant.amazon.com (10.252.50.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.26;
 Wed, 29 Mar 2023 20:46:53 +0000
Received: from EX19D030EUC004.ant.amazon.com (10.252.61.164) by
 EX19D030EUC003.ant.amazon.com (10.252.61.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.26;
 Wed, 29 Mar 2023 20:46:53 +0000
Received: from EX19D030EUC004.ant.amazon.com ([fe80::f98a:db18:b0eb:477]) by
 EX19D030EUC004.ant.amazon.com ([fe80::f98a:db18:b0eb:477%3]) with mapi id
 15.02.1118.026; Wed, 29 Mar 2023 20:46:53 +0000
From:   "Krcka, Tomas" <krckatom@amazon.de>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: Be less noisy during memory hotplug
Thread-Topic: [PATCH] mm: Be less noisy during memory hotplug
Thread-Index: AQHZYn+XVs9W/BOLZUmW8MFYQtAZcw==
Date:   Wed, 29 Mar 2023 20:46:53 +0000
Message-ID: <DA14AE2A-0ABA-40A4-A6F7-7279E441ADE7@amazon.com>
References: <20230323171904.14444-1-krckatom@amazon.de>
 <CA+CK2bDEPvQnMqv7R9JZybsNWbaMdHOPA0vKs501Txsu2OewKQ@mail.gmail.com>
 <CA+CK2bAPSeEmQk6uazxSn3k7kWf0f6D6z+3BdHdWJPZXFBBg9w@mail.gmail.com>
In-Reply-To: <CA+CK2bAPSeEmQk6uazxSn3k7kWf0f6D6z+3BdHdWJPZXFBBg9w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.213.23]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD9882EF5E72CD438B51B21BFAB281A6@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gMjMuIE1hciAyMDIzLCBhdCAyMDowNiwgUGFzaGEgVGF0YXNoaW4gPHBhc2hhLnRh
dGFzaGluQHNvbGVlbi5jb20+IHdyb3RlOg0KPiANCj4gDQo+IE9uIFRodSwgTWFyIDIzLCAyMDIz
IGF0IDI6MzfigK9QTSBQYXNoYSBUYXRhc2hpbg0KPiA8cGFzaGEudGF0YXNoaW5Ac29sZWVuLmNv
bT4gd3JvdGU6DQo+PiANCj4+IE9uIFRodSwgTWFyIDIzLCAyMDIzIGF0IDE6MTnigK9QTSBUb21h
cyBLcmNrYSA8a3Jja2F0b21AYW1hem9uLmRlPiB3cm90ZToNCj4+PiANCj4+PiBUdXJuIGEgcHJf
aW5mbygpIGludG8gYSBwcl9kZWJ1ZygpIHRvIHByZXZlbnQgZG1lc2cgc3BhbW1pbmcgb24gc3lz
dGVtcw0KPj4+IHdoZXJlIG1lbW9yeSBob3RwbHVnIGlzIGEgZnJlcXVlbnQgb3BlcmF0aW9uLg0K
Pj4+IA0KPj4+IEZpeGVzOiA5NjZjZjQ0ZjYzN2UgKCJtbTogZGVmZXIgWk9ORV9ERVZJQ0UgcGFn
ZSBpbml0aWFsaXphdGlvbiB0byB0aGUgcG9pbnQgd2hlcmUgd2UgaW5pdCBwZ21hcCIpDQo+Pj4g
DQo+Pj4gU3VnZ2VzdGVkLWJ5OiBKYW4gSC4gU2Now7ZuaGVyciA8anNjaG9lbmhAYW1hem9uLmRl
Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFRvbWFzIEtyY2thIDxrcmNrYXRvbUBhbWF6b24uZGU+DQo+
PiANCj4+IFJldmlld2VkLWJ5OiBQYXNoYSBUYXRhc2hpbiA8cGFzaGEudGF0YXNoaW5Ac29sZWVu
LmNvbT4NCj4gDQo+IENhbiB5b3UgcGxlYXNlIHNwZWNpZnkgd2hhdCB5b3UgbWVhbiBieSBmcmVx
dWVudCBob3RwbHVnOiB3b3cgZnJlcXVlbnQNCj4gaXMgaXQgYW5kIHdoYXQgaXMgdGhlIHVzZWNh
c2U/DQoNClRoZSB1c2UgY2FzZSBpcyB2aXJ0dWFsaXphdGlvbiBlbnZpcm9ubWVudCwgY2FzZSBs
aWtlIG5ldyB2aXJ0dWFsIG1hY2hpbmVzDQphcmUgc3B1biB1cCBhbmQgc2h1dCBkb3duIGZyZXF1
ZW50bHkgYW5kIHdoZXJlIHRoZSB3b3JrbG9hZCBvZiB0aGUgdmlydHVhbA0KbWFjaGluZXMgdmFy
aWVzIHdpZGVseSBvdmVyIHRpbWUuIFNvIHNwZWNpYWxseSBpbiBjYXNlIG9mIHNtYWxsIHZpcnR1
YWwgbWFjaGluZXMuDQpXZSBjYW4gdGFsayBhYm91dCBtdWx0aXBsZSB0aW1lcyBwZXIgaG91ciwg
ZGVwZW5kcyBvbiB0aGUgd29ya2xvYWQuDQoNCj4gDQo+IFRoYW5rcywNCj4gUGFzaGENCg0KCgoK
QW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAx
MTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRo
YW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIg
SFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK

