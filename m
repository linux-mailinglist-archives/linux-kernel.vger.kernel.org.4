Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2D673F674
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjF0IGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjF0IGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:06:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CABD1FCF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687853176; x=1719389176;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2tzxJQK+nVb/exsQTurKglEU4H6LnULZ4D02AIszRWE=;
  b=AH64bUwqAOSGpA94A355zTkKRwiXi1omX1jLm7xDOqTBUIkTGr4+RWvy
   KhfbteYVJ1PpDbNLmkHX8SFWohvxTSx0TW18mg/kAbsaS7J2lcVYHb7FX
   fdZjgqEpObn/ox6wjPCA3nW3oajqIEbuOTV7tMDSWddExmy62cZEdGN9x
   Nqi144Tmjf1QGg8hlvzXr2NS1Ac8LKCU0haIGvJYFxctYj5XqesNes5YH
   zrgIjYblkI3O0WrdRlkZ52CWjMzZQoxJRdbsCiZhMXEGhXv5orrRIH/Rp
   CMDHYUhP9xpLLBWJfZiVUapzm4p5nW8RA5NGjA4bIZpPApM15NyMyUywZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="361548740"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="361548740"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 01:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="751579390"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="751579390"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 27 Jun 2023 01:06:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 01:06:02 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 01:06:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 01:06:02 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 27 Jun 2023 01:06:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+eMFJkniUi537yuMsHWboelfBNydH9iv/UV4ubkcLVV65KDJVOvhookPkd3TydsW33FkC9Ivs0W35WbWaTV7P7gspbWSgM1SuZgjCeI9Cwk4yEJB1rHEDvoYQeuKXk8DqPIoyH6d2DA0AAVCadhEF9oHY7LCcjxxjWn74qtju7gtKcgHH2oJa2btaxXzmFUQrbafPAaLFknALu8c5GBZZTnYmPc8Knw7mFBhEUxSEz28rwnogSXuwVCFtwk1j0kUdSX1+LXuyOQFpFzZMjg35PXgglQVRUdkDIuJ9zp/IIRz1fDZcwmPKWL+7JypAfnZr/Q2KvdPn/Heoju1/0FNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUnzCqZqCcE8zt9oe3jfAEwClDAnr9rEHz2Inv6yUME=;
 b=OT86q1K6rhOa8wV4Amerov+FcaLqbjLSTl2AIZNU2NvpX93FRcZTjfWijvfXUtqRapw0KkDQYuX49w++mtdZb5r3V3r0KaNcb2t057jparmECRtYuxt509MrI7ZBIvyQ16ulMtvHUasP07twBQK072KSPNKEaj/tdxXd+dz5aJPx4YCQXR0AXCBaz+rm08Tx/xpWu1yQaGrQban/OYQySbdpnS18XUuya58RDp8+h3xrATlp7R1bnnPUpdDOOGz2nH9CvSsVYPmQZ25N9X7PSISBKHm/8iBaS7JfAgG5gDGn5AdQAk8jUM0Bm7gNKkXGvy5wdMajm9KsJRyAXJmBoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB5007.namprd11.prod.outlook.com (2603:10b6:a03:2d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 08:06:00 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 08:06:00 +0000
Date:   Tue, 27 Jun 2023 16:05:47 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Aaron Lu <aaron.lu@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Deng Pan <pan.deng@intel.com>, <tim.c.chen@intel.com>,
        <linux-kernel@vger.kernel.org>, <tianyou.li@intel.com>,
        <yu.ma@intel.com>, <lipeng.zhu@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v2] sched/task_group: Re-layout structure to reduce false
 sharing
