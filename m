Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1460874E636
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjGKFHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGKFHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:07:09 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4100FE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:07:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDaCj8BqEDb1MKWXOciKIYkyGecIHZ1gqZGTfjLjg/Hq5kjOrnTtASoFBf9Tet44fnWK+6zg7uA3BSIOBph6dzlMPl3xzy196V6UUBJpSJr8gs2XznaD7eF5NqB8OiiklxbTeNGly89/S5zt29WWcNAJCWuYSqxLUT9/nXl8uHENRz0zpVymu6gxmWcRusBcM3s0R2VJKUh+Jrws22Y9jUonoWp6qlqL6m9w/ZTFB3gPq0gZgHBb10P4Ql5bFi2e+0ktbg3UKMTYc+HT4ns7Ko8IFfzgNu+5hAvYfF3lULbYPMK7rRX0y51lXVMdKTfQLTVtCsJzs2l0s1PGw3Yvcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6do8xMdMuVYQZ9l3t76tDnQm0IA3RS1H2eSMIp05188=;
 b=KhJJJtkKq57VoIMDv0OO6AhWMt64iOR1lKvWx/2ps+eAlOVbx4E2Oc4A6Ax5BguSB5O8BhQ2JyOXk7C437VwGvNy8a6QUnEnMLmLIpkebpDRXYSvzOMURsOMYUXjwIwIG31MQhyrTkpSHAvc2EBVFH/dL2P1I0Ok4CYlJXQOWoFtV+/IYRfuVUIS5rMY+IJwYUEHGqsUCZJY9l/O+4m32jptXDcvZ06yICqd82NwSepgO8u5hDCqK5j0WyCMkyc1XbW8l5Tcz+1uGVZcYM5Jgx1Z+Gih0DtPmb4fv04inoJmCy85HiBRxuv0O6xYE7jXL15eguyzVECOI5gV6l9SUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6do8xMdMuVYQZ9l3t76tDnQm0IA3RS1H2eSMIp05188=;
 b=Xet2K3XEhNFhceW9iS+/Y1StnCBiUc4E5nmluhPwfcaQrsYmahuUAY2SbyrDhW/9YLFYVMJc6qskLGJ5V1L4jlO/LyEnAcfDcUYSeEt0pvP1dVueHXhRwLkgxHmCOhTkAD2LxFZZimjq74SSbu5zqOK4Ace5BuklqnWUm1TRrrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MW6PR12MB9017.namprd12.prod.outlook.com (2603:10b6:303:23b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 05:07:02 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c%2]) with mapi id 15.20.6565.026; Tue, 11 Jul 2023
 05:07:01 +0000
Message-ID: <a4d1998c-9e84-9bbb-1916-849e94bb8d50@amd.com>
Date:   Tue, 11 Jul 2023 10:36:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 0/3] sched: Implement shared wakequeue in CFS
Content-Language: en-US
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joshdon@google.com,
        roman.gushchin@linux.dev, tj@kernel.org, kernel-team@meta.com
