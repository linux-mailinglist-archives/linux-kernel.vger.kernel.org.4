Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D43D715173
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjE2WAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjE2WAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:00:36 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADA3C1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 15:00:31 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2A7422C0593;
        Tue, 30 May 2023 10:00:23 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685397623;
        bh=GvLRBj+jIJkhScZafRzWRU78FE7FWC5PGOOtBHRCLIY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ihZI5Xoc+QXfYJciv/tV1AuwQAzQqnwDSOcyF8z++/dcsPIb+EX5nyQnngocKBx9D
         4dLPE67dnPfw+E38crg5FvK+tcM6PjJN8DGrWmOHVYT22kthNxsyonaA/qVlw40rul
         lRVhbFbWI1sNoYv9zmxsUJHUGRJtSG80Tzu5HJTINxZrIx/LQzgz92z9dhnEHxFawB
         NDFNQEgq/NYe2yR4EzjCR9ZG7/wKsORLtMprUBMjUWjiJfS4vHpW4BU2yDs+bgQjOt
         7x8ndw7xEaxTF+9uJLAj2013GX6SDgx3OGXf1e8n8P0/YZT+1SRgmSgeLhhFgSeNwk
         uzmr7b/ZH9EjA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B647520770000>; Tue, 30 May 2023 10:00:23 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Tue, 30 May 2023 10:00:22 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Tue, 30 May 2023 10:00:22 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Tue, 30 May 2023 10:00:22 +1200
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
Thread-Index: AQHZhIoofApft8Zm8kuYZtpxH+f53K9VfDeAgAQYHQCAApZDgIAAjA4AgBOROQCAANfRAA==
Date:   Mon, 29 May 2023 22:00:22 +0000
Message-ID: <9756c9da-3063-04c8-02b6-79146b81b3cc@alliedtelesis.co.nz>
References: <20230512042806.3438373-1-chris.packham@alliedtelesis.co.nz>
 <CACRpkdYz9ipNTo2ORXKWy5Q4uCpKL=9Gd+kK76pestX7Onuz-Q@mail.gmail.com>
 <b36fcdf1-45ab-0c06-efe4-237df0612466@alliedtelesis.co.nz>
 <CACRpkdbiSAFoJP_JB1d_6gQ+Xx7Y+mLAh=C6Za+fpyWuRe6Gbw@mail.gmail.com>
 <31a23398-9b0e-4a19-3576-84fcfd3ce4b5@alliedtelesis.co.nz>
 <CACRpkdbqq1=8SeN18V_iyFQQ00bd8Eia5okB1v3f=nZQOnSiTA@mail.gmail.com>
In-Reply-To: <CACRpkdbqq1=8SeN18V_iyFQQ00bd8Eia5okB1v3f=nZQOnSiTA@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9CB69A6E0B1774CA9F7AFA4CB03B0E1@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=VwQbUJbxAAAA:8 a=n7lz_p6-F6BW55SpA8IA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyOS8wNS8yMyAyMTowNywgTGludXMgV2FsbGVpaiB3cm90ZToNCj4gT24gV2VkLCBNYXkg
MTcsIDIwMjMgYXQgMTI6MTnigK9BTSBDaHJpcyBQYWNraGFtDQo+IDxDaHJpcy5QYWNraGFtQGFs
bGllZHRlbGVzaXMuY28ubno+IHdyb3RlOg0KPj4gT24gMTcvMDUvMjMgMDE6NTcsIExpbnVzIFdh
bGxlaWogd3JvdGU6DQo+Pj4gT24gTW9uLCBNYXkgMTUsIDIwMjMgYXQgMTI6MjfigK9BTSBDaHJp
cyBQYWNraGFtDQo+Pj4gPENocmlzLlBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4gd3JvdGU6
DQo+Pj4+IFRoZSBjcnV4IG9mIHRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIGlycV9kZXNjIGlzIGNy
ZWF0ZWQgd2hlbiBpdCBoYXNuJ3QNCj4+Pj4gYmVlbiByZXF1ZXN0ZWQuDQo+Pj4gVGhlIHJpZ2h0
IHNvbHV0aW9uIHRvIG1lIHNlZW1zIHRvIGJlIHRvIG5vdCB1c2UgZ3Bpb2RfZXhwb3J0KCkNCj4+
PiBhbmQgbm90IHVzZSBzeXNmcyBUQkguDQo+PiBUaGF0J3Mgbm90IHJlYWxseSBhIGZlYXNpYmxl
IHNvbHV0aW9uLiBJJ20gZGVhbGluZyB3aXRoIGFwcGxpY2F0aW9uIGNvZGUNCj4+IHRoYXQgaGFz
IGJlZW4gaGFwcGlseSB1c2luZyB0aGUgc3lzZnMgaW50ZXJmYWNlIGZvciBtYW55IHllYXJzLg0K
PiBJIHdvbmRlciBob3cgbWFueSB5ZWFycy4NCj4NCj4gVGhlIEdQSU8gc3lzZnMgaGFzIGJlZW4g
ZGVwcmVjYXRlZCBmb3Igc2V2ZW4geWVhcnM6DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvRG9jdW1lbnRh
dGlvbi9BQkkvb2Jzb2xldGUvc3lzZnMtZ3Bpbz9pZD1mZTk1MDQ2ZTk2MGI0Yjc2ZTczZGMxNDg2
OTU1ZDkzZjQ3Mjc2MTM0DQo+DQo+IE15IGZlYXIgaXMgdGhhdCBkZXByZWNhdGlvbiBpcyBpZ25v
cmVkIGFuZCBwZW9wbGUgc3RpbGwgZGV2ZWxvcCBzdHVmZg0KPiBsaWtlIHRoaXMgaWdub3Jpbmcg
dGhlIGZhY3QgdGhhdCB0aGUgQUJJIGlzIGRlcHJlY2F0ZWQuDQoNCkkgY2FuJ3QgY2xhaW0gdGhh
dCB0aGUgY29kZSBpcyBlYXJsaWVyIHRoYW4gdGhhdCBkZXByZWNhdGlvbiAobWF5YmUgDQoyLjYu
MzIgZXJhKSBidXQgd2UgY2VydGFpbmx5IGRpZG4ndCBrbm93IGFib3V0IHRoZSBkZXByZWNhdGlv
biB3aGVuIHdlIA0Kc3RhcnRlZCB1c2luZyBpdC4gVW5mb3J0dW5hdGVseSB0aGUgaW50ZXJuZXQg
aGFzIGEgbG9uZyBtZW1vcnkgc28gaWYgeW91IA0Kc2VhcmNoIGZvciBMaW51eCBHUElPcyB5b3Un
bGwgZmluZCBwbGVudHkgb2YgZXhhbXBsZXMgdGhhdCBwb2ludCB0byB0aGUgDQpzeXNmcyBBQkkg
YXMgdGhlIHdheSB0aGF0IGl0J3MgZG9uZS4NCg0KU3dpdGNoaW5nIHRvIHRoZSBsaWJncGlvZCBp
cyB2aWFibGUgZm9yIGEgZmV3IG1pc2NlbGxhbmVvdXMgdXNlcyAoSSdsbCANCnRyeSB0byBwdXNo
IHRoYXQgZnJvbSBteSBlbmQpLCB0aGVyZSBwcm9iYWJseSB3aWxsIGJlIGEgbG9uZyB0YWlsIG9m
IA0KY29kZSB0aGF0IHdpbGwgY29udGludWUgdG8gdXNlIHRoZSBzeXNmcyBBQkkuDQoNCj4NCj4g
WW91cnMsDQo+IExpbnVzIFdhbGxlaWo=
