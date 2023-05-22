Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8133C70B437
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjEVEuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjEVEuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:50:50 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2085.outbound.protection.outlook.com [40.107.113.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FA9ED
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:50:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWIhNi5a9c4sy++7NKJH2JlUK7IMlMHU5HIYZtwlPbEw8Efx9OyX52TTDIdkPYN1W76m/hyJtrsC0qwJlBCX8GWUaoe5oriy5TTUeebQY1XxYwZBLv2RAfSbpGW6U+kh3zlIQy2Z6sFWxlbsPYWJE9FYivjAPb2fXs2VeWsQ9tB55KmXcgxaMXfpo5MZkocobYbtmTluA8uCdPjw2n7ryx84LpchMGVLik+IxKHbp8hhL1/V+GC2jmiV7GxW1gy89nDDCFerDo/a4X2CTyHMFoBRhq/iokU+haCNzm4Km4bdSyf8CD1b84LGkCK8cJJMQ+2iAh1MUT4v6O5P3iEnng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRXInTr6jqym3vTqmCfUHMiotCtoIXEstKeBiiUmT0c=;
 b=MKyWh9LS6BTA3tMVAVVwjwzNTrfDPpjQE0Xi5woITETw2NXJqv2FiYcHEDyI9erNT9ZsoEs/ZZV59act8IIKQ7l5gYjM2yQsDh+J7WeN9npsXLkZQLJQPtmxHYYHBF/+Cdy5elbBZTbzduOO/RieiT4rLMaa7WSWD+Lj/Vpit6qN3v6mrQTrD9Z2XCrj34eVh2zkSSQrI7qbpPAJhIjAE8l5aEHr3saKFELgwJugyLg7Wk+wu+6eoVbZC016rGwwSUEFb2OgI2Q6e4b2fupySmd2603+uFGQdGmaw/6utqlt22bCvf4OTroxMJpBeUz89vtLHkjzhCiaTDpWNz3ApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRXInTr6jqym3vTqmCfUHMiotCtoIXEstKeBiiUmT0c=;
 b=JjF+lqdHTguhEuEAkliw829qusiwj9F/cfKnhIKvtRkOJ4N6+SevXpsV9oMk2PROpWmohon0gzDq10gem7F8BO/ozV8BDRnv1lJ68s1UIUbmO1P3Q27TfC/5qNrthhJmzzdPMI86HfmDoAVyAcHJnEdry4dSQrR+b+8JgOp9u/Q=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSZPR01MB8797.jpnprd01.prod.outlook.com (2603:1096:604:159::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 04:50:45 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::15c9:309c:d898:c0f5]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::15c9:309c:d898:c0f5%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 04:50:45 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Jiaqi Yan <jiaqiyan@google.com>,
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
Thread-Index: AQHZiNoPwcxOaLRqBUOFhzfdsXoVo69fI8gAgALyqwCAAB4oAIADizyA
Date:   Mon, 22 May 2023 04:50:45 +0000
Message-ID: <20230522044557.GA845371@hori.linux.bs1.fc.nec.co.jp>
References: <20230517160948.811355-1-jiaqiyan@google.com>
 <20230517160948.811355-2-jiaqiyan@google.com> <20230517235314.GB10757@monkey>
 <CACw3F52zNguJ-MvXOAJuMK+JfreLxorvHDPwO8w_gQdOzWj7eA@mail.gmail.com>
 <20230519224214.GB3581@monkey>
In-Reply-To: <20230519224214.GB3581@monkey>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|OSZPR01MB8797:EE_
x-ms-office365-filtering-correlation-id: d620a689-5147-42dd-59b5-08db5a801a96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rPaMl+mGp+Zc+b+qRg5/8m9VkQaByc84QVfvx333WkTbMxHBZzcoNwAvbA0vkQxHznZecnOcR2o5MkVYaf/4eJOQXznOA5Xvwbf/PcxtiAKx9iVNWetWJrr5HqXzYpIU2DxHHQInM9PMp0OmV2ZJKKMZADVyTEhZfOYL0T8WkUTX/5KZmOXvBpj+pH2he3Wf2I8Esk3yjL/I0xQRAvLV4AGJ6ug38/lBRAjNCrU4beP2fB/9afmPvhXg0Tl6YkgpHp7kiv8clSMUZcrMvwB+BoxunA2bX7DBixm/QOL2Hro85bRyHQ4fvmdJZisEGdlQ5Zwo4Z5GiXe1FL/oiRzbeakA1z0ijbWYTh+VZvknMiFbhq06M3UPrs/N0A28NHMILNF5KBHv6kLoRAn/udFk6D/jMOylwrhmEmvjxHU3rWAWpl9cD/kk7YVFnOPePtaSXwHcdd3naYL5UugudSniWtTdsAr2cvHGOmW/p8Ozi3X9JZQoW6zDzHo3sORHrICsL6mDv74SiAq9T+6AAsl9aW5T6H76r1c71+IhTn/X2awaZPhIEoorQ6SRxa8ITD9Lu7HCAspqkwTpKllI1hlaerV40wnjohGOvhyxxGF4qloF/D4F3W8gCBEkUeUabxzb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199021)(38070700005)(122000001)(82960400001)(38100700002)(33656002)(86362001)(85182001)(55236004)(53546011)(9686003)(1076003)(6512007)(6506007)(8676002)(8936002)(7416002)(2906002)(54906003)(478600001)(186003)(64756008)(316002)(4326008)(6916009)(26005)(41300700001)(71200400001)(5660300002)(66446008)(66476007)(6486002)(76116006)(66556008)(66946007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z01PSEw3Y3ZVd1k1SkhnQnVldWxhODdpdDhGY2hmWFdsWTBrWUQ0ZWtaa2xx?=
 =?utf-8?B?bkZ0NFM0VXlSbWtKaUFrS2huSnFpWkNVbEkyYUwrb1ArL3cvSzRFUXZQUXZC?=
 =?utf-8?B?cEdaQkx5L1QyRXpjZlQ4VVM4eXU1UkNEcDhiVkxlMTRqRENxUXR0N1ZWN01o?=
 =?utf-8?B?c29qc29VSFZDMjlhZW81R25ZMDkyWEFoY1U3WWRmV1o2UnR2cXFpY1pJR29J?=
 =?utf-8?B?WlZndDlHYnNVc21qaTNzeWlqYUphd2dJeUNOclhzcU1hZUN0SGlSNzBLOHdG?=
 =?utf-8?B?d20rVllocG9tU3pLKzUzTGFXUzh0VFZFcFRVeHBSSzI0bFhOZFJwTUNwbHh3?=
 =?utf-8?B?UExQOVMwa2ZNcTRHUi9QWmN0bUFNSlR2T1R5QnJEdmpQNHlXb2swQlRPeHFs?=
 =?utf-8?B?NTFJRG5zUkdzdGlDd3ptYzJkUm4xSW5kN1NiNVIwcDB6bFhISHZHT29iN1dz?=
 =?utf-8?B?Z003MHFCUSszdVZSUG1KR3RTR1JMWFErajJJSkhNL3NVUG5qSE9reVJxa3Fi?=
 =?utf-8?B?WjJpb013NFZsb2kxd0R4clF3R1NOMytLRDNYdjRZeGZCbWw0UitZY1QwNlpH?=
 =?utf-8?B?SSt6aUNHNmNObDBBVzIwRUJkQkZxMi9qT1pZc3JiQ2dWRjBVT2o4am00UmtY?=
 =?utf-8?B?aHljL3pyWjJMVXJVUGU3VnoyMzUzeFJrMlZOam9UUzRZQjNOd09mT29iZ1Y4?=
 =?utf-8?B?bFcwaStjbnJUL0pwRmIwTndXTkhMRHYwOUZyRDVmQzQvWVZHaVgzN3VtOXhM?=
 =?utf-8?B?Q1QwWEw1Q2FQbk1XcHZJQmNLOEFDTnRWMTBsVFNSbTF5eURnaWNSanUvZWlr?=
 =?utf-8?B?VVpoWlRWVktXRUY0VnJEaGhHa0JXZVl3dXVmZmJ5MnZNaktvRUJFc08wTjNI?=
 =?utf-8?B?K3FqTHBYWnc3UW9CRE9VRFZGR3VEbmxBdWhqdDF4ZnNQSHU2UFllWnN6ZUZJ?=
 =?utf-8?B?eFk3L2tPRUw1RWtNaG1pTmNOWlQxWFBXUUJhd2tEbTk1Y1hyb2lCZnJHbXBm?=
 =?utf-8?B?QU9ON2JGTVF1aUV4MUo2c0lBNHE0d25ONmxwbXR5eGkvb1NSdVpXREJHU1Ft?=
 =?utf-8?B?aHhDVjJLNFZaQlJiT21EODJ3ZTRsU3VGVHpKQmRlQ0M2eWlGeE0vY0p0MHZy?=
 =?utf-8?B?TDhqRGgzbE5jV0FIVEtJOXJnWDNBa082ak42NDlLVHFKN3NzOWxJVDlPSkFY?=
 =?utf-8?B?OStkSE9DZWlTNmN4S0Y5bG9hTEFaUE1Ca0F5NUVXckZEbmVJK1o2WmtMdVAx?=
 =?utf-8?B?MmFGRmZvcCtJWmJKU3EzM09qb2oxMjhXcWs0M05FZm1mYXRaK0ltcC8xRy9p?=
 =?utf-8?B?cEFCT29MN0hXdXRqL0tGRmFVWlcyM1gwVTdGRFhTc3BlQVZOWnMxZFVoeXh0?=
 =?utf-8?B?UkNDTUljVWJkU2JhVnYrZFRaTUR6anlpa2RQSVVUcndYMnRvemEzTWlBbzh5?=
 =?utf-8?B?aWJpWGRHL3RrS0xidnpRMWRzSnBURG9CaWZhWnJoYWtPbFdxdjd6WHNtS0hy?=
 =?utf-8?B?M29UYlpEd0xzeEthT0psTzN6VXNvQlh0TksyazJQekhzQVdQWXhHZS8yR2la?=
 =?utf-8?B?S0o4bmNVUzJsZjAwelJ4ZlRoaHVyUW1nbFNNMkNZVzJZVXd1Nkd0TnY4cU1p?=
 =?utf-8?B?bE1jVXEzZ0pkRkx0Qzl4VXRjWmp4c1dQWVUrekJnRWpldlZQOWovb1c5eUow?=
 =?utf-8?B?eVFGeDQ3YTJBZVE5YUdPaHE2VXVPdmVVeVFkaWs4bmI5c05sS0lGdnQ1VEM3?=
 =?utf-8?B?b0ZLMEtoRDlSR1E4NDJnT1BaOWQwMzhkYThtTTRoNGFiM1JlVVZSVDZwY1Vh?=
 =?utf-8?B?d0ZqMm5LQTRsdnhRWUpOVVhoUExNajJDZWU4VXRPUUVHVFUvOHk1aDBzcGlS?=
 =?utf-8?B?VzkrbUdIVFBoQjBFTVoyNzRyUFJ0ZU9EMjdBd1A0Q2tzRUZPbUdZYXROVEhR?=
 =?utf-8?B?SnFKQVI3YTlPVDFiSWFMUjA4QlNWK25wYVpRUWMyaVlzTk5ZekRGSmRiUEJy?=
 =?utf-8?B?cWEzK0FBcERZUm43cmdZcUcwTUU2VnRiRmVLclViVDRTV3FjeHpzUG92a01j?=
 =?utf-8?B?aDgyRDVYTlZOOHRmTmpqeWNyN3J0WmtPSXdJZEFrSEJqY1drT05mWkd6SStu?=
 =?utf-8?B?aGVORkZTUTdCKzMwckxXS3JsRWVkZDQ4WDdxMVR0RFFDTDB0QzArV3NrdEsv?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68F5A4231FE86B4284E0D3D6210BE49C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d620a689-5147-42dd-59b5-08db5a801a96
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 04:50:45.1108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: phjiMf37sweAskWOq1JLkJEl7lmcgbc3XGGJfCvUZrQZYm3VjuWo0u1S6SO+Iqs3hxCX8F2F6sJ9x8xdaJk7PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8797
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXkgMTksIDIwMjMgYXQgMDM6NDI6MTRQTSAtMDcwMCwgTWlrZSBLcmF2ZXR6IHdy
b3RlOg0KPiBPbiAwNS8xOS8yMyAxMzo1NCwgSmlhcWkgWWFuIHdyb3RlOg0KPiA+IE9uIFdlZCwg
TWF5IDE3LCAyMDIzIGF0IDQ6NTPigK9QTSBNaWtlIEtyYXZldHogPG1pa2Uua3JhdmV0ekBvcmFj
bGUuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBPbiAwNS8xNy8yMyAxNjowOSwgSmlhcWkgWWFu
IHdyb3RlOg0KPiA+ID4gPiBBZGRzIHRoZSBmdW5jdGlvbmFsaXR5IHRvIHNlYXJjaCBhIHN1YnBh
Z2UncyBjb3JyZXNwb25kaW5nIHJhd19od3BfcGFnZQ0KPiA+ID4gPiBpbiBodWdldGxiIHBhZ2Un
cyBIV1BPSVNPTiBsaXN0LiBUaGlzIGZ1bmN0aW9uYWxpdHkgY2FuIGFsc28gdGVsbCBpZiBhDQo+
ID4gPiA+IHN1YnBhZ2UgaXMgYSByYXcgSFdQT0lTT04gcGFnZS4NCj4gPiA+ID4NCj4gPiA+ID4g
RXhwb3J0cyB0aGlzIGZ1bmN0aW9uYWxpdHkgdG8gYmUgaW1tZWRpYXRlbHkgdXNlZCBpbiB0aGUg
cmVhZCBvcGVyYXRpb24NCj4gPiA+ID4gZm9yIGh1Z2V0bGJmcy4NCj4gPiA+ID4NCj4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogSmlhcWkgWWFuIDxqaWFxaXlhbkBnb29nbGUuY29tPg0KPiA+ID4gPiAt
LS0NCj4gPiA+ID4gIGluY2x1ZGUvbGludXgvbW0uaCAgfCAyMyArKysrKysrKysrKysrKysrKysr
KysrKw0KPiA+ID4gPiAgbW0vbWVtb3J5LWZhaWx1cmUuYyB8IDI2ICsrKysrKysrKysrKysrKyst
LS0tLS0tLS0tDQo+ID4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDEw
IGRlbGV0aW9ucygtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9tbS5oIGIvaW5jbHVkZS9saW51eC9tbS5oDQo+ID4gPiA+IGluZGV4IDI3Y2U3NzA4MGM3OS4u
ZjE5MWE0MTE5NzE5IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21tLmgNCj4g
PiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC9tbS5oDQo+ID4gPg0KPiA+ID4gQW55IHJlYXNvbiB3
aHkgeW91IGRlY2lkZWQgdG8gYWRkIHRoZSBmb2xsb3dpbmcgdG8gbGludXgvbW0uaCBpbnN0ZWFk
IG9mDQo+ID4gPiBsaW51eC9odWdldGxiLmg/ICBTaW5jZSBpdCBpcyBodWdldGxiIHNwZWNpZmlj
IEkgd291bGQgaGF2ZSB0aG91Z2h0DQo+ID4gPiBodWdldGxiLmggd2FzIG1vcmUgYXBwcm9wcmlh
dGUuDQo+ID4gPg0KPiA+ID4gPiBAQCAtMzY4Myw2ICszNjgzLDI5IEBAIGVudW0gbWZfYWN0aW9u
X3BhZ2VfdHlwZSB7DQo+ID4gPiA+ICAgKi8NCj4gPiA+ID4gIGV4dGVybiBjb25zdCBzdHJ1Y3Qg
YXR0cmlidXRlX2dyb3VwIG1lbW9yeV9mYWlsdXJlX2F0dHJfZ3JvdXA7DQo+ID4gPiA+DQo+ID4g
PiA+ICsjaWZkZWYgQ09ORklHX0hVR0VUTEJfUEFHRQ0KPiA+ID4gPiArLyoNCj4gPiA+ID4gKyAq
IFN0cnVjdCByYXdfaHdwX3BhZ2UgcmVwcmVzZW50cyBpbmZvcm1hdGlvbiBhYm91dCAicmF3IGVy
cm9yIHBhZ2UiLA0KPiA+ID4gPiArICogY29uc3RydWN0aW5nIHNpbmdseSBsaW5rZWQgbGlzdCBm
cm9tIC0+X2h1Z2V0bGJfaHdwb2lzb24gZmllbGQgb2YgZm9saW8uDQo+ID4gPiA+ICsgKi8NCj4g
PiA+ID4gK3N0cnVjdCByYXdfaHdwX3BhZ2Ugew0KPiA+ID4gPiArICAgICBzdHJ1Y3QgbGxpc3Rf
bm9kZSBub2RlOw0KPiA+ID4gPiArICAgICBzdHJ1Y3QgcGFnZSAqcGFnZTsNCj4gPiA+ID4gK307
DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyBpbmxpbmUgc3RydWN0IGxsaXN0X2hlYWQgKnJh
d19od3BfbGlzdF9oZWFkKHN0cnVjdCBmb2xpbyAqZm9saW8pDQo+ID4gPiA+ICt7DQo+ID4gPiA+
ICsgICAgIHJldHVybiAoc3RydWN0IGxsaXN0X2hlYWQgKikmZm9saW8tPl9odWdldGxiX2h3cG9p
c29uOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICsvKg0KPiA+ID4gPiArICogR2l2
ZW4gQHN1YnBhZ2UsIGEgcmF3IHBhZ2UgaW4gYSBodWdlcGFnZSwgZmluZCBpdHMgbG9jYXRpb24g
aW4gQGZvbGlvJ3MNCj4gPiA+ID4gKyAqIF9odWdldGxiX2h3cG9pc29uIGxpc3QuIFJldHVybiBO
VUxMIGlmIEBzdWJwYWdlIGlzIG5vdCBpbiB0aGUgbGlzdC4NCj4gPiA+ID4gKyAqLw0KPiA+ID4g
PiArc3RydWN0IHJhd19od3BfcGFnZSAqZmluZF9yYXdfaHdwX3BhZ2Uoc3RydWN0IGZvbGlvICpm
b2xpbywNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCBwYWdlICpzdWJwYWdlKTsNCj4gPiA+ID4gKyNlbmRpZg0KPiA+ID4gPiArDQo+ID4gPiA+ICAj
aWYgZGVmaW5lZChDT05GSUdfVFJBTlNQQVJFTlRfSFVHRVBBR0UpIHx8IGRlZmluZWQoQ09ORklH
X0hVR0VUTEJGUykNCj4gPiA+ID4gIGV4dGVybiB2b2lkIGNsZWFyX2h1Z2VfcGFnZShzdHJ1Y3Qg
cGFnZSAqcGFnZSwNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBs
b25nIGFkZHJfaGludCwNCj4gPiA+ID4gZGlmZiAtLWdpdCBhL21tL21lbW9yeS1mYWlsdXJlLmMg
Yi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ID4gPiA+IGluZGV4IDViNjYzZWNhMWYyOS4uYzQ5ZTZj
MmQxZjA3IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ID4gPiA+
ICsrKyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gPiA+ID4gQEAgLTE4MTgsMTggKzE4MTgsMjQg
QEAgRVhQT1JUX1NZTUJPTF9HUEwobWZfZGF4X2tpbGxfcHJvY3MpOw0KPiA+ID4gPiAgI2VuZGlm
IC8qIENPTkZJR19GU19EQVggKi8NCj4gPiA+ID4NCj4gPiA+ID4gICNpZmRlZiBDT05GSUdfSFVH
RVRMQl9QQUdFDQo+ID4gPiA+IC0vKg0KPiA+ID4gPiAtICogU3RydWN0IHJhd19od3BfcGFnZSBy
ZXByZXNlbnRzIGluZm9ybWF0aW9uIGFib3V0ICJyYXcgZXJyb3IgcGFnZSIsDQo+ID4gPiA+IC0g
KiBjb25zdHJ1Y3Rpbmcgc2luZ2x5IGxpbmtlZCBsaXN0IGZyb20gLT5faHVnZXRsYl9od3BvaXNv
biBmaWVsZCBvZiBmb2xpby4NCj4gPiA+ID4gLSAqLw0KPiA+ID4gPiAtc3RydWN0IHJhd19od3Bf
cGFnZSB7DQo+ID4gPiA+IC0gICAgIHN0cnVjdCBsbGlzdF9ub2RlIG5vZGU7DQo+ID4gPiA+IC0g
ICAgIHN0cnVjdCBwYWdlICpwYWdlOw0KPiA+ID4gPiAtfTsNCj4gPiA+ID4NCj4gPiA+ID4gLXN0
YXRpYyBpbmxpbmUgc3RydWN0IGxsaXN0X2hlYWQgKnJhd19od3BfbGlzdF9oZWFkKHN0cnVjdCBm
b2xpbyAqZm9saW8pDQo+ID4gPiA+ICtzdHJ1Y3QgcmF3X2h3cF9wYWdlICpmaW5kX3Jhd19od3Bf
cGFnZShzdHJ1Y3QgZm9saW8gKmZvbGlvLA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3RydWN0IHBhZ2UgKnN1YnBhZ2UpDQo+ID4gPiA+ICB7DQo+ID4gPiA+
IC0gICAgIHJldHVybiAoc3RydWN0IGxsaXN0X2hlYWQgKikmZm9saW8tPl9odWdldGxiX2h3cG9p
c29uOw0KPiA+ID4gPiArICAgICBzdHJ1Y3QgbGxpc3Rfbm9kZSAqdCwgKnRub2RlOw0KPiA+ID4g
PiArICAgICBzdHJ1Y3QgbGxpc3RfaGVhZCAqcmF3X2h3cF9oZWFkID0gcmF3X2h3cF9saXN0X2hl
YWQoZm9saW8pOw0KPiA+ID4gPiArICAgICBzdHJ1Y3QgcmF3X2h3cF9wYWdlICpod3BfcGFnZSA9
IE5VTEw7DQo+ID4gPiA+ICsgICAgIHN0cnVjdCByYXdfaHdwX3BhZ2UgKnA7DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKyAgICAgbGxpc3RfZm9yX2VhY2hfc2FmZSh0bm9kZSwgdCwgcmF3X2h3cF9oZWFk
LT5maXJzdCkgew0KPiA+ID4NCj4gPiA+IElJVUMsIGluIHJhcmUgZXJyb3IgY2FzZXMgYSBodWdl
dGxiIHBhZ2UgY2FuIGJlIHBvaXNvbmVkIFdJVEhPVVQgYQ0KPiA+ID4gcmF3X2h3cF9saXN0LiAg
VGhpcyBpcyBpbmRpY2F0ZWQgYnkgdGhlIGh1Z2V0bGIgcGFnZSBzcGVjaWZpYyBmbGFnDQo+ID4g
PiBSYXdId3BVbnJlbGlhYmxlIG9yIGZvbGlvX3Rlc3RfaHVnZXRsYl9yYXdfaHdwX3VucmVsaWFi
bGUoKS4NCj4gPiA+DQo+ID4gPiBMb29rcyBsaWtlIHRoaXMgcm91dGluZSBkb2VzIG5vdCBjb25z
aWRlciB0aGF0IGNhc2UuICBTZWVtcyBsaWtlIGl0IHNob3VsZA0KPiA+ID4gYWx3YXlzIHJldHVy
biB0aGUgcGFzc2VkIHN1YnBhZ2UgaWYgZm9saW9fdGVzdF9odWdldGxiX3Jhd19od3BfdW5yZWxp
YWJsZSgpDQo+ID4gPiBpcyB0cnVlPw0KPiA+IA0KPiA+IFRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhp
cy4gSSB3b25kZXIgc2hvdWxkIHRoaXMgcm91dGluZSBjb25zaWRlcg0KPiA+IFJhd0h3cFVucmVs
aWFibGUgb3Igc2hvdWxkIHRoZSBjYWxsZXIgZG8uDQo+ID4gDQo+ID4gZmluZF9yYXdfaHdwX3Bh
Z2Ugbm93IHJldHVybnMgcmF3X2h3cF9wYWdlKiBpbiB0aGUgbGxpc3QgZW50cnkgdG8NCj4gPiBj
YWxsZXIgKHZhbGlkIG9uZSBhdCB0aGUgbW9tZW50KSwgYnV0IG9uY2UgUmF3SHdwVW5yZWxpYWJs
ZSBpcyBzZXQsDQo+ID4gYWxsIHRoZSByYXdfaHdwX3BhZ2UgaW4gdGhlIGxsaXN0IHdpbGwgYmUg
a2ZyZWUoKSwgYW5kIHRoZSByZXR1cm5lZA0KPiA+IHZhbHVlIGJlY29tZXMgZGFuZ2xpbmcgcG9p
bnRlciB0byBjYWxsZXIgKGlmIHRoZSBjYWxsZXIgaG9sZHMgdGhhdA0KPiA+IGNhbGxlciBsb25n
IGVub3VnaCkuIE1heWJlIHJldHVybmluZyBhIGJvb2wgd291bGQgYmUgc2FmZXIgdG8gdGhlDQo+
ID4gY2FsbGVyPyBJZiB0aGUgcm91dGluZSByZXR1cm5zIGJvb2wsIHRoZW4gY2hlY2tpbmcgUmF3
SHdwVW5yZWxpYWJsZQ0KPiA+IGNhbiBkZWZpbml0ZWx5IGJlIHdpdGhpbiB0aGUgcm91dGluZS4N
Cj4gDQo+IEkgdGhpbmsgdGhlIGNoZWNrIGZvciBSYXdId3BVbnJlbGlhYmxlIHNob3VsZCBiZSB3
aXRoaW4gdGhpcyByb3V0aW5lLg0KPiBMb29raW5nIGNsb3NlciBhdCB0aGUgY29kZSwgSSBkbyBu
b3Qgc2VlIGFueSB3YXkgdG8gc3luY2hyb25pemUgdGhpcy4NCj4gSXQgbG9va3MgbGlrZSBtYW5p
cHVsYXRpb24gaW4gdGhlIG1lbW9yeS1mYWlsdXJlIGNvZGUgd291bGQgYmUNCj4gc3luY2hyb25p
emVkIHZpYSB0aGUgbWZfbXV0ZXguICBIb3dldmVyLCBJIGRvIG5vdCBzZWUgaG93IHRyYXZlcnNh
bCBhbmQNCj4gZnJlZWluZyBvZiB0aGUgcmF3X2h3cF9saXN0ICBjYWxsZWQgZnJvbSBfX3VwZGF0
ZV9hbmRfZnJlZV9odWdldGxiX2ZvbGlvDQo+IGlzIHN5bmNocm9uaXplZCBhZ2FpbnN0IG1lbW9y
eS1mYWlsdXJlIGNvZGUgbW9kaWZ5aW5nIHRoZSBsaXN0Lg0KPiANCj4gTmFveWEsIGNhbiB5b3Ug
cHJvdmlkZSBzb21lIHRob3VnaHRzPw0KDQpUaGFua3MgZm9yIGVsYWJvcmF0aW5nIHRoZSBpc3N1
ZS4gIEkgdGhpbmsgdGhhdCBtYWtpbmcgZmluZF9yYXdfaHdwX3BhZ2UoKSBhbmQNCmZvbGlvX2Ns
ZWFyX2h1Z2V0bGJfaHdwb2lzb24oKSBkbyB0aGVpciB3b3JrcyB3aXRoaW4gbWZfbXV0ZXggY2Fu
IGJlIG9uZSBzb2x1dGlvbi4NCnRyeV9tZW1vcnlfZmFpbHVyZV9odWdldGxiKCksIG9uZSBvZiB0
aGUgY2FsbGVycyBvZiBmb2xpb19jbGVhcl9odWdldGxiX2h3cG9pc29uKCksDQphbHJlYWR5IGNh
bGxzIGl0IHdpdGhpbiBtZl9tdXRleCwgc28gc29tZSB3cmFwcGVyIG1pZ2h0IGJlIG5lZWRlZCB0
byBpbXBsZW1lbnQNCmNhbGxpbmcgcGF0aCBmcm9tIF9fdXBkYXRlX2FuZF9mcmVlX2h1Z2V0bGJf
Zm9saW8oKSB0byB0YWtlIG1mX211dGV4Lg0KDQpJdCBtaWdodCBiZSBhIGNvbmNlcm4gdGhhdCBt
Zl9tdXRleCBpcyBhIGJpZyBsb2NrIHRvIGNvdmVyIG92ZXJhbGwgaHdwb2lzb24NCnN1YnN5c3Rl
bSwgYnV0IEkgdGhpbmsgdGhhdCB0aGUgaW1wYWN0IGlzIG5vdCBzbyBiaWcgaWYgdGhlIGNoYW5n
ZWQgY29kZSBwYXRocw0KdGFrZSBtZl9tdXRleCBvbmx5IGFmdGVyIGNoZWNraW5nIGh3cG9pc29u
ZWQgaHVnZXBhZ2UuICBNYXliZSB1c2luZyBmb2xpb19sb2NrDQp0byBzeW5jaHJvbml6ZSBhY2Nl
c3NlcyB0byB0aGUgcmF3X2h3cF9saXN0IGNvdWxkIGJlIHBvc3NpYmxlLCBidXQgY3VycmVudGx5
DQpfX2dldF9odWdlX3BhZ2VfZm9yX2h3cG9pc29uKCkgY2FsbHMgZm9saW9fc2V0X2h1Z2V0bGJf
aHdwb2lzb24oKSB3aXRob3V0DQpmb2xpb19sb2NrLCBzbyB0aGlzIGFwcHJvYWNoIG5lZWRzIHVw
ZGF0ZSBvbiBsb2NraW5nIHJ1bGUgYW5kIGl0IHNvdW5kcyBtb3JlDQplcnJvci1wcm9uZSB0byBt
ZS4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hpDQoNCj4gDQo+ID4gDQo+ID4gQW5vdGhlciBv
cHRpb24gaXMsIHRoaXMgcm91dGluZSBzaW1wbHkgZG9lc24gb25lIHRoaW5nOiBmaW5kIGENCj4g
PiByYXdfaHdwX3BhZ2UgaW4gcmF3X2h3cF9saXN0IGZvciBhIHN1YnBhZ2UuIEJ1dCB0aGUgY2Fs
bGVyIG5lZWRzIHRvIDEpDQo+ID4gdGVzdCBSYXdId3BVbnJlbGlhYmxlIGJlZm9yZSBjYWxscyBp
bnRvIHRoZSByb3V0aW5lLCBhbmQgMikgdGVzdA0KPiA+IFJhd0h3cFVucmVsaWFibGUgYmVmb3Jl
IGFjY2VzcyByZXR1cm5lZCByYXdfaHdwX3BhZ2UqLiBJIHRoaW5rIDJuZA0KPiA+IG9wdGlvbiB3
aWxsIGJlIGVycm9yLXByb25lIGFuZCB0aGUgMXN0IG9wdGlvbiBpcyBhIGJldHRlciBvbmUuDQo+
ID4gDQo+ID4gTWF5YmUgSSBhbSBvdmVyLXRoaW5raW5nLiBXaGF0IGRvIHlvdSB0aGluaz8NCj4g
DQo+IEkgdGhpbmsgcmFjaW5nIGNvZGUgYWNjZXNzaW5nIHRoZSByYXdfaHdwX2xpc3QgaXMgdmVy
eSB1bmxpa2VseS4NCj4gSG93ZXZlciwgaXQgaXMgcG9zc2libGUgYW5kIHNob3VsZCBiZSBjb25z
aWRlcmVkLg0KPiAtLSANCj4gTWlrZSBLcmF2ZXR6DQo+IA0KPiA+IA0KPiA+ID4gLS0NCj4gPiA+
IE1pa2UgS3JhdmV0eg0KPiA+ID4NCj4gPiA+ID4gKyAgICAgICAgICAgICBwID0gY29udGFpbmVy
X29mKHRub2RlLCBzdHJ1Y3QgcmF3X2h3cF9wYWdlLCBub2RlKTsNCj4gPiA+ID4gKyAgICAgICAg
ICAgICBpZiAoc3VicGFnZSA9PSBwLT5wYWdlKSB7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICBod3BfcGFnZSA9IHA7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBicmVhazsN
Cj4gPiA+ID4gKyAgICAgICAgICAgICB9DQo+ID4gPiA+ICsgICAgIH0NCj4gPiA+ID4gKw0KPiA+
ID4gPiArICAgICByZXR1cm4gaHdwX3BhZ2U7DQo+ID4gPiA+ICB9DQo+ID4gPiA+DQo+ID4gPiA+
ICBzdGF0aWMgdW5zaWduZWQgbG9uZyBfX2ZvbGlvX2ZyZWVfcmF3X2h3cChzdHJ1Y3QgZm9saW8g
KmZvbGlvLCBib29sIG1vdmVfZmxhZykNCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi40MC4xLjYwNi5n
YTRiMWIxMjhkNi1nb29nDQo+ID4gPiA+
