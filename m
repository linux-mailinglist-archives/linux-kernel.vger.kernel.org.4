Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140E0680754
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbjA3IWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbjA3IWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:22:45 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD14180
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 00:22:42 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qw12so13484705ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 00:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgDUPbagJ258/yYJwTe+iBI4MNIZYVSZ6ZzoNPxg3fQ=;
        b=jSp7KjkCzGj1vQKZ0uEHgGSyqnFHwGb6uCwVOYIFVF3irUcSnbFRs3RJYkoL3pbQed
         dgc0jFKouPQLyqYvawKhOrrKVEmrX90bYT7BshFZZkvaHyEtJxMJRXU8ZGWfJ+CMfy4z
         ZUELBSnWaj6unZUN81MzGnOfvWoZoFaoBuZA6dGcewgR+Im9Ukh+z9IP1FSj+3FTAdAu
         mz0n0ifzBUuWDlEBEPy+UcRNDVZdtGH0H3NprHNnzT9Z1b9FZf8qeHjc20cVD2XIXYgJ
         5kaGs0JpY9Tr+lZm2BK9tukZEyYiC5XE2/Vd52HLUaq0GDFtsYy3GyUmZiXatLWH1ERy
         bAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgDUPbagJ258/yYJwTe+iBI4MNIZYVSZ6ZzoNPxg3fQ=;
        b=UvMDd3efbzG2WVLLc1GwOdnZtErFvBPdjvMp02q5WIjLWc3ZFNqXmueC6mavBasdLj
         grJObNH4bEuYi+FRht0o5r1EuKeQkvU7a+4OIgmN57UUNW/JvvfgIRwr3QD/j4vji6X2
         NosRs9pwlVz1KkFjES08S4jkGSsl1hW5CpzZiSWYfR1irz0mfK39mK3EnhGUepz3xOSl
         jByEcRQ4RB9df2em5dpY08fGsBiE175Oyf84GAhHLLRZsxi2JJQWgDdwDF5phuyVFfpS
         qeFF8G1xmGzu3EmAI/pnJF4GAaBFVTM34NrQIrKUezYO2E2LIQQboPkWfhjUK8quvr6i
         Y2uA==
X-Gm-Message-State: AO0yUKWPISBaIxFqKe88ymEurR1XHq6Jd745T9htO9PVdHAkagzP01/N
        pAVp7DLtkd/zis/Y7sC7aLoORg==
X-Google-Smtp-Source: AK7set/TE2eXiD1YEub5PF6wQ93zAdcnZkd4hp4UQ+9ft2Lj39OoTndCc5pf4awrIzvvnfW3qKVkBA==
X-Received: by 2002:a17:906:3e49:b0:812:d53e:1084 with SMTP id t9-20020a1709063e4900b00812d53e1084mr7125067eji.70.1675066960922;
        Mon, 30 Jan 2023 00:22:40 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id b29-20020a50ccdd000000b004a21791ff18sm4412926edj.12.2023.01.30.00.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 00:22:40 -0800 (PST)
Date:   Mon, 30 Jan 2023 09:22:39 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jinyu Tang <tjytimi@163.com>
Cc:     palmer@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        yuzhao@google.com, conor.dooley@microchip.com, guoren@kernel.org,
        tongtiangen@huawei.com, anup@brainfault.org,
        akpm@linux-foundation.org, falcon@tinylab.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] riscv: support arch_has_hw_pte_young()
Message-ID: <20230130082239.xptbyeqskdczm6ns@orel>
References: <20230129064956.143664-1-tjytimi@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129064956.143664-1-tjytimi@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 02:49:56PM +0800, Jinyu Tang wrote:
> The arch_has_hw_pte_young() is false for riscv by default. If it's
> false, page table walk is almost skipped for MGLRU reclaim. And it
> will also cause useless step in __wp_page_copy_user().
> 
> RISC-V Privileged Book says that riscv have two schemes to manage A
> and D bit.
> 
> So add a config for selecting, the default is true. For simple
> implementation riscv CPU which just generate page fault, unselect it.
> 
> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> ---
>  arch/riscv/Kconfig               | 10 ++++++++++
>  arch/riscv/include/asm/pgtable.h |  7 +++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e2b656043abf..17c82885549c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -180,6 +180,16 @@ config PAGE_OFFSET
>  	default 0x80000000 if 64BIT && !MMU
>  	default 0xff60000000000000 if 64BIT
>  
> +config ARCH_HAS_HARDWARE_PTE_YOUNG
> +	bool "Hardware Set PTE Access Bit"
> +	default y
> +	help
> +	  Select if hardware set A bit when PTE is accessed. The default is
> +	  'Y', because most RISC-V CPU hardware can manage A and D bit.
> +	  But RISC-V may have simple implementation that do not support
> +	  hardware set A bit but only generate page fault, for that case just
> +	  unselect it.
> +
>  config KASAN_SHADOW_OFFSET
>  	hex
>  	depends on KASAN_GENERIC
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 4eba9a98d0e3..1db54ab4e1ba 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -532,6 +532,13 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>  	 */
>  	return ptep_test_and_clear_young(vma, address, ptep);
>  }
> +#ifdef CONFIG_ARCH_HAS_HARDWARE_PTE_YOUNG
> +#define arch_has_hw_pte_young arch_has_hw_pte_young
> +static inline bool arch_has_hw_pte_young(void)
> +{
> +	return true;
> +}
> +#endif
>  
>  #define pgprot_noncached pgprot_noncached
>  static inline pgprot_t pgprot_noncached(pgprot_t _prot)
> -- 
> 2.30.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
