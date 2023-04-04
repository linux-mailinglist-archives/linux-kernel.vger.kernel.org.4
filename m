Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33E16D5AE7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbjDDI1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjDDI1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:27:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2511FEA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 01:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680596785; x=1712132785;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JeH6EePPOixkZw/uLEkmwzjhQXoU1ShYzTkzFHQrkys=;
  b=fOlbMaHj8XWVhxoPJ9m0Emrqp45mQc6MfRQ2WsMGYXrKCcP2jO4vjJ93
   8lMP0pBUop8AVC/vcTjBERLIWgme/Z3e8gvn96KakUMjk1vt/J0Stwro5
   Oh6fFIyDbrzxF/P/01gtkAnTevUlPrL2rKRP0Oi0lWtmF1/7fxw/DSNHr
   wE7XqXBfEahm8iVc8bjmLIFash+rfA3kdPZmJkPlnGqba2rG9dS6FAR/x
   tb5c8l7EIYzL9A5Y2HK5wucsyKj8j0K5fidMk/kwdIwDpG0LW/FcgBrhI
   lV20GbMb+6dFDt5RRjB4zttutEV/MeqjWvrtYF6PzG6om31i6eazMXftw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="322516773"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="322516773"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 01:25:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="688802888"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="688802888"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 04 Apr 2023 01:25:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 01:25:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 01:25:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 01:25:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 01:25:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnUjk4tNxOPf8xEv4qG5edyVounF6OqgvKeuqQadQu9B1+hrICLHQVXpP3cNS7ygsE5bKQn1DvCyLmgmw+SAsJ4xyMBJSIv9nw7M7l2v4gLAFURgeGzwEfpKvko3OlVMifGB7IrlwFbLORFVpIdQ9irxn4T/kJYmM6fz6lMNLyfTxFpf/A9f60Tdp2NwCxF2Or/uyR0XvwcpmfWxTgEje71BI31J/P7CjM1n8RX96p0ErAQUDDaZIYrnuxAqDxT2buEtnwa90u2P11/s4rkmHYE35WNVKM8dgIJs1kdqjafHu5fldRTZy/0/Gu2YbqklpDZFcwYKQxVqgV7aztFzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4wbMBlSMGP9AINVtPv38lN7VF5ArzQ7PsRUHEfdbLc=;
 b=NBdugJlfExvesn+4+V67xRHHuFrS0AbFb+NHDJdIIBG+4/UODM0UWAlJeprExRtOmFs0Hd7F0iKV4ilQY5Zf6zbzZfaL9DS36eAle8jsu3j2R0PVjuEP1OYH6VaiT4x9PZWKm/KbF7oYuNbfvum7vPdEcp/BQOOIO9w+7zcXQ4wwVWY+ASpU6JM9U6yazpFUWEI0KEbcI9cnqOEJZpIgW9i0e4bnX94k1XMbWbj1Hb6KRUiNzXf7g2lrybSO/NkCzcDeqPJ4npyfvd0NqC2is4MFpkvN9du3a/gwbP/klRaR5d1Sb8GSYCo51cD1pvepqiu8j9Ym7LO9pfOtGfEt/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Tue, 4 Apr 2023 08:25:34 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 08:25:33 +0000
