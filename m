Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D736338AB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiKVJiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiKVJiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:38:14 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE9F23151
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669109890; x=1700645890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5cBDtKNfDNnt23CJ73pMLemUTU0TTJoxHr4kWBA+FjM=;
  b=hyQ1jGxGEMFzQGyNhRU5xhsyo5LY6U/bZ3ZoPg/odqPWlOlGwjylkrGj
   im8p6fw6WoRPGmZjpJD+37wvTcKtRhEPx9U2xbRXf3/fs393am7IGfwhs
   BB7L4A1tXs0VDXoMucIGsN32OKepmChp/Z3/MIb0tYowOGu9VCFkTPd08
   x6svpokiSDWw8DX+y578FSfrUTTqOl/CPgRZwl+a+6kxl504UJX/X1eTW
   PjYnam5iyXto81pQE1LjBEXN68KIiZHi5RkeWpL/k0kRkTaFX0j1tKCFt
   hndyo1ULn8kMMiiG/tfdAbbM+EA3apv+5C4yhpGknrGa3t+WZuO/KsDfm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="400065158"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="400065158"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 01:38:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="710135645"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="710135645"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Nov 2022 01:38:07 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxPjC-0001Jj-1A;
        Tue, 22 Nov 2022 09:38:06 +0000
Date:   Tue, 22 Nov 2022 17:37:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        GUO Zihua <guozihua@huawei.com>
Subject: Re: [PATCH 2/2] net/9p: fix response size check in p9_check_errors()
Message-ID: <202211221721.MygdmZXr-lkp@intel.com>
References: <fffb512c532bf1290f0f2b1df6068b2ff6cd14c0.1669072186.git.linux_oss@crudebyte.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="h9dSaSZj0sr/muKD"
Content-Disposition: inline
In-Reply-To: <fffb512c532bf1290f0f2b1df6068b2ff6cd14c0.1669072186.git.linux_oss@crudebyte.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h9dSaSZj0sr/muKD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christian,

I love your patch! Perhaps something to improve:

[auto build test WARNING on v6.1-rc6]
[also build test WARNING on linus/master next-20221122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Schoenebeck/net-9p-fix-response-size-check-in-p9_check_errors/20221122-075849
patch link:    https://lore.kernel.org/r/fffb512c532bf1290f0f2b1df6068b2ff6cd14c0.1669072186.git.linux_oss%40crudebyte.com
patch subject: [PATCH 2/2] net/9p: fix response size check in p9_check_errors()
config: hexagon-randconfig-r041-20221120
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project af8c49dc1ec44339d915d988ffe0f38da68ca0e7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/33e592d4a74029c0a04584fbc23c55a91fd28dcb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christian-Schoenebeck/net-9p-fix-response-size-check-in-p9_check_errors/20221122-075849
        git checkout 33e592d4a74029c0a04584fbc23c55a91fd28dcb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash net/9p/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from net/9p/client.c:29:
   In file included from include/trace/events/9p.h:222:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:21:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from net/9p/client.c:29:
   In file included from include/trace/events/9p.h:222:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:21:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from net/9p/client.c:29:
   In file included from include/trace/events/9p.h:222:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:21:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> net/9p/client.c:520:19: warning: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                            req->rc.size, req->rc.capacity, req->rc.id);
                                          ^~~~~~~~~~~~~~~~
   include/linux/printk.h:500:33: note: expanded from macro 'pr_err'
           printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                  ~~~     ^~~~~~~~~~~
   include/linux/printk.h:457:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:429:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   7 warnings generated.


vim +520 net/9p/client.c

   498	
   499	/**
   500	 * p9_check_errors - check 9p packet for error return and process it
   501	 * @c: current client instance
   502	 * @req: request to parse and check for error conditions
   503	 *
   504	 * returns error code if one is discovered, otherwise returns 0
   505	 *
   506	 * this will have to be more complicated if we have multiple
   507	 * error packet types
   508	 */
   509	
   510	static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
   511	{
   512		s8 type;
   513		int err;
   514		int ecode;
   515	
   516		err = p9_parse_header(&req->rc, NULL, &type, NULL, 0);
   517		if (req->rc.size > req->rc.capacity && !req->rc.zc) {
   518			pr_err(
   519				 "requested packet size too big: %d does not fit %ld (type=%d)\n",
 > 520				 req->rc.size, req->rc.capacity, req->rc.id);
   521			return -EIO;
   522		}
   523		/* dump the response from server
   524		 * This should be after check errors which poplulate pdu_fcall.
   525		 */
   526		trace_9p_protocol_dump(c, &req->rc);
   527		if (err) {
   528			p9_debug(P9_DEBUG_ERROR, "couldn't parse header %d\n", err);
   529			return err;
   530		}
   531		if (type != P9_RERROR && type != P9_RLERROR)
   532			return 0;
   533	
   534		if (!p9_is_proto_dotl(c)) {
   535			char *ename;
   536	
   537			err = p9pdu_readf(&req->rc, c->proto_version, "s?d",
   538					  &ename, &ecode);
   539			if (err)
   540				goto out_err;
   541	
   542			if (p9_is_proto_dotu(c) && ecode < 512)
   543				err = -ecode;
   544	
   545			if (!err) {
   546				err = p9_errstr2errno(ename, strlen(ename));
   547	
   548				p9_debug(P9_DEBUG_9P, "<<< RERROR (%d) %s\n",
   549					 -ecode, ename);
   550			}
   551			kfree(ename);
   552		} else {
   553			err = p9pdu_readf(&req->rc, c->proto_version, "d", &ecode);
   554			if (err)
   555				goto out_err;
   556			err = -ecode;
   557	
   558			p9_debug(P9_DEBUG_9P, "<<< RLERROR (%d)\n", -ecode);
   559		}
   560	
   561		return err;
   562	
   563	out_err:
   564		p9_debug(P9_DEBUG_ERROR, "couldn't parse error%d\n", err);
   565	
   566		return err;
   567	}
   568	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--h9dSaSZj0sr/muKD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/hexagon 6.1.0-rc6 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="clang version 16.0.0 (git://gitmirror/llvm_project af8c49dc1ec44339d915d988ffe0f38da68ca0e7)"
CONFIG_GCC_VERSION=0
CONFIG_CC_IS_CLANG=y
CONFIG_CLANG_VERSION=160000
CONFIG_AS_IS_LLVM=y
CONFIG_AS_VERSION=160000
CONFIG_LD_VERSION=0
CONFIG_LD_IS_LLD=y
CONFIG_LLD_VERSION=160000
CONFIG_RUST_IS_AVAILABLE=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_COMPILE_TEST=y
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_BUILD_SALT=""
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
# CONFIG_TIME_KUNIT_TEST is not set
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

CONFIG_BPF=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# end of BPF subsystem

CONFIG_PREEMPT_NONE_BUILD=y
CONFIG_PREEMPT_NONE=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
# CONFIG_FORCE_TASKS_RCU is not set
# CONFIG_FORCE_TASKS_RUDE_RCU is not set
# CONFIG_FORCE_TASKS_TRACE_RCU is not set
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_NOCB_CPU is not set
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CGROUPS=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
# CONFIG_MEMCG is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_RD_GZIP is not set
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
# CONFIG_RD_ZSTD is not set
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_EMBED is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_EXPERT=y
# CONFIG_MULTIUSER is not set
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_FHANDLE is not set
CONFIG_POSIX_TIMERS=y
# CONFIG_PRINTK is not set
# CONFIG_BUG is not set
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
# CONFIG_FUTEX is not set
CONFIG_EPOLL=y
# CONFIG_SIGNALFD is not set
CONFIG_TIMERFD=y
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
# CONFIG_AIO is not set
# CONFIG_IO_URING is not set
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_KCMP=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

#
# Linux Kernel Configuration for Hexagon
#
CONFIG_HEXAGON=y
CONFIG_HEXAGON_PHYS_OFFSET=y
CONFIG_FRAME_POINTER=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_EARLY_PRINTK=y
CONFIG_MMU=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_STACKTRACE_SUPPORT=y

#
# Machine selection
#
CONFIG_HEXAGON_COMET=y
CONFIG_HEXAGON_ARCH_VERSION=2
CONFIG_CMDLINE=""
CONFIG_SMP=y
CONFIG_NR_CPUS=6
CONFIG_PAGE_SIZE_4KB=y
# CONFIG_PAGE_SIZE_16KB is not set
# CONFIG_PAGE_SIZE_64KB is not set
# CONFIG_PAGE_SIZE_256KB is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
# end of Machine selection

#
# General architecture-dependent options
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_LTO_NONE=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
# CONFIG_COMPAT_32BIT_TIME is not set
CONFIG_ARCH_NO_PREEMPT=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
# end of GCOV-based kernel profiling
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
# CONFIG_BLOCK is not set
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_ELF_KUNIT_TEST is not set
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SLUB_STATS=y
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_FLATMEM=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_BALLOON_COMPACTION is not set
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_CMA is not set
CONFIG_PAGE_IDLE_FLAG=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set
CONFIG_LRU_GEN=y
CONFIG_LRU_GEN_ENABLED=y
CONFIG_LRU_GEN_STATS=y

#
# Data Access Monitoring
#
CONFIG_DAMON=y
# CONFIG_DAMON_KUNIT_TEST is not set
CONFIG_DAMON_VADDR=y
CONFIG_DAMON_PADDR=y
CONFIG_DAMON_VADDR_KUNIT_TEST=y
CONFIG_DAMON_SYSFS=y
# CONFIG_DAMON_DBGFS is not set
CONFIG_DAMON_RECLAIM=y
# CONFIG_DAMON_LRU_SORT is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
CONFIG_XDP_SOCKETS=y
CONFIG_XDP_SOCKETS_DIAG=y
# CONFIG_INET is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_ATM is not set
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_BRIDGE=y
# CONFIG_BRIDGE_VLAN_FILTERING is not set
CONFIG_BRIDGE_MRP=y
CONFIG_BRIDGE_CFM=y
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
# CONFIG_VLAN_8021Q_MVRP is not set
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=y
# CONFIG_IPDDP is not set
CONFIG_X25=y
CONFIG_LAPB=y
CONFIG_PHONET=y
CONFIG_IEEE802154=y
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
# CONFIG_IEEE802154_SOCKET is not set
# CONFIG_MAC802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
# CONFIG_NET_SCH_HTB is not set
CONFIG_NET_SCH_HFSC=y
CONFIG_NET_SCH_PRIO=y
# CONFIG_NET_SCH_MULTIQ is not set
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFB=y
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
# CONFIG_NET_SCH_CBS is not set
CONFIG_NET_SCH_ETF=y
CONFIG_NET_SCH_TAPRIO=y
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_DSMARK=y
# CONFIG_NET_SCH_NETEM is not set
# CONFIG_NET_SCH_DRR is not set
CONFIG_NET_SCH_MQPRIO=y
CONFIG_NET_SCH_SKBPRIO=y
CONFIG_NET_SCH_CHOKE=y
CONFIG_NET_SCH_QFQ=y
CONFIG_NET_SCH_CODEL=y
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=y
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
# CONFIG_NET_SCH_INGRESS is not set
CONFIG_NET_SCH_PLUG=y
CONFIG_NET_SCH_ETS=y
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
# CONFIG_DEFAULT_FQ_CODEL is not set
# CONFIG_DEFAULT_SFQ is not set
CONFIG_DEFAULT_PFIFO_FAST=y
CONFIG_DEFAULT_NET_SCH="pfifo_fast"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=y
# CONFIG_NET_CLS_TCINDEX is not set
CONFIG_NET_CLS_FW=y
# CONFIG_NET_CLS_U32 is not set
CONFIG_NET_CLS_RSVP=y
CONFIG_NET_CLS_RSVP6=y
CONFIG_NET_CLS_FLOW=y
# CONFIG_NET_CLS_CGROUP is not set
# CONFIG_NET_CLS_BPF is not set
CONFIG_NET_CLS_FLOWER=y
CONFIG_NET_CLS_MATCHALL=y
# CONFIG_NET_EMATCH is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=y
CONFIG_NET_ACT_GACT=y
# CONFIG_GACT_PROB is not set
CONFIG_NET_ACT_MIRRED=y
CONFIG_NET_ACT_SAMPLE=y
# CONFIG_NET_ACT_NAT is not set
CONFIG_NET_ACT_PEDIT=y
CONFIG_NET_ACT_SIMP=y
# CONFIG_NET_ACT_SKBEDIT is not set
CONFIG_NET_ACT_MPLS=y
# CONFIG_NET_ACT_VLAN is not set
CONFIG_NET_ACT_BPF=y
# CONFIG_NET_ACT_SKBMOD is not set
CONFIG_NET_ACT_IFE=y
CONFIG_NET_ACT_TUNNEL_KEY=y
# CONFIG_NET_ACT_GATE is not set
CONFIG_NET_IFE_SKBMARK=y
CONFIG_NET_IFE_SKBPRIO=y
CONFIG_NET_IFE_SKBTCINDEX=y
CONFIG_NET_TC_SKB_EXT=y
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
CONFIG_BATMAN_ADV_BATMAN_V=y
CONFIG_BATMAN_ADV_NC=y
# CONFIG_BATMAN_ADV_DEBUG is not set
# CONFIG_BATMAN_ADV_TRACING is not set
CONFIG_VSOCKETS=y
# CONFIG_VSOCKETS_DIAG is not set
CONFIG_VSOCKETS_LOOPBACK=y
CONFIG_VIRTIO_VSOCKETS=y
CONFIG_VIRTIO_VSOCKETS_COMMON=y
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_QRTR is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
# CONFIG_AX25_DAMA_SLAVE is not set
CONFIG_NETROM=y
CONFIG_ROSE=y

