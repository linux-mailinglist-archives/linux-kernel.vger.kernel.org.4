Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA26747CE9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjGEGTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjGEGTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:19:09 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5541D10E2;
        Tue,  4 Jul 2023 23:19:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IamAG4T+Inwx0ReYuVb9seV3628jg71HUzO4RGxgn2sE3nxMcygmYJ7QKfhqErAv59b3uUb1s8OBSCJ5MpVHGa4rfnYUYd+3+Hu0qOgSu3VfAyzchcgEFrpXgnaXVzFN+V4z6tNeB+PEjwzzGL9P9Dzyq67BhQVi3jNzQ1+4SacRneVFVglBwWCOPrlUY2ryETui+fSuT9Qpc0axMjo/HcETjDVTPd9VKroEvZ5JxrUyK7gh46jsNwUxmXYG/FifV5XNtW2QUuUMwy/kzZFCYKL4q11pIolUmCt9qqzsPrvxiIPj2gTPIyI2XLO0gp4ckgjbBXUF2RdNEDI/skkhLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vefPpZ1gatX7wQ0eFFGhOyLt8HILICJlthgefTzFBNs=;
 b=FegqMNeMgOgvYGv+3Mg0bbz67AHDWlcfvfeddB4ydSz5i5GUHy19d+HkEwIziRNZJnNgx5cNR4zw27nL6+CvuK9E/2sMNSXQr99Pfb0rrUfqipxd8j5CACekjasEOVr4Kfivtc+z811EG1xgHl3kIs55+Poccgo8TfeTygG7faA/owmABvW8w2SBDiNXBEQJBPOVQgUrpG3sN46Wi+jUHlZfINmpUsAE+c9sCqva8cG/K5WqmdBnB5prLLijrBx6uMnD6TElAkN0iY4+QcqDShetb+yDtnhl7IVL4l/LcAEOJFMrBjiLbIRiz6cRzesLjXhZKUYJh3uM13MukdEKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vefPpZ1gatX7wQ0eFFGhOyLt8HILICJlthgefTzFBNs=;
 b=PfKrEQJZGhx7tNLN6S7FIjlibqQzpujr0ManD4euauKyyIlDDYtIrMBX+d5vopG+HlKo9/1xXE4FuXVCct4WMcfuYDZwphsAJ3ZsiIJN/6nlfVxUR+A5V6av/jp8CT/ByhHiGBK5em7KK789o6JFL7X/sacnDBoi/z9ciixumbc3pHjD1HHN98X31zqwZjJa64CaLR/432Ymbsi/G8dsZtXz4RIrK/cnrPk2veKWaQTp238lPkuLZXTZJ9s7fW+2CkFsAcAeA3/MX+psedNqFjzhGiYrz4WxmRvERW9wYIa1JwYQoN4vMj5eh+HqzTx/czkEDX77r4enCFvicIwcXA==
Received: from FR3P281CA0184.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a4::19)
 by DU0PR10MB6702.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:402::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 06:19:05 +0000
Received: from VE1EUR01FT022.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:a4:cafe::b7) by FR3P281CA0184.outlook.office365.com
 (2603:10a6:d10:a4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 06:19:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 VE1EUR01FT022.mail.protection.outlook.com (10.152.2.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.18 via Frontend Transport; Wed, 5 Jul 2023 06:19:04 +0000
Received: from CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 5 Jul 2023 08:19:03 +0200
Received: from CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) by
 CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 14:18:58 +0800
Received: from CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) by
 CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) with mapi id
 15.01.2507.027; Wed, 5 Jul 2023 14:18:58 +0800
From:   "Li, Hua Qian" <HuaQian.Li@siemens.com>
To:     "conor@kernel.org" <conor@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Su, Bao Cheng" <baocheng.su@siemens.com>,
        "huaqianlee@gmail.com" <huaqianlee@gmail.com>,
        "nm@ti.com" <nm@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: watchdog: ti,rti-wdt: Add support for
 WDIOF_CARDRESET
Thread-Topic: [PATCH 1/3] dt-bindings: watchdog: ti,rti-wdt: Add support for
 WDIOF_CARDRESET
Thread-Index: AQHZrVrq4sdOci+xdESek4b3DXmzGq+npxwAgADIsACAACUgAIAADP+AgACsHQCAAOJLAA==
Date:   Wed, 5 Jul 2023 06:18:58 +0000
Message-ID: <3137d87e56ef75ba0b8a923d407b2fecace6ccbd.camel@siemens.com>
References: <20230703030201.381394-1-huaqian.li@siemens.com>
         <1478c166-698a-864a-3249-d310ae744486@linaro.org>
         <deb70bd23ec5b2cc6afad052aa38dd4048b16285.camel@siemens.com>
         <2b4a5a66-cd67-2fa4-ce2e-03a795fcb041@linaro.org>
         <5d35ed8e6af17c6e8e0d2418cad2317cb9ad3eb7.camel@siemens.com>
         <20230704-revisit-punctured-f7342a00926b@spud>
