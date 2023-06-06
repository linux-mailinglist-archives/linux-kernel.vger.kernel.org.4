Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3702723AE5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbjFFICh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbjFFICN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:02:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0892135;
        Tue,  6 Jun 2023 00:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686038391; x=1717574391;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EeDHkj7AZhrJeaZ5rwptYR2misf13gjiNHTkwFX/y8s=;
  b=gUn1CJBmiwB2yn0Ytwbjj5cjvO3v6zVoOeIjlmvIxktkWklHaG2ORgH0
   Rndh1SYawbu5HLLFDeNtt9ibmjSvYDWeAYD0LmtdBTFwiW6WkrOrflb6x
   4prl0yOruCuD5PL6BRPDSstnq9sI23kTGTCw/sG3FKUBeyJB176aimv3x
   FN0qfv6QbRSIIX+2uy3phxE9Tkw5axmMdOy21nWKVAm7bl1lQhjFZsdOu
   gE9EsVWxac05wRJ3RvuoRzGnSOQHZ8Fv5hctO/FX3x1fqb5AysW9Fy2II
   QcpGiFKGCINrgqvhk8M8SaVLU7F3Cm6nP7J6ttLE6VloM0e3JndwL6SmC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422422772"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="422422772"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:58:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821523865"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="821523865"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jun 2023 00:58:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 00:58:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 00:58:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 00:58:53 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 00:58:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2Shet2/lmhb0cf+VOcXvy9/6Ag9Si0nY1lzJNQ8C2ZowAsaAEJ2Ra17gMH8MZJ8Q4AVTkxN21wY5pgrRUfG9F/pEbd+H6g7R4BTcaFSyngTkSHWaXBfUPGB/tuExpr56bJLKMIZ6hW9GbWeTPrXGgMB8Z5jeloRSZ779a5+Lu7YliPGV5qFrqx7Ndqdt9XNmNqwbMdc9lq6SpLCLcib8Az8JzyULQ3NLZiq5EW5MFoKejjvlWY6h9WESnkcVq0zVeUOoh9wO6o9V//MP+z8ZsWuGuZJ3CF9PjnjHPvzUX5ysoQwZVY/p+NPlP6ePe7I03Bar8yODBz3Y9i9jm40Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2kUIuZRCBMV/FTEYCEUXUj8Qhs5rrsmIiERwJcUe54=;
 b=XJhhHm5GBs+zmdIQGKMw7Gom8n1O2E3qVw2a4gESPw9Kxt3lm+WDpgkVVV0k0vTYG8Pb/SR+XwqgNSuZLoqCDst8dEyiOaUkRvHjoAasPv9OkWG8SOgKHmy/Q1FRcoE1bOXr4mvDBxDop+daP+oU8R36adHskNHt5L5eW/s7EJUGK+8iAucTm+sCaBwQ/YYyyBzUmyDwDMwOWIrn3WwR9ftibGC271XQXVCgGHzKf6YhiiOWdF/lGZObjhP3gu1JQaCMC7bTZDk2ovek4Fnas7mlHIqFRV+5ClV1pc38df7g8ezVwKiJoOpSp9O+8wlwo9luPuSkOXWC5M0QXbGoKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB7552.namprd11.prod.outlook.com (2603:10b6:510:26a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 07:58:51 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 07:58:51 +0000
Date:   Tue, 6 Jun 2023 15:58:33 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-tip-commits@vger.kernel.org>, "Tejun Heo" <tj@kernel.org>,
        <x86@kernel.org>
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Message-ID: <ZH7nKRDi2LCcpTzk@chenyu5-mobl2.ccr.corp.intel.com>
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
 <CGME20230605152531eucas1p2a10401ec2180696cc9a5f2e94a67adca@eucas1p2.samsung.com>
 <3051ad44-0ac3-e77b-3178-fac7cac3b3f2@samsung.com>
 <20230605190746.GX83892@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230605190746.GX83892@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d902531-2101-407e-9351-08db6663dda0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0z22w5udlbJ5i1mXfzA36zTF+49RC3AMlODuZK2sZq/zEHWFHInxgW3VwgAsoGPivp1rUC9rfLOBBJzhoRyB+9N0L3dXnTf3zWomwwzd4nUt+LmvJmsWfCITr2ze4FgvO3RMaTqxJzV9U+/iYB/ZAGY52XpMWXNi+AhWnr6FwGlO6Ce69eZNMWcHGSxhMhMWMgdZF/XBHTfI5aEsgWRhsQQNXi/cOMKlBSQEoLG9pSUXy2MawjsfakSZ7t0lZV5y5Wm3bM+3kPP6i01FhQAPURio8STnaaDQ/W7LbRnGjaFnr/NuyV7o1U9GYHshBSreysXz2FExghx8r/dZ8XtRIMCvkVsNJgzj2IEjENHWKJ9yRh2RSWdD/lJLOXn+ovXTa7F5blor3LklS20qRuiEBuHhR0/VvKsvYe1ZdHbONZavM+aEJJqfxTjYX5zmn9BR5n8nb6b+Y5G51ltXTQIiXNYng7Hh9vu/AsFKQfPqQJ/AFJQy4gsz5Q3J3yLJxoJKN15NuB5yem4Gtq6mZtXmGMDvFPcgmF3xUM+xYuboNJOXKoSAUpKiihaADUcnlM9s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199021)(8676002)(4326008)(66476007)(6916009)(66556008)(5660300002)(8936002)(66946007)(316002)(41300700001)(54906003)(2906002)(478600001)(38100700002)(6506007)(26005)(53546011)(6512007)(86362001)(186003)(82960400001)(6486002)(83380400001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GB1OFbuBMZIYJE1t5Y4CDg/B6+87CtvdrS9rtyuhOyjcHN80sKB9X5Si2xHN?=
 =?us-ascii?Q?PEsxgZKS2TOSEeRGyl9dzZri9RnVzMpbhG97KgS6fXZxDsmg8+R0iXBetjAr?=
 =?us-ascii?Q?qKaXeUoO4jRn0ztzwTLKe1T6Gk2UJMZz328Y1iucZjWT7GVR9Kiek+7ebMTl?=
 =?us-ascii?Q?n9wLKPwFVd/hzIgwRXWh+bKhUwm6UTV2rxE2uR+n4IVzOdhjezP6tdV/GUgl?=
 =?us-ascii?Q?DEJ2VHaakLfITvmcRSQe9ANctzNAIoGG3xOikuRX9p+j8x4aUc5JUyMaG0ir?=
 =?us-ascii?Q?E0PWfPF0y8Sp++uhtCuqR1jOMWoXK2XA0R4B1qCLHCHdcdrCqAu3GlRjQVxo?=
 =?us-ascii?Q?6NQSxKpDuS24GNPCKONLrbl4nk8YQ8bByYQXMP1DCMKsthkyNZiEIwu2PkYA?=
 =?us-ascii?Q?8/mH1/OaPRJ0/5gkl5VeWM0nlkYBxOaKo0LHZO1lg88z3Fbj1iLtqQ5GJTqZ?=
 =?us-ascii?Q?kNzEffLhjlG/PZcl6QCznPKFOBo/xbV2TGtj3OkxwthEfP7MPJRWmcycn2t9?=
 =?us-ascii?Q?/DE3IdopDKvBCymCNImVUzjiCinr3pxLMCzep3VnFtCFpwuocTpu8VFAufY/?=
 =?us-ascii?Q?j3rmsV4jJhBPPsPWFSabnRs0kg/d3f/a88fXgNYh2Mvf5qbJmgEQ/S3Ul8tz?=
 =?us-ascii?Q?VCqrSuxD5FRdJFSV3nhnE/76lRQXTP2n+d6OBJUnyl1W+ObG8Yz+4okHl7e5?=
 =?us-ascii?Q?UvF89UqkaFupqu9+77Ya6z9puXcz3WJU8d0tanbWwXuYQ2ECGGJeP4PhTvQ7?=
 =?us-ascii?Q?n/d7oG+XNhglDtxqIuS2Q97RYNOR4n+p1buJEDgjk9LlEevkR/q2QcZQYNt9?=
 =?us-ascii?Q?yyT+vEXQvPhOC/XDKbIkSMWAcRdzux0XcHrkA8cT5cuB9ItjRm9P/2c9PG50?=
 =?us-ascii?Q?p/mu9yuGXI9XsG4X9vciB0Pmni8NO7WbxJ0RkPTPT/ikJOzY62y4Tr2TaRy0?=
 =?us-ascii?Q?w5RTkl8pIRuKvZBOx+ep446C2JXvudh4s9t0wLfoOH1AUHWt/xmf3uFTbcg9?=
 =?us-ascii?Q?220LubFkaRX0SsoQFXPZrreqo7dLag7cmaXV12e58dZYyo3+lfTKdkEK+SOX?=
 =?us-ascii?Q?WGdjQ8EQ5HeIV5j0Cvv5dy9fULqe/BoaIlTBuM+rrAh1TJqT48W5lIRpr72u?=
 =?us-ascii?Q?TRaPHPf/unIIeV6Oj5odZSp2t1obK6sj8nVLet3ChQPz9igx8AeB8bF9DTkC?=
 =?us-ascii?Q?2+Z0ebG41Lk7CKDee0U+COEpSq2Jd8XsFanDnSGi7KOpSbMZNkoxOwVf6yeO?=
 =?us-ascii?Q?MfgZ0i3W//9Xq2FHEQgkR0zjXsMl0IAWz5aSQFpWQT5OAGYuOwlnN8aPWFOj?=
 =?us-ascii?Q?IX6S/6RWogVgpVVRQeTN3H0S+ZVA2Zi9XuiDPxgbQazEpW9VsN5lXGJznSCQ?=
 =?us-ascii?Q?1HU3ZO995Dsz7SvXG+cBZrSfBOpD2UZF1uIYsHt7BomEuuGtSrY5tDH5weXd?=
 =?us-ascii?Q?fEEOE3hhwZPHf5Rxe3VFQl3vpWLtBndGdkcpTqec3wOc6v7MsEoJzDe1FKhj?=
 =?us-ascii?Q?oDOx+Slw6tum+u2QnUWsqiJ3L0UpvO4l1XjDx1g4lyaGbh7eW2vDwRwyGInZ?=
 =?us-ascii?Q?rHc8zoLSkQPlY5mGZ370QMZJB6SGOVHoXfxVmDAG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d902531-2101-407e-9351-08db6663dda0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:58:51.1173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cM9VcABLW5N+poVp/wIAlB/+NsdL8n5p4TkrsIHD17Wql0DHBRR+//LGABNUaaXoAknFEjjXFDO4uDD6c0u/iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7552
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

On 2023-06-05 at 21:07:46 +0200, Peter Zijlstra wrote:
> On Mon, Jun 05, 2023 at 05:25:30PM +0200, Marek Szyprowski wrote:
> 
> > nfortunately it causes 
> > regression on my ARM 64bit Exynos5433-based TM2e test board during the 
> > CPU hotplug tests. 
> 
> Can you elucidate an ARM illiterate on the actual topology of that
> machine?
> 
> 
> > CPU: 6 PID: 43 Comm: cpuhp/6 Not tainted 6.4.0-rc1+ #13640
> > Hardware name: Samsung TM2E board (DT)
> > pstate: 000000c5 (nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : __bitmap_and+0x4c/0x78
> > lr : select_idle_cpu+0x64/0x450
> 
> Btw, where is lr at? Is that perhaps per_cpu(sd_llc) being NULL  or
> something?
> 
> 
> > > ---
> > >   kernel/sched/fair.c     | 38 ++++++++++++++++++++++++++++++++++++++
> > >   kernel/sched/features.h |  1 +
> > >   2 files changed, 39 insertions(+)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 48b6f0c..0172458 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -7028,6 +7028,38 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> > >   }
> > >   
> > >   /*
> > > + * For the multiple-LLC per node case, make sure to try the other LLC's if the
> > > + * local LLC comes up empty.
> > > + */
> > > +static int
> > > +select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
> > > +{
> > > +	struct sched_domain *parent = sd->parent;
> > > +	struct sched_group *sg;
> > > +
> > > +	/* Make sure to not cross nodes. */
> > > +	if (!parent || parent->flags & SD_NUMA)
> > > +		return -1;
> > > +
> > > +	sg = parent->groups;
> > > +	do {
> > > +		int cpu = cpumask_first(sched_group_span(sg));
> > > +		struct sched_domain *sd_child;
> > > +
> > > +		sd_child = per_cpu(sd_llc, cpu);
> 
> IOW, sd_child end up NULL?
>
Just wonder if we can use rcu_dereference(per_cpu(sd_llc, cpu)),
and cpu offline/online could modify sd_llc pointer. (We used rcu dereference
for sd_llc in other places)

thanks,
Chenyu 
