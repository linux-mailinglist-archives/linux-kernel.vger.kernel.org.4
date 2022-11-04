Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A199618E32
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiKDCUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiKDCUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:20:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6917F2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 19:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667528409; x=1699064409;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2kHSjR6a5D1PN6xf4m0e9aF3T+xUjoVFWtb5VG9WFQ0=;
  b=TqYHTDEZf5XB+0+casuuvQB1BiwpnoqSNY5uxqWPfAZvbQupgyRWl4pp
   zRSGzOo9eR9OtR55ymyyalHCA8NC0ikJfIEzkKA1O63L8+vanlRkjDryJ
   cL18pO1sYpv6upNlKxKdceKsuK/7JcFxBS3utUZYAo/zWnLlHTpYUhOmg
   ADwjC7qV5huUcb57725ZGVfzalbbQqx0KXu++LPnPivThplZ+x9cbcSbG
   hkMLKEBp81gDYydh0efcKcPN5o+b8HSm4rrDCPRhpJAtg6TvtIt+YkyBl
   TC2fnAokWnU2p8G0qbQNV1Jjp6QGYf5d3wS2tadVXEz10vDEs56/6b7T3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="297322149"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="297322149"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 19:20:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809900602"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="809900602"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 03 Nov 2022 19:20:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 19:20:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 19:20:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 19:20:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 19:20:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xl0ZTIIUODOF/DNHJp8N52Sdux5ZHDPjvShDsnPMa4OX3kThKo8FZQij4hx/U/W/yDbUiopO0YXAvBniosuI3JmpPsF/EutsWfCE+ERwUqjWluP0GpfEx5ApPNynBFHm+YKuqKbo70KNNL+fT/rtCOHZBi+0zq8dQj1ms2lwzH0RpUGKir1HNLhtVPpvPtZGq75QbgQjWBlIDAIGFIfd0UZZusbxhIVV0gk/+xRUb8tXG0gY99VKuM9kwoHZRGEM8V071T6YOV//yvm/aJPe1tkPCmSR+P5KL2mbjFeaQ5bc2w88J/qlG6HoA/N/dqs84+f9w743nBmGrHo/ugWzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xx2rMBsRvnfWpaXrvL62bpxXtSbaaZXlxYvLuhajqCc=;
 b=ReDHFzWxgojAZUY3M0bWeFiw0TXUPd2nZSGXd7621gG4h41fcodq1rRspuaz0P1fExYuNbsW0vwLTJZVfeFfAm3wocZU3/7MgUB/Meozb+CDd2mnFuNvjNWyc60wYgLrfYXYjyjLaxief10D6C0UNKENMawpJmmGDS6nOguGnzqV/kaODZNn3FbnVmfnuGBm2ZFlPUE3sGIS2mBILb3OzycaK8zPFJNlbUSVC5B6XawtrV3IKiTCPKW0exgtZKMaUiqLVuIgRu+Y/Sj9fjstC1O5KrCcMwzQJyK8ELdyGlrRGXFv1tDfsHBOWrE1hM2doNidBWZkBrWW1kj7TAdiJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SA1PR11MB5946.namprd11.prod.outlook.com (2603:10b6:806:23a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 02:20:05 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::c00f:264f:c005:3a5b]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::c00f:264f:c005:3a5b%3]) with mapi id 15.20.5769.021; Fri, 4 Nov 2022
 02:20:05 +0000
Date:   Fri, 4 Nov 2022 10:16:53 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <john.stultz@linaro.org>, <sboyd@kernel.org>, <corbet@lwn.net>,
        <Mark.Rutland@arm.com>, <maz@kernel.org>, <kernel-team@meta.com>,
        <neeraju@codeaurora.org>, <ak@linux.intel.com>,
        <zhengjun.xing@intel.com>, Waiman Long <longman@redhat.com>,
        John Stultz <jstultz@google.com>
Subject: Re: [PATCH clocksource 2/2] clocksource: Exponential backoff for
 load-induced bogus watchdog reads
