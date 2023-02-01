Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C2B685FF2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 07:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjBAGwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBAGvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:51:55 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068B08A73;
        Tue, 31 Jan 2023 22:51:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdBFkE3OxQaAZssQqUOgiIkJUaYpTFeb7+RLS2G+oS2yZaMHO2qfOivcf9Ge2ByrQC8zAyWI858cm+OnT6tC38g0kYVNIhjO0/nNHl4muzxdWhlnRVq+EGybXOunRtJoR5OSKGIk8/mD7HnVQHTyR1lzOW/MQ5J+vfpQAfFq252t9b3RSwzX+HcoyNlmetA0dg9vUltVRFOWdgJGd4RVlDOtuY8KfquDxmBZ54a6Au3xBwTHRstin/YzecwMJUJfA8ZAVVeb7qFXrw3ptKMmuFlowVXHvuwefYdGAqSwyb/0bEu8rYZZigl8MTuFBSAZYLfAyBfYjyTeLwWmsBrGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJjhJNwQVm5eda8zJ2RfVgdv+Hh0sDUZ1QWgZ+0MVPc=;
 b=CAnqni/Hd3MxsxChyLAT9CL3yJC65WURJ1cPPgkV/GWu//Xl3WgVg0/o7Oby7GecPNaCV3M8yl503/wkbkA9rXmV0q5vx5dNaVuvDKPmQAa8p8QuPUk4YXYWMMwFWMHR5sSI74RPlM/FBub20PP3uIZRW+p5QaOI4C3w2umqi8F/0d32LhFuAQg/YvvVGWF1B2WO/Ctm/KEBY3wRFeT88q7KhKXaASWZUPIGfqcSnJwtcuMXSTNpJEL5J49QYdHoX2yd+gxmFSPWSlD7Hwmm4tzn8WzZNYDk0k+RJsnwwM0vhZgZ1hLhpMReGiuBmULIqJLwedgVWJ4RsmdA6nx2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJjhJNwQVm5eda8zJ2RfVgdv+Hh0sDUZ1QWgZ+0MVPc=;
 b=OmnFqUvGMjdlD4itw/4LZ4d/dQqncOh4tl6hZF3P7l/Tj2TMWzDic1pBFpdInCdGRX3IQRP1Z46wlxCVqTR0bgARPQt5Tln1AcAFOylB7Jzgllx21UzSRQX8PbCsZre6ssejkKHkznGE8dMsvL9FFKXGMvSMitHm2kqCIn2aRQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CO6PR12MB5492.namprd12.prod.outlook.com (2603:10b6:5:35d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Wed, 1 Feb
 2023 06:51:51 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::25e3:3a9c:e866:787]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::25e3:3a9c:e866:787%7]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 06:51:50 +0000
Message-ID: <6871e91f-997b-8558-e87b-7bf147f2750c@amd.com>
Date:   Wed, 1 Feb 2023 12:21:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [6.1.7][6.2-rc5] perf all metrics test: FAILED!
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        "Xing, Zhengjun" <zhengjun.xing@intel.com>, sedat.dilek@gmail.com
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        llvm@lists.linux.dev, Ben Hutchings <benh@debian.org>,
        James Clark <james.clark@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <CA+icZUU_ew7pzWJJZLbj1xsU6MQTPrj8tkFfDhNdTDRQfGUBMQ@mail.gmail.com>
 <CAP-5=fULKkEYXOVV5tXd8J0occGJwgV+BiJLkA=exW=bfgyEBw@mail.gmail.com>
 <CA+icZUUOZoLOFiBcYkccWPSusk9G_Rhf3DOZYWat-K+VfWFHQw@mail.gmail.com>
 <c6605d52-b9e1-e8d3-ed29-562146f64eea@arm.com>
 <CAP-5=fWcb8m9vkfqSC9H2Gqi2dBjbPuGb2F27Fq-ejmR25foQw@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAP-5=fWcb8m9vkfqSC9H2Gqi2dBjbPuGb2F27Fq-ejmR25foQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::7) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CO6PR12MB5492:EE_
