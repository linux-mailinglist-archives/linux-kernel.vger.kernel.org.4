Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69CD6F00B4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 08:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242976AbjD0GRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 02:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjD0GRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 02:17:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071B62D5F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 23:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682576239; x=1714112239;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X4xALLeuKezzkjHciVAGEW91ZngNLlyIGAdgHX2Wcmc=;
  b=dDhMCQUTVh0gA9eWogkZwsQHwz6qybWKd9bnX7fHqIDXkZPzX1pRf1U6
   rYk6pohDKk3v9xEh7nbJhOu/y3+V74nvQTUWCqeT/m5glBnmdTxXt8TFk
   NNlSI2Ep/UNGodK8V8wRMdVQxb3Fqk89g+twpTg287oXZtzr8vXH8cdWE
   qGyfM5MRrJOwPx03l7jSTxEnvJ0lSEzGV+dqaPY4TFyQOzsHuaUO7CcSl
   1CiPhKCua47Bb2cBgoOLMuQHelPTa+2Xp2azJ+ngIRSGOlQnqHd6HZFGM
   drdO15EL1QKg21a/dtbdEGgwY6tfhSYe5/Fcu5ROC9UvEcbiNFLgRwWy2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="350175973"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="350175973"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 23:17:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="818400091"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="818400091"
Received: from lkp-server01.sh.intel.com (HELO 1e0e07564161) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Apr 2023 23:17:14 -0700
Received: from kbuild by 1e0e07564161 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pruwL-00002j-0k;
        Thu, 27 Apr 2023 06:17:13 +0000
Date:   Thu, 27 Apr 2023 14:16:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [paulmck-rcu:dev.2023.04.26a 35/51]
 arch/powerpc/kernel/smp.c:1768:1: error: function declared 'noreturn' should
 not return
Message-ID: <202304271416.DjRKPeoJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.04.26a
head:   56b38a90a12f76e463a7381d8cff854926fa2b59
commit: 2b927bfdda366c1719e021cd0e9688baf933c9cf [35/51] objtool: Fix for unreachable instruction warning
config: powerpc-buildonly-randconfig-r003-20230427 (https://download.01.org/0day-ci/archive/20230427/202304271416.DjRKPeoJ-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=2b927bfdda366c1719e021cd0e9688baf933c9cf
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu dev.2023.04.26a
        git checkout 2b927bfdda366c1719e021cd0e9688baf933c9cf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304271416.DjRKPeoJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/powerpc/kernel/smp.c:1768:1: error: function declared 'noreturn' should not return [-Werror,-Winvalid-noreturn]
   }
   ^
   1 error generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for HOTPLUG_CPU
   Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
   Selected by [y]:
   - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=y] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]


vim +/noreturn +1768 arch/powerpc/kernel/smp.c

d0174c721900ff Nathan Fontenot        2010-01-14  1754  
1ea21ba231f248 Michael Ellerman       2020-08-19  1755  void arch_cpu_idle_dead(void)
1ea21ba231f248 Michael Ellerman       2020-08-19  1756  {
424ef0160f439f Naveen N. Rao          2018-04-19  1757  	/*
424ef0160f439f Naveen N. Rao          2018-04-19  1758  	 * Disable on the down path. This will be re-enabled by
424ef0160f439f Naveen N. Rao          2018-04-19  1759  	 * start_secondary() via start_secondary_resume() below
424ef0160f439f Naveen N. Rao          2018-04-19  1760  	 */
424ef0160f439f Naveen N. Rao          2018-04-19  1761  	this_cpu_disable_ftrace();
424ef0160f439f Naveen N. Rao          2018-04-19  1762  
39f87561454dc3 Michael Ellerman       2020-08-19  1763  	if (smp_ops->cpu_offline_self)
39f87561454dc3 Michael Ellerman       2020-08-19  1764  		smp_ops->cpu_offline_self();
fa3f82c8bb7acb Benjamin Herrenschmidt 2011-02-10  1765  
fa3f82c8bb7acb Benjamin Herrenschmidt 2011-02-10  1766  	/* If we return, we re-enter start_secondary */
fa3f82c8bb7acb Benjamin Herrenschmidt 2011-02-10  1767  	start_secondary_resume();
abb17f9c3a92c5 Milton Miller          2010-05-19 @1768  }
fa3f82c8bb7acb Benjamin Herrenschmidt 2011-02-10  1769  

:::::: The code at line 1768 was first introduced by commit
:::::: abb17f9c3a92c5acf30e749efdf0419b7f50a5b8 powerpc: Use common cpu_die (fixes SMP+SUSPEND build)

:::::: TO: Milton Miller <miltonm@bga.com>
:::::: CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
