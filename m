Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F4F6FFF6D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 05:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239752AbjELDu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 23:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjELDuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 23:50:22 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A3249F9
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 20:50:19 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6ECD82C0405;
        Fri, 12 May 2023 15:50:06 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1683863406;
        bh=83GyqPLN+YuXrLcamGd08y0UPBixW/uxDKMNvZerhSE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=CCMfgnxqI6yVkrQ5iZuLDBVePNEHxem5ZMd4dl2E2oR+QZBPRpgOP8QnaP4FvAgxf
         2S/tFqIgB9yDfJW0VEkuFO+s3MuClQQiBkBVCZMhpUuoY8VN6zArLocDAkmoJXZJxB
         nVsGQ+2V+2ws4QGMEaHI5qYEr4jTLS2o/a/FQgmLm9VszsCSPfnNzV3laXaO4z5U0t
         NG8F2Ja3F2BA1bbJv8U12dn9yPxgshE80taOHUdU4gd5Po5ZcmUtwafNZ0ZclVOWvx
         sa1zZr101ORlUhzHId+14MCUVECDywDXhkH8I076uEBbRwDH8Z42KQsOkjQVrEUDsm
         UQd+l/NTeM8Qg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B645db76e0001>; Fri, 12 May 2023 15:50:06 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Fri, 12 May 2023 15:50:06 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Fri, 12 May 2023 15:50:05 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Fri, 12 May 2023 15:50:05 +1200
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
Thread-Index: AQHZgtQLyOA2wo5swkyuf0Vo3SyOl69SVxQAgADekoCAALj2gIAA0wsAgAB5M4A=
Date:   Fri, 12 May 2023 03:50:05 +0000
Message-ID: <334a8efc-003b-3971-41bc-4783a6fa5e30@alliedtelesis.co.nz>
References: <20230510001151.3946931-1-chris.packham@alliedtelesis.co.nz>
 <ZFtK3DydE24Qijle@surfacebook>
 <760ae58f-cb0b-dfe6-9e24-664310651e18@alliedtelesis.co.nz>
 <CACRpkdb1UFQ=1gePeBBEQ3ODu+6m0dHBqaxdtOF9Qc01WytMEQ@mail.gmail.com>
 <ab62b83e-0074-4c71-11d7-9aa6846a1eee@alliedtelesis.co.nz>
