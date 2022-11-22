Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745A96340AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiKVP7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbiKVP7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:59:08 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD72A6546
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669132747; x=1700668747;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Jt/H0qa1g63a+ZmE8Vf+CL4Ug5mnnASAenngKIQSzOQ=;
  b=BHMLnJ4x+3xbRIPFo9CuUPmYomzlcmx3hv/Q6p3hoBWB1R9R9Q7a4GrU
   EC6hfeHfrQgREqayUwRdY9a24V9lP7HgamdKtwDNYC3+h/QsAi+bqKvvK
   clJWst/cQGBrvXI0d8irZ7TAOjZRlLcFjHGfKRzOe/EUVqOJLyxEUv+It
   nGm+d5wUCKpalrJSSe4I2yxfmDIq6juqA9C9Ee+nsBMIVcy5pfo5eHyhk
   pPuH/hq+ns1lqf1tETxK0xoM21DSQuyc6WqNn/oG4Uoqwp2TnZjiDXj5M
   +Mfm/tjoI27g7cB3G/xBURjV+wlKjSMIcXKd6m8U6TfOOyDyCUKO8ObVn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="313879119"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="313879119"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 07:59:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="766378006"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="766378006"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 22 Nov 2022 07:59:06 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 07:59:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 07:59:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 07:59:06 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 07:59:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8/yuzoFbHRO6LhOiTdeam/pwhdmXoXc/KtFa+7fnc8zezJnGh8fyFArqnvGMoffn8imuhAduuZ8oEXCBGjRiHfucQrYPZDEN8stEamRwtl5mhWOPAzzeUDomGuHr1b/cFjZH7AYdXvNh0ufR+TTMasSToPJr6SEd16MKsRw6J/CWJdwrzEgcermFQmviaML7lAMGC0xaKaShL5NsFFFLmqlHDrcZc76OpINwxT6ayc2vkWX3Yd1rba+dmfOohq8eUEhFW70KFKv/xCuVkkwTBmZS0VH07lpHMI8r6ZNhNv8fekdVt8rbCf4pGwxx+D3JcmQQok6kZtAAeC3E0uQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9x8fu8BBOFKvjqcblA8FeMAtTdGwXifpE3g5qsuDBk0=;
 b=RvGKDvi0tEtMS4C4dMxveHNWbYMk/zZMVG038nnQgy8aZSRY9v1h1HpHAzvPzmeXxSQ8ehSJE46FUgw741Q9uqiitLPVLQSAmw/l7bFxFuLPc7UVFxR7J3ipT1UCD/vtJw4pv6kZ3nmao2CcPIJMiSX0+0Qd4/GtDOwH0p9UGFrM5N8PHMKGV4Et7qLqrzOrGSMqUsdZsKH4z7/Q4UsMQEVWH4G79MnYrdNetlfXRGBEdBoCdK4s91VEELYuwOU2O6kUczWgiQ2vqS8TQeIw7GKiDkx+UUA0h9NgSUOdvQoLqH+mIWPytt6rXZOoqEW/8Ozdz5wrtGYNbqV7EH6hrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CH0PR11MB5410.namprd11.prod.outlook.com (2603:10b6:610:d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 15:59:01 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%5]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 15:59:01 +0000
Date:   Tue, 22 Nov 2022 23:55:51 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <john.stultz@linaro.org>,
        <sboyd@kernel.org>, <corbet@lwn.net>, <Mark.Rutland@arm.com>,
        <maz@kernel.org>, <kernel-team@meta.com>, <neeraju@codeaurora.org>,
        <ak@linux.intel.com>, <zhengjun.xing@intel.com>,
        Chris Mason <clm@meta.com>, John Stultz <jstultz@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH clocksource 1/3] clocksource: Reject bogus watchdog
 clocksource measurements
