Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FADE71F460
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjFAVHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFAVHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:07:10 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD382196
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:07:06 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0B4832C04C6;
        Fri,  2 Jun 2023 09:07:04 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685653624;
        bh=lagv8B0EktaO49mcN5rcRK+n+7a0oAGzTW3IlAZoyKk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=j6+rRqv30keNW18U2kUJhrPjj1jWsXtvg+1f7z7tRYP8msGzQmk3XzL2KGpC+c0+M
         x0yUe8p5dthn9RuRALYWhwkJ6A+Fj7WhYntv7IO4vkVx74An243rf3G9m4iR3eXmAd
         jvaFf2CfppMr5d/+WTTic748QRJQm3OaT0ncRlL2pZvLLxOyF3SMkyCzcvOM27kUfj
         L6K28Qqkc1DlCyx+ZqZMEMILgIWAQ4aGFUHw3sbi4EB99E7T53XE3uUphOy/VDdkbV
         Wy456JKUiNMAEwYlFjGHxy5Bu5sxGgD3U3vhpYCfLDZpv0PYV5W90geqi2yh2iv8EW
         vkfY9DN85Ef+w==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B647908770001>; Fri, 02 Jun 2023 09:07:03 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Fri, 2 Jun 2023 09:07:03 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Fri, 2 Jun 2023 09:07:03 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Fri, 2 Jun 2023 09:07:03 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "conor@kernel.org" <conor@kernel.org>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "enachman@marvell.com" <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH v8 3/3] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Thread-Topic: [PATCH v8 3/3] dt-bindings: mtd: marvell-nand: Convert to YAML
 DT scheme
Thread-Index: AQHZlBqKdz5LnJY4bkmRhfo5eGePCq90vZuAgADrCwA=
Date:   Thu, 1 Jun 2023 21:07:03 +0000
Message-ID: <043c67b6-6061-f683-f054-86d7c298e03a@alliedtelesis.co.nz>
References: <20230531234923.2307013-1-chris.packham@alliedtelesis.co.nz>
 <20230531234923.2307013-4-chris.packham@alliedtelesis.co.nz>
 <a23dd485-a3d9-e31f-be3e-0ab293fcfc4a@linaro.org>
