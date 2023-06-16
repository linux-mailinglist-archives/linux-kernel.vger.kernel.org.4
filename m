Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2968A7327B5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjFPGf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243431AbjFPGfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:35:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFC42D69;
        Thu, 15 Jun 2023 23:35:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krGApTTtClQBl6FXaZvZ3WX9ZEBmJCpLBhLfJ3M3D4s35fIvNB6dyn+RRHABK6L1SmQQ90BSdNhag6veDhouWZKGOGDhLAunvxZVxs6ZgyvYROohuosBqYJVZfn6LxCahe+1fFrjyElrbY6UKKYOE7IGf4wCn4TjYr5nT80cn5L3OfC1lN5NWYxK/gQqXXo0iXBobImQdMvOGl46zxfaAlyDj4YMb1JTd57ss2RjxKCPAFkUDzg7yOzHws4coPif1rJG7iVVj+ozXg8UCLrbvB60IY0aeNU6FfwYIGn9A62aLfXIuDnjCVxhN5i2+sHhrNVkoGwC8nmYDnnIjcvtZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4l7QM17NggR/Kc2sl7wBUuqSkAIj3z34U5XLHvi7eE=;
 b=HkoIs4b/ao3/NCu3x/QMzOlZ9IIkSDhKy4fcW6H3TQhmVwEOOoKQvAf4AXD+Cp/Uyw6w13Ptx6kEPuvIImmD4sWcHEqQeA9danY8wqcC681xtTyWOMCxGXvvSPoYpS10OsZR41mYR5UmFkXGTnaR3cKAPLPXJBzyZXdUkfWu5Vg8ppRslMGIiP0SAfM+pf7FjPpQVIZiokwC5Y0tm9TnU4MtOn90mjelDklSL01hUChsCUd5kYcdhZfsod0JmtAROaan3HYNt4CpANQPBadVPy1G0+jqiDX9o8tdjtLN6dYUBHRkPKai4J0IzMUYCcyipEC/GHxXzxcPNTalT4GYfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4l7QM17NggR/Kc2sl7wBUuqSkAIj3z34U5XLHvi7eE=;
 b=tcp/o1mNAo0znO6xzdG1nVnrkaMxvSIQEYalqVE59BiGlSvhecNGuSGixt9WRQrz7seZpos5cfcukHY93beLjCiBABIU8W0ondX/G7Z0p5c5N5porT+hNCkx0RYN5Rtk19CIOxfTZB+WIcp8vZAzg5oQhN3QTVVeWOBO0JsbPbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 06:35:06 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c%2]) with mapi id 15.20.6455.039; Fri, 16 Jun 2023
 06:35:06 +0000
