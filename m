Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27C569BD92
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 23:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjBRW4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 17:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBRW4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 17:56:20 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13861287B
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 14:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676760978; x=1708296978;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+CBYHS47QPvmXzHptEyQdFVK20rxMIFd/c2zsTfFKjk=;
  b=nj7Vz2M+MDZiPZWXqmPsAXQCfHKHiYPGWOfW2T7voKdQH3dL5q1FdQFj
   Hjmno1mWbj1ELVj4UlS/ojAtN0PHhJ+RDqlkSDGAFqmWHFOKHuJUI2fr+
   XTECyHoatOCNkzYE0M++wJMOxYh/VtHZ3s9fng7S/T2sVA1aig+PL2gRs
   REDHgv94pafh965CR3odtQQLAjjy3j4mkDTxNwTEQqefg8UgSnmjjm8bb
   K1yRxIILJUyO1VLiMA8OeVGonR8ZCwF0FMYsG8CClJor/ALFF3AH/ORaB
   Vss4cow38wmKj0DA71LEibpUz+SdUsuLVsypjke8ZksJ+gA5W4GNvjGR0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="332214161"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="332214161"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 14:56:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="780203573"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="780203573"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 Feb 2023 14:56:17 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTW7s-000CpT-1V;
        Sat, 18 Feb 2023 22:56:16 +0000
Date:   Sun, 19 Feb 2023 06:55:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: kernel/module/main.c:4169:1: sparse: sparse: Using plain integer as
 NULL pointer
Message-ID: <202302190638.fKs1ga5r-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5e725d112e1a54c2611d5dffd124a79415d0f0de
commit: cfc1d277891eb499b3b5354df33b30f598683e90 module: Move all into module/
date:   11 months ago
config: s390-randconfig-s052-20230219 (https://download.01.org/0day-ci/archive/20230219/202302190638.fKs1ga5r-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cfc1d277891eb499b3b5354df33b30f598683e90
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout cfc1d277891eb499b3b5354df33b30f598683e90
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302190638.fKs1ga5r-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/module/main.c:2761:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct mod_kallsyms [noderef] __rcu *kallsyms @@     got void * @@
   kernel/module/main.c:2761:23: sparse:     expected struct mod_kallsyms [noderef] __rcu *kallsyms
   kernel/module/main.c:2761:23: sparse:     got void *
>> kernel/module/main.c:4169:1: sparse: sparse: Using plain integer as NULL pointer
>> kernel/module/main.c:4169:1: sparse: sparse: Using plain integer as NULL pointer
>> kernel/module/main.c:4169:1: sparse: sparse: Using plain integer as NULL pointer
>> kernel/module/main.c:4169:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/module/main.c:4189:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/module/main.c:4189:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/module/main.c: note: in included file (through include/linux/mm_types.h, include/linux/buildid.h, include/linux/module.h, ...):
   include/linux/rbtree.h:74:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rbtree.h:74:9: sparse:    struct rb_node [noderef] __rcu *
   include/linux/rbtree.h:74:9: sparse:    struct rb_node *
   include/linux/rbtree.h:74:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rbtree.h:74:9: sparse:    struct rb_node [noderef] __rcu *
   include/linux/rbtree.h:74:9: sparse:    struct rb_node *

vim +4169 kernel/module/main.c

b99b87f70c7785 kernel/module.c Peter Oberparleiter 2009-06-17  4168  
17da2bd90abf42 kernel/module.c Heiko Carstens      2009-01-14 @4169  SYSCALL_DEFINE3(init_module, void __user *, umod,
17da2bd90abf42 kernel/module.c Heiko Carstens      2009-01-14  4170  		unsigned long, len, const char __user *, uargs)
^1da177e4c3f41 kernel/module.c Linus Torvalds      2005-04-16  4171  {
34e1169d996ab1 kernel/module.c Kees Cook           2012-10-16  4172  	int err;
34e1169d996ab1 kernel/module.c Kees Cook           2012-10-16  4173  	struct load_info info = { };
^1da177e4c3f41 kernel/module.c Linus Torvalds      2005-04-16  4174  
34e1169d996ab1 kernel/module.c Kees Cook           2012-10-16  4175  	err = may_init_module();
34e1169d996ab1 kernel/module.c Kees Cook           2012-10-16  4176  	if (err)
34e1169d996ab1 kernel/module.c Kees Cook           2012-10-16  4177  		return err;
^1da177e4c3f41 kernel/module.c Linus Torvalds      2005-04-16  4178  
34e1169d996ab1 kernel/module.c Kees Cook           2012-10-16  4179  	pr_debug("init_module: umod=%p, len=%lu, uargs=%p\n",
34e1169d996ab1 kernel/module.c Kees Cook           2012-10-16  4180  	       umod, len, uargs);
^1da177e4c3f41 kernel/module.c Linus Torvalds      2005-04-16  4181  
34e1169d996ab1 kernel/module.c Kees Cook           2012-10-16  4182  	err = copy_module_from_user(umod, len, &info);
34e1169d996ab1 kernel/module.c Kees Cook           2012-10-16  4183  	if (err)
34e1169d996ab1 kernel/module.c Kees Cook           2012-10-16  4184  		return err;
^1da177e4c3f41 kernel/module.c Linus Torvalds      2005-04-16  4185  
2f3238aebedb24 kernel/module.c Rusty Russell       2012-10-22  4186  	return load_module(&info, uargs, 0);
e24e2e64c468c8 kernel/module.c Alexey Dobriyan     2008-03-10  4187  }
94462ad3b14739 kernel/module.c Steven Rostedt      2010-11-29  4188  

:::::: The code at line 4169 was first introduced by commit
:::::: 17da2bd90abf428523de0fb98f7075e00e3ed42e [CVE-2009-0029] System call wrappers part 08

:::::: TO: Heiko Carstens <heiko.carstens@de.ibm.com>
:::::: CC: Heiko Carstens <heiko.carstens@de.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
