Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393496471EF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLHOjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiLHOjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:39:17 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425D87BC03;
        Thu,  8 Dec 2022 06:39:15 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 27530E0004;
        Thu,  8 Dec 2022 14:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670510354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dEHxnxnFHBTO8JQi6DOwgnd07ueyg019eY2dApNt3d8=;
        b=AqHSVl8c2azXYAZjZSClzz72L9kP4AcZyFJcjGbJdRX31PVVf/C3FCeJw9yy/Y0J4Df5iB
        Kjq5ivZmn7r87C4mL2POnD+GmAckWPnYmDjeO8zJWD+3E08Y6lXnErJaqIuvGD25cIxTru
        GGf/4dVZ+2LZf5mGD+qDgsRi7kL+h3sJ0E4/jcAhflzPBj2DQqHaJ8wJSMX/B3ag5/1fCB
        JyN7l/QS7saNuCkJIbafQxijTTRz5te95tfl7Xwb1mIUkD/YIxk3FFN/Z2jiCrOILQBIOX
        JQvnQMPt2ig0TAe2U8Oqz5CrH+h4wsq2ZLUAht5U24YRAfBJ1hQpcv7LxRbYWQ==
Date:   Thu, 8 Dec 2022 15:39:12 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] clk: at91: do not compile dt-compat.c for sama7g5
 and sam9x60
Message-ID: <Y5H3EH7kPOwGI2SQ@mail.local>
References: <20221208114515.35179-1-claudiu.beznea@microchip.com>
 <20221208114515.35179-4-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208114515.35179-4-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2022 13:45:15+0200, Claudiu Beznea wrote:
> There is no need to have dt-compat.c compiled for SAMA7G5 and SAM9X60
> as there is no in kernel device tree that could use it. Thus avoid
> compiling dt-compat.c for them.
> 

Isn't it time to drop dt-compat.c? I was going to send a patch after 6.1
is released

> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/clk/at91/Makefile | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/at91/Makefile b/drivers/clk/at91/Makefile
> index 79301e1c1c36..89061b85e7d2 100644
> --- a/drivers/clk/at91/Makefile
> +++ b/drivers/clk/at91/Makefile
> @@ -3,7 +3,7 @@
>  # Makefile for at91 specific clk
>  #
>  
> -obj-y += pmc.o sckc.o dt-compat.o
> +obj-y += pmc.o sckc.o
>  obj-y += clk-slow.o clk-main.o clk-pll.o clk-plldiv.o clk-master.o
>  obj-y += clk-system.o clk-peripheral.o clk-programmable.o
>  
> @@ -15,12 +15,12 @@ obj-$(CONFIG_HAVE_AT91_H32MX)		+= clk-h32mx.o
>  obj-$(CONFIG_HAVE_AT91_GENERATED_CLK)	+= clk-generated.o
>  obj-$(CONFIG_HAVE_AT91_I2S_MUX_CLK)	+= clk-i2s-mux.o
>  obj-$(CONFIG_HAVE_AT91_SAM9X60_PLL)	+= clk-sam9x60-pll.o
> -obj-$(CONFIG_SOC_AT91RM9200) += at91rm9200.o
> -obj-$(CONFIG_SOC_AT91SAM9) += at91sam9260.o at91sam9rl.o at91sam9x5.o
> -obj-$(CONFIG_SOC_AT91SAM9) += at91sam9g45.o
> -obj-$(CONFIG_SOC_AT91SAM9) += at91sam9n12.o at91sam9x5.o
> +obj-$(CONFIG_SOC_AT91RM9200) += at91rm9200.o dt-compat.o
> +obj-$(CONFIG_SOC_AT91SAM9) += at91sam9260.o at91sam9rl.o at91sam9x5.o dt-compat.o
> +obj-$(CONFIG_SOC_AT91SAM9) += at91sam9g45.o dt-compat.o
> +obj-$(CONFIG_SOC_AT91SAM9) += at91sam9n12.o at91sam9x5.o dt-compat.o
>  obj-$(CONFIG_SOC_SAM9X60) += sam9x60.o
> -obj-$(CONFIG_SOC_SAMA5D3) += sama5d3.o
> -obj-$(CONFIG_SOC_SAMA5D4) += sama5d4.o
> -obj-$(CONFIG_SOC_SAMA5D2) += sama5d2.o
> +obj-$(CONFIG_SOC_SAMA5D3) += sama5d3.o dt-compat.o
> +obj-$(CONFIG_SOC_SAMA5D4) += sama5d4.o dt-compat.o
> +obj-$(CONFIG_SOC_SAMA5D2) += sama5d2.o dt-compat.o
>  obj-$(CONFIG_SOC_SAMA7G5) += sama7g5.o
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
