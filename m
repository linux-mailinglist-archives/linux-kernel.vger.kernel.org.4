Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFCC69096B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjBIM7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBIM7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:59:45 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FEB83EF;
        Thu,  9 Feb 2023 04:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675947584; x=1707483584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tlUqrHw+3WN1N6cJ7zBMvb5dmA3o04TSJbaUNgMWRDU=;
  b=AcANn5QaJZFUL+xdkamRo9/XTygkvQLxrBioLYB3s7U6ZkmOVOpw0ANb
   pDhUtbxP9jGz+DvQaRMhHJBHMo5+VljLaRJ2y6nORFGeDkKNlKLhK4M9E
   bzFl6edenJJEj6Zrcu26ppQ5gBkpVHffUDBZWgu1L7IFOtdMsmAvrhgMI
   k30gqU/6qFpAi+4mcg771PE7EEKGdG/jeWlzultJazCGMlWGnmIG/gGoQ
   hxpy4Bv/zh80STL4o8PFdB5PNEsAsc6MjKJZkMPaM2ptIN8+S/Skq1QgS
   3dYCZEHMwltzJ4fsRmj7p5iNK4ZG/CKj8o4PrKIJ6foq/utk3z6YqrCa9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="392479039"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="392479039"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 04:59:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="913115909"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="913115909"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 09 Feb 2023 04:59:41 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQ6Wb-000554-1A;
        Thu, 09 Feb 2023 12:59:41 +0000
Date:   Thu, 9 Feb 2023 20:59:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zqiang <qiang1.zhang@intel.com>, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, qiuxu.zhuo@intel.com
Cc:     oe-kbuild-all@lists.linux.dev, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Keeping rcu-related kthreads running on
 housekeeping CPUS
Message-ID: <202302092018.kI8rty7k-lkp@intel.com>
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

Thank you for the patch! Yet something to improve:

[auto build test ERROR on paulmck-rcu/dev]
[also build test ERROR on next-20230209]
[cannot apply to linus/master v6.2-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zqiang/rcu-Keeping-rcu-related-kthreads-running-on-housekeeping-CPUS/20230209-182311
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
patch link:    https://lore.kernel.org/r/20230209102730.974465-1-qiang1.zhang%40intel.com
patch subject: [PATCH v2] rcu: Keeping rcu-related kthreads running on housekeeping CPUS
config: arc-randconfig-r024-20230209 (https://download.01.org/0day-ci/archive/20230209/202302092018.kI8rty7k-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/af15a3ade363b21d823918088623f8564cbd9d08
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zqiang/rcu-Keeping-rcu-related-kthreads-running-on-housekeeping-CPUS/20230209-182311
        git checkout af15a3ade363b21d823918088623f8564cbd9d08
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302092018.kI8rty7k-lkp@intel.com

All errors (new ones prefixed by >>):

   arc-elf-ld: kernel/rcu/srcutiny.o: in function `rcu_kthread_setaffinity':
>> srcutiny.c:(.text+0x35c): multiple definition of `rcu_kthread_setaffinity'; kernel/rcu/update.o:update.c:(.text+0x204): first defined here
   arc-elf-ld: kernel/rcu/tiny.o: in function `rcu_kthread_setaffinity':
   tiny.c:(.text+0x164): multiple definition of `rcu_kthread_setaffinity'; kernel/rcu/update.o:update.c:(.text+0x204): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
