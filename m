Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3855C6CBCA8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjC1KjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC1KjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:39:18 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1638161A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:39:17 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-53d277c1834so221017237b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679999956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WeJvOmb4UiZDVdrpjbdoZEi88r2fueDviw4j3TobD+s=;
        b=in30x2eTX3jMdB5lq1/bDRTxEHiNx9CtvD7goZQ6srXY+8gNricGHD/FTz0kAZsX9h
         ry0Ldo03nV1VdMZBxhOiz0iMe1BRmASe+mD65YEruCVXoY0kbUsM/FgZLzv4q1n6Ll0z
         GVUioTnM9Eejmtvl5rRwz/3cwRjYeG2w5D9ULfltX9JSeLE9ixzw9M/O45MFf6240+qe
         d2lTNggLA6nKiLPBrpxqqlEqBXcbUQFTRY3MQ3HPDrzVtvSk+C3SvbaQrtA3Wek29dHU
         VcwRILvcyIQWn84anR+3PRXriNK7zyc07nGzltmgzqqyHmk3BywN1lNyUfLfgtFs836/
         lVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679999956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WeJvOmb4UiZDVdrpjbdoZEi88r2fueDviw4j3TobD+s=;
        b=2BOn5SEt3m+BfsbGC2Z6e35c03xdlKArIrbx3pIHvCC2Fhdk+S0RZLX+50WtlebZwc
         vwqgGBKUid0UZEosY8hdjEmOJAXSmqBUpIhySXEtJhgJSrJLv53OLqbp+2Npm8RL4jiJ
         b8MdruA+73cPEm91tL+2Vj5UrXH5bx0nitfUSACm09HtUSHDMKlEc6GCaNhxx6zDEhOS
         Tc3vu7VqA2+CpLqLdfwiB1zShDtvjmZ+Xpqii3hBoTJf2SJAI/72C+z5gkVMFsGRPmQJ
         Fq/xKS9iA/DUhemZuF01oE4PIfkieKpdUsKhN5nHI+D77+25UDS1lO/pB2j2zZTGmHMo
         0vjQ==
X-Gm-Message-State: AAQBX9fMpGqJUUeYobk4U6gCCP0+Qig9X7wYNZ0QoYGs5K1lo3xBNNtu
        1yt8dUVUgq97W4q42uEkz3NGF6igOD/EXJxkdr3Y/A==
X-Google-Smtp-Source: AKy350brQY738lvkF7Rq2rzNE3EKxx6So7gaAZKzG1faUECV9zEl3gL5esGUxz85xxrR5C20f9Chy1kDFvI+CQ0wU18=
X-Received: by 2002:a81:4410:0:b0:545:a7d8:f278 with SMTP id
 r16-20020a814410000000b00545a7d8f278mr6595880ywa.5.1679999956113; Tue, 28 Mar
 2023 03:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230327132718.573-1-quic_devipriy@quicinc.com>
 <20230327132718.573-4-quic_devipriy@quicinc.com> <CAA8EJprTm1sZ8fnfNee+NJTiaFq17QwWaEnSoJWVYs_GY65xFg@mail.gmail.com>
 <a6225636-7abb-3c5c-c78f-8d40c25167b9@quicinc.com>
In-Reply-To: <a6225636-7abb-3c5c-c78f-8d40c25167b9@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 28 Mar 2023 13:39:05 +0300
Message-ID: <CAA8EJprgcMOX-WRXP2i9k850La1A1UKaKuODd-fVi27nOxMbyA@mail.gmail.com>
Subject: Re: [PATCH V10 3/4] arm64: dts: qcom: Add support for ipq9574 SoC and
 RDP433 variant
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, shawnguo@kernel.org, arnd@arndb.de,
        marcel.ziswiler@toradex.com, nfraprado@collabora.com,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_srichara@quicinc.com,
        quic_gokulsri@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_poovendh@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 at 10:31, Devi Priya <quic_devipriy@quicinc.com> wrote:
> On 3/27/2023 8:15 PM, Dmitry Baryshkov wrote:
> > On Mon, 27 Mar 2023 at 16:28, Devi Priya <quic_devipriy@quicinc.com> wrote:
> >>
> >> Add initial device tree support for Qualcomm IPQ9574 SoC and
> >> Reference Design Platform(RDP) 433 which is based on IPQ9574
> >> family of SoCs
> >>
> >> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> >> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> >> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> >> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> >> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> >> ---
> >>   Changes in V10:
> >>          - Renamed the Board Device Tree Source to use the RDP numbers
> >>          - Updated the Makefile, subject and commit message accordingly
> >>
> >>   arch/arm64/boot/dts/qcom/Makefile           |   1 +
> >>   arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts |  84 ++++++
> >>   arch/arm64/boot/dts/qcom/ipq9574.dtsi       | 270 ++++++++++++++++++++
> >>   3 files changed, 355 insertions(+)
> >>   create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> >>   create mode 100644 arch/arm64/boot/dts/qcom/ipq9574.dtsi
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> >> index 1a29403400b7..52f1f92c5195 100644
> >> --- a/arch/arm64/boot/dts/qcom/Makefile
> >> +++ b/arch/arm64/boot/dts/qcom/Makefile
> >> @@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_QCOM) += ipq6018-cp01-c1.dtb
> >>   dtb-$(CONFIG_ARCH_QCOM)        += ipq8074-hk01.dtb
> >>   dtb-$(CONFIG_ARCH_QCOM)        += ipq8074-hk10-c1.dtb
> >>   dtb-$(CONFIG_ARCH_QCOM)        += ipq8074-hk10-c2.dtb
> >> +dtb-$(CONFIG_ARCH_QCOM)        += ipq9574-rdp433.dtb
> >>   dtb-$(CONFIG_ARCH_QCOM)        += msm8916-acer-a1-724.dtb
> >>   dtb-$(CONFIG_ARCH_QCOM)        += msm8916-alcatel-idol347.dtb
> >>   dtb-$(CONFIG_ARCH_QCOM)        += msm8916-asus-z00l.dtb
> >> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> >> new file mode 100644
> >> index 000000000000..2ce8e09e7565
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> >> @@ -0,0 +1,84 @@
> >> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> >> +/*
> >> + * IPQ9574 RDP433 board device tree source
> >> + *
> >> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
> >> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> >> + */
> >> +
> >> +/dts-v1/;
> >> +
> >> +#include "ipq9574.dtsi"
> >> +
> >> +/ {
> >> +       model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7";
> >> +       compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
> >> +
> >> +       aliases {
> >> +               serial0 = &blsp1_uart2;
> >> +       };
> >> +
> >> +       chosen {
> >> +               stdout-path = "serial0:115200n8";
> >> +       };
> >> +};
> >> +
> >> +&blsp1_uart2 {
> >> +       pinctrl-0 = <&uart2_pins>;
> >> +       pinctrl-names = "default";
> >> +       status = "okay";
> >> +};
> >> +
> >> +&sdhc_1 {
> >> +       pinctrl-0 = <&sdc_default_state>;
> >> +       pinctrl-names = "default";
> >> +       mmc-ddr-1_8v;
> >> +       mmc-hs200-1_8v;
> >> +       mmc-hs400-1_8v;
> >> +       mmc-hs400-enhanced-strobe;
> >> +       max-frequency = <384000000>;
> >> +       bus-width = <8>;
> >> +       status = "okay";
> >> +};
> >> +
> >> +&sleep_clk {
> >> +       clock-frequency = <32000>;
> >> +};
> >> +
> >> +&tlmm {
> >> +       sdc_default_state: sdc-default-state {
> >> +               clk-pins {
> >> +                       pins = "gpio5";
> >> +                       function = "sdc_clk";
> >> +                       drive-strength = <8>;
> >> +                       bias-disable;
> >> +               };
> >> +
> >> +               cmd-pins {
> >> +                       pins = "gpio4";
> >> +                       function = "sdc_cmd";
> >> +                       drive-strength = <8>;
> >> +                       bias-pull-up;
> >> +               };
> >> +
> >> +               data-pins {
> >> +                       pins = "gpio0", "gpio1", "gpio2",
> >> +                              "gpio3", "gpio6", "gpio7",
> >> +                              "gpio8", "gpio9";
> >> +                       function = "sdc_data";
> >> +                       drive-strength = <8>;
> >> +                       bias-pull-up;
> >> +               };
> >> +
> >> +               rclk-pins {
> >> +                       pins = "gpio10";
> >> +                       function = "sdc_rclk";
> >> +                       drive-strength = <8>;
> >> +                       bias-pull-down;
> >> +               };
> >> +       };
> >> +};
> >> +
> >> +&xo_board_clk {
> >> +       clock-frequency = <24000000>;
> >> +};
> >> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> >> new file mode 100644
> >> index 000000000000..3bb7435f5e7f
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> >> @@ -0,0 +1,270 @@
> >> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> >> +/*
> >> + * IPQ9574 SoC device tree source
> >> + *
> >> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
> >> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> >> + */
> >> +
> >> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> >> +#include <dt-bindings/clock/qcom,ipq9574-gcc.h>
> >> +#include <dt-bindings/reset/qcom,ipq9574-gcc.h>
> >> +
> >> +/ {
> >> +       interrupt-parent = <&intc>;
> >> +       #address-cells = <2>;
> >> +       #size-cells = <2>;
> >> +
> >> +       clocks {
> >> +               bias_pll_ubi_nc_clk: bias-pll-ubi-nc-clk {
> >> +                       compatible = "fixed-clock";
> >> +                       clock-frequency = <353000000>;
> >> +                       #clock-cells = <0>;
> >> +               };
> >
> > What is the source for this clock? With it clocking at 353 MHz, I
> > doubt that it is an external clock.
> bias_pll_ubi_nc_clk (353MHz)is a backup source
> for Q6_AXIM2_CLK/PCIE2_AXIM_CLK/PCIE3_AXIM_CLK/SNOC-CLK
> It is from the CMN_PLL, and is the same as that of PPE core clock.
> Do you suggest to move its clock-frequency to Board DT similar to
> xo/sleep clock?

No, I suggest moving it to the device where it originates. If it comes
from GCC, it should be provided by the GCC, not by the top-level fixed
clock.

> >
> >> +
> >> +               sleep_clk: sleep-clk {
> >> +                       compatible = "fixed-clock";
> >> +                       #clock-cells = <0>;
> >> +               };
> >> +
> >> +               xo_board_clk: xo-board-clk {
> >> +                       compatible = "fixed-clock";
> >> +                       #clock-cells = <0>;
> >> +               };
> >> +       };
> >
> > [skipped the rest]
> >
> Regards,
> Devi Priya



-- 
With best wishes
Dmitry
