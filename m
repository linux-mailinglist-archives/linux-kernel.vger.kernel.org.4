Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2DB5EFB6E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbiI2Q7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbiI2Q7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:59:00 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8201C6A6D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qm0wH4Qa8SHxhAFzjLMgBHAN0G1PBUF+v7PEOKjmBUs/AAvTropAX4MM2oYpTKudtCDv2TrGK+6qkholLe8Pwd/Br7KK4N+Y07JF6dLrF5Za3ne1xYpodpGzHkqGP6dRQsN3/z3tNZD/pqqXzhvAcQqUB88dgnbKyvqbC0LoYnzHXjdB8Gh2+6AoUy22xSJWZXjbGAhqM+lM3LomafC1SUaMBRcY30LRjCpqmIfYIIqacS3KJHjp7vCbCj4R2P5pYmyGoCOhgn95n3kwOLA6Z3MdCjP/rLyyxmUZUPsEWpG/0HvKTAFA1/HOR6TSj7ItFiVzrINliItIvh77GuTlWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXQdbkdXM6BgLKETyh2by6jXJeUSUIIr2X4bmusw40Y=;
 b=ZellvbmGhBEL4AqfzSLJgJiiyH9XfcLSY6pKDKQ2HCOmeHmSw+knlr8w3DtOAShUdV08tBTJSN14sIJoHWsUVUFmE6ShcOZv0D4nhDAsuG0o3h0O+xQqfKXLKXYgyk5amVvzZBC0FpTirFcQn9BEtAHnUvi8gShPDc7ywhsyh/3H38gkcUYHW3vCKXhtUWUQ14Soah6o08sEccm5TnZfxaq/uDzHxu8rrc2iGa4ldZIM9dSr6jiqCnsTLYF+IUUH4UsoSFz3rDuuENwSEnsJcNbE4YMbLesdy0w4BBO/26cudlzdPzLxL+qDVYaG1/VgnZLfI9lEdwECPinIxvz4Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXQdbkdXM6BgLKETyh2by6jXJeUSUIIr2X4bmusw40Y=;
 b=e8KbeRETK4eLcVoShSVmk8IA+QCLvdUzufrXpdwrciGbCBX8ApYoC4uj8BAZhCVoGL15l3qapaoTNEcOj9q008imTGW9dRIebRUa8isJW2J/bVdZ1ebYJZsWKDsNhugV4UA/M04XtdEoKdKrm56PGfkZVevImEZdCWBQT95jyas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Thu, 29 Sep
 2022 16:58:55 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::daa4:3ae4:39e3:61b5]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::daa4:3ae4:39e3:61b5%6]) with mapi id 15.20.5654.014; Thu, 29 Sep 2022
 16:58:55 +0000
Message-ID: <6c626e8d-4133-00ba-a765-bafe08034517@amd.com>
Date:   Thu, 29 Sep 2022 22:28:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH] sched/fair: Choose the CPU where short task is
 running during wake up