#
# AX.25 network device drivers
#
CONFIG_BPQETHER=y
CONFIG_BAYCOM_SER_FDX=y
CONFIG_BAYCOM_SER_HDX=y
CONFIG_BAYCOM_PAR=y
# CONFIG_BAYCOM_EPP is not set
# CONFIG_YAM is not set
# end of AX.25 network device drivers

CONFIG_CAN=y
CONFIG_CAN_RAW=y
CONFIG_CAN_BCM=y
CONFIG_CAN_GW=y
# CONFIG_CAN_J1939 is not set
CONFIG_CAN_ISOTP=y
CONFIG_BT=y
# CONFIG_BT_BREDR is not set
CONFIG_BT_LE=y
CONFIG_BT_LEDS=y
# CONFIG_BT_MSFTEXT is not set
CONFIG_BT_AOSPEXT=y
# CONFIG_BT_DEBUGFS is not set
# CONFIG_BT_SELFTEST is not set
# CONFIG_BT_FEATURE_DEBUG is not set

#
# Bluetooth device drivers
#
CONFIG_BT_HCIVHCI=y
CONFIG_BT_MRVL=y
# CONFIG_BT_MTKUART is not set
# CONFIG_BT_QCOMSMD is not set
# CONFIG_BT_VIRTIO is not set
# end of Bluetooth device drivers

# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
# CONFIG_NET_9P_VIRTIO is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_NFC=y
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=y
# CONFIG_NFC_NCI_SPI is not set
CONFIG_NFC_HCI=y
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_VIRTUAL_NCI=y
# CONFIG_NFC_FDP is not set
CONFIG_NFC_PN544=y
CONFIG_NFC_PN544_I2C=y
CONFIG_NFC_PN533=y
CONFIG_NFC_PN533_I2C=y
CONFIG_NFC_PN532_UART=y
CONFIG_NFC_MICROREAD=y
CONFIG_NFC_MICROREAD_I2C=y
CONFIG_NFC_ST21NFCA=y
CONFIG_NFC_ST21NFCA_I2C=y
CONFIG_NFC_ST_NCI=y
CONFIG_NFC_ST_NCI_I2C=y
CONFIG_NFC_ST_NCI_SPI=y
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
# CONFIG_NFC_S3FWRN82_UART is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
# CONFIG_LWTUNNEL is not set
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
# CONFIG_FAILOVER is not set
CONFIG_ETHTOOL_NETLINK=y
CONFIG_NETDEV_ADDR_LIST_TEST=y

#
# Device Drivers
#
# CONFIG_PCCARD is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
# CONFIG_DEVTMPFS is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_FW_LOADER_COMPRESS=y
# CONFIG_FW_LOADER_COMPRESS_XZ is not set
CONFIG_FW_LOADER_COMPRESS_ZSTD=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
# CONFIG_DRIVER_PE_KUNIT_TEST is not set
CONFIG_GENERIC_CPU_DEVICES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_ARM_INTEGRATOR_LM is not set
# CONFIG_BT1_APB is not set
# CONFIG_BT1_AXI is not set
# CONFIG_INTEL_IXP4XX_EB is not set
# CONFIG_QCOM_EBI2 is not set
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# CONFIG_ARM_SCMI_PROTOCOL is not set
# end of ARM System Control and Management Interface Protocol

# CONFIG_ARM_SCPI_PROTOCOL is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_BCM47XX_NVRAM is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=y
CONFIG_GNSS_MTK_SERIAL=y
# CONFIG_GNSS_SIRF_SERIAL is not set
CONFIG_GNSS_UBX_SERIAL=y
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_PARPORT=y
CONFIG_PARPORT_AX88796=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
CONFIG_AD525X_DPOT_SPI=y
# CONFIG_DUMMY_IRQ is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ATMEL_SSC is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_GEHC_ACHC is not set
# CONFIG_QCOM_COINCELL is not set
# CONFIG_QCOM_FASTRPC is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
# CONFIG_DS1682 is not set
CONFIG_LATTICE_ECP3_CONFIG=y
# CONFIG_SRAM is not set
CONFIG_XILINX_SDFEC=y
CONFIG_C2PORT=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_SPI is not set
CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
CONFIG_ECHO=y
CONFIG_UACCE=y
# CONFIG_PVPANIC is not set
# end of Misc devices

#
# SCSI device support
#
# end of SCSI device support

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# end of IEEE 1394 (FireWire) support

CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_DUMMY=y
CONFIG_EQUALIZER=y
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
CONFIG_MACVLAN=y
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=y
# CONFIG_NETCONSOLE_DYNAMIC is not set
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN_VNET_CROSS_LE=y
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
CONFIG_NLMON=y
CONFIG_ETHERNET=y
# CONFIG_NET_VENDOR_ACTIONS is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_NET_XGENE is not set
# CONFIG_NET_XGENE_V2 is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_NET_VENDOR_ARC is not set
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
# CONFIG_NET_VENDOR_CADENCE is not set
# CONFIG_NET_CALXEDA_XGMAC is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0_PLATFORM is not set
# CONFIG_EP93XX_ETH is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9000 is not set
# CONFIG_DM9051 is not set
CONFIG_DNET=y
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
CONFIG_NET_VENDOR_FARADAY=y
# CONFIG_FTMAC100 is not set
# CONFIG_FTGMAC100 is not set
CONFIG_NET_VENDOR_FREESCALE=y
# CONFIG_FEC is not set
# CONFIG_FSL_FMAN is not set
# CONFIG_FSL_PQ_MDIO is not set
# CONFIG_GIANFAR is not set
# CONFIG_FSL_ENETC_IERB is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_NET_VENDOR_GOOGLE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_NET_VENDOR_INTEL is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_KORINA is not set
# CONFIG_NET_VENDOR_ADI is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_MVNETA is not set
# CONFIG_MVPP2 is not set
# CONFIG_PXA168_ETH is not set
# CONFIG_NET_VENDOR_MEDIATEK is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLXSW_CORE=y
CONFIG_MLXSW_I2C=y
# CONFIG_MLXSW_MINIMAL is not set
CONFIG_MLXFW=y
# CONFIG_MLXBF_GIGE is not set
# CONFIG_NET_VENDOR_MICREL is not set
CONFIG_NET_VENDOR_MICROCHIP=y
CONFIG_ENC28J60=y
CONFIG_ENC28J60_WRITEVERIFY=y
# CONFIG_ENCX24J600 is not set
# CONFIG_NET_VENDOR_MICROSEMI is not set
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_NET_VENDOR_NI is not set
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_AX88796 is not set
# CONFIG_LPC_ENET is not set
CONFIG_ETHOC=y
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_RENESAS is not set
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_SMC91X is not set
# CONFIG_SMC911X is not set
# CONFIG_SMSC911X is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
CONFIG_NET_VENDOR_STMICRO=y
CONFIG_STMMAC_ETH=y
# CONFIG_STMMAC_PLATFORM is not set
CONFIG_NET_VENDOR_SUNPLUS=y
# CONFIG_SP7021_EMAC is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_VERTEXCOM is not set
# CONFIG_NET_VENDOR_VIA is not set
CONFIG_NET_VENDOR_WIZNET=y
CONFIG_WIZNET_W5100=y
CONFIG_WIZNET_W5300=y
# CONFIG_WIZNET_BUS_DIRECT is not set
CONFIG_WIZNET_BUS_INDIRECT=y
# CONFIG_WIZNET_BUS_ANY is not set
CONFIG_NET_VENDOR_XILINX=y
CONFIG_XILINX_EMACLITE=y
CONFIG_XILINX_AXI_EMAC=y
# CONFIG_XILINX_LL_TEMAC is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
CONFIG_LED_TRIGGER_PHY=y
CONFIG_FIXED_PHY=y
CONFIG_SFP=y

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=y
# CONFIG_MESON_GXL_PHY is not set
# CONFIG_ADIN_PHY is not set
CONFIG_ADIN1100_PHY=y
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
CONFIG_BROADCOM_PHY=y
CONFIG_BCM54140_PHY=y
# CONFIG_BCM63XX_PHY is not set
CONFIG_BCM7XXX_PHY=y
CONFIG_BCM84881_PHY=y
# CONFIG_BCM87XX_PHY is not set
CONFIG_BCM_NET_PHYLIB=y
CONFIG_CICADA_PHY=y
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
CONFIG_LXT_PHY=y
CONFIG_INTEL_XWAY_PHY=y
CONFIG_LSI_ET1011C_PHY=y
CONFIG_MARVELL_PHY=y
CONFIG_MARVELL_10G_PHY=y
CONFIG_MARVELL_88X2222_PHY=y
CONFIG_MAXLINEAR_GPHY=y
CONFIG_MEDIATEK_GE_PHY=y
CONFIG_MICREL_PHY=y
# CONFIG_MICROCHIP_PHY is not set
CONFIG_MICROCHIP_T1_PHY=y
# CONFIG_MICROSEMI_PHY is not set
CONFIG_MOTORCOMM_PHY=y
# CONFIG_NATIONAL_PHY is not set
CONFIG_NXP_C45_TJA11XX_PHY=y
CONFIG_QSEMI_PHY=y
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
CONFIG_ROCKCHIP_PHY=y
CONFIG_SMSC_PHY=y
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_DP83869_PHY=y
CONFIG_DP83TD510_PHY=y
CONFIG_VITESSE_PHY=y
CONFIG_XILINX_GMII2RGMII=y
# CONFIG_MICREL_KS8995MA is not set
CONFIG_PSE_CONTROLLER=y
# CONFIG_PSE_REGULATOR is not set
CONFIG_CAN_DEV=y
# CONFIG_CAN_VCAN is not set
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_RX_OFFLOAD=y
# CONFIG_CAN_AT91 is not set
# CONFIG_CAN_FLEXCAN is not set
# CONFIG_CAN_SUN4I is not set
# CONFIG_CAN_XILINXCAN is not set
CONFIG_CAN_C_CAN=y
CONFIG_CAN_C_CAN_PLATFORM=y
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_CTUCANFD is not set
# CONFIG_CAN_CTUCANFD_PLATFORM is not set
# CONFIG_CAN_IFI_CANFD is not set
CONFIG_CAN_M_CAN=y
CONFIG_CAN_M_CAN_PLATFORM=y
CONFIG_CAN_M_CAN_TCAN4X5X=y
# CONFIG_CAN_RCAR is not set
# CONFIG_CAN_RCAR_CANFD is not set
# CONFIG_CAN_SJA1000 is not set
CONFIG_CAN_SOFTING=y

#
# CAN SPI interfaces
#
CONFIG_CAN_HI311X=y
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_SUN4I is not set
# CONFIG_MDIO_XGENE is not set
CONFIG_MDIO_BITBANG=y
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_GPIO=y
CONFIG_MDIO_I2C=y
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_MOXART is not set
# CONFIG_MDIO_OCTEON is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
CONFIG_PCS_XPCS=y
# end of PCS device drivers

# CONFIG_PLIP is not set
CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPP_DEFLATE=y
# CONFIG_PPP_FILTER is not set
# CONFIG_PPP_MPPE is not set
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPPOE=y
CONFIG_SLHC=y

