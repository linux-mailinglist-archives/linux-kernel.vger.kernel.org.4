Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2135E705A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjEPWT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjEPWT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:19:26 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D15759D2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 15:19:24 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 047C02C04E1;
        Wed, 17 May 2023 10:19:15 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1684275555;
        bh=arElUNBLxYP/oS8PzLnuVnQ8MmR2mLGZDAgu2O2gSP0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=HPFIGvXnhVHJyEKGFnxyaxSijIvhEllmsTmbBGp+8Qqb35g1/YKCDZq1dzTp/zGdp
         MXO8b3wk0ogBOt3D7T01o0EGsIT6bnIyt4Jw66MetNrL71J1GWgdz2qk+gVyCaBrnP
         lur/J26PiuQlUlw/DoQV7mxuscX3d5cBg5wO6kh0InNO8zat9PEJ/AwkJlnxA2/SHb
         g/R8eaZOyN1+rp9+Jkf419hgcKUkcYwN8dVrvFumOgt1dQH7eB64AoEzBFsXlqvhlF
         sxl5asI2MU3uLmd5ubSc9/+TTCWzas5K8fMRuZcG+0An4HO2E64k59/eqrFmcasVt8
         eoMAfK1L2DdJw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B646401620001>; Wed, 17 May 2023 10:19:14 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 May 2023 10:19:14 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Wed, 17 May 2023 10:19:14 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "johan@kernel.org" <johan@kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "maz@kernel.org" <maz@kernel.org>,
        Ben Brown <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Thread-Topic: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Thread-Index: AQHZhIoofApft8Zm8kuYZtpxH+f53K9VfDeAgAQYHQCAApZDgIAAjA4A
Date:   Tue, 16 May 2023 22:19:14 +0000
Message-ID: <31a23398-9b0e-4a19-3576-84fcfd3ce4b5@alliedtelesis.co.nz>
References: <20230512042806.3438373-1-chris.packham@alliedtelesis.co.nz>
 <CACRpkdYz9ipNTo2ORXKWy5Q4uCpKL=9Gd+kK76pestX7Onuz-Q@mail.gmail.com>
 <b36fcdf1-45ab-0c06-efe4-237df0612466@alliedtelesis.co.nz>
 <CACRpkdbiSAFoJP_JB1d_6gQ+Xx7Y+mLAh=C6Za+fpyWuRe6Gbw@mail.gmail.com>
In-Reply-To: <CACRpkdbiSAFoJP_JB1d_6gQ+Xx7Y+mLAh=C6Za+fpyWuRe6Gbw@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E08B0DD9C4BAB49AB098DDA8173E7C0@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=3N-_S7HmHMGHqhwlQE4A:9 a=QEXdDO2ut3YA:10
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

