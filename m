Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84505FE6E8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 04:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJNCWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 22:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJNCWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 22:22:08 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2126.outbound.protection.outlook.com [40.107.255.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF99E8C7C;
        Thu, 13 Oct 2022 19:22:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVzU1XP7z/ErdCZgpAfc3iqCiSQiki96IBIlzNQpx79hL+VM5WZDiA4wgPpNSoVQtOlPwgsW2tXRq0bgHgRlu/lRKoxtUqCHfr6Sr4fW69dB1noS5N4+tQ2PudyKKcV8jlcnGXyLkF5dTmg0KVFsei/ENPBdoslJ5ArfqLZXag9DE3yib7WbYjUyS4JkZV+HF1eRalIXtxwWCiZHwN3ykmkZTtBU0ThEEuHCAoPtJ0VgJLP8Q1jo8WBJ+vNGkTkF+MgwlwRDTfLcBI4BoEaM2QlkFxyxM3Hdh0O19sHd0oFQ3CjZjC0q+btwKNiJDv4ua2h4Z1AllENW9Fc8WElthA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+bC7HmP7vLCVtjMYtnFam7rfO3+eQ9uOXIpamuzmwc=;
 b=AuJd687/iO/8nwjNAOkv7XaQYwckcwZJ7oUdrDIezdWYPCSEjQR1yNIK0+EtiODmoLwr0zswbWUj5IYNu9zcaEbYEcwpqlRazbDsszkqqDfPzd68AP3csjXtldUJs2srespaHS0miODYwJ/Xc1+IStwHrGC/geBokiw1B9qu3JYOxTWCRo2fL6b42F97atqlJNA78e2DJ/37JS+vxY3BKN8VZk1srrlgoL4PQ5UPcR4LKqsgiookCMKLu8HTCWjxdskrS870GB4fgAFBeQoF8MUryGTw14Y9tNo3aiZppR3gcHRESoWK2cdCNuph4PZyrEY+IEok5n8l65PwEgGEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 103.192.253.182) smtp.rcpttodomain=linaro.org smtp.mailfrom=zeku.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=zeku.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+bC7HmP7vLCVtjMYtnFam7rfO3+eQ9uOXIpamuzmwc=;
 b=DfNE+K/C8kB6sFLSj5iLKP49Fs2HOdkaqDSA7L0tqQwSoh1Q1foODKxsH90LcGSLyP3gIsqCanV55INcXDRrqlxTx27tjtjs/mh2574PGtzphSPUsYMKVUKKEYnxjN3r4u4id5MpAy5JmxQQuVDmVm/qobeqC58Oh+dBoxaKoDAoj/myUWz9oddfi4LBEVY2chRoN7rsMhwW2J6WLWlE5X9DPNIidco7DbmIcIi9UqJ/EXAm2TLqSNC4LBa8eXdOOnKsJvL0Co06Ew4m9+ZW0eG1fbLpVP3M/bG/b/QuELgsjEAGb/hyM3rQvDC1r2yvTs1JIde+LwQrPyvx0Bak6g==