Content-Language: en-US
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
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
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20220915165407.1776363-1-yu.c.chen@intel.com>
 <7975dcbe-97b3-7e6c-4697-5f316731c287@amd.com>
 <YzG5iAyJv3YCDKcp@BLR-5CG11610CF.amd.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <YzG5iAyJv3YCDKcp@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::7) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|PH7PR12MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d100ab-64c3-400f-ecb2-08daa23be4a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EIstVmbtBrpiCept8+UGimQ7EJ2tK3fdm087Awg9R4qDupUL57BKvpLUH0KZZI8UU4mpEfYMGG0DwKRbDS5SexscS4zrdJpFCWjrdJMKVwTuzuo0NuaEKeHf2U+HyNGR9NVfcrDbPO57JxgAyJ2dZgWBvDKuGsSSIARTSvdD4F/7/QEIa/YSGkQBLRTN3SBO32Pbt6AEmNk32xg6dWz4rmXtrMA8mk5S/H1KeTkWPLHb6Un6cDcz3T11rpJX6OsC72AV6scU0B/PGhLmECYnGOlvKvbqV64e1XPvzskk/GxAAAB7l51quPhFvN6OPPD9woUCCNAYY+lRnzEwztepdyKjdrtuk5njhozpmqOZ9akZWyXCRncYM7BeO8GDAffQrYCVk7ypG0b3sTN87v3EO7Nnv9sOmjUsqtnUBHlgavRZltdLhX2wMs9W72vKu9a+ihm7xLwqhjKZI3sGkC5nqDkj58JkANdGqsQz9jnQzgSojj0/SjFL3jnkJZ+OVYuURFG2G2oguPbcETTgwpnq2LlZ1FaLO2MXZZKSbFCCZo0Ipx9dNkYpQTzn9Z1e89bFeFJifkd5btZBkD6vPEg82Eyu525z2G1w6UqtAEGhhSXStLjB6I3F8Y8uqKjuebObSvWr1LZCKWSyN9EGr8KKJnLakce7fLP4nAT8tKs8kPhntLibrbuPwN4KIlQSl44X/CWiU8TcnnH8f/pmfiMrWVMNwFCteIMps/3idoqRHWGcgJgXhY76gAdzWAlHbDV9l2D70zsJD+Y90pkFnGfMc6N2HORLCHubstpgv4yLre8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199015)(54906003)(5660300002)(41300700001)(478600001)(6512007)(26005)(36756003)(38100700002)(8936002)(6486002)(66946007)(6666004)(30864003)(83380400001)(7416002)(6506007)(66476007)(53546011)(66556008)(8676002)(2616005)(316002)(31696002)(186003)(4326008)(110136005)(31686004)(2906002)(86362001)(66899015)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amtmLzJPeVVBTmhpK1krWjdVNXhCOG84Yy9IRjFjc2FWSlA4TmRDellWbDdv?=
 =?utf-8?B?dzBFWU9LNVI3NGhIQWVUdk9CWCtwTE1QZ2VlU2RFdjZUTm93MDZnQ1VQeDF3?=
 =?utf-8?B?NmN2REFCamN4dnJlVVYwRWdqUytLMFJnaEd1UHordS9XTTZ0UU14UkJmTlFT?=
 =?utf-8?B?cjQxWEtLcW1OVjZucGRyUGpzZW4yaFFyWE9teUk5aTdlVEE1MUY4d2pTalpB?=
 =?utf-8?B?S1hicXNzZW1wbUNaY3lXSjBJelhkdzdnRVpOWVJjSCtyMm40VkFnVk1JMlF0?=
 =?utf-8?B?MmY1aktTTCthVmtpYzlPajZxT2ZNRWNZZW1XSWtGV3NrNm1YMW9OSk54Zzlu?=
 =?utf-8?B?SVRweGFRSUdDUW05ZXc3aVNRcC9uaWljckJjR0NOTlcyMGlnU252SUsybFlH?=
 =?utf-8?B?Vno4L2FXeDgxM0FmRDE2bktXalcxaG5sSk5PVGhvQlZXYmFCOEsrb3FMd09M?=
 =?utf-8?B?VGMxVHltdUJJaUdrYVJxcHJJSHhVbTU2Vml6eXptNW9zV254dFl6RXpjODlX?=
 =?utf-8?B?enpCTFlsanMrWDA3dldGOTJIZmJrZ2JQeG5KTHMwTzVsdzNXUGk1UEdITWtC?=
 =?utf-8?B?NitkOHdPT1RpcGFObzV6YW1HcEQvWHVVNS9BclVqMmpVa0hnMllGRnRVMVk1?=
 =?utf-8?B?WkpXdFlhZGdiL2hlczB6RHh1RUY3dE00V1g2dmpHNlRpS045MGpqSUFNeGJQ?=
 =?utf-8?B?bkhuSHl6aWR4L2JDVi9CeXNQZnNtaVZIZGRzSXRWK2M0Uk50V2w2YlFFdnFN?=
 =?utf-8?B?SlhnVUVNVm14TVhPMUtTYVZjTGdoNmdBM01oWjFHYVhxdVdQZEMwWE1FKzdy?=
 =?utf-8?B?d2F5TUlLQkxCUXg4QUdSbUFsL2RRTklOZG96NFBvcGJXK0xHSVpzbDFGR1l4?=
 =?utf-8?B?Mkd0bk5KaTgvREIxS0svWjZ0eHBSUjhpYUcweWhDdzFTVFNaS1hraDJsVitu?=
 =?utf-8?B?UWtGUE5XUEdmaDdYck1iYlVLT0QvRmZWcDU0c1dZY2RPZnB5Ykd3U2JZVkZn?=
 =?utf-8?B?RGdiUUxiM00vSldjcFJoVzg2M0h1bzlvc3o3dlUzVXBmeEFXcURoZk1idUpG?=
 =?utf-8?B?OUZzbVErUEJrSEtzUk1FSGhFR013R2NZSzYxd002OWpyM1FwZnhkS09tTk0z?=
 =?utf-8?B?YWw4YWl5VFhyOHQySmMrVDRFcXl5ZEovSERlY3c0dFIwRC8wdzdLWWxLK250?=
 =?utf-8?B?VGFsaDA5UXIzOU4wOVNONzBsRzNhaVJQRFB2cDk2MHEya2lXeG9sa1pQaTRL?=
 =?utf-8?B?L3E4V0pOdTlHZXFuaHNxczFuajZsTkJvdlFIQzlVTitncU9WcHlJSEZCWmIy?=
 =?utf-8?B?T013b2lVL1ZndUJVSGNGR2tzLzRQTlkvcnhMUnBWeHgzS2E2UHVPZzdrY0xv?=
 =?utf-8?B?WlVZNFdnZWlSTFRvTTA3NWdxSXlZOC9URlZBWG1aRjBuaUsrYUlHQStkZWpB?=
 =?utf-8?B?YnVkd0hYMjdSYmRhRmR1TmpUUFpud05rc2wydVNON2NaMHVpKzlPcENIak90?=
 =?utf-8?B?czB0M2diQWIxeGZCYzI0MkV1SnNtbVcrbE9VdWpDckVubGJ1Znp5WXYrOFhD?=
 =?utf-8?B?TG5wYWp1VGQ1Zit6TFNRQktHTXVyajhjRm5paDNVWm1EdDZhaEdMRVBsTjJ0?=
 =?utf-8?B?L3pOTTFwMElLNVlaN2tvYkxSWXFVZGFSaVlFRzNhWGtKMUx4bDNkYkxDMFFs?=
 =?utf-8?B?V0c1UjJXWWN6SlF2dVVqNkcrSUNvT3lCQ1NyWjZ0TldlR2FZNVBLNlJYdE9J?=
 =?utf-8?B?TXc5K3NaK1ZpaVpUSXdiWEFXVEQ1TDRoTnZETVluY0FQS0h4ckZrSUQ5T0JB?=
 =?utf-8?B?aDdUQTEvMHNmaXM1bWlGbkRMRHVFZHU4MlB4Z3c4djBDQ0hNclVQeXNrOEU5?=
 =?utf-8?B?WnI2ajRHeGhYdnBGRGo1TXRzbjFmSVQ0K2tsendVNlQrTVh5RnNlMlBnUldM?=
 =?utf-8?B?clpkZWYzalFWTWhkT3RFVXo4UVNURkYzUzVOQUQ2Q2JWSHVOaTZHU2Fpd1l6?=
 =?utf-8?B?VmsrS2ZpbC9HMEV3dWpiT09MZFd3UWp6a3R6eEx2Z3Z5YWhRWVZGSEtnbkJy?=
 =?utf-8?B?dFV5UXExSTFmbExyamN0N3BUWTZQb1NER1JoT0JqdmRQQ1JlME5LQzl2M2Ro?=
 =?utf-8?Q?XK2TY9Kv+0WwM2odhM1bJRnUP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d100ab-64c3-400f-ecb2-08daa23be4a0
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 16:58:55.3867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5DVreVBwHUgrz5Lxb47MykrFMYuFQkTC/TAf2cK/yOLohkIoqiADZnhEOFU76HGCTr+p7n68CcQ4H3Eh92ueA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gautham and Chenyu,

