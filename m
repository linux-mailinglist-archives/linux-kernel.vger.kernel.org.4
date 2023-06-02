Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C1071F8C4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 05:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjFBDMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 23:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjFBDMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 23:12:48 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2721B0;
        Thu,  1 Jun 2023 20:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZIMHQmvKN39K1tKfHrPbcX4RDKQw66uDhJg0OBhl6Nda2GPCzoarQ0KrR2swBoGUBf80GrPpdZ995SYQ+8dxrXISgHF0QWOPIbWK7+PqVJEEgl7qnDqKZmqxlPcRilU2JOhqU3QIwjsKKkDSq2vMdRE8t5VxI+6dl9LSgXf7TdivjSkQ38Y4yvG5IjZ74CgrhZXcGMCZ8thjDE3DPOirr5HxhhXRKUYzSxVEJsLsmJPYsauibOqFlpXfWjjewnyw38Z9yK/meBqw+Bn0cQYtsai8neHZhP/VXvL5laj9lcpcEGMeDw6Roz7V8q0Eyz3doluhfHKj8It476vv94bzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QF0BFaetOZZXG9s5pCp0I6upk7SZC8U3fjxBsz9PJg=;
 b=JQ2hCF8CB9KPKqqkkMDu1h3JTRmZzpX9ZrO9yowjmpLL0uqOStRFuRl2Un3Gi7xXBvR6Y0d0bATBYTimN9BL4m2mylV98XhOwmmnYSji82WoWPaHLhIYQyFmCZPYmA4Pll0tLCuAxUkA4zUvVgcYSo+/wfeFlx/xXKQT+1D/GJ5SfnomHxcAp4G/rWDXsliz1PELlceg9DXRdiObg0p8f1DuWPJt4X1IgSt/lMIcJZso/89vlVSV1XoabQ20QyeB5Yg/hbx+kti6NHIRgKUJ6LP4zx/VniQwiXVyb3Nt8cF+EPbQlIxQT9lPIbpNs36+Hxgd+327+xNemPr6bqqzIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QF0BFaetOZZXG9s5pCp0I6upk7SZC8U3fjxBsz9PJg=;
 b=Zp41ZjQrpo7cdWjVBfsaAxxzmmRMRKRA1CSF3SHg0/s9BRvHrpoFiWmA9IYY7fL2b0xZGdue/4kyClTCDhv9s8B4rXvjOihrckBSBfPBt71lLbPWXgzx/0wY9RJJly+uB82OcD2Pww27HCVNzl5b3ua4musn/DyXbmqTjVs1OUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 03:12:43 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c%4]) with mapi id 15.20.6433.022; Fri, 2 Jun 2023
 03:12:43 +0000
Message-ID: <fb09519b-0057-fa0b-ebcb-cf21144dca6c@amd.com>
Date:   Fri, 2 Jun 2023 08:42:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        Gautham Shenoy <gautham.shenoy@amd.com>
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
 <3de5c24f-6437-f21b-ed61-76b86a199e8c@amd.com>
 <20230601111326.GV4253@hirez.programming.kicks-ass.net>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230601111326.GV4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::9) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|MN2PR12MB4344:EE_
