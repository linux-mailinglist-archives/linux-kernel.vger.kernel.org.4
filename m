Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E56D6EA66A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjDUJAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDUJAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:00:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B28526B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682067618; x=1713603618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dkqTBJMKo7F+hELtS2+2TMCCSxzpvF2p1cgx4R+h42I=;
  b=GcWg4X9Zd1zMIyAznNAyrSSL1qFg83gAd5IAF8Vh8Dc6dMhtd2pkyrHT
   8wqCvYypU1wEpP/+E3kGsRTJJnfjOV57nTUq1jymu3nx4Eg15U7ZMvnxH
   aPlJ+NZSgFYW1QRrb3Kko45IpwWUs2eV3g7FQ281DnzMrTrnhUyJSCe36
   3gDid9vygYC/TbWp7AXiJRPiK9MrvTQeqAqopGX/c+ukeKmYlP4kcv+Cm
   cQNpWQ0UfxtFtp+RhlKhCLbnQOYf7hwxo7GxCi0cwSJ7t6Ieaz8PWxLfA
   fKXrg6VLuTVjL37KrUp0Sosjrl0Fwh76dHRf5z8bjUHijh8ucLp/6Rsi8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="411217098"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="411217098"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 02:00:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="642443294"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="642443294"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Apr 2023 02:00:09 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppmci-000gTE-2l;
        Fri, 21 Apr 2023 09:00:08 +0000
Date:   Fri, 21 Apr 2023 16:59:18 +0800
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
Message-ID: <202304211628.wQn1SxkT-lkp@intel.com>
References: <43d7f8d6e4b45a1a76fceef2d117bbc3954bc0bf.1681994221.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43d7f8d6e4b45a1a76fceef2d117bbc3954bc0bf.1681994221.git.chris@chrisdown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
config: i386-randconfig-a011 (https://download.01.org/0day-ci/archive/20230421/202304211628.wQn1SxkT-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304211628.wQn1SxkT-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/printk/printk.c:1297:2: error: unterminated function-like macro invocation
           if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
           ^
   include/linux/compiler.h:56:9: note: macro 'if' defined here
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
           ^
>> kernel/printk/printk.c:4272:24: error: expected '}'
   #endif /* CONFIG_SMP */
                          ^
   kernel/printk/printk.c:1293:1: note: to match this '{'
   {
   ^
   2 errors generated.


vim +1297 kernel/printk/printk.c

bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1291  
db9fb81bc5f175 kernel/printk/printk.c Chris Down      2023-04-20  1292  static void boot_delay_msec(void)
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1293  {
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1294  	unsigned long long k;
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1295  	unsigned long timeout;
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1296  
ff48cd26fc4889 kernel/printk/printk.c Thomas Gleixner 2017-05-16 @1297  	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
bfe8df3d314bdd kernel/printk.c        Randy Dunlap    2007-10-16  1298  		return;
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
