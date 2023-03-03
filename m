Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD41D6A9577
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCCKmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjCCKmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:42:08 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36285D74A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 02:42:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrJdTlNI/TmX1beozvz6zUz4M4A48H1FhA1OZuAXlMYE7UMAQlrtik+0Lve65t4LgcuL7kA1GhqwAifmdt9gv/A93U6A6Z/UO2NLRlk7A/jhQrpZ1NscRHrvgGWMT1IWe4gvWyP/CcxVxUXB1fbmCIrLMKcDu71VDMeTCYpPafp+IvNEZcNypEk83Qqj0z6sn3ZnDL1OkPYC3az59Dd78Iu1sfUx8Es23FQD7rZhaKQzO9NV1HmPYvnrJCt6OhbvzBsnDTB6eJ5wJerFeA4Owjl1OJGEGoKGcYlHih1cpIZ/W7IA8kD4FY9e7+cH46D75GVt/yUrnPA37VYFpVsSYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6hkccg2J+hl9gIRA7Mt1Zdg4oRxJZj7piHMtYfiq/Q=;
 b=fGFNDgzvsMccioAf5g6mkePy8ZfUwSFm0NM+RloxGU1pkBvACuC9su2LdBkBzzF1ddSaSd6YPnbVvbg23AZUrsgfnJ+bjABubxmYgRAv5jWRRcKFHPLjjVgQkBTfKeT0lvmyNVFGeovUcS4qaZcng1lpL/jAH+6ze+knZLhk3eajklzVtS0PZvSzpERkiTOaOSAzePtLAfwSjoOYU23aLU8QjPe36m+TbUHDXQciBtSvZcMYZDbLIuDbtt+ikvykx//QtPZgSxhj5w5WHkvY6m8n/FhZ6R6rwsUmixy0OLnwXXe3HObYpD8GIxs7YfzUscAJMbwtw6pL/oQHg05Wag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 103.192.253.182) smtp.rcpttodomain=arm.com smtp.mailfrom=zeku.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=zeku.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6hkccg2J+hl9gIRA7Mt1Zdg4oRxJZj7piHMtYfiq/Q=;
 b=ta2Rk1WQaCtJ8wkPbwScdmp9tGGYVK/ftOdwTwcYLBSGDbHzNQ8xmmTxgiicpJcQKPczf3P1tXbDYt3OhScCRpWT5unsJAAXSoeDhCOADhjAN/t+/aMcgpSTU0deJz+M6sG9srkv5uX2MNWQj2XkB/ltvM7J/MlQ41SQhrb+8LeEzHpUzWaL1J784rL+OaEVMHSWtfxQ1l122h25AkQQih4KGK7L3/HHhmSdC1Akmi4lCIfvVfke0g9d+gA872uvrKz6jlyzMhdBRL0mOJu/xvAY0GvwR3/ys2/ZwcNpJ3nkTEjUuewK4VAFp2rHaNS2G7TJ/P6U6mTFm2W87dymCg==
