Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FC36AC453
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjCFPES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjCFPEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:04:15 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C7F1E5D5;
        Mon,  6 Mar 2023 07:04:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1678115048; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pGMr+NNICiymmqKaCk3a3F8vAlg21hMj3EX2VfFfcrT+DtcGCqAhVbRX/ka84yjxel
    jNqn22q1+Wbv7wLfmPIJgainmUMFE9CeGPrPCIbcrDYRBAqzm+ejZho6E6u4PZD7933t
    F0jb8xEvIEYaWHFfFLaTemsEQhoY5Y879YJxhc7P6aFYxS7Z4c6UdF/8SniSKcAzXP5N
    veXsYB1SI/SFxwPOMDp5VLPQE0mos4gF5bCGYkqQJiJf82s7b1iFgu3V6FG1oCRn+wP/
    KvQKAIDOiPP4CBEqNm98ZFJ003jXC5HKJbUveNwfeY5fa6RDV2EquV7PVJ+pSr/ogwpa
    lo+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1678115048;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=1GHCEc0q4f4WVSYLV+hSar8xE05C8WwGep10ieZ4YFE=;
    b=cKj3Oy+RMgyO4IQyLQkn4IwO4D8ujHbf/QkwRt8fKlOnMZvUYD9KALk5azuxuOAVe+
    E3F0EW9Rvexgw4AjPd5U25JYmi34gLdGrUKOGuys7xDymqSy9faAnt7I98YsT3e8qROb
    UbdxmSREsesprWPmhemwhpdJWQt9jLE8zpJHkWnbAUV+yaOMbEFBDIyXXh5fNBGxaJ3J
    pmMXRdqVJN3klBZcH0MDB3nHw26wZFB45pR9JMcKSgZPaHKnUR3iIyeWlUb30UPzNS7P
    joAB91ulRhuRvpkK2BOFW17JvGziHOBJOZqFTXaHt4xBknfzAbF2IXLEPz51TIKRSUhQ
    6HIw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1678115048;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=1GHCEc0q4f4WVSYLV+hSar8xE05C8WwGep10ieZ4YFE=;
    b=bsUEpF0AkcdGbRizldeyejXMue/iK+hTQ4aC5di9/l8PgZPQCRKf3S/t6i+mIlUT8M
    bTe6OiiSLWyEGVmaEna6wFTdboSvJPOTSIpmo6Q4TLdGDV7XpufFyycIxgYJ5kZBxByq
    ER6Cx5SQncr5vAbtYQOL27gX6xF/ZlZ+3oSr+2y0VlJVNEBs4F2B70nFJZdH8SfLvLK4
    IESvgPHIMnVEbpOJTBD4mHwr+KSdZAtzy+lGpRyvw7tVyHBkSG6ldQlNHbpAwWoytO1z
    CJMvAtWj8auq2DQYaW6vXGrvm1dCZu9WzWBTe58TGO/Zhl3N4IqFLrS9JU2V3EmLqKw9
    SBKQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKjXrKw8/qY="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.3.0 AUTH)
    with ESMTPSA id jba5bez26F48JbV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 6 Mar 2023 16:04:08 +0100 (CET)
Date:   Mon, 6 Mar 2023 16:04:01 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: Re: [PATCH v7 2/5] arm64: dts: qcom: Add msm8939 SoC
Message-ID: <ZAYA4cdlpIfjdqt2@gerhold.net>
References: <20230223153655.262783-1-bryan.odonoghue@linaro.org>
 <20230223153655.262783-3-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223153655.262783-3-bryan.odonoghue@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,

Thanks for making the changes. I only have some minor nitpicks now:

On Thu, Feb 23, 2023 at 03:36:52PM +0000, Bryan O'Donoghue wrote:
> Add msm8939 a derivative SoC of msm8916. This SoC contains a number of key
> differences to msm8916.
>
> [...]
> diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> new file mode 100644
> index 0000000000000..89a93f5e0a93b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> [...]
> +		mba_mem: mba@8cb00000 {
> +			no-map;
> +			reg = <0x0 0x8cb00000 0x0 0x100000>;
> +		};

Nitpick: Please put no-map last for consistency.

