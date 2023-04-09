Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEA76DC045
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 16:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjDIOKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 10:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjDIOJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 10:09:59 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAC0420F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 07:09:57 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id sb12so6918267ejc.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 07:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681049397; x=1683641397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Avfy1pMf9hFOgWQRWZgRhobPPoBecy5TH/QL70TE2dU=;
        b=QAE9Udul7Q0wQT+fUnsBwpbOAtKqsaZIzJhPHNlDABx6ztDTTHRNue0nVcl0d1hn5K
         v5c0jjDBuO3qcA3DRJD2MO2TjCrS/WUSl6YDo+HuryB0lL0j/ic7dgM8ZFiS1yb4bPR/
         lsuoKtQDKAy/HjUDMRI2BLirwwg4I5CPwtqwqE6Z3docO4xQx5pXAXDQbTYaY07IkPKw
         ohrruoec152CW1V/3WuspzoltOBO1d6bhUQ1GpSxMPEmKKFC5G6dQKr2/Gr5y+rWYsFK
         a4yTYCy51Q/EeHUg6Jy/xwdPkm4XPztgylTUDZ0jpZsjTHv8pHWpEu0OMxzHzdd2H/ae
         qdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681049397; x=1683641397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Avfy1pMf9hFOgWQRWZgRhobPPoBecy5TH/QL70TE2dU=;
        b=VUQKevouq/5jB2f3nZ1svVkVyxZv+6yPkflbeDLqQ6xpsyPXI3bcioLfAKTR/FiLxh
         EYuRP7iwhvbnWbRbiVxxs0NiWeQb8dWhfoCKhyOFom+uIGh789znsnK/Q52CFwngbpFl
         dENTqsTWk5WSk3m6LNndZ/yh+JYyRqGdaso2pz05S5E6tbaoz+ZynzH2uJEARjTvLEM5
         XjbZN0CgzWzHzOwgdQpA4YhONVWDjq/yF9hIYks06QtzUasSE9e6efMcEvDEk6/tehmK
         F40y3dBuoWpwF8ElE3x3yZ+X3WHaWUYGNi3NgBZzFUiTUt1NSLd8sx2xC0/Ispopd+46
         VaXw==
X-Gm-Message-State: AAQBX9e35lVq2dvThI+9OBe9qKWkpGfIPW1KixwF5+iN8BaVl/QoMaie
        hUwkh8QCLm4HxnF69oMajIY5LA==
X-Google-Smtp-Source: AKy350aRNl0LY6k3p6OVuPNcp4M0V6Gj7CCvE3iV71I7LgNQvGEjI2CDNw+zZwWaHg/C/YZqjRHUkQ==
X-Received: by 2002:a17:907:a44:b0:947:d3d0:ae1c with SMTP id be4-20020a1709070a4400b00947d3d0ae1cmr6260926ejc.0.1681049396848;
        Sun, 09 Apr 2023 07:09:56 -0700 (PDT)
Received: from linaro.org ([188.25.26.161])
        by smtp.gmail.com with ESMTPSA id o12-20020a1709064f8c00b0093f322187f0sm4138023eju.189.2023.04.09.07.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 07:09:56 -0700 (PDT)
Date:   Sun, 9 Apr 2023 17:09:54 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 3/5] clk: imx: imx8ulp: keep MU0_B clock enabled always
Message-ID: <ZDLHMgq3fPKIeSna@linaro.org>
References: <20230331063814.2462059-1-peng.fan@oss.nxp.com>
 <20230331063814.2462059-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331063814.2462059-4-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-31 14:38:12, Peng Fan (OSS) wrote:
> From: Jacky Bai <ping.bai@nxp.com>
> 
> Keep the A35<->M33 MU0_B clock enabled always for low power
> communication.
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

>  drivers/clk/imx/clk-imx8ulp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8ulp.c b/drivers/clk/imx/clk-imx8ulp.c
> index 3cf4b094dfff..0dd48e8159ee 100644
> --- a/drivers/clk/imx/clk-imx8ulp.c
> +++ b/drivers/clk/imx/clk-imx8ulp.c
> @@ -376,7 +376,7 @@ static int imx8ulp_clk_pcc3_init(struct platform_device *pdev)
>  	clks[IMX8ULP_CLK_DMA1_CH29] = imx_clk_hw_gate("pcc_dma1_ch29", "xbar_ad_divplat", base + 0x7c, 30);
>  	clks[IMX8ULP_CLK_DMA1_CH30] = imx_clk_hw_gate("pcc_dma1_ch30", "xbar_ad_divplat", base + 0x80, 30);
>  	clks[IMX8ULP_CLK_DMA1_CH31] = imx_clk_hw_gate("pcc_dma1_ch31", "xbar_ad_divplat", base + 0x84, 30);
> -	clks[IMX8ULP_CLK_MU0_B] = imx_clk_hw_gate("mu0_b", "xbar_ad_divplat", base + 0x88, 30);
> +	clks[IMX8ULP_CLK_MU0_B] = imx_clk_hw_gate_flags("mu0_b", "xbar_ad_divplat", base + 0x88, 30, CLK_IS_CRITICAL);
>  	clks[IMX8ULP_CLK_MU3_A] = imx_clk_hw_gate("mu3_a", "xbar_ad_divplat", base + 0x8c, 30);
>  
>  	imx_check_clk_hws(clks, clk_data->num);
> -- 
> 2.37.1
> 
