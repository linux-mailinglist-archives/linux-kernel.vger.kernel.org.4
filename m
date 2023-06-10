Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7788072A932
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 07:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjFJFm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 01:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFJFmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 01:42:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185DC3AA3;
        Fri,  9 Jun 2023 22:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686375743; x=1717911743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sQgAiqE4AY4AY0vEW9l4MzGZIdDuFn9T2C9jO4o6QXM=;
  b=cT730TvUYcnPqiyHtxA4cMC26hSUy/GhFy15igqTgPHfPxokkqs2LEue
   Hh6TnSwZfRRoY5ax26IQpLLa0TPmyJuH8UQUx7jUBHQmQnFbv7LyxR5s7
   xUEd7Y1WVgQAfFgNxAFFojPMwO707rAzPmceCHfvbFuIARjiC+MNX0/Ug
   ceJs0y/7jHm8VdjQ8m24dTR5qvpQxTs9b/s3GwYxin4juuTUZxKp1MGzg
   BvgTYDxpvGZUWazirQmvgpqYzv6uA5cbzAllMH383u+/pV4cYGBMg/Bt7
   8E1vUTzPOkDLVWgXqOBnw/d4eEVg/nz+Wi3zESMKi2kh6URXWIpxNxnFt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="342412466"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="342412466"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 22:42:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="884812674"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="884812674"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 09 Jun 2023 22:42:17 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7rMe-0009me-1a;
        Sat, 10 Jun 2023 05:42:16 +0000
Date:   Sat, 10 Jun 2023 13:42:10 +0800
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
Cc:     oe-kbuild-all@lists.linux.dev,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/4] Rip out simple_strtoll()
Message-ID: <202306101317.YiBrl6OZ-lkp@intel.com>
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
config: csky-randconfig-r011-20230610 (https://download.01.org/0day-ci/archive/20230610/202306101317.YiBrl6OZ-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add lee-mfd https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
        git fetch lee-mfd for-mfd-next
        git checkout lee-mfd/for-mfd-next
        b4 shazam https://lore.kernel.org/r/20230610025759.1813-1-demi@invisiblethingslab.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=csky olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash drivers/md/bcache/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306101317.YiBrl6OZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/md/bcache/util.c: In function 'bch_strtoll_h':
>> drivers/md/bcache/util.c:28:18: error: implicit declaration of function 'simple_strtoll'; did you mean 'simple_strtoull'? [-Werror=implicit-function-declaration]
      28 |         type i = simple_ ## name(cp, &e, 10);                   \
         |                  ^~~~~~~
   drivers/md/bcache/util.c:82:1: note: in expansion of macro 'STRTO_H'
      82 | STRTO_H(strtoll, long long)
         | ^~~~~~~
   cc1: some warnings being treated as errors


vim +28 drivers/md/bcache/util.c

cafe563591446c Kent Overstreet     2013-03-23  22  
cafe563591446c Kent Overstreet     2013-03-23  23  #define STRTO_H(name, type)					\
169ef1cf6171d3 Kent Overstreet     2013-03-28  24  int bch_ ## name ## _h(const char *cp, type *res)		\
cafe563591446c Kent Overstreet     2013-03-23  25  {								\
cafe563591446c Kent Overstreet     2013-03-23  26  	int u = 0;						\
cafe563591446c Kent Overstreet     2013-03-23  27  	char *e;						\
cafe563591446c Kent Overstreet     2013-03-23 @28  	type i = simple_ ## name(cp, &e, 10);			\
cafe563591446c Kent Overstreet     2013-03-23  29  								\
cafe563591446c Kent Overstreet     2013-03-23  30  	switch (tolower(*e)) {					\
cafe563591446c Kent Overstreet     2013-03-23  31  	default:						\
cafe563591446c Kent Overstreet     2013-03-23  32  		return -EINVAL;					\
cafe563591446c Kent Overstreet     2013-03-23  33  	case 'y':						\
cafe563591446c Kent Overstreet     2013-03-23  34  	case 'z':						\
cafe563591446c Kent Overstreet     2013-03-23  35  		u++;						\
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  36  		fallthrough;					\
cafe563591446c Kent Overstreet     2013-03-23  37  	case 'e':						\
cafe563591446c Kent Overstreet     2013-03-23  38  		u++;						\
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  39  		fallthrough;					\
cafe563591446c Kent Overstreet     2013-03-23  40  	case 'p':						\
cafe563591446c Kent Overstreet     2013-03-23  41  		u++;						\
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  42  		fallthrough;					\
cafe563591446c Kent Overstreet     2013-03-23  43  	case 't':						\
cafe563591446c Kent Overstreet     2013-03-23  44  		u++;						\
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  45  		fallthrough;					\
cafe563591446c Kent Overstreet     2013-03-23  46  	case 'g':						\
cafe563591446c Kent Overstreet     2013-03-23  47  		u++;						\
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  48  		fallthrough;					\
cafe563591446c Kent Overstreet     2013-03-23  49  	case 'm':						\
cafe563591446c Kent Overstreet     2013-03-23  50  		u++;						\
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  51  		fallthrough;					\
cafe563591446c Kent Overstreet     2013-03-23  52  	case 'k':						\
cafe563591446c Kent Overstreet     2013-03-23  53  		u++;						\
cafe563591446c Kent Overstreet     2013-03-23  54  		if (e++ == cp)					\
cafe563591446c Kent Overstreet     2013-03-23  55  			return -EINVAL;				\
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  56  		fallthrough;					\
cafe563591446c Kent Overstreet     2013-03-23  57  	case '\n':						\
cafe563591446c Kent Overstreet     2013-03-23  58  	case '\0':						\
cafe563591446c Kent Overstreet     2013-03-23  59  		if (*e == '\n')					\
cafe563591446c Kent Overstreet     2013-03-23  60  			e++;					\
cafe563591446c Kent Overstreet     2013-03-23  61  	}							\
cafe563591446c Kent Overstreet     2013-03-23  62  								\
cafe563591446c Kent Overstreet     2013-03-23  63  	if (*e)							\
cafe563591446c Kent Overstreet     2013-03-23  64  		return -EINVAL;					\
cafe563591446c Kent Overstreet     2013-03-23  65  								\
cafe563591446c Kent Overstreet     2013-03-23  66  	while (u--) {						\
cafe563591446c Kent Overstreet     2013-03-23  67  		if ((type) ~0 > 0 &&				\
cafe563591446c Kent Overstreet     2013-03-23  68  		    (type) ~0 / 1024 <= i)			\
cafe563591446c Kent Overstreet     2013-03-23  69  			return -EINVAL;				\
cafe563591446c Kent Overstreet     2013-03-23  70  		if ((i > 0 && ANYSINT_MAX(type) / 1024 < i) ||	\
cafe563591446c Kent Overstreet     2013-03-23  71  		    (i < 0 && -ANYSINT_MAX(type) / 1024 > i))	\
cafe563591446c Kent Overstreet     2013-03-23  72  			return -EINVAL;				\
cafe563591446c Kent Overstreet     2013-03-23  73  		i *= 1024;					\
cafe563591446c Kent Overstreet     2013-03-23  74  	}							\
cafe563591446c Kent Overstreet     2013-03-23  75  								\
cafe563591446c Kent Overstreet     2013-03-23  76  	*res = i;						\
cafe563591446c Kent Overstreet     2013-03-23  77  	return 0;						\
cafe563591446c Kent Overstreet     2013-03-23  78  }								\
cafe563591446c Kent Overstreet     2013-03-23  79  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