X-MS-Office365-Filtering-Correlation-Id: 85cd80a5-aff8-4abb-b08b-08db63173ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4OCO766F5IrYgPXxFM7JV8R/6NzATDruB+eXvo4ftQ6eIX/sqC+/AxPdnxHN7VWAOEoUUHEpglTtFaPDTmkiM2ZURwNI/P41VY8iart6UkN4lhi2z0v/oRqL+iD05HWVtQaEf0K7SqeVDyzbq6MHthJ53MMkFkLXerCaKT8sPa8Ugg7MOgtZ0IOaPNY5QhA4+Dh0ZecNsRdYNhfLo/5h2bGn/FgsFmN1BX4rHY+tBGrBfW7Yr/TFwshouJ6jWjE068S4+fDnBIAFQFcXsdv1FPaOz2yJbFcwxGklgwxeT9REk48n/OUoENC5pn9+nc1pkFUS2M/jX5mHMeic/OcnoI2/Mxvs2VQgOgAXwP/NIEJNpb22vry4EDP8hcdh9TbV7ww4PWrhxwYkEhAUboDFHFNhoLokc62ODZ7JL78h3qk5gZf815wihnrhH95Ra/VC1TKy8dr+wN3toYmHOED0RuF2te+PpgrIKUdcpwmHR5lls5KYqR6PHCajondrOW10fJXIlekbFeFHC4/NncviSCgaXVTlNsUwxx104dY7M8faRnsdCeyUtZPWL7oSF3S+mmsmJubFYRtjTr86AYqOCgGRTuNNw5b56F+pqy2gYW0ZXStHKUBKU6RQxThaYkL+DDTviKoieL+w1BiyWk8hMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(38100700002)(2616005)(41300700001)(6506007)(26005)(6486002)(6512007)(31686004)(6666004)(53546011)(186003)(478600001)(54906003)(36756003)(6916009)(66476007)(66556008)(66946007)(4326008)(86362001)(316002)(8936002)(2906002)(31696002)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjRwdGFjOHZCMk1ET1J3NXFQc1VLVVZLRzZDTmR1WG5FWUFXRHg1dEtnaUd0?=
 =?utf-8?B?WC91OVl5dURMRkdmTHg1ZEZxZmk0a3VGUVN2SU80dFN4cDdDdlpUOHNlTUl1?=
 =?utf-8?B?bE5ibCtXamlOUXpLaDhtenlKKzJoRitZYlA0VmI0U3ZYNVRhVFR2ZjJsWHJD?=
 =?utf-8?B?UVB0TGVNa2t2U0lVZkpWYzZXMTUwVE9vZHBtRHZmY2hqSHQxYUsrU2x0V2p1?=
 =?utf-8?B?bFJtZTB3UXNUV1Z1QjFWSnBjbHpBT3JLTXJoWnkwbFBUTUc4QUhxcGQvbUd5?=
 =?utf-8?B?VVREOEFTNEowOHNBK2RGMEdQUzhJTDNCTFJZT1pCb3ZHbWlNdUZya21nNGpC?=
 =?utf-8?B?L3VtVk5FVXdsZW9mL1c0Ymd1RVl5Sm1PUTN3eExDYklTWjdpRVoxdnM2eXp4?=
 =?utf-8?B?bElVOHNtakdhcDRFemtzeFRoQm1tVW9ZaTNYRmZlNVloUy9meVBLcW9VL3l2?=
 =?utf-8?B?TWl1VnZVczZHbXNoUk9DN3ZvLzk4SDE3UmM1OXZKaVBVRDh5YXNBV045eE1l?=
 =?utf-8?B?N1VMQ0QvVVh0VUp0NFFKTExFNGNDS3dwSjRnZHdqNkZid2RiajVNSjU5aE9r?=
 =?utf-8?B?RTUzUXF0LzJMYkcvaWVLQnFtZmp0Smt3eVVjRlZXdVZTOTZQdk9udGV6TEtW?=
 =?utf-8?B?d3NqL1JtTHlvQ1hkd1IvRFpyNDF5dE5OOGIvc2N3bWxTckdnakp1VUtYNnZn?=
 =?utf-8?B?Q0dFZjErTDBEdjlOUEhqNWR4ZXpxTXIxcGFjNzNldlIvOWJ2U2ZpZjhuYTg3?=
 =?utf-8?B?TFl4TlVnbTJUdEtjMkdaTEMwM1p2K3pxT3hnNktCTTdxb1pISmlhdldJK2Ni?=
 =?utf-8?B?TzlIT1g1TE1tclBkVjliMlBnL0o2am8wM3l4cVlxNzc2Vm5wYThMc1ZLYUtF?=
 =?utf-8?B?bUJMMHRydGx6N2JEVDdmQ0JVaFZNeDVxV0MzMlJmV3VwN0hTWlJCcnVmMTRj?=
 =?utf-8?B?WTU3YTV2QTQvUEhxWUcxS3JuaVZWWTIydFdYV3ZjQWRIWDlzZmJFZWYzK2Vs?=
 =?utf-8?B?eGQ4eU93QmJzc3pMV1d6SHduZWdQS2w0YkhEVTZxci8zdCtjdmxoM3RPU2Vu?=
 =?utf-8?B?eU5lYlIyQlQyVDV5YW9lMzF1eEY2aVZYUXdNazJOa3NSb0ZDUjFEOStoSVBF?=
 =?utf-8?B?a1kyNlVtdXNsdXY0UlFSWEdjQk5aV3pxNXFUK1lQeDQ1VWtSNlR2VzQvQWRx?=
 =?utf-8?B?QzVDSExscHJhUkZQdytPc3UvWlBCUXBPbngrWityejlqaWhmUDBCZENKbVFP?=
 =?utf-8?B?VWxUdktvdVM2NGJhMHdSSVNycDgrbjZNZ2NKZG1HaUJ1enZvMVhobks2anJo?=
 =?utf-8?B?WXFnNTB0MlhIWll3KzRxZ2dmQ09wVjBWMXo3Ym1VQnB4M2VwVTZDVFpUUW4w?=
 =?utf-8?B?MmVOSEF3bVEwdzVYRzIwS0hDSmt6bWExS2lBNWxMaDFQOURxVGEwbHBKYWlY?=
 =?utf-8?B?V1Excld4eEdmaEUvaThsc3RjQzVIazFTWnlnOXMvR0VSS0dieDNSK3lyb2gx?=
 =?utf-8?B?RlhhVmI3OUdCeXErRnA5RnJSNXRwak16NWhzSkZkb1NDeTR6Rmt2TEhzOFRQ?=
 =?utf-8?B?bFJ0Vzh1Y3U4UXVmWlpyNDg1SjRwZnZxZ2NoWTFlUFYrV1Y0Njk4d0hwbExX?=
 =?utf-8?B?eEY3Q05FNkc5UmZJTjZTTUxHUThUWWFJYkNzZ3l5d3ZPcEprM0lidjJmZDA4?=
 =?utf-8?B?SG80elkxbHo2QmtKcFNOWURmY2Y5Y3dLL1B5NVBIelZ0R3QvSG1NdkRNaTdT?=
 =?utf-8?B?RHlUNmxydHRHUjJFU0lQZnMwQlk5ZVExMUd4UVc5KzIvaTZsakFvZ3RKY1dp?=
 =?utf-8?B?N0hiYXhSVFNwZXZuUFBiUGdVd0l4YXRnaU55ZXlrRmVTalVVUlNxN1J4MG9C?=
 =?utf-8?B?YVdrVTBLeHkxaWY4c3owcVlwemxLRHh6QWQwZDFKUkY5RURUMVZNcFNCYTBV?=
 =?utf-8?B?ZkFyNVVIMDZ2RUo4ZjN4dEFMZmlEZ0tYUEtrMkJuSm10WXRGcWJJTUxTOEFG?=
 =?utf-8?B?WUlZOG5MVktBQlMrYWVsT3NIVHV2dFptMlZvOHBaekNxUGtRNUU5aTJRY1g0?=
 =?utf-8?B?dUhTeW5GM3RqWG5HbmNsejZ2Y2FWcWhzbTR4YTl4T3htUHVCTTJ2ZVJsMFFq?=
 =?utf-8?Q?hMWXDJBa2B8KSaQC8GA/K2Npa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cd80a5-aff8-4abb-b08b-08db63173ac0
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 03:12:42.8252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhalebdwWQqog7woKwOPiZimaacsqAx2BhiNfBKBhTeaqOJJefnPgCa9wv+2jBUp0eRx7SHqdb2eNyCu8241ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344
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

