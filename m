Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E73725C45
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240108AbjFGK5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239957AbjFGK5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:57:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD4F211B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:56:27 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f61530506aso72483245e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 03:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686135386; x=1688727386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5UCcyUpwLNcnfOQRBbrx1db0/IlLF9CgKxb2NfZYK4=;
        b=xgMT+yaNMf4T04KGzH6A+fqLakJ1cBP8DthakruzTxXpPu/JloPU/X0TPFiq086cgU
         pMzDEug38HiJ1mAsJaCoUfKRTudJNqiiB6F8XTfCO71BBpFFNgCiWnrWGy93dAzT4uG3
         fTdYhaeCsFFAAPSqA0OU8XQcJzQejOy9CFXnSAPA9l3WpySnvavzqciN2z7SatqBCtdK
         TZ+UHiVBtsgRKTvovmSHWk8VvlePqerby6E5NckPaqS9yiZgPWKWC+GGELV90TQP6IhM
         D9Wvz0L6gPUD4bCn6pcOGviPCn8lIzVaknwDF5T30KwQABakY+2zINSaxJBaK0q7fuM0
         /FEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686135386; x=1688727386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5UCcyUpwLNcnfOQRBbrx1db0/IlLF9CgKxb2NfZYK4=;
        b=gDstjHEVaJZnQ2X+PH6QQ5Z5qbR0kvEamxLfI1sm04+6B0B8VTm+TbAm+XEqoFsagu
         wZmLOL2WaEtGDjrTuLpSfg0l3uIRlGA3UVkTydD4jJeLuwOI9UcYwSwTXok6My3YGdC5
         kzWqOmcoKxcNN7Y4Sne7qqcjy2OjRXedt3WALNL+e4BHvMDNDOUHte5oiWvpXuqCw/Z7
         D35GoGgJrULMCDg6hBNzEe+HF6qHYmCuu4hBtnwEftbZXpqVW+jZypEWi3W7jNS7jpF+
         jyipMaaS183vmNsKsKfK6oUSF+lqOFwkdGEi/1q9g+5B0borDcn1dZVRdXJ/XCoD+iS1
         o56A==
X-Gm-Message-State: AC+VfDzyd+U7Vn3+sie3JELknWrGlIUASBj8LUWTOXy3RdaAr46O3x+T
        xFp2uIP5O0lxTfUEEjGq120MXw==
X-Google-Smtp-Source: ACHHUZ7zICNKDWCIbYPNOFEfKsFrkxPjS7thp/kurafFmSFgfnMhwyogs7ZoZuS5TmPu0b3fIjAKzg==
X-Received: by 2002:a1c:7215:0:b0:3f5:d0b8:4a53 with SMTP id n21-20020a1c7215000000b003f5d0b84a53mr4921271wmc.34.1686135386144;
        Wed, 07 Jun 2023 03:56:26 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c290a00b003f60faa4612sm1761879wmd.22.2023.06.07.03.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:56:25 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Jun 2023 12:56:14 +0200
Subject: [PATCH 03/18] clk: meson: migrate a1 clock drivers out of
 hw_onecell_data to drop NR_CLKS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-3-9676afa6b22c@linaro.org>
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=18293;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=4IHW0DqHIQik6UppDcGfS5DExiopyllD2RRqJLqazLs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkgGJPBtbh3lb8jW/hTzf1ZevUlTwj661m/KeOwcgK
 TVOCiuGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIBiTwAKCRB33NvayMhJ0fdpD/
 4pvGsSZH+XLQOwklUSynm0t1aYA7xanR3kQOgxGe8hWK+huH2wZWxtHdRbB+zd58deMHk7bJoryMe1
 0VnRhVc400x9IXEDIhV8Rdq6pgr7s5IsvEw+xN9QXbhmxBB6nM6I2gO1ph0VpVyTO80UxdCv0ViESR
 wMNWqAhd8X7GqnMFzYYx3jI1k3VO1VbZ+25d0dYcbExiKffNGgxeeLeK90NkKj9HwS9a+cuyRfKICa
 IxjmBXc4Mw8rLnIYlP/IEE8xJBX2WImlQP1IXGok4U7HhneHdYZG6gcI5eAwKYSVVSnXv0bHHLKmMa
 NqQiDWwh1wRRtQPd3LylVcPB/BOe3PMFoUjV23EY7i1s8X7gHjGtwYPZ8p8PinNATnHtvPRrfW9RZl
 Mkces8XVndV6/s7KsfYM5d7Pk9EexuFg5evIiKrFBrQ26/kpud/iGscJpjExxfutc5m1zUBE/oLzyl
 glc1Nu6AlUXINu84ztLiNr0JmDyjc4IpypBp0WTYbmZ9l1R2jjm+g5/L1pPw6Xa6IxWlZGEZGg3xp+
 WHVWuRxWlTOafOkw7wjuzLc5o4+NOxQpwQQOoviPy/wlLjXYDzKQXw/JtNOFetOfdD4KbfN5+bR7X0
 yJpc9zSNpofegvJ/CY4B63jgjaqszFYHDvsiuaW6lg2UReATxui27DLZJiRg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The way hw_onecell_data is declared:
struct clk_hw_onecell_data {
	unsigned int num;
	struct clk_hw *hws[];
};

makes it impossible to have the clk_hw table declared outside while
using ARRAY_SIZE() to determine ".num" due to ".hws" being a flexible
array member.

Completely move out of hw_onecell_data and add a custom
devm_of_clk_add_hw_provider() "get" callback to retrieve the clk_hw
in order to finally get rid on the NR_CLKS define.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/a1-peripherals.c | 343 +++++++++++++++++++------------------
 drivers/clk/meson/a1-peripherals.h |   1 -
 drivers/clk/meson/a1-pll.c         |  57 ++++--
 drivers/clk/meson/a1-pll.h         |   1 -
 4 files changed, 219 insertions(+), 183 deletions(-)

diff --git a/drivers/clk/meson/a1-peripherals.c b/drivers/clk/meson/a1-peripherals.c
index b320134fefeb..094246cb5f6c 100644
--- a/drivers/clk/meson/a1-peripherals.c
+++ b/drivers/clk/meson/a1-peripherals.c
@@ -1866,165 +1866,161 @@ static MESON_GATE(rom,		AXI_CLK_EN,	11);
 static MESON_GATE(prod_i2c,	AXI_CLK_EN,	12);
 
 /* Array of all clocks registered by this provider */
