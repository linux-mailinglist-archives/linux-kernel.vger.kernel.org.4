Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADF174D43C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjGJLHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGJLHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:07:43 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EF0DD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:07:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4cDmM+mjz3ApxRw+xHfRynGkEOCONDEA/Me124+gf18+8I/8X8yyBSpqQvg6wbcW+yU3P3EYjErJcHfZEyINM2foMhD6oZffCHiJFf97pz2fu7Qtq3q0KBPZS2dcVGumV+wkMEGOjfWvv+PC7oiZ+4WhUPSB8RXlpu2VIccdAm4HzObDy5kegI6e9+t4Aeqk3FGo8giXNPNjBzMKuTDZSDudz1qcLRCpo9D82vNAajSVz/+fvzWBPYcH2EWFJ68OEq35uIo0j4svef9hUF1M1x3QqaXNZEiKak4it2O5JUVpeJm8gIB5pa3JOVQlWH4fsvLTylZSh5dr3g08r09Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hw1dP2Xo5KIklY8lZxPZKuHI5vRAKDl/EOqSI/6SYVI=;
 b=U/yIKMtnCPKoZzIXjxyasOYxGOOjwLtR8o6vjxjFjC0g/GM6lGVaTcwXHup4+iy7Bbebkfb9KIV7SEOmZJCVAdy6XtVI/PTIQmCrOu0AB6+35lk6XB7Z7tAoUc7JCCeDSD7cW8Rzmmw3V1E4XW9pKmFn8/g3RklajFyIoQPLYjqUAPp0Xmed6ADupUlrkPvaNNGqL6bdRezy0Z3h1YXBME+2ggvQdudATTcaZBEug8vHRJdKiIw99nszu3T1MRdSQUV2xRmmA2k2YY7EpB/rw+IjNvw7pRxCNyAmq+cQ8geSi3IKo1w/k/5wbnpT1OYKP+CcOG+M3oLbVoDquV8HHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hw1dP2Xo5KIklY8lZxPZKuHI5vRAKDl/EOqSI/6SYVI=;
 b=k7BlAc2lwCkgQIBsnJFEhPRMLlzTjd2GD+s2H9TKMZYQ6cURQ8x6jzkr6k1lu+EZ1Ttp5BDEnAFRfJRsfMoFGZF59YnNoAsP6E7/9yVnCjtszTjgegtL9D3e1hvnwGU+KVKCXMgmvttkBLg4/txGnf+Vm9L4vVhOwGK2utPpgi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by PH7PR12MB7425.namprd12.prod.outlook.com (2603:10b6:510:200::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 11:07:03 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c%2]) with mapi id 15.20.6565.026; Mon, 10 Jul 2023
 11:07:03 +0000
