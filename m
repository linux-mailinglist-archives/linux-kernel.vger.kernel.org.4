Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0B06158FD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiKBDCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiKBDCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:02:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8C723143
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 20:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667358125; x=1698894125;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=M/XH+N2L/3ghRv+cfOGO0dp7gSJtPMRXCQhd/JvEoKI=;
  b=PRdFbojiktMRoh20JW9kHhV+mzyLOE18p8DfptmgBVq2W5wzjTq7wInS
   VgE9OopRMriLjQdoi0/s1wgrfFwvhvhBz9JoSUCvFxp00Z1I2sgGwsect
   k1sj5/58oMoPMh5OkCFx4H+5Ib5p/lRNG5KMFtKRmqpZGf1bST2FxEbLB
   rJJd2ERNp2OZCjf/6gRKweGG8S/KrORryu+H69odiZ0n44D7UhjwVbgXk
   V8bLqzfxQEHtNtqm+9yfOwkl3oy3N8BTFcBEIZ1bWBanZEzdple3NkdNQ
   Uj2aSvu12oAwM4rzD6xfvAtQy0teyn3pZHv6+7A+LAz8ihcKyqGDW6vdx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="289012333"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="289012333"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 20:02:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="585229969"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="585229969"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 01 Nov 2022 20:02:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 20:02:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 20:02:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 20:02:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 20:02:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gL6lNWZ2hEszJYUFq7MiS1Fav95A+gNaCwn8z1BDNBTpmRuKJZdMuy6dS7iXCxdG3zq9rwZuWyY92A8dWMqjdZ5ls6fTzOQ1nHVArQ1+nmz/uiYDIRzaUNa4o3uZSJ240fS9Lpw/BDQ2cFHP9sZ09ldZoyFxwI/DvdYm1gk+JUa25j9i2ky4mMnVPgLyKnoGmrwo4jAoGgGL8hlYUVRO/dTH/b7iaFKDGGZwO+GG4KLNmsYSsyG0jJ+l14QXOGHeVUeAQZI+YTqGjWzRCp7SfJtpmg7JnBPlptE05MCj9GNRSF8OODw9Ja4oKSYWbzNPul+RxGPh7SElgn2tgHjnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaLInzpXXaAT6NQLRM7dIsCHLQdPGgEeKvqZZL2tJvE=;
 b=mfo5hFZOl3HiJpwXQnbjSy3Hzwo+VAysprv2BDCKJaOWr9MmQK1nSHBSSuV7fr10c2jxSkl+PGcet/iWOu8BN2UDa/gEzLXnzqFkxurAfQgfPb9aK37Wu0swvtf7pbAmM6tsJCamqqnucLMMIMNM6Aup6r0LDhq6+tNTbSbFyDvm0PbjRVyu0WpsKrJBYeVB24VxAUYRR1qiDbrj3cgNGdOUJdpCBAfwmhC+r3ouN4CPFd2bJVrQJwyVgGVCuABR8ubaGqx6YJgng+HzOvsMvsjHptTtPIN+YaRi7Nkhm21ZmfJQ8ibtWbPQiXXfUKeEDBGJWNAs+b0a8mcFOLX5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB5914.namprd11.prod.outlook.com (2603:10b6:510:138::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 2 Nov
 2022 03:02:01 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::b6d7:8853:f8a4:ae30]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::b6d7:8853:f8a4:ae30%7]) with mapi id 15.20.5769.018; Wed, 2 Nov 2022
 03:02:01 +0000
