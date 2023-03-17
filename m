Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44916BE636
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCQKJE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Mar 2023 06:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCQKJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:09:02 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CFE7A8A;
        Fri, 17 Mar 2023 03:08:57 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pd70n-0000QK-7c; Fri, 17 Mar 2023 11:08:37 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Evan Green <evan@rivosinc.com>
Cc:     slewis@rivosinc.com, Conor Dooley <conor@kernel.org>,
        vineetg@rivosinc.com, Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Wei Fu <wefu@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 4/6] RISC-V: hwprobe: Support probing of misaligned access
 performance
Date:   Fri, 17 Mar 2023 11:08:36 +0100
Message-ID: <1846748.tdWV9SEqCh@diego>
In-Reply-To: <20230314183220.513101-5-evan@rivosinc.com>
References: <20230314183220.513101-1-evan@rivosinc.com>
 <20230314183220.513101-5-evan@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

Am Dienstag, 14. März 2023, 19:32:18 CET schrieb Evan Green:
> This allows userspace to select various routines to use based on the
> performance of misaligned access on the target hardware.

I really like this implementation.

Also interesting that T-Head actually has a fast unaligned access.
Maybe that should be part of the commit message (including were
this information comes from)


> Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Evan Green <evan@rivosinc.com>
> 
> ---
> 
> Changes in v4:
>  - Add newlines to CPUPERF_0 documentation (Conor)
>  - Add UNSUPPORTED value (Conor)
>  - Switched from DT to alternatives-based probing (Rob)
>  - Crispen up cpu index type to always be int (Conor)
> 
> Changes in v3:
>  - Have hwprobe_misaligned return int instead of long.
>  - Constify cpumask pointer in hwprobe_misaligned()
>  - Fix warnings in _PERF_O list documentation, use :c:macro:.
>  - Move include cpufeature.h to misaligned patch.
>  - Fix documentation mismatch for RISCV_HWPROBE_KEY_CPUPERF_0 (Conor)
>  - Use for_each_possible_cpu() instead of NR_CPUS (Conor)
>  - Break early in misaligned access iteration (Conor)
>  - Increase MISALIGNED_MASK from 2 bits to 3 for possible UNSUPPORTED future
>    value (Conor)
> 
> Changes in v2:
>  - Fixed logic error in if(of_property_read_string...) that caused crash
>  - Include cpufeature.h in cpufeature.h to avoid undeclared variable
>    warning.
>  - Added a _MASK define
>  - Fix random checkpatch complaints
> 
>  Documentation/riscv/hwprobe.rst       | 21 ++++++++++++++++++++
>  arch/riscv/errata/thead/errata.c      |  9 +++++++++
>  arch/riscv/include/asm/alternative.h  |  5 +++++
>  arch/riscv/include/asm/cpufeature.h   |  2 ++
>  arch/riscv/include/asm/hwprobe.h      |  2 +-
>  arch/riscv/include/uapi/asm/hwprobe.h |  7 +++++++
>  arch/riscv/kernel/alternative.c       | 19 ++++++++++++++++++
>  arch/riscv/kernel/cpufeature.c        |  3 +++
>  arch/riscv/kernel/smpboot.c           |  1 +
>  arch/riscv/kernel/sys_riscv.c         | 28 +++++++++++++++++++++++++++
>  10 files changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
> index 945d44683c40..9f0dd62dcb5d 100644
> --- a/Documentation/riscv/hwprobe.rst
> +++ b/Documentation/riscv/hwprobe.rst
> @@ -63,3 +63,24 @@ The following keys are defined:
>  
>    * :c:macro:`RISCV_HWPROBE_IMA_C`: The C extension is supported, as defined
>      by version 2.2 of the RISC-V ISA manual.
> +
> +* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
> +  information about the selected set of processors.
> +
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
> +    accesses is unknown.
> +
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned accesses are
> +    emulated via software, either in or below the kernel.  These accesses are
> +    always extremely slow.
> +
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned accesses are supported
> +    in hardware, but are slower than the cooresponding aligned accesses
> +    sequences.
> +
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned accesses are supported
> +    in hardware and are faster than the cooresponding aligned accesses
> +    sequences.
> +
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned accesses are
> +    not supported at all and will generate a misaligned address fault.
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index fac5742d1c1e..f41a45af5607 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -10,7 +10,9 @@
>  #include <linux/uaccess.h>
>  #include <asm/alternative.h>
>  #include <asm/cacheflush.h>
> +#include <asm/cpufeature.h>
>  #include <asm/errata_list.h>
> +#include <asm/hwprobe.h>
>  #include <asm/patch.h>
>  #include <asm/vendorid_list.h>
>  
> @@ -108,3 +110,10 @@ void __init_or_module thead_errata_patch_func(struct alt_entry *begin, struct al
>  	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
>  		local_flush_icache_all();
>  }
> +
> +void thead_feature_probe_func(unsigned int cpu, unsigned long archid,
> +			      unsigned long impid)
> +{
> +	if ((archid == 0) && (impid == 0))
> +		per_cpu(misaligned_access_speed, cpu) = RISCV_HWPROBE_MISALIGNED_FAST;

When looking at this function I 'm wondering if we also want to expose
the active erratas somehow (not in this patch of course, just in general)


Heiko


