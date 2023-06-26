Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A09773E3AF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjFZPmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjFZPmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:42:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6D0171A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:42:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-98e011f45ffso196276066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687794122; x=1690386122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o0J3WzAumgsESsQYSbAE6p/4apA5eVqKQr0TEvu7X0M=;
        b=ccPYNDPxuN4itvJ/sstWTQF1vUnzi3vdsgbCTGT0etYYQC3IxrGmszqckoyHZrXrLf
         WK4zVxe2gSGZwnDdvSp5oBhE1Fqdo63EQOqVOAwhFevfeCuNmSrHmSKWyDznupHGNi9w
         mY47R+zmd4pSu3Y2D8PvkqFDdUwHRRhmlA+b0zn3NAouDvEX1HPosXpHWQLKTcc9vWCp
         xmuqvDPH2jrWSHTUefSIpDl/VGvULPYj5aH7BuIxKilVhRwJfpamAQY7xnd14yLIzote
         o3r0Plh3gpIeMLEQMg7nFqVCFH2LY0lSZgPjlHlmz5+QNjSzsacVZTU91nciPBTanW6g
         4wvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687794122; x=1690386122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0J3WzAumgsESsQYSbAE6p/4apA5eVqKQr0TEvu7X0M=;
        b=S2EuiJzHyRB5rOjIPdM4dMQ7pA4hlzrlKE8r/xTaMRs24qE87oaky1Op0jIvKgZyRj
         ZIDEXxVWh3+rUQE81xIL7ZZMmzf7JKoxK/EusQGV93bPuqB1+S5GTlSaRkEGMXHO/MOa
         7TG4eTK+dPhN025HyVxRve1ICnoPht646XPHtq2TBULeT24TbNEJ6N9+sMLU9oV1SfMG
         KGF7L94mPqAC9rJxoODiTQNvl/QCgu3STdDfpulzPreX0Kk0LAoMuBQ8F/j+M13iTqJN
         1s0ch9OtLjFXA2u+MalI/Gy78Vg76mfYUO+oIkqZyFlmCV0C4wxcSqTNFh1nfN/LsUAu
         ubDA==
X-Gm-Message-State: AC+VfDw2JXTUx+O+Qr83V6P6+E31vxYJp8W6Mj+HAV899HS0zX1FnY0X
        Hqt7rD4i7/qoYQQdgz5l97Hw0w==
X-Google-Smtp-Source: ACHHUZ7cmwNmI2gsxQy6oaJVljhIRGzuFJOdvSmaBsxuRrlSIzHvnwJjLiFyC0NAJ5E7aAZ1rZb6fQ==
X-Received: by 2002:a17:907:74b:b0:971:484:6391 with SMTP id xc11-20020a170907074b00b0097104846391mr19752447ejb.20.1687794121978;
        Mon, 26 Jun 2023 08:42:01 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id bu2-20020a170906a14200b009829dc0f2a0sm3395698ejb.111.2023.06.26.08.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:42:01 -0700 (PDT)
Date:   Mon, 26 Jun 2023 17:42:00 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     palmer@dabbelt.com, conor@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 6/9] RISC-V: add single letter extensions to
 riscv_isa_ext
Message-ID: <20230626-c8eeb863272f9379cb01ef97@orel>
References: <20230626-provable-angrily-81760e8c3cc6@wendy>
 <20230626-sensuous-clothing-124f7ae0aedf@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626-sensuous-clothing-124f7ae0aedf@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 12:19:44PM +0100, Conor Dooley wrote:
> So that riscv_fill_hwcap() can use riscv_isa_ext to probe for single
> letter extensions, add them to it. riscv_isa_ext_data grows a new
> member, signifying whether an extension is multi-letter & thus requiring
> special handling.
> As a result, what gets spat out in /proc/cpuinfo will become borked, as
> single letter extensions will be printed as part of the base extensions
> and while printing from riscv_isa_arr. Take the opportunity to unify the
> printing of the isa string, using the new member of riscv_isa_ext_data
> in the process.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/include/asm/hwcap.h |  1 +
>  arch/riscv/kernel/cpu.c        | 36 ++++++----------------
>  arch/riscv/kernel/cpufeature.c | 56 +++++++++++++++++++++-------------
>  3 files changed, 46 insertions(+), 47 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index a35bee219dd7..6ad896dc4342 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -77,6 +77,7 @@ unsigned long riscv_get_elf_hwcap(void);
>  struct riscv_isa_ext_data {
>  	const unsigned int id;
>  	const char *name;
> +	const bool multi_letter;
>  };
>  
>  extern const struct riscv_isa_ext_data riscv_isa_ext[];
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index beb8b16bbf87..046d9d3dac16 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -160,41 +160,25 @@ arch_initcall(riscv_cpuinfo_init);
>  
>  #ifdef CONFIG_PROC_FS
>  
> -static void print_isa_ext(struct seq_file *f)
> -{
> -	for (int i = 0; i < riscv_isa_ext_count; i++) {
> -		const struct riscv_isa_ext_data *edata = &riscv_isa_ext[i];
> -		if (!__riscv_isa_extension_available(NULL, edata->id))
> -			continue;
> -
> -		seq_printf(f, "_%s", edata->name);
> -	}
> -}
> -
> -/*
> - * These are the only valid base (single letter) ISA extensions as per the spec.
> - * It also specifies the canonical order in which it appears in the spec.
> - * Some of the extension may just be a place holder for now (B, K, P, J).
> - * This should be updated once corresponding extensions are ratified.
> - */
> -static const char base_riscv_exts[13] = "imafdqcbkjpvh";
> -
>  static void print_isa(struct seq_file *f)
>  {
> -	int i;
> -
>  	seq_puts(f, "isa\t\t: ");
> +
>  	if (IS_ENABLED(CONFIG_32BIT))
>  		seq_write(f, "rv32", 4);
>  	else
>  		seq_write(f, "rv64", 4);
>  
> -	for (i = 0; i < sizeof(base_riscv_exts); i++) {
> -		if (__riscv_isa_extension_available(NULL, base_riscv_exts[i] - 'a'))
> -			/* Print only enabled the base ISA extensions */
> -			seq_write(f, &base_riscv_exts[i], 1);
> +	for (int i = 0; i < riscv_isa_ext_count; i++) {
> +		if (!__riscv_isa_extension_available(NULL, riscv_isa_ext[i].id))
> +			continue;
> +
> +		if (riscv_isa_ext[i].multi_letter)
> +			seq_puts(f, "_");
> +
> +		seq_printf(f, "%s", riscv_isa_ext[i].name);
>  	}
> -	print_isa_ext(f);
> +
>  	seq_puts(f, "\n");
>  }
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index b5e23506c4f0..5405d8a58537 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -99,9 +99,10 @@ static bool riscv_isa_extension_check(int id)
>  	return true;
>  }
>  
> -#define __RISCV_ISA_EXT_DATA(_name, _id) {	\
> -	.name = #_name,				\
> -	.id = _id,				\
> +#define __RISCV_ISA_EXT_DATA(_name, _id, _multi) {	\
> +	.name = #_name,					\
> +	.id = _id,					\
> +	.multi_letter = _multi,				\
>  }
>  
>  /*
> @@ -144,24 +145,37 @@ static bool riscv_isa_extension_check(int id)
>   * New entries to this struct should follow the ordering rules described above.
>   */
>  const struct riscv_isa_ext_data riscv_isa_ext[] = {
> -	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> -	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
> -	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
> -	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
> -	__RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI),
> -	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> -	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
> -	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
> -	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> -	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
> -	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
> -	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
> -	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> -	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
> -	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> -	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
> -	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> -	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
> +	__RISCV_ISA_EXT_DATA(i, RISCV_ISA_EXT_i, false),
> +	__RISCV_ISA_EXT_DATA(m, RISCV_ISA_EXT_m, false),
> +	__RISCV_ISA_EXT_DATA(a, RISCV_ISA_EXT_a, false),
> +	__RISCV_ISA_EXT_DATA(f, RISCV_ISA_EXT_f, false),
> +	__RISCV_ISA_EXT_DATA(d, RISCV_ISA_EXT_d, false),
> +	__RISCV_ISA_EXT_DATA(q, RISCV_ISA_EXT_q, false),
> +	__RISCV_ISA_EXT_DATA(c, RISCV_ISA_EXT_c, false),
> +	__RISCV_ISA_EXT_DATA(b, RISCV_ISA_EXT_b, false),
> +	__RISCV_ISA_EXT_DATA(k, RISCV_ISA_EXT_k, false),
> +	__RISCV_ISA_EXT_DATA(j, RISCV_ISA_EXT_j, false),
> +	__RISCV_ISA_EXT_DATA(p, RISCV_ISA_EXT_p, false),
> +	__RISCV_ISA_EXT_DATA(v, RISCV_ISA_EXT_v, false),
> +	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h, false),
> +	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM, true),
> +	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ, true),
> +	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR, true),
> +	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR, true),
> +	__RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI, true),
> +	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE, true),
> +	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM, true),
> +	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA, true),
> +	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB, true),
> +	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS, true),
> +	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA, true),
> +	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA, true),
> +	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF, true),
> +	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC, true),
> +	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL, true),
> +	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT, true),
> +	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT, true),
> +	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX, true),
>  };
>  
>  const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
> -- 
> 2.40.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