On 9/26/2022 8:09 PM, Gautham R. Shenoy wrote:
> Hello Prateek,
> 
> On Mon, Sep 26, 2022 at 11:20:16AM +0530, K Prateek Nayak wrote:[
> 
> [..snip..]
> 
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
> 
> We need to check if moving the is_short_task() to a later point after
> checking the availability of the previous CPU solve the problem for
> the workloads which showed regressions on AMD EPYC systems.

I've done some testing with moving the condition check for short
running task to the end of wake_affine_idle and checking if the
length of run queue is 1 similar to what Tim suggested in the thread
but doing it upfront in wake_affine_idle. There are a few variations
I've tested:

v1: move the check for short running task on current CPU to end of wake_affine_idle

v2: move the check for short running task on current CPU to end of wake_affine_idle
    + remove entire hunk in select_idle_cpu

v3: move the check for short running task on current CPU to end of wake_affine_idle
    + check if run queue of current CPU only has 1 task

v4: move the check for short running task on current CPU to end of wake_affine_idle
    + check if run queue of current CPU only has 1 task
    + remove entire hunk in select_idle_cpu

Adding diff for v3 below:
--
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0ad8e7183bf2..dad9bfb0248d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6074,13 +6074,15 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
 		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
 
-	if ((sync && cpu_rq(this_cpu)->nr_running == 1) ||
-	    is_short_task(cpu_curr(this_cpu)))
+	if (sync && cpu_rq(this_cpu)->nr_running == 1)
 		return this_cpu;
 
 	if (available_idle_cpu(prev_cpu))
 		return prev_cpu;
 
+	if (cpu_rq(this_cpu)->nr_running == 1 && is_short_task(cpu_curr(this_cpu)))
+		return this_cpu;
+
 	return nr_cpumask_bits;
 }
 
--

Deviation from above diff in other versions are as follows:

o v1 and v2 doesn't check cpu_rq(this_cpu)->nr_running == 1 and only
  moves the condition check to end of wake_affine_idle as:

	if (is_short_task(cpu_curr(this_cpu)))
		return this_cpu;

o The second hunk of changes in select_idle_cpu form RFC remains same
  in v1 and v3 but is removed in v2 and v3 to check if that was the
  cause of pileup seen in case of Hackbench.

Following are the results of the standard benchmarks on a dual socket
Zen3 system (2 x 64C/128T) in NPS1 and NPS4 mode:

~~~~~~~~~~~~~
~ Hackbench ~
~~~~~~~~~~~~~

o NPS1

Test:                   tip                     v1                      v2                      v3                      v4
 1-groups:         4.23 (0.00 pct)         4.21 (0.47 pct)         4.29 (-1.41 pct)        4.02 (4.96 pct)         4.34 (-2.60 pct)
 2-groups:         4.93 (0.00 pct)         5.23 (-6.08 pct)        5.20 (-5.47 pct)        4.75 (3.65 pct)         4.77 (3.24 pct)
 4-groups:         5.32 (0.00 pct)         5.64 (-6.01 pct)        5.66 (-6.39 pct)        5.13 (3.57 pct)         5.22 (1.87 pct)
 8-groups:         5.46 (0.00 pct)         5.92 (-8.42 pct)        5.96 (-9.15 pct)        5.24 (4.02 pct)         5.37 (1.64 pct)
16-groups:         7.31 (0.00 pct)         7.16 (2.05 pct)         7.17 (1.91 pct)         6.65 (9.02 pct)         7.05 (3.55 pct)

o NPS4

Test:                   tip                     v1                      v2                      v3                      v4
 1-groups:         4.23 (0.00 pct)         4.20 (0.70 pct)         4.37 (-3.30 pct)        4.02 (4.96 pct)         4.23 (0.00 pct)
 2-groups:         4.78 (0.00 pct)         5.07 (-6.06 pct)        5.07 (-6.06 pct)        4.60 (3.76 pct)         4.67 (2.30 pct)
 4-groups:         5.17 (0.00 pct)         5.47 (-5.80 pct)        5.50 (-6.38 pct)        5.01 (3.09 pct)         5.12 (0.96 pct)
 8-groups:         5.63 (0.00 pct)         5.77 (-2.48 pct)        5.84 (-3.73 pct)        5.48 (2.66 pct)         5.47 (2.84 pct)
16-groups:         7.88 (0.00 pct)         6.43 (18.40 pct)        6.60 (16.24 pct)       12.14 (-54.06 pct)       6.51 (17.38 pct)  *
16-groups:        10.28 (0.00 pct)         6.62 (35.60 pct)        6.68 (35.01 pct)        8.67 (15.66 pct)        6.96 (32.29 pct)  [Verification Run]

~~~~~~~~~~~~~
~ schebench ~
~~~~~~~~~~~~~

o NPS 1

#workers:     tip                     v1                      v2                      v3                      v4
  1:      22.00 (0.00 pct)        33.00 (-50.00 pct)      29.00 (-31.81 pct)      33.00 (-50.00 pct)      32.00 (-45.45 pct)
  2:      34.00 (0.00 pct)        34.00 (0.00 pct)        36.00 (-5.88 pct)       37.00 (-8.82 pct)       36.00 (-5.88 pct)
  4:      37.00 (0.00 pct)        39.00 (-5.40 pct)       36.00 (2.70 pct)        40.00 (-8.10 pct)       34.00 (8.10 pct)
  8:      55.00 (0.00 pct)        43.00 (21.81 pct)       52.00 (5.45 pct)        47.00 (14.54 pct)       55.00 (0.00 pct)
 16:      69.00 (0.00 pct)        64.00 (7.24 pct)        65.00 (5.79 pct)        65.00 (5.79 pct)        67.00 (2.89 pct)
 32:     113.00 (0.00 pct)       110.00 (2.65 pct)       112.00 (0.88 pct)       106.00 (6.19 pct)       108.00 (4.42 pct)
 64:     219.00 (0.00 pct)       200.00 (8.67 pct)       221.00 (-0.91 pct)      214.00 (2.28 pct)       217.00 (0.91 pct)
128:     506.00 (0.00 pct)       509.00 (-0.59 pct)      507.00 (-0.19 pct)      495.00 (2.17 pct)       535.00 (-5.73 pct)
256:     45440.00 (0.00 pct)     44096.00 (2.95 pct)     47296.00 (-4.08 pct)    43968.00 (3.23 pct)     42432.00 (6.61 pct)
512:     76672.00 (0.00 pct)     82304.00 (-7.34 pct)    82304.00 (-7.34 pct)    73088.00 (4.67 pct)     78976.00 (-3.00 pct)

o NPS4