X-MS-Office365-Filtering-Correlation-Id: dd2f2b15-b5a2-4214-e527-08db0420cbaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mV11eMCUgX3tLOjGa4tzzq1Bn3cgTys1FBpjGO11wXRI19z3+1NWHxVxP/Qs0h3qKbX9ANGyQcH6UswTVoybn9H4U2ET52kSMao44YCMTszPmFDJwyPsX4jc5/D7Msn15zqYagtrbmwFlrz8CuMd8x72mNHpcHBwbPI28IZafP/DQtWTw+8hEkCno2M8gpIT6FPLKgqWmFk+Ryh0eD51J7rrNbXRKemF7JrpDQDxuZUmTWHRq8WTjR5u3fNowFMUva5kOZFxWvxZ0/bASJouB8zU1d2S8E+zMZqwv3DTE4o1p8xWNX2Ra/q3eSsRTadg3WgyVmYr+9wcmhkMm/MCU4Q9vwufdVo94uFZ+xcTBNdSXkPqSWg2VHTjzBzFeKCZyWQnwTubnN83uXggRtGwPZ0l5OFu6MKooRW48BaCDEUsi4MnIO71NjYBAfdzyWczuGqlOPg+dANlKlCoObUXPHil2iblPEfdywY3xuWETiyBV+SB4O3VQgzxrhRG4CJZNwnYiGzuUtvu7GGunjVGVSVLT7c4af77ET6eUsEz6ksywKn99rbualJCKyVpd5Kk31qIA2Jbs6RT+UTzSslJlrXrSSEmdr1WzL1KhgOTsVmVcS+qbisJIlqNWsNfYnVfy+wj9g22GxdzeoTKWpMKvnVNKFlEvqpwFz9ottQL2X1ciVvxgUbQiotGxnremAhnBcQlG3CrXOWaTA2XyZFuxshvdBhAMVwlfrwHhX+rNEU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199018)(83380400001)(31686004)(6666004)(478600001)(6486002)(6512007)(2616005)(6506007)(26005)(186003)(31696002)(86362001)(38100700002)(36756003)(316002)(2906002)(41300700001)(66946007)(66556008)(8936002)(44832011)(66476007)(7416002)(110136005)(5660300002)(54906003)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0xNNm8vR1NaU3lOUklWdW5jeGpJcDhvK0ZwVms1TFprY0ZIUlBzMXJ4d3Jm?=
 =?utf-8?B?T1R2aUpxb3d6TDVWSEdYcFNkSVk4V0N0Nm0zYmNkSUVtWnpmWE9tdkNia1VF?=
 =?utf-8?B?UC9yUXFzcmJrRmJWVnBFa0NnMjNaa2R1TDZjLzNiUk04TVRWYXFORnZON1dx?=
 =?utf-8?B?eGZkRFZNemw2d0l2QVEzTDNqQVRrdEg3VEtOYm5TdGhMdDZyekJKRk54TS80?=
 =?utf-8?B?b3habWJZQjIzaUlIaVBlaDJzaHV5MEhtcEkva3FMWGUvQnlOM2RsUXhxOTdG?=
 =?utf-8?B?MTVsVU44cHYvbitrSkpRSjR3YTZPYU5hT3ZEZit0cCtuQUkxTkgrU1pKempG?=
 =?utf-8?B?c0xsN3pHRjljbGlacnhTaXo5MHB4NGdDcmxXQzh5Z25RelpiWHNYZUhUaUhk?=
 =?utf-8?B?TytoVGlBVWRLYzN1dDdvd1FvUE1qZEJnSGwyUThkYjFxV2hsc0h0aVlPanBV?=
 =?utf-8?B?dnhIdmUvYm5hSEJ6UG9xK1ppYkpLOFNXeXJOUDBPMis0RnFYZzVDVUNzamQr?=
 =?utf-8?B?bno2UmlmMFhJWHM1bUF4S25nYmQwcFVCMWRTTWdwaEcwbEU1WmVsRGp1Qjk1?=
 =?utf-8?B?YVBWdjlUOXFhZnR3eDVHZHNyK0IyZ0tDZU5mcUVNT1pCc3dKa1ppZlZ0UGNw?=
 =?utf-8?B?Q2MrSnQ3S2FSY0c4d2MzdW5mNkhSMkxFbG52ZjFKM0l2NW1QZUZQcWxVZUVw?=
 =?utf-8?B?K3JkUHFZVENZMDJqcDl4dDgwQitIdkZnWk1zamNkNDNJOFBQcHQwWHRVbnN1?=
 =?utf-8?B?c3A5eW55bHFGUXhyaXNDMDJncklEUHZpOStkaVBDSVZaL1R3cnladnpBa0RV?=
 =?utf-8?B?SzIvTkZNaE9nUWtLNHhFWVN1Y0RPQlVyMFNUYU1NSDZQMi9TMDZHNk8wUDR4?=
 =?utf-8?B?aDM4WWZoRGZ6VGdzSEdNSWVqaGxkY0FMcWZYVjhmMU1OdmNZVHZhUUV2Rmhh?=
 =?utf-8?B?aWtmQjF2alpSdlpBRGk5c3BjSklwQ1d6ZVFadjYwVFdDMFN3ZmdjVDdocHRL?=
 =?utf-8?B?enlHUHBnZlJ3ZDdRZ25pNWROR0lqZU5GSE9pRU42Tmp6eTAyOG1RaXZWV2wx?=
 =?utf-8?B?ZHJicDRkTEdZQWV3T2xrb0hraWlaZnBIUGtVRHY0UUpaSkF4S1ZFRFRxV1FU?=
 =?utf-8?B?ZHpCODdYcnNrQ090Ny8vKytYcm42Ynh6NFpaN1JBeXhDL3YrM0JlNmZwaElM?=
 =?utf-8?B?UXBhYkE1bHJkVXN6UDdWeVZaYXBWM0lMaWhaK0FDMkJTU1NSN3Rob2hNUjFh?=
 =?utf-8?B?UFZoWS95RFVyb2VKVnZXN29JdUVZMlVkTndSVnhFRDk1ZHhWZVJyNkExMGNs?=
 =?utf-8?B?Slc2WmpZZm8zRlFvL2FHV0cwLzhrdjY4RE96dTBQUHNIRzYzK0d4MGRTQlZN?=
 =?utf-8?B?aXpxSVM0V2dhU05QL3pxNUNLZmhlZTR4SUZpQjN3REpRR2E3eXd2dVNnWm9s?=
 =?utf-8?B?MDlDb0ZSTlcwV201WmpWSlB4UWNTN1FwVytiaFd0aDZaNGlwNEJEZWtDc3VP?=
 =?utf-8?B?YVBHNWhvUWtmUkdpck9LSFJHdHZLYzNrekswQWZneEJIVkFwYTB4N3NEb1BC?=
 =?utf-8?B?bGxGc0lOQkJFd0FxeHhETFI2bE1IMGFjejVwczFGTHlaZmZDMG11a1R1MnNi?=
 =?utf-8?B?OUY4VTdDM2dpVmtnem0rOTM1OVQycUhKWnZ0NnJXV1BvZG9YRWVueFRzMEtu?=
 =?utf-8?B?V1VxejRZMDdqcnZxU1pNaS9nSGJUTVVaZmJNbUkya1ZtWUlXcGM0ZUVreXdZ?=
 =?utf-8?B?VVZUaUR5U1BSOXFJR1Y1RFREMzg5WGlrNkIvZW9aY3RYVmY3QWFvcDNwV0p1?=
 =?utf-8?B?bkJDTWhRS2ZMR0lNeWlBdEVwbmhhZTRZNVkwNU05Y1kwalVwK1lFdzFNRTdU?=
 =?utf-8?B?a2pRMTNlWks3VmVtRTFQSjRuN0dxUHkvc0F2Y0ZiZVpsNXVPeWRiRFlpMUt5?=
 =?utf-8?B?V3pEb3hiWkRrWHQ3bk52MmViS0tLbUN0SFJLb0NmZTdnRlhjQmhnZFFjRGlJ?=
 =?utf-8?B?aXZXbHFjVDhSUGluVmJSTUtTT0pReFZsa3duS1l4QllJSFNHb3R3MC9uUGtj?=
 =?utf-8?B?T0paMnhULzBnemltTjRNVS96ZVhWMmlkeERSWUxoZTdvRnBYZUJLSG1MeUJV?=
 =?utf-8?Q?icf49UK5Dusn6euTz+jLWFLVC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2f2b15-b5a2-4214-e527-08db0420cbaf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 06:51:50.7073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3aeDHzcFN5RfnmDOd19O+hblOp0G1INlj7nAl6d5g7Qnnq31vuuySQm3fF7Q1PicpDgDuB7D74Ln8SKWcWwshw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5492
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

