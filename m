Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B186666258
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjAKR4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjAKR4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:56:19 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2312513F6D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:56:18 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bs20so15873295wrb.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iATtwX45ufevzGDCQk6FprOJLywVs059/Zoh+UqczYk=;
        b=oHmNoS5cGMmc4TMWWpwfbgeQ0tDKdN4IhHoVwR8mNEI0Apy9bv+5hVi4JYXKYlzaoN
         UWkNzMkI8H/sPR1qDuxOUdv2Na+csxtsLqVWd62z8U6urrXwYkcGbwGjf/7hCW4AKFQm
         EaT0pHS+rJ7NtVH9/wC8elXCHT0D5AHVPufa2gQhUXePqahPkaX+JqSuqs1qnftV5BLg
         f3zkMVLgVNvaDCh61ZnLDK6QugohhnwOPYWE6IxKQaW5LwmwY7hRNmhhiD7SAb5lVY9Q
         FJ6/K6MhV/8l1/scnfsGPmFMIfOG183LDroX+o01Bp9nC+4T090vIPN33+X23vZHo8Hr
         dsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iATtwX45ufevzGDCQk6FprOJLywVs059/Zoh+UqczYk=;
        b=Wf8JO9FKsvzYEEuSYEogrkE1+1uGCLSafyIY2qXQWEUeM1Yr3a3/iQFGpByHNM+BoR
         hIOBXuiu/HNOsCa2K9TmLz9IJUemHaC0OLolNz5cYssH6r0g3Wp0+5Ms+Dy9zUrtNSky
         oMd+GNVX8+GVUjcz2/7ZinC/qtLnGFRBAMupSCYA1BlEWVZp3bLcSdgQ1zuoLuVP0o8p
         hjFWvVZpCPPZtwrT3UkhLamA6WIAEvyjV84Zcre8FCXL5zbmgbz7V+Fihz2gxEzFW/P4
         K3hZE/33TwIn8mKglRyPTQz8vQ5Df2/4ZZbUXr/i9NCofsjHW5DR2AXz6+GclJFe5QrW
         b/Ng==
X-Gm-Message-State: AFqh2koLR1VTC0Svkweu8pVvcap8UvLyYknE+4xpRRgLIHPjJiy0R6h+
        oXx+rdI+dWJgqJEADtRvN2rkWA==
X-Google-Smtp-Source: AMrXdXtF/CJ1z+mSVHqSfXPznFXga6/+3peruKnsc6Yyigv0V5rinWx4z34Y3uC7wHeAaIrU2EeLyA==
X-Received: by 2002:a5d:5592:0:b0:2a2:4313:e880 with SMTP id i18-20020a5d5592000000b002a24313e880mr15167085wrv.61.1673459776750;
        Wed, 11 Jan 2023 09:56:16 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b00241fde8fe04sm14243618wrr.7.2023.01.11.09.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 09:56:16 -0800 (PST)
Date:   Wed, 11 Jan 2023 18:56:15 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v3 01/13] riscv: fix jal offsets in patched alternatives
Message-ID: <20230111175615.p7vpq6joyrzomcmz@orel>
References: <20230111171027.2392-1-jszhang@kernel.org>
 <20230111171027.2392-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111171027.2392-2-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 01:10:15AM +0800, Jisheng Zhang wrote:
> Alternatives live in a different section, so offsets used by jal
> instruction will point to wrong locations after the patch got applied.
> 
> Similar to arm64, adjust the location to consider that offset.
> 
> Co-developed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/insn.h   | 27 +++++++++++++++++++++++++++
>  arch/riscv/kernel/alternative.c | 27 +++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
> index 98453535324a..1d2df245d0bd 100644
> --- a/arch/riscv/include/asm/insn.h
> +++ b/arch/riscv/include/asm/insn.h
> @@ -291,6 +291,33 @@ static __always_inline bool riscv_insn_is_branch(u32 code)
>  	(RVC_X(x_, RVC_B_IMM_7_6_OPOFF, RVC_B_IMM_7_6_MASK) << RVC_B_IMM_7_6_OFF) | \
>  	(RVC_IMM_SIGN(x_) << RVC_B_IMM_SIGN_OFF); })
>  
> +/*
> + * Get the immediate from a J-type instruction.
> + *
> + * @insn: instruction to process
> + * Return: immediate
> + */
> +static inline s32 riscv_insn_extract_jtype_imm(u32 insn)
> +{
> +	return RV_EXTRACT_JTYPE_IMM(insn);
> +}
> +
> +/*
> + * Update a J-type instruction with an immediate value.
> + *
> + * @insn: pointer to the jtype instruction
> + * @imm: the immediate to insert into the instruction
> + */
> +static inline void riscv_insn_insert_jtype_imm(u32 *insn, s32 imm)
> +{
> +	/* drop the old IMMs, all jal IMM bits sit at 31:12 */
> +	*insn &= ~GENMASK(31, 12);
> +	*insn |= (RV_X(imm, RV_J_IMM_10_1_OFF, RV_J_IMM_10_1_MASK) << RV_J_IMM_10_1_OPOFF) |
> +		 (RV_X(imm, RV_J_IMM_11_OFF, RV_J_IMM_11_MASK) << RV_J_IMM_11_OPOFF) |
> +		 (RV_X(imm, RV_J_IMM_19_12_OFF, RV_J_IMM_19_12_MASK) << RV_J_IMM_19_12_OPOFF) |
> +		 (RV_X(imm, RV_J_IMM_SIGN_OFF, 1) << RV_J_IMM_SIGN_OPOFF);
> +}
> +
>  /*
>   * Put together one immediate from a U-type and I-type instruction pair.
>   *
> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
> index 6212ea0eed72..3d4f1f32c7f6 100644
> --- a/arch/riscv/kernel/alternative.c
> +++ b/arch/riscv/kernel/alternative.c
> @@ -79,6 +79,21 @@ static void riscv_alternative_fix_auipc_jalr(void *ptr, u32 auipc_insn,
>  	patch_text_nosync(ptr, call, sizeof(u32) * 2);
>  }
>  
> +static void riscv_alternative_fix_jal(void *ptr, u32 jal_insn, int patch_offset)
> +{
> +	s32 imm;
> +
> +	/* get and adjust new target address */
> +	imm = riscv_insn_extract_jtype_imm(jal_insn);
> +	imm -= patch_offset;
> +
> +	/* update instruction */
> +	riscv_insn_insert_jtype_imm(&jal_insn, imm);
> +
> +	/* patch the call place again */
> +	patch_text_nosync(ptr, &jal_insn, sizeof(u32));
> +}
> +
>  void riscv_alternative_fix_offsets(void *alt_ptr, unsigned int len,
>  				      int patch_offset)
>  {
> @@ -106,6 +121,18 @@ void riscv_alternative_fix_offsets(void *alt_ptr, unsigned int len,
>  			riscv_alternative_fix_auipc_jalr(alt_ptr + i * sizeof(u32),
>  							 insn, insn2, patch_offset);
>  		}
> +
> +		if (riscv_insn_is_jal(insn)) {
> +			s32 imm = riscv_insn_extract_jtype_imm(insn);
> +
> +			/* Don't modify jumps inside the alternative block */
> +			if ((alt_ptr + i * sizeof(u32) + imm) >= alt_ptr &&
> +			    (alt_ptr + i * sizeof(u32) + imm) < (alt_ptr + len))
> +				continue;
> +
> +			riscv_alternative_fix_jal(alt_ptr + i * sizeof(u32),
> +						  insn, patch_offset);
> +		}
>  	}
>  }
>  
> -- 
> 2.38.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
