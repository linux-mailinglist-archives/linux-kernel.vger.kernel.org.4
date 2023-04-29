Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2DD6F21D6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 03:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347204AbjD2BG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 21:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjD2BGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 21:06:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331D41BE6;
        Fri, 28 Apr 2023 18:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682730413; x=1714266413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PlWSoSdqq8TFR6+EZL1jyxd/pZTMFH5V0NmPcGL7Ed0=;
  b=KNoOK4PoZhggldOZ7F82OGMzEcK7cY/EAOWSYdpUI6SM33jto+dyr6ES
   oI+7knFw1tGCaX9CKRdh6S1dnGTHk6OuBRsY47oczvhqFG8Tamg8Gdv2F
   JzkGWHkxxrSdFe2mzduiYPHFf+ih79gZC4wBB00ZH0l/wr5j6PvX90ebq
   V/hbTQCbVB/PaoEXkBADLTlvsTIwzVo4x2POjg0lnlW+THqmbKYfWgxgz
   HX6QPJ7MggYr3JIWdVcp4vP6MNZ2rs8KmYcBqNyiYqM1LXLHAmR7lDbMu
   2R/xMQqSF2ztPkqKsi+tXvuNfO8SqiQj43X+psRHt6qEJtircZL+S+CDf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="411004446"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="411004446"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 18:06:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="839066003"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="839066003"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Apr 2023 18:06:49 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psZ32-0000mf-1B;
        Sat, 29 Apr 2023 01:06:48 +0000
Date:   Sat, 29 Apr 2023 09:06:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v10 07/11] LSM: Helpers for attribute names and filling
 lsm_ctx
