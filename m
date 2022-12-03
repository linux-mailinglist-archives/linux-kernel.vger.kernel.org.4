Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CE66414D1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 08:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiLCHuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 02:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiLCHuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 02:50:05 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA59098568
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 23:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670053804; x=1701589804;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F+vdFQrDivtWoU22pFPm17w2g4QwZqKNKg+49JTzlTM=;
  b=REmDJcre1AlYYbqrPiL2QCO24GtCd03mScwgkIqICU9V/UkUCuVlHUiC
   wwH+t76fWVBmnHjD8PMudm1dyFxhzUrrAgcJaGY/GVgPxl2CVFbY5ZEtz
   R+4ZzR1w+5ibyiL95JWmJqG7XavDRMCPBGLZMEqy+eqnSOIuCZUzLJsCJ
   5OyzZ2/7mKs3j3bYTF0r23vY74uWRXdlzQ8+TXaO0LEtZox1OA9L9Ld0K
   apGHvlc47nWHSNTrjuqfOaApbNZWH8slXyyLD3w+3ermYtqAqoyt3504f
   nbmqyRMKNwUVBKLrTDq2/hEhy/nixUCyjyT2ABM208R+hqUU0E68EzDIP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="296461003"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="296461003"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 23:50:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="819675772"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="819675772"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2022 23:50:02 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 23:50:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 23:50:01 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 23:50:01 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 23:50:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gh6lnjLY6E1IbT7X0vUy6ZGypW1EO3iAJpIRA6Kfw0OHWdPG8D5ifQx6z4PYosG5aggPRD2uwZ6knRWW+Hpc484wDItLcDAezG0YCiurYzXtMp9An5CZQMlYVt15AJ6o7cmZ5X2O87OnmGCWsC6qdgoy2dkmAvofMwoFA8Bvg5/LVTJQYeU9gLwlvRC/R7KjIS1meFexibL2q3mqqp/nwixcXLtrwSENnOA0C5S1dCbfXcikyF8LkjLvw7u+Si31/HEd860zisqNTNok3YeY+FJ7Es47YDxV2rL2dYU14X1N6Z84ULcEbg8u68ULoObrPIsOA1ibFqLXqZqgvy3iiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lw9IUxQ7QHyb71Ie2xUFXNTQpH+fbUEanWKZKZiS9zU=;
 b=We1KwOC4G2UfJRO7/dJjppJgDcx4ZmRXLotp0o1v8MiCfbXo8/bflYX7vaLDJ6EP076U2B28HRABg6Dpx5Viehb95D7RpXiaoN1JghU/OANhRTxMxAcHNucjR68xwfM50bVeC3nMX5JJLkFl3EXNpQDeCUXNZxkQJrhUFqNPR0lZIMXJgmLkhZtYOnyz5DjYsOfhWRRT+l0ACSQy97HoYbSRu21f8UuHqNnYgmsViUAU0X2GxIiQC1d9Bc288x1e+FPxQwfODbHgprg6mTYlndQ6EWUxuz7iGLn6rjYAzv5aLaBAiP6N3tRioj8pSxrEtxhdv63fc/lOBbUc9fL7gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CH0PR11MB5315.namprd11.prod.outlook.com (2603:10b6:610:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Sat, 3 Dec
 2022 07:49:53 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7%7]) with mapi id 15.20.5880.011; Sat, 3 Dec 2022
 07:49:53 +0000