In-Reply-To: <ab62b83e-0074-4c71-11d7-9aa6846a1eee@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE8062AF8B871F438F07F9274E6E35D6@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=5Ip8V5-vLxe71PKaftUA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMi8wNS8yMyAwODozNiwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4gSGkgTGludXMsDQo+
DQo+IE9uIDExLzA1LzIzIDIwOjAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0KPj4gT24gV2VkLCBN
YXkgMTAsIDIwMjMgYXQgMTA6NTnigK9QTSBDaHJpcyBQYWNraGFtDQo+PiA8Q2hyaXMuUGFja2hh
bUBhbGxpZWR0ZWxlc2lzLmNvLm56PiB3cm90ZToNCj4+DQo+Pj4gVGhlIGNvdXBsaW5nIG9mIGdw
aW9jaGlwX2lycV9tYXNrKCkvZ3Bpb2NoaXBfaXJxX3VubWFzaygpIHdpdGgNCj4+PiBncGlvY2hp
cF9kaXNhYmxlX2lycSgpL2dwaW9jaGlwX2VuYWJsZV9pcnEoKSBnb2VzIGJhY2sgdG8gdGhlIHNh
bWUNCj4+PiBjb21taXQgYTgxNzM4MjBmNDQxICgiZ3BpbzogZ3Bpb2xpYjogQWxsb3cgR1BJTyBJ
UlFzIHRvIGxhenkgZGlzYWJsZSIpLg0KPj4+IEl0J3Mgbm90IGltbWVkaWF0ZWx5IG9idmlvdXMg
dG8gbWUgd2h5IHRoZSBjb3VwbGluZyBpcyBuZWVkZWQuDQo+PiBUaGF0IGlzIGp1c3QgYSByZWZh
Y3RvcmluZyBvZiB3aGF0IGV4aXN0ZWQgYmVmb3JlLg0KPj4NCj4+IFRoZSB1c2UgY2FzZSBpcyBo
ZXJlOg0KPj4gZHJpdmVycy9tZWRpYS9jZWMvcGxhdGZvcm0vY2VjLWdwaW8vY2VjLWdwaW8uYw0K
Pj4NCj4+IFRoZSBkcml2ZXIgbmVlZHMgdG8gc3dpdGNoLCBhdCBydW50aW1lLCBiZXR3ZWVuIGFj
dGl2ZWx5IGRyaXZpbmcgYSBHUElPDQo+PiBsaW5lIHdpdGggZ3Bpb2Rfc2V0X3ZhbHVlKCksIGFu
ZCBzZXR0aW5nIHRoZSBzYW1lIGxpbmUgaW50byBpbnB1dCBtb2RlDQo+PiBhbmQgbGlzdGVuaW5n
IGZvciBzaWduYWxsaW5nIHRyaWdnZXJpbmcgSVJRcyBvbiBpdCwgYW5kIHRoZW4gYmFjayB0bw0K
Pj4gb3V0cHV0IG1vZGUgYW5kIGRyaXZpbmcgdGhlIGxpbmUgYWdhaW4uIEl0J3MgYSBiaWRpcmVj
dGlvbmFsIEdQSU8gbGluZS4NCj4+IFRoaXMgdXNlIGNhc2UgeWllbGRzIGEgaGlnaCBuZWVkIG9m
IGNvbnRyb2wuDQo+Pg0KPj4+IEkgd2FzDQo+Pj4gaG9waW5nIHRoYXQgc29tZW9uZSBzZWVpbmcg
bXkgcGF0Y2ggd291bGQgY29uZmlybSB0aGF0IGl0J3Mgbm90IG5lZWRlZA0KPj4+IG9yIHNheSB3
aHkgaXQncyBuZWVkZWQgc3VnZ2VzdCBhbiBhbHRlcm5hdGl2ZSBhcHByb2FjaC4NCj4+IFdoaWNo
IElSUS1lbmFibGVkIGdwaW9jaGlwIGlzIHRoaXM/IEhhcyBpdCBiZWVuIGNvbnZlcnRlZCB0byBi
ZSANCj4+IGltbXV0YWJsZT8NCj4+IEkgdGhpbmsgdGhhdCBjb3VsZCBiZSBwYXJ0IG9mIHRoZSBw
cm9ibGVtLg0KPg0KPiBGb3IgbWUgaXQncyBhIHBjYTk1NTUuIEkgc3BlbnQgeWVzdGVyZGF5IHRy
eWluZyB0byBkZW1vbnN0cmF0ZSB0aGUgDQo+IHByb2JsZW0gb24gYSBuZXdlciBrZXJuZWwuIFNv
bWUgdGVldGhpbmcgaXNzdWVzIGFzaWRlIEkgY2FuIHRyaWdnZXIgDQo+IHRoZSB3YXJuaW5nIGlm
IEkgaGF2ZSBhIGdwaW8tYnV0dG9uIHVzaW5nIG9uZSBvZiB0aGUgcGNhOTU1NSBwaW5zIGFzIA0K
PiBhbiBpbnRlcnJ1cHQgYW5kIHRoZW4gSSBleHBvcnQgc29tZSBvZiB0aGUgb3RoZXIgcGlucyB2
aWEgc3lzZnMuDQo+DQo+IEludGVyZXN0aW5nbHkgdGhlIHdhcm5pbmcgaXNuJ3QgdHJpZ2dlcmVk
IGlmIEkgdXNlIGEgZ3Bpby1ob2cgaW5zdGVhZCANCj4gb2YgZXhwb3J0aW5nIHRoZSBwaW5zLiBJ
IGhhdmVuJ3QgZmlndXJlZCBvdXQgd2h5IHRoYXQgaXMgYnV0IEknbSANCj4gYXNzdW1pbmcgaXQn
cyBzb21ldGhpbmcgdG8gZG8gd2l0aCB0aGUgaG9nZ2VkIHBpbnMgYmVpbmcgZXhjbHVkZWQgZnJv
bSANCj4gdGhlIGlycSBkb21haW4gYmVmb3JlIGl0IGlzIHJlZ2lzdGVyZWQuDQoNCkknbSBzdGFy
dGluZyB0byB1bmRlcnN0YW5kIHRoaW5ncy4NCg0KV2hlbiB0aGUgZ3BpbyBpcyBleHBvcnRlZCB0
byB1c2VybGFuZCB0aGUgaXJxX2Rlc2MgaXMgY3JlYXRlZCB2aWEgDQpkZXZpY2VfYWRkKCkvZ3Bp
b19pc192aXNpYmxlKCkvZ3Bpb2RfdG9faXJxKCkvZ3Bpb2NoaXBfdG9faXJxKCkuIEkgdGhpbmsg
DQp0aGF0IG1pZ2h0IGJlIGEgYnVnIGJlY2F1c2UgaWYgdGhlIHVzZXIgd2FudGVkIGFuIGludGVy
cnVwdCB0aGV5IHdvdWxkIA0KaGF2ZSBzYWlkIHNvIHZpYSBlZGdlX3N0b3JlKCkgd2hpY2ggYWxz
byBkb2VzIHRoZSBncGlvZF90b19pcnEoKSB0aGF0IA0KdWx0aW1hdGVseSBjcmVhdGVzIHRoZSBp
cnFfZGVzYy4gSGF2aW5nIHRoZSBncGlvIHR1cm5lZCBpbnRvIGFuIA0KaW50ZXJydXB0IHNlZW1z
IGxpa2UgYW4gb2RkIHNpZGUtZWZmZWN0IG9mIGdwaW9faXNfdmlzaWJsZSgpLg0K
