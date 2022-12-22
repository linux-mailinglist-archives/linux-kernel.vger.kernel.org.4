Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195436540BA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbiLVMJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbiLVMIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:08:54 -0500
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481C33135D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:59:27 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id E03143EBD9;
        Thu, 22 Dec 2022 12:59:23 +0100 (CET)
Date:   Thu, 22 Dec 2022 12:59:22 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dzmitry Sankouski <dsankouski@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v12 2/2] arm64: dts: qcom: sagit: add initial device tree
 for sagit
Message-ID: <20221222115922.jlachctn4lxopp7a@SoMainline.org>
References: <20221112203300.536010-1-dsankouski@gmail.com>
 <20221112203300.536010-3-dsankouski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221112203300.536010-3-dsankouski@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-12 23:33:00, Dzmitry Sankouski wrote:
> New device support - Xiaomi Mi6 phone

<snip>

> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> index 6a0e14382be8..6a5854333b2b 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -52,6 +52,14 @@ pm8998_pwrkey: pwrkey {
>  				bias-pull-up;
>  				linux,code = <KEY_POWER>;
>  			};
> +
> +			pm8998_resin: resin {
> +				compatible = "qcom,pm8941-resin";
> +				interrupts = <GIC_SPI 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> +				debounce = <15625>;
> +				bias-pull-up;
> +				status = "disabled";
> +			};

This should have been a separate patch, one that deduplicated
overlapping nodes with existing msm8998 / sdm845 boards which all add
this node individually to &pm8998_pon.

What's more, their override has the same node name and will be merged
with this one without setting status = "okay", leading to all those
boards suddenly having a broken resin key because they inherit your
status="disabled".

Can you send a fix to address that, with proper Fixes: tag?

- Marijn

>  		};
>  
>  		pm8998_temp: temp-alarm@2400 {
> -- 
> 2.30.2
> 
