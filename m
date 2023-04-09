Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3C86DC00C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 15:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjDINfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 09:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjDINfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 09:35:18 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFA535A3
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 06:35:17 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5047074939fso9656174a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 06:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681047316; x=1683639316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqAMC8ryCJbyjlZKXR0UCshyOaNbeRpsq5E7VX8LzM8=;
        b=RGtfVRh7HchKtccnf3RAEYVRQZNWk6sX+B8i5dTgOSACwSnLDisayZKHDXHCw5p3m5
         BRVJ16SWhDvpF/PYSZqvjxIOzMDDXYz4oAt4ckNiCDUkxA6R2wo00pRV0ZGNTANSZGPf
         e+AtPvtZ6y3zgLdq5jNGjS9aPFnhSO6VmGLglk4oITFpgHUSJu3FVtYTTOpF5iPDChna
         1u5wTjmC8EWk/Ga4glRtpmvEr0JG+R3PW5cYZkWtyMxh3DUsD00Q80OZkkY9w/Z3IHDm
         sivx+wD7RME0tfJZMG3MPAP/VlTCGMmu0kSFtvk5ZxwTg9a8ExDDRad2pwArcRTTc6yU
         yIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681047316; x=1683639316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqAMC8ryCJbyjlZKXR0UCshyOaNbeRpsq5E7VX8LzM8=;
        b=wzB6QJBwrPl7vk3yetJeWMFgP2dBwu0G6/br9U9yDd9zLgh2XP75RCddt/3wxnkyMk
         Ymuq59C/CL782QYA45EoJXyhFaiK8GyoDh8bc0B4VmhPm1/FVUW+NGttO9x2bnMasaQY
         37dYUqwfqW+AJkV+JTA37d1TAGblVW8mD/g45BjLPrNRB9/+pXC7XVya2eABEg4tRyB6
         HBhTPrleJBspCbc+Tcf3YaJ+NfCKpHAYlr6CtUwjHPKPz5f4BzpJ4z5hKiiuy4RD+x/U
         ba8WeqPgEZJg24nlfem5mauQHsf51xAezBzEEkdllgLfN4XEiOu1DQ9AvotlecuFuBpM
         gkyg==
X-Gm-Message-State: AAQBX9cme1Po5DUd7P1wIwcbXo+fymkaOnNloY8e7QeO7YSUIw9uEYh5
        MqQUes3kQAmOTxZIFSInuXSZ5w==
X-Google-Smtp-Source: AKy350b4e2e79p5RWSc0VkOqMhbXzlRhajSb/xMyYMC0sJxrEWB7WxAdnZsuUR+ZGUb+UZFXSVursg==
X-Received: by 2002:a05:6402:35d2:b0:4fd:21a6:832d with SMTP id z18-20020a05640235d200b004fd21a6832dmr13603639edc.11.1681047315976;
        Sun, 09 Apr 2023 06:35:15 -0700 (PDT)
Received: from linaro.org ([188.25.26.161])
        by smtp.gmail.com with ESMTPSA id z95-20020a509e68000000b004c09527d62dsm3939377ede.30.2023.04.09.06.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 06:35:15 -0700 (PDT)
Date:   Sun, 9 Apr 2023 16:35:14 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 1/4] clk: imx: imx8mp: correct DISP2 pixel clock type
Message-ID: <ZDK/EvHW038GHTJk@linaro.org>
References: <20230403094633.3366446-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403094633.3366446-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-04-03 17:46:30, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The MEDIA_DISP2_CLK_ROOT use ccm_ahb_channel, it is bus type.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
> 
> V1-V3:
> None
> 
>  drivers/clk/imx/clk-imx8mp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 3253589851ff..4a0f1b739fd4 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -554,7 +554,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
>  	hws[IMX8MP_CLK_AHB] = imx8m_clk_hw_composite_bus_critical("ahb_root", imx8mp_ahb_sels, ccm_base + 0x9000);
>  	hws[IMX8MP_CLK_AUDIO_AHB] = imx8m_clk_hw_composite_bus("audio_ahb", imx8mp_audio_ahb_sels, ccm_base + 0x9100);
>  	hws[IMX8MP_CLK_MIPI_DSI_ESC_RX] = imx8m_clk_hw_composite_bus("mipi_dsi_esc_rx", imx8mp_mipi_dsi_esc_rx_sels, ccm_base + 0x9200);
> -	hws[IMX8MP_CLK_MEDIA_DISP2_PIX] = imx8m_clk_hw_composite("media_disp2_pix", imx8mp_media_disp_pix_sels, ccm_base + 0x9300);
> +	hws[IMX8MP_CLK_MEDIA_DISP2_PIX] = imx8m_clk_hw_composite_bus("media_disp2_pix", imx8mp_media_disp_pix_sels, ccm_base + 0x9300);
>  
>  	hws[IMX8MP_CLK_IPG_ROOT] = imx_clk_hw_divider2("ipg_root", "ahb_root", ccm_base + 0x9080, 0, 1);
>  
> -- 
> 2.37.1
> 
