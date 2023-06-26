Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E07073DB80
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjFZJhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjFZJhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:37:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D209FC7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 02:37:03 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qDieT-0003on-U0; Mon, 26 Jun 2023 11:36:53 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qDieS-0003FA-RV; Mon, 26 Jun 2023 11:36:52 +0200
Date:   Mon, 26 Jun 2023 11:36:52 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Alibek Omarov <a1ba.omarov@gmail.com>
Cc:     linux-rockchip@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: rockchip: rk3568: Fix PLL rate setting for 78.75MHz
Message-ID: <20230626093652.GR18491@pengutronix.de>
References: <20230614134750.1056293-1-a1ba.omarov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614134750.1056293-1-a1ba.omarov@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 04:47:50PM +0300, Alibek Omarov wrote:
> PLL rate on RK356x is calculated through the simple formula:
> ((24000000 / _refdiv) * _fbdiv) / (_postdiv1 * _postdiv2)
> 
> The PLL rate setting for 78.75MHz seems to be copied from 96MHz
> so this patch fixes it and configures it properly.
> 
> Signed-off-by: Alibek Omarov <a1ba.omarov@gmail.com>
> Fixes: 842f4cb72639 ("clk: rockchip: Add more PLL rates for rk3568")

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  drivers/clk/rockchip/clk-rk3568.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3568.c b/drivers/clk/rockchip/clk-rk3568.c
> index 5dae960af4ce..48b8d06c305c 100644
> --- a/drivers/clk/rockchip/clk-rk3568.c
> +++ b/drivers/clk/rockchip/clk-rk3568.c
> @@ -82,7 +82,7 @@ static struct rockchip_pll_rate_table rk3568_pll_rates[] = {
>  	RK3036_PLL_RATE(101000000, 1, 101, 6, 4, 1, 0),
>  	RK3036_PLL_RATE(100000000, 1, 150, 6, 6, 1, 0),
>  	RK3036_PLL_RATE(96000000, 1, 96, 6, 4, 1, 0),
> -	RK3036_PLL_RATE(78750000, 1, 96, 6, 4, 1, 0),
> +	RK3036_PLL_RATE(78750000, 4, 315, 6, 4, 1, 0),

refdiv = 4
fbdiv = 315
postdiv1 = 6
postdiv2 = 4

((24000000 / 4) * 315) / 6 / 4 = 78750000

LGTM

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
