Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899EF6F4733
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjEBP3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjEBP3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:29:42 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AEA1BC7;
        Tue,  2 May 2023 08:29:26 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id C1350CEC2E;
        Tue,  2 May 2023 15:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683041334; bh=4Nf/Tso4ftEbFHYRGvD0XTZDY95O9PUTrhjQ+iuYvVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gtzSt7i1Jw+jiE3ltae0qC2vQUnz+LLmY0eZMjLaBky2ER45XW/VIwR1aGcP7PL66
         5HYKhn9c6cic8QM6KNdbEeSuwyHg3oP9im6Fl83uYVjaWPJrFGZxe7g+cLJDQsOAwz
         t3fYv8t1Z2Wzrg/NJJysw/AYidJi3HjfbTkjUPjk=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 4/4] ARM: dts: qcom: msm8974-hammerhead: Add vibrator
Date:   Tue, 02 May 2023 17:28:53 +0200
Message-ID: <112204300.nniJfEyVGO@z3ntu.xyz>
In-Reply-To: <fc22fd34-6cce-c175-d845-cf4435b4b0be@linaro.org>
References: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
 <20230427-hammerhead-vibra-v1-4-e87eeb94da51@z3ntu.xyz>
 <fc22fd34-6cce-c175-d845-cf4435b4b0be@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 2. Mai 2023 12:40:40 CEST Konrad Dybcio wrote:
> On 27.04.2023 22:34, Luca Weiss wrote:
> > The Nexus 5 has a vibrator connected to the clock output of GP1_CLK
> > which we can use with the clk-pwm driver, then we can use that pwm with
> > pwm-vibrator to get haptics functionality.
> > 
> > This patch is based on Brian Masney's previous patch with clk-vibrator.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> > 
> >  .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     | 35
> >  ++++++++++++++++++++++ 1 file changed, 35 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> > b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts index
> > ab35f2d644c0..fea8a6be9021 100644
> > --- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> > +++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> > @@ -41,6 +41,25 @@ key-volume-down {
> > 
> >  		};
> >  	
> >  	};
> > 
> > +	clk_pwm: pwm {
> > +		compatible = "clk-pwm";
> > +		clocks = <&mmcc CAMSS_GP1_CLK>;
> 
> Are you sure it's <&mmcc CAMSS_GP1_CLK> and not <&gcc GCC_GP1_CLK>?

Quite sure.

The driver uses:

	cam_gp1_clk = clk_get(&pdev->dev, "cam_gp1_clk");

and this comes from the clock-8974.c driver

	CLK_LOOKUP("cam_gp1_clk", camss_gp1_clk.c, "vibrator"),

Regards
Luca

> 
> Konrad
> 
> > +
> > +		pinctrl-0 = <&vibrator_pin>;
> > +		pinctrl-names = "default";
> > +
> > +		#pwm-cells = <2>;
> > +	};
> > +
> > +	vibrator {
> > +		compatible = "pwm-vibrator";
> > +		pwms = <&clk_pwm 0 100000>;
> > +		pwm-names = "enable";
> > +
> > +		vcc-supply = <&pm8941_l19>;
> > +		enable-gpios = <&tlmm 60 GPIO_ACTIVE_HIGH>;
> > +	};
> > +
> > 
> >  	vreg_wlan: wlan-regulator {
> >  	
> >  		compatible = "regulator-fixed";
> > 
> > @@ -637,6 +656,22 @@ shutdown-pins {
> > 
> >  			function = "gpio";
> >  		
> >  		};
> >  	
> >  	};
> > 
> > +
> > +	vibrator_pin: vibrator-state {
> > +		core-pins {
> > +			pins = "gpio27";
> > +			function = "gp1_clk";
> > +			drive-strength = <6>;
> > +			bias-disable;
> > +		};
> > +
> > +		enable-pins {
> > +			pins = "gpio60";
> > +			function = "gpio";
> > +			drive-strength = <2>;
> > +			bias-disable;
> > +		};
> > +	};
> > 
> >  };
> >  
> >  &usb {




