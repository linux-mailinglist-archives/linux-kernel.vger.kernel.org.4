Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3566F262E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 22:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjD2UHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 16:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjD2UH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 16:07:28 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1A8D1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 13:07:27 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-518d325b8a2so988976a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 13:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682798847; x=1685390847;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gK6tDOdJW77UWu8ehgn7i7aWpumq/WKr2MIt910Bd7s=;
        b=WUBihcm+a1wpS7sQ0pUFu/12EftxNcYgnMPnivlxueG/BXZLvLXm1D0m9x4TpwKfYM
         WhjlyrxIzgdGQrOSerXLVb+DmP7Im/xmFKyyqN6874MSA0SBwFBwfF7EUBn3uELfAjbH
         QwwAIq6evQjfUTzKJdF+k927U8Z04HG1gaodLLi10V7IR0kBJ3Tj3n+K/4hqysqMX8Qf
         7FXWKtVSdNGRAyd3va/O/CHUiDQ1qbTsw30YAMjfrS6Ov1GmYbupDIMvEVN2Mm1JwCc9
         4t1ZDnDjJVF4MUyJ/DIXUhzqvCfUnLmtrZT35u0xP0Xt0ZXfQh+wC5KSuvdDBa5lD0P4
         /4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682798847; x=1685390847;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gK6tDOdJW77UWu8ehgn7i7aWpumq/WKr2MIt910Bd7s=;
        b=CEuhP+5jgbYb5ziCEaARQtCdoO2+pTf4nc2wG4x8tn2SjhSworR1cacboDiZc3wFLF
         WqggsZSI3tV6z4azxDVmya29IB2KFTZPwB4PDSDtHsTB3+1w7PpG+At6KVgG0c5C3zJA
         KH7oERKEfitqvvKUX+DQn7g7skwHsaa2D1wu80B9EfucQBA7AGBtzNY88hPwxTPUr7Cz
         3x1Gf/fYIcy934NDs+5fBiw4A54vSWX8YBUOBsvCha4Uxud+VKCPJK+ZCXBK2bwbQqT4
         ieKJVBjTAcjjNpBZVZb4xXvCpceGz3ttYzJTFN6/xXj/xQjBM+rcJ9aBC7solRqT1U5C
         obbQ==
X-Gm-Message-State: AC+VfDwqVo6ayAnPQMK7L+gXH0b8n/D6nc0xLjcCQxLaSByvll8H7MwS
        FFiX4O/DVszx+XnSgwh1iWIPEQ==
X-Google-Smtp-Source: ACHHUZ7o+RBEAbiPHAxuoL8dXfckLdszx41+o6T6toUCBCwkx5RKwC0roj436Q6sHQusz673YDwRsg==
X-Received: by 2002:a17:902:cece:b0:1aa:e451:e22 with SMTP id d14-20020a170902cece00b001aae4510e22mr1548160plg.40.1682798846720;
        Sat, 29 Apr 2023 13:07:26 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902748b00b001a641e4738asm15212684pll.1.2023.04.29.13.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:07:26 -0700 (PDT)
Date:   Sat, 29 Apr 2023 13:07:26 -0700 (PDT)
X-Google-Original-Date: Sat, 29 Apr 2023 13:06:11 PDT (-0700)
Subject:     Re: [PATCH 2/3] RISC-V: Track ISA extensions per hart
In-Reply-To: <20230428190609.3239486-3-evan@rivosinc.com>
CC:     Evan Green <evan@rivosinc.com>, aou@eecs.berkeley.edu,
        ajones@ventanamicro.com, Conor Dooley <conor.dooley@microchip.com>,
        heiko.stuebner@vrull.eu, jszhang@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Evan Green <evan@rivosinc.com>