Message-ID: <f212f491-cd3f-6eee-20d7-8f9ab8937902@amd.com>
Date:   Fri, 16 Jun 2023 12:04:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        Chen Yu <yu.c.chen@intel.com>
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
 <3de5c24f-6437-f21b-ed61-76b86a199e8c@amd.com>
 <20230601111326.GV4253@hirez.programming.kicks-ass.net>
 <20230601115643.GX4253@hirez.programming.kicks-ass.net>
 <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
 <20230601144706.GA559454@hirez.programming.kicks-ass.net>
 <7bee9860-2d2a-067b-adea-04012516095c@amd.com>
 <20230602065438.GB620383@hirez.programming.kicks-ass.net>
 <bd083d8d-023a-698e-701b-725f1b15766e@amd.com>
 <20230613082536.GI83892@hirez.programming.kicks-ass.net>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230613082536.GI83892@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::20) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DM4PR12MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: 447ca15e-3a1e-425d-0179-08db6e33d254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RBMbYOgCiPBViOjZYIs1uHiz3E5NpO6v2e0ZgEsc1Sl2phBDmyQl47Z2t56rfbhGrKol5NBDdgsE3oikGjgwXpNpoFayt+7yffiryrlbEPS+0x9JNjuollaZxyLxi+ubDaHGTNpRrItN3LQLSBWn3fN4ykFP6T7uqDjA+QRL/BvN2hXQjKjXLkgOkAc8vhedWVf5ZrY4d6Db/Cgy4EaYTsL6VAfTsJIYxbaj661SnU+V/ZnX7rqMP6Q4qPpqsC9yvCFECVD2eH1/f69EBRx6pKYEW4mtDJPayr6jvOmTpoxXrnYpMKdwcyL63fq+RTCvSjJyL4q56yVvjhUw1Z+QHSjANRMM6Fop8ZmyR9H81GNa0n74W11Xmfvf7+tT7sGcPZf+ywmR63kSgz+6GDX+NXdAsOoNae7gsgfQks19Fv9JF8GAGqzuDnItnvoBz9F8QbOxgWFNXQ7um5K8EsM+aKIpgcIzqnJe3uvGFeK8iFST3bW/2iXjdyyq7PIROEFXk98IABietVEfMEUjK8/I8+IbondMpc1Af1l8XjoGCLc3m1+GiizCA6yJK0RJpVOK+KoZ9Dl1raqCaHH7/mjAxmi3EydvFtwSs6g4X+2LwzZn1US0SH8+UvYZFGR+g084fFgPXJ6UreMuBUYFqik9aoW/Igw4JvCFsTHFN7mKSzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199021)(6512007)(6506007)(26005)(53546011)(36756003)(186003)(478600001)(966005)(6666004)(6486002)(2906002)(30864003)(316002)(8936002)(41300700001)(86362001)(31696002)(31686004)(5660300002)(8676002)(38100700002)(54906003)(66899021)(2616005)(83380400001)(6916009)(4326008)(66476007)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHM5NmZrVzJoY3Vpbmc4QmpjY20rcXJXY3hUck9HMDl6S0w4Vm5wYURsOEpq?=
 =?utf-8?B?b1ZuNnJYS2FGL2Fkb243T1U3bkgrT1FDU0NNOUdLV2dSRDZpTWovZzE5Wkk1?=
 =?utf-8?B?Kzlwb3I3Ulo3VGtiaTFHdmYySmtvSjNJNU1NZktNRDkxbGRhU1lwdTlGbjl2?=
 =?utf-8?B?dzlOaHBNY2RFNE12VHV5SDB6NW9sVm5vS1d6cDR3Um9UYjhJVGV2NERmQjl1?=
 =?utf-8?B?NEtDUjU2NFpWeFdsbHZqdVJkWklTZ3ZEQXpBOTdQaVJuZTRRUktCQ1RibElP?=
 =?utf-8?B?cldlYUt0MlJTWmFwdDAydU4rQ1JGcFdwMDkzcVArOFBTK0VMWFBTNGVZSHkw?=
 =?utf-8?B?WlQzRFpRYXp3TUJxZkhJbG1Cei9PUjRaV29JYWRFYmtvVksvTGNrSGdQcWsr?=
 =?utf-8?B?SUEyclFTdVc3aHhxRnFpQ05XZVlBUzNvbnZ3RGw3YlR6YmR2cGM5SjJDSFUr?=
 =?utf-8?B?M2pLajF1WXFJNUJWV0trYlFJeS9RY0djZGEyb0p0Y3ZFaURjNS9hRG9Hc0ZX?=
 =?utf-8?B?UjhjSzIvRE1ZUk1tWXpDT1ZxNW1yRzloR211S3NRRG1UZVRBb0I1amxGbjlX?=
 =?utf-8?B?blFuTi9CNjVnWEdSR3lRSFl1ZHlPZjBST2h2eDQ0eXExSW51M3Qvbk1HakxV?=
 =?utf-8?B?WTlZU2NPK1drNzVCVEJVZ1dCaGtHZVZYM1BjNjVpNGY2RkRFeU53emRJd2Nt?=
 =?utf-8?B?OGRsQi94U3F3TzNET0lRaVRUdXNpQ1c1emkvUkdQQUsxTVhaL3ZrQ0FsYlV1?=
 =?utf-8?B?eUQxTjN6VWRBTTZ3YjJ1bmdxdU8zV2xlZUtpUnRmZFRBQWRsSkJENldmK3VB?=
 =?utf-8?B?RHNqbTJic3pVTTdFQ3BrQ040Y3Z1R2JVc3RYTDIvN0l1eUUyNEZ1T0hDbktu?=
 =?utf-8?B?UXQrQTdSemh1bkY3cVA5S1AycGE1MUxhYk1HRlJ6MHhUU05tZG9vQTM4THdh?=
 =?utf-8?B?T1RaekRmeklvSk11dlhVWlo0VURrN1FSTWIwT3Q4ZUJhalkyN3p5RE5oeVpi?=
 =?utf-8?B?aWxkcGYwZU84b0t1WG1KSHJYSjUyUlhWc3pZV2k3OWMvZkpVV21ocDF4RXhO?=
 =?utf-8?B?U2prcnE3VHpoSllMdW1xTXRtTmYzdzZKa0V6STk0N3RZQVBSK3VSQzRuRmJY?=
 =?utf-8?B?RGZ3TXpKTnMvM0Z1TEZoY1FzeXpoM2lLclhUS3duN1lKQjl4dVZyLzF4dnc2?=
 =?utf-8?B?eUZveStaQW9UR0VSRWtiMTludks2cSt2TmxhdjJoS2JRUHovMjdnM0I5V0Uz?=
 =?utf-8?B?Qzd4TU4yMVBDWXVlUnhhQlJQQlE3SFZGcWYrL0JNUnhHTFd3RjhjQWx4cmI0?=
 =?utf-8?B?N3J2b0Q0QkEwaWUxTHlFcUp3clFobG9Ya0ZxeWxiUU9OOEpDTjhnc3FPTHVK?=
 =?utf-8?B?RVFtRWZyZThjRU82bXB6cDZvQ3p6OXhjZDZ1aUgzeHhLRCtRRkhxdmorNEV4?=
 =?utf-8?B?NisyRWc0ZVRtM3Z1K01oWDM0NkszQ0xIRjVzY2pRbWpsbnhaYk5rNmJLNGNq?=
 =?utf-8?B?V3BLZWdWRGdESU9YaGNVQmpxWVhjc3gxcVVacEV2OUkxNmorUkVadGpiWGpR?=
 =?utf-8?B?UlowVFpPUG4xdk9Sb3ZwR2JpUlZ4RlEyZDRYN3VjaEkwcFFHSUJjTFdicGVh?=
 =?utf-8?B?MG1GemlMWXo2NEdvRitKOFdtbEJVWi8rVEdZRmVHTWdDWEZBVWYxdkRMZ0ll?=
 =?utf-8?B?THU0OEpwakh3eitMamRTVW0yaDVYUE5iV1QyUENVVnN2OWxIOXNrMHdza3Q2?=
 =?utf-8?B?MDNMU29PcGpaVjRUaGpnRnBqdk1vV0xLTWJyVFZWcGFrWVpRRXhreWV6VXRl?=
 =?utf-8?B?VGFiWU9WS0VDYW9VRXZUNFlmQ28zemdYckdBc3Vkak16VUxzM1B4cHZpY3dV?=
 =?utf-8?B?Y0VyZnJCUGRaYm9RUyt2cStWL2hzK0J5OSs5cE14aENVK1VZTUEyMC85azla?=
 =?utf-8?B?Tk8wejQvelVlUXFWUERPdi91UWZQcWpTaVlpUDZML1VtT2NGWmxLRkdGOGFX?=
 =?utf-8?B?T1BmenFwT2Qrcm5hZ0pkdlJLUlduUzNvQ0xWT2cyYmJSQ09DT2ErcXRIVXh1?=
 =?utf-8?B?TnpzNi9CVmxRQUVvVEZjUVZZa24vc0Q0RXgwNGZjZW9aT2oxRWhnaFNEaHpC?=
 =?utf-8?Q?/3yWiqjQzugOkQdAWxJlD7TI4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447ca15e-3a1e-425d-0179-08db6e33d254
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 06:35:05.8816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XPiUTRjRL0WYvYXNramgUSjDRZ22BgCMl/Yi/d7hDhNQjTlHY0+W5QDGVh3rpQSWrG/ZzWiEwWuxKsPfbwZaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5181
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

