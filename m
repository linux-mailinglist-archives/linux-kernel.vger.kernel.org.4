Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CD572940E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbjFIJD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241100AbjFIJDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:03:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFE51988;
        Fri,  9 Jun 2023 02:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686301390; x=1717837390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iaaw1/mG+dou+hqfRiLwG0kXBn1nAWk+R86bJNOIuzY=;
  b=L+DzSFsoe9orx/9k8uqFmcuXDIYZ+XvhoFlOmBX3XxuSDFwbKWZUwuf0
   FABVbW9JHMv7jJIELq5vBfStzYKvDMfammF84inpbWjS6rPfQKEQQ5C5o
   Yl9ixr7pcK8DECX5tTZmQYg9YuSr9GLOOdxLhdYM4QPkOcWSGI9lmQNwV
   gAPMIgNw8UgRjhID4awf5w3lEHESFTQr9IGfc5miGE16cgMsc1CsUxY0z
   3wDe/J0eRFi8T57WSvDy0mTJ5Fex3V2uvCke5w6fCvjQlw5+fkTNs4La3
   Z/GN+fGOR4J8xcvl46BYur/2Ho/87rP0BACsaWmRscEJyo0xRjC8BpT57
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="423434370"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="423434370"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 02:02:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="704480869"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="704480869"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Jun 2023 02:02:00 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7Y0N-0008sC-0L;
        Fri, 09 Jun 2023 09:01:59 +0000
Date:   Fri, 9 Jun 2023 17:01:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com, Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH] watchdog/mm: Allow dumping memory info in pretimeout
Message-ID: <202306091651.GsOxG35Q-lkp@intel.com>
References: <20230608-pretimeout-oom-v1-1-542cc91062d7@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608-pretimeout-oom-v1-1-542cc91062d7@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9561de3a55bed6bdd44a12820ba81ec416e705a7]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Whitchurch/watchdog-mm-Allow-dumping-memory-info-in-pretimeout/20230609-144807
base:   9561de3a55bed6bdd44a12820ba81ec416e705a7
patch link:    https://lore.kernel.org/r/20230608-pretimeout-oom-v1-1-542cc91062d7%40axis.com
patch subject: [PATCH] watchdog/mm: Allow dumping memory info in pretimeout
config: parisc-buildonly-randconfig-r006-20230608 (https://download.01.org/0day-ci/archive/20230609/202306091651.GsOxG35Q-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 9561de3a55bed6bdd44a12820ba81ec416e705a7
        b4 shazam https://lore.kernel.org/r/20230608-pretimeout-oom-v1-1-542cc91062d7@axis.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306091651.GsOxG35Q-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/oom_kill.c:156:21: warning: no previous prototype for 'find_trylock_task_mm' [-Wmissing-prototypes]
     156 | struct task_struct *find_trylock_task_mm(struct task_struct *p)
         |                     ^~~~~~~~~~~~~~~~~~~~


vim +/find_trylock_task_mm +156 mm/oom_kill.c

   151	
   152	/*
   153	 * Identical to the above, except that we avoid tasks which we can't lock, to
   154	 * avoid deadlocks when called from an interrupt handler.
   155	 */
 > 156	struct task_struct *find_trylock_task_mm(struct task_struct *p)
   157	{
   158		struct task_struct *t;
   159	
   160		rcu_read_lock();
   161	
   162		for_each_thread(p, t) {
   163			if (!task_trylock(t))
   164				continue;
   165			if (likely(t->mm))
   166				goto found;
   167			task_unlock(t);
   168		}
   169		t = NULL;
   170	found:
   171		rcu_read_unlock();
   172	
   173		return t;
   174	}
   175	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