Message-ID: <7e31ad34-ce2c-f64b-a852-f88f8a5749a6@amd.com>
Date:   Mon, 10 Jul 2023 16:36:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 3/4] sched/fair: Calculate the scan depth for idle
 balance based on system utilization
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-kernel@vger.kernel.org
References: <cover.1686554037.git.yu.c.chen@intel.com>
 <bc96b53efb712337a645e2c2a340975545ed5a28.1686554037.git.yu.c.chen@intel.com>
 <ZIqpI0ScCT5pmrAO@BLR-5CG11610CF.amd.com>
 <ZJKm195gy7X80wjm@chenyu5-mobl2.ccr.corp.intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZJKm195gy7X80wjm@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::12) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|PH7PR12MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f85e9b-264f-4c1e-8fc5-08db8135c962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wc6Xn3BqSRLOH14svfpomgkECuYw7D3oo8dIwzd2JaIWCd9JnhNaVFz5zhqSRRJmMuG1YKYnNTIv91toJlOmmj8JTzWj3011AtIqKwD6Fh9Lprx6j5tyUgwL1sJDWUmAQLXi26J2+AChV20jCNNCikkHwazTmIaV820H10YvAWwobH9CA1UqmxR9L2EP5Zrb/3LoVzpoQLD9Ry9BP9zrENeWn7kIMKL0HI87tb+BLQZMHVXfOuO1tr4EMbtbl3V6CHha2kIPLSfCKWFVEVMqhkoZ+Q7AmPgWxccrOUX6tdFpgC+ax2vcYsNObei4ZvpxRcrq6PdyPG0tNANZO4Wqh4xLWnN4qpHs0MlA8+6sndq3EVGANjOWO5TJlzAxqKrFdd1YwsR+zy2f2NbWPELNOfVcMI8r7059ACAlsdDjgGUsEVdVkHzyMMAy4Bc0iGFnlEzwPUy5Lfp00QMFJ5EJHuyeLoADtHrVWLyKLi7FDd+fuA95lh/FlIIEPqjseGjDjwljusoV9/QsesTXfWO4N/J2IlXYtGDR6z4O0NqluUdJ7aaaQvSfraPp7gb1LUNBZwBEagf30qpTg4ApENwWrvyA/r7DxU1+4K7uo/MCNTcVm5wKQsHE0gIDbadMx8flUN4bFElrrqQ6MqLjBBkSwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199021)(6506007)(26005)(53546011)(31686004)(83380400001)(2616005)(54906003)(38100700002)(30864003)(5660300002)(8676002)(8936002)(2906002)(66476007)(7416002)(186003)(6916009)(4326008)(66556008)(66946007)(86362001)(478600001)(31696002)(316002)(6666004)(6486002)(41300700001)(6512007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW9tQnM1YjFkTTF1MHNhVUtSMlpyaVd0VUo1T1B5c3hzRnUxREYrL3NZY0Nh?=
 =?utf-8?B?clpZN0ZGbkU3aTNkNzgycHlXWlUwZTNmUFRtNFk0ZkJPMnBmWVhyZjFZd0Yz?=
 =?utf-8?B?V0Fjb09WZXZSQkdWbkVjb3ozK3A2U0dQU3V0cUM3ZXJPclhBT0pKQlZYdlZ2?=
 =?utf-8?B?UVJCQk9WeWdRU0J1ajJWU2ZDUE5KaTdYaVhwNkl0QU5ycEdHZXZOVGg1cnI4?=
 =?utf-8?B?S3ZmQXFGNzQ0QVNhVG9xY2UwOEJCdVR4RktjN0lmL1VBNmNrSWNyT3o1LzN6?=
 =?utf-8?B?a1J1QStKU3h5MCttQ2pvOTdMemlOYzR2VW9xNnJPaFdaaXpUVW5ibmtOZVUz?=
 =?utf-8?B?eEw2NWVMSklxc3RjeEd0YXc0WllISUp2RmdhNFNUdHBBQnhRT2hHZS8yMWVC?=
 =?utf-8?B?dExjZVpaa3pXckJvbEUwdDFNYlFTUDJjczlDZmE4czdJT2ZuTkg4VzlFMTQx?=
 =?utf-8?B?L1czc3VRNWhQWTY1K2N2bWhVZWlYNE9OMFBydVgvQmVHZ2lPSzFacGp6OWJY?=
 =?utf-8?B?dGdVWTFGUG5EWUtPRWRBKzZPa1VDcW9vT1c3WlBXU0VZdTNxZ2EwRWpFZ2hJ?=
 =?utf-8?B?ZUhwcHRPNUdjVFlhcWFJdjBHaHZZUDc4eldOMnlXTWdvTmhpYU9JT0pqaVUz?=
 =?utf-8?B?d2VSRDhwM2l1bnpYeVdQdUR6a3VUS0dwZlpDdW16VHd2WkN6d3hFUmNXRElk?=
 =?utf-8?B?dWkvQU1YTkE0dEUvK0h2UEpWaWhqeVdsQVUxKzllVU1CZnlDd2dCVllZaW45?=
 =?utf-8?B?Ny9yZ2lOUURFdWdaOXFRTEdpL3JNZkRGeUtSUEhGSkxMa0ZJRVpQdW1SQW1j?=
 =?utf-8?B?WTVXNGNUK3hJVy82OGg2ZnpXVEU5cUxtU2V1N1lkZ3VTNHI4cFJORm5tbVBI?=
 =?utf-8?B?bk1ubE5RcHl2ZEROSktvWk1ybHQ5UENyTzZJMVJnUGNTdTM4NDlLR1gwMzY4?=
 =?utf-8?B?WUhTaVpyak9UcnVWYmZOQ0pZeENHL1luYVIxNjBXckVYQkh4SDR5MTE1UFFi?=
 =?utf-8?B?a3ZTak50ZzdNZTJqa0x0a1lzVVQvR0xhOTdvbXh3NktvQnI5TFllYWQvUFdP?=
 =?utf-8?B?WTNINkFnUW9mL09kTGNLRngwRGF4dHBBRm5hVm9pNmtQSG44M0JFTXF0SlBz?=
 =?utf-8?B?NERIdExXQ2NoRG1WQlhHT3RHY3RaaWhFb093V1NYRXgzUzlzNEd5VlRwRzBN?=
 =?utf-8?B?NHhWSzgvemp1OTNvdDFTelhzNGNCS1Zja05mUDA0d0Vad284ZjRVK1ZKSkxz?=
 =?utf-8?B?R1lNaHB3RDdBRTBYQks4d1FMUmJsZkFiaFljcUFUTTZZRHFNamFJcm1CTGsx?=
 =?utf-8?B?UytEcTZpMTlRNkQrV2pDS3h6ZnlFWmd6Z2RtZzBkQlBjK0ZmVmQ0TG5RcXps?=
 =?utf-8?B?K29wdHlkdXMxUXlJellQQk1FTkI3Vk94dU9RUy96UEpNd09GQUt2V3h6ckl1?=
 =?utf-8?B?WFNScmZPUmJZZXN1UlFocXVNYzR3bml4aWUrb3ZIVEsrdVVHUkpTUXBJeEx3?=
 =?utf-8?B?OFVLMndTcTlQQjJaTVBId2wzUzJ3MDlQZ2dWZFZQQWluamNwaWRJUVZ0VW5Z?=
 =?utf-8?B?c1BsdEhYNlUwa1VnR1dVamxDbnVhWEN5bjJLa2lnejBjbGF3K0ZLWXVibW5w?=
 =?utf-8?B?QVI4KzJ3QjhRZEp1VkpyMnJidHVKczBSQWt6bTAzZnlLRDZaSEkwOVVqWmY1?=
 =?utf-8?B?dEo3c0krYTRrTW9oQ0NkYWs0enFhbFVNQklJRkhHZWxZalJ4ODkvNmR6SGNS?=
 =?utf-8?B?ME9yTjFjMFl4d052TWFXeEsrWVVJZE5PbU9jUFZjak51a2EzRFBXYVBYUjhI?=
 =?utf-8?B?WC94dFBWekxleWdYWFhYMzFxbkMzS3RRbGRFYjZOd2g3dzJDdzhKWEI0Z0ZN?=
 =?utf-8?B?bTBwVFlrbnZ6dXp3eWM4UWh1RnJPNFhvMWI4ek9Wd3k5UkJZRW01NWZpMFYx?=
 =?utf-8?B?TFViNWsrUENFdXl6akNudmw4aWN5TW12Ym0zSkt1L0dlcFU4WVlSVExUanVV?=
 =?utf-8?B?dHRvKzhrZ3BjVHNxZEVCN2grTDNlYTZ4R1pSVHhvclZNVG1iNVFYNk56L2NH?=
 =?utf-8?B?eTIzSzBKSm5oL01PbkU4amk1czZCcU5Gc2NMMmw2Rm5HSEM5RXAzejhtQTgy?=
 =?utf-8?Q?rQLH6XEqfeujA8kInc++G3DoV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f85e9b-264f-4c1e-8fc5-08db8135c962
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 11:07:02.0899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 749LoX1XO10wZ7CYpH2nR6i5uZSJ2EOAXMecVD+XOtkgZhvg2qIhJIt30D/cwWCfjzTOSrJnihdypO0hOe1KpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7425
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

Thank you for sharing this extended version. Sharing the results from
testing below.

tl;dr

- tbench, netperf and unixbench-spawn see an improvement with ILB_UTIL.

- schbench (old) sees a regression in tail latency once system is heavily 
  loaded. DeathStarBench and SPECjbb too see a small drop under those
  conditions.

- Rest of the benchmark results do not vary much.

On 6/21/2023 12:59 PM, Chen Yu wrote:
> Hi Gautham,
> On 2023-06-15 at 11:31:07 +0530, Gautham R. Shenoy wrote:
>> Hello Chen Yu,
>>
>>
>> On Tue, Jun 13, 2023 at 12:18:57AM +0800, Chen Yu wrote:
>>> When CPU is about to enter idle, it invokes newidle_balance() to pull
>>> some tasks from other runqueues. Although there is per domain
>>> max_newidle_lb_cost to throttle the newidle_balance(), it would be
>>> good to further limit the scan based on overall system utilization.
>>> The reason is that there is no limitation for newidle_balance() to
>>> launch this balance simultaneously on multiple CPUs. Since each
>>> newidle_balance() has to traverse all the CPUs to calculate the
>>> statistics one by one, this total time cost on newidle_balance()
>>> could be O(n^2). This is not good for performance or power saving.
>>>
>>> For example, sqlite has spent quite some time on newidle balance()
>>> on Intel Sapphire Rapids, which has 2 x 56C/112T = 224 CPUs:
>>> 6.69%    0.09%  sqlite3     [kernel.kallsyms]   [k] newidle_balance
>>> 5.39%    4.71%  sqlite3     [kernel.kallsyms]   [k] update_sd_lb_stats
>>>
>>> Based on this observation, limit the scan depth of newidle_balance()
>>> by considering the utilization of the LLC domain. Let the number of
>>> scanned groups be a linear function of the utilization ratio:
>>>
>>
>> Is there any particular reason why this is being limited only to the
>> LLC domain ?
>>
>> On architectures where the LLC domain may not be so large (POWER9/10,
>> AMD), the additional cost is usually paid at the higher domains where
>> the number of groups is greater / equal to the number of groups in the
>> LLC domain and where sd_span is pretty large. It would be good to
>> explore avoiding the scan cost on those domains as well, right?
>>
>>> nr_groups_to_scan = nr_groups * (1 - util_ratio)
>>
>> If we can extend this logic to higher domains, on a Zen3 1 Socket
>> server with 128 CPUs at the DIE domain containing 8 groups, we can
>> expect a significant reduction in the time spent doing
>> update_sg_lb_stats() at higher utilizations.
>>
>> util_ratio     nr_groups_to_scan        nr_cpus_scanned
>> ========================================================
>> 0.9              1                       16     (-87.5%)
>> 0.75             2                       32     (-75%)
>> 0.5              4                       64     (-50%)
>> 0.25             6                       96     (-25%)
>> 0.1              7                      112     (-12.5%) 
>>
>>
>> On a Zen 4 1 socket server with 192 CPUs at the DIE domain containing
>> 12 groups, values will be:
>>
>> util_ratio     nr_groups_to_scan        nr_cpus_scanned
>> ========================================================
>> 0.9              1                       16     (-91%)
>> 0.75             3                       48     (-75%)
>> 0.5              6                       96     (-50%)
>> 0.25             9                      144     (-25%)
>> 0.1             10                      160     (-16.7%)
>>
> I have an idea to limit scan depth for newidle balance for big domains.
> These domains should have CPUs higher than/equals to LLC(MC domain).
> However it seems that in current kernel only domain with SD_SHARE_PKG_RESOURCES
> flag set will have the shared struct sched_domain_shared among the CPUs in this
> domain. And this is reasonable because the cost to access the struct sched_domain_shared
> is lower if the CPUs share cache. Since ILB_UTIL relies on the sched_domain_shared
> to get the scan depth, I removed the restriction of SD_SHARE_PKG_RESOURCES
> during sched_domain_shared assignment.
> If non-LLC domain's sched_domain_shared is only used for ILB_UTIL,
> the overhead should be not too high(only periodic load balance would
> write to sched_domain_shared). Here is a untest patch which shows what
> I'm thinking of, and I'll do some refinement based on this:
> 
> thanks,
> Chenyu
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 67b573d5bf28..ce7ffbb7b3f8 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -82,6 +82,10 @@ struct sched_domain_shared {
>  	atomic_t	nr_busy_cpus;
>  	int		has_idle_cores;
>  	int		nr_idle_scan;
> +	/* ilb scan depth and load balance statistic snapshot */
> +	int		ilb_nr_scan;
> +	unsigned long ilb_total_load;
> +	unsigned long ilb_total_capacity;
>  };
>  
>  struct sched_domain {
> @@ -152,6 +156,7 @@ struct sched_domain {
>  	struct sched_domain_shared *shared;
>  
>  	unsigned int span_weight;
> +	unsigned int nr_groups;
>  	/*
>  	 * Span of all CPUs in this domain.
>  	 *
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d724215826ae..34619dbb2f4e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10162,6 +10162,54 @@ static void update_idle_cpu_scan(struct lb_env *env,
>  		WRITE_ONCE(sd_share->nr_idle_scan, (int)y);
>  }
>  
> +/*
> + * Get the domain shared information of dst CPU.
> + */
> +static struct sched_domain_shared *get_sd_shared(struct lb_env *env)
> +{
> +	/*
> +	 * Do not consider the domains smaller than LLC because those
> +	 * small domains have low cost on idle load balance.
> +	 */
> +       if (env->sd->span_weight < per_cpu(sd_llc_size, env->dst_cpu))
> +               return NULL;
> +
> +       return env->sd->shared;
> +}
> +
> +static void update_ilb_group_scan(struct lb_env *env,
> +				  unsigned long sum_util,
> +				  struct sched_domain_shared *sd_share,
> +				  struct sd_lb_stats *sds)
> +{
> +	u64 tmp, nr_scan;
> +
> +	if (!sched_feat(ILB_UTIL) || env->idle == CPU_NEWLY_IDLE)
> +		return;
> +
> +	if(!sd_share)
> +		return;
> +	/*
> +	 * Limit the newidle balance scan depth based on overall system
> +	 * utilization:
> +	 * nr_groups_scan = nr_groups * (1 - util_ratio)
> +	 * and util_ratio = sum_util / (sd_weight * SCHED_CAPACITY_SCALE)
> +	 */
> +	nr_scan = env->sd->nr_groups * sum_util;
> +	tmp = env->sd->span_weight * SCHED_CAPACITY_SCALE;
> +	do_div(nr_scan, tmp);
> +	nr_scan = env->sd->nr_groups - nr_scan;
> +	if ((int)nr_scan != sd_share->ilb_nr_scan)
> +		WRITE_ONCE(sd_share->ilb_nr_scan, (int)nr_scan);
> +
> +	/* save the statistic snapshot of the periodic load balance */
> +	if (sds->total_load != sd_share->ilb_total_load)
> +		WRITE_ONCE(sd_share->ilb_total_load, sds->total_load);
> +
> +	if (sds->total_capacity != sd_share->ilb_total_capacity)
> +		WRITE_ONCE(sd_share->ilb_total_capacity, sds->total_capacity);
> +}
> +
>  /**
>   * update_sd_lb_stats - Update sched_domain's statistics for load balancing.
>   * @env: The load balancing environment.
> @@ -10170,11 +10218,17 @@ static void update_idle_cpu_scan(struct lb_env *env,
>  
>  static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sds)
>  {
> +	struct sched_domain_shared *sd_share = get_sd_shared(env);
>  	struct sched_group *sg = env->sd->groups;
>  	struct sg_lb_stats *local = &sds->local_stat;
>  	struct sg_lb_stats tmp_sgs;
>  	unsigned long sum_util = 0;
> -	int sg_status = 0;
> +	int sg_status = 0, nr_scan_ilb;
> +	bool ilb_util_enabled = sched_feat(ILB_UTIL) && env->idle == CPU_NEWLY_IDLE &&
> +	    sd_share && READ_ONCE(sd_share->ilb_total_capacity);
> +
> +	if (ilb_util_enabled)
> +		nr_scan_ilb = sd_share->ilb_nr_scan;
>  
>  	do {
>  		struct sg_lb_stats *sgs = &tmp_sgs;
> @@ -10192,6 +10246,17 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  
>  		update_sg_lb_stats(env, sds, sg, sgs, &sg_status);
>  
> +		if (ilb_util_enabled && --nr_scan_ilb <= 0) {
> +			/*
> +			 * Borrow the statistic of previous periodic load balance.
> +			 * The data might be stale and it is a trade-off.
> +			 */
> +			sds->total_load = READ_ONCE(sd_share->ilb_total_load);
> +			sds->total_capacity = READ_ONCE(sd_share->ilb_total_capacity);
> +
> +			break;
> +		}
> +
>  		if (local_group)
>  			goto next_group;
>  
> @@ -10239,6 +10304,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  	}
>  
>  	update_idle_cpu_scan(env, sum_util);
> +	update_ilb_group_scan(env, sum_util, sd_share, sds);
>  }
>  
>  /**
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index ee7f23c76bd3..8f6e5b08408d 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -85,6 +85,7 @@ SCHED_FEAT(RT_PUSH_IPI, true)
>  
>  SCHED_FEAT(RT_RUNTIME_SHARE, false)
>  SCHED_FEAT(LB_MIN, false)
> +SCHED_FEAT(ILB_UTIL, true)
>  SCHED_FEAT(ATTACH_AGE_LOAD, true)
>  
>  SCHED_FEAT(WA_IDLE, true)
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index d3a3b2646ec4..98bfac5f7836 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1023,7 +1023,7 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
>  	struct cpumask *covered = sched_domains_tmpmask;
>  	struct sd_data *sdd = sd->private;
>  	struct sched_domain *sibling;
> -	int i;
> +	int i, nr_groups = 0;
>  
>  	cpumask_clear(covered);
>  
> @@ -1087,6 +1087,8 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
>  		if (!sg)
>  			goto fail;
>  
> +		nr_groups++;
> +
>  		sg_span = sched_group_span(sg);
>  		cpumask_or(covered, covered, sg_span);
>  
> @@ -1100,6 +1102,7 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
>  		last->next = first;
>  	}
>  	sd->groups = first;
> +	sd->nr_groups = nr_groups;
>  
>  	return 0;
>  
> @@ -1233,7 +1236,7 @@ build_sched_groups(struct sched_domain *sd, int cpu)
>  	struct sd_data *sdd = sd->private;
>  	const struct cpumask *span = sched_domain_span(sd);
>  	struct cpumask *covered;
> -	int i;
> +	int i, nr_groups = 0;
>  
>  	lockdep_assert_held(&sched_domains_mutex);
>  	covered = sched_domains_tmpmask;
> @@ -1248,6 +1251,8 @@ build_sched_groups(struct sched_domain *sd, int cpu)
>  
>  		sg = get_group(i, sdd);
>  
> +		nr_groups++;
> +
>  		cpumask_or(covered, covered, sched_group_span(sg));
>  
>  		if (!first)
> @@ -1258,6 +1263,7 @@ build_sched_groups(struct sched_domain *sd, int cpu)
>  	}
>  	last->next = first;
>  	sd->groups = first;
> +	sd->nr_groups = nr_groups;
>  
>  	return 0;
>  }
> @@ -1641,14 +1647,12 @@ sd_init(struct sched_domain_topology_level *tl,
>  	}
>  
>  	/*
> -	 * For all levels sharing cache; connect a sched_domain_shared
> +	 * For all levels; connect a sched_domain_shared
>  	 * instance.
>  	 */
> -	if (sd->flags & SD_SHARE_PKG_RESOURCES) {
> -		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
> -		atomic_inc(&sd->shared->ref);
> -		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
> -	}
> +	sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
> +	atomic_inc(&sd->shared->ref);
> +	atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
>  
>  	sd->private = sdd;
>  

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

