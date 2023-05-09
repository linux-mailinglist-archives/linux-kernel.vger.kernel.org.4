Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0E56FD306
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 01:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjEIX1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 19:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEIX07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 19:26:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A26E4230
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 16:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683674818; x=1715210818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c9rYDZoloupoogZjD/RinnlIkKkS7tioJuuA7Hj7X0o=;
  b=eN15XVruPcCTwIQRezQ5wSihCLGN31/PvmfCdl5PQJCeFp1LZ7dgrzeh
   474WkOyLPGudtxz+I3VAvXBMlGfDhU1ygcnmIJt034bt6Z0P3Y2u6w5aC
   Mj1vb2ec7KFm9X9Mroo8AQXV9pceaLZkPrHCl6/+QU3gQUqIVow/uuC/w
   5iaaaywLlgCXegXZOmqVIC4Nk7CrA7533sGHyznerjsUXndAcfICdLh43
   +gOAt1EO+lU7o5kMh0sbXW2+qQz0U+7+Et2raCWAfvX8G9z2aTsuJ1HCz
   RfqMruUNynP0+KTayUw8DcD+XwomOdtekVU5S9ojJB4kU6RS4+BWfNmr+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="352260024"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="352260024"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 16:26:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="731944022"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="731944022"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 09 May 2023 16:26:55 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwWjO-0002cG-2h;
        Tue, 09 May 2023 23:26:54 +0000
Date:   Wed, 10 May 2023 07:26:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kent Overstreet <kmo@daterainc.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, Kent Overstreet <kmo@daterainc.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 1/2] lockdep: lock_set_cmp_fn()
Message-ID: <202305100719.eq9Z9e7H-lkp@intel.com>
References: <20230509195847.1745548-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509195847.1745548-1-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kent,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/locking/core]
[cannot apply to linus/master v6.4-rc1 next-20230509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kent-Overstreet/bcache-Convert-to-lock_cmp_fn/20230510-040030
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20230509195847.1745548-1-kent.overstreet%40linux.dev
patch subject: [PATCH 1/2] lockdep: lock_set_cmp_fn()
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230510/202305100719.eq9Z9e7H-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f265373c48cadb6f81e032df9893abffc370ab89
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kent-Overstreet/bcache-Convert-to-lock_cmp_fn/20230510-040030
        git checkout f265373c48cadb6f81e032df9893abffc370ab89
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/md/ kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305100719.eq9Z9e7H-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/locking/lockdep.c: In function 'print_chain_keys_chain':
>> kernel/locking/lockdep.c:3592:46: error: passing argument 1 of 'print_lock_name' from incompatible pointer type [-Werror=incompatible-pointer-types]
    3592 |                 print_lock_name(lock_classes + chain_hlock_class_idx(hlock_id));
         |                                 ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                              |
         |                                              struct lock_class *
   kernel/locking/lockdep.c:732:47: note: expected 'struct held_lock *' but argument is of type 'struct lock_class *'
     732 | static void print_lock_name(struct held_lock *hlock, struct lock_class *class)
         |                             ~~~~~~~~~~~~~~~~~~^~~~~
>> kernel/locking/lockdep.c:3592:17: error: too few arguments to function 'print_lock_name'
    3592 |                 print_lock_name(lock_classes + chain_hlock_class_idx(hlock_id));
         |                 ^~~~~~~~~~~~~~~
   kernel/locking/lockdep.c:732:13: note: declared here
     732 | static void print_lock_name(struct held_lock *hlock, struct lock_class *class)
         |             ^~~~~~~~~~~~~~~
   kernel/locking/lockdep.c: At top level:
   kernel/locking/lockdep.c:4898:6: warning: no previous prototype for 'lockdep_set_lock_cmp_fn' [-Wmissing-prototypes]
    4898 | void lockdep_set_lock_cmp_fn(struct lockdep_map *lock, lock_cmp_fn cmp_fn,
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/print_lock_name +3592 kernel/locking/lockdep.c

39e2e173fb1f90 Alfredo Alvarez Fernandez 2016-03-30  3580  
39e2e173fb1f90 Alfredo Alvarez Fernandez 2016-03-30  3581  static void print_chain_keys_chain(struct lock_chain *chain)
39e2e173fb1f90 Alfredo Alvarez Fernandez 2016-03-30  3582  {
39e2e173fb1f90 Alfredo Alvarez Fernandez 2016-03-30  3583  	int i;
f6ec8829ac9d59 Yuyang Du                 2019-05-06  3584  	u64 chain_key = INITIAL_CHAIN_KEY;
f611e8cf98ec90 Boqun Feng                2020-08-07  3585  	u16 hlock_id;
39e2e173fb1f90 Alfredo Alvarez Fernandez 2016-03-30  3586  
39e2e173fb1f90 Alfredo Alvarez Fernandez 2016-03-30  3587  	printk("depth: %u\n", chain->depth);
39e2e173fb1f90 Alfredo Alvarez Fernandez 2016-03-30  3588  	for (i = 0; i < chain->depth; i++) {
f611e8cf98ec90 Boqun Feng                2020-08-07  3589  		hlock_id = chain_hlocks[chain->base + i];
f611e8cf98ec90 Boqun Feng                2020-08-07  3590  		chain_key = print_chain_key_iteration(hlock_id, chain_key);
39e2e173fb1f90 Alfredo Alvarez Fernandez 2016-03-30  3591  
28df029d53a2fd Cheng Jui Wang            2022-02-10 @3592  		print_lock_name(lock_classes + chain_hlock_class_idx(hlock_id));
39e2e173fb1f90 Alfredo Alvarez Fernandez 2016-03-30  3593  		printk("\n");
39e2e173fb1f90 Alfredo Alvarez Fernandez 2016-03-30  3594  	}
39e2e173fb1f90 Alfredo Alvarez Fernandez 2016-03-30  3595  }
39e2e173fb1f90 Alfredo Alvarez Fernandez 2016-03-30  3596  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
