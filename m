Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEAE748861
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjGEPu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjGEPuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:50:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A27198E;
        Wed,  5 Jul 2023 08:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE726615F8;
        Wed,  5 Jul 2023 15:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE82C433CA;
        Wed,  5 Jul 2023 15:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688572204;
        bh=f4hoBSMGFxdGLbWt3eS2V76JRuxcN25xMJ62zDXlGHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+84wU3GIJNdN101uoFpZCQWc7lH7yIF0Roj2K9DuQtG1jR1K1SsRoNTOw7iMLyN2
         sDVQOwidG5J5JrJ/AmVk2G7rZN2QJQZwuwuzEbxtWb3vd7C5wLe7C+v5rtr9jspnV7
         qVVSiWucnhnxK70LNDpXoH2G4SWje5ZIxj8H74foaWH+OD4RpDdmYKLquSv6dUcS0D
         fO5UEyIJX3537W4e43/0ZpyL11KqzD5xSHPVq8CIF798Lf+kiFH2pmMNMLgy6CDWKV
         1cYEmnNHJAII9AL9C82ja2PKP6QOJI3myjUfvylJuyvLKIb56SXo8V96Z2YPtGm3JA
         Dy2lapsaUgpRQ==
Date:   Wed, 5 Jul 2023 08:49:58 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        chenhuacai@kernel.org, geert@linux-m68k.org,
        tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, kernel@xen0n.name, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, hpa@zytor.com, keescook@chromium.org,
        paulmck@kernel.org, peterz@infradead.org, frederic@kernel.org,
        akpm@linux-foundation.org, ardb@kernel.org,
        samitolvanen@google.com, juerg.haefliger@canonical.com,
        arnd@arndb.de, rmk+kernel@armlinux.org.uk,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        rppt@kernel.org, kirill.shutemov@linux.intel.com,
        anshuman.khandual@arm.com, ziy@nvidia.com, masahiroy@kernel.org,
        ndesaulniers@google.com, mhiramat@kernel.org, ojeda@kernel.org,
        thunder.leizhen@huawei.com, xin3.li@intel.com, tj@kernel.org,
        gregkh@linuxfoundation.org, tsi@tuyoix.net, bhe@redhat.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v4 12/13] s390/kexec: refactor for kernel/Kconfig.kexec
Message-ID: <20230705154958.GA3643511@dev-arch.thelio-3990X>
References: <20230705142004.3605799-1-eric.devolder@oracle.com>
 <20230705142004.3605799-13-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705142004.3605799-13-eric.devolder@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Wed, Jul 05, 2023 at 10:20:03AM -0400, Eric DeVolder wrote:
