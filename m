Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CA0704856
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjEPI6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjEPI6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:58:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72E83AAC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684227493; x=1715763493;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sVbzCkTRPlhXFaGXG20GvR5yM/FE2yVgEVDDYwWmvjo=;
  b=RX2bsoiZqqDV8Quo+pebY4PuCTeVx2z31UyIQBLJzZMeoxaA6OwmbQwm
   bkvmWAI1xsCLhIwJ2icViiByQrgeHhWEZnhNjp0zC05r7ov2X26Zz6C5H
   P1UCJxN8CqV3jiOvx7SyU8XG1zBcNn3n/kNhJdWesXqAOsc97APwhzujF
   I/3b/yDKHDHIQyYePz3k65tHmxpm+XksWIQa5ngCnH7TAAbYfBjg8+JWG
   NdnMarQTN2WE/Jfmvj4yBqljov4vRAF999v/6ukRzb9fizm//3KEo32Yl
   JsIotEBkA4mV5lC0I//0cZMxY3cr1TYYzxbcVRZ+AEBAkkE9D2bBf91oe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="353700460"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="353700460"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 01:58:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="790999220"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="790999220"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 16 May 2023 01:58:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 01:58:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 01:58:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 01:58:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 01:58:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jB6BBLTnXGMoOuOFOw/ghjDpcUDgsHY7TcFnTKhvQPItPsqS2CaQEN7uyaUMecugq6Xbc8+1e5z+K6Ie1COdPwR03Lufh8xVWGI74Q5qINJeGm1TAE1H1Da1HPALrZpbUsTKy2+1qK0Ov3311fT4whAP/3JlPunm0rQomenHlMtzlydaskXCJ66Si6JLctmyd+72nDH+A1j+YLXPasygV5gfhiVKDPhWRo4S7KJOSeG5FKBYsepA0CTy69/KQRwJYaBsImmfOUUXUFqY9x/zSnUlGHxu7M1VM00CR1SZ1/lT1lGpgostXhd8WI9giNuUg+flmNoPlljvmF6SedJC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFCHhJRbX5MA+GQi0PCm9/tPP9orDaRkBe8xMXZDxxs=;
 b=mEXcTKI23uJlNkXkvtPBrUY46Yvbff9XpFhkuYDl2kH53DjQelM+AyUDG2DBsdqC9YgmxO8BPpNEcs0SJ05SPDmKnwCuNoXzIHkotoBjWv0m+yzkqLz3bUF7fiqdHP1JRUCC5nLla+kbFwj0HTwE6DGy2Vqs8d6uwHa64CERZOeiIxGrz2T9bN9iBGDg0WH+LzSm4Q58jPxOu2HHNlhJfgTRpNJ3N54KEINehuvxVVD6QZ2Q1vbY4BLqS3GhMqdzzxLKOEyAgY1Uh9a55gVcNgqzlRGVnXspxSJdwBrOCWinoUR3xHfH5Z60yO1U/ZD7EgDPJag+zro4ZxoIMb2N6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB4973.namprd11.prod.outlook.com (2603:10b6:a03:2de::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 08:58:10 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d%3]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 08:58:09 +0000
