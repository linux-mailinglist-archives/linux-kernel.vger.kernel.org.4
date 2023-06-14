Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F254E72F1AD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 03:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbjFNBWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 21:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjFNBWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 21:22:43 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BF810F3;
        Tue, 13 Jun 2023 18:22:41 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Qgng45C3bzLmks;
        Wed, 14 Jun 2023 09:20:48 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 09:22:36 +0800
Subject: Re: [PATCH v1 05/21] arm64/kexec: refactor for kernel/Kconfig.kexec
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
 <20230612172805.681179-6-eric.devolder@oracle.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <29427d7c-7d81-9bda-0067-d17b51952cb4@huawei.com>
Date:   Wed, 14 Jun 2023 09:22:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230612172805.681179-6-eric.devolder@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
> The kexec and crash kernel options are provided in the common
> kernel/Kconfig.kexec. Utilize the common options and provide
> the ARCH_HAS_ and ARCH_SUPPORTS_ entries to recreate the
> equivalent set of KEXEC and CRASH options.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  arch/arm64/Kconfig | 61 ++++++++--------------------------------------
>  1 file changed, 10 insertions(+), 51 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 343e1e1cae10..33552476a877 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1433,60 +1433,19 @@ config PARAVIRT_TIME_ACCOUNTING
>  
>  	  If in doubt, say N here.
>  
> -config KEXEC
> -	depends on PM_SLEEP_SMP
> -	select KEXEC_CORE
> -	bool "kexec system call"
> -	help
> -	  kexec is a system call that implements the ability to shutdown your
> -	  current kernel, and to start another kernel.  It is like a reboot
> -	  but it is independent of the system firmware.   And like a reboot
> -	  you can start any kernel with it, not just Linux.
> -
> -config KEXEC_FILE
> -	bool "kexec file based system call"
> -	select KEXEC_CORE
> -	select HAVE_IMA_KEXEC if IMA
> -	help
> -	  This is new version of kexec system call. This system call is
> -	  file based and takes file descriptors as system call argument
> -	  for kernel and initramfs as opposed to list of segments as
> -	  accepted by previous system call.
> -
> -config KEXEC_SIG
> -	bool "Verify kernel signature during kexec_file_load() syscall"
> -	depends on KEXEC_FILE
> -	help
> -	  Select this option to verify a signature with loaded kernel
> -	  image. If configured, any attempt of loading a image without
> -	  valid signature will fail.
> -
> -	  In addition to that option, you need to enable signature
> -	  verification for the corresponding kernel image type being
> -	  loaded in order for this to work.
> +config ARCH_HAS_KEXEC
> +	def_bool PM_SLEEP_SMP
>  
> -config KEXEC_IMAGE_VERIFY_SIG
> -	bool "Enable Image signature verification support"
> -	default y
> -	depends on KEXEC_SIG
> -	depends on EFI && SIGNED_PE_FILE_VERIFICATION
> -	help
> -	  Enable Image signature verification support.

I don't see an alternative to this option. It's used in
arch/arm64/kernel/kexec_image.c:135

> -
> -comment "Support for PE file signature verification disabled"
> -	depends on KEXEC_SIG
> -	depends on !EFI || !SIGNED_PE_FILE_VERIFICATION
> +config ARCH_HAS_KEXEC_FILE
> +	def_bool y
>  
> -config CRASH_DUMP
> -	bool "Build kdump crash kernel"
> -	help
> -	  Generate crash dump after being started by kexec. This should
> -	  be normally only set in special crash dump kernels which are
> -	  loaded in the main kernel with kexec-tools into a specially
> -	  reserved region and then later executed after a crash by
> -	  kdump/kexec.
> +config ARCH_SUPPORTS_KEXEC_FILE
> +	def_bool y
> +	depends on KEXEC_FILE
> +	select HAVE_IMA_KEXEC if IMA
>  
> -	  For more details see Documentation/admin-guide/kdump/kdump.rst
> +config ARCH_HAS_CRASH_DUMP
> +	def_bool y
>  
>  config TRANS_TABLE
>  	def_bool y
> 

-- 
Regards,
  Zhen Lei
