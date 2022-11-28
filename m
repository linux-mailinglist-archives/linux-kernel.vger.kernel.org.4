Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960E963AE5C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbiK1REx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiK1RE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:04:27 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B89CF2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:04:14 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ha10so27517165ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JTDyEDKaD91giokM/cPj4vtolezotGe9v/1/QKs4b+k=;
        b=oFr5yw09GbKLgdRh/Ri2++F1p8zpGNHEY/WdT/dQtA9ZXaC5Y9uyvoJLAig2L1MKz2
         Qh6NJVAb0v34fCYDq+v/wCjT/bI0NXQarHxT3UmqtanyUPITYZUT40xlDwfPauX+uI0s
         FsqKz7njNQMtQGYuGx2qgrFxj5wFb7WNCEX5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JTDyEDKaD91giokM/cPj4vtolezotGe9v/1/QKs4b+k=;
        b=U14CJeod92Lh4Ns3tm7vQTXn3AnrUdSxPq1zPewzjp1uQJnwNTdSYHcQ9UbHfRNa+B
         JHXSZkp/kwUGByy/6dh8Ki747QImhORNag4gwR3PFknVyTnLPPTQzeGCYKLAKliU6SJ7
         ETr5caqq58ge3MX9yG0j1hKoxeqTZbtec03naRrLiNbFeM4WfIwK/YXVKZ1RVdm8i7hD
         fuMefDbxIRmKPWNv+KIEtQbPBvTgc6rhUCqt53lJPZW1HaVcEnPOpI2ACkah5tmF0PCP
         zOrEyTVrSrSyFbh+iUHo+ZjCwwK4dzeWc9siGS784IImPYm2posHvTMxAtwgQ9Pr2Jh7
         Do0A==
X-Gm-Message-State: ANoB5pmdv4vzJ1JHUd1h5NMkWe2Hf8B7JACcEhX93c2v/rV1bOy33+F4
        wmfHwSwFc7rM4SDc9HD2tZFheRRRcGgiKHO5
X-Google-Smtp-Source: AA0mqf7K3Tr85Fkbf4ak3nv+C7o0cAISTSuNaH+O4c/qjkPkkwoC7Cdqq9ZthPvp3zY7pcbZdV/D3g==
X-Received: by 2002:a17:906:444b:b0:7ad:dd43:5d53 with SMTP id i11-20020a170906444b00b007addd435d53mr26428090ejp.376.1669655052040;
        Mon, 28 Nov 2022 09:04:12 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id p27-20020a17090635db00b007081282cbd8sm5019485ejb.76.2022.11.28.09.04.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 09:04:11 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id v1so17891867wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:04:11 -0800 (PST)
X-Received: by 2002:a5d:4950:0:b0:242:1f80:6cd9 with SMTP id
 r16-20020a5d4950000000b002421f806cd9mr297512wrs.405.1669654727499; Mon, 28
 Nov 2022 08:58:47 -0800 (PST)
MIME-Version: 1.0
References: <20221125174415.v5.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
 <20221125174415.v5.2.I5fa17e079100361ef6809efa0bba2bf32f829e15@changeid>
In-Reply-To: <20221125174415.v5.2.I5fa17e079100361ef6809efa0bba2bf32f829e15@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Nov 2022 08:58:35 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wod-4GJGbr-9E+juHUCa3RN+3+wQ54jcM1CUyYRujSMQ@mail.gmail.com>
Message-ID: <CAD=FV=Wod-4GJGbr-9E+juHUCa3RN+3+wQ54jcM1CUyYRujSMQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] arm64: dts: qcom: sc7280: Add DT for sc7280-herobrine-zombie
To:     Owen Yang <ecs.taipeikernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Abner Yen <abner.yen@ecs.corp-partner.google.com>,
        Gavin Lee <gavin.lee@ecs.corp-partner.google.com>,
        Harvey <hunge@google.com>, Matthias Kaehlcke <mka@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Bob Moragues <moragues@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 25, 2022 at 1:45 AM Owen Yang <ecs.taipeikernel@gmail.com> wrote:
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
> new file mode 100644
> index 000000000000..d10362ecdafb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
> @@ -0,0 +1,313 @@
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
> +               vdd-supply = <&pp3300_z1>;
> +               post-power-on-delay-ms = <100>;

Do you have any documentation pointing to 100 ms really being needed
here? I know that leaving this number off is rarely a good idea, but
arbitrarily picking 100 isn't great either. It could either be much
too big or much too small.


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
> +&pm8350c_pwm_backlight{
> +       pwms = <&pm8350c_pwm 3 200000>;
> +};

This is not a pinctrl update so it doesn't belong in the "PINCTRL"
section. Please move this above right before the "pwmleds" node.

Having a comment like "Set the PWM period to 200 microseconds (5kHz
duty cycle") wouldn't hurt either.


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

There is still one extra entry in "gpio-line-names". Said another way,
the max GPIO number on sc7280 is GPIO 174. As you can see above, GPIO
170 is unnamed (it has a blank string). GPIO 171 has the name
"MOS_BLE_UART_TX", GPIO 172 has "MOS_BLE_UART_RX", and then you have
blank names for GPIO 173, 174, and 175. ...but there is no GPIO 175.

So, simply put, please remove one of the lines after the line with
"MOS_BLE_UART_RX"

-Doug
