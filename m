Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844B76C372C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjCUQmB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Mar 2023 12:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjCUQlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:41:50 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81A152911;
        Tue, 21 Mar 2023 09:41:33 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pef2q-0002rh-BA; Tue, 21 Mar 2023 17:41:08 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Evan Green <evan@rivosinc.com>
Cc:     slewis@rivosinc.com, Conor Dooley <conor@kernel.org>,
        vineetg@rivosinc.com, Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 3/6] RISC-V: hwprobe: Add support for
 RISCV_HWPROBE_BASE_BEHAVIOR_IMA
Date:   Tue, 21 Mar 2023 17:41:07 +0100
Message-ID: <3351107.e9J7NaK4W3@diego>
In-Reply-To: <20230314183220.513101-4-evan@rivosinc.com>
References: <20230314183220.513101-1-evan@rivosinc.com>
 <20230314183220.513101-4-evan@rivosinc.com>
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

Am Dienstag, 14. März 2023, 19:32:17 CET schrieb Evan Green:
> We have an implicit set of base behaviors that userspace depends on,
> which are mostly defined in various ISA specifications.
> 
> Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Evan Green <evan@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> 
> Changes in v4:
>  - More newlines in BASE_BEHAVIOR_IMA documentation (Conor)
> 
> Changes in v3:
>  - Refactored base ISA behavior probe to allow kernel probing as well,
>    in prep for vDSO data initialization.
>  - Fixed doc warnings in IMA text list, use :c:macro:.
> 
>  Documentation/riscv/hwprobe.rst       | 24 ++++++++++++++++++++++++
>  arch/riscv/include/asm/hwprobe.h      |  2 +-
>  arch/riscv/include/uapi/asm/hwprobe.h |  5 +++++
>  arch/riscv/kernel/sys_riscv.c         | 20 ++++++++++++++++++++
>  4 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
> index 211828f706e3..945d44683c40 100644
> --- a/Documentation/riscv/hwprobe.rst
> +++ b/Documentation/riscv/hwprobe.rst
> @@ -39,3 +39,27 @@ The following keys are defined:
>  
>  * :c:macro:`RISCV_HWPROBE_KEY_MIMPLID`: Contains the value of ``mimplid``, as
>    defined by the RISC-V privileged architecture specification.
> +
> +* :c:macro:`RISCV_HWPROBE_KEY_BASE_BEHAVIOR`: A bitmask containing the base
> +  user-visible behavior that this kernel supports.  The following base user ABIs
> +  are defined:
> +
> +  * :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`: Support for rv32ima or
> +    rv64ima, as defined by version 2.2 of the user ISA and version 1.10 of the
> +    privileged ISA, with the following known exceptions (more exceptions may be
> +    added, but only if it can be demonstrated that the user ABI is not broken):
> +
> +    * The :fence.i: instruction cannot be directly executed by userspace
> +      programs (it may still be executed in userspace via a
> +      kernel-controlled mechanism such as the vDSO).
> +
> +* :c:macro:`RISCV_HWPROBE_KEY_IMA_EXT_0`: A bitmask containing the extensions
> +  that are compatible with the :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`:
> +  base system behavior.
> +
> +  * :c:macro:`RISCV_HWPROBE_IMA_FD`: The F and D extensions are supported, as
> +    defined by commit cd20cee ("FMIN/FMAX now implement
> +    minimumNumber/maximumNumber, not minNum/maxNum") of the RISC-V ISA manual.
> +
> +  * :c:macro:`RISCV_HWPROBE_IMA_C`: The C extension is supported, as defined
> +    by version 2.2 of the RISC-V ISA manual.

just wondering, is there a plan on how further extensions should be added this this?
[as we have this big plethora of them :-) ]

Aka things like Zbb and friends will probably also be relevant to userspace, so just
fill up RISCV_HWPROBE_KEY_IMA_EXT_0 with more elements and once full switch to
RISCV_HWPROBE_KEY_IMA_EXT_1 , RISCV_HWPROBE_KEY_IMA_EXT_2, etc?

Or do we have some more elaborate sorting mechanism?


Thanks
Heiko



> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
> index 08d1c3bdd78a..7e52f1e1fe10 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -8,6 +8,6 @@
>  
>  #include <uapi/asm/hwprobe.h>
>  
> -#define RISCV_HWPROBE_MAX_KEY 2
> +#define RISCV_HWPROBE_MAX_KEY 4
>  
>  #endif
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index 591802047460..fc5665411782 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -20,6 +20,11 @@ struct riscv_hwprobe {
>  #define RISCV_HWPROBE_KEY_MVENDORID	0
>  #define RISCV_HWPROBE_KEY_MARCHID	1
>  #define RISCV_HWPROBE_KEY_MIMPID	2
> +#define RISCV_HWPROBE_KEY_BASE_BEHAVIOR	3
> +#define		RISCV_HWPROBE_BASE_BEHAVIOR_IMA	(1 << 0)
> +#define RISCV_HWPROBE_KEY_IMA_EXT_0	4
> +#define		RISCV_HWPROBE_IMA_FD		(1 << 0)
> +#define		RISCV_HWPROBE_IMA_C		(1 << 1)
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>  
>  #endif
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index 981d23457f13..1c118438b1b3 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -9,6 +9,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/hwprobe.h>
>  #include <asm/sbi.h>
> +#include <asm/switch_to.h>
>  #include <asm/uaccess.h>
>  #include <asm/unistd.h>
>  #include <asm-generic/mman-common.h>
> @@ -125,6 +126,25 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>  	case RISCV_HWPROBE_KEY_MIMPID:
>  		hwprobe_arch_id(pair, cpus);
>  		break;
> +	/*
> +	 * The kernel already assumes that the base single-letter ISA
> +	 * extensions are supported on all harts, and only supports the
> +	 * IMA base, so just cheat a bit here and tell that to
> +	 * userspace.
> +	 */
> +	case RISCV_HWPROBE_KEY_BASE_BEHAVIOR:
> +		pair->value = RISCV_HWPROBE_BASE_BEHAVIOR_IMA;
> +		break;
> +
> +	case RISCV_HWPROBE_KEY_IMA_EXT_0:
> +		pair->value = 0;
> +		if (has_fpu())
> +			pair->value |= RISCV_HWPROBE_IMA_FD;
> +
> +		if (elf_hwcap & RISCV_ISA_EXT_c)
> +			pair->value |= RISCV_HWPROBE_IMA_C;
> +
> +		break;
>  
>  	/*
>  	 * For forward compatibility, unknown keys don't fail the whole
> 




