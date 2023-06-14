Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013BB72F18F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 03:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242066AbjFNBTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 21:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242002AbjFNBTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 21:19:46 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28AC195;
        Tue, 13 Jun 2023 18:19:43 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QgnX45KKjz18MCL;
        Wed, 14 Jun 2023 09:14:44 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 09:19:38 +0800
Subject: Re: [PATCH v1 01/21] kexec: consolidate kexec and crash options into
 kernel/Kconfig.kexec
To:     Eric DeVolder <eric.devolder@oracle.com>, <linux@armlinux.org.uk>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <chenhuacai@kernel.org>, <geert@linux-m68k.org>,
        <tsbogend@alpha.franken.de>,
        <James.Bottomley@HansenPartnership.com>, <deller@gmx.de>,
        <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <glaubitz@physik.fu-berlin.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-ia64@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <linux-m68k@lists.linux-m68k.org>, <linux-mips@vger.kernel.org>,
        <linux-parisc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
        <linux-sh@vger.kernel.org>
CC:     <kernel@xen0n.name>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <hca@linux.ibm.com>,
        <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
        <hpa@zytor.com>, <keescook@chromium.org>, <paulmck@kernel.org>,
        <peterz@infradead.org>, <frederic@kernel.org>,
        <akpm@linux-foundation.org>, <ardb@kernel.org>,
        <samitolvanen@google.com>, <juerg.haefliger@canonical.com>,
        <arnd@arndb.de>, <rmk+kernel@armlinux.org.uk>,
        <linus.walleij@linaro.org>, <sebastian.reichel@collabora.com>,
        <rppt@kernel.org>, <kirill.shutemov@linux.intel.com>,
        <anshuman.khandual@arm.com>, <ziy@nvidia.com>,
        <masahiroy@kernel.org>, <ndesaulniers@google.com>,
        <mhiramat@kernel.org>, <ojeda@kernel.org>, <xin3.li@intel.com>,
        <tj@kernel.org>, <gregkh@linuxfoundation.org>, <tsi@tuyoix.net>,
        <bhe@redhat.com>, <hbathini@linux.ibm.com>,
        <sourabhjain@linux.ibm.com>, <boris.ostrovsky@oracle.com>,
        <konrad.wilk@oracle.com>
References: <20230612172805.681179-1-eric.devolder@oracle.com>
 <20230612172805.681179-2-eric.devolder@oracle.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <6e362106-9d74-1e00-b94d-ce094367e939@huawei.com>
Date:   Wed, 14 Jun 2023 09:19:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230612172805.681179-2-eric.devolder@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/13 1:27, Eric DeVolder wrote:
> The config options for kexec and crash features are consolidated
> into new file kernel/Kconfig.kexec. Under the "General Setup" submenu
> is a new submenu "Kexec and crash handling" where all the kexec and
> crash options that were once in the arch-dependent submenu "Processor
> type and features" are now consolidated.
> 
> The following options are impacted:
> 
>  - KEXEC
>  - KEXEC_FILE
>  - KEXEC_SIG
>  - KEXEC_SIG_FORCE
>  - KEXEC_BZIMAGE_VERIFY_SIG
>  - KEXEC_JUMP
>  - CRASH_DUMP
> 
> The three main options are KEXEC, KEXEC_FILE and CRASH_DUMP.
> 
> Architectures specify support of certain KEXEC and CRASH features with
> similarly named new ARCH_HAS_<option> config options.
> 
> Architectures can utilize the new ARCH_SUPPORTS_<option> config
> options to specify additional components when <option> is enabled.
> 
> To summarize, the ARCH_HAS_<option> permits the <option> to be
> enabled, and the ARCH_SUPPORTS_<option> handles side effects (ie.
> select statements).
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  arch/Kconfig         |  13 ------
>  init/Kconfig         |   2 +
>  kernel/Kconfig.kexec | 103 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+), 13 deletions(-)
>  create mode 100644 kernel/Kconfig.kexec
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 205fd23e0cad..a37730679730 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -11,19 +11,6 @@ source "arch/$(SRCARCH)/Kconfig"
>  
>  menu "General architecture-dependent options"
>  
> -config CRASH_CORE
> -	bool
> -
> -config KEXEC_CORE
> -	select CRASH_CORE
> -	bool
> -
> -config KEXEC_ELF
> -	bool
> -
> -config HAVE_IMA_KEXEC
> -	bool
> -
>  config ARCH_HAS_SUBPAGE_FAULTS
>  	bool
>  	help
> diff --git a/init/Kconfig b/init/Kconfig
> index 32c24950c4ce..4424447e23a5 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1917,6 +1917,8 @@ config BINDGEN_VERSION_TEXT
>  config TRACEPOINTS
>  	bool
>  
> +source "kernel/Kconfig.kexec"
> +
>  endmenu		# General setup
>  
>  source "arch/Kconfig"
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> new file mode 100644
> index 000000000000..660048099865
> --- /dev/null
> +++ b/kernel/Kconfig.kexec
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +menu "Kexec and crash features"
> +
> +config CRASH_CORE
> +	bool
> +
> +config KEXEC_CORE
> +	select CRASH_CORE
> +	bool
> +
> +config KEXEC_ELF
> +	bool
> +
> +config HAVE_IMA_KEXEC
> +	bool
> +
> +config KEXEC
> +	bool "Enable kexec system call"
> +	default ARCH_DEFAULT_KEXEC
> +	depends on ARCH_HAS_KEXEC
> +	select KEXEC_CORE
> +	help
> +	  kexec is a system call that implements the ability to shutdown your
> +	  current kernel, and to start another kernel.  It is like a reboot
> +	  but it is independent of the system firmware.   And like a reboot
> +	  you can start any kernel with it, not just Linux.

