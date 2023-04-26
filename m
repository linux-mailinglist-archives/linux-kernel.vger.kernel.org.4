Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8866EF149
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240182AbjDZJkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbjDZJkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:40:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5F030F3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:40:07 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-2f27a9c7970so6191334f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1682502006; x=1685094006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCMZ2IMJd2Mg7ngIyTYsjSve7eNLUi3UfEwOsJMdk1o=;
        b=GzOISrM2ope9QrnhxkRH/bKx1q9TCuQyewhfJeCjh5rHwXtt8kn8I99JXMFpnXY2cx
         UeA6ZgsIuRt499NoBAO8+Mr1fA1w8FtMSbRGLiYGp9oanczxuQCg6s92Kzzp82UyZ6JJ
         TZyUB1a9sn0Ude8kNNB13sjRSft4PTMPN9RTY08X7QwfIHNkutTYwl7bGfMzxeXF6shR
         ZcRw/WciBGFTSqYlnjUWfWbULosdWZe0RndS2szzyzVq6xqcoZBBdxjDMMBrHQgqFAhy
         KRS7LDvLjnZ/Gb/oleR19m9gQSwYI/UfPIFPlyw6VA4kb6+nneCG+e7TF90bnKRO+xW9
         et5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682502006; x=1685094006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCMZ2IMJd2Mg7ngIyTYsjSve7eNLUi3UfEwOsJMdk1o=;
        b=GdV1RzHdbh7bTq/tGNA2RgltDy6c5cCPfVOuupyc3URPis1+pVlCyX7j0pF24zji8Z
         vG4RX08lBYr4Z3L9uNR4oC5mCFqo/Cm8yjZ2qTz2LTnuj2OQXdh9dE3WidnMhGl91QoD
         Zf2I+gBzNMSJyli2IlzhH1oe3EaZY7h941zmPvdEAR20Hs7JY6h6y5gWFcNl2rleMfhI
         GVNeHiKcmzRUiEb5uwk0hW/gf41jTRVF0+0MsMftI/xWx80wFO2jH2YWijD7WOfoMyDe
         TZvtvug9bCedpBUPnX6YOtzRh+r1LdWhT74xugQ51XoYBAmFulUiccXX8HAW6kfjXBIq
         LmgA==
X-Gm-Message-State: AAQBX9d7aT82ZpWRpGnPJwF7a4Aq/C+KWP6yanre3GZsyXosjCPFrYGb
        uUKLDQUT0uzhWihVmIKPtDgCQpFuB5xDVdoZsF8=
X-Google-Smtp-Source: AKy350ZYnYCrMmjZAf8jC517i9hI+fORK7KGyz/IvtmdvWW9MwPZRaq1gyBB7pPl9gyVg2VV2T0qaQ==
X-Received: by 2002:adf:dc89:0:b0:2c9:e585:84b0 with SMTP id r9-20020adfdc89000000b002c9e58584b0mr13150565wrj.1.1682502006068;
        Wed, 26 Apr 2023 02:40:06 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id l11-20020a5d674b000000b0030276f42f08sm14021845wrw.88.2023.04.26.02.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 02:40:05 -0700 (PDT)
Date:   Wed, 26 Apr 2023 11:40:04 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com, kito.cheng@sifive.com, jrtc27@jrtc27.com,
        conor.dooley@microchip.com, matthias.bgg@gmail.com,
        heinrich.schuchardt@canonical.com, greentime.hu@sifive.com,
        nick.knight@sifive.com, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, richard.henderson@linaro.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH 3/4] RISC-V: export the ISA string of the running machine
 in the aux vector
Message-ID: <tef7bmjygjiafy3cykdj6uqlkovej5om2xm5rcnbjcqp34e574@hxlta64oagat>
References: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
 <20230424194911.264850-4-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424194911.264850-4-heiko.stuebner@vrull.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 09:49:10PM +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> Already defined aux-vectors regarding the machine type are AT_PLATFORM
> and AT_BASE_PLATFORM. PPC already uses AT_BASE_PLATFORM to identify the
> real platform the system is running on, so do a similar thing on RISC-V
> and export the ISA string of the running machine via this aux-vector
> element.
> 
> This way userspace can possibly adapt to extensions that allow it to
> run certain loads more performantly.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/include/asm/elf.h | 10 ++++++++++
>  arch/riscv/kernel/cpu.c      | 12 ++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
> index 30e7d2455960..820ef627e83d 100644
> --- a/arch/riscv/include/asm/elf.h
> +++ b/arch/riscv/include/asm/elf.h
> @@ -78,6 +78,16 @@ extern unsigned long elf_hwcap;
>  
>  #define COMPAT_ELF_PLATFORM	(NULL)
>  
> +/*
> + * ELF_PLATFORM indicates the ISA supported by the platform, but has
> + * special meaning to ld.so .
                              ^ stray space

> + * Expose the ISA string including all usable extensions via
> + * ELF_BASE_PLATFORM instead and allow userspace to adapt to them
> + * if needed.
> + */
> +#define ELF_BASE_PLATFORM (riscv_base_platform)
> +extern const char *riscv_base_platform;
> +
>  #ifdef CONFIG_MMU
>  #define ARCH_DLINFO						\
>  do {								\
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 06c2f587a176..71770563199f 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -118,8 +118,12 @@ static int riscv_cpuinfo_starting(unsigned int cpu)
>  	return 0;
>  }
>  
> +const char *riscv_base_platform = NULL;

No need for the '= NULL'

> +static char *riscv_create_isa_string(void);
> +
>  static int __init riscv_cpuinfo_init(void)
>  {
> +	char *isa_str;
>  	int ret;
>  
>  	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "riscv/cpuinfo:starting",
> @@ -129,6 +133,14 @@ static int __init riscv_cpuinfo_init(void)
>  		return ret;
>  	}
>  
> +	/*
> +	 * Create the isa-string with the common set of extensions over
> +	 * all harts, to expose as AT_BASE_PLATFORM in the aux vector.
> +	 */
> +	isa_str = riscv_create_isa_string();
> +	if (!IS_ERR(isa_str))
> +		riscv_base_platform = isa_str;
> +
>  	return 0;
>  }
>  arch_initcall(riscv_cpuinfo_init);
> -- 
> 2.39.0
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