Message-ID: <Y3zxB6r1kin8pSH1@feng-clx>
References: <20221114232807.GA834337@paulmck-ThinkPad-P17-Gen-1>
 <20221114232827.835599-1-paulmck@kernel.org>
 <87mt8pkzw1.ffs@tglx>
 <20221117230910.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <Y3rMc2VbgVLHN9db@feng-clx>
 <20221121181449.GA3774542@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221121181449.GA3774542@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CH0PR11MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e12da3-b84b-4dbc-6d3b-08dacca278f1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXvf/4Ho1DCRL7g9GXXwAG1CYZkrw4gz1uLnVPp00bjGHsL/JBHtVqPheTnejyIuAj/IqPn7L1ss+jEfwYv2otuEAHp1IwIrq9Mx87Vzv5OH2AN08uNNW2uNDIMbVP/mGA9fC5qjiFzWUYHLKTHAxyxZw3kVpCRgWfcQp4tL2WufqO4Cez5KEiODQPPZQeMZUUzMcJ3sQR0tbmGn2WA1PQfnAoKDWH3sfEA4wFKynrGwGQX8W4OnZobAw3b1pss6vvbwITcU2hBQt5APdzMiV/KxZ0DmxFhse08BBFH7OE+mbZXPeqZPp9yBqKcNH2mgFVmQdGkj+OfRF2PWwWxzym6rRve8H1ZAwKlyutOFASPNqX1goGyDvshZUdCzM3EDdS645+E03JegVwNh35SvQQUGTfmxqW6T8/Zpb+5sWFO17iDZJXPSmLq4TxvfEAX6N1eK44ubFMc0jwwnzbL9cV0sLA0+m64iiwT2M558SSvnMsdmbTxO6n4b5SfARHcAh/XMaSxrbTg7+q7ajnpmE5nxSDWJQEED1hTq3fl3j+NICNxHIEglJV5nVkSW7fjOMSsYdnC9zGxTuTz8LxIoRKNyCRzk697b+t2dGJ7hnpCQ+fELcHk0+XaY1tQ6IYYApiQwhsP+ptzxNbkK8XBN7tEK3Em6/rVPQtq5fZyzERg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199015)(82960400001)(6486002)(6506007)(478600001)(966005)(6666004)(33716001)(316002)(26005)(6916009)(38100700002)(54906003)(83380400001)(2906002)(8676002)(4326008)(66476007)(41300700001)(66556008)(66946007)(5660300002)(6512007)(44832011)(186003)(8936002)(9686003)(7416002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hNzUNMEA4f+myEHS0K+Lw7jw6jbWlLzerGczlWX4XD6tR8/OPSxBeCfkx4X9?=
 =?us-ascii?Q?vw6+yGUL5jzuGpiwvRY9o3NpfxWecUv7Qnh1DAGv0hgK9qVkr8uWBv8dhWCe?=
 =?us-ascii?Q?+R/Qe6eaEhFO9yGuVLH58BXPm6rgfygzwQ/Ejc4HCdqwV0UpasCu++800R9q?=
 =?us-ascii?Q?Z2TC4MP+t8LbwhedLgq4EgedxrdYGTWPALIkxaPwLuM9K0IDYkCpOdwvcQRt?=
 =?us-ascii?Q?gAat2GkoWusmFVXL0gWpv4cIqnZqQym8uLdnkQ778CAgah+Wu5o0PHdSN6sV?=
 =?us-ascii?Q?PVjhOeIkOUep3owmvI9dpfv794d8rpM1tRnOJXfiLg2EMTPaMHv59BX+EG/N?=
 =?us-ascii?Q?7d+oGtwq17coAaPvDmMcxxC9N/q5jV5C4p6rvpj0wIl8hFRg6gYUajOiTHBz?=
 =?us-ascii?Q?KEqj0OJTdEw7USE6nFKMqM3v0LCUFU9YyqUhT1PmqFMTWDwxVOTM53vCAcWt?=
 =?us-ascii?Q?YFU1IEmLQka4WqCaOit72Rli0ckH3k5frnwCCGrw7TbeVjXLhIVZY0Q6ZewB?=
 =?us-ascii?Q?uSP87Qw5hF7ZtHMX1OB80w1g/w6FiQQ6f0bY8ZAtbilc3y7mP79fFa1Uvt93?=
 =?us-ascii?Q?KrB9f+hDCRu/G30UNAWKM3atZZ5Ebbtk7xbnfGw5+U+ZeXAPekQvaroZWb7Q?=
 =?us-ascii?Q?9rj8vs/Op1NzeZh2Cgw7Ne8wx6Q693XZdScsz7SfhCaZ0r1XdLv+7AGIQ558?=
 =?us-ascii?Q?jpYHQi+1NBQ8RvVzRAmj7EWrXF4PMDbpvqVewTx0Yfj9fD6zPWeoJkg58LaD?=
 =?us-ascii?Q?8mRXbeN2evdyuJXUpVHGVQLZrU+S+SC8Kr689VEAvhZKCXm7zFVw8zZ6a5xj?=
 =?us-ascii?Q?6iYU4+C4D1mv7QuHEcaBKa9/HOIP/AO0vuex5Kggg4nnBwvWTZ8awpVFJvGG?=
 =?us-ascii?Q?gFKEgx5P4DMHByWqqP2Ltql/BRoitRgsZmE2QwsxdZK7AvRY9l2pt9FpvC2Y?=
 =?us-ascii?Q?45T/RP/J7NgAp97P2cDpkdg/Uq8/0GNnLx+6X4RCWwbaDm+EHGDYpSohhI4w?=
 =?us-ascii?Q?fmz0fCRDBmy9ZeYKvZnEko8UhX3fad0V/EOrp6oNEZRAaIL6wG6tHvBLtcrr?=
 =?us-ascii?Q?8N428Z689EawE5fFk85Y1BKkPLAE46LmuueHPZfsKBEK6C6H5jq8nz+08Flt?=
 =?us-ascii?Q?rTJFPGGFrqgQc47NvA/GuHXRvViquWcUpO1n1/mZMnwWnYi7MhgnlYTv9IfQ?=
 =?us-ascii?Q?VFola2lyMJMGzRXVxkBDYCZHbWny7MRMDDXt4Qpf7ZZ3rsVZpKS7GcmW2x97?=
 =?us-ascii?Q?xV9sJs014jLy6Fr8/QkOyLGJE6cM/zlnWWjnnEhs7w6N6E2mP1mmpQNwUpbf?=
 =?us-ascii?Q?ckePjfs3pGVSGFDFfRbvhTI6x2eSMmB+rjJDCOmKdFdSiTk/JRHFebvVX5w2?=
 =?us-ascii?Q?7CT15AKSeBMQXc7CaRMbpWSVLNT+vEMMMqpVdpimgy4xpiNkLWLA0/PvgX4Z?=
 =?us-ascii?Q?3GUO8Z13utFllJM3U5mHDwQ8Uozbh5Myy8xLF8uTPg2CSoYORyMlNoJmnbfN?=
 =?us-ascii?Q?SR3gqxv4mkeWHsJZA8OUk6ox/fpWu2A7eBxyZqEnpeoIAZt3FZD4hCuVld4/?=
 =?us-ascii?Q?5x9YLUMsp2QwYoJKngnpvGGIQskyx+qLma/86G65?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e12da3-b84b-4dbc-6d3b-08dacca278f1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 15:59:01.4545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6f2PsIbI3rrKe8TQnQxM1epjKBmriS2cMNblcgOVx1UEtklgc92PPWWTkl06OV0/XmJ7TWfc9BUkej52AHsAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5410
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 10:14:49AM -0800, Paul E. McKenney wrote:
> > > I have absolutely no argument with this statement, and going back a
> > > long time.  ;-)
> > > 
> > > But the set of systems that caused me to send this turned out to have
> > > real divergence between HPET and TSC, and 40 milliseconds per second of
> > > divergence at that.  So not only do you hate this series, but it is also
> > > the case that this series doesn't help with the problem at hand.
> > 
> > The drift is about 4% which is quite big. It seems that this is
> > either problem of HPET/TSC's hardware/firmware, or the problem of
> > frequency calibration for HPET/TSC. TSC calibration is complex,
> > as it could be done from different methods depending on hardware
> > and firmware, could you share the kernel boot log related with
> > tsc/hpet and clocksource? 
> > 
> > Also if your platform has acpi PM_TIMER, you may try "nohpet"
> > to use PM_TIMER instead of HPET and check if there is also big
> > drift between TSC and PM_TIMER.
> 
> The kernel is built with CONFIG_X86_PM_TIMER=y, so I was guessing
> that there is an ACPI PM_TIMER.  Except that when I booted
> without your "Disable clocksource watchdog for TSC on qualified
> platforms" patch, I get the following:
> 
> [   44.303035] clocksource: timekeeping watchdog on CPU3: Marking clocksource 'tsc-early' as unstable because the skew is too large:
> [   44.347034] clocksource:                       'refined-jiffies' wd_nsec: 503923392 wd_now: fffb73f8 wd_last: fffb7200 mask: ffffffff
> [   44.374034] clocksource:                       'tsc-early' cs_nsec: 588042081 cs_now: 66c486d157 cs_last: 6682125e5e mask: ffffffffffffffff
> [   44.403034] clocksource:                       No current clocksource.
> [   44.418034] tsc: Marking TSC unstable due to clocksource watchdog
 
