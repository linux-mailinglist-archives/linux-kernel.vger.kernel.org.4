Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5CF74FCC8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 03:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjGLBmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 21:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGLBmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 21:42:53 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6226E77;
        Tue, 11 Jul 2023 18:42:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSlEUvihfyJAp5VOgy55+gA0byhOllK6qVCYuQEk9R/U2jMQVp3o35XG9U3MMfsHDhu26GmU8HjrRbOdqygV8n//sVJ2iwtwK+ldvjHrf+YqXTmYCFUbbVuugwmQgNBf+QUvpneSWig8bhUmYUaPYPJCdkYubIwZFd8b+QV45WqCCT6chp6gGn1HgyFs+KI1FLpY11VG+rJuu8ICH3RjiGUquACQXK4n5oT92aI4FjTp6PbhtNLtlYwOJZ6arG3dJVSRxNv61cA8y/83WYCK4VU1Xw7Xkna2MlghFkxvMkcCHVy+MtjTOjWevUD/Dyc6HbQCFpbEM/Ltg7tLDST65g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8QStU5eZdirS4ujzLA6Wukfak1FefmwOXQ9CIklUQo=;
 b=LXGwDz/oePDkaUEzq0FKn2jt/qpPK7/uOIW6dJLl72fHIkB4e1Hk3/p6ywWDcYiPVy+kZigXdanW7oU/CVcameRJRBfNIQbK/O8rLLd/fV7fFnfHyrQPDXU7hq7U6yisfAjk1xyXvtLhbEHXFMq8F8ArwDbaz1+5EkTAasDRDQwKGKG/Ue05ws7UXp/7Xobzf78oH4f1Kz6iXOmz51+C/Lc0X4RnvTtIY8qQbqUnIZfYiI2uqeltN0UpNPvPkLHj7Ctp4gvaj+dFqo0LvT4JTS12+1V/Vu3tsGLfMf6VRRuV8BtCXFsJKoRrUpGp13ZUSBcZ7a6NIqzb8Qw7Pl+gxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8QStU5eZdirS4ujzLA6Wukfak1FefmwOXQ9CIklUQo=;
 b=YartGK2dPG7vSwCM46XgFVCzGoMm5U5XBaCFD3p/Q+woB7ptvehLPrWPt574dSM3oRS54EMaDXdnieCa2IGKwKoJHc0Ha+ry+6TlSxbiph6dNSMndlc2IyVfA9yO+yc8+ORhAhhgJWPm6qKUPytKQfXAcuTrtBIJhAYyucQ+YayHk0X6o2ub0UoH/4LqR5DK74TDPpyYhjHKbVvklaN5ugAp4goUzpbKF23BZI+H3i2q9YK/EiAOOFdlEgzwyUt0cBmGdxd2g6UW/g+a9Etjwd6MwdAuBJcONYkWeHnM5a+t9hy7nAUF7w0bEhBWdiFBFYcGmVt0+McAyy8QFMVuqw==
Received: from DU2PR04CA0158.eurprd04.prod.outlook.com (2603:10a6:10:2b0::13)
 by AM9PR10MB4070.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 01:42:49 +0000
Received: from DB5EUR01FT077.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:2b0:cafe::2c) by DU2PR04CA0158.outlook.office365.com
 (2603:10a6:10:2b0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 01:42:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT077.mail.protection.outlook.com (10.152.5.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 01:42:49 +0000
Received: from CNPEK01M08MSX.ad011.siemens.net (139.24.237.225) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 03:42:48 +0200
Received: from CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) by
 CNPEK01M08MSX.ad011.siemens.net (139.24.237.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 09:42:39 +0800
Received: from CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) by
 CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) with mapi id
 15.01.2507.027; Wed, 12 Jul 2023 09:42:39 +0800
From:   "Li, Hua Qian" <HuaQian.Li@siemens.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "Su, Bao Cheng" <baocheng.su@siemens.com>,
        "huaqianlee@gmail.com" <huaqianlee@gmail.com>,
        "nm@ti.com" <nm@ti.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: watchdog: ti,rti-wdt: Add support for
 WDIOF_CARDRESET
Thread-Topic: [PATCH v2 1/3] dt-bindings: watchdog: ti,rti-wdt: Add support
 for WDIOF_CARDRESET
Thread-Index: AQHZs9iNJlUGxm4aQEuTEnyi5GKohq+z0uKAgAEDkYA=
Date:   Wed, 12 Jul 2023 01:42:36 +0000
Message-ID: <2551edc7e6f499d78d943e25db26769eff837c41.camel@siemens.com>
References: <20230711091713.1113010-1-huaqian.li@siemens.com>
         <20230711091713.1113010-2-huaqian.li@siemens.com>
         <168907041196.552587.9843900798401014394.robh@kernel.org>
