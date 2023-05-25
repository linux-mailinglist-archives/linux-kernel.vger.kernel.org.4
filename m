Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F66071096B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbjEYKFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240453AbjEYKEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:04:53 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681A110B
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685009092; x=1716545092;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zpHliPzfyrtdrkom+qKYRF9CWVoivhVYLH3DRnXrI/I=;
  b=JduQLcakZ9bNbgAcYYS2d+8uEJi2cUjial+VFuDJXN3YC1CqG4DySmXG
   X0O/peNtuuS4/K6OQlibHXY+/HoCEAvj88ZBtZVyOqj5Afj5GtcSP7Bcr
   0q6hVVKGYjfu7+K/oDlyjB2PbCntxWRZzttyI1lDl1NUKK4ueecaYPQvJ
   8=;
X-IronPort-AV: E=Sophos;i="6.00,190,1681171200"; 
   d="scan'208";a="216537792"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 10:04:48 +0000
Received: from EX19D002EUC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com (Postfix) with ESMTPS id 7916B8035F;
        Thu, 25 May 2023 10:04:46 +0000 (UTC)
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D002EUC002.ant.amazon.com (10.252.51.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 May 2023 10:04:45 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.026; Thu, 25 May 2023 10:04:45 +0000
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
Thread-Index: AQHZjvBURRRDOxXal02o2yYRnZTOjA==
Date:   Thu, 25 May 2023 10:04:45 +0000
Message-ID: <7de1c7f0c9ff4a84b3cc3fa15ee39596c08b665f.camel@amazon.com>
References: <20230317095300.4076497-1-jgowans@amazon.com>
         <87h6tp5lkt.wl-maz@kernel.org>
         <0869847124f982c50d0f8d0ede996004f90a5576.camel@amazon.com>
         <86pm89kyyt.wl-maz@kernel.org>
         <7fdfb01590d8e502f384aa0bb0dc9c614caa5dfc.camel@amazon.com>
         <5a1fb95b57efbd6b6c2cea4a4e3ae5407fadeeb9.camel@amazon.com>
         <91902b8c-c854-c498-e5d0-2d959bd08637@huawei.com>
In-Reply-To: <91902b8c-c854-c498-e5d0-2d959bd08637@huawei.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.226]
Content-Type: text/plain; charset="utf-8"
Content-ID: <55705CAD1611944DA2968E16032EF818@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA1LTIzIGF0IDExOjE2ICswODAwLCBsaWFvY2hhbmcgKEEpIHdyb3RlOg0K
PiBIaSwgSmFtZXMgYW5kIE1hcmMsDQo+IA0KPiBBZnRlciBzdHVkeWluZyB5b3VyIGRpc2N1c3Np
b25zLCBJIGxpc3Qgc29tZSByZXF1aXJlbWVudHMgbmVlZCB0byBzYXRpZnkgZm9yDQo+IHRoZSBm
aW5hbCBwcmFjdGljYWwgc29sdXRpb246DQo+IA0KPiAxLiBVc2UgdGhlIEdJQyB0byBtYWludGFp
biB0aGUgdW5oYW5kbGVkIExQSS4NCj4gMi4gRG8gbm90IGNoYW5nZSB0aGUgc2VtYW50aWNzIG9m
IHNldF9pcnFfYWZmaW5pdHksIHdoaWNoIG1lYW5zIHRoYXQgdGhlIGludGVycnVwdA0KPiAgICBh
Y3Rpb24gbXVzdCBiZSBwZXJmb3JtZWQgb24gdGhlIG5ldyBDUFUgd2hlbiB0aGUgbmV4dCBpbnRl
cnJ1cHQgb2NjdXJzIGFmdGVyIGENCj4gICAgc3VjY2Vzc2Z1bCBzZXRfaXJxX2FmZmluaXR5IG9w
ZXJhdGlvbi4NCj4gMy4gTWluaW1pemUgdGhlIGNvc3QsIGVzcGVjaWFsbHkgdG8gb3RoZXIgdGFz
a3MgcnVubmluZyBvbiBDUFVzLCB3aGljaCBtZWFucyBhdm9pZA0KPiAgICBhIGRvL3doaWxlIGxv
b3Agb24gdGhlIG9yaWdpbmFsIENQVSBhbmQgcmVwZWF0ZWRseSByZXNlbmQgaW50ZXJydXB0IG9u
IHRoZSBuZXcgQ1BVLg0KDQpTZWVtcyByZWFzb25hYmxlIHRvIG1lLg0KPiANCj4gQmFzZWQgb24g
dGhlc2UgcmVxdWlyZW1lbnRzIGFuZCBMaW51eCB2Ni4zIHJldiwgSSBwcm9wb3NlIHRoZSBmb2xs
b3dpbmcgaGFjazoNCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvaXJxL2NoaXAuYyBiL2tlcm5l
bC9pcnEvY2hpcC5jDQo+IGluZGV4IDQ5ZTdiYzg3MWZlYy4uMWI0OTUxOGIxOWJkIDEwMDY0NA0K
PiAtLS0gYS9rZXJuZWwvaXJxL2NoaXAuYw0KPiArKysgYi9rZXJuZWwvaXJxL2NoaXAuYw0KPiBA
QCAtNjkyLDggKzY5MiwxNCBAQCB2b2lkIGhhbmRsZV9mYXN0ZW9pX2lycShzdHJ1Y3QgaXJxX2Rl
c2MgKmRlc2MpDQo+IA0KPiAgICAgICAgIHJhd19zcGluX2xvY2soJmRlc2MtPmxvY2spOw0KPiAN
Cj4gLSAgICAgICBpZiAoIWlycV9tYXlfcnVuKGRlc2MpKQ0KPiArICAgICAgIC8qDQo+ICsgICAg
ICAgICogQWNrIGFub3RoZXIgaW50ZXJydXB0IGZyb20gdGhlIHNhbWUgc291cmNlIGNhbiBvY2N1
cnMgb24gbmV3DQo+ICsgICAgICAgICogQ1BVIGV2ZW4gYmVmb3JlIHRoZSBmaXJzdCBvbmUgaXMg
aGFuZGxlZCBvbiBvcmlnaW5hbCBDUFUuDQo+ICsgICAgICAgICovDQo+ICsgICAgICAgaWYgKCFp
cnFfbWF5X3J1bihkZXNjKSkgew0KPiArICAgICAgICAgICAgICAgZGVzYy0+aXN0YXRlIHw9IElS
UVNfUEVORElORzsNCj4gICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiArICAgICAgIH0NCg0K
V29yZGluZyBtYXkgbmVlZCBhIHNsaWdodCB0d2VhaywgZXNwZWNpYWxseSBwb2ludGluZyBvdXQg
d2h5IFBFTkRJTkcgaXMNCnNldC4NCj4gDQo+ICAgICAgICAgZGVzYy0+aXN0YXRlICY9IH4oSVJR
U19SRVBMQVkgfCBJUlFTX1dBSVRJTkcpOw0KPiANCj4gQEAgLTcxNSw2ICs3MjEsOCBAQCB2b2lk
IGhhbmRsZV9mYXN0ZW9pX2lycShzdHJ1Y3QgaXJxX2Rlc2MgKmRlc2MpDQo+IA0KPiAgICAgICAg
IGNvbmRfdW5tYXNrX2VvaV9pcnEoZGVzYywgY2hpcCk7DQo+IA0KPiArICAgICAgIGNoZWNrX2ly
cV9yZXNlbmQoZGVzYywgdHJ1ZSk7DQo+ICsNCg0KSSdtIHByZXR0eSBzdXJlIHRoZSBzZWNvbmQg
cGFyYW0sICJpbmplY3QiLCBtdXN0IG5vdCBiZSB0cnVlLiBBcyBpcyB0aGlzDQp3aWxsICphbHdh
eXMqIHJlc2VuZCB0aGUgaW50ZXJydXB0IGFmdGVyIGV2ZXJ5IGludGVycnVwdC4gSW5maW5pdGUN
CmludGVycnVwdCBsb29wISAoZGlkIHlvdSB0ZXN0IHRoaXM/KQ0KSSd2ZSBjaGFuZ2VkIGl0IHRv
IGZhbHNlIGFuZCB0ZXN0ZWQsIHNlZW1zIGdvb2QgdG8gbWUuDQoNCkknZCBzdWdnZXN0IGFkZGlu
ZyBhIGNvbW1lbnQgaGVyZSB3aGljaCBwYWlycyB3aXRoIHRoZSBjb21tZW50IGFib3ZlDQpleHBs
YWluaW5nIHdoeSB0aGlzIGlzIGJlaW5nIGNhbGxlZCBoZXJlLiBBbHNvIHBlcmhhcHMgYWRkaW5n
Og0KaWYgKHVubGlrZWx5KChkZXNjLT5pc3RhdGUgJiBJUlFTX1BFTkRJTkcpKQ0KLi4uc28gdGhh
dCBpbiBnZW5lcmFsIHRoaXMgZnVuY3Rpb24gY2FsbCB3aWxsIGJlIHNraXBwZWQgb3Zlci4NCg0K
SWYgeW91IHdhbnQgSSdtIGhhcHB5IHRvIG1ha2UgdGhlc2UgdHdlYWtzIGFuZCBwb3N0IGFzIFYy
Pw0KVGhlcmUgYXJlIGFsc28gc29tZSBvdGhlciBjb21tZW50cyBJJ20ga2VlbiB0byBhZGQgdG8g
dGhlIGZsYWcgZW51bXMgdG8NCm1ha2UgaXQgYSBiaXQgY2xlYXJlciB3aGF0IHNvbWUgb2YgdGhl
IGZsYWdzIG1lYW4uDQoNCk1hcmMsIHdoYXQgYXJlIHlvdXIgdGhvdWdodHMgb24gdGhpcyBhcHBy
b2FjaD8NClRoZSBtYWluIChvbmx5PykgZG93bnNpZGUgSSBzZWUgY29tcGFyZWQgdG8geW91ciBz
dWdnZXN0aW9uIGlzIHRoYXQgaW4gdGhlDQppcnFfc3dfcmVzZW5kKCkgY2FzZSB0aGUgdGFza2xl
dCB3aWxsIGJlIHNjaGVkdWxlZCBvbiB0aGUgb3JpZ2luYWwgQ1BVLiBBcw0KeW91IG1lbnRpb25l
ZCBpbiBhIHByZXZpb3VzIHJlcGx5LCBwZXJoYXBzIHdlIHNob3VsZG4ndCBib3RoZXIgdGhpbmtp
bmcNCmFib3V0IHRoZSBzd19yZXNlbmQgY2FzZSBub3cgYXMgb25seSBHSUMgaXMgaW1wYWN0ZWQu
IEluIGZ1dHVyZSBpZg0KbmVjZXNzYXJ5IHRoZSBzd19yZXNlbmQgaW1wbGVtZW50YXRpb24gY291
bGQgYmUgdHdlYWtlZCB0byBzY2hlZHVsZSB0aGUNCnRhc2tsZXQgb24gdGhlIENQVSB3aGljaCB0
aGUgaW50ZXJydXB0IGlzIGFmZmluZWQgdG8uDQoNCkpHDQoNCj4gICAgICAgICByYXdfc3Bpbl91
bmxvY2soJmRlc2MtPmxvY2spOw0KPiAgICAgICAgIHJldHVybjsNCj4gIG91dDoNCj4gDQo+IExv
b2tpbmcgZm9yd2FyZCB0byB5b3VyIGZlZWRiYWNrcywgdGhhbmtzLg0K