- ILB_UTIL	   - tip:sched/core + this patch

~~~~~~~~~~~~~
~ hackbench ~
~~~~~~~~~~~~~

o NPS1

Test:			tip			ILB_UTIL
 1-groups:	   3.92 (0.00 pct)	   3.66 (6.63 pct)
 2-groups:	   4.58 (0.00 pct)	   4.18 (8.73 pct)
 4-groups:	   4.99 (0.00 pct)	   4.46 (10.62 pct)
 8-groups:	   5.67 (0.00 pct)	   5.39 (4.93 pct)
16-groups:	   7.88 (0.00 pct)	  10.43 (-32.36 pct)

o NPS2

Test:			tip			ILB_UTIL
 1-groups:	   3.82 (0.00 pct)	   3.59 (6.02 pct)
 2-groups:	   4.40 (0.00 pct)	   4.08 (7.27 pct)
 4-groups:	   4.84 (0.00 pct)	   4.44 (8.26 pct)
 8-groups:	   5.45 (0.00 pct)	   6.32 (-15.96 pct)
16-groups:	   6.94 (0.00 pct)	  11.71 (-68.73 pct)

o NPS4

Test:			tip			ILB_UTIL
 1-groups:	   3.82 (0.00 pct)	   3.65 (4.45 pct)
 2-groups:	   4.44 (0.00 pct)	   4.19 (5.63 pct)
 4-groups:	   4.86 (0.00 pct)	   4.60 (5.34 pct)
 8-groups:	   5.42 (0.00 pct)	   5.36 (1.10 pct)
