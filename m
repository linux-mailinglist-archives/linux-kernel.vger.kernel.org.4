Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177DC606EEF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 06:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJUEer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 00:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJUEen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 00:34:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA7C2DD5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 21:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666326881; x=1697862881;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1O9HcDstW/H7n2HUPrC1rAzSlOq0P6p4ZHIbHNWWmWI=;
  b=Na6Y8IKM0jZ9Vbp2MnTUZH5I3GD3xtlpBhfqlk9evj+GUBwBLqv+gSCG
   U8EgBrcqNaW5h2lEQ9Dni+AwrCXb/XmdOe/B1znzA7ZVztwIr+GNJVSkR
   4pJVfcvhYZZ8ewmBbSb2ygQ9akMEYxVFK5vnUFxPxiKWIP7AhErpPLr/Q
   mrHuByNjqmelzhu2Fa2/AY+p0gw82DNe+bfdeSIgIQAybUso3NS/2/8da
   LQQgQHkJgGjlcUL90cFyTrE2dx9S0M+1p/mCbTLKexiMGP5tH++sx+O1a
   M0WZq2J/gpXVlbMO5n2gkkcOHIjwETFwmDAWB/3TvlEc+8d6XtyNe09Ym
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="368955925"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="368955925"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 21:34:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="875445415"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="875445415"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 20 Oct 2022 21:34:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 21:34:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 21:34:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 21:34:34 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 21:34:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnxW0Kv41uYC0tR8aYCYveddmGFNQji+c1cZ/xZIXVDgA0zlHH/Xmbq3JDkThVaf4BnvSJmLS9Qux/Y/aDr0qVmu+3bC0mAIK4OJwaHFEz79FNyciK7k0UU+7bLGZ1wmdvrVHPc70JCnS6M8jlHzc5ocUaCEjsQ9E+XCWopr+VAU9eW7XY01vHvZaZu5689BwzzU0/Q8Pqk0HkFRYw4nk+nR6p7XehQ5ETOZsJdGhlt9t/6Q04kGuBUjYsvaMDNtatJJEQSsmsvLr9lcTZnXCQSE0D9DQmPCwIhgUTkYZmEv4YSa3auEDqMgxVlHGxhTn1ZTezqhRwWFexgRzGkc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scaYpOT/Y+DeiCJZbE7H3JgSrVlN962yhH2MM2h6TGg=;
 b=Mb9SVCJLWGfXBYvNZx0iOS/5xogcgECJjLMWbgN3IApb9p4XCUVHfs0LduwDgLguU/ato+SJIk4bnjS5A4eOVIbDIeZxX5jYUI+62Mf5Ecl6+DOMCRUEt9AiNSCvvgBh7M12/4vEyBW4JOSHvzzMoA0i45EsZDE5VTWhVWKT0L2o4fpdvEVLHdw/t7bh/i0eDnWltjQYfKvmIA9kP1NLNLeQAEV+/5eKfU1b8FbCdLAX1DDZjtw1QWXMNnb40ZOX3RvtZLL3oYKCk6l3LnxJviY2QoCxfEUonlyfLfTmGj/WYKnNTvPRgSMmDb2/rNOR/q/AL+Oiu3l8K476rRgy2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB4879.namprd11.prod.outlook.com (2603:10b6:a03:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31; Fri, 21 Oct
 2022 04:34:26 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43%3]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 04:34:26 +0000
Date:   Fri, 21 Oct 2022 12:34:08 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Josh Don <joshdon@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Barry Song <21cnbao@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/4] sched/fair: Introduce SIS_CORE
Message-ID: <Y1IhQPWMX3TX+sYo@chenyu5-mobl1>
References: <20221019122859.18399-1-wuyun.abel@bytedance.com>
 <20221019122859.18399-4-wuyun.abel@bytedance.com>
 <Y1IZ/DZ1SWMn0QDs@chenyu5-mobl1>
 <9ec8a474-d923-953c-0b73-02ba2fd6ea82@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9ec8a474-d923-953c-0b73-02ba2fd6ea82@bytedance.com>
