Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B0D6A0231
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 05:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjBWE57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 23:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjBWE5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 23:57:55 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2709740C5;
        Wed, 22 Feb 2023 20:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677128272; x=1708664272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=89xzBCBvGlaeg6paYol3WNZXC6riybGdTUnrw7DnLEg=;
  b=mI6oLixFboWgPb3AfesNk+alCKwhESuCEPKAdLt0meq4Yern16MRH31u
   EW3US5ZHcIJaC+Hrn/fTv5Szp4Va5pkqYpzD1L+4hte2akQ4DaxUaqAWy
   0PHMOqXpKzrwHz2INSFs48ERHA5xowEwo7UTtmuOUN4nVJn/cZE/wxSXi
   qNZOti56Zua0Sl7EsbhaGkFWk0GvnyP7GthuCbl2WlLlxZNWeWoUmShsQ
   0liR3VTvPT0RUj+z2QzQE9BDrjYdEmIz3TLsj8wQRlSuxHllMonlKLu9E
   yU96JXjiWXORWcBhuSm16tvL+MYBfszhJDf2vJsxQ9ZrsOPIH5ZC50BoP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="316843217"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="316843217"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 20:57:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="1001264304"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="1001264304"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Feb 2023 20:57:47 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pV3fv-00012v-0f;
        Thu, 23 Feb 2023 04:57:47 +0000
