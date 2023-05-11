Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871726FFB5A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 22:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbjEKUgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 16:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239120AbjEKUgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 16:36:36 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F17A46A2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 13:36:33 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6D9612C048D;
        Fri, 12 May 2023 08:36:19 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1683837379;
        bh=CKDjlNfsjGnFKzF01l+hVl7cUi2WErjjOil8ZTO8U8o=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=b1FHNpRhP5/cdPETzz4Qy2ICJvoTSD8zbiwBWUOtLC6HukuzFeqqrirdiquf/j34t
         M1wImWBoecy3dmhWmxN/jx+KVd99wZLxK+6dqKzRw0bTd18UQN3kYJ6sFQVEzKfvu8
         lDOTg/MFnJoMx53PFrbB6OWItTWLmM4NjGguzGyb+t76DGLEpXGOBLeaoc0vcpTRrh
         ilArSe6m/cr/GgIxTVjxWw2kHF10HwIlfHGgz4c7X5g3o49PztHxOGQL1qVlzVQwUd
         fzUcPdTQVnbEFBl8L2PzGEYHPh0k8Fy8Dl3yRwal8tZnzS7Z99Ezaf2iN30lh4r/TI
         YD4RHkMn67PVA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B645d51c30001>; Fri, 12 May 2023 08:36:19 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Fri, 12 May 2023 08:36:19 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Fri, 12 May 2023 08:36:18 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Fri, 12 May 2023 08:36:18 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        Ben Brown <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH] gpiolib: Don't implicitly disable irq when masking
Thread-Topic: [PATCH] gpiolib: Don't implicitly disable irq when masking
Thread-Index: AQHZgtQLyOA2wo5swkyuf0Vo3SyOl69SVxQAgADekoCAALj2gIAA0wsA
Date:   Thu, 11 May 2023 20:36:18 +0000
Message-ID: <ab62b83e-0074-4c71-11d7-9aa6846a1eee@alliedtelesis.co.nz>
References: <20230510001151.3946931-1-chris.packham@alliedtelesis.co.nz>
 <ZFtK3DydE24Qijle@surfacebook>
 <760ae58f-cb0b-dfe6-9e24-664310651e18@alliedtelesis.co.nz>
 <CACRpkdb1UFQ=1gePeBBEQ3ODu+6m0dHBqaxdtOF9Qc01WytMEQ@mail.gmail.com>
