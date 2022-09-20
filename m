Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729B85BDD7D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiITGlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiITGl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:41:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132A4252B0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:41:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE8EAB8250D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13CCC433C1;
        Tue, 20 Sep 2022 06:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663656079;
        bh=M/2X2FJl5x6KzoR4h2cSB4i+w/FfJXJx4Ka3Wc3iBGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PDxizsxa76iZ4tN91KivZ3lM1tRlvsto7l/YipkKLiY22/dbYeykwHJSg1del8nfb
         OCPG2VgRv0hVdiWU5bhXJ4EoCsxJcwAfA18svRYM/7MabMBItmDAPppZMjSeoMesRf
         o3VHjXbAt/Ittn1TspejsGzRz7yyzu5dyhxRl3acqocpbWBvJv/dsdUR8BZUuGnba0
         JTVqN6ifxq5q9NR2RQnxpLt3sHu9m2XQtLQYkaLDEbgdFnl/eQIfLtqU7VGjIdwXtO
         rDesTT4AFozN53aOLSGKoTHPRdruYv0j5VPoLgAwao5rrjs6C3NsnbPT25Kp3mScNk
         zm4OKXtIa5kig==
Date:   Tue, 20 Sep 2022 12:11:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Piyush Mehta <piyush.mehta@amd.com>
Cc:     laurent.pinchart@ideasonboard.com, kishon@ti.com,
        michal.simek@xilinx.com, michal.simek@amd.com,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, git@amd.com,
        siva.durga.prasad.paladugu@amd.com
Subject: Re: [PATCH] phy: xilinx: phy-zynqmp: dynamic clock support for
 power-save
Message-ID: <Yylgi+E2BAStgkEx@matsya>
References: <20220909130442.1337970-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909130442.1337970-1-piyush.mehta@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-09-22, 18:34, Piyush Mehta wrote:
> Enabling clock for all the lanes, consuming power even PHY is active or
> not.

Pls consider revision to:
Enabling clock for all the lanes consumes power even PHY is active or
idle..

> 
> To resolve the above issue and power saving,made clock enabled/disabled
> based on active PHYs on call of phy_init/phy_exit.

To resolve this, enable/disable clocks in phy_init/phy_exit

> By default clock is disabled for all the lanes. Whenever phy_init called
> from USB, SATA, SGMII, or display driver, it enabled the required clock
> for requested lane. On phy_exit cycle, it disabled clock for the active
> PHYs.
> 
> During the suspend/resume cycle, each USB/ SATA/ SGMII/ display driver
> called phy_exit/phy_init individually. it disabled clock on exit, and
> enabled on initialization for the active PHYs.
> 
> Active PHY configuration depends on the peripheral DT node status,
> like USB DT node status 'okay' then driver enabled clock for the USB
> configured lane.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> ---
>  drivers/phy/xilinx/phy-zynqmp.c | 59 ++++++++-------------------------
>  1 file changed, 14 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
> index 9be9535ad7ab..912c4defdf8d 100644
> --- a/drivers/phy/xilinx/phy-zynqmp.c
> +++ b/drivers/phy/xilinx/phy-zynqmp.c
> @@ -572,6 +572,10 @@ static int xpsgtr_phy_init(struct phy *phy)
>  
>  	mutex_lock(&gtr_dev->gtr_mutex);
>  
> +	/* Configure and enable the clock when peripheral phy_init call */

when peripheral invokes phy_init

> +	if (clk_prepare_enable(gtr_dev->clk[gtr_phy->lane]))
> +		goto out;
> +
>  	/* Skip initialization if not required. */
>  	if (!xpsgtr_phy_init_required(gtr_phy))
>  		goto out;
> @@ -616,9 +620,13 @@ static int xpsgtr_phy_init(struct phy *phy)
>  static int xpsgtr_phy_exit(struct phy *phy)
>  {
>  	struct xpsgtr_phy *gtr_phy = phy_get_drvdata(phy);
> +	struct xpsgtr_dev *gtr_dev = gtr_phy->dev;
>  
>  	gtr_phy->skip_phy_init = false;
>  
> +	/* Ensure that disable clock only, which configure for lane */
> +	clk_disable_unprepare(gtr_dev->clk[gtr_phy->lane]);
> +
>  	return 0;
>  }
>  
> @@ -824,15 +832,11 @@ static struct phy *xpsgtr_xlate(struct device *dev,
>  static int __maybe_unused xpsgtr_suspend(struct device *dev)
>  {
>  	struct xpsgtr_dev *gtr_dev = dev_get_drvdata(dev);
> -	unsigned int i;
>  
>  	/* Save the snapshot ICM_CFG registers. */
>  	gtr_dev->saved_icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
>  	gtr_dev->saved_icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
>  
> -	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
> -		clk_disable_unprepare(gtr_dev->clk[i]);
> -
>  	return 0;
>  }
>  
> @@ -842,13 +846,6 @@ static int __maybe_unused xpsgtr_resume(struct device *dev)
>  	unsigned int icm_cfg0, icm_cfg1;
>  	unsigned int i;
>  	bool skip_phy_init;
> -	int err;
> -
> -	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++) {
> -		err = clk_prepare_enable(gtr_dev->clk[i]);
> -		if (err)
> -			goto err_clk_put;
> -	}

