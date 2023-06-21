Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519B1737A66
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 06:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjFUEoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 00:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjFUEoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 00:44:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6BC171C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 21:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBnwMPFr/3IsAWc60ZgvNk/hmpqafeQCb/qXhtUU43GDpzor+RA935w1nAWOhKZgQIb1AhelHPNo0zTDz3MiEH/H6fnFkAaQP6z+h/fDpyA7B9wWWtEVIGR1qwq16nqyAFm6xSAkbFVgtE+e/o1qzsDLkbooe5BsWdVSYmLGwEEvFsXLdOjXdIX+gpptEhSKedK4HOI7mMPbvAy9Xkbh7v+T7/E5CiCnQfLOxOARnxdjC0/dHyWO7ijzIGOEKjrG9W8vz732maVfMXBERcS5dUp9Ih/1QiqXCBLZZFNSXVKNTM2BfgINihbjPNyt5wpmO9D1QwIGOtHv2UhFYkd3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpQLFBGvo7bLUj82PnOaax0q5kLs/l4hrRGcCAZWD5c=;
 b=SiaLd+ZHz5guoBq7daYV81H4HCJRowS6sCZYt6b7z6JCXUs8U4BUp5iIiyXMIPb791fYdFTLTpvxK72OhEgkPuehbdCFP+iTiU621SCu2j3fFcXgYv/nxh7N9AEsQBK8XdElkgQN3pnr9BIOw3KKOuv7XrVGAEhMQdy3mnH9pkkGJ3n+Pduzg33DUsJpqWVV6MuKulhYcnrd1vzFBWXHIaKyEkW9V41TCKaRRQpcfOTQ8mgweAzQIUprTbko4N3zVGlH5VQIZa8d5AZYwaCQm4QmITMq18uCr7FkbY8R2DJ7xvUsMEGpuVhl1BqxZd0/IeCu5vGtmnvdCbHVZSZmUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpQLFBGvo7bLUj82PnOaax0q5kLs/l4hrRGcCAZWD5c=;
 b=NL2jnrAqN6i6IFdaUPmDZOcFB9nBoETvibJT9qmJwHFHX55HQZ+mWjLuiK3hretANZia9F/ZiAZajXf+Xp5YNeZBVSAqxrkML9ewO1jT+QjBQGaaV82R7lX73A1ZyTqr4Gkf/ut8q3ZLYjjOmXydmxeAJrvVFa4ZRjSid1Asnxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) by
 MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21; Wed, 21 Jun 2023 04:44:25 +0000
Received: from DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::714c:3289:2d9e:954e]) by DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::714c:3289:2d9e:954e%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 04:44:25 +0000
Message-ID: <4ff99651-fee5-f62c-0a19-9bd599de54c5@amd.com>
Date:   Wed, 21 Jun 2023 10:14:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] sched/fair: Cleanup in migrate_degrades_locality() to
 improve readability
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, wyes.karny@amd.com
References: <20230614102224.12555-1-swapnil.sapkal@amd.com>
 <20230614102224.12555-3-swapnil.sapkal@amd.com>
 <20230619094529.GL4253@hirez.programming.kicks-ass.net>
