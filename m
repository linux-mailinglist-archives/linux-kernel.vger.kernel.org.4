Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D692F6F241C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 12:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjD2KLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 06:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjD2KLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 06:11:03 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B58199F
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 03:10:58 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f178da21afso3512535e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 03:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1682763057; x=1685355057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xOoH+u4sWuKfNhD+pplTW3/yRTQkkBi07WX1BaYaefA=;
        b=I9apvM5irx4dIyh27muv1VNP0nCVp2lMMmlZijTBu18GfVN3N/BX1rNrzb9GSRzGgb
         ZKmuhtvVT+5jcJhlBAUZ4sRqftAvgXGWaRvNutYvqaeYxnTxPu338zyvbSUJRVFjEfuY
         vo8TkQ2eey8+aTV0Qw+Qe3mr2NRZHZGYpBGpNaRbPpVPm9f/8zuvJq1OhGVkpZ8LMlqr
         zhrgHD9mWzusdMw/TjDAqEPHZMJdNupfzMD0mtvmtaT0ZCxuEb6HaaGR+3IR5xSFE2KE
         gw9MbLbU5hcWzPjUOmvwl7IsQv0x/IzL5hGOPYoIgMkVWxc+KZojvo3xRPrnkexlNG8D
         hGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682763057; x=1685355057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOoH+u4sWuKfNhD+pplTW3/yRTQkkBi07WX1BaYaefA=;
        b=EI0N9z3c/OAy87fUpRxbSdYyqkPE2tvXZBnoLYWrBvnQOjGU4SRKkqeqFAfc5KDHxe
         gPd6kmwMCdrc7Be6RT3lyddIommSAdAC7Yq42zQz7ea0hnh9wz6OH99e9n58vy0SXsOj
         Q/jbPIMIk9Q1kAQ4FvE3hfcRRFnLNbIeqK4eVH1kpgixj7TUMGXPPlkOBmMvAvITtarF
         OIfh+wdbDib2TcptHdRwjGOt+O9B8vdq+3E1l7/90kC2EBRXSl5wTufYLfzsxyImRjAG
         OuDXJJ6KUhMe1DkB21UCb1rUVrW1nWG8AJZA3tXmWU25lBPtVhoEGCPrh8cr+zJybNtB
         uIIA==
X-Gm-Message-State: AC+VfDzOdG741OOYLBqt89PAkmtrfM4Tc4e1m6ZS0eOOZdUybShSKP16
        r9rNrVXOAJWrNAMJYbXd4srKKeWwhgEgO9XnmAo=
X-Google-Smtp-Source: ACHHUZ57q1rR25Sq064Wnj4QKZbd7qnq+78FeEgQ8yPFE/Yl0dGyzJruj4yhR0U4Do2kNzDAwn+Kbg==
X-Received: by 2002:a7b:c391:0:b0:3f1:9391:46c with SMTP id s17-20020a7bc391000000b003f19391046cmr6047537wmj.30.1682763057046;
        Sat, 29 Apr 2023 03:10:57 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id f25-20020a7bc8d9000000b003f0b1b8cd9bsm26856002wml.4.2023.04.29.03.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 03:10:56 -0700 (PDT)
Date:   Sat, 29 Apr 2023 12:10:55 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Yangyu Chen <cyy@cyyself.name>
Cc:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wende Tan <twd2.me@gmail.com>, Soha Jin <soha@lohu.info>,
        Hongren Zheng <i@zenithal.me>
Subject: Re: [PATCH v2 1/2] riscv: allow case-insensitive ISA string parsing
Message-ID: <yz4emsezvf47vpyrevelope5d5jcul2dsibza3jb6yeqr3r6jg@rmrt5wv2mnbn>
References: <20230428141601.678489-1-cyy@cyyself.name>
 <tencent_BC90DDC6093E3E41246D3EC73F5CAB189007@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_BC90DDC6093E3E41246D3EC73F5CAB189007@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 10:16:00PM +0800, Yangyu Chen wrote:
> According to RISC-V Hart Capabilities Table (RHCT) description in UEFI
> Forum ECR, the format of the ISA string is defined in the RISC-V
> unprivileged specification which is case-insensitive. However, the
> current ISA string parser in the kernel does not support ISA strings
> with uppercase letters.
> 
> This patch modifies the ISA string parser in the kernel to support
> case-insensitive ISA string parsing.
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  arch/riscv/kernel/cpu.c        |  3 ++-
>  arch/riscv/kernel/cpufeature.c | 25 ++++++++++++-------------
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 8400f0cc9704..52b92a267121 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/cpu.h>
> +#include <linux/ctype.h>
>  #include <linux/init.h>
>  #include <linux/seq_file.h>
>  #include <linux/of.h>
> @@ -41,7 +42,7 @@ int riscv_of_processor_hartid(struct device_node *node, unsigned long *hart)
>  		pr_warn("CPU with hartid=%lu has no \"riscv,isa\" property\n", *hart);
>  		return -ENODEV;
>  	}
> -	if (isa[0] != 'r' || isa[1] != 'v') {
> +	if (tolower(isa[0]) != 'r' || tolower(isa[1]) != 'v') {
>  		pr_warn("CPU with hartid=%lu has an invalid ISA of \"%s\"\n", *hart, isa);
>  		return -ENODEV;
>  	}
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 59d58ee0f68d..d1991c12e546 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -119,13 +119,10 @@ void __init riscv_fill_hwcap(void)
>  		}
>  
>  		temp = isa;
> -#if IS_ENABLED(CONFIG_32BIT)
> -		if (!strncmp(isa, "rv32", 4))
> +		if (IS_ENABLED(CONFIG_32BIT) && !strncasecmp(isa, "rv32", 4))
>  			isa += 4;
> -#elif IS_ENABLED(CONFIG_64BIT)
> -		if (!strncmp(isa, "rv64", 4))
> +		else if (IS_ENABLED(CONFIG_64BIT) && !strncasecmp(isa, "rv64", 4))
>  			isa += 4;
> -#endif
>  		/* The riscv,isa DT property must start with rv64 or rv32 */
>  		if (temp == isa)
>  			continue;
> @@ -136,6 +133,7 @@ void __init riscv_fill_hwcap(void)
>  			bool ext_long = false, ext_err = false;
>  
>  			switch (*ext) {
> +			case 'S':
>  			case 's':
>  				/**
>  				 * Workaround for invalid single-letter 's' & 'u'(QEMU).
> @@ -143,19 +141,20 @@ void __init riscv_fill_hwcap(void)
>  				 * not valid ISA extensions. It works until multi-letter
>  				 * extension starting with "Su" appears.
>  				 */
> -				if (ext[-1] != '_' && ext[1] == 'u') {
> +				if (ext[-1] != '_' && tolower(ext[1]) == 'u') {
>  					++isa;
>  					ext_err = true;
>  					break;
>  				}
>  				fallthrough;
> +			case 'X':
>  			case 'x':
> +			case 'Z':
>  			case 'z':
>  				ext_long = true;
>  				/* Multi-letter extension must be delimited */
>  				for (; *isa && *isa != '_'; ++isa)
> -					if (unlikely(!islower(*isa)
> -						     && !isdigit(*isa)))
> +					if (unlikely(!isalnum(*isa)))
>  						ext_err = true;
>  				/* Parse backwards */
>  				ext_end = isa;
> @@ -166,7 +165,7 @@ void __init riscv_fill_hwcap(void)
>  				/* Skip the minor version */
>  				while (isdigit(*--ext_end))
>  					;
> -				if (ext_end[0] != 'p'
> +				if (tolower(ext_end[0]) != 'p'
>  				    || !isdigit(ext_end[-1])) {
>  					/* Advance it to offset the pre-decrement */
>  					++ext_end;
> @@ -178,7 +177,7 @@ void __init riscv_fill_hwcap(void)
>  				++ext_end;
>  				break;
>  			default:
> -				if (unlikely(!islower(*ext))) {
> +				if (unlikely(!isalpha(*ext))) {
>  					ext_err = true;
>  					break;
>  				}
> @@ -188,7 +187,7 @@ void __init riscv_fill_hwcap(void)
>  				/* Skip the minor version */
>  				while (isdigit(*++isa))
>  					;
> -				if (*isa != 'p')
> +				if (tolower(*isa) != 'p')
>  					break;
>  				if (!isdigit(*++isa)) {
>  					--isa;
> @@ -205,7 +204,7 @@ void __init riscv_fill_hwcap(void)
>  #define SET_ISA_EXT_MAP(name, bit)						\
>  			do {							\
>  				if ((ext_end - ext == sizeof(name) - 1) &&	\
> -				     !memcmp(ext, name, sizeof(name) - 1) &&	\
> +				     !strncasecmp(ext, name, sizeof(name) - 1) &&	\
>  				     riscv_isa_extension_check(bit))		\
>  					set_bit(bit, this_isa);			\
>  			} while (false)						\
> @@ -213,7 +212,7 @@ void __init riscv_fill_hwcap(void)
>  			if (unlikely(ext_err))
>  				continue;
>  			if (!ext_long) {
> -				int nr = *ext - 'a';
> +				int nr = tolower(*ext) - 'a';
>  
>  				if (riscv_isa_extension_check(nr)) {
>  					this_hwcap |= isa2hwcap[nr];
> -- 
> 2.40.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
