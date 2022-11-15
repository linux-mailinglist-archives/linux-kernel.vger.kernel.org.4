Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B0362AE5D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiKOW3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiKOW3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:29:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E23EC;
        Tue, 15 Nov 2022 14:29:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F2E761A47;
        Tue, 15 Nov 2022 22:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2875C433D6;
        Tue, 15 Nov 2022 22:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668551379;
        bh=5RTPqbqRHo17DhuTc7evD4YG3pNYusiYUpf6yFn71Rs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YAlCAat6PiIT8BfzXkVnLtXkgTT9/M6YrwN+0+km30efTdPdnaGrliKPnN0RomA61
         6NXgBR4pb2GZprFVGudycwIM8R0mh3mLUtEv4eVBwGaUMrVJy6xwsiE46FHwKQ4GgE
         1Lq7t6YSOFPkhCLELvSuQ4y3wXuYEvRc2Q1Q3sk5y7ESy7Bjv0ni/4OTBGAjnpjU2C
         EhVEEpgzX4zF5iZh9NrKysV7Sk0eX0hdVn52TAgGr5YSc7JEP5542l6jmta69gfyIw
         jKN/HHNerlPyp0px0Bx9pUZFZQaCK6OzgNoeJ1LGyjABRKYUhdYbIFuUQqSKd/3/Zg
         7StinEPGyWvow==
Date:   Tue, 15 Nov 2022 22:29:34 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>, palmer@dabbelt.com
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 8/9] RISC-V: Select APLIC and IMSIC drivers for QEMU virt
 machine
Message-ID: <Y3QSzkvV/4UvR1ME@spud>
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-9-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111044207.1478350-9-apatel@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Anup,

On Fri, Nov 11, 2022 at 10:12:06AM +0530, Anup Patel wrote:
> The QEMU virt machine supports APLIC and IMSIC emulation so let's
> select APLIC and IMSIC drivers from SOC_VIRT kconfig option.

I'm kinda torn with this as I've been trying to get rid of the selects
from the file in the first place. As Maz seems to have decided that the
SiFive plic driver is really the RISC-V plic driver - is there a reason
not to either:
- select the sifive plic at an arch level, or
- put a "default RISCV" type thing in the driver entry?

Similarly here, should we default the APLIC and IMSIC drivers to enabled
for RISCV rather than using selects?

> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/Kconfig.socs | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 69774bb362d6..c16b32eeadff 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -35,6 +35,8 @@ config SOC_VIRT
>  	select GOLDFISH
>  	select RTC_DRV_GOLDFISH if RTC_CLASS
>  	select SIFIVE_PLIC
> +	select RISCV_APLIC
> +	select RISCV_IMSIC
>  	select PM_GENERIC_DOMAINS if PM
>  	select PM_GENERIC_DOMAINS_OF if PM && OF
>  	select RISCV_SBI_CPUIDLE if CPU_IDLE && RISCV_SBI
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
