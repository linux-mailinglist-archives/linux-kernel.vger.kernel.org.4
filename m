Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153445E98FD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 07:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiIZFul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 01:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiIZFui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 01:50:38 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33581F2C8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 22:50:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzNyLabP7Y1NP2jhF14T5a5JoIaQydjiXtQYHlIlFhjBvZ6cuxcTmODqWXZRN3FEwmjxEJ0QKOD9T/9e+9gRjWWKJsJdL9CEULnRhe5CWpFWAUOwTSmVbTujGklFgILvmURYJUy5PwHCQ5xJwnYGI7yrNoZsmWg4AnyyfJX//fn+Wb+uEELxg5jWuaMN7xSz8ne00ZrxfPVS3wY23fDwnIad+/ixiOk6GazkpW/19JVFKvsibym89QOYq8xPtds5O9u6utONfUod54Z5FEwhIxKWn2HPNZFtYWay00Fq8IWLrlUKv5LTpa+TAOaclINH0Uo4Z28BQjMgYjm8mwvZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bl8SDHljm+r9HWKaJjl9orNIIOmeA4z32GTeMEaIiKM=;
 b=Q40+r9wrK6AU3sfHHpdz2ALyZZ9T4pBucWqTWsGiXb3YqlibCkQ/6JTpGOSzvNgTwuftt4esF+s7rg3+BzKiPfxEUqwCQEGn2MtXLOuoK9k10ro2Zs/GzgV94L4aUmXXY+kzGW8FZiM/tgQu3nfSlhX+n1XRrQtvVWxmlT/40PWARlku0IxusqCCJlkSQY1zsZtrfjXcDmPscHAelEOxV+SNvlwuXDCh7aUseIueoEaN4xa1zCJm4gl7B/mCFSiHI/0OT2OwT8Iw4fuFvSR/P8Wkw83KkmcaB/qwLvXrpkroLi0VK/FysScvqbR48cr4dUHtH+ljNzJQ2dd5U++Ndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bl8SDHljm+r9HWKaJjl9orNIIOmeA4z32GTeMEaIiKM=;
 b=nksbym8c7yO7xToK3Q8qgYC0Z0guEroj6DPSFRRq5X3QhVyPTpKozwpToNhpSnDQgFKpi7qf6wEOqJobQbYXByDKsuzaE7bj7RPKHg+1RMbki1z1yWgTpqnSWLAzFTTvXTV8GvnssmGEd895pMbLOwMe+lUFm9jM56sciA3deU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2381.namprd12.prod.outlook.com (2603:10b6:802:2f::13)
 by BL0PR12MB4898.namprd12.prod.outlook.com (2603:10b6:208:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 05:50:33 +0000
Received: from SN1PR12MB2381.namprd12.prod.outlook.com
 ([fe80::c534:ae1c:f7a1:1f33]) by SN1PR12MB2381.namprd12.prod.outlook.com
 ([fe80::c534:ae1c:f7a1:1f33%4]) with mapi id 15.20.5632.021; Mon, 26 Sep 2022
 05:50:32 +0000
Message-ID: <7975dcbe-97b3-7e6c-4697-5f316731c287@amd.com>
Date:   Mon, 26 Sep 2022 11:20:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH] sched/fair: Choose the CPU where short task is
 running during wake up
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
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
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220915165407.1776363-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::16) To SN1PR12MB2381.namprd12.prod.outlook.com
 (2603:10b6:802:2f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2381:EE_|BL0PR12MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: f322ae8c-ce84-48fb-db38-08da9f830672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNaH8Fu+02ZgyTTYkgTCilYs+d73Kd9t7kuGGd15AAaZAVsSpZqE5ok6s7X82aNi1NvrFX5czZpqPw3A3u0qVWVgJBXStK8eyZzo8IMH9PiL5AtJb/jpXF7JRhfNYuIdUWgjT5PMo+oHC38koaDgswh4qKhQAzB8rFey272MyTTVGP0jTZkMdNPOfJ4M1GcMx7lUI3EOG5ry5VnAJcV7yC98oMXhJX/gCgiA+v5I/2bdabN3y83lC/Bs6HeoIREq/aj6p75ThvBIHEK0EfsnLDeZ5dW77Xw6bGSaaw2eS2QNWMnJXPPaO1k4r/DwXt0KpbX9kFxSBpF8UcriLOgb/jx1eRzLlQM1N45uDL7zEl1KSlxFYLad1O+trsfP/CzZWSgBbVUsvdy9yzE7Pzk0oliqHuxbW79djyjYboUiCjURSzflZGB6jsx+GjDnr3SA0A6awFaWFxMu3tbZB7Dhd6gzj19CakNnqEYZxpHhgxewwcAFcMyKL6v3bunxE8d7fabsc50aHdZHTp1/Yvtr5vlAZW2K79WsILVUK6nTCCStY4zrLv6/e7rsPIC3uM+90wBc4QhRvMXNeHThQciM61W/lUVPnZhJqTe0xFYgmOuKTRxU1oZAIHYYDBjztRdAY8ipIOs50zUDiPRmywcrOBWrYosNL3t/DO/chMQSiPSRCjxgQoLkjn46KgALp5Z2k26jcHNY7ueOvxeWMpJH7SmHupnG3swDyCFtb2bpiAsBwvuJmZgueUgaCbNDnnmorBiOh55FkLy2yWHF54ofe4kMKLuMNTpt8+Dlsxs5y0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(136003)(346002)(376002)(366004)(396003)(451199015)(30864003)(5660300002)(26005)(7416002)(6512007)(6506007)(8936002)(53546011)(6666004)(38100700002)(83380400001)(41300700001)(2616005)(186003)(36756003)(2906002)(110136005)(54906003)(66899012)(31686004)(31696002)(66946007)(66556008)(66476007)(8676002)(4326008)(86362001)(316002)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yzc5K3RrUU9aOVUvUXVudmtBUVdNRWp3UG1xamNjMDg0RUdWbElPelQvMUR5?=
 =?utf-8?B?RnNpYU4vK3E5UzBjNVR4UE9oaFBETUpGaXE0bU9kUG8vaVFEVTJ5NUxoVDRn?=
 =?utf-8?B?aXdUaWh1NzE0ZWdVUm9NTWgzMWVhYllpR0E4dkhHWTlHdi9nd2F0aEg0YUtD?=
 =?utf-8?B?dExpNGZHbTFwUWxvekdvRnFTb2h5MTJydE5NZzIwVEc1c01ZZHl4elhvQlZy?=
 =?utf-8?B?L01DcVY1YXhPRHMvTzh2VEtUaWJLRzBoZm96LytXS1RZcTdDUi9TQ2hkdkNZ?=
 =?utf-8?B?dndIWUFsSHVlbGdnOVFYc0Z0VzJLY09LajJUOGNUNTVQb2JJWlF6b3U1U2c2?=
 =?utf-8?B?S1d1enVaM0M5OVZ1dWJnbTZtQWtlY0tnT1RkL3ZmUS9LS0YwY2lZd09xODNy?=
 =?utf-8?B?SzJyRkNKT3hZVmd5RTIvUHVhTUNiNDlXbnhZaEJJNlB4eEU5d3NBUkJ2NWZT?=
 =?utf-8?B?aEtYeEtRYVBZNmJIVWFPTHMwWE5YbDdMcy9FWjJhanhRS2hyWjlBN0Jxa20y?=
 =?utf-8?B?TGJGd1ZmZk85NzhNOXgzNzRlLzQzTnh5N3AyZFFXTGZya1lGc2tCUVdxM2xN?=
 =?utf-8?B?NjQzdkxTTEtlU2J6VTlTdEtWb0QxMlBJZ1JKR3RqR0F6dEhaVGNVMzVJY0dl?=
 =?utf-8?B?dkxDckFjdHc5d2h4OC8zL05pTTlVbEpYVW9EcGd6YU9aZmZWb0NLZENYV1pv?=
 =?utf-8?B?RDJDM3UxRnNVZThnNEJxQURBZ1NmZVk0L2xjOGNPNEpCanBVbWdBRjJQS0Vk?=
 =?utf-8?B?NlpaSW5ydDFEMFhReWFmQUlkVC9va1BzdVZoYXRGSXBEbjFpNWJrVTlNNVIx?=
 =?utf-8?B?MHpja2ErL1FoMkc0VW92S2ErM0N6cDdLdVNhYW90ZUZPN0xMNEdUSVhVQVQ5?=
 =?utf-8?B?bk96dWhuei9ldjduY2pvSVVLTVVQVWdWUGFkcDZjV3AvdWUxZ0pUOXUybDB1?=
 =?utf-8?B?aXVYSUlucmYxUk9nT0kvc3FlNkNLU3Z1RTA2UmhuSXI2ZEFGVEtnYkRveFFY?=
 =?utf-8?B?NVN6K1NLVyswTVdva1creGppTDN2dEp6dmR2aTNzM2xlZm9XQlllSy9Mb01F?=
 =?utf-8?B?Y2l5dUo5OG1xY2kvd2dIemVUWnk3Q1F4dUpGYUhhVnhMZHZ5dlV3UTlSdENM?=
 =?utf-8?B?d052YUdnQ3Q0M2dySHAvT0hYQUE4eTU1S1NjTDUvL0l1U0Z3QmZDZElzMWlS?=
 =?utf-8?B?aEwzdzQxYjBaSzk4bzY2Q2V5TjBOVjVRaDFtRFdRTzdUUXRyVDZzMTVPNlJM?=
 =?utf-8?B?NGJza2N6dzNFMXYrRUFSeDUrSDhjbnJIQkRIS0lyRjMzZG5qZXY4aDMxWGtU?=
 =?utf-8?B?VVpRNEgrLzNnNUFRaXhUUFBPeGtqdVZ1YzdxQWY0aml1aWNGNW0vR3lVRFds?=
 =?utf-8?B?QWdMQVZDRFdCQlJzM0RBRFNMSHBxL3Q5alNGMnRJb3NWRmhabVFveGJTN3dk?=
 =?utf-8?B?Rmkzcnc3dlRNN2U2NklsZTZWZ0tyRm5FeHB2Mlp3dEo3M3pVM3pXK01pdmFQ?=
 =?utf-8?B?WmhaVnhmT0J4aU9CVTMyYS9nREhsc0JTeVd5ZGJ1R2hSTjBTQlBKMVdyVGxI?=
 =?utf-8?B?SzcyUTQvSHQyR05KN3pBNlpXYUNiZnFkaDRhazJ1Tk9hdEw1N2Z0eGJ2M2Nn?=
 =?utf-8?B?Q1JITmN5NDZxTmJrKzNrdS8vTm5YcFRaRVNLOWh1RDQ1cjlsWndSTWx3d1Ew?=
 =?utf-8?B?Y0kwaGxjd0RRT2YzVjZJdDQ0akthTGo2aFJzaFJwRWZRVk5kQys4N0JqcG94?=
 =?utf-8?B?Q2t0b3lwY0NIdm5vS01PcGpnbXNEYUNBcHhrNnM0Q3VyZmFkNzU0MlBBenE4?=
 =?utf-8?B?QnNjYklHQWtUTVBqYWVJQTg4VjRBdnBib1FoR1oySU53MmFTMjBUbXpHeVlj?=
 =?utf-8?B?Ykw0MHNaLzFDZGRUTG9sVEZGZHE5OHoyTGpCRStiTittckEvUDJQNXI3UVBT?=
 =?utf-8?B?aVNIdTFQNjVQVUNINmxQWGd6eWJRT3ZLaUxsck05NWpralBMOTZtL1cvUDkz?=
 =?utf-8?B?SGxpQVlDUHNMaklWdlQwR21rWklzYVM1ZVZMYnpyTU01dmpyUFErNzB6Uy9j?=
 =?utf-8?B?SjBtajk5SDNoRm14cGFPVDVQTmZLb2ptVDdqNnRBNHhBYVF1WGliQi9lek8y?=
 =?utf-8?Q?hwB297cPTlW8ORvBOlqhVRbaf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f322ae8c-ce84-48fb-db38-08da9f830672
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 05:50:32.8600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2qVnLOJ8kAhQR1S+RMG6pzYln2t/JvdoLwpoarLOfumFYRvbimiQO7UTXMefBiHxa3b4HSF0MzngpwJGdDOrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4898
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

When testing the patch on a dual socket Zen3 system (3 x 64C/128T) we
noticed some regressions in some standard benchmark.

tl;dr

o Hackbench shows noticeable regression in most cases. Looking at schedstat
  data, we see there is an increased number of affine wakeup and an increase
  in the average wait time. As the LLC size on the Zen3 machine is only
  16 CPUs, there is good chance the LLC was overloaded and it required
  intervention from load balancer to distribute tasks optimally.

o There is a regression in Stream which is cause by piling up of more than
  one Stream thread on the same LLC. This happens as a result of migration
  in the wakeup path where the logic goes for an affine wakeup if the
  waker is short lived task even if sync flag is not set and the previous
  CPU might be idle.

I'll inline the results are detailed observation below:

On 9/15/2022 10:24 PM, Chen Yu wrote:
> [Background]
> At LPC 2022 Real-time and Scheduling Micro Conference we presented
> the cross CPU wakeup issue. This patch is a text version of the
> talk, and hopefully we can clarify the problem and appreciate for any
> feedback.
> 
> [re-send due to the previous one did not reach LKML, sorry
>  for any inconvenience.]
> 
> [Problem Statement]
> For a workload that is doing frequent context switches, the throughput
> scales well until the number of instances reaches a peak point. After
> that peak point, the throughput drops significantly if the number of
> instances continues to increase.
> 
> The will-it-scale context_switch1 test case exposes the issue. The
> test platform has 112 CPUs per LLC domain. The will-it-scale launches
> 1, 8, 16 ... 112 instances respectively. Each instance is composed
> of 2 tasks, and each pair of tasks would do ping-pong scheduling via
> pipe_read() and pipe_write(). No task is bound to any CPU.
> We found that, once the number of instances is higher than
> 56(112 tasks in total, every CPU has 1 task), the throughput
> drops accordingly if the instance number continues to increase:
> 
>           ^
> throughput|
>           |                 X
>           |               X   X X
>           |             X         X X
>           |           X               X
>           |         X                   X
>           |       X
>           |     X
>           |   X
>           | X
>           |
>           +-----------------.------------------->
>                             56
>                                  number of instances
> 
> [Symptom analysis]
> Both perf profile and lockstat have shown that, the bottleneck
> is the runqueue spinlock. Take perf profile for example:
> 
> nr_instance          rq lock percentage
> 1                    1.22%
> 8                    1.17%
> 16                   1.20%
> 24                   1.22%
> 32                   1.46%
> 40                   1.61%
> 48                   1.63%
> 56                   1.65%
> --------------------------
> 64                   3.77%      |
> 72                   5.90%      | increase
> 80                   7.95%      |
> 88                   9.98%      v
> 96                   11.81%
> 104                  13.54%
> 112                  15.13%
> 
> And the rq lock bottleneck is composed of two paths(perf profile):
> 
> (path1):
> raw_spin_rq_lock_nested.constprop.0;
> try_to_wake_up;
> default_wake_function;
> autoremove_wake_function;
> __wake_up_common;
> __wake_up_common_lock;
> __wake_up_sync_key;
> pipe_write;
> new_sync_write;
> vfs_write;
> ksys_write;
> __x64_sys_write;
> do_syscall_64;
> entry_SYSCALL_64_after_hwframe;write
> 
> (path2):
> raw_spin_rq_lock_nested.constprop.0;
> __sched_text_start;
> schedule_idle;
> do_idle;
> cpu_startup_entry;
> start_secondary;
> secondary_startup_64_no_verify
> 
> The idle percentage is around 30% when there are 112 instances:
> %Cpu0  :  2.7 us, 66.7 sy,  0.0 ni, 30.7 id
> 
> As a comparison, if we set CPU affinity to these workloads,
> which stops them from migrating among CPUs, the idle percentage
> drops to nearly 0%, and the throughput increases by about 300%.
> This indicates that there is room for optimization.
> 
> A possible scenario to describe the lock contention:
> task A tries to wakeup task B on CPU1, then task A grabs the
> runqueue lock of CPU1. If CPU1 is about to quit idle, it needs
> to grab its own lock which has been taken by someone else. Then
> CPU1 takes more time to quit which hurts the performance.
> 
> TTWU_QUEUE could mitigate the cross CPU runqueue lock contention.
> Since commit f3dd3f674555 ("sched: Remove the limitation of WF_ON_CPU
> on wakelist if wakee cpu is idle"), TTWU_QUEUE offloads the work from
> the waker and leverages the idle CPU to queue the wakee. However, a long
> idle duration is still observed. The idle task spends quite some time
> on sched_ttwu_pending() before it switches out. This long idle
> duration would mislead SIS_UTIL, then SIS_UTIL suggests the waker scan
> for more CPUs. The time spent searching for an idle CPU would make
> wakee waiting for more time, which in turn leads to more idle time.
> The NEWLY_IDLE balance fails to pull tasks to the idle CPU, which
> might be caused by no runnable wakee being found.
> 
> [Proposal]
> If a system is busy, and if the workloads are doing frequent context
> switches, it might not be a good idea to spread the wakee on different
> CPUs. Instead, consider the task running time and enhance wake affine
> might be applicable.
> 
> This idea has been suggested by Rik at LPC 2019 when discussing
> the latency nice. He asked the following question: if P1 is a small-time
> slice task on CPU, can we put the waking task P2 on the CPU and wait for
> P1 to release the CPU, without wasting time to search for an idle CPU?
> At LPC 2021 Vincent Guittot has proposed:
> 1. If the wakee is a long-running task, should we skip the short idle CPU?
> 2. If the wakee is a short-running task, can we put it onto a lightly loaded
>    local CPU?
> 
> Current proposal is a variant of 2:
> If the target CPU is running a short-time slice task, and the wakee
> is also a short-time slice task, the target CPU could be chosen as the
> candidate when the system is busy.
> 
> The definition of a short-time slice task is: The average running time
> of the task during each run is no more than sysctl_sched_min_granularity.
> If a task switches in and then voluntarily relinquishes the CPU
> quickly, it is regarded as a short-running task. Choosing
> sysctl_sched_min_granularity because it is the minimal slice if there
> are too many runnable tasks.
> 
> Reuse the nr_idle_scan of SIS_UTIL to decide if the system is busy.
> If yes, then a compromised "idle" CPU might be acceptable.
> 
> The reason is that, if the waker is a short running task, it might 
> relinquish the CPU soon, the wakee has the chance to be scheduled.
> On the other hand, if the wakee is also a short-running task, the
> impact it brings to the target CPU is small. If the system is
> already busy, maybe we could lower the bar to find an idle CPU. 
> The effect is, the wake affine is enhanced. 
> 
> [Benchmark results]
> The baseline is 6.0-rc4.
> 
> The throughput of will-it-scale.context_switch1 has been increased by
> 331.13% with this patch applied.
> 
> netperf
> =======
> case            	load    	baseline(std%)	compare%( std%)
> TCP_RR          	28 threads	 1.00 (  0.57)	 +0.29 (  0.59)
> TCP_RR          	56 threads	 1.00 (  0.49)	 +0.43 (  0.43)
> TCP_RR          	84 threads	 1.00 (  0.34)	 +0.24 (  0.34)
> TCP_RR          	112 threads	 1.00 (  0.26)	 +1.57 (  0.20)
> TCP_RR          	140 threads	 1.00 (  0.20)	+178.05 (  8.83)
> TCP_RR          	168 threads	 1.00 ( 10.14)	 +0.87 ( 10.03)
> TCP_RR          	196 threads	 1.00 ( 13.51)	 +0.90 ( 11.84)
> TCP_RR          	224 threads	 1.00 (  7.12)	 +0.66 (  8.28)
> UDP_RR          	28 threads	 1.00 (  0.96)	 -0.10 (  0.97)
> UDP_RR          	56 threads	 1.00 ( 10.93)	 +0.24 (  0.82)
> UDP_RR          	84 threads	 1.00 (  8.99)	 +0.40 (  0.71)
> UDP_RR          	112 threads	 1.00 (  0.15)	 +0.72 (  7.77)
> UDP_RR          	140 threads	 1.00 ( 11.11)	+135.81 ( 13.86)
> UDP_RR          	168 threads	 1.00 ( 12.58)	+147.63 ( 12.72)
> UDP_RR          	196 threads	 1.00 ( 19.47)	 -0.34 ( 16.14)
> UDP_RR          	224 threads	 1.00 ( 12.88)	 -0.35 ( 12.73)
> 
> hackbench
> =========
> case            	load    	baseline(std%)	compare%( std%)
> process-pipe    	1 group 	 1.00 (  1.02)	 +0.14 (  0.62)
> process-pipe    	2 groups 	 1.00 (  0.73)	 +0.29 (  0.51)
> process-pipe    	4 groups 	 1.00 (  0.16)	 +0.24 (  0.31)
> process-pipe    	8 groups 	 1.00 (  0.06)	+11.56 (  0.11)
> process-sockets 	1 group 	 1.00 (  1.59)	 +0.06 (  0.77)
> process-sockets 	2 groups 	 1.00 (  1.13)	 -1.86 (  1.31)
> process-sockets 	4 groups 	 1.00 (  0.14)	 +1.76 (  0.29)
> process-sockets 	8 groups 	 1.00 (  0.27)	 +2.73 (  0.10)
> threads-pipe    	1 group 	 1.00 (  0.43)	 +0.83 (  2.20)
> threads-pipe    	2 groups 	 1.00 (  0.52)	 +1.03 (  0.55)
> threads-pipe    	4 groups 	 1.00 (  0.44)	 -0.08 (  0.31)
> threads-pipe    	8 groups 	 1.00 (  0.04)	+11.86 (  0.05)
> threads-sockets 	1 groups 	 1.00 (  1.89)	 +3.51 (  0.57)
> threads-sockets 	2 groups 	 1.00 (  0.04)	 -1.12 (  0.69)
> threads-sockets 	4 groups 	 1.00 (  0.14)	 +1.77 (  0.18)
> threads-sockets 	8 groups 	 1.00 (  0.03)	 +2.75 (  0.03)
> 
> tbench
> ======
> case            	load    	baseline(std%)	compare%( std%)
> loopback        	28 threads	 1.00 (  0.08)	 +0.51 (  0.25)
> loopback        	56 threads	 1.00 (  0.15)	 -0.89 (  0.16)
> loopback        	84 threads	 1.00 (  0.03)	 +0.35 (  0.07)
> loopback        	112 threads	 1.00 (  0.06)	 +2.84 (  0.01)
> loopback        	140 threads	 1.00 (  0.07)	 +0.69 (  0.11)
> loopback        	168 threads	 1.00 (  0.09)	 +0.14 (  0.18)
> loopback        	196 threads	 1.00 (  0.04)	 -0.18 (  0.20)
> loopback        	224 threads	 1.00 (  0.25)	 -0.37 (  0.03)
> 
> Other benchmarks are under testing.

Discussed below are the results from running standard benchmarks on
a dual socket Zen3 (2 x 64C/128T) machine configured in different
NPS modes.

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

Benchmark Results:

Kernel versions:
- tip:       5.19.0 tip sched/core
- shortrun:  5.19.0 tip sched/core + this patch

When we started testing, the tip was at:
commit 7e9518baed4c ("sched/fair: Move call to list_last_entry() in detach_tasks")

~~~~~~~~~~~~~
~ hackbench ~
~~~~~~~~~~~~~

NPS1

Test:			tip			shortrun
 1-groups:	   4.23 (0.00 pct)	   4.24 (-0.23 pct)
 2-groups:	   4.93 (0.00 pct)	   5.68 (-15.21 pct)
 4-groups:	   5.32 (0.00 pct)	   6.21 (-16.72 pct)
 8-groups:	   5.46 (0.00 pct)	   6.49 (-18.86 pct)
16-groups:	   7.31 (0.00 pct)	   7.78 (-6.42 pct)

NPS2

Test:			tip			shortrun
 1-groups:	   4.19 (0.00 pct)	   4.19 (0.00 pct)
 2-groups:	   4.77 (0.00 pct)	   5.43 (-13.83 pct)
 4-groups:	   5.15 (0.00 pct)	   6.20 (-20.38 pct)
 8-groups:	   5.47 (0.00 pct)	   6.54 (-19.56 pct)
16-groups:	   6.63 (0.00 pct)	   7.28 (-9.80 pct)

NPS4

Test:			tip			shortrun
 1-groups:	   4.23 (0.00 pct)	   4.39 (-3.78 pct)
 2-groups:	   4.78 (0.00 pct)	   5.48 (-14.64 pct)
 4-groups:	   5.17 (0.00 pct)	   6.14 (-18.76 pct)
 8-groups:	   5.63 (0.00 pct)	   6.51 (-15.63 pct)
16-groups:	   7.88 (0.00 pct)	   7.03 (10.78 pct)

~~~~~~~~~~~~
~ schbench ~
~~~~~~~~~~~~

NPS1

#workers:       tip			shortrun
  1:	  22.00 (0.00 pct)	  36.00 (-63.63 pct)
  2:	  34.00 (0.00 pct)	  38.00 (-11.76 pct)
  4:	  37.00 (0.00 pct)	  36.00 (2.70 pct)
  8:	  55.00 (0.00 pct)	  51.00 (7.27 pct)
 16:	  69.00 (0.00 pct)	  68.00 (1.44 pct)
 32:	 113.00 (0.00 pct)	 116.00 (-2.65 pct)
 64:	 219.00 (0.00 pct)	 232.00 (-5.93 pct)
128:	 506.00 (0.00 pct)	 1019.00 (-101.38 pct)
256:	 45440.00 (0.00 pct)	 44864.00 (1.26 pct)
512:	 76672.00 (0.00 pct)	 73600.00 (4.00 pct)

NPS2

#workers:	tip			shortrun
  1:	  31.00 (0.00 pct)	  36.00 (-16.12 pct)
  2:	  36.00 (0.00 pct)	  36.00 (0.00 pct)
  4:	  45.00 (0.00 pct)	  39.00 (13.33 pct)
  8:	  47.00 (0.00 pct)	  48.00 (-2.12 pct)
 16:	  66.00 (0.00 pct)	  71.00 (-7.57 pct)
 32:	 114.00 (0.00 pct)	 123.00 (-7.89 pct)
 64:	 215.00 (0.00 pct)	 248.00 (-15.34 pct)
128:	 495.00 (0.00 pct)	 531.00 (-7.27 pct)
256:	 48576.00 (0.00 pct)	 47552.00 (2.10 pct)
512:	 79232.00 (0.00 pct)	 74624.00 (5.81 pct)

NPS4

#workers:	tip			shortrun
  1:	  30.00 (0.00 pct)	  36.00 (-20.00 pct)
  2:	  34.00 (0.00 pct)	  38.00 (-11.76 pct)
  4:	  41.00 (0.00 pct)	  44.00 (-7.31 pct)
  8:	  60.00 (0.00 pct)	  53.00 (11.66 pct)
 16:	  68.00 (0.00 pct)	  73.00 (-7.35 pct)
 32:	 116.00 (0.00 pct)	 125.00 (-7.75 pct)
 64:	 224.00 (0.00 pct)	 248.00 (-10.71 pct)
128:	 495.00 (0.00 pct)	 569.00 (-14.94 pct)
256:	 45888.00 (0.00 pct)	 38720.00 (15.62 pct)
512:	 78464.00 (0.00 pct)	 73600.00 (6.19 pct)


~~~~~~~~~~
~ tbench ~
~~~~~~~~~~

NPS1

Clients:	tip			shortrun
    1	 550.66 (0.00 pct)	 546.56 (-0.74 pct)
    2	 1009.69 (0.00 pct)	 1010.01 (0.03 pct)
    4	 1795.32 (0.00 pct)	 1782.71 (-0.70 pct)
    8	 2971.16 (0.00 pct)	 3035.58 (2.16 pct)
   16	 4627.98 (0.00 pct)	 4816.82 (4.08 pct)
   32	 8065.15 (0.00 pct)	 9269.52 (14.93 pct)
   64	 14994.32 (0.00 pct)	 14704.38 (-1.93 pct)
  128	 5175.73 (0.00 pct)	 5174.77 (-0.01 pct)
  256	 48763.57 (0.00 pct)	 49649.67 (1.81 pct)
  512	 43780.78 (0.00 pct)	 44717.04 (2.13 pct)
 1024	 40341.84 (0.00 pct)	 42078.99 (4.30 pct)

NPS2

Clients:	tip			shortrun
    1	 551.06 (0.00 pct)	 549.17 (-0.34 pct)
    2	 1000.76 (0.00 pct)	 993.75 (-0.70 pct)
    4	 1737.02 (0.00 pct)	 1773.33 (2.09 pct)
    8	 2992.31 (0.00 pct)	 2971.05 (-0.71 pct)
   16	 4579.29 (0.00 pct)	 4470.71 (-2.37 pct)
   32	 9120.73 (0.00 pct)	 8080.89 (-11.40 pct)
   64	 14918.58 (0.00 pct)	 14395.57 (-3.50 pct)
  128	 20830.61 (0.00 pct)	 20579.09 (-1.20 pct)
  256	 47708.18 (0.00 pct)	 47416.37 (-0.61 pct)
  512	 43721.79 (0.00 pct)	 43754.83 (0.07 pct)
 1024	 40920.49 (0.00 pct)	 40701.90 (-0.53 pct)

NPS4

Clients:	tip			shortrun
    1	 549.22 (0.00 pct)	 548.36 (-0.15 pct)
    2	 1000.08 (0.00 pct)	 1037.74 (3.76 pct)
    4	 1794.78 (0.00 pct)	 1802.11 (0.40 pct)
    8	 3008.50 (0.00 pct)	 2989.22 (-0.64 pct)
   16	 4804.71 (0.00 pct)	 4706.51 (-2.04 pct)
   32	 9156.57 (0.00 pct)	 8253.84 (-9.85 pct)
   64	 14901.45 (0.00 pct)	 15049.51 (0.99 pct)
  128	 20771.20 (0.00 pct)	 13229.50 (-36.30 pct)
  256	 47033.88 (0.00 pct)	 46737.17 (-0.63 pct)
  512	 43429.01 (0.00 pct)	 43246.64 (-0.41 pct)
 1024	 39271.27 (0.00 pct)	 42194.75 (7.44 pct)


~~~~~~~~~~
~ stream ~
~~~~~~~~~~

NPS1

10 Runs:

Test:	        tip			shortrun
 Copy:	 336311.52 (0.00 pct)	 330116.75 (-1.84 pct)
Scale:	 212955.82 (0.00 pct)	 215330.30 (1.11 pct)
  Add:	 251518.23 (0.00 pct)	 250926.53 (-0.23 pct)
Triad:	 262077.88 (0.00 pct)	 259618.70 (-0.93 pct)

100 Runs:

Test:		tip			shortrun
 Copy:	 339533.83 (0.00 pct)	 323452.74 (-4.73 pct)
Scale:	 194736.72 (0.00 pct)	 215789.55 (10.81 pct)
  Add:	 218294.54 (0.00 pct)	 244916.33 (12.19 pct)
Triad:	 262371.40 (0.00 pct)	 252997.84 (-3.57 pct)

NPS2

10 Runs:

Test:		tip			shortrun
 Copy:	 335277.15 (0.00 pct)	 305516.57 (-8.87 pct)
Scale:	 220990.24 (0.00 pct)	 207061.22 (-6.30 pct)
  Add:	 264156.13 (0.00 pct)	 243368.49 (-7.86 pct)
Triad:	 268707.53 (0.00 pct)	 223486.30 (-16.82 pct)

100 Runs:

Test:		tip			shortrun
 Copy:	 334913.73 (0.00 pct)	 319677.81 (-4.54 pct)
Scale:	 230522.47 (0.00 pct)	 222757.62 (-3.36 pct)
  Add:	 264567.28 (0.00 pct)	 254883.62 (-3.66 pct)
Triad:	 272974.23 (0.00 pct)	 260561.08 (-4.54 pct)

NPS4

10 Runs:

Test:		tip			shortrun
 Copy:	 356452.47 (0.00 pct)	 255911.77 (-28.20 pct)
Scale:	 242986.42 (0.00 pct)	 171587.28 (-29.38 pct)
  Add:	 268512.09 (0.00 pct)	 188244.75 (-29.89 pct)
Triad:	 281622.43 (0.00 pct)	 193271.97 (-31.37 pct)

100 Runs:

Test:		tip			shortrun
 Copy:	 367384.81 (0.00 pct)	 273101.20 (-25.66 pct)
Scale:	 254289.04 (0.00 pct)	 189986.88 (-25.28 pct)
  Add:	 273683.33 (0.00 pct)	 206384.96 (-24.58 pct)
Triad:	 285696.90 (0.00 pct)	 217214.10 (-23.97 pct)

~~~~~~~~~~~~~~~~~~~~~~~~~~
~ Notes and Observations ~
~~~~~~~~~~~~~~~~~~~~~~~~~~

o Schedstat data for Hackbench with 2 groups in NPS1 mode:

        ---------------------------------------------------------------------------------------------------
        cpu:  all_cpus (avg) vs cpu:  all_cpus (avg)
        ---------------------------------------------------------------------------------------------------
        kernel:                                                    :           tip      shortrun
        sched_yield count                                          :             0,            0
        Legacy counter can be ignored                              :             0,            0
        schedule called                                            :         53305,        40615  | -23.81|
        schedule left the processor idle                           :         22406,        16919  | -24.49|
        try_to_wake_up was called                                  :         30822,        23625  | -23.35|
        try_to_wake_up was called to wake up the local cpu         :           984,         2583  | 162.50|
        total runtime by tasks on this processor (in jiffies)      :     596998654,    481267347  | -19.39| *
        total waittime by tasks on this processor (in jiffies)     :     514142630,    766745576  |  49.13| * Longer wait time
        total timeslices run on this cpu                           :         30893,        23691  | -23.31| *
        ---------------------------------------------------------------------------------------------------


        < --------------------------------------  Wakeup info:  -------------------------------------- >
        kernel:                                                 :           tip      shortrun
        Wakeups on same         SMT cpus = all_cpus (avg)       :          1470,         1301  | -11.50|
        Wakeups on same         MC cpus = all_cpus (avg)        :         22913,        18606  | -18.80|
        Wakeups on same         DIE cpus = all_cpus (avg)       :          3634,          693  | -80.93|
        Wakeups on same         NUMA cpus = all_cpus (avg)      :          1819,          440  | -75.81|
        Affine wakeups on same  SMT cpus = all_cpus (avg)       :          1025,         1421  |  38.63| * More affine wakeups on possibly
        Affine wakeups on same  MC cpus = all_cpus (avg)        :         14455,        17514  |  21.16| * busy runqueue leading to longer
        Affine wakeups on same  DIE cpus = all_cpus (avg)       :          2828,          701  | -75.21|   wait time
        Affine wakeups on same  NUMA cpus = all_cpus (avg)      :          1194,          456  | -61.81|
        ------------------------------------------------------------------------------------------------

	We observe a larger wait time which which the patch which points
        to the fact that the tasks are piling on the run queue. I believe
	Tim's suggestion will help here where we can avoid a pileup as a
	result of waker task being a short run task.

o Tracepoint data for Stream for 100 runs in NPS4

	Following tracepoints were enabled for Stream threads:
	  - sched_wakeup_new: To observe initial placement
	  - sched_waking: To check if migration is in wakeup context or lb contxt
	  - sched_wakeup: To check if migration is in wakeup context or lb contxt
	  - sched_migrate_task: To observe task movements

	--> tip:

   run_stream.sh-3724    [057] d..2.   450.593407: sched_wakeup_new: comm=run_stream.sh pid=3733 prio=120 target_cpu=050 *LLC: 6
          <idle>-0       [182] d.s4.   450.594375: sched_waking: comm=stream pid=3733 prio=120 target_cpu=050
          <idle>-0       [050] dNh2.   450.594381: sched_wakeup: comm=stream pid=3733 prio=120 target_cpu=050
          <idle>-0       [182] d.s4.   450.594657: sched_waking: comm=stream pid=3733 prio=120 target_cpu=050
          <idle>-0       [050] dNh2.   450.594661: sched_wakeup: comm=stream pid=3733 prio=120 target_cpu=050
          stream-3733    [050] d..2.   450.594893: sched_wakeup_new: comm=stream pid=3735 prio=120 target_cpu=057 *LLC: 7
          stream-3733    [050] d..2.   450.594955: sched_wakeup_new: comm=stream pid=3736 prio=120 target_cpu=078 *LLC: 9
          stream-3733    [050] d..2.   450.594988: sched_wakeup_new: comm=stream pid=3737 prio=120 target_cpu=045 *LLC: 5
          stream-3733    [050] d..2.   450.595016: sched_wakeup_new: comm=stream pid=3738 prio=120 target_cpu=008 *LLC: 1
          stream-3733    [050] d..2.   450.595029: sched_waking: comm=stream pid=3737 prio=120 target_cpu=045
          <idle>-0       [045] dNh2.   450.595037: sched_wakeup: comm=stream pid=3737 prio=120 target_cpu=045
          stream-3737    [045] d..2.   450.595072: sched_waking: comm=stream pid=3733 prio=120 target_cpu=050
          <idle>-0       [050] dNh2.   450.595078: sched_wakeup: comm=stream pid=3733 prio=120 target_cpu=050
          stream-3738    [008] d..2.   450.595102: sched_waking: comm=stream pid=3733 prio=120 target_cpu=050
          <idle>-0       [050] dNh2.   450.595111: sched_wakeup: comm=stream pid=3733 prio=120 target_cpu=050
          stream-3733    [050] d..2.   450.595151: sched_wakeup_new: comm=stream pid=3739 prio=120 target_cpu=097 *LLC: 12
          stream-3733    [050] d..2.   450.595181: sched_wakeup_new: comm=stream pid=3740 prio=120 target_cpu=194 *LLC: 8
          stream-3733    [050] d..2.   450.595221: sched_wakeup_new: comm=stream pid=3741 prio=120 target_cpu=080 *LLC: 10
          stream-3733    [050] d..2.   450.595249: sched_wakeup_new: comm=stream pid=3742 prio=120 target_cpu=144 *LLC: 2
          stream-3733    [050] d..2.   450.595285: sched_wakeup_new: comm=stream pid=3743 prio=120 target_cpu=239 *LLC: 13
          stream-3733    [050] d..2.   450.595320: sched_wakeup_new: comm=stream pid=3744 prio=120 target_cpu=130 *LLC: 0
          stream-3733    [050] d..2.   450.595364: sched_wakeup_new: comm=stream pid=3745 prio=120 target_cpu=113 *LLC: 14
          stream-3744    [130] d..2.   450.595407: sched_waking: comm=stream pid=3733 prio=120 target_cpu=050
          <idle>-0       [050] dNh2.   450.595416: sched_wakeup: comm=stream pid=3733 prio=120 target_cpu=050
          stream-3733    [050] d..2.   450.595423: sched_waking: comm=stream pid=3745 prio=120 target_cpu=113
          <idle>-0       [113] dNh2.   450.595433: sched_wakeup: comm=stream pid=3745 prio=120 target_cpu=113
          stream-3733    [050] d..2.   450.595452: sched_wakeup_new: comm=stream pid=3746 prio=120 target_cpu=160 *LLC: 4
          stream-3733    [050] d..2.   450.595486: sched_wakeup_new: comm=stream pid=3747 prio=120 target_cpu=255 *LLC: 15
          stream-3733    [050] d..2.   450.595513: sched_wakeup_new: comm=stream pid=3748 prio=120 target_cpu=159 *LLC: 3
          stream-3746    [160] d..2.   450.595533: sched_waking: comm=stream pid=3733 prio=120 target_cpu=050
          <idle>-0       [050] dNh2.   450.595542: sched_wakeup: comm=stream pid=3733 prio=120 target_cpu=050
          stream-3747    [255] d..2.   450.595562: sched_waking: comm=stream pid=3733 prio=120 target_cpu=050
          <idle>-0       [050] dNh2.   450.595573: sched_wakeup: comm=stream pid=3733 prio=120 target_cpu=050
          stream-3733    [050] d..2.   450.595614: sched_wakeup_new: comm=stream pid=3749 prio=120 target_cpu=222 *LLC: 11
          stream-3740    [194] d..2.   451.140510: sched_waking: comm=stream pid=3747 prio=120 target_cpu=255
          <idle>-0       [255] dNh2.   451.140523: sched_wakeup: comm=stream pid=3747 prio=120 target_cpu=255
          stream-3733    [050] d..2.   451.617257: sched_waking: comm=stream pid=3740 prio=120 target_cpu=194
          stream-3733    [050] d..2.   451.617267: sched_waking: comm=stream pid=3746 prio=120 target_cpu=160
          stream-3733    [050] d..2.   451.617269: sched_waking: comm=stream pid=3739 prio=120 target_cpu=097
          stream-3733    [050] d..2.   451.617272: sched_waking: comm=stream pid=3742 prio=120 target_cpu=144
          stream-3733    [050] d..2.   451.617275: sched_waking: comm=stream pid=3749 prio=120 target_cpu=222
          ... (No migrations observed)

          In most cases, each LLCs is running only 1 stream thread leading to optimal performance.

	--> with patch:

   run_stream.sh-4383    [070] d..2.  1237.764236: sched_wakeup_new: comm=run_stream.sh pid=4392 prio=120 target_cpu=206 *LLC: 9
          stream-4392    [206] d..2.  1237.765121: sched_wakeup_new: comm=stream pid=4394 prio=120 target_cpu=070 *LLC: 8
          stream-4392    [206] d..2.  1237.765171: sched_wakeup_new: comm=stream pid=4395 prio=120 target_cpu=169 *LLC: 5
          stream-4392    [206] d..2.  1237.765204: sched_wakeup_new: comm=stream pid=4396 prio=120 target_cpu=111 *LLC: 13
          stream-4392    [206] d..2.  1237.765243: sched_wakeup_new: comm=stream pid=4397 prio=120 target_cpu=130 *LLC: 0
          stream-4392    [206] d..2.  1237.765249: sched_waking: comm=stream pid=4396 prio=120 target_cpu=111
          <idle>-0       [111] dNh2.  1237.765260: sched_wakeup: comm=stream pid=4396 prio=120 target_cpu=111
          stream-4392    [206] d..2.  1237.765281: sched_wakeup_new: comm=stream pid=4398 prio=120 target_cpu=182 *LLC: 6
          stream-4392    [206] d..2.  1237.765318: sched_wakeup_new: comm=stream pid=4399 prio=120 target_cpu=060 *LLC: 7
          stream-4392    [206] d..2.  1237.765368: sched_wakeup_new: comm=stream pid=4400 prio=120 target_cpu=124 *LLC: 15
          stream-4392    [206] d..2.  1237.765408: sched_wakeup_new: comm=stream pid=4401 prio=120 target_cpu=031 *LLC: 3
          stream-4392    [206] d..2.  1237.765439: sched_wakeup_new: comm=stream pid=4402 prio=120 target_cpu=095 *LLC: 11
          stream-4392    [206] d..2.  1237.765475: sched_wakeup_new: comm=stream pid=4403 prio=120 target_cpu=015 *LLC: 1
          stream-4401    [031] d..2.  1237.765497: sched_waking: comm=stream pid=4392 prio=120 target_cpu=206
          stream-4401    [031] d..2.  1237.765506: sched_migrate_task: comm=stream pid=4392 prio=120 orig_cpu=206 dest_cpu=152 *LLC: 9 -> 3
          <idle>-0       [152] dNh2.  1237.765540: sched_wakeup: comm=stream pid=4392 prio=120 target_cpu=152
          stream-4403    [015] d..2.  1237.765562: sched_waking: comm=stream pid=4392 prio=120 target_cpu=152
          stream-4403    [015] d..2.  1237.765570: sched_migrate_task: comm=stream pid=4392 prio=120 orig_cpu=152 dest_cpu=136 *LLC: 3 -> 1
          <idle>-0       [136] dNh2.  1237.765602: sched_wakeup: comm=stream pid=4392 prio=120 target_cpu=136
          stream-4392    [136] d..2.  1237.765799: sched_wakeup_new: comm=stream pid=4404 prio=120 target_cpu=097 *LLC: 12
          stream-4392    [136] d..2.  1237.765893: sched_wakeup_new: comm=stream pid=4405 prio=120 target_cpu=084 *LLC: 10
          stream-4392    [136] d..2.  1237.765957: sched_wakeup_new: comm=stream pid=4406 prio=120 target_cpu=119 *LLC: 14
          stream-4392    [136] d..2.  1237.766018: sched_wakeup_new: comm=stream pid=4407 prio=120 target_cpu=038 *LLC: 4
          stream-4406    [119] d..2.  1237.766044: sched_waking: comm=stream pid=4392 prio=120 target_cpu=136
          stream-4406    [119] d..2.  1237.766050: sched_migrate_task: comm=stream pid=4392 prio=120 orig_cpu=136 dest_cpu=240 *LLC: 1 -> 14
          <idle>-0       [240] dNh2.  1237.766154: sched_wakeup: comm=stream pid=4392 prio=120 target_cpu=240
          stream-4392    [240] d..2.  1237.766361: sched_wakeup_new: comm=stream pid=4408 prio=120 target_cpu=023 *LLC: 2
          stream-4399    [060] d..2.  1238.300605: sched_waking: comm=stream pid=4406 prio=120 target_cpu=119 *LLC: 14 <--- Two stream threads are
          stream-4399    [060] d..2.  1238.300611: sched_waking: comm=stream pid=4392 prio=120 target_cpu=240 *LLC: 14 <--- on the same LLC leading to
          <idle>-0       [119] dNh2.  1238.300620: sched_wakeup: comm=stream pid=4406 prio=120 target_cpu=119 *LLC: 14      cache contention, degrading
          <idle>-0       [240] dNh2.  1238.300621: sched_wakeup: comm=stream pid=4392 prio=120 target_cpu=240 *LLC: 14      the Stream throughput.
          ... (No more migrations observed)

          After all the wakeups and migrations, LLC 14 contains two stream threads (pid: 4392 and 4406)
          All the migrations happen between the events sched_waking and sched_wakeup showing the migrations
          happens during a wakeup and not as a resutl of load balancing.

> 
> This patch is more about enhancing the wake affine, rather than improving
> the SIS efficiency, so Mel's SIS statistic patch was not deployed for now.
> 
> [Limitations]
> When the number of CPUs suggested by SIS_UTIL is lower than 60% of the LLC
> CPUs, the LLC domain is regarded as relatively busy. However, the 60% is
> somewhat hacky, because it indicates that the util_avg% is around 50%,
> a half busy LLC. I don't have other lightweight/accurate method in mind to
> check if the LLC domain is busy or not.
> 
> [Misc]
> At LPC we received useful suggestions. The first one is that we should look at
> the time from the task is woken up, to the time the task goes back to sleep.
> I assume this is aligned with what is proposed here - we consider the average
> running time, rather than the total running time. The second one is that we
> should consider the long-running task. And this is under investigation.
> 
> Besides, Prateek has mentioned that the SIS_UTIL is unable to deal with
> burst workload.  Because there is a delay to reflect the instantaneous
> utilization and SIS_UTIL expects the workload to be stable. If the system
> is idle most of the time, but suddenly the workloads burst, the SIS_UTIL
> overscans. The current patch might mitigate this symptom somehow, as burst
> workload is usually regarded as a short-running task.
> 
> Suggested-by: Tim Chen <tim.c.chen@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/sched/fair.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 914096c5b1ae..7519ab5b911c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6020,6 +6020,19 @@ static int wake_wide(struct task_struct *p)
>  	return 1;
>  }
>  
> +/*
> + * If a task switches in and then voluntarily relinquishes the
> + * CPU quickly, it is regarded as a short running task.
> + * sysctl_sched_min_granularity is chosen as the threshold,
> + * as this value is the minimal slice if there are too many
> + * runnable tasks, see __sched_period().
> + */
> +static int is_short_task(struct task_struct *p)
> +{
> +	return (p->se.sum_exec_runtime <=
> +		(p->nvcsw * sysctl_sched_min_granularity));
> +}
> +
>  /*
>   * The purpose of wake_affine() is to quickly determine on which CPU we can run
>   * soonest. For the purpose of speed we only consider the waking and previous
> @@ -6050,7 +6063,8 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>  	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
>  		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
>  
> -	if (sync && cpu_rq(this_cpu)->nr_running == 1)
> +	if ((sync && cpu_rq(this_cpu)->nr_running == 1) ||
> +	    is_short_task(cpu_curr(this_cpu)))

This change seems to optimize for affine wakeup which benefits
tasks with producer-consumer pattern but is not ideal for Stream.
Currently the logic ends will do an affine wakeup even if sync
flag is not set:

          stream-4135    [029] d..2.   353.580953: sched_waking: comm=stream pid=4129 prio=120 target_cpu=082
          stream-4135    [029] d..2.   353.580957: select_task_rq_fair: wake_affine_idle: Select this_cpu: sync(0) rq->nr_running(1) is_short_task(1)
          stream-4135    [029] d..2.   353.580960: sched_migrate_task: comm=stream pid=4129 prio=120 orig_cpu=82 dest_cpu=30
          <idle>-0       [030] dNh2.   353.580993: sched_wakeup: comm=stream pid=4129 prio=120 target_cpu=030

I believe a consideration should be made for the sync flag when
going for an affine wakeup. Also the check for short running could
be at the end after checking if prev_cpu is an available_idle_cpu.

>  		return this_cpu;
>  
>  	if (available_idle_cpu(prev_cpu))
> @@ -6434,6 +6448,21 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  			/* overloaded LLC is unlikely to have idle cpu/core */
>  			if (nr == 1)
>  				return -1;
> +
> +			/*
> +			 * If nr is smaller than 60% of llc_weight, it
> +			 * indicates that the util_avg% is higher than 50%.
> +			 * This is calculated by SIS_UTIL in
> +			 * update_idle_cpu_scan(). The 50% util_avg indicates
> +			 * a half-busy LLC domain. System busier than this
> +			 * level could lower its bar to choose a compromised
> +			 * "idle" CPU. If the waker on target CPU is a short
> +			 * task and the wakee is also a short task, pick
> +			 * target directly.
> +			 */
> +			if (!has_idle_core && (5 * nr < 3 * sd->span_weight) &&
> +			    is_short_task(p) && is_short_task(cpu_curr(target)))
> +				return target;

Pileup seen in hackbench could also be a result of an early
bailout here for smaller LLCs but I don't have any data to
substantiate that claim currently.

>  		}
>  	}
>  
Please let me know if you need any more data from the test
system for any of the benchmarks covered or if you would like
me to run any other benchmark on the test system.
--
Thanks and Regards,
Prateek
