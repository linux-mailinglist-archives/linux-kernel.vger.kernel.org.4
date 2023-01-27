Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFDA67E39C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjA0Lkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbjA0Lkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:40:37 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146D2AD18
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:40:18 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id m15so3226809wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VhHXDO0wp4WFhLB5jJ+XJyRE81IMQ1jPd64bS/JNVtw=;
        b=R3RcqREAaPy27gMaNOjmRDp1PnFAXxmvcD/HG+D3KLMFxTnaG2dZP6duyG4ToXgMG2
         7Uieqf9lgNGdRWbav6towxYFctjIVJJNmb3P0J0dp19NRiG393tggEh8K56Kzc3qePOZ
         AqgrF7DKftDqdkRfyKbAJnkOy56fYWGDN14lOGk/SFjvulGrrgb9K+GmSwRwHv4sb0v8
         rn6mHpYjSv87d3ePo5sF+05x8RIPW8RVW3jE2Hld1kNKSE7kytt2Fz6ZCkC1pbVJ58IF
         XHe/NspeUCbT/L7j2ID1sqZ8A+WhGXa+NooAwgCRQxd5dCgmkbmQUUSkgQHuKBIkHDAQ
         Cstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhHXDO0wp4WFhLB5jJ+XJyRE81IMQ1jPd64bS/JNVtw=;
        b=I2mmryH+rI5aCcjcrJUdNFfcxhOiNC17a/uvtc/jIt+At7ZrDa+XrqaDKN+sXXJnRq
         O+Aq8POSsBtOfpyM/vgZXGoYn3MT1TGQkCG8tFbTbMZAUgBOxoPkHFRSqxr5SsOKkPwX
         tUxJ5OTcn3zw03FqAISQ7zgHz3yrHG9MGeEUTEwKoLfdqkyVxpuBycP/N42Rcz9dwxGh
         plSyLPJoZeTnA/iAjhm2F2wtpbZXM4hc3YjOklgGl9PsmyBTI52a9PwnnBvkc6RUhcnR
         vv6Zm5AU13D1eFEBfZBPSd0xJrlNcQ7qFPTvwN+eu5tNYMnCbMRhztvixweta1a2UwC0
         O7Hg==
X-Gm-Message-State: AO0yUKU9isZn5HLKirp1TJsVO9mNA/7TRta//dlylt0anneplQvuAZUN
        UOU6nzRMAf5UMTa30kMsSaDg9g==
X-Google-Smtp-Source: AK7set//e1VB1XgBNyNFLJoVGSf6wvCiQnsDQLCLfZCI7Mjakx2lmPSArWetRLjN1Ih+le3qs+noXA==
X-Received: by 2002:a05:600c:b56:b0:3dc:353c:8b37 with SMTP id k22-20020a05600c0b5600b003dc353c8b37mr2210043wmr.3.1674819292761;
        Fri, 27 Jan 2023 03:34:52 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id b32-20020a05600c4aa000b003db0cab0844sm3956369wmp.40.2023.01.27.03.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:34:52 -0800 (PST)
Date:   Fri, 27 Jan 2023 12:34:51 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, conor.dooley@microchip.com,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        mark.rutland@arm.com, bjorn@kernel.org, tongtiangen@huawei.com,
        andrew@sifive.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2] riscv: Fixup race condition on PG_dcache_clean in
 flush_icache_pte
Message-ID: <20230127113451.ltx2l7u2a355qrde@orel>
References: <20230127035306.1819561-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127035306.1819561-1-guoren@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 10:53:06PM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> In commit 588a513d3425 ("arm64: Fix race condition on PG_dcache_clean
> in __sync_icache_dcache()"), we found RISC-V has the same issue as the
> previous arm64. The previous implementation didn't guarantee the correct
> sequence of operations, which means flush_icache_all() hasn't been
> called when the PG_dcache_clean was set. That would cause a risk of page
> synchronization.
> 
> Fixes: 08f051eda33b ("RISC-V: Flush I$ when making a dirty page executable")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
> Changelog:
> V2:
>  - Optimize commit log
>  - Rebase on riscv for-next (20230127)
> 
> V1:
> https://lore.kernel.org/linux-riscv/20221023133205.3493564-2-guoren@kernel.org/
> ---
>  arch/riscv/mm/cacheflush.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 3cc07ed45aeb..fcd6145fbead 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -90,8 +90,10 @@ void flush_icache_pte(pte_t pte)
>  	if (PageHuge(page))
>  		page = compound_head(page);
>  
> -	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
> +	if (!test_bit(PG_dcache_clean, &page->flags)) {
>  		flush_icache_all();
> +		set_bit(PG_dcache_clean, &page->flags);
> +	}
>  }
>  #endif /* CONFIG_MMU */
>  
> -- 
> 2.36.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
