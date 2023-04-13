Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EF36E115C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjDMPnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDMPnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:43:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E936210E3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681400629; x=1712936629;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QOq9nOa94ZznsG5FeCw2bWXE79xHRRPQSH6HW0dT2Tc=;
  b=XlbVR5dM8FvPsCZ7I3ogO05P4YfSFAUhdEl9FWIcDxyotSwuHxmnGo0W
   tftVFhsO+/mqlCLA2uQQJjidIYm83FdCv5lPhWUrNbKuEyBue7r6qjc0Z
   YLlCSKZi/mI6nOG0ESViSr+KmDO+G4o1KB46u+NThOhs8i+fPHi3Tlv9Q
   7aMbwxKXjzz1ijdftcllpYXH9NWEcUG2zyrSTYVGnopUvjugdKz+bOEMn
   l6rI3MStVz0T3YeHc7lOi8PoRWh/oJCpmOokdXb+xAjjgkllOX2Jc/0mh
   H7hANCf1StD8IGirmwcpq5yCdl0WgrrXCi69VdaOQGFWvKaIHTS1YHam/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="328356920"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="328356920"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 08:42:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="833189568"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="833189568"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 13 Apr 2023 08:42:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 08:42:56 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 08:42:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 13 Apr 2023 08:42:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 13 Apr 2023 08:42:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIDxKDvMBgGLYX7cXgPzCyp0uT5plFNbQUYuOgRgGxXPpsyui0VumQgl/dQMNN18TdFhLWQCvwmK1TtBmRdGP0Di6VEr9fMWHN/2jtEbC+4FpoTy2NTB+fV7ekRgiACPunLh9BE6T4kKOIlVkkpvPHrATNuEWuDmm4toWTLC/BoZ2mUKZTlDP2UejkP2DleJJTDN0W807wtu5/qxP9l6VhFLhOaFVCeGa+Ai1EYShJY2n658rAHtLAMPJ/+cd6Ukl6NWJEl8OGglxuu9d69Vw5/r11R5tu9bNbjdLBQ5wT8KNtxw763rQtZNM08miWIO04hL/1yY2kcpchwygYdWNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brT+AibCqqocuHG+ayT5jnLC2l+dmM3MZwoWS96rguk=;
 b=P7h21seoZzQ9ZcPMptax142pu3/1LvyGi0guWYbigfvPVYE8iSgQJld7m6BkLDfsCIykzTw4I2nU0WPEEZp7LVYuZy2gjf1HnaAx55K/G3oXTXNwZk+Pb5JiUjErxzZb9bOFbrJ7qgw3SD8NMzSPsXBEtYdrPd04jylE/cJ8TVWRW/XpuBtdXDTuqw09UeBuAdYhLGK5v6fN6ZSDEhgEPPp1gv0yEZZDUpJB3X+CwDUetZJn+vxRbKmG2A1MEEJCVpnDui4Ad+x69/Ozc7QPIAkTIufokEHZcJ/aS1VwkpYX+37zz0k4tFiEFn43/luI9i5GJAQi5Q87rdxuyc0Cuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DM4PR11MB8180.namprd11.prod.outlook.com (2603:10b6:8:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 15:42:53 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d%5]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 15:42:53 +0000
Date:   Thu, 13 Apr 2023 23:42:34 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@kernel.org>, <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <corbet@lwn.net>, <qyousef@layalina.io>, <chris.hyser@oracle.com>,
        <patrick.bellasi@matbug.net>, <pjt@google.com>, <pavel@ucw.cz>,
        <qperret@google.com>, <tim.c.chen@linux.intel.com>,
        <joshdon@google.com>, <timj@gnu.org>, <kprateek.nayak@amd.com>,
        <youssefesmat@chromium.org>, <joel@joelfernandes.org>,
        <efault@gmx.de>
