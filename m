Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CC661E7B7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 00:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiKFXwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 18:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKFXwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 18:52:46 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2087.outbound.protection.outlook.com [40.107.113.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA60EDEDB
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 15:52:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9BKp1IKa4uEbnr/1+1NPqZ4khTKZ0OD2FBmFak0nUbkaQyk3vZ87tCqBzV6UZR3i4EwJ+DlbLZ2LJg/62FJBXxpkJtvvhwachaHevvqOyxHKKYtODnfkH3WSpWZ9WV71C6slOz56VnUIcOM7VhnwwV4z+DvQBJe266582aqIrsK0WcqcS8Nm3VwrEZf8SG6YVJu2JtYcbnHuScsSK5KRfBQQMAR+bE7g6CrYjHNbSxK6J/nAOA8JtZbKuy45pv+7i1llKUNzzLyc4moA4RJO9/k+3dlnE9NIM+sV/v46uiACkkorpunyDzzeXjrNhgybSSf/X9nzIQfk+bCuy2mTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckf8N9nm0I8vxSxjZmpb5refvxhD5kSDms+5ZhO8TfM=;
 b=an1LQLtt99gDfLj0zLMY1pUS1esSBIkyuAv+a5PA/wlyeP9foKaHkiwAUKC9l57PuBRgKowm4vBbJ3JJu7aCCo9C+9KhjVR+EAnTF4kDKMX+gzXxC6362XLIVIwGD19tAYmwpiJc5t42eLJ/44DT1yfl8lYQ+JUDyW3VV5ZAw8bnwhxhqsEnPEekxByEOy57R8l0iyhzRV8yllP/pXv/4Hdw/gzeOjM+y7+amaMWHC095Na5fPyPNxxTopjPT/yXTi4xtQ2v5cR6PWgCAr+hmF8rP/5PtyBsdQ+flA2CniKKCvLkTH8ccUK1KHv7SFcWdBCq46kJsTx4LxnH9uCSRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckf8N9nm0I8vxSxjZmpb5refvxhD5kSDms+5ZhO8TfM=;
 b=Pln+wVXPJ11gO4/m6yWCJPy3kFZ+odm66dpuBSLdfaEWGKsfIibb8VZ2xlnQ/4CYkTY3xj7HMoUbHVbXQpaJJFnAj1X7JJZO4rdhWn8ExetnyceGa3e7s2+ShGexS7KvZHZJL0qV3VzURaLTxlasNH5qA6TKvNHTy0R8GXyDZlY=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS3PR01MB5800.jpnprd01.prod.outlook.com (2603:1096:604:b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Sun, 6 Nov
 2022 23:52:19 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c%9]) with mapi id 15.20.5791.026; Sun, 6 Nov 2022
 23:52:19 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     =?utf-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [mm-unstable PATCH v7 2/8] mm/hugetlb: make pud_huge() and
 follow_huge_pud() aware of non-present pud entry
Thread-Topic: [mm-unstable PATCH v7 2/8] mm/hugetlb: make pud_huge() and
 follow_huge_pud() aware of non-present pud entry
Thread-Index: AQHY7v0BMOBmDc4G4EGu54WgnA9+dK4u7t4AgABrVgCAAz1qAA==
Date:   Sun, 6 Nov 2022 23:52:19 +0000
Message-ID: <20221106235216.GA426682@hori.linux.bs1.fc.nec.co.jp>
References: <Y2LYXItKQyaJTv8j@intel.com>
 <20221104155930.GA527246@ik1-406-35019.vs.sakura.ne.jp>
 <Y2WQ7I4LXh8iUIRd@intel.com>
