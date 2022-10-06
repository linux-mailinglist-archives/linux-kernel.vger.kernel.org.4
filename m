Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A175F6771
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiJFNKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiJFNKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:10:36 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B391AE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 06:10:35 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id u21so2720469edi.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 06:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2j3ygm+GSrR/kLyqMDlbC2b6qASfbfMJleAyszzEGTQ=;
        b=ZWBM0uCbPzhrgCjdFK9EkQwJqNvxYkgf9YOIb49x/8b1QImU3eoQXh4wYwySagDVTm
         l2ZLhv0Lwy5tsjO5rjnh3St9a+dAaV63QCzT7hHuP0ndum9zqBYnUfCxag8++A+58MPI
         BFYO0srN5xxVxCKPBm1QUpquGIeplt9d19LH2RqXnLGg8qQxY3f1oNEr+6Nj5kxas9bq
         wF5klqgjVKxSYqKN43EDfXcqvSZAfgNIZe7TlFGKnjS05ivFwK9NgSq3Zk03k4Drw716
         C5aq5G2DerEiPeBLf24HmIwi16MSW0K5Xqb/HAkspomYZhgb+ukcBzI9PlP95oYM6rwM
         umZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2j3ygm+GSrR/kLyqMDlbC2b6qASfbfMJleAyszzEGTQ=;
        b=SQVaq1GgQvymKPVIO+4DNHmRXr4qqDTSLnyZk/MfwdXiH2kzpkhHzmE8mqg/YbAR4x
         meZd3sYyPAV8augsiI/COooEKZZ1IjtMs1+sDATrOTOq6cTtG8RYnor+UWx7ZM730X/K
         pthACxiVe/UN+lq28rFWzyzdVJAZCCWazC91RxT1hgIOkMYKFByBAOWgMyK9xYQK7x9s
         nRgFCeghk8FGwGiM7/WGazi8kb9/rtsqBycb1yE+H6c2SMwBFAc38KEVnWrsDTwOqZlT
         KayRO2TQ+figeepSLCYuxdf5AEce7Glg0o9sFZX3X3X2Yxo8DVlwiW0vvsRNd1snrcFJ
         ul3g==
X-Gm-Message-State: ACrzQf3ZuruPFzwjzaWg80u/N7nEFvFjzp2UgHW0MOb1kiyLvdEtdyFN
        KxPrOtaax/L3/1zeApTY4wNMng==
X-Google-Smtp-Source: AMsMyM5ssASFggd3BrLF/QiCZwS2iMg5YlzHPO9Ef9AWdzNL9idpBus68/QMYchoiXaaJ2f65IbkAA==
X-Received: by 2002:a05:6402:2949:b0:451:fabf:d88a with SMTP id ed9-20020a056402294900b00451fabfd88amr4461739edb.324.1665061834369;
        Thu, 06 Oct 2022 06:10:34 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id d1-20020a056402144100b00456f2dbb379sm2606754edx.62.2022.10.06.06.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:10:34 -0700 (PDT)
Date:   Thu, 6 Oct 2022 15:10:33 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] riscv: move riscv_noncoherent_supported() out of
 ZICBOM probe
Message-ID: <20221006131033.jfb62me2zxz67gfs@kamzik>
References: <20221006070818.3616-1-jszhang@kernel.org>
 <20221006070818.3616-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006070818.3616-2-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 03:08:11PM +0800, Jisheng Zhang wrote:
> It's a bit wired to call riscv_noncoherent_supported() once when

s/wired/weird/

s/once/each time/

> insmod a module. Move the calling out of feature patch func.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/cpufeature.c | 7 +------
>  arch/riscv/kernel/setup.c      | 4 ++++
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 3b5583db9d80..03611b3ef45e 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -272,12 +272,7 @@ static bool __init_or_module cpufeature_probe_zicbom(unsigned int stage)
>  	case RISCV_ALTERNATIVES_EARLY_BOOT:
>  		return false;
>  	default:
> -		if (riscv_isa_extension_available(NULL, ZICBOM)) {
> -			riscv_noncoherent_supported();
> -			return true;
> -		} else {
> -			return false;
> -		}
> +		return riscv_isa_extension_available(NULL, ZICBOM);
>  	}
>  #endif
>  
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 2dfc463b86bb..1a055c3f5d9d 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -299,6 +299,10 @@ void __init setup_arch(char **cmdline_p)
>  	riscv_init_cbom_blocksize();

I think we can move this riscv_init_cbom_blocksize() down to be above the
new #ifdef in order to keep like calls grouped. It doesn't matter though.

>  	riscv_fill_hwcap();
>  	apply_boot_alternatives();
> +#ifdef CONFIG_RISCV_DMA_NONCOHERENT
> +	if (riscv_isa_extension_available(NULL, ZICBOM))
> +		riscv_noncoherent_supported();
> +#endif
>  }
>  
>  static int __init topology_init(void)
> -- 
> 2.37.2

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