On 6/13/2023 1:55 PM, Peter Zijlstra wrote:
> LIMIT seems to do well for the NPS1 case, but how come it falls apart
> for NPS2 ?!? that doesn't realy make sense, does it?

Including the results again with a rerun of SIS_NODE_LIMIT which I
definitely messed up last time. I'll include a small tl;dr for each
benchmark to reduce the dizziness from all the numbers :)

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

    - 8CCX per node

NPS2: Each socket is further logically divided into 2 NUMA regions.
    Total 4 NUMA nodes exist over 2 socket.
   
    Node 0: 0-31,   128-159
    Node 1: 32-63,  160-191
    Node 2: 64-95,  192-223
    Node 3: 96-127, 223-255

    - 4 CCX per node

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

    - 2 CCX per node

  Note:

  - Ideally in NPS2 and NPS4 modes SIS_NODE and SIS_NODE_LIMIT should
    behave similarly.

  - Ideally in NPS4 mode SIS_NODE and SIS_NODE_TOPOEXT should behave
    similarly.

o Kernel Versions

- tip              - tip:sched/core at commit e2a1f85bf9f5 "sched/psi:
                     Avoid resetting the min update period when it is
                     unnecessary")

- SIS_NODE         - tip:sched/core + this patch

- SIS_NODE_LIMIT   - tip:sched/core + this patch + nr=4 limit for SIS_NODE [1]

- SIS_NODE_TOPOEXT - tip:sched/core + this patch
                     + new sched domain (Multi-Multi-Core or MMC) [2]
		     (MMC domain groups 2 nearby CCX.)

[1] https://lore.kernel.org/all/20230601111326.GV4253@hirez.programming.kicks-ass.net/
[2] https://lore.kernel.org/all/3402dcc4-d52f-d99f-e6ce-b435478a5a59@amd.com/

o Benchmark Results

Note: All benchmarks were run with boost enabled and C2 disabled.

~~~~~~~~~~~~~
~ hackbench ~
~~~~~~~~~~~~~

tl;dr

- Similar trend is observed for SIS_NODE and SIS_NODE_LIMIT in NPS2 and
  NPS4 mode.
- Similar trend is observed for all SIS_NODE and SIS_NODE_TOPOEXT for
  NPS4 mode.
- Limiting search score seem to reduce the regression seen from plain
  SIS_NODE with a couple of outliers but the absolute numbers are not
  far off except for 16-groups in NPS4 mode for SIS_NODE_LIMIT.

o NPS1

Test:                   tip                     SIS_NODE           SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
1-groups:         3.92 (0.00 pct)         4.05 (-3.31 pct)        3.92 (0.00 pct)         3.77 (3.82 pct)
2-groups:         4.58 (0.00 pct)         3.84 (16.15 pct)        3.81 (16.81 pct)        4.34 (5.24 pct)
4-groups:         4.99 (0.00 pct)         3.98 (20.24 pct)        4.02 (19.43 pct)        5.01 (-0.40 pct)
8-groups:         5.67 (0.00 pct)         6.05 (-6.70 pct)        6.35 (-11.99 pct)       5.95 (-4.93 pct)
16-groups:        7.88 (0.00 pct)        10.56 (-34.01 pct)      10.07 (-27.79 pct)       8.04 (-2.03 pct)

o NPS4

Test:                   tip                     SIS_NODE           SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
1-groups:         3.82 (0.00 pct)         3.68 (3.66 pct)         3.80 (0.52 pct)         3.74 (2.09 pct)
2-groups:         4.40 (0.00 pct)         3.61 (17.95 pct)        3.90 (11.36 pct)        4.30 (2.27 pct)
4-groups:         4.84 (0.00 pct)         3.62 (25.20 pct)        4.11 (15.08 pct)        4.97 (-2.68 pct)
8-groups:         5.45 (0.00 pct)         6.14 (-12.66 pct)       6.15 (-12.84 pct)       5.68 (-4.22 pct)
16-groups:        6.94 (0.00 pct)         8.77 (-26.36 pct)       9.51 (-37.03 pct)       7.87 (-13.40 pct)

o NPS4

Test:                   tip                     SIS_NODE           SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
1-groups:         3.82 (0.00 pct)         3.84 (-0.52 pct)        3.83 (-0.26 pct)        3.85 (-0.78 pct)
2-groups:         4.44 (0.00 pct)         4.15 (6.53 pct)         4.25 (4.27 pct)         4.18 (5.85 pct)
4-groups:         4.86 (0.00 pct)         4.95 (-1.85 pct)        5.07 (-4.32 pct)        4.79 (1.44 pct)
8-groups:         5.42 (0.00 pct)         5.80 (-7.01 pct)        6.19 (-14.20 pct)       5.75 (-6.08 pct)
16-groups:        6.68 (0.00 pct)         9.07 (-35.77 pct)      13.80 (-106.58 pct)      8.66 (-29.64 pct)


~~~~~~~~~~~~~~~~~~
~ schbench (Old) ~
~~~~~~~~~~~~~~~~~~

tl;dr

- Similar to what was observed with hackbench with few outliers here
  and there.

o NPS1

