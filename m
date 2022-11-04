Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86C461924D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiKDIBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKDIBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:01:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D18C09
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 01:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667548859; x=1699084859;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rVYXwNvIhdN1T5hl/XIEV0y75CBQKymnCLcXkV44VoI=;
  b=VIH8OQ0LM3fJvVuSxAKtx3ustfoK46339syVnNQTnSukh4UAI5nabZAw
   rIgDJSaL7d77fentnvkSbu+XdtXtoskjgpVq/mtm7iG71XtYrdwf+WKBX
   GGuI3+Q30DkfdkBDbOyih6pG+xFzrIOrI7ZTIF7bFueetu07L1AoBA5Dw
   6aImla6yQrUc3qpHakILmXrz+q/SFgkPcRqwKDZevjamoolpH+bvdBSpp
   Guq6bHc13R9Hd+TYv5C3JyErWrIipBXyopG39GzFxW6judXhMbj3Zhy60
   oms3a022N899/CHX0fmM2WgsQLWDb/Y8M0RBW6+fcTgqEERKYNdfvA9oo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="289625896"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="289625896"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 01:00:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="740532266"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="740532266"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 04 Nov 2022 01:00:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 01:00:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 01:00:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 4 Nov 2022 01:00:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 4 Nov 2022 01:00:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTeB89VKDRjMA9Ay9ZzI47rujR/yAKVRjWKT6xhLraCmPQPwXcw/hiWJi1HkTaW8/XhzibqbhG83M6lsFSHs0tP9o24AmmFohzb+0HuENWEdSI08+SkPsTDQdbUQMoboFmQrQ5HnFZha96uwS/Te+NmPvapcpclClHm0zo56tBpksyFhjMzsMLSZqNBCvcU0+p2x3JjGsByLJcjqrwqz51M66V+JCiOmXTvoI5CsIAjsCxjx/BitM6PP+G0flxT3h1143/GGONAl9zoRdhzRzUDkd82os6kCDgn/xzoojMq6eYWORL+axR8ZilwZvxkoiBDcpS4E0YG91BEHBmcxDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zq0XeA288Ugnqpv0cOhEQgY5whYI7eYzHyezkU699VE=;
 b=MdNaRzbKOukknEqUEcK362sbT7x1mKne8lYDKqVS9tIjstnj76RtreQcsqcYLGuah4zBtSF1XBk54giKSxxj9XypGhLKpwZPXQvR9lYfz7+5JC19nMpzZiq7dweHHrmgFS5MPIO9n7dOyqMG9A3/DA90uUG0G1glaHRZlE5z/12xHXfYJ4HUYLcTh4tw+ZL3z7v599LTSVkz7ojF3ZXT4HF37i91LxfCJZw1HpdKenzQ2vUK+9YDrMUh/d/0ZUYO22qS5ihXpF3ugpzRe8ywDuMlCt1PdGw2YTu9k+MYz8S4vJYprjLkp/JxYH0/1DCl3lV6i7Rx6mrKMkcr0MCL/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SA2PR11MB5004.namprd11.prod.outlook.com (2603:10b6:806:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 08:00:55 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::b6d7:8853:f8a4:ae30]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::b6d7:8853:f8a4:ae30%9]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 08:00:55 +0000