Message-ID: <Y2R2Fbuef2APXhU3@feng-clx>
References: <20221102184001.GA1306489@paulmck-ThinkPad-P17-Gen-1>
 <20221102184009.1306751-2-paulmck@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221102184009.1306751-2-paulmck@kernel.org>
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SA1PR11MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 7130fde5-8746-42cd-10f4-08dabe0b162c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/ZNKBkFOBIpUcd0mSbXM9j7kNYdkEFtY+ZFeSc5g9yjqnZa1R9ulF2pKvHKnvJGNHZAl7jwrpc8NkwhaMiaRJFxJ4KHTvGC4HYLtiICGXAFmCF1h5rgc5SZdFBFlGDrM33xoDAGIP4YBsOt4pCYGxOQyfUx4ZZYFzjl21t0q8PzMInL0+ujqqL6xeeiM5S6PnO14w0xfjHQpPcT4vrizTciY94PIZLtasWCTf47ZxosJGAyw86pHgDwH/kaMDZ52jB/u3WCZAZx6Sa8qeMNQpy3Fq5msH/gHXm+u8dyTlxu4OqXhDyU3WqM2tKpzczFtMdutO7Uyd5Rbj1AmLaeZF92F8+we2cM+AOP2liCwSumCwxTz+UL5xPqp01VE23/LVQyJ5kLNpuC62OUD4wTO/bWeKlnPcHeiHpGgngnxZ2Y/fbealbKZaGEe77gRVQlJlIoI3JuwmV7JyzzrcC/eUrF3Lw8FQWCOsWTGUwj0zlSLVFq9eoaJwPieLee+ZnJ57cKQJShpezq69kMhBJDrcFoJVpuhwVgoilkRQPvttN6m6hSIwn5lv889PGcFaAEJ7Sn8PVdkJrM7iSzwXaKRPzpmf65ZphJFSuOZmjmizs8cf41jCe0SchH27coFC67d/Jfrr8ofApbnOfI21PMxtmvllN+UierXlNNM+1LKSKJMWaUTqp44DiH+oY0LoDkrEb+IdlMuwd230wlCsETAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199015)(38100700002)(82960400001)(44832011)(7416002)(2906002)(86362001)(83380400001)(186003)(26005)(9686003)(6666004)(6916009)(8676002)(6486002)(6512007)(316002)(54906003)(41300700001)(8936002)(4326008)(66556008)(66476007)(6506007)(5660300002)(33716001)(66946007)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4dAuxGC9bdboUYaOkGrMUMYCi2eEMWExtIIxrB0DeRapdUoIAKjxarwI4WW0?=
 =?us-ascii?Q?fTSFJS56o/sGJTTISKKqn9z8zJICBtu/kdXtIDdgxJ2UtSZv0Ku4s39lDKtR?=
 =?us-ascii?Q?fS9XKdSAIOtPf0wyPRMeiO8Wifbkdw2EnsJXx2WZqfV5IzmmXdvdpnmNhRI+?=
 =?us-ascii?Q?/Nu/C4Ukv6mvA4cEENG8hhwGTBWGjpQ11F3mAE/+ftP/DcSlegRkZx/jktsG?=
 =?us-ascii?Q?qg55G877dPMQAdsxKBbWGePJjZZ7UghupTeiLV52nfXKhCpRXkDp9lOiGU0I?=
 =?us-ascii?Q?00Mn+eq9v8qJGI6M6gSCLdF8OWu9YUn/ZIO8/HyOh5A5JXY4mQ4oGe5YaIFq?=
 =?us-ascii?Q?NQT1kYtiJsc7DL1rnrS/LbDarVaovv82H9j4VmGgok1n3xZ3eCoFy5yJtgHh?=
 =?us-ascii?Q?t387xYjh6yDKokDjMhYlmLNwESFDOcHAlgtwbrdzqmn3WEDIx9VqZT+ltktn?=
 =?us-ascii?Q?8XaB9vbbrYoPzJphczE2K+c32nyaBw0DN+qlBeoGoCYMzYYlTlXW2ZhjTERv?=
 =?us-ascii?Q?0Zwwo6qJFjcMnMr66ZIaIPv6XLoSJQm8SkvBZVO29l8tyeUpCHk0tFLzGuk7?=
 =?us-ascii?Q?QXILkjCjK5o12rDiXnb+ck6op2aG/H70XGFcWEemXUzjczkxTM9Og+LyDSX0?=
 =?us-ascii?Q?xoLb3Urvwmc7vatAWGhufU4rqq88vnjzz735P91lWMlf3lafHIoM5Ozaq1/m?=
 =?us-ascii?Q?Vww+Kg5v5OjFDl+nol+fvdmoEBy1UNvE+BYvtv4Th4AXyWrORqwwfBcxb1gD?=
 =?us-ascii?Q?AUZ9pU+WQekXP0LrdM4ilLbugOeCQ3gnGtaCPm8f7IR/hAhMbhJQmjFZee5U?=
 =?us-ascii?Q?cqvBjEgCxs4DOxGS1D/VFVO1t8NQdcw3CvrfR2a8lpfulawnwl+vq1+MVFwE?=
 =?us-ascii?Q?ftzwRECA0Teyc0NgE6pPGV0nWtI030n16GKoJ4CHSBf2uiU5QMZAnTtVzEo+?=
 =?us-ascii?Q?oldfmKkby2CBBWIA2Z4gZ8mHbou6C5lXFr41HJHxniagP0sjBkQgOuwefgZ+?=
 =?us-ascii?Q?aoDc1j9JHxUvY3CJFBXUKhzwIOP0TCcc/tijU1jOekuvnvhGqzWkklh8+5pY?=
 =?us-ascii?Q?ob7iooT9GLRsvAXPVUO8ZCD8SKIC+Y25Lp/KbuwBSoSWEppBhT2OJ6GEf5w7?=
 =?us-ascii?Q?xdMRNyQFe7lBO+6pVflhBXxFAe94rFBhlta2ZP0fUjHWXo5iUqfDYMbF0gc8?=
 =?us-ascii?Q?q9jhPdYGq1DW6eN/w7ZWwKmvXZ84/abEcqD8wR//DoFOlAjMPtG+sTam/4ck?=
 =?us-ascii?Q?LBrniKQSE7gXRAnp9lXc+8qe/1BDCaceMj9tTdizrvEdLdSr1QA0LhkjF/Iz?=
 =?us-ascii?Q?wknwHhKsmqxfA+RjS5kzX9lY3LReAZynQcCDmUTP1q7VlaeH1YweRdEwc9D5?=
 =?us-ascii?Q?rUwJgJ4uADsUPhVnF1WI4480HSTQLX3YSru+80C8P15WrRABQWYJ8WVeM5hY?=
 =?us-ascii?Q?Hr4vrDuQWidnRNHvCBlDn202zz/ifn8NKTpWMgIZbIlWhRqIu2NmhqC3gFwo?=
 =?us-ascii?Q?Q5yD2Z9wfGEZaf1Ard0whqMLSG+xBKDKYmd57bez/pLDIc2rRGdP99kTvosv?=
 =?us-ascii?Q?PiaUxShLX4DyZEagDNULIMbtuTSopYkB8RnNkwQl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7130fde5-8746-42cd-10f4-08dabe0b162c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 02:20:05.3344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBWjPL6iDqG/qH3w8aT/4tOyzsZcf6oHfYfDCV6c2KEgTSmQpe/DS6XkijJkvkDk82WtWlF+J8g5k0HRGC7QGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5946
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 11:40:09AM -0700, Paul E. McKenney wrote:
> The clocksource watchdog will reject measurements that are excessively
> delayed, that is, by more than 1.5 seconds beyond the intended 0.5-second
> watchdog interval.  On an extremely busy system, this can result in a
> console message being printed every two seconds.  This is excessively
> noisy for a non-error condition.
> 
> Therefore, apply exponential backoff to these messages.  This exponential
> backoff is capped at 1024 times the watchdog interval, which comes to
> not quite one message per ten minutes.
> 
> Please note that the bogus watchdog reads that occur when the watchdog
> interval is less than 0.125 seconds are still printed unconditionally
> because these likely correspond to a serious error condition in the
> timer code or hardware.

