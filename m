Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACC4642BAE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiLEP1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiLEP1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:27:05 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5291FF4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 07:25:44 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id b2so28653079eja.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 07:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1z97OrGTU/hJWYAfqZfW/MI++6sXrfXzrMwpvG8EePg=;
        b=dCM178E8Suk100QO/ms7b3XLKbOF+8tZvEEe9/zk+YQFvI3lnSe87JvStybbKAIfub
         awqCa8ezZ4Uu3oKML0aHEtQOrVWM0NOjSyxTARAgBYK/FwVOxscrIDZb0vo9C0F1vhTv
         CVlVKF5k1rIiSR4jcc1yHO9lBRBOEi2eHTk67Em7XOp7ByTQwljVXxY+ojE4+ei+ajt8
         TEkAfU/7OsPg0uqxbXrxu8GBaSxhxorn+jHdkq93jedGn6DJ+7fXOLXWI5Q/4PjAoldP
         831OfGZiiaXYkhnPAWplr8SxMrNd9DsxE7ZD4/4GiOHVOhoemq1Qq6Zm+ib+IqnFJXjX
         Ns7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1z97OrGTU/hJWYAfqZfW/MI++6sXrfXzrMwpvG8EePg=;
        b=CwjC6cmEv2SLZwj6agODE21MHKD96TnB2FWDGn/4PK4a25Tk3YZv46KjFNj38UTK8j
         sWJYWVtw5CmcIfONptc1cIW0Jf8xnW6x00qTlX8D1Ov8esBUOUPc3abIqpC4n195o4Bm
         A3wV/4FmgX4ss1mm9WwNcY4jspKM76LzIJfuNbaoBZQSOeAsePGVDyPpSsdZBAcBe8Ac
         lPFTqU2xZZ6kNcrLfeXrnq0SUxquTfCsrw81xhxZDwgfWlPSdsnynO/PKNwZKqDIk6KP
         Ld6hQwd2oxgC9/buhe/MGdYYax3l4oIE7o+fz+3cy9YrI0NCHbkfhTao85gGyY6uSAW0
         lUvA==
X-Gm-Message-State: ANoB5pmhNM9JBbcKYB7OXL1ar6G8NVFvZMzccSIWN0MYZPf36HzWWmMR
        mtTVQgMil1GcJSd7B2QCma/4gckO50IzpOw8
X-Google-Smtp-Source: AA0mqf6QxKwgJA2/+pD4o+mt3tAj8MLTz+WBlne9oWrdNVyr9G8GnF6kna89ihFcFCFx1zccpM/vew==
X-Received: by 2002:a17:906:94e:b0:7ba:4617:3f17 with SMTP id j14-20020a170906094e00b007ba46173f17mr47839324ejd.226.1670253942928;
        Mon, 05 Dec 2022 07:25:42 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-748-2a9a-a2a6-1362.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:748:2a9a:a2a6:1362])
        by smtp.gmail.com with ESMTPSA id ca13-20020a170906a3cd00b007c08439161dsm6338597ejb.50.2022.12.05.07.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 07:25:42 -0800 (PST)
Date:   Mon, 5 Dec 2022 16:25:41 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v2 08/13] riscv: module: move find_section to module.h
Message-ID: <20221205152541.5ahiqvlb7lt6np7w@kamzik>
References: <20221204174632.3677-1-jszhang@kernel.org>
 <20221204174632.3677-9-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221204174632.3677-9-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 01:46:27AM +0800, Jisheng Zhang wrote:
> Move it to the header so that the implementation can be shared
> by the alternatives code.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/module.h | 15 +++++++++++++++
>  arch/riscv/kernel/module.c      | 15 ---------------
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/module.h b/arch/riscv/include/asm/module.h
> index 76aa96a9fc08..78722a79fc59 100644
> --- a/arch/riscv/include/asm/module.h
> +++ b/arch/riscv/include/asm/module.h
> @@ -111,4 +111,19 @@ static inline struct plt_entry *get_plt_entry(unsigned long val,
>  
>  #endif /* CONFIG_MODULE_SECTIONS */

Should probably add an explicit #include <linux/elf.h>

Otherwise

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

>  
> +static inline const Elf_Shdr *find_section(const Elf_Ehdr *hdr,
> +					   const Elf_Shdr *sechdrs,
> +					   const char *name)
> +{
> +	const Elf_Shdr *s, *se;
> +	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
> +
> +	for (s = sechdrs, se = sechdrs + hdr->e_shnum; s < se; s++) {
> +		if (strcmp(name, secstrs + s->sh_name) == 0)
> +			return s;
> +	}
> +
> +	return NULL;
> +}
> +
>  #endif /* _ASM_RISCV_MODULE_H */
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 91fe16bfaa07..76f4b9c2ec5b 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -429,21 +429,6 @@ void *module_alloc(unsigned long size)
>  }
>  #endif
>  
> -static const Elf_Shdr *find_section(const Elf_Ehdr *hdr,
> -				    const Elf_Shdr *sechdrs,
> -				    const char *name)
> -{
> -	const Elf_Shdr *s, *se;
> -	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
> -
> -	for (s = sechdrs, se = sechdrs + hdr->e_shnum; s < se; s++) {
> -		if (strcmp(name, secstrs + s->sh_name) == 0)
> -			return s;
> -	}
> -
> -	return NULL;
> -}
> -
>  int module_finalize(const Elf_Ehdr *hdr,
>  		    const Elf_Shdr *sechdrs,
>  		    struct module *me)
> -- 
> 2.37.2
> 
