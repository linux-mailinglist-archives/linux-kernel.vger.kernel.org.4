Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44C45BABE1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiIPLAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiIPK7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:59:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD894D25B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 03:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663325406; x=1694861406;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D1eRhg69BpXnq3mrWpNL6n0sGisiKZVJOPwtcY+sc90=;
  b=WYPmU1zR6FtbsZuWkVPluqkrcTUz8+YX+n0Yosx7PwmNuvGFrGgQpinc
   ja9Kg4lJff3A+QsOlPGVReYVMQWn9DtnAT5KkHIaq/ipLps3ekrazx7UH
   IsGcKNv5t87PQ05O0AXuDslxSMgoU3g93a25906ynP/VT57H4XTl/xwni
   zuFKx5esQHrsdJnOOhONGIO1Q7Mz3OpxIx+Kt7EhHHJbeo12fD+ubUf9Y
   aznOymcngZTwRLnM8sVR0xFCpKBWO5qXxZvY3rB2Z0vuyXUrLtanz76wt
   RmQsFHT0ATFJZ2Y5wkarCB6umJSrGHnfmu0u3h+h9I6YqX0AI1O3gkScl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="298959541"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="298959541"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 03:50:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="568790700"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 16 Sep 2022 03:50:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 03:50:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 03:50:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 03:50:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 03:50:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrjakDQKCkIqMJdxaBtYjvTmVx+3B4BkF2rvLd6j+losG8RQbJ/ap/IBDrbC13FX4FAMYayi8C9ipoT/pOvkuV9xe9H/SFeU1+r/yCdzEW5Oy/m+6JzHItTyAcyeBMCWGD2mBDyZy31yBE3AFiTKj5rIOFzvqva3eL9IMQI9iBi9A/H6vLbi9fxksU/Y783Q9QsG52erlfN+omsuJqcc9FBNQeDoWtQy6DT/e/e6AU5DYHLuZmbQk/YQtYzkYU0I2XGcO0ECPV5y9VvBpN8fFqKhy2w5/DQy5bzInTpNJvgkT9td7jI0EGUI4oPl4VKukzADTARHZJ1VH53Ur+XBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRwH4lHL4Zkm9Z4tiB2iEAKy/dcmWx/cEjR1MXGBFBY=;
 b=Q9fT/W/jDmYITDSmd5h2WOzQlRHEvdzhpDeDEfWNSpoC3XSGL14Z/g8A7H4eyTnKWQylI/vk+M0oDGqZ6tY+RfQcJ0eL7KHe2XQnJ2JV1h6e2q//5Dxudd7Vg/yMOrW1KKvW6KSWQhSKd9xgVM4avnQil38oumZq9zfLTLMjbXOPawQcHcyY7Qexn5E/odWkmthLi7xb9ouxodOsltDcSDk5ASZ0x3J8FnL30MzkXiWODcKnc7JZdUZ5nBc4jwGM6dJxCj0lztVrYV5Qd6QNuHhyX91c7nePbxihsGKIlUqRLPFBzYgMkWWlGZfDxb/nIIP6jRyZ+7n5Vdsfgpghvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CY8PR11MB7313.namprd11.prod.outlook.com (2603:10b6:930:9c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 10:50:02 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::fdc0:8f79:3472:80a1]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::fdc0:8f79:3472:80a1%4]) with mapi id 15.20.5612.022; Fri, 16 Sep 2022
 10:50:02 +0000
Date:   Fri, 16 Sep 2022 18:49:39 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
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
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Choose the CPU where short task is
 running during wake up
Message-ID: <YyRUw4gmxMwgo4Zc@chenyu5-mobl1>
References: <20220915165407.1776363-1-yu.c.chen@intel.com>
 <bb7dd6ac32403e96943a6e51c60e72960c2942fd.camel@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bb7dd6ac32403e96943a6e51c60e72960c2942fd.camel@linux.intel.com>
