Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87797716FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjE3Vsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbjE3Vsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:48:41 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D64126
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685483293; x=1717019293;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CKJKXo9Q7B5q3cYhBlPCrsl21FnyugwOqNdIr3MU4kI=;
  b=FcwkUMUaHg16ezHq7Iy70MIszGK0QZgiVVCXaiTNGeAeruh2JPCv0G9D
   DWB8n+cv3pzGn2G/tKFBKxv0k9lsna86wrM/Iw9LUN/ccAsT4PjoHO8El
   fZ6YxAwKc6nn9QNpxvKpX2P7Okl/lPyGE4cTjbBscVcNbE+wmQvU9GlJr
   s=;
X-IronPort-AV: E=Sophos;i="6.00,205,1681171200"; 
   d="scan'208";a="330359848"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 21:48:00 +0000
Received: from EX19D002EUC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com (Postfix) with ESMTPS id 57BB244023;
        Tue, 30 May 2023 21:47:58 +0000 (UTC)
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D002EUC001.ant.amazon.com (10.252.51.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 May 2023 21:47:57 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.026; Tue, 30 May 2023 21:47:57 +0000
From:   "Gowans, James" <jgowans@amazon.com>
To:     "maz@kernel.org" <maz@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "liaochang1@huawei.com" <liaochang1@huawei.com>
CC:     "zouyipeng@huawei.com" <zouyipeng@huawei.com>,
        "Raslan, KarimAllah" <karahmed@amazon.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sironi, Filippo" <sironi@amazon.de>,
        "chris.zjh@huawei.com" <chris.zjh@huawei.com>
Subject: Re: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
Thread-Topic: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
Thread-Index: AQHZk0Bl2dXW3nwmw02O2ZkI/WN+cQ==
Date:   Tue, 30 May 2023 21:47:57 +0000
Message-ID: <f9cb8c3f546cf9aa6422e478ec56422b92264c8c.camel@amazon.com>
References: <20230317095300.4076497-1-jgowans@amazon.com>
         <87h6tp5lkt.wl-maz@kernel.org>
         <0869847124f982c50d0f8d0ede996004f90a5576.camel@amazon.com>
         <86pm89kyyt.wl-maz@kernel.org>
         <7fdfb01590d8e502f384aa0bb0dc9c614caa5dfc.camel@amazon.com>
         <5a1fb95b57efbd6b6c2cea4a4e3ae5407fadeeb9.camel@amazon.com>
         <91902b8c-c854-c498-e5d0-2d959bd08637@huawei.com>
         <7de1c7f0c9ff4a84b3cc3fa15ee39596c08b665f.camel@amazon.com>
         <516b8316-fba9-f3d9-2b3a-2536bd747a69@huawei.com>
In-Reply-To: <516b8316-fba9-f3d9-2b3a-2536bd747a69@huawei.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.226]
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED5B52CC07D0DC4BAF680E777CC1AC48@amazon.com>
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

