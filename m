Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D5E6D874E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjDETuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbjDETtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:49:50 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093D2268B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 12:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1/5i7YznS8RgiRkhMdRrLF9dQKb2UwnFIqP5FB7n6LIm5UvA0EUVIT2tiK+PFpQqNx254abmWwPW6PpRRD5GAsQ0cIDfdtI0E9Q1V0vdoiLEIug/0YHtlgks/8D6URNeKBWTP3ZB/1VKTjikmaEB0RURPhkJJ8bNHvQKvvFWcDAxf3QM4izxf5UeFreUmsPVBFllacHxyIYXYLawZ7zYnECC3ETD8ILD7IjIiUQdqm6eM+LAlTXbbR7U7SHj7WcWzD9NPGEj8fVfNWBa7EP5ZwmHsBAnDgFqWVTUU89qIaAp5EV6hAgTWheohJ6Uzc+HwKe5UySzSE8Zq5tZte/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTZRZOnM1ETARSe1T1DKQ0w156aeFgBcJLBIf+hPYq4=;
 b=oThj98Btn2rLl1KoCU99t+iMEaFwFQ3yQ0sXb10C2I9CwWa0Xn6b4knuW1DybY2yz/Qy06n+VsNOM++wHL6c3xL92WGKE2P4+TJy8sXdCXkKD1UDKogAbhZpQZcSVBuIcZLqkOxWgeHru5XxazassiV4JXVroR+BFjwTp+gbivCKbSozIcCI6qON2gyyBtQrkndZa+JNfJmZjla1jAYjlaX9viL0eMzZgw+YE/BrgqsqwU2KvERDYHhPRYb6eBwJCmF20ArlXmGI9hq36syRtLkALoGEXb8+RwEMronU4X7dXepv0rkOX9VEcFYVgGZTN1LpB6HSnouP9yn1klU7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTZRZOnM1ETARSe1T1DKQ0w156aeFgBcJLBIf+hPYq4=;
 b=ClMqnn1ItGgVeeVMFJRcXGhRMII1kTRMJcSFhMMIMPqQVtbmJ/evsJ4KFDelAeMOHRc6dlkTFqMnNJbrqQ6Mw5yIDb0JNFZZNP1T9CxPtyTZ+cO/AiRZo7IM7mcGNYR5VvsS36x2mg2hiPnALZ2agziwInDBXfyYwWpmHlEa8AY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 19:48:58 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::2323:bb78:a565:7bd4]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::2323:bb78:a565:7bd4%5]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 19:48:58 +0000
