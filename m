Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA48E62E065
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiKQPyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbiKQPyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:54:50 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EF01AF2E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:54:49 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id kt23so6094841ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sz7wfjeg8T345If88tOcbFDRpNURR2BmriELRXslcj8=;
        b=hrqH58M4N7Tw5Hx/U8a01y6RIWYVVZrmIbIRqRgYFtnLQNFYgE58WbhfxZKDsIT0Qq
         /5BjYYWTncoQT40bdyQiMM0xi9paZznL8yS1zFtttjH419VOR3g1QcYgnzKpMe6SLPEE
         YLPyWVSE5tkQpfpeLfI0qTWGwT8ZaYKgkgy7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sz7wfjeg8T345If88tOcbFDRpNURR2BmriELRXslcj8=;
        b=6RiEZw7lFfsSsnfrXeLyigLJXw0oQNGq1s8BdSco+aaeXZ7LrCCj0j7huchTmYl6NV
         AZpt6moO2320kItM+DcwwjZ9M3OM9I2CYSnkQfSEJskRxfxnTcLhyk1U+6LNnmkOBCjm
         o5ve0cAlkFArh67cqbHzz6OOLt24tQbNM/J+8ZBZZI6SL4Z/ys44YANwPGDZNHvj8G5h
         sxQJc2ITLlBk2QcKmE32uAEmLo9gJLcCNOF3VSDDOQTsya8QehIOaURgCWBt3HWnCKIU
         Ee82zeM4teZBavnWuYigo2uhQxpo7S4T49IqCoap9W7qw2REVUNj5kvh7jeSmSWCCH75
         /SUA==
X-Gm-Message-State: ANoB5pltZ4dcw7btLPP72XrgduiZFveEpCUw/XNk+bjH7YcTraoOo4Yd
        QljuscJJ54ukbJDwwM8YVS3cOKg4lNvKxblD
X-Google-Smtp-Source: AA0mqf61EVn15+gNoLMjMekePKV7B3kWWNWynYXzEfyMaLGH18tEZ1ulqwzEt9praQvduQNNySrBWw==
X-Received: by 2002:a17:906:84a:b0:7ae:1e53:3f97 with SMTP id f10-20020a170906084a00b007ae1e533f97mr2701923ejd.169.1668700487258;
        Thu, 17 Nov 2022 07:54:47 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id h29-20020a056402095d00b00467481df198sm691028edz.48.2022.11.17.07.54.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 07:54:46 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so4669729wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:54:46 -0800 (PST)
X-Received: by 2002:a05:600c:1e12:b0:3cf:9ad3:a20e with SMTP id
 ay18-20020a05600c1e1200b003cf9ad3a20emr2210234wmb.151.1668700486080; Thu, 17
 Nov 2022 07:54:46 -0800 (PST)
MIME-Version: 1.0
References: <20221117094251.1.I74849cf9699b8ff2e47f6028e28861101297549b@changeid>
In-Reply-To: <20221117094251.1.I74849cf9699b8ff2e47f6028e28861101297549b@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Nov 2022 07:54:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WwGJ++fBED9-AkCCWKBhWC-GUH7wJQJbpBmEELoniP2w@mail.gmail.com>
Message-ID: <CAD=FV=WwGJ++fBED9-AkCCWKBhWC-GUH7wJQJbpBmEELoniP2w@mail.gmail.com>
Subject: Re: [PATCH 1/2] Adding DT for zombie
To:     Owen Yang <ecs.taipeikernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Harvey <hunge@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 16, 2022 at 5:43 PM Owen Yang <ecs.taipeikernel@gmail.com> wrote:
>
> creating first device tree for zombie case.

Just like for patch #2, this probably should be a more proper
sentence, where the first word is capitalized. AKA:

Create the first device tree for sc7280-herobrine-zombie.

Also please note that ${SUBJECT} for this patch needs tags. Your
current ${SUBJECT} is "Adding DT for zombie". It should be something
like: "arm64: dts: qcom: sc7280: Add sc7280-herobrine-zombie".


> Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
> ---
>
>  arch/arm64/boot/dts/qcom/Makefile             |   2 +
>  .../dts/qcom/sc7280-herobrine-zombie-lte.dts  |  14 +
>  .../boot/dts/qcom/sc7280-herobrine-zombie.dts |  15 +
>  .../dts/qcom/sc7280-herobrine-zombie.dtsi     | 308 ++++++++++++++++++
>  4 files changed, 339 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-lte.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 384f2fa50646..e3226d7894ad 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -101,6 +101,8 @@ dtb-$(CONFIG_ARCH_QCOM)     += sc7280-herobrine-herobrine-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7280-herobrine-villager-r0.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7280-herobrine-villager-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7280-herobrine-villager-r1-lte.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += sc7280-herobrine-zombie.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += sc7280-herobrine-zombie-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7280-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7280-idp2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7280-crd-r3.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-lte.dts
> new file mode 100644
> index 000000000000..a76f5681581d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-lte.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Zombie board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +#include "sc7280-herobrine-zombie.dts"
> +#include "sc7280-herobrine-lte-sku.dtsi"
> +
> +/ {
> +       model = "Google Zombie with LTE";
> +       compatible = "google,zombie-sku512", "qcom,sc7280";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dts
> new file mode 100644
> index 000000000000..59a757e4c5fd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dts
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Zombie board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +/dts-v1/;
> +
> +#include "sc7280-herobrine-zombie.dtsi"

Since you're landing after commit 87548e54b86e ("arm64: dts: qcom:
sc7280: Add Google Herobrine WIFI SKU dts fragment"), you need:

#include "sc7280-herobrine-wifi-sku.dtsi"


> +/ {
> +       model = "Google Zombie";
> +       compatible = "google,zombie", "qcom,sc7280";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
> new file mode 100644
> index 000000000000..09e6d23c7ea7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
> @@ -0,0 +1,308 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Zombie board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +#include "sc7280-herobrine.dtsi"
> +#include "sc7280-herobrine-audio-rt5682.dtsi"
> +
> +/*
> + * ADDITIONS TO FIXED REGULATORS DEFINED IN PARENT DEVICE TREE FILES
> + *
> + * Sort order matches the order in the parent files (parents before children).
> + */
> +
> +&pp3300_codec {
> +       status = "okay";
> +};
> +
> +/* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
> +
> +ap_tp_i2c: &i2c0 {
> +       clock-frequency = <400000>;
> +       status = "okay";
> +
> +       trackpad: trackpad@15 {
> +               compatible = "hid-over-i2c";
> +               reg = <0x15>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&tp_int_odl>;
> +
> +               interrupt-parent = <&tlmm>;
> +               interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> +
> +               hid-descr-addr = <0x01>;
> +               vcc-supply = <&pp3300_z1>;

This isn't right. When you're using "hid-over-i2c" it's actually "vdd-supply".

I'll also note that I have seen precious few i2c touchpads that work
without "post-power-on-delay-ms". Maybe yours can?


> +               wakeup-source;
> +       };
> +};
> +
> +&ap_sar_sensor_i2c {
> +       status = "okay";
> +};
> +
> +&ap_sar_sensor0 {
> +       status = "okay";
> +};
> +
> +&ap_sar_sensor1 {
> +       status = "okay";
> +};
> +
> +&mdss_edp {
> +       status = "okay";
> +};
> +
> +&mdss_edp_phy {
> +       status = "okay";
> +};
> +
> +/* For nvme */
> +&pcie1 {
> +       status = "okay";
> +};
> +
> +/* For nvme */
> +&pcie1_phy {
> +       status = "okay";
> +};
> +
> +&pwmleds {
> +       status = "okay";
> +};
> +
> +/* For eMMC */
> +&sdhc_1 {
> +       status = "okay";
> +};
> +
> +/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
> +
> +&ts_rst_conn {
> +       bias-disable;
> +};
> +
> +/* PINCTRL - BOARD-SPECIFIC */
> +
> +/*
> + * Methodology for gpio-line-names:
> + * - If a pin goes to herobrine board and is named it gets that name.
> + * - If a pin goes to herobrine board and is not named, it gets no name.
> + * - If a pin is totally internal to Qcard then it gets Qcard name.
> + * - If a pin is not hooked up on Qcard, it gets no name.
> + */
> +
> +&pm8350c_gpios {
> +       gpio-line-names = "FLASH_STROBE_1",             /* 1 */
> +                         "AP_SUSPEND",
> +                         "PM8008_1_RST_N",
> +                         "",
> +                         "",
> +                         "",
> +                         "PMIC_EDP_BL_EN",
> +                         "PMIC_EDP_BL_PWM",
> +                         "";
> +};
> +
> +&tlmm {
> +       gpio-line-names = "AP_TP_I2C_SDA",              /* 0 */
> +                         "AP_TP_I2C_SCL",
> +                         "SSD_RST_L",
> +                         "PE_WAKE_ODL",
> +                         "AP_SAR_SDA",
> +                         "AP_SAR_SCL",
> +                         "PRB_SC_GPIO_6",
> +                         "TP_INT_ODL",
> +                         "HP_I2C_SDA",
> +                         "HP_I2C_SCL",
> +
> +                         "GNSS_L1_EN",                 /* 10 */
> +                         "GNSS_L5_EN",
> +                         "SPI_AP_MOSI",
> +                         "SPI_AP_MISO",
> +                         "SPI_AP_CLK",
> +                         "SPI_AP_CS0_L",
> +                         /*
> +                          * AP_FLASH_WP is crossystem ABI. Schematics
> +                          * call it BIOS_FLASH_WP_OD.
> +                          */
> +                         "AP_FLASH_WP",
> +                         "",
> +                         "AP_EC_INT_L",
> +                         "",
> +
> +                         "UF_CAM_RST_L",               /* 20 */
> +                         "WF_CAM_RST_L",
> +                         "UART_AP_TX_DBG_RX",
> +                         "UART_DBG_TX_AP_RX",
> +                         "",
> +                         "PM8008_IRQ_1",
> +                         "HOST2WLAN_SOL",
> +                         "WLAN2HOST_SOL",
> +                         "MOS_BT_UART_CTS",
> +                         "MOS_BT_UART_RFR",
> +
> +                         "MOS_BT_UART_TX",             /* 30 */
> +                         "MOS_BT_UART_RX",
> +                         "PRB_SC_GPIO_32",
> +                         "HUB_RST_L",
> +                         "",
> +                         "",
> +                         "AP_SPI_FP_MISO",
> +                         "AP_SPI_FP_MOSI",
> +                         "AP_SPI_FP_CLK",
> +                         "AP_SPI_FP_CS_L",
> +
> +                         "AP_EC_SPI_MISO",             /* 40 */
> +                         "AP_EC_SPI_MOSI",
> +                         "AP_EC_SPI_CLK",
> +                         "AP_EC_SPI_CS_L",
> +                         "LCM_RST_L",
> +                         "EARLY_EUD_N",
> +                         "",
> +                         "DP_HOT_PLUG_DET",
> +                         "IO_BRD_MLB_ID0",
> +                         "IO_BRD_MLB_ID1",
> +
> +                         "IO_BRD_MLB_ID2",             /* 50 */
> +                         "SSD_EN",
> +                         "TS_I2C_SDA_CONN",
> +                         "TS_I2C_CLK_CONN",
> +                         "TS_RST_CONN",
> +                         "TS_INT_CONN",
> +                         "AP_I2C_TPM_SDA",
> +                         "AP_I2C_TPM_SCL",
> +                         "PRB_SC_GPIO_58",
> +                         "PRB_SC_GPIO_59",
> +
> +                         "EDP_HOT_PLUG_DET_N",         /* 60 */
> +                         "FP_TO_AP_IRQ_L",
> +                         "",
> +                         "AMP_EN",
> +                         "CAM0_MCLK_GPIO_64",
> +                         "CAM1_MCLK_GPIO_65",
> +                         "WF_CAM_MCLK",
> +                         "PRB_SC_GPIO_67",
> +                         "FPMCU_BOOT0",
> +                         "UF_CAM_SDA",
> +
> +                         "UF_CAM_SCL",                 /* 70 */
> +                         "",
> +                         "",
> +                         "WF_CAM_SDA",
> +                         "WF_CAM_SCL",
> +                         "",
> +                         "",
> +                         "EN_FP_RAILS",
> +                         "FP_RST_L",
> +                         "PCIE1_CLKREQ_ODL",
> +
> +                         "EN_PP3300_DX_EDP",           /* 80 */
> +                         "US_EURO_HS_SEL",
> +                         "FORCED_USB_BOOT",
> +                         "WCD_RESET_N",
> +                         "MOS_WLAN_EN",
> +                         "MOS_BT_EN",
> +                         "MOS_SW_CTRL",
> +                         "MOS_PCIE0_RST",
> +                         "MOS_PCIE0_CLKREQ_N",
> +                         "MOS_PCIE0_WAKE_N",
> +
> +                         "MOS_LAA_AS_EN",              /* 90 */
> +                         "SD_CD_ODL",
> +                         "",
> +                         "",
> +                         "MOS_BT_WLAN_SLIMBUS_CLK",
> +                         "MOS_BT_WLAN_SLIMBUS_DAT0",
> +                         "HP_MCLK",
> +                         "HP_BCLK",
> +                         "HP_DOUT",
> +                         "HP_DIN",
> +
> +                         "HP_LRCLK",                   /* 100 */
> +                         "HP_IRQ",
> +                         "",
> +                         "",
> +                         "GSC_AP_INT_ODL",
> +                         "EN_PP3300_CODEC",
> +                         "AMP_BCLK",
> +                         "AMP_DIN",
> +                         "AMP_LRCLK",
> +                         "UIM1_DATA_GPIO_109",
> +
> +                         "UIM1_CLK_GPIO_110",          /* 110 */
> +                         "UIM1_RESET_GPIO_111",
> +                         "PRB_SC_GPIO_112",
> +                         "UIM0_DATA",
> +                         "UIM0_CLK",
> +                         "UIM0_RST",
> +                         "UIM0_PRESENT_ODL",
> +                         "SDM_RFFE0_CLK",
> +                         "SDM_RFFE0_DATA",
> +                         "WF_CAM_EN",
> +
> +                         "FASTBOOT_SEL_0",             /* 120 */
> +                         "SC_GPIO_121",
> +                         "FASTBOOT_SEL_1",
> +                         "SC_GPIO_123",
> +                         "FASTBOOT_SEL_2",
> +                         "SM_RFFE4_CLK_GRFC_8",
> +                         "SM_RFFE4_DATA_GRFC_9",
> +                         "WLAN_COEX_UART1_RX",
> +                         "WLAN_COEX_UART1_TX",
> +                         "PRB_SC_GPIO_129",
> +
> +                         "LCM_ID0",                    /* 130 */
> +                         "LCM_ID1",
> +                         "",
> +                         "SDR_QLINK_REQ",
> +                         "SDR_QLINK_EN",
> +                         "QLINK0_WMSS_RESET_N",
> +                         "SMR526_QLINK1_REQ",
> +                         "SMR526_QLINK1_EN",
> +                         "SMR526_QLINK1_WMSS_RESET_N",
> +                         "PRB_SC_GPIO_139",
> +
> +                         "SAR1_IRQ_ODL",               /* 140 */
> +                         "SAR0_IRQ_ODL",
> +                         "PRB_SC_GPIO_142",
> +                         "",
> +                         "WCD_SWR_TX_CLK",
> +                         "WCD_SWR_TX_DATA0",
> +                         "WCD_SWR_TX_DATA1",
> +                         "WCD_SWR_RX_CLK",
> +                         "WCD_SWR_RX_DATA0",
> +                         "WCD_SWR_RX_DATA1",
> +
> +                         "DMIC01_CLK",                 /* 150 */
> +                         "DMIC01_DATA",
> +                         "DMIC23_CLK",
> +                         "DMIC23_DATA",
> +                         "",
> +                         "",
> +                         "EC_IN_RW_ODL",
> +                         "HUB_EN",
> +                         "WCD_SWR_TX_DATA2",
> +                         "",
> +
> +                         "",                           /* 160 */
> +                         "",
> +                         "",
> +                         "",
> +                         "",
> +                         "",
> +                         "",
> +                         "",
> +                         "",
> +                         "",
> +
> +                         "",                           /* 170 */
> +                         "MOS_BLE_UART_TX",
> +                         "MOS_BLE_UART_RX",
> +                         "",
> +                         "",
> +                         "";

You seem to have one extra entry here compared to other herobrine
boards. Is that on purpose for some reason, or a mistake?
