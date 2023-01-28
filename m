Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4291767F975
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 17:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjA1QLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 11:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjA1QLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 11:11:45 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1F927D7D;
        Sat, 28 Jan 2023 08:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674922304; x=1706458304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qYGwK1HZEbiArGQa1pglPHRTaIsgkEtoJTEebkjcE1A=;
  b=dDCdJ9d96C4EIR9y3/WAjytTeOMlOrrA0GiTMTNk5BPpu5SqzPSWLHW2
   oQwPfD0DYmcdWieq9EGwoOaDSZBHfOur9eIMiRVFCoqHxvm6/lMWAl267
   mapCxafFxL551eKYFcIsGp8Z0S1orakw0cbfCjY5mJTg/JUkjeLoCm5v8
   5KFOPiQBjjagVicp4UtYLRP9LIYEhtzw9YrntfeTwDGiGVK8uFhpjp+hi
   0CY3y/ior2tSZMSBx0KrJwiR3jj+72gDtx0vEfUv1yyZfrYiQcGiHgcuF
   /8p+tfGLLyPlL1zvnSkh3AhqP1iLLRVzAToP5AMbuUZ6gZAn3IKSMJzia
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="315258375"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="315258375"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 08:11:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="665587079"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="665587079"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jan 2023 08:11:40 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLnnn-0000sr-2d;
        Sat, 28 Jan 2023 16:11:39 +0000
Date:   Sun, 29 Jan 2023 00:11:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v7 1/1] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
Message-ID: <202301290021.499W0wlW-lkp@intel.com>
References: <20230126190645.18341-2-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126190645.18341-2-gregory.price@memverge.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gregory,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on tip/core/entry v6.2-rc5 next-20230127]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gregory-Price/ptrace-syscall_user_dispatch-checkpoint-restore-support-for-SUD/20230128-145101
patch link:    https://lore.kernel.org/r/20230126190645.18341-2-gregory.price%40memverge.com
patch subject: [PATCH v7 1/1] ptrace,syscall_user_dispatch: checkpoint/restore support for SUD
config: x86_64-randconfig-a013-20230123 (https://download.01.org/0day-ci/archive/20230129/202301290021.499W0wlW-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bc68df21f98617e74a8c5368a901041f89bdb17f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gregory-Price/ptrace-syscall_user_dispatch-checkpoint-restore-support-for-SUD/20230128-145101
        git checkout bc68df21f98617e74a8c5368a901041f89bdb17f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/entry/syscall_user_dispatch.c:114:38: error: variable has incomplete type 'struct syscall_user_dispatch_config'
           struct syscall_user_dispatch_config config;
                                               ^
   kernel/entry/syscall_user_dispatch.c:114:9: note: forward declaration of 'struct syscall_user_dispatch_config'
           struct syscall_user_dispatch_config config;
                  ^
>> kernel/entry/syscall_user_dispatch.c:116:14: error: invalid application of 'sizeof' to an incomplete type 'struct syscall_user_dispatch_config'
           if (size != sizeof(struct syscall_user_dispatch_config))
                       ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/entry/syscall_user_dispatch.c:114:9: note: forward declaration of 'struct syscall_user_dispatch_config'
           struct syscall_user_dispatch_config config;
                  ^
   kernel/entry/syscall_user_dispatch.c:137:38: error: variable has incomplete type 'struct syscall_user_dispatch_config'
           struct syscall_user_dispatch_config config;
                                               ^
   kernel/entry/syscall_user_dispatch.c:137:9: note: forward declaration of 'struct syscall_user_dispatch_config'
           struct syscall_user_dispatch_config config;
                  ^
   kernel/entry/syscall_user_dispatch.c:139:14: error: invalid application of 'sizeof' to an incomplete type 'struct syscall_user_dispatch_config'
           if (size != sizeof(struct syscall_user_dispatch_config))
                       ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/entry/syscall_user_dispatch.c:137:9: note: forward declaration of 'struct syscall_user_dispatch_config'
           struct syscall_user_dispatch_config config;
                  ^
   4 errors generated.


vim +114 kernel/entry/syscall_user_dispatch.c

   109	
   110	int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
   111			void __user *data)
   112	{
   113		struct syscall_user_dispatch *sd = &task->syscall_dispatch;
 > 114		struct syscall_user_dispatch_config config;
   115	
 > 116		if (size != sizeof(struct syscall_user_dispatch_config))
   117			return -EINVAL;
   118	
   119		if (test_syscall_work(SYSCALL_USER_DISPATCH))
   120			config.mode = PR_SYS_DISPATCH_ON;
   121		else
   122			config.mode = PR_SYS_DISPATCH_OFF;
   123	
   124		config.offset = sd->offset;
   125		config.len = sd->len;
   126		config.selector = sd->selector;
   127	
   128		if (copy_to_user(data, &config, sizeof(config)))
   129			return -EFAULT;
   130	
   131		return 0;
   132	}
   133	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