Message-ID: <271b85ec-281e-d33b-5495-59eb2bc9fde4@amd.com>
Date:   Thu, 6 Apr 2023 01:18:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 0/9] x86/clear_huge_page: multi-page clearing
Content-Language: en-US
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, jon.grimm@amd.com, bharata@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::10) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|BL1PR12MB5191:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa40219-08a6-49ee-57d8-08db360ecbb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hUVvmgL0EuQ/rvYJgi+neiRFUSYKTNIm1fxAyKOA30w1uF5v3liY7ULiKdYqY1Pt3RB+HLA1j/cxYi32TCtqOxwj3w8RUFW+q262maCgbQh6fyhZ5J82fiXNR1MPfaGUl0pbs05TjL8Rq/qjbFYBu8I/ZRIK2zXxRkqeAVXFpuexT0VqMiNFyFh2EWBp6UG9etKA6wQmSh7h/j83kgs4XD45PJbdKOM9DGT4uO8cAKdLs11k15uny6c0T1AJfy2a3ym+Ia9b481D/CFTitbcwrthdLoPwsJBsmdHYCq/e1zPiLEVOBGAqoxALlry0Fw/uxW5XzwcNlqAPll4vavzjKvfJb3TYoz315X0TaED2dRI6WQkirbTfuAyGE39/q994xcyM/V+YeufX80LvYC8SftG6qizjAML4JdEbHcVY8CSPhqWpZwUCWI3DMVumy5M1KG+WbmI3KwqqDURwXImgAQ0HfFUlOKIG/Gi7w6GXMr3Bd4lKWCf2l0ti3uIj2O/Y8HKu7tPoQsPqWU2zrE4gcSkrS8xVVhwMs76rcfigPF4RLLSIfvr4PWTvdI67gOYIKYMAEAmgARW4eOCHbDOqQPNlF3JE54yJyAz+ME20TEwibvG78wvRMpM8ZDQLL/vIkIsSE722u3TZwjd2aNqqQMkuyOVbeZdQjXsNNfhIhfkCxgLTG8VRNN3yPL2at1sQlktiCFU9Uq13+OEsA72tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199021)(8936002)(186003)(53546011)(6666004)(26005)(83380400001)(6512007)(6506007)(2616005)(8676002)(41300700001)(316002)(38100700002)(4326008)(6486002)(966005)(66476007)(66556008)(66946007)(478600001)(36756003)(31696002)(7416002)(5660300002)(2906002)(84970400001)(31686004)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFhVdnBxbnB0eUtzWWNiV04yQk9pUElSTjh1TExRL0hWTEZaV2tFTjNheTNz?=
 =?utf-8?B?MHROMmJGYVNORnRhSk5zQjFmUkRaQUFuTTU4NzhNZ3A1N1R5bTdaRXQ2eXhQ?=
 =?utf-8?B?MjlWdkNNMkdCa3g2RUxMRzRPMVhnbElRaU5yTEJSaXA1SFhtcjNLbXVLM0lB?=
 =?utf-8?B?RFBJb0c4SnBVeFJkOTVDSlVaSWNNZlhwRENNa0pTUitZR0NvY2gxdmJnYVhT?=
 =?utf-8?B?UTNvZHlCOThVQUhGYUhlOW5tV0Fhb2N0N2pxNVYya0xxOUJWdlhsVkpNOXFX?=
 =?utf-8?B?ZFZES3JCNUZKelM1aTlJQ0xGUUpGQ3FQcEU2M0xIb2VjdXdra1J1TmlTSWRR?=
 =?utf-8?B?YVVaRjJqU0U1bjZ1WEFUeHd3U3NEWTVXLzlGakVFS1lDbjgzeWk2aHdFUFNY?=
 =?utf-8?B?dHlaam4zWVNlUWMrNlZCNjJWblo0RHVTR3dXVUYrd2lSeHpRMXcxQjdQazE1?=
 =?utf-8?B?VzFObk4xQWwvZ3ErUWVFYk9tem92MU1LdlNtL0JQSXRTd3UzT3UwaU1kVHNz?=
 =?utf-8?B?Z0h1bUhPelg4T2x1V0tBR0dVSHYxeEx4MnhGNUlPNUtEcUNPUDZSMk5rejFm?=
 =?utf-8?B?N2wwTGZtQmNUYi91ai9NVjFrV0hoTXY4S2lsTVJlUklsR25pdmdzUkVSK0kx?=
 =?utf-8?B?QXRXRGRxN2Y0a2hTcFgrOHl6OGllNkFEaDJDZlYvSFhpYVJqYnBrQ1I3dXFa?=
 =?utf-8?B?OGxYbWtvRWpZeFhCOWpFS1dzc3V4dHZBazJ1aUtVOUJZT0VidmlmUTZ2c3FF?=
 =?utf-8?B?OUh1Y3RuL0JuNWhuV2RhZ0pMSkVHSGpDTHpFRWVybHNhdGRnTWRXTjlhSzhm?=
 =?utf-8?B?R1dadUpzVFlRNTFxU0djQlVTTjlWSTN5dWRQVDd3d2UrbWdtRjI4aGlWSE44?=
 =?utf-8?B?Z2JnMXVGaCtnT0tOWlEyZ3d3YWNZS0VjMCtvUWwwMGVoVGNrRE84d3V5MW9K?=
 =?utf-8?B?eGpOUEgyUHNuOThKWkFyN1ZXRzBnaCt6SGVRTkg2cG5WODVwQTB1UnJOdEZU?=
 =?utf-8?B?aVBNeDlkSUowNktsME8yYkthT2NVckFNOUpNTDMvL1NCK1FURDJwVWo0RnZS?=
 =?utf-8?B?SFVNbThXa1dYeGFyZmVyenN1TW1WLy9mWVo5TXhNRmFoVTd2YVFxTm1mYXBV?=
 =?utf-8?B?WVJYdWhFbW9QR2FGbzBVcmh3OHJURHJKQUhMTXBiQ3FWUktURHhNb0FxVFg2?=
 =?utf-8?B?ZDM1OG4vbHgvaE1zaEM3SHRpTTVxU1ZyaURPenZ2cWxVZEoyYkFiQ1B5YVQ1?=
 =?utf-8?B?NFBMbzYvNjZFYWh1ZkUxVjNwZC8zbTllTEJtSUhDSllVcEdMV1V1Rk1tNHRu?=
 =?utf-8?B?Yk1Xa09PRk1JL2dWeTRySG4rUVpIaWRFMEI1eWNLVzdSQndaeUdYTTFYWGph?=
 =?utf-8?B?U01uQnVMamxFRVk3a0wvZEpLWXNPV0xMRW9WT1htT0V4citzaXFTYkZGV0F0?=
 =?utf-8?B?TVByUDE4ek90NXZQS3ZIOTRwRzRrWDZCOVZVK0hXTDVackJFOGpOaHZZU1g4?=
 =?utf-8?B?elVPZU15b05BMFl3Y3g1allqZGI1MUxUeDBQV2dSVUxQNXRQdzBDcWFoYWZo?=
 =?utf-8?B?cVovZ3pERS84aVF5N3pXZ2tKaFFlQXJqYzg0K2VXYU42WkpvYXRGM2RlY1Fu?=
 =?utf-8?B?cXRjS1FPK2QwNkR5TGgyYkt0TC8wUU9PblBrYXIrV3NZMGtiQm51MlNua2tp?=
 =?utf-8?B?enc1SHQyZUlBQTI2UjRVejNnV3liM0tVNVVaV3dNQk12TGk0MkFlY1FRWTMr?=
 =?utf-8?B?N1VsYVhYTEE0SVp3N1ZsZWpNcDZrQnVXcmJ0ZDJpb2s4THlJU0lieVVZVW5C?=
 =?utf-8?B?d3hLK1lYb3dMTk9GcFJSQk00dGxPR0JFeGtNUFhQSndSUTEyc01Mc0t0cVhO?=
 =?utf-8?B?V1NpeWx1SHpKRTZHcFRiZUdlR0NKUVJjSE9mMzJQTExaUHZBeEZLWDBQTW1X?=
 =?utf-8?B?NWpUS1BXVkZnMWZKUHpGbmY2anVkeDVKMnRTQzFaRWg1dEtrL1V2bUpZSWg0?=
 =?utf-8?B?R1R2VDNtMlRYS2JpWXlqY001MW1DRUozc0psekJjT3djd0xBWXJaajB5Sm1M?=
 =?utf-8?B?TUluRkVIM0RpNmJSRk9lSWZEWC9wR1FBdnRrZklXc01GUWp1Ynd0Snd4Kzk2?=
 =?utf-8?Q?5omNBEwbKdNzM/zt54MExRD8H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa40219-08a6-49ee-57d8-08db360ecbb5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 19:48:58.3738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZIqiaykxSsFzauHTx0c2ILPifRo2FM0LrTFdX0/lye44CXogiaMg9bu/zCD9eJWVkdpAIb6sd2X/eJf+30lwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/2023 10:52 AM, Ankur Arora wrote:
