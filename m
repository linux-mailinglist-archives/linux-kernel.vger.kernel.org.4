Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BC366A17D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjAMSEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjAMSDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:03:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAF7892CA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:58:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18336B821AB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFFFC433F0;
        Fri, 13 Jan 2023 17:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673632696;
        bh=JuFDRpf2cgQra4Jmh7Rp/roiRRmIQ+8USu0y4bvm8KA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RkzR17B3MqmFD3UDolrzkWFgVQxhTgJ+4mIBUVVNY+/xkKk5diJ1opON8eqkEMhs8
         56NpBBuZXT0z1eov1BtFLHwQbVq7pZQDfLDmHe9msV4+HlUoBra7C35UT54dmiJ/gK
         I1PeMTqmdr8gQ4978vdbOXvc7PZ0whaLOhhHuMROJiFm/4AZiws4TVlDUiUf86aDGk
         x4fdw0aL6q3xuuyxREb6gubPmU5zMZzolXC/K6ft33MfIN971TxVhZMBbkY7ON5C82
         El2Tp/2Lhy6ANr8J4O8V6cctEBXUyKemnbT2XRdS7k4SEw6v+NDC9c+dmUfmCZslMQ
         o87sG7uo5PfJQ==
Date:   Fri, 13 Jan 2023 23:28:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-amarula@amarulasolutions.com
Subject: Re: [RFC PATCH 2/4] phy: rockchip: Add inno_is_valid_phy_mode
Message-ID: <Y8GbtA7+xHtBEpRs@matsya>
References: <20221002064540.2500257-1-michael@amarulasolutions.com>
 <20221002064540.2500257-3-michael@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221002064540.2500257-3-michael@amarulasolutions.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-10-22, 08:45, Michael Trimarchi wrote:
> The function is used to avoid to enable clock on the hardware
> if the mode requested is invalid
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  .../phy/rockchip/phy-rockchip-inno-dsidphy.c  | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c b/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
> index 630e01b5c19b..644cf73cfd53 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
> @@ -217,6 +217,20 @@ static void phy_update_bits(struct inno_dsidphy *inno,
>  	writel(tmp, inno->phy_base + reg);
>  }
>  
> +static int inno_is_valid_phy_mode(struct inno_dsidphy *inno)
> +{
> +	switch (inno->mode) {
> +	case PHY_MODE_MIPI_DPHY:
> +		break;
> +	case PHY_MODE_LVDS:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +};
> +
>  static unsigned long inno_dsidphy_pll_calc_rate(struct inno_dsidphy *inno,
>  						unsigned long rate)
>  {
> @@ -495,6 +509,11 @@ static void inno_dsidphy_lvds_mode_enable(struct inno_dsidphy *inno)
>  static int inno_dsidphy_power_on(struct phy *phy)
>  {
>  	struct inno_dsidphy *inno = phy_get_drvdata(phy);
> +	int ret = 0;

this initialization is superfluous

> +
> +	ret = inno_is_valid_phy_mode(inno);
> +	if (ret)
> +		return ret;
>  
>  	clk_prepare_enable(inno->pclk_phy);
>  	clk_prepare_enable(inno->ref_clk);
> -- 
> 2.34.1

-- 
~Vinod
