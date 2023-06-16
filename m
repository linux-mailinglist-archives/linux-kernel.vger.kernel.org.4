Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E60732A1A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343597AbjFPIn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343566AbjFPInU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:43:20 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A978030C3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:43:18 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so526637a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686904997; x=1689496997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ze8cwbEimRlhZaK9EBJVsnPzOeV3nshtg9J9yVTNzbA=;
        b=0CwPdM23oJvOKoQrf2K1oFtch1GUVvuQqMOPzi5DMDq0TjmyNC8LGVZg6WCwDXV1Vs
         NYGCTgf0wcd3f2jgapURz07b342frjb+t+j0LfpkA2rqE50GyGKVze91Wk4/mY6fDOlb
         m+dv9X2ENUCWaTbwtJXXtyFzVTs52sG0Kg0nRkdqeD+LTQSAVHemhVAtdGQScTED246S
         Hvz+wXORJe7+Lc/uj4YV8LoS9SKCFE4KGTnYl0nB9EwZfT2eDN/Q2dRaqk61HeHPcyW+
         Hv+78e1DOE69nDXeWq9ZwFkvZpI36XyvNpoodqGxYmoz2DND6kIBR9uSFjHPn2ZKj2iD
         T+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686904997; x=1689496997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze8cwbEimRlhZaK9EBJVsnPzOeV3nshtg9J9yVTNzbA=;
        b=AuNqenSlTbKRFc0XDtgPwk8I9llQxbB/Y+uRx4dOK+13LjJeuEO/11auZfleaKp/BM
         ilWY+FIn0LurHqLtro1AMhAGW7lLofAJERaDoCEDaWQNHXkeNZseX+ozNG01KHmxe6P0
         co6YtPYKUDgNSnQIvy7ymDkcREvnuSF9OPf23TSOMgvNtXPzK0uFHsU0r2nvhxRHcF0r
         ktQ107G7a4NYLd6qHQdadYqq/rMpcic/FWrutH3RIJ6AJ1rzq4SBe6pl4fZM3pcN5L9U
         KBflLodUE38KhnxO7GCCOci/OOuBpvDG/vYYTpDjmdXkmk62qxhxNhFEO86xf0zt72+x
         WUZg==
X-Gm-Message-State: AC+VfDzNYRH7/GUNFrhNYlTss27Rt/YNkunGl9DzmC7wg3zIlPc/X6O8
        tZl+Abd42WO2S1FiJV0PvxnECw==
X-Google-Smtp-Source: ACHHUZ7MWFdjFMx/4EedaJmP35jyhkR6ud9o/ugYs5MNHQ34vWYGN4HLEeom/PdQ5fLBLp+o2C6xZg==
X-Received: by 2002:aa7:d6d3:0:b0:518:79da:911e with SMTP id x19-20020aa7d6d3000000b0051879da911emr665898edr.39.1686904996944;
        Fri, 16 Jun 2023 01:43:16 -0700 (PDT)
Received: from blmsp ([2001:4090:a245:802c:7f03:2fe0:bd27:d746])
        by smtp.gmail.com with ESMTPSA id c13-20020aa7c74d000000b0051823c1a10bsm8004786eds.54.2023.06.16.01.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 01:43:16 -0700 (PDT)
Date:   Fri, 16 Jun 2023 10:43:14 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com,
        wenst@chromium.org, u.kleine-koenig@pengutronix.de,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 1/3] clk: mediatek: clk-mtk: Grab iomem pointer for
 divider clocks
Message-ID: <20230616084314.vfx5gcoxupcq3mgl@blmsp>
References: <20230615122051.546985-1-angelogioacchino.delregno@collabora.com>
 <20230615122051.546985-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230615122051.546985-2-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 02:20:49PM +0200, AngeloGioacchino Del Regno wrote:
> In the rare case in which one of the clock drivers has divider clocks
> but not composite clocks, mtk_clk_simple_probe() would not io(re)map,
> hence passing a NULL pointer to mtk_clk_register_dividers().
> 
> To fix this issue, extend the `if` conditional to also check if any
> divider clocks are present. While at it, also make sure the iomem
> pointer is NULL if no composite/divider clocks are declared, as we
> are checking for that when iounmapping it in the error path.
> 
> This hasn't been seen on any MediaTek clock driver as the current ones
> always declare composite clocks along with divider clocks, but this is
> still an important fix for a future potential KP.
> 
> Fixes: 1fe074b1f112 ("clk: mediatek: Add divider clocks to mtk_clk_simple_{probe,remove}()")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

> ---
>  drivers/clk/mediatek/clk-mtk.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index cf3514c8e97e..b00ef4213335 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -469,7 +469,7 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
>  	const struct platform_device_id *id;
>  	const struct mtk_clk_desc *mcd;
>  	struct clk_hw_onecell_data *clk_data;
> -	void __iomem *base;
> +	void __iomem *base = NULL;
>  	int num_clks, r;
>  
>  	mcd = device_get_match_data(&pdev->dev);
> @@ -483,8 +483,8 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
>  			return -EINVAL;
>  	}
>  
> -	/* Composite clocks needs us to pass iomem pointer */
> -	if (mcd->composite_clks) {
> +	/* Composite and divider clocks needs us to pass iomem pointer */
> +	if (mcd->composite_clks || mcd->divider_clks) {
>  		if (!mcd->shared_io)
>  			base = devm_platform_ioremap_resource(pdev, 0);
>  		else
> -- 
> 2.40.1
> 