#workers:       tip                     SIS_NODE             SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
1:          26.00 (0.00 pct)        24.00 (7.69 pct)        26.00 (0.00 pct)        20.00 (23.07 pct)
2:          27.00 (0.00 pct)        24.00 (11.11 pct)       24.00 (11.11 pct)       26.00 (3.70 pct)
4:          31.00 (0.00 pct)        28.00 (9.67 pct)        29.00 (6.45 pct)        28.00 (9.67 pct)
8:          36.00 (0.00 pct)        33.00 (8.33 pct)        34.00 (5.55 pct)        34.00 (5.55 pct)
16:         49.00 (0.00 pct)        47.00 (4.08 pct)        51.00 (-4.08 pct)       50.00 (-2.04 pct)
32:         80.00 (0.00 pct)        81.00 (-1.25 pct)       82.00 (-2.50 pct)       81.00 (-1.25 pct)
64:        169.00 (0.00 pct)       169.00 (0.00 pct)       175.00 (-3.55 pct)      177.00 (-4.73 pct)
128:       343.00 (0.00 pct)       365.00 (-6.41 pct)      361.00 (-5.24 pct)      336.00 (2.04 pct)
256:     42048.00 (0.00 pct)     35392.00 (15.82 pct)    42048.00 (0.00 pct)     48576.00 (-15.52 pct)
512:     95104.00 (0.00 pct)     88704.00 (6.72 pct)     88192.00 (7.26 pct)     89984.00 (5.38 pct)

o NPS2

#workers:       tip                     SIS_NODE             SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
1:          23.00 (0.00 pct)        24.00 (-4.34 pct)       19.00 (17.39 pct)       21.00 (8.69 pct)
2:          24.00 (0.00 pct)        24.00 (0.00 pct)        26.00 (-8.33 pct)       28.00 (-16.66 pct)
4:          31.00 (0.00 pct)        26.00 (16.12 pct)       26.00 (16.12 pct)       29.00 (6.45 pct)
8:          41.00 (0.00 pct)        38.00 (7.31 pct)        38.00 (7.31 pct)        38.00 (7.31 pct)
16:         48.00 (0.00 pct)        49.00 (-2.08 pct)       50.00 (-4.16 pct)       53.00 (-10.41 pct)
32:         81.00 (0.00 pct)        84.00 (-3.70 pct)       80.00 (1.23 pct)        86.00 (-6.17 pct)
64:        157.00 (0.00 pct)       169.00 (-7.64 pct)      162.00 (-3.18 pct)      172.00 (-9.55 pct)
128:       386.00 (0.00 pct)       400.00 (-3.62 pct)      400.00 (-3.62 pct)      384.00 (0.51 pct)
256:     48832.00 (0.00 pct)     44480.00 (8.91 pct)     44480.00 (8.91 pct)     48576.00 (0.52 pct)
512:     92032.00 (0.00 pct)     89472.00 (2.78 pct)     88448.00 (3.89 pct)     91008.00 (1.11 pct)

o NPS4

#workers:       tip                     SIS_NODE             SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
1:          21.00 (0.00 pct)        24.00 (-14.28 pct)      23.00 (-9.52 pct)       22.00 (-4.76 pct)
2:          28.00 (0.00 pct)        24.00 (14.28 pct)       29.00 (-3.57 pct)       28.00 (0.00 pct)
4:          32.00 (0.00 pct)        29.00 (9.37 pct)        28.00 (12.50 pct)       30.00 (6.25 pct)
8:          46.00 (0.00 pct)        43.00 (6.52 pct)        44.00 (4.34 pct)        42.00 (8.69 pct)
16:         51.00 (0.00 pct)        53.00 (-3.92 pct)       57.00 (-11.76 pct)      56.00 (-9.80 pct)
32:         82.00 (0.00 pct)        81.00 (1.21 pct)        87.00 (-6.09 pct)       83.00 (-1.21 pct)
64:        173.00 (0.00 pct)       172.00 (0.57 pct)       176.00 (-1.73 pct)      155.00 (10.40 pct)
128:       396.00 (0.00 pct)       384.00 (3.03 pct)       366.00 (7.57 pct)       386.00 (2.52 pct)
256:     48832.00 (0.00 pct)     46656.00 (4.45 pct)     47296.00 (3.14 pct)     49472.00 (-1.31 pct)
512:     95104.00 (0.00 pct)     90752.00 (4.57 pct)     91264.00 (4.03 pct)     90496.00 (4.84 pct)


~~~~~~~~~~
~ tbench ~
~~~~~~~~~~

tl;dr

- I'll rerun the datapoints marked with (^) because they are
  surprisingly good for SIS_NODE and not SIS_NODE_LIMIT when both are
  supposed to behave exactly same.
- IN NPS1 (marked with (*)) there is a sharp outlier at 256 clients
  where larger search scope seems to be more successful as machine
  becomes more overloaded (?!) I'll go check some idle stats here. 

o NPS1

Clients:      tip                     SIS_NODE             SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
1        452.49 (0.00 pct)       457.94 (1.20 pct)       455.34 (0.62 pct)       447.69 (-1.06 pct)
2        862.44 (0.00 pct)       879.99 (2.03 pct)       871.34 (1.03 pct)       855.91 (-0.75 pct)
4       1604.27 (0.00 pct)      1618.87 (0.91 pct)      1621.18 (1.05 pct)      1627.14 (1.42 pct)
8       2966.77 (0.00 pct)      3040.90 (2.49 pct)      3002.73 (1.21 pct)      2957.91 (-0.29 pct)
16      5176.70 (0.00 pct)      5292.29 (2.23 pct)      5249.57 (1.40 pct)      5241.61 (1.25 pct)
32      8205.24 (0.00 pct)      8949.12 (9.06 pct)      9006.75 (9.76 pct)      8494.17 (3.52 pct)
64      13956.71 (0.00 pct)     14461.42 (3.61 pct)     15150.47 (8.55 pct)     15045.43 (7.80 pct)
128     24005.50 (0.00 pct)     26052.75 (8.52 pct)     26570.09 (10.68 pct)    24008.73 (0.01 pct)  *
256     32457.61 (0.00 pct)     21999.41 (-32.22 pct)   21635.06 (-33.34 pct)   31060.12 (-4.30 pct) *
512     34345.24 (0.00 pct)     41166.39 (19.86 pct)    35180.72 (2.43 pct)     31864.14 (-7.22 pct) *
1024    33432.92 (0.00 pct)     40900.84 (22.33 pct)    36075.90 (7.90 pct)     32006.81 (-4.26 pct)

