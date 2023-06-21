Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0608737A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 06:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjFUEj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 00:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjFUEjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 00:39:53 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7216E1BE1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 21:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KacXc9jjnU+Hj/xF2t+lnaWf+kXGeEsGW2o4MQMVInu83PbWpqQrEKr3Nwa5zixJnONyi6PEofo11gD2WdzyupGeWXFaftpxkcglXZHDj+86FyFTGyfWNDfsQ8/k+VXz50QaTnyuO67GY4gkME2kSnbAK1bzszTQD+2FpkWI8NfL/t7Mt+OEucvjH8DHrKsn65k0UGO/4rw8xWjunNii0DnaJrTPbNspWFUXhgmXD1TrNOkteOTYyBsfjO2ARFVq+1b2ogvvfp9+Cfa0pPeadb1Zwh+WRWgElXWNoY42C+hEZdlWHAdXcMMF8ZVatmbWFGrDZ549vX6rkNCZRmCYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnXMdWRDZpFA/YWUToI3ckN2TK0gXmX2hkZ4+sbGIMM=;
 b=X7w5PlCWnVQnhW+w0pKoaQ795I4YTtntCBtMENCq8fc59CwlXM4fY2K6tKgo7bnGFSGXHlMntCExW/P+TeWn0j/AosG3IPP+vFLox8Hr6lodR05xKfse7xNw7pAMMAzLWbF6Z/fnls0HAECOvtbmcTQMCmYT+Jirv0jKxkRivNhs5NPj4USbwfAqhkYfEhvXd1Ef73b7zMzFtALNL1W830NJsGS8hPjdqnx0K+hsXdx0nIv8Yf9AO+2jVp5UvpujJflBIgYVGgvbu/lT/BE3QKTU7jj+weUffN7WDcyKKEGl5hnRzqv/QeLyuDnXGagjIU2Mo27TQ6vpe/Wk3pVoWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnXMdWRDZpFA/YWUToI3ckN2TK0gXmX2hkZ4+sbGIMM=;
 b=fJWtHAc6LsZETtf5vzAR49HhqAYjk7yodcLvqWDVdg2hf5zp68/ZBei4c9E/6mCKFMA7uHTqVIo0ufn2zF+TCHePxu9Ju447nPOy87g/4IRLXt1r9B5qfu8WtvNWKnpm5WZfVBWortrL+M6r718Y51gNS0tzrCNqL1TT7vwrJ9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) by
 SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.29; Wed, 21 Jun 2023 04:38:20 +0000
Received: from DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::714c:3289:2d9e:954e]) by DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::714c:3289:2d9e:954e%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 04:38:20 +0000
Message-ID: <f72e2368-f30c-5149-c33b-099970f82294@amd.com>
Date:   Wed, 21 Jun 2023 10:08:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] sched/fair: Fix value reported by hot tasks pulled in
 /proc/schedstat
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, wyes.karny@amd.com
References: <20230614102224.12555-1-swapnil.sapkal@amd.com>
 <20230614102224.12555-2-swapnil.sapkal@amd.com>
 <20230619092228.GK4253@hirez.programming.kicks-ass.net>