Message-ID: <202304290847.WxviiKLP-lkp@intel.com>
References: <20230428203417.159874-8-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428203417.159874-8-casey@schaufler-ca.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Casey,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on acme/perf/core shuah-kselftest/next shuah-kselftest/fixes v6.3]
[cannot apply to linus/master next-20230428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/LSM-Maintain-a-table-of-LSM-attribute-data/20230429-053458
base:   tip/perf/core
patch link:    https://lore.kernel.org/r/20230428203417.159874-8-casey%40schaufler-ca.com
patch subject: [PATCH v10 07/11] LSM: Helpers for attribute names and filling lsm_ctx
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20230429/202304290847.WxviiKLP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/9830f4776196e33bee604b8ce3339177f8fd37f8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Casey-Schaufler/LSM-Maintain-a-table-of-LSM-attribute-data/20230429-053458
        git checkout 9830f4776196e33bee604b8ce3339177f8fd37f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304290847.WxviiKLP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:89,
                    from init/main.c:21:
   include/linux/security.h: In function 'lsm_name_to_attr':
>> include/linux/security.h:516:16: error: 'LSM_ATTR_UNDEF' undeclared (first use in this function)
     516 |         return LSM_ATTR_UNDEF;
         |                ^~~~~~~~~~~~~~
   include/linux/security.h:516:16: note: each undeclared identifier is reported only once for each function it appears in
   init/main.c: At top level:
   init/main.c:775:20: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
     775 | void __init __weak arch_post_acpi_subsys_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   init/main.c:787:20: warning: no previous prototype for 'mem_encrypt_init' [-Wmissing-prototypes]
     787 | void __init __weak mem_encrypt_init(void) { }
         |                    ^~~~~~~~~~~~~~~~
   init/main.c:789:20: warning: no previous prototype for 'poking_init' [-Wmissing-prototypes]
     789 | void __init __weak poking_init(void) { }
         |                    ^~~~~~~~~~~
--
   In file included from init/do_mounts.c:9:
   include/linux/security.h: In function 'lsm_name_to_attr':
>> include/linux/security.h:516:16: error: 'LSM_ATTR_UNDEF' undeclared (first use in this function)
     516 |         return LSM_ATTR_UNDEF;
         |                ^~~~~~~~~~~~~~
   include/linux/security.h:516:16: note: each undeclared identifier is reported only once for each function it appears in
--
   In file included from include/net/scm.h:8,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:46,
                    from include/uapi/linux/if_arp.h:27,
                    from include/linux/if_arp.h:23,
                    from arch/um/drivers/slirp_kern.c:6:
   include/linux/security.h: In function 'lsm_name_to_attr':
>> include/linux/security.h:516:16: error: 'LSM_ATTR_UNDEF' undeclared (first use in this function)
     516 |         return LSM_ATTR_UNDEF;
         |                ^~~~~~~~~~~~~~
   include/linux/security.h:516:16: note: each undeclared identifier is reported only once for each function it appears in
   arch/um/drivers/slirp_kern.c: At top level:
   arch/um/drivers/slirp_kern.c:18:6: warning: no previous prototype for 'slirp_init' [-Wmissing-prototypes]
      18 | void slirp_init(struct net_device *dev, void *data)
         |      ^~~~~~~~~~
--
   In file included from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:89,
                    from arch/x86/um/tls_32.c:8:
   include/linux/security.h: In function 'lsm_name_to_attr':
>> include/linux/security.h:516:16: error: 'LSM_ATTR_UNDEF' undeclared (first use in this function)
     516 |         return LSM_ATTR_UNDEF;
         |                ^~~~~~~~~~~~~~
   include/linux/security.h:516:16: note: each undeclared identifier is reported only once for each function it appears in
   arch/x86/um/tls_32.c: At top level:
   arch/x86/um/tls_32.c:23:5: warning: no previous prototype for 'do_set_thread_area' [-Wmissing-prototypes]
      23 | int do_set_thread_area(struct user_desc *info)
         |     ^~~~~~~~~~~~~~~~~~
   arch/x86/um/tls_32.c:39:5: warning: no previous prototype for 'do_get_thread_area' [-Wmissing-prototypes]
      39 | int do_get_thread_area(struct user_desc *info)
         |     ^~~~~~~~~~~~~~~~~~
   arch/x86/um/tls_32.c:184:5: warning: no previous prototype for 'arch_switch_tls' [-Wmissing-prototypes]
     184 | int arch_switch_tls(struct task_struct *to)
         |     ^~~~~~~~~~~~~~~
--
   In file included from kernel/fork.c:51:
   include/linux/security.h: In function 'lsm_name_to_attr':
>> include/linux/security.h:516:16: error: 'LSM_ATTR_UNDEF' undeclared (first use in this function)
     516 |         return LSM_ATTR_UNDEF;
         |                ^~~~~~~~~~~~~~
   include/linux/security.h:516:16: note: each undeclared identifier is reported only once for each function it appears in
   kernel/fork.c: At top level:
   kernel/fork.c:162:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     162 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:859:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     859 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:954:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
     954 | int __weak arch_dup_task_struct(struct task_struct *dst,
         |            ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:89,
                    from kernel/exit.c:42:
   include/linux/security.h: In function 'lsm_name_to_attr':
>> include/linux/security.h:516:16: error: 'LSM_ATTR_UNDEF' undeclared (first use in this function)
     516 |         return LSM_ATTR_UNDEF;
         |                ^~~~~~~~~~~~~~
   include/linux/security.h:516:16: note: each undeclared identifier is reported only once for each function it appears in
   kernel/exit.c: At top level:
   kernel/exit.c:1915:32: warning: no previous prototype for 'abort' [-Wmissing-prototypes]
    1915 | __weak __function_aligned void abort(void)
         |                                ^~~~~
--
   In file included from include/net/scm.h:8,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:46,
                    from include/linux/if_vlan.h:10,
                    from include/linux/filter.h:21,
                    from kernel/kallsyms.c:25:
   include/linux/security.h: In function 'lsm_name_to_attr':
>> include/linux/security.h:516:16: error: 'LSM_ATTR_UNDEF' undeclared (first use in this function)
     516 |         return LSM_ATTR_UNDEF;
         |                ^~~~~~~~~~~~~~
   include/linux/security.h:516:16: note: each undeclared identifier is reported only once for each function it appears in
   kernel/kallsyms.c: At top level:
   kernel/kallsyms.c:663:12: warning: no previous prototype for 'arch_get_kallsym' [-Wmissing-prototypes]
     663 | int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
         |            ^~~~~~~~~~~~~~~~
--
   In file included from include/linux/fs_context.h:14,
                    from include/linux/pseudo_fs.h:4,
                    from fs/pipe.c:17:
   include/linux/security.h: In function 'lsm_name_to_attr':
>> include/linux/security.h:516:16: error: 'LSM_ATTR_UNDEF' undeclared (first use in this function)
     516 |         return LSM_ATTR_UNDEF;
         |                ^~~~~~~~~~~~~~
   include/linux/security.h:516:16: note: each undeclared identifier is reported only once for each function it appears in
   fs/pipe.c: At top level:
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
   In file included from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:89,
                    from fs/d_path.c:2:
   include/linux/security.h: In function 'lsm_name_to_attr':
>> include/linux/security.h:516:16: error: 'LSM_ATTR_UNDEF' undeclared (first use in this function)
     516 |         return LSM_ATTR_UNDEF;
         |                ^~~~~~~~~~~~~~
   include/linux/security.h:516:16: note: each undeclared identifier is reported only once for each function it appears in
   fs/d_path.c: At top level:
   fs/d_path.c:317:7: warning: no previous prototype for 'simple_dname' [-Wmissing-prototypes]
     317 | char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
         |       ^~~~~~~~~~~~
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
   include/linux/security.h: In function 'lsm_name_to_attr':
>> include/linux/security.h:516:16: error: 'LSM_ATTR_UNDEF' undeclared (first use in this function)
     516 |         return LSM_ATTR_UNDEF;
         |                ^~~~~~~~~~~~~~
   include/linux/security.h:516:16: note: each undeclared identifier is reported only once for each function it appears in
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1681:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1681 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~
--
   In file included from include/net/scm.h:8,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:46,
                    from include/net/sock.h:46,
                    from include/linux/bpf-cgroup.h:11,
                    from net/socket.c:55:
   include/linux/security.h: In function 'lsm_name_to_attr':
>> include/linux/security.h:516:16: error: 'LSM_ATTR_UNDEF' undeclared (first use in this function)
     516 |         return LSM_ATTR_UNDEF;
         |                ^~~~~~~~~~~~~~
   include/linux/security.h:516:16: note: each undeclared identifier is reported only once for each function it appears in
   net/socket.c: In function '__sys_getsockopt':
   net/socket.c:2297:13: warning: variable 'max_optlen' set but not used [-Wunused-but-set-variable]
    2297 |         int max_optlen;
         |             ^~~~~~~~~~
..


vim +/LSM_ATTR_UNDEF +516 include/linux/security.h

   513	
   514	static inline u64 lsm_name_to_attr(const char *name)
   515	{
 > 516		return LSM_ATTR_UNDEF;
   517	}
   518	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
