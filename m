Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB7B6CA196
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjC0KnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjC0KnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:43:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC1F270D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679913782; x=1711449782;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ksrP2ibj6yLJY64gmpIuKgC5Q7oxUMkfcLj5RT5XOrY=;
  b=fMWqrDtFCGt304wMTsUYVe3DCLg1K0XCNUpBQJLyP9oGJAdsj3WZpfOb
   CR43p1FaNO3RCiltQ+msBOUz6D2L1DdvQQdBIL9XWAvKD0y9fumhynL+t
   zgmSGXDJF0+hyC6mlN2WBDQcXLa83fR3sQ6jmMZS2WQRD9bltBQUgHSCM
   8Q7xg1QdH0pbS+7h3jsipP1y7AIbA3ndIMu89sCYe4YlHB356jgAYQMiQ
   u4XTY3rGMeAtjOnndkJkC1XzfPwS2rG0ZCQwyUL2PqubTUctyH2jN0nUK
   mtgLoevyQY/dhX0Ovy3ONRLwvisryD7aLuhvjA3ccJV0Lj880iUP2FvYl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="328669367"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="328669367"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 03:42:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="807426658"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="807426658"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 27 Mar 2023 03:42:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 03:42:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 03:42:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 03:42:51 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 03:42:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQ7Ys8qalVrXoA1POvG9b4+nVTZwE6k6xqTAik09qrsM5zq5nyo4IlnEfcR2+LwAV4ujr434ubffDYtQTJl+Fd8oIEbKziJjl3lXEXwFxWtX5zfD8RFv1TXSRLcDkm/QL41goJTOv0Z8JSsmy8zkA8F1OKx9SfK+iHe/gpFWmijPeyNjm8tqUiXQPjysRK1Ia+H2YV4QDQPYxZGxraqMhqYDu0BLIe68xPPtzch4Ea93CoLOU4FEKn8i4RqfKazEmTUT9uJA17Spyi67YTc1qagl9xJJZVdl0NB3D2b+df1/gqJ6OcJtcO56y7Gz+N8CSIdSOqwss2xkYFDBqOIjcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlqhDgGz9EbAxGD/vxqNuVBhBN/R4RXtoJevwHuYsjg=;
 b=A9xTvy37Jl9aPI/4wFU37Q3RtrVHM0EnHRqjpUDim0xF0S8zD48+ksX4SbXVMkjz9PtyH01PejAL9lxKUyr4tj5Rp3Ubq48PYDwD2jXXjcZdzFSOgK5LhmIGZZ95t3qiyTZMyTjiQuOxq3J+NY7G8UB6ENU5AORxynauzvLRCSm8pVkQ6n9l5Yu4aGVMAj74HMHB+KIz0yBW+h7M5BQ1kGFojvvp1xrsZM5JR6GaW6/y+CLga3PnBKuGWG5VRtNc+RrbdbrJp8LBq/F23+jmB/SBIMHCkza9NyTIObTT2r3iovdz5ASZ9R8VmJCMZxaUWR88Wl2G5CdlISnLUX3Pug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SN7PR11MB7017.namprd11.prod.outlook.com (2603:10b6:806:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 10:42:45 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d%7]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 10:42:44 +0000
