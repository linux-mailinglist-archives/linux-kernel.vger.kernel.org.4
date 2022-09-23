Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBC15E7EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiIWPxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIWPxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:53:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10A512849D;
        Fri, 23 Sep 2022 08:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A36DB815AA;
        Fri, 23 Sep 2022 15:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B764DC433C1;
        Fri, 23 Sep 2022 15:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663948379;
        bh=7+mfZBhDfEgCL0rS4DVsA5OULUb3tNmDRomaJyyxXPk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=u/X+wiOjQHWAFaUOmAjmcayxbVVSWUrWxpB02cwh+TdsCHqrnj4BUQv18Ta5tiT9S
         oLxlxWbzUiiGLV/X7PW7VP2uFX0jlvJj42Di63N/BASw89elF+kOS8Spd80fAs8Sdz
         H6u/5GiIbmDNS+73/FdFbcgmS9W6nv26Wj/68j4Kw1sJa08a20iFMvEejjX7I/qh1D
         4nfPFqQWDz90MzDk1M2IFQIUhUuhrODkSWdEKupDQGCqjvHBCLaJr1MaEg8fsy0ET8
         zB81rrSetZ7iUNQsyGuOf4xj+Ha8ct7vGMWDnAMfZX+FXZnwGhM40aSRJdfFyAgtBQ
         iP3SDslPE5hdA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 685FB5C0829; Fri, 23 Sep 2022 08:52:59 -0700 (PDT)
Date:   Fri, 23 Sep 2022 08:52:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <oliver.sang@intel.com>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        RCU Mailing List <rcu@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: Fwd: [printk] e695fbe780: BUG:scheduling_while_atomic
Message-ID: <20220923155259.GS4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202209231537.b9d509b-oliver.sang@intel.com>
 <bd8c1740-cd8b-a4ad-445d-c3db4f28bc6f@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd8c1740-cd8b-a4ad-445d-c3db4f28bc6f@gnuweeb.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 09:15:18PM +0700, Ammar Faizi wrote:
> 
> 
> -------- Forwarded Message --------
> Subject: [printk]  e695fbe780: BUG:scheduling_while_atomic
> Date: Fri, 23 Sep 2022 16:02:58 +0800
> From: kernel test robot <oliver.sang@intel.com>
> To: Ammar Faizi <ammarfaizi2@gnuweeb.org>, GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
> CC: lkp@lists.01.org, lkp@intel.com
> 
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: e695fbe780f429298dca1fd826601968b5d00200 ("printk: Prepare for SCRU console list protection")
> https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/printk.2022.09.11a

Just in case there is any confusion, this commit is in a not-for-mainline
branch used only for my testing.  Yes, I do use -rcu to communicate code
to my test systems.  ;-)

							Thanx, Paul

