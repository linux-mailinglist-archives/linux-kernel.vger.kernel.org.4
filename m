Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3E6655A13
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 13:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiLXMNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 07:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiLXMNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 07:13:11 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C8C65EB
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 04:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nF52Ya7+E5CD0UatdNopBqSIoZ4RGMPTOI09/aeUJQc=;
  b=sL3PY4MWMwArg6lLTJNpcOt0TekU3oYapxuujffqPE+6XzE5uHhEUXCT
   sspePUNirICFlJ4TZfY0VrsWZuTOfJyjhlJFNXI5x4ojw/fpMasiIm1fO
   CV2RezWDS9FXn6rvl4chk2UG74tG+a3hAzePh80pXSpoc5BWTvbkoJniM
   I=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.96,271,1665439200"; 
   d="scan'208";a="84925534"
Received: from 214.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.214])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2022 13:13:04 +0100
Date:   Sat, 24 Dec 2022 13:13:04 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: drivers/crypto/qat/qat_common/qat_compression.c:238:24-25:
 WARNING opportunity for kfree_sensitive/kvfree_sensitive (memset at line
 237) (fwd)
In-Reply-To: <Y6blYUYKEXSYxMHs@gcabiddu-mobl1.ger.corp.intel.com>
Message-ID: <alpine.DEB.2.22.394.2212241310510.2711@hadrien>
References: <7c94c126-55b7-7275-a592-3aaf4e59969f@inria.fr> <Y6blYUYKEXSYxMHs@gcabiddu-mobl1.ger.corp.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Dec 2022, Giovanni Cabiddu wrote:

> Hi Julia,
>
> Based on this https://www.spinics.net/lists/linux-crypto/msg63956.html
> my understanding was that the optimization was applicable only to stack
> variables. Is that not the case?

OK, that makes sense.  Sorry for the noise.

julia

>
> Thanks,
>
> --
> Giovanni
>
> On Fri, Dec 23, 2022 at 09:37:19AM +0100, Julia Lawall wrote:
> > Hello,
> >
> > This is referring to the function qat_free_dc_data, where there is a
> > memset 0 of data immediately followed by a kfree.  The use of
> > kfree_sensitive will ensure taht the memset is not optimized away.
> >
> > julia
> >
> > ---------- Forwarded message ----------
> > Date: Wed, 21 Dec 2022 16:04:33 +0800
> > From: kernel test robot <lkp@intel.com>
> > To: oe-kbuild@lists.linux.dev
> > Cc: lkp@intel.com, Julia Lawall <julia.lawall@lip6.fr>
> > Subject: drivers/crypto/qat/qat_common/qat_compression.c:238:24-25: WARNING
> >     opportunity for kfree_sensitive/kvfree_sensitive (memset at line 237)
> >
> > BCC: lkp@intel.com
> > CC: oe-kbuild-all@lists.linux.dev
> > CC: linux-kernel@vger.kernel.org
> > TO: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> > CC: Herbert Xu <herbert@gondor.apana.org.au>
> > CC: Wojciech Ziemba <wojciech.ziemba@intel.com>
> > CC: Adam Guerin <adam.guerin@intel.com>
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
> > commit: 1198ae56c9a520384dcf53f01cd9adecd73751d0 crypto: qat - expose deflate through acomp api for QAT GEN2
> > date:   12 days ago
> > :::::: branch date: 17 hours ago
> > :::::: commit date: 12 days ago
> > config: loongarch-randconfig-c034-20221218
> > compiler: loongarch64-linux-gcc (GCC) 12.1.0
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> >
> > cocci warnings: (new ones prefixed by >>)
> > >> drivers/crypto/qat/qat_common/qat_compression.c:238:24-25: WARNING opportunity for kfree_sensitive/kvfree_sensitive (memset at line 237)
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
>
> > #
> > # Automatically generated file; DO NOT EDIT.
> > # Linux/loongarch 6.1.0-rc1 Kernel Configuration
> > #
> > CONFIG_CC_VERSION_TEXT="loongarch64-linux-gcc (GCC) 12.1.0"
> > CONFIG_CC_IS_GCC=y
> > CONFIG_GCC_VERSION=120100
> > CONFIG_CLANG_VERSION=0
> > CONFIG_AS_IS_GNU=y
> > CONFIG_AS_VERSION=23800
> > CONFIG_LD_IS_BFD=y
> > CONFIG_LD_VERSION=23800
> > CONFIG_LLD_VERSION=0
> > CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
> > CONFIG_CC_HAS_ASM_INLINE=y
> > CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
> > CONFIG_PAHOLE_VERSION=123
> > CONFIG_CONSTRUCTORS=y
> > CONFIG_IRQ_WORK=y
> > CONFIG_BUILDTIME_TABLE_SORT=y
> >
> > #
> > # General setup
> > #
> > CONFIG_INIT_ENV_ARG_LIMIT=32
> > CONFIG_COMPILE_TEST=y
> > # CONFIG_WERROR is not set
> > CONFIG_LOCALVERSION=""
> > CONFIG_BUILD_SALT=""
> > CONFIG_HAVE_KERNEL_GZIP=y
> > CONFIG_HAVE_KERNEL_LZMA=y
> > CONFIG_HAVE_KERNEL_XZ=y
> > CONFIG_HAVE_KERNEL_LZO=y
> > CONFIG_HAVE_KERNEL_LZ4=y
> > CONFIG_HAVE_KERNEL_ZSTD=y
> > # CONFIG_KERNEL_GZIP is not set
> > CONFIG_KERNEL_LZMA=y
> > # CONFIG_KERNEL_XZ is not set
> > # CONFIG_KERNEL_LZO is not set
> > # CONFIG_KERNEL_LZ4 is not set
> > # CONFIG_KERNEL_ZSTD is not set
> > CONFIG_DEFAULT_INIT=""
> > CONFIG_DEFAULT_HOSTNAME="(none)"
> > # CONFIG_SYSVIPC is not set
> > CONFIG_WATCH_QUEUE=y
> > CONFIG_CROSS_MEMORY_ATTACH=y
> > # CONFIG_USELIB is not set
> > CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> >
> > #
> > # IRQ subsystem
> > #
> > CONFIG_GENERIC_IRQ_PROBE=y
> > CONFIG_GENERIC_IRQ_SHOW=y
> > CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
> > CONFIG_GENERIC_IRQ_MIGRATION=y
> > CONFIG_GENERIC_IRQ_CHIP=y
> > CONFIG_IRQ_DOMAIN=y
> > CONFIG_IRQ_SIM=y
> > CONFIG_IRQ_DOMAIN_HIERARCHY=y
> > CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS=y
> > CONFIG_GENERIC_MSI_IRQ=y
> > CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
> > CONFIG_IRQ_FORCED_THREADING=y
> > CONFIG_SPARSE_IRQ=y
> > # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> > # end of IRQ subsystem
> >
> > CONFIG_GENERIC_IRQ_MULTI_HANDLER=y
> > CONFIG_GENERIC_TIME_VSYSCALL=y
> > CONFIG_GENERIC_CLOCKEVENTS=y
> > CONFIG_GENERIC_CMOS_UPDATE=y
> > CONFIG_TIME_KUNIT_TEST=y
> > CONFIG_CONTEXT_TRACKING=y
> > CONFIG_CONTEXT_TRACKING_IDLE=y
> >
> > #
> > # Timers subsystem
> > #
> > CONFIG_TICK_ONESHOT=y
> > CONFIG_NO_HZ_COMMON=y
> > # CONFIG_HZ_PERIODIC is not set
> > # CONFIG_NO_HZ_IDLE is not set
> > CONFIG_NO_HZ_FULL=y
> > CONFIG_CONTEXT_TRACKING_USER=y
> > CONFIG_CONTEXT_TRACKING_USER_FORCE=y
> > # CONFIG_NO_HZ is not set
> > # CONFIG_HIGH_RES_TIMERS is not set
> > # end of Timers subsystem
> >
> > CONFIG_HAVE_EBPF_JIT=y
> >
> > #
> > # BPF subsystem
> > #
> > # CONFIG_BPF_SYSCALL is not set
> > # end of BPF subsystem
> >
> > CONFIG_PREEMPT_BUILD=y
> > # CONFIG_PREEMPT_NONE is not set
> > # CONFIG_PREEMPT_VOLUNTARY is not set
> > CONFIG_PREEMPT=y
> > CONFIG_PREEMPT_COUNT=y
> > CONFIG_PREEMPTION=y
> >
> > #
> > # CPU/Task time and stats accounting
> > #
> > CONFIG_VIRT_CPU_ACCOUNTING=y
> > CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
> > CONFIG_IRQ_TIME_ACCOUNTING=y
> > CONFIG_HAVE_SCHED_AVG_IRQ=y
> > # CONFIG_PSI is not set
> > # end of CPU/Task time and stats accounting
> >
> > CONFIG_CPU_ISOLATION=y
> >
> > #
> > # RCU Subsystem
> > #
> > CONFIG_TREE_RCU=y
> > CONFIG_PREEMPT_RCU=y
> > # CONFIG_RCU_EXPERT is not set
> > CONFIG_SRCU=y
> > CONFIG_TREE_SRCU=y
> > CONFIG_RCU_STALL_COMMON=y
> > CONFIG_RCU_NEED_SEGCBLIST=y
> > CONFIG_RCU_NOCB_CPU=y
> > # CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
> > # end of RCU Subsystem
> >
> > # CONFIG_IKCONFIG is not set
> > CONFIG_IKHEADERS=y
> > CONFIG_LOG_BUF_SHIFT=17
> > CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> > CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> > # CONFIG_PRINTK_INDEX is not set
> > CONFIG_GENERIC_SCHED_CLOCK=y
> >
> > #
> > # Scheduler features
> > #
> > # end of Scheduler features
> >
> > CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
> > CONFIG_CC_HAS_INT128=y
> > CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
> > CONFIG_GCC12_NO_ARRAY_BOUNDS=y
> > CONFIG_CC_NO_ARRAY_BOUNDS=y
> > CONFIG_NUMA_BALANCING=y
> > # CONFIG_NUMA_BALANCING_DEFAULT_ENABLED is not set
> > # CONFIG_CGROUPS is not set
> > # CONFIG_SCHED_AUTOGROUP is not set
> > # CONFIG_SYSFS_DEPRECATED is not set
> > # CONFIG_RELAY is not set
> > CONFIG_BLK_DEV_INITRD=y
> > CONFIG_INITRAMFS_SOURCE=""
> > # CONFIG_INITRAMFS_FORCE is not set
> > CONFIG_RD_GZIP=y
> > # CONFIG_RD_BZIP2 is not set
> > # CONFIG_RD_LZMA is not set
> > CONFIG_RD_XZ=y
> > # CONFIG_RD_LZO is not set
> > CONFIG_RD_LZ4=y
> > CONFIG_RD_ZSTD=y
> > CONFIG_BOOT_CONFIG=y
> > # CONFIG_BOOT_CONFIG_EMBED is not set
> > CONFIG_INITRAMFS_PRESERVE_MTIME=y
> > CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> > # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> > CONFIG_LD_ORPHAN_WARN=y
> > CONFIG_SYSCTL_EXCEPTION_TRACE=y
> > CONFIG_EXPERT=y
> > # CONFIG_MULTIUSER is not set
> > # CONFIG_SGETMASK_SYSCALL is not set
> > CONFIG_SYSFS_SYSCALL=y
> > # CONFIG_FHANDLE is not set
> > CONFIG_POSIX_TIMERS=y
> > CONFIG_PRINTK=y
> > CONFIG_BUG=y
> > CONFIG_BASE_FULL=y
> > CONFIG_FUTEX=y
> > CONFIG_FUTEX_PI=y
> > CONFIG_EPOLL=y
> > # CONFIG_SIGNALFD is not set
> > CONFIG_TIMERFD=y
> > CONFIG_EVENTFD=y
> > CONFIG_SHMEM=y
> > # CONFIG_AIO is not set
> > CONFIG_IO_URING=y
> > CONFIG_ADVISE_SYSCALLS=y
> > CONFIG_MEMBARRIER=y
> > CONFIG_KALLSYMS=y
> > CONFIG_KALLSYMS_ALL=y
> > CONFIG_KALLSYMS_BASE_RELATIVE=y
> > CONFIG_KCMP=y
> > CONFIG_RSEQ=y
> > CONFIG_DEBUG_RSEQ=y
> > CONFIG_EMBEDDED=y
> > CONFIG_HAVE_PERF_EVENTS=y
> > CONFIG_PERF_USE_VMALLOC=y
> > # CONFIG_PC104 is not set
> >
> > #
> > # Kernel Performance Events And Counters
> > #
> > # CONFIG_PERF_EVENTS is not set
> > # end of Kernel Performance Events And Counters
> >
> > CONFIG_SYSTEM_DATA_VERIFICATION=y
> > # CONFIG_PROFILING is not set
> > # end of General setup
> >
> > CONFIG_LOONGARCH=y
> > CONFIG_64BIT=y
> > CONFIG_CPU_HAS_FPU=y
> > CONFIG_CPU_HAS_PREFETCH=y
> > CONFIG_GENERIC_BUG=y
> > CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
> > CONFIG_GENERIC_CALIBRATE_DELAY=y
> > CONFIG_GENERIC_CSUM=y
> > CONFIG_GENERIC_HWEIGHT=y
> > CONFIG_L1_CACHE_SHIFT=6
> > CONFIG_LOCKDEP_SUPPORT=y
> > CONFIG_STACKTRACE_SUPPORT=y
> > CONFIG_MACH_LOONGSON64=y
> > CONFIG_FIX_EARLYCON_MEM=y
> > CONFIG_PAGE_SIZE_64KB=y
> > CONFIG_PGTABLE_2LEVEL=y
> > CONFIG_PGTABLE_LEVELS=2
> > CONFIG_SCHED_OMIT_FRAME_POINTER=y
> >
> > #
> > # Kernel type and options
> > #
> > CONFIG_HZ_100=y
> > # CONFIG_HZ_250 is not set
> > # CONFIG_HZ_300 is not set
> > # CONFIG_HZ_1000 is not set
> > CONFIG_HZ=100
> > # CONFIG_4KB_3LEVEL is not set
> > # CONFIG_4KB_4LEVEL is not set
> > # CONFIG_16KB_2LEVEL is not set
> > # CONFIG_16KB_3LEVEL is not set
> > CONFIG_64KB_2LEVEL=y
> > # CONFIG_64KB_3LEVEL is not set
> > CONFIG_CMDLINE=""
> > # CONFIG_CMDLINE_BOOTLOADER is not set
> > # CONFIG_CMDLINE_EXTEND is not set
> > CONFIG_CMDLINE_FORCE=y
> > CONFIG_DMI=y
> > CONFIG_EFI=y
> > CONFIG_EFI_STUB=y
> > CONFIG_SMP=y
> > CONFIG_HOTPLUG_CPU=y
> > CONFIG_NR_CPUS=64
> > CONFIG_NUMA=y
> > CONFIG_NODES_SHIFT=6
> > CONFIG_ARCH_FORCE_MAX_ORDER=14
> > # CONFIG_ARCH_IOREMAP is not set
> > CONFIG_KEXEC=y
> > CONFIG_CRASH_DUMP=y
> > CONFIG_PHYSICAL_START=0x90000000a0000000
> > CONFIG_SECCOMP=y
> > # end of Kernel type and options
> >
> > CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> > CONFIG_ARCH_SPARSEMEM_ENABLE=y
> > CONFIG_ARCH_ENABLE_THP_MIGRATION=y
> > CONFIG_MMU=y
> > CONFIG_ARCH_MMAP_RND_BITS_MIN=12
> > CONFIG_ARCH_MMAP_RND_BITS_MAX=18
> >
> > #
> > # Power management options
> > #
> > CONFIG_ARCH_SUPPORTS_ACPI=y
> > CONFIG_ACPI=y
> > CONFIG_ACPI_GENERIC_GSI=y
> > CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> > CONFIG_ACPI_TABLE_LIB=y
> > CONFIG_ACPI_DEBUGGER=y
> > CONFIG_ACPI_DEBUGGER_USER=y
> > CONFIG_ACPI_SPCR_TABLE=y
> > # CONFIG_ACPI_EC_DEBUGFS is not set
> > # CONFIG_ACPI_AC is not set
> > CONFIG_ACPI_BATTERY=y
> > CONFIG_ACPI_BUTTON=y
> > CONFIG_ACPI_VIDEO=y
> > # CONFIG_ACPI_FAN is not set
> > # CONFIG_ACPI_DOCK is not set
> > CONFIG_ACPI_CPU_FREQ_PSS=y
> > CONFIG_ACPI_PROCESSOR_IDLE=y
> > CONFIG_ACPI_MCFG=y
> > CONFIG_ACPI_PROCESSOR=y
> > CONFIG_ACPI_HOTPLUG_CPU=y
> > CONFIG_ACPI_THERMAL=y
> > CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> > # CONFIG_ACPI_TABLE_UPGRADE is not set
> > CONFIG_ACPI_DEBUG=y
> > CONFIG_ACPI_PCI_SLOT=y
> > CONFIG_ACPI_CONTAINER=y
> > CONFIG_ACPI_HED=y
> > CONFIG_ACPI_CUSTOM_METHOD=y
> > # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> > CONFIG_ACPI_NUMA=y
> > CONFIG_ACPI_HMAT=y
> > CONFIG_ACPI_WATCHDOG=y
> > # CONFIG_ACPI_CONFIGFS is not set
> > CONFIG_ACPI_PFRUT=y
> > CONFIG_PMIC_OPREGION=y
> > # end of Power management options
> >
> > #
> > # Firmware Drivers
> > #
> >
> > #
> > # ARM System Control and Management Interface Protocol
> > #
> > # CONFIG_ARM_SCMI_PROTOCOL is not set
> > # end of ARM System Control and Management Interface Protocol
> >
> > # CONFIG_ARM_SCPI_PROTOCOL is not set
> > CONFIG_FIRMWARE_MEMMAP=y
> > CONFIG_DMIID=y
> > CONFIG_DMI_SYSFS=y
> > CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> > # CONFIG_SYSFB_SIMPLEFB is not set
> > # CONFIG_BCM47XX_NVRAM is not set
> > CONFIG_CS_DSP=y
> > # CONFIG_GOOGLE_FIRMWARE is not set
> >
> > #
> > # EFI (Extensible Firmware Interface) Support
> > #
> > CONFIG_EFI_ESRT=y
> > # CONFIG_EFI_VARS_PSTORE is not set
> > # CONFIG_EFI_SOFT_RESERVE is not set
> > CONFIG_EFI_RUNTIME_WRAPPERS=y
> > CONFIG_EFI_GENERIC_STUB=y
> > CONFIG_EFI_ZBOOT=y
> > # CONFIG_EFI_ZBOOT_SIGNING is not set
> > # CONFIG_EFI_BOOTLOADER_CONTROL is not set
> > # CONFIG_EFI_CAPSULE_LOADER is not set
> > # CONFIG_EFI_TEST is not set
> > # CONFIG_RESET_ATTACK_MITIGATION is not set
> > # CONFIG_EFI_RCI2_TABLE is not set
> > # CONFIG_EFI_DISABLE_PCI_DMA is not set
> > CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
> > # CONFIG_EFI_DISABLE_RUNTIME is not set
> > CONFIG_EFI_COCO_SECRET=y
> > # end of EFI (Extensible Firmware Interface) Support
> >
> > #
> > # Tegra firmware driver
> > #
> > # end of Tegra firmware driver
> > # end of Firmware Drivers
> >
> > #
> > # General architecture-dependent options
> > #
> > CONFIG_CRASH_CORE=y
> > CONFIG_KEXEC_CORE=y
> > CONFIG_GENERIC_ENTRY=y
> > CONFIG_HAVE_64BIT_ALIGNED_ACCESS=y
> > CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> > CONFIG_HAVE_IOREMAP_PROT=y
> > CONFIG_HAVE_NMI=y
> > CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> > CONFIG_HAVE_ARCH_TRACEHOOK=y
> > CONFIG_HAVE_DMA_CONTIGUOUS=y
> > CONFIG_GENERIC_SMP_IDLE_THREAD=y
> > CONFIG_ARCH_WANTS_NO_INSTR=y
> > CONFIG_HAVE_ASM_MODVERSIONS=y
> > CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> > CONFIG_HAVE_RSEQ=y
> > CONFIG_HAVE_PERF_REGS=y
> > CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> > CONFIG_MMU_GATHER_MERGE_VMAS=y
> > CONFIG_HAVE_ARCH_SECCOMP=y
> > CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> > CONFIG_LTO_NONE=y
> > CONFIG_HAVE_CONTEXT_TRACKING_USER=y
> > CONFIG_HAVE_TIF_NOHZ=y
> > CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> > CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> > CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> > CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> > CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
> > CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> > CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> > CONFIG_HAVE_EXIT_THREAD=y
> > CONFIG_ARCH_MMAP_RND_BITS=12
> > CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
> > CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT=y
> > # CONFIG_COMPAT_32BIT_TIME is not set
> > # CONFIG_LOCK_EVENT_COUNTS is not set
> > CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
> >
> > #
> > # GCOV-based kernel profiling
> > #
> > CONFIG_GCOV_KERNEL=y
> > # end of GCOV-based kernel profiling
> > # end of General architecture-dependent options
> >
> > CONFIG_RT_MUTEXES=y
> > CONFIG_BASE_SMALL=0
> > # CONFIG_MODULES is not set
> > CONFIG_BLOCK=y
> > # CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
> > CONFIG_BLK_DEV_BSG_COMMON=y
> > CONFIG_BLK_DEV_BSGLIB=y
> > CONFIG_BLK_DEV_INTEGRITY=y
> > CONFIG_BLK_DEV_INTEGRITY_T10=y
> > # CONFIG_BLK_DEV_ZONED is not set
> > CONFIG_BLK_WBT=y
> > # CONFIG_BLK_WBT_MQ is not set
> > # CONFIG_BLK_DEBUG_FS is not set
> > # CONFIG_BLK_SED_OPAL is not set
> > CONFIG_BLK_INLINE_ENCRYPTION=y
> > # CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK is not set
> >
> > #
> > # Partition Types
> > #
> > CONFIG_PARTITION_ADVANCED=y
> > # CONFIG_ACORN_PARTITION is not set
> > CONFIG_AIX_PARTITION=y
> > CONFIG_OSF_PARTITION=y
> > CONFIG_AMIGA_PARTITION=y
> > CONFIG_ATARI_PARTITION=y
> > CONFIG_MAC_PARTITION=y
> > # CONFIG_MSDOS_PARTITION is not set
> > # CONFIG_LDM_PARTITION is not set
> > # CONFIG_SGI_PARTITION is not set
> > CONFIG_ULTRIX_PARTITION=y
> > CONFIG_SUN_PARTITION=y
> > # CONFIG_KARMA_PARTITION is not set
> > CONFIG_EFI_PARTITION=y
> > CONFIG_SYSV68_PARTITION=y
> > CONFIG_CMDLINE_PARTITION=y
> > # end of Partition Types
> >
> > CONFIG_BLK_MQ_PCI=y
> > CONFIG_BLK_MQ_VIRTIO=y
> > CONFIG_BLOCK_HOLDER_DEPRECATED=y
> > CONFIG_BLK_MQ_STACKING=y
> >
> > #
> > # IO Schedulers
> > #
> > CONFIG_MQ_IOSCHED_DEADLINE=y
> > # CONFIG_MQ_IOSCHED_KYBER is not set
> > # CONFIG_IOSCHED_BFQ is not set
> > # end of IO Schedulers
> >
> > CONFIG_ASN1=y
> > CONFIG_UNINLINE_SPIN_UNLOCK=y
> > CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> > CONFIG_MUTEX_SPIN_ON_OWNER=y
> > CONFIG_RWSEM_SPIN_ON_OWNER=y
> > CONFIG_LOCK_SPIN_ON_OWNER=y
> > CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> > CONFIG_QUEUED_SPINLOCKS=y
> > CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> > CONFIG_QUEUED_RWLOCKS=y
> >
> > #
> > # Executable file formats
> > #
> > # CONFIG_BINFMT_ELF is not set
> > CONFIG_ARCH_BINFMT_ELF_STATE=y
> > CONFIG_BINFMT_SCRIPT=y
> > CONFIG_BINFMT_MISC=y
> > # CONFIG_COREDUMP is not set
> > # end of Executable file formats
> >
> > #
> > # Memory Management options
> > #
> > CONFIG_ZPOOL=y
> > CONFIG_SWAP=y
> > CONFIG_ZSWAP=y
> > # CONFIG_ZSWAP_DEFAULT_ON is not set
> > CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE=y
> > # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO is not set
> > # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
> > # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
> > # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
> > # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
> > CONFIG_ZSWAP_COMPRESSOR_DEFAULT="deflate"
> > CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
> > # CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
> > # CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
> > CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
> > CONFIG_ZBUD=y
> > CONFIG_Z3FOLD=y
> > CONFIG_ZSMALLOC=y
> > # CONFIG_ZSMALLOC_STAT is not set
> >
> > #
> > # SLAB allocator options
> > #
> > # CONFIG_SLAB is not set
> > CONFIG_SLUB=y
> > # CONFIG_SLOB is not set
> > CONFIG_SLAB_MERGE_DEFAULT=y
> > # CONFIG_SLAB_FREELIST_RANDOM is not set
> > # CONFIG_SLAB_FREELIST_HARDENED is not set
> > # CONFIG_SLUB_STATS is not set
> > CONFIG_SLUB_CPU_PARTIAL=y
> > # end of SLAB allocator options
> >
> > CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
> > # CONFIG_COMPAT_BRK is not set
> > CONFIG_SELECT_MEMORY_MODEL=y
> > CONFIG_SPARSEMEM_MANUAL=y
> > CONFIG_SPARSEMEM=y
> > CONFIG_SPARSEMEM_EXTREME=y
> > CONFIG_HAVE_FAST_GUP=y
> > CONFIG_ARCH_KEEP_MEMBLOCK=y
> > CONFIG_MEMORY_ISOLATION=y
> > CONFIG_EXCLUSIVE_SYSTEM_RAM=y
> > CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> > CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
> > # CONFIG_MEMORY_HOTPLUG is not set
> > CONFIG_SPLIT_PTLOCK_CPUS=4
> > CONFIG_MEMORY_BALLOON=y
> > # CONFIG_BALLOON_COMPACTION is not set
> > CONFIG_COMPACTION=y
> > CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
> > CONFIG_PAGE_REPORTING=y
> > CONFIG_MIGRATION=y
> > CONFIG_CONTIG_ALLOC=y
> > CONFIG_PHYS_ADDR_T_64BIT=y
> > CONFIG_MMU_NOTIFIER=y
> > CONFIG_KSM=y
> > CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> > CONFIG_TRANSPARENT_HUGEPAGE=y
> > CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
> > # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
> > # CONFIG_READ_ONLY_THP_FOR_FS is not set
> > CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> > CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> > CONFIG_USE_PERCPU_NUMA_NODE_ID=y
> > CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> > CONFIG_FRONTSWAP=y
> > CONFIG_CMA=y
> > CONFIG_CMA_DEBUG=y
> > CONFIG_CMA_DEBUGFS=y
> > CONFIG_CMA_SYSFS=y
> > CONFIG_CMA_AREAS=19
> > # CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
> > # CONFIG_IDLE_PAGE_TRACKING is not set
> > CONFIG_ZONE_DMA32=y
> > CONFIG_HMM_MIRROR=y
> > CONFIG_GET_FREE_REGION=y
> > # CONFIG_VM_EVENT_COUNTERS is not set
> > # CONFIG_PERCPU_STATS is not set
> > CONFIG_GUP_TEST=y
> > CONFIG_ARCH_HAS_PTE_SPECIAL=y
> > # CONFIG_USERFAULTFD is not set
> > # CONFIG_LRU_GEN is not set
> >
> > #
> > # Data Access Monitoring
> > #
> > # CONFIG_DAMON is not set
> > # end of Data Access Monitoring
> > # end of Memory Management options
> >
> > # CONFIG_NET is not set
> >
> > #
> > # Device Drivers
> > #
> > CONFIG_HAVE_PCI=y
> > CONFIG_PCI=y
> > CONFIG_PCI_DOMAINS=y
> > CONFIG_PCI_DOMAINS_GENERIC=y
> > # CONFIG_PCIEPORTBUS is not set
> > # CONFIG_PCIEASPM is not set
> > # CONFIG_PCIE_PTM is not set
> > CONFIG_PCI_MSI=y
> > CONFIG_PCI_MSI_IRQ_DOMAIN=y
> > CONFIG_PCI_MSI_ARCH_FALLBACKS=y
> > CONFIG_PCI_QUIRKS=y
> > CONFIG_PCI_DEBUG=y
> > CONFIG_PCI_REALLOC_ENABLE_AUTO=y
> > CONFIG_PCI_STUB=y
> > CONFIG_PCI_PF_STUB=y
> > CONFIG_PCI_ATS=y
> > CONFIG_PCI_DOE=y
> > CONFIG_PCI_ECAM=y
> > CONFIG_PCI_IOV=y
> > # CONFIG_PCI_PRI is not set
> > # CONFIG_PCI_PASID is not set
> > CONFIG_PCI_LABEL=y
> > # CONFIG_PCIE_BUS_TUNE_OFF is not set
> > # CONFIG_PCIE_BUS_DEFAULT is not set
> > # CONFIG_PCIE_BUS_SAFE is not set
> > CONFIG_PCIE_BUS_PERFORMANCE=y
> > # CONFIG_PCIE_BUS_PEER2PEER is not set
> > CONFIG_VGA_ARB=y
> > CONFIG_VGA_ARB_MAX_GPUS=16
> > # CONFIG_HOTPLUG_PCI is not set
> >
> > #
> > # PCI controller drivers
> > #
> > # CONFIG_PCIE_XILINX_NWL is not set
> > # CONFIG_PCI_TEGRA is not set
> > # CONFIG_PCIE_RCAR_HOST is not set
> > # CONFIG_PCIE_RCAR_EP is not set
> > # CONFIG_PCIE_XILINX is not set
> > # CONFIG_PCIE_XILINX_CPM is not set
> > # CONFIG_PCI_XGENE is not set
> > # CONFIG_PCI_VERSATILE is not set
> > # CONFIG_PCIE_ALTERA is not set
> > # CONFIG_PCI_HOST_THUNDER_PEM is not set
> > # CONFIG_PCI_HOST_THUNDER_ECAM is not set
> > # CONFIG_PCIE_MEDIATEK_GEN3 is not set
> > CONFIG_PCI_LOONGSON=y
> > # CONFIG_PCIE_MT7621 is not set
> >
> > #
> > # DesignWare PCI Core Support
> > #
> > CONFIG_PCIE_DW=y
> > CONFIG_PCIE_DW_HOST=y
> > CONFIG_PCIE_DW_EP=y
> > CONFIG_PCIE_DW_PLAT=y
> > CONFIG_PCIE_DW_PLAT_HOST=y
> > CONFIG_PCIE_DW_PLAT_EP=y
> > # CONFIG_PCI_EXYNOS is not set
> > # CONFIG_PCI_IMX6 is not set
> > # CONFIG_PCIE_SPEAR13XX is not set
> > # CONFIG_PCI_KEYSTONE_HOST is not set
> > # CONFIG_PCI_KEYSTONE_EP is not set
> > # CONFIG_PCIE_ARMADA_8K is not set
> > # CONFIG_PCIE_ARTPEC6_HOST is not set
> > # CONFIG_PCIE_ARTPEC6_EP is not set
> > # CONFIG_PCIE_KEEMBAY_HOST is not set
> > # CONFIG_PCIE_KEEMBAY_EP is not set
> > # CONFIG_PCIE_HISI_STB is not set
> > CONFIG_PCI_MESON=y
> > # CONFIG_PCIE_TEGRA194_HOST is not set
> > # CONFIG_PCIE_TEGRA194_EP is not set
> > # CONFIG_PCIE_VISCONTI_HOST is not set
> > # CONFIG_PCIE_FU740 is not set
> > # end of DesignWare PCI Core Support
> >
> > #
> > # Mobiveil PCIe Core Support
> > #
> > # CONFIG_PCIE_LAYERSCAPE_GEN4 is not set
> > # end of Mobiveil PCIe Core Support
> >
> > #
> > # Cadence PCIe controllers support
> > #
> > # end of Cadence PCIe controllers support
> > # end of PCI controller drivers
> >
> > #
> > # PCI Endpoint
> > #
> > CONFIG_PCI_ENDPOINT=y
> > # CONFIG_PCI_ENDPOINT_CONFIGFS is not set
> > CONFIG_PCI_EPF_TEST=y
> > # CONFIG_PCI_EPF_NTB is not set
> > # end of PCI Endpoint
> >
> > #
> > # PCI switch controller drivers
> > #
> > CONFIG_PCI_SW_SWITCHTEC=y
> > # end of PCI switch controller drivers
> >
> > CONFIG_CXL_BUS=y
> > CONFIG_CXL_PCI=y
> > CONFIG_CXL_MEM_RAW_COMMANDS=y
> > CONFIG_CXL_ACPI=y
> > CONFIG_CXL_PMEM=y
> > CONFIG_CXL_MEM=y
> > CONFIG_CXL_PORT=y
> > CONFIG_CXL_REGION=y
> > # CONFIG_PCCARD is not set
> > CONFIG_RAPIDIO=y
> > CONFIG_RAPIDIO_DISC_TIMEOUT=30
> > # CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
> > # CONFIG_RAPIDIO_DMA_ENGINE is not set
> > CONFIG_RAPIDIO_DEBUG=y
> > CONFIG_RAPIDIO_ENUM_BASIC=y
> > CONFIG_RAPIDIO_CHMAN=y
> > CONFIG_RAPIDIO_MPORT_CDEV=y
> >
> > #
> > # RapidIO Switch drivers
> > #
> > # CONFIG_RAPIDIO_CPS_XX is not set
> > CONFIG_RAPIDIO_CPS_GEN2=y
> > # CONFIG_RAPIDIO_RXS_GEN3 is not set
> > # end of RapidIO Switch drivers
> >
> > #
> > # Generic Driver Options
> > #
> > CONFIG_AUXILIARY_BUS=y
> > CONFIG_UEVENT_HELPER=y
> > CONFIG_UEVENT_HELPER_PATH=""
> > CONFIG_DEVTMPFS=y
> > # CONFIG_DEVTMPFS_MOUNT is not set
> > CONFIG_DEVTMPFS_SAFE=y
> > CONFIG_STANDALONE=y
> > # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> >
> > #
> > # Firmware loader
> > #
> > CONFIG_FW_LOADER=y
> > CONFIG_FW_LOADER_PAGED_BUF=y
> > CONFIG_FW_LOADER_SYSFS=y
> > CONFIG_EXTRA_FIRMWARE=""
> > CONFIG_FW_LOADER_USER_HELPER=y
> > # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> > # CONFIG_FW_LOADER_COMPRESS is not set
> > # CONFIG_FW_UPLOAD is not set
> > # end of Firmware loader
> >
> > CONFIG_WANT_DEV_COREDUMP=y
> > # CONFIG_ALLOW_DEV_COREDUMP is not set
> > # CONFIG_DEBUG_DRIVER is not set
> > CONFIG_DEBUG_DEVRES=y
> > # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> > CONFIG_PM_QOS_KUNIT_TEST=y
> > CONFIG_HMEM_REPORTING=y
> > CONFIG_DRIVER_PE_KUNIT_TEST=y
> > CONFIG_GENERIC_CPU_AUTOPROBE=y
> > CONFIG_REGMAP=y
> > CONFIG_REGMAP_I2C=y
> > CONFIG_REGMAP_SLIMBUS=y
> > CONFIG_REGMAP_MMIO=y
> > CONFIG_REGMAP_IRQ=y
> > CONFIG_REGMAP_SOUNDWIRE=y
> > CONFIG_REGMAP_SOUNDWIRE_MBQ=y
> > CONFIG_REGMAP_SCCB=y
> > CONFIG_DMA_SHARED_BUFFER=y
> > CONFIG_DMA_FENCE_TRACE=y
> > # end of Generic Driver Options
> >
> > #
> > # Bus devices
> > #
> > # CONFIG_ARM_INTEGRATOR_LM is not set
> > # CONFIG_BT1_APB is not set
> > # CONFIG_BT1_AXI is not set
> > # CONFIG_HISILICON_LPC is not set
> > # CONFIG_INTEL_IXP4XX_EB is not set
> > # CONFIG_QCOM_EBI2 is not set
> > CONFIG_MHI_BUS=y
> > CONFIG_MHI_BUS_DEBUG=y
> > CONFIG_MHI_BUS_PCI_GENERIC=y
> > CONFIG_MHI_BUS_EP=y
> > # end of Bus devices
> >
> > #
> > # Firmware Drivers
> > #
> >
> > #
> > # ARM System Control and Management Interface Protocol
> > #
> > # end of ARM System Control and Management Interface Protocol
> >
> > #
> > # EFI (Extensible Firmware Interface) Support
> > #
> > # end of EFI (Extensible Firmware Interface) Support
> >
> > #
> > # Tegra firmware driver
> > #
> > # end of Tegra firmware driver
> > # end of Firmware Drivers
> >
> > CONFIG_GNSS=y
> > CONFIG_GNSS_USB=y
> > CONFIG_MTD=y
> >
> > #
> > # Partition parsers
> > #
> > CONFIG_MTD_AR7_PARTS=y
> > # CONFIG_MTD_BCM63XX_PARTS is not set
> > # CONFIG_MTD_BRCM_U_BOOT is not set
> > CONFIG_MTD_CMDLINE_PARTS=y
> > # CONFIG_MTD_PARSER_IMAGETAG is not set
> > # CONFIG_MTD_PARSER_TRX is not set
> > # CONFIG_MTD_SHARPSL_PARTS is not set
> > CONFIG_MTD_REDBOOT_PARTS=y
> > CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
> > CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
> > CONFIG_MTD_REDBOOT_PARTS_READONLY=y
> > # end of Partition parsers
> >
> > #
> > # User Modules And Translation Layers
> > #
> > CONFIG_MTD_BLKDEVS=y
> > CONFIG_MTD_BLOCK=y
> >
> > #
> > # Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
> > #
> > # CONFIG_FTL is not set
> > CONFIG_NFTL=y
> > # CONFIG_NFTL_RW is not set
> > # CONFIG_INFTL is not set
> > CONFIG_RFD_FTL=y
> > CONFIG_SSFDC=y
> > CONFIG_SM_FTL=y
> > # CONFIG_MTD_OOPS is not set
> > CONFIG_MTD_PSTORE=y
> > # CONFIG_MTD_SWAP is not set
> > # CONFIG_MTD_PARTITIONED_MASTER is not set
> >
> > #
> > # RAM/ROM/Flash chip drivers
> > #
> > CONFIG_MTD_CFI=y
> > CONFIG_MTD_JEDECPROBE=y
> > CONFIG_MTD_GEN_PROBE=y
> > CONFIG_MTD_CFI_ADV_OPTIONS=y
> > # CONFIG_MTD_CFI_NOSWAP is not set
> > # CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
> > CONFIG_MTD_CFI_LE_BYTE_SWAP=y
> > CONFIG_MTD_CFI_GEOMETRY=y
> > CONFIG_MTD_MAP_BANK_WIDTH_1=y
> > CONFIG_MTD_MAP_BANK_WIDTH_2=y
> > CONFIG_MTD_MAP_BANK_WIDTH_4=y
> > CONFIG_MTD_MAP_BANK_WIDTH_8=y
> > # CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
> > # CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
> > CONFIG_MTD_CFI_I1=y
> > # CONFIG_MTD_CFI_I2 is not set
> > # CONFIG_MTD_CFI_I4 is not set
> > CONFIG_MTD_CFI_I8=y
> > # CONFIG_MTD_OTP is not set
> > # CONFIG_MTD_CFI_INTELEXT is not set
> > CONFIG_MTD_CFI_AMDSTD=y
> > CONFIG_MTD_CFI_STAA=y
> > CONFIG_MTD_CFI_UTIL=y
> > CONFIG_MTD_RAM=y
> > CONFIG_MTD_ROM=y
> > CONFIG_MTD_ABSENT=y
> > # end of RAM/ROM/Flash chip drivers
> >
> > #
> > # Mapping drivers for chip access
> > #
> > CONFIG_MTD_COMPLEX_MAPPINGS=y
> > # CONFIG_MTD_PHYSMAP is not set
> > # CONFIG_MTD_SC520CDP is not set
> > # CONFIG_MTD_NETSC520 is not set
> > # CONFIG_MTD_TS5500 is not set
> > CONFIG_MTD_PCI=y
> > # CONFIG_MTD_INTEL_VR_NOR is not set
> > # CONFIG_MTD_PLATRAM is not set
> > # end of Mapping drivers for chip access
> >
> > #
> > # Self-contained MTD device drivers
> > #
> > # CONFIG_MTD_PMC551 is not set
> > CONFIG_MTD_SPEAR_SMI=y
> > # CONFIG_MTD_SLRAM is not set
> > CONFIG_MTD_PHRAM=y
> > CONFIG_MTD_MTDRAM=y
> > CONFIG_MTDRAM_TOTAL_SIZE=4096
> > CONFIG_MTDRAM_ERASE_SIZE=128
> > CONFIG_MTD_BLOCK2MTD=y
> >
> > #
> > # Disk-On-Chip Device Drivers
> > #
> > CONFIG_MTD_DOCG3=y
> > CONFIG_BCH_CONST_M=14
> > CONFIG_BCH_CONST_T=4
> > # end of Self-contained MTD device drivers
> >
> > #
> > # NAND
> > #
> > CONFIG_MTD_NAND_CORE=y
> > CONFIG_MTD_ONENAND=y
> > CONFIG_MTD_ONENAND_VERIFY_WRITE=y
> > CONFIG_MTD_ONENAND_GENERIC=y
> > # CONFIG_MTD_ONENAND_SAMSUNG is not set
> > # CONFIG_MTD_ONENAND_OTP is not set
> > CONFIG_MTD_ONENAND_2X_PROGRAM=y
> > CONFIG_MTD_RAW_NAND=y
> >
> > #
> > # Raw/parallel NAND flash controllers
> > #
> > # CONFIG_MTD_NAND_DENALI_PCI is not set
> > CONFIG_MTD_NAND_AMS_DELTA=y
> > # CONFIG_MTD_NAND_SHARPSL is not set
> > CONFIG_MTD_NAND_CAFE=y
> > # CONFIG_MTD_NAND_ATMEL is not set
> > # CONFIG_MTD_NAND_MARVELL is not set
> > # CONFIG_MTD_NAND_SLC_LPC32XX is not set
> > # CONFIG_MTD_NAND_MLC_LPC32XX is not set
> > # CONFIG_MTD_NAND_BRCMNAND is not set
> > # CONFIG_MTD_NAND_OXNAS is not set
> > # CONFIG_MTD_NAND_FSL_IFC is not set
> > # CONFIG_MTD_NAND_VF610_NFC is not set
> > # CONFIG_MTD_NAND_SH_FLCTL is not set
> > # CONFIG_MTD_NAND_DAVINCI is not set
> > # CONFIG_MTD_NAND_TXX9NDFMC is not set
> > # CONFIG_MTD_NAND_SUNXI is not set
> > # CONFIG_MTD_NAND_HISI504 is not set
> > # CONFIG_MTD_NAND_QCOM is not set
> > CONFIG_MTD_NAND_MXIC=y
> > # CONFIG_MTD_NAND_TEGRA is not set
> > # CONFIG_MTD_NAND_STM32_FMC2 is not set
> > # CONFIG_MTD_NAND_MESON is not set
> > # CONFIG_MTD_NAND_GPIO is not set
> > # CONFIG_MTD_NAND_PLATFORM is not set
> > # CONFIG_MTD_NAND_CADENCE is not set
> > CONFIG_MTD_NAND_ARASAN=y
> > # CONFIG_MTD_NAND_INTEL_LGM is not set
> > # CONFIG_MTD_NAND_RENESAS is not set
> >
> > #
> > # Misc
> > #
> > CONFIG_MTD_SM_COMMON=y
> > CONFIG_MTD_NAND_NANDSIM=y
> > CONFIG_MTD_NAND_RICOH=y
> > # CONFIG_MTD_NAND_DISKONCHIP is not set
> >
> > #
> > # ECC engine support
> > #
> > CONFIG_MTD_NAND_ECC=y
> > CONFIG_MTD_NAND_ECC_SW_HAMMING=y
> > # CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
> > CONFIG_MTD_NAND_ECC_SW_BCH=y
> > CONFIG_MTD_NAND_ECC_MXIC=y
> > # CONFIG_MTD_NAND_ECC_MEDIATEK is not set
> > # end of ECC engine support
> > # end of NAND
> >
> > #
> > # LPDDR & LPDDR2 PCM memory drivers
> > #
> > # CONFIG_MTD_LPDDR is not set
> > # end of LPDDR & LPDDR2 PCM memory drivers
> >
> > CONFIG_MTD_UBI=y
> > CONFIG_MTD_UBI_WL_THRESHOLD=4096
> > CONFIG_MTD_UBI_BEB_LIMIT=20
> > CONFIG_MTD_UBI_FASTMAP=y
> > CONFIG_MTD_UBI_GLUEBI=y
> > # CONFIG_MTD_UBI_BLOCK is not set
> > CONFIG_MTD_HYPERBUS=y
> > # CONFIG_HBMC_AM654 is not set
> > # CONFIG_OF is not set
> > CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> > CONFIG_PARPORT=y
> > CONFIG_PARPORT_PC=y
> > # CONFIG_PARPORT_PC_FIFO is not set
> > CONFIG_PARPORT_PC_SUPERIO=y
> > CONFIG_PARPORT_AX88796=y
> > CONFIG_PARPORT_1284=y
> > CONFIG_PARPORT_NOT_PC=y
> > CONFIG_PNP=y
> > CONFIG_PNP_DEBUG_MESSAGES=y
> >
> > #
> > # Protocols
> > #
> > # CONFIG_ISAPNP is not set
> > CONFIG_PNPACPI=y
> > CONFIG_BLK_DEV=y
> > # CONFIG_BLK_DEV_NULL_BLK is not set
> > CONFIG_CDROM=y
> > CONFIG_PARIDE=y
> >
> > #
> > # Parallel IDE high-level drivers
> > #
> > CONFIG_PARIDE_PD=y
> > CONFIG_PARIDE_PCD=y
> > # CONFIG_PARIDE_PF is not set
> > # CONFIG_PARIDE_PT is not set
> > CONFIG_PARIDE_PG=y
> >
> > #
> > # Parallel IDE protocol modules
> > #
> > CONFIG_PARIDE_ATEN=y
> > CONFIG_PARIDE_BPCK=y
> > CONFIG_PARIDE_COMM=y
> > CONFIG_PARIDE_DSTR=y
> > # CONFIG_PARIDE_FIT2 is not set
> > CONFIG_PARIDE_FIT3=y
> > # CONFIG_PARIDE_EPAT is not set
> > CONFIG_PARIDE_EPIA=y
> > # CONFIG_PARIDE_FRIQ is not set
> > # CONFIG_PARIDE_FRPW is not set
> > CONFIG_PARIDE_KBIC=y
> > CONFIG_PARIDE_KTTI=y
> > # CONFIG_PARIDE_ON20 is not set
> > CONFIG_PARIDE_ON26=y
> > CONFIG_BLK_DEV_PCIESSD_MTIP32XX=y
> > CONFIG_ZRAM=y
> > # CONFIG_ZRAM_DEF_COMP_LZORLE is not set
> > # CONFIG_ZRAM_DEF_COMP_ZSTD is not set
> > # CONFIG_ZRAM_DEF_COMP_LZO is not set
> > # CONFIG_ZRAM_DEF_COMP_LZ4HC is not set
> > CONFIG_ZRAM_DEF_COMP_842=y
> > CONFIG_ZRAM_DEF_COMP="842"
> > # CONFIG_ZRAM_WRITEBACK is not set
> > # CONFIG_ZRAM_MEMORY_TRACKING is not set
> > # CONFIG_BLK_DEV_LOOP is not set
> >
> > #
> > # DRBD disabled because PROC_FS or INET not selected
> > #
> > # CONFIG_BLK_DEV_RAM is not set
> > # CONFIG_CDROM_PKTCDVD is not set
> > CONFIG_VIRTIO_BLK=y
> > CONFIG_BLK_DEV_UBLK=y
> >
> > #
> > # NVME Support
> > #
> > CONFIG_NVME_COMMON=y
> > CONFIG_NVME_CORE=y
> > CONFIG_BLK_DEV_NVME=y
> > CONFIG_NVME_MULTIPATH=y
> > # CONFIG_NVME_VERBOSE_ERRORS is not set
> > CONFIG_NVME_HWMON=y
> > CONFIG_NVME_FABRICS=y
> > CONFIG_NVME_FC=y
> > CONFIG_NVME_AUTH=y
> > CONFIG_NVME_TARGET=y
> > CONFIG_NVME_TARGET_PASSTHRU=y
> > CONFIG_NVME_TARGET_LOOP=y
> > CONFIG_NVME_TARGET_FC=y
> > # CONFIG_NVME_TARGET_FCLOOP is not set
> > CONFIG_NVME_TARGET_AUTH=y
> > # end of NVME Support
> >
> > #
> > # Misc devices
> > #
> > CONFIG_AD525X_DPOT=y
> > CONFIG_AD525X_DPOT_I2C=y
> > CONFIG_DUMMY_IRQ=y
> > CONFIG_PHANTOM=y
> > CONFIG_TIFM_CORE=y
> > CONFIG_TIFM_7XX1=y
> > # CONFIG_ICS932S401 is not set
> > # CONFIG_ATMEL_SSC is not set
> > # CONFIG_ENCLOSURE_SERVICES is not set
> > CONFIG_HP_ILO=y
> > # CONFIG_QCOM_COINCELL is not set
> > # CONFIG_QCOM_FASTRPC is not set
> > # CONFIG_APDS9802ALS is not set
> > # CONFIG_ISL29003 is not set
> > # CONFIG_ISL29020 is not set
> > # CONFIG_SENSORS_TSL2550 is not set
> > CONFIG_SENSORS_BH1770=y
> > CONFIG_SENSORS_APDS990X=y
> > CONFIG_HMC6352=y
> > # CONFIG_DS1682 is not set
> > # CONFIG_PCH_PHUB is not set
> > CONFIG_SRAM=y
> > CONFIG_DW_XDATA_PCIE=y
> > CONFIG_PCI_ENDPOINT_TEST=y
> > CONFIG_XILINX_SDFEC=y
> > CONFIG_MISC_RTSX=y
> > # CONFIG_HISI_HIKEY_USB is not set
> > CONFIG_C2PORT=y
> >
> > #
> > # EEPROM support
> > #
> > CONFIG_EEPROM_AT24=y
> > CONFIG_EEPROM_LEGACY=y
> > CONFIG_EEPROM_MAX6875=y
> > # CONFIG_EEPROM_93CX6 is not set
> > # CONFIG_EEPROM_IDT_89HPESX is not set
> > CONFIG_EEPROM_EE1004=y
> > # end of EEPROM support
> >
> > CONFIG_CB710_CORE=y
> > CONFIG_CB710_DEBUG=y
> > CONFIG_CB710_DEBUG_ASSUMPTIONS=y
> >
> > #
> > # Texas Instruments shared transport line discipline
> > #
> > # end of Texas Instruments shared transport line discipline
> >
> > # CONFIG_SENSORS_LIS3_I2C is not set
> > CONFIG_ALTERA_STAPL=y
> > # CONFIG_GENWQE is not set
> > # CONFIG_ECHO is not set
> > CONFIG_BCM_VK=y
> > # CONFIG_MISC_ALCOR_PCI is not set
> > CONFIG_MISC_RTSX_PCI=y
> > CONFIG_MISC_RTSX_USB=y
> > # CONFIG_HABANA_AI is not set
> > # CONFIG_UACCE is not set
> > CONFIG_PVPANIC=y
> > CONFIG_PVPANIC_MMIO=y
> > CONFIG_PVPANIC_PCI=y
> > # CONFIG_GP_PCI1XXXX is not set
> > # end of Misc devices
> >
> > #
> > # SCSI device support
> > #
> > CONFIG_SCSI_MOD=y
> > CONFIG_RAID_ATTRS=y
> > CONFIG_SCSI_COMMON=y
> > CONFIG_SCSI=y
> > CONFIG_SCSI_DMA=y
> >
> > #
> > # SCSI support type (disk, tape, CD-ROM)
> > #
> > CONFIG_BLK_DEV_SD=y
> > CONFIG_CHR_DEV_ST=y
> > CONFIG_BLK_DEV_SR=y
> > CONFIG_CHR_DEV_SG=y
> > CONFIG_BLK_DEV_BSG=y
> > CONFIG_CHR_DEV_SCH=y
> > # CONFIG_SCSI_CONSTANTS is not set
> > # CONFIG_SCSI_LOGGING is not set
> > CONFIG_SCSI_SCAN_ASYNC=y
> >
> > #
> > # SCSI Transports
> > #
> > CONFIG_SCSI_SPI_ATTRS=y
> > CONFIG_SCSI_SAS_ATTRS=y
> > CONFIG_SCSI_SAS_LIBSAS=y
> > CONFIG_SCSI_SAS_ATA=y
> > CONFIG_SCSI_SAS_HOST_SMP=y
> > CONFIG_SCSI_SRP_ATTRS=y
> > # end of SCSI Transports
> >
> > # CONFIG_SCSI_LOWLEVEL is not set
> > # CONFIG_SCSI_DH is not set
> > # end of SCSI device support
> >
> > CONFIG_ATA=y
> > CONFIG_SATA_HOST=y
> > CONFIG_PATA_TIMINGS=y
> > # CONFIG_ATA_VERBOSE_ERROR is not set
> > # CONFIG_ATA_FORCE is not set
> > # CONFIG_ATA_ACPI is not set
> > CONFIG_SATA_PMP=y
> >
> > #
> > # Controllers with non-SFF native interface
> > #
> > CONFIG_SATA_AHCI=y
> > CONFIG_SATA_MOBILE_LPM_POLICY=0
> > CONFIG_SATA_AHCI_PLATFORM=y
> > # CONFIG_AHCI_BRCM is not set
> > # CONFIG_AHCI_DA850 is not set
> > # CONFIG_AHCI_DM816 is not set
> > CONFIG_AHCI_DWC=y
> > # CONFIG_AHCI_ST is not set
> > # CONFIG_AHCI_IMX is not set
> > # CONFIG_AHCI_MTK is not set
> > # CONFIG_AHCI_MVEBU is not set
> > # CONFIG_AHCI_SUNXI is not set
> > # CONFIG_AHCI_TEGRA is not set
> > # CONFIG_AHCI_XGENE is not set
> > # CONFIG_SATA_FSL is not set
> > # CONFIG_SATA_AHCI_SEATTLE is not set
> > CONFIG_SATA_INIC162X=y
> > CONFIG_SATA_ACARD_AHCI=y
> > CONFIG_SATA_SIL24=y
> > CONFIG_ATA_SFF=y
> >
> > #
> > # SFF controllers with custom DMA interface
> > #
> > # CONFIG_PDC_ADMA is not set
> > CONFIG_SATA_QSTOR=y
> > CONFIG_SATA_SX4=y
> > CONFIG_ATA_BMDMA=y
> >
> > #
> > # SATA SFF controllers with BMDMA
> > #
> > CONFIG_ATA_PIIX=y
> > CONFIG_SATA_DWC=y
> > CONFIG_SATA_DWC_OLD_DMA=y
> > # CONFIG_SATA_HIGHBANK is not set
> > CONFIG_SATA_MV=y
> > CONFIG_SATA_NV=y
> > # CONFIG_SATA_PROMISE is not set
> > # CONFIG_SATA_RCAR is not set
> > CONFIG_SATA_SIL=y
> > CONFIG_SATA_SIS=y
> > CONFIG_SATA_SVW=y
> > CONFIG_SATA_ULI=y
> > # CONFIG_SATA_VIA is not set
> > # CONFIG_SATA_VITESSE is not set
> >
> > #
> > # PATA SFF controllers with BMDMA
> > #
> > CONFIG_PATA_ALI=y
> > # CONFIG_PATA_AMD is not set
> > # CONFIG_PATA_ARASAN_CF is not set
> > CONFIG_PATA_ARTOP=y
> > # CONFIG_PATA_ATIIXP is not set
> > # CONFIG_PATA_ATP867X is not set
> > # CONFIG_PATA_BK3710 is not set
> > CONFIG_PATA_CMD64X=y
> > # CONFIG_PATA_CS5520 is not set
> > # CONFIG_PATA_CS5530 is not set
> > # CONFIG_PATA_CS5536 is not set
> > # CONFIG_PATA_CYPRESS is not set
> > CONFIG_PATA_EFAR=y
> > # CONFIG_PATA_HPT366 is not set
> > CONFIG_PATA_HPT37X=y
> > CONFIG_PATA_HPT3X2N=y
> > CONFIG_PATA_HPT3X3=y
> > CONFIG_PATA_HPT3X3_DMA=y
> > # CONFIG_PATA_IMX is not set
> > CONFIG_PATA_IT8213=y
> > CONFIG_PATA_IT821X=y
> > CONFIG_PATA_JMICRON=y
> > # CONFIG_PATA_MARVELL is not set
> > CONFIG_PATA_NETCELL=y
> > CONFIG_PATA_NINJA32=y
> > CONFIG_PATA_NS87415=y
> > CONFIG_PATA_OLDPIIX=y
> > CONFIG_PATA_OPTIDMA=y
> > CONFIG_PATA_PDC2027X=y
> > CONFIG_PATA_PDC_OLD=y
> > # CONFIG_PATA_RADISYS is not set
> > CONFIG_PATA_RDC=y
> > # CONFIG_PATA_SC1200 is not set
> > # CONFIG_PATA_SCH is not set
> > CONFIG_PATA_SERVERWORKS=y
> > CONFIG_PATA_SIL680=y
> > CONFIG_PATA_SIS=y
> > CONFIG_PATA_TOSHIBA=y
> > CONFIG_PATA_TRIFLEX=y
> > CONFIG_PATA_VIA=y
> > # CONFIG_PATA_PXA is not set
> > CONFIG_PATA_WINBOND=y
> >
> > #
> > # PIO-only SFF controllers
> > #
> > CONFIG_PATA_CMD640_PCI=y
> > # CONFIG_PATA_IXP4XX_CF is not set
> > # CONFIG_PATA_MPIIX is not set
> > # CONFIG_PATA_NS87410 is not set
> > # CONFIG_PATA_OPTI is not set
> > CONFIG_PATA_RZ1000=y
> > # CONFIG_PATA_SAMSUNG_CF is not set
> >
> > #
> > # Generic fallback / legacy drivers
> > #
> > CONFIG_ATA_GENERIC=y
> > CONFIG_PATA_LEGACY=y
> > CONFIG_MD=y
> > # CONFIG_BLK_DEV_MD is not set
> > CONFIG_BCACHE=y
> > # CONFIG_BCACHE_DEBUG is not set
> > # CONFIG_BCACHE_CLOSURES_DEBUG is not set
> > # CONFIG_BCACHE_ASYNC_REGISTRATION is not set
> > CONFIG_BLK_DEV_DM_BUILTIN=y
> > CONFIG_BLK_DEV_DM=y
> > CONFIG_DM_DEBUG=y
> > CONFIG_DM_BUFIO=y
> > # CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
> > CONFIG_DM_BIO_PRISON=y
> > CONFIG_DM_PERSISTENT_DATA=y
> > CONFIG_DM_UNSTRIPED=y
> > CONFIG_DM_CRYPT=y
> > CONFIG_DM_SNAPSHOT=y
> > # CONFIG_DM_THIN_PROVISIONING is not set
> > CONFIG_DM_CACHE=y
> > # CONFIG_DM_CACHE_SMQ is not set
> > CONFIG_DM_WRITECACHE=y
> > # CONFIG_DM_EBS is not set
> > CONFIG_DM_ERA=y
> > # CONFIG_DM_CLONE is not set
> > CONFIG_DM_MIRROR=y
> > # CONFIG_DM_RAID is not set
> > CONFIG_DM_ZERO=y
> > CONFIG_DM_MULTIPATH=y
> > CONFIG_DM_MULTIPATH_QL=y
> > CONFIG_DM_MULTIPATH_ST=y
> > CONFIG_DM_MULTIPATH_HST=y
> > CONFIG_DM_MULTIPATH_IOA=y
> > CONFIG_DM_DELAY=y
> > # CONFIG_DM_DUST is not set
> > CONFIG_DM_INIT=y
> > # CONFIG_DM_UEVENT is not set
> > CONFIG_DM_FLAKEY=y
> > CONFIG_DM_VERITY=y
> > CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
> > # CONFIG_DM_VERITY_FEC is not set
> > CONFIG_DM_SWITCH=y
> > CONFIG_DM_LOG_WRITES=y
> > CONFIG_DM_INTEGRITY=y
> > CONFIG_TARGET_CORE=y
> > # CONFIG_TCM_IBLOCK is not set
> > CONFIG_TCM_FILEIO=y
> > # CONFIG_TCM_PSCSI is not set
> > CONFIG_LOOPBACK_TARGET=y
> > # CONFIG_FUSION is not set
> >
> > #
> > # IEEE 1394 (FireWire) support
> > #
> > # CONFIG_FIREWIRE is not set
> > CONFIG_FIREWIRE_NOSY=y
> > # end of IEEE 1394 (FireWire) support
> >
> > #
> > # Input device support
> > #
> > CONFIG_INPUT=y
> > # CONFIG_INPUT_LEDS is not set
> > CONFIG_INPUT_FF_MEMLESS=y
> > CONFIG_INPUT_SPARSEKMAP=y
> > CONFIG_INPUT_MATRIXKMAP=y
> > CONFIG_INPUT_VIVALDIFMAP=y
> >
> > #
> > # Userland interfaces
> > #
> > # CONFIG_INPUT_MOUSEDEV is not set
> > CONFIG_INPUT_JOYDEV=y
> > # CONFIG_INPUT_EVDEV is not set
> > CONFIG_INPUT_EVBUG=y
> >
> > #
> > # Input Device Drivers
> > #
> > CONFIG_INPUT_KEYBOARD=y
> > CONFIG_KEYBOARD_ADC=y
> > CONFIG_KEYBOARD_ADP5588=y
> > CONFIG_KEYBOARD_ADP5589=y
> > CONFIG_KEYBOARD_ATKBD=y
> > CONFIG_KEYBOARD_QT1050=y
> > # CONFIG_KEYBOARD_QT1070 is not set
> > CONFIG_KEYBOARD_QT2160=y
> > # CONFIG_KEYBOARD_CLPS711X is not set
> > CONFIG_KEYBOARD_DLINK_DIR685=y
> > # CONFIG_KEYBOARD_LKKBD is not set
> > # CONFIG_KEYBOARD_EP93XX is not set
> > CONFIG_KEYBOARD_GPIO=y
> > # CONFIG_KEYBOARD_GPIO_POLLED is not set
> > CONFIG_KEYBOARD_TCA6416=y
> > CONFIG_KEYBOARD_TCA8418=y
> > # CONFIG_KEYBOARD_MATRIX is not set
> > CONFIG_KEYBOARD_LM8323=y
> > CONFIG_KEYBOARD_LM8333=y
> > CONFIG_KEYBOARD_MAX7359=y
> > CONFIG_KEYBOARD_MCS=y
> > # CONFIG_KEYBOARD_MPR121 is not set
> > # CONFIG_KEYBOARD_IMX is not set
> > CONFIG_KEYBOARD_NEWTON=y
> > CONFIG_KEYBOARD_OPENCORES=y
> > CONFIG_KEYBOARD_PINEPHONE=y
> > CONFIG_KEYBOARD_SAMSUNG=y
> > CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
> > # CONFIG_KEYBOARD_STOWAWAY is not set
> > # CONFIG_KEYBOARD_ST_KEYSCAN is not set
> > CONFIG_KEYBOARD_SUNKBD=y
> > # CONFIG_KEYBOARD_SH_KEYSC is not set
> > # CONFIG_KEYBOARD_IQS62X is not set
> > # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> > CONFIG_KEYBOARD_XTKBD=y
> > # CONFIG_KEYBOARD_MT6779 is not set
> > # CONFIG_KEYBOARD_MTK_PMIC is not set
> > CONFIG_KEYBOARD_CYPRESS_SF=y
> > # CONFIG_INPUT_MOUSE is not set
> > CONFIG_INPUT_JOYSTICK=y
> > # CONFIG_JOYSTICK_ANALOG is not set
> > # CONFIG_JOYSTICK_A3D is not set
> > # CONFIG_JOYSTICK_ADC is not set
> > # CONFIG_JOYSTICK_ADI is not set
> > CONFIG_JOYSTICK_COBRA=y
> > CONFIG_JOYSTICK_GF2K=y
> > CONFIG_JOYSTICK_GRIP=y
> > CONFIG_JOYSTICK_GRIP_MP=y
> > CONFIG_JOYSTICK_GUILLEMOT=y
> > CONFIG_JOYSTICK_INTERACT=y
> > # CONFIG_JOYSTICK_SIDEWINDER is not set
> > CONFIG_JOYSTICK_TMDC=y
> > # CONFIG_JOYSTICK_IFORCE is not set
> > CONFIG_JOYSTICK_WARRIOR=y
> > CONFIG_JOYSTICK_MAGELLAN=y
> > CONFIG_JOYSTICK_SPACEORB=y
> > CONFIG_JOYSTICK_SPACEBALL=y
> > CONFIG_JOYSTICK_STINGER=y
> > CONFIG_JOYSTICK_TWIDJOY=y
> > CONFIG_JOYSTICK_ZHENHUA=y
> > # CONFIG_JOYSTICK_DB9 is not set
> > CONFIG_JOYSTICK_GAMECON=y
> > CONFIG_JOYSTICK_TURBOGRAFX=y
> > CONFIG_JOYSTICK_AS5011=y
> > CONFIG_JOYSTICK_JOYDUMP=y
> > CONFIG_JOYSTICK_XPAD=y
> > CONFIG_JOYSTICK_XPAD_FF=y
> > # CONFIG_JOYSTICK_XPAD_LEDS is not set
> > CONFIG_JOYSTICK_PXRC=y
> > CONFIG_JOYSTICK_QWIIC=y
> > CONFIG_JOYSTICK_FSIA6B=y
> > CONFIG_JOYSTICK_SENSEHAT=y
> > # CONFIG_INPUT_TABLET is not set
> > CONFIG_INPUT_TOUCHSCREEN=y
> > # CONFIG_TOUCHSCREEN_AD7879 is not set
> > CONFIG_TOUCHSCREEN_ADC=y
> > # CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
> > CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
> > # CONFIG_TOUCHSCREEN_BU21013 is not set
> > CONFIG_TOUCHSCREEN_BU21029=y
> > # CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
> > # CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
> > # CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
> > CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
> > CONFIG_TOUCHSCREEN_CYTTSP_I2C=y
> > # CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
> > # CONFIG_TOUCHSCREEN_DA9034 is not set
> > CONFIG_TOUCHSCREEN_DYNAPRO=y
> > CONFIG_TOUCHSCREEN_HAMPSHIRE=y
> > CONFIG_TOUCHSCREEN_EETI=y
> > # CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
> > CONFIG_TOUCHSCREEN_EXC3000=y
> > # CONFIG_TOUCHSCREEN_FUJITSU is not set
> > # CONFIG_TOUCHSCREEN_GOODIX is not set
> > CONFIG_TOUCHSCREEN_HIDEEP=y
> > CONFIG_TOUCHSCREEN_HYCON_HY46XX=y
> > CONFIG_TOUCHSCREEN_ILI210X=y
> > CONFIG_TOUCHSCREEN_ILITEK=y
> > # CONFIG_TOUCHSCREEN_IPROC is not set
> > CONFIG_TOUCHSCREEN_S6SY761=y
> > CONFIG_TOUCHSCREEN_GUNZE=y
> > CONFIG_TOUCHSCREEN_EKTF2127=y
> > # CONFIG_TOUCHSCREEN_ELAN is not set
> > CONFIG_TOUCHSCREEN_ELO=y
> > # CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
> > # CONFIG_TOUCHSCREEN_WACOM_I2C is not set
> > CONFIG_TOUCHSCREEN_MAX11801=y
> > CONFIG_TOUCHSCREEN_MCS5000=y
> > CONFIG_TOUCHSCREEN_MMS114=y
> > CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
> > CONFIG_TOUCHSCREEN_MSG2638=y
> > CONFIG_TOUCHSCREEN_MTOUCH=y
> > CONFIG_TOUCHSCREEN_IMAGIS=y
> > # CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
> > # CONFIG_TOUCHSCREEN_INEXIO is not set
> > CONFIG_TOUCHSCREEN_MK712=y
> > # CONFIG_TOUCHSCREEN_PENMOUNT is not set
> > CONFIG_TOUCHSCREEN_EDT_FT5X06=y
> > # CONFIG_TOUCHSCREEN_RASPBERRYPI_FW is not set
> > # CONFIG_TOUCHSCREEN_MIGOR is not set
> > CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
> > # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
> > CONFIG_TOUCHSCREEN_UCB1400=y
> > # CONFIG_TOUCHSCREEN_PIXCIR is not set
> > # CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
> > # CONFIG_TOUCHSCREEN_WM831X is not set
> > CONFIG_TOUCHSCREEN_WM97XX=y
> > # CONFIG_TOUCHSCREEN_WM9705 is not set
> > # CONFIG_TOUCHSCREEN_WM9712 is not set
> > # CONFIG_TOUCHSCREEN_WM9713 is not set
> > CONFIG_TOUCHSCREEN_USB_COMPOSITE=y
> > CONFIG_TOUCHSCREEN_MC13783=y
> > # CONFIG_TOUCHSCREEN_USB_EGALAX is not set
> > CONFIG_TOUCHSCREEN_USB_PANJIT=y
> > # CONFIG_TOUCHSCREEN_USB_3M is not set
> > CONFIG_TOUCHSCREEN_USB_ITM=y
> > # CONFIG_TOUCHSCREEN_USB_ETURBO is not set
> > CONFIG_TOUCHSCREEN_USB_GUNZE=y
> > CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
> > CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
> > # CONFIG_TOUCHSCREEN_USB_IDEALTEK is not set
> > # CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH is not set
> > CONFIG_TOUCHSCREEN_USB_GOTOP=y
> > CONFIG_TOUCHSCREEN_USB_JASTEC=y
> > CONFIG_TOUCHSCREEN_USB_ELO=y
> > CONFIG_TOUCHSCREEN_USB_E2I=y
> > # CONFIG_TOUCHSCREEN_USB_ZYTRONIC is not set
> > CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
> > # CONFIG_TOUCHSCREEN_USB_NEXIO is not set
> > # CONFIG_TOUCHSCREEN_USB_EASYTOUCH is not set
> > CONFIG_TOUCHSCREEN_TOUCHIT213=y
> > CONFIG_TOUCHSCREEN_TSC_SERIO=y
> > # CONFIG_TOUCHSCREEN_TSC2004 is not set
> > CONFIG_TOUCHSCREEN_TSC2007=y
> > # CONFIG_TOUCHSCREEN_TSC2007_IIO is not set
> > CONFIG_TOUCHSCREEN_RM_TS=y
> > # CONFIG_TOUCHSCREEN_SILEAD is not set
> > CONFIG_TOUCHSCREEN_SIS_I2C=y
> > CONFIG_TOUCHSCREEN_ST1232=y
> > # CONFIG_TOUCHSCREEN_STMFTS is not set
> > # CONFIG_TOUCHSCREEN_SUN4I is not set
> > CONFIG_TOUCHSCREEN_SX8654=y
> > # CONFIG_TOUCHSCREEN_TPS6507X is not set
> > CONFIG_TOUCHSCREEN_ZET6223=y
> > # CONFIG_TOUCHSCREEN_ZFORCE is not set
> > CONFIG_TOUCHSCREEN_COLIBRI_VF50=y
> > # CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
> > CONFIG_TOUCHSCREEN_IQS5XX=y
> > # CONFIG_TOUCHSCREEN_ZINITIX is not set
> > # CONFIG_INPUT_MISC is not set
> > CONFIG_RMI4_CORE=y
> > CONFIG_RMI4_I2C=y
> > CONFIG_RMI4_SMB=y
> > CONFIG_RMI4_F03=y
> > CONFIG_RMI4_F03_SERIO=y
> > CONFIG_RMI4_2D_SENSOR=y
> > CONFIG_RMI4_F11=y
> > CONFIG_RMI4_F12=y
> > CONFIG_RMI4_F30=y
> > # CONFIG_RMI4_F34 is not set
> > CONFIG_RMI4_F3A=y
> > CONFIG_RMI4_F54=y
> > CONFIG_RMI4_F55=y
> >
> > #
> > # Hardware I/O ports
> > #
> > CONFIG_SERIO=y
> > CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> > CONFIG_SERIO_I8042=y
> > CONFIG_SERIO_PARKBD=y
> > CONFIG_SERIO_PCIPS2=y
> > CONFIG_SERIO_LIBPS2=y
> > # CONFIG_SERIO_RAW is not set
> > # CONFIG_SERIO_ALTERA_PS2 is not set
> > # CONFIG_SERIO_PS2MULT is not set
> > # CONFIG_SERIO_ARC_PS2 is not set
> > # CONFIG_SERIO_OLPC_APSP is not set
> > # CONFIG_SERIO_SUN4I_PS2 is not set
> > CONFIG_SERIO_GPIO_PS2=y
> > CONFIG_USERIO=y
> > CONFIG_GAMEPORT=y
> > CONFIG_GAMEPORT_NS558=y
> > CONFIG_GAMEPORT_L4=y
> > CONFIG_GAMEPORT_EMU10K1=y
> > # CONFIG_GAMEPORT_FM801 is not set
> > # end of Hardware I/O ports
> > # end of Input device support
> >
> > #
> > # Character devices
> > #
> > # CONFIG_TTY is not set
> > # CONFIG_SERIAL_DEV_BUS is not set
> > CONFIG_PRINTER=y
> > # CONFIG_LP_CONSOLE is not set
> > # CONFIG_PPDEV is not set
> > # CONFIG_IPMI_HANDLER is not set
> > # CONFIG_ASPEED_KCS_IPMI_BMC is not set
> > # CONFIG_NPCM7XX_KCS_IPMI_BMC is not set
> > # CONFIG_ASPEED_BT_IPMI_BMC is not set
> > CONFIG_IPMB_DEVICE_INTERFACE=y
> > CONFIG_HW_RANDOM=y
> > # CONFIG_HW_RANDOM_TIMERIOMEM is not set
> > CONFIG_HW_RANDOM_BA431=y
> > CONFIG_HW_RANDOM_BCM2835=y
> > CONFIG_HW_RANDOM_IPROC_RNG200=y
> > CONFIG_HW_RANDOM_IXP4XX=y
> > CONFIG_HW_RANDOM_OMAP=y
> > CONFIG_HW_RANDOM_OMAP3_ROM=y
> > # CONFIG_HW_RANDOM_VIRTIO is not set
> > CONFIG_HW_RANDOM_IMX_RNGC=y
> > CONFIG_HW_RANDOM_NOMADIK=y
> > CONFIG_HW_RANDOM_STM32=y
> > CONFIG_HW_RANDOM_MESON=y
> > CONFIG_HW_RANDOM_MTK=y
> > CONFIG_HW_RANDOM_EXYNOS=y
> > CONFIG_HW_RANDOM_NPCM=y
> > # CONFIG_HW_RANDOM_XIPHERA is not set
> > CONFIG_HW_RANDOM_CN10K=y
> > CONFIG_APPLICOM=y
> > # CONFIG_DEVMEM is not set
> > # CONFIG_DEVPORT is not set
> > # CONFIG_TCG_TPM is not set
> > CONFIG_XILLYBUS_CLASS=y
> > # CONFIG_XILLYBUS is not set
> > CONFIG_XILLYUSB=y
> > CONFIG_RANDOM_TRUST_CPU=y
> > CONFIG_RANDOM_TRUST_BOOTLOADER=y
> > # end of Character devices
> >
> > #
> > # I2C support
> > #
> > CONFIG_I2C=y
> > # CONFIG_ACPI_I2C_OPREGION is not set
> > CONFIG_I2C_BOARDINFO=y
> > # CONFIG_I2C_COMPAT is not set
> > CONFIG_I2C_CHARDEV=y
> > CONFIG_I2C_MUX=y
> >
> > #
> > # Multiplexer I2C Chip support
> > #
> > CONFIG_I2C_MUX_GPIO=y
> > CONFIG_I2C_MUX_LTC4306=y
> > CONFIG_I2C_MUX_PCA9541=y
> > # CONFIG_I2C_MUX_PCA954x is not set
> > CONFIG_I2C_MUX_REG=y
> > CONFIG_I2C_MUX_MLXCPLD=y
> > # end of Multiplexer I2C Chip support
> >
> > # CONFIG_I2C_HELPER_AUTO is not set
> > CONFIG_I2C_SMBUS=y
> >
> > #
> > # I2C Algorithms
> > #
> > CONFIG_I2C_ALGOBIT=y
> > CONFIG_I2C_ALGOPCF=y
> > CONFIG_I2C_ALGOPCA=y
> > # end of I2C Algorithms
> >
> > #
> > # I2C Hardware Bus support
> > #
> >
> > #
> > # PC SMBus host controller drivers
> > #
> > CONFIG_I2C_CCGX_UCSI=y
> > # CONFIG_I2C_ALI1535 is not set
> > CONFIG_I2C_ALI1563=y
> > CONFIG_I2C_ALI15X3=y
> > # CONFIG_I2C_AMD756 is not set
> > CONFIG_I2C_AMD8111=y
> > # CONFIG_I2C_AMD_MP2 is not set
> > # CONFIG_I2C_HIX5HD2 is not set
> > CONFIG_I2C_I801=y
> > CONFIG_I2C_ISCH=y
> > CONFIG_I2C_PIIX4=y
> > CONFIG_I2C_NFORCE2=y
> > # CONFIG_I2C_NVIDIA_GPU is not set
> > CONFIG_I2C_SIS5595=y
> > CONFIG_I2C_SIS630=y
> > # CONFIG_I2C_SIS96X is not set
> > CONFIG_I2C_VIA=y
> > # CONFIG_I2C_VIAPRO is not set
> >
> > #
> > # ACPI drivers
> > #
> > CONFIG_I2C_SCMI=y
> >
> > #
> > # I2C system bus drivers (mostly embedded / system-on-chip)
> > #
> > # CONFIG_I2C_ASPEED is not set
> > # CONFIG_I2C_AT91 is not set
> > # CONFIG_I2C_AXXIA is not set
> > # CONFIG_I2C_BCM2835 is not set
> > # CONFIG_I2C_BCM_IPROC is not set
> > # CONFIG_I2C_BCM_KONA is not set
> > CONFIG_I2C_BRCMSTB=y
> > # CONFIG_I2C_CADENCE is not set
> > # CONFIG_I2C_CBUS_GPIO is not set
> > # CONFIG_I2C_DAVINCI is not set
> > CONFIG_I2C_DESIGNWARE_CORE=y
> > CONFIG_I2C_DESIGNWARE_SLAVE=y
> > CONFIG_I2C_DESIGNWARE_PLATFORM=y
> > CONFIG_I2C_DESIGNWARE_PCI=y
> > # CONFIG_I2C_DIGICOLOR is not set
> > # CONFIG_I2C_EG20T is not set
> > CONFIG_I2C_EMEV2=y
> > # CONFIG_I2C_GPIO is not set
> > # CONFIG_I2C_HIGHLANDER is not set
> > # CONFIG_I2C_HISI is not set
> > # CONFIG_I2C_IMG is not set
> > # CONFIG_I2C_IMX is not set
> > # CONFIG_I2C_IMX_LPI2C is not set
> > # CONFIG_I2C_IOP3XX is not set
> > # CONFIG_I2C_JZ4780 is not set
> > CONFIG_I2C_KEMPLD=y
> > # CONFIG_I2C_MESON is not set
> > # CONFIG_I2C_MT65XX is not set
> > # CONFIG_I2C_MT7621 is not set
> > # CONFIG_I2C_MV64XXX is not set
> > # CONFIG_I2C_MXS is not set
> > # CONFIG_I2C_NPCM is not set
> > # CONFIG_I2C_OCORES is not set
> > # CONFIG_I2C_OMAP is not set
> > # CONFIG_I2C_OWL is not set
> > # CONFIG_I2C_APPLE is not set
> > CONFIG_I2C_PCA_PLATFORM=y
> > # CONFIG_I2C_PNX is not set
> > # CONFIG_I2C_PXA is not set
> > # CONFIG_I2C_QCOM_CCI is not set
> > # CONFIG_I2C_QUP is not set
> > # CONFIG_I2C_RIIC is not set
> > # CONFIG_I2C_RZV2M is not set
> > # CONFIG_I2C_S3C2410 is not set
> > # CONFIG_I2C_SH_MOBILE is not set
> > CONFIG_I2C_SIMTEC=y
> > # CONFIG_I2C_SPRD is not set
> > # CONFIG_I2C_ST is not set
> > # CONFIG_I2C_STM32F4 is not set
> > # CONFIG_I2C_STM32F7 is not set
> > # CONFIG_I2C_SUN6I_P2WI is not set
> > # CONFIG_I2C_SYNQUACER is not set
> > # CONFIG_I2C_TEGRA_BPMP is not set
> > # CONFIG_I2C_UNIPHIER is not set
> > # CONFIG_I2C_UNIPHIER_F is not set
> > # CONFIG_I2C_VERSATILE is not set
> > # CONFIG_I2C_WMT is not set
> > # CONFIG_I2C_THUNDERX is not set
> > # CONFIG_I2C_XILINX is not set
> > # CONFIG_I2C_XLP9XX is not set
> > # CONFIG_I2C_RCAR is not set
> >
> > #
> > # External I2C/SMBus adapter drivers
> > #
> > CONFIG_I2C_DIOLAN_U2C=y
> > CONFIG_I2C_DLN2=y
> > CONFIG_I2C_CP2615=y
> > CONFIG_I2C_PARPORT=y
> > CONFIG_I2C_PCI1XXXX=y
> > CONFIG_I2C_ROBOTFUZZ_OSIF=y
> > CONFIG_I2C_TINY_USB=y
> >
> > #
> > # Other I2C/SMBus bus drivers
> > #
> > # CONFIG_I2C_MLXCPLD is not set
> > # CONFIG_I2C_VIRTIO is not set
> > # end of I2C Hardware Bus support
> >
> > CONFIG_I2C_SLAVE=y
> > CONFIG_I2C_SLAVE_EEPROM=y
> > CONFIG_I2C_SLAVE_TESTUNIT=y
> > # CONFIG_I2C_DEBUG_CORE is not set
> > # CONFIG_I2C_DEBUG_ALGO is not set
> > # CONFIG_I2C_DEBUG_BUS is not set
> > # end of I2C support
> >
> > # CONFIG_I3C is not set
> > # CONFIG_SPI is not set
> > # CONFIG_SPMI is not set
> > CONFIG_HSI=y
> > CONFIG_HSI_BOARDINFO=y
> >
> > #
> > # HSI controllers
> > #
> >
> > #
> > # HSI clients
> > #
> > CONFIG_HSI_CHAR=y
> > # CONFIG_PPS is not set
> >
> > #
> > # PTP clock support
> > #
> > CONFIG_PTP_1588_CLOCK_OPTIONAL=y
> >
> > #
> > # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> > #
> > # end of PTP clock support
> >
> > CONFIG_PINCTRL=y
> > CONFIG_PINMUX=y
> > CONFIG_PINCONF=y
> > CONFIG_GENERIC_PINCONF=y
> > CONFIG_DEBUG_PINCTRL=y
> > # CONFIG_PINCTRL_AMD is not set
> > # CONFIG_PINCTRL_CY8C95X0 is not set
> > CONFIG_PINCTRL_DA9062=y
> > CONFIG_PINCTRL_MCP23S08_I2C=y
> > CONFIG_PINCTRL_MCP23S08=y
> > CONFIG_PINCTRL_SX150X=y
> > CONFIG_PINCTRL_MADERA=y
> > CONFIG_PINCTRL_CS47L15=y
> > CONFIG_PINCTRL_CS47L35=y
> > CONFIG_PINCTRL_CS47L85=y
> > CONFIG_PINCTRL_CS47L90=y
> > CONFIG_PINCTRL_CS47L92=y
> >
> > #
> > # Intel pinctrl drivers
> > #
> > # CONFIG_PINCTRL_BAYTRAIL is not set
> > # CONFIG_PINCTRL_CHERRYVIEW is not set
> > # CONFIG_PINCTRL_LYNXPOINT is not set
> > # CONFIG_PINCTRL_ALDERLAKE is not set
> > # CONFIG_PINCTRL_BROXTON is not set
> > # CONFIG_PINCTRL_CANNONLAKE is not set
> > # CONFIG_PINCTRL_CEDARFORK is not set
> > # CONFIG_PINCTRL_DENVERTON is not set
> > # CONFIG_PINCTRL_ELKHARTLAKE is not set
> > # CONFIG_PINCTRL_EMMITSBURG is not set
> > # CONFIG_PINCTRL_GEMINILAKE is not set
> > # CONFIG_PINCTRL_ICELAKE is not set
> > # CONFIG_PINCTRL_JASPERLAKE is not set
> > # CONFIG_PINCTRL_LAKEFIELD is not set
> > # CONFIG_PINCTRL_LEWISBURG is not set
> > # CONFIG_PINCTRL_METEORLAKE is not set
> > # CONFIG_PINCTRL_SUNRISEPOINT is not set
> > # CONFIG_PINCTRL_TIGERLAKE is not set
> > # end of Intel pinctrl drivers
> >
> > #
> > # MediaTek pinctrl drivers
> > #
> > # CONFIG_EINT_MTK is not set
> > # end of MediaTek pinctrl drivers
> >
> > # CONFIG_PINCTRL_PXA25X is not set
> > # CONFIG_PINCTRL_PXA27X is not set
> > # CONFIG_PINCTRL_MSM is not set
> > # CONFIG_PINCTRL_LPASS_LPI is not set
> >
> > #
> > # Renesas pinctrl drivers
> > #
> > # CONFIG_PINCTRL_RENESAS is not set
> > # CONFIG_PINCTRL_PFC_EMEV2 is not set
> > # CONFIG_PINCTRL_PFC_R8A77995 is not set
> > # CONFIG_PINCTRL_PFC_R8A7794 is not set
> > # CONFIG_PINCTRL_PFC_R8A77990 is not set
> > # CONFIG_PINCTRL_PFC_R8A7779 is not set
> > # CONFIG_PINCTRL_PFC_R8A7790 is not set
> > # CONFIG_PINCTRL_PFC_R8A77950 is not set
> > # CONFIG_PINCTRL_PFC_R8A77951 is not set
> > # CONFIG_PINCTRL_PFC_R8A7778 is not set
> > # CONFIG_PINCTRL_PFC_R8A7793 is not set
> > # CONFIG_PINCTRL_PFC_R8A7791 is not set
> > # CONFIG_PINCTRL_PFC_R8A77965 is not set
> > # CONFIG_PINCTRL_PFC_R8A77960 is not set
> > # CONFIG_PINCTRL_PFC_R8A77961 is not set
> > # CONFIG_PINCTRL_PFC_R8A779F0 is not set
> > # CONFIG_PINCTRL_PFC_R8A7792 is not set
> > # CONFIG_PINCTRL_PFC_R8A77980 is not set
> > # CONFIG_PINCTRL_PFC_R8A77970 is not set
> > # CONFIG_PINCTRL_PFC_R8A779A0 is not set
> > # CONFIG_PINCTRL_PFC_R8A779G0 is not set
> > # CONFIG_PINCTRL_PFC_R8A7740 is not set
> > # CONFIG_PINCTRL_PFC_R8A73A4 is not set
> > # CONFIG_PINCTRL_PFC_R8A77470 is not set
> > # CONFIG_PINCTRL_PFC_R8A7745 is not set
> > # CONFIG_PINCTRL_PFC_R8A7742 is not set
> > # CONFIG_PINCTRL_PFC_R8A7743 is not set
> > # CONFIG_PINCTRL_PFC_R8A7744 is not set
> > # CONFIG_PINCTRL_PFC_R8A774C0 is not set
> > # CONFIG_PINCTRL_PFC_R8A774E1 is not set
> > # CONFIG_PINCTRL_PFC_R8A774A1 is not set
> > # CONFIG_PINCTRL_PFC_R8A774B1 is not set
> > # CONFIG_PINCTRL_PFC_SH7203 is not set
> > # CONFIG_PINCTRL_PFC_SH7264 is not set
> > # CONFIG_PINCTRL_PFC_SH7269 is not set
> > # CONFIG_PINCTRL_PFC_SH7720 is not set
> > # CONFIG_PINCTRL_PFC_SH7722 is not set
> > # CONFIG_PINCTRL_PFC_SH7734 is not set
> > # CONFIG_PINCTRL_PFC_SH7757 is not set
> > # CONFIG_PINCTRL_PFC_SH7785 is not set
> > # CONFIG_PINCTRL_PFC_SH7786 is not set
> > # CONFIG_PINCTRL_PFC_SH73A0 is not set
> > # CONFIG_PINCTRL_PFC_SH7723 is not set
> > # CONFIG_PINCTRL_PFC_SH7724 is not set
> > # CONFIG_PINCTRL_PFC_SHX3 is not set
> > # end of Renesas pinctrl drivers
> >
> > CONFIG_GPIOLIB=y
> > CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> > CONFIG_GPIO_ACPI=y
> > CONFIG_GPIOLIB_IRQCHIP=y
> > CONFIG_DEBUG_GPIO=y
> > # CONFIG_GPIO_SYSFS is not set
> > # CONFIG_GPIO_CDEV is not set
> > CONFIG_GPIO_GENERIC=y
> >
> > #
> > # Memory mapped GPIO drivers
> > #
> > CONFIG_GPIO_AMDPT=y
> > # CONFIG_GPIO_ATH79 is not set
> > # CONFIG_GPIO_CLPS711X is not set
> > CONFIG_GPIO_DWAPB=y
> > CONFIG_GPIO_GENERIC_PLATFORM=y
> > # CONFIG_GPIO_HISI is not set
> > # CONFIG_GPIO_IOP is not set
> > # CONFIG_GPIO_MB86S7X is not set
> > # CONFIG_GPIO_MENZ127 is not set
> > # CONFIG_GPIO_MPC8XXX is not set
> > # CONFIG_GPIO_MXC is not set
> > # CONFIG_GPIO_MXS is not set
> > # CONFIG_GPIO_PXA is not set
> > # CONFIG_GPIO_RCAR is not set
> > # CONFIG_GPIO_ROCKCHIP is not set
> > CONFIG_GPIO_SIOX=y
> > # CONFIG_GPIO_THUNDERX is not set
> > # CONFIG_GPIO_VX855 is not set
> > # CONFIG_GPIO_XGENE_SB is not set
> > # CONFIG_GPIO_XLP is not set
> > # CONFIG_GPIO_AMD_FCH is not set
> > # CONFIG_GPIO_IDT3243X is not set
> > # end of Memory mapped GPIO drivers
> >
> > #
> > # I2C GPIO expanders
> > #
> > # CONFIG_GPIO_MAX7300 is not set
> > CONFIG_GPIO_MAX732X=y
> > CONFIG_GPIO_MAX732X_IRQ=y
> > CONFIG_GPIO_PCA953X=y
> > # CONFIG_GPIO_PCA953X_IRQ is not set
> > CONFIG_GPIO_PCA9570=y
> > CONFIG_GPIO_PCF857X=y
> > CONFIG_GPIO_TPIC2810=y
> > # CONFIG_GPIO_TS4900 is not set
> > # end of I2C GPIO expanders
> >
> > #
> > # MFD GPIO expanders
> > #
> > CONFIG_GPIO_BD9571MWV=y
> > CONFIG_GPIO_DA9055=y
> > # CONFIG_GPIO_DLN2 is not set
> > CONFIG_GPIO_JANZ_TTL=y
> > # CONFIG_GPIO_KEMPLD is not set
> > CONFIG_GPIO_LP3943=y
> > CONFIG_GPIO_LP873X=y
> > CONFIG_GPIO_MADERA=y
> > CONFIG_GPIO_PALMAS=y
> > # CONFIG_GPIO_SL28CPLD is not set
> > CONFIG_GPIO_TPS65086=y
> > # CONFIG_GPIO_TPS65910 is not set
> > CONFIG_GPIO_TQMX86=y
> > CONFIG_GPIO_UCB1400=y
> > CONFIG_GPIO_WM831X=y
> > CONFIG_GPIO_WM8994=y
> > # end of MFD GPIO expanders
> >
> > #
> > # PCI GPIO expanders
> > #
> > # CONFIG_GPIO_AMD8111 is not set
> > # CONFIG_GPIO_BT8XX is not set
> > # CONFIG_GPIO_MLXBF is not set
> > # CONFIG_GPIO_MLXBF2 is not set
> > # CONFIG_GPIO_ML_IOH is not set
> > # CONFIG_GPIO_PCH is not set
> > CONFIG_GPIO_PCI_IDIO_16=y
> > # CONFIG_GPIO_PCIE_IDIO_24 is not set
> > CONFIG_GPIO_RDC321X=y
> > # end of PCI GPIO expanders
> >
> > #
> > # USB GPIO expanders
> > #
> > # end of USB GPIO expanders
> >
> > #
> > # Virtual GPIO drivers
> > #
> > # CONFIG_GPIO_AGGREGATOR is not set
> > # CONFIG_GPIO_MOCKUP is not set
> > CONFIG_GPIO_VIRTIO=y
> > # CONFIG_GPIO_SIM is not set
> > # end of Virtual GPIO drivers
> >
> > CONFIG_W1=y
> >
> > #
> > # 1-wire Bus Masters
> > #
> > CONFIG_W1_MASTER_MATROX=y
> > CONFIG_W1_MASTER_DS2490=y
> > CONFIG_W1_MASTER_DS2482=y
> > # CONFIG_W1_MASTER_MXC is not set
> > CONFIG_W1_MASTER_DS1WM=y
> > # CONFIG_W1_MASTER_GPIO is not set
> > CONFIG_W1_MASTER_SGI=y
> > # end of 1-wire Bus Masters
> >
> > #
> > # 1-wire Slaves
> > #
> > CONFIG_W1_SLAVE_THERM=y
> > # CONFIG_W1_SLAVE_SMEM is not set
> > CONFIG_W1_SLAVE_DS2405=y
> > CONFIG_W1_SLAVE_DS2408=y
> > # CONFIG_W1_SLAVE_DS2408_READBACK is not set
> > # CONFIG_W1_SLAVE_DS2413 is not set
> > # CONFIG_W1_SLAVE_DS2406 is not set
> > # CONFIG_W1_SLAVE_DS2423 is not set
> > # CONFIG_W1_SLAVE_DS2805 is not set
> > CONFIG_W1_SLAVE_DS2430=y
> > # CONFIG_W1_SLAVE_DS2431 is not set
> > CONFIG_W1_SLAVE_DS2433=y
> > CONFIG_W1_SLAVE_DS2433_CRC=y
> > CONFIG_W1_SLAVE_DS2438=y
> > CONFIG_W1_SLAVE_DS250X=y
> > CONFIG_W1_SLAVE_DS2780=y
> > CONFIG_W1_SLAVE_DS2781=y
> > # CONFIG_W1_SLAVE_DS28E04 is not set
> > CONFIG_W1_SLAVE_DS28E17=y
> > # end of 1-wire Slaves
> >
> > CONFIG_POWER_RESET=y
> > CONFIG_POWER_RESET_ATC260X=y
> > # CONFIG_POWER_RESET_BRCMKONA is not set
> > # CONFIG_POWER_RESET_BRCMSTB is not set
> > # CONFIG_POWER_RESET_OCELOT_RESET is not set
> > # CONFIG_POWER_RESET_PIIX4_POWEROFF is not set
> > CONFIG_POWER_RESET_RESTART=y
> > # CONFIG_POWER_RESET_TPS65086 is not set
> > # CONFIG_POWER_RESET_KEYSTONE is not set
> > # CONFIG_POWER_RESET_RMOBILE is not set
> > # CONFIG_POWER_RESET_SC27XX is not set
> > CONFIG_POWER_SUPPLY=y
> > # CONFIG_POWER_SUPPLY_DEBUG is not set
> > # CONFIG_POWER_SUPPLY_HWMON is not set
> > # CONFIG_PDA_POWER is not set
> > CONFIG_GENERIC_ADC_BATTERY=y
> > # CONFIG_IP5XXX_POWER is not set
> > CONFIG_MAX8925_POWER=y
> > # CONFIG_WM831X_BACKUP is not set
> > CONFIG_WM831X_POWER=y
> > CONFIG_TEST_POWER=y
> > CONFIG_CHARGER_ADP5061=y
> > # CONFIG_BATTERY_ACT8945A is not set
> > CONFIG_BATTERY_CW2015=y
> > CONFIG_BATTERY_DS2760=y
> > CONFIG_BATTERY_DS2780=y
> > # CONFIG_BATTERY_DS2781 is not set
> > CONFIG_BATTERY_DS2782=y
> > CONFIG_BATTERY_SAMSUNG_SDI=y
> > CONFIG_BATTERY_WM97XX=y
> > CONFIG_BATTERY_SBS=y
> > CONFIG_CHARGER_SBS=y
> > CONFIG_MANAGER_SBS=y
> > CONFIG_BATTERY_BQ27XXX=y
> > CONFIG_BATTERY_BQ27XXX_I2C=y
> > # CONFIG_BATTERY_BQ27XXX_HDQ is not set
> > # CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
> > CONFIG_BATTERY_DA9030=y
> > CONFIG_BATTERY_MAX17040=y
> > CONFIG_BATTERY_MAX17042=y
> > # CONFIG_BATTERY_MAX1721X is not set
> > CONFIG_CHARGER_ISP1704=y
> > # CONFIG_CHARGER_MAX8903 is not set
> > # CONFIG_CHARGER_LP8727 is not set
> > CONFIG_CHARGER_GPIO=y
> > CONFIG_CHARGER_MANAGER=y
> > CONFIG_CHARGER_LT3651=y
> > CONFIG_CHARGER_LTC4162L=y
> > # CONFIG_CHARGER_MAX14577 is not set
> > CONFIG_CHARGER_MAX77976=y
> > CONFIG_CHARGER_MAX8997=y
> > # CONFIG_CHARGER_MP2629 is not set
> > CONFIG_CHARGER_MT6360=y
> > CONFIG_CHARGER_MT6370=y
> > # CONFIG_CHARGER_BQ2415X is not set
> > CONFIG_CHARGER_BQ24190=y
> > # CONFIG_CHARGER_BQ24257 is not set
> > CONFIG_CHARGER_BQ24735=y
> > CONFIG_CHARGER_BQ2515X=y
> > CONFIG_CHARGER_BQ25890=y
> > CONFIG_CHARGER_BQ25980=y
> > CONFIG_CHARGER_BQ256XX=y
> > CONFIG_CHARGER_SMB347=y
> > CONFIG_BATTERY_GAUGE_LTC2941=y
> > CONFIG_BATTERY_GOLDFISH=y
> > CONFIG_BATTERY_RT5033=y
> > # CONFIG_CHARGER_RT9455 is not set
> > # CONFIG_CHARGER_SC2731 is not set
> > # CONFIG_FUEL_GAUGE_SC27XX is not set
> > # CONFIG_CHARGER_BD99954 is not set
> > # CONFIG_BATTERY_UG3105 is not set
> > CONFIG_HWMON=y
> > CONFIG_HWMON_VID=y
> > # CONFIG_HWMON_DEBUG_CHIP is not set
> >
> > #
> > # Native drivers
> > #
> > CONFIG_SENSORS_AD7414=y
> > CONFIG_SENSORS_AD7418=y
> > CONFIG_SENSORS_ADM1025=y
> > CONFIG_SENSORS_ADM1026=y
> > CONFIG_SENSORS_ADM1029=y
> > CONFIG_SENSORS_ADM1031=y
> > CONFIG_SENSORS_ADM1177=y
> > CONFIG_SENSORS_ADM9240=y
> > # CONFIG_SENSORS_ADT7410 is not set
> > CONFIG_SENSORS_ADT7411=y
> > # CONFIG_SENSORS_ADT7462 is not set
> > CONFIG_SENSORS_ADT7470=y
> > CONFIG_SENSORS_ADT7475=y
> > CONFIG_SENSORS_AHT10=y
> > CONFIG_SENSORS_AQUACOMPUTER_D5NEXT=y
> > CONFIG_SENSORS_AS370=y
> > CONFIG_SENSORS_ASC7621=y
> > # CONFIG_SENSORS_AXI_FAN_CONTROL is not set
> > # CONFIG_SENSORS_ASB100 is not set
> > # CONFIG_SENSORS_ASPEED is not set
> > # CONFIG_SENSORS_ATXP1 is not set
> > # CONFIG_SENSORS_BT1_PVT is not set
> > CONFIG_SENSORS_CORSAIR_CPRO=y
> > CONFIG_SENSORS_CORSAIR_PSU=y
> > # CONFIG_SENSORS_DRIVETEMP is not set
> > CONFIG_SENSORS_DS620=y
> > CONFIG_SENSORS_DS1621=y
> > # CONFIG_SENSORS_DA9055 is not set
> > CONFIG_SENSORS_I5K_AMB=y
> > # CONFIG_SENSORS_SPARX5 is not set
> > # CONFIG_SENSORS_F71805F is not set
> > CONFIG_SENSORS_F71882FG=y
> > CONFIG_SENSORS_F75375S=y
> > CONFIG_SENSORS_MC13783_ADC=y
> > # CONFIG_SENSORS_FSCHMD is not set
> > CONFIG_SENSORS_FTSTEUTATES=y
> > # CONFIG_SENSORS_GL518SM is not set
> > CONFIG_SENSORS_GL520SM=y
> > CONFIG_SENSORS_G760A=y
> > CONFIG_SENSORS_G762=y
> > CONFIG_SENSORS_HIH6130=y
> > CONFIG_SENSORS_IIO_HWMON=y
> > # CONFIG_SENSORS_IT87 is not set
> > CONFIG_SENSORS_JC42=y
> > CONFIG_SENSORS_POWR1220=y
> > # CONFIG_SENSORS_LAN966X is not set
> > CONFIG_SENSORS_LINEAGE=y
> > CONFIG_SENSORS_LTC2945=y
> > # CONFIG_SENSORS_LTC2947_I2C is not set
> > CONFIG_SENSORS_LTC2990=y
> > CONFIG_SENSORS_LTC2992=y
> > CONFIG_SENSORS_LTC4151=y
> > # CONFIG_SENSORS_LTC4215 is not set
> > # CONFIG_SENSORS_LTC4222 is not set
> > CONFIG_SENSORS_LTC4245=y
> > CONFIG_SENSORS_LTC4260=y
> > CONFIG_SENSORS_LTC4261=y
> > CONFIG_SENSORS_MAX127=y
> > # CONFIG_SENSORS_MAX16065 is not set
> > CONFIG_SENSORS_MAX1619=y
> > CONFIG_SENSORS_MAX1668=y
> > CONFIG_SENSORS_MAX197=y
> > CONFIG_SENSORS_MAX31730=y
> > # CONFIG_SENSORS_MAX31760 is not set
> > # CONFIG_SENSORS_MAX6620 is not set
> > CONFIG_SENSORS_MAX6621=y
> > CONFIG_SENSORS_MAX6639=y
> > CONFIG_SENSORS_MAX6650=y
> > CONFIG_SENSORS_MAX6697=y
> > CONFIG_SENSORS_MAX31790=y
> > CONFIG_SENSORS_MCP3021=y
> > CONFIG_SENSORS_TC654=y
> > # CONFIG_SENSORS_TPS23861 is not set
> > CONFIG_SENSORS_MENF21BMC_HWMON=y
> > # CONFIG_SENSORS_MR75203 is not set
> > CONFIG_SENSORS_LM63=y
> > # CONFIG_SENSORS_LM73 is not set
> > CONFIG_SENSORS_LM75=y
> > CONFIG_SENSORS_LM77=y
> > # CONFIG_SENSORS_LM78 is not set
> > CONFIG_SENSORS_LM80=y
> > # CONFIG_SENSORS_LM83 is not set
> > CONFIG_SENSORS_LM85=y
> > CONFIG_SENSORS_LM87=y
> > CONFIG_SENSORS_LM90=y
> > # CONFIG_SENSORS_LM92 is not set
> > # CONFIG_SENSORS_LM93 is not set
> > CONFIG_SENSORS_LM95234=y
> > CONFIG_SENSORS_LM95241=y
> > CONFIG_SENSORS_LM95245=y
> > CONFIG_SENSORS_PC87360=y
> > CONFIG_SENSORS_PC87427=y
> > CONFIG_SENSORS_NTC_THERMISTOR=y
> > CONFIG_SENSORS_NCT6683=y
> > CONFIG_SENSORS_NCT6775_CORE=y
> > CONFIG_SENSORS_NCT6775=y
> > CONFIG_SENSORS_NCT6775_I2C=y
> > CONFIG_SENSORS_NCT7802=y
> > CONFIG_SENSORS_NCT7904=y
> > CONFIG_SENSORS_NPCM7XX=y
> > CONFIG_SENSORS_NZXT_KRAKEN2=y
> > CONFIG_SENSORS_NZXT_SMART2=y
> > CONFIG_SENSORS_OCC_P8_I2C=y
> > CONFIG_SENSORS_OCC=y
> > CONFIG_SENSORS_PCF8591=y
> > # CONFIG_SENSORS_PECI_CPUTEMP is not set
> > # CONFIG_SENSORS_PECI_DIMMTEMP is not set
> > CONFIG_PMBUS=y
> > CONFIG_SENSORS_PMBUS=y
> > # CONFIG_SENSORS_ADM1266 is not set
> > # CONFIG_SENSORS_ADM1275 is not set
> > CONFIG_SENSORS_BEL_PFE=y
> > CONFIG_SENSORS_BPA_RS600=y
> > CONFIG_SENSORS_DELTA_AHE50DC_FAN=y
> > # CONFIG_SENSORS_FSP_3Y is not set
> > CONFIG_SENSORS_IBM_CFFPS=y
> > CONFIG_SENSORS_DPS920AB=y
> > # CONFIG_SENSORS_INSPUR_IPSPS is not set
> > CONFIG_SENSORS_IR35221=y
> > # CONFIG_SENSORS_IR36021 is not set
> > CONFIG_SENSORS_IR38064=y
> > # CONFIG_SENSORS_IR38064_REGULATOR is not set
> > CONFIG_SENSORS_IRPS5401=y
> > CONFIG_SENSORS_ISL68137=y
> > # CONFIG_SENSORS_LM25066 is not set
> > CONFIG_SENSORS_LT7182S=y
> > CONFIG_SENSORS_LTC2978=y
> > # CONFIG_SENSORS_LTC2978_REGULATOR is not set
> > # CONFIG_SENSORS_LTC3815 is not set
> > CONFIG_SENSORS_MAX15301=y
> > CONFIG_SENSORS_MAX16064=y
> > # CONFIG_SENSORS_MAX16601 is not set
> > CONFIG_SENSORS_MAX20730=y
> > # CONFIG_SENSORS_MAX20751 is not set
> > CONFIG_SENSORS_MAX31785=y
> > CONFIG_SENSORS_MAX34440=y
> > CONFIG_SENSORS_MAX8688=y
> > # CONFIG_SENSORS_MP2888 is not set
> > CONFIG_SENSORS_MP2975=y
> > # CONFIG_SENSORS_MP5023 is not set
> > CONFIG_SENSORS_PIM4328=y
> > # CONFIG_SENSORS_PLI1209BC is not set
> > # CONFIG_SENSORS_PM6764TR is not set
> > CONFIG_SENSORS_PXE1610=y
> > CONFIG_SENSORS_Q54SJ108A2=y
> > # CONFIG_SENSORS_STPDDC60 is not set
> > CONFIG_SENSORS_TPS40422=y
> > # CONFIG_SENSORS_TPS53679 is not set
> > CONFIG_SENSORS_TPS546D24=y
> > CONFIG_SENSORS_UCD9000=y
> > CONFIG_SENSORS_UCD9200=y
> > CONFIG_SENSORS_XDPE152=y
> > CONFIG_SENSORS_XDPE122=y
> > # CONFIG_SENSORS_XDPE122_REGULATOR is not set
> > CONFIG_SENSORS_ZL6100=y
> > # CONFIG_SENSORS_PWM_FAN is not set
> > # CONFIG_SENSORS_RASPBERRYPI_HWMON is not set
> > # CONFIG_SENSORS_SL28CPLD is not set
> > # CONFIG_SENSORS_SBTSI is not set
> > CONFIG_SENSORS_SBRMI=y
> > # CONFIG_SENSORS_SHT15 is not set
> > CONFIG_SENSORS_SHT21=y
> > # CONFIG_SENSORS_SHT3x is not set
> > CONFIG_SENSORS_SHT4x=y
> > CONFIG_SENSORS_SHTC1=y
> > CONFIG_SENSORS_SIS5595=y
> > # CONFIG_SENSORS_DME1737 is not set
> > # CONFIG_SENSORS_EMC1403 is not set
> > # CONFIG_SENSORS_EMC2103 is not set
> > # CONFIG_SENSORS_EMC2305 is not set
> > CONFIG_SENSORS_EMC6W201=y
> > CONFIG_SENSORS_SMSC47M1=y
> > # CONFIG_SENSORS_SMSC47M192 is not set
> > CONFIG_SENSORS_SMSC47B397=y
> > CONFIG_SENSORS_SCH56XX_COMMON=y
> > CONFIG_SENSORS_SCH5627=y
> > CONFIG_SENSORS_SCH5636=y
> > # CONFIG_SENSORS_STTS751 is not set
> > CONFIG_SENSORS_SMM665=y
> > CONFIG_SENSORS_ADC128D818=y
> > CONFIG_SENSORS_ADS7828=y
> > CONFIG_SENSORS_AMC6821=y
> > CONFIG_SENSORS_INA209=y
> > CONFIG_SENSORS_INA2XX=y
> > CONFIG_SENSORS_INA238=y
> > CONFIG_SENSORS_INA3221=y
> > CONFIG_SENSORS_TC74=y
> > CONFIG_SENSORS_THMC50=y
> > CONFIG_SENSORS_TMP102=y
> > CONFIG_SENSORS_TMP103=y
> > # CONFIG_SENSORS_TMP108 is not set
> > CONFIG_SENSORS_TMP401=y
> > # CONFIG_SENSORS_TMP421 is not set
> > # CONFIG_SENSORS_TMP464 is not set
> > CONFIG_SENSORS_TMP513=y
> > # CONFIG_SENSORS_VIA686A is not set
> > CONFIG_SENSORS_VT1211=y
> > # CONFIG_SENSORS_VT8231 is not set
> > # CONFIG_SENSORS_W83773G is not set
> > CONFIG_SENSORS_W83781D=y
> > # CONFIG_SENSORS_W83791D is not set
> > CONFIG_SENSORS_W83792D=y
> > CONFIG_SENSORS_W83793=y
> > CONFIG_SENSORS_W83795=y
> > CONFIG_SENSORS_W83795_FANCTRL=y
> > # CONFIG_SENSORS_W83L785TS is not set
> > CONFIG_SENSORS_W83L786NG=y
> > CONFIG_SENSORS_W83627HF=y
> > # CONFIG_SENSORS_W83627EHF is not set
> > CONFIG_SENSORS_WM831X=y
> >
> > #
> > # ACPI drivers
> > #
> > # CONFIG_SENSORS_ACPI_POWER is not set
> > CONFIG_THERMAL=y
> > CONFIG_THERMAL_STATISTICS=y
> > CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> > # CONFIG_THERMAL_HWMON is not set
> > CONFIG_THERMAL_WRITABLE_TRIPS=y
> > CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> > # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> > # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> > CONFIG_THERMAL_GOV_FAIR_SHARE=y
> > CONFIG_THERMAL_GOV_STEP_WISE=y
> > # CONFIG_THERMAL_GOV_BANG_BANG is not set
> > CONFIG_THERMAL_GOV_USER_SPACE=y
> > # CONFIG_DEVFREQ_THERMAL is not set
> > CONFIG_THERMAL_EMULATION=y
> > # CONFIG_K3_THERMAL is not set
> > # CONFIG_ROCKCHIP_THERMAL is not set
> > # CONFIG_RCAR_THERMAL is not set
> > CONFIG_MTK_THERMAL=y
> >
> > #
> > # Intel thermal drivers
> > #
> >
> > #
> > # ACPI INT340X thermal drivers
> > #
> > # end of ACPI INT340X thermal drivers
> >
> > # CONFIG_INTEL_MENLOW is not set
> > # end of Intel thermal drivers
> >
> > #
> > # Broadcom thermal drivers
> > #
> > # CONFIG_BRCMSTB_THERMAL is not set
> > # CONFIG_BCM_NS_THERMAL is not set
> > # CONFIG_BCM_SR_THERMAL is not set
> > # end of Broadcom thermal drivers
> >
> > #
> > # Texas Instruments thermal drivers
> > #
> > # CONFIG_TI_SOC_THERMAL is not set
> > # end of Texas Instruments thermal drivers
> >
> > #
> > # Samsung thermal drivers
> > #
> > # end of Samsung thermal drivers
> >
> > #
> > # NVIDIA Tegra thermal drivers
> > #
> > # CONFIG_TEGRA_SOCTHERM is not set
> > # CONFIG_TEGRA_BPMP_THERMAL is not set
> > # CONFIG_TEGRA30_TSENSOR is not set
> > # end of NVIDIA Tegra thermal drivers
> >
> > CONFIG_GENERIC_ADC_THERMAL=y
> >
> > #
> > # Qualcomm thermal drivers
> > #
> > # end of Qualcomm thermal drivers
> >
> > # CONFIG_SPRD_THERMAL is not set
> > CONFIG_WATCHDOG=y
> > CONFIG_WATCHDOG_CORE=y
> > # CONFIG_WATCHDOG_NOWAYOUT is not set
> > # CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
> > CONFIG_WATCHDOG_OPEN_TIMEOUT=0
> > # CONFIG_WATCHDOG_SYSFS is not set
> > # CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set
> >
> > #
> > # Watchdog Pretimeout Governors
> > #
> > CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
> > CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=y
> > CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
> > CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
> > # CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
> > CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y
> >
> > #
> > # Watchdog Device Drivers
> > #
> > # CONFIG_SOFT_WATCHDOG is not set
> > # CONFIG_DA9052_WATCHDOG is not set
> > CONFIG_DA9055_WATCHDOG=y
> > # CONFIG_DA9063_WATCHDOG is not set
> > CONFIG_DA9062_WATCHDOG=y
> > CONFIG_MENF21BMC_WATCHDOG=y
> > CONFIG_MENZ069_WATCHDOG=y
> > CONFIG_WDAT_WDT=y
> > CONFIG_WM831X_WATCHDOG=y
> > CONFIG_XILINX_WATCHDOG=y
> > CONFIG_ZIIRAVE_WATCHDOG=y
> > # CONFIG_SL28CPLD_WATCHDOG is not set
> > # CONFIG_ARMADA_37XX_WATCHDOG is not set
> > # CONFIG_AT91RM9200_WATCHDOG is not set
> > # CONFIG_AT91SAM9X_WATCHDOG is not set
> > # CONFIG_SAMA5D4_WATCHDOG is not set
> > CONFIG_CADENCE_WATCHDOG=y
> > # CONFIG_FTWDT010_WATCHDOG is not set
> > # CONFIG_S3C2410_WATCHDOG is not set
> > CONFIG_DW_WATCHDOG=y
> > # CONFIG_EP93XX_WATCHDOG is not set
> > # CONFIG_OMAP_WATCHDOG is not set
> > # CONFIG_PNX4008_WATCHDOG is not set
> > # CONFIG_DAVINCI_WATCHDOG is not set
> > # CONFIG_K3_RTI_WATCHDOG is not set
> > # CONFIG_RN5T618_WATCHDOG is not set
> > # CONFIG_SUNXI_WATCHDOG is not set
> > # CONFIG_NPCM7XX_WATCHDOG is not set
> > # CONFIG_STMP3XXX_RTC_WATCHDOG is not set
> > # CONFIG_TS72XX_WATCHDOG is not set
> > CONFIG_MAX63XX_WATCHDOG=y
> > # CONFIG_MAX77620_WATCHDOG is not set
> > # CONFIG_IMX2_WDT is not set
> > # CONFIG_IMX7ULP_WDT is not set
> > CONFIG_RETU_WATCHDOG=y
> > # CONFIG_MOXART_WDT is not set
> > # CONFIG_TEGRA_WATCHDOG is not set
> > # CONFIG_QCOM_WDT is not set
> > # CONFIG_MESON_GXBB_WATCHDOG is not set
> > # CONFIG_MESON_WATCHDOG is not set
> > # CONFIG_MEDIATEK_WATCHDOG is not set
> > # CONFIG_DIGICOLOR_WATCHDOG is not set
> > # CONFIG_LPC18XX_WATCHDOG is not set
> > # CONFIG_RENESAS_WDT is not set
> > # CONFIG_RENESAS_RZAWDT is not set
> > # CONFIG_RENESAS_RZN1WDT is not set
> > # CONFIG_RENESAS_RZG2LWDT is not set
> > # CONFIG_ASPEED_WATCHDOG is not set
> > # CONFIG_REALTEK_OTTO_WDT is not set
> > # CONFIG_SPRD_WATCHDOG is not set
> > # CONFIG_VISCONTI_WATCHDOG is not set
> > # CONFIG_MSC313E_WATCHDOG is not set
> > # CONFIG_APPLE_WATCHDOG is not set
> > # CONFIG_SUNPLUS_WATCHDOG is not set
> > CONFIG_ALIM7101_WDT=y
> > # CONFIG_SC520_WDT is not set
> > # CONFIG_I6300ESB_WDT is not set
> > # CONFIG_KEMPLD_WDT is not set
> > # CONFIG_RDC321X_WDT is not set
> > # CONFIG_BCM47XX_WDT is not set
> > # CONFIG_BCM_KONA_WDT is not set
> > # CONFIG_BCM7038_WDT is not set
> > # CONFIG_IMGPDC_WDT is not set
> > # CONFIG_MPC5200_WDT is not set
> > CONFIG_MEN_A21_WDT=y
> > # CONFIG_UML_WATCHDOG is not set
> >
> > #
> > # PCI-based Watchdog Cards
> > #
> > CONFIG_PCIPCWATCHDOG=y
> > CONFIG_WDTPCI=y
> >
> > #
> > # USB-based Watchdog Cards
> > #
> > # CONFIG_USBPCWATCHDOG is not set
> > CONFIG_SSB_POSSIBLE=y
> > CONFIG_SSB=y
> > CONFIG_SSB_PCIHOST_POSSIBLE=y
> > # CONFIG_SSB_PCIHOST is not set
> > CONFIG_SSB_SDIOHOST_POSSIBLE=y
> > # CONFIG_SSB_SDIOHOST is not set
> > # CONFIG_SSB_DRIVER_GPIO is not set
> > CONFIG_BCMA_POSSIBLE=y
> > # CONFIG_BCMA is not set
> >
> > #
> > # Multifunction device drivers
> > #
> > CONFIG_MFD_CORE=y
> > # CONFIG_MFD_SUN4I_GPADC is not set
> > # CONFIG_MFD_AS3711 is not set
> > # CONFIG_PMIC_ADP5520 is not set
> > CONFIG_MFD_AAT2870_CORE=y
> > # CONFIG_MFD_AT91_USART is not set
> > # CONFIG_MFD_BCM590XX is not set
> > CONFIG_MFD_BD9571MWV=y
> > # CONFIG_MFD_AXP20X_I2C is not set
> > CONFIG_MFD_MADERA=y
> > # CONFIG_MFD_MADERA_I2C is not set
> > CONFIG_MFD_CS47L15=y
> > CONFIG_MFD_CS47L35=y
> > CONFIG_MFD_CS47L85=y
> > CONFIG_MFD_CS47L90=y
> > CONFIG_MFD_CS47L92=y
> > # CONFIG_MFD_ASIC3 is not set
> > CONFIG_PMIC_DA903X=y
> > # CONFIG_MFD_DA9052_I2C is not set
> > CONFIG_MFD_DA9055=y
> > CONFIG_MFD_DA9062=y
> > # CONFIG_MFD_DA9063 is not set
> > # CONFIG_MFD_DA9150 is not set
> > CONFIG_MFD_DLN2=y
> > # CONFIG_MFD_ENE_KB3930 is not set
> > # CONFIG_MFD_EXYNOS_LPASS is not set
> > CONFIG_MFD_MC13XXX=y
> > CONFIG_MFD_MC13XXX_I2C=y
> > CONFIG_MFD_MP2629=y
> > # CONFIG_MFD_MXS_LRADC is not set
> > # CONFIG_MFD_MX25_TSADC is not set
> > CONFIG_HTC_PASIC3=y
> > CONFIG_HTC_I2CPLD=y
> > CONFIG_LPC_ICH=y
> > CONFIG_LPC_SCH=y
> > # CONFIG_INTEL_SOC_PMIC is not set
> > # CONFIG_INTEL_SOC_PMIC_CHTWC is not set
> > CONFIG_MFD_IQS62X=y
> > CONFIG_MFD_JANZ_CMODIO=y
> > CONFIG_MFD_KEMPLD=y
> > CONFIG_MFD_88PM800=y
> > CONFIG_MFD_88PM805=y
> > # CONFIG_MFD_88PM860X is not set
> > CONFIG_MFD_MAX14577=y
> > # CONFIG_MFD_MAX77620 is not set
> > # CONFIG_MFD_MAX77650 is not set
> > # CONFIG_MFD_MAX77686 is not set
> > # CONFIG_MFD_MAX77693 is not set
> > # CONFIG_MFD_MAX77714 is not set
> > CONFIG_MFD_MAX77843=y
> > CONFIG_MFD_MAX8907=y
> > CONFIG_MFD_MAX8925=y
> > CONFIG_MFD_MAX8997=y
> > CONFIG_MFD_MAX8998=y
> > CONFIG_MFD_MT6360=y
> > CONFIG_MFD_MT6370=y
> > # CONFIG_MFD_MT6397 is not set
> > CONFIG_MFD_MENF21BMC=y
> > # CONFIG_MFD_VIPERBOARD is not set
> > # CONFIG_MFD_NTXEC is not set
> > CONFIG_MFD_RETU=y
> > # CONFIG_MFD_PCF50633 is not set
> > CONFIG_UCB1400_CORE=y
> > # CONFIG_MFD_PM8XXX is not set
> > # CONFIG_MFD_SY7636A is not set
> > CONFIG_MFD_RDC321X=y
> > # CONFIG_MFD_RT4831 is not set
> > CONFIG_MFD_RT5033=y
> > CONFIG_MFD_RT5120=y
> > # CONFIG_MFD_RC5T583 is not set
> > # CONFIG_MFD_SEC_CORE is not set
> > CONFIG_MFD_SI476X_CORE=y
> > CONFIG_MFD_SIMPLE_MFD_I2C=y
> > # CONFIG_MFD_SL28CPLD is not set
> > CONFIG_MFD_SM501=y
> > # CONFIG_MFD_SM501_GPIO is not set
> > # CONFIG_MFD_SKY81452 is not set
> > # CONFIG_ABX500_CORE is not set
> > # CONFIG_MFD_SUN6I_PRCM is not set
> > CONFIG_MFD_SYSCON=y
> > # CONFIG_MFD_TI_AM335X_TSCADC is not set
> > CONFIG_MFD_LP3943=y
> > CONFIG_MFD_LP8788=y
> > CONFIG_MFD_TI_LMU=y
> > CONFIG_MFD_PALMAS=y
> > CONFIG_TPS6105X=y
> > CONFIG_TPS65010=y
> > CONFIG_TPS6507X=y
> > CONFIG_MFD_TPS65086=y
> > # CONFIG_MFD_TPS65090 is not set
> > CONFIG_MFD_TI_LP873X=y
> > # CONFIG_MFD_TPS6586X is not set
> > CONFIG_MFD_TPS65910=y
> > # CONFIG_MFD_TPS65912_I2C is not set
> > # CONFIG_TWL4030_CORE is not set
> > # CONFIG_TWL6040_CORE is not set
> > # CONFIG_MFD_WL1273_CORE is not set
> > CONFIG_MFD_LM3533=y
> > # CONFIG_MFD_TIMBERDALE is not set
> > CONFIG_MFD_TQMX86=y
> > # CONFIG_MFD_VX855 is not set
> > # CONFIG_MFD_ARIZONA_I2C is not set
> > # CONFIG_MFD_WM8400 is not set
> > CONFIG_MFD_WM831X=y
> > CONFIG_MFD_WM831X_I2C=y
> > # CONFIG_MFD_WM8350_I2C is not set
> > CONFIG_MFD_WM8994=y
> > # CONFIG_MFD_STW481X is not set
> > # CONFIG_MFD_STM32_LPTIMER is not set
> > # CONFIG_MFD_STM32_TIMERS is not set
> > # CONFIG_MFD_STMFX is not set
> > # CONFIG_MFD_WCD934X is not set
> > CONFIG_MFD_ATC260X=y
> > CONFIG_MFD_ATC260X_I2C=y
> > # CONFIG_MFD_KHADAS_MCU is not set
> > # CONFIG_MFD_ACER_A500_EC is not set
> > # end of Multifunction device drivers
> >
> > CONFIG_REGULATOR=y
> > CONFIG_REGULATOR_DEBUG=y
> > CONFIG_REGULATOR_FIXED_VOLTAGE=y
> > CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
> > # CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
> > # CONFIG_REGULATOR_88PG86X is not set
> > CONFIG_REGULATOR_88PM800=y
> > # CONFIG_REGULATOR_ACT8865 is not set
> > CONFIG_REGULATOR_AD5398=y
> > # CONFIG_REGULATOR_ANATOP is not set
> > CONFIG_REGULATOR_AAT2870=y
> > CONFIG_REGULATOR_ARIZONA_LDO1=y
> > CONFIG_REGULATOR_ARIZONA_MICSUPP=y
> > # CONFIG_REGULATOR_ATC260X is not set
> > CONFIG_REGULATOR_BD9571MWV=y
> > CONFIG_REGULATOR_DA903X=y
> > CONFIG_REGULATOR_DA9055=y
> > # CONFIG_REGULATOR_DA9062 is not set
> > CONFIG_REGULATOR_DA9210=y
> > CONFIG_REGULATOR_DA9211=y
> > CONFIG_REGULATOR_FAN53555=y
> > # CONFIG_REGULATOR_FAN53880 is not set
> > # CONFIG_REGULATOR_GPIO is not set
> > # CONFIG_REGULATOR_ISL9305 is not set
> > CONFIG_REGULATOR_ISL6271A=y
> > # CONFIG_REGULATOR_LM363X is not set
> > CONFIG_REGULATOR_LP3971=y
> > CONFIG_REGULATOR_LP3972=y
> > CONFIG_REGULATOR_LP872X=y
> > CONFIG_REGULATOR_LP8755=y
> > # CONFIG_REGULATOR_LP8788 is not set
> > CONFIG_REGULATOR_LTC3589=y
> > CONFIG_REGULATOR_LTC3676=y
> > CONFIG_REGULATOR_MAX14577=y
> > CONFIG_REGULATOR_MAX1586=y
> > # CONFIG_REGULATOR_MAX77620 is not set
> > # CONFIG_REGULATOR_MAX77650 is not set
> > CONFIG_REGULATOR_MAX8649=y
> > CONFIG_REGULATOR_MAX8660=y
> > # CONFIG_REGULATOR_MAX8893 is not set
> > CONFIG_REGULATOR_MAX8907=y
> > CONFIG_REGULATOR_MAX8925=y
> > CONFIG_REGULATOR_MAX8952=y
> > CONFIG_REGULATOR_MAX8997=y
> > # CONFIG_REGULATOR_MAX8998 is not set
> > CONFIG_REGULATOR_MAX20086=y
> > # CONFIG_REGULATOR_MAX77686 is not set
> > # CONFIG_REGULATOR_MAX77693 is not set
> > # CONFIG_REGULATOR_MAX77802 is not set
> > CONFIG_REGULATOR_MAX77826=y
> > # CONFIG_REGULATOR_MC13783 is not set
> > # CONFIG_REGULATOR_MC13892 is not set
> > CONFIG_REGULATOR_MP8859=y
> > # CONFIG_REGULATOR_MP886X is not set
> > CONFIG_REGULATOR_MT6311=y
> > # CONFIG_REGULATOR_MT6360 is not set
> > CONFIG_REGULATOR_MT6370=y
> > CONFIG_REGULATOR_PALMAS=y
> > # CONFIG_REGULATOR_PBIAS is not set
> > # CONFIG_REGULATOR_PCA9450 is not set
> > # CONFIG_REGULATOR_PV88060 is not set
> > CONFIG_REGULATOR_PV88080=y
> > CONFIG_REGULATOR_PV88090=y
> > # CONFIG_REGULATOR_QCOM_RPMH is not set
> > # CONFIG_REGULATOR_QCOM_SPMI is not set
> > # CONFIG_REGULATOR_QCOM_USB_VBUS is not set
> > CONFIG_REGULATOR_RT4801=y
> > CONFIG_REGULATOR_RT5033=y
> > CONFIG_REGULATOR_RT5120=y
> > CONFIG_REGULATOR_RT5190A=y
> > # CONFIG_REGULATOR_RT5759 is not set
> > CONFIG_REGULATOR_RT6160=y
> > CONFIG_REGULATOR_RT6245=y
> > CONFIG_REGULATOR_RTQ2134=y
> > CONFIG_REGULATOR_RTMV20=y
> > # CONFIG_REGULATOR_RTQ6752 is not set
> > # CONFIG_REGULATOR_S2MPA01 is not set
> > # CONFIG_REGULATOR_S2MPS11 is not set
> > # CONFIG_REGULATOR_S5M8767 is not set
> > # CONFIG_REGULATOR_SC2731 is not set
> > # CONFIG_REGULATOR_SLG51000 is not set
> > # CONFIG_REGULATOR_STM32_BOOSTER is not set
> > # CONFIG_REGULATOR_STM32_VREFBUF is not set
> > # CONFIG_REGULATOR_STM32_PWR is not set
> > # CONFIG_REGULATOR_TI_ABB is not set
> > # CONFIG_REGULATOR_STW481X_VMMC is not set
> > # CONFIG_REGULATOR_SY8106A is not set
> > # CONFIG_REGULATOR_SY8824X is not set
> > # CONFIG_REGULATOR_SY8827N is not set
> > CONFIG_REGULATOR_TPS51632=y
> > # CONFIG_REGULATOR_TPS6105X is not set
> > CONFIG_REGULATOR_TPS62360=y
> > CONFIG_REGULATOR_TPS65023=y
> > CONFIG_REGULATOR_TPS6507X=y
> > # CONFIG_REGULATOR_TPS65086 is not set
> > CONFIG_REGULATOR_TPS65132=y
> > # CONFIG_REGULATOR_TPS65910 is not set
> > # CONFIG_REGULATOR_TPS68470 is not set
> > # CONFIG_REGULATOR_WM831X is not set
> > CONFIG_REGULATOR_WM8994=y
> > # CONFIG_REGULATOR_QCOM_LABIBB is not set
> > CONFIG_RC_CORE=y
> > CONFIG_LIRC=y
> > # CONFIG_RC_MAP is not set
> > # CONFIG_RC_DECODERS is not set
> > CONFIG_RC_DEVICES=y
> > # CONFIG_IR_ENE is not set
> > CONFIG_IR_FINTEK=y
> > # CONFIG_IR_GPIO_CIR is not set
> > # CONFIG_IR_GPIO_TX is not set
> > # CONFIG_IR_HIX5HD2 is not set
> > CONFIG_IR_IGORPLUGUSB=y
> > CONFIG_IR_IGUANA=y
> > CONFIG_IR_IMON=y
> > CONFIG_IR_IMON_RAW=y
> > CONFIG_IR_ITE_CIR=y
> > CONFIG_IR_MCEUSB=y
> > # CONFIG_IR_MESON is not set
> > # CONFIG_IR_MESON_TX is not set
> > # CONFIG_IR_MTK is not set
> > CONFIG_IR_NUVOTON=y
> > CONFIG_IR_REDRAT3=y
> > # CONFIG_IR_RX51 is not set
> > CONFIG_IR_SERIAL=y
> > # CONFIG_IR_SERIAL_TRANSMITTER is not set
> > # CONFIG_IR_STREAMZAP is not set
> > # CONFIG_IR_SUNXI is not set
> > CONFIG_IR_TOY=y
> > CONFIG_IR_TTUSBIR=y
> > # CONFIG_IR_WINBOND_CIR is not set
> > # CONFIG_RC_ATI_REMOTE is not set
> > # CONFIG_RC_LOOPBACK is not set
> > # CONFIG_RC_ST is not set
> > CONFIG_RC_XBOX_DVD=y
> > # CONFIG_IR_IMG is not set
> > CONFIG_CEC_CORE=y
> > CONFIG_CEC_NOTIFIER=y
> > CONFIG_CEC_PIN=y
> >
> > #
> > # CEC support
> > #
> > # CONFIG_MEDIA_CEC_RC is not set
> > CONFIG_CEC_PIN_ERROR_INJ=y
> > CONFIG_MEDIA_CEC_SUPPORT=y
> > # CONFIG_CEC_CH7322 is not set
> > # CONFIG_CEC_MESON_AO is not set
> > CONFIG_CEC_GPIO=y
> > # CONFIG_CEC_SAMSUNG_S5P is not set
> > # CONFIG_CEC_STI is not set
> > # CONFIG_CEC_STM32 is not set
> > # CONFIG_CEC_TEGRA is not set
> > # CONFIG_CEC_SECO is not set
> > # end of CEC support
> >
> > CONFIG_MEDIA_SUPPORT=y
> > CONFIG_MEDIA_SUPPORT_FILTER=y
> > CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
> >
> > #
> > # Media device types
> > #
> > CONFIG_MEDIA_CAMERA_SUPPORT=y
> > # CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
> > CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
> > # CONFIG_MEDIA_RADIO_SUPPORT is not set
> > CONFIG_MEDIA_SDR_SUPPORT=y
> > CONFIG_MEDIA_PLATFORM_SUPPORT=y
> > CONFIG_MEDIA_TEST_SUPPORT=y
> > # end of Media device types
> >
> > CONFIG_VIDEO_DEV=y
> > CONFIG_MEDIA_CONTROLLER=y
> > CONFIG_DVB_CORE=y
> >
> > #
> > # Video4Linux options
> > #
> > CONFIG_VIDEO_V4L2_I2C=y
> > CONFIG_VIDEO_V4L2_SUBDEV_API=y
> > CONFIG_VIDEO_ADV_DEBUG=y
> > # CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
> > CONFIG_VIDEO_TUNER=y
> > CONFIG_V4L2_MEM2MEM_DEV=y
> > CONFIG_V4L2_FWNODE=y
> > CONFIG_V4L2_ASYNC=y
> > # end of Video4Linux options
> >
> > #
> > # Media controller options
> > #
> > # CONFIG_MEDIA_CONTROLLER_DVB is not set
> > CONFIG_MEDIA_CONTROLLER_REQUEST_API=y
> > # end of Media controller options
> >
> > #
> > # Digital TV options
> > #
> > # CONFIG_DVB_MMAP is not set
> > CONFIG_DVB_MAX_ADAPTERS=16
> > CONFIG_DVB_DYNAMIC_MINORS=y
> > CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
> > CONFIG_DVB_ULE_DEBUG=y
> > # end of Digital TV options
> >
> > #
> > # Media drivers
> > #
> >
> > #
> > # Drivers filtered as selected at 'Filter media drivers'
> > #
> >
> > #
> > # Media drivers
> > #
> > # CONFIG_MEDIA_USB_SUPPORT is not set
> > CONFIG_MEDIA_PCI_SUPPORT=y
> >
> > #
> > # Media capture support
> > #
> > CONFIG_VIDEO_SOLO6X10=y
> > # CONFIG_STA2X11_VIP is not set
> > CONFIG_VIDEO_TW5864=y
> > CONFIG_VIDEO_TW68=y
> > # CONFIG_VIDEO_TW686X is not set
> > # CONFIG_VIDEO_ZORAN is not set
> >
> > #
> > # Media capture/analog/hybrid TV support
> > #
> > CONFIG_VIDEO_COBALT=y
> > # CONFIG_VIDEO_CX18 is not set
> > # CONFIG_VIDEO_CX23885 is not set
> > CONFIG_VIDEO_CX25821=y
> > CONFIG_VIDEO_CX25821_ALSA=y
> > # CONFIG_VIDEO_CX88 is not set
> > CONFIG_VIDEO_SAA7134=y
> > CONFIG_VIDEO_SAA7134_ALSA=y
> > # CONFIG_VIDEO_SAA7134_RC is not set
> > # CONFIG_VIDEO_SAA7134_DVB is not set
> > CONFIG_VIDEO_SAA7164=y
> >
> > #
> > # Media digital TV PCI Adapters
> > #
> > # CONFIG_DVB_B2C2_FLEXCOP_PCI is not set
> > # CONFIG_DVB_DDBRIDGE is not set
> > CONFIG_DVB_DM1105=y
> > CONFIG_MANTIS_CORE=y
> > # CONFIG_DVB_MANTIS is not set
> > CONFIG_DVB_HOPPER=y
> > # CONFIG_DVB_NGENE is not set
> > # CONFIG_DVB_PLUTO2 is not set
> > CONFIG_DVB_PT1=y
> > # CONFIG_DVB_PT3 is not set
> > CONFIG_DVB_SMIPCIE=y
> > CONFIG_MEDIA_PLATFORM_DRIVERS=y
> > CONFIG_V4L_PLATFORM_DRIVERS=y
> > CONFIG_SDR_PLATFORM_DRIVERS=y
> > # CONFIG_DVB_PLATFORM_DRIVERS is not set
> > CONFIG_V4L_MEM2MEM_DRIVERS=y
> > CONFIG_VIDEO_MEM2MEM_DEINTERLACE=y
> >
> > #
> > # Allegro DVT media platform drivers
> > #
> > # CONFIG_VIDEO_ALLEGRO_DVT is not set
> >
> > #
> > # Amlogic media platform drivers
> > #
> > # CONFIG_VIDEO_MESON_GE2D is not set
> >
> > #
> > # Amphion drivers
> > #
> > # CONFIG_VIDEO_AMPHION_VPU is not set
> >
> > #
> > # Aspeed media platform drivers
> > #
> > # CONFIG_VIDEO_ASPEED is not set
> >
> > #
> > # Atmel media platform drivers
> > #
> > # CONFIG_VIDEO_ATMEL_ISC is not set
> > # CONFIG_VIDEO_ATMEL_XISC is not set
> >
> > #
> > # Cadence media platform drivers
> > #
> > CONFIG_VIDEO_CADENCE_CSI2RX=y
> > CONFIG_VIDEO_CADENCE_CSI2TX=y
> >
> > #
> > # Chips&Media media platform drivers
> > #
> >
> > #
> > # Intel media platform drivers
> > #
> > # CONFIG_VIDEO_PXA27x is not set
> >
> > #
> > # Marvell media platform drivers
> > #
> > CONFIG_VIDEO_CAFE_CCIC=y
> > # CONFIG_VIDEO_MMP_CAMERA is not set
> >
> > #
> > # Mediatek media platform drivers
> > #
> > # CONFIG_VIDEO_MEDIATEK_JPEG is not set
> > # CONFIG_VIDEO_MEDIATEK_MDP is not set
> > # CONFIG_VIDEO_MEDIATEK_VPU is not set
> > # CONFIG_VIDEO_MEDIATEK_MDP3 is not set
> >
> > #
> > # NVidia media platform drivers
> > #
> > # CONFIG_VIDEO_TEGRA_VDE is not set
> >
> > #
> > # NXP media platform drivers
> > #
> > # CONFIG_VIDEO_IMX_MIPI_CSIS is not set
> > # CONFIG_VIDEO_IMX_PXP is not set
> > # CONFIG_VIDEO_MX2_EMMAPRP is not set
> > # CONFIG_VIDEO_DW100 is not set
> > # CONFIG_VIDEO_IMX8_JPEG is not set
> >
> > #
> > # Qualcomm media platform drivers
> > #
> > # CONFIG_VIDEO_QCOM_CAMSS is not set
> >
> > #
> > # Renesas media platform drivers
> > #
> > # CONFIG_VIDEO_RENESAS_CEU is not set
> > # CONFIG_VIDEO_SH_VOU is not set
> > # CONFIG_VIDEO_RENESAS_FDP1 is not set
> > # CONFIG_VIDEO_RENESAS_JPU is not set
> > # CONFIG_VIDEO_RENESAS_VSP1 is not set
> > # CONFIG_VIDEO_RCAR_DRIF is not set
> >
> > #
> > # Rockchip media platform drivers
> > #
> > # CONFIG_VIDEO_ROCKCHIP_RGA is not set
> >
> > #
> > # Samsung media platform drivers
> > #
> > # CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC is not set
> > # CONFIG_VIDEO_SAMSUNG_S5P_G2D is not set
> > # CONFIG_VIDEO_SAMSUNG_S5P_JPEG is not set
> > # CONFIG_VIDEO_SAMSUNG_S5P_MFC is not set
> >
> > #
> > # STMicroelectronics media platform drivers
> > #
> > # CONFIG_VIDEO_STI_BDISP is not set
> > # CONFIG_VIDEO_STI_DELTA is not set
> > # CONFIG_VIDEO_STI_HVA is not set
> > # CONFIG_VIDEO_STM32_DMA2D is not set
> >
> > #
> > # Sunxi media platform drivers
> > #
> > # CONFIG_VIDEO_SUN4I_CSI is not set
> > # CONFIG_VIDEO_SUN6I_CSI is not set
> >
> > #
> > # Texas Instruments drivers
> > #
> > # CONFIG_VIDEO_TI_CAL is not set
> > # CONFIG_VIDEO_TI_VPE is not set
> > # CONFIG_VIDEO_AM437X_VPFE is not set
> > # CONFIG_VIDEO_DAVINCI_VPIF_DISPLAY is not set
> > # CONFIG_VIDEO_DAVINCI_VPIF_CAPTURE is not set
> > # CONFIG_VIDEO_DAVINCI_VPBE_DISPLAY is not set
> > # CONFIG_VIDEO_OMAP2_VOUT is not set
> >
> > #
> > # Verisilicon media platform drivers
> > #
> > # CONFIG_VIDEO_HANTRO is not set
> >
> > #
> > # VIA media platform drivers
> > #
> >
> > #
> > # Xilinx media platform drivers
> > #
> >
> > #
> > # MMC/SDIO DVB adapters
> > #
> > CONFIG_SMS_SDIO_DRV=y
> > CONFIG_V4L_TEST_DRIVERS=y
> > CONFIG_VIDEO_VIM2M=y
> > CONFIG_VIDEO_VICODEC=y
> > CONFIG_VIDEO_VIMC=y
> > # CONFIG_DVB_TEST_DRIVERS is not set
> > CONFIG_MEDIA_COMMON_OPTIONS=y
> >
> > #
> > # common driver options
> > #
> > CONFIG_VIDEO_TVEEPROM=y
> > CONFIG_SMS_SIANO_MDTV=y
> > # CONFIG_SMS_SIANO_RC is not set
> > CONFIG_VIDEO_V4L2_TPG=y
> > CONFIG_VIDEOBUF2_CORE=y
> > CONFIG_VIDEOBUF2_V4L2=y
> > CONFIG_VIDEOBUF2_MEMOPS=y
> > CONFIG_VIDEOBUF2_DMA_CONTIG=y
> > CONFIG_VIDEOBUF2_VMALLOC=y
> > CONFIG_VIDEOBUF2_DMA_SG=y
> > # end of Media drivers
> >
> > #
> > # Media ancillary drivers
> > #
> >
> > #
> > # IR I2C driver auto-selected by 'Autoselect ancillary drivers'
> > #
> > # CONFIG_VIDEO_IR_I2C is not set
> >
> > #
> > # Camera sensor devices
> > #
> > CONFIG_VIDEO_CCS_PLL=y
> > CONFIG_VIDEO_AR0521=y
> > CONFIG_VIDEO_HI556=y
> > CONFIG_VIDEO_HI846=y
> > # CONFIG_VIDEO_HI847 is not set
> > CONFIG_VIDEO_IMX208=y
> > CONFIG_VIDEO_IMX214=y
> > CONFIG_VIDEO_IMX219=y
> > CONFIG_VIDEO_IMX258=y
> > CONFIG_VIDEO_IMX274=y
> > CONFIG_VIDEO_IMX290=y
> > # CONFIG_VIDEO_IMX319 is not set
> > CONFIG_VIDEO_IMX355=y
> > CONFIG_VIDEO_MAX9271_LIB=y
> > CONFIG_VIDEO_MT9M001=y
> > # CONFIG_VIDEO_MT9M032 is not set
> > CONFIG_VIDEO_MT9M111=y
> > # CONFIG_VIDEO_MT9P031 is not set
> > # CONFIG_VIDEO_MT9T001 is not set
> > CONFIG_VIDEO_MT9T112=y
> > CONFIG_VIDEO_MT9V011=y
> > CONFIG_VIDEO_MT9V032=y
> > CONFIG_VIDEO_MT9V111=y
> > CONFIG_VIDEO_NOON010PC30=y
> > CONFIG_VIDEO_OG01A1B=y
> > # CONFIG_VIDEO_OV02A10 is not set
> > # CONFIG_VIDEO_OV08D10 is not set
> > CONFIG_VIDEO_OV13858=y
> > # CONFIG_VIDEO_OV13B10 is not set
> > CONFIG_VIDEO_OV2640=y
> > CONFIG_VIDEO_OV2659=y
> > CONFIG_VIDEO_OV2680=y
> > CONFIG_VIDEO_OV2685=y
> > # CONFIG_VIDEO_OV2740 is not set
> > CONFIG_VIDEO_OV5647=y
> > CONFIG_VIDEO_OV5670=y
> > # CONFIG_VIDEO_OV5675 is not set
> > CONFIG_VIDEO_OV5693=y
> > CONFIG_VIDEO_OV5695=y
> > CONFIG_VIDEO_OV6650=y
> > # CONFIG_VIDEO_OV7251 is not set
> > CONFIG_VIDEO_OV7640=y
> > CONFIG_VIDEO_OV7670=y
> > # CONFIG_VIDEO_OV772X is not set
> > CONFIG_VIDEO_OV7740=y
> > CONFIG_VIDEO_OV8856=y
> > CONFIG_VIDEO_OV9640=y
> > # CONFIG_VIDEO_OV9650 is not set
> > CONFIG_VIDEO_OV9734=y
> > CONFIG_VIDEO_RDACM20=y
> > CONFIG_VIDEO_RDACM21=y
> > CONFIG_VIDEO_RJ54N1=y
> > # CONFIG_VIDEO_S5K4ECGX is not set
> > CONFIG_VIDEO_S5K5BAF=y
> > CONFIG_VIDEO_S5K6A3=y
> > CONFIG_VIDEO_S5K6AA=y
> > CONFIG_VIDEO_SR030PC30=y
> > CONFIG_VIDEO_VS6624=y
> > CONFIG_VIDEO_CCS=y
> > CONFIG_VIDEO_ET8EK8=y
> > CONFIG_VIDEO_M5MOLS=y
> > # end of Camera sensor devices
> >
> > #
> > # Lens drivers
> > #
> > CONFIG_VIDEO_AD5820=y
> > CONFIG_VIDEO_AK7375=y
> > CONFIG_VIDEO_DW9714=y
> > CONFIG_VIDEO_DW9768=y
> > CONFIG_VIDEO_DW9807_VCM=y
> > # end of Lens drivers
> >
> > #
> > # Flash devices
> > #
> > CONFIG_VIDEO_ADP1653=y
> > CONFIG_VIDEO_LM3560=y
> > CONFIG_VIDEO_LM3646=y
> > # end of Flash devices
> >
> > #
> > # Audio decoders, processors and mixers
> > #
> > CONFIG_VIDEO_CS3308=y
> > CONFIG_VIDEO_CS5345=y
> > # CONFIG_VIDEO_CS53L32A is not set
> > # CONFIG_VIDEO_MSP3400 is not set
> > CONFIG_VIDEO_SONY_BTF_MPX=y
> > # CONFIG_VIDEO_TDA1997X is not set
> > CONFIG_VIDEO_TDA7432=y
> > CONFIG_VIDEO_TDA9840=y
> > CONFIG_VIDEO_TEA6415C=y
> > CONFIG_VIDEO_TEA6420=y
> > CONFIG_VIDEO_TLV320AIC23B=y
> > # CONFIG_VIDEO_TVAUDIO is not set
> > CONFIG_VIDEO_UDA1342=y
> > CONFIG_VIDEO_VP27SMPX=y
> > CONFIG_VIDEO_WM8739=y
> > # CONFIG_VIDEO_WM8775 is not set
> > # end of Audio decoders, processors and mixers
> >
> > #
> > # RDS decoders
> > #
> > CONFIG_VIDEO_SAA6588=y
> > # end of RDS decoders
> >
> > #
> > # Video decoders
> > #
> > # CONFIG_VIDEO_ADV7180 is not set
> > # CONFIG_VIDEO_ADV7183 is not set
> > CONFIG_VIDEO_ADV7604=y
> > CONFIG_VIDEO_ADV7604_CEC=y
> > CONFIG_VIDEO_ADV7842=y
> > CONFIG_VIDEO_ADV7842_CEC=y
> > CONFIG_VIDEO_BT819=y
> > CONFIG_VIDEO_BT856=y
> > CONFIG_VIDEO_BT866=y
> > CONFIG_VIDEO_KS0127=y
> > CONFIG_VIDEO_ML86V7667=y
> > CONFIG_VIDEO_SAA7110=y
> > # CONFIG_VIDEO_SAA711X is not set
> > # CONFIG_VIDEO_TC358743 is not set
> > CONFIG_VIDEO_TVP514X=y
> > CONFIG_VIDEO_TVP5150=y
> > # CONFIG_VIDEO_TVP7002 is not set
> > CONFIG_VIDEO_TW2804=y
> > CONFIG_VIDEO_TW9903=y
> > CONFIG_VIDEO_TW9906=y
> > CONFIG_VIDEO_TW9910=y
> > # CONFIG_VIDEO_VPX3220 is not set
> >
> > #
> > # Video and audio decoders
> > #
> > CONFIG_VIDEO_SAA717X=y
> > CONFIG_VIDEO_CX25840=y
> > # end of Video decoders
> >
> > #
> > # Video encoders
> > #
> > # CONFIG_VIDEO_AD9389B is not set
> > # CONFIG_VIDEO_ADV7170 is not set
> > CONFIG_VIDEO_ADV7175=y
> > CONFIG_VIDEO_ADV7343=y
> > CONFIG_VIDEO_ADV7393=y
> > CONFIG_VIDEO_ADV7511=y
> > CONFIG_VIDEO_ADV7511_CEC=y
> > CONFIG_VIDEO_AK881X=y
> > CONFIG_VIDEO_SAA7127=y
> > CONFIG_VIDEO_SAA7185=y
> > CONFIG_VIDEO_THS8200=y
> > # end of Video encoders
> >
> > #
> > # Video improvement chips
> > #
> > CONFIG_VIDEO_UPD64031A=y
> > CONFIG_VIDEO_UPD64083=y
> > # end of Video improvement chips
> >
> > #
> > # Audio/Video compression chips
> > #
> > CONFIG_VIDEO_SAA6752HS=y
> > # end of Audio/Video compression chips
> >
> > #
> > # SDR tuner chips
> > #
> > CONFIG_SDR_MAX2175=y
> > # end of SDR tuner chips
> >
> > #
> > # Miscellaneous helper chips
> > #
> > CONFIG_VIDEO_I2C=y
> > CONFIG_VIDEO_M52790=y
> > CONFIG_VIDEO_ST_MIPID02=y
> > CONFIG_VIDEO_THS7303=y
> > # end of Miscellaneous helper chips
> >
> > CONFIG_MEDIA_TUNER=y
> >
> > #
> > # Customize TV tuners
> > #
> > CONFIG_MEDIA_TUNER_E4000=y
> > CONFIG_MEDIA_TUNER_FC0011=y
> > CONFIG_MEDIA_TUNER_FC0012=y
> > CONFIG_MEDIA_TUNER_FC0013=y
> > CONFIG_MEDIA_TUNER_FC2580=y
> > CONFIG_MEDIA_TUNER_IT913X=y
> > CONFIG_MEDIA_TUNER_M88RS6000T=y
> > CONFIG_MEDIA_TUNER_MAX2165=y
> > CONFIG_MEDIA_TUNER_MC44S803=y
> > # CONFIG_MEDIA_TUNER_MT2060 is not set
> > CONFIG_MEDIA_TUNER_MT2063=y
> > CONFIG_MEDIA_TUNER_MT20XX=y
> > CONFIG_MEDIA_TUNER_MT2131=y
> > CONFIG_MEDIA_TUNER_MT2266=y
> > # CONFIG_MEDIA_TUNER_MXL301RF is not set
> > CONFIG_MEDIA_TUNER_MXL5005S=y
> > CONFIG_MEDIA_TUNER_MXL5007T=y
> > CONFIG_MEDIA_TUNER_QM1D1B0004=y
> > CONFIG_MEDIA_TUNER_QM1D1C0042=y
> > CONFIG_MEDIA_TUNER_QT1010=y
> > # CONFIG_MEDIA_TUNER_R820T is not set
> > CONFIG_MEDIA_TUNER_SI2157=y
> > CONFIG_MEDIA_TUNER_SIMPLE=y
> > CONFIG_MEDIA_TUNER_TDA18212=y
> > CONFIG_MEDIA_TUNER_TDA18218=y
> > CONFIG_MEDIA_TUNER_TDA18250=y
> > CONFIG_MEDIA_TUNER_TDA18271=y
> > CONFIG_MEDIA_TUNER_TDA827X=y
> > CONFIG_MEDIA_TUNER_TDA8290=y
> > CONFIG_MEDIA_TUNER_TDA9887=y
> > CONFIG_MEDIA_TUNER_TEA5761=y
> > CONFIG_MEDIA_TUNER_TEA5767=y
> > # CONFIG_MEDIA_TUNER_TUA9001 is not set
> > CONFIG_MEDIA_TUNER_XC2028=y
> > CONFIG_MEDIA_TUNER_XC4000=y
> > CONFIG_MEDIA_TUNER_XC5000=y
> > # end of Customize TV tuners
> >
> > #
> > # Customise DVB Frontends
> > #
> >
> > #
> > # Multistandard (satellite) frontends
> > #
> > CONFIG_DVB_M88DS3103=y
> > CONFIG_DVB_MXL5XX=y
> > CONFIG_DVB_STB0899=y
> > CONFIG_DVB_STB6100=y
> > CONFIG_DVB_STV090x=y
> > CONFIG_DVB_STV0910=y
> > CONFIG_DVB_STV6110x=y
> > # CONFIG_DVB_STV6111 is not set
> >
> > #
> > # Multistandard (cable + terrestrial) frontends
> > #
> > # CONFIG_DVB_DRXK is not set
> > # CONFIG_DVB_MN88472 is not set
> > CONFIG_DVB_MN88473=y
> > CONFIG_DVB_SI2165=y
> > # CONFIG_DVB_TDA18271C2DD is not set
> >
> > #
> > # DVB-S (satellite) frontends
> > #
> > # CONFIG_DVB_CX24110 is not set
> > CONFIG_DVB_CX24116=y
> > CONFIG_DVB_CX24117=y
> > # CONFIG_DVB_CX24120 is not set
> > CONFIG_DVB_CX24123=y
> > CONFIG_DVB_DS3000=y
> > CONFIG_DVB_MB86A16=y
> > # CONFIG_DVB_MT312 is not set
> > CONFIG_DVB_S5H1420=y
> > CONFIG_DVB_SI21XX=y
> > CONFIG_DVB_STB6000=y
> > CONFIG_DVB_STV0288=y
> > CONFIG_DVB_STV0299=y
> > # CONFIG_DVB_STV0900 is not set
> > CONFIG_DVB_STV6110=y
> > CONFIG_DVB_TDA10071=y
> > CONFIG_DVB_TDA10086=y
> > CONFIG_DVB_TDA8083=y
> > # CONFIG_DVB_TDA8261 is not set
> > CONFIG_DVB_TDA826X=y
> > CONFIG_DVB_TS2020=y
> > CONFIG_DVB_TUA6100=y
> > # CONFIG_DVB_TUNER_CX24113 is not set
> > CONFIG_DVB_TUNER_ITD1000=y
> > CONFIG_DVB_VES1X93=y
> > CONFIG_DVB_ZL10036=y
> > CONFIG_DVB_ZL10039=y
> >
> > #
> > # DVB-T (terrestrial) frontends
> > #
> > CONFIG_DVB_AF9013=y
> > CONFIG_DVB_CX22700=y
> > # CONFIG_DVB_CX22702 is not set
> > # CONFIG_DVB_CXD2820R is not set
> > # CONFIG_DVB_CXD2841ER is not set
> > CONFIG_DVB_DIB3000MB=y
> > CONFIG_DVB_DIB3000MC=y
> > CONFIG_DVB_DIB7000M=y
> > CONFIG_DVB_DIB7000P=y
> > CONFIG_DVB_DIB9000=y
> > CONFIG_DVB_DRXD=y
> > CONFIG_DVB_EC100=y
> > CONFIG_DVB_L64781=y
> > CONFIG_DVB_MT352=y
> > # CONFIG_DVB_NXT6000 is not set
> > CONFIG_DVB_RTL2830=y
> > CONFIG_DVB_RTL2832=y
> > CONFIG_DVB_RTL2832_SDR=y
> > # CONFIG_DVB_S5H1432 is not set
> > CONFIG_DVB_SI2168=y
> > CONFIG_DVB_SP887X=y
> > # CONFIG_DVB_STV0367 is not set
> > CONFIG_DVB_TDA10048=y
> > CONFIG_DVB_TDA1004X=y
> > CONFIG_DVB_ZD1301_DEMOD=y
> > CONFIG_DVB_ZL10353=y
> >
> > #
> > # DVB-C (cable) frontends
> > #
> > CONFIG_DVB_STV0297=y
> > CONFIG_DVB_TDA10021=y
> > CONFIG_DVB_TDA10023=y
> > CONFIG_DVB_VES1820=y
> >
> > #
> > # ATSC (North American/Korean Terrestrial/Cable DTV) frontends
> > #
> > # CONFIG_DVB_AU8522_DTV is not set
> > # CONFIG_DVB_AU8522_V4L is not set
> > CONFIG_DVB_BCM3510=y
> > # CONFIG_DVB_LG2160 is not set
> > # CONFIG_DVB_LGDT3305 is not set
> > # CONFIG_DVB_LGDT3306A is not set
> > CONFIG_DVB_LGDT330X=y
> > CONFIG_DVB_MXL692=y
> > # CONFIG_DVB_NXT200X is not set
> > # CONFIG_DVB_OR51132 is not set
> > # CONFIG_DVB_OR51211 is not set
> > # CONFIG_DVB_S5H1409 is not set
> > CONFIG_DVB_S5H1411=y
> >
> > #
> > # ISDB-T (terrestrial) frontends
> > #
> > CONFIG_DVB_DIB8000=y
> > # CONFIG_DVB_MB86A20S is not set
> > # CONFIG_DVB_S921 is not set
> >
> > #
> > # ISDB-S (satellite) & ISDB-T (terrestrial) frontends
> > #
> > CONFIG_DVB_MN88443X=y
> > CONFIG_DVB_TC90522=y
> >
> > #
> > # Digital terrestrial only tuners/PLL
> > #
> > CONFIG_DVB_PLL=y
> > # CONFIG_DVB_TUNER_DIB0070 is not set
> > CONFIG_DVB_TUNER_DIB0090=y
> >
> > #
> > # SEC control devices for DVB-S
> > #
> > CONFIG_DVB_A8293=y
> > # CONFIG_DVB_AF9033 is not set
> > CONFIG_DVB_ASCOT2E=y
> > CONFIG_DVB_ATBM8830=y
> > CONFIG_DVB_HELENE=y
> > # CONFIG_DVB_HORUS3A is not set
> > CONFIG_DVB_ISL6405=y
> > CONFIG_DVB_ISL6421=y
> > CONFIG_DVB_ISL6423=y
> > # CONFIG_DVB_IX2505V is not set
> > CONFIG_DVB_LGS8GL5=y
> > CONFIG_DVB_LGS8GXX=y
> > CONFIG_DVB_LNBH25=y
> > CONFIG_DVB_LNBH29=y
> > CONFIG_DVB_LNBP21=y
> > CONFIG_DVB_LNBP22=y
> > CONFIG_DVB_M88RS2000=y
> > # CONFIG_DVB_TDA665x is not set
> > # CONFIG_DVB_DRX39XYJ is not set
> >
> > #
> > # Common Interface (EN50221) controller drivers
> > #
> > # CONFIG_DVB_CXD2099 is not set
> > CONFIG_DVB_SP2=y
> > # end of Customise DVB Frontends
> >
> > #
> > # Tools to develop new frontends
> > #
> > CONFIG_DVB_DUMMY_FE=y
> > # end of Media ancillary drivers
> >
> > #
> > # Graphics support
> > #
> > # CONFIG_IMX_IPUV3_CORE is not set
> > CONFIG_DRM=y
> > CONFIG_DRM_DEBUG_MM=y
> > CONFIG_DRM_KUNIT_TEST=y
> > CONFIG_DRM_KMS_HELPER=y
> > CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS=y
> > CONFIG_DRM_DEBUG_MODESET_LOCK=y
> > # CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
> > CONFIG_DRM_DISPLAY_HELPER=y
> > CONFIG_DRM_DISPLAY_DP_HELPER=y
> > CONFIG_DRM_DISPLAY_HDMI_HELPER=y
> > # CONFIG_DRM_DP_AUX_CHARDEV is not set
> > CONFIG_DRM_DP_CEC=y
> > CONFIG_DRM_TTM=y
> > CONFIG_DRM_BUDDY=y
> > CONFIG_DRM_VRAM_HELPER=y
> > CONFIG_DRM_TTM_HELPER=y
> > CONFIG_DRM_GEM_SHMEM_HELPER=y
> > CONFIG_DRM_SCHED=y
> >
> > #
> > # I2C encoder or helper chips
> > #
> > # CONFIG_DRM_I2C_CH7006 is not set
> > # CONFIG_DRM_I2C_SIL164 is not set
> > CONFIG_DRM_I2C_NXP_TDA998X=y
> > CONFIG_DRM_I2C_NXP_TDA9950=y
> > # end of I2C encoder or helper chips
> >
> > #
> > # ARM devices
> > #
> > # end of ARM devices
> >
> > CONFIG_DRM_RADEON=y
> > # CONFIG_DRM_RADEON_USERPTR is not set
> > CONFIG_DRM_AMDGPU=y
> > CONFIG_DRM_AMDGPU_SI=y
> > CONFIG_DRM_AMDGPU_CIK=y
> > CONFIG_DRM_AMDGPU_USERPTR=y
> >
> > #
> > # ACP (Audio CoProcessor) Configuration
> > #
> > CONFIG_DRM_AMD_ACP=y
> > # end of ACP (Audio CoProcessor) Configuration
> >
> > #
> > # Display Engine Configuration
> > #
> > # CONFIG_DRM_AMD_DC is not set
> > # end of Display Engine Configuration
> >
> > CONFIG_DRM_NOUVEAU=y
> > # CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT is not set
> > CONFIG_NOUVEAU_DEBUG=5
> > CONFIG_NOUVEAU_DEBUG_DEFAULT=3
> > # CONFIG_NOUVEAU_DEBUG_MMU is not set
> > CONFIG_NOUVEAU_DEBUG_PUSH=y
> > # CONFIG_DRM_NOUVEAU_BACKLIGHT is not set
> > # CONFIG_DRM_KMB_DISPLAY is not set
> > CONFIG_DRM_VGEM=y
> > CONFIG_DRM_VKMS=y
> > # CONFIG_DRM_UDL is not set
> > CONFIG_DRM_AST=y
> > # CONFIG_DRM_MGAG200 is not set
> > # CONFIG_DRM_SUN4I is not set
> > # CONFIG_DRM_QXL is not set
> > CONFIG_DRM_VIRTIO_GPU=y
> > # CONFIG_DRM_MSM is not set
> > CONFIG_DRM_PANEL=y
> >
> > #
> > # Display Panels
> > #
> > # end of Display Panels
> >
> > CONFIG_DRM_BRIDGE=y
> > CONFIG_DRM_PANEL_BRIDGE=y
> >
> > #
> > # Display Interface Bridges
> > #
> > CONFIG_DRM_ANALOGIX_ANX78XX=y
> > CONFIG_DRM_ANALOGIX_DP=y
> > # end of Display Interface Bridges
> >
> > # CONFIG_DRM_V3D is not set
> > CONFIG_DRM_ETNAVIV=y
> > CONFIG_DRM_ETNAVIV_THERMAL=y
> > # CONFIG_DRM_HISI_HIBMC is not set
> > # CONFIG_DRM_LOGICVC is not set
> > CONFIG_DRM_BOCHS=y
> > # CONFIG_DRM_CIRRUS_QEMU is not set
> > # CONFIG_DRM_GM12U320 is not set
> > # CONFIG_DRM_SIMPLEDRM is not set
> > # CONFIG_DRM_PL111 is not set
> > # CONFIG_DRM_PANFROST is not set
> > CONFIG_DRM_GUD=y
> > CONFIG_DRM_SSD130X=y
> > CONFIG_DRM_SSD130X_I2C=y
> > # CONFIG_DRM_LEGACY is not set
> > CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
> > CONFIG_DRM_NOMODESET=y
> > CONFIG_DRM_LIB_RANDOM=y
> >
> > #
> > # Frame buffer Devices
> > #
> > CONFIG_FB_CMDLINE=y
> > # CONFIG_FB is not set
> > CONFIG_FB_OMAP_LCD_H3=y
> > # CONFIG_MMP_DISP is not set
> > # end of Frame buffer Devices
> >
> > #
> > # Backlight & LCD device support
> > #
> > # CONFIG_LCD_CLASS_DEVICE is not set
> > CONFIG_BACKLIGHT_CLASS_DEVICE=y
> > # CONFIG_BACKLIGHT_KTD253 is not set
> > CONFIG_BACKLIGHT_LM3533=y
> > # CONFIG_BACKLIGHT_OMAP1 is not set
> > # CONFIG_BACKLIGHT_DA903X is not set
> > CONFIG_BACKLIGHT_MAX8925=y
> > # CONFIG_BACKLIGHT_MT6370 is not set
> > CONFIG_BACKLIGHT_QCOM_WLED=y
> > CONFIG_BACKLIGHT_WM831X=y
> > CONFIG_BACKLIGHT_ADP8860=y
> > # CONFIG_BACKLIGHT_ADP8870 is not set
> > # CONFIG_BACKLIGHT_AAT2870 is not set
> > # CONFIG_BACKLIGHT_LM3639 is not set
> > # CONFIG_BACKLIGHT_GPIO is not set
> > CONFIG_BACKLIGHT_LV5207LP=y
> > CONFIG_BACKLIGHT_BD6107=y
> > # CONFIG_BACKLIGHT_ARCXCNN is not set
> > # end of Backlight & LCD device support
> >
> > CONFIG_HDMI=y
> > # end of Graphics support
> >
> > CONFIG_SOUND=y
> > CONFIG_SOUND_OSS_CORE=y
> > CONFIG_SOUND_OSS_CORE_PRECLAIM=y
> > CONFIG_SND=y
> > CONFIG_SND_TIMER=y
> > CONFIG_SND_PCM=y
> > CONFIG_SND_PCM_ELD=y
> > CONFIG_SND_PCM_IEC958=y
> > CONFIG_SND_DMAENGINE_PCM=y
> > CONFIG_SND_HWDEP=y
> > CONFIG_SND_SEQ_DEVICE=y
> > CONFIG_SND_RAWMIDI=y
> > CONFIG_SND_COMPRESS_OFFLOAD=y
> > CONFIG_SND_JACK=y
> > CONFIG_SND_JACK_INPUT_DEV=y
> > CONFIG_SND_OSSEMUL=y
> > # CONFIG_SND_MIXER_OSS is not set
> > CONFIG_SND_PCM_OSS=y
> > # CONFIG_SND_PCM_OSS_PLUGINS is not set
> > CONFIG_SND_PCM_TIMER=y
> > CONFIG_SND_DYNAMIC_MINORS=y
> > CONFIG_SND_MAX_CARDS=32
> > CONFIG_SND_SUPPORT_OLD_API=y
> > CONFIG_SND_VERBOSE_PRINTK=y
> > # CONFIG_SND_CTL_FAST_LOOKUP is not set
> > CONFIG_SND_DEBUG=y
> > CONFIG_SND_DEBUG_VERBOSE=y
> > # CONFIG_SND_CTL_INPUT_VALIDATION is not set
> > CONFIG_SND_CTL_DEBUG=y
> > # CONFIG_SND_JACK_INJECTION_DEBUG is not set
> > CONFIG_SND_VMASTER=y
> > CONFIG_SND_SEQUENCER=y
> > # CONFIG_SND_SEQ_DUMMY is not set
> > CONFIG_SND_SEQUENCER_OSS=y
> > CONFIG_SND_SEQ_MIDI_EVENT=y
> > CONFIG_SND_SEQ_MIDI=y
> > CONFIG_SND_SEQ_MIDI_EMUL=y
> > CONFIG_SND_MPU401_UART=y
> > CONFIG_SND_OPL3_LIB=y
> > CONFIG_SND_OPL3_LIB_SEQ=y
> > CONFIG_SND_AC97_CODEC=y
> > # CONFIG_SND_DRIVERS is not set
> > CONFIG_SND_PCI=y
> > CONFIG_SND_AD1889=y
> > # CONFIG_SND_ATIIXP is not set
> > CONFIG_SND_ATIIXP_MODEM=y
> > CONFIG_SND_AU8810=y
> > CONFIG_SND_AU8820=y
> > CONFIG_SND_AU8830=y
> > CONFIG_SND_AW2=y
> > CONFIG_SND_BT87X=y
> > # CONFIG_SND_BT87X_OVERCLOCK is not set
> > # CONFIG_SND_CA0106 is not set
> > CONFIG_SND_CMIPCI=y
> > CONFIG_SND_OXYGEN_LIB=y
> > # CONFIG_SND_OXYGEN is not set
> > CONFIG_SND_CS4281=y
> > # CONFIG_SND_CS46XX is not set
> > # CONFIG_SND_CS5535AUDIO is not set
> > CONFIG_SND_CTXFI=y
> > CONFIG_SND_DARLA20=y
> > CONFIG_SND_GINA20=y
> > CONFIG_SND_LAYLA20=y
> > CONFIG_SND_DARLA24=y
> > # CONFIG_SND_GINA24 is not set
> > CONFIG_SND_LAYLA24=y
> > CONFIG_SND_MONA=y
> > CONFIG_SND_MIA=y
> > CONFIG_SND_ECHO3G=y
> > # CONFIG_SND_INDIGO is not set
> > CONFIG_SND_INDIGOIO=y
> > CONFIG_SND_INDIGODJ=y
> > CONFIG_SND_INDIGOIOX=y
> > CONFIG_SND_INDIGODJX=y
> > CONFIG_SND_ENS1370=y
> > CONFIG_SND_ENS1371=y
> > CONFIG_SND_FM801=y
> > # CONFIG_SND_HDSP is not set
> > CONFIG_SND_HDSPM=y
> > CONFIG_SND_ICE1724=y
> > CONFIG_SND_INTEL8X0=y
> > # CONFIG_SND_INTEL8X0M is not set
> > CONFIG_SND_KORG1212=y
> > CONFIG_SND_LOLA=y
> > CONFIG_SND_LX6464ES=y
> > CONFIG_SND_MIXART=y
> > CONFIG_SND_NM256=y
> > # CONFIG_SND_PCXHR is not set
> > CONFIG_SND_RIPTIDE=y
> > # CONFIG_SND_RME32 is not set
> > # CONFIG_SND_RME96 is not set
> > CONFIG_SND_RME9652=y
> > # CONFIG_SND_VIA82XX is not set
> > CONFIG_SND_VIA82XX_MODEM=y
> > CONFIG_SND_VIRTUOSO=y
> > # CONFIG_SND_VX222 is not set
> > CONFIG_SND_YMFPCI=y
> >
> > #
> > # HD-Audio
> > #
> > # CONFIG_SND_HDA_INTEL is not set
> > # end of HD-Audio
> >
> > CONFIG_SND_HDA_PREALLOC_SIZE=64
> > CONFIG_SND_USB=y
> > CONFIG_SND_USB_AUDIO=y
> > CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
> > CONFIG_SND_USB_UA101=y
> > CONFIG_SND_USB_CAIAQ=y
> > CONFIG_SND_USB_CAIAQ_INPUT=y
> > # CONFIG_SND_USB_US122L is not set
> > CONFIG_SND_USB_6FIRE=y
> > # CONFIG_SND_USB_HIFACE is not set
> > # CONFIG_SND_BCD2000 is not set
> > CONFIG_SND_USB_LINE6=y
> > # CONFIG_SND_USB_POD is not set
> > # CONFIG_SND_USB_PODHD is not set
> > CONFIG_SND_USB_TONEPORT=y
> > CONFIG_SND_USB_VARIAX=y
> > CONFIG_SND_SOC=y
> > CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
> > CONFIG_SND_SOC_COMPRESS=y
> > # CONFIG_SND_SOC_UTILS_KUNIT_TEST is not set
> > CONFIG_SND_SOC_ADI=y
> > # CONFIG_SND_SOC_ADI_AXI_I2S is not set
> > # CONFIG_SND_SOC_ADI_AXI_SPDIF is not set
> > # CONFIG_SND_SOC_AMD_ACP is not set
> > # CONFIG_SND_AMD_ACP_CONFIG is not set
> > # CONFIG_SND_SOC_APPLE_MCA is not set
> > # CONFIG_SND_ATMEL_SOC is not set
> > # CONFIG_SND_BCM2835_SOC_I2S is not set
> > # CONFIG_SND_SOC_CYGNUS is not set
> > CONFIG_SND_BCM63XX_I2S_WHISTLER=y
> > # CONFIG_SND_EP93XX_SOC is not set
> > CONFIG_SND_DESIGNWARE_I2S=y
> > CONFIG_SND_DESIGNWARE_PCM=y
> >
> > #
> > # SoC Audio for Freescale CPUs
> > #
> >
> > #
> > # Common SoC Audio options for Freescale CPUs:
> > #
> > # CONFIG_SND_SOC_FSL_ASRC is not set
> > CONFIG_SND_SOC_FSL_SAI=y
> > CONFIG_SND_SOC_FSL_MQS=y
> > CONFIG_SND_SOC_FSL_AUDMIX=y
> > CONFIG_SND_SOC_FSL_SSI=y
> > # CONFIG_SND_SOC_FSL_SPDIF is not set
> > CONFIG_SND_SOC_FSL_ESAI=y
> > CONFIG_SND_SOC_FSL_MICFIL=y
> > CONFIG_SND_SOC_FSL_XCVR=y
> > # CONFIG_SND_SOC_FSL_AUD2HTX is not set
> > CONFIG_SND_SOC_FSL_UTILS=y
> > # CONFIG_SND_SOC_FSL_RPMSG is not set
> > CONFIG_SND_SOC_IMX_AUDMUX=y
> > # CONFIG_SND_IMX_SOC is not set
> > # end of SoC Audio for Freescale CPUs
> >
> > # CONFIG_SND_I2S_HI6210_I2S is not set
> > # CONFIG_SND_JZ4740_SOC_I2S is not set
> > # CONFIG_SND_KIRKWOOD_SOC is not set
> > # CONFIG_SND_SOC_IMG is not set
> > CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
> > # CONFIG_SND_SOC_INTEL_SKYLAKE is not set
> > # CONFIG_SND_SOC_INTEL_SKL is not set
> > # CONFIG_SND_SOC_INTEL_APL is not set
> > # CONFIG_SND_SOC_INTEL_KBL is not set
> > # CONFIG_SND_SOC_INTEL_GLK is not set
> > # CONFIG_SND_SOC_INTEL_CNL is not set
> > # CONFIG_SND_SOC_INTEL_CFL is not set
> > # CONFIG_SND_SOC_INTEL_CML_H is not set
> > # CONFIG_SND_SOC_INTEL_CML_LP is not set
> > # CONFIG_SND_SOC_INTEL_KEEMBAY is not set
> > # CONFIG_SND_SOC_INTEL_AVS is not set
> > CONFIG_SND_SOC_INTEL_MACH=y
> > # CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
> > # CONFIG_SND_SOC_MT8186 is not set
> > CONFIG_SND_SOC_MTK_BTCVSD=y
> > # CONFIG_SND_SOC_MT8195 is not set
> >
> > #
> > # ASoC support for Amlogic platforms
> > #
> > # CONFIG_SND_MESON_AIU is not set
> > # CONFIG_SND_MESON_AXG_FRDDR is not set
> > # CONFIG_SND_MESON_AXG_TODDR is not set
> > # CONFIG_SND_MESON_AXG_TDMIN is not set
> > # CONFIG_SND_MESON_AXG_TDMOUT is not set
> > # CONFIG_SND_MESON_AXG_SOUND_CARD is not set
> > # CONFIG_SND_MESON_AXG_SPDIFOUT is not set
> > # CONFIG_SND_MESON_AXG_SPDIFIN is not set
> > # CONFIG_SND_MESON_AXG_PDM is not set
> > # CONFIG_SND_MESON_GX_SOUND_CARD is not set
> > # CONFIG_SND_MESON_G12A_TOACODEC is not set
> > # CONFIG_SND_MESON_G12A_TOHDMITX is not set
> > # CONFIG_SND_SOC_MESON_T9015 is not set
> > # end of ASoC support for Amlogic platforms
> >
> > # CONFIG_SND_MXS_SOC is not set
> > # CONFIG_SND_PXA2XX_SOC is not set
> > # CONFIG_SND_SOC_QCOM is not set
> > # CONFIG_SND_SOC_ROCKCHIP is not set
> > # CONFIG_SND_SOC_SAMSUNG is not set
> >
> > #
> > # SoC Audio support for Renesas SoCs
> > #
> > # CONFIG_SND_SOC_SH4_FSI is not set
> > # CONFIG_SND_SOC_RCAR is not set
> > # CONFIG_SND_SOC_RZ is not set
> > # end of SoC Audio support for Renesas SoCs
> >
> > CONFIG_SND_SOC_SOF_TOPLEVEL=y
> > CONFIG_SND_SOC_SOF_PCI=y
> > CONFIG_SND_SOC_SOF_ACPI=y
> > # CONFIG_SND_SOC_SOF_OF is not set
> > # CONFIG_SND_SOC_SOF_AMD_TOPLEVEL is not set
> > # CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL is not set
> > # CONFIG_SND_SOC_SPRD is not set
> > # CONFIG_SND_SOC_STI is not set
> >
> > #
> > # STMicroelectronics STM32 SOC audio support
> > #
> > # CONFIG_SND_SOC_STM32_SAI is not set
> > # CONFIG_SND_SOC_STM32_I2S is not set
> > # CONFIG_SND_SOC_STM32_SPDIFRX is not set
> > # end of STMicroelectronics STM32 SOC audio support
> >
> > #
> > # Allwinner SoC Audio support
> > #
> > # CONFIG_SND_SUN4I_CODEC is not set
> > # CONFIG_SND_SUN8I_CODEC_ANALOG is not set
> > # CONFIG_SND_SUN50I_CODEC_ANALOG is not set
> > # CONFIG_SND_SUN4I_I2S is not set
> > # CONFIG_SND_SUN50I_DMIC is not set
> > # end of Allwinner SoC Audio support
> >
> > # CONFIG_SND_SOC_TEGRA is not set
> >
> > #
> > # Audio support for Texas Instruments SoCs
> > #
> >
> > #
> > # Texas Instruments DAI support for:
> > #
> > # CONFIG_SND_SOC_DAVINCI_ASP is not set
> > # CONFIG_SND_SOC_DAVINCI_MCASP is not set
> > # CONFIG_SND_SOC_DAVINCI_VCIF is not set
> > # CONFIG_SND_SOC_OMAP_DMIC is not set
> > # CONFIG_SND_SOC_OMAP_MCBSP is not set
> > # CONFIG_SND_SOC_OMAP_MCPDM is not set
> >
> > #
> > # Audio support for boards with Texas Instruments SoCs
> > #
> > # CONFIG_SND_SOC_OMAP_HDMI is not set
> > # CONFIG_SND_SOC_J721E_EVM is not set
> > # end of Audio support for Texas Instruments SoCs
> >
> > # CONFIG_SND_SOC_UNIPHIER is not set
> > CONFIG_SND_SOC_XILINX_I2S=y
> > # CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
> > # CONFIG_SND_SOC_XILINX_SPDIF is not set
> > # CONFIG_SND_SOC_XTFPGA_I2S is not set
> > CONFIG_SND_SOC_I2C_AND_SPI=y
> >
> > #
> > # CODEC drivers
> > #
> > # CONFIG_SND_SOC_ALL_CODECS is not set
> > CONFIG_SND_SOC_WM_ADSP=y
> > # CONFIG_SND_SOC_AC97_CODEC is not set
> > CONFIG_SND_SOC_ADAU_UTILS=y
> > # CONFIG_SND_SOC_ADAU1372_I2C is not set
> > # CONFIG_SND_SOC_ADAU1701 is not set
> > CONFIG_SND_SOC_ADAU17X1=y
> > CONFIG_SND_SOC_ADAU1761=y
> > CONFIG_SND_SOC_ADAU1761_I2C=y
> > CONFIG_SND_SOC_ADAU7002=y
> > CONFIG_SND_SOC_ADAU7118=y
> > CONFIG_SND_SOC_ADAU7118_HW=y
> > # CONFIG_SND_SOC_ADAU7118_I2C is not set
> > CONFIG_SND_SOC_AK4118=y
> > # CONFIG_SND_SOC_AK4375 is not set
> > # CONFIG_SND_SOC_AK4458 is not set
> > CONFIG_SND_SOC_AK4554=y
> > # CONFIG_SND_SOC_AK4613 is not set
> > CONFIG_SND_SOC_AK4642=y
> > CONFIG_SND_SOC_AK5386=y
> > # CONFIG_SND_SOC_AK5558 is not set
> > CONFIG_SND_SOC_ALC5623=y
> > # CONFIG_SND_SOC_AW8738 is not set
> > # CONFIG_SND_SOC_BD28623 is not set
> > CONFIG_SND_SOC_BT_SCO=y
> > # CONFIG_SND_SOC_CPCAP is not set
> > CONFIG_SND_SOC_CS35L32=y
> > CONFIG_SND_SOC_CS35L33=y
> > CONFIG_SND_SOC_CS35L34=y
> > # CONFIG_SND_SOC_CS35L35 is not set
> > CONFIG_SND_SOC_CS35L36=y
> > CONFIG_SND_SOC_CS35L41_LIB=y
> > CONFIG_SND_SOC_CS35L41=y
> > CONFIG_SND_SOC_CS35L41_I2C=y
> > CONFIG_SND_SOC_CS35L45_TABLES=y
> > CONFIG_SND_SOC_CS35L45=y
> > CONFIG_SND_SOC_CS35L45_I2C=y
> > CONFIG_SND_SOC_CS42L42_CORE=y
> > # CONFIG_SND_SOC_CS42L42 is not set
> > CONFIG_SND_SOC_CS42L51=y
> > CONFIG_SND_SOC_CS42L51_I2C=y
> > CONFIG_SND_SOC_CS42L52=y
> > CONFIG_SND_SOC_CS42L56=y
> > CONFIG_SND_SOC_CS42L73=y
> > CONFIG_SND_SOC_CS42L83=y
> > CONFIG_SND_SOC_CS4234=y
> > CONFIG_SND_SOC_CS4265=y
> > CONFIG_SND_SOC_CS4270=y
> > CONFIG_SND_SOC_CS4271=y
> > CONFIG_SND_SOC_CS4271_I2C=y
> > CONFIG_SND_SOC_CS42XX8=y
> > CONFIG_SND_SOC_CS42XX8_I2C=y
> > # CONFIG_SND_SOC_CS43130 is not set
> > # CONFIG_SND_SOC_CS4341 is not set
> > # CONFIG_SND_SOC_CS4349 is not set
> > CONFIG_SND_SOC_CS53L30=y
> > CONFIG_SND_SOC_CX2072X=y
> > CONFIG_SND_SOC_DA7213=y
> > CONFIG_SND_SOC_DMIC=y
> > CONFIG_SND_SOC_HDMI_CODEC=y
> > # CONFIG_SND_SOC_ES7134 is not set
> > # CONFIG_SND_SOC_ES7241 is not set
> > # CONFIG_SND_SOC_ES8316 is not set
> > CONFIG_SND_SOC_ES8326=y
> > # CONFIG_SND_SOC_ES8328_I2C is not set
> > # CONFIG_SND_SOC_GTM601 is not set
> > # CONFIG_SND_SOC_HDA is not set
> > CONFIG_SND_SOC_ICS43432=y
> > CONFIG_SND_SOC_INNO_RK3036=y
> > # CONFIG_SND_SOC_LOCHNAGAR_SC is not set
> > CONFIG_SND_SOC_MAX98088=y
> > CONFIG_SND_SOC_MAX98357A=y
> > CONFIG_SND_SOC_MAX98504=y
> > CONFIG_SND_SOC_MAX9867=y
> > CONFIG_SND_SOC_MAX98927=y
> > CONFIG_SND_SOC_MAX98520=y
> > CONFIG_SND_SOC_MAX98373=y
> > CONFIG_SND_SOC_MAX98373_I2C=y
> > # CONFIG_SND_SOC_MAX98373_SDW is not set
> > # CONFIG_SND_SOC_MAX98390 is not set
> > CONFIG_SND_SOC_MAX98396=y
> > # CONFIG_SND_SOC_MAX9860 is not set
> > # CONFIG_SND_SOC_MSM8916_WCD_ANALOG is not set
> > # CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
> > # CONFIG_SND_SOC_PCM1681 is not set
> > CONFIG_SND_SOC_PCM1789=y
> > CONFIG_SND_SOC_PCM1789_I2C=y
> > CONFIG_SND_SOC_PCM179X=y
> > CONFIG_SND_SOC_PCM179X_I2C=y
> > # CONFIG_SND_SOC_PCM186X_I2C is not set
> > CONFIG_SND_SOC_PCM3060=y
> > CONFIG_SND_SOC_PCM3060_I2C=y
> > CONFIG_SND_SOC_PCM3168A=y
> > CONFIG_SND_SOC_PCM3168A_I2C=y
> > CONFIG_SND_SOC_PCM5102A=y
> > # CONFIG_SND_SOC_PCM512x_I2C is not set
> > CONFIG_SND_SOC_RK3328=y
> > # CONFIG_SND_SOC_RK817 is not set
> > CONFIG_SND_SOC_RL6231=y
> > CONFIG_SND_SOC_RT1308_SDW=y
> > CONFIG_SND_SOC_RT1316_SDW=y
> > CONFIG_SND_SOC_RT5616=y
> > CONFIG_SND_SOC_RT5631=y
> > CONFIG_SND_SOC_RT5640=y
> > # CONFIG_SND_SOC_RT5659 is not set
> > # CONFIG_SND_SOC_RT5682_SDW is not set
> > CONFIG_SND_SOC_RT700=y
> > CONFIG_SND_SOC_RT700_SDW=y
> > # CONFIG_SND_SOC_RT711_SDW is not set
> > # CONFIG_SND_SOC_RT711_SDCA_SDW is not set
> > CONFIG_SND_SOC_RT715=y
> > CONFIG_SND_SOC_RT715_SDW=y
> > CONFIG_SND_SOC_RT715_SDCA_SDW=y
> > # CONFIG_SND_SOC_RT9120 is not set
> > CONFIG_SND_SOC_SDW_MOCKUP=y
> > # CONFIG_SND_SOC_SGTL5000 is not set
> > CONFIG_SND_SOC_SIGMADSP=y
> > CONFIG_SND_SOC_SIGMADSP_REGMAP=y
> > CONFIG_SND_SOC_SIMPLE_AMPLIFIER=y
> > CONFIG_SND_SOC_SIMPLE_MUX=y
> > CONFIG_SND_SOC_SPDIF=y
> > CONFIG_SND_SOC_SRC4XXX_I2C=y
> > CONFIG_SND_SOC_SRC4XXX=y
> > CONFIG_SND_SOC_SSM2305=y
> > CONFIG_SND_SOC_SSM2518=y
> > CONFIG_SND_SOC_SSM2602=y
> > CONFIG_SND_SOC_SSM2602_I2C=y
> > CONFIG_SND_SOC_SSM4567=y
> > # CONFIG_SND_SOC_STA32X is not set
> > CONFIG_SND_SOC_STA350=y
> > CONFIG_SND_SOC_STI_SAS=y
> > # CONFIG_SND_SOC_TAS2552 is not set
> > CONFIG_SND_SOC_TAS2562=y
> > CONFIG_SND_SOC_TAS2764=y
> > CONFIG_SND_SOC_TAS2770=y
> > CONFIG_SND_SOC_TAS2780=y
> > # CONFIG_SND_SOC_TAS5086 is not set
> > # CONFIG_SND_SOC_TAS571X is not set
> > # CONFIG_SND_SOC_TAS5720 is not set
> > CONFIG_SND_SOC_TAS5805M=y
> > CONFIG_SND_SOC_TAS6424=y
> > # CONFIG_SND_SOC_TDA7419 is not set
> > CONFIG_SND_SOC_TFA9879=y
> > # CONFIG_SND_SOC_TFA989X is not set
> > CONFIG_SND_SOC_TLV320ADC3XXX=y
> > CONFIG_SND_SOC_TLV320AIC23=y
> > CONFIG_SND_SOC_TLV320AIC23_I2C=y
> > CONFIG_SND_SOC_TLV320AIC31XX=y
> > CONFIG_SND_SOC_TLV320AIC32X4=y
> > CONFIG_SND_SOC_TLV320AIC32X4_I2C=y
> > # CONFIG_SND_SOC_TLV320AIC3X_I2C is not set
> > # CONFIG_SND_SOC_TLV320ADCX140 is not set
> > CONFIG_SND_SOC_TS3A227E=y
> > # CONFIG_SND_SOC_TSCS42XX is not set
> > # CONFIG_SND_SOC_TSCS454 is not set
> > CONFIG_SND_SOC_UDA1334=y
> > CONFIG_SND_SOC_WCD9335=y
> > CONFIG_SND_SOC_WCD_MBHC=y
> > # CONFIG_SND_SOC_WCD934X is not set
> > CONFIG_SND_SOC_WCD938X=y
> > CONFIG_SND_SOC_WCD938X_SDW=y
> > # CONFIG_SND_SOC_WM8510 is not set
> > # CONFIG_SND_SOC_WM8523 is not set
> > # CONFIG_SND_SOC_WM8524 is not set
> > CONFIG_SND_SOC_WM8580=y
> > # CONFIG_SND_SOC_WM8711 is not set
> > # CONFIG_SND_SOC_WM8728 is not set
> > # CONFIG_SND_SOC_WM8731_I2C is not set
> > # CONFIG_SND_SOC_WM8737 is not set
> > CONFIG_SND_SOC_WM8741=y
> > CONFIG_SND_SOC_WM8750=y
> > CONFIG_SND_SOC_WM8753=y
> > CONFIG_SND_SOC_WM8776=y
> > CONFIG_SND_SOC_WM8782=y
> > # CONFIG_SND_SOC_WM8804_I2C is not set
> > CONFIG_SND_SOC_WM8903=y
> > CONFIG_SND_SOC_WM8904=y
> > # CONFIG_SND_SOC_WM8940 is not set
> > # CONFIG_SND_SOC_WM8960 is not set
> > CONFIG_SND_SOC_WM8962=y
> > # CONFIG_SND_SOC_WM8974 is not set
> > # CONFIG_SND_SOC_WM8978 is not set
> > CONFIG_SND_SOC_WM8985=y
> > # CONFIG_SND_SOC_WSA881X is not set
> > # CONFIG_SND_SOC_WSA883X is not set
> > # CONFIG_SND_SOC_MAX9759 is not set
> > # CONFIG_SND_SOC_MT6351 is not set
> > # CONFIG_SND_SOC_MT6358 is not set
> > CONFIG_SND_SOC_MT6660=y
> > # CONFIG_SND_SOC_NAU8315 is not set
> > # CONFIG_SND_SOC_NAU8540 is not set
> > # CONFIG_SND_SOC_NAU8810 is not set
> > CONFIG_SND_SOC_NAU8821=y
> > CONFIG_SND_SOC_NAU8822=y
> > CONFIG_SND_SOC_NAU8824=y
> > CONFIG_SND_SOC_TPA6130A2=y
> > CONFIG_SND_SOC_LPASS_MACRO_COMMON=y
> > CONFIG_SND_SOC_LPASS_WSA_MACRO=y
> > CONFIG_SND_SOC_LPASS_VA_MACRO=y
> > CONFIG_SND_SOC_LPASS_RX_MACRO=y
> > CONFIG_SND_SOC_LPASS_TX_MACRO=y
> > # end of CODEC drivers
> >
> > # CONFIG_SND_SIMPLE_CARD is not set
> > CONFIG_SND_VIRTIO=y
> > CONFIG_AC97_BUS=y
> >
> > #
> > # HID support
> > #
> > CONFIG_HID=y
> > CONFIG_HID_BATTERY_STRENGTH=y
> > # CONFIG_HIDRAW is not set
> > # CONFIG_UHID is not set
> > CONFIG_HID_GENERIC=y
> >
> > #
> > # Special HID drivers
> > #
> > # CONFIG_HID_A4TECH is not set
> > CONFIG_HID_ACCUTOUCH=y
> > # CONFIG_HID_ACRUX is not set
> > CONFIG_HID_APPLE=y
> > CONFIG_HID_APPLEIR=y
> > CONFIG_HID_ASUS=y
> > CONFIG_HID_AUREAL=y
> > CONFIG_HID_BELKIN=y
> > CONFIG_HID_BETOP_FF=y
> > CONFIG_HID_BIGBEN_FF=y
> > # CONFIG_HID_CHERRY is not set
> > CONFIG_HID_CHICONY=y
> > # CONFIG_HID_CORSAIR is not set
> > # CONFIG_HID_COUGAR is not set
> > CONFIG_HID_MACALLY=y
> > # CONFIG_HID_PRODIKEYS is not set
> > # CONFIG_HID_CMEDIA is not set
> > # CONFIG_HID_CREATIVE_SB0540 is not set
> > # CONFIG_HID_CYPRESS is not set
> > CONFIG_HID_DRAGONRISE=y
> > CONFIG_DRAGONRISE_FF=y
> > # CONFIG_HID_EMS_FF is not set
> > CONFIG_HID_ELAN=y
> > CONFIG_HID_ELECOM=y
> > CONFIG_HID_ELO=y
> > # CONFIG_HID_EZKEY is not set
> > CONFIG_HID_GEMBIRD=y
> > CONFIG_HID_GFRM=y
> > CONFIG_HID_GLORIOUS=y
> > # CONFIG_HID_HOLTEK is not set
> > CONFIG_HID_VIVALDI_COMMON=y
> > CONFIG_HID_VIVALDI=y
> > # CONFIG_HID_GT683R is not set
> > # CONFIG_HID_KEYTOUCH is not set
> > # CONFIG_HID_KYE is not set
> > # CONFIG_HID_UCLOGIC is not set
> > CONFIG_HID_WALTOP=y
> > # CONFIG_HID_VIEWSONIC is not set
> > CONFIG_HID_VRC2=y
> > CONFIG_HID_XIAOMI=y
> > # CONFIG_HID_GYRATION is not set
> > CONFIG_HID_ICADE=y
> > CONFIG_HID_ITE=y
> > CONFIG_HID_JABRA=y
> > CONFIG_HID_TWINHAN=y
> > # CONFIG_HID_KENSINGTON is not set
> > CONFIG_HID_LCPOWER=y
> > CONFIG_HID_LED=y
> > CONFIG_HID_LENOVO=y
> > CONFIG_HID_LETSKETCH=y
> > # CONFIG_HID_LOGITECH is not set
> > # CONFIG_HID_MAGICMOUSE is not set
> > CONFIG_HID_MALTRON=y
> > CONFIG_HID_MAYFLASH=y
> > CONFIG_HID_MEGAWORLD_FF=y
> > CONFIG_HID_REDRAGON=y
> > CONFIG_HID_MICROSOFT=y
> > CONFIG_HID_MONTEREY=y
> > CONFIG_HID_MULTITOUCH=y
> > CONFIG_HID_NINTENDO=y
> > CONFIG_NINTENDO_FF=y
> > # CONFIG_HID_NTI is not set
> > # CONFIG_HID_NTRIG is not set
> > CONFIG_HID_ORTEK=y
> > CONFIG_HID_PANTHERLORD=y
> > # CONFIG_PANTHERLORD_FF is not set
> > # CONFIG_HID_PENMOUNT is not set
> > # CONFIG_HID_PETALYNX is not set
> > # CONFIG_HID_PICOLCD is not set
> > # CONFIG_HID_PLANTRONICS is not set
> > CONFIG_HID_PLAYSTATION=y
> > # CONFIG_PLAYSTATION_FF is not set
> > CONFIG_HID_PXRC=y
> > CONFIG_HID_RAZER=y
> > # CONFIG_HID_PRIMAX is not set
> > CONFIG_HID_RETRODE=y
> > CONFIG_HID_ROCCAT=y
> > CONFIG_HID_SAITEK=y
> > CONFIG_HID_SAMSUNG=y
> > # CONFIG_HID_SEMITEK is not set
> > CONFIG_HID_SIGMAMICRO=y
> > # CONFIG_HID_SONY is not set
> > CONFIG_HID_SPEEDLINK=y
> > CONFIG_HID_STEAM=y
> > CONFIG_HID_STEELSERIES=y
> > # CONFIG_HID_SUNPLUS is not set
> > CONFIG_HID_RMI=y
> > CONFIG_HID_GREENASIA=y
> > CONFIG_GREENASIA_FF=y
> > # CONFIG_HID_SMARTJOYPLUS is not set
> > CONFIG_HID_TIVO=y
> > CONFIG_HID_TOPSEED=y
> > CONFIG_HID_TOPRE=y
> > CONFIG_HID_THINGM=y
> > # CONFIG_HID_THRUSTMASTER is not set
> > # CONFIG_HID_UDRAW_PS3 is not set
> > CONFIG_HID_U2FZERO=y
> > CONFIG_HID_WACOM=y
> > # CONFIG_HID_WIIMOTE is not set
> > CONFIG_HID_XINMO=y
> > # CONFIG_HID_ZEROPLUS is not set
> > # CONFIG_HID_ZYDACRON is not set
> > CONFIG_HID_SENSOR_HUB=y
> > CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
> > CONFIG_HID_ALPS=y
> > CONFIG_HID_MCP2221=y
> > # end of Special HID drivers
> >
> > #
> > # USB HID support
> > #
> > CONFIG_USB_HID=y
> > CONFIG_HID_PID=y
> > # CONFIG_USB_HIDDEV is not set
> > # end of USB HID support
> >
> > #
> > # I2C HID support
> > #
> > CONFIG_I2C_HID_ACPI=y
> > # end of I2C HID support
> >
> > CONFIG_I2C_HID_CORE=y
> >
> > #
> > # Intel ISH HID support
> > #
> > # end of Intel ISH HID support
> >
> > #
> > # AMD SFH HID Support
> > #
> > # CONFIG_AMD_SFH_HID is not set
> > # end of AMD SFH HID Support
> > # end of HID support
> >
> > CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> > CONFIG_USB_SUPPORT=y
> > CONFIG_USB_COMMON=y
> > CONFIG_USB_LED_TRIG=y
> > CONFIG_USB_ULPI_BUS=y
> > CONFIG_USB_CONN_GPIO=y
> > CONFIG_USB_ARCH_HAS_HCD=y
> > CONFIG_USB=y
> > CONFIG_USB_PCI=y
> > # CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
> >
> > #
> > # Miscellaneous USB options
> > #
> > # CONFIG_USB_DEFAULT_PERSIST is not set
> > CONFIG_USB_FEW_INIT_RETRIES=y
> > CONFIG_USB_DYNAMIC_MINORS=y
> > CONFIG_USB_OTG_PRODUCTLIST=y
> > CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB=y
> > CONFIG_USB_LEDS_TRIGGER_USBPORT=y
> > CONFIG_USB_AUTOSUSPEND_DELAY=2
> > CONFIG_USB_MON=y
> >
> > #
> > # USB Host Controller Drivers
> > #
> > # CONFIG_USB_C67X00_HCD is not set
> > CONFIG_USB_XHCI_HCD=y
> > CONFIG_USB_XHCI_PCI=y
> > CONFIG_USB_XHCI_PCI_RENESAS=y
> > # CONFIG_USB_XHCI_PLATFORM is not set
> > # CONFIG_USB_XHCI_MTK is not set
> > # CONFIG_USB_XHCI_MVEBU is not set
> > # CONFIG_USB_BRCMSTB is not set
> > # CONFIG_USB_EHCI_HCD is not set
> > CONFIG_USB_OXU210HP_HCD=y
> > # CONFIG_USB_ISP116X_HCD is not set
> > # CONFIG_USB_ISP1362_HCD is not set
> > # CONFIG_USB_FOTG210_HCD is not set
> > CONFIG_USB_OHCI_HCD=y
> > # CONFIG_USB_OHCI_HCD_SPEAR is not set
> > # CONFIG_USB_OHCI_HCD_S3C2410 is not set
> > CONFIG_USB_OHCI_HCD_LPC32XX=y
> > # CONFIG_USB_OHCI_HCD_OMAP3 is not set
> > # CONFIG_USB_OHCI_HCD_DAVINCI is not set
> > CONFIG_USB_OHCI_HCD_PCI=y
> > # CONFIG_USB_OHCI_HCD_SSB is not set
> > # CONFIG_USB_OHCI_SH is not set
> > # CONFIG_USB_OHCI_EXYNOS is not set
> > # CONFIG_USB_CNS3XXX_OHCI is not set
> > CONFIG_USB_OHCI_HCD_PLATFORM=y
> > CONFIG_USB_UHCI_HCD=y
> > CONFIG_USB_U132_HCD=y
> > CONFIG_USB_SL811_HCD=y
> > CONFIG_USB_SL811_HCD_ISO=y
> > # CONFIG_USB_R8A66597_HCD is not set
> > CONFIG_USB_HCD_SSB=y
> > # CONFIG_USB_HCD_TEST_MODE is not set
> > # CONFIG_USB_RENESAS_USBHS is not set
> >
> > #
> > # USB Device Class drivers
> > #
> > CONFIG_USB_PRINTER=y
> > # CONFIG_USB_WDM is not set
> > CONFIG_USB_TMC=y
> >
> > #
> > # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> > #
> >
> > #
> > # also be needed; see USB_STORAGE Help for more info
> > #
> > CONFIG_USB_STORAGE=y
> > CONFIG_USB_STORAGE_DEBUG=y
> > CONFIG_USB_STORAGE_REALTEK=y
> > CONFIG_USB_STORAGE_DATAFAB=y
> > CONFIG_USB_STORAGE_FREECOM=y
> > # CONFIG_USB_STORAGE_ISD200 is not set
> > CONFIG_USB_STORAGE_USBAT=y
> > # CONFIG_USB_STORAGE_SDDR09 is not set
> > # CONFIG_USB_STORAGE_SDDR55 is not set
> > CONFIG_USB_STORAGE_JUMPSHOT=y
> > CONFIG_USB_STORAGE_ALAUDA=y
> > CONFIG_USB_STORAGE_ONETOUCH=y
> > # CONFIG_USB_STORAGE_KARMA is not set
> > # CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
> > CONFIG_USB_STORAGE_ENE_UB6250=y
> > CONFIG_USB_UAS=y
> >
> > #
> > # USB Imaging devices
> > #
> > CONFIG_USB_MDC800=y
> > # CONFIG_USB_MICROTEK is not set
> > # CONFIG_USB_CDNS_SUPPORT is not set
> > # CONFIG_USB_MTU3 is not set
> > # CONFIG_USB_MUSB_HDRC is not set
> > # CONFIG_USB_DWC3 is not set
> > CONFIG_USB_DWC2=y
> > CONFIG_USB_DWC2_HOST=y
> >
> > #
> > # Gadget/Dual-role mode requires USB Gadget support to be enabled
> > #
> > # CONFIG_USB_DWC2_PERIPHERAL is not set
> > # CONFIG_USB_DWC2_DUAL_ROLE is not set
> > CONFIG_USB_DWC2_PCI=y
> > CONFIG_USB_DWC2_DEBUG=y
> > # CONFIG_USB_DWC2_VERBOSE is not set
> > # CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
> > CONFIG_USB_DWC2_DEBUG_PERIODIC=y
> > CONFIG_USB_CHIPIDEA=y
> > # CONFIG_USB_CHIPIDEA_UDC is not set
> > # CONFIG_USB_CHIPIDEA_PCI is not set
> > CONFIG_USB_CHIPIDEA_MSM=y
> > CONFIG_USB_CHIPIDEA_GENERIC=y
> > # CONFIG_USB_ISP1760 is not set
> >
> > #
> > # USB port drivers
> > #
> > CONFIG_USB_USS720=y
> >
> > #
> > # USB Miscellaneous drivers
> > #
> > # CONFIG_USB_EMI62 is not set
> > CONFIG_USB_EMI26=y
> > # CONFIG_USB_ADUTUX is not set
> > # CONFIG_USB_SEVSEG is not set
> > CONFIG_USB_LEGOTOWER=y
> > CONFIG_USB_LCD=y
> > CONFIG_USB_CYPRESS_CY7C63=y
> > # CONFIG_USB_CYTHERM is not set
> > # CONFIG_USB_IDMOUSE is not set
> > CONFIG_USB_FTDI_ELAN=y
> > CONFIG_USB_APPLEDISPLAY=y
> > # CONFIG_USB_QCOM_EUD is not set
> > CONFIG_APPLE_MFI_FASTCHARGE=y
> > CONFIG_USB_LD=y
> > CONFIG_USB_TRANCEVIBRATOR=y
> > CONFIG_USB_IOWARRIOR=y
> > CONFIG_USB_TEST=y
> > CONFIG_USB_EHSET_TEST_FIXTURE=y
> > CONFIG_USB_ISIGHTFW=y
> > # CONFIG_USB_YUREX is not set
> > CONFIG_USB_EZUSB_FX2=y
> > CONFIG_USB_HUB_USB251XB=y
> > # CONFIG_USB_HSIC_USB3503 is not set
> > CONFIG_USB_HSIC_USB4604=y
> > # CONFIG_USB_LINK_LAYER_TEST is not set
> > CONFIG_USB_CHAOSKEY=y
> > # CONFIG_BRCM_USB_PINMAP is not set
> > # CONFIG_USB_ONBOARD_HUB is not set
> >
> > #
> > # USB Physical Layer drivers
> > #
> > CONFIG_USB_PHY=y
> > # CONFIG_KEYSTONE_USB_PHY is not set
> > CONFIG_NOP_USB_XCEIV=y
> > # CONFIG_AM335X_PHY_USB is not set
> > # CONFIG_USB_GPIO_VBUS is not set
> > # CONFIG_TAHVO_USB is not set
> > CONFIG_USB_ISP1301=y
> > # CONFIG_USB_TEGRA_PHY is not set
> > # CONFIG_USB_ULPI is not set
> > # CONFIG_JZ4770_PHY is not set
> > # end of USB Physical Layer drivers
> >
> > CONFIG_USB_GADGET=y
> > CONFIG_USB_GADGET_DEBUG=y
> > CONFIG_USB_GADGET_VERBOSE=y
> > CONFIG_USB_GADGET_DEBUG_FS=y
> > CONFIG_USB_GADGET_VBUS_DRAW=2
> > CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
> >
> > #
> > # USB Peripheral Controller
> > #
> > # CONFIG_USB_LPC32XX is not set
> > # CONFIG_USB_FOTG210_UDC is not set
> > # CONFIG_USB_GR_UDC is not set
> > CONFIG_USB_R8A66597=y
> > # CONFIG_USB_RENESAS_USB3 is not set
> > CONFIG_USB_PXA27X=y
> > CONFIG_USB_MV_UDC=y
> > CONFIG_USB_MV_U3D=y
> > CONFIG_USB_SNP_CORE=y
> > CONFIG_USB_M66592=y
> > CONFIG_USB_BDC_UDC=y
> > CONFIG_USB_AMD5536UDC=y
> > CONFIG_USB_NET2272=y
> > CONFIG_USB_NET2272_DMA=y
> > # CONFIG_USB_NET2280 is not set
> > CONFIG_USB_GOKU=y
> > CONFIG_USB_EG20T=y
> > # CONFIG_USB_GADGET_XILINX is not set
> > # CONFIG_USB_ASPEED_UDC is not set
> > # CONFIG_USB_ASPEED_VHUB is not set
> > CONFIG_USB_DUMMY_HCD=y
> > # end of USB Peripheral Controller
> >
> > CONFIG_USB_LIBCOMPOSITE=y
> > CONFIG_USB_F_SS_LB=y
> > CONFIG_USB_U_AUDIO=y
> > CONFIG_USB_F_MASS_STORAGE=y
> > CONFIG_USB_F_FS=y
> > CONFIG_USB_F_UAC1_LEGACY=y
> > CONFIG_USB_F_UAC2=y
> > CONFIG_USB_F_UVC=y
> > CONFIG_USB_F_MIDI=y
> > CONFIG_USB_F_HID=y
> > CONFIG_USB_F_TCM=y
> > CONFIG_USB_CONFIGFS=y
> > CONFIG_USB_CONFIGFS_MASS_STORAGE=y
> > # CONFIG_USB_CONFIGFS_F_LB_SS is not set
> > # CONFIG_USB_CONFIGFS_F_FS is not set
> > # CONFIG_USB_CONFIGFS_F_UAC1 is not set
> > CONFIG_USB_CONFIGFS_F_UAC1_LEGACY=y
> > CONFIG_USB_CONFIGFS_F_UAC2=y
> > CONFIG_USB_CONFIGFS_F_MIDI=y
> > CONFIG_USB_CONFIGFS_F_HID=y
> > CONFIG_USB_CONFIGFS_F_UVC=y
> > # CONFIG_USB_CONFIGFS_F_PRINTER is not set
> > # CONFIG_USB_CONFIGFS_F_TCM is not set
> >
> > #
> > # USB Gadget precomposed configurations
> > #
> > CONFIG_USB_ZERO=y
> > CONFIG_USB_AUDIO=y
> > # CONFIG_GADGET_UAC1 is not set
> > CONFIG_USB_GADGETFS=y
> > CONFIG_USB_FUNCTIONFS=y
> > CONFIG_USB_FUNCTIONFS_GENERIC=y
> > # CONFIG_USB_MASS_STORAGE is not set
> > CONFIG_USB_GADGET_TARGET=y
> > CONFIG_USB_MIDI_GADGET=y
> > # CONFIG_USB_G_PRINTER is not set
> > # CONFIG_USB_G_HID is not set
> > # CONFIG_USB_G_WEBCAM is not set
> > CONFIG_USB_RAW_GADGET=y
> > # end of USB Gadget precomposed configurations
> >
> > CONFIG_TYPEC=y
> > CONFIG_TYPEC_TCPM=y
> > CONFIG_TYPEC_TCPCI=y
> > CONFIG_TYPEC_RT1711H=y
> > CONFIG_TYPEC_MT6360=y
> > # CONFIG_TYPEC_TCPCI_MT6370 is not set
> > CONFIG_TYPEC_TCPCI_MAXIM=y
> > CONFIG_TYPEC_FUSB302=y
> > # CONFIG_TYPEC_UCSI is not set
> > CONFIG_TYPEC_TPS6598X=y
> > CONFIG_TYPEC_ANX7411=y
> > # CONFIG_TYPEC_RT1719 is not set
> > CONFIG_TYPEC_HD3SS3220=y
> > # CONFIG_TYPEC_STUSB160X is not set
> > # CONFIG_TYPEC_QCOM_PMIC is not set
> > CONFIG_TYPEC_WUSB3801=y
> >
> > #
> > # USB Type-C Multiplexer/DeMultiplexer Switch support
> > #
> > # CONFIG_TYPEC_MUX_FSA4480 is not set
> > CONFIG_TYPEC_MUX_PI3USB30532=y
> > # end of USB Type-C Multiplexer/DeMultiplexer Switch support
> >
> > #
> > # USB Type-C Alternate Mode drivers
> > #
> > CONFIG_TYPEC_DP_ALTMODE=y
> > CONFIG_TYPEC_NVIDIA_ALTMODE=y
> > # end of USB Type-C Alternate Mode drivers
> >
> > CONFIG_USB_ROLE_SWITCH=y
> > CONFIG_MMC=y
> > CONFIG_MMC_BLOCK=y
> > CONFIG_MMC_BLOCK_MINORS=8
> > CONFIG_MMC_TEST=y
> > CONFIG_MMC_CRYPTO=y
> >
> > #
> > # MMC/SD/SDIO Host Controller Drivers
> > #
> > CONFIG_MMC_DEBUG=y
> > CONFIG_MMC_SDHCI=y
> > # CONFIG_MMC_SDHCI_PCI is not set
> > CONFIG_MMC_SDHCI_ACPI=y
> > CONFIG_MMC_SDHCI_PLTFM=y
> > # CONFIG_MMC_SDHCI_OF_ESDHC is not set
> > # CONFIG_MMC_SDHCI_OF_SPARX5 is not set
> > # CONFIG_MMC_SDHCI_CNS3XXX is not set
> > # CONFIG_MMC_SDHCI_DOVE is not set
> > # CONFIG_MMC_SDHCI_TEGRA is not set
> > # CONFIG_MMC_SDHCI_S3C is not set
> > # CONFIG_MMC_SDHCI_PXAV3 is not set
> > # CONFIG_MMC_SDHCI_PXAV2 is not set
> > # CONFIG_MMC_SDHCI_BCM_KONA is not set
> > CONFIG_MMC_SDHCI_F_SDH30=y
> > # CONFIG_MMC_SDHCI_IPROC is not set
> > # CONFIG_MMC_MESON_GX is not set
> > # CONFIG_MMC_MOXART is not set
> > # CONFIG_MMC_SDHCI_ST is not set
> > # CONFIG_MMC_OMAP_HS is not set
> > # CONFIG_MMC_SDHCI_MSM is not set
> > # CONFIG_MMC_TIFM_SD is not set
> > # CONFIG_MMC_DAVINCI is not set
> > # CONFIG_MMC_S3C is not set
> > # CONFIG_MMC_SDHCI_SPRD is not set
> > # CONFIG_MMC_TMIO is not set
> > # CONFIG_MMC_SDHI is not set
> > CONFIG_MMC_CB710=y
> > CONFIG_MMC_VIA_SDMMC=y
> > # CONFIG_MMC_DW is not set
> > # CONFIG_MMC_SH_MMCIF is not set
> > CONFIG_MMC_VUB300=y
> > CONFIG_MMC_USHC=y
> > CONFIG_MMC_USDHI6ROL0=y
> > # CONFIG_MMC_REALTEK_PCI is not set
> > CONFIG_MMC_REALTEK_USB=y
> > CONFIG_MMC_CQHCI=y
> > CONFIG_MMC_HSQ=y
> > CONFIG_MMC_TOSHIBA_PCI=y
> > # CONFIG_MMC_BCM2835 is not set
> > CONFIG_MMC_MTK=y
> > CONFIG_MMC_SDHCI_XENON=y
> > # CONFIG_MMC_OWL is not set
> > # CONFIG_MMC_LITEX is not set
> > # CONFIG_SCSI_UFSHCD is not set
> > CONFIG_MEMSTICK=y
> > CONFIG_MEMSTICK_DEBUG=y
> >
> > #
> > # MemoryStick drivers
> > #
> > CONFIG_MEMSTICK_UNSAFE_RESUME=y
> > CONFIG_MSPRO_BLOCK=y
> > # CONFIG_MS_BLOCK is not set
> >
> > #
> > # MemoryStick Host Controller Drivers
> > #
> > CONFIG_MEMSTICK_TIFM_MS=y
> > CONFIG_MEMSTICK_JMICRON_38X=y
> > CONFIG_MEMSTICK_R592=y
> > # CONFIG_MEMSTICK_REALTEK_PCI is not set
> > CONFIG_MEMSTICK_REALTEK_USB=y
> > CONFIG_NEW_LEDS=y
> > CONFIG_LEDS_CLASS=y
> > # CONFIG_LEDS_CLASS_FLASH is not set
> > CONFIG_LEDS_CLASS_MULTICOLOR=y
> > # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
> >
> > #
> > # LED drivers
> > #
> > # CONFIG_LEDS_ARIEL is not set
> > # CONFIG_LEDS_LM3530 is not set
> > # CONFIG_LEDS_LM3532 is not set
> > CONFIG_LEDS_LM3533=y
> > CONFIG_LEDS_LM3642=y
> > # CONFIG_LEDS_S3C24XX is not set
> > # CONFIG_LEDS_COBALT_QUBE is not set
> > # CONFIG_LEDS_COBALT_RAQ is not set
> > CONFIG_LEDS_PCA9532=y
> > CONFIG_LEDS_PCA9532_GPIO=y
> > # CONFIG_LEDS_GPIO is not set
> > # CONFIG_LEDS_LP3944 is not set
> > CONFIG_LEDS_LP3952=y
> > CONFIG_LEDS_LP50XX=y
> > CONFIG_LEDS_LP8788=y
> > CONFIG_LEDS_PCA955X=y
> > CONFIG_LEDS_PCA955X_GPIO=y
> > # CONFIG_LEDS_PCA963X is not set
> > CONFIG_LEDS_WM831X_STATUS=y
> > # CONFIG_LEDS_DA903X is not set
> > CONFIG_LEDS_REGULATOR=y
> > CONFIG_LEDS_BD2802=y
> > # CONFIG_LEDS_LT3593 is not set
> > # CONFIG_LEDS_MC13783 is not set
> > CONFIG_LEDS_NS2=y
> > CONFIG_LEDS_TCA6507=y
> > CONFIG_LEDS_TLC591XX=y
> > CONFIG_LEDS_MAX8997=y
> > CONFIG_LEDS_LM355x=y
> > # CONFIG_LEDS_OT200 is not set
> > # CONFIG_LEDS_MENF21BMC is not set
> > CONFIG_LEDS_IS31FL319X=y
> >
> > #
> > # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> > #
> > CONFIG_LEDS_BLINKM=y
> > CONFIG_LEDS_MLXREG=y
> > CONFIG_LEDS_USER=y
> > CONFIG_LEDS_TI_LMU_COMMON=y
> > CONFIG_LEDS_LM36274=y
> > # CONFIG_LEDS_TPS6105X is not set
> > # CONFIG_LEDS_IP30 is not set
> >
> > #
> > # Flash and Torch LED drivers
> > #
> >
> > #
> > # RGB LED drivers
> > #
> >
> > #
> > # LED Triggers
> > #
> > CONFIG_LEDS_TRIGGERS=y
> > CONFIG_LEDS_TRIGGER_TIMER=y
> > # CONFIG_LEDS_TRIGGER_ONESHOT is not set
> > # CONFIG_LEDS_TRIGGER_DISK is not set
> > # CONFIG_LEDS_TRIGGER_MTD is not set
> > # CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
> > CONFIG_LEDS_TRIGGER_BACKLIGHT=y
> > # CONFIG_LEDS_TRIGGER_CPU is not set
> > CONFIG_LEDS_TRIGGER_ACTIVITY=y
> > # CONFIG_LEDS_TRIGGER_GPIO is not set
> > CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
> >
> > #
> > # iptables trigger is under Netfilter config (LED target)
> > #
> > CONFIG_LEDS_TRIGGER_TRANSIENT=y
> > CONFIG_LEDS_TRIGGER_CAMERA=y
> > # CONFIG_LEDS_TRIGGER_PANIC is not set
> > CONFIG_LEDS_TRIGGER_PATTERN=y
> > CONFIG_LEDS_TRIGGER_AUDIO=y
> >
> > #
> > # Simple LED drivers
> > #
> > # CONFIG_ACCESSIBILITY is not set
> > CONFIG_RTC_LIB=y
> > # CONFIG_RTC_CLASS is not set
> > CONFIG_DMADEVICES=y
> > # CONFIG_DMADEVICES_DEBUG is not set
> >
> > #
> > # DMA Devices
> > #
> > CONFIG_DMA_ENGINE=y
> > CONFIG_DMA_VIRTUAL_CHANNELS=y
> > CONFIG_DMA_ACPI=y
> > CONFIG_ALTERA_MSGDMA=y
> > # CONFIG_APPLE_ADMAC is not set
> > # CONFIG_AXI_DMAC is not set
> > # CONFIG_BCM_SBA_RAID is not set
> > # CONFIG_DMA_JZ4780 is not set
> > # CONFIG_DMA_SA11X0 is not set
> > # CONFIG_DMA_SUN6I is not set
> > # CONFIG_EP93XX_DMA is not set
> > # CONFIG_HISI_DMA is not set
> > # CONFIG_IMG_MDC_DMA is not set
> > # CONFIG_INTEL_IDMA64 is not set
> > # CONFIG_INTEL_IOP_ADMA is not set
> > # CONFIG_K3_DMA is not set
> > # CONFIG_MCF_EDMA is not set
> > # CONFIG_MMP_PDMA is not set
> > # CONFIG_MMP_TDMA is not set
> > # CONFIG_MV_XOR is not set
> > # CONFIG_MXS_DMA is not set
> > # CONFIG_NBPFAXI_DMA is not set
> > # CONFIG_PCH_DMA is not set
> > # CONFIG_PLX_DMA is not set
> > # CONFIG_STM32_DMA is not set
> > # CONFIG_STM32_DMAMUX is not set
> > # CONFIG_SPRD_DMA is not set
> > # CONFIG_S3C24XX_DMAC is not set
> > # CONFIG_TEGRA186_GPC_DMA is not set
> > # CONFIG_TEGRA20_APB_DMA is not set
> > # CONFIG_TEGRA210_ADMA is not set
> > # CONFIG_TIMB_DMA is not set
> > # CONFIG_XGENE_DMA is not set
> > # CONFIG_XILINX_ZYNQMP_DMA is not set
> > # CONFIG_MTK_HSDMA is not set
> > # CONFIG_MTK_CQDMA is not set
> > CONFIG_QCOM_HIDMA_MGMT=y
> > CONFIG_QCOM_HIDMA=y
> > CONFIG_DW_DMAC_CORE=y
> > CONFIG_DW_DMAC=y
> > # CONFIG_RZN1_DMAMUX is not set
> > # CONFIG_DW_DMAC_PCI is not set
> > CONFIG_DW_EDMA=y
> > CONFIG_DW_EDMA_PCIE=y
> > CONFIG_SF_PDMA=y
> > CONFIG_RENESAS_DMA=y
> > CONFIG_SH_DMAE_BASE=y
> > # CONFIG_SH_DMAE is not set
> > # CONFIG_RCAR_DMAC is not set
> > # CONFIG_RENESAS_USB_DMAC is not set
> > # CONFIG_RZ_DMAC is not set
> > CONFIG_TI_EDMA=y
> > CONFIG_DMA_OMAP=y
> > CONFIG_TI_DMA_CROSSBAR=y
> > # CONFIG_INTEL_LDMA is not set
> >
> > #
> > # DMA Clients
> > #
> > # CONFIG_ASYNC_TX_DMA is not set
> > CONFIG_DMATEST=y
> > CONFIG_DMA_ENGINE_RAID=y
> >
> > #
> > # DMABUF options
> > #
> > CONFIG_SYNC_FILE=y
> > CONFIG_SW_SYNC=y
> > # CONFIG_UDMABUF is not set
> > CONFIG_DMABUF_MOVE_NOTIFY=y
> > CONFIG_DMABUF_DEBUG=y
> > # CONFIG_DMABUF_SELFTESTS is not set
> > CONFIG_DMABUF_HEAPS=y
> > CONFIG_DMABUF_SYSFS_STATS=y
> > # CONFIG_DMABUF_HEAPS_SYSTEM is not set
> > # CONFIG_DMABUF_HEAPS_CMA is not set
> > # end of DMABUF options
> >
> > CONFIG_AUXDISPLAY=y
> > CONFIG_CHARLCD=y
> > # CONFIG_LINEDISP is not set
> > CONFIG_HD44780_COMMON=y
> > CONFIG_HD44780=y
> > CONFIG_KS0108=y
> > CONFIG_KS0108_PORT=0x378
> > CONFIG_KS0108_DELAY=2
> > # CONFIG_IMG_ASCII_LCD is not set
> > CONFIG_LCD2S=y
> > CONFIG_PARPORT_PANEL=y
> > CONFIG_PANEL_PARPORT=0
> > CONFIG_PANEL_PROFILE=5
> > # CONFIG_PANEL_CHANGE_MESSAGE is not set
> > # CONFIG_CHARLCD_BL_OFF is not set
> > # CONFIG_CHARLCD_BL_ON is not set
> > CONFIG_CHARLCD_BL_FLASH=y
> > CONFIG_PANEL=y
> > CONFIG_UIO=y
> > CONFIG_UIO_CIF=y
> > CONFIG_UIO_PDRV_GENIRQ=y
> > CONFIG_UIO_DMEM_GENIRQ=y
> > # CONFIG_UIO_AEC is not set
> > CONFIG_UIO_SERCOS3=y
> > CONFIG_UIO_PCI_GENERIC=y
> > # CONFIG_UIO_NETX is not set
> > # CONFIG_UIO_PRUSS is not set
> > # CONFIG_UIO_MF624 is not set
> > CONFIG_VFIO=y
> > CONFIG_VFIO_NOIOMMU=y
> > CONFIG_VFIO_PCI_MMAP=y
> > CONFIG_VFIO_PCI_INTX=y
> > # CONFIG_VFIO_PCI is not set
> > # CONFIG_VFIO_PLATFORM is not set
> > # CONFIG_VFIO_MDEV is not set
> > # CONFIG_VIRT_DRIVERS is not set
> > CONFIG_VIRTIO_ANCHOR=y
> > CONFIG_VIRTIO=y
> > CONFIG_VIRTIO_PCI_LIB=y
> > CONFIG_VIRTIO_MENU=y
> > CONFIG_VIRTIO_PCI=y
> > # CONFIG_VIRTIO_PCI_LEGACY is not set
> > # CONFIG_VIRTIO_PMEM is not set
> > CONFIG_VIRTIO_BALLOON=y
> > CONFIG_VIRTIO_INPUT=y
> > # CONFIG_VIRTIO_MMIO is not set
> > CONFIG_VIRTIO_DMA_SHARED_BUFFER=y
> > # CONFIG_VHOST_MENU is not set
> >
> > #
> > # Microsoft Hyper-V guest support
> > #
> > # end of Microsoft Hyper-V guest support
> >
> > CONFIG_GREYBUS=y
> > CONFIG_GREYBUS_ES2=y
> > # CONFIG_COMEDI is not set
> > CONFIG_STAGING=y
> > # CONFIG_RTS5208 is not set
> >
> > #
> > # IIO staging drivers
> > #
> >
> > #
> > # Accelerometers
> > #
> > # end of Accelerometers
> >
> > #
> > # Analog to digital converters
> > #
> > # end of Analog to digital converters
> >
> > #
> > # Analog digital bi-direction converters
> > #
> > CONFIG_ADT7316=y
> > # CONFIG_ADT7316_I2C is not set
> > # end of Analog digital bi-direction converters
> >
> > #
> > # Direct Digital Synthesis
> > #
> > # end of Direct Digital Synthesis
> >
> > #
> > # Network Analyzer, Impedance Converters
> > #
> > CONFIG_AD5933=y
> > # end of Network Analyzer, Impedance Converters
> >
> > #
> > # Active energy metering IC
> > #
> > CONFIG_ADE7854=y
> > # CONFIG_ADE7854_I2C is not set
> > # end of Active energy metering IC
> >
> > #
> > # Resolver to digital converters
> > #
> > # end of Resolver to digital converters
> > # end of IIO staging drivers
> >
> > # CONFIG_USB_EMXX is not set
> > CONFIG_STAGING_MEDIA=y
> > # CONFIG_VIDEO_IMX_MEDIA is not set
> > # CONFIG_VIDEO_MESON_VDEC is not set
> > # CONFIG_VIDEO_OMAP4 is not set
> > # CONFIG_VIDEO_ROCKCHIP_VDEC is not set
> > # CONFIG_VIDEO_SUNXI is not set
> > # CONFIG_STAGING_MEDIA_DEPRECATED is not set
> > CONFIG_MOST_COMPONENTS=y
> > CONFIG_MOST_VIDEO=y
> > CONFIG_MOST_I2C=y
> > CONFIG_GREYBUS_AUDIO=y
> > CONFIG_GREYBUS_AUDIO_APB_CODEC=y
> > # CONFIG_GREYBUS_BOOTROM is not set
> > CONFIG_GREYBUS_HID=y
> > CONFIG_GREYBUS_LIGHT=y
> > CONFIG_GREYBUS_LOG=y
> > # CONFIG_GREYBUS_LOOPBACK is not set
> > CONFIG_GREYBUS_POWER=y
> > # CONFIG_GREYBUS_RAW is not set
> > CONFIG_GREYBUS_VIBRATOR=y
> > # CONFIG_GREYBUS_BRIDGED_PHY is not set
> > # CONFIG_GREYBUS_ARCHE is not set
> > CONFIG_FIELDBUS_DEV=y
> > CONFIG_VME_BUS=y
> >
> > #
> > # VME Bridge Drivers
> > #
> > CONFIG_VME_TSI148=y
> > CONFIG_VME_FAKE=y
> >
> > #
> > # VME Device Drivers
> > #
> > # CONFIG_VME_USER is not set
> > CONFIG_LOONGARCH_PLATFORM_DEVICES=y
> > CONFIG_LOONGSON_LAPTOP=y
> > CONFIG_GOLDFISH=y
> > CONFIG_GOLDFISH_PIPE=y
> > # CONFIG_CHROME_PLATFORMS is not set
> > # CONFIG_MELLANOX_PLATFORM is not set
> > # CONFIG_OLPC_XO175 is not set
> > CONFIG_SURFACE_PLATFORMS=y
> > # CONFIG_SURFACE_3_POWER_OPREGION is not set
> > # CONFIG_SURFACE_GPE is not set
> > # CONFIG_SURFACE_HOTPLUG is not set
> > # CONFIG_SURFACE_PRO3_BUTTON is not set
> > CONFIG_HAVE_CLK=y
> > CONFIG_HAVE_CLK_PREPARE=y
> > CONFIG_COMMON_CLK=y
> > # CONFIG_COMMON_CLK_WM831X is not set
> >
> > #
> > # Clock driver for ARM Reference designs
> > #
> > # CONFIG_CLK_ICST is not set
> > # CONFIG_CLK_SP810 is not set
> > # end of Clock driver for ARM Reference designs
> >
> > # CONFIG_CLK_HSDK is not set
> > # CONFIG_COMMON_CLK_APPLE_NCO is not set
> > # CONFIG_COMMON_CLK_MAX77686 is not set
> > CONFIG_COMMON_CLK_MAX9485=y
> > # CONFIG_COMMON_CLK_HI655X is not set
> > # CONFIG_COMMON_CLK_SCMI is not set
> > # CONFIG_COMMON_CLK_SCPI is not set
> > CONFIG_COMMON_CLK_SI5341=y
> > # CONFIG_COMMON_CLK_SI5351 is not set
> > CONFIG_COMMON_CLK_SI544=y
> > # CONFIG_COMMON_CLK_BM1880 is not set
> > CONFIG_COMMON_CLK_CDCE706=y
> > # CONFIG_COMMON_CLK_TPS68470 is not set
> > CONFIG_COMMON_CLK_CS2000_CP=y
> > # CONFIG_COMMON_CLK_FSL_FLEXSPI is not set
> > # CONFIG_COMMON_CLK_FSL_SAI is not set
> > # CONFIG_COMMON_CLK_GEMINI is not set
> > # CONFIG_COMMON_CLK_ASPEED is not set
> > # CONFIG_COMMON_CLK_S2MPS11 is not set
> > # CONFIG_CLK_LS1028A_PLLDIG is not set
> > # CONFIG_COMMON_CLK_XGENE is not set
> > CONFIG_COMMON_CLK_PALMAS=y
> > # CONFIG_COMMON_CLK_OXNAS is not set
> > # CONFIG_COMMON_CLK_MMP2_AUDIO is not set
> > # CONFIG_CLK_ACTIONS is not set
> > # CONFIG_CLK_BAIKAL_T1 is not set
> > # CONFIG_CLK_BCM2711_DVP is not set
> > # CONFIG_CLK_BCM2835 is not set
> > # CONFIG_CLK_BCM_63XX is not set
> > # CONFIG_CLK_BCM_63XX_GATE is not set
> > # CONFIG_CLK_BCM_KONA is not set
> > # CONFIG_CLK_BCM_CYGNUS is not set
> > # CONFIG_CLK_BCM_HR2 is not set
> > # CONFIG_CLK_BCM_NSP is not set
> > # CONFIG_CLK_BCM_NS2 is not set
> > # CONFIG_CLK_BCM_SR is not set
> > # CONFIG_CLK_RASPBERRYPI is not set
> > # CONFIG_COMMON_CLK_HI3516CV300 is not set
> > # CONFIG_COMMON_CLK_HI3519 is not set
> > # CONFIG_COMMON_CLK_HI3559A is not set
> > # CONFIG_COMMON_CLK_HI3660 is not set
> > # CONFIG_COMMON_CLK_HI3670 is not set
> > # CONFIG_COMMON_CLK_HI3798CV200 is not set
> > # CONFIG_COMMON_CLK_HI6220 is not set
> > # CONFIG_RESET_HISI is not set
> > # CONFIG_STUB_CLK_HI6220 is not set
> > # CONFIG_STUB_CLK_HI3660 is not set
> > # CONFIG_COMMON_CLK_BOSTON is not set
> > # CONFIG_MXC_CLK is not set
> > # CONFIG_CLK_IMX8MM is not set
> > # CONFIG_CLK_IMX8MN is not set
> > # CONFIG_CLK_IMX8MP is not set
> > # CONFIG_CLK_IMX8MQ is not set
> > # CONFIG_CLK_IMX8ULP is not set
> > # CONFIG_CLK_IMX93 is not set
> >
> > #
> > # Ingenic SoCs drivers
> > #
> > # CONFIG_INGENIC_CGU_JZ4740 is not set
> > # CONFIG_INGENIC_CGU_JZ4725B is not set
> > # CONFIG_INGENIC_CGU_JZ4760 is not set
> > # CONFIG_INGENIC_CGU_JZ4770 is not set
> > # CONFIG_INGENIC_CGU_JZ4780 is not set
> > # CONFIG_INGENIC_CGU_X1000 is not set
> > # CONFIG_INGENIC_CGU_X1830 is not set
> > # CONFIG_INGENIC_TCU_CLK is not set
> > # end of Ingenic SoCs drivers
> >
> > # CONFIG_TI_SYSCON_CLK is not set
> >
> > #
> > # Clock driver for MediaTek SoC
> > #
> > # CONFIG_COMMON_CLK_MT2701 is not set
> > # CONFIG_COMMON_CLK_MT2712 is not set
> > # CONFIG_COMMON_CLK_MT6765 is not set
> > # CONFIG_COMMON_CLK_MT6779 is not set
> > # CONFIG_COMMON_CLK_MT6795 is not set
> > # CONFIG_COMMON_CLK_MT6797 is not set
> > # CONFIG_COMMON_CLK_MT7622 is not set
> > # CONFIG_COMMON_CLK_MT7629 is not set
> > # CONFIG_COMMON_CLK_MT7986 is not set
> > # CONFIG_COMMON_CLK_MT8135 is not set
> > # CONFIG_COMMON_CLK_MT8167 is not set
> > # CONFIG_COMMON_CLK_MT8173 is not set
> > # CONFIG_COMMON_CLK_MT8183 is not set
> > # CONFIG_COMMON_CLK_MT8186 is not set
> > # CONFIG_COMMON_CLK_MT8192 is not set
> > # CONFIG_COMMON_CLK_MT8195 is not set
> > # CONFIG_COMMON_CLK_MT8365 is not set
> > # CONFIG_COMMON_CLK_MT8516 is not set
> > # end of Clock driver for MediaTek SoC
> >
> > #
> > # Clock support for Amlogic platforms
> > #
> > # end of Clock support for Amlogic platforms
> >
> > # CONFIG_MSTAR_MSC313_MPLL is not set
> > # CONFIG_MCHP_CLK_MPFS is not set
> > # CONFIG_COMMON_CLK_PISTACHIO is not set
> > # CONFIG_CLK_MT7621 is not set
> > # CONFIG_CLK_RENESAS is not set
> > # CONFIG_COMMON_CLK_SAMSUNG is not set
> > # CONFIG_S3C2410_COMMON_CLK is not set
> > # CONFIG_S3C2412_COMMON_CLK is not set
> > # CONFIG_S3C2443_COMMON_CLK is not set
> > # CONFIG_CLK_SIFIVE is not set
> > # CONFIG_CLK_INTEL_SOCFPGA is not set
> > # CONFIG_SPRD_COMMON_CLK is not set
> > # CONFIG_CLK_STARFIVE_JH7100 is not set
> > CONFIG_CLK_SUNXI=y
> > CONFIG_CLK_SUNXI_CLOCKS=y
> > CONFIG_CLK_SUNXI_PRCM_SUN6I=y
> > CONFIG_CLK_SUNXI_PRCM_SUN8I=y
> > CONFIG_CLK_SUNXI_PRCM_SUN9I=y
> > # CONFIG_SUNXI_CCU is not set
> > # CONFIG_COMMON_CLK_TI_ADPLL is not set
> > # CONFIG_COMMON_CLK_VISCONTI is not set
> > CONFIG_XILINX_VCU=y
> > # CONFIG_COMMON_CLK_ZYNQMP is not set
> > CONFIG_CLK_KUNIT_TEST=y
> > CONFIG_CLK_GATE_KUNIT_TEST=y
> > CONFIG_HWSPINLOCK=y
> > # CONFIG_HWSPINLOCK_OMAP is not set
> > # CONFIG_HWSPINLOCK_QCOM is not set
> > # CONFIG_HWSPINLOCK_SPRD is not set
> > # CONFIG_HWSPINLOCK_STM32 is not set
> > # CONFIG_HWSPINLOCK_SUN6I is not set
> > # CONFIG_HSEM_U8500 is not set
> >
> > #
> > # Clock Source drivers
> > #
> > # CONFIG_BCM2835_TIMER is not set
> > # CONFIG_BCM_KONA_TIMER is not set
> > # CONFIG_DAVINCI_TIMER is not set
> > # CONFIG_DIGICOLOR_TIMER is not set
> > # CONFIG_OMAP_DM_TIMER is not set
> > # CONFIG_DW_APB_TIMER is not set
> > # CONFIG_FTTMR010_TIMER is not set
> > # CONFIG_IXP4XX_TIMER is not set
> > # CONFIG_MESON6_TIMER is not set
> > # CONFIG_OWL_TIMER is not set
> > # CONFIG_RDA_TIMER is not set
> > # CONFIG_SUN4I_TIMER is not set
> > # CONFIG_SUN5I_HSTIMER is not set
> > # CONFIG_TEGRA_TIMER is not set
> > # CONFIG_TEGRA186_TIMER is not set
> > # CONFIG_VT8500_TIMER is not set
> > # CONFIG_NPCM7XX_TIMER is not set
> > # CONFIG_CADENCE_TTC_TIMER is not set
> > # CONFIG_ASM9260_TIMER is not set
> > # CONFIG_CLKSRC_DBX500_PRCMU is not set
> > # CONFIG_CLPS711X_TIMER is not set
> > # CONFIG_MXS_TIMER is not set
> > # CONFIG_NSPIRE_TIMER is not set
> > # CONFIG_INTEGRATOR_AP_TIMER is not set
> > # CONFIG_CLKSRC_PISTACHIO is not set
> > # CONFIG_CLKSRC_TI_32K is not set
> > # CONFIG_CLKSRC_STM32_LP is not set
> > # CONFIG_CLKSRC_MPS2 is not set
> > # CONFIG_ARC_TIMERS is not set
> > # CONFIG_ARM_TIMER_SP804 is not set
> > # CONFIG_ARMV7M_SYSTICK is not set
> > # CONFIG_ATMEL_PIT is not set
> > # CONFIG_ATMEL_ST is not set
> > # CONFIG_CLKSRC_SAMSUNG_PWM is not set
> > # CONFIG_FSL_FTM_TIMER is not set
> > # CONFIG_OXNAS_RPS_TIMER is not set
> > # CONFIG_MTK_TIMER is not set
> > # CONFIG_SPRD_TIMER is not set
> > # CONFIG_SH_TIMER_CMT is not set
> > # CONFIG_SH_TIMER_MTU2 is not set
> > # CONFIG_RENESAS_OSTM is not set
> > # CONFIG_SH_TIMER_TMU is not set
> > # CONFIG_EM_TIMER_STI is not set
> > # CONFIG_CLKSRC_VERSATILE is not set
> > # CONFIG_CLKSRC_PXA is not set
> > # CONFIG_TIMER_IMX_SYS_CTR is not set
> > # CONFIG_CLKSRC_ST_LPC is not set
> > # CONFIG_GXP_TIMER is not set
> > # CONFIG_MSC313E_TIMER is not set
> > # CONFIG_INGENIC_TIMER is not set
> > # CONFIG_INGENIC_SYSOST is not set
> > # CONFIG_INGENIC_OST is not set
> > # CONFIG_MICROCHIP_PIT64B is not set
> > # end of Clock Source drivers
> >
> > CONFIG_MAILBOX=y
> > # CONFIG_IMX_MBOX is not set
> > # CONFIG_ROCKCHIP_MBOX is not set
> > # CONFIG_PCC is not set
> > CONFIG_ALTERA_MBOX=y
> > # CONFIG_POLARFIRE_SOC_MAILBOX is not set
> > # CONFIG_QCOM_APCS_IPC is not set
> > # CONFIG_BCM_PDC_MBOX is not set
> > # CONFIG_STM32_IPCC is not set
> > # CONFIG_MTK_ADSP_MBOX is not set
> > # CONFIG_MTK_CMDQ_MBOX is not set
> > # CONFIG_SUN6I_MSGBOX is not set
> > # CONFIG_SPRD_MBOX is not set
> > # CONFIG_QCOM_IPCC is not set
> > CONFIG_IOMMU_API=y
> > CONFIG_IOMMU_SUPPORT=y
> >
> > #
> > # Generic IOMMU Pagetable Support
> > #
> > # CONFIG_IOMMU_IO_PGTABLE_LPAE is not set
> > # CONFIG_IOMMU_IO_PGTABLE_ARMV7S is not set
> > # CONFIG_IOMMU_IO_PGTABLE_DART is not set
> > # end of Generic IOMMU Pagetable Support
> >
> > CONFIG_IOMMU_DEBUGFS=y
> > CONFIG_IOMMU_DEFAULT_DMA_STRICT=y
> > # CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
> > # CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
> > # CONFIG_OMAP_IOMMU is not set
> > # CONFIG_ROCKCHIP_IOMMU is not set
> > # CONFIG_SUN50I_IOMMU is not set
> > # CONFIG_EXYNOS_IOMMU is not set
> > # CONFIG_IPMMU_VMSA is not set
> > # CONFIG_APPLE_DART is not set
> > # CONFIG_ARM_SMMU is not set
> > # CONFIG_S390_CCW_IOMMU is not set
> > # CONFIG_S390_AP_IOMMU is not set
> > # CONFIG_MTK_IOMMU is not set
> > # CONFIG_QCOM_IOMMU is not set
> > # CONFIG_SPRD_IOMMU is not set
> >
> > #
> > # Remoteproc drivers
> > #
> > CONFIG_REMOTEPROC=y
> > # CONFIG_REMOTEPROC_CDEV is not set
> > # CONFIG_INGENIC_VPU_RPROC is not set
> > # CONFIG_MTK_SCP is not set
> > # CONFIG_MESON_MX_AO_ARC_REMOTEPROC is not set
> > # CONFIG_RCAR_REMOTEPROC is not set
> > # end of Remoteproc drivers
> >
> > #
> > # Rpmsg drivers
> > #
> > CONFIG_RPMSG=y
> > # CONFIG_RPMSG_CTRL is not set
> > CONFIG_RPMSG_NS=y
> > CONFIG_RPMSG_QCOM_GLINK=y
> > CONFIG_RPMSG_QCOM_GLINK_RPM=y
> > CONFIG_RPMSG_VIRTIO=y
> > # end of Rpmsg drivers
> >
> > CONFIG_SOUNDWIRE=y
> >
> > #
> > # SoundWire Devices
> > #
> > CONFIG_SOUNDWIRE_CADENCE=y
> > CONFIG_SOUNDWIRE_INTEL=y
> > CONFIG_SOUNDWIRE_QCOM=y
> > CONFIG_SOUNDWIRE_GENERIC_ALLOCATION=y
> >
> > #
> > # SOC (System On Chip) specific Drivers
> > #
> >
> > #
> > # Amlogic SoC drivers
> > #
> > # CONFIG_MESON_CANVAS is not set
> > # CONFIG_MESON_CLK_MEASURE is not set
> > # CONFIG_MESON_GX_SOCINFO is not set
> > # CONFIG_MESON_MX_SOCINFO is not set
> > # end of Amlogic SoC drivers
> >
> > #
> > # Apple SoC drivers
> > #
> > # CONFIG_APPLE_RTKIT is not set
> > # CONFIG_APPLE_SART is not set
> > # end of Apple SoC drivers
> >
> > #
> > # ASPEED SoC drivers
> > #
> > # CONFIG_ASPEED_LPC_CTRL is not set
> > # CONFIG_ASPEED_LPC_SNOOP is not set
> > # CONFIG_ASPEED_UART_ROUTING is not set
> > # CONFIG_ASPEED_P2A_CTRL is not set
> > # CONFIG_ASPEED_SOCINFO is not set
> > # end of ASPEED SoC drivers
> >
> > # CONFIG_AT91_SOC_ID is not set
> > # CONFIG_AT91_SOC_SFR is not set
> >
> > #
> > # Broadcom SoC drivers
> > #
> > # CONFIG_SOC_BCM63XX is not set
> > # CONFIG_SOC_BRCMSTB is not set
> > # end of Broadcom SoC drivers
> >
> > #
> > # NXP/Freescale QorIQ SoC drivers
> > #
> > # end of NXP/Freescale QorIQ SoC drivers
> >
> > #
> > # fujitsu SoC drivers
> > #
> > # end of fujitsu SoC drivers
> >
> > #
> > # i.MX SoC drivers
> > #
> > # CONFIG_SOC_IMX8M is not set
> > # CONFIG_SOC_IMX9 is not set
> > # end of i.MX SoC drivers
> >
> > #
> > # IXP4xx SoC drivers
> > #
> > # CONFIG_IXP4XX_QMGR is not set
> > # CONFIG_IXP4XX_NPE is not set
> > # end of IXP4xx SoC drivers
> >
> > #
> > # Enable LiteX SoC Builder specific drivers
> > #
> > # CONFIG_LITEX_SOC_CONTROLLER is not set
> > # end of Enable LiteX SoC Builder specific drivers
> >
> > #
> > # MediaTek SoC drivers
> > #
> > # CONFIG_MTK_CMDQ is not set
> > # CONFIG_MTK_DEVAPC is not set
> > # CONFIG_MTK_INFRACFG is not set
> > # CONFIG_MTK_MMSYS is not set
> > # end of MediaTek SoC drivers
> >
> > #
> > # Qualcomm SoC drivers
> > #
> > # CONFIG_QCOM_GENI_SE is not set
> > # CONFIG_QCOM_GSBI is not set
> > # CONFIG_QCOM_LLCC is not set
> > # CONFIG_QCOM_RPMH is not set
> > # CONFIG_QCOM_SMEM is not set
> > # CONFIG_QCOM_SMD_RPM is not set
> > # CONFIG_QCOM_SPM is not set
> > # CONFIG_QCOM_WCNSS_CTRL is not set
> > # CONFIG_QCOM_ICC_BWMON is not set
> > # end of Qualcomm SoC drivers
> >
> > # CONFIG_SOC_RENESAS is not set
> > # CONFIG_ROCKCHIP_GRF is not set
> > # CONFIG_SOC_SAMSUNG is not set
> > # CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER is not set
> > # CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER is not set
> > # CONFIG_SOC_TI is not set
> > # CONFIG_UX500_SOC_ID is not set
> >
> > #
> > # Xilinx SoC drivers
> > #
> > # end of Xilinx SoC drivers
> > # end of SOC (System On Chip) specific Drivers
> >
> > CONFIG_PM_DEVFREQ=y
> >
> > #
> > # DEVFREQ Governors
> > #
> > CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
> > # CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
> > CONFIG_DEVFREQ_GOV_POWERSAVE=y
> > # CONFIG_DEVFREQ_GOV_USERSPACE is not set
> > CONFIG_DEVFREQ_GOV_PASSIVE=y
> >
> > #
> > # DEVFREQ Drivers
> > #
> > # CONFIG_ARM_EXYNOS_BUS_DEVFREQ is not set
> > # CONFIG_ARM_IMX_BUS_DEVFREQ is not set
> > # CONFIG_ARM_TEGRA_DEVFREQ is not set
> > # CONFIG_ARM_MEDIATEK_CCI_DEVFREQ is not set
> > # CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ is not set
> > # CONFIG_PM_DEVFREQ_EVENT is not set
> > CONFIG_EXTCON=y
> >
> > #
> > # Extcon Device Drivers
> > #
> > CONFIG_EXTCON_ADC_JACK=y
> > CONFIG_EXTCON_FSA9480=y
> > CONFIG_EXTCON_GPIO=y
> > # CONFIG_EXTCON_INTEL_INT3496 is not set
> > # CONFIG_EXTCON_MAX14577 is not set
> > CONFIG_EXTCON_MAX3355=y
> > # CONFIG_EXTCON_MAX77843 is not set
> > CONFIG_EXTCON_MAX8997=y
> > CONFIG_EXTCON_PALMAS=y
> > # CONFIG_EXTCON_PTN5150 is not set
> > # CONFIG_EXTCON_QCOM_SPMI_MISC is not set
> > # CONFIG_EXTCON_RT8973A is not set
> > CONFIG_EXTCON_SM5502=y
> > CONFIG_EXTCON_USB_GPIO=y
> > CONFIG_EXTCON_USBC_TUSB320=y
> > # CONFIG_MEMORY is not set
> > CONFIG_IIO=y
> > CONFIG_IIO_BUFFER=y
> > CONFIG_IIO_BUFFER_CB=y
> > CONFIG_IIO_BUFFER_DMA=y
> > CONFIG_IIO_BUFFER_DMAENGINE=y
> > # CONFIG_IIO_BUFFER_HW_CONSUMER is not set
> > CONFIG_IIO_KFIFO_BUF=y
> > CONFIG_IIO_TRIGGERED_BUFFER=y
> > CONFIG_IIO_CONFIGFS=y
> > CONFIG_IIO_TRIGGER=y
> > CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> > CONFIG_IIO_SW_DEVICE=y
> > CONFIG_IIO_SW_TRIGGER=y
> > CONFIG_IIO_TRIGGERED_EVENT=y
> >
> > #
> > # Accelerometers
> > #
> > CONFIG_ADXL313=y
> > CONFIG_ADXL313_I2C=y
> > CONFIG_ADXL345=y
> > CONFIG_ADXL345_I2C=y
> > CONFIG_ADXL355=y
> > CONFIG_ADXL355_I2C=y
> > CONFIG_ADXL367=y
> > CONFIG_ADXL367_I2C=y
> > CONFIG_ADXL372=y
> > CONFIG_ADXL372_I2C=y
> > CONFIG_BMA180=y
> > CONFIG_BMA400=y
> > CONFIG_BMA400_I2C=y
> > # CONFIG_BMC150_ACCEL is not set
> > # CONFIG_DA280 is not set
> > CONFIG_DA311=y
> > # CONFIG_DMARD06 is not set
> > # CONFIG_DMARD09 is not set
> > CONFIG_DMARD10=y
> > CONFIG_FXLS8962AF=y
> > CONFIG_FXLS8962AF_I2C=y
> > CONFIG_HID_SENSOR_ACCEL_3D=y
> > # CONFIG_IIO_ST_ACCEL_3AXIS is not set
> > CONFIG_KXSD9=y
> > # CONFIG_KXSD9_I2C is not set
> > CONFIG_KXCJK1013=y
> > CONFIG_MC3230=y
> > # CONFIG_MMA7455_I2C is not set
> > CONFIG_MMA7660=y
> > CONFIG_MMA8452=y
> > CONFIG_MMA9551_CORE=y
> > CONFIG_MMA9551=y
> > CONFIG_MMA9553=y
> > # CONFIG_MSA311 is not set
> > CONFIG_MXC4005=y
> > # CONFIG_MXC6255 is not set
> > CONFIG_STK8312=y
> > # CONFIG_STK8BA50 is not set
> > # end of Accelerometers
> >
> > #
> > # Analog to digital converters
> > #
> > CONFIG_AD7091R5=y
> > CONFIG_AD7291=y
> > CONFIG_AD7606=y
> > CONFIG_AD7606_IFACE_PARALLEL=y
> > CONFIG_AD799X=y
> > # CONFIG_ASPEED_ADC is not set
> > # CONFIG_AT91_SAMA5D2_ADC is not set
> > # CONFIG_BCM_IPROC_ADC is not set
> > # CONFIG_BERLIN2_ADC is not set
> > CONFIG_CC10001_ADC=y
> > CONFIG_DLN2_ADC=y
> > CONFIG_ENVELOPE_DETECTOR=y
> > CONFIG_HX711=y
> > # CONFIG_INGENIC_ADC is not set
> > # CONFIG_IMX7D_ADC is not set
> > # CONFIG_IMX8QXP_ADC is not set
> > # CONFIG_LP8788_ADC is not set
> > # CONFIG_LPC18XX_ADC is not set
> > # CONFIG_LPC32XX_ADC is not set
> > # CONFIG_LTC2471 is not set
> > # CONFIG_LTC2485 is not set
> > CONFIG_LTC2497=y
> > CONFIG_MAX1363=y
> > CONFIG_MAX9611=y
> > CONFIG_MCP3422=y
> > CONFIG_MEDIATEK_MT6360_ADC=y
> > # CONFIG_MEDIATEK_MT6577_AUXADC is not set
> > CONFIG_MEN_Z188_ADC=y
> > CONFIG_MP2629_ADC=y
> > CONFIG_NAU7802=y
> > # CONFIG_NPCM_ADC is not set
> > CONFIG_PALMAS_GPADC=y
> > # CONFIG_RCAR_GYRO_ADC is not set
> > # CONFIG_ROCKCHIP_SARADC is not set
> > # CONFIG_RICHTEK_RTQ6056 is not set
> > # CONFIG_RZG2L_ADC is not set
> > # CONFIG_SC27XX_ADC is not set
> > # CONFIG_SPEAR_ADC is not set
> > CONFIG_SD_ADC_MODULATOR=y
> > # CONFIG_STM32_DFSDM_CORE is not set
> > # CONFIG_STM32_DFSDM_ADC is not set
> > CONFIG_TI_ADC081C=y
> > # CONFIG_TI_ADS1015 is not set
> > # CONFIG_VF610_ADC is not set
> > CONFIG_XILINX_XADC=y
> > # CONFIG_XILINX_AMS is not set
> > # end of Analog to digital converters
> >
> > #
> > # Analog to digital and digital to analog converters
> > #
> > # end of Analog to digital and digital to analog converters
> >
> > #
> > # Analog Front Ends
> > #
> > CONFIG_IIO_RESCALE=y
> > # end of Analog Front Ends
> >
> > #
> > # Amplifiers
> > #
> > CONFIG_HMC425=y
> > # end of Amplifiers
> >
> > #
> > # Capacitance to digital converters
> > #
> > # CONFIG_AD7150 is not set
> > CONFIG_AD7746=y
> > # end of Capacitance to digital converters
> >
> > #
> > # Chemical Sensors
> > #
> > CONFIG_ATLAS_PH_SENSOR=y
> > CONFIG_ATLAS_EZO_SENSOR=y
> > CONFIG_BME680=y
> > CONFIG_BME680_I2C=y
> > CONFIG_CCS811=y
> > CONFIG_IAQCORE=y
> > CONFIG_SCD30_CORE=y
> > # CONFIG_SCD30_I2C is not set
> > CONFIG_SCD4X=y
> > # CONFIG_SENSIRION_SGP30 is not set
> > # CONFIG_SENSIRION_SGP40 is not set
> > # CONFIG_SPS30_I2C is not set
> > CONFIG_SENSEAIR_SUNRISE_CO2=y
> > CONFIG_VZ89X=y
> > # end of Chemical Sensors
> >
> > #
> > # Hid Sensor IIO Common
> > #
> > CONFIG_HID_SENSOR_IIO_COMMON=y
> > CONFIG_HID_SENSOR_IIO_TRIGGER=y
> > # end of Hid Sensor IIO Common
> >
> > CONFIG_IIO_MS_SENSORS_I2C=y
> >
> > #
> > # IIO SCMI Sensors
> > #
> > # end of IIO SCMI Sensors
> >
> > #
> > # SSP Sensor Common
> > #
> > # end of SSP Sensor Common
> >
> > CONFIG_IIO_ST_SENSORS_CORE=y
> >
> > #
> > # Digital to analog converters
> > #
> > # CONFIG_AD5064 is not set
> > CONFIG_AD5380=y
> > CONFIG_AD5446=y
> > # CONFIG_AD5593R is not set
> > # CONFIG_AD5696_I2C is not set
> > # CONFIG_DPOT_DAC is not set
> > CONFIG_DS4424=y
> > # CONFIG_LPC18XX_DAC is not set
> > CONFIG_M62332=y
> > # CONFIG_MAX517 is not set
> > CONFIG_MAX5821=y
> > CONFIG_MCP4725=y
> > # CONFIG_STM32_DAC is not set
> > CONFIG_TI_DAC5571=y
> > CONFIG_VF610_DAC=y
> > # end of Digital to analog converters
> >
> > #
> > # IIO dummy driver
> > #
> > CONFIG_IIO_DUMMY_EVGEN=y
> > CONFIG_IIO_SIMPLE_DUMMY=y
> > CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
> > # CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
> > # end of IIO dummy driver
> >
> > #
> > # Filters
> > #
> > # end of Filters
> >
> > #
> > # Frequency Synthesizers DDS/PLL
> > #
> >
> > #
> > # Clock Generator/Distribution
> > #
> > # end of Clock Generator/Distribution
> >
> > #
> > # Phase-Locked Loop (PLL) frequency synthesizers
> > #
> > # end of Phase-Locked Loop (PLL) frequency synthesizers
> > # end of Frequency Synthesizers DDS/PLL
> >
> > #
> > # Digital gyroscope sensors
> > #
> > # CONFIG_BMG160 is not set
> > # CONFIG_FXAS21002C is not set
> > CONFIG_HID_SENSOR_GYRO_3D=y
> > # CONFIG_MPU3050_I2C is not set
> > CONFIG_IIO_ST_GYRO_3AXIS=y
> > # CONFIG_IIO_ST_GYRO_I2C_3AXIS is not set
> > CONFIG_ITG3200=y
> > # end of Digital gyroscope sensors
> >
> > #
> > # Health Sensors
> > #
> >
> > #
> > # Heart Rate Monitors
> > #
> > CONFIG_AFE4404=y
> > CONFIG_MAX30100=y
> > CONFIG_MAX30102=y
> > # end of Heart Rate Monitors
> > # end of Health Sensors
> >
> > #
> > # Humidity sensors
> > #
> > CONFIG_AM2315=y
> > # CONFIG_DHT11 is not set
> > CONFIG_HDC100X=y
> > CONFIG_HDC2010=y
> > CONFIG_HID_SENSOR_HUMIDITY=y
> > CONFIG_HTS221=y
> > CONFIG_HTS221_I2C=y
> > CONFIG_HTU21=y
> > CONFIG_SI7005=y
> > CONFIG_SI7020=y
> > # end of Humidity sensors
> >
> > #
> > # Inertial measurement units
> > #
> > # CONFIG_BMI160_I2C is not set
> > # CONFIG_BOSCH_BNO055_I2C is not set
> > CONFIG_FXOS8700=y
> > CONFIG_FXOS8700_I2C=y
> > CONFIG_KMX61=y
> > CONFIG_INV_ICM42600=y
> > CONFIG_INV_ICM42600_I2C=y
> > # CONFIG_INV_MPU6050_I2C is not set
> > CONFIG_IIO_ST_LSM6DSX=y
> > CONFIG_IIO_ST_LSM6DSX_I2C=y
> > # CONFIG_IIO_ST_LSM9DS0 is not set
> > # end of Inertial measurement units
> >
> > #
> > # Light sensors
> > #
> > # CONFIG_ACPI_ALS is not set
> > CONFIG_ADJD_S311=y
> > CONFIG_ADUX1020=y
> > # CONFIG_AL3010 is not set
> > # CONFIG_AL3320A is not set
> > CONFIG_APDS9300=y
> > CONFIG_APDS9960=y
> > CONFIG_AS73211=y
> > CONFIG_BH1750=y
> > CONFIG_BH1780=y
> > CONFIG_CM32181=y
> > # CONFIG_CM3232 is not set
> > CONFIG_CM3323=y
> > # CONFIG_CM3605 is not set
> > # CONFIG_CM36651 is not set
> > # CONFIG_GP2AP002 is not set
> > # CONFIG_GP2AP020A00F is not set
> > CONFIG_IQS621_ALS=y
> > CONFIG_SENSORS_ISL29018=y
> > CONFIG_SENSORS_ISL29028=y
> > # CONFIG_ISL29125 is not set
> > # CONFIG_HID_SENSOR_ALS is not set
> > CONFIG_HID_SENSOR_PROX=y
> > CONFIG_JSA1212=y
> > CONFIG_RPR0521=y
> > # CONFIG_SENSORS_LM3533 is not set
> > CONFIG_LTR501=y
> > # CONFIG_LTRF216A is not set
> > CONFIG_LV0104CS=y
> > CONFIG_MAX44000=y
> > CONFIG_MAX44009=y
> > CONFIG_NOA1305=y
> > CONFIG_OPT3001=y
> > CONFIG_PA12203001=y
> > CONFIG_SI1133=y
> > CONFIG_SI1145=y
> > CONFIG_STK3310=y
> > # CONFIG_ST_UVIS25 is not set
> > CONFIG_TCS3414=y
> > # CONFIG_TCS3472 is not set
> > CONFIG_SENSORS_TSL2563=y
> > CONFIG_TSL2583=y
> > CONFIG_TSL2591=y
> > # CONFIG_TSL2772 is not set
> > CONFIG_TSL4531=y
> > CONFIG_US5182D=y
> > CONFIG_VCNL4000=y
> > # CONFIG_VCNL4035 is not set
> > CONFIG_VEML6030=y
> > # CONFIG_VEML6070 is not set
> > CONFIG_VL6180=y
> > CONFIG_ZOPT2201=y
> > # end of Light sensors
> >
> > #
> > # Magnetometer sensors
> > #
> > CONFIG_AK8974=y
> > CONFIG_AK8975=y
> > # CONFIG_AK09911 is not set
> > CONFIG_BMC150_MAGN=y
> > CONFIG_BMC150_MAGN_I2C=y
> > CONFIG_MAG3110=y
> > CONFIG_HID_SENSOR_MAGNETOMETER_3D=y
> > CONFIG_MMC35240=y
> > CONFIG_IIO_ST_MAGN_3AXIS=y
> > # CONFIG_IIO_ST_MAGN_I2C_3AXIS is not set
> > CONFIG_SENSORS_HMC5843=y
> > CONFIG_SENSORS_HMC5843_I2C=y
> > CONFIG_SENSORS_RM3100=y
> > CONFIG_SENSORS_RM3100_I2C=y
> > CONFIG_YAMAHA_YAS530=y
> > # end of Magnetometer sensors
> >
> > #
> > # Multiplexers
> > #
> > # CONFIG_IIO_MUX is not set
> > # end of Multiplexers
> >
> > #
> > # Inclinometer sensors
> > #
> > CONFIG_HID_SENSOR_INCLINOMETER_3D=y
> > CONFIG_HID_SENSOR_DEVICE_ROTATION=y
> > # end of Inclinometer sensors
> >
> > CONFIG_IIO_RESCALE_KUNIT_TEST=y
> > CONFIG_IIO_FORMAT_KUNIT_TEST=y
> >
> > #
> > # Triggers - standalone
> > #
> > CONFIG_IIO_HRTIMER_TRIGGER=y
> > CONFIG_IIO_INTERRUPT_TRIGGER=y
> > # CONFIG_IIO_STM32_LPTIMER_TRIGGER is not set
> > # CONFIG_IIO_STM32_TIMER_TRIGGER is not set
> > CONFIG_IIO_TIGHTLOOP_TRIGGER=y
> > CONFIG_IIO_SYSFS_TRIGGER=y
> > # end of Triggers - standalone
> >
> > #
> > # Linear and angular position sensors
> > #
> > CONFIG_IQS624_POS=y
> > CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE=y
> > # end of Linear and angular position sensors
> >
> > #
> > # Digital potentiometers
> > #
> > CONFIG_AD5110=y
> > CONFIG_AD5272=y
> > CONFIG_DS1803=y
> > CONFIG_MAX5432=y
> > CONFIG_MCP4018=y
> > CONFIG_MCP4531=y
> > CONFIG_TPL0102=y
> > # end of Digital potentiometers
> >
> > #
> > # Digital potentiostats
> > #
> > CONFIG_LMP91000=y
> > # end of Digital potentiostats
> >
> > #
> > # Pressure sensors
> > #
> > # CONFIG_ABP060MG is not set
> > # CONFIG_BMP280 is not set
> > # CONFIG_DLHL60D is not set
> > CONFIG_DPS310=y
> > CONFIG_HID_SENSOR_PRESS=y
> > CONFIG_HP03=y
> > CONFIG_ICP10100=y
> > # CONFIG_MPL115_I2C is not set
> > # CONFIG_MPL3115 is not set
> > # CONFIG_MS5611 is not set
> > CONFIG_MS5637=y
> > CONFIG_IIO_ST_PRESS=y
> > # CONFIG_IIO_ST_PRESS_I2C is not set
> > # CONFIG_T5403 is not set
> > CONFIG_HP206C=y
> > CONFIG_ZPA2326=y
> > CONFIG_ZPA2326_I2C=y
> > # end of Pressure sensors
> >
> > #
> > # Lightning sensors
> > #
> > # end of Lightning sensors
> >
> > #
> > # Proximity and distance sensors
> > #
> > # CONFIG_ISL29501 is not set
> > # CONFIG_LIDAR_LITE_V2 is not set
> > CONFIG_MB1232=y
> > CONFIG_PING=y
> > # CONFIG_RFD77402 is not set
> > # CONFIG_SRF04 is not set
> > CONFIG_SX_COMMON=y
> > CONFIG_SX9310=y
> > # CONFIG_SX9324 is not set
> > CONFIG_SX9360=y
> > CONFIG_SX9500=y
> > CONFIG_SRF08=y
> > CONFIG_VCNL3020=y
> > CONFIG_VL53L0X_I2C=y
> > # end of Proximity and distance sensors
> >
> > #
> > # Resolver to digital converters
> > #
> > # end of Resolver to digital converters
> >
> > #
> > # Temperature sensors
> > #
> > # CONFIG_IQS620AT_TEMP is not set
> > CONFIG_HID_SENSOR_TEMP=y
> > CONFIG_MLX90614=y
> > # CONFIG_MLX90632 is not set
> > CONFIG_TMP006=y
> > # CONFIG_TMP007 is not set
> > CONFIG_TMP117=y
> > CONFIG_TSYS01=y
> > # CONFIG_TSYS02D is not set
> > # end of Temperature sensors
> >
> > # CONFIG_NTB is not set
> > # CONFIG_PWM is not set
> >
> > #
> > # IRQ chip support
> > #
> > CONFIG_IRQCHIP=y
> > # CONFIG_AL_FIC is not set
> > CONFIG_MADERA_IRQ=y
> > # CONFIG_RENESAS_INTC_IRQPIN is not set
> > # CONFIG_RENESAS_IRQC is not set
> > # CONFIG_RENESAS_RZA1_IRQC is not set
> > # CONFIG_RENESAS_RZG2L_IRQC is not set
> > # CONFIG_SL28CPLD_INTC is not set
> > # CONFIG_TS4800_IRQ is not set
> > # CONFIG_INGENIC_TCU_IRQ is not set
> > # CONFIG_IRQ_UNIPHIER_AIDET is not set
> > # CONFIG_MESON_IRQ_GPIO is not set
> > # CONFIG_IMX_IRQSTEER is not set
> > # CONFIG_IMX_INTMUX is not set
> > # CONFIG_EXYNOS_IRQ_COMBINER is not set
> > CONFIG_IRQ_LOONGARCH_CPU=y
> > CONFIG_LOONGSON_LIOINTC=y
> > CONFIG_LOONGSON_EIOINTC=y
> > CONFIG_LOONGSON_HTVEC=y
> > CONFIG_LOONGSON_PCH_PIC=y
> > CONFIG_LOONGSON_PCH_MSI=y
> > CONFIG_LOONGSON_PCH_LPC=y
> > # CONFIG_MST_IRQ is not set
> > # CONFIG_MCHP_EIC is not set
> > # CONFIG_SUNPLUS_SP7021_INTC is not set
> > # end of IRQ chip support
> >
> > # CONFIG_IPACK_BUS is not set
> > CONFIG_RESET_CONTROLLER=y
> > # CONFIG_RESET_A10SR is not set
> > # CONFIG_RESET_ATH79 is not set
> > # CONFIG_RESET_AXS10X is not set
> > # CONFIG_RESET_BCM6345 is not set
> > # CONFIG_RESET_BERLIN is not set
> > # CONFIG_RESET_BRCMSTB is not set
> > # CONFIG_RESET_BRCMSTB_RESCAL is not set
> > # CONFIG_RESET_HSDK is not set
> > # CONFIG_RESET_IMX7 is not set
> > # CONFIG_RESET_LANTIQ is not set
> > # CONFIG_RESET_LPC18XX is not set
> > # CONFIG_RESET_MCHP_SPARX5 is not set
> > # CONFIG_RESET_MESON is not set
> > # CONFIG_RESET_MESON_AUDIO_ARB is not set
> > # CONFIG_RESET_NPCM is not set
> > # CONFIG_RESET_PISTACHIO is not set
> > # CONFIG_RESET_QCOM_AOSS is not set
> > # CONFIG_RESET_QCOM_PDC is not set
> > CONFIG_RESET_RASPBERRYPI=y
> > # CONFIG_RESET_RZG2L_USBPHY_CTRL is not set
> > # CONFIG_RESET_SCMI is not set
> > CONFIG_RESET_SIMPLE=y
> > # CONFIG_RESET_SOCFPGA is not set
> > # CONFIG_RESET_STARFIVE_JH7100 is not set
> > # CONFIG_RESET_SUNPLUS is not set
> > # CONFIG_RESET_SUNXI is not set
> > # CONFIG_RESET_TI_SCI is not set
> > # CONFIG_RESET_TI_SYSCON is not set
> > # CONFIG_RESET_TI_TPS380X is not set
> > # CONFIG_RESET_TN48M_CPLD is not set
> > # CONFIG_RESET_ZYNQ is not set
> > # CONFIG_COMMON_RESET_HI3660 is not set
> > # CONFIG_COMMON_RESET_HI6220 is not set
> >
> > #
> > # PHY Subsystem
> > #
> > CONFIG_GENERIC_PHY=y
> > # CONFIG_PHY_PISTACHIO_USB is not set
> > # CONFIG_USB_LGM_PHY is not set
> > CONFIG_PHY_CAN_TRANSCEIVER=y
> > # CONFIG_PHY_SUN4I_USB is not set
> > # CONFIG_PHY_SUN6I_MIPI_DPHY is not set
> > # CONFIG_PHY_SUN9I_USB is not set
> >
> > #
> > # PHY drivers for Broadcom platforms
> > #
> > # CONFIG_PHY_BCM63XX_USBH is not set
> > CONFIG_BCM_KONA_USB2_PHY=y
> > # end of PHY drivers for Broadcom platforms
> >
> > # CONFIG_PHY_HI6220_USB is not set
> > # CONFIG_PHY_HI3660_USB is not set
> > # CONFIG_PHY_HI3670_USB is not set
> > # CONFIG_PHY_HI3670_PCIE is not set
> > # CONFIG_PHY_HISTB_COMBPHY is not set
> > # CONFIG_PHY_HISI_INNO_USB2 is not set
> > # CONFIG_PHY_INGENIC_USB is not set
> > # CONFIG_PHY_PXA_28NM_HSIC is not set
> > # CONFIG_PHY_PXA_28NM_USB2 is not set
> > # CONFIG_PHY_PXA_USB is not set
> > # CONFIG_PHY_MMP3_USB is not set
> > # CONFIG_PHY_MMP3_HSIC is not set
> > CONFIG_PHY_CPCAP_USB=y
> > CONFIG_PHY_QCOM_USB_HS=y
> > # CONFIG_PHY_QCOM_USB_HSIC is not set
> > # CONFIG_PHY_MT7621_PCI is not set
> > # CONFIG_PHY_RALINK_USB is not set
> > # CONFIG_PHY_RCAR_GEN3_USB3 is not set
> > # CONFIG_PHY_ROCKCHIP_DPHY_RX0 is not set
> > # CONFIG_PHY_ROCKCHIP_PCIE is not set
> > # CONFIG_PHY_ROCKCHIP_SNPS_PCIE3 is not set
> > # CONFIG_PHY_EXYNOS_MIPI_VIDEO is not set
> > # CONFIG_PHY_SAMSUNG_USB2 is not set
> > # CONFIG_PHY_ST_SPEAR1310_MIPHY is not set
> > # CONFIG_PHY_ST_SPEAR1340_MIPHY is not set
> > # CONFIG_PHY_STIH407_USB is not set
> > # CONFIG_PHY_STM32_USBPHYC is not set
> > # CONFIG_PHY_TEGRA194_P2U is not set
> > # CONFIG_PHY_DA8XX_USB is not set
> > # CONFIG_PHY_DM816X_USB is not set
> > # CONFIG_PHY_AM654_SERDES is not set
> > # CONFIG_OMAP_CONTROL_PHY is not set
> > # CONFIG_TI_PIPE3 is not set
> > CONFIG_PHY_TUSB1210=y
> > # CONFIG_PHY_INTEL_KEEMBAY_EMMC is not set
> > # CONFIG_PHY_INTEL_KEEMBAY_USB is not set
> > # CONFIG_PHY_INTEL_LGM_EMMC is not set
> > # CONFIG_PHY_XILINX_ZYNQMP is not set
> > # end of PHY Subsystem
> >
> > # CONFIG_POWERCAP is not set
> > CONFIG_MCB=y
> > # CONFIG_MCB_PCI is not set
> > CONFIG_MCB_LPC=y
> > # CONFIG_RAS is not set
> > CONFIG_USB4=y
> > # CONFIG_USB4_DEBUGFS_WRITE is not set
> > CONFIG_USB4_KUNIT_TEST=y
> > # CONFIG_USB4_DMA_TEST is not set
> >
> > #
> > # Android
> > #
> > # CONFIG_ANDROID_BINDER_IPC is not set
> > # end of Android
> >
> > CONFIG_LIBNVDIMM=y
> > CONFIG_BLK_DEV_PMEM=y
> > # CONFIG_BTT is not set
> > CONFIG_DAX=y
> > # CONFIG_DEV_DAX is not set
> > CONFIG_NVMEM=y
> > CONFIG_NVMEM_SYSFS=y
> > # CONFIG_NVMEM_APPLE_EFUSES is not set
> > # CONFIG_NVMEM_BCM_OCOTP is not set
> > # CONFIG_NVMEM_BRCM_NVRAM is not set
> > # CONFIG_NVMEM_IMX_IIM is not set
> > # CONFIG_NVMEM_IMX_OCOTP is not set
> > # CONFIG_NVMEM_LAN9662_OTPC is not set
> > # CONFIG_NVMEM_LAYERSCAPE_SFP is not set
> > # CONFIG_NVMEM_LPC18XX_EEPROM is not set
> > # CONFIG_NVMEM_LPC18XX_OTP is not set
> > # CONFIG_NVMEM_MESON_MX_EFUSE is not set
> > # CONFIG_NVMEM_MICROCHIP_OTPC is not set
> > # CONFIG_NVMEM_MTK_EFUSE is not set
> > # CONFIG_NVMEM_MXS_OCOTP is not set
> > # CONFIG_NVMEM_NINTENDO_OTP is not set
> > # CONFIG_NVMEM_QCOM_QFPROM is not set
> > CONFIG_NVMEM_RMEM=y
> > # CONFIG_NVMEM_ROCKCHIP_EFUSE is not set
> > # CONFIG_NVMEM_ROCKCHIP_OTP is not set
> > # CONFIG_NVMEM_SC27XX_EFUSE is not set
> > # CONFIG_NVMEM_SNVS_LPGPR is not set
> > # CONFIG_NVMEM_SPRD_EFUSE is not set
> > # CONFIG_NVMEM_STM32_ROMEM is not set
> > # CONFIG_NVMEM_SUNPLUS_OCOTP is not set
> > # CONFIG_NVMEM_UNIPHIER_EFUSE is not set
> > # CONFIG_NVMEM_VF610_OCOTP is not set
> >
> > #
> > # HW tracing support
> > #
> > CONFIG_STM=y
> > # CONFIG_STM_PROTO_BASIC is not set
> > CONFIG_STM_PROTO_SYS_T=y
> > CONFIG_STM_DUMMY=y
> > # CONFIG_STM_SOURCE_CONSOLE is not set
> > # CONFIG_STM_SOURCE_HEARTBEAT is not set
> > CONFIG_INTEL_TH=y
> > CONFIG_INTEL_TH_PCI=y
> > # CONFIG_INTEL_TH_ACPI is not set
> > CONFIG_INTEL_TH_GTH=y
> > CONFIG_INTEL_TH_STH=y
> > CONFIG_INTEL_TH_MSU=y
> > CONFIG_INTEL_TH_PTI=y
> > # CONFIG_INTEL_TH_DEBUG is not set
> > # end of HW tracing support
> >
> > # CONFIG_FPGA is not set
> > # CONFIG_TEE is not set
> > CONFIG_MULTIPLEXER=y
> >
> > #
> > # Multiplexer drivers
> > #
> > # CONFIG_MUX_ADG792A is not set
> > # CONFIG_MUX_GPIO is not set
> > # CONFIG_MUX_MMIO is not set
> > # end of Multiplexer drivers
> >
> > CONFIG_PM_OPP=y
> > CONFIG_SIOX=y
> > # CONFIG_SIOX_BUS_GPIO is not set
> > CONFIG_SLIMBUS=y
> > # CONFIG_SLIM_QCOM_CTRL is not set
> > CONFIG_INTERCONNECT=y
> > # CONFIG_INTERCONNECT_IMX is not set
> > # CONFIG_INTERCONNECT_QCOM_OSM_L3 is not set
> > # CONFIG_INTERCONNECT_SAMSUNG is not set
> > CONFIG_COUNTER=y
> > # CONFIG_104_QUAD_8 is not set
> > # CONFIG_INTERRUPT_CNT is not set
> > # CONFIG_STM32_TIMER_CNT is not set
> > # CONFIG_STM32_LPTIMER_CNT is not set
> > # CONFIG_TI_EQEP is not set
> > # CONFIG_INTEL_QEP is not set
> > # CONFIG_TI_ECAP_CAPTURE is not set
> > CONFIG_MOST=y
> > # CONFIG_MOST_USB_HDM is not set
> > CONFIG_MOST_CDEV=y
> > CONFIG_MOST_SND=y
> > CONFIG_PECI=y
> > CONFIG_PECI_CPU=y
> > # CONFIG_HTE is not set
> > # end of Device Drivers
> >
> > #
> > # File systems
> > #
> > CONFIG_VALIDATE_FS_PARSER=y
> > CONFIG_FS_IOMAP=y
> > CONFIG_EXT2_FS=y
> > # CONFIG_EXT2_FS_XATTR is not set
> > CONFIG_EXT3_FS=y
> > # CONFIG_EXT3_FS_POSIX_ACL is not set
> > CONFIG_EXT3_FS_SECURITY=y
> > CONFIG_EXT4_FS=y
> > CONFIG_EXT4_FS_POSIX_ACL=y
> > CONFIG_EXT4_FS_SECURITY=y
> > CONFIG_EXT4_DEBUG=y
> > CONFIG_EXT4_KUNIT_TESTS=y
> > CONFIG_JBD2=y
> > CONFIG_JBD2_DEBUG=y
> > CONFIG_FS_MBCACHE=y
> > CONFIG_REISERFS_FS=y
> > # CONFIG_REISERFS_CHECK is not set
> > # CONFIG_REISERFS_FS_XATTR is not set
> > CONFIG_JFS_FS=y
> > # CONFIG_JFS_POSIX_ACL is not set
> > CONFIG_JFS_SECURITY=y
> > # CONFIG_JFS_DEBUG is not set
> > CONFIG_JFS_STATISTICS=y
> > # CONFIG_XFS_FS is not set
> > CONFIG_GFS2_FS=y
> > CONFIG_BTRFS_FS=y
> > # CONFIG_BTRFS_FS_POSIX_ACL is not set
> > # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> > CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
> > # CONFIG_BTRFS_DEBUG is not set
> > CONFIG_BTRFS_ASSERT=y
> > # CONFIG_BTRFS_FS_REF_VERIFY is not set
> > # CONFIG_NILFS2_FS is not set
> > CONFIG_F2FS_FS=y
> > # CONFIG_F2FS_STAT_FS is not set
> > # CONFIG_F2FS_FS_XATTR is not set
> > # CONFIG_F2FS_CHECK_FS is not set
> > # CONFIG_F2FS_FAULT_INJECTION is not set
> > CONFIG_F2FS_FS_COMPRESSION=y
> > # CONFIG_F2FS_FS_LZO is not set
> > # CONFIG_F2FS_FS_LZ4 is not set
> > CONFIG_F2FS_FS_ZSTD=y
> > # CONFIG_F2FS_IOSTAT is not set
> > CONFIG_FS_POSIX_ACL=y
> > CONFIG_EXPORTFS=y
> > # CONFIG_EXPORTFS_BLOCK_OPS is not set
> > CONFIG_FILE_LOCKING=y
> > # CONFIG_FS_ENCRYPTION is not set
> > CONFIG_FS_VERITY=y
> > # CONFIG_FS_VERITY_DEBUG is not set
> > # CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
> > CONFIG_FSNOTIFY=y
> > # CONFIG_DNOTIFY is not set
> > # CONFIG_INOTIFY_USER is not set
> > CONFIG_FANOTIFY=y
> > CONFIG_QUOTA=y
> > # CONFIG_PRINT_QUOTA_WARNING is not set
> > # CONFIG_QUOTA_DEBUG is not set
> > CONFIG_QUOTA_TREE=y
> > CONFIG_QFMT_V1=y
> > CONFIG_QFMT_V2=y
> > CONFIG_QUOTACTL=y
> > # CONFIG_AUTOFS4_FS is not set
> > CONFIG_AUTOFS_FS=y
> > CONFIG_FUSE_FS=y
> > # CONFIG_CUSE is not set
> > CONFIG_VIRTIO_FS=y
> > # CONFIG_OVERLAY_FS is not set
> >
> > #
> > # Caches
> > #
> > CONFIG_NETFS_SUPPORT=y
> > CONFIG_FSCACHE=y
> > # CONFIG_FSCACHE_DEBUG is not set
> > CONFIG_CACHEFILES=y
> > CONFIG_CACHEFILES_DEBUG=y
> > CONFIG_CACHEFILES_ONDEMAND=y
> > # end of Caches
> >
> > #
> > # CD-ROM/DVD Filesystems
> > #
> > # CONFIG_ISO9660_FS is not set
> > # CONFIG_UDF_FS is not set
> > # end of CD-ROM/DVD Filesystems
> >
> > #
> > # DOS/FAT/EXFAT/NT Filesystems
> > #
> > CONFIG_FAT_FS=y
> > CONFIG_MSDOS_FS=y
> > CONFIG_VFAT_FS=y
> > CONFIG_FAT_DEFAULT_CODEPAGE=437
> > CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> > # CONFIG_FAT_DEFAULT_UTF8 is not set
> > CONFIG_FAT_KUNIT_TEST=y
> > CONFIG_EXFAT_FS=y
> > CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
> > CONFIG_NTFS_FS=y
> > CONFIG_NTFS_DEBUG=y
> > CONFIG_NTFS3_FS=y
> > # CONFIG_NTFS3_64BIT_CLUSTER is not set
> > CONFIG_NTFS3_LZX_XPRESS=y
> > CONFIG_NTFS3_FS_POSIX_ACL=y
> > # end of DOS/FAT/EXFAT/NT Filesystems
> >
> > #
> > # Pseudo filesystems
> > #
> > # CONFIG_PROC_FS is not set
> > CONFIG_KERNFS=y
> > CONFIG_SYSFS=y
> > CONFIG_TMPFS=y
> > # CONFIG_TMPFS_POSIX_ACL is not set
> > # CONFIG_TMPFS_XATTR is not set
> > # CONFIG_TMPFS_INODE64 is not set
> > CONFIG_ARCH_SUPPORTS_HUGETLBFS=y
> > CONFIG_HUGETLBFS=y
> > CONFIG_HUGETLB_PAGE=y
> > CONFIG_MEMFD_CREATE=y
> > CONFIG_CONFIGFS_FS=y
> > # CONFIG_EFIVAR_FS is not set
> > # end of Pseudo filesystems
> >
> > CONFIG_MISC_FILESYSTEMS=y
> > # CONFIG_ORANGEFS_FS is not set
> > CONFIG_ADFS_FS=y
> > CONFIG_ADFS_FS_RW=y
> > # CONFIG_AFFS_FS is not set
> > CONFIG_ECRYPT_FS=y
> > # CONFIG_ECRYPT_FS_MESSAGING is not set
> > CONFIG_HFS_FS=y
> > CONFIG_HFSPLUS_FS=y
> > CONFIG_BEFS_FS=y
> > CONFIG_BEFS_DEBUG=y
> > CONFIG_BFS_FS=y
> > CONFIG_EFS_FS=y
> > CONFIG_JFFS2_FS=y
> > CONFIG_JFFS2_FS_DEBUG=0
> > CONFIG_JFFS2_FS_WRITEBUFFER=y
> > # CONFIG_JFFS2_FS_WBUF_VERIFY is not set
> > CONFIG_JFFS2_SUMMARY=y
> > # CONFIG_JFFS2_FS_XATTR is not set
> > CONFIG_JFFS2_COMPRESSION_OPTIONS=y
> > # CONFIG_JFFS2_ZLIB is not set
> > CONFIG_JFFS2_LZO=y
> > # CONFIG_JFFS2_RTIME is not set
> > # CONFIG_JFFS2_RUBIN is not set
> > CONFIG_JFFS2_CMODE_NONE=y
> > # CONFIG_JFFS2_CMODE_PRIORITY is not set
> > # CONFIG_JFFS2_CMODE_SIZE is not set
> > # CONFIG_JFFS2_CMODE_FAVOURLZO is not set
> > CONFIG_UBIFS_FS=y
> > # CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
> > CONFIG_UBIFS_FS_LZO=y
> > CONFIG_UBIFS_FS_ZLIB=y
> > CONFIG_UBIFS_FS_ZSTD=y
> > CONFIG_UBIFS_ATIME_SUPPORT=y
> > CONFIG_UBIFS_FS_XATTR=y
> > CONFIG_UBIFS_FS_SECURITY=y
> > # CONFIG_UBIFS_FS_AUTHENTICATION is not set
> > CONFIG_CRAMFS=y
> > CONFIG_CRAMFS_BLOCKDEV=y
> > # CONFIG_CRAMFS_MTD is not set
> > CONFIG_SQUASHFS=y
> > CONFIG_SQUASHFS_FILE_CACHE=y
> > # CONFIG_SQUASHFS_FILE_DIRECT is not set
> > # CONFIG_SQUASHFS_DECOMP_SINGLE is not set
> > CONFIG_SQUASHFS_DECOMP_MULTI=y
> > # CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
> > CONFIG_SQUASHFS_XATTR=y
> > # CONFIG_SQUASHFS_ZLIB is not set
> > CONFIG_SQUASHFS_LZ4=y
> > CONFIG_SQUASHFS_LZO=y
> > CONFIG_SQUASHFS_XZ=y
> > CONFIG_SQUASHFS_ZSTD=y
> > CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
> > # CONFIG_SQUASHFS_EMBEDDED is not set
> > CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
> > CONFIG_VXFS_FS=y
> > CONFIG_MINIX_FS=y
> > CONFIG_OMFS_FS=y
> > CONFIG_HPFS_FS=y
> > # CONFIG_QNX4FS_FS is not set
> > # CONFIG_QNX6FS_FS is not set
> > CONFIG_ROMFS_FS=y
> > CONFIG_ROMFS_BACKED_BY_BLOCK=y
> > # CONFIG_ROMFS_BACKED_BY_MTD is not set
> > # CONFIG_ROMFS_BACKED_BY_BOTH is not set
> > CONFIG_ROMFS_ON_BLOCK=y
> > CONFIG_PSTORE=y
> > CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
> > # CONFIG_PSTORE_DEFLATE_COMPRESS is not set
> > # CONFIG_PSTORE_LZO_COMPRESS is not set
> > # CONFIG_PSTORE_LZ4_COMPRESS is not set
> > CONFIG_PSTORE_LZ4HC_COMPRESS=y
> > # CONFIG_PSTORE_842_COMPRESS is not set
> > CONFIG_PSTORE_ZSTD_COMPRESS=y
> > CONFIG_PSTORE_COMPRESS=y
> > # CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
> > CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT=y
> > CONFIG_PSTORE_COMPRESS_DEFAULT="zstd"
> > # CONFIG_PSTORE_CONSOLE is not set
> > # CONFIG_PSTORE_PMSG is not set
> > CONFIG_PSTORE_RAM=y
> > CONFIG_PSTORE_ZONE=y
> > CONFIG_PSTORE_BLK=y
> > CONFIG_PSTORE_BLK_BLKDEV=""
> > CONFIG_PSTORE_BLK_KMSG_SIZE=64
> > CONFIG_PSTORE_BLK_MAX_REASON=2
> > # CONFIG_SYSV_FS is not set
> > CONFIG_UFS_FS=y
> > CONFIG_UFS_FS_WRITE=y
> > # CONFIG_UFS_DEBUG is not set
> > # CONFIG_EROFS_FS is not set
> > CONFIG_NLS=y
> > CONFIG_NLS_DEFAULT="iso8859-1"
> > CONFIG_NLS_CODEPAGE_437=y
> > # CONFIG_NLS_CODEPAGE_737 is not set
> > # CONFIG_NLS_CODEPAGE_775 is not set
> > CONFIG_NLS_CODEPAGE_850=y
> > CONFIG_NLS_CODEPAGE_852=y
> > CONFIG_NLS_CODEPAGE_855=y
> > CONFIG_NLS_CODEPAGE_857=y
> > CONFIG_NLS_CODEPAGE_860=y
> > # CONFIG_NLS_CODEPAGE_861 is not set
> > CONFIG_NLS_CODEPAGE_862=y
> > CONFIG_NLS_CODEPAGE_863=y
> > CONFIG_NLS_CODEPAGE_864=y
> > CONFIG_NLS_CODEPAGE_865=y
> > # CONFIG_NLS_CODEPAGE_866 is not set
> > # CONFIG_NLS_CODEPAGE_869 is not set
> > CONFIG_NLS_CODEPAGE_936=y
> > CONFIG_NLS_CODEPAGE_950=y
> > CONFIG_NLS_CODEPAGE_932=y
> > # CONFIG_NLS_CODEPAGE_949 is not set
> > # CONFIG_NLS_CODEPAGE_874 is not set
> > CONFIG_NLS_ISO8859_8=y
> > CONFIG_NLS_CODEPAGE_1250=y
> > # CONFIG_NLS_CODEPAGE_1251 is not set
> > # CONFIG_NLS_ASCII is not set
> > # CONFIG_NLS_ISO8859_1 is not set
> > CONFIG_NLS_ISO8859_2=y
> > CONFIG_NLS_ISO8859_3=y
> > CONFIG_NLS_ISO8859_4=y
> > CONFIG_NLS_ISO8859_5=y
> > # CONFIG_NLS_ISO8859_6 is not set
> > CONFIG_NLS_ISO8859_7=y
> > CONFIG_NLS_ISO8859_9=y
> > CONFIG_NLS_ISO8859_13=y
> > # CONFIG_NLS_ISO8859_14 is not set
> > # CONFIG_NLS_ISO8859_15 is not set
> > # CONFIG_NLS_KOI8_R is not set
> > # CONFIG_NLS_KOI8_U is not set
> > # CONFIG_NLS_MAC_ROMAN is not set
> > CONFIG_NLS_MAC_CELTIC=y
> > CONFIG_NLS_MAC_CENTEURO=y
> > CONFIG_NLS_MAC_CROATIAN=y
> > # CONFIG_NLS_MAC_CYRILLIC is not set
> > CONFIG_NLS_MAC_GAELIC=y
> > CONFIG_NLS_MAC_GREEK=y
> > # CONFIG_NLS_MAC_ICELAND is not set
> > # CONFIG_NLS_MAC_INUIT is not set
> > CONFIG_NLS_MAC_ROMANIAN=y
> > CONFIG_NLS_MAC_TURKISH=y
> > CONFIG_NLS_UTF8=y
> > CONFIG_UNICODE=y
> > # CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
> > CONFIG_IO_WQ=y
> > # end of File systems
> >
> > #
> > # Security options
> > #
> > CONFIG_KEYS=y
> > # CONFIG_KEYS_REQUEST_CACHE is not set
> > CONFIG_PERSISTENT_KEYRINGS=y
> > CONFIG_TRUSTED_KEYS=y
> >
> > #
> > # No trust source selected!
> > #
> > # CONFIG_ENCRYPTED_KEYS is not set
> > # CONFIG_KEY_DH_OPERATIONS is not set
> > # CONFIG_KEY_NOTIFICATIONS is not set
> > CONFIG_SECURITY_DMESG_RESTRICT=y
> > # CONFIG_SECURITYFS is not set
> > CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> > CONFIG_HARDENED_USERCOPY=y
> > CONFIG_STATIC_USERMODEHELPER=y
> > CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
> > CONFIG_DEFAULT_SECURITY_DAC=y
> > CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"
> >
> > #
> > # Kernel hardening options
> > #
> >
> > #
> > # Memory initialization
> > #
> > CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
> > CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
> > CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
> > # CONFIG_INIT_STACK_NONE is not set
> > # CONFIG_INIT_STACK_ALL_PATTERN is not set
> > CONFIG_INIT_STACK_ALL_ZERO=y
> > # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> > # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> > CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
> > CONFIG_ZERO_CALL_USED_REGS=y
> > # end of Memory initialization
> >
> > CONFIG_RANDSTRUCT_NONE=y
> > # end of Kernel hardening options
> > # end of Security options
> >
> > CONFIG_XOR_BLOCKS=y
> > CONFIG_ASYNC_CORE=y
> > CONFIG_ASYNC_XOR=y
> > CONFIG_CRYPTO=y
> >
> > #
> > # Crypto core or helper
> > #
> > CONFIG_CRYPTO_FIPS=y
> > CONFIG_CRYPTO_FIPS_NAME="Linux Kernel Cryptographic API"
> > # CONFIG_CRYPTO_FIPS_CUSTOM_VERSION is not set
> > CONFIG_CRYPTO_ALGAPI=y
> > CONFIG_CRYPTO_ALGAPI2=y
> > CONFIG_CRYPTO_AEAD=y
> > CONFIG_CRYPTO_AEAD2=y
> > CONFIG_CRYPTO_SKCIPHER=y
> > CONFIG_CRYPTO_SKCIPHER2=y
> > CONFIG_CRYPTO_HASH=y
> > CONFIG_CRYPTO_HASH2=y
> > CONFIG_CRYPTO_RNG=y
> > CONFIG_CRYPTO_RNG2=y
> > CONFIG_CRYPTO_RNG_DEFAULT=y
> > CONFIG_CRYPTO_AKCIPHER2=y
> > CONFIG_CRYPTO_AKCIPHER=y
> > CONFIG_CRYPTO_KPP2=y
> > CONFIG_CRYPTO_KPP=y
> > CONFIG_CRYPTO_ACOMP2=y
> > CONFIG_CRYPTO_MANAGER=y
> > CONFIG_CRYPTO_MANAGER2=y
> > # CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> > # CONFIG_CRYPTO_MANAGER_EXTRA_TESTS is not set
> > CONFIG_CRYPTO_NULL=y
> > CONFIG_CRYPTO_NULL2=y
> > # CONFIG_CRYPTO_PCRYPT is not set
> > CONFIG_CRYPTO_CRYPTD=y
> > CONFIG_CRYPTO_AUTHENC=y
> > # CONFIG_CRYPTO_TEST is not set
> > CONFIG_CRYPTO_ENGINE=y
> > # end of Crypto core or helper
> >
> > #
> > # Public-key cryptography
> > #
> > CONFIG_CRYPTO_RSA=y
> > CONFIG_CRYPTO_DH=y
> > CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
> > CONFIG_CRYPTO_ECC=y
> > CONFIG_CRYPTO_ECDH=y
> > CONFIG_CRYPTO_ECDSA=y
> > # CONFIG_CRYPTO_ECRDSA is not set
> > # CONFIG_CRYPTO_SM2 is not set
> > # CONFIG_CRYPTO_CURVE25519 is not set
> > # end of Public-key cryptography
> >
> > #
> > # Block ciphers
> > #
> > CONFIG_CRYPTO_AES=y
> > CONFIG_CRYPTO_AES_TI=y
> > # CONFIG_CRYPTO_ARIA is not set
> > # CONFIG_CRYPTO_BLOWFISH is not set
> > CONFIG_CRYPTO_CAMELLIA=y
> > CONFIG_CRYPTO_CAST_COMMON=y
> > # CONFIG_CRYPTO_CAST5 is not set
> > CONFIG_CRYPTO_CAST6=y
> > CONFIG_CRYPTO_DES=y
> > CONFIG_CRYPTO_FCRYPT=y
> > CONFIG_CRYPTO_SERPENT=y
> > # CONFIG_CRYPTO_SM4_GENERIC is not set
> > # CONFIG_CRYPTO_TWOFISH is not set
> > # end of Block ciphers
> >
> > #
> > # Length-preserving ciphers and modes
> > #
> > # CONFIG_CRYPTO_ADIANTUM is not set
> > CONFIG_CRYPTO_CHACHA20=y
> > CONFIG_CRYPTO_CBC=y
> > CONFIG_CRYPTO_CFB=y
> > CONFIG_CRYPTO_CTR=y
> > CONFIG_CRYPTO_CTS=y
> > CONFIG_CRYPTO_ECB=y
> > CONFIG_CRYPTO_HCTR2=y
> > # CONFIG_CRYPTO_KEYWRAP is not set
> > CONFIG_CRYPTO_LRW=y
> > CONFIG_CRYPTO_OFB=y
> > CONFIG_CRYPTO_PCBC=y
> > CONFIG_CRYPTO_XCTR=y
> > CONFIG_CRYPTO_XTS=y
> > # end of Length-preserving ciphers and modes
> >
> > #
> > # AEAD (authenticated encryption with associated data) ciphers
> > #
> > # CONFIG_CRYPTO_AEGIS128 is not set
> > CONFIG_CRYPTO_CHACHA20POLY1305=y
> > CONFIG_CRYPTO_CCM=y
> > # CONFIG_CRYPTO_GCM is not set
> > CONFIG_CRYPTO_SEQIV=y
> > # CONFIG_CRYPTO_ECHAINIV is not set
> > CONFIG_CRYPTO_ESSIV=y
> > # end of AEAD (authenticated encryption with associated data) ciphers
> >
> > #
> > # Hashes, digests, and MACs
> > #
> > CONFIG_CRYPTO_BLAKE2B=y
> > # CONFIG_CRYPTO_CMAC is not set
> > # CONFIG_CRYPTO_GHASH is not set
> > CONFIG_CRYPTO_HMAC=y
> > CONFIG_CRYPTO_MD4=y
> > CONFIG_CRYPTO_MD5=y
> > CONFIG_CRYPTO_MICHAEL_MIC=y
> > CONFIG_CRYPTO_POLYVAL=y
> > CONFIG_CRYPTO_POLY1305=y
> > CONFIG_CRYPTO_RMD160=y
> > CONFIG_CRYPTO_SHA1=y
> > CONFIG_CRYPTO_SHA256=y
> > CONFIG_CRYPTO_SHA512=y
> > CONFIG_CRYPTO_SHA3=y
> > CONFIG_CRYPTO_SM3=y
> > CONFIG_CRYPTO_SM3_GENERIC=y
> > CONFIG_CRYPTO_STREEBOG=y
> > CONFIG_CRYPTO_VMAC=y
> > CONFIG_CRYPTO_WP512=y
> > CONFIG_CRYPTO_XCBC=y
> > CONFIG_CRYPTO_XXHASH=y
> > # end of Hashes, digests, and MACs
> >
> > #
> > # CRCs (cyclic redundancy checks)
> > #
> > CONFIG_CRYPTO_CRC32C=y
> > CONFIG_CRYPTO_CRC32=y
> > CONFIG_CRYPTO_CRCT10DIF=y
> > CONFIG_CRYPTO_CRC64_ROCKSOFT=y
> > # end of CRCs (cyclic redundancy checks)
> >
> > #
> > # Compression
> > #
> > CONFIG_CRYPTO_DEFLATE=y
> > CONFIG_CRYPTO_LZO=y
> > CONFIG_CRYPTO_842=y
> > # CONFIG_CRYPTO_LZ4 is not set
> > CONFIG_CRYPTO_LZ4HC=y
> > CONFIG_CRYPTO_ZSTD=y
> > # end of Compression
> >
> > #
> > # Random number generation
> > #
> > CONFIG_CRYPTO_ANSI_CPRNG=y
> > CONFIG_CRYPTO_DRBG_MENU=y
> > CONFIG_CRYPTO_DRBG_HMAC=y
> > # CONFIG_CRYPTO_DRBG_HASH is not set
> > CONFIG_CRYPTO_DRBG_CTR=y
> > CONFIG_CRYPTO_DRBG=y
> > CONFIG_CRYPTO_JITTERENTROPY=y
> > # end of Random number generation
> >
> > #
> > # Userspace interface
> > #
> > # end of Userspace interface
> >
> > CONFIG_CRYPTO_HASH_INFO=y
> > CONFIG_CRYPTO_HW=y
> > # CONFIG_CRYPTO_DEV_ALLWINNER is not set
> > # CONFIG_CRYPTO_DEV_EXYNOS_RNG is not set
> > # CONFIG_CRYPTO_DEV_S5P is not set
> > # CONFIG_CRYPTO_DEV_ATMEL_AES is not set
> > # CONFIG_CRYPTO_DEV_ATMEL_TDES is not set
> > # CONFIG_CRYPTO_DEV_ATMEL_SHA is not set
> > CONFIG_CRYPTO_DEV_ATMEL_I2C=y
> > # CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
> > CONFIG_CRYPTO_DEV_ATMEL_SHA204A=y
> > CONFIG_CRYPTO_DEV_QAT=y
> > CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
> > CONFIG_CRYPTO_DEV_QAT_C3XXX=y
> > CONFIG_CRYPTO_DEV_QAT_C62X=y
> > # CONFIG_CRYPTO_DEV_QAT_4XXX is not set
> > CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=y
> > CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
> > CONFIG_CRYPTO_DEV_QAT_C62XVF=y
> > # CONFIG_CAVIUM_CPT is not set
> > CONFIG_CRYPTO_DEV_NITROX=y
> > CONFIG_CRYPTO_DEV_NITROX_CNN55XX=y
> > # CONFIG_CRYPTO_DEV_OCTEONTX_CPT is not set
> > # CONFIG_CRYPTO_DEV_CAVIUM_ZIP is not set
> > # CONFIG_CRYPTO_DEV_QCE is not set
> > # CONFIG_CRYPTO_DEV_QCOM_RNG is not set
> > # CONFIG_CRYPTO_DEV_IMGTEC_HASH is not set
> > # CONFIG_CRYPTO_DEV_ZYNQMP_AES is not set
> > # CONFIG_CRYPTO_DEV_ZYNQMP_SHA3 is not set
> > CONFIG_CRYPTO_DEV_VIRTIO=y
> > CONFIG_CRYPTO_DEV_SAFEXCEL=y
> > # CONFIG_CRYPTO_DEV_HISI_SEC is not set
> > # CONFIG_CRYPTO_DEV_HISI_SEC2 is not set
> > # CONFIG_CRYPTO_DEV_HISI_ZIP is not set
> > # CONFIG_CRYPTO_DEV_HISI_HPRE is not set
> > CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
> > # CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG is not set
> > # CONFIG_CRYPTO_DEV_SA2UL is not set
> > # CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4 is not set
> > # CONFIG_CRYPTO_DEV_ASPEED is not set
> > CONFIG_ASYMMETRIC_KEY_TYPE=y
> > CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> > CONFIG_X509_CERTIFICATE_PARSER=y
> > # CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
> > CONFIG_PKCS7_MESSAGE_PARSER=y
> > CONFIG_PKCS7_TEST_KEY=y
> > CONFIG_SIGNED_PE_FILE_VERIFICATION=y
> > CONFIG_FIPS_SIGNATURE_SELFTEST=y
> >
> > #
> > # Certificates for signature checking
> > #
> > CONFIG_SYSTEM_TRUSTED_KEYRING=y
> > CONFIG_SYSTEM_TRUSTED_KEYS=""
> > # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> > # CONFIG_SECONDARY_TRUSTED_KEYRING is not set
> > # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
> > # end of Certificates for signature checking
> >
> > #
> > # Library routines
> > #
> > CONFIG_RAID6_PQ=y
> > # CONFIG_RAID6_PQ_BENCHMARK is not set
> > CONFIG_LINEAR_RANGES=y
> > # CONFIG_PACKING is not set
> > CONFIG_BITREVERSE=y
> > CONFIG_GENERIC_STRNCPY_FROM_USER=y
> > CONFIG_GENERIC_STRNLEN_USER=y
> > CONFIG_CORDIC=y
> > CONFIG_PRIME_NUMBERS=y
> > CONFIG_RATIONAL=y
> > CONFIG_GENERIC_PCI_IOMAP=y
> > CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
> >
> > #
> > # Crypto library routines
> > #
> > CONFIG_CRYPTO_LIB_UTILS=y
> > CONFIG_CRYPTO_LIB_AES=y
> > CONFIG_CRYPTO_LIB_GF128MUL=y
> > CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
> > CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
> > CONFIG_CRYPTO_LIB_CHACHA=y
> > CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
> > CONFIG_CRYPTO_LIB_CURVE25519=y
> > CONFIG_CRYPTO_LIB_DES=y
> > CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
> > CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
> > CONFIG_CRYPTO_LIB_POLY1305=y
> > # CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
> > CONFIG_CRYPTO_LIB_SHA1=y
> > CONFIG_CRYPTO_LIB_SHA256=y
> > # end of Crypto library routines
> >
> > CONFIG_CRC_CCITT=y
> > CONFIG_CRC16=y
> > CONFIG_CRC_T10DIF=y
> > CONFIG_CRC64_ROCKSOFT=y
> > CONFIG_CRC_ITU_T=y
> > CONFIG_CRC32=y
> > CONFIG_CRC32_SELFTEST=y
> > # CONFIG_CRC32_SLICEBY8 is not set
> > CONFIG_CRC32_SLICEBY4=y
> > # CONFIG_CRC32_SARWATE is not set
> > # CONFIG_CRC32_BIT is not set
> > CONFIG_CRC64=y
> > # CONFIG_CRC4 is not set
> > CONFIG_CRC7=y
> > CONFIG_LIBCRC32C=y
> > CONFIG_CRC8=y
> > CONFIG_XXHASH=y
> > CONFIG_RANDOM32_SELFTEST=y
> > CONFIG_842_COMPRESS=y
> > CONFIG_842_DECOMPRESS=y
> > CONFIG_ZLIB_INFLATE=y
> > CONFIG_ZLIB_DEFLATE=y
> > CONFIG_LZO_COMPRESS=y
> > CONFIG_LZO_DECOMPRESS=y
> > CONFIG_LZ4_COMPRESS=y
> > CONFIG_LZ4HC_COMPRESS=y
> > CONFIG_LZ4_DECOMPRESS=y
> > CONFIG_ZSTD_COMMON=y
> > CONFIG_ZSTD_COMPRESS=y
> > CONFIG_ZSTD_DECOMPRESS=y
> > CONFIG_XZ_DEC=y
> > # CONFIG_XZ_DEC_X86 is not set
> > # CONFIG_XZ_DEC_POWERPC is not set
> > CONFIG_XZ_DEC_IA64=y
> > # CONFIG_XZ_DEC_ARM is not set
> > CONFIG_XZ_DEC_ARMTHUMB=y
> > CONFIG_XZ_DEC_SPARC=y
> > CONFIG_XZ_DEC_MICROLZMA=y
> > CONFIG_XZ_DEC_BCJ=y
> > CONFIG_XZ_DEC_TEST=y
> > CONFIG_DECOMPRESS_GZIP=y
> > CONFIG_DECOMPRESS_XZ=y
> > CONFIG_DECOMPRESS_LZ4=y
> > CONFIG_DECOMPRESS_ZSTD=y
> > CONFIG_GENERIC_ALLOCATOR=y
> > CONFIG_REED_SOLOMON=y
> > CONFIG_REED_SOLOMON_ENC8=y
> > CONFIG_REED_SOLOMON_DEC8=y
> > CONFIG_REED_SOLOMON_DEC16=y
> > CONFIG_BCH=y
> > CONFIG_INTERVAL_TREE=y
> > CONFIG_XARRAY_MULTI=y
> > CONFIG_ASSOCIATIVE_ARRAY=y
> > CONFIG_HAS_IOMEM=y
> > CONFIG_HAS_IOPORT_MAP=y
> > CONFIG_HAS_DMA=y
> > CONFIG_NEED_DMA_MAP_STATE=y
> > CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> > CONFIG_SWIOTLB=y
> > CONFIG_DMA_CMA=y
> > # CONFIG_DMA_PERNUMA_CMA is not set
> >
> > #
> > # Default contiguous memory area size:
> > #
> > CONFIG_CMA_SIZE_MBYTES=16
> > CONFIG_CMA_SIZE_SEL_MBYTES=y
> > # CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
> > # CONFIG_CMA_SIZE_SEL_MIN is not set
> > # CONFIG_CMA_SIZE_SEL_MAX is not set
> > CONFIG_CMA_ALIGNMENT=8
> > # CONFIG_DMA_API_DEBUG is not set
> > # CONFIG_DMA_MAP_BENCHMARK is not set
> > CONFIG_SGL_ALLOC=y
> > # CONFIG_FORCE_NR_CPUS is not set
> > CONFIG_GLOB=y
> > CONFIG_GLOB_SELFTEST=y
> > CONFIG_CLZ_TAB=y
> > # CONFIG_IRQ_POLL is not set
> > CONFIG_MPILIB=y
> > CONFIG_OID_REGISTRY=y
> > CONFIG_UCS2_STRING=y
> > CONFIG_HAVE_GENERIC_VDSO=y
> > CONFIG_GENERIC_GETTIMEOFDAY=y
> > CONFIG_FONT_SUPPORT=y
> > CONFIG_FONT_8x16=y
> > CONFIG_FONT_AUTOSELECT=y
> > CONFIG_SG_POOL=y
> > CONFIG_MEMREGION=y
> > CONFIG_ARCH_STACKWALK=y
> > CONFIG_STACKDEPOT=y
> > CONFIG_SBITMAP=y
> > # CONFIG_PARMAN is not set
> > # CONFIG_OBJAGG is not set
> > # end of Library routines
> >
> > CONFIG_GENERIC_IOREMAP=y
> > CONFIG_GENERIC_LIB_ASHLDI3=y
> > CONFIG_GENERIC_LIB_ASHRDI3=y
> > CONFIG_GENERIC_LIB_LSHRDI3=y
> > CONFIG_GENERIC_LIB_CMPDI2=y
> > CONFIG_GENERIC_LIB_UCMPDI2=y
> > CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED=y
> >
> > #
> > # Kernel hacking
> > #
> >
> > #
> > # printk and dmesg options
> > #
> > CONFIG_PRINTK_TIME=y
> > CONFIG_PRINTK_CALLER=y
> > # CONFIG_STACKTRACE_BUILD_ID is not set
> > CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> > CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> > CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> > CONFIG_BOOT_PRINTK_DELAY=y
> > CONFIG_DYNAMIC_DEBUG=y
> > CONFIG_DYNAMIC_DEBUG_CORE=y
> > CONFIG_SYMBOLIC_ERRNAME=y
> > CONFIG_DEBUG_BUGVERBOSE=y
> > # end of printk and dmesg options
> >
> > CONFIG_DEBUG_KERNEL=y
> > # CONFIG_DEBUG_MISC is not set
> >
> > #
> > # Compile-time checks and compiler options
> > #
> > CONFIG_DEBUG_INFO=y
> > CONFIG_AS_HAS_NON_CONST_LEB128=y
> > # CONFIG_DEBUG_INFO_NONE is not set
> > # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
> > CONFIG_DEBUG_INFO_DWARF4=y
> > # CONFIG_DEBUG_INFO_DWARF5 is not set
> > # CONFIG_DEBUG_INFO_REDUCED is not set
> > CONFIG_DEBUG_INFO_COMPRESSED=y
> > # CONFIG_DEBUG_INFO_SPLIT is not set
> > CONFIG_PAHOLE_HAS_SPLIT_BTF=y
> > # CONFIG_GDB_SCRIPTS is not set
> > CONFIG_FRAME_WARN=2048
> > # CONFIG_STRIP_ASM_SYMS is not set
> > CONFIG_READABLE_ASM=y
> > CONFIG_HEADERS_INSTALL=y
> > CONFIG_DEBUG_SECTION_MISMATCH=y
> > CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> > # CONFIG_VMLINUX_MAP is not set
> > CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
> > # end of Compile-time checks and compiler options
> >
> > #
> > # Generic Kernel Debugging Instruments
> > #
> > CONFIG_MAGIC_SYSRQ=y
> > CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> > CONFIG_MAGIC_SYSRQ_SERIAL=y
> > CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
> > CONFIG_DEBUG_FS=y
> > # CONFIG_DEBUG_FS_ALLOW_ALL is not set
> > # CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
> > CONFIG_DEBUG_FS_ALLOW_NONE=y
> > # CONFIG_UBSAN is not set
> > CONFIG_HAVE_KCSAN_COMPILER=y
> > # end of Generic Kernel Debugging Instruments
> >
> > #
> > # Networking Debugging
> > #
> > # end of Networking Debugging
> >
> > #
> > # Memory Debugging
> > #
> > CONFIG_PAGE_EXTENSION=y
> > # CONFIG_DEBUG_PAGEALLOC is not set
> > CONFIG_SLUB_DEBUG=y
> > # CONFIG_SLUB_DEBUG_ON is not set
> > CONFIG_PAGE_OWNER=y
> > CONFIG_PAGE_POISONING=y
> > CONFIG_DEBUG_OBJECTS=y
> > CONFIG_DEBUG_OBJECTS_SELFTEST=y
> > # CONFIG_DEBUG_OBJECTS_FREE is not set
> > CONFIG_DEBUG_OBJECTS_TIMERS=y
> > # CONFIG_DEBUG_OBJECTS_WORK is not set
> > CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
> > # CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
> > CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
> > CONFIG_SHRINKER_DEBUG=y
> > CONFIG_DEBUG_STACK_USAGE=y
> > CONFIG_SCHED_STACK_END_CHECK=y
> > CONFIG_DEBUG_VM_IRQSOFF=y
> > CONFIG_DEBUG_VM=y
> > CONFIG_DEBUG_VM_MAPLE_TREE=y
> > # CONFIG_DEBUG_VM_RB is not set
> > # CONFIG_DEBUG_VM_PGFLAGS is not set
> > # CONFIG_DEBUG_MEMORY_INIT is not set
> > # CONFIG_DEBUG_PER_CPU_MAPS is not set
> > CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> > # CONFIG_DEBUG_STACKOVERFLOW is not set
> > CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> > # end of Memory Debugging
> >
> > # CONFIG_DEBUG_SHIRQ is not set
> >
> > #
> > # Debug Oops, Lockups and Hangs
> > #
> > # CONFIG_PANIC_ON_OOPS is not set
> > CONFIG_PANIC_ON_OOPS_VALUE=0
> > CONFIG_PANIC_TIMEOUT=0
> > # CONFIG_SOFTLOCKUP_DETECTOR is not set
> > # CONFIG_DETECT_HUNG_TASK is not set
> > CONFIG_WQ_WATCHDOG=y
> > # end of Debug Oops, Lockups and Hangs
> >
> > #
> > # Scheduler Debugging
> > #
> > # end of Scheduler Debugging
> >
> > CONFIG_DEBUG_TIMEKEEPING=y
> > CONFIG_DEBUG_PREEMPT=y
> >
> > #
> > # Lock Debugging (spinlocks, mutexes, etc...)
> > #
> > CONFIG_LOCK_DEBUGGING_SUPPORT=y
> > # CONFIG_PROVE_LOCKING is not set
> > CONFIG_LOCK_STAT=y
> > CONFIG_DEBUG_RT_MUTEXES=y
> > CONFIG_DEBUG_SPINLOCK=y
> > CONFIG_DEBUG_MUTEXES=y
> > CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> > # CONFIG_DEBUG_RWSEMS is not set
> > CONFIG_DEBUG_LOCK_ALLOC=y
> > CONFIG_LOCKDEP=y
> > CONFIG_LOCKDEP_BITS=15
> > CONFIG_LOCKDEP_CHAINS_BITS=16
> > CONFIG_LOCKDEP_STACK_TRACE_BITS=19
> > CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
> > CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
> > # CONFIG_DEBUG_LOCKDEP is not set
> > CONFIG_DEBUG_ATOMIC_SLEEP=y
> > CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
> > CONFIG_LOCK_TORTURE_TEST=y
> > CONFIG_WW_MUTEX_SELFTEST=y
> > CONFIG_SCF_TORTURE_TEST=y
> > CONFIG_CSD_LOCK_WAIT_DEBUG=y
> > # end of Lock Debugging (spinlocks, mutexes, etc...)
> >
> > # CONFIG_DEBUG_IRQFLAGS is not set
> > CONFIG_STACKTRACE=y
> > CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
> > CONFIG_DEBUG_KOBJECT=y
> > CONFIG_DEBUG_KOBJECT_RELEASE=y
> >
> > #
> > # Debug kernel data structures
> > #
> > CONFIG_DEBUG_LIST=y
> > CONFIG_DEBUG_PLIST=y
> > # CONFIG_DEBUG_SG is not set
> > # CONFIG_DEBUG_NOTIFIERS is not set
> > CONFIG_BUG_ON_DATA_CORRUPTION=y
> > CONFIG_DEBUG_MAPLE_TREE=y
> > # end of Debug kernel data structures
> >
> > # CONFIG_DEBUG_CREDENTIALS is not set
> >
> > #
> > # RCU Debugging
> > #
> > CONFIG_TORTURE_TEST=y
> > # CONFIG_RCU_SCALE_TEST is not set
> > # CONFIG_RCU_TORTURE_TEST is not set
> > # CONFIG_RCU_REF_SCALE_TEST is not set
> > CONFIG_RCU_CPU_STALL_TIMEOUT=21
> > CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
> > CONFIG_RCU_TRACE=y
> > CONFIG_RCU_EQS_DEBUG=y
> > # end of RCU Debugging
> >
> > CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
> > CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
> > CONFIG_USER_STACKTRACE_SUPPORT=y
> > CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> > CONFIG_TRACE_CLOCK=y
> > CONFIG_TRACING_SUPPORT=y
> > # CONFIG_FTRACE is not set
> > # CONFIG_SAMPLES is not set
> > # CONFIG_STRICT_DEVMEM is not set
> >
> > #
> > # loongarch Debugging
> > #
> > # CONFIG_UNWINDER_GUESS is not set
> > CONFIG_UNWINDER_PROLOGUE=y
> > # end of loongarch Debugging
> >
> > #
> > # Kernel Testing and Coverage
> > #
> > CONFIG_KUNIT=y
> > CONFIG_KUNIT_DEBUGFS=y
> > CONFIG_KUNIT_TEST=y
> > CONFIG_KUNIT_EXAMPLE_TEST=y
> > CONFIG_KUNIT_ALL_TESTS=y
> > CONFIG_KUNIT_DEFAULT_ENABLED=y
> > # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> > CONFIG_FAULT_INJECTION=y
> > CONFIG_FAILSLAB=y
> > # CONFIG_FAIL_PAGE_ALLOC is not set
> > # CONFIG_FAULT_INJECTION_USERCOPY is not set
> > CONFIG_FAIL_MAKE_REQUEST=y
> > # CONFIG_FAIL_IO_TIMEOUT is not set
> > CONFIG_FAIL_FUTEX=y
> > # CONFIG_FAULT_INJECTION_DEBUG_FS is not set
> > CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> > CONFIG_RUNTIME_TESTING_MENU=y
> > CONFIG_LKDTM=y
> > CONFIG_CPUMASK_KUNIT_TEST=y
> > CONFIG_TEST_LIST_SORT=y
> > # CONFIG_TEST_MIN_HEAP is not set
> > CONFIG_TEST_SORT=y
> > CONFIG_TEST_DIV64=y
> > CONFIG_BACKTRACE_SELF_TEST=y
> > # CONFIG_TEST_REF_TRACKER is not set
> > # CONFIG_RBTREE_TEST is not set
> > # CONFIG_REED_SOLOMON_TEST is not set
> > CONFIG_INTERVAL_TREE_TEST=y
> > # CONFIG_ATOMIC64_SELFTEST is not set
> > CONFIG_TEST_HEXDUMP=y
> > CONFIG_STRING_SELFTEST=y
> > CONFIG_TEST_STRING_HELPERS=y
> > CONFIG_TEST_STRSCPY=y
> > CONFIG_TEST_KSTRTOX=y
> > CONFIG_TEST_PRINTF=y
> > CONFIG_TEST_SCANF=y
> > CONFIG_TEST_BITMAP=y
> > CONFIG_TEST_UUID=y
> > # CONFIG_TEST_XARRAY is not set
> > CONFIG_TEST_RHASHTABLE=y
> > CONFIG_TEST_SIPHASH=y
> > CONFIG_TEST_IDA=y
> > # CONFIG_FIND_BIT_BENCHMARK is not set
> > CONFIG_TEST_FIRMWARE=y
> > CONFIG_BITFIELD_KUNIT=y
> > CONFIG_HASH_KUNIT_TEST=y
> > CONFIG_RESOURCE_KUNIT_TEST=y
> > CONFIG_SYSCTL_KUNIT_TEST=y
> > CONFIG_LIST_KUNIT_TEST=y
> > CONFIG_LINEAR_RANGES_TEST=y
> > CONFIG_CMDLINE_KUNIT_TEST=y
> > CONFIG_BITS_TEST=y
> > CONFIG_SLUB_KUNIT_TEST=y
> > CONFIG_RATIONAL_KUNIT_TEST=y
> > CONFIG_MEMCPY_KUNIT_TEST=y
> > CONFIG_IS_SIGNED_TYPE_KUNIT_TEST=y
> > CONFIG_OVERFLOW_KUNIT_TEST=y
> > CONFIG_STACKINIT_KUNIT_TEST=y
> > CONFIG_TEST_UDELAY=y
> > # CONFIG_TEST_DYNAMIC_DEBUG is not set
> > CONFIG_TEST_MEMCAT_P=y
> > CONFIG_TEST_MEMINIT=y
> > CONFIG_TEST_FREE_PAGES=y
> > # end of Kernel Testing and Coverage
> >
> > #
> > # Rust hacking
> > #
> > # end of Rust hacking
> >
> > # CONFIG_WARN_MISSING_DOCUMENTS is not set
> > # CONFIG_WARN_ABI_ERRORS is not set
> > # end of Kernel hacking
>
>