"kernel.  It is like", "firmware.   And like"

A few more spaces, I don't know the original author's intention, perhaps can be removed.

> +
> +	  The name comes from the similarity to the exec system call.
> +
> +	  It is an ongoing process to be certain the hardware in a machine
> +	  is properly shutdown, so do not be surprised if this code does not
> +	  initially work for you.  As of this writing the exact hardware
> +	  interface is strongly in flux, so no good recommendation can be
> +	  made.
> +
> +config KEXEC_FILE
> +	bool "Enable kexec file based system call"
> +	depends on ARCH_HAS_KEXEC_FILE
> +	select KEXEC_CORE
> +	help
> +	  This is new version of kexec system call. This system call is
> +	  file based and takes file descriptors as system call argument
> +	  for kernel and initramfs as opposed to list of segments as
> +	  accepted by previous system call.
> +
> +config KEXEC_SIG
> +	bool "Verify kernel signature during kexec_file_load() syscall"
> +	depends on KEXEC_FILE && MODULE_SIG_FORMAT

I see that there is no "depends on MODULE_SIG_FORMAT" on x86 and arm64.

> +	help
> +

This blank line can be deleted.

> +	  This option makes the kexec_file_load() syscall check for a valid
> +	  signature of the kernel image.  The image can still be loaded without
> +	  a valid signature unless you also enable KEXEC_SIG_FORCE, though if
> +	  there's a signature that we can check, then it must be valid.
> +
> +	  In addition to this option, you need to enable signature
> +	  verification for the corresponding kernel image type being
> +	  loaded in order for this to work.
> +
> +config KEXEC_SIG_FORCE
> +	bool "Require a valid signature in kexec_file_load() syscall"
> +	depends on KEXEC_SIG
> +	help
> +	  This option makes kernel signature verification mandatory for
> +	  the kexec_file_load() syscall.
> +
> +config KEXEC_BZIMAGE_VERIFY_SIG
> +	bool "Enable bzImage signature verification support"
> +	depends on KEXEC_SIG
> +	depends on SIGNED_PE_FILE_VERIFICATION
> +	select SYSTEM_TRUSTED_KEYRING
> +	help
> +	  Enable bzImage signature verification support.
> +
> +config KEXEC_JUMP
> +	bool "kexec jump"
> +	depends on KEXEC && HIBERNATION
> +	depends on ARCH_HAS_KEXEC_JUMP
> +	help
> +	  Jump between original kernel and kexeced kernel and invoke
> +	  code in physical address mode via KEXEC
> +
> +config CRASH_DUMP
> +	bool "kernel crash dumps"
> +	depends on ARCH_HAS_CRASH_DUMP
> +	select KEXEC_CORE
> +	select CRASH_CORE
> +	help
> +	  Generate crash dump after being started by kexec.
> +	  This should be normally only set in special crash dump kernels
> +	  which are loaded in the main kernel with kexec-tools into
> +	  a specially reserved region and then later executed after
> +	  a crash by kdump/kexec. The crash dump kernel must be compiled
> +	  to a memory address not used by the main kernel or BIOS using
> +	  PHYSICAL_START, or it must be built as a relocatable image
> +	  (CONFIG_RELOCATABLE=y).
> +	  For more details see Documentation/admin-guide/kdump/kdump.rst
> +
> +	  For s390, this option also enables zfcpdump.
> +	  See also <file:Documentation/s390/zfcpdump.rst>
> +
> +endmenu
> 

-- 
Regards,
  Zhen Lei
