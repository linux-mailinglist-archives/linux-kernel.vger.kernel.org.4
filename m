Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CE570A8E6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 17:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjETPnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 11:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjETPnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 11:43:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DB9BF;
        Sat, 20 May 2023 08:43:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63F8460AFF;
        Sat, 20 May 2023 15:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CC6C433D2;
        Sat, 20 May 2023 15:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684597383;
        bh=GeAKXnIDBsXzPVPz3tfWUSNstZz8hpDizUa4H2Jqd2k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tuzRLTITYkbs6ZCiLmxvuUJ2Yyc1FESTeNP7Tzh2BSd9ZNQR2YeNJa/r7uHfL87F0
         c7F0teZ/EqL+GZPviPb3WbJoo5KqNrFAE06jKrRTD+0XCWgHk/CM7zXIzYekfLyXE4
         PyJ9vOgkIB9nt9nuCQXxq91odixUMkZsQCPT0dzV/A5IWvpK3IWsDBX1GdXgXZbVsW
         o76IshvY1JpMZBYr4THgML2dZiZyh4hzcl0FG8gwixGAOvm9t+Yxxc5vwQqozi6XBS
         p9YWG4DdpvQO8YzpF8N861/2hK0bRZJLQCd8LyNzbgF/vXHQGDPps7H9jINgfQSjhY
         Qljpw5wGE9nWA==
Date:   Sat, 20 May 2023 16:59:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     lars@metafoo.de, heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sebastian.reichel@collabora.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com
Subject: Re: [PATCH 2/7] iio: adc: rockchip_saradc: Make use of
 devm_clk_get_enabled
Message-ID: <20230520165912.420c7cf3@jic23-huawei>
In-Reply-To: <20230516230051.14846-3-shreeya.patel@collabora.com>
References: <20230516230051.14846-1-shreeya.patel@collabora.com>
        <20230516230051.14846-3-shreeya.patel@collabora.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 04:30:46 +0530
Shreeya Patel <shreeya.patel@collabora.com> wrote:

> Use devm_clk_get_enabled() to avoid manually disabling the
> clock.

Please comment on why the enable is now done earlier than before.

> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
>  drivers/iio/adc/rockchip_saradc.c | 77 +++++--------------------------
>  1 file changed, 11 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index ac6fdf8e673b..05b66eff9a44 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -339,20 +339,6 @@ static void rockchip_saradc_reset_controller(struct reset_control *reset)
>  	reset_control_deassert(reset);
>  }
>  
> -static void rockchip_saradc_clk_disable(void *data)
> -{
> -	struct rockchip_saradc *info = data;
> -
> -	clk_disable_unprepare(info->clk);
> -}
> -
> -static void rockchip_saradc_pclk_disable(void *data)
> -{
> -	struct rockchip_saradc *info = data;
> -
> -	clk_disable_unprepare(info->pclk);
> -}
> -
>  static void rockchip_saradc_regulator_disable(void *data)
>  {
>  	struct rockchip_saradc *info = data;
> @@ -486,16 +472,6 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	info->pclk = devm_clk_get(&pdev->dev, "apb_pclk");
> -	if (IS_ERR(info->pclk))
> -		return dev_err_probe(&pdev->dev, PTR_ERR(info->pclk),
> -				     "failed to get pclk\n");
> -
> -	info->clk = devm_clk_get(&pdev->dev, "saradc");
> -	if (IS_ERR(info->clk))
> -		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
> -				     "failed to get adc clock\n");
> -
>  	info->vref = devm_regulator_get(&pdev->dev, "vref");
>  	if (IS_ERR(info->vref))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(info->vref),
> @@ -504,6 +480,16 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  	if (info->reset)
>  		rockchip_saradc_reset_controller(info->reset);
>  
> +	info->pclk = devm_clk_get_enabled(&pdev->dev, "apb_pclk");
> +	if (IS_ERR(info->pclk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(info->pclk),
> +				     "failed to get pclk\n");
> +
> +	info->clk = devm_clk_get_enabled(&pdev->dev, "saradc");
> +	if (IS_ERR(info->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
> +				     "failed to get adc clock\n");
> +
>  	/*
>  	 * Use a default value for the converter clock.
>  	 * This may become user-configurable in the future.
> @@ -533,32 +519,6 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  
>  	info->uv_vref = ret;
>  
> -	ret = clk_prepare_enable(info->pclk);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to enable pclk\n");
> -		return ret;
> -	}
> -	ret = devm_add_action_or_reset(&pdev->dev,
> -				       rockchip_saradc_pclk_disable, info);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to register devm action, %d\n",
> -			ret);
> -		return ret;
> -	}
> -
> -	ret = clk_prepare_enable(info->clk);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to enable converter clock\n");
> -		return ret;
> -	}
> -	ret = devm_add_action_or_reset(&pdev->dev,
> -				       rockchip_saradc_clk_disable, info);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to register devm action, %d\n",
> -			ret);
> -		return ret;
> -	}
> -
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	indio_dev->name = dev_name(&pdev->dev);
> @@ -594,8 +554,6 @@ static int rockchip_saradc_suspend(struct device *dev)
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct rockchip_saradc *info = iio_priv(indio_dev);
>  
> -	clk_disable_unprepare(info->clk);
> -	clk_disable_unprepare(info->pclk);
>  	regulator_disable(info->vref);
>  
>  	return 0;
> @@ -605,21 +563,8 @@ static int rockchip_saradc_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct rockchip_saradc *info = iio_priv(indio_dev);
> -	int ret;
> -
> -	ret = regulator_enable(info->vref);
> -	if (ret)
> -		return ret;
> -
> -	ret = clk_prepare_enable(info->pclk);
> -	if (ret)
> -		return ret;
> -
> -	ret = clk_prepare_enable(info->clk);
> -	if (ret)
> -		clk_disable_unprepare(info->pclk);
>  
> -	return ret;
> +	return regulator_enable(info->vref);
>  }
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(rockchip_saradc_pm_ops,