> This series introduces multi-page clearing for hugepages.
> 
> This is a follow up of some of the ideas discussed at:
>    https://lore.kernel.org/lkml/CAHk-=wj9En-BC4t7J9xFZOws5ShwaR9yor7FxHZr8CTVyEP_+Q@mail.gmail.com/
> 
> On x86 page clearing is typically done via string intructions. These,
> unlike a MOV loop, allow us to explicitly advertise the region-size to
> the processor, which could serve as a hint to current (and/or
> future) uarchs to elide cacheline allocation.
> 
> In current generation processors, Milan (and presumably other Zen
> variants) use the hint to elide cacheline allocation (for
> region-size > LLC-size.)
> 
> An additional reason for doing this is that string instructions are typically
> microcoded, and clearing in bigger chunks than the current page-at-a-
> time logic amortizes some of the cost.
> 
> All uarchs tested (Milan, Icelakex, Skylakex) showed improved performance.
> 
> There are, however, some problems:
> 
> 1. extended zeroing periods means there's an increased latency due to
>     the now missing preemption points.
> 
>     That's handled in patches 7, 8, 9:
>       "sched: define TIF_ALLOW_RESCHED"
>       "irqentry: define irqentry_exit_allow_resched()"
>       "x86/clear_huge_page: make clear_contig_region() preemptible"
>     by the context marking itself reschedulable, and rescheduling in
>     irqexit context if needed (for PREEMPTION_NONE/_VOLUNTARY.)
> 
> 2. the current page-at-a-time clearing logic does left-right narrowing
>     towards the faulting page which benefits workloads by maintaining
>     cache locality for workloads which have a sequential pattern. Clearing
>     in large chunks loses that.
> 
>     Some (but not all) of that could be ameliorated by something like
>     this patch:
>     https://lore.kernel.org/lkml/20220606203725.1313715-1-ankur.a.arora@oracle.com/
> 
>     But, before doing that I'd like some comments on whether that is
>     worth doing for this specific use case?
> 
> Rest of the series:
>    Patches 1, 2, 3:
>      "huge_pages: get rid of process_huge_page()"
>      "huge_page: get rid of {clear,copy}_subpage()"
>      "huge_page: allow arch override for clear/copy_huge_page()"
>    are mechanical and they simplify some of the current clear_huge_page()
>    logic.
> 
>    Patches 4, 5:
>    "x86/clear_page: parameterize clear_page*() to specify length"
>    "x86/clear_pages: add clear_pages()"
> 
>    add clear_pages() and helpers.
> 
>    Patch 6: "mm/clear_huge_page: use multi-page clearing" adds the
>    chunked x86 clear_huge_page() implementation.
> 
> 
> Performance
> ==
> 
> Demand fault performance gets a decent boost:
> 
>    *Icelakex*  mm/clear_huge_page   x86/clear_huge_page   change
>                            (GB/s)                (GB/s)
>                                                                    
>    pg-sz=2MB                 8.76                 11.82   +34.93%
>    pg-sz=1GB                 8.99                 12.18   +35.48%
> 
> 
>    *Milan*     mm/clear_huge_page   x86/clear_huge_page   change
>                            (GB/s)                (GB/s)
>                                                                     
>    pg-sz=2MB                12.24                 17.54    +43.30%
>    pg-sz=1GB                17.98                 37.24   +107.11%
> 
> 
> vm-scalability/case-anon-w-seq-hugetlb, gains in stime but performs
> worse when user space tries to touch those pages:
> 
>    *Icelakex*                  mm/clear_huge_page   x86/clear_huge_page   change
>    (mem=4GB/task, tasks=128)
> 
>    stime                           293.02 +- .49%        239.39 +- .83%   -18.30%
>    utime                           440.11 +- .28%        508.74 +- .60%   +15.59%
>    wall-clock                        5.96 +- .33%          6.27 +-2.23%   + 5.20%
> 
> 
>    *Milan*                     mm/clear_huge_page   x86/clear_huge_page   change
>    (mem=1GB/task, tasks=512)
> 
>    stime                          490.95 +- 3.55%       466.90 +- 4.79%   - 4.89%
>    utime                          276.43 +- 2.85%       311.97 +- 5.15%   +12.85%
>    wall-clock                       3.74 +- 6.41%         3.58 +- 7.82%   - 4.27%
> 
> Also at:
>    github.com/terminus/linux clear-pages.v1
> 
> Comments appreciated!
> 

