Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE816F0232
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243182AbjD0H5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242899AbjD0H5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:57:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487571B9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 00:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682582263; x=1714118263;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lsAUedkHvvNtxHA66xb/gLC9R37HAIeGmKPt3A5kho4=;
  b=gD7v79ej9S4/dLHCREda4ufxcMnjvH4m6OHwicFs/0PgJXDWnvc9bvCf
   cXXhTZe4/gfpXU+QPaK4CruyX6is7m9u36Gmpdf7fdLUFeXbitiZJyAcz
   /iiVlqnI9l5jgXedUzK7u70APVQJ+8MzSTIB5cDGigPLpGUqtNW7wiGu3
   KNnoexDNR7+IwgFnAIgWn5ms2QNwEBhNii3ObIOzEMBVflrqkEZlgdOY5
   EK5pF5iT6Otp+nnUsygE4oy+GNUI8P0wPjMOM5n57JpjGHzFCnZ6i9/dF
   VzRynNxhqOJFZqKgTwIMUYlb75FRmRwlZZbHp3yqhaSmtyORCM5XK4ZaF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="327679881"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="327679881"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 00:57:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="724790328"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="724790328"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 27 Apr 2023 00:57:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 00:57:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 00:57:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 00:57:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 00:57:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUXWE32DbSEs7HLRNAuLthtVVYw2J+i22WVf3d1O5KQOjU+Yr+9bW5e2F0gYWSEW/znPl6+M0/nj81d/zcIZVQtLY1ZT+oV555HSQR0BOdMQ+SJUnfIlCGoN/eGoFPRdxdJQ+8Hv6ouoq5cBGZ1pu2QLjsbkpYNXiRZRBHzD8fkcqrGJfXzfaNiIxhAZLGBjuhonmowvuJiooWagvDIRXNk71yi9FH8+nK7v+wgxRW2ZDUXLfcj9iXKYJ1AVvlShyK+ffi8I/DnLjx2PvYfXmJxRJt1RRDUXFIpe+s9r5uKx/NdIYObKVmjo6KYMeBDon6LHDdJ7rHS88wohYMog/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhZZi+zKfz0RTWKq3bfM1GwUlw03wf/CjtV9T0VLmXs=;
 b=Irt4RlXstAPX0Vn8t9lPIFZLIEJf/XQ9+kvF4p/NG/mXoK/WXUHwCDYrn+NHTmMn3PhnKgSQTwlubvegSoM7BWbwEIcN1qPiUEw32gFobhY5+/nwuByo0hmbuA3O3Z1Je5z1I0JSTPAc585pXVchfTINpi6kO7KEJC43RsZYUb59lwu+/hfZ+f0YCQqTuttXV0SmdsOJw0hkcv7YhhIKUOF2jHrmSuJvMg/NElRESGtUvRFEVY4yPuNV5mqx7fa0Pnd1+9DNMGmWLaRSK6jlJyOaXe0XG3dEVEWEuqIOpFG0J2KFz4xNP8zLgvU1sUJb8u71Ud2aDu233MMPV6G/Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 07:57:24 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d%6]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 07:57:24 +0000
Date:   Thu, 27 Apr 2023 15:57:05 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>,
        "Hillf Danton" <hdanton@sina.com>,
        kernel test robot <yujie.liu@intel.com>,
        "Arjan Van De Ven" <arjan.van.de.ven@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] sched/fair: Introduce SIS_CURRENT to wake up
 short task on current CPU
