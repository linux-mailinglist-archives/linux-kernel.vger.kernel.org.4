Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9036BE88D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjCQLtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjCQLth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:49:37 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BAE515E6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1679053776; x=1710589776;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PQx0CrTW19F7IamZ+8F11dyIB1erYgzc8KaXb87iwOs=;
  b=l55gKFZLofN3jeBHuxMh08TXp0ZuheuPC3eY2ynvoRHPcCrADtNzkq2K
   VA+U9ArqZLMIhzq2dmKnAsuez49dsAuLx4QQBdrghu33joR5f7alMpGfo
   L1+5CX8kfHxpoWFqBl329lVTNVbRAYcJo++f4DHAtsOEM+hd1GyKTd/el
   A=;
X-IronPort-AV: E=Sophos;i="5.98,268,1673913600"; 
   d="scan'208";a="1113660382"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 11:49:30 +0000
Received: from EX19D001EUB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com (Postfix) with ESMTPS id 8837EA0A30;
        Fri, 17 Mar 2023 11:49:29 +0000 (UTC)
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D001EUB001.ant.amazon.com (10.252.51.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.24; Fri, 17 Mar 2023 11:49:28 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.024; Fri, 17 Mar 2023 11:49:28 +0000
From:   "Gowans, James" <jgowans@amazon.com>
To:     "zouyipeng@huawei.com" <zouyipeng@huawei.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "maz@kernel.org" <maz@kernel.org>,
        "Raslan, KarimAllah" <karahmed@amazon.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
Thread-Topic: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
Thread-Index: AQHZWMaHvArk6ub1ukOl5lZbdF3CpA==
Date:   Fri, 17 Mar 2023 11:49:28 +0000
Message-ID: <001d516c1bb6f0b6d2344f1ae160e796d003c24c.camel@amazon.com>
References: <20230317095300.4076497-1-jgowans@amazon.com>
         <f0879a30-6f88-30e0-ce30-e230df8f2936@huawei.com>
In-Reply-To: <f0879a30-6f88-30e0-ce30-e230df8f2936@huawei.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.31.190.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CD950ABCBB3EC428F19594EC5E9ACF7@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAzLTE3IGF0IDE4OjEyICswODAwLCBZaXBlbmcgWm91IHdyb3RlOg0KPiBJ
dCBzZWVtcyB0aGF0IHdlIGhhdmUgdGhlIHNhbWUgc29sdXRpb24uDQoNClRoYXQncyBhIGdvb2Qg
c2lnbiEgOkQNCg0KPiAoSSBpbnRyb2R1Y2VkIGEgbmV3IGZsb3cgaGFuZGxlcikuDQoNCkkgY29u
c2lkZXJlZCB0aGlzLCBidXQgSU1PIGEgbmV3IGhhbmRsZXIgaXNuJ3QgdGhlIHdheSB0byBnbzog
d2UgYWxyZWFkeSBoYXZlIGENCmJpdCBvZiBoYW5kbGVyIHByb2xpZmVyYXRpb24gZ29pbmcgb24g
aGVyZS4gQXMgbWVudGlvbmVkIGluIG15IGNvbW1pdCBtZXNzYWdlDQp0aGVyZSB0aGlzIGlzIHN0
YXJ0aW5nIHRvIGdldCBjbG9zZXIgdG8gaGFuZGxlX2VkZ2VfZW9pX2lycSwgYW5kIGFkZGluZyBh
IG5ldw0KZ2VuZXJpYyBoYW5kbGVyIHdoaWNoIGlzIGEgbWl4IG9mIHRoZSB0d28gZXhpc3Rpbmcg
c2VlbXMgdG8ganVzdCBhZGQgbW9yZQ0KY29uZnVzaW9uOiB3aGljaCBvbmUgc2hvdWxkIGEgZHJp
dmVyIG93bmVyIHVzZT8gSSB0aGluayBpdCdsbCBiZSBncmVhdCBpZiB3ZSBjYW4NCmVuaGFuY2Ug
dGhlIGV4aXN0aW5nIGdlbmVyaWMgaGFuZGxlcnMgdG8gY2F0ZXIgZm9yIHRoZSB2YXJpb3VzIGVk
Z2UgY2FzZXMgYW5kDQpwZXJoYXBzIGV2ZW4gbWVyZ2UgdGhlc2UgZ2VuZXJpYyBoYW5kbGVycyBp
biBmdXR1cmUuDQoNCldoYXQgYXJlIHlvdXIgdGhvdWdodHMgb24gdGhpcyBhcHByb2FjaCBjb21w
YXJlZCB0byB5b3VyIHByb3Bvc2FsPw0KDQpUaGVyZSBpcyBhbHNvIHRoZSAiZGVsYXkgdGhlIGFm
ZmluaXR5IGNoYW5nZSBvZiBMUEkgdW50aWwgdGhlIG5leHQgaW50ZXJydXB0DQphY2tub3dsZWRn
ZSIgb3B0aW9uIGRlc2NyaWJlZCBpbiB0aGUgcHJldmlvdXMgdGhyZWFkIFswXS4gSSBhbHNvIGNv
bnNpZGVyZWQgdGhhdA0KYnV0IHNlZWluZyBhcyB0aGUgaGFuZGxlX2VkZ2VfaXJxIGRvZXMgdGhl
IGFwcHJvYWNoIGltcGxlbWVudGVkIGhlcmUgb2Ygc2V0dGluZw0KdGhlIFBFTkRJTkcgZmxhZyBh
bmQgdGhlbiByZS1ydW5uaW5nIGl0LCBpdCBzZWVtZWQgbGlrZSBnb29kIHByaW9yIGFydCB0byBk
cmF3DQpvbi4gSXMgdGhhdCBvcHRpb24gb2YgZW5hYmxpbmcgQ09ORklHX0dFTkVSSUNfUEVORElO
R19JUlEgYSB2aWFibGU/IElNTyB0aGUNCmdlbmVyaWMgaGFuZGxlcnMgc2hvdWxkIGJlIHJlc2ls
aWVudCB0byB0aGlzIHNvIEkgd291bGQgcHJlZmVyIHRoaXMgZml4IHRoYW4NCmRlcGVuZGluZyBv
biB0aGUgdXNlciB0byBrbm93IHRvIHNldCB0aGlzIGNvbmZpZyBvcHRpb24uDQoNCkpHDQoNClsw
XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvYjBmMjYyM2ItZWM3MC1kNTdlLWI3NDQtMjZj
NjJiMWNlNTIzQGh1YXdlaS5jb20vDQo=