DQpPbiAxNy8wNS8yMyAwMTo1NywgTGludXMgV2FsbGVpaiB3cm90ZToNCj4gT24gTW9uLCBNYXkg
MTUsIDIwMjMgYXQgMTI6MjfigK9BTSBDaHJpcyBQYWNraGFtDQo+IDxDaHJpcy5QYWNraGFtQGFs
bGllZHRlbGVzaXMuY28ubno+IHdyb3RlOg0KPg0KPj4gSW4gbXkgb3JpZ2luYWwgY2FzZSB3aGlj
aCBpcyBhIGtlcm5lbCBtb2R1bGUgdGhhdCBleHBvcnRzIGEgR1BJTyBmb3INCj4+IHVzZXJzcGFj
ZSB1c2luZyBncGlvZF9leHBvcnQoKQ0KPiBXZSBzaG91bGQgbm90IGFkZCBuZXcgdXNlcnMgZm9y
IHRoYXQgQVBJIGFzIGl0IGluY3JlYXNlIHRoZSB1c2FnZQ0KPiBvZiB0aGUgc3lzZnMgQUJJIGJ1
dCBpZiBpdCdzIGFuIGV4aXN0aW5nIGluLXRyZWUgdXNlY2FzZSBJIGJ1eSBpdC4NCj4NCj4+IFRo
ZSBjcnV4IG9mIHRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIGlycV9kZXNjIGlzIGNyZWF0ZWQgd2hl
biBpdCBoYXNuJ3QNCj4+IGJlZW4gcmVxdWVzdGVkLg0KPiBUaGUgcmlnaHQgc29sdXRpb24gdG8g
bWUgc2VlbXMgdG8gYmUgdG8gbm90IHVzZSBncGlvZF9leHBvcnQoKQ0KPiBhbmQgbm90IHVzZSBz
eXNmcyBUQkguDQoNClRoYXQncyBub3QgcmVhbGx5IGEgZmVhc2libGUgc29sdXRpb24uIEknbSBk
ZWFsaW5nIHdpdGggYXBwbGljYXRpb24gY29kZSANCnRoYXQgaGFzIGJlZW4gaGFwcGlseSB1c2lu
ZyB0aGUgc3lzZnMgaW50ZXJmYWNlIGZvciBtYW55IHllYXJzLg0KDQpJIGFjdHVhbGx5IGRpZCBs
b29rIGF0IGdldHRpbmcgdGhhdCBjb2RlIHVwZGF0ZWQgdG8gdXNlIGxpYmdwaW8gZWFybGllciAN
CnRoaXMgeWVhciBidXQgZm91bmQgdGhlIEFQSSB3YXMgaW4gYSBzdGF0ZSBvZiBmbHV4IGFuZCBJ
IHdhc24ndCBnb2luZyB0byANCnJlY29tbWVuZCByZS13cml0aW5nIHRoZSBhcHBsaWNhdGlvbiBj
b2RlIHRvIHVzZSBsaWJncGlvIGlmIEkga25ldyB0aGUgDQpBUEkgd2FzIGdvaW5nIHRvIGNoYW5n
ZSBhbmQgd2UnZCBoYXZlIHRvIHJlLXdyaXRlIGl0IGFnYWluLg0KDQpFdmVuIG5vdyB3aXRoIHRo
ZSAyLjAuMSBsaWJncGlvIHRoZXJlIGRvZXNuJ3Qgc2VlbSB0byBiZSBhIHdheSBvZiBhc2tpbmcg
DQphYm91dCBqdXN0IEdQSU8gbGluZXMgaW4gdGhlIHN5c3RlbSwgYXBwbGljYXRpb24gY29kZSB3
b3VsZCBzdGlsbCBuZWVkIA0KdG8gb3BlbiBldmVyeSAvZGV2L2dwaW9jaGlwTiBkZXZpY2UgYW5k
IGFzayB3aGF0IGxpbmVzIGFyZSBvbiB0aGUgY2hpcCANCmFuZCBrZWVwIHRoZSBmZHMgb3BlbiBm
b3IgdGhlIGNoaXBzIHRoYXQgaGF2ZSBsaW5lcyB0aGUgYXBwbGljYXRpb24gDQpjYXJlcyBhYm91
dCBidXQgbWFrZSBzdXJlIHRvIGNsb3NlIHRoZSBmZCBmb3IgdGhlIG9uZXMgdGhhdCBkb24ndC4g
U28gDQpub3cgdGhlIGFwcGxpY2F0aW9uIGNvZGUgaGFzIHRvIGNhcmUgYWJvdXQgR1BJTyBjaGlw
cyBpbiBhZGRpdGlvbiB0byB0aGUgDQpHUElPIGxpbmVzLg0KDQo+PiBJbiBzb21lIGNhc2VzIHdl
IGtub3cgdGhlIEdQSU8gcGluIGlzIGFuIG91dHB1dCBzbyB3ZQ0KPj4gY291bGQgYXZvaWQgaXQs
IGluIG90aGVycyB3ZSBjb3VsZCBkZWxheSB0aGUgY3JlYXRpb24gdW50aWwgYW4gaW50ZXJydXB0
DQo+PiBpcyBhY3R1YWxseSByZXF1ZXN0ZWQgKHdoaWNoIGlzIHdoYXQgSSdtIGF0dGVtcHRpbmcg
dG8gZG8pLg0KPiBZZWFoIEkgZ3Vlc3MuIElmIHdlIHdhbm5hIGtlZXAgcGFwZXJpbmcgb3ZlciBp
c3N1ZXMgY3JlYXRlZA0KPiBieSB0aGUgc3lzZnMgQUJJLg0KDQpTbyB0aGF0IGFzaWRlLiBJcyBp
cyByZWFzb25hYmxlIHRvIGV4cGVjdCB0aGF0IGdwaW9faXNfdmlzaWJsZSgpIHNob3VsZCANCm5v
dCBoYXZlIGFueSBzaWRlIGVmZmVjdHM/DQoNCkkgc3RpbGwgYmVsaWV2ZSB0aGF0IHRoaXMgY2hh
bmdlIGlzIGluIHRoZSByaWdodCBkaXJlY3Rpb24gYWx0aG91Z2ggDQpjbGVhcmx5IEkgbmVlZCB0
byBwcm92aWRlIGEgYmV0dGVyIGV4cGxhbmF0aW9uIG9mIHdoeSBJIHRoaW5rIHRoYXQgaXMgDQp0
aGUgY2FzZS4gQW5kIHRoZXJlIG1pZ2h0IGJlIGEgYmV0dGVyIHdheSBvZiBhY2hpZXZpbmcgbXkg
Z29hbCBvZiBub3QgDQp0cmlnZ2VyaW5nIHRoZSB3YXJuaW5nIG9uIGtleGVjIChjZXJ0YWlubHkg
bXkgaW5pdGlhbCBlZmZvcnQgd2FzIHdheSBvZmYgDQp0aGUgbWFyaykuDQoNCj4NCj4gWW91cnMs
DQo+IExpbnVzIFdhbGxlaWo=