Date:   Tue, 16 May 2023 16:57:52 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Aaron Lu <aaron.lu@intel.com>
CC:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <ZGNFkDkyipat5J8v@chenyu5-mobl1>
References: <20230328125624.GA6130@ziqianlu-desk2>
 <76939bf6-1d9d-5f8f-f15c-f03b2322d684@arm.com>
 <20230329135455.GA108864@ziqianlu-desk2>
 <20230330174557.m6jsgb6hsni4mxwq@parnassus.localdomain>
 <20230412120736.GD628377@hirez.programming.kicks-ass.net>
 <20230420205201.36fphk5g3aolryjh@parnassus.localdomain>
 <20230421150559.GA162558@ziqianlu-desk2>
 <dfkllxtzchrxeqykzyk24ppgwxbztk6rbbb6xyizpbhg7ctibi@fhk77qxo7yia>
 <20230504102746.GA137823@ziqianlu-desk2>
 <20230516075011.GA780@ziqianlu-desk2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230516075011.GA780@ziqianlu-desk2>
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB4973:EE_
X-MS-Office365-Filtering-Correlation-Id: 1836d6d9-deeb-4dad-a946-08db55ebab99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x32/PU30AFuJGWGqb6/cv1DJwlgj9zc22ge5aVBHV8bR+hbp00mpgmp1whyth9ha5QBADYotSYxTZTKo+8+mIv+zw/jAlVFRH37JTWB+LVwwSX2ANy98jgHJ6yqF8cr+mspn8IEN+D9bmyLkizroKC47BCnUYhpcTtk4IM+QFc52NHB9BySODrTJz+8z+shvdZTmLJHJ/YbEAl0Jaqb/a2w2hqlXtKb68KaFX1w3SK7EVaGG0yuTJBiqG/urv42Aa8dYg1Y+WWz2m+xMtIvZuhCEh7/rtq+ExQUmxHct/2FuhUKlH+kEOmfP/46uv302OIVNVb8dbqEP9Kk3trlPjb3BjFDBCmA1QJfSw+0oU8Go99t9z5N3zArjkYEb3GcjjfQHmhB72SeiefV2AVBe+fFq7m+xS63H64QhZgIOPRrIVizp5Q7yZorGRsOVbgEYjn4SHFrdSNQ7NEwNO+xS23vh3tHuBgATFlpgaqcqSDwTNfNtOYAnJy3ZHzgCX6NgpCVKUynVzQSVpdl+axjzXOpi9ZDs4arQrQKHLk21QaleK7yM+NVm0smTR88AjJ4G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199021)(33716001)(186003)(6636002)(66476007)(66946007)(66556008)(316002)(9686003)(53546011)(26005)(86362001)(82960400001)(4326008)(6512007)(6506007)(6666004)(6486002)(83380400001)(478600001)(54906003)(5660300002)(2906002)(41300700001)(38100700002)(8676002)(8936002)(6862004)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HWqiG/XMknzT/xQl69NBCZOMeAAZhx74N+b3FA821kl+bU5jTVTweYSrktAH?=
 =?us-ascii?Q?YPGfV5fYBjBx7nfxNO5g6Q0Of6zeqpM+i/vgPJVn5R4YhZkOqGCwMa5r8x4g?=
 =?us-ascii?Q?1nXH0vk4G5L20Pypwu8jBK4YrgAIIiemig+L4tPgSDtH5uEMQDF1xpOmupFf?=
 =?us-ascii?Q?f4997Hb0Skjco7vqbEEHlmRjUcLoeUn2GBZJgrdrisRjMn3gmj86x1wmloXw?=
 =?us-ascii?Q?MjMq0hSpa7JxnMowTBzwDFh5C2cl3tWWDsN3oBs7ahSzP1PwljRO/kXy0ECs?=
 =?us-ascii?Q?r7922gEYJXY8GZFhoEEyCX+4wCyCfeYTK+UzXHQqC+hb91LnRB7wNURFs4w6?=
 =?us-ascii?Q?rPhcUw5m5MQA9TDhb9xizLeL2k5zPX1ZVtwL77qLZGKl1lSl2Yp7D4Fq5dKp?=
 =?us-ascii?Q?zUivD39R5398Q3NRgUb/zmrUhkepGr2GL1pDJf+89r0so+GnoJMd9WW//r3J?=
 =?us-ascii?Q?SAExWFbbv6FGT6gMTJf2A+LACa58RRuCyS05FY9Jx5i9kBEiKrM+kprLjzkM?=
 =?us-ascii?Q?AgUgzsymVtY/69j89BA1t7PN6hj3DmnEcVQoWaho2Ve6L300wt0rGCOfCPzH?=
 =?us-ascii?Q?qGHArb8ZLMfHTQd3m5sRHGy3MldBUgLSP5mWPnORtMLaZTyjv0rPN6WbuAzc?=
 =?us-ascii?Q?aVyNxZUPJESnW7CU1NP2zNBSKLQFCmLuRGcrHoxVcKIKt6Egzuf83grkVrDp?=
 =?us-ascii?Q?R0mFX/WRE0hxP5fOv2WhHDlErATw4gKXPamRsi7nN9Me/fZkQAWJje7sFjiP?=
 =?us-ascii?Q?/E5WzEDqRWNH1AkC3wggES9KhGy63VG+8wuMEQKjU+1hZHuh/PKUVyGuT0n9?=
 =?us-ascii?Q?XsK0ZWIfB2nm9WSpLjAjFiJn2v29ixK4VsRkRHhDSvjonlizPAOmB4ddNB3L?=
 =?us-ascii?Q?FCeeLehyJs8EHARWRdrbJJvc1HeiDL8clfJ99u0pBP0X/OUPUm2/R7x59u84?=
 =?us-ascii?Q?7TzVVt1YytBc3xloQHzALQsOwziZbNtoMGntNjY8r/uSKW/0/0a3CcQMf+Zs?=
 =?us-ascii?Q?w/2XzFfmjgqgr8Nqe4agHM/gP+9ngZ1p7P1TT4hrSjmAsDLDvsXg+dKhWZGK?=
 =?us-ascii?Q?f8mXZxXNxhUbQDKJ0I9UE34R4stcdisu7uEU6UCvFhawiof9B6VNl+stZqaT?=
 =?us-ascii?Q?8Jk51Vzh2tSr7oX4Rx3vO5oTy7xG/T04LoYyR4SzK+pOLYT/OeKpkorUL5Uo?=
 =?us-ascii?Q?nXaBnHkqD/QFP7Cvg/9UiQVYRnveHhwsNGu/+GOoFhe9dNx3R708Krahtgd6?=
 =?us-ascii?Q?3A803sRk4g2TJUSXgjrCppQsgOet/AV/iQM/BwKlWzu7WvphXa+0beaHJ+rz?=
 =?us-ascii?Q?b3o6zyf1lSNsjo+54R7V8pE7MB9R6TR5ZAwO+09H3YrAqq6KuavwuvyXpCBA?=
 =?us-ascii?Q?WVuup6aFLA47dWJ5d7Talyfv1ZctYM462BxW9ermBbyKtD4VxIz8tyTG3IDF?=
 =?us-ascii?Q?6GdAsLuG44wcKFDQFnQwpg5RUNWxv9kRz08jhU26Fcrz/kHyyE9EE8zQyVIo?=
 =?us-ascii?Q?ytMEPWNslPLaldF5lkrgqR0xTHh3UlLxJ8t4zdqg7+C+hFhpA8HIg7RKZv4v?=
 =?us-ascii?Q?TDu0DSciZgfYxx4fS6PQqCfpK3GvQ0KruqtY55CJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1836d6d9-deeb-4dad-a946-08db55ebab99
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 08:58:08.9892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+9G6k2mrt+gnbzkhty/nFFERf7zlM/RERmw5tXYwXWnE7FIxerhx8puVv1W1HFPUk8FqQuVpL60BXop8jsrQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4973
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-16 at 15:50:11 +0800, Aaron Lu wrote:
> On Thu, May 04, 2023 at 06:27:46PM +0800, Aaron Lu wrote:
> > Base on my current understanding, the summary is:
> > - Running this workload with nr_thread=224 on SPR, the ingress queue
> >   will overflow and that will slow things down. This patch helps
> >   performance mainly because it transform the "many cpus accessing the
> >   same cacheline" scenario to "many cpus accessing two cachelines" and
> >   that can reduce the likelyhood of ingress queue overflow and thus,
> >   helps performance;
> > - On Icelake with high nr_threads but not too high that would cause
> >   100% cpu utilization, the two functions' cost will drop a little but
> >   performance did not improve(it actually regressed a little);
> > - On SPR when there is no ingress queue overflow, it's similar to
> >   Icelake: the two functions' cost will drop but performance did not
> >   improve.
> 
> More results when running hackbench and netperf on Sapphire Rapids as
> well as on 2 sockets Icelake and 2 sockets Cascade Lake.
> 
> The summary is:
> - on SPR, hackbench time reduced ~8% and netperf(UDP_RR/nr_thread=100%)
>   performance increased ~50%;
> - on Icelake, performance regressed about 1%-2% for postgres_sysbench
>   and hackbench, netperf has no performance change;
> - on Cascade Lake, netperf/UDP_RR/nr_thread=50% sees performance drop
>   ~3%; others have no performance change.
> 
> Together with results kindly collected by Daniel, it looks this patch
> helps most for SPR while for other machines, it either is flat or
> regressed 1%-3% for some workloads. With these results, I'm thinking an
> alternative solution to reduce the cost of accessing tg->load_avg.
> 
> There are two main reasons to access tg->load_avg. One is driven by
> pelt decay, which has a fixed frequency and is not a concern; the other
> is by enqueue_entity/dequeue_entity triggered by task migration. The
> number of migrations can be unbound so the access to tg->load_avg can
> be huge due to this. This frequent task migration is the problem for
> tg->load_avg. One thing I noticed is, on task migration, the load is
> carried from the old per-cpu cfs_rq to the new per-cpu cfs_rq. While
> the cfs_rq's load_avg and tg_load_avg_contrib should change accordingly
> to reflect this so that its corresponding sched entity can get a correct
> weight, the task group's load_avg should stay unchanged. So instead of
> removing a delta to tg->load_avg by src cfs_rq and then increasing the
> same delta to tg->load_avg by target cfs_rq, the two updates to tg's
> load_avg could be avoided. With this change, the update to tg->load_avg
> will be greatly reduced and the problem should be solved and it is
> likely to be a win for most machines/workloads. Not sure if I understand
> this correctly? I'm going to persue a solution based on this, feel free
> to let me know if you see anything wrong here, thanks.
Sound good, but maybe I understand it incorrectly, if the task has been dequeued
for a long time, and not enqueued yet, since we do not update
the tg->load_avg, will it be out-of-date? Or do you mean the task migration
is a frequent sleep-wakeup sequence?

thanks,
Chenyu
