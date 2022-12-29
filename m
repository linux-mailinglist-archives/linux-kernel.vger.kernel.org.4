Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0D36589E5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiL2HRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiL2HRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:17:31 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9DA24F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 23:17:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiyYBajlu84wIzWplzcwckRmOnr31wgEwlgRWrdOo0h36m2CDQcyUcUlmxV94SABssHG0EElo7EBuWdgIdFcDVEpP8r6ndugVPmfunL9tTAndmgtk1vt3eaSAUGGfd8pZelVrv/EzW2jFxNn3+n8+ET6TIcloj5uTwJmGfsgzp5KYS99QBVvim707935yo2HUp8fp01qhSt2d2Debr0GKo8AARkytdiggNicuu0L5KFUtBOzVyhQ4uT9t47w0qAUZleamBA/85yh6GExsAKNHCR0sxr096FErCCr68oRSk3M2PAHLBurk4DiHIORccyBmFi8fM+UfOS5PrTxUhBcag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZavRqJp9ZEEB9yFxW3KkxGmx6eZ5ILdoCNTVrhGYfg=;
 b=MmdsGfj1u0CU4q3eDEW917rmooMxKqD2IE9aOWwSDeMgxsWQZbuhLA0mfjGvo0G1SYoVssUh7dRgFcxwqF5myd4A2yMapPHdD8zoYd34gcuWaSOF+Jqm/pUwBTPjRXYW7pIGTNZXA1KeizwpJD3+dwZjYQBeWc7thwdJPg4iV6R9FBVwnGdG4q0GYCXdMWDOaOhmG8/EKgao72yOm7+A3j7iXJ/OdHwwLPNBv/NUTN6KrB/ToAot8y7aaJNskHylaJpmOz9HxoSwxF8vbjQPny+kFBtJtO8O9ix/Q1YGxWHdYZExJcdEhSW/QNGQIJGLMZyWQWrL8ZkTB6rxfu70wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZavRqJp9ZEEB9yFxW3KkxGmx6eZ5ILdoCNTVrhGYfg=;
 b=VqEyg9kEbyRsJwjoYi/ua81ddu72fMsCXFJy6ZcDnbY7zCA1GlhVTsrRrN3JCbtqi9fAruXYEvf6l7MD+mkne0LalTeztaJGoyyMBbUZ1GS4c1Jo8m0zP6U2aZx1tDoxXzogomCU9wK0rss+yMr+0R93vPbKe7+C8ZTzbMRqTOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Thu, 29 Dec
 2022 07:17:27 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d9a6:6f94:8e92:9e20]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d9a6:6f94:8e92:9e20%7]) with mapi id 15.20.5944.016; Thu, 29 Dec 2022
 07:17:26 +0000
