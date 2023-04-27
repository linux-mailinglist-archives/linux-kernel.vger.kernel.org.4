Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F191D6F0236
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 10:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243201AbjD0IAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 04:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242868AbjD0IAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:00:52 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B834D1B6;
        Thu, 27 Apr 2023 01:00:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 319BD80A4;
        Thu, 27 Apr 2023 08:00:51 +0000 (UTC)
Date:   Thu, 27 Apr 2023 11:00:49 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Udit Kumar <u-kumar1@ti.com>
Cc:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, m-chawdhry@ti.com, n-francis@ti.com
Subject: Re: [PATCH 1/5] arm64: dts: ti: k3-j7200: Add general purpose timers
Message-ID: <20230427080049.GH14287@atomide.com>
References: <20230426103219.1565266-1-u-kumar1@ti.com>
 <20230426103219.1565266-2-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426103219.1565266-2-u-kumar1@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Udit Kumar <u-kumar1@ti.com> [230426 10:38]:
> There are 20 general purpose timers on j7200 that can be used for things
> like PWM using pwm-omap-dmtimer driver. There are also additional ten
> timers in the MCU domain.
...

> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index 331b4e482e41..1c09e442b379 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -34,6 +34,126 @@ k3_reset: reset-controller {
>  		};
>  	};
>  
> +	mcu_timer0: timer@40400000 {
> +		compatible = "ti,am654-timer";
> +		reg = <0x00 0x40400000 0x00 0x400>;
> +		interrupts = <GIC_SPI 816 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 35 1>;
> +		clock-names = "fck";
> +		assigned-clocks = <&k3_clks 35 1>;
> +		assigned-clock-parents = <&k3_clks 35 2>;
> +		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
> +		ti,timer-pwm;
> +	};

Oh so also the MCU timers now have interrupts, nice. Can you please check
if what we have in the comments the other SoCs in the dtsi files for MCU
timers not having routable interrupts is correct?

Also, should the MCU timers be still tagged with status = "reserved"?

See the comments in k3-am62-mcu.dtsi for example for both questions.

Regards,

Tony
