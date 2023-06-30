Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363D77435C2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjF3H3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 03:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjF3H3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:29:06 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C03268A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 00:28:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc0981733so13353205e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 00:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688110134; x=1690702134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5hnHLVzBmXjX34BGgWyrCPO1253WX/LErEgN1o82kw=;
        b=eK2veF+sXiK1f6F6Ryz5qMNL9KR/JTqWXWrwnauwpwS4S2SbOBqWreg1jOJof/xVr6
         0tdT3sN2XYtKm9WDfJ2k7n4TXdxKVci2gO70/ZBV0L/xLVzwGFu3b96hWOpZyyH0/64X
         Y/4FwEgA6nhnDElwm6Wpx+urEsujsFQGyi5UzZEfMeqTdzZki4Ko3IdbDq8lmJe6yfqn
         U+3VI14iYpbKJEN437PH7YTuB8U8zsV87c6AtfGGyc/VndWngDD3BjE2mDDT6GDx1ZxL
         cAfi46T+yP5eIwBSlrYJg02MG5pq3lfJtdmUubVtXkQ6aZD96dQRq9mY6p31s5dqFcv0
         u+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688110134; x=1690702134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5hnHLVzBmXjX34BGgWyrCPO1253WX/LErEgN1o82kw=;
        b=aQC4Vp18Th/bT9UhZJq5hlTqhQQ3rXmA5BNyPhNzryNOw9all2w+bMXnbAgVMYALfH
         big84frVKudCf9fk8Lrclwhrm8C0Bxr7dhnfy06rbOes41ASj5b4g3u6Gh8vBHEVC+j/
         dq4zgwQtNmfQ3BUD77TfJlCf+HIyWya055bOSGqwjaBObx6aXZzbewaMEZmF/zstfxxh
         JQV2xRUi3sA/4t1ezh7FGfy2JFLFQ7icAav4G5HZ1eq+OF+ck2F9iEg5YscJ9vHFxxrA
         r5Ig1gg/QCtS1Z+h1iFZS5rEEhLt0eOFsVJHwaGwih06hYssUSn0lxcxlJvsDDDcraWi
         SomA==
X-Gm-Message-State: AC+VfDwldaU9zYk1+Hm8doe1p7Ikp9wb8Pjb5tdlxrHD7LxawTzBgeeK
        B/Q4glFQ/nxY4nqTQjo2c3KkGA==
X-Google-Smtp-Source: ACHHUZ7OfWejyvRwW+wSH4AjjfHdFJ4CbX0pfF0ylt/EErynx8bdIVuRTP62VNT4HzszPH01RgaI3A==
X-Received: by 2002:a05:600c:3649:b0:3f9:bf0f:1ceb with SMTP id y9-20020a05600c364900b003f9bf0f1cebmr1450795wmq.37.1688110134199;
        Fri, 30 Jun 2023 00:28:54 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id l21-20020a7bc455000000b003fa95c466a1sm13851044wmi.5.2023.06.30.00.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 00:28:53 -0700 (PDT)
Date:   Fri, 30 Jun 2023 09:28:52 +0200
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
Subject: Re: [PATCH v2 03/10] RISC-V: shunt isa_ext_arr to cpufeature.c
Message-ID: <20230630-1a540679d6cf0275511bfbfc@orel>
References: <20230629-rebuttal-vagueness-a699deb7c7b3@wendy>
 <20230629-museum-playhouse-6dbe7e573f2c@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629-museum-playhouse-6dbe7e573f2c@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 09:28:49AM +0100, Conor Dooley wrote:
> To facilitate using one struct to define extensions, rather than having
> several, shunt isa_ext_arr to cpufeature.c, where it will be used for
> probing extension presence also.
> As that scope of the array as widened, prefix it with riscv & drop the
> type from the variable name.
> 
> Since the new array is const, print_isa() needs a wee bit of cleanup to
> avoid complaints about losing the const qualifier.
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes in v2:
> - Drop the empty element from the end of the array, it was adding a bug
>   anyway as I was not decrementing the result of ARRAY_SIZE() by one.
>   Likely I meant to drop it originally and forgot, as dropping the
>   decrement was intentional.

I don't think v1 introduced a bug, because you changed the condition to
'<' from '<=' to account for not subtracting one. Both the original code
and v1 were doing a useless __riscv_isa_extension_available() check of
RISCV_ISA_EXT_MAX, though, which this version removes.

Thanks,
drew