In-Reply-To: <20230704-revisit-punctured-f7342a00926b@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.24.108.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <005FAA111E5DF8408B560B8728463FD6@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT022:EE_|DU0PR10MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: 1acd55dc-00a8-4513-9968-08db7d1fbba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N7rASQcHb4buWIimuZ+/fFJ9uY1mNdft91hJTng4CuGscmaZTtK0LiQ2MF/8Rxt35fKCLQn62n4qjgsrKK2eoSXhnMrPknwEXjfLQB030mSxyVjyGeLZ9cRB/78zeL+aPEVe0MML+qjltfF4qOgJq0jZV9Z26upz5RNDk6cBwYfMVpZMJkG9G9LVLs3CqLlGqYzsbENbetakfoWXUcKe6NnhhFVjvoW8VWAAdY3LLd7qGYMybEJ230L+KPvlCDALWvFwNdYmQO5sJX/nDK7PSd7ivVkNlpFkxW5OKPhHOroSnpkDj/1Y+zCORburnYhU3pkL9wvb/ZtNWJaDbpMXUzTN1Ru8xmyTfJR9nQNuMgIuEEIziE+bmQRb+el2hIPnLKwTGJWvgcYJDeTFY98D6zihm2+Vi2i84XTN594eur1Nm1L97WVgScto5SxaWMHOoMSZnK+YlKLQSnuU5ot6YS8lIfZ2vqTzE8IaxKIH+knDAh1U74DH6jf1X1nU9yvFhQy3p3owf2eXlrhBaxKv5ZdpbjdNATgoMuUa+k6Nop22jlKa4rDXblAUds16pDAdXjAIBf9LqxWliZDXRuuMrR1+I6UTna1FtzjmvYDVh8qby6BED7JGRr6pzoNPP2/xHpIHS2r0DwbQsaJZEbTDbTgDEyspdp98FoTU7I+lnKiz05/aa+53YcX0s8IYOitiVPjl8DBnVhDI1uYfn5GDEjj/666tTgib6o58sFqfAg0LGi00I0J1bIXA7s5vUiuO
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(54906003)(36860700001)(47076005)(2616005)(336012)(956004)(36756003)(40460700003)(86362001)(40480700001)(70586007)(2906002)(82310400005)(53546011)(186003)(26005)(70206006)(7596003)(356005)(7636003)(82740400003)(82960400001)(6916009)(4326008)(316002)(41300700001)(8936002)(8676002)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:19:04.7588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1acd55dc-00a8-4513-9968-08db7d1fbba7
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT022.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6702
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTA0IGF0IDE3OjQ4ICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFR1ZSwgSnVsIDA0LCAyMDIzIGF0IDA2OjMzOjAxQU0gKzAwMDAsIExpLCBIdWEgUWlhbiB3
cm90ZToNCj4gPiBPbiBUdWUsIDIwMjMtMDctMDQgYXQgMDc6NDYgKzAyMDAsIEtyenlzenRvZiBL
b3psb3dza2kgd3JvdGU6DQo+ID4gPiBPbiAwNC8wNy8yMDIzIDA1OjMzLCBMaSwgSHVhIFFpYW4g
d3JvdGU6DQo+ID4gPiA+IE9uIE1vbiwgMjAyMy0wNy0wMyBhdCAxNzozNSArMDIwMCwgS3J6eXN6
dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPiA+ID4gPiBPbiAwMy8wNy8yMDIzIDA1OjAxLCBodWFx
aWFuLmxpQHNpZW1lbnMuY29twqB3cm90ZToNCj4gPiA+ID4gPiA+IEZyb206IExpIEh1YSBRaWFu
IDxodWFxaWFuLmxpQHNpZW1lbnMuY29tPg0KPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ICsN
Cj4gPiA+ID4gPiA+ICvCoCBtZW1vcnktc2l6ZToNCj4gPiA+ID4gPiA+ICvCoMKgwqAgbWF4SXRl
bXM6IDENCj4gPiA+ID4gPiA+ICvCoMKgwqAgZGVzY3JpcHRpb246DQo+ID4gPiA+ID4gPiArwqDC
oMKgwqDCoCBDb250YWlucyB0aGUgd2F0Y2hkb2cgcmVzZXJ2ZWQgbWVtb3J5IHNpemUuDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gVGhlcmUgaXMgbm8gc3VjaCBwcm9wZXJ0eSBpbiByZXNlcnZlZC1t
ZW1vcnkgY29uc3VtZXINCj4gPiA+ID4gPiBiaW5kaW5ncy4uLg0KPiA+ID4gPiA+IEkNCj4gPiA+
ID4gPiBtZWFuLCB3aGF0IHNpemU/IE1pc3NpbmcgdHlwZS9yZWYgYW55d2F5Lg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IEJlc3QgcmVnYXJkcywNCj4gPiA+ID4gPiBLcnp5c3p0b2YNCj4gPiA+ID4g
DQo+ID4gPiA+IEFjdHVhbGx5LCBJIHdhc24ndCBhIGJpZyBmYW4gb2YgdGhlIGN1cnJlbnQgYmlu
ZGluZyBhbmQNCj4gPiA+ID4gcHJvcGVydGllcw0KPiA+ID4gPiBkZWZpbml0aW9uLiBJIHdhbnRl
ZCB0byBkZXNjcmliZSBhIHJlZ2lvbiB3aXRoIHNwZWNpZmljIHNpemUgdG8NCj4gPiA+ID4gcmVz
ZXJ2ZSB0aGUgcmVzZXQgcmVhc29uIGluIHNwZWNpZmljIG1lbW9yeS4gSWYgcG9zc2libGUsDQo+
ID4gPiA+IHBsZWFzZQ0KPiA+ID4gPiBnaXZlDQo+ID4gPiA+IG1lIHNvbWUgYWR2aWNlLCB0aGFu
a3MhDQo+ID4gPiANCj4gPiA+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IGRvIHlvdSBuZWVkIGhl
cmUuIFRoZXJlIGlzIGEgc2l6ZSBhbHJlYWR5DQo+ID4gPiAtDQo+ID4gPiBqdXN0DQo+ID4gPiBv
cGVuIHlvdXIgRFRTLi4uDQo+ID4gPiANCj4gPiA+IEJlc3QgcmVnYXJkcywNCj4gPiA+IEtyenlz
enRvZg0KPiA+ID4gDQo+ID4gWWVzLCB5b3UgYXJlIHJpZ2h0LCB3cml0aW5nIHRoZW0gaGVyZSBs
b29rcyBzdHJhbmdlLiBJIHdhcyB0cmVhdGluZw0KPiA+IHRoZW0gYXMgcGFydCBvZiBoYXJkd2Fy
ZSwgdGhlbiBmZWx0IGl0IGlzIGJldHRlciB0byBkZWZpbmUgaW4gZHRzLsKgDQo+ID4gDQo+ID4g
SWYgSSBkZWZpbmUgdGhlbSBpbiBkcml2ZXIgZGlyZWN0bHksIGFzc3VtZSB0aGUgZm9sbG93aW5n
LCBkbyB5b3UNCj4gPiB0aGluaw0KPiA+IGl0IGlzIGEgZ29vZCBpZGVhPw0KPiA+IA0KPiA+IC8v
IGZpbGU6IGRyaXZlcnMvd2F0Y2hkb2cvcnRpX3dkdC5jIA0KPiA+ICNkZWZpbmUgUE9OX1JFQVNP
Tl9BRERSIDB4QTIwMDAwMDANCj4gPiAjZGVmaW5lIFBPTl9SRUFTT05fU0laRSAweDEwMDANCj4g
DQo+IEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGlzLCB3aHkgY2FuIHlvdSBub3QganVzdCB1c2UgYSBy
ZWcgZW50cnk/DQo+IA0KSSBwZXJzb25hbGx5IHRob3VnaHQgaXQgd2FzIG5vdCBnb29kIHRvIHdy
aXRlIGxpa2UgdGhpcyBiZWZvcmUgYmVjYXVzZQ0KdGhpcyByZWdpb24gaXMgYSBjdXN0b21pemVk
IHJlc2VydmVkIHJlZ2lvbiBub3QgdGhlIGRldmljZSdzIHJlc291cmNlcy4NCg0KQW55d2F5LCBJ
IGN1cnJlbnRseSB0aGluayBpdCBpcyB0aGUgYmVzdCB3YXksIGFuZCBJIHBsYW4gdG8gcmVmYWN0
b3IgaXQNCmxpa2UgdGhpcy4NCg0KQW55IG90aGVyIHN1Z2dlc3Rpb25zIHBsZWFzZSBsZXQgbWUg
a25vdywgdGhhbmtzIQ0KDQpCZXN0IFJlZ2FyZHMsDQpIdWEgcWlhbg0K
