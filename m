Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507F574FCC2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 03:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjGLBkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 21:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjGLBkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 21:40:40 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4597BE60;
        Tue, 11 Jul 2023 18:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWMDtjJ7aXAlwW8hQebXu4OpoJC4j9qacsGMXq3py4YYr3ktdU9jyW+SiSh8KuV7HIjGSacQ/GHm/s7nbJn9Xk+GZnfdzpyF3Ye/y451u2FzTmXuTdP9ApHx3tK+YUeM9RtjOTwFpkp9OeGem1REbD3itF9tES7jsk8x2KDJJhLlHONIWK5sfHqiw4Ufy+OzY2ch03eoQmxJpcxvsFPC2P9VO+YqA8yeVIf8s/M1P1ZWt/4AbmlUS5luQ46NAFCYEnwjHXzec088y8QMOl/c20B4iYvG1JLpvjJRuvT4MWgBsqzW1eUXu8oJFCYuDPR2KHuZPW1x7wPjLMv5oaU57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZz+ZsdzhQ1Z8fS2H9uzKEqwBjhkXhBMT2zrmO585cQ=;
 b=IXdDBDs8IJ0syLAHYsQ5j6VLySgE4hrrMf/UvgsglgmEUnFK5wqnQ1heE976k7lMfj00qrmoizhEyYg0pGNqTCHM4oCIdi7ulIPehLhhKdFVAoATmoM4eui3TliVWJ3SsOBADcB1huRYaqKlDR4G8/tpBlirmCRvCEXHqmDm+nqcqgTflP2fZfJda1g+rxqFE5+eVznpGadx7v49TcqW/BvWqbXUSmR6DaC9qNbOYU/AIrwm8jpFKsIp59kDjtIAjT00zyJZBFckptXX/ev/fluHwOKbrcAtkLb/nuasHoZAftX2hRM0NKda9aFRD2V+qqHQMBoghRdqvO/7VaIaSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=linux-watchdog.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZz+ZsdzhQ1Z8fS2H9uzKEqwBjhkXhBMT2zrmO585cQ=;
 b=WdTew4k8O8DRWEEHP2cJrlQJl7N7GuQkMj5ZZ5F9pVAGFvPTQrpUxa6lNcAXNqzmC9Oyg/oXvkJKz51MyTboQi2qleU03Yn3WIQzpCFcUU+ZrrOa2zG/CXV2hvY6vbyPQ/kEN6Os21ySITNjShyTY5tz2+TUlmCMpGH/QgBchBRDd0gYDCouPTlZth6VIH3USbHmdcqGXla+4XHjTEUHZb1vCMYiSEEafxA8QMhCKEU0REY24vuix5ct440VoEe9DHsyOmbo8ZbPnkOFpmWZrZyPXMeUYZfYUMC0An9Itgs4ZtwFug1L0VuiM39G1PllI/pSNe07cuVrG1kwwSg9yw==
Received: from DUZP191CA0032.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::10)
 by PAVPR10MB6914.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Wed, 12 Jul
 2023 01:40:35 +0000
Received: from DB5EUR01FT078.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:4f8:cafe::88) by DUZP191CA0032.outlook.office365.com
 (2603:10a6:10:4f8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 01:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT078.mail.protection.outlook.com (10.152.5.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 01:40:35 +0000
Received: from CNPEK01M10MSX.ad011.siemens.net (139.24.237.228) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.30; Wed, 12 Jul 2023 03:40:34 +0200
Received: from CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) by
 CNPEK01M10MSX.ad011.siemens.net (139.24.237.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 09:40:32 +0800
Received: from CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) by
 CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) with mapi id
 15.01.2507.027; Wed, 12 Jul 2023 09:40:32 +0800
From:   "Li, Hua Qian" <HuaQian.Li@siemens.com>
To:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "kristo@kernel.org" <kristo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "huaqianlee@gmail.com" <huaqianlee@gmail.com>,
        "nm@ti.com" <nm@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Su, Bao Cheng" <baocheng.su@siemens.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: watchdog: ti,rti-wdt: Add support for
 WDIOF_CARDRESET
Thread-Topic: [PATCH v2 1/3] dt-bindings: watchdog: ti,rti-wdt: Add support
 for WDIOF_CARDRESET
Thread-Index: AQHZs9iNJlUGxm4aQEuTEnyi5GKohq+zxPQAgAEQ6AA=
Date:   Wed, 12 Jul 2023 01:40:32 +0000
Message-ID: <19bf680470e4b0c38f9182be621d3b75151740be.camel@siemens.com>
References: <20230711091713.1113010-1-huaqian.li@siemens.com>
         <20230711091713.1113010-2-huaqian.li@siemens.com>
         <8d52eaa7-0934-97fd-0288-9e8ed2f82bee@linaro.org>
