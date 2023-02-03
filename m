Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB18689751
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjBCKwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBCKwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:52:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C1D13525;
        Fri,  3 Feb 2023 02:52:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98C36B82911;
        Fri,  3 Feb 2023 10:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4E5C4339B;
        Fri,  3 Feb 2023 10:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675421549;
        bh=D0uCjMQ/oq2nRSMvQaIOlBUWWuZtFQ5a5L8lZOnG4sw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CYJaiDbYQgYNgIJ1krsSI0ZrM5NFSmwuk0+WR2OE+ui8WdlLuep3m+rwOFhJTyk8I
         Dv4/fptsJMbkjWi1jQlmoz/d9DB2TtnB33DHY5cdAU+PBpGTVEiYtqFbJyGrmW+nuL
         an7SWtWNysPCoetNZTotzi03EpHOdh4ev3VZKud7Xc4ZXQqOKoY91ww+/1cFfCUPnd
         JjB5iLevhGm2TUOM5TIC0pQk43RnEXbbT4ec38aKBoGtzJshwaLnOZOXVWnL+Q57nn
         wwAwZTgzrMT2U/TZiI15U2MDu8oKLuBUB0Qr69OKqD7suZGGQAt3vbH6lsDPvY1MIP
         2g1/lf6OV6dXA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pNtgd-0001No-Sw; Fri, 03 Feb 2023 11:52:55 +0100
Date:   Fri, 3 Feb 2023 11:52:55 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 6/8] phy: qcom-qmp-combo: Add support for SM8550
Message-ID: <Y9znh4ydK37V/Eyo@hovoldconsulting.com>
References: <20230202132511.3983095-1-abel.vesa@linaro.org>
 <20230202132511.3983095-7-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202132511.3983095-7-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 03:25:09PM +0200, Abel Vesa wrote:
> Add SM8550 specific register layout and table configs.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> The v3 version of this patch was here:
> https://lore.kernel.org/all/20230126131415.1453741-7-abel.vesa@linaro.org/
> 
> Changes since v3:
>  * switched dp_tx and dp_tx2 to off->dp_tx0 and off->dp_tx1, like Neil
>    suggested
> 
> Changes since v2:
>  * none
> 
> Changes since v1:
>  * switched from qmp-usb to qmp-combo as it will support DP also
>  * changed all hex offset values to lowercase, like Vinod suggested
> 
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 409 +++++++++++++++++++++-
>  1 file changed, 404 insertions(+), 5 deletions(-)

