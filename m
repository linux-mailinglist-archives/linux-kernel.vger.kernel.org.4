Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62396BF50A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCQWXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjCQWX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:23:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D713D521C7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 15:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679091805; x=1710627805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CxoqtRpgIYa299cxTvwVvIrPSLBWaBzvtQOQGfPiu+g=;
  b=NvTKMOSkQfjGRvWK86Yh2wg/4MMfDJYhYjcLATyAqJ5RTpnsV+hRgWZq
   dRqVhX4wqCMnmdsdjBfcxIjE3QZ5MFSNdyjxgz41XBTCmjz6NEBu79feo
   K5hNCwuxLWFI+VUGB65LUtMH8uNLTpGpnrxCMaPIZglV0lyAE56mQfgKW
   XT8QCosNZqE85hIWIZdss5hweWY/E0+hB6WuWdFpZq7pDHWhnqwf0ibq2
   T4LPuMpFzF62Sw921luPgnQgqGzveM1Rodx9LuCqI+CMlq2SFykTGSoZN
   zDamjoerb0BBSoerSnz81nYHtj7TSbkdTwmp1yYfD71eigcUD1sEjXfsV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="340730375"
X-IronPort-AV: E=Sophos;i="5.98,270,1673942400"; 
   d="scan'208";a="340730375"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 15:23:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="680434769"
X-IronPort-AV: E=Sophos;i="5.98,270,1673942400"; 
   d="scan'208";a="680434769"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 17 Mar 2023 15:23:21 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdITo-0009bs-2K;
        Fri, 17 Mar 2023 22:23:20 +0000
Date:   Sat, 18 Mar 2023 06:22:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leobras@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 2/2] memcg: do not drain charge pcp caches on remote
 isolated cpus
Message-ID: <202303180617.7E3aIlHf-lkp@intel.com>
References: <20230317134448.11082-3-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317134448.11082-3-mhocko@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

I love your patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.3-rc2 next-20230317]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Hocko/sched-isolation-Add-cpu_is_isolated-API/20230317-214621
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230317134448.11082-3-mhocko%40kernel.org
patch subject: [PATCH 2/2] memcg: do not drain charge pcp caches on remote isolated cpus
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20230318/202303180617.7E3aIlHf-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/b376cfcf40a43276e1280950bb926fdf3521940a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Michal-Hocko/sched-isolation-Add-cpu_is_isolated-API/20230317-214621
        git checkout b376cfcf40a43276e1280950bb926fdf3521940a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303180617.7E3aIlHf-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/memcontrol.c: In function 'drain_all_stock':
>> mm/memcontrol.c:2369:35: error: implicit declaration of function 'cpu_is_isolated' [-Werror=implicit-function-declaration]
    2369 |                         else if (!cpu_is_isolated(cpu))
         |                                   ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/cpu_is_isolated +2369 mm/memcontrol.c

  2331	
  2332	/*
  2333	 * Drains all per-CPU charge caches for given root_memcg resp. subtree
  2334	 * of the hierarchy under it.
  2335	 */
  2336	static void drain_all_stock(struct mem_cgroup *root_memcg)
  2337	{
  2338		int cpu, curcpu;
  2339	
  2340		/* If someone's already draining, avoid adding running more workers. */
  2341		if (!mutex_trylock(&percpu_charge_mutex))
  2342			return;
  2343		/*
  2344		 * Notify other cpus that system-wide "drain" is running
  2345		 * We do not care about races with the cpu hotplug because cpu down
  2346		 * as well as workers from this path always operate on the local
  2347		 * per-cpu data. CPU up doesn't touch memcg_stock at all.
  2348		 */
  2349		migrate_disable();
  2350		curcpu = smp_processor_id();
  2351		for_each_online_cpu(cpu) {
  2352			struct memcg_stock_pcp *stock = &per_cpu(memcg_stock, cpu);
  2353			struct mem_cgroup *memcg;
  2354			bool flush = false;
  2355	
  2356			rcu_read_lock();
  2357			memcg = stock->cached;
  2358			if (memcg && stock->nr_pages &&
  2359			    mem_cgroup_is_descendant(memcg, root_memcg))
  2360				flush = true;
  2361			else if (obj_stock_flush_required(stock, root_memcg))
  2362				flush = true;
  2363			rcu_read_unlock();
  2364	
  2365			if (flush &&
  2366			    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
  2367				if (cpu == curcpu)
  2368					drain_local_stock(&stock->work);
> 2369				else if (!cpu_is_isolated(cpu))
  2370					schedule_work_on(cpu, &stock->work);
  2371			}
  2372		}
  2373		migrate_enable();
  2374		mutex_unlock(&percpu_charge_mutex);
  2375	}
  2376	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
