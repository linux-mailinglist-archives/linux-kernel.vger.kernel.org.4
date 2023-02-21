Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1937069D792
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 01:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjBUAiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 19:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjBUAiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 19:38:16 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D281ADD8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 16:38:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbgSsKsZ6ZxX2eGGSn3DXivFUzK3kRZ/F/J1NtH3oQP9TVkj9bRL8MY+rJgdgsgx7fF3XS2wdL8yQ9mDPhsPcjIYqd6Ri8RAqysAykNJ+PZNhPo+qE27rM8ThC3U5LqykLeaLN3tjlMMD8G46ZT0mxU99vdVmMpoco88/gc+pUSPOwHb8/pbTJae3i5is23kjcvYHcTZSdEXW3vr6ko+xsyGwGITQnboO6vboGPWuZb7P7CeLqfnyMgAdKFEQQ6jbuEfZ6yKKJAVD1sHKJ/3EaSCyV+AOtzZUJdEjv9I4Jp+q3aI1Hy+1binXI50CbFoITbTPdmtolD+86hqf0LhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9+9QKuHekKtvrHrQeI+UaAcrscgJQKsLjZTq7MO2wA=;
 b=LOgFej05341AsW2yOkuoi8Mq5ukzsvakRviDMqitVDXJK8cU3Knyc90hCjugPlwhtYzq1WzwY6Oix2N8uZwNU5S24A73X77Z1igV5Z2xesPERPeVHp1uCo8853GDqYQVfK8y+tU4rwFlatjRmXxFD1cPm3j96vwZQh1xN1kb8gmgr3ur/NU9VNCzxm456mM8ZHxikLwKzf+rcbH0odLPFmGet5QlXbZi3FltyuqnV5jcEI++SkKvtHZBeoN1LiDvNNIGS8fHhKqNubuufDe7mdDoyAaT55WzSbuJZ3FLvhwPHC77Ng5VqISJjao5PCaK8+yR3FlRRgtt14XqXxpAlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9+9QKuHekKtvrHrQeI+UaAcrscgJQKsLjZTq7MO2wA=;
 b=1p5N8Jb8pHBM1C6je/LkKgiOnZOoUfR+lVI1P1536+hyLNdR7Y4nz0UOWu8rVq3WtO9B9f2p+2Rb0jElp42mR3APuivKzBoFTE8CrXBEI17KBInMsCCSP8MnF5hrcjV2b6HYV73Y9xCw7QXxSkR7iw1/RBen7fhVxrTD2mLe5mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by CY5PR12MB6622.namprd12.prod.outlook.com (2603:10b6:930:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Tue, 21 Feb
 2023 00:38:13 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::dc5d:6248:1c13:4a3]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::dc5d:6248:1c13:4a3%7]) with mapi id 15.20.6111.019; Tue, 21 Feb 2023
 00:38:13 +0000
Message-ID: <3f6624cc-2f7e-f830-eff5-173548d529e0@amd.com>
Date:   Mon, 20 Feb 2023 18:38:08 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC PATCH V1 1/1] sched/numa: Enhance vma scanning logic
Content-Language: en-US
To:     Bharata B Rao <bharata@amd.com>, Mel Gorman <mgorman@suse.de>,
        Raghavendra K T <raghavendra.kt@amd.com>, mizhang@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        xu xin <cgel.zte@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Colin Cross <ccross@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Hugh Dickins <hughd@google.com>,
        Disha Talreja <dishaa.talreja@amd.com>,
        Sean Christopherson <seanjc@google.com>, jhubbard@nvidia.com,
        ligang.bdlg@bytedance.com
References: <cover.1673610485.git.raghavendra.kt@amd.com>
 <67bf778d592c39d02444825c416c2ed11d2ef4b2.1673610485.git.raghavendra.kt@amd.com>
 <20230117145951.s2jmva4v54lfrhds@suse.de>
 <933d1843-be6c-cbd4-ffb2-b0adcbeeccd5@amd.com>