>  struct qmp_combo_offsets {
> @@ -808,6 +1039,8 @@ struct qmp_combo_offsets {
>  	u16 usb3_pcs;
>  	u16 usb3_pcs_usb;
>  	u16 dp_serdes;
> +	u16 dp_tx0;
> +	u16 dp_tx1;

As I mentioned off-list last week, this should be rebased on Luca's
patch adding support for SM6350:

	https://lore.kernel.org/lkml/20230120-sm6350-usbphy-v4-2-4d700a90ba16@fairphone.com/

>  	u16 dp_dp_phy;
>  };
>  
> @@ -927,6 +1160,9 @@ static int qmp_v4_calibrate_dp_phy(struct qmp_combo *qmp);
>  
>  static int qmp_v5_configure_dp_phy(struct qmp_combo *qmp);
>  
> +static void qmp_v6_dp_aux_init(struct qmp_combo *qmp);
> +static int qmp_v6_configure_dp_phy(struct qmp_combo *qmp);
> +
>  static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
>  {
>  	u32 reg;
> @@ -985,9 +1221,27 @@ static const struct qmp_combo_offsets qmp_combo_offsets_v5 = {
>  	.usb3_pcs	= 0x1400,
>  	.usb3_pcs_usb	= 0x1700,
>  	.dp_serdes	= 0x2000,
> +	.dp_tx0		= 0x2200,
> +	.dp_tx1		= 0x2600,

This would break sc8280xp and does not in anyway belong in this patch.

You can't just randomly change register offsets for an old SoC when
adding support for a new one.

>  	.dp_dp_phy	= 0x2200,
>  };
>  
> +static const struct qmp_combo_offsets qmp_combo_offsets_v6 = {
> +	.com		= 0x0000,
> +	.txa		= 0x1200,
> +	.rxa		= 0x1400,
> +	.txb		= 0x1600,
> +	.rxb		= 0x1800,
> +	.usb3_serdes	= 0x1000,
> +	.usb3_pcs_misc	= 0x1a00,
> +	.usb3_pcs	= 0x1c00,
> +	.usb3_pcs_usb	= 0x1f00,
> +	.dp_serdes	= 0x2000,
> +	.dp_tx0		= 0x2200,
> +	.dp_tx1		= 0x2600,
> +	.dp_dp_phy	= 0x2a00,
> +};
> +
>  static const struct qmp_phy_cfg sc7180_usb3dpphy_cfg = {
>  	.serdes_tbl		= qmp_v3_usb3_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_serdes_tbl),
> @@ -1219,6 +1473,54 @@ static const struct qmp_phy_cfg sm8250_usb3dpphy_cfg = {
>  	.has_pwrdn_delay	= true,
>  };
>  
> +static const struct qmp_phy_cfg sm8550_usb3dpphy_cfg = {
> +	.offsets		= &qmp_combo_offsets_v6,
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
> +
> +	.dp_serdes_tbl		= qmp_v6_dp_serdes_tbl,
> +	.dp_serdes_tbl_num	= ARRAY_SIZE(qmp_v6_dp_serdes_tbl),
> +	.dp_tx_tbl		= qmp_v6_dp_tx_tbl,
> +	.dp_tx_tbl_num		= ARRAY_SIZE(qmp_v6_dp_tx_tbl),
> +
> +	.serdes_tbl_rbr		= qmp_v6_dp_serdes_tbl_rbr,
> +	.serdes_tbl_rbr_num	= ARRAY_SIZE(qmp_v6_dp_serdes_tbl_rbr),
> +	.serdes_tbl_hbr		= qmp_v6_dp_serdes_tbl_hbr,
> +	.serdes_tbl_hbr_num	= ARRAY_SIZE(qmp_v6_dp_serdes_tbl_hbr),
> +	.serdes_tbl_hbr2	= qmp_v6_dp_serdes_tbl_hbr2,
> +	.serdes_tbl_hbr2_num	= ARRAY_SIZE(qmp_v6_dp_serdes_tbl_hbr2),
> +	.serdes_tbl_hbr3	= qmp_v6_dp_serdes_tbl_hbr3,
> +	.serdes_tbl_hbr3_num	= ARRAY_SIZE(qmp_v6_dp_serdes_tbl_hbr3),
> +
> +	.swing_hbr_rbr		= &qmp_dp_v5_voltage_swing_hbr_rbr,
> +	.pre_emphasis_hbr_rbr	= &qmp_dp_v6_pre_emphasis_hbr_rbr,
> +	.swing_hbr3_hbr2	= &qmp_dp_v5_voltage_swing_hbr3_hbr2,
> +	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v5_pre_emphasis_hbr3_hbr2,
> +
> +	.dp_aux_init		= qmp_v6_dp_aux_init,
> +	.configure_dp_tx	= qmp_v4_configure_dp_tx,
> +	.configure_dp_phy	= qmp_v6_configure_dp_phy,
> +	.calibrate_dp_phy	= qmp_v4_calibrate_dp_phy,
> +
> +	.regs			= qmp_v4_usb3phy_regs_layout,
> +	.clk_list		= qmp_v4_phy_clk_l,
> +	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
> +	.reset_list		= msm8996_usb3phy_reset_l,
> +	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),

> +	.pcs_usb_offset		= 0x300,

This field is not used with the new bindings and should be removed.

> +};
> +
>  static void qmp_combo_configure_lane(void __iomem *base,
>  					const struct qmp_phy_init_tbl tbl[],
>  					int num,
> @@ -1529,6 +1831,33 @@ static void qmp_v4_dp_aux_init(struct qmp_combo *qmp)
>  	       qmp->dp_dp_phy + QSERDES_V4_DP_PHY_AUX_INTERRUPT_MASK);
>  }
>  
> +static void qmp_v6_dp_aux_init(struct qmp_combo *qmp)
> +{
> +	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_PSR_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
> +	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
> +	       qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
> +
> +	/* Turn on BIAS current for PHY/PLL */
> +	writel(0x17, qmp->dp_serdes + QSERDES_V6_COM_PLL_BIAS_EN_CLK_BUFLR_EN);
> +
> +	writel(0x00, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG0);
> +	writel(0x13, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG1);
> +	writel(0xa4, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG2);
> +	writel(0x00, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG3);
> +	writel(0x0a, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG4);
> +	writel(0x26, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG5);
> +	writel(0x0a, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG6);
> +	writel(0x03, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG7);
> +	writel(0xb7, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG8);
> +	writel(0x03, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG9);
> +	qmp->dp_aux_cfg = 0;
> +
> +	writel(PHY_AUX_STOP_ERR_MASK | PHY_AUX_DEC_ERR_MASK |
> +	       PHY_AUX_SYNC_ERR_MASK | PHY_AUX_ALIGN_ERR_MASK |
> +	       PHY_AUX_REQ_ERR_MASK,
> +	       qmp->dp_dp_phy + QSERDES_V4_DP_PHY_AUX_INTERRUPT_MASK);
> +}
> +
>  static void qmp_v4_configure_dp_tx(struct qmp_combo *qmp)
>  {
>  	/* Program default values before writing proper values */
> @@ -1542,7 +1871,10 @@ static void qmp_v4_configure_dp_tx(struct qmp_combo *qmp)
>  			QSERDES_V4_TX_TX_EMP_POST1_LVL);
>  }
>  
> -static int qmp_v45_configure_dp_phy(struct qmp_combo *qmp)
> +static int qmp_v456_configure_dp_phy(struct qmp_combo *qmp,
> +				     unsigned int com_resetm_ctrl_reg,
> +				     unsigned int com_c_ready_status_reg,
> +				     unsigned int dp_phy_status_reg)
>  {
>  	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
>  	u32 phy_vco_div, status;

Looks like something is missing here as you're not using the new
parameters anywhere?

> @@ -1639,7 +1971,9 @@ static int qmp_v4_configure_dp_phy(struct qmp_combo *qmp)
>  	u32 status;
>  	int ret;
>  
> -	ret = qmp_v45_configure_dp_phy(qmp);
> +	ret = qmp_v456_configure_dp_phy(qmp, QSERDES_V4_COM_RESETSM_CNTRL,
> +					QSERDES_V4_COM_C_READY_STATUS,
> +					QSERDES_V4_DP_PHY_STATUS);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -1701,7 +2035,9 @@ static int qmp_v5_configure_dp_phy(struct qmp_combo *qmp)
>  	u32 status;
>  	int ret;
>  
> -	ret = qmp_v45_configure_dp_phy(qmp);
> +	ret = qmp_v456_configure_dp_phy(qmp, QSERDES_V4_COM_RESETSM_CNTRL,
> +					QSERDES_V4_COM_C_READY_STATUS,
> +					QSERDES_V4_DP_PHY_STATUS);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -1750,6 +2086,65 @@ static int qmp_v5_configure_dp_phy(struct qmp_combo *qmp)
>  	return 0;
>  }
>  
> +static int qmp_v6_configure_dp_phy(struct qmp_combo *qmp)
> +{
> +	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
> +	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
> +	bool reverse = false;
> +	u32 status;
> +	int ret;
> +
> +	ret = qmp_v456_configure_dp_phy(qmp, QSERDES_V6_COM_RESETSM_CNTRL,
> +					QSERDES_V6_COM_C_READY_STATUS,
> +					QSERDES_V6_DP_PHY_STATUS);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (dp_opts->lanes == 1) {
> +		bias0_en = reverse ? 0x3e : 0x1a;
> +		drvr0_en = reverse ? 0x13 : 0x10;
> +		bias1_en = reverse ? 0x15 : 0x3e;
> +		drvr1_en = reverse ? 0x10 : 0x13;
> +	} else if (dp_opts->lanes == 2) {
> +		bias0_en = reverse ? 0x3f : 0x15;
> +		drvr0_en = 0x10;
> +		bias1_en = reverse ? 0x15 : 0x3f;
> +		drvr1_en = 0x10;
> +	} else {
> +		bias0_en = 0x3f;
> +		bias1_en = 0x3f;
> +		drvr0_en = 0x10;
> +		drvr1_en = 0x10;
> +	}
> +
> +	writel(drvr0_en, qmp->dp_tx + QSERDES_V4_TX_HIGHZ_DRVR_EN);
> +	writel(bias0_en, qmp->dp_tx + QSERDES_V4_TX_TRANSCEIVER_BIAS_EN);
> +	writel(drvr1_en, qmp->dp_tx2 + QSERDES_V4_TX_HIGHZ_DRVR_EN);
> +	writel(bias1_en, qmp->dp_tx2 + QSERDES_V4_TX_TRANSCEIVER_BIAS_EN);
> +
> +	writel(0x18, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
> +	udelay(2000);
> +	writel(0x19, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
> +
> +	if (readl_poll_timeout(qmp->dp_dp_phy + QSERDES_V6_DP_PHY_STATUS,
> +			       status,
> +			       ((status & BIT(1)) > 0),
> +			       500,
> +			       10000))
> +		return -ETIMEDOUT;
> +
> +	writel(0x0a, qmp->dp_tx + QSERDES_V4_TX_TX_POL_INV);
> +	writel(0x0a, qmp->dp_tx2 + QSERDES_V4_TX_TX_POL_INV);
> +
> +	writel(0x27, qmp->dp_tx + QSERDES_V4_TX_TX_DRV_LVL);
> +	writel(0x27, qmp->dp_tx2 + QSERDES_V4_TX_TX_DRV_LVL);
> +
> +	writel(0x20, qmp->dp_tx + QSERDES_V4_TX_TX_EMP_POST1_LVL);
> +	writel(0x20, qmp->dp_tx2 + QSERDES_V4_TX_TX_EMP_POST1_LVL);
> +
> +	return 0;
> +}
> +
>  /*
>   * We need to calibrate the aux setting here as many times
>   * as the caller tries
> @@ -2640,8 +3035,8 @@ static int qmp_combo_parse_dt(struct qmp_combo *qmp)
>  	qmp->pcs_usb = base + offs->usb3_pcs_usb;
>  
>  	qmp->dp_serdes = base + offs->dp_serdes;
> -	qmp->dp_tx = base + offs->txa;
> -	qmp->dp_tx2 = base + offs->txb;
> +	qmp->dp_tx = base + offs->dp_tx0;
> +	qmp->dp_tx2 = base + offs->dp_tx1;

Again, this breaks sc8280xp. Rebasing on Luca's patch and dropping the
offsets you're adding to the v5 offsets should avoid that.

>  	qmp->dp_dp_phy = base + offs->dp_dp_phy;
>  
>  	qmp->pipe_clk = devm_clk_get(dev, "usb3_pipe");
> @@ -2792,6 +3187,10 @@ static const struct of_device_id qmp_combo_of_match_table[] = {
>  		.compatible = "qcom,sm8250-qmp-usb3-dp-phy",
>  		.data = &sm8250_usb3dpphy_cfg,
>  	},
> +	{
> +		.compatible = "qcom,sm8550-qmp-usb3-dp-phy",
> +		.data = &sm8550_usb3dpphy_cfg,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, qmp_combo_of_match_table);

Johan
