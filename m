Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4663656270
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 13:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiLZMLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 07:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLZMLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 07:11:37 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E936267;
        Mon, 26 Dec 2022 04:11:36 -0800 (PST)
Received: from g550jk.localnet (2a02-8388-6582-fe80-0000-0000-0000-0005.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::5])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 58158CA744;
        Mon, 26 Dec 2022 12:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1672056694; bh=8CDMtK2iyxq7Bqsb86TN4s+3gkJfVCoTCT1ioWKEkAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Gbe6nzyNpLNyOEEmvcd6a6rBbPncyEOwGq+JvzJgPth4XgypgnCIwhyZsOPwoZjrI
         NtkRoHq1DpCTspI2JXcU5KHRz97MXX/SZo8W7uboFATl3olqzfoS19AMoF9nO1BVMT
         8jzPv3Lx+ynCCarpruPXkwc1MFaliii/lsp5V9bc=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Rayyan Ansari <rayyan@ansari.sh>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayyan Ansari <rayyan@ansari.sh>
Subject: Re: [PATCH 2/3] ARM: dts: qcom: pm8226: add PON device node along with resin
 sub-node
Date:   Mon, 26 Dec 2022 13:11:33 +0100
Message-ID: <5631229.DvuYhMxLoT@g550jk>
In-Reply-To: <20221223193403.781355-3-rayyan@ansari.sh>
References: <20221223193403.781355-1-rayyan@ansari.sh>
 <20221223193403.781355-3-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FROM_SUSPICIOUS_NTLD,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Freitag, 23. Dezember 2022 20:34:02 CET Rayyan Ansari wrote:
> The PON (Power On) device in PM8226 supports both the power key and
> resin (reset input).
> The reset input is usually connected to a physical volume up/down button.
> 
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

> ---
>  arch/arm/boot/dts/qcom-pm8226.dtsi | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi
> b/arch/arm/boot/dts/qcom-pm8226.dtsi index d99532ea70b2..403324a35cf5
> 100644
> --- a/arch/arm/boot/dts/qcom-pm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: BSD-3-Clause
>  #include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
> 
> @@ -10,12 +11,25 @@ pm8226_0: pm8226@0 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> 
> -		pwrkey@800 {
> -			compatible = "qcom,pm8941-pwrkey";
> +		pon@800 {
> +			compatible = "qcom,pm8916-pon";
>  			reg = <0x800>;
> -			interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
> -			debounce = <15625>;
> -			bias-pull-up;
> +
> +			pwrkey {
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
> +				status = "disabled";
> +			};
>  		};
> 
>  		smbb: charger@1000 {




