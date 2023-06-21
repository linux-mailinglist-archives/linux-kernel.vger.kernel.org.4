Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C04737ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 07:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjFUFwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 01:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjFUFvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 01:51:33 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2491BE2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 22:50:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krMYMaps+UpW+pBQ/jcDBCBQIdo08S9HxEjyF4DSiVW4lM2KaguzdcbsN4XvmeyQu5TX4HaYDzqlfmYCoAwruQKcwdGS+JkRKKm+mTXzmv8aMLBTyrieAk3kvIptAthVVREdh0hWcKO3pk+DRRX/NKd8UJYukx89tB/9CFNLEA+MnaQ9ZZjobIRTujSq+VvD5ZZP9WYXhTqeqzDvsvZev9XKBaugKbqByCBdJbEIRQDpHFcsBc5vadB7cMWwbwAgIqmCVW6/kkHmOwMc0/TumVT/OHCukmX3ShvgS4i7igI3aW7zmDqrp2IaEUbaoz8t2sYfAYoZoX4KobU0BQIJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDXNh8TGjDnKBRXAjmCMDFlUp+IKPhB8w3A8NVnGbcw=;
 b=nL+BzNsWKk2S9od6iGJKlAAHY4gAo89zbTA0TQbv8rXm3tBaiDG+F/rpRBq8XcQAgN7p6FuSDEE3gDCT1tnsli7wHXmQr+3KgK0k882UUvUJ2zn/2f4zZgQSMNxOe221XMvxKjfFUrnOQ+HI0PGYjxm1tMkkorji1ILws2twXe3CPq0OizQ/S7bKAo8jUdcwzRUg9yEn+SDmMsKVtVlSHzZQhjHpieCAKbolMj96SD7edKQmd6BpjLWUau5QlK8uCmWF89GQIrg5BPGSmsZTt+lpqaPIRRnc3afeEFa8VK94hFWE//vNX6Xq3Y+JPnuKOEM0+1SOjnExXRXvaGSfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDXNh8TGjDnKBRXAjmCMDFlUp+IKPhB8w3A8NVnGbcw=;
 b=IWYy4V5hsLeFbXaCVLFt4wybObp+biMkaIA4hPFo3iB0rPw+eSQ0Ak4qP7FSYi5EffeYg/vXcFAcvdUiCan6WbXVeLNg0PwmF52jru6ZVWgqbB2x2REAhPACriD/2KXw2GDP21RN4Mm18dRt0P3EdhhdBm8xPL8dodMnOc/PXyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 05:50:38 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::3d2c:e06a:5a1c:b1a4]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::3d2c:e06a:5a1c:b1a4%3]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 05:50:38 +0000
