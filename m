Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F8B6F262C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 22:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjD2UH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 16:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjD2UH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 16:07:27 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA18BA
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 13:07:26 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b4e5fdb1eso1461265b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 13:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682798845; x=1685390845;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v42Z+4xBk6WHycNm2+Rc8kqKRamZqqwE3/PvX0dQE0w=;
        b=OgnDsZTo4WFQfb0mBwTGl2Gm8e4mJf0aNk/bWJH7Psec71MY6TqeuVMnPmFPb8w8A5
         f8qBiXhudFncs3+J/Z+uy6io79kLBPj/Z3Kd3qDerxomw0K2/sww4AM2rflXGJFxvAml
         yrtT9RXe7QNfdDd9MdBoiDZA2+V/STrGaF82wYQ9FmJ5iGCOzSrXCrPO+2XUPzMbjc7g
         aTaWz5IsKyIHfDiuXV06hE9WeNELTseBJVeL91qg/k7uGj/YmpWg7laHIsB1jm47JWXw
         6b7ojJJRtNKxpqOZhDNQsBuXSqYsR3yD9fYIkR58PflS49psLXtYaFTIRi35IQnStn90
         oMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682798845; x=1685390845;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v42Z+4xBk6WHycNm2+Rc8kqKRamZqqwE3/PvX0dQE0w=;
        b=fKTZD24ZyHSEApBdrbNbt1aGvt7cDP/PjRxpHjAWqatA8xYcIt+bJ2i4Ro2ylefBRh
         8qC/426YLS9A3dY3cfNv2xnhhP7RYa73kdZnI9Fbe+SjWIWxVWYWXypVcZJhFZe4Zed8
         EVuMTJIr9xeQR5YyQV+RTp3mpfs0cuwSGciOhiCMuIVDsCXLHzAhkGsCUhQnq7axwSHt
         6VQgZIVEnBpk7mNm5MHNxcWXSzrx8kONnY7djEE6K5QZQICpAbS84VK3TtPC79so4GWl
         LZl0JOYTbe0jOC91XpmEuVpq22PfWl/ZDcURTsiW+ZoreuDBUXvkTsgtaPZoYddT3e40
         U54Q==
X-Gm-Message-State: AC+VfDyUrS9vmSlMN6q4STtGcUH4+Zt6oNGYvOm08DKCTo6djha92T6V
        PNlnxOyUWhQjJlENcpEhmz1wng==
X-Google-Smtp-Source: ACHHUZ4VPcgEpESvEx+CFIa4p4XLLQVkjugt7LPssPD8v9agZo0Un2kC8oEjV0etJAxuOYWpPKiCLA==
X-Received: by 2002:a05:6a21:3a48:b0:ec:707f:7dc7 with SMTP id zu8-20020a056a213a4800b000ec707f7dc7mr9880275pzb.33.1682798845635;
        Sat, 29 Apr 2023 13:07:25 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id c24-20020a17090ad91800b0023d0d50edf2sm16662431pjv.42.2023.04.29.13.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:07:24 -0700 (PDT)
Date:   Sat, 29 Apr 2023 13:07:24 -0700 (PDT)
X-Google-Original-Date: Sat, 29 Apr 2023 13:05:52 PDT (-0700)
Subject:     Re: [PATCH 1/3] RISC-V: Add Zba extension probing
In-Reply-To: <20230428190609.3239486-2-evan@rivosinc.com>
CC:     Evan Green <evan@rivosinc.com>, aou@eecs.berkeley.edu,
        ajones@ventanamicro.com, apatel@ventanamicro.com,
        Conor Dooley <conor.dooley@microchip.com>, daolu@rivosinc.com,
        heiko.stuebner@vrull.eu, jszhang@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        sunilvl@ventanamicro.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Evan Green <evan@rivosinc.com>
Message-ID: <mhng-b5ad6600-acff-44ff-b4c0-ac22fc4f1eb0@palmer-ri-x1c9a>
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

On Fri, 28 Apr 2023 12:06:06 PDT (-0700), Evan Green wrote:
> Add the Zba address bit manipulation extension into those the kernel is
> aware of and maintains in its riscv_isa bitmap.
>
> Signed-off-by: Evan Green <evan@rivosinc.com>
> ---
>
>  arch/riscv/include/asm/hwcap.h | 1 +
>  arch/riscv/kernel/cpu.c        | 1 +
>  arch/riscv/kernel/cpufeature.c | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 9af793970855..fa36db9281ab 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -44,6 +44,7 @@
>  #define RISCV_ISA_EXT_ZIHINTPAUSE	32
>  #define RISCV_ISA_EXT_SVNAPOT		33
>  #define RISCV_ISA_EXT_ZICBOZ		34
> +#define RISCV_ISA_EXT_ZBA		35
>
>  #define RISCV_ISA_EXT_MAX		64
>  #define RISCV_ISA_EXT_NAME_LEN_MAX	32
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 3df38052dcbd..2f85b1656557 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -184,6 +184,7 @@ static struct riscv_isa_ext_data isa_ext_arr[] = {
>  	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
>  	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
>  	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> +	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
>  	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>  	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 52585e088873..1a80474e308e 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -233,6 +233,7 @@ void __init riscv_fill_hwcap(void)
>  				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
>  				SET_ISA_EXT_MAP("svnapot", RISCV_ISA_EXT_SVNAPOT);
>  				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
> +				SET_ISA_EXT_MAP("zba", RISCV_ISA_EXT_ZBA);
>  				SET_ISA_EXT_MAP("zbb", RISCV_ISA_EXT_ZBB);
>  				SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
>  				SET_ISA_EXT_MAP("zicboz", RISCV_ISA_EXT_ZICBOZ);

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
