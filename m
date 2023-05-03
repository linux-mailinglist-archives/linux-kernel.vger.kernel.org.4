Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287246F5D2D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjECRmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjECRmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:42:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E8E19B5
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yt0F86TP/Pe/rdQABtNqdpxaPElAXshaJFxY5L5mvgkc/PglzwFujns6X28so2RL9sXBVw3DqYoUCw7G6mWrNx6Ws4mdxkxYGT44T/aQ9rgSwg4FQOZWBaBnJ4DTNSDgkuiBzGe3YRGJTes0wIrVoWh2/OvLhW/MTaxvSemD07rzp3qOsKUCOfOJPTai5WNyWG430C0nlAJr1jKhgri0+fnCpgSziFJ1yuuiNAkqU2qh+GQ1og2ce1PZijKKw+mavXbDYZkEz8Zq1QFhFujJiEIei9Bt03fh4VAdj9kuqIh52XHAffWcKYkiH4/NILFbPwkSgFKpD9FwtREcOmpPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myjK3wTqhg95ttiAz29KEF16OVcy41BN0OCKlwt95JA=;
 b=JHwi/L/bEwuSoNvp/rvDyDan29ZUOcEOeMMlRHVpK17ZbGsUKphLn757D9rZTZkisQU+GHvgvHlwQHSblMqt5iDqZs9B1+bzu1xag/+8+/+gM0L4vHtuOd798ob8aANNvDsiL+ZNisqwE+F40hzuZZHiBnsGEn1pFEkArXpbgdOBjldvoN18SbITvrFZqg/wMx7+qTYqKMaicsmhOSZJXqSUrDYz11mB0qVyFPtFIVwUUABbHUos8K/d0ftfVB3ezSPeCy24KsxE+sOiPQy3Y0LZ//iyhxbnTerQfWI36TObUqndsK1Za4rl7eJUM8qeH0Z2ZT/FNG0FrFU/VdxO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myjK3wTqhg95ttiAz29KEF16OVcy41BN0OCKlwt95JA=;
 b=i74KM0Ya37lbjERdYJuudZNJ6CsUdet+BmpS+troZ2fXOZ4sSgc8Ymh5D5Ly7+nAjW82TeQO+laLXwYVvh/rCGPDmHg0vxu+dGrvLAiqZbc+dOcQcblCkj1HxeBYe9kp0SPLOolZgxOHZzrSZvl73Kfe3i9n1/SnGQf8SJcpqn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by IA1PR12MB8493.namprd12.prod.outlook.com (2603:10b6:208:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 17:42:45 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::13fd:6611:29cf:a351]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::13fd:6611:29cf:a351%4]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 17:42:45 +0000
