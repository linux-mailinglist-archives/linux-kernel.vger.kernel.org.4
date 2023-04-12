Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123E86DF810
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjDLOLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjDLOLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:11:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418F04234
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681308691; x=1712844691;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i13S+u1ep5swR+7Lo1o6HGY/CERl1q4EshzGdfaIbpQ=;
  b=k/QTXkxZCe+yGgkZmSrIAzAco7Nr/hcV6o/jTvMzDkTe1i1KbkxAHNLb
   jgx5iZCcAnvcsTgDMEFkfND+WbB78isninoePfQxgpbayjBNbg8tLjs15
   3TZTPC5rW3RIMSCqjKkQygneeI5BGLPDJ5gs0tlGOdftwRVj6VIx+uVjY
   CWK31f5pZdT1ChK2f8bFEU/LuW5wuUJ5hD+spvFi8lsq1fBHjQLyrwMJg
   NRYF1qR6/pHX58H9bsF+JU+fqOdIl9yjwRykvsnW77Dq64S39XdieqqN1
   5CeAO5+SvfqSZH14U69BcKMupaO7rstoeYWCWIT0E2Yp9Ib7+ACkFPc1q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="342664006"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="342664006"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 07:11:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="800349246"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="800349246"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 12 Apr 2023 07:11:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 07:11:30 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 07:11:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 07:11:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 07:11:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtbsGKxDNM3tbxlJKFL6f/fG1syazzGZs5kDwgtd8DI2/+URRj5UbxkrQkSVNt/LCdtGCOgGT3youoTEZQkZ+2IkJ9zP1dIb6M3HA0mcPKo6PDgR+fgx9pao2MUV3JE1nrE0SO84KmwCp+U324bESdIqUFr98lQE3LFYkINPtluNmiFxHSKmE6m/2HQAfMkqewG7kq0ElWhlKr3B4o/HYDrnvpR94oHnxdc+lAEGDgZycWB86MSnQZUF6QYM+9H+P3fltR6lhS4AcLVRizEaoLRG/lQ8bL4HjCPd4+vjhxi6xDBRvsmCoA1tfp/z4t1c/e73txrvmYoX7RCCit7F/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zK3HTtT9OE4xPAW0j2zKbhHvgCiwwUxvsVLjIDU5xY=;
 b=KYR0Atr1syh0WHoYOXWc50JiplkwulYqHeoFuKmha7+eXGzo3UWS6Z0/YRjo17ZR3evwYGZOxOBdM68jQFaasHXEEI4Xy35ck1AoRrLmFnbv6wzvVdXPL1mjD4PPy2hj+0m0wHkMru81+8gsKd3bq/15GzRjPRreS4t8OinwcY5PuP0xzOFGu/DfK2mEGJXoIKxahM730zuH+GJnESv1GLrfOP4njIoVskHyWHFYSM9vr6yGBZQ1mT7XWfv74NYFImoN7Swh1a3xb+x6rOLaIeH48se7Tw7y2lgU6t5LrMCks/YWPRPj8u2yxtAzIwYOCTQ4Rl68eFikdwqKvgky6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SA2PR11MB4972.namprd11.prod.outlook.com (2603:10b6:806:fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 14:11:27 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%3]) with mapi id 15.20.6277.031; Wed, 12 Apr 2023
 14:11:27 +0000
