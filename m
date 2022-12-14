Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A5664CB19
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbiLNNVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbiLNNVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:21:02 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02938EE16
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671024060; x=1702560060;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mPLuys5xlDHefxjxgWL2MY3nTSuTSIf/FXCjTq4lP3M=;
  b=DKkuWI9S9Ib4pty6gZjIe9hB0Hn9iS0BAfD3etsjNPGJDbcy69Sfb7ke
   P2f7YoBMpmeNsRtOhqw9VQ/oGTlbJI/eXJy0ux5RJv/zX3k6Qtmp5vu84
   8l5NElH9wMcMnNunhvaEXuaz0/PjuO+zmUKiQh3/DOAjtco1h5jKnYKRb
   FZx3xjUAaMxX6HZkE+UdkbIgcOyWV/sXkwxKKzAkUTWtW7VPwg4SBX199
   OhLuJLu80nzk5+ECLsz/Zm4kYrStLq+LDsIWK7IK6rSXBQjP637bmq/z+
   CFinG8Mtezf2wydGMpWXrVEWh16cB0+eyM4k4pCFEi0yf0LLzGxn+UeYl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="316035874"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="316035874"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 05:21:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="651076483"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="651076483"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 14 Dec 2022 05:20:58 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p5Rgw-0005Uv-0v;
        Wed, 14 Dec 2022 13:20:58 +0000
Date:   Wed, 14 Dec 2022 21:20:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: kernel/module/main.c:537:20: warning: Local variable 'arr' shadows
 outer variable [shadowVariable]
Message-ID: <202212142100.XuBgLkap-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e2ca6ba6ba0152361aa4fcbf6067db71b2c7a770
commit: cfc1d277891eb499b3b5354df33b30f598683e90 module: Move all into module/
date:   8 months ago
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout cfc1d277891eb499b3b5354df33b30f598683e90
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

