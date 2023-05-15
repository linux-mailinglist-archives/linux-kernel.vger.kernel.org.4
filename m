Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5BC70220D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjEODQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjEODQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:16:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892ED10F8;
        Sun, 14 May 2023 20:16:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A292F61407;
        Mon, 15 May 2023 03:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4AEC433D2;
        Mon, 15 May 2023 03:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684120573;
        bh=AdGBDMKxollXaXewEE0kxL5foqSxU+diTb/RUS93bnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cMqtoLwth2Lr932+ZBb2fkBUF4j8v04E6oXQrzyQYiGg3A5/jxnRixfQyv5Ic/3ii
         HoitDIxLlxqyX1kY4MslA0aDiTFB1o3iXvo9bchAUGSlYLP8LX+YJjYwRn9BOagRUx
         ZnMpTwxbgWut0OhTeDrms3zz+N7vmGiwTPFbSFrK4jQ8Q70zaks4uSd1Di/OfBV4jB
         x8BTNZlczcl0XKmRmy0vqvoamSsnO8GSP5metddO1cCuPjOKDV6yjPSu8DaJy5uOAe
         AwumY9WqSh56w9ba2/wsH2+j1vsLbpu/jWKyajxqKGqBuSjDrS1MXYd4NZ2WN3LB77
         4sAuu5q5MV2Gg==
Date:   Mon, 15 May 2023 11:16:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, marex@denx.de,
        aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp: Fix video clock parents
Message-ID: <20230515031601.GD767028@dragon>
References: <20230512010423.1227793-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512010423.1227793-1-aford173@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 08:04:23PM -0500, Adam Ford wrote:
> There are a few clocks whose parents are set in mipi_dsi
> and lcdif nodes, but these clocks are used by the media_blk_ctrl
> power domain.  This may cause an issue when re-parenting, because
> the media_blk_ctrl may start the clocks before the reparent is
> done resulting in a disp_pixel clock having the wrong parent and
> rate.
> 
> Fix this by moving the assigned-clock-parents and rates to the
> media_blk_ctrl node to configure these clocks before they are enabled.
> 
> After this patch, both disp1_pix_root and dixp2_pix_root clock
> become children of the video_pll1.
> 
> video_pll1_ref_sel           24000000
>   video_pll1               1039500000
>     video_pll1_bypass        1039500000
>       video_pll1_out           1039500000
>         media_disp2_pix          1039500000
>           media_disp2_pix_root_clk   1039500000
>         media_disp1_pix          1039500000
>           media_disp1_pix_root_clk   1039500000
> 
> Fixes: eda09fe149df ("arm64: dts: imx8mp: Add display pipeline components")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks!
