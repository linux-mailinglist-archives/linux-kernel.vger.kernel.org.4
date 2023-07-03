Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6188745A85
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjGCKo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjGCKox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:44:53 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CF2C1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:44:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fa16c6a85cso6613498e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 03:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688381089; x=1690973089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/z+WW5kwnxhCfLcQaJmH1xNEQf/PAh/QQcNu6U1wyek=;
        b=N+N/pXD6XQ24ilAe7T36rjHC/kWdO5IdIka8Ch7o4paXsRfixvo4trlwDMllISRt85
         a3+VwQk2dGZrVCJdwKgg+HVppR3UKrY4HBNJrHeTSytI+iOLXzoLda9vU066Y/SFVkDu
         m8f52hOiPvQDpqBrXaKK2Nfa0CNllfHxCjqTXKPeaeAPHCltP2mqeONZ6sTJkKKG1mGR
         mBKveunaZ4YSU+7hY87RwUkvwshjMWXQI7ZyswvDwoNgIDiyY62c/FmwL18KTzRUnxkV
         S1STKcf6JjQn3BR9EaMLVoMqi36Gw9lkJVSsSWdFdbF93Iw/yX56RXvJgq5GpX7n2RQ1
         41fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688381089; x=1690973089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/z+WW5kwnxhCfLcQaJmH1xNEQf/PAh/QQcNu6U1wyek=;
        b=dfml2fIpuGXKc4Pa3H0CouPOppWfKAB73vLaIrhruzfPX4EfAQTqzQ9T210jZSJ1MH
         sFYWvAkEl1GZjC9dPLTT5KQ9Ca9D7+ie8+JbTzwJyMAdwerWxDFNlaNfNPj+JXeDa5JU
         zC72NIBKBkKkABCKbEKDkvXJzc7FFTpNRcU0gH4DRW5AGXGsSGoRqn9zNBi9od1oDJzQ
         e5Zz5qjVflvCOmDXIWzzBVZxseLRf02V5C6PwmsXlMOSxtmQnZuPRYQCvNBheVHMISLe
         QQxjixu/SDv40zfhsoGHo02QURAks1RqFCYeIL5roq8PGxvzo6Ul3T2AAU9j+h0wMbRE
         uuaw==
X-Gm-Message-State: ABy/qLYRof0Wg5VWB/IDRVtlb4s9FeCFNFrCxR4evMT4Nk4/XvrmoTlq
        bx9RCmdA5cE68mYr2B+bJ0KUpw==
X-Google-Smtp-Source: APBJJlF1w7RoN0Uq19CNfqTlvPYcMoyTNYeuTkFT+ge+QXXoqsRGY+amLSuEfhQDxxk/a9Ld1x5OGw==
X-Received: by 2002:a05:6512:3b0c:b0:4fb:8981:f08 with SMTP id f12-20020a0565123b0c00b004fb89810f08mr8023840lfv.43.1688381089517;
        Mon, 03 Jul 2023 03:44:49 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c218500b003fbcdba1a52sm6996330wme.3.2023.07.03.03.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 03:44:48 -0700 (PDT)
Date:   Mon, 3 Jul 2023 12:44:48 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     palmer@dabbelt.com, conor@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v3 11/11] RISC-V: provide Kconfig & commandline options
 to control parsing "riscv,isa"
Message-ID: <20230703-57fe19b069fdacd4d9a82cf1@orel>
References: <20230703-repayment-vocalist-e4f3eeac2b2a@wendy>
 <20230703-greedy-dividable-251fa2b809ac@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703-greedy-dividable-251fa2b809ac@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 11:28:03AM +0100, Conor Dooley wrote:
> As it says on the tin, provide Kconfig option to control parsing the
> "riscv,isa" devicetree property. If either option is used, the kernel
> will fall back to parsing "riscv,isa", where "riscv,isa-base" and
> "riscv,isa-extensions" are not present.
> The Kconfig options are set up so that the default kernel configuration
> will enable the fallback path, without needing the commandline option.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes in v3:
> - Invert the Kconfig entry. It's now default y & not hidden by
>   NONPORTABLE, but its entablement will now activate the fallback
> - Add a commandline option to enable the fallback on kernels that do not
>   enable it in Kconfig, as Drew suggested
> - Default the global var to the Kconfig option & override it with the
>   commandline one, rather than have checks for IS_ENABLED() and for the
>   commandline option in riscv_fill_hwcap() &
>   riscv_early_of_processor_hartid()
> ---
>  .../admin-guide/kernel-parameters.txt          |  7 +++++++
>  arch/riscv/Kconfig                             | 18 ++++++++++++++++++
>  arch/riscv/include/asm/hwcap.h                 |  1 +
>  arch/riscv/kernel/cpu.c                        |  6 ++++++
>  arch/riscv/kernel/cpufeature.c                 | 14 +++++++++++++-
>  5 files changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index d910fba25f2c..1bd435f60055 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5437,6 +5437,13 @@
>  			[KNL] Disable ring 3 MONITOR/MWAIT feature on supported
>  			CPUs.
>  
> +	riscv_isa_fallback [RISCV]
> +			When CONFIG_RISCV_ISA_FALLBACK is not enabled, permit
> +			falling back to detecting extension support by parsing
> +			"riscv,isa" property on devicetree systems when the
> +			replacement properties are not found. See the Kconfig
> +			entry for RISCV_ISA_FALLBACK.
> +
>  	ro		[KNL] Mount root device read-only on boot
>  
>  	rodata=		[KNL]
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 1d39efe2b940..a9a473b67182 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -841,6 +841,24 @@ config XIP_PHYS_ADDR
>  	  be linked for and stored to.  This address is dependent on your
>  	  own flash usage.
>  
> +config RISCV_ISA_FALLBACK
> +	bool "Permit falling back to parsing riscv,isa for extension support by default"
> +	default y
> +	help
> +	  Parsing the "riscv,isa" devicetree property has been deprecated and
> +	  replaced by a list of explicitly defined strings. For compatibility
> +	  with existing platforms, the kernel will fall back to parsing the
> +	  "riscv,isa" property if the replacements are not found.
> +
> +	  Selecting N here will result in a kernel that does not use the
> +	  fallback, unless the commandline "riscv_isa_fallback" parameter is
> +	  present.
> +
> +	  Please see the dt-binding, located at
> +	  Documentation/devicetree/bindings/riscv/extensions.yaml for details
> +	  on the replacement properties of "riscv,isa-base" and

nit: It's probably just me, but 'of' twists my brain a bit here. I
think

...the replacement properties, "riscv,isa-base" and "riscv,isa-extensions".

works better (for me).

> +	  "riscv,isa-extensions".
> +
>  endmenu # "Boot options"
>  
>  config BUILTIN_DTB
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index e3cda14a486b..b7b58258f6c7 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -81,6 +81,7 @@ struct riscv_isa_ext_data {
>  
>  extern const struct riscv_isa_ext_data riscv_isa_ext[];
>  extern const size_t riscv_isa_ext_count;
> +extern bool riscv_isa_fallback;
>  
>  unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
>  
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 28d5af21f544..1acf3679600d 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -87,6 +87,12 @@ int riscv_early_of_processor_hartid(struct device_node *node, unsigned long *har
>  	return 0;
>  
>  old_interface:
> +	if (!riscv_isa_fallback) {
> +		pr_warn("CPU with hartid=%lu is invalid: this kernel does not parse \"riscv,isa\"",
> +			*hart);
> +		return -ENODEV;
> +	}
> +
>  	if (of_property_read_string(node, "riscv,isa", &isa)) {
>  		pr_warn("CPU with hartid=%lu has no \"riscv,isa-base\" or \"riscv,isa\" property\n",
>  			*hart);
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 2c4503fa984f..5945dfc5f806 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -471,6 +471,18 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_RISCV_ISA_FALLBACK
> +bool __initdata riscv_isa_fallback = true;
> +#else
> +bool __initdata riscv_isa_fallback;
> +static int __init riscv_isa_fallback_setup(char *__unused)
> +{
> +	riscv_isa_fallback = true;
> +	return 1;
> +}
> +early_param("riscv_isa_fallback", riscv_isa_fallback_setup);
> +#endif
> +
>  void __init riscv_fill_hwcap(void)
>  {
>  	char print_str[NUM_ALPHA_EXTS + 1];
> @@ -490,7 +502,7 @@ void __init riscv_fill_hwcap(void)
>  	} else {
>  		int ret = riscv_fill_hwcap_from_ext_list(isa2hwcap);
>  
> -		if (ret) {
> +		if (ret && riscv_isa_fallback) {
>  			pr_info("Falling back to deprecated \"riscv,isa\"\n");
>  			riscv_fill_hwcap_from_isa_string(isa2hwcap);
>  		}
> -- 
> 2.40.1
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
