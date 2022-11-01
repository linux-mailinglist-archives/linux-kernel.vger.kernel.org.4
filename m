Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE810614C16
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiKANvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiKANvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:51:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4005FE7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667310706; x=1698846706;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0l8++MuX0YZgd4P3Cj6RWrnjjGjOq+l4hAW/cuKqBZU=;
  b=fbIz9wUZo0HZNAWbAd4toUE4z/9DT/zF+WizN+KxCdZ8YJRra5tG4amt
   HkFuW4/yOToRYmCbcqkGloqHTOeRU9gkUesjyAU9D03BL9jWFln/nI48y
   XY3lm73ETIPzkvmkxGV9VZkyg1XFgNMhpJrYDqwc+oNnn20TAwLIRSvE9
   UNDqy3sHvDfPlkG2yDISwuWRAkHZA6jE+6PebYiS4Vnoyve2pJTTLWdAR
   i98l5BIr+YLsUzZirlwVUR1MCAbZyWiSWwpmWlcLIwRlC1GiBBfHnwATX
   pYK1lYYUb+L+2l9QN8Ubwe/jNga3CPUURGB/46GsA/PNiHnSXdIeRVoHR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="373351389"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="373351389"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 06:51:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="628574366"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="628574366"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 01 Nov 2022 06:51:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 06:51:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 06:51:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 06:51:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 06:51:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLL+1Uujtcx3jGBCUPUZflTrBK4GG/mxZ2xwh2n4kSPTSTF/I8jvoKb2LyK7X5n05E8xLI90P6hlsMttkonQxqCfu/4I7K0zjgaaPOjGAl7+ERunNRxtobH18g2OT+pGD95JkDc8+00MN66HkQ0xM2Q59XrlWGyCPcmuPkZ5aiMtyrrC1UCBowVj8RmcZRHv+02B8MFfFw+MWF3irU2y4LG6tpG6CybWPWLndcgkS/h/Q0MHrc5k5A36kNB3lLXM7eiaoRW+qphhWTbAwo7PS0BvOpoT+6Nq+W2/jYt3fJ4eQ2QIbJsxE5m7Ms8rYyDpdg8pTAZ3aabDhkxVbo6GAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dg7whafLGsAPEgaLF8IufNx0kT0boglSEey79fpyOls=;
 b=jHAXw+OjlGS+6Qacc5wfQ+vtmXNBzoz0U7fN/8PoXXTXv2jItGKvr/Ti4+xAEkiTkSfemsaXZoOoUjhA0w7rlpKZivNjRdLhRN5mDzFZZ8frpaozRpSWNPnlxiQwxDFKynjzIdDr0svsQfxXoQK1wKCOZxXB+oNpMDIOYwn64WlriRaqaOkqWaW7sscBp7YiZgd3SWRuM3oLAbCYoFyaV8encsEPUtli4hRe48Xax8xdBrxuNvDO7Ro8ey7CkGxsDFD39D29u3FKNtRbk7sYJH3WZi5ZC+yJ8egk9KQEHCKOPHYiy3o88wRofCZGvyYj1TzF54NdjM+lTMKaPs26DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SA1PR11MB7039.namprd11.prod.outlook.com (2603:10b6:806:2b5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 1 Nov
 2022 13:51:42 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::b6d7:8853:f8a4:ae30]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::b6d7:8853:f8a4:ae30%7]) with mapi id 15.20.5769.018; Tue, 1 Nov 2022
 13:51:42 +0000
