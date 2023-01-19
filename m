Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA598674AD4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjATEgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjATEgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:36:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32C0B2D2E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674189242; x=1705725242;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=taxX6732glkUZj65JghiQQbKc+L6JhjnLl4fIQEGOsY=;
  b=n+r3D6gkhdw+JmEb28A/flTT9WCrZVE3bQLRVO9I0p7g1VVIIVVZv7TP
   z8z+fnbs5sFW2QXRkfqKzi9rBqOIWfAFPGj9Gt/fXNqPtOhnrzi1DoXwv
   dzqgDgiTlaar7sZmKKvdXZ7ZKEX3DoBy/O1A0WQXpDKgIhrKBlSgX9y30
   23XpEHmUV9YUKHmgaWSuhjjdtE9BMiEW6PCnOkBo/uLBJaPEg9Xqa83gS
   F9lWyXcNIk1w/IbrO6WqM/wwjMmMqMsb3zyo3BRNCvpBEU69YfodBEass
   IEF/Z4uonMSsIUMLuKFRSTNYHwmutlbZDHpIzWttsz/zoGzSgE1dQy3Od
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="411534242"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="411534242"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 06:29:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="833993055"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="833993055"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 19 Jan 2023 06:29:27 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 06:29:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 06:29:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 06:29:26 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 06:29:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSnXVB6EALEt5DO4j26z2wXas5mJp1cpeELxNNNySzaH9qWsUgHoqgUsQO4ev3wikhIdXm2NzcSwp06pYBVRS+y6jtxi7BkA6jRA33JbUiBdMKIH0hEFSCH6kFkx7IfUC2JD+5+b+ZY7b4q4IlhpbqiKbu51hj2iXCEbgfhF5I5dgrTd9O0D+f9O35CKg4jben16trP4ZTNjgYtQrO3xBgoR4wNlEWY+3UEV1ANJUPdShDU452d8YIkrr8ipSVRySLZBCTSLo0MMmDggM4dEpa75UELq7wOu3JwFAh2B7ZepN6Bar8/GxPweLUhzr/mRBSSWJXy2DU/luZQSMkQdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UXBW6FN/zS9FMUj4T+ki2Cxl8/8o4zKmItikJkieIA=;
 b=I4egsoSkyJErd+8O9aPvBPjZg9FIvbw1AfHd6Jeur3LvkoZSJ6G5nabuOj8m8otTRvWiPF7x7OqqiVkhF898kDHUiW0SqMKe1+RvdRb4BVVWKS8nAt8RQ+ejoP7GJQD8an9cMW9NZCKUQqL/NQOyBKUIYaBGh45gbLTLg7gUc5x/1Li0ys9f58V1YgIYMrQfvcDSZ2rX/PuUJzqFOzIGZSNy0xI687XOJED+hzW+J9bYWOmqeYW9+jNZ61RYS43mhJqGjOEJLiKnW3ae2Vsg8JOwkDC+FHzwH4/T4Z32/pYQFyIS3HJcP24zgya4dQGl84ojPDyKia6HS3EcZc+3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ2PR11MB7453.namprd11.prod.outlook.com (2603:10b6:a03:4cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 14:29:24 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d%6]) with mapi id 15.20.6002.025; Thu, 19 Jan 2023
 14:29:24 +0000