Date:   Fri, 4 Nov 2022 16:00:35 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Tianchen Ding <dtcccc@linux.alibaba.com>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched: Clear ttwu_pending after enqueue_task
Message-ID: <Y2TGozI0YZQ7BCxc@chenyu5-mobl1>
References: <20221101073630.2797-1-dtcccc@linux.alibaba.com>
 <20221104023601.12844-1-dtcccc@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221104023601.12844-1-dtcccc@linux.alibaba.com>
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SA2PR11MB5004:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce007e7-b6b2-47a4-bfed-08dabe3ab34b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FtrXCRh5pC+CkvRP2NluWkOrq/AdjGRVAX0yI6BDiJ9uAR2Z2vuPQ/21UkwwMgSF17jiFjyyeMMUyH1M4OpKmKHkKEhXxgtxJq6r1UYz7Oe1hVZZDWtiUf4/fvw/V+pAZyOQX54gEUWAvT0o+uRQMI0//qMwBMZ5FDGZkWYWbU8cFMGZkQ1N1cY1+yB9jlTRoH/vaftG2NeQn4rN/rZJwmjG6fHuetvhIekKU84XOSCGFFqirQXi7JI4rdn+xjVKHGIKvQs0cIYbuE4cItT0LorkCmO4nnlCv8gM14k33Hw+bx2pzN8Y9hcTgpkyP8WQ6trqspkGLPvRK19kqM63OMfg6EH9JuNztCcLPAmL7F51TBHX1tYatra0N1XnGWWA3czs2zqjQMZyQ+aZ6/WpyCGj855q0jxAoaow1eXqrB1okvmJZrdFqY5Cc6B6GcKYmpNy4T6vZ6R7O1bOkjCKdd9bOqTV3W6A/kdKj32DX2o9rukodCWi19779hRWoIkVfdLf5Qoibsvh0mCBiZyaY8T+9H/Zn/6Cay2kq/i0W4pKoTG/deKZ3V/m8SipmGn92ftvo96wKV31HW8PrfhH4VLMm7O0I09GQykYtor5+UejJT+ECl233RjHc8vinGc2NNqmtv3oNuj3+e3uJAslcEDC8mABmgdL1FLxfogeWYg0Mbt7pc/7vPcXqyv8oZT43vrzF3dn3RVc3r4lnCHwBx3YoKzW20f+jP5+zHDwerQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199015)(33716001)(86362001)(9686003)(41300700001)(66946007)(6512007)(66556008)(8676002)(26005)(4326008)(66476007)(54906003)(186003)(5660300002)(6506007)(8936002)(6486002)(6916009)(966005)(478600001)(53546011)(316002)(7416002)(82960400001)(38100700002)(6666004)(2906002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CmYgqu5AL6DBH2yRjAs8P5aIz6kAn/6XIX4CDEAXJTtK22tt36KnBkwqqCME?=
 =?us-ascii?Q?AmXze2EYrqM9nyG8RUC2GoRmmSZ/Pi6MfiLLHyVq3ulVEbyokwsjvCTQ+7O/?=
 =?us-ascii?Q?RAWqeHGMRqn9moe6MTK68+jLyGJRJE67I7GyDEITmdoYDiTZBm/lNNgAOE4w?=
 =?us-ascii?Q?fxgDHdng6BWGBp+ZFD/2J7A8DoLnEjUsSleRp+jAmiHx8KyuEybljYBOgRZ9?=
 =?us-ascii?Q?sp5WTuQVWGPGmI/F3uHcSFX1LHESRbHt8DcbwSwNBKOrIHPvdHGV1frPf9PQ?=
 =?us-ascii?Q?xJ5C3ouRphvIbuCjD8a3ztK2554Ai2eYCCQ1JmN+uHDAGVRjhw3h9ElSE+Uc?=
 =?us-ascii?Q?OAmKhFDGjHjeqTwjZEHDZ3VBJGPPqlK9w3PG81AkrtdhieBzmEJVlah/qh6O?=
 =?us-ascii?Q?s1AulYapr/jwvaqvDDHKf4vnB0XqsRr6VSUK6hls+DK7fk4xfxYC3u0syjpN?=
 =?us-ascii?Q?W/4UC6KL/+/Zavm9RMYKgc33+ee0ZMYV9fF7Z0shGCqRbuOwqhv+wD07Zh4m?=
 =?us-ascii?Q?rNZAGJXA7gmOeBZrTDYSs0FujpM+wVUukt8k7D8+jF3fAw/WBAw2ifq20Qag?=
 =?us-ascii?Q?O0IBveg5w0XF5w90X6UQ05L6e9K26eWtvklxPJlGQqvGxcIoGfXqrV1TmaOU?=
 =?us-ascii?Q?IDpjxQlYEx5NLAyg4I6T7UelGtsmDx4ZluGvxlj0wika7o+4t+hBV4ZqgIa2?=
 =?us-ascii?Q?pOt0mFIVhITKBB7CT8PStD2aYRniOwcXlPKYRlcT1mKlTnntJ8PyrbEB2SaP?=
 =?us-ascii?Q?QugwhT0o4qGECVrEIBZ4jI5IqXcnR8J7+9FJDWxDI/WtdmCfX7WNawK5B3ER?=
 =?us-ascii?Q?p1QF/mOr0j4EBBDjQqqehSFJF4MxqNZ9G1hEr7fGN6uYESIg6GoWK6DsIZbj?=
 =?us-ascii?Q?ph5AP1NULOdslO+kqfOQTAd/U9AGBuUfAcwiXxe9jH0VKIQdqnQYCXYL5kCn?=
 =?us-ascii?Q?DlzjnG7vh5BcPGkpb9pCMKhVU53oNLczcVrxfejA/KLl3jizMNoGsN4cEEQd?=
 =?us-ascii?Q?nCbxTcvQnwp4vsxp0+3adO+ef+zhx++VkyuhUVLrdWNzzB72vup19fLzWhAG?=
 =?us-ascii?Q?7qeDYhGy5RZwLlay0YmmXEbllAvis+jpkiuazfsewgURtrsFw0Xa5fnpoPvt?=
 =?us-ascii?Q?nDccQcdZEqO4fVlaxDkSIW8e50Fl1nEGuhdoW/XxlSDXvl5Jh/4HGYYw4hGz?=
 =?us-ascii?Q?zry2cXcU9IIsaGnPouBzvvtl8xMgywlaQuxCMxNFmEzFg4IPsMO3wiMKAMj4?=
 =?us-ascii?Q?Rq3YPCeKVjjgfIrYuMz0FQMrf6089JAt6xx57zoLrOlkQskMfXCL0MstHQHO?=
 =?us-ascii?Q?yL0WQ+u1cbiHW/uY52HjTt2HMR4hjeCii4wYXRztHHW+6boUdlIZFmv4sKnH?=
 =?us-ascii?Q?CM8zYQxUlTgIBD6rTALLOtnP6NYQplnm4pfL+Hz9E5bU50wdHp8SwZa9GUei?=
 =?us-ascii?Q?3RFSdxC1+8HPP3ud+emkAi2jfVbbixZROO0mpODp7O+KPZFP85JM4EgKys88?=
 =?us-ascii?Q?OfwJD9cGfDzl6PFRo5ZLsdvoKp72bVKnnm574wN++nOZPUU3rAj6Kb8Oy6IF?=
 =?us-ascii?Q?aA5hcdMX40dMnOprZxyHEdvlAQ3FPDyK0oRIMjYd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce007e7-b6b2-47a4-bfed-08dabe3ab34b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 08:00:55.3843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3/NDlKZpVVqxS/fQyZmSMHxdKxKAhqOZ0np16nhkBF/AYiQobTCVDP78BpxMNbstuzuteCF8Uop0K//oxZlRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5004
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-04 at 10:36:01 +0800, Tianchen Ding wrote:
> We found a long tail latency in schbench whem m*t is close to nr_cpus.
> (e.g., "schbench -m 2 -t 16" on a machine with 32 cpus.)
> 
> This is because when the wakee cpu is idle, rq->ttwu_pending is cleared
> too early, and idle_cpu() will return true until the wakee task enqueued.
> This will mislead the waker when selecting idle cpu, and wake multiple
> worker threads on the same wakee cpu. This situation is enlarged by
> commit f3dd3f674555 ("sched: Remove the limitation of WF_ON_CPU on
> wakelist if wakee cpu is idle") because it tends to use wakelist.
> 
> Here is the result of "schbench -m 2 -t 16" on a VM with 32vcpu
> (Intel(R) Xeon(R) Platinum 8369B).
> 
> Latency percentiles (usec):
>                 base      base+revert_f3dd3f674555   base+this_patch
> 50.0000th:         9                            13                 9
> 75.0000th:        12                            19                12
> 90.0000th:        15                            22                15
> 95.0000th:        18                            24                17
> *99.0000th:       27                            31                24
> 99.5000th:      3364                            33                27
> 99.9000th:     12560                            36                30
> 
> We also tested on unixbench and hackbench, and saw no performance
> change.
> 
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> ---
> v2:
> Update commit log about other benchmarks.
> Add comment in code.
> Move the code before rq_unlock. This can make ttwu_pending updated a bit
> earlier than v1 so that it can reflect the real condition more timely,
> maybe.
> 
> v1: https://lore.kernel.org/all/20221101073630.2797-1-dtcccc@linux.alibaba.com/
> ---
>  kernel/sched/core.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 87c9cdf37a26..7a04b5565389 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3739,13 +3739,6 @@ void sched_ttwu_pending(void *arg)
>  	if (!llist)
>  		return;
>  
> -	/*
> -	 * rq::ttwu_pending racy indication of out-standing wakeups.
> -	 * Races such that false-negatives are possible, since they
> -	 * are shorter lived that false-positives would be.
> -	 */
> -	WRITE_ONCE(rq->ttwu_pending, 0);
> -
>  	rq_lock_irqsave(rq, &rf);
>  	update_rq_clock(rq);
>  
> @@ -3759,6 +3752,17 @@ void sched_ttwu_pending(void *arg)
>  		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
>  	}
>  
> +	/*
> +	 * Must be after enqueueing at least once task such that
> +	 * idle_cpu() does not observe a false-negative -- if it does,
> +	 * it is possible for select_idle_siblings() to stack a number
> +	 * of tasks on this CPU during that window.
> +	 *
> +	 * It is ok to clear ttwu_pending when another task pending.
> +	 * We will receive IPI after local irq enabled and then enqueue it.
> +	 * Since now nr_running > 0, idle_cpu() will always get correct result.
> +	 */
> +	WRITE_ONCE(rq->ttwu_pending, 0);
>  	rq_unlock_irqrestore(rq, &rf);
>  }
>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu
  