> The kexec and crash kernel options are provided in the common
> kernel/Kconfig.kexec. Utilize the common options and provide
> the ARCH_SUPPORTS_ and ARCH_SELECTS_ entries to recreate the
> equivalent set of KEXEC and CRASH options.
> 
> NOTE: The original Kconfig has a KEXEC_SIG which depends on
> MODULE_SIG_FORMAT. However, attempts to keep the MODULE_SIG_FORMAT
> dependency (using the strategy outlined in this series, and other
> techniques) results in 'error: recursive dependency detected'
> on CRYPTO.
> 
> Per Alexander Gordeev <agordeev@linux.ibm.com>: "the MODULE_SIG_FORMAT
> dependency was introduced with [git commit below] and in fact was not
> necessary, since s390 did/does not use mod_check_sig() anyway.
> 
>  commit c8424e776b09 ("MODSIGN: Export module signature definitions")
> 
> MODULE_SIG_FORMAT is needed to select SYSTEM_DATA_VERIFICATION. But
> SYSTEM_DATA_VERIFICATION is also selected by FS_VERITY*, so dropping
> MODULE_SIG_FORMAT does not hurt."
> 
> Therefore, the solution is to drop the MODULE_SIG_FORMAT dependency
> from KEXEC_SIG. Still results in equivalent .config files for s390.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/Kconfig | 65 ++++++++++++++---------------------------------
>  1 file changed, 19 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 5b39918b7042..5d4fbbfdd1cd 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -244,6 +244,25 @@ config PGTABLE_LEVELS
>  
>  source "kernel/livepatch/Kconfig"
>  
> +config ARCH_DEFAULT_KEXEC
> +	def_bool y
> +
> +config ARCH_SUPPORTS_KEXEC
> +	def_bool y
> +
> +config ARCH_SUPPORTS_KEXEC_FILE
> +	def_bool CRYPTO && CRYPTO_SHA256 && CRYPTO_SHA256_S390
> +
> +config ARCH_HAS_KEXEC_PURGATORY
> +	def_bool KEXEC_FILE
> +
> +config ARCH_SUPPORTS_CRASH_DUMP
> +	def_bool y
> +	help
> +	  Refer to <file:Documentation/s390/zfcpdump.rst> for more details on this.
> +	  This option also enables s390 zfcpdump.
> +	  See also <file:Documentation/s390/zfcpdump.rst>
> +
>  menu "Processor type and features"
>  
>  config HAVE_MARCH_Z10_FEATURES
> @@ -482,36 +501,6 @@ config SCHED_TOPOLOGY
>  
>  source "kernel/Kconfig.hz"
>  
> -config KEXEC
> -	def_bool y
> -	select KEXEC_CORE
> -
> -config KEXEC_FILE
> -	bool "kexec file based system call"
> -	select KEXEC_CORE
> -	depends on CRYPTO
> -	depends on CRYPTO_SHA256
> -	depends on CRYPTO_SHA256_S390
> -	help
> -	  Enable the kexec file based system call. In contrast to the normal
> -	  kexec system call this system call takes file descriptors for the
> -	  kernel and initramfs as arguments.
> -
> -config ARCH_HAS_KEXEC_PURGATORY
> -	def_bool y
> -	depends on KEXEC_FILE
> -
> -config KEXEC_SIG
> -	bool "Verify kernel signature during kexec_file_load() syscall"
> -	depends on KEXEC_FILE && MODULE_SIG_FORMAT
> -	help
> -	  This option makes kernel signature verification mandatory for
> -	  the kexec_file_load() syscall.
> -
> -	  In addition to that option, you need to enable signature
> -	  verification for the corresponding kernel image type being
> -	  loaded in order for this to work.
> -
>  config KERNEL_NOBP
>  	def_bool n
>  	prompt "Enable modified branch prediction for the kernel by default"
> @@ -733,22 +722,6 @@ config VFIO_AP
>  
>  endmenu
>  
> -menu "Dump support"
> -
> -config CRASH_DUMP
> -	bool "kernel crash dumps"
> -	select KEXEC
> -	help
> -	  Generate crash dump after being started by kexec.
> -	  Crash dump kernels are loaded in the main kernel with kexec-tools
> -	  into a specially reserved region and then later executed after
> -	  a crash by kdump/kexec.
> -	  Refer to <file:Documentation/s390/zfcpdump.rst> for more details on this.
> -	  This option also enables s390 zfcpdump.
> -	  See also <file:Documentation/s390/zfcpdump.rst>
> -
> -endmenu
> -
>  config CCW
>  	def_bool y
>  
> -- 
> 2.31.1
> 

