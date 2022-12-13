Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC6164B399
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbiLMKvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbiLMKvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:51:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9756C644C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:51:42 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1p52sh-0007xo-V7; Tue, 13 Dec 2022 11:51:27 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1p52se-0004jk-VU; Tue, 13 Dec 2022 11:51:24 +0100
Date:   Tue, 13 Dec 2022 11:51:24 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        18701859600@163.com, bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH V3 1/1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
Message-ID: <20221213105124.rivhfvxcazrgum24@pengutronix.de>
References: <20221213104426.3864788-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20221213104426.3864788-2-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213104426.3864788-2-Qing-wu.Li@leica-geosystems.com.cn>
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

On 22-12-13, LI Qingwu wrote:
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
> index 652ae58c2735..db03d632ea8d 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -522,6 +522,9 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
>  	hws[IMX8MP_CLK_A53_SRC] = hws[IMX8MP_CLK_A53_DIV];
>  	hws[IMX8MP_CLK_A53_CG] = hws[IMX8MP_CLK_A53_DIV];
>  	hws[IMX8MP_CLK_M7_CORE] = imx8m_clk_hw_composite_core("m7_core", imx8mp_m7_sels, ccm_base + 0x8080);
> +	hws[IMX8MP_CLK_M7_DIV] = hws[IMX8MP_CLK_M7_CORE];
> +	hws[IMX8MP_CLK_M7_SRC] = hws[IMX8MP_CLK_M7_CORE];
> +

Last nit, I wouldn't add a newline here. Apart from that

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

>  	hws[IMX8MP_CLK_ML_CORE] = imx8m_clk_hw_composite_core("ml_core", imx8mp_ml_sels, ccm_base + 0x8100);
>  	hws[IMX8MP_CLK_GPU3D_CORE] = imx8m_clk_hw_composite_core("gpu3d_core", imx8mp_gpu3d_core_sels, ccm_base + 0x8180);
>  	hws[IMX8MP_CLK_GPU3D_SHADER_CORE] = imx8m_clk_hw_composite("gpu3d_shader_core", imx8mp_gpu3d_shader_sels, ccm_base + 0x8200);
> -- 
> 2.25.1
> 
> 
> 
