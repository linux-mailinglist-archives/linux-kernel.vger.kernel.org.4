Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D89F6D7F87
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbjDEObK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238081AbjDEObH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:31:07 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9ED6E99
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:30:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l27so36435388wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680705052;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=EgLadd94O8XczIdn8YeDNTRC0ay46l/3/7AZ410rDto=;
        b=FWJq9Q1aODrqJntWSOyXbnNZ0SBHSDnck8NBF5YwVSAa5xsAoKATvHscFzmJaT+ssV
         +qHyfK7v+pgz3Sw4j4sSkWTYWXdSY40bEr5dYJjOrknxaIiWcDC4ZbdCQKgHsbotcHYK
         ue8qZ+qKHWP78RU0P7X/t03TR9uQG9XRUKr479v3Rjmy7Q1gOOygYnBZiAWtWAilvVaJ
         /Td0/17FzBRb6LHFhbcdu7ZeTEv1f4fyTRrw7oBRi6SyQ5hZj40m4KY/y/9FptlV8sUD
         s5ryAfBonG1trHXmoPOD8JIa3ZUxIiX1WDrQpX/giovXjA0gK26bPFhjlEYmROb732gy
         3WDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680705052;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgLadd94O8XczIdn8YeDNTRC0ay46l/3/7AZ410rDto=;
        b=UBX0lp2GKiE12b21PpBl1P6hGMqmXFpmG0DKZGv/lyH0HM1baoSCQmS37KYR8G1km/
         FJKQ9xav7YrIi/Oy1hbRL4ZNopPyAv9CMAAhhnXzdeIN7ewXxrFduuKzyqAIWsQm7A8d
         vy9mIvt+eODZYEMSm5fYsgQpv+6jP1lgPRqFHus9+bYwZVijh4uuLv0TAfv5dlkTff1V
         m6eNtICUzoyNo0x677VkqtEgaLw/AGJq/YfhupOQjMp/IuDBr0xyiQ9sXMF8DbMCPZfQ
         sma7aUAfSK54yvBQsDz8kQC/8L1kQoWqumRVnHRCwWomDqngXcn31rvOINZjlvNy739o
         6KmA==
X-Gm-Message-State: AAQBX9fcT7zD4dqOYmrKS0JJAhS6UPXFv61LvC6Ytsy7Sv5dyXBzRQpW
        x0/+JhHRkKdTQHDfdPzaJzxgbA==
X-Google-Smtp-Source: AKy350bKIW36MwRanv80akKe3S3w+vDG8PDIWtrl9tvFe8SCq2HgcGIvbVqSLvzGKUvHr5qZAdkeIw==
X-Received: by 2002:a5d:6391:0:b0:2e4:cc1c:1036 with SMTP id p17-20020a5d6391000000b002e4cc1c1036mr4406813wru.62.1680705051753;
        Wed, 05 Apr 2023 07:30:51 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r8-20020a5d4e48000000b002c70e60abd4sm15370114wrt.2.2023.04.05.07.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:30:51 -0700 (PDT)
References: <20230404155332.9571-1-ddrokosov@sberdevices.ru>
 <20230404155332.9571-7-ddrokosov@sberdevices.ru>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        neil.armstrong@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v12 6/6] clk: meson: a1: add Amlogic A1 Peripherals
 clock controller driver
Date:   Wed, 05 Apr 2023 16:13:44 +0200
In-reply-to: <20230404155332.9571-7-ddrokosov@sberdevices.ru>
Message-ID: <1j8rf6flk5.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 04 Apr 2023 at 18:53, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:

> +/* Array of all clocks registered by this provider */
> +static struct clk_hw_onecell_data a1_periphs_clks = {
> +	.hws = {
> +		/* DT exposed clocks */
> +		[CLKID_FIXPLL_IN]		= &fixpll_in.hw,
> +		[CLKID_USB_PHY_IN]		= &usb_phy_in.hw,
> +		[CLKID_USB_CTRL_IN]		= &usb_ctrl_in.hw,
> +		[CLKID_HIFIPLL_IN]		= &hifipll_in.hw,
> +		[CLKID_SYSPLL_IN]		= &syspll_in.hw,
> +		[CLKID_DDS_IN]			= &dds_in.hw,
> +		[CLKID_SYS]			= &sys.hw,
> +		[CLKID_CLKTREE]			= &clktree.hw,
> +		[CLKID_RESET_CTRL]		= &reset_ctrl.hw,
> +		[CLKID_ANALOG_CTRL]		= &analog_ctrl.hw,
> +		[CLKID_PWR_CTRL]		= &pwr_ctrl.hw,
> +		[CLKID_PAD_CTRL]		= &pad_ctrl.hw,
> +		[CLKID_SYS_CTRL]		= &sys_ctrl.hw,
> +		[CLKID_TEMP_SENSOR]		= &temp_sensor.hw,
> +		[CLKID_AM2AXI_DIV]		= &am2axi_dev.hw,
> +		[CLKID_SPICC_B]			= &spicc_b.hw,
> +		[CLKID_SPICC_A]			= &spicc_a.hw,
> +		[CLKID_MSR]			= &msr.hw,
> +		[CLKID_AUDIO]			= &audio.hw,
> +		[CLKID_JTAG_CTRL]		= &jtag_ctrl.hw,
> +		[CLKID_SARADC_EN]		= &saradc_en.hw,
> +		[CLKID_PWM_EF]			= &pwm_ef.hw,
> +		[CLKID_PWM_CD]			= &pwm_cd.hw,
> +		[CLKID_PWM_AB]			= &pwm_ab.hw,
> +		[CLKID_CEC]			= &cec.hw,
> +		[CLKID_I2C_S]			= &i2c_s.hw,
> +		[CLKID_IR_CTRL]			= &ir_ctrl.hw,
> +		[CLKID_I2C_M_D]			= &i2c_m_d.hw,
> +		[CLKID_I2C_M_C]			= &i2c_m_c.hw,
> +		[CLKID_I2C_M_B]			= &i2c_m_b.hw,
> +		[CLKID_I2C_M_A]			= &i2c_m_a.hw,
> +		[CLKID_ACODEC]			= &acodec.hw,
> +		[CLKID_OTP]			= &otp.hw,
> +		[CLKID_SD_EMMC_A]		= &sd_emmc_a.hw,
> +		[CLKID_USB_PHY]			= &usb_phy.hw,
> +		[CLKID_USB_CTRL]		= &usb_ctrl.hw,
> +		[CLKID_SYS_DSPB]		= &sys_dspb.hw,
> +		[CLKID_SYS_DSPA]		= &sys_dspa.hw,
> +		[CLKID_DMA]			= &dma.hw,
> +		[CLKID_IRQ_CTRL]		= &irq_ctrl.hw,
> +		[CLKID_NIC]			= &nic.hw,
> +		[CLKID_GIC]			= &gic.hw,
> +		[CLKID_UART_C]			= &uart_c.hw,
> +		[CLKID_UART_B]			= &uart_b.hw,
> +		[CLKID_UART_A]			= &uart_a.hw,
> +		[CLKID_SYS_PSRAM]		= &sys_psram.hw,
> +		[CLKID_RSA]			= &rsa.hw,
> +		[CLKID_CORESIGHT]		= &coresight.hw,
> +		[CLKID_AM2AXI_VAD]		= &am2axi_vad.hw,
> +		[CLKID_AUDIO_VAD]		= &audio_vad.hw,
> +		[CLKID_AXI_DMC]			= &axi_dmc.hw,
> +		[CLKID_AXI_PSRAM]		= &axi_psram.hw,
> +		[CLKID_RAMB]			= &ramb.hw,
> +		[CLKID_RAMA]			= &rama.hw,
> +		[CLKID_AXI_SPIFC]		= &axi_spifc.hw,
> +		[CLKID_AXI_NIC]			= &axi_nic.hw,
> +		[CLKID_AXI_DMA]			= &axi_dma.hw,
> +		[CLKID_CPU_CTRL]		= &cpu_ctrl.hw,
> +		[CLKID_ROM]			= &rom.hw,
> +		[CLKID_PROC_I2C]		= &prod_i2c.hw,
> +		[CLKID_DSPA_EN]			= &dspa_en.hw,
> +		[CLKID_DSPA_EN_NIC]		= &dspa_en_nic.hw,
> +		[CLKID_DSPB_EN]			= &dspb_en.hw,
> +		[CLKID_DSPB_EN_NIC]		= &dspb_en_nic.hw,
> +		[CLKID_RTC]			= &rtc.hw,
> +		[CLKID_CECA_32K]		= &ceca_32k_out.hw,
> +		[CLKID_CECB_32K]		= &cecb_32k_out.hw,
> +		[CLKID_24M]			= &clk_24m.hw,
> +		[CLKID_12M]			= &clk_12m.hw,
> +		[CLKID_FCLK_DIV2_DIVN]		= &fclk_div2_divn.hw,
> +		[CLKID_GEN]			= &gen.hw,
> +		[CLKID_SARADC]			= &saradc.hw,
> +		[CLKID_PWM_A]			= &pwm_a.hw,
> +		[CLKID_PWM_B]			= &pwm_b.hw,
> +		[CLKID_PWM_C]			= &pwm_c.hw,
> +		[CLKID_PWM_D]			= &pwm_d.hw,
> +		[CLKID_PWM_E]			= &pwm_e.hw,
> +		[CLKID_PWM_F]			= &pwm_f.hw,
> +		[CLKID_SPICC]			= &spicc.hw,
> +		[CLKID_TS]			= &ts.hw,
> +		[CLKID_SPIFC]			= &spifc.hw,
> +		[CLKID_USB_BUS]			= &usb_bus.hw,
> +		[CLKID_SD_EMMC]			= &sd_emmc.hw,
> +		[CLKID_PSRAM]			= &psram.hw,
> +		[CLKID_DMC]			= &dmc.hw,
> +		[CLKID_GEN_SEL]			= &gen_sel.hw,
> +		[CLKID_PWM_A_SEL]		= &pwm_a_sel.hw,
> +		[CLKID_PWM_B_SEL]		= &pwm_b_sel.hw,
> +		[CLKID_PWM_C_SEL]		= &pwm_c_sel.hw,
> +		[CLKID_PWM_D_SEL]		= &pwm_d_sel.hw,
> +		[CLKID_PWM_E_SEL]		= &pwm_e_sel.hw,
> +		[CLKID_PWM_F_SEL]		= &pwm_f_sel.hw,
> +		[CLKID_DSPA_A_SEL]		= &dspa_a_sel.hw,
> +		[CLKID_DSPA_B_SEL]		= &dspa_b_sel.hw,
> +		[CLKID_DSPB_A_SEL]		= &dspb_a_sel.hw,
> +		[CLKID_DSPB_B_SEL]		= &dspb_b_sel.hw,
> +		[CLKID_CECA_32K_SEL]		= &ceca_32k_sel.hw,
> +		[CLKID_CECA_32K_SEL_PRE]	= &ceca_32k_sel_pre.hw,
> +		[CLKID_CECB_32K_SEL]		= &cecb_32k_sel.hw,
> +		[CLKID_CECB_32K_SEL_PRE]	= &cecb_32k_sel_pre.hw,
> +
> +		/* Internal clocks */

There is no need to make such groups within the table.
I don't think such change was requested in the previous reviews.

Also grouping the IDs the way you did is a bad idea.

1) Since the clocks are registered in the order of the table, this will
make a lot of orphans during the registration of the controller. It does
work but it is not ideal performance wise. Whenever possible, it is
better to register the clocks from the roots to the leafs.

2) These 2 nice groups are going away the minute you add another clock which
was not part of the original submission. This is why IDs have no meaning,
no even groups.