> ---
>  arch/riscv/include/asm/hwcap.h |  3 ++
>  arch/riscv/kernel/cpu.c        | 75 +---------------------------------
>  arch/riscv/kernel/cpufeature.c | 67 ++++++++++++++++++++++++++++++
>  3 files changed, 72 insertions(+), 73 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index f041bfa7f6a0..7a57e6109aef 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -76,6 +76,9 @@ struct riscv_isa_ext_data {
>  	unsigned int isa_ext_id;
>  };
>  
> +extern const struct riscv_isa_ext_data riscv_isa_ext[];
> +extern const size_t riscv_isa_ext_count;
> +
>  unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
>  
>  #define riscv_isa_extension_mask(ext) BIT_MASK(RISCV_ISA_EXT_##ext)
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index ddd7634e4c1d..269a32ceb595 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -160,81 +160,10 @@ arch_initcall(riscv_cpuinfo_init);
>  
>  #ifdef CONFIG_PROC_FS
>  
> -#define __RISCV_ISA_EXT_DATA(UPROP, EXTID) \
> -	{							\
> -		.uprop = #UPROP,				\
> -		.isa_ext_id = EXTID,				\
> -	}
> -
> -/*
> - * The canonical order of ISA extension names in the ISA string is defined in
> - * chapter 27 of the unprivileged specification.
> - *
> - * Ordinarily, for in-kernel data structures, this order is unimportant but
> - * isa_ext_arr defines the order of the ISA string in /proc/cpuinfo.
> - *
> - * The specification uses vague wording, such as should, when it comes to
> - * ordering, so for our purposes the following rules apply:
> - *
> - * 1. All multi-letter extensions must be separated from other extensions by an
> - *    underscore.
> - *
> - * 2. Additional standard extensions (starting with 'Z') must be sorted after
> - *    single-letter extensions and before any higher-privileged extensions.
> -
> - * 3. The first letter following the 'Z' conventionally indicates the most
> - *    closely related alphabetical extension category, IMAFDQLCBKJTPVH.
> - *    If multiple 'Z' extensions are named, they must be ordered first by
> - *    category, then alphabetically within a category.
> - *
> - * 3. Standard supervisor-level extensions (starting with 'S') must be listed
> - *    after standard unprivileged extensions.  If multiple supervisor-level
> - *    extensions are listed, they must be ordered alphabetically.
> - *
> - * 4. Standard machine-level extensions (starting with 'Zxm') must be listed
> - *    after any lower-privileged, standard extensions.  If multiple
> - *    machine-level extensions are listed, they must be ordered
> - *    alphabetically.
> - *
> - * 5. Non-standard extensions (starting with 'X') must be listed after all
> - *    standard extensions. If multiple non-standard extensions are listed, they
> - *    must be ordered alphabetically.
> - *
> - * An example string following the order is:
> - *    rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
> - *
> - * New entries to this struct should follow the ordering rules described above.
> - */
> -static struct riscv_isa_ext_data isa_ext_arr[] = {
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
> -};
> -
>  static void print_isa_ext(struct seq_file *f)
>  {
> -	struct riscv_isa_ext_data *edata;
> -	int i = 0, arr_sz;
> -
> -	arr_sz = ARRAY_SIZE(isa_ext_arr) - 1;
> -
> -	for (i = 0; i <= arr_sz; i++) {
> -		edata = &isa_ext_arr[i];
> +	for (int i = 0; i < riscv_isa_ext_count; i++) {
> +		const struct riscv_isa_ext_data *edata = &riscv_isa_ext[i];
>  		if (!__riscv_isa_extension_available(NULL, edata->isa_ext_id))
>  			continue;
>  		seq_printf(f, "_%s", edata->uprop);
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index bdcf460ea53d..fb476153fffc 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -99,6 +99,73 @@ static bool riscv_isa_extension_check(int id)
>  	return true;
>  }
>  
> +#define __RISCV_ISA_EXT_DATA(UPROP, EXTID) \
> +	{							\
> +		.uprop = #UPROP,				\
> +		.isa_ext_id = EXTID,				\
> +	}
> +
> +/*
> + * The canonical order of ISA extension names in the ISA string is defined in
> + * chapter 27 of the unprivileged specification.
> + *
> + * Ordinarily, for in-kernel data structures, this order is unimportant but
> + * isa_ext_arr defines the order of the ISA string in /proc/cpuinfo.
> + *
> + * The specification uses vague wording, such as should, when it comes to
> + * ordering, so for our purposes the following rules apply:
> + *
> + * 1. All multi-letter extensions must be separated from other extensions by an
> + *    underscore.
> + *
> + * 2. Additional standard extensions (starting with 'Z') must be sorted after
> + *    single-letter extensions and before any higher-privileged extensions.
> + *
> + * 3. The first letter following the 'Z' conventionally indicates the most
> + *    closely related alphabetical extension category, IMAFDQLCBKJTPVH.
> + *    If multiple 'Z' extensions are named, they must be ordered first by
> + *    category, then alphabetically within a category.
> + *
> + * 3. Standard supervisor-level extensions (starting with 'S') must be listed
> + *    after standard unprivileged extensions.  If multiple supervisor-level
> + *    extensions are listed, they must be ordered alphabetically.
> + *
> + * 4. Standard machine-level extensions (starting with 'Zxm') must be listed
> + *    after any lower-privileged, standard extensions.  If multiple
> + *    machine-level extensions are listed, they must be ordered
> + *    alphabetically.
> + *
> + * 5. Non-standard extensions (starting with 'X') must be listed after all
> + *    standard extensions. If multiple non-standard extensions are listed, they
> + *    must be ordered alphabetically.
> + *
> + * An example string following the order is:
> + *    rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
> + *
> + * New entries to this struct should follow the ordering rules described above.
> + */
> +const struct riscv_isa_ext_data riscv_isa_ext[] = {
> +	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> +	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
> +	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
> +	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
> +	__RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI),
> +	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> +	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
> +	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
> +	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> +	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
> +	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
> +	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
> +	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> +	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
> +	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> +	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
> +	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> +};
> +
> +const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
> +
>  void __init riscv_fill_hwcap(void)
>  {
>  	struct device_node *node;
> -- 
> 2.40.1
> 
