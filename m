Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC4E611132
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJ1MXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJ1MXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:23:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A4A40E1E;
        Fri, 28 Oct 2022 05:23:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D3C1B829BC;
        Fri, 28 Oct 2022 12:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28541C433C1;
        Fri, 28 Oct 2022 12:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666959816;
        bh=aMABIn5VBGdso1UMHCRd1cHCeGi+PYCtr5sq0K9Cir4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IGk2WYZRRV7vVnwGQvOBOk4TvzROTq98CggsXXE4XOYG0ME/bGsRJJy3/VPjLzjcy
         V7Rs1iZ2Y1Pp2i9MroALy+l9WCD67zdsztcdsHKqy/Erx0frb6AWBBQ+shW3TiQ+D9
         +j4t6RwU8VKo/A/eC2cpO8NyuXOQa5z99ziSDuoDp7oZH0oRDfbixnL96HNud1vOsF
         7+E6Mj9L65fz1beQ4zdZjxr+tspMkXJ8TGo3p8KTT35YV2/jwk+GWr/Mrr+xav4zM2
         QlsjCqaWXUruUzGgwSzcN3Yb0GUNE2w0jfOogBrJk0EgA5jWIovHXEpPa1Y6mxwIEo
         Ipa79QTy4/B6A==
Date:   Fri, 28 Oct 2022 17:53:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, mani@kernel.org
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/20] phy: qcom-qmp-pcie: drop start-ctrl abstraction
Message-ID: <Y1vJw2Co5tVhUrc+@matsya>
References: <20221012084846.24003-1-johan+linaro@kernel.org>
 <20221012085002.24099-1-johan+linaro@kernel.org>
 <20221012085002.24099-16-johan+linaro@kernel.org>
 <81632b90-bc8a-7f3b-d2c9-153b4cea16ed@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81632b90-bc8a-7f3b-d2c9-153b4cea16ed@linaro.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-10-22, 00:20, Dmitry Baryshkov wrote:
> On 12/10/2022 11:49, Johan Hovold wrote:
> > All PCIe PHYs need to start and stop the SerDes and PCS so drop the
> > start-ctrl abstraction which is no longer needed since the QMP driver
> > split.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 18 +++---------------
> >   1 file changed, 3 insertions(+), 15 deletions(-)
> 
> I think it should be possible to also drop the pwrdn_ctrl by replacing it
> with something like no_refclk_drv_dsbl. However I'd like to understand why
> this is not required for SDX55. Is this the peculiarity of that platform? Or
> is it a specifics of the EP mode?
> Many, Vinod, do you know the answer by chance?

Adding Mani, i am not sure maybe sdx55 specific...?

> 
> Nevertheless, for this patch:
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > index d3e7e673114f..5534a4ad0243 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > @@ -1355,7 +1355,6 @@ struct qmp_phy_cfg {
> >   	/* array of registers with different offsets */
> >   	const unsigned int *regs;
> > -	unsigned int start_ctrl;
> >   	unsigned int pwrdn_ctrl;
> >   	/* bit offset of PHYSTATUS in QPHY_PCS_STATUS register */
> >   	unsigned int phy_status;
> > @@ -1491,7 +1490,6 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
> >   	.num_vregs		= 0,
> >   	.regs			= pciephy_regs_layout,
> > -	.start_ctrl		= SERDES_START | PCS_START,
> >   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> >   	.phy_status		= PHYSTATUS,
> >   };
> > @@ -1517,7 +1515,6 @@ static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
> >   	.num_vregs		= 0,
> >   	.regs			= ipq_pciephy_gen3_regs_layout,
> > -	.start_ctrl		= SERDES_START | PCS_START,
> >   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> >   	.phy_status		= PHYSTATUS,
> > @@ -1547,7 +1544,6 @@ static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
> >   	.num_vregs		= 0,
> >   	.regs			= ipq_pciephy_gen3_regs_layout,
> > -	.start_ctrl		= SERDES_START | PCS_START,
> >   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> >   	.phy_status		= PHYSTATUS,
> >   };
> > @@ -1575,7 +1571,6 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
> >   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> >   	.regs			= sdm845_qmp_pciephy_regs_layout,
> > -	.start_ctrl		= PCS_START | SERDES_START,
> >   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> >   	.phy_status		= PHYSTATUS,
> >   };
> > @@ -1601,7 +1596,6 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
> >   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> >   	.regs			= sdm845_qhp_pciephy_regs_layout,
> > -	.start_ctrl		= PCS_START | SERDES_START,
> >   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> >   	.phy_status		= PHYSTATUS,
> >   };
> > @@ -1639,7 +1633,6 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
> >   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> >   	.regs			= sm8250_pcie_regs_layout,
> > -	.start_ctrl		= PCS_START | SERDES_START,
> >   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> >   	.phy_status		= PHYSTATUS,
> >   };
> > @@ -1677,7 +1670,6 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
> >   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> >   	.regs			= sm8250_pcie_regs_layout,
> > -	.start_ctrl		= PCS_START | SERDES_START,
> >   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> >   	.phy_status		= PHYSTATUS,
> >   };
> > @@ -1703,7 +1695,6 @@ static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
> >   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> >   	.regs			= pciephy_regs_layout,
> > -	.start_ctrl             = SERDES_START | PCS_START,
> >   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> >   	.phy_status		= PHYSTATUS,
> > @@ -1733,7 +1724,6 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
> >   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> >   	.regs			= sm8250_pcie_regs_layout,
> > -	.start_ctrl		= PCS_START | SERDES_START,
> >   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> >   	.phy_status		= PHYSTATUS,
> >   };
> > @@ -1761,7 +1751,6 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
> >   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> >   	.regs			= sm8250_pcie_regs_layout,
> > -	.start_ctrl		= PCS_START | SERDES_START,
> >   	.pwrdn_ctrl		= SW_PWRDN,
> >   	.phy_status		= PHYSTATUS_4_20,
> >   };
> > @@ -1789,7 +1778,6 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
> >   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> >   	.regs			= sm8250_pcie_regs_layout,
> > -	.start_ctrl             = SERDES_START | PCS_START,
> >   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> >   	.phy_status		= PHYSTATUS,
> >   };
> > @@ -1832,7 +1820,6 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
> >   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> >   	.regs			= sm8250_pcie_regs_layout,
> > -	.start_ctrl             = SERDES_START | PCS_START,
> >   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> >   	.phy_status		= PHYSTATUS_4_20,
> >   };
> > @@ -1997,7 +1984,7 @@ static int qmp_pcie_power_on(struct phy *phy)
> >   	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
> >   	/* start SerDes and Phy-Coding-Sublayer */
> > -	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
> > +	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], SERDES_START | PCS_START);
> >   	if (!cfg->skip_start_delay)
> >   		usleep_range(1000, 1200);
> > @@ -2030,7 +2017,8 @@ static int qmp_pcie_power_off(struct phy *phy)
> >   	qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
> >   	/* stop SerDes and Phy-Coding-Sublayer */
> > -	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
> > +	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL],
> > +			SERDES_START | PCS_START);
> >   	/* Put PHY into POWER DOWN state: active low */
> >   	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
> 
> -- 
> With best wishes
> Dmitry

-- 
~Vinod