In-Reply-To: <168907041196.552587.9843900798401014394.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.24.129.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <26D44C6F9F6E3140AD88F4D52C59399C@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT077:EE_|AM9PR10MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: c61c54d5-3c8a-438b-27c0-08db82794cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRlkLdSrePghXSXyfdawTVolNQ7qe8aLJTAUm9K3IxOvUxssKL735Ct1dQJWdqzMd41ecbJ9Z5otRjcApJrdPfDeCBZA3MDmzXcjOimfwa/JyE2Jkg21QdDMlR+vczdOS+xWojqs0hWxAP1Hv+1QHX+xIQORZtAiU31wpyjI4YOBQqXn4rMRGKXCIzwseJkeva+S/FE3NY/Dz3CIBLtgok1CvG6dZhDxw7a0EGnMJNnyrrHIGSbbS3jPovnuzC+rZmNCquuKm3IAkLrukm/wEqVcOEVzP9XKbQRustTQwrx33zrGZPYWPIwBjhUM5hu6TvXCbsCB8dllVDWqG4Crs3fmeTGosKU7Y1YPMqOShsDCbIVL7hra/LSKtePSiqeQgq/aBXXgZPxG63qbOKpWwhInCp+Kik+79/hD+picdArAp6CiCtSUt6hVL+Fhmd7kRArDL4GMk9A6g36yLINUkMbPGCRaxzdwuMGCfDwJOcbmub2nOGmSJjlCjC4OzY62wwllquPNwoeifPzWK0rN7hgtt21GVeNqSC2O3jK+Dz3N1Qld60LR91GnjlhcM7+QhZRZoDSbRlu8qqAvSk182qVxyV2pJFnPGUTYhS+Bee9YpJYYuEojd32Zo/Gk1+ZP9aHUg17sby78GWfrMlNjQ222eTCFJd4nIIYNnfmcTJlGkSa4yOn1CnF/I3K9MoBp22IjbNhsxeBTcbNJK1Y97ROsifbfZsAO1O0f3uChvpHLDAyE+cViVqmZ5bU8f0cdSs9bOGjrq+IOsyYin62ayw==
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(7416002)(4326008)(6916009)(70586007)(70206006)(316002)(41300700001)(2906002)(8676002)(8936002)(5660300002)(478600001)(54906003)(36860700001)(6666004)(45080400002)(40460700003)(966005)(40480700001)(26005)(186003)(36756003)(83380400001)(336012)(47076005)(81166007)(356005)(82960400001)(82740400003)(82310400005)(956004)(2616005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 01:42:49.4622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c61c54d5-3c8a-438b-27c0-08db82794cdf
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT077.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4070
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

T24gVHVlLCAyMDIzLTA3LTExIGF0IDA0OjEzIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
DQo+IE9uIFR1ZSwgMTEgSnVsIDIwMjMgMTc6MTc6MTEgKzA4MDAsIGh1YXFpYW4ubGlAc2llbWVu
cy5jb23CoHdyb3RlOg0KPiA+IEZyb206IExpIEh1YSBRaWFuIDxodWFxaWFuLmxpQHNpZW1lbnMu
Y29tPg0KPiA+IA0KPiA+IFRJIFJUSSAoUmVhbCBUaW1lIEludGVycnVwdCkgV2F0Y2hkb2cgZG9l
c24ndCBzdXBwb3J0IHRvIHJlY29yZCB0aGUNCj4gPiB3YXRjaGRvZyBjYXVzZS4gQWRkIGEgcmVz
ZXJ2ZWQgbWVtb3J5IHRvIGtub3cgdGhlIGxhc3QgcmVib290IHdhcw0KPiA+IGNhdXNlZA0KPiA+
IGJ5IHRoZSB3YXRjaGRvZyBjYXJkLiBJbiB0aGUgcmVzZXJ2ZWQgbWVtb3J5LCBzb21lIHNwZWNp
ZmljIGluZm8NCj4gPiB3aWxsIGJlDQo+ID4gc2F2ZWQgdG8gaW5kaWNhdGUgd2hldGhlciB0aGUg
d2F0Y2hkb2cgcmVzZXQgd2FzIHRyaWdnZXJlZCBpbiBsYXN0DQo+ID4gYm9vdC4NCj4gPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBMaSBIdWEgUWlhbiA8aHVhcWlhbi5saUBzaWVtZW5zLmNvbT4NCj4g
PiAtLS0NCj4gPiDCoC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3dhdGNoZG9nL3RpLHJ0aS13ZHQu
eWFtbMKgwqDCoCB8IDEzDQo+ID4gKysrKysrKysrKysrLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQs
IDEyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gDQo+IE15IGJvdCBmb3Vu
ZCBlcnJvcnMgcnVubmluZyAnbWFrZSBEVF9DSEVDS0VSX0ZMQUdTPS1tDQo+IGR0X2JpbmRpbmdf
Y2hlY2snDQo+IG9uIHlvdXIgcGF0Y2ggKERUX0NIRUNLRVJfRkxBR1MgaXMgbmV3IGluIHY1LjEz
KToNCj4gDQo+IHlhbWxsaW50IHdhcm5pbmdzL2Vycm9yczoNCj4gLi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvd2F0Y2hkb2cvdGkscnRpLXdkdC55YW1sOjMwOjE4Og0KPiBbZXJy
b3JdIHN5bnRheCBlcnJvcjogbWFwcGluZyB2YWx1ZXMgYXJlIG5vdCBhbGxvd2VkIGhlcmUgKHN5
bnRheCkNCj4gDQo+IGR0c2NoZW1hL2R0YyB3YXJuaW5ncy9lcnJvcnM6DQo+IG1ha2VbMl06ICoq
KiBEZWxldGluZyBmaWxlDQo+ICdEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvd2F0
Y2hkb2cvdGkscnRpLXdkdC5leGFtcGxlLmR0cycNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3dhdGNoZG9nL3RpLHJ0aS13ZHQueWFtbDozMDoxODoNCj4gbWFwcGluZyB2YWx1
ZXMgYXJlIG5vdCBhbGxvd2VkIGluIHRoaXMgY29udGV4dA0KPiBtYWtlWzJdOiAqKiogW0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9NYWtlZmlsZToyNjoNCj4gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3dhdGNoZG9nL3RpLHJ0aS13ZHQuZXhhbXBsZS5kdHNdDQo+
IEVycm9yIDENCj4gbWFrZVsyXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4N
Cj4gLi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvd2F0Y2hkb2cvdGkscnRpLXdk
dC55YW1sOjMwOjE4Og0KPiBtYXBwaW5nIHZhbHVlcyBhcmUgbm90IGFsbG93ZWQgaW4gdGhpcyBj
b250ZXh0DQo+IC9idWlsZHMvcm9iaGVycmluZy9kdC1yZXZpZXctDQo+IGNpL2xpbnV4L0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy93YXRjaGRvZy90aSxydGktd2R0LnlhbWw6DQo+
IGlnbm9yaW5nLCBlcnJvciBwYXJzaW5nIGZpbGUNCj4gbWFrZVsxXTogKioqIFsvYnVpbGRzL3Jv
YmhlcnJpbmcvZHQtcmV2aWV3LWNpL2xpbnV4L01ha2VmaWxlOjE1MDA6DQo+IGR0X2JpbmRpbmdf
Y2hlY2tdIEVycm9yIDINCj4gbWFrZTogKioqIFtNYWtlZmlsZToyMzQ6IF9fc3ViLW1ha2VdIEVy
cm9yIDINCj4gDQo+IGRvYyByZWZlcmVuY2UgZXJyb3JzIChtYWtlIHJlZmNoZWNrZG9jcyk6DQo+
IA0KPiBTZWUNCj4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2RldmljZXRy
ZWUtYmluZGluZ3MvcGF0Y2gvMjAyMzA3MTEwOTE3MTMuMTExMzAxMC0yLWh1YXFpYW4ubGlAc2ll
bWVucy5jb20NCj4gDQo+IFRoZSBiYXNlIGZvciB0aGUgc2VyaWVzIGlzIGdlbmVyYWxseSB0aGUg
bGF0ZXN0IHJjMS4gQSBkaWZmZXJlbnQNCj4gZGVwZW5kZW5jeQ0KPiBzaG91bGQgYmUgbm90ZWQg
aW4gKnRoaXMqIHBhdGNoLg0KPiANCj4gSWYgeW91IGFscmVhZHkgcmFuICdtYWtlIGR0X2JpbmRp
bmdfY2hlY2snIGFuZCBkaWRuJ3Qgc2VlIHRoZSBhYm92ZQ0KPiBlcnJvcihzKSwgdGhlbiBtYWtl
IHN1cmUgJ3lhbWxsaW50JyBpcyBpbnN0YWxsZWQgYW5kIGR0LXNjaGVtYSBpcyB1cA0KPiB0bw0K
PiBkYXRlOg0KPiANCj4gcGlwMyBpbnN0YWxsIGR0c2NoZW1hIC0tdXBncmFkZQ0KPiANCj4gUGxl
YXNlIGNoZWNrIGFuZCByZS1zdWJtaXQgYWZ0ZXIgcnVubmluZyB0aGUgYWJvdmUgY29tbWFuZCB5
b3Vyc2VsZi4NCj4gTm90ZQ0KPiB0aGF0IERUX1NDSEVNQV9GSUxFUyBjYW4gYmUgc2V0IHRvIHlv
dXIgc2NoZW1hIGZpbGUgdG8gc3BlZWQgdXANCj4gY2hlY2tpbmcNCj4geW91ciBzY2hlbWEuIEhv
d2V2ZXIsIGl0IG11c3QgYmUgdW5zZXQgdG8gdGVzdCBhbGwgZXhhbXBsZXMgd2l0aCB5b3VyDQo+
IHNjaGVtYS4NCj4gDQpUaGFua3MgZm9yIHRoZSB0ZXN0IGFuZCB5b3VyIGFkdmljZSwgSSB3aWxs
IG1ha2Ugc3VyZSB0aGlzIGlzIG5vDQpwcm9ibGVtIGluIHRoZSBuZXh0IHZlcnNpb24uDQo=