#workers:     tip                     v1                      v2                      v3                      v4
  1:      30.00 (0.00 pct)        35.00 (-16.66 pct)      20.00 (33.33 pct)       30.00 (0.00 pct)        34.00 (-13.33 pct)
  2:      34.00 (0.00 pct)        35.00 (-2.94 pct)       36.00 (-5.88 pct)       38.00 (-11.76 pct)      37.00 (-8.82 pct)
  4:      41.00 (0.00 pct)        39.00 (4.87 pct)        43.00 (-4.87 pct)       39.00 (4.87 pct)        41.00 (0.00 pct)
  8:      60.00 (0.00 pct)        64.00 (-6.66 pct)       53.00 (11.66 pct)       52.00 (13.33 pct)       56.00 (6.66 pct)
 16:      68.00 (0.00 pct)        68.00 (0.00 pct)        69.00 (-1.47 pct)       71.00 (-4.41 pct)       67.00 (1.47 pct)
 32:     116.00 (0.00 pct)       115.00 (0.86 pct)       118.00 (-1.72 pct)      111.00 (4.31 pct)       113.00 (2.58 pct)
 64:     224.00 (0.00 pct)       208.00 (7.14 pct)       217.00 (3.12 pct)       224.00 (0.00 pct)       231.00 (-3.12 pct)
128:     495.00 (0.00 pct)       523.00 (-5.65 pct)      567.00 (-14.54 pct)     515.00 (-4.04 pct)      675.00 (-36.36 pct)  *
256:     45888.00 (0.00 pct)     45888.00 (0.00 pct)     46656.00 (-1.67 pct)    47168.00 (-2.78 pct)    44864.00 (2.23 pct)
512:     78464.00 (0.00 pct)     78976.00 (-0.65 pct)    83584.00 (-6.52 pct)    76672.00 (2.28 pct)     80768.00 (-2.93 pct)

Note: schbench shows a large amount of run to run variation for
lower worker count. The results have been included to check for
any large increase in latency that suggests schbench task queuing
behind one another.

~~~~~~~~~~
~ tbench ~
~~~~~~~~~~

o NPS 1

Clients:      tip                     v1                      v2                      v3                      v4
    1    550.66 (0.00 pct)       582.73 (5.82 pct)       572.06 (3.88 pct)       576.94 (4.77 pct)       582.44 (5.77 pct)
    2    1009.69 (0.00 pct)      1087.30 (7.68 pct)      1056.81 (4.66 pct)      1072.44 (6.21 pct)      1041.94 (3.19 pct)
    4    1795.32 (0.00 pct)      1847.22 (2.89 pct)      1869.23 (4.11 pct)      1839.32 (2.45 pct)      1877.57 (4.58 pct)
    8    2971.16 (0.00 pct)      3144.05 (5.81 pct)      3137.94 (5.61 pct)      3100.27 (4.34 pct)      3032.99 (2.08 pct)
   16    4627.98 (0.00 pct)      4704.22 (1.64 pct)      4752.77 (2.69 pct)      4833.24 (4.43 pct)      4726.70 (2.13 pct)
   32    8065.15 (0.00 pct)      8172.79 (1.33 pct)      9266.77 (14.89 pct)     9508.24 (17.89 pct)     9199.91 (14.06 pct)
   64    14994.32 (0.00 pct)     15357.75 (2.42 pct)     15246.82 (1.68 pct)     15670.37 (4.50 pct)     15433.18 (2.92 pct)
  128    5175.73 (0.00 pct)      3062.00 (-40.83 pct)    18429.11 (256.06 pct)   3365.81 (-34.96 pct)    2633.09 (-49.12 pct)  *
  128    20490.63 (0.00 pct)     20504.17 (0.06 pct)     21183.21 (3.37 pct)     20469.20 (-0.10 pct)    20879.77 (1.89 pct)   [Verification Run]
  256    48763.57 (0.00 pct)     50703.97 (3.97 pct)     50723.68 (4.01 pct)     49387.93 (1.28 pct)     49552.81 (1.61 pct)
  512    43780.78 (0.00 pct)     45328.44 (3.53 pct)     45328.59 (3.53 pct)     45384.80 (3.66 pct)     43897.43 (0.26 pct)
 1024    40341.84 (0.00 pct)     42823.05 (6.15 pct)     42262.72 (4.76 pct)     41856.06 (3.75 pct)     40785.67 (1.10 pct)

o NPS 4

