Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC0F64514E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 02:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLGBj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 20:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLGBj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 20:39:56 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753D72B632
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 17:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670377195; x=1701913195;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=g8I8+hQvGwJYiUfQdCPtlqhGyFLgIzvKIsyHtMSLrQ0=;
  b=Q7lgKsoMZddt4Jg/SVdjDQU2HBe4xnToDuLj13bbFrhT4qOxlMT51Q3D
   6zUhH3NCjsggLUgbSUpcz66y40cHS+JDXdTg9/OMmlRXk2I25Hyvo42JS
   BC3L1xdqCrZKb8BMdcQFu+tqsFDmLqb6lbE5cvNSpohZrUJRNZEUMF5yG
   ahHKwvfCSxmE9Wi68spHWMnIxvBbxi17a2lxh7TlPoooCORd55r4poxID
   HSz/RgRW9jyOSJStSNaCYl1xIPAIsiWOnKd5lOJojKxcNgliKHCHt0W02
   R8ozafR1xpmXjANyePx1rXiGcWBdynlrZZGm5tjKjRnwp+4kwTVXUO0gn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="300197579"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="300197579"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 17:39:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="709884705"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="709884705"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 06 Dec 2022 17:39:54 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 6 Dec 2022 17:39:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 6 Dec 2022 17:39:53 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 6 Dec 2022 17:39:53 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 6 Dec 2022 17:39:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/76R0ct3wE+9DvFtrjrAsHQ4r1G/eZCB5lFFvZTapMO+oudZJljE2+o6ffJiR/erTw5sxkEecBbwbGyN1rt5vxvaBObHi+uvlHmUB0Mq/PW4n5hzvr/gzZdSu4LNvd7OeJS/jZhSqGMD43/eu6d2zCwH4nCmC4wUen2SCDalgsEK/UpC5k2qPKAxFvxl65oUttf82uI8emEZg8uinRc5sl4lHKhOrTlq0Ww/h/QsEdqOSjvBDlSf90bHP87Wzq5DAUUPYDqvcsGoLtbPFy5rSlLn8OhE4g7P8BTrtd4fbfmbvRfsvuAnd3nRWEzN2J0+UP0tY1aMC+eh8swaseFyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bi1yOCqUME57ULuQiSgFcJ5Lox+7nwo78EITbuJBQZ4=;
 b=QaH5eEbv692LU3wzWdATNrUGN86FpBs3m7w1V2WIW6swpqaikSoSxOAuLNnRjv9OqMfGDem8dsymE/24mfsNq4iPxsz7NpCj8gHDRSSlC44vsWSNnW847OpWZjyPi1H/yT8kOFDUWoAcgj/MBTq+ygMJ7GsYCDPoM5iwqhdEhjLbaPOBJrGR0F7SEPCx4gqEF2jt43zloQjwqwGcakw/Hb4tTEMQ4cIUNvtLH5JrpIEpgEwCWkTZqUGo5OMmffH57qfR0W41JGbJpC7Vy2dEcZWInhnQUEHc8U9rfpQnrkDMIpX7PRWynIiEV+uviMMFroT3mElKY8eKBXERRimDOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 01:39:50 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::15c8:6dea:24bb:b4c8]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::15c8:6dea:24bb:b4c8%8]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 01:39:50 +0000
Date:   Wed, 7 Dec 2022 09:39:43 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [linus:master] [rcutorture]  a5c095e0e9:
 WARNING:suspicious_RCU_usage