cppcheck warnings: (new ones prefixed by >>)
>> kernel/module/main.c:537:20: warning: Local variable 'arr' shadows outer variable [shadowVariable]
     struct symsearch arr[] = {
                      ^
   kernel/module/main.c:519:32: note: Shadowed declaration
    static const struct symsearch arr[] = {
                                  ^
   kernel/module/main.c:537:20: note: Shadow variable
     struct symsearch arr[] = {
                      ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

   kernel/module/main.c:2459:26: warning: Redundant assignment of 'mod->core_layout.size' to itself. [selfAssignment]
      mod->core_layout.size = debug_align(mod->core_layout.size);
                            ^
   kernel/module/main.c:2463:26: warning: Redundant assignment of 'mod->core_layout.size' to itself. [selfAssignment]
      mod->core_layout.size = debug_align(mod->core_layout.size);
                            ^
   kernel/module/main.c:2467:26: warning: Redundant assignment of 'mod->core_layout.size' to itself. [selfAssignment]
      mod->core_layout.size = debug_align(mod->core_layout.size);
                            ^
   kernel/module/main.c:2471:26: warning: Redundant assignment of 'mod->core_layout.size' to itself. [selfAssignment]
      mod->core_layout.size = debug_align(mod->core_layout.size);
                            ^
   kernel/module/main.c:2493:26: warning: Redundant assignment of 'mod->init_layout.size' to itself. [selfAssignment]
      mod->init_layout.size = debug_align(mod->init_layout.size);
                            ^
   kernel/module/main.c:2497:26: warning: Redundant assignment of 'mod->init_layout.size' to itself. [selfAssignment]
      mod->init_layout.size = debug_align(mod->init_layout.size);
                            ^
   kernel/module/main.c:2508:26: warning: Redundant assignment of 'mod->init_layout.size' to itself. [selfAssignment]
      mod->init_layout.size = debug_align(mod->init_layout.size);
                            ^
   kernel/module/main.c:2829:70: warning: Parameter 'debug' can be declared as pointer to const [constParameter]
   static void dynamic_debug_remove(struct module *mod, struct _ddebug *debug)
                                                                        ^
   lib/dynamic_debug.c:1104:14: warning: Comparing pointers that point to different objects [comparePointers]
    for (; iter < __stop___dyndbg; iter++) {
                ^
   lib/dynamic_debug.c:42:23: note: Variable declared here.
   extern struct _ddebug __start___dyndbg[];
                         ^
   lib/dynamic_debug.c:1101:9: note: Array decayed to pointer here.
    iter = __start___dyndbg;
           ^
   lib/dynamic_debug.c:43:23: note: Variable declared here.
   extern struct _ddebug __stop___dyndbg[];
                         ^
   lib/dynamic_debug.c:1104:16: note: Array decayed to pointer here.
    for (; iter < __stop___dyndbg; iter++) {
                  ^
   lib/dynamic_debug.c:1104:14: note: Comparing pointers that point to different objects
    for (; iter < __stop___dyndbg; iter++) {
                ^
>> lib/dynamic_debug.c:843:60: warning: Parameter 'pos' can be declared as pointer to const [constParameter]
   static void *ddebug_proc_start(struct seq_file *m, loff_t *pos)
                                                              ^
>> lib/dynamic_debug.c:866:57: warning: Parameter 'p' can be declared as pointer to const [constParameter]
   static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
                                                           ^
   lib/dynamic_debug.c:170:23: warning: Uninitialized variable: dt->num_ddebugs [uninitvar]
     for (i = 0; i < dt->num_ddebugs; i++) {
                         ^
   lib/dynamic_debug.c:166:21: note: Assuming condition is false
     if (query->module &&
                       ^
   lib/dynamic_debug.c:170:23: note: Uninitialized variable: dt->num_ddebugs
     for (i = 0; i < dt->num_ddebugs; i++) {
                         ^
>> lib/dynamic_debug.c:1035:11: warning: Uninitialized variable: dt->mod_name [uninitvar]
     if (dt->mod_name == mod_name) {
             ^
>> lib/dynamic_debug.c:102:12: warning: Using argument fb that points at uninitialized variable flags [ctuuninitvar]
    char *p = fb->buf;
              ^
   lib/dynamic_debug.c:900:27: note: Calling function ddebug_describe_flags, 2nd argument is uninitialized
        ddebug_describe_flags(dp->flags, &flags));
                             ^
   lib/dynamic_debug.c:102:12: note: Using argument fb
    char *p = fb->buf;
              ^

vim +/arr +537 kernel/module/main.c

de4d8d534654831 kernel/module.c Rusty Russell     2011-04-19  512  
24b9f0d22081455 kernel/module.c Sergey Shtylyov   2020-11-07  513  /*
24b9f0d22081455 kernel/module.c Sergey Shtylyov   2020-11-07  514   * Find an exported symbol and return it, along with, (optional) crc and
24b9f0d22081455 kernel/module.c Sergey Shtylyov   2020-11-07  515   * (optional) module which owns it.  Needs preempt disabled or module_mutex.
24b9f0d22081455 kernel/module.c Sergey Shtylyov   2020-11-07  516   */
0b96615cdc091bc kernel/module.c Christoph Hellwig 2021-01-20  517  static bool find_symbol(struct find_symbol_arg *fsa)
ad9546c9917d44e kernel/module.c Rusty Russell     2008-05-01  518  {
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  519  	static const struct symsearch arr[] = {
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  520  		{ __start___ksymtab, __stop___ksymtab, __start___kcrctab,
367948220fcefca kernel/module.c Christoph Hellwig 2021-02-02  521  		  NOT_GPL_ONLY },
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  522  		{ __start___ksymtab_gpl, __stop___ksymtab_gpl,
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  523  		  __start___kcrctab_gpl,
367948220fcefca kernel/module.c Christoph Hellwig 2021-02-02  524  		  GPL_ONLY },
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  525  	};
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  526  	struct module *mod;
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  527  	unsigned int i;
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  528  
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  529  	module_assert_mutex_or_preempt();
f71d20e961474dd kernel/module.c Arjan van de Ven  2006-06-28  530  
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  531  	for (i = 0; i < ARRAY_SIZE(arr); i++)
0b96615cdc091bc kernel/module.c Christoph Hellwig 2021-01-20  532  		if (find_exported_symbol_in_section(&arr[i], NULL, fsa))
0b96615cdc091bc kernel/module.c Christoph Hellwig 2021-01-20  533  			return true;
^1da177e4c3f415 kernel/module.c Linus Torvalds    2005-04-16  534  
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  535  	list_for_each_entry_rcu(mod, &modules, list,
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  536  				lockdep_is_held(&module_mutex)) {
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02 @537  		struct symsearch arr[] = {
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  538  			{ mod->syms, mod->syms + mod->num_syms, mod->crcs,
367948220fcefca kernel/module.c Christoph Hellwig 2021-02-02  539  			  NOT_GPL_ONLY },
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  540  			{ mod->gpl_syms, mod->gpl_syms + mod->num_gpl_syms,
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  541  			  mod->gpl_crcs,
367948220fcefca kernel/module.c Christoph Hellwig 2021-02-02  542  			  GPL_ONLY },
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  543  		};
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  544  
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  545  		if (mod->state == MODULE_STATE_UNFORMED)
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  546  			continue;
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  547  
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  548  		for (i = 0; i < ARRAY_SIZE(arr); i++)
0b96615cdc091bc kernel/module.c Christoph Hellwig 2021-01-20  549  			if (find_exported_symbol_in_section(&arr[i], mod, fsa))
0b96615cdc091bc kernel/module.c Christoph Hellwig 2021-01-20  550  				return true;
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  551  	}
71e4b309dc4238c kernel/module.c Christoph Hellwig 2021-02-02  552  
0b96615cdc091bc kernel/module.c Christoph Hellwig 2021-01-20  553  	pr_debug("Failed to find symbol %s\n", fsa->name);
0b96615cdc091bc kernel/module.c Christoph Hellwig 2021-01-20  554  	return false;
^1da177e4c3f415 kernel/module.c Linus Torvalds    2005-04-16  555  }
f71d20e961474dd kernel/module.c Arjan van de Ven  2006-06-28  556  

:::::: The code at line 537 was first introduced by commit
:::::: 71e4b309dc4238cba84d144b19004543c76c37e9 module: merge each_symbol_section into find_symbol

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Jessica Yu <jeyu@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
