Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F34605A91
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiJTJGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiJTJGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:06:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD1E17D842;
        Thu, 20 Oct 2022 02:05:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A47E61A7C;
        Thu, 20 Oct 2022 09:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB3BC433D6;
        Thu, 20 Oct 2022 09:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666256753;
        bh=8iKdldjvKKs2lE0Li1/6feX8twrjb9ZVJyOVWEF5/5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eqa/6DDoOVKzdrO6zSjsCb3R4ZZvJUIXcmQe6uPPg8m6TXZBiMUQ29UidpE+J4nCl
         ijiamSzzmJSDYKYys7tqMKEaBTmY9NLDkIaR7IWieogwEgjhR4fa4PVdd4sntazKqI
         hVn4GJY1bVgT8URw7y6Xsi7CGHNsXkaQ9dCbtvc1l/MT5g5PekkZhmWuo8o7XYwpri
         i/5gUYlPorOyVRtWStTrQD2dWQqnhW3AXGEYDxqCLmKobKwXcemIefL1vOb7fM/FAr
         h1VPKL9dpYu+R0TQ0cc7c7bCaruLo3sWjUw2ClDmADIA+AcUUXu8yPob35PtpIHb1r
         GF8J7K2mUNLSw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1olRUi-0001AH-2K; Thu, 20 Oct 2022 11:05:40 +0200
Date:   Thu, 20 Oct 2022 11:05:40 +0200
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
Subject: Re: [PATCH v2 13/15] phy: qcom-qmp-pcie: add support for pipediv2
 clock
Message-ID: <Y1EPZBinv0tyZVqW@hovoldconsulting.com>
References: <20221019113552.22353-1-johan+linaro@kernel.org>
 <20221019113552.22353-14-johan+linaro@kernel.org>
 <325d6c7b-ca96-df73-a792-4d156a710267@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <325d6c7b-ca96-df73-a792-4d156a710267@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 11:31:35AM +0300, Dmitry Baryshkov wrote:
> On 19/10/2022 14:35, Johan Hovold wrote:
> > Some QMP PHYs have a second fixed-divider pipe clock that needs to be
> > enabled along with the pipe clock.
> > 
> > Add support for an optional "pipediv2" clock.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 42 ++++++++++++++++++++----
> >   1 file changed, 36 insertions(+), 6 deletions(-)

> I still think that the attached patch is somewhat simpler. Diffstat 
> supports that idea:
> 
> $ diffstat /tmp/pipe.diff
>   phy-qcom-qmp-pcie.c |   26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)

It's not just about LoC.
 
> Yes, I'm speaking this after having cleaned up several open-coded 
> versions of clk_bulk_foo from the drm/msm code. It typically starts with 
> the 'just another clock' story, and then suddenly they are all over the 
> code.

But you don't start using the bulk API when you have one clock. Two,
maybe. Three, sure. It's a decision that needs to be done on a case-by
case basis, and pipe clocks for the QMP block is different from general
interface clocks (which are more likely to be extended). (And of course
the clocks would need to be independent in the first place.)

Here's your example diff inline:

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 9c8e009033f1..a148b143dd90 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1378,8 +1378,10 @@ struct qmp_pcie {
 	void __iomem *tx2;
 	void __iomem *rx2;
 
-	struct clk *pipe_clk;
+	struct clk_bulk_data *pipe_clks;
+	int num_pipe_clks;
 	struct clk_bulk_data *clks;
+
 	struct reset_control_bulk_data *resets;
 	struct regulator_bulk_data *vregs;
 
@@ -1923,11 +1925,9 @@ static int qmp_pcie_power_on(struct phy *phy)
 	qmp_pcie_init_registers(qmp, &cfg->tables);
 	qmp_pcie_init_registers(qmp, mode_tables);
 
-	ret = clk_prepare_enable(qmp->pipe_clk);
-	if (ret) {
-		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
+	ret = clk_bulk_prepare_enable(qmp->num_pipe_clks, qmp->pipe_clks);
+	if (ret)
 		return ret;
-	}
 
 	/* Pull PHY out of reset state */
 	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
@@ -1950,7 +1950,7 @@ static int qmp_pcie_power_on(struct phy *phy)
 	return 0;
 
 err_disable_pipe_clk:
-	clk_disable_unprepare(qmp->pipe_clk);
+	clk_bulk_disable_unprepare(qmp->num_pipe_clks, qmp->pipe_clks);
 
 	return ret;
 }
@@ -1960,7 +1960,7 @@ static int qmp_pcie_power_off(struct phy *phy)
 	struct qmp_pcie *qmp = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 
-	clk_disable_unprepare(qmp->pipe_clk);
+	clk_bulk_disable_unprepare(qmp->num_pipe_clks, qmp->pipe_clks);
 
 	/* PHY reset */
 	qphy_setbits(qmp->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);

The above is pretty much identical, expect for using the bulk API
instead of the very straight-forward pipe-clock helpers.

@@ -2154,6 +2154,7 @@ static int qmp_pcie_parse_dt_legacy(struct qmp_pcie *qmp, struct device_node *np
 	struct platform_device *pdev = to_platform_device(qmp->dev);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	struct device *dev = qmp->dev;
+	struct clk *clk;
 
 	qmp->serdes = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(qmp->serdes))
@@ -2206,12 +2207,17 @@ static int qmp_pcie_parse_dt_legacy(struct qmp_pcie *qmp, struct device_node *np
 		}
 	}
 
-	qmp->pipe_clk = devm_get_clk_from_child(dev, np, NULL);
-	if (IS_ERR(qmp->pipe_clk)) {
-		return dev_err_probe(dev, PTR_ERR(qmp->pipe_clk),
+	clk = devm_get_clk_from_child(dev, np, NULL);
+	if (IS_ERR(clk)) {
+		return dev_err_probe(dev, PTR_ERR(clk),
 				     "failed to get pipe clock\n");
 	}
 
+	qmp->num_pipe_clks = 1;
+	qmp->pipe_clks = devm_kcalloc(dev, qmp->num_pipe_clks,
+				      sizeof(*qmp->pipe_clks), GFP_KERNEL);
+	qmp->pipe_clks[0].clk = clk;

So here you're poking at bulk API internals and forgot to set the id
string, which the implementation uses.

For reasons like this, and the fact that will likely never have a third
pipe clock, I'm reluctant to using the bulk API.

+
 	return 0;
 }
 
Johan
