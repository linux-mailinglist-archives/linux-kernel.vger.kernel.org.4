Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D8A612C70
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 20:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJ3Taf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 15:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3Tad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 15:30:33 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6654AB49A;
        Sun, 30 Oct 2022 12:30:30 -0700 (PDT)
Received: from [185.156.123.69] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1opE0d-0005RB-QY; Sun, 30 Oct 2022 20:30:15 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux@armlinux.org.uk, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v1 1/2] arm: rockchip: Kconfig: remove select ARM_GLOBAL_TIMER
Date:   Sun, 30 Oct 2022 20:30:14 +0100
Message-ID: <3935573.e9J7NaK4W3@phil>
In-Reply-To: <88e93a81-ef9f-adcc-db83-f8b5ba615c47@gmail.com>
References: <88e93a81-ef9f-adcc-db83-f8b5ba615c47@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am Sonntag, 30. Oktober 2022, 19:36:01 CET schrieb Johan Jonker:
> The clocksource and the sched_clock provided by the arm_global_timer
> on Rockchip rk3066a/rk3188 are quite unstable because their rates
> depend on the cpu frequency.
> 
> Recent changes to the arm_global_timer driver makes it impossible to use.
> 
> On the other side, the arm_global_timer has a higher rating than the
> rockchip_timer, it will be selected by default by the time framework
> while we want to use the stable rockchip clocksource.
> 
> Let's disable the arm_global_timer in order to have the ROCKCHIP_TIMER
> (rk3188) or DW_APB_TIMER (rk3066a) selected by default.

Doing that change won't help you with the issue you see.
These days kernel images are supposed to run on as many
platforms as possible with the _same_ kernel image.

So the muliplatform image build from the kernel's defconfig will
include most of the time other platforms that will pull in the
global-timer again.


I do see that you disable the global-timer
in the rk3066 dtsi in patch2, though this would leave the rk3188
still using the global-timer. Why not do this in the rk3xxx.dtsi?

I.e. keep the global-timer node, but add a disabled property
together with a comment above the status=disabled, describing
the issue. [This should keep people from re-adding the global-timer
in the future :-) ]

Thanks
Heiko

> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> ARM: dts: rockchip: disable arm-global-timer for rk3188
> https://lore.kernel.org/linux-rockchip/1492374441-23336-26-git-send-email-daniel.lezcano@linaro.org/
> 
> clocksource: arm_global_timer: implement rate compensation whenever source clock changes
> https://lore.kernel.org/all/20210406130045.15491-2-andrea.merello@gmail.com/
> ---
>  arch/arm/mach-rockchip/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index b7855cc66..0432a4430 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -15,8 +15,6 @@ config ARCH_ROCKCHIP
>  	select DW_APB_TIMER_OF
>  	select REGULATOR if PM
>  	select ROCKCHIP_TIMER
> -	select ARM_GLOBAL_TIMER
> -	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
>  	select ZONE_DMA if ARM_LPAE
>  	select PM
>  	help
> --
> 2.20.1
> 
> 