In-Reply-To: <CACRpkdb1UFQ=1gePeBBEQ3ODu+6m0dHBqaxdtOF9Qc01WytMEQ@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <829E292AAD3DD144BB26208B5FC1BF44@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=EBvnk0w614hoTqdwZjwA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNCk9uIDExLzA1LzIzIDIwOjAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0KPiBP
biBXZWQsIE1heSAxMCwgMjAyMyBhdCAxMDo1OeKAr1BNIENocmlzIFBhY2toYW0NCj4gPENocmlz
LlBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4gd3JvdGU6DQo+DQo+PiBUaGUgY291cGxpbmcg
b2YgZ3Bpb2NoaXBfaXJxX21hc2soKS9ncGlvY2hpcF9pcnFfdW5tYXNrKCkgd2l0aA0KPj4gZ3Bp
b2NoaXBfZGlzYWJsZV9pcnEoKS9ncGlvY2hpcF9lbmFibGVfaXJxKCkgZ29lcyBiYWNrIHRvIHRo
ZSBzYW1lDQo+PiBjb21taXQgYTgxNzM4MjBmNDQxICgiZ3BpbzogZ3Bpb2xpYjogQWxsb3cgR1BJ
TyBJUlFzIHRvIGxhenkgZGlzYWJsZSIpLg0KPj4gSXQncyBub3QgaW1tZWRpYXRlbHkgb2J2aW91
cyB0byBtZSB3aHkgdGhlIGNvdXBsaW5nIGlzIG5lZWRlZC4NCj4gVGhhdCBpcyBqdXN0IGEgcmVm
YWN0b3Jpbmcgb2Ygd2hhdCBleGlzdGVkIGJlZm9yZS4NCj4NCj4gVGhlIHVzZSBjYXNlIGlzIGhl
cmU6DQo+IGRyaXZlcnMvbWVkaWEvY2VjL3BsYXRmb3JtL2NlYy1ncGlvL2NlYy1ncGlvLmMNCj4N
Cj4gVGhlIGRyaXZlciBuZWVkcyB0byBzd2l0Y2gsIGF0IHJ1bnRpbWUsIGJldHdlZW4gYWN0aXZl
bHkgZHJpdmluZyBhIEdQSU8NCj4gbGluZSB3aXRoIGdwaW9kX3NldF92YWx1ZSgpLCBhbmQgc2V0
dGluZyB0aGUgc2FtZSBsaW5lIGludG8gaW5wdXQgbW9kZQ0KPiBhbmQgbGlzdGVuaW5nIGZvciBz
aWduYWxsaW5nIHRyaWdnZXJpbmcgSVJRcyBvbiBpdCwgYW5kIHRoZW4gYmFjayB0bw0KPiBvdXRw
dXQgbW9kZSBhbmQgZHJpdmluZyB0aGUgbGluZSBhZ2Fpbi4gSXQncyBhIGJpZGlyZWN0aW9uYWwg
R1BJTyBsaW5lLg0KPiBUaGlzIHVzZSBjYXNlIHlpZWxkcyBhIGhpZ2ggbmVlZCBvZiBjb250cm9s
Lg0KPg0KPj4gSSB3YXMNCj4+IGhvcGluZyB0aGF0IHNvbWVvbmUgc2VlaW5nIG15IHBhdGNoIHdv
dWxkIGNvbmZpcm0gdGhhdCBpdCdzIG5vdCBuZWVkZWQNCj4+IG9yIHNheSB3aHkgaXQncyBuZWVk
ZWQgc3VnZ2VzdCBhbiBhbHRlcm5hdGl2ZSBhcHByb2FjaC4NCj4gV2hpY2ggSVJRLWVuYWJsZWQg
Z3Bpb2NoaXAgaXMgdGhpcz8gSGFzIGl0IGJlZW4gY29udmVydGVkIHRvIGJlIGltbXV0YWJsZT8N
Cj4gSSB0aGluayB0aGF0IGNvdWxkIGJlIHBhcnQgb2YgdGhlIHByb2JsZW0uDQoNCkZvciBtZSBp
dCdzIGEgcGNhOTU1NS4gSSBzcGVudCB5ZXN0ZXJkYXkgdHJ5aW5nIHRvIGRlbW9uc3RyYXRlIHRo
ZSANCnByb2JsZW0gb24gYSBuZXdlciBrZXJuZWwuIFNvbWUgdGVldGhpbmcgaXNzdWVzIGFzaWRl
IEkgY2FuIHRyaWdnZXIgdGhlIA0Kd2FybmluZyBpZiBJIGhhdmUgYSBncGlvLWJ1dHRvbiB1c2lu
ZyBvbmUgb2YgdGhlIHBjYTk1NTUgcGlucyBhcyBhbiANCmludGVycnVwdCBhbmQgdGhlbiBJIGV4
cG9ydCBzb21lIG9mIHRoZSBvdGhlciBwaW5zIHZpYSBzeXNmcy4NCg0KSW50ZXJlc3RpbmdseSB0
aGUgd2FybmluZyBpc24ndCB0cmlnZ2VyZWQgaWYgSSB1c2UgYSBncGlvLWhvZyBpbnN0ZWFkIG9m
IA0KZXhwb3J0aW5nIHRoZSBwaW5zLiBJIGhhdmVuJ3QgZmlndXJlZCBvdXQgd2h5IHRoYXQgaXMg
YnV0IEknbSBhc3N1bWluZyANCml0J3Mgc29tZXRoaW5nIHRvIGRvIHdpdGggdGhlIGhvZ2dlZCBw
aW5zIGJlaW5nIGV4Y2x1ZGVkIGZyb20gdGhlIGlycSANCmRvbWFpbiBiZWZvcmUgaXQgaXMgcmVn
aXN0ZXJlZC4NCg==
