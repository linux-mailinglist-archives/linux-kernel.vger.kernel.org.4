Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68902729D74
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjFIOzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241616AbjFIOyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:54:37 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41733A97;
        Fri,  9 Jun 2023 07:54:34 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-777a2ef8d45so76973039f.2;
        Fri, 09 Jun 2023 07:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686322474; x=1688914474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QL/Lam7XSRby/6zHuK8ihMzigScvLNfSZKDbqyqBYWA=;
        b=FbPcnG4GwCCrW3SGjMQjmkKU3oTjWz+33jXNW8Jmblwww0oi8S5Om8tYjl+90sTxcs
         +Qv82KCUpCvhmDnf/nxNixPjYzDxOLQn5+H1ez4EhKo1VHuX7Rh6xoktFBRvIlqfWebG
         hz8jpqqC05+ZbRy5uOQuCw8t66ML1PdbI6VDybIsaZshkswVUlVaAv6tMRuH27+vgWac
         5ejknrGRAsY77mAq6OO5BozrkvQJACh7QbrPRg/eJCvYEojhB6MEcYLfXtPb80FCpl93
         dNUS/LXkuWZXjX/qpyMKx3jdrOJQuxvf/T8E5ak4HUK7WZ4FlVaXqwD0zLCpFuYqZ4Tp
         aENw==
X-Gm-Message-State: AC+VfDzWEaj+m7LhuaUMPmQDJsxSzdwQBYD/oVnxzt30qOZfPU3uLNrE
        vkfDHBtWbYqAxWeC4vnJRQ==
X-Google-Smtp-Source: ACHHUZ5HUe2/EJqtSSvqF99Jez8LUfwrnSAZkcHuhlvuSAuxzKlXfZZXQ7vt+b4u5NJerQklab+UoQ==
X-Received: by 2002:a6b:770e:0:b0:774:9a92:f1c9 with SMTP id n14-20020a6b770e000000b007749a92f1c9mr1616726iom.19.1686322474036;
        Fri, 09 Jun 2023 07:54:34 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id d11-20020a02a48b000000b0041a9c4e0f1csm1005631jam.109.2023.06.09.07.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:54:33 -0700 (PDT)
Received: (nullmailer pid 915546 invoked by uid 1000);
        Fri, 09 Jun 2023 14:54:31 -0000
Date:   Fri, 9 Jun 2023 08:54:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] fdt: Mark "/reserved-memory" nodes as nosave if
 !reusable
Message-ID: <20230609145431.GA887298-robh@kernel.org>
References: <20230530080425.18612-1-alexghiti@rivosinc.com>
 <20230530080425.18612-2-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530080425.18612-2-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 10:04:25AM +0200, Alexandre Ghiti wrote:
> The hibernation process will access those reserved memory regions if
> they are part of the linear mapping, but as described in
> devicetree/bindings/reserved-memory/reserved-memory.yaml,
> "/reserved-memory" nodes should not be used as normal memory, unless they
> are marked as reusable which means the kernel can access it at some point.
> 
> Otherwise those regions are only used by drivers which should do what's
> necessary when the hibernation process is started, or they can contain
> the firmware reserved memory regions which should not be accessed at all.

Hibernation is only one case. Speculative accesses could also occur. I 
think some of the memory debugging stuff will walk memory as well. If 
something can't be accessed, it better have 'no-map'.

> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/setup.c |  2 +

How is this specific to Risc-V? Hint, it's not.

