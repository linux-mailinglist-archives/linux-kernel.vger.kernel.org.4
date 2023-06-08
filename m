Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCB0727FAC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbjFHMMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbjFHMMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:12:37 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027D4184
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 05:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686226357; x=1717762357;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gS4xhVj8gxF8BXH9pXa+KuVfXpf56uoh5w2XzqhngVg=;
  b=k89OwsTZf67EJUi0mnCX51GS/T5cM8Onum5EX+1lh27waNoM+0KRAsRD
   LrkJPLgtoC/a0T+GSSzSVidS7j52C/NzoEJtamVck+vJIxmR/gw2lwfCj
   bedz1usqMgoVwaqkKaxc/6T2u1bfiPjaYPz+4zbEuAMSSgYYy/tZKyPX/
   k=;
X-IronPort-AV: E=Sophos;i="6.00,226,1681171200"; 
   d="scan'208";a="219687472"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 12:12:36 +0000
Received: from EX19D001EUA003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com (Postfix) with ESMTPS id 8CD0BA0743;
        Thu,  8 Jun 2023 12:12:35 +0000 (UTC)
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D001EUA003.ant.amazon.com (10.252.50.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 8 Jun 2023 12:12:34 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.026; Thu, 8 Jun 2023 12:12:34 +0000
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
Thread-Index: AQHZmgKBhs/uX+H82UK1+mdvNXSe+w==
Date:   Thu, 8 Jun 2023 12:12:34 +0000
Message-ID: <2439ff9afd9a98d850ddd0d39b881fcbc7f6b7ac.camel@amazon.com>
References: <20230605155723.2628097-1-jgowans@amazon.com>
         <20230605155723.2628097-2-jgowans@amazon.com>
         <87jzwgo715.wl-maz@kernel.org>
         <9c831b0b0b0f067f48841903b5173e3c97f84292.camel@amazon.com>
         <2fc0a230d79414ab2c2027ec02a022e3@kernel.org>
In-Reply-To: <2fc0a230d79414ab2c2027ec02a022e3@kernel.org>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.221]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A000F36618D34245BADF620B7F200EC6@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTA3IGF0IDE0OjEzICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIDIwMjMtMDYtMDcgMTM6MjEsIEdvd2FucywgSmFtZXMgd3JvdGU6DQo+ID4gT24gVHVlLCAy
MDIzLTA2LTA2IGF0IDE4OjA1ICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+ID4gPiBPbiBN
b24sIDA1IEp1biAyMDIzIDE2OjU3OjIzICswMTAwLA0KPiA+ID4gSmFtZXMgR293YW5zIDxqZ293
YW5zQGFtYXpvbi5jb20+IHdyb3RlOg0KPiA+ID4gPiAuLi4gYW5kIGVuYWJsZSB0aGF0IGZ1bmN0
aW9uYWxpdHkgZm9yIEdJQy12MyBvbmx5Lg0KPiA+ID4gDQo+ID4gPiBuaXQ6IGRyb3AgdGhlIG11
bHRpLWxpbmUgc3ViamVjdC4NCj4gPiANCj4gPiBXb3VsZCB5b3UgcHJlZmVyIHR3byBjb21taXRz
IC0gb25lIHRvIGludHJvZHVjZSB0aGUgZnVuY3Rpb25hbGl0eSBhbmQNCj4gPiBvbmUNCj4gPiB0
byBlbmFibGUgaXQgZm9yIEdJQy12Mz8NCj4gDQo+IEknZCBwcmVmZXIgdGhhdC4gSXQgaXMgaW4g
Z2VuZXJhbCBiZXR0ZXIgdG8gZGVjb3VwbGUgZHJpdmVyIHN0dWZmIGZyb20NCj4gY29yZSBjb2Rl
Lg0KDQpEb25lLCBuZXcgcmV2IHdpdGggY292ZXIgbGV0dGVyIGhlcmU6DQpodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sLzIwMjMwNjA4MTIwMDIxLjMyNzM0MDAtMS1qZ293YW5zQGFtYXpvbi5j
b20vDQpBbHNvIGFkZGVkIGRldGFpbGVkIHRlc3RpbmcgZGF0YSB0byB0aGUgY292ZXIgLSBJIGhv
cGUgdGhhdCdzDQp1c2VmdWwvY29ycmVjdC4NCg0KSnVzdCBvbmUgbW9yZSB0aGluZzogSSd2ZSBi
ZWVuIHRoaW5raW5nIGFib3V0IGl0IG1vcmUgYW5kIGFkbWl0IHRvIHN0aWxsDQpiZWluZyB1bnN1
cmUgb2YgdGhlIGp1c3RpZmljYXRpb24gZm9yIHdoZW4gd2Ugc3BlY2lmaWNhbGx5ICpkb24ndCog
d2FudA0KdGhlIHJlc2VuZCBmdW5jdGlvbmFsaXR5IHRvIGhhcHBlbjogdGhlIGp1c3RpZmljYXRp
b24gZm9yIGdhdGluZyBpdCBiZWhpbmQNCmEgZmxhZy4gVGhlIGV4YW1wbGUgeW91IGdhdmUgd2Fz
IGZvciBhIHdha2UtdXAgc291cmNlIHdoZXJlIGl0J3Mgbm90DQpkZXNpcmFibGUgZm9yIGEgd2Fr
ZXVwIHNvdXJjZSB0byBiZSByZXNlbnQuIEJ1dCBJIGRvbid0IHNlZSBob3cgdGhhdCBjYXNlDQpj
YW4gaGFwcGVuIGluIHByYWN0aWNlOiBlaXRoZXIgdGhhdCBpbnRlcnJ1cHQgd291bGQgbmV2ZXIg
Z2V0IHRvIHRoZQ0KaGFuZGxlX2Zhc3RfZW9pKCkgaGFuZGxlciAodGhlcmUncyBwcm9iYWJseSBu
byBoYW5kbGVyIHRvIHJ1biBmb3IgaXQ/KSBvcg0KaWYgaXQgZGlkIGl0IHdvdWxkIGxpa2VseSB1
c2UgZGlmZmVyZW50IHN0cnVjdCBpcnFfZGVzYyBwZXIgQ1BVIC0gdGhpcw0KcmFjZSB3b3VsZCBi
ZSBoaXQgYWxsIHRoZSB0aW1lIGlmIHdha2V1cCBzb3VyY2VzIHJhbiBoYW5kbGVycyBhbmQgc2hh
cmVkDQppcnFfZGVzYy4NCg0KV2UgaGF2ZSBzb21ldGhpbmcgdGhhdCB3b3JrcyBub3cgc28gSSdt
IGhhcHB5IHRvIGdvIHdpdGggdGhpcyAtIEkganVzdA0Kd2FudCB0byBwb2ludCBvdXQgdGhhdCBJ
J20gc3RpbGwgc3RydWdnbGluZyB0byBzZWUgd2hlbiBpdCB3b3VsZCBhY3R1YWxseQ0KYmUgd3Jv
bmcgdG8gYXBwbHkgdGhpcyByZXNlbmQgbG9naWMgdG8gYSB1c2VyIG9mIGhhbmRsZV9mYXN0X2Vv
aSgpLg0KDQpKRw0K