16-groups:	   6.68 (0.00 pct)	  10.09 (-51.04 pct)

~~~~~~~~~~~~~~~~~~
~ schbench (Old) ~
~~~~~~~~~~~~~~~~~~

o NPS1

#workers:	tip			ILB_UTIL
  1:	  26.00 (0.00 pct)	  26.00 (0.00 pct)
  2:	  27.00 (0.00 pct)	  28.00 (-3.70 pct)
  4:	  31.00 (0.00 pct)	  27.00 (12.90 pct)
  8:	  36.00 (0.00 pct)	  40.00 (-11.11 pct)
 16:	  49.00 (0.00 pct)	  50.00 (-2.04 pct)
 32:	  80.00 (0.00 pct)	  80.00 (0.00 pct)
 64:	 169.00 (0.00 pct)	 170.00 (-0.59 pct)
128:	 343.00 (0.00 pct)	 338.00 (1.45 pct)
256:	 42048.00 (0.00 pct)	 45760.00 (-8.82 pct)
512:	 95104.00 (0.00 pct)	 109696.00 (-15.34 pct)

o NPS2

#workers:	tip			ILB_UTIL
  1:	  23.00 (0.00 pct)	  21.00 (8.69 pct)
  2:	  24.00 (0.00 pct)	  25.00 (-4.16 pct)
  4:	  31.00 (0.00 pct)	  29.00 (6.45 pct)
  8:	  41.00 (0.00 pct)	  43.00 (-4.87 pct)
 16:	  48.00 (0.00 pct)	  50.00 (-4.16 pct)
 32:	  81.00 (0.00 pct)	  81.00 (0.00 pct)
 64:	 157.00 (0.00 pct)	 180.00 (-14.64 pct)
