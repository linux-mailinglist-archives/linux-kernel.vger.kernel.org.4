Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF585EFC0C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbiI2RfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiI2RfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:35:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A9B7A52F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GARE1IJqSzVGN4SfIySnpXimgvFQtZLEE3727bPgnctm7I2zCITuE9+hejbB5e3GtBhf6/NEvcheenFu3nW3g8ziCUKBD7kt0lFLXGTVTutMY3KFAyI4+OwIWKTUoTwjhmvewtXB/b0ddkT29EWZkV14QSs8OkzCIL5l8Xhs5uRvkEUc4R7SWKOOsT8Fppk8kMt+zJLOrwLLeAYwB3wa7VSiCiS59AqPTGCly9SnELwM3DN8GRHZXAc7L+TXlK0O5Dz7BZJTyiGNKaqM1U0JW4ZnRjujOg+4H5E8J+PABakjlA8YEJu45PvOVKtxU+JEGjEGvO7PQQi+XR9G/rDB9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfiU9pWkv1C+YEzB+FI+gCwhM/K90Js4sP3DL42050s=;
 b=Q6DmAly/B+ldK7fgsFL/+R2DeNv+rGhjS3Za+fJf1dRSJ0zp0LtZ+X08znlHZa6kK+wpCBABDVw2sFUrX+jWe67XIJBX9xjmCVKctgarIePmlotWtYDM9n8lHZLRNkvXHaagRPubaWcqSf3Z8AsL7GRf9vzmHXz843/dtFdiopoZHOJBWtEj5K3PcimUxTwE3Lannu/WJwNvGb5dYW2157UmzS5SmoYIuzvQAmygigJzLDhX1wwdooFdZaZYIbclbrKxeT3gNKSWpNxH3KwPiBeIOKHepiqquGTTukiwbqNhaqGb8/koSfPG3mbIHoNkr8dCNmChrCXPYaUxT9FumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfiU9pWkv1C+YEzB+FI+gCwhM/K90Js4sP3DL42050s=;
 b=uZtSR5QfVxn3BZrjyYTGJjUKdLFBwMC9oJ2gq4Wlmrouc2ZK3kAXJsWDAtH/JD2RgNp+UXfZ5qnZdqHcxfa5fFk+gGML7i+YCeQPf2+aN4sjNTSg55E9gyshKX+oWm8tLh7DQ9/g0t89hjB4/fHM+wjwfqK4iFutLaCfHg4RjTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 17:35:10 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::daa4:3ae4:39e3:61b5]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::daa4:3ae4:39e3:61b5%6]) with mapi id 15.20.5654.014; Thu, 29 Sep 2022
 17:35:10 +0000
Message-ID: <2c50baa4-beef-54b9-74fe-1cbf6e8f8dbd@amd.com>
Date:   Thu, 29 Sep 2022 23:04:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH] sched/fair: Choose the CPU where short task is
 running during wake up
Content-Language: en-US
To:     Honglei Wang <wanghonglei@didichuxing.com>,
        Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