X-ClientProxiedBy: SG2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096::25) To
 MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: e18c753d-a583-4414-c369-08dab31d88db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OuD8pi6o3qFdc6NSz5WvknVJrL0NdvYICwC2TUMVHK4eJov+M+J+1+EDUYV/ovBIhoPn3iBlwNVIFfpM3PxqUnNr3tQJBrA/jTwzx5qA0B8B+8lJr/WPnCDhyUowtx9QoRxo/QD0l9vCqI29OiPDg1a9bPy9HhB9RWTlWVN0JdwU6p46zNkkFBCbpbxaYsfk7Wt4vGqVBBXP2xQhuHddYnLKruieMrT418E7yZ2RE8oE+2y0VQNozbpaskbtgfoq8dxCU3S9cxmqr8Z1SlPvlZomE6kkeFX0sz0TBiL4sUZWtzgMhAVW/fWOcdOcwErQ+GowhCtKTy3Gs8PDPlw8X/rJffGRFKCf/1lzq7VH9t8SEn5D6wjr5CiBIfm+bmpXzI0ehIlmCYDJsGFfRae1N7ksX9bi5XPkPn4UFA3v7syAovEwUbbIB+yofobdToZUYhMzeMvi8MknR5eiPvwVF+eOQkiGdA7OzfryVrOWiuyhvRGfHAZz9m9ZDVNqXiiRIo5myhrdYvno2OlT8EgVoXqrf5Rdvtnu14csvLpj/Fhq/YokxFiTFIl+MQ4L5KoBFB0Naam8MhOnIQT/likX8H2DwAQT1hCo/1M5NjslIg5IPqA9oSRbODL8TwRMWsNADJlqRVlMoj1U7O42wQoL9KvnLGEO8wEJbj6whMqhNKQ4aodxf75iF8IK4+XWLuw7FmK1K+YZCaSjWYIgMf9D1p2EtFH7Prn2Jexo2AyEc9VMQMh9Jh/8IN/zcl/DrUOV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199015)(6506007)(9686003)(186003)(26005)(316002)(6666004)(6512007)(53546011)(83380400001)(8936002)(5660300002)(33716001)(478600001)(66946007)(54906003)(6486002)(4326008)(8676002)(41300700001)(66556008)(2906002)(6916009)(4001150100001)(7416002)(66476007)(86362001)(38100700002)(82960400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9qYAt6sPZ5D2duK5ktLT9kyEXOpRRHxqRhODgBsci+7/Ke3wyISruyxDA2NM?=
 =?us-ascii?Q?sbpTHj/nSWA3vtH6YyMEyz+xHHfB0fsIRqvUI267Gmh+tcVED7CCEXxowWAQ?=
 =?us-ascii?Q?kFs6dxHoTmtyS0+WTTfuVa9Qy5hatXJmuSBU5vOnr1Tm8QY2hTg4suUO6Wgs?=
 =?us-ascii?Q?ImARW5aEtfIeJmwxixqhoucbi8keXMsPOIHD0LtaoTtqTI/QKqqoSwhICokV?=
 =?us-ascii?Q?nUojQzFYM3g4HC040U1JlNA43fwvbmU0OyIu9jWdDokTLF6TjeFVgTP83vUj?=
 =?us-ascii?Q?c2g2z0Lig5gAGaJIc8FkYUQK9pKiHRrJSpy/p9PD2lDSWN241su1shXUhdy+?=
 =?us-ascii?Q?pBNd4JRfVhkYVtmcaF14mraMkciYvzMxRiLZbMwSxjNMI8aTLlgRwqZvu72Q?=
 =?us-ascii?Q?nUv50ljQVtu0ARgas2unrMlAUrbhSXeDhybaK+iHBd/gjF6HP+N/tzVit8/9?=
 =?us-ascii?Q?PJwFbBliY/3c/ZIQqd5aaZC9vdEI2fzwAPfgAvyFUNmpQ2wAYYq+0IejFnxU?=
 =?us-ascii?Q?q/TA/3pmgqzOOdz1/kVM623kqNZ9c2l6ZnG7eik5hsOy0Yo7K+Sbw2iNOeW+?=
 =?us-ascii?Q?Rk58jFXSHbEY7h9doWQkFgxjQQy3QCQdM7jvhdT8FBSFCJjLnCCUCWOJ3ZhO?=
 =?us-ascii?Q?FDRzZNMYS35/V9e9G4ZJv2ql1z4jCW+08aAfCSfGcnMpYqxj9GjK8cIiUmyh?=
 =?us-ascii?Q?M9Djyri14UqlRL7LbPIzF+x3nVeX4uF5hACr7OKXI9WJKGhgURadcPtborFg?=
 =?us-ascii?Q?zeGK7mV32IrhvWhRpc6eJqVsnx707PUJfaHveM1lbdwwwt1Ezch2rwRgaWoI?=
 =?us-ascii?Q?5vsg4NEgLSCc3Uh+qRKSat3dQ4UH4V2OU2Y1BKvjaD+KRiRog8Kp9rXDxJu9?=
 =?us-ascii?Q?yBjkHo0E0kF828GaOhRE85w1SbU0ao1tI1c3k8pAiRLKT6iXD9V6nwzfex5d?=
 =?us-ascii?Q?/oCW/W+ozFq8o2NWWMwgXzI5CJAzfyZbuwg1Uqp6fOsAgnSQFNnBdwkEoOZk?=
 =?us-ascii?Q?eDrKaS3rhtJtXg3D2oG5VtNbpdVVeTFeShQv/heFPsMABmZ2fxs2F3vpbpjQ?=
 =?us-ascii?Q?ZnzqnO5DviWxnE1F3rTe7qLkcowl80o1sp6VLubCeCZzd8vYQ+jTsoFhJeya?=
 =?us-ascii?Q?W8dxAzTWp66A4pzJYS7FY/u277NIU6FyF4Zo4K6yfYZJEZYUozzxbjtVMgyL?=
 =?us-ascii?Q?bDk+1Xq9u/Euf9CGMVZp9th+ud5G53VTcPFRSFCbRCI/Yvv7oVVHYCqNq9ID?=
 =?us-ascii?Q?Groae8SEAlQS9tjIxXN5jsIIdsV7vJQYMxEstrEWOsQTdRu5P4ih2sIxEx3f?=
 =?us-ascii?Q?9M9Y16Wp80aL5CpyGzPEIXLPOrWYSZ08NUmhWxS3YnDgKa3RMnj7KWwippX/?=
 =?us-ascii?Q?hDvSLFtHXDt9qplDYzty90DujpdNUlyFPDyoJML5Il00e3MuGj0wsuFFfbq7?=
 =?us-ascii?Q?OfEALseckiyvT6xVQOFyzJ54lpTd/N65R1u7MHfFW1rqUMUQGyhF8W83Zqyc?=
 =?us-ascii?Q?xlkFEDgAAW2CtnxTVmCVovwRlw5Zky+/kSAZ+BDuyD9sIvswNevmi47aMg9V?=
 =?us-ascii?Q?DpdK2wvRnoc0HAFu6yEnLW6RTAC7ursnpi7pjP8F?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e18c753d-a583-4414-c369-08dab31d88db
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 04:34:25.9435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vfw9vuO+c+I5bi2vxvMTTIL/lVXvgbsYATlvhKG33VE5ZBXFhX21GsH3SIIQdSifkKlK/ltYV8VdnaOjC06pkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4879
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-21 at 12:30:56 +0800, Abel Wu wrote:
> Hi Chen, thanks for your reviewing!
> 
> On 10/21/22 12:03 PM, Chen Yu wrote:
> > On 2022-10-19 at 20:28:58 +0800, Abel Wu wrote:
> > [cut]
> > > A major concern is the accuracy of the idle cpumask. A cpu present
> > > in the mask might not be idle any more, which is called the false
> > > positive cpu. Such cpus will negate lots of benefit this feature
> > > brings. The strategy against the false positives will be introduced
> > > in next patch.
> > > 
> > I was thinking that, if patch[3/4] needs [4/4] to fix the false positives,
> > maybe SIS_CORE could be disabled by default in 3/4 but enabled
> > in 4/4? So this might facilicate git bisect in case of any regression
> > check?
> 
> Agreed. Will fix in next version.
> 
> > [cut]
> > > + * To honor the rule of CORE granule update, set this cpu to the LLC idle
> > > + * cpumask only if there is no cpu of this core showed up in the cpumask.
> > > + */
> > > +static void update_idle_cpu(int cpu)
> > > +{
> > > +	struct sched_domain_shared *sds;
> > > +
> > > +	if (!sched_feat(SIS_CORE))
> > > +		return;
> > > +
> > > +	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> > > +	if (sds) {
> > > +		struct cpumask *icpus = to_cpumask(sds->icpus);
> > > +
> > > +		/*
> > > +		 * This is racy against clearing in select_idle_cpu(),
> > > +		 * and can lead to idle cpus miss the chance to be set to
> > > +		 * the idle cpumask, thus the idle cpus are temporarily
> > > +		 * out of reach in SIS domain scan. But it should be rare
> > > +		 * and we still have ILB to kick them working.
> > > +		 */
> > > +		if (!cpumask_intersects(cpu_smt_mask(cpu), icpus))
> > > +			cpumask_set_cpu(cpu, icpus);
> > Maybe I miss something, here we only set one CPU in the icpus, but
> > when we reach update_idle_cpu(), all SMT siblings of 'cpu' are idle,
> > is this intended for 'CORE granule update'?
> 
> The __update_idle_core() is called by all the cpus that need to go idle
> to update has_idle_core if necessary, and update_idle_cpu() is called
> before that check.
>
I see.

Since __update_idle_core() has checked all SMT siblings of 'cpu' if
they are idle, can that information also be updated to icpus?

thanks,
Chenyu 
> Thanks,
> Abel
> 