Message-ID: <105eede3-2125-5a1e-836c-954fc67f575b@amd.com>
Date:   Thu, 29 Dec 2022 12:46:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH v4 0/2] sched/fair: Choose the CPU where short task is
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
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org
References: <cover.1671158588.git.yu.c.chen@intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <cover.1671158588.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::16) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: b5fc0f02-7d42-4fe8-885a-08dae96cbcc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eeL6aYTRC6rLSkhSBfzNDpEDckMF6k7nL9I/22jo+mfCI4LSTuogTKN48wtXWDijGdlRP88CnKgsF018aIdMsTMVbZL8XPu+0A5+8/hSZJqqDBZOMxeZ2wrzj+Nl7ocVnix7uXolIGibEgx4n164w9AXDyWBRLO1APoeFm1QejIhGM9/KSOqJv43THdv2+cTGVs4CFawqkmgnFiBcoVYsABIY6LBtbbDnBGY+uBSOvW4FhWzwSln4ylB98VfGUHQjdN3ejv7jolZuVkpWkcBbTRZPV7IDgPrFK25SOLO51oq4fjP4vKmM/RTjjpxaVjpUsRJTt7omuqmurTnuPNd8JnxUyrg31P3M21bRxPr88hpZhRN2xF5xiU5mg0PMAMIYaJ+QnpYPIvPqf1lIO/Opsj7/O+070FKpyVwLQasYgg8vEhl0JbmPDGYiQIeBbAbpZ5TZmOykEB9x3pmDZgbkYXdNDnOt6xlJykuIW2ZOwe5e76Myv1wWaB1gNS2Cxq4F/88SrXY5JUGTU/aZIdceMQiy5h3etmOcE+5uVccf+d2/FbrvQwIBafpe2PU3febBbe0/lN4t8jc0IiHVLHylYp8bT5E4eu2mQKcEhBQDLfDPw8tDVIGxvpyXO7oBJ+yWiiSGg9ox6Bopat5h3fRbOMuCAC1m6tOV4z3i2oEg5AH0LhVGkA/uZe67xEGY4Bl26hccs3/8Bu4IuzMhKUEUWbj58Ii09WRroLsqWmEdk3qpphC5dxd5bX1ADQKf1hWIhHrZ4wkhuoG6uU32jBawaQLBHE94VbzYr3dHiFDvZ3wdfOGOS+2lkoWRY1g5leJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199015)(54906003)(6666004)(110136005)(478600001)(6506007)(53546011)(31686004)(6486002)(31696002)(6512007)(966005)(26005)(36756003)(41300700001)(86362001)(186003)(38100700002)(2906002)(8936002)(4326008)(8676002)(30864003)(83380400001)(5660300002)(7416002)(66946007)(66556008)(2616005)(66476007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1YyU0R1WXFzOWlEYkJuMjlvL2tWdlFiVHJ6VHlWbFFHSCtoVk9zVWQ2Z0dI?=
 =?utf-8?B?UC93QWFYVUxSYTkraVdUWldUMGJ1UFM1Zmk0N1crVGVlUndIWVErVk9rNVVP?=
 =?utf-8?B?a28yRXIxVnZhOXYwblEyNys5L2U3ajRRbm1WSkRxMXY5MkFyelU4VlhUYXUr?=
 =?utf-8?B?bDFBQU1td1EyUGQycGlTWmMwbVdtYkdpeUFjU081dWptZHBYMjdmODlSV2NI?=
 =?utf-8?B?WksrUm85K1NaMVNjdENMSDRsM2p3TjF4ZHlweGpzc2lYV1FjWUxIeUFvT2Zn?=
 =?utf-8?B?UjlqUG9GTDdnOG5jb2pJQlVmUzIwNTlkWlZwRGxoeU9XWGQvS01ub2tkdlVM?=
 =?utf-8?B?dzIwR3ZmbGE5RXdZQnVtdUxNbkZhSW5PWmc2Y3NQdTVBMkwySFhyTEJQbUNL?=
 =?utf-8?B?ZHFERkdSZzNNUHRQTmtJaU5SOGx5RVdJL1FsU3NEaDdPa0NHZjFRek1mc29m?=
 =?utf-8?B?djVaR0xMZ2ZTV2FWYUJpRzg1R05ZMWtKdmk1aWVmcTRTR3k1bjRBUFFmZlh0?=
 =?utf-8?B?QVhWMWM2MnNRTktkSGVwSFZ3c2l4VmNHLzF5Qnh0MTlhSSs2YWs3V29lWmoy?=
 =?utf-8?B?QlJzR20vWU9EMXplMHJNKy9sOFE2SXIwUG9sOTZ4V1VPSXBqYjZXa1kvcHRF?=
 =?utf-8?B?ZmwvVytURnhhdjlad1VlWVl4YXZwVFQ1QzFxbWlUaDEzNzdEVWlJblN6cGJm?=
 =?utf-8?B?dkluK1V4bDlMTFdCUGErbXpVVzhYRk9ITjZOVUhJZ29Mb1ZpY3F1a1U1bnEz?=
 =?utf-8?B?alhwQ3RyV21icTVQWWVaYVU1SFhvcFA4OUlydFBuWHJHOCtiTjlRa1Q1UWtw?=
 =?utf-8?B?Qm9WbDJ5Y3dTQlNseVVzNHZkMytJcDBBTEtYQ0dYcG1JNXlsTTRHWmdHRmJ2?=
 =?utf-8?B?NURUclFTanF5c1F6b3Q0a0JDR0xwVXRXaGJHVEwrZjVBL1N1ZkZHbzlqNGVU?=
 =?utf-8?B?ZVJmeGFLOElpUE1hcFQveXkvSTdQUWVCd2hubGZ0QjR4ZGhqckFPUGdvclVN?=
 =?utf-8?B?WTZhQkVtTHdXVXlUTlV4dDZ0SVJUKzFFTWxQZy81M2t5dEl4RVc4Vk1ZbEUz?=
 =?utf-8?B?Q1RZVnBraWM4aEtCSnNnT2cxQ1ppc21ydUlCOXk0T0prV0hUbUYraTU5L1J3?=
 =?utf-8?B?KzF1TW5idHZ4aWd1M2ROMFJ6Z1kwek93Njd5eVZTd1ErK3RTSnVsUTZQWHdK?=
 =?utf-8?B?d085d0creWNiYVV5aHpONm0wNGlkb0NiVUpGN0JqaHpDenpHN0kwTnhQS24x?=
 =?utf-8?B?Qm9DVVlEeDhqZllhcVd1L1E4MGhBVDNRRXhiWURkVWJscFhXMWsxTjA2Nkpu?=
 =?utf-8?B?cytNZ2U4N0x1b1pEZUhiZUlhOU5OUW1obzlFUE1jMjVKWHpoUVRVbzNyRCtQ?=
 =?utf-8?B?SVBLalg1MDVnT0NMcU9SdzRkcHR0UldIaWVPKzlSMkFBZm5kY0E2RlhQaWRL?=
 =?utf-8?B?blJORVAwUnB5Q0dpVDY1dnMzbWhnVGdYZnpURkRqbGxORWpRdVltUnVLSU5k?=
 =?utf-8?B?UXhPREJlL3VVR3haQTdoK2x1RUUxZWpIdVNsRU0vVzk2RmhCUU5WbnhCZEQz?=
 =?utf-8?B?cmZLZ3NGdWdBUUhmdmU1L3hrbDBVZmpZM3prZW96cmpxb2U4akd6N0huQVRV?=
 =?utf-8?B?S2hmUnduNjhqRGRWRGU1eG5LV25UR0xXNS9VSVcydGxMV1lubmU2bGhKU04x?=
 =?utf-8?B?RUo3QzFFRlNMcWNHTzVWRTJ2N1BtajF3bUFWUTYvVnVXSkNsdFFFcXM5b04r?=
 =?utf-8?B?eFpGWlN3NHgwV0xvRlhHaExIeTdoM3crQWlRM0UvT2hhUlhJUDBRTGZ4UHRr?=
 =?utf-8?B?MXpaSWNqRCsxUHZndTByOSt6S3hPUDhNZ3dSWXZZbFp6ZEZDc3YzeHJKQ2Zx?=
 =?utf-8?B?WGNPQ3lHTVJJQ25hTit5OVIrWDhWSnNJaytLbGFidG9od0xvTE95b2hSYm40?=
 =?utf-8?B?alFRcitrbWdka0FrYm90ZVZVS3F2ZzU4VWpibHhtKzI1T3FhTGJqOXQwdW55?=
 =?utf-8?B?MUgrMjhKY1IvRnlIOU9mdEZRVjdwY3RXVGNPNkNnQUdyaGIzTEFSRTNqSlpz?=
 =?utf-8?B?Y0p2aFliYzh0SlYyblN1c09kTm8ybDdPdTlOdWx5VjBkU0lIVm5KVzdYRk5Z?=
 =?utf-8?Q?nL4657PGRSQSaAztFIoMdaKIz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fc0f02-7d42-4fe8-885a-08dae96cbcc7
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2022 07:17:26.3341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1EqT4Mun3epxlzGj35/O9pZyZLKXj6Mk5UAH/mCu25wcAAu+sQueD4AhCBPRgRA20bErvYynza2mxI0lxhTlPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

Including the detailed results from testing below.

tl;dr

o There seems to be 3 noticeable regressions:
  - tbench for lower number of clients. The schedstat data shows
    an increase in wait time.
  - SpecJBB MultiJVM performance drops as the workload prefers
    an idle CPU over a busy one.
  - Unixbench-pipe benchmark performance drops.

o Most benchmark numbers remain same.

o Small gains seen for ycsb-mongodb and unixbench-syscall.

On 12/16/2022 11:38 AM, Chen Yu wrote:
> The main purpose of this change is to avoid too many cross CPU
> wake up when it is unnecessary. The frequent cross CPU wake up
> brings significant damage to some workloads, especially on high
> core count systems.
> 
> This patch set inhibits the cross CPU wake-up by placing the wakee
> on waking CPU or previous CPU, if both the waker and wakee are
> short-duration tasks.
> 
> The first patch is to introduce the definition of a short-duration
> task. The second patch leverages the first patch to choose a local
> or previous CPU for wakee.
> 
> Changes since v3:
> 1. Honglei and Josh have concern that the threshold of short
>    task duration could be too long. Decreased the threshold from
>    sysctl_sched_min_granularity to (sysctl_sched_min_granularity / 8),
>    and the '8' comes from get_update_sysctl_factor().
> 2. Export p->se.dur_avg to /proc/{pid}/sched per Yicong's suggestion.
> 3. Move the calculation of average duration from put_prev_task_fair()
>    to dequeue_task_fair(). Because there is an issue in v3 that,
>    put_prev_task_fair() will not be invoked by pick_next_task_fair()
>    in fast path, thus the dur_avg could not be updated timely.
> 4. Fix the comment in PATCH 2/2, that "WRITE_ONCE(CPU1->ttwu_pending, 1);"
>    on CPU0 is earlier than CPU1 getting "ttwu_list->p0", per Tianchen.
> 5. Move the scan for CPU with short duration task from select_idle_cpu()
>    to select_idle_siblings(), because there is no CPU scan involved, per>    Yicong.

Following are the results from running standard benchmarks on a
dual socket Zen3 (2 x 64C/128T) machine configured in different
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
- tip:          6.1.0-rc2 tip sched/core
- sis_short: 	6.1.0-rc2 tip sched/core + this series

When the testing started, the tip was at:
commit d6962c4fe8f9 "sched: Clear ttwu_pending after enqueue_task()"

~~~~~~~~~~~~~
~ hackbench ~
~~~~~~~~~~~~~

NPS1

Test:			tip			sis_short
 1-groups:	   4.25 (0.00 pct)	   4.26 (-0.23 pct)
 2-groups:	   4.95 (0.00 pct)	   4.87 (1.61 pct)
 4-groups:	   5.19 (0.00 pct)	   5.09 (1.92 pct)
 8-groups:	   5.45 (0.00 pct)	   5.37 (1.46 pct)
16-groups:	   7.33 (0.00 pct)	   7.65 (-4.36 pct)

NPS2

Test:			tip			sis_short
 1-groups:	   4.09 (0.00 pct)	   4.20 (-2.68 pct)
 2-groups:	   4.68 (0.00 pct)	   4.75 (-1.49 pct)
 4-groups:	   5.05 (0.00 pct)	   4.94 (2.17 pct)
 8-groups:	   5.37 (0.00 pct)	   5.29 (1.48 pct)
16-groups:	   6.69 (0.00 pct)	   6.78 (-1.34 pct)

NPS4

Test:			tip			sis_short
 1-groups:	   4.28 (0.00 pct)	   4.37 (-2.10 pct)
 2-groups:	   4.78 (0.00 pct)	   4.82 (-0.83 pct)
 4-groups:	   5.11 (0.00 pct)	   5.06 (0.97 pct)
 8-groups:	   5.48 (0.00 pct)	   5.38 (1.82 pct)
16-groups:	   7.07 (0.00 pct)	   6.93 (1.98 pct)

~~~~~~~~~~~~
~ schbench ~
~~~~~~~~~~~~

NPS1

#workers:	tip			sis_short
  1:	  31.00 (0.00 pct)	  32.00 (-3.22 pct)
  2:	  33.00 (0.00 pct)	  32.00 (3.03 pct)
  4:	  39.00 (0.00 pct)	  34.00 (12.82 pct)
  8:	  45.00 (0.00 pct)	  43.00 (4.44 pct)
 16:	  61.00 (0.00 pct)	  66.00 (-8.19 pct)
 32:	 108.00 (0.00 pct)	 107.00 (0.92 pct)
 64:	 212.00 (0.00 pct)	 223.00 (-5.18 pct)
128:	 475.00 (0.00 pct)	 519.00 (-9.26 pct)	*
128:	 434.00 (0.00 pct)	 438.00 (-0.92 pct)	[Verification Run]
256:	 44736.00 (0.00 pct)	 42048.00 (6.00 pct)
512:	 77184.00 (0.00 pct)	 76672.00 (0.66 pct)

NPS2

#workers:	tip			sis_short
  1:	  28.00 (0.00 pct)	  32.00 (-14.28 pct)
  2:	  34.00 (0.00 pct)	  37.00 (-8.82 pct)
  4:	  36.00 (0.00 pct)	  37.00 (-2.77 pct)
  8:	  51.00 (0.00 pct)	  47.00 (7.84 pct)
 16:	  68.00 (0.00 pct)	  67.00 (1.47 pct)
 32:	 113.00 (0.00 pct)	 117.00 (-3.53 pct)
 64:	 221.00 (0.00 pct)	 221.00 (0.00 pct)
128:	 553.00 (0.00 pct)	 567.00 (-2.53 pct)
256:	 43840.00 (0.00 pct)	 47040.00 (-7.29 pct)	*
256:	 46016.00 (0.00 pct)	 46272.00 (-0.55 pct)	[Verification Run]
512:	 76672.00 (0.00 pct)	 78976.00 (-3.00 pct)

NPS4

#workers:	tip			sis_short
  1:	  33.00 (0.00 pct)	  32.00 (3.03 pct)
  2:	  29.00 (0.00 pct)	  42.00 (-44.82 pct)
  4:	  39.00 (0.00 pct)	  43.00 (-10.25 pct)
  8:	  58.00 (0.00 pct)	  56.00 (3.44 pct)
 16:	  66.00 (0.00 pct)	  68.00 (-3.03 pct)
 32:	 112.00 (0.00 pct)	 113.00 (-0.89 pct)
 64:	 215.00 (0.00 pct)	 214.00 (0.46 pct)
128:	 689.00 (0.00 pct)	 823.00 (-19.44 pct)	*
128:	 424.00 (0.00 pct)	 449.00 (-5.89 pct)	[Verification Run]
256:	 45120.00 (0.00 pct)	 44608.00 (1.13 pct)
512:	 77440.00 (0.00 pct)	 79488.00 (-2.64 pct)


~~~~~~~~~~
~ tbench ~
~~~~~~~~~~

NPS1

Clients:	tip			sis_short
    1	 581.75 (0.00 pct)	 545.15 (-6.29 pct)	*
    1    588.80 (0.00 pct)       547.71 (-6.97 pct)	[Verification Run]
    2	 1145.75 (0.00 pct)	 1074.91 (-6.18 pct)	*
    2    1153.55 (0.00 pct)      1068.06 (-7.41 pct)	[Verification Run]
    4	 2127.94 (0.00 pct)	 1958.71 (-7.95 pct)	*
    4    2133.95 (0.00 pct)      1965.03 (-7.91 pct)	[Verification Run]
    8	 3838.27 (0.00 pct)	 3701.75 (-3.55 pct)
   16	 6272.71 (0.00 pct)	 6045.56 (-3.62 pct)
   32	 11400.12 (0.00 pct)	 11688.67 (2.53 pct)
   64	 21605.96 (0.00 pct)	 22070.92 (2.15 pct)
  128	 30715.43 (0.00 pct)	 30772.11 (0.18 pct)
  256	 55580.78 (0.00 pct)	 54998.38 (-1.04 pct)
  512	 56528.79 (0.00 pct)	 55239.00 (-2.28 pct)
 1024	 56520.40 (0.00 pct)	 55153.71 (-2.41 pct)

NPS2

Clients:	tip			sis_short
    1	 584.13 (0.00 pct)	 555.55 (-4.89 pct)
    2	 1153.63 (0.00 pct)	 1094.62 (-5.11 pct)	*
    2    1147.26 (0.00 pct)      1063.35 (-7.31 pct)	[Verification Run]
    4	 2212.89 (0.00 pct)	 2049.24 (-7.39 pct)	*
    4    2133.57 (0.00 pct)      2004.66 (-6.04 pct)	[Verification Run]
    8	 3871.35 (0.00 pct)	 3793.66 (-2.00 pct)
   16	 6216.72 (0.00 pct)	 5895.87 (-5.16 pct)	*
   16    6342.15 (0.00 pct)      5962.58 (-5.98 pct)	[Verification Run]
   32	 11766.98 (0.00 pct)	 11013.97 (-6.39 pct)	*
   32    11009.53 (0.00 pct)     10215.06 (-7.21 pct)	[Verification Run]
   64	 22000.93 (0.00 pct)	 20563.47 (-6.53 pct)	*
   64    20315.34 (0.00 pct)     20097.13 (-1.07 pct)	[Verification Run]
  128	 31520.53 (0.00 pct)	 27489.63 (-12.78 pct)	*
  128    29224.27 (0.00 pct)     27872.81 (-4.62 pct)	[Verification Run]
  256	 51420.11 (0.00 pct)	 51968.82 (1.06 pct)
  512	 53935.90 (0.00 pct)	 54053.59 (0.21 pct)
 1024	 55239.73 (0.00 pct)	 54505.89 (-1.32 pct)

NPS4

Clients:	tip			sis_short
    1	 585.83 (0.00 pct)	 547.36 (-6.56 pct)	*
    1    590.36 (0.00 pct)       546.57 (-7.41 pct)	[Verification Run]
    2	 1141.59 (0.00 pct)	 1061.99 (-6.97 pct)	*
    2    1167.56 (0.00 pct)      1059.16 (-9.28 pct)	[Verification Run]
    4	 2174.79 (0.00 pct)	 2002.42 (-7.92 pct)	*
    4    2169.72 (0.00 pct)      1973.22 (-9.05 pct)	[Verification Run]
    8	 3887.56 (0.00 pct)	 3543.62 (-8.84 pct)	*
    8    3747.36 (0.00 pct)      3398.57 (-9.30 pct)	[Verification Run]
   16	 6441.59 (0.00 pct)	 5896.92 (-8.45 pct)	*
   16    6165.54 (0.00 pct)      6019.96 (-2.36 pct)	[Verification Run]
   32	 12133.60 (0.00 pct)	 11074.16 (-8.73 pct)	*
   32    11182.63 (0.00 pct)     11241.82 (0.52 pct)	[Verification Run]
   64	 21769.15 (0.00 pct)	 19485.94 (-10.48 pct)	*
   64    20168.52 (0.00 pct)     20333.98 (0.82 pct)	[Verification Run]
  128	 31396.31 (0.00 pct)	 29029.29 (-7.53 pct)	*
  128    29437.98 (0.00 pct)     27438.60 (-6.79 pct)	[Verification Run]
  256	 52792.39 (0.00 pct)	 51560.92 (-2.33 pct)
  512	 55315.44 (0.00 pct)	 52914.21 (-4.34 pct)
 1024	 52150.27 (0.00 pct)	 53286.08 (2.17 pct)


~~~~~~~~~~
~ stream ~
~~~~~~~~~~

NPS1

10 Runs:

Test:		tip			sis_short
 Copy:	 307827.79 (0.00 pct)	 320671.93 (4.17 pct)
Scale:	 208872.28 (0.00 pct)	 213725.16 (2.32 pct)
  Add:	 239404.64 (0.00 pct)	 240872.59 (0.61 pct)
Triad:	 247258.30 (0.00 pct)	 249764.53 (1.01 pct)

100 Runs:

Test:		tip			sis_short
 Copy:	 317217.55 (0.00 pct)	 318031.46 (0.25 pct)
Scale:	 208740.82 (0.00 pct)	 213773.01 (2.41 pct)
  Add:	 240550.63 (0.00 pct)	 239618.79 (-0.38 pct)
Triad:	 249594.21 (0.00 pct)	 245722.98 (-1.55 pct)

NPS2

10 Runs:

Test:		tip			sis_short
 Copy:	 340877.18 (0.00 pct)	 336204.91 (-1.37 pct)
Scale:	 217318.16 (0.00 pct)	 218200.84 (0.40 pct)
  Add:	 259078.93 (0.00 pct)	 258847.83 (-0.08 pct)
Triad:	 274500.78 (0.00 pct)	 267234.01 (-2.64 pct)

100 Runs:

Test:		tip			sis_short
 Copy:	 341860.73 (0.00 pct)	 335116.25 (-1.97 pct)
Scale:	 218043.00 (0.00 pct)	 219265.81 (0.56 pct)
  Add:	 253698.22 (0.00 pct)	 260792.08 (2.79 pct)
Triad:	 265011.84 (0.00 pct)	 269655.66 (1.75 pct)

NPS4

10 Runs:

Test:		tip			sis_short
 Copy:	 323775.81 (0.00 pct)	 363923.22 (12.39 pct)
Scale:	 237719.83 (0.00 pct)	 238074.93 (0.14 pct)
  Add:	 251896.35 (0.00 pct)	 269129.04 (6.84 pct)
Triad:	 264124.72 (0.00 pct)	 284456.89 (7.69 pct)

100 Runs:

Test:		tip			sis_short
 Copy:	 360777.62 (0.00 pct)	 375325.94 (4.03 pct)
Scale:	 239333.27 (0.00 pct)	 238341.16 (-0.41 pct)
  Add:	 271142.94 (0.00 pct)	 269924.55 (-0.44 pct)
Triad:	 285408.97 (0.00 pct)	 290345.65 (1.72 pct)

~~~~~~~~~~~~~~~~
~ ycsb-mongodb ~
~~~~~~~~~~~~~~~~

o NPS1

tip:                    131696.33 (var: 2.03%)
sis_short:              129031.33 (var: 1.71%)  (-2.02%)

o NPS2:

tip:                    129895.33 (var: 2.34%)
sis_short:              133652.33 (var: 1.11%)  (+2.89%)

o NPS4:

tip:                    131165.00 (var: 1.06%)
sis_short:              135975.00 (var: 0.34%)  (+3.66%)

~~~~~~~~~~~~~~~~~~~~~~~~~~~
~ SPECjbb MultiJVM - NPS1 ~
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Kernel			 tip		sis_short
Max-jOPS		100%		  96%
Critical-jOPS		100%		  97%

~~~~~~~~~~~~~
~ unixbench ~
~~~~~~~~~~~~~

o NPS1

Test			Metric	  Parallelism			tip		      	sis_short
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      48929419.48 (   0.00%)    48992339.28 (   0.13%)
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6266355505.80 (   0.00%)  6251441423.60 (  -0.24%)
unixbench-syscall       Amean     unixbench-syscall-1        2994319.73 (   0.00%)     2665595.13 *  10.98%*
unixbench-syscall       Amean     unixbench-syscall-512      7349715.87 (   0.00%)     7645690.70 *  -4.03%*
unixbench-pipe          Hmean     unixbench-pipe-1           2830206.03 (   0.00%)     2508957.89 * -11.35%*	*
unixbench-pipe          Hmean     unixbench-pipe-512       326207828.01 (   0.00%)   306588592.66 *  -6.01%*	*
unixbench-spawn         Hmean     unixbench-spawn-1             6394.21 (   0.00%)        6153.47 (  -3.76%)
unixbench-spawn         Hmean     unixbench-spawn-512          72700.64 (   0.00%)       87873.75 *  20.87%*
unixbench-execl         Hmean     unixbench-execl-1             4723.61 (   0.00%)        4678.46 (  -0.96%)
unixbench-execl         Hmean     unixbench-execl-512          11212.05 (   0.00%)       11067.41 *  -1.29%*

o NPS2

Test			Metric	  Parallelism			tip		      	sis_short
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      49271512.85 (   0.00%)    48842191.93 (  -0.87%)
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6267992483.03 (   0.00%)  6261579339.17 (  -0.10%)
unixbench-syscall       Amean     unixbench-syscall-1        2995885.93 (   0.00%)     2668794.40 *  10.92%*
unixbench-syscall       Amean     unixbench-syscall-512      7388865.77 (   0.00%)     7229531.57 *   2.16%*
unixbench-pipe          Hmean     unixbench-pipe-1           2828971.95 (   0.00%)     2509560.35 * -11.29%*	*
unixbench-pipe          Hmean     unixbench-pipe-512       326225385.37 (   0.00%)   306941838.69 *  -5.91%*	*
unixbench-spawn         Hmean     unixbench-spawn-1             6958.71 (   0.00%)        6613.24 (  -4.96%)
unixbench-spawn         Hmean     unixbench-spawn-512          85443.56 (   0.00%)       89130.15 *   4.31%*
unixbench-execl         Hmean     unixbench-execl-1             4767.99 (   0.00%)        4684.44 *  -1.75%*
unixbench-execl         Hmean     unixbench-execl-512          11250.72 (   0.00%)       11197.80 (  -0.47%)

o NPS4

Test			Metric	  Parallelism			tip		      	sis_short
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      49041932.68 (   0.00%)    48942640.63 (  -0.20%)
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6277864986.70 (   0.00%)  6263890106.10 (  -0.22%)
unixbench-syscall       Amean     unixbench-syscall-1        2992405.60 (   0.00%)     2663959.00 *  10.98%*
unixbench-syscall       Amean     unixbench-syscall-512      7971789.70 (   0.00%)     7834566.33 *   1.72%*
unixbench-pipe          Hmean     unixbench-pipe-1           2822892.54 (   0.00%)     2505995.43 * -11.23%*	*
unixbench-pipe          Hmean     unixbench-pipe-512       326408309.83 (   0.00%)   306887263.78 *  -5.98%*	*
unixbench-spawn         Hmean     unixbench-spawn-1             7685.31 (   0.00%)        7675.29 (  -0.13%)
unixbench-spawn         Hmean     unixbench-spawn-512          72245.56 (   0.00%)       74190.34 *   2.69%*
unixbench-execl         Hmean     unixbench-execl-1             4761.42 (   0.00%)        4683.56 *  -1.64%*
unixbench-execl         Hmean     unixbench-execl-512          11533.53 (   0.00%)       11298.59 (  -2.04%)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~ Analyzing tbench (2 client) for NPS1 configuration ~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tip: 		1126.33 MB/sec
sis_short:	1031.26 MB/sec (-8.44%)

-> Legend for per CPU stats:

rq->yld_count:                  sched_yield count
rq->sched_count:                schedule called
rq->sched_goidle:               schedule left the processor idle
rq->ttwu_count:                 try_to_wake_up was called
rq->ttwu_local:                 try_to_wake_up was called to wake up the local cpu
rq->rq_cpu_time:                total runtime by tasks on this processor (in jiffies)
rq->rq_sched_info.run_delay:    total waittime by tasks on this processor (in jiffies)
rq->rq_sched_info.pcount:       total timeslices run on this cpu

-> System wide stats

-------------------------------------------------------------------------------------------------------------------------
cpu:  all_cpus (avg) vs cpu:  all_cpus (avg)
-------------------------------------------------------------------------------------------------------------------------
sched_yield count                                          :             0,            0
Legacy counter can be ignored                              :             0,            0
schedule called                                            :        233543,       213786  |  -8.46|
schedule left the processor idle                           :        116745,       106863  |  -8.46|
try_to_wake_up was called                                  :        116772,       106893  |  -8.46|
try_to_wake_up was called to wake up the local cpu         :            74,           84  |  13.51|
total runtime by tasks on this processor (in jiffies)      :     579771198,    585440128
total waittime by tasks on this processor (in jiffies)     :        176365,       258702  |  46.69|	* Wait time is much longer
total timeslices run on this cpu                           :        116797,       106922  |  -8.45|
-------------------------------------------------------------------------------------------------------------------------
< -----------------------------------------------------------------  Wakeup info:  ------------------------------------ >
Wakeups on same         SMT cpus = all_cpus (avg)       :             0,            0             
Wakeups on same         MC cpus = all_cpus (avg)        :        116689,       106797  |  -8.48|
Wakeups on same         DIE cpus = all_cpus (avg)       :             2,            4
Wakeups on same         NUMA cpus = all_cpus (avg)      :             5,            7
Affine wakeups on same  SMT cpus = all_cpus (avg)       :             0,            0
Affine wakeups on same  MC cpus = all_cpus (avg)        :        116667,       106781  |  -8.47|
Affine wakeups on same  DIE cpus = all_cpus (avg)       :             2,            4
Affine wakeups on same  NUMA cpus = all_cpus (avg)      :             5,            6
--------------------------------------------------------------------------------------------------------------------------

The rq->rq_sched_info.pcount and rq->sched_count seems to
have reduced proportionally.

> 
> Changes since v2:
> 
> 1. Peter suggested comparing the duration of waker and the cost to
>    scan for an idle CPU: If the cost is higher than the task duration,
>    do not waste time finding an idle CPU, choose the local or previous
>    CPU directly. A prototype was created based on this suggestion.
>    However, according to the test result, this prototype does not inhibit
>    the cross CPU wakeup and did not bring improvement. Because the cost
>    to find an idle CPU is small in the problematic scenario. The root
>    cause of the problem is a race condition between scanning for an idle
>    CPU and task enqueue(please refer to the commit log in PATCH 2/2).
>    So v3 does not change the core logic of v2, with some refinement based
>    on Peter's suggestion.
> 
> 2. Simplify the logic to record the task duration per Peter and Abel's suggestion.
> 
> This change brings overall improvement on some microbenchmarks, both on
> Intel and AMD platforms.
> 
> v3: https://lore.kernel.org/lkml/cover.1669862147.git.yu.c.chen@intel.com/
> v2: https://lore.kernel.org/all/cover.1666531576.git.yu.c.chen@intel.com/
> v1: https://lore.kernel.org/lkml/20220915165407.1776363-1-yu.c.chen@intel.com/
> 
> Chen Yu (2):
>   sched/fair: Introduce short duration task check
>   sched/fair: Choose the CPU where short task is running during wake up
> 
>  include/linux/sched.h   |  3 +++
>  kernel/sched/core.c     |  2 ++
>  kernel/sched/debug.c    |  1 +
>  kernel/sched/fair.c     | 32 ++++++++++++++++++++++++++++++++
>  kernel/sched/features.h |  1 +
>  5 files changed, 39 insertions(+)
> 

All numbers are with turbo and C2 enabled. I wonder if the
check "(5 * nr < 3 * sd->span_weight)" in v2 helped workloads
like tbench and SpecJBB. I'll queue some runs with the condition
added back and separate run with turbo and C2 disabled to see
if they helps. I'll update the thread once the results are in.

--
Thanks and Regards,
Prateek