Hello Ankur,

Was able to test your patches. To summarize, am seeing 2x-3x perf
improvement for 2M, 1GB base hugepage sizes.

SUT: Genoa AMD EPYC
    Thread(s) per core:  2
    Core(s) per socket:  128
    Socket(s):           2

NUMA:
   NUMA node(s):          2
   NUMA node0 CPU(s):     0-127,256-383
   NUMA node1 CPU(s):     128-255,384-511

Test:  Use mmap(MAP_HUGETLB) to demand a fault on 64GB region (NUMA 
node0), for both base-hugepage-size=2M and 1GB

perf stat -r 10 -d -d  numactl -m 0 -N 0 <test>

time in seconds elapsed (average of 10 runs) (lower = better)

Result:
page-size  mm/clear_huge_page   x86/clear_huge_page     change %
2M              5.4567          2.6774                  -50.93
1G              2.64452         1.011281                -61.76

Full perfstat info

  page size = 2M mm/clear_huge_page

  Performance counter stats for 'numactl -m 0 -N 0 map_hugetlb_2M' (10 
runs):

           5,434.71 msec task-clock                #    0.996 CPUs 
utilized            ( +-  0.55% )
                  8      context-switches          #    1.466 /sec 
                ( +-  4.66% )
                  0      cpu-migrations            #    0.000 /sec
             32,918      page-faults               #    6.034 K/sec 
                ( +-  0.00% )
     16,977,242,482      cycles                    #    3.112 GHz 
                ( +-  0.04% )  (35.70%)
          1,961,724      stalled-cycles-frontend   #    0.01% frontend 
