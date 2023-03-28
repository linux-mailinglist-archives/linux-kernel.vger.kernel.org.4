Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94B66CC9DA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjC1R6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjC1R6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:58:48 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F9E10433;
        Tue, 28 Mar 2023 10:58:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6Yho39LoSY+iOVjeLdGYBHrOnXqyV3aMAmOOVVn26JIQjmOM5qeoNspDBlA9zcB+XRUxc+q21QCm++n+P2dBZtJDB6R1Ke77NnKeKg9dIykZfuArG/2oTd2JRZ/TuCekjfdzWcvhIKN4iXeIKlN586oU0OlABsGWHT1nV2+yN54313R8d9jpGbdBzRPByEBXMldv5oItg8jEB71fGkifXnrZzgSNOi8mPO4Na1bgafmGoaBh2qnhfqRPmB0HBFX7NFRFlZVHU5lHV8Q24NjtE43a6g8e5k0AATBRFN846qefNaqwSUZGtyitHDi4l7xMdgPOuFcCEbf2Z9QTMgDEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwWBZhO1wqIKmSwi1/edUE8W6nK4df8cg3dLn6ydrf4=;
 b=XsA41b47pPh4rLf2YWrqQlqePs/zHFbMD55GYH1XPyaUjCBAaBJQDp6vZCdyKvTK8i35h0EdTqEeQVyp9DiDGHF1BMpGWL6TbbrdVJZ4ZsdF2UAXQUv54JD5U4zmP8hDaUoloZvVhNadySsuCkydCdhiTCOvQRY8AP4DUYFJKhCYTRXVuLnu8uviz/FtcDXsSh7ztYXP8kOiM5YRCcsHDcn6jY1iaFRFd2aMY/GZnIEHoCsH/HMgQCC0bt2uK/bGekuzbdJV6iAYWs38JbgSH0TeuaTQE6sk0DSWLYO9As3LslIImvTX1Oab82qxgp1j37iwyYgppBworeFN141zOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwWBZhO1wqIKmSwi1/edUE8W6nK4df8cg3dLn6ydrf4=;
 b=sfLD5Dbg7ArMsjHm2VxFWccrpaAz801NBMnccK0/5GM5g2Mca6xfvUpNaKEv8naPpgFkVtbzx6R8gCbe+Je5rBcltHa/57Zzy7X2jd3v/uSrY0N3PNC80ppk9SQwpNy2lxZRv47i1kaV0VQkQacCMkN35b7RJ6O9S3B35pQHRJQKTBWpXI7ZiP7PKt54hdmuRzRkSJarvCdqDEUUSUZPehcAHUukBGt00ls6OKl7D1VWBEXU5n1BJFq1czguk+1ixiVhMYSfUyXkYMf3sGmOu+DwPasLvsfEm+CZpnplFAeQc3eDvS9N4g/dyhYMFt3h7RV3HK9aonG5+KZw1ozn9g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 17:58:24 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6222.030; Tue, 28 Mar 2023
 17:58:24 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Zheng Yejian <zhengyejian1@huawei.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] blktrace: Gracefully return if fail in
 blk_register_tracepoints()
Thread-Topic: [PATCH] blktrace: Gracefully return if fail in
 blk_register_tracepoints()
