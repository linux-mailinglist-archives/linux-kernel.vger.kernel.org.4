Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161B869B334
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 20:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjBQTgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 14:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBQTgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 14:36:03 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895A810E5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 11:36:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KamSk5Bhyq0ZhMtGgCY6iE7DjFaUwOn2Ph2/BGM4c4s8qKEQCSNedJN8NO0k3mGdurqq657yQRoiKJQ0Cj1sKFldOfYx/uLhm/XIRKysKm3/pbMNgaQPWcUJQSBjP+A+ziUw43QRbSwUD9ogRRW/yKH47F0dQu+je8lz4ELkPwbhh+KyQ1mwM06Bi/Hslj6z9MzWrs+1RCC3OnTm5odkVer3DxhBdqWkx1qvW+1Fy17NPfUy7gCHbBMFLerrbMefXd8G8N4ipVVLzSVM9HiH+MzP2TpGYbfYq4kALG+xDg3sPChxjrtLXAo8OUQr5OQW+9YsX4nI3rLDt7jdw5mkKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mavLzKLTRiaCAPAreaOf8ECzC6m0Wrp2rhGUBSwvoPw=;
 b=Sl/xRBJfiz9daeejLuvSwDDr78Xq+JGYm0sDBE8skIWZU+/dEvwiAonoAXN7YExvgjX0nicBeZMN8Y5uA7P80V3bZi2WB8rrNSY1gQuZIaeeuFWBCg7JiJnSf3pcTgj1cTrfQYsQv9CS0fwuXCNaXiNw2NosNZeDXdS1T3sr4OH6eRLwc0SmvlmnSBMXim2hWF7Fv7TXWbY5wrVunBsiKfMC9tb0UbReqDmnYYlr1cCB7seFCXxaOVTai8QlJl9CzvA/LspwAMaqj7wdxyLQzof5r43cuZq2p+MS6izUUG0y0TRrIIo7BRdJiJSK9uWEumCDl2iBO0u7Bn0SoJC8ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mavLzKLTRiaCAPAreaOf8ECzC6m0Wrp2rhGUBSwvoPw=;
 b=fwzKLAjzVuYO+rxIO9ArYFVEzSrgME2LB1QsXUf89g7WiMItuQfH0onYVH1PHFknAtSVl2T+VNTk+PZVhX6xB3GB9kUKkjIDCZsCrB8+whb16dw89lOtcABZlZfJGNEtx5xYzmxIUd4kHMGfmTkxqWg90U5ZuyTNQdTrUioAisk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 19:35:57 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::f2f8:a2b0:8e91:de7]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::f2f8:a2b0:8e91:de7%7]) with mapi id 15.20.6111.012; Fri, 17 Feb 2023
 19:35:57 +0000
Message-ID: <53d53475-2720-cfbb-c567-563e900144ee@amd.com>
Date:   Sat, 18 Feb 2023 01:05:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v5 0/2] sched/fair: Wake short task on current CPU
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>, Abel Wu <wuyun.abel@bytedance.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, Hillf Danton <hdanton@sina.com>,
        linux-kernel@vger.kernel.org