hold on, why is this being removed from suspend/resume?

>  
>  	icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
>  	icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
> @@ -869,12 +866,6 @@ static int __maybe_unused xpsgtr_resume(struct device *dev)
>  		gtr_dev->phys[i].skip_phy_init = skip_phy_init;
>  
>  	return 0;
> -
> -err_clk_put:
> -	while (i--)
> -		clk_disable_unprepare(gtr_dev->clk[i]);
> -
> -	return err;
>  }
>  
>  static const struct dev_pm_ops xpsgtr_pm_ops = {
> @@ -888,7 +879,6 @@ static const struct dev_pm_ops xpsgtr_pm_ops = {
>  static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
>  {
>  	unsigned int refclk;
> -	int ret;
>  
>  	for (refclk = 0; refclk < ARRAY_SIZE(gtr_dev->refclk_sscs); ++refclk) {
>  		unsigned long rate;
> @@ -899,19 +889,14 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
>  		snprintf(name, sizeof(name), "ref%u", refclk);
>  		clk = devm_clk_get_optional(gtr_dev->dev, name);
>  		if (IS_ERR(clk)) {
> -			ret = dev_err_probe(gtr_dev->dev, PTR_ERR(clk),
> -					    "Failed to get reference clock %u\n",
> -					    refclk);
> -			goto err_clk_put;
> +			return dev_err_probe(gtr_dev->dev, PTR_ERR(clk),
> +					     "Failed to get ref clock %u\n",
> +					     refclk);
>  		}
>  
>  		if (!clk)
>  			continue;
>  
> -		ret = clk_prepare_enable(clk);
> -		if (ret)
> -			goto err_clk_put;
> -
>  		gtr_dev->clk[refclk] = clk;
>  
>  		/*
> @@ -931,18 +916,11 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
>  			dev_err(gtr_dev->dev,
>  				"Invalid rate %lu for reference clock %u\n",
>  				rate, refclk);
> -			ret = -EINVAL;
> -			goto err_clk_put;
> +			return -EINVAL;
>  		}
>  	}
>  
>  	return 0;
> -
> -err_clk_put:
> -	while (refclk--)
> -		clk_disable_unprepare(gtr_dev->clk[refclk]);
> -
> -	return ret;
>  }
>  
>  static int xpsgtr_probe(struct platform_device *pdev)
> @@ -951,7 +929,6 @@ static int xpsgtr_probe(struct platform_device *pdev)
>  	struct xpsgtr_dev *gtr_dev;
>  	struct phy_provider *provider;
>  	unsigned int port;
> -	unsigned int i;
>  	int ret;
>  
>  	gtr_dev = devm_kzalloc(&pdev->dev, sizeof(*gtr_dev), GFP_KERNEL);
> @@ -991,8 +968,7 @@ static int xpsgtr_probe(struct platform_device *pdev)
>  		phy = devm_phy_create(&pdev->dev, np, &xpsgtr_phyops);
>  		if (IS_ERR(phy)) {
>  			dev_err(&pdev->dev, "failed to create PHY\n");
> -			ret = PTR_ERR(phy);
> -			goto err_clk_put;
> +			return PTR_ERR(phy);
>  		}
>  
>  		gtr_phy->phy = phy;
> @@ -1003,16 +979,9 @@ static int xpsgtr_probe(struct platform_device *pdev)
>  	provider = devm_of_phy_provider_register(&pdev->dev, xpsgtr_xlate);
>  	if (IS_ERR(provider)) {
>  		dev_err(&pdev->dev, "registering provider failed\n");
> -		ret = PTR_ERR(provider);
> -		goto err_clk_put;
> +		return PTR_ERR(provider);
>  	}
>  	return 0;
> -
> -err_clk_put:
> -	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
> -		clk_disable_unprepare(gtr_dev->clk[i]);
> -
> -	return ret;
>  }
>  
>  static const struct of_device_id xpsgtr_of_match[] = {
> -- 
> 2.25.1

-- 
~Vinod
