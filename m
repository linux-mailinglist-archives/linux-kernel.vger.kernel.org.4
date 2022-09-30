Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04875F10C0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiI3R04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiI3R0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:26:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6F9114734
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 10:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664558812; x=1696094812;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tJBNDvY0DPDGOqeiV4GTjXgC8eECPaGHv6+/X7vBABQ=;
  b=WM2CT2uR/EQF02liNjJN1H2fiyQmTrbBJTbkuAA7tBklP8zpV6ViOwKR
   NGWCrO6NnzprQIavQbsOro5u0Q+93kxLGa/imr3Ui/JAlOlQrd5DuJQ/H
   /2PiqE8PkGxIVOwNTJV0nqtCqDskz2/Kba/IWZC7ZwnmJ8KDxm1sYePPF
   4ZgWv1VvchC9Vo1+Wzwp0ZMybE2l9upuIYqZSWIXtgY9moRIEqELMsHnR
   jR30Q3+eVlH/qzNzJhXxtAzvfm7icsYOazR8WnMLlaruTdK8tD+XvzCce
   b3vvST1TPbwknrF7lP7MS4qItHNV05ijwhjHfB4vIUQ1pkDGdZPt/Sxxk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="282613739"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="282613739"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 10:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="691328588"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="691328588"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 30 Sep 2022 10:26:51 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 10:26:50 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 10:26:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 30 Sep 2022 10:26:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 30 Sep 2022 10:26:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFy2DzsE1uuD4T74870Uxb+LDhylUS1XYxsk6063HqMVMYT96X63dfDGzCb3/GrsVsYHW0Um6sRTF6rzaPM1rqe0OxwiZYNzTBcKHDXVKDFMsCiNUztbda4wzNzwmfJaX/2GAYKRLsGg4NoPchqYdYcPpgRXzjAN269+KbaICgHV4sDOQ33EU5UkXHzS6ZTsfSWkUO2cp7rDsWjAEWEsaBECGBmLKtnTpU9bhq1sHXgnwhj75p6hXEfDX4Xezlbc5638GHmjJxRVtHdrUqePuz7ua94I5hCcCEaDdAadDod48CqjJqnZwT+/v3nzyzOkcj0SfBQtJOtlIvSH5yKfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SNxEXDmOHb7m0FWjB1qj0TuuqCmC/Dn1d/AoBkrXH0=;
 b=QTQybJjmopg5blwdPntcf3d7UKmVvQTUACWYp6Tjls7HeFURaZSYD2YnjuTVjz/GUIgvLA2DdxIg3+CY0gGF1Nl0sraI2vXAzBfrvczeQqdK/6z8fG0k+7twA86y6NJKzen/ypez+qjvrRcc8ro3AX1op7Aj6wpF07ZrZ8Qc/AewAr/QlmTQ/H6hMNc9y2SnpFXquxHySK7gtRFq6kHiyNnaD2iftNhrEImYiMqreT5DFHQhjLVFy3C9FFEenF30z15MOziGYKiGcObMGTlv/wrO1ly2OTI51LeUipgM7AaVNrKQkSIQiw3XfO0XHHQjnO4y1SogPsvO0f9vrvlc6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BL1PR11MB5980.namprd11.prod.outlook.com (2603:10b6:208:387::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 17:26:48 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43%4]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 17:26:48 +0000
Date:   Sat, 1 Oct 2022 01:26:25 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
CC:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Tim Chen" <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Juri Lelli" <juri.lelli@redhat.com>,
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
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Choose the CPU where short task is
 running during wake up
Message-ID: <YzcmwQCedKPLUsfi@chenyu5-mobl1>
References: <20220915165407.1776363-1-yu.c.chen@intel.com>
 <7975dcbe-97b3-7e6c-4697-5f316731c287@amd.com>
 <YzG5iAyJv3YCDKcp@BLR-5CG11610CF.amd.com>
 <6c626e8d-4133-00ba-a765-bafe08034517@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6c626e8d-4133-00ba-a765-bafe08034517@amd.com>
