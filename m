Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5298F74FE11
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 06:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjGLEEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 00:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjGLED6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 00:03:58 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3254F9B;
        Tue, 11 Jul 2023 21:03:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwpqGpsH0lwJGjlWLk+Do4SLqHdSeam2qTvzmtYnTo+I3faxc/nKfim+dxFhPqtCk3NRYU+Uyo4T+sVY6m3gcnB1BH3Dj04cI3cqItIuOjVQ/AIAd7s0rqQVbyw0UIK5AJpjusL261kh1HuWX55KNxfTSlAVXmrtD3N92RWUc1j7uh6b6BTTBki4rSSwfrriHVWGvRpgG94sYEQ1VlUG7GmBxfYZU5hYWKXnqW0GstNZ13R5h1CJG0xhCB4zOImSdCi2sI9ORjOebomRsubbZ+yF3UFDTw+j321e/J2ApwBd0bgjJeg2frEx9XzO/c5MsVI1+x989niLeALUDHuWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLc7ahvRf4/huSDKQ0+B7eoSgNypkZLh6J2x3saZdtM=;
 b=Ga6kpLOsxGc/vLKtSOOLtKy2Zc2m3LAi36G6+Qob/5XPQ1+QHHBiA1hTKiQBHOSJAwJR9laNS7aAtxpYud8HW3pax/Q1w7Hbt/POsxSw8yeQb7TA1RuBZzEysjUOP+ndV8eBlkup/76U5X+fxNWIIFr4pbJTVtRpVn6v6WUQ/hHt+R17tpovk47NhEtNXjXpkLTPwc6wGPzJCd3vuiqGYtxOqJmRsNG+W1ILY6fomUTWH7WcQkItRdhznD2KOfjzA/sqhwQ1bmN3buiyD+b0CvRVQDOw/VjxXvEZUh+2emgcctbv2m+0N5iBmsGh55miMwrInbGU3T3E7KCGZr1S4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLc7ahvRf4/huSDKQ0+B7eoSgNypkZLh6J2x3saZdtM=;
 b=kQ4IHd2m+N92imMx/w7VSbWPrRK85hOZLBycMC77x+lCSTEMu4jujWWzX4kLSOO3uHjTTNRGRjpr5qELRzw65ARnVqwUNybOIiaySgpOpjsi8HLrTtzTyWVEf8hvpiA+4xEb+f3ztUpGOpViX9JKFlDyMyl3dRq6MBJA1+voeZQ/9kj8AB1zNVMfLs7BXHk2p/GVGGGp2Tt9Kr1qpGnsguL1oP8bpvkFlmYYLZ02xR8UouExKxcqwXkLeOvQYMiVX7MG+BP0TBkZhW9c0MZdjSUJX4DpNw5jmszEXTmBGF7PDuV5iSsx9EZqMQkhvR0MGgrUBtX6pELMF7TlMWQQYQ==
Received: from GVYP280CA0018.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:fa::28)
 by PRAPR10MB5153.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:29d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 04:03:54 +0000
Received: from HE1EUR01FT053.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:fa:cafe::cc) by GVYP280CA0018.outlook.office365.com
 (2603:10a6:150:fa::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 04:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT053.mail.protection.outlook.com (10.152.1.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 04:03:53 +0000
Received: from CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 06:03:50 +0200
Received: from CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) by
 CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 12:03:48 +0800
Received: from CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) by
 CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) with mapi id
 15.01.2507.027; Wed, 12 Jul 2023 12:03:48 +0800
From:   "Li, Hua Qian" <HuaQian.Li@siemens.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
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
Subject: Re: [PATCH v2 3/3] watchdog:rit_wdt: Add support for WDIOF_CARDRESET
Thread-Topic: [PATCH v2 3/3] watchdog:rit_wdt: Add support for WDIOF_CARDRESET
Thread-Index: AQHZs9iTW+HS9TjwuU6ojS6PQTnTFq+05GKAgAAZfwA=
Date:   Wed, 12 Jul 2023 04:03:48 +0000
Message-ID: <0d1b15b1016d451862b895f851c6c6c81472755f.camel@siemens.com>
References: <20230711091713.1113010-1-huaqian.li@siemens.com>
         <20230711091713.1113010-4-huaqian.li@siemens.com>
         <165cf95b-663b-5dac-b686-a515f2111656@roeck-us.net>
