Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99374605E59
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiJTK74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJTK7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:59:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9521A2F001;
        Thu, 20 Oct 2022 03:59:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 323A861AF6;
        Thu, 20 Oct 2022 10:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3E6C433D6;
        Thu, 20 Oct 2022 10:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666263590;
        bh=oNTahkkZ6EJ/BED5DDzmzj9s5hQoDekb/BIBiCvXL04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GAneG2oc8jEpfBXNZcINY8mPfqRun9rCjs2s+ctvZqqTjpqmE3wsnjWWsfjED+HJn
         fTNMJN/ptqz9FAneZtb5g2EezpCVMhhG7w7rjqYBpT0VixHap1C/j27J8JSRAmRsVr
         ijran+p0y7xHfvK/YC9dsgDe4lIjS7eidIEIWP5KybDUJ3kvdEsLILNDURjxZJwInc
         NYlKw/yqMmr69gjxs8e5pQsh2Tdfd3ldFtqLs4QxQVuzNujrjj36T/dlnrWZyefFqn
         vjlAtOQjbfBDoMaAfhq8Z5YBv2vLFNlU+MFD+Mz24blovOlCMDVlQkGNKFC1qUVm/i
         dS+zgsDhjXyEQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1olTGy-0002Ib-EE; Thu, 20 Oct 2022 12:59:37 +0200
Date:   Thu, 20 Oct 2022 12:59:36 +0200
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
Message-ID: <Y1EqGPc/UzZJmGcz@hovoldconsulting.com>
References: <20221019113552.22353-1-johan+linaro@kernel.org>
 <20221019113552.22353-16-johan+linaro@kernel.org>
 <2902e7e8-eddf-149c-06fd-86b85d8af326@linaro.org>
 <Y1DuB6hzb3V5Lqdy@hovoldconsulting.com>
 <004a6ab9-690b-db13-08a9-c42d09368814@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004a6ab9-690b-db13-08a9-c42d09368814@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 12:32:13PM +0300, Dmitry Baryshkov wrote:
> On 20/10/2022 09:43, Johan Hovold wrote:
> > On Thu, Oct 20, 2022 at 06:43:47AM +0300, Dmitry Baryshkov wrote:
> >> On 19/10/2022 14:35, Johan Hovold wrote:
> >>> The PCIe2 and PCIe3 controllers and PHYs on SC8280XP can be used in
> >>> 4-lane mode or as separate controllers and PHYs in 2-lane mode (e.g. as
> >>> PCIe2A and PCIe2B).
> >>>
> >>> Add support for fetching the 4-lane configuration from the TCSR and
> >>> programming the lane registers of the second port when in 4-lane mode.
> >>>
> >>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

> > The gen3x4 PHYs can be in either 4-lane or 2-lane mode depending on the
> > TCSR configuration. Port A is programmed identically in both cases
> > except for this serdes register, and in 4-lane mode tx/rx also needs
> > to be programmed for port B.
> >   
> >>> +
> >>>    	/* clock ids to be requested */
> >>>    	const char * const *clk_list;
> >>>    	int num_clks;
> >>> @@ -1518,6 +1527,7 @@ struct qmp_pcie {
> >>>    	struct device *dev;
> >>>    
> >>>    	const struct qmp_phy_cfg *cfg;
> >>> +	bool tcsr_4ln_config;
> >>
> >> As a matter of preference, this seems too specific. I'd rename it to
> >> split_config or split_4ln_config.
> > 
> > I'm afraid those names do not make much sense. This TCSR register
> > controls whether the PHY is in 4-lane mode (instead of 2-lane mode).
> 
> Well, we just need the info that it's 4-lane. It doesn't really matter 
> if this information comes from TCSR, DT or e.g. fuses. I'd say that TCSR 
> is a platform detail. Thus I'm suggesting a more generic name.

No, it's a specific configuration flag for this (and possibly coming
platforms) to control whether the two PHY ports are used as individual x2
PHYs or as a combined x4 PHY.

It's not just about number of lanes and can definitely not come from DT
or somewhere else as that TCSR bit drives a signal that's needed during
programming.

> >>> +static void qmp_pcie_init_port_b(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
> >>> +{
> >>> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> >>> +	const struct qmp_pcie_offsets *offs = cfg->offsets;
> >>> +	void __iomem *tx3, *rx3, *tx4, *rx4;
> >>> +
> >>> +	tx3 = qmp->port_b + offs->tx;
> >>> +	rx3 = qmp->port_b + offs->rx;
> >>> +	tx4 = qmp->port_b + offs->tx2;
> >>> +	rx4 = qmp->port_b + offs->rx2;
> >>> +
> >>> +	qmp_pcie_configure_lane(tx3, tbls->tx, tbls->tx_num, 1);
> >>> +	qmp_pcie_configure_lane(rx3, tbls->rx, tbls->rx_num, 1);
> >>> +
> >>> +	qmp_pcie_configure_lane(tx4, tbls->tx, tbls->tx_num, 2);
> >>> +	qmp_pcie_configure_lane(rx4, tbls->rx, tbls->rx_num, 2);
> >>
> >> I'd use BIT(2) and BIT(3) here. This would allow one to make a
> >> difference between programming first pair of lanes and second pair of
> >> lanes if necessary.
> > 
> > No, the tx and tx registers of the second port should be programmed
> > identically to that of the first port.
> 
> As you would prefer. As a matter of fact, we do not have CFG_LANES in 
> the PCIe PHY. Thus I'm surprised that you didn't drop this. I think 
> CFG_LANES usage is limited to sm8250 USB and combo PHY configurations.

It's actually also used by SC8280XP so we cannot drop it (see
sc8280xp_qmp_gen3x2_pcie_tx_tbl) here. Appears to be unused for UFS
currently, though.

Johan