Message-ID: <Y4/u3wO7gdqhv4K8@xsang-OptiPlex-9020>
References: <202212032149.66b0c23b-oliver.sang@intel.com>
 <20221203185654.GQ4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221203185654.GQ4001@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA2PR11MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e6b708-1825-4e15-72c2-08dad7f3ee44
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zkLbcMY2lBmNfizWZ4LfkGEfvWxhdTtuoRMEeb49DeQhn0KbhKNHnRiLtIQzKuMEjTh8qbHEg3B0O5FzwgBJbgJO6w0W1S91eWgnl15DekYZUj3bNmoezvS9b5sTFz+RbAOYk6PgmSyxzlXt7zIrgtLK//aLO1+aeTeKVKqSlxbome2VF+6w+4k+KqW3FgnJxPEcZRoKuyESIlMFrW/mGgDs+1jzJdgBlfpJagIWysB6wbY1F0UReK5iKl0niB/u3BeuCjGZ4JajTj+3m+Uc+vB3hjpmVIAaYWA4rIEY7FLrs3CtJE49T7je1CFRhO3JQ0A5R3G3NxnoX5vhojrSwdpK4wyq5NZdJFTam6HYg3Hv06NjN1eV2vgVLiNKX8gkLzEvr9T22+Zw/uhBxyfZ0kaRnYnc7HjD0M1dQwStg9jVPFsaNu/kx0q3rt2mK4xhoyi4+nlGuzzeoufArlKEJgW2ewtJIscKaNNgsuOSe5XrQlgq1InNGiu6DIkxn0UfxB7hlXG9GPHduGoVwUQcwjTj08n2hrwYIMCyzBj0JG/3KvTjzc0j0uE61BOdwHA5+SqZpL5Z9rRpwXpJQtatugqJ8ZJRDCSDsvfLaXy5Sycd51JlLiEDDCMIvILzwaEv4eDG95OPDcWnCyfmNcfU07+t28GEFDDuV3/ucZBW0Fg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199015)(2906002)(83380400001)(66946007)(41300700001)(186003)(86362001)(66556008)(33716001)(38100700002)(6512007)(26005)(9686003)(82960400001)(4326008)(8936002)(66476007)(44832011)(966005)(8676002)(316002)(6916009)(478600001)(6666004)(6486002)(6506007)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jspnZmfJdk+ipJIY5R3hlRG2axZWvLlN9uoNXhyrP78UY0XjtYLoI4ruMTqB?=
 =?us-ascii?Q?B140cadTstpidUQGZgx8KnOAIGGXN8KBe99MFCCgTIotOthI8AawEW45Msk8?=
 =?us-ascii?Q?H2/Jg1J5unvWo7lGf/tEMbn1RKaAyyaWujXSWmz3imrRbiK5Z3Cph/y4fNbf?=
 =?us-ascii?Q?DVpJ3wJwWVJ7hAkyZTA2eugu5Ov1ioxoqxQO+NFJ4F33SnyqH09NITGL8Czc?=
 =?us-ascii?Q?vsF3h20rHexFMdvV4ZxI5CAfoiT6xMeRrgcAZUcLkBILICu3WCIKa9RFbECa?=
 =?us-ascii?Q?6f1VIgCpL1neL1+ZUQFVWn/3mJfGDvFIcPdOqtalWXEKq7jBAT3pjjnFy53E?=
 =?us-ascii?Q?jq3KXht+WUVUCbURhaF+uRiJt/B+h5HVsqFYhqh7v0K/gNhR4UFgkFRE4UH5?=
 =?us-ascii?Q?LEkBIFkLDfbL1+blmOuPhiuIoBKhaW3XamipS9BMUWnkB5eV7HhYwE0ZUwUA?=
 =?us-ascii?Q?AxlxYZoewfLZ15VCJc+3Zebi5ZQ3dDuNQKLhJzGP/REiQsJTBaboUjkCrI3w?=
 =?us-ascii?Q?cGUkAa4eh554DC6bsz/O65UXG9XIyg6GLB67kuLuxSE40NiSx1aRun6pVwJo?=
 =?us-ascii?Q?pOt3fkRWGnOf0gcsNaJu78aGpKPlmcy25Ofn+B0sXu7MAaST2sbk891Flo4q?=
 =?us-ascii?Q?WCxu4QRJqGDSk7i0gTPOmU0xxsnx+ddabTp2zjt0i0ZDi3glLQCGxt9DkZxT?=
 =?us-ascii?Q?tUosjkfWtTaK/z5jSZysilyC/Q96/VU425MbshWjLX7KRmLTDxdEukDHUu2b?=
 =?us-ascii?Q?3FOiTEPhmPdOaGARJN4pkqR/R4RiD40w2y9jLi755B9DbklBF+fG9mpQSUcc?=
 =?us-ascii?Q?f+YE2hu41+YxuwgsqHb04OOCG+6zkkGqLMRXPr0RKijC3eL4pshHwRudcJem?=
 =?us-ascii?Q?2QqO6HF79n8NThR2i/pXstUKvG+daETwuIVHlei+/sXutuRPHUqamlhar8cl?=
 =?us-ascii?Q?SwkdmV2gtcL9PoYBip60FJWvNhs8I6L2o8otyg82lp3Ivi6UX/j423tCcFhY?=
 =?us-ascii?Q?Dvx4kCqdehSC64OiFGIZ5F6X7vO6P0iGTjSqn575z6gIsoxx11QHrGI8970v?=
 =?us-ascii?Q?U0agFTiAgZwB5SOZkonZSm61txo5uUpLzgwkrRAeQxg3Ac5N95VtUE0HPljp?=
 =?us-ascii?Q?6wyo2ACgz/FtCDC1SFVyjCIWRy7bGNrRO7JGa8LhebhIDh18q2XCpoezeA5O?=
 =?us-ascii?Q?vRUODbPbN9mTXJCIZt+tkXvANrhYE9TFalVQ5bBy5MDevvYoJ08bn+bu6jhp?=
 =?us-ascii?Q?S0DurSmrhygUWLNMdRINC8+jOw9x88XDBjuJt+1M4sxOf0YCgu0RUZZ+FXBm?=
 =?us-ascii?Q?JnIB4+6t6WcKZCtZh5ggXA63lR6B1qZEaRgj13L0OpN5mMmv+RoRVwoKwVqM?=
 =?us-ascii?Q?sv3AfaZaOeBUwE4X9F8V8vpS+iLcxaMQ7OxNpH55P5OI1CNM2ExLZs19XXMz?=
 =?us-ascii?Q?Zk3yoHvz9NjwfR2anLz2Z66+49L2sh6t4tpLes+ePk1sRvAu5uv+QyL29Eaa?=
 =?us-ascii?Q?IiVgBcveInEWxS48dBHe/wOkrpvZGkogrb82W4Uj6Zts/3tofe2BXs7ey0Yz?=
 =?us-ascii?Q?jhHrVoTKC/7nttAJodWZ1ujrG4YasopbzDyQo3X2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e6b708-1825-4e15-72c2-08dad7f3ee44
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 01:39:50.3490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNMdl4+0a+i1QA/kXFRBJfzCVJNPCl9B9ucntJCMSRRJ/kjINXjfzcXXn7Bz32AWBjLRV2gI8HmKsVRHCYywog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5082
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Sat, Dec 03, 2022 at 10:56:54AM -0800, Paul E. McKenney wrote:
> On Sat, Dec 03, 2022 at 10:47:47PM +0800, kernel test robot wrote:
> > 
> > Greeting,
> > 
> > FYI, we noticed WARNING:suspicious_RCU_usage due to commit (built with gcc-11):
> > 
> > commit: a5c095e0e9b6fedcffd0907c84f77751128e2a34 ("rcutorture: Abstract read-lock-held checks")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > in testcase: rcutorture
> 
> This is expected behavior!

