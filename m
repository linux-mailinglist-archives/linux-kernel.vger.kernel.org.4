Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADED693371
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 21:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBKUBp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 11 Feb 2023 15:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBKUBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 15:01:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45F1A166C4;
        Sat, 11 Feb 2023 12:01:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D64E4B3;
        Sat, 11 Feb 2023 12:02:16 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D34683F71E;
        Sat, 11 Feb 2023 12:01:30 -0800 (PST)
Date:   Sat, 11 Feb 2023 19:59:31 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Andreas Feldner <pelzi@flying-snail.de>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: sunxi: set minimal debounce on input-debounce
 0
Message-ID: <20230211195931.5f1b2abb@slackpad.lan>
In-Reply-To: <200d4457-9801-c862-0e86-850e3188f765@flying-snail.de>
References: <Y+FaVorMl37F5Dve@debian-qemu.internal.flying-snail.de>
        <20230207011608.2ce24d17@slackpad.lan>
        <d0534762-3785-ec2d-8d1e-aba0e39f701b@feldner-bv.de>
        <20230209202952.673d5a60@slackpad.lan>
        <20230210082936.qefzz4fsp3jpalvp@houat>
        <20230210094425.474cfba5@donnerap.cambridge.arm.com>
        <20230210100620.z6j7rvkiwyu7paij@houat>
        <20230210101814.2d36ae57@donnerap.cambridge.arm.com>
        <ba463d40-3d39-a621-b198-191fdbe239a1@feldner-bv.de>
        <20230211151358.3467b4f9@slackpad.lan>
        <200d4457-9801-c862-0e86-850e3188f765@flying-snail.de>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Feb 2023 19:08:32 +0100
Andreas Feldner <pelzi@flying-snail.de> wrote:

Hi Andreas,

thanks for putting this together!

> sunxi-h3-h5 based boards have no support for switching
> off IRQ debouncing filter. This would be the expected
> behaviour of value 0 for the general pinctl parameter
> input-debounce.
> The current driver implementation ignores value 0
> for input-debounce, leaving the chip's default. This
> default, however, is not minimal, but equivalent to
> value 31 (microseconds).
> 
> This patch does not ignore value 0 but instead makes
> sure the corresponding IRQ debounce filter is set
> to the shortest time selectable, i. e. the fast
> oscillator with a divider of 1 == (2 ^ 0).
> 
> The current default behaviour is explicitly ensured
> by including input-debounce=<31 31> in the relevant
> part of the devicetree.

The actual change looks alright to me, just some general comments:
- Please don't post new patches as replies to existing threads. Even a
  new revision of a previously posted series is a new thread.
- Your patch is whitespace deformed (no tabs, just spaces). This makes
  it impossible to apply without doing it manually. Your original patch
  was fine in this regard, not sure what you changed. In general it's
  recommended to use git send-email. For a simple patch it might be
  feasible to craft the email in a client (ideally by using an
  external editor), but make sure that it still applies. Sending to
  yourself first helps.
- You cannot mix DT changes and code changes in one patch, they have to
  be in separate patches. The DT change also brings up the question why
  this would be specific to H3/H5, I think this applies to virtually
  every Allwinner SoC.

Cheers,
Andre

> 
> Fixes: 7c926492d38a ("pinctrl: sunxi: Add support for interrupt debouncing")
> 
> Signed-off-by: Andreas Feldner <pelzi@flying-snail.de>
> ---
>   arch/arm/boot/dts/sunxi-h3-h5.dtsi    |  1 +
>   drivers/pinctrl/sunxi/pinctrl-sunxi.c | 40 +++++++++++++++------------
>   2 files changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi 
> b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index 686193bd6bd9..e9ed4948134d 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -410,6 +410,7 @@ pio: pinctrl@1c20800 {
>               #gpio-cells = <3>;
>               interrupt-controller;
>               #interrupt-cells = <3>;
> +            input-debounce = <31 31>;
> 
>               csi_pins: csi-pins {
>                   pins = "PE0", "PE2", "PE3", "PE4", "PE5",
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c 
> b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index f35179eceb4e..6798c8f4067e 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -1444,29 +1444,35 @@ static int sunxi_pinctrl_setup_debounce(struct 
> sunxi_pinctrl *pctl,
>           if (ret)
>               return ret;
> 
> -        if (!debounce)
> -            continue;
> -
> -        debounce_freq = DIV_ROUND_CLOSEST(USEC_PER_SEC, debounce);
> -        losc_div = sunxi_pinctrl_get_debounce_div(losc,
> -                              debounce_freq,
> -                              &losc_diff);
> -
> -        hosc_div = sunxi_pinctrl_get_debounce_div(hosc,
> -                              debounce_freq,
> -                              &hosc_diff);
> -
> -        if (hosc_diff < losc_diff) {
> -            div = hosc_div;
> -            src = 1;
> +        if (debounce) {
> +            debounce_freq = DIV_ROUND_CLOSEST(USEC_PER_SEC, debounce);
> +            losc_div = sunxi_pinctrl_get_debounce_div(losc,
> +                                  debounce_freq,
> +                                  &losc_diff);
> +
> +            hosc_div = sunxi_pinctrl_get_debounce_div(hosc,
> +                                  debounce_freq,
> +                                  &hosc_diff);
> +
> +            if (hosc_diff < losc_diff) {
> +                div = hosc_div;
> +                src = 1;
> +            } else {
> +                div = losc_div;
> +                src = 0;
> +            }
>           } else {
> -            div = losc_div;
> -            src = 0;
> +            /* lowest time as best approximation to "off" */
> +            div = 0;
> +            src = 1;
>           }
> 
>           writel(src | div << 4,
>                  pctl->membase +
>                  sunxi_irq_debounce_reg_from_bank(pctl->desc, i));
> +
> +        pr_info("Debounce filter for IRQ bank %d configured to %d us 
> (reg %x)\n",
> +            i, debounce, src | div << 4);
>       }
> 
>       return 0;