From:   Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <20230619094529.GL4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::17) To DS7PR12MB6165.namprd12.prod.outlook.com
 (2603:10b6:8:9a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: a2a6488f-2193-4679-8665-08db721230ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23EQg0xftpC8x+JvlgUiO674No6ioGmj3hxNYkoCXgJ+MP1M4AmZ8Rp0SVJ7p7D/fubGIQaLwuAqa2RpPDVFKUMV2/+pNh4Kmsi2Q/pOQCA+FfBAtwPT/5CURlf1vT5NjFWDoP4K7x1nUZD3eb+upw+QWmnohTuwVHqSsK7ZUpDqmPmhhh03Yt1jJeGQMFuX8hL+OPw9YByRCNFrQNsmKA4N3FN67BRJJ8V9FAKcm3V3Sz5BBK8pSjTZ12gHkh5/YfF48y9oEhaTl0Gx+J0FE4bopSc96FFojLe28XbwTwCqWdSYND+Xc61jKJWcX4AWLzIeOC42bIWgSdhAemooqK3By8fHUW8A72LxEqep34fHDmKJ3+hT6zB796uJOu1r+0FNTiRCOkxSp5Z02B1/rxYqkbxiBPeaml4+EuNV95ROjFCb7eIoCtytlp4H3XxIxvhVFzGtha3jGrHwbM9RIAj2MFvssgu9pUJ3Of7SDDPDJOFgNwPHTueiGC3BBStCZaQDBSmkLfUBT1ITADMKUmqxQy7qhpdJ3WT//bZcn0I1aaeGlLW+1qYTpKcV2nn+TYNXRRFfNpDFEeb9S8g2zgPnl+utg0aOa+y9qJTlWwBA2cbMIQ9VNJ8uo7RiVT4qeQJrRHVHP+4DMEY5XZ93ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(5660300002)(7416002)(2906002)(8676002)(8936002)(83380400001)(31696002)(36756003)(86362001)(38100700002)(31686004)(6666004)(6916009)(66476007)(6486002)(66946007)(4326008)(478600001)(66556008)(6512007)(26005)(186003)(41300700001)(316002)(2616005)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzBLNE9aUXdQV3UvMDlDQ0Nuc0Y2eE9YMWNyOE9oek9ONFhVdHJPZmdkd2dk?=
 =?utf-8?B?MGdSdndDVHpYMXJndDhDT1VyS0t1UXNDMFhvWjZZaVRCWGhobXF3aUEzWi8w?=
 =?utf-8?B?MVpTVE0vb1dOS2MyZnhna2tTQW8rbTY5RlBySFN1WThySGxYVTNTNWtlalBo?=
 =?utf-8?B?WnBxNzZIdEkwekgxK3BTUy9CRkJVTXc1VU9nUnVFMDBldmJlTFY0U1M5L3JT?=
 =?utf-8?B?MDVQR0JOZFNPcngyOEJjSkJhWTJEWnRZUnIxZlc0WmUrRnArLzFLdWs5OHh2?=
 =?utf-8?B?M0lvS2REWFZORmZRQ3ZLYStmS05GRmo1OW53d2U1Uk9DOFMzQUo1QVNYYVFP?=
 =?utf-8?B?MUZaZlBFR2lKbXp3T1FrMXIvT212RDJWQVo3Mng0bzFQM3dRMUl1TTRnUlgr?=
 =?utf-8?B?WUg3amJ3MGJpbm92VFUvVXRlWTJFTStxNFpyeWtwYTZ0RzFyaGRCNk9iaC83?=
 =?utf-8?B?S1JwRWtoN0Q4R3hTSEN1QWRLN256SU1qV0ExUUVUSytmNXMrWTE4djVjbWNH?=
 =?utf-8?B?cExuWGxXcTE5a1hnaUZQd3h2RGMxS2cyQlY0bVgwS3A4eTVlazlkYVFWNzM2?=
 =?utf-8?B?VVlwaUE3OUNxVmRmR0tpK1JSUkZxNU1VaVVMUWZOUjRsaFROazErZkh4UkNr?=
 =?utf-8?B?QzA5bU56MWpZcWUwTXNVb3NqbzZoY0g5S0xlZmJaTWlvazdaOVM5L0kyeUVt?=
 =?utf-8?B?c0poM0t2R0MzQWhSN0duRktxd2lETmwvME5Qd0NyOTNZeFRXSVV0N1VRU0tB?=
 =?utf-8?B?RXpkRTZJZzBnajJxekhxSFFmQlhNUjFTWjJXRzVsTU9OeHkrTUwyREd5SlNQ?=
 =?utf-8?B?QlJuWEk4NmRhU3VGUjdieUQyMG0xbnlHbzdFR05hSUtrQnozTTZRRXdvdzhs?=
 =?utf-8?B?ZHJiNE5xaVJCb3FyVlpMenZ2R0Nkdk1DeElwWm9mZzZTTk1zQVhJMHRKUG5C?=
 =?utf-8?B?eUxCVnRwT2s3V0k5dGJVb0pGTW94N0NnWXRBZ1ZIRU9ERlgxYWEwOWEwM2Vp?=
 =?utf-8?B?UnorSmdwQ2JjMlNjMXEzUGZhSjdHTU5NeU5YOXF0K0hEa1loeG5UTllvNlRw?=
 =?utf-8?B?T1hScGJRVnRWOVRWcWY5amF5SmlnbGRWNkhjZFpwNHFjWllSUUhTNjRDdWtI?=
 =?utf-8?B?Q2JGeVN2Z3IrdS9pYTc4SVkzTFdNM2pKZkc2WlhuK2s0T3pmVHEwam5XTlp3?=
 =?utf-8?B?V0ppcTBCeVhtYi9mc1pMZk0zQ1NwaWNSZnVJdC81dmZ5aGlEQjRJMHdFMml1?=
 =?utf-8?B?dXJUUVFhR2dqNzFPbzNMQ0IyK2hVWVFHZDlPOHB4UmFOSFZZY3BuVklVT2Zr?=
 =?utf-8?B?OVhtYlZVNnJSZlpQRC80VzZaQ2ZVVVdEei9mKzJ1ZXpOVFZBUGxtdGl3b3dC?=
 =?utf-8?B?M2c4RWVCOGRJUG4vUk9vUFlvU1JHZTRzcTV6WG1hSUNMNW9FUzdLUWtGR2po?=
 =?utf-8?B?c2tVMUJaRUFXb01KS200RTJxUXJFTWxYYkF6SHl2MzFIZXBKWFBWbnJVQU5X?=
 =?utf-8?B?UWtuOCtML2hDeDFoQXFiS3VHTXJuS0p0MnRxKzAzZVZCY0FuaVFsRDNlQWt3?=
 =?utf-8?B?REIrRDd0bGV5R3BuN0hvemxQa09oNG0xdGkzc3lIZktWWUxDWUhVeisxR2xV?=
 =?utf-8?B?enNpUjk0UjRDYU0vYzZKTklQN1AzZlJ6Q0hXNlZWRUFhVU9tYXRIRXZrRXBQ?=
 =?utf-8?B?WldsU3hOWFFzTkwxU2IvNTJqZUF1Y3J3S0pLNjZ1ZFl2VEpuc3Z3SkpwNTg5?=
 =?utf-8?B?SnVWUHJDcmdDTjRLdjN3VnBpRG1CUHNVVE9UWUhaK21LdVlJNThHZHdQb2Zs?=
 =?utf-8?B?SGlFcGZrQnFJeWR3YVlVQmhQWURiV0p2eEV2MytFV3c1S1gvMlJrRy9UMExq?=
 =?utf-8?B?VG5UWnpBeHFXY0ZpTlJZRU9CK0pLUmdpMkJpbFhLMlhiUDR1ZWJJWDdDaGFC?=
 =?utf-8?B?eG1KZzNPRUd5UDdXYVhwRnZsMFY4bHBIMWhhUEE0RlhxaWhwT2VHYWt2SVNL?=
 =?utf-8?B?S0tXOWhDQlVSQUEzNk1GZUVWNkhmZGt4cVdvN3kyM09JSWMvdnFYNm5DenRy?=
 =?utf-8?B?ZGF6NThHUldMZStJQ3M1SDQvcU9HMS9QQ21KQzNRMDUwemdEUFYvNmR1QjV6?=
 =?utf-8?Q?qAuVEhFHJKsLv5BEabIK8jNJj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a6488f-2193-4679-8665-08db721230ae
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 04:44:25.8628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K27wDK3PXEhpajTUL4ec9axsKvnvdfPMCpjYWTmWE61jm1AabUSuifZykhxvr+o7BYrwg3E1ZesOnYFp+p5kNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714
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

On 6/19/2023 3:15 PM, Peter Zijlstra wrote:
> On Wed, Jun 14, 2023 at 10:22:24AM +0000, Swapnil Sapkal wrote:
>> The migrate_degrades_locality() returns tristate value whether
>> the migration will improve locality, degrades locality or no
>> impact. Handle this return values with enum to improve the
>> readability.
> 
> I can see how you ended up there, that tristate is weird, but perhaps
> don't make it more complicated than it should be?
> 
> ---
>   kernel/sched/fair.c | 39 ++++++++++++++++++++-------------------
>   1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 373ff5f55884..a8449f594348 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8446,42 +8446,42 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>   #ifdef CONFIG_NUMA_BALANCING
>   /*
>    * Returns 1, if task migration degrades locality
> - * Returns 0, if task migration improves locality i.e migration preferred.
> - * Returns -1, if task migration is not affected by locality.
> + * Returns 0, if task migration is not affected by locality.
> + * Returns -1, if task migration improves locality i.e migration preferred.
>    */
Because of the following hunk:

> @@ -8492,14 +8492,14 @@ static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
>   		dst_weight = task_weight(p, dst_nid, dist);
>   	}
>   
> -	return dst_weight < src_weight;
> +	return src_weight - dst_weight;
>   }
>   