Date:   Thu, 19 Jan 2023 22:29:01 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Message-ID: <Y8lTrW/WrFPWCHFo@chenyu5-mobl1>
References: <cover.1671158588.git.yu.c.chen@intel.com>
 <ec049fd9b635f76a9e1d1ad380fd9184ebeeca53.1671158588.git.yu.c.chen@intel.com>
 <82689dd6-9db1-dd00-069b-73a637a21126@arm.com>
 <Y8Un9nmJauxpuSVE@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y8Un9nmJauxpuSVE@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR02CA0122.apcprd02.prod.outlook.com
 (2603:1096:4:188::10) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ2PR11MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b6a2f38-2da0-4f64-2e0f-08dafa298fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fHYISfRjMUQQlUafwnVR60pHbGlC1lAXT7XI/610vvgdWuKTuW0iD96frc74UUeav192Bcdy9Fz/WwL9jZ22PIh3w7sFOvb+BDykBkfVDQNwPVmUSKp4qqUmLJ/DG6zhm4HUQmwL7M0Z/ln+VwC1cbMykHPOLxmO+8H4hU3WYK0R990UCc/ArNzv+xJ9ZVE1g2VdwWBTejsaAcEXBybo6ZUMgVjS3Q6uwyTM6n7onB1w7q+w6FNdMWfq4Kkblz7ab1y21qzhmp8Bw+21hO0EtkzjkO1JzZ5HYKRiyEpJJoCaEaZ7ZL+ukV1hdI/+8Y+Lw1qN7fC5v4HlCh+stBlH2YMmkpS90gZlxyHGIyShmCjHL2Sv/byI7lWTYxKuShy/hd/+Q0BCtfTC9s9G1dVtftGZRVST3YP7UsWBcngJliTrr/R8N5uQ5xoP9AE8Ogz+YNkkeE02Qv8VCnVV5pbIqcLUf38tFZ0r5MW8orUvUQobbJW0I3cO4MbTUCL0vlNDqmyQIvyzlwl/a7e5R28qCJhGhCn3nwSAp7STsK9oA5y7BYC1B5RHt5XSh/32Q0DfkezkKuxCX1eo6UfOVcwHpVJW6prf2zc1dcSxBvVIU2okMfRP/PAlt7K2rQ2MZOIioVNxaveUiAN/Df00XdYWBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199015)(33716001)(82960400001)(38100700002)(86362001)(5660300002)(7416002)(2906002)(66556008)(66946007)(6916009)(66476007)(41300700001)(8936002)(4326008)(6512007)(186003)(9686003)(26005)(6506007)(6666004)(53546011)(83380400001)(54906003)(8676002)(478600001)(316002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SrTGYpLdtEbzpF/ZtW/4LkhiCmsJMUjC87oChuSX9CH3jJjGdJspnp//yX57?=
 =?us-ascii?Q?eCQjPeKFXl8DKii8PJTvrrDQrIeieb26gOPXuoIQ8FRGp1VsZkD1aEgR9GXh?=
 =?us-ascii?Q?Gcb1yWIr5+yIu7eaunf4ZfwoHF/Zw1KKWNqhZ8a557530D59XT2sf+chPZ70?=
 =?us-ascii?Q?fqS+vDKTbxyrsJglzhNdvN2q7DxsO1C6NxXOhYgvWjH+FJeI9d7dlAFnf1up?=
 =?us-ascii?Q?6rNanM9RfbgGFWw1oDTueq33Ja8D9yucS6huzdo/BQzweU9Hbx0N8EHErwTj?=
 =?us-ascii?Q?qMOVf800DD9wL2DqU2RQiMLgAM4pVxX8DzGim0XIJGXEy3GUl9BQcV1VrOAH?=
 =?us-ascii?Q?RyUdPXIPkuS1YdxlIvgBx7Xf8DJRHkreWoo8J+m0UJuc5poFbv8av72ZinB4?=
 =?us-ascii?Q?W8WP6YvzbAJwwCNUcwJBjMeK5kbt3AogdaN3JGxmkVrITHPg8y7eNTdqt4x8?=
 =?us-ascii?Q?3xJvHXmsdn9mwXLr4kZ8Cg6dMFyTChnvguSF/kj6BinSBVWXCinzQZc3ZUyn?=
 =?us-ascii?Q?s7XboMPFo7AWlhx8LwskKE/CwUi0I4tI22RDTvuIMw64oop+UWITXTo66C6f?=
 =?us-ascii?Q?g2CmfhZTug0OAM5+EMU1zPbxVT3O5tHBU/gFTPESRXw3dNbe37dhVav45QwS?=
 =?us-ascii?Q?ojSr2Yf685F8F2BNgioIvKZ0a/tb4vRNqLPVedV6TErDBAooHGqpiU5lBkrt?=
 =?us-ascii?Q?IThix6AkrF38RvOoP402aUgwaeXQpKGCwi1QLwd9icPl1pV8582ehsP3CecF?=
 =?us-ascii?Q?ui5PxydWHbl6KBseGP64ahDwFrRK30I4999y4V7ftcrytwYxxmGLxl6VVAw3?=
 =?us-ascii?Q?dcRlGPpbvOJrBH8q52S0M/OBeKheWbYD1DQ4/FH2EqB8VUqDLiM1A95j2CVQ?=
 =?us-ascii?Q?Jxe6rg9zT6TOyI4T993oR7D8CQE/1OVCKNn56f/M3YCFe2dnfSEcQD6CLvxR?=
 =?us-ascii?Q?E1ZR0y2394aPI6aRfMBZLxzre6IYtxn6GACthcynFu3Z67zld8W22Kgl09BI?=
 =?us-ascii?Q?8Jc8OipIikVPMQ8bRu78BS7D7c/NfCT86UpSc8eqmei6WTMfqhYTSEYwXC6w?=
 =?us-ascii?Q?U/KKKEse80v4vtvxmoodTunoA18cfn5rrUu15eOzyOBWdt0PK1GaxpIdrlP8?=
 =?us-ascii?Q?LK9tqoFWypyBmQh8KgO4vxDc5YdadZyK9Xf5a9wNbETzTqvNnwXh41Ph2RxY?=
 =?us-ascii?Q?YdDWkarBbwy4Z3JxpVmATYwr3Dosp3051oN+GvvdL38Y2Th1osKLn7bcfLSX?=
 =?us-ascii?Q?QqElejvp+O/TfgCxwwetLIY3bfm7cIqu12xw+4k84ECQRW7JlTBlJ3gpOKBY?=
 =?us-ascii?Q?vdHusus6QhbdlW98iCwpMBMMCSRH6ViDpcsKig1Ojn6gmlu7hLNkzpeQKPHv?=
 =?us-ascii?Q?7bJ5zNsJq3TPlLgQP1J0Eu1J22w8O4tdmFgPsSgnjR0cwjvIE07DaCPmUOxr?=
 =?us-ascii?Q?R0+AeyzlyDwim7hOlrr4C4Ofslo+En1M89vcN9PRONprCekyfEENxdz0i/ON?=
 =?us-ascii?Q?f79pINrN9jprO7LyWrmGcgTyoTvo77KNy3ihQRsbZdfxquuIN+hJFd9NaXbt?=
 =?us-ascii?Q?qiiHTa0NJv1aAJ3hGDN4tHb+EGSr/mkUrUGvHBrU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6a2f38-2da0-4f64-2e0f-08dafa298fd4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 14:29:24.3121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5gFeQRg/tUaUxBp1CI3eOsbQJHhT3C1LqCZ9WLPxuPF6/xtvh2CpDWRiLtOBUq8D1HXvOSGSaZbWu0y2g0gNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7453
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,
On 2023-01-16 at 11:33:26 +0100, Peter Zijlstra wrote:
> On Thu, Jan 05, 2023 at 12:33:16PM +0100, Dietmar Eggemann wrote:
> > On 16/12/2022 07:11, Chen Yu wrote:
> > 
> > [...]
> > 
> > > @@ -5995,6 +6005,18 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > >  
> > >  static void set_next_buddy(struct sched_entity *se);
> > >  
> > > +static inline void dur_avg_update(struct task_struct *p, bool task_sleep)
> > > +{
> > > +	u64 dur;
> > > +
> > > +	if (!task_sleep)
> > > +		return;
> > > +
> > > +	dur = p->se.sum_exec_runtime - p->se.prev_sum_exec_runtime_vol;
> > > +	p->se.prev_sum_exec_runtime_vol = p->se.sum_exec_runtime;
> > 
> > Shouldn't se->prev_sum_exec_runtime_vol be set in enqueue_task_fair()
> > and not in dequeue_task_fair()->dur_avg_update()? Otherwise `dur` will
> > contain sleep time.
> > 
> > Like we do for se->prev_sum_exec_runtime in set_next_entity() but for
> > one `set_next_entity()-put_prev_entity()` run section.
> > 
> > AFAICS, you want to measure the exec_runtime sum over all run sections
> > between enqueue and dequeue.
> 
> You were thinking of the dynamic PELT window size thread? (which is what
> I had to think of when I looked at this).
> 
> I think we can still do that with this prev_sum_exec_runtime_vol (can't
> say I love the name though).
I agree that this name is not accurate, maybe prev_sleep_sum_exec_runtime?
I'm open to any other name for this : )

Currently I'm checking Prateek's data on Zen3 and Yicong's data on Arm64,
and their data suggested that: inhibiting the spreading of short wakee is not
always a good idea on a system with small LLC. Meanwhile, according to my
test on a system with large number of CPUs in 1 LLC, short duration wakee become
a trouble maker if spreading them on different CPUs, which could trigger unexpected
race condition. I'm thinking of taking nr_llc_cpu into consideration when defining
a short duration task, and do some experiment on this.

thanks,
Chenyu
