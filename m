Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D26616A6C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiKBRRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiKBRRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:17:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672131F63B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:17:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC78061AC8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 17:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305E0C433D6;
        Wed,  2 Nov 2022 17:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667409430;
        bh=kaAX6SSDPEcN1NcnHF0O3nN5xIdKn/WRvP7yC9rOFLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IaA/iLkUfHYUmgIL+BIG3PfaucncOFTdjxdWT8aAUgs1zp8xUQoAmJN78RtEymr0R
         KJmVRXWHIQulRgowHy+YbfhF2+OPK448UUyab27o54UByc3wUwyvJS97UZkl3fK7U5
         5/rABLrj5UtIIFlUmAMpJPkbpSEVHdDz1PqqJQV8k3FqUnBoDyEsNqxmb9qucSN0nP
         Ah8PdCMYSCLW6uKyQzzZigAGjxXQ7TNcTznGyuQdgx3QkSiOVCrVyNov1sn7uc515J
         dfMRPRAu2nKdfbjH7Qjk/hp81X6FymEMdt77xv9KbRWI2lTpW+QTx1XLyzkbwkgG1m
         WYgJqyo/JFZFg==
Date:   Thu, 3 Nov 2022 01:07:27 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: vdso: fix build with llvm
Message-ID: <Y2KjzykMsfmXCqGD@xhacker>
References: <20221031182943.2453-1-jszhang@kernel.org>
 <202211012201.VNdfUEyW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202211012201.VNdfUEyW-lkp@intel.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 10:59:21PM +0800, kernel test robot wrote:
> Hi Jisheng,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.1-rc3 next-20221101]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Jisheng-Zhang/riscv-vdso-fix-build-with-llvm/20221101-101926
> patch link:    https://lore.kernel.org/r/20221031182943.2453-1-jszhang%40kernel.org
> patch subject: [PATCH] riscv: vdso: fix build with llvm
> config: riscv-randconfig-r022-20221030
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/9a1e0495b1c93ca30480a13701a1c0f78fd04e6a
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Jisheng-Zhang/riscv-vdso-fix-build-with-llvm/20221101-101926
>         git checkout 9a1e0495b1c93ca30480a13701a1c0f78fd04e6a
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv prepare
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> ld.lld: error: section .dynamic file range overlaps with .text
>    >>> .dynamic range is [0x760, 0x88F]
>    >>> .text range is [0x800, 0x178B]


These build errors are another story, I believe the bug existed for a
long time, I can reproduce it w/ and w/o this patch.

The fix of these errors is:
https://lore.kernel.org/linux-riscv/20221102170254.1925-1-jszhang@kernel.org/T/#u