o NPS2

Clients:      tip                     SIS_NODE             SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
1         453.73 (0.00 pct)       451.63 (-0.46 pct)      449.92 (-0.83 pct)      453.79 (0.01 pct)
2         861.71 (0.00 pct)       857.85 (-0.44 pct)      867.28 (0.64 pct)       850.14 (-1.34 pct)
4        1599.14 (0.00 pct)      1609.30 (0.63 pct)      1601.12 (0.12 pct)      1619.10 (1.24 pct)
8        2951.03 (0.00 pct)      2944.71 (-0.21 pct)     2987.26 (1.22 pct)      2973.52 (0.76 pct)
16       5080.32 (0.00 pct)      5160.39 (1.57 pct)      5213.69 (2.62 pct)      5150.99 (1.39 pct)
32       7900.41 (0.00 pct)      8039.13 (1.75 pct)      8238.31 (4.27 pct)      7956.45 (0.70 pct)
64      14629.65 (0.00 pct)     15391.08 (5.20 pct)     14246.13 (-2.62 pct)    15410.41 (5.33 pct)
128     23155.88 (0.00 pct)     24015.45 (3.71 pct)     25187.85 (8.77 pct)     23351.35 (0.84 pct)
256     33449.57 (0.00 pct)     33571.08 (0.36 pct)     29242.15 (-12.57 pct)   32869.85 (-1.73 pct)
512     33757.47 (0.00 pct)     39872.69 (18.11 pct) ^  33893.44 (0.40 pct)     34526.17 (2.27 pct)
1024    34823.14 (0.00 pct)     41090.15 (17.99 pct) ^  33173.55 (-4.73 pct)    34522.97 (-0.86 pct)

o NPS4

Clients:      tip                     SIS_NODE             SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
1        450.14 (0.00 pct)       454.46 (0.95 pct)       449.90 (-0.05 pct)      451.43 (0.28 pct)
2        863.26 (0.00 pct)       868.94 (0.65 pct)       856.32 (-0.80 pct)      866.74 (0.40 pct)
4        1618.71 (0.00 pct)      1599.13 (-1.20 pct)     1592.50 (-1.61 pct)     1610.08 (-0.53 pct)
8        2929.35 (0.00 pct)      3065.12 (4.63 pct)      3052.68 (4.21 pct)      3004.74 (2.57 pct)
16       5114.04 (0.00 pct)      5261.40 (2.88 pct)      5220.86 (2.08 pct)      5108.53 (-0.10 pct)
32       7912.18 (0.00 pct)      8926.77 (12.82 pct)     8944.70 (13.04 pct)     8214.73 (3.82 pct)
64      14424.72 (0.00 pct)     14853.61 (2.97 pct)     14531.64 (0.74 pct)     14430.17 (0.03 pct)
128     23614.97 (0.00 pct)     24506.73 (3.77 pct)     25404.57 (7.57 pct)     23296.38 (-1.34 pct)
256     34365.13 (0.00 pct)     35538.42 (3.41 pct)     33123.21 (-3.61 pct)    31009.12 (-9.76 pct)
512     34215.50 (0.00 pct)     36017.49 (5.26 pct)     34398.11 (0.53 pct)     33262.55 (-2.78 pct)
1024    35421.90 (0.00 pct)     35193.81 (-0.64 pct)    36448.71 (2.89 pct)     32795.86 (-7.41 pct) *


~~~~~~~~~~
~ stream ~
~~~~~~~~~~

tl;dr

