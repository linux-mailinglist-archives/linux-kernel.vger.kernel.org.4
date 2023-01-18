Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4028F671394
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 07:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjARGN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 01:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjARGGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 01:06:54 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2079.outbound.protection.outlook.com [40.107.114.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B05B47E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 21:58:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dC4XnpYaBVUfGW2Gl5wvqSymE/2j+SLRJp2L02mfM7vtaNGJ3b+3oG69C3VxlyEk7KcIiIKu7ULCYFT5/13wRINZnnsujLtB8NfHoT1RHB8+aS0iu7utNubkeM/pTGmMMrjyooYqzUxKU4HsFOW82I/8+CbDysxOheaHQbC0qLFExf7UcI+C6z0us+QftQAnP53ICiNM9sr6UjVQPIk/vNuiz+pUIRV4vhcy5Pv6fFJVrRrNQdyfFK2jV/V4BR0OJYkoUgABqnO8FKj6gz8Qza1WFvCjE5Bj6EQys70SbrjTX43nKP7SZuOM6uq/gAS3hqbvuafNMMaFBXFMPqwIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmPUpQl4FJ//3O9z8pXgW9CMz43TwkcFbTlqPSQw7F0=;
 b=RxVME2RL1ukeU/HSRYjb8mUcSoQ6MYdQ3747NU9N4EZ2UijDMqgUTUADwVXRkT8UJVx8/fBhd+q78NNDSia5Mh0aZwuS/8toKeBVbu7FnPtZvWNekRlYJa4v2AbGqDkIFB0bA6YTAqJjaN5mMYO7/3pqGhXUc8FqhKL6fJLYVSvPVUOzUaXeDFrdF8zzDdWPMFSWmk3OpLs97rCWNvhzibPdY/mgrMskxoyMT5ocC7jNwBIMizqfZSEat1A0yvH7/BCwx3hAbyeZRCKN1BWApy6ey6CXu9wEfyGIJXnLdx53b7M+JVMvC5qcPpn9L2CEdNexLEh9MOIftEXpcZZYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmPUpQl4FJ//3O9z8pXgW9CMz43TwkcFbTlqPSQw7F0=;
 b=bOkbqM6TSoja+rFHr5tKKTF9ABdNc+wiF9xUon6mCL17CEZdHV9hMJToMeeYBoIWEdj7qwgZAP3DI9oe4VgTvhRFDq6YdLKIbnj/t+KbF3e4rVqk6ZhXYCGZ3yv8w/J3M88Yz15a8GYJgITM0os7rn1E4jAQO3iUKcEJjWUG/mI=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS3PR01MB5671.jpnprd01.prod.outlook.com (2603:1096:604:c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 05:57:51 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::f495:bf26:717c:c45b]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::f495:bf26:717c:c45b%3]) with mapi id 15.20.6002.012; Wed, 18 Jan 2023
 05:57:51 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] mm/hugetlb: convert get_hwpoison_huge_page() to folios