Received: from SL2PR03CA0005.apcprd03.prod.outlook.com (2603:1096:100:55::17)
 by SEZPR02MB5888.apcprd02.prod.outlook.com (2603:1096:101:74::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Fri, 3 Mar
 2023 10:42:02 +0000
Received: from PSAAPC01FT056.eop-APC01.prod.protection.outlook.com
 (2603:1096:100:55:cafe::6a) by SL2PR03CA0005.outlook.office365.com
 (2603:1096:100:55::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.10 via Frontend
 Transport; Fri, 3 Mar 2023 10:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 103.192.253.182)
 smtp.mailfrom=zeku.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=zeku.com;
Received-SPF: Pass (protection.outlook.com: domain of zeku.com designates
 103.192.253.182 as permitted sender) receiver=protection.outlook.com;
 client-ip=103.192.253.182; helo=sh-exhtc2.internal.zeku.com; pr=C
Received: from sh-exhtc2.internal.zeku.com (103.192.253.182) by
 PSAAPC01FT056.mail.protection.outlook.com (10.13.38.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.21 via Frontend Transport; Fri, 3 Mar 2023 10:42:00 +0000
Received: from sh-exhtc1.internal.zeku.com (10.123.21.105) by
 sh-exhtc2.internal.zeku.com (10.123.21.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.12; Fri, 3 Mar 2023 18:41:59 +0800
Received: from sh-exhtc4.internal.zeku.com (10.123.154.251) by
 sh-exhtc1.internal.zeku.com (10.123.21.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.12; Fri, 3 Mar 2023 18:41:59 +0800
Received: from sh-exhtc4.internal.zeku.com ([fe80::b447:eb25:37fd:3fd8]) by
 sh-exhtc4.internal.zeku.com ([fe80::b447:eb25:37fd:3fd8%3]) with mapi id
 15.02.0986.005; Fri, 3 Mar 2023 18:41:59 +0800
From:   =?utf-8?B?6KKB5biFKFNodWFpIFl1YW4p?= <yuanshuai@zeku.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
CC:     Dmitry Vyukov <dvyukov@google.com>,
        =?utf-8?B?5qyn6Ziz54Kc6ZKKKFdlaXpoYW8gT3V5YW5nKQ==?= 
        <ouyangweizhao@zeku.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Weizhao Ouyang <o451686892@gmail.com>,
        =?utf-8?B?5Lu756uL6bmPKFBlbmcgUmVuKQ==?= <renlipeng@zeku.com>,
        "Peter Collingbourne" <pcc@google.com>
Subject: RE: [PATCH v2] kasan: fix deadlock in start_report()
Thread-Topic: [PATCH v2] kasan: fix deadlock in start_report()
Thread-Index: AQHZPDZzScKWhyj5L0eV70o/eMb/rq7FygeAgACH4+D//5aGAIAAy+8AgAC6aDCACH5tEIARtn+AgAJ7vQCAAF9zAIABQRKAgAMl3+A=
Date:   Fri, 3 Mar 2023 10:41:59 +0000
Message-ID: <942d0845b3ac42f284ac6c790d65b095@zeku.com>
References: <20230209031159.2337445-1-ouyangweizhao@zeku.com>
 <CACT4Y+Zrz4KOU82jjEperYOM0sEp6TCmgse4XVMPkwAkS+dXrA@mail.gmail.com>
 <93b94f59016145adbb1e01311a1103f8@zeku.com>
 <CACT4Y+a=BaMNUf=_suQ5or9=ZksX2ht9gX8=XBSDEgHogyy3mg@mail.gmail.com>
 <CA+fCnZf3k-rsaOeti0Q7rqkmvsqDb2XxgxOq6V5Gqp6FGLH7Yg@mail.gmail.com>
 <b058a424e46d4f94a1f2fdc61292606b@zeku.com>
 <2b57491a9fab4ce9a643bd0922e03e73@zeku.com>
 <CA+fCnZcirNwdA=oaLLiDN+NxBPNcA75agPV1sRsKuZ0Wz6w_hQ@mail.gmail.com>
 <Y/4nJEHeUAEBsj6y@arm.com>
 <CA+fCnZcFaOAGYic-x7848TMom2Rt5-Bm5SpYd-uxdT3im8PHvg@mail.gmail.com>
 <Y/+Ei5boQh+TFj7Q@arm.com>
In-Reply-To: <Y/+Ei5boQh+TFj7Q@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.122.89.15]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAAPC01FT056:EE_|SEZPR02MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f2b70e-2e6b-4ad7-f539-08db1bd3eb8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TFTPp4LceXDjjXT8/gSO3QNbmLUHtDGhilU6ODwH02bVrlQFEN/yceIzjCsRw2wOphpZOCIhG3UThI/rxPRYT1yLKNei9X35ZCWJlGnQXFfq95fr7BhiFhumksVUTf9MlIWdutZxd3r2T9MINlc7oGBEiHgA3MCBdkxrPI5/zrX7o5de7enWccLDPup1FUHTeUJnJsvG4srnRAgqPeAnyy3tI7S/BXow5wXaJYopbP6bkucLYZJKfCLJNmd1EiO9MpL1PwFVlTFnKHz6Y52kn/OvKASHsJFi+q3DDSPPldVO89dvt1+N5V4TkrA4zUWp+EJYphFjpp7oCVQehLLT/oCXpbMtahWGE4bG1T0JTAa0/fOAiZ61c1GI4AYUjXix8wZ/9OaOp0f8wJZDcpGbAUxf7NXRLzzGSfbqVshsj2XsM5bqfjsglwaF3qxBvKHF+2bThJGxA8Cqgqy93AeCkSvVQfYzAr+sIJnD2h34GruBFALVM6UF7ADu+b4eSh6hBAiLSlz6iawo1Ato0GdPDs71W90040ZxM42l0C9yUOhZL/WSawdIgN32IF5YS87q1gKd9TXsMfm1t9kXA4CdoxNjANedgWVdmJsEWq5WX4onteabmveWwJmIJorSCaabDwFUPEpsOi5hzfJgV3gt/64x/U/G8iJAUrWN946XVWRa7UxPz/LGKnpLmNcrhp8KOsTcGbajT12sMun7tAEOuQ==
X-Forefront-Antispam-Report: CIP:103.192.253.182;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:sh-exhtc2.internal.zeku.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(39850400004)(451199018)(36840700001)(46966006)(83380400001)(66899018)(36860700001)(426003)(47076005)(36756003)(85182001)(24736004)(5660300002)(7416002)(81166007)(8936002)(82740400003)(86362001)(356005)(40480700001)(82310400005)(186003)(108616005)(336012)(478600001)(26005)(2616005)(7696005)(70586007)(8676002)(316002)(70206006)(2906002)(54906003)(4326008)(110136005)(41300700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: zeku.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 10:42:00.4893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f2b70e-2e6b-4ad7-f539-08db1bd3eb8b
X-MS-Exchange-CrossTenant-Id: 171aedba-f024-43df-bc82-290d40e185ac
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=171aedba-f024-43df-bc82-290d40e185ac;Ip=[103.192.253.182];Helo=[sh-exhtc2.internal.zeku.com]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT056.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5888
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUdWUsIEZlYiAyOCwgMjAyMyBhdCAxMDo1MDo0NlBNICswMTAwLCBBbmRyZXkgS29ub3Zh
bG92IHdyb3RlOg0KPiA+IE9uIFR1ZSwgRmViIDI4LCAyMDIzIGF0IDU6MDnigK9QTSBDYXRhbGlu
IE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPg0KPiA+DQo+ID4gUmlnaHQsIGJ1dCBo
ZXJlIHdlIGRvbid0IHdhbnQgdG8gcmUtZW5hYmxlIE1URSBhZnRlciBhIGZhdWx0LCB3ZSB3YW50
DQo+ID4gdG8gc3VwcHJlc3MgZmF1bHRzIHdoZW4gcHJpbnRpbmcgYW4gZXJyb3IgcmVwb3J0Lg0K
PiA+DQo+ID4gPiBJSVVDLCB0aGUgcHJvYmxlbSBpcyB0aGF0IHRoZSBrZXJuZWwgYWxyZWFkeSBn
b3QgYW4gTVRFIGZhdWx0LCBzbyBhdA0KPiA+ID4gdGhhdCBwb2ludCB0aGUgZXJyb3IgaXMgbm90
IHJlYWxseSByZWNvdmVyYWJsZS4NCj4gPg0KPiA+IE5vLCB0aGUgcHJvYmxlbSBpcyB3aXRoIHRo
ZSBmb2xsb3dpbmcgc2VxdWVuY2Ugb2YgZXZlbnRzOg0KPiA+DQo+ID4gMS4gS0FTQU4gZGV0ZWN0
cyBhIG1lbW9yeSBjb3JydXB0aW9uIGFuZCBzdGFydHMgcHJpbnRpbmcgYSByZXBvcnQNCj4gPiBf
d2l0aG91dCBnZXR0aW5nIGFuIE1URSBmYXVsdF8uIFRoaXMgaGFwcGVucyB3aGVuIGUuZy4gS0FT
QU4gc2VlcyBhDQo+ID4gZnJlZSBvZiBhbiBpbnZhbGlkIGFkZHJlc3MuDQo+ID4NCj4gPiAyLiBE
dXJpbmcgZXJyb3IgcmVwb3J0aW5nLCBhbiBNVEUgZmF1bHQgaXMgdHJpZ2dlcmVkIGJ5IHRoZSBl
cnJvcg0KPiA+IHJlcG9ydGluZyBjb2RlLiBFLmcuIHdoaWxlIGNvbGxlY3RpbmcgaW5mb3JtYXRp
b24gYWJvdXQgdGhlIGFjY2Vzc2VkDQo+ID4gc2xhYiBvYmplY3QuDQo+ID4NCj4gPiAzLiBLQVNB
TiB0cmllcyB0byBwcmludCBhbm90aGVyIHJlcG9ydCB3aGlsZSBwcmludGluZyBhIHJlcG9ydCBh
bmQNCj4gPiBnb2VzIGludG8gYSBkZWFkbG9jay4NCj4gPg0KPiA+IElmIHdlIGNvdWxkIGF2b2lk
IE1URSBmYXVsdHMgYmVpbmcgdHJpZ2dlcmVkIGR1cmluZyBlcnJvciByZXBvcnRpbmcsDQo+ID4g
dGhpcyB3b3VsZCBzb2x2ZSB0aGUgcHJvYmxlbS4NCj4NCj4gQWgsIEkgZ2V0IGl0IG5vdy4gU28g
d2UganVzdCB3YW50IHRvIGF2b2lkIHRyaWdnZXJpbmcgYSBiZW5pZ24gTVRFIGZhdWx0Lg0KPg0K
PiA+ID4gSWYgd2Ugd2FudCB0byBhdm9pZCBhDQo+ID4gPiBmYXVsdCBpbiB0aGUgZmlyc3QgcGxh
Y2UsIHdlIGNvdWxkIGRvIHNvbWV0aGluZyBsaWtlDQo+ID4gPiBfX3VhY2Nlc3NfZW5hYmxlX3Rj
bygpIChWaW5jZW56byBoYXMgc29tZSBwYXRjaGVzIHRvIGdlbmVyYWxpc2UNCj4gPiA+IHRoZXNl
DQo+ID4gPiByb3V0aW5lcykNCj4gPg0KPiA+IEFoLCB0aGlzIGxvb2tzIGV4YWN0bHkgbGlrZSB3
aGF0IHdlIG5lZWQuIEFkZGluZw0KPiA+IF9fdWFjY2Vzc19lbi9kaXNhYmxlX3RjbyB0byBrYXNh
bl9yZXBvcnRfaW52YWxpZF9mcmVlIHNvbHZlcyB0aGUNCj4gPiBwcm9ibGVtLg0KPiA+DQo+ID4g
RG8geW91IHRoaW5rIGl0IHdvdWxkIGJlIHBvc3NpYmxlIHRvIGV4cG9zZSB0aGVzZSByb3V0aW5l
cyB0byBLQVNBTj8NCj4NCj4gWWVzLiBJJ20gaW5jbHVkaW5nIFZpbmNlbnpvJ3MgcGF0Y2ggYmVs
b3cgKHBhcnQgb2YgZml4aW5nIHNvbWUgcG90ZW50aWFsDQo+IHN0cnNjcHkoKSBmYXVsdHMgd2l0
aCBpdHMgdW5hbGlnbmVkIGFjY2Vzc2VzIGVhZ2VyIHJlYWRpbmc7IHdlJ2xsIGdldCB0byBwb3N0
aW5nDQo+IHRoYXQgZXZlbnR1YWxseSkuIFlvdSBjYW4gYWRkIHNvbWUgYXJjaF9rYXNhbl9lbmFi
bGUvZGlzYWJsZSgpIG1hY3JvcyBvbg0KPiB0b3AgYW5kIGZlZWwgZnJlZSB0byBpbmNsdWRlIHRo
ZSBwYXRjaCBiZWxvdy4NCg0KSSBoYXZlIGluaXRpYWxseSB2ZXJpZmllZCB0aGUgZm9sbG93aW5n
IGNvZGUgb24ga2VybmVsIHZlcnNpb24gNS4xNSBhbmQgaXQgaXMgdmFsaWQuDQpBbHRob3VnaCBu
b3QgdXNpbmcgdGhlIGxhdGVzdCBpbnRlcmZhY2UsIHRoZXJlIGlzIG5vIGZ1bmRhbWVudGFsIGRp
ZmZlcmVuY2UuDQpJIHRoaW5rIHRoaXMgY2hhbmdlIHNob3VsZCBhbHNvIGFwcGx5IHRvIHRoZSBs
YXRlc3Qga2VybmVsIGNvZGUuDQoNCmRpZmYgLS1naXQgYS9tbS9rYXNhbi9yZXBvcnQuYyBiL21t
L2thc2FuL3JlcG9ydC5jDQppbmRleCAxZjk2YTcyYzdlZGQuLjczYjdmYzUzMmQ4MSAxMDA2NDQN
Ci0tLSBhL21tL2thc2FuL3JlcG9ydC5jDQorKysgYi9tbS9rYXNhbi9yZXBvcnQuYw0KQEAgLTI4
LDcgKzI4LDkgQEANCiAjaW5jbHVkZSA8dHJhY2UvZXZlbnRzL2Vycm9yX3JlcG9ydC5oPg0KDQog
I2luY2x1ZGUgPGFzbS9zZWN0aW9ucy5oPg0KLQ0KKyNpZmRlZiBDT05GSUdfS0FTQU5fSFdfVEFH
Uw0KKyNpbmNsdWRlIDxhc20vdWFjY2Vzcy5oPg0KKyNlbmRpZg0KICNpbmNsdWRlIDxrdW5pdC90
ZXN0Lmg+DQoNCiAjaW5jbHVkZSAia2FzYW4uaCINCkBAIC0xMDcsNiArMTA5LDEwIEBAIHN0YXRp
YyB2b2lkIHN0YXJ0X3JlcG9ydCh1bnNpZ25lZCBsb25nICpmbGFncykNCiAgKi8NCiBrYXNhbl9k
aXNhYmxlX2N1cnJlbnQoKTsNCiBzcGluX2xvY2tfaXJxc2F2ZSgmcmVwb3J0X2xvY2ssICpmbGFn
cyk7DQorI2lmZGVmIENPTkZJR19LQVNBTl9IV19UQUdTDQoraWYgKGthc2FuX2h3X3RhZ3NfZW5h
YmxlZCgpKQ0KK19fdWFjY2Vzc19lbmFibGVfdGNvKCk7DQorI2VuZGlmDQogcHJfZXJyKCI9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT1cbiIpOw0KIH0NCg0KQEAgLTExNiw2ICsxMjIsMTAgQEAgc3RhdGljIHZvaWQgZW5kX3Jl
cG9ydCh1bnNpZ25lZCBsb25nICpmbGFncywgdW5zaWduZWQgbG9uZyBhZGRyKQ0KIHRyYWNlX2Vy
cm9yX3JlcG9ydF9lbmQoRVJST1JfREVURUNUT1JfS0FTQU4sIGFkZHIpOw0KcHJfZXJyKCI9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT1cbiIpOw0KIGFkZF90YWludChUQUlOVF9CQURfUEFHRSwgTE9DS0RFUF9OT1dfVU5SRUxJ
QUJMRSk7DQorI2lmZGVmIENPTkZJR19LQVNBTl9IV19UQUdTDQoraWYgKGthc2FuX2h3X3RhZ3Nf
ZW5hYmxlZCgpKQ0KK19fdWFjY2Vzc19kaXNhYmxlX3RjbygpOw0KKyNlbmRpZg0Kc3Bpbl91bmxv
Y2tfaXJxcmVzdG9yZSgmcmVwb3J0X2xvY2ssICpmbGFncyk7DQogaWYgKHBhbmljX29uX3dhcm4g
JiYgIXRlc3RfYml0KEtBU0FOX0JJVF9NVUxUSV9TSE9ULCAma2FzYW5fZmxhZ3MpKSB7DQogLyoN
Cg0KPiBOb3csIEkgd29uZGVyIHdoZXRoZXIgd2Ugc2hvdWxkIGxpbmsgdGhvc2UgaW50byBrYXNh
bl9kaXNhYmxlX2N1cnJlbnQoKS4NCj4gVGhlc2UgZnVuY3Rpb25zIG9ubHkgZGVhbCB3aXRoIHRo
ZSBkZXB0aCBmb3IgS0FTQU5fU1dfVEFHUyBidXQgaXQgd291bGQNCj4gbWFrZSBzZW5zZSBmb3Ig
S0FTQU5fSFdfVEFHUyB0byBlbmFibGUgdGFnLWNoZWNrLW92ZXJyaWRlIHNvIHRoYXQgd2UNCj4g
ZG9uJ3QgbmVlZCB0byBib3RoZXIgd2l0aCBhIG1hdGNoLWFsbCB0YWdzIG9uIHBvaW50ZXIgZGVy
ZWZlcmVuY2luZy4NCg0KWkVLVQ0K5L+h5oGv5a6J5YWo5aOw5piO77ya5pys6YKu5Lu25YyF5ZCr
5L+h5oGv5b2S5Y+R5Lu25Lq65omA5Zyo57uE57uHWkVLVeaJgOacieOAgiDnpoHmraLku7vkvZXk
urrlnKjmnKrnu4/mjojmnYPnmoTmg4XlhrXkuIvku6Xku7vkvZXlvaLlvI/vvIjljIXmi6zkvYbk
uI3pmZDkuo7lhajpg6jmiJbpg6jliIbmiqvpnLLjgIHlpI3liLbmiJbkvKDmkq3vvInkvb/nlKjl
jIXlkKvnmoTkv6Hmga/jgILoi6XmgqjplJnmlLbkuobmnKzpgq7ku7bvvIzor7fnq4vljbPnlLXo
r53miJbpgq7ku7bpgJrnn6Xlj5Hku7bkurrvvIzlubbliKDpmaTmnKzpgq7ku7blj4rpmYTku7bj
gIINCkluZm9ybWF0aW9uIFNlY3VyaXR5IE5vdGljZTogVGhlIGluZm9ybWF0aW9uIGNvbnRhaW5l
ZCBpbiB0aGlzIG1haWwgaXMgc29sZWx5IHByb3BlcnR5IG9mIHRoZSBzZW5kZXIncyBvcmdhbml6
YXRpb24gWkVLVS4gQW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBp
biBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlh
bCBkaXNjbG9zdXJlLCByZXByb2R1Y3Rpb24sIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMg
b3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlv
dSByZWNlaXZlIHRoaXMgZW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBi
eSBwaG9uZSBvciBlbWFpbCBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIGl0Lg0K
