Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFD26EA091
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 02:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjDUATF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 20:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjDUATD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 20:19:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F294204
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 17:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682036341; x=1713572341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zo/enHcd24a/zv1nIUz07m3HxxiG/ex8WtBZ0iBSgD0=;
  b=YG1C4f9dIIRRCmbpkq854Ss0kw9xgoGEE5ZwRtyvU/YHTbI0+g10ikLD
   PzQQTeocaqaXk+cPPaO8h+X/FyV8T0/WXW22UVn9cA6584a27FVKLYQSM
   guo84nAZYcRk1h7NuHEIlnLxL5NMIk6C2vyXHEHUET5gMTjshcYfoNiRf
   0KzZYXZB1Au72UpC+PNx67pA7nJnbJE69XC8fn2tZ8HHIT2dV28TitYes
   23aOLSm6Tgmi7nBkWVxuS63UA+S+oWHUTv8fnznS8m3k/sMNIEX2HrdZ6
   t1Mk4uUMmi0sJeZHDrN76GvPOpIm5vPvVjqGC8X1y7oPrVA9nLN+PAfzJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="432162800"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="432162800"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 17:19:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="761385725"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="761385725"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Apr 2023 17:18:58 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppeUM-000gC0-0b;
        Fri, 21 Apr 2023 00:18:58 +0000
Date:   Fri, 21 Apr 2023 08:18:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v4 1/2] printk: Do not delay messages which aren't
 solicited by any console
Message-ID: <202304210846.3xN0Ge3m-lkp@intel.com>
References: <43d7f8d6e4b45a1a76fceef2d117bbc3954bc0bf.1681994221.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43d7f8d6e4b45a1a76fceef2d117bbc3954bc0bf.1681994221.git.chris@chrisdown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

kernel test robot noticed the following build errors:

[auto build test ERROR on cb0856346a60fe3eb837ba5e73588a41f81ac05f]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Down/printk-Do-not-delay-messages-which-aren-t-solicited-by-any-console/20230420-204202
base:   cb0856346a60fe3eb837ba5e73588a41f81ac05f
patch link:    https://lore.kernel.org/r/43d7f8d6e4b45a1a76fceef2d117bbc3954bc0bf.1681994221.git.chris%40chrisdown.name
patch subject: [PATCH v4 1/2] printk: Do not delay messages which aren't solicited by any console
config: x86_64-randconfig-a013-20230417 (https://download.01.org/0day-ci/archive/20230421/202304210846.3xN0Ge3m-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/db9fb81bc5f175ef48cb317c24da85d0f6d4391d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chris-Down/printk-Do-not-delay-messages-which-aren-t-solicited-by-any-console/20230420-204202
        git checkout db9fb81bc5f175ef48cb317c24da85d0f6d4391d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs// kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304210846.3xN0Ge3m-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/printk/printk.c:1298:3: error: expected ')'
                   return;
                   ^
   kernel/printk/printk.c:1297:5: note: to match this '('
           if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
              ^
   1 error generated.


vim +1298 kernel/printk/printk.c

bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1291  
db9fb81bc5f175 kernel/printk/printk.c Chris Down      2023-04-20  1292  static void boot_delay_msec(void)
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1293  {
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1294  	unsigned long long k;
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1295  	unsigned long timeout;
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1296  
ff48cd26fc4889 kernel/printk/printk.c Thomas Gleixner 2017-05-16  1297  	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16 @1298  		return;
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1299  
3a3b6ed2235f2f kernel/printk.c        Dave Young      2009-09-22  1300  	k = (unsigned long long)loops_per_msec * boot_delay;
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1301  
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1302  	timeout = jiffies + msecs_to_jiffies(boot_delay);
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1303  	while (k) {
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1304  		k--;
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1305  		cpu_relax();
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1306  		/*
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1307  		 * use (volatile) jiffies to prevent
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1308  		 * compiler reduction; loop termination via jiffies
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1309  		 * is secondary and may or may not happen.
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1310  		 */
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1311  		if (time_after(jiffies, timeout))
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1312  			break;
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1313  		touch_nmi_watchdog();
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1314  	}
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1315  }
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1316  #else
db9fb81bc5f175 kernel/printk/printk.c Chris Down      2023-04-20  1317  static inline void boot_delay_msec(void)
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1318  {
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1319  }
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1320  #endif
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1321  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
