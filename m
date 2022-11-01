Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A23614683
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiKAJTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKAJTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:19:47 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D9AE07
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 02:19:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sc25so35459666ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 02:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VxyvqSqVgdx1tQ7y6vR7H8NyGf0tUg17P1dTi6A/S0o=;
        b=GhJRea2K0caG3PjN23EC9YGProjYnt8XRg9G98FhXcGu73m45ADaTnlZ+O8DMYtoRT
         0+9omFzWgO4xMFB8T1gh+ZYJsZB33pILRILOXX1F5jORf4izfFmpAHcuORXKnW6QEVTX
         ccK+La+6+MQ8ovXI342wiOV0RfOZvPu9XdSfrGLc0GApZHwbrDcnFDyEp6KS9AhaPVv0
         5y9J4A0Pig2nXrOJzXWJ9oppaJOf03fqJ5vcKTsc5+126tFy101sCjmT3qRRm2Acs8fs
         gqZdVLuLUWdxWU3FEW2RUAqqWJ+gELrsVy05k/iUEdSAR8CVpr5mx2XHa5jGZgzc5fmR
         jfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxyvqSqVgdx1tQ7y6vR7H8NyGf0tUg17P1dTi6A/S0o=;
        b=1260DhkvehJNAYVgBfU3syHezdDmGCcJ/st3cilt49hKJtur8qV4PkGCtT5MP2SK5j
         Cq4O8IUKDI/aFGzkcPRZ8bEKjg2slCFHUmkBnuU0LA5YViwIUoLW9IKgtnPYupSJFiBi
         gwOtyg4YYKAtwAxNw/g/jX1JybbSq6jIFopwqktOXOw0kvG2J/bCST2MSCUTlBtUddqG
         DA19uoivIT/XSrY2vSHxP+kcalYSJUAIcyi+9fkyyHP5S5+Es4aGgOFjhL4xjRx7ImZ2
         KE4PPl4bGe4JfSp0tYDhdwK0o8mgfbvTVJqJZNTJ2ScRGOm5sp55wRenYwtmJTDYeIXl
         hQCg==
X-Gm-Message-State: ACrzQf0jxhZtBwsme+GBIqSyvtI1eM3Gztj1hV103B8Td2O2FnD94Qhd
        rnEdCEilvnLCPx1Rk0WTASZqLCPlpJBLhQ==
X-Google-Smtp-Source: AMsMyM6UmB2jz1VDu1dYoDIP9ZILO6Mqj1ZOS0mAf+fYqBqMX0BKVoXgTTu1f1ISVXGj7HOslRSU5g==
X-Received: by 2002:a17:906:99c1:b0:6fe:b01d:134 with SMTP id s1-20020a17090699c100b006feb01d0134mr17069970ejn.598.1667294384105;
        Tue, 01 Nov 2022 02:19:44 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id x25-20020aa7d399000000b0045c010d0584sm4238587edq.47.2022.11.01.02.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 02:19:43 -0700 (PDT)
Date:   Tue, 1 Nov 2022 10:19:42 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] riscv: vdso: fix section overlapping under some
 conditions
Message-ID: <20221101091942.k7pgcbbkudgjk4ae@kamzik>
References: <20221031175842.1699-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031175842.1699-1-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 01:58:42AM +0800, Jisheng Zhang wrote:
> lkp reported a build error, I tried the config and can reproduce
> build error as below:
> 
>   VDSOLD  arch/riscv/kernel/vdso/vdso.so.dbg
> ld.lld: error: section .note file range overlaps with .text
> >>> .note range is [0x7C8, 0x803]
> >>> .text range is [0x800, 0x1993]
> 
> ld.lld: error: section .text file range overlaps with .dynamic
> >>> .text range is [0x800, 0x1993]
> >>> .dynamic range is [0x808, 0x937]
> 
> ld.lld: error: section .note virtual address range overlaps with .text
> >>> .note range is [0x7C8, 0x803]
> >>> .text range is [0x800, 0x1993]
> 
> Fix it by removing the hardcoding 0x800 and related comments.
> 
> Link: https://lore.kernel.org/lkml/202210122123.Cc4FPShJ-lkp@intel.com/#r
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/vdso/vdso.lds.S | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
> index 01d94aae5bf5..344209d2e128 100644
> --- a/arch/riscv/kernel/vdso/vdso.lds.S
> +++ b/arch/riscv/kernel/vdso/vdso.lds.S
> @@ -31,13 +31,7 @@ SECTIONS
>  
>  	.rodata		: { *(.rodata .rodata.* .gnu.linkonce.r.*) }
>  
> -	/*
> -	 * This linker script is used both with -r and with -shared.
> -	 * For the layouts to match, we need to skip more than enough
> -	 * space for the dynamic symbol table, etc. If this amount is
> -	 * insufficient, ld -shared will error; simply increase it here.
> -	 */
> -	. = 0x800;

Hi Jisheng,

Removing this hard coded value is a good thing, but I don't understand
why, if it was necessary before, that it's no longer necessary. Can you
please explain that in the commit message? If the linker improved in
this regard, then do we need to document a new minimum linker version?

> +	. = ALIGN(16);

Aligning text to a 4-byte boundary makes sense to me, but I don't
understand the 16-byte boundary requirement. Can you please explain
this for my education?

Thanks,
drew

>  	.text		: { *(.text .text.*) }		:text
>  
>  	.data		: {
> -- 
> 2.37.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