From:   "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <933d1843-be6c-cbd4-ffb2-b0adcbeeccd5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0065.namprd07.prod.outlook.com
 (2603:10b6:610:5b::39) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|CY5PR12MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: e3faaeac-aeb3-4b2a-35b7-08db13a3e9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Caw1uLql2EZjUwF/F+XcjViQB3g+hQjVw6jRHBzX/Vw9nhYdZRV50uEHfjpWgOjE5JFjURqlr8viLqu1Ju4FKuFOBAwHkZo71EGVtrGrJ79VEsSnkahw6P+y+naiu3CYJKFyaEUsOjaTdwXyMBoWqlZZrZB7gjrskjUzWKyoHx+j81UkLHp9V/QFZBQtlBPipTY7T+RyBrzItpuvSMDSeesCwl3Ctlca9hIeLUI9qn/SWUDeR2UBUbeANSJXmhyc6n7Z47T441fDXieqTs1Ohfu8SCN2NNfgbFEgXjoKcB3oVdlEpoZTaQOR3L2qcsiooV9ef282q6POHxRf4/087zfcLcklTujYT3L5sNJ0UyKufP6/IlHOY/DK4VyTb010e+EHWBRW8UGV5qnwlz9plV/N496HzA1Cgk6I910+6BUsCF0Yqrlr6Vfh9xXehOzhhBkyobAinrsbhYDyIIlVpbXnS8pw5DegbsJeXrQQS4mQYxU0DjpCtSSXNjIu3/VUF1EEhnlCELwAeHKajo6Q/QWvQ/N7vfOsakNtsID8+tjqfFGKjkG2VKGDpEIMbdcvWH/Na4atFp5TUY/KuhE/BfJJ7x3AJAtKi7kFZ8sp2cMXqyXV9SDBJ3iS9BRy3zAtCcqTryV1xbIibNtqhdr5cYlJm/oYnPebOENEesMntiDqcfkTS32jS/Dg66TM+Yw6ShbXGnWwuV46838k8TiP8aE61hocSeKmLDjvl0zrtjVrRQUugPvLopbxRU8mLTd80yxQy+8ESC7Y7xvvVVJq0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199018)(31696002)(86362001)(36756003)(4326008)(8676002)(66556008)(41300700001)(5660300002)(966005)(316002)(66476007)(110136005)(7416002)(54906003)(66946007)(6486002)(8936002)(2906002)(83380400001)(186003)(38100700002)(6506007)(6666004)(26005)(53546011)(6512007)(478600001)(2616005)(31686004)(66899018)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnZ2eTlNQ0dIZ09IendnekdrQ2RBd25BZVNCdjk5VFpKb2R6MngxZlhyNUZG?=
 =?utf-8?B?RllwM1dpaDE2NWVLTW4rdzZ1ZDgvWXZGeTRVbWc3TklXL3BOaDFWcDZwUjcw?=
 =?utf-8?B?V3p3OTY4T2Q0alpJRzlZQ1k4Z0ZOZE45RXJLd0FxZ3FtTVFtQ09Fc3QzcmFR?=
 =?utf-8?B?Sjg3NFh5VkMxckMvWmJJL3RsRms1QnFCcjJEYllTNmpoMjhKbEREekxoZ2VF?=
 =?utf-8?B?dWFoNi9ZMnlLbkpJNEZ2WWpBK1VWYU5NVWNlSkZMMDZPak1IY1VmNlJlREd2?=
 =?utf-8?B?Ym9kOG93OUhYM0kxWHUvb3BIS1A2dGpZM0x3WWl0a3dPMUhXR2ZOc2xxS1Nr?=
 =?utf-8?B?L1loWFJaQU1CcXRUYlNLelJ1ZEZUUHdLSFhTZHpQSFFPSGdKVzN6SmhTWlAv?=
 =?utf-8?B?Z3ZBMjRiemp5QTlnbVNXU29hZmZjck9VZ3BJeTlMcmRiQ3h6SXVQWUViMmpx?=
 =?utf-8?B?dHFNeVNRL0swRHFZaFFhNlF5YllkdmVwcjJra0ZGZWZRMDl0VHF5NGxxanFa?=
 =?utf-8?B?c0o1ODNwaHMrb2paa0tPRTNPaEt0UDA0Vis1czZ0NUJLZHY1MmZ5QlErWXBq?=
 =?utf-8?B?bXVKMWcwMWQxYi9nRWh6N1pEc1N2ZGZ0cVJhaVZLNG9yTWpCcktzaGdteEpG?=
 =?utf-8?B?U01pQnFrbHRtZkdxTGpOV2U3ejlMaUhhVDMzbmRvdDRJcDhUY2h0OTh3K3cw?=
 =?utf-8?B?dTdVaTd3b2Z5TUNaRXhkSVVFWGRGb3gzMDZ4ZDhJN2Y3TEpRUDBSYlN6WGI1?=
 =?utf-8?B?OWZLN2xsaGFIMkZodkF4MnovcTVVdGNDYzFLOVdmNEVZeFpidU1qNHR6N2Rw?=
 =?utf-8?B?RXJDZ3RMY1RZS0M3cnNiZ2tGOXowVlJSdTNUajdMMGVvSjJoeER0c05IV1JD?=
 =?utf-8?B?TSswbGxzQVpxYzNUWjdiYktmeWlobUVUaWVFSHdqdnV2Ry9HbkhHM0UvczJE?=
 =?utf-8?B?a29JSDRRTWRSeWtjQmpSRUxXT09pQ2RuVWZnVTY1ZlJJS1BvVGNDdGZVOXdS?=
 =?utf-8?B?UzBRQWdueGtJZFZjbFJ1VDkxcXF3bC9EeFlIQy8zZ0ZaTVRYTWIrejd6RzBD?=
 =?utf-8?B?RkdVeWJ2MzBsaHZXWVVXa0liNDRHdDVLM1FqOWVzTUVucm14RXlzTlJZQ1Rj?=
 =?utf-8?B?L1lFUlk5SlNBMExhSUxXUjRXcUJrVEZ1L1JTaXdrdGsvWSthUE9rWjhUMjlP?=
 =?utf-8?B?VUVaQTBHRXBZREZpMnNHcGRXNUZBOWIzMVlHQXlkZzRSMFZmSmdKbFpraysv?=
 =?utf-8?B?Y2xqcHZSL2lYSmxyUlJsOG43VTJPUlpWMTlFMGFkNlFsUFZQYVoySi9HYmpx?=
 =?utf-8?B?VGRUZDdWYUYycktDYzJHdkhSay84ZUk4cDFHMVI2NG1HRjNObnlmcm9Bek1K?=
 =?utf-8?B?elJzZ3p2dzlrZlFPYU1vVTFhbE9BSFlLSDRkdDV1bUxGam1wSmZwb0c3QTZl?=
 =?utf-8?B?NGdoY3lrNTZWTEU2dTluOGh1TFFuVit0N2tiTVhCekNHMFFYWlhJdmdKeEpJ?=
 =?utf-8?B?UnJIVFcwcFRJTUpub0RFSXlQRlJsWTRrZk9iUFN1Q2pnNjdKOG5vTm9yTkY0?=
 =?utf-8?B?YXptRS83Tk5FWVhtTGNKaTRQc2VvR1g5cW1qcU9FU3BaNktyT1R5eHBpek14?=
 =?utf-8?B?YUVEbFB1cFEvR1NnRFYwNkpTenJyQ3dZUVUwSE8xcG1aTVFrWHlCUDl1RFNF?=
 =?utf-8?B?Uno0QVZSVlJlU2hrQm9DenBONFMxbDhQUjNIOE1tWnJzK0Z4bENvM0c2bnBD?=
 =?utf-8?B?TW1zeDlxVDdPeXAvYVcyQStKWTcrbkFDQkcvdy9EeDJEcG80OUMyTWtTZGtQ?=
 =?utf-8?B?K3YxR2dVcHQvWEVIYk5rU3dVUGZjYkh6ZTQ3ckFURmVEU3NGYnR4M01BdW1T?=
 =?utf-8?B?WTVIQ1QzRzBkUVdnSmwrS2tnbUVZTzVMS1FLeC9vcjJKWlJkeTRyWjc5WnNt?=
 =?utf-8?B?VzVhZTdhZUxGa3VNTkRZL0FTYmxveXdWUzJuR2QwaVl3QkZHcHRFQ3FJT2F3?=
 =?utf-8?B?YS94T2h0eXNFYU56cmpkUTNSbkovem1qSUVXdHRkeFFUOEt0MnlwYTJ6SmNy?=
 =?utf-8?B?bFNzd0FhRTE0dUJHdm5LL0JnbWk3WE5sTS9lZXJpVkVvQVZxU1B3S21MVWN3?=
 =?utf-8?Q?jABFTdPm3GAMI7KIE7Ho0+Mw2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3faaeac-aeb3-4b2a-35b7-08db13a3e9ce
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 00:38:12.8603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3hO930GNgunKge5OP6RbzATg9nIw0fayvJiucKpKTkTncesbRzDbjlIv1Qv1jTb19vki65/CyAutduWcGF7Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6622
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mingwei, Sean,