Thanks a lot for detailed guidance as below!

> 
> Your dmesg contains "busted_srcud-torture: rcu_torture_reader task started",
> which indicates that you are testing with "busted_srcud".  Searching
> for the string "busted_srcud" (with quotes) gets us this:
> 
> /* As above, but broken due to inappropriate reader extension. */
> static struct rcu_torture_ops busted_srcud_ops = {
> 	.ttype		= SRCU_FLAVOR,
> 	.init		= srcu_torture_init,
> 	.cleanup	= srcu_torture_cleanup,
> 	.readlock	= srcu_torture_read_lock,
> 	.read_delay	= rcu_read_delay,
> 	.readunlock	= srcu_torture_read_unlock,
> 	.readlock_held	= torture_srcu_read_lock_held,
> 	.get_gp_seq	= srcu_torture_completed,
> 	.deferred_free	= srcu_torture_deferred_free,
> 	.sync		= srcu_torture_synchronize,
> 	.exp_sync	= srcu_torture_synchronize_expedited,
> 	.call		= srcu_torture_call,
> 	.cb_barrier	= srcu_torture_barrier,
> 	.stats		= srcu_torture_stats,
> 	.irq_capable	= 1,
> 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
> 	.extendables	= RCUTORTURE_MAX_EXTEND,
> 	.name		= "busted_srcud"
> };
> 
> That comment says it all.  The point of this test is to make sure that
> rcutorture really does group differeent types of readers together
> when asked.  Since we have torture_srcu_read_lock_held(), we expect
> rcutorture to complain when the reader uses one of the non-SRCU readers,
> such as preemption being disabled.
> 
> So the complaint you got was an indication that rcutorture really will
> complain when as it should when a given RCU flavor's read-side protection
> is broken.
> 
> 							Thanx, Paul
> 
> > [  154.593443][  T500] WARNING: suspicious RCU usage
> > [  154.594126][  T500] 5.13.0-rc1-00008-ga5c095e0e9b6 #1 Not tainted
> > [  154.594990][  T500] -----------------------------
> > [  154.595665][  T500] kernel/rcu/rcutorture.c:1568 suspicious rcu_dereference_check() usage!
> > [  154.596944][  T500]
> > [  154.596944][  T500] other info that might help us debug this:
> > [  154.596944][  T500]
> > [  154.598385][  T500]
> > [  154.598385][  T500] rcu_scheduler_active = 2, debug_locks = 1
> > [  154.599595][  T500] no locks held by rcu_torture_rea/500.
> > [  154.601317][  T500]
> > [  154.601317][  T500] stack backtrace:
> > [  154.602154][  T500] CPU: 1 PID: 500 Comm: rcu_torture_rea Not tainted 5.13.0-rc1-00008-ga5c095e0e9b6 #1
> > [  154.603441][  T500] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> > [  154.604909][  T500] Call Trace:
> > [ 154.605402][ T500] ? dump_stack (??:?) 
> > [ 154.606122][ T500] ? lockdep_rcu_suspicious (??:?) 
> > [ 154.606892][ T500] ? rcu_torture_one_read (rcutorture.c:?) rcutorture
> > [ 154.607813][ T500] ? rcutorture_loop_extend (rcutorture.c:?) rcutorture
> > [ 154.608764][ T500] ? __mod_timer (timer.c:?) 
> > [ 154.609578][ T500] ? do_init_timer (timer.c:?) 
> > [ 154.610282][ T500] ? rcu_torture_reader (rcutorture.c:?) rcutorture
> > [ 154.611202][ T500] ? rcu_torture_read_exit_child (rcutorture.c:?) rcutorture
> > [ 154.612204][ T500] ? __kasan_check_read (??:?) 
> > [ 154.612974][ T500] ? rcu_torture_reader (rcutorture.c:?) rcutorture
> > [ 154.613950][ T500] ? __kasan_check_read (??:?) 
> > [ 154.614673][ T500] ? test_bit (main.c:?) 
> > [ 154.615332][ T500] ? __kthread_parkme (kthread.c:?) 
> > [ 154.616059][ T500] ? kthread (kthread.c:?) 
> > [ 154.616640][ T500] ? rcu_torture_read_exit_child (rcutorture.c:?) rcutorture
> > [ 154.617642][ T500] ? kzalloc (resource.c:?) 
> > [ 154.618361][ T500] ? ret_from_fork (??:?) 
> > [  154.627467][  T483] busted_srcud-torture: Creating torture_shuffle task
> > [  154.629419][  T502] busted_srcud-torture: rcu_torture_stats task started
> > [  154.640374][  T483] busted_srcud-torture: Creating torture_stutter task
> > [  154.644728][  T504] busted_srcud-torture: torture_shuffle task started
> > [  154.645963][  T483] busted_srcud-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
> > [  154.647399][  T483] busted_srcud-torture: Creating rcu_torture_read_exit task
> > [  154.649698][  T505] busted_srcud-torture: torture_stutter task started
> > [ 154.660318][ T483] initcall rcu_torture_init+0x0/0x2b83 [rcutorture] returned 0 after 472073 usecs 
> > [  154.679808][  T507] busted_srcud-torture: rcu_torture_read_exit: Start of test
> > [  160.204160][  T507] busted_srcud-torture: rcu_torture_read_exit: End of episode
> > [  173.852307][  T507] busted_srcud-torture: rcu_torture_read_exit: Start of episode
> > 
> > 
