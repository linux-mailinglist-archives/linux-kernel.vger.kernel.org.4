Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EA8693DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 06:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjBMF3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 00:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBMF27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 00:28:59 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3D21BC
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 21:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676266137; x=1707802137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RUQMeqsO6DZNKCd9iPnV70FSMcN+IXmCZMUJT/5bYUA=;
  b=Baz9SlbSD1XnI47JG3M85vaES9ezUKT2OWjtiuZSxpQeLpatXkgHdqct
   FLTNuyQlrLxP4Wsghw9L4/JGMKm/TlsyfL+9M23h5n3mfvyn3VRNU/x1h
   Z2Phqudscx1YPre5GkOsfA4elTKaFwFPK6CHc9kLsZaGCyoaG6HKqU7oi
   Vx8GGjeiXNlJfNAmgp1Fb/PMKRes2+mbDPiK+STzdvuvZkWpIYAhdUibZ
   TUJnz2x0PCizxz96IO6ViBaDjgF/rvvBZBtxawUPmyI0m2470oXKotcpw
   tsLm+hJg3QbBSzSMGkGbhnq9kH6zx6MUWvyNcNDbWBGDL0paQwt7Ka5IF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="330820842"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="330820842"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 21:28:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="914183654"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="914183654"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 12 Feb 2023 21:28:08 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pRRNn-0007a5-1a;
        Mon, 13 Feb 2023 05:28:07 +0000
