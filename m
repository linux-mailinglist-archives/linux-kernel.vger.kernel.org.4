Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E18D640E8D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiLBTe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLBTe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:34:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90769A6074;
        Fri,  2 Dec 2022 11:34:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9136923A;
        Fri,  2 Dec 2022 11:35:01 -0800 (PST)
Received: from bogus (unknown [10.57.5.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A467B3F67D;
        Fri,  2 Dec 2022 11:34:52 -0800 (PST)
Date:   Fri, 2 Dec 2022 19:34:49 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Wang Honghui <honghui.wang@ucas.com.cn>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64/boot/dts and arm_scpi: add to support Phytium
 FT2004 CPU
Message-ID: <20221202193449.vhmta6oou7oxf7gp@bogus>
References: <0D48D1B7AC373F2F+Y4l+EOBIC9SmZD2A@TP-P15V>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0D48D1B7AC373F2F+Y4l+EOBIC9SmZD2A@TP-P15V>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 12:24:48PM +0800, Wang Honghui wrote:
> arm64/boot/dts and arm_scpi: add to support Phytium FT2004 CPU.
>

Krzysztof had commented pointing out some of the issues already. I will
skip those. I am surprised as you seem to still post patches when there
was ongoing discussions on SCPI compatibles on the other thread[1].

> Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
> ---
>  arch/arm64/Kconfig.platforms                  |   5 +
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/phytium/Makefile          |   5 +
>  .../dts/phytium/ft2004-devboard-d4-dsk.dts    |  73 +++
>  .../dts/phytium/ft2004-generic-psci-soc.dtsi  | 469 ++++++++++++++++++
>  drivers/firmware/arm_scpi.c                   |   1 +

You didn't respond with the reason for the need to use extra compatible
when you can manage with generic compatible. I still think you must not
need this change in arm_scpi as you simply can use existing compatible.
Also if you need, it needs to be separate patch, I have already pointed
out that.

> diff --git a/arch/arm64/boot/dts/phytium/ft2004-generic-psci-soc.dtsi b/arch/arm64/boot/dts/phytium/ft2004-generic-psci-soc.dtsi
> new file mode 100644
> index 000000000000..80d64e17899b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/phytium/ft2004-generic-psci-soc.dtsi
> @@ -0,0 +1,469 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dts file for FT-2000/4 SoC
> + *
> + * Copyright (C) 2018-2019, Phytium Technology Co., Ltd.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "phytium,ft2004";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		ethernet0 = &gmac0;
> +		ethernet1 = &gmac1;
> +	};
> +
> +	psci {
> +		compatible   = "arm,psci-1.0";
> +		method       = "smc";

Drop all the below properties they are needed only for v0.1. For v0.2 and
above it is fixed and don't need to be described in the DTS.

> +		cpu_suspend  = <0xc4000001>;
> +		cpu_off      = <0x84000002>;
> +		cpu_on       = <0xc4000003>;
> +		sys_poweroff = <0x84000008>;
> +		sys_reset    = <0x84000009>;
> +	};
> +
> +	cpus {
> +		#address-cells = <0x2>;
> +		#size-cells = <0x0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";

I assume this is not model and it is real platform in which case it must
have real processor compatible like "arm,cortex-a57" or whatever it is.

> +
> +		sram: sram@2a006000 {
> +			compatible = "phytium,ft2004-sram-ns","mmio-sram";
> +			reg = <0x0 0x2a006000 0x0 0x2000>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x0 0x2a006000 0x2000>;
> +
> +			scpi_lpri: scpi-shmem@0 {
> +				compatible = "phytium,ft2004-scpi-shmem";

As mentioned multiple times, use the generic compatible "arm,scp-shmem"
unless you need it for some specific reason in which case I would expect
associated changes in the driver.

> +				reg = <0x1000 0x800>;
> +			};
> +		};
> +
> +};
> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
> index 435d0e2658a4..876eb2f9ff81 100644
> --- a/drivers/firmware/arm_scpi.c
> +++ b/drivers/firmware/arm_scpi.c
> @@ -904,6 +904,7 @@ static const struct of_device_id shmem_of_match[] __maybe_unused = {
>  	{ .compatible = "amlogic,meson-axg-scp-shmem", },
>  	{ .compatible = "arm,juno-scp-shmem", },
>  	{ .compatible = "arm,scp-shmem", },
> +	{ .compatible = "phytium,ft2004-scpi-shmem", },

Drop the above if there is no other change need in the driver which means
you are compatible with std. SCPI spec and need nothing different meaning
no need for this extra compatible.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/20221201114107.2ig6pdncekzlpdq2@bogus

