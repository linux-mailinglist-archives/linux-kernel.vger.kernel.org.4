Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5128613AA5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiJaPrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiJaPqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:46:36 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB83312744
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:46:16 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 17so6764348pfv.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ED4Pdl1pYYospuQHPOVy+ykTYjfhxK1y0Bxl806wcnU=;
        b=Nz2rB0RQElBpW/tcMg8d2tGeXEH/d0R0oHOYOc1xDlCBBN53JbuxFQn49lf6eseZnh
         60Uut/B4MncdaqtRdiYh2uD7RP9pYjS5g07dvOv/+bWLrH8HZoHhELJtMhVEET60tduS
         M3jCAI0FPCkF5tc3xJ4DnQcrwsyPfNV+DevsdZW5stmc6GtBR3GIoolDosOPQ7Li+S1J
         936/BEeuZLFYNwGAv/p6yVAcSIRbIuCoRTIn505t0+KZNwJURwS5O4fHrgjpwCnCofaH
         oUeqUgtc7eZoezlOyXR4jeQR4DtQRnocVA71j8jyryjLXqTkh3iI8viHwW7L/PYkPYto
         /46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ED4Pdl1pYYospuQHPOVy+ykTYjfhxK1y0Bxl806wcnU=;
        b=bhlS36zKxDCiBiLVI8mZBPqhlic1bgOAdXMqqv9+zqQHuxeT6tnjPo6FtVTY06d5kV
         wTyUi3FBw2OQGJeLoI0ZoatWxZUA6PEr7qZXrqeA5fBz2w8skTTBz3ztvkUZkPnEWSKr
         dRbmyoyiUPwxb7pGT5Zw7plj83kFa/1CoSQedxp27XROKWMfbccZK4SRkuIOQj+3tnh2
         H9TuU8oG9t6lqBp+BOiJxZkbNkqUi9kVjfE6JdCffHSJLLZZkUHs+DdMfLHiLK/gayoi
         yCHM5AhynjvNm1XufnwWFaCLZw/mFi4m78TVzVqRZdsAIiujt7f/xddlmqpONtMOEBDD
         0ezQ==
X-Gm-Message-State: ACrzQf3USaXriQGhhwlV2yefVErP77JgWO1+ApPpYdDO5wnOL/J70Xur
        vJtkDyHNHqzrMtruyjpa3Mhy
X-Google-Smtp-Source: AMsMyM6G37NPNmjzsD0efFFw6fm6GkywzdhhnCL4jIyI4CGuyNd7aDtT3ixtA4AfA59rUB9RpajzGw==
X-Received: by 2002:a63:188:0:b0:43c:22e9:2d10 with SMTP id 130-20020a630188000000b0043c22e92d10mr13277229pgb.12.1667231176289;
        Mon, 31 Oct 2022 08:46:16 -0700 (PDT)
Received: from thinkpad ([117.193.209.221])
        by smtp.gmail.com with ESMTPSA id 9-20020a631749000000b0046f1e8cb30dsm4298951pgx.26.2022.10.31.08.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 08:46:15 -0700 (PDT)
Date:   Mon, 31 Oct 2022 21:16:07 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, quic_cang@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 01/15] phy: qcom-qmp-ufs: Move register settings to
 qmp_phy_cfg_tables struct
Message-ID: <20221031154607.GB12738@thinkpad>
References: <20221029141633.295650-1-manivannan.sadhasivam@linaro.org>
 <20221029141633.295650-2-manivannan.sadhasivam@linaro.org>
 <14844656-0d93-eac0-1877-f3e967691f5a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14844656-0d93-eac0-1877-f3e967691f5a@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 12:50:50AM +0300, Dmitry Baryshkov wrote:
> On 29/10/2022 17:16, Manivannan Sadhasivam wrote:
> > As done for Qcom PCIe PHY driver, let's move the register settings to the
> > common qmp_phy_cfg_tables struct. This helps in adding any additional PHY
> > settings needed for functionalities like HS-G4 in the future by adding one
> > more instance of the qmp_phy_cfg_tables.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 223 +++++++++++++-----------
> >   1 file changed, 126 insertions(+), 97 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > index c08d34ad1313..cdfda4e6d575 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > @@ -107,7 +107,7 @@ static const unsigned int sm8150_ufsphy_regs_layout[QPHY_LAYOUT_SIZE] = {
> >   	[QPHY_SW_RESET]			= QPHY_V4_PCS_UFS_SW_RESET,
> >   };
> > -static const struct qmp_phy_init_tbl msm8996_ufs_serdes_tbl[] = {
> > +static const struct qmp_phy_init_tbl msm8996_ufs_serdes[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x0e),
> >   	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0xd7),
> >   	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
> > @@ -156,12 +156,12 @@ static const struct qmp_phy_init_tbl msm8996_ufs_serdes_tbl[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE1, 0x00),
> >   };
> > -static const struct qmp_phy_init_tbl msm8996_ufs_tx_tbl[] = {
> > +static const struct qmp_phy_init_tbl msm8996_ufs_tx[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN, 0x45),
> >   	QMP_PHY_INIT_CFG(QSERDES_TX_LANE_MODE, 0x02),
> >   };
> > -static const struct qmp_phy_init_tbl msm8996_ufs_rx_tbl[] = {
> > +static const struct qmp_phy_init_tbl msm8996_ufs_rx[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_LVL, 0x24),
> >   	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_CNTRL, 0x02),
> >   	QMP_PHY_INIT_CFG(QSERDES_RX_RX_INTERFACE_MODE, 0x00),
> > @@ -175,7 +175,7 @@ static const struct qmp_phy_init_tbl msm8996_ufs_rx_tbl[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0E),
> >   };
> > -static const struct qmp_phy_init_tbl sm6115_ufsphy_serdes_tbl[] = {
> > +static const struct qmp_phy_init_tbl sm6115_ufsphy_serdes[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x0e),
> >   	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x14),
> >   	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
> > @@ -231,12 +231,12 @@ static const struct qmp_phy_init_tbl sm6115_ufsphy_serdes_tbl[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x44),
> >   };
> > -static const struct qmp_phy_init_tbl sm6115_ufsphy_tx_tbl[] = {
> > +static const struct qmp_phy_init_tbl sm6115_ufsphy_tx[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN, 0x45),
> >   	QMP_PHY_INIT_CFG(QSERDES_TX_LANE_MODE, 0x06),
> >   };
> > -static const struct qmp_phy_init_tbl sm6115_ufsphy_rx_tbl[] = {
> > +static const struct qmp_phy_init_tbl sm6115_ufsphy_rx[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_LVL, 0x24),
> >   	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_CNTRL, 0x0F),
> >   	QMP_PHY_INIT_CFG(QSERDES_RX_RX_INTERFACE_MODE, 0x40),
> > @@ -254,7 +254,7 @@ static const struct qmp_phy_init_tbl sm6115_ufsphy_rx_tbl[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5B),
> >   };
> > -static const struct qmp_phy_init_tbl sm6115_ufsphy_pcs_tbl[] = {
> > +static const struct qmp_phy_init_tbl sm6115_ufsphy_pcs[] = {
> >   	QMP_PHY_INIT_CFG(QPHY_V2_PCS_RX_PWM_GEAR_BAND, 0x15),
> >   	QMP_PHY_INIT_CFG(QPHY_V2_PCS_RX_SIGDET_CTRL2, 0x6d),
> >   	QMP_PHY_INIT_CFG(QPHY_V2_PCS_TX_LARGE_AMP_DRV_LVL, 0x0f),
> > @@ -266,7 +266,7 @@ static const struct qmp_phy_init_tbl sm6115_ufsphy_pcs_tbl[] = {
> >   	QMP_PHY_INIT_CFG(QPHY_V2_PCS_RX_MIN_HIBERN8_TIME, 0x9a), /* 8 us */
> >   };
> > -static const struct qmp_phy_init_tbl sdm845_ufsphy_serdes_tbl[] = {
> > +static const struct qmp_phy_init_tbl sdm845_ufsphy_serdes[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYS_CLK_CTRL, 0x02),
> >   	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x04),
> >   	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BG_TIMER, 0x0a),
> > @@ -308,13 +308,13 @@ static const struct qmp_phy_init_tbl sdm845_ufsphy_serdes_tbl[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_MAP, 0x44),
> >   };
> > -static const struct qmp_phy_init_tbl sdm845_ufsphy_tx_tbl[] = {
> > +static const struct qmp_phy_init_tbl sdm845_ufsphy_tx[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0x06),
> >   	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX, 0x04),
> >   	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_RX, 0x07),
> >   };
> > -static const struct qmp_phy_init_tbl sdm845_ufsphy_rx_tbl[] = {
> > +static const struct qmp_phy_init_tbl sdm845_ufsphy_rx[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_LVL, 0x24),
> >   	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x0f),
> >   	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
> > @@ -333,7 +333,7 @@ static const struct qmp_phy_init_tbl sdm845_ufsphy_rx_tbl[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x59),
> >   };
> > -static const struct qmp_phy_init_tbl sdm845_ufsphy_pcs_tbl[] = {
> > +static const struct qmp_phy_init_tbl sdm845_ufsphy_pcs[] = {
> >   	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_SIGDET_CTRL2, 0x6e),
> >   	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0a),
> >   	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_TX_SMALL_AMP_DRV_LVL, 0x02),
> > @@ -344,7 +344,7 @@ static const struct qmp_phy_init_tbl sdm845_ufsphy_pcs_tbl[] = {
> >   	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
> >   };
> > -static const struct qmp_phy_init_tbl sm8150_ufsphy_serdes_tbl[] = {
> > +static const struct qmp_phy_init_tbl sm8150_ufsphy_serdes[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0xd9),
> >   	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_SEL, 0x11),
> >   	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_HS_SWITCH_SEL, 0x00),
> > @@ -374,7 +374,7 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_serdes_tbl[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE_MAP, 0x06),
> >   };
> > -static const struct qmp_phy_init_tbl sm8150_ufsphy_tx_tbl[] = {
> > +static const struct qmp_phy_init_tbl sm8150_ufsphy_tx[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_1_DIVIDER_BAND0_1, 0x06),
> >   	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND0_1, 0x03),
> >   	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_3_DIVIDER_BAND0_1, 0x01),
> > @@ -383,7 +383,7 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_tx_tbl[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_V4_TX_TRAN_DRVR_EMP_EN, 0x0c),
> >   };
> > -static const struct qmp_phy_init_tbl sm8150_ufsphy_rx_tbl[] = {
> > +static const struct qmp_phy_init_tbl sm8150_ufsphy_rx[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_LVL, 0x24),
> >   	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x0f),
> >   	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
> > @@ -421,7 +421,7 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_rx_tbl[] = {
> >   };
> > -static const struct qmp_phy_init_tbl sm8150_ufsphy_pcs_tbl[] = {
> > +static const struct qmp_phy_init_tbl sm8150_ufsphy_pcs[] = {
> >   	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_RX_SIGDET_CTRL2, 0x6d),
> >   	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0a),
> >   	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_SMALL_AMP_DRV_LVL, 0x02),
> > @@ -431,7 +431,7 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_pcs_tbl[] = {
> >   	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
> >   };
> > -static const struct qmp_phy_init_tbl sm8350_ufsphy_serdes_tbl[] = {
> > +static const struct qmp_phy_init_tbl sm8350_ufsphy_serdes[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0xd9),
> >   	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x11),
> >   	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_HS_SWITCH_SEL, 0x00),
> > @@ -461,7 +461,7 @@ static const struct qmp_phy_init_tbl sm8350_ufsphy_serdes_tbl[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE_MAP, 0x06),
> >   };
> > -static const struct qmp_phy_init_tbl sm8350_ufsphy_tx_tbl[] = {
> > +static const struct qmp_phy_init_tbl sm8350_ufsphy_tx[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PWM_GEAR_1_DIVIDER_BAND0_1, 0x06),
> >   	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PWM_GEAR_2_DIVIDER_BAND0_1, 0x03),
> >   	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PWM_GEAR_3_DIVIDER_BAND0_1, 0x01),
> > @@ -473,7 +473,7 @@ static const struct qmp_phy_init_tbl sm8350_ufsphy_tx_tbl[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_V5_TX_TRAN_DRVR_EMP_EN, 0x0c),
> >   };
> > -static const struct qmp_phy_init_tbl sm8350_ufsphy_rx_tbl[] = {
> > +static const struct qmp_phy_init_tbl sm8350_ufsphy_rx[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_LVL, 0x24),
> >   	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_CNTRL, 0x0f),
> >   	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
> > @@ -513,7 +513,7 @@ static const struct qmp_phy_init_tbl sm8350_ufsphy_rx_tbl[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_V5_RX_DCC_CTRL1, 0x0c),
> >   };
> > -static const struct qmp_phy_init_tbl sm8350_ufsphy_pcs_tbl[] = {
> > +static const struct qmp_phy_init_tbl sm8350_ufsphy_pcs[] = {
> >   	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_RX_SIGDET_CTRL2, 0x6d),
> >   	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0a),
> >   	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_TX_SMALL_AMP_DRV_LVL, 0x02),
> > @@ -531,19 +531,24 @@ static const struct qmp_phy_init_tbl sm8350_ufsphy_pcs_tbl[] = {
> >   	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
> >   };
> > +struct qmp_phy_cfg_tables {
> > +	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
> > +	const struct qmp_phy_init_tbl *serdes;
> > +	int serdes_num;
> > +	const struct qmp_phy_init_tbl *tx;
> > +	int tx_num;
> > +	const struct qmp_phy_init_tbl *rx;
> > +	int rx_num;
> > +	const struct qmp_phy_init_tbl *pcs;
> > +	int pcs_num;
> > +};
> > +
> >   /* struct qmp_phy_cfg - per-PHY initialization config */
> >   struct qmp_phy_cfg {
> >   	int lanes;
> > -	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
> > -	const struct qmp_phy_init_tbl *serdes_tbl;
> > -	int serdes_tbl_num;
> > -	const struct qmp_phy_init_tbl *tx_tbl;
> > -	int tx_tbl_num;
> > -	const struct qmp_phy_init_tbl *rx_tbl;
> > -	int rx_tbl_num;
> > -	const struct qmp_phy_init_tbl *pcs_tbl;
> > -	int pcs_tbl_num;
> > +	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
> > +	const struct qmp_phy_cfg_tables tables;
> >   	/* clock ids to be requested */
> >   	const char * const *clk_list;
> > @@ -660,12 +665,14 @@ static const char * const qmp_phy_vreg_l[] = {
> >   static const struct qmp_phy_cfg msm8996_ufs_cfg = {
> >   	.lanes			= 1,
> > -	.serdes_tbl		= msm8996_ufs_serdes_tbl,
> > -	.serdes_tbl_num		= ARRAY_SIZE(msm8996_ufs_serdes_tbl),
> > -	.tx_tbl			= msm8996_ufs_tx_tbl,
> > -	.tx_tbl_num		= ARRAY_SIZE(msm8996_ufs_tx_tbl),
> > -	.rx_tbl			= msm8996_ufs_rx_tbl,
> > -	.rx_tbl_num		= ARRAY_SIZE(msm8996_ufs_rx_tbl),
> > +	.tables = {
> > +		.serdes		= msm8996_ufs_serdes,
> > +		.serdes_num	= ARRAY_SIZE(msm8996_ufs_serdes),
> > +		.tx		= msm8996_ufs_tx,
> > +		.tx_num		= ARRAY_SIZE(msm8996_ufs_tx),
> > +		.rx		= msm8996_ufs_rx,
> > +		.rx_num		= ARRAY_SIZE(msm8996_ufs_rx),
> > +	},
> >   	.clk_list		= msm8996_ufs_phy_clk_l,
> >   	.num_clks		= ARRAY_SIZE(msm8996_ufs_phy_clk_l),
> > @@ -685,14 +692,16 @@ static const struct qmp_phy_cfg msm8996_ufs_cfg = {
> >   static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
> >   	.lanes			= 2,
> > -	.serdes_tbl		= sdm845_ufsphy_serdes_tbl,
> > -	.serdes_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_serdes_tbl),
> > -	.tx_tbl			= sdm845_ufsphy_tx_tbl,
> > -	.tx_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_tx_tbl),
> > -	.rx_tbl			= sdm845_ufsphy_rx_tbl,
> > -	.rx_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_rx_tbl),
> > -	.pcs_tbl		= sdm845_ufsphy_pcs_tbl,
> > -	.pcs_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_pcs_tbl),
> > +	.tables = {
> > +		.serdes		= sdm845_ufsphy_serdes,
> > +		.serdes_num	= ARRAY_SIZE(sdm845_ufsphy_serdes),
> > +		.tx		= sdm845_ufsphy_tx,
> > +		.tx_num		= ARRAY_SIZE(sdm845_ufsphy_tx),
> > +		.rx		= sdm845_ufsphy_rx,
> > +		.rx_num		= ARRAY_SIZE(sdm845_ufsphy_rx),
> > +		.pcs		= sdm845_ufsphy_pcs,
> > +		.pcs_num	= ARRAY_SIZE(sdm845_ufsphy_pcs),
> > +	},
> >   	.clk_list		= sdm845_ufs_phy_clk_l,
> >   	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> >   	.vreg_list		= qmp_phy_vreg_l,
> > @@ -709,14 +718,16 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
> >   static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
> >   	.lanes			= 1,
> > -	.serdes_tbl		= sm6115_ufsphy_serdes_tbl,
> > -	.serdes_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_serdes_tbl),
> > -	.tx_tbl			= sm6115_ufsphy_tx_tbl,
> > -	.tx_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_tx_tbl),
> > -	.rx_tbl			= sm6115_ufsphy_rx_tbl,
> > -	.rx_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_rx_tbl),
> > -	.pcs_tbl		= sm6115_ufsphy_pcs_tbl,
> > -	.pcs_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_pcs_tbl),
> > +	.tables = {
> > +		.serdes		= sm6115_ufsphy_serdes,
> > +		.serdes_num	= ARRAY_SIZE(sm6115_ufsphy_serdes),
> > +		.tx		= sm6115_ufsphy_tx,
> > +		.tx_num		= ARRAY_SIZE(sm6115_ufsphy_tx),
> > +		.rx		= sm6115_ufsphy_rx,
> > +		.rx_num		= ARRAY_SIZE(sm6115_ufsphy_rx),
> > +		.pcs		= sm6115_ufsphy_pcs,
> > +		.pcs_num	= ARRAY_SIZE(sm6115_ufsphy_pcs),
> > +	},
> >   	.clk_list		= sdm845_ufs_phy_clk_l,
> >   	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> >   	.vreg_list		= qmp_phy_vreg_l,
> > @@ -732,14 +743,16 @@ static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
> >   static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
> >   	.lanes			= 2,
> > -	.serdes_tbl		= sm8150_ufsphy_serdes_tbl,
> > -	.serdes_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_serdes_tbl),
> > -	.tx_tbl			= sm8150_ufsphy_tx_tbl,
> > -	.tx_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_tx_tbl),
> > -	.rx_tbl			= sm8150_ufsphy_rx_tbl,
> > -	.rx_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_rx_tbl),
> > -	.pcs_tbl		= sm8150_ufsphy_pcs_tbl,
> > -	.pcs_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_pcs_tbl),
> > +	.tables = {
> > +		.serdes		= sm8150_ufsphy_serdes,
> > +		.serdes_num	= ARRAY_SIZE(sm8150_ufsphy_serdes),
> > +		.tx		= sm8150_ufsphy_tx,
> > +		.tx_num		= ARRAY_SIZE(sm8150_ufsphy_tx),
> > +		.rx		= sm8150_ufsphy_rx,
> > +		.rx_num		= ARRAY_SIZE(sm8150_ufsphy_rx),
> > +		.pcs		= sm8150_ufsphy_pcs,
> > +		.pcs_num	= ARRAY_SIZE(sm8150_ufsphy_pcs),
> > +	},
> >   	.clk_list		= sdm845_ufs_phy_clk_l,
> >   	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> >   	.vreg_list		= qmp_phy_vreg_l,
> > @@ -754,14 +767,16 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
> >   static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
> >   	.lanes			= 2,
> > -	.serdes_tbl		= sm8350_ufsphy_serdes_tbl,
> > -	.serdes_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_serdes_tbl),
> > -	.tx_tbl			= sm8350_ufsphy_tx_tbl,
> > -	.tx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_tx_tbl),
> > -	.rx_tbl			= sm8350_ufsphy_rx_tbl,
> > -	.rx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_rx_tbl),
> > -	.pcs_tbl		= sm8350_ufsphy_pcs_tbl,
> > -	.pcs_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_pcs_tbl),
> > +	.tables = {
> > +		.serdes		= sm8350_ufsphy_serdes,
> > +		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_serdes),
> > +		.tx		= sm8350_ufsphy_tx,
> > +		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_tx),
> > +		.rx		= sm8350_ufsphy_rx,
> > +		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_rx),
> > +		.pcs		= sm8350_ufsphy_pcs,
> > +		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_pcs),
> > +	},
> >   	.clk_list		= sdm845_ufs_phy_clk_l,
> >   	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> >   	.vreg_list		= qmp_phy_vreg_l,
> > @@ -776,14 +791,16 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
> >   static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
> >   	.lanes			= 2,
> > -	.serdes_tbl		= sm8350_ufsphy_serdes_tbl,
> > -	.serdes_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_serdes_tbl),
> > -	.tx_tbl			= sm8350_ufsphy_tx_tbl,
> > -	.tx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_tx_tbl),
> > -	.rx_tbl			= sm8350_ufsphy_rx_tbl,
> > -	.rx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_rx_tbl),
> > -	.pcs_tbl		= sm8350_ufsphy_pcs_tbl,
> > -	.pcs_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_pcs_tbl),
> > +	.tables = {
> > +		.serdes		= sm8350_ufsphy_serdes,
> > +		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_serdes),
> > +		.tx		= sm8350_ufsphy_tx,
> > +		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_tx),
> > +		.rx		= sm8350_ufsphy_rx,
> > +		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_rx),
> > +		.pcs		= sm8350_ufsphy_pcs,
> > +		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_pcs),
> > +	},
> >   	.clk_list		= sm8450_ufs_phy_clk_l,
> >   	.num_clks		= ARRAY_SIZE(sm8450_ufs_phy_clk_l),
> >   	.vreg_list		= qmp_phy_vreg_l,
> > @@ -826,16 +843,43 @@ static void qmp_ufs_configure(void __iomem *base,
> >   	qmp_ufs_configure_lane(base, regs, tbl, num, 0xff);
> >   }
> > -static int qmp_ufs_serdes_init(struct qmp_phy *qphy)
> > +static void qmp_ufs_serdes_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tables *tables)
> >   {
> >   	const struct qmp_phy_cfg *cfg = qphy->cfg;
> >   	void __iomem *serdes = qphy->serdes;
> > -	const struct qmp_phy_init_tbl *serdes_tbl = cfg->serdes_tbl;
> > -	int serdes_tbl_num = cfg->serdes_tbl_num;
> > -	qmp_ufs_configure(serdes, cfg->regs, serdes_tbl, serdes_tbl_num);
> > +	if (!tables)
> > +		return;
> > -	return 0;
> > +	qmp_ufs_configure(serdes, cfg->regs, tables->serdes, tables->serdes_num);
> > +}
> > +
> > +static void qmp_ufs_lanes_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tables *tables)
> > +{
> > +	const struct qmp_phy_cfg *cfg = qphy->cfg;
> > +	void __iomem *tx = qphy->tx;
> > +	void __iomem *rx = qphy->rx;
> > +
> > +	qmp_ufs_configure_lane(tx, cfg->regs, tables->tx, tables->tx_num, 1);
> > +
> > +	if (cfg->lanes >= 2)
> > +		qmp_ufs_configure_lane(qphy->tx2, cfg->regs, tables->tx, tables->tx_num, 2);
> > +
> > +	qmp_ufs_configure_lane(rx, cfg->regs, tables->rx, tables->rx_num, 1);
> > +
> > +	if (cfg->lanes >= 2)
> > +		qmp_ufs_configure_lane(qphy->rx2, cfg->regs, tables->rx, tables->rx_num, 2);
> > +}
> > +
> > +static void qmp_ufs_pcs_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tables *tables)
> > +{
> > +	const struct qmp_phy_cfg *cfg = qphy->cfg;
> > +	void __iomem *pcs = qphy->pcs;
> > +
> > +	if (!tables)
> > +		return;
> > +
> > +	qmp_ufs_configure(pcs, cfg->regs, tables->pcs, tables->pcs_num);
> >   }
> >   static int qmp_ufs_com_init(struct qmp_phy *qphy)
> > @@ -933,31 +977,16 @@ static int qmp_ufs_power_on(struct phy *phy)
> >   	struct qmp_phy *qphy = phy_get_drvdata(phy);
> >   	struct qcom_qmp *qmp = qphy->qmp;
> >   	const struct qmp_phy_cfg *cfg = qphy->cfg;
> > -	void __iomem *tx = qphy->tx;
> > -	void __iomem *rx = qphy->rx;
> >   	void __iomem *pcs = qphy->pcs;
> >   	void __iomem *status;
> >   	unsigned int mask, val, ready;
> >   	int ret;
> > -	qmp_ufs_serdes_init(qphy);
> > -
> > -	/* Tx, Rx, and PCS configurations */
> > -	qmp_ufs_configure_lane(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num, 1);
> > +	qmp_ufs_serdes_init(qphy, &cfg->tables);
> > -	if (cfg->lanes >= 2) {
> > -		qmp_ufs_configure_lane(qphy->tx2, cfg->regs,
> > -					cfg->tx_tbl, cfg->tx_tbl_num, 2);
> > -	}
> > -
> > -	qmp_ufs_configure_lane(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num, 1);
> > -
> > -	if (cfg->lanes >= 2) {
> > -		qmp_ufs_configure_lane(qphy->rx2, cfg->regs,
> > -					cfg->rx_tbl, cfg->rx_tbl_num, 2);
> > -	}
> > +	qmp_ufs_lanes_init(qphy, &cfg->tables);
> > -	qmp_ufs_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
> > +	qmp_ufs_pcs_init(qphy, &cfg->tables);
> 
> I'd suggest going straight to qmp_ufs_init_registers, which would contain
> both serdes, lanes and pcs inits.
> 

That adds one more level of indirection which may not be needed here. Moreover,
I'm trying to be in sync with other qmp drivers, specifically the pcie one.
This helps in working with these drivers.

Thanks,
Mani

> >   	ret = reset_control_deassert(qmp->ufs_reset);
> >   	if (ret)
> 
> -- 
> With best wishes
> Dmitry
> 

-- 
மணிவண்ணன் சதாசிவம்
