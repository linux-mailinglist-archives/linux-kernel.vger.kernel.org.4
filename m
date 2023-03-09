Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652346B1F17
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjCII6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjCII5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:57:31 -0500
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7297E500F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1678352186; x=1709888186;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=a5vYyq3M8U/A7avZVWbkEyfBt22G/RH3fSlgSQLmuEQ=;
  b=SWMNsetf0TUlL9PKkG8I4fsspxiN80FANzKGFP39WhsgH8m5GoZ0xBRZ
   wYFZuZV2HTV+iSmYwuebhrtvy9X/pGJ3z6CAWFcN/HwaS4BjFs7iTSOJu
   wA3GJ7CrNwwRiIDh4XZOdSlhodBf1w7xl0KL5lmFUGTKdTJ0iLd3wvB0N
   4=;
X-IronPort-AV: E=Sophos;i="5.98,245,1673913600"; 
   d="scan'208";a="307184690"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 08:56:23 +0000
Received: from EX19D020EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com (Postfix) with ESMTPS id AACE8A04BB;
        Thu,  9 Mar 2023 08:56:20 +0000 (UTC)
Received: from EX19D030EUC004.ant.amazon.com (10.252.61.164) by
 EX19D020EUA004.ant.amazon.com (10.252.50.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.24; Thu, 9 Mar 2023 08:56:18 +0000
Received: from EX19D030EUC004.ant.amazon.com (10.252.61.164) by
 EX19D030EUC004.ant.amazon.com (10.252.61.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.24;
 Thu, 9 Mar 2023 08:56:18 +0000
Received: from EX19D030EUC004.ant.amazon.com ([fe80::f98a:db18:b0eb:477]) by
 EX19D030EUC004.ant.amazon.com ([fe80::f98a:db18:b0eb:477%3]) with mapi id
 15.02.1118.024; Thu, 9 Mar 2023 08:56:18 +0000
From:   "Krcka, Tomas" <krckatom@amazon.de>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     "Krcka, Tomas" <krckatom@amazon.de>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix event queue overflow
 acknowledgment
Thread-Topic: [PATCH] iommu/arm-smmu-v3: Fix event queue overflow
 acknowledgment
Thread-Index: AQHZUmUDQvjM+UGuakej3zFJkdLkgg==
Date:   Thu, 9 Mar 2023 08:56:18 +0000
Message-ID: <A0F7B0A1-0441-47A4-A045-07604A6C1842@amazon.com>
References: <8291b66d-b9b8-47c9-f5ed-a4e951c92154@arm.com>
 <20230308140204.83249-1-krckatom@amazon.de>
 <b8c21aec-75d6-7b5b-4777-58838f8d8602@arm.com>
In-Reply-To: <b8c21aec-75d6-7b5b-4777-58838f8d8602@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.51.153]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D7688FD1BB7ED4C947CE3CC61B1C854@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiBPbiAyMDIzLTAzLTA4IDE0OjAyLCBUb21hcyBLcmNrYSB3cm90ZToNCj4+Pj4gV2hl
biBhbiBvdmVyZmxvdyBvY2N1cnMgaW4gdGhlIGV2ZW50IHF1ZXVlLCB0aGUgU01NVSB0b2dnbGVz
IG92ZXJmbG93DQo+Pj4+IGZsYWcgT1ZGTEcgaW4gdGhlIFBST0QgcmVnaXN0ZXIuDQo+Pj4+IFRo
ZSBldnRxIHRocmVhZCBpcyBzdXBwb3NlZCB0byBhY2tub3dsZWRnZSB0aGUgb3ZlcmZsb3cgZmxh
ZyBieSB0b2dnbGluZw0KPj4+PiBmbGFnIE9WQUNLRkxHIGluIHRoZSBDT05TIHJlZ2lzdGVyLCBv
dGhlcndpc2UgdGhlIG92ZXJmbG93IGNvbmRpdGlvbiBpcw0KPj4+PiBzdGlsbCBhY3RpdmUgKE9W
RkxHICE9IE9WQUNLRkxHKS4NCj4+Pj4gDQo+Pj4+IEN1cnJlbnRseSB0aGUgYWNrbm93bGVkZ2Ug
cmVnaXN0ZXIgaXMgdG9nZ2xlZCBhZnRlciBjbGVhcmluZyB0aGUgZXZlbnQNCj4+Pj4gcXVldWUg
YnV0IGlzIG5ldmVyIHByb3BhZ2F0ZWQgdG8gdGhlIGhhcmR3YXJlLiBJdCB3b3VsZCBiZSBkb25l
IG5leHQNCj4+Pj4gdGltZSB3aGVuIGV4ZWN1dGluZyBldnRxIHRocmVhZC4NCj4+Pj4gDQo+Pj4+
IFRoZSBTTU1VIHN0aWxsIGFkZHMgZWxlbWVudHMgdG8gdGhlIHF1ZXVlIHdoZW4gdGhlIG92ZXJm
bG93IGNvbmRpdGlvbiBpcw0KPj4+PiBhY3RpdmUgYnV0IGFueSBzdWJzZXF1ZW50IG92ZXJmbG93
IGluZm9ybWF0aW9uIGFmdGVyIGNsZWFyaW5nIHRoZSBldmVudA0KPj4+PiBxdWV1ZSB3aWxsIGJl
IGxvc3QuDQo+Pj4+IA0KPj4+PiBUaGlzIGNoYW5nZSBrZWVwcyB0aGUgU01NVSBpbiBzeW5jIGFz
IGl0J3MgZXhwZWN0ZWQgYnkgZGVzaWduLg0KPj4+IA0KPj4+IElmIEkndmUgdW5kZXJzdG9vZCBj
b3JyZWN0bHksIHRoZSB1cHNob3Qgb2YgdGhpcyBpcyB0aGF0IGlmIHRoZSBxdWV1ZQ0KPj4+IGhh
cyBvdmVyZmxvd2VkIG9uY2UsIGJlY29tZSBlbXB0eSwgdGhlbiBzb21laG93IGdvZXMgZnJvbSBl
bXB0eSB0byBmdWxsDQo+Pj4gYmVmb3JlIHdlIG1hbmFnZSB0byBjb25zdW1lIGEgc2luZ2xlIGV2
ZW50LCB3ZSB3b24ndCBwcmludCB0aGUgImV2ZW50cw0KPj4+IGxvc3QiIG1lc3NhZ2UgYSBzZWNv
bmQgdGltZS4NCj4+PiANCj4+PiBIYXZlIHlvdSBzZWVuIHRoaXMgaGFwcGVuIGluIHByYWN0aWNl
PyBUQkggaWYgdGhlIGV2ZW50IHF1ZXVlIGV2ZXINCj4+PiBvdmVyZmxvd3MgZXZlbiBvbmNlIGl0
J3MgaW5kaWNhdGl2ZSB0aGF0IHRoZSBzeXN0ZW0gaXMgaG9zZWQgYW55d2F5LCBzbw0KPj4+IGl0
J3Mgbm90IGNsZWFyIHRvIG1lIHRoYXQgdGhlcmUncyBhbnkgZ3JlYXQgbG9zcyBvZiB2YWx1ZSBp
biBzb21ldGltZXMNCj4+PiBmYWlsaW5nIHRvIHJlcGVhdCBhIHdhcm5pbmcgZm9yIGEgY2hyb25p
YyBvbmdvaW5nIG9wZXJhdGlvbmFsIGZhaWx1cmUuDQo+Pj4gDQo+PiANCj4+IFllcywgSSBkaWQg
c2VlIGluIHByYWN0aWNlLiBBbmQgaXTigJlzIG5vdCBqdXN0IGFib3V0IGxvb3Npbmcgc3Vic2Vx
dWVuY2Ugd2FybmluZy4NCj4+IFRoZSB3YXkgaG93IGl04oCZcyBkb25lIG5vdyBrZWVwcyBpbmNv
bnNpc3RlbnQgQ09OUyByZWdpc3RlciB2YWx1ZSBiZXR3ZWVuIFNNTVUgYW5kIHRoZSBrZXJuZWwN
Cj4+IHVudGlsIGFueSBuZXcgZXZlbnQgaGFwcGVucy4gVGhlIGtlcm5lbCBkb2VzbuKAmXQgaW5m
b3JtIFNNTVUgdGhhdCB3ZSBrbm93IGFib3V0IHRoZSBvdmVyZmxvdw0KPj4gYW5kIGNvbnN1bWlu
ZyBldmVudHMgYXMgZmFzdCBhcyB3ZSBjYW4uDQo+IA0KPiBJbnRlcmVzdGluZyAtIG91dCBvZiBj
dXJpb3NpdHksIGlzIHNvbWV0aGluZyBibG9ja2luZyB0aGUgSVJRIHRocmVhZA0KPiBmcm9tIHJ1
bm5pbmcgaW4gYSB0aW1lbHkgbWFubmVyLCBvciBhcmUgeW91IGp1c3QgdXNpbmcgYSByZWFsbHkg
dGlueQ0KPiBldmVudCBxdWV1ZT8NCg0KT3VyIGNhc2Ugd2FzIHRoZSB0aW55IGV2ZW50IHF1ZXVl
Lg0KPiANCj4gRWl0aGVyIHdheSB0aG91Z2gsIHRoZSBwb2ludCBpcyB0aGF0IHRoZXJlIGlzIG5v
dGhpbmcgdG8gImluZm9ybSIgdGhlDQo+IFNNTVUgYWJvdXQgaGVyZS4gSXQgd2lsbCBzZWUgdGhh
dCB3ZSdyZSBjb25zdW1pbmcgZXZlbnRzIGFuZCBtYWtpbmcNCj4gc3BhY2UgaW4gdGhlIHF1ZXVl
LCBiZWNhdXNlIHdlJ3JlIHN0aWxsIHVwZGF0aW5nIENPTlMuUkQuIEFsbCB0aGF0IGFuDQo+IHVw
ZGF0ZSBvZiBQUk9ELk9WRkxHIHNlcnZlcyB0byBkbyBpcyBpbmRpY2F0ZSB0byBzb2Z0d2FyZSB0
aGF0IGV2ZW50cw0KPiBoYXZlIGJlZW4gZGlzY2FyZGVkIHNpbmNlIHRoZSBsYXN0IHRpbWUgQ09O
Uy5PVkFDS0ZMRyB3YXMgdXBkYXRlZC4gSXQNCj4gbWFrZXMgbm8gZGlmZmVyZW5jZSB0byB0aGUg
U01NVSBpZiBpdCBjb250aW51ZXMgdG8gZGlzY2FyZCAqbW9yZSogZXZlbnRzDQo+IHVudGlsIHNv
ZnR3YXJlIHVwZGF0ZXMgQ09OUy5PVkFDS0ZMRyBhZ2Fpbi4gSXQncyBlbnRpcmVseSBzb2Z0d2Fy
ZSdzIG93bg0KPiBkZWNpc2lvbiBob3cgY2xvc2VseSBpdCB3YW50cyB0byBrZWVwIHRyYWNrIG9m
IG92ZXJmbG93cy4NCj4gDQo+IExpa2UgSSBzYXkgaXQncyBub3QgY2xlYXIgaG93IG11Y2ggTGlu
dXggcmVhbGx5IGNhcmVzIGFib3V0IHRoYXQsIGdpdmVuDQo+IHRoYXQgYWxsIHdlIGRvIHdpdGgg
dGhlIGluZm9ybWF0aW9uIGlzIGxvZyBhIG1lc3NhZ2UgdG8gaW5kaWNhdGUgdGhhdA0KPiBzb21l
IG1vcmUgZXZlbnRzIGhhdmUgYmVlbiBsb3N0IHNpbmNlIHRoZSBsYXN0IHRpbWUgd2UgbG9nZ2Vk
IHRoZSBzYW1lDQo+IG1lc3NhZ2UuIEZ1cnRoZXJtb3JlLCB0aGUgb25seSB0aGluZyB3ZSdsbCBk
byB3aXRoIHRoZSBvdmVyd2hlbG1pbmcNCj4gbWFqb3JpdHkgb2YgZXZlbnRzIHRoZW1zZWx2ZXMg
aXMgYWxzbyBsb2cgbWVzc2FnZXMuIFRodXMgcmVhbGlzdGljYWxseQ0KPiBpZiB3ZSdyZSBzdWRk
ZW5seSBmYWNlZCB3aXRoIHByb2Nlc3NpbmcgYSBmdWxsIGV2ZW50IHF1ZXVlIG91dCBvZg0KPiBu
b3doZXJlLCB0aGVuIG1hbnkgb2YgdGhlIGV2ZW50cyB3aGljaCAqd2VyZSogZGVsaXZlcmVkIHRv
IHRoZSBxdWV1ZQ0KPiB3aWxsIGFsc28gYmUgImxvc3QiIHRoYW5rcyB0byByYXRlLWxpbWl0aW5n
Lg0KPiANCj4gRldJVyBJIHRoaW5rIGl0J3Mgc3RpbGwgdHJ1ZSB0aGF0IGZvciBvdXIgY3VycmVu
dGx5IHN1cHBvcnRlZCB1c2UtY2FzZXMNCj4gaW4gTGludXgsICphbnkqIGRpc2NhcmRhYmxlIGV2
ZW50IGlzIGEgc2lnbiB0aGF0IHNvbWV0aGluZydzIGdvbmUgd3Jvbmc7DQo+IGEgZnVsbCBxdWV1
ZSBvZiAzMksgZXZlbnRzIHdvdWxkIGFscmVhZHkgYmUgYSBzaWduIHRoYXQgc29tZXRoaW5nJ3Mg
Z29uZQ0KPiAqc2V2ZXJlbHkqIHdyb25nLCBzbyBhdCB0aGF0IHBvaW50IGtub3dpbmcgd2hldGhl
ciBpdCB3YXMgZXhhY3RseSAzMkssDQo+IG9yIDMySyArIG4gZm9yIHNvbWUgaW5kZXRlcm1pbmF0
ZSB2YWx1ZSBvZiBuLCBpcyB1bmxpa2VseSB0byBiZQ0KPiBzaWduaWZpY2FudGx5IG1lYW5pbmdm
dWwuDQoNClRoZSBpc3N1ZSBJIHNlZSB3aXRoIHRoZSBjdXJyZW50IHN0YXRlIGlzIHRoYXQgbG9j
YWwgKGtlcm5lbCkgY29weSBvZiB0aGUgQ09OUyByZWdpc3Rlcg0Kd2lsbCBiZSBkaWZmZXJlbnQg
ZnJvbSB0aGUgU01NVSBzdGF0ZSBmb3IgYW4gaW5kZWZpbml0ZSBwZXJpb2Qgb2YgdGltZSwgdW50
aWwgd2UgZ2V0IG5ldyANCmV2ZW50Lg0KSW4gdGhlIG1lYW50aW1lLCB3ZSBjYW5ub3QgdXNlIHRo
ZSBsb2NhbCBjb3B5IGFzIGEgdmFsdWUgcmVwcmVzZW50aW5nIHN0YXRlIGluIFNNTVUuDQpXaXRo
IG9yIHdpdGhvdXQgdGhpcyBwYXRjaCwgaXQgc2hvdWxkIGJlIGNsZWFybHkgdmlzaWJsZS4gDQpS
aWdodCBub3cgdGhlIGtlcm5lbCBqdXN0IHByaW50cyB3YXJuaW5nIG1lc3NhZ2VzLg0KSWYgYW55
IGNoYW5nZSBpcyBpbXBsZW1lbnRlZCBpbiB0aGUgZnV0dXJlLCB0aGlzIHN0YXRlIHNob3VsZCBi
ZSB0YWtlbiBpbnRvIGFjY291bnQuDQpTeW5jaW5nIHRoZSBDT05TIHJlZ2lzdGVyIGltbWVkaWF0
ZWx5IGFmdGVyIHRoZSBjaGFuZ2Ugd291bGQgcHJldmVudCBhbnkgbWlzdW5kZXJzdGFuZGluZy4N
ClRoYXQgaXMgd2h5IEkgaGF2ZSBwb3N0ZWQgdGhpcyBwYXRjaCwgbWF5YmUgSSBzaG91bGQgaGF2
ZSBjbGFyaWZpZWQgaXQgYmV0dGVyIGluIHRoZQ0KY29tbWl0IG1lc3NhZ2UuDQoNCkFueXdheSwg
ZG8geW91IHRoaW5rIHRoYXQgd2Ugc2hvdWxkIGF0IGxlYXN0IGZpbmQgYSB3YXkgaG93IHRvIG1h
a2UgdGhlIGV2ZW50cSAgDQpDT05TLk9WQUNLRkxHICBzeW5jIHdvcmtmbG93IGNsZWFyZXIgPw0K
PiANCj4+PiBJdCBjb3VsZCBiZSBhcmd1ZWQgdGhhdCB3ZSBoYXZlIGEgc3VidGxlIGluY29uc2lz
dGVuY3kgYmV0d2Vlbg0KPj4+IGFybV9zbW11X2V2dHFfdGhyZWFkKCkgYW5kIGFybV9zbW11X3By
aXFfdGhyZWFkKCkgaGVyZSwgYnV0IHRoZSBmYWN0IGlzDQo+Pj4gdGhhdCB0aGUgRXZlbnQgcXVl
dWUgYW5kIFBSSSBxdWV1ZSAqZG8qIGhhdmUgZGlmZmVyZW50IG92ZXJmbG93DQo+Pj4gYmVoYXZp
b3Vycywgc28gaXQgY291bGQgZXF1YWxseSBiZSBhcmd1ZWQgdGhhdCBpbmNvbnNpc3RlbmN5IGlu
IHRoZSBjb2RlDQo+Pj4gaGVscHMgcmVmbGVjdCB0aGF0LiBGV0lXIEkgY2FuJ3Qgc2F5IEkgaGF2
ZSBhIHN0cm9uZyBwcmVmZXJlbmNlIGVpdGhlciB3YXkuDQo+PiANCj4+IEZvciB0aGUgYXJndW1l
bnQgdGhhdCB0aGUgY29kZSBjYW4gcmVmbGVjdCB0aGUgZGlmZmVyZW5jZS4NCj4+IFRoZW4gdGhl
IGNvbW1lbnQgJ1N5bmMgb3VyIG92ZXJmbG93IGZsYWcsIGFzIHdlIGJlbGlldmUgd2UncmUgdXAg
dG8gc3BlZWTigJkgaXMNCj4+IGFscmVhZHkgbWlzbGVhZGluZy4NCj4gDQo+IFllcywgdGhhdCBp
cyB3aGF0IEkgd2FzIGFsbHVkaW5nIHRvLiBTb21ldGltZXMgaWYgYSBjb21tZW50IGRvZXNuJ3QN
Cj4gY2xlYXJseSBtYXRjaCB0aGUgY29kZSBpdCBtZWFucyB0aGUgY29kZSBpcyB3cm9uZy4gU29t
ZXRpbWVzIGl0IGp1c3QNCj4gbWVhbnMgdGhlIGNvbW1lbnQgaXMgd3JvbmcuDQo+IA0KPiBJJ20g
bm90IHNheWluZyB0aGlzIHBhdGNoIGlzIHRoZSB3cm9uZyBhbnN3ZXIsIGJ1dCBhcyBwcmVzZW50
ZWQgaXQNCj4gaGFzbid0IG1hbmFnZWQgdG8gY29udmluY2UgbWUgdGhhdCBpdCdzIHRoZSByaWdo
dCBvbmUgZWl0aGVyLiBMYXJnZWx5DQo+IHNpbmNlIEknbSBub3QgMTAwJSBzdXJlIHdoYXQgdGhl
IGV4YWN0IHF1ZXN0aW9uIGlzIC0gZXZlbiB3aXRoIHRoaXMNCj4gY2hhbmdlIHdlJ2Qgc3RpbGwg
aGF2ZSB0aGUgc2FtZSBBQkEgcHJvYmxlbSB3aGVuZXZlciB0aGUgcXVldWUgb3ZlcmZsb3dzDQo+
IGFnYWluICpiZWZvcmUqIGl0J3MgY29tcGxldGVseSBkcmFpbmVkLg0KPiANCj4gVGhhbmtzLA0K
PiBSb2Jpbi4NCg0KVGhhbmsgeW91Lg0KVG9tYXMNCg0KDQoKCgpBbWF6b24gRGV2ZWxvcG1lbnQg
Q2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0
c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdl
biBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejog
QmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