In-Reply-To: <Y2WQ7I4LXh8iUIRd@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|OS3PR01MB5800:EE_
x-ms-office365-filtering-correlation-id: f7ed0afb-d329-4d29-c7f0-08dac051f10a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PW4QKwjXl/PNumFI46X3Vv2VIoD0qU66uAvQC0dviT6LN1lu+Don8VlVyYBZ289JZracCK/goSWcy33+vvm+E0AXMw6CcLgRtrGsQt/HxVfqHvcuOeadEIs9nKxlVi4PGAl1By2PHrcah1ewCwteOICtXCdlXuodfFOWeo5C9MUvb8Wv061iHxOOG823M3uEZHQNSVSHPlgGoPxSgrddxAwmfMMTnT8jbuXwxHQk3P2ul6uXtlTy5dNbG1RMGrTvzYoVls97bZtPvXckjzwZjs3+HXDxEtwMJwz2u2EOr1TjYQ6FNLprcMViXjJoHmfAWqU7KLV/5m9BwLLIuSiwaOLA3S6lkKMEq/3xoAqedd/3hFfAEmOdPYGmm/uq1h1XzxRcHB9JYBORJTcnMCTL1YPuGCx/P55XHPF+dw4Vch3ry0dR1H/U1gJh9tUFlo5A2ZIlgkRdDPwkV8rymHX1o3s8EuYxh3/dNFyJXqCvO3HZ1hGI+6id0Fz4+WhOi+ZOB0VYGYWDj4rzEjim5OnCvqkIW+kxvhOA3aZlUvEpyv5XqjIn0aA0JPOb3BhnSbCA1UUFpc43Sr9Ie3jdkIge+L4+4TG/YIX/lr3rKp9JayLwOuTY+HbGwE7SGxg6+UzzWYZDc/Efp0tT0Pw5vzUzn5+ULt/ivd0Ee1G1iqieEc3LQmF2GThqMBs6HHtZL1+6jG9lReGN5Tx1jVAcvgNBsdT+adSwNE8Yui1x1ZvgwP1nU6kIErXBSvHlFp3RtLN2Lf+LzmimgwCiYiOPzslG8aURfiKSADYeIcTyb0u+E3w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199015)(6512007)(26005)(9686003)(6506007)(5660300002)(82960400001)(7416002)(478600001)(316002)(54906003)(6916009)(2906002)(122000001)(86362001)(71200400001)(6486002)(38100700002)(8936002)(33656002)(41300700001)(85182001)(83380400001)(1076003)(4326008)(76116006)(66574015)(8676002)(38070700005)(186003)(64756008)(66446008)(66946007)(66556008)(66476007)(14583001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXRQTjlrM2xCajE5R0YzTTJGT3p1UzNQSjJ5WUNFb29PZyt0NW9kYTROWUQv?=
 =?utf-8?B?dnJEQ24xZWR0ajBPWXJwUlhKNWpvWnNsQmtiZkdQRjNaQW93UzNrWnRuc2hK?=
 =?utf-8?B?Y0J6ajU4VEMyK0owRXlrK3RjeWZCWlVJVlhPQWk4bE51akJOVS93TzJHWFVO?=
 =?utf-8?B?KzVjR1QrUE1jRnNqaklDMmhxVUpvNEZEUWdwSnpEaDlvZlZ0MkNaSFVyTXFX?=
 =?utf-8?B?MC9XMmlTWFFrZTJaeDdjbzlZQmxXbDlOTGRsNzQ5ampPUUlmTkhQMldUUkMy?=
 =?utf-8?B?dU9qbEN4MjFnQjAvR1BkWHlMRjBIbVhsUGkyM2k1eTB3Z3lHa3dobE5pMjJG?=
 =?utf-8?B?c2dKQlhOaXlxcmo0bks4cmpDODJHWndVaEZSR1h5QW5PMXQxU3h6c25mdEsr?=
 =?utf-8?B?ZXVZS3JaSnk5emQzRTNYTWt4ZmpJQ0M1MzVJVkJJWmMydUpNRnV5dUZLQWRP?=
 =?utf-8?B?L3dvaHVSbnRrZVg5ckx6NHpGYkkwUmtEQkNvZHE5WStmYm1uNGFpdzkrSUF3?=
 =?utf-8?B?UndUUm40TzlzekZ2enBScEpNZFVUdU5vd1RscjgvcHpWYkZ5TzJqdnY4Yk9i?=
 =?utf-8?B?Wmg3WStqWHJiMUVBMllWV29odHZVc3duV3NTMG5tQXp4amFkKy9abkFjODdu?=
 =?utf-8?B?Y041L0FPeDIxUTBSS3luYktVN0Q2MVVoaGtsTzMxMTBEWTJOcnlPcVVTWE1r?=
 =?utf-8?B?QjJYc0ROcUZlZ0N0VnRFMkROaWJpOWo2T2JobVovNEsrajdhNEVXcXRnVFc5?=
 =?utf-8?B?bU9yV1BYM0xxbnlNQUFVcldZdUZaejRnRUNvUHBWVUdaQUU0bVJPQmMxeUJq?=
 =?utf-8?B?ajh3UnY3ak9PU0U2WldONzk5aFQwTlVCaHJwV3lTdTJCQVpxOUFnOEJDRlBH?=
 =?utf-8?B?NFBGUXJJY1lSODlXNVV0T1o3R0dYY0tzU21PczFLU1YrL0daN3piSG53RW0x?=
 =?utf-8?B?MzdJYkxCbkJ2Q3lrTjRRM3NvKzl6RHNuNk42WmNOQ3BxZE9uS2Z2dEFVUU5p?=
 =?utf-8?B?bGw4Z1ljRmxSUlg3dDRNZFl2YmxabldvbnE5Tk03SGh4UXo3d3VieVk0R09P?=
 =?utf-8?B?Z01mY0lyRk1LRjhnWkJzTWNhSGdlNmFyQ1gvbmloaGZyVzBqazRPazFRZkx0?=
 =?utf-8?B?dENnOFd6VS9XTk43QXBoWGRmK29YQzd4VVhGRzhIaHRmbjIyQSthQmpPM0Fw?=
 =?utf-8?B?Z0FSVFNmYWJHV0NJQ2h6Y3NuMHg0M2phaUFsZEZkdlNqNzJHaFRFVWpFWlpG?=
 =?utf-8?B?NHNiUFJhbXgwTjBxTHZHaUFCRVhvVEtJQXJFMzhDcEltN0dETTNiMi8rYlR5?=
 =?utf-8?B?QUVkSHV0ZjZPd2FORE1iSnhZSWhuZHFEUW9ZTXQ3YlZJb2d6c2owdTdPOFh2?=
 =?utf-8?B?Q2hQdTBoQVEwQktSSDNlNnE1TGh2ZDN2WVNXRFB0djBVMUFMN0s3aEFXQ3Vx?=
 =?utf-8?B?M0xvd29wKy92TlRuWS9TMnNDWml3NUJFelJJZWFERCtyMjFRZm5MNFIrTU5q?=
 =?utf-8?B?dHB1NmxOMjQ0NmR1WnE5c00vU0NtNUhMOWQ2MDF5ckVmazU3OURZbUhKRFM2?=
 =?utf-8?B?czJUU05JdmVtblhjaDE2YkdGYjRMSFR6ZUVmU3hzdmpDZkNRbHFPNGtWMllL?=
 =?utf-8?B?UDlNT3ZGSkhDS1Vmc1VYWUJHMHhHM20zdjAvTU9aZGFaQ1AvbjFnbXRUTE1x?=
 =?utf-8?B?cWZtb21DYkhETjU0bWZ3bUtFMnE4YlhGcExSc0duVE10QTU5YjlXS2NublJH?=
 =?utf-8?B?ZncxNlJYVXA3dzY5K0l2TEdHN213YW12Z09Da1RlOTkraDdWRzRUbms3WUJ3?=
 =?utf-8?B?SjlrWkpNZ0dlTUVNUUREL0FGVmsvcVU1emVUdlF4R2JsWHhSTnBJR1pPNXE2?=
 =?utf-8?B?VVNHa0pvNDhaM0srTTRiNUVGNXZCNU5SanFQbzdsZk1FMGVTSS9zS1hXTStk?=
 =?utf-8?B?NnY1cE5IWVBlQUlxN1dBa1dHeVJZNFpNRmhCc0txYzdCVGQ3Y3gwRnhkQ2Rw?=
 =?utf-8?B?WCtVNHZPbFRpcW1KWHI4V0FNOW1sREpBN2RpMURwS3JuNnl4N0Z3V0xMRHBK?=
 =?utf-8?B?QjJHMVcwUU5ycnJ0eC92eWhaVWlNak9nOXptTlRzSDNBdEhOT3dFN1NPSk10?=
 =?utf-8?B?Z1NEOGFrSUZzRytSVk1ZUkgxRVNSU0MzR3p3ejBDN3F3ejVXTFoyaWNrR25S?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E1585206D17F44684D2847E6E74F98B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ed0afb-d329-4d29-c7f0-08dac051f10a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2022 23:52:19.4935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 79Bh9sype1QQtnm13T4o7cZNzvA2nrOQW3956CRNZDpmSXQ7/o7KMjPn9I8Vk85oZdaRoryAjA/Ky1IfQ/7U0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5800
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBOb3YgMDUsIDIwMjIgYXQgMTI6MjM6NDBBTSArMDIwMCwgVmlsbGUgU3lyasOkbMOk
IHdyb3RlOg0KPiBPbiBTYXQsIE5vdiAwNSwgMjAyMiBhdCAxMjo1OTozMEFNICswOTAwLCBOYW95
YSBIb3JpZ3VjaGkgd3JvdGU6DQo+ID4gT24gV2VkLCBOb3YgMDIsIDIwMjIgYXQgMTA6NTE6NDBQ
TSArMDIwMCwgVmlsbGUgU3lyasOkbMOkIHdyb3RlOg0KPiA+ID4gT24gVGh1LCBKdWwgMTQsIDIw
MjIgYXQgMDE6MjQ6MTRQTSArMDkwMCwgTmFveWEgSG9yaWd1Y2hpIHdyb3RlOg0KPiA+ID4gPiAr
LyoNCj4gPiA+ID4gKyAqIHB1ZF9odWdlKCkgcmV0dXJucyAxIGlmIEBwdWQgaXMgaHVnZXRsYiBy
ZWxhdGVkIGVudHJ5LCB0aGF0IGlzIG5vcm1hbA0KPiA+ID4gPiArICogaHVnZXRsYiBlbnRyeSBv
ciBub24tcHJlc2VudCAobWlncmF0aW9uIG9yIGh3cG9pc29uZWQpIGh1Z2V0bGIgZW50cnkuDQo+
ID4gPiA+ICsgKiBPdGhlcndpc2UsIHJldHVybnMgMC4NCj4gPiA+ID4gKyAqLw0KPiA+ID4gPiAg
aW50IHB1ZF9odWdlKHB1ZF90IHB1ZCkNCj4gPiA+ID4gIHsNCj4gPiA+ID4gLQlyZXR1cm4gISEo
cHVkX3ZhbChwdWQpICYgX1BBR0VfUFNFKTsNCj4gPiA+ID4gKwlyZXR1cm4gIXB1ZF9ub25lKHB1
ZCkgJiYNCj4gPiA+ID4gKwkJKHB1ZF92YWwocHVkKSAmIChfUEFHRV9QUkVTRU5UfF9QQUdFX1BT
RSkpICE9IF9QQUdFX1BSRVNFTlQ7DQo+ID4gPiA+ICB9DQo+ID4gPiANCj4gPiA+IEhpLA0KPiA+
ID4gDQo+ID4gPiBUaGlzIGNhdXNlcyBpOTE1IHRvIHRyaXAgYSBCVUdfT04oKSBvbiB4ODYtMzIg
d2hlbiBJIHN0YXJ0IFguDQo+ID4gDQo+ID4gSGVsbG8sDQo+ID4gDQo+ID4gVGhhbmsgeW91IGZv
ciBmaW5kaW5nIGFuZCByZXBvcnRpbmcgdGhlIGlzc3VlLg0KPiA+IA0KPiA+IHg4Ni0zMiBkb2Vz
IG5vdCBlbmFibGUgQ09ORklHX0FSQ0hfSEFTX0dJR0FOVElDX1BBR0UsIHNvIHB1ZF9odWdlKCkg
aXMNCj4gPiBzdXBwb3NlZCB0byBiZSBmYWxzZSBvbiB4ODYtMzIuICBEb2luZyBsaWtlIGJlbG93
IGxvb2tzIHRvIG1lIGEgZml4DQo+ID4gKHJldmVydGluZyB0byB0aGUgb3JpZ2luYWwgYmVoYXZp
b3IgZm9yIHg4Ni0zMik6DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL2h1Z2V0bGJwYWdl
LmMgYi9hcmNoL3g4Ni9tbS9odWdldGxicGFnZS5jDQo+ID4gaW5kZXggNmIzMDMzODQ1YzZkLi5i
ZjczZjI1YWFhMzIgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYvbW0vaHVnZXRsYnBhZ2UuYw0K
PiA+ICsrKyBiL2FyY2gveDg2L21tL2h1Z2V0bGJwYWdlLmMNCj4gPiBAQCAtMzcsOCArMzcsMTIg
QEAgaW50IHBtZF9odWdlKHBtZF90IHBtZCkNCj4gPiAgICovDQo+ID4gIGludCBwdWRfaHVnZShw
dWRfdCBwdWQpDQo+ID4gIHsNCj4gPiArI2lmZGVmIENPTkZJR19BUkNIX0hBU19HSUdBTlRJQ19Q
QUdFDQo+ID4gICAgICAgICByZXR1cm4gIXB1ZF9ub25lKHB1ZCkgJiYNCj4gPiAgICAgICAgICAg
ICAgICAgKHB1ZF92YWwocHVkKSAmIChfUEFHRV9QUkVTRU5UfF9QQUdFX1BTRSkpICE9IF9QQUdF
X1BSRVNFTlQ7DQo+ID4gKyNlbHNlDQo+ID4gKyAgICAgICByZXR1cm4gISEocHVkX3ZhbChwdWQp
ICYgX1BBR0VfUFNFKTsgICAgLy8gb3IgInJldHVybiAwOyIgPw0KPiA+ICsjZW5kaWYNCj4gPiAg
fQ0KPiA+IA0KPiA+ICAjaWZkZWYgQ09ORklHX0hVR0VUTEJfUEFHRQ0KPiA+IA0KPiA+IA0KPiA+
IExldCBtZSBndWVzcyB3aGF0IHRoZSBQVUQgZW50cnkgd2FzIHRoZXJlIHdoZW4gdHJpZ2dlcmlu
ZyB0aGUgaXNzdWUuDQo+ID4gQXNzdW1pbmcgdGhhdCB0aGUgb3JpZ2luYWwgY29kZSAoYmVmb3Jl
IDNhMTk0ZjNmOGFkMCkgd2FzIGNvcnJlY3QsIHRoZSBQU0UNCj4gPiBiaXQgaW4gcHVkX3ZhbChw
dWQpIHNob3VsZCBiZSBhbHdheXMgY2xlYXJlZC4gIFNvLCB3aGVuIHB1ZF9odWdlKCkgcmV0dXJu
cw0KPiA+IHRydWUgc2luY2UgM2ExOTRmM2Y4YWQwLCB0aGUgUFJFU0VOVCBiaXQgc2hvdWxkIGJl
IGNsZWFyIGFuZCBzb21lIG90aGVyDQo+ID4gYml0cyAocmF0aGVyIHRoYW4gUFJFU0VOVCBhbmQg
UFNFKSBhcmUgc2V0IHNvIHRoYXQgcHVkX25vbmUoKSBpcyBmYWxzZS4NCj4gPiBJJ20gbm90IHN1
cmUgd2hhdCBzdWNoIGEgbm9uLXByZXNlbnQgUFVEIGVudHJ5IGRvZXMgbWVhbi4NCj4gDQo+IHB1
ZF92YWwoKT09MCB3aGVuIGl0IGJsb3dzIHVwLCBhbmQgcHVkX25vbmUoKSBpcyBmYWxzZSBiZWNh
dXNlDQo+IHBndGFibGUtbm9wbWQuaCBzYXlzIHNvIHdpdGggMiBsZXZlbCBwYWdpbmcuDQo+IA0K
PiBBbmQgZ2l2ZW4gdGhhdCBJIGp1c3QgdGVzdGVkIHdpdGggUEFFIC8gMyBsZXZlbCBwYWdpbmcs
IA0KPiBhbmQgc3VyZSBlbm91Z2ggaXQgbm8gbG9uZ2VyIGJsb3dzIHVwLg0KPiANCj4gU28gbG9v
a3MgdG8gbWUgbGlrZSBtYXliZSB0aGlzIG5ldyBjb2RlIGp1c3QgZG9lc24ndCB1bmRlcnN0YW5k
DQo+IGhvdyB0aGUgbGV2ZWxzIGdldCBmb2xkZWQuDQoNCk9LLCBzbyBicmFuY2hpbmcgYmFzZWQg
b24gIiNpZiBDT05GSUdfUEdUQUJMRV9MRVZFTFMgPiAyIiBzZWVtcyBiZXR0ZXIuDQpUaGFuayB5
b3UgZm9yIGFkZGl0aW9uYWwgdGVzdGluZy4NCg0KPiANCj4gSSBtaWdodCBhbHNvIGJlIG1pc3Np
bmcgc29tZXRoaW5nIG9idmlvdXMsIGJ1dCB3aHkgaXMgaXQgZXZlbg0KPiBuZWNlc3NhcnkgdG8g
dHJlYXQgUFJFU0VOVD09MCtQU0U9PTAgYXMgYSBodWdlIGVudHJ5Pw0KDQpUaGUgZm9ybWF0IG9m
IHB1ZCBlbnRyeSBkaWZmZXJzIGJhc2VkIG9uIFBSRVNFTlQgYml0LCBhbmQgUFNFIGJpdCBpcw0K
Y2hlY2tlZCBiZWZvcmUgUFJFU0VOVCBiaXQuICBTbyBpbiBvcmRlciB0byBkaXN0aW5ndWlzaCBm
cm9tIGEgbm9ybWFsDQpodWdlIGVudHJ5LCB3ZSBoYWQgdG8gZGVmaW5lIHRoYXQgYSBub24tcHJl
c2VudCBodWdlIGVudHJ5IHNob3VsZCBoYXZlDQppdHMgUFNFIGJpdCBjbGVhcmVkIChhbHRob3Vn
aCB0aGlzIHNvdW5kcyBjb3VudGVyLWludHVpdGl2ZSkuDQoNClRoYW5rcywNCk5hb3lhIEhvcmln
dWNoaQ==