Subject: Re: [PATCH 06/17] sched/fair: Add lag based placement
Message-ID: <ZDgi6g4hRYCfbxcu@chenyu5-mobl1>
References: <20230328092622.062917921@infradead.org>
 <20230328110353.988000317@infradead.org>
 <ZCqZzp98q806qfip@chenyu5-mobl1>
 <20230405094720.GA4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230405094720.GA4253@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DM4PR11MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: 61eed55f-94e5-48b6-2ef6-08db3c35be7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/vRd++pL/CnR311wSRfEOWazfPJlOgJDg75a8IpFiN3RiE3lfcZqbiC2xrVpWHuq8n0XRCCGk5qvRdmqJq6bIZ1VMXwTfE9PanKwl4HDDbsCHgU+1q6hCGGnm65qBf22Z24b0p4COaZZyu8SnhA6rMAZ99uqq8SvIOzGDZrRDNg+0TJ6OTws6rQnDFKdDYZs+tXIu1Dmqpt0lcOOya6X0hEt9a7wVGoKe1U5e0qndvYLw2LDGAai+HLawdOxY/81HIDNsgvpRdOUntgLUOsTFzH9YNTIh72bU3/kR8gTLlLW/GUV8GolInKtGzt9mFiiA30gygXlATnXWGR0P3tCAs0Y2ft68dSakR2xRVnZspm890x23QqFRvgqwIdeATUw6yt3wUzfP89DAYW8aaZC5rg8ciOtPxEy4Se24Q+gFh6Bc2xmPsSEs+mMNfLdDAx8EBot9qWohomzYqbK7CS0cGW+vD9qWhc9UyAdGLGTZNFW3Fbf7KRAU6qnNZHyGwaxEnN4voUtkvDVYflYoSAYZON/FrOxd5eCeYNcjAnmYNdn9mXeiCFLXvUI174GxhE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(186003)(41300700001)(33716001)(53546011)(86362001)(66556008)(4326008)(66476007)(6916009)(66946007)(9686003)(82960400001)(6512007)(316002)(6506007)(26005)(478600001)(6486002)(5660300002)(8936002)(7416002)(6666004)(38100700002)(2906002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oSSXZfVFU9Trpcg0PJiPqXby5JnccEwEWg2s/tCsPV/1NoVNs4OaE+kh7QER?=
 =?us-ascii?Q?7z2zC1/hJr8/GEbDk6Pio+K0RBjEwGJTFyV9jmzbQ+xfu7aP9pD4BTnHv5dg?=
 =?us-ascii?Q?78vdfZbhpvimuqz9dVtoQYuTEF1Nf0r7Qyuf7fYp22FHYvubCRKA1jTuAUaS?=
 =?us-ascii?Q?OOZY5LDw+4wmCqsTjv5YYXc2HitrMFYZDISHgmIQ4b6N4fQjYdAH4LaQ2vRc?=
 =?us-ascii?Q?8ZL3DL1dO+zqwgTNMvvKk4UvNifzSik51Q49y3gBMnn6T3qVPSwO9MjU/6AY?=
 =?us-ascii?Q?fP4cvWG9B973QoiaxpFGrEx0EzMILbBnYedVYXhi/tjEoSJO0ZbI0KXSh0ME?=
 =?us-ascii?Q?Y5+COunSJFg93Yft2Dl3FnKf2ISugQzKr/qvu8+uwbs4KPruCI/XcgkLxHV8?=
 =?us-ascii?Q?cnloRyptJzr2KHyjFqmVErvBZm2iyKDi6Y8oL+mBk4C3gaXHABCg5jpxbLzJ?=
 =?us-ascii?Q?B6TcCve5X79NWK0Dm8gdIIq1YGu7zZi2RLks+5XH55O8OK3+eL9bHO05Tea0?=
 =?us-ascii?Q?il0fUfX+JhgqYy/2wIVCpZlMyJdTMi8DUbqBougoYhweqx0vp+nUrAQeFf17?=
 =?us-ascii?Q?kz0GiOpIQNTNpDfz6hDOtwQUC2q37ZNo5QvqoEZI/XSeZYhe86HUp888TMjd?=
 =?us-ascii?Q?HZf3SjRvwgsfqhr/yj/hw745MAYewVMOqCYT7MIM3sl/HRXp/KxZeAd9eWbL?=
 =?us-ascii?Q?fwx0TMDmh2M1uK4TLCCKDu0gBWc26lHK3aj/WBj6xkRs9rUH0SB0oeTnznen?=
 =?us-ascii?Q?DBffv0lEzm7Qd8Qpm8KgTbMhPc8cV6MIapkmKO4W0ggoylxcDHpDzRcPYHrD?=
 =?us-ascii?Q?x4qq0MBaCPI3c+MdpgoNrQPWw9UPENQAG3AcitEZ0nPIxiLiIRq9ZF26cgyc?=
 =?us-ascii?Q?CV9GoUwQfghDvme9ZkPovJbaSQfTLT4zrnyYw81IarsmEYEUsZrg1ctJznn5?=
 =?us-ascii?Q?bvkHlF+iV6drD+1wi/GhXg2bpimM7tQMOwaGvF+WDFsEfHoQCCrfvyfxkMON?=
 =?us-ascii?Q?tguDSKwlGxJROjHyGe9RCeTmLSobFps+/o3aXl1FEUimBUHR/iCVzkN7hcEa?=
 =?us-ascii?Q?pW1Ykw4Rf9mAwidmCIKGUykDD+lYa/2P29P0nRH231/d0ayHV8fvOLIOulwV?=
 =?us-ascii?Q?QWTg2AVU7VY+u38HE5bZga8tssWStOPqUnR82ZwdqnEjakoBLf1Un01tJKzU?=
 =?us-ascii?Q?D5xk8Ps4bB4Jp9HwO+u+2BGV/+ihvDCSjoE1H6ed2yRTV8s1H/6W6U3G/pJZ?=
 =?us-ascii?Q?Bc9bnS+Ixfk5VApW5PY9Edpn/lDevbCysJJc6Hyro5IEM9zDX2hJYl110Qkm?=
 =?us-ascii?Q?CoFUKJdtIYvuBxSbUzBqJHiWtyN+K2LZtcgfFB3D8uSOYG5nwkq+H59DErMC?=
 =?us-ascii?Q?yeDvF+sZZzET3QCDw6OlI7nVqvTmT8pVmHS+oNW/EJqSG1r3vdVrbzECLr4Z?=
 =?us-ascii?Q?HaWEFUVgJ8njqWnjMy2Bamm8muTWCXOQPgs8+lpPxcRo/nYkUDy9q4puB8+m?=
 =?us-ascii?Q?icMV8n9rxeR6Z1xmDcnO0hWrVZlngqD8CJ8NUHsv/xZ1m+GAOjHlO0rQT2X5?=
 =?us-ascii?Q?WNmzh9bvrV65GDiM/J8v3KnEdmoormPzXymy+090?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61eed55f-94e5-48b6-2ef6-08db3c35be7a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 15:42:53.3405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ME6t6Yg7Iomk6LIwSJEENwqwS9V9wnCFNVCeB55Wld1iB1Q/IlaQhSN5050gidjeFZOdZhebEnNa1F3Qru2lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8180
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-05 at 11:47:20 +0200, Peter Zijlstra wrote:
> On Mon, Apr 03, 2023 at 05:18:06PM +0800, Chen Yu wrote:
> > On 2023-03-28 at 11:26:28 +0200, Peter Zijlstra wrote:
So I launched the test on another platform with more CPUs,

baseline: 6.3-rc6

compare:  sched/eevdf branch on top of commit 8c59a975d5ee ("sched/eevdf: Debug / validation crud")


--------------------------------------------------------------------------------------
schbench:mthreads = 2
                   baseline                    eevdf+NO_PLACE_BONUS
worker_threads
25%                80.00           +19.2%      95.40            schbench.latency_90%_us
                   (0.00%)                     (0.51%)          stddev
50%                183.70          +2.2%       187.80           schbench.latency_90%_us
                   (0.35%)                     (0.46%)          stddev
75%                4065            -21.4%      3193             schbench.latency_90%_us
                   (69.65%)                    (3.42%)          stddev
100%               13696           -92.4%      1040             schbench.latency_90%_us
                   (5.25%)                     (69.03%)         stddev
125%               16457           -78.6%      3514             schbench.latency_90%_us
                   (10.50%)                    (6.25%)          stddev
150%               31177           -77.5%      7008             schbench.latency_90%_us
                   (6.84%)                     (5.19%)          stddev
175%               40729           -75.1%      10160            schbench.latency_90%_us
                   (6.11%)                     (2.53%)          stddev
200%               52224           -74.4%      13385            schbench.latency_90%_us
                   (10.42%)                    (1.72%)          stddev


                  eevdf+NO_PLACE_BONUS       eevdf+PLACE_BONUS
worker_threads
25%               96.30             +0.2%      96.50            schbench.latency_90%_us
                  (0.66%)                      (0.52%)          stddev
50%               187.20            -3.0%      181.60           schbench.latency_90%_us
                  (0.21%)                      (0.71%)          stddev
75%                3034             -84.1%     482.50           schbench.latency_90%_us
                  (5.56%)                      (27.40%)         stddev
100%              648.20            +114.7%    1391             schbench.latency_90%_us
                  (64.70%)                     (10.05%)         stddev
125%              3506              -3.0%      3400             schbench.latency_90%_us
                  (2.79%)                      (9.89%)          stddev
150%              6793              +29.6%     8803             schbench.latency_90%_us
                  (1.39%)                      (7.30%)          stddev
175%               9961             +9.2%      10876            schbench.latency_90%_us
                  (1.51%)                      (6.54%)          stddev
200%              13660             +3.3%      14118            schbench.latency_90%_us
                  (1.38%)                      (6.02%)          stddev



Summary for schbench: in most cases eevdf+NO_PLACE_BONUS gives the best performance.
And this is aligned with the previous test on another platform with smaller number of
CPUs, eevdf benefits schbench overall.

---------------------------------------------------------------------------------------



hackbench: ipc=pipe mode=process default fd:20

                   baseline                     eevdf+NO_PLACE_BONUS
worker_threads
1                  103103            -0.3%     102794        hackbench.throughput_avg
25%                115562          +825.7%    1069725        hackbench.throughput_avg
50%                296514          +352.1%    1340414        hackbench.throughput_avg
75%                498059          +190.8%    1448156        hackbench.throughput_avg
100%               804560           +74.8%    1406413        hackbench.throughput_avg


                   eevdf+NO_PLACE_BONUS        eevdf+PLACE_BONUS
worker_threads
1                  102172            +1.5%     103661         hackbench.throughput_avg
25%                1076503           -52.8%     508612        hackbench.throughput_avg
50%                1394311           -68.2%     443251        hackbench.throughput_avg
75%                1476502           -70.2%     440391        hackbench.throughput_avg
100%               1512706           -76.2%     359741        hackbench.throughput_avg


Summary for hackbench pipe process test: in most cases eevdf+NO_PLACE_BONUS gives the best performance.

-------------------------------------------------------------------------------------
unixbench: test=pipe

                   baseline                     eevdf+NO_PLACE_BONUS
nr_task
1                  1405              -0.5%       1398        unixbench.score
25%                77942             +0.9%      78680        unixbench.score
50%                155384            +1.1%     157100        unixbench.score
75%                179756            +0.3%     180295        unixbench.score
100%               204030            -0.2%     203540        unixbench.score
125%               204972            -0.4%     204062        unixbench.score
150%               205891            -0.5%     204792        unixbench.score
175%               207051            -0.5%     206047        unixbench.score
200%               209387            -0.9%     207559        unixbench.score


                   eevdf+NO_PLACE_BONUS        eevdf+PLACE_BONUS
nr_task
1                  1405              -0.3%       1401        unixbench.score
25%                78640             +0.0%      78647        unixbench.score
50%                157153            -0.0%     157093        unixbench.score
75%                180152            +0.0%     180205        unixbench.score
100%               203479            -0.0%     203464        unixbench.score
125%               203866            +0.1%     204013        unixbench.score
150%               204872            -0.0%     204838        unixbench.score
175%               205799            +0.0%     205824        unixbench.score
200%               207152            +0.2%     207546        unixbench.score

Seems to have no impact on unixbench in pipe mode.
--------------------------------------------------------------------------------

netperf: TCP_RR, ipv4, loopback

                   baseline                    eevdf+NO_PLACE_BONUS
nr_threads
25%                56232            -1.7%      55265        netperf.Throughput_tps
50%                49876            -3.1%      48338        netperf.Throughput_tps
75%                24281            +1.9%      24741        netperf.Throughput_tps
100%               73598            +3.8%      76375        netperf.Throughput_tps
125%               59119            +1.4%      59968        netperf.Throughput_tps
150%               49124            +1.2%      49727        netperf.Throughput_tps
175%               41929            +0.2%      42004        netperf.Throughput_tps
200%               36543            +0.4%      36677        netperf.Throughput_tps

                   eevdf+NO_PLACE_BONUS        eevdf+PLACE_BONUS
nr_threads
25%                55296            +4.7%      57877        netperf.Throughput_tps
50%                48659            +1.9%      49585        netperf.Throughput_tps
75%                24741            +0.3%      24807        netperf.Throughput_tps
100%               76455            +6.7%      81548        netperf.Throughput_tps
125%               60082            +7.6%      64622        netperf.Throughput_tps
150%               49618            +7.7%      53429        netperf.Throughput_tps
175%               41974            +7.6%      45160        netperf.Throughput_tps
200%               36677            +6.5%      39067        netperf.Throughput_tps

Seems to have no impact on netperf.
-----------------------------------------------------------------------------------

stress-ng: futex

                   baseline                     eevdf+NO_PLACE_BONUS
nr_threads
25%                207926           -21.0%     164356       stress-ng.futex.ops_per_sec
50%                46611           -16.1%      39130        stress-ng.futex.ops_per_sec
75%                71381           -11.3%      63283        stress-ng.futex.ops_per_sec
100%               58766            -0.8%      58269        stress-ng.futex.ops_per_sec
125%               59859           +11.3%      66645        stress-ng.futex.ops_per_sec
150%               52869            +7.6%      56863        stress-ng.futex.ops_per_sec
175%               49607           +22.9%      60969        stress-ng.futex.ops_per_sec
200%               56011           +11.8%      62631        stress-ng.futex.ops_per_sec


When the system is not busy, there is regression. When the system gets busier,
there are some improvement. Even with PLACE_BONUS enabled, there are still regression.
Per the perf profile of 50% case, there are nearly the same ratio of wakeup with vs without
eevdf patch applied:
50.82            -0.7       50.15        perf-profile.children.cycles-pp.futex_wake
but there are more preemption after eevdf enabled:
135095           +15.4%     155943        stress-ng.time.involuntary_context_switches
which is near the performance loss -16.1%
That is to say, eevdf help futex wakee grab the CPU easier(benefit latency), while might
have some impact on throughput?

thanks,
Chenyu
