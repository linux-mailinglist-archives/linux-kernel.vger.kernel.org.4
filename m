Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F354467E480
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjA0MEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjA0MD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:03:26 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4A283978
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:58:36 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q5so4794696wrv.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AG2NHqPq2MDUFCXcsloiAHsEM2LV6SLFKyhZBS19eCI=;
        b=kncF5BzrGRAn4X6Gg3sdk0WdGgBCURzjftSUf83iGmrpia3GG3kcnjqfSg0kNq8q1W
         VH5Uq5kyYbnSJiKz6sWZxg/Kfz324t9nNc47PKEQfijXq3dFIVIupxz/7Vr0Jngh0diz
         XYyrTTi+W0t/nJ3gazNOyUm0E2cO3sVJ0MvS15fUx8+8HWyo4V0pMCqMI7by2WdM6kso
         xDd1eky4D64pAWVIdklNV2bHQN2Q3O+iJqfgwiDUUFsDIjBhJzUSEWvzaqdR1+90eNPx
         rNegK/+zwUxmGO+uKWAkBiM8g9XBBWszhpeJRy7lFU7JA1Kp3TvcPPuj5zQXkiTDgJ3y
         pH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AG2NHqPq2MDUFCXcsloiAHsEM2LV6SLFKyhZBS19eCI=;
        b=2UEmUd1KOAiTfGacYWy15uznyo4VScHBzVDntLCp18Q3Itg9ImocHumF/ct5EgrPGI
         v7F8Gr6n2oknjH46tvSjTrU3L+zbQiu3Von25WwwGXKQuRP/FBrkZD0bFotT3P4yQ9gW
         6wrazBRftJZ7fLlT19U8d3notQckoxBEqlnA0C7XFm+goKMv+BZsSszpSk4GJHfOpl2c
         L4i4iBkFNwMPwK4c9ClI0cqC/Y958eoifb5tJ/Kkne/P0aI112SSgaSUYOkKgFSX3N/j
         dYNo75mZSuxgYaktjP4xmH1S5kYJQWTiFSmMoYbkrm4uJD0a7KXZmQaZGAV7wziSgxHS
         WBxA==
X-Gm-Message-State: AFqh2kq3Q4eg9smgACvfa2GsSKCfuCNvQtbdSsRKyACcUAzexh3JJltD
        vbdJI+xHJZn+TDs4Cjx/QlK3zg==
X-Google-Smtp-Source: AMrXdXvCpk1WdOvws9od3CJ2gO4rgLLAVMW+bO35wHLbTEMIt47NsTK6FfDOkHfepTZ8st/WHB3E7g==
X-Received: by 2002:a5d:5a85:0:b0:2bd:f5df:2689 with SMTP id bp5-20020a5d5a85000000b002bdf5df2689mr37641627wrb.47.1674820641209;
        Fri, 27 Jan 2023 03:57:21 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id h1-20020adfe981000000b002bfb02153d1sm4570262wrm.45.2023.01.27.03.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:57:20 -0800 (PST)
Date:   Fri, 27 Jan 2023 12:57:14 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     guoren@kernel.org
Cc:     tongtiangen@huawei.com, alexandre.ghiti@canonical.com,
        muchun.song@linux.dev, palmer@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH -next V2] riscv: mm: hugetlb: Enable
 ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
Message-ID: <20230127115714.467ymd5cpvi5h2ey@orel>
References: <20230127050421.1920048-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127050421.1920048-1-guoren@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 12:04:21AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Add HVO support for RISC-V; see commit 6be24bed9da3 ("mm: hugetlb:
> introduce a new config HUGETLB_PAGE_FREE_VMEMMAP").

I found Documentation/mm/vmemmap_dedup.rst even more enlightening
about HVO than the commit message of 6be24bed9da3.

> This patch is
> similar to commit 1e63ac088f20 ("arm64: mm: hugetlb: enable
> HUGETLB_PAGE_FREE_VMEMMAP for arm64"), and riscv's motivation is the
> same as arm64. The current riscv was ready to enable HVO after fixup,
> ref commit d33deda095d3 ("riscv/mm: hugepage's PG_dcache_clean flag
> is only set in head page").
> 
> The HugeTLB VmemmapvOptimization (HVO) defaults to off in Kconfig.
> 
> Here is the riscv test log:
> cat /proc/sys/vm/hugetlb_optimize_vmemmap
> echo 8 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> mount -t hugetlbfs none test/ -o pagesize=2048k
> <Try some simple hugetlb test in test dir, no problem found.>
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Link: https://lore.kernel.org/linux-riscv/1F5AF29D-708A-483B-A29F-CAEE6F554866@linux.dev/
> Acked-by: Muchun Song <songmuchun@bytedance.com>
> ---
> Changelog:
> V2:
>  - Optimize the commit log
>  - Remove riscv page compound_head fixup which has been merged.
>  - Rebase on riscv for-next (20230127)
>  - Add HVO author's acked-by
> 
> V1:
> https://lore.kernel.org/linux-riscv/20221023133205.3493564-1-guoren@kernel.org/
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e2b656043abf..949974a38a41 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -46,6 +46,7 @@ config RISCV
>  	select ARCH_WANT_FRAME_POINTERS
>  	select ARCH_WANT_GENERAL_HUGETLB
>  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
> +	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>  	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
>  	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
>  	select BUILDTIME_TABLE_SORT if MMU
> -- 
> 2.36.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