128:	 386.00 (0.00 pct)	 385.00 (0.25 pct)
256:	 48832.00 (0.00 pct)	 52032.00 (-6.55 pct)
512:	 92032.00 (0.00 pct)	 113024.00 (-22.80 pct)

o NPS4

#workers:	tip			ILB_UTIL
  1:	  21.00 (0.00 pct)	  23.00 (-9.52 pct)
  2:	  28.00 (0.00 pct)	  30.00 (-7.14 pct)
  4:	  32.00 (0.00 pct)	  33.00 (-3.12 pct)
  8:	  46.00 (0.00 pct)	  51.00 (-10.86 pct)
 16:	  51.00 (0.00 pct)	  54.00 (-5.88 pct)
 32:	  82.00 (0.00 pct)	  88.00 (-7.31 pct)
 64:	 173.00 (0.00 pct)	 175.00 (-1.15 pct)
128:	 396.00 (0.00 pct)	 387.00 (2.27 pct)
256:	 48832.00 (0.00 pct)	 46912.00 (3.93 pct)
512:	 95104.00 (0.00 pct)	 110720.00 (-16.41 pct)


~~~~~~~~~~
~ tbench ~
~~~~~~~~~~

o NPS1

Clients:	tip			ILB_UTIL
    1	 452.49 (0.00 pct)	 449.93 (-0.56 pct)
    2	 862.44 (0.00 pct)	 875.04 (1.46 pct)
    4	 1604.27 (0.00 pct)	 1626.23 (1.36 pct)
    8	 2966.77 (0.00 pct)	 3036.80 (2.36 pct)
   16	 5176.70 (0.00 pct)	 5402.88 (4.36 pct)
   32	 8205.24 (0.00 pct)	 9256.48 (12.81 pct)
   64	 13956.71 (0.00 pct)	 15581.58 (11.64 pct)
  128	 24005.50 (0.00 pct)	 24782.63 (3.23 pct)
  256	 32457.61 (0.00 pct)	 30810.66 (-5.07 pct)
  512	 34345.24 (0.00 pct)	 40971.90 (19.29 pct)
 1024	 33432.92 (0.00 pct)	 41604.06 (24.44 pct)

