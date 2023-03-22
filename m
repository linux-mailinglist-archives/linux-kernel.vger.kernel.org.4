Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B950A6C4456
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjCVHsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCVHsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:48:38 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4E9515C8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1679471318; x=1711007318;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gWD/199U9Z6p1OQ+STquAoH+Xiq446QsJqjvFjoaxzk=;
  b=ijQ2EoueGDkWyJ9RupnDXjMJJuz/xxSBqHOE4Gzg7Du6w5QECfCMN+TX
   GUT/btFHsbHsBR2Nm4Sx2U13JkprXsKaT1AGphCHjWtxSmKdAjG0q3Pqf
   ewHtV/52bziMPxLpJhj7S91Oirs+PZc0r2rFvktsaoxROnb8cUmtA4eJs
   s=;
X-IronPort-AV: E=Sophos;i="5.98,281,1673913600"; 
   d="scan'208";a="305784623"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:48:35 +0000
Received: from EX19D001EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id AAB1181C71;
        Wed, 22 Mar 2023 07:48:33 +0000 (UTC)
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D001EUA004.ant.amazon.com (10.252.50.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 22 Mar 2023 07:48:31 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.024; Wed, 22 Mar 2023 07:48:31 +0000
From:   "Gowans, James" <jgowans@amazon.com>
To:     "zouyipeng@huawei.com" <zouyipeng@huawei.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "maz@kernel.org" <maz@kernel.org>,
        "Raslan, KarimAllah" <karahmed@amazon.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
Thread-Topic: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
Thread-Index: AQHZXJKyDjg3qzMVRUmFyh7TAqCRhA==
Date:   Wed, 22 Mar 2023 07:48:31 +0000
Message-ID: <fd5588e5b0b1b5d21b1c0df7290844907ebcf367.camel@amazon.com>
References: <20230317095300.4076497-1-jgowans@amazon.com>
         <f0879a30-6f88-30e0-ce30-e230df8f2936@huawei.com>
         <001d516c1bb6f0b6d2344f1ae160e796d003c24c.camel@amazon.com>
         <6d1859b0-20f3-05a8-d8d6-dfb0c9985985@huawei.com>
In-Reply-To: <6d1859b0-20f3-05a8-d8d6-dfb0c9985985@huawei.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.225]
Content-Type: text/plain; charset="utf-8"
Content-ID: <595C775C95A42841B1853744697EDF80@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-10.0 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTIyIGF0IDE0OjI2ICswODAwLCBZaXBlbmcgWm91IHdyb3RlOg0KPiA+
IOWcqCAyMDIzLzMvMTcgMTk6NDksIEdvd2FucywgSmFtZXMg5YaZ6YGTOg0KPiA+IFdoYXQgYXJl
IHlvdXIgdGhvdWdodHMgb24gdGhpcyBhcHByb2FjaCBjb21wYXJlZCB0byB5b3VyIHByb3Bvc2Fs
Pw0KPiANCj4gSGksDQo+IA0KPiBJIGFsc28gYWdyZWUgd2l0aCB5b3UsIGVuaGFuY2UgdGhlIGV4
aXN0aW5nIGdlbmVyaWMgaGFuZGxlcnMgaXMgYSBnb29kDQo+IHdheSB0byBnby4NCj4gDQo+IFRv
byBtYW55IGdlbmVyaWMgaGFuZGxlcnMgcmVhbGx5IGNvbmZ1c2UgZGV2ZWxvcGVycy4NCg0KVGhv
bWFzLCB3b3VsZCB5b3UgYmUgb3BlbiB0byB0YWtpbmcgdGhlIHBhdGNoIHRvIHR3ZWFrIHRoZSBo
YW5kbGVfZmFzdGVvaV9pcnENCmhhbmRsZXI/IE9yIGlzIHRoZXJlIGEgZGlmZmVyZW50IHNvbHV0
aW9uIHRvIHRoaXMgcHJvYmxlbSB3aGljaCB5b3UgcHJlZmVyPw0KDQo+IEFib3V0IENPTkZJR19H
RU5FUklDX1BFTkRJTkdfSVJRIGlzIGFjdHVhbGx5IHNvbWUgYXR0ZW1wdHMgd2UgbWFkZQ0KPiBi
ZWZvcmUgdW5kZXIgdGhlIHN1Z2dlc3Rpb24gb2YgVGhvbWFzLg0KPiANCj4gVGhpcyBwYXRjaCBp
cyB2YWxpZCBmb3Igb3VyIHByb2JsZW0uIEhvd2V2ZXIsIHRoZSBjdXJyZW50IGNvbmZpZyBpcyBv
bmx5DQo+IHN1cHBvcnRlZCBvbiB4ODYsIGFuZCBzb21lIGNvZGUgbW9kaWZpY2F0aW9ucyBhcmUg
cmVxdWlyZWQgb24gYXJtLg0KDQpUaGFua3MgZm9yIHRoZSBwYXRjaCEgSSBoYXZlIGJlZW4gdHJ5
aW5nIG91dCBDT05GSUdfR0VORVJJQ19QRU5ESU5HX0lSUSB0b28sIGJ1dA0KY291bGRuJ3QgZ2V0
IGl0IHRvIHdvcms7IGl0IHNlZW1zIHRoZSBJUlEgbmV2ZXIgYWN0dWFsbHkgbW92ZWQuIEkgc2Vl
IGZyb20geW91cg0KcGF0Y2ggdGhhdCB3ZSB3b3VsZCBuZWVkIHRvIHR3ZWFrIHRoZSBjYWxsYmFj
a3MgYW5kIGV4cGxpY2l0bHkgZG8gdGhlIGFmZmluaXR5DQptb3ZlIGluIHRoZSBFT0kgaGFuZGxl
ciBvZiB0aGUgY2hpcDsgdGhlIGdlbmVyaWMgY29kZSB3b24ndCBkbyBpdCBmb3IgdXMuDQoNCj4g
VGhpcyBoYXMgbGVkIHRvIHNvbWUgY2hhbmdlcyBpbiB0aGUgb3JpZ2luYWwgYmVoYXZpb3Igb2Yg
bW9kaWZ5aW5nDQo+IGludGVycnVwdGluZyBhZmZpbml0eSwgZnJvbSB0aGUgbmV4dCBpbnRlcnJ1
cHQgdGFraW5nIGVmZmVjdCB0byB0aGUgbmV4dA0KPiB0byB0aGUgbmV4dCBpbnRlcnJ1cHQgdGFr
aW5nIGVmZmVjdC4NCg0KU28gdGhpcyBtZWFucyB0aGF0IGV2ZW4gaWYgaXQncyBzYWZlIHRvIGNo
YW5nZSB0aGUgYWZmaW5pdHkgcmlnaHQgbm93LCB0aGUNCmNoYW5nZSB3aWxsIGFjdHVhbGx5IGJl
IGRlbGF5ZWQgdW50aWwgdGhlICpuZXh0KiBpbnRlcnJ1cHQ/IFNwZWNpZmljYWxseSBiZWNhdXNl
DQppbnRlcnJ1cHQgZG9lc24ndCBoYXZlIHRoZSBJUlFEX01PVkVfUENOVFhUIHN0YXRlIGZsYWcg
aXNuJ3Qgc2V0IGhlbmNlDQppcnFfc2V0X2FmZmluaXR5X2xvY2tlZCB3b24ndCBjYWxsIGlycV90
cnlfc2V0X2FmZmluaXR5Pw0KDQoNCkpHDQo=
