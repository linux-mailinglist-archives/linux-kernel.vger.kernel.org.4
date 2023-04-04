Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5E36D5CB2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbjDDKKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbjDDKKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:10:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CA3E79
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 03:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680603014; x=1712139014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2WpOwPpwAvS3ja0wM80XZdqT10gY15brihXwIR0tEyM=;
  b=lv5/E6is4Yd/jKKeDx/3N76yaR9zA+4bHw+4SOHyACmd/DcNT1UwmAHX
   KuHu0QJEOr7rMHkxRWYifh9Lugc2IqE9+lY3+/n8t3jee9m8hdzjvqE0t
   XSy4bH906UCUymmxqvjuClVWi83BxHrfBhFADXCXmBK4DD0/RIQvSmTft
   MTa9zjA+n54DzknjXjVV9PdvbklkxOvQyxXTMwaA4nbS4CjEjiFbGOT+D
   t9MCumU5Im06BUxdCoMJGC2op+k/94pHdCgeJ8utzi7ghLzWLUj9/bWb3
   grRnZM5oTuCi+OM+EzC0pgdY5FAjCaZ34vHvInBRghnEXwxk04T1ggKeq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="321798531"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="321798531"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 03:10:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="688839750"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="688839750"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 04 Apr 2023 03:10:12 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjdcB-000PWw-2B;
        Tue, 04 Apr 2023 10:10:11 +0000
Date:   Tue, 4 Apr 2023 18:09:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Triplett <josh@joshtriplett.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH] prctl: Add PR_GET_AUXV to copy auxv to userspace
Message-ID: <202304041710.JYcSAmPL-lkp@intel.com>
References: <b11a591e085f1cd06adb454b1f7cde676d317318.1680585798.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b11a591e085f1cd06adb454b1f7cde676d317318.1680585798.git.josh@joshtriplett.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.3-rc5]
[cannot apply to akpm-mm/mm-everything next-20230404]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Josh-Triplett/prctl-Add-PR_GET_AUXV-to-copy-auxv-to-userspace/20230404-140043
patch link:    https://lore.kernel.org/r/b11a591e085f1cd06adb454b1f7cde676d317318.1680585798.git.josh%40joshtriplett.org
patch subject: [PATCH] prctl: Add PR_GET_AUXV to copy auxv to userspace
config: arm-randconfig-r025-20230403 (https://download.01.org/0day-ci/archive/20230404/202304041710.JYcSAmPL-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/4323f9bd6c2ecbfd6be4f8a3830ea47a89558314
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Josh-Triplett/prctl-Add-PR_GET_AUXV-to-copy-auxv-to-userspace/20230404-140043
        git checkout 4323f9bd6c2ecbfd6be4f8a3830ea47a89558314
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304041710.JYcSAmPL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/sys.c:2383:23: warning: comparison of distinct pointer types ('typeof (sizeof (mm->saved_auxv)) *' (aka 'unsigned int *') and 'typeof (len) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
           unsigned long size = min(sizeof(mm->saved_auxv), len);
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:67:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   1 warning generated.


vim +2383 kernel/sys.c

  2379	
  2380	static int prctl_get_auxv(void __user *addr, unsigned long len)
  2381	{
  2382		struct mm_struct *mm = current->mm;
> 2383		unsigned long size = min(sizeof(mm->saved_auxv), len);
  2384	
  2385		if (size && copy_to_user(addr, mm->saved_auxv, size))
  2386			return -EFAULT;
  2387		return sizeof(mm->saved_auxv);
  2388	}
  2389	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