Message-ID: <ZJqYW3Ul/nixpU9m@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230621081425.420607-1-pan.deng@intel.com>
 <20230626054756.GA435374@ziqianlu-dell>
 <ZJlDsbyNmcKtweg4@chenyu5-mobl2.ccr.corp.intel.com>
 <20230626125335.GA508448@ziqianlu-dell>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230626125335.GA508448@ziqianlu-dell>
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB5007:EE_
X-MS-Office365-Filtering-Correlation-Id: fca5b440-030e-4fe6-2595-08db76e55811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9zOaplX92ROAqgC2yalHBjaSbgidJvRBYIikvOlaYrTuMFzAzvROTPNmYTENKzNFFwyEWLMcY53R8v6y+JmH9CbeO3dAPYk1fhQJZOjVu3y0dXvpkjXczsl+XxCrmrhr18FqwbuaJnkW3BqXk4V19IgsZOx+NPMko0C9+z0sdslrkwT8oI1c5uhoQmyjVYiCtktPk/gVBJp63Nw1U2rhrAA4gzdM7jmbfBxLpa2UcohhSkCTuQhi3heK/90cIy7iyQZ7zS2RhLYqyElBCft1Plcyic+9S+vla70q01w7CE6Hq8xvxSTWC5icUR1j1b7MueLurQOKVRo0tMQ1MHxvHUfwztuMyI6iVQb7JHL3r2KCLKdZhFPquh8lR23IRCr2tLYVo2CT+98qVfucBgwy52r15D5RGW5jtPLyn5sYtLjsei0JbacrXjYQ4dyLkDcCi31a8gkdzC1ucsYxWyxnuumzy85viBpRBxJLCBTvl7xtELvlKOIwlrxdYUCywRuB8WIsX4GuLxWKfx5Piu1Dtduubjh1dGXa+NPKBISIt5XVtgW729JomPgixqDomqLe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(186003)(26005)(2906002)(5660300002)(66476007)(6862004)(6666004)(82960400001)(8676002)(6636002)(316002)(54906003)(6486002)(86362001)(478600001)(4326008)(38100700002)(66946007)(41300700001)(8936002)(66556008)(53546011)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NM9hk1DZ7WQh2zX+wAY0CeQswJpS8ZtrtmIQwXlrc5AEqsi92gFNrK5kfVac?=
 =?us-ascii?Q?yPPN6BY6toeA+UnCBc4NVNPWZoPHNkczL2NE7nOxyoMi6hxY9s8Dkgm5TjSu?=
 =?us-ascii?Q?jg0JpaWPQN3yRfG4xtxnhTH51VoGHWPHqqW/COJpRZ9UDJOqvWvD8EZAe3Ng?=
 =?us-ascii?Q?nl51Yni3FEHFaWisCZswyvLEpzgnH50kSIRlVCb2mcvp/3tRm9jhbvrSHiJe?=
 =?us-ascii?Q?WlRZ3myabXjKunqO2LI9dFo1I4+hOmPEdX4AGvkrq6fwRewC5VMxNEdabSs3?=
 =?us-ascii?Q?vvcgwxPR0AgVdVOB3k4eYfnopTrhpwr0no9cFmbXmiUQrRmkA4hjf4gfrBB3?=
 =?us-ascii?Q?MhT3M4Tjodz4slMe7OOlkXg3HLf7ySA6cjovWhGKsfm2yUXeEdW93/F+nsq0?=
 =?us-ascii?Q?p7AnervXh57Wwzk7ALMz/eR5P6kz13uIT+MILT6mJtQtDoLmYsAXdbbaBjFt?=
 =?us-ascii?Q?gpc1kaq1qLQ2mSsGuP109boYUHWRP1Tcea8NQd/2yWbobYITA7F6a74OtaMU?=
 =?us-ascii?Q?sQu5ks+QiJr711qcOcdjsX7kdqVYz7O7byWCi2QyEbNRHQowa21jIC6DblmQ?=
 =?us-ascii?Q?T615ZloZPgsV7cGD0Z6FPXfpNa3Nz+SAUdD/iogIneXGB2sBnmg8AEzgqEDA?=
 =?us-ascii?Q?FUpwUb5lWjY5DpeNPswWnV2JB3nxkiOqV/Kst256i6YZqPe7imVBCjhar2Ez?=
 =?us-ascii?Q?VTYkoM6l3CojgkMdaIWkyA+IAnccmRNK+YYYgY8oHGwTT4w+i8XFRlHUiNwC?=
 =?us-ascii?Q?MnKrWl2QNLq36309Zdw145UNpmYLj2Y+jmZ9016/iknZYKHw7wPI5g/OEnN4?=
 =?us-ascii?Q?zHBS4RL7mxqSl0HzHbP7Yhf5MXFd6RJe93nXibBGR9oqUIUEojVExRrLZEJU?=
 =?us-ascii?Q?arDSiaFFiOOQOiTyjm7siemwwHtwM57fzVPuoxuEN011SBq5aKXHdaiRzGrk?=
 =?us-ascii?Q?v6IeVrICGF4dChm16HSIM7GzJC9goNwJgmEodY2y+4XdNe/yVlyI8Yij4UT3?=
 =?us-ascii?Q?6FOB/d6hlKIDjgj/cThmlcPcL5gcR6aO50jxnX7GOjQasUiztoCeERV7JG4v?=
 =?us-ascii?Q?R4m7lm7Ddm5mPRszSJWkeHG2XSbXcd/LZ6kxbs4QnznVFmr+h/azKp6EF00x?=
 =?us-ascii?Q?CaBXPeK9AcVRLvwTQ30xOfomtA64Y2YhVL9Fsx5N+b9wvhp+LyMCSftvGTIS?=
 =?us-ascii?Q?x4KeilpG4gmrG465Ngwye/G+lggO28EyZvZJVyP3Bc1ug9bwLs6eJVVRRv3m?=
 =?us-ascii?Q?C68zF3s2YuPOSl2UAjB5c2Keh6s3FQULO3tJbVa0ZMglfE+GRtFsUqxT2jCH?=
 =?us-ascii?Q?JaYfRwH1OCo38eyJG5wFyXLu3VqAX8lZvEZf30ubE8rBq8bZ49b5tzce2GdC?=
 =?us-ascii?Q?8sRPo4/fAxsLgDvNb1/kOlsVHBVT6HJZRRaqJzd10ZYC5Kt4qVtYmIWxpKhf?=
 =?us-ascii?Q?5SdDeUmE3lC1rnH6L1MrG85vgUZjCOA/79KrlLHXllPOo2kagbPFLRbTYD2W?=
 =?us-ascii?Q?taxDsQwOm4SJgJZPqWyKQPLwe1Jl2ew8yTvAJ9zu66604IFx0ibHg0Ew3V6c?=
 =?us-ascii?Q?0UjU8jHK3T+iLoxlYHahtfqbODuA2/kUUFvHhoJY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fca5b440-030e-4fe6-2595-08db76e55811
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 08:06:00.1589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUiT+VmITUTPLFfw+YoQGdJsNI2rtb693Ac00wQxF2flwBf5m+oqSVnV4ukTTyq7QbmcP4L+vmaxSLJBPMI6sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5007
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-26 at 20:53:35 +0800, Aaron Lu wrote:
> On Mon, Jun 26, 2023 at 03:52:17PM +0800, Chen Yu wrote:
> > Besides the cache line alignment, if the task is not a rt one,
> > why do we have to touch that, I wonder if the following change can avoid that:
> > 
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index ec7b3e0a2b20..067f1310bad2 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1958,8 +1958,10 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
> >  #endif
> >  
> >  #ifdef CONFIG_RT_GROUP_SCHED
> > -	p->rt.rt_rq  = tg->rt_rq[cpu];
> > -	p->rt.parent = tg->rt_se[cpu];
> > +	if (p->sched_class = &rt_sched_class) {
>                            ==  :-)
> 
Yes.
> > +		p->rt.rt_rq  = tg->rt_rq[cpu];
> > +		p->rt.parent = tg->rt_se[cpu];
> > +	}
> >  #endif
> >  }
> 
> If a task starts life as a SCHED_NORMAL one and then after some time
> it's changed to a RT one, then during its next ttwu(), if it didn't
> migrate, then set_task_rq() will not be called and p->rt.rt_rq will
> keep as NULL which will cause problem when this task gets enqueued as
> a rt one.
>
Yeah, this case should be covered to avoid the NULL pointer issue.
It seems that set_task_rq() is widely used to assign task's rt field
irrelevant of what context the task is in to avoid extra check. 
> The follow diff seems to cure this issue:
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c7db597e8175..8c57148e668c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7801,6 +7801,20 @@ static int __sched_setscheduler(struct task_struct *p,
>  	}
>  	__setscheduler_uclamp(p, attr);
>  
> +#ifdef CONFIG_RT_GROUP_SCHED
> +	/*
> +	 * Make sure when this task becomes a rt one,
> +	 * its rt fields have valid value.
> +	 */
> +	if (rt_prio(newprio)) {
> +		struct task_group *tg = task_group(p);
> +		int cpu = cpu_of(rq);
> +
> +		p->rt.rt_rq = tg->rt_rq[cpu];
> +		p->rt.parent = tg->rt_se[cpu];
> +	}
> +#endif
> +
>  	if (queued) {
>  		/*
>  		 * We enqueue to tail when the priority of a task is
> 
> But I'm not sure if it's worth the trouble.
>
Yeah, cache alignment change seems to be simpler.

thanks,
Chenyu 
> Thanks,
> Aaron