Date:   Tue, 4 Apr 2023 16:25:04 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Aaron Lu <aaron.lu@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <ZCve4JaH8EhxBcwQ@chenyu5-mobl1>
References: <20230327053955.GA570404@ziqianlu-desk2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230327053955.GA570404@ziqianlu-desk2>
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DM8PR11MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 23878ab0-e729-47f1-c4bd-08db34e628d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4jzrH8xeKgkHyBnnVfZX4nQjcynVkhCV/0NgCnsAS+OfIusQDF3+aybb7la6FNw7M2gd9DrsD6oGMoUbOb8oNy0IUQXFPmNoPqUNbtkxA4LJrLCFPIHqBLxTSQLKNK6JLMUE+45kUpknGGIkpkrywFcyB4k3iktvVtC+MZXzOHXzXCipAer9Vr40IKUiqIqAKINhh1qOtmkNM0e8fReq6RDjnTk7+UYw8NYNnX1YSrUjFlcfa1Vu+hkQHdWNkcPVLuguek+vKXQVHWcM7gdj05ZbQlFJEr94iuhVbSpuN+n8x8tzOfhROQJbOWYP4gfADokr9fWlfF44/TiV7lS70P9kY9HvNacCNOhqTh2gKyL1b7rNCeTjNUAxm0ynxNEPigSJXJRzForVK3u9MO+qpZVTXwyYrqsta60CVCUtxunLaVmO0gIXA585qQB2g23NeQ9AhWOEXkYf7QbXZYuGhf3pJYjHnGw3GvyUe56Ik5nHWab8lN4eNZ3TS3G7Boe5xe0tL3LlfOUGgpttY2lMD4JZgN5DhpyVSMW1a+Mcrz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199021)(6486002)(966005)(82960400001)(6512007)(53546011)(83380400001)(9686003)(6506007)(38100700002)(6666004)(186003)(26005)(2906002)(8936002)(5660300002)(6862004)(7416002)(478600001)(6636002)(54906003)(66476007)(4326008)(66556008)(66946007)(41300700001)(8676002)(316002)(86362001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FdPyKnQBq9PLbq9AaMcGmUfIKfqKQ0NCPNspnQsUb57Ya1ndQrXdTWGFVzdI?=
 =?us-ascii?Q?iN3AnvoQS6dzn5nvWqb6+gzhXSz4LYS8UbZwPC8/uvyhXKOlFpLbkboC4GjW?=
 =?us-ascii?Q?W0bdNVOcJcUULrv3BQXq/XJkyO8li2dS0x+0wZLHE2kVkjmTMzTohBRvtb4b?=
 =?us-ascii?Q?khpyjRAo8q7CCRKKNcz90yInunn+E/ALo4urIQP1wm5eJ/NljeJGWcdngdYU?=
 =?us-ascii?Q?w8ozc9USFIdogN1p3lt8tyL+FB/AjkgoNTtvxNnJ8OGCfP806vgWnVHOCfRP?=
 =?us-ascii?Q?EWOUmTBEi0iaXzOY8OGlKLCgn83D82acRXZ/chdGH5bbjqAoX4mRQ+wG3cJG?=
 =?us-ascii?Q?ml0NWZoc2J/9lp+87/YbEilN+O3ZPrl2AHXjFjLA3cRu8/YS6OxX9RsjOE4Q?=
 =?us-ascii?Q?qwvr6yHkhJJXb+VND/Of3yi75ILURQPTAmk+3YJK2kxQVl//ITKIAAkKe6MO?=
 =?us-ascii?Q?w/78eYxdzx3Lu36wj4PbB3npgTpY4LAqe74FXpcY50OmDB+v3sD7Up61PtzQ?=
 =?us-ascii?Q?kJWL/NXQN59XIs0SNbIyPUkKYUkinqSE94WScURo0UGPOQn5/jKfO/ZQQMGl?=
 =?us-ascii?Q?ZQ6XqmTQzOtJdOxjJkBv4ID54XF92y0ntXRPSchuTJzHyKV1ca2A2KZML9Oo?=
 =?us-ascii?Q?XxHsaAL6edju8dA8wgjQF2uoKWUJ03OZ1PahsV8LoFljCh+hy+Gd9caCr502?=
 =?us-ascii?Q?g0lyl8EK1chhAa2cj0ySJjRP3/jSnYvAxKpz02QDMY7QdLM6fn36JZj11JE4?=
 =?us-ascii?Q?NnZC6iPaR7rrspcT0AP0rPwvouqEma0/mX5ZGrE6CYb4bnamv/Y8cZum/vGV?=
 =?us-ascii?Q?XYplhLfptNaoEjOYwQ4lLoYnUCJ5t6XLCacisHvuc6Iirn0FGRBTqrIVYZ2D?=
 =?us-ascii?Q?9k7b/a8JGXUXpJAw3H4GPVHwe/TMGQMp1MH94CuyzrnJ8kLiuPGLDi1m/yOu?=
 =?us-ascii?Q?KOOvNhXOiLPCCOJAXlW4nY+WDQ7PNhjhH0sEirbm7NmxCaqeN4TlwYi4bL8i?=
 =?us-ascii?Q?0h1alqaoSYsxH5YcnDNz5l6WaX23mQLej1HTAoFmtE25FLIj2XEsxiwZ9KRm?=
 =?us-ascii?Q?GoOSbCr0HTFpEXaCRTRucE/xaEyXn+lP9NEAdCpbZ7K4qjDihNpIGTohbE0B?=
 =?us-ascii?Q?jF2zgM1Cm+BuUyH9Vmif1nIhwd7LsGc51toaNR3k9jz2E/S3Ege7lzMpmnuN?=
 =?us-ascii?Q?pUf1ifjluLfkoeTTdHRWi5wA0ZwLR0fda+gNdvAg8YYwxnamCoCKlNu//kS4?=
 =?us-ascii?Q?ZI+8W/bQpczxTNvLQeu39nxZPU1f+HTRFRaGxJbMKlcTQaZimvlY7HPyQJuQ?=
 =?us-ascii?Q?RyFJjZK2ia6e8b0bXyeJPu7xXDY45ko/pNQ433L/QRq5GA3FSWqiPC8Loo1i?=
 =?us-ascii?Q?EYfokNgpgAlxFeJXjPUQ6fWpHm8pJNdiIhjXmRbpmWXLmAQNvSEfiJLB/Lh0?=
 =?us-ascii?Q?qpmLe4c1s4QcdCrCUrH7A/QwNynsb4yOSrnJvyXOr9NC5Z8EXZZRr7SRQE09?=
 =?us-ascii?Q?Lv3eAc0e9CO81Mg8NSUcrfwV9pW0K+96+7x5U9QQwaqvhyKywv7Ux5Mem0am?=
 =?us-ascii?Q?UKX+S0LcD35hzS6v4XzT5nfWuCifw6YiGISFRDgq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23878ab0-e729-47f1-c4bd-08db34e628d5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 08:25:33.7183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73kk7ocxWHXC3ORSgJin5/oHMhNWYCMA/KIm4luR8vLbjbb7yJxIR1N4Xebxorn7v1V8yuq2BnXkviUEWr1y5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5653
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-27 at 13:39:55 +0800, Aaron Lu wrote:
> When using sysbench to benchmark Postgres in a single docker instance
> with sysbench's nr_threads set to nr_cpu, it is observed there are times
> update_cfs_group() and update_load_avg() shows noticeable overhead on
> cpus of one node of a 2sockets/112core/224cpu Intel Sapphire Rapids:
> 
>     10.01%     9.86%  [kernel.vmlinux]        [k] update_cfs_group
>      7.84%     7.43%  [kernel.vmlinux]        [k] update_load_avg
> 
> While cpus of the other node normally sees a lower cycle percent:
> 
>      4.46%     4.36%  [kernel.vmlinux]        [k] update_cfs_group
>      4.02%     3.40%  [kernel.vmlinux]        [k] update_load_avg
> 
> Annotate shows the cycles are mostly spent on accessing tg->load_avg
> with update_load_avg() being the write side and update_cfs_group() being
> the read side.
> 
> The reason why only cpus of one node has bigger overhead is: task_group
> is allocated on demand from a slab and whichever cpu happens to do the
> allocation, the allocated tg will be located on that node and accessing
> to tg->load_avg will have a lower cost for cpus on the same node and
> a higer cost for cpus of the remote node.
> 
> Tim Chen told me that PeterZ once mentioned a way to solve a similar
> problem by making a counter per node so do the same for tg->load_avg.
> After this change, the worst number I saw during a 5 minutes run from
> both nodes are:
> 
>      2.77%     2.11%  [kernel.vmlinux]        [k] update_load_avg
>      2.72%     2.59%  [kernel.vmlinux]        [k] update_cfs_group
>
The same issue was found when running netperf on this platform.
According to the perf profile:

11.90%    11.84%  swapper          [kernel.kallsyms]   [k] update_cfs_group
9.79%     9.43%  swapper           [kernel.kallsyms]   [k] update_load_avg

these two functions took quite some cycles.

1. cpufreq governor set to performance, turbo disabled, C6 disabled
2. launches 224 instances of netperf, and each instance is:
   netperf -4 -H 127.0.0.1 -t UDP_RR/TCP_RR -c -C -l 100 & 
3. perf record -ag sleep 4

Also the test script could be downloaded via
https://github.com/yu-chen-surf/schedtests.git


thanks,
Chenyu
