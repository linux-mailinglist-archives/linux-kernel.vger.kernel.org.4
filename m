Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CE970DCE1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbjEWMrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjEWMrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:47:45 -0400
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D80DB
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 05:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1684846064; x=1716382064;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8v1ELZGYIdnnHBigd19DQw24xSRpH6GYKnjhm0hRl8k=;
  b=onig6hWDSL4gBO7RtbG6ju4uwYDz2vYygUyNu/PcwAQmDrnfMYeo09fr
   A6vtdRBMRLq5J6/BZyWSX4SXhiE17CLQ52PDdD4znnd1Hp9d15pPJT/VJ
   RDO3AN134oRke/ViZaD806KgqVaAVVLJGpXjflr655q7EKwBR6NDPN4JK
   U=;
X-IronPort-AV: E=Sophos;i="6.00,186,1681171200"; 
   d="scan'208";a="5191036"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 12:47:40 +0000
Received: from EX19D002EUC003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com (Postfix) with ESMTPS id 8D5A682B0D;
        Tue, 23 May 2023 12:47:37 +0000 (UTC)
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D002EUC003.ant.amazon.com (10.252.51.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 23 May 2023 12:47:36 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.026; Tue, 23 May 2023 12:47:36 +0000
From:   "Gowans, James" <jgowans@amazon.com>
To:     "maz@kernel.org" <maz@kernel.org>,
        "liaochang1@huawei.com" <liaochang1@huawei.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "zouyipeng@huawei.com" <zouyipeng@huawei.com>,
        "Raslan, KarimAllah" <karahmed@amazon.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sironi, Filippo" <sironi@amazon.de>,
        "chris.zjh@huawei.com" <chris.zjh@huawei.com>
Subject: Re: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
Thread-Topic: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
Thread-Index: AQHZjXTAqYD1RnLdPkODbZRG7pJCPA==
Date:   Tue, 23 May 2023 12:47:36 +0000
Message-ID: <605113d89cdf53ba1a5034bb15704da58a5336d7.camel@amazon.com>
References: <20230317095300.4076497-1-jgowans@amazon.com>
         <87h6tp5lkt.wl-maz@kernel.org>
         <0869847124f982c50d0f8d0ede996004f90a5576.camel@amazon.com>
         <86pm89kyyt.wl-maz@kernel.org>
         <7fdfb01590d8e502f384aa0bb0dc9c614caa5dfc.camel@amazon.com>
         <5a1fb95b57efbd6b6c2cea4a4e3ae5407fadeeb9.camel@amazon.com>
         <86sfcfghqh.wl-maz@kernel.org>
In-Reply-To: <86sfcfghqh.wl-maz@kernel.org>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.31.190.53]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A57DCC7569C4543B4C92ADF324E9E7A@amazon.com>
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

