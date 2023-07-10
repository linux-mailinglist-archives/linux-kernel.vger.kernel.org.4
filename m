Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6476574D4D4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjGJL5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjGJL5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:57:41 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57F4FE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:57:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7OCcx7efuKzJMTxl8KWGPXkSW1GwT3iygV/sNquLpKj+x+x6rwQXAAVujLGud4VVgOxxpYjzMeFK48Isa8kF2lj4dG1L5bIjEvWA/oZrFalL5cVuycc4eWnsVKlKIQHxH54wtYpBsLNdY2svQ3M099FOHemfrCl6q+TZEdF57ckSXXhpECasQKEUBnO1kKwGsAostn9DhfA33pf0JVRE4bxxO8Q4nHxR2OCve7eGhQtonZLvW3euey/9Dob2ZalfViTdC/nXrmGpQNmQ/lnlACLA4duQe7rdV0E3dvdb3OxEaTMLB0dbE6BA9mcD3lL8CQidp6taGdWEzzV0rWgug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TAgQPxh3u3Gnls6e8KUfWy83ybZ3gG/a1FHcjyHIdg=;
 b=BMD/SkTol/S6y/noi40Sbw0mj440l8+WxQxczTliZw3MKRe3SCOmGpozISAv+qtnh/V+GTv6mWnOaj72Xxq6uP8ir65jhqLwexxeivOCizpZCzGGJlLru7OXJ7k7OnuYd2HO5PnRMqdhD44a5NG7aACUlukuvD0mp3/G66OM59aK2T4yKa15vGfe+xWquco9gayvWerDC7yQ3lUGFqtQKLSemSbi35KY9AAPza0Dwb2wtTI0iVoJKhDMILBqv271GIoBlXZEVou5dEcnj8nys9iBIDmWd/j2MxUTs+tEsakiNKzzowcUxBvmPFRbW3MMJPrO6AupVdyjWsoobpPCxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TAgQPxh3u3Gnls6e8KUfWy83ybZ3gG/a1FHcjyHIdg=;
 b=TxyHSuh/vQCNln0wp5vL5Z8WZTaVuZwDkm12MP5dmIDAxtu87zeMO8vGTKMlIY41yujP7swR5aRHHL3fvPkKYDk9mstshY5mKzTi8B0LAvDmp7vvaC5kU0dh39ev6tvcC1KJkM69HTXCya/3e8AIoQuX6jFfk14G6XBYERUrSH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by PH7PR12MB8037.namprd12.prod.outlook.com (2603:10b6:510:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 11:57:33 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c%2]) with mapi id 15.20.6565.026; Mon, 10 Jul 2023
 11:57:33 +0000
Message-ID: <2b1fba1c-da7a-f7a0-552a-c6dbc7ac2b7e@amd.com>
Date:   Mon, 10 Jul 2023 17:27:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 0/3] sched: Implement shared wakequeue in CFS
Content-Language: en-US
To:     David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joshdon@google.com,
        roman.gushchin@linux.dev, tj@kernel.org, kernel-team@meta.com
