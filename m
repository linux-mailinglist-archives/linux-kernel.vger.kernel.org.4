Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000175EB8F6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiI0DmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiI0DmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 23:42:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE44AE86B;
        Mon, 26 Sep 2022 20:42:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02E24B81911;
        Tue, 27 Sep 2022 03:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF57C433B5;
        Tue, 27 Sep 2022 03:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664250118;
        bh=HKt3HG9NLn2qRqX89HSNo/r4xCT+ng7EgrAEd1EPWvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nf01NM6aVqR3wKaWwe12L8HCvnGS1TR5Tw2K9NdjEv3RcXybzNeviY8g/zh6mukSP
         I1o7EE025IdDxomZtPF47XCp8VVaYdCoTOEGwOKELOtnXiYngovwXVMn4ee28hDw/a
         WP8kFnonao5b2yKUXrx6GfW2MaT4afpd7Z02qHqlT+tK1NZv/kQLxA6SxOBLXgf4ng
         KlK/SdkhD3fvSkshNZ1sdRj3pKACdHIhyrE1gTtf6wgjtbcSkMwmMkKXbcLpU7xLSO
         /Ylk88Uvb0wMR3lExekzkNgP5mMqj7IEwK5/dltBFHOmmjH0XG/V/tpbl26IA1eJg1
         MoV+GcZsWHF2A==
Date:   Mon, 26 Sep 2022 22:41:55 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/33] pinctrl/arm64: qcom: continued - fix Qualcomm
 TLMM pinctrl schema warnings
Message-ID: <20220927034155.2bwxfq4g4m6ovjod@builder.lan>
References: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 09:43:42AM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes since v1
> ================
> v1: https://lore.kernel.org/linux-devicetree/20220924080459.13084-1-krzysztof.kozlowski@linaro.org/T/#t
> 1. As Stephan suggested, move check for function on non-GPIO pins to common
>    TLMM schema.  This affects few commits in the set named:
>    "use common TLMM schema"
>    "do not require function on non-GPIOs"
> 
> Overview
> ========
> This is the third, independent patchset around Qualcomm pinctrl in recent days:
> 1. First round of TLMM fixes: merged
> 2. LPASS fixes:
>    https://lore.kernel.org/linux-devicetree/20220922195651.345369-1-krzysztof.kozlowski@linaro.org/T/#t
> 3. ARMv7 TLMM fixes: *THIS PATCHSET*
> 4. ARMv8 remaining TLMM fixes: v1 send:
>    https://lore.kernel.org/linux-devicetree/20220925110608.145728-1-krzysztof.kozlowski@linaro.org/T/#t
> 
> Dependencies
> ============
> 1. No dependencies.
> 2. dt-bindings are independent of DTS patches.
> 
> Best regards,
> Krzysztof

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> 
> Krzysztof Kozlowski (33):
>   arm64: dts: qcom: ipq6018-cp01-c1: correct blspi1 pins
>   arm64: dts: qcom: ipq6018: align TLMM pin configuration with DT schema
>   ARM: dts: qcom: sdx55: add gpio-ranges to TLMM pinctrl
>   ARM: dts: qcom: sdx55: align TLMM pin configuration with DT schema
>   ARM: dts: qcom: msm8226: align TLMM pin configuration with DT schema
>   ARM: dts: qcom: msm8974: align TLMM pin configuration with DT schema
>   dt-bindings: pinctrl: qcom,tlmm-common: add common check for function
>   dt-bindings: pinctrl: qcom,ipq6018: add qpic_pad function
>   dt-bindings: pinctrl: qcom,ipq6018: increase number of pins in pinmux
>   dt-bindings: pinctrl: qcom,ipq6018: fix matching pin config
>   dt-bindings: pinctrl: qcom,ipq6018: use common TLMM schema
>   dt-bindings: pinctrl: qcom,ipq6018: fix indentation in example
>   dt-bindings: pinctrl: qcom,msm8226: fix matching pin config
>   dt-bindings: pinctrl: qcom,msm8226: use common TLMM schema
>   dt-bindings: pinctrl: qcom,msm8226: add functions and input-enable
>   dt-bindings: pinctrl: qcom,msm8226: fix indentation in example
>   dt-bindings: pinctrl: qcom,msm8909-tlmm: fix matching pin config
>   dt-bindings: pinctrl: qcom,msm8909-tlmm: do not require function on
>     non-GPIOs
>   dt-bindings: pinctrl: qcom,msm8909-tlmm: fix indentation in example
>   dt-bindings: pinctrl: qcom,msm8953: fix matching pin config
>   dt-bindings: pinctrl: qcom,msm8953: use common TLMM schema
>   dt-bindings: pinctrl: qcom,msm8953: fix indentation in example
>   dt-bindings: pinctrl: qcom,mdm9607: do not require function on
>     non-GPIOs
>   dt-bindings: pinctrl: qcom,mdm9607: fix indentation in example
>   dt-bindings: pinctrl: qcom,qcm2290: fix matching pin config
>   dt-bindings: pinctrl: qcom,qcm2290: use common TLMM schema
>   dt-bindings: pinctrl: qcom,sdx55: fix matching pin config
>   dt-bindings: pinctrl: qcom,sdx55: use common TLMM schema
>   dt-bindings: pinctrl: qcom,sdx55: fix indentation in example
>   dt-bindings: pinctrl: qcom,sdx65: fix matching pin config
>   dt-bindings: pinctrl: qcom,sdx65: use common TLMM schema
>   dt-bindings: pinctrl: qcom,sc7280: fix matching pin config
>   dt-bindings: pinctrl: qcom,sc8280xp: fix indentation in example
>     (remaining piece)
> 
>  .../pinctrl/qcom,ipq6018-pinctrl.yaml         | 60 +++++++++--------
>  .../pinctrl/qcom,mdm9607-pinctrl.yaml         | 23 ++++---
>  .../pinctrl/qcom,msm8226-pinctrl.yaml         | 63 +++++++++---------
>  .../bindings/pinctrl/qcom,msm8909-tlmm.yaml   | 64 +++++++++----------
>  .../pinctrl/qcom,msm8953-pinctrl.yaml         | 51 ++++++++-------
>  .../pinctrl/qcom,qcm2290-pinctrl.yaml         | 11 ++--
>  .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml | 14 +++-
>  .../pinctrl/qcom,sc8280xp-pinctrl.yaml        |  4 +-
>  .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml  | 51 ++++++++-------
>  .../bindings/pinctrl/qcom,sdx65-pinctrl.yaml  | 12 ++--
>  .../bindings/pinctrl/qcom,tlmm-common.yaml    | 20 ++++--
>  arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts   |  6 +-
>  arch/arm/boot/dts/qcom-msm8226.dtsi           | 24 +++----
>  .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 30 ++++-----
>  .../boot/dts/qcom-sdx55-telit-fn980-tlb.dts   | 45 +++++--------
>  arch/arm/boot/dts/qcom-sdx55.dtsi             |  1 +
>  arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts  |  8 ++-
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  4 +-
>  18 files changed, 264 insertions(+), 227 deletions(-)
> 
> -- 
> 2.34.1
> 