References: <20230613052004.2836135-1-void@manifault.com>
 <2b1fba1c-da7a-f7a0-552a-c6dbc7ac2b7e@amd.com>
 <20230711044345.GC376791@maniforge>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230711044345.GC376791@maniforge>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::9) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|MW6PR12MB9017:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d673a1-24dc-4046-e50a-08db81cca88b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TuT+YopNKBEQvhgDNKPik+hqDFgMJ1XrKHJn1mFwhB+HdUheDs5neZ1AGtFvzdOSugzHF1M8J2d3K94g7BAJryIPucdtaYRkN9BeMcriQpCYhN0a0iJV4v345GJdaDT9+ROLzDVzqgPLbOjDTdBJ/UW5oZM9/WDPvzXSXkqsgvYBVmA7u7IyvT8GnUa4/VVAmy63y3ry49qBr5DeUF88g3GG1iu4PJv6sB5fMGPuPjwCtYNNtX35es4RZNChi5zX9PnH2C9yTNCcXyftAFN2FnjeOsszEsNH7m6j9xFX67UoptZcmA7HEU/4tF/tOK5o7y1iP2F87o9S2o9BSwpm6VW/r4lBUDom9b2wz7aeehLOk1CrQlTUzAmTGWMqKcy3nliIloqC96Twi9Kum7CuyNdEV8weRWP4Y0uV5KCe4hrbvgWTX/WJv87YmiLfoCjkkOsBrkBoGBjI1wf46h4dP7IavqMWt7G+5YGnzxXh4mNvR3g4xqN1Vg+5r1BTi4LVOsbOCFPVzdYSY/7muytKbMV9CDDK1W3hOlDkRSqQJSKduvueIWA+XzRAubPYkZccAX1GJRhqphbr9YN9jrDriheOG/XtsnAzhNnmcecbM9OyrDYOfCIPBqAXBCfs8zAUXbyeK9KMQVtB9ukIk20e0oguYvRWe8QxBSga5tVnykzYlMYlV2FQLPdNAGQsPRIE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199021)(6512007)(966005)(38100700002)(83380400001)(26005)(53546011)(186003)(2616005)(6506007)(2906002)(30864003)(7416002)(5660300002)(8936002)(8676002)(6666004)(36756003)(66556008)(6486002)(478600001)(66476007)(4326008)(6916009)(86362001)(66946007)(316002)(31696002)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWEzVzcwWjk5RnRYUFd1ZkNKbXdyWWE0YW5ja1YycWEvc2l1V25TY1ZzNCtj?=
 =?utf-8?B?dHRFc2pEb0ttVlpEZEpacnRoQkNYS2h4aG14YVBaL1MrR1ZLNEhGRHFTejFL?=
 =?utf-8?B?SnpPQ21QR0dEVXdKVGVDbXJsU0tKSHJQRmszakNQSTh0T0Zpdm04WkFTTXQ3?=
 =?utf-8?B?ek1UZEk3ZzJMbldwSU9TMkJMWjNoYzBVUkdWUHJkSTZHZnFqd3ZvTExOa2R5?=
 =?utf-8?B?bVh2cnI1VDNDcTFCd1VrbUVyMU9NRlY3UmpubVMrN3BNaHhXSW5neUxzZVZm?=
 =?utf-8?B?d2E4UitwSEFIL0ZrS1RpMFlkc3dITmFtcUdiM0FoVjl0QXE4dmc5NWVsYk90?=
 =?utf-8?B?SEtpakhSM2FnZWlnUUMwWkh6RUVtaHVCZlNWL1VGKzFYLzRUd1JrMU9DZmVX?=
 =?utf-8?B?dExkOEV0eGNRWk1RTnZ4YWRoMUl3ZjJBUWRRbG1xZU1Jc05Qa2crcCszbm41?=
 =?utf-8?B?NHduYlFlSDFlb3B3Rk9kbU1pdTdMZWZXTlR3bEIwUXJTdVcvZSs2SnV4WXdH?=
 =?utf-8?B?azNJYVU0QmNYYUpKZ1dzT1J2d3ZOWDBmMEx1SGEzb0hNVkVGTVJmWGFCNlN5?=
 =?utf-8?B?UGU2dVVuZkplNjhWQVNDYkxkWkE1aWllZXhyL3dzQnRWaVp1cExoODdzajY5?=
 =?utf-8?B?VzFwN28vWFVEL3FMYTNzS21DQzE2cDYyMHZsQVlEZEFhZDFhRklLd3VIZXJ3?=
 =?utf-8?B?M2dQbG9kNmFETE93c0FhU1hsTEJxaW5aNFc2MzRJamxtbVRrRjlDMXY1WCtu?=
 =?utf-8?B?dGw0RVdoSXEwM1M3VE9YaHlRWW9uYys5SktFS0ZHVk00bkt6Z1ZDcWtucjlR?=
 =?utf-8?B?TVQyb1RPcHdiOTc5UlVpUnZTY3JqUlR0cWN1Wi9UMUZqTzlBc200bTdneU5x?=
 =?utf-8?B?MUFPMnlpa3RqOC8rQXI0V1V4Q1FaVmZXTWZOODkxbVFaUE9qWnRiWCt5MUQz?=
 =?utf-8?B?VDdJdThzalhtOTY4Y2p1ejJtY0doQXhYM21tYTZpQUNMMG1PT1o5Y3RNV1BT?=
 =?utf-8?B?bk9wM1FnSGRlVVBiRldVcFlRT1RBdnZheVFEY1AxaHV0UHcwcnJrUGEyTHQ3?=
 =?utf-8?B?a212Z01SRHVDYlhTNHg4SXIrb2VKWVd3NEdBQ2paeDFjREphMjNXVXhyeGJo?=
 =?utf-8?B?SXdmNkZ6TGVsaVcxSUlUVDZKNjZpRElEdEViS3YreHd3bmhVZ1c1QWJralMx?=
 =?utf-8?B?ZjF0V2F1andIT3cvN1RFZEVFd3Ewc1NoVXVWbmJ1TUorL2dhSEplZnQ2Mld6?=
 =?utf-8?B?dGhEalJWZnZOeGJTYUt2bUdUeHZ6QTVLOXFidFAwOEptYmFoTUJ1V1FyRjd5?=
 =?utf-8?B?S1poTWZ6MDI0MFdORFRJNXp6dU5BKzE3S28vaThDRkVOcEsyOFBtbGE5Tkxk?=
 =?utf-8?B?TDNmWFg5S3dRN2dYT1E0aGhnbVREQVR3aWg5djY1UDNRRUpxb1ZiODFJUVZD?=
 =?utf-8?B?aTlZczhHSHNZM1NOWWhjeVRUbkRhbERSOVI3MUZoQVBnTTlteXZFaENPWW9P?=
 =?utf-8?B?NE9GWUJRektMYkN3R1VuSmpyRk9SN241MmFWU2NXUGRrZkttWDlHZGtvZW9G?=
 =?utf-8?B?ajB5ZVl4eXlWUHNNSk5lUDBXMjJQeEp2WTVONWFNSjZ2c3ZRM2Q2eE8vcDAv?=
 =?utf-8?B?OGNEeFd5L0UyWk02VVZDQk5nOS91WmlaT1AvUmFXc2JnZFVvZTducUhTQVVD?=
 =?utf-8?B?V0N1TlJXQzR6Z1RidTdrZ2xPQjA3ckZyd3hKbTFrYzBtNFR5ampyVEZrQ1BX?=
 =?utf-8?B?aWJ0T2lobW5PWFBybnpacDM5ZHZuT2tTK2tYNVNmMHIyejAvTEQwcytNaWFM?=
 =?utf-8?B?ZmZTaDlzd1hqb3hYZDQ2SDlVWFpGNFIyb2dSeXZCTURuVkw1NHE1SzBGN0hD?=
 =?utf-8?B?K1NoS0JELzRuWm1DaTduWEhXTDhpUzFiQ3JYVVpSVlJhbC9GcEVBbVpENzlk?=
 =?utf-8?B?Q1dpdUg4RTZFZ01HdmV2ZStRR0wxSE9NTlNqT0g1V0FQUjVEUEs5NVgyekpL?=
 =?utf-8?B?Y3FWMDZhbWJ3Z2g2cTB5Q0hkVGJpeUFVMWtRUXhoeHY4V2FxV01oT0RYWkNu?=
 =?utf-8?B?d1RzMzNIaDlVUld4aWxJOUEzcCtFRXgxeDNXVDFySHppV2xRQW5OeUZPcFoy?=
 =?utf-8?Q?8gxDQ/N9Azly0B0W9cEIXAB6O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d673a1-24dc-4046-e50a-08db81cca88b
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 05:07:00.7917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trVacz4zeF1rC1VcOxQy7+m1ZrieRqC6nF7CgDofRz4YGeb45eR5NPCR8U3GtsZWCFYNaZW7iNgE96AFSaWMZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9017
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On 7/11/2023 10:13 AM, David Vernet wrote:
> On Mon, Jul 10, 2023 at 05:27:15PM +0530, K Prateek Nayak wrote:
>> Hello David,
>>
>> Sharing the results from testing SWQUEUE with some of the standard
>> benchmarks below.
> 
> Hello Prateek,
> 
> Thank you for taking the time to run these benchmarks. Very much
> appreciated. As I expect you saw given that I cc'd you, I sent v2 of
> this series out this morning in [0].
> 
> [0]: https://lore.kernel.org/all/20230710200342.358255-1-void@manifault.com/
> 
> There were quite a few changes, so if you have the bandwidth it may be
> worth running these benchmarks again on v2.