T24gTW9uLCAyMDIzLTA1LTI5IGF0IDEwOjQ3ICswODAwLCBMaWFvLCBDaGFuZyB3cm90ZToNCj4g
DQo+ID4gDQo+ID4gV29yZGluZyBtYXkgbmVlZCBhIHNsaWdodCB0d2VhaywgZXNwZWNpYWxseSBw
b2ludGluZyBvdXQgd2h5IFBFTkRJTkcgaXMNCj4gPiBzZXQuDQo+IA0KPiBTdXJlLCBzZWUgdGhl
IGNvbW1lbnQgYmVsb3c6DQo+IA0KPiAiQWNrIGFub3RoZXIgaW50ZXJydXB0IGZyb20gdGhlIHNh
bWUgc291cmNlIGNhbiBvY2N1cnMgb24gbmV3IENQVSBldmVuIGJlZm9yZQ0KPiB0aGUgZmlyc3Qg
b25lIGlzIGhhbmRsZWQgb24gb3JpZ2luYWwgQ1BVLCBJUlFTX1BFTkRJTkcgYml0IGNhbiBiZSBy
ZXVzZWQgdG8NCj4gaW5kaWNhdGUgdGhpcyBzaXR1YXRpb24sIHdoaWNoIHdpbGwgZGVmZXIgdGhl
IGV4ZWN1dGlvbiBvZiB0aGUgaW50ZXJydXB0IGhhbmRsZXINCj4gZnVuY3Rpb24gYXNzb2NpYXRl
ZCB3aXRoIHRoZSBpcnFfZGVzYyB1bnRpbCB0aGUgZmlyc3QgaW50ZXJydXB0IGhhbmRsZXIgcmV0
dXJucy4iDQo+IA0KPiBJbiBzdW1tYXJ5LCB0aGUgSVJRX1BFTkRJTkdTIGVuc3VyZXMgdGhhdCBv
bmx5IG9uZSBpbnRlcnJ1cHQgaGFuZGxlciBpcyBldmVyDQo+IHJ1bm5pbmcgZm9yIGEgcGFydGlj
dWxhciBzb3VyY2UgYXQgYSB0aW1lLCBhbmQgdGhlIG1ham9yIHVzYWdlcyBvZiBJUlFTX1BFTkRJ
TkcNCj4gaW4ga2VybmVsIGFzIGZvbGxvd3M6DQo+IA0KPiAxLiBVc2VkIGluIGlycSBmbG93IGhh
bmRsZXIgdG8gaW5kaWNhdGUgdGhhdCBhbiBhY2tub3dsZWRnZWQgaW50ZXJydXB0IGNhbm5vdCBi
ZQ0KPiBoYW5kbGVkIGltbWVkaWF0ZWx5IGR1ZSB0byB0aHJlZSBkaWZmZXJlbnQgcmVhc29uczoN
Cj4gLSBDYXNlMTogdGhlIGludGVycnVwdCBoYW5kbGVyIGZ1bmN0aW9uIGhhcyBiZWVuIHVucmVn
aXN0ZXJlZCB2aWEgZnJlZV9pcnEoKS4NCj4gLSBDYXNlMjogdGhlIGludGVycnVwdCBoYXMgYmVl
biBkaXNhYmxlZCB2aWEgaXJxX2Rpc2FibGUoKS4NCj4gLSBDYXNlMzogdGhlIGludGVycnVwdCBp
cyBhbiBlZGdlLXRyaWdnZXJlZCBpbnRlcnJ1cHQgYW5kIGl0cyBoYW5kbGVyIGlzIGFscmVhZHkN
Cj4gICAgICAgICAgcnVubmluZyBvbiB0aGUgQ1BVLg0KPiANCj4gSW4gYW55IG9mIHRoZXNlIGNh
c2VzLCB0aGUga2VybmVsIHdpbGwgZGVmZXIgdGhlIGV4ZWN1dGlvbiBvZiB0aGUgaW50ZXJydXB0
IGhhbmRsZXINCj4gdW50aWwgdGhlIGludGVycnVwdCBpcyBlbmFibGVkIGFuZCBuZXcgaGFuZGxl
ciBpcyBlc3RhYmxpc2hlZCBhZ2FpbiB2aWEgY2hlY2tfaXJxX3Jlc2VuZCgpLA0KPiBvciB2aWEg
dGhlIGluc2lkZSBsb29wIGluIGhhbmRsZV9lZGdlX2lycSgpIHVwb24gdGhlIHByZXZpb3VzIGhh
bmRsZXIgcmV0dXJucy4NCj4gDQo+IDIuIFVzZWQgaW4gdGhlIHNwdXJpb3VzIGludGVycnVwdCBk
ZXRlY3RvciwgYSBmZXcgc3lzdGVtcyB3aXRoIG1pc2Rlc2NyaWJlZCBJUlENCj4gcm91dGluZyBj
YW4gY2F1c2UgYW4gaW50ZXJydXB0IHRvIGJlIGhhbmRsZWQgb24gdGhlIHdyb25nIENQVS4gSW4g
dGhpcyBzaXR1YXRpb24sDQo+IHRoZSBzcHVyaW91cyBpbnRlcnJ1cHQgZGV0ZWN0b3Igc2VhcmNo
ZXMgZm9yIGEgcmVjb3ZlcnkgaGFuZGxlciBmb3IgdGhlIGludGVycnVwdC4NCj4gSWYgdGhlIGZv
dW5kIGhhbmRsZXIgaXMgcnVubmluZyBvbiBhbm90aGVyIENQVSwgdGhlIHNwdXJpb3VzIGludGVy
cnVwdCBkZXRlY3Rvcg0KPiBhbHNvIGRlZmVycyB0aGUgZXhlY3V0aW9uIG9mIHRoZSByZWNvdmVy
eSBoYW5kbGVyLCBzaW1pbGFyIHRvIGNhc2UgMyBpbiAjMS4NCj4gDQo+IEkgaG9wZSB0aGlzIGlz
IGhlbHBmdWwuDQoNClN0dW5uaW5nISBJIHRyaWVkIHRvIHBpbGxhZ2Ugc29tZSBvZiB0aGlzIGZv
ciB0aGUgY29tbWl0IG1lc3NhZ2UsIGJ1dCBJDQp0aGluayBpdCB3YXMgdG9vIG11Y2ggZGV0YWls
IGZvciB0aGlzIGNvbW1pdCBtZXNzYWdlIC0gaXQgcHJvYmFibHkgYmVsb25ncw0KaW4gYSBkb2Mg
b3IgY29kZSBjb21tZW50IHNvbWV3aGVyZSB0aG91Z2guIFVzZWZ1bCENCg0KPiA+IElmIHlvdSB3
YW50IEknbSBoYXBweSB0byBtYWtlIHRoZXNlIHR3ZWFrcyBhbmQgcG9zdCBhcyBWMj8NCj4gPiBU
aGVyZSBhcmUgYWxzbyBzb21lIG90aGVyIGNvbW1lbnRzIEknbSBrZWVuIHRvIGFkZCB0byB0aGUg
ZmxhZyBlbnVtcyB0bw0KPiA+IG1ha2UgaXQgYSBiaXQgY2xlYXJlciB3aGF0IHNvbWUgb2YgdGhl
IGZsYWdzIG1lYW4uDQo+IA0KPiBEb24ndCBzZWUgd2h5IG5vdCA6KQ0KDQpEb25lLCBWMjogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDUzMDIxMzg0OC4zMjczMDA2LTItamdvd2Fu
c0BhbWF6b24uY29tLw0KDQpKRw0K