Date:   Wed, 2 Nov 2022 11:01:38 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Tianchen Ding <dtcccc@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Clear ttwu_pending after enqueue_task
Message-ID: <Y2Hdkkp4mYK+fjDP@chenyu5-mobl1>
References: <20221101073630.2797-1-dtcccc@linux.alibaba.com>
 <Y2D2HIZuGP81w25+@hirez.programming.kicks-ass.net>
 <Y2EkXYqZ15/Kjl6H@chenyu5-mobl1>
 <Y2E0TeFJorjOXikX@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y2E0TeFJorjOXikX@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SGXP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::20)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db33d00-0305-44f4-0a03-08dabc7e9d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SyW+Tv3JUK7fwp4GnwfmwFc52KXxZQ9ZQoIn/M3vdqEYiT2cgMrGsSKg8RGwkl8QjHEQdTgIFiWOSGL0ptKOhiXWLdg093C9GQU95xmx2xu2U1yBHvkTiFLiIHl3T6TTGW8cwNfOUd3cVfEqBlogElj+HWZhhN41qHXvtWhDX4qMpuqPE/SoseWSlobG5v+Tjfix131oh2eokRDj9yJMYu8ZsHDhssaJAXdXQF0Vt9VJepLjtDBeiZZjojnCMCgCWqmpc9oq5FKIOMfqjv+6g0nINrJVjrdnPpPsDqxkclTp52mg3KyGSxMVuo8+VRIb6HogMkLVVRvRU0p1DopKf+6++3lFxb6Up1cxI0FEz8NgRz+rL8y8ewu1Ot+xLdMbfFJ9zzFkDmwtYgAMsEhyhacdrZbwkxzzXfWCU41OEMtEmjqKEcwUyBRDCRt8+xi0GlXqq4ucr+HUj2GMSlABQPJWLTfqSRBGQLfnKP3dXZia8LD+DnzlDuL/z/MxmWOYrFae5nHM8aM7jdScjUoJ1DjuDn7PcG6om2IBZ8qzy7Z25fFKISRvttVzMvlqggkpR0XjScan9cz1LnsENeUQaZmx3UG424iRgBhUBcrv+PR4JN3lFr8/lONUs0Gmb3PR1mkmI5BZ+bt3C7SsgSbJ591Tuk7soldpTa/pDlO4WRzkKhZN6yrAyhrkRKbItH3w6Xu2w0qMhafh4UVDlzZKGs7DfFUXP4DDrUmTvVsO1qb/4IhXJCAyQOTJ2ywJUs9U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199015)(33716001)(7416002)(478600001)(82960400001)(6486002)(66556008)(316002)(53546011)(83380400001)(6916009)(54906003)(38100700002)(9686003)(6666004)(8676002)(26005)(66476007)(66946007)(6506007)(6512007)(8936002)(41300700001)(186003)(2906002)(5660300002)(4326008)(86362001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lCa3GtJ7OtbchPpjVHh6e5l6OHqjX5DZHd9zLNihqNCbjG3zz1jJe548yAXn?=
 =?us-ascii?Q?AxGa5Rr1mOYE3engt5netEoaKyLwGQ8eplJC5FECtuZCeZx/gnajsXXjob/H?=
 =?us-ascii?Q?KchVVNQSJBfl56/fq3nIBamxir4FdjYRPquShtFdTXPmeZBznVHtW3WjsAj4?=
 =?us-ascii?Q?cTlIVW/TZG/tkrstTPjtictkKH2owG7lOrzIzV2i378X7PQ2miotV+nGARHo?=
 =?us-ascii?Q?5XtRC2DoyF3EJCA3fxvSF4Yjy1IwXJFl2ilyzpbodJE3Xz+oozQNFtMcwC1l?=
 =?us-ascii?Q?U27vC8q5Dseg8eZYvGG/xKDjWrkpcRtMl2cp2fsx9IPlUffopbJsbwGDGSoC?=
 =?us-ascii?Q?X3z5+z0J+6xDx9JFSCeNW9WaLyafQsQb0fdub2+hVZcrCi5vQH+4HAaPtD+w?=
 =?us-ascii?Q?YGKfMShRyiilcfGfR8po6BQ9UUqZ2qeihGDmIW57kZ/kwbXAmrjIX3HhlyoP?=
 =?us-ascii?Q?vVNdxJBWykmy4JIgTfWIRCG9J9Q06ex4H1ABWTMT5ntZepN2ssHX/LHdtdXQ?=
 =?us-ascii?Q?CPvnesf6gOa/skFfMQ47X0xxvulAANJecjR1WrZfWygFlfW1xRMfQRvbjsS4?=
 =?us-ascii?Q?jRlwv+lZVdQQWWh6w0Udi5PexE/WCj5AQ5zZT3y1UqyHckCth/zncfp84itz?=
 =?us-ascii?Q?kITURFxLhxGVumssOb7mkundttGTRfHP6W27GjbGnytF6Wv9Uhn+fc4ckRH/?=
 =?us-ascii?Q?OHxyiAqf1y1r4FQCfN8ZRrVRTSjaRWgzEKYLa0ETcs6klSlG7GAHuCzHSaDM?=
 =?us-ascii?Q?OhA/Py2dJhBE1Mv370JrEmSPzUN7anMPQ02VXmxSk2lfWqS8/xyV1vMxt7ih?=
 =?us-ascii?Q?QFZZLM/oEtw+QMZ/FM+2JPLo4JjQx9JF5eEwHuQWjuC6gxh9ve/p5FgqruPB?=
 =?us-ascii?Q?ZoiWG4nBUqUwQooOzU4Mgntq3tzYiCQpvpCrFVt92FqH+yz3S9S1LwBn2gRR?=
 =?us-ascii?Q?KSjOEbqmfgr06lthpE6WImjKwqIzEUO4zb0IuS9cCggXIYwxEoVIfljgVrFF?=
 =?us-ascii?Q?1mShfZJK+HGjVADufPPCIXTcjYGz08JHRB69AtKDs/FVsmtWVLMcEbiqoeR5?=
 =?us-ascii?Q?rdiaXQicHrjlI2qSldIVrMUsd9uHP/LmsX9pPHSRZqbyI2BTuYftcjdEIeWk?=
 =?us-ascii?Q?OfLiEckgnLNzL5DsftIUdKd+ePVhWuv7XY/9trAz+FwIcMIRnhCOvnBWeQhI?=
 =?us-ascii?Q?zCms7T3DzBOM0xI7fA4P7FGBghBclhPPyTibS/sTCq33CsBIbQ9/MXqJ8+CJ?=
 =?us-ascii?Q?QZ2S3UTbUpKu1EG6RurGxOZA8RRA/yqdRLGEpm8MQ9c88jnm/4yrxq4GlHoE?=
 =?us-ascii?Q?kR7pI8PBiJ4vrwIuMpgxq0dsPF0sQQ4Ds9OzjlizPyK+IQDTbQ8wHpNYnoyo?=
 =?us-ascii?Q?bjhHhQJhTK7FhWLdnPnivm0tCJg2erIRvEHBj7Nrj5IchCLLaF3eveoyxF3D?=
 =?us-ascii?Q?stn9/2UJla02UyFNXPeILwUdR+UYL57JdsZfmF4F/f6WFBLTWGTmhSkLkRbk?=
 =?us-ascii?Q?7KsoLXKOcBjRnrJ9/jo4a+/Z4cuqy/O13H+sEHYA3j7mbBHl3Bv8T6vI6wLi?=
 =?us-ascii?Q?P3FsnEf+S0xLgQP01vlh5Y+gnPOqkiIgt5MFdXNe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db33d00-0305-44f4-0a03-08dabc7e9d04
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 03:02:01.4253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Boznk0aVofsbmvooMrIfLvTSB0Q5DaPM2dz2EYlHH0TGfUJYotuEvfWvanmiQG0GdXa2vg8R3xHIIxubodNM1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5914
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-01 at 15:59:25 +0100, Peter Zijlstra wrote:
> On Tue, Nov 01, 2022 at 09:51:25PM +0800, Chen Yu wrote:
> 
> > > Could you try the below instead? Also note the comment; since you did
> > > the work to figure out why -- best record that for posterity.
> > > 
> > > @@ -3737,6 +3730,13 @@ void sched_ttwu_pending(void *arg)
> > >  			set_task_cpu(p, cpu_of(rq));
> > >  
> > >  		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
> > > +		/*
> > > +		 * Must be after enqueueing at least once task such that
> > > +		 * idle_cpu() does not observe a false-negative -- if it does,
> > > +		 * it is possible for select_idle_siblings() to stack a number
> > > +		 * of tasks on this CPU during that window.
> > > +		 */
> > > +		WRITE_ONCE(rq->ttwu_pending, 0);
> > Just curious why do we put above code inside llist_for_each_entry_safe loop?
> 
> > My understanding is that once 1 task is queued, select_idle_cpu() would not
> > treat this rq as idle anymore because nr_running is not 0. But would this bring
> > overhead to write the rq->ttwu_pending multiple times, do I miss something?
> 
> So the consideration is that by clearing it late, you might also clear a
> next set; consider something like:
> 
> 
> 	cpu0			cpu1			cpu2
> 
> 	ttwu_queue()
> 	  ->ttwu_pending = 1;
> 	  llist_add()
> 
> 				sched_ttwu_pending()
> 				  llist_del_all()
> 				  ... long ...
> 							ttwu_queue()
> 							  ->ttwu_pending = 1
> 							  llist_add()
> 
> 				  ... time ...
> 				  ->ttwu_pending = 0
> 
> Which leaves you with a non-empty list but with ttwu_pending == 0.
>
Thanks for the explaination, in theory the race windows could
be shrinked but could not be closed due to ttwu_pending is
not protected by lock in ttwu_queue() -> __ttwu_queue_wakelist()
I suppose.
> But I suppose that's not actually better with my variant, since it keeps
> writing 0s. We can make it more complicated again, but perhaps it
> doesn't matter and your version is good enough.
I see, although I'm not the author of this patch :)

thanks,
Chenyu
> 
> But please update with a comment on why it needs to be after
> ttwu_do_activate().
> 
