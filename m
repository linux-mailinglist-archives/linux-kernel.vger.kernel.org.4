Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7615E8D62
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 16:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiIXOkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 10:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiIXOkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 10:40:39 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39EDAA4C9;
        Sat, 24 Sep 2022 07:40:38 -0700 (PDT)
Received: from g550jk.localnet (212095005231.public.telering.at [212.95.5.231])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id C0191C0C33;
        Sat, 24 Sep 2022 14:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1664030407; bh=8QhRyd0j2F999c5w2aJ8ANnzfTmXzU50u2hNBubP5NA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=nCCyBgMLVSHkJ8xYmVsz2v4xF70VkH/j4CVOSGW/AEgzEzMq2ZdV1knY8/J8kiutw
         EKb1ogEXH1/ULaiZz9Dk/aj5gnBEUDHMfE+jOPz872OXYumhUMWRloaGHD14RJzjFb
         IZTbKpkeGMumry+CNxyGCs8XjqEk4ZiMSl5o9V08=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org, Jack Matthews <jm5112356@gmail.com>
Cc:     bartosz.dudziak@snejp.pl, Jack Matthews <jm5112356@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: pm8226: Add PON node
Date:   Sat, 24 Sep 2022 16:40:05 +0200
Message-ID: <2646812.mvXUDI8C0e@g550jk>
In-Reply-To: <20211122235230.2467246-1-jm5112356@gmail.com>
References: <20211122235230.2467246-1-jm5112356@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

On Dienstag, 23. November 2021 00:52:30 CEST Jack Matthews wrote:
> Add PON node with pwrkey and resin as child nodes.
> Also adds resin, and additional properties to pwrkey.

I just saw that this patch hasn't been applied yet.
As it doesn't apply cleanly anymore can you please rebase it and send a v2? 
Hopefully Bjorn can apply it then :)

Regards
Luca

> 
> Signed-off-by: Jack Matthews <jm5112356@gmail.com>
> ---
>  arch/arm/boot/dts/qcom-pm8226.dtsi | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi
> b/arch/arm/boot/dts/qcom-pm8226.dtsi index 666bc6350c50..63f3026c25bf
> 100644
> --- a/arch/arm/boot/dts/qcom-pm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: BSD-3-Clause
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/input/input.h>
>  #include <dt-bindings/spmi/spmi.h>
> 
>  &spmi_bus {
> @@ -9,12 +10,26 @@ pm8226_0: pm8226@0 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> 
> -		pwrkey@800 {
> -			compatible = "qcom,pm8941-pwrkey";
> -			reg = <0x800>;
> -			interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
> -			debounce = <15625>;
> -			bias-pull-up;
> +		pon: power-on@800 {
> +			compatible = "qcom,pm8916-pon";
> +			reg = <0x0800>;
> +
> +			pm8226_pwrkey: pwrkey {
> +				compatible = "qcom,pm8941-
pwrkey";
> +				interrupts = <0x0 0x8 0 
IRQ_TYPE_EDGE_BOTH>;
> +				debounce = <15625>;
> +				bias-pull-up;
> +				linux,code = <KEY_POWER>;
> +			};
> +
> +			pm8226_resin: resin {
> +				compatible = "qcom,pm8941-resin";
> +				interrupts = <0x0 0x8 1 
IRQ_TYPE_EDGE_BOTH>;
> +				debounce = <15625>;
> +				bias-pull-up;
> +
> +				status = "disabled";
> +			};
>  		};
> 
>  		smbb: charger@1000 {