#
# Host-side USB support is needed for USB Network Adapter support
#
# CONFIG_WLAN is not set
CONFIG_WAN=y
CONFIG_HDLC=y
CONFIG_HDLC_RAW=y
CONFIG_HDLC_RAW_ETH=y
# CONFIG_HDLC_CISCO is not set
# CONFIG_HDLC_FR is not set
CONFIG_HDLC_PPP=y
CONFIG_HDLC_X25=y
# CONFIG_SLIC_DS26522 is not set
CONFIG_LAPBETHER=y
CONFIG_IEEE802154_DRIVERS=y

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=y
# CONFIG_KEYBOARD_ADP5520 is not set
CONFIG_KEYBOARD_ADP5588=y
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_CLPS711X is not set
CONFIG_KEYBOARD_DLINK_DIR685=y
CONFIG_KEYBOARD_LKKBD=y
# CONFIG_KEYBOARD_EP93XX is not set
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=y
# CONFIG_KEYBOARD_LM8333 is not set
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_IMX is not set
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
CONFIG_KEYBOARD_PMIC8XXX=y
CONFIG_KEYBOARD_SAMSUNG=y
CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
CONFIG_KEYBOARD_STOWAWAY=y
# CONFIG_KEYBOARD_ST_KEYSCAN is not set
CONFIG_KEYBOARD_SUNKBD=y
# CONFIG_KEYBOARD_SH_KEYSC is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
CONFIG_KEYBOARD_XTKBD=y
# CONFIG_KEYBOARD_MT6779 is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
# CONFIG_MOUSE_PS2_LOGIPS2PP is not set
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
# CONFIG_MOUSE_PS2_CYPRESS is not set
# CONFIG_MOUSE_PS2_TRACKPOINT is not set
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
# CONFIG_MOUSE_PS2_FOCALTECH is not set
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
CONFIG_MOUSE_CYAPA=y
CONFIG_MOUSE_ELAN_I2C=y
# CONFIG_MOUSE_ELAN_I2C_I2C is not set
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=y
CONFIG_MOUSE_GPIO=y
CONFIG_MOUSE_SYNAPTICS_I2C=y
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
CONFIG_JOYSTICK_A3D=y
# CONFIG_JOYSTICK_ADC is not set
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
CONFIG_JOYSTICK_INTERACT=y
# CONFIG_JOYSTICK_SIDEWINDER is not set
CONFIG_JOYSTICK_TMDC=y
CONFIG_JOYSTICK_IFORCE=y
# CONFIG_JOYSTICK_IFORCE_232 is not set
# CONFIG_JOYSTICK_WARRIOR is not set
CONFIG_JOYSTICK_MAGELLAN=y
CONFIG_JOYSTICK_SPACEORB=y
# CONFIG_JOYSTICK_SPACEBALL is not set
CONFIG_JOYSTICK_STINGER=y
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_DB9=y
CONFIG_JOYSTICK_GAMECON=y
CONFIG_JOYSTICK_TURBOGRAFX=y
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
CONFIG_JOYSTICK_PSXPAD_SPI=y
# CONFIG_JOYSTICK_PSXPAD_SPI_FF is not set
CONFIG_JOYSTICK_QWIIC=y
CONFIG_JOYSTICK_FSIA6B=y
CONFIG_JOYSTICK_SENSEHAT=y
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_SERIAL_WACOM4=y
CONFIG_INPUT_TOUCHSCREEN=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
CONFIG_TOUCHSCREEN_AD7879=y
# CONFIG_TOUCHSCREEN_AD7879_I2C is not set
CONFIG_TOUCHSCREEN_AD7879_SPI=y
# CONFIG_TOUCHSCREEN_ADC is not set
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
CONFIG_TOUCHSCREEN_CY8CTMA140=y
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP_I2C=y
# CONFIG_TOUCHSCREEN_CYTTSP_SPI is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=y
CONFIG_TOUCHSCREEN_CYTTSP4_SPI=y
CONFIG_TOUCHSCREEN_DA9034=y
CONFIG_TOUCHSCREEN_DA9052=y
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
CONFIG_TOUCHSCREEN_EXC3000=y
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=y
CONFIG_TOUCHSCREEN_HIDEEP=y
CONFIG_TOUCHSCREEN_HYCON_HY46XX=y
CONFIG_TOUCHSCREEN_ILI210X=y
CONFIG_TOUCHSCREEN_ILITEK=y
# CONFIG_TOUCHSCREEN_IPROC is not set
CONFIG_TOUCHSCREEN_S6SY761=y
# CONFIG_TOUCHSCREEN_GUNZE is not set
CONFIG_TOUCHSCREEN_EKTF2127=y
CONFIG_TOUCHSCREEN_ELAN=y
CONFIG_TOUCHSCREEN_ELO=y
CONFIG_TOUCHSCREEN_WACOM_W8001=y
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
CONFIG_TOUCHSCREEN_MAX11801=y
CONFIG_TOUCHSCREEN_MCS5000=y
CONFIG_TOUCHSCREEN_MMS114=y
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MSG2638 is not set
CONFIG_TOUCHSCREEN_MTOUCH=y
# CONFIG_TOUCHSCREEN_IMAGIS is not set
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
CONFIG_TOUCHSCREEN_INEXIO=y
# CONFIG_TOUCHSCREEN_MK712 is not set
CONFIG_TOUCHSCREEN_PENMOUNT=y
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
# CONFIG_TOUCHSCREEN_RASPBERRYPI_FW is not set
# CONFIG_TOUCHSCREEN_MIGOR is not set
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
CONFIG_TOUCHSCREEN_TOUCHWIN=y
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=y
CONFIG_TOUCHSCREEN_PIXCIR=y
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
CONFIG_TOUCHSCREEN_WM831X=y
# CONFIG_TOUCHSCREEN_MC13783 is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=y
CONFIG_TOUCHSCREEN_TSC_SERIO=y
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
# CONFIG_TOUCHSCREEN_TSC2005 is not set
CONFIG_TOUCHSCREEN_TSC2007=y
CONFIG_TOUCHSCREEN_TSC2007_IIO=y
CONFIG_TOUCHSCREEN_RM_TS=y
# CONFIG_TOUCHSCREEN_SILEAD is not set
CONFIG_TOUCHSCREEN_SIS_I2C=y
CONFIG_TOUCHSCREEN_ST1232=y
# CONFIG_TOUCHSCREEN_STMFTS is not set
CONFIG_TOUCHSCREEN_SURFACE3_SPI=y
# CONFIG_TOUCHSCREEN_SX8654 is not set
CONFIG_TOUCHSCREEN_TPS6507X=y
CONFIG_TOUCHSCREEN_ZET6223=y
CONFIG_TOUCHSCREEN_ZFORCE=y
# CONFIG_TOUCHSCREEN_COLIBRI_VF50 is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
CONFIG_TOUCHSCREEN_ZINITIX=y
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SPI=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
CONFIG_RMI4_F3A=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_PARKBD=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
# CONFIG_SERIO_OLPC_APSP is not set
# CONFIG_SERIO_SUN4I_PS2 is not set
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=y
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
# CONFIG_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
CONFIG_IPMI_HANDLER=y
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_SI is not set
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_IPMB=y
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=y
# CONFIG_ASPEED_KCS_IPMI_BMC is not set
# CONFIG_NPCM7XX_KCS_IPMI_BMC is not set
# CONFIG_ASPEED_BT_IPMI_BMC is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_BA431=y
CONFIG_HW_RANDOM_BCM2835=y
CONFIG_HW_RANDOM_IPROC_RNG200=y
CONFIG_HW_RANDOM_IXP4XX=y
CONFIG_HW_RANDOM_OMAP=y
CONFIG_HW_RANDOM_OMAP3_ROM=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_IMX_RNGC=y
CONFIG_HW_RANDOM_NOMADIK=y
CONFIG_HW_RANDOM_STM32=y
CONFIG_HW_RANDOM_MESON=y
CONFIG_HW_RANDOM_MTK=y
CONFIG_HW_RANDOM_EXYNOS=y
CONFIG_HW_RANDOM_NPCM=y
CONFIG_HW_RANDOM_XIPHERA=y
CONFIG_DEVMEM=y
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS_SPI=y
# CONFIG_TCG_TIS_SPI_CR50 is not set
CONFIG_TCG_TIS_I2C=y
# CONFIG_TCG_TIS_SYNQUACER is not set
CONFIG_TCG_TIS_I2C_CR50=y
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
# CONFIG_TCG_ATMEL is not set
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#
# CONFIG_I2C_HIX5HD2 is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_ASPEED is not set
# CONFIG_I2C_AT91 is not set
# CONFIG_I2C_AXXIA is not set
# CONFIG_I2C_BCM2835 is not set
# CONFIG_I2C_BCM_IPROC is not set
# CONFIG_I2C_BCM_KONA is not set
CONFIG_I2C_BRCMSTB=y
# CONFIG_I2C_CADENCE is not set
CONFIG_I2C_CBUS_GPIO=y
# CONFIG_I2C_DAVINCI is not set
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DIGICOLOR is not set
CONFIG_I2C_EMEV2=y
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_HIGHLANDER is not set
# CONFIG_I2C_HISI is not set
# CONFIG_I2C_IMG is not set
# CONFIG_I2C_IMX is not set
# CONFIG_I2C_IMX_LPI2C is not set
# CONFIG_I2C_IOP3XX is not set
# CONFIG_I2C_JZ4780 is not set
# CONFIG_I2C_MESON is not set
# CONFIG_I2C_MT65XX is not set
# CONFIG_I2C_MT7621 is not set
# CONFIG_I2C_MV64XXX is not set
# CONFIG_I2C_MXS is not set
# CONFIG_I2C_NPCM is not set
CONFIG_I2C_OCORES=y
# CONFIG_I2C_OMAP is not set
# CONFIG_I2C_OWL is not set
# CONFIG_I2C_APPLE is not set
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PNX is not set
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_QCOM_CCI is not set
# CONFIG_I2C_QUP is not set
# CONFIG_I2C_RIIC is not set
# CONFIG_I2C_RZV2M is not set
# CONFIG_I2C_S3C2410 is not set
# CONFIG_I2C_SH_MOBILE is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_SPRD is not set
# CONFIG_I2C_ST is not set
# CONFIG_I2C_STM32F4 is not set
# CONFIG_I2C_STM32F7 is not set
# CONFIG_I2C_SUN6I_P2WI is not set
# CONFIG_I2C_SYNQUACER is not set
# CONFIG_I2C_TEGRA_BPMP is not set
# CONFIG_I2C_UNIPHIER is not set
# CONFIG_I2C_UNIPHIER_F is not set
# CONFIG_I2C_VERSATILE is not set
# CONFIG_I2C_WMT is not set
CONFIG_I2C_XILINX=y
# CONFIG_I2C_XLP9XX is not set
# CONFIG_I2C_RCAR is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_VIRTIO=y
# end of I2C Hardware Bus support

CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
CONFIG_I2C_SLAVE_TESTUNIT=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
CONFIG_I2C_DEBUG_BUS=y
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_ALTERA_CORE is not set
# CONFIG_SPI_AR934X is not set
# CONFIG_SPI_ATH79 is not set
# CONFIG_SPI_ARMADA_3700 is not set
CONFIG_SPI_AXI_SPI_ENGINE=y
# CONFIG_SPI_BCM2835 is not set
# CONFIG_SPI_BCM2835AUX is not set
# CONFIG_SPI_BCM63XX is not set
# CONFIG_SPI_BCM63XX_HSSPI is not set
# CONFIG_SPI_BCM_QSPI is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=y
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_CLPS711X is not set
CONFIG_SPI_DESIGNWARE=y
CONFIG_SPI_DW_DMA=y
# CONFIG_SPI_DW_MMIO is not set
# CONFIG_SPI_DW_BT1 is not set
# CONFIG_SPI_EP93XX is not set
# CONFIG_SPI_FSL_LPSPI is not set
# CONFIG_SPI_FSL_QUADSPI is not set
# CONFIG_SPI_GXP is not set
# CONFIG_SPI_HISI_KUNPENG is not set
# CONFIG_SPI_HISI_SFC_V3XX is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
CONFIG_SPI_GPIO=y
# CONFIG_SPI_IMG_SPFI is not set
# CONFIG_SPI_IMX is not set
# CONFIG_SPI_INGENIC is not set
CONFIG_SPI_LM70_LLP=y
# CONFIG_SPI_LP8841_RTC is not set
# CONFIG_SPI_FSL_DSPI is not set
# CONFIG_SPI_MESON_SPICC is not set
# CONFIG_SPI_MESON_SPIFC is not set
CONFIG_SPI_MICROCHIP_CORE=y
CONFIG_SPI_MICROCHIP_CORE_QSPI=y
# CONFIG_SPI_MT65XX is not set
# CONFIG_SPI_MT7621 is not set
# CONFIG_SPI_MTK_NOR is not set
# CONFIG_SPI_NPCM_PSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_OMAP24XX is not set
# CONFIG_SPI_TI_QSPI is not set
# CONFIG_SPI_OMAP_100K is not set
# CONFIG_SPI_ORION is not set
# CONFIG_SPI_PIC32 is not set
# CONFIG_SPI_PIC32_SQI is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_ROCKCHIP_SFC is not set
# CONFIG_SPI_RSPI is not set
# CONFIG_SPI_QUP is not set
# CONFIG_SPI_S3C64XX is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SH_MSIOF is not set
# CONFIG_SPI_SH is not set
# CONFIG_SPI_SH_HSPI is not set
CONFIG_SPI_SIFIVE=y
# CONFIG_SPI_SLAVE_MT27XX is not set
# CONFIG_SPI_SPRD is not set
# CONFIG_SPI_SPRD_ADI is not set
# CONFIG_SPI_STM32 is not set
# CONFIG_SPI_ST_SSC4 is not set
# CONFIG_SPI_SUN4I is not set
# CONFIG_SPI_SUN6I is not set
# CONFIG_SPI_SUNPLUS_SP7021 is not set
# CONFIG_SPI_SYNQUACER is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_TEGRA210_QUAD is not set
# CONFIG_SPI_TEGRA114 is not set
# CONFIG_SPI_TEGRA20_SFLASH is not set
# CONFIG_SPI_TEGRA20_SLINK is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_XLP is not set
# CONFIG_SPI_XTENSA_XTFPGA is not set
# CONFIG_SPI_ZYNQ_QSPI is not set
CONFIG_SPI_ZYNQMP_GQSPI=y
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_TLE62X0 is not set
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=y
# CONFIG_SPI_SLAVE_SYSTEM_CONTROL is not set
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=y
# CONFIG_SPMI_HISI3670 is not set
# CONFIG_SPMI_MSM_PMIC_ARB is not set
# CONFIG_SPMI_MTK_PMIF is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_PARPORT=y
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
CONFIG_PTP_1588_CLOCK_DTE=y
CONFIG_PTP_1588_CLOCK_QORIQ=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_IDT82P33=y
CONFIG_PTP_1588_CLOCK_IDTCM=y
# end of PTP clock support

# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
# CONFIG_GPIO_SYSFS is not set
# CONFIG_GPIO_CDEV is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_ATH79 is not set
# CONFIG_GPIO_CLPS711X is not set
# CONFIG_GPIO_DWAPB is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_HISI is not set
# CONFIG_GPIO_IOP is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MPC8XXX is not set
# CONFIG_GPIO_MXC is not set
# CONFIG_GPIO_MXS is not set
# CONFIG_GPIO_PXA is not set
# CONFIG_GPIO_RCAR is not set
# CONFIG_GPIO_ROCKCHIP is not set
# CONFIG_GPIO_SIOX is not set
# CONFIG_GPIO_XGENE_SB is not set
# CONFIG_GPIO_XLP is not set
CONFIG_GPIO_AMD_FCH=y
# CONFIG_GPIO_IDT3243X is not set
# end of Memory mapped GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y
# CONFIG_GPIO_TS4900 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=y
# CONFIG_GPIO_PALMAS is not set
# CONFIG_GPIO_RC5T583 is not set
# CONFIG_GPIO_SL28CPLD is not set
# CONFIG_GPIO_TPS6586X is not set
CONFIG_GPIO_TPS65910=y
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TQMX86=y
# CONFIG_GPIO_TWL6040 is not set
CONFIG_GPIO_WM831X=y
# end of MFD GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
CONFIG_GPIO_MC33880=y
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VIRTIO=y
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

CONFIG_W1=y
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_MXC is not set
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2430=y
# CONFIG_W1_SLAVE_DS2431 is not set
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_ATC260X=y
# CONFIG_POWER_RESET_BRCMKONA is not set
# CONFIG_POWER_RESET_BRCMSTB is not set
# CONFIG_POWER_RESET_OCELOT_RESET is not set
CONFIG_POWER_RESET_RESTART=y
# CONFIG_POWER_RESET_KEYSTONE is not set
# CONFIG_POWER_RESET_RMOBILE is not set
# CONFIG_POWER_RESET_SC27XX is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_IP5XXX_POWER=y
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=y
CONFIG_TEST_POWER=y
CONFIG_CHARGER_ADP5061=y
# CONFIG_BATTERY_ACT8945A is not set
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SAMSUNG_SDI=y
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9030=y
CONFIG_BATTERY_DA9052=y
CONFIG_CHARGER_DA9150=y
CONFIG_BATTERY_DA9150=y
# CONFIG_CHARGER_AXP20X is not set
CONFIG_BATTERY_AXP20X=y
CONFIG_AXP20X_POWER=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_PCF50633=y
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_LTC4162L=y
CONFIG_CHARGER_MAX77976=y
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ2515X=y
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
# CONFIG_CHARGER_SC2731 is not set
# CONFIG_FUEL_GAUGE_SC27XX is not set
CONFIG_CHARGER_BD99954=y
# CONFIG_BATTERY_UG3105 is not set
# CONFIG_HWMON is not set
# CONFIG_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set
CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT=y

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
CONFIG_DA9052_WATCHDOG=y
# CONFIG_DA9055_WATCHDOG is not set
# CONFIG_DA9063_WATCHDOG is not set
# CONFIG_DA9062_WATCHDOG is not set
# CONFIG_MENF21BMC_WATCHDOG is not set
CONFIG_WM831X_WATCHDOG=y
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
# CONFIG_RAVE_SP_WATCHDOG is not set
# CONFIG_SL28CPLD_WATCHDOG is not set
# CONFIG_ARMADA_37XX_WATCHDOG is not set
# CONFIG_AT91RM9200_WATCHDOG is not set
# CONFIG_AT91SAM9X_WATCHDOG is not set
# CONFIG_SAMA5D4_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_FTWDT010_WATCHDOG is not set
# CONFIG_S3C2410_WATCHDOG is not set
CONFIG_DW_WATCHDOG=y
# CONFIG_EP93XX_WATCHDOG is not set
# CONFIG_OMAP_WATCHDOG is not set
# CONFIG_PNX4008_WATCHDOG is not set
# CONFIG_DAVINCI_WATCHDOG is not set
# CONFIG_K3_RTI_WATCHDOG is not set
# CONFIG_RN5T618_WATCHDOG is not set
# CONFIG_SUNXI_WATCHDOG is not set
# CONFIG_NPCM7XX_WATCHDOG is not set
# CONFIG_STMP3XXX_RTC_WATCHDOG is not set
# CONFIG_TS72XX_WATCHDOG is not set
CONFIG_MAX63XX_WATCHDOG=y
# CONFIG_MAX77620_WATCHDOG is not set
# CONFIG_IMX2_WDT is not set
# CONFIG_IMX7ULP_WDT is not set
# CONFIG_RETU_WATCHDOG is not set
# CONFIG_MOXART_WDT is not set
# CONFIG_TEGRA_WATCHDOG is not set
# CONFIG_QCOM_WDT is not set
# CONFIG_MESON_GXBB_WATCHDOG is not set
# CONFIG_MESON_WATCHDOG is not set
# CONFIG_MEDIATEK_WATCHDOG is not set
# CONFIG_DIGICOLOR_WATCHDOG is not set
# CONFIG_LPC18XX_WATCHDOG is not set
# CONFIG_RENESAS_WDT is not set
# CONFIG_RENESAS_RZAWDT is not set
# CONFIG_RENESAS_RZN1WDT is not set
# CONFIG_RENESAS_RZG2LWDT is not set
# CONFIG_ASPEED_WATCHDOG is not set
# CONFIG_REALTEK_OTTO_WDT is not set
# CONFIG_SPRD_WATCHDOG is not set
# CONFIG_VISCONTI_WATCHDOG is not set
# CONFIG_MSC313E_WATCHDOG is not set
# CONFIG_APPLE_WATCHDOG is not set
# CONFIG_SUNPLUS_WATCHDOG is not set
# CONFIG_SC520_WDT is not set
# CONFIG_BCM47XX_WDT is not set
# CONFIG_BCM_KONA_WDT is not set
# CONFIG_BCM7038_WDT is not set
# CONFIG_IMGPDC_WDT is not set
# CONFIG_MPC5200_WDT is not set
CONFIG_MEN_A21_WDT=y
# CONFIG_UML_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_SOC=y
# CONFIG_BCMA_DRIVER_MIPS is not set
CONFIG_BCMA_SFLASH=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_SUN4I_GPADC is not set
# CONFIG_MFD_AS3711 is not set
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_AT91_USART is not set
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
# CONFIG_MFD_MADERA is not set
# CONFIG_MFD_ASIC3 is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=y
# CONFIG_MFD_ENE_KB3930 is not set
# CONFIG_MFD_EXYNOS_LPASS is not set
CONFIG_MFD_MC13XXX=y
# CONFIG_MFD_MC13XXX_SPI is not set
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_MXS_LRADC is not set
# CONFIG_MFD_MX25_TSADC is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
# CONFIG_MFD_MAX77650 is not set
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77714 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6360=y
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_CPCAP is not set
# CONFIG_MFD_NTXEC is not set
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
CONFIG_MFD_PM8XXX=y
# CONFIG_MFD_SY7636A is not set
CONFIG_MFD_RT4831=y
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SIMPLE_MFD_I2C=y
# CONFIG_MFD_SL28CPLD is not set
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SC27XX_PMIC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SUN6I_PRCM is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
# CONFIG_TPS6105X is not set
CONFIG_TPS65010=y
CONFIG_TPS6507X=y
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_TPS65912_SPI=y
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_TQMX86=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_ARIZONA_SPI=y
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM831X_SPI=y
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_STW481X is not set
# CONFIG_MFD_STM32_LPTIMER is not set
# CONFIG_MFD_STM32_TIMERS is not set
# CONFIG_MFD_STMFX is not set
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
# CONFIG_MFD_KHADAS_MCU is not set
# CONFIG_MFD_ACER_A500_EC is not set
CONFIG_RAVE_SP_CORE=y
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
# CONFIG_RC_CORE is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
# CONFIG_IMX_IPUV3_CORE is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=y
# CONFIG_DRM_DEBUG_MM is not set
# CONFIG_DRM_KUNIT_TEST is not set
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_GEM_DMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=y
CONFIG_DRM_I2C_NXP_TDA998X=y
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_KMB_DISPLAY is not set
CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_SUN4I is not set
# CONFIG_DRM_VIRTIO_GPU is not set
# CONFIG_DRM_MSM is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_ANALOGIX_DP=y
# end of Display Interface Bridges

# CONFIG_DRM_V3D is not set
CONFIG_DRM_ETNAVIV=y
# CONFIG_DRM_ETNAVIV_THERMAL is not set
# CONFIG_DRM_LOGICVC is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
CONFIG_DRM_SIMPLEDRM=y
CONFIG_TINYDRM_HX8357D=y
CONFIG_TINYDRM_ILI9163=y
CONFIG_TINYDRM_ILI9225=y
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
CONFIG_TINYDRM_REPAPER=y
CONFIG_TINYDRM_ST7586=y
CONFIG_TINYDRM_ST7735R=y
# CONFIG_DRM_PL111 is not set
CONFIG_DRM_SSD130X=y
CONFIG_DRM_SSD130X_I2C=y
# CONFIG_DRM_SSD130X_SPI is not set
CONFIG_DRM_LEGACY=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
# CONFIG_FB_BIG_ENDIAN is not set
CONFIG_FB_LITTLE_ENDIAN=y
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CLPS711X is not set
# CONFIG_FB_IMX is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_CONTROL is not set
CONFIG_FB_UVESA=y
# CONFIG_FB_GBE is not set
# CONFIG_FB_PVR2 is not set
CONFIG_FB_OPENCORES=y
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_WM8505 is not set
# CONFIG_FB_PXA168 is not set
# CONFIG_FB_W100 is not set
# CONFIG_FB_SH_MOBILE_LCDC is not set
# CONFIG_FB_TMIO is not set
# CONFIG_FB_S3C is not set
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_GOLDFISH=y
# CONFIG_FB_DA8XX is not set
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=y
# CONFIG_FB_BROADSHEET is not set
CONFIG_FB_SSD1307=y
CONFIG_FB_OMAP_LCD_H3=y
# CONFIG_MMP_DISP is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
CONFIG_LCD_LMS283GF05=y
CONFIG_LCD_LTV350QV=y
# CONFIG_LCD_ILI922X is not set
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=y
# CONFIG_LCD_AMS369FG06 is not set
CONFIG_LCD_LMS501KF03=y
CONFIG_LCD_HX8357=y
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_OMAP1 is not set
CONFIG_BACKLIGHT_PWM=y
# CONFIG_BACKLIGHT_DA903X is not set
CONFIG_BACKLIGHT_DA9052=y
CONFIG_BACKLIGHT_QCOM_WLED=y
CONFIG_BACKLIGHT_RT4831=y
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP5520=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_AAT2870=y
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=y
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_BACKLIGHT_RAVE_SP=y
# end of Backlight & LCD device support

CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACRUX=y
# CONFIG_HID_ACRUX_FF is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
# CONFIG_HID_CHERRY is not set
CONFIG_HID_COUGAR=y
CONFIG_HID_MACALLY=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=y
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
CONFIG_HID_GLORIOUS=y
CONFIG_HID_VIVALDI_COMMON=y
CONFIG_HID_VIVALDI=y
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=y
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_VRC2=y
CONFIG_HID_XIAOMI=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
# CONFIG_HID_LED is not set
CONFIG_HID_LENOVO=y
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
# CONFIG_HID_MICROSOFT is not set
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NINTENDO=y
CONFIG_NINTENDO_FF=y
CONFIG_HID_NTI=y
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
# CONFIG_HID_PICOLCD_LCD is not set
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=y
# CONFIG_HID_PLAYSTATION is not set
CONFIG_HID_PXRC=y
CONFIG_HID_RAZER=y
CONFIG_HID_PRIMAX=y
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEAM=y
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
CONFIG_GREENASIA_FF=y
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
# CONFIG_HID_TOPRE is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WIIMOTE=y
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=y
# CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
CONFIG_HID_ALPS=y
# end of Special HID drivers

#
# I2C HID support
#
# end of I2C HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
# CONFIG_USB_SUPPORT is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_ARIEL is not set
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_S3C24XX is not set
# CONFIG_LEDS_COBALT_QUBE is not set
# CONFIG_LEDS_COBALT_RAQ is not set
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP50XX=y
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_DA903X=y
# CONFIG_LEDS_DA9052 is not set
# CONFIG_LEDS_DAC124S085 is not set
CONFIG_LEDS_PWM=y
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_ADP5520 is not set
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_NS2=y
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_OT200 is not set
CONFIG_LEDS_IS31FL319X=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_PM8058=y
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM36274=y
# CONFIG_LEDS_IP30 is not set

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AS3645A=y
# CONFIG_LEDS_LM3601X is not set
# CONFIG_LEDS_RT8515 is not set
# CONFIG_LEDS_SGM3140 is not set

#
# RGB LED drivers
#
CONFIG_LEDS_PWM_MULTICOLOR=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_NETDEV=y
CONFIG_LEDS_TRIGGER_PATTERN=y
# CONFIG_LEDS_TRIGGER_AUDIO is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_LIB_KUNIT_TEST=y
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
# CONFIG_RTC_INTF_PROC is not set
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM80X=y
CONFIG_RTC_DRV_ABB5ZES3=y
CONFIG_RTC_DRV_ABEOZ9=y
CONFIG_RTC_DRV_ABX80X=y
# CONFIG_RTC_DRV_BRCMSTB is not set
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=y
# CONFIG_RTC_DRV_DS1374_WDT is not set
# CONFIG_RTC_DRV_DS1672 is not set
CONFIG_RTC_DRV_MAX6900=y
# CONFIG_RTC_DRV_MAX8907 is not set
# CONFIG_RTC_DRV_MAX8998 is not set
# CONFIG_RTC_DRV_MAX77686 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
# CONFIG_RTC_DRV_ISL12026 is not set
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=y
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=y
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BQ32K=y
CONFIG_RTC_DRV_PALMAS=y
CONFIG_RTC_DRV_TPS6586X=y
CONFIG_RTC_DRV_TPS65910=y
CONFIG_RTC_DRV_RC5T583=y
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=y
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
CONFIG_RTC_DRV_RX8025=y
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV3028=y
CONFIG_RTC_DRV_RV3032=y
CONFIG_RTC_DRV_RV8803=y
# CONFIG_RTC_DRV_S5M is not set
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=y
CONFIG_RTC_DRV_M41T94=y
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
CONFIG_RTC_DRV_DS1347=y
# CONFIG_RTC_DRV_DS1390 is not set
CONFIG_RTC_DRV_MAX6916=y
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=y
CONFIG_RTC_DRV_RS5C348=y
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
CONFIG_RTC_DRV_PCF2127=y
# CONFIG_RTC_DRV_RV3029C2 is not set
CONFIG_RTC_DRV_RX6110=y

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_DS1286 is not set
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=y
CONFIG_RTC_DRV_DS1685_FAMILY=y
# CONFIG_RTC_DRV_DS1685 is not set
CONFIG_RTC_DRV_DS1689=y
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DRV_DS1742 is not set
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_DA9052=y
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_STK17TA8=y
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
CONFIG_RTC_DRV_BQ4802=y
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=y
# CONFIG_RTC_DRV_GAMECUBE is not set
# CONFIG_RTC_DRV_WM831X is not set
# CONFIG_RTC_DRV_SC27XX is not set
CONFIG_RTC_DRV_SPEAR=y
# CONFIG_RTC_DRV_PCF50633 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_ASM9260 is not set
# CONFIG_RTC_DRV_DAVINCI is not set
# CONFIG_RTC_DRV_DIGICOLOR is not set
# CONFIG_RTC_DRV_FSL_FTM_ALARM is not set
# CONFIG_RTC_DRV_MESON is not set
# CONFIG_RTC_DRV_MESON_VRTC is not set
# CONFIG_RTC_DRV_S3C is not set
# CONFIG_RTC_DRV_EP93XX is not set
# CONFIG_RTC_DRV_GENERIC is not set
# CONFIG_RTC_DRV_VT8500 is not set
# CONFIG_RTC_DRV_SUN6I is not set
# CONFIG_RTC_DRV_SUNXI is not set
# CONFIG_RTC_DRV_MV is not set
CONFIG_RTC_DRV_FTRTC010=y
# CONFIG_RTC_DRV_STMP is not set
CONFIG_RTC_DRV_MC13XXX=y
# CONFIG_RTC_DRV_LPC32XX is not set
CONFIG_RTC_DRV_PM8XXX=y
# CONFIG_RTC_DRV_TEGRA is not set
# CONFIG_RTC_DRV_MOXART is not set
# CONFIG_RTC_DRV_MT2712 is not set
# CONFIG_RTC_DRV_MT6397 is not set
# CONFIG_RTC_DRV_MT7622 is not set
# CONFIG_RTC_DRV_XGENE is not set
# CONFIG_RTC_DRV_STM32 is not set
# CONFIG_RTC_DRV_RTD119X is not set
# CONFIG_RTC_DRV_TI_K3 is not set

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_GOLDFISH=y
# CONFIG_RTC_DRV_MSC313 is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
CONFIG_DMABUF_DEBUG=y
CONFIG_DMABUF_SELFTESTS=y
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
CONFIG_IMG_ASCII_LCD=y
CONFIG_HT16K33=y
CONFIG_LCD2S=y
CONFIG_PARPORT_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
CONFIG_PANEL=y
# CONFIG_UIO is not set
CONFIG_VFIO=y
CONFIG_VFIO_NOIOMMU=y
# CONFIG_VFIO_PLATFORM is not set
# CONFIG_VFIO_MDEV is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_VDPA=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
CONFIG_VDPA=y
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
CONFIG_COMEDI_ISA_DRIVERS=y
# CONFIG_COMEDI_PCL711 is not set
CONFIG_COMEDI_PCL724=y
CONFIG_COMEDI_PCL726=y
# CONFIG_COMEDI_PCL730 is not set
CONFIG_COMEDI_PCL812=y
CONFIG_COMEDI_PCL816=y
CONFIG_COMEDI_PCL818=y
CONFIG_COMEDI_PCM3724=y
CONFIG_COMEDI_AMPLC_DIO200_ISA=y
# CONFIG_COMEDI_AMPLC_PC236_ISA is not set
CONFIG_COMEDI_AMPLC_PC263_ISA=y
CONFIG_COMEDI_RTI800=y
CONFIG_COMEDI_RTI802=y
CONFIG_COMEDI_DAC02=y
# CONFIG_COMEDI_DAS16M1 is not set
# CONFIG_COMEDI_DAS08_ISA is not set
CONFIG_COMEDI_DAS16=y
# CONFIG_COMEDI_DAS800 is not set
CONFIG_COMEDI_DAS1800=y
# CONFIG_COMEDI_DAS6402 is not set
CONFIG_COMEDI_DT2801=y
# CONFIG_COMEDI_DT2811 is not set
# CONFIG_COMEDI_DT2814 is not set
CONFIG_COMEDI_DT2815=y
CONFIG_COMEDI_DT2817=y
# CONFIG_COMEDI_DT282X is not set
CONFIG_COMEDI_DMM32AT=y
CONFIG_COMEDI_FL512=y
CONFIG_COMEDI_AIO_AIO12_8=y
CONFIG_COMEDI_AIO_IIRO_16=y
# CONFIG_COMEDI_II_PCI20KC is not set
# CONFIG_COMEDI_C6XDIGIO is not set
CONFIG_COMEDI_MPC624=y
CONFIG_COMEDI_ADQ12B=y
# CONFIG_COMEDI_NI_AT_A2150 is not set
CONFIG_COMEDI_NI_AT_AO=y
# CONFIG_COMEDI_NI_ATMIO is not set
# CONFIG_COMEDI_NI_ATMIO16D is not set
CONFIG_COMEDI_NI_LABPC_ISA=y
# CONFIG_COMEDI_PCMAD is not set
# CONFIG_COMEDI_PCMDA12 is not set
CONFIG_COMEDI_PCMMIO=y
# CONFIG_COMEDI_PCMUIO is not set
CONFIG_COMEDI_MULTIQ3=y
CONFIG_COMEDI_S526=y
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
# CONFIG_COMEDI_KCOMEDILIB is not set
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_ROUTING=y
CONFIG_COMEDI_TESTS=y
CONFIG_COMEDI_TESTS_EXAMPLE=y
CONFIG_COMEDI_TESTS_NI_ROUTES=y
# CONFIG_STAGING is not set
CONFIG_GOLDFISH=y
CONFIG_GOLDFISH_PIPE=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
# CONFIG_OLPC_XO175 is not set
CONFIG_SURFACE_PLATFORMS=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y

#
# Clock driver for ARM Reference designs
#
# CONFIG_CLK_ICST is not set
# CONFIG_CLK_SP810 is not set
# end of Clock driver for ARM Reference designs

# CONFIG_CLK_HSDK is not set
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_APPLE_NCO is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
CONFIG_COMMON_CLK_MAX9485=y
# CONFIG_COMMON_CLK_HI655X is not set
# CONFIG_COMMON_CLK_SCMI is not set
# CONFIG_COMMON_CLK_SCPI is not set
CONFIG_COMMON_CLK_SI5341=y
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI544=y
# CONFIG_COMMON_CLK_BM1880 is not set
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_TPS68470 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_FSL_FLEXSPI is not set
# CONFIG_COMMON_CLK_FSL_SAI is not set
# CONFIG_COMMON_CLK_GEMINI is not set
# CONFIG_COMMON_CLK_ASPEED is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_CLK_TWL6040 is not set
# CONFIG_CLK_LS1028A_PLLDIG is not set
# CONFIG_COMMON_CLK_XGENE is not set
CONFIG_COMMON_CLK_PALMAS=y
CONFIG_COMMON_CLK_PWM=y
# CONFIG_COMMON_CLK_OXNAS is not set
# CONFIG_COMMON_CLK_MMP2_AUDIO is not set
# CONFIG_CLK_ACTIONS is not set
# CONFIG_CLK_BAIKAL_T1 is not set
# CONFIG_CLK_BCM2711_DVP is not set
# CONFIG_CLK_BCM2835 is not set
# CONFIG_CLK_BCM_63XX is not set
# CONFIG_CLK_BCM_63XX_GATE is not set
# CONFIG_CLK_BCM_KONA is not set
# CONFIG_CLK_BCM_CYGNUS is not set
# CONFIG_CLK_BCM_HR2 is not set
# CONFIG_CLK_BCM_NSP is not set
# CONFIG_CLK_BCM_NS2 is not set
# CONFIG_CLK_BCM_SR is not set
# CONFIG_CLK_RASPBERRYPI is not set
# CONFIG_COMMON_CLK_HI3516CV300 is not set
# CONFIG_COMMON_CLK_HI3519 is not set
# CONFIG_COMMON_CLK_HI3559A is not set
# CONFIG_COMMON_CLK_HI3660 is not set
# CONFIG_COMMON_CLK_HI3670 is not set
# CONFIG_COMMON_CLK_HI3798CV200 is not set
# CONFIG_COMMON_CLK_HI6220 is not set
# CONFIG_RESET_HISI is not set
# CONFIG_STUB_CLK_HI6220 is not set
# CONFIG_STUB_CLK_HI3660 is not set
# CONFIG_COMMON_CLK_BOSTON is not set
# CONFIG_MXC_CLK is not set
# CONFIG_CLK_IMX8MM is not set
# CONFIG_CLK_IMX8MN is not set
# CONFIG_CLK_IMX8MP is not set
# CONFIG_CLK_IMX8MQ is not set
# CONFIG_CLK_IMX8ULP is not set
# CONFIG_CLK_IMX93 is not set