-static struct clk_hw_onecell_data a1_periphs_clks = {
-	.hws = {
-		[CLKID_XTAL_IN]			= &xtal_in.hw,
-		[CLKID_FIXPLL_IN]		= &fixpll_in.hw,
-		[CLKID_USB_PHY_IN]		= &usb_phy_in.hw,
-		[CLKID_USB_CTRL_IN]		= &usb_ctrl_in.hw,
-		[CLKID_HIFIPLL_IN]		= &hifipll_in.hw,
-		[CLKID_SYSPLL_IN]		= &syspll_in.hw,
-		[CLKID_DDS_IN]			= &dds_in.hw,
-		[CLKID_SYS]			= &sys.hw,
-		[CLKID_CLKTREE]			= &clktree.hw,
-		[CLKID_RESET_CTRL]		= &reset_ctrl.hw,
-		[CLKID_ANALOG_CTRL]		= &analog_ctrl.hw,
-		[CLKID_PWR_CTRL]		= &pwr_ctrl.hw,
-		[CLKID_PAD_CTRL]		= &pad_ctrl.hw,
-		[CLKID_SYS_CTRL]		= &sys_ctrl.hw,
-		[CLKID_TEMP_SENSOR]		= &temp_sensor.hw,
-		[CLKID_AM2AXI_DIV]		= &am2axi_dev.hw,
-		[CLKID_SPICC_B]			= &spicc_b.hw,
-		[CLKID_SPICC_A]			= &spicc_a.hw,
-		[CLKID_MSR]			= &msr.hw,
-		[CLKID_AUDIO]			= &audio.hw,
-		[CLKID_JTAG_CTRL]		= &jtag_ctrl.hw,
-		[CLKID_SARADC_EN]		= &saradc_en.hw,
-		[CLKID_PWM_EF]			= &pwm_ef.hw,
-		[CLKID_PWM_CD]			= &pwm_cd.hw,
-		[CLKID_PWM_AB]			= &pwm_ab.hw,
-		[CLKID_CEC]			= &cec.hw,
-		[CLKID_I2C_S]			= &i2c_s.hw,
-		[CLKID_IR_CTRL]			= &ir_ctrl.hw,
-		[CLKID_I2C_M_D]			= &i2c_m_d.hw,
-		[CLKID_I2C_M_C]			= &i2c_m_c.hw,
-		[CLKID_I2C_M_B]			= &i2c_m_b.hw,
-		[CLKID_I2C_M_A]			= &i2c_m_a.hw,
-		[CLKID_ACODEC]			= &acodec.hw,
-		[CLKID_OTP]			= &otp.hw,
-		[CLKID_SD_EMMC_A]		= &sd_emmc_a.hw,
-		[CLKID_USB_PHY]			= &usb_phy.hw,
-		[CLKID_USB_CTRL]		= &usb_ctrl.hw,
-		[CLKID_SYS_DSPB]		= &sys_dspb.hw,
-		[CLKID_SYS_DSPA]		= &sys_dspa.hw,
-		[CLKID_DMA]			= &dma.hw,
-		[CLKID_IRQ_CTRL]		= &irq_ctrl.hw,
-		[CLKID_NIC]			= &nic.hw,
-		[CLKID_GIC]			= &gic.hw,
-		[CLKID_UART_C]			= &uart_c.hw,
-		[CLKID_UART_B]			= &uart_b.hw,
-		[CLKID_UART_A]			= &uart_a.hw,
-		[CLKID_SYS_PSRAM]		= &sys_psram.hw,
-		[CLKID_RSA]			= &rsa.hw,
-		[CLKID_CORESIGHT]		= &coresight.hw,
-		[CLKID_AM2AXI_VAD]		= &am2axi_vad.hw,
-		[CLKID_AUDIO_VAD]		= &audio_vad.hw,
-		[CLKID_AXI_DMC]			= &axi_dmc.hw,
-		[CLKID_AXI_PSRAM]		= &axi_psram.hw,
-		[CLKID_RAMB]			= &ramb.hw,
-		[CLKID_RAMA]			= &rama.hw,
-		[CLKID_AXI_SPIFC]		= &axi_spifc.hw,
-		[CLKID_AXI_NIC]			= &axi_nic.hw,
-		[CLKID_AXI_DMA]			= &axi_dma.hw,
-		[CLKID_CPU_CTRL]		= &cpu_ctrl.hw,
-		[CLKID_ROM]			= &rom.hw,
-		[CLKID_PROC_I2C]		= &prod_i2c.hw,
-		[CLKID_DSPA_SEL]		= &dspa_sel.hw,
-		[CLKID_DSPB_SEL]		= &dspb_sel.hw,
-		[CLKID_DSPA_EN]			= &dspa_en.hw,
-		[CLKID_DSPA_EN_NIC]		= &dspa_en_nic.hw,
-		[CLKID_DSPB_EN]			= &dspb_en.hw,
-		[CLKID_DSPB_EN_NIC]		= &dspb_en_nic.hw,
-		[CLKID_RTC]			= &rtc.hw,
-		[CLKID_CECA_32K]		= &ceca_32k_out.hw,
-		[CLKID_CECB_32K]		= &cecb_32k_out.hw,
-		[CLKID_24M]			= &clk_24m.hw,
-		[CLKID_12M]			= &clk_12m.hw,
-		[CLKID_FCLK_DIV2_DIVN]		= &fclk_div2_divn.hw,
-		[CLKID_GEN]			= &gen.hw,
-		[CLKID_SARADC_SEL]		= &saradc_sel.hw,
-		[CLKID_SARADC]			= &saradc.hw,
-		[CLKID_PWM_A]			= &pwm_a.hw,
-		[CLKID_PWM_B]			= &pwm_b.hw,
-		[CLKID_PWM_C]			= &pwm_c.hw,
-		[CLKID_PWM_D]			= &pwm_d.hw,
-		[CLKID_PWM_E]			= &pwm_e.hw,
-		[CLKID_PWM_F]			= &pwm_f.hw,
-		[CLKID_SPICC]			= &spicc.hw,
-		[CLKID_TS]			= &ts.hw,
-		[CLKID_SPIFC]			= &spifc.hw,
-		[CLKID_USB_BUS]			= &usb_bus.hw,
-		[CLKID_SD_EMMC]			= &sd_emmc.hw,
-		[CLKID_PSRAM]			= &psram.hw,
-		[CLKID_DMC]			= &dmc.hw,
-		[CLKID_SYS_A_SEL]		= &sys_a_sel.hw,
-		[CLKID_SYS_A_DIV]		= &sys_a_div.hw,
-		[CLKID_SYS_A]			= &sys_a.hw,
-		[CLKID_SYS_B_SEL]		= &sys_b_sel.hw,
-		[CLKID_SYS_B_DIV]		= &sys_b_div.hw,
-		[CLKID_SYS_B]			= &sys_b.hw,
-		[CLKID_DSPA_A_SEL]		= &dspa_a_sel.hw,
-		[CLKID_DSPA_A_DIV]		= &dspa_a_div.hw,
-		[CLKID_DSPA_A]			= &dspa_a.hw,
-		[CLKID_DSPA_B_SEL]		= &dspa_b_sel.hw,
-		[CLKID_DSPA_B_DIV]		= &dspa_b_div.hw,
-		[CLKID_DSPA_B]			= &dspa_b.hw,
-		[CLKID_DSPB_A_SEL]		= &dspb_a_sel.hw,
-		[CLKID_DSPB_A_DIV]		= &dspb_a_div.hw,
-		[CLKID_DSPB_A]			= &dspb_a.hw,
-		[CLKID_DSPB_B_SEL]		= &dspb_b_sel.hw,
-		[CLKID_DSPB_B_DIV]		= &dspb_b_div.hw,
-		[CLKID_DSPB_B]			= &dspb_b.hw,
-		[CLKID_RTC_32K_IN]		= &rtc_32k_in.hw,
-		[CLKID_RTC_32K_DIV]		= &rtc_32k_div.hw,
-		[CLKID_RTC_32K_XTAL]		= &rtc_32k_xtal.hw,
-		[CLKID_RTC_32K_SEL]		= &rtc_32k_sel.hw,
-		[CLKID_CECB_32K_IN]		= &cecb_32k_in.hw,
-		[CLKID_CECB_32K_DIV]		= &cecb_32k_div.hw,
-		[CLKID_CECB_32K_SEL_PRE]	= &cecb_32k_sel_pre.hw,
-		[CLKID_CECB_32K_SEL]		= &cecb_32k_sel.hw,
-		[CLKID_CECA_32K_IN]		= &ceca_32k_in.hw,
-		[CLKID_CECA_32K_DIV]		= &ceca_32k_div.hw,
-		[CLKID_CECA_32K_SEL_PRE]	= &ceca_32k_sel_pre.hw,
-		[CLKID_CECA_32K_SEL]		= &ceca_32k_sel.hw,
-		[CLKID_DIV2_PRE]		= &fclk_div2_divn_pre.hw,
-		[CLKID_24M_DIV2]		= &clk_24m_div2.hw,
-		[CLKID_GEN_SEL]			= &gen_sel.hw,
-		[CLKID_GEN_DIV]			= &gen_div.hw,
-		[CLKID_SARADC_DIV]		= &saradc_div.hw,
-		[CLKID_PWM_A_SEL]		= &pwm_a_sel.hw,
-		[CLKID_PWM_A_DIV]		= &pwm_a_div.hw,
-		[CLKID_PWM_B_SEL]		= &pwm_b_sel.hw,
-		[CLKID_PWM_B_DIV]		= &pwm_b_div.hw,
-		[CLKID_PWM_C_SEL]		= &pwm_c_sel.hw,
-		[CLKID_PWM_C_DIV]		= &pwm_c_div.hw,
-		[CLKID_PWM_D_SEL]		= &pwm_d_sel.hw,
-		[CLKID_PWM_D_DIV]		= &pwm_d_div.hw,
-		[CLKID_PWM_E_SEL]		= &pwm_e_sel.hw,
-		[CLKID_PWM_E_DIV]		= &pwm_e_div.hw,
-		[CLKID_PWM_F_SEL]		= &pwm_f_sel.hw,
-		[CLKID_PWM_F_DIV]		= &pwm_f_div.hw,
-		[CLKID_SPICC_SEL]		= &spicc_sel.hw,
-		[CLKID_SPICC_DIV]		= &spicc_div.hw,
-		[CLKID_SPICC_SEL2]		= &spicc_sel2.hw,
-		[CLKID_TS_DIV]			= &ts_div.hw,
-		[CLKID_SPIFC_SEL]		= &spifc_sel.hw,
-		[CLKID_SPIFC_DIV]		= &spifc_div.hw,
-		[CLKID_SPIFC_SEL2]		= &spifc_sel2.hw,
-		[CLKID_USB_BUS_SEL]		= &usb_bus_sel.hw,
-		[CLKID_USB_BUS_DIV]		= &usb_bus_div.hw,
-		[CLKID_SD_EMMC_SEL]		= &sd_emmc_sel.hw,
-		[CLKID_SD_EMMC_DIV]		= &sd_emmc_div.hw,
-		[CLKID_SD_EMMC_SEL2]		= &sd_emmc_sel2.hw,
-		[CLKID_PSRAM_SEL]		= &psram_sel.hw,
-		[CLKID_PSRAM_DIV]		= &psram_div.hw,
-		[CLKID_PSRAM_SEL2]		= &psram_sel2.hw,
-		[CLKID_DMC_SEL]			= &dmc_sel.hw,
-		[CLKID_DMC_DIV]			= &dmc_div.hw,
-		[CLKID_DMC_SEL2]		= &dmc_sel2.hw,
-		[NR_CLKS]			= NULL,
-	},
-	.num = NR_CLKS,
+static struct clk_hw *a1_periphs_hw_clks[] = {
+	[CLKID_XTAL_IN]			= &xtal_in.hw,
+	[CLKID_FIXPLL_IN]		= &fixpll_in.hw,
+	[CLKID_USB_PHY_IN]		= &usb_phy_in.hw,
+	[CLKID_USB_CTRL_IN]		= &usb_ctrl_in.hw,
+	[CLKID_HIFIPLL_IN]		= &hifipll_in.hw,
+	[CLKID_SYSPLL_IN]		= &syspll_in.hw,
+	[CLKID_DDS_IN]			= &dds_in.hw,
+	[CLKID_SYS]			= &sys.hw,
+	[CLKID_CLKTREE]			= &clktree.hw,
+	[CLKID_RESET_CTRL]		= &reset_ctrl.hw,
+	[CLKID_ANALOG_CTRL]		= &analog_ctrl.hw,
+	[CLKID_PWR_CTRL]		= &pwr_ctrl.hw,
+	[CLKID_PAD_CTRL]		= &pad_ctrl.hw,
+	[CLKID_SYS_CTRL]		= &sys_ctrl.hw,
+	[CLKID_TEMP_SENSOR]		= &temp_sensor.hw,
+	[CLKID_AM2AXI_DIV]		= &am2axi_dev.hw,
+	[CLKID_SPICC_B]			= &spicc_b.hw,
+	[CLKID_SPICC_A]			= &spicc_a.hw,
+	[CLKID_MSR]			= &msr.hw,
+	[CLKID_AUDIO]			= &audio.hw,
+	[CLKID_JTAG_CTRL]		= &jtag_ctrl.hw,
+	[CLKID_SARADC_EN]		= &saradc_en.hw,
+	[CLKID_PWM_EF]			= &pwm_ef.hw,
+	[CLKID_PWM_CD]			= &pwm_cd.hw,
+	[CLKID_PWM_AB]			= &pwm_ab.hw,
+	[CLKID_CEC]			= &cec.hw,
+	[CLKID_I2C_S]			= &i2c_s.hw,
+	[CLKID_IR_CTRL]			= &ir_ctrl.hw,
+	[CLKID_I2C_M_D]			= &i2c_m_d.hw,
+	[CLKID_I2C_M_C]			= &i2c_m_c.hw,
+	[CLKID_I2C_M_B]			= &i2c_m_b.hw,
+	[CLKID_I2C_M_A]			= &i2c_m_a.hw,
+	[CLKID_ACODEC]			= &acodec.hw,
+	[CLKID_OTP]			= &otp.hw,
+	[CLKID_SD_EMMC_A]		= &sd_emmc_a.hw,
+	[CLKID_USB_PHY]			= &usb_phy.hw,
+	[CLKID_USB_CTRL]		= &usb_ctrl.hw,
+	[CLKID_SYS_DSPB]		= &sys_dspb.hw,
+	[CLKID_SYS_DSPA]		= &sys_dspa.hw,
+	[CLKID_DMA]			= &dma.hw,
+	[CLKID_IRQ_CTRL]		= &irq_ctrl.hw,
+	[CLKID_NIC]			= &nic.hw,
+	[CLKID_GIC]			= &gic.hw,
+	[CLKID_UART_C]			= &uart_c.hw,
+	[CLKID_UART_B]			= &uart_b.hw,
+	[CLKID_UART_A]			= &uart_a.hw,
+	[CLKID_SYS_PSRAM]		= &sys_psram.hw,
+	[CLKID_RSA]			= &rsa.hw,
+	[CLKID_CORESIGHT]		= &coresight.hw,
+	[CLKID_AM2AXI_VAD]		= &am2axi_vad.hw,
+	[CLKID_AUDIO_VAD]		= &audio_vad.hw,
+	[CLKID_AXI_DMC]			= &axi_dmc.hw,
+	[CLKID_AXI_PSRAM]		= &axi_psram.hw,
+	[CLKID_RAMB]			= &ramb.hw,
+	[CLKID_RAMA]			= &rama.hw,
+	[CLKID_AXI_SPIFC]		= &axi_spifc.hw,
+	[CLKID_AXI_NIC]			= &axi_nic.hw,
+	[CLKID_AXI_DMA]			= &axi_dma.hw,
+	[CLKID_CPU_CTRL]		= &cpu_ctrl.hw,
+	[CLKID_ROM]			= &rom.hw,
+	[CLKID_PROC_I2C]		= &prod_i2c.hw,
+	[CLKID_DSPA_SEL]		= &dspa_sel.hw,
+	[CLKID_DSPB_SEL]		= &dspb_sel.hw,
+	[CLKID_DSPA_EN]			= &dspa_en.hw,
+	[CLKID_DSPA_EN_NIC]		= &dspa_en_nic.hw,
+	[CLKID_DSPB_EN]			= &dspb_en.hw,
+	[CLKID_DSPB_EN_NIC]		= &dspb_en_nic.hw,
+	[CLKID_RTC]			= &rtc.hw,
+	[CLKID_CECA_32K]		= &ceca_32k_out.hw,
+	[CLKID_CECB_32K]		= &cecb_32k_out.hw,
+	[CLKID_24M]			= &clk_24m.hw,
+	[CLKID_12M]			= &clk_12m.hw,
+	[CLKID_FCLK_DIV2_DIVN]		= &fclk_div2_divn.hw,
+	[CLKID_GEN]			= &gen.hw,
+	[CLKID_SARADC_SEL]		= &saradc_sel.hw,
+	[CLKID_SARADC]			= &saradc.hw,
+	[CLKID_PWM_A]			= &pwm_a.hw,
+	[CLKID_PWM_B]			= &pwm_b.hw,
+	[CLKID_PWM_C]			= &pwm_c.hw,
+	[CLKID_PWM_D]			= &pwm_d.hw,
+	[CLKID_PWM_E]			= &pwm_e.hw,
+	[CLKID_PWM_F]			= &pwm_f.hw,
+	[CLKID_SPICC]			= &spicc.hw,
+	[CLKID_TS]			= &ts.hw,
+	[CLKID_SPIFC]			= &spifc.hw,
+	[CLKID_USB_BUS]			= &usb_bus.hw,
+	[CLKID_SD_EMMC]			= &sd_emmc.hw,
+	[CLKID_PSRAM]			= &psram.hw,
+	[CLKID_DMC]			= &dmc.hw,
+	[CLKID_SYS_A_SEL]		= &sys_a_sel.hw,
+	[CLKID_SYS_A_DIV]		= &sys_a_div.hw,
+	[CLKID_SYS_A]			= &sys_a.hw,
+	[CLKID_SYS_B_SEL]		= &sys_b_sel.hw,
+	[CLKID_SYS_B_DIV]		= &sys_b_div.hw,
+	[CLKID_SYS_B]			= &sys_b.hw,
+	[CLKID_DSPA_A_SEL]		= &dspa_a_sel.hw,
+	[CLKID_DSPA_A_DIV]		= &dspa_a_div.hw,
+	[CLKID_DSPA_A]			= &dspa_a.hw,
+	[CLKID_DSPA_B_SEL]		= &dspa_b_sel.hw,
+	[CLKID_DSPA_B_DIV]		= &dspa_b_div.hw,
+	[CLKID_DSPA_B]			= &dspa_b.hw,
+	[CLKID_DSPB_A_SEL]		= &dspb_a_sel.hw,
+	[CLKID_DSPB_A_DIV]		= &dspb_a_div.hw,
+	[CLKID_DSPB_A]			= &dspb_a.hw,
+	[CLKID_DSPB_B_SEL]		= &dspb_b_sel.hw,
+	[CLKID_DSPB_B_DIV]		= &dspb_b_div.hw,
+	[CLKID_DSPB_B]			= &dspb_b.hw,
+	[CLKID_RTC_32K_IN]		= &rtc_32k_in.hw,
+	[CLKID_RTC_32K_DIV]		= &rtc_32k_div.hw,
+	[CLKID_RTC_32K_XTAL]		= &rtc_32k_xtal.hw,
+	[CLKID_RTC_32K_SEL]		= &rtc_32k_sel.hw,
+	[CLKID_CECB_32K_IN]		= &cecb_32k_in.hw,
+	[CLKID_CECB_32K_DIV]		= &cecb_32k_div.hw,
+	[CLKID_CECB_32K_SEL_PRE]	= &cecb_32k_sel_pre.hw,
+	[CLKID_CECB_32K_SEL]		= &cecb_32k_sel.hw,
+	[CLKID_CECA_32K_IN]		= &ceca_32k_in.hw,
+	[CLKID_CECA_32K_DIV]		= &ceca_32k_div.hw,
+	[CLKID_CECA_32K_SEL_PRE]	= &ceca_32k_sel_pre.hw,
+	[CLKID_CECA_32K_SEL]		= &ceca_32k_sel.hw,
+	[CLKID_DIV2_PRE]		= &fclk_div2_divn_pre.hw,
+	[CLKID_24M_DIV2]		= &clk_24m_div2.hw,
+	[CLKID_GEN_SEL]			= &gen_sel.hw,
+	[CLKID_GEN_DIV]			= &gen_div.hw,
+	[CLKID_SARADC_DIV]		= &saradc_div.hw,
+	[CLKID_PWM_A_SEL]		= &pwm_a_sel.hw,
+	[CLKID_PWM_A_DIV]		= &pwm_a_div.hw,
+	[CLKID_PWM_B_SEL]		= &pwm_b_sel.hw,
+	[CLKID_PWM_B_DIV]		= &pwm_b_div.hw,
+	[CLKID_PWM_C_SEL]		= &pwm_c_sel.hw,
+	[CLKID_PWM_C_DIV]		= &pwm_c_div.hw,
+	[CLKID_PWM_D_SEL]		= &pwm_d_sel.hw,
+	[CLKID_PWM_D_DIV]		= &pwm_d_div.hw,
+	[CLKID_PWM_E_SEL]		= &pwm_e_sel.hw,
+	[CLKID_PWM_E_DIV]		= &pwm_e_div.hw,
+	[CLKID_PWM_F_SEL]		= &pwm_f_sel.hw,
+	[CLKID_PWM_F_DIV]		= &pwm_f_div.hw,
+	[CLKID_SPICC_SEL]		= &spicc_sel.hw,
+	[CLKID_SPICC_DIV]		= &spicc_div.hw,
+	[CLKID_SPICC_SEL2]		= &spicc_sel2.hw,
+	[CLKID_TS_DIV]			= &ts_div.hw,
+	[CLKID_SPIFC_SEL]		= &spifc_sel.hw,
+	[CLKID_SPIFC_DIV]		= &spifc_div.hw,
+	[CLKID_SPIFC_SEL2]		= &spifc_sel2.hw,
+	[CLKID_USB_BUS_SEL]		= &usb_bus_sel.hw,
+	[CLKID_USB_BUS_DIV]		= &usb_bus_div.hw,
+	[CLKID_SD_EMMC_SEL]		= &sd_emmc_sel.hw,
+	[CLKID_SD_EMMC_DIV]		= &sd_emmc_div.hw,
+	[CLKID_SD_EMMC_SEL2]		= &sd_emmc_sel2.hw,
+	[CLKID_PSRAM_SEL]		= &psram_sel.hw,
+	[CLKID_PSRAM_DIV]		= &psram_div.hw,
+	[CLKID_PSRAM_SEL2]		= &psram_sel2.hw,
+	[CLKID_DMC_SEL]			= &dmc_sel.hw,
+	[CLKID_DMC_DIV]			= &dmc_div.hw,
+	[CLKID_DMC_SEL2]		= &dmc_sel2.hw,
 };
 
 /* Convenience table to populate regmap in .probe */
@@ -2190,6 +2186,29 @@ static struct regmap_config a1_periphs_regmap_cfg = {
 	.reg_stride = 4,
 };
 
+struct meson_a1_periphs_clks {
+	struct clk_hw **hw_clks;
+	unsigned int hw_clk_num;
+};
+
+static struct meson_a1_periphs_clks a1_periphs_clks = {
+	.hw_clks = a1_periphs_hw_clks,
+	.hw_clk_num = ARRAY_SIZE(a1_periphs_hw_clks),
+};
+
+static struct clk_hw *meson_a1_periphs_hw_get(struct of_phandle_args *clkspec, void *clk_data)
+{
+	const struct meson_a1_periphs_clks *data = clk_data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx >= data->hw_clk_num) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return data->hw_clks[idx];
+}
+
 static int meson_a1_periphs_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -2211,15 +2230,15 @@ static int meson_a1_periphs_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(a1_periphs_regmaps); i++)
 		a1_periphs_regmaps[i]->map = map;
 
