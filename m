Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86AE717194
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjE3XUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbjE3XUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:20:31 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73422102
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:20:29 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 8FF822C0596;
        Wed, 31 May 2023 11:20:26 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685488826;
        bh=pBukmPQ3it++bc32Xj8MsVYzyzLTR0p/rymwPyFTAGs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=BYjlzXQYNAH+TTZndsi3Omsk4q6jlYGG9kp5bOIZWJZES36RecojF+CndtM+n25gG
         j0zqQw1itQ5Jo3/yk6rjWLj8uRu+Ul5wdCyXeBzIYHrg9NSntophgYpmJDIYJVBTd0
         MQkPZze968IAHvgBfqNDoDzacGCWFCwiHAbpbx7wUua/QJphwQwkzcbKsthAFokBMR
         +O9AJkLitZrU0btKCt+sHwSoiIJTKDqBSotwyqaXhpDeBzqR4IPRXjqh7JLQx595dY
         rr/QVem53M8zH8X1FY/XkqNgOIK+ERtUisSpVUzvPCUfKT+FyIb79kq1+kthtvJjTt
         R6D5vsK1bn3Og==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B647684ba0001>; Wed, 31 May 2023 11:20:26 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Wed, 31 May 2023 11:20:26 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Wed, 31 May 2023 11:20:26 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Wed, 31 May 2023 11:20:25 +1200
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
        "vadym.kochan@plvision.eu" <vadym.kochan@plvision.eu>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "enachman@marvell.com" <enachman@marvell.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Thread-Topic: [PATCH v6 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML
 DT scheme
Thread-Index: AQHZkpEvY3k2XQch4kKrVAHkTx0+pa9x9QcAgAC3TIA=
Date:   Tue, 30 May 2023 23:20:25 +0000
Message-ID: <bc538264-20f5-03e1-a4a6-6f9f076f15eb@alliedtelesis.co.nz>
References: <20230530005337.3687938-1-chris.packham@alliedtelesis.co.nz>
 <20230530005337.3687938-2-chris.packham@alliedtelesis.co.nz>
 <a1b2caed-b314-59db-ee00-92fc983150f6@linaro.org>
In-Reply-To: <a1b2caed-b314-59db-ee00-92fc983150f6@linaro.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <11A8F379D8E7434AA6EEC968A66617F4@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=jWhIqavZLoxoapoUxmoA:9 a=QEXdDO2ut3YA:10
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

T24gMzEvMDUvMjMgMDA6MjQsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+PiArDQo+PiAr
cHJvcGVydGllczoNCj4+ICsgIGNvbXBhdGlibGU6DQo+PiArICAgIG9uZU9mOg0KPj4gKyAgICAg
IC0gaXRlbXM6DQo+PiArICAgICAgICAgIC0gY29uc3Q6IG1hcnZlbGwsYXJtYWRhLThrLW5hbmQt
Y29udHJvbGxlcg0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBtYXJ2ZWxsLGFybWFkYTM3MC1uYW5k
LWNvbnRyb2xsZXINCj4+ICsgICAgICAtIGVudW06DQo+PiArICAgICAgICAgIC0gbWFydmVsbCxh
cm1hZGEzNzAtbmFuZC1jb250cm9sbGVyDQo+PiArICAgICAgICAgIC0gbWFydmVsbCxweGEzeHgt
bmFuZC1jb250cm9sbGVyDQo+IFlvdSBtaXNzIGhlcmUgZGVwcmVjYXRlZCBjb21wYXRpYmxlcywg
d2hpY2ggYXJlIEJUVyBzdGlsbCB1c2VkLiBEb24ndA0KPiBkcm9wIHByb3BlcnRpZXMgYW5kIGNv
bXBhdGlibGVzIGR1cmluZyBjb252ZXJzaW9uLg0KSXMgdGhlcmUgYW55IHdheSB0byBpbmRpY2F0
ZSB0aGF0IGEgY29tcGF0aWJsZSB2YWx1ZSBpcyBkZXByZWNhdGVkPyBJIA0Ka25vdyBob3cgdG8g
bWFyayBhIHByb3BlcnR5IGFzIGRlcHJlY2F0ZWQgYnV0IGhvdyBkbyBJIGluZGljYXRlIHRoaXMg
Zm9yIA0Kc3BlY2lmaWMgY29tcGF0aWJsZSB2YWx1ZXM/