References: <20230613052004.2836135-1-void@manifault.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230613052004.2836135-1-void@manifault.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::14) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|PH7PR12MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d597bf5-87f3-42d4-f2a0-08db813cd7fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RpdlytaxClcmbh7mh6VHTM6NjOgD0CkBjZvLUQPaSBG99YyLZxyvK/6BXDTGNxzPJGpFsxZnhTJerA00WN8c/3EwwqnSRgFQmGc3ENCc+Y2W5YPZiqnkosz0UfUlFmFc+oXH8kJF4Yy5j2W1mgC0U7/ps7zFMjeUDdUcC+ikUoNJOUYFVKKrLj69x41jBy1vUXAoeAkEVbGXlmzBSWESvUYfgc6KeGBtIjV/d2k6PqzUuXYYc1YlCqbC6a2p4WPw/qSypCgj1AmQcVuerbrU8SBgAqp268wt2c9jjOHfT7oPluBey53Tz1gBEYUAicUkZLyt5ua75viBxGfELOHYq7tDIBiI7DMXlfVsnJEVjw2ZP2wx/2/UZk+YAsCvFH5uaiJNWrXAkY+XbsQI1Uly7FFhJ+QisYYRyVYtinPJxNSlbTGfoA3MSPw1V2JHOef5MvZq/dFupYPpJ01LSUvp40z9nAOgm9hXHwD3h6iJ1BHpFJUrcA5+jBiWQybIHnG1OOzRX9ANlpqsDBozgv+Irzqmc5alob3pQiqbf+rbNnFvtp1Wphao8FygUsANOCo75auOHk8Kqco/WQbHCwbrooDo94I4di4TKoFUdYW08v3puPVUA4eLps+Ovtw8Rt7YWw16AlV5X+EVH5qL5zwZdtHwT6BLKQ/SjxzR+XHoj17KN/d6hM338PBEGSiL+2r2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(86362001)(31696002)(38100700002)(31686004)(36756003)(6666004)(6486002)(53546011)(26005)(6506007)(186003)(6512007)(966005)(2616005)(7416002)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(83380400001)(4326008)(30864003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dS94WTEvdFU1KzdQelRqVCsxdklyT25IeFoyS2xxdkkwR1pkUVFkeHZyV2hE?=
 =?utf-8?B?MFVvWkhWaWx6RmNzSlRnV1pxeFUySUE2MUY5ZXJoUnU3Q1Npazh5dE5YWGhu?=
 =?utf-8?B?ZlpsTDZZNGxBWUN5K05XWmxPcVlNRGlEZ0Z1cVdqWEQyUmFUalJGNVlzV3pH?=
 =?utf-8?B?eVJyRmd2M0xaYkphekdKNFlpTVhsUzdXYUR2NTVMNSs0YVVBcDNGdnZ2eWty?=
 =?utf-8?B?ZGhZbjZVWEMzNm9XRUVmY3hGSStpY0c5aVNTOGFxbmFyNFpYQWNjYXZZMHBH?=
 =?utf-8?B?aUkzVXNYRG55NWZseCs4U3diQkRSdHgxUHdTUEdnWlp0NysxczhTa24vd1N4?=
 =?utf-8?B?S1QxekhVanByVFVSWVZVS2RZcVZ0bFZOc3lqcU0rSE8vVzljamtZSVR3Tjcw?=
 =?utf-8?B?blE5alhVd1dycjJuR21EMHQzRGRsaWJRQkZzUzV2Yk9nWENDd3VBVjFHMDU1?=
 =?utf-8?B?RVBNZGd1NjJZaitjWkRaMG1CKzExKzk1Y2t6WjdvZkZ2eUdjc1FBbTJPVVNP?=
 =?utf-8?B?Y0daS1RocVI5QWsxSEFBRjI4NmdaRnExSGJkWTFSVm1HYlhPOVhEYXZlRnox?=
 =?utf-8?B?WkFENmRzeEFJd0FsdUdTWE4yOGt0cjVMeksrWGk1dTZXVzFKbGxpcFVvRE1P?=
 =?utf-8?B?ZkF6NnJ4VW1HeEJNOWU3MEdYOHgzeFJUbnltbmU1cjNsd29GdW5SV2RjOU1T?=
 =?utf-8?B?QTRoTGRLbFlPc3ZqcXo2WUZWTzFjMldqZTc1NDNxSUR3eHh5V01QK0p1aitv?=
 =?utf-8?B?T3p4VmdicW0zcDIwcVVWR0EyL01VQUk5UmlSNGJqNHpqOXEvWkNXZDJZWVZo?=
 =?utf-8?B?dDZpeEROc2JzeVJaaEJnNzZheDVISFAwUVkxSHJKTndPTWpTMEc1Z3hSWDly?=
 =?utf-8?B?U3FaU3plQXY4cEMzTXRKNUV6OGsyQW1aVkpvQ0FkYS9QM0sxUHRGWW9NWlhE?=
 =?utf-8?B?VFpsUmp1bXZDdndsT1N5K3pVekxNVUpWdEwrWlVrODltQm5YTlljTkJMVG4w?=
 =?utf-8?B?OTFpcmUrVmhPRzhIWEQxY3E0cEQ3Y1ZIa2JRTEtYd1NNUSt0aFBnYUJobzFt?=
 =?utf-8?B?ZEk2Z2I5YjgwRzdja1JzZDFYS0JhSDBoSDNSbkFTTFRXem5lYk02aWJiRG5Q?=
 =?utf-8?B?U3daUGRicWFmOWl1L2R1SFRqalR1MnhsY29PNjNvbXYvaHgyN3JwVTVlYzZP?=
 =?utf-8?B?Tlk5Rk5RMDFPL1dmRmlkWHJ6TTc3M0srN1VZUW9GRFI1NlowTEx0eklVUEtx?=
 =?utf-8?B?cTFMT2VQWFpRSFlqZFU0L29Fbks5TVZrVXBPQ3I4QlZjemgwbFRXNmVNdEVz?=
 =?utf-8?B?Vmgxd0lxRnU4NitIVm1wbnRDd0podXNvMUVFQ3JlMnZyMXVSaXE1YWFPNUtX?=
 =?utf-8?B?NHo1WGJYS1hCa0hHM28vNmlNMHpPQnBnV01TNVFNQ2lDbXhrV2NPUXVsZ3Vs?=
 =?utf-8?B?ays5TXdUYUVKa0FnMjFFSHk4aU9GNmxYVHNxT0N6emwyOTlCSUJuU2RiWlE0?=
 =?utf-8?B?ckpKeUpCTWtsamdtTkl1dVlDdUU5aHJaczZIV0pBWTJnZXUzL3hJTWdFSUFK?=
 =?utf-8?B?MDUwM2lodndmMnA2eXFmbFJkTnFxTEwzSzdLZzZBOFBmVWpzeVZjMVpJbUt2?=
 =?utf-8?B?SjJld2xhbSt5UFZuMXUrNTJ4cmQzMUFkckg0OTVOUGlJajY4MkNaa1VHR0hq?=
 =?utf-8?B?Yzd6MWt6aGFrYUhDWkl5VHZ6TndLaWpyaXRESVNRRDdGSWFCUHBMZkpXR1BM?=
 =?utf-8?B?Q3RGa3FFaG51Mld3SGlaSUpiZzh1YkJpd2h0TXFwVVNGVlBlYXJndjJTRmN3?=
 =?utf-8?B?NHZ6K0pnejVUSldGcCs4cmxuWVBIeHBzUWI0YVllN3BsWXRSY0hBbVVDSG54?=
 =?utf-8?B?ZkJuak9pNXFTcnREdVBTRlB1RzMzSGQ3d1czQlVheWQ4WFdMZG9kSHE4WUg0?=
 =?utf-8?B?Y2FYaU5YdHVYMjAzVVJNOEtoQndSVTBoWkNjeU43NGNmcUkrVU9vK2xxUlpF?=
 =?utf-8?B?UXBXaCs1S0xoM2tOaTBoVno1bGpnOThSRGlSdjhNVndtNnFSTWVDczMvSC9H?=
 =?utf-8?B?KzVRWXNnOG5mT0gzb2R6eTlQc3JPNHN4Tzk1TExldXdPRU9rYTQwc2oyRzhw?=
 =?utf-8?Q?UU6CesOyzqaUja43EeJNe6oi/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d597bf5-87f3-42d4-f2a0-08db813cd7fc
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 11:57:32.8862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1gzt9CgeQCWmjLzk2DhP0/FxAmmK8OCUmzWsilntHa+3NxdD8loLbDjBpGjh+z27QU5oXMIhOhiHPkylBIYgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8037
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

Sharing the results from testing SWQUEUE with some of the standard
benchmarks below.

tl;dr

- Hackbench, tbench, DeathStarBench and SPECjbb seem to like the
  SWQUEUE (except for hackbench in NPS4, with 16 groups)

- Netperf sees regression as system becomes more loaded. I'll go
  back and check if there is some lock contention issues here which
  is parallely being discussed on the tread.

- Other benchmarks seem to be behave similar to tip.

On 6/13/2023 10:50 AM, David Vernet wrote:
> Overview
> ========
> 
> The scheduler must constantly strike a balance between work
> conservation, and avoiding costly migrations which harm performance due
> to e.g. decreased cache locality. The matter is further complicated by
> the topology of the system. Migrating a task between cores on the same
> LLC may be more optimal than keeping a task local to the CPU, whereas
> migrating a task between LLCs or NUMA nodes may tip the balance in the
> other direction.
> 
> With that in mind, while CFS is by and large mostly a work conserving
> scheduler, there are certain instances where the scheduler will choose
> to keep a task local to a CPU, when it would have been more optimal to
> migrate it to an idle core.
> 
> An example of such a workload is the HHVM / web workload at Meta. HHVM
> is a VM that JITs Hack and PHP code in service of web requests. Like
> other JIT / compilation workloads, it tends to be heavily CPU bound, and
> exhibit generally poor cache locality. To try and address this, we set
> several debugfs (/sys/kernel/debug/sched) knobs on our HHVM workloads:
> 
> - migration_cost_ns -> 0
> - latency_ns -> 20000000
> - min_granularity_ns -> 10000000
> - wakeup_granularity_ns -> 12000000
> 
> These knobs are intended both to encourage the scheduler to be as work
> conserving as possible (migration_cost_ns -> 0), and also to keep tasks
> running for relatively long time slices so as to avoid the overhead of
> context switching (the other knobs). Collectively, these knobs provide a
> substantial performance win; resulting in roughly a 20% improvement in
> throughput. Worth noting, however, is that this improvement is _not_ at
> full machine saturation.
> 
> That said, even with these knobs, we noticed that CPUs were still going
> idle even when the host was overcommitted. In response, we wrote the
> "shared wakequeue" (swqueue) feature proposed in this patch set. The
> idea behind swqueue is simple: it enables the scheduler to be
> aggressively work conserving by placing a waking task into a per-LLC
> FIFO queue that can be pulled from by another core in the LLC FIFO queue
> which can then be pulled from before it goes idle.
> 
> With this simple change, we were able to achieve a 1 - 1.6% improvement
> in throughput, as well as a small, consistent improvement in p95 and p99
> latencies, in HHVM. These performance improvements were in addition to
> the wins from the debugfs knobs mentioned above.
> 
> Design
> ======
> 
> The design of swqueue is quite simple. An swqueue is simply a struct
> list_head, and a spinlock:
> 
> struct swqueue {
> 	struct list_head list;
> 	spinlock_t lock;
> } ____cacheline_aligned;
> 
> We create a struct swqueue per LLC, ensuring they're in their own
> cachelines to avoid false sharing between CPUs on different LLCs.
> 
> When a task first wakes up, it enqueues itself in the swqueue of its
> current LLC at the end of enqueue_task_fair(). Enqueues only happen if
> the task was not manually migrated to the current core by
> select_task_rq(), and is not pinned to a specific CPU.
> 
> A core will pull a task from its LLC's swqueue before calling
> newidle_balance().
> 
> Difference between SIS_NODE
> ===========================
> 
> In [0] Peter proposed a patch that addresses Tejun's observations that
> when workqueues are targeted towards a specific LLC on his Zen2 machine
> with small CCXs, that there would be significant idle time due to
> select_idle_sibling() not considering anything outside of the current
> LLC.
> 
> This patch (SIS_NODE) is essentially the complement to the proposal
> here. SID_NODE causes waking tasks to look for idle cores in neighboring
> LLCs on the same die, whereas swqueue causes cores about to go idle to
> look for enqueued tasks. That said, in its current form, the two
> features at are a different scope as SIS_NODE searches for idle cores
> between LLCs, while swqueue enqueues tasks within a single LLC.
> 
> The patch was since removed in [1], but we elect to compare its
> performance to swqueue given that as described above, it's conceptually
> complementary.
> 
> [0]: https://lore.kernel.org/all/20230530113249.GA156198@hirez.programming.kicks-ass.net/
> [1]: https://lore.kernel.org/all/20230605175636.GA4253@hirez.programming.kicks-ass.net/
> 
> I observed that while SIS_NODE works quite well for hosts with small
> CCXs, it can result in degraded performance on machines either with a
> large number of total cores in a CCD, or for which the cache miss
> penalty of migrating between CCXs is high, even on the same die.
> 
> For example, on Zen 4c hosts (Bergamo), CCXs within a CCD are muxed
> through a single link to the IO die, and thus have similar cache miss
> latencies as cores in remote CCDs.
> 
> Such subtleties could be taken into account with SIS_NODE, but
> regardless, both features are conceptually complementary sides of the
> same coin. SIS_NODE searches for idle cores for waking threads, whereas
> swqueue searches for available work before a core goes idle.
> 
> Results
> =======
> 
> Note that the motivation for the shared wakequeue feature was originally
> arrived at using experiments in the sched_ext framework that's currently
> being proposed upstream. The ~1 - 1.6% improvement in HHVM throughput
> is similarly visible using work-conserving sched_ext schedulers (even
> very simple ones like global FIFO).
> 
> In both single and multi socket / CCX hosts, this can measurably improve
> performance. In addition to the performance gains observed on our
> internal web workloads, we also observed an improvement in common
> workloads such as kernel compile when running shared wakequeue. Here are
> the results of running make -j$(nproc) built-in.a on several different
> types of hosts configured with make allyesconfig on commit a27648c74210
> ("afs: Fix setting of mtime when creating a file/dir/symlink") on Linus'
> tree (boost was disabled on all of these hosts when the experiments were
> performed):
> 
> Single-socket | 32-core | 2-CCX | AMD 7950X Zen4
> 
> CPU max MHz:                     5879.8818
> CPU min MHz:                     3000.0000
> 				o____________o_______o
> 				|    mean    | CPU   |
> 				o------------o-------o
> NO_SWQUEUE + NO_SIS_NODE:	| 590.52s    | 3103% |
> NO_SWQUEUE + SIS_NODE:		| 590.80s    | 3102% |
> SWQUEUE + NO_SIS_NODE:		| 589.65s    | 3116% |
> SWQUEUE + SIS_NODE:		| 589.99s    | 3115% |
> 				o------------o-------o
> 
> Takeaway: swqueue doesn't seem to provide a statistically significant
> improvement for kernel compile on my 7950X. SIS_NODE similarly does not
> have a noticeable effect on performance.
> 
> -------------------------------------------------------------------------------
> 
> Single-socket | 72-core | 6-CCX | AMD Milan Zen3
> 
> CPU max MHz:                     3245.0190
> CPU min MHz:                     700.0000
> 				o_____________o_______o
> 				|    mean     | CPU   |
> 				o-------------o-------o
> NO_SWQUEUE + NO_SIS_NODE:	| 1608.69s    | 6488% |
> NO_SWQUEUE + SIS_NODE:		| 1610.24s    | 6473% |
> SWQUEUE + NO_SIS_NODE:		| 1605.80s    | 6504% |
> SWQUEUE + SIS_NODE:		| 1606.96s    | 6488% |
> 				o-------------o-------o
> 
> Takeaway: swqueue does provide a small statistically significant
> improvement on Milan, but the compile times in general were quite long
> relative to the 7950X Zen4, and the Bergamo Zen4c due to the lower clock
> frequency. Milan also has larger CCXs than Bergamo, so it stands to
> reason that select_idle_sibling() will have an easier time finding idle
> cores inside the current CCX.

o System Details

Dual Socket 3rd Generation EPYC System (2 x 64C/128T)

o NPS Modes

NPS Modes are used to logically divide single socket into
multiple NUMA region.
Following is the NUMA configuration for each NPS mode on the system:

NPS1: Each socket is a NUMA node.
    Total 2 NUMA nodes in the dual socket machine.

    Node 0: 0-63,   128-191
    Node 1: 64-127, 192-255

NPS2: Each socket is further logically divided into 2 NUMA regions.
    Total 4 NUMA nodes exist over 2 socket.
   
    Node 0: 0-31,   128-159
    Node 1: 32-63,  160-191
    Node 2: 64-95,  192-223
    Node 3: 96-127, 223-255

NPS4: Each socket is logically divided into 4 NUMA regions.
    Total 8 NUMA nodes exist over 2 socket.
   
    Node 0: 0-15,    128-143
    Node 1: 16-31,   144-159
    Node 2: 32-47,   160-175
    Node 3: 48-63,   176-191
    Node 4: 64-79,   192-207
    Node 5: 80-95,   208-223
    Node 6: 96-111,  223-231
    Node 7: 112-127, 232-255

o Kernel Versions

- tip              - tip:sched/core at commit e2a1f85bf9f5 "sched/psi:
                     Avoid resetting the min update period when it is
                     unnecessary")

- SWQUEUE	   - tip:sched/core + this patch
		     (SWQUEUE feature enabled from debugfs)

~~~~~~~~~~~~~
~ hackbench ~
~~~~~~~~~~~~~

o NPS1

Test:			tip			SWQUEUE
 1-groups:	   3.92 (0.00 pct)	   3.41 (13.01 pct)
 2-groups:	   4.58 (0.00 pct)	   3.80 (17.03 pct)
 4-groups:	   4.99 (0.00 pct)	   4.48 (10.22 pct)
 8-groups:	   5.67 (0.00 pct)	   5.11 (9.87 pct)
16-groups:	   7.88 (0.00 pct)	   7.29 (7.48 pct)

o NPS2

Test:			tip			SWQUEUE
 1-groups:	   3.82 (0.00 pct)	   3.45 (9.68 pct)
 2-groups:	   4.40 (0.00 pct)	   3.72 (15.45 pct)
 4-groups:	   4.84 (0.00 pct)	   4.27 (11.77 pct)
 8-groups:	   5.45 (0.00 pct)	   4.98 (8.62 pct)
16-groups:	   6.94 (0.00 pct)	   6.82 (1.72 pct)

o NPS4

Test:			tip			SWQUEUE
 1-groups:	   3.82 (0.00 pct)	   3.50 (8.37 pct)
 2-groups:	   4.44 (0.00 pct)	   3.77 (15.09 pct)
 4-groups:	   4.86 (0.00 pct)	   4.44 (8.64 pct)
 8-groups:	   5.42 (0.00 pct)	   5.08 (6.27 pct)
16-groups:	   6.68 (0.00 pct)	   7.82 (-17.06 pct)

~~~~~~~~~~~~
~ schbench ~
~~~~~~~~~~~~

o NPS1

#workers:	tip			SWQUEUE
  1:	  26.00 (0.00 pct)	  28.00 (-7.69 pct)
  2:	  27.00 (0.00 pct)	  23.00 (14.81 pct)
  4:	  31.00 (0.00 pct)	  29.00 (6.45 pct)
  8:	  36.00 (0.00 pct)	  38.00 (-5.55 pct)
 16:	  49.00 (0.00 pct)	  48.00 (2.04 pct)
 32:	  80.00 (0.00 pct)	  78.00 (2.50 pct)
 64:	 169.00 (0.00 pct)	 168.00 (0.59 pct)
128:	 343.00 (0.00 pct)	 383.00 (-11.66 pct)
256:	 42048.00 (0.00 pct)	 50368.00 (-19.78 pct)
512:	 95104.00 (0.00 pct)	 93312.00 (1.88 pct)

o NPS2

#workers:	tip			SWQUEUE
  1:	  23.00 (0.00 pct)	  21.00 (8.69 pct)
  2:	  24.00 (0.00 pct)	  25.00 (-4.16 pct)
  4:	  31.00 (0.00 pct)	  29.00 (6.45 pct)
  8:	  41.00 (0.00 pct)	  43.00 (-4.87 pct)
 16:	  48.00 (0.00 pct)	  50.00 (-4.16 pct)
 32:	  81.00 (0.00 pct)	  80.00 (1.23 pct)
 64:	 157.00 (0.00 pct)	 161.00 (-2.54 pct)
128:	 386.00 (0.00 pct)	 413.00 (-6.99 pct)
256:	 48832.00 (0.00 pct)	 49472.00 (-1.31 pct)
512:	 92032.00 (0.00 pct)	 93568.00 (-1.66 pct)

o NPS4

#workers:	tip			SWQUEUE
  1:	  21.00 (0.00 pct)	  22.00 (-4.76 pct)
  2:	  28.00 (0.00 pct)	  27.00 (3.57 pct)
  4:	  32.00 (0.00 pct)	  29.00 (9.37 pct)
  8:	  46.00 (0.00 pct)	  44.00 (4.34 pct)
 16:	  51.00 (0.00 pct)	  59.00 (-15.68 pct)
 32:	  82.00 (0.00 pct)	  86.00 (-4.87 pct)
 64:	 173.00 (0.00 pct)	 164.00 (5.20 pct)
128:	 396.00 (0.00 pct)	 400.00 (-1.01 pct)
256:	 48832.00 (0.00 pct)	 45504.00 (6.81 pct)
512:	 95104.00 (0.00 pct)	 96640.00 (-1.61 pct)


~~~~~~~~~~
~ tbench ~
~~~~~~~~~~

o NPS1

Clients:	tip			SWQUEUE
    1	 452.49 (0.00 pct)	 438.60 (-3.06 pct)
    2	 862.44 (0.00 pct)	 859.99 (-0.28 pct)
    4	 1604.27 (0.00 pct)	 1593.44 (-0.67 pct)
    8	 2966.77 (0.00 pct)	 3005.65 (1.31 pct)
   16	 5176.70 (0.00 pct)	 5263.86 (1.68 pct)
   32	 8205.24 (0.00 pct)	 8890.77 (8.35 pct)
   64	 13956.71 (0.00 pct)	 14600.43 (4.61 pct)
  128	 24005.50 (0.00 pct)	 25695.32 (7.03 pct)
  256	 32457.61 (0.00 pct)	 35580.53 (9.62 pct)
  512	 34345.24 (0.00 pct)	 39206.89 (14.15 pct)
 1024	 33432.92 (0.00 pct)	 38751.11 (15.90 pct)

o NPS2

Clients:	tip			SWQUEUE
    1	 453.73 (0.00 pct)	 447.49 (-1.37 pct)
    2	 861.71 (0.00 pct)	 849.51 (-1.41 pct)
    4	 1599.14 (0.00 pct)	 1604.38 (0.32 pct)
    8	 2951.03 (0.00 pct)	 2992.67 (1.41 pct)
   16	 5080.32 (0.00 pct)	 5318.28 (4.68 pct)
   32	 7900.41 (0.00 pct)	 7845.42 (-0.69 pct)
   64	 14629.65 (0.00 pct)	 14621.95 (-0.05 pct)
  128	 23155.88 (0.00 pct)	 24286.26 (4.88 pct)
  256	 33449.57 (0.00 pct)	 33606.58 (0.46 pct)
  512	 33757.47 (0.00 pct)	 37592.42 (11.36 pct)
 1024	 34823.14 (0.00 pct)	 38943.21 (11.83 pct)

o NPS4

Clients:	tip			SWQUEUE
    1	 450.14 (0.00 pct)	 444.69 (-1.21 pct)
    2	 863.26 (0.00 pct)	 859.65 (-0.41 pct)
    4	 1618.71 (0.00 pct)	 1604.36 (-0.88 pct)
    8	 2929.35 (0.00 pct)	 2996.47 (2.29 pct)
   16	 5114.04 (0.00 pct)	 5243.98 (2.54 pct)
   32	 7912.18 (0.00 pct)	 8200.71 (3.64 pct)
   64	 14424.72 (0.00 pct)	 14149.10 (-1.91 pct)
  128	 23614.97 (0.00 pct)	 24149.05 (2.26 pct)
  256	 34365.13 (0.00 pct)	 34244.24 (-0.35 pct)
  512	 34215.50 (0.00 pct)	 39799.28 (16.31 pct)
 1024	 35421.90 (0.00 pct)	 40460.77 (14.22 pct)


~~~~~~~~~~
~ stream ~
~~~~~~~~~~

o NPS1

- 10 Runs:

Test:		tip			SWQUEUE
 Copy:	 271317.35 (0.00 pct)	 281858.05 (3.88 pct)
Scale:	 205533.77 (0.00 pct)	 203003.11 (-1.23 pct)
  Add:	 221624.62 (0.00 pct)	 226854.06 (2.35 pct)
Triad:	 228500.68 (0.00 pct)	 224038.89 (-1.95 pct)

- 100 Runs:

Test:		tip			SWQUEUE
 Copy:	 317381.65 (0.00 pct)	 319745.64 (0.74 pct)
Scale:	 214145.00 (0.00 pct)	 210485.52 (-1.70 pct)
  Add:	 239243.29 (0.00 pct)	 233651.11 (-2.33 pct)
Triad:	 249477.76 (0.00 pct)	 241242.87 (-3.30 pct)

o NPS2

- 10 Runs:

Test:		tip			SWQUEUE
 Copy:	 277761.29 (0.00 pct)	 292487.03 (5.30 pct)
Scale:	 215193.83 (0.00 pct)	 209904.82 (-2.45 pct)
  Add:	 242725.75 (0.00 pct)	 239361.95 (-1.38 pct)
Triad:	 237253.44 (0.00 pct)	 249638.69 (5.22 pct)

- 100 Runs:

Test:		tip			SWQUEUE
 Copy:	 318082.10 (0.00 pct)	 318466.54 (0.12 pct)
Scale:	 219338.56 (0.00 pct)	 221856.65 (1.14 pct)
  Add:	 248118.20 (0.00 pct)	 252907.96 (1.93 pct)
Triad:	 247088.55 (0.00 pct)	 248171.73 (0.43 pct)

o NPS4

- 10 Runs:

Test:		tip			SWQUEUE
 Copy:	 273307.14 (0.00 pct)	 294527.85 (7.76 pct)
Scale:	 235715.23 (0.00 pct)	 232442.47 (-1.38 pct)
  Add:	 244500.40 (0.00 pct)	 243812.43 (-0.28 pct)
Triad:	 250600.04 (0.00 pct)	 249006.70 (-0.63 pct)

- 100 Runs:

Test:		tip			SWQUEUE
 Copy:	 345396.19 (0.00 pct)	 323605.07 (-6.30 pct)
Scale:	 241521.63 (0.00 pct)	 218688.02 (-9.45 pct)
  Add:	 261157.86 (0.00 pct)	 234725.46 (-10.12 pct)
Triad:	 267804.99 (0.00 pct)	 253017.71 (-5.52 pct)

~~~~~~~~~~~
~ netperf ~
~~~~~~~~~~~

o NPS1

Test:			tip			SWQUEUE
 1-clients:	 102839.97 (0.00 pct)	 98690.53 (-4.03 pct)
 2-clients:	 98428.08 (0.00 pct)	 97027.85 (-1.42 pct)
 4-clients:	 92298.45 (0.00 pct)	 93217.27 (0.99 pct)
 8-clients:	 85618.41 (0.00 pct)	 87393.58 (2.07 pct)
16-clients:	 78722.18 (0.00 pct)	 78607.48 (-0.14 pct)
32-clients:	 73610.75 (0.00 pct)	 70636.67 (-4.04 pct)
64-clients:	 55285.07 (0.00 pct)	 52613.62 (-4.83 pct)
128-clients:	 31176.92 (0.00 pct)	 35212.35 (12.94 pct)
256-clients:	 20011.44 (0.00 pct)	 18817.54 (-5.96 pct)

o NPS2

Test:			tip			SWQUEUE
 1-clients:	 103105.55 (0.00 pct)	 101318.80 (-1.73 pct)
 2-clients:	 98720.29 (0.00 pct)	 97809.70 (-0.92 pct)
 4-clients:	 92289.39 (0.00 pct)	 93771.16 (1.60 pct)
 8-clients:	 84998.63 (0.00 pct)	 85093.68 (0.11 pct)
16-clients:	 76395.81 (0.00 pct)	 78181.45 (2.33 pct)
32-clients:	 71110.89 (0.00 pct)	 70312.53 (-1.12 pct)
64-clients:	 49526.21 (0.00 pct)	 49030.94 (-1.00 pct)
128-clients:	 27917.51 (0.00 pct)	 31428.64 (12.57 pct)
256-clients:	 20067.17 (0.00 pct)	 18273.28 (-8.93 pct)

o NPS4

Test:			tip			SWQUEUE
 1-clients:	 102139.49 (0.00 pct)	 100629.37 (-1.47 pct)
 2-clients:	 98259.53 (0.00 pct)	 96639.21 (-1.64 pct)
 4-clients:	 91576.79 (0.00 pct)	 92032.50 (0.49 pct)
 8-clients:	 84742.30 (0.00 pct)	 85588.07 (0.99 pct)
16-clients:	 79540.75 (0.00 pct)	 78033.63 (-1.89 pct)
32-clients:	 71166.14 (0.00 pct)	 69080.28 (-2.93 pct)
64-clients:	 51763.24 (0.00 pct)	 44243.04 (-14.52 pct)
128-clients:	 27829.29 (0.00 pct)	 32188.25 (15.66 pct)
256-clients:	 24185.37 (0.00 pct)	 17669.40 (-26.94 pct)

~~~~~~~~~~~~~
~ unixbench ~
~~~~~~~~~~~~~

o NPS1

						tip			SWQUEUE
Hmean     unixbench-dhry2reg-1   	  41322625.19 (   0.00%)    40874894.71 *  -1.08%*
Hmean     unixbench-dhry2reg-512	6252491108.60 (   0.00%)  6253691168.43 (   0.02%)
Amean     unixbench-syscall-1    	   2501398.27 (   0.00%)     2524108.97 *  -0.91%*
Amean     unixbench-syscall-512  	   8120524.00 (   0.00%)     7596446.63 *   6.45%*
Hmean     unixbench-pipe-1    		   2359346.02 (   0.00%)     2429532.75 *   2.97%*
Hmean     unixbench-pipe-512		 338790322.61 (   0.00%)   343170761.60 *   1.29%*
Hmean     unixbench-spawn-1      	      4261.52 (   0.00%)        4554.10 *   6.87%*
Hmean     unixbench-spawn-512    	     64328.93 (   0.00%)       62585.87 *  -2.71%*
Hmean     unixbench-execl-1      	      3677.73 (   0.00%)        3655.40 *  -0.61%*
Hmean     unixbench-execl-512    	     11984.83 (   0.00%)       13248.56 (  10.54%)

o NPS2

						tip			SWQUEUE
Hmean     unixbench-dhry2reg-1   	  41311787.29 (   0.00%)    41100045.17 (  -0.51%)
Hmean     unixbench-dhry2reg-512	6243873272.76 (   0.00%)  6257834310.98 (   0.22%)
Amean     unixbench-syscall-1    	   2503190.70 (   0.00%)     2520187.83 *  -0.68%*
Amean     unixbench-syscall-512  	   8012388.13 (   0.00%)     7545705.57 *   5.82%*
Hmean     unixbench-pipe-1    		   2340486.25 (   0.00%)     2436643.73 *   4.11%*
Hmean     unixbench-pipe-512		 338965319.79 (   0.00%)   342560610.22 *   1.06%*
Hmean     unixbench-spawn-1      	      5241.83 (   0.00%)        5174.11 (  -1.29%)
Hmean     unixbench-spawn-512    	     65799.86 (   0.00%)       63879.27 *  -2.92%*
Hmean     unixbench-execl-1      	      3670.65 (   0.00%)        3634.26 *  -0.99%*
Hmean     unixbench-execl-512    	     13682.00 (   0.00%)       14002.70 (   2.34%)

o NPS4

						tip			SWQUEUE
Hmean     unixbench-dhry2reg-1   	  41025577.99 (   0.00%)    41588045.76 (   1.37%)
Hmean     unixbench-dhry2reg-512	6255568261.91 (   0.00%)  6257479983.24 (   0.03%)
Amean     unixbench-syscall-1    	   2507165.37 (   0.00%)     2519780.17 *  -0.50%*
Amean     unixbench-syscall-512  	   7458476.50 (   0.00%)     8140849.63 *  -9.15%*
Hmean     unixbench-pipe-1    		   2369301.21 (   0.00%)     2415933.77 *   1.97%*
Hmean     unixbench-pipe-512		 340299405.72 (   0.00%)   343206741.58 *   0.85%*
Hmean     unixbench-spawn-1      	      5571.78 (   0.00%)        5421.31 (  -2.70%)
Hmean     unixbench-spawn-512    	     63999.96 (   0.00%)       63968.08 (  -0.05%)
Hmean     unixbench-execl-1      	      3587.15 (   0.00%)        3619.10 *   0.89%*
Hmean     unixbench-execl-512    	     14184.17 (   0.00%)       13006.80 *  -8.30%*

~~~~~~~~~~~~~~~~
~ ycsb-mongodb ~
~~~~~~~~~~~~~~~~


o NPS1:

base:			298681.00 (var: 2.31%)
SWQUEUE			295218.00 (var: 0.15%) (-1.15%)

o NPS2:

base:			296570.00 (var: 1.01%)
SWQUEUE			293648.67 (var: 0.89%) (-0.98%)

o NPS4:

base			297181.67 (var: 0.46%)
SWQUEUE			290700.67 (var: 2.09%) (-2.18%)

~~~~~~~~~~~~~~~~~~
~ DeathStarBench ~
~~~~~~~~~~~~~~~~~~

o NPS1:

- 1 CCD

base:			1.00 (var: 0.27%)
SWQUEUE:		0.99 (var: 0.40%) (-0.83%)

- 2 CCD

base:			1.00 (var: 0.42%)
SWQUEUE:		1.02 (var: 0.40%) (2.52%)

- 4 CCD

base:			1.00 (var: 0.46%)
SWQUEUE:		1.04 (var: 1.08%) (4.63%)

- 8 CCD

base:			1.00 (var: 0.63%)
SWQUEUE:		0.99 (var: 7.18%) (-0.83%)

~~~~~~~~~~~~~~~~~~~~~~~~~~~
~ SPECjbb2015 - multi-JVM ~
~~~~~~~~~~~~~~~~~~~~~~~~~~~

		tip		SWQUEUE
max-jOPS	1.00		1.02  (+2.47%)   
critical-jOPS	1.00		1.02  (+1.72%)

--

I'll go back and check why netperf is unhappy using perf and IBS.
Meanwhile if there is any specific benchmark you would like me to run
on the test system, please do let me know.

> 
> It also seems logical that SIS_NODE would hurt performance a bit here,
> as all cores / CCXs are in the same NUMA node, so select_idle_sibling()
> has to iterate over 72 cores; delaying task wakeup. That said, I'm not
> sure that's a viable theory if total CPU% is lower with SIS_NODE.
> 
> [..snip..]
> 
 
--
Thanks and Regards,
Prateek