I suppose we should also change the comment to:
   /*
    * Returns a positive value, if task migration degrades locality
    * Returns 0, if task migration is not affected by locality.
    * Returns a negative value, if task migration improves locality i.e migration preferred.
    */

Do I need to resend v2 with your changes for this patchset?

> -static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
> +static long migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
>   {
>   	struct numa_group *numa_group = rcu_dereference(p->numa_group);
>   	unsigned long src_weight, dst_weight;
>   	int src_nid, dst_nid, dist;
>   
>   	if (!static_branch_likely(&sched_numa_balancing))
> -		return -1;
> +		return 0;
>   
>   	if (!p->numa_faults || !(env->sd->flags & SD_NUMA))
> -		return -1;
> +		return 0;
>   
>   	src_nid = cpu_to_node(env->src_cpu);
>   	dst_nid = cpu_to_node(env->dst_cpu);
>   
>   	if (src_nid == dst_nid)
> -		return -1;
> +		return 0;
>   
>   	/* Migrating away from the preferred node is always bad. */
>   	if (src_nid == p->numa_preferred_nid) {
>   		if (env->src_rq->nr_running > env->src_rq->nr_preferred_running)
>   			return 1;
>   		else
> -			return -1;
> +			return 0;
>   	}
>   
>   	/* Encourage migration to the preferred node. */
>   	if (dst_nid == p->numa_preferred_nid)
> -		return 0;
> +		return -1;
>   
>   	/* Leaving a core idle is often worse than degrading locality. */
>   	if (env->idle == CPU_IDLE)
> -		return -1;
> +		return 0;
>   
>   	dist = node_distance(src_nid, dst_nid);
>   	if (numa_group) {
> @@ -8492,14 +8492,14 @@ static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
>   		dst_weight = task_weight(p, dst_nid, dist);
>   	}
>   
> -	return dst_weight < src_weight;
> +	return src_weight - dst_weight;
>   }
--
Thanks and regards,
Swapnil
