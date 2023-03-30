Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D266D0C12
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjC3Q7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjC3Q7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:59:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8991D729F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680195557; x=1711731557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A3swVtIESmOhzKOGg7B046CX41e8Q+Fc20bjH7hHWTg=;
  b=VKDzSSjLfOcDANVL5B1vWczVvzlB/YBo1aTjtR3LOoxRC7QqFfF9Wi8Y
   zy7hLe1AyGba8p+lGSBZq91p6BHUrtjTH3NHqijcOBiIrZBXewD0v2mdG
   fIWMshSOSBByTT/azKAOTkQYvjLOL5EoyHNppjmRe1nfi9JVsJSJfBa+5
   FQJadXpf9ygRnmoVdox7laQSQHapGeB2onqYvASvzBqWQer38tA+lMcQj
   waQZ8Xk+wPOlnO6AfDcUpXllL+pHtZPr5SAdiYWznIlXOLNCKS3w96A46
   qkCa+chCPCKOL3NR4cy8bZCiygf9XFL6Y0bp7fE2iOr/ruQOy/uJkgzna
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="339952105"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="339952105"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 09:59:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="715078940"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="715078940"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Mar 2023 09:59:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phvc5-000L1i-2e;
        Thu, 30 Mar 2023 16:59:01 +0000
Date:   Fri, 31 Mar 2023 00:58:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        chenzhongjin@huawei.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rmk+kernel@armlinux.org.uk, geert@linux-m68k.org,
        keescook@chromium.org
Subject: Re: [PATCH] wchan: Fix get_wchan() when task in schedule
Message-ID: <202303310019.uMAqiUA4-lkp@intel.com>
References: <20230330121238.176534-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330121238.176534-1-chenzhongjin@huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on linus/master v6.3-rc4 next-20230330]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Zhongjin/wchan-Fix-get_wchan-when-task-in-schedule/20230330-201555
patch link:    https://lore.kernel.org/r/20230330121238.176534-1-chenzhongjin%40huawei.com
patch subject: [PATCH] wchan: Fix get_wchan() when task in schedule
config: mips-randconfig-r006-20230329 (https://download.01.org/0day-ci/archive/20230331/202303310019.uMAqiUA4-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/d5fd727a071ab3c2241f858e77c2ae5bb3cec6f3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chen-Zhongjin/wchan-Fix-get_wchan-when-task-in-schedule/20230330-201555
        git checkout d5fd727a071ab3c2241f858e77c2ae5bb3cec6f3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303310019.uMAqiUA4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/sched/core.c:2060:23: error: no member named 'on_cpu' in 'struct task_struct'
               !p->on_rq && !p->on_cpu)
                             ~  ^
   1 error generated.


vim +2060 kernel/sched/core.c

  2046	
  2047	unsigned long get_wchan(struct task_struct *p)
  2048	{
  2049		unsigned long ip = 0;
  2050		unsigned int state;
  2051	
  2052		if (!p || p == current)
  2053			return 0;
  2054	
  2055		/* Only get wchan if task is blocked and we can keep it that way. */
  2056		raw_spin_lock_irq(&p->pi_lock);
  2057		state = READ_ONCE(p->__state);
  2058		smp_rmb(); /* see try_to_wake_up() */
  2059		if (state != TASK_RUNNING && state != TASK_WAKING &&
> 2060		    !p->on_rq && !p->on_cpu)
  2061			ip = __get_wchan(p);
  2062		raw_spin_unlock_irq(&p->pi_lock);
  2063	
  2064		return ip;
  2065	}
  2066	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