>  drivers/of/fdt.c          | 77 +++++++++++++++++++++++++++++++++++++++
>  include/linux/of_fdt.h    |  1 +
>  3 files changed, 80 insertions(+)
> 
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 36b026057503..642f1035b5ce 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -299,6 +299,8 @@ void __init setup_arch(char **cmdline_p)
>  	if (IS_ENABLED(CONFIG_RISCV_ISA_ZICBOM) &&
>  	    riscv_isa_extension_available(NULL, ZICBOM))
>  		riscv_noncoherent_supported();
> +
> +	early_init_fdt_nosave_reserved_mem();
>  }
>  
>  static int __init topology_init(void)
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index bf502ba8da95..863de7e6b10c 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -26,6 +26,7 @@
>  #include <linux/serial_core.h>
>  #include <linux/sysfs.h>
>  #include <linux/random.h>
> +#include <linux/suspend.h>
>  
>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>  #include <asm/page.h>
> @@ -494,6 +495,43 @@ static int __init early_init_dt_reserve_memory(phys_addr_t base,
>  	return memblock_reserve(base, size);
>  }
>  
> +/*
> + * __reserved_mem_nosave_reg() - Make all memory described in 'reg' property as
> + * nosave, unless it is "reusable".
> + */
> +static void __init __reserved_mem_nosave_reg(unsigned long node,
> +					     const char *uname)
> +{
> +	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
> +	phys_addr_t base, size;
> +	int len;
> +	const __be32 *prop;
> +	bool reusable;
> +
> +	prop = of_get_flat_dt_prop(node, "reg", &len);
> +	if (!prop)
> +		return;
> +
> +	if (len && len % t_len != 0) {
> +		pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
> +		       uname);
> +		return;
> +	}
> +
> +	reusable = of_get_flat_dt_prop(node, "reusable", NULL) != NULL;
> +
> +	while (len >= t_len) {
> +		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
> +		size = dt_mem_next_cell(dt_root_size_cells, &prop);
> +
> +		if (size && !reusable)
> +			register_nosave_region(phys_to_pfn(base),
> +					       phys_to_pfn(base + size));
> +
> +		len -= t_len;
> +	}
> +}
> +
>  /*
>   * __reserved_mem_reserve_reg() - reserve all memory described in 'reg' property
>   */
> @@ -596,6 +634,38 @@ static int __init fdt_scan_reserved_mem(void)
>  	return 0;
>  }
>  
> +/*
> + * fdt_nosave_reserved_mem() - scan a single FDT node to mark reserved memory
> + * as nosave.
> + */
> +static int __init fdt_nosave_reserved_mem(void)
> +{
> +	int node, child;
> +	const void *fdt = initial_boot_params;
> +
> +	node = fdt_path_offset(fdt, "/reserved-memory");
> +	if (node < 0)
> +		return -ENODEV;
> +
> +	if (__reserved_mem_check_root(node) != 0) {
> +		pr_err("Reserved memory: unsupported node format, ignoring\n");
> +		return -EINVAL;
> +	}
> +
> +	fdt_for_each_subnode(child, fdt, node) {
> +		const char *uname;
> +
> +		if (!of_fdt_device_is_available(fdt, child))
> +			continue;
> +
> +		uname = fdt_get_name(fdt, child, NULL);
> +
> +		__reserved_mem_nosave_reg(child, uname);
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * fdt_reserve_elfcorehdr() - reserves memory for elf core header
>   *
> @@ -649,6 +719,13 @@ void __init early_init_fdt_scan_reserved_mem(void)
>  	fdt_init_reserved_mem();
>  }
>  
> +void __init early_init_fdt_nosave_reserved_mem(void)
> +{
> +#ifdef CONFIG_HIBERNATION
> +	fdt_nosave_reserved_mem();
> +#endif
> +}
> +
>  /**
>   * early_init_fdt_reserve_self() - reserve the memory used by the FDT blob
>   */
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index d69ad5bb1eb1..55eb5a0f7305 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -63,6 +63,7 @@ extern int early_init_dt_scan_memory(void);
>  extern void early_init_dt_check_for_usable_mem_range(void);
>  extern int early_init_dt_scan_chosen_stdout(void);
>  extern void early_init_fdt_scan_reserved_mem(void);
> +extern void early_init_fdt_nosave_reserved_mem(void);
>  extern void early_init_fdt_reserve_self(void);
>  extern void early_init_dt_add_memory_arch(u64 base, u64 size);
>  extern u64 dt_mem_next_cell(int s, const __be32 **cellp);
> -- 
> 2.39.2
> 
