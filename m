Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351566F698A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjEDLIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjEDLIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:08:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEE0358A
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 04:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683198484; x=1714734484;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=n217QK/NWKeX2y/z1wv/tGFrRKlRztYDaP86rERwb6Y=;
  b=KNCWjAs4kkTaf2uwc0q+rDHLTImpaJb2fdNUHRyTpiFTetBRG4zhH7wv
   Gfmxcz8azD8VaxSD3hucXNcT6BULhVRNUOXf2BCN3v0bE5rLYn2I25n4P
   1cs8VrZlNGzMTuA9WP6rRXgFtPlr5GfTaahh81cCUhlWyOuiGBon8lfu4
   ZZEGzfVQVwPfSCGW4cQPYsEA7qXB258MB8Je3AGh3kOpepNIca33i3zTy
   8cv0HOGtlO2ZBo7yMLtRdYmacE1MGj6w1io8bhmOct2QGJDKDAKrgZKyO
   FC+tU5VLdlgEcRP/geCqm0wnKqQ9LKhNOvUzG6pWxY6viuIMiDn28MXEt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="348948133"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="348948133"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 04:08:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="729751987"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="729751987"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 04 May 2023 04:08:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 04:08:03 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 04:08:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 4 May 2023 04:08:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 4 May 2023 04:08:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1Sf8tRhmiY5WZYU/KArcUe3WW5HP7qcXSsLysv0WHA6nEG/q5XiCO4D3QIOax99yDpQRYUfiOGTQ8BwkdQ0gGE1CGQfv/jUBzI5T+qsuwcuT3l1O4lJhzLFa4/OPxQbO5I0e0mwpXnRb2uT8DUuhVPGyLtVyrL1rA8+Ozi/oeVzcJ1rO7d85VZyO0XTJGBGoFDMVa5F8U2qojz6LJp7WNGL8k6QIhrsoruCVJgQMf7iM91AVWBlqlIHJ6BKVNTZpXSP6cI6tGyvvVKeeV8RUwMIph3IDYb2z3ruJGATY6zU1FqkxuhMERoyosYCzGjbLT7LxkpJlvyKs8d6hW06dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uKbnkQMuA7SfCE1Dr7lB2pylEsqnjQJW4dk37spwCI=;
 b=iuQdk0CE0CEMK+GLJdk1PNMaOD1JOrLIXcR8Kenx4jC3PhVYFYYyWl7W+DhZnk2MWDT6VtOhkuPFKvbgftrJw3oCT1CJaMzJHFwUO7hd3RXzHusM45RVCM6eyCArb38DloAFakFpO/daAcj0A3p2ah6vhbbS4Q4IpFL93uroUC+hYKxA0j01e9VnnlHAerE8tRbxR5QSzHChh6MDLsY3fQYfZ9C4awBYOPPTstdrbMwsyKfHJ+pliFAUjJ896Toyjz2Uza3/fq6RN3H+NqF1lzqJGmsfIR3EUPiX6+TUvllNSJOgbiMrw2wkZ5Dtm//hb9SKGLvBmmqQyyeCXZzTJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.22; Thu, 4 May 2023 11:08:00 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d%3]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 11:08:00 +0000
Date:   Thu, 4 May 2023 19:07:38 +0800
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
        "kernel test robot" <yujie.liu@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 2/2] sched/fair: Introduce SIS_CURRENT to wake up
 short task on current CPU
