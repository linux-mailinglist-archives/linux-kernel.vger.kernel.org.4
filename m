Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8CB60202A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 03:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJRBIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 21:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiJRBIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:08:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5711BAF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666055286; x=1697591286;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Whwd2QfpwTAEnlfg8Tcho97mX2Q0HQHLUFac55I/m1w=;
  b=TA4vR0yn/dClaXdMvRG2ZF7YcWYCQaRFYfzuUW8+FqXCs5FpMTqNJ+d6
   3Q4FhDNFmVI9FSd23Gyh01J6Boljgq9HFkRGriF3Heij2epLuFkOgwzG6
   hdMYSvw1CE5d4A4lDoXgNTw9uuq4UEm81obVawrdEWvlJy/ELR/C8ZBR3
   lzm76rJpRsnG8oLCz4jlYOyU1rhXlbVbcRWiy/0ug6CM8pkriXKklv+uS
   oiAIrHaEBZOM/lbYGtSiS2eB6dzIYIDBSUDwEGe4o3TKerX33iLAqp58K
   osJbzif93bJatpzi3F5tfbBdNb5r/jIDRUg7l7asRu10BmI9Pwgt4S54o
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="367989619"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="367989619"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 18:08:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="753834802"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="753834802"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 17 Oct 2022 18:08:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 18:08:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 18:08:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 17 Oct 2022 18:08:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 17 Oct 2022 18:08:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VF2J8dURzdOi1gsPq9WL5Ui1ulKpm3m2gE57wNbT1aY58kWIiQaaio5abvMXgK7las778zSGXnQfTzXuqh7KhyNbQJkQikAIkbzUrOztUxfi2tBG5ddtCQUwmpTcfpChhqjRTZJ7YSwDi1/O0sS/56FiLQd4dOaAmsQthZczusn9fZxiPaoUzIR/bcYLUjwN+VjscemdzgTyudCRFd+YopLMxsyMKA4SDHuyZX53YKYOfJQdZs7T/go1ZOKPOE0Uh0+eBRUUZImzB39EwbaWm63zaYjL0xoPAb/EFS0Q8XOWyyY566qmO1tATlZr4VPexcbMtzAQOKroRxX3vFyTdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V47ZOE/MLek0RXRMxpWzYKM3V1UbBJhbgeowCf81vTw=;
 b=HE2lEivvM13vnJ8tbcH6AmtB7/4VWNo7b3I6kgdrYxoL4N4bkmtlzKXmGqMzM2J+EamWPAED5JA64fsw2bvdWgIRSjrMj37vuw/4crSLgsHhH2gIuClv26hKirqGvV2f0vSbJfJwzirpWRjY7B2TX0pU+Hvt3k9wUtcMoo2hz14tpwSf/f8BlIBCeusGjcQSHeuS5IEHzQ7UoHakEYM0K94T4lYw5l54gnBKFTf2IN4ZkpkF+YvcnX4/fYtEeZH8upxQ/gPvkLUrD+O6AvA8EwApqDnKgs6WCu+uBJJRcHkrwsMF13RPeAF2ZHOpc4/2LVXNs7WEo4iHn4udyMYg0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CH0PR11MB5561.namprd11.prod.outlook.com (2603:10b6:610:d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 01:08:02 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5723.030; Tue, 18 Oct 2022
 01:08:02 +0000
Date:   Tue, 18 Oct 2022 09:07:46 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <rui.zhang@intel.com>,
        <tim.c.chen@intel.com>, <liaoyu15@huawei.com>
Subject: Re: [RFC PATCH] x86/tsc: use topology_max_packages() in tsc watchdog
 check
Message-ID: <Y038Ym8e0K7Cz3WR@feng-clx>
References: <20221017132942.1646934-1-feng.tang@intel.com>
 <ff269ad9-2811-e427-3bb9-5b4c978e80bf@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ff269ad9-2811-e427-3bb9-5b4c978e80bf@intel.com>
X-ClientProxiedBy: SG2PR01CA0124.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::28) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CH0PR11MB5561:EE_
X-MS-Office365-Filtering-Correlation-Id: c672aa3e-afbe-4e15-b91f-08dab0a53450
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /G3tEjfFG+6K6d4us72oAhBLapIF/T877bXJIsParvfyLmixouWvTadNy5zG9lYEZdYLfcWq2lSTb1/5z+gK0tc7BzWlp7BqeHD2eyEywQbSZTJIuBteGFIJHNgMvMwCiIlUISvCWBm+z96+akiehTbdzk2xVMLzpLclPrwnEqBk5nx6UbWRm5Y5p7kK6aLoyaODpeuXxUTMhyh5Mc9s+qDBZ5HKSQtUeJUAQtElqerpOVeKXF2tWcGXBuYypf//C6+dog4AfYr+ttnnsiPoWeAFy8L6F/hmJemHnqHLnzLNyiBpnrM9w7Fl5tyhlpsjnFZZnmqOuRU/lJJTgEuk2qTDKwbzx3FUfiz4M0BulGPf0+e20HDAVlYOOf2JPcnrCeoKCnuMgmDwvD0fgP9esLKsFh6XUNzMwa8hyV4WBx9LsHGEmslbKd6jhYd+qU2Tv8CGMHONKuUYLzwdAWVgMIuyx0Uar13HA70Lq8z8k6hE0oSUM3Wj+S9+ijIrfL0EUknNxwqbqt8DpoZblkQihVRe+jc1x2K/x9hUWiQGWuZtUoAP3gbC2X0hZ6QonRbKOtxgH20BmyWwqGAZW08cUYmoAe07gfCer87jQ89+6BL9FAsF5j3CoOstUpRZ6sqoLxMvQiGI293i29mxdFZKiZO/wBtDt9WshzrLmx7HjxJnNoRkFqdzZYK4Fofx1kAWFn1dR0WTqQIEQDNmOE5o/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199015)(2906002)(5660300002)(66556008)(6636002)(4326008)(54906003)(8676002)(316002)(33716001)(66946007)(478600001)(6666004)(6506007)(8936002)(6862004)(41300700001)(6486002)(9686003)(53546011)(6512007)(83380400001)(26005)(44832011)(66476007)(38100700002)(82960400001)(186003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qrNIy7/w2hrjkRQD8RElZFfn3DeakJ6o41u/VXnVQ43xkLca04IlSx3keLl2?=
 =?us-ascii?Q?gEHP7FqoZ51A+aEy2kYC1xnpIY4EnNg8fWSI0Pcup8DhIKoBX9AazxlMeNNu?=
 =?us-ascii?Q?3svnKxbRrUiQUrTPdFYl24XwqMWKbc/5zGSnZCtlTrBB7ZqwW9+OWc0/5UoV?=
 =?us-ascii?Q?VQt32pfnxj/E4yyGRwQAAjI2gcgcSbraDSGTeNVaUsbOT2ZAtO4wXEgugiQH?=
 =?us-ascii?Q?cIpfArko43u2n8bxYx9n50uAne7AYkYYqTWkHynJcYZHTz4fm8kT0mwFtkvf?=
 =?us-ascii?Q?/F4OgkU2j59BK/436/SJwiOhbI1h6+f599yZBwpbe2DtCrz1LzCd99JOhW5H?=
 =?us-ascii?Q?rLTK2N5b7Fb+UzmAmKLK1OTweVAg7fk/aikc3JWMktV41ycxivKvbDP3MXv4?=
 =?us-ascii?Q?/kqZAcv8vam2ctXmAfRarq+5RIpuaR8QJ8mt4CMGAhI4HonQxQVJHh9F9wvv?=
 =?us-ascii?Q?b4SYIJAPdBauiyZ6/YUXivcFf3xm+7Z0dt8fG07YUZ1Ly2G78/Tomf703Lys?=
 =?us-ascii?Q?PnSRZjdkUjnlgLbu7M8rcJylYwj9ihpHGKkSLPqYYuc1Vbc8apmxzzIMZnL9?=
 =?us-ascii?Q?cwt39UyIHW6hyeRaY7mcaAzuQMSLfcIo9JOxKuwG1dB3SaZL6QiiXr4jjDDe?=
 =?us-ascii?Q?079Ywao4/x3CDTgl/TLfF12mLNrI5uW0qDs2YLal0lyTwLX80ETasQk1F4px?=
 =?us-ascii?Q?emungPHuQJujYF7qtABRrcvMPklnwR7TNcgBsXsWnPY00hKzNPOKLh4mIDOv?=
 =?us-ascii?Q?0oEp/kHwEhUyxpJBfE8QG8qYQhjphAcsLgMAMFfTLpXdGeSoX5fVuL1kpVWv?=
 =?us-ascii?Q?xACvBPlzcKcJfou8RO1F0/RDYzPQ5oo3QL4Lw2Kd9geV9KtbXVGAW3bExXNY?=
 =?us-ascii?Q?5MkMXb3OBs9gt0NSkk40rOvSgzrsEYyzf11UCywXTvk7ahSdO1ga+6S7jjE1?=
 =?us-ascii?Q?5yXASYTZ4bZO2c1/HVKooKyj1fYEt+mnj7duGYnj/QoP1RAvyIIrxTuI3CR+?=
 =?us-ascii?Q?zDIYBvxJEVJ4DrPDUvMR/ePD/UN0IsVL8Kyvk4JvnG9TnRsHZzNaSyZvO8VW?=
 =?us-ascii?Q?6Kd4HY1lhRwWIqTqcW1Xcziy0MCja2i8wkUzoFxVp7HbJxEPSzpg2BM5TnUA?=
 =?us-ascii?Q?z5irWpb7lh2sPMqfezDnuLM6WmJZD20KpmV6+N63+zSwsS4jimjNVUOFYyNy?=
 =?us-ascii?Q?hK6ADMumzZGf0khw7EKY5GckAeH7rM4z7TR1sgOHWui1vY7ozDuUUxEzKqKk?=
 =?us-ascii?Q?SEs++Q2mG4JuKjn2nbZe3SSKOG/o+o4wR45fnsmHkhkNeu9JLiLh6TTaLnhv?=
 =?us-ascii?Q?vO5jLPrIHq2anm9LIjcGMFF7fcHbO/vcH/AI+dB5aPpH562QLd51fERuaGW+?=
 =?us-ascii?Q?3937dd2/gT/AS/VV6MjrO7osHidSiiiQ3iyzg8FOwiQ4sly6lPOA3m0d1DJK?=
 =?us-ascii?Q?Y335HskqnkAmq+pgyQ/6CBRSL4IR1QoxpbM8oMKcZRKrAEl3v5GUWKiV0N+r?=
 =?us-ascii?Q?VvU7wG6/e9+hEnFu+mN5MfUohpyIEfNlTpgoQxBqwcMfiwMpvcO5LHzB/82d?=
 =?us-ascii?Q?pcGcfeduPw71JnFBUOi6PhdJSdDIPrlKimLY5FDZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c672aa3e-afbe-4e15-b91f-08dab0a53450
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 01:08:02.1237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPuDTb5dVebN3GBun4LMhtZVSaCwpWxGSyln9M903L5OGQktEwSrKvXozJls4tBdQfuijUeJ5OSrgH6mpvz6nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5561
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 04:15:24PM -0700, Dave Hansen wrote:
> On 10/17/22 06:29, Feng Tang wrote:
> > +	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> > +	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> > +	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> > +	    topology_max_packages() <= 2)
> > +		clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
> 
> I couldn't help but notice the comment in here:
> 
> > void __init calculate_max_logical_packages(void)
> > {
> >         int ncpus;
> > 
> >         /*
> >          * Today neither Intel nor AMD support heterogeneous systems so
> >          * extrapolate the boot cpu's data to all packages.
> >          */
> >         ncpus = cpu_data(0).booted_cores * topology_max_smt_threads();
> >         __max_logical_packages = DIV_ROUND_UP(total_cpus, ncpus);
> >         pr_info("Max logical packages: %u\n", __max_logical_packages);
> > }
> 
> Could you double check for me that the Alder Lake combination Core/Atom
> CPUs don't count as "heterogeneous systems" in this case?

Thanks for the great catch! This API seems to be obsolete and shouldn't
be used, even if the number happens to equal to 'logical_packages'  

I found a Alder Lake platform which has 6 P-cores and 8 E-cores (Thanks
Rui for sharing it), the log shows "smpboot: Max logical packages: 1",
and 'cat /proc/cpuinfo | grep "physical id"' shows all its CPU's package
ID is '0'

When writing the RFC patch, I followed the smp_init() discussed by Peter
and Rui, where 'logical_packages' is the appropriate number, which is
updated in topology_update_package_map() after each CPU gets initialized.

Possible fix for this could be:
* export 'logical_packages' for tsc use
* update calculate_max_logical_packages() to return 'logical_packages'

Thoughts?

Thanks,
Feng
