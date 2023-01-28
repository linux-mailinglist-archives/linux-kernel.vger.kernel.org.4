Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B1D67F544
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 07:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjA1Gna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 01:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjA1Gn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 01:43:27 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4159E43937
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 22:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674888205; x=1706424205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LkEXiLb1Y8XFVO0DQ8XQuT26+XWiPJF5DLav8bZYtZg=;
  b=cDkWDpMBldxQV9iDmdT0hhpdenCmAnSpVqRIIPFMeibMuoodyOvz8Q1t
   bRgGPYngtQJ85T/ankeqJWmdpz79cGHIDgeCmxHynh8EjXbR+XGmOZDhb
   l1lCJ5jaqkYY2UXXx3BZ5qNS3ZFJsgtbaWb5rhfiYUXCGr1veGdlnpBHJ
   Ujunl+PhH2ONR7RKOtL2K19hlLEtbTK30scIsTqG9rQP5B5mIaFpoC2WF
   LPmOMcxodqHB+YTUfbTopuv9T44aBUfEnTjpukQRMIbxdvG5qTCz1WtJD
   g8+ceOtlrLiJ/KEV57O07G5LsPy/hfm1/GES0K8tGPRI+e4fC9kSfcX79
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="413490590"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="413490590"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 22:43:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="787441545"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="787441545"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Jan 2023 22:43:20 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLevn-0000Sj-2n;
        Sat, 28 Jan 2023 06:43:19 +0000
Date:   Sat, 28 Jan 2023 14:42:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roman Kagan <rkagan@amazon.de>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/fair: sanitize vruntime of entity being placed
Message-ID: <202301281410.4cvSCADA-lkp@intel.com>
References: <20230127163230.3339408-1-rkagan@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127163230.3339408-1-rkagan@amazon.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DIET_1,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on linus/master v6.2-rc5 next-20230127]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Roman-Kagan/sched-fair-sanitize-vruntime-of-entity-being-placed/20230128-130846
patch link:    https://lore.kernel.org/r/20230127163230.3339408-1-rkagan%40amazon.de
patch subject: [PATCH] sched/fair: sanitize vruntime of entity being placed
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230128/202301281410.4cvSCADA-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2db31a18bcb88c280481672d7721f7e003d8df5a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Roman-Kagan/sched-fair-sanitize-vruntime-of-entity-being-placed/20230128-130846
        git checkout 2db31a18bcb88c280481672d7721f7e003d8df5a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/sched/fair.c:688:5: warning: no previous prototype for 'sched_update_scaling' [-Wmissing-prototypes]
     688 | int sched_update_scaling(void)
         |     ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c: In function 'place_entity':
>> kernel/sched/fair.c:4697:34: warning: integer overflow in expression of type 'long int' results in '-129542144' [-Woverflow]
    4697 |         if ((s64)sleep_time > 60 * NSEC_PER_SEC)
         |                                  ^


vim +4697 kernel/sched/fair.c

  4654	
  4655	static void
  4656	place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
  4657	{
  4658		u64 vruntime = cfs_rq->min_vruntime;
  4659		u64 sleep_time;
  4660	
  4661		/*
  4662		 * The 'current' period is already promised to the current tasks,
  4663		 * however the extra weight of the new task will slow them down a
  4664		 * little, place the new task so that it fits in the slot that
  4665		 * stays open at the end.
  4666		 */
  4667		if (initial && sched_feat(START_DEBIT))
  4668			vruntime += sched_vslice(cfs_rq, se);
  4669	
  4670		/* sleeps up to a single latency don't count. */
  4671		if (!initial) {
  4672			unsigned long thresh;
  4673	
  4674			if (se_is_idle(se))
  4675				thresh = sysctl_sched_min_granularity;
  4676			else
  4677				thresh = sysctl_sched_latency;
  4678	
  4679			/*
  4680			 * Halve their sleep time's effect, to allow
  4681			 * for a gentler effect of sleepers:
  4682			 */
  4683			if (sched_feat(GENTLE_FAIR_SLEEPERS))
  4684				thresh >>= 1;
  4685	
  4686			vruntime -= thresh;
  4687		}
  4688	
  4689		/*
  4690		 * Pull vruntime of the entity being placed to the base level of
  4691		 * cfs_rq, to prevent boosting it if placed backwards.  If the entity
  4692		 * slept for a long time, don't even try to compare its vruntime with
  4693		 * the base as it may be too far off and the comparison may get
  4694		 * inversed due to s64 overflow.
  4695		 */
  4696		sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> 4697		if ((s64)sleep_time > 60 * NSEC_PER_SEC)
  4698			se->vruntime = vruntime;
  4699		else
  4700			se->vruntime = max_vruntime(se->vruntime, vruntime);
  4701	}
  4702	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