#
# Ingenic SoCs drivers
#
# CONFIG_INGENIC_CGU_JZ4740 is not set
# CONFIG_INGENIC_CGU_JZ4725B is not set
# CONFIG_INGENIC_CGU_JZ4760 is not set
# CONFIG_INGENIC_CGU_JZ4770 is not set
# CONFIG_INGENIC_CGU_JZ4780 is not set
# CONFIG_INGENIC_CGU_X1000 is not set
# CONFIG_INGENIC_CGU_X1830 is not set
# CONFIG_INGENIC_TCU_CLK is not set
# end of Ingenic SoCs drivers

# CONFIG_TI_SYSCON_CLK is not set

#
# Clock driver for MediaTek SoC
#
# CONFIG_COMMON_CLK_MT2701 is not set
# CONFIG_COMMON_CLK_MT2712 is not set
# CONFIG_COMMON_CLK_MT6765 is not set
# CONFIG_COMMON_CLK_MT6779 is not set
# CONFIG_COMMON_CLK_MT6795 is not set
# CONFIG_COMMON_CLK_MT6797 is not set
# CONFIG_COMMON_CLK_MT7622 is not set
# CONFIG_COMMON_CLK_MT7629 is not set
# CONFIG_COMMON_CLK_MT7986 is not set
# CONFIG_COMMON_CLK_MT8135 is not set
# CONFIG_COMMON_CLK_MT8167 is not set
# CONFIG_COMMON_CLK_MT8173 is not set
# CONFIG_COMMON_CLK_MT8183 is not set
# CONFIG_COMMON_CLK_MT8186 is not set
# CONFIG_COMMON_CLK_MT8192 is not set
# CONFIG_COMMON_CLK_MT8195 is not set
# CONFIG_COMMON_CLK_MT8365 is not set
# CONFIG_COMMON_CLK_MT8516 is not set
# end of Clock driver for MediaTek SoC

#
# Clock support for Amlogic platforms
#
# end of Clock support for Amlogic platforms

# CONFIG_MSTAR_MSC313_MPLL is not set
# CONFIG_MCHP_CLK_MPFS is not set
# CONFIG_COMMON_CLK_PISTACHIO is not set
# CONFIG_CLK_MT7621 is not set
# CONFIG_CLK_RENESAS is not set
# CONFIG_COMMON_CLK_SAMSUNG is not set
# CONFIG_S3C2410_COMMON_CLK is not set
# CONFIG_S3C2412_COMMON_CLK is not set
# CONFIG_S3C2443_COMMON_CLK is not set
# CONFIG_CLK_SIFIVE is not set
# CONFIG_CLK_INTEL_SOCFPGA is not set
# CONFIG_SPRD_COMMON_CLK is not set
# CONFIG_CLK_STARFIVE_JH7100 is not set
CONFIG_CLK_SUNXI=y
CONFIG_CLK_SUNXI_CLOCKS=y
CONFIG_CLK_SUNXI_PRCM_SUN6I=y
CONFIG_CLK_SUNXI_PRCM_SUN8I=y
CONFIG_CLK_SUNXI_PRCM_SUN9I=y
# CONFIG_SUNXI_CCU is not set
# CONFIG_COMMON_CLK_TI_ADPLL is not set
# CONFIG_COMMON_CLK_VISCONTI is not set
CONFIG_XILINX_VCU=y
# CONFIG_COMMON_CLK_ZYNQMP is not set
# CONFIG_CLK_KUNIT_TEST is not set
CONFIG_CLK_GATE_KUNIT_TEST=y
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
# CONFIG_BCM2835_TIMER is not set
# CONFIG_BCM_KONA_TIMER is not set
# CONFIG_DAVINCI_TIMER is not set
# CONFIG_DIGICOLOR_TIMER is not set
# CONFIG_OMAP_DM_TIMER is not set
# CONFIG_DW_APB_TIMER is not set
# CONFIG_FTTMR010_TIMER is not set
# CONFIG_IXP4XX_TIMER is not set
# CONFIG_MESON6_TIMER is not set
# CONFIG_OWL_TIMER is not set
# CONFIG_RDA_TIMER is not set
# CONFIG_SUN4I_TIMER is not set
# CONFIG_SUN5I_HSTIMER is not set
# CONFIG_TEGRA_TIMER is not set
# CONFIG_TEGRA186_TIMER is not set
# CONFIG_VT8500_TIMER is not set
# CONFIG_NPCM7XX_TIMER is not set
# CONFIG_CADENCE_TTC_TIMER is not set
# CONFIG_ASM9260_TIMER is not set
# CONFIG_CLKSRC_DBX500_PRCMU is not set
# CONFIG_CLPS711X_TIMER is not set
# CONFIG_MXS_TIMER is not set
# CONFIG_NSPIRE_TIMER is not set
# CONFIG_INTEGRATOR_AP_TIMER is not set
# CONFIG_CLKSRC_PISTACHIO is not set
# CONFIG_CLKSRC_STM32_LP is not set
# CONFIG_ARMV7M_SYSTICK is not set
# CONFIG_ATMEL_PIT is not set
# CONFIG_ATMEL_ST is not set
# CONFIG_CLKSRC_SAMSUNG_PWM is not set
# CONFIG_FSL_FTM_TIMER is not set
# CONFIG_OXNAS_RPS_TIMER is not set
# CONFIG_MTK_TIMER is not set
# CONFIG_SPRD_TIMER is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_RENESAS_OSTM is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
# CONFIG_CLKSRC_PXA is not set
# CONFIG_TIMER_IMX_SYS_CTR is not set
# CONFIG_CLKSRC_ST_LPC is not set
# CONFIG_GXP_TIMER is not set
# CONFIG_MSC313E_TIMER is not set
# CONFIG_INGENIC_TIMER is not set
# CONFIG_INGENIC_SYSOST is not set
# CONFIG_INGENIC_OST is not set
# CONFIG_MICROCHIP_PIT64B is not set
# CONFIG_GOLDFISH_TIMER is not set
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_IMX_MBOX is not set
# CONFIG_ROCKCHIP_MBOX is not set
# CONFIG_ALTERA_MBOX is not set
# CONFIG_POLARFIRE_SOC_MAILBOX is not set
# CONFIG_QCOM_APCS_IPC is not set
# CONFIG_BCM_PDC_MBOX is not set
# CONFIG_STM32_IPCC is not set
# CONFIG_MTK_ADSP_MBOX is not set
# CONFIG_MTK_CMDQ_MBOX is not set
# CONFIG_SUN6I_MSGBOX is not set
# CONFIG_SPRD_MBOX is not set
# CONFIG_QCOM_IPCC is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_IOMMU_IO_PGTABLE_ARMV7S is not set
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
# CONFIG_OMAP_IOMMU is not set
# CONFIG_ROCKCHIP_IOMMU is not set
# CONFIG_SUN50I_IOMMU is not set
# CONFIG_EXYNOS_IOMMU is not set
# CONFIG_S390_CCW_IOMMU is not set
# CONFIG_S390_AP_IOMMU is not set
# CONFIG_MTK_IOMMU is not set
# CONFIG_SPRD_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
CONFIG_RPMSG_CTRL=y
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# CONFIG_MESON_CANVAS is not set
# CONFIG_MESON_CLK_MEASURE is not set
# CONFIG_MESON_GX_SOCINFO is not set
# CONFIG_MESON_MX_SOCINFO is not set
# end of Amlogic SoC drivers

#
# Apple SoC drivers
#
# CONFIG_APPLE_RTKIT is not set
# CONFIG_APPLE_SART is not set
# end of Apple SoC drivers

#
# ASPEED SoC drivers
#
# CONFIG_ASPEED_LPC_CTRL is not set
# CONFIG_ASPEED_LPC_SNOOP is not set
# CONFIG_ASPEED_UART_ROUTING is not set
# CONFIG_ASPEED_P2A_CTRL is not set
# CONFIG_ASPEED_SOCINFO is not set
# end of ASPEED SoC drivers

# CONFIG_AT91_SOC_ID is not set
# CONFIG_AT91_SOC_SFR is not set

#
# Broadcom SoC drivers
#
# CONFIG_SOC_BCM63XX is not set
# CONFIG_SOC_BRCMSTB is not set
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# CONFIG_SOC_IMX8M is not set
# CONFIG_SOC_IMX9 is not set
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
# CONFIG_IXP4XX_QMGR is not set
# CONFIG_IXP4XX_NPE is not set
# end of IXP4xx SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# CONFIG_LITEX_SOC_CONTROLLER is not set
# end of Enable LiteX SoC Builder specific drivers

#
# MediaTek SoC drivers
#
# CONFIG_MTK_CMDQ is not set
# CONFIG_MTK_DEVAPC is not set
# CONFIG_MTK_INFRACFG is not set
# CONFIG_MTK_MMSYS is not set
# end of MediaTek SoC drivers

#
# Qualcomm SoC drivers
#
# CONFIG_QCOM_GENI_SE is not set
# CONFIG_QCOM_GSBI is not set
# CONFIG_QCOM_LLCC is not set
# CONFIG_QCOM_RPMH is not set
# CONFIG_QCOM_SMD_RPM is not set
# CONFIG_QCOM_SPM is not set
# CONFIG_QCOM_WCNSS_CTRL is not set
# CONFIG_QCOM_APR is not set
# CONFIG_QCOM_ICC_BWMON is not set
# end of Qualcomm SoC drivers