X-ClientProxiedBy: SG2PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:4:7c::36) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BL1PR11MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: dad92700-72d5-433f-201e-08daa308f490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6snOGgC2p8F1sTgPyUdrVXYSi8ZCG5iygKPSgFyqdl3RGXUL4vvtJlxWNnytnqdFulScpdhECjO28qjj0LV1klf+wYAQSMqRSFs2nCWZlH4IBqcjFB+X0n2yD8LygtL1pcItpd6ucNtkoEfTMosr/JA55L5tcDVRFk4N+/wAhrg989fkXJ0xAy5OTh3MQh6s5Z6VNaBuzS6kvxdG8NDk02pd43yxpOiWZ1YohD2gb1kTFL9wmySbY5YI71HRb2DGnID6+wJdhqPyG9FtshzHNzRiBU0ukHDfqojPBPKazjPBoIbhTS/rNwZ5ySZTpu8idJVKZd3oXHamKClBXtUTkHdDnui1ZAxMv3KembGIkfJfmdhIoPs99HvshCZFKrMsuq9fScFjAQEfIkLdGw157HuxmAIjUWvtaN8ZRsoLnAXDVFHip2GWkwV7hSpPVCForJKjrJKC5s4worwRVR3J729C0qKmYAmQI7RYXr4FooF4RSM3A55yhZsQvsab0ZwV8KGyG+cOa9rkHkdD8oAsT02su5Sxo0xsHIiUU8q2dcn2pgisSP62Z0H6wtcw6+RBRcVmlsssyJegisl4na6SBBPUSnxPIPSGb/IiAkyovdKOVPr5zfvXkYd9bqNBBsDtlcbpPi4M56UWOMlegTqxy47c8Gcj1LT/23/ATSWKXuVRo8G0d7FghXnnj+xiT5OwtGtC7/W3CcHyyCHZB87rOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199015)(186003)(2906002)(6506007)(6666004)(41300700001)(7416002)(5660300002)(53546011)(8936002)(26005)(9686003)(6512007)(8676002)(4326008)(66476007)(66556008)(66946007)(38100700002)(82960400001)(33716001)(86362001)(54906003)(478600001)(6916009)(6486002)(316002)(66899015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cHXc1RYJFNwg3X8alcVOscCqKwFOYSgNFDj9U+C/GdQ29A5lIjz/YgjH1VGS?=
 =?us-ascii?Q?qTvCHCzdr0uy1k+7t/fHx6mWwlxaUlFfHmwIEAXYzPuEfJR1mbmfsMFwbNCt?=
 =?us-ascii?Q?J76I23RMu9qB/grH08pg5V2NFK5diAl4ISqUuTVEbsBsomDJwQ7j0BaV0DHu?=
 =?us-ascii?Q?xCTym3i5g790pYoHI3rNsikMt7etjyJEX4eG9YiSdkjVWs67EhjZc/bDQFKa?=
 =?us-ascii?Q?Hed4rdIFi+u01AHo4xZzYkqfo2FJgs6lJ0KGfvaT6hEQ+dEKL8jqq7Nd32XE?=
 =?us-ascii?Q?K6UhRiJzwcu/LBc2yo4YRS57akYaDzjvohyAMdtpEGUtI3RrHPaBlSUm1zJX?=
 =?us-ascii?Q?hOTRPMTRzCE34O31w58LGhmxZF1IoBrVz2wVrsT3MMC1xALRIpZnyp9VnQlo?=
 =?us-ascii?Q?NV5VneKY3D5A9TW3lg8snOmLPrIXGfN0hLrKhcwqCF9uD698qGL6gprwC6Pi?=
 =?us-ascii?Q?vxO6PHea7x9X4WhauBLlC96kErCx4q6me7VZAmFV0+d0tCSaxJOa/BfwZkof?=
 =?us-ascii?Q?lJNJuzx59WR6Zs0ZZz7bKnBLPre780t1yLfDtwxutrekVDgr0AoRcELgCg6v?=
 =?us-ascii?Q?Opz6Z7aSyHDyC11QvExeXqvSF9nkHf190aWxdGBGil5oOWyF2G87Sl91kEON?=
 =?us-ascii?Q?xubLOx7lsTvOV0jMeQ+4KAKDWeddcm2jb0naspg+XJXx5m9ye4H9fXzdh8Xj?=
 =?us-ascii?Q?AMGRpgNwiEHEeSCjqoaResUac7hQpgJDGDS34HhmEcx1Mp0K0PglFRMPq74+?=
 =?us-ascii?Q?mbPPlPRI1/TKOTcED8o9kqE2JHnnKZwtbmdvZ8ZcbvHoPZaD6nmyNdwV90jh?=
 =?us-ascii?Q?PPGY/7gE6SXwhCpCyZV9QIoecscCkscMGYIQpR4JKjHGisszOhzErHqFePdG?=
 =?us-ascii?Q?f/LacfqoNLVV9Q9CFhI+eFMvpQQRk/ehkcknJnAD+rn5f2RwMW8Omt6UGpN3?=
 =?us-ascii?Q?e4B4Zzw2O+bLTqniHx4Lwxik0vaYC2+I+34miMD7xq+gbrNYahWFxK1lfq4u?=
 =?us-ascii?Q?ltDL15Qe1U4l9gjQwIfrbXD9sfFsd8Rx5jwZtuvzj0nwIK2CNFqmC2UW8kXg?=
 =?us-ascii?Q?mthj1DxbcJdSPG7ZqBIchXfJDltrMvpIngiqgzSlge1hnW1nDyVaXuLJQQV6?=
 =?us-ascii?Q?sHrXg8K5IdK4A8Z8O9KJszPdHF1sLBE8tRcd9iyC1R4pBEt0QmegqihbSjdd?=
 =?us-ascii?Q?UoBuRir7voW85+0N/UeNm4ECiuzts6q7hqcLliSKJvFM8DN+qzA7PiSqftAo?=
 =?us-ascii?Q?OxojKykdkDzsG9C840WNJJja4Uwn3AYLxpuS5mqdWZDRx+gXKTuPXrqzOz5C?=
 =?us-ascii?Q?uVww0PEjHnn/yYUz+yy2XT0Opu5n9fSGr0JCezaP17IGKPC2AnzBzNCcp5vh?=
 =?us-ascii?Q?EWsdv3Ui+RHCKxJLMUxVtJLugNGSQjcYDqRBB1bm7FraiZ+1sUJH7A4uIET1?=
 =?us-ascii?Q?z+sp/9csfPrtO/Utkz/ua0rYIq0LMLVm1l/wuhkn9tsNLG5e5v+LqyvxdVp7?=
 =?us-ascii?Q?aVdQpWCEhsZR5Uc+G96nbb4hwqRFQltTEi9PxEU673RGcamEMDW/OFx8HJRO?=
 =?us-ascii?Q?V/pbvh0dva36Ewuv0hGQ2Lp4u6E1w3wZriYKgkyN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dad92700-72d5-433f-201e-08daa308f490
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 17:26:48.5904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jq4Unh+Cf/zeclYiMm2fQaJwi4eeHzIexU95+Lt1V4cy0ogGWO8/LJkI54D8u8IO5SugJ/Bgr4rYSS4usqC/9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5980
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prateek,
On 2022-09-29 at 22:28:38 +0530, K Prateek Nayak wrote:
> Hello Gautham and Chenyu,
> 
> On 9/26/2022 8:09 PM, Gautham R. Shenoy wrote:
> > Hello Prateek,
> > 
> > On Mon, Sep 26, 2022 at 11:20:16AM +0530, K Prateek Nayak wrote:[
> > 
> > [..snip..]
> > 
> >>> @@ -6050,7 +6063,8 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
> >>>  	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
> >>>  		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
> >>>  
> >>> -	if (sync && cpu_rq(this_cpu)->nr_running == 1)
> >>> +	if ((sync && cpu_rq(this_cpu)->nr_running == 1) ||
> >>> +	    is_short_task(cpu_curr(this_cpu)))
> >>
> >> This change seems to optimize for affine wakeup which benefits
> >> tasks with producer-consumer pattern but is not ideal for Stream.
> >> Currently the logic ends will do an affine wakeup even if sync
> >> flag is not set:
> >>
> >>           stream-4135    [029] d..2.   353.580953: sched_waking: comm=stream pid=4129 prio=120 target_cpu=082
> >>           stream-4135    [029] d..2.   353.580957: select_task_rq_fair: wake_affine_idle: Select this_cpu: sync(0) rq->nr_running(1) is_short_task(1)
> >>           stream-4135    [029] d..2.   353.580960: sched_migrate_task: comm=stream pid=4129 prio=120 orig_cpu=82 dest_cpu=30
> >>           <idle>-0       [030] dNh2.   353.580993: sched_wakeup: comm=stream pid=4129 prio=120 target_cpu=030
> >>
> >> I believe a consideration should be made for the sync flag when
> >> going for an affine wakeup. Also the check for short running could
> >> be at the end after checking if prev_cpu is an available_idle_cpu.
> > 
> > We need to check if moving the is_short_task() to a later point after
> > checking the availability of the previous CPU solve the problem for
> > the workloads which showed regressions on AMD EPYC systems.
> 
> I've done some testing with moving the condition check for short
> running task to the end of wake_affine_idle and checking if the
> length of run queue is 1 similar to what Tim suggested in the thread
> but doing it upfront in wake_affine_idle.
Thanks for the investigation. After a second thought, for will-it-scale
context_switch test case, all the tasks have SYNC flag, so I wonder if
putting the check to the end of wake_affine_idle() would make any
difference for will-it-scale test. Because will-it-scale might have
already returned this_cpu via 'if (sync && cpu_rq(this_cpu)->nr_running == 1)'
I'll do some test tomorrow on this.
> There are a few variations I've tested:
> 
> v1: move the check for short running task on current CPU to end of wake_affine_idle
> 
> v2: move the check for short running task on current CPU to end of wake_affine_idle
>     + remove entire hunk in select_idle_cpu
> 
> v3: move the check for short running task on current CPU to end of wake_affine_idle
>     + check if run queue of current CPU only has 1 task
> 
> v4: move the check for short running task on current CPU to end of wake_affine_idle
>     + check if run queue of current CPU only has 1 task
>     + remove entire hunk in select_idle_cpu
> 
> Adding diff for v3 below:
> --
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0ad8e7183bf2..dad9bfb0248d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6074,13 +6074,15 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>  	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
>  		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
>  
> -	if ((sync && cpu_rq(this_cpu)->nr_running == 1) ||
> -	    is_short_task(cpu_curr(this_cpu)))
> +	if (sync && cpu_rq(this_cpu)->nr_running == 1)
>  		return this_cpu;
>  
>  	if (available_idle_cpu(prev_cpu))
>  		return prev_cpu;
>  
> +	if (cpu_rq(this_cpu)->nr_running == 1 && is_short_task(cpu_curr(this_cpu)))
> +		return this_cpu;
> +
I'm also thinking of adding this check in SIS and also the ttwu_pending flag
check in SIS.
>  	return nr_cpumask_bits;
>  }
>  
> --
>
[cut] 
> 
> We still see a pileup with v1 and v2 but not with v3 and v4 suggesting
> that the second hunk is not the reason for the pileup but rather
> choosing the current CPU in wake_affine_idle on the basis that the
> current running task is the short running task. To prevent a pileup, we
> must only choose the current rq if the short running task is the only
> task running there.
>
OK, I see. 

[cut]
> 
> A point to note is Stream is more sensitive initially when tasks have not
> run for long enough where, if a kworker or another short running task
> is running on the previous CPU during wakeup, the logic will favor an
> affine wakeup as initially as scheduler might not realize Stream is a
> long running task.
Maybe we can add restriction that only after the task has run for a while
we start the short_task() check?
> 
> Let me know if you would like me to gather more data on the test system
> for the modified kernels discussed above.
While waiting for Vincent's feedback, I'll refine the patch per your experiment
and modify the code in SIS per Tim's suggestion.

thanks,
Chenyu 
> --
> Thanks and Regards,
> Prateek