-	for (clkid = 0; clkid < a1_periphs_clks.num; clkid++) {
-		err = devm_clk_hw_register(dev, a1_periphs_clks.hws[clkid]);
+	for (clkid = 0; clkid < a1_periphs_clks.hw_clk_num; clkid++) {
+		err = devm_clk_hw_register(dev, a1_periphs_clks.hw_clks[clkid]);
 		if (err)
 			return dev_err_probe(dev, err,
 					     "clock[%d] registration failed\n",
 					     clkid);
 	}
 
-	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+	return devm_of_clk_add_hw_provider(dev, meson_a1_periphs_hw_get,
 					   &a1_periphs_clks);
 }
 
diff --git a/drivers/clk/meson/a1-peripherals.h b/drivers/clk/meson/a1-peripherals.h
index 526fc9ba5c9f..4d60456a95a9 100644
--- a/drivers/clk/meson/a1-peripherals.h
+++ b/drivers/clk/meson/a1-peripherals.h
@@ -108,6 +108,5 @@
 #define CLKID_DMC_SEL		151
 #define CLKID_DMC_DIV		152
 #define CLKID_DMC_SEL2		153
-#define NR_CLKS			154
 
 #endif /* __A1_PERIPHERALS_H */
diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
index bd2f1d1ec6e4..25d102dc8a5d 100644
--- a/drivers/clk/meson/a1-pll.c
+++ b/drivers/clk/meson/a1-pll.c
@@ -268,22 +268,18 @@ static struct clk_regmap fclk_div7 = {
 };
 
 /* Array of all clocks registered by this provider */