> in testcase: boot
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +-----------------------------+------------+------------+
> |                             | c522626383 | e695fbe780 |
> +-----------------------------+------------+------------+
> | boot_successes              | 12         | 0          |
> | boot_failures               | 0          | 16         |
> | BUG:scheduling_while_atomic | 0          | 16         |
> +-----------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Link: https://lore.kernel.org/r/202209231537.b9d509b-oliver.sang@intel.com
> 
> 
> [    0.326642][    T0] printk: console [tty0] enabled
> [    0.327777][    T0] printk: console [ttyS0] enabled
> [    0.329795][    T0] printk: bootconsole [earlyser0] disabled
> [    0.332327][    T0] BUG: scheduling while atomic: swapper/0/0x00000002
> [    0.333877][    T0] Modules linked in:
> [    0.335157][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-rc1-00138-ge695fbe780f4 #1
> [    0.337196][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> [    0.343745][    T0] Call Trace:
> [    0.344608][    T0]  ? show_stack+0x33/0x39
> [    0.345628][    T0]  dump_stack_lvl+0x20/0x2a
> [    0.346859][    T0]  dump_stack+0xd/0x10
> [    0.347869][    T0]  __schedule_bug.cold+0x56/0x66
> [    0.349104][    T0]  __schedule+0x3df/0x4d0
> [    0.350260][    T0]  ? prb_read+0x78/0x1c0
> [    0.351334][    T0]  schedule+0x52/0xd0
> [    0.352362][    T0]  schedule_timeout+0x8d/0xd0
> [    0.353504][    T0]  ? __might_sleep+0x2f/0x90
> [    0.354723][    T0]  __wait_for_common+0x8b/0x190
> [    0.355826][    T0]  ? usleep_range_state+0xc0/0xc0
> [    0.357005][    T0]  wait_for_completion+0x1c/0x20
> [    0.358239][    T0]  synchronize_srcu+0x5e/0x80
> [    0.359453][    T0]  ? get_completed_synchronize_rcu+0x10/0x10
> [    0.360879][    T0]  console_unregister_locked+0x8b/0xa5
> [    0.362247][    T0]  register_console.cold+0x5f/0x6c
> [    0.363569][    T0]  univ8250_console_init+0x1b/0x25
> [    0.364813][    T0]  console_init+0x1f/0x24
> [    0.365865][    T0]  start_kernel+0x2b9/0x3bb
> [    0.367072][    T0]  i386_start_kernel+0x42/0x44
> [    0.385824][    T0]  startup_32_smp+0x161/0x164
> 
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-6.0.0-rc1-00138-ge695fbe780f4 .config
> 	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
> 	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> 
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
> 
> 

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/i386 6.0.0-rc1 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-5) 11.3.0"
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=110300
> CONFIG_CLANG_VERSION=0
> CONFIG_AS_IS_GNU=y
> CONFIG_AS_VERSION=23890
> CONFIG_LD_IS_BFD=y
> CONFIG_LD_VERSION=23890
> CONFIG_LLD_VERSION=0
> CONFIG_CC_CAN_LINK=y
> CONFIG_CC_CAN_LINK_STATIC=y
> CONFIG_CC_HAS_ASM_GOTO=y
> CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
> CONFIG_CC_HAS_ASM_INLINE=y
> CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
> CONFIG_PAHOLE_VERSION=123
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_TABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_BROKEN_ON_SMP=y
> CONFIG_INIT_ENV_ARG_LIMIT=32
> # CONFIG_COMPILE_TEST is not set
> # CONFIG_WERROR is not set
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_BUILD_SALT=""
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_BZIP2=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> CONFIG_HAVE_KERNEL_ZSTD=y
> CONFIG_KERNEL_GZIP=y
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> # CONFIG_KERNEL_ZSTD is not set
> CONFIG_DEFAULT_INIT=""
> CONFIG_DEFAULT_HOSTNAME="(none)"
> # CONFIG_SYSVIPC is not set
> # CONFIG_POSIX_MQUEUE is not set
> # CONFIG_WATCH_QUEUE is not set
> CONFIG_CROSS_MEMORY_ATTACH=y
> # CONFIG_USELIB is not set
> # CONFIG_AUDIT is not set
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_HARDIRQS_SW_RESEND=y
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> # end of IRQ subsystem
> 
> CONFIG_CLOCKSOURCE_WATCHDOG=y
> CONFIG_ARCH_CLOCKSOURCE_INIT=y
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
> CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
> 
> #
> # Timers subsystem
> #
> CONFIG_HZ_PERIODIC=y
> # CONFIG_NO_HZ_IDLE is not set
> # CONFIG_NO_HZ is not set
> # CONFIG_HIGH_RES_TIMERS is not set
> CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
> # end of Timers subsystem
> 
> CONFIG_BPF=y
> CONFIG_HAVE_EBPF_JIT=y
> 
> #
> # BPF subsystem
> #
> # CONFIG_BPF_SYSCALL is not set
> # CONFIG_BPF_JIT is not set
> # end of BPF subsystem
> 
> CONFIG_PREEMPT_VOLUNTARY_BUILD=y
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_COUNT=y
> # CONFIG_PREEMPT_DYNAMIC is not set
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_TICK_CPU_ACCOUNTING=y
> # CONFIG_IRQ_TIME_ACCOUNTING is not set
> # CONFIG_BSD_PROCESS_ACCT is not set
> # CONFIG_TASKSTATS is not set
> # CONFIG_PSI is not set
> # end of CPU/Task time and stats accounting
> 
> #
> # RCU Subsystem
> #
> CONFIG_TINY_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=y
> CONFIG_TINY_SRCU=y
> # end of RCU Subsystem
> 
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> # CONFIG_IKHEADERS is not set
> CONFIG_LOG_BUF_SHIFT=20
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> # CONFIG_PRINTK_INDEX is not set
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> 
> #
> # Scheduler features
> #
> # end of Scheduler features
> 
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
> CONFIG_GCC12_NO_ARRAY_BOUNDS=y
> CONFIG_CGROUPS=y
> # CONFIG_CGROUP_FAVOR_DYNMODS is not set
> # CONFIG_MEMCG is not set
> # CONFIG_BLK_CGROUP is not set
> # CONFIG_CGROUP_SCHED is not set
> # CONFIG_CGROUP_PIDS is not set
> # CONFIG_CGROUP_RDMA is not set
> # CONFIG_CGROUP_FREEZER is not set
> # CONFIG_CGROUP_DEVICE is not set
> # CONFIG_CGROUP_CPUACCT is not set
> # CONFIG_CGROUP_PERF is not set
> # CONFIG_CGROUP_MISC is not set
> # CONFIG_CGROUP_DEBUG is not set
> CONFIG_NAMESPACES=y
> CONFIG_UTS_NS=y
> CONFIG_TIME_NS=y
> # CONFIG_USER_NS is not set
> CONFIG_PID_NS=y
> CONFIG_NET_NS=y
> # CONFIG_CHECKPOINT_RESTORE is not set
> # CONFIG_SCHED_AUTOGROUP is not set
> # CONFIG_SYSFS_DEPRECATED is not set
> # CONFIG_RELAY is not set
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_RD_GZIP=y
> CONFIG_RD_BZIP2=y
> CONFIG_RD_LZMA=y
> CONFIG_RD_XZ=y
> CONFIG_RD_LZO=y
> CONFIG_RD_LZ4=y
> CONFIG_RD_ZSTD=y
> # CONFIG_BOOT_CONFIG is not set
> CONFIG_INITRAMFS_PRESERVE_MTIME=y
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_LD_ORPHAN_WARN=y
> CONFIG_SYSCTL=y
> CONFIG_HAVE_UID16=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_HAVE_PCSPKR_PLATFORM=y
> # CONFIG_EXPERT is not set
> CONFIG_UID16=y
> CONFIG_MULTIUSER=y
> CONFIG_SGETMASK_SYSCALL=y
> CONFIG_SYSFS_SYSCALL=y
> CONFIG_FHANDLE=y
> CONFIG_POSIX_TIMERS=y
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_PCSPKR_PLATFORM=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> CONFIG_IO_URING=y
> CONFIG_ADVISE_SYSCALLS=y
> CONFIG_MEMBARRIER=y
> CONFIG_KALLSYMS=y
> # CONFIG_KALLSYMS_ALL is not set
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> CONFIG_RSEQ=y
> # CONFIG_EMBEDDED is not set
> CONFIG_HAVE_PERF_EVENTS=y
> 
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> # end of Kernel Performance Events And Counters
> 
> # CONFIG_PROFILING is not set
> # end of General setup
> 
> CONFIG_X86_32=y
> CONFIG_X86=y
> CONFIG_INSTRUCTION_DECODER=y
> CONFIG_OUTPUT_FORMAT="elf32-i386"
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_MMU=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_BITS_MAX=16
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_BUG=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_ARCH_HAS_CPU_RELAX=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_ARCH_NR_GPIO=512
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_PGTABLE_LEVELS=2
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> 
> #
> # Processor type and features
> #
> # CONFIG_SMP is not set
> CONFIG_X86_FEATURE_NAMES=y
> # CONFIG_GOLDFISH is not set
> # CONFIG_X86_CPU_RESCTRL is not set
> CONFIG_X86_EXTENDED_PLATFORM=y
> # CONFIG_X86_GOLDFISH is not set
> # CONFIG_X86_INTEL_LPSS is not set
> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> # CONFIG_IOSF_MBI is not set
> # CONFIG_X86_RDC321X is not set
> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
> # CONFIG_X86_32_IRIS is not set
> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_PARAVIRT=y
> # CONFIG_PARAVIRT_DEBUG is not set
> CONFIG_X86_HV_CALLBACK_VECTOR=y
> CONFIG_KVM_GUEST=y
> CONFIG_ARCH_CPUIDLE_HALTPOLL=y
> # CONFIG_PVH is not set
> # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> CONFIG_PARAVIRT_CLOCK=y
> # CONFIG_M486SX is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> CONFIG_M686=y
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUMM is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MEFFICEON is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MELAN is not set
> # CONFIG_MGEODEGX1 is not set
> # CONFIG_MGEODE_LX is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> # CONFIG_MVIAC7 is not set
> # CONFIG_MCORE2 is not set
> # CONFIG_MATOM is not set
> # CONFIG_X86_GENERIC is not set
> CONFIG_X86_INTERNODE_CACHE_SHIFT=5
> CONFIG_X86_L1_CACHE_SHIFT=5
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_X86_TSC=y
> CONFIG_X86_CMPXCHG64=y
> CONFIG_X86_CMOV=y
> CONFIG_X86_MINIMUM_CPU_FAMILY=6
> CONFIG_X86_DEBUGCTLMSR=y
> CONFIG_IA32_FEAT_CTL=y
> CONFIG_X86_VMX_FEATURE_NAMES=y
> CONFIG_CPU_SUP_INTEL=y
> CONFIG_CPU_SUP_AMD=y
> CONFIG_CPU_SUP_HYGON=y
> CONFIG_CPU_SUP_CENTAUR=y
> CONFIG_CPU_SUP_TRANSMETA_32=y
> CONFIG_CPU_SUP_ZHAOXIN=y
> CONFIG_CPU_SUP_VORTEX_32=y
> CONFIG_HPET_TIMER=y
> CONFIG_DMI=y
> CONFIG_NR_CPUS_RANGE_BEGIN=1
> CONFIG_NR_CPUS_RANGE_END=1
> CONFIG_NR_CPUS_DEFAULT=1
> CONFIG_NR_CPUS=1
> # CONFIG_X86_UP_APIC is not set
> CONFIG_X86_MCE=y
> # CONFIG_X86_MCELOG_LEGACY is not set
> # CONFIG_X86_ANCIENT_MCE is not set
> 
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> CONFIG_PERF_EVENTS_INTEL_RAPL=y
> CONFIG_PERF_EVENTS_INTEL_CSTATE=y
> # CONFIG_PERF_EVENTS_AMD_POWER is not set
> # CONFIG_PERF_EVENTS_AMD_UNCORE is not set
> # CONFIG_PERF_EVENTS_AMD_BRS is not set
> # end of Performance monitoring
> 
> # CONFIG_X86_LEGACY_VM86 is not set
> CONFIG_X86_16BIT=y
> CONFIG_X86_ESPFIX32=y
> CONFIG_X86_IOPL_IOPERM=y
> # CONFIG_TOSHIBA is not set
> # CONFIG_X86_REBOOTFIXUPS is not set
> CONFIG_MICROCODE=y
> CONFIG_MICROCODE_INTEL=y
> # CONFIG_MICROCODE_AMD is not set
> # CONFIG_MICROCODE_LATE_LOADING is not set
> # CONFIG_X86_MSR is not set
> # CONFIG_X86_CPUID is not set
> # CONFIG_NOHIGHMEM is not set
> CONFIG_HIGHMEM4G=y
> # CONFIG_HIGHMEM64G is not set
> CONFIG_PAGE_OFFSET=0xC0000000
> CONFIG_HIGHMEM=y
> # CONFIG_X86_CPA_STATISTICS is not set
> CONFIG_ARCH_FLATMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> CONFIG_ILLEGAL_POINTER_VALUE=0
> # CONFIG_HIGHPTE is not set
> # CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
> CONFIG_MTRR=y
> CONFIG_MTRR_SANITIZER=y
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
> CONFIG_X86_PAT=y
> CONFIG_ARCH_USES_PG_UNCACHED=y
> CONFIG_X86_UMIP=y
> CONFIG_CC_HAS_IBT=y
> CONFIG_X86_INTEL_TSX_MODE_OFF=y
> # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> # CONFIG_EFI is not set
> # CONFIG_HZ_100 is not set
> CONFIG_HZ_250=y
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=250
> # CONFIG_KEXEC is not set
> # CONFIG_CRASH_DUMP is not set
> CONFIG_PHYSICAL_START=0x1000000
> CONFIG_RELOCATABLE=y
> # CONFIG_RANDOMIZE_BASE is not set
> CONFIG_X86_NEED_RELOCS=y
> CONFIG_PHYSICAL_ALIGN=0x200000
> # CONFIG_COMPAT_VDSO is not set
> # CONFIG_CMDLINE_BOOL is not set
> CONFIG_MODIFY_LDT_SYSCALL=y
> # CONFIG_STRICT_SIGALTSTACK_SIZE is not set
> # end of Processor type and features
> 
> CONFIG_CC_HAS_SLS=y
> CONFIG_CC_HAS_RETURN_THUNK=y
> CONFIG_SPECULATION_MITIGATIONS=y
> CONFIG_RETPOLINE=y
> # CONFIG_RETHUNK is not set
> CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
> 
> #
> # Power management and ACPI options
> #
> CONFIG_SUSPEND=y
> CONFIG_SUSPEND_FREEZER=y
> # CONFIG_HIBERNATION is not set
> CONFIG_PM_SLEEP=y
> # CONFIG_PM_AUTOSLEEP is not set
> # CONFIG_PM_USERSPACE_AUTOSLEEP is not set
> # CONFIG_PM_WAKELOCKS is not set
> CONFIG_PM=y
> # CONFIG_PM_DEBUG is not set
> # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> CONFIG_ARCH_SUPPORTS_ACPI=y
> CONFIG_ACPI=y
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> # CONFIG_ACPI_DEBUGGER is not set
> CONFIG_ACPI_SPCR_TABLE=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> # CONFIG_ACPI_EC_DEBUGFS is not set
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_FAN=y
> # CONFIG_ACPI_TAD is not set
> # CONFIG_ACPI_DOCK is not set
> CONFIG_ACPI_CPU_FREQ_PSS=y
> CONFIG_ACPI_PROCESSOR_CSTATE=y
> CONFIG_ACPI_PROCESSOR_IDLE=y
> CONFIG_ACPI_PROCESSOR=y
> # CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
> CONFIG_ACPI_THERMAL=y
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_TABLE_UPGRADE=y
> # CONFIG_ACPI_DEBUG is not set
> # CONFIG_ACPI_PCI_SLOT is not set
> # CONFIG_ACPI_CONTAINER is not set
> # CONFIG_ACPI_SBS is not set
> # CONFIG_ACPI_HED is not set
> # CONFIG_ACPI_CUSTOM_METHOD is not set
> CONFIG_HAVE_ACPI_APEI=y
> CONFIG_HAVE_ACPI_APEI_NMI=y
> # CONFIG_ACPI_APEI is not set
> # CONFIG_ACPI_DPTF is not set
> # CONFIG_ACPI_CONFIGFS is not set
> # CONFIG_PMIC_OPREGION is not set
> CONFIG_X86_PM_TIMER=y
> # CONFIG_APM is not set
> 
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
> # end of CPU Frequency scaling
> 
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> CONFIG_CPU_IDLE_GOV_LADDER=y
> # CONFIG_CPU_IDLE_GOV_MENU is not set
> # CONFIG_CPU_IDLE_GOV_TEO is not set
> # CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
> CONFIG_HALTPOLL_CPUIDLE=y
> # end of CPU Idle
> 
> # CONFIG_INTEL_IDLE is not set
> # end of Power management and ACPI options
> 
> #
> # Bus options (PCI etc.)
> #
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GOMMCONFIG is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> CONFIG_ISA_DMA_API=y
> # CONFIG_ISA is not set
> # CONFIG_SCx200 is not set
> # CONFIG_OLPC is not set
> # CONFIG_ALIX is not set
> # CONFIG_NET5501 is not set
> # CONFIG_GEOS is not set
> CONFIG_AMD_NB=y
> # end of Bus options (PCI etc.)
> 
> #
> # Binary Emulations
> #
> CONFIG_COMPAT_32=y
> # end of Binary Emulations
> 
> CONFIG_HAVE_ATOMIC_IOMAP=y
> CONFIG_HAVE_KVM=y
> CONFIG_VIRTUALIZATION=y
> CONFIG_AS_AVX512=y
> CONFIG_AS_SHA1_NI=y
> CONFIG_AS_SHA256_NI=y
> CONFIG_AS_TPAUSE=y
> 
> #
> # General architecture-dependent options
> #
> CONFIG_GENERIC_ENTRY=y
> # CONFIG_KPROBES is not set
> # CONFIG_JUMP_LABEL is not set
> # CONFIG_STATIC_CALL_SELFTEST is not set
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_OPTPROBES=y
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_HAVE_NMI=y
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> CONFIG_ARCH_WANTS_NO_INSTR=y
> CONFIG_ARCH_32BIT_OFF_T=y
> CONFIG_HAVE_ASM_MODVERSIONS=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_RSEQ=y
> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
> CONFIG_MMU_GATHER_TABLE_FREE=y
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> CONFIG_MMU_GATHER_MERGE_VMAS=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
> CONFIG_HAVE_CMPXCHG_LOCAL=y
> CONFIG_HAVE_CMPXCHG_DOUBLE=y
> CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
> CONFIG_HAVE_ARCH_SECCOMP=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_SECCOMP=y
> CONFIG_SECCOMP_FILTER=y
> # CONFIG_SECCOMP_CACHE_DEBUG is not set
> CONFIG_HAVE_ARCH_STACKLEAK=y
> CONFIG_HAVE_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR_STRONG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
> CONFIG_LTO_NONE=y
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_MOVE_PUD=y
> CONFIG_HAVE_MOVE_PMD=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_REL=y
> CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_ARCH_MMAP_RND_BITS=8
> CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
> CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
> CONFIG_CLONE_BACKWARDS=y
> CONFIG_OLD_SIGSUSPEND3=y
> CONFIG_OLD_SIGACTION=y
> CONFIG_COMPAT_32BIT_TIME=y
> CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
> CONFIG_RANDOMIZE_KSTACK_OFFSET=y
> # CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> CONFIG_STRICT_KERNEL_RWX=y
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> CONFIG_STRICT_MODULE_RWX=y
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
> # CONFIG_LOCK_EVENT_COUNTS is not set
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> CONFIG_HAVE_STATIC_CALL=y
> CONFIG_HAVE_PREEMPT_DYNAMIC=y
> CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
> CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_ARCH_SPLIT_ARG64=y
> CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
> CONFIG_DYNAMIC_SIGFRAME=y
> 
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> # end of GCOV-based kernel profiling
> 
> CONFIG_HAVE_GCC_PLUGINS=y
> CONFIG_GCC_PLUGINS=y
> # CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
> # end of General architecture-dependent options
> 
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> CONFIG_MODULES=y
> # CONFIG_MODULE_FORCE_LOAD is not set
> # CONFIG_MODULE_UNLOAD is not set
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> # CONFIG_MODULE_SIG is not set
> CONFIG_MODULE_COMPRESS_NONE=y
> # CONFIG_MODULE_COMPRESS_GZIP is not set
> # CONFIG_MODULE_COMPRESS_XZ is not set
> # CONFIG_MODULE_COMPRESS_ZSTD is not set
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_MODPROBE_PATH="/sbin/modprobe"
> CONFIG_MODULES_TREE_LOOKUP=y
> CONFIG_BLOCK=y
> CONFIG_BLOCK_LEGACY_AUTOLOAD=y
> # CONFIG_BLK_DEV_BSGLIB is not set
> # CONFIG_BLK_DEV_INTEGRITY is not set
> # CONFIG_BLK_DEV_ZONED is not set
> # CONFIG_BLK_WBT is not set
> CONFIG_BLK_DEBUG_FS=y
> # CONFIG_BLK_SED_OPAL is not set
> # CONFIG_BLK_INLINE_ENCRYPTION is not set
> 
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
> CONFIG_EFI_PARTITION=y
> # end of Partition Types
> 
> CONFIG_BLK_MQ_PCI=y
> CONFIG_BLK_PM=y
> 
> #
> # IO Schedulers
> #
> CONFIG_MQ_IOSCHED_DEADLINE=y
> CONFIG_MQ_IOSCHED_KYBER=y
> # CONFIG_IOSCHED_BFQ is not set
> # end of IO Schedulers
> 
> CONFIG_ASN1=m
> CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
> CONFIG_INLINE_READ_UNLOCK=y
> CONFIG_INLINE_READ_UNLOCK_IRQ=y
> CONFIG_INLINE_WRITE_UNLOCK=y
> CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> CONFIG_FREEZER=y
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_ELFCORE=y
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
> CONFIG_BINFMT_SCRIPT=y
> # CONFIG_BINFMT_MISC is not set
> CONFIG_COREDUMP=y
> # end of Executable file formats
> 
> #
> # Memory Management options
> #
> CONFIG_SWAP=y
> # CONFIG_ZSWAP is not set
> 
> #
> # SLAB allocator options
> #
> # CONFIG_SLAB is not set
> CONFIG_SLUB=y
> CONFIG_SLAB_MERGE_DEFAULT=y
> # CONFIG_SLAB_FREELIST_RANDOM is not set
> # CONFIG_SLAB_FREELIST_HARDENED is not set
> # CONFIG_SLUB_STATS is not set
> # end of SLAB allocator options
> 
> # CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
> CONFIG_COMPAT_BRK=y
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_FLATMEM_MANUAL=y
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_FLATMEM=y
> CONFIG_SPARSEMEM_STATIC=y
> CONFIG_HAVE_FAST_GUP=y
> CONFIG_EXCLUSIVE_SYSTEM_RAM=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_COMPACTION=y
> # CONFIG_PAGE_REPORTING is not set
> CONFIG_MIGRATION=y
> CONFIG_BOUNCE=y
> # CONFIG_KSM is not set
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
> # CONFIG_MEMORY_FAILURE is not set
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> # CONFIG_TRANSPARENT_HUGEPAGE is not set
> CONFIG_NEED_PER_CPU_KM=y
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> # CONFIG_CMA is not set
> CONFIG_GENERIC_EARLY_IOREMAP=y
> # CONFIG_IDLE_PAGE_TRACKING is not set
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
> CONFIG_ZONE_DMA=y
> CONFIG_VM_EVENT_COUNTERS=y
> # CONFIG_PERCPU_STATS is not set
> # CONFIG_GUP_TEST is not set
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> CONFIG_KMAP_LOCAL=y
> CONFIG_SECRETMEM=y
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
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> # CONFIG_PACKET is not set
> CONFIG_UNIX=y
> CONFIG_UNIX_SCM=y
> CONFIG_AF_UNIX_OOB=y
> # CONFIG_UNIX_DIAG is not set
> # CONFIG_TLS is not set
> # CONFIG_XFRM_USER is not set
> # CONFIG_NET_KEY is not set
> CONFIG_INET=y
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> # CONFIG_IP_PNP_BOOTP is not set
> # CONFIG_IP_PNP_RARP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE_DEMUX is not set
> CONFIG_NET_IP_TUNNEL=y
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_NET_IPVTI is not set
> # CONFIG_NET_FOU is not set
> # CONFIG_NET_FOU_IP_TUNNELS is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> CONFIG_INET_TUNNEL=y
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> # CONFIG_INET_UDP_DIAG is not set
> # CONFIG_INET_RAW_DIAG is not set
> # CONFIG_INET_DIAG_DESTROY is not set
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_DEFAULT_TCP_CONG="cubic"
> # CONFIG_TCP_MD5SIG is not set
> CONFIG_IPV6=y
> # CONFIG_IPV6_ROUTER_PREF is not set
> # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> # CONFIG_INET6_AH is not set
> # CONFIG_INET6_ESP is not set
> # CONFIG_INET6_IPCOMP is not set
> # CONFIG_IPV6_MIP6 is not set
> # CONFIG_IPV6_VTI is not set
> CONFIG_IPV6_SIT=y
> # CONFIG_IPV6_SIT_6RD is not set
> CONFIG_IPV6_NDISC_NODETYPE=y
> # CONFIG_IPV6_TUNNEL is not set
> # CONFIG_IPV6_MULTIPLE_TABLES is not set
> # CONFIG_IPV6_MROUTE is not set
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> # CONFIG_IPV6_SEG6_HMAC is not set
> # CONFIG_IPV6_RPL_LWTUNNEL is not set
> # CONFIG_IPV6_IOAM6_LWTUNNEL is not set
> # CONFIG_MPTCP is not set
> # CONFIG_NETWORK_SECMARK is not set
> CONFIG_NET_PTP_CLASSIFY=y
> # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> # CONFIG_NETFILTER is not set
> # CONFIG_BPFILTER is not set
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
> # CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_L2TP is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_NET_DSA is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_PHONET is not set
> # CONFIG_6LOWPAN is not set
> # CONFIG_IEEE802154 is not set
> # CONFIG_NET_SCHED is not set
> # CONFIG_DCB is not set
> CONFIG_DNS_RESOLVER=m
> # CONFIG_BATMAN_ADV is not set
> # CONFIG_OPENVSWITCH is not set
> # CONFIG_VSOCKETS is not set
> # CONFIG_NETLINK_DIAG is not set
> # CONFIG_MPLS is not set
> # CONFIG_NET_NSH is not set
> # CONFIG_HSR is not set
> # CONFIG_NET_SWITCHDEV is not set
> # CONFIG_NET_L3_MASTER_DEV is not set
> # CONFIG_QRTR is not set
> # CONFIG_NET_NCSI is not set
> # CONFIG_CGROUP_NET_PRIO is not set
> # CONFIG_CGROUP_NET_CLASSID is not set
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # end of Network testing
> # end of Networking options
> 
> # CONFIG_HAMRADIO is not set
> # CONFIG_CAN is not set
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
> # CONFIG_AF_KCM is not set
> # CONFIG_MCTP is not set
> CONFIG_WIRELESS=y
> # CONFIG_CFG80211 is not set
> 
> #
> # CFG80211 needs to be enabled for MAC80211
> #
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> # CONFIG_RFKILL is not set
> CONFIG_NET_9P=y
> CONFIG_NET_9P_FD=y
> # CONFIG_NET_9P_DEBUG is not set
> # CONFIG_CAIF is not set
> # CONFIG_CEPH_LIB is not set
> # CONFIG_NFC is not set
> # CONFIG_PSAMPLE is not set
> # CONFIG_NET_IFE is not set
> # CONFIG_LWTUNNEL is not set
> CONFIG_DST_CACHE=y
> CONFIG_GRO_CELLS=y
> # CONFIG_FAILOVER is not set
> CONFIG_ETHTOOL_NETLINK=y
> 
> #
> # Device Drivers
> #
> CONFIG_HAVE_EISA=y
> # CONFIG_EISA is not set
> CONFIG_HAVE_PCI=y
> CONFIG_PCI=y
> CONFIG_PCI_DOMAINS=y
> # CONFIG_PCIEPORTBUS is not set
> CONFIG_PCIEASPM=y
> CONFIG_PCIEASPM_DEFAULT=y
> # CONFIG_PCIEASPM_POWERSAVE is not set
> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> # CONFIG_PCIE_PTM is not set
> # CONFIG_PCI_MSI is not set
> CONFIG_PCI_QUIRKS=y
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_STUB is not set
> CONFIG_PCI_LOCKLESS_CONFIG=y
> # CONFIG_PCI_IOV is not set
> # CONFIG_PCI_PRI is not set
> # CONFIG_PCI_PASID is not set
> CONFIG_PCI_LABEL=y
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=16
> # CONFIG_HOTPLUG_PCI is not set
> 
> #
> # PCI controller drivers
> #
> 
> #
> # DesignWare PCI Core Support
> #
> # end of DesignWare PCI Core Support
> 
> #
> # Mobiveil PCIe Core Support
> #
> # end of Mobiveil PCIe Core Support
> 
> #
> # Cadence PCIe controllers support
> #
> # end of Cadence PCIe controllers support
> # end of PCI controller drivers
> 
> #
> # PCI Endpoint
> #
> # CONFIG_PCI_ENDPOINT is not set
> # end of PCI Endpoint
> 
> #
> # PCI switch controller drivers
> #
> # CONFIG_PCI_SW_SWITCHTEC is not set
> # end of PCI switch controller drivers
> 
> # CONFIG_CXL_BUS is not set
> # CONFIG_PCCARD is not set
> # CONFIG_RAPIDIO is not set
> 
> #
> # Generic Driver Options
> #
> # CONFIG_UEVENT_HELPER is not set
> CONFIG_DEVTMPFS=y
> # CONFIG_DEVTMPFS_MOUNT is not set
> # CONFIG_DEVTMPFS_SAFE is not set
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_EXTRA_FIRMWARE=""
> # CONFIG_FW_LOADER_USER_HELPER is not set
> # CONFIG_FW_LOADER_COMPRESS is not set
> CONFIG_FW_CACHE=y
> # CONFIG_FW_UPLOAD is not set
> # end of Firmware loader
> 
> CONFIG_ALLOW_DEV_COREDUMP=y
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_GENERIC_CPU_VULNERABILITIES=y
> # end of Generic Driver Options
> 
> #
> # Bus devices
> #
> # CONFIG_MHI_BUS is not set
> # CONFIG_MHI_BUS_EP is not set
> # end of Bus devices
> 
> # CONFIG_CONNECTOR is not set
> 
> #
> # Firmware Drivers
> #
> 
> #
> # ARM System Control and Management Interface Protocol
> #
> # end of ARM System Control and Management Interface Protocol
> 
> # CONFIG_EDD is not set
> CONFIG_FIRMWARE_MEMMAP=y
> CONFIG_DMIID=y
> # CONFIG_DMI_SYSFS is not set
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> # CONFIG_FW_CFG_SYSFS is not set
> # CONFIG_SYSFB_SIMPLEFB is not set
> # CONFIG_GOOGLE_FIRMWARE is not set
> 
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
> 
> # CONFIG_GNSS is not set
> # CONFIG_MTD is not set
> # CONFIG_OF is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> # CONFIG_PARPORT is not set
> CONFIG_PNP=y
> CONFIG_PNP_DEBUG_MESSAGES=y
> 
> #
> # Protocols
> #
> CONFIG_PNPACPI=y
> CONFIG_BLK_DEV=y
> # CONFIG_BLK_DEV_NULL_BLK is not set
> # CONFIG_BLK_DEV_FD is not set
> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> # CONFIG_BLK_DEV_LOOP is not set
> # CONFIG_BLK_DEV_DRBD is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_ATA_OVER_ETH is not set
> # CONFIG_BLK_DEV_RBD is not set
> # CONFIG_BLK_DEV_UBLK is not set
> 
> #
> # NVME Support
> #
> # CONFIG_BLK_DEV_NVME is not set
> # CONFIG_NVME_FC is not set
> # CONFIG_NVME_TCP is not set
> # end of NVME Support
> 
> #
> # Misc devices
> #
> # CONFIG_DUMMY_IRQ is not set
> # CONFIG_IBM_ASM is not set
> # CONFIG_PHANTOM is not set
> # CONFIG_TIFM_CORE is not set
> # CONFIG_ENCLOSURE_SERVICES is not set
> # CONFIG_HP_ILO is not set
> # CONFIG_PCH_PHUB is not set
> # CONFIG_SRAM is not set
> # CONFIG_DW_XDATA_PCIE is not set
> # CONFIG_PCI_ENDPOINT_TEST is not set
> # CONFIG_XILINX_SDFEC is not set
> # CONFIG_C2PORT is not set
> 
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_93CX6 is not set
> # end of EEPROM support
> 
> # CONFIG_CB710_CORE is not set
> 
> #
> # Texas Instruments shared transport line discipline
> #
> # end of Texas Instruments shared transport line discipline
> 
> #
> # Altera FPGA firmware download module (requires I2C)
> #
> # CONFIG_INTEL_MEI is not set
> # CONFIG_INTEL_MEI_ME is not set
> # CONFIG_INTEL_MEI_TXE is not set
> # CONFIG_VMWARE_VMCI is not set
> # CONFIG_ECHO is not set
> # CONFIG_MISC_ALCOR_PCI is not set
> # CONFIG_MISC_RTSX_PCI is not set
> # CONFIG_HABANA_AI is not set
> # CONFIG_PVPANIC is not set
> # end of Misc devices
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> # CONFIG_RAID_ATTRS is not set
> # CONFIG_SCSI is not set
> # end of SCSI device support
> 
> # CONFIG_ATA is not set
> # CONFIG_MD is not set
> # CONFIG_TARGET_CORE is not set
> # CONFIG_FUSION is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_FIREWIRE is not set
> # CONFIG_FIREWIRE_NOSY is not set
> # end of IEEE 1394 (FireWire) support
> 
> # CONFIG_MACINTOSH_DRIVERS is not set
> CONFIG_NETDEVICES=y
> CONFIG_NET_CORE=y
> # CONFIG_BONDING is not set
> # CONFIG_DUMMY is not set
> # CONFIG_WIREGUARD is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_NET_TEAM is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_IPVLAN is not set
> # CONFIG_VXLAN is not set
> # CONFIG_GENEVE is not set
> # CONFIG_BAREUDP is not set
> # CONFIG_GTP is not set
> # CONFIG_MACSEC is not set
> # CONFIG_NETCONSOLE is not set
> # CONFIG_TUN is not set
> # CONFIG_TUN_VNET_CROSS_LE is not set
> # CONFIG_VETH is not set
> # CONFIG_NLMON is not set
> # CONFIG_ARCNET is not set
> CONFIG_ETHERNET=y
> CONFIG_NET_VENDOR_3COM=y
> # CONFIG_VORTEX is not set
> # CONFIG_TYPHOON is not set
> CONFIG_NET_VENDOR_ADAPTEC=y
> # CONFIG_ADAPTEC_STARFIRE is not set
> CONFIG_NET_VENDOR_AGERE=y
> # CONFIG_ET131X is not set
> CONFIG_NET_VENDOR_ALACRITECH=y
> # CONFIG_SLICOSS is not set
> CONFIG_NET_VENDOR_ALTEON=y
> # CONFIG_ACENIC is not set
> # CONFIG_ALTERA_TSE is not set
> CONFIG_NET_VENDOR_AMAZON=y
> # CONFIG_NET_VENDOR_AMD is not set
> CONFIG_NET_VENDOR_AQUANTIA=y
> # CONFIG_AQTION is not set
> CONFIG_NET_VENDOR_ARC=y
> CONFIG_NET_VENDOR_ASIX=y
> CONFIG_NET_VENDOR_ATHEROS=y
> # CONFIG_ATL2 is not set
> # CONFIG_ATL1 is not set
> # CONFIG_ATL1E is not set
> # CONFIG_ATL1C is not set
> # CONFIG_ALX is not set
> # CONFIG_CX_ECAT is not set
> CONFIG_NET_VENDOR_BROADCOM=y
> # CONFIG_B44 is not set
> # CONFIG_BCMGENET is not set
> # CONFIG_BNX2 is not set
> # CONFIG_CNIC is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_BNX2X is not set
> # CONFIG_SYSTEMPORT is not set
> # CONFIG_BNXT is not set
> CONFIG_NET_VENDOR_CADENCE=y
> CONFIG_NET_VENDOR_CAVIUM=y
> CONFIG_NET_VENDOR_CHELSIO=y
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_CHELSIO_T3 is not set
> # CONFIG_CHELSIO_T4 is not set
> # CONFIG_CHELSIO_T4VF is not set
> CONFIG_NET_VENDOR_CISCO=y
> # CONFIG_ENIC is not set
> CONFIG_NET_VENDOR_CORTINA=y
> CONFIG_NET_VENDOR_DAVICOM=y
> # CONFIG_DNET is not set
> CONFIG_NET_VENDOR_DEC=y
> # CONFIG_NET_TULIP is not set
> CONFIG_NET_VENDOR_DLINK=y
> # CONFIG_DL2K is not set
> # CONFIG_SUNDANCE is not set
> CONFIG_NET_VENDOR_EMULEX=y
> # CONFIG_BE2NET is not set
> CONFIG_NET_VENDOR_ENGLEDER=y
> # CONFIG_TSNEP is not set
> CONFIG_NET_VENDOR_EZCHIP=y
> CONFIG_NET_VENDOR_FUNGIBLE=y
> CONFIG_NET_VENDOR_GOOGLE=y
> CONFIG_NET_VENDOR_HUAWEI=y
> CONFIG_NET_VENDOR_I825XX=y
> CONFIG_NET_VENDOR_INTEL=y
> # CONFIG_E100 is not set
> CONFIG_E1000=y
> # CONFIG_E1000E is not set
> # CONFIG_IGB is not set
> # CONFIG_IGBVF is not set
> # CONFIG_IXGB is not set
> # CONFIG_IXGBE is not set
> # CONFIG_I40E is not set
> # CONFIG_IGC is not set
> CONFIG_NET_VENDOR_WANGXUN=y
> # CONFIG_TXGBE is not set
> # CONFIG_JME is not set
> CONFIG_NET_VENDOR_LITEX=y
> CONFIG_NET_VENDOR_MARVELL=y
> # CONFIG_MVMDIO is not set
> # CONFIG_SKGE is not set
> # CONFIG_SKY2 is not set
> CONFIG_NET_VENDOR_MELLANOX=y
> # CONFIG_MLX4_EN is not set
> # CONFIG_MLX5_CORE is not set
> # CONFIG_MLXSW_CORE is not set
> # CONFIG_MLXFW is not set
> CONFIG_NET_VENDOR_MICREL=y
> # CONFIG_KS8851_MLL is not set
> # CONFIG_KSZ884X_PCI is not set
> CONFIG_NET_VENDOR_MICROCHIP=y
> # CONFIG_LAN743X is not set
> CONFIG_NET_VENDOR_MICROSEMI=y
> CONFIG_NET_VENDOR_MICROSOFT=y
> CONFIG_NET_VENDOR_MYRI=y
> # CONFIG_MYRI10GE is not set
> # CONFIG_FEALNX is not set
> CONFIG_NET_VENDOR_NI=y
> # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
> CONFIG_NET_VENDOR_NATSEMI=y
> # CONFIG_NATSEMI is not set
> # CONFIG_NS83820 is not set
> CONFIG_NET_VENDOR_NETERION=y
> # CONFIG_S2IO is not set
> CONFIG_NET_VENDOR_NETRONOME=y
> CONFIG_NET_VENDOR_8390=y
> # CONFIG_NE2K_PCI is not set
> CONFIG_NET_VENDOR_NVIDIA=y
> # CONFIG_FORCEDETH is not set
> CONFIG_NET_VENDOR_OKI=y
> # CONFIG_PCH_GBE is not set
> # CONFIG_ETHOC is not set
> CONFIG_NET_VENDOR_PACKET_ENGINES=y
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> CONFIG_NET_VENDOR_PENSANDO=y
> CONFIG_NET_VENDOR_QLOGIC=y
> # CONFIG_QLA3XXX is not set
> # CONFIG_QLCNIC is not set
> # CONFIG_NETXEN_NIC is not set
> # CONFIG_QED is not set
> CONFIG_NET_VENDOR_BROCADE=y
> # CONFIG_BNA is not set
> CONFIG_NET_VENDOR_QUALCOMM=y
> # CONFIG_QCOM_EMAC is not set
> # CONFIG_RMNET is not set
> CONFIG_NET_VENDOR_RDC=y
> # CONFIG_R6040 is not set
> CONFIG_NET_VENDOR_REALTEK=y
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> # CONFIG_R8169 is not set
> CONFIG_NET_VENDOR_RENESAS=y
> CONFIG_NET_VENDOR_ROCKER=y
> CONFIG_NET_VENDOR_SAMSUNG=y
> # CONFIG_SXGBE_ETH is not set
> CONFIG_NET_VENDOR_SEEQ=y
> CONFIG_NET_VENDOR_SILAN=y
> # CONFIG_SC92031 is not set
> CONFIG_NET_VENDOR_SIS=y
> # CONFIG_SIS900 is not set
> # CONFIG_SIS190 is not set
> CONFIG_NET_VENDOR_SOLARFLARE=y
> # CONFIG_SFC is not set
> # CONFIG_SFC_FALCON is not set
> # CONFIG_SFC_SIENA is not set
> CONFIG_NET_VENDOR_SMSC=y
> # CONFIG_EPIC100 is not set
> # CONFIG_SMSC911X is not set
> # CONFIG_SMSC9420 is not set
> CONFIG_NET_VENDOR_SOCIONEXT=y
> CONFIG_NET_VENDOR_STMICRO=y
> # CONFIG_STMMAC_ETH is not set
> CONFIG_NET_VENDOR_SUN=y
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NIU is not set
> CONFIG_NET_VENDOR_SYNOPSYS=y
> # CONFIG_DWC_XLGMAC is not set
> CONFIG_NET_VENDOR_TEHUTI=y
> # CONFIG_TEHUTI is not set
> CONFIG_NET_VENDOR_TI=y
> # CONFIG_TI_CPSW_PHY_SEL is not set
> # CONFIG_TLAN is not set
> CONFIG_NET_VENDOR_VERTEXCOM=y
> CONFIG_NET_VENDOR_VIA=y
> # CONFIG_VIA_RHINE is not set
> # CONFIG_VIA_VELOCITY is not set
> CONFIG_NET_VENDOR_WIZNET=y
> # CONFIG_WIZNET_W5100 is not set
> # CONFIG_WIZNET_W5300 is not set
> CONFIG_NET_VENDOR_XILINX=y
> # CONFIG_XILINX_EMACLITE is not set
> # CONFIG_XILINX_AXI_EMAC is not set
> # CONFIG_XILINX_LL_TEMAC is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_NET_SB1000 is not set
> # CONFIG_PHYLIB is not set
> # CONFIG_MDIO_DEVICE is not set
> 
> #
> # PCS device drivers
> #
> # end of PCS device drivers
> 
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> 
> #
> # Host-side USB support is needed for USB Network Adapter support
> #
> CONFIG_WLAN=y
> CONFIG_WLAN_VENDOR_ADMTEK=y
> CONFIG_WLAN_VENDOR_ATH=y
> # CONFIG_ATH_DEBUG is not set
> # CONFIG_ATH5K_PCI is not set
> CONFIG_WLAN_VENDOR_ATMEL=y
> CONFIG_WLAN_VENDOR_BROADCOM=y
> CONFIG_WLAN_VENDOR_CISCO=y
> CONFIG_WLAN_VENDOR_INTEL=y
> CONFIG_WLAN_VENDOR_INTERSIL=y
> # CONFIG_HOSTAP is not set
> CONFIG_WLAN_VENDOR_MARVELL=y
> CONFIG_WLAN_VENDOR_MEDIATEK=y
> CONFIG_WLAN_VENDOR_MICROCHIP=y
> CONFIG_WLAN_VENDOR_PURELIFI=y
> CONFIG_WLAN_VENDOR_RALINK=y
> CONFIG_WLAN_VENDOR_REALTEK=y
> CONFIG_WLAN_VENDOR_RSI=y
> CONFIG_WLAN_VENDOR_SILABS=y
> CONFIG_WLAN_VENDOR_ST=y
> CONFIG_WLAN_VENDOR_TI=y
> CONFIG_WLAN_VENDOR_ZYDAS=y
> CONFIG_WLAN_VENDOR_QUANTENNA=y
> # CONFIG_WAN is not set
> 
> #
> # Wireless WAN
> #
> # CONFIG_WWAN is not set
> # end of Wireless WAN
> 
> # CONFIG_VMXNET3 is not set
> # CONFIG_FUJITSU_ES is not set
> # CONFIG_NETDEVSIM is not set
> # CONFIG_NET_FAILOVER is not set
> # CONFIG_ISDN is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> CONFIG_INPUT_FF_MEMLESS=y
> # CONFIG_INPUT_SPARSEKMAP is not set
> # CONFIG_INPUT_MATRIXKMAP is not set
> CONFIG_INPUT_VIVALDIFMAP=y
> 
> #
> # Userland interfaces
> #
> # CONFIG_INPUT_MOUSEDEV is not set
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_EVDEV is not set
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_OPENCORES is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> CONFIG_MOUSE_PS2_ALPS=y
> CONFIG_MOUSE_PS2_BYD=y
> CONFIG_MOUSE_PS2_LOGIPS2PP=y
> CONFIG_MOUSE_PS2_SYNAPTICS=y
> CONFIG_MOUSE_PS2_CYPRESS=y
> CONFIG_MOUSE_PS2_LIFEBOOK=y
> CONFIG_MOUSE_PS2_TRACKPOINT=y
> # CONFIG_MOUSE_PS2_ELANTECH is not set
> # CONFIG_MOUSE_PS2_SENTELIC is not set
> # CONFIG_MOUSE_PS2_TOUCHKIT is not set
> CONFIG_MOUSE_PS2_FOCALTECH=y
> # CONFIG_MOUSE_PS2_VMMOUSE is not set
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_APPLETOUCH is not set
> # CONFIG_MOUSE_BCM5974 is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> # CONFIG_MOUSE_SYNAPTICS_USB is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
> # CONFIG_RMI4_CORE is not set
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=y
> # CONFIG_SERIO_RAW is not set
> # CONFIG_SERIO_ALTERA_PS2 is not set
> # CONFIG_SERIO_PS2MULT is not set
> # CONFIG_SERIO_ARC_PS2 is not set
> # CONFIG_USERIO is not set
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
> CONFIG_VT_CONSOLE=y
> CONFIG_VT_CONSOLE_SLEEP=y
> CONFIG_HW_CONSOLE=y
> # CONFIG_VT_HW_CONSOLE_BINDING is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256
> CONFIG_LDISC_AUTOLOAD=y
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> CONFIG_SERIAL_8250_PNP=y
> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_EXAR=y
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> CONFIG_SERIAL_8250_DWLIB=y
> # CONFIG_SERIAL_8250_DW is not set
> # CONFIG_SERIAL_8250_RT288X is not set
> CONFIG_SERIAL_8250_LPSS=y
> CONFIG_SERIAL_8250_MID=y
> CONFIG_SERIAL_8250_PERICOM=y
> 
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_UARTLITE is not set
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> # CONFIG_SERIAL_JSM is not set
> # CONFIG_SERIAL_LANTIQ is not set
> # CONFIG_SERIAL_SCCNXP is not set
> # CONFIG_SERIAL_TIMBERDALE is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> # CONFIG_SERIAL_PCH_UART is not set
> # CONFIG_SERIAL_ARC is not set
> # CONFIG_SERIAL_RP2 is not set
> # CONFIG_SERIAL_FSL_LPUART is not set
> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> # end of Serial drivers
> 
> # CONFIG_SERIAL_NONSTANDARD is not set
> # CONFIG_N_GSM is not set
> # CONFIG_NOZOMI is not set
> # CONFIG_NULL_TTY is not set
> # CONFIG_SERIAL_DEV_BUS is not set
> # CONFIG_VIRTIO_CONSOLE is not set
> # CONFIG_IPMI_HANDLER is not set
> CONFIG_HW_RANDOM=y
> # CONFIG_HW_RANDOM_TIMERIOMEM is not set
> CONFIG_HW_RANDOM_INTEL=y
> # CONFIG_HW_RANDOM_AMD is not set
> # CONFIG_HW_RANDOM_BA431 is not set
> CONFIG_HW_RANDOM_GEODE=y
> CONFIG_HW_RANDOM_VIA=y
> # CONFIG_HW_RANDOM_XIPHERA is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
> # CONFIG_MWAVE is not set
> # CONFIG_PC8736x_GPIO is not set
> # CONFIG_NSC_GPIO is not set
> CONFIG_DEVMEM=y
> # CONFIG_NVRAM is not set
> CONFIG_DEVPORT=y
> # CONFIG_HPET is not set
> # CONFIG_HANGCHECK_TIMER is not set
> # CONFIG_TCG_TPM is not set
> # CONFIG_TELCLOCK is not set
> # CONFIG_XILLYBUS is not set
> CONFIG_RANDOM_TRUST_CPU=y
> CONFIG_RANDOM_TRUST_BOOTLOADER=y
> # end of Character devices
> 
> #
> # I2C support
> #
> # CONFIG_I2C is not set
> # end of I2C support
> 
> # CONFIG_I3C is not set
> # CONFIG_SPI is not set
> # CONFIG_SPMI is not set
> # CONFIG_HSI is not set
> CONFIG_PPS=y
> # CONFIG_PPS_DEBUG is not set
> # CONFIG_NTP_PPS is not set
> 
> #
> # PPS clients support
> #
> # CONFIG_PPS_CLIENT_KTIMER is not set
> # CONFIG_PPS_CLIENT_LDISC is not set
> # CONFIG_PPS_CLIENT_GPIO is not set
> 
> #
> # PPS generators support
> #
> 
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK=y
> CONFIG_PTP_1588_CLOCK_OPTIONAL=y
> 
> #
> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> #
> # CONFIG_PTP_1588_CLOCK_PCH is not set
> CONFIG_PTP_1588_CLOCK_KVM=y
> # CONFIG_PTP_1588_CLOCK_VMW is not set
> # end of PTP clock support
> 
> # CONFIG_PINCTRL is not set
> # CONFIG_GPIOLIB is not set
> # CONFIG_W1 is not set
> # CONFIG_POWER_RESET is not set
> CONFIG_POWER_SUPPLY=y
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> CONFIG_POWER_SUPPLY_HWMON=y
> # CONFIG_PDA_POWER is not set
> # CONFIG_TEST_POWER is not set
> # CONFIG_BATTERY_DS2780 is not set
> # CONFIG_BATTERY_DS2781 is not set
> # CONFIG_BATTERY_SAMSUNG_SDI is not set
> # CONFIG_BATTERY_BQ27XXX is not set
> # CONFIG_CHARGER_MAX8903 is not set
> # CONFIG_BATTERY_GOLDFISH is not set
> CONFIG_HWMON=y
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Native drivers
> #
> # CONFIG_SENSORS_ABITUGURU is not set
> # CONFIG_SENSORS_ABITUGURU3 is not set
> # CONFIG_SENSORS_AS370 is not set
> # CONFIG_SENSORS_AXI_FAN_CONTROL is not set
> # CONFIG_SENSORS_K8TEMP is not set
> # CONFIG_SENSORS_K10TEMP is not set
> # CONFIG_SENSORS_FAM15H_POWER is not set
> # CONFIG_SENSORS_APPLESMC is not set
> # CONFIG_SENSORS_ASPEED is not set
> # CONFIG_SENSORS_CORSAIR_CPRO is not set
> # CONFIG_SENSORS_CORSAIR_PSU is not set
> # CONFIG_SENSORS_DELL_SMM is not set
> # CONFIG_SENSORS_I5K_AMB is not set
> # CONFIG_SENSORS_F71805F is not set
> # CONFIG_SENSORS_F71882FG is not set
> # CONFIG_SENSORS_I5500 is not set
> # CONFIG_SENSORS_CORETEMP is not set
> # CONFIG_SENSORS_IT87 is not set
> # CONFIG_SENSORS_MAX197 is not set
> # CONFIG_SENSORS_MR75203 is not set
> # CONFIG_SENSORS_PC87360 is not set
> # CONFIG_SENSORS_PC87427 is not set
> # CONFIG_SENSORS_NCT6683 is not set
> # CONFIG_SENSORS_NCT6775 is not set
> # CONFIG_SENSORS_NPCM7XX is not set
> # CONFIG_SENSORS_SIS5595 is not set
> # CONFIG_SENSORS_SY7636A is not set
> # CONFIG_SENSORS_SMSC47M1 is not set
> # CONFIG_SENSORS_SMSC47B397 is not set
> # CONFIG_SENSORS_VIA_CPUTEMP is not set
> # CONFIG_SENSORS_VIA686A is not set
> # CONFIG_SENSORS_VT1211 is not set
> # CONFIG_SENSORS_VT8231 is not set
> # CONFIG_SENSORS_W83627HF is not set
> # CONFIG_SENSORS_W83627EHF is not set
> 
> #
> # ACPI drivers
> #
> # CONFIG_SENSORS_ACPI_POWER is not set
> # CONFIG_SENSORS_ATK0110 is not set
> # CONFIG_SENSORS_ASUS_EC is not set
> CONFIG_THERMAL=y
> # CONFIG_THERMAL_NETLINK is not set
> # CONFIG_THERMAL_STATISTICS is not set
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> CONFIG_THERMAL_HWMON=y
> # CONFIG_THERMAL_WRITABLE_TRIPS is not set
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> # CONFIG_THERMAL_GOV_FAIR_SHARE is not set
> CONFIG_THERMAL_GOV_STEP_WISE=y
> # CONFIG_THERMAL_GOV_BANG_BANG is not set
> # CONFIG_THERMAL_GOV_USER_SPACE is not set
> # CONFIG_THERMAL_EMULATION is not set
> 
> #
> # Intel thermal drivers
> #
> # CONFIG_INTEL_POWERCLAMP is not set
> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
> 
> #
> # ACPI INT340X thermal drivers
> #
> # end of ACPI INT340X thermal drivers
> 
> # CONFIG_INTEL_PCH_THERMAL is not set
> # CONFIG_INTEL_TCC_COOLING is not set
> # CONFIG_INTEL_MENLOW is not set
> # end of Intel thermal drivers
> 
> # CONFIG_WATCHDOG is not set
> CONFIG_SSB_POSSIBLE=y
> # CONFIG_SSB is not set
> CONFIG_BCMA_POSSIBLE=y
> # CONFIG_BCMA is not set
> 
> #
> # Multifunction device drivers
> #
> # CONFIG_MFD_CS5535 is not set
> # CONFIG_MFD_MADERA is not set
> # CONFIG_HTC_PASIC3 is not set
> # CONFIG_LPC_ICH is not set
> # CONFIG_LPC_SCH is not set
> # CONFIG_MFD_INTEL_LPSS_ACPI is not set
> # CONFIG_MFD_INTEL_LPSS_PCI is not set
> # CONFIG_MFD_INTEL_PMC_BXT is not set
> # CONFIG_MFD_JANZ_CMODIO is not set
> # CONFIG_MFD_KEMPLD is not set
> # CONFIG_MFD_MT6397 is not set
> # CONFIG_MFD_RDC321X is not set
> # CONFIG_MFD_SM501 is not set
> # CONFIG_MFD_SYSCON is not set
> # CONFIG_MFD_TI_AM335X_TSCADC is not set
> # CONFIG_MFD_TQMX86 is not set
> # CONFIG_MFD_VX855 is not set
> # end of Multifunction device drivers
> 
> # CONFIG_REGULATOR is not set
> # CONFIG_RC_CORE is not set
> 
> #
> # CEC support
> #
> # CONFIG_MEDIA_CEC_SUPPORT is not set
> # end of CEC support
> 
> # CONFIG_MEDIA_SUPPORT is not set
> 
> #
> # Graphics support
> #
> # CONFIG_AGP is not set
> # CONFIG_VGA_SWITCHEROO is not set
> # CONFIG_DRM is not set
> 
> #
> # ARM devices
> #
> # end of ARM devices
> 
> #
> # Frame buffer Devices
> #
> # CONFIG_FB is not set
> # end of Frame buffer Devices
> 
> #
> # Backlight & LCD device support
> #
> # CONFIG_LCD_CLASS_DEVICE is not set
> # CONFIG_BACKLIGHT_CLASS_DEVICE is not set
> # end of Backlight & LCD device support
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_DUMMY_CONSOLE_COLUMNS=80
> CONFIG_DUMMY_CONSOLE_ROWS=25
> # end of Console display driver support
> # end of Graphics support
> 
> # CONFIG_SOUND is not set
> 
> #
> # HID support
> #
> CONFIG_HID=y
> # CONFIG_HID_BATTERY_STRENGTH is not set
> # CONFIG_HIDRAW is not set
> # CONFIG_UHID is not set
> CONFIG_HID_GENERIC=y
> 
> #
> # Special HID drivers
> #
> CONFIG_HID_A4TECH=y
> # CONFIG_HID_ACRUX is not set
> # CONFIG_HID_AUREAL is not set
> CONFIG_HID_BELKIN=y
> CONFIG_HID_CHERRY=y
> # CONFIG_HID_COUGAR is not set
> # CONFIG_HID_MACALLY is not set
> # CONFIG_HID_CMEDIA is not set
> CONFIG_HID_CYPRESS=y
> # CONFIG_HID_DRAGONRISE is not set
> # CONFIG_HID_EMS_FF is not set
> # CONFIG_HID_ELECOM is not set
> CONFIG_HID_EZKEY=y
> # CONFIG_HID_GEMBIRD is not set
> # CONFIG_HID_GFRM is not set
> # CONFIG_HID_GLORIOUS is not set
> # CONFIG_HID_VIVALDI is not set
> # CONFIG_HID_KEYTOUCH is not set
> # CONFIG_HID_KYE is not set
> # CONFIG_HID_WALTOP is not set
> # CONFIG_HID_VIEWSONIC is not set
> # CONFIG_HID_XIAOMI is not set
> # CONFIG_HID_GYRATION is not set
> # CONFIG_HID_ICADE is not set
> CONFIG_HID_ITE=y
> # CONFIG_HID_JABRA is not set
> # CONFIG_HID_TWINHAN is not set
> CONFIG_HID_KENSINGTON=y
> # CONFIG_HID_LCPOWER is not set
> # CONFIG_HID_LENOVO is not set
> # CONFIG_HID_MAGICMOUSE is not set
> # CONFIG_HID_MALTRON is not set
> # CONFIG_HID_MAYFLASH is not set
> CONFIG_HID_REDRAGON=y
> CONFIG_HID_MICROSOFT=y
> CONFIG_HID_MONTEREY=y
> # CONFIG_HID_MULTITOUCH is not set
> # CONFIG_HID_NTI is not set
> # CONFIG_HID_ORTEK is not set
> # CONFIG_HID_PANTHERLORD is not set
> # CONFIG_HID_PETALYNX is not set
> # CONFIG_HID_PICOLCD is not set
> # CONFIG_HID_PLANTRONICS is not set
> # CONFIG_HID_RAZER is not set
> # CONFIG_HID_PRIMAX is not set
> # CONFIG_HID_SAITEK is not set
> # CONFIG_HID_SEMITEK is not set
> # CONFIG_HID_SPEEDLINK is not set
> # CONFIG_HID_STEAM is not set
> # CONFIG_HID_STEELSERIES is not set
> # CONFIG_HID_SUNPLUS is not set
> # CONFIG_HID_RMI is not set
> # CONFIG_HID_GREENASIA is not set
> # CONFIG_HID_SMARTJOYPLUS is not set
> # CONFIG_HID_TIVO is not set
> # CONFIG_HID_TOPSEED is not set
> # CONFIG_HID_UDRAW_PS3 is not set
> # CONFIG_HID_XINMO is not set
> # CONFIG_HID_ZEROPLUS is not set
> # CONFIG_HID_ZYDACRON is not set
> # CONFIG_HID_SENSOR_HUB is not set
> # CONFIG_HID_ALPS is not set
> # end of Special HID drivers
> # end of HID support
> 
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> # CONFIG_USB_ULPI_BUS is not set
> CONFIG_USB_ARCH_HAS_HCD=y
> # CONFIG_USB is not set
> CONFIG_USB_PCI=y
> 
> #
> # USB port drivers
> #
> 
> #
> # USB Physical Layer drivers
> #
> # CONFIG_NOP_USB_XCEIV is not set
> # end of USB Physical Layer drivers
> 
> # CONFIG_USB_GADGET is not set
> # CONFIG_TYPEC is not set
> # CONFIG_USB_ROLE_SWITCH is not set
> # CONFIG_MMC is not set
> # CONFIG_MEMSTICK is not set
> # CONFIG_NEW_LEDS is not set
> # CONFIG_ACCESSIBILITY is not set
> # CONFIG_INFINIBAND is not set
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> CONFIG_RTC_LIB=y
> CONFIG_RTC_MC146818_LIB=y
> # CONFIG_RTC_CLASS is not set
> # CONFIG_DMADEVICES is not set
> 
> #
> # DMABUF options
> #
> # CONFIG_SYNC_FILE is not set
> # CONFIG_DMABUF_HEAPS is not set
> # end of DMABUF options
> 
> # CONFIG_AUXDISPLAY is not set
> # CONFIG_UIO is not set
> # CONFIG_VFIO is not set
> # CONFIG_VIRT_DRIVERS is not set
> CONFIG_VIRTIO_MENU=y
> # CONFIG_VIRTIO_PCI is not set
> # CONFIG_VIRTIO_MMIO is not set
> # CONFIG_VDPA is not set
> CONFIG_VHOST_MENU=y
> # CONFIG_VHOST_NET is not set
> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> # end of Microsoft Hyper-V guest support
> 
> # CONFIG_GREYBUS is not set
> # CONFIG_COMEDI is not set
> # CONFIG_STAGING is not set
> # CONFIG_CHROME_PLATFORMS is not set
> # CONFIG_MELLANOX_PLATFORM is not set
> CONFIG_SURFACE_PLATFORMS=y
> # CONFIG_SURFACE_GPE is not set
> # CONFIG_SURFACE_PRO3_BUTTON is not set
> CONFIG_X86_PLATFORM_DEVICES=y
> # CONFIG_ACPI_WMI is not set
> # CONFIG_ACERHDF is not set
> # CONFIG_ACER_WIRELESS is not set
> # CONFIG_ADV_SWBUTTON is not set
> # CONFIG_ASUS_WIRELESS is not set
> # CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
> # CONFIG_FUJITSU_TABLET is not set
> # CONFIG_GPD_POCKET_FAN is not set
> # CONFIG_HP_ACCEL is not set
> # CONFIG_WIRELESS_HOTKEY is not set
> # CONFIG_IBM_RTL is not set
> # CONFIG_SENSORS_HDAPS is not set
> # CONFIG_INTEL_SAR_INT1092 is not set
> # CONFIG_INTEL_PMC_CORE is not set
> # CONFIG_INTEL_PUNIT_IPC is not set
> # CONFIG_INTEL_RST is not set
> # CONFIG_INTEL_SMARTCONNECT is not set
> # CONFIG_INTEL_VSEC is not set
> # CONFIG_SAMSUNG_Q10 is not set
> # CONFIG_TOSHIBA_BT_RFKILL is not set
> # CONFIG_TOSHIBA_HAPS is not set
> # CONFIG_ACPI_CMPC is not set
> # CONFIG_SYSTEM76_ACPI is not set
> # CONFIG_TOPSTAR_LAPTOP is not set
> # CONFIG_INTEL_IPS is not set
> # CONFIG_INTEL_SCU_PCI is not set
> # CONFIG_INTEL_SCU_PLATFORM is not set
> # CONFIG_SIEMENS_SIMATIC_IPC is not set
> # CONFIG_WINMATE_FM07_KEYS is not set
> # CONFIG_P2SB is not set
> # CONFIG_COMMON_CLK is not set
> # CONFIG_HWSPINLOCK is not set
> 
> #
> # Clock Source drivers
> #
> CONFIG_CLKSRC_I8253=y
> CONFIG_CLKEVT_I8253=y
> CONFIG_I8253_LOCK=y
> CONFIG_CLKBLD_I8253=y
> # end of Clock Source drivers
> 
> # CONFIG_MAILBOX is not set
> CONFIG_IOMMU_SUPPORT=y
> 
> #
> # Generic IOMMU Pagetable Support
> #
> # end of Generic IOMMU Pagetable Support
> 
> # CONFIG_IOMMU_DEBUGFS is not set
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
> # CONFIG_RPMSG_VIRTIO is not set
> # end of Rpmsg drivers
> 
> # CONFIG_SOUNDWIRE is not set
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> 
> #
> # Amlogic SoC drivers
> #
> # end of Amlogic SoC drivers
> 
> #
> # Broadcom SoC drivers
> #
> # end of Broadcom SoC drivers
> 
> #
> # NXP/Freescale QorIQ SoC drivers
> #
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
> # end of i.MX SoC drivers
> 
> #
> # Enable LiteX SoC Builder specific drivers
> #
> # end of Enable LiteX SoC Builder specific drivers
> 
> #
> # Qualcomm SoC drivers
> #
> # end of Qualcomm SoC drivers
> 
> # CONFIG_SOC_TI is not set
> 
> #
> # Xilinx SoC drivers
> #
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
> 
> # CONFIG_PM_DEVFREQ is not set
> # CONFIG_EXTCON is not set
> # CONFIG_MEMORY is not set
> # CONFIG_IIO is not set
> # CONFIG_NTB is not set
> # CONFIG_PWM is not set
> 
> #
> # IRQ chip support
> #
> # end of IRQ chip support
> 
> # CONFIG_IPACK_BUS is not set
> # CONFIG_RESET_CONTROLLER is not set
> 
> #
> # PHY Subsystem
> #
> # CONFIG_GENERIC_PHY is not set
> # CONFIG_USB_LGM_PHY is not set
> # CONFIG_PHY_CAN_TRANSCEIVER is not set
> 
> #
> # PHY drivers for Broadcom platforms
> #
> # CONFIG_BCM_KONA_USB2_PHY is not set
> # end of PHY drivers for Broadcom platforms
> 
> # CONFIG_PHY_PXA_28NM_HSIC is not set
> # CONFIG_PHY_PXA_28NM_USB2 is not set
> # CONFIG_PHY_INTEL_LGM_EMMC is not set
> # end of PHY Subsystem
> 
> # CONFIG_POWERCAP is not set
> # CONFIG_MCB is not set
> 
> #
> # Performance monitor support
> #
> # end of Performance monitor support
> 
> # CONFIG_RAS is not set
> # CONFIG_USB4 is not set
> 
> #
> # Android
> #
> # CONFIG_ANDROID_BINDER_IPC is not set
> # end of Android
> 
> # CONFIG_DAX is not set
> # CONFIG_NVMEM is not set
> 
> #
> # HW tracing support
> #
> # CONFIG_STM is not set
> # CONFIG_INTEL_TH is not set
> # end of HW tracing support
> 
> # CONFIG_FPGA is not set
> # CONFIG_TEE is not set
> # CONFIG_SIOX is not set
> # CONFIG_SLIMBUS is not set
> # CONFIG_INTERCONNECT is not set
> # CONFIG_COUNTER is not set
> # CONFIG_PECI is not set
> # CONFIG_HTE is not set
> # end of Device Drivers
> 
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=y
> # CONFIG_VALIDATE_FS_PARSER is not set
> # CONFIG_EXT2_FS is not set
> # CONFIG_EXT3_FS is not set
> # CONFIG_EXT4_FS is not set
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> # CONFIG_XFS_FS is not set
> # CONFIG_GFS2_FS is not set
> # CONFIG_BTRFS_FS is not set
> # CONFIG_NILFS2_FS is not set
> # CONFIG_F2FS_FS is not set
> CONFIG_EXPORTFS=y
> # CONFIG_EXPORTFS_BLOCK_OPS is not set
> CONFIG_FILE_LOCKING=y
> # CONFIG_FS_ENCRYPTION is not set
> # CONFIG_FS_VERITY is not set
> CONFIG_FSNOTIFY=y
> CONFIG_DNOTIFY=y
> CONFIG_INOTIFY_USER=y
> # CONFIG_FANOTIFY is not set
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_FUSE_FS is not set
> # CONFIG_OVERLAY_FS is not set
> 
> #
> # Caches
> #
> # CONFIG_FSCACHE is not set
> # end of Caches
> 
> #
> # CD-ROM/DVD Filesystems
> #
> # CONFIG_ISO9660_FS is not set
> # CONFIG_UDF_FS is not set
> # end of CD-ROM/DVD Filesystems
> 
> #
> # DOS/FAT/EXFAT/NT Filesystems
> #
> # CONFIG_MSDOS_FS is not set
> # CONFIG_VFAT_FS is not set
> # CONFIG_EXFAT_FS is not set
> # CONFIG_NTFS_FS is not set
> # CONFIG_NTFS3_FS is not set
> # end of DOS/FAT/EXFAT/NT Filesystems
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> # CONFIG_PROC_KCORE is not set
> CONFIG_PROC_SYSCTL=y
> CONFIG_PROC_PAGE_MONITOR=y
> # CONFIG_PROC_CHILDREN is not set
> CONFIG_PROC_PID_ARCH_STATUS=y
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> # CONFIG_TMPFS_POSIX_ACL is not set
> # CONFIG_TMPFS_XATTR is not set
> # CONFIG_HUGETLBFS is not set
> CONFIG_MEMFD_CREATE=y
> # CONFIG_CONFIGFS_FS is not set
> # end of Pseudo filesystems
> 
> CONFIG_MISC_FILESYSTEMS=y
> # CONFIG_ORANGEFS_FS is not set
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_ECRYPT_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_SQUASHFS is not set
> # CONFIG_VXFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_OMFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_QNX6FS_FS is not set
> # CONFIG_ROMFS_FS is not set
> # CONFIG_PSTORE is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> # CONFIG_EROFS_FS is not set
> CONFIG_NETWORK_FILESYSTEMS=y
> CONFIG_NFS_FS=y
> CONFIG_NFS_V2=y
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V3_ACL is not set
> CONFIG_NFS_V4=m
> # CONFIG_NFS_SWAP is not set
> # CONFIG_NFS_V4_1 is not set
> # CONFIG_ROOT_NFS is not set
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=y
> CONFIG_NFS_DISABLE_UDP_SUPPORT=y
> # CONFIG_NFSD is not set
> CONFIG_GRACE_PERIOD=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=y
> CONFIG_SUNRPC_GSS=m
> # CONFIG_SUNRPC_DEBUG is not set
> # CONFIG_CEPH_FS is not set
> CONFIG_CIFS=m
> CONFIG_CIFS_STATS2=y
> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
> # CONFIG_CIFS_UPCALL is not set
> # CONFIG_CIFS_XATTR is not set
> CONFIG_CIFS_DEBUG=y
> # CONFIG_CIFS_DEBUG2 is not set
> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> # CONFIG_CIFS_DFS_UPCALL is not set
> # CONFIG_CIFS_SWN_UPCALL is not set
> # CONFIG_SMB_SERVER is not set
> CONFIG_SMBFS_COMMON=m
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> # CONFIG_9P_FS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> # CONFIG_NLS_CODEPAGE_437 is not set
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> # CONFIG_NLS_ASCII is not set
> # CONFIG_NLS_ISO8859_1 is not set
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> # CONFIG_NLS_MAC_ROMAN is not set
> # CONFIG_NLS_MAC_CELTIC is not set
> # CONFIG_NLS_MAC_CENTEURO is not set
> # CONFIG_NLS_MAC_CROATIAN is not set
> # CONFIG_NLS_MAC_CYRILLIC is not set
> # CONFIG_NLS_MAC_GAELIC is not set
> # CONFIG_NLS_MAC_GREEK is not set
> # CONFIG_NLS_MAC_ICELAND is not set
> # CONFIG_NLS_MAC_INUIT is not set
> # CONFIG_NLS_MAC_ROMANIAN is not set
> # CONFIG_NLS_MAC_TURKISH is not set
> # CONFIG_NLS_UTF8 is not set
> # CONFIG_UNICODE is not set
> CONFIG_IO_WQ=y
> # end of File systems
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> # CONFIG_KEYS_REQUEST_CACHE is not set
> # CONFIG_PERSISTENT_KEYRINGS is not set
> # CONFIG_TRUSTED_KEYS is not set
> # CONFIG_ENCRYPTED_KEYS is not set
> # CONFIG_KEY_DH_OPERATIONS is not set
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> # CONFIG_SECURITY is not set
> # CONFIG_SECURITYFS is not set
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> # CONFIG_HARDENED_USERCOPY is not set
> CONFIG_FORTIFY_SOURCE=y
> # CONFIG_STATIC_USERMODEHELPER is not set
> CONFIG_DEFAULT_SECURITY_DAC=y
> CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"
> 
> #
> # Kernel hardening options
> #
> 
> #
> # Memory initialization
> #
> CONFIG_INIT_STACK_NONE=y
> # CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
> # CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
> # CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
> # CONFIG_GCC_PLUGIN_STACKLEAK is not set
> # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
> # CONFIG_ZERO_CALL_USED_REGS is not set
> # end of Memory initialization
> 
> CONFIG_RANDSTRUCT_NONE=y
> # CONFIG_RANDSTRUCT_FULL is not set
> # CONFIG_RANDSTRUCT_PERFORMANCE is not set
> # end of Kernel hardening options
> # end of Security options
> 
> CONFIG_CRYPTO=m
> 
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=m
> CONFIG_CRYPTO_ALGAPI2=m
> CONFIG_CRYPTO_AEAD=m
> CONFIG_CRYPTO_AEAD2=m
> CONFIG_CRYPTO_SKCIPHER=m
> CONFIG_CRYPTO_SKCIPHER2=m
> CONFIG_CRYPTO_HASH=m
> CONFIG_CRYPTO_HASH2=m
> CONFIG_CRYPTO_RNG2=m
> CONFIG_CRYPTO_AKCIPHER2=m
> CONFIG_CRYPTO_KPP2=m
> CONFIG_CRYPTO_ACOMP2=m
> CONFIG_CRYPTO_MANAGER=m
> CONFIG_CRYPTO_MANAGER2=m
> # CONFIG_CRYPTO_USER is not set
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> CONFIG_CRYPTO_GF128MUL=m
> CONFIG_CRYPTO_NULL=m
> CONFIG_CRYPTO_NULL2=m
> # CONFIG_CRYPTO_CRYPTD is not set
> # CONFIG_CRYPTO_AUTHENC is not set
> # CONFIG_CRYPTO_TEST is not set
> 
> #
> # Public-key cryptography
> #
> # CONFIG_CRYPTO_RSA is not set
> # CONFIG_CRYPTO_DH is not set
> # CONFIG_CRYPTO_ECDH is not set
> # CONFIG_CRYPTO_ECDSA is not set
> # CONFIG_CRYPTO_ECRDSA is not set
> # CONFIG_CRYPTO_SM2 is not set
> # CONFIG_CRYPTO_CURVE25519 is not set
> 
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=m
> CONFIG_CRYPTO_GCM=m
> # CONFIG_CRYPTO_CHACHA20POLY1305 is not set
> # CONFIG_CRYPTO_AEGIS128 is not set
> # CONFIG_CRYPTO_SEQIV is not set
> # CONFIG_CRYPTO_ECHAINIV is not set
> 
> #
> # Block modes
> #
> # CONFIG_CRYPTO_CBC is not set
> # CONFIG_CRYPTO_CFB is not set
> CONFIG_CRYPTO_CTR=m
> # CONFIG_CRYPTO_CTS is not set
> CONFIG_CRYPTO_ECB=m
> # CONFIG_CRYPTO_LRW is not set
> # CONFIG_CRYPTO_OFB is not set
> # CONFIG_CRYPTO_PCBC is not set
> # CONFIG_CRYPTO_XTS is not set
> # CONFIG_CRYPTO_KEYWRAP is not set
> # CONFIG_CRYPTO_ADIANTUM is not set
> # CONFIG_CRYPTO_HCTR2 is not set
> # CONFIG_CRYPTO_ESSIV is not set
> 
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=m
> CONFIG_CRYPTO_HMAC=m
> # CONFIG_CRYPTO_XCBC is not set
> # CONFIG_CRYPTO_VMAC is not set
> 
> #
> # Digest
> #
> # CONFIG_CRYPTO_CRC32C is not set
> # CONFIG_CRYPTO_CRC32C_INTEL is not set
> # CONFIG_CRYPTO_CRC32 is not set
> # CONFIG_CRYPTO_CRC32_PCLMUL is not set
> # CONFIG_CRYPTO_XXHASH is not set
> # CONFIG_CRYPTO_BLAKE2B is not set
> # CONFIG_CRYPTO_CRCT10DIF is not set
> CONFIG_CRYPTO_GHASH=m
> # CONFIG_CRYPTO_POLY1305 is not set
> # CONFIG_CRYPTO_MD4 is not set
> CONFIG_CRYPTO_MD5=m
> # CONFIG_CRYPTO_MICHAEL_MIC is not set
> # CONFIG_CRYPTO_RMD160 is not set
> # CONFIG_CRYPTO_SHA1 is not set
> CONFIG_CRYPTO_SHA256=m
> CONFIG_CRYPTO_SHA512=m
> # CONFIG_CRYPTO_SHA3 is not set
> # CONFIG_CRYPTO_SM3_GENERIC is not set
> # CONFIG_CRYPTO_STREEBOG is not set
> # CONFIG_CRYPTO_WP512 is not set
> 
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=m
> # CONFIG_CRYPTO_AES_TI is not set
> # CONFIG_CRYPTO_AES_NI_INTEL is not set
> # CONFIG_CRYPTO_BLOWFISH is not set
> # CONFIG_CRYPTO_CAMELLIA is not set
> # CONFIG_CRYPTO_CAST5 is not set
> # CONFIG_CRYPTO_CAST6 is not set
> # CONFIG_CRYPTO_DES is not set
> # CONFIG_CRYPTO_FCRYPT is not set
> # CONFIG_CRYPTO_CHACHA20 is not set
> # CONFIG_CRYPTO_ARIA is not set
> # CONFIG_CRYPTO_SERPENT is not set
> # CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
> # CONFIG_CRYPTO_SM4_GENERIC is not set
> # CONFIG_CRYPTO_TWOFISH is not set
> # CONFIG_CRYPTO_TWOFISH_586 is not set
> 
> #
> # Compression
> #
> # CONFIG_CRYPTO_DEFLATE is not set
> # CONFIG_CRYPTO_LZO is not set
> # CONFIG_CRYPTO_842 is not set
> # CONFIG_CRYPTO_LZ4 is not set
> # CONFIG_CRYPTO_LZ4HC is not set
> # CONFIG_CRYPTO_ZSTD is not set
> 
> #
> # Random Number Generation
> #
> # CONFIG_CRYPTO_ANSI_CPRNG is not set
> # CONFIG_CRYPTO_DRBG_MENU is not set
> # CONFIG_CRYPTO_JITTERENTROPY is not set
> # CONFIG_CRYPTO_USER_API_HASH is not set
> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> # CONFIG_CRYPTO_USER_API_RNG is not set
> # CONFIG_CRYPTO_USER_API_AEAD is not set
> CONFIG_CRYPTO_HW=y
> # CONFIG_CRYPTO_DEV_PADLOCK is not set
> # CONFIG_CRYPTO_DEV_GEODE is not set
> # CONFIG_CRYPTO_DEV_HIFN_795X is not set
> # CONFIG_CRYPTO_DEV_CCP is not set
> # CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
> # CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
> # CONFIG_CRYPTO_DEV_QAT_C62X is not set
> # CONFIG_CRYPTO_DEV_QAT_4XXX is not set
> # CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
> # CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
> # CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
> # CONFIG_CRYPTO_DEV_SAFEXCEL is not set
> # CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
> # CONFIG_ASYMMETRIC_KEY_TYPE is not set
> 
> #
> # Certificates for signature checking
> #
> # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
> # end of Certificates for signature checking
> 
> #
> # Library routines
> #
> # CONFIG_PACKING is not set
> CONFIG_BITREVERSE=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> # CONFIG_CORDIC is not set
> # CONFIG_PRIME_NUMBERS is not set
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
> 
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_AES=m
> CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
> # CONFIG_CRYPTO_LIB_CHACHA is not set
> # CONFIG_CRYPTO_LIB_CURVE25519 is not set
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
> # CONFIG_CRYPTO_LIB_POLY1305 is not set
> # CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
> CONFIG_CRYPTO_LIB_SHA1=y
> CONFIG_CRYPTO_LIB_SHA256=m
> # end of Crypto library routines
> 
> CONFIG_LIB_MEMNEQ=y
> # CONFIG_CRC_CCITT is not set
> # CONFIG_CRC16 is not set
> # CONFIG_CRC_T10DIF is not set
> # CONFIG_CRC64_ROCKSOFT is not set
> # CONFIG_CRC_ITU_T is not set
> CONFIG_CRC32=y
> # CONFIG_CRC32_SELFTEST is not set
> CONFIG_CRC32_SLICEBY8=y
> # CONFIG_CRC32_SLICEBY4 is not set
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> # CONFIG_CRC64 is not set
> # CONFIG_CRC4 is not set
> # CONFIG_CRC7 is not set
> # CONFIG_LIBCRC32C is not set
> # CONFIG_CRC8 is not set
> CONFIG_XXHASH=y
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_ZLIB_INFLATE=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> CONFIG_XZ_DEC_X86=y
> CONFIG_XZ_DEC_POWERPC=y
> CONFIG_XZ_DEC_IA64=y
> CONFIG_XZ_DEC_ARM=y
> CONFIG_XZ_DEC_ARMTHUMB=y
> CONFIG_XZ_DEC_SPARC=y
> # CONFIG_XZ_DEC_MICROLZMA is not set
> CONFIG_XZ_DEC_BCJ=y
> # CONFIG_XZ_DEC_TEST is not set
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_DECOMPRESS_BZIP2=y
> CONFIG_DECOMPRESS_LZMA=y
> CONFIG_DECOMPRESS_XZ=y
> CONFIG_DECOMPRESS_LZO=y
> CONFIG_DECOMPRESS_LZ4=y
> CONFIG_DECOMPRESS_ZSTD=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_DMA_MAP_BENCHMARK is not set
> CONFIG_SGL_ALLOC=y
> CONFIG_DQL=y
> CONFIG_NLATTR=y
> # CONFIG_IRQ_POLL is not set
> CONFIG_OID_REGISTRY=m
> CONFIG_HAVE_GENERIC_VDSO=y
> CONFIG_GENERIC_GETTIMEOFDAY=y
> CONFIG_GENERIC_VDSO_32=y
> CONFIG_GENERIC_VDSO_TIME_NS=y
> CONFIG_ARCH_STACKWALK=y
> CONFIG_STACKDEPOT=y
> CONFIG_SBITMAP=y
> # end of Library routines
> 
> #
> # Kernel hacking
> #
> 
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=y
> CONFIG_PRINTK_CALLER=y
> # CONFIG_STACKTRACE_BUILD_ID is not set
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> # CONFIG_BOOT_PRINTK_DELAY is not set
> # CONFIG_DYNAMIC_DEBUG is not set
> # CONFIG_DYNAMIC_DEBUG_CORE is not set
> CONFIG_SYMBOLIC_ERRNAME=y
> CONFIG_DEBUG_BUGVERBOSE=y
> # end of printk and dmesg options
> 
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_MISC=y
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO_NONE=y
> # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> CONFIG_FRAME_WARN=8192
> # CONFIG_STRIP_ASM_SYMS is not set
> # CONFIG_READABLE_ASM is not set
> # CONFIG_HEADERS_INSTALL is not set
> CONFIG_DEBUG_SECTION_MISMATCH=y
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> CONFIG_FRAME_POINTER=y
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
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
> # CONFIG_KGDB is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> CONFIG_UBSAN=y
> # CONFIG_UBSAN_TRAP is not set
> CONFIG_CC_HAS_UBSAN_BOUNDS=y
> CONFIG_UBSAN_BOUNDS=y
> CONFIG_UBSAN_ONLY_BOUNDS=y
> CONFIG_UBSAN_SHIFT=y
> # CONFIG_UBSAN_DIV_ZERO is not set
> CONFIG_UBSAN_UNREACHABLE=y
> # CONFIG_UBSAN_BOOL is not set
> # CONFIG_UBSAN_ENUM is not set
> # CONFIG_UBSAN_ALIGNMENT is not set
> CONFIG_UBSAN_SANITIZE_ALL=y
> # CONFIG_TEST_UBSAN is not set
> CONFIG_HAVE_KCSAN_COMPILER=y
> # end of Generic Kernel Debugging Instruments
> 
> #
> # Networking Debugging
> #
> # CONFIG_NET_DEV_REFCNT_TRACKER is not set
> # CONFIG_NET_NS_REFCNT_TRACKER is not set
> # CONFIG_DEBUG_NET is not set
> # end of Networking Debugging
> 
> #
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=y
> # CONFIG_DEBUG_PAGEALLOC is not set
> CONFIG_SLUB_DEBUG=y
> # CONFIG_SLUB_DEBUG_ON is not set
> CONFIG_PAGE_OWNER=y
> # CONFIG_PAGE_POISONING is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> CONFIG_ARCH_HAS_DEBUG_WX=y
> # CONFIG_DEBUG_WX is not set
> CONFIG_GENERIC_PTDUMP=y
> # CONFIG_PTDUMP_DEBUGFS is not set
> # CONFIG_DEBUG_OBJECTS is not set
> # CONFIG_SHRINKER_DEBUG is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> # CONFIG_DEBUG_KMEMLEAK is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_SCHED_STACK_END_CHECK is not set
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
> # CONFIG_DEBUG_VM is not set
> # CONFIG_DEBUG_VM_PGTABLE is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> # CONFIG_DEBUG_VIRTUAL is not set
> CONFIG_DEBUG_MEMORY_INIT=y
> # CONFIG_DEBUG_KMAP_LOCAL is not set
> CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
> # CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
> # CONFIG_DEBUG_HIGHMEM is not set
> CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> CONFIG_CC_HAS_KASAN_GENERIC=y
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> CONFIG_HAVE_ARCH_KFENCE=y
> # CONFIG_KFENCE is not set
> # end of Memory Debugging
> 
> # CONFIG_DEBUG_SHIRQ is not set
> 
> #
> # Debug Oops, Lockups and Hangs
> #
> CONFIG_PANIC_ON_OOPS=y
> CONFIG_PANIC_ON_OOPS_VALUE=1
> CONFIG_PANIC_TIMEOUT=0
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> # CONFIG_HARDLOCKUP_DETECTOR is not set
> CONFIG_DETECT_HUNG_TASK=y
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> CONFIG_WQ_WATCHDOG=y
> # CONFIG_TEST_LOCKUP is not set
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
> # CONFIG_PROVE_LOCKING is not set
> # CONFIG_LOCK_STAT is not set
> # CONFIG_DEBUG_RT_MUTEXES is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_MUTEXES is not set
> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> # CONFIG_DEBUG_RWSEMS is not set
> # CONFIG_DEBUG_LOCK_ALLOC is not set
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> # CONFIG_LOCK_TORTURE_TEST is not set
> # CONFIG_WW_MUTEX_SELFTEST is not set
> # CONFIG_SCF_TORTURE_TEST is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
> 
> # CONFIG_DEBUG_IRQFLAGS is not set
> CONFIG_STACKTRACE=y
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
> 
> #
> # Debug kernel data structures
> #
> # CONFIG_DEBUG_LIST is not set
> # CONFIG_DEBUG_PLIST is not set
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
> # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> # end of Debug kernel data structures
> 
> # CONFIG_DEBUG_CREDENTIALS is not set
> 
> #
> # RCU Debugging
> #
> # CONFIG_RCU_SCALE_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_RCU_REF_SCALE_TEST is not set
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
> 
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> # CONFIG_LATENCYTOP is not set
> CONFIG_USER_STACKTRACE_SUPPORT=y
> CONFIG_HAVE_RETHOOK=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
> CONFIG_TRACING_SUPPORT=y
> # CONFIG_FTRACE is not set
> # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> # CONFIG_SAMPLES is not set
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> CONFIG_STRICT_DEVMEM=y
> # CONFIG_IO_STRICT_DEVMEM is not set
> 
> #
> # x86 Debugging
> #
> CONFIG_EARLY_PRINTK_USB=y
> CONFIG_X86_VERBOSE_BOOTUP=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_EARLY_PRINTK_DBGP=y
> CONFIG_EARLY_PRINTK_USB_XDBC=y
> # CONFIG_DEBUG_TLBFLUSH is not set
> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> # CONFIG_X86_DECODER_SELFTEST is not set
> CONFIG_IO_DELAY_0X80=y
> # CONFIG_IO_DELAY_0XED is not set
> # CONFIG_IO_DELAY_UDELAY is not set
> # CONFIG_IO_DELAY_NONE is not set
> # CONFIG_DEBUG_BOOT_PARAMS is not set
> # CONFIG_CPA_DEBUG is not set
> # CONFIG_DEBUG_ENTRY is not set
> CONFIG_X86_DEBUG_FPU=y
> # CONFIG_PUNIT_ATOM_DEBUG is not set
> CONFIG_UNWINDER_FRAME_POINTER=y
> # end of x86 Debugging
> 
> #
> # Kernel Testing and Coverage
> #
> # CONFIG_KUNIT is not set
> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> # CONFIG_FAULT_INJECTION is not set
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> CONFIG_RUNTIME_TESTING_MENU=y
> # CONFIG_LKDTM is not set
> # CONFIG_TEST_MIN_HEAP is not set
> # CONFIG_TEST_DIV64 is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_TEST_REF_TRACKER is not set
> # CONFIG_RBTREE_TEST is not set
> # CONFIG_REED_SOLOMON_TEST is not set
> # CONFIG_INTERVAL_TREE_TEST is not set
> # CONFIG_PERCPU_TEST is not set
> # CONFIG_ATOMIC64_SELFTEST is not set
> # CONFIG_TEST_HEXDUMP is not set
> # CONFIG_STRING_SELFTEST is not set
> # CONFIG_TEST_STRING_HELPERS is not set
> # CONFIG_TEST_STRSCPY is not set
> # CONFIG_TEST_KSTRTOX is not set
> # CONFIG_TEST_PRINTF is not set
> # CONFIG_TEST_SCANF is not set
> # CONFIG_TEST_BITMAP is not set
> # CONFIG_TEST_UUID is not set
> # CONFIG_TEST_XARRAY is not set
> # CONFIG_TEST_RHASHTABLE is not set
> # CONFIG_TEST_SIPHASH is not set
> # CONFIG_TEST_IDA is not set
> # CONFIG_TEST_LKM is not set
> # CONFIG_TEST_BITOPS is not set
> # CONFIG_TEST_VMALLOC is not set
> # CONFIG_TEST_USER_COPY is not set
> # CONFIG_TEST_BPF is not set
> # CONFIG_TEST_BLACKHOLE_DEV is not set
> # CONFIG_FIND_BIT_BENCHMARK is not set
> # CONFIG_TEST_FIRMWARE is not set
> # CONFIG_TEST_SYSCTL is not set
> # CONFIG_TEST_UDELAY is not set
> # CONFIG_TEST_STATIC_KEYS is not set
> # CONFIG_TEST_KMOD is not set
> # CONFIG_TEST_MEMCAT_P is not set
> # CONFIG_TEST_MEMINIT is not set
> # CONFIG_TEST_FREE_PAGES is not set
> # CONFIG_TEST_FPU is not set
> # CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
> CONFIG_ARCH_USE_MEMTEST=y
> # CONFIG_MEMTEST is not set
> # end of Kernel Testing and Coverage
> # end of Kernel hacking
> 

> #!/bin/sh
> 
> export_top_env()
> {
> 	export suite='boot'
> 	export testcase='boot'
> 	export category='functional'
> 	export timeout='10m'
> 	export job_origin='boot.yaml'
> 	export queue_cmdline_keys='branch
> commit'
> 	export queue='bisect'
> 	export testbox='vm-snb-i386'
> 	export tbox_group='vm-snb-i386'
> 	export branch='paulmck-rcu/printk.2022.09.11a'
> 	export commit='e695fbe780f429298dca1fd826601968b5d00200'
> 	export kconfig='i386-alldefconfig'
> 	export nr_vm=300
> 	export submit_id='632cc0634e10ca2244eff25f'
> 	export job_file='/lkp/jobs/scheduled/vm-meta-137/boot-1-debian-i386-20191205.cgz-e695fbe780f429298dca1fd826601968b5d00200-20220923-74308-1vpwy2k-2.yaml'
> 	export id='772e60e2fd9d4535288deeca89516f433682eb2a'
> 	export queuer_version='/zday/lkp'
> 	export model='qemu-system-i386 -enable-kvm -cpu SandyBridge'
> 	export nr_cpu=2
> 	export memory='4G'
> 	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
> 	export ssh_base_port=23400
> 	export kernel_cmdline='vmalloc=256M initramfs_async=0 page_owner=on'
> 	export rootfs='debian-i386-20191205.cgz'
> 	export compiler='gcc-11'
> 	export enqueue_time='2022-09-23 04:06:59 +0800'
> 	export _id='632d142d4e10ca2244eff261'
> 	export _rt='/result/boot/1/vm-snb-i386/debian-i386-20191205.cgz/i386-alldefconfig/gcc-11/e695fbe780f429298dca1fd826601968b5d00200'
> 	export user='lkp'
> 	export LKP_SERVER='internal-lkp-server'
> 	export result_root='/result/boot/1/vm-snb-i386/debian-i386-20191205.cgz/i386-alldefconfig/gcc-11/e695fbe780f429298dca1fd826601968b5d00200/3'
> 	export scheduler_version='/lkp/lkp/src'
> 	export arch='i386'
> 	export max_uptime=600
> 	export initrd='/osimage/debian/debian-i386-20191205.cgz'
> 	export bootloader_append='root=/dev/ram0
> RESULT_ROOT=/result/boot/1/vm-snb-i386/debian-i386-20191205.cgz/i386-alldefconfig/gcc-11/e695fbe780f429298dca1fd826601968b5d00200/3
> BOOT_IMAGE=/pkg/linux/i386-alldefconfig/gcc-11/e695fbe780f429298dca1fd826601968b5d00200/vmlinuz-6.0.0-rc1-00138-ge695fbe780f4
> branch=paulmck-rcu/printk.2022.09.11a
> job=/lkp/jobs/scheduled/vm-meta-137/boot-1-debian-i386-20191205.cgz-e695fbe780f429298dca1fd826601968b5d00200-20220923-74308-1vpwy2k-2.yaml
> user=lkp
> ARCH=i386
> kconfig=i386-alldefconfig
> commit=e695fbe780f429298dca1fd826601968b5d00200
> vmalloc=256M initramfs_async=0 page_owner=on
> initcall_debug
> max_uptime=600
> LKP_SERVER=internal-lkp-server
> selinux=0
> debug
> apic=debug
> sysrq_always_enabled
> rcupdate.rcu_cpu_stall_timeout=100
> net.ifnames=0
> printk.devkmsg=on
> panic=-1
> softlockup_panic=1
> nmi_watchdog=panic
> oops=panic
> load_ramdisk=2
> prompt_ramdisk=0
> drbd.minor_count=8
> systemd.log_level=err
> ignore_loglevel
> console=tty0
> earlyprintk=ttyS0,115200
> console=ttyS0,115200
> vga=normal
> rw'
> 	export modules_initrd='/pkg/linux/i386-alldefconfig/gcc-11/e695fbe780f429298dca1fd826601968b5d00200/modules.cgz'
> 	export bm_initrd='/osimage/deps/debian-i386-20191205.cgz/lkp_20201203.cgz'
> 	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
> 	export site='lkp-wsx01'
> 	export LKP_CGI_PORT=80
> 	export LKP_CIFS_PORT=139
> 	export schedule_notify_address=
> 	export meta_host='vm-meta-137'
> 	export kernel='/pkg/linux/i386-alldefconfig/gcc-11/e695fbe780f429298dca1fd826601968b5d00200/vmlinuz-6.0.0-rc1-00138-ge695fbe780f4'
> 	export dequeue_time='2022-09-23 10:10:50 +0800'
> 	export job_initrd='/lkp/jobs/scheduled/vm-meta-137/boot-1-debian-i386-20191205.cgz-e695fbe780f429298dca1fd826601968b5d00200-20220923-74308-1vpwy2k-2.cgz'
> 
> 	[ -n "$LKP_SRC" ] ||
> 	export LKP_SRC=/lkp/${user:-lkp}/src
> }
> 
> run_job()
> {
> 	echo $$ > $TMP/run-job.pid
> 
> 	. $LKP_SRC/lib/http.sh
> 	. $LKP_SRC/lib/job.sh
> 	. $LKP_SRC/lib/env.sh
> 
> 	export_top_env
> 
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
> 	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> 	run_monitor $LKP_SRC/monitors/wrapper heartbeat
> 	run_monitor $LKP_SRC/monitors/wrapper meminfo
> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> 	run_monitor $LKP_SRC/monitors/plain/watchdog
> 
> 	run_test $LKP_SRC/tests/wrapper sleep 1
> }
> 
> extract_stats()
> {
> 	export stats_part_begin=
> 	export stats_part_end=
> 
> 	$LKP_SRC/stats/wrapper boot-slabinfo
> 	$LKP_SRC/stats/wrapper boot-meminfo
> 	$LKP_SRC/stats/wrapper memmap
> 	$LKP_SRC/stats/wrapper boot-memory
> 	$LKP_SRC/stats/wrapper boot-time
> 	$LKP_SRC/stats/wrapper kernel-size
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper sleep
> 	$LKP_SRC/stats/wrapper meminfo
> 
> 	$LKP_SRC/stats/wrapper time sleep.time
> 	$LKP_SRC/stats/wrapper dmesg
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper last_state
> 	$LKP_SRC/stats/wrapper stderr
> 	$LKP_SRC/stats/wrapper time
> }
> 
> "$@"
> 


