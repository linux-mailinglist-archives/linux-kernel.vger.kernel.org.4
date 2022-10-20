Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CD2605784
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJTGnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiJTGnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:43:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E501C1170;
        Wed, 19 Oct 2022 23:43:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8899F619EE;
        Thu, 20 Oct 2022 06:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE434C433C1;
        Thu, 20 Oct 2022 06:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666248213;
        bh=P98rue6EL+V6EJka1psQePQe1VwTN63BL+TzJqbRDKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ISHlqu89GIBldf3hubnpjInbd0yT3HfVjtB4wq27T/1F9w1/EjGes5gvfy0CL7jwY
         evODlNH1f62m7pL0Tdg/wqzz/K/hqHs7hcRqwOsnEHM6uD4GabRIGOu48+RG4a6/MR
         PwBdthU+zUG3MWdLHejIZWXxjw/V7ARdvHTVz5Mz/peOGGYxSDQxI9eaVKOsDvUsUO
         XuCFKsSlilDVtw2FuMVYXCMhEvF5+2UtziSGKHVx8UhcICrEcpdbQxrC77nblmRri4
         Y7CxebnRRzr32eQEDJc2OfC9zHvtymQ9glN2/pBOh7RilJysnM3fEHfUgjDXDx3gyW
         IiZlUJhisO24Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1olPGx-0005YY-5N; Thu, 20 Oct 2022 08:43:19 +0200
Date:   Thu, 20 Oct 2022 08:43:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/15] phy: qcom-qmp-pcie: add support for sc8280xp
 4-lane PHYs
Message-ID: <Y1DuB6hzb3V5Lqdy@hovoldconsulting.com>
References: <20221019113552.22353-1-johan+linaro@kernel.org>
 <20221019113552.22353-16-johan+linaro@kernel.org>
 <2902e7e8-eddf-149c-06fd-86b85d8af326@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2902e7e8-eddf-149c-06fd-86b85d8af326@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 06:43:47AM +0300, Dmitry Baryshkov wrote:
> On 19/10/2022 14:35, Johan Hovold wrote:
> > The PCIe2 and PCIe3 controllers and PHYs on SC8280XP can be used in
> > 4-lane mode or as separate controllers and PHYs in 2-lane mode (e.g. as
> > PCIe2A and PCIe2B).
> > 
> > Add support for fetching the 4-lane configuration from the TCSR and
> > programming the lane registers of the second port when in 4-lane mode.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   drivers/phy/qualcomm/Kconfig             |   1 +
> >   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 118 +++++++++++++++++++++++
> >   2 files changed, 119 insertions(+)
> > 
> > diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
> > index 5c98850f5a36..eb9ddc685b38 100644
> > --- a/drivers/phy/qualcomm/Kconfig
> > +++ b/drivers/phy/qualcomm/Kconfig
> > @@ -54,6 +54,7 @@ config PHY_QCOM_QMP
> >   	tristate "Qualcomm QMP PHY Driver"
> >   	depends on OF && COMMON_CLK && (ARCH_QCOM || COMPILE_TEST)
> >   	select GENERIC_PHY
> > +	select MFD_SYSCON
> >   	help
> >   	  Enable this to support the QMP PHY transceiver that is used
> >   	  with controllers such as PCIe, UFS, and USB on Qualcomm chips.
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > index ea5228bd9ecc..e5bce4810bb5 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > @@ -10,6 +10,7 @@
> >   #include <linux/io.h>
> >   #include <linux/iopoll.h>
> >   #include <linux/kernel.h>
> > +#include <linux/mfd/syscon.h>
> >   #include <linux/module.h>
> >   #include <linux/of.h>
> >   #include <linux/of_device.h>
> > @@ -17,6 +18,7 @@
> >   #include <linux/phy/pcie.h>
> >   #include <linux/phy/phy.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> >   #include <linux/regulator/consumer.h>
> >   #include <linux/reset.h>
> >   #include <linux/slab.h>
> > @@ -886,6 +888,10 @@ static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x2_pcie_rc_serdes_tbl[] =
> >   	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
> >   };
> >   
> > +static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x4_pcie_serdes_4ln_tbl[] = {
> > +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x1c),
> > +};
> > +
> >   static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x1_pcie_tx_tbl[] = {
> >   	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PI_QEC_CTRL, 0x20),
> >   	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0x75),
> > @@ -1491,6 +1497,9 @@ struct qmp_phy_cfg {
> >   	const struct qmp_phy_cfg_tables *tables_rc;
> >   	const struct qmp_phy_cfg_tables *tables_ep;
> >   
> > +	const struct qmp_phy_init_tbl *serdes_4ln_tbl;
> > +	int serdes_4ln_num;
> 
> Would it make more sense to change this into the proper 
> qmp_phy_cfg_tables entry and then use the existing API for programming 
> the table?

No, there is just one serdes register update needed when in 4-lane mode,
besides programming tx/rx for the second port. Adding a third struct
qmp_phy_cfg_tables for this seems like overkill and would lead to a more
convoluted implementation of the programming sequence.

And you can't add it two one of the existing ones, as your comment seems
to suggest.

The gen3x4 PHYs can be in either 4-lane or 2-lane mode depending on the
TCSR configuration. Port A is programmed identically in both cases
except for this serdes register, and in 4-lane mode tx/rx also needs
to be programmed for port B.
 
> > +
> >   	/* clock ids to be requested */
> >   	const char * const *clk_list;
> >   	int num_clks;
> > @@ -1518,6 +1527,7 @@ struct qmp_pcie {
> >   	struct device *dev;
> >   
> >   	const struct qmp_phy_cfg *cfg;
> > +	bool tcsr_4ln_config;
> 
> As a matter of preference, this seems too specific. I'd rename it to 
> split_config or split_4ln_config.

I'm afraid those names do not make much sense. This TCSR register
controls whether the PHY is in 4-lane mode (instead of 2-lane mode).

> >   
> >   	void __iomem *serdes;
> >   	void __iomem *pcs;
> > @@ -1527,6 +1537,8 @@ struct qmp_pcie {
> >   	void __iomem *tx2;
> >   	void __iomem *rx2;
> >   
> > +	void __iomem *port_b;
> > +
> >   	struct clk *pipe_clk;
> >   	struct clk *pipediv2_clk;
> >   	struct clk_bulk_data *clks;
> > @@ -1932,6 +1944,44 @@ static const struct qmp_phy_cfg sc8280xp_qmp_gen3x2_pciephy_cfg = {
> >   	.phy_status		= PHYSTATUS,
> >   };
  
> > +static void qmp_pcie_init_port_b(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
> > +{
> > +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> > +	const struct qmp_pcie_offsets *offs = cfg->offsets;
> > +	void __iomem *tx3, *rx3, *tx4, *rx4;
> > +
> > +	tx3 = qmp->port_b + offs->tx;
> > +	rx3 = qmp->port_b + offs->rx;
> > +	tx4 = qmp->port_b + offs->tx2;
> > +	rx4 = qmp->port_b + offs->rx2;
> > +
> > +	qmp_pcie_configure_lane(tx3, tbls->tx, tbls->tx_num, 1);
> > +	qmp_pcie_configure_lane(rx3, tbls->rx, tbls->rx_num, 1);
> > +
> > +	qmp_pcie_configure_lane(tx4, tbls->tx, tbls->tx_num, 2);
> > +	qmp_pcie_configure_lane(rx4, tbls->rx, tbls->rx_num, 2);
> 
> I'd use BIT(2) and BIT(3) here. This would allow one to make a 
> difference between programming first pair of lanes and second pair of 
> lanes if necessary.

No, the tx and tx registers of the second port should be programmed
identically to that of the first port.

> > +}
> > +
> >   static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
> >   {
> >   	const struct qmp_phy_cfg *cfg = qmp->cfg;
> > @@ -2080,6 +2148,11 @@ static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_c
> >   
> >   	qmp_pcie_configure(pcs, tbls->pcs, tbls->pcs_num);
> >   	qmp_pcie_configure(pcs_misc, tbls->pcs_misc, tbls->pcs_misc_num);
> > +
> > +	if (cfg->lanes >= 4 && qmp->tcsr_4ln_config) {
> > +		qmp_pcie_configure(serdes, cfg->serdes_4ln_tbl, cfg->serdes_4ln_num);
> > +		qmp_pcie_init_port_b(qmp, tbls);
> > +	}
> 
> As you have been refactoring this piece of code, maybe it would make 
> more sense to change qmp->tx/tx2 into an array of two elements? Then we 
> can extend it to 4 in this patch, and just always write the whole array 
> in a loop?

No, I don't think that would be an improvement and would obscure the
fact that we're programming two otherwise identical ports (e.g. tx1 and
tx2 of port B is used for the third and fourth lanes).

Note that the above conditional encodes the difference in programming
sequence between 4-lane and 2-lane mode I described above (one serdes
register difference + tx/rx of port b).

Johan
