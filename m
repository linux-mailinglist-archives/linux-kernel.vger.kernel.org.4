Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A9B6D07C2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjC3OMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjC3OMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:12:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA597AB0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680185521; x=1711721521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GhT/t7TxVKI6UXGLx3M833XEBT9MVcJzOZvQtUqQUgM=;
  b=M5EKqsDOsaFRHj2UTKfS3sVzTt1R9hi750iQAeMjwXp0w77h6SG9mGLr
   3aPuIJhmKxvRaA7pyDCaTr5Iwg/m0F+Ifd7vtpKkQRfJxagWEpASmODJu
   akc068MkNN8FY/SJNFsFyxCUORkldXTwcPsbkNW1+4kV/Qf7ieZOMJ4Tb
   Lxm50aZIgGiCJpwVpc7YGvRIlcDBdv7W4iRIlUVzSxbrMSFWeHfxClGMd
   DIwGOwiUzWtwlzx84L5mn9eWxxghzIt0T8RcNFubXSn/zVtQrODDwpown
   SBWOZQPsH9DDERomz+crwuvzTZNwT89CxjAEjtjDSMAhGOZPIyfenpC48
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="343651416"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="343651416"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 06:54:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="828343453"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="828343453"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 30 Mar 2023 06:53:56 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phsix-000Kts-3D;
        Thu, 30 Mar 2023 13:53:55 +0000
Date:   Thu, 30 Mar 2023 21:53:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, chenzhongjin@huawei.com,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        rmk+kernel@armlinux.org.uk, geert@linux-m68k.org,
        keescook@chromium.org
Subject: Re: [PATCH] wchan: Fix get_wchan() when task in schedule
Message-ID: <202303302125.7Ku9P7v5-lkp@intel.com>
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
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230330/202303302125.7Ku9P7v5-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d5fd727a071ab3c2241f858e77c2ae5bb3cec6f3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chen-Zhongjin/wchan-Fix-get_wchan-when-task-in-schedule/20230330-201555
        git checkout d5fd727a071ab3c2241f858e77c2ae5bb3cec6f3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303302125.7Ku9P7v5-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/sched/core.c: In function 'get_wchan':
>> kernel/sched/core.c:2060:28: error: 'struct task_struct' has no member named 'on_cpu'
    2060 |             !p->on_rq && !p->on_cpu)
         |                            ^~


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
