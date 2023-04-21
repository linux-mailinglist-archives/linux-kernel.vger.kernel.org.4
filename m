Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79496EADB3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjDUPGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDUPGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:06:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED8C19AC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682089592; x=1713625592;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CQcJjV1ZOwWIEiR5UdKREe10baVRe594NSZ1MGaUT7w=;
  b=adhWlWpSMFr+T+FH2wlBEe28gtifbR4NtCifObCn77ExOXNgjUSuIGQR
   5WFrTZqww2Ohy8ofbSMIXrur2wYSVIwYjAlDiYuA6ODr78cWA6NUgWn9r
   G2BE+awXEj3vL91QBMv/FmoyBuwo2ja6YYCHMWrf8LwMkxo1piX2COBBg
   JMXtmAlAr+odrAj32fdV4+P35x/YMYXf7aHfbeoIIOa7343/M16MZAxod
   dEyRTnGwcbWQVJniE2cYx1/eAFtonqkzoVMmfJhbV6f9VLvqchjUb9Qrt
   ezYCgdpA5R4Oo31pbHhb/eDrkWSDfZx8UNqnmNaZK3wS6RyNwGBv1RFVO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="330208480"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="330208480"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 08:06:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="642539109"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="642539109"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 21 Apr 2023 08:06:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 08:06:16 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 08:06:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 08:06:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 08:06:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OA3jRMBi1XeOuQlG1n7bg7zdNs7sJ7cllnUanXL5jQ63CTiMi/wayuR//NaIfWKpBUIsjteRbo9SK0LvJgPIZQMOfAK2+Zrtg1yMrVda+FuOEseHIAZrB1Cu7ZJnfJK1BvzUhZRfhGro5bVq7KnpTohc/re6g7QojaEeZKq4bxkDtzSu+gxgDVnEjDmoz/w4hj7bRf6MpQUKLZTbZkAkj/Nf7oohl5ukCzfOvPvNfRgaJjDZkOVeT0XWUYhZ3UiL+n2KzWSTK8srPOSa8Z++gRVk9zPA3zRKrIa0+McWK4nJo9Dj0meYpAFR94ZEDMee4G8tqA+Qn0qgmIqXmoc6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRCnGNAVJLuzYdGWJZPnV3BJtCJ6YwOEmt/iUkSCK7A=;
 b=c71JazZ/gjiNaE2eXuwm64w3kwJT5hEyGcQu9lUqwBfKjnmQMiMUOH2062tMdF8epjUp34OT9zqcV5Xrc7CxNrjZrjHAx5ukzcto3+qPMNnXVUTALydygksrG+8qc8/0IxjXWWS+5Os6/1zfrpdkoCS0ueh/qC9SjHN8sBaDJJU/wKS7476mtUlA4Au6etlGsjuFg/QHt+TzXDVC9PdF1os31v9RKsa9qquubdhkIIxS8oz1FtNcmP6toPGHz6+dsjj5EDQAWaC8Sn+PZ+zDzyiTrJRDD3z6CGV70Z41yl7V4VrqJRyNiMpTu55uSaVhb7SRJmCR1vRhV2pw+C9jaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SJ0PR11MB5181.namprd11.prod.outlook.com (2603:10b6:a03:2de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Fri, 21 Apr
 2023 15:06:13 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%4]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 15:06:13 +0000
Date:   Fri, 21 Apr 2023 23:05:59 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        Yu Chen <yu.c.chen@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <20230421150559.GA162558@ziqianlu-desk2>
References: <20230327053955.GA570404@ziqianlu-desk2>
 <943d44f7-1fa9-8545-dc1d-890e4dd20854@arm.com>
 <20230328125624.GA6130@ziqianlu-desk2>
 <76939bf6-1d9d-5f8f-f15c-f03b2322d684@arm.com>
 <20230329135455.GA108864@ziqianlu-desk2>
 <20230330174557.m6jsgb6hsni4mxwq@parnassus.localdomain>
 <20230412120736.GD628377@hirez.programming.kicks-ass.net>
 <20230420205201.36fphk5g3aolryjh@parnassus.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230420205201.36fphk5g3aolryjh@parnassus.localdomain>
