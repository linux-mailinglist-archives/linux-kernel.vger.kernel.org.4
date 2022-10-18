Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B50602EE1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJROxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJROxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:53:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0F1D8ED0;
        Tue, 18 Oct 2022 07:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A26CBB81F93;
        Tue, 18 Oct 2022 14:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5D2C433C1;
        Tue, 18 Oct 2022 14:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666104807;
        bh=xY5BiZ6ZbFe5aQcbT010/8Bqi/0eo2aMR4dgD1EpzfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rUgMVV9DSN9+yoHM5MgMrkQQONs+hY1gEWW+7cJbZVyHPbjco8CWfe8vLRSgIsym4
         a2IV3Q21K/+ueczi8NKy1UBUcAgokU1o44xTHLOnPZyafZ3AZQhRTsB0QFPsQ7GVaa
         KVn0GVhCMNP1ZIPbxxJnrnoijMDzZprdTbx/X7Pfn1kziCLcpujms5VaARjvzxfbsJ
         uipcbXsvoXGjtb9SBhFmZ2hNFhnahe+sjrt5iVv80vd5xufA7VtUoSDiYtKgyTQz0b
         kdW0yEXO7xM4f83RI2UgmdXC2YtUii7fLBYfrFtZR3vHOTs/wUtL0NC8PSUcAjIDZ2
         VqsBvE1nLOF5w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oknxy-0005SJ-PV; Tue, 18 Oct 2022 16:53:15 +0200
Date:   Tue, 18 Oct 2022 16:53:14 +0200
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
Subject: Re: [PATCH 13/15] phy: qcom-qmp-pcie: add support for pipediv2 clock
Message-ID: <Y0692mW6MJneljrP@hovoldconsulting.com>
References: <20221017145328.22090-1-johan+linaro@kernel.org>
 <20221017145328.22090-14-johan+linaro@kernel.org>
 <2cf670a0-59bd-31b0-8816-496c1e13165d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cf670a0-59bd-31b0-8816-496c1e13165d@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 04:05:29PM +0300, Dmitry Baryshkov wrote:
> On 17/10/2022 17:53, Johan Hovold wrote:
> > Some QMP PHYs have a second fixed-divider pipe clock that needs to be
> > enabled along with the pipe clock.
> > 
> > Add support for an optional "pipediv2" clock.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 42 ++++++++++++++++++++----
> >   1 file changed, 36 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > index 9c8e009033f1..c1d74c06fad1 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > @@ -1379,7 +1379,9 @@ struct qmp_pcie {
> >   	void __iomem *rx2;
> >   
> >   	struct clk *pipe_clk;
> > +	struct clk *pipediv2_clk;
> >   	struct clk_bulk_data *clks;
> > +
> >   	struct reset_control_bulk_data *resets;
> >   	struct regulator_bulk_data *vregs;
> >   
> > @@ -1902,6 +1904,36 @@ static int qmp_pcie_exit(struct phy *phy)
> >   	return 0;
> >   }
> >   
> > +static int pipe_clk_enable(struct qmp_pcie *qmp)
> > +{
> > +	int ret;
> > +
> > +	ret = clk_prepare_enable(qmp->pipe_clk);
> > +	if (ret) {
> > +		dev_err(qmp->dev, "failed to enable pipe clock: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = clk_prepare_enable(qmp->pipediv2_clk);
> > +	if (ret) {
> > +		dev_err(qmp->dev, "failed to enable pipediv2 clock: %d\n", ret);
> > +		goto err_disable_pipe_clk;
> > +	}
> 
> Do they have to be enabled in sequence? If not, I'd use a bulk clocks 
> here for the pipe clocks. While it can look like an overkill, it would 
> be a safe net for the possible future changes, which might include 
> additional clocks.

I don't believe the bulk API is a good fit here as we need to support
both the new and old bindings, and for the latter the pipe_clk is looked
up by index rather than name (and that's from the child node too which
limits which APIs you can use further).

The code is clear enough as it stands, and I don't think we need to take
height for a hypothetical third pipe clock just yet.

Johan