- Ideally nothing should change here since we are only running 16
  STREAM threads on such a large system however in NPS4, STREAM does
  not seem to be happy. (I'll go check whether it is indeed SIS_NODE)

- 10 Runs

o NPS1

Test:         tip                     SIS_NODE             SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
Copy:    271317.35 (0.00 pct)    292440.22 (7.78 pct)    241027.63 (-11.16 pct)  287277.25 (5.88 pct)
Scale:   205533.77 (0.00 pct)    203362.60 (-1.05 pct)   202615.73 (-1.41 pct)   205206.26 (-0.15 pct)
  Add:   221624.62 (0.00 pct)    225850.83 (1.90 pct)    212399.58 (-4.16 pct)   229774.48 (3.67 pct)
Triad:   228500.68 (0.00 pct)    225885.25 (-1.14 pct)   213445.64 (-6.58 pct)   240041.53 (5.05 pct)

o NPS2

Test:         tip                     SIS_NODE             SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
 Copy:   277761.29 (0.00 pct)    301816.34 (8.66 pct)    283260.62 (1.97 pct)    308218.80 (10.96 pct)
Scale:   215193.83 (0.00 pct)    212522.72 (-1.24 pct)   215479.38 (0.13 pct)    205678.94 (-4.42 pct)
  Add:   242725.75 (0.00 pct)    242695.13 (-0.01 pct)   240395.33 (-0.96 pct)   238089.46 (-1.91 pct)
Triad:   237253.44 (0.00 pct)    250618.57 (5.63 pct)    239077.27 (0.76 pct)    249652.73 (5.22 pct)

o NPS4

Test:         tip                     SIS_NODE             SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
 Copy:   273307.14 (0.00 pct)    255091.78 (-6.66 pct)   255965.91 (-6.34 pct)   262007.26 (-4.13 pct)
Scale:   235715.23 (0.00 pct)    222018.36 (-5.81 pct)   223368.73 (-5.23 pct)   222282.64 (-5.69 pct)
  Add:   244500.40 (0.00 pct)    230468.21 (-5.73 pct)   223901.86 (-8.42 pct)   227146.80 (-7.09 pct)
Triad:   250600.04 (0.00 pct)    236229.50 (-5.73 pct)   221054.69 (-11.78 pct)  231772.02 (-7.51 pct)

- 100 Runs

o NPS1

Test:         tip                     SIS_NODE             SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
Copy:    317381.65 (0.00 pct)    318827.08 (0.45 pct)    316606.07 (-0.24 pct)   318922.96 (0.48 pct)
Scale:   214145.00 (0.00 pct)    206213.69 (-3.70 pct)   216937.82 (1.30 pct)    210384.47 (-1.75 pct)
  Add:   239243.29 (0.00 pct)    229791.67 (-3.95 pct)   243660.76 (1.84 pct)    236659.48 (-1.07 pct)
Triad:   249477.76 (0.00 pct)    236843.06 (-5.06 pct)   237186.61 (-4.92 pct)   235990.67 (-5.40 pct)

o NPS2

Test:         tip                     SIS_NODE             SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
 Copy:   318082.10 (0.00 pct)    322844.91 (1.49 pct)    317697.43 (-0.12 pct)   322495.84 (1.38 pct)
Scale:   219338.56 (0.00 pct)    218139.90 (-0.54 pct)   220850.47 (0.68 pct)    221040.27 (0.77 pct)
  Add:   248118.20 (0.00 pct)    249826.98 (0.68 pct)    249156.94 (0.41 pct)    253006.79 (1.97 pct)
Triad:   247088.55 (0.00 pct)    260488.38 (5.42 pct)    255260.30 (3.30 pct)    249081.33 (0.80 pct)

o NPS4

Test:         tip                     SIS_NODE             SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
 Copy:   345396.19 (0.00 pct)    343675.74 (-0.49 pct)   338130.49 (-2.10 pct)   334677.55 (-3.10 pct)
Scale:   241521.63 (0.00 pct)    231494.70 (-4.15 pct)   239206.00 (-0.95 pct)   229159.01 (-5.11 pct)
  Add:   261157.86 (0.00 pct)    249663.86 (-4.40 pct)   255752.77 (-2.06 pct)   242257.98 (-7.23 pct)
Triad:   267804.99 (0.00 pct)    263071.00 (-1.76 pct)   253672.27 (-5.27 pct)   256978.50 (-4.04 pct)

~~~~~~~~~~~
~ netperf ~
~~~~~~~~~~~

tl;dr

- Similar trend as hackbench with a few outliers.

o NPS1

                        tip                  SIS_NODE              SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
 1-clients:      102839.97 (0.00 pct)    103540.33 (0.68 pct)    102890.49 (0.04 pct)    103271.77 (0.41 pct)
 2-clients:      98428.08 (0.00 pct)     100431.67 (2.03 pct)    100804.93 (2.41 pct)    100417.11 (2.02 pct)
 4-clients:      92298.45 (0.00 pct)     94800.51 (2.71 pct)     94137.00 (1.99 pct)     94981.10 (2.90 pct)
 8-clients:      85618.41 (0.00 pct)     89130.14 (4.10 pct)     85573.71 (-0.05 pct)    88284.61 (3.11 pct)
16-clients:      78722.18 (0.00 pct)     79715.38 (1.26 pct)     79422.52 (0.88 pct)     78980.88 (0.32 pct)
32-clients:      73610.75 (0.00 pct)     72801.41 (-1.09 pct)    74763.95 (1.56 pct)     75077.55 (1.99 pct)
64-clients:      55285.07 (0.00 pct)     56184.38 (1.62 pct)     58976.82 (6.67 pct)     60689.05 (9.77 pct)
128-clients:     31176.92 (0.00 pct)     32830.06 (5.30 pct)     39403.20 (26.38 pct)    35638.50 (14.31 pct)
256-clients:     20011.44 (0.00 pct)     15135.39 (-24.36 pct)   17117.22 (-14.46 pct)   18219.29 (-8.95 pct)
512-clients:     10012.28 (0.00 pct)     9726.37 (-2.85 pct)     10492.91 (4.80 pct)     9395.51 (-6.16 pct)


o NPS2

                        tip                  SIS_NODE              SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
1-clients:      103105.55 (0.00 pct)    101582.75 (-1.47 pct)   101709.57 (-1.35 pct)   102233.63 (-0.84 pct)
2-clients:       98720.29 (0.00 pct)     98537.46 (-0.18 pct)    98469.37 (-0.25 pct)    99211.39 (0.49 pct)
4-clients:       92289.39 (0.00 pct)     94332.45 (2.21 pct)     95033.41 (2.97 pct)     93321.77 (1.11 pct)
8-clients:       84998.63 (0.00 pct)     87180.90 (2.56 pct)     88343.42 (3.93 pct)     86076.75 (1.26 pct)
16-clients:      76395.81 (0.00 pct)     80017.06 (4.74 pct)     79511.47 (4.07 pct)     75090.85 (-1.70 pct)
32-clients:      71110.89 (0.00 pct)     69445.86 (-2.34 pct)    67564.76 (-4.98 pct)    66885.99 (-5.94 pct)
64-clients:      49526.21 (0.00 pct)     50004.13 (0.96 pct)     53450.34 (7.92 pct)     51100.52 (3.17 pct)
128-clients:     27917.51 (0.00 pct)     30581.70 (9.54 pct)     32451.97 (16.24 pct)    33477.65 (19.91 pct)
256-clients:     20067.17 (0.00 pct)     26002.42 (29.57 pct)    25011.83 (24.64 pct)    18144.96 (-9.57 pct)

o NPS4

                        tip                  SIS_NODE              SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
1-clients:      102139.49 (0.00 pct)    103578.02 (1.40 pct)    103036.47 (0.87 pct)    101656.07 (-0.47 pct)
2-clients:       98259.53 (0.00 pct)     99336.70 (1.09 pct)     99442.86 (1.20 pct)     98812.86 (0.56 pct)
4-clients:       91576.79 (0.00 pct)     95278.30 (4.04 pct)     94412.90 (3.09 pct)     93848.94 (2.48 pct)
8-clients:       84742.30 (0.00 pct)     89005.65 (5.03 pct)     86045.25 (1.53 pct)     86709.29 (2.32 pct)
16-clients:      79540.75 (0.00 pct)     85478.97 (7.46 pct)     81959.57 (3.04 pct)     81016.24 (1.85 pct)
32-clients:      71166.14 (0.00 pct)     74254.01 (4.33 pct)     71476.02 (0.43 pct)     71391.62 (0.31 pct)
64-clients:      51763.24 (0.00 pct)     52565.56 (1.54 pct)     50651.09 (-2.14 pct)    52472.91 (1.37 pct)
128-clients:     27829.29 (0.00 pct)     35774.61 (28.55 pct)    35541.25 (27.71 pct)    34564.10 (24.20 pct)
256-clients:     24185.37 (0.00 pct)     27215.35 (12.52 pct)    31619.39 (30.73 pct)    24937.66 (3.11 pct)


~~~~~~~~~~~~~~~~
~ ycsb-mongodb ~
~~~~~~~~~~~~~~~~

tl;dr

- SIS_NODE_LIMIT shows good improvements in NPS1 mode. Other modes
  are more or less similar.

o NPS1

tip:			131070.33 (var: 2.84%)
SIS_NODE:		131070.33 (var: 2.84%) (0.00%)
SIS_NODE_LIMIT:		137525.00 (var: 1.24%) (4.92%)
SIS_NODE_TOPOEXT:	133529.67 (var: 0.98%) (1.87%)

o NPS2

tip:			133693.67 (var: 1.69%)
SIS_NODE:		134173.00 (var: 4.07%) (0.35%)
SIS_NODE_LIMIT:		134068.33 (var: 2.10%) (0.28%)
SIS_NODE_TOPOEXT:	133747.33 (var: 2.49%) (0.04%)

o NPS4

tip:			132913.67 (var: 1.97%)
SIS_NODE:		133697.33 (var: 1.69%) (0.58%)
SIS_NODE_LIMIT:		133545.33 (var: 1.03%) (0.47%)
SIS_NODE_TOPOEXT:	133426.67 (var: 3.60%) (0.38%)

~~~~~~~~~~~~~
~ unixbench ~
~~~~~~~~~~~~~

tl;dr

- unixbench-syscall-512 in NPS1 and NPS2 seems to be the only gains
  while others stay more or less the same with few outliers as
  usual.

o NPS1

kernel                        			tip                  SIS_NODE               SIS_NODE_LIMIT            SIS_NODE_TOPOEXT
Hmean     unixbench-dhry2reg-1            41322625.19 (   0.00%)   41224388.33 (  -0.24%)    41064084.38 (  -0.63%)    41222168.97 (  -0.24%)
Hmean     unixbench-dhry2reg-512        6252491108.60 (   0.00%) 6240160851.68 (  -0.20%)  6245401623.65 (  -0.11%)  6259553403.67 (   0.11%)
Amean     unixbench-syscall-1              2501398.27 (   0.00%)    2577323.43 *  -3.04%*     2555415.40 *  -2.16%*     2541279.77 *  -1.59%*
Amean     unixbench-syscall-512            8120524.00 (   0.00%)    7512955.87 *   7.48%*     7443914.67 *   8.33%*     7477129.17 *   7.92%*
Hmean     unixbench-pipe-1                 2359346.02 (   0.00%)    2392308.62 *   1.40%*     2387202.32 *   1.18%*     2334146.94 *  -1.07%*
Hmean     unixbench-pipe-512             338790322.61 (   0.00%)  337711432.92 (  -0.32%)   337228635.73 *  -0.46%*   339008490.26 (   0.06%)
Hmean     unixbench-spawn-1                   4261.52 (   0.00%)       4164.90 (  -2.27%)        4351.26 (   2.11%)        5111.16 *  19.94%*
Hmean     unixbench-spawn-512                64328.93 (   0.00%)      62257.64 *  -3.22%*       63966.41 (  -0.56%)       63291.18 *  -1.61%*
Hmean     unixbench-execl-1                   3677.73 (   0.00%)       3652.08 (  -0.70%)        3599.76 *  -2.12%*        3671.98 (  -0.16%)
Hmean     unixbench-execl-512                11984.83 (   0.00%)      13585.65 *  13.36%*       13521.41 *  12.82%*       12306.01 (   2.68%)

o NPS2

kernel                        			tip                  SIS_NODE               SIS_NODE_LIMIT            SIS_NODE_TOPOEXT
Hmean     unixbench-dhry2reg-1            41311787.29 (   0.00%)    41412946.27 (   0.24%)    41305805.50 (  -0.01%)    41371003.93 (   0.14%)
Hmean     unixbench-dhry2reg-512        6243873272.76 (   0.00%)  6256893083.32 (   0.21%)  6246099911.20 (   0.04%)  6235047089.83 (  -0.14%)
Amean     unixbench-syscall-1              2503190.70 (   0.00%)     2576854.30 *  -2.94%*     2554603.93 *  -2.05%*     2540298.77 *  -1.48%*
Amean     unixbench-syscall-512            8012388.13 (   0.00%)     7503196.87 *   6.36%*     8076005.50 *  -0.79%*     7495117.73 *   6.46%*
Hmean     unixbench-pipe-1                 2340486.25 (   0.00%)     2388946.63 (   2.07%)     2397554.45 *   2.44%*     2360277.30 (   0.85%)
Hmean     unixbench-pipe-512             338965319.79 (   0.00%)   337225630.07 (  -0.51%)   336766051.70 *  -0.65%*   336939353.18 *  -0.60%*
Hmean     unixbench-spawn-1                   5241.83 (   0.00%)        5246.00 (   0.08%)        5248.48 (   0.13%)        4967.96 *  -5.22%*
Hmean     unixbench-spawn-512                65799.86 (   0.00%)       64817.15 *  -1.49%*       64569.20 *  -1.87%*       66820.63 *   1.55%*
Hmean     unixbench-execl-1                   3670.65 (   0.00%)        3622.36 *  -1.32%*        3633.71 (  -1.01%)        3660.08 (  -0.29%)
Hmean     unixbench-execl-512                13682.00 (   0.00%)       13699.90 (   0.13%)       13969.40 (   2.10%)       12960.11 (  -5.28%)

o NPS4

kernel                        			tip                  SIS_NODE               SIS_NODE_LIMIT            SIS_NODE_TOPOEXT
Hmean     unixbench-dhry2reg-1            41025577.99 (   0.00%)    40879469.78 (  -0.36%)    41209188.37 *   0.45%*    41260407.54 (   0.57%)
Hmean     unixbench-dhry2reg-512        6255568261.91 (   0.00%)  6258326086.80 (   0.04%)  6256509267.44 (   0.02%)  6259088809.43 (   0.06%)
Amean     unixbench-syscall-1              2507165.37 (   0.00%)     2579108.77 *  -2.87%*     2554902.63 *  -1.90%*     2517574.40 (  -0.42%)
Amean     unixbench-syscall-512            7458476.50 (   0.00%)     7502528.67 *  -0.59%*     7587645.17 *  -1.73%*     7580369.27 *  -1.63%*
Hmean     unixbench-pipe-1                 2369301.21 (   0.00%)     2392905.29 *   1.00%*     2383343.22 (   0.59%)     2347814.20 (  -0.91%)
Hmean     unixbench-pipe-512             340299405.72 (   0.00%)   339139980.01 *  -0.34%*   337309478.87 *  -0.88%*   338708678.82 *  -0.47%*
Hmean     unixbench-spawn-1                   5571.78 (   0.00%)        5423.03 (  -2.67%)        5076.02 *  -8.90%*        5543.08 (  -0.52%)
Hmean     unixbench-spawn-512                63999.96 (   0.00%)       63485.41 (  -0.80%)       63705.16 (  -0.46%)       67486.34 *   5.45%*
Hmean     unixbench-execl-1                   3587.15 (   0.00%)        3624.44 *   1.04%*        3614.43 *   0.76%*        3639.57 *   1.46%*
Hmean     unixbench-execl-512                14184.17 (   0.00%)       13784.17 (  -2.82%)       13985.35 (  -1.40%)       13598.22 (  -4.13%)

~~~~~~~~~~~~~~~~~~
~ DeathStarBench ~
~~~~~~~~~~~~~~~~~~

tl;dr

- Similar trend as hackbench except in NPS4 mode with 8CCXs (one
  socket), SIS_NODE_LIMIT and SIS_NODE_TOPOEXT are noticeably
  worse than SIS_NODE but all are bad.

o NPS1

CCD	Scaling	       tip    SIS_NODE 		SIS_NODE_LIMIT 		SIS_NODE_TOPOEXT
1	1		0%    0.30%             0.34%                   0.79%
2       2		0%    0.17%             0.78%                   0.91%
4       4		0%    -0.40%            0.91%                   1.61%
8       8		0%    -7.95%            -6.73%                  -1.56%

o NPS2

CCD	Scaling	       tip    SIS_NODE 		SIS_NODE_LIMIT 		SIS_NODE_TOPOEXT
1	1		0%    0.34%             0.07%                   -0.62%
2       2		0%    -0.02%            0.24%                   -1.15%
4       4		0%    -12.34%           -6.47%                  -7.80% * High Run to Run Variance (~10%)
8       8		0%    -12.41%           -12.83%                 -9.85%

o NPS4

CCD	Scaling	       tip    SIS_NODE 		SIS_NODE_LIMIT 		SIS_NODE_TOPOEXT
1	1		0%      -1.32%          -1.25%                  -1.09%
2       2		0%      -1.53%          -1.62%                  -1.73%
4       4		0%       7.19%           9.08%                   5.75%
8       8		0%      -4.66%          -9.68%                  -7.52%

--

Conclusion seems to be that most workloads would like to run on an idle
thread as quickly as possible, however, once the system becomes
overloaded, even iterating over the groups to find an idle CPU outside
of the target group can affect the workload performance. TOPOEXT is a
clean way to limit search (as long as marking the boundaries can be
done in a clean way) but there are concerns about the load balancing
jitters the new domain will introduce. There will also be an increase
in amount of C2C transfers as some of the shared data structures are
accessed and modified (for example sched_domain_shared->has_idle_cores
updates).

I'll go get some additional data for some of the data points mentioned
above. Meanwhile if you would like any additional data, please do let
me know. I'll also try to see if a dynamic limit for SIS_NODE_LIMIT
based on Chenyu's SIS_UTIL / ILB_UTIL [3] logic helps.

[3] https://lore.kernel.org/all/bc96b53efb712337a645e2c2a340975545ed5a28.1686554037.git.yu.c.chen@intel.com/

--
Thanks and Regards,
Prateek