Thread-Index: AQHZYVnBKN801/2HuE+GbVHCI96aJ68QexOA
Date:   Tue, 28 Mar 2023 17:58:24 +0000
Message-ID: <5e3d8652-7cab-a6ea-a943-80950a0f9bed@nvidia.com>
References: <20230328094605.480557-1-zhengyejian1@huawei.com>
In-Reply-To: <20230328094605.480557-1-zhengyejian1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB8147:EE_
x-ms-office365-filtering-correlation-id: e8c7774c-1ada-42ea-7062-08db2fb6067d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u+ASXpzSsDeVffHS4NyXss8myYs6p4exFq/2dx9c13gNEiwutuVQc0/4fRvtuUUo7AIVakSdHg7fEWcmsc0tM9kxapIkMt5bUzhRyo6uhz6ibM0eFDvBFUr8afgwEKrXEk1KKShGB8TnRl99p+wcruXFmtquJ1kUZA9s+5QpfhJ/+oTii6z8auWocu+Q18/JHoB6jj6uHlm9d+Vr+M5h8pGb0mR9E/ojzRjJmoKajAfPwRhWLst4aWe0GYEtiUhl087DmdbGzpEr6VlUAe29+eWN5772OLObK0JeJi67tzsvHVLZu+tnyz5hT/GjKGGGM7gfLJDO/ySEuQyq1jCCJJol4yfCWFr5pZ9Fak4IZJXy7kWrD48/e3gNFM8QDoBRK9lD3sNERAbcdddsT85Daj5PjNt8KLGKT/Dr10g4Wmv+qZbcWpg38G8IM8LAL4WaNmQyC9BGz9wXEnRUCrnqXM94mo6ujPu7YR0pYCXlhgIys6ABbNBLsUhRU+LJaiuE8oFhh0PJGi+w6xLHbCOQ6Tn4QCpUps1+be+HahT3B1Fdguil910HkgxJJ13M5yxnLcDfDyZGrfyxo7mh5vdwVCH4Tnv8p0NvFQ7aL8wFtqN2DhXWwW/GI2V+75Rcon4L5G0Gb7KbJHbxDgwFWcyyZy/CnH6La42Gfd+BXjyiF11joSi2Lff3zaSaC5ZJ/3XL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199021)(26005)(2906002)(86362001)(83380400001)(31696002)(4326008)(8676002)(2616005)(186003)(38100700002)(5660300002)(64756008)(66556008)(38070700005)(53546011)(41300700001)(66446008)(36756003)(122000001)(66946007)(66476007)(8936002)(76116006)(6486002)(4744005)(6506007)(110136005)(6512007)(316002)(91956017)(54906003)(478600001)(71200400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDdjL2hqY2J0NEVoMUYxN1YxSzBMbU51dGlmT1JYZ0NWTUVTYWMwVlFlNmlL?=
 =?utf-8?B?WlY3K2YvOFhiQStSdnNlM0NRclNaWkxETlRJSXVNeEVxVVQ2UzhkN0k5eldv?=
 =?utf-8?B?OThSTzlDQVJSQkh3WEUrQ2dmTFNTZGI2RUg4MnEyREVhZEpoZmoraEJldzVT?=
 =?utf-8?B?TjN3ZmZnQ1lkcHZNTVlscHI0UUtKTUVkbmNjUHdObzNKOTVxRHgza0MrSWxD?=
 =?utf-8?B?azFXWjM1clVqVU12SzcrWDh6N0dsYWdCcGFtVlVJYUFQNXlhRTc4NUExbkVv?=
 =?utf-8?B?TEpQWWE5RERCTUhmN1NxNm43eWpBNHNyOUJMMTBwQVhKd0dKVzV0cnprbm1Z?=
 =?utf-8?B?ODFCbUVHeUVvMXFKKzFQZ3E1TFRSNC9Nemw5VFVDV1BpaytkNm1CT2FWZUpB?=
 =?utf-8?B?ek01b0dGRGM2QnQ5NEk3ZW1GaTlVNDV5QmZYckdOYkxDdDhsUi8yc1hTamhV?=
 =?utf-8?B?VVF4cWh5K3Yyd0VuNWlIQVBub2QvaUlhaEUvdFdGMzFpQ0pHazEyNzVyeHBU?=
 =?utf-8?B?elVaQWhMRHpONWUzZkhtbHZZaTMzNWNkWUIyMXB4L3d4Y21DVEszd3dEY1Rj?=
 =?utf-8?B?dDV2L204MXJNWGVuRFZQVElxalhxRUhpVlRCbU9kTmJ6ZTMwZVVLRDlpeFB3?=
 =?utf-8?B?UVA1b29uaGk3ZXBnUUtrVXQ5alhnU2tiU2YrelZvV05rZ1QwckdoblVoZjRD?=
 =?utf-8?B?Wm84TkFPNlpVRVRSYWR3dGdLUWR0eVhGV2N1T2RtbDN1K0dsRmpSMW4zRjdJ?=
 =?utf-8?B?WTNlSThMVWl6NFRzUnlUaERkL2NGZ05YczRRaGpkZW9kQVV1cTFaZkdkZ0tZ?=
 =?utf-8?B?ei9RczcxSEJFUHpWbWlucjFoTmZYc2hGK1hhMVFYbDNUUkVQRndFOFhEUFJH?=
 =?utf-8?B?bnhXeThmYnZ1M2dkT0xlRHFEUGxQNGdoWWIzQmdnMDVScFR6VktNaDhkMHEw?=
 =?utf-8?B?eFV0SW5CMEtraVNua1R1ay80b1ZrVzFkSjdJbVFlTTVDOEplUEsyVDZsZTJ2?=
 =?utf-8?B?NFRBR2RxNkFESlIxajNKM1hybHYxQUNqM1IvTzRkQkdIQmMyZHg1VFltdWph?=
 =?utf-8?B?UDVlOFlOWXRXM1Q0MXVPM3BheW9pKzdqb1NHWm1GTHd5a2FWOG81SzU3MFYv?=
 =?utf-8?B?ZjRFWE5ZMloyUkxPNGN0ZWtjZ0VDN253K0ZnbGc4aUFJUUZqZUpWQ29RcTVm?=
 =?utf-8?B?MWFHL21walo3R1BOQWZhZVdPVkRkKzY1U2JHVncxOGhOeTB6azZIRzRadWVp?=
 =?utf-8?B?dkQ5S3BaK2FxaWlRbzNnSjRJdU1ZclhUbjAyRlltV015ZVY1MFlkNDlrYU9q?=
 =?utf-8?B?V0RMMmtVcis2bER5UnVhczZmcWoxNGJCN3dIUlZZaXVabnpMeEZERDhTK24z?=
 =?utf-8?B?enBpdXA2T1lHYzZWdE5NUUc5L1lxSnp3a0ZEeWdlSkxFZVI5S2JOc2lJTFRo?=
 =?utf-8?B?SWR5WVdJcDNQeW5aN1hRL1MzR3ZUVVhSWjc0U0dnRFRwYkwzbExUSndZazV2?=
 =?utf-8?B?aWF5RHl2SmlZdVhmVG0reWJod2Jhb1V0QWg2VzM0dUlWZTN5Zk84T094NXB2?=
 =?utf-8?B?UDdxUDRoS3FqS2lpOERVMFQyYkgzaHBIRTErVXM1TzNRRlUvQlpCU0JodDZx?=
 =?utf-8?B?Q1k2eFJTODN1VSttNzBIQ1VFeUROMVNrdXZWOFdEMFhvZEhXejd3cXJrUnph?=
 =?utf-8?B?ZUd1dlZ5ZEtBdEhhVzRkL25kcmM4T3FRbmx0eCtMekdIcWFrc1BEQlhrRlBu?=
 =?utf-8?B?TGFIQkU0T2JmUXJkdU1VN2hMUzB1cnp3ejFwc1hNMkwzVERGVFBYQ1BWTG00?=
 =?utf-8?B?azlGRCtTTmQ2NzcyeXl6dzR5TlhoaXl0RDFnNFpaTENFeUd5cFZBZWwwOHl3?=
 =?utf-8?B?a2hieDhXOW1YejhqbWVmM08xa0FVcFRqTm1nYTZzVWY1SG1ocXBvVXFPUVp1?=
 =?utf-8?B?NFR2a2ZDZnBvK1lEZDAzd1QwNUNRc0FLdFpIcVJXNW5MaU9GenNkS2VJNEg0?=
 =?utf-8?B?WUJlTXIwQWxIemVsZzdJSUUvdXRyb29tamNwbVc4S2RVUFlnZ2llOUxnZG1t?=
 =?utf-8?B?eENzalBNVWxIYjF6MmRobVM0YUFtNVpnWEZsbjlOR0ZqRlM5ZUtZYS9VOTBX?=
 =?utf-8?Q?5ilY4om9G1PkiwVYbbhc9DlJ3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9FB4C4E6D4D1A45A6A97F6B0A0140E2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c7774c-1ada-42ea-7062-08db2fb6067d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 17:58:24.2345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GNlaTsHVT7pxMu3HPb0dZ526RgifHPfNPOUirlzQPbSa1kRFvopi7OCEG3hRA04AySNM4Rp34tEInFPjGf35xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yOC8yMyAwMjo0NiwgWmhlbmcgWWVqaWFuIHdyb3RlOg0KPiBDdXJyZW50bHkgYmxrX3Jl
Z2lzdGVyX3RyYWNlcG9pbnRzKCkgV0FSTiBmb3IgZXZlcnkgcmVnaXN0cmF0aW9uIGZhaWx1cmUN
Cj4gb2YgYmxvY2sgdHJhY2Vwb2ludCwgaG93ZXZlciwgYmxrX3RyYWNlIGNhbiBzdGlsbCBiZSBz
ZXR1cC1lZC4NCj4NCj4gSXQgc2VlbXMgYmV0dGVyIHRvIGNsZWFudXAgcmVnaXN0ZXJlZCB0cmFj
ZXBvaW50cyBhbmQgcmV0dXJuIGVycm9yIHdoZW4NCj4gYSBjZXJ0YWluIHJlZ2lzdHJhdGlvbiBm
YWlsZWQsIGV2ZW4gaWYgaXQncyBhIHNtYWxsIHByb2JhYmlsaXR5LCBhbmQNCj4gdXNlcnMgY2Fu
IGtub3cgdGhlIGVycm9yIGFuZCBkbyBibGtfdHJhY2Ugc2V0dXAgYWdhaW4uDQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IFpoZW5nIFllamlhbiA8emhlbmd5ZWppYW4xQGh1YXdlaS5jb20+DQo+IC0tLQ0K
Pg0KDQpTbyBmYXIgSSdtIGZpbmUgd2l0aCBjdXJyZW50IGNvZGUgYXMgdGhpcyBhZGRzIGEgbG90
IG9mIGNvZGUuDQpJJ3ZlIHRob3VnaHQgb2YgZG9pbmcgdGhpcyB3aGVuIEkgd29ya2VkIG9uIGJs
a3RyYWNlIGV4dGVuc2lvbiwgYnV0DQpvdGhlcnMgYXJlIG9rYXkgd2l0aCBpdCBzdXJlIC4uDQoN
Ci1jaw0KDQoNCg==