T24gVHVlLCAyMDIzLTA1LTAyIGF0IDExOjE3ICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IA0KPiBTb3JyeSBmb3IgdGhlIGRlbGF5LCBJJ3ZlIGJlZW4gdHJhdmVsbGluZyB0aGUgcGFzdCBj
b3VwbGUgb2Ygd2Vla3MuDQoNCk1lIHRvbyAtIGp1c3QgZ2V0dGluZyBiYWNrIHRvIHRoaXMgbm93
LiA6LSkNCj4gDQo+IE9uIFR1ZSwgMDIgTWF5IDIwMjMgMDk6NDM6MDIgKzAxMDAsDQo+ICJHb3dh
bnMsIEphbWVzIiA8amdvd2Fuc0BhbWF6b24uY29tPiB3cm90ZToNCj4gPiANCj4gPiA+IFRoaXMg
d2lsbCBydW4gY2hlY2tfaXJxX3Jlc2VuZCgpIG9uIHRoZSAqbmV3bHkgYWZmaW5lZCogQ1BVLCB3
aGlsZSB0aGUgb2xkDQo+ID4gPiBvbmUgaXMgc3RpbGwgcnVubmluZyB0aGUgb3JpZ2luYWwgaGFu
ZGxlci4gQUZBSUNUIHdoYXQgd2lsbCBoYXBwZW4gaXM6DQo+ID4gPiBjaGVja19pcnFfcmVzZW5k
DQo+ID4gPiAgIHRyeV9yZXRyaWdnZXINCj4gPiA+ICAgICBpcnFfY2hpcF9yZXRyaWdnZXJfaGll
cmFyY2h5DQo+ID4gPiAgICAgICBpdHNfaXJxX3JldHJpZ2dlcg0KPiA+ID4gLi4uIHdoaWNoIHdp
bGwgY2F1c2UgdGhlIElUUyB0byAqaW1tZWRpYXRlbHkqIHJlLXRyaWdnZXIgdGhlIElSUS4gVGhl
DQo+ID4gPiBvcmlnaW5hbCBDUFUgY2FuIHN0aWxsIGJlIHJ1bm5pbmcgdGhlIGhhbmRsZXIgaW4g
dGhhdCBjYXNlLg0KPiANCj4gSW1tZWRpYXRlbHkgaXMgYSByZWxhdGl2ZSB0aGluZy4gVGhlIEdJ
QyBwcm9jZXNzZXMgaW50ZXJydXB0cyBmYXINCj4gc2xvd2VyIHRoYW4gdGhlIENQVSBjYW4gaGFu
ZGxlIHRoZW0uDQoNCkFjayAtIEkndmUgdGVzdGVkIHdpdGggeW91ciBwYXRjaCBiZWxvdyBhbmQg
ZW1waXJpY2FsbHkgb24gbXkgc3lzdGVtIGl0DQpzZWVtcyB0aGF0IGEgcmVzZW5kIHN0b3JtIChy
dW5uaW5nIHJlc2VuZCBpbiBhIHRpZ2h0IGxvb3Agb24gdGhlIG5ldyBDUFUNCndoaWxlIHRoZSBv
cmlnaW5hbCBvbmUgaXMgc3RpbGwgc2xvd2x5IHJ1bm5pbmcgYSBoYW5kbGVyKSBjYXVzZXMNCmlu
dGVycnVwdHMgZ2V0IGRlbGl2ZXJlZCBhdCBwZXJpb2Qgb2YgYWJvdXQgNDAgwrVzLiBUaGF0IGlz
IGluZGVlZCBsZXNzDQoiaW1tZWRpYXRlbHkiIHRoYW4gaGFuZGxlcnMgKnR5cGljYWxseSogdGFr
ZS4NCg0KPiBZZXMsIHRoaXMgaXMgY2xlYXJseSBtaXNzaW5nIGZyb20gbXkgcGF0Y2gsIHRoYW5r
cyBmb3IgcG9pbnRpbmcgdGhpcw0KPiBvdXQuIEkgdGhpbmsgc29tZXRoaW5nIGxpa2UgdGhlIGhh
Y2sgYmVsb3cgc2hvdWxkIGhhbmRsZSBpdC4NCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvaXJx
L3Jlc2VuZC5jIGIva2VybmVsL2lycS9yZXNlbmQuYw0KPiBpbmRleCAwYzQ2ZTlmZTNhODkuLjVm
YTk2ODQyYTg4MiAxMDA2NDQNCj4gLS0tIGEva2VybmVsL2lycS9yZXNlbmQuYw0KPiArKysgYi9r
ZXJuZWwvaXJxL3Jlc2VuZC5jDQo+IEBAIC0xMTcsNyArMTE3LDggQEAgaW50IGNoZWNrX2lycV9y
ZXNlbmQoc3RydWN0IGlycV9kZXNjICpkZXNjLCBib29sIGluamVjdCkNCj4gICAgICAgICAgICAg
ICAgIHJldHVybiAtRUlOVkFMOw0KPiAgICAgICAgIH0NCj4gDQo+IC0gICAgICAgaWYgKGRlc2Mt
PmlzdGF0ZSAmIElSUVNfUkVQTEFZKQ0KPiArICAgICAgIGlmICgoZGVzYy0+aXN0YXRlICYgSVJR
U19SRVBMQVkpICYmDQo+ICsgICAgICAgICAgICFpcnFkX25lZWRzX3Jlc2VuZF93aGVuX2luX3By
b2dyZXNzKCZkZXNjLT5pcnFfZGF0YSkpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVCVVNZ
Ow0KPiANCj4gICAgICAgICBpZiAoIShkZXNjLT5pc3RhdGUgJiBJUlFTX1BFTkRJTkcpICYmICFp
bmplY3QpDQoNCkhhdmUgdGVzdGVkIHRoaXMgYW5kIGNvbmZpcm0gaXQgbWl0aWdhdGVzIHRoZSBp
c3N1ZS4NCg0KPiBJIHJlYWxseSB0aGluayB0aGF0IHdlIHdhbnQgdG8gbW92ZSBhd2F5IGZyb20g
dGhlIG9sZCBDUFUgYXNhcC4NCj4gSW1hZ2luZSB0aGUgZm9sbG93aW5nIGNhc2U6IHdlIHdhbnQg
dG8gdHVybiBhIENQVSBvZmYsIGFuZCBmb3IgdGhpcyB3ZQ0KPiBuZWVkIHRvIG1pZ3JhdGUgdGhl
IGludGVycnVwdHMgYXdheSBmcm9tIGl0LiBCdXQgdGhlIHNvdXJjZSBvZiB0aGUNCj4gaW50ZXJy
dXB0IGlzIGEgZ3Vlc3Qgd2hpY2gga2VlcHMgdGhlIGludGVycnVwdCBjb21pbmcsIGFuZCB0aGlz
IGNvdWxkDQo+IGF0IGxlYXN0IGluIHRoZW9yeSBkZWxheSB0aGUgb2ZmbGluaW5nIGluZGVmaW5p
dGVseS4NCg0KQWdyZWVkIC0ganVzdCBub3RlIHRoYXQgd2hldGhlciB3ZSBkbyB0aGUgaGFyZHdh
cmUtYXNzaXN0ZWQNCmlycV9yZXRyaWdnZXIoKSBiZWZvcmUgdGhlIGhhbmRsZXIgb24gdGhlIG5l
d2x5IGFmZmluZWQgQ1BVIChhcyB5b3VyIHBhdGNoDQpkb2VzKSBvciBhZnRlciB0aGUgaGFuZGxl
ciBvbiB0aGUgb2xkIENQVSAoYXMgbXkgb3JpZ2luYWwgcGF0Y2ggc3VnZ2VzdGVkKQ0KZG9lc24n
dCBtYWtlIGEgZGlmZmVyZW5jZSAtIGVpdGhlciB3YXkgdGhlIG5leHQgYWN0dWFsIGhhbmRsZXIg
cnVuIHdpbGwNCmhhcHBlbiBvbiB0aGUgbmV3bHkgYWZmaW5lZCBDUFUgYW5kIHdlIGdldCBvZmYg
dGhlIG9sZCBDUFUgZm9yIHRoZSBuZXh0DQpoYW5kbGVyIHJ1bnMuDQoNClRoZSBvbmx5IHRpbWUg
aXMgZG9lcyBtYWtlIGEgZGlmZmVyZW5jZSBpcyBpbiB0aGUgU1cgcmVzZW5kIGNhc2UgYnV0IGFz
DQp5b3UgcG9pbnQgb3V0Og0KDQo+IFdpdGggU1cgcmVzZW5kLCB0aGUgdGFza2xldCBzaG91bGQg
Z2V0IG1vdmVkIHRvIENQVXMgdGhhdCBhcmUgc3RpbGwNCj4gb25saW5lLCBhbmQgdGhlcmUgbWF5
IGJlIHNvbWUgYWRkaXRpb25hbCB3b3JrIHRvIGRvIGhlcmUuDQoNCj4gPiBKdXN0IGNoZWNraW5n
IHRvIHNlZSBpZiB5b3UndmUgaGFkIGEgY2hhbmNlIHRvIGNvbnNpZGVyIHRoZXNlDQo+ID4gaXNz
dWVzL3Rob3VnaHRzLCBhbmQgaWYvaG93IHRoZXkgc2hvdWxkIGJlIGhhbmRsZWQ/DQo+ID4gSSdt
IHN0aWxsIHRlbmRpbmcgdG93YXJkcyBzYXlpbmcgdGhhdCB0aGUgY2hlY2tfaXJxX3Jlc2VuZCgp
IHNob3VsZCBydW4NCj4gPiBhZnRlciBoYW5kbGVfaXJxX2V2ZW50KCkgYW5kIHRoZSBJUlFTX1BF
TkRJTkcgZmxhZyBzaG91bGQgYmUgd3JhbmdsZWQgdG8NCj4gPiBkZWNpZGUgd2hldGhlciBvciBu
b3QgdG8gcmVzZW5kLg0KPiANCj4gSSBzdGlsbCB0aGluayB0aGlzIGlzIHRoZSB3cm9uZyBhcHBy
b2FjaC4gVGhpcyBtaXhlcyB0aGUgcGVuZGluZyBhbmQNCj4gcmVwbGF5IHN0YXRlcywgd2hpY2gg
YXJlIHNpZ25pZmljYW50bHkgZGlmZmVyZW50IGluIHRoZSBJUlEgY29kZS4NCg0KT2theSwgVEJI
IEknbSBub3QgdG9vIHN1cmUgd2hhdCB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZXNlIHR3byBm
bGFncyBpcywNCnRoZSBjb21tZW50cyBvbiB0aGUgZW51bSB2YWx1ZXMgaXNuJ3QgdG9vIGRldGFp
bGVkLiBJIHdhcyBpbnNwaXJlZCBieQ0KaGFuZGxlX2VkZ2VfaXJxKCkgdG8gdXNlIHRoZSBJUlFf
UEVORElORy4gQW55IGlkZWEgd2h5IGl0J3MgY29ycmVjdCB0byB1c2UNCklSUV9QRU5ESU5HIHRo
ZXJlIGJ1dCBub3QgaGVyZT8gV2UgY291bGQgdHdlYWsgdGhpcyB0byB1c2UgdGhlIFJFUExBWSBm
bGFnDQphbmQgdXNlIHRoYXQgdG8gY29uZGl0aW9uYWxseSBydW4gY2hlY2tfaXJxX3Jlc2VuZCgp
IGFmdGVyIHRoZSBoYW5kbGVyLg0KDQo+IEkgZGVmaW5pdGVseSB3YW50IHRvIHNlZSBtb3JlIHRl
c3Rpbmcgb24gdGhpcywgYnV0IEknbSBub3Qgc3VyZSB0aGUgU1cNCj4gcmVzZW5kIHBhcnQgaXMg
dGhhdCBjcml0aWNhbC4gVGhlIGlzc3VlIGF0IGhhbmQgcmVhbGx5IGlzIGEgR0lDDQo+IHNwZWNp
ZmljIHByb2JsZW0uDQoNCkFjaywgSSdtIGFsc28gaGFwcHkgdG8gbm90IGJvdGhlciB3aXRoIHRo
ZSBTVyByZXNlbmQgY2FzZSB0b28gbXVjaC4gSnVzdA0KY3Jvc3MtcG9zdGluZyBmcm9tIHlvdXIg
b3RoZXIgZW1haWwgKHVuaWZ5aW5nIHRoZSB0aHJlYWRzKToNCg0KPiBJIGNvbnRlbmQgdGhhdCB0
aGlzIHJlYWxseSBpcyBhIEdJQ3YzIGFyY2hpdGVjdHVyYWwgYnVnLiBUaGUgbGFjayBvZg0KPiBh
biBhY3RpdmUgc3RhdGUgb24gTFBJcyBsZWFkcyB0byBpdCwgYW5kIGFzIGZhciBhcyBJIGNhbiB0
ZWxsLCBubw0KPiBvdGhlciBpbnRlcnJ1cHQgYXJjaGl0ZWN0dXJlIGhhcyB0aGUgc2FtZSBpc3N1
ZS4gU28gdGhlIG9udXMgc2hvdWxkIGJlDQo+IG9uIHRoZSBHSUMsIHRoZSBHSUMgb25seSwgYW5k
IG9ubHkgdGhlIHBhcnRzIG9mIHRoZSBHSUMgdGhhdCByZXF1aXJlDQo+IGl0IChTUElzLCBQUElz
IGFuZCBTR0lzIGFyZSBmaW5lLCBlaXRoZXIgYmVjYXVzZSB0aGV5IGhhdmUgYW4gYWN0aXZlDQo+
IHN0YXRlLCBvciBiZWNhdXNlIHRoZSBsb2NrIGlzbid0IGRyb3BwZWQgd2hlbiBjYWxsaW5nIHRo
ZSBoYW5kbGVyKS4NCg0KQWdhaW4gSSdtIGhhcHB5IHRvIGRlZmVyIHRvIHlvdSBoZXJlLiBJJ20g
c3RpbGwgbm90IHN1cmUgd2h5IHdlIHdvdWxkbid0DQpwcmVmZXIgdG8gc29sdmUgdGhpcyBpbiBh
IHdheSB0aGF0ICpkb2Vzbid0KiBuZWVkIGZsYWdzLCBhbmQgd2lsbCBqdXN0DQpuZXZlciBydW4g
Zm9yIGludGVycnVwdCBjb250cm9sbGVycyB3aGljaCBhcmUgbm90IGltcGFjdGVkPyBUaGF0IHNl
ZW1zDQpsaWtlIHdlIGNvdWxkIGhhdmUgc2ltcGxlciBjb2RlIHdpdGggbm8gZG93bnNpZGUuDQoN
CkpHDQoNCg==