Message-ID: <ZFOR+i53zW6JpP+R@chenyu5-mobl1>
References: <cover.1682661027.git.yu.c.chen@intel.com>
 <4081178486e025c89dbb7cc0e62bbfab95fc794a.1682661027.git.yu.c.chen@intel.com>
 <20230501134827.GB1597538@hirez.programming.kicks-ass.net>
 <ZE/gT7bkmIFkLdkg@chenyu5-mobl1>
 <20230502115408.GC1597538@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230502115408.GC1597538@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:3:18::25) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DS7PR11MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 9998fd2d-02fd-45c5-e486-08db4c8fd220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TqBGXru3173NmOld1fhX4271aJLAYLPDCjPfEwf88hoKKjTsFMQbdWw9gkB8ulNdrVtkH6v1Faq1LM+Z1tbkdJVJlwEgRXR40FHFcdrG1hO1Om5CWWi5LzQWJyeEgqEvUacDjoB1IzpJT6Nxx7unEcijg0UbV0Sv2NLCMzh/mIMarJ69U8QkUTT0Agn1y9v/YwNikYahi8IrIpmWjMMKC6OQv6YMAi05JY+Zozy2W8Ns9tbvx1meyOi2DIwW06RgTuYx/A9LdLrQbe4bNSvR8oAoNnwYthGPojoAWIIF+WvkN71WuMGAYR1YVRrOE4i7erAqLv6lHXDj9JW2ff/R3MNZ8ja6SB+z9oeoa/MWdl06ffuEEZ2G10oBX/JKxRXfLGYlWwrlAZG6f4gGh3uT8A5GscW7SMbfxVQ8GJLVRuN8Q7igvHYL26awqERKXkF4aN+ZdJR+yd7u2XCv65YQpSz8kH4fn84joGCI41gPvJtIbgcgNc66tkqN/BiqwRxWJVsdFkmMC57nqAjwCOBCLMMWqXPpMdDwsqTJ8m7m6F5uoM4vxYu6Nmw9pur4+OBA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(2906002)(38100700002)(41300700001)(5660300002)(7416002)(8936002)(8676002)(33716001)(86362001)(6666004)(6486002)(54906003)(478600001)(83380400001)(53546011)(186003)(6506007)(26005)(6512007)(6916009)(9686003)(66476007)(316002)(66556008)(82960400001)(66946007)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TMXkP7pB+BR04rFs4YjvzrYH6U4ZByQ2/4pdc+g++UySS6eQAtUTPnvdA877?=
 =?us-ascii?Q?YHRPOjnEUqolsjBXSMGzeWLFfUyUrXqZtj+ZLzxa693EnjHE6KQ1DmSXk1uj?=
 =?us-ascii?Q?E77N+DktvVTXzRJ/fLE/ejkzGuULl6buUS6h2aG7KBTMvBGkvueRmcLLBbZm?=
 =?us-ascii?Q?bogXDFsSndnnDUtFJRJ8Q41LqpbZhOTAZpg42qMsP4yAfHgV0yVtpfOuVs8y?=
 =?us-ascii?Q?MTvLWdvWXuOYZnnsS6nGqtJZsj0FBJvjkstAEM0Hsyqixk2hLmwzHmYAX21z?=
 =?us-ascii?Q?vt6sLyutZnyggLTQXadmkj8Ob/z5QbUZ16DCH3CWbCRhTZ22es4tL0VS5dW0?=
 =?us-ascii?Q?XlV0TNx9I2TabPgWIso5RQ4p6bMTq5sDr+UMK1hpUXr8k4xJEvojPVlE90jB?=
 =?us-ascii?Q?LA3sqr9L285O8wVQ4AuSW8HxO3KIyLdC8g7l9cZiPy6xWGFb8L/iK84ntnbM?=
 =?us-ascii?Q?5cHKhPSPxeXc3/wgd1O+215Y/c5s9le8c+PwLjv21tXnamnHO8dIgeIf7fbv?=
 =?us-ascii?Q?Fk0YbadEFQFw0SkuUmL+I4Mw80yPObXxltv8MbolZqdOYij2QGB9BwRlAEsu?=
 =?us-ascii?Q?v3RAfpmyPWd9Tm8u364CJmDYX+Ide4VA8ttZOt/aO0YmqIwXH+98fegBbOx9?=
 =?us-ascii?Q?uBJl8XZQlBIY6qyVopr4YeNavyfjHrM4l1H002kC4e+OJywhqxbBrnSTb4jf?=
 =?us-ascii?Q?hecMyJIxbLiCtCkS706OFL2LtVj8T03L+0kwk1qzVKa7Qn3p2H30VXtEkw9I?=
 =?us-ascii?Q?1VWwSFBk8ULq6C3Ae1Rjbv3y8O45h+t8v4W5senzUpvSphAiD/VJN6gYNWua?=
 =?us-ascii?Q?TpQNKzg+SBUvJ0ojDdA+RQDjDZ41R0Cx3hR0+/SNALLbD3MyxdOV6HQIvuM0?=
 =?us-ascii?Q?wZltucPSt3pg7wpZq2UHcyU/TDQIf6OdjtrcbH/ktVAFj4kBIfupqIzMgsxb?=
 =?us-ascii?Q?E9WEtjK5Q6Z44637Qkv1m62ekgQnNiiVOHT3mEEuI0lmEjS0s26yDSeKswai?=
 =?us-ascii?Q?HcJkLLJfueP9uVMgzKMa3m9mFJqdLk4KBhEih/r9tX4U28Qh6U5UQcPuxtYc?=
 =?us-ascii?Q?7vJANmuoebaQXCaF1N43taD98GHbC3FQ2s73tTk8VXeADVdnt1nxwbhLluTK?=
 =?us-ascii?Q?zGuXmEFcUZ9dbQocyPvU2riGi0BMKuggpI02cFnFd/Sicric8nk309zyAA9v?=
 =?us-ascii?Q?3tdCv1qjaxcrWiFXnMp+JOmbn5DPSOHeW/bCR+UT26wsvoXcqszKR17MQ/vO?=
 =?us-ascii?Q?8ulpMAFKOYr0LBPytPKWuY01u1yh2lLMX7K9sQdQUzlPjhbhO8czBfFkOOvt?=
 =?us-ascii?Q?HXPR/ipVoZd55nNJZe6ZZ/nOlRHLTCuPX6lpaYCcHUcbKqcu50wTSD8FZsAG?=
 =?us-ascii?Q?2xoU2syXa7dxJskuPde8fabWRv6Io/8GyTce20xPd2XbHSJYpbJU/HvCy6oL?=
 =?us-ascii?Q?l067gQstijJLmjjl/h90JzyG7R4TozGAAaAgQqy8ABa9GvACSsSJoxVAmFOe?=
 =?us-ascii?Q?FJxAo7MLVCis9+eGW8XtE1WZXa4FwmJWIgUDmRNUVwjNFZbgGjrsX74J8pGU?=
 =?us-ascii?Q?m8iRZ5Nxm27Tslo9EJBFI3fUwOVW1blnkoiuZB4H?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9998fd2d-02fd-45c5-e486-08db4c8fd220
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 11:07:59.4972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkBctLjVPNMUBazJqApMBnora6rC4fQ1zqUMdKwmT57Vz8F4WcHydk6fV5jpqlpJShPcp2zoU31ZH+Z0kci2Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5990
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-02 at 13:54:08 +0200, Peter Zijlstra wrote:
> On Mon, May 01, 2023 at 11:52:47PM +0800, Chen Yu wrote:
> 
> > > So,... I've been poking around with this a bit today and I'm not seeing
> > > it. On my ancient IVB-EP (2*10*2) with the code as in
> > > queue/sched/core I get:
> > > 
> > > netperf                   NO_SIS_CURRENT          %
> > >                                      SIS_CURRENT
> > > ----------------------- -------------------------------
> > > TCP_SENDFILE-1  : Avg:    42001      40783.4   -2.89898
> > > TCP_SENDFILE-10 : Avg:    37065.1    36604.4   -1.24295
> > > TCP_SENDFILE-20 : Avg:    21004.4    21356.9   1.67822
> > > TCP_SENDFILE-40 : Avg:    7079.93    7231.3    2.13802
> > > TCP_SENDFILE-80 : Avg:    3582.98    3615.85   0.917393
> 
> > > TCP_STREAM-1    : Avg:    37134.5    35095.4   -5.49112
> > > TCP_STREAM-10   : Avg:    31260.7    31588.1   1.04732
> > > TCP_STREAM-20   : Avg:    17996.6    17937.4   -0.328951
> > > TCP_STREAM-40   : Avg:    7710.4     7790.62   1.04041
> > > TCP_STREAM-80   : Avg:    2601.51    2903.89   11.6232
> 
> > > TCP_RR-1        : Avg:    81167.8    83541.3   2.92419
> > > TCP_RR-10       : Avg:    71123.2    69447.9   -2.35549
> > > TCP_RR-20       : Avg:    50905.4    52157.2   2.45907
> > > TCP_RR-40       : Avg:    46289.2    46350.7   0.13286
> > > TCP_RR-80       : Avg:    22024.4    22229.2   0.929878
> 
> > > UDP_RR-1        : Avg:    95997.2    96553.3   0.579288
> > > UDP_RR-10       : Avg:    83878.5    78998.6   -5.81782
> > > UDP_RR-20       : Avg:    61838.8    62926     1.75812
> > > UDP_RR-40       : Avg:    56456.1    57115.2   1.16746
> > > UDP_RR-80       : Avg:    27635.2    27784.8   0.541339
> 
> > > UDP_STREAM-1    : Avg:    52808.2    51908.6   -1.70352
> > > UDP_STREAM-10   : Avg:    43115      43561.2   1.03491
> > > UDP_STREAM-20   : Avg:    18798.7    20066     6.74142
> > > UDP_STREAM-40   : Avg:    13070.5    13110.2   0.303737
> > > UDP_STREAM-80   : Avg:    6248.86    6413.09   2.62816
> 
> 
> > > tbench
> 
> > > WA_WEIGHT, WA_BIAS, NO_SIS_CURRENT (aka, mainline)
> > > 
> > > Throughput  649.46 MB/sec   2 clients   2 procs  max_latency=0.092 ms
> > > Throughput 1370.93 MB/sec   5 clients   5 procs  max_latency=0.140 ms
> > > Throughput 1904.14 MB/sec  10 clients  10 procs  max_latency=0.470 ms
> > > Throughput 2406.15 MB/sec  20 clients  20 procs  max_latency=0.276 ms
> > > Throughput 2419.40 MB/sec  40 clients  40 procs  max_latency=0.414 ms
> > > Throughput 2426.00 MB/sec  80 clients  80 procs  max_latency=1.366 ms
> > > 
> > > WA_WEIGHT, WA_BIAS, SIS_CURRENT (aka, with patches on)
> > > 
> > > Throughput  646.55 MB/sec   2 clients   2 procs  max_latency=0.104 ms
> > > Throughput 1361.06 MB/sec   5 clients   5 procs  max_latency=0.100 ms
> > > Throughput 1889.82 MB/sec  10 clients  10 procs  max_latency=0.154 ms
> > > Throughput 2406.57 MB/sec  20 clients  20 procs  max_latency=3.667 ms
> > > Throughput 2318.00 MB/sec  40 clients  40 procs  max_latency=0.390 ms
> > > Throughput 2384.85 MB/sec  80 clients  80 procs  max_latency=1.371 ms
> > > 
> > > 
> > > So what's going on here? I don't see anything exciting happening at the
> > > 40 mark. At the same time, I can't seem to reproduce Mike's latency pile
> > > up either :/
> > > 
> > Thank you very much for trying this patch. This patch was found to mainly
> > benefit system with large number of CPUs in 1 LLC. Previously I tested
> > it on Sapphire Rapids(2x56C/224T) and Ice Lake Server(2x32C/128T)[1], it
> > seems to have benefit on them. The benefit seems to come from:
> > 1. reducing the waker stacking among many CPUs within 1 LLC
> 
> I should be seeing that at 10 cores per LLC. And when we look at the
> tbench results (never the most stable -- let me run a few more of those)
> it looks like SIS_CURRENT is actually making that worse.
> 
> That latency spike at 20 seems stable for me -- and 3ms is rather small,
> I've seen it up to 11ms (but typical in the 4-6 range). This does not
> happen with NO_SIS_CURRENT and is a fairly big point against these
> patches.
>
I tried to reproduce the issue on your platform, so I launched tbench with
nr_thread = 50% on a Ivy Bridge-EP, it seems that I could not reproduce the
issue(the difference is that the default testing is with perf record enabled).
 