Message-ID: <mhng-a49186a7-69f7-4f8a-ba14-62277c0f7f59@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 12:06:07 PDT (-0700), Evan Green wrote:
> The kernel maintains a mask of ISA extensions ANDed together across all
> harts. Let's also keep a bitmap of ISA extensions for each CPU. Although
> the kernel is currently unlikely to enable a feature that exists only on
> some CPUs, we want the ability to report asymmetric CPU extensions
> accurately to usermode.
>
> Note that riscv_fill_hwcaps() runs before the per_cpu_offsets are built,
> which is why I've used a [NR_CPUS] array rather than per_cpu() data.
>
> Signed-off-by: Evan Green <evan@rivosinc.com>
> ---
>
>  arch/riscv/include/asm/cpufeature.h | 10 ++++++++++
>  arch/riscv/kernel/cpufeature.c      | 18 ++++++++++++------
>  2 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> index 808d5403f2ac..23fed53b8815 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -6,6 +6,9 @@
>  #ifndef _ASM_CPUFEATURE_H
>  #define _ASM_CPUFEATURE_H
>
> +#include <linux/bitmap.h>
> +#include <asm/hwcap.h>
> +
>  /*
>   * These are probed via a device_initcall(), via either the SBI or directly
>   * from the corresponding CSRs.
> @@ -16,8 +19,15 @@ struct riscv_cpuinfo {
>  	unsigned long mimpid;
>  };
>
> +struct riscv_isainfo {
> +	DECLARE_BITMAP(isa, RISCV_ISA_EXT_MAX);
> +};
> +
>  DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
>
>  DECLARE_PER_CPU(long, misaligned_access_speed);
>
> +/* Per-cpu ISA extensions. */
> +extern struct riscv_isainfo hart_isa[NR_CPUS];
> +
>  #endif
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 1a80474e308e..0e9d66580478 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -14,6 +14,7 @@
>  #include <linux/of.h>
>  #include <asm/alternative.h>
>  #include <asm/cacheflush.h>
> +#include <asm/cpufeature.h>
>  #include <asm/hwcap.h>
>  #include <asm/patch.h>
>  #include <asm/processor.h>
> @@ -25,6 +26,9 @@ unsigned long elf_hwcap __read_mostly;
>  /* Host ISA bitmap */
>  static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
>
> +/* Per-cpu ISA extensions. */
> +struct riscv_isainfo hart_isa[NR_CPUS];
> +
>  /* Performance information */
>  DEFINE_PER_CPU(long, misaligned_access_speed);
>
> @@ -112,14 +116,17 @@ void __init riscv_fill_hwcap(void)
>  	bitmap_zero(riscv_isa, RISCV_ISA_EXT_MAX);
>
>  	for_each_of_cpu_node(node) {
> +		struct riscv_isainfo *isainfo;
>  		unsigned long this_hwcap = 0;
> -		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
>  		const char *temp;
> +		unsigned int cpu_id;
>
>  		rc = riscv_of_processor_hartid(node, &hartid);
>  		if (rc < 0)
>  			continue;
>
> +		cpu_id = riscv_hartid_to_cpuid(hartid);
> +		isainfo = &hart_isa[cpu_id];
>  		if (of_property_read_string(node, "riscv,isa", &isa)) {
>  			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
>  			continue;
> @@ -136,7 +143,6 @@ void __init riscv_fill_hwcap(void)
>  		/* The riscv,isa DT property must start with rv64 or rv32 */
>  		if (temp == isa)
>  			continue;
> -		bitmap_zero(this_isa, RISCV_ISA_EXT_MAX);
>  		for (; *isa; ++isa) {
>  			const char *ext = isa++;
>  			const char *ext_end = isa;
> @@ -214,7 +220,7 @@ void __init riscv_fill_hwcap(void)
>  				if ((ext_end - ext == sizeof(name) - 1) &&	\
>  				     !memcmp(ext, name, sizeof(name) - 1) &&	\
>  				     riscv_isa_extension_check(bit))		\
> -					set_bit(bit, this_isa);			\
> +					set_bit(bit, isainfo->isa);		\
>  			} while (false)						\
>
>  			if (unlikely(ext_err))
> @@ -224,7 +230,7 @@ void __init riscv_fill_hwcap(void)
>
>  				if (riscv_isa_extension_check(nr)) {
>  					this_hwcap |= isa2hwcap[nr];
> -					set_bit(nr, this_isa);
> +					set_bit(nr, isainfo->isa);
>  				}
>  			} else {
>  				/* sorted alphabetically */
> @@ -253,9 +259,9 @@ void __init riscv_fill_hwcap(void)
>  			elf_hwcap = this_hwcap;
>
>  		if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
> -			bitmap_copy(riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
> +			bitmap_copy(riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
>  		else
> -			bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
> +			bitmap_and(riscv_isa, riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
>  	}
>
>  	/* We don't support systems with F but without D, so mask those out

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
