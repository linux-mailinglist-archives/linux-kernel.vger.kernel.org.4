Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66DA68FC96
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 02:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjBIBUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 20:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjBIBUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 20:20:48 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9673624CAD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 17:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675905643; x=1707441643;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HNlu0IIJNX4Rf/9m5j/1/OZEgAXz+UynATcxFfkzVQ0=;
  b=b6N2KOTtZx0qkd3hKXtZwSSxi6so7ZRdqdyoFxjTPAai7o42n9qEU7hs
   60DQkQBYXPquyXmp5TiN2O1HyTpQWZ5b/g5G1DMlf3ny6Uxv4vHZ94Vf8
   fya+xyg+uVijpNwAQ1KOXGRXuQUBx8cpHS9qPuKATlCNTgagnHJIBg3jr
   fKMgCjWvJWQwkKHQ7KXsC5TKVBhc/VVj1QqmGMHH0j7Lx5wrSTShX2bAm
   wLuelljIqM9t4wApkZ0bIyhnk3GY5Vhbf1/5ybLVmMu7mVWp1CTjOMoBT
   iDKs+qmXOi9e7Lx/zyUrQTk7R0ywUsBMdQXhXuADjBEpcG77tfrX3c2Qk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="309627765"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="309627765"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 17:20:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="841404543"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="841404543"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Feb 2023 17:20:20 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPvbn-0004jp-1G;
        Thu, 09 Feb 2023 01:20:19 +0000
Date:   Thu, 9 Feb 2023 09:19:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: kernel/sys.c:2224:16: sparse: sparse: cast removes address space
 '__user' of expression
