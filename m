Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C455EFBC4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbiI2RTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbiI2RTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:19:48 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970A236405
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIrRm7Y4ZxuKqrrT9rJjUPARa1F5+o1Mm6AYOT1qzLIYmEJouhhCwb9CK1rito2/4F8vYkGQvKxzquUBbNj7hJ3Zt2ox03E7z+xXGwdJdG7FlzD6ybI4SET8nWAFwEOLcIKuaj2BLRTIfPly8ZY1Og02p0X0OfFaJmpwVqPx2k31EkBIpIh5aFp9GvHgmQxIc7LsBvKgLd7qhVAoJckUJBtDv27u0Jc+zeCvkqaOprgvF0+HdfOf8rEu4e/Jynmo37hSqteEZxnPMTidaoKfh4LS+x2GGm5xqq6YaR9mEilOiRcGpIswyZ9A99aGc7VMntkNSLseZI41VJy3kRDtIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=462bbpIu/1BGk6PxplLjmwMc3hckyNNOg0ovFJXnID0=;
 b=bxyt0DDW6lm4G8xdRH3cfHJivuDUpC5rPaL999gWWlC6AMpEXWsz8YOwawIo2FEegaTIzRx9I6Ms5W3kugLxp58wwjRSyKiZ9KTPfxB50dct0mJN5JL7/tOqtqT9l3anxXsgs+PIUMe8knGnGFQdE2SnK24i13CFFcYhKAhALT9rTny/HhG2ej+zwv1QFqttlldcH3fVYMLKkqCwTa1tQOKcON8E9fUclvlv+zQMbOw/ORqlRmYTq6EzDiM3busDZrc18yB/45kpqOwBVxJEVZGJKTK93/GFDS23xrhjGZS2dEIMmjnB75ezLuHIhbYsPjcj45yKkHixD1bE1jlxJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=462bbpIu/1BGk6PxplLjmwMc3hckyNNOg0ovFJXnID0=;
 b=Cjv9lTd/9KD8bvNgTtUHXR0atezhEVKvHKJJaJJPMYR7l5o2IgANoJwF5FH/emy5WkZ7/5eKLbgMhuiwcXPEdtYHA/v/N0oAQ37JtYxfp3Hch4r4Z9hm9faSgzlU+kM34Fx8h3fChMLGPDnEPgR8VFtlexW4PVrUgWQsP06OGto=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Thu, 29 Sep
 2022 17:19:42 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::daa4:3ae4:39e3:61b5]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::daa4:3ae4:39e3:61b5%6]) with mapi id 15.20.5654.014; Thu, 29 Sep 2022
 17:19:41 +0000
