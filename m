Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BDA604777
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiJSNj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiJSNig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:38:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CFEFF8E3;
        Wed, 19 Oct 2022 06:26:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73857B823B2;
        Wed, 19 Oct 2022 13:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16197C433C1;
        Wed, 19 Oct 2022 13:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666185961;
        bh=A5t4CXm5J1KUg+zlPQFV5lxTl6j5CK+3GZRfiu9Ujqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U4Uq19l5+cJ0WdPmSnhzmdK47Q0oxS06zMDRehgCsk9Vl2btsZ9fgLxXyBD8xkDET
         KrYYUPaM2H90Jwaxh6euwEnnqQ3sTThI7BAw+amUyBNMS0L/tO/yxHXoiADfss5o10
         E30f1kKn6s4sn1ucRIqBDdXC/rDUGqwJEplUbdwFoE5+izBqKzTq6QBY+m9MZF1Edm
         dlKbDAQFTwPMAaTd08shIl+KjWmILIt1CS84ZIdDWPUZ7gtMZJ6h1H4DrWWffCC2nf
         igH1hYaHF6OK4zqnQ9oDbVlpwFStdjduhhDD5wq0muwmF714bJkZv/VnlKt7bk0lAX
         t6WilUs1ndNFw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ol94v-0005wG-3Y; Wed, 19 Oct 2022 15:25:49 +0200
Date:   Wed, 19 Oct 2022 15:25:49 +0200
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
Subject: Re: [PATCH v2 08/15] phy: qcom-qmp-pcie: add register init helper
Message-ID: <Y0/63eH82t2zXFi5@hovoldconsulting.com>
References: <20221019113552.22353-1-johan+linaro@kernel.org>
 <20221019113552.22353-9-johan+linaro@kernel.org>
 <0f1fff20-772f-c4d1-f803-f1824ef23780@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f1fff20-772f-c4d1-f803-f1824ef23780@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 04:12:02PM +0300, Dmitry Baryshkov wrote:
> On 19/10/2022 14:35, Johan Hovold wrote:
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
> Nit: could we please keep it as `tables'?

I considered that but found that the longer identifier hurt
readability so I prefer to use "tbls" here.

Compare

	qmp_pcie_configure(serdes, tbls->serdes, tbls->serdes_num);

	qmp_pcie_configure_lane(tx, tbls->tx, tbls->tx_num, 1);
	qmp_pcie_configure_lane(rx, tbls->rx, tbls->rx_num, 1);

	if (cfg->lanes >= 2) {
		qmp_pcie_configure_lane(tx2, tbls->tx, tbls->tx_num, 2);
		qmp_pcie_configure_lane(rx2, tbls->rx, tbls->rx_num, 2);
	}

	qmp_pcie_configure(pcs, tbls->pcs, tbls->pcs_num);
	qmp_pcie_configure(pcs_misc, tbls->pcs_misc, tbls->pcs_misc_num);

with

	qmp_pcie_configure(serdes, tables->serdes, tables->serdes_num);

	qmp_pcie_configure_lane(tx, tables->tx, tables->tx_num, 1);
	qmp_pcie_configure_lane(rx, tables->rx, tables->rx_num, 1);

	if (cfg->lanes >= 2) {
		qmp_pcie_configure_lane(tx2, tables->tx, tables->tx_num, 2);
		qmp_pcie_configure_lane(rx2, tables->rx, tables->rx_num, 2);
	}

	qmp_pcie_configure(pcs, tables->pcs, tables->pcs_num);
	qmp_pcie_configure(pcs_misc, tables->pcs_misc, tables->pcs_misc_num);

Johan