I saw there is ongoing discussion about some wording, overall it
looks good to me, thanks!

Reviewed-by: Feng Tang <feng.tang@intel.com>

> [ paulmck: Apply Feng Tang feedback. ]
> 
> Reported-by: Waiman Long <longman@redhat.com>
> Reported-by: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Waiman Long <longman@redhat.com>
> ---
>  include/linux/clocksource.h |  4 ++++
>  kernel/time/clocksource.c   | 31 +++++++++++++++++++++++++------
>  2 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index 1d42d4b173271..daac05aedf56a 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -125,6 +125,10 @@ struct clocksource {
>  	struct list_head	wd_list;
>  	u64			cs_last;
>  	u64			wd_last;
> +	u64			wd_last_bogus;
> +	int			wd_bogus_shift;
> +	unsigned long		wd_bogus_count;
> +	unsigned long		wd_bogus_count_last;
>  #endif
>  	struct module		*owner;
>  };
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 3f5317faf891f..de8047b6720f5 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -442,14 +442,33 @@ static void clocksource_watchdog(struct timer_list *unused)
>  
>  		/* Check for bogus measurements. */
>  		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
> -		if (wd_nsec < (wdi >> 2)) {
> -			/* This usually indicates broken timer code or hardware. */
> -			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> +		if (wd_nsec > (wdi << 2) || cs_nsec > (wdi << 2)) {
> +			bool needwarn = false;
> +			u64 wd_lb;
> +
> +			cs->wd_bogus_count++;
> +			if (!cs->wd_bogus_shift) {
> +				needwarn = true;
> +			} else {
> +				delta = clocksource_delta(wdnow, cs->wd_last_bogus, watchdog->mask);
> +				wd_lb = clocksource_cyc2ns(delta, watchdog->mult, watchdog->shift);
> +				if ((1 << cs->wd_bogus_shift) * wdi <= wd_lb)
> +					needwarn = true;
> +			}
> +			if (needwarn) {
> +				/* This can happen on busy systems, which can delay the watchdog. */
> +				pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval (%lu additional), probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL, cs->wd_bogus_count - cs->wd_bogus_count_last);
> +				cs->wd_last_bogus = wdnow;
> +				if (cs->wd_bogus_shift < 10)
> +					cs->wd_bogus_shift++;
> +				cs->wd_bogus_count_last = cs->wd_bogus_count;
> +			}
>  			continue;
>  		}
> -		if (wd_nsec > (wdi << 2)) {
> -			/* This can happen on busy systems, which can delay the watchdog. */
> -			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> +		/* Check too-short measurements second to handle wrap. */
> +		if (wd_nsec < (wdi >> 2) || cs_nsec < (wdi >> 2)) {
> +			/* This usually indicates broken timer code or hardware. */
> +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
>  			continue;
>  		}
>  
> -- 
> 2.31.1.189.g2e36527f23
> 