cycles idle     ( +-  1.09% )  (35.72%)
         35,685,674      stalled-cycles-backend    #    0.21% backend 
cycles idle      ( +-  3.48% )  (35.74%)
      1,038,327,182      instructions              #    0.06  insn per cycle
                                                   #    0.04  stalled 
cycles per insn  ( +-  0.38% )  (35.75%)
        221,409,216      branches                  #   40.584 M/sec 
                ( +-  0.36% )  (35.75%)
            350,730      branch-misses             #    0.16% of all 
branches          ( +-  1.18% )  (35.75%)
      2,520,888,779      L1-dcache-loads           #  462.077 M/sec 
                ( +-  0.03% )  (35.73%)
      1,094,178,209      L1-dcache-load-misses     #   43.46% of all 
L1-dcache accesses  ( +-  0.02% )  (35.71%)
         67,751,730      L1-icache-loads           #   12.419 M/sec 
                ( +-  0.11% )  (35.70%)
            271,118      L1-icache-load-misses     #    0.40% of all 
L1-icache accesses  ( +-  2.55% )  (35.70%)
            506,635      dTLB-loads                #   92.866 K/sec 
                ( +-  3.31% )  (35.70%)
            237,385      dTLB-load-misses          #   43.64% of all 
dTLB cache accesses  ( +-  7.00% )  (35.69%)
                268      iTLB-load-misses          # 6700.00% of all 
iTLB cache accesses  ( +- 13.86% )  (35.70%)

             5.4567 +- 0.0300 seconds time elapsed  ( +-  0.55% )

  page size = 2M x86/clear_huge_page
  Performance counter stats for 'numactl -m 0 -N 0 map_hugetlb_2M' (10 
runs):

           2,780.69 msec task-clock                #    1.039 CPUs 
utilized            ( +-  1.03% )
                  3      context-switches          #    1.121 /sec 
                ( +- 21.34% )
                  0      cpu-migrations            #    0.000 /sec
             32,918      page-faults               #   12.301 K/sec 
                ( +-  0.00% )
      8,143,619,771      cycles                    #    3.043 GHz 
                ( +-  0.25% )  (35.62%)
          2,024,872      stalled-cycles-frontend   #    0.02% frontend 
cycles idle     ( +-320.93% )  (35.66%)
        717,198,728      stalled-cycles-backend    #    8.82% backend 
cycles idle      ( +-  8.26% )  (35.69%)
        606,549,334      instructions              #    0.07  insn per cycle
                                                   #    1.39  stalled 
cycles per insn  ( +-  0.23% )  (35.73%)
        108,856,550      branches                  #   40.677 M/sec 
                ( +-  0.24% )  (35.76%)
            202,490      branch-misses             #    0.18% of all 
branches          ( +-  3.58% )  (35.78%)
      2,348,818,806      L1-dcache-loads           #  877.701 M/sec 
                ( +-  0.03% )  (35.78%)
      1,081,562,988      L1-dcache-load-misses     #   46.04% of all 
L1-dcache accesses  ( +-  0.01% )  (35.78%)
    <not supported>      LLC-loads
    <not supported>      LLC-load-misses
         43,411,167      L1-icache-loads           #   16.222 M/sec 
                ( +-  0.19% )  (35.77%)
            273,042      L1-icache-load-misses     #    0.64% of all 
L1-icache accesses  ( +-  4.94% )  (35.76%)
            834,482      dTLB-loads                #  311.827 K/sec 
                ( +-  9.73% )  (35.72%)
            437,343      dTLB-load-misses          #   65.86% of all 
dTLB cache accesses  ( +-  8.56% )  (35.68%)
                  0      iTLB-loads                #    0.000 /sec 
                (35.65%)
                160      iTLB-load-misses          # 1777.78% of all 
iTLB cache accesses  ( +- 15.82% )  (35.62%)

             2.6774 +- 0.0287 seconds time elapsed  ( +-  1.07% )

  page size = 1G mm/clear_huge_page
  Performance counter stats for 'numactl -m 0 -N 0 map_hugetlb_1G' (10 
runs):

           2,625.24 msec task-clock                #    0.993 CPUs 
