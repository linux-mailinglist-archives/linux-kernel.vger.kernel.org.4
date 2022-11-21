Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65370632A57
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKURGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiKURGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:06:45 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB8DCC78F2;
        Mon, 21 Nov 2022 09:06:43 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oxAFl-00041n-00; Mon, 21 Nov 2022 18:06:41 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id C2930C1B8B; Mon, 21 Nov 2022 18:03:52 +0100 (CET)
Date:   Mon, 21 Nov 2022 18:03:52 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: DTS: CI20: fix reset line polarity of the ethernet
 controller
Message-ID: <20221121170352.GA3200@alpha.franken.de>
References: <Y3e2Q9jeGotRlwqV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3e2Q9jeGotRlwqV@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 08:43:47AM -0800, Dmitry Torokhov wrote:
> The reset line is called PWRST#, annotated as "active low" in the
> binding documentation, and is driven low and then high by the driver to
> reset the chip. However in device tree for CI20 board it was incorrectly
> marked as "active high". Fix it.
> 
> Because (as far as I know) the ci20.dts is always built in the kernel I
> elected not to also add a quirk to gpiolib to force the polarity there.
> 
> Fixes: db49ca38579d ("net: davicom: dm9000: switch to using gpiod API")
> Reported-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  arch/mips/boot/dts/ingenic/ci20.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
> index 37c46720c719..f38c39572a9e 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> @@ -438,7 +438,7 @@ dm9000@6 {
>  		ingenic,nemc-tAW = <50>;
>  		ingenic,nemc-tSTRV = <100>;
>  
> -		reset-gpios = <&gpf 12 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpf 12 GPIO_ACTIVE_LOW>;
>  		vcc-supply = <&eth0_power>;
>  
>  		interrupt-parent = <&gpe>;
> -- 
> 2.38.1.584.g0f3c55d4c2-goog

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