-static struct clk_hw_onecell_data a1_pll_clks = {
-	.hws = {
-		[CLKID_FIXED_PLL_DCO]	= &fixed_pll_dco.hw,
-		[CLKID_FIXED_PLL]	= &fixed_pll.hw,
-		[CLKID_FCLK_DIV2_DIV]	= &fclk_div2_div.hw,
-		[CLKID_FCLK_DIV3_DIV]	= &fclk_div3_div.hw,
-		[CLKID_FCLK_DIV5_DIV]	= &fclk_div5_div.hw,
-		[CLKID_FCLK_DIV7_DIV]	= &fclk_div7_div.hw,
-		[CLKID_FCLK_DIV2]	= &fclk_div2.hw,
-		[CLKID_FCLK_DIV3]	= &fclk_div3.hw,
-		[CLKID_FCLK_DIV5]	= &fclk_div5.hw,
-		[CLKID_FCLK_DIV7]	= &fclk_div7.hw,
-		[CLKID_HIFI_PLL]	= &hifi_pll.hw,
-		[NR_PLL_CLKS]		= NULL,
-	},
-	.num = NR_PLL_CLKS,
+static struct clk_hw *a1_pll_hw_clks[] = {
+	[CLKID_FIXED_PLL_DCO]	= &fixed_pll_dco.hw,
+	[CLKID_FIXED_PLL]	= &fixed_pll.hw,
+	[CLKID_FCLK_DIV2_DIV]	= &fclk_div2_div.hw,
+	[CLKID_FCLK_DIV3_DIV]	= &fclk_div3_div.hw,
+	[CLKID_FCLK_DIV5_DIV]	= &fclk_div5_div.hw,
+	[CLKID_FCLK_DIV7_DIV]	= &fclk_div7_div.hw,
+	[CLKID_FCLK_DIV2]	= &fclk_div2.hw,
+	[CLKID_FCLK_DIV3]	= &fclk_div3.hw,
+	[CLKID_FCLK_DIV5]	= &fclk_div5.hw,
+	[CLKID_FCLK_DIV7]	= &fclk_div7.hw,
+	[CLKID_HIFI_PLL]	= &hifi_pll.hw,
 };
 
 static struct clk_regmap *const a1_pll_regmaps[] = {
@@ -302,6 +298,29 @@ static struct regmap_config a1_pll_regmap_cfg = {
 	.reg_stride = 4,
 };
 
+struct meson_a1_pll_clks {
+	struct clk_hw **hw_clks;
+	unsigned int hw_clk_num;
+};
+
+static struct meson_a1_pll_clks a1_pll_clks = {
+	.hw_clks = a1_pll_hw_clks,
+	.hw_clk_num = ARRAY_SIZE(a1_pll_hw_clks),
+};
+
+static struct clk_hw *meson_a1_pll_hw_get(struct of_phandle_args *clkspec, void *clk_data)
+{
+	const struct meson_a1_pll_clks *data = clk_data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx >= data->hw_clk_num) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return data->hw_clks[idx];
+}
+
 static int meson_a1_pll_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -324,15 +343,15 @@ static int meson_a1_pll_probe(struct platform_device *pdev)
 		a1_pll_regmaps[i]->map = map;
 
 	/* Register clocks */
-	for (clkid = 0; clkid < a1_pll_clks.num; clkid++) {
-		err = devm_clk_hw_register(dev, a1_pll_clks.hws[clkid]);
+	for (clkid = 0; clkid < a1_pll_clks.hw_clk_num; clkid++) {
+		err = devm_clk_hw_register(dev, a1_pll_clks.hw_clks[clkid]);
 		if (err)
 			return dev_err_probe(dev, err,
 					     "clock[%d] registration failed\n",
 					     clkid);
 	}
 
-	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+	return devm_of_clk_add_hw_provider(dev, meson_a1_pll_hw_get,
 					   &a1_pll_clks);
 }
 
diff --git a/drivers/clk/meson/a1-pll.h b/drivers/clk/meson/a1-pll.h
index 29726651b056..82570759e6a2 100644
--- a/drivers/clk/meson/a1-pll.h
+++ b/drivers/clk/meson/a1-pll.h
@@ -42,6 +42,5 @@
 #define CLKID_FCLK_DIV3_DIV	3
 #define CLKID_FCLK_DIV5_DIV	4
 #define CLKID_FCLK_DIV7_DIV	5
-#define NR_PLL_CLKS		11
 
 #endif /* __A1_PLL_H */

-- 
2.34.1

