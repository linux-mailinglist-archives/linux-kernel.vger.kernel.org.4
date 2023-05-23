Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D2670D17A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbjEWCnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjEWCnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:43:13 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2067.outbound.protection.outlook.com [40.107.114.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FFBCD
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:43:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQVrLeOhZM2VuJIkGCiHXmNB57DAbojjKuEhReRaDQ+sJlwKC4SN3yJt72TrsesSXJ5VYr0vNdBKZFcjSnCIVhWfGrkDsm3VoVbugPflkZockCUIZprFpIY/2VFfKq390CYJVXiubrIdx+aB61ESjRZs+wZyhrVFmg8NCwEwVagM6ovD68Wus04WkQQyJRDy6ioKqe/fRW24IyUkk6Apl3fcSWl8wQmALIR1BkoZiZY9YnXS9jbA+Y4A/5W3FlyZewVrjIWKc6AdMSOICGWWndVbNCTJHfNYsmORp+OgpuRtjFr4Ayo1hbZHogNADYEapctju+JJxX9sCyN1WjKLiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5I7PtVhPX4aZOU/vx0CGojspyLZqV52hz4zMPvB+yA=;
 b=D/rE3OV1Dl+/G0s1c3bxOtd558fQ8ar0MWtiJUlfSLBsk09blD82/RSOA0YZ4VHXPQqEwyd1zu0UJJvs2BD5kfrP8Z723g9oHTVdDuvdtCs6EY6D/xFnd4mRd1gR725SiF6bNFSoDbyhtR9V8+H2WnPSsyJEjPD8AjC++NtP1IR2/9s4MkRm3EvoQNWLgUw97IiTIPDCDFv5EwYFd90DQcxTxLNxyL47Xd8UO0ZQj5RoBWO4nzx+2jHVGQGta71PJchxUBkCcvV0W9mLHJ/YDn21lMVP8SlSyzYUOV6YdXN/3TlAOnpI6fT2+zBMvw4lo4/3TlruB3rSts2xNxja6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5I7PtVhPX4aZOU/vx0CGojspyLZqV52hz4zMPvB+yA=;
 b=cZ7+7Jyw8qwgZvlP6rs9u1E0GRDuXHHEIyEbe4nbD2dqpsFqlYYqC4cRLWmOtugdGc/yVTAU/Uo7gZgxHmr7hsvefPtFxmFPTneUp5GEfIg/Mmdk9loOjQ2fUtgXdSGaVoOEIZqrS9qutH05hl4WPpYZDlwiK2A7Re9PXhEgguc=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY3PR01MB10353.jpnprd01.prod.outlook.com (2603:1096:400:251::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 02:43:08 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::15c9:309c:d898:c0f5]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::15c9:309c:d898:c0f5%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 02:43:08 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Jiaqi Yan <jiaqiyan@google.com>
CC:     Mike Kravetz <mike.kravetz@oracle.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "duenwen@google.com" <duenwen@google.com>,
        "axelrasmussen@google.com" <axelrasmussen@google.com>,
        "jthoughton@google.com" <jthoughton@google.com>
Subject: Re: [PATCH v1 1/3] mm/hwpoison: find subpage in hugetlb HWPOISON list
Thread-Topic: [PATCH v1 1/3] mm/hwpoison: find subpage in hugetlb HWPOISON
 list
Thread-Index: AQHZiNoPwcxOaLRqBUOFhzfdsXoVo69fI8gAgALyqwCAAB4oAIADizyAgADjSICAAIvGgA==
Date:   Tue, 23 May 2023 02:43:07 +0000
Message-ID: <20230523024305.GA920098@hori.linux.bs1.fc.nec.co.jp>
References: <20230517160948.811355-1-jiaqiyan@google.com>
 <20230517160948.811355-2-jiaqiyan@google.com> <20230517235314.GB10757@monkey>
 <CACw3F52zNguJ-MvXOAJuMK+JfreLxorvHDPwO8w_gQdOzWj7eA@mail.gmail.com>
 <20230519224214.GB3581@monkey>
 <20230522044557.GA845371@hori.linux.bs1.fc.nec.co.jp>
 <CACw3F50rkrWkdMKo7yq35vDbGrcF4b0zohN3dORxL_h0KxZ7Bg@mail.gmail.com>
In-Reply-To: <CACw3F50rkrWkdMKo7yq35vDbGrcF4b0zohN3dORxL_h0KxZ7Bg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TY3PR01MB10353:EE_
x-ms-office365-filtering-correlation-id: 60c27a19-c3cc-451f-0aac-08db5b377108
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eH5suR309hhLtX4RyohLkDCzmKH+0dp8L2Y3ZjOWUcX5c67+gAHi2OSlYhRuCqXzij5OFm+1uIpbpCNek0uYfyZ74QijAbVuxJS3OqxPugsH2jQSmro6wyWtH8Zjx6b+fCh1pEUfO4p6GGeBsAG0K/tEjxlKIPdQAUA84YFNk7ESRZMS5SnQV27rXW+H5OOoOsBx64rdpTzKdVaNjKBnJI4+vbMD9obMolQnHQ5g7Abcp5XC15fNkdiDxe1k3cMRljurJ1okWRDl/+s7YKUt5S64ioQqEYP7Fuh6z4qUeR5xGM3F5DQh7Tv94dvKxTsmKSSaOyc3WnYpA0af4bwEEd0bdMnj41Tyq30bYhYDFPUNnTVhYd2hZgBekalwsvosLrujzjYl40igJ77IhBtihlbzFhbvPLljyvG/I53Es6KdIZi3fLyJ53j6j8eqPAhc6uG+GtYRw45pciUuUTwr2m4RuitVBeo7a06iYbZnv+tPr6+cQldgi57kEoQxQYBGz+C7XnfKKffLktxDkXwT2uysL4JpGwKOSrFHRKAtG7HtwDV4P6aD5eklDpMjm+zVFEfYWcR6XRxMGW5uv7AzZXSlEu7OWIjojmye9DQbSQ2pD/8NjxxJQZu5Lpa6hsTa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(85182001)(186003)(2906002)(7416002)(8676002)(8936002)(6512007)(6506007)(1076003)(26005)(9686003)(53546011)(5660300002)(478600001)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(6916009)(4326008)(86362001)(38100700002)(38070700005)(54906003)(122000001)(82960400001)(83380400001)(41300700001)(6486002)(71200400001)(316002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzZYd2ZjSXcrUjkzRldubVNXOCtZU0c4T1NhcWFQL2J4ODVqOVZ0YlhOenZY?=
 =?utf-8?B?L3RCZGp2MWxlYU4wZzlsYU9XbWNpSy9BbWZDeThENnRKMmZLNjMxUjUvQ3V1?=
 =?utf-8?B?MVRKTlYraFpQclNudHBINFRHZlF0YjZJWUNta2JJbHJkVGVXam5tWTA5cy94?=
 =?utf-8?B?R1JadWk1MTdRK0UvVFYyckI0UWdpZHMzYUhiM0txZE1OcGJ6U1JKdkxSNWdN?=
 =?utf-8?B?dWZwNVhwMHBkOGZ3dW5YaW9nd1U3c0ZhV21yaXI3ZzhmS1o1NExTcFl2K2pF?=
 =?utf-8?B?NU5oQXRyY1BoMU9ETWpLT3VhRUpvUC9haGZEajV6dWxoTmg4NCtwNDNSTStL?=
 =?utf-8?B?ZlhNMjZadEsyUlB2eVFyQ3VBWWNTOFA5Y3JzTngrang5ODhsSmk0TkRWc01C?=
 =?utf-8?B?S05NYmpXS0ExMjdaalJuUzh0TklST2g2Q0h1cGJrYkVaVEpuNDRaVlJ4Qmp1?=
 =?utf-8?B?SnZsYUFwY3gxTGZXMTYrU1o0UTJjbDlPbHRtZW5QVVdjSmNERXNqS1lldU41?=
 =?utf-8?B?cmF3S1lYelV6S1BVVDNVcXFyR2M4b2tTakJ5ZU9Kb0RVQU5tWWNkVkJaeWJj?=
 =?utf-8?B?dEk2d3haNVloRFM5TnhyZ0haTGU4SGZKK0RNU2FEWVhITU1OTWRmdnF0bjVt?=
 =?utf-8?B?VS9tR20xZzE4L2s4dmNZZVRKWGxqVFlVazRPVWRGRjFVV3pOMEt1VGwrdGpj?=
 =?utf-8?B?VFBsOTFrL3VkVHczR3ZYMkVVSUNSWExOZDNqVjBDWGRtZHlYL3YzME0yamhn?=
 =?utf-8?B?bG1qMXp1eUhkM3BmQlB4a0lVZWlvUlpPQzNFZ1VJcFU1OGJXUitqME9mV3R1?=
 =?utf-8?B?ZEhHelJFc1VsQXY4T3JxMjJOcWRhZlFTY1FkTnVPWUZkVExyQzJVZ1h1bGFw?=
 =?utf-8?B?cVhiOEg3VmhhT25KVFY3Y0Z4WkVvZkxqak9lUG82MFNFcm1ERnliZWpZYjAw?=
 =?utf-8?B?SkJjbzlKVTRWa2RiOE5aT1dPZytyQjdZSjVoUjdvVHcyVDh3cnVsVFFCYnIy?=
 =?utf-8?B?K2J5ZnJHamtCdmk2TEFUeDFIbTN0UlpQMWlxclVCbnF5V094bWc2RUlXVkNm?=
 =?utf-8?B?Z0drYW4zWk5GMER5T3VqUDdSVDRLTW0rTkpmYXd5dUk1YWFnRHdRbW1Ib09v?=
 =?utf-8?B?YmJRbVdmMW43OVM4REpBMWtFbm9mQjhPQy9rZENxMkQvdEtWRzVJUkd0WFA5?=
 =?utf-8?B?VytaZmM0VHBtbGI0OWt3OGpuTG9lRnVWeHp5WURFRzdNaklybG0xR1lYME15?=
 =?utf-8?B?NWFKK1hndXlUWGtiMStlUk9GZFJXb0NIQUNUd1BnaUpxZHg4cFdDRjYzRWp2?=
 =?utf-8?B?dk5kK3RwZndaUGZFWlFSR2RCNG56UnkwRmpuS3JOV2U2L0I3Wno5OEkrMHN3?=
 =?utf-8?B?aUQ0Z2Y1WEZ1bGpyU1c2eDFmRU1FWm13YUxSZlJVeG0xSllVeDJvdytUSldu?=
 =?utf-8?B?bWM1Tmt4Rk9vZnlpMFdPSkNIdmRBM1VlZW9iVGprWTZpanQ1VnZCTS9kVFFQ?=
 =?utf-8?B?V1Y4N09sazRza09VNEs3NHhBN2krMDVUeVBuN2NxeHgxVGlUSGdNcXJ2YkJ6?=
 =?utf-8?B?c0srdHIxVVJ0Mk9WSkExbll4dThXNEJMdXFvNStxWFBZblZRTjU2bnRMbkIx?=
 =?utf-8?B?TnRlNmNYZCs4OUFJUTVDT0FERHM2d0p2M0ZIK0pDalloaWxVb1QzaXZFY3I2?=
 =?utf-8?B?UXNSQVp3eE9ZeXBnYTlBeXlyY2o2UUl0YkNGOFltTnV3RFBuNGtoTCsrNEVw?=
 =?utf-8?B?Ym1YeUE1MEtWTEJyNmllTUk3Y0dRSWJ5VHRVS3hheXo4b25SM1FVbTh3MW5F?=
 =?utf-8?B?b0Z4cXJGOGhZZ2FaYUVDUjhZTU12T1c2U2tlU1VmSktIbFF3enNzc3N3TzRh?=
 =?utf-8?B?OHBDK3NFM2FPRDl0VDUwZmUvN3VDTHUrcXFsUGowM0NkMkNjU3V6Mzc0M3Bp?=
 =?utf-8?B?MUVwSWQxK2RjM2Z6Q3g4bkN5bEkxUFVBM2FxU2s4Wk5yb0JvMDVWMnFtNUtV?=
 =?utf-8?B?VnJWL2dKMGZhcmNPQWFOTDVLN3BwanlnYWdROEYrRW9UVDJSbE0rSWl0allM?=
 =?utf-8?B?YjQ5MDlwUVpWUVRXMXQreExsQ3BXTXRWRWU3WHdMQ3ZtdmtkSUphQ3VmYXBL?=
 =?utf-8?B?TjFlUHNwSkVSOEkwLzB6RElQeDJxNzE0Q2VCZXFZQUZWMEN1WXRTQXpLK0Fl?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDEFC0D854AF9842BC04DAC0FEF230C0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c27a19-c3cc-451f-0aac-08db5b377108
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 02:43:08.0236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rVqAfF+VhZS4alf/sXvjJUwJWMgx2fLlfDYAyMp/9ir03LL4e0mNXMm6f/BeZ/wZi4zZbxvADJsEAqJfOV8ITg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10353
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBNYXkgMjIsIDIwMjMgYXQgMTE6MjI6NDlBTSAtMDcwMCwgSmlhcWkgWWFuIHdyb3Rl
Og0KPiBPbiBTdW4sIE1heSAyMSwgMjAyMyBhdCA5OjUw4oCvUE0gSE9SSUdVQ0hJIE5BT1lBKOWg
gOWPo+OAgOebtOS5nykNCj4gPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPiB3cm90ZToNCj4gPg0K
PiA+IE9uIEZyaSwgTWF5IDE5LCAyMDIzIGF0IDAzOjQyOjE0UE0gLTA3MDAsIE1pa2UgS3JhdmV0
eiB3cm90ZToNCj4gPiA+IE9uIDA1LzE5LzIzIDEzOjU0LCBKaWFxaSBZYW4gd3JvdGU6DQo+ID4g
PiA+IE9uIFdlZCwgTWF5IDE3LCAyMDIzIGF0IDQ6NTPigK9QTSBNaWtlIEtyYXZldHogPG1pa2Uu
a3JhdmV0ekBvcmFjbGUuY29tPiB3cm90ZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9uIDA1LzE3
LzIzIDE2OjA5LCBKaWFxaSBZYW4gd3JvdGU6DQo+ID4gPiA+ID4gPiBBZGRzIHRoZSBmdW5jdGlv
bmFsaXR5IHRvIHNlYXJjaCBhIHN1YnBhZ2UncyBjb3JyZXNwb25kaW5nIHJhd19od3BfcGFnZQ0K
PiA+ID4gPiA+ID4gaW4gaHVnZXRsYiBwYWdlJ3MgSFdQT0lTT04gbGlzdC4gVGhpcyBmdW5jdGlv
bmFsaXR5IGNhbiBhbHNvIHRlbGwgaWYgYQ0KPiA+ID4gPiA+ID4gc3VicGFnZSBpcyBhIHJhdyBI
V1BPSVNPTiBwYWdlLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEV4cG9ydHMgdGhpcyBmdW5j
dGlvbmFsaXR5IHRvIGJlIGltbWVkaWF0ZWx5IHVzZWQgaW4gdGhlIHJlYWQgb3BlcmF0aW9uDQo+
ID4gPiA+ID4gPiBmb3IgaHVnZXRsYmZzLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IEppYXFpIFlhbiA8amlhcWl5YW5AZ29vZ2xlLmNvbT4NCj4gPiA+ID4gPiA+IC0t
LQ0KPiA+ID4gPiA+ID4gIGluY2x1ZGUvbGludXgvbW0uaCAgfCAyMyArKysrKysrKysrKysrKysr
KysrKysrKw0KPiA+ID4gPiA+ID4gIG1tL21lbW9yeS1mYWlsdXJlLmMgfCAyNiArKysrKysrKysr
KysrKysrLS0tLS0tLS0tLQ0KPiA+ID4gPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMzkgaW5zZXJ0
aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvbW0uaCBiL2luY2x1ZGUvbGludXgvbW0uaA0KPiA+ID4gPiA+
ID4gaW5kZXggMjdjZTc3MDgwYzc5Li5mMTkxYTQxMTk3MTkgMTAwNjQ0DQo+ID4gPiA+ID4gPiAt
LS0gYS9pbmNsdWRlL2xpbnV4L21tLmgNCj4gPiA+ID4gPiA+ICsrKyBiL2luY2x1ZGUvbGludXgv
bW0uaA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQW55IHJlYXNvbiB3aHkgeW91IGRlY2lkZWQgdG8g
YWRkIHRoZSBmb2xsb3dpbmcgdG8gbGludXgvbW0uaCBpbnN0ZWFkIG9mDQo+ID4gPiA+ID4gbGlu
dXgvaHVnZXRsYi5oPyAgU2luY2UgaXQgaXMgaHVnZXRsYiBzcGVjaWZpYyBJIHdvdWxkIGhhdmUg
dGhvdWdodA0KPiA+ID4gPiA+IGh1Z2V0bGIuaCB3YXMgbW9yZSBhcHByb3ByaWF0ZS4NCj4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gQEAgLTM2ODMsNiArMzY4MywyOSBAQCBlbnVtIG1mX2FjdGlvbl9w
YWdlX3R5cGUgew0KPiA+ID4gPiA+ID4gICAqLw0KPiA+ID4gPiA+ID4gIGV4dGVybiBjb25zdCBz
dHJ1Y3QgYXR0cmlidXRlX2dyb3VwIG1lbW9yeV9mYWlsdXJlX2F0dHJfZ3JvdXA7DQo+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gKyNpZmRlZiBDT05GSUdfSFVHRVRMQl9QQUdFDQo+ID4gPiA+ID4g
PiArLyoNCj4gPiA+ID4gPiA+ICsgKiBTdHJ1Y3QgcmF3X2h3cF9wYWdlIHJlcHJlc2VudHMgaW5m
b3JtYXRpb24gYWJvdXQgInJhdyBlcnJvciBwYWdlIiwNCj4gPiA+ID4gPiA+ICsgKiBjb25zdHJ1
Y3Rpbmcgc2luZ2x5IGxpbmtlZCBsaXN0IGZyb20gLT5faHVnZXRsYl9od3BvaXNvbiBmaWVsZCBv
ZiBmb2xpby4NCj4gPiA+ID4gPiA+ICsgKi8NCj4gPiA+ID4gPiA+ICtzdHJ1Y3QgcmF3X2h3cF9w
YWdlIHsNCj4gPiA+ID4gPiA+ICsgICAgIHN0cnVjdCBsbGlzdF9ub2RlIG5vZGU7DQo+ID4gPiA+
ID4gPiArICAgICBzdHJ1Y3QgcGFnZSAqcGFnZTsNCj4gPiA+ID4gPiA+ICt9Ow0KPiA+ID4gPiA+
ID4gKw0KPiA+ID4gPiA+ID4gK3N0YXRpYyBpbmxpbmUgc3RydWN0IGxsaXN0X2hlYWQgKnJhd19o
d3BfbGlzdF9oZWFkKHN0cnVjdCBmb2xpbyAqZm9saW8pDQo+ID4gPiA+ID4gPiArew0KPiA+ID4g
PiA+ID4gKyAgICAgcmV0dXJuIChzdHJ1Y3QgbGxpc3RfaGVhZCAqKSZmb2xpby0+X2h1Z2V0bGJf
aHdwb2lzb247DQo+ID4gPiA+ID4gPiArfQ0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKy8q
DQo+ID4gPiA+ID4gPiArICogR2l2ZW4gQHN1YnBhZ2UsIGEgcmF3IHBhZ2UgaW4gYSBodWdlcGFn
ZSwgZmluZCBpdHMgbG9jYXRpb24gaW4gQGZvbGlvJ3MNCj4gPiA+ID4gPiA+ICsgKiBfaHVnZXRs
Yl9od3BvaXNvbiBsaXN0LiBSZXR1cm4gTlVMTCBpZiBAc3VicGFnZSBpcyBub3QgaW4gdGhlIGxp
c3QuDQo+ID4gPiA+ID4gPiArICovDQo+ID4gPiA+ID4gPiArc3RydWN0IHJhd19od3BfcGFnZSAq
ZmluZF9yYXdfaHdwX3BhZ2Uoc3RydWN0IGZvbGlvICpmb2xpbywNCj4gPiA+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgcGFnZSAqc3VicGFnZSk7DQo+
ID4gPiA+ID4gPiArI2VuZGlmDQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiAgI2lmIGRlZmlu
ZWQoQ09ORklHX1RSQU5TUEFSRU5UX0hVR0VQQUdFKSB8fCBkZWZpbmVkKENPTkZJR19IVUdFVExC
RlMpDQo+ID4gPiA+ID4gPiAgZXh0ZXJuIHZvaWQgY2xlYXJfaHVnZV9wYWdlKHN0cnVjdCBwYWdl
ICpwYWdlLA0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBs
b25nIGFkZHJfaGludCwNCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9tbS9tZW1vcnktZmFpbHVy
ZS5jIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+ID4gPiA+ID4gaW5kZXggNWI2NjNlY2ExZjI5
Li5jNDllNmMyZDFmMDcgMTAwNjQ0DQo+ID4gPiA+ID4gPiAtLS0gYS9tbS9tZW1vcnktZmFpbHVy
ZS5jDQo+ID4gPiA+ID4gPiArKysgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ID4gPiA+ID4gPiBA
QCAtMTgxOCwxOCArMTgxOCwyNCBAQCBFWFBPUlRfU1lNQk9MX0dQTChtZl9kYXhfa2lsbF9wcm9j
cyk7DQo+ID4gPiA+ID4gPiAgI2VuZGlmIC8qIENPTkZJR19GU19EQVggKi8NCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiAgI2lmZGVmIENPTkZJR19IVUdFVExCX1BBR0UNCj4gPiA+ID4gPiA+IC0v
Kg0KPiA+ID4gPiA+ID4gLSAqIFN0cnVjdCByYXdfaHdwX3BhZ2UgcmVwcmVzZW50cyBpbmZvcm1h
dGlvbiBhYm91dCAicmF3IGVycm9yIHBhZ2UiLA0KPiA+ID4gPiA+ID4gLSAqIGNvbnN0cnVjdGlu
ZyBzaW5nbHkgbGlua2VkIGxpc3QgZnJvbSAtPl9odWdldGxiX2h3cG9pc29uIGZpZWxkIG9mIGZv
bGlvLg0KPiA+ID4gPiA+ID4gLSAqLw0KPiA+ID4gPiA+ID4gLXN0cnVjdCByYXdfaHdwX3BhZ2Ug
ew0KPiA+ID4gPiA+ID4gLSAgICAgc3RydWN0IGxsaXN0X25vZGUgbm9kZTsNCj4gPiA+ID4gPiA+
IC0gICAgIHN0cnVjdCBwYWdlICpwYWdlOw0KPiA+ID4gPiA+ID4gLX07DQo+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gLXN0YXRpYyBpbmxpbmUgc3RydWN0IGxsaXN0X2hlYWQgKnJhd19od3BfbGlz
dF9oZWFkKHN0cnVjdCBmb2xpbyAqZm9saW8pDQo+ID4gPiA+ID4gPiArc3RydWN0IHJhd19od3Bf
cGFnZSAqZmluZF9yYXdfaHdwX3BhZ2Uoc3RydWN0IGZvbGlvICpmb2xpbywNCj4gPiA+ID4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgcGFnZSAqc3VicGFn
ZSkNCj4gPiA+ID4gPiA+ICB7DQo+ID4gPiA+ID4gPiAtICAgICByZXR1cm4gKHN0cnVjdCBsbGlz
dF9oZWFkICopJmZvbGlvLT5faHVnZXRsYl9od3BvaXNvbjsNCj4gPiA+ID4gPiA+ICsgICAgIHN0
cnVjdCBsbGlzdF9ub2RlICp0LCAqdG5vZGU7DQo+ID4gPiA+ID4gPiArICAgICBzdHJ1Y3QgbGxp
c3RfaGVhZCAqcmF3X2h3cF9oZWFkID0gcmF3X2h3cF9saXN0X2hlYWQoZm9saW8pOw0KPiA+ID4g
PiA+ID4gKyAgICAgc3RydWN0IHJhd19od3BfcGFnZSAqaHdwX3BhZ2UgPSBOVUxMOw0KPiA+ID4g
PiA+ID4gKyAgICAgc3RydWN0IHJhd19od3BfcGFnZSAqcDsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+
ID4gPiA+ICsgICAgIGxsaXN0X2Zvcl9lYWNoX3NhZmUodG5vZGUsIHQsIHJhd19od3BfaGVhZC0+
Zmlyc3QpIHsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IElJVUMsIGluIHJhcmUgZXJyb3IgY2FzZXMg
YSBodWdldGxiIHBhZ2UgY2FuIGJlIHBvaXNvbmVkIFdJVEhPVVQgYQ0KPiA+ID4gPiA+IHJhd19o
d3BfbGlzdC4gIFRoaXMgaXMgaW5kaWNhdGVkIGJ5IHRoZSBodWdldGxiIHBhZ2Ugc3BlY2lmaWMg
ZmxhZw0KPiA+ID4gPiA+IFJhd0h3cFVucmVsaWFibGUgb3IgZm9saW9fdGVzdF9odWdldGxiX3Jh
d19od3BfdW5yZWxpYWJsZSgpLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gTG9va3MgbGlrZSB0aGlz
IHJvdXRpbmUgZG9lcyBub3QgY29uc2lkZXIgdGhhdCBjYXNlLiAgU2VlbXMgbGlrZSBpdCBzaG91
bGQNCj4gPiA+ID4gPiBhbHdheXMgcmV0dXJuIHRoZSBwYXNzZWQgc3VicGFnZSBpZiBmb2xpb190
ZXN0X2h1Z2V0bGJfcmF3X2h3cF91bnJlbGlhYmxlKCkNCj4gPiA+ID4gPiBpcyB0cnVlPw0KPiA+
ID4gPg0KPiA+ID4gPiBUaGFua3MgZm9yIGNhdGNoaW5nIHRoaXMuIEkgd29uZGVyIHNob3VsZCB0
aGlzIHJvdXRpbmUgY29uc2lkZXINCj4gPiA+ID4gUmF3SHdwVW5yZWxpYWJsZSBvciBzaG91bGQg
dGhlIGNhbGxlciBkby4NCj4gPiA+ID4NCj4gPiA+ID4gZmluZF9yYXdfaHdwX3BhZ2Ugbm93IHJl
dHVybnMgcmF3X2h3cF9wYWdlKiBpbiB0aGUgbGxpc3QgZW50cnkgdG8NCj4gPiA+ID4gY2FsbGVy
ICh2YWxpZCBvbmUgYXQgdGhlIG1vbWVudCksIGJ1dCBvbmNlIFJhd0h3cFVucmVsaWFibGUgaXMg
c2V0LA0KPiA+ID4gPiBhbGwgdGhlIHJhd19od3BfcGFnZSBpbiB0aGUgbGxpc3Qgd2lsbCBiZSBr
ZnJlZSgpLCBhbmQgdGhlIHJldHVybmVkDQo+ID4gPiA+IHZhbHVlIGJlY29tZXMgZGFuZ2xpbmcg
cG9pbnRlciB0byBjYWxsZXIgKGlmIHRoZSBjYWxsZXIgaG9sZHMgdGhhdA0KPiA+ID4gPiBjYWxs
ZXIgbG9uZyBlbm91Z2gpLiBNYXliZSByZXR1cm5pbmcgYSBib29sIHdvdWxkIGJlIHNhZmVyIHRv
IHRoZQ0KPiA+ID4gPiBjYWxsZXI/IElmIHRoZSByb3V0aW5lIHJldHVybnMgYm9vbCwgdGhlbiBj
aGVja2luZyBSYXdId3BVbnJlbGlhYmxlDQo+ID4gPiA+IGNhbiBkZWZpbml0ZWx5IGJlIHdpdGhp
biB0aGUgcm91dGluZS4NCj4gPiA+DQo+ID4gPiBJIHRoaW5rIHRoZSBjaGVjayBmb3IgUmF3SHdw
VW5yZWxpYWJsZSBzaG91bGQgYmUgd2l0aGluIHRoaXMgcm91dGluZS4NCj4gPiA+IExvb2tpbmcg
Y2xvc2VyIGF0IHRoZSBjb2RlLCBJIGRvIG5vdCBzZWUgYW55IHdheSB0byBzeW5jaHJvbml6ZSB0
aGlzLg0KPiA+ID4gSXQgbG9va3MgbGlrZSBtYW5pcHVsYXRpb24gaW4gdGhlIG1lbW9yeS1mYWls
dXJlIGNvZGUgd291bGQgYmUNCj4gPiA+IHN5bmNocm9uaXplZCB2aWEgdGhlIG1mX211dGV4LiAg
SG93ZXZlciwgSSBkbyBub3Qgc2VlIGhvdyB0cmF2ZXJzYWwgYW5kDQo+ID4gPiBmcmVlaW5nIG9m
IHRoZSByYXdfaHdwX2xpc3QgIGNhbGxlZCBmcm9tIF9fdXBkYXRlX2FuZF9mcmVlX2h1Z2V0bGJf
Zm9saW8NCj4gPiA+IGlzIHN5bmNocm9uaXplZCBhZ2FpbnN0IG1lbW9yeS1mYWlsdXJlIGNvZGUg
bW9kaWZ5aW5nIHRoZSBsaXN0Lg0KPiA+ID4NCj4gPiA+IE5hb3lhLCBjYW4geW91IHByb3ZpZGUg
c29tZSB0aG91Z2h0cz8NCj4gPg0KPiA+IFRoYW5rcyBmb3IgZWxhYm9yYXRpbmcgdGhlIGlzc3Vl
LiAgSSB0aGluayB0aGF0IG1ha2luZyBmaW5kX3Jhd19od3BfcGFnZSgpIGFuZA0KPiA+IGZvbGlv
X2NsZWFyX2h1Z2V0bGJfaHdwb2lzb24oKSBkbyB0aGVpciB3b3JrcyB3aXRoaW4gbWZfbXV0ZXgg
Y2FuIGJlIG9uZSBzb2x1dGlvbi4NCj4gPiB0cnlfbWVtb3J5X2ZhaWx1cmVfaHVnZXRsYigpLCBv
bmUgb2YgdGhlIGNhbGxlcnMgb2YgZm9saW9fY2xlYXJfaHVnZXRsYl9od3BvaXNvbigpLA0KPiA+
IGFscmVhZHkgY2FsbHMgaXQgd2l0aGluIG1mX211dGV4LCBzbyBzb21lIHdyYXBwZXIgbWlnaHQg
YmUgbmVlZGVkIHRvIGltcGxlbWVudA0KPiA+IGNhbGxpbmcgcGF0aCBmcm9tIF9fdXBkYXRlX2Fu
ZF9mcmVlX2h1Z2V0bGJfZm9saW8oKSB0byB0YWtlIG1mX211dGV4Lg0KPiA+DQo+ID4gSXQgbWln
aHQgYmUgYSBjb25jZXJuIHRoYXQgbWZfbXV0ZXggaXMgYSBiaWcgbG9jayB0byBjb3ZlciBvdmVy
YWxsIGh3cG9pc29uDQo+ID4gc3Vic3lzdGVtLCBidXQgSSB0aGluayB0aGF0IHRoZSBpbXBhY3Qg
aXMgbm90IHNvIGJpZyBpZiB0aGUgY2hhbmdlZCBjb2RlIHBhdGhzDQo+ID4gdGFrZSBtZl9tdXRl
eCBvbmx5IGFmdGVyIGNoZWNraW5nIGh3cG9pc29uZWQgaHVnZXBhZ2UuICBNYXliZSB1c2luZyBm
b2xpb19sb2NrDQo+ID4gdG8gc3luY2hyb25pemUgYWNjZXNzZXMgdG8gdGhlIHJhd19od3BfbGlz
dCBjb3VsZCBiZSBwb3NzaWJsZSwgYnV0IGN1cnJlbnRseQ0KPiA+IF9fZ2V0X2h1Z2VfcGFnZV9m
b3JfaHdwb2lzb24oKSBjYWxscyBmb2xpb19zZXRfaHVnZXRsYl9od3BvaXNvbigpIHdpdGhvdXQN
Cj4gPiBmb2xpb19sb2NrLCBzbyB0aGlzIGFwcHJvYWNoIG5lZWRzIHVwZGF0ZSBvbiBsb2NraW5n
IHJ1bGUgYW5kIGl0IHNvdW5kcyBtb3JlDQo+ID4gZXJyb3ItcHJvbmUgdG8gbWUuDQo+IA0KPiBU
aGFua3MgTmFveWEsIHNpbmNlIG1lbW9yeV9mYWlsdXJlIGlzIHRoZSBtYWluIHVzZXIgb2YgcmF3
X2h3cF9saXN0LCBJDQo+IGFncmVlIG1mX211dGV4IGNvdWxkIGhlbHAgdG8gc3luYyBpdHMgdHdv
IGRlbF9hbGwgb3BlcmF0aW9ucyAob25lIGZyb20NCj4gdHJ5X21lbW9yeV9mYWlsdXJlX2h1Z2V0
bGIgYW5kIG9uZSBmcm9tDQo+IF9fdXBkYXRlX2FuZF9mcmVlX2h1Z2V0bGJfZm9saW8pLg0KPiAN
Cj4gSSBzdGlsbCB3YW50IHRvIGFzayBhIHBlcmhhcHMgc3R1cGlkIHF1ZXN0aW9uLCBzb21ld2hh
dCByZWxhdGVkIHRvIGhvdw0KPiB0byBpbXBsZW1lbnQgZmluZF9yYXdfaHdwX3BhZ2UoKSBjb3Jy
ZWN0bHkuIEl0IHNlZW1zDQo+IGxsaXN0X2Zvcl9lYWNoX3NhZmUgc2hvdWxkIG9ubHkgYmUgdXNl
ZCB0byB0cmF2ZXJzZSBhZnRlciBsaXN0IGVudHJpZXMNCj4gYWxyZWFkeSAqZGVsZXRlZCogdmlh
IGxsaXN0X2RlbF9hbGwuIEJ1dCB0aGUgbGxpc3RfZm9yX2VhY2hfc2FmZSBjYWxscw0KPiBpbiBt
ZW1vcnlfZmFpbHVyZSB0b2RheSBpcyB1c2VkICpkaXJlY3RseSogb24gdGhlIHJhd19od3BfbGlz
dC4gVGhpcw0KPiBpcyBxdWl0ZSBkaWZmZXJlbnQgZnJvbSBvdGhlciB1c2VycyBvZiBsbGlzdF9m
b3JfZWFjaF9zYWZlIChmb3INCj4gZXhhbXBsZSwga2VybmVsL2JwZi9tZW1hbGxvYy5jKS4NCg0K
T2gsIEkgZG9uJ3Qgbm90aWNlZCB0aGF0IHdoZW4gd3JpdGluZyB0aGUgb3JpZ2luYWwgY29kZS4g
KEkganVzdCBjaG9zZQ0KbGxpc3RfZm9yX2VhY2hfc2FmZSBiZWNhdXNlIEkganVzdCB3YW50ZWQg
c3RydWN0IGxsaXN0X25vZGUgYXMgYSBzaW5nbHkNCmxpbmtlZCBsaXN0LikNCg0KPiAgV2h5IGlz
IGl0IGNvcnJlY3Q/IEkgZ3Vlc3MgbW9zdGx5DQo+IGJlY2F1c2UgdGhleSBhcmUgc3luYy1lZCB1
bmRlciBtZl9tdXRleCAoZXhjZXB0IHRoZSBtaXNzaW5nIGNvdmVyYWdlDQo+IG9uIF9fdXBkYXRl
X2FuZF9mcmVlX2h1Z2V0bGJfZm9saW8pPw0KDQpZZXMsIGFuZCB0aGVyZSBzZWVtcyBubyBnb29k
IHJlYXNvbiB0byB1c2UgdGhlIG1hY3JvIGxsaXN0X2Zvcl9lYWNoX3NhZmUNCmhlcmUuICBJIHRo
aW5rIGl0J3MgT0sgdG8gc3dpdGNoIHRvIHNpbXBsZXIgb25lIGxpa2UgbGlzdF9mb3JfZWFjaCB3
aGljaA0Kc2hvdWxkIGJlIHN1cHBvc2VkIHRvIGJlIGNhbGxlZCBkaXJlY3RseS4gIFRvIGRvIHRo
aXMsIHN0cnVjdCByYXdfaHdwX3BhZ2UNCm5lZWQgdG8gaGF2ZSBAbm9kZSAodHlwZWQgc3RydWN0
IGxpc3RfaGVhZCBpbnN0ZWFkIG9mIHN0cnVjdCBsbGlzdF9ub2RlKS4NCg0KVGhhbmtzLA0KTmFv
eWEgSG9yaWd1Y2hp