Thread-Topic: [PATCH] mm/hugetlb: convert get_hwpoison_huge_page() to folios
Thread-Index: AQHZKqHA+RRc1mFWcEWfzemUfwCGS66jrlOA
Date:   Wed, 18 Jan 2023 05:57:51 +0000
Message-ID: <20230118055749.GA3475659@hori.linux.bs1.fc.nec.co.jp>
References: <20230117182917.73729-1-sidhartha.kumar@oracle.com>
In-Reply-To: <20230117182917.73729-1-sidhartha.kumar@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|OS3PR01MB5671:EE_
x-ms-office365-filtering-correlation-id: c27b8c6a-d4f5-4ec4-4ebd-08daf918ef7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JC1Tg67iRoNusVb8FW06Tr7ULNG+336ku9MU1O18VDueU9d/ZXE5w64QONha9xtLUYfGmkB9sC08Tqwq0JBEXERxnpBzJv4CJY76z8iL8OHboXt1/OkCZViu3SCyaFATpex8w7uABwtX2UNOESaAb6nOX+wLDHqOgmP0yqnIrP8amf5POFy5095NbhCmc/2qoDSee+VfkFJJQ2NRetxLllmHDXxy6atd1n40IFhXRty6M+dAly+6+HMdcNgF9fpjghfIu1VR6T+LbmnUjENixOT4gUys4WQWUqABvB9WwhfZ2g8pkDsV793K+0yEcS5XsiHoK2smQtzemd2hJlgDqaCxfJPCH96kbtvt6XTJTqMtHzqG9LY+dvgFcWvfILwrUyMJxhhsKPN2Iodg8AYwqlpsJtIML5FlgprUs54J3siGuxDD3VvaEbUDSiI8ruliCyzyOaDEvx3CrM8lrEYNNOvxsnqadkybs+3MxBBltNcu2dEOm8YHEfFaqPOoYW+TmQYvDt6qWrnTDKOKR9b6WuyEGhmZXZpbpzI06v1rnmf95Y9bI4Z48Hn2AyPXWCSn/wyhYRKSDX2x5euiJe4Bie6uGf7qtlpIJw9lQS0GQx66WmTb9/lvJR67fOpgfOODdmdXGSnPu6aVsgkrL8woh32EtVVYmbURSxdz6t0Qs1Ab+ffkLDxKMZjdgyrPs2u26sWLxfAH+Vaie3JOmmHs7Jabz/BgUfrFcBVlj19+TDM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(2906002)(4744005)(5660300002)(8936002)(66476007)(4326008)(6916009)(86362001)(83380400001)(64756008)(66556008)(1076003)(76116006)(85182001)(8676002)(316002)(33656002)(41300700001)(66946007)(66446008)(71200400001)(55236004)(6486002)(186003)(6512007)(26005)(82960400001)(6506007)(9686003)(54906003)(38070700005)(478600001)(122000001)(38100700002)(14583001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZytacFdTSnBoTElKU0dVZGl5Ty93RjhRZHErYkxyZW1vQkIvcTBRZEVVYkhx?=
 =?utf-8?B?UUVEekl3UjdVa05oeHYwZVRqVEFFM2F4bWx4MFdzdFZ6ZXFPaWI0UWgzUVJN?=
 =?utf-8?B?ZGVKRS9BNHNkVGF4SXpLc05vOEhCNGRNREYza2JEZEFXekt1RWdXeHhEVFZD?=
 =?utf-8?B?Wk5nQVlFU09lSjZ0bnIyeGZnTVVpeFUrV1l2TEt1eE5MclVibU14MUcrYjM4?=
 =?utf-8?B?eEFXRFVlZUVrczhMaGRsOWJ6cFRKTXFYcm9FN1dwaDUzbFFIMVR6aGIwWmlC?=
 =?utf-8?B?ZDY3ZWdmQlE4Q0hrM0ZYZXdwT1crTzVEa0Y2MXJidU45d1ZqWDl4Qko2S2NU?=
 =?utf-8?B?Y2o0ejllcE1QMUFUOWdmbTRqWHRMTzZ3RDFzbXY4dEQwcVgwK1kreXltQTla?=
 =?utf-8?B?TE1BTVRqaS90L1E2QzVaWXRFYmR6cjJQSGE0WENmUnVzL1ZRRVhsVmluK2tP?=
 =?utf-8?B?ODFJenJ0bFhKa1NIbXd2ZkVVUGZTSkxjdmd2UWduRVBRazNxNEtaOHJYZjdE?=
 =?utf-8?B?Vis0bzRpUjUydlBieTRCMHpoajhnOXpVVitJU3VkSXVraXRCTFd2OU9wTkZ4?=
 =?utf-8?B?Y3pwRXlPdExlaFZNa3lxWDBkN2FFYXl2eHBUb21RVWVFbThJVEtDMEdaeDhV?=
 =?utf-8?B?UkR3N3czMmI3VWRkTEptbmtxTkhwakxYVEFjZXA2QjB3dzNZdjBLakVUMnVz?=
 =?utf-8?B?QmY2YmZXWHpWRFF5WlVQOU9kcVFQSUpnc1VpWDRwckNNbCtwUjZVR0lFK2JX?=
 =?utf-8?B?WHRIR2RYM0d6ZVB6ZUVGTmVSVFJDNEYydm42SC9ZTHBPTDdTZExocUxudjRu?=
 =?utf-8?B?V1c4cDJCUzhnMWNIejI4YXIyRW9RNmlvR0xWeVVvSUxsSi9pbDJ5YjRJamZB?=
 =?utf-8?B?ekMwU3hGUFhjd1kwL3NiaVlnR2hzZWE0THp6T0JGVEErdzB4cXNkVzVsM25p?=
 =?utf-8?B?M2xRWkIzWTNTT2VlZGY3SGRNTHp4Z2JncWsvWVVrLzNOUlBBS3JYRVFRZzZS?=
 =?utf-8?B?dXJkM2dadzBkc2JFelJBdVNyNDVCa0pPWTFlb1BWMFJPeTc4UVprSWxwTkZo?=
 =?utf-8?B?b2dKOXA3R0pvWEJuZ3M5MTZRYnRFQU1uS2RnTUxZVkVLVmgrTnRsMWlpSWM3?=
 =?utf-8?B?amxtREJPQk1QRFMxU0RoODc0VUdFZjJhQU8xNTBucHlQT05JcXVZd3RhTitU?=
 =?utf-8?B?bUV4VkJqcGs2dnNpTWprKzVNd3ZpSGFtcTAzU2VkMi8rWVloZXY4RFRJZUtT?=
 =?utf-8?B?MVFYdU5wckxiTzhObGd6UDBLK3A0OUhxQWlaNHpkbjl2T2o2M2RkcG4xOFVZ?=
 =?utf-8?B?eXZqc3dTaUlUWmkwdGJGUjRoNlVVOEVDNENyeEt2RHVlN3hjam05QlRmSEp2?=
 =?utf-8?B?OW1CYlYweDRaTksxc0N1Q09iR2dBSGl3OXF1Q2VkTHU5NVV0L2VVZWkwQWxT?=
 =?utf-8?B?RzdUNDNHMzhnTEluaGpJWThqV3BKQy9PR2NScnRIVGtuQ2daQXNYbkh5aTJv?=
 =?utf-8?B?UVgwazhzOExwbDZPS3BaMmo3WTVaNDloS2lWVVdPTlc2V0RPMHRzbmlhZ09m?=
 =?utf-8?B?ZFFOUFNhd3M2Zi94RGdFZWU1cHVNZm9FaXZwU2wwMUR6bmhjc0NvQjJ4UXVN?=
 =?utf-8?B?TWpMMWFEd093VVQvTlhJRzczUElBdUs3MXJjZXUyOVpUN3BVWExmZjlOU3I4?=
 =?utf-8?B?Y3JpZmJWNmFuMmdVUFJqRkpFVmhNMGt6Z1pHUEVDWHNWdmRveFhDU1BxOU1k?=
 =?utf-8?B?NVNtUklTenpKbzhlaHdhYlRuSEs4YmtMTHpzNGR6RFpPUDBzTDJIWUNWdklt?=
 =?utf-8?B?bXh6bVQ4YkUxZGtvMFNHUGRVYXdNY2svK3EwbzVlT0VCaDF6aUI2L2tIdzVv?=
 =?utf-8?B?VmJ6dTVRTlFIMmtXUE5BVzhVQnllWE5VblVGMnF0c0w1NW5waWNyMXpXRnFv?=
 =?utf-8?B?SnhjbkF2bGNBaTZkd0o4ZlFvNHVPYkhOVmtzbmQxNW5KRjVPN2JxU2V1Z2ls?=
 =?utf-8?B?MTBpS3lCYTRmMUtRVnlVNHRuNUgwdzY5SFVObnRFbUJiMy9kMXhwenU4V1o3?=
 =?utf-8?B?U1hULzhLczJNMnlGS1lhZkxPY2swaWp2NCtVODhhajl6cExRRjk3VnA2MTJQ?=
 =?utf-8?B?VVlza1MyUlZ0RmVQRkphY01meEFta2szU2l2UG9pSTRnRUVwRWlNZ3dZM2ov?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <460B00193F38B3439C7FFA891519073A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27b8c6a-d4f5-4ec4-4ebd-08daf918ef7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 05:57:51.8219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OT/R+kNkL6c7KCS9chJON1gKuvYgu/Gr1BM+mhhjKA+kVGDPEgm1JgZ3Vo+MD9yq07jv3jlIQ2I44v3hZIeB0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5671
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKYW4gMTcsIDIwMjMgYXQgMTA6Mjk6MTdBTSAtMDgwMCwgU2lkaGFydGhhIEt1bWFy
IHdyb3RlOg0KPiBTdHJhaWdodGZvcndhcmQgY29udmVyc2lvbiBvZiBnZXRfaHdwb2lzb25faHVn
ZV9wYWdlKCkgdG8NCj4gZ2V0X2h3cG9pc29uX2h1Z2V0bGJfZm9saW8oKS4gUmVkdWNlcyB0d28g
cmVmZXJlbmNlcyB0byBhIGhlYWQgcGFnZSBpbg0KPiBtZW1vcnktZmFpbHVyZS5jDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBTaWRoYXJ0aGEgS3VtYXIgPHNpZGhhcnRoYS5rdW1hckBvcmFjbGUuY29t
Pg0KDQpMb29rcyBnb29kIHRvIG1lIHdpdGggYXBwbHlpbmcgTWF0dGhldydzIGNvbW1lbnQsIHNv
DQoNCkFja2VkLWJ5OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0K
DQpUaGFuayB5b3Uu
