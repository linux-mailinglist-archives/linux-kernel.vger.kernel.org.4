Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02832614CEA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiKAOl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiKAOlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:41:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F4912AFF;
        Tue,  1 Nov 2022 07:41:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43E24B81DE8;
        Tue,  1 Nov 2022 14:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8944BC433D6;
        Tue,  1 Nov 2022 14:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313711;
        bh=6fLhKHkcCTdjlHjtarNnhYCz/WQJHny1JZxIw0NKpOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AF/uNtsrND3wviLza4EuafmD0UX2XS6MQsazz+oR88XcaIULiugDHZRnocmmXBZhH
         bNOL2t6UgtyVgHhRR4f4VutDu7TuilN9Wgmx+yBS4/FNUfiJ3BLCdZWwEvPwiiUseA
         i0oMHlM9C+mMzgdTFcwcwv+lcWHhWRTXjM40DlIhRt9ZEJag+526y9AzZq1rHNg1WQ
         1n9lt1Dww8rDWZdhk+rdYvAXX3oajQrs10Cs1pCFFzdEX32XMMpRYxWw+/AOXFjeSB
         P5L0VjPVhRkqzH74iRyt5vr24K/6BU1X/zdQ39frmZ1p9JPT4VddIOQ7I4LTipmB2H
         kx+Jkd9fLNs+Q==
Date:   Tue, 1 Nov 2022 20:11:35 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, quic_cang@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 01/15] phy: qcom-qmp-ufs: Move register settings to
 qmp_phy_cfg_tables struct
Message-ID: <20221101144135.GC244012@thinkpad>
References: <20221029141633.295650-1-manivannan.sadhasivam@linaro.org>
 <20221029141633.295650-2-manivannan.sadhasivam@linaro.org>
 <14844656-0d93-eac0-1877-f3e967691f5a@linaro.org>
 <20221031154607.GB12738@thinkpad>
 <748f41e1-cafc-e7eb-43ac-b8daacf88da4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <748f41e1-cafc-e7eb-43ac-b8daacf88da4@linaro.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 09:50:59PM +0300, Dmitry Baryshkov wrote:
> On 31/10/2022 18:46, Manivannan Sadhasivam wrote:
> > On Sun, Oct 30, 2022 at 12:50:50AM +0300, Dmitry Baryshkov wrote:
> > > On 29/10/2022 17:16, Manivannan Sadhasivam wrote:
> > > > As done for Qcom PCIe PHY driver, let's move the register settings to the
> > > > common qmp_phy_cfg_tables struct. This helps in adding any additional PHY
> > > > settings needed for functionalities like HS-G4 in the future by adding one
> > > > more instance of the qmp_phy_cfg_tables.
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >    drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 223 +++++++++++++-----------
> > > >    1 file changed, 126 insertions(+), 97 deletions(-)
> > > > 
> > > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c

[...]

> > > >    static int qmp_ufs_com_init(struct qmp_phy *qphy)
> > > > @@ -933,31 +977,16 @@ static int qmp_ufs_power_on(struct phy *phy)
> > > >    	struct qmp_phy *qphy = phy_get_drvdata(phy);
> > > >    	struct qcom_qmp *qmp = qphy->qmp;
> > > >    	const struct qmp_phy_cfg *cfg = qphy->cfg;
> > > > -	void __iomem *tx = qphy->tx;
> > > > -	void __iomem *rx = qphy->rx;
> > > >    	void __iomem *pcs = qphy->pcs;
> > > >    	void __iomem *status;
> > > >    	unsigned int mask, val, ready;
> > > >    	int ret;
> > > > -	qmp_ufs_serdes_init(qphy);
> > > > -
> > > > -	/* Tx, Rx, and PCS configurations */
> > > > -	qmp_ufs_configure_lane(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num, 1);
> > > > +	qmp_ufs_serdes_init(qphy, &cfg->tables);
> > > > -	if (cfg->lanes >= 2) {
> > > > -		qmp_ufs_configure_lane(qphy->tx2, cfg->regs,
> > > > -					cfg->tx_tbl, cfg->tx_tbl_num, 2);
> > > > -	}
> > > > -
> > > > -	qmp_ufs_configure_lane(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num, 1);
> > > > -
> > > > -	if (cfg->lanes >= 2) {
> > > > -		qmp_ufs_configure_lane(qphy->rx2, cfg->regs,
> > > > -					cfg->rx_tbl, cfg->rx_tbl_num, 2);
> > > > -	}
> > > > +	qmp_ufs_lanes_init(qphy, &cfg->tables);
> > > > -	qmp_ufs_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
> > > > +	qmp_ufs_pcs_init(qphy, &cfg->tables);
> > > 
> > > I'd suggest going straight to qmp_ufs_init_registers, which would contain
> > > both serdes, lanes and pcs inits.
> > > 
> > 
> > That adds one more level of indirection which may not be needed here. Moreover,
> > I'm trying to be in sync with other qmp drivers, specifically the pcie one.
> > This helps in working with these drivers.
> 
> Yes, I understand. However I hope that the respective patchset (including
> [1]) will be merged soon. Thus I suggest skipping the step and using the
> same function already.
> 
> [1] https://lore.kernel.org/linux-phy/20221028133603.18470-10-johan+linaro@kernel.org/
> 

Ah, I missed this series. Will use the common function then.

Thanks,
Mani

> > 
> > Thanks,
> > Mani
> > 
> > > >    	ret = reset_control_deassert(qmp->ufs_reset);
> > > >    	if (ret)
> > > 
> > > -- 
> > > With best wishes
> > > Dmitry
> > > 
> > 
> 
> -- 
> With best wishes
> Dmitry
> 

-- 
மணிவண்ணன் சதாசிவம்
