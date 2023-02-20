Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E0F69C4D8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 05:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjBTE6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 23:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjBTE6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 23:58:47 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCC9AD37
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 20:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676869125; x=1708405125;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=tgQYcs0NDkmTB4QjLKCeNbOMCqM25Fx4YOPUBANoUVo=;
  b=nPi+MZI/+mcDO/4InP1AjvIlxS8fV4n5vAy+t3+K2gzm4DNTnlDdUt2l
   rk7aFw8mn4zP9U5mOX073PS0rAeaCMIoA/KakOfZRsoWdP8/3HIa/R2nG
   K/c2WKV/OHKh6RF7gYdABnyH5tds0rIJRpjXmiY1C6cLtJqDQx1FuRXHs
   62e3HdWHjSQTzvRhxX7XtGpPsjWijyc5OS8bGIYR2YVF0kKefkA/RgaYj
   b0xoFBLMqtgSDpSRNIJjHc90/jpJifINaWUt1QSKOjQlM7NlTXzXHFPN2
   RZ7c5kHJAmUsWOz8nEI8v3oNPu5bSkSdRKjUqtKmQxVf8KmDAHJQ+BSQA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="332328329"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="332328329"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 20:58:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="648711570"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="648711570"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 19 Feb 2023 20:58:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 19 Feb 2023 20:58:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 19 Feb 2023 20:58:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 19 Feb 2023 20:58:44 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 19 Feb 2023 20:58:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQFOXko8HNt8oPaPedqXV7RDt06ZfxI7zo3sL87nkk0mxRO8ZcHwE24qjaT527EzGHDugaTODr7b0PzzoO3dVWasJe7t0zoltcptEGISaiTNo3RlMooYwQCp7ly4el0eShQKGn72xr/NlPZmuqFKKamE1CVMhM/q3L+ZBjwNtrfqTePRNRw7KKgdMY14TSui+OajsYmDrxbF8nL4RJs6mCmG22L4X2NPZe1LPG1+nQMjnGKnJJhFhDIWukGg/IUetgy1K08F5WxLixEQzVUMJGdcZYwLO1HtV41ldRZIcaO/UbeKypVn08ptYZZO0CYZcO6RuqXn7qbfCMHaceTrRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WrVgZ1tA60Lj4tARNpE1tbYRGNT5lmhx5aJk2z/tk0=;
 b=PfX72WUFtjunjKCkBWVPuJzduc0rw8rD58vphiBwH6APaLtAwvToJOaJQtNBvreedZal4aElYKTVpNO5+SaZ/8Q8DMhJk/E5/KyILL/pAUMQOby7q8XTpW+nFY99rTkHwIJy8JqMD+dSbWvSwRXSkiUJIc4GIDXYEugXiNyLF6zkZj5qAEOQEupEUaZwJjfhxJE16XZCkOsNAQr6u8Nt9U80KUes8EbSHqxlQgwFNGGmkvOCj81xsW1BMrh+l8HWzbgT8D8UArV7wUAmN+If6KJO+Xi8bhadm25l96uXgm7EiVKZuyhqQ5iABnlcS2QCLlpGLBD1P6SpxMb/yL9GLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BL1PR11MB5512.namprd11.prod.outlook.com (2603:10b6:208:314::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Mon, 20 Feb
 2023 04:58:42 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d%7]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 04:58:42 +0000
Date:   Mon, 20 Feb 2023 12:58:24 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Honglei Wang <wanghonglei@didichuxing.com>
CC:     Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "K Prateek Nayak" <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        "Tianchen Ding" <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, Hillf Danton <hdanton@sina.com>,
        <linux-kernel@vger.kernel.org>,
        kernel test robot <yujie.liu@intel.com>
Subject: Re: [PATCH v5 2/2] sched/fair: Introduce SIS_SHORT to wake up short
 task on current CPU
Message-ID: <Y/L98AVIqkBPVkWG@chenyu5-mobl1>
References: <36ba3b68-5b73-9db0-2247-061627b0d95a@bytedance.com>
 <f88838ff-2024-ca32-069e-f7a4c0465961@didichuxing.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f88838ff-2024-ca32-069e-f7a4c0465961@didichuxing.com>
