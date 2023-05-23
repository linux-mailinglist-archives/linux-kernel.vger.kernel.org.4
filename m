Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E859B70DBE2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbjEWL76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbjEWL74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:59:56 -0400
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6833218B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1684843190; x=1716379190;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rfBrXyd80so5rkF5O7e482EyNrJaA/hWhH0YiJqU49A=;
  b=t6Ewvh8wRSREt4DM1wV6fqN502uIVWlyRio2z8p7D3L9HQMq9yXLZtNE
   I9QYcYbAdzGw708nylfpopJy0E5rbcXxYh1s4+RlXMq1mLA/hl1tnSeN9
   h5PxoauTCaairLVcfpCUuM2ytiUaqC7T+/JfX3JbUHFIRPnJfwsan7Vtr
   w=;
X-IronPort-AV: E=Sophos;i="6.00,186,1681171200"; 
   d="scan'208";a="5179486"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 11:59:45 +0000
Received: from EX19D001EUA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id D5DEC40D60;
        Tue, 23 May 2023 11:59:44 +0000 (UTC)
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D001EUA002.ant.amazon.com (10.252.50.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 23 May 2023 11:59:43 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.026; Tue, 23 May 2023 11:59:43 +0000
From:   "Gowans, James" <jgowans@amazon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "liaochang1@huawei.com" <liaochang1@huawei.com>
CC:     "zouyipeng@huawei.com" <zouyipeng@huawei.com>,
        "Raslan, KarimAllah" <karahmed@amazon.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chris.zjh@huawei.com" <chris.zjh@huawei.com>
Subject: Re: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
Thread-Topic: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
Thread-Index: AQHZjW4PGSq2s7RWTU6XG/HcCpVCNg==
Date:   Tue, 23 May 2023 11:59:43 +0000
Message-ID: <efe052679277adf38f0b843420fec7657ed3dc37.camel@amazon.com>
References: <20230317095300.4076497-1-jgowans@amazon.com>
         <a2f82321-8bca-d773-b83e-a71c1f455e40@huawei.com>
In-Reply-To: <a2f82321-8bca-d773-b83e-a71c1f455e40@huawei.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.31.190.53]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B1FF1C031B4494E9EF5B30CAE0E321D@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA1LTIzIGF0IDExOjE1ICswODAwLCBsaWFvY2hhbmcgKEEpIHdyb3RlOg0K
PiA+IDEuIERvIHdlIG5lZWQgdG8gbWFzayB0aGUgSVJRIGFuZCB0aGVuIHVubWFzayBpdCBsYXRl
cj8gSSBkb24ndCB0aGluayBzbw0KPiA+IGJ1dCBpdCdzIG5vdCBlbnRpcmVseSBjbGVhciB3aHkg
aGFuZGxlX2VkZ2VfaXJxIGRvZXMgdGhpcyBhbnl3YXk7IGl0J3MNCj4gPiBhbiBlZGdlIElSUSBz
byBub3Qgc3VyZSB3aHkgaXQgbmVlZHMgdG8gYmUgbWFza2VkLg0KPiANCj4gDQo+IEluIHRoZSBH
SUMgYXJjaGl0ZWN0dXJlLCBhIENQVSB0aGF0IGlzIGhhbmRsaW5nIGFuIElSUSBjYW5ub3QgYmUg
c2lnbmFsZWQNCj4gd2l0aCBhIG5ldyBpbnRlcnJ1cHQgdW50aWwgaXQgc2F0aXNmaWVzIHRoZSBp
bnRlcnJ1cHQgcHJlZW1wdGlvbiByZXF1aXJlbWVudHMNCj4gZGVmaW5lZCBpbiB0aGUgR0lDIGFy
Y2hpdGVjdHVyZS4gT25lIG9mIHRoZXNlIHJlcXVpcmVtZW50cyBpcyB0aGF0IHRoZQ0KPiBwcmlv
cml0eSBvZiB0aGUgbmV3IHBlbmRpbmcgaW50ZXJydXB0IGlzIGhpZ2hlciB0aGFuIHRoZSBwcmlv
cml0eSBvZiB0aGUNCj4gY3VycmVudCBydW5uaW5nIGludGVycnVwdC4gT2J2aW91c2x5LCB0aGUg
c2FtZSBpbnRlcnJ1cHQgc291cmNlIGNhbm5vdA0KPiBwcmVlbXB0IGl0c2VsZi4gQWRkaXRpb25h
bGx5LCBpbnRlcnJ1cHQgcHJpb3JpdHkgaXMgcmFyZWx5IGVuYWJsZWQgaW4NCj4gdGhlIExpbnV4
IGtlcm5lbCxleGNlcHQgZm9yIHRoZSBQRVNVRE9fTk1JLg0KPiANCj4gSWYgdGhlIGludGVycnVw
dCBpcyBhbiBMUEksIGFuZCBpbnRlcnJ1cHQgaGFuZGxpbmcgaXMgc3RpbGwgaW4gcHJvZ3Jlc3Mg
b24NCj4gdGhlIG9yaWdpbmFsIENQVSwgdGhlIGxhY2sgb2YgdGhlIEFDSVRWRSBzdGF0ZSBtZWFu
cyB0aGF0IHRoZSBMUEkgY2FuIGJlDQo+IGRpc3RyaWJ1dGVkIHRvIGFub3RoZXIgQ1BVIG9uY2Ug
aXRzIGFmZmluaXR5IGhhcyBiZWVuIGNoYW5nZWQuIE9uIHRoZSBvdGhlcg0KPiBoYW5kLCBzaW5j
ZSB0aGUgZGVzYy0+aXN0YXRlIGlzIG1hcmtlZCBJUlFTX1BFTkRJTkcgYW5kIHRoaXMgaW50ZXJy
dXB0IGhhcw0KPiBiZWVuIGNvbnN1bWVkIG9uIHRoZSBuZXcgQ1BVLCB0aGVyZSBpcyBubyBuZWVk
IHRvIG1hc2sgaXQgYW5kIHRoZW4gdW5tYXNrIGl0IGxhdGVyLg0KDQpUaGFua3MsIHRoaXMgbWFr
ZXMgc2Vuc2UgdG8gbWUgYW5kIG1hdGNoZXMgbXkgdW5kZXJzdGFuZGluZy4gV2hhdCBJIHdhcw0K
YWN0dWFsbHkgdW5zdXJlIGFib3V0IHdhcyB3aHkgaGFuZGxlX2VkZ2VfaXJxKCkgKmRvZXMqIGRv
IHRoZSBtYXNraW5nLiBJDQpndWVzcyBpdCdzIGJlY2F1c2UgaGFuZGxlX2VkZ2VfaXJxKCkgcnVu
cyBkZXNjLT5pcnFfZGF0YS5jaGlwLT5pcnFfYWNrKCksDQphbmQgcGVyaGFwcyBpZiB0aGF0IGlz
bid0IHJ1biAoaW4gdGhlIGNvbmN1cnJlbnQgaW52b2tlIGNhc2UpIHRoZW4gdGhlIElSUQ0Kd2ls
bCBrZWVwIGdldHRpbmcgcmUtdHJpZ2dlcmVkPyBXaWxkIHNwZWN1bGF0aW9uLiA6LSkNCg0KPiA+
IDIuIFNob3VsZCB0aGUgRU9JIGRlbGl2ZXJ5IGJlIGluc2lkZSB0aGUgZG8gbG9vcCBhZnRlciBl
dmVyeSBoYW5kbGVyDQo+ID4gcnVuPyBJIHRoaW5rIG91dHNpZGUgdGhlIGxvb3BzIGlzIGJlc3Q7
IG9ubHkgaW5mb3JtIHRoZSBjaGlwIHRvIGRlbGl2ZXINCj4gPiBtb3JlIElSUXMgb25jZSBhbGwg
cGVuZGluZyBydW5zIGhhdmUgYmVlbiBmaW5pc2hlZC4NCj4gDQo+IFRoZSBHSUMgYXJjaGl0ZWN0
dXJlIHJlcXVpcmVzIHRoYXQgd3JpdGVzIHRvIHRoZSBFT0kgcmVnaXN0ZXIgYmUgaW4gdGhlIGV4
YWN0DQo+IHJldmVyc2Ugb3JkZXIgb2YgcmVhZHMgZnJvbSB0aGUgSUFSIHJlZ2lzdGVyLiBUaGVy
ZWZvcmUsIElBUiBhbmQgRU9JIG11c3QgYmUgcGFpcmVkLg0KPiBXcml0aW5nIEVPSSBpbnNpZGUg
dGhlIGRvIGxvb3AgYWZ0ZXIgZXZlcnkgaGFuZGxlciBtYXkgY2F1c2Ugc3VidGxlIHByb2JsZW1z
Lg0KPiANCkFoIGhhISAod2hlcmUgaXMgdGhpcyBkb2N1bWVudGVkLCBidHc/KSBBbmQgYmVjYXVz
ZSB0aGUgSUFSIHJlYWQgaGFwcGVucw0KcmVhbGx5IGVhcmx5IGluIChmb3IgZXhhbXBsZSkgX19n
aWNfaGFuZGxlX2lycV9mcm9tX2lycXNvbigpIGl0IG9ubHkgbWFrZXMNCnNlbnNlIHRvIGNhbGwg
RU9JIG9uY2Ugd2hlbiByZXR1cm5pbmcgZnJvbSB0aGUgaW50ZXJydXB0IGNvbnRleHQuIFRoYXQN
CmFsc28gbWVhbnMgdGhhdCBpbiB0aGUgY29uY3VycmVudCBpbnZva2UgY2FzZSB3ZSB3b3VsZCBu
ZWVkIHRvIHJ1biBFT0kNCmV2ZW4gaWYgdGhlIGhhbmRsZXIgd2FzIG5vdCBpbnZva2VkLg0KDQo+
ID4gMy4gRG8gd2UgbmVlZCB0byBjaGVjayB0aGF0IGRlc2MtPmFjdGlvbiBpcyBzdGlsbCBzZXQ/
IEkgZG9uJ3Qga25vdyBpZg0KPiA+IGl0IGNhbiBiZSB1bi1zZXQgd2hpbGUgdGhlIElSUSBpcyBz
dGlsbCBlbmFibGVkLg0KPiANCj4gVGhpcyBjaGVjayBpcyBuZWNlc3NhcnkgaGVyZS4gV2hlbiB0
aGUgY29kZSBlbnRlcnMgdGhpcyBjcml0aWNhbCBzZWN0aW9uLCB0aGUga2VybmVsDQo+IHJ1bm5p
bmcgb24gYW5vdGhlciBDUFUgbWlnaHQgaGF2ZSBhbHJlYWR5IHVucmVnaXN0ZXJlZCB0aGUgSVJR
IGFjdGlvbiB2aWEgdGhlIGZyZWVfaXJxIEFQSS4NCj4gQWx0aG91Z2ggZnJlZV9pcnEgaXMgdHlw
aWNhbGx5IHVzZWQgaW4gY29kZSBwYXRocyBjYWxsZWQgb24gbW9kdWxlIHVubG9hZCBvciBleGNl
cHRpb24NCj4gaGFuZGxpbmcsIHdlIGhhdmUgYWxzbyBvYnNlcnZlZCB0aGF0IHZpcnR1YWxpemF0
aW9uIHVzaW5nIFZGSU8gYXMgYSBQQ0kgYmFja2VuZA0KPiBmcmVxdWVudGx5IGludGVuZHMgdG8g
dXNlIGZyZWVfaXJxIGluIHNvbWUgcmVndWxhciBjb2RlIHBhdGhzLg0KPiANCg0KT2theSwgSSdt
IGEgYml0IGhhenkgb24gd2hldGhlciBpdCBpcyBvciBzaG91bGQgYmUgcG9zc2libGUgdG8gdW5y
ZWdpc3Rlcg0KdGhlIElSUSBhY3Rpb24gd2hpbGUgdGhlIGhhbmRsZXIgaXMgc3RpbGwgcnVubmlu
ZyAtIGl0IHNvdW5kcyBsaWtlIHlvdSdyZQ0Kc2F5aW5nIHRoaXMgaXMgcG9zc2libGUgYW5kIHNh
ZmUuIE1vcmUgY29kZSBzcGVsdW5raW5nIHdvdWxkIGJlIG5lY2Vzc2FyeQ0KdG8gdmVyaWZ5IHRo
aXMgYnV0IEkgd29uJ3QgYm90aGVyIHNlZWluZyBhcyBpdCBsb29rcyBsaWtlIHRoZSBzb2x1dGlv
bg0Kd2UncmUgdGVuZGluZyB0b3dhcmRzIHVzZXMgY2hlY2tfaXJxX3Jlc2VuZCgpLCBpbnN0ZWFk
IG9mIGludm9raW5nIHRoZQ0KaGFuZGxlciBkaXJlY3RseS4NCg0KSkcNCg==
