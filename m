Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D172D5E77DD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiIWKCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiIWKC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:02:28 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A296B1280CC;
        Fri, 23 Sep 2022 03:02:25 -0700 (PDT)
Received: from p508fdb48.dip0.t-ipconnect.de ([80.143.219.72] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1obfVi-0005d7-QY; Fri, 23 Sep 2022 12:02:18 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dan Johansen <strit@manjaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Enable HDMI and GPU on quartz64-b
Date:   Fri, 23 Sep 2022 12:02:18 +0200
Message-ID: <2218487.usQuhbGJ8B@phil>
In-Reply-To: <ad36710b-af7d-f9ca-fa04-cbb9acb5f123@manjaro.org>
References: <20220920143446.633956-1-frattaroli.nicolas@gmail.com> <2198677.PYKUYFuaPT@phil> <ad36710b-af7d-f9ca-fa04-cbb9acb5f123@manjaro.org>
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

Hi,

Am Freitag, 23. September 2022, 11:53:52 CEST schrieb Dan Johansen:
> 
> Den 23.09.2022 kl. 11.45 skrev Heiko Stuebner:
> > Hi,
> >
> > Am Donnerstag, 22. September 2022, 23:22:37 CEST schrieb Dan Johansen:
> >> This seems to be based against linux-next and not mainline. It fails to
> >> apply on mainline for me.
> > I would not expect things any other way though :-) .
> > I.e. in the current cycle everything new is of course targetting
> > v6.1 and the Quartz boards already saw some other changes.
> 
> Ah okay. I have misunderstood the submitting process then.
> 
> I was under the impression that a patch should always target the latest 
> -rc1, in this case 6.0-rc1.
> 
> I did not know that when you are at rc6/rc7 it's okay to target 
> linux-next without
> mentioning it.
> 
> Sorry for my noise.

no worries - just to clarify a bit more, the issue gets slightly
more complex :-) .

I.e. patches should always target the maintainer-branch you're expecting
them getting applied to. During the whole development cycle there is a
lot of movement happening in each maintainer tree, so targetting some
completely separate rc-kernel won't really make sense.

Most of the time targetting -rc1 might work in the beginning, but when
there are other changes already applied you need to take these into
account too.

Heiko


> >> Den 20.09.2022 kl. 16.34 skrev Nicolas Frattaroli:
> >>> This enables the GPU and HDMI output (including HDMI audio) on
> >>> the PINE64 Quartz64 Model B single board computer.
> >>>
> >>> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> >>> ---
> >>>    .../boot/dts/rockchip/rk3566-quartz64-b.dts   | 60 +++++++++++++++++++
> >>>    1 file changed, 60 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> >>> index 0f623198970f..77b179cd20e7 100644
> >>> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> >>> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> >>> @@ -4,6 +4,7 @@
> >>>    
> >>>    #include <dt-bindings/gpio/gpio.h>
> >>>    #include <dt-bindings/pinctrl/rockchip.h>
> >>> +#include <dt-bindings/soc/rockchip,vop2.h>
> >>>    #include "rk3566.dtsi"
> >>>    
> >>>    / {
> >>> @@ -28,6 +29,17 @@ gmac1_clkin: external-gmac1-clock {
> >>>    		#clock-cells = <0>;
> >>>    	};
> >>>    
> >>> +	hdmi-con {
> >>> +		compatible = "hdmi-connector";
> >>> +		type = "a";
> >>> +
> >>> +		port {
> >>> +			hdmi_con_in: endpoint {
> >>> +				remote-endpoint = <&hdmi_out_con>;
> >>> +			};
> >>> +		};
> >>> +	};
> >>> +
> >>>    	leds {
> >>>    		compatible = "gpio-leds";
> >>>    
> >>> @@ -183,6 +195,33 @@ &gmac1m1_clkinout
> >>>    	status = "okay";
> >>>    };
> >>>    
> >>> +&gpu {
> >>> +	mali-supply = <&vdd_gpu>;
> >>> +	status = "okay";
> >>> +};
> >>> +
> >>> +&hdmi {
> >>> +	avdd-0v9-supply = <&vdda0v9_image>;
> >>> +	avdd-1v8-supply = <&vcca1v8_image>;
> >>> +	status = "okay";
> >>> +};
> >>> +
> >>> +&hdmi_in {
> >>> +	hdmi_in_vp0: endpoint {
> >>> +		remote-endpoint = <&vp0_out_hdmi>;
> >>> +	};
> >>> +};
> >>> +
> >>> +&hdmi_out {
> >>> +	hdmi_out_con: endpoint {
> >>> +		remote-endpoint = <&hdmi_con_in>;
> >>> +	};
> >>> +};
> >>> +
> >>> +&hdmi_sound {
> >>> +	status = "okay";
> >>> +};
> >>> +
> >>>    &i2c0 {
> >>>    	status = "okay";
> >>>    
> >>> @@ -456,6 +495,10 @@ &i2c5 {
> >>>    	status = "disabled";
> >>>    };
> >>>    
> >>> +&i2s0_8ch {
> >>> +	status = "okay";
> >>> +};
> >>> +
> >>>    &i2s1_8ch {
> >>>    	pinctrl-names = "default";
> >>>    	pinctrl-0 = <&i2s1m0_sclktx
> >> The above part does not seem to exist in the current mainline (rc6) git
> >> repo.
> > which is of course already in linux-next, so this
> > patch just applied nicely.
> >
> >
> > Heiko
> >
> >>> @@ -677,3 +720,20 @@ &usb_host0_ehci {
> >>>    &usb_host0_ohci {
> >>>    	status = "okay";
> >>>    };
> >>> +
> >>> +&vop {
> >>> +	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
> >>> +	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
> >>> +	status = "okay";
> >>> +};
> >>> +
> >>> +&vop_mmu {
> >>> +	status = "okay";
> >>> +};
> >>> +
> >>> +&vp0 {
> >>> +	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
> >>> +		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
> >>> +		remote-endpoint = <&hdmi_in_vp0>;
> >>> +	};
> >>> +};
> >
> >
> >
> >
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 