o NPS2

Clients:	tip			ILB_UTIL
    1	 453.73 (0.00 pct)	 444.72 (-1.98 pct)
    2	 861.71 (0.00 pct)	 853.67 (-0.93 pct)
    4	 1599.14 (0.00 pct)	 1573.69 (-1.59 pct)
    8	 2951.03 (0.00 pct)	 3021.87 (2.40 pct)
   16	 5080.32 (0.00 pct)	 5464.64 (7.56 pct)
   32	 7900.41 (0.00 pct)	 10304.44 (30.42 pct)
   64	 14629.65 (0.00 pct)	 17083.33 (16.77 pct)
  128	 23155.88 (0.00 pct)	 25278.86 (9.16 pct)
  256	 33449.57 (0.00 pct)	 32964.11 (-1.45 pct)
  512	 33757.47 (0.00 pct)	 40951.04 (21.30 pct)
 1024	 34823.14 (0.00 pct)	 41737.76 (19.85 pct)

o NPS4

Clients:	tip			ILB_UTIL
    1	 450.14 (0.00 pct)	 451.88 (0.38 pct)
    2	 863.26 (0.00 pct)	 864.96 (0.19 pct)
    4	 1618.71 (0.00 pct)	 1632.00 (0.82 pct)
    8	 2929.35 (0.00 pct)	 3071.80 (4.86 pct)
   16	 5114.04 (0.00 pct)	 5373.74 (5.07 pct)
   32	 7912.18 (0.00 pct)	 8830.49 (11.60 pct)
   64	 14424.72 (0.00 pct)	 15598.13 (8.13 pct)
  128	 23614.97 (0.00 pct)	 24563.76 (4.01 pct)
  256	 34365.13 (0.00 pct)	 32096.70 (-6.60 pct)
  512	 34215.50 (0.00 pct)	 42068.49 (22.95 pct)
 1024	 35421.90 (0.00 pct)	 42230.56 (19.22 pct)

~~~~~~~~~~
~ stream ~
~~~~~~~~~~

o NPS1

- 10 Runs:

Test:		tip			ILB_UTIL
 Copy:	 271317.35 (0.00 pct)	 304210.62 (12.12 pct)
Scale:	 205533.77 (0.00 pct)	 204155.75 (-0.67 pct)
  Add:	 221624.62 (0.00 pct)	 228757.07 (3.21 pct)
