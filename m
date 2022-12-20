Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27835652598
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiLTRce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbiLTRcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:32:13 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDC81A3B0;
        Tue, 20 Dec 2022 09:32:11 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1p7gTI-00085n-EU; Tue, 20 Dec 2022 18:32:08 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Yuteng Zhong <zonyitoo@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, DHDAXCW <lasstp5011@gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add RK3566 LubanCat 1
Date:   Tue, 20 Dec 2022 18:32:06 +0100
Message-ID: <3325915.e9J7NaK4W3@diego>
In-Reply-To: <a113d20c-dc6c-2e44-009f-d4b17beb8820@linaro.org>
References: <Y6GMnq3AC7Kbnag8@VM-66-53-centos> <a113d20c-dc6c-2e44-009f-d4b17beb8820@linaro.org>
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

Am Dienstag, 20. Dezember 2022, 17:14:51 CET schrieb Krzysztof Kozlowski:
> On 20/12/2022 11:21, Yuteng Zhong wrote:
> > LubanCat 1 is a Rockchip RK3566 SBC based
> > is developed by EmbedFire Electronics Co., Ltd.
> > Mini Linux Card Type Cheap Computer Development Board
> 
> Please wrap commit message according to Linux coding style / submission
> process:
> https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586
> 
> > +	rk809: pmic@20 {
> > +		compatible = "rockchip,rk809";
> > +		reg = <0x20>;
> > +		interrupt-parent = <&gpio0>;
> > +		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
> > +		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
> > +		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
> > +		#clock-cells = <1>;
> > +		clock-names = "mclk";
> > +		clocks = <&cru I2S1_MCLKOUT_TX>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pmic_int>;
> > +		rockchip,system-power-controller;
> > +		#sound-dai-cells = <0>;
> > +		vcc1-supply = <&vcc3v3_sys>;
> > +		vcc2-supply = <&vcc3v3_sys>;
> > +		vcc3-supply = <&vcc3v3_sys>;
> > +		vcc4-supply = <&vcc3v3_sys>;
> > +		vcc5-supply = <&vcc3v3_sys>;
> > +		vcc6-supply = <&vcc3v3_sys>;
> > +		vcc7-supply = <&vcc3v3_sys>;
> > +		vcc8-supply = <&vcc3v3_sys>;
> > +		vcc9-supply = <&vcc3v3_sys>;
> > +		wakeup-source;
> > +
> > +		regulators {
> > +			vdd_logic: DCDC_REG1 {
> 
> No underscores in node names. Anything requires it?

looks like the answer is "it depends" :-)

When the regulator-framework searches for the node to get the init-data from
it uses the actual node-name or the regulator-compatible property [0]
to match against.

And going via regulator-compatible was the "old" way, already deprecated
before the yaml-conversion [1] and not even included

So matching against the node-name is the correct way to go and it's actually
part of the rk8xx-binding as well [2]


Hope that helps,
Heiko


[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/regulator/of_regulator.c#n477
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/Documentation/devicetree/bindings/regulator/regulator.txt?id=1914a996436b09186489da73b807e1df71259f67
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml#n84


