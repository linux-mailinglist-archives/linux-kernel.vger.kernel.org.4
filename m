Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA7871539D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjE3CZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjE3CZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:25:26 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2044.outbound.protection.outlook.com [40.107.114.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B86C7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 19:25:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XasLqAh3IBTrXxcJ2UeFtzBkeZtXRdkjm6Sh8cEEwQ2/uCkhg1OJ1g2/s/QETVihnrvFTTBtQMz933eXsXZOxK9sihJxrTdKLijVIEqfiKTsLL0+jIeOFC14yi4TNShvBG7YacFJXfjOxUSJZASPOkwVe1PeD77IH/ygmyZuFh5AOmo+n+FdJoy9+JnQFBSZ22qpbp6ms5x9OHbaC0lu0oy83eVTK+f63d33iTgxI9ATqAtyow7mg/OI+PtSKKMYf1XrXDkwUCGJi5DatvHs/Y0wpVM24vrCMAWe+wm+pgS05WPTYI4A/e++ErLk08w0puWyshwEvDVAoq+OBdbFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4q/BQSn495BBm8upV+lI5R8QjYwG5qZ3sw7sy4kS4SM=;
 b=BRMZlRtITt0CxL0n+Srf66bbMj/qhpOxbNo6wZaE6nsloPO1zAasFIRSlyTlljPA18Be4zYFRwknTMn1mIDywIhpoDP/e3CnJ0bxF9NvAmhfBFAORSwRw1S2rO9XK9ycLdfaspYczvNWZqiR0tyd7PrsGqLYXt+tbJFvdArRKXLNKG1cblfkJOjm8i9xJ5OOVvtL4O/Kbrp7grXPs6+p+NgZMVJJ7UcSYp/gbUB34LvXMK6xfZLQfDcCsR/AxBhpmv9Q3Sy1fZ+2sVkUufaZlsCGtLbQ/rGm7ovFlt7cPyJ73ae+JrAMwK/KZF9TD8RzFOCHzEmASrVgGAYhyJOnJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4q/BQSn495BBm8upV+lI5R8QjYwG5qZ3sw7sy4kS4SM=;
 b=FfEUvJHWArif3CrFV57gG8Y1xaJzxgy42Oe5tsP9CrscoFsa4nAiPcd5k276Mij1BLicGxNTww6KSMewzCAz/bLvXfDJ0rva7PI1XVLp3NnpWsoll66L4nzo6xEnKSC3Y09CYrqp3242WOBi7v7cpgx/PZ7TBjMYb73vIt+z4HY=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSRPR01MB11647.jpnprd01.prod.outlook.com (2603:1096:604:22e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 02:25:20 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::15c9:309c:d898:c0f5]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::15c9:309c:d898:c0f5%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 02:25:20 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Jiaqi Yan <jiaqiyan@google.com>
CC:     "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "duenwen@google.com" <duenwen@google.com>,
        "axelrasmussen@google.com" <axelrasmussen@google.com>,
        "jthoughton@google.com" <jthoughton@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 4/7] mm/memory_failure: unmap raw HWPoison PTEs
 when possible
Thread-Topic: [RFC PATCH v1 4/7] mm/memory_failure: unmap raw HWPoison PTEs
 when possible
Thread-Index: AQHZeWo+sjL67g3mbEeZdiZwX+Z2jq9ySQQA
Date:   Tue, 30 May 2023 02:25:20 +0000
Message-ID: <20230530022456.GA1434147@hori.linux.bs1.fc.nec.co.jp>
References: <20230428004139.2899856-1-jiaqiyan@google.com>
 <20230428004139.2899856-5-jiaqiyan@google.com>
