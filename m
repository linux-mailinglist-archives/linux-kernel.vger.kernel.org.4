Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3D2736969
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjFTKgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjFTKgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:36:02 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CA1E3;
        Tue, 20 Jun 2023 03:36:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KR7YjFqBABt+k7fhUs8AE/XsTFRGUFmD9O90mcFsBklnNyuR+9l5SLqIJ5+VggcbfvehhogJtMEOSy0MbKLwKAQnyDL3lChXjQoHOUJvwrpVa4ly7WBWVDvtu5t20kwdHmNVZXa+P8SnJPeGezndffHxHBaK92Xtw8I8r3g8C4iJrJN+fRN+gDNMsFO/PI8DI3IMyxSAWZa/uQJSacThb33Di6ySzNLIFfBxbNLm0PSr+43189HWW3Yu1jyPCrqdY6mCnqzEbsldpXFP73/rTUrWhnx0KIZhUBg/6SId0Rc35t2DTBUCPnYMtS/sz8WxFPnlrxWx/q9qwkFrhfCSKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WrQ3KRLwblgecK6UwXVuAGSN9kCeuBgrL+gFP+ciAA=;
 b=UAxU9Uw5SrVPD87kPbHm/PMdlbHd6NSKIGVsWeuRCOnjciIN+0RzdmKMnjjdL6vY9lSV4sopdsA2uV3NAwkR0Go0AmEVlgfv8b9nZwB5Tnc+D7Ttd2XysEUWOeJJ2KPy1BNhdVdFjPQsleHUvm5CNuWxAP2DuhAp+4Kb6u6avx9kwLiBBHxE0SwNDUE+Xgfa5KX8yr81B0qkD3/EAKtvxCJVSJPgLFdg58EgAPH3sM5yGa9r7LO44pgAuA0bE9zHsHvdvcdrlIsgvQrajX1kkQ68mdOCFONkKdrwLrszErbI7AiqnV3zaJVW6jF8iS6QZA1t/2UWjpZrG1afi94bbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WrQ3KRLwblgecK6UwXVuAGSN9kCeuBgrL+gFP+ciAA=;
 b=T3Bw6ABt2eoDU69/Gmsr7FNZ3lCw8md9PxTxzZKUJeyrwQkCEAx+GBeXj2PggWRDu5QzCo+GMBgcC6g46U+5FUT9J5FM8cIudsCjDTjA5ExyrOROi+dlwnyql5FuOZejkBG5Mq07kZiZLq3ExACDSoYmT8Qkt3YFrnwp9D0HfWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) by
 PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Tue, 20 Jun 2023 10:35:58 +0000
Received: from DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::714c:3289:2d9e:954e]) by DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::714c:3289:2d9e:954e%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 10:35:58 +0000
Message-ID: <44428f1e-ca2c-466f-952f-d5ad33f12073@amd.com>
Date:   Tue, 20 Jun 2023 16:05:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [tip: sched/core] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Aaron Lu <aaron.lu@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        x86@kernel.org
References: <168214940343.404.10896712987516429042.tip-bot2@tip-bot2>
 <09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com>
 <20230620091139.GZ4253@hirez.programming.kicks-ass.net>