Message-ID: <202302090906.TbG52nlU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aurelien,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0983f6bf2bfc0789b51ddf7315f644ff4da50acb
commit: 6df2a016c0c8a3d0933ef33dd192ea6606b115e3 riscv: fix build with binutils 2.38
date:   12 months ago
config: riscv-randconfig-s051-20230209 (https://download.01.org/0day-ci/archive/20230209/202302090906.TbG52nlU-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6df2a016c0c8a3d0933ef33dd192ea6606b115e3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6df2a016c0c8a3d0933ef33dd192ea6606b115e3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash drivers/usb/core/ drivers/vhost/ fs/ kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302090906.TbG52nlU-lkp@intel.com

sparse warnings: (new ones prefixed by >>)
>> kernel/sys.c:2224:16: sparse: sparse: cast removes address space '__user' of expression
   kernel/sys.c:1068:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/sys.c:1068:32: sparse:     expected struct task_struct *p1
   kernel/sys.c:1068:32: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/sys.c: note: in included file (through include/linux/rcuwait.h, include/linux/percpu-rwsem.h, include/linux/fs.h, ...):
   include/linux/sched/signal.h:714:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:714:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:714:37: sparse:     got struct spinlock [noderef] __rcu *
--
   kernel/signal.c:2076:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sighand_struct *psig @@     got struct sighand_struct [noderef] __rcu *[noderef] __rcu sighand @@
   kernel/signal.c:2076:14: sparse:     expected struct sighand_struct *psig
   kernel/signal.c:2076:14: sparse:     got struct sighand_struct [noderef] __rcu *[noderef] __rcu sighand
   kernel/signal.c:2105:46: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct task_struct *t @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2105:46: sparse:     expected struct task_struct *t
   kernel/signal.c:2105:46: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2106:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2106:34: sparse:     expected struct task_struct *parent
   kernel/signal.c:2106:34: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2135:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2135:24: sparse:     expected struct task_struct *parent
   kernel/signal.c:2135:24: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2138:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/signal.c:2138:24: sparse:     expected struct task_struct *parent
   kernel/signal.c:2138:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/signal.c:2171:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/signal.c:2171:17: sparse:     expected struct sighand_struct *sighand
   kernel/signal.c:2171:17: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/signal.c:2209:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2209:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2209:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2211:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2211:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2211:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2261:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2261:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2261:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2316:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2316:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2316:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2350:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2350:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2350:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2352:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2352:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2352:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2450:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2450:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2450:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2535:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2535:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2535:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2547:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2547:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2547:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2585:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2585:52: sparse:     expected struct task_struct *tsk
   kernel/signal.c:2585:52: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2587:49: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/signal.c:2625:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/signal.c:2625:49: sparse:     expected struct sighand_struct *sighand
   kernel/signal.c:2625:49: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/signal.c:2961:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2961:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2961:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2981:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2981:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2981:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3048:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3048:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3048:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3050:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3050:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3050:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3201:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3201:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3201:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3204:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3204:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3204:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3591:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3591:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3591:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3603:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3603:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3603:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3608:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3608:35: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3608:35: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3613:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3613:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3613:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4067:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4067:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4067:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4079:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4079:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4079:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4097:11: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct k_sigaction *k @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/signal.c:4097:11: sparse:     expected struct k_sigaction *k
   kernel/signal.c:4097:11: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/signal.c:4099:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4099:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4099:25: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4101:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4101:35: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4101:35: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4149:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4149:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4149:27: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/signal.c:4256:19: sparse: sparse: cast removes address space '__user' of expression
   kernel/signal.c:69:34: sparse: sparse: dereference of noderef expression
   kernel/signal.c:529:35: sparse: sparse: dereference of noderef expression
   kernel/signal.c:557:52: sparse: sparse: dereference of noderef expression
   kernel/signal.c:1034:13: sparse: sparse: dereference of noderef expression
   kernel/signal.c: note: in included file:
   include/linux/signalfd.h:21:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wait_queue_head *wq_head @@     got struct wait_queue_head [noderef] __rcu * @@
   include/linux/signalfd.h:21:13: sparse:     expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:21:13: sparse:     got struct wait_queue_head [noderef] __rcu *
   include/linux/signalfd.h:22:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wait_queue_head *wq_head @@     got struct wait_queue_head [noderef] __rcu * @@
   include/linux/signalfd.h:22:17: sparse:     expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:22:17: sparse:     got struct wait_queue_head [noderef] __rcu *
   kernel/signal.c: note: in included file (through include/linux/sched/cputime.h):
   include/linux/sched/signal.h:714:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:714:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:714:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:1301:9: sparse: sparse: context imbalance in 'do_send_sig_info' - different lock contexts for basic block
   kernel/signal.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:725:9: sparse: sparse: context imbalance in '__lock_task_sighand' - different lock contexts for basic block
   kernel/signal.c: note: in included file (through include/linux/sched/cputime.h):
   include/linux/sched/signal.h:714:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:714:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:714:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c: note: in included file:
   include/linux/signalfd.h:21:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wait_queue_head *wq_head @@     got struct wait_queue_head [noderef] __rcu * @@
   include/linux/signalfd.h:21:13: sparse:     expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:21:13: sparse:     got struct wait_queue_head [noderef] __rcu *
   include/linux/signalfd.h:22:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wait_queue_head *wq_head @@     got struct wait_queue_head [noderef] __rcu * @@
   include/linux/signalfd.h:22:17: sparse:     expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:22:17: sparse:     got struct wait_queue_head [noderef] __rcu *
   kernel/signal.c: note: in included file (through include/linux/sched/cputime.h):
   include/linux/sched/signal.h:714:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:714:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:714:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:725:9: sparse: sparse: context imbalance in 'send_sigqueue' - wrong count at exit
   kernel/signal.c:2058:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2058:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2058:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2058:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c: note: in included file (through arch/riscv/include/asm/perf_event.h, include/linux/perf_event.h, include/linux/trace_events.h, ...):
   include/linux/ptrace.h:99:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:99:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:99:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:99:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:99:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:99:60: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2377:13: sparse: sparse: context imbalance in 'do_signal_stop' - different lock contexts for basic block
   kernel/signal.c:2587:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2587:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2587:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2587:49: sparse: sparse: dereference of noderef expression
   include/linux/ptrace.h:99:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:99:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:99:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:99:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:99:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:99:60: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2698:17: sparse: sparse: context imbalance in 'get_signal' - different lock contexts for basic block
   kernel/signal.c:4068:33: sparse: sparse: dereference of noderef expression
--
   fs/eventpoll.c: note: in included file:
>> include/linux/eventpoll.h:81:13: sparse: sparse: restricted __poll_t degrades to integer
>> include/linux/eventpoll.h:81:13: sparse: sparse: restricted __poll_t degrades to integer
   include/linux/eventpoll.h:81:13: sparse: sparse: cast from restricted __poll_t
--
>> drivers/usb/core/devio.c:2045:13: sparse: sparse: cast removes address space '__user' of expression
--
   drivers/vhost/vhost.c:969:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:969:16: sparse: sparse: restricted __virtio16 degrades to integer
>> drivers/vhost/vhost.c:969:16: sparse: sparse: cast from restricted __virtio16
   drivers/vhost/vhost.c:969:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:969:16: sparse: sparse: restricted __virtio16 degrades to integer
>> drivers/vhost/vhost.c:969:16: sparse: sparse: cast from restricted __virtio16
   drivers/vhost/vhost.c:954:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:954:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:954:16: sparse: sparse: cast from restricted __virtio16
   drivers/vhost/vhost.c:954:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:954:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:954:16: sparse: sparse: cast from restricted __virtio16
   drivers/vhost/vhost.c:1046:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1046:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1046:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:1046:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1046:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1046:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:1021:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1021:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1021:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:1021:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1021:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1021:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:1027:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1027:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1027:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:1027:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1027:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1027:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:976:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:976:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:976:16: sparse: sparse: cast from restricted __virtio16
   drivers/vhost/vhost.c:976:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:976:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:976:16: sparse: sparse: cast from restricted __virtio16
   drivers/vhost/vhost.c:1034:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1034:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1034:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:1034:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1034:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1034:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:1040:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1040:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1040:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:1040:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1040:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1040:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:1021:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:1021:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:1021:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:1021:16: sparse: sparse: cast to restricted __virtio16
--
>> kernel/futex/syscalls.c:77:16: sparse: sparse: cast removes address space '__user' of expression
--
>> fs/ecryptfs/miscdev.c:285:13: sparse: sparse: restricted __be32 degrades to integer
>> fs/ecryptfs/miscdev.c:285:13: sparse: sparse: restricted __be32 degrades to integer
   fs/ecryptfs/miscdev.c:285:13: sparse: sparse: cast from restricted __be32

vim +/__user +2224 kernel/sys.c

300f786b2683f8 Cyrill Gorcunov  2012-06-07  2220  
52b3694157e3aa Amnon Shiloh     2013-04-30  2221  #ifdef CONFIG_CHECKPOINT_RESTORE
986b9eacb25910 Rasmus Villemoes 2020-10-24  2222  static int prctl_get_tid_address(struct task_struct *me, int __user * __user *tid_addr)
300f786b2683f8 Cyrill Gorcunov  2012-06-07  2223  {
300f786b2683f8 Cyrill Gorcunov  2012-06-07 @2224  	return put_user(me->clear_child_tid, tid_addr);
300f786b2683f8 Cyrill Gorcunov  2012-06-07  2225  }
52b3694157e3aa Amnon Shiloh     2013-04-30  2226  #else
986b9eacb25910 Rasmus Villemoes 2020-10-24  2227  static int prctl_get_tid_address(struct task_struct *me, int __user * __user *tid_addr)
300f786b2683f8 Cyrill Gorcunov  2012-06-07  2228  {
300f786b2683f8 Cyrill Gorcunov  2012-06-07  2229  	return -EINVAL;
300f786b2683f8 Cyrill Gorcunov  2012-06-07  2230  }
028ee4be34a09a Cyrill Gorcunov  2012-01-12  2231  #endif
028ee4be34a09a Cyrill Gorcunov  2012-01-12  2232  

:::::: The code at line 2224 was first introduced by commit
:::::: 300f786b2683f8bb1ec0afb6e1851183a479c86d c/r: prctl: add ability to get clear_tid_address

:::::: TO: Cyrill Gorcunov <gorcunov@openvz.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
