Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94C0740582
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjF0VTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjF0VT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:19:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FC5198E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 14:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687900765; x=1719436765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9F6oczZXMEUoLAJfxEwJtk3XCCkCKi/30DZkczd5yX0=;
  b=ZBh3EauGKjv5lsLz3jvHWPIbqoaszNHdUMD4vhoxKn1JXNc57qpWcXYZ
   fSCoV8BCCsdAiwaZ5A0T3KHYJBG4Fj3Qp8eRbzvkeVEHgQPcdGzRPccmM
   NVh+jwOnAqdnhZVxk7OVQ7TiFGi0Z1jybYwFzDahCd8qxT1Z6L3X3H79y
   v0CKUiqfXxvxykSCw4Ec//GHtGL3M911fPIPvxn7xLVbkjogwz3nBknrM
   IauYx8kljUkE8F3PeJ410r4m8ui1awgavjr4HTlD6am7U5+y8+eLdTvIL
   N17TcCffeHS8QrrzW1vjGIfCLsIRuMeBqtfvyUSLeRrbDmH5YoHpQZR9u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="448068758"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="448068758"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 14:19:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="694047086"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="694047086"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Jun 2023 14:19:22 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEG5p-000CHH-1b;
        Tue, 27 Jun 2023 21:19:21 +0000
Date:   Wed, 28 Jun 2023 05:19:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] Sched/fair: Block nohz tick_stop when cfs bandwidth
 in use
Message-ID: <202306280536.Zd5x1Zdv-lkp@intel.com>
References: <20230627191201.344110-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627191201.344110-1-pauld@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/auto-latest]
[also build test WARNING on linus/master v6.4 next-20230627]
[cannot apply to tip/sched/core tip/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Phil-Auld/Sched-fair-Block-nohz-tick_stop-when-cfs-bandwidth-in-use/20230628-031312
base:   tip/auto-latest
patch link:    https://lore.kernel.org/r/20230627191201.344110-1-pauld%40redhat.com
patch subject: [PATCH v2] Sched/fair: Block nohz tick_stop when cfs bandwidth in use
config: nios2-randconfig-r035-20230627 (https://download.01.org/0day-ci/archive/20230628/202306280536.Zd5x1Zdv-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230628/202306280536.Zd5x1Zdv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306280536.Zd5x1Zdv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/sched/fair.c:688:5: warning: no previous prototype for 'sched_update_scaling' [-Wmissing-prototypes]
     688 | int sched_update_scaling(void)
         |     ^~~~~~~~~~~~~~~~~~~~
>> kernel/sched/fair.c:6220:6: warning: no previous prototype for 'sched_cfs_bandwidth_active' [-Wmissing-prototypes]
    6220 | bool sched_cfs_bandwidth_active(struct cfs_rq *cfs_rq)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/sched_cfs_bandwidth_active +6220 kernel/sched/fair.c

  6212	
  6213	static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
  6214	{
  6215		return NULL;
  6216	}
  6217	static inline void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
  6218	static inline void update_runtime_enabled(struct rq *rq) {}
  6219	static inline void unthrottle_offline_cfs_rqs(struct rq *rq) {}
> 6220	bool sched_cfs_bandwidth_active(struct cfs_rq *cfs_rq)
  6221	{
  6222		return false;
  6223	}
  6224	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