I just bisected the following build failure visible with 'ARCH=s390
allnoconfig' to this change as commit 842ce0e1dafa ("s390/kexec:
refactor for kernel/Kconfig.kexec") in -next.

  arch/s390/kernel/machine_kexec.c:120:37: warning: 'struct kimage' declared inside parameter list will not be visible outside of this definition or declaration
    120 | static bool kdump_csum_valid(struct kimage *image)
        |                                     ^~~~~~
  arch/s390/kernel/machine_kexec.c:188:34: warning: 'struct kimage' declared inside parameter list will not be visible outside of this definition or declaration
    188 | int machine_kexec_prepare(struct kimage *image)
        |                                  ^~~~~~
  arch/s390/kernel/machine_kexec.c: In function 'machine_kexec_prepare':
  arch/s390/kernel/machine_kexec.c:192:18: error: invalid use of undefined type 'struct kimage'
    192 |         if (image->type == KEXEC_TYPE_CRASH)
        |                  ^~
  arch/s390/kernel/machine_kexec.c:192:28: error: 'KEXEC_TYPE_CRASH' undeclared (first use in this function); did you mean 'KEXEC_ON_CRASH'?
    192 |         if (image->type == KEXEC_TYPE_CRASH)
        |                            ^~~~~~~~~~~~~~~~
        |                            KEXEC_ON_CRASH
  arch/s390/kernel/machine_kexec.c:192:28: note: each undeclared identifier is reported only once for each function it appears in
  arch/s390/kernel/machine_kexec.c:196:18: error: invalid use of undefined type 'struct kimage'
    196 |         if (image->type != KEXEC_TYPE_DEFAULT)
        |                  ^~
  arch/s390/kernel/machine_kexec.c:196:28: error: 'KEXEC_TYPE_DEFAULT' undeclared (first use in this function); did you mean 'KEXEC_ARCH_DEFAULT'?
    196 |         if (image->type != KEXEC_TYPE_DEFAULT)
        |                            ^~~~~~~~~~~~~~~~~~
        |                            KEXEC_ARCH_DEFAULT
  In file included from arch/s390/include/asm/thread_info.h:31,
                   from include/linux/thread_info.h:60,
                   from arch/s390/include/asm/preempt.h:6,
                   from include/linux/preempt.h:79,
                   from arch/s390/include/asm/percpu.h:5,
                   from include/linux/irqflags.h:18,
                   from include/linux/rcupdate.h:26,
                   from include/linux/rculist.h:11,
                   from include/linux/pid.h:5,
                   from include/linux/sched.h:14,
                   from include/linux/ratelimit.h:6,
                   from include/linux/dev_printk.h:16,
                   from include/linux/device.h:15,
                   from arch/s390/kernel/machine_kexec.c:9:
  arch/s390/kernel/machine_kexec.c:200:48: error: invalid use of undefined type 'struct kimage'
    200 |         reboot_code_buffer = page_to_virt(image->control_code_page);
        |                                                ^~
  arch/s390/include/asm/page.h:186:58: note: in definition of macro '__va'
    186 | #define __va(x)                 ((void *)(unsigned long)(x))
        |                                                          ^
  arch/s390/include/asm/page.h:194:38: note: in expansion of macro 'pfn_to_phys'
    194 | #define pfn_to_virt(pfn)        __va(pfn_to_phys(pfn))
        |                                      ^~~~~~~~~~~
  arch/s390/include/asm/page.h:199:33: note: in expansion of macro 'pfn_to_virt'
    199 | #define page_to_virt(page)      pfn_to_virt(page_to_pfn(page))
        |                                 ^~~~~~~~~~~
  include/asm-generic/memory_model.h:64:21: note: in expansion of macro '__page_to_pfn'
     64 | #define page_to_pfn __page_to_pfn
        |                     ^~~~~~~~~~~~~
  arch/s390/kernel/machine_kexec.c:200:30: note: in expansion of macro 'page_to_virt'
    200 |         reboot_code_buffer = page_to_virt(image->control_code_page);
        |                              ^~~~~~~~~~~~
  arch/s390/kernel/machine_kexec.c: At top level:
  arch/s390/kernel/machine_kexec.c:207:35: warning: 'struct kimage' declared inside parameter list will not be visible outside of this definition or declaration
    207 | void machine_kexec_cleanup(struct kimage *image)
        |                                   ^~~~~~
  arch/s390/kernel/machine_kexec.c: In function '__do_machine_kexec':
  arch/s390/kernel/machine_kexec.c:243:40: error: invalid use of undefined type 'struct kimage'
    243 |         data_mover = page_to_phys(image->control_code_page);
        |                                        ^~
  arch/s390/include/asm/page.h:189:35: note: in definition of macro 'pfn_to_phys'
    189 | #define pfn_to_phys(pfn)        ((pfn) << PAGE_SHIFT)
        |                                   ^~~
  include/asm-generic/memory_model.h:64:21: note: in expansion of macro '__page_to_pfn'
     64 | #define page_to_pfn __page_to_pfn
        |                     ^~~~~~~~~~~~~
  arch/s390/kernel/machine_kexec.c:243:22: note: in expansion of macro 'page_to_phys'
    243 |         data_mover = page_to_phys(image->control_code_page);
        |                      ^~~~~~~~~~~~
  arch/s390/kernel/machine_kexec.c:244:36: error: invalid use of undefined type 'struct kimage'
    244 |         entry = virt_to_phys(&image->head);
        |                                    ^~
  In file included from arch/s390/kernel/machine_kexec.c:27:
  arch/s390/kernel/machine_kexec.c:252:40: error: invalid use of undefined type 'struct kimage'
    252 |                    unsigned long, image->start,
        |                                        ^~
  arch/s390/include/asm/stacktrace.h:101:32: note: in definition of macro 'CALL_LARGS_2'
    101 |         long arg2 = (long)(t2)(a2)
        |                                ^~
  arch/s390/include/asm/stacktrace.h:216:9: note: in expansion of macro 'CALL_LARGS_3'
    216 |         CALL_LARGS_##nr(__VA_ARGS__);                                   \
        |         ^~~~~~~~~~~
  arch/s390/kernel/machine_kexec.c:250:9: note: in expansion of macro 'call_nodat'
    250 |         call_nodat(3, void, (relocate_kernel_t)data_mover,
        |         ^~~~~~~~~~
  In file included from include/linux/irqflags.h:15:
  arch/s390/kernel/machine_kexec.c:252:40: error: invalid use of undefined type 'struct kimage'
    252 |                    unsigned long, image->start,
        |                                        ^~
  include/linux/typecheck.h:11:16: note: in definition of macro 'typecheck'
     11 |         typeof(x) __dummy2; \
        |                ^
  arch/s390/include/asm/stacktrace.h:136:9: note: in expansion of macro 'CALL_TYPECHECK_2'
    136 |         CALL_TYPECHECK_2(__VA_ARGS__);                                  \
        |         ^~~~~~~~~~~~~~~~
  arch/s390/include/asm/stacktrace.h:219:9: note: in expansion of macro 'CALL_TYPECHECK_3'
    219 |         CALL_TYPECHECK_##nr(__VA_ARGS__);                               \
        |         ^~~~~~~~~~~~~~~
  arch/s390/kernel/machine_kexec.c:250:9: note: in expansion of macro 'call_nodat'
    250 |         call_nodat(3, void, (relocate_kernel_t)data_mover,
        |         ^~~~~~~~~~
  include/linux/typecheck.h:12:25: warning: comparison of distinct pointer types lacks a cast
     12 |         (void)(&__dummy == &__dummy2); \
        |                         ^~
  arch/s390/include/asm/stacktrace.h:134:9: note: in expansion of macro 'typecheck'
    134 |         typecheck(t, a)
        |         ^~~~~~~~~
  arch/s390/include/asm/stacktrace.h:136:9: note: in expansion of macro 'CALL_TYPECHECK_2'
    136 |         CALL_TYPECHECK_2(__VA_ARGS__);                                  \
        |         ^~~~~~~~~~~~~~~~
  arch/s390/include/asm/stacktrace.h:219:9: note: in expansion of macro 'CALL_TYPECHECK_3'
    219 |         CALL_TYPECHECK_##nr(__VA_ARGS__);                               \
        |         ^~~~~~~~~~~~~~~
  arch/s390/kernel/machine_kexec.c:250:9: note: in expansion of macro 'call_nodat'
    250 |         call_nodat(3, void, (relocate_kernel_t)data_mover,
        |         ^~~~~~~~~~
  arch/s390/kernel/machine_kexec.c: At top level:
  arch/s390/kernel/machine_kexec.c:278:27: warning: 'struct kimage' declared inside parameter list will not be visible outside of this definition or declaration
    278 | void machine_kexec(struct kimage *image)
        |                           ^~~~~~
  arch/s390/kernel/machine_kexec.c: In function 'machine_kexec':
  arch/s390/kernel/machine_kexec.c:280:18: error: invalid use of undefined type 'struct kimage'
    280 |         if (image->type == KEXEC_TYPE_CRASH && !kdump_csum_valid(image))
        |                  ^~
  arch/s390/kernel/machine_kexec.c:280:28: error: 'KEXEC_TYPE_CRASH' undeclared (first use in this function); did you mean 'KEXEC_ON_CRASH'?
    280 |         if (image->type == KEXEC_TYPE_CRASH && !kdump_csum_valid(image))
        |                            ^~~~~~~~~~~~~~~~
        |                            KEXEC_ON_CRASH
  arch/s390/kernel/machine_kexec.c:280:66: error: passing argument 1 of 'kdump_csum_valid' from incompatible pointer type [-Werror=incompatible-pointer-types]
    280 |         if (image->type == KEXEC_TYPE_CRASH && !kdump_csum_valid(image))
        |                                                                  ^~~~~
        |                                                                  |
        |                                                                  struct kimage *
  arch/s390/kernel/machine_kexec.c:120:45: note: expected 'struct kimage *' but argument is of type 'struct kimage *'
    120 | static bool kdump_csum_valid(struct kimage *image)
        |                              ~~~~~~~~~~~~~~~^~~~~
  cc1: some warnings being treated as errors

I don't think this change is equivalent for s390, which had

  config KEXEC
      def_bool y
      select KEXEC_CORE

but it is now the equivalent of

  config KEXEC
      bool "Enable kexec system call"
      default y

which enables KEXEC by default but it also allows KEXEC to be disabled
for s390 now, because it is a user-visible symbol, not one that is
unconditionally enabled no matter what. If s390 can tolerate KEXEC being
user selectable, then I assume the fix is just adjusting
arch/s390/kernel/Makefile to only build the machine_kexec files when
CONFIG_KEXEC_CORE is set:

diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 6b2a051e1f8a..a06b39da95f0 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -37,10 +37,10 @@ CFLAGS_unwind_bc.o	+= -fno-optimize-sibling-calls
 obj-y	:= head64.o traps.o time.o process.o earlypgm.o early.o setup.o idle.o vtime.o
 obj-y	+= processor.o syscall.o ptrace.o signal.o cpcmd.o ebcdic.o nmi.o
 obj-y	+= debug.o irq.o ipl.o dis.o diag.o vdso.o cpufeature.o
-obj-y	+= sysinfo.o lgr.o os_info.o machine_kexec.o
+obj-y	+= sysinfo.o lgr.o os_info.o
 obj-y	+= runtime_instr.o cache.o fpu.o dumpstack.o guarded_storage.o sthyi.o
 obj-y	+= entry.o reipl.o relocate_kernel.o kdebugfs.o alternative.o
-obj-y	+= nospec-branch.o ipl_vmparm.o machine_kexec_reloc.o unwind_bc.o
+obj-y	+= nospec-branch.o ipl_vmparm.o unwind_bc.o
 obj-y	+= smp.o text_amode31.o stacktrace.o abs_lowcore.o
 
 extra-y				+= vmlinux.lds
@@ -66,6 +66,7 @@ obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
+obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o machine_kexec_reloc.o
 obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_image.o
 obj-$(CONFIG_KEXEC_FILE)	+= kexec_elf.o
 

Otherwise, the prompt for KEXEC could be made conditional on some ARCH
symbol so that architectures can opt out of it.

As an aside, is this intended for the 6.5 merge window? If not, it
shouldn't be in -next at this point, I was surprised to see new broken
builds.

Cheers,
Nathan