X-ClientProxiedBy: SG2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:3:18::25) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SJ0PR11MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eedc187-a595-40d4-c510-08db4279f27f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7lhVkkmlZjRoX9CBV2Y/92vZ4nH0AIuaF4KdPGUshtEOgImoZFO86gbG64m3bmRRRQgsLkoCwHqCiqsz45JSfpYO58pHHV29ORd1xWuzFPp2U5FqLOc0X77kR+MJ91wFR9m+obv3RUYWL4vnhWoW6HbRBvAfXX0YIj6J6xMN1ayTCpSCn3YTTDtNX+6wze7+Z3fOmRNVmQbDoGO6p217p6Mkpyr5lVZXGWFjGhsUbb6Hf2UD9yvDd41KlqJ58gagzitv9mG+Fln6HvcmNG4zqKqxIdyr5Mznh17w01ZCRq5N2PiQCaql55AXkO2nY6d9ZfzOncKKygllPLGMdtFFeXunbOp5CtmCjThhETcJLZef8hBLM6iPtIElQexBjfBXSMrJbGlLE/OqbGjcRHkVOYf+tCTwtSu2u5HEkVwgp7a5LXO9wj1ymVeppgyzFHolXZrAF/zFL1sBG+Q3MSAQEInSkIOLMI2EEgj/bKgk34fe8O9amxmYvRv/W+/gK5ANhCpzgK6aZiAyqZpVxphK+Izlb55aO+Z4nTAR+o+TjYOvWJUEekAUuGyBYQjIRkuR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199021)(44832011)(4326008)(6916009)(54906003)(316002)(66556008)(66476007)(66946007)(26005)(9686003)(6506007)(1076003)(38100700002)(83380400001)(6512007)(5660300002)(41300700001)(33716001)(6666004)(6486002)(82960400001)(478600001)(8936002)(86362001)(33656002)(2906002)(7416002)(8676002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IKvKRMqOjhyJb3HgKDrIG2BBW8XjE7p4H6QiYyCyHxRN2XfwjOkckL0XPof0?=
 =?us-ascii?Q?/O5FTgkRy3MNJUhXJdq9YKiQ0lZprWnxpuPy37mmNEkxQ35kJhX1Fgd7OpdU?=
 =?us-ascii?Q?H4xl5DeW73awobwSJBWoOIEB0v0mnxdYlhjtV2ua9mVStUmMpecARF77eZLh?=
 =?us-ascii?Q?5HFXM8v3wPR5agVT3SI/2FSrydibBd1i9hoDeMSjqvG2E08RVQEojqt4OnP2?=
 =?us-ascii?Q?bVoix/srlyE14wOp7U9qlfnAftYUhAcBMV0n8qqLhTpujLWCv8VvBeMKUX5T?=
 =?us-ascii?Q?Zl2RaSBshFpyvuGoF1r6FVZZK1g70q/nuKRYuz2Y6G9qRnFdX+L6Lw4FFW7D?=
 =?us-ascii?Q?LjUxRJVsZO22Ls4D2+Vn0eWW71FlXnqnzmXD6DBy+UtQHm4+eCq2wu9ASVst?=
 =?us-ascii?Q?pndyIf068bu6nQpowMEvTB9AIQALtheftTQx+I1yKmbUbrbMgJOhdw6tODsZ?=
 =?us-ascii?Q?A7j7wIEK3CUWqCUJodLYqXF+7oAWMru3VHNzHcZQGXxlwALmh05U/Wk34rB4?=
 =?us-ascii?Q?frNtyNDSYHPpvT9HXKRI42pzfoOnWjmf/eEDFF0Pe9V13+93AkCppEdY01H9?=
 =?us-ascii?Q?2Ck4T6zm9dl1+kV14kY/88tOBBilx7QgUtPPldZ0RMmv3bTKNaKaHsgYlSx2?=
 =?us-ascii?Q?yz+3GGaooO8pu3M1+x9Rd1HHTdaxKtzQ4bsyN9QB1FTceapvrc95oTU2X+Z/?=
 =?us-ascii?Q?pjOY/THrvZXd+YujHI2xlzB7/WvC1Sf5XqwFn+dHFSMTetVOi9RFbdKzrdtP?=
 =?us-ascii?Q?JS2YdDW4eZeyNUzACWNcHPB5U02wO1N+n6zIsK42tUAHtf4YJdqorMlxhcr3?=
 =?us-ascii?Q?5OX298tvCIlpZCIhSDN6vlCEU0T37+IRhqO34G/FRG6ktIvQ9dmzdmZAAbYq?=
 =?us-ascii?Q?ODC2DsgX6NfxWNjrOiu7W/e0JJi5IFKxeTcmOhUulcfcMtbx8ojyP3KLW7tn?=
 =?us-ascii?Q?9fccgJXPMakhpQtAhWeY4wRKN3M0JlcLADk5AGk3nZUg7MKMJ4d5t9L9zG0U?=
 =?us-ascii?Q?6647IkcqA2Wb+lEYRfOEQVGxm0sYVIGPlTeZBV/gdRKBEJS5dKsro0ZFGgHm?=
 =?us-ascii?Q?DgMbSh4CCTFR+Tm6nx23XcZra551SxR9mEk51TcwtXmu4zBMEj3uZbI6B1Rz?=
 =?us-ascii?Q?9DBaz7pg4mfBBt9QYH/6eY+8dfTfG8XkKjdk1Mzj1m2IQ9/g/X1ctZU7kxSR?=
 =?us-ascii?Q?PIdyTMmDaEh4U+aryatGHLwLwnVCRJ8aHk4plopBJeD74IS5xblltO0146Vz?=
 =?us-ascii?Q?ThiZe68wSFXdA0+jUy51CRp6SvcrfQNmpUfaiMTyAjMO2D11osTmu2BqKpUj?=
 =?us-ascii?Q?/8x2uZIqDubXOrNs2Gxv4ATYVGw3frAKa935+khx2+RPUiW7rvx9raHEH38M?=
 =?us-ascii?Q?dEOe979n7Ub9ZuLwyVrSv4H16K2a96FLo0xeWDJLd47UzW7hcpG6oJntEDaK?=
 =?us-ascii?Q?guD8AU8ZcG6uMB4JpIJCarFzrgcAKfHmKG1l12vxafj1rFP3xg3HvkNXBDPK?=
 =?us-ascii?Q?5adeRzOVfGd0uAziekBK7pBNxECgrIJKsdDBqJiUSGet4HCt81nRMZ89FS86?=
 =?us-ascii?Q?JMXyCBFoccWHltYZQOL+mcirs+jsKouo1+D80Bts?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eedc187-a595-40d4-c510-08db4279f27f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 15:06:13.3565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqOREjBWyBQ6UBlHNfxeCpLtZS3aQ3d3SMeEODrU4BisvyQx7o1f+DhsdT5WSvW+7tGn/cxUbyFHwwqBBl2ozw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5181
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 04:52:01PM -0400, Daniel Jordan wrote:
> On Wed, Apr 12, 2023 at 02:07:36PM +0200, Peter Zijlstra wrote:
> > On Thu, Mar 30, 2023 at 01:45:57PM -0400, Daniel Jordan wrote:
> > 
> > > The topology of my machine is different from yours, but it's the biggest
> > > I have, and I'm assuming cpu count is more important than topology when
> > > reproducing the remote accesses.  I also tried on
> > 
> > Core count definitely matters some, but the thing that really hurts is
> > the cross-node (and cross-cache, which for intel happens to be the same
> > set) atomics.
> > 
> > I suppose the thing to measure is where this cost rises most sharply on
> > the AMD platforms -- is that cross LLC or cross Node?
> > 
> > I mean, setting up the split at boot time is fairly straight forward and
> > we could equally well split at LLC.
> 
> To check the cross LLC case, I bound all postgres and sysbench tasks to
> a node.  The two functions aren't free then on either AMD or Intel,
> multiple LLCs or not, but the pain is a bit greater in the cross node
> (unbound) case.
> 
> The read side (update_cfs_group) gets more expensive with per-node tg
> load_avg on AMD, especially cross node--those are the biggest diffs.
> 
> These are more containerized sysbench runs, just the same as before.
> Base is 6.2, test is 6.2 plus this RFC.  Each number under base or test
> is the average over ten runs of the profile percent of the function
> measured for 5 seconds, 60 seconds into the run.  I ran the experiment a
> second time, and the numbers were fairly similar to what's below.
> 
> AMD EPYC 7J13 64-Core Processor (NPS1)
>     2 sockets * 64 cores * 2 threads = 256 CPUs
> 
>                       update_load_avg profile%    update_cfs_group profile%        
> affinity  nr_threads          base  test  diff             base  test  diff
>  unbound          96           0.7   0.6  -0.1              0.3   0.6   0.4
>  unbound         128           0.8   0.7   0.0              0.3   0.7   0.4
>  unbound         160           2.4   1.7  -0.7              1.2   2.3   1.1
>  unbound         192           2.3   1.7  -0.6              0.9   2.4   1.5
>  unbound         224           0.9   0.9   0.0              0.3   0.6   0.3
>  unbound         256           0.4   0.4   0.0              0.1   0.2   0.1

Is it possible to show per-node profile for the two functions? I wonder
how the per-node profile changes with and without this patch on Milan.
And for vanilla kernel, it would be good to know on which node the struct
task_group is allocated. I used below script to fetch this info:
kretfunc:sched_create_group
{
        $root = kaddr("root_task_group");
	if (args->parent == $root) {
		return;
	}

	printf("cpu%d, node%d: tg=0x%lx, parent=%s\n", cpu, numaid,
			retval, str(args->parent->css.cgroup->kn->name));
}

BTW, is the score(transactions) of the workload stable? If so, how the
score change when the patch is applied?

>    node0          48           0.7   0.6  -0.1              0.3   0.6   0.3
>    node0          64           0.7   0.7  -0.1              0.3   0.6   0.3
>    node0          80           1.4   1.3  -0.1              0.3   0.6   0.3
>    node0          96           1.5   1.4  -0.1              0.3   0.6   0.3
>    node0         112           0.8   0.8   0.0              0.2   0.4   0.2
>    node0         128           0.4   0.4   0.0              0.1   0.2   0.1
>    node1          48           0.7   0.6  -0.1              0.3   0.6   0.3
>    node1          64           0.7   0.6  -0.1              0.3   0.6   0.3
>    node1          80           1.4   1.2  -0.1              0.3   0.6   0.3
>    node1          96           1.4   1.3  -0.2              0.3   0.6   0.3
>    node1         112           0.8   0.7  -0.1              0.2   0.3   0.2
>    node1         128           0.4   0.4   0.0              0.1   0.2   0.1

I can see why the cost of update_cfs_group() slightly increased since
now there is no cross node access to tg->load_avg and the patched kernel
doesn't provide any benefit but only incur some overhead due to indirect
access to tg->load_avg, but why update_load_avg()'s cost dropped? I
expect it to be roughly the same after patched or slightly increased.

>                                                                                              
> Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz
>     2 sockets * 32 cores * 2 thread = 128 CPUs
>                                                                                              
>                       update_load_avg profile%    update_cfs_group profile%        
> affinity  nr_threads          base  test  diff             base  test  diff
>  unbound          48           0.4   0.4   0.0              0.4   0.5   0.1
>  unbound          64           0.5   0.5   0.0              0.5   0.6   0.1
>  unbound          80           2.0   1.8  -0.2              2.7   2.4  -0.3
>  unbound          96           3.3   2.8  -0.5              3.6   3.3  -0.3
>  unbound         112           2.8   2.6  -0.2              4.1   3.3  -0.8
>  unbound         128           0.4   0.4   0.0              0.4   0.4   0.1

This is in line with my test on SPR, just the cost is much lower on
Icelake.

>    node0          24           0.4   0.4   0.0              0.3   0.5   0.2
>    node0          32           0.5   0.5   0.0              0.3   0.4   0.2
>    node0          40           1.0   1.1   0.1              0.7   0.8   0.1
>    node0          48           1.5   1.6   0.1              0.8   0.9   0.1
>    node0          56           1.8   1.9   0.1              0.8   0.9   0.1
>    node0          64           0.4   0.4   0.0              0.2   0.4   0.1
>    node1          24           0.4   0.5   0.0              0.3   0.5   0.2
>    node1          32           0.4   0.5   0.0              0.3   0.5   0.2
>    node1          40           1.0   1.1   0.0              0.7   0.8   0.1
>    node1          48           1.6   1.6   0.1              0.8   0.9   0.1
>    node1          56           1.8   1.9   0.1              0.8   0.9   0.1
>    node1          64           0.4   0.4   0.0              0.2   0.4   0.1

And the slight increase for both the read side and write side seem to
suggest it is due to the indirect access introduced in this patch,
especially on the read side where a summation of all node's value is
performed, that's probably why read side's increase is larger: 0.1 - 0.2
vs 0.0 - 0.1.

Thanks for sharing these data.