X-ClientProxiedBy: SG2PR04CA0192.apcprd04.prod.outlook.com
 (2603:1096:4:14::30) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BL1PR11MB5512:EE_
X-MS-Office365-Filtering-Correlation-Id: b300d59a-0c43-41cb-ffe9-08db12ff2347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wIjFHzcomuAbOpStfeWK5Hr6pA5dOWFtI7DW2ch502ulRlW2sLxq/v6sGcN9iEHrkRNhDXG87UHin3MmEjhr4LBnhjeeCQXQim40/QHOkpuBajea0QogAXhmAGptXR8nm/NOT9jg9mLjwohBw3ghhiApiubxhYzb1YLu5/kpF3OjCsnyPlrvYH20psiNWyRpqbZu+i0UQAjAeR4LBUiAp6rdUhJGF17ALs8GgujC4nbgCtsAd0S2hml6jPVapauhJXKfX9+i/MtC+Vxg/Ryapbntn2MxdltujUt7Lpt3pF4IZorhxGsq/HSZzXxod+2vH5JGvwPff5DguF5Mqhv3fkF9SPl5kK3CRa5CGznrB4Arzv9QdDjrHpwRyl1NIGw9/2+n29NFo3XDBlpxOFNA3LVOznDjeMyyMa7/mL/eNjNRKXuL4voU0Se7Id7EnJWinfr3NWbxkbvJMkZ9lf/MkuChxqOziH6dL+Qf9YleDoIJRgsNRT0laWlXzISMCOfyMJq1LAV8QhXALNttc9CIU3B7cvGfEX0bL5ZcG1e4+XNrUVK13TpjzmyzSqaiTOgK6K6DGcF7Gy9uNXu1D0iWPkxDF+Sr15oRqboqazcQd9EQ9MbhhgfHmSAxt0tmYSb7hXNua0VhiZvfVRpBLXDitQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199018)(82960400001)(86362001)(5660300002)(2906002)(7416002)(38100700002)(33716001)(478600001)(6486002)(53546011)(9686003)(26005)(6512007)(186003)(54906003)(316002)(66946007)(8676002)(4326008)(6666004)(41300700001)(6506007)(8936002)(6916009)(66556008)(66476007)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?osWNXR6klyrfGGf+hlo8zqn1HlbQ8NvUu+D4apE0vqW5ktH9+y0qR8k9Pf?=
 =?iso-8859-1?Q?uH3sGjI/KRlxxCfWpbFBsIRRALEeKjZtFkhYXdz15ARsycR0TpXTjrAMdd?=
 =?iso-8859-1?Q?GATgeuLhC735wDqPk8CBf0juvbVJzBrQx0keCplv1n1atylpdbXXY59D7g?=
 =?iso-8859-1?Q?4SZ/BMaI2gbonstY6U333EqgZr74oIEPKjfa2lGPG2JHIrxnDd5QXqGL4/?=
 =?iso-8859-1?Q?mUEFWc9NWRpYSBUna+7Flsl/TsZ/Xx7lo8OlmT4XcNdOYD4WtQ2K/eAiIV?=
 =?iso-8859-1?Q?K3jgsgn1lPMItAFPZyhj/yrbI12AF/fWc/BLLXSJEMVTXKBHIooLQt7YVT?=
 =?iso-8859-1?Q?NxN7TW7LXxbFRizMklACkGhDqkEjHBnBWkcvMX+BoscFKViAEC2N5hzVaw?=
 =?iso-8859-1?Q?bG2FfQRZk0TxBILyIg6LH0f/BqT1Q0yKUONckLX9SqgLj0MarJb17uiYNT?=
 =?iso-8859-1?Q?QRbT/vL6Wk89tyG5lnTSX0ZONTcnvQ9idSdHlXhaPFlA4/FnpYcmw+XQVb?=
 =?iso-8859-1?Q?bUXxSnKnsjJwlA+xHzKbvPN6Q+Z7OS/Wrl38dOVPnd6PphKfmZ6FRPm+nn?=
 =?iso-8859-1?Q?ClioOpL9R05LUWvpRp0bKNVtOMFFFfe5ZI0D1bgbTok8TDIdBnGrxupuq/?=
 =?iso-8859-1?Q?d+s7UWiLsOs7pFYBy9LAf3FEV5RQ9l+TQlrnJb8YxFCLQDo6UpFzgTYhO9?=
 =?iso-8859-1?Q?mVSrrZKUX+42Jjq5wCODLNRkqYsIT3dImZVbC2aNWK0j1h/TSAFDeunthy?=
 =?iso-8859-1?Q?ajiqZyIO/C9pEufBCmHJZIGMcuf8ELAyTVEq53nEych3OHVRwy90VsD5YS?=
 =?iso-8859-1?Q?naB980KsVLectZwrhz6iM9fga7ZzJeHkV46zDGtS+wSbh9fR26Q39BGify?=
 =?iso-8859-1?Q?K48J/FwLWWtv9TGGYvtOACvwbw0QND0IKzXslhi6Eas68n6SY+DknIu346?=
 =?iso-8859-1?Q?oXbWjHQNv0orxnEyW7Pn4p3EfJ25nTbW4FiRNbgGi5unIIjG0iW/x+HCx6?=
 =?iso-8859-1?Q?h4mfnFVaD6el8V3vfZUWHkdy677F17nbZIeagl/G0a22fBDIE2uesaiFcG?=
 =?iso-8859-1?Q?GQ9AeTAXLKlMOvOKqLltXroUnWwbh2TMVKKmmNGIA5SsHCsXyfn3A9fr54?=
 =?iso-8859-1?Q?v5Oxy+VLyPOI35AlitbgbqfEmN7aup+WxCYrE+yknwk+Nd0sB+rgbo3bt7?=
 =?iso-8859-1?Q?lVRXO6JNvfzcf+O/sdz3FWR5gEz5mfs+0EZoTRoTTUo0WDws/PVM3MoF+d?=
 =?iso-8859-1?Q?oCHSwcIpmrXYSjRBuiflbIi9vEcSFvWqnEMRaUTRXhRDjuFa1WXGtwlsjG?=
 =?iso-8859-1?Q?Pd1sYcf7BfSaDgweApUrAL94Gg2u/J30eNJo/dJZDNB0pBP4XqCI1A04Fq?=
 =?iso-8859-1?Q?dxUFHaQzcaxpYUjN1AltbtvArQ8xVCxaAlgQlhisTb+8DuTAAyoGg9hinO?=
 =?iso-8859-1?Q?Ucj5vEIy0c5dnvUNeXMRomnqI8VA9X51qK+VNEIxCgsPl/9PaLRQ/NAyBI?=
 =?iso-8859-1?Q?qcIPwyXHWziPxhCRLrv3u/TGUPJZtGM029Br8dPLLq33zXA6mpXrIhfWe6?=
 =?iso-8859-1?Q?TK0WiyGEMbfKdqY3xrSTIdIukJVZ2kgd6YW2Pw6I6aQ4rQwsebFAJHtHvy?=
 =?iso-8859-1?Q?SUN7g3R6CqbSnOuLQJntb3Wg95FsinQigd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b300d59a-0c43-41cb-ffe9-08db12ff2347
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 04:58:42.2985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38d8Ti64ljBps7f7mp3sQNAQzeCqgtapg2nUKDFCmgzvq3jHNLuN+4DpX3r1PjrZkneIx1mpuJaCxG4Ck/o61g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5512
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-17 at 16:35:24 +0800, Honglei Wang wrote:
> 
> 
> On 2023/2/16 20:55, Abel Wu wrote:
> > Hi Chen,
> > 
> > I've tested this patchset (with modification) on our Redis proxy
> > servers, and the results seems promising.
> > 
> > On 2/3/23 1:18 PM, Chen Yu wrote:
> > > ...
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index aa16611c7263..d50097e5fcc1 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -6489,6 +6489,20 @@ static int wake_wide(struct task_struct *p)
> > >       return 1;
> > >   }
> > > +/*
> > > + * If a task switches in and then voluntarily relinquishes the
> > > + * CPU quickly, it is regarded as a short duration task.
> > > + *
> > > + * SIS_SHORT tries to wake up the short wakee on current CPU. This
> > > + * aims to avoid race condition among CPUs due to frequent context
> > > + * switch.
> > > + */
> > > +static inline int is_short_task(struct task_struct *p)
> > > +{
> > > +    return sched_feat(SIS_SHORT) && p->se.dur_avg &&
> > > +           ((p->se.dur_avg * 8) < sysctl_sched_min_granularity);
> > > +}
> > 
> > I changed the factor to fit into the shape of tasks in question.
> > 
> >      static inline int is_short_task(struct task_struct *p)
> >      {
> >          u64 dur = sysctl_sched_min_granularity / 8;
> > 
> >          if (!sched_feat(SIS_SHORT) || !p->se.dur_avg)
> >              return false;
> > 
> >          /*
> >           * Bare tracepoint to allow dynamically changing
> >           * the threshold.
> >           */
> >          trace_sched_short_task_tp(p, &dur);
> > 
> >          return p->se.dur_avg < dur;
> >      }
> > 
> > I'm not sure it is the right way to provide such flexibility, but
> > definition of 'short' can be workload specific.
> > 
> > > +
> > >   /*
> > >    * The purpose of wake_affine() is to quickly determine on which
> > > CPU we can run
> > >    * soonest. For the purpose of speed we only consider the waking
> > > and previous
> > > @@ -6525,6 +6539,11 @@ wake_affine_idle(int this_cpu, int prev_cpu,
> > > int sync)
> > >       if (available_idle_cpu(prev_cpu))
> > >           return prev_cpu;
> > > +    /* The only running task is a short duration one. */
> > > +    if (cpu_rq(this_cpu)->nr_running == 1 &&
> > > +        is_short_task(rcu_dereference(cpu_curr(this_cpu))))
> > > +        return this_cpu;
> > 
> > Since proxy server handles simple data delivery, the tasks are
> > generally short running ones and hate task stacking which may
> > introduce scheduling latency (even there are only 2 short tasks
> > competing each other). So this part brings slight regression on
> > the proxy case. But I still think this is good for most cases.
> > 
> > Speaking of task stacking, I found wake_affine_weight() can be
> > much more dangerous. It chooses the less loaded one between the
> > prev & this cpu as a candidate, so 'small' tasks can be easily
> > stacked on this cpu when wake up several tasks at one time if
> > this cpu is unloaded. This really hurts if the 'small' tasks are
> > latency-sensitive, although wake_affine_weight() does the right
> > thing from the point of view of 'load'.
> > 
> > The following change greatly reduced the p99lat of Redis service
> > from 150ms to 0.9ms, at exactly the same throughput (QPS).
> > 
> > @@ -5763,6 +5787,9 @@ wake_affine_weight(struct sched_domain *sd, struct
> > task_struct *p,
> >      s64 this_eff_load, prev_eff_load;
> >      unsigned long task_load;
> > 
> > +    if (is_short_task(p))
> > +        return nr_cpumask_bits;
> > +
> >      this_eff_load = cpu_load(cpu_rq(this_cpu));
> > 
> >      if (sync) {
> > 
> > I know that 'short' tasks are not necessarily 'small' tasks, e.g.
> > sleeping duration is small or have large weights, but this works
> > really well for this case. This is partly because delivering data
> > is memory bandwidth intensive hence prefer cache hot cpus. And I
> > think this is also applicable to the general purposes: do NOT let
> > the short running tasks suffering from cache misses caused by
> > migration.
> > 
> 
> Redis is a bit special. It runs quick and really sensitive on schedule
> latency. The purpose of this 'short task' feature from Yu is to mitigate the
> migration and tend to place the waking task on local cpu, this is somehow on
> the opposite side of workload such as Redis. The changes you did remind me
> of the latency-prio stuff. Maybe we can do something base on both the 'short
> task' and 'latency-prio' to make your changes more general. thoughts?
>
Looks reasonable, I suppose you were refering to 'latency nice' proposed by
Vincent. For now I'd like to keep this patch simple enough, later we can
extend it.

thanks,
Chenyu 
> Thanks,
> Honglei
> 
> > Best regards,
> >      Abel