Triad:	 228500.68 (0.00 pct)	 236454.48 (3.48 pct)

- 100 Runs:

Test:		tip			ILB_UTIL
 Copy:	 317381.65 (0.00 pct)	 321587.90 (1.32 pct)
Scale:	 214145.00 (0.00 pct)	 211397.70 (-1.28 pct)
  Add:	 239243.29 (0.00 pct)	 235497.67 (-1.56 pct)
Triad:	 249477.76 (0.00 pct)	 240764.14 (-3.49 pct)

o NPS2

- 10 Runs:

Test:		tip			ILB_UTIL
 Copy:	 277761.29 (0.00 pct)	 279582.97 (0.65 pct)
Scale:	 215193.83 (0.00 pct)	 203628.71 (-5.37 pct)
  Add:	 242725.75 (0.00 pct)	 232522.80 (-4.20 pct)
Triad:	 237253.44 (0.00 pct)	 245716.42 (3.56 pct)

- 100 Runs:

Test:		tip			ILB_UTIL
 Copy:	 318082.10 (0.00 pct)	 320640.80 (0.80 pct)
Scale:	 219338.56 (0.00 pct)	 222158.47 (1.28 pct)
  Add:	 248118.20 (0.00 pct)	 254163.15 (2.43 pct)
Triad:	 247088.55 (0.00 pct)	 252459.53 (2.17 pct)

o NPS4

- 10 Runs:

Test:		tip			ILB_UTIL
 Copy:	 273307.14 (0.00 pct)	 269979.40 (-1.21 pct)
Scale:	 235715.23 (0.00 pct)	 225429.20 (-4.36 pct)
  Add:	 244500.40 (0.00 pct)	 227988.81 (-6.75 pct)
Triad:	 250600.04 (0.00 pct)	 234012.67 (-6.61 pct)

- 100 Runs:

Test:		tip			ILB_UTIL
 Copy:	 345396.19 (0.00 pct)	 335548.25 (-2.85 pct)
Scale:	 241521.63 (0.00 pct)	 228991.04 (-5.18 pct)
  Add:	 261157.86 (0.00 pct)	 247020.34 (-5.41 pct)
Triad:	 267804.99 (0.00 pct)	 258260.01 (-3.56 pct)

~~~~~~~~~~~
~ netperf ~
~~~~~~~~~~~

o NPS1

Test:			tip			ILB_UTIL
 1-clients:	 102839.97 (0.00 pct)	 101826.77 (-0.98 pct)
 2-clients:	 98428.08 (0.00 pct)	 98563.25 (0.13 pct)
 4-clients:	 92298.45 (0.00 pct)	 95310.26 (3.26 pct)
 8-clients:	 85618.41 (0.00 pct)	 87859.85 (2.61 pct)
16-clients:	 78722.18 (0.00 pct)	 79430.42 (0.89 pct)
32-clients:	 73610.75 (0.00 pct)	 76459.08 (3.86 pct)
64-clients:	 55285.07 (0.00 pct)	 64071.43 (15.89 pct)
128-clients:	 31176.92 (0.00 pct)	 37287.20 (19.59 pct)
256-clients:	 20011.44 (0.00 pct)	 31243.73 (56.12 pct)

o NPS2

Test:			tip			ILB_UTIL
 1-clients:	 103105.55 (0.00 pct)	 99162.95 (-3.82 pct)
 2-clients:	 98720.29 (0.00 pct)	 96055.84 (-2.69 pct)
 4-clients:	 92289.39 (0.00 pct)	 92818.61 (0.57 pct)
 8-clients:	 84998.63 (0.00 pct)	 86693.17 (1.99 pct)
16-clients:	 76395.81 (0.00 pct)	 77137.01 (0.97 pct)
32-clients:	 71110.89 (0.00 pct)	 70154.80 (-1.34 pct)
64-clients:	 49526.21 (0.00 pct)	 55032.79 (11.11 pct)
128-clients:	 27917.51 (0.00 pct)	 36377.03 (30.30 pct)
256-clients:	 20067.17 (0.00 pct)	 27607.78 (37.57 pct)

o NPS4

Test:			tip			ILB_UTIL
 1-clients:	 102139.49 (0.00 pct)	 103414.93 (1.24 pct)
 2-clients:	 98259.53 (0.00 pct)	 101472.40 (3.26 pct)
 4-clients:	 91576.79 (0.00 pct)	 96917.69 (5.83 pct)
 8-clients:	 84742.30 (0.00 pct)	 90389.72 (6.66 pct)
16-clients:	 79540.75 (0.00 pct)	 85183.23 (7.09 pct)
32-clients:	 71166.14 (0.00 pct)	 78511.48 (10.32 pct)
64-clients:	 51763.24 (0.00 pct)	 61334.30 (18.49 pct)
128-clients:	 27829.29 (0.00 pct)	 35989.34 (29.32 pct)
256-clients:	 24185.37 (0.00 pct)	 35769.17 (47.89 pct)

~~~~~~~~~~~~~
~ unixbench ~
~~~~~~~~~~~~~

o NPS1

						tip			ILB_UTIL