Thank you for taking a look at the report.

On 6/1/2023 4:43 PM, Peter Zijlstra wrote:
> On Thu, Jun 01, 2023 at 03:03:39PM +0530, K Prateek Nayak wrote:
>> Hello Peter, 
>>
>> Sharing some initial benchmark results with the patch below.
>>
>> tl;dr
>>
>> - Hackbench starts off well but performance drops as the number of groups
>>   increases.
>>
>> - schbench (old), tbench, netperf see improvement but there is a band of
>>   outlier results when system is fully loaded or slightly overloaded.
>>
>> - Stream and ycsb-mongodb are don't mind the extra search.
>>
>> - SPECjbb (with default scheduler tunables) and DeathStarBench are not
>>   very happy.
> 
> Figures :/ Every time something like this is changed someone gets to be
> sad..
> 
>> Tests were run on a dual socket 3rd Generation EPYC server(2 x64C/128T)
>> running in NPS1 mode. Following it the simplified machine topology:
> 
> Right, Zen3 8 cores / LLC, 64 cores total give 8 LLC per node.

Yes, correct!

> 
>> ~~~~~~~~~~~~~~~~~~~~~~~
>> ~ SPECjbb - Multi-JVM ~
>> ~~~~~~~~~~~~~~~~~~~~~~~
>>
>> o NPS1
>>
>> - Default Scheduler Tunables
>>
>> kernel			max-jOPS		critical-jOPS
>> tip			100.00%			100.00%
>> peter-next-level	 94.45% (-5.55%)	 98.25% (-1.75%)
>>
>> - Modified Scheduler Tunables
>>
>> kernel			max-jOPS		critical-jOPS
>> tip			100.00%			100.00%
>> peter-next-level	100.00% (0.00%)		102.41% (2.41%)
> 
> I'm slightly confused, either the default or the tuned is better. Given
> it's counting ops, I'm thinking higher is more better, so isn't this an
> improvement in the tuned case?