Received: from TYCP286CA0114.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:29c::12)
 by PSAPR02MB5029.apcprd02.prod.outlook.com (2603:1096:301:88::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.22; Fri, 14 Oct
 2022 02:22:01 +0000
Received: from TYZAPC01FT055.eop-APC01.prod.protection.outlook.com
 (2603:1096:400:29c:cafe::4e) by TYCP286CA0114.outlook.office365.com
 (2603:1096:400:29c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29 via Frontend
 Transport; Fri, 14 Oct 2022 02:22:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 103.192.253.182)
 smtp.mailfrom=zeku.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=zeku.com;
Received-SPF: Pass (protection.outlook.com: domain of zeku.com designates
 103.192.253.182 as permitted sender) receiver=protection.outlook.com;
 client-ip=103.192.253.182; helo=sh-exhtc2.internal.zeku.com; pr=C
Received: from sh-exhtc2.internal.zeku.com (103.192.253.182) by
 TYZAPC01FT055.mail.protection.outlook.com (10.118.152.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Fri, 14 Oct 2022 02:22:01 +0000
Received: from sh-exhtc3.internal.zeku.com (10.123.154.250) by
 sh-exhtc2.internal.zeku.com (10.123.21.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.12; Fri, 14 Oct 2022 10:22:01 +0800
Received: from sh-exhtc1.internal.zeku.com (10.123.21.105) by
 sh-exhtc3.internal.zeku.com (10.123.154.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.986.5;
 Fri, 14 Oct 2022 10:22:01 +0800
Received: from sh-exhtc1.internal.zeku.com ([fe80::6d26:2d7f:da66:7a7c]) by
 sh-exhtc1.internal.zeku.com ([fe80::6d26:2d7f:da66:7a7c%5]) with mapi id
 15.01.2375.012; Fri, 14 Oct 2022 10:22:01 +0800
From:   =?utf-8?B?5qyn6Ziz54Kc6ZKKKFdlaXpoYW8gT3V5YW5nKQ==?= 
        <ouyangweizhao@zeku.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?utf-8?B?546L5aSn5a6HKEpvaG4gV2FuZyk=?= <wangdayu@zeku.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        =?utf-8?B?6ams5a6P5LyfKE1hdHRoZXcgTWEp?= <mahongwei@zeku.com>,
        Pierre Ossman <drzeus@drzeus.cx>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: sdio: fix kernel panic when remove non-standard SDIO
 card
Thread-Topic: [PATCH] mmc: sdio: fix kernel panic when remove non-standard
 SDIO card
Thread-Index: Adjfc64mMth2za2wTpeU0aMAg1X+bA==
Date:   Fri, 14 Oct 2022 02:22:01 +0000
Message-ID: <cee804c27ff54cdd8b9354ed43358f56@zeku.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.108.20.99]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZAPC01FT055:EE_|PSAPR02MB5029:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b093dc-9cd0-4cfa-430d-08daad8ae0a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wQY/7I54+MoFwIDjOMhmabd3a9HGmPs5qTPGbSJTCT8s2O2Sv1rG5A2UQNcZGygvM76ydlJGpBdMloho3Y7USW4RrhxBOS+rSpXoK/rO69hu0Cs6yCxIO5omZvQqcPFG8T49d6IyHJcpkaBWO6okmCnkgISCFQCcID5fIUG2vc3gyXijEt5hfk3ZJMlnt9DnPL6ORtLWe+HlBrZBd1OzQxwOG1OM83xvvxbIzdTYtvy+5ld6pV1kagWb9rMHcXYVuPLjiy8reAaAFG9U7jWPVbh8eRdCeIoSB5bHZoQ1R/jSN/ub7TNu5cWxuYIRg/SVwWVsKmpYRAskinrq5SJZ364TOSvr13zhCtx1qx3X9e8dW9QaM9Ld8e8Eio5bPCqP6HgXvF7zYHeWK3tPEd4rLtJvBXM+YqL8J2ZUij8Ivsk2QCW0jFhn0PkhkndNeVSMkIZSkUzqFZVi830LUxQw0s2a+tonHQGC4hCpBVmEaZNPK5O5VHqbnID192o8sHY0vHSp5M+IE6A7bs00eetLeAn/7CBRZXUKfKxLS4lzsQfPzck1KzBL6kgigj1wL6ZsZma97rqR1fEF/tmEaTet/JLPuuCdDboHLh+RX7jWXavrXenBD9avdFW/3deh2g/VCir+T/pPzsvDzyCwKjcB5920d5aJ/eac49G91g9k2Njzri+V3egfLtihbf3mgijBAcA1EX+QRGacZaqxM+FEInrmfZJ+9RCcW6PRSDLpk2LnqEV/bqk1YJIBJrFkWpMZUtlP7F8FIUhm/Lg3aK6pyg==
X-Forefront-Antispam-Report: CIP:103.192.253.182;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:sh-exhtc2.internal.zeku.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39840400004)(451199015)(46966006)(36840700001)(40480700001)(36756003)(85182001)(7696005)(82310400005)(41300700001)(24736004)(26005)(70206006)(70586007)(8676002)(478600001)(108616005)(86362001)(356005)(81166007)(36860700001)(426003)(316002)(336012)(8936002)(5660300002)(36906005)(110136005)(83380400001)(47076005)(2616005)(186003)(2906002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: zeku.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 02:22:01.1050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b093dc-9cd0-4cfa-430d-08daad8ae0a4
X-MS-Exchange-CrossTenant-Id: 171aedba-f024-43df-bc82-290d40e185ac
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=171aedba-f024-43df-bc82-290d40e185ac;Ip=[103.192.253.182];Helo=[sh-exhtc2.internal.zeku.com]
X-MS-Exchange-CrossTenant-AuthSource: TYZAPC01FT055.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR02MB5029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MjAyMuW5tDEw5pyIMTLml6UgMTg6MDksIFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8u
b3JnPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgMTIgT2N0IDIwMjIgYXQgMDM6NTAsIOasp+mYs+eC
nOmSiihXZWl6aGFvIE91eWFuZykNCj4gPG91eWFuZ3dlaXpoYW9AemVrdS5jb20+IHdyb3RlOg0K
PiA+DQo+ID4gMjAyMuW5tDEw5pyIMTHml6UgMjI6NDEsIFVsZiBIYW5zc29uIDx1bGYuaGFuc3Nv
bkBsaW5hcm8ub3JnPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBPbiBUdWUsIDI3IFNlcHQgMjAyMiBh
dCAwNDowNCwgV2VpemhhbyBPdXlhbmcNCj4gPG91eWFuZ3dlaXpoYW9AemVrdS5jb20+DQo+ID4g
PiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gRnJvbTogTWF0dGhldyBNYSA8bWFob25nd2VpQHpl
a3UuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBTRElPIHR1cGxlIGlzIG9ubHkgYWxsb2NhdGVkIGZv
ciBzdGFuZGFyZCBTRElPIGNhcmQsIGVzcGVjaWFsbHkgaXQNCj4gPiA+ID4gY2F1c2VzIG1lbW9y
eSBjb3JydXB0aW9uIGlzc3VlcyB3aGVuIHRoZSBub24tc3RhbmRhcmQgU0RJTyBjYXJkIGhhcw0K
PiA+ID4gPiByZW1vdmVkIHNpbmNlIHRoZSBjYXJkIGRldmljZSdzIHJlZmVyZW5jZSBjb3VudGVy
IGRvZXMgbm90IGluY3JlYXNlIGZvcg0KPiA+ID4gPiBpdCBhdCBzZGlvX2luaXRfZnVuYygpLCBi
dXQgYWxsIFNESU8gY2FyZCBkZXZpY2UgcmVmZXJlbmNlIGNvdW50ZXIgaGFzDQo+ID4gPiA+IGRl
Y3JlYXNlZCBhdCBzZGlvX3JlbGVhc2VfZnVuYygpLg0KPiA+ID4gPg0KPiA+ID4gPiBGaXhlczog
MWE2MzJmOGNkYzMzICgic2Rpbzogc3BsaXQgdXAgY29tbW9uIGFuZCBmdW5jdGlvbiBDSVMgcGFy
c2luZyIpDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE1hdHRoZXcgTWEgPG1haG9uZ3dlaUB6ZWt1
LmNvbT4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IFdlaXpoYW8gT3V5YW5nIDxvdXlhbmd3ZWl6aGFv
QHpla3UuY29tPg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogSm9obiBXYW5nIDx3YW5nZGF5dUB6ZWt1
LmNvbT4NCj4gPiA+DQo+ID4gPiBBcG9sb2dpemUgZm9yIHRoZSBkZWxheSENCj4gPiA+DQo+ID4g
PiBXb3csIHRoYXQncyBhIHZlcnkgb2xkIGJ1ZyB5b3UgZml4ZWQhIEhvd2V2ZXIsIGl0IGxvb2tz
IGxpa2UgdGhlIGZpeGVkDQo+ID4gPiBjb21taXQgc2hvdWxkIGJlIGNoYW5nZWQgdG8gNmY1MWJl
M2QzN2RmICgic2RpbzogYWxsb3cgbm9uLXN0YW5kYXJkDQo+ID4gPiBTRElPIGNhcmRzIikuDQo+
ID4NCj4gPiBUaGFua3MsIEkgbWVzc2VkIHRoZSB0YWcuDQo+ID4NCj4gPiA+DQo+ID4gPiBJIHRy
aWVkIHRvIGFwcGx5IHRoZSBwYXRjaCwgYnV0IHRoZSBwYXRjaCBmb3JtYXQgc2VlbXMgdG8gYmUg
Y29ycnVwdC4NCj4gPiA+IERpZCB5b3UgdXNlIGdpdCBmb3JtYXQtcGF0Y2ggYW5kIGRpZCBydW4g
Li9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgb24NCj4gPiA+IGl0Pw0KPiA+ID4NCj4gPg0KPiA+IFll
YWggSSB1c2VkIGNoZWNrcGF0Y2gucGwgd2l0aCBzdHJpY3QgbW9kZSB0byBjaGVjayB0aGlzIHBh
dGNoLCBhbmQgaXQNCj4gPiBoYXMgbm8gb2J2aW91cyBzdHlsZSBwcm9ibGVtcy4gV2hhdCdzIHRo
ZSBmb3JtYXQgZXJyb3IgeW91IGdvdD8NCj4gDQo+IEVSUk9SOiBwYXRjaCBzZWVtcyB0byBiZSBj
b3JydXB0IChsaW5lIHdyYXBwZWQ/KQ0KPiAjMTMwOiBGSUxFOiBkcml2ZXJzL21tYy9jb3JlL3Nk
aW9fYnVzLmM6MjkxOg0KPiBzdHJ1Y3Qgc2Rpb19mdW5jICpmdW5jID0gZGV2X3RvX3NkaW9fZnVu
YyhkZXYpOw0KPiANCj4gdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA5IGxpbmVzIGNoZWNr
ZWQNCj4gDQoNClNvcnJ5IG91ciBlbWFpbCBob3N0aW5nIHNlcnZpY2UgbWFkZSBzb21lIGlzc3Vl
IG9uIGZvcm1hdHRpbmcsIEkgd2lsbA0Kc2VuZCBhbiB1cGRhdGVkIHBhdGNoIEFTQVAuDQoNClRo
YW5rcywNCldlaXpoYW8NCg0K