In-Reply-To: <165cf95b-663b-5dac-b686-a515f2111656@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.24.129.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <769C42A9F12F334E87B40B1F363FBEEF@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT053:EE_|PRAPR10MB5153:EE_
X-MS-Office365-Filtering-Correlation-Id: e67d5cf7-016c-4f05-067f-08db828d019e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6uxeW+9VPK5I7bR3w+TN9fGx3GYOnxqPPd+cyd2HU/bow+k3F6QW8DN+X8cSyJ2h+reFgeYstPGZiW6VqEP+FvUXqPGekS3zdL+N1x8McqwDSGnNA3KRMq9a+X+2/lq2BeJgrGRdF8TD+lT1WziPbKu7dKPCd9NSnUXYwzT4zsQFADDlPMCPqpj2/QHearN4Q8LWtClM1ZDxrz4acSRc7vpqn0P/rYHKEluy1n7fnyIVh40PbnLqgFU7S2jxJWSffI1rAyol98n5hoQEX4rhClo5a50iRE/S0G8hO4JDxvhgsNNigFM1i8MQNeYTTuJDRvgbRcAAdHufDZgd+mn9uzFbKX38GeYFlokhRC5OkyrNRSwiacmvd/hinZLf/VU3XvQHuhPcbtdli8kXHmhj5M3ucQYg21T90KCmV1tskeqYdqJPvi6JStD0e+FNPEk1n6ENrqYfE7gm3wXM7Ksz4qCh6aSNkG970wF2u/3xVjq5cDmNBKGfaizj6ew10oP2mTc23BufQtCUKt7S9hPdfeWGIFfpKh6g158DIJgRbqKu6GoXkh7BtHYrY5Hdi5FT6iJFTrTfWe+NKEKdBa6rEpBUy9sWaZHfwVfUjWsH76yPM6ZCJo4+reJ/7fm7qnrbPUbvDoA0aDigXnkoz4v4pC5CFuvyv/ovFYOQl+9EvHHdv1PwFlCFJ3S/+LxiWZn12rht+Ze5GCiDUa+5raXFR3T9CuDgZnT/HeUt3iHzlG++7Vb+qKfnGlTrEnCNAhFG
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(83380400001)(47076005)(36860700001)(2906002)(956004)(336012)(2616005)(36756003)(82310400005)(86362001)(82740400003)(7636003)(356005)(7596003)(82960400001)(40480700001)(41300700001)(4326008)(316002)(5660300002)(8936002)(8676002)(478600001)(70586007)(70206006)(54906003)(110136005)(26005)(186003)(7416002)(53546011);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 04:03:53.1096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e67d5cf7-016c-4f05-067f-08db828d019e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT053.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5153
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTExIGF0IDE5OjMyIC0wNzAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOgo+
IE9uIDcvMTEvMjMgMDI6MTcsIGh1YXFpYW4ubGlAc2llbWVucy5jb23CoHdyb3RlOgo+ID4gRnJv
bTogTGkgSHVhIFFpYW4gPGh1YXFpYW4ubGlAc2llbWVucy5jb20+Cj4gPiAKPiA+IFRoaXMgcGF0
Y2ggYWRkcyB0aGUgV0RJT0ZfQ0FSRFJFU0VUIHN1cHBvcnQgZm9yIHRoZSBwbGF0Zm9ybQo+ID4g
d2F0Y2hkb2cKPiA+IHdob3NlIGhhcmR3YXJlIGRvZXMgbm90IHN1cHBvcnQgdGhpcyBmZWF0dXJl
LCB0byBrbm93IGlmIHRoZSBib2FyZAo+ID4gcmVib290IGlzIGR1ZSB0byBhIHdhdGNoZG9nIHJl
c2V0Lgo+ID4gCj4gPiBUaGlzIGlzIGRvbmUgdmlhIHJlc2VydmVkIG1lbW9yeShSQU0pLCB3aGlj
aCBpbmRpY2F0ZXMgaWYgc3BlY2lmaWMKPiA+IGluZm8gc2F2ZWQsIHRyaWdnZXJpbmcgdGhlIHdh
dGNoZG9nIHJlc2V0IGluIGxhc3QgYm9vdC4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogTGkgSHVh
IFFpYW4gPGh1YXFpYW4ubGlAc2llbWVucy5jb20+Cj4gPiAtLS0KPiA+IMKgIGRyaXZlcnMvd2F0
Y2hkb2cvcnRpX3dkdC5jIHwgNDgKPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCj4gPiDCoCAxIGZpbGUgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy93YXRjaGRvZy9ydGlfd2R0LmMKPiA+IGIvZHJpdmVycy93YXRj
aGRvZy9ydGlfd2R0LmMKPiA+IGluZGV4IGNlOGYxOGU5M2FhOS4uNzdmZDZiNTQxMzdjIDEwMDY0
NAo+ID4gLS0tIGEvZHJpdmVycy93YXRjaGRvZy9ydGlfd2R0LmMKPiA+ICsrKyBiL2RyaXZlcnMv
d2F0Y2hkb2cvcnRpX3dkdC5jCj4gPiBAQCAtMTgsNiArMTgsNyBAQAo+ID4gwqAgI2luY2x1ZGUg
PGxpbnV4L3BtX3J1bnRpbWUuaD4KPiA+IMKgICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgo+ID4g
wqAgI2luY2x1ZGUgPGxpbnV4L3dhdGNoZG9nLmg+Cj4gPiArI2luY2x1ZGUgPGxpbnV4L29mLmg+
Cj4gPiDCoCAKPiA+IMKgICNkZWZpbmUgREVGQVVMVF9IRUFSVEJFQVQgNjAKPiA+IMKgIAo+ID4g
QEAgLTUyLDYgKzUzLDExIEBACj4gPiDCoCAKPiA+IMKgICNkZWZpbmUgRFdEU1TCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgQklUKDEpCj4gPiDCoCAKPiA+ICsjZGVmaW5lIFBPTl9S
RUFTT05fU09GX05VTcKgwqDCoMKgwqAweEJCQkJDQ0NDCj4gPiArI2RlZmluZSBQT05fUkVBU09O
X01BR0lDX05VTcKgwqDCoDB4REREREREREQKPiA+ICsjZGVmaW5lIFBPTl9SRUFTT05fRU9GX05V
TcKgwqDCoMKgwqAweENDQ0NCQkJCCj4gPiArI2RlZmluZSBQT05fUkVBU09OX0lURU1fQklUU8Kg
wqDCoDB4RkZGRkZGRkYKPiA+ICsKPiA+IMKgIHN0YXRpYyBpbnQgaGVhcnRiZWF0ID0gREVGQVVM
VF9IRUFSVEJFQVQ7Cj4gPiDCoCAKPiA+IMKgIC8qCj4gPiBAQCAtMTk4LDYgKzIwNCwxMSBAQCBz
dGF0aWMgaW50IHJ0aV93ZHRfcHJvYmUoc3RydWN0Cj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHJ0aV93ZHRfZGV2aWNlICp3ZHQ7Cj4gPiDCoMKg
wqDCoMKgwqDCoMKgc3RydWN0IGNsayAqY2xrOwo+ID4gwqDCoMKgwqDCoMKgwqDCoHUzMiBsYXN0
X3BpbmcgPSAwOwo+ID4gK8KgwqDCoMKgwqDCoMKgdTMyIHJlc2VydmVkX21lbV9zaXplOwo+ID4g
K8KgwqDCoMKgwqDCoMKgdW5zaWduZWQgbG9uZyAqdmFkZHI7Cj4gPiArwqDCoMKgwqDCoMKgwqB1
bnNpZ25lZCBsb25nIHBhZGRyOwo+ID4gK8KgwqDCoMKgwqDCoMKgdTMyIGRhdGFbM107Cj4gPiAr
wqDCoMKgwqDCoMKgwqB1MzIgcmVnWzhdOwo+ID4gwqAgCj4gPiDCoMKgwqDCoMKgwqDCoMKgd2R0
ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCp3ZHQpLCBHRlBfS0VSTkVMKTsKPiA+IMKgwqDC
oMKgwqDCoMKgwqBpZiAoIXdkdCkKPiA+IEBAIC0yODQsNiArMjk1LDQzIEBAIHN0YXRpYyBpbnQg
cnRpX3dkdF9wcm9iZShzdHJ1Y3QKPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gwqDCoMKgwqDCoMKgwqDCoH0KPiA+IMKg
IAo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gb2ZfcHJvcGVydHlfcmVhZF92YXJpYWJsZV91MzJf
YXJyYXkocGRldi0KPiA+ID5kZXYub2Zfbm9kZSwgInJlZyIsIHJlZywKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgMCwgQVJSQVlfU0laRShyZWcpKTsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChy
ZXQgPCAwKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2VycihkZXYs
ICJjYW5ub3QgcmVhZCB0aGUgcmVnIGluZm8uXG4iKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBnb3RvIGVycl9pb21hcDsKPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiAKPiBUaGlz
IGFib3J0cyBpZiB0aGUgcHJvcGVydHkgZG9lcyBub3QgZXhpc3QsIHdoaWNoIGlzIHVuYWNjZXB0
YWJsZS4KPiBBbnkgc3VjaCBhZGRpdGlvbiBtdXN0IGJlIG9wdGlvbmFsLgpBZ3JlZSwgcmVmYWN0
b3IgaXQuCj4gCj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqAvKgo+ID4gK8KgwqDCoMKgwqDCoMKg
ICogSWYgcmVzZXJ2ZWQgbWVtb3J5IGlzIGRlZmluZWQgZm9yIHdhdGNoZG9nIHJlc2V0IGNhdXNl
Lgo+ID4gK8KgwqDCoMKgwqDCoMKgICogUmVhZG91dCB0aGUgUG93ZXItb24oUE9OKSByZWFzb24g
YW5kIHBhc3MgdG8gYm9vdHN0YXR1cy4KPiA+ICvCoMKgwqDCoMKgwqDCoCAqLwo+ID4gK8KgwqDC
oMKgwqDCoMKgaWYgKHJldCA9PSA4KSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcGFkZHIgPSByZWdbNV07Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVz
ZXJ2ZWRfbWVtX3NpemUgPSByZWdbN107Cj4gCj4gSXQgc2VlbXMgb2RkIHRoYXQgcmVzZXJ2ZWRf
bWVtX3NpemUgaXMgbm90IGNoZWNrZWQswqAKQUNLCj4gYW5kIHRoYXQgaXQgaXMgZXZlbiBwcm92
aWRlZAo+IGdpdmVuIHRoYXQgaXQgbmVlZHMgdG8gYmUgKGF0IGxlYXN0KSAyNCBieXRlcywgYW5k
IGFueSBvdGhlciB2YWx1ZQo+IGRvZXMgbm90IHJlYWxseQo+IG1ha2Ugc2Vuc2UuCj4gCkkgd2Fz
IHRoaW5rZyB0byBhZGQgdGhlIHJlbGlhYmlsaXR5LCBidXQgaXQgc2VlbXMgdG8gYmUgdW5uZWNl
c3NhcnkgYW5kCnBvaW50bGVzcy4gV2VyZSB5b3Ugc3VnZ2VzdGluZyB0aGF0IDggYnl0ZXMgYXJl
IGVub3VnaD8KCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdmFkZHIgPSBtZW1y
ZW1hcChwYWRkciwgcmVzZXJ2ZWRfbWVtX3NpemUsCj4gPiBNRU1SRU1BUF9XQik7Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHZhZGRyID09IE5VTEwpIHsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2VycihkZXYsICJG
YWlsZWQgdG8gbWFwIG1lbW9yeS0KPiA+IHJlZ2lvbi5cbiIpOwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGVycl9pb21hcDsKPiAKPiBUaGlz
IHJldHVybnMgOCwgd2hpY2ggd291bGQgYmUgYW4gb2RkIGVycm9yIHJldHVybi4KPiAKQUNLLHJl
ZmFjdG9yIGl0Lgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ICsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkYXRhWzBdID0gKnZhZGRyICYgUE9OX1JF
QVNPTl9JVEVNX0JJVFM7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGF0YVsx
XSA9ICoodmFkZHIgKyAxKSAmIFBPTl9SRUFTT05fSVRFTV9CSVRTOwo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGRhdGFbMl0gPSAqKHZhZGRyICsgMikgJiBQT05fUkVBU09OX0lU
RU1fQklUUzsKPiA+ICsKPiAKPiBUaGUgJiBzZWVtcyBwb2ludGxlc3MgLyB3YXN0ZWZ1bC4gV2h5
IGlnbm9yZSB0aGUgdXBwZXIgMzIgYml0cyBvZgo+IGVhY2ggbG9jYXRpb24gPwo+IEVpdGhlciBt
YWtlIGl0IHUzMiBvciBtYWtlIGl0IHU2NCBhbmQgdXNlIHRoZSBlbnRpcmUgNjQgYml0LiBCZXNp
ZGVzLAo+IHZhZGRyWzAuLjJdIHdvdWxkIG1ha2UgdGhlIGNvZGUgbXVjaCBlYXNpZXIgdG8gcmVh
ZC4KPiAKQUNLLCByZWZhY3RvciBpdC4KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBkZXZfZGJnKGRldiwgIldhdGNoZG9nOiBzb2YgPSAlbFgsIGRhdGEgPSAlbFgsIGVvZgo+ID4g
PSAlbFhcbiIsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGRhdGFbMF0sIGRhdGFbMV0sIGRhdGFbMl0pOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmICgoZGF0YVswXSA9PSBQT05fUkVBU09OX1NPRl9OVU0pCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICYmIChkYXRhWzFdID09IFBPTl9S
RUFTT05fTUFHSUNfTlVNKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAmJiAoZGF0YVsxXSA9PSBQT05fUkVBU09OX01BR0lDX05VTSkpIHsKPiAKPiBVbm5lY2Vzc2Fy
eSBpbm5lciAoKSwgYW5kIEkgZG9uJ3Qgc2VlIHRoZSBwb2ludCBvZiBjaGVja2luZyBkYXRhWzFd
Cj4gdHdpY2UuClllYWgsIGEgdHlwbyBoYXBwZW5lZC4KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2luZm8oZGV2LCAiV2F0Y2hkb2cgcmVz
ZXQgY2F1c2UKPiA+IGRldGVjdGVkLlxuIik7Cj4gCj4gVW5uZWNlc3Nhcnkgbm9pc2UuCkFDSyxy
ZW5hbWUgZGV2X2luZm8gdG8gZGV2X2RiZy4KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgd2RkLT5ib290c3RhdHVzIHw9IFdESU9GX0NBUkRSRVNF
VDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgbWVtc2V0KHZhZGRyLCAwLCByZXNlcnZlZF9tZW1fc2l6ZSk7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWVtdW5tYXAodmFkZHIpOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgfQo+IAo+IEFuZCBzb21lIHJhbmRvbSBkYXRhIGluIHRoZSBwcm9wZXJ0eSBp
cyBhY2NlcHRhYmxlID8gVGhhdCBpcyBvZGQsCj4gZXNwZWNpYWxseQo+IGFmdGVyIG1hbmRhdGlu
ZyB0aGUgcHJvcGVydHkgaXRzZWxmLgo+IApZZWFoLCBkbyB5b3UgaGF2ZSBhbnkgc3VnZ2VzdGlv
bnMgYWJvdXQgaG93IHRvIHN0b3JlIHRoZSB3YXRjaGRvZwpyZXNldCBjYXVzZT8KCkJlc3QgcmVn
YXJkcywKTGkgSHVhIFFpYW4KPiA+ICsKPiA+IMKgwqDCoMKgwqDCoMKgwqB3YXRjaGRvZ19pbml0
X3RpbWVvdXQod2RkLCBoZWFydGJlYXQsIGRldik7Cj4gPiDCoCAKPiA+IMKgwqDCoMKgwqDCoMKg
wqByZXQgPSB3YXRjaGRvZ19yZWdpc3Rlcl9kZXZpY2Uod2RkKTsKPiAKCg==