References: <cover.1675361144.git.yu.c.chen@intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <cover.1675361144.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::34) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1becc5-6c6d-4406-e36c-08db111e3059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3FC8DZNODmjlAXgOzBuzrugDXiFJg4XEgjlpbmNcLPJxZBDsCBKpHpgRmq+76A2zUT6WWIhR3MT9jZQX/MegGiryAaQmaYRp5iMOTEg/rEX2gOkV0w/F8w06aPh+lOwKrNWBMQhEjeZozjhc5SskGw4jdS73/En46pDYAOM624ejmUnUNYTajpGI4lSLFQJbACOVl1nrdySzd7+mStwFdAZCtpm7NLXDbEw8RBuFw67M1l9ijXGcPHoocfzXFByAs2xzfpW96m8BYcg4BjhtOV36b1mRh5W8Hpof8PgMG64Tr1AJ3P3UJJtO5aUoGlfyStLjoMLEE1R+MI6vwz34ywxBR/k1btbWHsfKxwXJc1s7kOjHksNyXvqspqhxyOcebqejqrVe1vNb3RL/4+/2jb00O4DI4GhYg0ZaqJLRUjAXokvmJlvp442+lvDqpenfKoHy9c4c/jXMbl9NetU8HApfad4k5wRV8lq5GlxiD+REnlRDrErThRCdbvOY7Cqy1FdpVf/NRKqGM9J13/ntzTkq1cc90LwxTVhWr3tKCC8EoWGl4eziWwn3Z6DDmZ7LRLDJQNocC3UtKNuV23fpcdRF+LaVPlru28f+FaqxEHsxQ0tY1oyCAHjQTAdBnHdJJYczp2YiFkwENZU57L9a1tQa/QJuSxWzZ050IWYuzihKkDkqahsa1LCo6LIyNitwRJ4ScR7L/FWBnpithb+MKD7A1hPL23NrcBe/7c2INusvMGnq+ECRgBW/HOY66orG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199018)(6512007)(83380400001)(110136005)(86362001)(26005)(31696002)(36756003)(54906003)(31686004)(6506007)(2616005)(186003)(2906002)(30864003)(8676002)(66556008)(7416002)(8936002)(4326008)(41300700001)(66946007)(966005)(53546011)(6486002)(6666004)(478600001)(66476007)(5660300002)(316002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1RMZWRjSzU2Y0x1Yk44ZnQ0OGd6N3pYc0VCOHpyOTJkQ3d0NkhvWm4zRTl0?=
 =?utf-8?B?OTNldEtOVnFkSTJ5Y2plSVVvRFkyNEQxMXJoMkd6blFlenhFellRcU13bytT?=
 =?utf-8?B?SEowSXR1RUc3Z0x2cGExQ0E5L25XREc0OUxaZmt3V3RRQldPM3dYZkRncHho?=
 =?utf-8?B?WHBuWGlDTHYrSmJiVm01VlFjdERpM0NhY2RjRE55ZkZ6K1MydEdTWUN6Y2ow?=
 =?utf-8?B?UXJKVFByODNxcHpLVHUrRHFKeThYN1NlYWpxcFhmZTNmZjZkbTc1SzFEL1Vk?=
 =?utf-8?B?VzhwTW40QUdPSzhBZjdNTVp1dW9oZWx2bkQ4M094eHpxVjlJc1JFMWthQU9N?=
 =?utf-8?B?eUxNLzhjMFVoZWZxa3YxUHF1N2dqTEU0V0Y5RzQyUUlTNGd0Z0lONGVFNitT?=
 =?utf-8?B?Z2s5anAva0xnSUxNU1Q5Q001aUFEbkJYcWZUZnVtN1czVkQzMFpKTXhvYmNi?=
 =?utf-8?B?RmNqQWRreHk1VXRlenZ6WTFPV05BcGY4cGp0MkZkUCtCOGgzS1NiUStMaUhK?=
 =?utf-8?B?dklCaUlITXFQZ0FPOVFORVNmSDJxcE0vdWk2eW1aVzFpSHJLQ21VLzBsM2Ey?=
 =?utf-8?B?RzFKUHpaUmhVSlNJbnMyT2JqemJzaVlGNkxNVTNsYzN6RWMzNWpGTmtYVWJF?=
 =?utf-8?B?QUVaSHdvbDl6U0x1bHZPRU85dzVyMU41TCtETmJXNXBmcnp3SHBFKzY2Q1dF?=
 =?utf-8?B?bTFHcUtYN0ZvVlNqdDdYSlZySEZMUkJOWm10OTFSWkp1cStxNXJOaGovREZD?=
 =?utf-8?B?aVFWclBhR0xpWjVvbGJmcE5reDFRQUxlVDlrdGFjaTU2cmVFVnBRNDVDNWs3?=
 =?utf-8?B?T2hMVDkwSkxETThTTk9rTVpvTDFnWElkRzZaOTd1czJpS1N6QkUwZWhDZkVF?=
 =?utf-8?B?M3FONXMrNFh1TVUveTBoam5GdVI0MWJYdmRlWXMrRXZvTzFxVGRpYjE1OGkv?=
 =?utf-8?B?SG53RGtXcllSWW5RNXdFUUw0UFlKQmxFSitkdlZiSXV3bisrb0pMZnJncjVZ?=
 =?utf-8?B?RUNrU1ZHRmxVVkNQRXRCOTdGT1lHZWE4K1Bpa1phbjM2aVp4clJwV0p3akt2?=
 =?utf-8?B?c0xGdndlWGJPb1lmeVgrTDZ6T0lTVHpPMWdyckY3ckRUU2pCSE1jVis3a0pG?=
 =?utf-8?B?ZXU3ZnJFNEtmVGtZbHI4cGh2ZloyUHhMVnAzaVlWTWpzTVI0d1A3S0lObC82?=
 =?utf-8?B?VEl3RXBxZUE4U0ZHLzI3bmVYOUJVSUZIRFhaS2ZTWWtYSElvTnBHZWtNVVZB?=
 =?utf-8?B?MGpwWW44YmJtMmVPaVdGdXJScVNnTUppWGEyUTMvbVp4eU94SFhjSEcxUm5w?=
 =?utf-8?B?VGp6dTAzRWxSMllhSlFRSmVpUmdaZFdLdXVFclRiUmZQaHlBWTM0NlU5VG5U?=
 =?utf-8?B?SFRvRy9DZ0YzUG1oTkQzUEp5c2hDbEdMM2NkalYvZHFTWEduVEZCVlhjdC9U?=
 =?utf-8?B?eWtKYlpFMTdRWDZtTVVxa1U3SXNNSHN3aFMzRlZpckNmbHdEdEtRYlJPZ1Bs?=
 =?utf-8?B?ZEJKSUZRaWQ2YkFQQTJLaGZVQ3BveWF1dUZpb2FZWWRaSkFYQU00OWVTY2RN?=
 =?utf-8?B?VTNtT0t1aG9ZTngzcVQrWEIxUkR4YmhaV1FIMlF3MXp5QzBacnF2Qk02SjZ5?=
 =?utf-8?B?QlRzcVBHQ2xDL0c1QzBleDVLWVMxa2dENE9nK01YN2hQKzFEUFdKM0ZQYnBF?=
 =?utf-8?B?c0svOXhhSUVFOXVybTRhWmdnLzdLaVlwRVhqd3FhQzRNY0p3OHdOSzRZdUxN?=
 =?utf-8?B?RFpwcktmcXVieEFYdDl2bUZpRmdOa0g5SUNhOVQxemtiM2wybHZ0ZzlCNVhY?=
 =?utf-8?B?WTJvZERDQU9FMnFsQ2ZOajEwdUgxUFhjV0FWQ1RBbTFHUHo4K3VnVnlVRDhJ?=
 =?utf-8?B?K0llSlArMHhrajNkQkFzVDQ4alhESURuUS9kR1Yya1VZR0xWeVFyOENnMGsr?=
 =?utf-8?B?MmMwM2tGNVl6WStub0g0U1FLWVBrckwyVmZBdWVySGxjbXBXZ0lrb295TW5r?=
 =?utf-8?B?RnMrY2daajh4Mkx3TXAzc3FRWHprNVkvZU43U1p0clVseWliQVhOMmhVZi9r?=
 =?utf-8?B?eWxvT1VtdzRXd0RtNnpNYnY3bFBiV3RjZ2FYL3B3bStlQXMrYmZkcHJOQzZN?=
 =?utf-8?Q?zq9j1N1JMhgdM4OoV2C5wx4ZC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1becc5-6c6d-4406-e36c-08db111e3059
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 19:35:56.8757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CFRzgPJW8xcajPLtaLT12U2A9DHU7afNAdLS4CBGqR5uoU2hoVGcUcCxPdldM3SkUhpDxJCSGXF2J4XkXnDkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu and Abel,

I'll leave the detailed results from testing on a dual socket Zen3 system
(2 x 64C/128T) below.

tl;dr

o Most benchmark results see small wins or are comparable to tip.
o SpecJBB Max-jOPS see a small hit but Critical-jOPS improve.
o ycsb-mongodb sees small uplift in NPS1 mode.
o Numbers for Netperf runs are pending which I'll share in the
  coming week.
o Abel's suggestion on top of v5 seem promising but there are
  few regressions I notice on larger workloads.

Detailed Results:

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
- tip:          6.2.0-rc6 tip sched/core
- sis_short: 	6.2.0-rc6 tip sched/core + this series

When the testing started, the tip was at:
commit 4d627628d758 "cpuidle: Fix poll_idle() noinstr annotation"

~~~~~~~~~~~~~
~ hackbench ~
~~~~~~~~~~~~~

o NPS1

Test:			tip			sis_short
 1-groups:	   4.38 (0.00 pct)	   4.49 (-2.51 pct)
 2-groups:	   5.12 (0.00 pct)	   5.20 (-1.56 pct)
 4-groups:	   4.21 (0.00 pct)	   4.24 (-0.71 pct)
 8-groups:	   4.68 (0.00 pct)	   4.73 (-1.06 pct)
16-groups:	   6.13 (0.00 pct)	   6.35 (-3.58 pct)

o NPS2

Test:			tip			sis_short
 1-groups:	   4.51 (0.00 pct)	   4.36 (3.32 pct)
 2-groups:	   4.31 (0.00 pct)	   4.35 (0.92 pct)
 4-groups:	   4.17 (0.00 pct)	   4.08 (2.15 pct)
 8-groups:	   4.58 (0.00 pct)	   4.49 (1.96 pct)
16-groups:	   5.74 (0.00 pct)	   5.93 (-3.31 pct)

o NPS4

Test:			tip			sis_short
 1-groups:	   4.47 (0.00 pct)	   4.51 (-0.89 pct)
 2-groups:	   4.97 (0.00 pct)	   5.04 (-1.40 pct)
 4-groups:	   4.26 (0.00 pct)	   4.28 (-0.46 pct)
 8-groups:	   5.46 (0.00 pct)	   5.56 (-1.83 pct)
16-groups:	   6.38 (0.00 pct)	   6.10 (4.38 pct)

~~~~~~~~~~~~
~ schbench ~
~~~~~~~~~~~~

o NPS1

#workers:	tip			sis_short
  1:	  36.00 (0.00 pct)	  27.00 (25.00 pct)
  2:	  37.00 (0.00 pct)	  32.00 (13.51 pct)
  4:	  41.00 (0.00 pct)	  34.00 (17.07 pct)
  8:	  46.00 (0.00 pct)	  43.00 (6.52 pct)
 16:	  66.00 (0.00 pct)	  66.00 (0.00 pct)
 32:	 111.00 (0.00 pct)	 108.00 (2.70 pct)
 64:	 207.00 (0.00 pct)	 206.00 (0.48 pct)
128:	 483.00 (0.00 pct)	 481.00 (0.41 pct)
256:	 46272.00 (0.00 pct)	 45120.00 (2.48 pct)
512:	 76160.00 (0.00 pct)	 77696.00 (-2.01 pct)

o NPS2

#workers:	tip			sis_short
  1:	  33.00 (0.00 pct)	  31.00 (6.06 pct)
  2:	  35.00 (0.00 pct)	  31.00 (11.42 pct)
  4:	  38.00 (0.00 pct)	  38.00 (0.00 pct)
  8:	  51.00 (0.00 pct)	  47.00 (7.84 pct)
 16:	  64.00 (0.00 pct)	  67.00 (-4.68 pct)
 32:	 118.00 (0.00 pct)	 116.00 (1.69 pct)
 64:	 214.00 (0.00 pct)	 217.00 (-1.40 pct)
128:	 497.00 (0.00 pct)	 504.00 (-1.40 pct)
256:	 45632.00 (0.00 pct)	 44352.00 (2.80 pct)
512:	 81024.00 (0.00 pct)	 78464.00 (3.15 pct)

o NPS4

#workers:	tip			sis_short
  1:	  33.00 (0.00 pct)	  32.00 (3.03 pct)
  2:	  40.00 (0.00 pct)	  32.00 (20.00 pct)
  4:	  42.00 (0.00 pct)	  38.00 (9.52 pct)
  8:	  64.00 (0.00 pct)	  65.00 (-1.56 pct)
 16:	  73.00 (0.00 pct)	  69.00 (5.47 pct)
 32:	 112.00 (0.00 pct)	 112.00 (0.00 pct)
 64:	 215.00 (0.00 pct)	 207.00 (3.72 pct)
128:	 615.00 (0.00 pct)	 593.00 (3.73 pct)
256:	 46144.00 (0.00 pct)	 45376.00 (1.66 pct)
512:	 78208.00 (0.00 pct)	 77696.00 (0.65 pct)


~~~~~~~~~~
~ tbench ~
~~~~~~~~~~

o NPS1

Clients:	tip			sis_short
    1	 536.78 (0.00 pct)	 537.38 (0.11 pct)
    2	 1050.74 (0.00 pct)	 1058.74 (0.76 pct)
    4	 1993.47 (0.00 pct)	 1976.79 (-0.83 pct)
    8	 3498.02 (0.00 pct)	 3657.16 (4.54 pct)
   16	 6202.01 (0.00 pct)	 6014.62 (-3.02 pct)
   32	 11544.55 (0.00 pct)	 11847.47 (2.62 pct)
   64	 21828.75 (0.00 pct)	 21754.85 (-0.33 pct)
  128	 31095.92 (0.00 pct)	 31643.35 (1.76 pct)
  256	 54828.12 (0.00 pct)	 55432.29 (1.10 pct)
  512	 54888.10 (0.00 pct)	 55917.91 (1.87 pct)
 1024	 54916.75 (0.00 pct)	 53468.79 (-2.63 pct)

o NPS2

Clients:	tip			sis_short
    1	 543.08 (0.00 pct)	 544.49 (0.25 pct)
    2	 1074.55 (0.00 pct)	 1060.33 (-1.32 pct)
    4	 1980.75 (0.00 pct)	 1992.86 (0.61 pct)
    8	 3628.36 (0.00 pct)	 3507.73 (-3.32 pct)
   16	 5806.00 (0.00 pct)	 5790.82 (-0.26 pct)
   32	 11351.94 (0.00 pct)	 10937.21 (-3.26 pct)
   64	 19987.40 (0.00 pct)	 20739.38 (3.76 pct)
  128	 29554.40 (0.00 pct)	 30011.99 (1.54 pct)
  256	 53594.11 (0.00 pct)	 51473.78 (-3.95 pct)
  512	 54304.03 (0.00 pct)	 52998.31 (-2.40 pct)
 1024	 54338.25 (0.00 pct)	 53265.51 (-1.97 pct)

o NPS4

Clients:	tip			sis_short
    1	 541.29 (0.00 pct)	 536.21 (-0.93 pct)
    2	 1045.15 (0.00 pct)	 1054.94 (0.93 pct)
    4	 1973.01 (0.00 pct)	 1988.63 (0.79 pct)
    8	 3490.55 (0.00 pct)	 3535.27 (1.28 pct)
   16	 5920.12 (0.00 pct)	 5846.04 (-1.25 pct)
   32	 10933.38 (0.00 pct)	 10944.33 (0.10pct)
   64	 19628.34 (0.00 pct)	 19328.66 (1.01 pct)
  128	 29785.23 (0.00 pct)	 28749.48 (-4.55 pct)
  256	 51999.72 (0.00 pct)	 51336.20 (-1.27 pct)
  512	 53619.42 (0.00 pct)	 53269.04 (-0.65 pct)
 1024	 53956.57 (0.00 pct)	 53666.14 (-0.53 pct)


~~~~~~~~~~
~ stream ~
~~~~~~~~~~

o NPS1

10 Runs:

Test:		tip			sis_short
 Copy:	 320576.16 (0.00 pct)	 328194.56 (2.37 pct)
Scale:	 212869.80 (0.00 pct)	 216713.96 (1.80 pct)
  Add:	 241556.74 (0.00 pct)	 247467.26 (2.44 pct)
Triad:	 250637.58 (0.00 pct)	 245538.49 (-2.03 pct)

100 Runs:

Test:		tip			sis_short
 Copy:	 330058.38 (0.00 pct)	 329339.60 (-0.21 pct)
Scale:	 216475.85 (0.00 pct)	 219334.10 (1.32 pct)
  Add:	 243028.82 (0.00 pct)	 244037.77 (0.41 pct)
Triad:	 252907.98 (0.00 pct)	 257210.37 (1.70 pct)

o NPS2

10 Runs:

Test:		tip			sis_short
 Copy:	 339946.34 (0.00 pct)	 327261.79 (-3.73 pct)
Scale:	 217453.46 (0.00 pct)	 221366.66 (1.79 pct)
  Add:	 258099.63 (0.00 pct)	 258472.44 (0.14 pct)
Triad:	 264974.76 (0.00 pct)	 262618.99 (-0.88 pct)

100 Runs:

Test:		tip			sis_short
 Copy:	 335725.30 (0.00 pct)	 320797.67 (-4.44 pct)
Scale:	 229985.45 (0.00 pct)	 221706.62 (-3.59 pct)
  Add:	 260546.33 (0.00 pct)	 250668.80 (-3.79 pct)
Triad:	 267925.27 (0.00 pct)	 262959.86 (-1.85 pct)

o NPS4

10 Runs:

Test:		tip			sis_short
 Copy:   369037.34 (0.00 pct)    371514.46 (0.67 pct)
Scale:   238235.39 (0.00 pct)    237661.29 (-0.24 pct)
  Add:   263626.48 (0.00 pct)    263436.20 (-0.07 pct)
Triad:   280881.43 (0.00 pct)    288059.52 (2.55 pct)

100 Runs:

Test:		tip			sis_short
 Copy:	 339036.66 (0.00 pct)	 346904.09 (2.32 pct)
Scale:	 246638.02 (0.00 pct)	 230195.65 (-6.66 pct)
  Add:	 259898.86 (0.00 pct)	 244631.77 (-5.87 pct)
Triad:	 265719.02 (0.00 pct)	 264620.50 (-0.41 pct)

~~~~~~~~~~~~~~~~
~ ycsb-mongodb ~
~~~~~~~~~~~~~~~~

o NPS1:

tip		:	133514.00  (var: 2.07%)
sis-short	:	137664.67  (var: 1.45%)  (3.11%)

o NPS2:

tip		:	132193.33  (var: 1.46%)
sis-short	:	131189.33  (var: 1.69%)	(-0.75%)

o NPS4:

tip		:	133285.67  (var: 1.77%)
sis-short	:	133891.33  (var: 1.58%)  (0.45%)

~~~~~~~~~~~~~
~ unixbench ~
~~~~~~~~~~~~~

o NPS1

Test			Metric	  Parallelism			tip		      sis_short
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      48665321.00 (   0.00%)    48553432.30 (  -0.23%)
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6281376826.80 (   0.00%)  6277335150.50 (  -0.06%)
unixbench-syscall       Amean     unixbench-syscall-1        2689026.67 (   0.00%)     2682044.73 *   0.26%*
unixbench-syscall       Amean     unixbench-syscall-512      7352453.23 (   0.00%)     7290524.47 *  -0.84%*
unixbench-pipe          Hmean     unixbench-pipe-1           2467955.46 (   0.00%)     2426076.17 *  -1.70%*
unixbench-pipe          Hmean     unixbench-pipe-512       295937232.39 (   0.00%)   293462420.03 *  -0.84%*
unixbench-spawn         Hmean     unixbench-spawn-1             4164.75 (   0.00%)        4229.59 (   1.56%)
unixbench-spawn         Hmean     unixbench-spawn-512          79950.80 (   0.00%)       76439.30 (  -4.39%)
unixbench-execl         Hmean     unixbench-execl-1             4112.25 (   0.00%)        4151.37 (   0.95%)
unixbench-execl         Hmean     unixbench-execl-512          11785.88 (   0.00%)       11756.46 (  -0.25%)

o NPS2

Test			Metric	  Parallelism			tip		      sis_short
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      49671827.09 (   0.00%)    49077076.00 (  -1.20%)
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6282239821.90 (   0.00%)  6283671307.30 (   0.02%)
unixbench-syscall       Amean     unixbench-syscall-1        2688504.20 (   0.00%)     2676278.60 *   0.45%*
unixbench-syscall       Amean     unixbench-syscall-512      7321621.07 (   0.00%)     7784926.60 *   6.33%*
unixbench-pipe          Hmean     unixbench-pipe-1           2469941.97 (   0.00%)     2419584.09 *  -2.04%*
unixbench-pipe          Hmean     unixbench-pipe-512       296146392.10 (   0.00%)   293156913.86 *  -1.01%*
unixbench-spawn         Hmean     unixbench-spawn-1             5029.05 (   0.00%)        5015.18 (  -0.28%)
unixbench-spawn         Hmean     unixbench-spawn-512          77198.79 (   0.00%)       80409.23 *   4.16%*
unixbench-execl         Hmean     unixbench-execl-1             4092.59 (   0.00%)        4158.36 *   1.61%*
unixbench-execl         Hmean     unixbench-execl-512          12293.67 (   0.00%)       12169.31 (  -1.01%)

o NPS4

Test			Metric	  Parallelism			tip		      sis_short
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      48944542.05 (   0.00%)    49490899.03 *   1.12%*
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6291259625.50 (   0.00%)  6299305899.90 (   0.13%)
unixbench-syscall       Amean     unixbench-syscall-1        2686991.73 (   0.00%)     2682940.53 *   0.15%*
unixbench-syscall       Amean     unixbench-syscall-512      7902201.47 (   0.00%)     7931906.47 (  -0.38%)
unixbench-pipe          Hmean     unixbench-pipe-1           2468813.43 (   0.00%)     2422272.88 *  -1.89%*
unixbench-pipe          Hmean     unixbench-pipe-512       297109244.52 (   0.00%)   294589928.27 *  -0.85%*
unixbench-spawn         Hmean     unixbench-spawn-1             5161.67 (   0.00%)        5012.58 (  -2.89%)
unixbench-spawn         Hmean     unixbench-spawn-512          78657.60 (   0.00%)       78572.80 (  -0.11%)
unixbench-execl         Hmean     unixbench-execl-1             4112.02 (   0.00%)        4122.16 (   0.25%)
unixbench-execl         Hmean     unixbench-execl-512          13700.99 (   0.00%)       14173.20 *   3.44%*

~~~~~~~~~~~
~ SpecJBB ~
~~~~~~~~~~~

o NPS1 - Normalized to baseline (tip)

Kernel			 tip		sis_short
Max-jOPS		100%		 98.53%
Critical-jOPS		100%		105.61%

~~~~~~~~~~~~~~~~~~
~ DeathStarBench ~
~~~~~~~~~~~~~~~~~~

o NPS1 - Normalized to baseline (tip)

Kernel		:	  tip		sis_short
8C/16T		:	100.00%		 100.54%
16C/32T		:	100.00%		 100.19%
32C/64T		:	100.00%		  98.08%
64C/128T	:	100.00%		  98.34% 


--------------- With Abel's suggestion added to v5 ---------------

I've added the hunk suggested by Abel in the thread to the v5 and
following are results for the same set of benchmarks but only for
machine running in NPS1 mode.

sis_short_v5.1: 6.2.0-rc6 tip sched/core + this series + Abel's suggestion

~~~~~~~~~~~~~
~ hackbench ~
~~~~~~~~~~~~~

o NPS1

Test:			tip		   sis_short_v5.1
 1-groups:	   4.38 (0.00 pct)	   4.08 (6.84 pct)
 2-groups:	   5.12 (0.00 pct)	   5.10 (0.39 pct)
 4-groups:	   4.21 (0.00 pct)	   4.23 (-0.47 pct)
 8-groups:	   4.68 (0.00 pct)	   4.69 (-0.21 pct)
16-groups:	   6.13 (0.00 pct)	   5.94 (3.09 pct)

~~~~~~~~~~~~
~ schbench ~
~~~~~~~~~~~~

o NPS1

#workers:	tip		   sis_short_v5.1
  1:	  36.00 (0.00 pct)	  36.00 (0.00 pct)
  2:	  37.00 (0.00 pct)	  39.00 (-5.40 pct)
  4:	  41.00 (0.00 pct)	  40.00 (2.43 pct)
  8:	  46.00 (0.00 pct)	  46.00 (0.00 pct)
 16:	  66.00 (0.00 pct)	  68.00 (-3.03 pct)
 32:	 111.00 (0.00 pct)	 112.00 (-0.90 pct)
 64:	 207.00 (0.00 pct)	 238.00 (-14.97 pct)
 64:	 227.00 (0.00 pct)	 219.00 (3.52 pct)
128:	 483.00 (0.00 pct)	 494.00 (-2.27 pct)
256:	 46272.00 (0.00 pct)	 41280.00 (10.78 pct)
512:	 78293.00 (0.00 pct)	 79325.00 (-1.31 pct)

~~~~~~~~~~
~ tbench ~
~~~~~~~~~~

o NPS1

Clients:	tip		   sis_short_v5.1
    1	 536.78 (0.00 pct)	 535.90 (-0.16 pct)
    2	 1050.74 (0.00 pct)	 1067.32 (1.57 pct)
    4	 1993.47 (0.00 pct)	 1971.63 (-1.09 pct)
    8	 3601.77 (0.00 pct)	 3599.17 (-0.07 pct)
   16	 6202.01 (0.00 pct)	 6115.08 (-1.40 pct)
   32	 11544.55 (0.00 pct)	 11423.52 (-1.04 pct)
   64	 21828.75 (0.00 pct)	 21403.94 (-1.94 pct)
  128	 31095.92 (0.00 pct)	 30783.55 (-1.00 pct)
  256	 54828.12 (0.00 pct)	 55328.94 (0.91 pct)
  512	 54888.10 (0.00 pct)	 53483.33 (-2.55 pct)
 1024	 48407.14 (0.00 pct)	 48998.95 (1.22 pct)

~~~~~~~~~~
~ stream ~
~~~~~~~~~~

o NPS1

10 Runs:

Test:		tip		   sis_short_v5.1
 Copy:	 320576.16 (0.00 pct)	 331810.14 (3.50 pct)
Scale:	 212869.80 (0.00 pct)	 214725.82 (0.87 pct)
  Add:	 241556.74 (0.00 pct)	 242340.92 (0.32 pct)
Triad:	 250637.58 (0.00 pct)	 251271.53 (0.25 pct)

100 Runs:

Test:		tip		   sis_short_v5.1
 Copy:	 330058.38 (0.00 pct)	 331966.60 (0.57 pct)
Scale:	 216475.85 (0.00 pct)	 222777.84 (2.91 pct)
  Add:	 243028.82 (0.00 pct)	 250873.78 (3.22 pct)
Triad:	 252907.98 (0.00 pct)	 253791.20 (0.34 pct)

~~~~~~~~~~~~~~~~
~ ycsb-mongodb ~
~~~~~~~~~~~~~~~~

o NPS1:

tip		:	133514.00  (var: 2.07%)
sis-short_v5.1	:	129172.67  (var: 2.32%)  (-3.25%)  **

~~~~~~~~~~~~~
~ unixbench ~
~~~~~~~~~~~~~

o NPS1

Test			Metric	  Parallelism			tip		      sis_short_v5.1
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      49266026.90 (   0.00%)    49054799.90 (  -0.43%)
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6285063007.68 (   0.00%)  6280424934.15 (  -0.07%)
unixbench-syscall       Amean     unixbench-syscall-1        2689026.67 (   0.00%)     2677968.03 *   0.41%*
unixbench-syscall       Amean     unixbench-syscall-512      7352453.23 (   0.00%)     7354325.40 (  -0.03%)
unixbench-pipe          Hmean     unixbench-pipe-1           2467955.46 (   0.00%)     2351117.60 *  -4.73%*
unixbench-pipe          Hmean     unixbench-pipe-512       295937232.39 (   0.00%)   295769918.99 (  -0.06%)
unixbench-spawn         Hmean     unixbench-spawn-1             4164.75 (   0.00%)        4331.89 *   4.01%*
unixbench-spawn         Hmean     unixbench-spawn-512          79626.61 (   0.00%)       77865.32 *  -2.21%*
unixbench-execl         Hmean     unixbench-execl-1             4112.25 (   0.00%)        4145.85 (   0.82%)
unixbench-execl         Hmean     unixbench-execl-512          11785.88 (   0.00%)       11935.41 (   1.27%)

~~~~~~~~~~~
~ SpecJBB ~
~~~~~~~~~~~

o NPS1 - Normalized to baseline (tip)

Kernel			 tip	     sis_short_V5.1
Max-jOPS		100%		 91.99%  ** (-8.01%)
Critical-jOPS		100%		 99.29%

~~~~~~~~~~~~~~~~~~
~ DeathStarBench ~
~~~~~~~~~~~~~~~~~~

o NPS1 - Throughput normalized to baseline (tip)

Kernel		:	  tip	      sis_short_V5.1
8C/16T		:	100.00%		  93.75%  ** (-6.25%)
16C/32T		:	100.00%		 100.43%
32C/64T		:	100.00%		 101.12%
64C/128T	:	100.00%		 100.21%

o Follow wake_affine_bias() if waker's cpu and prev_cpu are on same LLC?

There are cases with Abel's suggestion where some of the larger
benchmark regresses. I wonder if wake_affine_bias() can still be
considered for short running tasks if the waker's CPU and the
prev_cpu share caches. In DeathStarBench 8C/16T case, the
services are all pinned to the CPUs of same MC domain. The
regression observed seems to arise from the missed opportunity
to distribute load among the CPUs sharing the same L3. I do not
have data for this currently but I'll update the thread with any
findings.

I'll also queue up a Redis run from mmtest to see if I can reproduce
Abel's observations on my system however I'm not sure if the
utilization will be high enough to emulate the same scenario as
Abel's prod environment. If the migrations within the same MC 

On 2/3/2023 10:47 AM, Chen Yu wrote:
> The main purpose is to avoid too many cross CPU wake up when it is
> unnecessary. The frequent cross CPU wake up brings significant damage
> to some workloads, especially on high core count systems.
> 
> Inhibits the cross CPU wake-up by placing the wakee on waking CPU,
> if both the waker and wakee are short-duration tasks. The short
> duration task could become a trouble maker on high-load system,
> because it could bring frequent context switch. So this strategy
> only takes effect when the system is busy.  Besides, it is unreasonable
> to inhibit the idle CPU scan when there are still idle CPUs.
> 
> First, introduce the definition of a short-duration task. Then
> leverages the first patch to choose a local CPU for wakee.
> 
> Overall there is significant performance improvement on Intel
> 2 x 56C/112T platform.  Such as will-it-scale (1200+%),
> netperf(600+%) in some cases. And no noticeable impact on
> schbench, hackbench, tbench and a OLTP workload with a commercial RDBMS.
> 
> Seeking for test results on other platforms, such as Zen3 and Kunpeng
> Arm64. Appreciated Prateek and Yicong if you can have a try on this
> version.
> 
> Changes since v4:
> 1. Dietmar has commented on the task duration calculation. So refined
>    the commit log to reduce confusion.
> 2. Change [PATCH 1/2] to only record the average duration of a task.
>    So this change could benefit UTIL_EST_FASTER[1].
> 3. As v4 reported regression on Zen3 and Kunpeng Arm64, add back
>    the system average utilization restriction that, if the system
>    is not busy, do not enable the short wake up. Above logic has
>    shown improvment on Zen3[2].
> 4. Restrict the wakeup target to be current CPU, rather than both
>    current CPU and task's previous CPU. This could also benefit
>    wakeup optimization from interrupt in the future, which is
>    suggested by Yicong.
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
>    to select_idle_siblings(), because there is no CPU scan involved, per
>    Yicong.
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
> 
> [1] https://lore.kernel.org/lkml/c56855a7-14fd-4737-fc8b-8ea21487c5f6@arm.com/
> [2] https://lore.kernel.org/all/cover.1666531576.git.yu.c.chen@intel.com/
> 
> v4: https://lore.kernel.org/lkml/cover.1671158588.git.yu.c.chen@intel.com/
> v3: https://lore.kernel.org/lkml/cover.1669862147.git.yu.c.chen@intel.com/
> v2: https://lore.kernel.org/all/cover.1666531576.git.yu.c.chen@intel.com/
> v1: https://lore.kernel.org/lkml/20220915165407.1776363-1-yu.c.chen@intel.com/
> 
> Chen Yu (2):
>   sched/fair: Record the average duration of a task
>   sched/fair: Introduce SIS_SHORT to wake up short task on current CPU
> 
>  include/linux/sched.h   |  3 +++
>  kernel/sched/core.c     |  2 ++
>  kernel/sched/debug.c    |  1 +
>  kernel/sched/fair.c     | 39 +++++++++++++++++++++++++++++++++++++++
>  kernel/sched/features.h |  1 +
>  5 files changed, 46 insertions(+)
> 

The netperf results are still pending and I'll update the thread
with the same in the coming week. If you would like me to test
or gather some data for specific workload on the test system,
please do let me know.
--
Thanks and Regards,
Prateek
