Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8E56FE5E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbjEJU73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbjEJU70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:59:26 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B93A35B8
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:59:05 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 635D02C04E0;
        Thu, 11 May 2023 08:58:58 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1683752338;
        bh=l4vbyLqH2z50M4ot1jUVGa5ma88HP2zRrlQecjZ+xWQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=t57ZKwYETDAFYUdN/JAy+ee4pd1oKvakapB/i9QkVZbV8rkfJnbU6VsuIvaizdb9k
         FvuZhHN1QOEdRNp5B9PqVhzr/BZPF3433fHdlfaRb5Uwy1Ni0XhvTA0mcrpJWlpD4q
         ZeI3Aftaj+f3VX+YJZb5Lvd7HPN44sZaUGliaPnJyfw7HSceG7OFJw0O/Vqwgm8Mw7
         Z9vxSLSSp6cHJ680lAvC/RJcL3pMwLsITHOeTapXXiry+jY460P0PxrgdokAamJpXC
         R09udLzwKUHuXjpPP10VY/8zpWH5FeAxBgLxTYTZSHavDjTIQ7qlYm5DdQLSk0K7KL
         q/61qdqHHJ/7w==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B645c05920001>; Thu, 11 May 2023 08:58:58 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 11 May 2023 08:58:58 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Thu, 11 May 2023 08:58:58 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        Ben Brown <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] gpiolib: Don't implicitly disable irq when masking
Thread-Topic: [PATCH] gpiolib: Don't implicitly disable irq when masking
Thread-Index: AQHZgtQLyOA2wo5swkyuf0Vo3SyOl69SVxQAgADekoA=
Date:   Wed, 10 May 2023 20:58:57 +0000
Message-ID: <760ae58f-cb0b-dfe6-9e24-664310651e18@alliedtelesis.co.nz>
References: <20230510001151.3946931-1-chris.packham@alliedtelesis.co.nz>
 <ZFtK3DydE24Qijle@surfacebook>