Message-ID: <8213bb71-9924-4f98-eb85-1a3d6401c0f6@amd.com>
Date:   Wed, 3 May 2023 23:12:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH V1 1/2] sched/numa: Introduce per vma scan counter
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>
References: <cover.1683033105.git.raghavendra.kt@amd.com>
 <abd037023141f25f79c6bbbb801c8405e4c449a1.1683033105.git.raghavendra.kt@amd.com>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <abd037023141f25f79c6bbbb801c8405e4c449a1.1683033105.git.raghavendra.kt@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::20) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|IA1PR12MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: 6576e3d2-aff5-4658-9690-08db4bfdcd6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zcCR9ujutPSLbgrqxAICkWtEJqIH+zhLEdI0RxWTqvYJotPu9/gyaWGA4+TthtG63BmXCkfGfCah0raRY0t5vvMvQcUu4enElfUovzicHDCAGyNBhW7IYWux5jrHvTfWOwUcmEOLNDjL2xkcZkkUbyHuY7VSd/+tPQ4shr6Coxxn7329l5fYSqKyddyoULqJj8kHbhAU4fZdV9n+lBhHcWUTF3YF9mxX4wma0y2RDO3C8X2ZbzXUVPciyOEg2/dUQmRjOD8RhRsB9duSMqtnsyaZXQAamq4rqec4I38jEnNZZoXI4V7QVXjqg0wZ7LHtjTWzC1v04NldS9p6MSRvodHrokn9bZLkuvWPX8ldQg+HNXOvuUuT5yFBS+T0nSOn/VqX9Jv/tV/Q5uN18QrcwFGNJ5hg5vmZ6tY51R+m0Ddof9iXt9FbOEh4V+GxSJ9U9l46xycrfCraWyS+R0seU5Hmqk9VJvFOP29JAdVCdvdm6PIKBA5hpfb2fsHu6LZIh9yRDdOZdpvdeiuiePgFS/VyixrbAkDhVvaZ8uNnKdAHvdbyd3G7otsBBXCo2sWsnkd7jjHIynBUrjccTk9plUCO8f6OePA0deRNnuBW2tEreiEWaRtVzD4uMqNUqWJP8x8FgC67EIab2TyGsVbbxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(2906002)(38100700002)(83380400001)(2616005)(26005)(6506007)(6512007)(53546011)(186003)(36756003)(8676002)(8936002)(66476007)(5660300002)(7416002)(316002)(31696002)(478600001)(4326008)(54906003)(6666004)(6486002)(41300700001)(66556008)(66946007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um16RnJaUXIwSzdnaTZ0U2xmYyttQ29NTHJGN3crOE0ycG9XeVZ4M0lNVU5V?=
 =?utf-8?B?MURzQVBiRENRdC9sWU9yam9nWjhJVFlaSnRQc3VMWjE5UUgvalpISktUbEJC?=
 =?utf-8?B?dnQ5aEs3MitsTERadGxBUEJGRHlnUEN5N0ZZVDc2U1Y4TzBZZ0lhYmp1RXN5?=
 =?utf-8?B?R2E2MkhvTkhSaU5TZkZiUFl4RDd1TlZKTjBJSk14WWVIM2syekxMNTBUcDhj?=
 =?utf-8?B?UGZWaXM1Y09OdkdCMHZiM0VMZENGTlAzQm1xSFhqUTdiZ1c4cXZSNDl1MGFQ?=
 =?utf-8?B?OUIxQzNXV0pTMTYxRnMxTVdldU9zZTdvWVpJdkFZaTIrMU1JT1FHRjdXQnRQ?=
 =?utf-8?B?TldTdHNrL0Q3c1Z6eUNLMU12bXgvUjFzdzJZL3pJQ0hqM1M2bk5XVDJyWWhS?=
 =?utf-8?B?TWpDOExNSWdBWllWZEpkUndpdndPL2lKdEZGdG4xbWZDVTVQc00yWFhwaTVV?=
 =?utf-8?B?SWt6VmVVTFY1bXgwODViR25HcmN5cW9oVC8ybVBmSDQ2NzZZdWxYRVRva0dF?=
 =?utf-8?B?clI1QldGMTVYVlo2dmNHRzloME8zd2JCbTZRNmJ0c3FkaDBraXc3VkVjVnJV?=
 =?utf-8?B?aTU4ZnRXMERJcWZ2RC9VZDc3dWdJOFQwOWUzQndqblpvK1VRaFlDRGtvQkox?=
 =?utf-8?B?MTh0RGcvYnovKzl5KzlHM3pQY2VMTWpqMFYrZ0kvZzF1R3BzQzZzTHdMb3ha?=
 =?utf-8?B?T0crVllxZXd0R2ZmU3Yxa2lvMkxOeStIaFk4MFNKbXFWOTh3OVN2VnEweFdV?=
 =?utf-8?B?RGdicmQ5cExET3RnYllOeWRONjkzNFRRbjhSckdVWnBPZjRBZGFiYUJ0ZDFz?=
 =?utf-8?B?SitzaFRrOG1xb1AyRkhXOS9KUm11bDhwMFBEbzlTMVk4TUQraGVIb3B1Ym5i?=
 =?utf-8?B?dU5SYzVvSk5GS010K2tqaHFMVkthL3AzUzI1dXBQRzF0LzBXTEVjZkd0MEtD?=
 =?utf-8?B?eVFiZllUNndMUnpNY2NEWFR6UWtqN3JseTZsWWgveU8xTFhZRHExT3RwdkRn?=
 =?utf-8?B?WVd0WXNjNEhKcHExQWNEUk1UL2dWaVloSCtsclRXREtqY0NPUjlFWmZpSUVC?=
 =?utf-8?B?SGNjWkl2MG85YkZWaGprTWx5cWhSK1VCWFlnY3hucE5aMHVOWW5pckRCOTQv?=
 =?utf-8?B?QkVSYVNSMXg2N2VadEIzaEF6alBmUGpwZTNzYzQwd0wrVWovRGhjb1B1ZFlo?=
 =?utf-8?B?Z0dTcENWMUoyZW9TMnBkeW1zRWZISzNpNUFuTUNsbGI3ZHgxVXBCRVJPcUtU?=
 =?utf-8?B?S3ZKWFpMRmpuSjFEMExUNjc0Q1J1Ry9BUUZQUW15elE1UmpaS2tHMnREVmw5?=
 =?utf-8?B?MHB2WmJpVTBIeUN5SjNCc2M3OUxmS0I3V0hEMW56QU94aHdYOCs4cUYvRU8v?=
 =?utf-8?B?UHFSYlJFc3p2cHhRUzBnUmwyRnpESEMzZlo5MCtiazZqRjd0OFpNNzE5azkz?=
 =?utf-8?B?OGczU1o0NDU3VTdaMEh0YkVSNFFCRlRFd2o1ZGNMWUhZaEdWcTlOSjh1bzBJ?=
 =?utf-8?B?a0tQRXo0bjZ6Q3AydXVtQmxoOXZkRUo0UDRCN0IrekQwelJMbjYzcVlmT0E3?=
 =?utf-8?B?YTdBeDA2dlRQNHBLWDdCNjdwaFI4OTNhQjVReVJwMWViNkJ1MEoyNDZjdHph?=
 =?utf-8?B?Yk8wWEhKOFJJaldYVGgxZHRqWXlvS2dweUcyelFObmJ0bEtzM3NXSHBqbnpX?=
 =?utf-8?B?WmdrOUFwZXFwYnpVa2lvSkx6bUFqWlpmOVZQYnZaZHhUTGJMZk9rR1FyTUJ5?=
 =?utf-8?B?L3hpZ0tTZ01XTmdBV2I5a3lyRkRpRGlsNEg2VVpMRG1vN3FmRTdLRkRtZzkz?=
 =?utf-8?B?b0Q1SVFiRHhCL2cvREJES25FZmpmOVA5V2o5eFJOdkFVRHRGemorL2xEdDVJ?=
 =?utf-8?B?NEo0aVpURXV0K3MzMW1NMTR1a0JSWHF5cjg5RExacURNTVJEK3VLZ20wVS8r?=
 =?utf-8?B?V1RPK3FUY09GakUvS2k1QzRzZ2VFWHRiYVAxZlk5MjlVNWJQME5ibWlmV2FB?=
 =?utf-8?B?dkwvb0FRb3FYZzA5c3dIcGFLdlhSU3N6LzZ4WE9TYXBUZHVLNGczOFEvNHJC?=
 =?utf-8?B?RUdFTjdKL2p6WlZMOHRWNnJsUktVTjUyZ0tta1NsZTYvdmtaL01KQ0lEMEZ4?=
 =?utf-8?Q?m0MyYkL9y4NQinWHdjp8toygn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6576e3d2-aff5-4658-9690-08db4bfdcd6d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 17:42:45.1553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sw7AnyIX1DnLoCJuU+Kld+X/MJx8Qn26Neu/FXnwDORE8q6XOdZnwtva5ly/MyL7QYBVckngrNp2kh/2ptvsRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8493
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/2023 7:35 AM, Raghavendra K T wrote:
> With the recent numa scan enhancements, only the tasks which had
> previously accessed vma are allowed to scan.
> 
> While this has improved significant system time overhead, there are
> corner cases, which genuinely needs some relaxation for e.g., concern
> raised by PeterZ where unfairness amongst the theread belonging to
> disjoint set of VMSs can potentially amplify the side effects of vma
> regions belonging to some of the tasks being left unscanned.
> 
> To address this, allow scanning for first few times with a per vma
> counter.
> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
> ---

Some clarification:
base was linux-next-20230411 (because I have some issue with
linux-next-20230425 onwards and linux master branch, which I am diging.


>   include/linux/mm_types.h |  1 +
>   kernel/sched/fair.c      | 30 +++++++++++++++++++++++++++---
>   2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 3fc9e680f174..f66e6b4e0620 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -479,6 +479,7 @@ struct vma_numab_state {
>   	unsigned long next_scan;
>   	unsigned long next_pid_reset;
>   	unsigned long access_pids[2];
> +	unsigned int scan_counter;
>   };
>   
>   /*
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a29ca11bead2..3c50dc3893eb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2928,19 +2928,38 @@ static void reset_ptenuma_scan(struct task_struct *p)
>   	p->mm->numa_scan_offset = 0;
>   }
>   
> +/* Scan 1GB or 4 * scan_size */
> +#define VMA_DISJOINT_SET_ACCESS_THRESH		4U
> +
>   static bool vma_is_accessed(struct vm_area_struct *vma)
>   {
>   	unsigned long pids;
> +	unsigned int windows;

Missed windows = 0 while splitting the patch
will be corrected in next posting.

/me Remembered after kernel test robot noticed
[...]