Message-ID: <dce80b8e-8a2c-d498-bdf9-0ca3ca340ce7@amd.com>
Date:   Thu, 29 Sep 2022 22:49:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH] sched/fair: Choose the CPU where short task is
 running during wake up
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
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
References: <20220915165407.1776363-1-yu.c.chen@intel.com>
 <7975dcbe-97b3-7e6c-4697-5f316731c287@amd.com>
 <YzUrITfUn96puCtv@chenyu5-mobl1>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <YzUrITfUn96puCtv@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::7) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aab34c6-781e-4e43-afa4-08daa23ecb8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mj2UgUeODCI3+HTp2nArGifCHs+TzSyLxX6+EhwUrTvt9WY2yzavBbrOZgxsaND1w0TLV0YIutvbUuajy6xlsjV08rQB6mw6nA/OoFedZYHXe+gi5/IIVL7f1mZiNgrKY3ef0WGaNZw3+ZxU/MN7xpvFC9ppuZRSVDvU2Y5RyWPuOJ0jKQyz91alSy6GE/wqEd7/luZ5DSDMTT5U8UpVYxf7xbD7l0+qQkxop+v4DABcsxm0yTMaCNd2yDva+NiKZYazYPsA3GuC+k+6xz7svlLZtDsiFxEFGUC/SShk2rbgWxb+lurGFjezwJz4pQ9dZLhEagMeE01h+/d+/X0uEOesTk9I+YpEJh48QLT7BMaAKUuGXDWaF09dGMfvNahNY8ioFEc0Pqx009O/UUxUJMLyQfxAnMS+cH3Ym6XFHvLPEEgSsnZ2LRs0tUKPwf/tZs2sTSylLIqJ6luZYoqb+kkstCT7Qn6+7Orf2FBsBzkdSLn2cejMiwATG2Za/L3wWlanmi3wySZOqryFsTq63I0IhnZaFXCcyIXIFUDLSzF18zfzOrdYdLu+mx3J4v03Tm8CnzJF5Me6ySgpB+59gfn0fT5eyPHzMufVsLZzm//DZwdZ4eSdjgN+2CA7j2XeggR3S0XPE6IpHN0KSXgOv9tuELkQV0TahMWoQI1pzJJJhh7KgfnJ2zKZ8Mk6TkTvuPduEnV1X39+9tZpogtoUZHJUZsgaNMrKq6ypdHDdzyjiKJdYQtgJVLohbrxLVk9xempLExjtuo1KVHNCF3H3wbliwAhhJvpANQ5EJRMSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(83380400001)(2616005)(66946007)(38100700002)(4326008)(66556008)(86362001)(8676002)(66476007)(316002)(6916009)(54906003)(5660300002)(31686004)(2906002)(8936002)(6506007)(6666004)(7416002)(26005)(41300700001)(36756003)(66899015)(186003)(53546011)(6512007)(31696002)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGgwcll0THJYU0YxL2lNS3VSWlNnRENYYU1Cd1Q0MUFHSVQwZmUrdisxSUZ0?=
 =?utf-8?B?WVN6MXBKdG12cnNrNjdOZ3RWSFFMMUtUSnBUYkt0UWs1bmtwZWxQNVk0R2cy?=
 =?utf-8?B?SUxYdVFjbnJLMDRLaWZWMk1mejdlZ3p0UXdSZXZHbGV1ZVBWZG9BRDRqNXdV?=
 =?utf-8?B?eDAvTWViMllaTGZXM0ZCbUFrUUd6MlFYU0U3aTA3dkVGWEwycDdRRS9SNVFx?=
 =?utf-8?B?a1luL2NSaGpDaVYrcUtHYXB3eVlpTzFVaXRaZXc5Nnl3MXZST0JNMVB2NnBJ?=
 =?utf-8?B?b0NObDduZnE1dnNFS1VMUGtWUTdhUm9aa3ovZm5VS2NIR3c1VFRyMW5qb3hD?=
 =?utf-8?B?T2RrZmVZSFV2bU9KbWVyWWw3QjJWdnEyU3BOajJoS29UbExCQURqK0cwZUxj?=
 =?utf-8?B?UStKTmVEY1lUSWJrVnE2c25UVnhUd0dSQkd1c3d3bm04UTJYdDBLcFJ2Szk3?=
 =?utf-8?B?YWhBOGZqV05nK2phaDg3UndHOFR6SjRudytnaXhqM0h5UUE3WnBMYkI3R2Jr?=
 =?utf-8?B?cGRNcVNFVFZ4SFRIWm0yMW9LcldhTWE3eVpLeFV3dWZ4NmVURFlsRFRCRFdL?=
 =?utf-8?B?N0QrSlBwNXErcGJxS3loWWlTRVBON0hqd1dlTjJaellWUnY5bHY1aDZWQVdY?=
 =?utf-8?B?U2FML0JsWlIvT3dQd1RsU2lSRFp0cEJOcHFoaEQvckVIaVhvblV5TlJUTWM3?=
 =?utf-8?B?Z09JZ00xTTJFRVAwMkVMTmJzN24wNTRiZ1BRVXFJak1ETTU4K3luRjZTY09l?=
 =?utf-8?B?aTVuRGNKWXBsRXlSOXZ6c2hzYS96Ky9ua0tkZTU0THFlR0JEUWQwWVR6ZzVj?=
 =?utf-8?B?Vm9BUUhuU0NuYWZZa0ZiWWhDQTRGbDNvUThPNnh1RzZRcHM3Q2VrMklNakJ6?=
 =?utf-8?B?b0UxTHdQRG52aS91U21JQ0hQSHVhTXQ0dWRVNkRUUWhTV0RGUEhOQkkvUHlN?=
 =?utf-8?B?YUlXaDB1TlE2MFpkL3VyY1VpZjAxWnlDNVBNTEtuK2c1TWM2dEV0VDdvMlYy?=
 =?utf-8?B?RVF0NnlSUzJzYm1FNG44YjVLaXBXdjNibDZScjZ6VnJKY1NjR2licnBlSFdT?=
 =?utf-8?B?b1pDVFc2Z1JucWVGN2NZZnF6YkRMWlF6TDVuQXlEa0E3K3FwWjVwM05tWWZj?=
 =?utf-8?B?d3pFWHlwbFNpc29qWnJxM0dMZ21TQnBTNkFRd1htSVpOZVBLdUJneU5BbGpC?=
 =?utf-8?B?SXVrbUQyVWVKYWQ3TGJOamF2TTF6RkdML015eUxUSEI5RXBLc2p5TGpDbW1X?=
 =?utf-8?B?M1c0TXAxajdkV3p3bGIwUWNjTW82OUtxdHlTRUdscHFzVFlONHJOWnNnUmto?=
 =?utf-8?B?bXNxUG5EN1g4cE9oVFFvZFFTR0VGSVlldzE5NnExOGk2SmhPL0lTbkwyeDVt?=
 =?utf-8?B?V1M2Q0MxMXFoSllNSUxEejVoUDdmYzFhMDA1T2dhazFNM0w3ZGVYNE9nTDB4?=
 =?utf-8?B?cnVVcG0vVmhuYkxMdSs4N2lEQlBTMms3bldBRW1ycTU5TzdBV3phTnRnQ0Jo?=
 =?utf-8?B?aVlmQzkwQko4UzlKVkRvd1ZkQjZja3FIU3BjcmlIYzQ1cWZnbHowZFFFb3ZC?=
 =?utf-8?B?Tis4UU5JMStwZ09SZEUycU9UWEZTZ0VEb0tsT0VPZk45Qzg5ZDJMQ28vaUhp?=
 =?utf-8?B?SjZYUU9zVlU2NVNSb3Bqd1VOeVFwcjN2bXdNM3UwTkI1Mi9PaEdVUWJoN3A2?=
 =?utf-8?B?eXhuUjhxaWRIQ2NUeDIwdnVPaDRVVmcvcTdKcS80TjJwamJjOUxxVjVMTXYw?=
 =?utf-8?B?U0pleDhvQm9PU204Vk5vZVdZT0dkSVh4d2d1Wk14Z0t1d1I0WEJ3TFNPMXZQ?=
 =?utf-8?B?WUhSVzFzYml3OFRXbFM1NndtaUt4WEhudHIxRHYzU0dTaWtxVTkwTlY4ZFZq?=
 =?utf-8?B?S3dyNG1sNWRaWmp5L1ZGckZNTlBGQXFXQ3prN2ZqT09xYlZOTTlrRjJVWHBU?=
 =?utf-8?B?NEpJTDJTcHlhTGNXQjNpcjgvVU9Vb2xWZTFKNHEwYXhpdjA0cGtoSSszR2l4?=
 =?utf-8?B?elhMSE1zT2xKQzB1Z2Z0UURFYSthdlBHaHV5MUliMzZEbGx2eVpJSFlNTDNX?=
 =?utf-8?B?MVlxait6U21HOUlBSmtGZE9xNGcydVRGWnpqN2xzNlZYVitnK3BuUnVhd1BE?=
 =?utf-8?Q?j3DqwaLbqvmdkSIVAvW6y48HO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aab34c6-781e-4e43-afa4-08daa23ecb8f
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 17:19:41.7428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bn0bnZN6ea4GsDeRAgX7jtfpDLPhvyajTmeYUXz2Tjq2hKrMm3fomIcRRSIpo+4/XIzWe/Cr295SXimgYud3Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

