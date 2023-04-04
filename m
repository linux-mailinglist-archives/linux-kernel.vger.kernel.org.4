Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955816D5C87
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbjDDJ7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjDDJ7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:59:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505E31BD6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680602358; x=1712138358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sWw4FO/jFyMRxxBXknWut7zEzlnQFR4CIDRAC5E0jKE=;
  b=G3SjuQEs76hQLX+Ps8H7lcEAuP8aGRn96AI+NS7KJxF3Bu/I2A4r5o+D
   TImyHBqk9DKKOsb7464Z19Olg0OnU4/pWLfUnEOyJRHMQqG7ug2JYLh61
   hclcQKjOyxBxbroB2tu+jShUyVslZzb4K0qk6albO2QS8wEQc6BjO79p4
   swgXk3WO79IT/mBuN1kP34/tWFwpCXtNpVvhKqTA/+fQ6tJcBHY9fbpvP
   douSd1HcqqBmCfNU4DIeBxfd3xKJwL6RuNtXpXwdqqktkmEnD0N/I8/Pe
   M97pa48lPacpAVc/tOTfkFDdt+jhcneRES+WiUQaIgond90lPCP3m6T2W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="407199925"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="407199925"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 02:59:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="750861005"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="750861005"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Apr 2023 02:59:11 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjdRX-000PW8-0U;
        Tue, 04 Apr 2023 09:59:11 +0000
Date:   Tue, 4 Apr 2023 17:58:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Triplett <josh@joshtriplett.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH] prctl: Add PR_GET_AUXV to copy auxv to userspace
Message-ID: <202304041715.c3b7aJd4-lkp@intel.com>
References: <b11a591e085f1cd06adb454b1f7cde676d317318.1680585798.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b11a591e085f1cd06adb454b1f7cde676d317318.1680585798.git.josh@joshtriplett.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
config: i386-randconfig-a001-20230403 (https://download.01.org/0day-ci/archive/20230404/202304041715.c3b7aJd4-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4323f9bd6c2ecbfd6be4f8a3830ea47a89558314
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Josh-Triplett/prctl-Add-PR_GET_AUXV-to-copy-auxv-to-userspace/20230404-140043
        git checkout 4323f9bd6c2ecbfd6be4f8a3830ea47a89558314
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304041715.c3b7aJd4-lkp@intel.com/

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