Sure. I'll continue further testing and analysis with v2.

> 
>> tl;dr
>>
>> - Hackbench, tbench, DeathStarBench and SPECjbb seem to like the
>>   SWQUEUE (except for hackbench in NPS4, with 16 groups)
> 
> Excellent, glad to hear that. I observed a significant improvement in
> hackbench as well on v2, glad to hear that other benchmarks seem to like
> this too.
> 
>>
>> - Netperf sees regression as system becomes more loaded. I'll go
>>   back and check if there is some lock contention issues here which
>>   is parallely being discussed on the tread.
> 
> Lock contention is indeed the issue, as Aaron pointed out in [1].
> 
> [1]: https://lore.kernel.org/lkml/20230614043529.GA1942@ziqianlu-dell/
> 
> Sharding the per-LLC shared runqueues helps quite a bit here, but it
> doesn't fully address the issue. See my write-up on the v2 cover letter
> for more info.

Will do.

> 
>>
>> - Other benchmarks seem to be behave similar to tip.
>>
>> On 6/13/2023 10:50 AM, David Vernet wrote:
>>> Overview
>>> ========
>>>
>>> The scheduler must constantly strike a balance between work
>>> conservation, and avoiding costly migrations which harm performance due
>>> to e.g. decreased cache locality. The matter is further complicated by
>>> the topology of the system. Migrating a task between cores on the same
>>> LLC may be more optimal than keeping a task local to the CPU, whereas
>>> migrating a task between LLCs or NUMA nodes may tip the balance in the
>>> other direction.
>>>
>>> With that in mind, while CFS is by and large mostly a work conserving
>>> scheduler, there are certain instances where the scheduler will choose
>>> to keep a task local to a CPU, when it would have been more optimal to
>>> migrate it to an idle core.
>>>
>>> An example of such a workload is the HHVM / web workload at Meta. HHVM
>>> is a VM that JITs Hack and PHP code in service of web requests. Like
>>> other JIT / compilation workloads, it tends to be heavily CPU bound, and
>>> exhibit generally poor cache locality. To try and address this, we set
>>> several debugfs (/sys/kernel/debug/sched) knobs on our HHVM workloads:
>>>
>>> - migration_cost_ns -> 0
>>> - latency_ns -> 20000000
>>> - min_granularity_ns -> 10000000
>>> - wakeup_granularity_ns -> 12000000
>>>
>>> These knobs are intended both to encourage the scheduler to be as work
>>> conserving as possible (migration_cost_ns -> 0), and also to keep tasks
>>> running for relatively long time slices so as to avoid the overhead of
>>> context switching (the other knobs). Collectively, these knobs provide a
>>> substantial performance win; resulting in roughly a 20% improvement in
>>> throughput. Worth noting, however, is that this improvement is _not_ at
>>> full machine saturation.
>>>
>>> That said, even with these knobs, we noticed that CPUs were still going
>>> idle even when the host was overcommitted. In response, we wrote the
>>> "shared wakequeue" (swqueue) feature proposed in this patch set. The
>>> idea behind swqueue is simple: it enables the scheduler to be
>>> aggressively work conserving by placing a waking task into a per-LLC
>>> FIFO queue that can be pulled from by another core in the LLC FIFO queue
>>> which can then be pulled from before it goes idle.
>>>
>>> With this simple change, we were able to achieve a 1 - 1.6% improvement
>>> in throughput, as well as a small, consistent improvement in p95 and p99
>>> latencies, in HHVM. These performance improvements were in addition to
>>> the wins from the debugfs knobs mentioned above.
>>>
>>> Design
>>> ======
>>>
>>> The design of swqueue is quite simple. An swqueue is simply a struct
>>> list_head, and a spinlock:
>>>
>>> struct swqueue {
>>> 	struct list_head list;
>>> 	spinlock_t lock;
>>> } ____cacheline_aligned;
>>>
>>> We create a struct swqueue per LLC, ensuring they're in their own
>>> cachelines to avoid false sharing between CPUs on different LLCs.
>>>
>>> When a task first wakes up, it enqueues itself in the swqueue of its
>>> current LLC at the end of enqueue_task_fair(). Enqueues only happen if
>>> the task was not manually migrated to the current core by
>>> select_task_rq(), and is not pinned to a specific CPU.
>>>
>>> A core will pull a task from its LLC's swqueue before calling
>>> newidle_balance().
>>>
>>> Difference between SIS_NODE
>>> ===========================
>>>
>>> In [0] Peter proposed a patch that addresses Tejun's observations that
>>> when workqueues are targeted towards a specific LLC on his Zen2 machine
>>> with small CCXs, that there would be significant idle time due to
>>> select_idle_sibling() not considering anything outside of the current
>>> LLC.
>>>
>>> This patch (SIS_NODE) is essentially the complement to the proposal
>>> here. SID_NODE causes waking tasks to look for idle cores in neighboring
>>> LLCs on the same die, whereas swqueue causes cores about to go idle to
>>> look for enqueued tasks. That said, in its current form, the two
>>> features at are a different scope as SIS_NODE searches for idle cores
>>> between LLCs, while swqueue enqueues tasks within a single LLC.
>>>
>>> The patch was since removed in [1], but we elect to compare its
>>> performance to swqueue given that as described above, it's conceptually
>>> complementary.
>>>
>>> [0]: https://lore.kernel.org/all/20230530113249.GA156198@hirez.programming.kicks-ass.net/
>>> [1]: https://lore.kernel.org/all/20230605175636.GA4253@hirez.programming.kicks-ass.net/
>>>
>>> I observed that while SIS_NODE works quite well for hosts with small
>>> CCXs, it can result in degraded performance on machines either with a
>>> large number of total cores in a CCD, or for which the cache miss
>>> penalty of migrating between CCXs is high, even on the same die.
>>>
>>> For example, on Zen 4c hosts (Bergamo), CCXs within a CCD are muxed
>>> through a single link to the IO die, and thus have similar cache miss
>>> latencies as cores in remote CCDs.
>>>
>>> Such subtleties could be taken into account with SIS_NODE, but
>>> regardless, both features are conceptually complementary sides of the
>>> same coin. SIS_NODE searches for idle cores for waking threads, whereas
>>> swqueue searches for available work before a core goes idle.
>>>
>>> Results
>>> =======
>>>
>>> Note that the motivation for the shared wakequeue feature was originally
>>> arrived at using experiments in the sched_ext framework that's currently
>>> being proposed upstream. The ~1 - 1.6% improvement in HHVM throughput
>>> is similarly visible using work-conserving sched_ext schedulers (even
>>> very simple ones like global FIFO).
>>>
>>> In both single and multi socket / CCX hosts, this can measurably improve
>>> performance. In addition to the performance gains observed on our
>>> internal web workloads, we also observed an improvement in common
>>> workloads such as kernel compile when running shared wakequeue. Here are
>>> the results of running make -j$(nproc) built-in.a on several different
>>> types of hosts configured with make allyesconfig on commit a27648c74210
>>> ("afs: Fix setting of mtime when creating a file/dir/symlink") on Linus'
>>> tree (boost was disabled on all of these hosts when the experiments were
>>> performed):
>>>
>>> Single-socket | 32-core | 2-CCX | AMD 7950X Zen4
>>>
>>> CPU max MHz:                     5879.8818
>>> CPU min MHz:                     3000.0000
>>> 				o____________o_______o
>>> 				|    mean    | CPU   |
>>> 				o------------o-------o
>>> NO_SWQUEUE + NO_SIS_NODE:	| 590.52s    | 3103% |
>>> NO_SWQUEUE + SIS_NODE:		| 590.80s    | 3102% |
>>> SWQUEUE + NO_SIS_NODE:		| 589.65s    | 3116% |
>>> SWQUEUE + SIS_NODE:		| 589.99s    | 3115% |
>>> 				o------------o-------o
>>>
>>> Takeaway: swqueue doesn't seem to provide a statistically significant
>>> improvement for kernel compile on my 7950X. SIS_NODE similarly does not
>>> have a noticeable effect on performance.
>>>
>>> -------------------------------------------------------------------------------
>>>
>>> Single-socket | 72-core | 6-CCX | AMD Milan Zen3
>>>
>>> CPU max MHz:                     3245.0190
>>> CPU min MHz:                     700.0000
>>> 				o_____________o_______o
>>> 				|    mean     | CPU   |
>>> 				o-------------o-------o
>>> NO_SWQUEUE + NO_SIS_NODE:	| 1608.69s    | 6488% |
>>> NO_SWQUEUE + SIS_NODE:		| 1610.24s    | 6473% |
>>> SWQUEUE + NO_SIS_NODE:		| 1605.80s    | 6504% |
>>> SWQUEUE + SIS_NODE:		| 1606.96s    | 6488% |
>>> 				o-------------o-------o
>>>
>>> Takeaway: swqueue does provide a small statistically significant
>>> improvement on Milan, but the compile times in general were quite long
>>> relative to the 7950X Zen4, and the Bergamo Zen4c due to the lower clock
>>> frequency. Milan also has larger CCXs than Bergamo, so it stands to
>>> reason that select_idle_sibling() will have an easier time finding idle
>>> cores inside the current CCX.
>>
>> o System Details
>>
>> Dual Socket 3rd Generation EPYC System (2 x 64C/128T)
> 
> Oh yeah, this would definitely run into contention on netperf. We were
> seeing it on smaller LLCs as well. Very curious to hear about how the
> sharded approach works for machines of this size.

