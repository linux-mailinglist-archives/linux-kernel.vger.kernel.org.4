Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDA3722C3D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbjFEQK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjFEQK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:10:57 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0D994
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 09:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685981457; x=1717517457;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kiK49FwbMBS76QFP/MguH9fBOQjELpcrLBjTVS4hhEk=;
  b=D/sdQEMkSFP8aZ0z35/Caq5pSGxwkpGA+75T3Es61b7oXxmoPkmXEzu4
   N5fvBg2jtKmlT56R95TY72c4ko+Vc1ziqu8nhbGQnpYPiW8jxFnyEytiD
   kMIw85RfBSRIqR194hpl1qQrEs2RMAfBaFrFuRF2yjQCTC6/jy0S00m3F
   I=;
X-IronPort-AV: E=Sophos;i="6.00,217,1681171200"; 
   d="scan'208";a="289733476"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 16:10:55 +0000
Received: from EX19D001EUB004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com (Postfix) with ESMTPS id 41D89C0158;
        Mon,  5 Jun 2023 16:10:53 +0000 (UTC)
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D001EUB004.ant.amazon.com (10.252.51.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 5 Jun 2023 16:10:52 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.026; Mon, 5 Jun 2023 16:10:51 +0000
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
Thread-Index: AQHZlFolsBpe8L2DYUen+rvhN7X1hK98Z90A
Date:   Mon, 5 Jun 2023 16:10:51 +0000
Message-ID: <f52edf70042b67f8b6306ca6f8be72ff569ee5ff.camel@amazon.com>
References: <20230530213848.3273006-1-jgowans@amazon.com>
         <20230530213848.3273006-2-jgowans@amazon.com>
         <867cspc7e2.wl-maz@kernel.org>
         <3903a508c15e7a75b6d637c8523c3bae13d6a7af.camel@amazon.com>
In-Reply-To: <3903a508c15e7a75b6d637c8523c3bae13d6a7af.camel@amazon.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.227]
Content-Type: text/plain; charset="utf-8"
Content-ID: <98C67C9D6620FD4180B8DC2DF3C7122A@amazon.com>
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