Message-ID: <bc4b5606-2409-85e6-cdf2-1d7857c8a446@amd.com>
Date:   Wed, 21 Jun 2023 11:20:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH v0 1/3] sched/numa: Process based autonuma scan period
 framework
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>, Bharata B Rao <bharata@amd.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        dishaa.talreja@amd.com, Wei Huang <wei.huang2@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
References: <20220128052851.17162-1-bharata@amd.com>
 <20220128052851.17162-2-bharata@amd.com> <20220131121714.GX3301@suse.de>
 <9f95a85f-5396-b8bd-50cf-c4eeeac2a013@amd.com>
 <20220201141520.GB3301@suse.de>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20220201141520.GB3301@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::29) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 758f70f1-876f-473a-7512-08db721b70a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V9bi5w2qT7dFwuDb67lWc7h1LCCCf+hs/434Ky8uB2a6j8DO7xB4RJ8L3wg7T4p8qf23vI/ZJFg0vFyLKYZxFl79AvpHTsLO+NEtJhgKyrA/jsGglDlQAmR2nVhwJDqHqFwdX6tGjI/fbpApZfWXkpMn5hQeRAU6jTr3UXjstfz6jVrSwSr4K8bx2q1BA74xxC7/kc4RLc4WFLTvFvwLsaGtgvtJkNfBU3XhkkVL3M6HCje5kLZ0Vxc4qYpoALcEt5B2TjE6Ch75eiD0GUhgX8AXTrIP4soLX6gb19qOFhhmeHVc1+tnm0G1OX29VZIqA2Li6b5VRoDsTqU1vuaeD4wF2WogtLs7eAOub9FMk5es9ORfnvcH3hiCkbRMOZcCpw1SEayz858texW6wl5EXD6Y2XbPpc/UHIV9v9oNMOByhuvAGCCjH4ghnulX4+0ZZHgzsPg0Txug3N5/jyU7p4LElAy+A1Cpfe/qM3Z+vOgjxINf8WbqiQB1iMHDDGTOAgBTzMU0DFVBv9LQgw+gMxOodvyjYWML/VVHOdwyOHK8ufYS9xoqDl8DscZ8i3tvnvf3Fzb/mnNJg01z/FAavdXRFVvGnaVxRUTM07HfCk6WrfwGCxQMjcXUExf7jl2vbX9akxEftlOXT8x6ZbAbxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199021)(186003)(6512007)(26005)(53546011)(6506007)(2616005)(38100700002)(83380400001)(6666004)(478600001)(66556008)(4326008)(41300700001)(6636002)(66476007)(66946007)(36756003)(8676002)(31686004)(316002)(54906003)(110136005)(8936002)(7416002)(6486002)(31696002)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkEvckYyc2ZRTm96YkJIRVVxejBGdEhGVnR2TVlpbFgzbndwbjdaaWNYMWU1?=
 =?utf-8?B?cElLU01qTThINlRoZHR1aVNzZWtoMCt5T1R1SzBIQmVVc25TUDI3QW0zckpu?=
 =?utf-8?B?RXQwQUR3THJld0dwMnpaVUFLTUc4QlNXdXl0UWd0Mk1DTmFTaE9XY2Q5dW1X?=
 =?utf-8?B?WmhUU1A1RUNKZVdGVlVWNzU0czV4RkZxQkVJZFNDbWJPL05iZDh0aE9YVy8z?=
 =?utf-8?B?VWdoWFRndTl5Q2JoTGhwbkg3VzRzVUZ4SWdKS3VKSkZPS1RFbTcxbWZsQmZN?=
 =?utf-8?B?bjZaSTQxakt6ZGdSZG8zdnZHdDU2eGpoV1ZOTWU5S2J6b0JrSHNyaG5MZER4?=
 =?utf-8?B?aVVxTVV4Um5vY0c1RlVqVmFtUGtIZjNhaEtDWGNMZjJiMzd0MkFaQ3F0c3BL?=
 =?utf-8?B?WmF3dmRJbUdiZ3NNWXJ5S3d4Y2kyNmU1NDlkOW81WkZNVGhnOER2eHNySnJM?=
 =?utf-8?B?NTlHdHYzQTRLTFczU1Y4QktWbGg4ODNiMXRDL0c1eUFJMEZ2c0F3SE4vUjlZ?=
 =?utf-8?B?ZU5uSHBGSm9weG5aelViMjR3a0NJYXd0bmlCeFBvY1g1Mm8va09SZy9tZk1K?=
 =?utf-8?B?NXY0R1NGRUpYQWFaRkZFSHBFc053TUx3QlloMVBJR0s3M2gzMUx5UitpMkEw?=
 =?utf-8?B?Wit2cW83NE1LR095Yyt4Q3Zta2dPeGlCeUorMEhLVFkxaENDTnFjVVlTVjRn?=
 =?utf-8?B?M3gwVEdiRDdlNmpQTWtnditsdXpZWWJ3WGFYUTc0UEt6bWV5a3dpTnJyQXV2?=
 =?utf-8?B?RDFCV3JkaWh2Yng4dmNDeUF0dWFkZVlyNnk0ZVlHaUNBbERKaWJqbWovS2J4?=
 =?utf-8?B?NWlnNnVFME5HN0pzT0ErMkVnZ2hObm5iakJpWGhTOUdrUXhKZ09yUGU4aVZl?=
 =?utf-8?B?UFExSkErakIvNGVubVA0bVp6MnpJQWZDU1gxb1ptcTNEaFhlNWo2Y2dIalJJ?=
 =?utf-8?B?SXNQSzNicUtXNS80ZElUNXoydFVMSStjM1VQSG81Ymh1amZDdTF4cG90RC9Y?=
 =?utf-8?B?dFFzUmFlZ2dCczVzbmplMjJ3ckRpZTRtZDZUaDk2OUdreU00cG1PUXpJalhX?=
 =?utf-8?B?cWNjS1owL3VSSW1pNUNpMG5GaWdVdGx5NG5tNmlLUHVzN1JmVGVacnhWNzBr?=
 =?utf-8?B?WDJ1K2NYeE02RGl6OSszQmM0eG5oL2Rnbm9MSmxXa3hFTjZDR05wVlI5VDF1?=
 =?utf-8?B?MTFQdGphMzVrRWFGOFJTMHhNcVk1em9GZjRzMFMwQVZSdi9UK01LS0NYcExo?=
 =?utf-8?B?bm5HVmI4UE1kZU5VUTdxWnhpbGVERjJnbFRKa0hoenRJblNPSUxMb2xNV3Jq?=
 =?utf-8?B?ZFNEN24zKzExaFgzVVdOMlEwZXZ1aDF4S3N1MGZwaU5jT0VUdGE3M3cxTUFi?=
 =?utf-8?B?dGN3V3pJZ0JtYW5ReXhqcE5wMDVxNmFIOGkyaklDbERzVnNzaThVK1hKZllq?=
 =?utf-8?B?YmNIMWw0cEFyWFpBTzJucEdaQk4vVSszeXp0eTZ6bTVIZzI1RVM0REVScENG?=
 =?utf-8?B?MkJmUXlSZ3NsZ1BCbExYNkp0QXBHcUYzbFJWTlJ1cWYvc0pLZXlnMCs1SEVU?=
 =?utf-8?B?YnJObzR4UStGcFVQaDBNb1dmNnAyMzBpSkEzNjd4bU8rTW44YjV0MGUxWHkx?=
 =?utf-8?B?eFdWRU5xaXNiT1p6b0NIT29LZ3liV1l2Y3FVWWtUd0F6QVdrRUNKd3BwRVNJ?=
 =?utf-8?B?eGVNZEM3Z240aHpFc2dPaHh4SXh5NVdhbU0xNUVTYzRaYzdNOUl4Ty9iNzho?=
 =?utf-8?B?ZFJsTGtqcUFuR1pYNVV2WEdReUZheVQxMEJkU3FwYUJ0SDZBbEorN2pNL3Zw?=
 =?utf-8?B?cUZDbjFpMldYQ1U3RUJxUDY4Y0hHcDh0TXFtTXpVdjMxYzNVaU9xMmh0OWJD?=
 =?utf-8?B?NkhjUE9tL0RIRWQ1VUtieTlYd3YwdFlmcnJoNkhSTy9aSTZUWGRxTnhPSUE3?=
 =?utf-8?B?c0E2OHBYNzE3S0dFSTIzSnV5YW9tVWNxc250cnNOckNhTVRKMVhRT1JwSkZU?=
 =?utf-8?B?S2FQQXp4YThzOTd0dnBTMEhwbzdyZVo0MEs3bFF1a0wveWNBNWNiL2tYZE9I?=
 =?utf-8?B?NndaSkVrVURYUTIyUGNsK0RlVEhKM004YTVMdjgzaThGTERMcWIvQnJyNG9Z?=
 =?utf-8?Q?cDe8Fsys02O2nJ/vl0cifz0yA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758f70f1-876f-473a-7512-08db721b70a4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 05:50:38.6408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoN+7ZYNEmsgMgwtmhzhT5pv4EJhbIhx6rjOcZkFTJ/pYO1kJ1QUoaTyRImW+ljjOquh386chkVs0fw0ZU9HgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+linux-mm
