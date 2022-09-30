Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53FA5F104D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiI3Qxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbiI3Qxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:53:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4AF1D84A1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664556824; x=1696092824;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZlB1TIp1QmBQa5vMkurvlRZBApVwAD4rK4oLlj+ubH0=;
  b=jfV9ndd2zfP5UwS54KMEga5g1gI2eE2vqnOwx+8jdS673RAdO8Yyugkq
   DjYYCnScxMzBTZML3VHCALrHSHEA9C6SIFLP5juaFtY9poE8I46rA5OJ1
   o5PFfJpY6dN90AHOqo3cBDbsaGVP7kqD1AjPQCK+Q0E/u1l0jacosTtIG
   tMJkpWK+5bYra33ZE46mjhEI5dFSpZQYoo77J7FSTGV1hI29NgOBiKfl1
   Y1tqKIAhtG1vs+66Gv0Vq32YbNZ5BkIQJddAa9b38XAGQU6uN/Fu3KLKV
   oU1aU8CZiGcUkBjX3n1Wota7546mch6GTxbf5+IEbgOWjjSPT0mAwiduQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="299838482"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="299838482"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 09:53:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="573922234"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="573922234"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 30 Sep 2022 09:53:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 09:53:43 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 09:53:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 30 Sep 2022 09:53:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 30 Sep 2022 09:53:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAzre5j5pZKC8tBbcPm1gn8dIIWVNpeIbVyuKfp8sv39tKxKckU7VkRUvCZwcHe5wwPls545T2knUHbPH/bs1+pNW8YD6z4hJI7DDGvuRLAjbJYED4c+wVdTTkhPuPaRRbZIYO4LIgfH2UrV69+kwbBilddlUFdDZnt+70rH5mSYEPqbb6+gLeCYdUosKVKnNytl1jD1iDi5IpxDIRq/bagdr17xI4d30fubsW1KGsRDa+es2NzfceLQU9M1HDCS7aEt7UwGISpBGNFmmrVTKRV32k0BCshQJ92W0zB6KM0h+KRcVA1PImTYaHyuh/2ck4wZZMCpgHEivlO4y2Db8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZHN/WIIbGLZJftj93QubrYMNaGBGoLoSRLkzGEsnbE=;
 b=O3gcn3YEyDf0F9LyWLh1g+rupv5bw/RJfooSUKULJw0Cz5nDnYKGQBTcyMYewy1YxrvDWSSFA5a1MQf7rUI/r9/1YhVPKhU2X+o2lYOOCsCPhjV921AHFgnNDZd6i6YnALGYp8tFf4UpjO7IxP86G8ELXA1YdrIONWRUF8XkG9OwAQpWRhzzhdgd/FgyYmRpoOhS6yiPDLH7J5xi55itSeAMgExC5yfehTZPSpqyPV20ewivDguYhxVCctFAO+fSQKAWmdhENHM6CEteDTU3ABbwvVqAh+dyqKFiuZRhwZFZ2iTcK41bVfiY4ro0YoWfRz5njZQhv/3iRQTxdk3mZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BL3PR11MB6434.namprd11.prod.outlook.com (2603:10b6:208:3ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Fri, 30 Sep
 2022 16:53:40 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43%4]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 16:53:40 +0000
Date:   Sat, 1 Oct 2022 00:53:20 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
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
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Choose the CPU where short task is
 running during wake up