> --
> >> ld.lld: error: section .text file range overlaps with _ftrace_branch
>    >>> .text range is [0x800, 0x178B]
>    >>> _ftrace_branch range is [0x890, 0x9F7]
> --
> >> ld.lld: error: section .dynamic virtual address range overlaps with .text
>    >>> .dynamic range is [0x760, 0x88F]
>    >>> .text range is [0x800, 0x178B]
> --
> >> ld.lld: error: section .text virtual address range overlaps with _ftrace_branch
>    >>> .text range is [0x800, 0x178B]
>    >>> _ftrace_branch range is [0x890, 0x9F7]
> --
> >> ld.lld: error: section .dynamic load address range overlaps with .text
>    >>> .dynamic range is [0x760, 0x88F]
>    >>> .text range is [0x800, 0x178B]
> --
> >> ld.lld: error: section .text load address range overlaps with _ftrace_branch
>    >>> .text range is [0x800, 0x178B]
>    >>> _ftrace_branch range is [0x890, 0x9F7]
> --
> >> ld.lld: error: section .text load address range overlaps with _ftrace_branch
>    >>> .text range is [0x800, 0x178B]
>    >>> _ftrace_branch range is [0x890, 0x9F7]
> --
>    scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
>    scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
>    scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
> >> ld.lld: error: section .dynamic file range overlaps with .text
>    >>> .dynamic range is [0x760, 0x88F]
>    >>> .text range is [0x800, 0x178B]
> --
> >> ld.lld: error: section .text load address range overlaps with _ftrace_branch
>    >>> .text range is [0x800, 0x178B]
>    >>> _ftrace_branch range is [0x890, 0x9F7]
>    llvm-nm: error: arch/riscv/kernel/vdso/vdso.so.dbg: No such file or directory
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/riscv 6.1.0-rc3 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT="clang version 16.0.0 (git://gitmirror/llvm_project 791a7ae1ba3efd6bca96338e10ffde557ba83920)"
> CONFIG_GCC_VERSION=0
> CONFIG_CC_IS_CLANG=y
> CONFIG_CLANG_VERSION=160000
> CONFIG_AS_IS_LLVM=y
> CONFIG_AS_VERSION=160000
> CONFIG_LD_VERSION=0
> CONFIG_LD_IS_LLD=y
> CONFIG_LLD_VERSION=160000
> CONFIG_RUST_IS_AVAILABLE=y
> CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
> CONFIG_TOOLS_SUPPORT_RELR=y
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
> CONFIG_COMPILE_TEST=y
> # CONFIG_WERROR is not set
> CONFIG_LOCALVERSION=""
> CONFIG_BUILD_SALT=""
> CONFIG_DEFAULT_INIT=""
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_COMPAT=y
> CONFIG_WATCH_QUEUE=y
> # CONFIG_CROSS_MEMORY_ATTACH is not set
> # CONFIG_USELIB is not set
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
> CONFIG_HARDIRQS_SW_RESEND=y
> CONFIG_GENERIC_IRQ_CHIP=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_SIM=y
> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> CONFIG_GENERIC_MSI_IRQ=y
> CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> # end of IRQ subsystem
> 
> CONFIG_GENERIC_IRQ_MULTI_HANDLER=y
> CONFIG_ARCH_CLOCKSOURCE_INIT=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
> CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
> 
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> CONFIG_NO_HZ_IDLE=y
> CONFIG_NO_HZ=y
> # CONFIG_HIGH_RES_TIMERS is not set
> # end of Timers subsystem
> 
> CONFIG_BPF=y
> CONFIG_HAVE_EBPF_JIT=y
> 
> #
> # BPF subsystem
> #
> CONFIG_BPF_SYSCALL=y
> CONFIG_BPF_JIT=y
> # CONFIG_BPF_JIT_ALWAYS_ON is not set
> # CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
> # end of BPF subsystem
> 
> CONFIG_PREEMPT_NONE_BUILD=y
> CONFIG_PREEMPT_NONE=y
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_COUNT=y
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_TICK_CPU_ACCOUNTING=y
> # CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
> CONFIG_IRQ_TIME_ACCOUNTING=y
> CONFIG_BSD_PROCESS_ACCT=y
> # CONFIG_BSD_PROCESS_ACCT_V3 is not set
> # CONFIG_PSI is not set
> # end of CPU/Task time and stats accounting
> 
> CONFIG_CPU_ISOLATION=y
> 
> #
> # RCU Subsystem
> #
> CONFIG_TINY_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=y
> CONFIG_TINY_SRCU=y
> CONFIG_TASKS_RCU_GENERIC=y
> CONFIG_TASKS_TRACE_RCU=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> # end of RCU Subsystem
> 
> CONFIG_IKCONFIG=y
> # CONFIG_IKCONFIG_PROC is not set
> CONFIG_IKHEADERS=y
> CONFIG_LOG_BUF_SHIFT=17
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> CONFIG_PRINTK_INDEX=y
> CONFIG_GENERIC_SCHED_CLOCK=y
> 
> #
> # Scheduler features
> #
> # end of Scheduler features
> 
> CONFIG_CC_HAS_INT128=y
> CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough"
> CONFIG_GCC12_NO_ARRAY_BOUNDS=y
> CONFIG_ARCH_SUPPORTS_INT128=y
> # CONFIG_CGROUPS is not set
> CONFIG_NAMESPACES=y
> CONFIG_UTS_NS=y
> CONFIG_TIME_NS=y
> # CONFIG_IPC_NS is not set
> CONFIG_USER_NS=y
> CONFIG_PID_NS=y
> CONFIG_CHECKPOINT_RESTORE=y
> # CONFIG_SCHED_AUTOGROUP is not set
> # CONFIG_SYSFS_DEPRECATED is not set
> CONFIG_RELAY=y
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> # CONFIG_RD_GZIP is not set
> CONFIG_RD_BZIP2=y
> # CONFIG_RD_LZMA is not set
> CONFIG_RD_XZ=y
> CONFIG_RD_LZO=y
> CONFIG_RD_LZ4=y
> CONFIG_RD_ZSTD=y
> CONFIG_BOOT_CONFIG=y
> # CONFIG_BOOT_CONFIG_EMBED is not set
> CONFIG_INITRAMFS_PRESERVE_MTIME=y
> # CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_EXPERT=y
> CONFIG_MULTIUSER=y
> CONFIG_SGETMASK_SYSCALL=y
> CONFIG_SYSFS_SYSCALL=y
> # CONFIG_FHANDLE is not set
> CONFIG_POSIX_TIMERS=y
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> # CONFIG_BASE_FULL is not set
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> # CONFIG_SIGNALFD is not set
> CONFIG_TIMERFD=y
> # CONFIG_EVENTFD is not set
> CONFIG_SHMEM=y
> # CONFIG_AIO is not set
> # CONFIG_IO_URING is not set
> CONFIG_ADVISE_SYSCALLS=y
> CONFIG_MEMBARRIER=y
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> CONFIG_KCMP=y
> CONFIG_RSEQ=y
> # CONFIG_DEBUG_RSEQ is not set
> CONFIG_EMBEDDED=y
> CONFIG_HAVE_PERF_EVENTS=y
> # CONFIG_PC104 is not set
> 
> #
> # Kernel Performance Events And Counters
> #
> # CONFIG_PERF_EVENTS is not set
> # end of Kernel Performance Events And Counters
> 
> CONFIG_SYSTEM_DATA_VERIFICATION=y
> # CONFIG_PROFILING is not set
> CONFIG_TRACEPOINTS=y
> # end of General setup
> 
> CONFIG_64BIT=y
> CONFIG_RISCV=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=18
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_BITS_MAX=24
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=17
> CONFIG_RISCV_SBI=y
> CONFIG_MMU=y
> CONFIG_PAGE_OFFSET=0xff60000000000000
> CONFIG_ARCH_FLATMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_GENERIC_BUG=y
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_GENERIC_CSUM=y
> CONFIG_GENERIC_HWEIGHT=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_PGTABLE_LEVELS=5
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_RISCV_DMA_NONCOHERENT=y
> CONFIG_AS_HAS_INSN=y
> 
> #
> # SoC selection
> #
> CONFIG_SOC_MICROCHIP_POLARFIRE=y
> CONFIG_SOC_SIFIVE=y
> # CONFIG_SOC_STARFIVE is not set
> # CONFIG_SOC_VIRT is not set
> # end of SoC selection
> 
> #
> # CPU errata selection
> #
> CONFIG_ERRATA_SIFIVE=y
> CONFIG_ERRATA_SIFIVE_CIP_453=y
> CONFIG_ERRATA_SIFIVE_CIP_1200=y
> # CONFIG_ERRATA_THEAD is not set
> # end of CPU errata selection
> 
> #
> # Platform type
> #
> # CONFIG_NONPORTABLE is not set
> CONFIG_ARCH_RV64I=y
> CONFIG_CMODEL_MEDLOW=y
> # CONFIG_CMODEL_MEDANY is not set
> CONFIG_MODULE_SECTIONS=y
> # CONFIG_SMP is not set
> CONFIG_TUNE_GENERIC=y
> CONFIG_RISCV_ALTERNATIVE=y
> CONFIG_RISCV_ISA_C=y
> CONFIG_RISCV_ISA_SVPBMT=y
> CONFIG_TOOLCHAIN_HAS_ZICBOM=y
> CONFIG_RISCV_ISA_ZICBOM=y
> CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE=y
> CONFIG_FPU=y
> # end of Platform type
> 
> #
> # Kernel features
> #
> CONFIG_HZ_100=y
> # CONFIG_HZ_250 is not set
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=100
> CONFIG_RISCV_SBI_V01=y
> # CONFIG_KEXEC is not set
> # CONFIG_KEXEC_FILE is not set
> CONFIG_CRASH_DUMP=y
> CONFIG_COMPAT=y
> # end of Kernel features
> 
> #
> # Boot options
> #
> CONFIG_CMDLINE=""
> CONFIG_EFI_STUB=y
> CONFIG_EFI=y
> # end of Boot options
> 
> CONFIG_PORTABLE=y
> 
> #
> # Power management options
> #
> # CONFIG_PM is not set
> # end of Power management options
> 
> #
> # CPU Power Management
> #
> 
> #
> # CPU Idle
> #
> # CONFIG_CPU_IDLE is not set
> # end of CPU Idle
> # end of CPU Power Management
> 
> # CONFIG_VIRTUALIZATION is not set
> 
> #
> # General architecture-dependent options
> #
> CONFIG_KPROBES=y
> # CONFIG_JUMP_LABEL is not set
> CONFIG_HAVE_64BIT_ALIGNED_ACCESS=y
> CONFIG_KRETPROBES=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_GENERIC_IDLE_POLL_SETUP=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> CONFIG_HAVE_ASM_MODVERSIONS=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_RSEQ=y
> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
> CONFIG_HAVE_ARCH_SECCOMP=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> # CONFIG_SECCOMP is not set
> CONFIG_HAVE_STACKPROTECTOR=y
> # CONFIG_STACKPROTECTOR is not set
> CONFIG_LTO_NONE=y
> CONFIG_HAVE_CONTEXT_TRACKING_USER=y
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_MOVE_PUD=y
> CONFIG_HAVE_MOVE_PMD=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_RELA=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_ARCH_MMAP_RND_BITS=18
> CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
> CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
> CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
> CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT=y
> CONFIG_CLONE_BACKWARDS=y
> # CONFIG_COMPAT_32BIT_TIME is not set
> CONFIG_HAVE_ARCH_VMAP_STACK=y
> CONFIG_VMAP_STACK=y
> CONFIG_ARCH_OPTIONAL_KERNEL_RWX=y
> CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT=y
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> # CONFIG_STRICT_KERNEL_RWX is not set
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> CONFIG_STRICT_MODULE_RWX=y
> CONFIG_ARCH_USE_MEMREMAP_PROT=y
> CONFIG_LOCK_EVENT_COUNTS=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
> 
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> # end of GCOV-based kernel profiling
> 
> CONFIG_HAVE_GCC_PLUGINS=y
> # end of General architecture-dependent options
> 
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=1
> CONFIG_MODULE_SIG_FORMAT=y
> CONFIG_MODULES=y
> CONFIG_MODULE_FORCE_LOAD=y
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> # CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
> CONFIG_MODVERSIONS=y
> CONFIG_ASM_MODVERSIONS=y
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> CONFIG_MODULE_SIG=y
> CONFIG_MODULE_SIG_FORCE=y
> CONFIG_MODULE_SIG_ALL=y
> # CONFIG_MODULE_SIG_SHA1 is not set
> # CONFIG_MODULE_SIG_SHA224 is not set
> CONFIG_MODULE_SIG_SHA256=y
> # CONFIG_MODULE_SIG_SHA384 is not set
> # CONFIG_MODULE_SIG_SHA512 is not set
> CONFIG_MODULE_SIG_HASH="sha256"
> # CONFIG_MODULE_COMPRESS_NONE is not set
> # CONFIG_MODULE_COMPRESS_GZIP is not set
> CONFIG_MODULE_COMPRESS_XZ=y
> # CONFIG_MODULE_COMPRESS_ZSTD is not set
> # CONFIG_MODULE_DECOMPRESS is not set
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_MODPROBE_PATH="/sbin/modprobe"
> CONFIG_MODULES_TREE_LOOKUP=y
> CONFIG_BLOCK=y
> CONFIG_BLOCK_LEGACY_AUTOLOAD=y
> CONFIG_BLK_DEV_BSG_COMMON=y
> CONFIG_BLK_ICQ=y
> CONFIG_BLK_DEV_BSGLIB=y
> # CONFIG_BLK_DEV_INTEGRITY is not set
> CONFIG_BLK_DEV_ZONED=y
> # CONFIG_BLK_WBT is not set
> # CONFIG_BLK_DEBUG_FS is not set
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
> CONFIG_BLOCK_COMPAT=y
> CONFIG_BLK_MQ_PCI=y
> CONFIG_BLK_MQ_VIRTIO=y
> 
> #
> # IO Schedulers
> #
> CONFIG_MQ_IOSCHED_DEADLINE=y
> CONFIG_MQ_IOSCHED_KYBER=y
> CONFIG_IOSCHED_BFQ=m
> # end of IO Schedulers
> 
> CONFIG_ASN1=y
> CONFIG_UNINLINE_SPIN_UNLOCK=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> CONFIG_ARCH_HAS_MMIOWB=y
> 
> #
> # Executable file formats
> #
> # CONFIG_BINFMT_ELF is not set
> CONFIG_BINFMT_SCRIPT=y
> CONFIG_ARCH_HAS_BINFMT_FLAT=y
> # CONFIG_BINFMT_FLAT is not set
> CONFIG_BINFMT_MISC=y
> # CONFIG_COREDUMP is not set
> # end of Executable file formats
> 
> #
> # Memory Management options
> #
> # CONFIG_SWAP is not set
> 
> #
> # SLAB allocator options
> #
> CONFIG_SLAB=y
> # CONFIG_SLUB is not set
> # CONFIG_SLOB is not set
> # CONFIG_SLAB_MERGE_DEFAULT is not set
> CONFIG_SLAB_FREELIST_RANDOM=y
> CONFIG_SLAB_FREELIST_HARDENED=y
> # end of SLAB allocator options
> 
> # CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
> # CONFIG_COMPAT_BRK is not set
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_FLATMEM_MANUAL=y
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_FLATMEM=y
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> CONFIG_MEMORY_ISOLATION=y
> CONFIG_EXCLUSIVE_SYSTEM_RAM=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> CONFIG_MEMORY_BALLOON=y
> CONFIG_BALLOON_COMPACTION=y
> CONFIG_COMPACTION=y
> CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
> CONFIG_PAGE_REPORTING=y
> CONFIG_MIGRATION=y
> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
> CONFIG_CONTIG_ALLOC=y
> CONFIG_PHYS_ADDR_T_64BIT=y
> CONFIG_KSM=y
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_ARCH_WANTS_THP_SWAP=y
> # CONFIG_TRANSPARENT_HUGEPAGE is not set
> CONFIG_NEED_PER_CPU_KM=y
> CONFIG_CMA=y
> CONFIG_CMA_DEBUG=y
> # CONFIG_CMA_DEBUGFS is not set
> CONFIG_CMA_SYSFS=y
> CONFIG_CMA_AREAS=7
> CONFIG_GENERIC_EARLY_IOREMAP=y
> CONFIG_PAGE_IDLE_FLAG=y
> CONFIG_IDLE_PAGE_TRACKING=y
> CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
> CONFIG_ZONE_DMA32=y
> CONFIG_VM_EVENT_COUNTERS=y
> CONFIG_PERCPU_STATS=y
> # CONFIG_GUP_TEST is not set
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> # CONFIG_ANON_VMA_NAME is not set
> # CONFIG_USERFAULTFD is not set
> # CONFIG_LRU_GEN is not set
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
> CONFIG_HAVE_PCI=y
> CONFIG_PCI=y
> CONFIG_PCI_DOMAINS=y
> CONFIG_PCI_DOMAINS_GENERIC=y
> # CONFIG_PCIEPORTBUS is not set
> # CONFIG_PCIEASPM is not set
> # CONFIG_PCIE_PTM is not set
> CONFIG_PCI_MSI=y
> CONFIG_PCI_MSI_IRQ_DOMAIN=y
> # CONFIG_PCI_QUIRKS is not set
> CONFIG_PCI_DEBUG=y
> CONFIG_PCI_REALLOC_ENABLE_AUTO=y
> # CONFIG_PCI_STUB is not set
> CONFIG_PCI_PF_STUB=y
> CONFIG_PCI_ATS=y
> CONFIG_PCI_DOE=y
> CONFIG_PCI_ECAM=y
> CONFIG_PCI_IOV=y
> CONFIG_PCI_PRI=y
> # CONFIG_PCI_PASID is not set
> # CONFIG_PCIE_BUS_TUNE_OFF is not set
> # CONFIG_PCIE_BUS_DEFAULT is not set
> # CONFIG_PCIE_BUS_SAFE is not set
> CONFIG_PCIE_BUS_PERFORMANCE=y
> # CONFIG_PCIE_BUS_PEER2PEER is not set
> # CONFIG_VGA_ARB is not set
> # CONFIG_HOTPLUG_PCI is not set
> 
> #
> # PCI controller drivers
> #
> # CONFIG_PCI_AARDVARK is not set
> # CONFIG_PCIE_XILINX_NWL is not set
> CONFIG_PCI_FTPCI100=y
> # CONFIG_PCI_TEGRA is not set
> # CONFIG_PCIE_RCAR_HOST is not set
> CONFIG_PCI_HOST_COMMON=y
> CONFIG_PCI_HOST_GENERIC=y
> CONFIG_PCIE_XILINX=y
> # CONFIG_PCIE_XILINX_CPM is not set
> # CONFIG_PCI_XGENE is not set
> # CONFIG_PCI_V3_SEMI is not set
> # CONFIG_PCI_VERSATILE is not set
> # CONFIG_PCIE_ALTERA is not set
> # CONFIG_PCI_HOST_THUNDER_PEM is not set
> # CONFIG_PCI_HOST_THUNDER_ECAM is not set
> # CONFIG_PCIE_ROCKCHIP_HOST is not set
> # CONFIG_PCIE_MEDIATEK is not set
> # CONFIG_PCIE_MEDIATEK_GEN3 is not set
> # CONFIG_PCIE_BRCMSTB is not set
> CONFIG_PCIE_MICROCHIP_HOST=y
> # CONFIG_PCIE_APPLE is not set
> # CONFIG_PCIE_MT7621 is not set
> 
> #
> # DesignWare PCI Core Support
> #
> CONFIG_PCIE_DW=y
> CONFIG_PCIE_DW_HOST=y
> CONFIG_PCIE_DW_PLAT=y
> CONFIG_PCIE_DW_PLAT_HOST=y
> # CONFIG_PCI_EXYNOS is not set
> # CONFIG_PCI_IMX6 is not set
> # CONFIG_PCIE_SPEAR13XX is not set
> # CONFIG_PCI_KEYSTONE_HOST is not set
> # CONFIG_PCI_LAYERSCAPE is not set
> # CONFIG_PCI_HISI is not set
> # CONFIG_PCIE_QCOM is not set
> # CONFIG_PCIE_ARMADA_8K is not set
> # CONFIG_PCIE_ARTPEC6_HOST is not set
> # CONFIG_PCIE_ROCKCHIP_DW_HOST is not set
> # CONFIG_PCIE_INTEL_GW is not set
> # CONFIG_PCIE_KEEMBAY_HOST is not set
> # CONFIG_PCIE_KIRIN is not set
> # CONFIG_PCIE_HISI_STB is not set
> # CONFIG_PCI_MESON is not set
> # CONFIG_PCIE_TEGRA194_HOST is not set
> # CONFIG_PCIE_VISCONTI_HOST is not set
> # CONFIG_PCIE_UNIPHIER is not set
> # CONFIG_PCIE_AL is not set
> # CONFIG_PCIE_FU740 is not set
> # end of DesignWare PCI Core Support
> 
> #
> # Mobiveil PCIe Core Support
> #
> # CONFIG_PCIE_MOBIVEIL_PLAT is not set
> # CONFIG_PCIE_LAYERSCAPE_GEN4 is not set
> # end of Mobiveil PCIe Core Support
> 
> #
> # Cadence PCIe controllers support
> #
> CONFIG_PCIE_CADENCE=y
> CONFIG_PCIE_CADENCE_HOST=y
> CONFIG_PCIE_CADENCE_PLAT=y
> CONFIG_PCIE_CADENCE_PLAT_HOST=y
> CONFIG_PCI_J721E=y
> CONFIG_PCI_J721E_HOST=y
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
> CONFIG_PCI_SW_SWITCHTEC=m
> # end of PCI switch controller drivers
> 
> CONFIG_CXL_BUS=m
> CONFIG_CXL_PCI=m
> # CONFIG_CXL_MEM_RAW_COMMANDS is not set
> CONFIG_CXL_MEM=m
> CONFIG_CXL_PORT=m
> CONFIG_PCCARD=m
> # CONFIG_PCMCIA is not set
> CONFIG_CARDBUS=y
> 
> #
> # PC-card bridges
> #
> CONFIG_YENTA=m
> # CONFIG_YENTA_O2 is not set
> CONFIG_YENTA_RICOH=y
> # CONFIG_YENTA_TI is not set
> CONFIG_YENTA_TOSHIBA=y
> # CONFIG_RAPIDIO is not set
> 
> #
> # Generic Driver Options
> #
> CONFIG_AUXILIARY_BUS=y
> # CONFIG_UEVENT_HELPER is not set
> # CONFIG_DEVTMPFS is not set
> # CONFIG_STANDALONE is not set
> # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_FW_LOADER_PAGED_BUF=y
> CONFIG_FW_LOADER_SYSFS=y
> CONFIG_EXTRA_FIRMWARE=""
> CONFIG_FW_LOADER_USER_HELPER=y
> CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
> # CONFIG_FW_LOADER_COMPRESS is not set
> # CONFIG_FW_UPLOAD is not set
> # end of Firmware loader
> 
> CONFIG_WANT_DEV_COREDUMP=y
> CONFIG_ALLOW_DEV_COREDUMP=y
> CONFIG_DEV_COREDUMP=y
> # CONFIG_DEBUG_DRIVER is not set
> CONFIG_DEBUG_DEVRES=y
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> CONFIG_TEST_ASYNC_DRIVER_PROBE=m
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=y
> CONFIG_REGMAP_SLIMBUS=m
> CONFIG_REGMAP_MMIO=y
> CONFIG_REGMAP_IRQ=y
> CONFIG_REGMAP_I3C=m
> CONFIG_DMA_SHARED_BUFFER=y
> # CONFIG_DMA_FENCE_TRACE is not set
> CONFIG_GENERIC_ARCH_TOPOLOGY=y
> # end of Generic Driver Options
> 
> #
> # Bus devices
> #
> # CONFIG_ARM_INTEGRATOR_LM is not set
> # CONFIG_BT1_APB is not set
> # CONFIG_BT1_AXI is not set
> # CONFIG_HISILICON_LPC is not set
> # CONFIG_INTEL_IXP4XX_EB is not set
> # CONFIG_QCOM_EBI2 is not set
> CONFIG_MHI_BUS=y
> # CONFIG_MHI_BUS_DEBUG is not set
> # CONFIG_MHI_BUS_PCI_GENERIC is not set
> # CONFIG_MHI_BUS_EP is not set
> # end of Bus devices
> 
> #
> # Firmware Drivers
> #
> 
> #
> # ARM System Control and Management Interface Protocol
> #
> # CONFIG_ARM_SCMI_PROTOCOL is not set
> CONFIG_ARM_SCMI_POWER_DOMAIN=y
> # CONFIG_ARM_SCMI_POWER_CONTROL is not set
> # end of ARM System Control and Management Interface Protocol
> 
> # CONFIG_ARM_SCPI_PROTOCOL is not set
> CONFIG_ARM_SCPI_POWER_DOMAIN=y
> CONFIG_FIRMWARE_MEMMAP=y
> CONFIG_SYSFB=y
> CONFIG_SYSFB_SIMPLEFB=y
> # CONFIG_TURRIS_MOX_RWTM is not set
> # CONFIG_BCM47XX_NVRAM is not set
> CONFIG_GOOGLE_FIRMWARE=y
> CONFIG_GOOGLE_COREBOOT_TABLE=m
> CONFIG_GOOGLE_MEMCONSOLE=m
> CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=m
> CONFIG_GOOGLE_VPD=m
> 
> #
> # EFI (Extensible Firmware Interface) Support
> #
> CONFIG_EFI_ESRT=y
> CONFIG_EFI_VARS_PSTORE=m
> # CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
> CONFIG_EFI_PARAMS_FROM_FDT=y
> CONFIG_EFI_RUNTIME_WRAPPERS=y
> CONFIG_EFI_GENERIC_STUB=y
> # CONFIG_EFI_ZBOOT is not set
> CONFIG_EFI_BOOTLOADER_CONTROL=y
> CONFIG_EFI_CAPSULE_LOADER=y
> CONFIG_EFI_TEST=y
> # CONFIG_RESET_ATTACK_MITIGATION is not set
> # CONFIG_EFI_RCI2_TABLE is not set
> # CONFIG_EFI_DISABLE_PCI_DMA is not set
> CONFIG_EFI_EARLYCON=y
> # CONFIG_EFI_DISABLE_RUNTIME is not set
> # CONFIG_EFI_COCO_SECRET is not set
> # end of EFI (Extensible Firmware Interface) Support
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
> CONFIG_GNSS_SIRF_SERIAL=y
> CONFIG_GNSS_UBX_SERIAL=y
> CONFIG_MTD=y
> CONFIG_MTD_TESTS=m
> 
> #
> # Partition parsers
> #
> CONFIG_MTD_AR7_PARTS=y
> # CONFIG_MTD_BCM63XX_PARTS is not set
> # CONFIG_MTD_BRCM_U_BOOT is not set
> CONFIG_MTD_CMDLINE_PARTS=y
> CONFIG_MTD_OF_PARTS=y
> # CONFIG_MTD_OF_PARTS_BCM4908 is not set
> # CONFIG_MTD_OF_PARTS_LINKSYS_NS is not set
> # CONFIG_MTD_PARSER_IMAGETAG is not set
> # CONFIG_MTD_PARSER_TRX is not set
> # CONFIG_MTD_SHARPSL_PARTS is not set
> # CONFIG_MTD_REDBOOT_PARTS is not set
> # end of Partition parsers
> 
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_BLKDEVS=y
> CONFIG_MTD_BLOCK=y
> 
> #
> # Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
> #
> CONFIG_FTL=y
> CONFIG_NFTL=y
> CONFIG_NFTL_RW=y
> CONFIG_INFTL=y
> CONFIG_RFD_FTL=m
> # CONFIG_SSFDC is not set
> CONFIG_SM_FTL=m
> CONFIG_MTD_OOPS=m
> CONFIG_MTD_PSTORE=y
> CONFIG_MTD_PARTITIONED_MASTER=y
> 
> #
> # RAM/ROM/Flash chip drivers
> #
> CONFIG_MTD_CFI=m
> CONFIG_MTD_JEDECPROBE=m
> CONFIG_MTD_GEN_PROBE=m
> CONFIG_MTD_CFI_ADV_OPTIONS=y
> # CONFIG_MTD_CFI_NOSWAP is not set
> # CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
> CONFIG_MTD_CFI_LE_BYTE_SWAP=y
> CONFIG_MTD_CFI_GEOMETRY=y
> # CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
> CONFIG_MTD_MAP_BANK_WIDTH_2=y
> # CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
> CONFIG_MTD_MAP_BANK_WIDTH_8=y
> # CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
> CONFIG_MTD_MAP_BANK_WIDTH_32=y
> # CONFIG_MTD_CFI_I1 is not set
> CONFIG_MTD_CFI_I2=y
> # CONFIG_MTD_CFI_I4 is not set
> CONFIG_MTD_CFI_I8=y
> # CONFIG_MTD_OTP is not set
> CONFIG_MTD_CFI_INTELEXT=m
> CONFIG_MTD_CFI_AMDSTD=m
> CONFIG_MTD_CFI_STAA=m
> CONFIG_MTD_CFI_UTIL=m
> CONFIG_MTD_RAM=y
> CONFIG_MTD_ROM=y
> CONFIG_MTD_ABSENT=m
> # end of RAM/ROM/Flash chip drivers
> 
> #
> # Mapping drivers for chip access
> #
> CONFIG_MTD_COMPLEX_MAPPINGS=y
> # CONFIG_MTD_PHYSMAP is not set
> # CONFIG_MTD_SC520CDP is not set
> # CONFIG_MTD_NETSC520 is not set
> # CONFIG_MTD_TS5500 is not set
> # CONFIG_MTD_PCI is not set
> CONFIG_MTD_INTEL_VR_NOR=m
> # CONFIG_MTD_PLATRAM is not set
> # end of Mapping drivers for chip access
> 
> #
> # Self-contained MTD device drivers
> #
> # CONFIG_MTD_PMC551 is not set
> CONFIG_MTD_SPEAR_SMI=y
> CONFIG_MTD_SLRAM=m
> CONFIG_MTD_PHRAM=m
> # CONFIG_MTD_MTDRAM is not set
> CONFIG_MTD_BLOCK2MTD=m
> 
> #
> # Disk-On-Chip Device Drivers
> #
> CONFIG_MTD_DOCG3=m
> CONFIG_BCH_CONST_M=14
> CONFIG_BCH_CONST_T=4
> # end of Self-contained MTD device drivers
> 
> #
> # NAND
> #
> CONFIG_MTD_NAND_CORE=y
> CONFIG_MTD_ONENAND=y
> CONFIG_MTD_ONENAND_VERIFY_WRITE=y
> # CONFIG_MTD_ONENAND_GENERIC is not set
> # CONFIG_MTD_ONENAND_SAMSUNG is not set
> # CONFIG_MTD_ONENAND_OTP is not set
> CONFIG_MTD_ONENAND_2X_PROGRAM=y
> CONFIG_MTD_RAW_NAND=m
> 
> #
> # Raw/parallel NAND flash controllers
> #
> CONFIG_MTD_NAND_DENALI=m
> CONFIG_MTD_NAND_DENALI_PCI=m
> CONFIG_MTD_NAND_DENALI_DT=m
> CONFIG_MTD_NAND_AMS_DELTA=m
> # CONFIG_MTD_NAND_SHARPSL is not set
> # CONFIG_MTD_NAND_CAFE is not set
> # CONFIG_MTD_NAND_ATMEL is not set
> # CONFIG_MTD_NAND_MARVELL is not set
> # CONFIG_MTD_NAND_SLC_LPC32XX is not set
> # CONFIG_MTD_NAND_MLC_LPC32XX is not set
> # CONFIG_MTD_NAND_BRCMNAND is not set
> # CONFIG_MTD_NAND_OXNAS is not set
> # CONFIG_MTD_NAND_FSL_IFC is not set
> # CONFIG_MTD_NAND_VF610_NFC is not set
> # CONFIG_MTD_NAND_MXC is not set
> # CONFIG_MTD_NAND_SH_FLCTL is not set
> # CONFIG_MTD_NAND_DAVINCI is not set
> # CONFIG_MTD_NAND_TXX9NDFMC is not set
> # CONFIG_MTD_NAND_FSMC is not set
> # CONFIG_MTD_NAND_SUNXI is not set
> # CONFIG_MTD_NAND_HISI504 is not set
> # CONFIG_MTD_NAND_QCOM is not set
> CONFIG_MTD_NAND_MXIC=m
> # CONFIG_MTD_NAND_TEGRA is not set
> # CONFIG_MTD_NAND_STM32_FMC2 is not set
> # CONFIG_MTD_NAND_MESON is not set
> CONFIG_MTD_NAND_GPIO=m
> CONFIG_MTD_NAND_PLATFORM=m
> # CONFIG_MTD_NAND_CADENCE is not set
> CONFIG_MTD_NAND_ARASAN=m
> # CONFIG_MTD_NAND_INTEL_LGM is not set
> # CONFIG_MTD_NAND_RENESAS is not set
> 
> #
> # Misc
> #
> CONFIG_MTD_SM_COMMON=m
> CONFIG_MTD_NAND_NANDSIM=m
> CONFIG_MTD_NAND_RICOH=m
> CONFIG_MTD_NAND_DISKONCHIP=m
> CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
> CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
> CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH=y
> # CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
> 
> #
> # ECC engine support
> #
> CONFIG_MTD_NAND_ECC=y
> CONFIG_MTD_NAND_ECC_SW_HAMMING=y
> # CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
> CONFIG_MTD_NAND_ECC_SW_BCH=y
> # CONFIG_MTD_NAND_ECC_MXIC is not set
> # CONFIG_MTD_NAND_ECC_MEDIATEK is not set
> # end of ECC engine support
> # end of NAND
> 
> #
> # LPDDR & LPDDR2 PCM memory drivers
> #
> CONFIG_MTD_LPDDR=m
> CONFIG_MTD_QINFO_PROBE=m
> # end of LPDDR & LPDDR2 PCM memory drivers
> 
> CONFIG_MTD_UBI=y
> CONFIG_MTD_UBI_WL_THRESHOLD=4096
> CONFIG_MTD_UBI_BEB_LIMIT=20
> # CONFIG_MTD_UBI_FASTMAP is not set
> CONFIG_MTD_UBI_GLUEBI=m
> CONFIG_MTD_UBI_BLOCK=y
> CONFIG_MTD_HYPERBUS=m
> # CONFIG_HBMC_AM654 is not set
> CONFIG_DTC=y
> CONFIG_OF=y
> CONFIG_OF_UNITTEST=y
> # CONFIG_OF_ALL_DTBS is not set
> CONFIG_OF_FLATTREE=y
> CONFIG_OF_EARLY_FLATTREE=y
> CONFIG_OF_KOBJ=y
> CONFIG_OF_DYNAMIC=y
> CONFIG_OF_ADDRESS=y
> CONFIG_OF_IRQ=y
> CONFIG_OF_RESERVED_MEM=y
> CONFIG_OF_RESOLVE=y
> CONFIG_OF_OVERLAY=y
> CONFIG_OF_DMA_DEFAULT_COHERENT=y
> CONFIG_PARPORT=y
> # CONFIG_PARPORT_PC is not set
> CONFIG_PARPORT_AX88796=m
> CONFIG_PARPORT_1284=y
> CONFIG_PARPORT_NOT_PC=y
> # CONFIG_BLK_DEV is not set
> 
> #
> # NVME Support
> #
> CONFIG_NVME_CORE=m
> CONFIG_BLK_DEV_NVME=m
> # CONFIG_NVME_MULTIPATH is not set
> # CONFIG_NVME_VERBOSE_ERRORS is not set
> # CONFIG_NVME_HWMON is not set
> # CONFIG_NVME_FC is not set
> # CONFIG_NVME_AUTH is not set
> CONFIG_NVME_TARGET=m
> # CONFIG_NVME_TARGET_PASSTHRU is not set
> # CONFIG_NVME_TARGET_LOOP is not set
> CONFIG_NVME_TARGET_FC=m
> # CONFIG_NVME_TARGET_AUTH is not set
> # end of NVME Support
> 
> #
> # Misc devices
> #
> CONFIG_SENSORS_LIS3LV02D=y
> CONFIG_AD525X_DPOT=m
> CONFIG_AD525X_DPOT_I2C=m
> # CONFIG_DUMMY_IRQ is not set
> # CONFIG_PHANTOM is not set
> # CONFIG_TIFM_CORE is not set
> # CONFIG_ICS932S401 is not set
> # CONFIG_ATMEL_SSC is not set
> CONFIG_ENCLOSURE_SERVICES=m
> CONFIG_HP_ILO=m
> # CONFIG_QCOM_COINCELL is not set
> # CONFIG_QCOM_FASTRPC is not set
> CONFIG_APDS9802ALS=y
> # CONFIG_ISL29003 is not set
> CONFIG_ISL29020=m
> CONFIG_SENSORS_TSL2550=m
> CONFIG_SENSORS_BH1770=m
> # CONFIG_SENSORS_APDS990X is not set
> # CONFIG_HMC6352 is not set
> CONFIG_DS1682=m
> # CONFIG_PCH_PHUB is not set
> # CONFIG_SRAM is not set
> # CONFIG_DW_XDATA_PCIE is not set
> CONFIG_PCI_ENDPOINT_TEST=y
> # CONFIG_XILINX_SDFEC is not set
> # CONFIG_OPEN_DICE is not set
> # CONFIG_VCPU_STALL_DETECTOR is not set
> # CONFIG_C2PORT is not set
> 
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_AT24 is not set
> CONFIG_EEPROM_LEGACY=m
> # CONFIG_EEPROM_MAX6875 is not set
> CONFIG_EEPROM_93CX6=y
> # CONFIG_EEPROM_IDT_89HPESX is not set
> CONFIG_EEPROM_EE1004=m
> # end of EEPROM support
> 
> CONFIG_CB710_CORE=m
> # CONFIG_CB710_DEBUG is not set
> CONFIG_CB710_DEBUG_ASSUMPTIONS=y
> 
> #
> # Texas Instruments shared transport line discipline
> #
> # end of Texas Instruments shared transport line discipline
> 
> CONFIG_SENSORS_LIS3_I2C=y
> # CONFIG_ALTERA_STAPL is not set
> # CONFIG_GENWQE is not set
> CONFIG_ECHO=y
> CONFIG_BCM_VK=m
> CONFIG_BCM_VK_TTY=y
> CONFIG_MISC_ALCOR_PCI=m
> # CONFIG_MISC_RTSX_PCI is not set
> CONFIG_HABANA_AI=m
> CONFIG_PVPANIC=y
> CONFIG_PVPANIC_MMIO=m
> CONFIG_PVPANIC_PCI=m
> # CONFIG_GP_PCI1XXXX is not set
> # end of Misc devices
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> CONFIG_RAID_ATTRS=y
> CONFIG_SCSI_COMMON=y
> CONFIG_SCSI=y
> CONFIG_SCSI_DMA=y
> # CONFIG_SCSI_PROC_FS is not set
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> # CONFIG_BLK_DEV_SD is not set
> # CONFIG_CHR_DEV_ST is not set
> CONFIG_CHR_DEV_SG=m
> CONFIG_BLK_DEV_BSG=y
> # CONFIG_CHR_DEV_SCH is not set
> CONFIG_SCSI_ENCLOSURE=m
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
> CONFIG_SCSI_SCAN_ASYNC=y
> 
> #
> # SCSI Transports
> #
> CONFIG_SCSI_SPI_ATTRS=y
> CONFIG_SCSI_SAS_ATTRS=y
> # CONFIG_SCSI_SAS_LIBSAS is not set
> CONFIG_SCSI_SRP_ATTRS=m
> # end of SCSI Transports
> 
> # CONFIG_SCSI_LOWLEVEL is not set
> # CONFIG_SCSI_DH is not set
> # end of SCSI device support
> 
> CONFIG_ATA=y
> CONFIG_SATA_HOST=y
> CONFIG_PATA_TIMINGS=y
> CONFIG_ATA_VERBOSE_ERROR=y
> CONFIG_ATA_FORCE=y
> # CONFIG_SATA_PMP is not set
> 
> #
> # Controllers with non-SFF native interface
> #
> CONFIG_SATA_AHCI=m
> CONFIG_SATA_MOBILE_LPM_POLICY=0
> CONFIG_SATA_AHCI_PLATFORM=y
> # CONFIG_AHCI_BRCM is not set
> # CONFIG_AHCI_DA850 is not set
> # CONFIG_AHCI_DM816 is not set
> # CONFIG_AHCI_DWC is not set
> # CONFIG_AHCI_ST is not set
> # CONFIG_AHCI_IMX is not set
> # CONFIG_AHCI_CEVA is not set
> # CONFIG_AHCI_MTK is not set
> # CONFIG_AHCI_MVEBU is not set
> # CONFIG_AHCI_SUNXI is not set
> # CONFIG_AHCI_TEGRA is not set
> # CONFIG_AHCI_XGENE is not set
> CONFIG_AHCI_QORIQ=m
> # CONFIG_SATA_FSL is not set
> # CONFIG_SATA_GEMINI is not set
> # CONFIG_SATA_AHCI_SEATTLE is not set
> # CONFIG_SATA_INIC162X is not set
> CONFIG_SATA_ACARD_AHCI=y
> # CONFIG_SATA_SIL24 is not set
> CONFIG_ATA_SFF=y
> 
> #
> # SFF controllers with custom DMA interface
> #
> # CONFIG_PDC_ADMA is not set
> # CONFIG_SATA_QSTOR is not set
> CONFIG_SATA_SX4=y
> # CONFIG_ATA_BMDMA is not set
> 
> #
> # PIO-only SFF controllers
> #
> # CONFIG_PATA_CMD640_PCI is not set
> # CONFIG_PATA_IXP4XX_CF is not set
> # CONFIG_PATA_MPIIX is not set
> CONFIG_PATA_NS87410=y
> CONFIG_PATA_OPTI=m
> # CONFIG_PATA_OF_PLATFORM is not set
> # CONFIG_PATA_RZ1000 is not set
> # CONFIG_PATA_SAMSUNG_CF is not set
> 
> #
> # Generic fallback / legacy drivers
> #
> CONFIG_PATA_LEGACY=y
> # CONFIG_MD is not set
> CONFIG_TARGET_CORE=m
> # CONFIG_TCM_IBLOCK is not set
> # CONFIG_TCM_FILEIO is not set
> CONFIG_TCM_PSCSI=m
> # CONFIG_LOOPBACK_TARGET is not set
> CONFIG_SBP_TARGET=m
> # CONFIG_FUSION is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> CONFIG_FIREWIRE=m
> # CONFIG_FIREWIRE_OHCI is not set
> CONFIG_FIREWIRE_SBP2=m
> CONFIG_FIREWIRE_NOSY=m
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
> CONFIG_INPUT_VIVALDIFMAP=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=m
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_JOYDEV=y
> # CONFIG_INPUT_EVDEV is not set
> CONFIG_INPUT_EVBUG=y
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ADC=m
> CONFIG_KEYBOARD_ADP5588=y
> CONFIG_KEYBOARD_ADP5589=y
> CONFIG_KEYBOARD_ATKBD=y
> CONFIG_KEYBOARD_QT1050=m
> CONFIG_KEYBOARD_QT1070=y
> CONFIG_KEYBOARD_QT2160=y
> # CONFIG_KEYBOARD_CLPS711X is not set
> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_EP93XX is not set
> CONFIG_KEYBOARD_GPIO=y
> CONFIG_KEYBOARD_GPIO_POLLED=m
> # CONFIG_KEYBOARD_TCA6416 is not set
> CONFIG_KEYBOARD_TCA8418=y
> # CONFIG_KEYBOARD_MATRIX is not set
> # CONFIG_KEYBOARD_LM8323 is not set
> # CONFIG_KEYBOARD_LM8333 is not set
> CONFIG_KEYBOARD_MAX7359=m
> CONFIG_KEYBOARD_MCS=y
> CONFIG_KEYBOARD_MPR121=m
> # CONFIG_KEYBOARD_SNVS_PWRKEY is not set
> # CONFIG_KEYBOARD_IMX is not set
> CONFIG_KEYBOARD_NEWTON=y
> CONFIG_KEYBOARD_OPENCORES=m
> # CONFIG_KEYBOARD_SAMSUNG is not set
> # CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
> CONFIG_KEYBOARD_STOWAWAY=y
> # CONFIG_KEYBOARD_ST_KEYSCAN is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_SH_KEYSC is not set
> CONFIG_KEYBOARD_OMAP4=y
> # CONFIG_KEYBOARD_TC3589X is not set
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> # CONFIG_KEYBOARD_TWL4030 is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> CONFIG_KEYBOARD_CAP11XX=y
> # CONFIG_KEYBOARD_BCM is not set
> # CONFIG_KEYBOARD_MT6779 is not set
> CONFIG_KEYBOARD_MTK_PMIC=m
> # CONFIG_KEYBOARD_CYPRESS_SF is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=m
> CONFIG_MOUSE_PS2_ALPS=y
> CONFIG_MOUSE_PS2_BYD=y
> # CONFIG_MOUSE_PS2_LOGIPS2PP is not set
> CONFIG_MOUSE_PS2_SYNAPTICS=y
> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
> CONFIG_MOUSE_PS2_CYPRESS=y
> # CONFIG_MOUSE_PS2_TRACKPOINT is not set
> CONFIG_MOUSE_PS2_ELANTECH=y
> # CONFIG_MOUSE_PS2_ELANTECH_SMBUS is not set
> CONFIG_MOUSE_PS2_SENTELIC=y
> # CONFIG_MOUSE_PS2_TOUCHKIT is not set
> # CONFIG_MOUSE_PS2_FOCALTECH is not set
> CONFIG_MOUSE_PS2_SMBUS=y
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_CYAPA is not set
> # CONFIG_MOUSE_ELAN_I2C is not set
> CONFIG_MOUSE_VSXXXAA=y
> CONFIG_MOUSE_GPIO=m
> CONFIG_MOUSE_SYNAPTICS_I2C=m
> CONFIG_INPUT_JOYSTICK=y
> CONFIG_JOYSTICK_ANALOG=y
> CONFIG_JOYSTICK_A3D=y
> CONFIG_JOYSTICK_ADC=m
> # CONFIG_JOYSTICK_ADI is not set
> # CONFIG_JOYSTICK_COBRA is not set
> CONFIG_JOYSTICK_GF2K=y
> CONFIG_JOYSTICK_GRIP=y
> # CONFIG_JOYSTICK_GRIP_MP is not set
> CONFIG_JOYSTICK_GUILLEMOT=m
> CONFIG_JOYSTICK_INTERACT=m
> CONFIG_JOYSTICK_SIDEWINDER=m
> CONFIG_JOYSTICK_TMDC=y
> CONFIG_JOYSTICK_IFORCE=y
> CONFIG_JOYSTICK_IFORCE_232=m
> # CONFIG_JOYSTICK_WARRIOR is not set
> # CONFIG_JOYSTICK_MAGELLAN is not set
> CONFIG_JOYSTICK_SPACEORB=m
> CONFIG_JOYSTICK_SPACEBALL=m
> # CONFIG_JOYSTICK_STINGER is not set
> CONFIG_JOYSTICK_TWIDJOY=y
> CONFIG_JOYSTICK_ZHENHUA=y
> CONFIG_JOYSTICK_DB9=m
> # CONFIG_JOYSTICK_GAMECON is not set
> CONFIG_JOYSTICK_TURBOGRAFX=m
> # CONFIG_JOYSTICK_AS5011 is not set
> CONFIG_JOYSTICK_JOYDUMP=m
> CONFIG_JOYSTICK_QWIIC=m
> CONFIG_JOYSTICK_FSIA6B=y
> # CONFIG_JOYSTICK_SENSEHAT is not set
> # CONFIG_INPUT_TABLET is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_AD714X=y
> # CONFIG_INPUT_AD714X_I2C is not set
> # CONFIG_INPUT_ATMEL_CAPTOUCH is not set
> CONFIG_INPUT_BMA150=m
> # CONFIG_INPUT_E3X0_BUTTON is not set
> CONFIG_INPUT_MAX77650_ONKEY=m
> # CONFIG_INPUT_MAX77693_HAPTIC is not set
> CONFIG_INPUT_MAX8997_HAPTIC=y
> CONFIG_INPUT_MC13783_PWRBUTTON=y
> CONFIG_INPUT_MMA8450=m
> # CONFIG_INPUT_GPIO_BEEPER is not set
> # CONFIG_INPUT_GPIO_DECODER is not set
> CONFIG_INPUT_GPIO_VIBRA=m
> CONFIG_INPUT_KXTJ9=y
> CONFIG_INPUT_RETU_PWRBUTTON=y
> CONFIG_INPUT_TPS65218_PWRBUTTON=y
> CONFIG_INPUT_AXP20X_PEK=m
> # CONFIG_INPUT_TWL4030_PWRBUTTON is not set
> # CONFIG_INPUT_TWL4030_VIBRA is not set
> CONFIG_INPUT_UINPUT=y
> CONFIG_INPUT_PCF8574=y
> CONFIG_INPUT_PWM_BEEPER=y
> CONFIG_INPUT_PWM_VIBRA=m
> # CONFIG_INPUT_RK805_PWRKEY is not set
> # CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
> CONFIG_INPUT_DA7280_HAPTICS=m
> CONFIG_INPUT_DA9055_ONKEY=m
> CONFIG_INPUT_DA9063_ONKEY=m
> CONFIG_INPUT_WM831X_ON=y
> CONFIG_INPUT_ADXL34X=m
> CONFIG_INPUT_ADXL34X_I2C=m
> # CONFIG_INPUT_IBM_PANEL is not set
> CONFIG_INPUT_IQS269A=y
> CONFIG_INPUT_IQS626A=m
> # CONFIG_INPUT_IQS7222 is not set
> CONFIG_INPUT_CMA3000=m
> CONFIG_INPUT_CMA3000_I2C=m
> CONFIG_INPUT_DRV260X_HAPTICS=m
> # CONFIG_INPUT_DRV2665_HAPTICS is not set
> CONFIG_INPUT_DRV2667_HAPTICS=m
> # CONFIG_INPUT_HISI_POWERKEY is not set
> CONFIG_INPUT_RAVE_SP_PWRBUTTON=m
> # CONFIG_INPUT_SC27XX_VIBRA is not set
> # CONFIG_INPUT_RT5120_PWRKEY is not set
> CONFIG_INPUT_STPMIC1_ONKEY=m
> CONFIG_RMI4_CORE=m
> CONFIG_RMI4_I2C=m
> CONFIG_RMI4_SMB=m
> # CONFIG_RMI4_F03 is not set
> CONFIG_RMI4_2D_SENSOR=y
> CONFIG_RMI4_F11=y
> # CONFIG_RMI4_F12 is not set
> # CONFIG_RMI4_F30 is not set
> CONFIG_RMI4_F34=y
> # CONFIG_RMI4_F3A is not set
> # CONFIG_RMI4_F55 is not set
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_SERIO_SERPORT=m
> CONFIG_SERIO_PARKBD=y
> CONFIG_SERIO_PCIPS2=m
> CONFIG_SERIO_LIBPS2=y
> CONFIG_SERIO_RAW=y
> CONFIG_SERIO_ALTERA_PS2=y
> CONFIG_SERIO_PS2MULT=y
> CONFIG_SERIO_ARC_PS2=y
> # CONFIG_SERIO_APBPS2 is not set
> # CONFIG_SERIO_OLPC_APSP is not set
> # CONFIG_SERIO_SUN4I_PS2 is not set
> CONFIG_SERIO_GPIO_PS2=y
> CONFIG_USERIO=y
> CONFIG_GAMEPORT=y
> CONFIG_GAMEPORT_NS558=m
> # CONFIG_GAMEPORT_L4 is not set
> CONFIG_GAMEPORT_EMU10K1=y
> CONFIG_GAMEPORT_FM801=m
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
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256
> CONFIG_LDISC_AUTOLOAD=y
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> # CONFIG_SERIAL_8250 is not set
> 
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_AMBA_PL010 is not set
> # CONFIG_SERIAL_EARLYCON_RISCV_SBI is not set
> # CONFIG_SERIAL_ATMEL is not set
> CONFIG_SERIAL_KGDB_NMI=y
> # CONFIG_SERIAL_MESON is not set
> # CONFIG_SERIAL_CLPS711X is not set
> # CONFIG_SERIAL_SAMSUNG is not set
> # CONFIG_SERIAL_TEGRA is not set
> # CONFIG_SERIAL_TEGRA_TCU is not set
> # CONFIG_SERIAL_IMX is not set
> # CONFIG_SERIAL_IMX_EARLYCON is not set
> CONFIG_SERIAL_UARTLITE=m
> CONFIG_SERIAL_UARTLITE_NR_UARTS=1
> # CONFIG_SERIAL_SH_SCI is not set
> # CONFIG_SERIAL_HS_LPC32XX is not set
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_CONSOLE_POLL=y
> # CONFIG_SERIAL_ICOM is not set
> # CONFIG_SERIAL_JSM is not set
> # CONFIG_SERIAL_MSM is not set
> # CONFIG_SERIAL_VT8500 is not set
> # CONFIG_SERIAL_OMAP is not set
> CONFIG_SERIAL_SIFIVE=y
> CONFIG_SERIAL_SIFIVE_CONSOLE=y
> # CONFIG_SERIAL_LANTIQ is not set
> CONFIG_SERIAL_SCCNXP=y
> CONFIG_SERIAL_SCCNXP_CONSOLE=y
> CONFIG_SERIAL_SC16IS7XX=y
> # CONFIG_SERIAL_SC16IS7XX_I2C is not set
> # CONFIG_SERIAL_TIMBERDALE is not set
> CONFIG_SERIAL_BCM63XX=m
> CONFIG_SERIAL_ALTERA_JTAGUART=m
> CONFIG_SERIAL_ALTERA_UART=y
> CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
> CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
> CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
> # CONFIG_SERIAL_PCH_UART is not set
> # CONFIG_SERIAL_MXS_AUART is not set
> CONFIG_SERIAL_XILINX_PS_UART=y
> CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
> # CONFIG_SERIAL_MPS2_UART is not set
> CONFIG_SERIAL_ARC=m
> CONFIG_SERIAL_ARC_NR_PORTS=1
> # CONFIG_SERIAL_RP2 is not set
> CONFIG_SERIAL_FSL_LPUART=y
> CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> CONFIG_SERIAL_CONEXANT_DIGICOLOR=m
> # CONFIG_SERIAL_ST_ASC is not set
> CONFIG_SERIAL_MEN_Z135=m
> # CONFIG_SERIAL_SPRD is not set
> # CONFIG_SERIAL_STM32 is not set
> # CONFIG_SERIAL_MVEBU_UART is not set
> # CONFIG_SERIAL_OWL is not set
> # CONFIG_SERIAL_RDA is not set
> # CONFIG_SERIAL_MILBEAUT_USIO is not set
> # CONFIG_SERIAL_LITEUART is not set
> # CONFIG_SERIAL_SUNPLUS is not set
> # end of Serial drivers
> 
> # CONFIG_SERIAL_NONSTANDARD is not set
> CONFIG_NOZOMI=y
> CONFIG_NULL_TTY=y
> CONFIG_HVC_DRIVER=y
> CONFIG_HVC_RISCV_SBI=y
> # CONFIG_RPMSG_TTY is not set
> CONFIG_SERIAL_DEV_BUS=y
> # CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set
> CONFIG_TTY_PRINTK=m
> CONFIG_TTY_PRINTK_LEVEL=6
> CONFIG_PRINTER=y
> # CONFIG_LP_CONSOLE is not set
> CONFIG_PPDEV=y
> CONFIG_VIRTIO_CONSOLE=y
> # CONFIG_IPMI_HANDLER is not set
> # CONFIG_ASPEED_KCS_IPMI_BMC is not set
> # CONFIG_NPCM7XX_KCS_IPMI_BMC is not set
> # CONFIG_ASPEED_BT_IPMI_BMC is not set
> CONFIG_IPMB_DEVICE_INTERFACE=y
> CONFIG_HW_RANDOM=m
> CONFIG_HW_RANDOM_TIMERIOMEM=m
> CONFIG_HW_RANDOM_ATMEL=m
> CONFIG_HW_RANDOM_BA431=m
> CONFIG_HW_RANDOM_BCM2835=m
> CONFIG_HW_RANDOM_IPROC_RNG200=m
> CONFIG_HW_RANDOM_IXP4XX=m
> CONFIG_HW_RANDOM_OMAP=m
> CONFIG_HW_RANDOM_OMAP3_ROM=m
> # CONFIG_HW_RANDOM_VIRTIO is not set
> CONFIG_HW_RANDOM_IMX_RNGC=m
> CONFIG_HW_RANDOM_NOMADIK=m
> CONFIG_HW_RANDOM_STM32=m
> CONFIG_HW_RANDOM_MESON=m
> CONFIG_HW_RANDOM_MTK=m
> CONFIG_HW_RANDOM_EXYNOS=m
> CONFIG_HW_RANDOM_NPCM=m
> CONFIG_HW_RANDOM_KEYSTONE=m
> # CONFIG_HW_RANDOM_CCTRNG is not set
> CONFIG_HW_RANDOM_XIPHERA=m
> CONFIG_HW_RANDOM_CN10K=m
> CONFIG_APPLICOM=y
> # CONFIG_DEVMEM is not set
> # CONFIG_DEVPORT is not set
> CONFIG_TCG_TPM=y
> # CONFIG_TCG_TIS is not set
> # CONFIG_TCG_TIS_I2C is not set
> # CONFIG_TCG_TIS_SYNQUACER is not set
> CONFIG_TCG_TIS_I2C_CR50=m
> CONFIG_TCG_TIS_I2C_ATMEL=m
> CONFIG_TCG_TIS_I2C_INFINEON=y
> # CONFIG_TCG_TIS_I2C_NUVOTON is not set
> # CONFIG_TCG_ATMEL is not set
> # CONFIG_TCG_VTPM_PROXY is not set
> CONFIG_TCG_TIS_ST33ZP24=m
> CONFIG_TCG_TIS_ST33ZP24_I2C=m
> # CONFIG_XILLYBUS is not set
> CONFIG_RANDOM_TRUST_CPU=y
> # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
> # end of Character devices
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_COMPAT=y
> CONFIG_I2C_CHARDEV=m
> CONFIG_I2C_MUX=m
> 
> #
> # Multiplexer I2C Chip support
> #
> # CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
> CONFIG_I2C_MUX_GPIO=m
> CONFIG_I2C_MUX_GPMUX=m
> # CONFIG_I2C_MUX_LTC4306 is not set
> CONFIG_I2C_MUX_PCA9541=m
> CONFIG_I2C_MUX_PCA954x=m
> # CONFIG_I2C_MUX_PINCTRL is not set
> CONFIG_I2C_MUX_REG=m
> CONFIG_I2C_DEMUX_PINCTRL=m
> CONFIG_I2C_MUX_MLXCPLD=m
> # end of Multiplexer I2C Chip support
> 
> # CONFIG_I2C_HELPER_AUTO is not set
> CONFIG_I2C_SMBUS=m
> 
> #
> # I2C Algorithms
> #
> CONFIG_I2C_ALGOBIT=y
> CONFIG_I2C_ALGOPCF=y
> CONFIG_I2C_ALGOPCA=y
> # end of I2C Algorithms
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # PC SMBus host controller drivers
> #
> CONFIG_I2C_CCGX_UCSI=m
> CONFIG_I2C_ALI1535=m
> CONFIG_I2C_ALI1563=m
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> CONFIG_I2C_AMD8111=y
> # CONFIG_I2C_HIX5HD2 is not set
> CONFIG_I2C_I801=m
> # CONFIG_I2C_ISCH is not set
> CONFIG_I2C_PIIX4=y
> CONFIG_I2C_NFORCE2=m
> CONFIG_I2C_NVIDIA_GPU=m
> CONFIG_I2C_SIS5595=m
> CONFIG_I2C_SIS630=y
> CONFIG_I2C_SIS96X=y
> CONFIG_I2C_VIA=y
> CONFIG_I2C_VIAPRO=y
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_ALTERA is not set
> # CONFIG_I2C_ASPEED is not set
> # CONFIG_I2C_AT91 is not set
> # CONFIG_I2C_AXXIA is not set
> # CONFIG_I2C_BCM2835 is not set
> # CONFIG_I2C_BCM_IPROC is not set
> # CONFIG_I2C_BCM_KONA is not set
> CONFIG_I2C_BRCMSTB=y
> # CONFIG_I2C_CADENCE is not set
> CONFIG_I2C_CBUS_GPIO=m
> # CONFIG_I2C_DAVINCI is not set
> CONFIG_I2C_DESIGNWARE_CORE=y
> CONFIG_I2C_DESIGNWARE_SLAVE=y
> CONFIG_I2C_DESIGNWARE_PLATFORM=y
> # CONFIG_I2C_DESIGNWARE_PCI is not set
> # CONFIG_I2C_DIGICOLOR is not set
> # CONFIG_I2C_EG20T is not set
> CONFIG_I2C_EMEV2=m
> # CONFIG_I2C_EXYNOS5 is not set
> CONFIG_I2C_GPIO=m
> CONFIG_I2C_GPIO_FAULT_INJECTOR=y
> # CONFIG_I2C_HIGHLANDER is not set
> # CONFIG_I2C_HISI is not set
> # CONFIG_I2C_IMG is not set
> # CONFIG_I2C_IMX is not set
> # CONFIG_I2C_IMX_LPI2C is not set
> # CONFIG_I2C_IOP3XX is not set
> # CONFIG_I2C_JZ4780 is not set
> CONFIG_I2C_KEMPLD=y
> # CONFIG_I2C_LPC2K is not set
> # CONFIG_I2C_MESON is not set
> # CONFIG_I2C_MICROCHIP_CORE is not set
> # CONFIG_I2C_MT65XX is not set
> # CONFIG_I2C_MT7621 is not set
> # CONFIG_I2C_MV64XXX is not set
> # CONFIG_I2C_MXS is not set
> # CONFIG_I2C_NPCM is not set
> CONFIG_I2C_OCORES=y
> # CONFIG_I2C_OMAP is not set
> # CONFIG_I2C_OWL is not set
> # CONFIG_I2C_APPLE is not set
> CONFIG_I2C_PCA_PLATFORM=y
> # CONFIG_I2C_PNX is not set
> # CONFIG_I2C_PXA is not set
> # CONFIG_I2C_QCOM_CCI is not set
> # CONFIG_I2C_QUP is not set
> # CONFIG_I2C_RIIC is not set
> CONFIG_I2C_RK3X=y
> # CONFIG_I2C_RZV2M is not set
> # CONFIG_I2C_S3C2410 is not set
> # CONFIG_I2C_SH_MOBILE is not set
> CONFIG_I2C_SIMTEC=m
> # CONFIG_I2C_SPRD is not set
> # CONFIG_I2C_ST is not set
> # CONFIG_I2C_STM32F4 is not set
> # CONFIG_I2C_STM32F7 is not set
> # CONFIG_I2C_SUN6I_P2WI is not set
> # CONFIG_I2C_SYNQUACER is not set
> # CONFIG_I2C_TEGRA is not set
> # CONFIG_I2C_TEGRA_BPMP is not set
> # CONFIG_I2C_UNIPHIER is not set
> # CONFIG_I2C_UNIPHIER_F is not set
> # CONFIG_I2C_VERSATILE is not set
> # CONFIG_I2C_WMT is not set
> # CONFIG_I2C_THUNDERX is not set
> # CONFIG_I2C_XILINX is not set
> # CONFIG_I2C_XLP9XX is not set
> # CONFIG_I2C_RCAR is not set
> 
> #
> # External I2C/SMBus adapter drivers
> #
> CONFIG_I2C_PARPORT=m
> # CONFIG_I2C_PCI1XXXX is not set
> CONFIG_I2C_TAOS_EVM=m
> 
> #
> # Other I2C/SMBus bus drivers
> #
> # CONFIG_I2C_MLXCPLD is not set
> CONFIG_I2C_FSI=y
> # CONFIG_I2C_VIRTIO is not set
> # end of I2C Hardware Bus support
> 
> CONFIG_I2C_STUB=m
> CONFIG_I2C_SLAVE=y
> CONFIG_I2C_SLAVE_EEPROM=y
> # CONFIG_I2C_SLAVE_TESTUNIT is not set
> CONFIG_I2C_DEBUG_CORE=y
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # end of I2C support
> 
> CONFIG_I3C=m
> CONFIG_CDNS_I3C_MASTER=m
> CONFIG_DW_I3C_MASTER=m
> CONFIG_SVC_I3C_MASTER=m
> # CONFIG_MIPI_I3C_HCI is not set
> # CONFIG_SPI is not set
> # CONFIG_SPMI is not set
> # CONFIG_HSI is not set
> # CONFIG_PPS is not set
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
> # CONFIG_PINCTRL_AT91PIO4 is not set
> # CONFIG_PINCTRL_AXP209 is not set
> # CONFIG_PINCTRL_BM1880 is not set
> # CONFIG_PINCTRL_CY8C95X0 is not set
> # CONFIG_PINCTRL_DA850_PUPD is not set
> # CONFIG_PINCTRL_DA9062 is not set
> # CONFIG_PINCTRL_EQUILIBRIUM is not set
> # CONFIG_PINCTRL_INGENIC is not set
> # CONFIG_PINCTRL_LPC18XX is not set
> CONFIG_PINCTRL_MAX77620=m
> CONFIG_PINCTRL_MCP23S08_I2C=m
> CONFIG_PINCTRL_MCP23S08=m
> # CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
> # CONFIG_PINCTRL_OCELOT is not set
> # CONFIG_PINCTRL_PISTACHIO is not set
> # CONFIG_PINCTRL_RK805 is not set
> # CONFIG_PINCTRL_ROCKCHIP is not set
> CONFIG_PINCTRL_SINGLE=m
> CONFIG_PINCTRL_STMFX=y
> # CONFIG_PINCTRL_SX150X is not set
> # CONFIG_PINCTRL_OWL is not set
> # CONFIG_PINCTRL_ASPEED_G4 is not set
> # CONFIG_PINCTRL_ASPEED_G5 is not set
> # CONFIG_PINCTRL_ASPEED_G6 is not set
> # CONFIG_PINCTRL_BCM281XX is not set
> # CONFIG_PINCTRL_BCM2835 is not set
> # CONFIG_PINCTRL_BCM4908 is not set
> # CONFIG_PINCTRL_BCM6318 is not set
> # CONFIG_PINCTRL_BCM6328 is not set
> # CONFIG_PINCTRL_BCM6358 is not set
> # CONFIG_PINCTRL_BCM6362 is not set
> # CONFIG_PINCTRL_BCM6368 is not set
> # CONFIG_PINCTRL_BCM63268 is not set
> # CONFIG_PINCTRL_IPROC_GPIO is not set
> # CONFIG_PINCTRL_CYGNUS_MUX is not set
> # CONFIG_PINCTRL_NS is not set
> # CONFIG_PINCTRL_NSP_GPIO is not set
> # CONFIG_PINCTRL_NS2_MUX is not set
> # CONFIG_PINCTRL_NSP_MUX is not set
> # CONFIG_PINCTRL_AS370 is not set
> # CONFIG_PINCTRL_BERLIN_BG4CT is not set
> CONFIG_PINCTRL_MADERA=y
> CONFIG_PINCTRL_CS47L15=y
> CONFIG_PINCTRL_CS47L90=y
> 
> #
> # Intel pinctrl drivers
> #
> # end of Intel pinctrl drivers
> 
> #
> # MediaTek pinctrl drivers
> #
> CONFIG_EINT_MTK=y
> CONFIG_PINCTRL_MTK=y
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
> CONFIG_PINCTRL_MT6397=y
> # end of MediaTek pinctrl drivers
> 
> CONFIG_PINCTRL_MESON=y
> # CONFIG_PINCTRL_WPCM450 is not set
> # CONFIG_PINCTRL_NPCM7XX is not set
> # CONFIG_PINCTRL_PXA25X is not set
> # CONFIG_PINCTRL_PXA27X is not set
> # CONFIG_PINCTRL_MSM is not set
> # CONFIG_PINCTRL_QCOM_SSBI_PMIC is not set
> # CONFIG_PINCTRL_LPASS_LPI is not set
> 
> #
> # Renesas pinctrl drivers
> #
> # CONFIG_PINCTRL_RENESAS is not set
> # CONFIG_PINCTRL_PFC_EMEV2 is not set
> # CONFIG_PINCTRL_PFC_R8A77995 is not set
> # CONFIG_PINCTRL_PFC_R8A7794 is not set
> # CONFIG_PINCTRL_PFC_R8A77990 is not set
> # CONFIG_PINCTRL_PFC_R8A7779 is not set
> # CONFIG_PINCTRL_PFC_R8A7790 is not set
> # CONFIG_PINCTRL_PFC_R8A77950 is not set
> # CONFIG_PINCTRL_PFC_R8A77951 is not set
> # CONFIG_PINCTRL_PFC_R8A7778 is not set
> # CONFIG_PINCTRL_PFC_R8A7793 is not set
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
> # CONFIG_PINCTRL_PFC_R8A7740 is not set
> # CONFIG_PINCTRL_PFC_R8A73A4 is not set
> # CONFIG_PINCTRL_RZA1 is not set
> # CONFIG_PINCTRL_RZA2 is not set
> # CONFIG_PINCTRL_RZG2L is not set
> # CONFIG_PINCTRL_PFC_R8A77470 is not set
> # CONFIG_PINCTRL_PFC_R8A7745 is not set
> # CONFIG_PINCTRL_PFC_R8A7742 is not set
> # CONFIG_PINCTRL_PFC_R8A7743 is not set
> # CONFIG_PINCTRL_PFC_R8A7744 is not set
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
> # CONFIG_PINCTRL_PFC_SH73A0 is not set
> # CONFIG_PINCTRL_PFC_SH7723 is not set
> # CONFIG_PINCTRL_PFC_SH7724 is not set
> # CONFIG_PINCTRL_PFC_SHX3 is not set
> # end of Renesas pinctrl drivers
> 
> # CONFIG_PINCTRL_EXYNOS is not set
> # CONFIG_PINCTRL_S3C24XX is not set
> # CONFIG_PINCTRL_S3C64XX is not set
> # CONFIG_PINCTRL_SPRD_SC9860 is not set
> # CONFIG_PINCTRL_STARFIVE_JH7100 is not set
> # CONFIG_PINCTRL_STM32F429 is not set
> # CONFIG_PINCTRL_STM32F469 is not set
> # CONFIG_PINCTRL_STM32F746 is not set
> # CONFIG_PINCTRL_STM32F769 is not set
> # CONFIG_PINCTRL_STM32H743 is not set
> # CONFIG_PINCTRL_STM32MP135 is not set
> # CONFIG_PINCTRL_STM32MP157 is not set
> # CONFIG_PINCTRL_TI_IODELAY is not set
> CONFIG_PINCTRL_UNIPHIER=y
> # CONFIG_PINCTRL_UNIPHIER_LD4 is not set
> # CONFIG_PINCTRL_UNIPHIER_PRO4 is not set
> # CONFIG_PINCTRL_UNIPHIER_SLD8 is not set
> # CONFIG_PINCTRL_UNIPHIER_PRO5 is not set
> # CONFIG_PINCTRL_UNIPHIER_PXS2 is not set
> # CONFIG_PINCTRL_UNIPHIER_LD6B is not set
> # CONFIG_PINCTRL_UNIPHIER_LD11 is not set
> # CONFIG_PINCTRL_UNIPHIER_LD20 is not set
> # CONFIG_PINCTRL_UNIPHIER_PXS3 is not set
> # CONFIG_PINCTRL_UNIPHIER_NX1 is not set
> # CONFIG_PINCTRL_TMPV7700 is not set
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_OF_GPIO=y
> CONFIG_GPIOLIB_IRQCHIP=y
> # CONFIG_DEBUG_GPIO is not set
> CONFIG_GPIO_SYSFS=y
> CONFIG_GPIO_CDEV=y
> CONFIG_GPIO_CDEV_V1=y
> CONFIG_GPIO_GENERIC=y
> CONFIG_GPIO_MAX730X=y
> 
> #
> # Memory mapped GPIO drivers
> #
> CONFIG_GPIO_74XX_MMIO=y
> CONFIG_GPIO_ALTERA=m
> # CONFIG_GPIO_ASPEED is not set
> # CONFIG_GPIO_ASPEED_SGPIO is not set
> # CONFIG_GPIO_ATH79 is not set
> # CONFIG_GPIO_RASPBERRYPI_EXP is not set
> # CONFIG_GPIO_BCM_KONA is not set
> # CONFIG_GPIO_BCM_XGS_IPROC is not set
> # CONFIG_GPIO_BRCMSTB is not set
> CONFIG_GPIO_CADENCE=m
> # CONFIG_GPIO_CLPS711X is not set
> CONFIG_GPIO_DWAPB=m
> # CONFIG_GPIO_EIC_SPRD is not set
> # CONFIG_GPIO_EM is not set
> CONFIG_GPIO_FTGPIO010=y
> CONFIG_GPIO_GENERIC_PLATFORM=m
> CONFIG_GPIO_GRGPIO=m
> # CONFIG_GPIO_HISI is not set
> CONFIG_GPIO_HLWD=y
> # CONFIG_GPIO_IOP is not set
> CONFIG_GPIO_LOGICVC=m
> # CONFIG_GPIO_LPC18XX is not set
> # CONFIG_GPIO_LPC32XX is not set
> CONFIG_GPIO_MB86S7X=m
> # CONFIG_GPIO_MENZ127 is not set
> # CONFIG_GPIO_MPC8XXX is not set
> # CONFIG_GPIO_MT7621 is not set
> # CONFIG_GPIO_MXC is not set
> # CONFIG_GPIO_MXS is not set
> # CONFIG_GPIO_PMIC_EIC_SPRD is not set
> # CONFIG_GPIO_PXA is not set
> # CONFIG_GPIO_RCAR is not set
> # CONFIG_GPIO_RDA is not set
> # CONFIG_GPIO_ROCKCHIP is not set
> # CONFIG_GPIO_SAMA5D2_PIOBU is not set
> # CONFIG_GPIO_SIFIVE is not set
> # CONFIG_GPIO_SIOX is not set
> # CONFIG_GPIO_SNPS_CREG is not set
> # CONFIG_GPIO_SPRD is not set
> # CONFIG_GPIO_STP_XWAY is not set
> CONFIG_GPIO_SYSCON=y
> # CONFIG_GPIO_TEGRA is not set
> # CONFIG_GPIO_TEGRA186 is not set
> # CONFIG_GPIO_TS4800 is not set
> # CONFIG_GPIO_THUNDERX is not set
> # CONFIG_GPIO_UNIPHIER is not set
> # CONFIG_GPIO_VISCONTI is not set
> # CONFIG_GPIO_VX855 is not set
> # CONFIG_GPIO_WCD934X is not set
> # CONFIG_GPIO_XGENE_SB is not set
> # CONFIG_GPIO_XILINX is not set
> # CONFIG_GPIO_XLP is not set
> CONFIG_GPIO_AMD_FCH=y
> # CONFIG_GPIO_IDT3243X is not set
> # end of Memory mapped GPIO drivers
> 
> #
> # I2C GPIO expanders
> #
> # CONFIG_GPIO_ADNP is not set
> CONFIG_GPIO_GW_PLD=y
> CONFIG_GPIO_MAX7300=y
> CONFIG_GPIO_MAX732X=y
> CONFIG_GPIO_MAX732X_IRQ=y
> CONFIG_GPIO_PCA953X=m
> # CONFIG_GPIO_PCA953X_IRQ is not set
> # CONFIG_GPIO_PCA9570 is not set
> # CONFIG_GPIO_PCF857X is not set
> CONFIG_GPIO_TPIC2810=m
> # CONFIG_GPIO_TS4900 is not set
> # end of I2C GPIO expanders
> 
> #
> # MFD GPIO expanders
> #
> CONFIG_GPIO_ARIZONA=m
> CONFIG_GPIO_BD71815=m
> CONFIG_GPIO_BD71828=m
> CONFIG_GPIO_DA9055=m
> CONFIG_GPIO_JANZ_TTL=m
> CONFIG_GPIO_KEMPLD=m
> CONFIG_GPIO_LP3943=y
> CONFIG_GPIO_LP873X=m
> CONFIG_GPIO_LP87565=y
> # CONFIG_GPIO_MADERA is not set
> # CONFIG_GPIO_MAX77620 is not set
> CONFIG_GPIO_MAX77650=m
> # CONFIG_GPIO_SL28CPLD is not set
> CONFIG_GPIO_TC3589X=y
> # CONFIG_GPIO_TPS65218 is not set
> # CONFIG_GPIO_TPS65912 is not set
> CONFIG_GPIO_TQMX86=m
> # CONFIG_GPIO_TWL4030 is not set
> # CONFIG_GPIO_WM831X is not set
> CONFIG_GPIO_WM8350=y
> CONFIG_GPIO_WM8994=m
> # end of MFD GPIO expanders
> 
> #
> # PCI GPIO expanders
> #
> # CONFIG_GPIO_AMD8111 is not set
> CONFIG_GPIO_BT8XX=m
> # CONFIG_GPIO_MLXBF is not set
> # CONFIG_GPIO_MLXBF2 is not set
> # CONFIG_GPIO_ML_IOH is not set
> # CONFIG_GPIO_PCH is not set
> CONFIG_GPIO_PCI_IDIO_16=y
> # CONFIG_GPIO_PCIE_IDIO_24 is not set
> CONFIG_GPIO_RDC321X=y
> # end of PCI GPIO expanders
> 
> #
> # Virtual GPIO drivers
> #
> CONFIG_GPIO_AGGREGATOR=m
> CONFIG_GPIO_MOCKUP=y
> CONFIG_GPIO_VIRTIO=m
> # CONFIG_GPIO_SIM is not set
> # end of Virtual GPIO drivers
> 
> CONFIG_W1=y
> 
> #
> # 1-wire Bus Masters
> #
> # CONFIG_W1_MASTER_MATROX is not set
> # CONFIG_W1_MASTER_DS2482 is not set
> # CONFIG_W1_MASTER_MXC is not set
> CONFIG_W1_MASTER_DS1WM=y
> CONFIG_W1_MASTER_GPIO=m
> CONFIG_W1_MASTER_SGI=m
> # end of 1-wire Bus Masters
> 
> #
> # 1-wire Slaves
> #
> CONFIG_W1_SLAVE_THERM=y
> # CONFIG_W1_SLAVE_SMEM is not set
> # CONFIG_W1_SLAVE_DS2405 is not set
> # CONFIG_W1_SLAVE_DS2408 is not set
> # CONFIG_W1_SLAVE_DS2413 is not set
> CONFIG_W1_SLAVE_DS2406=y
> CONFIG_W1_SLAVE_DS2423=m
> # CONFIG_W1_SLAVE_DS2805 is not set
> # CONFIG_W1_SLAVE_DS2430 is not set
> # CONFIG_W1_SLAVE_DS2431 is not set
> # CONFIG_W1_SLAVE_DS2433 is not set
> # CONFIG_W1_SLAVE_DS2438 is not set
> CONFIG_W1_SLAVE_DS250X=y
> CONFIG_W1_SLAVE_DS2780=m
> CONFIG_W1_SLAVE_DS2781=y
> CONFIG_W1_SLAVE_DS28E04=y
> CONFIG_W1_SLAVE_DS28E17=y
> # end of 1-wire Slaves
> 
> CONFIG_POWER_RESET=y
> # CONFIG_POWER_RESET_BRCMKONA is not set
> # CONFIG_POWER_RESET_BRCMSTB is not set
> # CONFIG_POWER_RESET_GEMINI_POWEROFF is not set
> CONFIG_POWER_RESET_GPIO=y
> CONFIG_POWER_RESET_GPIO_RESTART=y
> # CONFIG_POWER_RESET_OCELOT_RESET is not set
> # CONFIG_POWER_RESET_PIIX4_POWEROFF is not set
> # CONFIG_POWER_RESET_LTC2952 is not set
> # CONFIG_POWER_RESET_MT6323 is not set
> # CONFIG_POWER_RESET_RESTART is not set
> # CONFIG_POWER_RESET_KEYSTONE is not set
> # CONFIG_POWER_RESET_SYSCON is not set
> CONFIG_POWER_RESET_SYSCON_POWEROFF=y
> # CONFIG_POWER_RESET_RMOBILE is not set
> CONFIG_REBOOT_MODE=y
> CONFIG_SYSCON_REBOOT_MODE=y
> # CONFIG_POWER_RESET_SC27XX is not set
> CONFIG_NVMEM_REBOOT_MODE=m
> CONFIG_POWER_SUPPLY=y
> CONFIG_POWER_SUPPLY_DEBUG=y
> # CONFIG_POWER_SUPPLY_HWMON is not set
> CONFIG_PDA_POWER=y
> # CONFIG_GENERIC_ADC_BATTERY is not set
> # CONFIG_IP5XXX_POWER is not set
> CONFIG_WM831X_BACKUP=m
> CONFIG_WM831X_POWER=m
> # CONFIG_WM8350_POWER is not set
> # CONFIG_TEST_POWER is not set
> CONFIG_CHARGER_ADP5061=y
> # CONFIG_BATTERY_ACT8945A is not set
> # CONFIG_BATTERY_CW2015 is not set
> CONFIG_BATTERY_DS2760=y
> # CONFIG_BATTERY_DS2780 is not set
> CONFIG_BATTERY_DS2781=y
> CONFIG_BATTERY_DS2782=y
> # CONFIG_BATTERY_LEGO_EV3 is not set
> # CONFIG_BATTERY_SAMSUNG_SDI is not set
> CONFIG_BATTERY_SBS=y
> CONFIG_CHARGER_SBS=y
> # CONFIG_MANAGER_SBS is not set
> CONFIG_BATTERY_BQ27XXX=y
> CONFIG_BATTERY_BQ27XXX_I2C=m
> CONFIG_BATTERY_BQ27XXX_HDQ=m
> CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
> CONFIG_AXP20X_POWER=m
> CONFIG_BATTERY_MAX17040=m
> # CONFIG_BATTERY_MAX17042 is not set
> # CONFIG_BATTERY_MAX1721X is not set
> # CONFIG_BATTERY_TWL4030_MADC is not set
> CONFIG_BATTERY_RX51=m
> # CONFIG_CHARGER_MAX8903 is not set
> # CONFIG_CHARGER_TWL4030 is not set
> CONFIG_CHARGER_LP8727=m
> CONFIG_CHARGER_GPIO=m
> CONFIG_CHARGER_LT3651=m
> CONFIG_CHARGER_LTC4162L=m
> CONFIG_CHARGER_MAX14577=m
> CONFIG_CHARGER_DETECTOR_MAX14656=m
> CONFIG_CHARGER_MAX77650=m
> CONFIG_CHARGER_MAX77693=m
> # CONFIG_CHARGER_MAX77976 is not set
> # CONFIG_CHARGER_BQ2415X is not set
> CONFIG_CHARGER_BQ24190=m
> # CONFIG_CHARGER_BQ24257 is not set
> CONFIG_CHARGER_BQ24735=y
> CONFIG_CHARGER_BQ2515X=m
> CONFIG_CHARGER_BQ25890=m
> # CONFIG_CHARGER_BQ25980 is not set
> # CONFIG_CHARGER_BQ256XX is not set
> # CONFIG_CHARGER_RK817 is not set
> CONFIG_CHARGER_TPS65090=y
> # CONFIG_BATTERY_GAUGE_LTC2941 is not set
> CONFIG_BATTERY_GOLDFISH=m
> # CONFIG_BATTERY_RT5033 is not set
> CONFIG_CHARGER_RT9455=y
> # CONFIG_CHARGER_SC2731 is not set
> # CONFIG_FUEL_GAUGE_SC27XX is not set
> # CONFIG_CHARGER_BD99954 is not set
> CONFIG_RN5T618_POWER=m
> # CONFIG_BATTERY_UG3105 is not set
> CONFIG_HWMON=y
> CONFIG_HWMON_VID=y
> CONFIG_HWMON_DEBUG_CHIP=y
> 
> #
> # Native drivers
> #
> CONFIG_SENSORS_AD7414=m
> # CONFIG_SENSORS_AD7418 is not set
> CONFIG_SENSORS_ADM1025=y
> CONFIG_SENSORS_ADM1026=y
> # CONFIG_SENSORS_ADM1029 is not set
> CONFIG_SENSORS_ADM1031=m
> CONFIG_SENSORS_ADM1177=m
> # CONFIG_SENSORS_ADM9240 is not set
> CONFIG_SENSORS_ADT7X10=m
> CONFIG_SENSORS_ADT7410=m
> # CONFIG_SENSORS_ADT7411 is not set
> # CONFIG_SENSORS_ADT7462 is not set
> CONFIG_SENSORS_ADT7470=m
> # CONFIG_SENSORS_ADT7475 is not set
> CONFIG_SENSORS_AHT10=y
> CONFIG_SENSORS_AS370=y
> CONFIG_SENSORS_ASC7621=m
> CONFIG_SENSORS_AXI_FAN_CONTROL=y
> # CONFIG_SENSORS_ASB100 is not set
> CONFIG_SENSORS_ASPEED=m
> CONFIG_SENSORS_ATXP1=m
> # CONFIG_SENSORS_BT1_PVT is not set
> # CONFIG_SENSORS_CORSAIR_CPRO is not set
> CONFIG_SENSORS_CORSAIR_PSU=m
> # CONFIG_SENSORS_DRIVETEMP is not set
> # CONFIG_SENSORS_DS620 is not set
> CONFIG_SENSORS_DS1621=y
> CONFIG_SENSORS_DA9055=y
> CONFIG_SENSORS_I5K_AMB=m
> # CONFIG_SENSORS_SPARX5 is not set
> CONFIG_SENSORS_F71805F=m
> # CONFIG_SENSORS_F71882FG is not set
> # CONFIG_SENSORS_F75375S is not set
> CONFIG_SENSORS_GSC=m
> CONFIG_SENSORS_MC13783_ADC=y
> # CONFIG_SENSORS_FSCHMD is not set
> CONFIG_SENSORS_GL518SM=y
> CONFIG_SENSORS_GL520SM=y
> CONFIG_SENSORS_G760A=m
> CONFIG_SENSORS_G762=m
> CONFIG_SENSORS_GPIO_FAN=m
> CONFIG_SENSORS_HIH6130=y
> # CONFIG_SENSORS_IIO_HWMON is not set
> CONFIG_SENSORS_IT87=m
> CONFIG_SENSORS_JC42=m
> CONFIG_SENSORS_POWR1220=m
> # CONFIG_SENSORS_LAN966X is not set
> CONFIG_SENSORS_LINEAGE=m
> CONFIG_SENSORS_LTC2945=m
> # CONFIG_SENSORS_LTC2947_I2C is not set
> CONFIG_SENSORS_LTC2990=y
> CONFIG_SENSORS_LTC2992=m
> CONFIG_SENSORS_LTC4151=m
> # CONFIG_SENSORS_LTC4215 is not set
> # CONFIG_SENSORS_LTC4222 is not set
> CONFIG_SENSORS_LTC4245=y
> CONFIG_SENSORS_LTC4260=m
> # CONFIG_SENSORS_LTC4261 is not set
> CONFIG_SENSORS_MAX127=m
> CONFIG_SENSORS_MAX16065=m
> # CONFIG_SENSORS_MAX1619 is not set
> CONFIG_SENSORS_MAX1668=y
> # CONFIG_SENSORS_MAX197 is not set
> CONFIG_SENSORS_MAX31730=m
> # CONFIG_SENSORS_MAX31760 is not set
> # CONFIG_SENSORS_MAX6620 is not set
> CONFIG_SENSORS_MAX6621=m
> # CONFIG_SENSORS_MAX6639 is not set
> CONFIG_SENSORS_MAX6650=m
> CONFIG_SENSORS_MAX6697=m
> # CONFIG_SENSORS_MAX31790 is not set
> CONFIG_SENSORS_MCP3021=y
> # CONFIG_SENSORS_TC654 is not set
> # CONFIG_SENSORS_TPS23861 is not set
> CONFIG_SENSORS_MR75203=m
> CONFIG_SENSORS_LM63=m
> CONFIG_SENSORS_LM73=m
> CONFIG_SENSORS_LM75=m
> CONFIG_SENSORS_LM77=m
> # CONFIG_SENSORS_LM78 is not set
> CONFIG_SENSORS_LM80=y
> CONFIG_SENSORS_LM83=m
> CONFIG_SENSORS_LM85=m
> CONFIG_SENSORS_LM87=y
> CONFIG_SENSORS_LM90=y
> CONFIG_SENSORS_LM92=y
> CONFIG_SENSORS_LM93=y
> CONFIG_SENSORS_LM95234=m
> # CONFIG_SENSORS_LM95241 is not set
> CONFIG_SENSORS_LM95245=y
> # CONFIG_SENSORS_PC87360 is not set
> CONFIG_SENSORS_PC87427=m
> CONFIG_SENSORS_NTC_THERMISTOR=m
> CONFIG_SENSORS_NCT6683=y
> CONFIG_SENSORS_NCT6775_CORE=m
> CONFIG_SENSORS_NCT6775=m
> # CONFIG_SENSORS_NCT6775_I2C is not set
> # CONFIG_SENSORS_NCT7802 is not set
> CONFIG_SENSORS_NPCM7XX=m
> # CONFIG_SENSORS_NSA320 is not set
> # CONFIG_SENSORS_OCC_P8_I2C is not set
> # CONFIG_SENSORS_OCC_P9_SBE is not set
> CONFIG_SENSORS_PCF8591=m
> CONFIG_PMBUS=m
> CONFIG_SENSORS_PMBUS=m
> CONFIG_SENSORS_ADM1266=m
> CONFIG_SENSORS_ADM1275=m
> # CONFIG_SENSORS_BEL_PFE is not set
> # CONFIG_SENSORS_BPA_RS600 is not set
> # CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
> CONFIG_SENSORS_FSP_3Y=m
> CONFIG_SENSORS_IBM_CFFPS=m
> # CONFIG_SENSORS_DPS920AB is not set
> CONFIG_SENSORS_INSPUR_IPSPS=m
> # CONFIG_SENSORS_IR35221 is not set
> CONFIG_SENSORS_IR36021=m
> CONFIG_SENSORS_IR38064=m
> # CONFIG_SENSORS_IRPS5401 is not set
> CONFIG_SENSORS_ISL68137=m
> CONFIG_SENSORS_LM25066=m
> # CONFIG_SENSORS_LT7182S is not set
> CONFIG_SENSORS_LTC2978=m
> CONFIG_SENSORS_LTC3815=m
> # CONFIG_SENSORS_MAX15301 is not set
> CONFIG_SENSORS_MAX16064=m
> # CONFIG_SENSORS_MAX16601 is not set
> # CONFIG_SENSORS_MAX20730 is not set
> CONFIG_SENSORS_MAX20751=m
> CONFIG_SENSORS_MAX31785=m
> CONFIG_SENSORS_MAX34440=m
> # CONFIG_SENSORS_MAX8688 is not set
> CONFIG_SENSORS_MP2888=m
> # CONFIG_SENSORS_MP2975 is not set
> # CONFIG_SENSORS_MP5023 is not set
> CONFIG_SENSORS_PIM4328=m
> # CONFIG_SENSORS_PLI1209BC is not set
> CONFIG_SENSORS_PM6764TR=m
> CONFIG_SENSORS_PXE1610=m
> # CONFIG_SENSORS_Q54SJ108A2 is not set
> # CONFIG_SENSORS_STPDDC60 is not set
> # CONFIG_SENSORS_TPS40422 is not set
> CONFIG_SENSORS_TPS53679=m
> # CONFIG_SENSORS_TPS546D24 is not set
> CONFIG_SENSORS_UCD9000=m
> CONFIG_SENSORS_UCD9200=m
> # CONFIG_SENSORS_XDPE152 is not set
> CONFIG_SENSORS_XDPE122=m
> CONFIG_SENSORS_ZL6100=m
> CONFIG_SENSORS_PWM_FAN=m
> # CONFIG_SENSORS_RASPBERRYPI_HWMON is not set
> # CONFIG_SENSORS_SL28CPLD is not set
> CONFIG_SENSORS_SBTSI=y
> CONFIG_SENSORS_SBRMI=y
> # CONFIG_SENSORS_SHT15 is not set
> CONFIG_SENSORS_SHT21=y
> CONFIG_SENSORS_SHT3x=y
> CONFIG_SENSORS_SHT4x=m
> CONFIG_SENSORS_SHTC1=m
> # CONFIG_SENSORS_SIS5595 is not set
> CONFIG_SENSORS_DME1737=y
> CONFIG_SENSORS_EMC1403=m
> CONFIG_SENSORS_EMC2103=m
> # CONFIG_SENSORS_EMC2305 is not set
> CONFIG_SENSORS_EMC6W201=y
> # CONFIG_SENSORS_SMSC47M1 is not set
> CONFIG_SENSORS_SMSC47M192=m
> CONFIG_SENSORS_SMSC47B397=y
> # CONFIG_SENSORS_STTS751 is not set
> CONFIG_SENSORS_SMM665=y
> # CONFIG_SENSORS_ADC128D818 is not set
> CONFIG_SENSORS_ADS7828=m
> CONFIG_SENSORS_AMC6821=m
> CONFIG_SENSORS_INA209=y
> CONFIG_SENSORS_INA2XX=m
> # CONFIG_SENSORS_INA238 is not set
> CONFIG_SENSORS_INA3221=y
> # CONFIG_SENSORS_TC74 is not set
> CONFIG_SENSORS_THMC50=m
> CONFIG_SENSORS_TMP102=y
> # CONFIG_SENSORS_TMP103 is not set
> CONFIG_SENSORS_TMP108=m
> # CONFIG_SENSORS_TMP401 is not set
> # CONFIG_SENSORS_TMP421 is not set
> # CONFIG_SENSORS_TMP464 is not set
> # CONFIG_SENSORS_TMP513 is not set
> CONFIG_SENSORS_VIA686A=y
> CONFIG_SENSORS_VT1211=y
> # CONFIG_SENSORS_VT8231 is not set
> # CONFIG_SENSORS_W83773G is not set
> # CONFIG_SENSORS_W83781D is not set
> # CONFIG_SENSORS_W83791D is not set
> CONFIG_SENSORS_W83792D=m
> CONFIG_SENSORS_W83793=y
> # CONFIG_SENSORS_W83795 is not set
> CONFIG_SENSORS_W83L785TS=m
> CONFIG_SENSORS_W83L786NG=y
> # CONFIG_SENSORS_W83627HF is not set
> CONFIG_SENSORS_W83627EHF=m
> # CONFIG_SENSORS_WM831X is not set
> CONFIG_SENSORS_WM8350=m
> # CONFIG_THERMAL is not set
> # CONFIG_WATCHDOG is not set
> CONFIG_SSB_POSSIBLE=y
> CONFIG_SSB=m
> CONFIG_SSB_PCIHOST_POSSIBLE=y
> # CONFIG_SSB_PCIHOST is not set
> CONFIG_SSB_DRIVER_GPIO=y
> CONFIG_BCMA_POSSIBLE=y
> CONFIG_BCMA=m
> CONFIG_BCMA_HOST_PCI_POSSIBLE=y
> CONFIG_BCMA_HOST_PCI=y
> # CONFIG_BCMA_HOST_SOC is not set
> CONFIG_BCMA_DRIVER_PCI=y
> # CONFIG_BCMA_DRIVER_MIPS is not set
> CONFIG_BCMA_DRIVER_GMAC_CMN=y
> CONFIG_BCMA_DRIVER_GPIO=y
> CONFIG_BCMA_DEBUG=y
> 
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=y
> # CONFIG_MFD_ACT8945A is not set
> # CONFIG_MFD_SUN4I_GPADC is not set
> CONFIG_MFD_AS3711=y
> # CONFIG_MFD_AS3722 is not set
> # CONFIG_PMIC_ADP5520 is not set
> # CONFIG_MFD_AAT2870_CORE is not set
> # CONFIG_MFD_AT91_USART is not set
> CONFIG_MFD_ATMEL_FLEXCOM=y
> CONFIG_MFD_ATMEL_HLCDC=y
> # CONFIG_MFD_BCM590XX is not set
> # CONFIG_MFD_BD9571MWV is not set
> CONFIG_MFD_AXP20X=m
> CONFIG_MFD_AXP20X_I2C=m
> CONFIG_MFD_MADERA=y
> CONFIG_MFD_MADERA_I2C=m
> CONFIG_MFD_CS47L15=y
> # CONFIG_MFD_CS47L35 is not set
> # CONFIG_MFD_CS47L85 is not set
> CONFIG_MFD_CS47L90=y
> # CONFIG_MFD_CS47L92 is not set
> # CONFIG_MFD_ASIC3 is not set
> # CONFIG_PMIC_DA903X is not set
> # CONFIG_MFD_DA9052_I2C is not set
> CONFIG_MFD_DA9055=y
> CONFIG_MFD_DA9062=m
> # CONFIG_MFD_DA9063 is not set
> # CONFIG_MFD_DA9150 is not set
> # CONFIG_MFD_ENE_KB3930 is not set
> # CONFIG_MFD_EXYNOS_LPASS is not set
> CONFIG_MFD_GATEWORKS_GSC=m
> CONFIG_MFD_MC13XXX=y
> CONFIG_MFD_MC13XXX_I2C=y
> CONFIG_MFD_MP2629=y
> # CONFIG_MFD_MXS_LRADC is not set
> # CONFIG_MFD_MX25_TSADC is not set
> CONFIG_MFD_HI6421_PMIC=y
> # CONFIG_MFD_HI655X_PMIC is not set
> CONFIG_HTC_PASIC3=y
> # CONFIG_HTC_I2CPLD is not set
> # CONFIG_LPC_ICH is not set
> CONFIG_LPC_SCH=y
> # CONFIG_INTEL_SOC_PMIC is not set
> # CONFIG_MFD_IQS62X is not set
> CONFIG_MFD_JANZ_CMODIO=y
> CONFIG_MFD_KEMPLD=y
> # CONFIG_MFD_88PM800 is not set
> CONFIG_MFD_88PM805=m
> # CONFIG_MFD_88PM860X is not set
> CONFIG_MFD_MAX14577=m
> CONFIG_MFD_MAX77620=y
> CONFIG_MFD_MAX77650=y
> CONFIG_MFD_MAX77686=m
> CONFIG_MFD_MAX77693=m
> # CONFIG_MFD_MAX77714 is not set
> CONFIG_MFD_MAX77843=y
> CONFIG_MFD_MAX8907=m
> # CONFIG_MFD_MAX8925 is not set
> CONFIG_MFD_MAX8997=y
> CONFIG_MFD_MAX8998=y
> # CONFIG_MFD_MT6360 is not set
> # CONFIG_MFD_MT6370 is not set
> CONFIG_MFD_MT6397=y
> # CONFIG_MFD_MENF21BMC is not set
> CONFIG_MFD_NTXEC=y
> CONFIG_MFD_RETU=y
> # CONFIG_MFD_PCF50633 is not set
> # CONFIG_MFD_PM8XXX is not set
> # CONFIG_MFD_SY7636A is not set
> CONFIG_MFD_RDC321X=y
> # CONFIG_MFD_RT4831 is not set
> CONFIG_MFD_RT5033=y
> # CONFIG_MFD_RT5120 is not set
> # CONFIG_MFD_RC5T583 is not set
> CONFIG_MFD_RK808=m
> CONFIG_MFD_RN5T618=m
> CONFIG_MFD_SEC_CORE=m
> # CONFIG_MFD_SI476X_CORE is not set
> # CONFIG_MFD_SL28CPLD is not set
> CONFIG_MFD_SM501=y
> # CONFIG_MFD_SM501_GPIO is not set
> CONFIG_MFD_SKY81452=y
> # CONFIG_ABX500_CORE is not set
> # CONFIG_MFD_STMPE is not set
> # CONFIG_MFD_SUN6I_PRCM is not set
> CONFIG_MFD_SYSCON=y
> CONFIG_MFD_TI_AM335X_TSCADC=y
> CONFIG_MFD_LP3943=y
> # CONFIG_MFD_LP8788 is not set
> CONFIG_MFD_TI_LMU=y
> # CONFIG_MFD_PALMAS is not set
> # CONFIG_TPS6105X is not set
> # CONFIG_TPS65010 is not set
> CONFIG_TPS6507X=m
> # CONFIG_MFD_TPS65086 is not set
> CONFIG_MFD_TPS65090=y
> # CONFIG_MFD_TPS65217 is not set
> CONFIG_MFD_TI_LP873X=y
> CONFIG_MFD_TI_LP87565=y
> CONFIG_MFD_TPS65218=y
> # CONFIG_MFD_TPS6586X is not set
> # CONFIG_MFD_TPS65910 is not set
> CONFIG_MFD_TPS65912=y
> CONFIG_MFD_TPS65912_I2C=y
> CONFIG_TWL4030_CORE=y
> # CONFIG_MFD_TWL4030_AUDIO is not set
> # CONFIG_TWL6040_CORE is not set
> # CONFIG_MFD_WL1273_CORE is not set
> CONFIG_MFD_LM3533=y
> # CONFIG_MFD_TIMBERDALE is not set
> CONFIG_MFD_TC3589X=y
> CONFIG_MFD_TQMX86=m
> CONFIG_MFD_VX855=m
> # CONFIG_MFD_LOCHNAGAR is not set
> CONFIG_MFD_ARIZONA=y
> CONFIG_MFD_ARIZONA_I2C=y
> # CONFIG_MFD_CS47L24 is not set
> # CONFIG_MFD_WM5102 is not set
> # CONFIG_MFD_WM5110 is not set
> CONFIG_MFD_WM8997=y
> # CONFIG_MFD_WM8998 is not set
> CONFIG_MFD_WM8400=y
> CONFIG_MFD_WM831X=y
> CONFIG_MFD_WM831X_I2C=y
> CONFIG_MFD_WM8350=y
> CONFIG_MFD_WM8350_I2C=y
> CONFIG_MFD_WM8994=y
> # CONFIG_MFD_STW481X is not set
> # CONFIG_MFD_ROHM_BD718XX is not set
> CONFIG_MFD_ROHM_BD71828=m
> # CONFIG_MFD_ROHM_BD957XMUF is not set
> # CONFIG_MFD_STM32_LPTIMER is not set
> # CONFIG_MFD_STM32_TIMERS is not set
> CONFIG_MFD_STPMIC1=m
> CONFIG_MFD_STMFX=y
> CONFIG_MFD_WCD934X=m
> # CONFIG_MFD_ATC260X_I2C is not set
> # CONFIG_MFD_KHADAS_MCU is not set
> # CONFIG_MFD_ACER_A500_EC is not set
> CONFIG_MFD_QCOM_PM8008=y
> CONFIG_RAVE_SP_CORE=m
> # CONFIG_MFD_RSMU_I2C is not set
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
> CONFIG_APERTURE_HELPERS=y
> # CONFIG_IMX_IPUV3_CORE is not set
> # CONFIG_DRM is not set
> CONFIG_DRM_DEBUG_MODESET_LOCK=y
> 
> #
> # ARM devices
> #
> # end of ARM devices
> 
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
> 
> #
> # Frame buffer Devices
> #
> CONFIG_FB_CMDLINE=y
> CONFIG_FB_NOTIFY=y
> CONFIG_FB=y
> CONFIG_FIRMWARE_EDID=y
> CONFIG_FB_DDC=y
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
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
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CLPS711X is not set
> # CONFIG_FB_IMX is not set
> CONFIG_FB_CYBER2000=m
> CONFIG_FB_CYBER2000_DDC=y
> # CONFIG_FB_ARC is not set
> # CONFIG_FB_CONTROL is not set
> CONFIG_FB_ASILIANT=y
> # CONFIG_FB_IMSTT is not set
> CONFIG_FB_EFI=y
> # CONFIG_FB_GBE is not set
> # CONFIG_FB_PVR2 is not set
> # CONFIG_FB_OPENCORES is not set
> CONFIG_FB_S1D13XXX=y
> # CONFIG_FB_ATMEL is not set
> # CONFIG_FB_NVIDIA is not set
> CONFIG_FB_RIVA=m
> CONFIG_FB_RIVA_I2C=y
> CONFIG_FB_RIVA_DEBUG=y
> CONFIG_FB_RIVA_BACKLIGHT=y
> CONFIG_FB_I740=y
> CONFIG_FB_MATROX=m
> # CONFIG_FB_MATROX_MILLENIUM is not set
> # CONFIG_FB_MATROX_MYSTIQUE is not set
> # CONFIG_FB_MATROX_G is not set
> # CONFIG_FB_MATROX_I2C is not set
> CONFIG_FB_RADEON=y
> CONFIG_FB_RADEON_I2C=y
> CONFIG_FB_RADEON_BACKLIGHT=y
> CONFIG_FB_RADEON_DEBUG=y
> CONFIG_FB_ATY128=y
> # CONFIG_FB_ATY128_BACKLIGHT is not set
> CONFIG_FB_ATY=y
> CONFIG_FB_ATY_CT=y
> CONFIG_FB_ATY_GENERIC_LCD=y
> CONFIG_FB_ATY_GX=y
> # CONFIG_FB_ATY_BACKLIGHT is not set
> # CONFIG_FB_S3 is not set
> CONFIG_FB_SAVAGE=y
> CONFIG_FB_SAVAGE_I2C=y
> CONFIG_FB_SAVAGE_ACCEL=y
> CONFIG_FB_SIS=m
> CONFIG_FB_SIS_300=y
> CONFIG_FB_SIS_315=y
> # CONFIG_FB_VIA is not set
> CONFIG_FB_NEOMAGIC=y
> CONFIG_FB_KYRO=m
> CONFIG_FB_3DFX=m
> # CONFIG_FB_3DFX_ACCEL is not set
> CONFIG_FB_3DFX_I2C=y
> CONFIG_FB_VOODOO1=y
> # CONFIG_FB_VT8623 is not set
> CONFIG_FB_TRIDENT=m
> CONFIG_FB_ARK=y
> CONFIG_FB_PM3=y
> CONFIG_FB_CARMINE=m
> CONFIG_FB_CARMINE_DRAM_EVAL=y
> # CONFIG_CARMINE_DRAM_CUSTOM is not set
> # CONFIG_FB_WM8505 is not set
> # CONFIG_FB_PXA168 is not set
> # CONFIG_FB_W100 is not set
> # CONFIG_FB_SH_MOBILE_LCDC is not set
> # CONFIG_FB_TMIO is not set
> # CONFIG_FB_S3C is not set
> CONFIG_FB_SM501=m
> CONFIG_FB_IBM_GXT4500=y
> # CONFIG_FB_GOLDFISH is not set
> # CONFIG_FB_DA8XX is not set
> CONFIG_FB_VIRTUAL=m
> CONFIG_FB_METRONOME=y
> CONFIG_FB_MB862XX=m
> CONFIG_FB_MB862XX_PCI_GDC=y
> # CONFIG_FB_MB862XX_I2C is not set
> # CONFIG_FB_BROADSHEET is not set
> # CONFIG_FB_SIMPLE is not set
> CONFIG_FB_SSD1307=y
> # CONFIG_FB_SM712 is not set
> # CONFIG_FB_OMAP2 is not set
> # CONFIG_MMP_DISP is not set
> # end of Frame buffer Devices
> 
> #
> # Backlight & LCD device support
> #
> CONFIG_LCD_CLASS_DEVICE=m
> # CONFIG_LCD_PLATFORM is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> CONFIG_BACKLIGHT_KTD253=y
> CONFIG_BACKLIGHT_LM3533=y
> # CONFIG_BACKLIGHT_OMAP1 is not set
> # CONFIG_BACKLIGHT_PWM is not set
> CONFIG_BACKLIGHT_QCOM_WLED=m
> # CONFIG_BACKLIGHT_WM831X is not set
> CONFIG_BACKLIGHT_ADP8860=m
> CONFIG_BACKLIGHT_ADP8870=y
> # CONFIG_BACKLIGHT_LM3630A is not set
> CONFIG_BACKLIGHT_LM3639=y
> # CONFIG_BACKLIGHT_LP855X is not set
> CONFIG_BACKLIGHT_PANDORA=y
> CONFIG_BACKLIGHT_SKY81452=m
> CONFIG_BACKLIGHT_AS3711=y
> # CONFIG_BACKLIGHT_GPIO is not set
> # CONFIG_BACKLIGHT_LV5207LP is not set
> CONFIG_BACKLIGHT_BD6107=m
> CONFIG_BACKLIGHT_ARCXCNN=y
> CONFIG_BACKLIGHT_RAVE_SP=m
> CONFIG_BACKLIGHT_LED=y
> # end of Backlight & LCD device support
> 
> CONFIG_VGASTATE=y
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_DUMMY_CONSOLE_COLUMNS=80
> CONFIG_DUMMY_CONSOLE_ROWS=25
> # CONFIG_FRAMEBUFFER_CONSOLE is not set
> # end of Console display driver support
> 
> # CONFIG_LOGO is not set
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
> CONFIG_UHID=y
> # CONFIG_HID_GENERIC is not set
> 
> #
> # Special HID drivers
> #
> # CONFIG_HID_A4TECH is not set
> CONFIG_HID_ACRUX=y
> CONFIG_HID_ACRUX_FF=y
> CONFIG_HID_APPLE=y
> # CONFIG_HID_AUREAL is not set
> CONFIG_HID_BELKIN=y
> CONFIG_HID_CHERRY=y
> CONFIG_HID_COUGAR=y
> # CONFIG_HID_MACALLY is not set
> CONFIG_HID_CMEDIA=m
> CONFIG_HID_CYPRESS=m
> # CONFIG_HID_DRAGONRISE is not set
> CONFIG_HID_EMS_FF=y
> CONFIG_HID_ELECOM=y
> CONFIG_HID_EZKEY=m
> CONFIG_HID_GEMBIRD=m
> CONFIG_HID_GFRM=m
> CONFIG_HID_GLORIOUS=y
> CONFIG_HID_VIVALDI_COMMON=y
> CONFIG_HID_VIVALDI=y
> CONFIG_HID_KEYTOUCH=m
> CONFIG_HID_KYE=m
> CONFIG_HID_WALTOP=y
> # CONFIG_HID_VIEWSONIC is not set
> # CONFIG_HID_VRC2 is not set
> # CONFIG_HID_XIAOMI is not set
> CONFIG_HID_GYRATION=y
> CONFIG_HID_ICADE=y
> CONFIG_HID_ITE=y
> CONFIG_HID_JABRA=m
> # CONFIG_HID_TWINHAN is not set
> CONFIG_HID_KENSINGTON=m
> CONFIG_HID_LCPOWER=y
> CONFIG_HID_LED=y
> CONFIG_HID_LENOVO=y
> CONFIG_HID_MAGICMOUSE=y
> CONFIG_HID_MALTRON=m
> # CONFIG_HID_MAYFLASH is not set
> CONFIG_HID_REDRAGON=m
> CONFIG_HID_MICROSOFT=y
> # CONFIG_HID_MONTEREY is not set
> # CONFIG_HID_MULTITOUCH is not set
> # CONFIG_HID_NINTENDO is not set
> # CONFIG_HID_NTI is not set
> CONFIG_HID_ORTEK=m
> CONFIG_HID_PANTHERLORD=m
> CONFIG_PANTHERLORD_FF=y
> # CONFIG_HID_PETALYNX is not set
> CONFIG_HID_PICOLCD=m
> CONFIG_HID_PICOLCD_FB=y
> CONFIG_HID_PICOLCD_BACKLIGHT=y
> # CONFIG_HID_PICOLCD_LCD is not set
> # CONFIG_HID_PICOLCD_LEDS is not set
> CONFIG_HID_PLANTRONICS=y
> CONFIG_HID_PLAYSTATION=m
> CONFIG_PLAYSTATION_FF=y
> # CONFIG_HID_PXRC is not set
> # CONFIG_HID_RAZER is not set
> # CONFIG_HID_PRIMAX is not set
> # CONFIG_HID_SAITEK is not set
> CONFIG_HID_SEMITEK=m
> CONFIG_HID_SPEEDLINK=m
> CONFIG_HID_STEAM=y
> CONFIG_HID_STEELSERIES=m
> # CONFIG_HID_SUNPLUS is not set
> # CONFIG_HID_RMI is not set
> CONFIG_HID_GREENASIA=m
> # CONFIG_GREENASIA_FF is not set
> # CONFIG_HID_SMARTJOYPLUS is not set
> CONFIG_HID_TIVO=y
> # CONFIG_HID_TOPSEED is not set
> # CONFIG_HID_TOPRE is not set
> # CONFIG_HID_THINGM is not set
> CONFIG_HID_UDRAW_PS3=m
> CONFIG_HID_WIIMOTE=m
> CONFIG_HID_XINMO=m
> CONFIG_HID_ZEROPLUS=m
> # CONFIG_ZEROPLUS_FF is not set
> CONFIG_HID_ZYDACRON=y
> CONFIG_HID_SENSOR_HUB=m
> # CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
> CONFIG_HID_ALPS=m
> # end of Special HID drivers
> 
> #
> # I2C HID support
> #
> CONFIG_I2C_HID_OF=m
> # CONFIG_I2C_HID_OF_ELAN is not set
> CONFIG_I2C_HID_OF_GOODIX=y
> # end of I2C HID support
> 
> CONFIG_I2C_HID_CORE=y
> 
> #
> # Intel ISH HID support
> #
> # end of Intel ISH HID support
> 
> #
> # AMD SFH HID Support
> #
> # CONFIG_AMD_SFH_HID is not set
> # end of AMD SFH HID Support
> # end of HID support
> 
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> # CONFIG_USB_SUPPORT is not set
> # CONFIG_MMC is not set
> # CONFIG_SCSI_UFSHCD is not set
> CONFIG_MEMSTICK=m
> CONFIG_MEMSTICK_DEBUG=y
> 
> #
> # MemoryStick drivers
> #
> # CONFIG_MEMSTICK_UNSAFE_RESUME is not set
> # CONFIG_MSPRO_BLOCK is not set
> # CONFIG_MS_BLOCK is not set
> 
> #
> # MemoryStick Host Controller Drivers
> #
> # CONFIG_MEMSTICK_TIFM_MS is not set
> CONFIG_MEMSTICK_JMICRON_38X=m
> CONFIG_MEMSTICK_R592=m
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
> # CONFIG_LEDS_CLASS_FLASH is not set
> CONFIG_LEDS_CLASS_MULTICOLOR=m
> # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
> 
> #
> # LED drivers
> #
> # CONFIG_LEDS_AN30259A is not set
> # CONFIG_LEDS_ARIEL is not set
> # CONFIG_LEDS_AW2013 is not set
> # CONFIG_LEDS_BCM6328 is not set
> # CONFIG_LEDS_BCM6358 is not set
> # CONFIG_LEDS_TURRIS_OMNIA is not set
> CONFIG_LEDS_LM3530=y
> # CONFIG_LEDS_LM3532 is not set
> CONFIG_LEDS_LM3533=m
> CONFIG_LEDS_LM3642=m
> CONFIG_LEDS_LM3692X=m
> CONFIG_LEDS_MT6323=y
> # CONFIG_LEDS_S3C24XX is not set
> # CONFIG_LEDS_COBALT_QUBE is not set
> # CONFIG_LEDS_COBALT_RAQ is not set
> # CONFIG_LEDS_PCA9532 is not set
> # CONFIG_LEDS_GPIO is not set
> # CONFIG_LEDS_LP3944 is not set
> # CONFIG_LEDS_LP3952 is not set
> CONFIG_LEDS_LP50XX=m
> CONFIG_LEDS_LP55XX_COMMON=m
> CONFIG_LEDS_LP5521=m
> CONFIG_LEDS_LP5523=m
> CONFIG_LEDS_LP5562=m
> CONFIG_LEDS_LP8501=m
> CONFIG_LEDS_LP8860=m
> # CONFIG_LEDS_PCA955X is not set
> # CONFIG_LEDS_PCA963X is not set
> # CONFIG_LEDS_WM831X_STATUS is not set
> CONFIG_LEDS_WM8350=m
> CONFIG_LEDS_PWM=y
> CONFIG_LEDS_BD2802=y
> CONFIG_LEDS_LT3593=m
> CONFIG_LEDS_MC13783=y
> CONFIG_LEDS_NS2=y
> CONFIG_LEDS_NETXBIG=y
> CONFIG_LEDS_TCA6507=m
> # CONFIG_LEDS_TLC591XX is not set
> CONFIG_LEDS_MAX77650=y
> CONFIG_LEDS_MAX8997=m
> CONFIG_LEDS_LM355x=m
> # CONFIG_LEDS_OT200 is not set
> CONFIG_LEDS_IS31FL319X=y
> # CONFIG_LEDS_IS31FL32XX is not set
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> CONFIG_LEDS_BLINKM=y
> CONFIG_LEDS_SYSCON=y
> CONFIG_LEDS_MLXREG=m
> CONFIG_LEDS_USER=y
> CONFIG_LEDS_TI_LMU_COMMON=y
> CONFIG_LEDS_LM3697=y
> # CONFIG_LEDS_LM36274 is not set
> # CONFIG_LEDS_IP30 is not set
> # CONFIG_LEDS_BCM63138 is not set
> # CONFIG_LEDS_LGM is not set
> 
> #
> # Flash and Torch LED drivers
> #
> 
> #
> # RGB LED drivers
> #
> # CONFIG_LEDS_PWM_MULTICOLOR is not set
> 
> #
> # LED Triggers
> #
> # CONFIG_LEDS_TRIGGERS is not set
> 
> #
> # Simple LED drivers
> #
> # CONFIG_ACCESSIBILITY is not set
> CONFIG_EDAC_SUPPORT=y
> CONFIG_EDAC=y
> CONFIG_EDAC_LEGACY_SYSFS=y
> CONFIG_EDAC_DEBUG=y
> # CONFIG_EDAC_AL_MC is not set
> # CONFIG_EDAC_XGENE is not set
> CONFIG_RTC_LIB=y
> CONFIG_RTC_CLASS=y
> # CONFIG_RTC_HCTOSYS is not set
> # CONFIG_RTC_SYSTOHC is not set
> # CONFIG_RTC_DEBUG is not set
> CONFIG_RTC_NVMEM=y
> 
> #
> # RTC interfaces
> #
> # CONFIG_RTC_INTF_SYSFS is not set
> CONFIG_RTC_INTF_PROC=y
> CONFIG_RTC_INTF_DEV=y
> CONFIG_RTC_INTF_DEV_UIE_EMUL=y
> CONFIG_RTC_DRV_TEST=m
> 
> #
> # I2C RTC drivers
> #
> # CONFIG_RTC_DRV_ABB5ZES3 is not set
> # CONFIG_RTC_DRV_ABEOZ9 is not set
> # CONFIG_RTC_DRV_ABX80X is not set
> # CONFIG_RTC_DRV_BRCMSTB is not set
> CONFIG_RTC_DRV_DS1307=m
> # CONFIG_RTC_DRV_DS1307_CENTURY is not set
> CONFIG_RTC_DRV_DS1374=m
> # CONFIG_RTC_DRV_DS1672 is not set
> CONFIG_RTC_DRV_HYM8563=y
> # CONFIG_RTC_DRV_MAX6900 is not set
> # CONFIG_RTC_DRV_MAX8907 is not set
> CONFIG_RTC_DRV_MAX8998=y
> CONFIG_RTC_DRV_MAX8997=y
> CONFIG_RTC_DRV_MAX77686=m
> # CONFIG_RTC_DRV_NCT3018Y is not set
> CONFIG_RTC_DRV_RK808=m
> CONFIG_RTC_DRV_RS5C372=y
> CONFIG_RTC_DRV_ISL1208=m
> CONFIG_RTC_DRV_ISL12022=m
> CONFIG_RTC_DRV_ISL12026=y
> CONFIG_RTC_DRV_X1205=m
> # CONFIG_RTC_DRV_PCF8523 is not set
> CONFIG_RTC_DRV_PCF85063=y
> # CONFIG_RTC_DRV_PCF85363 is not set
> # CONFIG_RTC_DRV_PCF8563 is not set
> # CONFIG_RTC_DRV_PCF8583 is not set
> # CONFIG_RTC_DRV_M41T80 is not set
> # CONFIG_RTC_DRV_BD70528 is not set
> CONFIG_RTC_DRV_BQ32K=m
> CONFIG_RTC_DRV_TWL4030=m
> # CONFIG_RTC_DRV_RC5T619 is not set
> # CONFIG_RTC_DRV_S35390A is not set
> CONFIG_RTC_DRV_FM3130=m
> # CONFIG_RTC_DRV_RX8010 is not set
> CONFIG_RTC_DRV_RX8581=m
> # CONFIG_RTC_DRV_RX8025 is not set
> CONFIG_RTC_DRV_EM3027=m
> # CONFIG_RTC_DRV_RV3028 is not set
> CONFIG_RTC_DRV_RV3032=m
> # CONFIG_RTC_DRV_RV8803 is not set
> CONFIG_RTC_DRV_S5M=m
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
> CONFIG_RTC_DRV_DS3232=m
> CONFIG_RTC_DRV_DS3232_HWMON=y
> CONFIG_RTC_DRV_PCF2127=y
> CONFIG_RTC_DRV_RV3029C2=m
> CONFIG_RTC_DRV_RV3029_HWMON=y
> # CONFIG_RTC_DRV_RX6110 is not set
> 
> #
> # Platform RTC drivers
> #
> # CONFIG_RTC_DRV_DS1286 is not set
> CONFIG_RTC_DRV_DS1511=m
> # CONFIG_RTC_DRV_DS1553 is not set
> CONFIG_RTC_DRV_DS1685_FAMILY=m
> # CONFIG_RTC_DRV_DS1685 is not set
> # CONFIG_RTC_DRV_DS1689 is not set
> # CONFIG_RTC_DRV_DS17285 is not set
> # CONFIG_RTC_DRV_DS17485 is not set
> CONFIG_RTC_DRV_DS17885=y
> CONFIG_RTC_DRV_DS1742=m
> CONFIG_RTC_DRV_DS2404=y
> CONFIG_RTC_DRV_DA9055=m
> CONFIG_RTC_DRV_DA9063=m
> # CONFIG_RTC_DRV_EFI is not set
> # CONFIG_RTC_DRV_STK17TA8 is not set
> # CONFIG_RTC_DRV_M48T86 is not set
> # CONFIG_RTC_DRV_M48T35 is not set
> CONFIG_RTC_DRV_M48T59=m
> CONFIG_RTC_DRV_MSM6242=y
> # CONFIG_RTC_DRV_BQ4802 is not set
> # CONFIG_RTC_DRV_RP5C01 is not set
> # CONFIG_RTC_DRV_V3020 is not set
> # CONFIG_RTC_DRV_GAMECUBE is not set
> CONFIG_RTC_DRV_WM831X=m
> # CONFIG_RTC_DRV_WM8350 is not set
> # CONFIG_RTC_DRV_SC27XX is not set
> CONFIG_RTC_DRV_SPEAR=y
> CONFIG_RTC_DRV_ZYNQMP=m
> CONFIG_RTC_DRV_NTXEC=y
> 
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_ASM9260 is not set
> # CONFIG_RTC_DRV_DAVINCI is not set
> # CONFIG_RTC_DRV_DIGICOLOR is not set
> # CONFIG_RTC_DRV_FSL_FTM_ALARM is not set
> # CONFIG_RTC_DRV_MESON is not set
> # CONFIG_RTC_DRV_MESON_VRTC is not set
> # CONFIG_RTC_DRV_OMAP is not set
> # CONFIG_RTC_DRV_S3C is not set
> # CONFIG_RTC_DRV_EP93XX is not set
> # CONFIG_RTC_DRV_AT91RM9200 is not set
> # CONFIG_RTC_DRV_AT91SAM9 is not set
> # CONFIG_RTC_DRV_RZN1 is not set
> # CONFIG_RTC_DRV_GENERIC is not set
> # CONFIG_RTC_DRV_VT8500 is not set
> # CONFIG_RTC_DRV_SUN6I is not set
> # CONFIG_RTC_DRV_SUNXI is not set
> # CONFIG_RTC_DRV_MV is not set
> # CONFIG_RTC_DRV_ARMADA38X is not set
> CONFIG_RTC_DRV_CADENCE=y
> CONFIG_RTC_DRV_FTRTC010=y
> # CONFIG_RTC_DRV_STMP is not set
> # CONFIG_RTC_DRV_MC13XXX is not set
> # CONFIG_RTC_DRV_JZ4740 is not set
> # CONFIG_RTC_DRV_LPC24XX is not set
> # CONFIG_RTC_DRV_LPC32XX is not set
> # CONFIG_RTC_DRV_PM8XXX is not set
> # CONFIG_RTC_DRV_TEGRA is not set
> # CONFIG_RTC_DRV_MXC is not set
> # CONFIG_RTC_DRV_MXC_V2 is not set
> # CONFIG_RTC_DRV_SNVS is not set
> # CONFIG_RTC_DRV_MOXART is not set
> # CONFIG_RTC_DRV_MT2712 is not set
> # CONFIG_RTC_DRV_MT6397 is not set
> # CONFIG_RTC_DRV_MT7622 is not set
> # CONFIG_RTC_DRV_XGENE is not set
> # CONFIG_RTC_DRV_R7301 is not set
> # CONFIG_RTC_DRV_STM32 is not set
> # CONFIG_RTC_DRV_RTD119X is not set
> # CONFIG_RTC_DRV_ASPEED is not set
> # CONFIG_RTC_DRV_TI_K3 is not set
> 
> #
> # HID Sensor RTC drivers
> #
> CONFIG_RTC_DRV_GOLDFISH=m
> # CONFIG_RTC_DRV_MSC313 is not set
> # CONFIG_RTC_DRV_POLARFIRE_SOC is not set
> # CONFIG_DMADEVICES is not set
> 
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=y
> # CONFIG_SW_SYNC is not set
> # CONFIG_UDMABUF is not set
> CONFIG_DMABUF_MOVE_NOTIFY=y
> # CONFIG_DMABUF_DEBUG is not set
> CONFIG_DMABUF_SELFTESTS=y
> # CONFIG_DMABUF_HEAPS is not set
> # CONFIG_DMABUF_SYSFS_STATS is not set
> # end of DMABUF options
> 
> CONFIG_AUXDISPLAY=y
> CONFIG_CHARLCD=y
> # CONFIG_LINEDISP is not set
> # CONFIG_HD44780_COMMON is not set
> # CONFIG_HD44780 is not set
> # CONFIG_IMG_ASCII_LCD is not set
> # CONFIG_HT16K33 is not set
> CONFIG_LCD2S=y
> # CONFIG_PARPORT_PANEL is not set
> CONFIG_PANEL_CHANGE_MESSAGE=y
> CONFIG_PANEL_BOOT_MESSAGE=""
> # CONFIG_CHARLCD_BL_OFF is not set
> # CONFIG_CHARLCD_BL_ON is not set
> CONFIG_CHARLCD_BL_FLASH=y
> # CONFIG_PANEL is not set
> CONFIG_UIO=m
> CONFIG_UIO_CIF=m
> CONFIG_UIO_PDRV_GENIRQ=m
> # CONFIG_UIO_DMEM_GENIRQ is not set
> # CONFIG_UIO_AEC is not set
> # CONFIG_UIO_SERCOS3 is not set
> # CONFIG_UIO_PCI_GENERIC is not set
> CONFIG_UIO_NETX=m
> CONFIG_UIO_PRUSS=m
> CONFIG_UIO_MF624=m
> CONFIG_UIO_DFL=m
> # CONFIG_VFIO is not set
> # CONFIG_VIRT_DRIVERS is not set
> CONFIG_VIRTIO_ANCHOR=y
> CONFIG_VIRTIO=y
> CONFIG_VIRTIO_PCI_LIB=m
> CONFIG_VIRTIO_MENU=y
> CONFIG_VIRTIO_PCI=m
> # CONFIG_VIRTIO_PCI_LEGACY is not set
> CONFIG_VIRTIO_BALLOON=m
> # CONFIG_VIRTIO_INPUT is not set
> CONFIG_VIRTIO_MMIO=m
> # CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
> # CONFIG_VHOST_MENU is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> # end of Microsoft Hyper-V guest support
> 
> # CONFIG_GREYBUS is not set
> CONFIG_COMEDI=m
> # CONFIG_COMEDI_DEBUG is not set
> CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
> CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
> # CONFIG_COMEDI_MISC_DRIVERS is not set
> CONFIG_COMEDI_ISA_DRIVERS=y
> CONFIG_COMEDI_PCL711=m
> CONFIG_COMEDI_PCL724=m
> # CONFIG_COMEDI_PCL726 is not set
> # CONFIG_COMEDI_PCL730 is not set
> CONFIG_COMEDI_PCL812=m
> CONFIG_COMEDI_PCL816=m
> # CONFIG_COMEDI_PCL818 is not set
> # CONFIG_COMEDI_PCM3724 is not set
> CONFIG_COMEDI_AMPLC_DIO200_ISA=m
> # CONFIG_COMEDI_AMPLC_PC236_ISA is not set
> # CONFIG_COMEDI_AMPLC_PC263_ISA is not set
> # CONFIG_COMEDI_RTI800 is not set
> # CONFIG_COMEDI_RTI802 is not set
> CONFIG_COMEDI_DAC02=m
> CONFIG_COMEDI_DAS16M1=m
> # CONFIG_COMEDI_DAS08_ISA is not set
> # CONFIG_COMEDI_DAS16 is not set
> CONFIG_COMEDI_DAS800=m
> # CONFIG_COMEDI_DAS1800 is not set
> CONFIG_COMEDI_DAS6402=m
> CONFIG_COMEDI_DT2801=m
> CONFIG_COMEDI_DT2811=m
> # CONFIG_COMEDI_DT2814 is not set
> # CONFIG_COMEDI_DT2815 is not set
> CONFIG_COMEDI_DT2817=m
> CONFIG_COMEDI_DT282X=m
> CONFIG_COMEDI_DMM32AT=m
> # CONFIG_COMEDI_FL512 is not set
> # CONFIG_COMEDI_AIO_AIO12_8 is not set
> # CONFIG_COMEDI_AIO_IIRO_16 is not set
> CONFIG_COMEDI_II_PCI20KC=m
> CONFIG_COMEDI_C6XDIGIO=m
> CONFIG_COMEDI_MPC624=m
> CONFIG_COMEDI_ADQ12B=m
> CONFIG_COMEDI_NI_AT_A2150=m
> CONFIG_COMEDI_NI_AT_AO=m
> CONFIG_COMEDI_NI_ATMIO=m
> # CONFIG_COMEDI_NI_ATMIO16D is not set
> # CONFIG_COMEDI_NI_LABPC_ISA is not set
> # CONFIG_COMEDI_PCMAD is not set
> CONFIG_COMEDI_PCMDA12=m
> # CONFIG_COMEDI_PCMMIO is not set
> # CONFIG_COMEDI_PCMUIO is not set
> CONFIG_COMEDI_MULTIQ3=m
> CONFIG_COMEDI_S526=m
> CONFIG_COMEDI_PCI_DRIVERS=m
> # CONFIG_COMEDI_8255_PCI is not set
> CONFIG_COMEDI_ADDI_WATCHDOG=m
> CONFIG_COMEDI_ADDI_APCI_1032=m
> CONFIG_COMEDI_ADDI_APCI_1500=m
> CONFIG_COMEDI_ADDI_APCI_1516=m
> CONFIG_COMEDI_ADDI_APCI_1564=m
> CONFIG_COMEDI_ADDI_APCI_16XX=m
> CONFIG_COMEDI_ADDI_APCI_2032=m
> CONFIG_COMEDI_ADDI_APCI_2200=m
> # CONFIG_COMEDI_ADDI_APCI_3120 is not set
> # CONFIG_COMEDI_ADDI_APCI_3501 is not set
> # CONFIG_COMEDI_ADDI_APCI_3XXX is not set
> CONFIG_COMEDI_ADL_PCI6208=m
> CONFIG_COMEDI_ADL_PCI7X3X=m
> CONFIG_COMEDI_ADL_PCI8164=m
> # CONFIG_COMEDI_ADL_PCI9111 is not set
> CONFIG_COMEDI_ADL_PCI9118=m
> CONFIG_COMEDI_ADV_PCI1710=m
> CONFIG_COMEDI_ADV_PCI1720=m
> # CONFIG_COMEDI_ADV_PCI1723 is not set
> # CONFIG_COMEDI_ADV_PCI1724 is not set
> CONFIG_COMEDI_ADV_PCI1760=m
> # CONFIG_COMEDI_ADV_PCI_DIO is not set
> # CONFIG_COMEDI_AMPLC_DIO200_PCI is not set
> CONFIG_COMEDI_AMPLC_PC236_PCI=m
> CONFIG_COMEDI_AMPLC_PC263_PCI=m
> CONFIG_COMEDI_AMPLC_PCI224=m
> CONFIG_COMEDI_AMPLC_PCI230=m
> CONFIG_COMEDI_CONTEC_PCI_DIO=m
> # CONFIG_COMEDI_DAS08_PCI is not set
> CONFIG_COMEDI_DT3000=m
> # CONFIG_COMEDI_DYNA_PCI10XX is not set
> CONFIG_COMEDI_GSC_HPDI=m
> CONFIG_COMEDI_MF6X4=m
> # CONFIG_COMEDI_ICP_MULTI is not set
> CONFIG_COMEDI_DAQBOARD2000=m
> # CONFIG_COMEDI_JR3_PCI is not set
> CONFIG_COMEDI_KE_COUNTER=m
> CONFIG_COMEDI_CB_PCIDAS64=m
> CONFIG_COMEDI_CB_PCIDAS=m
> # CONFIG_COMEDI_CB_PCIDDA is not set
> # CONFIG_COMEDI_CB_PCIMDAS is not set
> CONFIG_COMEDI_CB_PCIMDDA=m
> CONFIG_COMEDI_ME4000=m
> CONFIG_COMEDI_ME_DAQ=m
> # CONFIG_COMEDI_NI_6527 is not set
> CONFIG_COMEDI_NI_65XX=m
> CONFIG_COMEDI_NI_660X=m
> CONFIG_COMEDI_NI_670X=m
> # CONFIG_COMEDI_NI_LABPC_PCI is not set
> # CONFIG_COMEDI_NI_PCIDIO is not set
> # CONFIG_COMEDI_NI_PCIMIO is not set
> # CONFIG_COMEDI_RTD520 is not set
> # CONFIG_COMEDI_S626 is not set
> CONFIG_COMEDI_MITE=m
> CONFIG_COMEDI_NI_TIOCMD=m
> CONFIG_COMEDI_8254=m
> CONFIG_COMEDI_8255=m
> CONFIG_COMEDI_8255_SA=m
> CONFIG_COMEDI_KCOMEDILIB=m
> CONFIG_COMEDI_AMPLC_DIO200=m
> CONFIG_COMEDI_AMPLC_PC236=m
> CONFIG_COMEDI_NI_TIO=m
> CONFIG_COMEDI_NI_ROUTING=m
> # CONFIG_COMEDI_TESTS is not set
> CONFIG_STAGING=y
> # CONFIG_RTS5208 is not set
> 
> #
> # IIO staging drivers
> #
> 
> #
> # Accelerometers
> #
> # end of Accelerometers
> 
> #
> # Analog to digital converters
> #
> # end of Analog to digital converters
> 
> #
> # Analog digital bi-direction converters
> #
> # CONFIG_ADT7316 is not set
> # end of Analog digital bi-direction converters
> 
> #
> # Direct Digital Synthesis
> #
> # end of Direct Digital Synthesis
> 
> #
> # Network Analyzer, Impedance Converters
> #
> CONFIG_AD5933=m
> # end of Network Analyzer, Impedance Converters
> 
> #
> # Active energy metering IC
> #
> CONFIG_ADE7854=m
> CONFIG_ADE7854_I2C=m
> # end of Active energy metering IC
> 
> #
> # Resolver to digital converters
> #
> # end of Resolver to digital converters
> # end of IIO staging drivers
> 
> CONFIG_FB_SM750=y
> # CONFIG_STAGING_MEDIA is not set
> # CONFIG_STAGING_BOARD is not set
> CONFIG_MOST_COMPONENTS=m
> # CONFIG_MOST_DIM2 is not set
> CONFIG_MOST_I2C=m
> CONFIG_BCM_VIDEOCORE=y
> # CONFIG_BCM2835_VCHIQ is not set
> # CONFIG_XIL_AXIS_FIFO is not set
> CONFIG_FIELDBUS_DEV=y
> CONFIG_HMS_ANYBUSS_BUS=y
> CONFIG_HMS_PROFINET=m
> # CONFIG_VME_BUS is not set
> # CONFIG_GOLDFISH is not set
> # CONFIG_CHROME_PLATFORMS is not set
> # CONFIG_MELLANOX_PLATFORM is not set
> # CONFIG_OLPC_XO175 is not set
> CONFIG_SURFACE_PLATFORMS=y
> CONFIG_HAVE_CLK=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> CONFIG_COMMON_CLK_WM831X=m
> 
> #
> # Clock driver for ARM Reference designs
> #
> # CONFIG_CLK_ICST is not set
> CONFIG_CLK_SP810=y
> # end of Clock driver for ARM Reference designs
> 
> # CONFIG_CLK_HSDK is not set
> # CONFIG_COMMON_CLK_APPLE_NCO is not set
> CONFIG_COMMON_CLK_MAX77686=m
> CONFIG_COMMON_CLK_MAX9485=m
> CONFIG_COMMON_CLK_RK808=m
> # CONFIG_COMMON_CLK_HI655X is not set
> # CONFIG_COMMON_CLK_SCMI is not set
> # CONFIG_COMMON_CLK_SCPI is not set
> CONFIG_COMMON_CLK_SI5341=y
> # CONFIG_COMMON_CLK_SI5351 is not set
> # CONFIG_COMMON_CLK_SI514 is not set
> CONFIG_COMMON_CLK_SI544=m
> # CONFIG_COMMON_CLK_SI570 is not set
> # CONFIG_COMMON_CLK_BM1880 is not set
> CONFIG_COMMON_CLK_CDCE706=m
> # CONFIG_COMMON_CLK_TPS68470 is not set
> # CONFIG_COMMON_CLK_CDCE925 is not set
> # CONFIG_COMMON_CLK_CS2000_CP is not set
> # CONFIG_COMMON_CLK_EN7523 is not set
> # CONFIG_COMMON_CLK_FSL_FLEXSPI is not set
> # CONFIG_COMMON_CLK_FSL_SAI is not set
> # CONFIG_COMMON_CLK_GEMINI is not set
> # CONFIG_COMMON_CLK_LAN966X is not set
> # CONFIG_COMMON_CLK_ASPEED is not set
> CONFIG_COMMON_CLK_S2MPS11=m
> # CONFIG_COMMON_CLK_AXI_CLKGEN is not set
> # CONFIG_CLK_QORIQ is not set
> # CONFIG_CLK_LS1028A_PLLDIG is not set
> # CONFIG_COMMON_CLK_XGENE is not set
> CONFIG_COMMON_CLK_PWM=y
> # CONFIG_COMMON_CLK_OXNAS is not set
> # CONFIG_COMMON_CLK_RS9_PCIE is not set
> CONFIG_COMMON_CLK_VC5=m
> # CONFIG_COMMON_CLK_VC7 is not set
> # CONFIG_COMMON_CLK_MMP2_AUDIO is not set
> CONFIG_COMMON_CLK_BD718XX=m
> # CONFIG_COMMON_CLK_FIXED_MMIO is not set
> # CONFIG_CLK_ACTIONS is not set
> CONFIG_CLK_ANALOGBITS_WRPLL_CLN28HPC=y
> # CONFIG_CLK_BAIKAL_T1 is not set
> # CONFIG_CLK_BCM2711_DVP is not set
> # CONFIG_CLK_BCM2835 is not set
> # CONFIG_CLK_BCM_63XX is not set
> # CONFIG_CLK_BCM_63XX_GATE is not set
> # CONFIG_CLK_BCM_KONA is not set
> # CONFIG_CLK_BCM_CYGNUS is not set
> # CONFIG_CLK_BCM_HR2 is not set
> # CONFIG_CLK_BCM_NSP is not set
> # CONFIG_CLK_BCM_NS2 is not set
> # CONFIG_CLK_BCM_SR is not set
> # CONFIG_CLK_RASPBERRYPI is not set
> # CONFIG_COMMON_CLK_HI3516CV300 is not set
> # CONFIG_COMMON_CLK_HI3519 is not set
> # CONFIG_COMMON_CLK_HI3559A is not set
> # CONFIG_COMMON_CLK_HI3660 is not set
> # CONFIG_COMMON_CLK_HI3670 is not set
> # CONFIG_COMMON_CLK_HI3798CV200 is not set
> # CONFIG_COMMON_CLK_HI6220 is not set
> # CONFIG_RESET_HISI is not set
> # CONFIG_STUB_CLK_HI6220 is not set
> # CONFIG_STUB_CLK_HI3660 is not set
> # CONFIG_COMMON_CLK_BOSTON is not set
> # CONFIG_MXC_CLK is not set
> # CONFIG_CLK_IMX8MM is not set
> # CONFIG_CLK_IMX8MN is not set
> # CONFIG_CLK_IMX8MP is not set
> # CONFIG_CLK_IMX8MQ is not set
> # CONFIG_CLK_IMX8ULP is not set
> # CONFIG_CLK_IMX93 is not set
> 
> #
> # Ingenic SoCs drivers
> #
> # CONFIG_INGENIC_CGU_JZ4740 is not set
> # CONFIG_INGENIC_CGU_JZ4725B is not set
> # CONFIG_INGENIC_CGU_JZ4760 is not set
> # CONFIG_INGENIC_CGU_JZ4770 is not set
> # CONFIG_INGENIC_CGU_JZ4780 is not set
> # CONFIG_INGENIC_CGU_X1000 is not set
> # CONFIG_INGENIC_CGU_X1830 is not set
> # CONFIG_INGENIC_TCU_CLK is not set
> # end of Ingenic SoCs drivers
> 
> # CONFIG_COMMON_CLK_KEYSTONE is not set
> # CONFIG_TI_SYSCON_CLK is not set
> 
> #
> # Clock driver for MediaTek SoC
> #
> # CONFIG_COMMON_CLK_MT2701 is not set
> # CONFIG_COMMON_CLK_MT2712 is not set
> # CONFIG_COMMON_CLK_MT6765 is not set
> # CONFIG_COMMON_CLK_MT6779 is not set
> # CONFIG_COMMON_CLK_MT6795 is not set
> # CONFIG_COMMON_CLK_MT6797 is not set
> # CONFIG_COMMON_CLK_MT7622 is not set
> # CONFIG_COMMON_CLK_MT7629 is not set
> # CONFIG_COMMON_CLK_MT7986 is not set
> # CONFIG_COMMON_CLK_MT8135 is not set
> # CONFIG_COMMON_CLK_MT8167 is not set
> # CONFIG_COMMON_CLK_MT8173 is not set
> # CONFIG_COMMON_CLK_MT8183 is not set
> # CONFIG_COMMON_CLK_MT8186 is not set
> # CONFIG_COMMON_CLK_MT8192 is not set
> # CONFIG_COMMON_CLK_MT8195 is not set
> # CONFIG_COMMON_CLK_MT8365 is not set
> # CONFIG_COMMON_CLK_MT8516 is not set
> # end of Clock driver for MediaTek SoC
> 
> #
> # Clock support for Amlogic platforms
> #
> # end of Clock support for Amlogic platforms
> 
> # CONFIG_MSTAR_MSC313_MPLL is not set
> CONFIG_MCHP_CLK_MPFS=y
> # CONFIG_COMMON_CLK_PISTACHIO is not set
> # CONFIG_COMMON_CLK_QCOM is not set
> # CONFIG_CLK_MT7621 is not set
> # CONFIG_CLK_RENESAS is not set
> # CONFIG_COMMON_CLK_SAMSUNG is not set
> # CONFIG_S3C2410_COMMON_CLK is not set
> # CONFIG_S3C2412_COMMON_CLK is not set
> # CONFIG_S3C2443_COMMON_CLK is not set
> CONFIG_CLK_SIFIVE=y
> CONFIG_CLK_SIFIVE_PRCI=y
> # CONFIG_CLK_INTEL_SOCFPGA is not set
> # CONFIG_SPRD_COMMON_CLK is not set
> # CONFIG_CLK_STARFIVE_JH7100 is not set
> CONFIG_CLK_SUNXI=y
> CONFIG_CLK_SUNXI_CLOCKS=y
> CONFIG_CLK_SUNXI_PRCM_SUN6I=y
> CONFIG_CLK_SUNXI_PRCM_SUN8I=y
> CONFIG_CLK_SUNXI_PRCM_SUN9I=y
> # CONFIG_SUNXI_CCU is not set
> # CONFIG_COMMON_CLK_TI_ADPLL is not set
> # CONFIG_CLK_UNIPHIER is not set
> # CONFIG_COMMON_CLK_VISCONTI is not set
> # CONFIG_CLK_LGM_CGU is not set
> # CONFIG_XILINX_VCU is not set
> # CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
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
> # CONFIG_BCM2835_TIMER is not set
> # CONFIG_BCM_KONA_TIMER is not set
> # CONFIG_DAVINCI_TIMER is not set
> # CONFIG_DIGICOLOR_TIMER is not set
> # CONFIG_OMAP_DM_TIMER is not set
> # CONFIG_DW_APB_TIMER is not set
> # CONFIG_FTTMR010_TIMER is not set
> # CONFIG_IXP4XX_TIMER is not set
> # CONFIG_MESON6_TIMER is not set
> # CONFIG_OWL_TIMER is not set
> # CONFIG_RDA_TIMER is not set
> # CONFIG_SUN4I_TIMER is not set
> # CONFIG_SUN5I_HSTIMER is not set
> # CONFIG_TEGRA_TIMER is not set
> # CONFIG_VT8500_TIMER is not set
> # CONFIG_NPCM7XX_TIMER is not set
> # CONFIG_CADENCE_TTC_TIMER is not set
> # CONFIG_ASM9260_TIMER is not set
> # CONFIG_CLKSRC_DBX500_PRCMU is not set
> # CONFIG_CLPS711X_TIMER is not set
> # CONFIG_MXS_TIMER is not set
> # CONFIG_NSPIRE_TIMER is not set
> # CONFIG_INTEGRATOR_AP_TIMER is not set
> # CONFIG_CLKSRC_PISTACHIO is not set
> # CONFIG_CLKSRC_TI_32K is not set
> # CONFIG_CLKSRC_STM32_LP is not set
> # CONFIG_CLKSRC_MPS2 is not set
> # CONFIG_ARC_TIMERS is not set
> # CONFIG_ARM_TIMER_SP804 is not set
> # CONFIG_ARMV7M_SYSTICK is not set
> # CONFIG_ATMEL_PIT is not set
> # CONFIG_ATMEL_ST is not set
> # CONFIG_CLKSRC_SAMSUNG_PWM is not set
> # CONFIG_FSL_FTM_TIMER is not set
> # CONFIG_OXNAS_RPS_TIMER is not set
> # CONFIG_MTK_TIMER is not set
> # CONFIG_SPRD_TIMER is not set
> # CONFIG_CLKSRC_JCORE_PIT is not set
> # CONFIG_SH_TIMER_CMT is not set
> # CONFIG_SH_TIMER_MTU2 is not set
> # CONFIG_RENESAS_OSTM is not set
> # CONFIG_SH_TIMER_TMU is not set
> # CONFIG_EM_TIMER_STI is not set
> # CONFIG_CLKSRC_VERSATILE is not set
> # CONFIG_CLKSRC_PXA is not set
> # CONFIG_TIMER_IMX_SYS_CTR is not set
> # CONFIG_CLKSRC_ST_LPC is not set
> # CONFIG_GXP_TIMER is not set
> CONFIG_RISCV_TIMER=y
> # CONFIG_CLINT_TIMER is not set
> # CONFIG_MSC313E_TIMER is not set
> # CONFIG_INGENIC_TIMER is not set
> # CONFIG_INGENIC_SYSOST is not set
> # CONFIG_INGENIC_OST is not set
> CONFIG_MICROCHIP_PIT64B=y
> # CONFIG_GOLDFISH_TIMER is not set
> # end of Clock Source drivers
> 
> CONFIG_MAILBOX=y
> # CONFIG_IMX_MBOX is not set
> CONFIG_PLATFORM_MHU=y
> # CONFIG_ARMADA_37XX_RWTM_MBOX is not set
> # CONFIG_ROCKCHIP_MBOX is not set
> CONFIG_ALTERA_MBOX=y
> # CONFIG_HI3660_MBOX is not set
> # CONFIG_HI6220_MBOX is not set
> CONFIG_MAILBOX_TEST=m
> CONFIG_POLARFIRE_SOC_MAILBOX=m
> # CONFIG_QCOM_APCS_IPC is not set
> # CONFIG_BCM_PDC_MBOX is not set
> # CONFIG_STM32_IPCC is not set
> # CONFIG_MTK_ADSP_MBOX is not set
> # CONFIG_MTK_CMDQ_MBOX is not set
> # CONFIG_SUN6I_MSGBOX is not set
> # CONFIG_SPRD_MBOX is not set
> # CONFIG_QCOM_IPCC is not set
> CONFIG_IOMMU_SUPPORT=y
> 
> #
> # Generic IOMMU Pagetable Support
> #
> # CONFIG_IOMMU_IO_PGTABLE_LPAE is not set
> # CONFIG_IOMMU_IO_PGTABLE_ARMV7S is not set
> # CONFIG_IOMMU_IO_PGTABLE_DART is not set
> # end of Generic IOMMU Pagetable Support
> 
> CONFIG_IOMMU_DEBUGFS=y
> # CONFIG_OMAP_IOMMU is not set
> # CONFIG_ROCKCHIP_IOMMU is not set
> # CONFIG_SUN50I_IOMMU is not set
> # CONFIG_EXYNOS_IOMMU is not set
> # CONFIG_IPMMU_VMSA is not set
> # CONFIG_APPLE_DART is not set
> # CONFIG_ARM_SMMU is not set
> # CONFIG_S390_CCW_IOMMU is not set
> # CONFIG_S390_AP_IOMMU is not set
> # CONFIG_MTK_IOMMU is not set
> # CONFIG_QCOM_IOMMU is not set
> # CONFIG_SPRD_IOMMU is not set
> 
> #
> # Remoteproc drivers
> #
> CONFIG_REMOTEPROC=y
> CONFIG_REMOTEPROC_CDEV=y
> # CONFIG_INGENIC_VPU_RPROC is not set
> # CONFIG_MTK_SCP is not set
> # CONFIG_MESON_MX_AO_ARC_REMOTEPROC is not set
> # CONFIG_RCAR_REMOTEPROC is not set
> # end of Remoteproc drivers
> 
> #
> # Rpmsg drivers
> #
> CONFIG_RPMSG=y
> # CONFIG_RPMSG_CTRL is not set
> CONFIG_RPMSG_NS=y
> CONFIG_RPMSG_QCOM_GLINK=m
> CONFIG_RPMSG_QCOM_GLINK_RPM=m
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
> 
> #
> # Amlogic SoC drivers
> #
> # CONFIG_MESON_CANVAS is not set
> # CONFIG_MESON_CLK_MEASURE is not set
> # CONFIG_MESON_GX_SOCINFO is not set
> # CONFIG_MESON_MX_SOCINFO is not set
> # end of Amlogic SoC drivers
> 
> #
> # Apple SoC drivers
> #
> # CONFIG_APPLE_RTKIT is not set
> # CONFIG_APPLE_SART is not set
> # end of Apple SoC drivers
> 
> #
> # ASPEED SoC drivers
> #
> # CONFIG_ASPEED_LPC_CTRL is not set
> # CONFIG_ASPEED_LPC_SNOOP is not set
> # CONFIG_ASPEED_UART_ROUTING is not set
> # CONFIG_ASPEED_P2A_CTRL is not set
> # CONFIG_ASPEED_SOCINFO is not set
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
> # CONFIG_SOC_BRCMSTB is not set
> # CONFIG_BCM_PMB is not set
> # end of Broadcom SoC drivers
> 
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # CONFIG_QUICC_ENGINE is not set
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
> # CONFIG_LITEX_SOC_CONTROLLER is not set
> # end of Enable LiteX SoC Builder specific drivers
> 
> #
> # MediaTek SoC drivers
> #
> # CONFIG_MTK_CMDQ is not set
> # CONFIG_MTK_DEVAPC is not set
> # CONFIG_MTK_INFRACFG is not set
> # CONFIG_MTK_PMIC_WRAP is not set
> # CONFIG_MTK_SCPSYS is not set
> # CONFIG_MTK_MMSYS is not set
> # end of MediaTek SoC drivers
> 
> # CONFIG_POLARFIRE_SOC_SYS_CTRL is not set
> 
> #
> # Qualcomm SoC drivers
> #
> # CONFIG_QCOM_COMMAND_DB is not set
> # CONFIG_QCOM_GENI_SE is not set
> # CONFIG_QCOM_GSBI is not set
> # CONFIG_QCOM_LLCC is not set
> # CONFIG_QCOM_RPMH is not set
> # CONFIG_QCOM_SMEM is not set
> # CONFIG_QCOM_SMD_RPM is not set
> # CONFIG_QCOM_SPM is not set
> # CONFIG_QCOM_WCNSS_CTRL is not set
> # CONFIG_QCOM_ICC_BWMON is not set
> # end of Qualcomm SoC drivers
> 
> # CONFIG_SOC_RENESAS is not set
> # CONFIG_ROCKCHIP_GRF is not set
> # CONFIG_ROCKCHIP_IODOMAIN is not set
> # CONFIG_SOC_SAMSUNG is not set
> # CONFIG_SIFIVE_CCACHE is not set
> # CONFIG_SOC_TI is not set
> # CONFIG_UX500_SOC_ID is not set
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
> # CONFIG_DEVFREQ_GOV_POWERSAVE is not set
> CONFIG_DEVFREQ_GOV_USERSPACE=m
> CONFIG_DEVFREQ_GOV_PASSIVE=y
> 
> #
> # DEVFREQ Drivers
> #
> # CONFIG_ARM_EXYNOS_BUS_DEVFREQ is not set
> # CONFIG_ARM_IMX_BUS_DEVFREQ is not set
> # CONFIG_ARM_TEGRA_DEVFREQ is not set
> # CONFIG_ARM_MEDIATEK_CCI_DEVFREQ is not set
> # CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ is not set
> CONFIG_PM_DEVFREQ_EVENT=y
> # CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP is not set
> # CONFIG_DEVFREQ_EVENT_EXYNOS_PPMU is not set
> # CONFIG_DEVFREQ_EVENT_ROCKCHIP_DFI is not set
> CONFIG_EXTCON=m
> 
> #
> # Extcon Device Drivers
> #
> CONFIG_EXTCON_ADC_JACK=m
> CONFIG_EXTCON_FSA9480=m
> CONFIG_EXTCON_GPIO=m
> CONFIG_EXTCON_MAX14577=m
> CONFIG_EXTCON_MAX3355=m
> # CONFIG_EXTCON_MAX77693 is not set
> # CONFIG_EXTCON_MAX77843 is not set
> CONFIG_EXTCON_MAX8997=m
> CONFIG_EXTCON_PTN5150=m
> # CONFIG_EXTCON_QCOM_SPMI_MISC is not set
> CONFIG_EXTCON_RT8973A=m
> # CONFIG_EXTCON_SM5502 is not set
> CONFIG_EXTCON_USB_GPIO=m
> # CONFIG_MEMORY is not set
> CONFIG_IIO=m
> CONFIG_IIO_BUFFER=y
> CONFIG_IIO_BUFFER_CB=m
> CONFIG_IIO_BUFFER_DMA=m
> CONFIG_IIO_BUFFER_DMAENGINE=m
> CONFIG_IIO_BUFFER_HW_CONSUMER=m
> CONFIG_IIO_KFIFO_BUF=m
> CONFIG_IIO_TRIGGERED_BUFFER=m
> CONFIG_IIO_CONFIGFS=m
> CONFIG_IIO_TRIGGER=y
> CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> CONFIG_IIO_SW_DEVICE=m
> CONFIG_IIO_SW_TRIGGER=m
> # CONFIG_IIO_TRIGGERED_EVENT is not set
> 
> #
> # Accelerometers
> #
> # CONFIG_ADXL313_I2C is not set
> # CONFIG_ADXL355_I2C is not set
> # CONFIG_ADXL367_I2C is not set
> CONFIG_ADXL372=m
> CONFIG_ADXL372_I2C=m
> CONFIG_BMA400=m
> CONFIG_BMA400_I2C=m
> # CONFIG_BMC150_ACCEL is not set
> CONFIG_DA280=m
> # CONFIG_DA311 is not set
> CONFIG_DMARD06=m
> CONFIG_DMARD09=m
> # CONFIG_DMARD10 is not set
> CONFIG_FXLS8962AF=m
> CONFIG_FXLS8962AF_I2C=m
> CONFIG_HID_SENSOR_ACCEL_3D=m
> # CONFIG_KXSD9 is not set
> # CONFIG_KXCJK1013 is not set
> CONFIG_MC3230=m
> # CONFIG_MMA7455_I2C is not set
> CONFIG_MMA7660=m
> CONFIG_MMA8452=m
> CONFIG_MMA9551_CORE=m
> CONFIG_MMA9551=m
> CONFIG_MMA9553=m
> # CONFIG_MSA311 is not set
> CONFIG_MXC4005=m
> # CONFIG_MXC6255 is not set
> # CONFIG_STK8312 is not set
> # CONFIG_STK8BA50 is not set
> # end of Accelerometers
> 
> #
> # Analog to digital converters
> #
> CONFIG_AD7091R5=m
> CONFIG_AD7291=m
> CONFIG_AD7606=m
> CONFIG_AD7606_IFACE_PARALLEL=m
> CONFIG_AD799X=m
> # CONFIG_ADI_AXI_ADC is not set
> # CONFIG_ASPEED_ADC is not set
> # CONFIG_AT91_ADC is not set
> # CONFIG_AT91_SAMA5D2_ADC is not set
> # CONFIG_AXP20X_ADC is not set
> CONFIG_AXP288_ADC=m
> # CONFIG_BCM_IPROC_ADC is not set
> # CONFIG_BERLIN2_ADC is not set
> # CONFIG_ENVELOPE_DETECTOR is not set
> # CONFIG_EXYNOS_ADC is not set
> # CONFIG_HX711 is not set
> CONFIG_INA2XX_ADC=m
> # CONFIG_INGENIC_ADC is not set
> # CONFIG_IMX7D_ADC is not set
> # CONFIG_IMX8QXP_ADC is not set
> # CONFIG_LPC18XX_ADC is not set
> # CONFIG_LPC32XX_ADC is not set
> CONFIG_LTC2471=m
> CONFIG_LTC2485=m
> # CONFIG_LTC2497 is not set
> CONFIG_MAX1363=m
> # CONFIG_MAX9611 is not set
> # CONFIG_MCP3422 is not set
> # CONFIG_MEDIATEK_MT6577_AUXADC is not set
> # CONFIG_MEN_Z188_ADC is not set
> # CONFIG_MESON_SARADC is not set
> # CONFIG_MP2629_ADC is not set
> CONFIG_NAU7802=m
> # CONFIG_NPCM_ADC is not set
> # CONFIG_RCAR_GYRO_ADC is not set
> CONFIG_RN5T618_ADC=m
> # CONFIG_ROCKCHIP_SARADC is not set
> # CONFIG_RICHTEK_RTQ6056 is not set
> # CONFIG_RZG2L_ADC is not set
> # CONFIG_SC27XX_ADC is not set
> # CONFIG_SPEAR_ADC is not set
> CONFIG_SD_ADC_MODULATOR=m
> # CONFIG_STM32_DFSDM_CORE is not set
> # CONFIG_STM32_DFSDM_ADC is not set
> CONFIG_TI_ADC081C=m
> CONFIG_TI_ADS1015=m
> # CONFIG_TI_AM335X_ADC is not set
> CONFIG_TWL4030_MADC=m
> CONFIG_TWL6030_GPADC=m
> CONFIG_VF610_ADC=m
> CONFIG_XILINX_XADC=m
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
> CONFIG_IIO_RESCALE=m
> # end of Analog Front Ends
> 
> #
> # Amplifiers
> #
> CONFIG_HMC425=m
> # end of Amplifiers
> 
> #
> # Capacitance to digital converters
> #
> # CONFIG_AD7150 is not set
> CONFIG_AD7746=m
> # end of Capacitance to digital converters
> 
> #
> # Chemical Sensors
> #
> # CONFIG_ATLAS_PH_SENSOR is not set
> CONFIG_ATLAS_EZO_SENSOR=m
> # CONFIG_BME680 is not set
> CONFIG_CCS811=m
> CONFIG_IAQCORE=m
> CONFIG_PMS7003=m
> # CONFIG_SCD30_CORE is not set
> # CONFIG_SCD4X is not set
> CONFIG_SENSIRION_SGP30=m
> CONFIG_SENSIRION_SGP40=m
> CONFIG_SPS30=m
> CONFIG_SPS30_I2C=m
> CONFIG_SPS30_SERIAL=m
> # CONFIG_SENSEAIR_SUNRISE_CO2 is not set
> # CONFIG_VZ89X is not set
> # end of Chemical Sensors
> 
> #
> # Hid Sensor IIO Common
> #
> CONFIG_HID_SENSOR_IIO_COMMON=m
> CONFIG_HID_SENSOR_IIO_TRIGGER=m
> # end of Hid Sensor IIO Common
> 
> CONFIG_IIO_MS_SENSORS_I2C=m
> 
> #
> # IIO SCMI Sensors
> #
> # end of IIO SCMI Sensors
> 
> #
> # SSP Sensor Common
> #
> # end of SSP Sensor Common
> 
> CONFIG_IIO_ST_SENSORS_I2C=m
> CONFIG_IIO_ST_SENSORS_CORE=m
> 
> #
> # Digital to analog converters
> #
> CONFIG_AD5064=m
> CONFIG_AD5380=m
> CONFIG_AD5446=m
> CONFIG_AD5592R_BASE=m
> CONFIG_AD5593R=m
> # CONFIG_AD5696_I2C is not set
> CONFIG_DPOT_DAC=m
> CONFIG_DS4424=m
> # CONFIG_LPC18XX_DAC is not set
> CONFIG_M62332=m
> # CONFIG_MAX517 is not set
> CONFIG_MAX5821=m
> CONFIG_MCP4725=m
> CONFIG_TI_DAC5571=m
> CONFIG_VF610_DAC=m
> # end of Digital to analog converters
> 
> #
> # IIO dummy driver
> #
> CONFIG_IIO_SIMPLE_DUMMY=m
> # CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
> # CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
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
> CONFIG_BMG160=m
> CONFIG_BMG160_I2C=m
> CONFIG_FXAS21002C=m
> CONFIG_FXAS21002C_I2C=m
> CONFIG_HID_SENSOR_GYRO_3D=m
> # CONFIG_MPU3050_I2C is not set
> CONFIG_IIO_ST_GYRO_3AXIS=m
> CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
> CONFIG_ITG3200=m
> # end of Digital gyroscope sensors
> 
> #
> # Health Sensors
> #
> 
> #
> # Heart Rate Monitors
> #
> CONFIG_AFE4404=m
> CONFIG_MAX30100=m
> # CONFIG_MAX30102 is not set
> # end of Heart Rate Monitors
> # end of Health Sensors
> 
> #
> # Humidity sensors
> #
> CONFIG_AM2315=m
> CONFIG_DHT11=m
> CONFIG_HDC100X=m
> # CONFIG_HDC2010 is not set
> CONFIG_HID_SENSOR_HUMIDITY=m
> CONFIG_HTS221=m
> CONFIG_HTS221_I2C=m
> # CONFIG_HTU21 is not set
> # CONFIG_SI7005 is not set
> # CONFIG_SI7020 is not set
> # end of Humidity sensors
> 
> #
> # Inertial measurement units
> #
> # CONFIG_BMI160_I2C is not set
> # CONFIG_BOSCH_BNO055_SERIAL is not set
> # CONFIG_BOSCH_BNO055_I2C is not set
> # CONFIG_FXOS8700_I2C is not set
> # CONFIG_KMX61 is not set
> # CONFIG_INV_ICM42600_I2C is not set
> # CONFIG_INV_MPU6050_I2C is not set
> CONFIG_IIO_ST_LSM6DSX=m
> CONFIG_IIO_ST_LSM6DSX_I2C=m
> CONFIG_IIO_ST_LSM6DSX_I3C=m
> # end of Inertial measurement units
> 
> #
> # Light sensors
> #
> CONFIG_ADJD_S311=m
> CONFIG_ADUX1020=m
> CONFIG_AL3010=m
> CONFIG_AL3320A=m
> CONFIG_APDS9300=m
> CONFIG_APDS9960=m
> # CONFIG_AS73211 is not set
> CONFIG_BH1750=m
> CONFIG_BH1780=m
> # CONFIG_CM32181 is not set
> # CONFIG_CM3232 is not set
> CONFIG_CM3323=m
> # CONFIG_CM3605 is not set
> CONFIG_CM36651=m
> CONFIG_GP2AP002=m
> CONFIG_GP2AP020A00F=m
> # CONFIG_IQS621_ALS is not set
> CONFIG_SENSORS_ISL29018=m
> # CONFIG_SENSORS_ISL29028 is not set
> CONFIG_ISL29125=m
> # CONFIG_HID_SENSOR_ALS is not set
> # CONFIG_HID_SENSOR_PROX is not set
> # CONFIG_JSA1212 is not set
> CONFIG_RPR0521=m
> CONFIG_SENSORS_LM3533=m
> CONFIG_LTR501=m
> # CONFIG_LTRF216A is not set
> CONFIG_LV0104CS=m
> CONFIG_MAX44000=m
> CONFIG_MAX44009=m
> CONFIG_NOA1305=m
> # CONFIG_OPT3001 is not set
> # CONFIG_PA12203001 is not set
> CONFIG_SI1133=m
> # CONFIG_SI1145 is not set
> # CONFIG_STK3310 is not set
> CONFIG_ST_UVIS25=m
> CONFIG_ST_UVIS25_I2C=m
> CONFIG_TCS3414=m
> # CONFIG_TCS3472 is not set
> CONFIG_SENSORS_TSL2563=m
> # CONFIG_TSL2583 is not set
> # CONFIG_TSL2591 is not set
> # CONFIG_TSL2772 is not set
> CONFIG_TSL4531=m
> CONFIG_US5182D=m
> CONFIG_VCNL4000=m
> CONFIG_VCNL4035=m
> # CONFIG_VEML6030 is not set
> CONFIG_VEML6070=m
> # CONFIG_VL6180 is not set
> CONFIG_ZOPT2201=m
> # end of Light sensors
> 
> #
> # Magnetometer sensors
> #
> CONFIG_AK8974=m
> CONFIG_AK8975=m
> CONFIG_AK09911=m
> # CONFIG_BMC150_MAGN_I2C is not set
> CONFIG_MAG3110=m
> # CONFIG_HID_SENSOR_MAGNETOMETER_3D is not set
> CONFIG_MMC35240=m
> CONFIG_IIO_ST_MAGN_3AXIS=m
> CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
> CONFIG_SENSORS_HMC5843=m
> CONFIG_SENSORS_HMC5843_I2C=m
> CONFIG_SENSORS_RM3100=m
> CONFIG_SENSORS_RM3100_I2C=m
> # CONFIG_YAMAHA_YAS530 is not set
> # end of Magnetometer sensors
> 
> #
> # Multiplexers
> #
> CONFIG_IIO_MUX=m
> # end of Multiplexers
> 
> #
> # Inclinometer sensors
> #
> CONFIG_HID_SENSOR_INCLINOMETER_3D=m
> CONFIG_HID_SENSOR_DEVICE_ROTATION=m
> # end of Inclinometer sensors
> 
> #
> # Triggers - standalone
> #
> CONFIG_IIO_HRTIMER_TRIGGER=m
> CONFIG_IIO_INTERRUPT_TRIGGER=m
> # CONFIG_IIO_STM32_LPTIMER_TRIGGER is not set
> # CONFIG_IIO_STM32_TIMER_TRIGGER is not set
> CONFIG_IIO_TIGHTLOOP_TRIGGER=m
> # CONFIG_IIO_SYSFS_TRIGGER is not set
> # end of Triggers - standalone
> 
> #
> # Linear and angular position sensors
> #
> # CONFIG_IQS624_POS is not set
> CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE=m
> # end of Linear and angular position sensors
> 
> #
> # Digital potentiometers
> #
> # CONFIG_AD5110 is not set
> CONFIG_AD5272=m
> CONFIG_DS1803=m
> CONFIG_MAX5432=m
> CONFIG_MCP4018=m
> CONFIG_MCP4531=m
> CONFIG_TPL0102=m
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
> CONFIG_ABP060MG=m
> # CONFIG_BMP280 is not set
> # CONFIG_DLHL60D is not set
> CONFIG_DPS310=m
> CONFIG_HID_SENSOR_PRESS=m
> # CONFIG_HP03 is not set
> CONFIG_ICP10100=m
> CONFIG_MPL115=m
> CONFIG_MPL115_I2C=m
> # CONFIG_MPL3115 is not set
> # CONFIG_MS5611 is not set
> CONFIG_MS5637=m
> CONFIG_IIO_ST_PRESS=m
> CONFIG_IIO_ST_PRESS_I2C=m
> CONFIG_T5403=m
> # CONFIG_HP206C is not set
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
> CONFIG_ISL29501=m
> CONFIG_LIDAR_LITE_V2=m
> CONFIG_MB1232=m
> # CONFIG_PING is not set
> CONFIG_RFD77402=m
> CONFIG_SRF04=m
> CONFIG_SX_COMMON=m
> CONFIG_SX9310=m
> # CONFIG_SX9324 is not set
> # CONFIG_SX9360 is not set
> # CONFIG_SX9500 is not set
> # CONFIG_SRF08 is not set
> CONFIG_VCNL3020=m
> # CONFIG_VL53L0X_I2C is not set
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
> CONFIG_HID_SENSOR_TEMP=m
> CONFIG_MLX90614=m
> CONFIG_MLX90632=m
> CONFIG_TMP006=m
> CONFIG_TMP007=m
> # CONFIG_TMP117 is not set
> CONFIG_TSYS01=m
> # CONFIG_TSYS02D is not set
> # end of Temperature sensors
> 
> # CONFIG_NTB is not set
> CONFIG_PWM=y
> CONFIG_PWM_SYSFS=y
> # CONFIG_PWM_DEBUG is not set
> # CONFIG_PWM_ATMEL is not set
> CONFIG_PWM_ATMEL_HLCDC_PWM=y
> # CONFIG_PWM_ATMEL_TCB is not set
> # CONFIG_PWM_BCM_IPROC is not set
> # CONFIG_PWM_BCM_KONA is not set
> # CONFIG_PWM_BCM2835 is not set
> # CONFIG_PWM_BERLIN is not set
> # CONFIG_PWM_BRCMSTB is not set
> # CONFIG_PWM_CLK is not set
> # CONFIG_PWM_CLPS711X is not set
> CONFIG_PWM_DWC=y
> # CONFIG_PWM_EP93XX is not set
> # CONFIG_PWM_FSL_FTM is not set
> # CONFIG_PWM_HIBVT is not set
> # CONFIG_PWM_IMG is not set
> # CONFIG_PWM_IMX1 is not set
> # CONFIG_PWM_IMX27 is not set
> # CONFIG_PWM_IMX_TPM is not set
> # CONFIG_PWM_INTEL_LGM is not set
> # CONFIG_PWM_IQS620A is not set
> # CONFIG_PWM_JZ4740 is not set
> # CONFIG_PWM_KEEMBAY is not set
> # CONFIG_PWM_LP3943 is not set
> # CONFIG_PWM_LPC18XX_SCT is not set
> # CONFIG_PWM_LPC32XX is not set
> # CONFIG_PWM_LPSS_PCI is not set
> # CONFIG_PWM_LPSS_PLATFORM is not set
> # CONFIG_PWM_MESON is not set
> # CONFIG_PWM_MTK_DISP is not set
> # CONFIG_PWM_MEDIATEK is not set
> # CONFIG_PWM_MXS is not set
> # CONFIG_PWM_NTXEC is not set
> # CONFIG_PWM_OMAP_DMTIMER is not set
> # CONFIG_PWM_PCA9685 is not set
> # CONFIG_PWM_PXA is not set
> # CONFIG_PWM_RASPBERRYPI_POE is not set
> # CONFIG_PWM_RCAR is not set
> # CONFIG_PWM_RENESAS_TPU is not set
> # CONFIG_PWM_ROCKCHIP is not set
> # CONFIG_PWM_SAMSUNG is not set
> CONFIG_PWM_SIFIVE=m
> # CONFIG_PWM_SL28CPLD is not set
> # CONFIG_PWM_SPEAR is not set
> # CONFIG_PWM_SPRD is not set
> # CONFIG_PWM_STI is not set
> # CONFIG_PWM_STM32 is not set
> # CONFIG_PWM_STM32_LP is not set
> # CONFIG_PWM_SUN4I is not set
> # CONFIG_PWM_SUNPLUS is not set
> # CONFIG_PWM_TEGRA is not set
> # CONFIG_PWM_TIECAP is not set
> # CONFIG_PWM_TIEHRPWM is not set
> CONFIG_PWM_TWL=m
> CONFIG_PWM_TWL_LED=y
> # CONFIG_PWM_VISCONTI is not set
> # CONFIG_PWM_VT8500 is not set
> # CONFIG_PWM_XILINX is not set
> 
> #
> # IRQ chip support
> #
> CONFIG_IRQCHIP=y
> CONFIG_AL_FIC=y
> CONFIG_MADERA_IRQ=y
> # CONFIG_JCORE_AIC is not set
> # CONFIG_RENESAS_INTC_IRQPIN is not set
> # CONFIG_RENESAS_IRQC is not set
> # CONFIG_RENESAS_RZA1_IRQC is not set
> # CONFIG_RENESAS_RZG2L_IRQC is not set
> # CONFIG_SL28CPLD_INTC is not set
> # CONFIG_TS4800_IRQ is not set
> # CONFIG_XILINX_INTC is not set
> # CONFIG_INGENIC_TCU_IRQ is not set
> # CONFIG_IRQ_UNIPHIER_AIDET is not set
> # CONFIG_MESON_IRQ_GPIO is not set
> # CONFIG_IMX_IRQSTEER is not set
> # CONFIG_IMX_INTMUX is not set
> # CONFIG_IMX_MU_MSI is not set
> CONFIG_RISCV_INTC=y
> CONFIG_SIFIVE_PLIC=y
> # CONFIG_EXYNOS_IRQ_COMBINER is not set
> # CONFIG_MST_IRQ is not set
> # CONFIG_MCHP_EIC is not set
> # CONFIG_SUNPLUS_SP7021_INTC is not set
> # end of IRQ chip support
> 
> CONFIG_IPACK_BUS=m
> # CONFIG_BOARD_TPCI200 is not set
> CONFIG_SERIAL_IPOCTAL=m
> CONFIG_RESET_CONTROLLER=y
> # CONFIG_RESET_A10SR is not set
> # CONFIG_RESET_ATH79 is not set
> # CONFIG_RESET_AXS10X is not set
> # CONFIG_RESET_BCM6345 is not set
> # CONFIG_RESET_BERLIN is not set
> # CONFIG_RESET_BRCMSTB is not set
> # CONFIG_RESET_BRCMSTB_RESCAL is not set
> # CONFIG_RESET_HSDK is not set
> # CONFIG_RESET_IMX7 is not set
> # CONFIG_RESET_INTEL_GW is not set
> # CONFIG_RESET_K210 is not set
> # CONFIG_RESET_LANTIQ is not set
> # CONFIG_RESET_LPC18XX is not set
> # CONFIG_RESET_MCHP_SPARX5 is not set
> # CONFIG_RESET_MESON is not set
> # CONFIG_RESET_MESON_AUDIO_ARB is not set
> # CONFIG_RESET_NPCM is not set
> # CONFIG_RESET_PISTACHIO is not set
> CONFIG_RESET_POLARFIRE_SOC=y
> # CONFIG_RESET_QCOM_AOSS is not set
> # CONFIG_RESET_QCOM_PDC is not set
> # CONFIG_RESET_RASPBERRYPI is not set
> # CONFIG_RESET_RZG2L_USBPHY_CTRL is not set
> # CONFIG_RESET_SCMI is not set
> CONFIG_RESET_SIMPLE=y
> # CONFIG_RESET_SOCFPGA is not set
> # CONFIG_RESET_STARFIVE_JH7100 is not set
> # CONFIG_RESET_SUNPLUS is not set
> # CONFIG_RESET_SUNXI is not set
> # CONFIG_RESET_TI_SCI is not set
> CONFIG_RESET_TI_SYSCON=m
> # CONFIG_RESET_TI_TPS380X is not set
> # CONFIG_RESET_TN48M_CPLD is not set
> # CONFIG_RESET_UNIPHIER is not set
> # CONFIG_RESET_UNIPHIER_GLUE is not set
> # CONFIG_RESET_ZYNQ is not set
> # CONFIG_COMMON_RESET_HI3660 is not set
> # CONFIG_COMMON_RESET_HI6220 is not set
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
> # CONFIG_PHY_SUN50I_USB3 is not set
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
> # CONFIG_PHY_BCM_SR_USB is not set
> CONFIG_BCM_KONA_USB2_PHY=m
> # CONFIG_PHY_BCM_NS_USB2 is not set
> # CONFIG_PHY_NS2_USB_DRD is not set
> # CONFIG_PHY_BRCM_SATA is not set
> # CONFIG_PHY_BRCM_USB is not set
> # CONFIG_PHY_BCM_SR_PCIE is not set
> # end of PHY drivers for Broadcom platforms
> 
> CONFIG_PHY_CADENCE_TORRENT=y
> CONFIG_PHY_CADENCE_DPHY=m
> # CONFIG_PHY_CADENCE_DPHY_RX is not set
> CONFIG_PHY_CADENCE_SIERRA=y
> CONFIG_PHY_CADENCE_SALVO=m
> # CONFIG_PHY_FSL_IMX8MQ_USB is not set
> # CONFIG_PHY_MIXEL_LVDS_PHY is not set
> CONFIG_PHY_MIXEL_MIPI_DPHY=m
> # CONFIG_PHY_FSL_IMX8M_PCIE is not set
> # CONFIG_PHY_FSL_LYNX_28G is not set
> # CONFIG_PHY_HI6220_USB is not set
> # CONFIG_PHY_HI3660_USB is not set
> # CONFIG_PHY_HI3670_USB is not set
> # CONFIG_PHY_HI3670_PCIE is not set
> # CONFIG_PHY_HISTB_COMBPHY is not set
> # CONFIG_PHY_HISI_INNO_USB2 is not set
> # CONFIG_PHY_LANTIQ_VRX200_PCIE is not set
> # CONFIG_PHY_LANTIQ_RCU_USB2 is not set
> # CONFIG_ARMADA375_USBCLUSTER_PHY is not set
> # CONFIG_PHY_BERLIN_SATA is not set
> # CONFIG_PHY_BERLIN_USB is not set
> CONFIG_PHY_MVEBU_A3700_UTMI=y
> # CONFIG_PHY_MVEBU_A38X_COMPHY is not set
> CONFIG_PHY_PXA_28NM_HSIC=m
> # CONFIG_PHY_PXA_28NM_USB2 is not set
> # CONFIG_PHY_PXA_USB is not set
> # CONFIG_PHY_MMP3_USB is not set
> # CONFIG_PHY_MMP3_HSIC is not set
> # CONFIG_PHY_MTK_PCIE is not set
> # CONFIG_PHY_MTK_TPHY is not set
> # CONFIG_PHY_MTK_UFS is not set
> # CONFIG_PHY_MTK_XSPHY is not set
> # CONFIG_PHY_MTK_HDMI is not set
> # CONFIG_PHY_MTK_MIPI_DSI is not set
> # CONFIG_PHY_MTK_DP is not set
> # CONFIG_PHY_SPARX5_SERDES is not set
> # CONFIG_PHY_LAN966X_SERDES is not set
> CONFIG_PHY_OCELOT_SERDES=y
> # CONFIG_PHY_ATH79_USB is not set
> # CONFIG_PHY_QCOM_EDP is not set
> # CONFIG_PHY_QCOM_IPQ4019_USB is not set
> # CONFIG_PHY_QCOM_PCIE2 is not set
> # CONFIG_PHY_QCOM_QMP is not set
> # CONFIG_PHY_QCOM_QUSB2 is not set
> # CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2 is not set
> # CONFIG_PHY_QCOM_USB_HS_28NM is not set
> # CONFIG_PHY_QCOM_USB_SS is not set
> # CONFIG_PHY_QCOM_IPQ806X_USB is not set
> # CONFIG_PHY_MT7621_PCI is not set
> # CONFIG_PHY_RALINK_USB is not set
> # CONFIG_PHY_RCAR_GEN3_USB3 is not set
> # CONFIG_PHY_ROCKCHIP_DPHY_RX0 is not set
> # CONFIG_PHY_ROCKCHIP_INNO_HDMI is not set
> # CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY is not set
> # CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY is not set
> # CONFIG_PHY_ROCKCHIP_PCIE is not set
> # CONFIG_PHY_ROCKCHIP_SNPS_PCIE3 is not set
> # CONFIG_PHY_ROCKCHIP_TYPEC is not set
> # CONFIG_PHY_EXYNOS_DP_VIDEO is not set
> # CONFIG_PHY_EXYNOS_MIPI_VIDEO is not set
> # CONFIG_PHY_EXYNOS_PCIE is not set
> # CONFIG_PHY_SAMSUNG_UFS is not set
> # CONFIG_PHY_SAMSUNG_USB2 is not set
> # CONFIG_PHY_UNIPHIER_USB2 is not set
> # CONFIG_PHY_UNIPHIER_USB3 is not set
> # CONFIG_PHY_UNIPHIER_PCIE is not set
> CONFIG_PHY_UNIPHIER_AHCI=y
> # CONFIG_PHY_ST_SPEAR1310_MIPHY is not set
> # CONFIG_PHY_ST_SPEAR1340_MIPHY is not set
> # CONFIG_PHY_STIH407_USB is not set
> # CONFIG_PHY_STM32_USBPHYC is not set
> # CONFIG_PHY_SUNPLUS_USB is not set
> # CONFIG_PHY_TEGRA194_P2U is not set
> # CONFIG_PHY_DA8XX_USB is not set
> # CONFIG_PHY_AM654_SERDES is not set
> # CONFIG_PHY_J721E_WIZ is not set
> # CONFIG_OMAP_CONTROL_PHY is not set
> # CONFIG_TI_PIPE3 is not set
> # CONFIG_PHY_INTEL_KEEMBAY_EMMC is not set
> # CONFIG_PHY_INTEL_KEEMBAY_USB is not set
> # CONFIG_PHY_INTEL_LGM_COMBO is not set
> # CONFIG_PHY_INTEL_LGM_EMMC is not set
> # CONFIG_PHY_INTEL_THUNDERBAY_EMMC is not set
> # CONFIG_PHY_XILINX_ZYNQMP is not set
> # end of PHY Subsystem
> 
> CONFIG_POWERCAP=y
> # CONFIG_DTPM is not set
> CONFIG_MCB=y
> # CONFIG_MCB_PCI is not set
> CONFIG_MCB_LPC=y
> CONFIG_RAS=y
> CONFIG_USB4=y
> CONFIG_USB4_DEBUGFS_WRITE=y
> # CONFIG_USB4_DEBUGFS_MARGINING is not set
> CONFIG_USB4_DMA_TEST=y
> 
> #
> # Android
> #
> # CONFIG_ANDROID_BINDER_IPC is not set
> # end of Android
> 
> CONFIG_DAX=y
> CONFIG_NVMEM=y
> # CONFIG_NVMEM_SYSFS is not set
> # CONFIG_NVMEM_APPLE_EFUSES is not set
> # CONFIG_NVMEM_BCM_OCOTP is not set
> # CONFIG_NVMEM_BRCM_NVRAM is not set
> # CONFIG_NVMEM_IMX_IIM is not set
> # CONFIG_NVMEM_IMX_OCOTP is not set
> # CONFIG_NVMEM_JZ4780_EFUSE is not set
> # CONFIG_NVMEM_LAN9662_OTPC is not set
> # CONFIG_NVMEM_LAYERSCAPE_SFP is not set
> # CONFIG_NVMEM_LPC18XX_EEPROM is not set
> # CONFIG_NVMEM_LPC18XX_OTP is not set
> # CONFIG_NVMEM_MESON_MX_EFUSE is not set
> # CONFIG_NVMEM_MICROCHIP_OTPC is not set
> # CONFIG_NVMEM_MTK_EFUSE is not set
> # CONFIG_NVMEM_MXS_OCOTP is not set
> # CONFIG_NVMEM_NINTENDO_OTP is not set
> # CONFIG_NVMEM_QCOM_QFPROM is not set
> # CONFIG_NVMEM_RAVE_SP_EEPROM is not set
> # CONFIG_NVMEM_RMEM is not set
> # CONFIG_NVMEM_ROCKCHIP_EFUSE is not set
> # CONFIG_NVMEM_ROCKCHIP_OTP is not set
> # CONFIG_NVMEM_SC27XX_EFUSE is not set
> # CONFIG_NVMEM_SNVS_LPGPR is not set
> # CONFIG_NVMEM_SPRD_EFUSE is not set
> # CONFIG_NVMEM_STM32_ROMEM is not set
> # CONFIG_NVMEM_SUNPLUS_OCOTP is not set
> # CONFIG_NVMEM_U_BOOT_ENV is not set
> # CONFIG_NVMEM_UNIPHIER_EFUSE is not set
> # CONFIG_NVMEM_VF610_OCOTP is not set
> 
> #
> # HW tracing support
> #
> CONFIG_STM=m
> CONFIG_STM_PROTO_BASIC=m
> # CONFIG_STM_PROTO_SYS_T is not set
> CONFIG_STM_DUMMY=m
> # CONFIG_STM_SOURCE_CONSOLE is not set
> # CONFIG_STM_SOURCE_HEARTBEAT is not set
> # CONFIG_STM_SOURCE_FTRACE is not set
> CONFIG_INTEL_TH=y
> CONFIG_INTEL_TH_PCI=m
> CONFIG_INTEL_TH_GTH=m
> # CONFIG_INTEL_TH_STH is not set
> CONFIG_INTEL_TH_MSU=m
> # CONFIG_INTEL_TH_PTI is not set
> # CONFIG_INTEL_TH_DEBUG is not set
> # end of HW tracing support
> 
> CONFIG_FPGA=m
> # CONFIG_FPGA_MGR_SOCFPGA is not set
> # CONFIG_FPGA_MGR_SOCFPGA_A10 is not set
> CONFIG_ALTERA_PR_IP_CORE=m
> # CONFIG_ALTERA_PR_IP_CORE_PLAT is not set
> # CONFIG_FPGA_MGR_ALTERA_CVP is not set
> # CONFIG_FPGA_MGR_ZYNQ_FPGA is not set
> CONFIG_FPGA_BRIDGE=m
> CONFIG_ALTERA_FREEZE_BRIDGE=m
> CONFIG_XILINX_PR_DECOUPLER=m
> CONFIG_FPGA_REGION=m
> CONFIG_OF_FPGA_REGION=m
> CONFIG_FPGA_DFL=m
> # CONFIG_FPGA_DFL_AFU is not set
> CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000=m
> CONFIG_FPGA_DFL_PCI=m
> # CONFIG_FPGA_MGR_ZYNQMP_FPGA is not set
> # CONFIG_FPGA_MGR_VERSAL_FPGA is not set
> CONFIG_FSI=y
> # CONFIG_FSI_NEW_DEV_NODE is not set
> CONFIG_FSI_MASTER_GPIO=m
> # CONFIG_FSI_MASTER_HUB is not set
> # CONFIG_FSI_MASTER_ASPEED is not set
> CONFIG_FSI_SCOM=y
> CONFIG_FSI_SBEFIFO=y
> CONFIG_FSI_OCC=m
> # CONFIG_TEE is not set
> CONFIG_MULTIPLEXER=m
> 
> #
> # Multiplexer drivers
> #
> CONFIG_MUX_ADG792A=m
> # CONFIG_MUX_GPIO is not set
> CONFIG_MUX_MMIO=m
> # end of Multiplexer drivers
> 
> CONFIG_PM_OPP=y
> CONFIG_SIOX=m
> CONFIG_SIOX_BUS_GPIO=m
> CONFIG_SLIMBUS=m
> # CONFIG_SLIM_QCOM_CTRL is not set
> # CONFIG_INTERCONNECT is not set
> # CONFIG_COUNTER is not set
> CONFIG_MOST=m
> CONFIG_MOST_CDEV=m
> # CONFIG_PECI is not set
> # CONFIG_HTE is not set
> # end of Device Drivers
> 
> #
> # File systems
> #
> CONFIG_VALIDATE_FS_PARSER=y
> CONFIG_FS_IOMAP=y
> CONFIG_EXT2_FS=y
> CONFIG_EXT2_FS_XATTR=y
> CONFIG_EXT2_FS_POSIX_ACL=y
> CONFIG_EXT2_FS_SECURITY=y
> # CONFIG_EXT3_FS is not set
> CONFIG_EXT4_FS=m
> # CONFIG_EXT4_FS_POSIX_ACL is not set
> # CONFIG_EXT4_FS_SECURITY is not set
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_JBD2=m
> CONFIG_JBD2_DEBUG=y
> CONFIG_FS_MBCACHE=y
> CONFIG_REISERFS_FS=y
> CONFIG_REISERFS_CHECK=y
> # CONFIG_REISERFS_PROC_INFO is not set
> CONFIG_REISERFS_FS_XATTR=y
> # CONFIG_REISERFS_FS_POSIX_ACL is not set
> CONFIG_REISERFS_FS_SECURITY=y
> # CONFIG_JFS_FS is not set
> CONFIG_XFS_FS=y
> CONFIG_XFS_SUPPORT_V4=y
> # CONFIG_XFS_QUOTA is not set
> CONFIG_XFS_POSIX_ACL=y
> # CONFIG_XFS_RT is not set
> CONFIG_XFS_ONLINE_SCRUB=y
> # CONFIG_XFS_ONLINE_REPAIR is not set
> CONFIG_XFS_DEBUG=y
> # CONFIG_XFS_ASSERT_FATAL is not set
> CONFIG_GFS2_FS=m
> CONFIG_BTRFS_FS=m
> # CONFIG_BTRFS_FS_POSIX_ACL is not set
> CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> # CONFIG_BTRFS_DEBUG is not set
> CONFIG_BTRFS_ASSERT=y
> CONFIG_BTRFS_FS_REF_VERIFY=y
> CONFIG_NILFS2_FS=y
> # CONFIG_F2FS_FS is not set
> # CONFIG_ZONEFS_FS is not set
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> CONFIG_EXPORTFS_BLOCK_OPS=y
> # CONFIG_FILE_LOCKING is not set
> CONFIG_FS_ENCRYPTION=y
> CONFIG_FS_ENCRYPTION_ALGS=m
> # CONFIG_FS_VERITY is not set
> CONFIG_FSNOTIFY=y
> # CONFIG_DNOTIFY is not set
> CONFIG_INOTIFY_USER=y
> CONFIG_FANOTIFY=y
> CONFIG_QUOTA=y
> CONFIG_PRINT_QUOTA_WARNING=y
> # CONFIG_QUOTA_DEBUG is not set
> CONFIG_QFMT_V1=y
> # CONFIG_QFMT_V2 is not set
> CONFIG_QUOTACTL=y
> CONFIG_AUTOFS4_FS=y
> CONFIG_AUTOFS_FS=y
> CONFIG_FUSE_FS=y
> CONFIG_CUSE=m
> CONFIG_VIRTIO_FS=y
> # CONFIG_OVERLAY_FS is not set
> 
> #
> # Caches
> #
> CONFIG_NETFS_SUPPORT=m
> CONFIG_NETFS_STATS=y
> CONFIG_FSCACHE=m
> CONFIG_FSCACHE_STATS=y
> CONFIG_FSCACHE_DEBUG=y
> # CONFIG_CACHEFILES is not set
> # end of Caches
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=y
> # CONFIG_JOLIET is not set
> CONFIG_ZISOFS=y
> # CONFIG_UDF_FS is not set
> # end of CD-ROM/DVD Filesystems
> 
> #
> # DOS/FAT/EXFAT/NT Filesystems
> #
> CONFIG_FAT_FS=m
> CONFIG_MSDOS_FS=m
> # CONFIG_VFAT_FS is not set
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_EXFAT_FS=y
> CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
> CONFIG_NTFS_FS=y
> CONFIG_NTFS_DEBUG=y
> # CONFIG_NTFS_RW is not set
> CONFIG_NTFS3_FS=y
> # CONFIG_NTFS3_64BIT_CLUSTER is not set
> CONFIG_NTFS3_LZX_XPRESS=y
> CONFIG_NTFS3_FS_POSIX_ACL=y
> # end of DOS/FAT/EXFAT/NT Filesystems
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> # CONFIG_PROC_KCORE is not set
> CONFIG_PROC_VMCORE=y
> # CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
> # CONFIG_PROC_SYSCTL is not set
> # CONFIG_PROC_PAGE_MONITOR is not set
> CONFIG_PROC_CHILDREN=y
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> # CONFIG_TMPFS_POSIX_ACL is not set
> CONFIG_TMPFS_XATTR=y
> # CONFIG_TMPFS_INODE64 is not set
> CONFIG_ARCH_SUPPORTS_HUGETLBFS=y
> CONFIG_HUGETLBFS=y
> CONFIG_HUGETLB_PAGE=y
> CONFIG_MEMFD_CREATE=y
> CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
> CONFIG_CONFIGFS_FS=m
> # CONFIG_EFIVAR_FS is not set
> # end of Pseudo filesystems
> 
> CONFIG_MISC_FILESYSTEMS=y
> CONFIG_ORANGEFS_FS=m
> CONFIG_ADFS_FS=y
> CONFIG_ADFS_FS_RW=y
> CONFIG_AFFS_FS=m
> # CONFIG_ECRYPT_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> CONFIG_BEFS_FS=m
> # CONFIG_BEFS_DEBUG is not set
> CONFIG_BFS_FS=m
> CONFIG_EFS_FS=y
> # CONFIG_JFFS2_FS is not set
> # CONFIG_UBIFS_FS is not set
> CONFIG_CRAMFS=m
> # CONFIG_CRAMFS_BLOCKDEV is not set
> CONFIG_CRAMFS_MTD=y
> CONFIG_SQUASHFS=m
> # CONFIG_SQUASHFS_FILE_CACHE is not set
> CONFIG_SQUASHFS_FILE_DIRECT=y
> CONFIG_SQUASHFS_DECOMP_SINGLE=y
> # CONFIG_SQUASHFS_DECOMP_MULTI is not set
> # CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
> CONFIG_SQUASHFS_XATTR=y
> CONFIG_SQUASHFS_ZLIB=y
> # CONFIG_SQUASHFS_LZ4 is not set
> CONFIG_SQUASHFS_LZO=y
> CONFIG_SQUASHFS_XZ=y
> # CONFIG_SQUASHFS_ZSTD is not set
> CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
> # CONFIG_SQUASHFS_EMBEDDED is not set
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
> CONFIG_VXFS_FS=m
> # CONFIG_MINIX_FS is not set
> CONFIG_OMFS_FS=y
> # CONFIG_HPFS_FS is not set
> CONFIG_QNX4FS_FS=m
> # CONFIG_QNX6FS_FS is not set
> CONFIG_ROMFS_FS=y
> # CONFIG_ROMFS_BACKED_BY_BLOCK is not set
> CONFIG_ROMFS_BACKED_BY_MTD=y
> # CONFIG_ROMFS_BACKED_BY_BOTH is not set
> CONFIG_ROMFS_ON_MTD=y
> CONFIG_PSTORE=y
> CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
> CONFIG_PSTORE_DEFLATE_COMPRESS=m
> CONFIG_PSTORE_LZO_COMPRESS=m
> CONFIG_PSTORE_LZ4_COMPRESS=y
> CONFIG_PSTORE_LZ4HC_COMPRESS=y
> # CONFIG_PSTORE_842_COMPRESS is not set
> # CONFIG_PSTORE_ZSTD_COMPRESS is not set
> CONFIG_PSTORE_COMPRESS=y
> CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
> # CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
> # CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
> # CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
> CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
> CONFIG_PSTORE_CONSOLE=y
> # CONFIG_PSTORE_PMSG is not set
> CONFIG_PSTORE_RAM=y
> CONFIG_PSTORE_ZONE=y
> CONFIG_PSTORE_BLK=y
> CONFIG_PSTORE_BLK_BLKDEV=""
> CONFIG_PSTORE_BLK_KMSG_SIZE=64
> CONFIG_PSTORE_BLK_MAX_REASON=2
> CONFIG_PSTORE_BLK_CONSOLE_SIZE=64
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> # CONFIG_EROFS_FS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> # CONFIG_NLS_CODEPAGE_437 is not set
> CONFIG_NLS_CODEPAGE_737=m
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> CONFIG_NLS_CODEPAGE_852=y
> CONFIG_NLS_CODEPAGE_855=y
> CONFIG_NLS_CODEPAGE_857=m
> # CONFIG_NLS_CODEPAGE_860 is not set
> CONFIG_NLS_CODEPAGE_861=m
> CONFIG_NLS_CODEPAGE_862=m
> # CONFIG_NLS_CODEPAGE_863 is not set
> CONFIG_NLS_CODEPAGE_864=y
> # CONFIG_NLS_CODEPAGE_865 is not set
> CONFIG_NLS_CODEPAGE_866=m
> CONFIG_NLS_CODEPAGE_869=m
> CONFIG_NLS_CODEPAGE_936=y
> CONFIG_NLS_CODEPAGE_950=y
> CONFIG_NLS_CODEPAGE_932=y
> CONFIG_NLS_CODEPAGE_949=y
> CONFIG_NLS_CODEPAGE_874=y
> CONFIG_NLS_ISO8859_8=y
> # CONFIG_NLS_CODEPAGE_1250 is not set
> CONFIG_NLS_CODEPAGE_1251=y
> # CONFIG_NLS_ASCII is not set
> CONFIG_NLS_ISO8859_1=m
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> CONFIG_NLS_ISO8859_4=y
> CONFIG_NLS_ISO8859_5=y
> CONFIG_NLS_ISO8859_6=y
> CONFIG_NLS_ISO8859_7=y
> # CONFIG_NLS_ISO8859_9 is not set
> CONFIG_NLS_ISO8859_13=m
> CONFIG_NLS_ISO8859_14=y
> CONFIG_NLS_ISO8859_15=y
> CONFIG_NLS_KOI8_R=m
> # CONFIG_NLS_KOI8_U is not set
> CONFIG_NLS_MAC_ROMAN=m
> CONFIG_NLS_MAC_CELTIC=m
> CONFIG_NLS_MAC_CENTEURO=m
> CONFIG_NLS_MAC_CROATIAN=y
> # CONFIG_NLS_MAC_CYRILLIC is not set
> CONFIG_NLS_MAC_GAELIC=y
> CONFIG_NLS_MAC_GREEK=y
> CONFIG_NLS_MAC_ICELAND=y
> # CONFIG_NLS_MAC_INUIT is not set
> CONFIG_NLS_MAC_ROMANIAN=m
> CONFIG_NLS_MAC_TURKISH=y
> CONFIG_NLS_UTF8=m
> CONFIG_UNICODE=y
> CONFIG_UNICODE_NORMALIZATION_SELFTEST=m
> # end of File systems
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> CONFIG_KEYS_REQUEST_CACHE=y
> CONFIG_PERSISTENT_KEYRINGS=y
> # CONFIG_BIG_KEYS is not set
> CONFIG_TRUSTED_KEYS=y
> CONFIG_TRUSTED_KEYS_TPM=y
> CONFIG_ENCRYPTED_KEYS=m
> # CONFIG_USER_DECRYPTED_DATA is not set
> CONFIG_KEY_DH_OPERATIONS=y
> # CONFIG_KEY_NOTIFICATIONS is not set
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> # CONFIG_SECURITY is not set
> CONFIG_SECURITYFS=y
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> CONFIG_HARDENED_USERCOPY=y
> # CONFIG_FORTIFY_SOURCE is not set
> CONFIG_STATIC_USERMODEHELPER=y
> CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
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
> CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
> CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_ENABLER=y
> CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
> # CONFIG_INIT_STACK_NONE is not set
> # CONFIG_INIT_STACK_ALL_PATTERN is not set
> CONFIG_INIT_STACK_ALL_ZERO=y
> # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> CONFIG_INIT_ON_FREE_DEFAULT_ON=y
> # end of Memory initialization
> 
> CONFIG_CC_HAS_RANDSTRUCT=y
> # CONFIG_RANDSTRUCT_NONE is not set
> CONFIG_RANDSTRUCT_FULL=y
> CONFIG_RANDSTRUCT=y
> # end of Kernel hardening options
> # end of Security options
> 
> CONFIG_XOR_BLOCKS=m
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
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
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> CONFIG_CRYPTO_GF128MUL=y
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> # CONFIG_CRYPTO_CRYPTD is not set
> CONFIG_CRYPTO_AUTHENC=y
> CONFIG_CRYPTO_TEST=m
> CONFIG_CRYPTO_ENGINE=m
> # end of Crypto core or helper
> 
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=y
> CONFIG_CRYPTO_DH=y
> # CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
> CONFIG_CRYPTO_ECC=y
> # CONFIG_CRYPTO_ECDH is not set
> CONFIG_CRYPTO_ECDSA=y
> CONFIG_CRYPTO_ECRDSA=m
> CONFIG_CRYPTO_SM2=m
> CONFIG_CRYPTO_CURVE25519=y
> # end of Public-key cryptography
> 
> #
> # Block ciphers
> #
> CONFIG_CRYPTO_AES=y
> # CONFIG_CRYPTO_AES_TI is not set
> # CONFIG_CRYPTO_ARIA is not set
> CONFIG_CRYPTO_BLOWFISH=m
> CONFIG_CRYPTO_BLOWFISH_COMMON=m
> CONFIG_CRYPTO_CAMELLIA=m
> CONFIG_CRYPTO_CAST_COMMON=m
> # CONFIG_CRYPTO_CAST5 is not set
> CONFIG_CRYPTO_CAST6=m
> CONFIG_CRYPTO_DES=m
> # CONFIG_CRYPTO_FCRYPT is not set
> CONFIG_CRYPTO_SERPENT=m
> CONFIG_CRYPTO_SM4=y
> # CONFIG_CRYPTO_SM4_GENERIC is not set
> CONFIG_CRYPTO_TWOFISH=y
> CONFIG_CRYPTO_TWOFISH_COMMON=y
> # end of Block ciphers
> 
> #
> # Length-preserving ciphers and modes
> #
> CONFIG_CRYPTO_ADIANTUM=m
> CONFIG_CRYPTO_CHACHA20=m
> CONFIG_CRYPTO_CBC=y
> # CONFIG_CRYPTO_CFB is not set
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_CTS=m
> CONFIG_CRYPTO_ECB=y
> # CONFIG_CRYPTO_HCTR2 is not set
> CONFIG_CRYPTO_KEYWRAP=y
> CONFIG_CRYPTO_LRW=y
> CONFIG_CRYPTO_OFB=y
> # CONFIG_CRYPTO_PCBC is not set
> CONFIG_CRYPTO_XTS=y
> CONFIG_CRYPTO_NHPOLY1305=m
> # end of Length-preserving ciphers and modes
> 
> #
> # AEAD (authenticated encryption with associated data) ciphers
> #
> # CONFIG_CRYPTO_AEGIS128 is not set
> CONFIG_CRYPTO_CHACHA20POLY1305=m
> CONFIG_CRYPTO_CCM=y
> CONFIG_CRYPTO_GCM=y
> CONFIG_CRYPTO_SEQIV=m
> CONFIG_CRYPTO_ECHAINIV=y
> # CONFIG_CRYPTO_ESSIV is not set
> # end of AEAD (authenticated encryption with associated data) ciphers
> 
> #
> # Hashes, digests, and MACs
> #
> CONFIG_CRYPTO_BLAKE2B=m
> # CONFIG_CRYPTO_CMAC is not set
> CONFIG_CRYPTO_GHASH=y
> CONFIG_CRYPTO_HMAC=y
> # CONFIG_CRYPTO_MD4 is not set
> CONFIG_CRYPTO_MD5=y
> # CONFIG_CRYPTO_MICHAEL_MIC is not set
> CONFIG_CRYPTO_POLY1305=m
> # CONFIG_CRYPTO_RMD160 is not set
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=y
> # CONFIG_CRYPTO_SHA3 is not set
> CONFIG_CRYPTO_SM3=y
> # CONFIG_CRYPTO_SM3_GENERIC is not set
> CONFIG_CRYPTO_STREEBOG=m
> CONFIG_CRYPTO_VMAC=m
> CONFIG_CRYPTO_WP512=m
> CONFIG_CRYPTO_XCBC=m
> CONFIG_CRYPTO_XXHASH=y
> # end of Hashes, digests, and MACs
> 
> #
> # CRCs (cyclic redundancy checks)
> #
> CONFIG_CRYPTO_CRC32C=y
> CONFIG_CRYPTO_CRC32=y
> CONFIG_CRYPTO_CRCT10DIF=m
> # CONFIG_CRYPTO_CRC64_ROCKSOFT is not set
> # end of CRCs (cyclic redundancy checks)
> 
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=m
> CONFIG_CRYPTO_LZO=y
> # CONFIG_CRYPTO_842 is not set
> CONFIG_CRYPTO_LZ4=y
> CONFIG_CRYPTO_LZ4HC=y
> CONFIG_CRYPTO_ZSTD=m
> # end of Compression
> 
> #
> # Random number generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=m
> CONFIG_CRYPTO_DRBG_MENU=y
> CONFIG_CRYPTO_DRBG_HMAC=y
> CONFIG_CRYPTO_DRBG_HASH=y
> # CONFIG_CRYPTO_DRBG_CTR is not set
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
> CONFIG_CRYPTO_HW=y
> # CONFIG_CRYPTO_DEV_ALLWINNER is not set
> # CONFIG_CRYPTO_DEV_EXYNOS_RNG is not set
> # CONFIG_CRYPTO_DEV_S5P is not set
> # CONFIG_CRYPTO_DEV_ATMEL_AES is not set
> # CONFIG_CRYPTO_DEV_ATMEL_TDES is not set
> # CONFIG_CRYPTO_DEV_ATMEL_SHA is not set
> CONFIG_CRYPTO_DEV_ATMEL_I2C=m
> # CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
> CONFIG_CRYPTO_DEV_ATMEL_SHA204A=m
> # CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
> # CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
> # CONFIG_CRYPTO_DEV_QAT_C62X is not set
> # CONFIG_CRYPTO_DEV_QAT_4XXX is not set
> # CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
> # CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
> # CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
> # CONFIG_CAVIUM_CPT is not set
> # CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
> # CONFIG_CRYPTO_DEV_OCTEONTX_CPT is not set
> # CONFIG_CRYPTO_DEV_CAVIUM_ZIP is not set
> # CONFIG_CRYPTO_DEV_QCE is not set
> # CONFIG_CRYPTO_DEV_QCOM_RNG is not set
> # CONFIG_CRYPTO_DEV_IMGTEC_HASH is not set
> # CONFIG_CRYPTO_DEV_ZYNQMP_AES is not set
> # CONFIG_CRYPTO_DEV_ZYNQMP_SHA3 is not set
> CONFIG_CRYPTO_DEV_VIRTIO=m
> # CONFIG_CRYPTO_DEV_SAFEXCEL is not set
> CONFIG_CRYPTO_DEV_CCREE=y
> # CONFIG_CRYPTO_DEV_HISI_SEC is not set
> # CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
> # CONFIG_CRYPTO_DEV_SA2UL is not set
> # CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4 is not set
> # CONFIG_CRYPTO_DEV_KEEMBAY_OCS_ECC is not set
> # CONFIG_CRYPTO_DEV_KEEMBAY_OCS_HCU is not set
> # CONFIG_CRYPTO_DEV_ASPEED is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=y
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> CONFIG_X509_CERTIFICATE_PARSER=y
> # CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
> CONFIG_PKCS7_MESSAGE_PARSER=y
> CONFIG_PKCS7_TEST_KEY=m
> # CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
> # CONFIG_FIPS_SIGNATURE_SELFTEST is not set
> 
> #
> # Certificates for signature checking
> #
> CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
> # CONFIG_MODULE_SIG_KEY_TYPE_RSA is not set
> CONFIG_MODULE_SIG_KEY_TYPE_ECDSA=y
> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_TRUSTED_KEYS=""
> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> # CONFIG_SECONDARY_TRUSTED_KEYRING is not set
> # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
> # end of Certificates for signature checking
> 
> CONFIG_BINARY_PRINTF=y
> 
> #
> # Library routines
> #
> CONFIG_RAID6_PQ=m
> CONFIG_RAID6_PQ_BENCHMARK=y
> # CONFIG_PACKING is not set
> CONFIG_BITREVERSE=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_CORDIC=m
> # CONFIG_PRIME_NUMBERS is not set
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_PCI_IOMAP=y
> 
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_UTILS=y
> CONFIG_CRYPTO_LIB_AES=y
> CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
> CONFIG_CRYPTO_LIB_CHACHA=y
> CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
> CONFIG_CRYPTO_LIB_CURVE25519=y
> CONFIG_CRYPTO_LIB_DES=y
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
> CONFIG_CRYPTO_LIB_POLY1305=y
> CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
> CONFIG_CRYPTO_LIB_SHA1=y
> CONFIG_CRYPTO_LIB_SHA256=y
> # end of Crypto library routines
> 
> CONFIG_CRC_CCITT=m
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=m
> # CONFIG_CRC64_ROCKSOFT is not set
> CONFIG_CRC_ITU_T=y
> CONFIG_CRC32=y
> # CONFIG_CRC32_SELFTEST is not set
> # CONFIG_CRC32_SLICEBY8 is not set
> # CONFIG_CRC32_SLICEBY4 is not set
> CONFIG_CRC32_SARWATE=y
> # CONFIG_CRC32_BIT is not set
> CONFIG_CRC64=m
> CONFIG_CRC4=y
> CONFIG_CRC7=y
> CONFIG_LIBCRC32C=y
> CONFIG_CRC8=y
> CONFIG_XXHASH=y
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=m
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_COMPRESS=y
> CONFIG_LZ4HC_COMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_COMMON=y
> CONFIG_ZSTD_COMPRESS=m
> CONFIG_ZSTD_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> CONFIG_XZ_DEC_X86=y
> CONFIG_XZ_DEC_POWERPC=y
> CONFIG_XZ_DEC_IA64=y
> CONFIG_XZ_DEC_ARM=y
> # CONFIG_XZ_DEC_ARMTHUMB is not set
> # CONFIG_XZ_DEC_SPARC is not set
> # CONFIG_XZ_DEC_MICROLZMA is not set
> CONFIG_XZ_DEC_BCJ=y
> CONFIG_XZ_DEC_TEST=m
> CONFIG_DECOMPRESS_BZIP2=y
> CONFIG_DECOMPRESS_XZ=y
> CONFIG_DECOMPRESS_LZO=y
> CONFIG_DECOMPRESS_LZ4=y
> CONFIG_DECOMPRESS_ZSTD=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_REED_SOLOMON=y
> CONFIG_REED_SOLOMON_ENC8=y
> CONFIG_REED_SOLOMON_DEC8=y
> CONFIG_REED_SOLOMON_ENC16=y
> CONFIG_REED_SOLOMON_DEC16=y
> CONFIG_BCH=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> CONFIG_DMA_DECLARE_COHERENT=y
> CONFIG_ARCH_HAS_SETUP_DMA_OPS=y
> CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE=y
> CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU=y
> CONFIG_ARCH_HAS_DMA_PREP_COHERENT=y
> CONFIG_SWIOTLB=y
> # CONFIG_DMA_RESTRICTED_POOL is not set
> CONFIG_DMA_NONCOHERENT_MMAP=y
> CONFIG_DMA_COHERENT_POOL=y
> CONFIG_DMA_DIRECT_REMAP=y
> CONFIG_DMA_CMA=y
> CONFIG_DMA_PERNUMA_CMA=y
> 
> #
> # Default contiguous memory area size:
> #
> CONFIG_CMA_SIZE_MBYTES=16
> CONFIG_CMA_SIZE_PERCENTAGE=10
> # CONFIG_CMA_SIZE_SEL_MBYTES is not set
> # CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
> # CONFIG_CMA_SIZE_SEL_MIN is not set
> CONFIG_CMA_SIZE_SEL_MAX=y
> CONFIG_CMA_ALIGNMENT=8
> # CONFIG_DMA_API_DEBUG is not set
> CONFIG_DMA_MAP_BENCHMARK=y
> CONFIG_SGL_ALLOC=y
> CONFIG_GLOB=y
> # CONFIG_GLOB_SELFTEST is not set
> CONFIG_CLZ_TAB=y
> # CONFIG_IRQ_POLL is not set
> CONFIG_MPILIB=y
> CONFIG_LIBFDT=y
> CONFIG_OID_REGISTRY=y
> CONFIG_UCS2_STRING=y
> CONFIG_HAVE_GENERIC_VDSO=y
> CONFIG_GENERIC_GETTIMEOFDAY=y
> CONFIG_GENERIC_VDSO_TIME_NS=y
> CONFIG_FONT_SUPPORT=y
> CONFIG_FONT_8x16=y
> CONFIG_FONT_AUTOSELECT=y
> CONFIG_SG_POOL=y
> CONFIG_ARCH_STACKWALK=y
> CONFIG_STACKDEPOT=y
> CONFIG_SBITMAP=y
> # CONFIG_PARMAN is not set
> # CONFIG_OBJAGG is not set
> # end of Library routines
> 
> CONFIG_GENERIC_IOREMAP=y
> CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED=y
> CONFIG_ASN1_ENCODER=y
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
> CONFIG_STACKTRACE_BUILD_ID=y
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> CONFIG_BOOT_PRINTK_DELAY=y
> # CONFIG_DYNAMIC_DEBUG is not set
> # CONFIG_DYNAMIC_DEBUG_CORE is not set
> CONFIG_SYMBOLIC_ERRNAME=y
> # CONFIG_DEBUG_BUGVERBOSE is not set
> # end of printk and dmesg options
> 
> CONFIG_DEBUG_KERNEL=y
> # CONFIG_DEBUG_MISC is not set
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=y
> CONFIG_AS_HAS_NON_CONST_LEB128=y
> # CONFIG_DEBUG_INFO_NONE is not set
> # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> CONFIG_DEBUG_INFO_DWARF5=y
> CONFIG_DEBUG_INFO_REDUCED=y
> CONFIG_PAHOLE_HAS_SPLIT_BTF=y
> CONFIG_PAHOLE_HAS_BTF_TAG=y
> CONFIG_GDB_SCRIPTS=y
> CONFIG_FRAME_WARN=2048
> CONFIG_STRIP_ASM_SYMS=y
> # CONFIG_HEADERS_INSTALL is not set
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> CONFIG_ARCH_WANT_FRAME_POINTERS=y
> # CONFIG_FRAME_POINTER is not set
> CONFIG_VMLINUX_MAP=y
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
> CONFIG_HAVE_ARCH_KGDB_QXFER_PKT=y
> CONFIG_KGDB=y
> # CONFIG_KGDB_HONOUR_BLOCKLIST is not set
> CONFIG_KGDB_SERIAL_CONSOLE=m
> # CONFIG_KGDB_TESTS is not set
> # CONFIG_KGDB_KDB is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> CONFIG_UBSAN=y
> CONFIG_CC_HAS_UBSAN_BOUNDS=y
> CONFIG_CC_HAS_UBSAN_ARRAY_BOUNDS=y
> # CONFIG_UBSAN_BOUNDS is not set
> CONFIG_UBSAN_SHIFT=y
> # CONFIG_UBSAN_UNREACHABLE is not set
> CONFIG_UBSAN_BOOL=y
> CONFIG_UBSAN_ENUM=y
> # CONFIG_UBSAN_SANITIZE_ALL is not set
> CONFIG_TEST_UBSAN=m
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
> CONFIG_DEBUG_PAGEALLOC=y
> CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
> # CONFIG_DEBUG_SLAB is not set
> CONFIG_PAGE_OWNER=y
> # CONFIG_PAGE_TABLE_CHECK is not set
> CONFIG_PAGE_POISONING=y
> CONFIG_DEBUG_PAGE_REF=y
> CONFIG_ARCH_HAS_DEBUG_WX=y
> # CONFIG_DEBUG_WX is not set
> CONFIG_GENERIC_PTDUMP=y
> # CONFIG_PTDUMP_DEBUGFS is not set
> CONFIG_DEBUG_OBJECTS=y
> # CONFIG_DEBUG_OBJECTS_SELFTEST is not set
> CONFIG_DEBUG_OBJECTS_FREE=y
> # CONFIG_DEBUG_OBJECTS_TIMERS is not set
> CONFIG_DEBUG_OBJECTS_WORK=y
> # CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
> # CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
> CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
> # CONFIG_SHRINKER_DEBUG is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> CONFIG_DEBUG_KMEMLEAK=y
> CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
> CONFIG_DEBUG_KMEMLEAK_TEST=m
> CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
> # CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> CONFIG_SCHED_STACK_END_CHECK=y
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
> CONFIG_DEBUG_VM_IRQSOFF=y
> CONFIG_DEBUG_VM=y
> # CONFIG_DEBUG_VM_MAPLE_TREE is not set
> CONFIG_DEBUG_VM_RB=y
> CONFIG_DEBUG_VM_PGFLAGS=y
> # CONFIG_DEBUG_VM_PGTABLE is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> # CONFIG_DEBUG_VIRTUAL is not set
> # CONFIG_DEBUG_MEMORY_INIT is not set
> CONFIG_HAVE_ARCH_KASAN=y
> CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> CONFIG_CC_HAS_KASAN_GENERIC=y
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> # CONFIG_KASAN is not set
> CONFIG_HAVE_ARCH_KFENCE=y
> # CONFIG_KFENCE is not set
> # end of Memory Debugging
> 
> # CONFIG_DEBUG_SHIRQ is not set
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
> CONFIG_TEST_LOCKUP=m
> # end of Debug Oops, Lockups and Hangs
> 
> #
> # Scheduler Debugging
> #
> CONFIG_SCHED_DEBUG=y
> CONFIG_SCHED_INFO=y
> CONFIG_SCHEDSTATS=y
> # end of Scheduler Debugging
> 
> # CONFIG_DEBUG_TIMEKEEPING is not set
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> CONFIG_PROVE_LOCKING=y
> CONFIG_PROVE_RAW_LOCK_NESTING=y
> # CONFIG_LOCK_STAT is not set
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
> # CONFIG_DEBUG_LOCKDEP is not set
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> CONFIG_LOCK_TORTURE_TEST=m
> CONFIG_WW_MUTEX_SELFTEST=m
> # CONFIG_SCF_TORTURE_TEST is not set
> # CONFIG_CSD_LOCK_WAIT_DEBUG is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
> 
> CONFIG_TRACE_IRQFLAGS=y
> CONFIG_DEBUG_IRQFLAGS=y
> CONFIG_STACKTRACE=y
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
> 
> #
> # Debug kernel data structures
> #
> CONFIG_DEBUG_LIST=y
> # CONFIG_DEBUG_PLIST is not set
> CONFIG_DEBUG_SG=y
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
> CONFIG_TORTURE_TEST=y
> CONFIG_RCU_SCALE_TEST=m
> CONFIG_RCU_TORTURE_TEST=y
> CONFIG_RCU_REF_SCALE_TEST=m
> CONFIG_RCU_TRACE=y
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
> 
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> CONFIG_NOP_TRACER=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
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
> CONFIG_BOOTTIME_TRACING=y
> # CONFIG_FUNCTION_TRACER is not set
> # CONFIG_STACK_TRACER is not set
> CONFIG_IRQSOFF_TRACER=y
> # CONFIG_SCHED_TRACER is not set
> # CONFIG_HWLAT_TRACER is not set
> CONFIG_OSNOISE_TRACER=y
> CONFIG_TIMERLAT_TRACER=y
> CONFIG_FTRACE_SYSCALLS=y
> CONFIG_TRACER_SNAPSHOT=y
> CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
> CONFIG_TRACE_BRANCH_PROFILING=y
> # CONFIG_BRANCH_PROFILE_NONE is not set
> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> CONFIG_PROFILE_ALL_BRANCHES=y
> # CONFIG_BRANCH_TRACER is not set
> CONFIG_BLK_DEV_IO_TRACE=y
> CONFIG_KPROBE_EVENTS=y
> CONFIG_DYNAMIC_EVENTS=y
> CONFIG_PROBE_EVENTS=y
> # CONFIG_SYNTH_EVENTS is not set
> # CONFIG_USER_EVENTS is not set
> # CONFIG_TRACE_EVENT_INJECT is not set
> # CONFIG_TRACEPOINT_BENCHMARK is not set
> CONFIG_RING_BUFFER_BENCHMARK=y
> CONFIG_TRACE_EVAL_MAP_FILE=y
> # CONFIG_FTRACE_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS=y
> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> CONFIG_KPROBE_EVENT_GEN_TEST=y
> # CONFIG_RV is not set
> # CONFIG_SAMPLES is not set
> # CONFIG_STRICT_DEVMEM is not set
> 
> #
> # riscv Debugging
> #
> # end of riscv Debugging
> 
> #
> # Kernel Testing and Coverage
> #
> # CONFIG_KUNIT is not set
> CONFIG_NOTIFIER_ERROR_INJECTION=m
> CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=m
> CONFIG_FUNCTION_ERROR_INJECTION=y
> # CONFIG_FAULT_INJECTION is not set
> CONFIG_ARCH_HAS_KCOV=y
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> # CONFIG_KCOV is not set
> CONFIG_RUNTIME_TESTING_MENU=y
> # CONFIG_LKDTM is not set
> CONFIG_TEST_MIN_HEAP=y
> # CONFIG_TEST_DIV64 is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_TEST_REF_TRACKER is not set
> CONFIG_RBTREE_TEST=y
> CONFIG_REED_SOLOMON_TEST=y
> # CONFIG_INTERVAL_TREE_TEST is not set
> # CONFIG_PERCPU_TEST is not set
> # CONFIG_ATOMIC64_SELFTEST is not set
> # CONFIG_TEST_HEXDUMP is not set
> # CONFIG_STRING_SELFTEST is not set
> # CONFIG_TEST_STRING_HELPERS is not set
> CONFIG_TEST_STRSCPY=m
> CONFIG_TEST_KSTRTOX=y
> CONFIG_TEST_PRINTF=y
> CONFIG_TEST_SCANF=y
> CONFIG_TEST_BITMAP=y
> CONFIG_TEST_UUID=m
> # CONFIG_TEST_XARRAY is not set
> # CONFIG_TEST_RHASHTABLE is not set
> # CONFIG_TEST_SIPHASH is not set
> CONFIG_TEST_IDA=y
> CONFIG_TEST_LKM=m
> CONFIG_TEST_BITOPS=m
> CONFIG_TEST_VMALLOC=m
> CONFIG_TEST_USER_COPY=m
> # CONFIG_FIND_BIT_BENCHMARK is not set
> # CONFIG_TEST_FIRMWARE is not set
> CONFIG_TEST_UDELAY=y
> # CONFIG_TEST_STATIC_KEYS is not set
> CONFIG_TEST_MEMCAT_P=m
> CONFIG_TEST_MEMINIT=m
> CONFIG_TEST_FREE_PAGES=y
> CONFIG_ARCH_USE_MEMTEST=y
> CONFIG_MEMTEST=y
> # end of Kernel Testing and Coverage
> 
> #
> # Rust hacking
> #
> # end of Rust hacking
> 
> # CONFIG_WARN_MISSING_DOCUMENTS is not set
> # CONFIG_WARN_ABI_ERRORS is not set
> # end of Kernel hacking