> So I think this is a kernel bug triggering a perf tool bug. The kernel
> bug can be worked around in the perf tool. I only had an Ivybridge to
> test with (hence slightly different events) but what I see is both
> tma_dram_bound and tma_l3_bound using the same 4 events. I could work
> around the "<not counted>" by adding the --metric-no-group flag:
> 
> ```
> $ perf stat -M tma_l3_bound --metric-no-group -a sleep 1
> 
> Performance counter stats for 'system wide':
> 
>           400,404      MEM_LOAD_UOPS_RETIRED.LLC_HIT    #      4.3 %
> tma_l3_bound             (74.99%)
>       128,937,891      CYCLE_ACTIVITY.STALLS_L2_PENDING
>                         (87.46%)
>           167,459      MEM_LOAD_UOPS_RETIRED.LLC_MISS
>                         (74.99%)
>       759,574,967      CPU_CLK_UNHALTED.THREAD
>                         (87.47%)
> 
>       1.001526438 seconds time elapsed
> 
> $ perf stat -M tma_dram_bound -a --metric-no-group sleep 1
> 
> Performance counter stats for 'system wide':
> 
>           259,954      MEM_LOAD_UOPS_RETIRED.LLC_HIT    #     15.2 %
> tma_dram_bound           (74.99%)
>       118,807,043      CYCLE_ACTIVITY.STALLS_L2_PENDING
>                         (87.46%)
>           111,699      MEM_LOAD_UOPS_RETIRED.LLC_MISS
>                         (74.95%)
>       587,571,060      CPU_CLK_UNHALTED.THREAD
>                         (87.45%)
> 
>       1.001518093 seconds time elapsed
> ```
> 
> The issue is that perf metrics use weak groups of events. A weak group
> is the same as a group of events initially. We want to use groups of
> events with metrics so that all the counters are scheduled in and out
> at the same time, and not multiplexed independently. Imagine measuring
> IPC but the counts for instructions and cycles are measured at
> different periods, the resultant IPC value would be unlikely to be
> accurate. If perf_event_open fails then the perf tool retries the
> events without the group. If I try just 3 of the events in a weak
> group then the failure can be seen:
> 
> ```
> $ perf stat -e "{MEM_LOAD_UOPS_RETIRED.LLC_HIT,MEM_LOAD_UOPS_RETIRED.LLC_MISS,CYCLE_ACTIVITY.STALLS_L2_PENDING}:W"
> -a sleep 1
> 
> Performance counter stats for 'system wide':
> 
>     <not counted>      MEM_LOAD_UOPS_RETIRED.LLC_HIT
>                         (0.00%)
>     <not counted>      MEM_LOAD_UOPS_RETIRED.LLC_MISS
>                         (0.00%)
>     <not counted>      CYCLE_ACTIVITY.STALLS_L2_PENDING
>                         (0.00%)
> 
>       1.001458485 seconds time elapsed
> ```
> 
> The kernel should have failed the perf_event_open on opening the third
> event and then measured without the group,