I launched netperf/tbench under 50%/75%/100%/125% on some platforms with
smaller number of CPUs, including:
Ivy Bridge-EP, nr_node: 2, nr_cpu: 48
Ivy Bridge, nr_node: 1, nr_cpu: 4
Coffee Lake, nr_node: 1, nr_cpu: 12
Commet Lake, nr_node: 1, nr_cpu: 20
Kaby Lake, nr_node: 1, nr_cpu: 8

All platforms are tested with cpu freq govenor set to performance to
get stable result. Each test lasts for 60 seconds.

It seems that per the test result, no obvious netperf/tbench throughput
regress was detected on these platforms(within 3%), and some platforms
such as Commet Lake shows some improvement.

The tbench.max_latency show improvement/degrading and it seems that
this latency value is unstable(with/without patch applied).
I don't know how to interpret this value(should we look at the tail
latency like schbench) and it seems that the latency variance is another
issue to be looked into. 


netperf.Throughput_total_tps(higher the better):

Ivy Bridge-EP, nr_node: 2, nr_cpu: 48:
               NO_SIS_CURRENT             SIS_CURRENT
               ---------------- ---------------------------
50%+TCP_RR:    990828           -1.0%     980992
50%+UDP_RR:    1282489          +1.0%     1295717
75%+TCP_RR:    935827           +8.9%     1019470
75%+UDP_RR:    1164074          +11.6%    1298844
100%+TCP_RR:   1846962          -0.1%     1845311
100%+UDP_RR:   2557455          -2.3%     2497846
125%+TCP_RR:   1771652          -1.4%     1747653
125%+UDP_RR:   2415665          -1.1%     2388459

