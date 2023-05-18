Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6734708828
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjERTCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjERTCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:02:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8785D10B
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 12:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684436470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Ctz6cleYtJzz+dL5tk5OYD3FcF1cwjJGEBm5UiOK7Y=;
        b=aua/dmFC+GgpWifxURTiEq28snohXGXzvROcnrIUzfpkgPFN173WyiOTJqFd0JCZG3+n6C
        yXDTV+tNW7s+qmmf5JgsGshSEKZ4doHNie3a+ebNR4v/1e1yXlfHReiZr+Pje/p084OvhZ
        NLijhrKRqSW8zTiOmZgp0LnRDGpbvwk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-olm2LdlpM_qvTV0E9PRo5w-1; Thu, 18 May 2023 15:01:06 -0400
X-MC-Unique: olm2LdlpM_qvTV0E9PRo5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBF7E1825061;
        Thu, 18 May 2023 19:01:05 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.9.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA91414171C0;
        Thu, 18 May 2023 19:01:04 +0000 (UTC)
Date:   Thu, 18 May 2023 15:01:03 -0400
From:   Phil Auld <pauld@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH RESEND] sched/nohz: Add HRTICK_BW for using cfs bandwidth
 with nohz_full
Message-ID: <20230518190103.GA120739@lorien.usersys.redhat.com>
References: <20230518132038.3534728-1-pauld@redhat.com>
 <202305190022.zJccJfXx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305190022.zJccJfXx-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 12:38:27AM +0800 kernel test robot wrote:
> Hi Phil,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on tip/sched/core]
> [also build test ERROR on tip/master tip/auto-latest linus/master v6.4-rc2 next-20230518]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Phil-Auld/sched-nohz-Add-HRTICK_BW-for-using-cfs-bandwidth-with-nohz_full/20230518-215053
> base:   tip/sched/core
> patch link:    https://lore.kernel.org/r/20230518132038.3534728-1-pauld%40redhat.com
> patch subject: [PATCH RESEND] sched/nohz: Add HRTICK_BW for using cfs bandwidth with nohz_full
> config: arm-randconfig-r046-20230517
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b0fb98227c90adf2536c9ad644a74d5e92961111)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://github.com/intel-lab-lkp/linux/commit/525e4d701ca23f8041908b074be2c82b58a28230
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Phil-Auld/sched-nohz-Add-HRTICK_BW-for-using-cfs-bandwidth-with-nohz_full/20230518-215053
>         git checkout 525e4d701ca23f8041908b074be2c82b58a28230
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash kernel/sched/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202305190022.zJccJfXx-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/sched/fair.c:688:5: warning: no previous prototype for function 'sched_update_scaling' [-Wmissing-prototypes]
>    int sched_update_scaling(void)
>        ^
>    kernel/sched/fair.c:688:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    int sched_update_scaling(void)
>    ^
>    static 
> >> kernel/sched/fair.c:8117:3: error: call to undeclared function 'start_hrtick_cfs_bw'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>                    start_hrtick_cfs_bw(rq, task_cfs_rq(p));
>                    ^
>    1 warning and 1 error generated.
>

Drat, I missed testing with CONFIG_CFS_BANDWIDTH off. Didn't see this was
deep in a #ifdef section.  I'll post v2 which fixes this so it's correct
even though Peter will likely squash it :)


Cheers,
Phil


