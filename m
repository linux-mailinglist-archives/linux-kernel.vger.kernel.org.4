Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2E761DA8D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 14:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiKENR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 09:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKENRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 09:17:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E494DEE0;
        Sat,  5 Nov 2022 06:17:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFA6EB81CD0;
        Sat,  5 Nov 2022 13:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757F0C433C1;
        Sat,  5 Nov 2022 13:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667654241;
        bh=g8lIKSV/SnGce3PP/TyHF+6TUk0vGoCQ14dXjV9GD4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r77WgSbuYIqnJVLLN+6Wh2Qi3bbAn4mvy6z83OjfMXHzJ9UB0haxjhyOxJ2OazLil
         uthSj0nqeMSOwcSfRMS/mCZlOjRhGhq4AXqkRDEKSkL816JMAJAydP2mEwMslFg7Oo
         chDeMPi88bk3fJ3JZDdxk3L6RigxvJNnQar+IQRhZOem/U2Z6LzSVVK27qEWJmyfEH
         2Dt50gtREw/WzVI6WTb9DUcusA2iWogSqqAL3DQuQwFvL2DyM+sxdwFk52GprRLQL6
         2p2e94UHD8g7GRP+61rRMJINJh27KqwAt2LI3AnVE/zXgrXhoBgaroTHaHZkHcGhbI
         YdPwsfg7DATBA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1orJ2j-0006ok-8P; Sat, 05 Nov 2022 14:17:01 +0100
Date:   Sat, 5 Nov 2022 14:17:01 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/16] phy: qcom-qmp-pcie: add register init helper
Message-ID: <Y2ZiTWk+dJj/XNu/@hovoldconsulting.com>
References: <20221028133603.18470-1-johan+linaro@kernel.org>
 <20221028133603.18470-10-johan+linaro@kernel.org>
 <Y2ZSVooZDBDnsKD3@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2ZSVooZDBDnsKD3@matsya>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 05:38:54PM +0530, Vinod Koul wrote:
> On 28-10-22, 15:35, Johan Hovold wrote:
> > Generalise the serdes initialisation helper so that it can be used to
> > initialise all the PHY registers (e.g. serdes, tx, rx, pcs).
> > 
> > Note that this defers the ungating of the PIPE clock somewhat, which is
> > fine as it isn't needed until starting the PHY.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 37 +++++-------------------
> >  1 file changed, 8 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > index 791ed7ef0eab..f57d10f20277 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > @@ -1820,27 +1820,22 @@ static void qmp_pcie_configure(void __iomem *base,
> >  	qmp_pcie_configure_lane(base, tbl, num, 0xff);
> >  }
> >  
> > -static void qmp_pcie_serdes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
> > -{
> > -	void __iomem *serdes = qmp->serdes;
> > -
> > -	if (!tbls)
> > -		return;
> > -
> > -	qmp_pcie_configure(serdes, tbls->serdes, tbls->serdes_num);
> > -}
> > -
> > -static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
> > +static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
> >  {
> >  	const struct qmp_phy_cfg *cfg = qmp->cfg;
> > +	void __iomem *serdes = qmp->serdes;
> >  	void __iomem *tx = qmp->tx;
> >  	void __iomem *rx = qmp->rx;
> >  	void __iomem *tx2 = qmp->tx2;
> >  	void __iomem *rx2 = qmp->rx2;
> > +	void __iomem *pcs = qmp->pcs;
> > +	void __iomem *pcs_misc = qmp->pcs_misc;
> >  
> >  	if (!tbls)
> >  		return;
> >  
> > +	qmp_pcie_configure(serdes, tbls->serdes, tbls->serdes_num);
> 
> We are tbls

Yeah, it's a separate function.

Note that qmp_pcie_configure_lane() above use 'tbl' too.

> > +
> >  	qmp_pcie_configure_lane(tx, tbls->tx, tbls->tx_num, 1);
> >  	qmp_pcie_configure_lane(rx, tbls->rx, tbls->rx_num, 1);
> >  
> > @@ -1848,15 +1843,6 @@ static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_t
> >  		qmp_pcie_configure_lane(tx2, tbls->tx, tbls->tx_num, 2);
> >  		qmp_pcie_configure_lane(rx2, tbls->rx, tbls->rx_num, 2);
> >  	}
> > -}
> > -
> > -static void qmp_pcie_pcs_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
> > -{
> > -	void __iomem *pcs = qmp->pcs;
> > -	void __iomem *pcs_misc = qmp->pcs_misc;
> > -
> > -	if (!tbls)
> > -		return;
> >  
> >  	qmp_pcie_configure(pcs, tbls->pcs, tbls->pcs_num);
> >  	qmp_pcie_configure(pcs_misc, tbls->pcs_misc, tbls->pcs_misc_num);
> > @@ -1932,8 +1918,8 @@ static int qmp_pcie_power_on(struct phy *phy)
> >  	else
> >  		mode_tables = cfg->tables_ep;
> >  
> > -	qmp_pcie_serdes_init(qmp, &cfg->tables);
> > -	qmp_pcie_serdes_init(qmp, mode_tables);
> > +	qmp_pcie_init_registers(qmp, &cfg->tables);
> > +	qmp_pcie_init_registers(qmp, mode_tables);
> 
> but here tables :(
> 
> Lets stick with either please, or if we have differentiation lets make
> it real obvious

It's not uncommon to use shorter local identifiers and a more descriptive
name in structures, but since the driver already used 'tbl' consistently
before the recent addition of the aggregate tables structure, I can
rename also those pointers so that we use 'tbl' and 'tbls' consistently
throughout the driver.

Johan