Ivy Bridge, nr_node: 1, nr_cpu: 4
              NO_SIS_CURRENT            SIS_CURRENT
              ---------------- ---------------------------
50%+TCP_RR:   52697            -1.2%      52088
50%+UDP_RR:   135397           -0.1%     135315
75%+TCP_RR:   135613           -0.6%     134777
75%+UDP_RR:   183439           -0.3%     182853
100%+TCP_RR:  183255           -1.3%     180859
100%+UDP_RR:  245836           -0.6%     244345
125%+TCP_RR:  174957           -2.1%     171258
125%+UDP_RR:  232509           -1.1%     229868


Coffee Lake, nr_node: 1, nr_cpu: 12
             NO_SIS_CURRENT               SIS_CURRENT
         ---------------- ---------------------------
50%+TCP_RR:    429718            -1.2%     424359
50%+UDP_RR:    536240            +0.1%     536646
75%+TCP_RR:    450310            -1.2%     444764
75%+UDP_RR:    538645            -1.0%     532995
100%+TCP_RR:   774423            -0.3%     771764
100%+UDP_RR:   971805            -0.3%     969223
125%+TCP_RR:   720546            +0.6%     724593
125%+UDP_RR:   911169            +0.2%     912576

Commet Lake, nr_node: 1, nr_cpu: 20
                NO_SIS_CURRENT              SIS_CURRENT
                ---------------- ---------------------------