On 2/1/2022 7:45 PM, Mel Gorman wrote:
> On Tue, Feb 01, 2022 at 05:52:55PM +0530, Bharata B Rao wrote:
>> On 1/31/2022 5:47 PM, Mel Gorman wrote:
>>> On Fri, Jan 28, 2022 at 10:58:49AM +0530, Bharata B Rao wrote:
>>>> From: Disha Talreja <dishaa.talreja@amd.com>
>>>>
>>>> Add a new framework that calculates autonuma scan period
>>>> based on per-process NUMA fault stats.
>>>>
>>>> NUMA faults can be classified into different categories, such
>>>> as local vs. remote, or private vs. shared. It is also important
>>>> to understand such behavior from the perspective of a process.
>>>> The per-process fault stats added here will be used for
>>>> calculating the scan period in the adaptive NUMA algorithm.
>>>>
>>>
>>> Be more specific no how the local vs remote, private vs shared states
>>> are reflections of per-task activity of the same.
>>
>> Sure, will document the algorithm better. However the overall thinking
>> here is that the address-space scanning is a per-process activity and
>> hence the scan period value derived from the accumulated per-process
>> faults is more appropriate than calculating per-task (per-thread) scan
>> periods. Participating threads may have their local/shared and private/shared
>> behaviors, but when aggregated at the process level, it gives a better
>> input for eventual scan period variation. The understanding is that individual
>> thread fault rates will start altering the overall process metrics in
>> such a manner that we respond by changing the scan rate to do more aggressive
>> or less aggressive scanning.
>>
> 
> I don't have anything to add on your other responses as it would mostly
> be an acknowledgment of your response.
> 
> However, the major concern I have is that address-space wide decisions
> on scan rates has no sensible means of adapting to thread-specific
> requirements. I completely agree that it will result in more stable scan
> rates, particularly the adjustments. It also side-steps a problem where
> new threads may start with a scan rate that is completely inappropriate.
> 
> However, I worry that it would be limited overall because each thread
> potentially has unique behaviour which is not obvious in a workload like
> NAS where threads are all executing similar instructions on different
> data. For other applications, threads may operate on thread-local areas
> only (low scan rate), others could operate on shared only regresions (high
> scan rate until back off and interleave), threads can has phase behaviour
> (manager thread collecting data from worker threads) and threads can have
> different lifetimes and phase behaviour. Each thread would have a different
> optimal scan rate to decide if memory needs to be migrated to a local node
> or not. I don't see how address-space wide statistics could every be mapped
> back to threads to adapt scan rates based on thread-specific behaviour.
> 
> Thread scanning on the other hand can be improved in multiple ways. If
> nothing else, they can do redundant scanning of regions that are
> not relveant to a task which gets increasingly problematic when VSZ
> increases. The obvious problems are
> 
> 1. Scan based on page table updates, not address ranges to mitigate
>     problems with THP vs base page updates
> 