Date:   Tue, 1 Nov 2022 21:51:25 +0800
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
Message-ID: <Y2EkXYqZ15/Kjl6H@chenyu5-mobl1>
References: <20221101073630.2797-1-dtcccc@linux.alibaba.com>
 <Y2D2HIZuGP81w25+@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y2D2HIZuGP81w25+@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SA1PR11MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: 1323a473-0f87-4b6e-52db-08dabc103528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tLiLj8MgispuPIAM+TC4Zns9NHeZ/SYvT+zv46l4mhY9u55+719gt2tZB/LcicKkY2RFMDkcdRA1BXCsDdiMc9KX/Cx3Ib+Laee0n2NWxkqciMaS1B6UVj3jkheDtczTY3nR+4SHeNv/Bkg5Pc7WjMmk8op3ahUmXd1DaG0A+Qb/rGoPJB2QhnCpho4+Y8St8M77kt640mSs1yxZlQkj25s64Cho98jPDe7ukNOJ7HNhfdD2rpbEwd3TNUXqSGFgYZHKwD/peHqUNtN8V8iVvTA7Nr+gtUqfw6NJmtKo2creqW20tDfSsyhxqO5f8/tXeuWa43Qb37V999HfeMJWpIyXZsAQNmCWZxPxPI5KeakORRaaVyFByE+mbPIK5ghOGXdP6qJ9X9I6QHvvLuDKDVf28so0ZoiMglleamOgsR1KYdcbxvcbTe+MwBWA4HfyDr/YfHvmhdAcpZxS0km7k3PT/tIFcRn79gVA7dtKbeemxYyD2JwNU6JSyoc+laNst7+LIwh/hyoFxBIhLrwPyNk9brk/GmRDsY0sGgfOwX9X2oj+j5sVUEDwEaiIrszwZFjtA5ryHc6/fZoY6e5t7Z2BKoBA1LXiR127IXAtEvoXTtMowcLFPPi0CWS2cz7jxyiej1dYD0aAnitsPr6fXjdcju5znRgw7c3yFiMxlTMN/ywvwnskGS7PfTQU1XlH5R1+qHSYrYVsEi8TMrGBAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199015)(83380400001)(86362001)(38100700002)(82960400001)(2906002)(7416002)(6506007)(186003)(6666004)(26005)(6512007)(9686003)(53546011)(8936002)(316002)(66946007)(6486002)(4326008)(66556008)(6916009)(5660300002)(66476007)(33716001)(54906003)(8676002)(478600001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T5ygWFFtZEMLN4ulilpCwqID6d/O4ni0c8BySXccjSzLbO33n+9R8dciDRJN?=
 =?us-ascii?Q?UstDl/NPGC8dVE2Drsf7+7IXSPtRa6AvW8wwji31sjZXZJ2hX9p115p2xUVW?=
 =?us-ascii?Q?8SJ1LBvrqjBLiHsoqf7DmyPU8psOXWbo8cDmYr7Lt3m9O7KKmTj08b748xtn?=
 =?us-ascii?Q?xksXm9B5/h3SsIP3Ak6nySiYna8HQbs3jF79lN5dY4/SvdDJHu103jBlDdDa?=
 =?us-ascii?Q?MX+Vu+TSZs1ytC3xi5SRkWdn2raauNiaMENHTDCKrCtMRpdnBpSYWSv5r3/0?=
 =?us-ascii?Q?jrT/ugulzT87b6FUI2m05zoGPQMLeuvYjdqsJqOzFN1SaI7EeAW9WZOPlGEh?=
 =?us-ascii?Q?7MXbeZX4AvqG2qW2kyHQ+Z8LOZU6dwB7F1Qt62S7+bDpbm2fXvwhgt+bv5Cv?=
 =?us-ascii?Q?d9cNdhWk/IErJuTeLk29FoANmcizqeBeSiiWIK8zqyOkK/+adQ2WxfVcyHPB?=
 =?us-ascii?Q?GyNdwbyg8aZ0PO17Jz5wVIh4g8TDdAAw29D9ggaf/Zy+PbQBLSJSgoDi5u6n?=
 =?us-ascii?Q?pzbTGplfEE3z4Xz+JSWo1EId3txGcCtH7G+hjFPx1C5sp0VfhAIxkpTnv09i?=
 =?us-ascii?Q?9B93nySIsS3TBnH4iOxvz/+wRH2fzTCVeG/GnmwHJF9UPfFIj1hTU5k6Uq0U?=
 =?us-ascii?Q?CINlk452g8Ko3IFvB2diAKCLUXf4QsCOcP42Z5Qi8Diqag8pc5yEhXa/0U3t?=
 =?us-ascii?Q?gas5TI+jWW07d+4sAyxZoD5QMHpxortY+3/S9ode2Yu6VzdoHBR2bih8AdCi?=
 =?us-ascii?Q?bQtNflhbs4SRyC5R+hgIDepJkWhT6GpllZuwZ2Jtu/8ZL3yxkDn3phwll0MW?=
 =?us-ascii?Q?1dNX4Lm0Qdl8TFp8yOW3WrKHtkIg8BRQIW/Kum6mtZlRNJ93by657Z9P5uqB?=
 =?us-ascii?Q?c4paW7kfWtpwefd39w0d3Uh8hVokaRGDw29tEIigu4Znr8ODbPs2tWz9TRA2?=
 =?us-ascii?Q?6LOadn7jZEn7xlCzXBPKO3hlzX14fcGpWu5Mc9j/3m3EbaWCzx5byrteKOTV?=
 =?us-ascii?Q?H9soRv0h2C2FzYehnXnXLev10W3OdPuYCau8RCL1vfW/J90aSE3q5j16uVVd?=
 =?us-ascii?Q?h0/bYBcXYZbA3QCafdvucDc0vKtwNpC9R70+eEwswhFehh9XnqwsQ0RHbfCi?=
 =?us-ascii?Q?oI2H7YFTMBrb1EjWCXivjJQVMwH+c2KHsRUMUW9XAxxgKsA1jA2R0DTUbDec?=
 =?us-ascii?Q?jYzeKnKNlAzJRSITkQF2LeWi+QNoPdFI4iOHj8F+iF7EzJIAKQvVpQRpVEIA?=
 =?us-ascii?Q?FCxHWDMl+woHu1XQzo6SVyRCtsbDlftxy8yL/YDLWKMQBESAXc0j6xvaI2DO?=
 =?us-ascii?Q?rUG2e0qGZQlCyu1k+/+RsMmavoTxTACEHtN27d2+2obohV32RF1IdFBJC7fk?=
 =?us-ascii?Q?sQ5GJeYlMlE/SWYG75t8IQCLVmQd06JBIeDMhCyfT5WHz3FDCHoOKbVFDDs0?=
 =?us-ascii?Q?lBSAlNRaU3IlEqcWgaqLO2jEJXdrq08i4yLOgNz4mzbeddW61Rnmt05s4Kvr?=
 =?us-ascii?Q?ze+XDJNmF15HSNrSRjeq+0jzuqfAkv3NE+s4IlDeCdFOCwkkj4oZwOm+jYHE?=
 =?us-ascii?Q?PS/FKoJ8A9vLK5Ec+jjZjtzr8ijv3hdRq3pvWgZ3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1323a473-0f87-4b6e-52db-08dabc103528
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 13:51:42.5867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 137zTMHpCSqprknwtPofVNWJRzlHGccR37xByj/JMiWvqQn7miTwhePgi/CBR5wwtHU/yZd5M9jMZuuFIm7Iqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7039
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-01 at 11:34:04 +0100, Peter Zijlstra wrote:
> On Tue, Nov 01, 2022 at 03:36:30PM +0800, Tianchen Ding wrote:
> > We found a long tail latency in schbench whem m*t is close to nr_cpus.
> > (e.g., "schbench -m 2 -t 16" on a machine with 32 cpus.)
> > 
> > This is because when the wakee cpu is idle, rq->ttwu_pending is cleared
> > too early, and idle_cpu() will return true until the wakee task enqueued.
> > This will mislead the waker when selecting idle cpu, and wake multiple
> > worker threads on the same wakee cpu. This situation is enlarged by
> > commit f3dd3f674555 ("sched: Remove the limitation of WF_ON_CPU on
> > wakelist if wakee cpu is idle") because it tends to use wakelist.
> > 
> > Here is the result of "schbench -m 2 -t 16" on a VM with 32vcpu
> > (Intel(R) Xeon(R) Platinum 8369B).
> > 
> > Latency percentiles (usec):
> >                 base      base+revert_f3dd3f674555   base+this_patch
> > 50.0000th:         9                            13                 9
> > 75.0000th:        12                            19                12
> > 90.0000th:        15                            22                15
> > 95.0000th:        18                            24                17
> > *99.0000th:       27                            31                24
> > 99.5000th:      3364                            33                27
> > 99.9000th:     12560                            36                30
> 
> Nice; but have you also ran other benchmarks and confirmed it doesn't
> negatively affect those?
> 
> If so; mentioning that is very helpful. If not; best go do so :-)
> 
> > Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> > ---
> >  kernel/sched/core.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 87c9cdf37a26..b07de1753be5 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3739,13 +3739,6 @@ void sched_ttwu_pending(void *arg)
> >  	if (!llist)
> >  		return;
> >  
> > -	/*
> > -	 * rq::ttwu_pending racy indication of out-standing wakeups.
> > -	 * Races such that false-negatives are possible, since they
> > -	 * are shorter lived that false-positives would be.
> > -	 */
> > -	WRITE_ONCE(rq->ttwu_pending, 0);
> > -
> >  	rq_lock_irqsave(rq, &rf);
> >  	update_rq_clock(rq);
> >  
> 
> Could you try the below instead? Also note the comment; since you did
> the work to figure out why -- best record that for posterity.
> 
> @@ -3737,6 +3730,13 @@ void sched_ttwu_pending(void *arg)
>  			set_task_cpu(p, cpu_of(rq));
>  
>  		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
> +		/*
> +		 * Must be after enqueueing at least once task such that
> +		 * idle_cpu() does not observe a false-negative -- if it does,
> +		 * it is possible for select_idle_siblings() to stack a number
> +		 * of tasks on this CPU during that window.
> +		 */
> +		WRITE_ONCE(rq->ttwu_pending, 0);
Just curious why do we put above code inside llist_for_each_entry_safe loop?
My understanding is that once 1 task is queued, select_idle_cpu() would not
treat this rq as idle anymore because nr_running is not 0. But would this bring
overhead to write the rq->ttwu_pending multiple times, do I miss something?

thanks,
Chenyu
>  	}
>  
>  	rq_unlock_irqrestore(rq, &rf);
