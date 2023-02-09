Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD09690C34
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjBIOvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjBIOvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:51:51 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E2E170C;
        Thu,  9 Feb 2023 06:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675954306; x=1707490306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QT90vOr/r30zf6GJZ359ruAU9KZMp1cmqnLWwFOqYdc=;
  b=S9Z4m2L9n+hkboCMXP6pvxytpNXaFNbZh5jogvV+tTYFjp/k9Jd8OC38
   BU/ASQ0wbGVQ0NjlQz5M+qEdrs8ickst4kiynaN7dpySLlP/0AkRr8bGu
   k+kgdWwQ0lQGyPb09BDMpXxFU2CWqw3UJYU3L5o4uXQpze1kl6iECR5WZ
   UwZWn+DzWcylWKpE25Bs2rTWVV/8IM9Cjh5hKFGJupt3zlvVLs1TWVEXd
   cfDiYTNXHUwfrXgCjn9MS19jtevpEOCSiccwDZ+NSgh7jwSH8s8aG55+/
   rSpFtFsNvIFgi20BMnIYsMj3yUZyLQZU/8k/5WMIQLb7oktO5ZRLsci/h
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="310479068"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="310479068"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 06:51:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="736379244"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="736379244"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 Feb 2023 06:51:44 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQ8H1-00057e-1D;
        Thu, 09 Feb 2023 14:51:43 +0000
Date:   Thu, 9 Feb 2023 22:51:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zqiang <qiang1.zhang@intel.com>, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, qiuxu.zhuo@intel.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Keeping rcu-related kthreads running on
 housekeeping CPUS
Message-ID: <202302092209.AYjmQ4Id-lkp@intel.com>
References: <20230209102730.974465-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209102730.974465-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zqiang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on paulmck-rcu/dev]
[also build test WARNING on next-20230209]
[cannot apply to linus/master v6.2-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zqiang/rcu-Keeping-rcu-related-kthreads-running-on-housekeeping-CPUS/20230209-182311
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
patch link:    https://lore.kernel.org/r/20230209102730.974465-1-qiang1.zhang%40intel.com
patch subject: [PATCH v2] rcu: Keeping rcu-related kthreads running on housekeeping CPUS
config: riscv-randconfig-r016-20230209 (https://download.01.org/0day-ci/archive/20230209/202302092209.AYjmQ4Id-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db0e6591612b53910a1b366863348bdb9d7d2fb1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/af15a3ade363b21d823918088623f8564cbd9d08
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zqiang/rcu-Keeping-rcu-related-kthreads-running-on-housekeeping-CPUS/20230209-182311
        git checkout af15a3ade363b21d823918088623f8564cbd9d08
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302092209.AYjmQ4Id-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/torture.c:40:
>> kernel/rcu/rcu.h:509:6: warning: no previous prototype for function 'rcu_tasks_generic_setaffinity' [-Wmissing-prototypes]
   void rcu_tasks_generic_setaffinity(int cpu) {}
        ^
   kernel/rcu/rcu.h:509:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void rcu_tasks_generic_setaffinity(int cpu) {}
   ^
   static 
   1 warning generated.


vim +/rcu_tasks_generic_setaffinity +509 kernel/rcu/rcu.h

   484	
   485	#ifdef CONFIG_TINY_RCU
   486	/* Tiny RCU doesn't expedite, as its purpose in life is instead to be tiny. */
   487	static inline bool rcu_gp_is_normal(void) { return true; }
   488	static inline bool rcu_gp_is_expedited(void) { return false; }
   489	static inline bool rcu_async_should_hurry(void) { return false; }
   490	static inline void rcu_expedite_gp(void) { }
   491	static inline void rcu_unexpedite_gp(void) { }
   492	static inline void rcu_async_hurry(void) { }
   493	static inline void rcu_async_relax(void) { }
   494	static inline void rcu_request_urgent_qs_task(struct task_struct *t) { }
   495	#else /* #ifdef CONFIG_TINY_RCU */
   496	bool rcu_gp_is_normal(void);     /* Internal RCU use. */
   497	bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
   498	bool rcu_async_should_hurry(void);  /* Internal RCU use. */
   499	void rcu_expedite_gp(void);
   500	void rcu_unexpedite_gp(void);
   501	void rcu_async_hurry(void);
   502	void rcu_async_relax(void);
   503	void rcupdate_announce_bootup_oddness(void);
   504	#ifdef CONFIG_TASKS_RCU_GENERIC
   505	void show_rcu_tasks_gp_kthreads(void);
   506	void rcu_tasks_generic_setaffinity(int cpu);
   507	#else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
   508	static inline void show_rcu_tasks_gp_kthreads(void) {}
 > 509	void rcu_tasks_generic_setaffinity(int cpu) {}
   510	#endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
   511	void rcu_request_urgent_qs_task(struct task_struct *t);
   512	#endif /* #else #ifdef CONFIG_TINY_RCU */
   513	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