50%+UDP_RR:     1174505            +4.6%      1228945
75%+TCP_RR:      833303            +20.2%     1001582
75%+UDP_RR:     1149171            +13.4%     1303623
100%+TCP_RR:    1928064            -0.5%      1917500
125%+TCP_RR:     74389             -0.1%      74304
125%+UDP_RR:    2564210            -1.1%      2535377


Kaby Lake, nr_node: 1, nr_cpu: 8
                NO_SIS_CURRENT                 SIS_CURRENT
                ---------------- ---------------------------
50%+TCP_RR:        303956             -1.7%       298749
50%+UDP_RR:        382059             -0.8%       379176
75%+TCP_RR:        368399             -1.5%       362742
75%+UDP_RR:        459285             -0.3%       458020
100%+TCP_RR:       544630             -1.1%       538901
100%+UDP_RR:       684498             -0.6%       680450
125%+TCP_RR:       514266             +0.0%       514367
125%+UDP_RR:       645970             +0.2%       647473



tbench.max_latency(lower the better)

Ivy Bridge-EP, nr_node: 2, nr_cpu: 48:
                NO_SIS_CURRENT            SIS_CURRENT
                ---------------- ---------------------------
50%:           45.31            -26.3%       33.41
75%:           269.36           -87.5%       33.72
100%:          274.76           -66.6%       91.85
125%:          723.34           -49.1%       368.29

Ivy Bridge, nr_node: 1, nr_cpu: 4
                NO_SIS_CURRENT              SIS_CURRENT
                ---------------- ---------------------------
50%:          10.04           -70.5%        2.96
75%:          10.12           +63.0%        16.49
100%:         73.97           +148.1%       183.55
125%:         138.31          -39.9%        83.09


Commet Lake, nr_node: 1, nr_cpu: 20
                NO_SIS_CURRENT              SIS_CURRENT
                ---------------- ---------------------------
50%:            10.59            +24.5%      13.18
75%:            11.53            -0.5%      11.47
100%:           414.65           -13.9%     356.93
125%:           411.51           -81.9%      74.56

Coffee Lake, nr_node: 1, nr_cpu: 12
                NO_SIS_CURRENT              SIS_CURRENT
                ---------------- ---------------------------
50%            452.07           -99.5%       2.06
75%            4.42             +81.2%       8.00
100%           76.11           -44.7%        42.12
125%           47.06           +280.6%     179.09


Kaby Lake, nr_node: 1, nr_cpu: 8
                NO_SIS_CURRENT              SIS_CURRENT
                ---------------- ---------------------------
50%:               10.52            +0.1%      10.53
75%:               12.95           +62.1%      20.99
100%:              25.63          +181.1%      72.05
125%:              94.05           -17.0%      78.06

> > 2. reducing the C2C overhead within 1 LLC
> 
> This is due to how L3 became non-inclusive with Skylake? I can't see
> that because I don't have anything that recent :/
>
I checked it with the colleagues and it seems to not be related to non-inclusive L3
but related to the number of CPUs. More CPUs makes distances in the die longer,
which adds to the latency.
> > So far I did not received performance difference from LKP on desktop
> > test boxes. Let me queue the full test on some desktops to confirm
> > if this change has any impact on them.
> 
> Right, so I've updated my netperf results above to have a relative
> difference between NO_SIS_CURRENT and SIS_CURRENT and I see some losses
> at the low end. For servers that gets compensated at the high end, but
> desktops tend to not get there much.
> 
>
Since the large CPU number is one major motivation to wakeup
the task locally, may I have your opinion that is it applicable to add llc_size
as the factor when deciding whether we should wake up the wakee on current CPU?
The smaller the llc_size is, the harder the wake will be woken up on current CPU.


thanks,
Chenyu
