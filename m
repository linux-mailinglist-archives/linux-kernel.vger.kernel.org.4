Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AFF71021C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 02:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjEYAx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 20:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEYAxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 20:53:24 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659CCE7
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 17:53:22 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id AF5272C02E0;
        Thu, 25 May 2023 12:53:19 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1684975999;
        bh=gakfYzajycWsBIRNP8cV6Mi5LfkKI00ALEVp/557AR0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=opxRzPOMErYuaex5VKKtrEpdkwSwq0I/abh33hNMcE1bFwXayQdf7pizD/waWK64J
         NWbFvdSNQa3ndbqaG4wRuNGcd5y7JQwoiBm1lFcVWgiaAL2FOujUsZ4V4xu7YAtlo8
         eYRs7gdeyA76Ge48X0V2nWobvoTYSw5V4QSZ0Z3JQdWsPP8DiNoTpiBDXVXVBaSZ0x
         X2OSRrSJzW/X3rwgZZUq91ud8vkfkBtrcJroc71hBDyP8wnY58AIE5g5v7tqEcz2Ah
         N+Gzly+YvsTkYJt8qCJrtNn+4uDu66h/Ijc3ZUs6xERR8ClnrBx+ClhEUJNYgXHS5G
         Fnu/56z5cngqw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B646eb17f0001>; Thu, 25 May 2023 12:53:19 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 May 2023 12:53:19 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Thu, 25 May 2023 12:53:19 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Aviram Dali <aviramd@marvell.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH 0/3] mtd: rawnand: marvell: add support for AC5 SoC
Thread-Topic: [PATCH 0/3] mtd: rawnand: marvell: add support for AC5 SoC
Thread-Index: AQHY45PTmnmHPuwW40yPMLrn8y8OYa9qtkQA
Date:   Thu, 25 May 2023 00:53:19 +0000
Message-ID: <143fb1ff-b2d4-a6fe-e892-b55a7bbf56f8@alliedtelesis.co.nz>
References: <20221019082046.30160-1-vadym.kochan@plvision.eu>
In-Reply-To: <20221019082046.30160-1-vadym.kochan@plvision.eu>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BED105E491B8E142A82B3707E313028D@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=QG0ANWG3iu1Ceheqxc0A:9 a=QEXdDO2ut3YA:10
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

SGkgVmFkeW0sDQoNCk9uIDE5LzEwLzIyIDIxOjIwLCBWYWR5bSBLb2NoYW4gd3JvdGU6DQo+IFRo
aXMgc2VyaWVzIGFkZHMgc3VwcG9ydCBmb3IgQUM1IFNvQy4NCj4NCj4gVGhlIGZvbGxvd2luZyBj
aGFuZ2VzIHdlcmUgbWFkZSB0byBhZGQgQUM1IHN1cHBvcnQ6DQo+DQo+ICAgICAxKSBNb2RpZnkg
TWFydmVsbCBuYW5kIE5GQyB0aW1pbmcgc2V0IGZvciBtb2RlIDANCj4NCj4gICAgIDIpIGZpeCB2
YWxpZGF0aW9uIGluIEFDNSBOYW5kIGRyaXZlciBmb3IgT05GSSB0aW1pbmdzIHZhbHVlcyBtb2Rl
cyAxIGFuZCAzDQo+DQo+ICAgICAzKSByZW1vdmUgdW5uZWNlc3NhcnkgbmFuZCB0aW1pbmctbW9k
ZSBpbiBkZXZpY2UgdHJlZSBvZiBhYzUuZHRzaQ0KPg0KPiAgICAgNCkgYWRkIG5hbmQgbWlzc2lu
ZyBBQzVYIGxheW91dHMgLCBhZGQgb3B0aW9uIHRvIHVzZSBuZHRyIHByZWRlZmluZWQgdmFsdWVz
DQo+DQo+ICAgICA1KSBaZXJvIHN0ZXBzIGFuZCB0b3RhbCBmaWVsZHMgb2YgZWNjIGluIGVjYyBj
b250cm9sbGVyIGluaXRpYWxpemF0aW9uIHNvDQo+ICAgICAgICBuYW5kX3NjYW5fdGFpbCgpIHdp
bGwgY2FsY3VsYXRlIHRoZXNlIHR3byBmaWVsZHMsIG90aGVyd2lzZQ0KPiAgICAgICAgTkFORCBp
bml0aWFsaXphdGlvbiB3aWxsIGZhaWwgd2l0aCBrZXJuZWwgNS4xNSBhbmQgYWJvdmUuDQo+DQo+
IEF2aXJhbSBEYWxpICgyKToNCj4gICAgZHQtYmluZGluZ3M6IG10ZDogQWRkIEFDNSBzcGVjaWZp
YyBiaW5kaW5nDQo+ICAgIG10ZDogcmF3bmFuZDogbWFydmVsbDogYWRkIHN1cHBvcnQgZm9yIEFD
NSBTb0MNCg0KQXJlIHlvdSBzdGlsbCBsb29raW5nIGludG8gdGhpcyBzZXJpZXM/IEkgc2VlIG9u
ZSBwYXJ0IG1hZGUgaXQgdXBzdHJlYW0gDQphcyBjb21taXQgNjhjMThkYWU2ODg4ICgibXRkOiBy
YXduYW5kOiBtYXJ2ZWxsOiBhZGQgbWlzc2luZyBsYXlvdXRzIikgDQphbmQgdGhlcmUgd2FzIGFu
IG9mZi1zaG9vdCBzZXJpZXMgYXJvdW5kIGNvbnZlcnRpbmcgdGhlIERUIGJpbmRpbmcuDQoNCj4g
VmFkeW0gS29jaGFuICgxKToNCj4gICAgbXRkOiByYXduYW5kOiBQYXJ0aWFsbHkgcmV2ZXJ0IDQx
MTRmOTdjNDFjZCAoIm10ZDogcmF3bmFuZDogR2V0IHJpZCBvZg0KPiAgICAgIGEgZmV3IHVudXNl
ZCBkZWZpbml0aW9ucyIpDQo+DQo+ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL21hcnZl
bGwtbmFuZC50eHQgIHwgICAxICsNCj4gICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9LY29uZmlnICAg
ICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9tYXJ2ZWxs
X25hbmQuYyAgICAgICAgICAgfCAyNzcgKysrKysrKysrKysrKysrKy0tDQo+ICAgZHJpdmVycy9t
dGQvbmFuZC9yYXcvbmFuZF90aW1pbmdzLmMgICAgICAgICAgIHwgIDE0ICsNCj4gICBpbmNsdWRl
L2xpbnV4L210ZC9yYXduYW5kLmggICAgICAgICAgICAgICAgICAgfCAgIDMgKw0KPiAgIDUgZmls
ZXMgY2hhbmdlZCwgMjY0IGluc2VydGlvbnMoKyksIDMzIGRlbGV0aW9ucygtKQ0KPg==
