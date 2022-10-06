Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B705F6846
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiJFNg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiJFNg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:36:26 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9643A99DE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 06:36:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y100so2850703ede.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 06:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=0UfzhzFU90rUX1Zui/jkz3o75f5mI9Z9O0OKWUMBplQ=;
        b=kLFfxeludzLzIaDOjssv83UlUa6NwmAXruQHUbh2cWE3MCcDBNocLfnlW04y0Uc334
         EwOsQciNnARNDGu25LPXuTA7liiU9/SLLrg7I+r1nKHdcyyX8hU21KbRMY3kFfiPUPnJ
         xTSQW/ry8qRSkPlZV3aGQ2cuKb6oSc1rorG2VLmIdIRfsaIxZjQBHgifXfosK1OLA3Qv
         SIQuyrx8qTTLNJtAzRSLCfrpDrG+3xOD4ghayD3mdf6UFOpkEjX+0WvhjBivc6X+zVAt
         JlweQb05TLiKGZM+THm0ZmdJvcGSbgMryHJX2LHf4p46utaGAc8WhnmSKJDIjKzGhFhI
         rjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0UfzhzFU90rUX1Zui/jkz3o75f5mI9Z9O0OKWUMBplQ=;
        b=n1QyaRwN5aFV4Hh4NwP10rVTPZ7KfdlWMvNevoOPuoHGxb2e+utUSB6HRwjjYIQ3KK
         SvvQxRDZG8sntbN4NRPgsxgf3QdjaIULZ5pUtkUosVn5lIbu2AjQd4MT0jja7+xBahG7
         2kFT4mrA1gyzT3hGKyk6WdngrpR6SbDBdUHvuvmJT3WZghTzhA7VRP5hgm9RnWggSBRV
         W+qk5ggcAolZdnwVeIvSApAAIKNo0b2FnfJgJy69nXizT/K5q6WKWGW7bmUSsBB2qmUk
         IOsiSSC2k6p1xbIsIbw9+vic1LECKLfqLLzzP6qktoyMU04O2uLVadrsC/JzEollYTEj
         dmmQ==
X-Gm-Message-State: ACrzQf2JgxMqIcn+eCwmitE5SXv2IGVZlcjjP0TBTTrYhpHeHZkcIAEb
        ahYLXUPanUAxq5qXc2a8YIAIoQ==
X-Google-Smtp-Source: AMsMyM6+xhVtakhKWGU9SGpwhFNpt47nCQGSZGLsdYYQsMxXm0m3+WMbSh3KS1KsDrtAiU81a23ijQ==
X-Received: by 2002:aa7:c314:0:b0:458:dc90:467a with SMTP id l20-20020aa7c314000000b00458dc90467amr4598176edq.284.1665063383412;
        Thu, 06 Oct 2022 06:36:23 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id g23-20020a056402181700b004591e6f7f47sm5838159edy.42.2022.10.06.06.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:36:23 -0700 (PDT)
Date:   Thu, 6 Oct 2022 15:36:22 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] riscv: introduce riscv_has_extension_[un]likely()
Message-ID: <20221006133622.xnruzidkrphgxa7d@kamzik>
References: <20221006070818.3616-1-jszhang@kernel.org>
 <20221006070818.3616-6-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006070818.3616-6-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 03:08:15PM +0800, Jisheng Zhang wrote:
> Generally, riscv ISA extensions are fixed for any specific hardware
> platform, that's to say, the hart features won't change any more
> after booting, this chacteristic make it straightforward to use
> static branch to check one specific ISA extension is supported or not
> to optimize performance.
> 
> However, some ISA extensions such as SVPBMT and ZICBOM are handled
> via. the alternative sequences.
> 
> Basically, for ease of maintenance, we prefer to use static branches
> in C code, but recently, Samuel found that the static branch usage in
> cpu_relax() breaks building with CONFIG_CC_OPTIMIZE_FOR_SIZE[1]. As
> Samuel pointed out, "Having a static branch in cpu_relax() is
> problematic because that function is widely inlined, including in some
> quite complex functions like in the VDSO. A quick measurement shows
> this static branch is responsible by itself for around 40% of the jump
> table."
> 
> Samuel's findings pointed out one of a few downsides of static branches
> usage in C code to handle ISA extensions detected at boot time:
> static branch's metadata in the __jump_table section, which is not
> discarded after ISA extensions are finalized, wastes some space.
> 
> I want to try to solve the issue for all possible dynamic handling of
> ISA extensions at boot time. Inspired by Mark[2], this patch introduces
> riscv_has_extension_*() helpers, which work like static branches but
> are patched using alternatives, thus the metadata can be freed after
> patching.
> 
> [1]https://lore.kernel.org/linux-riscv/20220922060958.44203-1-samuel@sholland.org/
> [2]https://lore.kernel.org/linux-arm-kernel/20220912162210.3626215-8-mark.rutland@arm.com/
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/hwcap.h | 37 ++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 6cf445653911..54b88ee6cae1 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -8,6 +8,7 @@
>  #ifndef _ASM_RISCV_HWCAP_H
>  #define _ASM_RISCV_HWCAP_H
>  
> +#include <asm/alternative-macros.h>
>  #include <asm/errno.h>
>  #include <linux/bits.h>
>  #include <uapi/asm/hwcap.h>
> @@ -96,6 +97,42 @@ static __always_inline int riscv_isa_ext2key(int num)
>  	}
>  }
>  
> +static __always_inline bool
> +riscv_has_extension_likely(const unsigned long ext)
> +{
> +	compiletime_assert(ext < RISCV_ISA_EXT_ID_MAX,
> +			   "ext must be < RISCV_ISA_EXT_ID_MAX");
> +
> +	asm_volatile_goto(
> +	ALTERNATIVE("j	%l[l_no]", "nop", 0, %[ext], 1)
> +	:
> +	: [ext] "i" (ext)
> +	:
> +	: l_no);
> +
> +	return true;
> +l_no:
> +	return false;
> +}
> +
> +static __always_inline bool
> +riscv_has_extension_unlikely(const unsigned long ext)
> +{
> +	compiletime_assert(ext < RISCV_ISA_EXT_ID_MAX,
> +			   "ext must be < RISCV_ISA_EXT_ID_MAX");
> +
> +	asm_volatile_goto(
> +	ALTERNATIVE("nop", "j	%l[l_yes]", 0, %[ext], 1)
> +	:
> +	: [ext] "i" (ext)
> +	:
> +	: l_yes);
> +
> +	return false;
> +l_yes:
> +	return true;
> +}
> +
>  unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
>  
>  #define riscv_isa_extension_mask(ext) BIT_MASK(RISCV_ISA_EXT_##ext)
> -- 
> 2.37.2
>

Cheers to Mark for this nifty idea and to you for bringing it to riscv.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
