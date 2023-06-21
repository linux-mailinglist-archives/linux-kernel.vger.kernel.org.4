Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9372739392
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjFVAKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjFVAKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:10:15 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C28C2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:10:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b51414b080so38771445ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687392607; x=1689984607;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mc4fpIkxrmWFX77cuCPTRDrtxqTugNNR8tCOrUF27gs=;
        b=C8B1vtlPll32edOWojj5xYY/mysKxmH0KcDH0IMNPBiQmP1y8ZQ2vxUdcbLo20jpOh
         HxoupZR/BRBmpes+fYctj+Z/0grfYdi5s/OxwLd+aO5Y9GEKhvuEp1m6vXFhbRiiKZt9
         fes9KO0UhH8i2XYPMbeZq2QOLpeWG+yupcJX0qCfHcyJY/M42vw7iKBWcgHsf5JhSs+S
         CZiTL6uJpQvNmfDzVl588IPYk33bhNacC03OEA92hsA3YaRvvP9PjQzILKpzrbDNlXA1
         4cpd22jujSNuv7pgqYWUnAL0R4q1eQnd9lvvz7UJkdyzHbnzn3gDbYiJZH7yhzgidpp0
         2bYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687392607; x=1689984607;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mc4fpIkxrmWFX77cuCPTRDrtxqTugNNR8tCOrUF27gs=;
        b=DMfX9ITN7zx/XLzqTlHseav8rnsZmgxpWm3oGfP30o9z3BP+lS/H0KHPT9ue7rFD0A
         uRvxCE2XgfdowbA2zHnq6Ae5IrO599WiutL+7P+20WeAUz6ddJsZKUQKjJXuzPMYwzfw
         ZjuseS3Qq+urKT4aD6737+D/0X/PNB5nldxq4DpGJpc/g0KkSmgmdxiix+OIZEf8m4Wr
         k62l6HOEaNkmDwOFhIbtmJcmDRXwaujLSCdhRUXR9PZZHuRHT74Eb/5eqC6jl9cK0c4M
         9wQ8ec727vGlhF2srU8UVGgJjT720kLWyQSew4RkHuXYmEAQekwvnvZRHROMhLNETg8s
         /ddA==
X-Gm-Message-State: AC+VfDxd0dbpNshEw8i26Cp7xo+q8sxCDBDywCwav577RG1JxKpwogUb
        62WY075CtLlzqE9L7inciHr8ENCmNXn7HJNnwhs=
X-Google-Smtp-Source: ACHHUZ5X0a/eiR5H1ppvpN4jE+a/znwL58JjJPGOLiHuqaFtHFz3LZk9cOq6Vs4tx9xfHwMLmSsgOQ==
X-Received: by 2002:aca:2b05:0:b0:39d:5610:b779 with SMTP id i5-20020aca2b05000000b0039d5610b779mr17396238oik.49.1687391819292;
        Wed, 21 Jun 2023 16:56:59 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id p14-20020a63e64e000000b005533c53f550sm3654119pgj.45.2023.06.21.16.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 16:56:58 -0700 (PDT)
Date:   Wed, 21 Jun 2023 16:56:58 -0700 (PDT)
X-Google-Original-Date: Wed, 21 Jun 2023 16:56:18 PDT (-0700)
Subject:     Re: [PATCH 3/7] riscv: mm: Refactor create_linear_mapping_range() for hot add
In-Reply-To: <20230512145737.985671-4-bjorn@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, Bjorn Topel <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, david@redhat.com,
        osalvador@suse.de, virtualization@lists.linux-foundation.org,
        linux@rivosinc.com, alexghiti@rivosinc.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     bjorn@kernel.org
Message-ID: <mhng-ec7e2bae-2eb8-45c5-b7e4-bc2a931760df@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023 07:57:33 PDT (-0700), bjorn@kernel.org wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
>
> Add a parameter to the direct map setup function, so it can be used in
> arch_add_memory() later.
>
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>  arch/riscv/mm/init.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index e974ff6ef036..aea8ccb3f4ae 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1247,18 +1247,19 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  	pt_ops_set_fixmap();
>  }
>
> -static void __init create_linear_mapping_range(phys_addr_t start,
> -					       phys_addr_t end)
> +static void __meminit create_linear_mapping_range(phys_addr_t start, phys_addr_t end,
> +						  struct mhp_params *params)

Sorry if I missed a v2, but it looks like this fails to build under 
CONFIG_MEMORY_HOTPLUG=n (as struct mhp_params isn't defined) -- unless I 
screwed up some merge conflict, but doesn't look like it here.

I'm getting

      CC      arch/riscv/mm/init.o
    arch/riscv/mm/init.c:1252:58: warning: ‘struct mhp_params’ declared inside parameter list will not be visible outside of this definition or declaration
     1252 |                                                   struct mhp_params *params)
          |                                                          ^~~~~~~~~~
    arch/riscv/mm/init.c: In function ‘create_linear_mapping_range’:
    arch/riscv/mm/init.c:1261:42: error: invalid use of undefined type ‘struct mhp_params’
     1261 |                 pgprot =  params ? params->pgprot : pgprot_from_va(va);
          |                                          ^~
    make[3]: *** [scripts/Makefile.build:252: arch/riscv/mm/init.o] Error 1
    make[2]: *** [scripts/Makefile.build:494: arch/riscv/mm] Error 2
    make[1]: *** [scripts/Makefile.build:494: arch/riscv] Error 2
    make: *** [Makefile:2026: .] Error 2

patchwork is saying something similar
<https://gist.github.com/conor-pwbot/9ed9a564e63d824aed1786050ee06558>.

>  {
>  	phys_addr_t pa;
>  	uintptr_t va, map_size;
>
>  	for (pa = start; pa < end; pa += map_size) {
> +		pgprot_t pgprot;
> +
>  		va = (uintptr_t)__va(pa);
> +		pgprot =  params ? params->pgprot : pgprot_from_va(va);
>  		map_size = best_map_size(pa, end - pa);
> -
> -		create_pgd_mapping(swapper_pg_dir, va, pa, map_size,
> -				   pgprot_from_va(va));
> +		create_pgd_mapping(swapper_pg_dir, va, pa, map_size, pgprot);
>  	}
>  }
>
> @@ -1288,13 +1289,12 @@ static void __init create_linear_mapping_page_table(void)
>  		if (end >= __pa(PAGE_OFFSET) + memory_limit)
>  			end = __pa(PAGE_OFFSET) + memory_limit;
>
> -		create_linear_mapping_range(start, end);
> +		create_linear_mapping_range(start, end, NULL);
>  	}
>
>  #ifdef CONFIG_STRICT_KERNEL_RWX
> -	create_linear_mapping_range(ktext_start, ktext_start + ktext_size);
> -	create_linear_mapping_range(krodata_start,
> -				    krodata_start + krodata_size);
> +	create_linear_mapping_range(ktext_start, ktext_start + ktext_size, NULL);
> +	create_linear_mapping_range(krodata_start, krodata_start + krodata_size, NULL);
>
>  	memblock_clear_nomap(ktext_start,  ktext_size);
>  	memblock_clear_nomap(krodata_start, krodata_size);
