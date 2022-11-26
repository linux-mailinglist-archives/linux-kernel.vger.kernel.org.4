Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085236396C8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 16:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiKZPcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 10:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKZPcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 10:32:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FBB1CFD2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 07:32:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 140A760B85
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 15:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9ECAC433C1;
        Sat, 26 Nov 2022 15:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669476728;
        bh=2h++QTrAorI59jH3iOzNiOX8uGhWbeZh9J4UkZ1FyzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XTiCoNiFxstsiQ35EmguH3iWYVBEe3apPBSsTx3XhGaH6OEnPLE73OcRJDA1TFzzf
         3G5xP1gC1z9cmAtNIgerhIblRAmPkHDOEfr4XGBzsz9+8BJWW71+71cyduG14ubOxd
         iCjl6S0MQL2qWIUHflM/amzUvTLsZ/cGBhxbcpX+vX/OprEHM+0sAaQzfeQ84oHdDS
         tDsZRQvY7SkerNjM6DL9/uAsielxGaDuroSK6k4R262+5K97gDO3EmRQs8R7w7ecn6
         v/bNBy13uGUtaRaStBGxFq5x3XvB9HBVG2BBSggNAfOrVMhWRPinZjUx0rrQ3To5Je
         3E/eQnnf9MgOA==
Date:   Sat, 26 Nov 2022 15:32:04 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: Fix NR_CPUS range conditions
Message-ID: <Y4IxdOPWhLLg5rwd@spud>
References: <20221126061557.3541-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221126061557.3541-1-samuel@sholland.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 12:15:56AM -0600, Samuel Holland wrote:
> The conditions reference the symbol SBI_V01, which does not exist. The
> correct symbol is RISCV_SBI_V01.

Huh, good spot.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> 
> Fixes: e623715f3d67 ("RISC-V: Increase range and default value of NR_CPUS")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  arch/riscv/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index fec54872ab45..acbfe34c6a00 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -319,9 +319,9 @@ config SMP
>  config NR_CPUS
>  	int "Maximum number of CPUs (2-512)"
>  	depends on SMP
> -	range 2 512 if !SBI_V01
> -	range 2 32 if SBI_V01 && 32BIT
> -	range 2 64 if SBI_V01 && 64BIT
> +	range 2 512 if !RISCV_SBI_V01
> +	range 2 32 if RISCV_SBI_V01 && 32BIT
> +	range 2 64 if RISCV_SBI_V01 && 64BIT
>  	default "32" if 32BIT
>  	default "64" if 64BIT
>  
> -- 
> 2.37.4
> 
