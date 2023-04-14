Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C456B6E2761
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDNPtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjDNPtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:49:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6647B772
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16E8F62212
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 15:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7CCC433EF;
        Fri, 14 Apr 2023 15:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681487364;
        bh=5DqrhCTzuzTjvwCGlt19FA3g4stRfeUyytfgLiO4ps8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D+M4c8lZ8CKUyLB4075G4N7ODWaHSg88hJWbhdpIVYS8u7hwMnq7mfLEE+BniHyD6
         asCaVPm64ZeLyeyNT+N0Y6+uXFBgz8E7bJygkylSKH+9QA5IJT9yttrVxK6jqwCZfv
         mcev16XlcOWWVwZqZa3svHdx6UeQN9splmLRfZ6PUJB4OMfgKLqihc7YlLo9sHiy4Q
         ENYiYmQlt6YadBkHXG74JdINOamfMUJaUkXICj/tm4hnGviEnjxRcTG8fREkzOHriy
         Ove74Hq/km8t/N+sARfWLfYXXZsnOPXx4Kgf6P5LpHKBJ0i71O0haS/6m03hvzia75
         FkmDD8tCgTO1g==
Date:   Fri, 14 Apr 2023 08:49:21 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        chunfeng.yun@mediatek.com, vkoul@kernel.org, kishon@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        ndesaulniers@google.com, granquet@baylibre.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] phy: mediatek: fix returning garbage
Message-ID: <20230414154921.GB1931632@dev-arch.thelio-3990X>
References: <20230414122253.3171524-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414122253.3171524-1-trix@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 08:22:53AM -0400, Tom Rix wrote:
> clang reports
> drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:298:6: error: variable
>   'ret' is uninitialized when used here [-Werror,-Wuninitialized]
>         if (ret)
>             ^~~
> ret should have been set by the preceding call to mtk_hdmi_pll_set_hw.
> 
> Fixes: 45810d486bb4 ("phy: mediatek: add support for phy-mtk-hdmi-mt8195")
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Angelo brought up a good point on another patch to fix this issue that
we should probably be returning ret instead of unconditionally returning
-EINVAL but it sounds like it does not really matter at the moment since
mtk_hdmi_pll_set_hw() can only return -EINVAL or 0.

https://lore.kernel.org/ada769e0-0141-634f-3753-eb3a50f0eee3@collabora.com/

> ---
>  drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> index abfc077fb0a8..c63294e451d6 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> @@ -292,9 +292,9 @@ static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdmi_phy, struct clk_hw *hw,
>  	if (!(digital_div <= 32 && digital_div >= 1))
>  		return -EINVAL;
>  
> -	mtk_hdmi_pll_set_hw(hw, PLL_PREDIV, fbkdiv_high, fbkdiv_low,
> -			    PLL_FBKDIV_HS3, posdiv1, posdiv2, txprediv,
> -			    txposdiv, digital_div);
> +	ret = mtk_hdmi_pll_set_hw(hw, PLL_PREDIV, fbkdiv_high, fbkdiv_low,
> +				  PLL_FBKDIV_HS3, posdiv1, posdiv2, txprediv,
> +				  txposdiv, digital_div);
>  	if (ret)
>  		return -EINVAL;
>  
> -- 
> 2.27.0
> 
