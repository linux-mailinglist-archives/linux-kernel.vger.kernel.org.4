Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2457667D0D8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjAZQCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjAZQCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:02:42 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB2C69500
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:02:37 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id qx13so6211534ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XlKMRT9EHE65PtZHGD4k5FPNh/3AR3OGuPsdhBKT3qA=;
        b=gVGoa76c/5rcg8G4PJsKVsH40EqYRtPXBFl7cMEhxTAGOx7n3XRkZBT5M1LjyfxzzS
         NNTkEx8ZywN1TUdTYOGh6T2vQPp9JSmW2Ip0K4W3QnoyiA8dyh9gv0zxTLENpebOTA6Y
         2TxJyZ01aQkpqZQ1izt8958vsDK9vtJm81ED338cGJ//zUeessnoocomcBAR7VKzpYCs
         nJySEhKgBYDOjCcG+9shtL+EjAYO9GRPiQ8vR0Z5/+jhv3p0BDqHz5lEwigamOyQh5Uf
         BwYynfKbGPtzq8Eb51M8Ebjd2g8s4fmr9EU/yj7rgI2u+1LxavslRi4hqS7VpeUOnETi
         FSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlKMRT9EHE65PtZHGD4k5FPNh/3AR3OGuPsdhBKT3qA=;
        b=l2GcX2eT/7hlE9ZrJBi1YBKA6CurU172d93DyzjVhLwFe8N9JTPY1DX9aqN6qfGmpu
         P+rrSFFBFgyDhoy+Iln5A19WmHy3VpUtmymP0gq+20TZv4St48hXYnVv3EOJHUjbgIAb
         2xVRoTn7CoGyH/Mq5LDBnNMcG6wqJDAU5HcPrTZcRD4jcSDqus6GVkGHGeUiNUF2q6DN
         JPuGPli42jlPVwLJV7ZQZP1jLnAN3CZaRsn6JSFCfQRl0P/trxCI/gXhrBTFeklIeWk4
         Qv2G4sbAOgfz5sF6GeoULmUYgoXKhNPe1nvm1KdWYsJV75Y/NBV+LsWMU+9Pf9zYS8B+
         0cMg==
X-Gm-Message-State: AFqh2kqfEF1Z9Cp2mvddkJiytx39i5xsUaFa6yvHPep5vBKC5Hv1zn6/
        3BqbrnFyMFGuO4Or1ac911i0mg==
X-Google-Smtp-Source: AMrXdXsk6/rbV5qIL2/9m6irzy5vZLxenpeokFpPeGQyT1ZRaqMfMO3FJ+14IUiRM7HGjs6S8IzxYw==
X-Received: by 2002:a17:907:2489:b0:84d:255e:21a4 with SMTP id zg9-20020a170907248900b0084d255e21a4mr39291298ejb.2.1674748956236;
        Thu, 26 Jan 2023 08:02:36 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id ec16-20020a170906b6d000b0073d796a1043sm762948ejb.123.2023.01.26.08.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 08:02:35 -0800 (PST)
Date:   Thu, 26 Jan 2023 17:02:34 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] RISC-V: Detect AIA CSRs from ISA string
Message-ID: <20230126160234.pkx4socjv3fcxpmn@orel>
References: <20230112140304.1830648-1-apatel@ventanamicro.com>
 <20230112140304.1830648-3-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112140304.1830648-3-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 07:32:59PM +0530, Anup Patel wrote:
> We have two extension names for AIA ISA support: Smaia (M-mode AIA CSRs)
> and Ssaia (S-mode AIA CSRs).
> 
> We extend the ISA string parsing to detect Smaia and Ssaia extensions.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/hwcap.h | 8 ++++++++
>  arch/riscv/kernel/cpu.c        | 2 ++
>  arch/riscv/kernel/cpufeature.c | 2 ++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 86328e3acb02..c649e85ed7bb 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -59,10 +59,18 @@ enum riscv_isa_ext_id {
>  	RISCV_ISA_EXT_ZIHINTPAUSE,
>  	RISCV_ISA_EXT_SSTC,
>  	RISCV_ISA_EXT_SVINVAL,
> +	RISCV_ISA_EXT_SSAIA,
> +	RISCV_ISA_EXT_SMAIA,

These will change a couple different ways due other other patches in
flight, but let's put the pair in alphabetical order now so they get
moved together that way.

>  	RISCV_ISA_EXT_ID_MAX
>  };
>  static_assert(RISCV_ISA_EXT_ID_MAX <= RISCV_ISA_EXT_MAX);
>  
> +#ifdef CONFIG_RISCV_M_MODE
> +#define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
> +#else
> +#define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
> +#endif

This isn't used in this patch, so should probably be introduced in a later
patch when it is.

> +
>  /*
>   * This enum represents the logical ID for each RISC-V ISA extension static
>   * keys. We can use static key to optimize code path if some ISA extensions
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 1b9a5a66e55a..a215ec929160 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -162,6 +162,8 @@ arch_initcall(riscv_cpuinfo_init);
>   *    extensions by an underscore.
>   */
>  static struct riscv_isa_ext_data isa_ext_arr[] = {
> +	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
> +	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>  	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
>  	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 93e45560af30..3c5b51f519d5 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -228,6 +228,8 @@ void __init riscv_fill_hwcap(void)
>  				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
>  				SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
>  				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
> +				SET_ISA_EXT_MAP("smaia", RISCV_ISA_EXT_SMAIA);
> +				SET_ISA_EXT_MAP("ssaia", RISCV_ISA_EXT_SSAIA);
>  			}
>  #undef SET_ISA_EXT_MAP
>  		}
> -- 
> 2.34.1
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