> 
> vim +/start_hrtick_cfs_bw +8117 kernel/sched/fair.c
> 
>   8112	
>   8113		if (hrtick_enabled_fair(rq))
>   8114			hrtick_start_fair(rq, p);
>   8115	
>   8116		if (hrtick_enabled_bw(rq))
> > 8117			start_hrtick_cfs_bw(rq, task_cfs_rq(p));
>   8118	
>   8119		update_misfit_status(p, rq);
>   8120	
>   8121		return p;
>   8122	
>   8123	idle:
>   8124		if (!rf)
>   8125			return NULL;
>   8126	
>   8127		new_tasks = newidle_balance(rq, rf);
>   8128	
>   8129		/*
>   8130		 * Because newidle_balance() releases (and re-acquires) rq->lock, it is
>   8131		 * possible for any higher priority task to appear. In that case we
>   8132		 * must re-start the pick_next_entity() loop.
>   8133		 */
>   8134		if (new_tasks < 0)
>   8135			return RETRY_TASK;
>   8136	
>   8137		if (new_tasks > 0)
>   8138			goto again;
>   8139	
>   8140		/*
>   8141		 * rq is about to be idle, check if we need to update the
>   8142		 * lost_idle_time of clock_pelt
>   8143		 */
>   8144		update_idle_rq_clock_pelt(rq);
>   8145	
>   8146		return NULL;
>   8147	}
>   8148	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/arm 6.4.0-rc1 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT="clang version 17.0.0 (git://gitmirror/llvm_project b0fb98227c90adf2536c9ad644a74d5e92961111)"
> CONFIG_GCC_VERSION=0
> CONFIG_CC_IS_CLANG=y
> CONFIG_CLANG_VERSION=170000
> CONFIG_AS_IS_LLVM=y
> CONFIG_AS_VERSION=170000
> CONFIG_LD_VERSION=0
> CONFIG_LD_IS_LLD=y
> CONFIG_LLD_VERSION=170000
> CONFIG_RUST_IS_AVAILABLE=y
> CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
> CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
> CONFIG_TOOLS_SUPPORT_RELR=y
> CONFIG_CC_HAS_ASM_INLINE=y
> CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
> CONFIG_PAHOLE_VERSION=125
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_TABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_BROKEN_ON_SMP=y
> CONFIG_INIT_ENV_ARG_LIMIT=32
> CONFIG_COMPILE_TEST=y
> # CONFIG_WERROR is not set
> CONFIG_LOCALVERSION=""
> CONFIG_BUILD_SALT=""
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> # CONFIG_KERNEL_GZIP is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> CONFIG_KERNEL_LZO=y
> # CONFIG_KERNEL_LZ4 is not set
> CONFIG_DEFAULT_INIT=""
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SYSVIPC=y
> CONFIG_WATCH_QUEUE=y
> # CONFIG_CROSS_MEMORY_ATTACH is not set
> CONFIG_USELIB=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
> CONFIG_GENERIC_IRQ_INJECTION=y
> CONFIG_HARDIRQS_SW_RESEND=y
> CONFIG_GENERIC_IRQ_CHIP=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_SIM=y
> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS=y
> CONFIG_GENERIC_MSI_IRQ=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> # end of IRQ subsystem
> 
> CONFIG_GENERIC_IRQ_MULTI_HANDLER=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> 
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_HZ_PERIODIC=y
> # CONFIG_NO_HZ_IDLE is not set
> # CONFIG_NO_HZ is not set
> CONFIG_HIGH_RES_TIMERS=y
> # end of Timers subsystem
> 
> CONFIG_HAVE_EBPF_JIT=y
> 
> #
> # BPF subsystem
> #
> # CONFIG_BPF_SYSCALL is not set
> # end of BPF subsystem
> 
> CONFIG_PREEMPT_VOLUNTARY_BUILD=y
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_COUNT=y
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_TICK_CPU_ACCOUNTING=y
> # CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
> # CONFIG_IRQ_TIME_ACCOUNTING is not set
> CONFIG_PSI=y
> CONFIG_PSI_DEFAULT_DISABLED=y
> # end of CPU/Task time and stats accounting
> 
> CONFIG_CPU_ISOLATION=y
> 
> #
> # RCU Subsystem
> #
> CONFIG_TINY_RCU=y
> CONFIG_RCU_EXPERT=y
> CONFIG_TINY_SRCU=y
> CONFIG_TASKS_RCU_GENERIC=y
> # CONFIG_FORCE_TASKS_RCU is not set
> # CONFIG_FORCE_TASKS_RUDE_RCU is not set
> CONFIG_TASKS_RUDE_RCU=y
> # CONFIG_FORCE_TASKS_TRACE_RCU is not set
> CONFIG_RCU_NEED_SEGCBLIST=y
> # end of RCU Subsystem
> 
> CONFIG_IKCONFIG=y
> # CONFIG_IKCONFIG_PROC is not set
> # CONFIG_IKHEADERS is not set
> CONFIG_LOG_BUF_SHIFT=17
> # CONFIG_PRINTK_INDEX is not set
> CONFIG_GENERIC_SCHED_CLOCK=y
> 
> #
> # Scheduler features
> #
> # end of Scheduler features
> 
> CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough"
> CONFIG_GCC11_NO_ARRAY_BOUNDS=y
> CONFIG_CGROUPS=y
> CONFIG_PAGE_COUNTER=y
> CONFIG_CGROUP_FAVOR_DYNMODS=y
> CONFIG_MEMCG=y
> CONFIG_MEMCG_KMEM=y
> CONFIG_CGROUP_SCHED=y
> # CONFIG_FAIR_GROUP_SCHED is not set
> # CONFIG_RT_GROUP_SCHED is not set
> # CONFIG_CGROUP_PIDS is not set
> # CONFIG_CGROUP_RDMA is not set
> CONFIG_CGROUP_FREEZER=y
> CONFIG_CGROUP_HUGETLB=y
> # CONFIG_CGROUP_DEVICE is not set
> # CONFIG_CGROUP_CPUACCT is not set
> # CONFIG_CGROUP_PERF is not set
> CONFIG_CGROUP_MISC=y
> CONFIG_CGROUP_DEBUG=y
> CONFIG_CHECKPOINT_RESTORE=y
> # CONFIG_SCHED_AUTOGROUP is not set
> # CONFIG_RELAY is not set
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_RD_GZIP=y
> CONFIG_RD_BZIP2=y
> CONFIG_RD_LZMA=y
> CONFIG_RD_XZ=y
> CONFIG_RD_LZO=y
> # CONFIG_RD_LZ4 is not set
> # CONFIG_RD_ZSTD is not set
> CONFIG_BOOT_CONFIG=y
> CONFIG_BOOT_CONFIG_FORCE=y
> # CONFIG_BOOT_CONFIG_EMBED is not set
> # CONFIG_INITRAMFS_PRESERVE_MTIME is not set
> # CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> CONFIG_LD_ORPHAN_WARN=y
> CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
> CONFIG_HAVE_UID16=y
> CONFIG_EXPERT=y
> # CONFIG_MULTIUSER is not set
> CONFIG_SGETMASK_SYSCALL=y
> CONFIG_SYSFS_SYSCALL=y
> CONFIG_FHANDLE=y
> # CONFIG_POSIX_TIMERS is not set
> CONFIG_PRINTK=y
> # CONFIG_BUG is not set
> # CONFIG_BASE_FULL is not set
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> # CONFIG_SHMEM is not set
> CONFIG_AIO=y
> # CONFIG_IO_URING is not set
> CONFIG_ADVISE_SYSCALLS=y
> CONFIG_MEMBARRIER=y
> CONFIG_KALLSYMS=y
> # CONFIG_KALLSYMS_SELFTEST is not set
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> CONFIG_KCMP=y
> CONFIG_RSEQ=y
> CONFIG_DEBUG_RSEQ=y
> CONFIG_EMBEDDED=y
> CONFIG_HAVE_PERF_EVENTS=y
> CONFIG_PERF_USE_VMALLOC=y
> CONFIG_PC104=y
> 
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> CONFIG_DEBUG_PERF_USE_VMALLOC=y
> # end of Kernel Performance Events And Counters
> 
> CONFIG_SYSTEM_DATA_VERIFICATION=y
> CONFIG_PROFILING=y
> CONFIG_TRACEPOINTS=y
> # end of General setup
> 
> CONFIG_ARM=y
> CONFIG_SYS_SUPPORTS_APM_EMULATION=y
> CONFIG_HAVE_TCM=y
> CONFIG_HAVE_PROC_CPU=y
> CONFIG_NO_IOPORT_MAP=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_ARCH_HAS_BANDGAP=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_GENERIC_HWEIGHT=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_ARM_PATCH_PHYS_VIRT=y
> CONFIG_PGTABLE_LEVELS=3
> 
> #
> # System Type
> #
> CONFIG_MMU=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_BITS_MAX=16
> # CONFIG_ARCH_MULTIPLATFORM is not set
> 
> #
> # Platform selection
> #
> 
> #
> # CPU Core family selection
> #
> # CONFIG_ARCH_MULTI_V6 is not set
> CONFIG_ARCH_MULTI_V7=y
> CONFIG_ARCH_MULTI_V6_V7=y
> # end of Platform selection
> 
> CONFIG_ARCH_VIRT=y
> CONFIG_ARCH_AIROHA=y
> CONFIG_ARCH_ACTIONS=y
> CONFIG_ARCH_ALPINE=y
> CONFIG_ARCH_ARTPEC=y
> # CONFIG_MACH_ARTPEC6 is not set
> CONFIG_ARCH_ASPEED=y
> # CONFIG_MACH_ASPEED_G6 is not set
> # CONFIG_ARCH_AT91 is not set
> # CONFIG_ARCH_AXXIA is not set
> CONFIG_ARCH_BCM=y
> 
> #
> # IPROC architected SoCs
> #
> CONFIG_ARCH_BCM_IPROC=y
> CONFIG_ARCH_BCM_CYGNUS=y
> # CONFIG_ARCH_BCM_HR2 is not set
> CONFIG_ARCH_BCM_NSP=y
> CONFIG_ARCH_BCM_5301X=y
> 
> #
> # KONA architected SoCs
> #
> CONFIG_ARCH_BCM_MOBILE=y
> CONFIG_ARCH_BCM_281XX=y
> # CONFIG_ARCH_BCM_21664 is not set
> CONFIG_ARCH_BCM_23550=y
> CONFIG_ARCH_BCM_MOBILE_L2_CACHE=y
> CONFIG_ARCH_BCM_MOBILE_SMC=y
> 
> #
> # Other Architectures
> #
> # CONFIG_ARCH_BCM2835 is not set
> # CONFIG_ARCH_BCM_53573 is not set
> CONFIG_ARCH_BRCMSTB=y
> CONFIG_ARCH_BCMBCA=y
> 
> #
> # BCMBCA sub platforms
> #
> CONFIG_ARCH_BCMBCA_CORTEXA7=y
> CONFIG_ARCH_BCMBCA_CORTEXA9=y
> CONFIG_ARCH_BCMBCA_BRAHMAB15=y
> # CONFIG_ARCH_BERLIN is not set
> # CONFIG_ARCH_DIGICOLOR is not set
> # CONFIG_ARCH_EXYNOS is not set
> # CONFIG_ARCH_HIGHBANK is not set
> CONFIG_ARCH_HISI=y
> 
> #
> # Hisilicon platform type
> #
> CONFIG_ARCH_HI3xxx=y
> # CONFIG_ARCH_HIP01 is not set
> CONFIG_ARCH_HIP04=y
> CONFIG_ARCH_HIX5HD2=y
> # end of Hisilicon platform type
> 
> # CONFIG_ARCH_HPE is not set
> # CONFIG_ARCH_MXC is not set
> CONFIG_ARCH_KEYSTONE=y
> CONFIG_ARCH_MEDIATEK=y
> # CONFIG_MACH_MT2701 is not set
> CONFIG_MACH_MT6589=y
> CONFIG_MACH_MT6592=y
> # CONFIG_MACH_MT7623 is not set
> CONFIG_MACH_MT7629=y
> # CONFIG_MACH_MT8127 is not set
> # CONFIG_MACH_MT8135 is not set
> # CONFIG_ARCH_MESON is not set
> # CONFIG_ARCH_MILBEAUT is not set
> CONFIG_ARCH_MMP=y
> 
> #
> # Marvell PXA168/910/MMP2 Implementations
> #
> # CONFIG_MACH_MMP2_DT is not set
> # CONFIG_MACH_MMP3_DT is not set
> # end of Marvell PXA168/910/MMP2 Implementations
> 
> # CONFIG_ARCH_MSTARV7 is not set
> # CONFIG_ARCH_MVEBU is not set
> CONFIG_ARCH_NPCM=y
> CONFIG_ARCH_NPCM7XX=y
> CONFIG_ARCH_OMAP=y
> 
> #
> # TI OMAP/AM/DM/DRA Family
> #
> CONFIG_OMAP_HWMOD=y
> CONFIG_ARCH_OMAP3=y
> CONFIG_ARCH_OMAP4=y
> CONFIG_SOC_OMAP5=y
> CONFIG_SOC_AM33XX=y
> # CONFIG_SOC_AM43XX is not set
> # CONFIG_SOC_DRA7XX is not set
> CONFIG_ARCH_OMAP2PLUS=y
> CONFIG_OMAP_INTERCONNECT_BARRIER=y
> 
> #
> # TI OMAP2/3/4 Specific Features
> #
> # CONFIG_ARCH_OMAP2PLUS_TYPICAL is not set
> CONFIG_SOC_HAS_OMAP2_SDRC=y
> # CONFIG_SOC_HAS_REALTIME_COUNTER is not set
> # CONFIG_POWER_AVS_OMAP is not set
> # CONFIG_OMAP3_L2_AUX_SECURE_SAVE_RESTORE is not set
> CONFIG_SOC_OMAP3430=y
> # CONFIG_SOC_TI81XX is not set
> 
> #
> # OMAP Legacy Platform Data Board Type
> #
> CONFIG_MACH_OMAP_GENERIC=y
> # end of TI OMAP2/3/4 Specific Features
> 
> CONFIG_OMAP5_ERRATA_801819=y
> # end of TI OMAP/AM/DM/DRA Family
> 
> # CONFIG_ARCH_QCOM is not set
> # CONFIG_ARCH_RDA is not set
> # CONFIG_ARCH_REALTEK is not set
> CONFIG_ARCH_ROCKCHIP=y
> CONFIG_ARCH_S5PV210=y
> CONFIG_CPU_S5PV210=y
> CONFIG_ARCH_RENESAS=y
> # CONFIG_ARCH_INTEL_SOCFPGA is not set
> CONFIG_PLAT_SPEAR=y
> # CONFIG_ARCH_SPEAR13XX is not set
> CONFIG_ARCH_STI=y
> CONFIG_SOC_STIH415=y
> CONFIG_SOC_STIH416=y
> CONFIG_SOC_STIH407=y
> # CONFIG_ARCH_STM32 is not set
> CONFIG_ARCH_SUNPLUS=y
> # CONFIG_SOC_SP7021 is not set
> CONFIG_ARCH_SUNXI=y
> # CONFIG_MACH_SUN4I is not set
> # CONFIG_MACH_SUN5I is not set
> # CONFIG_MACH_SUN6I is not set
> # CONFIG_MACH_SUN7I is not set
> CONFIG_MACH_SUN8I=y
> CONFIG_MACH_SUN9I=y
> # CONFIG_ARCH_TEGRA is not set
> CONFIG_ARCH_UNIPHIER=y
> CONFIG_ARCH_U8500=y
> CONFIG_UX500_SOC_DB8500=y
> CONFIG_UX500_DEBUG_UART=2
> CONFIG_ARCH_REALVIEW=y
> # CONFIG_MACH_REALVIEW_EB is not set
> CONFIG_MACH_REALVIEW_PBA8=y
> CONFIG_MACH_REALVIEW_PBX=y
> # CONFIG_ARCH_VEXPRESS is not set
> CONFIG_ARCH_VT8500=y
> CONFIG_ARCH_WM8850=y
> CONFIG_ARCH_ZYNQ=y
> CONFIG_PLAT_VERSATILE=y
> 
> #
> # Processor Type
> #
> CONFIG_CPU_V7=y
> CONFIG_CPU_THUMB_CAPABLE=y
> CONFIG_CPU_32v6K=y
> CONFIG_CPU_32v7=y
> CONFIG_CPU_ABRT_EV7=y
> CONFIG_CPU_PABRT_V7=y
> CONFIG_CPU_CACHE_V7=y
> CONFIG_CPU_CACHE_VIPT=y
> CONFIG_CPU_COPY_V6=y
> CONFIG_CPU_TLB_V7=y
> CONFIG_CPU_HAS_ASID=y
> CONFIG_CPU_CP15=y
> CONFIG_CPU_CP15_MMU=y
> 
> #
> # Processor Features
> #
> CONFIG_ARM_LPAE=y
> CONFIG_ARM_PV_FIXUP=y
> CONFIG_ARM_THUMB=y
> # CONFIG_ARM_THUMBEE is not set
> CONFIG_ARM_VIRT_EXT=y
> # CONFIG_SWP_EMULATE is not set
> CONFIG_CPU_LITTLE_ENDIAN=y
> CONFIG_CPU_ICACHE_DISABLE=y
> CONFIG_CPU_DCACHE_DISABLE=y
> CONFIG_CPU_BPREDICT_DISABLE=y
> CONFIG_CPU_SPECTRE=y
> CONFIG_HARDEN_BRANCH_PREDICTOR=y
> CONFIG_HARDEN_BRANCH_HISTORY=y
> # CONFIG_KUSER_HELPERS is not set
> # CONFIG_VDSO is not set
> CONFIG_OUTER_CACHE=y
> CONFIG_OUTER_CACHE_SYNC=y
> CONFIG_CACHE_B15_RAC=y
> CONFIG_MIGHT_HAVE_CACHE_L2X0=y
> CONFIG_CACHE_L2X0=y
> # CONFIG_CACHE_L2X0_PMU is not set
> CONFIG_PL310_ERRATA_588369=y
> CONFIG_PL310_ERRATA_727915=y
> CONFIG_PL310_ERRATA_753970=y
> CONFIG_PL310_ERRATA_769419=y
> CONFIG_CACHE_UNIPHIER=y
> CONFIG_ARM_L1_CACHE_SHIFT_6=y
> CONFIG_ARM_L1_CACHE_SHIFT_7=y
> CONFIG_ARM_L1_CACHE_SHIFT=7
> CONFIG_ARM_DMA_MEM_BUFFERABLE=y
> CONFIG_ARM_HEAVY_MB=y
> # CONFIG_DEBUG_ALIGN_RODATA is not set
> CONFIG_ARM_ERRATA_430973=y
> CONFIG_ARM_ERRATA_458693=y
> CONFIG_ARM_ERRATA_460075=y
> CONFIG_ARM_ERRATA_720789=y
> CONFIG_ARM_ERRATA_743622=y
> # CONFIG_ARM_ERRATA_751472 is not set
> CONFIG_ARM_ERRATA_754322=y
> CONFIG_ARM_ERRATA_764319=y
> CONFIG_ARM_ERRATA_775420=y
> CONFIG_ARM_ERRATA_773022=y
> CONFIG_ARM_ERRATA_818325_852422=y
> # CONFIG_ARM_ERRATA_821420 is not set
> # CONFIG_ARM_ERRATA_825619 is not set
> CONFIG_ARM_ERRATA_857271=y
> CONFIG_ARM_ERRATA_852421=y
> # CONFIG_ARM_ERRATA_852423 is not set
> # CONFIG_ARM_ERRATA_857272 is not set
> # end of System Type
> 
> #
> # Bus support
> #
> CONFIG_ARM_ERRATA_814220=y
> # end of Bus support
> 
> #
> # Kernel Features
> #
> CONFIG_HAVE_SMP=y
> # CONFIG_SMP is not set
> CONFIG_CURRENT_POINTER_IN_TPIDRURO=y
> CONFIG_IRQSTACKS=y
> CONFIG_HAVE_ARM_SCU=y
> CONFIG_HAVE_ARM_ARCH_TIMER=y
> CONFIG_VMSPLIT_3G=y
> # CONFIG_VMSPLIT_2G is not set
> # CONFIG_VMSPLIT_1G is not set
> CONFIG_PAGE_OFFSET=0xC0000000
> CONFIG_ARM_PSCI=y
> CONFIG_HZ_FIXED=0
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_200 is not set
> # CONFIG_HZ_250 is not set
> CONFIG_HZ_300=y
> # CONFIG_HZ_500 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=300
> CONFIG_SCHED_HRTICK=y
> # CONFIG_THUMB2_KERNEL is not set
> CONFIG_ARM_PATCH_IDIV=y
> CONFIG_AEABI=y
> CONFIG_OABI_COMPAT=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> CONFIG_ARCH_FLATMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_HIGHMEM=y
> # CONFIG_HIGHPTE is not set
> CONFIG_ARCH_FORCE_MAX_ORDER=11
> CONFIG_ALIGNMENT_TRAP=y
> # CONFIG_UACCESS_WITH_MEMCPY is not set
> CONFIG_PARAVIRT=y
> # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> CONFIG_XEN_DOM0=y
> CONFIG_XEN=y
> CONFIG_CC_HAVE_STACKPROTECTOR_TLS=y
> # end of Kernel Features
> 
> #
> # Boot options
> #
> CONFIG_USE_OF=y
> # CONFIG_ATAGS is not set
> CONFIG_ZBOOT_ROM_TEXT=0x0
> CONFIG_ZBOOT_ROM_BSS=0x0
> # CONFIG_ARM_APPENDED_DTB is not set
> CONFIG_CMDLINE=""
> CONFIG_KEXEC=y
> # CONFIG_CRASH_DUMP is not set
> CONFIG_AUTO_ZRELADDR=y
> # CONFIG_EFI is not set
> # end of Boot options
> 
> #
> # CPU Power Management
> #
> 
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> CONFIG_CPU_FREQ_GOV_COMMON=y
> # CONFIG_CPU_FREQ_STAT is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
> CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> # CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> 
> #
> # CPU frequency scaling drivers
> #
> CONFIG_CPUFREQ_DT=y
> CONFIG_CPUFREQ_DT_PLATDEV=y
> CONFIG_ARM_SCPI_CPUFREQ=y
> CONFIG_ARM_BRCMSTB_AVS_CPUFREQ=y
> CONFIG_ARM_MEDIATEK_CPUFREQ=y
> CONFIG_ARM_MEDIATEK_CPUFREQ_HW=y
> # CONFIG_ARM_OMAP2PLUS_CPUFREQ is not set
> # CONFIG_ARM_QCOM_CPUFREQ_HW is not set
> # CONFIG_ARM_RASPBERRYPI_CPUFREQ is not set
> # CONFIG_ARM_S5PV210_CPUFREQ is not set
> # CONFIG_ARM_SCMI_CPUFREQ is not set
> # CONFIG_ARM_SPEAR_CPUFREQ is not set
> CONFIG_ARM_STI_CPUFREQ=y
> CONFIG_ARM_TI_CPUFREQ=y
> # CONFIG_QORIQ_CPUFREQ is not set
> # end of CPU Frequency scaling
> 
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> CONFIG_CPU_IDLE_GOV_LADDER=y
> # CONFIG_CPU_IDLE_GOV_MENU is not set
> CONFIG_CPU_IDLE_GOV_TEO=y
> 
> #
> # ARM CPU Idle Drivers
> #
> # CONFIG_ARM_CPUIDLE is not set
> # CONFIG_ARM_PSCI_CPUIDLE is not set
> # CONFIG_ARM_CLPS711X_CPUIDLE is not set
> CONFIG_ARM_HIGHBANK_CPUIDLE=y
> # CONFIG_ARM_KIRKWOOD_CPUIDLE is not set
> CONFIG_ARM_ZYNQ_CPUIDLE=y
> # CONFIG_ARM_U8500_CPUIDLE is not set
> CONFIG_ARM_AT91_CPUIDLE=y
> # CONFIG_ARM_EXYNOS_CPUIDLE is not set
> # CONFIG_ARM_MVEBU_V7_CPUIDLE is not set
> # CONFIG_ARM_TEGRA_CPUIDLE is not set
> # CONFIG_ARM_QCOM_SPM_CPUIDLE is not set
> # end of ARM CPU Idle Drivers
> # end of CPU Idle
> # end of CPU Power Management
> 
> #
> # Floating point emulation
> #
> 
> #
> # At least one emulation must be selected
> #
> CONFIG_FPE_NWFPE=y
> # CONFIG_FPE_NWFPE_XP is not set
> # CONFIG_FPE_FASTFPE is not set
> # CONFIG_VFP is not set
> # end of Floating point emulation
> 
> #
> # Power management options
> #
> # CONFIG_SUSPEND is not set
> CONFIG_PM=y
> CONFIG_PM_DEBUG=y
> CONFIG_PM_ADVANCED_DEBUG=y
> # CONFIG_DPM_WATCHDOG is not set
> CONFIG_APM_EMULATION=y
> CONFIG_PM_CLK=y
> CONFIG_PM_GENERIC_DOMAINS=y
> CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
> CONFIG_PM_GENERIC_DOMAINS_OF=y
> CONFIG_CPU_PM=y
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_ARM_CPU_SUSPEND=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> # end of Power management options
> 
> CONFIG_AS_VFP_VMRS_FPINST=y
> 
> #
> # General architecture-dependent options
> #
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> # CONFIG_JUMP_LABEL is not set
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_OPTPROBES=y
> CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_HAVE_NMI=y
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_GENERIC_IDLE_POLL_SETUP=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_KEEPINITRD=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> CONFIG_ARCH_32BIT_OFF_T=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_RSEQ=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_MMU_LAZY_TLB_REFCOUNT=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
> CONFIG_HAVE_ARCH_SECCOMP=y
> CONFIG_SECCOMP=y
> CONFIG_HAVE_STACKPROTECTOR=y
> # CONFIG_STACKPROTECTOR is not set
> CONFIG_LTO_NONE=y
> CONFIG_HAVE_CONTEXT_TRACKING_USER=y
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_REL=y
> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
> CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
> CONFIG_SOFTIRQ_ON_OWN_STACK=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_ARCH_MMAP_RND_BITS=8
> CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
> CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
> CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT=y
> CONFIG_CLONE_BACKWARDS=y
> CONFIG_OLD_SIGSUSPEND3=y
> CONFIG_OLD_SIGACTION=y
> CONFIG_COMPAT_32BIT_TIME=y
> CONFIG_ARCH_OPTIONAL_KERNEL_RWX=y
> CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT=y
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> CONFIG_STRICT_KERNEL_RWX=y
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> CONFIG_LOCK_EVENT_COUNTS=y
> CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
> CONFIG_HAVE_ARCH_PFN_VALID=y
> 
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> # end of GCOV-based kernel profiling
> 
> CONFIG_HAVE_GCC_PLUGINS=y
> CONFIG_FUNCTION_ALIGNMENT=0
> # end of General architecture-dependent options
> 
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=1
> # CONFIG_MODULES is not set
> # CONFIG_BLOCK is not set
> CONFIG_ASN1=y
> CONFIG_UNINLINE_SPIN_UNLOCK=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
> CONFIG_FREEZER=y
> 
> #
> # Executable file formats
> #
> # CONFIG_BINFMT_ELF is not set
> # CONFIG_BINFMT_ELF_FDPIC is not set
> # CONFIG_BINFMT_SCRIPT is not set
> CONFIG_ARCH_HAS_BINFMT_FLAT=y
> CONFIG_BINFMT_FLAT=y
> CONFIG_BINFMT_FLAT_ARGVP_ENVP_ON_STACK=y
> # CONFIG_BINFMT_FLAT_OLD is not set
> # CONFIG_BINFMT_ZFLAT is not set
> CONFIG_BINFMT_MISC=y
> # CONFIG_COREDUMP is not set
> # end of Executable file formats
> 
> #
> # Memory Management options
> #
> 
> #
> # SLAB allocator options
> #
> # CONFIG_SLAB is not set
> CONFIG_SLUB=y
> CONFIG_SLUB_TINY=y
> CONFIG_SLAB_MERGE_DEFAULT=y
> # end of SLAB allocator options
> 
> CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
> # CONFIG_COMPAT_BRK is not set
> CONFIG_SELECT_MEMORY_MODEL=y
> # CONFIG_FLATMEM_MANUAL is not set
> CONFIG_SPARSEMEM_MANUAL=y
> CONFIG_SPARSEMEM=y
> CONFIG_SPARSEMEM_STATIC=y
> CONFIG_HAVE_FAST_GUP=y
> CONFIG_ARCH_KEEP_MEMBLOCK=y
> CONFIG_EXCLUSIVE_SYSTEM_RAM=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_COMPACTION=y
> CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
> # CONFIG_PAGE_REPORTING is not set
> CONFIG_MIGRATION=y
> CONFIG_PHYS_ADDR_T_64BIT=y
> CONFIG_MMU_NOTIFIER=y
> # CONFIG_KSM is not set
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_TRANSPARENT_HUGEPAGE=y
> CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
> # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
> CONFIG_NEED_PER_CPU_KM=y
> # CONFIG_CMA is not set
> CONFIG_GENERIC_EARLY_IOREMAP=y
> # CONFIG_IDLE_PAGE_TRACKING is not set
> CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
> CONFIG_ZONE_DMA=y
> # CONFIG_VM_EVENT_COUNTERS is not set
> # CONFIG_PERCPU_STATS is not set
> # CONFIG_GUP_TEST is not set
> CONFIG_DMAPOOL_TEST=y
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> CONFIG_KMAP_LOCAL=y
> CONFIG_KMAP_LOCAL_NON_LINEAR_PTE_ARRAY=y
> # CONFIG_ANON_VMA_NAME is not set
> # CONFIG_USERFAULTFD is not set
> 
> #
> # Data Access Monitoring
> #
> # CONFIG_DAMON is not set
> # end of Data Access Monitoring
> # end of Memory Management options
> 
> # CONFIG_NET is not set
> 
> #
> # Device Drivers
> #
> CONFIG_ARM_AMBA=y
> CONFIG_HAVE_PCI=y
> CONFIG_FORCE_PCI=y
> CONFIG_PCI=y
> CONFIG_PCI_DOMAINS=y
> CONFIG_PCI_DOMAINS_GENERIC=y
> CONFIG_PCI_SYSCALL=y
> CONFIG_PCIEPORTBUS=y
> CONFIG_PCIEAER=y
> CONFIG_PCIEAER_INJECT=y
> # CONFIG_PCIE_ECRC is not set
> # CONFIG_PCIEASPM is not set
> CONFIG_PCIE_PME=y
> # CONFIG_PCIE_DPC is not set
> CONFIG_PCIE_PTM=y
> CONFIG_PCI_MSI=y
> # CONFIG_PCI_QUIRKS is not set
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
> CONFIG_PCI_STUB=y
> CONFIG_PCI_PF_STUB=y
> CONFIG_PCI_ATS=y
> CONFIG_PCI_DOE=y
> CONFIG_PCI_ECAM=y
> CONFIG_PCI_IOV=y
> # CONFIG_PCI_PRI is not set
> # CONFIG_PCI_PASID is not set
> # CONFIG_PCIE_BUS_TUNE_OFF is not set
> # CONFIG_PCIE_BUS_DEFAULT is not set
> CONFIG_PCIE_BUS_SAFE=y
> # CONFIG_PCIE_BUS_PERFORMANCE is not set
> # CONFIG_PCIE_BUS_PEER2PEER is not set
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=16
> # CONFIG_HOTPLUG_PCI is not set
> 
> #
> # PCI controller drivers
> #
> # CONFIG_PCI_AARDVARK is not set
> # CONFIG_PCIE_ALTERA is not set
> # CONFIG_PCIE_APPLE is not set
> # CONFIG_PCI_VERSATILE is not set
> CONFIG_PCIE_BRCMSTB=y
> CONFIG_PCIE_IPROC=y
> CONFIG_PCIE_IPROC_PLATFORM=y
> CONFIG_PCIE_IPROC_BCMA=y
> # CONFIG_PCIE_IPROC_MSI is not set
> # CONFIG_PCI_HOST_THUNDER_PEM is not set
> # CONFIG_PCI_HOST_THUNDER_ECAM is not set
> CONFIG_PCI_FTPCI100=y
> CONFIG_PCI_HOST_COMMON=y
> CONFIG_PCI_HOST_GENERIC=y
> # CONFIG_PCI_IXP4XX is not set
> # CONFIG_PCIE_MEDIATEK is not set
> CONFIG_PCIE_MEDIATEK_GEN3=y
> # CONFIG_PCIE_MT7621 is not set
> CONFIG_PCIE_MICROCHIP_HOST=y
> # CONFIG_PCI_TEGRA is not set
> # CONFIG_PCIE_RCAR_HOST is not set
> CONFIG_PCIE_RCAR_EP=y
> CONFIG_PCI_RCAR_GEN2=y
> CONFIG_PCIE_ROCKCHIP=y
> CONFIG_PCIE_ROCKCHIP_HOST=y
> CONFIG_PCIE_ROCKCHIP_EP=y
> # CONFIG_PCI_V3_SEMI is not set
> # CONFIG_PCI_XGENE is not set
> CONFIG_PCIE_XILINX=y
> # CONFIG_PCIE_XILINX_NWL is not set
> # CONFIG_PCIE_XILINX_CPM is not set
> 
> #
> # Cadence-based PCIe controllers
> #
> CONFIG_PCIE_CADENCE=y
> CONFIG_PCIE_CADENCE_EP=y
> # CONFIG_PCIE_CADENCE_PLAT_HOST is not set
> # CONFIG_PCIE_CADENCE_PLAT_EP is not set
> CONFIG_PCI_J721E=y
> # CONFIG_PCI_J721E_HOST is not set
> CONFIG_PCI_J721E_EP=y
> # end of Cadence-based PCIe controllers
> 
> #
> # DesignWare-based PCIe controllers
> #
> CONFIG_PCIE_DW=y
> CONFIG_PCIE_DW_HOST=y
> CONFIG_PCIE_DW_EP=y
> # CONFIG_PCIE_AL is not set
> # CONFIG_PCI_MESON is not set
> # CONFIG_PCIE_ARTPEC6_HOST is not set
> # CONFIG_PCIE_ARTPEC6_EP is not set
> # CONFIG_PCIE_BT1 is not set
> # CONFIG_PCI_IMX6_HOST is not set
> # CONFIG_PCI_IMX6_EP is not set
> CONFIG_PCI_LAYERSCAPE=y
> CONFIG_PCI_LAYERSCAPE_EP=y
> # CONFIG_PCI_HISI is not set
> # CONFIG_PCIE_KIRIN is not set
> CONFIG_PCIE_HISI_STB=y
> # CONFIG_PCIE_INTEL_GW is not set
> # CONFIG_PCIE_KEEMBAY_HOST is not set
> # CONFIG_PCIE_KEEMBAY_EP is not set
> # CONFIG_PCIE_ARMADA_8K is not set
> # CONFIG_PCIE_TEGRA194_HOST is not set
> # CONFIG_PCIE_TEGRA194_EP is not set
> CONFIG_PCIE_DW_PLAT=y
> CONFIG_PCIE_DW_PLAT_HOST=y
> # CONFIG_PCIE_DW_PLAT_EP is not set
> # CONFIG_PCIE_QCOM is not set
> # CONFIG_PCIE_QCOM_EP is not set
> # CONFIG_PCIE_ROCKCHIP_DW_HOST is not set
> # CONFIG_PCI_EXYNOS is not set
> # CONFIG_PCIE_FU740 is not set
> CONFIG_PCIE_UNIPHIER=y
> CONFIG_PCIE_UNIPHIER_EP=y
> # CONFIG_PCIE_SPEAR13XX is not set
> # CONFIG_PCI_DRA7XX_HOST is not set
> # CONFIG_PCI_DRA7XX_EP is not set
> CONFIG_PCI_KEYSTONE=y
> CONFIG_PCI_KEYSTONE_HOST=y
> CONFIG_PCI_KEYSTONE_EP=y
> # CONFIG_PCIE_VISCONTI_HOST is not set
> # end of DesignWare-based PCIe controllers
> 
> #
> # Mobiveil-based PCIe controllers
> #
> # CONFIG_PCIE_LAYERSCAPE_GEN4 is not set
> # CONFIG_PCIE_MOBIVEIL_PLAT is not set
> # end of Mobiveil-based PCIe controllers
> # end of PCI controller drivers
> 
> #
> # PCI Endpoint
> #
> CONFIG_PCI_ENDPOINT=y
> CONFIG_PCI_ENDPOINT_CONFIGFS=y
> # CONFIG_PCI_EPF_TEST is not set
> CONFIG_PCI_EPF_NTB=y
> # CONFIG_PCI_EPF_VNTB is not set
> # end of PCI Endpoint
> 
> #
> # PCI switch controller drivers
> #
> CONFIG_PCI_SW_SWITCHTEC=y
> # end of PCI switch controller drivers
> 
> CONFIG_CXL_BUS=y
> # CONFIG_CXL_PCI is not set
> CONFIG_CXL_PORT=y
> # CONFIG_CXL_REGION is not set
> # CONFIG_PCCARD is not set
> # CONFIG_RAPIDIO is not set
> 
> #
> # Generic Driver Options
> #
> CONFIG_AUXILIARY_BUS=y
> # CONFIG_UEVENT_HELPER is not set
> CONFIG_DEVTMPFS=y
> CONFIG_DEVTMPFS_MOUNT=y
> CONFIG_DEVTMPFS_SAFE=y
> # CONFIG_STANDALONE is not set
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_FW_LOADER_PAGED_BUF=y
> CONFIG_FW_LOADER_SYSFS=y
> CONFIG_EXTRA_FIRMWARE=""
> CONFIG_FW_LOADER_USER_HELPER=y
> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> CONFIG_FW_LOADER_COMPRESS=y
> CONFIG_FW_LOADER_COMPRESS_XZ=y
> # CONFIG_FW_LOADER_COMPRESS_ZSTD is not set
> # CONFIG_FW_UPLOAD is not set
> # end of Firmware loader
> 
> CONFIG_ALLOW_DEV_COREDUMP=y
> CONFIG_DEBUG_DRIVER=y
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> CONFIG_SYS_HYPERVISOR=y
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_GENERIC_CPU_VULNERABILITIES=y
> CONFIG_SOC_BUS=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=y
> CONFIG_REGMAP_SPMI=y
> CONFIG_REGMAP_W1=y
> CONFIG_REGMAP_MMIO=y
> CONFIG_REGMAP_IRQ=y
> CONFIG_DMA_SHARED_BUFFER=y
> CONFIG_DMA_FENCE_TRACE=y
> # CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
> # end of Generic Driver Options
> 
> #
> # Bus devices
> #
> CONFIG_ARM_CCI=y
> # CONFIG_ARM_INTEGRATOR_LM is not set
> CONFIG_BRCMSTB_GISB_ARB=y
> # CONFIG_BT1_APB is not set
> # CONFIG_BT1_AXI is not set
> # CONFIG_HISILICON_LPC is not set
> # CONFIG_INTEL_IXP4XX_EB is not set
> CONFIG_OMAP_INTERCONNECT=y
> # CONFIG_OMAP_OCP2SCP is not set
> # CONFIG_QCOM_EBI2 is not set
> CONFIG_SUN50I_DE2_BUS=y
> CONFIG_SUNXI_RSB=y
> CONFIG_TI_SYSC=y
> # CONFIG_UNIPHIER_SYSTEM_BUS is not set
> CONFIG_VEXPRESS_CONFIG=y
> # CONFIG_FSL_MC_BUS is not set
> CONFIG_MHI_BUS=y
> CONFIG_MHI_BUS_DEBUG=y
> CONFIG_MHI_BUS_PCI_GENERIC=y
> CONFIG_MHI_BUS_EP=y
> # end of Bus devices
> 
> #
> # Firmware Drivers
> #
> 
> #
> # ARM System Control and Management Interface Protocol
> #
> CONFIG_ARM_SCMI_PROTOCOL=y
> # CONFIG_ARM_SCMI_RAW_MODE_SUPPORT is not set
> CONFIG_ARM_SCMI_HAVE_TRANSPORT=y
> CONFIG_ARM_SCMI_HAVE_SHMEM=y
> CONFIG_ARM_SCMI_HAVE_MSG=y
> # CONFIG_ARM_SCMI_TRANSPORT_MAILBOX is not set
> CONFIG_ARM_SCMI_TRANSPORT_OPTEE=y
> CONFIG_ARM_SCMI_TRANSPORT_SMC=y
> # CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE is not set
> CONFIG_ARM_SCMI_TRANSPORT_VIRTIO=y
> CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_VERSION1_COMPLIANCE=y
> CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE=y
> CONFIG_ARM_SCMI_POWER_DOMAIN=y
> CONFIG_ARM_SCMI_POWER_CONTROL=y
> # end of ARM System Control and Management Interface Protocol
> 
> CONFIG_ARM_SCPI_PROTOCOL=y
> # CONFIG_ARM_SCPI_POWER_DOMAIN is not set
> CONFIG_FIRMWARE_MEMMAP=y
> CONFIG_MTK_ADSP_IPC=y
> # CONFIG_TRUSTED_FOUNDATIONS is not set
> # CONFIG_TURRIS_MOX_RWTM is not set
> CONFIG_BCM47XX_NVRAM=y
> # CONFIG_BCM47XX_SPROM is not set
> # CONFIG_TEE_BNXT_FW is not set
> CONFIG_GOOGLE_FIRMWARE=y
> # CONFIG_GOOGLE_COREBOOT_TABLE is not set
> CONFIG_ARM_PSCI_FW=y
> CONFIG_HAVE_ARM_SMCCC=y
> CONFIG_HAVE_ARM_SMCCC_DISCOVERY=y
> # CONFIG_ARM_SMCCC_SOC_ID is not set
> 
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
> 
> CONFIG_GNSS=y
> CONFIG_GNSS_SERIAL=y
> CONFIG_GNSS_MTK_SERIAL=y
> # CONFIG_GNSS_SIRF_SERIAL is not set
> # CONFIG_GNSS_UBX_SERIAL is not set
> CONFIG_MTD=y
> 
> #
> # Partition parsers
> #
> CONFIG_MTD_AR7_PARTS=y
> # CONFIG_MTD_BCM47XX_PARTS is not set
> # CONFIG_MTD_BCM63XX_PARTS is not set
> # CONFIG_MTD_BRCM_U_BOOT is not set
> # CONFIG_MTD_CMDLINE_PARTS is not set
> CONFIG_MTD_OF_PARTS=y
> # CONFIG_MTD_OF_PARTS_BCM4908 is not set
> # CONFIG_MTD_OF_PARTS_LINKSYS_NS is not set
> # CONFIG_MTD_PARSER_IMAGETAG is not set
> CONFIG_MTD_AFS_PARTS=y
> CONFIG_MTD_PARSER_TPLINK_SAFELOADER=y
> CONFIG_MTD_PARSER_TRX=y
> # CONFIG_MTD_SHARPSL_PARTS is not set
> CONFIG_MTD_REDBOOT_PARTS=y
> CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
> CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
> CONFIG_MTD_REDBOOT_PARTS_READONLY=y
> # end of Partition parsers
> 
> #
> # User Modules And Translation Layers
> #
> # CONFIG_MTD_OOPS is not set
> # CONFIG_MTD_PARTITIONED_MASTER is not set
> 
> #
> # RAM/ROM/Flash chip drivers
> #
> CONFIG_MTD_CFI=y
> # CONFIG_MTD_JEDECPROBE is not set
> CONFIG_MTD_GEN_PROBE=y
> # CONFIG_MTD_CFI_ADV_OPTIONS is not set
> CONFIG_MTD_MAP_BANK_WIDTH_1=y
> CONFIG_MTD_MAP_BANK_WIDTH_2=y
> CONFIG_MTD_MAP_BANK_WIDTH_4=y
> CONFIG_MTD_CFI_I1=y
> CONFIG_MTD_CFI_I2=y
> CONFIG_MTD_CFI_INTELEXT=y
> # CONFIG_MTD_CFI_AMDSTD is not set
> CONFIG_MTD_CFI_STAA=y
> CONFIG_MTD_CFI_UTIL=y
> CONFIG_MTD_RAM=y
> CONFIG_MTD_ROM=y
> # CONFIG_MTD_ABSENT is not set
> # end of RAM/ROM/Flash chip drivers
> 
> #
> # Mapping drivers for chip access
> #
> # CONFIG_MTD_COMPLEX_MAPPINGS is not set
> CONFIG_MTD_PHYSMAP=y
> CONFIG_MTD_PHYSMAP_COMPAT=y
> CONFIG_MTD_PHYSMAP_START=0x8000000
> CONFIG_MTD_PHYSMAP_LEN=0
> CONFIG_MTD_PHYSMAP_BANKWIDTH=2
> # CONFIG_MTD_PHYSMAP_OF is not set
> # CONFIG_MTD_SC520CDP is not set
> # CONFIG_MTD_NETSC520 is not set
> # CONFIG_MTD_TS5500 is not set
> # CONFIG_MTD_INTEL_VR_NOR is not set
> CONFIG_MTD_PLATRAM=y
> # end of Mapping drivers for chip access
> 
> #
> # Self-contained MTD device drivers
> #
> # CONFIG_MTD_PMC551 is not set
> CONFIG_MTD_SPEAR_SMI=y
> # CONFIG_MTD_SLRAM is not set
> # CONFIG_MTD_PHRAM is not set
> CONFIG_MTD_MTDRAM=y
> CONFIG_MTDRAM_TOTAL_SIZE=4096
> CONFIG_MTDRAM_ERASE_SIZE=128
> 
> #
> # Disk-On-Chip Device Drivers
> #
> CONFIG_MTD_DOCG3=y
> CONFIG_MTD_ST_SPI_FSM=y
> CONFIG_BCH_CONST_M=14
> CONFIG_BCH_CONST_T=4
> # end of Self-contained MTD device drivers
> 
> #
> # NAND
> #
> CONFIG_MTD_NAND_CORE=y
> # CONFIG_MTD_ONENAND is not set
> CONFIG_MTD_RAW_NAND=y
> 
> #
> # Raw/parallel NAND flash controllers
> #
> CONFIG_MTD_NAND_DENALI=y
> CONFIG_MTD_NAND_DENALI_PCI=y
> CONFIG_MTD_NAND_DENALI_DT=y
> CONFIG_MTD_NAND_AMS_DELTA=y
> CONFIG_MTD_NAND_OMAP2=y
> CONFIG_MTD_NAND_OMAP_BCH=y
> CONFIG_MTD_NAND_OMAP_BCH_BUILD=y
> # CONFIG_MTD_NAND_SHARPSL is not set
> # CONFIG_MTD_NAND_CAFE is not set
> # CONFIG_MTD_NAND_ATMEL is not set
> # CONFIG_MTD_NAND_MARVELL is not set
> # CONFIG_MTD_NAND_SLC_LPC32XX is not set
> # CONFIG_MTD_NAND_MLC_LPC32XX is not set
> CONFIG_MTD_NAND_BRCMNAND=y
> CONFIG_MTD_NAND_BRCMNAND_BCM63XX=y
> # CONFIG_MTD_NAND_BRCMNAND_BCMBCA is not set
> # CONFIG_MTD_NAND_BRCMNAND_BRCMSTB is not set
> CONFIG_MTD_NAND_BRCMNAND_IPROC=y
> # CONFIG_MTD_NAND_OXNAS is not set
> # CONFIG_MTD_NAND_FSL_IFC is not set
> # CONFIG_MTD_NAND_VF610_NFC is not set
> # CONFIG_MTD_NAND_MXC is not set
> # CONFIG_MTD_NAND_SH_FLCTL is not set
> # CONFIG_MTD_NAND_DAVINCI is not set
> # CONFIG_MTD_NAND_TXX9NDFMC is not set
> # CONFIG_MTD_NAND_FSMC is not set
> CONFIG_MTD_NAND_SUNXI=y
> CONFIG_MTD_NAND_HISI504=y
> # CONFIG_MTD_NAND_QCOM is not set
> # CONFIG_MTD_NAND_MXIC is not set
> # CONFIG_MTD_NAND_TEGRA is not set
> # CONFIG_MTD_NAND_STM32_FMC2 is not set
> # CONFIG_MTD_NAND_MESON is not set
> CONFIG_MTD_NAND_GPIO=y
> CONFIG_MTD_NAND_PLATFORM=y
> CONFIG_MTD_NAND_CADENCE=y
> CONFIG_MTD_NAND_ARASAN=y
> CONFIG_MTD_NAND_INTEL_LGM=y
> CONFIG_MTD_NAND_ROCKCHIP=y
> CONFIG_MTD_NAND_PL35X=y
> CONFIG_MTD_NAND_RENESAS=y
> 
> #
> # Misc
> #
> CONFIG_MTD_SM_COMMON=y
> CONFIG_MTD_NAND_NANDSIM=y
> CONFIG_MTD_NAND_RICOH=y
> # CONFIG_MTD_NAND_DISKONCHIP is not set
> 
> #
> # ECC engine support
> #
> CONFIG_MTD_NAND_ECC=y
> CONFIG_MTD_NAND_ECC_SW_HAMMING=y
> CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
> CONFIG_MTD_NAND_ECC_SW_BCH=y
> # CONFIG_MTD_NAND_ECC_MXIC is not set
> # CONFIG_MTD_NAND_ECC_MEDIATEK is not set
> # end of ECC engine support
> # end of NAND
> 
> #
> # LPDDR & LPDDR2 PCM memory drivers
> #
> CONFIG_MTD_LPDDR=y
> CONFIG_MTD_QINFO_PROBE=y
> CONFIG_MTD_LPDDR2_NVM=y
> # end of LPDDR & LPDDR2 PCM memory drivers
> 
> # CONFIG_MTD_UBI is not set
> # CONFIG_MTD_HYPERBUS is not set
> CONFIG_DTC=y
> CONFIG_OF=y
> # CONFIG_OF_UNITTEST is not set
> # CONFIG_OF_ALL_DTBS is not set
> CONFIG_OF_FLATTREE=y
> CONFIG_OF_EARLY_FLATTREE=y
> CONFIG_OF_KOBJ=y
> CONFIG_OF_ADDRESS=y
> CONFIG_OF_IRQ=y
> CONFIG_OF_RESERVED_MEM=y
> # CONFIG_OF_OVERLAY is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> # CONFIG_PARPORT is not set
> 
> #
> # NVME Support
> #
> # end of NVME Support
> 
> #
> # Misc devices
> #
> CONFIG_AD525X_DPOT=y
> CONFIG_AD525X_DPOT_I2C=y
> # CONFIG_DUMMY_IRQ is not set
> CONFIG_PHANTOM=y
> CONFIG_TIFM_CORE=y
> # CONFIG_TIFM_7XX1 is not set
> CONFIG_ICS932S401=y
> # CONFIG_ATMEL_SSC is not set
> CONFIG_ENCLOSURE_SERVICES=y
> CONFIG_SMPRO_ERRMON=y
> CONFIG_SMPRO_MISC=y
> CONFIG_HI6421V600_IRQ=y
> # CONFIG_HP_ILO is not set
> # CONFIG_QCOM_COINCELL is not set
> # CONFIG_QCOM_FASTRPC is not set
> # CONFIG_APDS9802ALS is not set
> CONFIG_ISL29003=y
> CONFIG_ISL29020=y
> CONFIG_SENSORS_TSL2550=y
> # CONFIG_SENSORS_BH1770 is not set
> CONFIG_SENSORS_APDS990X=y
> CONFIG_HMC6352=y
> # CONFIG_DS1682 is not set
> # CONFIG_PCH_PHUB is not set
> CONFIG_SRAM=y
> CONFIG_SRAM_EXEC=y
> CONFIG_DW_XDATA_PCIE=y
> # CONFIG_PCI_ENDPOINT_TEST is not set
> CONFIG_XILINX_SDFEC=y
> CONFIG_MISC_RTSX=y
> CONFIG_OPEN_DICE=y
> CONFIG_VCPU_STALL_DETECTOR=y
> CONFIG_C2PORT=y
> 
> #
> # EEPROM support
> #
> CONFIG_EEPROM_AT24=y
> # CONFIG_EEPROM_LEGACY is not set
> CONFIG_EEPROM_MAX6875=y
> CONFIG_EEPROM_93CX6=y
> CONFIG_EEPROM_IDT_89HPESX=y
> # CONFIG_EEPROM_EE1004 is not set
> # end of EEPROM support
> 
> CONFIG_CB710_CORE=y
> # CONFIG_CB710_DEBUG is not set
> CONFIG_CB710_DEBUG_ASSUMPTIONS=y
> 
> #
> # Texas Instruments shared transport line discipline
> #
> # end of Texas Instruments shared transport line discipline
> 
> # CONFIG_SENSORS_LIS3_I2C is not set
> CONFIG_ALTERA_STAPL=y
> # CONFIG_ECHO is not set
> CONFIG_BCM_VK=y
> # CONFIG_BCM_VK_TTY is not set
> # CONFIG_MISC_ALCOR_PCI is not set
> CONFIG_MISC_RTSX_PCI=y
> CONFIG_PVPANIC=y
> CONFIG_PVPANIC_MMIO=y
> CONFIG_PVPANIC_PCI=y
> CONFIG_GP_PCI1XXXX=y
> # end of Misc devices
> 
> #
> # SCSI device support
> #
> # end of SCSI device support
> 
> CONFIG_HAVE_PATA_PLATFORM=y
> CONFIG_FUSION=y
> CONFIG_FUSION_MAX_SGE=128
> # CONFIG_FUSION_LOGGING is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_FIREWIRE is not set
> CONFIG_FIREWIRE_NOSY=y
> # end of IEEE 1394 (FireWire) support
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> # CONFIG_INPUT_LEDS is not set
> CONFIG_INPUT_FF_MEMLESS=y
> CONFIG_INPUT_SPARSEKMAP=y
> CONFIG_INPUT_MATRIXKMAP=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> # CONFIG_INPUT_JOYDEV is not set
> CONFIG_INPUT_EVDEV=y
> CONFIG_INPUT_EVBUG=y
> # CONFIG_INPUT_APMPOWER is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> # CONFIG_KEYBOARD_ADC is not set
> # CONFIG_KEYBOARD_ADP5520 is not set
> # CONFIG_KEYBOARD_ADP5588 is not set
> CONFIG_KEYBOARD_ADP5589=y
> # CONFIG_KEYBOARD_ATKBD is not set
> # CONFIG_KEYBOARD_QT1050 is not set
> CONFIG_KEYBOARD_QT1070=y
> # CONFIG_KEYBOARD_QT2160 is not set
> # CONFIG_KEYBOARD_CLPS711X is not set
> CONFIG_KEYBOARD_DLINK_DIR685=y
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_EP93XX is not set
> # CONFIG_KEYBOARD_GPIO is not set
> CONFIG_KEYBOARD_GPIO_POLLED=y
> CONFIG_KEYBOARD_TCA6416=y
> # CONFIG_KEYBOARD_TCA8418 is not set
> CONFIG_KEYBOARD_MATRIX=y
> CONFIG_KEYBOARD_LM8323=y
> CONFIG_KEYBOARD_LM8333=y
> # CONFIG_KEYBOARD_LPC32XX is not set
> # CONFIG_KEYBOARD_MAX7359 is not set
> CONFIG_KEYBOARD_MCS=y
> CONFIG_KEYBOARD_MPR121=y
> # CONFIG_KEYBOARD_SNVS_PWRKEY is not set
> # CONFIG_KEYBOARD_IMX is not set
> CONFIG_KEYBOARD_NEWTON=y
> CONFIG_KEYBOARD_NOMADIK=y
> # CONFIG_KEYBOARD_TEGRA is not set
> CONFIG_KEYBOARD_OPENCORES=y
> CONFIG_KEYBOARD_PINEPHONE=y
> # CONFIG_KEYBOARD_PXA27x is not set
> # CONFIG_KEYBOARD_SAMSUNG is not set
> CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
> CONFIG_KEYBOARD_STOWAWAY=y
> # CONFIG_KEYBOARD_ST_KEYSCAN is not set
> CONFIG_KEYBOARD_SUNKBD=y
> # CONFIG_KEYBOARD_SH_KEYSC is not set
> # CONFIG_KEYBOARD_STMPE is not set
> CONFIG_KEYBOARD_SUN4I_LRADC=y
> CONFIG_KEYBOARD_IQS62X=y
> CONFIG_KEYBOARD_OMAP4=y
> CONFIG_KEYBOARD_SPEAR=y
> # CONFIG_KEYBOARD_TC3589X is not set
> CONFIG_KEYBOARD_TM2_TOUCHKEY=y
> CONFIG_KEYBOARD_TWL4030=y
> CONFIG_KEYBOARD_XTKBD=y
> # CONFIG_KEYBOARD_CAP11XX is not set
> CONFIG_KEYBOARD_BCM=y
> # CONFIG_KEYBOARD_MT6779 is not set
> CONFIG_KEYBOARD_MTK_PMIC=y
> CONFIG_KEYBOARD_CYPRESS_SF=y
> # CONFIG_INPUT_MOUSE is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_88PM80X_ONKEY=y
> CONFIG_INPUT_AB8500_PONKEY=y
> CONFIG_INPUT_AD714X=y
> # CONFIG_INPUT_AD714X_I2C is not set
> # CONFIG_INPUT_ATC260X_ONKEY is not set
> CONFIG_INPUT_ATMEL_CAPTOUCH=y
> # CONFIG_INPUT_BBNSM_PWRKEY is not set
> CONFIG_INPUT_BMA150=y
> # CONFIG_INPUT_E3X0_BUTTON is not set
> CONFIG_INPUT_MAX77650_ONKEY=y
> CONFIG_INPUT_MAX8925_ONKEY=y
> CONFIG_INPUT_MC13783_PWRBUTTON=y
> CONFIG_INPUT_MMA8450=y
> CONFIG_INPUT_GPIO_BEEPER=y
> # CONFIG_INPUT_GPIO_DECODER is not set
> CONFIG_INPUT_GPIO_VIBRA=y
> # CONFIG_INPUT_KXTJ9 is not set
> CONFIG_INPUT_REGULATOR_HAPTIC=y
> CONFIG_INPUT_RETU_PWRBUTTON=y
> CONFIG_INPUT_TPS65218_PWRBUTTON=y
> # CONFIG_INPUT_AXP20X_PEK is not set
> CONFIG_INPUT_TWL4030_PWRBUTTON=y
> # CONFIG_INPUT_TWL4030_VIBRA is not set
> CONFIG_INPUT_TWL6040_VIBRA=y
> CONFIG_INPUT_UINPUT=y
> CONFIG_INPUT_PALMAS_PWRBUTTON=y
> CONFIG_INPUT_PCF50633_PMU=y
> # CONFIG_INPUT_PCF8574 is not set
> # CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
> CONFIG_INPUT_DA7280_HAPTICS=y
> CONFIG_INPUT_DA9055_ONKEY=y
> # CONFIG_INPUT_DA9063_ONKEY is not set
> CONFIG_INPUT_WM831X_ON=y
> CONFIG_INPUT_ADXL34X=y
> # CONFIG_INPUT_ADXL34X_I2C is not set
> CONFIG_INPUT_IBM_PANEL=y
> # CONFIG_INPUT_IQS269A is not set
> CONFIG_INPUT_IQS626A=y
> CONFIG_INPUT_IQS7222=y
> # CONFIG_INPUT_CMA3000 is not set
> # CONFIG_INPUT_XEN_KBDDEV_FRONTEND is not set
> # CONFIG_INPUT_DRV260X_HAPTICS is not set
> CONFIG_INPUT_DRV2665_HAPTICS=y
> # CONFIG_INPUT_DRV2667_HAPTICS is not set
> CONFIG_INPUT_HISI_POWERKEY=y
> CONFIG_INPUT_RAVE_SP_PWRBUTTON=y
> # CONFIG_INPUT_SC27XX_VIBRA is not set
> CONFIG_INPUT_RT5120_PWRKEY=y
> CONFIG_RMI4_CORE=y
> # CONFIG_RMI4_I2C is not set
> CONFIG_RMI4_SMB=y
> CONFIG_RMI4_F03=y
> CONFIG_RMI4_F03_SERIO=y
> CONFIG_RMI4_2D_SENSOR=y
> CONFIG_RMI4_F11=y
> # CONFIG_RMI4_F12 is not set
> # CONFIG_RMI4_F30 is not set
> CONFIG_RMI4_F34=y
> CONFIG_RMI4_F3A=y
> # CONFIG_RMI4_F55 is not set
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_SERIO_SERPORT=y
> CONFIG_SERIO_AMBAKMI=y
> # CONFIG_SERIO_PCIPS2 is not set
> # CONFIG_SERIO_LIBPS2 is not set
> CONFIG_SERIO_RAW=y
> CONFIG_SERIO_ALTERA_PS2=y
> CONFIG_SERIO_PS2MULT=y
> CONFIG_SERIO_ARC_PS2=y
> # CONFIG_SERIO_APBPS2 is not set
> CONFIG_SERIO_OLPC_APSP=y
> CONFIG_SERIO_SUN4I_PS2=y
> CONFIG_SERIO_GPIO_PS2=y
> CONFIG_USERIO=y
> # CONFIG_GAMEPORT is not set
> # end of Hardware I/O ports
> # end of Input device support
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> CONFIG_VT=y
> CONFIG_CONSOLE_TRANSLATIONS=y
> # CONFIG_VT_CONSOLE is not set
> CONFIG_HW_CONSOLE=y
> CONFIG_VT_HW_CONSOLE_BINDING=y
> # CONFIG_UNIX98_PTYS is not set
> # CONFIG_LEGACY_PTYS is not set
> CONFIG_LEGACY_TIOCSTI=y
> # CONFIG_LDISC_AUTOLOAD is not set
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> CONFIG_SERIAL_8250_16550A_VARIANTS=y
> # CONFIG_SERIAL_8250_FINTEK is not set
> # CONFIG_SERIAL_8250_CONSOLE is not set
> CONFIG_SERIAL_8250_DMA=y
> CONFIG_SERIAL_8250_PCILIB=y
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_EXAR=y
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> CONFIG_SERIAL_8250_ASPEED_VUART=y
> CONFIG_SERIAL_8250_PCI1XXXX=y
> CONFIG_SERIAL_8250_DWLIB=y
> CONFIG_SERIAL_8250_DW=y
> CONFIG_SERIAL_8250_EM=y
> # CONFIG_SERIAL_8250_IOC3 is not set
> CONFIG_SERIAL_8250_RT288X=y
> # CONFIG_SERIAL_8250_OMAP is not set
> # CONFIG_SERIAL_8250_LPC18XX is not set
> # CONFIG_SERIAL_8250_MT6577 is not set
> # CONFIG_SERIAL_8250_UNIPHIER is not set
> # CONFIG_SERIAL_8250_INGENIC is not set
> CONFIG_SERIAL_8250_LPSS=y
> CONFIG_SERIAL_8250_MID=y
> # CONFIG_SERIAL_8250_PERICOM is not set
> # CONFIG_SERIAL_8250_PXA is not set
> CONFIG_SERIAL_8250_TEGRA=y
> CONFIG_SERIAL_8250_BCM7271=y
> CONFIG_SERIAL_OF_PLATFORM=y
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_AMBA_PL010=y
> CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
> # CONFIG_SERIAL_AMBA_PL011 is not set
> CONFIG_SERIAL_EARLYCON_SEMIHOST=y
> # CONFIG_SERIAL_ATMEL is not set
> CONFIG_SERIAL_KGDB_NMI=y
> # CONFIG_SERIAL_MESON is not set
> # CONFIG_SERIAL_CLPS711X is not set
> # CONFIG_SERIAL_SAMSUNG is not set
> # CONFIG_SERIAL_TEGRA is not set
> # CONFIG_SERIAL_TEGRA_TCU is not set
> # CONFIG_SERIAL_PXA is not set
> # CONFIG_SERIAL_IMX is not set
> # CONFIG_SERIAL_IMX_EARLYCON is not set
> # CONFIG_SERIAL_UARTLITE is not set
> # CONFIG_SERIAL_SH_SCI is not set
> # CONFIG_SERIAL_HS_LPC32XX is not set
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_CONSOLE_POLL=y
> # CONFIG_SERIAL_ICOM is not set
> CONFIG_SERIAL_JSM=y
> # CONFIG_SERIAL_MSM is not set
> # CONFIG_SERIAL_VT8500 is not set
> CONFIG_SERIAL_OMAP=y
> CONFIG_SERIAL_OMAP_CONSOLE=y
> CONFIG_SERIAL_SIFIVE=y
> CONFIG_SERIAL_SIFIVE_CONSOLE=y
> # CONFIG_SERIAL_LANTIQ is not set
> # CONFIG_SERIAL_SCCNXP is not set
> CONFIG_SERIAL_SC16IS7XX=y
> # CONFIG_SERIAL_SC16IS7XX_I2C is not set
> # CONFIG_SERIAL_TIMBERDALE is not set
> CONFIG_SERIAL_BCM63XX=y
> CONFIG_SERIAL_BCM63XX_CONSOLE=y
> CONFIG_SERIAL_ALTERA_JTAGUART=y
> # CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> # CONFIG_SERIAL_PCH_UART is not set
> # CONFIG_SERIAL_MXS_AUART is not set
> CONFIG_SERIAL_XILINX_PS_UART=y
> # CONFIG_SERIAL_XILINX_PS_UART_CONSOLE is not set
> # CONFIG_SERIAL_MPS2_UART is not set
> CONFIG_SERIAL_ARC=y
> # CONFIG_SERIAL_ARC_CONSOLE is not set
> CONFIG_SERIAL_ARC_NR_PORTS=1
> # CONFIG_SERIAL_RP2 is not set
> CONFIG_SERIAL_FSL_LPUART=y
> CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
> CONFIG_SERIAL_FSL_LINFLEXUART=y
> CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE=y
> # CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
> # CONFIG_SERIAL_ST_ASC is not set
> CONFIG_SERIAL_SPRD=y
> CONFIG_SERIAL_SPRD_CONSOLE=y
> # CONFIG_SERIAL_STM32 is not set
> # CONFIG_SERIAL_MVEBU_UART is not set
> # CONFIG_SERIAL_OWL is not set
> # CONFIG_SERIAL_RDA is not set
> # CONFIG_SERIAL_MILBEAUT_USIO is not set
> # CONFIG_SERIAL_LITEUART is not set
> CONFIG_SERIAL_SUNPLUS=y
> # CONFIG_SERIAL_SUNPLUS_CONSOLE is not set
> # end of Serial drivers
> 
> CONFIG_SERIAL_MCTRL_GPIO=y
> # CONFIG_SERIAL_NONSTANDARD is not set
> CONFIG_GOLDFISH_TTY=y
> CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
> CONFIG_NOZOMI=y
> CONFIG_NULL_TTY=y
> CONFIG_HVC_DRIVER=y
> # CONFIG_HVC_XEN is not set
> # CONFIG_HVC_DCC is not set
> CONFIG_RPMSG_TTY=y
> CONFIG_SERIAL_DEV_BUS=y
> CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
> CONFIG_TTY_PRINTK=y
> CONFIG_TTY_PRINTK_LEVEL=6
> CONFIG_VIRTIO_CONSOLE=y
> # CONFIG_IPMI_HANDLER is not set
> CONFIG_IPMI_KCS_BMC=y
> CONFIG_ASPEED_KCS_IPMI_BMC=y
> # CONFIG_NPCM7XX_KCS_IPMI_BMC is not set
> CONFIG_IPMI_KCS_BMC_CDEV_IPMI=y
> CONFIG_IPMI_KCS_BMC_SERIO=y
> # CONFIG_ASPEED_BT_IPMI_BMC is not set
> # CONFIG_SSIF_IPMI_BMC is not set
> # CONFIG_IPMB_DEVICE_INTERFACE is not set
> CONFIG_HW_RANDOM=y
> CONFIG_HW_RANDOM_TIMERIOMEM=y
> CONFIG_HW_RANDOM_ATMEL=y
> # CONFIG_HW_RANDOM_BA431 is not set
> CONFIG_HW_RANDOM_BCM2835=y
> # CONFIG_HW_RANDOM_IPROC_RNG200 is not set
> CONFIG_HW_RANDOM_IXP4XX=y
> CONFIG_HW_RANDOM_OMAP=y
> CONFIG_HW_RANDOM_OMAP3_ROM=y
> CONFIG_HW_RANDOM_VIRTIO=y
> CONFIG_HW_RANDOM_IMX_RNGC=y
> CONFIG_HW_RANDOM_NOMADIK=y
> CONFIG_HW_RANDOM_HISI=y
> CONFIG_HW_RANDOM_ST=y
> CONFIG_HW_RANDOM_STM32=y
> CONFIG_HW_RANDOM_MESON=y
> # CONFIG_HW_RANDOM_MTK is not set
> CONFIG_HW_RANDOM_EXYNOS=y
> CONFIG_HW_RANDOM_OPTEE=y
> CONFIG_HW_RANDOM_NPCM=y
> # CONFIG_HW_RANDOM_KEYSTONE is not set
> CONFIG_HW_RANDOM_CCTRNG=y
> CONFIG_HW_RANDOM_XIPHERA=y
> # CONFIG_HW_RANDOM_ARM_SMCCC_TRNG is not set
> # CONFIG_HW_RANDOM_JH7110 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_DEVMEM is not set
> # CONFIG_DEVPORT is not set
> # CONFIG_TCG_TPM is not set
> CONFIG_XILLYBUS_CLASS=y
> CONFIG_XILLYBUS=y
> # CONFIG_XILLYBUS_PCIE is not set
> # CONFIG_XILLYBUS_OF is not set
> # end of Character devices
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_COMPAT=y
> # CONFIG_I2C_CHARDEV is not set
> CONFIG_I2C_MUX=y
> 
> #
> # Multiplexer I2C Chip support
> #
> # CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
> CONFIG_I2C_MUX_GPIO=y
> # CONFIG_I2C_MUX_GPMUX is not set
> CONFIG_I2C_MUX_LTC4306=y
> CONFIG_I2C_MUX_PCA9541=y
> # CONFIG_I2C_MUX_PCA954x is not set
> CONFIG_I2C_MUX_PINCTRL=y
> CONFIG_I2C_MUX_REG=y
> # CONFIG_I2C_DEMUX_PINCTRL is not set
> CONFIG_I2C_MUX_MLXCPLD=y
> # end of Multiplexer I2C Chip support
> 
> CONFIG_I2C_HELPER_AUTO=y
> CONFIG_I2C_SMBUS=y
> CONFIG_I2C_ALGOBIT=y
> CONFIG_I2C_ALGOPCA=y
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # PC SMBus host controller drivers
> #
> CONFIG_I2C_CCGX_UCSI=y
> CONFIG_I2C_ALI1535=y
> # CONFIG_I2C_ALI1563 is not set
> CONFIG_I2C_ALI15X3=y
> # CONFIG_I2C_AMD756 is not set
> CONFIG_I2C_AMD8111=y
> CONFIG_I2C_HIX5HD2=y
> CONFIG_I2C_I801=y
> # CONFIG_I2C_ISCH is not set
> CONFIG_I2C_PIIX4=y
> CONFIG_I2C_NFORCE2=y
> CONFIG_I2C_NVIDIA_GPU=y
> CONFIG_I2C_SIS5595=y
> # CONFIG_I2C_SIS630 is not set
> CONFIG_I2C_SIS96X=y
> # CONFIG_I2C_VIA is not set
> # CONFIG_I2C_VIAPRO is not set
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_ALTERA is not set
> # CONFIG_I2C_ASPEED is not set
> # CONFIG_I2C_AT91 is not set
> # CONFIG_I2C_AXXIA is not set
> # CONFIG_I2C_BCM2835 is not set
> CONFIG_I2C_BCM_IPROC=y
> # CONFIG_I2C_BCM_KONA is not set
> # CONFIG_I2C_BRCMSTB is not set
> CONFIG_I2C_CADENCE=y
> # CONFIG_I2C_CBUS_GPIO is not set
> CONFIG_I2C_DAVINCI=y
> CONFIG_I2C_DESIGNWARE_CORE=y
> CONFIG_I2C_DESIGNWARE_SLAVE=y
> CONFIG_I2C_DESIGNWARE_PLATFORM=y
> # CONFIG_I2C_DESIGNWARE_PCI is not set
> # CONFIG_I2C_DIGICOLOR is not set
> # CONFIG_I2C_EG20T is not set
> CONFIG_I2C_EMEV2=y
> # CONFIG_I2C_EXYNOS5 is not set
> # CONFIG_I2C_GPIO is not set
> # CONFIG_I2C_GXP is not set
> # CONFIG_I2C_HIGHLANDER is not set
> # CONFIG_I2C_HISI is not set
> # CONFIG_I2C_IMG is not set
> # CONFIG_I2C_IMX is not set
> # CONFIG_I2C_IMX_LPI2C is not set
> # CONFIG_I2C_IOP3XX is not set
> # CONFIG_I2C_JZ4780 is not set
> # CONFIG_I2C_LPC2K is not set
> # CONFIG_I2C_LS2X is not set
> # CONFIG_I2C_MESON is not set
> # CONFIG_I2C_MICROCHIP_CORE is not set
> CONFIG_I2C_MT65XX=y
> # CONFIG_I2C_MT7621 is not set
> CONFIG_I2C_MV64XXX=y
> # CONFIG_I2C_MXS is not set
> CONFIG_I2C_NOMADIK=y
> # CONFIG_I2C_NPCM is not set
> CONFIG_I2C_OCORES=y
> CONFIG_I2C_OMAP=y
> CONFIG_I2C_OWL=y
> # CONFIG_I2C_APPLE is not set
> CONFIG_I2C_PCA_PLATFORM=y
> # CONFIG_I2C_PNX is not set
> CONFIG_I2C_PXA=y
> # CONFIG_I2C_PXA_SLAVE is not set
> # CONFIG_I2C_QCOM_CCI is not set
> # CONFIG_I2C_QUP is not set
> CONFIG_I2C_RIIC=y
> # CONFIG_I2C_RK3X is not set
> CONFIG_I2C_RZV2M=y
> CONFIG_I2C_S3C2410=y
> # CONFIG_I2C_SH_MOBILE is not set
> # CONFIG_I2C_SIMTEC is not set
> # CONFIG_I2C_SPRD is not set
> CONFIG_I2C_ST=y
> # CONFIG_I2C_STM32F4 is not set
> # CONFIG_I2C_STM32F7 is not set
> # CONFIG_I2C_SUN6I_P2WI is not set
> # CONFIG_I2C_SYNQUACER is not set
> # CONFIG_I2C_TEGRA is not set
> # CONFIG_I2C_TEGRA_BPMP is not set
> CONFIG_I2C_UNIPHIER=y
> # CONFIG_I2C_UNIPHIER_F is not set
> CONFIG_I2C_VERSATILE=y
> CONFIG_I2C_WMT=y
> # CONFIG_I2C_XILINX is not set
> # CONFIG_I2C_XLP9XX is not set
> CONFIG_I2C_RCAR=y
> 
> #
> # External I2C/SMBus adapter drivers
> #
> # CONFIG_I2C_PCI1XXXX is not set
> CONFIG_I2C_TAOS_EVM=y
> 
> #
> # Other I2C/SMBus bus drivers
> #
> # CONFIG_I2C_MLXCPLD is not set
> CONFIG_I2C_FSI=y
> # CONFIG_I2C_VIRTIO is not set
> # end of I2C Hardware Bus support
> 
> CONFIG_I2C_SLAVE=y
> CONFIG_I2C_SLAVE_EEPROM=y
> CONFIG_I2C_SLAVE_TESTUNIT=y
> CONFIG_I2C_DEBUG_CORE=y
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # end of I2C support
> 
> CONFIG_I3C=y
> CONFIG_CDNS_I3C_MASTER=y
> CONFIG_DW_I3C_MASTER=y
> CONFIG_AST2600_I3C_MASTER=y
> # CONFIG_SVC_I3C_MASTER is not set
> # CONFIG_MIPI_I3C_HCI is not set
> # CONFIG_SPI is not set
> CONFIG_SPMI=y
> CONFIG_SPMI_HISI3670=y
> # CONFIG_SPMI_MSM_PMIC_ARB is not set
> # CONFIG_SPMI_MTK_PMIF is not set
> CONFIG_HSI=y
> CONFIG_HSI_BOARDINFO=y
> 
> #
> # HSI controllers
> #
> CONFIG_OMAP_SSI=y
> 
> #
> # HSI clients
> #
> CONFIG_HSI_CHAR=y
> CONFIG_PPS=y
> CONFIG_PPS_DEBUG=y
> CONFIG_NTP_PPS=y
> 
> #
> # PPS clients support
> #
> # CONFIG_PPS_CLIENT_KTIMER is not set
> # CONFIG_PPS_CLIENT_LDISC is not set
> CONFIG_PPS_CLIENT_GPIO=y
> 
> #
> # PPS generators support
> #
> 
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK_OPTIONAL=y
> 
> #
> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> #
> # end of PTP clock support
> 
> CONFIG_PINCTRL=y
> CONFIG_GENERIC_PINCTRL_GROUPS=y
> CONFIG_PINMUX=y
> CONFIG_GENERIC_PINMUX_FUNCTIONS=y
> CONFIG_PINCONF=y
> CONFIG_GENERIC_PINCONF=y
> # CONFIG_DEBUG_PINCTRL is not set
> # CONFIG_PINCTRL_AMD is not set
> # CONFIG_PINCTRL_AS3722 is not set
> # CONFIG_PINCTRL_AT91PIO4 is not set
> CONFIG_PINCTRL_AXP209=y
> # CONFIG_PINCTRL_BM1880 is not set
> CONFIG_PINCTRL_CY8C95X0=y
> # CONFIG_PINCTRL_DA850_PUPD is not set
> CONFIG_PINCTRL_DA9062=y
> # CONFIG_PINCTRL_EQUILIBRIUM is not set
> # CONFIG_PINCTRL_INGENIC is not set
> # CONFIG_PINCTRL_LOONGSON2 is not set
> # CONFIG_PINCTRL_LPC18XX is not set
> # CONFIG_PINCTRL_MCP23S08 is not set
> # CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
> CONFIG_PINCTRL_OCELOT=y
> # CONFIG_PINCTRL_PALMAS is not set
> # CONFIG_PINCTRL_PISTACHIO is not set
> CONFIG_PINCTRL_ROCKCHIP=y
> CONFIG_PINCTRL_SINGLE=y
> CONFIG_PINCTRL_ST=y
> # CONFIG_PINCTRL_STMFX is not set
> # CONFIG_PINCTRL_SX150X is not set
> CONFIG_PINCTRL_ZYNQ=y
> # CONFIG_PINCTRL_MLXBF3 is not set
> CONFIG_PINCTRL_OWL=y
> # CONFIG_PINCTRL_S500 is not set
> # CONFIG_PINCTRL_S700 is not set
> # CONFIG_PINCTRL_S900 is not set
> # CONFIG_PINCTRL_ASPEED_G4 is not set
> # CONFIG_PINCTRL_ASPEED_G5 is not set
> # CONFIG_PINCTRL_ASPEED_G6 is not set
> # CONFIG_PINCTRL_BCM281XX is not set
> CONFIG_PINCTRL_BCM2835=y
> CONFIG_PINCTRL_BCM4908=y
> # CONFIG_PINCTRL_BCM6318 is not set
> # CONFIG_PINCTRL_BCM6328 is not set
> # CONFIG_PINCTRL_BCM6358 is not set
> # CONFIG_PINCTRL_BCM6362 is not set
> # CONFIG_PINCTRL_BCM6368 is not set
> # CONFIG_PINCTRL_BCM63268 is not set
> # CONFIG_PINCTRL_IPROC_GPIO is not set
> CONFIG_PINCTRL_CYGNUS_MUX=y
> # CONFIG_PINCTRL_NS is not set
> CONFIG_PINCTRL_NSP_GPIO=y
> # CONFIG_PINCTRL_NS2_MUX is not set
> CONFIG_PINCTRL_NSP_MUX=y
> # CONFIG_PINCTRL_AS370 is not set
> # CONFIG_PINCTRL_BERLIN_BG4CT is not set
> CONFIG_PINCTRL_MADERA=y
> CONFIG_PINCTRL_CS47L15=y
> CONFIG_PINCTRL_CS47L35=y
> CONFIG_PINCTRL_CS47L85=y
> CONFIG_PINCTRL_CS47L92=y
> 
> #
> # Intel pinctrl drivers
> #
> # end of Intel pinctrl drivers
> 
> #
> # MediaTek pinctrl drivers
> #
> # CONFIG_EINT_MTK is not set
> # CONFIG_PINCTRL_MT2701 is not set
> # CONFIG_PINCTRL_MT7623 is not set
> # CONFIG_PINCTRL_MT7629 is not set
> # CONFIG_PINCTRL_MT8135 is not set
> # CONFIG_PINCTRL_MT8127 is not set
> # CONFIG_PINCTRL_MT2712 is not set
> # CONFIG_PINCTRL_MT6765 is not set
> # CONFIG_PINCTRL_MT6779 is not set
> # CONFIG_PINCTRL_MT6795 is not set
> # CONFIG_PINCTRL_MT6797 is not set
> # CONFIG_PINCTRL_MT7622 is not set
> # CONFIG_PINCTRL_MT7981 is not set
> # CONFIG_PINCTRL_MT7986 is not set
> # CONFIG_PINCTRL_MT8167 is not set
> # CONFIG_PINCTRL_MT8173 is not set
> # CONFIG_PINCTRL_MT8183 is not set
> # CONFIG_PINCTRL_MT8186 is not set
> # CONFIG_PINCTRL_MT8188 is not set
> # CONFIG_PINCTRL_MT8192 is not set
> # CONFIG_PINCTRL_MT8195 is not set
> # CONFIG_PINCTRL_MT8365 is not set
> # CONFIG_PINCTRL_MT8516 is not set
> # CONFIG_PINCTRL_MT6397 is not set
> # end of MediaTek pinctrl drivers
> 
> CONFIG_PINCTRL_MESON=y
> CONFIG_PINCTRL_MESON8=y
> CONFIG_PINCTRL_MESON8B=y
> CONFIG_PINCTRL_MESON8_PMX=y
> CONFIG_PINCTRL_ABX500=y
> CONFIG_PINCTRL_AB8500=y
> CONFIG_PINCTRL_AB8505=y
> CONFIG_PINCTRL_NOMADIK=y
> CONFIG_PINCTRL_DB8500=y
> # CONFIG_PINCTRL_WPCM450 is not set
> CONFIG_PINCTRL_NPCM7XX=y
> # CONFIG_PINCTRL_PXA25X is not set
> # CONFIG_PINCTRL_PXA27X is not set
> # CONFIG_PINCTRL_MSM is not set
> # CONFIG_PINCTRL_QCOM_SPMI_PMIC is not set
> # CONFIG_PINCTRL_QCOM_SSBI_PMIC is not set
> # CONFIG_PINCTRL_LPASS_LPI is not set
> 
> #
> # Renesas pinctrl drivers
> #
> CONFIG_PINCTRL_RENESAS=y
> CONFIG_PINCTRL_SH_PFC=y
> CONFIG_PINCTRL_SH_PFC_GPIO=y
> CONFIG_PINCTRL_PFC_EMEV2=y
> # CONFIG_PINCTRL_PFC_R8A77995 is not set
> CONFIG_PINCTRL_PFC_R8A7794=y
> # CONFIG_PINCTRL_PFC_R8A77990 is not set
> CONFIG_PINCTRL_PFC_R8A7779=y
> # CONFIG_PINCTRL_PFC_R8A7790 is not set
> # CONFIG_PINCTRL_PFC_R8A77951 is not set
> # CONFIG_PINCTRL_PFC_R8A7778 is not set
> CONFIG_PINCTRL_PFC_R8A7793=y
> # CONFIG_PINCTRL_PFC_R8A7791 is not set
> # CONFIG_PINCTRL_PFC_R8A77965 is not set
> # CONFIG_PINCTRL_PFC_R8A77960 is not set
> # CONFIG_PINCTRL_PFC_R8A77961 is not set
> # CONFIG_PINCTRL_PFC_R8A779F0 is not set
> # CONFIG_PINCTRL_PFC_R8A7792 is not set
> # CONFIG_PINCTRL_PFC_R8A77980 is not set
> # CONFIG_PINCTRL_PFC_R8A77970 is not set
> # CONFIG_PINCTRL_PFC_R8A779A0 is not set
> # CONFIG_PINCTRL_PFC_R8A779G0 is not set
> CONFIG_PINCTRL_PFC_R8A7740=y
> # CONFIG_PINCTRL_PFC_R8A73A4 is not set
> # CONFIG_PINCTRL_RZA1 is not set
> # CONFIG_PINCTRL_RZA2 is not set
> # CONFIG_PINCTRL_RZG2L is not set
> # CONFIG_PINCTRL_PFC_R8A77470 is not set
> # CONFIG_PINCTRL_PFC_R8A7745 is not set
> # CONFIG_PINCTRL_PFC_R8A7742 is not set
> CONFIG_PINCTRL_PFC_R8A7743=y
> CONFIG_PINCTRL_PFC_R8A7744=y
> # CONFIG_PINCTRL_PFC_R8A774C0 is not set
> # CONFIG_PINCTRL_PFC_R8A774E1 is not set
> # CONFIG_PINCTRL_PFC_R8A774A1 is not set
> # CONFIG_PINCTRL_PFC_R8A774B1 is not set
> # CONFIG_PINCTRL_RZN1 is not set
> # CONFIG_PINCTRL_RZV2M is not set
> # CONFIG_PINCTRL_PFC_SH7203 is not set
> # CONFIG_PINCTRL_PFC_SH7264 is not set
> # CONFIG_PINCTRL_PFC_SH7269 is not set
> # CONFIG_PINCTRL_PFC_SH7720 is not set
> # CONFIG_PINCTRL_PFC_SH7722 is not set
> # CONFIG_PINCTRL_PFC_SH7734 is not set
> # CONFIG_PINCTRL_PFC_SH7757 is not set
> # CONFIG_PINCTRL_PFC_SH7785 is not set
> # CONFIG_PINCTRL_PFC_SH7786 is not set
> CONFIG_PINCTRL_PFC_SH73A0=y
> # CONFIG_PINCTRL_PFC_SH7723 is not set
> # CONFIG_PINCTRL_PFC_SH7724 is not set
> # CONFIG_PINCTRL_PFC_SHX3 is not set
> # end of Renesas pinctrl drivers
> 
> CONFIG_PINCTRL_SAMSUNG=y
> CONFIG_PINCTRL_EXYNOS=y
> CONFIG_PINCTRL_EXYNOS_ARM=y
> # CONFIG_PINCTRL_EXYNOS_ARM64 is not set
> # CONFIG_PINCTRL_S3C64XX is not set
> # CONFIG_PINCTRL_SPRD_SC9860 is not set
> # CONFIG_PINCTRL_STARFIVE_JH7100 is not set
> # CONFIG_PINCTRL_STARFIVE_JH7110_SYS is not set
> # CONFIG_PINCTRL_STARFIVE_JH7110_AON is not set
> # CONFIG_PINCTRL_STM32F429 is not set
> # CONFIG_PINCTRL_STM32F469 is not set
> # CONFIG_PINCTRL_STM32F746 is not set
> # CONFIG_PINCTRL_STM32F769 is not set
> # CONFIG_PINCTRL_STM32H743 is not set
> # CONFIG_PINCTRL_STM32MP135 is not set
> # CONFIG_PINCTRL_STM32MP157 is not set
> CONFIG_PINCTRL_SUNXI=y
> CONFIG_PINCTRL_SUN4I_A10=y
> # CONFIG_PINCTRL_SUN5I is not set
> # CONFIG_PINCTRL_SUN6I_A31 is not set
> # CONFIG_PINCTRL_SUN6I_A31_R is not set
> CONFIG_PINCTRL_SUN8I_A23=y
> # CONFIG_PINCTRL_SUN8I_A33 is not set
> # CONFIG_PINCTRL_SUN8I_A83T is not set
> CONFIG_PINCTRL_SUN8I_A83T_R=y
> # CONFIG_PINCTRL_SUN8I_A23_R is not set
> # CONFIG_PINCTRL_SUN8I_H3 is not set
> CONFIG_PINCTRL_SUN8I_H3_R=y
> # CONFIG_PINCTRL_SUN8I_V3S is not set
> # CONFIG_PINCTRL_SUN9I_A80 is not set
> CONFIG_PINCTRL_SUN9I_A80_R=y
> CONFIG_PINCTRL_SUN20I_D1=y
> # CONFIG_PINCTRL_SUN50I_A64 is not set
> CONFIG_PINCTRL_SUN50I_A64_R=y
> # CONFIG_PINCTRL_SUN50I_A100 is not set
> # CONFIG_PINCTRL_SUN50I_A100_R is not set
> # CONFIG_PINCTRL_SUN50I_H5 is not set
> # CONFIG_PINCTRL_SUN50I_H6 is not set
> CONFIG_PINCTRL_SUN50I_H6_R=y
> # CONFIG_PINCTRL_SUN50I_H616 is not set
> CONFIG_PINCTRL_SUN50I_H616_R=y
> # CONFIG_PINCTRL_TI_IODELAY is not set
> # CONFIG_PINCTRL_UNIPHIER is not set
> # CONFIG_PINCTRL_TMPV7700 is not set
> # CONFIG_PINCTRL_WM8850 is not set
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_OF_GPIO=y
> CONFIG_GPIOLIB_IRQCHIP=y
> CONFIG_OF_GPIO_MM_GPIOCHIP=y
> # CONFIG_DEBUG_GPIO is not set
> CONFIG_GPIO_SYSFS=y
> CONFIG_GPIO_CDEV=y
> # CONFIG_GPIO_CDEV_V1 is not set
> CONFIG_GPIO_GENERIC=y
> CONFIG_GPIO_REGMAP=y
> CONFIG_GPIO_MAX730X=y
> CONFIG_GPIO_IDIO_16=y
> 
> #
> # Memory mapped GPIO drivers
> #
> CONFIG_GPIO_74XX_MMIO=y
> CONFIG_GPIO_ALTERA=y
> CONFIG_GPIO_ASPEED=y
> # CONFIG_GPIO_ASPEED_SGPIO is not set
> # CONFIG_GPIO_ATH79 is not set
> # CONFIG_GPIO_RASPBERRYPI_EXP is not set
> CONFIG_GPIO_BCM_KONA=y
> # CONFIG_GPIO_BCM_XGS_IPROC is not set
> # CONFIG_GPIO_BRCMSTB is not set
> # CONFIG_GPIO_CADENCE is not set
> # CONFIG_GPIO_CLPS711X is not set
> CONFIG_GPIO_DAVINCI=y
> CONFIG_GPIO_DWAPB=y
> # CONFIG_GPIO_EIC_SPRD is not set
> CONFIG_GPIO_EM=y
> # CONFIG_GPIO_EN7523 is not set
> # CONFIG_GPIO_EXAR is not set
> CONFIG_GPIO_FTGPIO010=y
> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> # CONFIG_GPIO_GRGPIO is not set
> # CONFIG_GPIO_HISI is not set
> CONFIG_GPIO_HLWD=y
> CONFIG_GPIO_LOGICVC=y
> # CONFIG_GPIO_LOONGSON_64BIT is not set
> # CONFIG_GPIO_LPC18XX is not set
> # CONFIG_GPIO_LPC32XX is not set
> CONFIG_GPIO_MB86S7X=y
> # CONFIG_GPIO_MPC8XXX is not set
> # CONFIG_GPIO_MT7621 is not set
> # CONFIG_GPIO_MXC is not set
> # CONFIG_GPIO_MXS is not set
> # CONFIG_GPIO_OMAP is not set
> CONFIG_GPIO_PL061=y
> CONFIG_GPIO_PXA=y
> CONFIG_GPIO_RCAR=y
> # CONFIG_GPIO_RDA is not set
> CONFIG_GPIO_ROCKCHIP=y
> # CONFIG_GPIO_SAMA5D2_PIOBU is not set
> CONFIG_GPIO_SIFIVE=y
> # CONFIG_GPIO_SNPS_CREG is not set
> # CONFIG_GPIO_SPEAR_SPICS is not set
> # CONFIG_GPIO_SPRD is not set
> # CONFIG_GPIO_STP_XWAY is not set
> # CONFIG_GPIO_SYSCON is not set
> # CONFIG_GPIO_TEGRA is not set
> # CONFIG_GPIO_TEGRA186 is not set
> # CONFIG_GPIO_TS4800 is not set
> # CONFIG_GPIO_UNIPHIER is not set
> # CONFIG_GPIO_VISCONTI is not set
> # CONFIG_GPIO_VX855 is not set
> # CONFIG_GPIO_XGENE_SB is not set
> CONFIG_GPIO_XILINX=y
> # CONFIG_GPIO_XLP is not set
> CONFIG_GPIO_ZEVIO=y
> CONFIG_GPIO_ZYNQ=y
> CONFIG_GPIO_AMD_FCH=y
> # CONFIG_GPIO_IDT3243X is not set
> # end of Memory mapped GPIO drivers
> 
> #
> # I2C GPIO expanders
> #
> # CONFIG_GPIO_ADNP is not set
> CONFIG_GPIO_FXL6408=y
> CONFIG_GPIO_GW_PLD=y
> CONFIG_GPIO_MAX7300=y
> CONFIG_GPIO_MAX732X=y
> CONFIG_GPIO_MAX732X_IRQ=y
> CONFIG_GPIO_PCA953X=y
> # CONFIG_GPIO_PCA953X_IRQ is not set
> CONFIG_GPIO_PCA9570=y
> # CONFIG_GPIO_PCF857X is not set
> # CONFIG_GPIO_TPIC2810 is not set
> # CONFIG_GPIO_TS4900 is not set
> # end of I2C GPIO expanders
> 
> #
> # MFD GPIO expanders
> #
> # CONFIG_GPIO_ADP5520 is not set
> CONFIG_GPIO_ARIZONA=y
> CONFIG_GPIO_BD71815=y
> CONFIG_GPIO_BD71828=y
> # CONFIG_GPIO_BD9571MWV is not set
> CONFIG_GPIO_DA9055=y
> CONFIG_HTC_EGPIO=y
> # CONFIG_GPIO_ELKHARTLAKE is not set
> CONFIG_GPIO_LP87565=y
> CONFIG_GPIO_MADERA=y
> CONFIG_GPIO_MAX77650=y
> # CONFIG_GPIO_PALMAS is not set
> # CONFIG_GPIO_PMIC_EIC_SPRD is not set
> CONFIG_GPIO_RC5T583=y
> # CONFIG_GPIO_SL28CPLD is not set
> # CONFIG_GPIO_STMPE is not set
> CONFIG_GPIO_TC3589X=y
> CONFIG_GPIO_TPS65086=y
> CONFIG_GPIO_TPS65218=y
> # CONFIG_GPIO_TPS6586X is not set
> CONFIG_GPIO_TWL4030=y
> CONFIG_GPIO_TWL6040=y
> # CONFIG_GPIO_WM831X is not set
> CONFIG_GPIO_WM8350=y
> # CONFIG_GPIO_WM8994 is not set
> # end of MFD GPIO expanders
> 
> #
> # PCI GPIO expanders
> #
> CONFIG_GPIO_BT8XX=y
> # CONFIG_GPIO_ML_IOH is not set
> # CONFIG_GPIO_PCH is not set
> CONFIG_GPIO_PCI_IDIO_16=y
> CONFIG_GPIO_PCIE_IDIO_24=y
> CONFIG_GPIO_RDC321X=y
> # end of PCI GPIO expanders
> 
> #
> # Virtual GPIO drivers
> #
> CONFIG_GPIO_AGGREGATOR=y
> CONFIG_GPIO_LATCH=y
> # CONFIG_GPIO_MOCKUP is not set
> CONFIG_GPIO_VIRTIO=y
> CONFIG_GPIO_SIM=y
> # end of Virtual GPIO drivers
> 
> CONFIG_W1=y
> 
> #
> # 1-wire Bus Masters
> #
> # CONFIG_W1_MASTER_MATROX is not set
> CONFIG_W1_MASTER_DS2482=y
> # CONFIG_W1_MASTER_MXC is not set
> # CONFIG_W1_MASTER_GPIO is not set
> CONFIG_HDQ_MASTER_OMAP=y
> CONFIG_W1_MASTER_SGI=y
> # end of 1-wire Bus Masters
> 
> #
> # 1-wire Slaves
> #
> # CONFIG_W1_SLAVE_THERM is not set
> CONFIG_W1_SLAVE_SMEM=y
> # CONFIG_W1_SLAVE_DS2405 is not set
> CONFIG_W1_SLAVE_DS2408=y
> CONFIG_W1_SLAVE_DS2408_READBACK=y
> # CONFIG_W1_SLAVE_DS2413 is not set
> CONFIG_W1_SLAVE_DS2406=y
> CONFIG_W1_SLAVE_DS2423=y
> CONFIG_W1_SLAVE_DS2805=y
> # CONFIG_W1_SLAVE_DS2430 is not set
> CONFIG_W1_SLAVE_DS2431=y
> # CONFIG_W1_SLAVE_DS2433 is not set
> CONFIG_W1_SLAVE_DS2438=y
> # CONFIG_W1_SLAVE_DS250X is not set
> CONFIG_W1_SLAVE_DS2780=y
> CONFIG_W1_SLAVE_DS2781=y
> CONFIG_W1_SLAVE_DS28E04=y
> # CONFIG_W1_SLAVE_DS28E17 is not set
> # end of 1-wire Slaves
> 
> CONFIG_POWER_RESET=y
> CONFIG_POWER_RESET_AS3722=y
> CONFIG_POWER_RESET_ATC260X=y
> CONFIG_POWER_RESET_BRCMKONA=y
> CONFIG_POWER_RESET_BRCMSTB=y
> # CONFIG_POWER_RESET_GEMINI_POWEROFF is not set
> # CONFIG_POWER_RESET_GPIO is not set
> # CONFIG_POWER_RESET_GPIO_RESTART is not set
> CONFIG_POWER_RESET_HISI=y
> # CONFIG_POWER_RESET_OCELOT_RESET is not set
> # CONFIG_POWER_RESET_ODROID_GO_ULTRA_POWEROFF is not set
> # CONFIG_POWER_RESET_PIIX4_POWEROFF is not set
> # CONFIG_POWER_RESET_LTC2952 is not set
> CONFIG_POWER_RESET_MT6323=y
> # CONFIG_POWER_RESET_REGULATOR is not set
> CONFIG_POWER_RESET_RESTART=y
> # CONFIG_POWER_RESET_ST is not set
> # CONFIG_POWER_RESET_TPS65086 is not set
> CONFIG_POWER_RESET_VERSATILE=y
> CONFIG_POWER_RESET_VEXPRESS=y
> # CONFIG_POWER_RESET_KEYSTONE is not set
> CONFIG_POWER_RESET_SYSCON=y
> CONFIG_POWER_RESET_SYSCON_POWEROFF=y
> CONFIG_POWER_RESET_RMOBILE=y
> CONFIG_REBOOT_MODE=y
> # CONFIG_SYSCON_REBOOT_MODE is not set
> # CONFIG_POWER_RESET_SC27XX is not set
> CONFIG_NVMEM_REBOOT_MODE=y
> CONFIG_POWER_SUPPLY=y
> CONFIG_POWER_SUPPLY_DEBUG=y
> # CONFIG_POWER_SUPPLY_HWMON is not set
> CONFIG_APM_POWER=y
> # CONFIG_GENERIC_ADC_BATTERY is not set
> # CONFIG_IP5XXX_POWER is not set
> CONFIG_MAX8925_POWER=y
> # CONFIG_WM831X_BACKUP is not set
> CONFIG_WM831X_POWER=y
> CONFIG_WM8350_POWER=y
> # CONFIG_TEST_POWER is not set
> CONFIG_CHARGER_ADP5061=y
> # CONFIG_BATTERY_ACT8945A is not set
> # CONFIG_BATTERY_CW2015 is not set
> # CONFIG_BATTERY_DS2760 is not set
> CONFIG_BATTERY_DS2780=y
> CONFIG_BATTERY_DS2781=y
> CONFIG_BATTERY_DS2782=y
> # CONFIG_BATTERY_LEGO_EV3 is not set
> CONFIG_BATTERY_SAMSUNG_SDI=y
> CONFIG_BATTERY_SBS=y
> CONFIG_CHARGER_SBS=y
> CONFIG_MANAGER_SBS=y
> # CONFIG_BATTERY_BQ27XXX is not set
> CONFIG_BATTERY_DA9030=y
> # CONFIG_CHARGER_DA9150 is not set
> CONFIG_BATTERY_DA9150=y
> CONFIG_AXP20X_POWER=y
> CONFIG_BATTERY_MAX17040=y
> CONFIG_BATTERY_MAX17042=y
> CONFIG_BATTERY_MAX1721X=y
> CONFIG_BATTERY_TWL4030_MADC=y
> # CONFIG_CHARGER_PCF50633 is not set
> # CONFIG_BATTERY_RX51 is not set
> CONFIG_CHARGER_MAX8903=y
> # CONFIG_CHARGER_TWL4030 is not set
> # CONFIG_CHARGER_LP8727 is not set
> CONFIG_CHARGER_GPIO=y
> CONFIG_CHARGER_MANAGER=y
> CONFIG_CHARGER_LT3651=y
> # CONFIG_CHARGER_LTC4162L is not set
> # CONFIG_CHARGER_DETECTOR_MAX14656 is not set
> # CONFIG_CHARGER_MAX77650 is not set
> CONFIG_CHARGER_MAX77976=y
> CONFIG_CHARGER_MAX8997=y
> CONFIG_CHARGER_MAX8998=y
> CONFIG_CHARGER_MP2629=y
> CONFIG_CHARGER_MT6360=y
> # CONFIG_CHARGER_QCOM_SMBB is not set
> CONFIG_CHARGER_BQ2415X=y
> # CONFIG_CHARGER_BQ24190 is not set
> CONFIG_CHARGER_BQ24257=y
> CONFIG_CHARGER_BQ24735=y
> CONFIG_CHARGER_BQ2515X=y
> CONFIG_CHARGER_BQ25890=y
> CONFIG_CHARGER_BQ25980=y
> # CONFIG_CHARGER_BQ256XX is not set
> # CONFIG_CHARGER_SMB347 is not set
> # CONFIG_CHARGER_TPS65217 is not set
> CONFIG_BATTERY_GAUGE_LTC2941=y
> CONFIG_BATTERY_GOLDFISH=y
> # CONFIG_BATTERY_RT5033 is not set
> CONFIG_CHARGER_RT9455=y
> CONFIG_CHARGER_RT9467=y
> CONFIG_CHARGER_RT9471=y
> # CONFIG_CHARGER_SC2731 is not set
> # CONFIG_FUEL_GAUGE_SC27XX is not set
> CONFIG_CHARGER_UCS1002=y
> # CONFIG_CHARGER_BD99954 is not set
> # CONFIG_BATTERY_UG3105 is not set
> CONFIG_HWMON=y
> CONFIG_HWMON_VID=y
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Native drivers
> #
> CONFIG_SENSORS_SMPRO=y
> CONFIG_SENSORS_AD7414=y
> # CONFIG_SENSORS_AD7418 is not set
> CONFIG_SENSORS_ADM1025=y
> CONFIG_SENSORS_ADM1026=y
> # CONFIG_SENSORS_ADM1029 is not set
> # CONFIG_SENSORS_ADM1031 is not set
> # CONFIG_SENSORS_ADM1177 is not set
> CONFIG_SENSORS_ADM9240=y
> CONFIG_SENSORS_ADT7X10=y
> CONFIG_SENSORS_ADT7410=y
> CONFIG_SENSORS_ADT7411=y
> CONFIG_SENSORS_ADT7462=y
> CONFIG_SENSORS_ADT7470=y
> CONFIG_SENSORS_ADT7475=y
> CONFIG_SENSORS_AHT10=y
> CONFIG_SENSORS_AS370=y
> # CONFIG_SENSORS_ASC7621 is not set
> CONFIG_SENSORS_AXI_FAN_CONTROL=y
> CONFIG_SENSORS_ARM_SCMI=y
> CONFIG_SENSORS_ARM_SCPI=y
> # CONFIG_SENSORS_ASB100 is not set
> CONFIG_SENSORS_ASPEED=y
> CONFIG_SENSORS_ATXP1=y
> # CONFIG_SENSORS_BT1_PVT is not set
> # CONFIG_SENSORS_DS620 is not set
> # CONFIG_SENSORS_DS1621 is not set
> CONFIG_SENSORS_DA9055=y
> CONFIG_SENSORS_I5K_AMB=y
> # CONFIG_SENSORS_SPARX5 is not set
> # CONFIG_SENSORS_F71805F is not set
> CONFIG_SENSORS_F71882FG=y
> CONFIG_SENSORS_F75375S=y
> # CONFIG_SENSORS_GSC is not set
> CONFIG_SENSORS_MC13783_ADC=y
> # CONFIG_SENSORS_FSCHMD is not set
> CONFIG_SENSORS_FTSTEUTATES=y
> CONFIG_SENSORS_GL518SM=y
> # CONFIG_SENSORS_GL520SM is not set
> # CONFIG_SENSORS_G760A is not set
> CONFIG_SENSORS_G762=y
> # CONFIG_SENSORS_GPIO_FAN is not set
> # CONFIG_SENSORS_GXP_FAN_CTRL is not set
> CONFIG_SENSORS_HIH6130=y
> CONFIG_SENSORS_IIO_HWMON=y
> CONFIG_SENSORS_IT87=y
> CONFIG_SENSORS_JC42=y
> CONFIG_SENSORS_POWR1220=y
> # CONFIG_SENSORS_LAN966X is not set
> # CONFIG_SENSORS_LINEAGE is not set
> CONFIG_SENSORS_LTC2945=y
> # CONFIG_SENSORS_LTC2947_I2C is not set
> CONFIG_SENSORS_LTC2990=y
> CONFIG_SENSORS_LTC2992=y
> CONFIG_SENSORS_LTC4151=y
> # CONFIG_SENSORS_LTC4215 is not set
> # CONFIG_SENSORS_LTC4222 is not set
> # CONFIG_SENSORS_LTC4245 is not set
> CONFIG_SENSORS_LTC4260=y
> # CONFIG_SENSORS_LTC4261 is not set
> CONFIG_SENSORS_MAX127=y
> # CONFIG_SENSORS_MAX16065 is not set
> CONFIG_SENSORS_MAX1619=y
> CONFIG_SENSORS_MAX1668=y
> CONFIG_SENSORS_MAX197=y
> CONFIG_SENSORS_MAX31730=y
> # CONFIG_SENSORS_MAX31760 is not set
> CONFIG_SENSORS_MAX6620=y
> CONFIG_SENSORS_MAX6621=y
> CONFIG_SENSORS_MAX6639=y
> CONFIG_SENSORS_MAX6650=y
> CONFIG_SENSORS_MAX6697=y
> CONFIG_SENSORS_MAX31790=y
> CONFIG_SENSORS_MC34VR500=y
> CONFIG_SENSORS_MCP3021=y
> # CONFIG_SENSORS_MLXREG_FAN is not set
> CONFIG_SENSORS_TC654=y
> CONFIG_SENSORS_TPS23861=y
> CONFIG_SENSORS_MENF21BMC_HWMON=y
> # CONFIG_SENSORS_MR75203 is not set
> # CONFIG_SENSORS_LM63 is not set
> CONFIG_SENSORS_LM73=y
> # CONFIG_SENSORS_LM75 is not set
> CONFIG_SENSORS_LM77=y
> # CONFIG_SENSORS_LM78 is not set
> CONFIG_SENSORS_LM80=y
> CONFIG_SENSORS_LM83=y
> CONFIG_SENSORS_LM85=y
> # CONFIG_SENSORS_LM87 is not set
> CONFIG_SENSORS_LM90=y
> CONFIG_SENSORS_LM92=y
> CONFIG_SENSORS_LM93=y
> CONFIG_SENSORS_LM95234=y
> CONFIG_SENSORS_LM95241=y
> CONFIG_SENSORS_LM95245=y
> # CONFIG_SENSORS_PC87360 is not set
> # CONFIG_SENSORS_PC87427 is not set
> CONFIG_SENSORS_NTC_THERMISTOR=y
> # CONFIG_SENSORS_NCT6683 is not set
> CONFIG_SENSORS_NCT6775_CORE=y
> CONFIG_SENSORS_NCT6775_I2C=y
> CONFIG_SENSORS_NCT7802=y
> CONFIG_SENSORS_NCT7904=y
> # CONFIG_SENSORS_NPCM7XX is not set
> # CONFIG_SENSORS_NSA320 is not set
> # CONFIG_SENSORS_OCC_P8_I2C is not set
> CONFIG_SENSORS_PCF8591=y
> CONFIG_SENSORS_PECI_CPUTEMP=y
> CONFIG_SENSORS_PECI_DIMMTEMP=y
> CONFIG_SENSORS_PECI=y
> CONFIG_PMBUS=y
> CONFIG_SENSORS_PMBUS=y
> CONFIG_SENSORS_ACBEL_FSG032=y
> # CONFIG_SENSORS_ADM1266 is not set
> # CONFIG_SENSORS_ADM1275 is not set
> CONFIG_SENSORS_BEL_PFE=y
> # CONFIG_SENSORS_BPA_RS600 is not set
> CONFIG_SENSORS_DELTA_AHE50DC_FAN=y
> CONFIG_SENSORS_FSP_3Y=y
> # CONFIG_SENSORS_IBM_CFFPS is not set
> CONFIG_SENSORS_DPS920AB=y
> # CONFIG_SENSORS_INSPUR_IPSPS is not set
> # CONFIG_SENSORS_IR35221 is not set
> CONFIG_SENSORS_IR36021=y
> CONFIG_SENSORS_IR38064=y
> # CONFIG_SENSORS_IR38064_REGULATOR is not set
> CONFIG_SENSORS_IRPS5401=y
> CONFIG_SENSORS_ISL68137=y
> CONFIG_SENSORS_LM25066=y
> CONFIG_SENSORS_LM25066_REGULATOR=y
> # CONFIG_SENSORS_LT7182S is not set
> # CONFIG_SENSORS_LTC2978 is not set
> CONFIG_SENSORS_LTC3815=y
> CONFIG_SENSORS_MAX15301=y
> CONFIG_SENSORS_MAX16064=y
> CONFIG_SENSORS_MAX16601=y
> CONFIG_SENSORS_MAX20730=y
> CONFIG_SENSORS_MAX20751=y
> CONFIG_SENSORS_MAX31785=y
> CONFIG_SENSORS_MAX34440=y
> # CONFIG_SENSORS_MAX8688 is not set
> CONFIG_SENSORS_MP2888=y
> CONFIG_SENSORS_MP2975=y
> # CONFIG_SENSORS_MP5023 is not set
> # CONFIG_SENSORS_MPQ7932 is not set
> # CONFIG_SENSORS_PIM4328 is not set
> CONFIG_SENSORS_PLI1209BC=y
> CONFIG_SENSORS_PLI1209BC_REGULATOR=y
> # CONFIG_SENSORS_PM6764TR is not set
> # CONFIG_SENSORS_PXE1610 is not set
> # CONFIG_SENSORS_Q54SJ108A2 is not set
> CONFIG_SENSORS_STPDDC60=y
> # CONFIG_SENSORS_TDA38640 is not set
> CONFIG_SENSORS_TPS40422=y
> CONFIG_SENSORS_TPS53679=y
> # CONFIG_SENSORS_TPS546D24 is not set
> # CONFIG_SENSORS_UCD9000 is not set
> CONFIG_SENSORS_UCD9200=y
> CONFIG_SENSORS_XDPE152=y
> CONFIG_SENSORS_XDPE122=y
> CONFIG_SENSORS_XDPE122_REGULATOR=y
> # CONFIG_SENSORS_ZL6100 is not set
> # CONFIG_SENSORS_PWM_FAN is not set
> # CONFIG_SENSORS_RASPBERRYPI_HWMON is not set
> # CONFIG_SENSORS_SL28CPLD is not set
> CONFIG_SENSORS_SBTSI=y
> # CONFIG_SENSORS_SBRMI is not set
> CONFIG_SENSORS_SHT15=y
> # CONFIG_SENSORS_SHT21 is not set
> # CONFIG_SENSORS_SHT3x is not set
> CONFIG_SENSORS_SHT4x=y
> CONFIG_SENSORS_SHTC1=y
> CONFIG_SENSORS_SIS5595=y
> CONFIG_SENSORS_SY7636A=y
> # CONFIG_SENSORS_DME1737 is not set
> CONFIG_SENSORS_EMC1403=y
> CONFIG_SENSORS_EMC2103=y
> CONFIG_SENSORS_EMC2305=y
> CONFIG_SENSORS_EMC6W201=y
> CONFIG_SENSORS_SMSC47M1=y
> # CONFIG_SENSORS_SMSC47M192 is not set
> CONFIG_SENSORS_SMSC47B397=y
> CONFIG_SENSORS_SCH56XX_COMMON=y
> CONFIG_SENSORS_SCH5627=y
> CONFIG_SENSORS_SCH5636=y
> CONFIG_SENSORS_STTS751=y
> # CONFIG_SENSORS_SFCTEMP is not set
> CONFIG_SENSORS_SMM665=y
> # CONFIG_SENSORS_ADC128D818 is not set
> # CONFIG_SENSORS_ADS7828 is not set
> CONFIG_SENSORS_AMC6821=y
> # CONFIG_SENSORS_INA209 is not set
> # CONFIG_SENSORS_INA2XX is not set
> # CONFIG_SENSORS_INA238 is not set
> # CONFIG_SENSORS_INA3221 is not set
> CONFIG_SENSORS_TC74=y
> CONFIG_SENSORS_THMC50=y
> CONFIG_SENSORS_TMP102=y
> # CONFIG_SENSORS_TMP103 is not set
> CONFIG_SENSORS_TMP108=y
> # CONFIG_SENSORS_TMP401 is not set
> CONFIG_SENSORS_TMP421=y
> CONFIG_SENSORS_TMP464=y
> CONFIG_SENSORS_TMP513=y
> CONFIG_SENSORS_VEXPRESS=y
> CONFIG_SENSORS_VIA686A=y
> # CONFIG_SENSORS_VT1211 is not set
> CONFIG_SENSORS_VT8231=y
> # CONFIG_SENSORS_W83773G is not set
> # CONFIG_SENSORS_W83781D is not set
> # CONFIG_SENSORS_W83791D is not set
> CONFIG_SENSORS_W83792D=y
> CONFIG_SENSORS_W83793=y
> # CONFIG_SENSORS_W83795 is not set
> # CONFIG_SENSORS_W83L785TS is not set
> CONFIG_SENSORS_W83L786NG=y
> CONFIG_SENSORS_W83627HF=y
> CONFIG_SENSORS_W83627EHF=y
> # CONFIG_SENSORS_WM831X is not set
> CONFIG_SENSORS_WM8350=y
> # CONFIG_THERMAL is not set
> CONFIG_WATCHDOG=y
> CONFIG_WATCHDOG_CORE=y
> CONFIG_WATCHDOG_NOWAYOUT=y
> CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
> CONFIG_WATCHDOG_OPEN_TIMEOUT=0
> # CONFIG_WATCHDOG_SYSFS is not set
> # CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set
> 
> #
> # Watchdog Pretimeout Governors
> #
> CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
> CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=y
> # CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP is not set
> CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
> CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y
> 
> #
> # Watchdog Device Drivers
> #
> CONFIG_SOFT_WATCHDOG=y
> # CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
> CONFIG_BD957XMUF_WATCHDOG=y
> # CONFIG_DA9052_WATCHDOG is not set
> CONFIG_DA9055_WATCHDOG=y
> CONFIG_DA9063_WATCHDOG=y
> # CONFIG_DA9062_WATCHDOG is not set
> CONFIG_GPIO_WATCHDOG=y
> CONFIG_GPIO_WATCHDOG_ARCH_INITCALL=y
> CONFIG_MENF21BMC_WATCHDOG=y
> CONFIG_WM831X_WATCHDOG=y
> # CONFIG_WM8350_WATCHDOG is not set
> CONFIG_XILINX_WATCHDOG=y
> CONFIG_ZIIRAVE_WATCHDOG=y
> CONFIG_RAVE_SP_WATCHDOG=y
> CONFIG_MLX_WDT=y
> # CONFIG_SL28CPLD_WATCHDOG is not set
> CONFIG_ARM_SP805_WATCHDOG=y
> # CONFIG_ARMADA_37XX_WATCHDOG is not set
> # CONFIG_ASM9260_WATCHDOG is not set
> # CONFIG_AT91RM9200_WATCHDOG is not set
> # CONFIG_AT91SAM9X_WATCHDOG is not set
> # CONFIG_SAMA5D4_WATCHDOG is not set
> CONFIG_CADENCE_WATCHDOG=y
> # CONFIG_977_WATCHDOG is not set
> # CONFIG_FTWDT010_WATCHDOG is not set
> # CONFIG_S3C2410_WATCHDOG is not set
> CONFIG_DW_WATCHDOG=y
> # CONFIG_EP93XX_WATCHDOG is not set
> CONFIG_OMAP_WATCHDOG=y
> # CONFIG_PNX4008_WATCHDOG is not set
> CONFIG_DAVINCI_WATCHDOG=y
> # CONFIG_K3_RTI_WATCHDOG is not set
> # CONFIG_ORION_WATCHDOG is not set
> CONFIG_RN5T618_WATCHDOG=y
> # CONFIG_SUNXI_WATCHDOG is not set
> CONFIG_NPCM7XX_WATCHDOG=y
> # CONFIG_TWL4030_WATCHDOG is not set
> # CONFIG_STMP3XXX_RTC_WATCHDOG is not set
> # CONFIG_TS4800_WATCHDOG is not set
> # CONFIG_TS72XX_WATCHDOG is not set
> CONFIG_MAX63XX_WATCHDOG=y
> # CONFIG_MAX77620_WATCHDOG is not set
> # CONFIG_IMX2_WDT is not set
> # CONFIG_IMX7ULP_WDT is not set
> CONFIG_DB500_WATCHDOG=y
> # CONFIG_RETU_WATCHDOG is not set
> # CONFIG_MOXART_WDT is not set
> CONFIG_ST_LPC_WATCHDOG=y
> # CONFIG_TEGRA_WATCHDOG is not set
> # CONFIG_QCOM_WDT is not set
> # CONFIG_MESON_GXBB_WATCHDOG is not set
> # CONFIG_MESON_WATCHDOG is not set
> CONFIG_MEDIATEK_WATCHDOG=y
> # CONFIG_DIGICOLOR_WATCHDOG is not set
> CONFIG_ARM_SMC_WATCHDOG=y
> # CONFIG_LPC18XX_WATCHDOG is not set
> # CONFIG_RENESAS_WDT is not set
> # CONFIG_RENESAS_RZAWDT is not set
> CONFIG_RENESAS_RZN1WDT=y
> CONFIG_RENESAS_RZG2LWDT=y
> CONFIG_ASPEED_WATCHDOG=y
> CONFIG_UNIPHIER_WATCHDOG=y
> # CONFIG_RTD119X_WATCHDOG is not set
> # CONFIG_REALTEK_OTTO_WDT is not set
> # CONFIG_SPRD_WATCHDOG is not set
> # CONFIG_VISCONTI_WATCHDOG is not set
> # CONFIG_MSC313E_WATCHDOG is not set
> # CONFIG_APPLE_WATCHDOG is not set
> # CONFIG_SUNPLUS_WATCHDOG is not set
> CONFIG_ALIM7101_WDT=y
> # CONFIG_SC520_WDT is not set
> # CONFIG_I6300ESB_WDT is not set
> # CONFIG_RDC321X_WDT is not set
> # CONFIG_ATH79_WDT is not set
> CONFIG_BCM47XX_WDT=y
> # CONFIG_BCM2835_WDT is not set
> # CONFIG_BCM_KONA_WDT is not set
> # CONFIG_BCM7038_WDT is not set
> # CONFIG_IMGPDC_WDT is not set
> # CONFIG_MT7621_WDT is not set
> # CONFIG_MPC5200_WDT is not set
> CONFIG_MEN_A21_WDT=y
> # CONFIG_STARFIVE_WATCHDOG is not set
> CONFIG_XEN_WDT=y
> # CONFIG_UML_WATCHDOG is not set
> 
> #
> # PCI-based Watchdog Cards
> #
> CONFIG_PCIPCWATCHDOG=y
> CONFIG_WDTPCI=y
> CONFIG_SSB_POSSIBLE=y
> CONFIG_SSB=y
> CONFIG_SSB_SPROM=y
> CONFIG_SSB_PCIHOST_POSSIBLE=y
> CONFIG_SSB_PCIHOST=y
> CONFIG_SSB_HOST_SOC=y
> CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
> # CONFIG_SSB_DRIVER_PCICORE is not set
> # CONFIG_SSB_DRIVER_GPIO is not set
> CONFIG_BCMA_POSSIBLE=y
> CONFIG_BCMA=y
> CONFIG_BCMA_HOST_PCI_POSSIBLE=y
> # CONFIG_BCMA_HOST_PCI is not set
> # CONFIG_BCMA_HOST_SOC is not set
> # CONFIG_BCMA_DRIVER_PCI is not set
> # CONFIG_BCMA_DRIVER_MIPS is not set
> # CONFIG_BCMA_DRIVER_GMAC_CMN is not set
> CONFIG_BCMA_DRIVER_GPIO=y
> CONFIG_BCMA_DEBUG=y
> 
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=y
> CONFIG_MFD_ACT8945A=y
> CONFIG_MFD_SUN4I_GPADC=y
> # CONFIG_MFD_AS3711 is not set
> CONFIG_MFD_SMPRO=y
> CONFIG_MFD_AS3722=y
> CONFIG_PMIC_ADP5520=y
> # CONFIG_MFD_AAT2870_CORE is not set
> # CONFIG_MFD_AT91_USART is not set
> CONFIG_MFD_ATMEL_FLEXCOM=y
> # CONFIG_MFD_ATMEL_HLCDC is not set
> # CONFIG_MFD_BCM590XX is not set
> CONFIG_MFD_BD9571MWV=y
> # CONFIG_MFD_AC100 is not set
> CONFIG_MFD_AXP20X=y
> CONFIG_MFD_AXP20X_I2C=y
> # CONFIG_MFD_AXP20X_RSB is not set
> CONFIG_MFD_MADERA=y
> # CONFIG_MFD_MADERA_I2C is not set
> CONFIG_MFD_MAX597X=y
> CONFIG_MFD_CS47L15=y
> CONFIG_MFD_CS47L35=y
> CONFIG_MFD_CS47L85=y
> # CONFIG_MFD_CS47L90 is not set
> CONFIG_MFD_CS47L92=y
> CONFIG_PMIC_DA903X=y
> # CONFIG_MFD_DA9052_I2C is not set
> CONFIG_MFD_DA9055=y
> CONFIG_MFD_DA9062=y
> CONFIG_MFD_DA9063=y
> CONFIG_MFD_DA9150=y
> # CONFIG_MFD_ENE_KB3930 is not set
> # CONFIG_MFD_EXYNOS_LPASS is not set
> CONFIG_MFD_GATEWORKS_GSC=y
> CONFIG_MFD_MC13XXX=y
> CONFIG_MFD_MC13XXX_I2C=y
> CONFIG_MFD_MP2629=y
> # CONFIG_MFD_MXS_LRADC is not set
> # CONFIG_MFD_MX25_TSADC is not set
> # CONFIG_MFD_HI6421_PMIC is not set
> CONFIG_MFD_HI6421_SPMI=y
> CONFIG_MFD_HI655X_PMIC=y
> # CONFIG_LPC_ICH is not set
> CONFIG_LPC_SCH=y
> # CONFIG_INTEL_SOC_PMIC is not set
> CONFIG_MFD_IQS62X=y
> # CONFIG_MFD_JANZ_CMODIO is not set
> # CONFIG_MFD_KEMPLD is not set
> CONFIG_MFD_88PM800=y
> # CONFIG_MFD_88PM805 is not set
> # CONFIG_MFD_88PM860X is not set
> # CONFIG_MFD_MAX14577 is not set
> # CONFIG_MFD_MAX77620 is not set
> CONFIG_MFD_MAX77650=y
> CONFIG_MFD_MAX77686=y
> # CONFIG_MFD_MAX77693 is not set
> # CONFIG_MFD_MAX77714 is not set
> # CONFIG_MFD_MAX77843 is not set
> CONFIG_MFD_MAX8907=y
> CONFIG_MFD_MAX8925=y
> CONFIG_MFD_MAX8997=y
> CONFIG_MFD_MAX8998=y
> CONFIG_MFD_MT6360=y
> # CONFIG_MFD_MT6370 is not set
> CONFIG_MFD_MT6397=y
> CONFIG_MFD_MENF21BMC=y
> # CONFIG_MFD_NTXEC is not set
> CONFIG_MFD_RETU=y
> CONFIG_MFD_PCF50633=y
> # CONFIG_PCF50633_ADC is not set
> CONFIG_PCF50633_GPIO=y
> # CONFIG_MFD_PM8XXX is not set
> # CONFIG_MFD_SPMI_PMIC is not set
> CONFIG_MFD_SY7636A=y
> CONFIG_MFD_RDC321X=y
> CONFIG_MFD_RT4831=y
> CONFIG_MFD_RT5033=y
> CONFIG_MFD_RT5120=y
> CONFIG_MFD_RC5T583=y
> # CONFIG_MFD_RK808 is not set
> CONFIG_MFD_RN5T618=y
> # CONFIG_MFD_SEC_CORE is not set
> CONFIG_MFD_SI476X_CORE=y
> CONFIG_MFD_SIMPLE_MFD_I2C=y
> # CONFIG_MFD_SL28CPLD is not set
> # CONFIG_MFD_SM501 is not set
> # CONFIG_MFD_SKY81452 is not set
> # CONFIG_RZ_MTU3 is not set
> CONFIG_ABX500_CORE=y
> CONFIG_AB8500_CORE=y
> CONFIG_MFD_DB8500_PRCMU=y
> CONFIG_MFD_STMPE=y
> 
> #
> # STMicroelectronics STMPE Interface Drivers
> #
> CONFIG_STMPE_I2C=y
> # end of STMicroelectronics STMPE Interface Drivers
> 
> CONFIG_MFD_SUN6I_PRCM=y
> CONFIG_MFD_SYSCON=y
> CONFIG_MFD_TI_AM335X_TSCADC=y
> # CONFIG_MFD_LP3943 is not set
> # CONFIG_MFD_LP8788 is not set
> # CONFIG_MFD_TI_LMU is not set
> CONFIG_MFD_PALMAS=y
> # CONFIG_TPS6105X is not set
> CONFIG_TPS65010=y
> # CONFIG_TPS6507X is not set
> CONFIG_MFD_TPS65086=y
> # CONFIG_MFD_TPS65090 is not set
> CONFIG_MFD_TPS65217=y
> # CONFIG_MFD_TI_LP873X is not set
> CONFIG_MFD_TI_LP87565=y
> CONFIG_MFD_TPS65218=y
> # CONFIG_MFD_TPS65219 is not set
> CONFIG_MFD_TPS6586X=y
> # CONFIG_MFD_TPS65910 is not set
> # CONFIG_MFD_TPS65912_I2C is not set
> CONFIG_TWL4030_CORE=y
> # CONFIG_TWL4030_POWER is not set
> # CONFIG_MFD_TWL4030_AUDIO is not set
> CONFIG_TWL6040_CORE=y
> CONFIG_MFD_WL1273_CORE=y
> CONFIG_MFD_LM3533=y
> # CONFIG_MFD_TIMBERDALE is not set
> CONFIG_MFD_TC3589X=y
> # CONFIG_MFD_TQMX86 is not set
> CONFIG_MFD_VX855=y
> # CONFIG_MFD_LOCHNAGAR is not set
> CONFIG_MFD_ARIZONA=y
> CONFIG_MFD_ARIZONA_I2C=y
> # CONFIG_MFD_CS47L24 is not set
> # CONFIG_MFD_WM5102 is not set
> CONFIG_MFD_WM5110=y
> CONFIG_MFD_WM8997=y
> # CONFIG_MFD_WM8998 is not set
> CONFIG_MFD_WM8400=y
> CONFIG_MFD_WM831X=y
> CONFIG_MFD_WM831X_I2C=y
> CONFIG_MFD_WM8350=y
> CONFIG_MFD_WM8350_I2C=y
> CONFIG_MFD_WM8994=y
> # CONFIG_MFD_STW481X is not set
> CONFIG_MFD_ROHM_BD718XX=y
> CONFIG_MFD_ROHM_BD71828=y
> CONFIG_MFD_ROHM_BD957XMUF=y
> # CONFIG_MFD_STM32_LPTIMER is not set
> # CONFIG_MFD_STM32_TIMERS is not set
> # CONFIG_MFD_STPMIC1 is not set
> CONFIG_MFD_STMFX=y
> CONFIG_MFD_ATC260X=y
> CONFIG_MFD_ATC260X_I2C=y
> CONFIG_MFD_KHADAS_MCU=y
> # CONFIG_MFD_ACER_A500_EC is not set
> CONFIG_MFD_QCOM_PM8008=y
> # CONFIG_MFD_VEXPRESS_SYSREG is not set
> CONFIG_RAVE_SP_CORE=y
> CONFIG_MFD_RSMU_I2C=y
> # end of Multifunction device drivers
> 
> CONFIG_REGULATOR=y
> CONFIG_REGULATOR_DEBUG=y
> CONFIG_REGULATOR_FIXED_VOLTAGE=y
> CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
> CONFIG_REGULATOR_USERSPACE_CONSUMER=y
> # CONFIG_REGULATOR_88PG86X is not set
> # CONFIG_REGULATOR_88PM800 is not set
> # CONFIG_REGULATOR_ACT8865 is not set
> CONFIG_REGULATOR_ACT8945A=y
> CONFIG_REGULATOR_AD5398=y
> # CONFIG_REGULATOR_ANATOP is not set
> CONFIG_REGULATOR_AB8500=y
> CONFIG_REGULATOR_ARM_SCMI=y
> # CONFIG_REGULATOR_AS3722 is not set
> # CONFIG_REGULATOR_ATC260X is not set
> # CONFIG_REGULATOR_AXP20X is not set
> CONFIG_REGULATOR_BD71815=y
> CONFIG_REGULATOR_BD71828=y
> CONFIG_REGULATOR_BD718XX=y
> CONFIG_REGULATOR_BD9571MWV=y
> # CONFIG_REGULATOR_BD957XMUF is not set
> # CONFIG_REGULATOR_DA9055 is not set
> CONFIG_REGULATOR_DA9062=y
> # CONFIG_REGULATOR_DA9063 is not set
> # CONFIG_REGULATOR_DA9121 is not set
> CONFIG_REGULATOR_DA9210=y
> CONFIG_REGULATOR_DA9211=y
> CONFIG_REGULATOR_DBX500_PRCMU=y
> CONFIG_REGULATOR_DB8500_PRCMU=y
> CONFIG_REGULATOR_FAN53555=y
> CONFIG_REGULATOR_FAN53880=y
> # CONFIG_REGULATOR_GPIO is not set
> # CONFIG_REGULATOR_HI655X is not set
> CONFIG_REGULATOR_HI6421V600=y
> CONFIG_REGULATOR_ISL9305=y
> # CONFIG_REGULATOR_ISL6271A is not set
> CONFIG_REGULATOR_LP3971=y
> CONFIG_REGULATOR_LP3972=y
> CONFIG_REGULATOR_LP872X=y
> CONFIG_REGULATOR_LP8755=y
> CONFIG_REGULATOR_LP87565=y
> CONFIG_REGULATOR_LTC3589=y
> # CONFIG_REGULATOR_LTC3676 is not set
> # CONFIG_REGULATOR_MAX1586 is not set
> CONFIG_REGULATOR_MAX597X=y
> # CONFIG_REGULATOR_MAX77620 is not set
> CONFIG_REGULATOR_MAX77650=y
> CONFIG_REGULATOR_MAX8649=y
> CONFIG_REGULATOR_MAX8660=y
> CONFIG_REGULATOR_MAX8893=y
> CONFIG_REGULATOR_MAX8907=y
> CONFIG_REGULATOR_MAX8925=y
> CONFIG_REGULATOR_MAX8952=y
> CONFIG_REGULATOR_MAX8997=y
> CONFIG_REGULATOR_MAX8998=y
> CONFIG_REGULATOR_MAX20086=y
> CONFIG_REGULATOR_MAX20411=y
> CONFIG_REGULATOR_MAX77686=y
> # CONFIG_REGULATOR_MAX77693 is not set
> CONFIG_REGULATOR_MAX77802=y
> # CONFIG_REGULATOR_MAX77826 is not set
> CONFIG_REGULATOR_MC13XXX_CORE=y
> CONFIG_REGULATOR_MC13783=y
> # CONFIG_REGULATOR_MC13892 is not set
> # CONFIG_REGULATOR_MCP16502 is not set
> CONFIG_REGULATOR_MP5416=y
> # CONFIG_REGULATOR_MP8859 is not set
> CONFIG_REGULATOR_MP886X=y
> # CONFIG_REGULATOR_MPQ7920 is not set
> # CONFIG_REGULATOR_MT6311 is not set
> CONFIG_REGULATOR_MT6315=y
> CONFIG_REGULATOR_MT6323=y
> # CONFIG_REGULATOR_MT6331 is not set
> # CONFIG_REGULATOR_MT6332 is not set
> CONFIG_REGULATOR_MT6357=y
> CONFIG_REGULATOR_MT6358=y
> # CONFIG_REGULATOR_MT6359 is not set
> CONFIG_REGULATOR_MT6360=y
> # CONFIG_REGULATOR_MT6397 is not set
> CONFIG_REGULATOR_PALMAS=y
> CONFIG_REGULATOR_PBIAS=y
> CONFIG_REGULATOR_PCA9450=y
> # CONFIG_REGULATOR_PCF50633 is not set
> CONFIG_REGULATOR_PF8X00=y
> CONFIG_REGULATOR_PFUZE100=y
> # CONFIG_REGULATOR_PV88060 is not set
> # CONFIG_REGULATOR_PV88080 is not set
> # CONFIG_REGULATOR_PV88090 is not set
> # CONFIG_REGULATOR_QCOM_RPMH is not set
> CONFIG_REGULATOR_QCOM_SPMI=y
> CONFIG_REGULATOR_QCOM_USB_VBUS=y
> # CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
> CONFIG_REGULATOR_RC5T583=y
> CONFIG_REGULATOR_RN5T618=y
> CONFIG_REGULATOR_ROHM=y
> CONFIG_REGULATOR_RT4801=y
> # CONFIG_REGULATOR_RT4803 is not set
> CONFIG_REGULATOR_RT4831=y
> CONFIG_REGULATOR_RT5033=y
> # CONFIG_REGULATOR_RT5120 is not set
> CONFIG_REGULATOR_RT5190A=y
> CONFIG_REGULATOR_RT5739=y
> CONFIG_REGULATOR_RT5759=y
> CONFIG_REGULATOR_RT6160=y
> CONFIG_REGULATOR_RT6190=y
> CONFIG_REGULATOR_RT6245=y
> # CONFIG_REGULATOR_RTQ2134 is not set
> CONFIG_REGULATOR_RTMV20=y
> # CONFIG_REGULATOR_RTQ6752 is not set
> # CONFIG_REGULATOR_S2MPA01 is not set
> # CONFIG_REGULATOR_S2MPS11 is not set
> # CONFIG_REGULATOR_S5M8767 is not set
> # CONFIG_REGULATOR_SC2731 is not set
> CONFIG_REGULATOR_SLG51000=y
> # CONFIG_REGULATOR_STM32_BOOSTER is not set
> # CONFIG_REGULATOR_STM32_VREFBUF is not set
> # CONFIG_REGULATOR_STM32_PWR is not set
> CONFIG_REGULATOR_TI_ABB=y
> # CONFIG_REGULATOR_STW481X_VMMC is not set
> CONFIG_REGULATOR_SY7636A=y
> CONFIG_REGULATOR_SY8106A=y
> CONFIG_REGULATOR_SY8824X=y
> CONFIG_REGULATOR_SY8827N=y
> # CONFIG_REGULATOR_TPS51632 is not set
> # CONFIG_REGULATOR_TPS62360 is not set
> CONFIG_REGULATOR_TPS6286X=y
> CONFIG_REGULATOR_TPS65023=y
> # CONFIG_REGULATOR_TPS6507X is not set
> # CONFIG_REGULATOR_TPS65086 is not set
> # CONFIG_REGULATOR_TPS65132 is not set
> CONFIG_REGULATOR_TPS65217=y
> # CONFIG_REGULATOR_TPS65218 is not set
> CONFIG_REGULATOR_TPS6586X=y
> # CONFIG_REGULATOR_TPS68470 is not set
> CONFIG_REGULATOR_TWL4030=y
> CONFIG_REGULATOR_UNIPHIER=y
> # CONFIG_REGULATOR_VCTRL is not set
> CONFIG_REGULATOR_VEXPRESS=y
> CONFIG_REGULATOR_WM831X=y
> CONFIG_REGULATOR_WM8350=y
> # CONFIG_REGULATOR_WM8400 is not set
> CONFIG_REGULATOR_WM8994=y
> CONFIG_REGULATOR_QCOM_LABIBB=y
> # CONFIG_RC_CORE is not set
> CONFIG_CEC_CORE=y
> CONFIG_CEC_NOTIFIER=y
> 
> #
> # CEC support
> #
> CONFIG_MEDIA_CEC_SUPPORT=y
> CONFIG_CEC_CH7322=y
> # CONFIG_CEC_MESON_AO is not set
> # CONFIG_CEC_MESON_G12A_AO is not set
> # CONFIG_CEC_GPIO is not set
> # CONFIG_CEC_SAMSUNG_S5P is not set
> CONFIG_CEC_STI=y
> # CONFIG_CEC_STM32 is not set
> # CONFIG_CEC_TEGRA is not set
> # end of CEC support
> 
> CONFIG_MEDIA_SUPPORT=y
> # CONFIG_MEDIA_SUPPORT_FILTER is not set
> CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
> 
> #
> # Media device types
> #
> CONFIG_MEDIA_CAMERA_SUPPORT=y
> CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
> CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
> CONFIG_MEDIA_RADIO_SUPPORT=y
> CONFIG_MEDIA_SDR_SUPPORT=y
> CONFIG_MEDIA_PLATFORM_SUPPORT=y
> CONFIG_MEDIA_TEST_SUPPORT=y
> # end of Media device types
> 
> #
> # Media core support
> #
> # CONFIG_VIDEO_DEV is not set
> # CONFIG_MEDIA_CONTROLLER is not set
> # CONFIG_DVB_CORE is not set
> # end of Media core support
> 
> #
> # Media drivers
> #
> 
> #
> # Media drivers
> #
> # CONFIG_MEDIA_PCI_SUPPORT is not set
> # CONFIG_MEDIA_PLATFORM_DRIVERS is not set
> # end of Media drivers
> 
> #
> # Media ancillary drivers
> #
> CONFIG_MEDIA_TUNER=y
> 
> #
> # Customize TV tuners
> #
> # CONFIG_MEDIA_TUNER_FC0011 is not set
> # CONFIG_MEDIA_TUNER_FC0012 is not set
> CONFIG_MEDIA_TUNER_FC0013=y
> CONFIG_MEDIA_TUNER_IT913X=y
> # CONFIG_MEDIA_TUNER_M88RS6000T is not set
> CONFIG_MEDIA_TUNER_MAX2165=y
> CONFIG_MEDIA_TUNER_MC44S803=y
> # CONFIG_MEDIA_TUNER_MT2060 is not set
> # CONFIG_MEDIA_TUNER_MT2063 is not set
> CONFIG_MEDIA_TUNER_MT20XX=y
> CONFIG_MEDIA_TUNER_MT2131=y
> # CONFIG_MEDIA_TUNER_MT2266 is not set
> CONFIG_MEDIA_TUNER_MXL301RF=y
> # CONFIG_MEDIA_TUNER_MXL5005S is not set
> # CONFIG_MEDIA_TUNER_MXL5007T is not set
> # CONFIG_MEDIA_TUNER_QM1D1B0004 is not set
> CONFIG_MEDIA_TUNER_QM1D1C0042=y
> # CONFIG_MEDIA_TUNER_QT1010 is not set
> CONFIG_MEDIA_TUNER_R820T=y
> # CONFIG_MEDIA_TUNER_SI2157 is not set
> CONFIG_MEDIA_TUNER_SIMPLE=y
> CONFIG_MEDIA_TUNER_TDA18212=y
> CONFIG_MEDIA_TUNER_TDA18218=y
> CONFIG_MEDIA_TUNER_TDA18250=y
> CONFIG_MEDIA_TUNER_TDA18271=y
> CONFIG_MEDIA_TUNER_TDA827X=y
> CONFIG_MEDIA_TUNER_TDA8290=y
> CONFIG_MEDIA_TUNER_TDA9887=y
> CONFIG_MEDIA_TUNER_TEA5761=y
> CONFIG_MEDIA_TUNER_TEA5767=y
> CONFIG_MEDIA_TUNER_TUA9001=y
> CONFIG_MEDIA_TUNER_XC2028=y
> CONFIG_MEDIA_TUNER_XC4000=y
> CONFIG_MEDIA_TUNER_XC5000=y
> # end of Customize TV tuners
> 
> #
> # Customise DVB Frontends
> #
> # end of Customise DVB Frontends
> 
> #
> # Tools to develop new frontends
> #
> # end of Media ancillary drivers
> 
> #
> # Graphics support
> #
> CONFIG_APERTURE_HELPERS=y
> CONFIG_VIDEO_CMDLINE=y
> CONFIG_VIDEO_NOMODESET=y
> # CONFIG_TEGRA_HOST1X is not set
> # CONFIG_IMX_IPUV3_CORE is not set
> # CONFIG_DRM is not set
> CONFIG_DRM_DEBUG_MODESET_LOCK=y
> 
> #
> # ARM devices
> #
> # end of ARM devices
> 
> #
> # Frame buffer Devices
> #
> CONFIG_FB_NOTIFY=y
> CONFIG_FB=y
> CONFIG_FIRMWARE_EDID=y
> CONFIG_FB_DDC=y
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> CONFIG_FB_CFB_REV_PIXELS_IN_BYTE=y
> CONFIG_FB_SYS_FILLRECT=y
> CONFIG_FB_SYS_COPYAREA=y
> CONFIG_FB_SYS_IMAGEBLIT=y
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> CONFIG_FB_SYS_FOPS=y
> CONFIG_FB_DEFERRED_IO=y
> CONFIG_FB_SVGALIB=y
> CONFIG_FB_BACKLIGHT=y
> CONFIG_FB_MODE_HELPERS=y
> CONFIG_FB_TILEBLITTING=y
> 
> #
> # Frame buffer hardware drivers
> #
> CONFIG_FB_CIRRUS=y
> CONFIG_FB_PM2=y
> # CONFIG_FB_PM2_FIFO_DISCONNECT is not set
> # CONFIG_FB_ARMCLCD is not set
> # CONFIG_FB_CLPS711X is not set
> # CONFIG_FB_IMX is not set
> CONFIG_FB_CYBER2000=y
> # CONFIG_FB_CYBER2000_DDC is not set
> # CONFIG_FB_ARC is not set
> # CONFIG_FB_CONTROL is not set
> CONFIG_FB_ASILIANT=y
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_GBE is not set
> # CONFIG_FB_PVR2 is not set
> CONFIG_FB_OPENCORES=y
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_ATMEL is not set
> CONFIG_FB_NVIDIA=y
> # CONFIG_FB_NVIDIA_I2C is not set
> CONFIG_FB_NVIDIA_DEBUG=y
> # CONFIG_FB_NVIDIA_BACKLIGHT is not set
> CONFIG_FB_RIVA=y
> # CONFIG_FB_RIVA_I2C is not set
> # CONFIG_FB_RIVA_DEBUG is not set
> CONFIG_FB_RIVA_BACKLIGHT=y
> CONFIG_FB_I740=y
> # CONFIG_FB_MATROX is not set
> CONFIG_FB_RADEON=y
> # CONFIG_FB_RADEON_I2C is not set
> CONFIG_FB_RADEON_BACKLIGHT=y
> CONFIG_FB_RADEON_DEBUG=y
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> CONFIG_FB_S3=y
> # CONFIG_FB_S3_DDC is not set
> CONFIG_FB_SAVAGE=y
> CONFIG_FB_SAVAGE_I2C=y
> # CONFIG_FB_SAVAGE_ACCEL is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_VIA is not set
> CONFIG_FB_NEOMAGIC=y
> # CONFIG_FB_KYRO is not set
> CONFIG_FB_3DFX=y
> CONFIG_FB_3DFX_ACCEL=y
> CONFIG_FB_3DFX_I2C=y
> CONFIG_FB_VOODOO1=y
> CONFIG_FB_VT8623=y
> CONFIG_FB_TRIDENT=y
> CONFIG_FB_ARK=y
> CONFIG_FB_PM3=y
> CONFIG_FB_CARMINE=y
> # CONFIG_FB_CARMINE_DRAM_EVAL is not set
> CONFIG_CARMINE_DRAM_CUSTOM=y
> CONFIG_FB_VT8500=y
> # CONFIG_FB_WM8505 is not set
> CONFIG_FB_WMT_GE_ROPS=y
> # CONFIG_FB_PXA168 is not set
> CONFIG_FB_SH_MOBILE_LCDC=y
> # CONFIG_FB_S3C is not set
> CONFIG_FB_IBM_GXT4500=y
> CONFIG_FB_XILINX=y
> CONFIG_FB_GOLDFISH=y
> CONFIG_FB_DA8XX=y
> # CONFIG_FB_VIRTUAL is not set
> CONFIG_XEN_FBDEV_FRONTEND=y
> CONFIG_FB_METRONOME=y
> # CONFIG_FB_MB862XX is not set
> # CONFIG_FB_BROADSHEET is not set
> CONFIG_FB_SIMPLE=y
> CONFIG_FB_SSD1307=y
> CONFIG_FB_SM712=y
> # CONFIG_FB_OMAP is not set
> # CONFIG_FB_OMAP2 is not set
> # CONFIG_MMP_DISP is not set
> # end of Frame buffer Devices
> 
> #
> # Backlight & LCD device support
> #
> # CONFIG_LCD_CLASS_DEVICE is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> # CONFIG_BACKLIGHT_KTD253 is not set
> CONFIG_BACKLIGHT_KTZ8866=y
> CONFIG_BACKLIGHT_LM3533=y
> # CONFIG_BACKLIGHT_OMAP1 is not set
> CONFIG_BACKLIGHT_DA903X=y
> CONFIG_BACKLIGHT_MAX8925=y
> CONFIG_BACKLIGHT_QCOM_WLED=y
> CONFIG_BACKLIGHT_RT4831=y
> # CONFIG_BACKLIGHT_WM831X is not set
> # CONFIG_BACKLIGHT_ADP5520 is not set
> CONFIG_BACKLIGHT_ADP8860=y
> # CONFIG_BACKLIGHT_ADP8870 is not set
> CONFIG_BACKLIGHT_PCF50633=y
> CONFIG_BACKLIGHT_LM3639=y
> CONFIG_BACKLIGHT_PANDORA=y
> CONFIG_BACKLIGHT_TPS65217=y
> # CONFIG_BACKLIGHT_GPIO is not set
> CONFIG_BACKLIGHT_LV5207LP=y
> # CONFIG_BACKLIGHT_BD6107 is not set
> CONFIG_BACKLIGHT_ARCXCNN=y
> CONFIG_BACKLIGHT_RAVE_SP=y
> # CONFIG_BACKLIGHT_LED is not set
> # end of Backlight & LCD device support
> 
> CONFIG_VGASTATE=y
> CONFIG_VIDEOMODE_HELPERS=y
> 
> #
> # Console display driver support
> #
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> # CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
> # CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
> # CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
> CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER=y
> # end of Console display driver support
> 
> CONFIG_LOGO=y
> CONFIG_LOGO_LINUX_MONO=y
> CONFIG_LOGO_LINUX_VGA16=y
> CONFIG_LOGO_LINUX_CLUT224=y
> # end of Graphics support
> 
> CONFIG_SOUND=y
> # CONFIG_SND is not set
> # CONFIG_HID_SUPPORT is not set
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> # CONFIG_USB_SUPPORT is not set
> # CONFIG_MMC is not set
> CONFIG_MEMSTICK=y
> CONFIG_MEMSTICK_DEBUG=y
> 
> #
> # MemoryStick drivers
> #
> CONFIG_MEMSTICK_UNSAFE_RESUME=y
> 
> #
> # MemoryStick Host Controller Drivers
> #
> CONFIG_MEMSTICK_TIFM_MS=y
> # CONFIG_MEMSTICK_JMICRON_38X is not set
> CONFIG_MEMSTICK_R592=y
> CONFIG_MEMSTICK_REALTEK_PCI=y
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
> # CONFIG_LEDS_CLASS_FLASH is not set
> CONFIG_LEDS_CLASS_MULTICOLOR=y
> # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
> 
> #
> # LED drivers
> #
> CONFIG_LEDS_AN30259A=y
> # CONFIG_LEDS_ARIEL is not set
> # CONFIG_LEDS_AW2013 is not set
> # CONFIG_LEDS_BCM6328 is not set
> # CONFIG_LEDS_BCM6358 is not set
> # CONFIG_LEDS_TURRIS_OMNIA is not set
> CONFIG_LEDS_LM3530=y
> CONFIG_LEDS_LM3532=y
> CONFIG_LEDS_LM3533=y
> # CONFIG_LEDS_LM3642 is not set
> CONFIG_LEDS_LM3692X=y
> CONFIG_LEDS_MT6323=y
> # CONFIG_LEDS_COBALT_QUBE is not set
> # CONFIG_LEDS_COBALT_RAQ is not set
> CONFIG_LEDS_PCA9532=y
> CONFIG_LEDS_PCA9532_GPIO=y
> # CONFIG_LEDS_GPIO is not set
> CONFIG_LEDS_LP3944=y
> CONFIG_LEDS_LP3952=y
> CONFIG_LEDS_LP50XX=y
> CONFIG_LEDS_LP55XX_COMMON=y
> # CONFIG_LEDS_LP5521 is not set
> CONFIG_LEDS_LP5523=y
> CONFIG_LEDS_LP5562=y
> # CONFIG_LEDS_LP8501 is not set
> CONFIG_LEDS_LP8860=y
> CONFIG_LEDS_PCA955X=y
> # CONFIG_LEDS_PCA955X_GPIO is not set
> CONFIG_LEDS_PCA963X=y
> CONFIG_LEDS_WM831X_STATUS=y
> CONFIG_LEDS_WM8350=y
> # CONFIG_LEDS_DA903X is not set
> # CONFIG_LEDS_REGULATOR is not set
> CONFIG_LEDS_BD2606MVV=y
> CONFIG_LEDS_BD2802=y
> # CONFIG_LEDS_LT3593 is not set
> # CONFIG_LEDS_ADP5520 is not set
> CONFIG_LEDS_MC13783=y
> CONFIG_LEDS_NS2=y
> CONFIG_LEDS_NETXBIG=y
> CONFIG_LEDS_TCA6507=y
> CONFIG_LEDS_TLC591XX=y
> CONFIG_LEDS_MAX77650=y
> CONFIG_LEDS_MAX8997=y
> CONFIG_LEDS_LM355x=y
> # CONFIG_LEDS_OT200 is not set
> # CONFIG_LEDS_MENF21BMC is not set
> CONFIG_LEDS_IS31FL319X=y
> CONFIG_LEDS_IS31FL32XX=y
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> # CONFIG_LEDS_BLINKM is not set
> CONFIG_LEDS_SYSCON=y
> CONFIG_LEDS_MLXREG=y
> CONFIG_LEDS_USER=y
> CONFIG_LEDS_TI_LMU_COMMON=y
> # CONFIG_LEDS_LM3697 is not set
> # CONFIG_LEDS_IP30 is not set
> CONFIG_LEDS_BCM63138=y
> # CONFIG_LEDS_LGM is not set
> 
> #
> # Flash and Torch LED drivers
> #
> 
> #
> # RGB LED drivers
> #
> 
> #
> # LED Triggers
> #
> # CONFIG_LEDS_TRIGGERS is not set
> 
> #
> # Simple LED drivers
> #
> CONFIG_ACCESSIBILITY=y
> CONFIG_A11Y_BRAILLE_CONSOLE=y
> 
> #
> # Speakup console speech
> #
> CONFIG_SPEAKUP=y
> CONFIG_SPEAKUP_SERIALIO=y
> # CONFIG_SPEAKUP_SYNTH_ACNTSA is not set
> # CONFIG_SPEAKUP_SYNTH_ACNTPC is not set
> # CONFIG_SPEAKUP_SYNTH_APOLLO is not set
> # CONFIG_SPEAKUP_SYNTH_AUDPTR is not set
> CONFIG_SPEAKUP_SYNTH_BNS=y
> CONFIG_SPEAKUP_SYNTH_DECTLK=y
> # CONFIG_SPEAKUP_SYNTH_DECEXT is not set
> # CONFIG_SPEAKUP_SYNTH_DTLK is not set
> # CONFIG_SPEAKUP_SYNTH_KEYPC is not set
> CONFIG_SPEAKUP_SYNTH_LTLK=y
> CONFIG_SPEAKUP_SYNTH_SOFT=y
> CONFIG_SPEAKUP_SYNTH_SPKOUT=y
> # CONFIG_SPEAKUP_SYNTH_TXPRT is not set
> CONFIG_SPEAKUP_SYNTH_DUMMY=y
> # end of Speakup console speech
> 
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> # CONFIG_EDAC is not set
> CONFIG_RTC_LIB=y
> CONFIG_RTC_CLASS=y
> CONFIG_RTC_HCTOSYS=y
> CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> # CONFIG_RTC_SYSTOHC is not set
> CONFIG_RTC_DEBUG=y
> CONFIG_RTC_NVMEM=y
> 
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=y
> # CONFIG_RTC_INTF_PROC is not set
> # CONFIG_RTC_INTF_DEV is not set
> CONFIG_RTC_DRV_TEST=y
> 
> #
> # I2C RTC drivers
> #
> CONFIG_RTC_DRV_88PM80X=y
> # CONFIG_RTC_DRV_ABB5ZES3 is not set
> CONFIG_RTC_DRV_ABEOZ9=y
> # CONFIG_RTC_DRV_ABX80X is not set
> # CONFIG_RTC_DRV_BRCMSTB is not set
> # CONFIG_RTC_DRV_AS3722 is not set
> CONFIG_RTC_DRV_DS1307=y
> # CONFIG_RTC_DRV_DS1307_CENTURY is not set
> CONFIG_RTC_DRV_DS1374=y
> CONFIG_RTC_DRV_DS1374_WDT=y
> CONFIG_RTC_DRV_DS1672=y
> CONFIG_RTC_DRV_HYM8563=y
> # CONFIG_RTC_DRV_MAX6900 is not set
> # CONFIG_RTC_DRV_MAX8907 is not set
> CONFIG_RTC_DRV_MAX8925=y
> CONFIG_RTC_DRV_MAX8998=y
> CONFIG_RTC_DRV_MAX8997=y
> CONFIG_RTC_DRV_MAX77686=y
> CONFIG_RTC_DRV_NCT3018Y=y
> CONFIG_RTC_DRV_RS5C372=y
> CONFIG_RTC_DRV_ISL1208=y
> CONFIG_RTC_DRV_ISL12022=y
> CONFIG_RTC_DRV_ISL12026=y
> # CONFIG_RTC_DRV_X1205 is not set
> CONFIG_RTC_DRV_PCF8523=y
> CONFIG_RTC_DRV_PCF85063=y
> CONFIG_RTC_DRV_PCF85363=y
> CONFIG_RTC_DRV_PCF8563=y
> # CONFIG_RTC_DRV_PCF8583 is not set
> # CONFIG_RTC_DRV_M41T80 is not set
> CONFIG_RTC_DRV_BD70528=y
> CONFIG_RTC_DRV_BQ32K=y
> # CONFIG_RTC_DRV_TWL4030 is not set
> CONFIG_RTC_DRV_PALMAS=y
> # CONFIG_RTC_DRV_TPS6586X is not set
> CONFIG_RTC_DRV_RC5T583=y
> CONFIG_RTC_DRV_RC5T619=y
> CONFIG_RTC_DRV_S35390A=y
> CONFIG_RTC_DRV_FM3130=y
> # CONFIG_RTC_DRV_RX8010 is not set
> # CONFIG_RTC_DRV_RX8581 is not set
> # CONFIG_RTC_DRV_RX8025 is not set
> # CONFIG_RTC_DRV_EM3027 is not set
> CONFIG_RTC_DRV_RV3028=y
> CONFIG_RTC_DRV_RV3032=y
> # CONFIG_RTC_DRV_RV8803 is not set
> # CONFIG_RTC_DRV_S5M is not set
> # CONFIG_RTC_DRV_SD3078 is not set
> 
> #
> # SPI RTC drivers
> #
> CONFIG_RTC_I2C_AND_SPI=y
> 
> #
> # SPI and I2C RTC drivers
> #
> # CONFIG_RTC_DRV_DS3232 is not set
> # CONFIG_RTC_DRV_PCF2127 is not set
> # CONFIG_RTC_DRV_RV3029C2 is not set
> # CONFIG_RTC_DRV_RX6110 is not set
> 
> #
> # Platform RTC drivers
> #
> # CONFIG_RTC_DRV_CMOS is not set
> # CONFIG_RTC_DRV_DS1286 is not set
> CONFIG_RTC_DRV_DS1511=y
> # CONFIG_RTC_DRV_DS1553 is not set
> CONFIG_RTC_DRV_DS1685_FAMILY=y
> # CONFIG_RTC_DRV_DS1685 is not set
> CONFIG_RTC_DRV_DS1689=y
> # CONFIG_RTC_DRV_DS17285 is not set
> # CONFIG_RTC_DRV_DS17485 is not set
> # CONFIG_RTC_DRV_DS17885 is not set
> CONFIG_RTC_DRV_DS1742=y
> # CONFIG_RTC_DRV_DS2404 is not set
> CONFIG_RTC_DRV_DA9055=y
> CONFIG_RTC_DRV_DA9063=y
> CONFIG_RTC_DRV_STK17TA8=y
> CONFIG_RTC_DRV_M48T86=y
> # CONFIG_RTC_DRV_M48T35 is not set
> CONFIG_RTC_DRV_M48T59=y
> CONFIG_RTC_DRV_MSM6242=y
> CONFIG_RTC_DRV_BQ4802=y
> CONFIG_RTC_DRV_RP5C01=y
> # CONFIG_RTC_DRV_GAMECUBE is not set
> # CONFIG_RTC_DRV_WM831X is not set
> # CONFIG_RTC_DRV_WM8350 is not set
> # CONFIG_RTC_DRV_SC27XX is not set
> CONFIG_RTC_DRV_SPEAR=y
> # CONFIG_RTC_DRV_PCF50633 is not set
> # CONFIG_RTC_DRV_AB8500 is not set
> CONFIG_RTC_DRV_OPTEE=y
> CONFIG_RTC_DRV_ZYNQMP=y
> 
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_ASM9260 is not set
> # CONFIG_RTC_DRV_DIGICOLOR is not set
> # CONFIG_RTC_DRV_FSL_FTM_ALARM is not set
> # CONFIG_RTC_DRV_MESON is not set
> # CONFIG_RTC_DRV_MESON_VRTC is not set
> # CONFIG_RTC_DRV_OMAP is not set
> # CONFIG_RTC_DRV_S3C is not set
> # CONFIG_RTC_DRV_EP93XX is not set
> # CONFIG_RTC_DRV_SA1100 is not set
> CONFIG_RTC_DRV_SH=y
> CONFIG_RTC_DRV_PL030=y
> CONFIG_RTC_DRV_PL031=y
> # CONFIG_RTC_DRV_AT91RM9200 is not set
> # CONFIG_RTC_DRV_AT91SAM9 is not set
> # CONFIG_RTC_DRV_RZN1 is not set
> # CONFIG_RTC_DRV_GENERIC is not set
> CONFIG_RTC_DRV_VT8500=y
> CONFIG_RTC_DRV_SUN6I=y
> # CONFIG_RTC_DRV_SUNXI is not set
> # CONFIG_RTC_DRV_MV is not set
> # CONFIG_RTC_DRV_ARMADA38X is not set
> # CONFIG_RTC_DRV_CADENCE is not set
> CONFIG_RTC_DRV_FTRTC010=y
> # CONFIG_RTC_DRV_STMP is not set
> CONFIG_RTC_DRV_MC13XXX=y
> # CONFIG_RTC_DRV_JZ4740 is not set
> # CONFIG_RTC_DRV_LPC24XX is not set
> # CONFIG_RTC_DRV_LPC32XX is not set
> # CONFIG_RTC_DRV_PM8XXX is not set
> # CONFIG_RTC_DRV_TEGRA is not set
> # CONFIG_RTC_DRV_MXC is not set
> # CONFIG_RTC_DRV_MXC_V2 is not set
> # CONFIG_RTC_DRV_SNVS is not set
> # CONFIG_RTC_DRV_BBNSM is not set
> CONFIG_RTC_DRV_ST_LPC=y
> # CONFIG_RTC_DRV_MOXART is not set
> CONFIG_RTC_DRV_MT2712=y
> CONFIG_RTC_DRV_MT6397=y
> # CONFIG_RTC_DRV_MT7622 is not set
> # CONFIG_RTC_DRV_XGENE is not set
> CONFIG_RTC_DRV_R7301=y
> # CONFIG_RTC_DRV_STM32 is not set
> # CONFIG_RTC_DRV_RTD119X is not set
> CONFIG_RTC_DRV_ASPEED=y
> # CONFIG_RTC_DRV_TI_K3 is not set
> 
> #
> # HID Sensor RTC drivers
> #
> CONFIG_RTC_DRV_GOLDFISH=y
> # CONFIG_RTC_DRV_MSC313 is not set
> CONFIG_DMADEVICES=y
> CONFIG_DMADEVICES_DEBUG=y
> CONFIG_DMADEVICES_VDEBUG=y
> 
> #
> # DMA Devices
> #
> CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH=y
> CONFIG_DMA_ENGINE=y
> CONFIG_DMA_VIRTUAL_CHANNELS=y
> CONFIG_DMA_OF=y
> # CONFIG_ALTERA_MSGDMA is not set
> # CONFIG_AMBA_PL08X is not set
> # CONFIG_APPLE_ADMAC is not set
> # CONFIG_AXI_DMAC is not set
> # CONFIG_DMA_JZ4780 is not set
> # CONFIG_DMA_SA11X0 is not set
> # CONFIG_DMA_SUN6I is not set
> CONFIG_DW_AXI_DMAC=y
> # CONFIG_EP93XX_DMA is not set
> # CONFIG_FSL_EDMA is not set
> # CONFIG_FSL_QDMA is not set
> CONFIG_HISI_DMA=y
> # CONFIG_IMG_MDC_DMA is not set
> # CONFIG_INTEL_IDMA64 is not set
> # CONFIG_K3_DMA is not set
> # CONFIG_MCF_EDMA is not set
> # CONFIG_MILBEAUT_HDMAC is not set
> # CONFIG_MILBEAUT_XDMAC is not set
> CONFIG_MMP_PDMA=y
> CONFIG_MMP_TDMA=y
> # CONFIG_MV_XOR is not set
> # CONFIG_MXS_DMA is not set
> # CONFIG_NBPFAXI_DMA is not set
> CONFIG_OWL_DMA=y
> # CONFIG_PCH_DMA is not set
> CONFIG_PL330_DMA=y
> # CONFIG_PXA_DMA is not set
> # CONFIG_PLX_DMA is not set
> CONFIG_STE_DMA40=y
> # CONFIG_STM32_DMA is not set
> # CONFIG_STM32_DMAMUX is not set
> # CONFIG_STM32_MDMA is not set
> # CONFIG_SPRD_DMA is not set
> # CONFIG_TEGRA20_APB_DMA is not set
> # CONFIG_TEGRA210_ADMA is not set
> # CONFIG_TIMB_DMA is not set
> CONFIG_UNIPHIER_MDMAC=y
> CONFIG_UNIPHIER_XDMAC=y
> # CONFIG_XGENE_DMA is not set
> # CONFIG_XILINX_DMA is not set
> # CONFIG_XILINX_XDMA is not set
> CONFIG_XILINX_ZYNQMP_DMA=y
> CONFIG_XILINX_ZYNQMP_DPDMA=y
> # CONFIG_MTK_HSDMA is not set
> CONFIG_MTK_CQDMA=y
> # CONFIG_QCOM_BAM_DMA is not set
> CONFIG_QCOM_HIDMA_MGMT=y
> CONFIG_QCOM_HIDMA=y
> CONFIG_DW_DMAC_CORE=y
> # CONFIG_DW_DMAC is not set
> # CONFIG_DW_DMAC_PCI is not set
> CONFIG_DW_EDMA=y
> CONFIG_DW_EDMA_PCIE=y
> CONFIG_HSU_DMA=y
> CONFIG_SF_PDMA=y
> CONFIG_RENESAS_DMA=y
> CONFIG_SH_DMAE_BASE=y
> # CONFIG_SH_DMAE is not set
> CONFIG_RCAR_DMAC=y
> # CONFIG_RENESAS_USB_DMAC is not set
> # CONFIG_RZ_DMAC is not set
> # CONFIG_TI_CPPI41 is not set
> CONFIG_TI_EDMA=y
> # CONFIG_DMA_OMAP is not set
> CONFIG_TI_DMA_CROSSBAR=y
> # CONFIG_INTEL_LDMA is not set
> 
> #
> # DMA Clients
> #
> CONFIG_ASYNC_TX_DMA=y
> CONFIG_DMATEST=y
> CONFIG_DMA_ENGINE_RAID=y
> 
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=y
> # CONFIG_SW_SYNC is not set
> CONFIG_UDMABUF=y
> CONFIG_DMABUF_MOVE_NOTIFY=y
> # CONFIG_DMABUF_DEBUG is not set
> CONFIG_DMABUF_SELFTESTS=y
> # CONFIG_DMABUF_HEAPS is not set
> CONFIG_DMABUF_SYSFS_STATS=y
> # end of DMABUF options
> 
> # CONFIG_AUXDISPLAY is not set
> CONFIG_UIO=y
> # CONFIG_UIO_CIF is not set
> CONFIG_UIO_PDRV_GENIRQ=y
> CONFIG_UIO_DMEM_GENIRQ=y
> CONFIG_UIO_AEC=y
> # CONFIG_UIO_SERCOS3 is not set
> CONFIG_UIO_PCI_GENERIC=y
> # CONFIG_UIO_NETX is not set
> CONFIG_UIO_PRUSS=y
> CONFIG_UIO_MF624=y
> # CONFIG_VFIO is not set
> # CONFIG_VIRT_DRIVERS is not set
> CONFIG_VIRTIO_ANCHOR=y
> CONFIG_VIRTIO=y
> # CONFIG_VIRTIO_MENU is not set
> CONFIG_VHOST_MENU=y
> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> # end of Microsoft Hyper-V guest support
> 
> #
> # Xen driver support
> #
> CONFIG_XEN_BALLOON=y
> # CONFIG_XEN_SCRUB_PAGES_DEFAULT is not set
> # CONFIG_XEN_DEV_EVTCHN is not set
> # CONFIG_XEN_BACKEND is not set
> # CONFIG_XENFS is not set
> CONFIG_XEN_SYS_HYPERVISOR=y
> CONFIG_XEN_XENBUS_FRONTEND=y
> CONFIG_XEN_GNTDEV=y
> # CONFIG_XEN_GNTDEV_DMABUF is not set
> CONFIG_XEN_GRANT_DEV_ALLOC=y
> CONFIG_XEN_GRANT_DMA_ALLOC=y
> CONFIG_SWIOTLB_XEN=y
> # CONFIG_XEN_PRIVCMD is not set
> CONFIG_XEN_AUTO_XLATE=y
> # CONFIG_XEN_VIRTIO is not set
> # end of Xen driver support
> 
> # CONFIG_GREYBUS is not set
> CONFIG_COMEDI=y
> CONFIG_COMEDI_DEBUG=y
> CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
> CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
> CONFIG_COMEDI_MISC_DRIVERS=y
> CONFIG_COMEDI_BOND=y
> CONFIG_COMEDI_TEST=y
> CONFIG_COMEDI_PARPORT=y
> # CONFIG_COMEDI_SSV_DNP is not set
> # CONFIG_COMEDI_ISA_DRIVERS is not set
> # CONFIG_COMEDI_PCI_DRIVERS is not set
> CONFIG_COMEDI_8255=y
> CONFIG_COMEDI_8255_SA=y
> CONFIG_COMEDI_KCOMEDILIB=y
> CONFIG_COMEDI_NI_ROUTING=y
> CONFIG_COMEDI_TESTS=y
> CONFIG_COMEDI_TESTS_EXAMPLE=y
> CONFIG_COMEDI_TESTS_NI_ROUTES=y
> # CONFIG_STAGING is not set
> CONFIG_GOLDFISH=y
> CONFIG_GOLDFISH_PIPE=y
> CONFIG_CHROME_PLATFORMS=y
> # CONFIG_CROS_EC is not set
> CONFIG_MELLANOX_PLATFORM=y
> # CONFIG_MLXREG_HOTPLUG is not set
> CONFIG_MLXREG_IO=y
> # CONFIG_MLXREG_LC is not set
> CONFIG_NVSW_SN2201=y
> CONFIG_OLPC_XO175=y
> CONFIG_SURFACE_PLATFORMS=y
> CONFIG_HAVE_CLK=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> CONFIG_COMMON_CLK_WM831X=y
> 
> #
> # Clock driver for ARM Reference designs
> #
> CONFIG_CLK_ICST=y
> CONFIG_CLK_SP810=y
> CONFIG_CLK_VEXPRESS_OSC=y
> # end of Clock driver for ARM Reference designs
> 
> # CONFIG_CLK_HSDK is not set
> # CONFIG_COMMON_CLK_APPLE_NCO is not set
> CONFIG_COMMON_CLK_MAX77686=y
> # CONFIG_COMMON_CLK_MAX9485 is not set
> CONFIG_COMMON_CLK_HI655X=y
> # CONFIG_COMMON_CLK_SCMI is not set
> CONFIG_COMMON_CLK_SCPI=y
> # CONFIG_COMMON_CLK_SI5341 is not set
> CONFIG_COMMON_CLK_SI5351=y
> CONFIG_COMMON_CLK_SI514=y
> CONFIG_COMMON_CLK_SI544=y
> # CONFIG_COMMON_CLK_SI570 is not set
> # CONFIG_COMMON_CLK_BM1880 is not set
> # CONFIG_COMMON_CLK_CDCE706 is not set
> # CONFIG_COMMON_CLK_TPS68470 is not set
> # CONFIG_COMMON_CLK_CDCE925 is not set
> CONFIG_COMMON_CLK_CS2000_CP=y
> CONFIG_COMMON_CLK_EN7523=y
> # CONFIG_COMMON_CLK_FSL_FLEXSPI is not set
> # CONFIG_COMMON_CLK_FSL_SAI is not set
> # CONFIG_COMMON_CLK_GEMINI is not set
> # CONFIG_COMMON_CLK_LAN966X is not set
> CONFIG_COMMON_CLK_ASPEED=y
> # CONFIG_COMMON_CLK_S2MPS11 is not set
> # CONFIG_CLK_TWL6040 is not set
> # CONFIG_COMMON_CLK_AXI_CLKGEN is not set
> # CONFIG_CLK_QORIQ is not set
> # CONFIG_CLK_LS1028A_PLLDIG is not set
> # CONFIG_COMMON_CLK_XGENE is not set
> # CONFIG_COMMON_CLK_LOONGSON2 is not set
> # CONFIG_COMMON_CLK_PALMAS is not set
> # CONFIG_COMMON_CLK_OXNAS is not set
> # CONFIG_COMMON_CLK_RS9_PCIE is not set
> # CONFIG_COMMON_CLK_SI521XX is not set
> # CONFIG_COMMON_CLK_VC5 is not set
> CONFIG_COMMON_CLK_VC7=y
> # CONFIG_COMMON_CLK_MMP2_AUDIO is not set
> CONFIG_COMMON_CLK_BD718XX=y
> CONFIG_COMMON_CLK_FIXED_MMIO=y
> # CONFIG_COMMON_CLK_SP7021 is not set
> CONFIG_CLK_ACTIONS=y
> CONFIG_CLK_OWL_S500=y
> # CONFIG_CLK_OWL_S700 is not set
> # CONFIG_CLK_OWL_S900 is not set
> # CONFIG_CLK_BAIKAL_T1 is not set
> # CONFIG_CLK_BCM2711_DVP is not set
> CONFIG_CLK_BCM2835=y
> CONFIG_CLK_BCM_63XX=y
> # CONFIG_CLK_BCM_63XX_GATE is not set
> # CONFIG_CLK_BCM63268_TIMER is not set
> # CONFIG_CLK_BCM_KONA is not set
> CONFIG_COMMON_CLK_IPROC=y
> CONFIG_CLK_BCM_CYGNUS=y
> # CONFIG_CLK_BCM_HR2 is not set
> CONFIG_CLK_BCM_NSP=y
> # CONFIG_CLK_BCM_NS2 is not set
> # CONFIG_CLK_BCM_SR is not set
> # CONFIG_CLK_RASPBERRYPI is not set
> # CONFIG_COMMON_CLK_HI3516CV300 is not set
> CONFIG_COMMON_CLK_HI3519=y
> CONFIG_COMMON_CLK_HI3559A=y
> CONFIG_COMMON_CLK_HI3660=y
> CONFIG_COMMON_CLK_HI3670=y
> CONFIG_COMMON_CLK_HI3798CV200=y
> CONFIG_COMMON_CLK_HI6220=y
> CONFIG_RESET_HISI=y
> # CONFIG_STUB_CLK_HI6220 is not set
> CONFIG_STUB_CLK_HI3660=y
> # CONFIG_COMMON_CLK_BOSTON is not set
> # CONFIG_MXC_CLK is not set
> # CONFIG_CLK_IMX8MM is not set
> # CONFIG_CLK_IMX8MN is not set
> # CONFIG_CLK_IMX8MP is not set
> # CONFIG_CLK_IMX8MQ is not set
> # CONFIG_CLK_IMX8ULP is not set
> # CONFIG_CLK_IMX93 is not set
> # CONFIG_CLK_IMXRT1050 is not set
> 
> #
> # Ingenic SoCs drivers
> #
> # CONFIG_INGENIC_CGU_JZ4740 is not set
> # CONFIG_INGENIC_CGU_JZ4755 is not set
> # CONFIG_INGENIC_CGU_JZ4725B is not set
> # CONFIG_INGENIC_CGU_JZ4760 is not set
> # CONFIG_INGENIC_CGU_JZ4770 is not set
> # CONFIG_INGENIC_CGU_JZ4780 is not set
> # CONFIG_INGENIC_CGU_X1000 is not set
> # CONFIG_INGENIC_CGU_X1830 is not set
> # CONFIG_INGENIC_TCU_CLK is not set
> # end of Ingenic SoCs drivers
> 
> CONFIG_COMMON_CLK_KEYSTONE=y
> CONFIG_TI_SYSCON_CLK=y
> 
> #
> # Clock driver for MediaTek SoC
> #
> CONFIG_COMMON_CLK_MEDIATEK=y
> CONFIG_COMMON_CLK_MEDIATEK_FHCTL=y
> CONFIG_COMMON_CLK_MT2701=y
> CONFIG_COMMON_CLK_MT2701_MMSYS=y
> CONFIG_COMMON_CLK_MT2701_IMGSYS=y
> CONFIG_COMMON_CLK_MT2701_VDECSYS=y
> CONFIG_COMMON_CLK_MT2701_HIFSYS=y
> CONFIG_COMMON_CLK_MT2701_ETHSYS=y
> # CONFIG_COMMON_CLK_MT2701_BDPSYS is not set
> CONFIG_COMMON_CLK_MT2701_AUDSYS=y
> # CONFIG_COMMON_CLK_MT2701_G3DSYS is not set
> # CONFIG_COMMON_CLK_MT2712 is not set
> # CONFIG_COMMON_CLK_MT6765 is not set
> # CONFIG_COMMON_CLK_MT6779 is not set
> CONFIG_COMMON_CLK_MT6795=y
> # CONFIG_COMMON_CLK_MT6795_MFGCFG is not set
> CONFIG_COMMON_CLK_MT6795_MMSYS=y
> CONFIG_COMMON_CLK_MT6795_VDECSYS=y
> # CONFIG_COMMON_CLK_MT6795_VENCSYS is not set
> # CONFIG_COMMON_CLK_MT6797 is not set
> # CONFIG_COMMON_CLK_MT7622 is not set
> CONFIG_COMMON_CLK_MT7629=y
> # CONFIG_COMMON_CLK_MT7629_ETHSYS is not set
> CONFIG_COMMON_CLK_MT7629_HIFSYS=y
> # CONFIG_COMMON_CLK_MT7981 is not set
> CONFIG_COMMON_CLK_MT7986=y
> CONFIG_COMMON_CLK_MT7986_ETHSYS=y
> CONFIG_COMMON_CLK_MT8135=y
> CONFIG_COMMON_CLK_MT8167=y
> CONFIG_COMMON_CLK_MT8167_AUDSYS=y
> CONFIG_COMMON_CLK_MT8167_IMGSYS=y
> CONFIG_COMMON_CLK_MT8167_MFGCFG=y
> CONFIG_COMMON_CLK_MT8167_MMSYS=y
> CONFIG_COMMON_CLK_MT8167_VDECSYS=y
> CONFIG_COMMON_CLK_MT8173=y
> CONFIG_COMMON_CLK_MT8173_IMGSYS=y
> CONFIG_COMMON_CLK_MT8173_MMSYS=y
> CONFIG_COMMON_CLK_MT8173_VDECSYS=y
> CONFIG_COMMON_CLK_MT8173_VENCSYS=y
> # CONFIG_COMMON_CLK_MT8183 is not set
> CONFIG_COMMON_CLK_MT8186=y
> CONFIG_COMMON_CLK_MT8186_CAMSYS=y
> CONFIG_COMMON_CLK_MT8186_IMGSYS=y
> CONFIG_COMMON_CLK_MT8186_IPESYS=y
> CONFIG_COMMON_CLK_MT8186_WPESYS=y
> CONFIG_COMMON_CLK_MT8186_IMP_IIC_WRAP=y
> CONFIG_COMMON_CLK_MT8186_MCUSYS=y
> CONFIG_COMMON_CLK_MT8186_MDPSYS=y
> CONFIG_COMMON_CLK_MT8186_MFGCFG=y
> CONFIG_COMMON_CLK_MT8186_MMSYS=y
> CONFIG_COMMON_CLK_MT8186_VDECSYS=y
> CONFIG_COMMON_CLK_MT8186_VENCSYS=y
> CONFIG_COMMON_CLK_MT8188=y
> CONFIG_COMMON_CLK_MT8188_ADSP_AUDIO26M=y
> CONFIG_COMMON_CLK_MT8188_CAMSYS=y
> CONFIG_COMMON_CLK_MT8188_IMGSYS=y
> CONFIG_COMMON_CLK_MT8188_IMP_IIC_WRAP=y
> CONFIG_COMMON_CLK_MT8188_IPESYS=y
> CONFIG_COMMON_CLK_MT8188_MFGCFG=y
> CONFIG_COMMON_CLK_MT8188_VDECSYS=y
> CONFIG_COMMON_CLK_MT8188_VDOSYS=y
> CONFIG_COMMON_CLK_MT8188_VENCSYS=y
> CONFIG_COMMON_CLK_MT8188_VPPSYS=y
> CONFIG_COMMON_CLK_MT8188_WPESYS=y
> # CONFIG_COMMON_CLK_MT8192 is not set
> CONFIG_COMMON_CLK_MT8195=y
> CONFIG_COMMON_CLK_MT8195_APUSYS=y
> CONFIG_COMMON_CLK_MT8195_AUDSYS=y
> CONFIG_COMMON_CLK_MT8195_IMP_IIC_WRAP=y
> CONFIG_COMMON_CLK_MT8195_MFGCFG=y
> CONFIG_COMMON_CLK_MT8195_MSDC=y
> CONFIG_COMMON_CLK_MT8195_SCP_ADSP=y
> CONFIG_COMMON_CLK_MT8195_VDOSYS=y
> CONFIG_COMMON_CLK_MT8195_VPPSYS=y
> CONFIG_COMMON_CLK_MT8195_CAMSYS=y
> CONFIG_COMMON_CLK_MT8195_IMGSYS=y
> CONFIG_COMMON_CLK_MT8195_IPESYS=y
> CONFIG_COMMON_CLK_MT8195_WPESYS=y
> CONFIG_COMMON_CLK_MT8195_VDECSYS=y
> CONFIG_COMMON_CLK_MT8195_VENCSYS=y
> CONFIG_COMMON_CLK_MT8365=y
> CONFIG_COMMON_CLK_MT8365_APU=y
> CONFIG_COMMON_CLK_MT8365_CAM=y
> # CONFIG_COMMON_CLK_MT8365_MFG is not set
> CONFIG_COMMON_CLK_MT8365_MMSYS=y
> CONFIG_COMMON_CLK_MT8365_VDEC=y
> CONFIG_COMMON_CLK_MT8365_VENC=y
> CONFIG_COMMON_CLK_MT8516=y
> CONFIG_COMMON_CLK_MT8516_AUDSYS=y
> # end of Clock driver for MediaTek SoC
> 
> #
> # Clock support for Amlogic platforms
> #
> CONFIG_COMMON_CLK_MESON_REGMAP=y
> CONFIG_COMMON_CLK_MESON_MPLL=y
> CONFIG_COMMON_CLK_MESON_PLL=y
> CONFIG_COMMON_CLK_MESON8B=y
> # end of Clock support for Amlogic platforms
> 
> # CONFIG_MSTAR_MSC313_CPUPLL is not set
> # CONFIG_MSTAR_MSC313_MPLL is not set
> # CONFIG_MCHP_CLK_MPFS is not set
> # CONFIG_COMMON_CLK_PISTACHIO is not set
> # CONFIG_COMMON_CLK_QCOM is not set
> # CONFIG_CLK_MT7621 is not set
> CONFIG_CLK_RENESAS=y
> CONFIG_CLK_EMEV2=y
> CONFIG_CLK_RZA1=y
> CONFIG_CLK_R7S9210=y
> # CONFIG_CLK_R8A73A4 is not set
> CONFIG_CLK_R8A7740=y
> # CONFIG_CLK_R8A7742 is not set
> CONFIG_CLK_R8A7743=y
> # CONFIG_CLK_R8A7745 is not set
> # CONFIG_CLK_R8A77470 is not set
> # CONFIG_CLK_R8A774A1 is not set
> # CONFIG_CLK_R8A774B1 is not set
> # CONFIG_CLK_R8A774C0 is not set
> # CONFIG_CLK_R8A774E1 is not set
> # CONFIG_CLK_R8A7778 is not set
> CONFIG_CLK_R8A7779=y
> # CONFIG_CLK_R8A7790 is not set
> CONFIG_CLK_R8A7791=y
> # CONFIG_CLK_R8A7792 is not set
> CONFIG_CLK_R8A7794=y
> # CONFIG_CLK_R8A7795 is not set
> # CONFIG_CLK_R8A77960 is not set
> # CONFIG_CLK_R8A77961 is not set
> # CONFIG_CLK_R8A77965 is not set
> # CONFIG_CLK_R8A77970 is not set
> # CONFIG_CLK_R8A77980 is not set
> # CONFIG_CLK_R8A77990 is not set
> # CONFIG_CLK_R8A77995 is not set
> # CONFIG_CLK_R8A779A0 is not set
> # CONFIG_CLK_R8A779F0 is not set
> # CONFIG_CLK_R8A779G0 is not set
> # CONFIG_CLK_R9A06G032 is not set
> # CONFIG_CLK_R9A07G043 is not set
> # CONFIG_CLK_R9A07G044 is not set
> # CONFIG_CLK_R9A07G054 is not set
> # CONFIG_CLK_R9A09G011 is not set
> CONFIG_CLK_SH73A0=y
> # CONFIG_CLK_RCAR_CPG_LIB is not set
> CONFIG_CLK_RCAR_GEN2_CPG=y
> # CONFIG_CLK_RCAR_GEN3_CPG is not set
> # CONFIG_CLK_RCAR_GEN4_CPG is not set
> # CONFIG_CLK_RCAR_USB2_CLOCK_SEL is not set
> # CONFIG_CLK_RZG2L is not set
> CONFIG_CLK_RENESAS_CPG_MSSR=y
> CONFIG_CLK_RENESAS_CPG_MSTP=y
> CONFIG_CLK_RENESAS_DIV6=y
> CONFIG_COMMON_CLK_ROCKCHIP=y
> CONFIG_CLK_PX30=y
> # CONFIG_CLK_RV110X is not set
> # CONFIG_CLK_RV1126 is not set
> # CONFIG_CLK_RK3036 is not set
> CONFIG_CLK_RK312X=y
> # CONFIG_CLK_RK3188 is not set
> CONFIG_CLK_RK322X=y
> # CONFIG_CLK_RK3288 is not set
> CONFIG_CLK_RK3308=y
> CONFIG_CLK_RK3328=y
> CONFIG_CLK_RK3368=y
> CONFIG_CLK_RK3399=y
> CONFIG_CLK_RK3568=y
> CONFIG_CLK_RK3588=y
> CONFIG_COMMON_CLK_SAMSUNG=y
> # CONFIG_S3C64XX_COMMON_CLK is not set
> CONFIG_S5PV210_COMMON_CLK=y
> # CONFIG_EXYNOS_3250_COMMON_CLK is not set
> # CONFIG_EXYNOS_4_COMMON_CLK is not set
> # CONFIG_EXYNOS_5250_COMMON_CLK is not set
> # CONFIG_EXYNOS_5260_COMMON_CLK is not set
> # CONFIG_EXYNOS_5410_COMMON_CLK is not set
> # CONFIG_EXYNOS_5420_COMMON_CLK is not set
> # CONFIG_EXYNOS_ARM64_COMMON_CLK is not set
> CONFIG_EXYNOS_AUDSS_CLK_CON=y
> CONFIG_EXYNOS_CLKOUT=y
> # CONFIG_CLK_SIFIVE is not set
> # CONFIG_CLK_INTEL_SOCFPGA is not set
> # CONFIG_SPRD_COMMON_CLK is not set
> # CONFIG_CLK_STARFIVE_JH7100 is not set
> # CONFIG_CLK_STARFIVE_JH7110_SYS is not set
> # CONFIG_CLK_SUNXI is not set
> # CONFIG_SUNXI_CCU is not set
> CONFIG_COMMON_CLK_TI_ADPLL=y
> # CONFIG_CLK_UNIPHIER is not set
> # CONFIG_COMMON_CLK_VISCONTI is not set
> # CONFIG_CLK_LGM_CGU is not set
> # CONFIG_XILINX_VCU is not set
> CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
> # CONFIG_COMMON_CLK_ZYNQMP is not set
> CONFIG_HWSPINLOCK=y
> # CONFIG_HWSPINLOCK_OMAP is not set
> # CONFIG_HWSPINLOCK_QCOM is not set
> # CONFIG_HWSPINLOCK_SPRD is not set
> # CONFIG_HWSPINLOCK_STM32 is not set
> # CONFIG_HWSPINLOCK_SUN6I is not set
> # CONFIG_HSEM_U8500 is not set
> 
> #
> # Clock Source drivers
> #
> CONFIG_TIMER_OF=y
> CONFIG_TIMER_PROBE=y
> CONFIG_OMAP_DM_SYSTIMER=y
> CONFIG_CLKSRC_MMIO=y
> # CONFIG_BCM2835_TIMER is not set
> CONFIG_BCM_KONA_TIMER=y
> # CONFIG_DAVINCI_TIMER is not set
> # CONFIG_DIGICOLOR_TIMER is not set
> CONFIG_OMAP_DM_TIMER=y
> CONFIG_DW_APB_TIMER=y
> CONFIG_DW_APB_TIMER_OF=y
> # CONFIG_FTTMR010_TIMER is not set
> # CONFIG_IXP4XX_TIMER is not set
> CONFIG_ROCKCHIP_TIMER=y
> # CONFIG_ARMADA_370_XP_TIMER is not set
> # CONFIG_MESON6_TIMER is not set
> # CONFIG_ORION_TIMER is not set
> CONFIG_OWL_TIMER=y
> # CONFIG_RDA_TIMER is not set
> CONFIG_SUN4I_TIMER=y
> # CONFIG_SUN5I_HSTIMER is not set
> # CONFIG_TEGRA_TIMER is not set
> # CONFIG_TEGRA186_TIMER is not set
> CONFIG_VT8500_TIMER=y
> CONFIG_NPCM7XX_TIMER=y
> CONFIG_CADENCE_TTC_TIMER=y
> # CONFIG_ASM9260_TIMER is not set
> CONFIG_CLKSRC_NOMADIK_MTU=y
> CONFIG_CLKSRC_DBX500_PRCMU=y
> # CONFIG_CLPS711X_TIMER is not set
> # CONFIG_MXS_TIMER is not set
> # CONFIG_NSPIRE_TIMER is not set
> CONFIG_KEYSTONE_TIMER=y
> # CONFIG_INTEGRATOR_AP_TIMER is not set
> # CONFIG_CLKSRC_LPC32XX is not set
> # CONFIG_CLKSRC_PISTACHIO is not set
> CONFIG_CLKSRC_TI_32K=y
> # CONFIG_CLKSRC_STM32 is not set
> # CONFIG_CLKSRC_STM32_LP is not set
> # CONFIG_CLKSRC_MPS2 is not set
> # CONFIG_ARC_TIMERS is not set
> CONFIG_ARM_ARCH_TIMER=y
> # CONFIG_ARM_ARCH_TIMER_EVTSTREAM is not set
> CONFIG_ARM_GLOBAL_TIMER=y
> CONFIG_ARM_GT_INITIAL_PRESCALER_VAL=2
> CONFIG_ARM_TIMER_SP804=y
> CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK=y
> # CONFIG_ARMV7M_SYSTICK is not set
> # CONFIG_ATMEL_PIT is not set
> # CONFIG_ATMEL_ST is not set
> # CONFIG_ATMEL_TCB_CLKSRC is not set
> # CONFIG_CLKSRC_EXYNOS_MCT is not set
> CONFIG_CLKSRC_SAMSUNG_PWM=y
> # CONFIG_FSL_FTM_TIMER is not set
> # CONFIG_OXNAS_RPS_TIMER is not set
> CONFIG_SYS_SUPPORTS_SH_CMT=y
> CONFIG_MTK_TIMER=y
> CONFIG_MTK_CPUX_TIMER=y
> # CONFIG_SPRD_TIMER is not set
> CONFIG_SYS_SUPPORTS_SH_MTU2=y
> CONFIG_SYS_SUPPORTS_SH_TMU=y
> CONFIG_SYS_SUPPORTS_EM_STI=y
> # CONFIG_CLKSRC_JCORE_PIT is not set
> CONFIG_SH_TIMER_CMT=y
> CONFIG_SH_TIMER_MTU2=y
> CONFIG_RENESAS_OSTM=y
> CONFIG_SH_TIMER_TMU=y
> CONFIG_EM_TIMER_STI=y
> # CONFIG_CLKSRC_QCOM is not set
> # CONFIG_CLKSRC_VERSATILE is not set
> # CONFIG_CLKSRC_PXA is not set
> # CONFIG_CLKSRC_IMX_GPT is not set
> # CONFIG_CLKSRC_IMX_TPM is not set
> # CONFIG_TIMER_IMX_SYS_CTR is not set
> CONFIG_CLKSRC_ST_LPC=y
> # CONFIG_GXP_TIMER is not set
> # CONFIG_MILBEAUT_TIMER is not set
> # CONFIG_MSC313E_TIMER is not set
> # CONFIG_INGENIC_TIMER is not set
> # CONFIG_INGENIC_SYSOST is not set
> # CONFIG_INGENIC_OST is not set
> CONFIG_MICROCHIP_PIT64B=y
> # CONFIG_GOLDFISH_TIMER is not set
> # end of Clock Source drivers
> 
> CONFIG_MAILBOX=y
> # CONFIG_ARM_MHU is not set
> CONFIG_ARM_MHU_V2=y
> # CONFIG_IMX_MBOX is not set
> CONFIG_PLATFORM_MHU=y
> # CONFIG_PL320_MBOX is not set
> # CONFIG_ARMADA_37XX_RWTM_MBOX is not set
> CONFIG_OMAP2PLUS_MBOX=y
> CONFIG_OMAP_MBOX_KFIFO_SIZE=256
> # CONFIG_ROCKCHIP_MBOX is not set
> CONFIG_ALTERA_MBOX=y
> CONFIG_STI_MBOX=y
> # CONFIG_TI_MESSAGE_MANAGER is not set
> # CONFIG_HI3660_MBOX is not set
> CONFIG_HI6220_MBOX=y
> CONFIG_MAILBOX_TEST=y
> # CONFIG_POLARFIRE_SOC_MAILBOX is not set
> # CONFIG_QCOM_APCS_IPC is not set
> # CONFIG_BCM_PDC_MBOX is not set
> # CONFIG_STM32_IPCC is not set
> CONFIG_MTK_ADSP_MBOX=y
> CONFIG_MTK_CMDQ_MBOX=y
> # CONFIG_SUN6I_MSGBOX is not set
> # CONFIG_SPRD_MBOX is not set
> # CONFIG_QCOM_IPCC is not set
> # CONFIG_IOMMU_SUPPORT is not set
> 
> #
> # Remoteproc drivers
> #
> # CONFIG_REMOTEPROC is not set
> # end of Remoteproc drivers
> 
> #
> # Rpmsg drivers
> #
> CONFIG_RPMSG=y
> CONFIG_RPMSG_CTRL=y
> CONFIG_RPMSG_NS=y
> CONFIG_RPMSG_QCOM_GLINK=y
> CONFIG_RPMSG_QCOM_GLINK_RPM=y
> CONFIG_RPMSG_VIRTIO=y
> # end of Rpmsg drivers
> 
> CONFIG_SOUNDWIRE=y
> 
> #
> # SoundWire Devices
> #
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> CONFIG_OWL_PM_DOMAINS_HELPER=y
> # CONFIG_OWL_PM_DOMAINS is not set
> 
> #
> # Amlogic SoC drivers
> #
> # CONFIG_MESON_CANVAS is not set
> # CONFIG_MESON_CLK_MEASURE is not set
> # CONFIG_MESON_GX_SOCINFO is not set
> # CONFIG_MESON_GX_PM_DOMAINS is not set
> # CONFIG_MESON_EE_PM_DOMAINS is not set
> # CONFIG_MESON_MX_SOCINFO is not set
> # end of Amlogic SoC drivers
> 
> #
> # Apple SoC drivers
> #
> # CONFIG_APPLE_PMGR_PWRSTATE is not set
> # CONFIG_APPLE_RTKIT is not set
> # CONFIG_APPLE_SART is not set
> # end of Apple SoC drivers
> 
> #
> # ASPEED SoC drivers
> #
> CONFIG_ASPEED_LPC_CTRL=y
> CONFIG_ASPEED_LPC_SNOOP=y
> # CONFIG_ASPEED_UART_ROUTING is not set
> CONFIG_ASPEED_P2A_CTRL=y
> CONFIG_ASPEED_SOCINFO=y
> # end of ASPEED SoC drivers
> 
> # CONFIG_AT91_SOC_ID is not set
> # CONFIG_AT91_SOC_SFR is not set
> 
> #
> # Broadcom SoC drivers
> #
> # CONFIG_BCM2835_POWER is not set
> # CONFIG_SOC_BCM63XX is not set
> CONFIG_SOC_BRCMSTB=y
> CONFIG_BCM_PMB=y
> # end of Broadcom SoC drivers
> 
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # CONFIG_QUICC_ENGINE is not set
> # CONFIG_CPM_TSA is not set
> CONFIG_DPAA2_CONSOLE=y
> # end of NXP/Freescale QorIQ SoC drivers
> 
> #
> # fujitsu SoC drivers
> #
> # end of fujitsu SoC drivers
> 
> #
> # i.MX SoC drivers
> #
> # CONFIG_IMX_GPCV2_PM_DOMAINS is not set
> # CONFIG_SOC_IMX8M is not set
> # CONFIG_SOC_IMX9 is not set
> # end of i.MX SoC drivers
> 
> #
> # IXP4xx SoC drivers
> #
> # CONFIG_IXP4XX_QMGR is not set
> # CONFIG_IXP4XX_NPE is not set
> # end of IXP4xx SoC drivers
> 
> #
> # Enable LiteX SoC Builder specific drivers
> #
> CONFIG_LITEX=y
> CONFIG_LITEX_SOC_CONTROLLER=y
> # end of Enable LiteX SoC Builder specific drivers
> 
> # CONFIG_LOONGSON2_GUTS is not set
> 
> #
> # MediaTek SoC drivers
> #
> CONFIG_MTK_CMDQ=y
> # CONFIG_MTK_DEVAPC is not set
> CONFIG_MTK_INFRACFG=y
> # CONFIG_MTK_PMIC_WRAP is not set
> CONFIG_MTK_REGULATOR_COUPLER=y
> # CONFIG_MTK_SCPSYS is not set
> # CONFIG_MTK_SCPSYS_PM_DOMAINS is not set
> CONFIG_MTK_MMSYS=y
> CONFIG_MTK_SVS=y
> # end of MediaTek SoC drivers
> 
> CONFIG_WPCM450_SOC=y
> CONFIG_PLAT_PXA=y
> 
> #
> # Qualcomm SoC drivers
> #
> # CONFIG_QCOM_AOSS_QMP is not set
> # CONFIG_QCOM_COMMAND_DB is not set
> # CONFIG_QCOM_GENI_SE is not set
> # CONFIG_QCOM_GSBI is not set
> # CONFIG_QCOM_LLCC is not set
> # CONFIG_QCOM_RAMP_CTRL is not set
> # CONFIG_QCOM_RPMH is not set
> # CONFIG_QCOM_SMEM is not set
> # CONFIG_QCOM_SMD_RPM is not set
> # CONFIG_QCOM_SPM is not set
> # CONFIG_QCOM_WCNSS_CTRL is not set
> # CONFIG_QCOM_ICC_BWMON is not set
> # end of Qualcomm SoC drivers
> 
> CONFIG_SOC_RENESAS=y
> CONFIG_ARCH_RCAR_GEN1=y
> CONFIG_ARCH_RCAR_GEN2=y
> CONFIG_ARCH_RMOBILE=y
> CONFIG_ARCH_EMEV2=y
> CONFIG_ARCH_R8A7794=y
> CONFIG_ARCH_R8A7779=y
> # CONFIG_ARCH_R8A7790 is not set
> # CONFIG_ARCH_R8A7778 is not set
> CONFIG_ARCH_R8A7793=y
> # CONFIG_ARCH_R8A7791 is not set
> # CONFIG_ARCH_R8A7792 is not set
> CONFIG_ARCH_R8A7740=y
> # CONFIG_ARCH_R8A73A4 is not set
> CONFIG_ARCH_R7S72100=y
> CONFIG_ARCH_R7S9210=y
> # CONFIG_ARCH_R8A77470 is not set
> # CONFIG_ARCH_R8A7745 is not set
> # CONFIG_ARCH_R8A7742 is not set
> CONFIG_ARCH_R8A7743=y
> CONFIG_ARCH_R8A7744=y
> # CONFIG_ARCH_R9A06G032 is not set
> CONFIG_ARCH_SH73A0=y
> # CONFIG_PWC_RZV2M is not set
> CONFIG_RST_RCAR=y
> CONFIG_SYSC_RCAR=y
> # CONFIG_SYSC_RCAR_GEN4 is not set
> # CONFIG_SYSC_R8A77995 is not set
> CONFIG_SYSC_R8A7794=y
> # CONFIG_SYSC_R8A77990 is not set
> CONFIG_SYSC_R8A7779=y
> # CONFIG_SYSC_R8A7790 is not set
> # CONFIG_SYSC_R8A7795 is not set
> CONFIG_SYSC_R8A7791=y
> # CONFIG_SYSC_R8A77965 is not set
> # CONFIG_SYSC_R8A77960 is not set
> # CONFIG_SYSC_R8A77961 is not set
> # CONFIG_SYSC_R8A779F0 is not set
> # CONFIG_SYSC_R8A7792 is not set
> # CONFIG_SYSC_R8A77980 is not set
> # CONFIG_SYSC_R8A77970 is not set
> # CONFIG_SYSC_R8A779A0 is not set
> # CONFIG_SYSC_R8A779G0 is not set
> CONFIG_SYSC_RMOBILE=y
> # CONFIG_SYSC_R8A77470 is not set
> # CONFIG_SYSC_R8A7745 is not set
> # CONFIG_SYSC_R8A7742 is not set
> CONFIG_SYSC_R8A7743=y
> # CONFIG_SYSC_R8A774C0 is not set
> # CONFIG_SYSC_R8A774E1 is not set
> # CONFIG_SYSC_R8A774A1 is not set
> # CONFIG_SYSC_R8A774B1 is not set
> CONFIG_ROCKCHIP_GRF=y
> CONFIG_ROCKCHIP_IODOMAIN=y
> # CONFIG_ROCKCHIP_PM_DOMAINS is not set
> CONFIG_SOC_SAMSUNG=y
> # CONFIG_EXYNOS_CHIPID is not set
> # CONFIG_EXYNOS_USI is not set
> # CONFIG_EXYNOS_PMU is not set
> # CONFIG_EXYNOS_PM_DOMAINS is not set
> CONFIG_SAMSUNG_PM_CHECK=y
> CONFIG_SAMSUNG_PM_CHECK_CHUNKSIZE=64
> # CONFIG_EXYNOS_REGULATOR_COUPLER is not set
> # CONFIG_JH71XX_PMU is not set
> CONFIG_SUNXI_MBUS=y
> CONFIG_SUNXI_SRAM=y
> CONFIG_SUN20I_PPU=y
> # CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER is not set
> # CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER is not set
> # CONFIG_SOC_TI is not set
> # CONFIG_UX500_SOC_ID is not set
> CONFIG_SOC_REALVIEW=y
> 
> #
> # Xilinx SoC drivers
> #
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
> 
> CONFIG_PM_DEVFREQ=y
> 
> #
> # DEVFREQ Governors
> #
> CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
> CONFIG_DEVFREQ_GOV_PERFORMANCE=y
> CONFIG_DEVFREQ_GOV_POWERSAVE=y
> # CONFIG_DEVFREQ_GOV_USERSPACE is not set
> CONFIG_DEVFREQ_GOV_PASSIVE=y
> 
> #
> # DEVFREQ Drivers
> #
> # CONFIG_ARM_EXYNOS_BUS_DEVFREQ is not set
> # CONFIG_ARM_IMX_BUS_DEVFREQ is not set
> # CONFIG_ARM_IMX8M_DDRC_DEVFREQ is not set
> # CONFIG_ARM_TEGRA_DEVFREQ is not set
> # CONFIG_ARM_MEDIATEK_CCI_DEVFREQ is not set
> CONFIG_ARM_RK3399_DMC_DEVFREQ=y
> CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ=y
> CONFIG_PM_DEVFREQ_EVENT=y
> # CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP is not set
> # CONFIG_DEVFREQ_EVENT_EXYNOS_PPMU is not set
> CONFIG_DEVFREQ_EVENT_ROCKCHIP_DFI=y
> CONFIG_EXTCON=y
> 
> #
> # Extcon Device Drivers
> #
> CONFIG_EXTCON_ADC_JACK=y
> CONFIG_EXTCON_FSA9480=y
> CONFIG_EXTCON_GPIO=y
> CONFIG_EXTCON_MAX3355=y
> CONFIG_EXTCON_MAX8997=y
> CONFIG_EXTCON_PALMAS=y
> # CONFIG_EXTCON_PTN5150 is not set
> # CONFIG_EXTCON_QCOM_SPMI_MISC is not set
> CONFIG_EXTCON_RT8973A=y
> CONFIG_EXTCON_SM5502=y
> CONFIG_EXTCON_USB_GPIO=y
> CONFIG_MEMORY=y
> CONFIG_DDR=y
> CONFIG_ARM_PL172_MPMC=y
> # CONFIG_ATMEL_SDRAMC is not set
> # CONFIG_ATMEL_EBI is not set
> CONFIG_BRCMSTB_DPFE=y
> CONFIG_BRCMSTB_MEMC=y
> # CONFIG_BT1_L2_CTL is not set
> # CONFIG_TI_AEMIF is not set
> # CONFIG_TI_EMIF is not set
> CONFIG_OMAP_GPMC=y
> # CONFIG_OMAP_GPMC_DEBUG is not set
> CONFIG_TI_EMIF_SRAM=y
> # CONFIG_MVEBU_DEVBUS is not set
> # CONFIG_FSL_CORENET_CF is not set
> # CONFIG_FSL_IFC is not set
> # CONFIG_JZ4780_NEMC is not set
> # CONFIG_MTK_SMI is not set
> # CONFIG_DA8XX_DDRCTL is not set
> CONFIG_PL353_SMC=y
> # CONFIG_RENESAS_RPCIF is not set
> # CONFIG_STM32_FMC2_EBI is not set
> # CONFIG_SAMSUNG_MC is not set
> CONFIG_TEGRA_MC=y
> CONFIG_TEGRA20_EMC=y
> CONFIG_TEGRA30_EMC=y
> CONFIG_TEGRA124_EMC=y
> # CONFIG_TEGRA210_EMC is not set
> CONFIG_IIO=y
> CONFIG_IIO_BUFFER=y
> # CONFIG_IIO_BUFFER_CB is not set
> CONFIG_IIO_BUFFER_DMA=y
> CONFIG_IIO_BUFFER_DMAENGINE=y
> CONFIG_IIO_BUFFER_HW_CONSUMER=y
> CONFIG_IIO_KFIFO_BUF=y
> CONFIG_IIO_TRIGGERED_BUFFER=y
> CONFIG_IIO_CONFIGFS=y
> CONFIG_IIO_GTS_HELPER=y
> CONFIG_IIO_TRIGGER=y
> CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> CONFIG_IIO_SW_DEVICE=y
> CONFIG_IIO_SW_TRIGGER=y
> CONFIG_IIO_TRIGGERED_EVENT=y
> 
> #
> # Accelerometers
> #
> CONFIG_ADXL313=y
> CONFIG_ADXL313_I2C=y
> # CONFIG_ADXL355_I2C is not set
> # CONFIG_ADXL367_I2C is not set
> # CONFIG_ADXL372_I2C is not set
> # CONFIG_BMA400 is not set
> CONFIG_BMC150_ACCEL=y
> CONFIG_BMC150_ACCEL_I2C=y
> # CONFIG_DA280 is not set
> # CONFIG_DA311 is not set
> # CONFIG_DMARD06 is not set
> CONFIG_DMARD09=y
> CONFIG_DMARD10=y
> CONFIG_FXLS8962AF=y
> CONFIG_FXLS8962AF_I2C=y
> CONFIG_IIO_ST_ACCEL_3AXIS=y
> CONFIG_IIO_ST_ACCEL_I2C_3AXIS=y
> # CONFIG_IIO_KX022A_I2C is not set
> CONFIG_KXSD9=y
> CONFIG_KXSD9_I2C=y
> CONFIG_KXCJK1013=y
> # CONFIG_MC3230 is not set
> CONFIG_MMA7455=y
> CONFIG_MMA7455_I2C=y
> CONFIG_MMA7660=y
> CONFIG_MMA8452=y
> CONFIG_MMA9551_CORE=y
> CONFIG_MMA9551=y
> # CONFIG_MMA9553 is not set
> # CONFIG_MSA311 is not set
> CONFIG_MXC4005=y
> CONFIG_MXC6255=y
> CONFIG_STK8312=y
> CONFIG_STK8BA50=y
> # end of Accelerometers
> 
> #
> # Analog to digital converters
> #
> # CONFIG_AB8500_GPADC is not set
> # CONFIG_AD7091R5 is not set
> # CONFIG_AD7291 is not set
> CONFIG_AD7606=y
> CONFIG_AD7606_IFACE_PARALLEL=y
> CONFIG_AD799X=y
> CONFIG_ADI_AXI_ADC=y
> CONFIG_ASPEED_ADC=y
> # CONFIG_AT91_ADC is not set
> # CONFIG_AT91_SAMA5D2_ADC is not set
> # CONFIG_AXP20X_ADC is not set
> CONFIG_AXP288_ADC=y
> CONFIG_BCM_IPROC_ADC=y
> # CONFIG_BERLIN2_ADC is not set
> CONFIG_CC10001_ADC=y
> CONFIG_DA9150_GPADC=y
> CONFIG_ENVELOPE_DETECTOR=y
> # CONFIG_EP93XX_ADC is not set
> CONFIG_EXYNOS_ADC=y
> # CONFIG_HX711 is not set
> CONFIG_INA2XX_ADC=y
> # CONFIG_INGENIC_ADC is not set
> # CONFIG_IMX7D_ADC is not set
> # CONFIG_IMX8QXP_ADC is not set
> # CONFIG_IMX93_ADC is not set
> # CONFIG_LPC18XX_ADC is not set
> # CONFIG_LPC32XX_ADC is not set
> # CONFIG_LTC2471 is not set
> CONFIG_LTC2485=y
> CONFIG_LTC2497=y
> CONFIG_MAX1363=y
> CONFIG_MAX9611=y
> CONFIG_MCP3422=y
> CONFIG_MEDIATEK_MT6360_ADC=y
> CONFIG_MEDIATEK_MT6577_AUXADC=y
> # CONFIG_MESON_SARADC is not set
> CONFIG_MP2629_ADC=y
> CONFIG_NAU7802=y
> CONFIG_NPCM_ADC=y
> # CONFIG_PALMAS_GPADC is not set
> CONFIG_QCOM_VADC_COMMON=y
> CONFIG_QCOM_SPMI_IADC=y
> CONFIG_QCOM_SPMI_VADC=y
> CONFIG_QCOM_SPMI_ADC5=y
> CONFIG_RCAR_GYRO_ADC=y
> # CONFIG_RN5T618_ADC is not set
> CONFIG_ROCKCHIP_SARADC=y
> CONFIG_RICHTEK_RTQ6056=y
> # CONFIG_RZG2L_ADC is not set
> # CONFIG_SC27XX_ADC is not set
> # CONFIG_SPEAR_ADC is not set
> CONFIG_SD_ADC_MODULATOR=y
> # CONFIG_STM32_ADC_CORE is not set
> # CONFIG_STM32_DFSDM_CORE is not set
> # CONFIG_STM32_DFSDM_ADC is not set
> CONFIG_STMPE_ADC=y
> # CONFIG_SUN4I_GPADC is not set
> # CONFIG_TI_ADC081C is not set
> CONFIG_TI_ADS1015=y
> CONFIG_TI_ADS7924=y
> CONFIG_TI_ADS1100=y
> CONFIG_TI_AM335X_ADC=y
> CONFIG_TWL4030_MADC=y
> CONFIG_TWL6030_GPADC=y
> # CONFIG_VF610_ADC is not set
> CONFIG_XILINX_XADC=y
> # CONFIG_XILINX_AMS is not set
> # end of Analog to digital converters
> 
> #
> # Analog to digital and digital to analog converters
> #
> # end of Analog to digital and digital to analog converters
> 
> #
> # Analog Front Ends
> #
> CONFIG_IIO_RESCALE=y
> # end of Analog Front Ends
> 
> #
> # Amplifiers
> #
> CONFIG_HMC425=y
> # end of Amplifiers
> 
> #
> # Capacitance to digital converters
> #
> CONFIG_AD7150=y
> # CONFIG_AD7746 is not set
> # end of Capacitance to digital converters
> 
> #
> # Chemical Sensors
> #
> CONFIG_ATLAS_PH_SENSOR=y
> # CONFIG_ATLAS_EZO_SENSOR is not set
> # CONFIG_BME680 is not set
> CONFIG_CCS811=y
> CONFIG_IAQCORE=y
> # CONFIG_PMS7003 is not set
> # CONFIG_SCD30_CORE is not set
> # CONFIG_SCD4X is not set
> CONFIG_SENSIRION_SGP30=y
> CONFIG_SENSIRION_SGP40=y
> CONFIG_SPS30=y
> CONFIG_SPS30_I2C=y
> # CONFIG_SPS30_SERIAL is not set
> CONFIG_SENSEAIR_SUNRISE_CO2=y
> # CONFIG_VZ89X is not set
> # end of Chemical Sensors
> 
> #
> # Hid Sensor IIO Common
> #
> # end of Hid Sensor IIO Common
> 
> CONFIG_IIO_MS_SENSORS_I2C=y
> 
> #
> # IIO SCMI Sensors
> #
> # CONFIG_IIO_SCMI is not set
> # end of IIO SCMI Sensors
> 
> #
> # SSP Sensor Common
> #
> # end of SSP Sensor Common
> 
> CONFIG_IIO_ST_SENSORS_I2C=y
> CONFIG_IIO_ST_SENSORS_CORE=y
> 
> #
> # Digital to analog converters
> #
> CONFIG_AD5064=y
> CONFIG_AD5380=y
> CONFIG_AD5446=y
> CONFIG_AD5592R_BASE=y
> CONFIG_AD5593R=y
> # CONFIG_AD5696_I2C is not set
> CONFIG_DPOT_DAC=y
> CONFIG_DS4424=y
> # CONFIG_LPC18XX_DAC is not set
> # CONFIG_M62332 is not set
> CONFIG_MAX517=y
> # CONFIG_MAX5821 is not set
> CONFIG_MCP4725=y
> # CONFIG_STM32_DAC is not set
> CONFIG_TI_DAC5571=y
> CONFIG_VF610_DAC=y
> # end of Digital to analog converters
> 
> #
> # IIO dummy driver
> #
> CONFIG_IIO_DUMMY_EVGEN=y
> CONFIG_IIO_SIMPLE_DUMMY=y
> CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
> CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y
> # end of IIO dummy driver
> 
> #
> # Filters
> #
> # end of Filters
> 
> #
> # Frequency Synthesizers DDS/PLL
> #
> 
> #
> # Clock Generator/Distribution
> #
> # end of Clock Generator/Distribution
> 
> #
> # Phase-Locked Loop (PLL) frequency synthesizers
> #
> # end of Phase-Locked Loop (PLL) frequency synthesizers
> # end of Frequency Synthesizers DDS/PLL
> 
> #
> # Digital gyroscope sensors
> #
> CONFIG_BMG160=y
> CONFIG_BMG160_I2C=y
> CONFIG_FXAS21002C=y
> CONFIG_FXAS21002C_I2C=y
> CONFIG_MPU3050=y
> CONFIG_MPU3050_I2C=y
> # CONFIG_IIO_ST_GYRO_3AXIS is not set
> # CONFIG_ITG3200 is not set
> # end of Digital gyroscope sensors
> 
> #
> # Health Sensors
> #
> 
> #
> # Heart Rate Monitors
> #
> # CONFIG_AFE4404 is not set
> CONFIG_MAX30100=y
> CONFIG_MAX30102=y
> # end of Heart Rate Monitors
> # end of Health Sensors
> 
> #
> # Humidity sensors
> #
> CONFIG_AM2315=y
> CONFIG_DHT11=y
> CONFIG_HDC100X=y
> # CONFIG_HDC2010 is not set
> CONFIG_HTS221=y
> CONFIG_HTS221_I2C=y
> # CONFIG_HTU21 is not set
> # CONFIG_SI7005 is not set
> # CONFIG_SI7020 is not set
> # end of Humidity sensors
> 
> #
> # Inertial measurement units
> #
> CONFIG_BMI160=y
> CONFIG_BMI160_I2C=y
> CONFIG_BOSCH_BNO055=y
> CONFIG_BOSCH_BNO055_SERIAL=y
> CONFIG_BOSCH_BNO055_I2C=y
> CONFIG_FXOS8700=y
> CONFIG_FXOS8700_I2C=y
> CONFIG_KMX61=y
> CONFIG_INV_ICM42600=y
> CONFIG_INV_ICM42600_I2C=y
> CONFIG_INV_MPU6050_IIO=y
> CONFIG_INV_MPU6050_I2C=y
> # CONFIG_IIO_ST_LSM6DSX is not set
> CONFIG_IIO_ST_LSM9DS0=y
> CONFIG_IIO_ST_LSM9DS0_I2C=y
> # end of Inertial measurement units
> 
> #
> # Light sensors
> #
> CONFIG_ADJD_S311=y
> CONFIG_ADUX1020=y
> CONFIG_AL3010=y
> CONFIG_AL3320A=y
> # CONFIG_APDS9300 is not set
> CONFIG_APDS9960=y
> CONFIG_AS73211=y
> # CONFIG_BH1750 is not set
> CONFIG_BH1780=y
> CONFIG_CM32181=y
> CONFIG_CM3232=y
> CONFIG_CM3323=y
> # CONFIG_CM3605 is not set
> CONFIG_CM36651=y
> # CONFIG_GP2AP002 is not set
> # CONFIG_GP2AP020A00F is not set
> CONFIG_IQS621_ALS=y
> CONFIG_SENSORS_ISL29018=y
> # CONFIG_SENSORS_ISL29028 is not set
> # CONFIG_ISL29125 is not set
> CONFIG_JSA1212=y
> CONFIG_ROHM_BU27034=y
> CONFIG_RPR0521=y
> # CONFIG_SENSORS_LM3533 is not set
> CONFIG_LTR501=y
> CONFIG_LTRF216A=y
> CONFIG_LV0104CS=y
> # CONFIG_MAX44000 is not set
> CONFIG_MAX44009=y
> CONFIG_NOA1305=y
> CONFIG_OPT3001=y
> CONFIG_PA12203001=y
> # CONFIG_SI1133 is not set
> CONFIG_SI1145=y
> # CONFIG_STK3310 is not set
> CONFIG_ST_UVIS25=y
> CONFIG_ST_UVIS25_I2C=y
> # CONFIG_TCS3414 is not set
> CONFIG_TCS3472=y
> CONFIG_SENSORS_TSL2563=y
> CONFIG_TSL2583=y
> CONFIG_TSL2591=y
> CONFIG_TSL2772=y
> CONFIG_TSL4531=y
> CONFIG_US5182D=y
> CONFIG_VCNL4000=y
> # CONFIG_VCNL4035 is not set
> CONFIG_VEML6030=y
> # CONFIG_VEML6070 is not set
> CONFIG_VL6180=y
> CONFIG_ZOPT2201=y
> # end of Light sensors
> 
> #
> # Magnetometer sensors
> #
> CONFIG_AK8974=y
> CONFIG_AK8975=y
> CONFIG_AK09911=y
> # CONFIG_BMC150_MAGN_I2C is not set
> CONFIG_MAG3110=y
> CONFIG_MMC35240=y
> CONFIG_IIO_ST_MAGN_3AXIS=y
> CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
> CONFIG_SENSORS_HMC5843=y
> CONFIG_SENSORS_HMC5843_I2C=y
> CONFIG_SENSORS_RM3100=y
> CONFIG_SENSORS_RM3100_I2C=y
> CONFIG_TI_TMAG5273=y
> CONFIG_YAMAHA_YAS530=y
> # end of Magnetometer sensors
> 
> #
> # Multiplexers
> #
> # CONFIG_IIO_MUX is not set
> # end of Multiplexers
> 
> #
> # Inclinometer sensors
> #
> # end of Inclinometer sensors
> 
> #
> # Triggers - standalone
> #
> # CONFIG_IIO_HRTIMER_TRIGGER is not set
> # CONFIG_IIO_INTERRUPT_TRIGGER is not set
> # CONFIG_IIO_STM32_LPTIMER_TRIGGER is not set
> # CONFIG_IIO_STM32_TIMER_TRIGGER is not set
> CONFIG_IIO_TIGHTLOOP_TRIGGER=y
> CONFIG_IIO_SYSFS_TRIGGER=y
> # end of Triggers - standalone
> 
> #
> # Linear and angular position sensors
> #
> # CONFIG_IQS624_POS is not set
> # end of Linear and angular position sensors
> 
> #
> # Digital potentiometers
> #
> # CONFIG_AD5110 is not set
> CONFIG_AD5272=y
> CONFIG_DS1803=y
> CONFIG_MAX5432=y
> # CONFIG_MCP4018 is not set
> CONFIG_MCP4531=y
> CONFIG_TPL0102=y
> # end of Digital potentiometers
> 
> #
> # Digital potentiostats
> #
> # CONFIG_LMP91000 is not set
> # end of Digital potentiostats
> 
> #
> # Pressure sensors
> #
> # CONFIG_ABP060MG is not set
> # CONFIG_BMP280 is not set
> CONFIG_DLHL60D=y
> # CONFIG_DPS310 is not set
> # CONFIG_HP03 is not set
> # CONFIG_ICP10100 is not set
> CONFIG_MPL115=y
> CONFIG_MPL115_I2C=y
> # CONFIG_MPL3115 is not set
> CONFIG_MS5611=y
> CONFIG_MS5611_I2C=y
> CONFIG_MS5637=y
> CONFIG_IIO_ST_PRESS=y
> CONFIG_IIO_ST_PRESS_I2C=y
> # CONFIG_T5403 is not set
> CONFIG_HP206C=y
> # CONFIG_ZPA2326 is not set
> # end of Pressure sensors
> 
> #
> # Lightning sensors
> #
> # end of Lightning sensors
> 
> #
> # Proximity and distance sensors
> #
> CONFIG_ISL29501=y
> CONFIG_LIDAR_LITE_V2=y
> CONFIG_MB1232=y
> CONFIG_PING=y
> CONFIG_RFD77402=y
> CONFIG_SRF04=y
> CONFIG_SX_COMMON=y
> CONFIG_SX9310=y
> # CONFIG_SX9324 is not set
> # CONFIG_SX9360 is not set
> CONFIG_SX9500=y
> CONFIG_SRF08=y
> CONFIG_VCNL3020=y
> CONFIG_VL53L0X_I2C=y
> # end of Proximity and distance sensors
> 
> #
> # Resolver to digital converters
> #
> # end of Resolver to digital converters
> 
> #
> # Temperature sensors
> #
> # CONFIG_IQS620AT_TEMP is not set
> # CONFIG_MLX90614 is not set
> CONFIG_MLX90632=y
> # CONFIG_TMP006 is not set
> # CONFIG_TMP007 is not set
> # CONFIG_TMP117 is not set
> CONFIG_TSYS01=y
> # CONFIG_TSYS02D is not set
> CONFIG_MAX30208=y
> # end of Temperature sensors
> 
> CONFIG_NTB=y
> # CONFIG_NTB_MSI is not set
> CONFIG_NTB_IDT=y
> CONFIG_NTB_SWITCHTEC=y
> CONFIG_NTB_PINGPONG=y
> CONFIG_NTB_TOOL=y
> CONFIG_NTB_PERF=y
> # CONFIG_NTB_TRANSPORT is not set
> # CONFIG_PWM is not set
> 
> #
> # IRQ chip support
> #
> CONFIG_IRQCHIP=y
> CONFIG_ARM_GIC=y
> CONFIG_ARM_GIC_MAX_NR=2
> CONFIG_ARM_GIC_V2M=y
> CONFIG_ARM_GIC_V3=y
> CONFIG_ARM_GIC_V3_ITS=y
> CONFIG_ARM_GIC_V3_ITS_PCI=y
> CONFIG_ARM_VIC=y
> CONFIG_ARM_VIC_NR=4
> CONFIG_ALPINE_MSI=y
> CONFIG_AL_FIC=y
> # CONFIG_BCM7038_L1_IRQ is not set
> CONFIG_BCM7120_L2_IRQ=y
> # CONFIG_BRCMSTB_L2_IRQ is not set
> CONFIG_MADERA_IRQ=y
> CONFIG_OMAP_IRQCHIP=y
> # CONFIG_JCORE_AIC is not set
> CONFIG_RENESAS_INTC_IRQPIN=y
> CONFIG_RENESAS_IRQC=y
> CONFIG_RENESAS_RZA1_IRQC=y
> # CONFIG_RENESAS_RZG2L_IRQC is not set
> # CONFIG_SL28CPLD_INTC is not set
> CONFIG_ST_IRQCHIP=y
> CONFIG_SUN6I_R_INTC=y
> CONFIG_SUNXI_NMI_INTC=y
> # CONFIG_TS4800_IRQ is not set
> CONFIG_XILINX_INTC=y
> CONFIG_KEYSTONE_IRQ=y
> # CONFIG_INGENIC_TCU_IRQ is not set
> CONFIG_PARTITION_PERCPU=y
> CONFIG_IRQ_UNIPHIER_AIDET=y
> # CONFIG_MESON_IRQ_GPIO is not set
> # CONFIG_IMX_IRQSTEER is not set
> # CONFIG_IMX_INTMUX is not set
> # CONFIG_IMX_MU_MSI is not set
> # CONFIG_EXYNOS_IRQ_COMBINER is not set
> # CONFIG_MST_IRQ is not set
> # CONFIG_MCHP_EIC is not set
> # CONFIG_SUNPLUS_SP7021_INTC is not set
> # end of IRQ chip support
> 
> CONFIG_IPACK_BUS=y
> CONFIG_BOARD_TPCI200=y
> CONFIG_SERIAL_IPOCTAL=y
> CONFIG_ARCH_HAS_RESET_CONTROLLER=y
> CONFIG_RESET_CONTROLLER=y
> # CONFIG_RESET_A10SR is not set
> # CONFIG_RESET_ATH79 is not set
> # CONFIG_RESET_AXS10X is not set
> # CONFIG_RESET_BCM6345 is not set
> # CONFIG_RESET_BERLIN is not set
> # CONFIG_RESET_BRCMSTB is not set
> CONFIG_RESET_BRCMSTB_RESCAL=y
> # CONFIG_RESET_HSDK is not set
> # CONFIG_RESET_IMX7 is not set
> # CONFIG_RESET_INTEL_GW is not set
> # CONFIG_RESET_K210 is not set
> # CONFIG_RESET_LANTIQ is not set
> # CONFIG_RESET_LPC18XX is not set
> # CONFIG_RESET_MCHP_SPARX5 is not set
> # CONFIG_RESET_MESON is not set
> # CONFIG_RESET_MESON_AUDIO_ARB is not set
> CONFIG_RESET_NPCM=y
> # CONFIG_RESET_PISTACHIO is not set
> # CONFIG_RESET_QCOM_AOSS is not set
> # CONFIG_RESET_QCOM_PDC is not set
> # CONFIG_RESET_RASPBERRYPI is not set
> # CONFIG_RESET_RZG2L_USBPHY_CTRL is not set
> CONFIG_RESET_SCMI=y
> CONFIG_RESET_SIMPLE=y
> # CONFIG_RESET_SOCFPGA is not set
> CONFIG_RESET_SUNPLUS=y
> CONFIG_RESET_SUNXI=y
> # CONFIG_RESET_TI_SCI is not set
> CONFIG_RESET_TI_SYSCON=y
> CONFIG_RESET_TI_TPS380X=y
> # CONFIG_RESET_TN48M_CPLD is not set
> CONFIG_RESET_UNIPHIER=y
> CONFIG_RESET_UNIPHIER_GLUE=y
> CONFIG_RESET_ZYNQ=y
> # CONFIG_RESET_STARFIVE_JH7100 is not set
> CONFIG_STI_RESET_SYSCFG=y
> CONFIG_STIH407_RESET=y
> # CONFIG_COMMON_RESET_HI3660 is not set
> CONFIG_COMMON_RESET_HI6220=y
> 
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=y
> CONFIG_GENERIC_PHY_MIPI_DPHY=y
> # CONFIG_PHY_LPC18XX_USB_OTG is not set
> # CONFIG_PHY_PISTACHIO_USB is not set
> # CONFIG_PHY_XGENE is not set
> # CONFIG_PHY_CAN_TRANSCEIVER is not set
> # CONFIG_PHY_SUN6I_MIPI_DPHY is not set
> CONFIG_PHY_SUN50I_USB3=y
> # CONFIG_PHY_MESON8_HDMI_TX is not set
> # CONFIG_PHY_MESON_G12A_MIPI_DPHY_ANALOG is not set
> # CONFIG_PHY_MESON_G12A_USB2 is not set
> # CONFIG_PHY_MESON_G12A_USB3_PCIE is not set
> # CONFIG_PHY_MESON_AXG_PCIE is not set
> # CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG is not set
> # CONFIG_PHY_MESON_AXG_MIPI_DPHY is not set
> 
> #
> # PHY drivers for Broadcom platforms
> #
> # CONFIG_PHY_BCM63XX_USBH is not set
> # CONFIG_PHY_CYGNUS_PCIE is not set
> CONFIG_PHY_BCM_SR_USB=y
> CONFIG_BCM_KONA_USB2_PHY=y
> # CONFIG_PHY_BCM_NS_USB2 is not set
> CONFIG_PHY_NS2_USB_DRD=y
> CONFIG_PHY_BRCM_SATA=y
> CONFIG_PHY_BRCM_USB=y
> CONFIG_PHY_BCM_SR_PCIE=y
> # end of PHY drivers for Broadcom platforms
> 
> # CONFIG_PHY_CADENCE_TORRENT is not set
> CONFIG_PHY_CADENCE_DPHY=y
> # CONFIG_PHY_CADENCE_DPHY_RX is not set
> CONFIG_PHY_CADENCE_SIERRA=y
> CONFIG_PHY_CADENCE_SALVO=y
> # CONFIG_PHY_FSL_IMX8MQ_USB is not set
> # CONFIG_PHY_MIXEL_LVDS_PHY is not set
> # CONFIG_PHY_MIXEL_MIPI_DPHY is not set
> # CONFIG_PHY_FSL_IMX8M_PCIE is not set
> # CONFIG_PHY_FSL_LYNX_28G is not set
> # CONFIG_PHY_HI6220_USB is not set
> # CONFIG_PHY_HI3660_USB is not set
> # CONFIG_PHY_HI3670_USB is not set
> # CONFIG_PHY_HI3670_PCIE is not set
> # CONFIG_PHY_HISTB_COMBPHY is not set
> # CONFIG_PHY_HISI_INNO_USB2 is not set
> CONFIG_PHY_HIX5HD2_SATA=y
> # CONFIG_PHY_LANTIQ_VRX200_PCIE is not set
> # CONFIG_PHY_LANTIQ_RCU_USB2 is not set
> # CONFIG_ARMADA375_USBCLUSTER_PHY is not set
> # CONFIG_PHY_BERLIN_SATA is not set
> # CONFIG_PHY_BERLIN_USB is not set
> CONFIG_PHY_MVEBU_A3700_COMPHY=y
> CONFIG_PHY_MVEBU_A3700_UTMI=y
> # CONFIG_PHY_MVEBU_A38X_COMPHY is not set
> # CONFIG_PHY_MVEBU_CP110_COMPHY is not set
> CONFIG_PHY_PXA_28NM_HSIC=y
> CONFIG_PHY_PXA_28NM_USB2=y
> CONFIG_PHY_PXA_USB=y
> # CONFIG_PHY_MMP3_USB is not set
> # CONFIG_PHY_MMP3_HSIC is not set
> # CONFIG_PHY_MTK_PCIE is not set
> # CONFIG_PHY_MTK_TPHY is not set
> CONFIG_PHY_MTK_UFS=y
> # CONFIG_PHY_MTK_XSPHY is not set
> CONFIG_PHY_MTK_HDMI=y
> CONFIG_PHY_MTK_MIPI_DSI=y
> # CONFIG_PHY_MTK_DP is not set
> # CONFIG_PHY_SPARX5_SERDES is not set
> CONFIG_PHY_LAN966X_SERDES=y
> CONFIG_PHY_OCELOT_SERDES=y
> # CONFIG_PHY_ATH79_USB is not set
> # CONFIG_PHY_QCOM_EDP is not set
> # CONFIG_PHY_QCOM_IPQ4019_USB is not set
> # CONFIG_PHY_QCOM_PCIE2 is not set
> # CONFIG_PHY_QCOM_QMP is not set
> # CONFIG_PHY_QCOM_QUSB2 is not set
> # CONFIG_PHY_QCOM_SNPS_EUSB2 is not set
> # CONFIG_PHY_QCOM_EUSB2_REPEATER is not set
> # CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2 is not set
> # CONFIG_PHY_QCOM_USB_HS_28NM is not set
> # CONFIG_PHY_QCOM_USB_SS is not set
> # CONFIG_PHY_QCOM_IPQ806X_USB is not set
> # CONFIG_PHY_MT7621_PCI is not set
> # CONFIG_PHY_RALINK_USB is not set
> # CONFIG_PHY_R8A779F0_ETHERNET_SERDES is not set
> CONFIG_PHY_RCAR_GEN2=y
> CONFIG_PHY_RCAR_GEN3_PCIE=y
> CONFIG_PHY_RCAR_GEN3_USB3=y
> # CONFIG_PHY_ROCKCHIP_DP is not set
> # CONFIG_PHY_ROCKCHIP_DPHY_RX0 is not set
> CONFIG_PHY_ROCKCHIP_EMMC=y
> # CONFIG_PHY_ROCKCHIP_INNO_HDMI is not set
> CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY=y
> CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=y
> CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY=y
> CONFIG_PHY_ROCKCHIP_PCIE=y
> CONFIG_PHY_ROCKCHIP_SNPS_PCIE3=y
> CONFIG_PHY_ROCKCHIP_TYPEC=y
> CONFIG_PHY_ROCKCHIP_USB=y
> # CONFIG_PHY_EXYNOS_DP_VIDEO is not set
> # CONFIG_PHY_EXYNOS_MIPI_VIDEO is not set
> # CONFIG_PHY_EXYNOS_PCIE is not set
> # CONFIG_PHY_SAMSUNG_UFS is not set
> # CONFIG_PHY_SAMSUNG_USB2 is not set
> # CONFIG_PHY_UNIPHIER_USB2 is not set
> CONFIG_PHY_UNIPHIER_USB3=y
> CONFIG_PHY_UNIPHIER_PCIE=y
> CONFIG_PHY_UNIPHIER_AHCI=y
> CONFIG_PHY_MIPHY28LP=y
> # CONFIG_PHY_ST_SPEAR1310_MIPHY is not set
> # CONFIG_PHY_ST_SPEAR1340_MIPHY is not set
> # CONFIG_PHY_STIH407_USB is not set
> # CONFIG_PHY_STM32_USBPHYC is not set
> # CONFIG_PHY_SUNPLUS_USB is not set
> # CONFIG_PHY_TEGRA194_P2U is not set
> # CONFIG_PHY_DA8XX_USB is not set
> # CONFIG_PHY_AM654_SERDES is not set
> # CONFIG_PHY_J721E_WIZ is not set
> CONFIG_OMAP_CONTROL_PHY=y
> CONFIG_TI_PIPE3=y
> # CONFIG_PHY_INTEL_KEEMBAY_EMMC is not set
> # CONFIG_PHY_INTEL_KEEMBAY_USB is not set
> # CONFIG_PHY_INTEL_LGM_COMBO is not set
> # CONFIG_PHY_INTEL_LGM_EMMC is not set
> # CONFIG_PHY_XILINX_ZYNQMP is not set
> # end of PHY Subsystem
> 
> CONFIG_POWERCAP=y
> CONFIG_IDLE_INJECT=y
> CONFIG_ARM_SCMI_POWERCAP=y
> CONFIG_DTPM=y
> # CONFIG_MCB is not set
> 
> #
> # Performance monitor support
> #
> CONFIG_ARM_CCI_PMU=y
> # CONFIG_ARM_CCI400_PMU is not set
> CONFIG_ARM_CCI5xx_PMU=y
> CONFIG_ARM_CCN=y
> # CONFIG_ARM_CMN is not set
> # CONFIG_ARM_PMU is not set
> # CONFIG_FSL_IMX8_DDR_PMU is not set
> # CONFIG_ARM_DMC620_PMU is not set
> # CONFIG_ALIBABA_UNCORE_DRW_PMU is not set
> # CONFIG_HNS3_PMU is not set
> # CONFIG_MESON_DDR_PMU is not set
> # end of Performance monitor support
> 
> CONFIG_RAS=y
> CONFIG_USB4=y
> CONFIG_USB4_DEBUGFS_WRITE=y
> # CONFIG_USB4_DEBUGFS_MARGINING is not set
> # CONFIG_USB4_DMA_TEST is not set
> 
> #
> # Android
> #
> # CONFIG_ANDROID_BINDER_IPC is not set
> # end of Android
> 
> # CONFIG_DAX is not set
> CONFIG_NVMEM=y
> CONFIG_NVMEM_SYSFS=y
> 
> #
> # Layout Types
> #
> CONFIG_NVMEM_LAYOUT_SL28_VPD=y
> CONFIG_NVMEM_LAYOUT_ONIE_TLV=y
> # end of Layout Types
> 
> # CONFIG_NVMEM_APPLE_EFUSES is not set
> CONFIG_NVMEM_BCM_OCOTP=y
> CONFIG_NVMEM_BRCM_NVRAM=y
> # CONFIG_NVMEM_IMX_IIM is not set
> # CONFIG_NVMEM_IMX_OCOTP is not set
> # CONFIG_NVMEM_JZ4780_EFUSE is not set
> # CONFIG_NVMEM_LAN9662_OTPC is not set
> # CONFIG_NVMEM_LAYERSCAPE_SFP is not set
> # CONFIG_NVMEM_LPC18XX_EEPROM is not set
> # CONFIG_NVMEM_LPC18XX_OTP is not set
> # CONFIG_NVMEM_MESON_MX_EFUSE is not set
> # CONFIG_NVMEM_MICROCHIP_OTPC is not set
> CONFIG_NVMEM_MTK_EFUSE=y
> # CONFIG_NVMEM_MXS_OCOTP is not set
> # CONFIG_NVMEM_NINTENDO_OTP is not set
> # CONFIG_NVMEM_QCOM_QFPROM is not set
> # CONFIG_NVMEM_RAVE_SP_EEPROM is not set
> CONFIG_NVMEM_RMEM=y
> # CONFIG_NVMEM_ROCKCHIP_EFUSE is not set
> CONFIG_NVMEM_ROCKCHIP_OTP=y
> # CONFIG_NVMEM_SC27XX_EFUSE is not set
> # CONFIG_NVMEM_SNVS_LPGPR is not set
> CONFIG_NVMEM_SPMI_SDAM=y
> # CONFIG_NVMEM_SPRD_EFUSE is not set
> # CONFIG_NVMEM_STM32_ROMEM is not set
> # CONFIG_NVMEM_SUNPLUS_OCOTP is not set
> # CONFIG_NVMEM_SUNXI_SID is not set
> # CONFIG_NVMEM_U_BOOT_ENV is not set
> # CONFIG_NVMEM_UNIPHIER_EFUSE is not set
> # CONFIG_NVMEM_VF610_OCOTP is not set
> 
> #
> # HW tracing support
> #
> CONFIG_STM=y
> CONFIG_STM_PROTO_BASIC=y
> CONFIG_STM_PROTO_SYS_T=y
> # CONFIG_STM_DUMMY is not set
> CONFIG_STM_SOURCE_CONSOLE=y
> CONFIG_STM_SOURCE_HEARTBEAT=y
> CONFIG_STM_SOURCE_FTRACE=y
> # CONFIG_INTEL_TH is not set
> # end of HW tracing support
> 
> CONFIG_FPGA=y
> # CONFIG_FPGA_MGR_SOCFPGA is not set
> # CONFIG_FPGA_MGR_SOCFPGA_A10 is not set
> # CONFIG_ALTERA_PR_IP_CORE is not set
> CONFIG_FPGA_MGR_ALTERA_CVP=y
> # CONFIG_FPGA_MGR_ZYNQ_FPGA is not set
> CONFIG_FPGA_BRIDGE=y
> # CONFIG_ALTERA_FREEZE_BRIDGE is not set
> # CONFIG_XILINX_PR_DECOUPLER is not set
> CONFIG_FPGA_REGION=y
> CONFIG_OF_FPGA_REGION=y
> # CONFIG_FPGA_DFL is not set
> # CONFIG_FPGA_MGR_ZYNQMP_FPGA is not set
> # CONFIG_FPGA_MGR_VERSAL_FPGA is not set
> CONFIG_FSI=y
> # CONFIG_FSI_NEW_DEV_NODE is not set
> CONFIG_FSI_MASTER_GPIO=y
> CONFIG_FSI_MASTER_HUB=y
> CONFIG_FSI_MASTER_AST_CF=y
> CONFIG_FSI_MASTER_ASPEED=y
> CONFIG_FSI_SCOM=y
> # CONFIG_FSI_SBEFIFO is not set
> CONFIG_TEE=y
> CONFIG_OPTEE=y
> CONFIG_PM_OPP=y
> # CONFIG_SIOX is not set
> # CONFIG_SLIMBUS is not set
> CONFIG_INTERCONNECT=y
> # CONFIG_INTERCONNECT_IMX is not set
> # CONFIG_INTERCONNECT_QCOM_OSM_L3 is not set
> # CONFIG_INTERCONNECT_SAMSUNG is not set
> CONFIG_COUNTER=y
> # CONFIG_104_QUAD_8 is not set
> # CONFIG_FTM_QUADDEC is not set
> # CONFIG_INTERRUPT_CNT is not set
> # CONFIG_MICROCHIP_TCB_CAPTURE is not set
> # CONFIG_RZ_MTU3_CNT is not set
> # CONFIG_STM32_LPTIMER_CNT is not set
> # CONFIG_STM32_TIMER_CNT is not set
> CONFIG_TI_ECAP_CAPTURE=y
> # CONFIG_TI_EQEP is not set
> # CONFIG_MOST is not set
> CONFIG_PECI=y
> CONFIG_PECI_CPU=y
> CONFIG_PECI_ASPEED=y
> # CONFIG_HTE is not set
> # end of Device Drivers
> 
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=y
> # CONFIG_VALIDATE_FS_PARSER is not set
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> CONFIG_EXPORTFS_BLOCK_OPS=y
> CONFIG_FILE_LOCKING=y
> # CONFIG_FS_ENCRYPTION is not set
> CONFIG_FS_VERITY=y
> CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
> # CONFIG_DNOTIFY is not set
> # CONFIG_INOTIFY_USER is not set
> # CONFIG_FANOTIFY is not set
> CONFIG_QUOTA=y
> CONFIG_QUOTA_DEBUG=y
> CONFIG_QUOTA_TREE=y
> # CONFIG_QFMT_V1 is not set
> CONFIG_QFMT_V2=y
> CONFIG_QUOTACTL=y
> CONFIG_AUTOFS4_FS=y
> CONFIG_AUTOFS_FS=y
> CONFIG_FUSE_FS=y
> # CONFIG_CUSE is not set
> CONFIG_VIRTIO_FS=y
> CONFIG_OVERLAY_FS=y
> # CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
> CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
> # CONFIG_OVERLAY_FS_INDEX is not set
> # CONFIG_OVERLAY_FS_METACOPY is not set
> 
> #
> # Caches
> #
> # CONFIG_FSCACHE is not set
> # end of Caches
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> # CONFIG_PROC_SYSCTL is not set
> # CONFIG_PROC_PAGE_MONITOR is not set
> CONFIG_PROC_CHILDREN=y
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_ARCH_SUPPORTS_HUGETLBFS=y
> CONFIG_HUGETLBFS=y
> CONFIG_HUGETLB_PAGE=y
> CONFIG_MEMFD_CREATE=y
> CONFIG_CONFIGFS_FS=y
> # end of Pseudo filesystems
> 
> CONFIG_MISC_FILESYSTEMS=y
> CONFIG_ORANGEFS_FS=y
> CONFIG_ECRYPT_FS=y
> CONFIG_ECRYPT_FS_MESSAGING=y
> CONFIG_JFFS2_FS=y
> CONFIG_JFFS2_FS_DEBUG=0
> CONFIG_JFFS2_FS_WRITEBUFFER=y
> # CONFIG_JFFS2_FS_WBUF_VERIFY is not set
> CONFIG_JFFS2_SUMMARY=y
> CONFIG_JFFS2_FS_XATTR=y
> # CONFIG_JFFS2_FS_POSIX_ACL is not set
> # CONFIG_JFFS2_FS_SECURITY is not set
> CONFIG_JFFS2_COMPRESSION_OPTIONS=y
> # CONFIG_JFFS2_ZLIB is not set
> # CONFIG_JFFS2_LZO is not set
> # CONFIG_JFFS2_RTIME is not set
> # CONFIG_JFFS2_RUBIN is not set
> CONFIG_JFFS2_CMODE_NONE=y
> # CONFIG_JFFS2_CMODE_PRIORITY is not set
> # CONFIG_JFFS2_CMODE_SIZE is not set
> # CONFIG_JFFS2_CMODE_FAVOURLZO is not set
> # CONFIG_CRAMFS is not set
> CONFIG_ROMFS_FS=y
> CONFIG_ROMFS_BACKED_BY_MTD=y
> CONFIG_ROMFS_ON_MTD=y
> CONFIG_PSTORE=y
> CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
> CONFIG_PSTORE_DEFLATE_COMPRESS=y
> CONFIG_PSTORE_LZO_COMPRESS=y
> # CONFIG_PSTORE_LZ4_COMPRESS is not set
> CONFIG_PSTORE_LZ4HC_COMPRESS=y
> CONFIG_PSTORE_842_COMPRESS=y
> # CONFIG_PSTORE_ZSTD_COMPRESS is not set
> CONFIG_PSTORE_COMPRESS=y
> CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
> # CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
> # CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
> # CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
> CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
> CONFIG_PSTORE_CONSOLE=y
> # CONFIG_PSTORE_PMSG is not set
> CONFIG_PSTORE_FTRACE=y
> # CONFIG_PSTORE_RAM is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> # CONFIG_NLS_CODEPAGE_437 is not set
> # CONFIG_NLS_CODEPAGE_737 is not set
> CONFIG_NLS_CODEPAGE_775=y
> CONFIG_NLS_CODEPAGE_850=y
> CONFIG_NLS_CODEPAGE_852=y
> CONFIG_NLS_CODEPAGE_855=y
> CONFIG_NLS_CODEPAGE_857=y
> # CONFIG_NLS_CODEPAGE_860 is not set
> CONFIG_NLS_CODEPAGE_861=y
> CONFIG_NLS_CODEPAGE_862=y
> # CONFIG_NLS_CODEPAGE_863 is not set
> CONFIG_NLS_CODEPAGE_864=y
> CONFIG_NLS_CODEPAGE_865=y
> CONFIG_NLS_CODEPAGE_866=y
> CONFIG_NLS_CODEPAGE_869=y
> CONFIG_NLS_CODEPAGE_936=y
> CONFIG_NLS_CODEPAGE_950=y
> CONFIG_NLS_CODEPAGE_932=y
> CONFIG_NLS_CODEPAGE_949=y
> CONFIG_NLS_CODEPAGE_874=y
> CONFIG_NLS_ISO8859_8=y
> CONFIG_NLS_CODEPAGE_1250=y
> CONFIG_NLS_CODEPAGE_1251=y
> CONFIG_NLS_ASCII=y
> CONFIG_NLS_ISO8859_1=y
> CONFIG_NLS_ISO8859_2=y
> CONFIG_NLS_ISO8859_3=y
> CONFIG_NLS_ISO8859_4=y
> CONFIG_NLS_ISO8859_5=y
> CONFIG_NLS_ISO8859_6=y
> CONFIG_NLS_ISO8859_7=y
> CONFIG_NLS_ISO8859_9=y
> # CONFIG_NLS_ISO8859_13 is not set
> CONFIG_NLS_ISO8859_14=y
> # CONFIG_NLS_ISO8859_15 is not set
> CONFIG_NLS_KOI8_R=y
> # CONFIG_NLS_KOI8_U is not set
> CONFIG_NLS_MAC_ROMAN=y
> CONFIG_NLS_MAC_CELTIC=y
> CONFIG_NLS_MAC_CENTEURO=y
> CONFIG_NLS_MAC_CROATIAN=y
> CONFIG_NLS_MAC_CYRILLIC=y
> CONFIG_NLS_MAC_GAELIC=y
> CONFIG_NLS_MAC_GREEK=y
> CONFIG_NLS_MAC_ICELAND=y
> # CONFIG_NLS_MAC_INUIT is not set
> CONFIG_NLS_MAC_ROMANIAN=y
> # CONFIG_NLS_MAC_TURKISH is not set
> CONFIG_NLS_UTF8=y
> CONFIG_UNICODE=y
> CONFIG_UNICODE_NORMALIZATION_SELFTEST=y
> # end of File systems
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> # CONFIG_KEYS_REQUEST_CACHE is not set
> # CONFIG_PERSISTENT_KEYRINGS is not set
> CONFIG_TRUSTED_KEYS=y
> # CONFIG_TRUSTED_KEYS_TEE is not set
> 
> #
> # No trust source selected!
> #
> CONFIG_ENCRYPTED_KEYS=y
> CONFIG_USER_DECRYPTED_DATA=y
> CONFIG_KEY_DH_OPERATIONS=y
> # CONFIG_KEY_NOTIFICATIONS is not set
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> # CONFIG_SECURITYFS is not set
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> # CONFIG_HARDENED_USERCOPY is not set
> # CONFIG_FORTIFY_SOURCE is not set
> CONFIG_STATIC_USERMODEHELPER=y
> CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
> CONFIG_DEFAULT_SECURITY_DAC=y
> CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,bpf"
> 
> #
> # Kernel hardening options
> #
> 
> #
> # Memory initialization
> #
> CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
> CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
> CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
> CONFIG_INIT_STACK_NONE=y
> # CONFIG_INIT_STACK_ALL_PATTERN is not set
> # CONFIG_INIT_STACK_ALL_ZERO is not set
> # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> # end of Memory initialization
> 
> CONFIG_CC_HAS_RANDSTRUCT=y
> CONFIG_RANDSTRUCT_NONE=y
> # CONFIG_RANDSTRUCT_FULL is not set
> # end of Kernel hardening options
> # end of Security options
> 
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> # CONFIG_CRYPTO_FIPS is not set
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_SKCIPHER=y
> CONFIG_CRYPTO_SKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=y
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_RNG_DEFAULT=y
> CONFIG_CRYPTO_AKCIPHER2=y
> CONFIG_CRYPTO_AKCIPHER=y
> CONFIG_CRYPTO_KPP2=y
> CONFIG_CRYPTO_KPP=y
> CONFIG_CRYPTO_ACOMP2=y
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> # CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> # CONFIG_CRYPTO_MANAGER_EXTRA_TESTS is not set
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> # CONFIG_CRYPTO_CRYPTD is not set
> CONFIG_CRYPTO_AUTHENC=y
> # CONFIG_CRYPTO_TEST is not set
> # end of Crypto core or helper
> 
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=y
> CONFIG_CRYPTO_DH=y
> # CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
> CONFIG_CRYPTO_ECC=y
> CONFIG_CRYPTO_ECDH=y
> # CONFIG_CRYPTO_ECDSA is not set
> CONFIG_CRYPTO_ECRDSA=y
> CONFIG_CRYPTO_SM2=y
> CONFIG_CRYPTO_CURVE25519=y
> # end of Public-key cryptography
> 
> #
> # Block ciphers
> #
> CONFIG_CRYPTO_AES=y
> CONFIG_CRYPTO_AES_TI=y
> CONFIG_CRYPTO_ARIA=y
> CONFIG_CRYPTO_BLOWFISH=y
> CONFIG_CRYPTO_BLOWFISH_COMMON=y
> CONFIG_CRYPTO_CAMELLIA=y
> CONFIG_CRYPTO_CAST_COMMON=y
> CONFIG_CRYPTO_CAST5=y
> # CONFIG_CRYPTO_CAST6 is not set
> CONFIG_CRYPTO_DES=y
> CONFIG_CRYPTO_FCRYPT=y
> CONFIG_CRYPTO_SERPENT=y
> CONFIG_CRYPTO_SM4=y
> CONFIG_CRYPTO_SM4_GENERIC=y
> CONFIG_CRYPTO_TWOFISH=y
> CONFIG_CRYPTO_TWOFISH_COMMON=y
> # end of Block ciphers
> 
> #
> # Length-preserving ciphers and modes
> #
> CONFIG_CRYPTO_ADIANTUM=y
> CONFIG_CRYPTO_CHACHA20=y
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_CFB=y
> CONFIG_CRYPTO_CTR=y
> # CONFIG_CRYPTO_CTS is not set
> CONFIG_CRYPTO_ECB=y
> CONFIG_CRYPTO_HCTR2=y
> CONFIG_CRYPTO_KEYWRAP=y
> CONFIG_CRYPTO_LRW=y
> CONFIG_CRYPTO_OFB=y
> # CONFIG_CRYPTO_PCBC is not set
> CONFIG_CRYPTO_XCTR=y
> CONFIG_CRYPTO_XTS=y
> CONFIG_CRYPTO_NHPOLY1305=y
> # end of Length-preserving ciphers and modes
> 
> #
> # AEAD (authenticated encryption with associated data) ciphers
> #
> CONFIG_CRYPTO_AEGIS128=y
> # CONFIG_CRYPTO_CHACHA20POLY1305 is not set
> # CONFIG_CRYPTO_CCM is not set
> CONFIG_CRYPTO_GCM=y
> CONFIG_CRYPTO_SEQIV=y
> # CONFIG_CRYPTO_ECHAINIV is not set
> # CONFIG_CRYPTO_ESSIV is not set
> # end of AEAD (authenticated encryption with associated data) ciphers
> 
> #
> # Hashes, digests, and MACs
> #
> CONFIG_CRYPTO_BLAKE2B=y
> # CONFIG_CRYPTO_CMAC is not set
> CONFIG_CRYPTO_GHASH=y
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_MD4=y
> CONFIG_CRYPTO_MD5=y
> CONFIG_CRYPTO_MICHAEL_MIC=y
> CONFIG_CRYPTO_POLYVAL=y
> # CONFIG_CRYPTO_POLY1305 is not set
> # CONFIG_CRYPTO_RMD160 is not set
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=y
> CONFIG_CRYPTO_SHA3=y
> CONFIG_CRYPTO_SM3=y
> CONFIG_CRYPTO_SM3_GENERIC=y
> CONFIG_CRYPTO_STREEBOG=y
> CONFIG_CRYPTO_VMAC=y
> CONFIG_CRYPTO_WP512=y
> CONFIG_CRYPTO_XCBC=y
> CONFIG_CRYPTO_XXHASH=y
> # end of Hashes, digests, and MACs
> 
> #
> # CRCs (cyclic redundancy checks)
> #
> CONFIG_CRYPTO_CRC32C=y
> # CONFIG_CRYPTO_CRC32 is not set
> CONFIG_CRYPTO_CRCT10DIF=y
> CONFIG_CRYPTO_CRC64_ROCKSOFT=y
> # end of CRCs (cyclic redundancy checks)
> 
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=y
> CONFIG_CRYPTO_LZO=y
> CONFIG_CRYPTO_842=y
> CONFIG_CRYPTO_LZ4=y
> CONFIG_CRYPTO_LZ4HC=y
> # CONFIG_CRYPTO_ZSTD is not set
> # end of Compression
> 
> #
> # Random number generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=y
> CONFIG_CRYPTO_DRBG_MENU=y
> CONFIG_CRYPTO_DRBG_HMAC=y
> CONFIG_CRYPTO_DRBG_HASH=y
> CONFIG_CRYPTO_DRBG_CTR=y
> CONFIG_CRYPTO_DRBG=y
> CONFIG_CRYPTO_JITTERENTROPY=y
> CONFIG_CRYPTO_KDF800108_CTR=y
> # end of Random number generation
> 
> #
> # Userspace interface
> #
> # end of Userspace interface
> 
> CONFIG_CRYPTO_HASH_INFO=y
> 
> #
> # Accelerated Cryptographic Algorithms for CPU (arm)
> #
> # CONFIG_CRYPTO_POLY1305_ARM is not set
> # CONFIG_CRYPTO_BLAKE2S_ARM is not set
> CONFIG_CRYPTO_SHA1_ARM=y
> CONFIG_CRYPTO_SHA256_ARM=y
> # CONFIG_CRYPTO_SHA512_ARM is not set
> CONFIG_CRYPTO_AES_ARM=y
> CONFIG_CRYPTO_CHACHA20_NEON=y
> # end of Accelerated Cryptographic Algorithms for CPU (arm)
> 
> # CONFIG_CRYPTO_HW is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=y
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> CONFIG_X509_CERTIFICATE_PARSER=y
> CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
> CONFIG_PKCS7_MESSAGE_PARSER=y
> # CONFIG_PKCS7_TEST_KEY is not set
> # CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
> # CONFIG_FIPS_SIGNATURE_SELFTEST is not set
> 
> #
> # Certificates for signature checking
> #
> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_TRUSTED_KEYS=""
> CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
> CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
> CONFIG_SECONDARY_TRUSTED_KEYRING=y
> # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
> # end of Certificates for signature checking
> 
> CONFIG_BINARY_PRINTF=y
> 
> #
> # Library routines
> #
> CONFIG_LINEAR_RANGES=y
> # CONFIG_PACKING is not set
> CONFIG_BITREVERSE=y
> CONFIG_HAVE_ARCH_BITREVERSE=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_CORDIC=y
> # CONFIG_PRIME_NUMBERS is not set
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
> 
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_UTILS=y
> CONFIG_CRYPTO_LIB_AES=y
> CONFIG_CRYPTO_LIB_GF128MUL=y
> CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
> CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
> CONFIG_CRYPTO_LIB_CHACHA=y
> CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
> CONFIG_CRYPTO_LIB_CURVE25519=y
> CONFIG_CRYPTO_LIB_DES=y
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=9
> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
> CONFIG_CRYPTO_LIB_POLY1305=y
> CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
> CONFIG_CRYPTO_LIB_SHA1=y
> CONFIG_CRYPTO_LIB_SHA256=y
> # end of Crypto library routines
> 
> CONFIG_CRC_CCITT=y
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=y
> CONFIG_CRC64_ROCKSOFT=y
> CONFIG_CRC_ITU_T=y
> CONFIG_CRC32=y
> CONFIG_CRC32_SELFTEST=y
> # CONFIG_CRC32_SLICEBY8 is not set
> # CONFIG_CRC32_SLICEBY4 is not set
> # CONFIG_CRC32_SARWATE is not set
> CONFIG_CRC32_BIT=y
> CONFIG_CRC64=y
> CONFIG_CRC4=y
> # CONFIG_CRC7 is not set
> CONFIG_LIBCRC32C=y
> CONFIG_CRC8=y
> CONFIG_XXHASH=y
> CONFIG_RANDOM32_SELFTEST=y
> CONFIG_842_COMPRESS=y
> CONFIG_842_DECOMPRESS=y
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_COMPRESS=y
> CONFIG_LZ4HC_COMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> # CONFIG_XZ_DEC_X86 is not set
> CONFIG_XZ_DEC_POWERPC=y
> CONFIG_XZ_DEC_IA64=y
> # CONFIG_XZ_DEC_ARM is not set
> # CONFIG_XZ_DEC_ARMTHUMB is not set
> # CONFIG_XZ_DEC_SPARC is not set
> CONFIG_XZ_DEC_MICROLZMA=y
> CONFIG_XZ_DEC_BCJ=y
> CONFIG_XZ_DEC_TEST=y
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_DECOMPRESS_BZIP2=y
> CONFIG_DECOMPRESS_LZMA=y
> CONFIG_DECOMPRESS_XZ=y
> CONFIG_DECOMPRESS_LZO=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_BCH=y
> CONFIG_INTERVAL_TREE=y
> CONFIG_XARRAY_MULTI=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT=y
> CONFIG_HAS_DMA=y
> CONFIG_DMA_OPS=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> CONFIG_DMA_DECLARE_COHERENT=y
> CONFIG_ARCH_HAS_SETUP_DMA_OPS=y
> CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS=y
> CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE=y
> CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU=y
> CONFIG_SWIOTLB=y
> # CONFIG_DMA_RESTRICTED_POOL is not set
> CONFIG_DMA_NONCOHERENT_MMAP=y
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_DMA_MAP_BENCHMARK is not set
> CONFIG_SGL_ALLOC=y
> CONFIG_GLOB=y
> # CONFIG_GLOB_SELFTEST is not set
> CONFIG_CLZ_TAB=y
> CONFIG_IRQ_POLL=y
> CONFIG_MPILIB=y
> CONFIG_LIBFDT=y
> CONFIG_OID_REGISTRY=y
> CONFIG_FONT_SUPPORT=y
> CONFIG_FONTS=y
> # CONFIG_FONT_8x8 is not set
> CONFIG_FONT_8x16=y
> # CONFIG_FONT_6x11 is not set
> CONFIG_FONT_7x14=y
> # CONFIG_FONT_PEARL_8x8 is not set
> # CONFIG_FONT_ACORN_8x8 is not set
> # CONFIG_FONT_MINI_4x6 is not set
> CONFIG_FONT_6x10=y
> # CONFIG_FONT_10x18 is not set
> # CONFIG_FONT_SUN8x16 is not set
> # CONFIG_FONT_SUN12x22 is not set
> # CONFIG_FONT_TER16x32 is not set
> CONFIG_FONT_6x8=y
> CONFIG_ARCH_STACKWALK=y
> CONFIG_STACKDEPOT=y
> # CONFIG_PARMAN is not set
> # CONFIG_OBJAGG is not set
> # end of Library routines
> 
> CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED=y
> 
> #
> # Kernel hacking
> #
> 
> #
> # printk and dmesg options
> #
> # CONFIG_PRINTK_TIME is not set
> CONFIG_PRINTK_CALLER=y
> # CONFIG_STACKTRACE_BUILD_ID is not set
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> CONFIG_BOOT_PRINTK_DELAY=y
> # CONFIG_DYNAMIC_DEBUG is not set
> # CONFIG_DYNAMIC_DEBUG_CORE is not set
> # CONFIG_SYMBOLIC_ERRNAME is not set
> # end of printk and dmesg options
> 
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_MISC=y
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_AS_HAS_NON_CONST_LEB128=y
> CONFIG_DEBUG_INFO_NONE=y
> # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> CONFIG_FRAME_WARN=1024
> CONFIG_STRIP_ASM_SYMS=y
> CONFIG_HEADERS_INSTALL=y
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> CONFIG_ARCH_WANT_FRAME_POINTERS=y
> CONFIG_FRAME_POINTER=y
> # CONFIG_VMLINUX_MAP is not set
> CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
> # end of Compile-time checks and compiler options
> 
> #
> # Generic Kernel Debugging Instruments
> #
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> CONFIG_MAGIC_SYSRQ_SERIAL=y
> CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
> CONFIG_DEBUG_FS=y
> CONFIG_DEBUG_FS_ALLOW_ALL=y
> # CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
> # CONFIG_DEBUG_FS_ALLOW_NONE is not set
> CONFIG_HAVE_ARCH_KGDB=y
> CONFIG_KGDB=y
> CONFIG_KGDB_SERIAL_CONSOLE=y
> # CONFIG_KGDB_TESTS is not set
> CONFIG_KGDB_KDB=y
> CONFIG_KDB_DEFAULT_ENABLE=0x1
> CONFIG_KDB_KEYBOARD=y
> CONFIG_KDB_CONTINUE_CATASTROPHIC=0
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> # CONFIG_UBSAN is not set
> # end of Generic Kernel Debugging Instruments
> 
> #
> # Networking Debugging
> #
> # end of Networking Debugging
> 
> #
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=y
> # CONFIG_DEBUG_PAGEALLOC is not set
> CONFIG_PAGE_OWNER=y
> CONFIG_PAGE_POISONING=y
> # CONFIG_DEBUG_PAGE_REF is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> # CONFIG_DEBUG_WX is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> # CONFIG_DEBUG_KMEMLEAK is not set
> # CONFIG_DEBUG_OBJECTS is not set
> # CONFIG_SHRINKER_DEBUG is not set
> CONFIG_DEBUG_STACK_USAGE=y
> CONFIG_SCHED_STACK_END_CHECK=y
> # CONFIG_DEBUG_VM is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> CONFIG_DEBUG_VIRTUAL=y
> CONFIG_DEBUG_MEMORY_INIT=y
> CONFIG_DEBUG_KMAP_LOCAL=y
> CONFIG_DEBUG_HIGHMEM=y
> CONFIG_HAVE_ARCH_KASAN=y
> CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> CONFIG_CC_HAS_KASAN_GENERIC=y
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> CONFIG_HAVE_ARCH_KFENCE=y
> CONFIG_KFENCE=y
> CONFIG_KFENCE_SAMPLE_INTERVAL=100
> CONFIG_KFENCE_NUM_OBJECTS=255
> # CONFIG_KFENCE_DEFERRABLE is not set
> CONFIG_KFENCE_STRESS_TEST_FAULTS=0
> # end of Memory Debugging
> 
> CONFIG_DEBUG_SHIRQ=y
> 
> #
> # Debug Oops, Lockups and Hangs
> #
> # CONFIG_PANIC_ON_OOPS is not set
> CONFIG_PANIC_ON_OOPS_VALUE=0
> CONFIG_PANIC_TIMEOUT=0
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
> # CONFIG_DETECT_HUNG_TASK is not set
> # CONFIG_WQ_WATCHDOG is not set
> # end of Debug Oops, Lockups and Hangs
> 
> #
> # Scheduler Debugging
> #
> CONFIG_SCHED_DEBUG=y
> # CONFIG_SCHEDSTATS is not set
> # end of Scheduler Debugging
> 
> # CONFIG_DEBUG_TIMEKEEPING is not set
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> CONFIG_PROVE_LOCKING=y
> # CONFIG_PROVE_RAW_LOCK_NESTING is not set
> CONFIG_LOCK_STAT=y
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> CONFIG_DEBUG_RWSEMS=y
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_LOCKDEP=y
> CONFIG_LOCKDEP_BITS=15
> CONFIG_LOCKDEP_CHAINS_BITS=16
> CONFIG_LOCKDEP_STACK_TRACE_BITS=19
> CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
> CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
> CONFIG_DEBUG_LOCKDEP=y
> # CONFIG_DEBUG_ATOMIC_SLEEP is not set
> CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
> CONFIG_LOCK_TORTURE_TEST=y
> # CONFIG_WW_MUTEX_SELFTEST is not set
> CONFIG_SCF_TORTURE_TEST=y
> # end of Lock Debugging (spinlocks, mutexes, etc...)
> 
> CONFIG_TRACE_IRQFLAGS=y
> CONFIG_DEBUG_IRQFLAGS=y
> CONFIG_STACKTRACE=y
> CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
> CONFIG_DEBUG_KOBJECT=y
> 
> #
> # Debug kernel data structures
> #
> # CONFIG_DEBUG_LIST is not set
> CONFIG_DEBUG_PLIST=y
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
> # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> # CONFIG_DEBUG_MAPLE_TREE is not set
> # end of Debug kernel data structures
> 
> # CONFIG_DEBUG_CREDENTIALS is not set
> 
> #
> # RCU Debugging
> #
> CONFIG_PROVE_RCU=y
> CONFIG_PROVE_RCU_LIST=y
> CONFIG_TORTURE_TEST=y
> # CONFIG_RCU_SCALE_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_RCU_REF_SCALE_TEST is not set
> # CONFIG_RCU_TRACE is not set
> CONFIG_RCU_EQS_DEBUG=y
> # end of RCU Debugging
> 
> CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
> # CONFIG_LATENCYTOP is not set
> CONFIG_NOP_TRACER=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
> CONFIG_TRACER_MAX_TRACE=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_RING_BUFFER=y
> CONFIG_EVENT_TRACING=y
> CONFIG_CONTEXT_SWITCH_TRACER=y
> CONFIG_RING_BUFFER_ALLOW_SWAP=y
> CONFIG_PREEMPTIRQ_TRACEPOINTS=y
> CONFIG_TRACING=y
> CONFIG_GENERIC_TRACER=y
> CONFIG_TRACING_SUPPORT=y
> CONFIG_FTRACE=y
> # CONFIG_BOOTTIME_TRACING is not set
> CONFIG_FUNCTION_TRACER=y
> CONFIG_FUNCTION_GRAPH_TRACER=y
> # CONFIG_DYNAMIC_FTRACE is not set
> CONFIG_FUNCTION_PROFILER=y
> # CONFIG_STACK_TRACER is not set
> CONFIG_IRQSOFF_TRACER=y
> # CONFIG_SCHED_TRACER is not set
> # CONFIG_HWLAT_TRACER is not set
> CONFIG_OSNOISE_TRACER=y
> CONFIG_TIMERLAT_TRACER=y
> # CONFIG_FTRACE_SYSCALLS is not set
> CONFIG_TRACER_SNAPSHOT=y
> CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
> CONFIG_TRACE_BRANCH_PROFILING=y
> # CONFIG_BRANCH_PROFILE_NONE is not set
> CONFIG_PROFILE_ANNOTATED_BRANCHES=y
> # CONFIG_PROFILE_ALL_BRANCHES is not set
> CONFIG_TRACING_BRANCHES=y
> CONFIG_BRANCH_TRACER=y
> # CONFIG_UPROBE_EVENTS is not set
> CONFIG_DYNAMIC_EVENTS=y
> CONFIG_TRACING_MAP=y
> CONFIG_SYNTH_EVENTS=y
> # CONFIG_USER_EVENTS is not set
> CONFIG_HIST_TRIGGERS=y
> CONFIG_TRACE_EVENT_INJECT=y
> # CONFIG_TRACEPOINT_BENCHMARK is not set
> CONFIG_RING_BUFFER_BENCHMARK=y
> CONFIG_TRACE_EVAL_MAP_FILE=y
> CONFIG_FTRACE_RECORD_RECURSION=y
> CONFIG_FTRACE_RECORD_RECURSION_SIZE=128
> # CONFIG_RING_BUFFER_RECORD_RECURSION is not set
> # CONFIG_FTRACE_STARTUP_TEST is not set
> CONFIG_RING_BUFFER_STARTUP_TEST=y
> CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS=y
> CONFIG_SYNTH_EVENT_GEN_TEST=y
> # CONFIG_HIST_TRIGGERS_DEBUG is not set
> # CONFIG_RV is not set
> # CONFIG_SAMPLES is not set
> 
> #
> # arm Debugging
> #
> # CONFIG_ARM_PTDUMP_DEBUGFS is not set
> CONFIG_UNWINDER_FRAME_POINTER=y
> # CONFIG_UNWINDER_ARM is not set
> # CONFIG_BACKTRACE_VERBOSE is not set
> CONFIG_DEBUG_USER=y
> # CONFIG_DEBUG_LL is not set
> CONFIG_DEBUG_LL_INCLUDE="mach/debug-macro.S"
> CONFIG_UNCOMPRESS_INCLUDE="debug/uncompress.h"
> # CONFIG_PID_IN_CONTEXTIDR is not set
> CONFIG_CORESIGHT=y
> CONFIG_CORESIGHT_LINKS_AND_SINKS=y
> CONFIG_CORESIGHT_LINK_AND_SINK_TMC=y
> # CONFIG_CORESIGHT_CATU is not set
> # CONFIG_CORESIGHT_SINK_TPIU is not set
> # CONFIG_CORESIGHT_SINK_ETBV10 is not set
> CONFIG_CORESIGHT_SOURCE_ETM3X=y
> CONFIG_CORESIGHT_STM=y
> CONFIG_CORESIGHT_CPU_DEBUG=y
> # CONFIG_CORESIGHT_CPU_DEBUG_DEFAULT_ON is not set
> # CONFIG_CORESIGHT_CTI is not set
> CONFIG_CORESIGHT_TPDM=y
> CONFIG_CORESIGHT_TPDA=y
> # end of arm Debugging
> 
> #
> # Kernel Testing and Coverage
> #
> # CONFIG_KUNIT is not set
> CONFIG_NOTIFIER_ERROR_INJECTION=y
> CONFIG_PM_NOTIFIER_ERROR_INJECT=y
> # CONFIG_FAULT_INJECTION is not set
> CONFIG_ARCH_HAS_KCOV=y
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> # CONFIG_KCOV is not set
> # CONFIG_RUNTIME_TESTING_MENU is not set
> CONFIG_ARCH_USE_MEMTEST=y
> CONFIG_MEMTEST=y
> # end of Kernel Testing and Coverage
> 
> #
> # Rust hacking
> #
> # end of Rust hacking
> # end of Kernel hacking
> 
> #
> # Documentation
> #
> # CONFIG_WARN_MISSING_DOCUMENTS is not set
> # CONFIG_WARN_ABI_ERRORS is not set
> # end of Documentation


-- 