X-ClientProxiedBy: SG2PR02CA0114.apcprd02.prod.outlook.com
 (2603:1096:4:92::30) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CY8PR11MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba6d3a1-4439-4bc8-80e7-08da97d13517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G7wzsZoL98x9MyHysuIeH9k9/ZOFZAkRMVqCVPDy/pChy77feBPPlv0tznM2k+mcXcl3nFjwNCZ67LJTFLRjw1S1tc/Xjndu5otrVCDX2mo8s2rYmSqUwfaiWgoXe9u/4UfQwEkGRHPjUcXLQcsPHAl1Qnd6lmtQtsep1+836LT1iiMBCy/MbhIc9N1QvVTLNe5VyHYNwLf+8pwa85NLVPqgynKg5NY5LyDhjg+1XbMG3NOGPcsFL9QiaedebZ/Gh3TjmuZQfKQxUxRdgSfYvn+Iym17jJCfB0w4V7nimpoCIL/NPa7wIafLAnK8O/ENsjF9Ws4RylWidG/VuApj1JWcAjsdhwlUUamL3YbN6Ap8C19VnBR2LFaYWLahnQrQSPZDqHPrHDZReAWZDUtiAzmT/lEDtZ5Et+c5Z6mKY+8Bhgk4X1IVKzkubfzJtELynnKgNR3jbD+dy9nfVGVoGbPJCV4NFja/u8JEJpO4CPr9mMR+O7ciLhS06zdIB9tfwIRzasgxmJ75OUUEdXWsSwgll/vhDe9Og2pfel4RvDHy4dLKTQyt48qUeyi1v1cesP2mHKRnylcIXz2VLgQdMUp+vtcrnQ/dneppxT8Fg8T2qdtn9Zlr2OIbVPLbc/+gM9+ygCX3VGxbd9+juJBkck6Oi+qeXtjw928YDG8aLbTt0IiP/e0soZ4hvkzR6Jxk0MaRM3czQNdb05bqj3J1wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199015)(33716001)(2906002)(82960400001)(38100700002)(7416002)(8676002)(5660300002)(8936002)(316002)(66476007)(4326008)(66946007)(86362001)(6916009)(54906003)(186003)(26005)(478600001)(66556008)(9686003)(6512007)(83380400001)(6486002)(6506007)(6666004)(41300700001)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ilu+UfuWk43rtjKPG2Hdkj0VW8wO+F3+lJd7fVk5/QwsrIBdjubY5nPcgWz7?=
 =?us-ascii?Q?zInP1mWslU/s7+hPDx8gshglVAYbr3GDY5tyKiBaYIE/7j6e7vTtgMgjRq22?=
 =?us-ascii?Q?SdpmdX7ntsyMYt2MX6r0Q07XgNEeIhOSfeq9m7KJ1BhEPQbNGU4UnVkjt0QA?=
 =?us-ascii?Q?KfkVt4ZMb3ajSTNsoDCrvE0cgEqOVxbYuVwlHGxzazVjm9p1NvL4k8O7F3UP?=
 =?us-ascii?Q?eARSUia+6+ESxmxIbyqlNRE2UF60W6HJjJ3QTwi0b2KlzFEzDvFDdAhz164G?=
 =?us-ascii?Q?OHIJbvsDZi6y53yO1HzBnrKKQju/3RnlUrThbkFM3zVfQ+PuTUQuKvJ0KWr9?=
 =?us-ascii?Q?LnQRBkMqTBt8QyiFWuYR/m+PfkYtBE1uICUjwHNJ/2mCjbi3pYCYFruzqKiY?=
 =?us-ascii?Q?pDqcwPDRlcfZy94ANI3ADw6TSK02dS07SWT5uIMqLTC8pbJsSWeJBTReXvyE?=
 =?us-ascii?Q?T//bOzvBma+QmXmN8RqqvYrsVF9p/e5E+pCgsBQB/f9Q2NVfpQzOHWRb5IV6?=
 =?us-ascii?Q?nx+6Lc5XVB51U+DIZZmzRcVjRbcke6cuOeyUFU5kWdZFypmDj0NxwfQpSrQk?=
 =?us-ascii?Q?xIQBGJSWQZ9xzBRj8TUF6zNSZ8XJ+3nYeQQs51xpVlR2kQCh7neAm+b0diLn?=
 =?us-ascii?Q?BFOhh+U6qlmOTPABoEY722RHxlGZDSqm6pr1wZcoJ0UeVSL83EMcyl1hdfnW?=
 =?us-ascii?Q?FDZBB9QhbTuGdtCDRgS64Yv9PvUzkM2eG0BTPSccEcGJr0+fN9oSwlxqrqB7?=
 =?us-ascii?Q?iDZ996sOdfXcTxg7lZsjQFYx9nlIcUyy2BcQI+rp3jTW4SaFcx+9q1ClkjnK?=
 =?us-ascii?Q?GWawMIrJsgFsde2nyNbmOOeeBijt7M498C1HE2glGbex1ZQTEIbNoCdNdlUR?=
 =?us-ascii?Q?hCYPzQqIOolngGhN5eUuXgBYycOtNIUBJTPlz2HcjCmP4Mdf31/1wwJiR+yU?=
 =?us-ascii?Q?uoMKpKcfzW3bE1/hgg9opsve3pIe6kxqLSgSwV34dxCXm5F9ayXnCWQ+mp6p?=
 =?us-ascii?Q?fhHG0gZRRK9LVR/KPIhvA8fYEoNV+USXmugHlgh39J0KauLvXZz5MoX+r5sA?=
 =?us-ascii?Q?7KOQl4ObjLtGBdDKEhcmetvoW2FIsyuOetCIBpPR9rmI4Xi2ENXfgM+io3L/?=
 =?us-ascii?Q?JnS5bZtIRn0tfA8+LBysuiWWT6LkuV7keVrCoN3eixnwJGEVS2ruBZgrBuy+?=
 =?us-ascii?Q?Ce1sQ/J/6HAYiXyp8savc3qnjLdGMgsXIyqH6yu8K8jyn6qSmQ5ugvigXZFV?=
 =?us-ascii?Q?i2ksegsy8Bkk758JFo0fGdT9sJ7gIKZmBNP1DZ4Mqanq/FypPf+MNpdR3NnC?=
 =?us-ascii?Q?VP9edtscQkEB3Zp3m9NRLWXDdT4NlCJvXKsn7Wv+RJHMz3AhGuLKHRkucNiW?=
 =?us-ascii?Q?2f4eINnpNObUA7ymzGt4W0F2KN9JzzOQRNDRYeFRlRfkmdZZ/GpQ4tjwov+b?=
 =?us-ascii?Q?C62lYmkWpPO+9q0V8bA1UvVeztL0KRyKOSkpMpU40v/UOLDVC2ja6tvpcpm1?=
 =?us-ascii?Q?ibBW0hlM81bc4ZxCZ/KGNZUe8tXRCi5inN2iLbz0FEUsKJHnYz01fGbkHfQw?=
 =?us-ascii?Q?tiOGkwlZ7pOXN87kS6X2rYpDO0Il4c/rWg/TZhcf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba6d3a1-4439-4bc8-80e7-08da97d13517
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 10:50:02.2288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCaDa/SZMsfy7XU/bMdkr8BlxAaSBqWOslxfkirXh0YNgVD53h0zztugA9P92vpM9SEadanIGk1Y6ITeBLGHBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7313
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-15 at 10:10:25 -0700, Tim Chen wrote:
> On Fri, 2022-09-16 at 00:54 +0800, Chen Yu wrote:
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
> > +	return (p->se.sum_exec_runtime <=
> > +		(p->nvcsw * sysctl_sched_min_granularity));
> > +}
> > +
> >  /*
> >   * The purpose of wake_affine() is to quickly determine on which CPU we can run
> >   * soonest. For the purpose of speed we only consider the waking and previous
> > @@ -6050,7 +6063,8 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
> >  	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
> >  		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
> >  
> > -	if (sync && cpu_rq(this_cpu)->nr_running == 1)
> > +	if ((sync && cpu_rq(this_cpu)->nr_running == 1) ||
> > +	    is_short_task(cpu_curr(this_cpu)))
> >  		return this_cpu;
> >  
> >  	if (available_idle_cpu(prev_cpu))
> > @@ -6434,6 +6448,21 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >  			/* overloaded LLC is unlikely to have idle cpu/core */
> >  			if (nr == 1)
> >  				return -1;
> > +
> > +			/*
> > +			 * If nr is smaller than 60% of llc_weight, it
> > +			 * indicates that the util_avg% is higher than 50%.
> > +			 * This is calculated by SIS_UTIL in
> > +			 * update_idle_cpu_scan(). The 50% util_avg indicates
> > +			 * a half-busy LLC domain. System busier than this
> > +			 * level could lower its bar to choose a compromised
> > +			 * "idle" CPU. If the waker on target CPU is a short
> > +			 * task and the wakee is also a short task, pick
> > +			 * target directly.
> > +			 */
> > +			if (!has_idle_core && (5 * nr < 3 * sd->span_weight) &&
> > +			    is_short_task(p) && is_short_task(cpu_curr(target)))
> 
> Should we check if target's rq's nr_running is 1, and if there's pending waking
> task before picking it?
>
Yes we can consider the two factors, then the criteria to pick up a target CPU
would be more strict. After taking nr_running and the pending wakeup request into
consideration, I think it would be a variant of WF_SYNC and we can get rid of
'system should be busy' restriction. I'll do some test in this direction.

thanks,
Chenyu
> > +				return target;
> >  		}
> >  	}
> >  
> 
> Thanks.
> 
> Tim
> 
