Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BB35BDD8E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiITGqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiITGqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:46:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DE45B04B;
        Mon, 19 Sep 2022 23:46:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D64EF6230C;
        Tue, 20 Sep 2022 06:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCC9C433C1;
        Tue, 20 Sep 2022 06:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663656362;
        bh=IWfJeKWmLuHACzZrveUELh0VlbJlmxI/wfJ2qMqFsas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iF9bHGCB+k3DdAqqx6WtJCfbxp13KHbYMMp3nUNGhp12rQwAu50+gMuWPy74YL2vO
         v2ky4yOA9MYZOvzh5zYqkFOHXSxs4HRaY884iX/wteKBXSuNzXt7ZMEPw8yimvOeSd
         7uuB5F0Us0fVv/BWryXEbuPSkXQOM8t+AoXkuXZSp2rIsHdUvCgc88lAcC0F5X8mKf
         wTE509G2RFVuNB3GOadoSNfUaNdQir9Ydl2OcFjh3KbMXDXpjKBQnIL5bFoPKma00h
         eSCEKC0vKlEVWAPZgnJTnVEfqF7OBR8mYqsW7YwnBd/TshoZCyMBgQ3oKYzXVgKlja
         m2jsibnfRs02A==
Date:   Tue, 20 Sep 2022 12:15:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, kishon@ti.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: qcom-qmp-pcie: Fix the SM8450 PCS registers
Message-ID: <YylhpBtz8d2dqJhv@matsya>
References: <20220910063857.17372-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910063857.17372-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-09-22, 12:08, Manivannan Sadhasivam wrote:
> In the PCS region, registers QPHY_V5_PCS_EQ_CONFIG4 and
> QPHY_V5_PCS_EQ_CONFIG5 should be used instead of QPHY_V5_PCS_EQ_CONFIG2
> and QPHY_V5_PCS_EQ_CONFIG3.
> 
> This causes high latency when ASPM is enabled, so fix it!
> 
> Fixes: 2c91bf6bf290 ("phy: qcom-qmp: Add SM8450 PCIe1 PHY support")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c   | 4 ++--
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 4648467d5cac..b508903d77d0 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1332,8 +1332,8 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_rx_tbl[] = {
>  };
>  
>  static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_tbl[] = {
> -	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG2, 0x16),
> -	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG3, 0x22),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG4, 0x16),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG5, 0x22),
>  	QMP_PHY_INIT_CFG(QPHY_V5_PCS_G3S2_PRE_GAIN, 0x2e),
>  	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RX_SIGDET_LVL, 0x99),
>  };
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
> index 61a44519f969..cca6455ec98c 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
> @@ -11,7 +11,7 @@
>  #define QPHY_V5_PCS_G3S2_PRE_GAIN			0x170
>  #define QPHY_V5_PCS_RX_SIGDET_LVL			0x188
>  #define QPHY_V5_PCS_RATE_SLEW_CNTRL1			0x198
> -#define QPHY_V5_PCS_EQ_CONFIG2				0x1e0
> -#define QPHY_V5_PCS_EQ_CONFIG3				0x1e4
> +#define QPHY_V5_PCS_EQ_CONFIG4				0x2e0
> +#define QPHY_V5_PCS_EQ_CONFIG5				0x2e4

This conflicts with c0c7769cdae2 ("phy: qcom-qmp: Add SC8280XP USB3 UNI phy")

where QPHY_V5_PCS_EQ_CONFIG5 was added as 0x1e0

Do we have a different v5 for SM8450 and SC8280XP?

-- 
~Vinod