Date:   Mon, 13 Feb 2023 13:28:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Christie <michael.christie@oracle.com>, brauner@kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 1/5] kernel: Move kernel_clone_args's fn to new struct
Message-ID: <202302131343.whX9lCGw-lkp@intel.com>
References: <20230213010020.1813-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213010020.1813-2-michael.christie@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on linus/master v6.2-rc8]
[cannot apply to next-20230210]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Christie/kernel-Move-kernel_clone_args-s-fn-to-new-struct/20230213-090304
patch link:    https://lore.kernel.org/r/20230213010020.1813-2-michael.christie%40oracle.com
patch subject: [PATCH 1/5] kernel: Move kernel_clone_args's fn to new struct
config: csky-buildonly-randconfig-r004-20230212 (https://download.01.org/0day-ci/archive/20230213/202302131343.whX9lCGw-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3eb77c0672cdc93fa577d5feb91b79f272d883b7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mike-Christie/kernel-Move-kernel_clone_args-s-fn-to-new-struct/20230213-090304
        git checkout 3eb77c0672cdc93fa577d5feb91b79f272d883b7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash fs/ kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302131343.whX9lCGw-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:740,
                    from fs/open.c:9:
>> include/linux/sched/task.h:99:14: error: conflicting types for 'kernel_thread'; have 'pid_t(struct kernel_clone_fns *, void *, long unsigned int)' {aka 'int(struct kernel_clone_fns *, void *, long unsigned int)'}
      99 | extern pid_t kernel_thread(struct kernel_clone_fns *fns, void *fn_arg,
         |              ^~~~~~~~~~~~~
   In file included from arch/csky/include/asm/thread_info.h:10,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/csky/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7:
   arch/csky/include/asm/processor.h:75:12: note: previous declaration of 'kernel_thread' with type 'int(int (*)(void *), void *, long unsigned int)'
      75 | extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
         |            ^~~~~~~~~~~~~
--
   In file included from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:740,
                    from fs/pipe.c:8:
>> include/linux/sched/task.h:99:14: error: conflicting types for 'kernel_thread'; have 'pid_t(struct kernel_clone_fns *, void *, long unsigned int)' {aka 'int(struct kernel_clone_fns *, void *, long unsigned int)'}
      99 | extern pid_t kernel_thread(struct kernel_clone_fns *fns, void *fn_arg,
         |              ^~~~~~~~~~~~~
   In file included from arch/csky/include/asm/thread_info.h:10,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/csky/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7:
   arch/csky/include/asm/processor.h:75:12: note: previous declaration of 'kernel_thread' with type 'int(int (*)(void *), void *, long unsigned int)'
      75 | extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
         |            ^~~~~~~~~~~~~
   fs/pipe.c:757:15: warning: no previous prototype for 'account_pipe_buffers' [-Wmissing-prototypes]
     757 | unsigned long account_pipe_buffers(struct user_struct *user,
         |               ^~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:763:6: warning: no previous prototype for 'too_many_pipe_buffers_soft' [-Wmissing-prototypes]
     763 | bool too_many_pipe_buffers_soft(unsigned long user_bufs)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:770:6: warning: no previous prototype for 'too_many_pipe_buffers_hard' [-Wmissing-prototypes]
     770 | bool too_many_pipe_buffers_hard(unsigned long user_bufs)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:777:6: warning: no previous prototype for 'pipe_is_unprivileged_user' [-Wmissing-prototypes]
     777 | bool pipe_is_unprivileged_user(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:1253:5: warning: no previous prototype for 'pipe_resize_ring' [-Wmissing-prototypes]
    1253 | int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
         |     ^~~~~~~~~~~~~~~~
--
   In file included from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/uapi/linux/aio_abi.h:31,
                    from include/linux/syscalls.h:77,
                    from fs/d_path.c:2:
>> include/linux/sched/task.h:99:14: error: conflicting types for 'kernel_thread'; have 'pid_t(struct kernel_clone_fns *, void *, long unsigned int)' {aka 'int(struct kernel_clone_fns *, void *, long unsigned int)'}
      99 | extern pid_t kernel_thread(struct kernel_clone_fns *fns, void *fn_arg,
         |              ^~~~~~~~~~~~~
   In file included from arch/csky/include/asm/thread_info.h:10,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/csky/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:56,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6:
   arch/csky/include/asm/processor.h:75:12: note: previous declaration of 'kernel_thread' with type 'int(int (*)(void *), void *, long unsigned int)'
      75 | extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
         |            ^~~~~~~~~~~~~
   fs/d_path.c:317:7: warning: no previous prototype for 'simple_dname' [-Wmissing-prototypes]
     317 | char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
         |       ^~~~~~~~~~~~
--
   In file included from kernel/fork.c:23:
>> include/linux/sched/task.h:99:14: error: conflicting types for 'kernel_thread'; have 'pid_t(struct kernel_clone_fns *, void *, long unsigned int)' {aka 'int(struct kernel_clone_fns *, void *, long unsigned int)'}
      99 | extern pid_t kernel_thread(struct kernel_clone_fns *fns, void *fn_arg,
         |              ^~~~~~~~~~~~~
   In file included from arch/csky/include/asm/thread_info.h:10,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/csky/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:15,
                    from kernel/fork.c:16:
   arch/csky/include/asm/processor.h:75:12: note: previous declaration of 'kernel_thread' with type 'int(int (*)(void *), void *, long unsigned int)'
      75 | extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
         |            ^~~~~~~~~~~~~
   kernel/fork.c:162:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     162 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:862:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     862 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:957:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
     957 | int __weak arch_dup_task_struct(struct task_struct *dst,
         |            ^~~~~~~~~~~~~~~~~~~~
>> kernel/fork.c:2740:7: error: conflicting types for 'kernel_thread'; have 'pid_t(struct kernel_clone_fns *, void *, long unsigned int)' {aka 'int(struct kernel_clone_fns *, void *, long unsigned int)'}
    2740 | pid_t kernel_thread(struct kernel_clone_fns *fns, void *fn_arg,
         |       ^~~~~~~~~~~~~
   arch/csky/include/asm/processor.h:75:12: note: previous declaration of 'kernel_thread' with type 'int(int (*)(void *), void *, long unsigned int)'
      75 | extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
         |            ^~~~~~~~~~~~~
--
   In file included from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:740,
                    from include/linux/kallsyms.h:13,
                    from include/linux/ftrace.h:13,
                    from include/linux/kprobes.h:28,
                    from include/linux/kgdb.h:19,
                    from kernel/panic.c:15:
>> include/linux/sched/task.h:99:14: error: conflicting types for 'kernel_thread'; have 'pid_t(struct kernel_clone_fns *, void *, long unsigned int)' {aka 'int(struct kernel_clone_fns *, void *, long unsigned int)'}
      99 | extern pid_t kernel_thread(struct kernel_clone_fns *fns, void *fn_arg,
         |              ^~~~~~~~~~~~~
   In file included from arch/csky/include/asm/thread_info.h:10,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/csky/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/percpu.h:6,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/interrupt.h:11,
                    from kernel/panic.c:14:
   arch/csky/include/asm/processor.h:75:12: note: previous declaration of 'kernel_thread' with type 'int(int (*)(void *), void *, long unsigned int)'
      75 | extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
         |            ^~~~~~~~~~~~~
   kernel/panic.c: In function '__warn':
   kernel/panic.c:658:17: warning: function '__warn' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     658 |                 vprintk(args->fmt, args->args);
         |                 ^~~~~~~
--
   In file included from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:740,
                    from kernel/exit.c:8:
>> include/linux/sched/task.h:99:14: error: conflicting types for 'kernel_thread'; have 'pid_t(struct kernel_clone_fns *, void *, long unsigned int)' {aka 'int(struct kernel_clone_fns *, void *, long unsigned int)'}
      99 | extern pid_t kernel_thread(struct kernel_clone_fns *fns, void *fn_arg,
         |              ^~~~~~~~~~~~~
   In file included from arch/csky/include/asm/thread_info.h:10,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/csky/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7:
   arch/csky/include/asm/processor.h:75:12: note: previous declaration of 'kernel_thread' with type 'int(int (*)(void *), void *, long unsigned int)'
      75 | extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
         |            ^~~~~~~~~~~~~
   kernel/exit.c:1908:13: warning: no previous prototype for 'abort' [-Wmissing-prototypes]
    1908 | __weak void abort(void)
         |             ^~~~~
--
   In file included from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:740,
                    from include/linux/kallsyms.h:13,
                    from kernel/kallsyms.c:15:
>> include/linux/sched/task.h:99:14: error: conflicting types for 'kernel_thread'; have 'pid_t(struct kernel_clone_fns *, void *, long unsigned int)' {aka 'int(struct kernel_clone_fns *, void *, long unsigned int)'}
      99 | extern pid_t kernel_thread(struct kernel_clone_fns *fns, void *fn_arg,
         |              ^~~~~~~~~~~~~
   In file included from arch/csky/include/asm/thread_info.h:10,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/csky/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:56,
                    from include/linux/kref.h:16,
                    from include/linux/mm_types.h:8,
                    from include/linux/buildid.h:5,
                    from include/linux/kallsyms.h:10:
   arch/csky/include/asm/processor.h:75:12: note: previous declaration of 'kernel_thread' with type 'int(int (*)(void *), void *, long unsigned int)'
      75 | extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
         |            ^~~~~~~~~~~~~
   kernel/kallsyms.c:663:12: warning: no previous prototype for 'arch_get_kallsym' [-Wmissing-prototypes]
     663 | int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
         |            ^~~~~~~~~~~~~~~~
--
   In file included from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:740,
                    from include/linux/kallsyms.h:13,
                    from include/linux/ftrace.h:13,
                    from include/linux/kprobes.h:28,
                    from kernel/kprobes.c:23:
>> include/linux/sched/task.h:99:14: error: conflicting types for 'kernel_thread'; have 'pid_t(struct kernel_clone_fns *, void *, long unsigned int)' {aka 'int(struct kernel_clone_fns *, void *, long unsigned int)'}
      99 | extern pid_t kernel_thread(struct kernel_clone_fns *fns, void *fn_arg,
         |              ^~~~~~~~~~~~~
   In file included from arch/csky/include/asm/thread_info.h:10,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/current.h:5,
                    from ./arch/csky/include/generated/asm/current.h:1,
                    from include/linux/mutex.h:14,
                    from include/linux/notifier.h:14,
                    from include/linux/kprobes.h:21:
   arch/csky/include/asm/processor.h:75:12: note: previous declaration of 'kernel_thread' with type 'int(int (*)(void *), void *, long unsigned int)'
      75 | extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
         |            ^~~~~~~~~~~~~
   kernel/kprobes.c:1856:12: warning: no previous prototype for 'kprobe_exceptions_notify' [-Wmissing-prototypes]
    1856 | int __weak kprobe_exceptions_notify(struct notifier_block *self,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:740,
                    from kernel/iomem.c:5:
>> include/linux/sched/task.h:99:14: error: conflicting types for 'kernel_thread'; have 'pid_t(struct kernel_clone_fns *, void *, long unsigned int)' {aka 'int(struct kernel_clone_fns *, void *, long unsigned int)'}
      99 | extern pid_t kernel_thread(struct kernel_clone_fns *fns, void *fn_arg,
         |              ^~~~~~~~~~~~~
   In file included from arch/csky/include/asm/thread_info.h:10,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/current.h:5,
                    from ./arch/csky/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from kernel/iomem.c:2:
   arch/csky/include/asm/processor.h:75:12: note: previous declaration of 'kernel_thread' with type 'int(int (*)(void *), void *, long unsigned int)'
      75 | extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
         |            ^~~~~~~~~~~~~
   kernel/iomem.c:9:22: warning: no previous prototype for 'ioremap_cache' [-Wmissing-prototypes]
       9 | __weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
         |                      ^~~~~~~~~~~~~
--
   In file included from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from fs/proc/meminfo.c:2:
>> include/linux/sched/task.h:99:14: error: conflicting types for 'kernel_thread'; have 'pid_t(struct kernel_clone_fns *, void *, long unsigned int)' {aka 'int(struct kernel_clone_fns *, void *, long unsigned int)'}
      99 | extern pid_t kernel_thread(struct kernel_clone_fns *fns, void *fn_arg,
         |              ^~~~~~~~~~~~~
   In file included from arch/csky/include/asm/thread_info.h:10,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/csky/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:56,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6:
   arch/csky/include/asm/processor.h:75:12: note: previous declaration of 'kernel_thread' with type 'int(int (*)(void *), void *, long unsigned int)'
      75 | extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
         |            ^~~~~~~~~~~~~
   fs/proc/meminfo.c:22:28: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
      22 | void __attribute__((weak)) arch_report_meminfo(struct seq_file *m)
         |                            ^~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/debugfs.h:15,
                    from kernel/locking/lock_events.c:19:
>> include/linux/sched/task.h:99:14: error: conflicting types for 'kernel_thread'; have 'pid_t(struct kernel_clone_fns *, void *, long unsigned int)' {aka 'int(struct kernel_clone_fns *, void *, long unsigned int)'}
      99 | extern pid_t kernel_thread(struct kernel_clone_fns *fns, void *fn_arg,
         |              ^~~~~~~~~~~~~
   In file included from arch/csky/include/asm/thread_info.h:10,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/csky/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:56,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6:
   arch/csky/include/asm/processor.h:75:12: note: previous declaration of 'kernel_thread' with type 'int(int (*)(void *), void *, long unsigned int)'
      75 | extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
         |            ^~~~~~~~~~~~~
   kernel/locking/lock_events.c:61:16: warning: no previous prototype for 'lockevent_read' [-Wmissing-prototypes]
      61 | ssize_t __weak lockevent_read(struct file *file, char __user *user_buf,
         |                ^~~~~~~~~~~~~~
..


vim +99 include/linux/sched/task.h

    94	
    95	extern pid_t kernel_clone(struct kernel_clone_args *kargs);
    96	struct task_struct *create_io_thread(struct kernel_clone_fns *fns, void *fn_arg,
    97					     int node);
    98	struct task_struct *fork_idle(int);
  > 99	extern pid_t kernel_thread(struct kernel_clone_fns *fns, void *fn_arg,
   100				   unsigned long flags);
   101	extern pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags);
   102	extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
   103	int kernel_wait(pid_t pid, int *stat);
   104	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