Aha, we've met similar error (TSC being judged 'unstable' by
'refined-jiffies') before, and our root cause is discussed in [1].
In our case, we had early serial console enabled, which made it
easier to be reproduced.

That was a trigger for us to proposed severl solutions before Thomas
suggested to disable tsc watchdog for all qualified platforms.

[1]. https://lore.kernel.org/lkml/20201126012421.GA92582@shbuild999.sh.intel.com/

> If PM_TIMER was involved, I would expect 'acpi_pm' instead of
> refined-jiffies.  Or am I misinterpreting the output and/or code?

It's about timing. On a typical server platform, the clocksources
init order could be:
  refined-jiffies --> hpet --> tsc-early --> acpi_pm --> tsc 

From your log, TSC('tsc-early') is disabled before 'acpi_pm' get
initialized, so 'acpi_pm' timer (if exist) had no chance to watchdog
the tsc.

> Either way, would it make sense to add CLOCK_SOURCE_MUST_VERIFY to
> clocksource_hpet.flags?

Maybe try below patch, which will skip watchdog for 'tsc-early',
while giving 'acpi_pm' timer a chance to watchdog 'tsc'.

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index cafacb2e58cc..9840f0131764 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1131,8 +1131,7 @@ static struct clocksource clocksource_tsc_early = {
 	.uncertainty_margin	= 32 * NSEC_PER_MSEC,
 	.read			= read_tsc,
 	.mask			= CLOCKSOURCE_MASK(64),
-	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
-				  CLOCK_SOURCE_MUST_VERIFY,
+	.flags			= CLOCK_SOURCE_IS_CONTINUOUS,
 	.vdso_clock_mode	= VDSO_CLOCKMODE_TSC,
 	.enable			= tsc_cs_enable,
 	.resume			= tsc_resume,


> I am sending the full console output off-list.  Hey, you asked for it!  ;-)

Thanks for sharing!

Thanks,
Feng

> 
> 							Thanx, Paul
