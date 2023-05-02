Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBE66F3F64
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjEBInV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjEBInQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:43:16 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC8A49E1
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 01:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1683016993; x=1714552993;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kyDDJaTN85P4XK1OHPezyL8IqMOaIgXQfmWVToDak0o=;
  b=MUr5nzD1pdo7jS+4lDP0R+voOJgh6eFwPMsnSZ+W2ZbWDVra3AZjGQiS
   SbLXi90+p3iwbHgcuyZD3aMy72aX6dW1bVUEZck4rDjusTRGLDnF+rHkd
   jdaL8BpXzLW4W1FGkhtfrQzc3VF7nhz3yK0tDhwF7+jtu6SzahAdlsvOA
   Y=;
X-IronPort-AV: E=Sophos;i="5.99,243,1677542400"; 
   d="scan'208";a="281604225"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 08:43:05 +0000
Received: from EX19D002EUC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com (Postfix) with ESMTPS id B944E4148F;
        Tue,  2 May 2023 08:43:03 +0000 (UTC)
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D002EUC002.ant.amazon.com (10.252.51.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 2 May 2023 08:43:02 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.026; Tue, 2 May 2023 08:43:02 +0000
From:   "Gowans, James" <jgowans@amazon.com>
To:     "maz@kernel.org" <maz@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "zouyipeng@huawei.com" <zouyipeng@huawei.com>,
        "Raslan, KarimAllah" <karahmed@amazon.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sironi, Filippo" <sironi@amazon.de>,
        "chris.zjh@huawei.com" <chris.zjh@huawei.com>
Subject: Re: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
Thread-Topic: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
Thread-Index: AQHZceRg2u2D9PMEE0SrVnUWrsGPFK9GwGmA
Date:   Tue, 2 May 2023 08:43:02 +0000
Message-ID: <5a1fb95b57efbd6b6c2cea4a4e3ae5407fadeeb9.camel@amazon.com>
References: <20230317095300.4076497-1-jgowans@amazon.com>
         <87h6tp5lkt.wl-maz@kernel.org>
         <0869847124f982c50d0f8d0ede996004f90a5576.camel@amazon.com>
         <86pm89kyyt.wl-maz@kernel.org>
         <7fdfb01590d8e502f384aa0bb0dc9c614caa5dfc.camel@amazon.com>
In-Reply-To: <7fdfb01590d8e502f384aa0bb0dc9c614caa5dfc.camel@amazon.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.222]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A312737B5BAFC64F9B8136D81687A598@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYyBhbmQgVGhvbWFzLA0KDQpPbiBUdWUsIDIwMjMtMDQtMTggYXQgMTI6NTYgKzAyMDAs
IEphbWVzIEdvd2FucyB3cm90ZToNCj4gPiAgIHN0YXRpYyBpbmxpbmUgaXJxX2h3X251bWJlcl90
IGlycWRfdG9faHdpcnEoc3RydWN0IGlycV9kYXRhICpkKQ0KPiA+IGRpZmYgLS1naXQgYS9rZXJu
ZWwvaXJxL2NoaXAuYyBiL2tlcm5lbC9pcnEvY2hpcC5jDQo+ID4gaW5kZXggNDllN2JjODcxZmVj
Li43MzU0NmJhOGJjNDMgMTAwNjQ0DQo+ID4gLS0tIGEva2VybmVsL2lycS9jaGlwLmMNCj4gPiAr
KysgYi9rZXJuZWwvaXJxL2NoaXAuYw0KPiA+IEBAIC02OTIsOCArNjkyLDExIEBAIHZvaWQgaGFu
ZGxlX2Zhc3Rlb2lfaXJxKHN0cnVjdCBpcnFfZGVzYyAqZGVzYykNCj4gPiAgICAgICAgICByYXdf
c3Bpbl9sb2NrKCZkZXNjLT5sb2NrKTsNCj4gPiAtICAgICAgIGlmICghaXJxX21heV9ydW4oZGVz
YykpDQo+ID4gKyAgICAgICBpZiAoIWlycV9tYXlfcnVuKGRlc2MpKSB7DQo+ID4gKyAgICAgICAg
ICAgICAgIGlmIChpcnFkX25lZWRzX3Jlc2VuZF93aGVuX2luX3Byb2dyZXNzKCZkZXNjLT5pcnFf
ZGF0YSkpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY2hlY2tfaXJxX3Jlc2VuZChkZXNj
LCB0cnVlKTsNCj4gPiAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ICsgICAgICAgfQ0K
PiANCj4gDQo+IFRoaXMgd2lsbCBydW4gY2hlY2tfaXJxX3Jlc2VuZCgpIG9uIHRoZSAqbmV3bHkg
YWZmaW5lZCogQ1BVLCB3aGlsZSB0aGUgb2xkDQo+IG9uZSBpcyBzdGlsbCBydW5uaW5nIHRoZSBv
cmlnaW5hbCBoYW5kbGVyLiBBRkFJQ1Qgd2hhdCB3aWxsIGhhcHBlbiBpczoNCj4gY2hlY2tfaXJx
X3Jlc2VuZA0KPiAgIHRyeV9yZXRyaWdnZXINCj4gICAgIGlycV9jaGlwX3JldHJpZ2dlcl9oaWVy
YXJjaHkNCj4gICAgICAgaXRzX2lycV9yZXRyaWdnZXINCj4gLi4uIHdoaWNoIHdpbGwgY2F1c2Ug
dGhlIElUUyB0byAqaW1tZWRpYXRlbHkqIHJlLXRyaWdnZXIgdGhlIElSUS4gVGhlDQo+IG9yaWdp
bmFsIENQVSBjYW4gc3RpbGwgYmUgcnVubmluZyB0aGUgaGFuZGxlciBpbiB0aGF0IGNhc2UuDQo+
IA0KPiBJZiB0aGF0IGhhcHBlbnMsIGNvbnNpZGVyIHdoYXQgd2lsbCBoYXBwZW4gaW4gY2hlY2tf
aXJxX3Jlc2VuZDoNCj4gLSBmaXJzdCBJUlEgY29tZXMgaW4sIHN1Y2Nlc3NmbGx5IHJ1bnMgdHJ5
X3JldHJpZ2dlciBhbmQgc2V0cyBJUlFTX1JFUExBWS4NCj4gLSBpdCBpcyAqaW1tZWRpYXRlbHkq
IHJldHJpZ2dlcmVkIGJ5IElUUywgYW5kIGJlY2F1c2UgdGhlIG9yaWdpbmFsIGhhbmRsZXINCj4g
b24gdGhlIG90aGVyIENQVSBpcyBzdGlsbCBydW5uaW5nLCBjb21lcyBpbnRvIGNoZWNrX2lycV9y
ZXNlbmQgYWdhaW4uDQo+IC0gY2hlY2tfaXJxX3Jlc2VuZCBub3cgb2JzZXJ2ZXMgdGhhdCBJUlFT
X1JFUExBWSBpcyBzZXQgYW5kIGVhcmx5IG91dHMuDQo+IC0gTm8gbW9yZSByZXNlbmRzLCB0aGUg
SVJRIGlzIHN0aWxsIGxvc3QuIDotKA0KPiANCj4gTm93IEkgYWRtaXQgdGhlIGZhaWx1cmUgbW9k
ZSBpcyBnZXR0aW5nIGEgYml0IHBhdGhvbG9naWNhbDogdHdvIHJlLQ0KPiB0cmlnZ2VycyB3aGls
ZSB0aGUgb3JpZ2luYWwgaGFuZGxlciBpcyBzdGlsbCBydW5uaW5nLCBidXQgSSB3YXMgYWJsZSB0
bw0KPiBoaXQgdGhpcyBvbiBteSB0ZXN0IG1hY2hpbmUgYnkgaW50ZW50aW9uYWxseSBzbG93aW5n
DQo+IHRoZSBoYW5kbGVyIGRvd24gYnkgYSBmZXcgZG96ZW4gbWljcm9zLiBTaG91bGQgd2UgY2F0
ZXIgZm9yIHRoaXM/DQo+IA0KPiBJIGNhbiBzZWUgdHdvIHBvc3NpYmlsaXRpZXM6DQo+IC0gdHdl
YWsgY2hlY2tfaXJxX3Jlc2VuZCgpIHRvIG5vdCBlYXJseS1vdXQgaW4gdGhpcyBjYXNlIGJ1dCB0
byBrZWVwIHJlLQ0KPiB0cmlnZ2VyaW5nIHVudGlsIGl0IGV2ZW50dWFsbHkgcnVucy4NCj4gLSBt
b3ZlIHRoZSBjaGVja19pcnFfcmVzZW5kIHRvIG9ubHkgaGFwcGVuIGxhdGVyLCAqYWZ0ZXIqIHRo
ZSBvcmlnaW5hbA0KPiBoYW5kbGVyIGhhcyBmaW5pc2hlZCBydW5uaW5nLiBUaGlzIHdvdWxkIGJl
IHZlcnkgc2ltaWxhciB0byB3aGF0IEkNCj4gc3VnZ2VzdGVkIGluIG15IG9yaWdpbmFsIHBhdGNo
LCBleGNlcHQgaW5zdGVhZCBvZiBydW5uaW5nIGEgZG8vd2hpbGUgbG9vcCwNCj4gdGhlIGNvZGUg
d291bGQgb2JzZXJ2ZSB0aGF0IHRoZSBwZW5kaW5nIGZsYWcgd2FzIHNldCBhZ2FpbiBhbmQgcnVu
DQo+IGNoZWNrX2lycV9yZXNlbmQuDQo+IA0KPiBJJ20gYWxzbyB3b25kZXJpbmcgd2hhdCB3aWxs
IGhhcHBlbiBmb3IgdXNlcnMgd2hvIGRvbid0IGhhdmUgdGhlDQo+IGNoaXAtPmlycV9yZXRyaWdn
ZXIgY2FsbGJhY2sgc2V0IGFuZCBmYWxsIGJhY2sgdG8gdGhlIHRhc2tsZXQNCj4gdmlhIGlycV9z
d19yZXNlbmQoKS4uLiBMb29rcyBsaWtlIGl0IHdpbGwgd29yayBmaW5lLiBIb3dldmVyIGlmIHdl
IGRvIG15DQo+IHN1Z2dlc3Rpb24gYW5kIG1vdmUgY2hlY2tfaXJxX3Jlc2VuZCB0byB0aGUgZW5k
IG9mIGhhbmRsZV9mYXN0ZW9pX2lycSB0aGVuDQo+IHRoZSB0YXNrbGV0IHdpbGwgYmUgc2NoZWR1
bGVkIG9uIHRoZSBvbGQgQ1BVIGFnYWluLCB3aGljaCBtYXkgYmUgc3ViLQ0KPiBvcHRpbWFsLg0K
DQpKdXN0IGNoZWNraW5nIHRvIHNlZSBpZiB5b3UndmUgaGFkIGEgY2hhbmNlIHRvIGNvbnNpZGVy
IHRoZXNlDQppc3N1ZXMvdGhvdWdodHMsIGFuZCBpZi9ob3cgdGhleSBzaG91bGQgYmUgaGFuZGxl
ZD8NCkknbSBzdGlsbCB0ZW5kaW5nIHRvd2FyZHMgc2F5aW5nIHRoYXQgdGhlIGNoZWNrX2lycV9y
ZXNlbmQoKSBzaG91bGQgcnVuDQphZnRlciBoYW5kbGVfaXJxX2V2ZW50KCkgYW5kIHRoZSBJUlFT
X1BFTkRJTkcgZmxhZyBzaG91bGQgYmUgd3JhbmdsZWQgdG8NCmRlY2lkZSB3aGV0aGVyIG9yIG5v
dCB0byByZXNlbmQuDQoNCkkganVzdCBkb24ndCBrbm93IGlmIGhhdmluZyB0aGUgdGFza2xldCBz
Y2hlZHVsZWQgYW5kIHJ1biBvbiB0aGUgb3JpZ2luYWwNCkNQVSB2aWEgaXJxX3N3X3Jlc2VuZCgp
IHdvdWxkIGJlIHByb2JsZW1hdGljIG9yIG5vdC4gSW4gZ2VuZXJhbCBpdA0KcHJvYmFibHkgd29u
J3QgYnV0IGluIHRoZSBDUFUgb2ZmbGluaW5nIGNhc2UuLi4uIG1heWJlPyBJIHJlYWxpc2UgdGhh
dCBmb3INCkdJQy12MyB0aGUgdGFza2xldCB3b24ndCBiZSB1c2VkIGJlY2F1c2UgR0lDIGhhcyBj
aGlwLT5pcnFfcmV0cmlnZ2VyDQpjYWxsYmFjayBkZWZpbmVkIC0gSSdtIGp1c3QgdGhpbmtpbmcg
aW4gZ2VuZXJhbCBoZXJlLCBlc3BlY2lhbGx5IHNvDQphc3N1bWluZyB3ZSBkcm9wIHRoZSBuZXcg
SVJRRF9SRVNFTkRfV0hFTl9JTl9QUk9HUkVTUyBmbGFnKS4NCg0KVGhvdWdodHM/DQoNCkkgY2Fu
IHB1dCB0b2dldGhlciBhIFBvQyBhbmQgdGVzdCBpdCBhbG9uZyB3aXRoIFlpcGVuZyBmcm9tIEh1
YXdlaSBpZiB5b3UNCnRoaW5rIGl0IHNvdW5kcyByZWFzb25hYmxlLg0KDQpKRw0K
