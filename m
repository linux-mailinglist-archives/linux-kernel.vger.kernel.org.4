Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1813260763C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiJULd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiJULdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:33:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF9D261AC8;
        Fri, 21 Oct 2022 04:33:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44E7661E6E;
        Fri, 21 Oct 2022 11:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9957EC433B5;
        Fri, 21 Oct 2022 11:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666351978;
        bh=bHuZR4rMM1qL/TW8wsRxJhDlERNua01QySV3U+fIvv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eZeNVZz3JoAcPEPpF+F5AsNEFUw3zhaSpNwhImh2d3/5yg5RIN6VUDLJwWGuUFrGi
         2FQ+bPJpzuQJE+t1NeQA679l5iRQJLYn2M28Db72OK+92h3ZqNBYYobUVuvskx1OR4
         vGZCdwkmjqcHMrugTD8qnBqAXm4KesaTBVvpv+5FruHd0Zj+Amc6H/tnk4fyR+XWjw
         Y97sR+w8c/+IbnV/wfw1dF8MG9KhwXMCkGIgNuojnvkQTeAHmuzJf1nZZUGLlb84Y5
         EirV2qFDReemL+mDuJ+o6cKZQR+GH26D1UP55H7g2jC20FMDhl9C3Tw+ZiMY7sdmcl
         Co4E0vDEHSQww==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1olqGa-00011A-QY; Fri, 21 Oct 2022 13:32:45 +0200
Date:   Fri, 21 Oct 2022 13:32:44 +0200
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
Subject: Re: [PATCH v3 08/15] phy: qcom-qmp-pcie: add register init helper
Message-ID: <Y1KDXD9n0cCqjTGy@hovoldconsulting.com>
References: <20221021110947.28103-1-johan+linaro@kernel.org>
 <20221021110947.28103-9-johan+linaro@kernel.org>
 <932765e0-ecbc-8c9b-69c5-ce0bb0c8de68@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <932765e0-ecbc-8c9b-69c5-ce0bb0c8de68@linaro.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 02:18:49PM +0300, Dmitry Baryshkov wrote:
> On 21/10/2022 14:09, Johan Hovold wrote:
> > Generalise the serdes initialisation helper so that it can be used to
> > initialise all the PHY registers (e.g. serdes, tx, rx, pcs).
> > 
> > Note that this defers the ungating of the PIPE clock somewhat, which is
> > fine as it isn't needed until starting the PHY.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 51 +++++++-----------------
> >   1 file changed, 15 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > index dd7e72424fc0..f57d10f20277 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > @@ -1820,46 +1820,32 @@ static void qmp_pcie_configure(void __iomem *base,
> >   	qmp_pcie_configure_lane(base, tbl, num, 0xff);
> >   }
> >   
> > -static void qmp_pcie_serdes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
> > -{
> > -	void __iomem *serdes = qmp->serdes;
> > -
> > -	if (!tables)
> > -		return;
> > -
> > -	qmp_pcie_configure(serdes, tables->serdes, tables->serdes_num);
> > -}
> > -
> > -static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
> > +static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
> >   {
> >   	const struct qmp_phy_cfg *cfg = qmp->cfg;
> > +	void __iomem *serdes = qmp->serdes;
> >   	void __iomem *tx = qmp->tx;
> >   	void __iomem *rx = qmp->rx;
> >   	void __iomem *tx2 = qmp->tx2;
> >   	void __iomem *rx2 = qmp->rx2;
> > +	void __iomem *pcs = qmp->pcs;
> > +	void __iomem *pcs_misc = qmp->pcs_misc;
> >   
> > -	if (!tables)
> > +	if (!tbls)
> >   		return;
> >   
> > -	qmp_pcie_configure_lane(tx, tables->tx, tables->tx_num, 1);
> > -	qmp_pcie_configure_lane(rx, tables->rx, tables->rx_num, 1);
> > +	qmp_pcie_configure(serdes, tbls->serdes, tbls->serdes_num);
> > +
> > +	qmp_pcie_configure_lane(tx, tbls->tx, tbls->tx_num, 1);
> > +	qmp_pcie_configure_lane(rx, tbls->rx, tbls->rx_num, 1);
> >   
> >   	if (cfg->lanes >= 2) {
> > -		qmp_pcie_configure_lane(tx2, tables->tx, tables->tx_num, 2);
> > -		qmp_pcie_configure_lane(rx2, tables->rx, tables->rx_num, 2);
> > +		qmp_pcie_configure_lane(tx2, tbls->tx, tbls->tx_num, 2);
> > +		qmp_pcie_configure_lane(rx2, tbls->rx, tbls->rx_num, 2);
> >   	}
> > -}
> > -
> > -static void qmp_pcie_pcs_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
> > -{
> > -	void __iomem *pcs = qmp->pcs;
> > -	void __iomem *pcs_misc = qmp->pcs_misc;
> > -
> > -	if (!tables)
> > -		return;
> >   
> > -	qmp_pcie_configure(pcs, tables->pcs, tables->pcs_num);
> > -	qmp_pcie_configure(pcs_misc, tables->pcs_misc, tables->pcs_misc_num);
> > +	qmp_pcie_configure(pcs, tbls->pcs, tbls->pcs_num);
> > +	qmp_pcie_configure(pcs_misc, tbls->pcs_misc, tbls->pcs_misc_num);
> 
> As seem above, if nothing else, tables -> tbls rename generates 
> unnecessary diff.

Can you please stop with the bikeshedding. This is not about keeping the
diff small, this is about readability of the new helper function as I
already told you.

And this is a *local* identifier, not some state member that needs a
super descriptive name. And the rest of the driver used "tbl"
consistently until your EP/RC mode patches for that matter.

> Other than that LGTM.

Johan
