Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342A2742350
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjF2JcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjF2Jbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:31:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E7635AB
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:31:36 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso724051e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688031095; x=1690623095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ajD4Xlmgnwv8O+jtu7HYaXxwVa4EBrrrsttRRo2IsCo=;
        b=S6CoM+QL+IrLFXgIDSFYfgP3xref1Lw3zrAa+ruoTEOTjEaeaWuoTi/yED9tjbOX3e
         WPy4uhNOuQ/FNXaRj8aD0G3pH+8qlO8D4BxuYAa4lGpwdcf6eftfPCG2ANJ7sdFMv4kV
         NjVwHbhrtAJVyuyZ6UtzcDQEYkrtRwFgHZJUI8GaBcf3os1KN5dYL6QD2xr5mcK6mkY/
         SYXwzjIiHG7dgcHXiVmE0eqmwaXbKdm9KjwnCZS+otS/r8deZFL7rxvIoPhgnLRIdzhE
         z/1HTz7KLstyepnVUfFEUHJ39fR2O1TkMdm/bfO0XjWzVpm1xIjslxTdUBlh/u1r2iC0
         Z2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688031095; x=1690623095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajD4Xlmgnwv8O+jtu7HYaXxwVa4EBrrrsttRRo2IsCo=;
        b=cTBSuVrAfQ5ApEmB6XqgpudyQmsjJoHBKfIs0mjBRFac1/qUpagLu7uSaa8QkL5u3W
         YotMMwfjIpprpxdvA60SCwBNUEiSx6I9I5yUyjSx6HjrGIoUquwOJt7o4QUEg8TM0bQv
         VahStxsFe/aQxiKdCy3YFPMzmfw4MUAL2p6BBAuMj5tj+rrAr+Izzy4mSImhaculP+qr
         UurZekABzreC3+v4Cf/918N3B/xwPLyPdpvy+jKtWORlID6f91drlbc7AogdacMlP70l
         PnIzOKNXwxvrhswiR2HGdEBxeozgLB0u1bcyut98zfwtD5DNADfT0ZEcAUO/lfv9V3HP
         Izfw==
X-Gm-Message-State: ABy/qLaNSbYtY4rZvmgqp9jQz6fiCUANHcHQKBoTxVu4nAmiXN/EuJh2
        IQimCwtMM+IvifrL0DtVxcRhRgn+ad2w5Z5+7E4=
X-Google-Smtp-Source: APBJJlEt3kWDaGO7D0zrrowbl1KaWdBGX6mWiQYWM1fItOdFeb3Rv6MrTumN9H7oxc+mij9WFVhxNA==
X-Received: by 2002:a05:6512:2355:b0:4fb:97d9:382b with SMTP id p21-20020a056512235500b004fb97d9382bmr1730502lfu.60.1688031094662;
        Thu, 29 Jun 2023 02:31:34 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b003f733c1129fsm7205674wmc.33.2023.06.29.02.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 02:31:34 -0700 (PDT)
Date:   Thu, 29 Jun 2023 11:31:33 +0200
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
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v2 10/10] RISC-V: provide a Kconfig option to disable
 parsing "riscv,isa"
Message-ID: <20230629-a80f112e6ed4158080867694@orel>
References: <20230629-rebuttal-vagueness-a699deb7c7b3@wendy>
 <20230629-resilient-grievance-d782163b09d6@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629-resilient-grievance-d782163b09d6@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 09:28:56AM +0100, Conor Dooley wrote:
> As it says on the tin, provide a Kconfig option to disabling parsing the
> "riscv,isa" devicetree property. Hide the option behind NONPORTABLE so
> that only those willing to keep the pieces enable it, and make sure the
> default kernel contains the fallback code.
> 
> Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/Kconfig             | 16 ++++++++++++++++
>  arch/riscv/kernel/cpu.c        |  3 +++
>  arch/riscv/kernel/cpufeature.c |  2 +-
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 1d39efe2b940..0e1909ac5947 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -291,6 +291,22 @@ config NONPORTABLE
>  
>  	  If unsure, say N.
>  
> +config NO_RISCV_ISA_FALLBACK
> +	bool "Permit falling back to parsing riscv,isa for extension support"
> +	depends on NONPORTABLE
> +	help
> +	  Parsing the "riscv,isa" devicetree property has been deprecated and
> +	  replaced by a list of explicitly defined strings. For compatibility
> +	  with existing platforms, the kernel will fall back to parsing the
> +	  "riscv,isa" property if the replacements are not found.
> +
> +	  Selecting Y here will result in a kernel without this fallback, and
> +	  will not work on platforms where the devicetree does not contain the
> +	  replacement 	  properties of "riscv,isa-base" and
                     ^ spacing issue

> +	  "riscv,isa-extensions". Please see the dt-binding, located at
> +	  Documentation/devicetree/bindings/riscv/extensions.yaml for details
> +	  on the replacement properties.
> +
>  choice
>  	prompt "Base ISA"
>  	default ARCH_RV64I
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 9a4f4a23afcd..86a1d98b8b3b 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -81,6 +81,9 @@ int riscv_early_of_processor_hartid(struct device_node *node, unsigned long *har
>  	return 0;
>  
>  old_interface:
> +	if (IS_ENABLED(CONFIG_NO_RISCV_ISA_FALLBACK))
> +		return -ENODEV;
> +
>  	if (of_property_read_string(node, "riscv,isa", &isa)) {
>  		pr_warn("CPU with hartid=%lu has no \"riscv,isa-base\" or \"riscv,isa\" property\n",
>  			*hart);
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 2c4503fa984f..f6fb18d2af84 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -490,7 +490,7 @@ void __init riscv_fill_hwcap(void)
>  	} else {
>  		int ret = riscv_fill_hwcap_from_ext_list(isa2hwcap);
>  
> -		if (ret) {
> +		if (ret && !IS_ENABLED(CONFIG_NO_RISCV_ISA_FALLBACK)) {
>  			pr_info("Falling back to deprecated \"riscv,isa\"\n");
>  			riscv_fill_hwcap_from_isa_string(isa2hwcap);
>  		}
> -- 
> 2.40.1
>

Should we also have a kernel command line option, 'isa_fallback', where
without this config the command line option is not necessary to fallback,
but, with this config, no fallback will be done unless 'isa_fallback' is
provided?

Thanks,
drew