IIUC, Kernel should not fail opening of the 3rd event, because there are 4
general purpose counters on Intel and all three events can be scheduled
on any of the 4 counter (I checked IvyBridge).

However, what I don't understand is why kernel failed to schedule the group.
Unless someone has pre-occupied 2 or more GP counter, group should get
schedule fine.

> which it can do with
> multiplexing as in the following:
> 
> ```
> $ perf stat -e "MEM_LOAD_UOPS_RETIRED.LLC_HIT,MEM_LOAD_UOPS_RETIRED.LLC_MISS,CYCLE_ACTIVITY.STALLS_L2_PENDING"
> -a sleep 1
> 
> Performance counter stats for 'system wide':
> 
>         1,239,397      MEM_LOAD_UOPS_RETIRED.LLC_HIT
>                         (79.06%)
>           174,826      MEM_LOAD_UOPS_RETIRED.LLC_MISS
>                         (64.60%)
>       124,026,024      CYCLE_ACTIVITY.STALLS_L2_PENDING
>                         (81.16%)
> 
>       1.001483434 seconds time elapsed
> ```
> 
> When the --metric-no-group flag is given to perf then it doesn't
> produce the initial weak group, which works around the bug of the
> kernel not failing on the 3rd perf_event_open. I've added Kan and
> Zhengjun to the e-mail as they work on the Intel kernel PMU code.
> 
> There's a question about what we should do in the perf test about
> this? I have a few solutions:
> 
> 1) try metric tests again with the --metric-no-group flag and don't
> fail the test if this succeeds. This allows kernel bugs to hide, so
> I'm not a huge fan.
> 
> 2) add a new metric flag/constraint to say not to group, this way the
> metric will automatically apply the "--metric-no-group" flag. It is a
> bit of work to wire this up but this kind of failure is common enough
> in PMUs that it is probably worthwhile. We also need to add the flag
> to metrics and I'm not sure how to get a good list of the metrics that
> currently fail and require it. This is okay but error prone.
> 
> 3) fix the kernel bug and let the perf test fail until an adequate
> kernel is installed. Probably the best option.

Thanks,
Ravi