In-Reply-To: <20230428004139.2899856-5-jiaqiyan@google.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|OSRPR01MB11647:EE_
x-ms-office365-filtering-correlation-id: 4a73a2ce-24ea-4b2a-c36e-08db60b51d9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xlYPXUwWbOnLwp7kPXRqb+QPDjkEZ2ojmo3gCb/ZiYjSsbEFOAIk4E7PfnNMdr6p6avwElv6KsO054oM+jaPIHWM2n9QAi2TeT4JKw4brc3nEFHiJ9L7XkxJLD+hlLokpJnM11qIaOX2lW5HF8Rvkvfruca2ZR8tcjooGhga8k7dudCYBIpfCx5Q469Tuu9Gvbz17H3YHdZJqFCno25Ur78Y+MrpDGhHwHMkudd9RBc3f5BtURsOo0UuoaiWbB7/sUPjjm2Z1c2Sm2WBSTtwcZbw2oNIZ4iCXiyZpwEDE6VweBJl0hDDz/7/X4kLgECsgiLW7MkxfiTI0EE/xEXPBjYrjt1UtTsKbk1eNIqIYXTtbBzxnPZ1s4amt+ZC6u9Lm0Xyxvq4wqv0r5+GbND5uGkxu0tT2wFmrE/3G8hfOnwDM7smCo+IOBM1Y0yflSPk3qo4mmNCjX2wMonURTGcHlSL7Z9fcq0yH9jG8C1h5nDGXHdgCTwC45iKsODPph6R3oqt0IPI9QsljE4cguemQvplHziwVhUihvoLTd5VPCNP5eGkfDtcotr7009MAgJ46L/y8HH4wa/F+TOG8BLC6XGB228gJCziAmDD5b1admTbuNVrPAFBl9c/IHz3q4OG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199021)(71200400001)(478600001)(54906003)(8676002)(8936002)(7416002)(5660300002)(85182001)(33656002)(38070700005)(2906002)(86362001)(66476007)(82960400001)(4326008)(6916009)(122000001)(64756008)(66556008)(66446008)(66946007)(76116006)(316002)(38100700002)(41300700001)(186003)(6506007)(9686003)(1076003)(26005)(6512007)(6486002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVNGdU85UXFzTnlGUVZVckZmYjBGOGVwNWJkdHM1RjNIY3QxNTlMdUJmT1hn?=
 =?utf-8?B?MVRzbC82bnhjUUJhWW5rdUM3bGtWZXpGSVVJbklCSDJ3ZDJ1emtuTFJleit6?=
 =?utf-8?B?ZjIxdkliUThwWTdJMlhORmNTRzQ2VzdOK3dqeFo2MXJ1U0huQjhqWSs1SEhz?=
 =?utf-8?B?eUdvNUR0dHFZUGlaR2RVQmN1MEl0eG9aWlJTRnBsaUUxanlxZEMvSTBmRzBq?=
 =?utf-8?B?Y0F6WHR1OStxb2c4cGZIYnU2NVNqbytHL3pVZDNDYlBhUnRNaG13SVpNR0lV?=
 =?utf-8?B?STNJSGZ3bmUyamM1UUgxbFBha0NoVDNHOUZTL1JzRFA3RzYzR1l2RVkxN0tn?=
 =?utf-8?B?Q1Fac2FJYWRCS05ZcmgrbkhoR1Q3M2g0UXNRUFdSTGdDeDFTSDB5RFhzQlp2?=
 =?utf-8?B?R1czNHNqQ01VV1JYbjNRa1h2dmlFMTVNK2VKd0MvUEd2RVVpZnc5NW8zT2FE?=
 =?utf-8?B?RVd5UjhWQlpCNG8va3p1WjZtcXp5NCszcHdPTEk5VXBJdStwY2MrcVZDMk9O?=
 =?utf-8?B?SWM5VXpCSkFwQWVlbGs1cUk1VDE2NFBJb3JlckdLZGJkNWs5TC9hMVh3c3BY?=
 =?utf-8?B?cTV3dmwwZHVPZm4wMnRIU1lQZytheVczb3hGOHU2Y1pNL0x4d09LcTk0dFli?=
 =?utf-8?B?cjArNWR5OWczYTdGUFBoNG9iWDhBZWpET21lR0M0bHFCVXRuakNTV3RodVBV?=
 =?utf-8?B?Yjk5NDR6bWgyL2ptWW9UWmVsUUZWdmpOQ1VkTk8yWXAzNnRyYTA4STN0VUVp?=
 =?utf-8?B?QUxJdXFCdzQwcC92cU9RYTU4S1NNUmtWMzFyM2hkMEluVkhCREVRRkZmRVo0?=
 =?utf-8?B?Nk5vUmlrWEJERFRkRWhuWm1TU01qTGtRclh1NmNwVDcwOW5EWWxtbmRyVk9B?=
 =?utf-8?B?N0pzczZDWGlPTElXRmgySGxubVhWYUpiWk1PcVNqZ2RxZVhiRm9Ja1ZtaG9Z?=
 =?utf-8?B?VG1MblpUSWQ0L2I2enNxVjVrR3lhdzZWNGl0aVNLUFVGdVlVM3NnbEd5MTRF?=
 =?utf-8?B?cFhzLzZNdEliMmk1RSttSkRGVGM0QW8yWU5oWnNXREw2UWlSN2RkQmxPOFlr?=
 =?utf-8?B?R3NqWktCWUZRRFYzQnpObkl0bTdmYlRzRjJRbWxQSEpIQ2xPZ1dKK01xVW5V?=
 =?utf-8?B?NGM2R0xLNDFTNnZCZWZuZENVWDRHSGwwWG1xT29reHppYVJQYUFza2t3MTN6?=
 =?utf-8?B?YS8vUnpPRjNUaEtCWGk3cXlabnVybDdvWW0vRG1ZdmtTWlkySzVkMnpUQmtj?=
 =?utf-8?B?WlNwUWZoUmRCZFE3NkN1WGJuaDVUM21ZZUlIZE8zSnk0d0lqWkhvczBCbjli?=
 =?utf-8?B?M1dadi9xQkNYZFltc0R1VlRIL0xQUklrQWI4eVFraEczM2NydDJTMjVuVDNx?=
 =?utf-8?B?elN6MDhtK0x3NzIrRXpDTnNDMzdWTHoyVEg0TlEySEszb2xYSDd4cDJ2UXd4?=
 =?utf-8?B?SGdSbnhUalVoSzFsWlpGeitnN25pbGVCdUdHMXI1VWJXcTBrY2w4ODUycXV4?=
 =?utf-8?B?aDRReU5tdFZEeVhGL0k3UUY0UTJUZU9HcEF5ZEREQS9PQzFRTXhGOWhTb1Vr?=
 =?utf-8?B?ZE50c1FnREpXa2xCYmY4dHByeXhxczdnOFJvZDBVL2FXcHhXbEU2VnNDeHNq?=
 =?utf-8?B?YkUvNjM0RzNFZk94dXJBK3h0WmJ4WkhGZDljbG5jN0JKRkVKajFiOEpXZW4x?=
 =?utf-8?B?am5YZlozNEQwNCtGTEk2R0tRNFA0WHRhalJ5MEN6WGcvQ3RBeDdNbEN5RjdW?=
 =?utf-8?B?QzhyTEFvUVBJMjNPRksxenJCLzI0QTkreWp0UXdJWjUyWllVb1NkR0RtT21q?=
 =?utf-8?B?eTBiZUpaVC9JNWlRRWlHb3NSckREYmJQLzVJdzBLaHNRR1NwRngxWHE3dXQ5?=
 =?utf-8?B?U0pKelkwaEl0anRQbWE0blpObnJad0gyWG5OUW9kTGpkTjI2bVo4MnQzR1lF?=
 =?utf-8?B?dmM5cE9WZXZCVUNBNVRaQ01uS1dtbVdaQUN5STU4ZlRzeERlSm5nYi85VEtW?=
 =?utf-8?B?NXYrciticDlkVjBaU1NWaDAwZXlPNUJYV25RNmNmTEsxakhRcGtQMmIwWVZn?=
 =?utf-8?B?ajdtY0hGTm1CcERQQi9UMmc5RVZuN0hlZFM4eUs4Vkx0NFZhZEpmNUNZTTNB?=
 =?utf-8?B?ZmxBYzdvdDVJZlB6aHlOc01UdVk2S1RUY0ljU1l5emJzV1dIS21scE4vV3ky?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86F9C9882F529342A237A20269BA8DE5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a73a2ce-24ea-4b2a-c36e-08db60b51d9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 02:25:20.5228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dVrydWRkQIII+44CGXZMMUaz8ZfblUNlxcrNcGE/i6Jj7+TCdjkSpN8fKoWRQ+AazjRlEJP6cujSoa82WcwpeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11647
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBcHIgMjgsIDIwMjMgYXQgMTI6NDE6MzZBTSArMDAwMCwgSmlhcWkgWWFuIHdyb3Rl
Og0KPiBXaGVuIGEgZm9saW8ncyBWTUEgaXMgSEdNIGVsaWdpYmxlLCB0cnlfdG9fdW5tYXBfb25l
IG5vdyBvbmx5IHVubWFwcw0KPiB0aGUgcmF3IEhXUE9JU09OIHBhZ2UgKHByZXZpb3VzbHkgc3Bs
aXQgYW5kIG1hcHBlZCBhdCBQVEUgc2l6ZSkuDQo+IElmIEhHTSBmYWlsZWQgdG8gYmUgZW5hYmxl
ZCBvbiBlbGlnaWJsZSBWTUEgb3Igc3BsaXR0aW5nIGZhaWxlZCwNCj4gdHJ5X3RvX3VubWFwX29u
ZSBmYWlscy4NCj4gDQo+IEZvciBWTVMgdGhhdCBpcyBub3QgSEdNIGVsaWdpYmxlLCB0cnlfdG9f
dW5tYXBfb25lIHN0aWxsIHVubWFwcw0KPiB0aGUgd2hvbGUgUCpELg0KPiANCj4gV2hlbiBvbmx5
IHRoZSByYXcgSFdQT0lTT04gc3VicGFnZSBpcyB1bm1hcHBlZCBidXQgb3RoZXJzIGtlZXAgbWFw
cGVkLA0KPiB0aGUgb2xkIHdheSBpbiBtZW1vcnlfZmFpbHVyZSB0byBjaGVjayBpZiB1bm1hcHBp
bmcgc3VjY2Vzc2Z1bCBkb2Vzbid0DQo+IHdvcmsuIFNvIGludHJvZHVjZSBpc191bm1hcHBpbmdf
c3VjY2Vzc2Z1bCgpIHRvIGNvdmVyIGJvdGggZXhpc3RpbmcgYW5kDQo+IG5ldyB1bm1hcHBpbmcg
YmVoYXZpb3IuDQo+IA0KPiBGb3IgdGhlIG5ldyB1bm1hcHBpbmcgYmVoYXZpb3IsIHN0b3JlIGhv
dyBtYW55IHRpbWVzIGEgcmF3IEhXUE9JU09OIHBhZ2UNCj4gaXMgZXhwZWN0ZWQgdG8gYmUgdW5t
YXBwZWQsIGFuZCBob3cgbWFueSB0aW1lcyBpdCBpcyBhY3R1YWxseSB1bm1hcHBlZA0KPiBpbiB0
cnlfdG9fdW5tYXBfb25lKCkuIEEgSFdQT0lTT04gcmF3IHBhZ2UgaXMgZXhwZWN0ZWQgdG8gYmUg
dW5tYXBwZWQNCj4gZnJvbSBhIFZNQSBpZiBzcGxpdHRpbmcgc3VjY2VlZGVkIGluIHRyeV90b19z
cGxpdF9odWdlX21hcHBpbmcoKSwgc28NCj4gdW5tYXBfc3VjY2VzcyA9IChucl9leHBlY3RlZF91
bmFtcHMgPT0gbnJfYWN0dWFsX3VubWFwcykuDQo+IA0KPiBPbGQgZm9saW9fc2V0X2h1Z2V0bGJf
aHdwb2lzb24gcmV0dXJucyAtRUhXUE9JU09OIGlmIGEgZm9saW8gaGFzIGFueQ0KPiByYXcgSFdQ
T0lTT04gc3VicGFnZSwgYW5kIHRyeV9tZW1vcnlfZmFpbHVyZV9odWdldGxiIHdvbid0IGF0dGVt
cHQNCj4gcmVjb3ZlcnkgYWN0aW9ucyBhZ2FpbiBiZWNhdXNlIHJlY292ZXJ5IHVzZWQgdG8gYmUg
ZG9uZSBvbiB0aGUgZW50aXJlDQo+IGh1Z2VwYWdlLiBXaXRoIHRoZSBuZXcgdW5tYXBwaW5nIGJl
aGF2aW9yLCB0aGlzIGRvZXNuJ3QgaG9sZC4gTW9yZQ0KPiBzdWJwYWdlcyBpbiB0aGUgaHVnZXBh
Z2UgY2FuIGJlY29tZSBjb3JydXB0ZWQsIGFuZCBuZWVkcyB0byBiZSByZWNvdmVyZWQNCj4gKGku
ZS4gdW5tYXBwZWQpIGluZGl2aWR1YWxseS4gTmV3IGZvbGlvX3NldF9odWdldGxiX2h3cG9pc29u
IHJldHVybnMNCj4gMCBhZnRlciBhZGRpbmcgYSBuZXcgcmF3IHN1YnBhZ2UgdG8gcmF3X2h3cF9s
aXN0Lg0KPiANCj4gVW5tYXBwaW5nIHJhdyBIV1BPSVNPTiBwYWdlIHJlcXVpcmVzIGFsbG9jYXRp
bmcgcmF3X2h3cF9wYWdlDQo+IHN1Y2Nlc3NmdWxseSBpbiBmb2xpb19zZXRfaHVnZXRsYl9od3Bv
aXNvbiwgc28gdHJ5X21lbW9yeV9mYWlsdXJlX2h1Z2V0bGINCj4gbm93IG1heSBmYWlsIGR1ZSB0
byBPT00uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKaWFxaSBZYW4gPGppYXFpeWFuQGdvb2dsZS5j
b20+DQo+IC0tLQ0KLi4uDQoNCj4gQEAgLTE4MjcsNiArMTg3OSwzMSBAQCBFWFBPUlRfU1lNQk9M
X0dQTChtZl9kYXhfa2lsbF9wcm9jcyk7DQo+ICANCj4gICNpZmRlZiBDT05GSUdfSFVHRVRMQl9Q
QUdFDQo+ICANCj4gKy8qDQo+ICsgKiBHaXZlbiBhIEhXUE9JU09OIEBzdWJwYWdlIGFzIHJhdyBw
YWdlLCBmaW5kIGl0cyBsb2NhdGlvbiBpbiBAZm9saW8ncw0KPiArICogX2h1Z2V0bGJfaHdwb2lz
b24uIFJldHVybiBOVUxMIGlmIEBzdWJwYWdlIGlzIG5vdCBpbiB0aGUgbGlzdC4NCj4gKyAqLw0K
PiArc3RydWN0IHJhd19od3BfcGFnZSAqZmluZF9pbl9yYXdfaHdwX2xpc3Qoc3RydWN0IGZvbGlv
ICpmb2xpbywNCj4gKwkJCQkJICBzdHJ1Y3QgcGFnZSAqc3VicGFnZSkNCj4gK3sNCj4gKwlzdHJ1
Y3QgbGxpc3Rfbm9kZSAqdCwgKnRub2RlOw0KPiArCXN0cnVjdCBsbGlzdF9oZWFkICpyYXdfaHdw
X2hlYWQgPSByYXdfaHdwX2xpc3RfaGVhZChmb2xpbyk7DQo+ICsJc3RydWN0IHJhd19od3BfcGFn
ZSAqaHdwX3BhZ2UgPSBOVUxMOw0KPiArCXN0cnVjdCByYXdfaHdwX3BhZ2UgKnA7DQo+ICsNCj4g
KwlWTV9CVUdfT05fUEFHRShQYWdlSFdQb2lzb24oc3VicGFnZSksIHN1YnBhZ2UpOw0KDQpJJ20g
dGVzdGluZyB0aGUgc2VyaWVzIChvbiB0b3Agb2YgdjYuMi1yYzQgKyBIR00gdjIgcGF0Y2hzZXQp
IGFuZCBmb3VuZCB0aGUNCmZvbGxvd2luZyBlcnJvciB0cmlnZ2VyZWQgYnkgdGhpcyBWTV9CVUdf
T05fUEFHRSgpLiAgVGhlIHRlc3RjYXNlIGlzIGp1c3QgdG8NCmluamVjdCBod3BvaXNvbiBvbiBh
biBhbm9ueW1vdXMgcGFnZSAoaXQncyBub3QgaHVnZXRsYi1yZWxhdGVkIG9uZSkuDQoNCiAgWyAg
NzkwLjYxMDk4NV0gPT09PiB0ZXN0Y2FzZSAnbW0vaHdwb2lzb24vYmFzZS9iYWNrZW5kLWFub255
bW91c19lcnJvci1oYXJkLW9mZmxpbmVfYWNjZXNzLWF2b2lkLmF1dG8zJyBzdGFydA0KICBbICA3
OTMuMzA0OTI3XSBwYWdlOjAwMDAwMDAwNjc0MzE3N2IgcmVmY291bnQ6MSBtYXBjb3VudDowIG1h
cHBpbmc6MDAwMDAwMDAwMDAwMDAwMCBpbmRleDoweDcwMDAwMDAwMCBwZm46MHgxNGQ3MzkNCiAg
WyAgNzkzLjMwOTMyMl0gbWVtY2c6ZmZmZjhhMzBjNTBiNjAwMA0KICBbICA3OTMuMzEwOTM0XSBh
bm9uIGZsYWdzOiAweDU3ZmZmZmUwOGEwMDFkKGxvY2tlZHx1cHRvZGF0ZXxkaXJ0eXxscnV8bWFw
cGVkdG9kaXNrfHN3YXBiYWNrZWR8aHdwb2lzb258bm9kZT0xfHpvbmU9MnxsYXN0Y3B1cGlkPTB4
MWZmZmZmKQ0KICBbICA3OTMuMzE2NjY1XSByYXc6IDAwNTdmZmZmZTA4YTAwMWQgZmZmZmU5M2Nj
NTM1M2M4OCBmZmZmZTkzY2M1Njg1ZmM4IGZmZmY4YTMwYzkxODc4ZjENCiAgWyAgNzkzLjMyMDIx
MV0gcmF3OiAwMDAwMDAwNzAwMDAwMDAwIDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDFmZmZmZmZm
ZiBmZmZmOGEzMGM1MGI2MDAwDQogIFsgIDc5My4zMjM2NjVdIHBhZ2UgZHVtcGVkIGJlY2F1c2U6
IFZNX0JVR19PTl9QQUdFKFBhZ2VIV1BvaXNvbihzdWJwYWdlKSkNCiAgWyAgNzkzLjMyNjc2NF0g
LS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQogIFsgIDc5My4zMjkwODBdIGtl
cm5lbCBCVUcgYXQgbW0vbWVtb3J5LWZhaWx1cmUuYzoxODk0IQ0KICBbICA3OTMuMzMxODk1XSBp
bnZhbGlkIG9wY29kZTogMDAwMCBbIzFdIFBSRUVNUFQgU01QIFBUSQ0KICBbICA3OTMuMzM0ODU0
XSBDUFU6IDQgUElEOiAyNjQ0IENvbW06IG1jZWluai5zaCBUYWludGVkOiBHICAgICAgICAgICAg
RSAgICBOIDYuMi4wLXJjNC12Ni4yLXJjMi0yMzA1MjktMTQwNCsgIzYzDQogIFsgIDc5My4zNDA3
MTBdIEhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKGk0NDBGWCArIFBJSVgsIDE5OTYp
LCBCSU9TIDEuMTYuMS0yLmZjMzcgMDQvMDEvMjAxNA0KICBbICA3OTMuMzQ1ODc1XSBSSVA6IDAw
MTA6aHdwb2lzb25fdXNlcl9tYXBwaW5ncysweDY1NC8weDc4MA0KICBbICA3OTMuMzQ5MDY2XSBD
b2RlOiBlZiA4OSBkZSBlOCA2ZSBiYyBmOCBmZiA0OCA4YiA3YyAyNCAyMCA0OCA4MyBjNyA1OCBl
OCAxMCBiYiBkOSBmZiBlOSA1ZiBmYiBmZiBmZiA0OCBjNyBjNiA4MCBjZSA0YyBiMSA0YyA4OSBl
ZiBlOCAxYyAzOCBmNiBmZiA8MGY+IDBiIDQ4IGM3IGM2IDdiIGM4IDRjIGIxIDRjIDg5IGVmIGU4
IDBiIDM4IGY2IGZmIDBmIDBiIDhiIDQ1IDU4DQogIFsgIDc5My4zNTk3MzJdIFJTUDogMDAxODpm
ZmZmYTNmZjg1ZWQzZDI4IEVGTEFHUzogMDAwMTAyOTYNCiAgWyAgNzkzLjM2MjM2N10gUkFYOiAw
MDAwMDAwMDAwMDAwMDNhIFJCWDogMDAwMDAwMDAwMDAwMDAxOCBSQ1g6IDAwMDAwMDAwMDAwMDAw
MDANCiAgWyAgNzkzLjM2NTc2M10gUkRYOiAwMDAwMDAwMDAwMDAwMDAxIFJTSTogZmZmZmZmZmZi
MTRhYzQ1MSBSREk6IDAwMDAwMDAwZmZmZmZmZmYNCiAgWyAgNzkzLjM2ODY5OF0gUkJQOiBmZmZm
ZTkzY2M1MzVjZTQwIFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IGZmZmZhM2ZmODVlZDNiYTAN
CiAgWyAgNzkzLjM3MDgzN10gUjEwOiAwMDAwMDAwMDAwMDAwMDAzIFIxMTogZmZmZmZmZmZiMWQz
ZWQyOCBSMTI6IDAwMDAwMDAwMDAxNGQ3MzkNCiAgWyAgNzkzLjM3MjkwM10gUjEzOiBmZmZmZTkz
Y2M1MzVjZTQwIFIxNDogZmZmZmU5M2NjNTM1Y2U0MCBSMTU6IGZmZmZlOTNjYzUzNWNlNDANCiAg
WyAgNzkzLjM3NDkzMV0gRlM6ICAwMDAwN2Y2Y2NjNDJhNzQwKDAwMDApIEdTOmZmZmY4YTMxYmJj
MDAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KICBbICA3OTMuMzc3MTM2XSBDUzog
IDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQogIFsgIDc5My4z
Nzg2NTZdIENSMjogMDAwMDU2MWFhZDY0NzRiMiBDUjM6IDAwMDAwMDAxNDkyZDQwMDUgQ1I0OiAw
MDAwMDAwMDAwMTcwZWUwDQogIFsgIDc5My4zODA1MTRdIERSMDogZmZmZmZmZmZiMjhlZDdkMCBE
UjE6IGZmZmZmZmZmYjI4ZWQ3ZDEgRFIyOiBmZmZmZmZmZmIyOGVkN2QyDQogIFsgIDc5My4zODIy
OTZdIERSMzogZmZmZmZmZmZiMjhlZDdkMyBEUjY6IDAwMDAwMDAwZmZmZjBmZjAgRFI3OiAwMDAw
MDAwMDAwMDAwNjAwDQogIFsgIDc5My4zODQwMjhdIENhbGwgVHJhY2U6DQogIFsgIDc5My4zODQ2
NTVdICA8VEFTSz4NCiAgWyAgNzkzLjM4NTIxMF0gID8gX19scnVfYWRkX2RyYWluX2FsbCsweDE2
NC8weDFmMA0KICBbICA3OTMuMzg2MzE2XSAgbWVtb3J5X2ZhaWx1cmUrMHgzNTIvMHhhYTANCiAg
WyAgNzkzLjM4NzI0OV0gID8gX19wZnhfYnBmX2xzbV9jYXBhYmxlKzB4MTAvMHgxMA0KICBbICA3
OTMuMzg4MzIzXSAgPyBfX3BmeF9zZWN1cml0eV9jYXBhYmxlKzB4MTAvMHgxMA0KICBbICA3OTMu
Mzg5MzUwXSAgaGFyZF9vZmZsaW5lX3BhZ2Vfc3RvcmUrMHg0Ni8weDgwDQogIFsgIDc5My4zOTAz
OTddICBrZXJuZnNfZm9wX3dyaXRlX2l0ZXIrMHgxMWUvMHgyMDANCiAgWyAgNzkzLjM5MTQ0MV0g
IHZmc193cml0ZSsweDFlNC8weDNhMA0KICBbICA3OTMuMzkyMjIxXSAga3N5c193cml0ZSsweDUz
LzB4ZDANCiAgWyAgNzkzLjM5Mjk3Nl0gIGRvX3N5c2NhbGxfNjQrMHgzYS8weDkwDQogIFsgIDc5
My4zOTM3OTBdICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Mi8weGRjDQoNCkkn
bSB3b25kZXJpbmcgaG93IHRoaXMgY29kZSBwYXRoIGlzIGNhbGxlZCwgb25lIHBvc3NpYmxlIHBh
dGggaXMgbGlrZSB0aGlzOg0KDQogIGh3cG9pc29uX3VzZXJfbWFwcGluZ3MNCiAgICBpZiBQYWdl
SHVnZShocGFnZSkgJiYgIVBhZ2VBbm9uKGhwYWdlKQ0KICAgICAgdHJ5X3RvX3NwbGl0X2h1Z2Vf
bWFwcGluZygpDQogICAgICAgIGZpbmRfaW5fcmF3X2h3cF9saXN0DQogICAgICAgICAgVk1fQlVH
X09OX1BBR0UoUGFnZUhXUG9pc29uKHN1YnBhZ2UpLCBzdWJwYWdlKQ0KDQpidXQgdGhpcyBsb29r
cyB1bmxpa2VseSBiZWNhdXNlIHRoZSBwcmVjaGVjayAiUGFnZUh1Z2UoaHBhZ2UpICYmICFQYWdl
QW5vbihocGFnZSkiIGlzDQpmYWxzZSBmb3IgYW5vbnltb3VzIHBhZ2VzLg0KDQpBbm90aGVyIHBv
c3NpYmxlIGNvZGUgcGF0aCBpczoNCg0KICBod3BvaXNvbl91c2VyX21hcHBpbmdzDQogICAgaWYg
UGFnZUh1Z2UoaHBhZ2UpICYmICFQYWdlQW5vbihocGFnZSkNCiAgICAgIC4uLg0KICAgIGVsc2UN
CiAgICAgIHRyeV90b191bm1hcA0KICAgICAgICBybWFwX3dhbGsNCiAgICAgICAgICBybWFwX3dh
bGtfYW5vbg0KICAgICAgICAgICAgdHJ5X3RvX3VubWFwX29uZQ0KICAgICAgICAgICAgICBpZiBm
b2xpb190ZXN0X2h1Z2V0bGINCiAgICAgICAgICAgICAgICBpZiBoZ21fZWxpZ2libGUNCiAgICAg
ICAgICAgICAgICAgIGZpbmRfaW5fcmF3X2h3cF9saXN0DQogICAgICAgICAgICAgICAgICAgIFZN
X0JVR19PTl9QQUdFKFBhZ2VIV1BvaXNvbihzdWJwYWdlKSwgc3VicGFnZSkNCg0KYnV0IHRoaXMg
bG9va3MgYWxzbyB1bmxpa2VseSBiZWNhdXNlIG9mIGNoZWNraW5nIGZvbGlvX3Rlc3RfaHVnZXRs
YiBhbmQgaGdtX2VsaWdpYmxlDQooSSB0aGluayBib3RoIGFyZSBmYWxzZSBpbiB0aGlzIHRlc3Rj
YXNlLikNCk1heWJlIEkgbWlzcyBzb21ldGhpbmcgKGFuZCBJJ2xsIGRpZyB0aGlzIG1vcmUpLCBi
dXQgbGV0IG1lIHNoYXJlIHRoZSBpc3N1ZS4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hpDQo=
