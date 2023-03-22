Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0116C4AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCVMrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjCVMrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:47:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EE34FF12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:46:34 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id cn12so26779243edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1679489193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W5zKbHjfhgxF54RZN2uMVwaO/XV5lTFGogMg3VcS9Gw=;
        b=AeU+V10ihje21KzHVT78gOrQJ9YQxfOvj599aKQERL00BRKdGiTV8EFqv73faU5f45
         Fykh774S7V9G71lAC4TEFQ3HxDIx1EQ0Bqm7flYXZj5iFo/nVULYw3meaxbOoELkiojq
         x6V2dlejM6itF7F200uRTOvDwFd2eADEDVVJQOGEDaaATvRx85pcmbviAKnRrBPTx/uB
         AOeK7cGNMBKW8ICWJsqaSKxaLc9PvuyaYQwOUVTTIsqorPS2qGnQzXmY9wNn92vowMA3
         VTqRv2AOet1xNuUY4essauv5cZLbIYJmk2Tv9HaJt7ImatZVWYQ3DaircOALrij8nlol
         2Vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679489193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5zKbHjfhgxF54RZN2uMVwaO/XV5lTFGogMg3VcS9Gw=;
        b=OIv/S/49t7wotHevcVZx1detcBXoxDRl+pPCIlX5A2gnDtjDVs9GWowTAf+snG1Dby
         BFHIfDl3Vvuh3qNOTw02uh4cGafZZmzuf8eopyFp1xPJAJ/dpighTEV8N2YxHgpwqKpc
         rlX+3b2hCn9glgvf3I2R93Fw+0K0VqCXa0M69LeXP4zdWhTlh7AOJ0HT6dlJYZ4MafEa
         Z2+1U/LDEjTsSbDaNRImX2EsoWwgq1Q2eBSmEGXFgIUk9kN+l1iqgRbVDQLpYHcsz2mR
         tPOFimQALFjC03N4FZxz/qrYhuc65FpvHmfhOncQTRsNm3RM+BXrHTf/IWdNDFcszSER
         estA==
X-Gm-Message-State: AO0yUKXCJrB7JrwNuIGoxpOqUR5qDF2Mzv/BidA7d0vINORVUbYZccsB
        t2Bnyhr3RCKuChSMm3s52CT6Ew==
X-Google-Smtp-Source: AK7set+gJyx2poiD3sfTmwA9axJroFF1RhsQFBXaCqd0DtnPZi3yDlC8QBiTKtp9e6oeJC2EllLOww==
X-Received: by 2002:a05:6402:48c:b0:4fa:ad62:b1a0 with SMTP id k12-20020a056402048c00b004faad62b1a0mr5882545edv.41.1679489193201;
        Wed, 22 Mar 2023 05:46:33 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id c25-20020a50f619000000b004bd6e3ed196sm7761962edn.86.2023.03.22.05.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 05:46:32 -0700 (PDT)
Date:   Wed, 22 Mar 2023 13:46:31 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        regressions@leemhuis.info, regressions@lists.linux.dev
Subject: Re: [PATCH] riscv: require alternatives framework when selecting FPU
 support
Message-ID: <20230322124631.7p67thzeblrawsqj@orel>
References: <ZBruFRwt3rUVngPu@zx2c4.com>
 <20230322120907.2968494-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322120907.2968494-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 01:09:07PM +0100, Jason A. Donenfeld wrote:
> When moving switch_to's has_fpu() over to using riscv_has_extension_
> likely() rather than static branchs, the FPU code gained a dependency on
> the alternatives framework. If CONFIG_RISCV_ALTERNATIVE isn't selected
> when CONFIG_FPU is, then has_fpu() returns false, and switch_to does not
> work as intended. So select CONFIG_RISCV_ALTERNATIVE when CONFIG_FPU is
> selected.
> 
> Fixes: 702e64550b12 ("riscv: fpu: switch has_fpu() to riscv_has_extension_likely()")
> Link: https://lore.kernel.org/all/ZBruFRwt3rUVngPu@zx2c4.com/
> Cc: Jisheng Zhang <jszhang@kernel.org>
> Cc: Andrew Jones <ajones@ventanamicro.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index c5e42cc37604..0f59350c699d 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -467,6 +467,7 @@ config TOOLCHAIN_HAS_ZIHINTPAUSE
>  config FPU
>  	bool "FPU support"
>  	default y
> +	select RISCV_ALTERNATIVE
>  	help
>  	  Say N here if you want to disable all floating-point related procedure
>  	  in the kernel.
> -- 
> 2.40.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

I took a look to see if we missed anything else and see that we should
do the same patch for KVM. I'll send one.

(It's tempting to just select RISCV_ALTERNATIVE from RISCV, but maybe we
 can defer that wedding a bit longer.)

Thanks,
drew