> [...]
> +		qfprom: qfprom@5c000 {
> +			compatible = "qcom,msm8916-qfprom", "qcom,qfprom";
> +			reg = <0x0005c000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			tsens_caldata: caldata@a0 {
> +				reg = <0xa0 0x5c>;
> +			};

This is now unused and overlaps with the definitions below so I'd just
drop it like in msm8916.dtsi.

> +
> +			tsens_base1: base1@a0 {
> +				reg = <0xa0 0x1>;
> +				bits = <0 8>;
> +			};
> +
> +			tsens_s5_p1: s5-p1@a1 {
> +				reg = <0xa1 0x1>;
> +				bits = <0 6>;
> +			};
> [...]
> +		tsens: thermal-sensor@4a9000 {
> +			compatible = "qcom,msm8939-tsens", "qcom,tsens-v0_1";
> +			reg = <0x004a9000 0x1000>, /* TM */
> +			      <0x004a8000 0x1000>; /* SROT */
> +			nvmem-cells = <&tsens_mode>,
> +				      <&tsens_base1>, <&tsens_base2>,
> +				      <&tsens_s0_p1>, <&tsens_s0_p2>,
> +				      <&tsens_s1_p1>, <&tsens_s1_p2>,
> +				      <&tsens_s2_p1>, <&tsens_s2_p2>,
> +				      <&tsens_s3_p1>, <&tsens_s3_p2>,
> +				      <&tsens_s4_p1>, <&tsens_s4_p2>,
> +				      <&tsens_s4_p1>, <&tsens_s4_p2>,
> +				      <&tsens_s5_p1>, <&tsens_s5_p2>,
> +				      <&tsens_s6_p1>, <&tsens_s6_p2>,
> +				      <&tsens_s7_p1>, <&tsens_s7_p2>,
> +				      <&tsens_s8_p1>, <&tsens_s8_p2>;
> +			nvmem-cell-names = "mode",
> +					   "base1", "base2",
> +					   "s0_p1", "s0_p2",
> +					   "s1_p1", "s1_p2",
> +					   "s2_p1", "s2_p2",
> +					   "s3_p1", "s3_p2",
> +					   "s4_p1", "s4_p2",
> +					   "s4_p1", "s4_p2",

s4_p1/p2 are specified twice, is this on purpose or accidental?

> +					   "s5_p1", "s5_p2",
> +					   "s6_p1", "s6_p2",
> +					   "s7_p1", "s7_p2",
> +					   "s8_p1", "s8_p2";
> +			#qcom,sensors = <9>;
> +			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "uplow";
> +			#thermal-sensor-cells = <1>;
> +		};
> [...]
> +		usb: usb@78d9000 {
> +			compatible = "qcom,ci-hdrc";
> +			reg = <0x078d9000 0x200>,
> +			      <0x078d9200 0x200>;
> +			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_USB_HS_AHB_CLK>,
> +				 <&gcc GCC_USB_HS_SYSTEM_CLK>;
> +			clock-names = "iface", "core";
> +			assigned-clocks = <&gcc GCC_USB_HS_SYSTEM_CLK>;
> +			assigned-clock-rates = <80000000>;
> +			resets = <&gcc GCC_USB_HS_BCR>;
> +			reset-names = "core";
> +			#reset-cells = <1>;
> +			phy_type = "ulpi";
> +			dr_mode = "otg";

Please add

			hnp-disable;
			srp-disable;
			adp-disable;

here for consistency with msm8916.dtsi. These are needed for correct
behavior if you enable CONFIG_USB_OTG_FSM, see commit bfd5d21abcd5c
("arm64: dts: qcom: msm8916: Move common USB properties to msm8916.dtsi")
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bfd5d21abcd5c7941ad79b594f5f42e27496eb28

> +			ahb-burst-config = <0>;
> +			phy-names = "usb-phy";
> +			phys = <&usb_hs_phy>;
> +			status = "disabled";
> +
> +			ulpi {
> +				usb_hs_phy: phy {
> +					compatible = "qcom,usb-hs-phy-msm8916",
> +						     "qcom,usb-hs-phy";
> +					clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> +						 <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
> +					clock-names = "ref", "sleep";
> +					resets = <&gcc GCC_USB2A_PHY_BCR>, <&usb 0>;
> +					reset-names = "phy", "por";
> +					#phy-cells = <0>;
> +					qcom,init-seq = /bits/ 8 <0x0 0x44>,
> +								 <0x1 0x6b>,
> +								 <0x2 0x24>,
> +								 <0x3 0x13>;
> +				};
> +			};
> +		};
> +
> [...]
> +		timer@b120000 {
> +			compatible = "arm,armv7-timer-mem";
> +			reg = <0x0b120000 0x1000>;

This node needs to be reordered now, it should be below a53pll_c0.

> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			frame@b121000 {
> +				reg = <0x0b121000 0x1000>,
> +				      <0x0b122000 0x1000>;
> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <0>;
> +			};
> +
> +			frame@b123000 {
> +				reg = <0x0b123000 0x1000>;
> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <1>;
> +				status = "disabled";
> +			};
> +
> +			frame@b124000 {
> +				reg = <0x0b124000 0x1000>;
> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <2>;
> +				status = "disabled";
> +			};
> +
> +			frame@b125000 {
> +				reg = <0x0b125000 0x1000>;
> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <3>;
> +				status = "disabled";
> +			};
> +
> +			frame@b126000 {
> +				reg = <0x0b126000 0x1000>;
> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <4>;
> +				status = "disabled";
> +			};
> +
> +			frame@b127000 {
> +				reg = <0x0b127000 0x1000>;
> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <5>;
> +				status = "disabled";
> +			};
> +
> +			frame@b128000 {
> +				reg = <0x0b128000 0x1000>;
> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <6>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		pronto: remoteproc@a204000 {
> +			compatible = "qcom,pronto-v2-pil", "qcom,pronto";
> +			reg = <0x0a204000 0x2000>,
> +			      <0x0a202000 0x1000>,
> +			      <0x0a21b000 0x3000>;
> +			reg-names = "ccu", "dxe", "pmu";

and this node should be below usb/above intc (ordered by address).

Thanks,
Stephan