In-Reply-To: <8d52eaa7-0934-97fd-0288-9e8ed2f82bee@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.24.129.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <66AD5BA7E6EA75468F7E5581A1ED1939@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT078:EE_|PAVPR10MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: ed566bf6-98e3-4afc-9b70-08db8278fd05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UBxtTVe7SB80jnsBaHoDDGUlAMQ6pHuEYpCVCzRfhuYsi+FiMee+zy7E5p14rLqMOVjM4fwXX5oqwc59pQbX6hsHowbDqpUSamgWnCEQ2C3jr8lkY6kswX56YRgjPPZDBRiKafdFLsknjKq+yeYF9NBXmft9xWoBRd/089lm5X1ugVA0HixkvMvCPuYhs9+1n46B5i15FHXAnhta+jMtmlAE2skt1DZFk4xfMAUEmKeKHt0v/LuLB3F3S56JpWhpHjW+Fl68rWfK9mta5SPOKa/LKzvXGsiTpuysfa7l8IYLBObbx6vRfFnv1pdppOerwHVUy0ui2Boe2WDMqMejS0ZFqBrIB5N/Gf7UWeiePeEXsCBHnguC9CbOwc6fl6PiKnoFaej8jhYPgdpPJ2DSphCgztCk5N4k8ceVda2NMdMZNpSTYWneVI1VAQnwLJqNbEgoJ8NwiVeAAG3/E1Zt5wnlzcIM7SDVoRzQdAhggUUrYs9YqbmBo1gb2nBahS+hHILoeTtlmA1GJ7NadV+SBo0M8KKKfEIhYS+QYRXSkklbJ8kP/LGuhMWB0nQhFrb3lfpwZoKZidi+ULmoFpP1irzheo9Fvn2rGWRgIu0BQ1D7LiijTfICa7ovVTNFIUjSuQYBlOzHWmkY41D70H3IpoghZx+M518lrqhJTb5XKU5Qv00xcitSpyGZSANQXs4jKB6EiWXYwP3zq5bPaaTxppEsi4Bmf6zdtIODN2/IohhNlfkmKdwxUAIq6stGouJRWlDq5BhvO/u0fjil4a4VQQ==
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(45080400002)(478600001)(110136005)(54906003)(336012)(47076005)(36860700001)(83380400001)(2616005)(956004)(53546011)(40460700003)(86362001)(36756003)(40480700001)(70586007)(2906002)(82310400005)(4326008)(186003)(26005)(966005)(356005)(82740400003)(316002)(82960400001)(81166007)(8936002)(8676002)(5660300002)(41300700001)(7416002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 01:40:35.5121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed566bf6-98e3-4afc-9b70-08db8278fd05
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT078.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6914
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

T24gVHVlLCAyMDIzLTA3LTExIGF0IDExOjIzICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxMS8wNy8yMDIzIDExOjE3LCBodWFxaWFuLmxpQHNpZW1lbnMuY29twqB3cm90
ZToNCj4gPiBGcm9tOiBMaSBIdWEgUWlhbiA8aHVhcWlhbi5saUBzaWVtZW5zLmNvbT4NCj4gPiAN
Cj4gPiBUSSBSVEkgKFJlYWwgVGltZSBJbnRlcnJ1cHQpIFdhdGNoZG9nIGRvZXNuJ3Qgc3VwcG9y
dCB0byByZWNvcmQgdGhlDQo+ID4gd2F0Y2hkb2cgY2F1c2UuIEFkZCBhIHJlc2VydmVkIG1lbW9y
eSB0byBrbm93IHRoZSBsYXN0IHJlYm9vdCB3YXMNCj4gPiBjYXVzZWQNCj4gPiBieSB0aGUgd2F0
Y2hkb2cgY2FyZC4gSW4gdGhlIHJlc2VydmVkIG1lbW9yeSwgc29tZSBzcGVjaWZpYyBpbmZvDQo+
ID4gd2lsbCBiZQ0KPiA+IHNhdmVkIHRvIGluZGljYXRlIHdoZXRoZXIgdGhlIHdhdGNoZG9nIHJl
c2V0IHdhcyB0cmlnZ2VyZWQgaW4gbGFzdA0KPiA+IGJvb3QuDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogTGkgSHVhIFFpYW4gPGh1YXFpYW4ubGlAc2llbWVucy5jb20+DQo+ID4gLS0tDQo+IA0K
PiBNaXNzaW5nIGNoYW5nZWxvZy4NClRoYW5rcyBmb3IgcG9pbnRpbmcgb3V0Lg0KPiANCj4gPiDC
oC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3dhdGNoZG9nL3RpLHJ0aS13ZHQueWFtbMKgwqDCoCB8
IDEzDQo+ID4gKysrKysrKysrKysrLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3dhdGNoZG9nL3RpLHJ0aS0NCj4gPiB3ZHQueWFtbCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy93YXRjaGRvZy90aSxydGktDQo+ID4gd2R0
LnlhbWwNCj4gPiBpbmRleCBmYzU1MzIxMWU0MmQuLmYyMjdkYjA4ZGM3MCAxMDA2NDQNCj4gPiAt
LS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvd2F0Y2hkb2cvdGkscnRpLXdk
dC55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3dhdGNo
ZG9nL3RpLHJ0aS13ZHQueWFtbA0KPiA+IEBAIC0yNiw3ICsyNiwxOCBAQCBwcm9wZXJ0aWVzOg0K
PiA+IMKgwqDCoMKgwqDCoCAtIHRpLGo3LXJ0aS13ZHQNCj4gPiDCoA0KPiA+IMKgwqAgcmVnOg0K
PiA+IC3CoMKgwqAgbWF4SXRlbXM6IDENCj4gPiArwqDCoMKgIG1heEl0ZW1zOiAyDQo+IA0KPiBU
aGUgZXhwZWN0ZWQgc3ludGF4IGlzIGluIHN1Y2ggY2FzZToNCj4gwqAgaXRlbXM6DQo+IMKgwqDC
oCAtIGRlc2NyaXB0aW9uOiAuLi4NCj4gwqDCoMKgIC0gZGVzY3JpcHRpb246IC4uLg0KPiANCj4g
WW91IHdpbGwgZmluZCBwbGVudHkgb2YgZXhhbXBsZXMgZm9yIHRoaXMuDQo+IA0KPiA+ICvCoMKg
wqDCoMKgIGRlc2NyaXB0aW9uOg0KPiA+ICvCoMKgwqDCoMKgwqDCoC0gQ29udGFpbnMgdGhlIGFk
ZHJlc3MgYW5kIHRoZSBzaXplIG9mIE1DVSBSVEkgcmVnaXN0ZXIuDQo+ID4gK8KgwqDCoMKgwqDC
oMKgLSBDb250YWlucyB0aGUgYWRkcmVzcyBhbmQgdGhlIHNpemUgb2YgcmVzZXJ2ZWQgbWVtb3J5
LA0KPiA+IHdoaWNoDQo+IA0KPiBJIGRvbid0IHRoaW5rIENvbm9yIHN1Z2dlc3RlZCB1c2luZyBy
ZWcgb2YgdGhlIGRldmljZSwgYnV0IHJlZyBvZg0KPiByZXNlcnZlZCBtZW1vcnkuIFRoaXMgaXMg
bm90IGRldmljZSBhZGRyZXNzIHNwYWNlLCBidXQganVzdCBzb21lDQo+IHJhbmRvbQ0KPiBtZW1v
cnkuDQo+IA0KPiBtZW1vcnktcmVnaW9uIHNlZW1zIHByb3BlciB0byBtZS4gV2Ugd2VyZSBqdXN0
IGRpc2N1c3NpbmcgdG90YWxseQ0KPiB1c2VsZXNzIG5ldyBwcm9wZXJ0eSBvZiBzaXplLg0KSSBn
dWVzcyBJIG1pc3VuZGVyc3Rvb2Qgd2hhdCBDb25vciBzdWdnZXN0ZWQsIEkgd2lsbCBjaGFuZ2Ug
YmFjayB0bw0KbWVtb3J5LXJlZ2lvbiBhbmQgZ2V0IHNpemUgZnJvbSByZXNlcnZlZC1tZW1vcnku
IERvZXMgdGhpcyBsb29rIGdvb2QNCnRvIHlvdT8NCj4gDQo+IFdoYXQncyBtb3JlIC0geW91IGRp
ZCBub3QgdGVzdCBpdC4uLiBzbyB1c3VhbCB0ZW1wbGF0ZToNCj4gDQo+IEl0IGRvZXMgbm90IGxv
b2sgbGlrZSB5b3UgdGVzdGVkIHRoZSBEVFMgYWdhaW5zdCBiaW5kaW5ncy4gUGxlYXNlIHJ1bg0K
PiBgbWFrZSBkdGJzX2NoZWNrYCAoc2VlDQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy93cml0aW5nLXNjaGVtYS5yc3Qgb3INCj4gaHR0cHM6Ly93d3cubGluYXJvLm9yZy9ibG9n
L3RpcHMtYW5kLXRyaWNrcy1mb3ItdmFsaWRhdGluZy1kZXZpY2V0cmVlLXNvdXJjZXMtd2l0aC10
aGUtZGV2aWNldHJlZS1zY2hlbWEvDQo+IGZvciBpbnN0cnVjdGlvbnMpLg0KPiANCj4gQmVzdCBy
ZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQpTb3JyeSBmb3IgdGhpcywgSSB3aWxsIG1ha2Ugc3Vy
ZSB0aGlzIGlzIG5vIHByb2JsZW0gaW4gdGhlIG5leHQNCnZlcnNpb24uDQoNCkJlc3QgcmVnYXJk
cywNCkxpIEh1YSBRaWFuDQo=