SGkgTWFyYywNCg0KT24gVGh1LCAyMDIzLTA2LTAxIGF0IDA5OjI0ICswMjAwLCBKYW1lcyBHb3dh
bnMgd3JvdGU6DQo+IFdoaWxlIEknbSBnbGFkIHRoYXQgeW91IGV2ZW50dWFsbHkgZGVjaWRlZCB0
byB1c2UgdGhlIHJlc2VuZCBtZWNoYW5pc20NCj4gPiBpbnN0ZWFkIG9mIHNwaW5uaW5nIG9uIHRo
ZSAib2xkIiBDUFUsIEkgc3RpbGwgdGhpbmsgaW1wb3NpbmcgdGhpcw0KPiA+IGJlaGF2aW91ciBv
biBhbGwgdXNlcnMgd2l0aG91dCBhbnkgZGlzY3JpbWluYXRpb24gaXMgd3JvbmcuDQo+ID4gDQo+
ID4gTG9vayBhdCB3aGF0IGl0IGRvZXMgaWYgYW4gaW50ZXJydXB0IGlzIGEgd2FrZS11cCBzb3Vy
Y2UuIFlvdSdkDQo+ID4gcG9pbnRsZXNzbHkgcmVxdWV1ZSB0aGUgaW50ZXJydXB0IChib251cyBw
b2ludHMgaWYgdGhlIGlycWNoaXAgZG9lc24ndA0KPiA+IHByb3ZpZGUgYSBIVy1iYXNlZCByZXRy
aWdnZXIgbWVjaGFuaXNtKS4NCj4gPiANCj4gPiBJIHN0aWxsIG1haW50YWluIHRoYXQgdGhpcyBj
aGFuZ2Ugc2hvdWxkIG9ubHkgYmUgYXBwbGllZCBmb3IgdGhlDQo+ID4gcGFydGljdWxhciBpbnRl
cnJ1cHRzIHRoYXQgKnJlcXVpcmUqIGl0LCBhbmQgbm90IGFzIGEgYmxhbmtldCBjaGFuZ2UNCj4g
PiBhZmZlY3RpbmcgZXZlcnl0aGluZyB1bmRlciB0aGUgc3VuLiBJIGhhdmUgcHJvcG9zZWQgc3Vj
aCBhIGNoYW5nZSBpbg0KPiA+IHRoZSBwYXN0LCBmZWVsIGZyZWUgdG8gdXNlIGl0IG9yIHJvbGwg
eW91ciBvd24uDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBleGFtcGxlIG9mIHdoZXJlIHRoaXMgYmxh
bmtldCBmdW5jdGlvbmFsaXR5IHdvdWxkbid0IGJlDQo+IGRlc2lyZWQgLSBJJ2xsIHJlLXdvcmsg
dGhpcyB0byBpbnRyb2R1Y2UgYW5kIHVzZQ0KPiB0aGUgSVJRRF9SRVNFTkRfV0hFTl9JTl9QUk9H
UkVTUyBmbGFnIGFzIHlvdSBvcmlnaW5hbGx5IHN1Z2dlc3RlZC4NCj4gDQo+IEp1c3Qgb25lIG1v
cmUgdGhpbmcgYmVmb3JlIEkgcG9zdCBWMzogYXJlIHlvdSBva2F5IHdpdGggZG9pbmcgdGhlIHJl
c2VuZA0KPiBoZXJlICphZnRlciogdGhlIGhhbmRsZXIgZmluaXNoZWQgcnVubmluZywgYW5kIHVz
aW5nIHRoZSBJUlFfUEVORElORyBmbGFnDQo+IHRvIGtub3cgdG8gcmVzZW5kIGl0PyBPciB3b3Vs
ZCB5b3UgbGlrZSBpdCB0byBiZSByZXNlbnQgaW4NCj4gdGhlICFpcnFfbWF5X3J1bihkZXNjKSBi
bG9jayBhcyB5b3Ugc3VnZ2VzdGVkPw0KPiANCj4gSSBoYXZlIGEgc2xpZ2h0IHByZWZlcmVuY2Ug
dG8gZG8gaXQgYWZ0ZXIsIG9ubHkgd2hlbiB3ZSBrbm93IGl0J3MgcmVhZHkgdG8NCj4gYmUgcnVu
IGFnYWluLCBhbmQgaGVuY2Ugbm90IG5lZWRlZCB0byBtb2RpZnkgY2hlY2tfaXJxX3Jlc2VuZCgp
IHRvIGNhdGVyDQo+IGZvciBtdWx0aXBsZSByZXRyaWVzLg0KDQpIb3BpbmcvYXNzdW1pbmcgdGhh
dCB5b3UncmUgb2theSB3aXRoIHRoZSBrZWVwaW5nIHRoZSByZXNlbmQgYXQgdGhlIGVuZCBvZg0K
dGhlIGZ1bmN0aW9uLCBoZXJlJ3MgVjM6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIw
MjMwNjA1MTU1NzIzLjI2MjgwOTctMi1qZ293YW5zQGFtYXpvbi5jb20vDQoNCkl0J3Mgbm93IHZl
cnkgY2xvc2UgdG8gd2hhdCB0byBzdWdnZXN0ZWQgb3JpZ2luYWxseS4gOi0pDQoNCk9uZSB0aGlu
ZzogSSdtIG5vdCB0b3RhbGx5IHN1cmUgdGhhdCBpdCdzIG5lY2Vzc2FyeSBvciBjb3JyZWN0IHRv
IHNldCB0aGlzDQpmbGFnIG9uIGl0c192cGVfaXJxX2RvbWFpbl9hbGxvYygpIHRvbyAtIG9uIG15
IHN5c3RlbSAocjZnLm1ldGFsIEdyYXZpdG9uDQoyIGhvc3QpIHRoYXQgZG9lc24ndCBzZWVtIHRv
IGJlIHJ1bi4gTXkgZ3Vlc3MgaXMgdGhhdCBpdCdzIGZvciBhIEdJQy12NA0Kc3lzdGVtIHdoaWNo
IHN1cHBvcnRzIHBvc3RlZCBpbnRlcnJ1cHQgd2hpY2ggZ2VuZXJhbGx5IGdldCBkZWxpdmVyeQ0K
ZGlyZWN0bHkgdG8gdGhlIHZDUFUgaWYgcnVubmluZywgYnV0IHNvbWV0aW1lcyBuZWVkIHRvIGJl
IGRlbGl2ZXJlZCB0byB0aGUNCmh5cGVydmlzb3IgKGZvciBleGFtcGxlIGlmIHZDUFUgbm90IHJ1
bm5pbmcpLiBJIGNhbiB0cnkgdGVzdCB0aGlzIG9uDQpyN2cubWV0YWwgd2hpY2ggbWlnaHQgaGF2
ZSBHSUMtdjQgdG8gYmUgc3VyZS4uLg0KDQpKRw0K
