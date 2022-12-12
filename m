Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21F4649D34
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiLLLJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiLLLIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:08:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDE7120BF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:58:37 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1p4gVt-0003Vq-8i; Mon, 12 Dec 2022 11:58:25 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1p4gVq-0001pq-CI; Mon, 12 Dec 2022 11:58:22 +0100
Date:   Mon, 12 Dec 2022 11:58:22 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        18701859600@163.com, bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH V2 1/1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
Message-ID: <20221212105822.z6s6ofhy5lgagncr@pengutronix.de>
References: <20221212094533.2803867-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20221212094533.2803867-2-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212094533.2803867-2-Qing-wu.Li@leica-geosystems.com.cn>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

On 22-12-12, LI Qingwu wrote:
> Defined IMX8MP_CLK_M7_SRC and IMX8MP_CLK_M7_DIV in imx8mp-clock.h
> but never assigned. It will cause the system to hang if using them.
> Alias IMX8MP_CLK_M7_SRC and IMX8MP_CLK_M7_DIV to IMX8MP_CLK_M7_CORE
> for backward compatibility.
> 
> Fixes: 8c83a8ff4dd9 (clk: imx8mp: use imx8m_clk_hw_composite_core to simplify code)
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/clk/imx/clk-imx8mp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 652ae58c2735..bae5ecc81bdc 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -531,6 +531,9 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
>  	hws[IMX8MP_CLK_HSIO_AXI] = imx8m_clk_hw_composite("hsio_axi", imx8mp_hsio_axi_sels, ccm_base + 0x8380);
>  	hws[IMX8MP_CLK_MEDIA_ISP] = imx8m_clk_hw_composite("media_isp", imx8mp_media_isp_sels, ccm_base + 0x8400);
>  
> +	hws[IMX8MP_CLK_M7_SRC] = hws[IMX8MP_CLK_M7_CORE];
> +	hws[IMX8MP_CLK_M7_DIV] = hws[IMX8MP_CLK_M7_CORE];

Nit:

Can you please move them below the assignment of the IMX8MP_CLK_M7_CORE,
so the M7 clocks are bundled at one place.

Regards,
  Marco

> +
>  	/* CORE SEL */
>  	hws[IMX8MP_CLK_A53_CORE] = imx_clk_hw_mux2("arm_a53_core", ccm_base + 0x9880, 24, 1, imx8mp_a53_core_sels, ARRAY_SIZE(imx8mp_a53_core_sels));
>  
> -- 
> 2.25.1
> 
> 
> 