In-Reply-To: <a23dd485-a3d9-e31f-be3e-0ab293fcfc4a@linaro.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3518A4F5BE4424DAD44AEAF1B6001AC@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=CMhUoijD c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=of4jigFt-DYA:10 a=g8kJ_gb0AAAA:8 a=62ntRvTiAAAA:8 a=gEfo2CItAAAA:8 a=P-IC7800AAAA:8 a=0ubqMkb-OQRjDkv6lAAA:9 a=QEXdDO2ut3YA:10 a=ecSNLfPMzbq-p5zXJZOg:22 a=pToNdpNmrtiFLRE6bQ9Z:22 a=sptkURWiP4Gy88Gu7hUp:22 a=d3PnA9EDa4IxuAV0gXij:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxLzA2LzIzIDE5OjA1LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBPbiAwMS8w
Ni8yMDIzIDAxOjQ5LCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4gRnJvbTogVmFkeW0gS29jaGFu
IDx2YWR5bS5rb2NoYW5AcGx2aXNpb24uZXU+DQo+Pg0KPj4gU3dpdGNoIHRoZSBEVCBiaW5kaW5n
IHRvIGEgWUFNTCBzY2hlbWEgdG8gZW5hYmxlIHRoZSBEVCB2YWxpZGF0aW9uLg0KPj4NCj4+IFRo
ZSB0ZXh0IGJpbmRpbmcgZGlkbid0IG1lbnRpb24gaXQgYXMgYSByZXF1aXJlbWVudCBidXQgZXhp
c3RpbmcgdXNhZ2UNCj4+IGhhcw0KPj4NCj4+ICAgICBjb21wYXRpYmxlID0gIm1hcnZlbGwsYXJt
YWRhLThrLW5hbmQtY29udHJvbGxlciIsDQo+PiAgICAgICAgICAgICAgICAgICJtYXJ2ZWxsLGFy
bWFkYTM3MC1uYW5kLWNvbnRyb2xsZXIiOw0KPj4NCj4+IHNvIHRoZSBZQU1MIGFsbG93cyB0aGlz
IGluIGFkZGl0aW9uIHRvIHRoZSBpbmRpdmlkdWFsIGNvbXBhdGlibGUgdmFsdWVzLg0KPj4NCj4+
IFRoZXJlIHdhcyBhbHNvIGFuIGluY29ycmVjdCByZWZlcmVuY2UgdG8gZG1hLW5hbWVzIGJlaW5n
ICJyeHR4IiB3aGVyZQ0KPj4gdGhlIGRyaXZlciBhbmQgZXhpc3RpbmcgZGV2aWNlIHRyZWVzIGFj
dHVhbGx5IHVzZSBkbWEtbmFtZXMgPSAiZGF0YSIgc28NCj4+IHRoaXMgaXMgY29ycmVjdGVkIGlu
IHRoZSBjb252ZXJzaW9uLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZhZHltIEtvY2hhbiA8dmFk
eW0ua29jaGFuQHBsdmlzaW9uLmV1Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8
Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPj4gLS0tDQo+Pg0KPj4gTm90ZXM6
DQo+PiAgICAgIENoYW5nZXMgaW4gdjg6DQo+PiAgICAgIC0gTWFyayBkZXByZWNhdGVkIGNvbXBh
dGlibGUgdmFsdWVzIGFzIHN1Y2gNCj4+ICAgICAgLSBBbGxvdyAibWFydmVsbCxhcm1hZGEtOGst
bmFuZC1jb250cm9sbGVyIiB3aXRob3V0DQo+PiAgICAgICAgIm1hcnZlbGwsYXJtYWRhMzcwLW5h
bmQtY29udHJvbGxlciINCj4+ICAgICAgLSBNYWtlIGRtYS1uYW1lcyB1c2FnZSByZWZsZWN0IHJl
YWxpdHkNCj4+ICAgICAgLSBVcGRhdGUgY29tbWl0IG1lc3NhZ2UNCj4+ICAgICAgDQo+PiAgICAg
IENoYW5nZXMgaW4gdjc6DQo+PiAgICAgIC0gUmVzdG9yZSAibGFiZWwiIGFuZCAicGFydGl0aW9u
cyIgcHJvcGVydGllcyAoc2hvdWxkIGJlIHBpY2tlZCB1cCB2aWENCj4+ICAgICAgICBuYW5kLWNv
bnRyb2xsZXIueWFtbCBidXQgYXJlbid0KQ0KPiBXaGF0IGRvIHlvdSBtZWFuIGJ5ICJhcmVuJ3Qi
PyBUaGV5IGFyZSBub3QgbmVlZGVkLg0KDQpJIG1lYW4gSSBzaW1wbHkgY2Fubm90IG1ha2UgaXQg
d29yayBhbmQgSSdtIG91dCBvZiBpZGVhcyAoSSdtIGFsc28gaW4gYW4gDQphd2t3YXJkIHRpbWV6
b25lIHNvIGl0IHRha2VzIDI0aHJzIGZvciBtZSB0byBhc2sgYSBxdWVzdGlvbiBhbmQgZ2V0IGEg
DQpyZXNwb25zZSB3aGljaCBsZWFkcyB0byBtZSBtYWtpbmcgZ3Vlc3NlcyBpbnN0ZWFkIG9mIHdh
aXRpbmcpLg0KDQpuYW5kLWNvbnRyb2xsZXIueWFtbCByZWZlcmVuY2VzIG5hbmQtY2hpcC55YW1s
IHdoaWNoIHJlZmVyZW5jZXMgbXRkLnlhbWwgDQp3aGljaCBkZWZpbmVzIHRoZSAibGFiZWwiIGFu
ZCAicGFydGl0aW9ucyIgcHJvcGVydHkuDQoNCkkgdGhvdWdodCBtYXJ2ZWxsLG5hbmQtY29udHJv
bGxlci55YW1sIGNvdWxkIGp1c3Qgc2F5IGAkcmVmOiANCm5hbmQtY29udHJvbGxlci55YW1sYCBh
bmQgaXQgd291bGQgbWVhbiBJJ2QgZ2V0IGFsbCB0aGUgZGVmaW5pdGlvbnMgZG93biANCnRoZSBj
aGFpbiBidXQgdGhpcyBkb2Vzbid0IHNlZW0gdG8gd29yayB0aGUgd2F5IEkgZXhwZWN0IChvciBt
b3JlIGxpa2VseSANCkknbSBub3QgZG9pbmcgaXQgcmlnaHQpLiBJIHRob3VnaHQgaXQgbWlnaHQg
aGF2ZSBzb21ldGhpbmcgdG8gZG8gd2l0aCANCnRoZSBkaWZmZXJlbnQgcGF0dGVyblByb3BlcnRp
ZXMgcGF0dGVybiBidXQgZXZlbiB3aGVuIEkgbWFrZSB0aGF0IG1hdGNoIA0Kd2hhdCBpcyB1c2Vk
IGluIG5hbmQtY29udHJvbGxlci55YW1sIGl0IGRvZXNuJ3Qgc2VlbSB0byBwaWNrIHVwIHRob3Nl
IA0KcHJvcGVydGllcy4NCg0KPj4gICAgICAtIEFkZC9yZXN0b3JlIG5hbmQtb24tZmxhc2gtYmJ0
IGFuZCBuYW5kLWVjYy1tb2RlIHdoaWNoIGFyZW4ndCBjb3ZlcmVkDQo+PiAgICAgICAgYnkgbmFu
ZC1jb250cm9sbGVyLnlhbWwuDQo+PiAgICAgIC0gVXNlICJ1bmV2YWxhdXRlZFByb3BlcnRpZXM6
IGZhbHNlIg0KPj4gICAgICAtIENvcnJlY3Rpb25zIGZvciBjbG9jay1uYW1lcywgZG1hLW5hbWVz
LCBuYW5kLXJiIGFuZCBuYW5kLWVjYy1zdHJlbmd0aA0KPj4gICAgICAtIEFkZCBweGEzeHgtbmFu
ZC1jb250cm9sbGVyIGV4YW1wbGUNCj4+ICAgICAgDQo+PiAgICAgIENoYW5nZXMgaW4gdjY6DQo+
PiAgICAgIC0gcmVtb3ZlIHByb3BlcnRpZXMgY292ZXJlZCBieSBuYW5kLWNvbnRyb2xsZXIueWFt
bA0KPj4gICAgICAtIGFkZCBleGFtcGxlIHVzaW5nIGFybWFkYS04ayBjb21wYXRpYmxlDQo+PiAg
ICAgIA0KPj4gICAgICBlYXJsaWVyIGNoYW5nZXM6DQo+PiAgICAgIA0KPj4gICAgICB2NToNCj4+
ICAgICAgICAgMSkgR2V0IGJhY2sgImxhYmVsIiBhbmQgInBhcnRpdGlvbnMiIHByb3BlcnRpZXMg
YnV0IHdpdGhvdXQNCj4+ICAgICAgICAgICAgcmVmIHRvIHRoZSAicGFydGl0aW9uLnlhbWwiIHdo
aWNoIHdhcyB3cm9uZ2x5IHVzZWQuDQo+PiAgICAgIA0KPj4gICAgICAgICAyKSBBZGQgImFkZGl0
aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZSIgZm9yIG5hbmRAIGJlY2F1c2UgYWxsIHBvc3NpYmxlDQo+
PiAgICAgICAgICAgIHByb3BlcnRpZXMgYXJlIGRlc2NyaWJlZC4NCj4+ICAgICAgDQo+PiAgICAg
IHY0Og0KPj4gICAgICAgICAxKSBSZW1vdmUgImxhYmVsIiBhbmQgInBhcnRpdGlvbnMiIHByb3Bl
cnRpZXMNCj4+ICAgICAgDQo+PiAgICAgICAgIDIpIFVzZSAyIGNsb2NrcyBmb3IgQTdLLzhLIHBs
YXRmb3JtIHdoaWNoIGlzIGEgcmVxdWlyZW1lbnQNCj4+ICAgICAgDQo+PiAgICAgIHYzOg0KPj4g
ICAgICAgIDEpIFJlbW92ZSB0eHQgdmVyc2lvbiBmcm9tIHRoZSBNQUlOVEFJTkVSUyBsaXN0DQo+
PiAgICAgIA0KPj4gICAgICAgIDIpIFVzZSBlbnVtIGZvciBzb21lIG9mIGNvbXBhdGlibGUgc3Ry
aW5ncw0KPj4gICAgICANCj4+ICAgICAgICAzKSBEcm9wOg0KPj4gICAgICAgICAgICAgICNhZGRy
ZXNzLWNlbGxzDQo+PiAgICAgICAgICAgICAgI3NpemUtY2VsbHM6DQo+PiAgICAgIA0KPj4gICAg
ICAgICAgIGFzIHRoZXkgYXJlIGluaGVyaXRlZCBmcm9tIHRoZSBuYW5kLWNvbnRyb2xsZXIueWFt
bA0KPj4gICAgICANCj4+ICAgICAgICA0KSBBZGQgcmVzdHJpY3Rpb24gdG8gdXNlIDIgY2xvY2tz
IGZvciBBOEsgU29DDQo+PiAgICAgIA0KPj4gICAgICAgIDUpIERyb3BwZWQgZGVzY3JpcHRpb24g
Zm9yIGNsb2NrLW5hbWVzIGFuZCBleHRlbmQgaXQgd2l0aA0KPj4gICAgICAgICAgIG1pbkl0ZW1z
OiAxDQo+PiAgICAgIA0KPj4gICAgICAgIDYpIERyb3AgZGVzY3JpcHRpb24gZm9yICJkbWFzIg0K
Pj4gICAgICANCj4+ICAgICAgICA3KSBVc2UgInVuZXZhbGF1dGVkUHJvcGVydGllczogZmFsc2Ui
DQo+PiAgICAgIA0KPj4gICAgICAgIDgpIERyb3AgcXVpdGVzIGZyb20geWFtbCByZWZzLg0KPj4g
ICAgICANCj4+ICAgICAgICA5KSBVc2UgNC1zcGFjZSBpbmRlbnRhdGlvbiBmb3IgdGhlIGV4YW1w
bGUgc2VjdGlvbg0KPj4gICAgICANCj4+ICAgICAgdjI6DQo+PiAgICAgICAgMSkgRml4ZWQgd2Fy
bmluZyBieSB5YW1sbGludCB3aXRoIGluY29ycmVjdCBpbmRlbnRhdGlvbiBmb3IgY29tcGF0aWJs
ZSBsaXN0DQo+Pg0KPj4gICAuLi4vYmluZGluZ3MvbXRkL21hcnZlbGwsbmFuZC1jb250cm9sbGVy
LnlhbWwgfCAyMjMgKysrKysrKysrKysrKysrKysrDQo+PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRp
bmdzL210ZC9tYXJ2ZWxsLW5hbmQudHh0ICB8IDEyNiAtLS0tLS0tLS0tDQo+PiAgIE1BSU5UQUlO
RVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSAtDQo+PiAgIDMgZmls
ZXMgY2hhbmdlZCwgMjIzIGluc2VydGlvbnMoKyksIDEyNyBkZWxldGlvbnMoLSkNCj4+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvbWFy
dmVsbCxuYW5kLWNvbnRyb2xsZXIueWFtbA0KPj4gICBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9tYXJ2ZWxsLW5hbmQudHh0DQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvbWFydmVs
bCxuYW5kLWNvbnRyb2xsZXIueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tdGQvbWFydmVsbCxuYW5kLWNvbnRyb2xsZXIueWFtbA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uNDMzZmViNDMwNTU1DQo+PiAtLS0gL2Rldi9udWxs
DQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL21hcnZlbGws
bmFuZC1jb250cm9sbGVyLnlhbWwNCj4+IEBAIC0wLDAgKzEsMjIzIEBADQo+PiArIyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+PiArJVlB
TUwgMS4yDQo+PiArLS0tDQo+PiArJGlkOiBodHRwOi8vc2Nhbm1haWwudHJ1c3R3YXZlLmNvbS8/
Yz0yMDk4OCZkPTE4UDQ1TldhUjRWNnBYdF9rdWl2TkNpVkFYQ20zQzdNRUYtXzh4clAyQSZ1PWh0
dHAlM2ElMmYlMmZkZXZpY2V0cmVlJTJlb3JnJTJmc2NoZW1hcyUyZm10ZCUyZm1hcnZlbGwlMmNu
YW5kLWNvbnRyb2xsZXIlMmV5YW1sJTIzDQo+PiArJHNjaGVtYTogaHR0cDovL3NjYW5tYWlsLnRy
dXN0d2F2ZS5jb20vP2M9MjA5ODgmZD0xOFA0NU5XYVI0VjZwWHRfa3Vpdk5DaVZBWENtM0M3TUVG
dnE4Qi1aalEmdT1odHRwJTNhJTJmJTJmZGV2aWNldHJlZSUyZW9yZyUyZm1ldGEtc2NoZW1hcyUy
ZmNvcmUlMmV5YW1sJTIzDQo+PiArDQo+PiArdGl0bGU6IE1hcnZlbGwgTkFORCBGbGFzaCBDb250
cm9sbGVyIChORkMpDQo+PiArDQo+PiArbWFpbnRhaW5lcnM6DQo+PiArICAtIE1pcXVlbCBSYXlu
YWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+PiArDQo+PiArcHJvcGVydGllczoNCj4+
ICsgIGNvbXBhdGlibGU6DQo+PiArICAgIG9uZU9mOg0KPj4gKyAgICAgIC0gaXRlbXM6DQo+PiAr
ICAgICAgICAgIC0gY29uc3Q6IG1hcnZlbGwsYXJtYWRhLThrLW5hbmQtY29udHJvbGxlcg0KPj4g
KyAgICAgICAgICAtIGNvbnN0OiBtYXJ2ZWxsLGFybWFkYTM3MC1uYW5kLWNvbnRyb2xsZXINCj4+
ICsgICAgICAtIGVudW06DQo+PiArICAgICAgICAgIC0gbWFydmVsbCxhcm1hZGEtOGstbmFuZC1j
b250cm9sbGVyDQo+PiArICAgICAgICAgIC0gbWFydmVsbCxhcm1hZGEzNzAtbmFuZC1jb250cm9s
bGVyDQo+PiArICAgICAgICAgIC0gbWFydmVsbCxweGEzeHgtbmFuZC1jb250cm9sbGVyDQo+PiAr
ICAgICAgLSBkZXNjcmlwdGlvbjogbGVnYWN5IGJpbmRpbmdzDQo+PiArICAgICAgICBkZXByZWNh
dGVkOiB0cnVlDQo+PiArICAgICAgICBlbnVtOg0KPj4gKyAgICAgICAgICAtIG1hcnZlbGwsYXJt
YWRhLThrLW5hbmQNCj4+ICsgICAgICAgICAgLSBtYXJ2ZWxsLGFybWFkYTM3MC1uYW5kDQo+PiAr
ICAgICAgICAgIC0gbWFydmVsbCxweGEzeHgtbmFuZA0KPj4gKw0KPj4gKyAgcmVnOg0KPj4gKyAg
ICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgaW50ZXJydXB0czoNCj4+ICsgICAgbWF4SXRlbXM6
IDENCj4+ICsNCj4+ICsgIGNsb2NrczoNCj4+ICsgICAgZGVzY3JpcHRpb246DQo+PiArICAgICAg
U2hhbGwgcmVmZXJlbmNlIHRoZSBOQU5EIGNvbnRyb2xsZXIgY2xvY2tzLCB0aGUgc2Vjb25kIG9u
ZSBpcw0KPj4gKyAgICAgIGlzIG9ubHkgbmVlZGVkIGZvciB0aGUgQXJtYWRhIDdLLzhLIFNvQ3MN
Cj4+ICsgICAgbWluSXRlbXM6IDENCj4+ICsgICAgbWF4SXRlbXM6IDINCj4+ICsNCj4+ICsgIGNs
b2NrLW5hbWVzOg0KPj4gKyAgICBtaW5JdGVtczogMQ0KPj4gKyAgICBpdGVtczoNCj4+ICsgICAg
ICAtIGNvbnN0OiBjb3JlDQo+PiArICAgICAgLSBjb25zdDogcmVnDQo+PiArDQo+PiArICBkbWFz
Og0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgZG1hLW5hbWVzOg0KPj4gKyAgICBp
dGVtczoNCj4+ICsgICAgICAtIGNvbnN0OiBkYXRhDQo+PiArDQo+PiArICBtYXJ2ZWxsLHN5c3Rl
bS1jb250cm9sbGVyOg0KPj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0
aW9ucy9waGFuZGxlDQo+PiArICAgIGRlc2NyaXB0aW9uOiBTeXNjb24gbm9kZSB0aGF0IGhhbmRs
ZXMgTkFORCBjb250cm9sbGVyIHJlbGF0ZWQgcmVnaXN0ZXJzDQo+PiArDQo+PiArcGF0dGVyblBy
b3BlcnRpZXM6DQo+PiArICAiXm5hbmRAWzAtM10kIjoNCj4+ICsgICAgdHlwZTogb2JqZWN0DQo+
PiArICAgIHVuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4+ICsgICAgcHJvcGVydGllczoN
Cj4+ICsgICAgICByZWc6DQo+PiArICAgICAgICBtaW5pbXVtOiAwDQo+PiArICAgICAgICBtYXhp
bXVtOiAzDQo+PiArDQo+PiArICAgICAgbmFuZC1yYjoNCj4+ICsgICAgICAgIG1pbkl0ZW1zOiAx
DQo+IERyb3AgbWluSXRlbXMuDQo+DQo+PiArICAgICAgICBtYXhJdGVtczogMQ0KPiBEaWRuJ3Qg
eW91IGhhdmUgaGVyZSBtaW5pbXVtIGFuZCBtYXhpbXVtPyBJIHRoaW5rIEkgZGlkIG5vdCBhc2sg
dG8NCj4gcmVtb3ZlIHRoZW0uDQo+DQo+PiArDQo+PiArICAgICAgbmFuZC1lY2Mtc3RlcC1zaXpl
Og0KPj4gKyAgICAgICAgY29uc3Q6IDUxMg0KPj4gKw0KPj4gKyAgICAgIG5hbmQtZWNjLXN0cmVu
Z3RoOg0KPj4gKyAgICAgICAgZW51bTogWzEsIDQsIDgsIDEyLCAxNl0NCj4+ICsNCj4+ICsgICAg
ICBuYW5kLW9uLWZsYXNoLWJidDoNCj4+ICsgICAgICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlh
bWwjL2RlZmluaXRpb25zL2ZsYWcNCj4+ICsNCj4+ICsgICAgICBuYW5kLWVjYy1tb2RlOg0KPj4g
KyAgICAgICAgY29uc3Q6IGh3DQo+PiArDQo+PiArICAgICAgbGFiZWw6DQo+PiArICAgICAgICAk
cmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9zdHJpbmcNCj4gRHJvcCBsYWJl
bA0KPg0KPj4gKw0KPj4gKyAgICAgIHBhcnRpdGlvbnM6DQo+PiArICAgICAgICB0eXBlOiBvYmpl
Y3QNCj4gRHJvcCBwYXJ0aXRpb25zLg0KPg0KPj4gKw0KPj4gKyAgICAgIG1hcnZlbGwsbmFuZC1r
ZWVwLWNvbmZpZzoNCj4+ICsgICAgICAgIGRlc2NyaXB0aW9uOiB8DQo+PiArICAgICAgICAgIE9y
ZGVycyB0aGUgZHJpdmVyIG5vdCB0byB0YWtlIHRoZSB0aW1pbmdzIGZyb20gdGhlIGNvcmUgYW5k
DQo+PiArICAgICAgICAgIGxlYXZpbmcgdGhlbSBjb21wbGV0ZWx5IHVudG91Y2hlZC4gQm9vdGxv
YWRlciB0aW1pbmdzIHdpbGwgdGhlbg0KPj4gKyAgICAgICAgICBiZSB1c2VkLg0KPj4gKyAgICAg
ICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvZmxhZw0KPj4gKw0KPj4g
KyAgICAgIG1hcnZlbGwsbmFuZC1lbmFibGUtYXJiaXRlcjoNCj4+ICsgICAgICAgIGRlc2NyaXB0
aW9uOiB8DQo+PiArICAgICAgICAgIFRvIGVuYWJsZSB0aGUgYXJiaXRlciwgYWxsIGJvYXJkcyBi
bGluZGx5IHVzZWQgaXQsDQo+PiArICAgICAgICAgIHRoaXMgYml0IHdhcyBzZXQgYnkgdGhlIGJv
b3Rsb2FkZXIgZm9yIG1hbnkgYm9hcmRzIGFuZCBldmVuIGlmDQo+PiArICAgICAgICAgIGl0IGlz
IG1hcmtlZCByZXNlcnZlZCBpbiBzZXZlcmFsIGRhdGFzaGVldHMsIGl0IG1pZ2h0IGJlIG5lZWRl
ZCB0byBzZXQNCj4+ICsgICAgICAgICAgaXQgKG90aGVyd2lzZSBpdCBpcyBoYXJtbGVzcykuDQo+
PiArICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9mbGFnDQo+
PiArICAgICAgICBkZXByZWNhdGVkOiB0cnVlDQo+PiArDQo+PiArICAgIGFkZGl0aW9uYWxQcm9w
ZXJ0aWVzOiBmYWxzZQ0KPiB1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+DQo+PiArDQo+
PiArICAgIHJlcXVpcmVkOg0KPj4gKyAgICAgIC0gcmVnDQo+PiArICAgICAgLSBuYW5kLXJiDQo+
PiArDQo+IHJlcXVpcmVkOiBibG9jayBnb2VzIGhlcmUNCj4NCj4+ICthbGxPZjoNCj4+ICsgIC0g
JHJlZjogbmFuZC1jb250cm9sbGVyLnlhbWwNCj4+ICsNCj4+ICsgIC0gaWY6DQo+PiArICAgICAg
cHJvcGVydGllczoNCj4+ICsgICAgICAgIGNvbXBhdGlibGU6DQo+PiArICAgICAgICAgIGNvbnRh
aW5zOg0KPj4gKyAgICAgICAgICAgIGNvbnN0OiBtYXJ2ZWxsLHB4YTN4eC1uYW5kLWNvbnRyb2xs
ZXINCj4+ICsgICAgdGhlbjoNCj4+ICsgICAgICByZXF1aXJlZDoNCj4+ICsgICAgICAgIC0gZG1h
cw0KPj4gKyAgICAgICAgLSBkbWEtbmFtZXMNCj4+ICsNCj4+ICsgIC0gaWY6DQo+PiArICAgICAg
cHJvcGVydGllczoNCj4+ICsgICAgICAgIGNvbXBhdGlibGU6DQo+PiArICAgICAgICAgIGNvbnRh
aW5zOg0KPj4gKyAgICAgICAgICAgIGNvbnN0OiBtYXJ2ZWxsLGFybWFkYS04ay1uYW5kLWNvbnRy
b2xsZXINCj4+ICsgICAgdGhlbjoNCj4+ICsgICAgICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAgICAg
Y2xvY2tzOg0KPj4gKyAgICAgICAgICBtaW5JdGVtczogMg0KPj4gKw0KPj4gKyAgICAgICAgY2xv
Y2stbmFtZXM6DQo+PiArICAgICAgICAgIG1pbkl0ZW1zOiAyDQo+PiArDQo+PiArICAgICAgcmVx
dWlyZWQ6DQo+PiArICAgICAgICAtIG1hcnZlbGwsc3lzdGVtLWNvbnRyb2xsZXINCj4+ICsNCj4N
Cj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4=