Hello Mel,
Sorry for digging a very old email, to seek directions on numascanning.

 From the list we have handled (2) and (3) below .. and looking forward 
to continue, with (1) above.

My understanding is when the 256MB limit was introduced, it was mainly
  to limit total number PTE we scan (=64k PTEs of 4kB page).

Considering we can do more if we have THP or hugepage, and thus do we
want to cover more hugePTEs here?

I mean can we say we want to scan 64k worth 2MB page table entry (or 
corresponding hugepage entries)?

I started with a simple patch that just handles 4k/hugepage, but
does not handle THP case properly yet as its not trivial (to track
how much worth of page table entries we handled in a VMA that has THP)
(patch may have white space error because of copying).

Idea is to scan 64k worth of PTEs instead of 256MB for scanning.

Secondly Unrelated to this, I was also thinking if how recently
  vma access was done information could be helpful..

Please let me know your suggestion/comment on the direction/approach etc

> 2. Move scan delay to be a per-vma structure that is kmalloced if
>     necessary instead of being address space wide.
> 
> 3. Track what threads access a VMA. The suggestion was to use a unsigned
>     long pid_mask and use the lower bits to tag approximately what
>     threads access a VMA. Skip VMAs that did not trap a fault. This would
>     be approximate because of PID collisions but would reduce scanning
>     of areas the thread is not interested in
> 
> 4. Track active regions within VMAs. Very coarse tracking, use unsigned
>     long to trap what ranges are active
> 
> In different ways, this would reduce the amount of scanning work threads
> do and focuses them on regions of relevance to reduce overhead overall
> without losing thread-specific details.
> 
> Unfortunately, I have not had the time yet to prototype anything.
> 
Comments about the patch
- may need to scale virtpages checking as well
- Needs checking of exact THP PTEs covered in scan
- Does not touch task_scan_min() etc which influences scan_period (do we 
require)???

