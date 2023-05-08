Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417BB6FA2A0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjEHIxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjEHIxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:53:47 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67DE4234
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 01:53:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f41d087b3bso17084245e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 01:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683536023; x=1686128023;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O3KqObjAsilK7W2Rhm2TS8fPos79XK4Q4L9RasYouWE=;
        b=S4Bi5JRenXCjM29jmjyQWtCVZlgluw5yYsM9zqN8eASFqqaw/Dm2+ciVsGNuXE98un
         gZDET1wJR8IHwp1ZUIk6hfNZpPorAHqzFfBEJ6ihLYqmm8L8Q5aR5mbwwk5xAaTfK0BQ
         Y14q8+1FfrvZYeCb6dWEBf40WiREVcyb+N82/woJftlnbUFfZ+wCd9Asml3b6aqNN6YB
         KX2Gl/J8kR232eQzb7qdcevT/gm0+iPWGLWXv+KubnsFcGwkhebvnfSLbic5/S2iX9Ze
         V3E8bEtoyFK8ONJc2aTlSYoMoXf5UsgkLMCOGPAKCJQt6N7v0diXKTbiBIt934Yvg+vU
         kl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683536023; x=1686128023;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O3KqObjAsilK7W2Rhm2TS8fPos79XK4Q4L9RasYouWE=;
        b=EC/w2lzU9WVIh+iXGUrcxNo5SZ1VJL55Jpik8E30vAY31SvBlsa1N5dEzDydR5SAkH
         j2V0R3T3zW3P1x9leoZHNEm146D3FHDylUTRhSzBDmjSAq75c/gxsv98vW1jy1K+cgPV
         95QUKBF1dHnoQJEaZo/lU+n/M1P4EQBeNhAmGyeiFI8IxL68eQFoVpUBwJc3dowCp1oY
         b0uRHZFt5a6E54pkz7YPNC33ZvW7rmegdjwV0qgEbXNtYWcYyHs1zeylZpnYtjAZkcJ+
         HVWe7SxAHNN+xaPMLT4FAR/uvhsqt2WunCuAsjQPW/pPe3iBgHSJ7gDlHuqotdYDpRaY
         zgHg==
X-Gm-Message-State: AC+VfDynp40ASc87AjdDf6ElQAVU3VJUkLSCo9tj9BS8iwl9Hav44fde
        sDgx3l3Vyz8yLM0Vea3N/uJOyQ==
X-Google-Smtp-Source: ACHHUZ7aELAO5PERzM1eNeiR96sxaVm00o+2NMJmSigXprBBwEI4jBlUxzi2QX5vWAxcA4WV1/C5CQ==
X-Received: by 2002:a7b:cc05:0:b0:3f1:7581:eaaf with SMTP id f5-20020a7bcc05000000b003f17581eaafmr6525943wmh.4.1683536023283;
        Mon, 08 May 2023 01:53:43 -0700 (PDT)
Received: from blmsp ([2001:4090:a246:80f3:ef71:25ff:df82:9cc9])
        by smtp.gmail.com with ESMTPSA id z24-20020a1cf418000000b003f3e50eb606sm15935297wma.13.2023.05.08.01.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 01:53:42 -0700 (PDT)
Date:   Mon, 8 May 2023 10:53:41 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jerome Neanne <jneanne@baylibre.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, khilman@baylibre.com, j-keerthy@ti.com
Subject: Re: [RESEND PATCH] regulator: tps65219: Fix matching interrupts for
 their regulators
Message-ID: <20230508085341.hggdfw45zqer4e5q@blmsp>
References: <20230507144656.192800-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230507144656.192800-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, May 07, 2023 at 04:46:56PM +0200, Krzysztof Kozlowski wrote:
> The driver's probe() first registers regulators in a loop and then in a
> second loop passes them as irq data to the interrupt handlers.  However
> the function to get the regulator for given name
> tps65219_get_rdev_by_name() was a no-op due to argument passed by value,
> not pointer, thus the second loop assigned always same value - from
> previous loop.  The interrupts, when fired, where executed with wrong
> data.  Compiler also noticed it:
> 
>   drivers/regulator/tps65219-regulator.c: In function ‘tps65219_get_rdev_by_name’:
>   drivers/regulator/tps65219-regulator.c:292:60: error: parameter ‘dev’ set but not used [-Werror=unused-but-set-parameter]
> 
> Fixes: c12ac5fc3e0a ("regulator: drivers: Add TI TPS65219 PMIC regulators support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best,
Markus

> 
> ---
> 
> Not tested.
> Sent two months ago and no comments, so resending.
> 
> Cc: Jerome Neanne <jneanne@baylibre.com>
> Cc: khilman@baylibre.com
> Cc: msp@baylibre.com
> Cc: j-keerthy@ti.com
> ---
>  drivers/regulator/tps65219-regulator.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/regulator/tps65219-regulator.c b/drivers/regulator/tps65219-regulator.c
> index b1719ee990ab..8971b507a79a 100644
> --- a/drivers/regulator/tps65219-regulator.c
> +++ b/drivers/regulator/tps65219-regulator.c
> @@ -289,13 +289,13 @@ static irqreturn_t tps65219_regulator_irq_handler(int irq, void *data)
>  
>  static int tps65219_get_rdev_by_name(const char *regulator_name,
>  				     struct regulator_dev *rdevtbl[7],
> -				     struct regulator_dev *dev)
> +				     struct regulator_dev **dev)
>  {
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(regulators); i++) {
>  		if (strcmp(regulator_name, regulators[i].name) == 0) {
> -			dev = rdevtbl[i];
> +			*dev = rdevtbl[i];
>  			return 0;
>  		}
>  	}
> @@ -348,7 +348,7 @@ static int tps65219_regulator_probe(struct platform_device *pdev)
>  		irq_data[i].dev = tps->dev;
>  		irq_data[i].type = irq_type;
>  
> -		tps65219_get_rdev_by_name(irq_type->regulator_name, rdevtbl, rdev);
> +		tps65219_get_rdev_by_name(irq_type->regulator_name, rdevtbl, &rdev);
>  		if (IS_ERR(rdev)) {
>  			dev_err(tps->dev, "Failed to get rdev for %s\n",
>  				irq_type->regulator_name);
> -- 
> 2.34.1
> 