Thank you for looking into this issue.

On 9/29/2022 10:55 AM, Chen Yu wrote:
> Hi Prateek,
> [..snip..]
>
>>>  kernel/sched/fair.c | 31 ++++++++++++++++++++++++++++++-
>>>  1 file changed, 30 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 914096c5b1ae..7519ab5b911c 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -6020,6 +6020,19 @@ static int wake_wide(struct task_struct *p)
>>>  	return 1;
>>>  }
>>>  
>>> +/*
>>> + * If a task switches in and then voluntarily relinquishes the
>>> + * CPU quickly, it is regarded as a short running task.
>>> + * sysctl_sched_min_granularity is chosen as the threshold,
>>> + * as this value is the minimal slice if there are too many
>>> + * runnable tasks, see __sched_period().
>>> + */
>>> +static int is_short_task(struct task_struct *p)
>>> +{
>>> +	return (p->se.sum_exec_runtime <=
>>> +		(p->nvcsw * sysctl_sched_min_granularity));
>>> +}
>>> +
>>>  /*
>>>   * The purpose of wake_affine() is to quickly determine on which CPU we can run
>>>   * soonest. For the purpose of speed we only consider the waking and previous
>>> @@ -6050,7 +6063,8 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>>>  	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
>>>  		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
>>>  
>>> -	if (sync && cpu_rq(this_cpu)->nr_running == 1)
>>> +	if ((sync && cpu_rq(this_cpu)->nr_running == 1) ||
>>> +	    is_short_task(cpu_curr(this_cpu)))
>>
>> This change seems to optimize for affine wakeup which benefits
>> tasks with producer-consumer pattern but is not ideal for Stream.
>> Currently the logic ends will do an affine wakeup even if sync
>> flag is not set:
>>
>>           stream-4135    [029] d..2.   353.580953: sched_waking: comm=stream pid=4129 prio=120 target_cpu=082
>>           stream-4135    [029] d..2.   353.580957: select_task_rq_fair: wake_affine_idle: Select this_cpu: sync(0) rq->nr_running(1) is_short_task(1)
>>           stream-4135    [029] d..2.   353.580960: sched_migrate_task: comm=stream pid=4129 prio=120 orig_cpu=82 dest_cpu=30
>>           <idle>-0       [030] dNh2.   353.580993: sched_wakeup: comm=stream pid=4129 prio=120 target_cpu=030
>>
>> I believe a consideration should be made for the sync flag when
>> going for an affine wakeup. Also the check for short running could
>> be at the end after checking if prev_cpu is an available_idle_cpu.
>>
> We can move the short running check after the prev_cpu check. If we
> add the sync flag check would it shrink the coverage of this change?

I've ran some test where I just move the condition to check for
short running towards the end of task wake_affine_idle and also
incorporated suggestion from Tim in wake_affine_idle. I've shared
the results in a parallel thread.

> Since I found that there is limited scenario would enable the sync
> flag and we want to make the short running check a generic optimization.
> But yes, we can test with/without sync flag constrain to see which one
> gives better data.
>>>  		return this_cpu;
>>>  
>>>  	if (available_idle_cpu(prev_cpu))
>>> @@ -6434,6 +6448,21 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>>  			/* overloaded LLC is unlikely to have idle cpu/core */
>>>  			if (nr == 1)
>>>  				return -1;
>>> +
>>> +			/*
>>> +			 * If nr is smaller than 60% of llc_weight, it
>>> +			 * indicates that the util_avg% is higher than 50%.
>>> +			 * This is calculated by SIS_UTIL in
>>> +			 * update_idle_cpu_scan(). The 50% util_avg indicates
>>> +			 * a half-busy LLC domain. System busier than this
>>> +			 * level could lower its bar to choose a compromised
>>> +			 * "idle" CPU. If the waker on target CPU is a short
>>> +			 * task and the wakee is also a short task, pick
>>> +			 * target directly.
>>> +			 */
>>> +			if (!has_idle_core && (5 * nr < 3 * sd->span_weight) &&
>>> +			    is_short_task(p) && is_short_task(cpu_curr(target)))
>>> +				return target;
>>
>> Pileup seen in hackbench could also be a result of an early
>> bailout here for smaller LLCs but I don't have any data to
>> substantiate that claim currently.
>>
>>>  		}
>>>  	}
>>>  
>> Please let me know if you need any more data from the test
>> system for any of the benchmarks covered or if you would like
>> me to run any other benchmark on the test system.
> Thank you for your testing, I'll enable SNC to divide the LLC domain
> into smaller ones, and to see if the issue could be reproduced
> on my platform too, then I'll update my finding on this.

Thank you for testing with SNC enabled. It should get the LLC size
closer to the Zen3 system I've tested on.

> 
> thanks,
> Chenyu
--
Thanks and Regards,
Prateek