---8<---

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 6d041aa9f0fe..066e9bee1187 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -260,7 +260,8 @@ int pud_huge(pud_t pud);
  long hugetlb_change_protection(struct vm_area_struct *vma,
                 unsigned long address, unsigned long end, pgprot_t newprot,
                 unsigned long cp_flags);
-
+long hugetllb_effective_scanned_ptes(struct vm_area_struct *vma, 
unsigned long start,
+               unsigned long end);
  bool is_hugetlb_entry_migration(pte_t pte);
  void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce77080c79..e64430863f9e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2441,6 +2441,8 @@ bool can_change_pte_writable(struct vm_area_struct 
*vma, unsigned long addr,
  extern long change_protection(struct mmu_gather *tlb,
                               struct vm_area_struct *vma, unsigned long 
start,
                               unsigned long end, unsigned long cp_flags);
+extern long effective_scanned_ptes(struct vm_area_struct *vma,
+                               unsigned long start, unsigned long end);
  extern int mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather 
*tlb,
           struct vm_area_struct *vma, struct vm_area_struct **pprev,
           unsigned long start, unsigned long end, unsigned long newflags);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 373ff5f55884..a8280f589cbf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2959,7 +2959,7 @@ static void task_numa_work(struct callback_head *work)
         struct vm_area_struct *vma;
         unsigned long start, end;
         unsigned long nr_pte_updates = 0;
-       long pages, virtpages;
+       long pages, virtpages, ptes_to_scan;
         struct vma_iterator vmi;

         SCHED_WARN_ON(p != container_of(work, struct task_struct, 
numa_work));
@@ -3006,6 +3006,8 @@ static void task_numa_work(struct callback_head *work)
         start = mm->numa_scan_offset;
         pages = sysctl_numa_balancing_scan_size;
         pages <<= 20 - PAGE_SHIFT; /* MB in pages */
+       /* Consider total number of PTEs to scan rather than sticking to 
256MB */
+       ptes_to_scan = pages;
         virtpages = pages * 8;     /* Scan up to this much virtual space */
         if (!pages)
                 return;
@@ -3099,11 +3101,11 @@ static void task_numa_work(struct callback_head 
*work)
                          * areas faster.
                          */
                         if (nr_pte_updates)
-                               pages -= (end - start) >> PAGE_SHIFT;
-                       virtpages -= (end - start) >> PAGE_SHIFT;
+                               ptes_to_scan -= 
effective_scanned_ptes(vma, start, end);

+                       virtpages -= effective_scanned_ptes(vma, start, 
end);
                         start = end;
-                       if (pages <= 0 || virtpages <= 0)
+                       if (ptes_to_scan <= 0 || virtpages <= 0)
                                 goto out;

                         cond_resched();
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f154019e6b84..9935b462c479 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6841,6 +6841,15 @@ long hugetlb_change_protection(struct 
vm_area_struct *vma,
         return pages > 0 ? (pages << h->order) : pages;
  }

+long hugetllb_effective_scanned_ptes(struct vm_area_struct *vma, 
unsigned long start,
+                      unsigned long end)
+{
+       struct hstate *h = hstate_vma(vma);
+
+       return (end - start) >> (PAGE_SHIFT + h->order);
+}
+
+
  /* Return true if reservation was successful, false otherwise.  */
  bool hugetlb_reserve_pages(struct inode *inode,
                                         long from, long to,
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 92d3d3ca390a..8022cb09b47b 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -586,6 +586,16 @@ long change_protection(struct mmu_gather *tlb,
         return pages;
  }

+long effective_scanned_ptes(struct vm_area_struct *vma, unsigned long 
start,
+                      unsigned long end)
+{
+       if (is_vm_hugetlb_page(vma))
+               return hugetllb_effective_scanned_ptes(vma, start, end);
+
+       return (end - start) >> PAGE_SHIFT;
+}
+
+
  static int prot_none_pte_entry(pte_t *pte, unsigned long addr,
                                unsigned long next, struct mm_walk *walk)
  {
