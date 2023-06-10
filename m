Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6A272A934
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 07:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjFJFmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 01:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjFJFm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 01:42:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3A93AA4;
        Fri,  9 Jun 2023 22:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686375746; x=1717911746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=604bTd5KebLX7Wwvo0G69iyofM3Y2hWMagG0LdnFklk=;
  b=f8Wq1lhZF0MhkoSRN76xyfL+uMkKH4DzraGylg0GsxZgL2hhbuZt0EU1
   GlmOqHlwbPhOFtcx68P1i1031lPpRDbCvOG7HP9rqK3iJonG+mywaXVrV
   fhS/XYi+YDrXv6RWdnm8CiK4IYhCZF7d4KGc3CA1aCU+8847Q2w7vSAlJ
   BO3xTxhoKLPvXjUJla0hhARSXONiazW0RWKDhMVo+QqlhUJmTORnydFez
   ltOLT5nD5QX1xYy1j5sKF1B7UMsV4FlnTP6/GcPtKwhhzLjQIav5SpTXp
   m1coQHbnshjXR3cHOTUEPthEQYBLaDhjmGwiUM7H6WG4u0Wu5zKar5xYL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="342412490"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="342412490"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 22:42:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="884812675"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="884812675"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 09 Jun 2023 22:42:17 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7rMe-0009mi-1j;
        Sat, 10 Jun 2023 05:42:16 +0000
Date:   Sat, 10 Jun 2023 13:42:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/4] Rip out simple_strtoll()
Message-ID: <202306101334.lDZERsKo-lkp@intel.com>
References: <20230610025759.1813-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610025759.1813-1-demi@invisiblethingslab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Demi,

kernel test robot noticed the following build errors:

[auto build test ERROR on lee-mfd/for-mfd-next]
[also build test ERROR on lee-leds/for-leds-next linus/master v6.4-rc5 next-20230609]
[cannot apply to xen-tip/linux-next lee-mfd/for-mfd-fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Demi-Marie-Obenour/vsscanf-Return-ERANGE-on-integer-overflow/20230610-110026
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/20230610025759.1813-1-demi%40invisiblethingslab.com
patch subject: [PATCH 1/4] Rip out simple_strtoll()
config: arm-randconfig-r046-20230610 (https://download.01.org/0day-ci/archive/20230610/202306101334.lDZERsKo-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git remote add lee-mfd https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
        git fetch lee-mfd for-mfd-next
        git checkout lee-mfd/for-mfd-next
        b4 shazam https://lore.kernel.org/r/20230610025759.1813-1-demi@invisiblethingslab.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/md/bcache/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306101334.lDZERsKo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/md/bcache/util.c:82:1: error: call to undeclared function 'simple_strtoll'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
   STRTO_H(strtoll, long long)
   ^
   drivers/md/bcache/util.c:28:11: note: expanded from macro 'STRTO_H'
           type i = simple_ ## name(cp, &e, 10);                   \
                    ^
   <scratch space>:22:1: note: expanded from here
   simple_strtoll
   ^
   1 error generated.


vim +/simple_strtoll +82 drivers/md/bcache/util.c

cafe563591446c Kent Overstreet 2013-03-23  79  
cafe563591446c Kent Overstreet 2013-03-23  80  STRTO_H(strtoint, int)
cafe563591446c Kent Overstreet 2013-03-23  81  STRTO_H(strtouint, unsigned int)
cafe563591446c Kent Overstreet 2013-03-23 @82  STRTO_H(strtoll, long long)
cafe563591446c Kent Overstreet 2013-03-23  83  STRTO_H(strtoull, unsigned long long)
cafe563591446c Kent Overstreet 2013-03-23  84  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