# CONFIG_SOC_RENESAS is not set
# CONFIG_ROCKCHIP_GRF is not set
# CONFIG_SOC_SAMSUNG is not set
# CONFIG_SOC_TI is not set
# CONFIG_UX500_SOC_ID is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_ARM_EXYNOS_BUS_DEVFREQ is not set
# CONFIG_ARM_IMX_BUS_DEVFREQ is not set
# CONFIG_ARM_TEGRA_DEVFREQ is not set
# CONFIG_ARM_MEDIATEK_CCI_DEVFREQ is not set
# CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ is not set
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_DMA is not set
# CONFIG_IIO_BUFFER_DMAENGINE is not set
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
CONFIG_IIO_SW_TRIGGER=y
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
CONFIG_ADIS16201=y
CONFIG_ADIS16209=y
CONFIG_ADXL313=y
# CONFIG_ADXL313_I2C is not set
CONFIG_ADXL313_SPI=y
CONFIG_ADXL345=y
# CONFIG_ADXL345_I2C is not set
CONFIG_ADXL345_SPI=y
CONFIG_ADXL355=y
CONFIG_ADXL355_I2C=y
CONFIG_ADXL355_SPI=y
# CONFIG_ADXL367_SPI is not set
# CONFIG_ADXL367_I2C is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
CONFIG_BMA180=y
CONFIG_BMA220=y
CONFIG_BMA400=y
CONFIG_BMA400_I2C=y
CONFIG_BMA400_SPI=y
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_BMC150_ACCEL_SPI=y
CONFIG_BMI088_ACCEL=y
CONFIG_BMI088_ACCEL_SPI=y
# CONFIG_DA280 is not set
CONFIG_DA311=y
CONFIG_DMARD06=y
# CONFIG_DMARD09 is not set
CONFIG_DMARD10=y
CONFIG_FXLS8962AF=y
CONFIG_FXLS8962AF_I2C=y
# CONFIG_FXLS8962AF_SPI is not set
CONFIG_HID_SENSOR_ACCEL_3D=y
CONFIG_KXSD9=y
# CONFIG_KXSD9_SPI is not set
CONFIG_KXSD9_I2C=y
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=y
CONFIG_MMA7455=y
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7455_SPI=y
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=y
# CONFIG_MSA311 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
CONFIG_SCA3000=y
CONFIG_SCA3300=y
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7091R5=y
CONFIG_AD7124=y
# CONFIG_AD7192 is not set
CONFIG_AD7266=y
CONFIG_AD7280=y
CONFIG_AD7291=y
CONFIG_AD7292=y
# CONFIG_AD7298 is not set
CONFIG_AD7476=y
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
CONFIG_AD7606_IFACE_SPI=y
CONFIG_AD7766=y
CONFIG_AD7768_1=y
# CONFIG_AD7780 is not set
CONFIG_AD7791=y
CONFIG_AD7793=y
CONFIG_AD7887=y
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_ASPEED_ADC is not set
# CONFIG_AT91_SAMA5D2_ADC is not set
CONFIG_AXP20X_ADC=y
CONFIG_AXP288_ADC=y
# CONFIG_BCM_IPROC_ADC is not set
# CONFIG_BERLIN2_ADC is not set
CONFIG_DA9150_GPADC=y
# CONFIG_ENVELOPE_DETECTOR is not set
CONFIG_HI8435=y
CONFIG_HX711=y
# CONFIG_INA2XX_ADC is not set
# CONFIG_INGENIC_ADC is not set
# CONFIG_IMX7D_ADC is not set
# CONFIG_IMX8QXP_ADC is not set
# CONFIG_LPC18XX_ADC is not set
# CONFIG_LPC32XX_ADC is not set
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
# CONFIG_LTC2496 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
CONFIG_MAX11205=y
# CONFIG_MAX1241 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
CONFIG_MEDIATEK_MT6360_ADC=y
# CONFIG_MEDIATEK_MT6577_AUXADC is not set
CONFIG_NAU7802=y
# CONFIG_NPCM_ADC is not set
# CONFIG_PALMAS_GPADC is not set
CONFIG_QCOM_VADC_COMMON=y
# CONFIG_QCOM_PM8XXX_XOADC is not set
CONFIG_QCOM_SPMI_IADC=y
CONFIG_QCOM_SPMI_VADC=y
CONFIG_QCOM_SPMI_ADC5=y
# CONFIG_RCAR_GYRO_ADC is not set
# CONFIG_ROCKCHIP_SARADC is not set
CONFIG_RICHTEK_RTQ6056=y
# CONFIG_RZG2L_ADC is not set
# CONFIG_SC27XX_ADC is not set
# CONFIG_SPEAR_ADC is not set
CONFIG_SD_ADC_MODULATOR=y
# CONFIG_STM32_DFSDM_CORE is not set
# CONFIG_STM32_DFSDM_ADC is not set
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADC0832=y
# CONFIG_TI_ADC084S021 is not set
CONFIG_TI_ADC12138=y
CONFIG_TI_ADC108S102=y
CONFIG_TI_ADC128S052=y
CONFIG_TI_ADC161S626=y
CONFIG_TI_ADS1015=y
# CONFIG_TI_ADS7950 is not set
CONFIG_TI_ADS8344=y
CONFIG_TI_ADS8688=y
CONFIG_TI_ADS124S08=y
CONFIG_TI_ADS131E08=y
CONFIG_TI_AM335X_ADC=y
# CONFIG_TI_TLC4541 is not set
CONFIG_TI_TSC2046=y
# CONFIG_VF610_ADC is not set
CONFIG_XILINX_XADC=y
# CONFIG_XILINX_AMS is not set
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
CONFIG_AD74413R=y
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_AD8366=y
# CONFIG_ADA4250 is not set
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Capacitance to digital converters
#
CONFIG_AD7150=y
CONFIG_AD7746=y
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_ATLAS_EZO_SENSOR=y
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_BME680_SPI=y
CONFIG_CCS811=y
CONFIG_IAQCORE=y
CONFIG_PMS7003=y
CONFIG_SCD30_CORE=y
CONFIG_SCD30_I2C=y
CONFIG_SCD30_SERIAL=y
# CONFIG_SCD4X is not set
CONFIG_SENSIRION_SGP30=y
CONFIG_SENSIRION_SGP40=y
CONFIG_SPS30=y
# CONFIG_SPS30_I2C is not set
CONFIG_SPS30_SERIAL=y
CONFIG_SENSEAIR_SUNRISE_CO2=y
CONFIG_VZ89X=y
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=y
CONFIG_IIO_SSP_SENSORHUB=y
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
# CONFIG_AD3552R is not set
CONFIG_AD5064=y
CONFIG_AD5360=y
# CONFIG_AD5380 is not set
CONFIG_AD5421=y
CONFIG_AD5446=y
CONFIG_AD5449=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5592R=y
# CONFIG_AD5593R is not set
CONFIG_AD5504=y
CONFIG_AD5624R_SPI=y
# CONFIG_LTC2688 is not set
CONFIG_AD5686=y
CONFIG_AD5686_SPI=y
CONFIG_AD5696_I2C=y
CONFIG_AD5755=y
CONFIG_AD5758=y
CONFIG_AD5761=y
CONFIG_AD5764=y
CONFIG_AD5766=y
CONFIG_AD5770R=y
CONFIG_AD5791=y
# CONFIG_AD7293 is not set
CONFIG_AD7303=y
CONFIG_AD8801=y
CONFIG_DPOT_DAC=y
# CONFIG_DS4424 is not set
# CONFIG_LPC18XX_DAC is not set
CONFIG_LTC1660=y
CONFIG_LTC2632=y
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
CONFIG_MAX5821=y
CONFIG_MCP4725=y
CONFIG_MCP4922=y
CONFIG_TI_DAC082S085=y
CONFIG_TI_DAC5571=y
CONFIG_TI_DAC7311=y
# CONFIG_TI_DAC7612 is not set
# CONFIG_VF610_DAC is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=y
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
# CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
# end of IIO dummy driver

#
# Filters
#
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=y
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# CONFIG_ADF4371 is not set
# CONFIG_ADMV1013 is not set
CONFIG_ADMV4420=y
# CONFIG_ADRF6780 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
CONFIG_ADIS16130=y
CONFIG_ADIS16136=y
CONFIG_ADIS16260=y
CONFIG_ADXRS290=y
CONFIG_ADXRS450=y
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_BMG160_SPI=y
CONFIG_FXAS21002C=y
CONFIG_FXAS21002C_I2C=y
CONFIG_FXAS21002C_SPI=y
CONFIG_HID_SENSOR_GYRO_3D=y
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
# CONFIG_IIO_ST_GYRO_SPI_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
CONFIG_MAX30100=y
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
CONFIG_HDC2010=y
# CONFIG_HID_SENSOR_HUMIDITY is not set
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTS221_SPI=y
CONFIG_HTU21=y
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_ADIS16400=y
CONFIG_ADIS16460=y
CONFIG_ADIS16475=y
CONFIG_ADIS16480=y
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_BMI160_SPI=y
CONFIG_BOSCH_BNO055=y
CONFIG_BOSCH_BNO055_SERIAL=y
CONFIG_BOSCH_BNO055_I2C=y
CONFIG_FXOS8700=y
CONFIG_FXOS8700_I2C=y
CONFIG_FXOS8700_SPI=y
CONFIG_KMX61=y
CONFIG_INV_ICM42600=y
# CONFIG_INV_ICM42600_I2C is not set
CONFIG_INV_ICM42600_SPI=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_INV_MPU6050_SPI=y
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
CONFIG_ADJD_S311=y
CONFIG_ADUX1020=y
CONFIG_AL3010=y
CONFIG_AL3320A=y
CONFIG_APDS9300=y
# CONFIG_APDS9960 is not set
CONFIG_AS73211=y
# CONFIG_BH1750 is not set
CONFIG_BH1780=y
CONFIG_CM32181=y
CONFIG_CM3232=y
CONFIG_CM3323=y
CONFIG_CM3605=y
# CONFIG_CM36651 is not set
CONFIG_GP2AP002=y
CONFIG_GP2AP020A00F=y
# CONFIG_IQS621_ALS is not set
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=y
CONFIG_ISL29125=y
CONFIG_HID_SENSOR_ALS=y
CONFIG_HID_SENSOR_PROX=y
# CONFIG_JSA1212 is not set
CONFIG_RPR0521=y
CONFIG_LTR501=y
CONFIG_LTRF216A=y
# CONFIG_LV0104CS is not set
CONFIG_MAX44000=y
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=y
CONFIG_PA12203001=y
CONFIG_SI1133=y
CONFIG_SI1145=y
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
CONFIG_TCS3414=y
CONFIG_TCS3472=y
# CONFIG_SENSORS_TSL2563 is not set
CONFIG_TSL2583=y
CONFIG_TSL2591=y
# CONFIG_TSL2772 is not set
CONFIG_TSL4531=y
# CONFIG_US5182D is not set
CONFIG_VCNL4000=y
CONFIG_VCNL4035=y
CONFIG_VEML6030=y
CONFIG_VEML6070=y
CONFIG_VL6180=y
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_BMC150_MAGN_SPI=y
CONFIG_MAG3110=y
# CONFIG_HID_SENSOR_MAGNETOMETER_3D is not set
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
# CONFIG_IIO_ST_MAGN_SPI_3AXIS is not set
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
CONFIG_SENSORS_HMC5843_SPI=y
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
# CONFIG_SENSORS_RM3100_SPI is not set
CONFIG_YAMAHA_YAS530=y
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=y
CONFIG_HID_SENSOR_DEVICE_ROTATION=y
# end of Inclinometer sensors

CONFIG_IIO_RESCALE_KUNIT_TEST=y
CONFIG_IIO_FORMAT_KUNIT_TEST=y

#
# Triggers - standalone
#
# CONFIG_IIO_HRTIMER_TRIGGER is not set
CONFIG_IIO_INTERRUPT_TRIGGER=y
# CONFIG_IIO_STM32_LPTIMER_TRIGGER is not set
# CONFIG_IIO_STM32_TIMER_TRIGGER is not set
CONFIG_IIO_TIGHTLOOP_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# CONFIG_IQS624_POS is not set
CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE=y
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=y
# CONFIG_AD5272 is not set
CONFIG_DS1803=y
CONFIG_MAX5432=y
CONFIG_MAX5481=y
CONFIG_MAX5487=y
# CONFIG_MCP4018 is not set
CONFIG_MCP4131=y
# CONFIG_MCP4531 is not set
CONFIG_MCP41010=y
CONFIG_TPL0102=y
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=y
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_BMP280_SPI=y
CONFIG_DLHL60D=y
CONFIG_DPS310=y
CONFIG_HID_SENSOR_PRESS=y
# CONFIG_HP03 is not set
CONFIG_ICP10100=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL115_SPI=y
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
# CONFIG_IIO_ST_PRESS_I2C is not set
CONFIG_IIO_ST_PRESS_SPI=y
CONFIG_T5403=y
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
CONFIG_ZPA2326_SPI=y
# end of Pressure sensors

#
# Lightning sensors
#
CONFIG_AS3935=y
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=y
CONFIG_LIDAR_LITE_V2=y
CONFIG_MB1232=y
CONFIG_PING=y
CONFIG_RFD77402=y
CONFIG_SRF04=y
# CONFIG_SX9310 is not set
# CONFIG_SX9324 is not set
# CONFIG_SX9360 is not set
CONFIG_SX9500=y
CONFIG_SRF08=y
CONFIG_VCNL3020=y
CONFIG_VL53L0X_I2C=y
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
CONFIG_AD2S90=y
CONFIG_AD2S1200=y
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_IQS620AT_TEMP is not set
CONFIG_LTC2983=y
CONFIG_MAXIM_THERMOCOUPLE=y
# CONFIG_HID_SENSOR_TEMP is not set
CONFIG_MLX90614=y
CONFIG_MLX90632=y
CONFIG_TMP006=y
CONFIG_TMP007=y
CONFIG_TMP117=y
CONFIG_TSYS01=y
CONFIG_TSYS02D=y
# CONFIG_MAX31856 is not set
# CONFIG_MAX31865 is not set
# end of Temperature sensors

CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_BCM_IPROC is not set
# CONFIG_PWM_BCM_KONA is not set
# CONFIG_PWM_BCM2835 is not set
# CONFIG_PWM_BERLIN is not set
# CONFIG_PWM_BRCMSTB is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_CLPS711X is not set
# CONFIG_PWM_EP93XX is not set
# CONFIG_PWM_HIBVT is not set
# CONFIG_PWM_IMG is not set
# CONFIG_PWM_IMX1 is not set
# CONFIG_PWM_IMX27 is not set
# CONFIG_PWM_IMX_TPM is not set
# CONFIG_PWM_INTEL_LGM is not set
# CONFIG_PWM_IQS620A is not set
# CONFIG_PWM_JZ4740 is not set
# CONFIG_PWM_KEEMBAY is not set
# CONFIG_PWM_LP3943 is not set
# CONFIG_PWM_LPC18XX_SCT is not set
# CONFIG_PWM_LPC32XX is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_MESON is not set
# CONFIG_PWM_MTK_DISP is not set
# CONFIG_PWM_MEDIATEK is not set
CONFIG_PWM_PCA9685=y
# CONFIG_PWM_PXA is not set
# CONFIG_PWM_RASPBERRYPI_POE is not set
# CONFIG_PWM_RCAR is not set
# CONFIG_PWM_RENESAS_TPU is not set
# CONFIG_PWM_ROCKCHIP is not set
# CONFIG_PWM_SAMSUNG is not set
# CONFIG_PWM_SL28CPLD is not set
# CONFIG_PWM_SPRD is not set
# CONFIG_PWM_STM32 is not set
# CONFIG_PWM_STM32_LP is not set
# CONFIG_PWM_SUN4I is not set
# CONFIG_PWM_TEGRA is not set
# CONFIG_PWM_TIECAP is not set
# CONFIG_PWM_TIEHRPWM is not set
# CONFIG_PWM_VISCONTI is not set
# CONFIG_PWM_VT8500 is not set