Looking forward to your thoughts/feedback on the MMU invalidation 
notifier issues with SEV guests as mentioned below ?

Thanks,
Ashish

On 1/17/2023 10:43 PM, Bharata B Rao wrote:
> On 1/17/2023 8:29 PM, Mel Gorman wrote:
>> Note that the cc list is excessive for the topic.
> 
> (Wasn't sure about pruning the CC list mid-thread, hence continuing with it)
> 
> <snip>
> 
>>
>> This is a build-tested only prototype to illustrate how VMA could track
>> NUMA balancing state. It starts with applying the scan delay to every VMA
>> instead of every task to avoid scanning new or very short-lived VMAs. I
>> went back to my old notes on how I hoped to reduce excessive scanning in
>> NUMA balancing and it happened to be second on my list and straight-forward
>> to prototype in a few minutes.
> 
> While on the topic of improving NUMA balancer scanning relevancy, the following
> additional points may be worth noting:
> 
> Recently there have been reports about NUMA balancing induced scanning and
> subsequent MMU notifier invalidations causing problems in different scenarios.
> 
> 1. Currently NUMA balancing won't check at scan time, if a page (or a VMA )is
> not migratable since the page (or the address range) is pinned. It will go ahead
> with MMU invalidation notifications and changes the PTE protection to PAGE_NONE
> only to realize later that the pinned pages can't be migrated before reinstalling
> the original PTE.
> 
> This was found to cause issues to SEV guests whose pages are completely pinned.
> This was discussed here - https://lore.kernel.org/all/20220927000729.498292-1-Ashish.Kalra@amd.com/
> 
> We could probably use page_maybe_dma_pinned() to determine if the page is long
> term pinned and avoid MMU invalidation and protection change for such a page.
> However then we would have to do per-page invalidations (as against one time
> PMD range invalidation that is done currently) which is probably not desirable.
> 
> Also MMU invalidations are expected to be issued under sleepable context (mostly
> except in the OOM notification which uses nonblock verion, AFAICS). This makes it
> difficult to check the pinned state of the page prior to MMU invalidation. Some of
> this is discussed here: https://lore.kernel.org/linux-arm-kernel/YuEMkKY2RU%2F2KiZW@monolith.localdoman/
> 
> This current patchset where we attempt to restrict scanning to relevant VMAs may
> help the above case partially, but any ideas on addressing this issue
> comprehensively? It would have been ideal if we could identify such non-migratable
> pages (long term pinned) clearly and avoid them entirely from scanning and protection
> change.
> 
> 2. Applications that run on GPUs may like to avoid the NUMA balancing activity
> completely and they benefit from per-process enabling/disabling of NUMA balancing.
> The patchset (which has a different use case for per-process control) that helps
> this is here - https://lore.kernel.org/all/49ed07b1-e167-7f94-9986-8e86fb60bb09@nvidia.com/
> 
> Improvements to increase the relevant scanning can help this case to an extent
> but per-process NUMA balancing control should be a useful control to have.
> 
> Regards,
> Bharata.
> 