From:   Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <20230620091139.GZ4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::17) To DS7PR12MB6165.namprd12.prod.outlook.com
 (2603:10b6:8:9a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7eb77b-b528-4bb8-fbd5-08db717a2200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NSOfnDkMY8ho9w32gQSOHb04jwlkIxokDP5oH1SyYKgHDF/LlQ/9ODlpMHhwASOBTdYTiqt8rLlRcx/pkM8Yq0t/IGOrG5aMF5zHKSsXr61GCS29PuuHpj4/Z13k43RM3lLZjd9hzeuevIWS79+E46sRDd5D6RLNZR+VzoVz1s4yqw1K6QR7unWFZF3/GLRtEUYKGh4ie9S1o7ruC9Ow3Fwtxa45eoxKSnlqfqXPVfL/FAJY2EkS7qCf+CwBnRNUdWxyE6oClT9FeXZHWOgy1M881P3ZX90ZomyzUV6EBqQ0SBr6oB72PxV9YXLzXlKsB3U3pMvSw1RAZT+QopEXnxcCbVJH0gAcJWIZGM5VLObTiA5VbOiFDOxsI/sYX8gJBY76zfYIwGkD21UZ3B94PvG4y3QvVJhcxtPbzZX0E9o35mLOTyjI0cNMnRZ1RZHdnYXIq9/Q5gLB6vLqzCyvQooW/CsRLoSMezwnIwqiKsBRIVKv6IwkcozlP3L1xwGL6BTZdVh/hHixOAGyOnEO4nA8mCxL0Z6leawYVsYWXdUbVSv1nDDzBmMWSkvllLZSmpyDx/G/sNDYj1PM3NeQ0w0+JD4uKilhN7cj/CoZVMwiHQhSEHiY17F7YsIL+VKWKTYY9kthJ3UiQwVkfCcFx0t9ZgcAxGTpjIFeJEFtBUg3U5vpXkOgiPI/TZFALFYV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(966005)(6666004)(6486002)(478600001)(186003)(26005)(6512007)(53546011)(36756003)(83380400001)(2616005)(86362001)(31696002)(38100700002)(6506007)(6916009)(4326008)(66556008)(66946007)(66476007)(316002)(31686004)(8936002)(8676002)(5660300002)(41300700001)(2906002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm9ZQVpObkFMd1VyS1Y2RTZtSlp1RWJSUndFMzJva21oekJmbjE1QmJLeEtq?=
 =?utf-8?B?cE96ZE1WMU9GOTJVbVJVVHRsb3YyMnlDMnM2bG5KMU1JaGlsendEcVpkbWVi?=
 =?utf-8?B?U3NmSG54R1o5ajdlZERZSkdzZ0Q0eWxZQzZnS2lwTjN1V1Y4RXJNalQySFA2?=
 =?utf-8?B?ZU5CemRLYmZCWUhXdXdSYk5YNHNaUzlmcnFNMU5wbFdVN0xFTVhBU2l5UjNY?=
 =?utf-8?B?blcvcnNsNlFoTmV3SElpTERKQ1RWTTh1bjhHbTNTNTJDUmtRd1l3SW1OMWIw?=
 =?utf-8?B?b2FjSWxhWVRERy8zODZWV1JQVEpCNlptaTMyUUdIdnFoczFkUXI4M0t6THVL?=
 =?utf-8?B?Uy9RSjNJQlVUazZIMU5sMHRSejJWdDBjNXhyeGh2aG96U0lWcDE1b2hVRWxD?=
 =?utf-8?B?QS8xQ2h0VU9TL2RUSXJYV0dZN0hIdG9UZlNLT3RyT3BDbzhlYm9kdG1WZXcv?=
 =?utf-8?B?T0JTS3NwNXhmczFMdllreTVhSW85eWExZTVHeS9xUGVmWkJSeHBuYzV0Tk1s?=
 =?utf-8?B?dCswVDEyQXZvOVExQnVDZjhITzBQcjlwZkE1aFdGRWROZW8zNk51NU5IN2Iy?=
 =?utf-8?B?NFBxZmtoSEVFVnhlZXVkMmVINlVnWVNyQkxuY2gyTkNpYk84a3ZjWnUyUnNM?=
 =?utf-8?B?dVhJRWRmdjQ2QURRK2g0SU0xc3RkZVZHaU5NT0FhU01lcDF0RCtCVlBvRTRF?=
 =?utf-8?B?WjJEK1JhWlBydHVtNkRxc3lXY3VIR0FlRkFSR25XRk5jUXlRa2FQNDFhSEha?=
 =?utf-8?B?Sm0wQmpyR3ZpN0FVZjZtYVlGYUpoNkZVYjhhOVpYcENOTit6cHliR0oyQmE3?=
 =?utf-8?B?YXo1M1FPNWhxQU5wU0xxT2loeWNJWm5yeFA5VTc3b0p0VGQ1SVFhY0hlUklX?=
 =?utf-8?B?SHlWWWhmZXBjcmFkekJGT2wyTFV2MDZ6ODQzRnMzazgxNWk0SzNNQ2lVMFlr?=
 =?utf-8?B?aVpQZXpHN2x5MXByNmV2RElna3FETVRCbEZWRGVsamJRYm51dVVUbnJSV3Z0?=
 =?utf-8?B?SFJDaGxlL0N3RzZwNThmVEtUendQbXdQMTJpNGZ2ODdwcGs5SW1QTGhuOVkr?=
 =?utf-8?B?Y05PeURtZVZsS0FMNDhFNWVxOHdHWGlBNmVQSytselIzdjNlTDh5T1ZwR0xX?=
 =?utf-8?B?T0ozeERQR3lrZW54cW1kbGZkQVFmME1pelZYNkFvdkxDMXY1YmRSMGo4Ni91?=
 =?utf-8?B?WVV3SDdiVDltZld1UDVvV0ovY3RYdEhncnRqQlpLRjNlbXozRnc0RkFXMHZm?=
 =?utf-8?B?NDdDSVovNzRsZTJQZjVJVHUxWWNaT3UzelQrcloreW9LdUQ0bCtOWVRpNjg3?=
 =?utf-8?B?Z0ZXWXQrQzVtdjJUOGJGY1pPU2x4bWM2YXRkTWczWGVna2c1UmpmSGxONGRj?=
 =?utf-8?B?bUZQU3JrN2NqcUNhRFRUWU51eUpnejE1bTlvd1FLRS9rRmp6ZkJhaWdQTWhu?=
 =?utf-8?B?cHlTSHIweEZiUDUwL1VRbm1UcUtPcGtqejM5OGFPVnF2Ty9WSy83ZDg2YytE?=
 =?utf-8?B?dkhoSmxOd1g5R2ZxSHNHUFY3Y0ZOM21FRzdPSmZabUtKVFVWeXZoa0NvREY1?=
 =?utf-8?B?TTYvTkx2MCtubis2UTBlSFloVUNPK3k2VTc1NDlqcjV2aWNhTDBBRW01am1m?=
 =?utf-8?B?ZXNJc0g5MWYrTWc3cGw2a3hkQkd0MWl6RDNvTVhoQXNnZjVwUHA2dEVWUnFa?=
 =?utf-8?B?K05UWlFsR01NSHdFWmZVazVJMzdLRVNFOVhQSE9GTTcwTzVvT3NDdCs4NXJh?=
 =?utf-8?B?K1oxQVBEN1MydkpGRkIzOC9GNmdzc0JNMWEvWjVQVkJVeFNrVlRlVmtSNThO?=
 =?utf-8?B?djNHR0lGcWFCb3VHQUVIS3o0Rkd6RFpUODc5dVdOaDg1RXRreHNGeXppUXdu?=
 =?utf-8?B?Y0dVazVySEpQNFRZWUJOTDAwY3RHVFNRUTIrdFM3OHk2cFdBS29idVZBSVF1?=
 =?utf-8?B?QjZldmlBRWZLWHhHVk5vVWprY1NDVmxFTWNHSkRJUWlQaHJzb2RWbTQ1bkNH?=
 =?utf-8?B?SnhHUjBqdGhxc2hkd2ZkRFhGTlNyYndLRFRtS3hOQURTVUNveVRiOUJ5enhx?=
 =?utf-8?B?UTFtelFTZ3JvQm1FRVVEcXc4REwxdktDM2IwZFJZa1krL0NDR3JwN3huaWRK?=
 =?utf-8?Q?w/Aw+8k4OSHByac5VXxPbqBcn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7eb77b-b528-4bb8-fbd5-08db717a2200
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 10:35:57.6961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncuVlbYMAYev1yHOhcHW3BLNiK4fIj0+MSvYbU+RyveWDm98GDyt9ARJpOoU05K3dJXH3OPJgwYvuGE4QwQAYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278
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

Hello Peter,

On 6/20/2023 2:41 PM, Peter Zijlstra wrote:
> On Tue, Jun 20, 2023 at 01:44:32PM +0530, Swapnil Sapkal wrote:
>> Hello Mathieu,
>>
>> On 4/22/2023 1:13 PM, tip-bot2 for Mathieu Desnoyers wrote:
>>> The following commit has been merged into the sched/core branch of tip:
>>>
>>> Commit-ID:     223baf9d17f25e2608dbdff7232c095c1e612268
>>> Gitweb:        https://git.kernel.org/tip/223baf9d17f25e2608dbdff7232c095c1e612268
>>> Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> AuthorDate:    Thu, 20 Apr 2023 10:55:48 -04:00
>>> Committer:     Peter Zijlstra <peterz@infradead.org>
>>> CommitterDate: Fri, 21 Apr 2023 13:24:20 +02:00
>>>
>>> sched: Fix performance regression introduced by mm_cid
>>>
>>> Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
>>> sysbench regression reported by Aaron Lu.
>>>
>>> Keep track of the currently allocated mm_cid for each mm/cpu rather than
>>> freeing them immediately on context switch. This eliminates most atomic
>>> operations when context switching back and forth between threads
>>> belonging to different memory spaces in multi-threaded scenarios (many
>>> processes, each with many threads). The per-mm/per-cpu mm_cid values are
>>> serialized by their respective runqueue locks.
>>>
>>> Thread migration is handled by introducing invocation to
>>> sched_mm_cid_migrate_to() (with destination runqueue lock held) in
>>> activate_task() for migrating tasks. If the destination cpu's mm_cid is
>>> unset, and if the source runqueue is not actively using its mm_cid, then
>>> the source cpu's mm_cid is moved to the destination cpu on migration.
>>>
>>> Introduce a task-work executed periodically, similarly to NUMA work,
>>> which delays reclaim of cid values when they are unused for a period of
>>> time.
>>>
>>> Keep track of the allocation time for each per-cpu cid, and let the task
>>> work clear them when they are observed to be older than
>>> SCHED_MM_CID_PERIOD_NS and unused. This task work also clears all
>>> mm_cids which are greater or equal to the Hamming weight of the mm
>>> cidmask to keep concurrency ids compact.
>>>
>>> Because we want to ensure the mm_cid converges towards the smaller
>>> values as migrations happen, the prior optimization that was done when
>>> context switching between threads belonging to the same mm is removed,
>>> because it could delay the lazy release of the destination runqueue
>>> mm_cid after it has been replaced by a migration. Removing this prior
>>> optimization is not an issue performance-wise because the introduced
>>> per-mm/per-cpu mm_cid tracking also covers this more specific case.
>>>
>>> Fixes: af7f588d8f73 ("sched: Introduce per-memory-map concurrency ID")
>>> Reported-by: Aaron Lu <aaron.lu@intel.com>
>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> Tested-by: Aaron Lu <aaron.lu@intel.com>
>>> Link: https://lore.kernel.org/lkml/20230327080502.GA570847@ziqianlu-desk2/
>>
>> I run standard benchmarks as a part of kernel performance regression
>> testing. When I run these benchmarks against v6.3.0 to v6.4-rc1,
>> I have seen performance regression in hackbench running with threads. When I did
>> git bisect it pointed to this commit and reverting this commit helps regains
>> the performance. This regression is not seen with hackbench processes.
> 
> Well, *this* commit was supposed to help fix the horrible contention on
> cid_lock that was introduced with af7f588d8f73.

I went back and tested the commit that introduced mm_cid and I found that the
original implementation actually helped hackbench. Following are numbers from
2 Socket Zen3 Server (2 X 64C/128T):

Test:           base (v6.2-rc1)      base + orig_mm_cid
  1-groups:     4.29 (0.00 pct)     4.32 (-0.69 pct)
  2-groups:     4.96 (0.00 pct)     4.94 (0.40 pct)
  4-groups:     5.21 (0.00 pct)     4.10 (21.30 pct)
  8-groups:     5.44 (0.00 pct)     4.50 (17.27 pct)
16-groups:     7.09 (0.00 pct)     5.28 (25.52 pct)

I see following IBS traces in this case:

Base:

    6.69%  sched-messaging  [kernel.vmlinux]          [k] copy_user_generic_string
    5.38%  sched-messaging  [kernel.vmlinux]          [k] native_queued_spin_lock_slowpath
    3.73%  swapper          [kernel.vmlinux]          [k] __switch_to_asm
    3.23%  sched-messaging  [kernel.vmlinux]          [k] __calc_delta
    2.93%  sched-messaging  [kernel.vmlinux]          [k] try_to_wake_up
    2.63%  sched-messaging  [kernel.vmlinux]          [k] dequeue_task_fair
    2.56%  sched-messaging  [kernel.vmlinux]          [k] osq_lock

Base + orig_mm_cid:

   13.70%  sched-messaging  [kernel.vmlinux]      [k] native_queued_spin_lock_slowpath
   11.87%  swapper          [kernel.vmlinux]      [k] native_queued_spin_lock_slowpath
    8.99%  sched-messaging  [kernel.vmlinux]      [k] copy_user_generic_string
    6.08%  sched-messaging  [kernel.vmlinux]      [k] osq_lock
    4.79%  sched-messaging  [kernel.vmlinux]      [k] apparmor_file_permission
    3.71%  sched-messaging  [kernel.vmlinux]      [k] mutex_spin_on_owner
    3.66%  sched-messaging  [kernel.vmlinux]      [k] ktime_get_coarse_real_ts64
    3.11%  sched-messaging  [kernel.vmlinux]      [k] _copy_from_iter

> 
>> Following are the results from 1 Socket 4th generation EPYC
>> Processor(1 X 96C/192T) configured in NPS1 mode. This regression
>> becomes more severe as the number of core count increases.
>>
>> The numbers on a 1 Socket Bergamo (1 X 128 cores/256 threads) is significantly worse.
>>
>> Threads:
>>
>> Test:             With-mmcid-patch        Without-mmcid-patch
>>   1-groups:         5.23 (0.00 pct)         4.61 (+11.85 pct)
>>   2-groups:         4.99 (0.00 pct)         4.72 (+5.41 pct)
>>   4-groups:         5.96 (0.00 pct)         4.87 (+18.28 pct)
>>   8-groups:         6.58 (0.00 pct)         5.44 (+17.32 pct)
>> 16-groups:        11.48 (0.00 pct)         8.07 (+29.70 pct)
> 
> I'm really confused, so you're saying that having a process wide
> spinlock is better than what this patch does? Or are you testing against
> something without mm-cid entirely?

It does look like the lock contention introduced by the original mm_cid patch helped
hackbench in this case. In that case, I see hackbench threads run for longer on average (avg_atom)
and total idle entries are down significantly. Even on disabling C1 and C2, I see
similar behavior. With the new mm_cid patch that gets rid of the lock contention, we see a drop
in the hackbench performance.

I will go dig into this further meanwhile if you have any pointers please do let me know.

--
Thanks and Regards,
Swapnil