Clients:      tip                     v1                      v2                      v3                      v4
    1    549.22 (0.00 pct)       582.89 (6.13 pct)       576.74 (5.01 pct)       582.34 (6.03 pct)       585.19 (6.54 pct)
    2    1000.08 (0.00 pct)      1111.54 (11.14 pct)     1043.47 (4.33 pct)      1060.99 (6.09 pct)      1071.39 (7.13 pct)
    4    1794.78 (0.00 pct)      1895.64 (5.61 pct)      1858.40 (3.54 pct)      1828.08 (1.85 pct)      1862.47 (3.77 pct)
    8    3008.50 (0.00 pct)      3117.10 (3.60 pct)      3060.15 (1.71 pct)      3143.65 (4.49 pct)      3065.17 (1.88 pct)
   16    4804.71 (0.00 pct)      4677.82 (-2.64 pct)     4587.01 (-4.53 pct)     4694.21 (-2.29 pct)     4627.39 (-3.69 pct)
   32    9156.57 (0.00 pct)      8462.23 (-7.58 pct)     8290.70 (-9.45 pct)     7906.44 (-13.65 pct)    8679.98 (-5.20 pct)    *
   32    9157.62 (0.00 pct)      8712.33 (-4.86 pct)     8640.77 (-5.64 pct)     9415.99 (2.82 pct)      9403.35 (2.68 pct)     [Verification Run]
   64    14901.45 (0.00 pct)     15263.87 (2.43 pct)     15031.33 (0.87 pct)     15149.54 (1.66 pct)     14714.04 (-1.25 pct)
  128    20771.20 (0.00 pct)     21114.00 (1.65 pct)     17818.77 (-14.21 pct)   17686.98 (-14.84 pct)   15917.79 (-23.36 pct)  *
  128    20490.63 (0.00 pct)     20504.17 (0.06 pct)     21183.21 (3.37 pct)     20469.20 (-0.10 pct)    20879.77 (1.89 pct)    [Verification Run]
  256    47033.88 (0.00 pct)     48021.71 (2.10 pct)     48439.88 (2.98 pct)     48042.49 (2.14 pct)     49294.05 (4.80 pct)
  512    43429.01 (0.00 pct)     44488.54 (2.43 pct)     43672.99 (0.56 pct)     42462.44 (-2.22 pct)    44072.90 (1.48 pct)
 1024    39271.27 (0.00 pct)     42304.03 (7.72 pct)     41850.17 (6.56 pct)     39791.47 (1.32 pct)     41528.81 (5.74 pct)