In-Reply-To: <ZFtK3DydE24Qijle@surfacebook>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <79A374CA8C0CF64B8C235100AF500C16@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=fJAoSiaRUxuVBzyPri8A:9 a=QEXdDO2ut3YA:10 a=uYmH_lBRNJ4A:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwNCg0KT24gMTAvMDUvMjMgMTk6NDIsIGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20g
d3JvdGU6DQo+IFdlZCwgTWF5IDEwLCAyMDIzIGF0IDEyOjExOjUxUE0gKzEyMDAsIENocmlzIFBh
Y2toYW0ga2lyam9pdHRpOg0KPj4gV2hlbiBwcmVwYXJpbmcgdG8ga2V4ZWMgaW50byBhIG5ldyBr
ZXJuZWwgdGhlIGtleGVjIGNvZGUgd2lsbCBtYXNrIGFsbA0KPj4gaW50ZXJydXB0cyBmb3IgYWxs
IGludGVycnVwdCBkb21haW5zIGJlZm9yZSBkaXNhYmxpbmcgdGhlbS4gSW4gdGhlIGNhc2UNCj4+
IG9mIGEgZ3BpbyBjaGlwIHdoaWNoIGhhcyBhIG1peCBvZiBncGlvIGFuZCBpcnEgcGlucyBhIHdh
cm5pbmcgd291bGQgYmUNCj4+IHRyaWdnZXJlZCBhcyBmb2xsb3dzDQo+PiAgICBbcm9vdEBsb2Nh
bGhvc3Qgfl0jIGVjaG8gYyA+L3Byb2Mvc3lzcnEtdHJpZ2dlcg0KPiBCZXNpZGVzIHRoZSB2ZXJ5
IG5vaXN5IHRyYWNlYmFjayBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgKHJlYWQNCj4gaHR0cHM6Ly9r
ZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5odG1s
I2JhY2t0cmFjZXMtaW4tY29tbWl0LW1lc3NhZ2VzKQ0KPiBzZWUgYmVsb3cuDQo+DQo+PiBUaGlz
IGlzIGJlY2F1c2UgZ3Bpb2NoaXBfaXJxX21hc2sgd2FzIGJlaW5nIHVzZWQgdG8gbWFzayBhbGwg
cG9zc2libGUNCj4gV2UgcmVmZXIgdG8gdGhlIGZ1bmN0aW9ucyBpbiB0aGUgZm9ybSBhcyBmb2xs
b3dzIGdwaW9jaGlwX2lycV9tYXNrKCkuDQo+DQo+DQo+PiBpcnFzIGluIHRoZSBkb21haW4gYnV0
IGdwaW9jaGlwX2Rpc2FibGVfaXJxIHdpbGwgV0FSTiBpZiBhbnkgb2YgdGhvc2UNCj4gSVJRcw0K
PiBncGlvY2hpcF9kaXNhYmxlX2lycSgpDQo+DQo+PiBncGlvcyBoYXZlbid0IGJlZW4gcmVxdWVz
dGVkIGFzIGludGVycnVwdHMgeWV0LiBSZW1vdmUgdGhlIGNhbGwgdG8NCj4gR1BJT3MNCj4NCj4+
IGdwaW9jaGlwX2Rpc2FibGVfaXJxIHRvIHN0b3AgdGhlIHdhcm5pbmcuDQo+IGdwaW9jaGlwX2Rp
c2FibGVfaXJxKCkNCldpbGwgdGFrZSB0aGUgYWJvdmUgcG9pbnRzIG9uYm9hcmQgZm9yIHYyLg0K
Pg0KPj4gRml4ZXM6IGE4MTczODIwZjQ0MSAoImdwaW86IGdwaW9saWI6IEFsbG93IEdQSU8gSVJR
cyB0byBsYXp5IGRpc2FibGUiKQ0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hy
aXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvZ3Bp
by9ncGlvbGliLmMgfCAxIC0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncGlvL2dwaW9saWIuYyBiL2RyaXZlcnMvZ3Bpby9n
cGlvbGliLmMNCj4+IGluZGV4IDhjMDQxYThkZDlkOC4uOTAzZjUxODVhZTU1IDEwMDY0NA0KPj4g
LS0tIGEvZHJpdmVycy9ncGlvL2dwaW9saWIuYw0KPj4gKysrIGIvZHJpdmVycy9ncGlvL2dwaW9s
aWIuYw0KPj4gQEAgLTE0NTEsNyArMTQ1MSw2IEBAIHN0YXRpYyB2b2lkIGdwaW9jaGlwX2lycV9t
YXNrKHN0cnVjdCBpcnFfZGF0YSAqZCkNCj4+ICAgDQo+PiAgIAlpZiAoZ2MtPmlycS5pcnFfbWFz
aykNCj4+ICAgCQlnYy0+aXJxLmlycV9tYXNrKGQpOw0KPj4gLQlncGlvY2hpcF9kaXNhYmxlX2ly
cShnYywgZC0+aHdpcnEpOw0KPj4gICB9DQo+IEF0IHRoZSBzYW1lIHRpbWUgdGhlIGdwaW9jaGlw
X2lycV91bm1hc2soKSBoYXMgdGhlIHN5bW1ldHJpY2FsIGNhbGwuIFdoeT8NCg0KSG1tIHlvdSdy
ZSByaWdodCBJIG5ldmVyIG5vdGljZWQgdGhhdC4gSSB0aGluayB0aGF0IHdvdWxkIGFsc28gdHJp
Z2dlciBhIA0Kc2ltaWxhciB3YXJuaW5nIGlmIGl0IHdlcmUgZXZlciBoaXQuIEl0J3Mgbm90IGhp
dCBpbiBteSB1c2UtY2FzZSBiZWNhdXNlIA0Kbm90aGluZyBpcyBydW5uaW5nIHRocm91Z2ggYWxs
IHRoZSBpcnEgZG9tYWlucyB1bm1hc2tpbmcgaW50ZXJydXB0cy4NCg0KVGhlIGNvdXBsaW5nIG9m
IGdwaW9jaGlwX2lycV9tYXNrKCkvZ3Bpb2NoaXBfaXJxX3VubWFzaygpIHdpdGggDQpncGlvY2hp
cF9kaXNhYmxlX2lycSgpL2dwaW9jaGlwX2VuYWJsZV9pcnEoKSBnb2VzIGJhY2sgdG8gdGhlIHNh
bWUgDQpjb21taXQgYTgxNzM4MjBmNDQxICgiZ3BpbzogZ3Bpb2xpYjogQWxsb3cgR1BJTyBJUlFz
IHRvIGxhenkgZGlzYWJsZSIpLiANCkl0J3Mgbm90IGltbWVkaWF0ZWx5IG9idmlvdXMgdG8gbWUg
d2h5IHRoZSBjb3VwbGluZyBpcyBuZWVkZWQuIEkgd2FzIA0KaG9waW5nIHRoYXQgc29tZW9uZSBz
ZWVpbmcgbXkgcGF0Y2ggd291bGQgY29uZmlybSB0aGF0IGl0J3Mgbm90IG5lZWRlZCANCm9yIHNh
eSB3aHkgaXQncyBuZWVkZWQgc3VnZ2VzdCBhbiBhbHRlcm5hdGl2ZSBhcHByb2FjaC4NCg0KPiBB
bHNvIGl0J3Mgb2J2aW91cyB0aGF0IHlvdSBoYXZlIHVzZWQgb3V0ZGF0ZWQgcmVwb3NpdG9yeS4g
WW91IG5lZWQgdG8gcmViYXNlDQo+IGFnYWluc3Qgc3Vic3lzdGVtIHRyZWUgZm9yLW5leHQgYnJh
bmNoLg0KWWVhaCB0aGF0J3MgdGhlIHRyaWNreSBwYXJ0LiBJJ20gY3VycmVudGx5IGJhc2VkIG9u
IGx0cy01LjE1IGFuZCBpbiANCm9yZGVyIHRvIGFjdHVhbGx5IHRlc3QgdGhpcyBJIG5lZWQgYWxs
IG9mIHRoZSBzdXBwb3J0IGZvciBteSBwbGF0Zm9ybSBzbyANCkkgY2FuIHVzZSBrZHVtcCB0byBk
ZW1vbnN0cmF0ZSB0aGUgaXNzdWUuIEkgbWlnaHQgYmUgYWJsZSB0byB1c2UgYSANCmRpZmZlcmVu
dCBwbGF0Zm9ybSB0aGF0IGlzIGFscmVhZHkgc3VwcG9ydGVkIGluIGEgbmV3ZXIga2VybmVsDQo+
DQo+IFAuUy4gSXQncyBhbHNvIG1ha2VzIHNlbnNlIHRvIENjIHRvIE1hcmMgWnluZ2llciA8bWF6
QGtlcm5lbC5vcmc+Lg0KPg0KQWRkZWQu
