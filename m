Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B5D620465
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 01:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiKHABm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 19:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiKHABW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 19:01:22 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2089.outbound.protection.outlook.com [40.107.113.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4CE200
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 16:00:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPb+A23Al+nI5utMFOIJZW8eTrdcIXPq2qyNPkyZXgcFoC+NRaVda8V8W100cpc+SRs58uWp09g5OW789BDEx+Gime+57QRzPsffUH2+l8msjQvnAlWOlFYUP6oCbSrvZrmVpY4oB4TfHIxrQAlSkQwLlJZ85zBahxL6Ewc6ZiAykr3XXBrECNq+5yzdFAmiCjD8MdLIjur2qVcCypgZ5YSetD0fPnMkgZsdFVvMPcLUs7PjAOf1bXC3N5dopCO+QmR/ImkBQCP39WfyjPFsXThu9qxjT8e7e4zEvYO8D9+OZqyjC7rITskHycmfPHN3SbvVyl+Y3X1ynIrJxneZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4O+KNhf/BNmBNbQx4Qy3hbad1kdXjCErCYGX8UEKBaI=;
 b=BTFvh4tbcko/daJBMNv90xyKx3/eua1rnf1Ukaf5q4EMDdWzcXwC7CF4qSkksbLPwsSt+XimYlT2ZjC9zxAuYHI3Nc36nHiKqChmIn+VOUQSAWFu03k2TrnKkBCmn+Vurun9SFuz763m4krse+82k0khEr65HTcL9Zf1lxZGqRkGoG4ygMKiBbpIa76WkXI9Fr/ZWByMPze9W8RDNrUfNCrHa2voQqTHFogkYrgs8v78/YS9j5gBkokUJnOKlThx26sBAOjF+7vDDHghSppGOHbM4qz5PqY46wdzuK8XM41JsWnWaEW89s6t0evIkMRXP4hxV76LVUigOHLrgC1XNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4O+KNhf/BNmBNbQx4Qy3hbad1kdXjCErCYGX8UEKBaI=;
 b=UjhDReQ2M7T9te/glgU09rjnxjLZP0IoImuZJtMo0upEZ9IRUU3Lphnk1QxU0H1enLvAVxBRJNgs5FWaGA2kW9tAVwgqAzOyESXccp3Yj8LlBaXEqQgkwSnSYa+KjYwUkvF47dcMqNkgLUQMDFIZG+cKsixs2OaAF9++DKvXdjs=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYYPR01MB8245.jpnprd01.prod.outlook.com (2603:1096:400:119::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 00:00:15 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c%9]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 00:00:15 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     =?utf-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] arch/x86/mm/hugetlbpage.c: pud_huge() returns 0 when
 using 2-level paging
Thread-Topic: [PATCH v1] arch/x86/mm/hugetlbpage.c: pud_huge() returns 0 when
 using 2-level paging
Thread-Index: AQHY8qZyXOKciFJsQEmOvQNHfaZD/640JNoA
Date:   Tue, 8 Nov 2022 00:00:15 +0000
Message-ID: <20221108000014.GB471526@hori.linux.bs1.fc.nec.co.jp>
References: <20221107021010.2449306-1-naoya.horiguchi@linux.dev>
 <Y2j9KqIY9sAIDize@intel.com>