Date:   Mon, 27 Mar 2023 18:42:35 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: rq lock contention due to commit af7f588d8f73
Message-ID: <20230327104235.GB571475@ziqianlu-desk2>
References: <20230327080502.GA570847@ziqianlu-desk2>
 <20230327090951.GA4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230327090951.GA4253@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SN7PR11MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: bd62b9cf-5ed5-4d25-a88e-08db2eafff6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZCD6B+UJ65CXX7SqXU3815Em94+Z8MmlpxV6IJClh3EAEKl/sPpiTQJrzhM6BkUPo98ZBtJ1rYedWNxre1Z3PhAfRT70kZhbjqijpl1qyUoCie84l9HC7dUPrJcjnnYuExpc1mC6fFQmnmW0VphjfLJI5rv18eaolv1T78cQtF9dAq/Jg6apH4JtqNHzgShjvBNz3t1sxLCgvQZoFjkvp9XADQWoK8j1hXaWci61G2wu6EXWkLLlbZs4b/OivYO875HGneYMixmBxWi3ElmPuUg9YfGuLkGVllggqChD43BzsdWRUmLXsqW5+z7A5fdtmyL+qEU+SiHU2SHeDqdx6iG/gCnz1rXkOlvQdBfIQuqIJCLTHEi6avS/ivr2+7rNIgIrvrBY3E89mqnKgWXRo7N0p4YguQfd9+0RHkrltTVxsBvv7rS9lMCUBt38aRzLnad8xVHFt/ukboMerqsDXcqNb7gbVI7FllxOFCV9e/jq8ugqkuzcSxy5tdqMECnd353dFH8GySlSLFwGv8ZLUo/QX/T4jhpDyz0dYzCXcTAonqnWUAZF4OpQNxVuR7Bp/SkKriHgx7vsSZUtZ6ToVWbV2exrgcqQX59wXcwjKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199021)(86362001)(44832011)(33716001)(33656002)(2906002)(6486002)(6666004)(83380400001)(1076003)(26005)(478600001)(4326008)(6916009)(316002)(66556008)(66476007)(8676002)(66946007)(186003)(82960400001)(6512007)(6506007)(9686003)(8936002)(41300700001)(5660300002)(38100700002)(98903001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1tgV1CMicuEV9drv3me2MLduG3/LchXYAlhzWW9dd/xsVSZaLygbllDPeR3e?=
 =?us-ascii?Q?PIReWi7QSxXrY6fXuexcEkhwrgzK36nDL1pwOFy7gSYm02cH6tZSx420WXIw?=
 =?us-ascii?Q?jhcHpL8FBDvyq2mo0HKzWH8sAvNRSasmvj65eX8DBSMPyQoWOwfH20uWA4mG?=
 =?us-ascii?Q?ue4Dfiyz1zUkRLIqwDye+gR0tYuCVlp/Pa9F7O5qTgBr9UgJK/xu6e1XIxh0?=
 =?us-ascii?Q?5jp7ByNlWEDbkcc+ltXbpe+00Gs4edhTfcM5e4bQb0/mYfftHePd+vAa7XTn?=
 =?us-ascii?Q?2kXPxp5Z4tFWb92AzSoHhNMxjdHHbiTOiB9/0BFft+xWPn5xT3HPbtI53OK8?=
 =?us-ascii?Q?5TJpErOwW4NfzjqlpL+5ynr6+iHDNpCz9fJ9bD0cAUPTnj5E9hsicf1B5dtk?=
 =?us-ascii?Q?DI4CxhQYKWLG2NMafqXhK1N89izZyDO6pXpdDP2+P3IjSqtcXQhfA7BMbHHC?=
 =?us-ascii?Q?DV7tiKwjXTwW3iAt+3w4fEpqquA2rtPGYqR0cM4SjSmEX72WgKoFqxOOXuo9?=
 =?us-ascii?Q?ilGbrvo2ndceFSswuD4j+/Qi6CPtWUk6RsA8hXVR0k/nKDXb+0CS/Bt89zmj?=
 =?us-ascii?Q?bT+MojRFRqvoCJbrYbXkaaFIjx9tfLbvF1RyaGv7T2qHyyGgRrrEblYLjTSc?=
 =?us-ascii?Q?io/hexHc4gNLKuRrKw5G0py0U/CQMg1NIegDyRT4mdZ6mecr5WeXKvWRaoSL?=
 =?us-ascii?Q?vJIS3o7FC/Aok/ovTQQFduDL/At4m02qng+fxesN5THn7/4Oy0Mu6Wu2bHbe?=
 =?us-ascii?Q?o8nqXYTWlUtfZ1U8pQl0WvvisVAoIy9m0oTisE3uLKlerQkpsXVxLQOe7pGi?=
 =?us-ascii?Q?jbPQOMGSZOfDHaLl1BU8hvs4DAY9HObpIiZnZckLiekfPhno3NMym0xr6F1s?=
 =?us-ascii?Q?mAOSqMvtmC7I/J9JxdAsCk5TyerS4PrJD8SoQbgIqce+BzSrE6d+630ZbBV8?=
 =?us-ascii?Q?v5mxojh7GRHP63oNciAujSOlggXe6Xa+nPBnWZge1iBxyZaN0nL1/xCrF/9M?=
 =?us-ascii?Q?IQs6ZaRrGVE4+cCDTIiX0uZTv0tu3lcumovITb6rG8GRufP5IBl0GtHS2izz?=
 =?us-ascii?Q?8ZhoCMNitvaKcGpPtfis24Ru1KsuZhz9DDdJh9RmoJvMYVK+qXkIBr/02jNe?=
 =?us-ascii?Q?GpQmkHUGFCPuM7f07gkDBKiTtw1NRdA2t2ZZgf2trQGWpOrz5alA3s4+Hgvm?=
 =?us-ascii?Q?8mVM2hINDOyNrW4jLFS6Y3s4iqP3og7Nzl2AOx6ke1mIPLnk783py916LJdv?=
 =?us-ascii?Q?/ctLgVvZjrgH9E4LRYUe9bFafjpoLStWf+Pee1RDgNiT5/FVzUvpwYmpHBzG?=
 =?us-ascii?Q?RaWQJBEH9AkUqVHpctBf59AGuJZeFdthFq6Nn0bCmXoo0Qbd6XMSiDHyaDFD?=
 =?us-ascii?Q?2JWiSw78wbEBBYKxQFRU6tBujxQWOmV/0J3jrLx5gxvJF/U2M++7UrkmARey?=
 =?us-ascii?Q?GB1N7TYULf7vNWtNAB3SJNUC4IC6WN73zipHVp/yGCW7E9OG/wheYCQ9+R4X?=
 =?us-ascii?Q?WBbtwAEbRv2jf4iPUT1hC1MppB7JqwuQqsutz18CEr3O+vqISMZl6PXBy4Tn?=
 =?us-ascii?Q?lLf1aRu1nA9VC3Vdbbys//nDY4cPWkYpwVlVeXhk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd62b9cf-5ed5-4d25-a88e-08db2eafff6f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 10:42:44.3813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kR4IOxx9OEchNDVclsYRhuVXPMBcr554YopHHvOhnJ47Y3TtNsUa8uZmgi7sYQO5vW4masj5nvfQ7dX9lp4uGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7017
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 11:09:51AM +0200, Peter Zijlstra wrote:
> On Mon, Mar 27, 2023 at 04:05:02PM +0800, Aaron Lu wrote:
> > Hi Mathieu,
> > 
> > I was doing some optimization work[1] for kernel scheduler using a
> > database workload: sysbench+postgres and before I submit my work, I
> > rebased my patch on top of latest v6.3-rc kernels to see if everything
> > still works expected and then I found rq's lock became very heavily
> > contended as compared to v6.2 based kernels.
> > 
> > Using the above mentioned workload, before commit af7f588d8f73("sched:
> > Introduce per-memory-map concurrency ID"), the profile looked like:
> > 
> >      7.30%     0.71%  [kernel.vmlinux]            [k] __schedule
> >      0.03%     0.03%  [kernel.vmlinux]            [k] native_queued_spin_lock_slowpath
> > 
> > After that commit:
> > 
> >     49.01%     0.87%  [kernel.vmlinux]            [k] __schedule
> >     43.20%    43.18%  [kernel.vmlinux]            [k] native_queued_spin_lock_slowpath
> 
> Unlike what the subject says, if it is due to that commit, then it's not
> rq lock but that new cid_lock thing.
> 
> Can you frob init/Kconfig and make SCHED_MM_CID user configurable and
> disable it to confirm?

Confirmed the problem is gone after disabling it through menuconfig with
the below diff applied on top of v6.3-rc4.

> 
> (also, mathieu, when you do the below, you'll see it is in a weird spot)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 1fb5f313d18f..f2661f73f3dd 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1042,7 +1042,8 @@ config RT_GROUP_SCHED
>  endif #CGROUP_SCHED
>  
>  config SCHED_MM_CID
> -	def_bool y
> +	bool "RSEQ Concurrency ID"
> +	default y
>  	depends on SMP && RSEQ
>  
>  config UCLAMP_TASK_GROUP
