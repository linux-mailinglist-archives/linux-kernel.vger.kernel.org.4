Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1E766022D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjAFOa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjAFOaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:30:21 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC8F7F45C
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 06:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673015419; x=1704551419;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Fat7FsApUSyOnOnlXQkEzBVpWCY1yTAnjBMKdPfRTlQ=;
  b=H4pKethIKrFNmDL0hk6/5RrZ0Ol8n7Kbgr3S+547obfoyVdRdLGk9w6a
   Jw4cNNZzU5G7KeP50EX8WImcZfZx5A7idlktlkNIACoYNXqBxtOSOxhpN
   CsJeD7X6IANPNPK6qt7Pi9x0x5du4SEGDpU8j36ZVIBPK1U+vhmGUIQjS
   2rtIHSiduKgnGUP+YaAzPOiQrrZsALsYh8HLkobIGIpuY8MK647GWpLad
   GcpTzq7sTUHy+yusYAGNrULxIt5DUJvuFTlbGFTOYyRU2lWB5v6WN6IPP
   dMbT5oVcLWnr/dlxy83iBm7j3SHbpSIEUlLIy05bwYFwWxsfY4uu0D7Wn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="408737211"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="408737211"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 06:30:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="744648867"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="744648867"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jan 2023 06:30:15 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 06:30:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 06:30:15 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 6 Jan 2023 06:30:15 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 6 Jan 2023 06:30:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZO+PBCvVLxI4G91v8uJqs/0+ZUpt4Fa4IYEYcCTfA8NnCxeF44LDO5TMFW1PuyGwUUt5keMJj4T36zAtRWSatbijbmU91VMum07swwbL/1JwvWBiCmRRTselXK6PzCSBrQXtfwuMghFgjsJfz3De9aWUmYrn+3OmQePEcPPWh6XfhkfGivBrkPWRcs519VW2U61xh/H5F3S/VrJBUCID49gjYsVMka2+9vah8XAsCnsZRn+fr47rc6N8GDbJGT24L4wAheu7nvzftP47FGpTac1IyGVg0UtG2+vZ8/txAqhzT8DtNLx6DGgkysE2TBc+cfYgIULdVnPAJrqV9QBJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y76wV8/g91yBfsR7UeI11Q1v/Rq/I4KKbqQF7Akj3es=;
 b=gxRqxoHqWa1aeEvxQIuV0FmOHp0Z1NoFtF57oXCpFcOG4HzOMfMoEFdoKEeXEhdv8zEp9Dkv4ZoCcm9IH4RIvV7RSFDGaOu/LXEOgMmJZV+gfeUQcZmjST6dkMUKiyOLqidxJjVSPjOTd/77Bk/6EHm9A0zCowbpTdTTyii26sfBuvxKLtmhJ/wEix+TmeGhitAq1peMdAZZmNqIEmMt6b0DCvEMGGZTL+Cy93Hzu9j4NBkuKf9rd9SajkxMAREs6u2dDh21Nq3CQfeaGPWS7R2lGoA3ufiHMssg/ZlABeFNtbsOdfm1z1tqv5aOeSr0TVyrG/qKdD3HAfEmfecAhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH8PR11MB7070.namprd11.prod.outlook.com (2603:10b6:510:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 14:30:08 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2%3]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 14:30:08 +0000
Date:   Fri, 6 Jan 2023 22:29:45 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Rik van Riel" <riel@surriel.com>, Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Yicong Yang" <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        "Tianchen Ding" <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v4 1/2] sched/fair: Introduce short duration task
 check
