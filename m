Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234DD637EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiKXR4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiKXR4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:56:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F1D126;
        Thu, 24 Nov 2022 09:56:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E3C4B82898;
        Thu, 24 Nov 2022 17:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17779C433D6;
        Thu, 24 Nov 2022 17:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669312605;
        bh=BKT0rn7Gm7FIxK/z6Udwsh0VTf4/rEeZdnp+Jv8fgxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cYMrZGzwn4A7ggEhefOusOD5BVwuP5oAtvAN3UhbdvTRcB2bUAOx9BHsSaArE8uRI
         phHWKoBxC2Vfg/y9WI37hyPunRonA7qFv/Kt6XqT+8OzPapbpuJZp016V78OdnQsm3
         +aIG2SUtYCjttb8Nov5eFJDLX3Lhnd8ijat0c4i42QhvylhRXBexJgikq/7uCHUa1J
         VxXduaXQ73dWsisiUPTUdO7ftJGoSnQVLeFjpibTlQ1gguGKetmxR3XS6YfepodJ60
         b5SaF7W6W669Y4+bULap4OKF9/kVw2RQhjQiTzm/aCe6Pw+5N9fJM/a0MJqKbN5ez7
         69Hh3qKq4k3cA==
Date:   Thu, 24 Nov 2022 23:26:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 05/10] phy: qualcomm: qmp-usb: Add support for SM8550
Message-ID: <Y3+wWLsqfzDzdJK+@matsya>
References: <20221116120157.2706810-1-abel.vesa@linaro.org>
 <20221116120157.2706810-6-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116120157.2706810-6-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-22, 14:01, Abel Vesa wrote:
> Add SM8550 specific register layout and table configs.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 171 ++++++++++++++++++++++++
>  1 file changed, 171 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> index 55029ea63f73..4f8941913fe1 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> @@ -1216,6 +1216,145 @@ static const struct qmp_phy_init_tbl sm8350_usb3_uniphy_pcs_usb_tbl[] = {
>  	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
>  };
>  
> +static const struct qmp_phy_init_tbl sm8550_usb3_serdes_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE1, 0xC0),

lower case please, here and everywhere else


> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE1, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORECLK_DIV_MODE1, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x41),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x41),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MSB_MODE1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE1, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE1, 0x75),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE1, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE1_MODE1, 0x25),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE2_MODE1, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0x5C),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x0F),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0x5C),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x0F),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE0, 0xC0),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE0, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x1A),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MSB_MODE0, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE0, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE0, 0x75),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE0, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE1_MODE0, 0x25),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE2_MODE0, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BG_TIMER, 0x0A),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_EN_CENTER, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER1, 0x62),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER2, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_BUF_ENABLE, 0x0C),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_EN_SEL, 0x1A),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_CFG, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORE_CLK_EN, 0x20),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_CONFIG_1, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_1, 0xB6),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_2, 0x4B),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_3, 0x37),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_ADDITIONAL_MISC, 0x0C),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_usb3_tx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_TX, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_RX, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x1F),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_OFFSET_RX, 0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_1, 0xF5),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_3, 0x3F),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_4, 0x3F),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_5, 0x5F),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RCV_DETECT_LVL_2, 0x12),
> +	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_TX_PI_QEC_CTRL, 0x21, 1),
> +	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_TX_PI_QEC_CTRL, 0x05, 2),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_usb3_rx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_FO_GAIN, 0x0A),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SO_GAIN, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_FASTLOCK_FO_GAIN, 0x2F),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7F),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_FASTLOCK_COUNT_LOW, 0xFF),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0F),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_PI_CONTROLS, 0x99),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_THRESH1, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_THRESH2, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_GAIN1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_GAIN2, 0x0A),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_AUX_DATA_TCOARSE_TFINE, 0xA0),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_VGA_CAL_CNTRL1, 0x54),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_VGA_CAL_CNTRL2, 0x0F),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_GM_CAL, 0x13),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0F),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4A),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0A),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_IDAC_TSETTLE_LOW, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIGDET_CNTRL, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIGDET_DEGLITCH_CNTRL, 0x0E),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_LOW, 0xDC),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH, 0x5C),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH2, 0x9C),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH3, 0x1D),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH4, 0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_DFE_EN_TIMER, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_DCC_CTRL1, 0x0C),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_VTH_CODE, 0x10),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIGDET_CAL_CTRL1, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIGDET_CAL_TRIM, 0x08),
> +
> +	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_RX_RX_MODE_00_LOW, 0x3F, 1),
> +	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_RX_RX_MODE_00_HIGH, 0xBF, 1),
> +	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_RX_RX_MODE_00_HIGH2, 0xFF, 1),
> +	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_RX_RX_MODE_00_HIGH3, 0xDF, 1),
> +	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_RX_RX_MODE_00_HIGH4, 0xED, 1),
> +
> +	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_RX_RX_MODE_00_LOW, 0xBF, 2),
> +	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_RX_RX_MODE_00_HIGH, 0xBF, 2),
> +	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_RX_RX_MODE_00_HIGH2, 0xBF, 2),
> +	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_RX_RX_MODE_00_HIGH3, 0xDF, 2),
> +	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_RX_RX_MODE_00_HIGH4, 0xFD, 2),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_usb3_pcs_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_LOCK_DETECT_CONFIG1, 0xC4),
> +	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_LOCK_DETECT_CONFIG2, 0x89),
> +	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_LOCK_DETECT_CONFIG3, 0x20),
> +	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_LOCK_DETECT_CONFIG6, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_REFGEN_REQ_CONFIG1, 0x21),
> +	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_RX_SIGDET_LVL, 0x99),
> +	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_RCVR_DTCT_DLY_P1U2_L, 0xE7),
> +	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_CDR_RESET_TIME, 0x0A),
> +	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_ALIGN_DETECT_CONFIG1, 0x88),
> +	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_ALIGN_DETECT_CONFIG2, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_PCS_TX_RX_CONFIG, 0x0C),
> +	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_EQ_CONFIG1, 0x4B),
> +	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_EQ_CONFIG5, 0x10),
> +	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_POWER_STATE_CONFIG1, 0x68),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_usb3_pcs_usb_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xF8),
> +	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
> +	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L, 0x40),
> +	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H, 0x00),
> +};
> +
>  static const struct qmp_phy_init_tbl qcm2290_usb3_serdes_tbl[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x14),
>  	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
> @@ -1531,6 +1670,12 @@ static const char * const qmp_v4_sm8250_usbphy_clk_l[] = {
>  	"aux", "ref_clk_src", "com_aux"
>  };
>  
> +static const char * const qmp_v4_sm8550_clk_l[] = {
> +	"aux_clk", "pipe_clk", "pipe_clk_mux",
> +	"pipe_clk_ext_src", "ref_clk_src",
> +	"ref_clk", "com_aux_clk"
> +};
> +
>  /* usb3 phy on sdx55 doesn't have com_aux clock */
>  static const char * const qmp_v4_sdx55_usbphy_clk_l[] = {
>  	"aux", "cfg_ahb", "ref"
> @@ -1919,6 +2064,29 @@ static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
>  	.has_pwrdn_delay	= true,
>  };
>  
> +static const struct qmp_phy_cfg sm8550_usb3_uniphy_cfg = {
> +	.lanes			= 2,
> +
> +	.serdes_tbl		= sm8550_usb3_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sm8550_usb3_serdes_tbl),
> +	.tx_tbl			= sm8550_usb3_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(sm8550_usb3_tx_tbl),
> +	.rx_tbl			= sm8550_usb3_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sm8550_usb3_rx_tbl),
> +	.pcs_tbl		= sm8550_usb3_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sm8550_usb3_pcs_tbl),
> +	.pcs_usb_tbl		= sm8550_usb3_pcs_usb_tbl,
> +	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8550_usb3_pcs_usb_tbl),
> +	.clk_list		= qmp_v4_sm8250_usbphy_clk_l,
> +	.num_clks		= ARRAY_SIZE(qmp_v4_sm8250_usbphy_clk_l),
> +	.reset_list		= msm8996_usb3phy_reset_l,
> +	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= qmp_v4_usb3phy_regs_layout,
> +	.pcs_usb_offset		= 0x1000,
> +};
> +
>  static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
>  	.lanes			= 2,
>  
> @@ -2643,6 +2811,9 @@ static const struct of_device_id qmp_usb_of_match_table[] = {
>  	}, {
>  		.compatible = "qcom,sm8450-qmp-usb3-phy",
>  		.data = &sm8350_usb3phy_cfg,
> +	}, {
> +		.compatible = "qcom,sm8550-qmp-usb3-phy",
> +		.data = &sm8550_usb3_uniphy_cfg,
>  	},
>  	{ },
>  };
> -- 
> 2.34.1

-- 
~Vinod