Default is bad. I believe migrating across the LLC boundary is not that
great from cache efficiency perspective here. Setting the tunables
makes task run for longer, and in that case, able to find an idle CPU
seems to be more beneficial.

> 
>> ~~~~~~~~~~~~~~~~~~
>> ~ DeathStarBench ~
>> ~~~~~~~~~~~~~~~~~~
>>
>> Pinning   Scaling	tip		peter-next-level
>> 1 CCD     1             100.00%      	100.30% (%diff:  0.30%)
>> 2 CCD     2             100.00%      	100.17% (%diff:  0.17%)
>> 4 CCD     4             100.00%      	 99.60% (%diff: -0.40%)
>> 8 CCD     8             100.00%      	 92.05% (%diff: -7.95%)	*
> 
> Right, so that's a definite loss.
> 
>> I wonder if extending SIS_UTIL for SIS_NODE would help some of these
>> cases but I've not tried tinkering with it yet. I'll continue
>> testing on other NPS modes which would decrease the search scope.
>> I'll also try running the same bunch of workloads on an even larger
>> 4th Generation EPYC server to see if the behavior there is similar.
> 
>>>  /*
>>> + * For the multiple-LLC per node case, make sure to try the other LLC's if the
>>> + * local LLC comes up empty.
>>> + */
>>> +static int
>>> +select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
>>> +{
>>> +	struct sched_domain *parent = sd->parent;
>>> +	struct sched_group *sg;
>>> +
>>> +	/* Make sure to not cross nodes. */
>>> +	if (!parent || parent->flags & SD_NUMA)
>>> +		return -1;
>>> +
>>> +	sg = parent->groups;
>>> +	do {
>>> +		int cpu = cpumask_first(sched_group_span(sg));
>>> +		struct sched_domain *sd_child;
>>> +
>>> +		sd_child = per_cpu(sd_llc, cpu);
>>> +		if (sd_child != sd) {
>>> +			int i = select_idle_cpu(p, sd_child, test_idle_cores(cpu), cpu);
> 
> Given how SIS_UTIL is inside select_idle_cpu() it should already be
> effective here, no?

True, but if the entire higher domain is busy, iterating over the groups
itself adds to the scheduling latency only to fallback to the target.
Wondering if keeping track of the largest "sd_llc_shared->nr_idle_scan"
and the corresponding group, and starting from there makes sense.

> 
>>> +			if ((unsigned)i < nr_cpumask_bits)
>>> +				return i;
>>> +		}
>>> +
>>> +		sg = sg->next;
>>> +	} while (sg != parent->groups);
>>> +
>>> +	return -1;
>>> +}
> 
> This DeathStarBench thing seems to suggest that scanning up to 4 CCDs
> isn't too much of a bother; so perhaps something like so?
> 
> (on top of tip/sched/core from just a few hours ago, as I had to 'fix'
> this patch and force pushed the thing)
> 
> And yeah, random hacks and heuristics here :/ Does there happen to be
> additional topology that could aid us here? Does the CCD fabric itself
> have a distance metric we can use?
>

We do not have a CCD to CCD distance metric unfortunately :(
However NPS modes should mitigate some of the problems of the larger
search space (but adds additional NUMA complexity) which I still need to
test.

> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 22e0a249e0a8..f1d6ed973410 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7036,6 +7036,7 @@ select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>  	struct sched_domain *parent = sd->parent;
>  	struct sched_group *sg;
> +	int nr = 4;
>  
>  	/* Make sure to not cross nodes. */
>  	if (!parent || parent->flags & SD_NUMA)
> @@ -7050,6 +7051,9 @@ select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
>  						test_idle_cores(cpu), cpu);
>  			if ((unsigned)i < nr_cpumask_bits)
>  				return i;
> +
> +			if (!--nr)
> +				return -1;
>  		}
>  
>  		sg = sg->next;

--
Thanks and Regards,
Prateek