Message-ID: <Y7gwWUKyG+6OUYd9@chenyu5-mobl1>
References: <cover.1671158588.git.yu.c.chen@intel.com>
 <ec049fd9b635f76a9e1d1ad380fd9184ebeeca53.1671158588.git.yu.c.chen@intel.com>
 <82689dd6-9db1-dd00-069b-73a637a21126@arm.com>
 <Y7fdEruJGTux4fYH@chenyu5-mobl1>
 <1913041e-ee67-1e65-68fa-ef08b97ed9d5@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1913041e-ee67-1e65-68fa-ef08b97ed9d5@arm.com>
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH8PR11MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a3503d3-2af7-48ad-73f0-08daeff2826f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dr3K4fGhBWWPhbHmbnxiI4tni06DDhrk/HxrVCijuBaV2p17uu5wMcZsxWfwigby0pjQZAt/Q7m0aZ7E6eNgodLJnbQDVgjZZ3LvxBmGEixzfuZcwNevB7iW1mjcKgoAw9byol779Z5YHNi76inpSaM5Un1dzOFENDxVvJG4iLoF8Cea/PXjT/+wHpMoo0JTfBT3czP04aISp38z3g1Dap+8hJ2mpNWsyf50+rqkVbqJyvNUio9zZ5XFM4rR0GPxwf9Bz9B+h6f5DSVqM3rWVbZRgOFMe9Ye4A5ixyCkpBq2vW4nNNpXhhq0Pigp0RAZjI+DZns8GU9B3WU1uUVrhlLlvK6QrHuSMaZT6j3GV7v4jU40Il+kVLcQEjGet/t3ktojQ1L8yBabTHYrM7qAchNbG0YwRRudjmz8nGUD9nmxustWqCd4OwQjoYCRcgE8bPxHlSANuBscRUYQZLFGpsRpedEupZQw0aBRB+F5f1EpdKZVSd87fuzYxRpzq/xy5AEFWPNDzhYXe1r0wtRdweGW0j+FGbYrpFI7UYraiiZTSHUdJPbmgkGURD1tTm9OFS5AcvvQ0M3V8Ex51UxkXwMfkeKxcjsvyI4YeLI9OZ32BscUKp/SeobAVdKz6F8jsEX+vqb/g5UIQRDCOVE6478Ap3D5Gzy/qDlNZLwADAo601h/LG7noyawz+hoNrmp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199015)(41300700001)(54906003)(66556008)(82960400001)(66946007)(38100700002)(6916009)(8936002)(8676002)(66476007)(4326008)(316002)(7416002)(5660300002)(2906002)(186003)(86362001)(478600001)(33716001)(9686003)(83380400001)(53546011)(6486002)(6506007)(6666004)(6512007)(26005)(66899015)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q4On1RYGqIV3myu2CexdtV/Nx4ucICK5dSvUmm1VNaHA4xYzmiHJ83Bnceem?=
 =?us-ascii?Q?4LabZoONRfuUNesUx8tZIPu52ApQBCN+hdiJ9iTA4sKgUC90f0QLMATtyEMS?=
 =?us-ascii?Q?RGAESUvffOYvunpZot9ztHRQzcErzcnqcYL3L5HvBz+/AaogcF41IfAAUYh3?=
 =?us-ascii?Q?IR8u494i134rJs0IPq5eHMvalLXuHyaDuCen9ZZRKuqxZTQvHQVGsCw+DK/n?=
 =?us-ascii?Q?ydGh75BDtaFP/2tgw1COc/WSYaZ2zwHSz9UXBrEN6NKjgQtab11ecJc/BR80?=
 =?us-ascii?Q?6bGpOU7BQyGRTCbSa6MDVRIgNBwOiMhOxtG2WHLAI6fxJJU3A7RW/gAlSWt0?=
 =?us-ascii?Q?UGYWMDK8CuG5bfG2c0xi81va9kcIk3QOQxAwRbMbY/k8haRRqEh6I7VuOzx8?=
 =?us-ascii?Q?4lt6s5m7Od0QzMD+Y8DI0LZvmo/kSciat2m9ZRO7OrqAqNiw9J5RZDOlOXRj?=
 =?us-ascii?Q?AkcNF6JCMhAVGGhj4newx8DntVI4CXUAm947GY2JAQJlRxNq3PMa1PmMkr/p?=
 =?us-ascii?Q?4aMMayso7BX60MHnbNcUtHhMsCKMEAb22WipJAso5XqUNIlYg5aT0ZKSZd3K?=
 =?us-ascii?Q?4BYxcTlmFRqUfnwURNlnT4NmXcFKk4zTSrJNTnUYP4BOMe3IOZtab4ToR/VM?=
 =?us-ascii?Q?QZYJ81nvzRWub/iEyd+Udtbfv4/OMUVFGcCrCakLuOQHWxAN/JJZ5j62wIGI?=
 =?us-ascii?Q?0kx2+RTydoWf1EBTLnTfPU+M/wtt5o0upOgNYJjidaNpsvyFAl6few2IeMRR?=
 =?us-ascii?Q?L+bKDCaun1nNXVursVsRCd8hvR1Ap8YQE8DR0qqezQePohu68QTSuuVmBldL?=
 =?us-ascii?Q?YkRiJhkRLRY7zDfEWw6amdo9BIFiq8X+PCg8WJ4oynlwIEOYeWJFDl3pGhtp?=
 =?us-ascii?Q?BKO+xTk66MVyspQJvrp41i0zHEDkADBROFAoyAXu8/IGKzGfdcwRwv/NwV6Q?=
 =?us-ascii?Q?QV7iHiJTXXHaQ1lp9++2w92pDrFmIumPUZywIC3x6RBQbOx0RR7AWB6q0RBV?=
 =?us-ascii?Q?Nm+cZaNOKl8kC0uzplKEVzZ1eFdOF7GEEbmvIl8+ddNOLXPu4OChF0j+byF4?=
 =?us-ascii?Q?PJoySFavyc6lYfh5VS0HFuSOIIfHSfLdrqFkVFUwXQStZgGqiY7ZzmoVzXdt?=
 =?us-ascii?Q?EIomOCDxDnY5AQMkwfKspF8aHSVgh7q6K7NAcfzS24OlU3DuguQ5GIxbQMuw?=
 =?us-ascii?Q?xA/xI7zk8FS0myy0XV79ERmBA7NjP9+mBGtHptE29wz9aBDvTOTR+OCinme9?=
 =?us-ascii?Q?YUrmixs4/RxTxpbak1gJzZP8nWOpZgZn/HioCXnpnf4sQciYnPrk+BFrkfNY?=
 =?us-ascii?Q?7JoY1JJukW+w/IZA8FR1eLtCwiPtEp4sh3S3/0eLNRvfPlPyhhK2S23IealC?=
 =?us-ascii?Q?jeaFyY04Gq+haMJwvLM0dho9BjLPR4FQu9aESJSEkKe6w4FXrnOFJi10QWr2?=
 =?us-ascii?Q?IPwC6gafTqBx2j6n6D1YtOHDLh6Fpb6mkPH32wybZBjv7MZiyYGkA7tG88o6?=
 =?us-ascii?Q?4Uoeiu/6tcgSYkBfwzPBQjODY3LyoT1PplZKqgHIPB4+YrngtO2BwPhA6yzk?=
 =?us-ascii?Q?wj2rtqtabXOTzFlvTslw05DiMByVoa3r93lVK9lQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3503d3-2af7-48ad-73f0-08daeff2826f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 14:30:07.8781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Nqc148gCfrfUoPHdFYAMQLcCs/6dEhD518Uay/vLc6P42uLpOYqfRJHTb1xC3PsHbm1evBJQCkR+h41SgM2nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7070
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-06 at 12:28:26 +0100, Dietmar Eggemann wrote:
> On 06/01/2023 09:34, Chen Yu wrote:
> > Hi Dietmar,
> > thanks for reviewing the patch!
> > On 2023-01-05 at 12:33:16 +0100, Dietmar Eggemann wrote:
> >> On 16/12/2022 07:11, Chen Yu wrote:
> >>
> >> [...]
> >>
> >>> @@ -5995,6 +6005,18 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >>>  
> >>>  static void set_next_buddy(struct sched_entity *se);
> >>>  
> >>> +static inline void dur_avg_update(struct task_struct *p, bool task_sleep)
> >>> +{
> >>> +	u64 dur;
> >>> +
> >>> +	if (!task_sleep)
> >>> +		return;
> >>> +
> >>> +	dur = p->se.sum_exec_runtime - p->se.prev_sum_exec_runtime_vol;
> >>> +	p->se.prev_sum_exec_runtime_vol = p->se.sum_exec_runtime;
> >>
> >> Shouldn't se->prev_sum_exec_runtime_vol be set in enqueue_task_fair()
> >> and not in dequeue_task_fair()->dur_avg_update()? Otherwise `dur` will
> >> contain sleep time.
> >>
> > After the task p is dequeued, p's sum_exec_runtime will not be increased.
> 
> True.
> 
> > Unless task p is switched in again, p's sum_exec_runtime will continue to
> > increase. So dur should not include the sleep time, because we substract
> 
> Not sure I get this sentence? p's se->sum_exec_runtime will only
> increase if p is current, so running?
>
Yes, it was a typo, should be "will not continue to increase".
> > between the sum_exec_runtime rather than rq->clock_task. Not sure if I understand
> > this correctly?
> 
> No, you're right. We're not dealing with time snapshots but rather with
> sum_exec_runtime snapshots. So the value will not change between dequeue
> and the next enqueue.
> 
> e ... enqueue_task_fair()
> d ... dequeue_task_fair()
> s ... set_next_entity()
> p ... put_prev_entity()
> u ... update_curr_fair()->update_curr()
> 
> p1:
> 
> ---|---||--|--|---|--|--||---
>    d   es  u  p   s  u  pd
> 
>    ^   ^
>    |   |
>   (A) (B)
> 
> Same se->prev_sum_exec_runtime_vol value in (A) and (B).
> 
Yes.
> > My original thought was that, record the average run time of every section:
> > Only consider that task voluntarily relinquishes the CPU.
> > For example, suppose on CPU1, task p1 and p2 run alternatively:
> > 
> >  --------------------> time
> > 
> >  | p1 runs 1ms | p2 preempt p1 | p1 switch in, runs 0.5ms and blocks |
> >                ^               ^                                     ^
> >  |_____________|               |_____________________________________|
> >                                                                      ^
> >                                                                      |
> >                                                                   p1 dequeued
> > 
> > p1's duration in one section is (1 + 0.5)ms. Because if p2 does not
> > preempt p1, p1 can run 1.5ms. This reflects the nature of a task,
> > how long it wishes to run at most.
> > 
> >> Like we do for se->prev_sum_exec_runtime in set_next_entity() but for
> >> one `set_next_entity()-put_prev_entity()` run section.
> >>
> >> AFAICS, you want to measure the exec_runtime sum over all run sections
> >> between enqueue and dequeue.
> > Yes, we tried to record the 'decayed' average exec_runtime for each section.
> > Say, task p runs for a ms , then p is dequeued and blocks for b ms, and then
> > runs for c ms, its average duration is 0.875 * a + 0.125 * c , which is
> > what update_avg() does.
> 
> OK.
> 
I'll add more descriptions in next version to avoid confusing.

thanks,
Chenyu