I'll share the results on v2 when the tests finish.

> 
>> o NPS Modes
>>
>> NPS Modes are used to logically divide single socket into
>> multiple NUMA region.
>> Following is the NUMA configuration for each NPS mode on the system:
>>
>> NPS1: Each socket is a NUMA node.
>>     Total 2 NUMA nodes in the dual socket machine.
>>
>>     Node 0: 0-63,   128-191
>>     Node 1: 64-127, 192-255
>>
>> NPS2: Each socket is further logically divided into 2 NUMA regions.
>>     Total 4 NUMA nodes exist over 2 socket.
>>    
>>     Node 0: 0-31,   128-159
>>     Node 1: 32-63,  160-191
>>     Node 2: 64-95,  192-223
>>     Node 3: 96-127, 223-255
>>
>> NPS4: Each socket is logically divided into 4 NUMA regions.
>>     Total 8 NUMA nodes exist over 2 socket.
> 
> Do these logical NUMA regions all share the same LLC?

The NUMA regions will further contain multiple MCs which marks the LLC.
Sharding should have similar effect across the NPS modes since LLC size
remains the same.

> If so, I think the
> sharded approach is probably preferable to this, though I guess it
> depends on how bad the overhead is for newidle_balance() to walk all the
> shards to find an idle task.
> 
> [..snip..]
>>
>> I'll go back and check why netperf is unhappy using perf and IBS.
>> Meanwhile if there is any specific benchmark you would like me to run
>> on the test system, please do let me know.
> 
> Thanks very much for the time you're spending on this. I don't have any
> other specific benchmarks in mind. My only suggestion would be that your
> time is probably better spent experimenting with the v2 version of the
> patch set.
> 
> The only thing to bear in mind is that the series hard-codes the shard
> size at 6. We may want to make that configurable in a separate debugfs
> node. In the meantime, you just need to adjust SHARED_RUNQ_SHARD_SZ in
> [2].

I'll play around with a couple of values of SHARED_RUNQ_SHARD_SZ and pick
the benchmarks that show noticeable variation. I'll test them further
with more shared sizes. Let me know if I should take a different approach
at testing shard sizes.

> 
> [2]: https://lore.kernel.org/all/20230710200342.358255-7-void@manifault.com/
> 
> Thanks,
> David
 
--
Thanks and Regards,
Prateek