Date:   Wed, 12 Apr 2023 22:11:16 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        Yu Chen <yu.c.chen@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <20230412141116.GB155769@ziqianlu-desk2>
References: <20230327053955.GA570404@ziqianlu-desk2>
 <20230412115936.GC628377@hirez.programming.kicks-ass.net>
 <20230412135828.GB629496@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230412135828.GB629496@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SA2PR11MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: ee2c9beb-dd7d-482c-a48a-08db3b5fce67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3J/WC9mp22tubZ7EZEeIhiXYIQ5FVEZMk1IVMOt2c5HGYq7/GK9YrV51eePiUCHrZFSblmPEmlIbvZuwOh7OKCQm7ifZPJtxjIUBxz63ZGkTdRniTyFsWoyNuPFFHN9SYmcJlknMXVPjLw4/f8/Th2YrheMzW0/kH1Q5wJl/nE3WLi6iLP3aM4KuJlOI+x2Whv5RcIf1TZLu4Yp06g1aOMJU43i324CsJI8ezFa42P09nfgNLxiDe6KxUPnrHlSI27n89wlbmLpzDOrH3iATI/FrScXNAfg9lMtiH93Q02AR/DS7pVUOjF5xJ4UH2n/6H1nJVfhejYqOYxFugilcrFXh2upiejL4Zbzov1PFeHMuHkPJQgADVwA7+hIPxQuRqNkI8nIEyG2xAilTdnzZMRdAHsv5xoXt6FdwqjAtN/mMwYwmDKL23KDP1D4TZLjfHRgMgc0gqsVscbSog5vIipI96+KrnfRwm9gSTEW90ZjSP9VH5yEuRAOHrBtrmejzgS+DLp2faKwkCPZ4mvuv9wlmCzM2taTTA2o7hkodxfSiCVCOVHHWHPJXnY0t1k6N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199021)(316002)(41300700001)(6486002)(6512007)(1076003)(9686003)(26005)(6506007)(38100700002)(6666004)(86362001)(186003)(33716001)(66476007)(82960400001)(83380400001)(66556008)(66946007)(4326008)(6916009)(54906003)(33656002)(478600001)(8676002)(8936002)(5660300002)(2906002)(7416002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OHGmee+CluOMC34V+tvT6tYKv0YeF5VvrcjyRes5mHYGUsfJPyQOfS/hMcQC?=
 =?us-ascii?Q?AaFmhQrjzDnOrMFibp/bNx0VjuTIVQMUC7htoIKFDe14AzX0fintXfF5rGu0?=
 =?us-ascii?Q?XXD/dAcK+fsW1KNoYE+SnMVjDEG1goA7yHO30+JjFcdodAXyCPbLxB71vGxU?=
 =?us-ascii?Q?Dg+ih1qILpI6SVoorHvcLmem7jMfKegdigVf2nHGPRz50wtN86dLOguJ4jsP?=
 =?us-ascii?Q?xgCquTGlqanUsbasXmzJjUSzHXv+e4IGvwwI0Kv9hCI0LouxKC7pxmgai9+z?=
 =?us-ascii?Q?zVI/FdHAiuo4SSYBre38y7MCMJp7/NGiS8yvA1dYUb907eakJSSY++b9TzAT?=
 =?us-ascii?Q?hbyDMGDsltvEuQYfu6bkj7fbXbAMAfaXs47nUDKd6AspAORLC4ULtoD5jkGm?=
 =?us-ascii?Q?kkQYm45JqWgzExV7wFI/mPb0d723J8be2p4geyaNqJK96ZPCdPTSCkppyJqo?=
 =?us-ascii?Q?pU/5cTUsMB4axmdvIpnR2DzgSBrK4JoBylRed7poZw8ffS1k3KI8BCCGRPtr?=
 =?us-ascii?Q?PF9Ykp3rjXL8oo1+G/ftutuXHwmA73O5zQpcaDCov7dGkAWUtkQ9t6RDkEgb?=
 =?us-ascii?Q?ihi5Np/1/3Q6x5PUbtbdJRenEj2veyOMCNGLzeN0S/RmBmQhFATSw2itnvRP?=
 =?us-ascii?Q?3TtmfWaA1DkVBfTBMcnnWnmEKxDNaEgjjrhqggEQo0WbGUhMGa/7Ha38saQS?=
 =?us-ascii?Q?+M6/T1OKW0JmK37JM6zgLTtZlw/YDOO2FpdxYmrENtzWGvfyAMp13JYlJi2S?=
 =?us-ascii?Q?VQ7QF0AOu7qNsUaP0DeANAz7cooNzmfqspldonXP/Q87IGW8NYKWognE9/7m?=
 =?us-ascii?Q?QotOmLcrRVFZlOw8i0E58NNOYU7aiP2BSVchyh7/YTBzc3cuWWkCTwvijR0F?=
 =?us-ascii?Q?Ygu35AcdeaTJwVjYExDPHo4NRsMRNOaOrIYZsOXo3yVz2G5RrhWFlMKhwNuN?=
 =?us-ascii?Q?NnYphr/q/1DSl4zEMY0WXpudUFWJ21dy80Ll0DcpMkakbrhAf24b6PeEMkIM?=
 =?us-ascii?Q?kB59AFRtnGuYicph23e91eiJz0grG84AvZn754z5Eu6oPWc/a+vgU3u2Wp1T?=
 =?us-ascii?Q?11Qt1j13Wmz7PIoqWV7tULNSqW7dCGh5SKXN/yJv0UnpzOwKzoMJAa1M5bQJ?=
 =?us-ascii?Q?pLj04JSt627KdwWpje3KQdHrvOWjORT3p/5p8IXu9J5h09yHmdMZ82C14iON?=
 =?us-ascii?Q?SjAm5suO7DVhBj5Q13GXGPLjCGG1Ygr0dM2+dRHgifTlfZzWGMSBmDuWcD7L?=
 =?us-ascii?Q?kzFzrULHXn3b4Oe33SRcpndPDnOCXvo3EQQgZnMClw4gH9BNFIwE3rw65Yb0?=
 =?us-ascii?Q?BAZBiGmHuA73DNqISfXKOYPCRjYML98OD5iUXhOwz3choMRZvdj0BwWvHCLl?=
 =?us-ascii?Q?sFDFdPqqojdEr9P68LZM94H7HPgxOEQroy4SlcTuyASTc3zMyRTpDY14MMBe?=
 =?us-ascii?Q?Rl6H+0PcPhk9hoBGYpzaSUamLDy7eiAZkLOSQ3lkAJc1qETjA1IF3NA4drO3?=
 =?us-ascii?Q?TEtIoUfqFJOSeWbjyxnz55ySjWitw+r7lPONJ75qXkah13QPMCD6w01ngyHX?=
 =?us-ascii?Q?VHqvEzUNblCTjT/gYshWmst3XE9gqPclpHx+qWLn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2c9beb-dd7d-482c-a48a-08db3b5fce67
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 14:11:27.5625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpHs7/P3qmT6Iocv38Cy/MWQGxhyHNPLOUbv4fCHe5X9+J5RQogYOiaDd0YOuFnwiRZ8XLQelFsySduV3Z7sFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4972
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 03:58:28PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 12, 2023 at 01:59:36PM +0200, Peter Zijlstra wrote:
> > On Mon, Mar 27, 2023 at 01:39:55PM +0800, Aaron Lu wrote:
> > > When using sysbench to benchmark Postgres in a single docker instance
> > > with sysbench's nr_threads set to nr_cpu, it is observed there are times
> > > update_cfs_group() and update_load_avg() shows noticeable overhead on
> > > cpus of one node of a 2sockets/112core/224cpu Intel Sapphire Rapids:
> > > 
> > >     10.01%     9.86%  [kernel.vmlinux]        [k] update_cfs_group
> > >      7.84%     7.43%  [kernel.vmlinux]        [k] update_load_avg
> > > 
> > > While cpus of the other node normally sees a lower cycle percent:
> > > 
> > >      4.46%     4.36%  [kernel.vmlinux]        [k] update_cfs_group
> > >      4.02%     3.40%  [kernel.vmlinux]        [k] update_load_avg
> > > 
> > > Annotate shows the cycles are mostly spent on accessing tg->load_avg
> > > with update_load_avg() being the write side and update_cfs_group() being
> > > the read side.
> > > 
> > > The reason why only cpus of one node has bigger overhead is: task_group
> > > is allocated on demand from a slab and whichever cpu happens to do the
> > > allocation, the allocated tg will be located on that node and accessing
> > > to tg->load_avg will have a lower cost for cpus on the same node and
> > > a higer cost for cpus of the remote node.
> > > 
> > > Tim Chen told me that PeterZ once mentioned a way to solve a similar
> > > problem by making a counter per node so do the same for tg->load_avg.
> > 
> > Yeah, I send him a very similar patch (except horrible) some 5 years ago
> > for testing.
> > 
> > > After this change, the worst number I saw during a 5 minutes run from
> > > both nodes are:
> > > 
> > >      2.77%     2.11%  [kernel.vmlinux]        [k] update_load_avg
> > >      2.72%     2.59%  [kernel.vmlinux]        [k] update_cfs_group
> > 
> > Nice!
> > 
> > > Another observation of this workload is: it has a lot of wakeup time
> > > task migrations and that is the reason why update_load_avg() and
> > > update_cfs_group() shows noticeable cost. Running this workload in N
> > > instances setup where N >= 2 with sysbench's nr_threads set to 1/N nr_cpu,
> > > task migrations on wake up time are greatly reduced and the overhead from
> > > the two above mentioned functions also dropped a lot. It's not clear to
> > > me why running in multiple instances can reduce task migrations on
> > > wakeup path yet.
> > 
> > If there is *any* idle time, we're rather agressive at moving tasks to
> > idle CPUs in an attempt to avoid said idle time. If you're running at
> > about the number of CPUs there will be a fair amount of idle time and
> > hence significant migrations.
> > 
> > When you overload, there will no longer be idle time and hence no more
> > migrations.
> > 
> > > Reported-by: Nitin Tekchandani <nitin.tekchandani@intel.com>
> > > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> > 
> > If you want to make things more complicated you can check
> > num_possible_nodes()==1 on boot and then avoid the indirection, but
> 
> ... finishing emails is hard :-)
> 
> I think I meant to say we should check if there's measurable overhead on
> single-node systems before we go overboard or somesuch.

Got it, hopefully there is no measurable overhead :-)
