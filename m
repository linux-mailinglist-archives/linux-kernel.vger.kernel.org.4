Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA39B7329DC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245274AbjFPIck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjFPIcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:32:36 -0400
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E9E2D48
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686904356; x=1718440356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r5rVlmHwFsJrSN1/mnupR/bO+oDiYEmTtz2+L5vT+cM=;
  b=adKCose/2Z1eZk/OmAZpgHVOx3i1hl4egIwCfwzP+MiQLSigCnTZIrB/
   pJ5QYPXYX3WDOe4Q5n90+EAb9oDi+VFXIyEmOA42h3EX/T+KpDYDadSpP
   Ut+i9oSE4owO7x537dIJEYOT/Q70XKTn/q7O/q358imz5h/ZPS3UGcqzQ
   s=;
X-IronPort-AV: E=Sophos;i="6.00,247,1681171200"; 
   d="scan'208";a="587685952"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-3ef535ca.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 08:32:33 +0000
Received: from EX19D014EUC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-3ef535ca.us-west-2.amazon.com (Postfix) with ESMTPS id E7A8960AA2;
        Fri, 16 Jun 2023 08:32:31 +0000 (UTC)
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D014EUC001.ant.amazon.com (10.252.51.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Jun 2023 08:32:30 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.026; Fri, 16 Jun 2023 08:32:30 +0000
From:   "Gowans, James" <jgowans@amazon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "liaochang1@huawei.com" <liaochang1@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Resend GIC-v3 LPIs on concurrent invoke
Thread-Topic: [PATCH 0/3] Resend GIC-v3 LPIs on concurrent invoke
Thread-Index: AQHZmgEKR/AD3FMNjkCRB6yMZRAtzK+NJh6A
Date:   Fri, 16 Jun 2023 08:32:30 +0000
Message-ID: <d08bc249fcf25ab88ded1578e79997a25ab6ba93.camel@amazon.com>
References: <20230608120021.3273400-1-jgowans@amazon.com>
In-Reply-To: <20230608120021.3273400-1-jgowans@amazon.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.222]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C999BD054DA09A4AB154C8EC9A98B04E@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYyBhbmQgVG9tYXMsDQpKdXN0IGEgcGluZyBvbiB0aGlzIHNlcmllczsgd291bGQgYmUg
Z3JlYXQgdG8gZ2V0IGFueSBtb3JlIGZlZWRiYWNrLCBvcg0KZ2V0IHRoaXMgbWVyZ2VkLg0KDQpU
aGFua3MhDQpKYW1lcw0KDQpPbiBUaHUsIDIwMjMtMDYtMDggYXQgMTQ6MDAgKzAyMDAsIEphbWVz
IEdvd2FucyB3cm90ZToNCj4gSWYgaW50ZXJydXB0cyBkbyBub3QgaGF2ZSBnbG9iYWwgYWN0aXZl
IHN0YXRlcyBpdCBpcyBwb3NzaWJsZSBmb3INCj4gdGhlIG5leHQgaW50ZXJydXB0IHRvIGFycml2
ZSBvbiBhIG5ldyBDUFUgaWYgYW4gYWZmaW5pdHkgY2hhbmdlIGhhcHBlbnMNCj4gd2hpbGUgdGhl
IG9yaWdpbmFsIENQVSBpcyBzdGlsbCBydW5uaW5nIHRoZSBoYW5kbGVyLiBUaGlzIHNwZWNpZmlj
YWxseQ0KPiBpbXBhY3RzIEdJQy12My4NCj4gDQo+IEluIHRoaXMgc2VyaWVzLCBnZW5lcmljIGZ1
bmN0aW9uYWxpdHkgaXMgYWRkZWQgdG8gaGFuZGxlX2Zhc3RfZW9pKCkgdG8NCj4gc3VwcG9ydCBy
ZXNlbmRpbmcgdGhlIGludGVycnVwdCB3aGVuIHRoaXMgcmFjZSBoYXBwZW5zLCBhbmQgdGhhdCBn
ZW5lcmljDQo+IGZ1bmN0aW9uYWxpdHkgaXMgZW5hYmxlZCBzcGVjaWZpY2FsbHkgZm9yIHRoZSBH
SUMtdjMgd2hpY2ggaXMgaW1wYWN0ZWQNCj4gYnkgdGhpcyBpc3N1ZS4gR0lDLXYzIHVzZXMgdGhl
IGhhbmRsZV9mYXN0X2VvaSgpIGdlbmVyaWMgaGFuZGxlciwgaGVuY2UNCj4gdGhhdCBpcyB0aGUg
aGFuZGxlciBnZXR0aW5nIHRoZSBmdW5jdGlvbmFsaXR5Lg0KPiANCj4gQWxzbyBhZGRpbmcgYSBi
aXQgbW9yZSBkZXRhaWxzIHRvIHRoZSBJUlFEIGZsYWdzIGRvY3MgdG8gaGVscCBmdXR1cmUNCj4g
cmVhZGVycyBrbm93IHdoZW4vd2h5IGZsYWdzIHNob3VsZCBiZSB1c2VkIGFuZCB3aGF0IHRoZXkg
bWVhbi4NCj4gDQo+ID09IFRlc3Rpbmc6ID09DQo+IA0KPiBUTDtEUjogUnVuIGEgdmlydCB1c2lu
ZyBRRU1VIG9uIGEgRUMyIFI2Zy5tZXRhbCBob3N0IHdpdGggYSBFTkEgZGV2aWNlDQo+IHBhc3Nl
ZCB0aHJvdWdoIHVzaW5nIFZGSU8gLSBib3VuY2UgSVJRIGFmZmluaXR5IGJldHdlZW4gdHdvIENQ
VXMuIEJlZm9yZQ0KPiB0aGlzIGNoYW5nZSBhbiBpbnRlcnJ1cHQgY2FuIGdldCBsb3N0IGFuZCB0
aGUgZGV2aWNlIHN0YWxsczsgYWZ0ZXIgdGhpcw0KPiBjaGFuZ2UgdGhlIGludGVycnVwdCBpcyBu
b3QgbG9zdC4NCj4gDQo+ID09PSBEZXRhaWxzOiA9PT0NCj4gDQo+IEludGVudGlvbmFsbHkgc2xv
dyBkb3duIHRoZSBJUlEgaW5qZWN0aW9uIGEgYml0LCB0byB0dXJuIHRoaXMgZnJvbSBhDQo+IHJh
cmUgcmFjZSBjb25kaXRpb24gd2hpY2ggdG8gc29tZXRoaW5nIHdoaWNoIGNhbiBlYXNpbHkgYmUg
Zmx1c2hlZCBvdXQNCj4gaW4gdGVzdGluZzoNCj4gDQo+IEBAIC03NjMsNiArNzY0LDcgQEAgaW50
IHZnaWNfaXRzX2luamVjdF9jYWNoZWRfdHJhbnNsYXRpb24oc3RydWN0IGt2bSAqa3ZtLCBzdHJ1
Y3Qga3ZtX21zaSAqbXNpKQ0KPiAgICAgICAgIHJhd19zcGluX2xvY2tfaXJxc2F2ZSgmaXJxLT5p
cnFfbG9jaywgZmxhZ3MpOw0KPiAgICAgICAgIGlycS0+cGVuZGluZ19sYXRjaCA9IHRydWU7DQo+
ICAgICAgICAgdmdpY19xdWV1ZV9pcnFfdW5sb2NrKGt2bSwgaXJxLCBmbGFncyk7DQo+ICsgICAg
ICAgdWRlbGF5KDEwKTsNCj4gDQo+ICAgICAgICAgcmV0dXJuIDA7DQo+ICB9DQo+IA0KPiBBbHNv
IHNwcmlua2xlIGEgcHJpbnQgdG8gbWFrZSBpdCBjbGVhciB3aGVuIHRoZSByYWNlIGRlc2NyaWJl
ZCBoZXJlIGlzDQo+IGhpdDoNCj4gDQo+IEBAIC02OTgsNiArNjk4LDcgQEAgdm9pZCBoYW5kbGVf
ZmFzdGVvaV9pcnEoc3RydWN0IGlycV9kZXNjICpkZXNjKQ0KPiAgICAgICAgICAqIGhhbmRsaW5n
IHRoZSBwcmV2aW91cyBvbmUgLSBpdCBtYXkgbmVlZCB0byBiZSByZXNlbnQuDQo+ICAgICAgICAg
ICovDQo+ICAgICAgICAgaWYgKCFpcnFfbWF5X3J1bihkZXNjKSkgew0KPiArICAgICAgICAgICAg
ICAgcHJpbnRrKCIhaXJxX21heV9ydW4gJWlcbiIsIGRlc2MtPmlycV9kYXRhLmlycSk7DQo+ICAg
ICAgICAgICAgICAgICBpZiAoaXJxZF9uZWVkc19yZXNlbmRfd2hlbl9pbl9wcm9ncmVzcygmZGVz
Yy0+aXJxX2RhdGEpKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBkZXNjLT5pc3RhdGUgfD0g
SVJRU19QRU5ESU5HOw0KPiAgICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+IA0KPiBMYXVuY2gg
UUVNVSBpbiB5b3VyIGZhdm91cml0ZSB3YXksIHdpdGggYW4gRU5BIGRldmljZSBwYXNzZWQgdGhy
b3VnaCB2aWENCj4gVkZJTyAoVkZJTyBkcml2ZXIgcmUtYmluZGluZyBuZWVkcyB0byBiZSBkb25l
IGJlZm9yZSB0aGlzKToNCj4gDQo+IHFlbXUtc3lzdGVtLWFhcmNoNjQgLWVuYWJsZS1rdm0gIC1t
YWNoaW5lIHZpcnQsZ2ljX3ZlcnNpb249MyAtZGV2aWNlIHZmaW8tcGNpLGhvc3Q9MDQ6MDAuMCAu
Li4NCj4gDQo+IEluIHRoZSBWTSwgZ2VuZXJhdGUgbmV0d29yayB0cmFmZmljIHRvIGdldCBpbnRl
cnJ1cHRzIGZsb3dpbmc6DQo+IA0KPiBwaW5nIC1mIC1pIDAuMDAxIDEwLjAuMy4xID4gL2Rldi9u
dWxsDQo+IA0KPiBPbiB0aGUgaG9zdCwgY2hhbmdlIGFmZmluaXR5IG9mIHRoZSBpbnRlcnJ1cHQg
YXJvdW5kIHRvIGZsdXNoIG91dCB0aGUgcmFjZToNCj4gDQo+IHdoaWxlIHRydWU7IGRvDQo+IAll
Y2hvIDEgPiAvcHJvYy9pcnEvNzEvc21wX2FmZmluaXR5IDsgc2xlZXAgMC4wMTsNCj4gCWVjaG8g
MiA+IC9wcm9jL2lycS83MS9zbXBfYWZmaW5pdHkgOyBzbGVlcCAwLjAxOw0KPiBkb25lDQo+IA0K
PiBJbiBob3N0IGRtZXNnIHRoZSBwcmludGsgaW5kaWNhdGVzIHRoYXQgdGhlIHJhY2UgaXMgaGl0
Og0KPiANCj4gWyAgMTAyLjIxNTgwMV0gIWlycV9tYXlfcnVuIDcxDQo+IFsgIDEwNS40MjY0MTNd
ICFpcnFfbWF5X3J1biA3MQ0KPiBbICAxMDUuNTg2NDYyXSAhaXJxX21heV9ydW4gNzENCj4gDQo+
IEJlZm9yZSB0aGlzIGNoYW5nZSwgYW4gaW50ZXJydXB0IGlzIGxvc3QgYW5kIHRoaXMgbWFuaWZl
c3RzIGFzIGEgZHJpdmVyDQo+IHdhdGNoZG9nIHRpbWVvdXQgaW4gdGhlIGd1ZXN0IGRldmljZSBk
cml2ZXI6DQo+IA0KPiBbICAgMzUuMTI0NDQxXSBlbmEgMDAwMDowMDowMi4wIGVucDBzMjogRm91
bmQgYSBUeCB0aGF0IHdhc24ndCBjb21wbGV0ZWQgb24gdGltZSwuLi4NCj4gLi4uDQo+IFsgICAz
Ny4xMjQ0NTldIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiBbICAgMzcu
MTI0NzkxXSBORVRERVYgV0FUQ0hET0c6IGVucDBzMiAoZW5hKTogdHJhbnNtaXQgcXVldWUgMCB0
aW1lZCBvdXQNCj4gDQo+IEFmdGVyIHRoaXMgY2hhbmdlLCBldmVuIHRob3VnaCB0aGUgIWlycV9t
YXlfcnVuIHByaW50IGlzIHN0aWxsIHNob3duDQo+IChpbmRpY2F0aW5nIHRoYXQgdGhlIHJhY2Ug
aXMgc3RpbGwgaGl0KSB0aGUgZHJpdmVyIG5vIGxvbmdlciB0aW1lcyBvdXQNCj4gYmVjYXVzZSB0
aGUgaW50ZXJydXB0IG5vdyBnZXRzIHJlc2VudCB3aGVuIHRoZSByYWNlIG9jY3Vycy4NCj4gDQo+
IEphbWVzIEdvd2FucyAoMyk6DQo+ICAgZ2VuaXJxOiBFeHBhbmQgZG9jIGZvciBQRU5ESU5HIGFu
ZCBSRVBMQVkgZmxhZ3MNCj4gICBnZW5pcnE6IGZhc3Rlb2kgc3VwcG9ydHMgcmVzZW5kIG9uIGNv
bmN1cnJlbnQgaW52b2tlDQo+ICAgaXJxY2hpcC9naWMtdjMtaXRzOiBFbmFibGUgUkVTRU5EX1dI
RU5fSU5fUFJPR1JFU1MgZm9yIExQSXMNCj4gDQo+ICBkcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12
My1pdHMuYyB8ICAyICsrDQo+ICBpbmNsdWRlL2xpbnV4L2lycS5oICAgICAgICAgICAgICB8IDEz
ICsrKysrKysrKysrKysNCj4gIGtlcm5lbC9pcnEvY2hpcC5jICAgICAgICAgICAgICAgIHwgMTYg
KysrKysrKysrKysrKysrLQ0KPiAga2VybmVsL2lycS9kZWJ1Z2ZzLmMgICAgICAgICAgICAgfCAg
MiArKw0KPiAga2VybmVsL2lycS9pbnRlcm5hbHMuaCAgICAgICAgICAgfCAgNyArKysrKy0tDQo+
ICA1IGZpbGVzIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0K
PiANCj4gYmFzZS1jb21taXQ6IDVmNjM1OTVlYmQ4MmY1NmEyZGQzNmNhMDEzZGQ3ZjVmZjJlMjQx
NmENCg==
