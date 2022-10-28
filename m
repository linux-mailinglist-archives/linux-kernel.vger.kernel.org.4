Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0736111F9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiJ1MzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiJ1Myt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:54:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D7A5F81;
        Fri, 28 Oct 2022 05:54:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8756ECE2AFD;
        Fri, 28 Oct 2022 12:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2483DC433C1;
        Fri, 28 Oct 2022 12:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666961683;
        bh=m+dABeNdo1jP9iK7JBRoT+Hc2J3W+ylW1aqtkyVNMsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fJrku492UpL2ToEbDTFMxi6MgjxD8xG5ZhVFxQ/A9TlfqFvWZkd6YLnAQbuq9pKbh
         ps3zJuE/fIRhkFDJkAflSMwdYg+b3yibDzDa3/Dxp08yf8e+gbx14ZjOSH6XY3xIcN
         TWMCsORy9TMbyiYTjXGXtgoh9tew9Xi0nAkPJYGOBYhZBps6GAlIUVZ2chV7h0K5LR
         2PSuzXsAOZurYLCZeO2F5mat8WIR7PFCU+M3t/DStOe6WMLFnE4DtCbeFTXINqb41j
         7EkujZVKWctY0xUTAOY3BvW/ka9zyXltTX6ozzoEj9eW8rirUO6vufCHrwND57NpSS
         OtA2CHU8IIIVQ==
Date:   Fri, 28 Oct 2022 18:24:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/15] phy: qcom-qmp-pcie: add register init helper
Message-ID: <Y1vRDv+hrMmnqwPj@matsya>
References: <20221021110947.28103-1-johan+linaro@kernel.org>
 <20221021110947.28103-9-johan+linaro@kernel.org>
 <932765e0-ecbc-8c9b-69c5-ce0bb0c8de68@linaro.org>
 <Y1KDXD9n0cCqjTGy@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1KDXD9n0cCqjTGy@hovoldconsulting.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-22, 13:32, Johan Hovold wrote:
> On Fri, Oct 21, 2022 at 02:18:49PM +0300, Dmitry Baryshkov wrote:
> > On 21/10/2022 14:09, Johan Hovold wrote:
> > > Generalise the serdes initialisation helper so that it can be used to
> > > initialise all the PHY registers (e.g. serdes, tx, rx, pcs).
> > > 
> > > Note that this defers the ungating of the PIPE clock somewhat, which is
> > > fine as it isn't needed until starting the PHY.
> > > 
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > >   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 51 +++++++-----------------
> > >   1 file changed, 15 insertions(+), 36 deletions(-)
> > > 
> > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > > index dd7e72424fc0..f57d10f20277 100644
> > > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > > @@ -1820,46 +1820,32 @@ static void qmp_pcie_configure(void __iomem *base,
> > >   	qmp_pcie_configure_lane(base, tbl, num, 0xff);
> > >   }
> > >   
> > > -static void qmp_pcie_serdes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
> > > -{
> > > -	void __iomem *serdes = qmp->serdes;
> > > -
> > > -	if (!tables)
> > > -		return;
> > > -
> > > -	qmp_pcie_configure(serdes, tables->serdes, tables->serdes_num);
> > > -}
> > > -
> > > -static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
> > > +static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
> > >   {
> > >   	const struct qmp_phy_cfg *cfg = qmp->cfg;
> > > +	void __iomem *serdes = qmp->serdes;
> > >   	void __iomem *tx = qmp->tx;
> > >   	void __iomem *rx = qmp->rx;
> > >   	void __iomem *tx2 = qmp->tx2;
> > >   	void __iomem *rx2 = qmp->rx2;
> > > +	void __iomem *pcs = qmp->pcs;
> > > +	void __iomem *pcs_misc = qmp->pcs_misc;
> > >   
> > > -	if (!tables)
> > > +	if (!tbls)
> > >   		return;
> > >   
> > > -	qmp_pcie_configure_lane(tx, tables->tx, tables->tx_num, 1);
> > > -	qmp_pcie_configure_lane(rx, tables->rx, tables->rx_num, 1);
> > > +	qmp_pcie_configure(serdes, tbls->serdes, tbls->serdes_num);
> > > +
> > > +	qmp_pcie_configure_lane(tx, tbls->tx, tbls->tx_num, 1);
> > > +	qmp_pcie_configure_lane(rx, tbls->rx, tbls->rx_num, 1);
> > >   
> > >   	if (cfg->lanes >= 2) {
> > > -		qmp_pcie_configure_lane(tx2, tables->tx, tables->tx_num, 2);
> > > -		qmp_pcie_configure_lane(rx2, tables->rx, tables->rx_num, 2);
> > > +		qmp_pcie_configure_lane(tx2, tbls->tx, tbls->tx_num, 2);
> > > +		qmp_pcie_configure_lane(rx2, tbls->rx, tbls->rx_num, 2);
> > >   	}
> > > -}
> > > -
> > > -static void qmp_pcie_pcs_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
> > > -{
> > > -	void __iomem *pcs = qmp->pcs;
> > > -	void __iomem *pcs_misc = qmp->pcs_misc;
> > > -
> > > -	if (!tables)
> > > -		return;
> > >   
> > > -	qmp_pcie_configure(pcs, tables->pcs, tables->pcs_num);
> > > -	qmp_pcie_configure(pcs_misc, tables->pcs_misc, tables->pcs_misc_num);
> > > +	qmp_pcie_configure(pcs, tbls->pcs, tbls->pcs_num);
> > > +	qmp_pcie_configure(pcs_misc, tbls->pcs_misc, tbls->pcs_misc_num);
> > 
> > As seem above, if nothing else, tables -> tbls rename generates 
> > unnecessary diff.
> 
> Can you please stop with the bikeshedding. This is not about keeping the
> diff small, this is about readability of the new helper function as I
> already told you.
> 
> And this is a *local* identifier, not some state member that needs a
> super descriptive name. And the rest of the driver used "tbl"
> consistently until your EP/RC mode patches for that matter.

I would disagree here... You can change tbls/tables but then it does not
help _this_ patch

Right thing would be to change tbls to tables first and then add init
helper... For a reviewer seeing an undocumented change and unnecessary
diff is not right..

Pls split if you would still like the rename

-- 
~Vinod