#
# IRQ chip support
#
# CONFIG_AL_FIC is not set
# CONFIG_RENESAS_INTC_IRQPIN is not set
# CONFIG_RENESAS_IRQC is not set
# CONFIG_RENESAS_RZA1_IRQC is not set
# CONFIG_RENESAS_RZG2L_IRQC is not set
# CONFIG_SL28CPLD_INTC is not set
# CONFIG_TS4800_IRQ is not set
# CONFIG_INGENIC_TCU_IRQ is not set
# CONFIG_IRQ_UNIPHIER_AIDET is not set
# CONFIG_MESON_IRQ_GPIO is not set
# CONFIG_IMX_IRQSTEER is not set
# CONFIG_IMX_INTMUX is not set
# CONFIG_EXYNOS_IRQ_COMBINER is not set
# CONFIG_MST_IRQ is not set
# CONFIG_MCHP_EIC is not set
# CONFIG_SUNPLUS_SP7021_INTC is not set
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_A10SR is not set
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_AXS10X is not set
# CONFIG_RESET_BCM6345 is not set
# CONFIG_RESET_BERLIN is not set
# CONFIG_RESET_BRCMSTB is not set
# CONFIG_RESET_BRCMSTB_RESCAL is not set
# CONFIG_RESET_HSDK is not set
# CONFIG_RESET_IMX7 is not set
# CONFIG_RESET_LANTIQ is not set
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MCHP_SPARX5 is not set
# CONFIG_RESET_MESON is not set
# CONFIG_RESET_MESON_AUDIO_ARB is not set
# CONFIG_RESET_NPCM is not set
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_QCOM_AOSS is not set
# CONFIG_RESET_QCOM_PDC is not set
# CONFIG_RESET_RASPBERRYPI is not set
# CONFIG_RESET_RZG2L_USBPHY_CTRL is not set
# CONFIG_RESET_SCMI is not set
# CONFIG_RESET_SIMPLE is not set
# CONFIG_RESET_SOCFPGA is not set
# CONFIG_RESET_STARFIVE_JH7100 is not set
# CONFIG_RESET_SUNPLUS is not set
# CONFIG_RESET_SUNXI is not set
# CONFIG_RESET_TI_SCI is not set
CONFIG_RESET_TI_SYSCON=y
# CONFIG_RESET_TI_TPS380X is not set
# CONFIG_RESET_TN48M_CPLD is not set
# CONFIG_RESET_ZYNQ is not set
# CONFIG_COMMON_RESET_HI3660 is not set
# CONFIG_COMMON_RESET_HI6220 is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_PHY_PISTACHIO_USB is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set
# CONFIG_PHY_SUN6I_MIPI_DPHY is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_PHY_BCM63XX_USBH is not set
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_PHY_NS2_PCIE is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_HI6220_USB is not set
# CONFIG_PHY_HI3660_USB is not set
# CONFIG_PHY_HI3670_USB is not set
# CONFIG_PHY_HI3670_PCIE is not set
# CONFIG_PHY_HISTB_COMBPHY is not set
# CONFIG_PHY_HISI_INNO_USB2 is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_PXA_USB is not set
# CONFIG_PHY_MMP3_USB is not set
# CONFIG_PHY_MMP3_HSIC is not set
# CONFIG_PHY_MT7621_PCI is not set
# CONFIG_PHY_RALINK_USB is not set
# CONFIG_PHY_RCAR_GEN3_USB3 is not set
# CONFIG_PHY_ROCKCHIP_DPHY_RX0 is not set
# CONFIG_PHY_ROCKCHIP_PCIE is not set
# CONFIG_PHY_ROCKCHIP_SNPS_PCIE3 is not set
# CONFIG_PHY_EXYNOS_MIPI_VIDEO is not set
# CONFIG_PHY_SAMSUNG_USB2 is not set
# CONFIG_PHY_ST_SPEAR1310_MIPHY is not set
# CONFIG_PHY_ST_SPEAR1340_MIPHY is not set
# CONFIG_PHY_STIH407_USB is not set
# CONFIG_PHY_STM32_USBPHYC is not set
# CONFIG_PHY_TEGRA194_P2U is not set
# CONFIG_PHY_DA8XX_USB is not set
# CONFIG_PHY_AM654_SERDES is not set
# CONFIG_OMAP_CONTROL_PHY is not set
# CONFIG_TI_PIPE3 is not set
# CONFIG_PHY_INTEL_KEEMBAY_EMMC is not set
# CONFIG_PHY_INTEL_KEEMBAY_USB is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# CONFIG_PHY_XILINX_ZYNQMP is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# CONFIG_ARM_CCN is not set
# CONFIG_ARM_CMN is not set
# CONFIG_FSL_IMX8_DDR_PMU is not set
# CONFIG_ARM_DMC620_PMU is not set
# CONFIG_ALIBABA_UNCORE_DRW_PMU is not set
# end of Performance monitor support

CONFIG_RAS=y

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_APPLE_EFUSES is not set
# CONFIG_NVMEM_BCM_OCOTP is not set
# CONFIG_NVMEM_BRCM_NVRAM is not set
# CONFIG_NVMEM_IMX_IIM is not set
# CONFIG_NVMEM_IMX_OCOTP is not set
# CONFIG_NVMEM_LAN9662_OTPC is not set
# CONFIG_NVMEM_LAYERSCAPE_SFP is not set
# CONFIG_NVMEM_LPC18XX_EEPROM is not set
# CONFIG_NVMEM_LPC18XX_OTP is not set
# CONFIG_NVMEM_MESON_MX_EFUSE is not set
# CONFIG_NVMEM_MICROCHIP_OTPC is not set
# CONFIG_NVMEM_MTK_EFUSE is not set
# CONFIG_NVMEM_MXS_OCOTP is not set
# CONFIG_NVMEM_NINTENDO_OTP is not set
# CONFIG_NVMEM_QCOM_QFPROM is not set
CONFIG_NVMEM_RAVE_SP_EEPROM=y
CONFIG_NVMEM_RMEM=y
# CONFIG_NVMEM_ROCKCHIP_EFUSE is not set
# CONFIG_NVMEM_ROCKCHIP_OTP is not set
# CONFIG_NVMEM_SC27XX_EFUSE is not set
# CONFIG_NVMEM_SNVS_LPGPR is not set
CONFIG_NVMEM_SPMI_SDAM=y
# CONFIG_NVMEM_SPRD_EFUSE is not set
# CONFIG_NVMEM_STM32_ROMEM is not set
# CONFIG_NVMEM_SUNPLUS_OCOTP is not set
# CONFIG_NVMEM_UNIPHIER_EFUSE is not set
# CONFIG_NVMEM_VF610_OCOTP is not set

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
# CONFIG_STM_SOURCE_HEARTBEAT is not set
CONFIG_STM_SOURCE_FTRACE=y
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_GTH=y
# CONFIG_INTEL_TH_STH is not set
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=y
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_ADGS1408=y
CONFIG_MUX_GPIO=y
# CONFIG_MUX_MMIO is not set
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
# CONFIG_SLIMBUS is not set
CONFIG_INTERCONNECT=y
# CONFIG_INTERCONNECT_IMX is not set
# CONFIG_INTERCONNECT_QCOM_OSM_L3 is not set
# CONFIG_INTERCONNECT_SAMSUNG is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
# CONFIG_INOTIFY_USER is not set
CONFIG_FANOTIFY=y
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_VIRTIO_FS=y
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
# CONFIG_CRAMFS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
CONFIG_PSTORE_LZO_COMPRESS=y
CONFIG_PSTORE_LZ4_COMPRESS=y
CONFIG_PSTORE_LZ4HC_COMPRESS=y
CONFIG_PSTORE_842_COMPRESS=y
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_RAM=y
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_KEY_NOTIFICATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITYFS is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
CONFIG_INIT_STACK_ALL_PATTERN=y
# CONFIG_INIT_STACK_ALL_ZERO is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization

CONFIG_CC_HAS_RANDSTRUCT=y
CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=y
# end of Crypto core or helper

#
# Public-key cryptography
#
# CONFIG_CRYPTO_RSA is not set
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECDSA is not set
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_SM2=y
CONFIG_CRYPTO_CURVE25519=y
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARIA=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_ARC4 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_HCTR2=y
CONFIG_CRYPTO_KEYWRAP=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XCTR=y
# CONFIG_CRYPTO_XTS is not set
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_SEQIV is not set
CONFIG_CRYPTO_ECHAINIV=y
# CONFIG_CRYPTO_ESSIV is not set
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_POLYVAL=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_VMAC is not set
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_XCBC=y
# CONFIG_CRYPTO_XXHASH is not set
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_KDF800108_CTR=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_AUDIT_GENERIC=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE=y
CONFIG_DMA_GLOBAL_POOL=y
CONFIG_DMA_API_DEBUG=y
CONFIG_DMA_API_DEBUG_SG=y
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
# CONFIG_CPUMASK_OFFSTACK is not set
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_GENERIC_ATOMIC64=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_STACKDEPOT=y
CONFIG_REF_TRACKER=y
# CONFIG_PARMAN is not set
# CONFIG_OBJAGG is not set
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_SYMBOLIC_ERRNAME=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_AS_HAS_NON_CONST_LEB128=y
CONFIG_DEBUG_INFO_NONE=y
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
CONFIG_DEBUG_FS_ALLOW_NONE=y
CONFIG_HAVE_ARCH_KGDB=y
CONFIG_KGDB=y
CONFIG_KGDB_TESTS=y
# CONFIG_KGDB_TESTS_ON_BOOT is not set
# CONFIG_KGDB_KDB is not set
CONFIG_UBSAN=y
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_CC_HAS_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_UNREACHABLE is not set
CONFIG_UBSAN_BOOL=y
CONFIG_UBSAN_ENUM=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
CONFIG_NET_DEV_REFCNT_TRACKER=y
# CONFIG_NET_NS_REFCNT_TRACKER is not set
CONFIG_DEBUG_NET=y
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_SLUB_DEBUG is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SOFTLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_SCF_TORTURE_TEST=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
CONFIG_DEBUG_MAPLE_TREE=y
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
CONFIG_RCU_SCALE_TEST=y
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_LATENCYTOP=y
CONFIG_NOP_TRACER=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_OSNOISE_TRACER=y
CONFIG_TIMERLAT_TRACER=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_TRACING_BRANCHES=y
CONFIG_BRANCH_TRACER=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_SYNTH_EVENTS=y
# CONFIG_USER_EVENTS is not set
CONFIG_TRACE_EVENT_INJECT=y
CONFIG_TRACEPOINT_BENCHMARK=y
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_GCOV_PROFILE_FTRACE=y
CONFIG_FTRACE_SELFTEST=y
CONFIG_FTRACE_STARTUP_TEST=y
CONFIG_EVENT_TRACE_STARTUP_TEST=y
# CONFIG_EVENT_TRACE_TEST_SYSCALLS is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
CONFIG_SYNTH_EVENT_GEN_TEST=y
# CONFIG_RV is not set
# CONFIG_SAMPLES is not set

#
# hexagon Debugging
#
# end of hexagon Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
# CONFIG_KUNIT_DEBUGFS is not set
CONFIG_KUNIT_TEST=y
# CONFIG_KUNIT_EXAMPLE_TEST is not set
# CONFIG_KUNIT_ALL_TESTS is not set
# CONFIG_KUNIT_DEFAULT_ENABLED is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
# CONFIG_FAULT_INJECTION_USERCOPY is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_RUNTIME_TESTING_MENU is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking

# CONFIG_WARN_MISSING_DOCUMENTS is not set
# CONFIG_WARN_ABI_ERRORS is not set
# end of Kernel hacking

--h9dSaSZj0sr/muKD--