Date:   Sat, 3 Dec 2022 15:49:30 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Honglei Wang <wanghonglei@didichuxing.com>
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
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        "Tianchen Ding" <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] sched/fair: Introduce short duration task check
Message-ID: <Y4r/iuqyLG4MOK4d@chenyu5-mobl1>
References: <7621888af45a89c3963b39e062695602a3b9499f.1669862147.git.yu.c.chen@intel.com>
 <8d976d4a-ecb6-41af-85b0-65e6022a0d82@didichuxing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8d976d4a-ecb6-41af-85b0-65e6022a0d82@didichuxing.com>
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CH0PR11MB5315:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b3c7487-87ac-4333-5922-08dad502f6c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZBAolcGkBogG3OTMWmCkPok2QXkWUuAfcIuAbO4laDpphsiU6SjAvNDSrX78U3iJDqqau5VhnmnGOEC7J90EpVIxs8eKEO2VZeaKiwDWxipHr6UbYhK7zq/0vG+wekPzsCC7YwJLBWVr0iJTeu78HJEp2Y0qm2YHAp85BmGRYba++cDwSyMRE/wx9hJmSAg/2L6osSPYrs3xfEfZzD996PAZgPIGxQuOMVKnDNKQ1tCWzJQ6g3jlD7gx7UgUvx9j7cPGCN4pZdLuidfnt2bPpOhyQH/HOAnpFXtHzlqvhoUsKPll5Wcn4mHtOZRK9z/0DH8eGd7LaBQ8stJzrnWHID8qalqDIFII6I+CEZVKMMb+PBqAOwM5vyZfph0sX7BTYRy26JmJG5SL5DroucbDO3hvWSnWRTsc15H9o4hoJ9WIVH1VJhe0Mm/2rBxXQrhk4yuNLSQbjYXn+sD0Hab/UML9oaSV+VqTJYFXNoBxRQWFJ/rig3lsCkGRsYhAq7pdJ08TnsmzDZIeM/gkJHPki4/tuHPZveqm1kV06M/ZJC2wI3LN4G5rW7qUL8hEBoFCddmo4PDE1ObtBk1PVjyO8dUM40dlsSP5MO1mt5Ov4B4l4Ov8m4R6+xUU+XleBpd6nfqYeR6/aYtujyytrTzKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199015)(86362001)(6486002)(6916009)(316002)(8936002)(33716001)(82960400001)(66946007)(41300700001)(8676002)(7416002)(66556008)(4326008)(478600001)(66476007)(83380400001)(38100700002)(6506007)(9686003)(53546011)(2906002)(26005)(5660300002)(186003)(6666004)(6512007)(54906003)(66899015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TYop7csf20Dzw0JD0mBOTbsKaiDssyREyUbXJqsZc6jWn3o6jGcp3Aw2kbsJ?=
 =?us-ascii?Q?kjwN7vNL5wgCCOdOOoqSbnFaGrfHqC2ylZ5nWably5HII5LknoV/A+Lr1bKh?=
 =?us-ascii?Q?78ThyOx41LZBkKfVZJgwgT+KcE6/lCTULGqsLgDJN9rRiwK9N0GKTHuQhZ6G?=
 =?us-ascii?Q?h8bSsM7YW34HXq57XZdw+gE1oVRsPyhfbVcTa3j9K9diERxQCaz9iAj2pLbZ?=
 =?us-ascii?Q?xi7ycjObrGpcmY3W1G442ajVjaKdkkQ2Xfpk57Dpub8zU3FuF1oWZ4HVh5RG?=
 =?us-ascii?Q?gS67LJ9PHVfLKHK5zHTZODDk4vOWRfjzNKnWUOTal8pV37i3z2o8PVEpiguO?=
 =?us-ascii?Q?bL7UaSZM6vlnOt7DVeHYCPGFjPPe1KMz4Dqv52ZiNq2xVNpo7yX4OrcUyMZs?=
 =?us-ascii?Q?Kme1vXtidsu3InU7MYoKC/EO3czu5aITE/vb1DOk3718J/XaWECxbFK5jlib?=
 =?us-ascii?Q?c7R7kAhtKr4UQy33VJwuHH2o5Ispdbwnl/Lfm3wQImtdSM4D8prIBUDfLvGF?=
 =?us-ascii?Q?ncGL3iYTh6mNBFQnf9guFneiDIkXHlkboWE46AZK/IbUy1M5vLsvaZxJ2o9W?=
 =?us-ascii?Q?pKSoqKEidA3ItPdfSsvl1onE1cdIglgmAa59RH+1t3s5Ir56daJ4NIbqxeP3?=
 =?us-ascii?Q?mxqCCRge4dBt314Z3w2wpPDXMaCgZWMdFOCsI4TjzaS8rJwHgRxlroLVtltJ?=
 =?us-ascii?Q?gG82Svo4W1VqdehxJGR7+FCooIcYodjc6AflbTJ1B9vedusCcpy7FUt6czCO?=
 =?us-ascii?Q?53NGYaDWOQacUEiQz6jXV57iEZJ/XszLGb/WdUA+sPZDNoHrYzKwIfjRr9pW?=
 =?us-ascii?Q?yrwnRP45EjoferaRpAP8xsrEORGbJUmLp2CqBd3XFWSNzLQhZ3/3vzYC6P2Q?=
 =?us-ascii?Q?1qG25sXbz7VBh7EBo6VgIkmQE44WfkRw1I2AfyCyqTgddcySUcRm2j6BiSJe?=
 =?us-ascii?Q?8eAywPI02hY/eko7NSuiFgdrQ8J6xh7RxFcTitZ7F6e84YfhGjyOIBuaAzQ2?=
 =?us-ascii?Q?DYgLWmqm0dO66dEwFDGxDYH4RHBn9CykdPoPTN8K8GqaRRLsc/R35qid6C1X?=
 =?us-ascii?Q?117NpfD1n3EegzsPWz67Y1muu1MxsL86XbWI0msL4jrlsglQzTLOJCYo97DF?=
 =?us-ascii?Q?5VoLTxsPwRUppUCSuOkohgin+1G71WdDyphVyTpeiPMj6OVcHZbwyLwemcYp?=
 =?us-ascii?Q?qZDkYOdRCzE7hHV9NRyDYx4KFlJr/GCX6N/PCM0Olnq+1co4mBMrmjvoPFmD?=
 =?us-ascii?Q?9Ih7bRmEEVCOr20Gh7w1l0mdsJFZAaWfb1xK/VKWEo8adbWWx03d6lX8juQN?=
 =?us-ascii?Q?VlytUiYe7eKzGEb+jHodnHA7XKuxwszmgjvv6qQxRp3hmU0AsTzjIRvkU5fo?=
 =?us-ascii?Q?8BPK5z4FD9vT2V0u8WCZqLENgwovqBkTv2gVYNKiPcK87kPNoVx6UF9vr4Yy?=
 =?us-ascii?Q?WXJwD+Tvmv6WOlkS4qC9CM4mxwyD0m9Fj4yif0VFP3zMzw1/nzzO/u2FCXv1?=
 =?us-ascii?Q?rV/tbJOOSoVkCk+ClSj6WDEcxdKtCMdS6LVlNnCF2MBxsqNa51Az2c7CII+U?=
 =?us-ascii?Q?if6fEbbVlZOoQTsm5FJY7vmlwEjZq3aaivms0tfZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3c7487-87ac-4333-5922-08dad502f6c8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2022 07:49:53.5353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9lg6plM5jORA+vqTVxGPB+DmJRH/HBkNiidjUJcmGhgIzQXVx3tW9Jj5i8uqgChjN4ANJw+zOi5UxSkAUzrpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5315
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Honglei,
On 2022-12-02 at 15:44:18 +0800, Honglei Wang wrote:
> 
> 
> On 2022/12/1 16:44, Chen Yu wrote:
> > Introduce short-duration task checks, as there is requirement
> > to leverage this attribute for better task placement.
> > 
> > There are several choices of metrics that could be used to
> > indicate if a task is a short-duration task.
> > 
> > At first thought the (p->se.sum_exec_runtime / p->nvcsw)
> > could be used to measure the task duration. However, the
> > history long past was factored too heavily in such a formula.
> > Ideally, the old activity should decay and not affect
> > the current status too much.
> > 
> > Although something based on PELT could be used, se.util_avg might
> > not be appropriate to describe the task duration:
> > 1. Task p1 and task p2 are doing frequent ping-pong scheduling on
> >     one CPU, both p1 and p2 have a short duration, but the util_avg
> >     can be up to 50%.
> > 2. Suppose a task lasting less than 4ms is regarded as a short task.
> >     If task p3 runs for 6ms and sleeps for 32ms, p3 should not be a
> >     short-duration task. However, PELT would decay p3's accumulated
> >     running time from 6ms to 3ms, because 32ms is the half-life in PELT.
> >     As a result, p3 would be incorrectly treated as a short task.
> > 
> > It was found that there was once a similar feature to track the
> > duration of a task, which is in Commit ad4b78bbcbab ("sched: Add
> > new wakeup preemption mode: WAKEUP_RUNNING"). Unfortunately, it
> > was reverted because it was an experiment. So pick the patch up
> > again, by recording the average duration when a task voluntarily
> > switches out. Introduce SIS_SHORT to control this strategy.
> > 
> > The threshold of short duration reuses sysctl_sched_min_granularity,
> > so it can be tuned by the user. Ideally there should be a dedicated
> > parameter for the threshold, but that might introduce complexity.
> > 
> > Suggested-by: Tim Chen <tim.c.chen@intel.com>
> > Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >   include/linux/sched.h   |  4 ++++
> >   kernel/sched/core.c     |  2 ++
> >   kernel/sched/fair.c     | 17 +++++++++++++++++
> >   kernel/sched/features.h |  1 +
> >   4 files changed, 24 insertions(+)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index ffb6eb55cd13..64b7acb77a11 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -558,6 +558,10 @@ struct sched_entity {
> >   	u64				nr_migrations;
> > +	u64				prev_sum_exec_runtime_vol;
> > +	/* average duration of a task */
> > +	u64				dur_avg;
> > +
> >   #ifdef CONFIG_FAIR_GROUP_SCHED
> >   	int				depth;
> >   	struct sched_entity		*parent;
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index daff72f00385..c5202f1be3f7 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4348,6 +4348,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
> >   	p->se.prev_sum_exec_runtime	= 0;
> >   	p->se.nr_migrations		= 0;
> >   	p->se.vruntime			= 0;
> > +	p->se.dur_avg			= 0;
> > +	p->se.prev_sum_exec_runtime_vol	= 0;
> >   	INIT_LIST_HEAD(&p->se.group_node);
> >   #ifdef CONFIG_FAIR_GROUP_SCHED
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e4a0b8bd941c..a4b314b664f8 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6200,6 +6200,16 @@ static int wake_wide(struct task_struct *p)
> >   	return 1;
> >   }
> > +/*
> > + * If a task switches in and then voluntarily relinquishes the
> > + * CPU quickly, it is regarded as a short duration task.
> > + */
> > +static inline int is_short_task(struct task_struct *p)
> > +{
> > +	return sched_feat(SIS_SHORT) &&
> > +		(p->se.dur_avg <= sysctl_sched_min_granularity);
> > +}
> > +
> 
> Hi Yu,
> 
> I still have a bit concern about the sysctl_sched_min_granularity stuff..
> This grab can be set to different value which will impact the action of this
> patch and make things not totally under control.
> 
> Not sure if we can add a new grab for this.. The test result shows good
> improvement for short task, and with this grab, admins will be able to
> custom the system base on their own 'short task' view.
>
It would be ideal to have a dedicated parameter to tweak this. For example,
something under /sys/kernel/debug/sched/, and initilized to sysctl_sched_min_granularity
by default. 
Hi Peter, Vincent,
may I have your opinion if this is applicable?

thanks,
Chenyu