Date:   Thu, 23 Feb 2023 12:57:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v6 04/11] LSM: syscalls for current process attributes
Message-ID: <202302231247.4CJvLv71-lkp@intel.com>
References: <20230222200838.8149-5-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222200838.8149-5-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Casey,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on acme/perf/core shuah-kselftest/next shuah-kselftest/fixes v6.2]
[cannot apply to linus/master next-20230222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/LSM-Maintain-a-table-of-LSM-attribute-data/20230223-050902
patch link:    https://lore.kernel.org/r/20230222200838.8149-5-casey%40schaufler-ca.com
patch subject: [PATCH v6 04/11] LSM: syscalls for current process attributes
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20230223/202302231247.4CJvLv71-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/04ba82c1bd629c2114ad851b4723d6e8b0f9d08f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Casey-Schaufler/LSM-Maintain-a-table-of-LSM-attribute-data/20230223-050902
        git checkout 04ba82c1bd629c2114ad851b4723d6e8b0f9d08f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302231247.4CJvLv71-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:89,
                    from init/main.c:21:
>> include/linux/security.h:1356:1: error: expected identifier or '(' before '{' token
    1356 | {
         | ^
   include/linux/security.h:1363:1: error: expected identifier or '(' before '{' token
    1363 | {
         | ^
   init/main.c:775:20: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
     775 | void __init __weak arch_post_acpi_subsys_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   init/main.c:787:20: warning: no previous prototype for 'mem_encrypt_init' [-Wmissing-prototypes]
     787 | void __init __weak mem_encrypt_init(void) { }
         |                    ^~~~~~~~~~~~~~~~
   init/main.c:789:20: warning: no previous prototype for 'poking_init' [-Wmissing-prototypes]
     789 | void __init __weak poking_init(void) { }
         |                    ^~~~~~~~~~~
   In file included from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:89,
                    from init/main.c:21:
   include/linux/security.h:1353:19: warning: 'security_getselfattr' declared 'static' but never defined [-Wunused-function]
    1353 | static inline int security_getselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
   include/linux/security.h:1360:19: warning: 'security_setselfattr' declared 'static' but never defined [-Wunused-function]
    1360 | static inline int security_setselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
--
   In file included from init/do_mounts.c:9:
>> include/linux/security.h:1356:1: error: expected identifier or '(' before '{' token
    1356 | {
         | ^
   include/linux/security.h:1363:1: error: expected identifier or '(' before '{' token
    1363 | {
         | ^
   In file included from init/do_mounts.c:9:
   include/linux/security.h:1353:19: warning: 'security_getselfattr' declared 'static' but never defined [-Wunused-function]
    1353 | static inline int security_getselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
   include/linux/security.h:1360:19: warning: 'security_setselfattr' declared 'static' but never defined [-Wunused-function]
    1360 | static inline int security_setselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/net/scm.h:8,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:46,
                    from include/uapi/linux/if_arp.h:27,
                    from include/linux/if_arp.h:23,
                    from arch/um/drivers/slirp_kern.c:6:
>> include/linux/security.h:1356:1: error: expected identifier or '(' before '{' token
    1356 | {
         | ^
   include/linux/security.h:1363:1: error: expected identifier or '(' before '{' token
    1363 | {
         | ^
   arch/um/drivers/slirp_kern.c:18:6: warning: no previous prototype for 'slirp_init' [-Wmissing-prototypes]
      18 | void slirp_init(struct net_device *dev, void *data)
         |      ^~~~~~~~~~
   In file included from include/net/scm.h:8,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:46,
                    from include/uapi/linux/if_arp.h:27,
                    from include/linux/if_arp.h:23,
                    from arch/um/drivers/slirp_kern.c:6:
   include/linux/security.h:1353:19: warning: 'security_getselfattr' declared 'static' but never defined [-Wunused-function]
    1353 | static inline int security_getselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
   include/linux/security.h:1360:19: warning: 'security_setselfattr' declared 'static' but never defined [-Wunused-function]
    1360 | static inline int security_setselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:89,
                    from arch/x86/um/syscalls_64.c:10:
>> include/linux/security.h:1356:1: error: expected identifier or '(' before '{' token
    1356 | {
         | ^
   include/linux/security.h:1363:1: error: expected identifier or '(' before '{' token
    1363 | {
         | ^
   arch/x86/um/syscalls_64.c:84:6: warning: no previous prototype for 'arch_switch_to' [-Wmissing-prototypes]
      84 | void arch_switch_to(struct task_struct *to)
         |      ^~~~~~~~~~~~~~
   In file included from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:89,
                    from arch/x86/um/syscalls_64.c:10:
   include/linux/security.h:1353:19: warning: 'security_getselfattr' declared 'static' but never defined [-Wunused-function]
    1353 | static inline int security_getselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
   include/linux/security.h:1360:19: warning: 'security_setselfattr' declared 'static' but never defined [-Wunused-function]
    1360 | static inline int security_setselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
--
   In file included from kernel/fork.c:51:
>> include/linux/security.h:1356:1: error: expected identifier or '(' before '{' token
    1356 | {
         | ^
   include/linux/security.h:1363:1: error: expected identifier or '(' before '{' token
    1363 | {
         | ^
   kernel/fork.c:162:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     162 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:862:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     862 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:957:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
     957 | int __weak arch_dup_task_struct(struct task_struct *dst,
         |            ^~~~~~~~~~~~~~~~~~~~
   In file included from kernel/fork.c:51:
   include/linux/security.h:1353:19: warning: 'security_getselfattr' declared 'static' but never defined [-Wunused-function]
    1353 | static inline int security_getselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
   include/linux/security.h:1360:19: warning: 'security_setselfattr' declared 'static' but never defined [-Wunused-function]
    1360 | static inline int security_setselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:89,
                    from kernel/exit.c:42:
>> include/linux/security.h:1356:1: error: expected identifier or '(' before '{' token
    1356 | {
         | ^
   include/linux/security.h:1363:1: error: expected identifier or '(' before '{' token
    1363 | {
         | ^
   kernel/exit.c:1901:13: warning: no previous prototype for 'abort' [-Wmissing-prototypes]
    1901 | __weak void abort(void)
         |             ^~~~~
   In file included from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:89,
                    from kernel/exit.c:42:
   include/linux/security.h:1353:19: warning: 'security_getselfattr' declared 'static' but never defined [-Wunused-function]
    1353 | static inline int security_getselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
   include/linux/security.h:1360:19: warning: 'security_setselfattr' declared 'static' but never defined [-Wunused-function]
    1360 | static inline int security_setselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/net/scm.h:8,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:46,
                    from include/linux/if_vlan.h:10,
                    from include/linux/filter.h:20,
                    from kernel/kallsyms.c:25:
>> include/linux/security.h:1356:1: error: expected identifier or '(' before '{' token
    1356 | {
         | ^
   include/linux/security.h:1363:1: error: expected identifier or '(' before '{' token
    1363 | {
         | ^
   kernel/kallsyms.c:663:12: warning: no previous prototype for 'arch_get_kallsym' [-Wmissing-prototypes]
     663 | int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
         |            ^~~~~~~~~~~~~~~~
   In file included from include/net/scm.h:8,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:46,
                    from include/linux/if_vlan.h:10,
                    from include/linux/filter.h:20,
                    from kernel/kallsyms.c:25:
   include/linux/security.h:1353:19: warning: 'security_getselfattr' declared 'static' but never defined [-Wunused-function]
    1353 | static inline int security_getselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
   include/linux/security.h:1360:19: warning: 'security_setselfattr' declared 'static' but never defined [-Wunused-function]
    1360 | static inline int security_setselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/fs_context.h:14,
                    from include/linux/pseudo_fs.h:4,
                    from fs/pipe.c:17:
>> include/linux/security.h:1356:1: error: expected identifier or '(' before '{' token
    1356 | {
         | ^
   include/linux/security.h:1363:1: error: expected identifier or '(' before '{' token
    1363 | {
         | ^
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
   In file included from include/linux/fs_context.h:14,
                    from include/linux/pseudo_fs.h:4,
                    from fs/pipe.c:17:
   include/linux/security.h:1353:19: warning: 'security_getselfattr' declared 'static' but never defined [-Wunused-function]
    1353 | static inline int security_getselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
   include/linux/security.h:1360:19: warning: 'security_setselfattr' declared 'static' but never defined [-Wunused-function]
    1360 | static inline int security_setselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:89,
                    from fs/d_path.c:2:
>> include/linux/security.h:1356:1: error: expected identifier or '(' before '{' token
    1356 | {
         | ^
   include/linux/security.h:1363:1: error: expected identifier or '(' before '{' token
    1363 | {
         | ^
   fs/d_path.c:317:7: warning: no previous prototype for 'simple_dname' [-Wmissing-prototypes]
     317 | char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
         |       ^~~~~~~~~~~~
   In file included from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:89,
                    from fs/d_path.c:2:
   include/linux/security.h:1353:19: warning: 'security_getselfattr' declared 'static' but never defined [-Wunused-function]
    1353 | static inline int security_getselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
   include/linux/security.h:1360:19: warning: 'security_setselfattr' declared 'static' but never defined [-Wunused-function]
    1360 | static inline int security_setselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:89,
                    from io_uring/io_uring.c:45:
>> include/linux/security.h:1356:1: error: expected identifier or '(' before '{' token
    1356 | {
         | ^
   include/linux/security.h:1363:1: error: expected identifier or '(' before '{' token
    1363 | {
         | ^
   io_uring/io_uring.c: In function '__io_submit_flush_completions':
   io_uring/io_uring.c:1448:40: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
    1448 |         struct io_wq_work_node *node, *prev;
         |                                        ^~~~
   In file included from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:89,
                    from io_uring/io_uring.c:45:
   io_uring/io_uring.c: At top level:
   include/linux/security.h:1353:19: warning: 'security_getselfattr' declared 'static' but never defined [-Wunused-function]
    1353 | static inline int security_getselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
   include/linux/security.h:1360:19: warning: 'security_setselfattr' declared 'static' but never defined [-Wunused-function]
    1360 | static inline int security_setselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/net/scm.h:8,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:46,
                    from include/net/sock.h:46,
                    from include/linux/tcp.h:19,
                    from include/linux/ipv6.h:93,
                    from include/net/addrconf.h:52,
                    from lib/vsprintf.c:40:
>> include/linux/security.h:1356:1: error: expected identifier or '(' before '{' token
    1356 | {
         | ^
   include/linux/security.h:1363:1: error: expected identifier or '(' before '{' token
    1363 | {
         | ^
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1681:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1681 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~
   In file included from include/net/scm.h:8,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:46,
                    from include/net/sock.h:46,
                    from include/linux/tcp.h:19,
                    from include/linux/ipv6.h:93,
                    from include/net/addrconf.h:52,
                    from lib/vsprintf.c:40:
   lib/vsprintf.c: At top level:
   include/linux/security.h:1353:19: warning: 'security_getselfattr' declared 'static' but never defined [-Wunused-function]
    1353 | static inline int security_getselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
   include/linux/security.h:1360:19: warning: 'security_setselfattr' declared 'static' but never defined [-Wunused-function]
    1360 | static inline int security_setselfattr(u64 __user attr,
         |                   ^~~~~~~~~~~~~~~~~~~~
..


vim +1356 include/linux/security.h

  1352	
  1353	static inline int security_getselfattr(u64 __user attr,
  1354					       struct lsm_ctx __user *ctx,
  1355					       size_t __user *size);
> 1356	{
  1357		return -EINVAL;
  1358	}
  1359	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