From:   Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <20230619092228.GK4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0229.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::11) To DS7PR12MB6165.namprd12.prod.outlook.com
 (2603:10b6:8:9a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d49e3a-3896-474e-3d3b-08db72115679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hROyzaNovzv0EqCxQxFGpsd1b1vwmZHbrPQ9VdxE86aT+rYtVErQpBrurTmTWrzlai5FcMKlCphhET5b5jkdYWzcziHIHzT2Yzyu6uaPDrP9JqEUs+KyjEboSvKqhDgl3CzOZq9xburYdtKVS7mH9GXnrbCOFSbHHVDwtjtyEtp254X6+obpGoSjUjQ8NWxqWqIXTf4OC/cFyx+bra6UY+hLRh8nF6yQhMCtK0JjGBbsK0GB3RLfAAExkxEyjXvqFIcEXHEIDPQaiPn2eXpjs2hInnAm6YKRrDQ5vx94fZsqUsJsSLEobpbG0JTOylcO7ecbf9BU/nW/2mCtRjWta0DMLaLwLY0/6sdK9dp9dODvTSxamOd2UXWZc6VoKyB2+LrDt+VW7SR82Usa/yzF70l15VV51FM48pWSCwfHiehwbODklndQWfbAHScw4EmKt0JYlk+51yXtOoMUQGSC64HpvM+HM5LGtOKoPnJLnL6yvpkUtOdKIoPOkyXHHR0vSke+VbVe3iQZgLJml71wA7TmLXVu0eAVDhyNMu8a4MPUZ6e5VPRjkHRxf9uThYpxhqnk5A21aLivha6KAZ3yBLo4eFxmzVRbw2K2FYhLPAhXhvK+mxjhRZL2Qq3IMardhipw7hkFeZQXPdGzUApGFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(2906002)(8676002)(8936002)(38100700002)(41300700001)(66556008)(66476007)(4326008)(66946007)(31686004)(6916009)(5660300002)(83380400001)(2616005)(36756003)(7416002)(186003)(53546011)(6506007)(26005)(6512007)(478600001)(6666004)(6486002)(316002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE5ET29QVEgxUEc4cFZHeG9BWXA5aGl0RjZVTzVWWlZhdVl3OURObEUwK1R0?=
 =?utf-8?B?aFdFZVFSSkpVNDFmeDA3VW0rZGJrMld0OFFRb2t2SUVleUp4M29yUmR2dnI2?=
 =?utf-8?B?QllIQndBQnR5TVU2bURCcS9BT3A3UlQ0U1V2bHptUDlCNkt2MGk5eTA1MVd5?=
 =?utf-8?B?VFROdnZsZStrbStEOFd1Q3kyZHM0akc0NU5vMVd6K214dnppcnVPRUVzZmRM?=
 =?utf-8?B?RTBkcFJYNVBZYlYyZUlGM1J6MVU4azR2dm4wL1Jqd1QrSDlsalkxT2JrbGkw?=
 =?utf-8?B?djZIM1oxQXZyc2N5NkRDZGFuTXF2dW9wRmd4VmhQSEdhK2J1RXE3anpGTUlJ?=
 =?utf-8?B?N0d0VUllWnFZS2tQTGU4NEdtQ1dZT1ZvUHYxSkk3MnVsdkNEWDkyL3Z6d1Nv?=
 =?utf-8?B?VjgwQ0FLRDMrY1RHOXJOUGhPQmlZNkZzSDFvV2NrOTY2c1B2YmQ4ZXhGMGxy?=
 =?utf-8?B?Ym5PZU1RTm12cmNhdzU3UERaNFFqMHZ5Ti9tTU5hK2N2VXUzcHJZd09nWU5h?=
 =?utf-8?B?Z1lhNVI0QkVYYkNKOEVnSkNyZ29DcFN4cWNRQ2IxdkxaaWhieXExQ3ZzVkVL?=
 =?utf-8?B?bTIvdnZmMkFkQkZCNU12RnZhYXVEcm1pRTV2b3BOT2I3VjRaeVFGZEZTL2dC?=
 =?utf-8?B?U3FueGQvaUVNQlhIcFZERngxN2xWMWFxQ1BCTHpPRzJHVlVHNzFkWDhabExz?=
 =?utf-8?B?cjJ3NUVUa1gvTUROc0FUWlF5UHowd2lQL3ViclFweFNaS093b3l6MTUvOHZY?=
 =?utf-8?B?bFErT0o0QmsxNkdNTGdPbFhwL0RwVW5pN3JNNlN3NmUwSU5wYStCdDVPS2sw?=
 =?utf-8?B?aTJMV2xMVmM4N3lKNkpQbWVKbGVWcWNtVnIvUUZybUFZUkNWcFBrTDN2RjZW?=
 =?utf-8?B?SDI4TmkvTmNGMzBTVVNRWVhqYjlqbElMejJ6anFoYTgveUsvYXRrMHpxclRX?=
 =?utf-8?B?Ykx5Q0djRTN6WWNCUExYT1hZZjFjTzJaNW9iN0VrVFdVUHBvcVNNZzRsYzN1?=
 =?utf-8?B?U3Fnbzg3VFI2R0RhSmZpSUFZUjFZcHg4QWtCajVMdTczUmlGSG5HS21OVEk3?=
 =?utf-8?B?dk9pbjVQV21DK3AxNmRHcG00U1FZbnU4ZnlHTTVQN3Q2V0pjRFBURG5mUWVC?=
 =?utf-8?B?czRWTlp6R0NtbjYvQ3VaV1hWTVVzcW5nL1Zzd1IxQ0JiY1hta1JPSnl2VFVG?=
 =?utf-8?B?ZTl2T0NwSFp1RnJsd2U0R0ZPblVXc0hCQVJBRFZMc1hIbTJTSnUvQk1xOU1u?=
 =?utf-8?B?cStkL2E1dDhmYW1hVmN1RzEzcnNoc0JWamEyYWRWeHZReSt6T25wVHI0bXVm?=
 =?utf-8?B?VDBBMHh3bVp5NUtpV3JBcWZnSTNVQnhsZVNKR016YzRaWDhGajJuU3R2aFo3?=
 =?utf-8?B?Q0ZHamMydVl3RGMrSko4MlBXZjNyLzdhUGxpbElublI0anZaQlBrbUJlcU9m?=
 =?utf-8?B?U0x5M0JsdFNoRGZDYmwveVkrcVZxZjBSbVl0ZHpHRVZRVFV5Ylc0VGZjTlR0?=
 =?utf-8?B?WElwODkwY1AzUEpmZmQ5SUF0UEU3VkxxUlQ2YVp4SFpvbmpsdkIxYnRuWVRU?=
 =?utf-8?B?Ym0xWkF3bUJoWjRGSVdpUWpSRC95ZnVwMEkzUGIzdVhhWkZjZklMbU1YejU2?=
 =?utf-8?B?YVFodUowcXZiNG1GSFpNZTJiejZ2Y0pvdnlOc0FFajNiSFY4WUxtWWpHZTdZ?=
 =?utf-8?B?aUVMeFJUQ0RXSDBiT1FXZlAzQ1FqSVRDZTBRR2RFS0xIeE9IZy9WQVpBYTZX?=
 =?utf-8?B?NkNycURCR1diMVFiWllkTG5YRXFXNWcrV3hWUjd5T3hEcEwvRjJldkpkOGYw?=
 =?utf-8?B?T3dqU1o0bVBXTWV4MXlkZGJkczgyTE5PZ0llZVk3OFJNcmJtV1UybVBiN3Zq?=
 =?utf-8?B?eFZ5djluelVCbURQd2hyY09VZVYrNFJpZkZma2dTeTVpK0hsSnZvMlRvTVRZ?=
 =?utf-8?B?Tm53NHpTcEtaalFwZjZzZlZJMXBESDEwQVpRNGYycWkrWVhtMnpkZ3hJMTVi?=
 =?utf-8?B?ZjZzL2RleHZrb0tsN2Yrd2k1czBHV2U0K3VUVzl2YzdSOGRhZnFiSG9kOHp2?=
 =?utf-8?B?eUk2NlYvaU8wY1NsOHVZVS85L1pxRHRPeFFNVHpwaURLLy9CZ0NxSFNVRnRj?=
 =?utf-8?Q?St5zVdnNmdsw6cRAtwOFFi36F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d49e3a-3896-474e-3d3b-08db72115679
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 04:38:19.7810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5+sHkbeWpm2Gus0DHkPftPIK9cPJHM8vKiZMNGGVtgYWiVjG32T6QDR2KZoRGAJNtWGEXN80lYPI+cwh1NUEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895
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

On 6/19/2023 2:52 PM, Peter Zijlstra wrote:
> On Wed, Jun 14, 2023 at 10:22:23AM +0000, Swapnil Sapkal wrote:
>> In /proc/schedstat, lb_hot_gained reports the number hot tasks pulled
>> during load balance. This value is incremented in can_migrate_task()
>> if the task is migratable and hot. After incrementing the value,
>> load balancer can still decide not to migrate this task leading to wrong
>> accounting. Fix this by incrementing stats when hot tasks are detached.
>> This issue only exits in detach_tasks() where we can decide to not
>> migrate hot task even if it is migratable. However, in detach_one_task(),
>> we migrate it unconditionally.
>>
>> Fixes: d31980846f96 ("sched: Move up affinity check to mitigate useless redoing overhead")
>> Reported-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> ---
>>   kernel/sched/fair.c | 47 +++++++++++++++++++++++++++++----------------
>>   1 file changed, 30 insertions(+), 17 deletions(-)
> 
> All this for just a number hardly anybody looks at :-(
> 
> Does this also work?

Thank you for this patch which looks much simpler.
This will work. In addition we need to handle the following case: when the task is
hot and migratable, and detach_tasks() decides not to migrate the task, then we
should be incrementing nr_failed_migrations_hot. I am appending this hunk at the
end of this mail.

> 
> Please double check the order of the task_struct::sched_bitfield thing,
> I've not had much wake-up juice
> 
> ---
>   include/linux/sched.h |  1 +
>   kernel/sched/fair.c   | 14 ++++++++++----
>   2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 1292d38d66cc..eba0a78ac2a9 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -887,6 +887,7 @@ struct task_struct {
>   	unsigned			sched_reset_on_fork:1;
>   	unsigned			sched_contributes_to_load:1;
>   	unsigned			sched_migrated:1;
> +	unsigned			sched_task_hot:1;
>   
>   	/* Force alignment to the next boundary: */
>   	unsigned			:0;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6189d1a45635..a88577132b20 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8569,6 +8569,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>   	int tsk_cache_hot;
>   
>   	lockdep_assert_rq_held(env->src_rq);
> +	if (p->sched_task_hot)
> +		p->sched_task_hot = 0;
>   
>   	/*
>   	 * We do not migrate tasks that are:
> @@ -8641,10 +8643,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>   
>   	if (tsk_cache_hot <= 0 ||
>   	    env->sd->nr_balance_failed > env->sd->cache_nice_tries) {
> -		if (tsk_cache_hot == 1) {
> -			schedstat_inc(env->sd->lb_hot_gained[env->idle]);
> -			schedstat_inc(p->stats.nr_forced_migrations);
> -		}
> +		if (tsk_cache_hot == 1)
> +			p->sched_task_hot = 1;
>   		return 1;
>   	}
>   
> @@ -8659,6 +8659,12 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
>   {
>   	lockdep_assert_rq_held(env->src_rq);
>   
> +	if (p->sched_task_hot) {
> +		p->sched_task_hot = 0;
> +		schedstat_inc(env->sd->lb_hot_gained[env->idle]);
> +		schedstat_inc(p->stats.nr_forced_migrations);
> +	}
> +
>   	deactivate_task(env->src_rq, p, DEQUEUE_NOCLOCK);
>   	set_task_cpu(p, env->dst_cpu);
>   }
---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b6a738514047..eb836629560f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8772,6 +8772,9 @@ static int detach_tasks(struct lb_env *env)

                 continue;
  next:
+               if (p->sched_task_hot)
+                       schedstat_inc(p->stats.nr_failed_migrations_hot);
+
                 list_move(&p->se.group_node, tasks);
         }
