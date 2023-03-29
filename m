Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDAD6CDAF8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjC2NhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjC2NhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:37:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF4946BF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680097015; x=1711633015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/+830BIGyxkaS/X9JdvqrrRiNUxLdgMKrlJlssiTfWg=;
  b=dvFA996IPnsIBhwIlCQ/tvZLw4etrv0XHNFFCHB+ookELugRc7Pdbaup
   MMGP+qZJHSi+S761gjvDu5Jc8+xmB/DyjS1VTxWy1LtuDCoENsYgG0Mxs
   Yqvpto2/0xYkybVej/9fs6tTOrrkHf/By56PxFpF7Wyw5jJlf/1AwBVEY
   f6DUdm/Buly9tq+hNMoRDhXM8WMns0ov8eptm5c4pbIZS4RVe/g+ybloG
   Zlk1SSA+9/xFPgN3EJrOIgnFY6pGJqdfDsymqn3dzcflY16c3MyJXN2u/
   w3Kth0Y+Lik7EPORL4Eqpt72PxsKg8pQsNUWE7XKJak8hZmxQ8IVRp7HU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="368648514"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="368648514"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:36:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="686829764"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="686829764"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 29 Mar 2023 06:36:53 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phVyu-000Ja4-1E;
        Wed, 29 Mar 2023 13:36:52 +0000
Date:   Wed, 29 Mar 2023 21:36:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, peterz@infradead.org,
        surenb@google.com, brauner@kernel.org, chris@chrisdown.name,
        hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: Re: [PATCH v3 4/4] sched/psi: allow unprivileged polling of N*2s
 period
Message-ID: <202303292129.PLXZnmls-lkp@intel.com>
References: <20230329074842.16209-5-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329074842.16209-5-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Domenico,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on tj-cgroup/for-next vfs-idmapping/for-next linus/master v6.3-rc4 next-20230329]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Domenico-Cerasuolo/sched-psi-rearrange-polling-code-in-preparation/20230329-155205
patch link:    https://lore.kernel.org/r/20230329074842.16209-5-cerasuolodomenico%40gmail.com
patch subject: [PATCH v3 4/4] sched/psi: allow unprivileged polling of N*2s period
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20230329/202303292129.PLXZnmls-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6c9f1219e1ccea05926017b359e41bfff24e9bd9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Domenico-Cerasuolo/sched-psi-rearrange-polling-code-in-preparation/20230329-155205
        git checkout 6c9f1219e1ccea05926017b359e41bfff24e9bd9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303292129.PLXZnmls-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_utility.c:97:
   kernel/sched/psi.c: In function 'psi_irq_open':
>> kernel/sched/psi.c:1602:16: error: implicit declaration of function 'psi_open'; did you mean 'psi_io_open'? [-Werror=implicit-function-declaration]
    1602 |         return psi_open(file, psi_irq_show);
         |                ^~~~~~~~
         |                psi_io_open
   cc1: some warnings being treated as errors


vim +1602 kernel/sched/psi.c

52b1364ba0b105 Chengming Zhou 2022-08-26  1599  
52b1364ba0b105 Chengming Zhou 2022-08-26  1600  static int psi_irq_open(struct inode *inode, struct file *file)
52b1364ba0b105 Chengming Zhou 2022-08-26  1601  {
52b1364ba0b105 Chengming Zhou 2022-08-26 @1602  	return psi_open(file, psi_irq_show);
52b1364ba0b105 Chengming Zhou 2022-08-26  1603  }
52b1364ba0b105 Chengming Zhou 2022-08-26  1604  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
