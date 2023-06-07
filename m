Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58544725EEA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240707AbjFGMVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240747AbjFGMVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:21:22 -0400
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF051FC4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686140475; x=1717676475;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UOuuG9t1FZOqwrB4HXi09hRAifW1OU5cdl/OKI48ueA=;
  b=nG1HaaJARBCGZN2ZdmZA9L8LEZRjNi1LsKwCmoq+PFvJmRlB/uOYgsH/
   H0vo+5Lmb3vVJ4IaZfPvLew5aiL9P4voaudw2tz8fSpk1dD49Ly8BTRM+
   dhkKjZ8ocHLk2ipCIxTucsIqBj1GToTtX8hfSJg5g4TTHMmaDwPSnF0fL
   0=;
X-IronPort-AV: E=Sophos;i="6.00,224,1681171200"; 
   d="scan'208";a="8681979"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 12:21:13 +0000
Received: from EX19D001EUA004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com (Postfix) with ESMTPS id 1291DA0CB4;
        Wed,  7 Jun 2023 12:21:11 +0000 (UTC)
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D001EUA004.ant.amazon.com (10.252.50.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 12:21:10 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.026; Wed, 7 Jun 2023 12:21:10 +0000
From:   "Gowans, James" <jgowans@amazon.com>
To:     "maz@kernel.org" <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "Raslan, KarimAllah" <karahmed@amazon.com>,
        "liaochang1@huawei.com" <liaochang1@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zouyipeng@huawei.com" <zouyipeng@huawei.com>,
        "chris.zjh@huawei.com" <chris.zjh@huawei.com>
Subject: Re: [PATCH v3 2/2] genirq: fasteoi supports resend on concurrent
 invoke
Thread-Topic: [PATCH v3 2/2] genirq: fasteoi supports resend on concurrent
 invoke
Thread-Index: AQHZmTqKTlfTtCTd7k+4gQ3+psU7cA==
Date:   Wed, 7 Jun 2023 12:21:10 +0000
Message-ID: <9c831b0b0b0f067f48841903b5173e3c97f84292.camel@amazon.com>
References: <20230605155723.2628097-1-jgowans@amazon.com>
         <20230605155723.2628097-2-jgowans@amazon.com>
         <87jzwgo715.wl-maz@kernel.org>
In-Reply-To: <87jzwgo715.wl-maz@kernel.org>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.226]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6CF5E715C94194BB23F8DB29E5987D2@amazon.com>
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