utilized            ( +-  0.23% )
                  4      context-switches          #    1.513 /sec 
                ( +-  4.49% )
                  1      cpu-migrations            #    0.378 /sec
                214      page-faults               #   80.965 /sec 
                ( +-  0.13% )
      8,178,624,349      cycles                    #    3.094 GHz 
                ( +-  0.23% )  (35.65%)
          2,942,576      stalled-cycles-frontend   #    0.04% frontend 
cycles idle     ( +- 75.22% )  (35.69%)
          7,117,425      stalled-cycles-backend    #    0.09% backend 
cycles idle      ( +-  3.79% )  (35.73%)
        454,521,647      instructions              #    0.06  insn per cycle
                                                   #    0.02  stalled 
cycles per insn  ( +-  0.10% )  (35.77%)
        113,223,853      branches                  #   42.837 M/sec 
                ( +-  0.08% )  (35.80%)
             84,766      branch-misses             #    0.07% of all 
branches          ( +-  5.37% )  (35.80%)
      2,294,528,890      L1-dcache-loads           #  868.111 M/sec 
                ( +-  0.02% )  (35.81%)
      1,075,907,551      L1-dcache-load-misses     #   46.88% of all 
L1-dcache accesses  ( +-  0.02% )  (35.78%)
         26,167,323      L1-icache-loads           #    9.900 M/sec 
                ( +-  0.24% )  (35.74%)
            139,675      L1-icache-load-misses     #    0.54% of all 
L1-icache accesses  ( +-  0.37% )  (35.70%)
              3,459      dTLB-loads                #    1.309 K/sec 
                ( +- 12.75% )  (35.67%)
                732      dTLB-load-misses          #   19.71% of all 
dTLB cache accesses  ( +- 26.61% )  (35.62%)
                 11      iTLB-load-misses          #  192.98% of all 
iTLB cache accesses  ( +-238.28% )  (35.62%)

            2.64452 +- 0.00600 seconds time elapsed  ( +-  0.23% )


  page size = 1G x86/clear_huge_page
  Performance counter stats for 'numactl -m 0 -N 0 map_hugetlb_1G' (10 
runs):

           1,009.09 msec task-clock                #    0.998 CPUs 
utilized            ( +-  0.06% )
                  2      context-switches          #    1.980 /sec 
                ( +- 23.63% )
                  1      cpu-migrations            #    0.990 /sec
                214      page-faults               #  211.887 /sec 
                ( +-  0.16% )
      3,154,980,463      cycles                    #    3.124 GHz 
                ( +-  0.06% )  (35.77%)
            145,051      stalled-cycles-frontend   #    0.00% frontend 
cycles idle     ( +-  6.26% )  (35.78%)
        730,087,143      stalled-cycles-backend    #   23.12% backend 
cycles idle      ( +-  9.75% )  (35.78%)
         45,813,391      instructions              #    0.01  insn per cycle
                                                   #   18.51  stalled 
cycles per insn  ( +-  1.00% )  (35.78%)
          8,498,282      branches                  #    8.414 M/sec 
                ( +-  1.54% )  (35.78%)
             63,351      branch-misses             #    0.74% of all 
branches          ( +-  6.70% )  (35.69%)
         29,135,863      L1-dcache-loads           #   28.848 M/sec 
                ( +-  5.67% )  (35.68%)
          8,537,280      L1-dcache-load-misses     #   28.66% of all 
L1-dcache accesses  ( +- 10.15% )  (35.68%)
          1,040,087      L1-icache-loads           #    1.030 M/sec 
                ( +-  1.60% )  (35.68%)
              9,147      L1-icache-load-misses     #    0.85% of all 
L1-icache accesses  ( +-  6.50% )  (35.67%)
              1,084      dTLB-loads                #    1.073 K/sec 
                ( +- 12.05% )  (35.68%)
                431      dTLB-load-misses          #   40.28% of all 
dTLB cache accesses  ( +- 43.46% )  (35.68%)
                 16      iTLB-load-misses          #    0.00% of all 
iTLB cache accesses  ( +- 40.54% )  (35.68%)

           1.011281 +- 0.000624 seconds time elapsed  ( +-  0.06% )

Please feel free to add

Tested-by: Raghavendra K T <raghavendra.kt@amd.com>

Will come back with further observations on patch/performance if any

Thanks and Regards
