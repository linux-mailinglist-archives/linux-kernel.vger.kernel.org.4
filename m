Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D30A700CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjELQVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjELQU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:20:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623894488
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683908455; x=1715444455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kQrCjZfmA9fTOWXr4x31FqcTg2sfAoGnoswipb60XPM=;
  b=NJ7furqosJTWEcDOHLf0CPMNYmsrgni1vebmw0PWuvoFZB75Sb61s8PG
   /KuCr2kfswut0xdY8OPhW//VVHw9h+LEkCi4LJnZ49UlcpH+8BNP6A1eZ
   fMGrkpcD4r+ktLrmasgWyAs3ihIBbBaNlkF1MtEh4o65UK2tW5KA1cp9+
   dimfc4SRGaPVmIoSkR9q6QVlJxd0lmqThlQURT5oF4iJOrrJMIMdlXXEW
   v+rpUbGo/JpsSTfXhgruDOJSrHLI1++GBGKun6WAggSIHMbgMg5Hqp/Az
   80lTtAVUEcj4kCBX7J2ApMhdoMSrqs09hxwPkGAL6W8a1n27qMWo8tJzf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="353077808"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="353077808"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 09:20:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="765219554"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="765219554"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 May 2023 09:20:51 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxVVi-0004y0-28;
        Fri, 12 May 2023 16:20:50 +0000
Date:   Sat, 13 May 2023 00:20:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xia Fukun <xiafukun@huawei.com>, gregkh@linuxfoundation.org,
        prajnoha@redhat.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, xiafukun@huawei.com
Subject: Re: [PATCH v4] kobject: Fix global-out-of-bounds in
 kobject_action_type()
Message-ID: <202305130013.em3umwVP-lkp@intel.com>
References: <20230512103029.183852-1-xiafukun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512103029.183852-1-xiafukun@huawei.com>
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

Hi Xia,

kernel test robot noticed the following build errors:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.4-rc1 next-20230512]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xia-Fukun/kobject-Fix-global-out-of-bounds-in-kobject_action_type/20230512-183414
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20230512103029.183852-1-xiafukun%40huawei.com
patch subject: [PATCH v4] kobject: Fix global-out-of-bounds in kobject_action_type()
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20230513/202305130013.em3umwVP-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4d1d5546395a3bf45324f25b5e77b90fe6cfe8df
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xia-Fukun/kobject-Fix-global-out-of-bounds-in-kobject_action_type/20230512-183414
        git checkout 4d1d5546395a3bf45324f25b5e77b90fe6cfe8df
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305130013.em3umwVP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/kobject_uevent.c:90:11: error: implicit declaration of function 'kobject_action' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           action = kobject_action(i);
                    ^
   lib/kobject_uevent.c:67:9: warning: variable 'count_first' set but not used [-Wunused-but-set-variable]
           size_t count_first;
                  ^
   1 warning and 1 error generated.


vim +/kobject_action +90 lib/kobject_uevent.c

    61	
    62	static int kobject_action_type(const char *buf, size_t count,
    63				       enum kobject_action *type,
    64				       const char **args)
    65	{
    66		enum kobject_action action;
    67		size_t count_first;
    68		const char *args_start;
    69		int i, ret = -EINVAL;
    70	
    71		if (count && (buf[count-1] == '\n' || buf[count-1] == '\0'))
    72			count--;
    73	
    74		if (!count)
    75			goto out;
    76	
    77		args_start = strnchr(buf, count, ' ');
    78		if (args_start) {
    79			count_first = args_start - buf;
    80			args_start = args_start + 1;
    81		} else
    82			count_first = count;
    83	
    84		/* Use sysfs_match_string() to replace the fragile and convoluted loop */
    85		i = sysfs_match_string(kobject_actions, buf);
    86	
    87		if (i < 0)
    88			return ret;
    89	
  > 90		action = kobject_action(i);
    91	
    92		if (args)
    93			*args = args_start;
    94	
    95		*type = action;
    96		ret = 0;
    97	
    98	out:
    99		return ret;
   100	}
   101	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