T24gVHVlLCAyMDIzLTA2LTA2IGF0IDE4OjA1ICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IA0KPiBPbiBNb24sIDA1IEp1biAyMDIzIDE2OjU3OjIzICswMTAwLA0KPiBKYW1lcyBHb3dhbnMg
PGpnb3dhbnNAYW1hem9uLmNvbT4gd3JvdGU6DQo+ID4gLi4uIGFuZCBlbmFibGUgdGhhdCBmdW5j
dGlvbmFsaXR5IGZvciBHSUMtdjMgb25seS4NCj4gDQo+IG5pdDogZHJvcCB0aGUgbXVsdGktbGlu
ZSBzdWJqZWN0Lg0KDQpXb3VsZCB5b3UgcHJlZmVyIHR3byBjb21taXRzIC0gb25lIHRvIGludHJv
ZHVjZSB0aGUgZnVuY3Rpb25hbGl0eSBhbmQgb25lDQp0byBlbmFibGUgaXQgZm9yIEdJQy12Mz8N
Cg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pcnEuaCBiL2luY2x1ZGUvbGludXgvaXJx
LmgNCj4gPiBpbmRleCBiMWIyOGFmZmIzMmEuLmI3NmNjOTBmYWViZCAxMDA2NDQNCj4gPiAtLS0g
YS9pbmNsdWRlL2xpbnV4L2lycS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9pcnEuaA0KPiA+
IEBAIC0yMjMsNiArMjIzLDggQEAgc3RydWN0IGlycV9kYXRhIHsNCj4gPiAgICogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGlycV9jaGlwOjppcnFfc2V0X2FmZmluaXR5KCkgd2hlbiBkZWFj
dGl2YXRlZC4NCj4gPiAgICogSVJRRF9JUlFfRU5BQkxFRF9PTl9TVVNQRU5EICAgICAgIC0gSW50
ZXJydXB0IGlzIGVuYWJsZWQgb24gc3VzcGVuZCBieSBpcnEgcG0gaWYNCj4gPiAgICogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGlycWNoaXAgaGF2ZSBmbGFnIElSUUNISVBfRU5BQkxFX1dB
S0VVUF9PTl9TVVNQRU5EIHNldC4NCj4gPiArICogUlFEX1JFU0VORF9XSEVOX0lOX1BST0dSRVNT
ICAgICAgIC0gSW50ZXJydXB0IG1heSBmaXJlIHdoZW4gYWxyZWFkeSBpbiBwcm9ncmVzcyBpbiB3
aGljaA0KPiA+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2FzZSBpdCBtdXN0IGJl
IHJlc2VudCBhdCB0aGUgbmV4dCBhdmFpbGFibGUgb3Bwb3J0dW5pdHkuDQo+ID4gICAqLw0KPiA+
ICBlbnVtIHsNCj4gPiAgICAgICBJUlFEX1RSSUdHRVJfTUFTSyAgICAgICAgICAgICAgID0gMHhm
LA0KPiA+IEBAIC0yNDksNiArMjUxLDcgQEAgZW51bSB7DQo+ID4gICAgICAgSVJRRF9IQU5ETEVf
RU5GT1JDRV9JUlFDVFggICAgICA9ICgxIDw8IDI4KSwNCj4gPiAgICAgICBJUlFEX0FGRklOSVRZ
X09OX0FDVElWQVRFICAgICAgID0gKDEgPDwgMjkpLA0KPiA+ICAgICAgIElSUURfSVJRX0VOQUJM
RURfT05fU1VTUEVORCAgICAgPSAoMSA8PCAzMCksDQo+ID4gKyAgICAgSVJRRF9SRVNFTkRfV0hF
Tl9JTl9QUk9HUkVTUyAgICA9ICgxIDw8IDMxKSwNCj4gDQo+IE1ha2UgdGhpcyB1bnNpZ25lZCwg
YXMgaXQgb3RoZXJ3aXNlIGhhcyB0aGUgcG90ZW50aWFsIHRvIHNpZ24tZXh0ZW5kDQo+IGFuZCBs
ZWFkIHRvICJmdW4gdG8gZGVidWciIGlzc3Vlcy4NCg0KQWNrLCBkb2luZyB0aGlzIGNoYW5nZToN
Cg0KQEAgLTI1MSw3ICsyNTEsNyBAQCBlbnVtIHsNCiAgICAgICAgSVJRRF9IQU5ETEVfRU5GT1JD
RV9JUlFDVFggICAgICA9ICgxIDw8IDI4KSwNCiAgICAgICAgSVJRRF9BRkZJTklUWV9PTl9BQ1RJ
VkFURSAgICAgICA9ICgxIDw8IDI5KSwNCiAgICAgICAgSVJRRF9JUlFfRU5BQkxFRF9PTl9TVVNQ
RU5EICAgICA9ICgxIDw8IDMwKSwNCi0gICAgICAgSVJRRF9SRVNFTkRfV0hFTl9JTl9QUk9HUkVT
UyAgICA9ICgxIDw8IDMxKSwNCisgICAgICAgSVJRRF9SRVNFTkRfV0hFTl9JTl9QUk9HUkVTUyAg
ICA9ICgxVSA8PCAzMSksDQogfTsNCiANCihsb29rcyBhIGJpdCBvZGQgaGF2aW5nIG9ubHkgdGhp
cyBvbmUgdW5zaWduZWQgdGhvdWdoLi4uKQ0KDQpBbHNvIGZpeGluZyBhYm92ZSB0eXBvIHdoaWNo
IFJhbmR5IHBvaW50ZWQgb3V0Lg0KDQo+ICsrKyBiL2tlcm5lbC9pcnEvY2hpcC5jDQo+ID4gQEAg
LTY5Miw4ICs2OTIsMTYgQEAgdm9pZCBoYW5kbGVfZmFzdGVvaV9pcnEoc3RydWN0IGlycV9kZXNj
ICpkZXNjKQ0KPiA+IA0KPiA+ICAgICAgIHJhd19zcGluX2xvY2soJmRlc2MtPmxvY2spOw0KPiA+
IA0KPiA+IC0gICAgIGlmICghaXJxX21heV9ydW4oZGVzYykpDQo+ID4gKyAgICAgLyoNCj4gPiAr
ICAgICAgKiBXaGVuIGFuIGFmZmluaXR5IGNoYW5nZSByYWNlcyB3aXRoIElSUSBkZWxpdmVyeSwg
dGhlIG5leHQgaW50ZXJydXB0DQo+IA0KPiBUaGUgcmFjZSBpcyB3aXRoIHRoZSBJUlEgKmhhbmRs
aW5nKi4NCg0KUmV3b3JkZWQuDQoNCj4gDQo+IElmIHlvdSByZXNwaW4gdGhpcyBzZXJpZXMgc2hv
cnRseSAoKndpdGgqIGEgY292ZXIgbGV0dGVyLCBwbGVhc2UpLA0KPiBJJ2xsIHF1ZXVlIGl0IHNv
IHRoYXQgaXQgY2FuIHNpbW1lciBpbiAtbmV4dCBmb3IgYSBiaXQuDQoNCldpbGwgZG8gLSBqdXN0
IGtlZW4gdG8gc2VlIGlmIHlvdSBwcmVmZXIgdGhlIGNvbW1pdCB0byBiZSBzcGxpdC4NCg0KSkcN
Cg==