References: <a6e38a33-0003-d3ea-de9b-cf805aef647f@didichuxing.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <a6e38a33-0003-d3ea-de9b-cf805aef647f@didichuxing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::8) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DM4PR12MB5374:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed6d679-f5f0-435c-9158-08daa240f526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9xOre2F1ZgZNFjYU6YnxRcGpzxhJh5KOlYpN9gSuCE/L8vUv8c/z41+S+CMCGUT85/kKNggSfB1GGEIHrXF6bvZDQjHBhJZHVnOpxsckJYsxvNbplDGe7XEFcvTih25Pl4qv24ifl0tLeMvvGBL+y1O5qvF3Og2Ez88KaLjqA0HAzEeVQW1KT3vQDjLp+UncYG0DjtuBhRRdvGneBakofStx+6bLBhvueaOpmzLonpqbO33LgDrRGJ3S3eZtj9cdEvgxgikrFhyGXhCPAFBZbp8sSEPPq5jfjDHNjw3JloFbQxC+WfRXKlbzYXYH2zC1S3VkC7p55aOAJFLw6cOpV4OVBIECiP+JER50JHPR2l76Q7u4YMFO0WvuFBaIoDQEi4LSuQalOp8xW8D7ykwN5jmbBkE7I2+FTszeQidI7CkC0RYEH7zFLrMP95zwNSjuZjextXZlOdXi3PQsmOrq9HKMvArnQ21FZGzQryMRqt1blrmFrERPHs8fSXyH26YnG2HPkUFlP9hCyfGPJh00Itb0p61+TMtgHaH5KY/OeSwzA67H7RdHvL0J0JxtOZbuAynB/ujygTreNnfZaNpthv9pphExBXzbprO0g1biau2FNxmdW30F2SsngqjkIala87dYooKaOWB/r0eTN8jbz8s2Q0V1jQTE93suQGOWQ7YnLAL/1Xz9ZNcPTLdZ3e+RoDLsgHLzVb9kfZxqBELkAfz8LCh6XKKF4bkjFvuGf3ZbZxOIPUZoJ0UQfZIGndQZMilJboV4zAMb4v4hPxKgE5r/fWRt3PhP0GzVBBP4yR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199015)(2906002)(41300700001)(6666004)(53546011)(6506007)(6512007)(26005)(36756003)(7416002)(4326008)(5660300002)(8676002)(38100700002)(66476007)(66556008)(66946007)(186003)(2616005)(8936002)(31686004)(86362001)(31696002)(66899015)(110136005)(6486002)(54906003)(478600001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TThwb1lidXo5VFNJNlZSbENSb2Nma2Y5ckdwSVhWV0RwVHppdG94c1BVZU1m?=
 =?utf-8?B?WFhYRlVsbGNrYWJJU3pMTGtJSDNxYjE5d1pXYXZQWWIrUTBoUXpSaUIrT0hp?=
 =?utf-8?B?M21nMlVJeWt0WFdaalRONlpjVW5pVk04dW4xcWVRZUV0R0xjZEJjdlcyTzJ6?=
 =?utf-8?B?OXNPNkJ6NnlXMG9pN29rNHBicjV0ZEdEYXJnNkhMblBNbitURTlpNlkxSTJk?=
 =?utf-8?B?YnhyeTB1K0dLR3d1ZlNHSWxTTjZFd0NsdDBtL1RYTnkrbUZIV2o1TSs0aVcz?=
 =?utf-8?B?Z2hoVFdYdkdDWTkwUnFPNTBWN0ZDRC90YnpER2ZCT2FubE04WDdzNmRObGhx?=
 =?utf-8?B?dmlaRG9LMVJEWXp3cmx4b0lBcG0vUWZPZmlCVzVPOVoyck9QU0lRWmF5U0NR?=
 =?utf-8?B?Mkxob0hscTkrb3ZNZHdaKzVsejJTVHRhUDNuc29UajMxdE5jazVBekRyUmk0?=
 =?utf-8?B?VkhLcTlieDFaUWgxWXRYWnhXSFh0aVhFdXlUWS80ZVN0R1E0ZzhxWWE3S0RQ?=
 =?utf-8?B?SjlDcHlCcUsxejllbXFURTdibmdMMDFZd0lVNEJwUDZJbFB5SnkwK0NjVzV4?=
 =?utf-8?B?OCt2MFBSMXhablJCZ1N0S09vZHZrZzlqUndOb25pMjI1UUxnRHdQcUxpOU9G?=
 =?utf-8?B?VDNyTWVkdkFoT0JhdkdHSHdOSUhEWnltNExWSXhnMU1DdldCS3ZFKzk1cTNB?=
 =?utf-8?B?bHZaSjBxVWtsaHExMGZuK1BVaFpCMWJLaVZKaUpLVmwyR2dWbnFyR2R3RjVm?=
 =?utf-8?B?b2xJbzgrcTE2Zy9yUE1OMVlPRTVldzByUmtSQm1zZ3lIajh2c2VwNmZDK2k5?=
 =?utf-8?B?Y3NZanhDSlZWaW9XTVJYTjFQNVJRcjU3RnN1TjB6S3g4YkJWTEQ0QVZyU3JS?=
 =?utf-8?B?NjVXazFvSXlJQk9ZMHBqcVlibGF5WTFLeHk4LytyQWx3azRjaURGdG5pYUpD?=
 =?utf-8?B?d05laW5kcXRyN0o5Yjlqcmd3dzNGMTZpMUtxRzFiZUdYQWZIVTRZWXlFbTVE?=
 =?utf-8?B?K0FXejdpNk9ZcHpYOEJzeVp1OWc1VEg1SktYYnRtNThhZjE2TG4xNHVrWHlk?=
 =?utf-8?B?bHgyNGpYalJGUGJMemFvdnIwVzhDcUkza0F2b3VGU2Q3TEVnRUFHUC9YWEJ6?=
 =?utf-8?B?cFV1TmtrYVROdE1OUW5NMEdvaWkyY1ZEZG9uMGZsVWNYK1RvT2ZMbjZQSktU?=
 =?utf-8?B?bVlaSythcnZBZFFZeDRGaTl5VTRZUlFGSmllRzZxdmJuQzJ2NFdYNXArWU5P?=
 =?utf-8?B?MEJyaGIwbzh0VExBUGlsclFhQUNqcGV2T2dFZ0RjclpmYU9kUkk4VXFsV2V1?=
 =?utf-8?B?UDllNFpCcVpFQlcwU0lLdU8yV2Q1M2RUZjVhWmx3SUhPVFlBMEsrQmNDN3RW?=
 =?utf-8?B?ODhENUV1V05NbkNDMjF6emMzWjBIZkY4ZnRzVkx2TUpHSTBkOW40MkY3VnlP?=
 =?utf-8?B?SGdDenJYUVNCZUtQdUp2cXQ0Q1VDNWh6MTVDamVwZms0WjJVWWZSeS9rdFor?=
 =?utf-8?B?MVVPSHlMQksyZE5Ua0VqU2k4bUdta2JnV21ydnJUUCtJNFJIcXFSVGlURjhJ?=
 =?utf-8?B?UEw4eUF6Uit2RCtOdmVXUk1Vd1ZXaDhUWWhRSHJWZ3RsK0h5NFUxaEpQSjgv?=
 =?utf-8?B?c0o2dDBjZVZFeHhZSnAycFh2VjRMSnBFcnRVWXRDbFBpbUY0TzhLNW5lOGZl?=
 =?utf-8?B?UGVOSTZhYlVhV3k0UTVmSDF2eVNUTU5SREVoU1BvZVBLZHMxZkdSVUNSMmxH?=
 =?utf-8?B?VnR6bWNMWTNXMkx0OVkwVnJQa3NDbnJFdno3U1dhUm9TQ292ZjlUU3NjTk9x?=
 =?utf-8?B?eFhEUm1QUjZTck4xdUtRV3FXZXcxMHpEZUJzVVFuclNBZW4rWVJYampSdjVF?=
 =?utf-8?B?R3ZXb2tlMkRUNkRJcWVtcmsvRHJHc01zQmVmMUJJbkF0em0zQk1QbGpNcys3?=
 =?utf-8?B?UGo0VlhBdytGT213bWN4OUlOWkN4NFExdUNzRXFhaThIa1pFRUpUMzFBSzI3?=
 =?utf-8?B?SGhzU3pWSWYvcGE1VUdtbjU4M2NwWkxlTndnd25leUdZYytqbnZlbmZuc25X?=
 =?utf-8?B?UUtOVUhrWDRZYTlkam9JMkRPWWphVGVIc2tKd2NHbmpoaVJkUEJwUlkzNXVM?=
 =?utf-8?Q?wePZL32Z6IICsNwYudgCfPcmh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed6d679-f5f0-435c-9158-08daa240f526
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 17:35:10.5273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e822spZMd1VWuiCM723314xxXU4hlONFRQjhpRv8HHFDnuajcqTQVvh8DF0++EoT1VxbDALyzP9YBYGzNxS1pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Honglei,

Thank you for looking into this.

On 9/29/2022 12:29 PM, Honglei Wang wrote:
> 
> [..snip..]
> 
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 914096c5b1ae..7519ab5b911c 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -6020,6 +6020,19 @@ static int wake_wide(struct task_struct *p)
>>>>       return 1;
>>>>   }
>>>>   +/*
>>>> + * If a task switches in and then voluntarily relinquishes the
>>>> + * CPU quickly, it is regarded as a short running task.
>>>> + * sysctl_sched_min_granularity is chosen as the threshold,
>>>> + * as this value is the minimal slice if there are too many
>>>> + * runnable tasks, see __sched_period().
>>>> + */
>>>> +static int is_short_task(struct task_struct *p)
>>>> +{
>>>> +    return (p->se.sum_exec_runtime <=
>>>> +        (p->nvcsw * sysctl_sched_min_granularity));
>>>> +}
>>>> +
>>>>   /*
>>>>    * The purpose of wake_affine() is to quickly determine on which CPU we can run
>>>>    * soonest. For the purpose of speed we only consider the waking and previous
>>>> @@ -6050,7 +6063,8 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>>>>       if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
>>>>           return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
>>>>   -    if (sync && cpu_rq(this_cpu)->nr_running == 1)
>>>> +    if ((sync && cpu_rq(this_cpu)->nr_running == 1) ||
>>>> +        is_short_task(cpu_curr(this_cpu)))
> 
> Seems it a bit breaks idle (or will be idle) purpose of wake_affine_idle() here. Maybe we can do it something like this?
> 
> if ((sync || is_short_task(cpu_curr(this_cpu))) && cpu_rq(this_cpu)->nr_running == 1)

I believe this will still cause performance degradation on split-LLC
system for Stream like workloads. Based on the logs below, we can
have a situation as follows:

	stream-4135    [029] d..2.   353.580957: select_task_rq_fair: wake_affine_idle: Select this_cpu: sync(0) rq->nr_running(1) is_short_task(1)

Where sync is 0 but is_short_task() may return 1 and the
current_rq->nr_running is 1. This will lead to two Stream threads
getting placed on same LLC during wakeup which will cause cache
contention and performance degradation.

> 
> Thanks,
> Honglei
> 
>>>
>>> This change seems to optimize for affine wakeup which benefits
>>> tasks with producer-consumer pattern but is not ideal for Stream.
>>> Currently the logic ends will do an affine wakeup even if sync
>>> flag is not set:
>>>
>>>            stream-4135    [029] d..2.   353.580953: sched_waking: comm=stream pid=4129 prio=120 target_cpu=082
>>>            stream-4135    [029] d..2.   353.580957: select_task_rq_fair: wake_affine_idle: Select this_cpu: sync(0) rq->nr_running(1) is_short_task(1)
>>>            stream-4135    [029] d..2.   353.580960: sched_migrate_task: comm=stream pid=4129 prio=120 orig_cpu=82 dest_cpu=30
>>>            <idle>-0       [030] dNh2.   353.580993: sched_wakeup: comm=stream pid=4129 prio=120 target_cpu=030

This is the exact situation observed during our testing.

>>>
>>> [..snip..]
>>>  
--
Thanks and Regards,
Prateek