Note: tbench for 128 clients runs into an ACPI idle driver issue
that is fixed by the commit e400ad8b7e6a ("ACPI: processor idle:
Practically limit "Dummy wait" workaround to old Intel systems")
which will be a part of the v6.0 kernel release.

~~~~~~~~~~
~ stream ~
~~~~~~~~~~

o NPS 1

- 10 runs

Test:            tip                     v1                      v2                      v3                      v4
 Copy:   335832.93 (0.00 pct)    338535.58 (0.80 pct)    334772.76 (-0.31 pct)   337487.50 (0.49 pct)    336720.22 (0.26 pct)
Scale:   212781.21 (0.00 pct)    217118.20 (2.03 pct)    213011.28 (0.10 pct)    216905.50 (1.93 pct)    213371.06 (0.27 pct)
  Add:   251667.59 (0.00 pct)    240811.38 (-4.31 pct)   250478.75 (-0.47 pct)   250584.95 (-0.43 pct)   250987.62 (-0.27 pct)
Triad:   251537.87 (0.00 pct)    261919.66 (4.12 pct)    260702.92 (3.64 pct)    251181.87 (-0.14 pct)   262152.01 (4.21 pct)

- 100 runs

Test:            tip                     v1                      v2                      v3                      v4
 Copy:   335721.37 (0.00 pct)    337441.09 (0.51 pct)    338472.90 (0.81 pct)    335777.78 (0.01 pct)    338434.23 (0.80 pct)
Scale:   219593.12 (0.00 pct)    224083.11 (2.04 pct)    218742.58 (-0.38 pct)   221381.50 (0.81 pct)    219603.23 (0.00 pct)
  Add:   251612.53 (0.00 pct)    251633.66 (0.00 pct)    251593.37 (0.00 pct)    251261.72 (-0.13 pct)   251838.27 (0.08 pct)
Triad:   261985.15 (0.00 pct)    261639.38 (-0.13 pct)   263003.34 (0.38 pct)    261084.30 (-0.34 pct)   260353.64 (-0.62 pct)

o NPS 4

- 10 runs

Test:            tip                     v1                      v2                      v3                      v4
 Copy:   354774.17 (0.00 pct)    359486.69 (1.32 pct)    368017.56 (3.73 pct)    374514.29 (5.56 pct)    344022.60 (-3.03 pct)
Scale:   231870.22 (0.00 pct)    221056.77 (-4.66 pct)   246191.29 (6.17 pct)    244736.54 (5.54 pct)    232084.49 (0.09 pct)
  Add:   258728.29 (0.00 pct)    243136.12 (-6.02 pct)   259962.30 (0.47 pct)    273104.99 (5.55 pct)    256671.88 (-0.79 pct)
Triad:   269237.56 (0.00 pct)    282994.33 (5.10 pct)    286902.41 (6.56 pct)    290661.36 (7.95 pct)    269610.52 (0.13 pct)

- 100 runs

Test:            tip                     v1                      v2                      v3                      v4
 Copy:   369249.91 (0.00 pct)    360411.30 (-2.39 pct)   364531.71 (-1.27 pct)   374280.94 (1.36 pct)    372066.41 (0.76 pct)
Scale:   254849.59 (0.00 pct)    253724.21 (-0.44 pct)   254868.47 (0.00 pct)    254916.90 (0.02 pct)    256054.43 (0.47 pct)
  Add:   273124.66 (0.00 pct)    272945.31 (-0.06 pct)   272989.26 (-0.04 pct)   260213.79 (-4.72 pct)   273955.09 (0.30 pct)
Triad:   287935.27 (0.00 pct)    284522.85 (-1.18 pct)   284797.06 (-1.08 pct)   290192.01 (0.78 pct)    288755.39 (0.28 pct)

~~~~~~~~~~~~~~~~~~~~~~~~~
~ Notes and Observation ~
~~~~~~~~~~~~~~~~~~~~~~~~~

We still see a pileup with v1 and v2 but not with v3 and v4 suggesting
that the second hunk is not the reason for the pileup but rather
choosing the current CPU in wake_affine_idle on the basis that the
current running task is the short running task. To prevent a pileup, we
must only choose the current rq if the short running task is the only
task running there.

I've not checked for the sync flag to allow for a larger opportunity
for affine wakeup. This assumes that wake_affine() is called only for
tasks that can benefit from an affine wakeup.

Sharing more data from the test runs:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~ Hackbench 2 groups schedstat data ~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

o NPS1

---------------------------------------------------------------------------------------------------------------------------
cpu:  all_cpus (avg) vs cpu:  all_cpus (avg)
---------------------------------------------------------------------------------------------------------------------------
kernel                                                     :            v1            v3                      v4
sched_yield count                                          :             0,            0                       0
Legacy counter can be ignored                              :             0,            0                       0
schedule called                                            :         49196,        51320                   67541  |  37.29|
schedule left the processor idle                           :         21399,        21609                   32655  |  52.60|
try_to_wake_up was called                                  :         27726,        29630  |   6.87|        34868  |  25.76|
try_to_wake_up was called to wake up the local cpu         :          2049,         1195  | -41.68|          409  | -80.04|
total runtime by tasks on this processor (in jiffies)      :     548520817,    582155720  |   6.13|   1068137641  |  94.73|
total waittime by tasks on this processor (in jiffies)     :     668076627,    480034644  | -28.15|     77773209  | -88.36|  * v3 and v4 have lower wait time
total timeslices run on this cpu                           :         27791,        29703  |   6.88|        34883  |  25.52|    and a larger runtime / waittime ratio

< -----------------------------------------------------------------  Wakeup info:  -------------------------------------- >
kernel                                                  :            v1            v3                    v4
Wakeups on same         SMT cpus = all_cpus (avg)       :          1368,         1403                   309  | -77.41|
Wakeups on same         MC cpus = all_cpus (avg)        :         20980,        21018                 11493  | -45.22|
Wakeups on same         DIE cpus = all_cpus (avg)       :          2074,         3499  |  68.71|      11166  | 438.38|
Wakeups on same         NUMA cpus = all_cpus (avg)      :          1252,         2514  | 100.80|      11489  | 817.65|
Affine wakeups on same  SMT cpus = all_cpus (avg)       :          1400,         1046  | -25.29|        142  | -89.86|
Affine wakeups on same  MC cpus = all_cpus (avg)        :         18940,        13474  | -28.86|       2916  | -84.60|
Affine wakeups on same  DIE cpus = all_cpus (avg)       :          2163,         2827  |  30.70|       3771  |  74.34|
Affine wakeups on same  NUMA cpus = all_cpus (avg)      :          1145,         1945  |  69.87|       3466  | 202.71|
---------------------------------------------------------------------------------------------------------------------------

o NPS4

----------------------------------------------------------------------------------------------------------------------------
cpu:  all_cpus (avg) vs cpu:  all_cpus (avg)
----------------------------------------------------------------------------------------------------------------------------
kernel                                                     :            v1            v3                       v4
sched_yield count                                          :             0,            0                        0
Legacy counter can be ignored                              :             0,            0                        0
schedule called                                            :         49685,        50335                    55266  |  11.23|
schedule left the processor idle                           :         21755,        21269                    25277  |  16.19|
try_to_wake_up was called                                  :         27870,        28990                    29955  |   7.48|
try_to_wake_up was called to wake up the local cpu         :          2054,         1246  | -39.34|           666  | -67.58|
total runtime by tasks on this processor (in jiffies)      :     582044948,    657092589  |  12.89|     860907207  |  47.91|
total waittime by tasks on this processor (in jiffies)     :     610820439,    435359035  | -28.73|     171279622  | -71.96| * Same is observed in NPS4 runs
total timeslices run on this cpu                           :         27923,        29059                    29985  |   7.38|

< -----------------------------------------------------------------  Wakeup info:  --------------------------------------- >
kernel                                                  :            v1            v3                    v4
Wakeups on same         SMT cpus = all_cpus (avg)       :          1307,         1229  |  -5.97|        699  | -46.52|
Wakeups on same         MC cpus = all_cpus (avg)        :         19854,        19726                 16895  | -14.90|
Wakeups on same         NODE cpus = all_cpus (avg)      :           818,         1442  |  76.28|       1959  | 139.49|
Wakeups on same         NUMA cpus = all_cpus (avg)      :          2068,         3257  |  57.50|       6861  | 231.77|
Wakeups on same         NUMA cpus = all_cpus (avg)      :          1767,         2088  |  18.17|       2871  |  62.48|
Affine wakeups on same  SMT cpus = all_cpus (avg)       :          1314,          887  | -32.50|        439  | -66.59|
Affine wakeups on same  MC cpus = all_cpus (avg)        :         17572,        11754  | -33.11|       6971  | -60.33|
Affine wakeups on same  NODE cpus = all_cpus (avg)      :           885,         1195  |  35.03|       1379  |  55.82|
Affine wakeups on same  NUMA cpus = all_cpus (avg)      :          1516,         2792  |  84.17|       4070  | 168.47|
Affine wakeups on same  NUMA cpus = all_cpus (avg)      :           845,         2042  | 141.66|       1823  | 115.74|
----------------------------------------------------------------------------------------------------------------------------

~~~~~~~~~~~~~~~~~
~ Stream traces ~
~~~~~~~~~~~~~~~~~

Trace is obtained by enabling the following tracepoints:
- sched_wakeup_new
- sched_migrate_task

 trace_stream.sh-4581    [130] d..2.  1795.126862: sched_wakeup_new: comm=trace_stream.sh pid=4589 prio=120 target_cpu=008 (LLC: 1)
          stream-4589    [008] d..2.  1795.128145: sched_wakeup_new: comm=stream pid=4591 prio=120 target_cpu=159 (LLC: 3)
          stream-4589    [008] d..2.  1795.128189: sched_wakeup_new: comm=stream pid=4592 prio=120 target_cpu=162 (LLC: 4)
          stream-4589    [008] d..2.  1795.128259: sched_wakeup_new: comm=stream pid=4593 prio=120 target_cpu=202 (LLC: 9)
          stream-4589    [008] d..2.  1795.128281: sched_wakeup_new: comm=stream pid=4594 prio=120 target_cpu=173 (LLC: 5)
          stream-4589    [008] d..2.  1795.128311: sched_wakeup_new: comm=stream pid=4595 prio=120 target_cpu=214 (LLC: 10)
          stream-4589    [008] d..2.  1795.128366: sched_wakeup_new: comm=stream pid=4596 prio=120 target_cpu=053 (LLC: 6)
          stream-4589    [008] d..2.  1795.128454: sched_wakeup_new: comm=stream pid=4597 prio=120 target_cpu=088 (LLC: 11)
          stream-4589    [008] d..2.  1795.128475: sched_wakeup_new: comm=stream pid=4598 prio=120 target_cpu=191 (LLC: 7)
          stream-4589    [008] d..2.  1795.128508: sched_wakeup_new: comm=stream pid=4599 prio=120 target_cpu=096 (LLC: 12)
          stream-4589    [008] d..2.  1795.128568: sched_wakeup_new: comm=stream pid=4600 prio=120 target_cpu=130 (LLC: 0)
          stream-4589    [008] d..2.  1795.128620: sched_wakeup_new: comm=stream pid=4601 prio=120 target_cpu=239 (LLC: 13)
          stream-4589    [008] d..2.  1795.128641: sched_wakeup_new: comm=stream pid=4602 prio=120 target_cpu=146 (LLC: 2)
          stream-4589    [008] d..2.  1795.128672: sched_wakeup_new: comm=stream pid=4603 prio=120 target_cpu=247 (LLC: 14)
          stream-4589    [008] d..2.  1795.128747: sched_wakeup_new: comm=stream pid=4604 prio=120 target_cpu=255 (LLC: 15)
          stream-4589    [008] d..2.  1795.128784: sched_wakeup_new: comm=stream pid=4605 prio=120 target_cpu=066 (LLC: 8)

	No migrations were observed till the end of the run

- Initial task placement distribution

        +--------+-------------------------------------+
        | LLC ID |  Tasks initially placed on this LLC |
        +--------+-------------------------------------+
        |   0    |                  1                  |
        |   1    |                  1                  |
        |   2    |                  1                  |
        |   3    |                  1                  |
        |   4    |                  1                  |
        |   5    |                  1                  |
        |   6    |                  1                  |
        |   7    |                  1                  |
        |   8    |                  1                  |
        |   9    |                  1                  |
        |   10   |                  1                  |
        |   11   |                  1                  |
        |   12   |                  1                  |
        |   13   |                  1                  |
        |   14   |                  1                  |
        |   15   |                  1                  |
        +--------+-------------------------------------+

A point to note is Stream is more sensitive initially when tasks have not
run for long enough where, if a kworker or another short running task
is running on the previous CPU during wakeup, the logic will favor an
affine wakeup as initially as scheduler might not realize Stream is a
long running task.

Let me know if you would like me to gather more data on the test system
for the modified kernels discussed above. 
--
Thanks and Regards,
Prateek
