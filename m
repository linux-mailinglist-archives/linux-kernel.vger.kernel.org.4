Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F8F71941C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjFAHZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjFAHY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:24:59 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9E518F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 00:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685604297; x=1717140297;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J3Fj+1eGqYs7BE7BZnq4cZKJqhqU1iB3bNWMV2udwbo=;
  b=oLuiHEXYgW9MaY8woRFhWLffhXLcZmsCWR9fpUSiPffLon5Qnc7BzaIF
   azIXWxVTIzk6zfiWEpft+CgKCyzTI/kkAGER9ArxbqQfCDTCL04DYvefP
   T5Jfp87Mm67D+Qc7QohaKj6KwZ8QjejF7vmiCkgDOnYjwpOVuOMs4j4tM
   M=;
X-IronPort-AV: E=Sophos;i="6.00,209,1681171200"; 
   d="scan'208";a="330946173"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:24:54 +0000
Received: from EX19D001EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id A9AE74637B;
        Thu,  1 Jun 2023 07:24:52 +0000 (UTC)
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D001EUA001.ant.amazon.com (10.252.50.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 07:24:48 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.026; Thu, 1 Jun 2023 07:24:48 +0000
From:   "Gowans, James" <jgowans@amazon.com>
To:     "maz@kernel.org" <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "Raslan, KarimAllah" <karahmed@amazon.com>,
        "liaochang1@huawei.com" <liaochang1@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zouyipeng@huawei.com" <zouyipeng@huawei.com>,
        "chris.zjh@huawei.com" <chris.zjh@huawei.com>
Subject: Re: [PATCH 2/2] genirq: fasteoi resends interrupt on concurrent
 invoke
Thread-Topic: [PATCH 2/2] genirq: fasteoi resends interrupt on concurrent
 invoke
Thread-Index: AQHZlFolsBpe8L2DYUen+rvhN7X1hA==
Date:   Thu, 1 Jun 2023 07:24:48 +0000
Message-ID: <3903a508c15e7a75b6d637c8523c3bae13d6a7af.camel@amazon.com>
References: <20230530213848.3273006-1-jgowans@amazon.com>
         <20230530213848.3273006-2-jgowans@amazon.com>
         <867cspc7e2.wl-maz@kernel.org>
In-Reply-To: <867cspc7e2.wl-maz@kernel.org>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.225]
Content-Type: text/plain; charset="utf-8"
Content-ID: <08CAED25D4D3D440AA89A630D6CD403A@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTMxIGF0IDA4OjAwICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
ID4gR2VuZXJhbGx5IGl0IHNob3VsZCBub3QgYmUgcG9zc2libGUgZm9yIHRoZSBuZXh0IGludGVy
cnVwdCB0byBhcnJpdmUNCj4gPiB3aGlsZSB0aGUgcHJldmlvdXMgaGFuZGxlciBpcyBzdGlsbCBy
dW5uaW5nOiB0aGUgbmV4dCBpbnRlcnJ1cHQgc2hvdWxkDQo+ID4gb25seSBhcnJpdmUgYWZ0ZXIg
dGhlIEVPSSBtZXNzYWdlIGhhcyBiZWVuIHNlbnQgYW5kIHRoZSBwcmV2aW91cyBoYW5kbGVyDQo+
ID4gaGFzIHJldHVybmVkLg0KPiANCj4gVGhlcmUgaXMgbm8gc3VjaCBtZXNzYWdlIHdpdGggTFBJ
cy4gSSBwb2ludGVkIHRoYXQgb3V0IHByZXZpb3VzbHkuDQoNCkFyZywgdGhhbmtzLCBJJ2xsIHJl
LXdvcmQgdGhpcyB0bzoNCg0KIkdlbmVyYWxseSBpdCBzaG91bGQgbm90IGJlIHBvc3NpYmxlIGZv
ciB0aGUgbmV4dCBpbnRlcnJ1cHQgdG8gYXJyaXZlDQp3aGlsZSB0aGUgcHJldmlvdXMgaGFuZGxl
ciBpcyBzdGlsbCBydW5uaW5nOiB0aGUgQ1BVIHdpbGwgbm90IHByZWVtcHQgYW4NCmludGVycnVw
dCB3aXRoIGFub3RoZXIgZnJvbSB0aGUgc2FtZSBzb3VyY2Ugb3Igc2FtZSBwcmlvcml0eS4iDQoN
CkkgaG9wZSB0aGF0J3MgbW9yZSBhY2N1cmF0ZT8NCg0KPiA+IFRoaXMgaXNzdWUgd2FzIG9ic2Vy
dmVkIHNwZWNpZmljYWxseSBvbiBhbiBhcm02NCBzeXN0ZW0gd2l0aCBhIEdJQy12Mw0KPiA+IGhh
bmRsaW5nIE1TSXM7IEdJQy12MyB1c2VzIHRoZSBoYW5kbGVfZmFzdGVvaV9pcnEgaGFuZGxlci4g
VGhlIGlzc3VlIGlzDQo+ID4gdGhhdCB0aGUgZ2xvYmFsIElUUyBpcyByZXNwb25zaWJsZSBmb3Ig
YWZmaW5pdHkgYnV0IGRvZXMgbm90IGtub3cNCj4gPiB3aGV0aGVyIGludGVycnVwdHMgYXJlIHBl
bmRpbmcvcnVubmluZywgb25seSB0aGUgQ1BVLWxvY2FsIHJlZGlzdHJpYnV0b3INCj4gPiBoYW5k
bGVzIHRoZSBFT0kuIEhlbmNlIHdoZW4gdGhlIGFmZmluaXR5IGlzIGNoYW5nZWQgaW4gdGhlIElU
UywgdGhlIG5ldw0KPiA+IENQVSdzIHJlZGlzdHJpYnV0b3IgZG9lcyBub3Qga25vdyB0aGF0IHRo
ZSBvcmlnaW5hbCBDUFUgaXMgc3RpbGwgcnVubmluZw0KPiA+IHRoZSBoYW5kbGVyLg0KPiANCj4g
U2ltaWxhciB0byB5b3VyIHByZXZpb3VzIHBhdGNoLCB5b3UgZG9uJ3QgZXhwbGFpbiAqd2h5KiB0
aGUgaW50ZXJydXB0DQo+IGdldHMgZGVsaXZlcmVkIHdoZW4gaXQgaXMgYW4gTFBJLCBhbmQgbm90
IGZvciBhbnkgb2YgdGhlIG90aGVyIEdJQ3YzDQo+IGludGVycnVwdCB0eXBlcy4gVGhhdCdzIGFu
IGltcG9ydGFudCBwb2ludC4NCg0KUmlnaHQsIHlvdSBwb2ludGVkIG91dCB0aGUgaXNzdWUgd2l0
aCB0aGlzIHNlbnRlbmNlIHRvbyBhbmQgSSBtaXNzZWQNCnVwZGF0aW5nIGl0LiA6LS8gSG93IGFi
b3V0Og0KDQoiVGhpcyBpc3N1ZSB3YXMgb2JzZXJ2ZWQgc3BlY2lmaWNhbGx5IG9uIGFuIGFybTY0
IHN5c3RlbSB3aXRoIGEgR0lDLXYzDQpoYW5kbGluZyBNU0lzOyBHSUMtdjMgdXNlcyB0aGUgaGFu
ZGxlX2Zhc3Rlb2lfaXJxIGhhbmRsZXIuIFRoZSBpc3N1ZSBpcw0KdGhhdCB0aGUgR0lDLXYzJ3Mg
cGh5c2ljYWwgTFBJcyBkbyBub3QgaGF2ZSBhIGdsb2JhbCBhY3RpdmUgc3RhdGUuIElmIExQSXMN
CmhhZCBhbiBhY3RpdmUgc3RhdGUsIHRoZW4gaXQgd291bGQgbm90IGJlIGJlIGFibGUgdG8gYmUg
cmV0cmlnZ2VyZWQgdW50aWwNCnRoZSBmaXJzdCBDUFUgaGFkIGlzc3VlZCBhIGRlYWN0aXZhdGlv
biINCg0KPiANCj4gPiANCj4gPiArICAgICAvKg0KPiA+ICsgICAgICAqIFdoZW4gdGhlIHJhY2Ug
ZGVzY2liZWQgYWJvdmUgaGFwcGVucywgdGhpcyB3aWxsIHJlc2VuZCB0aGUgaW50ZXJydXB0Lg0K
PiA+ICsgICAgICAqLw0KPiA+ICsgICAgIGlmICh1bmxpa2VseShkZXNjLT5pc3RhdGUgJiBJUlFT
X1BFTkRJTkcpKQ0KPiA+ICsgICAgICAgICAgICAgY2hlY2tfaXJxX3Jlc2VuZChkZXNjLCBmYWxz
ZSk7DQo+ID4gKw0KPiA+ICAgICAgIHJhd19zcGluX3VubG9jaygmZGVzYy0+bG9jayk7DQo+ID4g
ICAgICAgcmV0dXJuOw0KPiA+ICBvdXQ6DQo+IA0KPiBXaGlsZSBJJ20gZ2xhZCB0aGF0IHlvdSBl
dmVudHVhbGx5IGRlY2lkZWQgdG8gdXNlIHRoZSByZXNlbmQgbWVjaGFuaXNtDQo+IGluc3RlYWQg
b2Ygc3Bpbm5pbmcgb24gdGhlICJvbGQiIENQVSwgSSBzdGlsbCB0aGluayBpbXBvc2luZyB0aGlz
DQo+IGJlaGF2aW91ciBvbiBhbGwgdXNlcnMgd2l0aG91dCBhbnkgZGlzY3JpbWluYXRpb24gaXMg
d3JvbmcuDQo+IA0KPiBMb29rIGF0IHdoYXQgaXQgZG9lcyBpZiBhbiBpbnRlcnJ1cHQgaXMgYSB3
YWtlLXVwIHNvdXJjZS4gWW91J2QNCj4gcG9pbnRsZXNzbHkgcmVxdWV1ZSB0aGUgaW50ZXJydXB0
IChib251cyBwb2ludHMgaWYgdGhlIGlycWNoaXAgZG9lc24ndA0KPiBwcm92aWRlIGEgSFctYmFz
ZWQgcmV0cmlnZ2VyIG1lY2hhbmlzbSkuDQo+IA0KPiBJIHN0aWxsIG1haW50YWluIHRoYXQgdGhp
cyBjaGFuZ2Ugc2hvdWxkIG9ubHkgYmUgYXBwbGllZCBmb3IgdGhlDQo+IHBhcnRpY3VsYXIgaW50
ZXJydXB0cyB0aGF0ICpyZXF1aXJlKiBpdCwgYW5kIG5vdCBhcyBhIGJsYW5rZXQgY2hhbmdlDQo+
IGFmZmVjdGluZyBldmVyeXRoaW5nIHVuZGVyIHRoZSBzdW4uIEkgaGF2ZSBwcm9wb3NlZCBzdWNo
IGEgY2hhbmdlIGluDQo+IHRoZSBwYXN0LCBmZWVsIGZyZWUgdG8gdXNlIGl0IG9yIHJvbGwgeW91
ciBvd24uDQoNClRoYW5rcyBmb3IgdGhlIGV4YW1wbGUgb2Ygd2hlcmUgdGhpcyBibGFua2V0IGZ1
bmN0aW9uYWxpdHkgd291bGRuJ3QgYmUNCmRlc2lyZWQgLSBJJ2xsIHJlLXdvcmsgdGhpcyB0byBp
bnRyb2R1Y2UgYW5kIHVzZQ0KdGhlIElSUURfUkVTRU5EX1dIRU5fSU5fUFJPR1JFU1MgZmxhZyBh
cyB5b3Ugb3JpZ2luYWxseSBzdWdnZXN0ZWQuDQoNCkp1c3Qgb25lIG1vcmUgdGhpbmcgYmVmb3Jl
IEkgcG9zdCBWMzogYXJlIHlvdSBva2F5IHdpdGggZG9pbmcgdGhlIHJlc2VuZA0KaGVyZSAqYWZ0
ZXIqIHRoZSBoYW5kbGVyIGZpbmlzaGVkIHJ1bm5pbmcsIGFuZCB1c2luZyB0aGUgSVJRX1BFTkRJ
TkcgZmxhZw0KdG8ga25vdyB0byByZXNlbmQgaXQ/IE9yIHdvdWxkIHlvdSBsaWtlIGl0IHRvIGJl
IHJlc2VudCBpbg0KdGhlICFpcnFfbWF5X3J1bihkZXNjKSBibG9jayBhcyB5b3Ugc3VnZ2VzdGVk
Pw0KDQpJIGhhdmUgYSBzbGlnaHQgcHJlZmVyZW5jZSB0byBkbyBpdCBhZnRlciwgb25seSB3aGVu
IHdlIGtub3cgaXQncyByZWFkeSB0bw0KYmUgcnVuIGFnYWluLCBhbmQgaGVuY2Ugbm90IG5lZWRl
ZCB0byBtb2RpZnkgY2hlY2tfaXJxX3Jlc2VuZCgpIHRvIGNhdGVyDQpmb3IgbXVsdGlwbGUgcmV0
cmllcy4NCg0KSkcNCg==