In-Reply-To: <Y2j9KqIY9sAIDize@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYYPR01MB8245:EE_
x-ms-office365-filtering-correlation-id: ecc38eeb-8761-473f-0c83-08dac11c36f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0rdaNBp///T4JRA4l1ZIm0mD8HgX9xhO/DyWaeM1g/b4rxxkCdWcHBVybM8uPuM2+Pw2Nild3b6I3pipsTqs5emsG4rZbUM2peaWcfD4sJkMCA+fSAsLbYaJ4aVfmvCrCpMzjkFV2qyB1ZdyPbQRGGHHDV9B89YDn6iDb72FvxkC/l5ZPDBccQRMb5iw1AmRaR68o8iHWF4i0SijV8IGkXR08+3zyKEqdF87pfoFNZ/9tHpB7Jf+Htmqmz/G04yy37LIh0QfRuZRaLnGR9URV+FG1piMcvqNpUEy3lIY0Sn6B2NCNoVRP2jZeVi2IcIb4q/eZkMzKXD3YL0GFcwCmuQ1CFh9zuKjUPImS7b6LXlhlWJ6uFbJKwkpRcmvcmLsrXrWNUrdMlyEOt0vyjj66hOZcTsNgA6jq8c38x1RH4DrJsH1TekWsRDuW2p0qD+1l8Om2k5YKrr8uaQZxd4akw/1VGS8PvkXp7MiGIVTBDXW4yjTdHJEYQnMQQJniutJJyf3vkxiezE5VaOb/7110xLZYNy4TY5D6yC+QpNtFxEJJalH+BQ22z12qPe0WKVO4wz+hBvMEVMsN4fAi5jpST1zb1wjfmjofJGK5kQ75HIa5xfauv8UWUbRYJHMkoTFI9oqaFlGMWDZ9AUJ0UJKkXn71gyLr84Swy/mhTsw9LxfuKe6c+wpYpew2BNhObGDP6o5Z7oihnCYgABO+eo05bsCsPvbR7C6R6e01uhjE6eSxTS8UL2YESinkgO6jnw0fzWmZ5a1D3+Tl+gls1r82TR5Cfj9Zkwnlr503D4GVOw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199015)(86362001)(66899015)(85182001)(33656002)(66556008)(76116006)(5660300002)(8936002)(7416002)(2906002)(186003)(9686003)(6512007)(26005)(83380400001)(122000001)(38070700005)(82960400001)(66574015)(1076003)(38100700002)(54906003)(110136005)(316002)(66446008)(64756008)(41300700001)(4326008)(66946007)(66476007)(8676002)(6486002)(478600001)(71200400001)(6506007)(14583001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGdCc3E1cGhtTXYxcWVBT0JHNnhZdG83TVFtQmp2REEvaEhjZnpRQ3lSR1dj?=
 =?utf-8?B?MkhuVnJJdG0yanYyLzZFM2wrQVVBckxqeS9SZEo4RGF4emh0TW81bnd4VlRO?=
 =?utf-8?B?c1hEVmExbnJpTTZ0YzdEVElRdHIvVzJsbHpjTzYvT0JlWG5zeGkycmZJZmZF?=
 =?utf-8?B?enpoYjh5Sy81em53dVROUFZobTZ6UTdhK2xsUXNMWlh2T3VobVZSRHZPVHpB?=
 =?utf-8?B?OWkxNmZscFE5dDRiOGlQN2dJTVRqbTZIT1VvSWNHbHo2U0pCZHFTZCt5dThj?=
 =?utf-8?B?NEZPNGkzTkRFcHFlQy9ZTWlxVHIzcWJjZGNZUUVRWEVtMTlGQkZyUjZGYUhK?=
 =?utf-8?B?dS93ZnQyZS9Id0s1cDdrbDE0MUFwQ1hIKzBaUW10TkJSUm56OCtDaDVvRVRY?=
 =?utf-8?B?cVMvUkVibGV3alM3SmVrTnd4MlY4clVNRVpwSVBUblhUZldOS3FQR3hIaU1S?=
 =?utf-8?B?dEVpRGRFSjNEcFExSElkYWRDZHdiMVlpcFRnWEZYZ08yZW1pdlpLYWRVaUtz?=
 =?utf-8?B?VUNaeVFyUGJSd1BuUHJDUEZwMmRudnArTHVXMFNzSGtqT0tMRXJhK1ZESWRh?=
 =?utf-8?B?NWY4Q2dDeTRJaFR4OXhDTytKZ1I1NXA3YUdSOU9SbDJOWnMvMnNzQnVucUtv?=
 =?utf-8?B?UDkySEpPYVRKMGNnUXVLcnFSdkZSZERyb3dMUzcvQ3hNVzVIS3hzdzhteFVm?=
 =?utf-8?B?RHZTRlJVdjBMd1k4Q3dCYVh3SVhjMGl4bG9BcDV2aUhLWm0rQ0s5NHVmWTlL?=
 =?utf-8?B?MFhQaG5uRm5YL0RiWXBackxNMXNBU3UwWG94SDFlRVhDTEVVZDRYTDlscHl2?=
 =?utf-8?B?NE5YVnZOaExsMFlNZEdUVmk2TUwrR1JKeUEzR3E2NndpdHFGU3k4MHREU2s1?=
 =?utf-8?B?ZUs0OXBMWlNsUjdYZCtkV2owaUFaWmZmeUorN1psTDZUSDhUZHBnSnk5NEpa?=
 =?utf-8?B?amF5eHhEdStjR2d3SlM4QVFyNVNKZlIzQjczanozNFhvZy8vSzZ5YnhxVXZ5?=
 =?utf-8?B?aXRneFVGQTN5d1NXVStETmVFVStPUTdRdEVXVTBna3ZhVmU0NDdMVlp0WlpT?=
 =?utf-8?B?dG9QSlFjS0NHSFVkQ09UTHFnUFdDWmRiMzMzT0tJWXdMSjM3VFdZQXdJdmhZ?=
 =?utf-8?B?bnM4NEpvY24zSklONTVNVlZLTTh1UmRhNXQ5K1M2VnZ1dVZuZlpaOXY0TEwr?=
 =?utf-8?B?SlprUXRsN3lZYlN1aXNJYWhEcVRaSjEvMk15R3o4RXNOK3hNK29MbjUrQWta?=
 =?utf-8?B?SXlQemQwZUNjMGZTNWVoUUVLOWtBYzdMeFZDeDBZRXMwR0FobXU4Wm1uWTJo?=
 =?utf-8?B?Sjl6UjJWSFNJSVE3VVR5clNKNEVKMlN5TnE0cnp5b1ZzcXoxSWZuVXBDOGRi?=
 =?utf-8?B?ZTlOUjY4SnppVDRnU0JUek8rWU13VExqS3lNY3RIc29VeHM4TmwxYkRGcUN2?=
 =?utf-8?B?OS95bWpWajRWVUtQOGxuTk9kbUQwc3RubHBTRHpZWDhIUkhic3kxektlejRL?=
 =?utf-8?B?ZVF5dE5KMzIxZUtyWHpOV0VUZDc3azRwV1ZpWkNhTWFQU3lubFBSdTNEZ211?=
 =?utf-8?B?QTRPOTdDZHJ6a0hoOEZqRmErRVdZbVhNQVpORHRuR2ZvK0syMmNlTHR1T2o5?=
 =?utf-8?B?S0RPR3hlb0o3aisyMWl6a0lIdXNjMHdQd2hlYnk1NXM5UHNDUVI1WEcxbUow?=
 =?utf-8?B?MXdNNzd3dEptUkg3dThtdzN5WXhHSGxZQ0Vld2xKY3FGdjBrSjZFMGdBdk9n?=
 =?utf-8?B?NEJxSHRoN20yNkRKR2tRUHNwVkV0c2NNenQ0WlRreFZUODZtNHhzWThWTlZx?=
 =?utf-8?B?MzNDbGhWRlVPVE5MMTNpeHJNTVpBdFJyMFpySS8wQUxjQk5LcmdvT2pNME80?=
 =?utf-8?B?NEtoTlp6S1NtbzgvRGhTWW1uZkxNOHVGQU9pNHNoQWtkclA3MWdJT0dkTytQ?=
 =?utf-8?B?YUg1MkdhSEYzMDMvUXpSbDlaWFVBc3k4a0FmWHFEdVdYYTBPNGNTYkFodXBn?=
 =?utf-8?B?QzFMZlJGRUJVNkc2eUdubndLd0NXb0RFeUdBa1U2NlJRK3F1cC9CRXJJTjJk?=
 =?utf-8?B?SnJ3V3lOSHdlSHJhMFdTUDAzc3U5N2dxOCtKRXh4QjN4MWFnU2dVb0NjdW5M?=
 =?utf-8?B?UXJJaEExN0VBWDBEV290eGRRU2RQdC9LVGtsdmxMZGRTclc5WlRnd3BzSEx3?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <200C961FBFD8B4499654E837C33291D2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc38eeb-8761-473f-0c83-08dac11c36f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 00:00:15.1192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RPmCFF2FTOR/l0JBquBb006/mrC0jQ6wruhRXyUqhxlFSRJYkIRnYALweKKrl6wUAfNEw8fThUN1FMf6600GbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8245
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBOb3YgMDcsIDIwMjIgYXQgMDI6NDI6MThQTSArMDIwMCwgVmlsbGUgU3lyasOkbMOk
IHdyb3RlOg0KPiBPbiBNb24sIE5vdiAwNywgMjAyMiBhdCAxMToxMDoxMEFNICswOTAwLCBOYW95
YSBIb3JpZ3VjaGkgd3JvdGU6DQo+ID4gRnJvbTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3Jp
Z3VjaGlAbmVjLmNvbT4NCj4gPiANCj4gPiBUaGUgZm9sbG93aW5nIGJ1ZyBpcyByZXBvcnRlZCB0
byBiZSB0cmlnZ2VyZWQgd2hlbiBzdGFydGluZyBYIG9uIHg4Ni0zMg0KPiA+IHN5c3RlbSB3aXRo
IGk5MTU6DQo+ID4gDQo+ID4gICBbICAyMjUuNzc3Mzc1XSBrZXJuZWwgQlVHIGF0IG1tL21lbW9y
eS5jOjI2NjQhDQo+ID4gICBbICAyMjUuNzc3MzkxXSBpbnZhbGlkIG9wY29kZTogMDAwMCBbIzFd
IFBSRUVNUFQgU01QDQo+ID4gICBbICAyMjUuNzc3NDA1XSBDUFU6IDAgUElEOiAyNDAyIENvbW06
IFhvcmcgTm90IHRhaW50ZWQgNi4xLjAtcmMzLWJkZysgIzg2DQo+ID4gICBbICAyMjUuNzc3NDE1
XSBIYXJkd2FyZSBuYW1lOiAgLzhJODY1Rzc3NS1HLCBCSU9TIEYxIDA4LzI5LzIwMDYNCj4gPiAg
IFsgIDIyNS43Nzc0MjFdIEVJUDogX19hcHBseV90b19wYWdlX3JhbmdlKzB4MjRkLzB4MzFjDQo+
ID4gICBbICAyMjUuNzc3NDM3XSBDb2RlOiBmZiBmZiA4YiA1NSBlOCA4YiA0NSBjYyBlOCAwYSAx
MSBlYyBmZiA4OSBkOCA4MyBjNCAyOCA1YiA1ZSA1ZiA1ZCBjMyA4MSA3ZCBlMCBhMCBlZiA5NiBj
MSA3NCBhZCA4YiA0NSBkMCBlOCAyZCA4MyA0OSAwMCBlYiBhMyA8MGY+IDBiIDI1IDAwIGYwIGZm
IGZmIDgxIGViIDAwIDAwIDAwIDQwIDAxIGMzIDhiIDQ1IGVjIDhiIDAwIGU4IDc2DQo+ID4gICBb
ICAyMjUuNzc3NDQ2XSBFQVg6IDAwMDAwMDAxIEVCWDogYzUzYTNiNTggRUNYOiBiNWMwMDAwMCBF
RFg6IGMyNThhYTAwDQo+ID4gICBbICAyMjUuNzc3NDU0XSBFU0k6IGI1YzAwMDAwIEVESTogYjU5
MDAwMDAgRUJQOiBjNGIwZmRiNCBFU1A6IGM0YjBmZDgwDQo+ID4gICBbICAyMjUuNzc3NDYyXSBE
UzogMDA3YiBFUzogMDA3YiBGUzogMDBkOCBHUzogMDAzMyBTUzogMDA2OCBFRkxBR1M6IDAwMDEw
MjAyDQo+ID4gICBbICAyMjUuNzc3NDcwXSBDUjA6IDgwMDUwMDMzIENSMjogYjU5MDAwMDAgQ1Iz
OiAwNTNhMzAwMCBDUjQ6IDAwMDAwNmQwDQo+ID4gICBbICAyMjUuNzc3NDc5XSBDYWxsIFRyYWNl
Og0KPiA+ICAgWyAgMjI1Ljc3NzQ4Nl0gID8gaTkxNV9tZW1jcHlfaW5pdF9lYXJseSsweDYzLzB4
NjMgW2k5MTVdDQo+ID4gICBbICAyMjUuNzc3Njg0XSAgYXBwbHlfdG9fcGFnZV9yYW5nZSsweDIx
LzB4MjcNCj4gPiAgIFsgIDIyNS43Nzc2OTRdICA/IGk5MTVfbWVtY3B5X2luaXRfZWFybHkrMHg2
My8weDYzIFtpOTE1XQ0KPiA+ICAgWyAgMjI1Ljc3Nzg3MF0gIHJlbWFwX2lvX21hcHBpbmcrMHg0
OS8weDc1IFtpOTE1XQ0KPiA+ICAgWyAgMjI1Ljc3ODA0Nl0gID8gaTkxNV9tZW1jcHlfaW5pdF9l
YXJseSsweDYzLzB4NjMgW2k5MTVdDQo+ID4gICBbICAyMjUuNzc4MjIwXSAgPyBtdXRleF91bmxv
Y2srMHhiLzB4ZA0KPiA+ICAgWyAgMjI1Ljc3ODIzMV0gID8gaTkxNV92bWFfcGluX2ZlbmNlKzB4
NmQvMHhmNyBbaTkxNV0NCj4gPiAgIFsgIDIyNS43Nzg0MjBdICB2bV9mYXVsdF9ndHQrMHgyYTkv
MHg4ZjEgW2k5MTVdDQo+ID4gICBbICAyMjUuNzc4NjQ0XSAgPyBsb2NrX2lzX2hlbGRfdHlwZSsw
eDU2LzB4ZTcNCj4gPiAgIFsgIDIyNS43Nzg2NTVdICA/IGxvY2tfaXNfaGVsZF90eXBlKzB4N2Ev
MHhlNw0KPiA+ICAgWyAgMjI1Ljc3ODY2M10gID8gMHhjMTAwMDAwMA0KPiA+ICAgWyAgMjI1Ljc3
ODY3MF0gIF9fZG9fZmF1bHQrMHgyMS8weDZhDQo+ID4gICBbICAyMjUuNzc4Njc5XSAgaGFuZGxl
X21tX2ZhdWx0KzB4NzA4LzB4YjIxDQo+ID4gICBbICAyMjUuNzc4Njg2XSAgPyBtdF9maW5kKzB4
MjFlLzB4NWFlDQo+ID4gICBbICAyMjUuNzc4Njk2XSAgZXhjX3BhZ2VfZmF1bHQrMHgxODUvMHg3
MDUNCj4gPiAgIFsgIDIyNS43Nzg3MDRdICA/IGRvdWJsZWZhdWx0X3NoaW0rMHgxMjcvMHgxMjcN
Cj4gPiAgIFsgIDIyNS43Nzg3MTVdICBoYW5kbGVfZXhjZXB0aW9uKzB4MTMwLzB4MTMwDQo+ID4g
ICBbICAyMjUuNzc4NzIzXSBFSVA6IDB4YjcwMDQ2OGENCj4gPiANCj4gPiBSZWNlbnRseSBwdWRf
aHVnZSgpIGdvdCBhd2FyZSBvZiBub24tcHJlc2VudCBlbnRyeSBieSBjb21taXQgM2ExOTRmM2Y4
YWQwDQo+ID4gKCJtbS9odWdldGxiOiBtYWtlIHB1ZF9odWdlKCkgYW5kIGZvbGxvd19odWdlX3B1
ZCgpIGF3YXJlIG9mIG5vbi1wcmVzZW50DQo+ID4gcHVkIGVudHJ5IikgdG8gaGFuZGxlIHNvbWUg
c3BlY2lhbCBzdGF0ZXMgb2YgZ2lnYW50aWMgcGFnZS4gIEhvd2V2ZXIsIGl0J3MNCj4gPiBvdmVy
bG9va2VkIHRoYXQgcHVkX25vbmUoKSBhbHdheXMgcmV0dXJucyBmYWxzZSB3aGVuIHJ1bm5pbmcg
d2l0aCAyLWxldmVsDQo+ID4gcGFnaW5nLCBhbmQgYXMgYSByZXN1bHQgcG1kX2h1Z2UoKSBjYW4g
cmV0dXJuIHRydWUgcG9pbnRsZXNzbHkuDQoNClNvcnJ5LCBJIGZvdW5kIGEgbm9uLW5lZ2xpZ2li
bGUgdHlwbyBoZXJlIChzL3BtZF9odWdlL3B1ZF9odWdlLykuDQpBbmRyZXcsIGNvdWxkIHlvdSBm
aXggdGhpcyBvbiBtbS1ob3RmaXhlcy11bnN0YWJsZT8NCg0KPiA+IA0KPiA+IEludHJvZHVjZSAi
I2lmIENPTkZJR19QR1RBQkxFX0xFVkVMUyA+IDIiIHRvIHB1ZF9odWdlKCkgdG8gZGVhbCB3aXRo
IHRoaXMuDQo+ID4gDQo+ID4gRml4ZXM6IDNhMTk0ZjNmOGFkMCAoIm1tL2h1Z2V0bGI6IG1ha2Ug
cHVkX2h1Z2UoKSBhbmQgZm9sbG93X2h1Z2VfcHVkKCkgYXdhcmUgb2Ygbm9uLXByZXNlbnQgcHVk
IGVudHJ5IikNCj4gPiBSZXBvcnRlZC1ieTogVmlsbGUgU3lyasOkbMOkIDx2aWxsZS5zeXJqYWxh
QGxpbnV4LmludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYW95YSBIb3JpZ3VjaGkgPG5h
b3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiA+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4N
Cj4gDQo+IFdvcmtzIGZvciBtZS4NCj4gVGVzdGVkLWJ5OiBWaWxsZSBTeXJqw6Rsw6QgPHZpbGxl
LnN5cmphbGFAbGludXguaW50ZWwuY29tPg0KDQpUaGFuayB5b3UgZm9yIGNvbmZpcm1hdGlvbi4N
Cg0KLSBOYW95YSBIb3JpZ3VjaGk=
