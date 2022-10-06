Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD625F6782
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiJFNPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJFNPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:15:38 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E761AA2AB8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 06:15:30 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x59so2751417ede.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 06:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=C3zWAQBpIW3PZpVPpSUfTCDFk3CK+4WyR74h9CUwMsU=;
        b=iVHfFo/CpB5OBIq7+p0elW88jDoyuYwnUOlw9lTnQeOzsrEekcZUKb/HReEyyXqZBR
         dH6Y1Mo/uW2N59NDcduWBLfNRaMWsCJ2ztIqE/Iz6k7AMTthdZSRrO3fLmFaua7yP2y/
         4YjOIp+5dXNyqrmQK3jOKJdwKmLG2Fjy3P6qcrpZUxhnt36TFoxUP8e5e0HTiJyOUfb2
         DzrwmmR+VvZl4ljtXh1GrKLdvR4DiBK9u1uIu+Y9npDO5A+OcwC4mpnb0+z3iuGerp/U
         6C46WWnxSSgAY5zv/dbOKs9yVh6qG33IgofTMt/wD1l3nZrFuOKteZSc8cqhy5UuD89m
         lA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=C3zWAQBpIW3PZpVPpSUfTCDFk3CK+4WyR74h9CUwMsU=;
        b=VlFKKeldDXwF4hEYfujLh8371lAF4HcGD27zJUaXO7DgO2L3xHTJT6/77Tyu0CkEaY
         tnyCG3gg7yDhbANIiyPNeyd+H9HlnI4JHOj7k06O3r7MbG/9ytKqAtK97fqiSqtDtBJr
         vtbg+vU6fu8P5HerTQkYZ/tQl8bRgKoCiW7h22F726YXvNbs1NfETBMmIJ3nU8OoL4z1
         ibz9BKfabfFi3GBSOFkjII4LvL7W38G6zOzMXaLJxRRtkEENKitwJ1L67VdMG5nWP1pi
         lW90tzqpnL1yfEciExPZ+q5309ux7eXHTyZEyhZGbrx/HfjaLeC1OwutBwsggi1p0BY9
         Fo6Q==
X-Gm-Message-State: ACrzQf2bh5QIryc49r+36YlbxLzTHJT2ujm8AX7VEq2R75QC5T4VJAUk
        aUaxyungERAqmt65GSnHh3Wo1w==
X-Google-Smtp-Source: AMsMyM4gHbe3CFDT3BxF1JnwGIhtjpYQNTFT0EOibrKWzjA30a45VV2/808gOMB7w74H64u3Tyq5bw==
X-Received: by 2002:a05:6402:2926:b0:459:675b:38a9 with SMTP id ee38-20020a056402292600b00459675b38a9mr4632411edb.60.1665062129421;
        Thu, 06 Oct 2022 06:15:29 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id i26-20020a50fc1a000000b00458e73fe1c1sm5802996edr.8.2022.10.06.06.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:15:29 -0700 (PDT)
Date:   Thu, 6 Oct 2022 15:15:28 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] riscv: hwcap: make ISA extension ids can be used in
 asm
Message-ID: <20221006131528.ovcvgnp4tdkfcnb7@kamzik>
References: <20221006070818.3616-1-jszhang@kernel.org>
 <20221006070818.3616-4-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006070818.3616-4-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 03:08:13PM +0800, Jisheng Zhang wrote:
> We will make use of ISA extension in asm files, so make the multi-letter
> RISC-V ISA extension IDs macros rather than enums and move them and
> those base ISA extension IDs to suitable place.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/hwcap.h | 45 +++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 6f59ec64175e..6cf445653911 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -12,20 +12,6 @@
>  #include <linux/bits.h>
>  #include <uapi/asm/hwcap.h>
>  
> -#ifndef __ASSEMBLY__
> -#include <linux/jump_label.h>
> -/*
> - * This yields a mask that user programs can use to figure out what
> - * instruction set this cpu supports.
> - */
> -#define ELF_HWCAP		(elf_hwcap)
> -
> -enum {
> -	CAP_HWCAP = 1,
> -};
> -
> -extern unsigned long elf_hwcap;
> -
>  #define RISCV_ISA_EXT_a		('a' - 'a')
>  #define RISCV_ISA_EXT_c		('c' - 'a')
>  #define RISCV_ISA_EXT_d		('d' - 'a')
> @@ -46,21 +32,36 @@ extern unsigned long elf_hwcap;
>  #define RISCV_ISA_EXT_BASE 26
>  
>  /*
> - * This enum represent the logical ID for each multi-letter RISC-V ISA extension.
> + * These macros represent the logical ID for each multi-letter RISC-V ISA extension.
>   * The logical ID should start from RISCV_ISA_EXT_BASE and must not exceed
>   * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
>   * extensions while all the multi-letter extensions should define the next
>   * available logical extension id.
>   */
> -enum riscv_isa_ext_id {
> -	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
> -	RISCV_ISA_EXT_SVPBMT,
> -	RISCV_ISA_EXT_ZICBOM,
> -	RISCV_ISA_EXT_ZIHINTPAUSE,
> -	RISCV_ISA_EXT_SSTC,
> -	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
> +#define RISCV_ISA_EXT_SSCOFPMF 		26
> +#define RISCV_ISA_EXT_SVPBMT		27
> +#define RISCV_ISA_EXT_ZICBOM		28
> +#define RISCV_ISA_EXT_ZIHINTPAUSE	29
> +#define RISCV_ISA_EXT_SSTC		30
> +
> +#define RISCV_ISA_EXT_ID_MAX		RISCV_ISA_EXT_MAX

afaict, RISCV_ISA_EXT_ID_MAX is ununsed and can be removed.

> +
> +
> +#ifndef __ASSEMBLY__
> +#include <linux/jump_label.h>
> +/*
> + * This yields a mask that user programs can use to figure out what
> + * instruction set this cpu supports.
> + */
> +#define ELF_HWCAP		(elf_hwcap)
> +
> +enum {
> +	CAP_HWCAP = 1,
>  };
>  
> +extern unsigned long elf_hwcap;
> +
> +
>  /*
>   * This enum represents the logical ID for each RISC-V ISA extension static
>   * keys. We can use static key to optimize code path if some ISA extensions
> -- 
> 2.37.2
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