Message-ID: <YzcfAOLswvY05s0n@chenyu5-mobl1>
References: <20220915165407.1776363-1-yu.c.chen@intel.com>
 <CAKfTPtD3L4437htX__mCNBZJ+fv4MEdnNhCG2kBoQYhVESB_fg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtD3L4437htX__mCNBZJ+fv4MEdnNhCG2kBoQYhVESB_fg@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0208.apcprd04.prod.outlook.com
 (2603:1096:4:187::10) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BL3PR11MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: af5174b3-6ec7-4fbd-157b-08daa304537c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ckv88RD9klKJBEUoxBFERnqGSURViCZM6sFVqqi+oAzK/sz+JpFpNadQSqOOZRAUTBKvkOfKdRArv/Swab2IpVX6d8zZ2sVxPo57gMZsMj6IoYvYFLr8gjZ/n9qDHtMoOUAh3PeXp7sbFxGf1VSo6KfKA7VTb/mvkSsc1cCVosl3Q1Kiu2s8UQ5lxRu9Vq4vXkAOxAMFBLeM4dV1ogi0YCoeFBIDE/SelQ3fTW6fPtLZ9JUMGt++uQdI/FjLgZRXsTwkIgDTgny3PY2Y0MlYFwnMoWNboVHmgQwdvU6FHNnH10I3lP6W035AejIUKhvujrgMybB9NIWgleTAS+K6tj0Z/XNNW4ucWoabFavy7rdFO3RMbZkNf0QI2NOkwBf1SVL/Jfx1cYpbYOo70lFvIgK9zULyqfzzyjiuBWglsgUIJhnMFYnaXuMSx1PaIbg8cvtL0uTfmi7Bye+m/p4FSf0Sa2olzvlDlJ0Y2l1j5jebRsRd91lRS7ZBYghkGAILGri0MLv1CjdpCt9eXyHBdLbqoA/yaSo7tLCSwUyyFcY6U7Rsm06McLgoPnEZrY6ZqCBRgYVhq8jxWwwAlrgUKymJ9bKeP636UWYCN5TkJkF0JNRXNbVJLgMM9qNidPVgCDLKI6kBtZqwI7d3bKN2LxKnB7OillbI8aHENiz0bmbJOxCQxQBQuVu7TEVJPH3IU6xDSr4voRghnfeDUcL0nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199015)(83380400001)(38100700002)(26005)(6512007)(54906003)(9686003)(316002)(6916009)(2906002)(33716001)(186003)(5660300002)(86362001)(41300700001)(66476007)(7416002)(82960400001)(4326008)(8676002)(66946007)(478600001)(66556008)(6486002)(6506007)(6666004)(8936002)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/zC9D5c6HC5bHVWo8t1DcwHPhxqhHjCi9ZKTX4+qCqaJ46i6OBiREFqsiWXF?=
 =?us-ascii?Q?0loJmejq8y0WSuYJ9Uydezuuv901GBxfz+XTFn8vxyNGz3L0QKKAuqH0roG8?=
 =?us-ascii?Q?DtqS/tt4aYAhV+FHUeSwVFG0o1KGr7dkEYpFIjA3rCfoGuvbcUputOvnzX7u?=
 =?us-ascii?Q?oyYY9ED7URSTH9DCxEZyFPgjh5SX0v2Xnhy7D8e5+UwwOcJ9kKe4bXoNLKmM?=
 =?us-ascii?Q?8yPIZ7SWCd6+EQQl953QmkAx/JqMxuB3yn0B7sUoHGyzGuX2JFnn8nCOx5r/?=
 =?us-ascii?Q?KSKqlFIjfqrAve2Nd2RlT+FR3JQmEnVnFsuScbEb103FxaP4RjrMDZEvxA1W?=
 =?us-ascii?Q?9VRQXe/fYkv862jEZw7NpYlg5WHk5KawRQiwCzkYjWTRHQJZ7XbBhiaUht3l?=
 =?us-ascii?Q?mG4WTDtANvcElA8cFbIKvtAF7eLGhFb3iBP1W85vOwTM6OIUFALSCeUOEOHl?=
 =?us-ascii?Q?XzSppI3U3np2BWli9ygIpmDyKOiygV7jUr/NxPRRMOH4+YuXIco1z2o/mVCc?=
 =?us-ascii?Q?liabC24a8nWc1sTWKUtknflW/lCPh6QVAJe+ShKdSc/T0OHa7qqCtK8L27By?=
 =?us-ascii?Q?i+M0yZ9lIy01Takk95XcUWYxAh/Zw60W+nJqrNB+mbnjuA1DlkMmKfySibnr?=
 =?us-ascii?Q?zRTxZ9FaJwDJAL2ltZO80/e3rtcmugXOL3duioRi1AZ3O6xuAaQHwkxtsmnW?=
 =?us-ascii?Q?GYzOSLlaK40H+9IIonwoLPkauT5G/WlYWBGZ1ZN4ACq77wimAOqmyQ17vpUS?=
 =?us-ascii?Q?mK3j/gl2AGsM8+1tZNHAvERSlK6Z4kbmER/9ELDZnFXt/ehuUyyOlwqfAjwt?=
 =?us-ascii?Q?YwNCLScnS5d0MTwW0WBKcDly/7GOGdHqv892Fb8kMBBYoK2XiqzsOhWcfX6A?=
 =?us-ascii?Q?V60lYjNTWVyWltrJpdA7V61kJ/WTvglTTZ2Z/D7VNGeCngzuuYMOvDmWrwOu?=
 =?us-ascii?Q?uwp53MRUvhBcRiTcg47qNyLnyEjHxLzOLjO1WJDgcVo3Og/r5AtdKXIGYjux?=
 =?us-ascii?Q?NpxHLK++Q3qCmoTsXYMw9ue5VwhqO+Vtggi/tvxPq2dPVTAQ6lTYqMm9FXCR?=
 =?us-ascii?Q?8wCNVtZ1kMLTICWeIqMZmQmivPy36hNlgJG3uclusGh+yCx3zb/jvDfHevub?=
 =?us-ascii?Q?OIHIGhV927Gw8jguNnsqX0eFwcil4pB/MXpRURY64L4ERbCSd0sC8uUhS9hA?=
 =?us-ascii?Q?FTBrKIZO+zxphzUu7H6HRh3cG4TXw8U31f26heS2kxkd7XaG8oFH/iRdYVaT?=
 =?us-ascii?Q?FwuNHbBdyo5SyWxWY0kREkWLGmDdUyRTlcUxcKTU74Dz0nNV0DUDjoRPZ6HW?=
 =?us-ascii?Q?sd5uu82VoCJOfS+Aa2Jp5/ymQpq1SOmjLvPrCiok+b+MyqJnrtTJjgz67hfG?=
 =?us-ascii?Q?TMuJanTVyzNxsn6vv0MhYFf7OQ7+yAZbGoQkxaQ4p3Kzp/ItxPSws7wQWQ2C?=
 =?us-ascii?Q?c0/xVS4p7u102cNe3ostYXbwcRJVNFGMUpASDqdYOi3FVl1aFiIYSkXkA8zT?=
 =?us-ascii?Q?BIa1d+KO9NLLjnN/bVJ/W2eblNnoL5DMjARA0+VSU5UxcMdvtVCiNJoACzcN?=
 =?us-ascii?Q?W5xNQTy5a0WtuU2tDNdG6e6FvV+ENeDkPHUx/oac?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af5174b3-6ec7-4fbd-157b-08daa304537c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 16:53:40.6714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6azrVRn16gPJexaxREzRvmRtVBia2H+CkAtsKymBRwbPcsxMZ0tGIDtZXeEheKJLkSqAne3HrunvT/IcDkmfDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6434
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,
On 2022-09-29 at 10:00:40 +0200, Vincent Guittot wrote:
[cut]
> >
> > This idea has been suggested by Rik at LPC 2019 when discussing
> > the latency nice. He asked the following question: if P1 is a small-time
> > slice task on CPU, can we put the waking task P2 on the CPU and wait for
> > P1 to release the CPU, without wasting time to search for an idle CPU?
> > At LPC 2021 Vincent Guittot has proposed:
> > 1. If the wakee is a long-running task, should we skip the short idle CPU?
> > 2. If the wakee is a short-running task, can we put it onto a lightly loaded
> >    local CPU?
> 
> When I said that, I had in mind to use the task utilization (util_avg
> or util_est) which reflects the recent behavior of the task but not to
> compute an average duration
> 
Ah I see. However there is a scenario(will-it-scale context switch sub-test)
that, if task A is doing frequent ping-pong context switch with task B on one
CPU, we should avoid cross-CPU wakeup, by placing the wakee on the same CPU
as the waker. Since util_avg/est might be high for both waker and wakee,
we use the average duration to detect this scenario.
> >
> > Current proposal is a variant of 2:
> > If the target CPU is running a short-time slice task, and the wakee
> > is also a short-time slice task, the target CPU could be chosen as the
> > candidate when the system is busy.
> >
> > The definition of a short-time slice task is: The average running time
> > of the task during each run is no more than sysctl_sched_min_granularity.
> > If a task switches in and then voluntarily relinquishes the CPU
> > quickly, it is regarded as a short-running task. Choosing
> > sysctl_sched_min_granularity because it is the minimal slice if there
> > are too many runnable tasks.
> >
[cut]
> >
> > +/*
> > + * If a task switches in and then voluntarily relinquishes the
> > + * CPU quickly, it is regarded as a short running task.
> > + * sysctl_sched_min_granularity is chosen as the threshold,
> > + * as this value is the minimal slice if there are too many
> > + * runnable tasks, see __sched_period().
> > + */
> > +static int is_short_task(struct task_struct *p)
> > +{
> > +       return (p->se.sum_exec_runtime <=
> > +               (p->nvcsw * sysctl_sched_min_granularity));
> 
> you assume that the task behavior will never change during is whole life time
>
I was thinking that the average running time of a task could slowly catch
up with the latest task behavior, but yes, there would be delay especially
for rapid changing tasks(and similar to rq->avg_idle). I wonder if we
could use something like: 
	return (p->se.avg.util_avg <=
		(p->nvcsw * PELT(sysctl_sched_min_granularity));
to reflect the recent behavior of the task.

thanks,
Chenyu