> +		[CLKID_XTAL_IN]			= &xtal_in.hw,
> +		[CLKID_DSPA_SEL]		= &dspa_sel.hw,
> +		[CLKID_DSPB_SEL]		= &dspb_sel.hw,
> +		[CLKID_SARADC_SEL]		= &saradc_sel.hw,
> +		[CLKID_SYS_A_SEL]		= &sys_a_sel.hw,
> +		[CLKID_SYS_A_DIV]		= &sys_a_div.hw,
> +		[CLKID_SYS_A]			= &sys_a.hw,
> +		[CLKID_SYS_B_SEL]		= &sys_b_sel.hw,
> +		[CLKID_SYS_B_DIV]		= &sys_b_div.hw,
> +		[CLKID_SYS_B]			= &sys_b.hw,
> +		[CLKID_DSPA_A_DIV]		= &dspa_a_div.hw,
> +		[CLKID_DSPA_A]			= &dspa_a.hw,
> +		[CLKID_DSPA_B_DIV]		= &dspa_b_div.hw,
> +		[CLKID_DSPA_B]			= &dspa_b.hw,
> +		[CLKID_DSPB_A_DIV]		= &dspb_a_div.hw,
> +		[CLKID_DSPB_A]			= &dspb_a.hw,
> +		[CLKID_DSPB_B_DIV]		= &dspb_b_div.hw,
> +		[CLKID_DSPB_B]			= &dspb_b.hw,
> +		[CLKID_RTC_32K_IN]		= &rtc_32k_in.hw,
> +		[CLKID_RTC_32K_DIV]		= &rtc_32k_div.hw,
> +		[CLKID_RTC_32K_XTAL]		= &rtc_32k_xtal.hw,
> +		[CLKID_RTC_32K_SEL]		= &rtc_32k_sel.hw,
> +		[CLKID_CECB_32K_IN]		= &cecb_32k_in.hw,
> +		[CLKID_CECB_32K_DIV]		= &cecb_32k_div.hw,
> +		[CLKID_CECA_32K_IN]		= &ceca_32k_in.hw,
> +		[CLKID_CECA_32K_DIV]		= &ceca_32k_div.hw,
> +		[CLKID_DIV2_PRE]		= &fclk_div2_divn_pre.hw,
> +		[CLKID_24M_DIV2]		= &clk_24m_div2.hw,
> +		[CLKID_GEN_DIV]			= &gen_div.hw,
> +		[CLKID_SARADC_DIV]		= &saradc_div.hw,
> +		[CLKID_PWM_A_DIV]		= &pwm_a_div.hw,
> +		[CLKID_PWM_B_DIV]		= &pwm_b_div.hw,
> +		[CLKID_PWM_C_DIV]		= &pwm_c_div.hw,
> +		[CLKID_PWM_D_DIV]		= &pwm_d_div.hw,
> +		[CLKID_PWM_E_DIV]		= &pwm_e_div.hw,
> +		[CLKID_PWM_F_DIV]		= &pwm_f_div.hw,
> +		[CLKID_SPICC_SEL]		= &spicc_sel.hw,
> +		[CLKID_SPICC_DIV]		= &spicc_div.hw,
> +		[CLKID_SPICC_SEL2]		= &spicc_sel2.hw,
> +		[CLKID_TS_DIV]			= &ts_div.hw,
> +		[CLKID_SPIFC_SEL]		= &spifc_sel.hw,
> +		[CLKID_SPIFC_DIV]		= &spifc_div.hw,
> +		[CLKID_SPIFC_SEL2]		= &spifc_sel2.hw,
> +		[CLKID_USB_BUS_SEL]		= &usb_bus_sel.hw,
> +		[CLKID_USB_BUS_DIV]		= &usb_bus_div.hw,
> +		[CLKID_SD_EMMC_SEL]		= &sd_emmc_sel.hw,
> +		[CLKID_SD_EMMC_DIV]		= &sd_emmc_div.hw,
> +		[CLKID_SD_EMMC_SEL2]		= &sd_emmc_sel2.hw,
> +		[CLKID_PSRAM_SEL]		= &psram_sel.hw,
> +		[CLKID_PSRAM_DIV]		= &psram_div.hw,
> +		[CLKID_PSRAM_SEL2]		= &psram_sel2.hw,
> +		[CLKID_DMC_SEL]			= &dmc_sel.hw,
> +		[CLKID_DMC_DIV]			= &dmc_div.hw,
> +		[CLKID_DMC_SEL2]		= &dmc_sel2.hw,
> +
> +		[NR_CLKS]			= NULL,
> +	},
> +	.num = NR_CLKS,
> +};