Hmean     unixbench-dhry2reg-1   	  41322625.19 (   0.00%)    41202944.91 (  -0.29%)
Hmean     unixbench-dhry2reg-512	6252491108.60 (   0.00%)  6193511930.01 *  -0.94%*
Amean     unixbench-syscall-1    	   2501398.27 (   0.00%)     2558258.57 *  -2.27%*
Amean     unixbench-syscall-512  	   8120524.00 (   0.00%)     8014692.00 *   1.30%*
Hmean     unixbench-pipe-1    		   2359346.02 (   0.00%)     2395716.82 *   1.54%*
Hmean     unixbench-pipe-512		 338790322.61 (   0.00%)   339462110.52 (   0.20%)
Hmean     unixbench-spawn-1      	      4261.52 (   0.00%)        4786.09 *  12.31%*
Hmean     unixbench-spawn-512    	     64328.93 (   0.00%)       68328.36 *   6.22%*
Hmean     unixbench-execl-1      	      3677.73 (   0.00%)        3671.96 (  -0.16%)
Hmean     unixbench-execl-512    	     11984.83 (   0.00%)       13272.01 (  10.74%)

o NPS2

						tip			ILB_UTIL
Hmean     unixbench-dhry2reg-1   	  41311787.29 (   0.00%)    41209738.92 (  -0.25%)
Hmean     unixbench-dhry2reg-512	6243873272.76 (   0.00%)  6198007442.15 *  -0.73%*
Amean     unixbench-syscall-1    	   2503190.70 (   0.00%)     2559295.30 *  -2.24%*
Amean     unixbench-syscall-512  	   8012388.13 (   0.00%)     7984268.83 *   0.35%*
Hmean     unixbench-pipe-1    		   2340486.25 (   0.00%)     2395174.42 *   2.34%*
Hmean     unixbench-pipe-512		 338965319.79 (   0.00%)   339972146.39 (   0.30%)
Hmean     unixbench-spawn-1    		      5241.83 (   0.00%)        5041.98 *  -3.81%*
Hmean     unixbench-spawn-512  		     65799.86 (   0.00%)       68871.88 *   4.67%*
Hmean     unixbench-execl-1    		      3670.65 (   0.00%)        3659.10 (  -0.31%)
Hmean     unixbench-execl-512  		     13682.00 (   0.00%)       13984.58 (   2.21%)

o NPS4

						tip			ILB_UTIL
Hmean     unixbench-dhry2reg-1   	  41025577.99 (   0.00%)    41039940.89 (   0.04%)
Hmean     unixbench-dhry2reg-512	6255568261.91 (   0.00%)  6216198481.97 *  -0.63%*
Amean     unixbench-syscall-1    	   2507165.37 (   0.00%)     2553468.33 *  -1.85%*
Amean     unixbench-syscall-512  	   7458476.50 (   0.00%)     7483366.27 *  -0.33%*
Hmean     unixbench-pipe-1    		   2369301.21 (   0.00%)     2397653.84 *   1.20%*
Hmean     unixbench-pipe-512		 340299405.72 (   0.00%)   340332182.64 (   0.01%)
Hmean     unixbench-spawn-1      	      5571.78 (   0.00%)        5389.50 (  -3.27%)
Hmean     unixbench-spawn-512    	     63999.96 (   0.00%)       68343.41 *   6.79%*
Hmean     unixbench-execl-1      	      3587.15 (   0.00%)        3628.48 *   1.15%*
Hmean     unixbench-execl-512    	     14184.17 (   0.00%)       13720.55 (  -3.27%)

~~~~~~~~~~~~~~~~
~ ycsb-mongodb ~
~~~~~~~~~~~~~~~~

o NPS1:

base:			298681.00 (var: 2.31%)
ILB_UTIL		292352.67 (var: 3.31%) (-2.11%)

o NPS2:

base:			296570.00 (var: 1.01%)
ILB_UTIL		298804.67 (var: 1.50%) (0.75%)

o NPS4:

base			297181.67 (var: 0.46%)
ILB_UTIL		297495.00 (var: 0.33%) (0.10%)

~~~~~~~~~~~~~~~~~~
~ DeathStarBench ~
~~~~~~~~~~~~~~~~~~

o NPS1:

- 1 CCD

base:			1.00 (var: 0.27%)
ILB_UTIL:		1.03 (var: 0.16%) (+3.31%)

- 2 CCD

base:			1.00 (var: 0.42%)
ILB_UTIL:		1.01 (var: 0.19%) (+1.48%)

- 4 CCD

base:			1.00 (var: 0.46%)
ILB_UTIL:		0.98 (var: 0.17%) (-2.00%)

- 8 CCD

base:			1.00 (var: 0.63%)
ILB_UTIL:		0.96 (var: 0.46%) (-3.79%)

~~~~~~~~~~~~~~~~~~~~~~~~~~~
~ SPECjbb2015 - multi-JVM ~
~~~~~~~~~~~~~~~~~~~~~~~~~~~

max-jOPS	1.00		0.99  (-1.11%)  
critical-jOPS	1.00		0.99  (-1.06%)

--

I have a couple of theories:

o Either new_idle_balance is failing to find an overloaded busy rq as a
  result of the limit.

o Or, there is a chain reaction where pulling from a loaded rq which is not
  the most loaded, will lead to more new_idle_balancing attempts which is
  degrading performance.

I'll go back and get some data to narrow down the cause. Meanwhile if
there is any specific benchmark you would like me to run on the test
system, please do let me know.

--
Thanks and Regards,
Prateek