Message-ID: <ZEoq0UXokdPG7i3n@chenyu5-mobl1>
References: <cover.1682060436.git.yu.c.chen@intel.com>
 <98257d0184b227cad8b4e947eedd9246d60191d3.1682060436.git.yu.c.chen@intel.com>
 <20230426140324.GB1377058@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230426140324.GB1377058@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH0PR11MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: 861bda34-1824-4516-e5be-08db46f508ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FbUybZoEP7HVvfA/2JHqrm6ItBfV43sMyPIKGJTGgZmcipbkbXXqEXz/LaMqVh0BXxScguSe9c+gKKIqOwEKBwyYWt9irzFzJfnHExTZjxs/+t2HpTFY/XjXSyR6UhqhL+IaHXIDjcHXWDuzITP0YID0Zkkti3jJKyD7KK6ASN9ChnWKzv8XSJcP9PGj5ynOjbGQyNnATNq5r42OD6Y7MviVqoBqY0TLUURXvSKxFxZtjkd2X6x6bd5dhs6NvIZCr2dOdrO7yCXAO0IKS9KSGpfOopDPXLXcwHCC2uXy4QDN4nWDw+tPCvrxZCg8dvu5RCl/em/7f7b1dXVYO5bHp021Do8hoFlvBgvL/qQwGDhArxgrqgmz3sHghKhPYOSY3mi0jJWu4KRSdiTDS4CdXDGDqX2VZcydFrMoTVM0a+r0LJL2k+gNOqfSQThmA0k8BANpFy8GTj+C40KA9ZPVEjtt9/wFTJIpewpKv7noDED+LSDmv1BkFllp0snas2/W9joES6TQr03/0DZ7kmVf8pgj1RSBWW+bXaP0G/8ZEgG78DDpBJep9e+eb8KmW5WX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(6486002)(6666004)(86362001)(82960400001)(2906002)(5660300002)(66556008)(66476007)(6916009)(7416002)(478600001)(38100700002)(8936002)(33716001)(8676002)(41300700001)(54906003)(6506007)(4326008)(66946007)(53546011)(186003)(316002)(6512007)(26005)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lc8Q3TdMQwUsa+WpwadAfgy3J2uZ45mVaxx+3SPkAmJ8JV6LWLiul/fBg90m?=
 =?us-ascii?Q?6+LHqz1EqhmdDe4WElo4ZNVxxiIvOYwaBoNiPiTLXIpXde72ETsfv2naOCFy?=
 =?us-ascii?Q?+SFh9Sd4cMKWIK0iZyLqTDMII1fwV61AqZ6XpA/qWK6nY83EX56LFLgPXQOo?=
 =?us-ascii?Q?FQu3uK4yU9OT77u+ji6ARZZ4iA7bEAnR4jK6gHvR8MQ63m5W6dwwI8H7KNgT?=
 =?us-ascii?Q?FWWUIAo8iB4NB+9hTzWvWCE51U2g4RJtuASEeef8M2Qps/gVrARZI4EvvyXT?=
 =?us-ascii?Q?KodeebkLkwwL9+O7nv4VIA20Mo4Ioq4V2uT5GxmlJWyhooadzI5sy3QQRpbe?=
 =?us-ascii?Q?P80rdX2aQLo09viD0G5q7ZF64tXPtef6c56R0dupwpf0oeC4fs8hjex5jHbO?=
 =?us-ascii?Q?B4b0Tl1CCpYSt5HhyC6jZ5KRtIteOAB8R2eKnhtQsssC4vNEexMV4it5Gcfb?=
 =?us-ascii?Q?K/JNoWOmQ2UJfilSYZ5w/tJEdiMcWBjf98b+j5tktVDcEN79jy/4z5U91U8K?=
 =?us-ascii?Q?OxIbUaPVfxu2IP3qUpYBBcor4wK8J0GL2NLWcslOTxvLX0zc8aAAs4eksJ/P?=
 =?us-ascii?Q?NENJHufkL7r/tf9UPL9reI7dPDay4wHYx+0GIzot946drmh9Z80eKFhUDfIt?=
 =?us-ascii?Q?udw8INdD9IajzkW+4OGCU7oA1V4GQji7ng5b5p3QJVfWRI434XOse8OvoX/y?=
 =?us-ascii?Q?vjhI4xJfXHaU+7/B804u7wl38D010/xf9m8zHA8Dy6wh4Pg1V5omrVeL9C8A?=
 =?us-ascii?Q?WAoiXh8Ji14DLIzm1w6OY410mgTgezA0xqCbZ83sfYvpSO9GI8AKbu8Fb9PC?=
 =?us-ascii?Q?BDBXoicd657YrwYesgCxEgc+xp5muWJWk6JxbAIqPabX2BjlkdtGWYXqQtZh?=
 =?us-ascii?Q?Fy+eJapGnWtmvV7G6OBo1OJmlTsoA9O8dOKMk625d6HWocwR/Iabv2AWpj9m?=
 =?us-ascii?Q?iTYR46B0jz2jzqS37YcZDLy/EKeXnIgqIzSFXLA+ayP7twgTh+2G7l55LiEz?=
 =?us-ascii?Q?iNjSy0wMG+pJn31uASqyGEFj9SbDxe5RHlgfmm1IsxVsqPe+2SbeUNsQ5/gX?=
 =?us-ascii?Q?RadsbimfMymokK12+XN1IoJQ17MA/Bs6ZT3l2rJIKnlIdrSQT3DwB78t6MLI?=
 =?us-ascii?Q?so2npYKEJ56LW84jIUGxCF4SNWauc7yXssDb+p84K8TVm7yYilz1FNXjNMxj?=
 =?us-ascii?Q?V5mIBI3mr5ywKZNklSyFs5cLf9m0IxxK8MOVrUS6bSdXwX3vj8EQXpzUh5tA?=
 =?us-ascii?Q?uva8NRrtDDkaHHU+z1uKZ0ZV6ZQPaXrXElz608mFrIn6b4GG/JzNTYGII7Nt?=
 =?us-ascii?Q?xqFNk5VwQwNvoROhwKchtzaJJRGm22Ys2FkfqAEuutWo2ZPO2dfbQ75iisEZ?=
 =?us-ascii?Q?dMnu3xWsU8q4+31KSp9gEHnzSkARMekfChfNIiox2ZKCU377MtaIviUDZ3Hp?=
 =?us-ascii?Q?x+YZ9QwrqKWmVceO61lycB+9o3I8LCInAEo/edid82sCH+fKugxa8Om5mbrA?=
 =?us-ascii?Q?ghjLtN4I2OVvmuO1oRp4Fennahl6ym/CkAjAshAzTCRZKQZaF0QEe9N4BaU7?=
 =?us-ascii?Q?YTFYxQkHo+2HLL+eEqeofjvwxOZ4EcfW3G4c4Bau?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 861bda34-1824-4516-e5be-08db46f508ea
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 07:57:23.6721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBvU3nQd/EtZiAHXAk+xp7AQsLBdhV1VoKPBoIWnsnfDGBU2YBjbQjNdXWsTUXsX9JFO6P0TF/C6aXjbKcZxkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5674
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-26 at 16:03:24 +0200, Peter Zijlstra wrote:
> On Sat, Apr 22, 2023 at 12:08:18AM +0800, Chen Yu wrote:
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 4af5799b90fc..46c1321c0407 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6501,6 +6501,46 @@ static int wake_wide(struct task_struct *p)
> >  	return 1;
> >  }
> >  
> > +/*
> > + * Wake up the task on current CPU, if the following conditions are met:
> > + *
> > + * 1. waker A is the only running task on this_cpu
> > + * 3. A is a short duration task (waker will fall asleep soon)
> > + * 4. wakee B is a short duration task (impact of B on A is minor)
> > + * 5. A and B wake up each other alternately
> > + */
> > +static bool
> > +wake_on_current(int this_cpu, struct task_struct *p)
> > +{
> > +	if (!sched_feat(SIS_CURRENT))
> > +		return false;
> > +
> > +	if (cpu_rq(this_cpu)->nr_running > 1)
> > +		return false;
> > +
> > +	/*
> > +	 * If a task switches in and then voluntarily relinquishes the
> > +	 * CPU quickly, it is regarded as a short duration task. In that
> > +	 * way, the short waker is likely to relinquish the CPU soon, which
> > +	 * provides room for the wakee. Meanwhile, a short wakee would bring
> > +	 * minor impact to the target rq. Put the short waker and wakee together
> > +	 * bring benefit to cache-share task pairs and avoid migration overhead.
> > +	 */
> > +	if (!current->se.dur_avg || ((current->se.dur_avg * 8) >= sysctl_sched_min_granularity))
> > +		return false;
> > +
> > +	if (!p->se.dur_avg || ((p->se.dur_avg * 8) >= sysctl_sched_min_granularity))
> > +		return false;
> > +
> > +	if (current->wakee_flips || p->wakee_flips)
> > +		return false;
> > +
> > +	if (current->last_wakee != p || p->last_wakee != current)
> > +		return false;
> > +
> > +	return true;
> > +}
> 
> So I was going to play with this and found I needed to change things up
> since these sysctl's no longer exist in my EEVDF branch.
> 
> And while I can easily do
> 's/sysctl_sched_min_granularity/sysctl_sched_base_slice/', it did make
> me wonder if that's the right value to use.
> 
> min_gran/base_slice is related to how long we want a task to run before
> switching, but that is not related to how long it needs to run to
> establish a cache footprint.
> 
> Would not sched_migration_cost be a better measure to compare against?
> That is also used in task_hot() to prevent migrations.
Yes, thanks for the suggestion, this looks more reasonable. I'll tune on this
and check the result.

thanks,
Chenyu
