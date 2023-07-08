Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5318D74BEFB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 21:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGHTeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 15:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjGHTen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 15:34:43 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110D11B3
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 12:34:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-314417861b9so3282961f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 12:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688844880; x=1691436880;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ldWBxd74R+pglDeJnUmYlGVsD0i0ZZKfyJtHQNTwXzQ=;
        b=sVjmI/+niehvvGhOr0OrzfmxAJGLr0PGa4XQdAo4op/FETPRrGMxoZSaobvT09ZgaD
         0tho5PCSpJUGIiKH799QaoHux4jIrEQqcd/dP3MoO6gvaXHC9ZHflkHGPHLbuQzKoni3
         M3cCmN+sSLBawVQF40rlDO6g2S9gVB33bml1xJRO/cHKfZBZpXc2QBo9jc/+wMHi/Sxg
         Pnq+K6f7cOq34xsgU+pkmpIa1eMo436sexFTVwxvsxd8kOr7qPpaSvJ/h5iLPIWLxFu3
         thp1Hqcu4dzrZsQRBkQ16It2ygPTd3wi0iiPvUws3yxx8ELFznGB/PM46DU5OKXi0xxh
         3GYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688844880; x=1691436880;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldWBxd74R+pglDeJnUmYlGVsD0i0ZZKfyJtHQNTwXzQ=;
        b=CzmDpwoS4Kw5aCauewEpyecSxUWeKEH8vt8vfttDlnTzIriSc8h5SNZ7WbhaThVWoN
         17u7XUOniVtpJavNmWY7MGziXblopv24txDaRdlnpUeNo1OkY6fVb/VeQs5mbj0oLoVx
         yNQHpGSEqEfI6YQ61bGuZJXl1Kw7M83E2QJaN9lnTb/ZwOEKYxuP6TUXI8YBq3y4/2tt
         IiQ8gTc2J+whidD+aTq69nwbKwEy4JMuw/0vdFQqMOWaOR3XbPbcG4hnN+YszdQD3ahY
         UK6bNgk93CpGSsEYdE/ZkeSj9Cn/A0Q+PvmQ7bx6GRX03SjnjU4WBK14NH91NMrdMY8I
         Ncbg==
X-Gm-Message-State: ABy/qLahhC9o1Bw3/4WCWuTYvlpnvnRHNpD7/p8Ckd00p+Rrchq8m5D9
        zUCb3DfutdadQsCYiPUNvM0=
X-Google-Smtp-Source: APBJJlGNcDSORY8447lyep+MwzIZdPiYkFWo0VoxirWIRMBbFz2WsbB3+sDDxjNWo7cuDUhuN0uydQ==
X-Received: by 2002:a5d:484d:0:b0:314:15b7:20a5 with SMTP id n13-20020a5d484d000000b0031415b720a5mr7268292wrs.54.1688844880170;
        Sat, 08 Jul 2023 12:34:40 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id q17-20020a05600000d100b003142eb75724sm7556052wrx.24.2023.07.08.12.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 12:34:39 -0700 (PDT)
Date:   Sat, 8 Jul 2023 20:34:38 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 PATCH 2/9] riscv: avoid missing prototypes warning
Message-ID: <ZKm6TqqdEWKvwnQM@antec>
References: <20230704140924.315594-1-cleger@rivosinc.com>
 <20230704140924.315594-3-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230704140924.315594-3-cleger@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 04:09:17PM +0200, Clément Léger wrote:
> Declare handle_misaligned_store/load() functions in entry-common.h and
> include that file in traps_misaligned.c file to avoid warnings.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/entry-common.h | 3 +++
>  arch/riscv/kernel/traps.c             | 2 --
>  arch/riscv/kernel/traps_misaligned.c  | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
> index 6e4dee49d84b..58e9e2976e1b 100644
> --- a/arch/riscv/include/asm/entry-common.h
> +++ b/arch/riscv/include/asm/entry-common.h
> @@ -8,4 +8,7 @@
>  void handle_page_fault(struct pt_regs *regs);
>  void handle_break(struct pt_regs *regs);
>  
> +int handle_misaligned_load(struct pt_regs *regs);
> +int handle_misaligned_store(struct pt_regs *regs);
> +

Would this work when CONFIG_RISCV_M_MODE is disabled?

The handle_misaligned_load/store functions are only defined if
CONFIG_RISCV_M_MODE is enabled.  I would expect warnings if CONFIG_RISCV_M_MODE
is siabled.

-Stafford

>  #endif /* _ASM_RISCV_ENTRY_COMMON_H */
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 8c258b78c925..7fcaf2fd27a1 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -155,8 +155,6 @@ DO_ERROR_INFO(do_trap_load_misaligned,
>  DO_ERROR_INFO(do_trap_store_misaligned,
>  	SIGBUS, BUS_ADRALN, "Oops - store (or AMO) address misaligned");
>  #else
> -int handle_misaligned_load(struct pt_regs *regs);
> -int handle_misaligned_store(struct pt_regs *regs);
>  
>  asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
>  {
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index e7bfb33089c1..0cccac4822a8 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -12,6 +12,7 @@
>  #include <asm/processor.h>
>  #include <asm/ptrace.h>
>  #include <asm/csr.h>
> +#include <asm/entry-common.h>
>  
>  #define INSN_MATCH_LB			0x3
>  #define INSN_MASK_LB			0x707f
> -- 
> 2.40.1
> 
