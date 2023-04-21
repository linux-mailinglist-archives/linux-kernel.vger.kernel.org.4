Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A776EA9CE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 13:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjDUL7K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Apr 2023 07:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjDUL7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:59:08 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88503A3;
        Fri, 21 Apr 2023 04:59:05 -0700 (PDT)
Received: from [194.95.143.137] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pppPn-0002Lk-Js; Fri, 21 Apr 2023 13:58:59 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix nEXTRST on SOQuartz
Date:   Fri, 21 Apr 2023 13:58:58 +0200
Message-ID: <8914603.GXAFRqVoOG@phil>
In-Reply-To: <20230419171731.28641-1-frattaroli.nicolas@gmail.com>
References: <20230419171731.28641-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 19. April 2023, 19:17:31 CEST schrieb Nicolas Frattaroli:
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
> index ce7165d7f1a1..f589a4fdaccb 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
> @@ -65,6 +65,17 @@ led_work: led-work {
>  		};
>  	};
>  
> +	nextrst_pin: nextrst-pin-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&nextrst_h>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-name = "nextrst";
> +	};
> +

I agree with the sentiment and of course the rationale of the change,
but not necessarily with the implementation ;-) .

Why is this done as a regulator?

If you want the nextrst line to be high, you could just use a gpio-hog
for the line instead of doing a (fake?-)regulator.

For example the px30-ringneck.dtsi does something similar:

&gpio2 {        
        /*      
         * The Qseven BIOS_DISABLE signal on the PX30-µQ7 keeps the on-module
         * eMMC powered-down initially (in fact it keeps the reset signal
         * asserted). BIOS_DISABLE_OVERRIDE pin allows to re-enable eMMC after
         * the SPL has been booted from SD Card.
         */     
        bios-disable-override-hog {
                gpios = <RK_PB5 GPIO_ACTIVE_LOW>;
                output-high;
                line-name = "bios_disable_override";
                gpio-hog;
        };      
...
};


Thanks
Heiko


