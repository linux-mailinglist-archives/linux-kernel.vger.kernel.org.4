Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF50D610BC9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 10:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiJ1IFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 04:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ1IFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 04:05:06 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113EE25C1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 01:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCyWYPL3W6ZXo4yT5efZ0nUqbBxd3MEyI5KY8L0QAY2SsSkc4Lg8d7Zs1aVXA4LlLjXiu5jheC/stZAcEMgjTW3JkFR+OcKXN4CKwHqIlhQXoNQJrTtsUViTZE9aLZmzVuwdnRr14TvUtU0wbUX85AfllrYb3zITLRoSoM2Y+jjtvHxY9hI9UlBkHsp19h38J9beG90K/uRGsz4XSxWIm2hQp4Bus41POJeY38/BzHVl0r83MfWgG7Kwo2hER5bJ9LKKAlSM2GNWzqzNPt2E+82rdj7hT5lihmmgsy3PTnzo0HDgNbb/uWyOHkulK3mhCFN5wzBy6dx/3wqFFRVkHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfdhdV7r0d3nTl1d1nE8Ee277zqiP7hpuRUkGN6dnhk=;
 b=gtc+CewSFQ7wZtLgMPpIr6jZCKulFBTsazbwOQGqQBWJUQ5N3BK0YL/kpC/8P1YmqkIdNVEnUVx7RKLB5abHnzrX+oUTEE1+us1twCFlGqjEvL6Nu/S6NiGN8mJDV1mRB2cuweUxA1RdstKcpiPANjn32EzxOyCiHI8hsNcr3xvQZbkKxSzCck0Vq14dE/WZVWaCxzNYA3m6kLSJ96SqUMJZP/jpfaw2k+STFG8GoT+08AIFWMeR9eDVdSfCsKrSicO1Co9HoD0nzNOHJG574nuNYpHbH06qNAjukMvrGgElW7H1ZkFDP8sbDwipsJaPxivOyX5NPVTrKf0PvgA/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfdhdV7r0d3nTl1d1nE8Ee277zqiP7hpuRUkGN6dnhk=;
 b=L8k6g6uRBVflvTrBMOYCs4Gf3PSHbT2FOwdbSgI5/t4c+3JVkhZgWD6jtOeFgMJuQdR1ShYo/eTjTJ2F6wL+rQMgZ4lzhnxnPtC4YiblUY9W8xtyMNxu7BiQDMplJvYAsNMC8V+fDbptB3vtgwpzgA/K12Kg1T9vn9zCcyNootE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 28 Oct
 2022 08:04:59 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::bf6b:5ddd:be09:a1e0]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::bf6b:5ddd:be09:a1e0%5]) with mapi id 15.20.5769.014; Fri, 28 Oct 2022
 08:04:59 +0000
Message-ID: <0d938c9f-c810-b10a-e489-c2b312475c52@amd.com>
Date:   Fri, 28 Oct 2022 13:34:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC] memory tiering: use small chunk size and more tiers
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Jagdish Gediya <jvgediya.oss@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>
References: <20221027065925.476955-1-ying.huang@intel.com>
 <578c9b89-10eb-1e23-8868-cdd6685d8d4e@linux.ibm.com>
 <877d0kk5uf.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <59291b98-6907-0acf-df11-6d87681027cc@linux.ibm.com>
 <8735b8jy9k.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <8735b8jy9k.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::22) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|DS0PR12MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: f17c82da-a297-46b0-e300-08dab8bb1b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RgSdbgY3CBzmKiFmcpbdqvRsrOl2ac+2ULkBYab/O2JnmddYUr+0SSBo4WlfxvH8IIOo3KdfOqMKf3b/zpPbpOKpVQnuJOY8xS8hWeqykXTUE/Z//YXwS8njgI31TxIQZ4p0JBHZRlEGg7jHVL5GkJTcg1u2xJm0IORLWM8vCtD25r1mqnpi44MerchHbhMauLwrnM0l48Tu2lf7Tw4yebD7v2TeDs/+S+mH7IeaC6O4/MlMcf9Wu2MpMUNoIwSvqMmlhLeBXJ3Dj/gH6bBcpFVdoETrSqRObsZck2wqvmbE9xPIfXRDuffjR2lk7VHVwGQU4QhuX6WtGu3ZhB5JqJddmyJrgsR1CH+jqVLjbaHaZLWARGVP1PzBO4cREyf6kIEPEjqAaQPNBhH1IRkdTBbdMMfUrHnOJL84dEVX8kBDd1xLXlTFZV9bdmNy9l9QZyyiIzWXaMSQRqgYdt0aByx7tYQ7pxoqBf+S+FIINECMORscZm/UT7Due+nfk6Y3szyOYmZjsLRgXKGEmT7P3cqeJfpI9Dxh7C+4a5Lk/OokKRjf9R09qdJaRU9yqcA+bvq4upf3AKUCapHkTFsJ/OpIUlDnReCkuoTubRN3I3v/DoSxKJjFjz0HnvcTAXc7I6CMLJ3fc77a2y826rd3xubjElFAHE9oJ2BQWp0VvL5JB1cZK2DtVZSipqobL2ocu5H3X0nLpwi0hm+TVcEY6buPZB8qg7raVCH912RfbyRQh8JQcE5LLiNrGWVjpMi58Ch5W53Fdw1ODZRafqewMzK9FGct2VDWwQwWAeHl2L0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199015)(186003)(5660300002)(83380400001)(2616005)(86362001)(2906002)(31696002)(53546011)(8936002)(41300700001)(316002)(4744005)(66556008)(6512007)(66946007)(26005)(66476007)(6506007)(7416002)(4326008)(6486002)(478600001)(38100700002)(6666004)(54906003)(110136005)(8676002)(31686004)(36756003)(66899015)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTVYUXRnKzlRZVpweHB1MjF4eFhxS1c2SUYvSU5IMy9EL05vMWlhNlBiQ0g4?=
 =?utf-8?B?WlQ0elZCR2tLbkJVc3NEQm92NmlKeTF0Q0x5QVdEaThLNktTSDl3WkZKT2wv?=
 =?utf-8?B?WnAvS0JFM2ZES0hVMDZ4eDY1UFMwb2o2TkwzRGFmTS9IdGFNOWswY1pIWWlU?=
 =?utf-8?B?b3dwQWhEWVUzNS8wSEo3OHpDWDBmYy82ZVdJYmhseVRXVlptWVdCWC9CT2pY?=
 =?utf-8?B?emgrMFhST0FEK1VGNEV1NG1GeWpUbXJqbTlPOGRmSjlYMTFmVkk1L0t6bFBD?=
 =?utf-8?B?bzdnekliK2ZHTGdIOFFiYTBHSk5CQ3hVbk9RTDBTRmZTWG45RWpybEtRNTM4?=
 =?utf-8?B?VjArVkRIZTBKYzlHMjI4ZlZ2TnlnZS9QelJJbE1vVXV4VDZQbFo4QUc5a2hG?=
 =?utf-8?B?VHpuWWRLVE1uOHU3ZkRwWUwwSVRXT0tocFFyUElaL3dybHhabkxQY08wdXNT?=
 =?utf-8?B?YVhOQW1rc0VJZU1KUVhKT0xXdkRUQkxkM2FvaGpCNi9tU3ZYTU15a1VjSXdh?=
 =?utf-8?B?MitpUUkvc1FHNktsYUJuTHpUbkVXeUZlQUw2QkZCeHo3bmt6eHNQWkgxZDJC?=
 =?utf-8?B?a3R3eGRYV0pWNVBubnhsY3BSZGZUMkhDN0kxZU55dWhzZWRtamkrVnV6S2Rq?=
 =?utf-8?B?MlE1SjVvRHpBTmRhS0hQR3B6cFlhTXE3WTdDdEsrRW1WZk1VdmpwTlM5K2FD?=
 =?utf-8?B?azA5QmgwTFFlamx4UzhVVHRmK2trVktJcUxvYTdqUk5TVDBVOTN6bE1QT3BM?=
 =?utf-8?B?bVNLbXUwc2JPU29XWlZLeXQxaXlOSHZ5ZjlOZGQ5WlAyZ3VrckozYlkxcmtv?=
 =?utf-8?B?Q3R0RnplRHlOR21hTE5Ka29kaHpKWHN5c1ZjenRUUVdyL3pyV05aYUVlZk5s?=
 =?utf-8?B?dEVGL0xkSHMvKzRIR0JjRkNBYkdKd0MxNEVCSDBmRGdXb0x0MU9yMzB5VFBS?=
 =?utf-8?B?RUpiZi9zTEVGeW1jNTA3WHYvdzZVbVpWaTNEZWNYRE4wU1FCZkZwL1F6emhX?=
 =?utf-8?B?TDJGajlqQVZYcjVKdUFuOVVrYVNVWTN0QWdPMzhvWEdqZXk3QS81eXM4WE5h?=
 =?utf-8?B?anVSS0dIdlVjS3o2Ujlsc095bjFabmEvM3Z0Q29CVWRNR0sxeUFya2c2bXdX?=
 =?utf-8?B?RGloYldIVWcvcjRkMlJDb05EMnlSbVh4dldRNm44YnNGS1pCT09OR1VIQ2hD?=
 =?utf-8?B?TUhxeWxFcDErN3gyaXp6SnlDTVNJY1V1YTFhREd2QmlOdy9UNWNuZHhLYitT?=
 =?utf-8?B?dk1QTFZCSEdhcmd5NVdlMm0wemp1T1BwVjhiRm0zRGRKS0RKUndJaEFZRWxC?=
 =?utf-8?B?MXEzRE4vQWF1VERjUEJhbG1BMFBZVkhtZmFWTGNjdkF1VzdDOHV2cGo3ekM3?=
 =?utf-8?B?Z0VITk5XWG0zcTRNYXNwdGhpWWpXMlFJaDBmWDZrUGF2S3RFWXo5K25JaVc0?=
 =?utf-8?B?Sk5QUWR1U0dWQ3J2d2FLR2RmN2RsdWptNWk4dlBLMVhWajdzdWg1c1FFRHJy?=
 =?utf-8?B?cEQxMEduRzBEZWdiMFZIQlhPZTB3V09IYnF2czlVbmRkR2JDK3kzUG1uc0gy?=
 =?utf-8?B?b3VBUllaOVcyOWVZeHpqUE1Wc2N0R0liaG1ZaytqRURBWmhURmJOQVVES2Zr?=
 =?utf-8?B?Z3ZNc2FQd1lNUUtzR3VVcEJnN1l0aitpdXEzY001RUNDZ1ZtcTBmWHFqWFVH?=
 =?utf-8?B?MkNHMWZwWW5YSWlwQTdzV01MWFU3ano1Y1FMZTRXRXdHODNnckFYUXJRSTUx?=
 =?utf-8?B?ZVhTUis2LzBoZTFVcmxPZmwrWnNLWnRGSitXQUJOUWdGMm5QN1ZBWVVxNVhF?=
 =?utf-8?B?VVgrUDVINk1yNXRJNmdsMUVIZlB0dDhZekQwVS9tNGswZnNzZ3d6TjFSc1V5?=
 =?utf-8?B?NS8yTnhKZy9qSVRSV3ltNUhJSUM4a0dBOXBKdmxQRlJxajlDYnVGZXJDMXo2?=
 =?utf-8?B?TzhzTUdVU20ycGtWcG9NdEJaL2p4YzNBM0dBRDhGRHpleHNQeHVXb2NtMFZr?=
 =?utf-8?B?SmVIdEV4MmtmMEE2N3NxSmxObUxwTXlOMHF0QWRYblh1MmMyNGpOSjdFZUJD?=
 =?utf-8?B?VG4xVlhEUjB2eEdxVTlGdUJnRUI3NHlSNEd0WmtRNWtLU1NKM1h6MkdWVGRJ?=
 =?utf-8?Q?8ZEDlow/85lAwnCSA711L7XXC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17c82da-a297-46b0-e300-08dab8bb1b65
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 08:04:58.9558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUpCI6ty2QvJ4GiB1VYwWFxmNjnG2KTRZkZIGhcIFMyJ+x06f5SdWY+mWOGI7f3UOq0nEnpLoblZ7BNGSO2Fcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/2022 11:16 AM, Huang, Ying wrote:
> If my understanding were correct, you think the latency / bandwidth of
> these NUMA nodes will near each other, but may be different.
> 
> Even if the latency / bandwidth of these NUMA nodes isn't exactly same,
> we should deal with that in memory types instead of memory tiers.
> There's only one abstract distance for each memory type.
> 
> So, I still believe we will not have many memory tiers with my proposal.
> 
> I don't care too much about the exact number, but want to discuss some
> general design choice,
> 
> a) Avoid to group multiple memory types into one memory tier by default
>    at most times.

Do you expect the abstract distances of two different types to be
close enough in real life (like you showed in your example with
CXL - 5000 and PMEM - 5100) that they will get assigned into same tier
most times?

Are you foreseeing that abstract distance that get mapped by sources
like HMAT would run into this issue?

Regards,
Bharata.
