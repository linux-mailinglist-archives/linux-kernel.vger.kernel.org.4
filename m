Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9604B750989
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjGLNXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjGLNXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:23:09 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B3B19A7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:23:07 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b734aea34aso21217291fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20221208.gappssmtp.com; s=20221208; t=1689168185; x=1691760185;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cFbSFj9le/usrCi2OxYHwS0d4kbQdwC9hFOkQplOr7s=;
        b=y9Dk2RnSmhBdUuFNGlfxUKPD2/zFsx9LtPsqr3+Ll7Ldjus4MTVnbVWDhy9gXP56Wj
         uCdINq8m0ym5JfEwKMi4/uw4G34TDwII5Kbz0VuQ4BPeDmP9McF7RO4SqRUrJOYJ34wD
         I9L7llj+bdDYjwgnZTrDlTx1uxwm7jim5/tNaDVf+/IAwmWLjPFSIVk5VPgU94saeZMC
         0yvYpu2AOIYnTRIBBdVoR7S3/ZHvEu2H1TC98PujEU/R/GMQ68cLu4L/LhxZzNug1X/N
         IwoFjjZMGJ8U/gYgeb62v05NSkeNxzX4jZ1nxL79YD8h22/7nLkIfb9MqVUfvWzX9uYt
         SjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689168185; x=1691760185;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFbSFj9le/usrCi2OxYHwS0d4kbQdwC9hFOkQplOr7s=;
        b=KROJXb8sbw+QcoIjlHxqsf/oUm83eUrpJ8ZfFSDB27f+sZ+7qZSy18z94LLNxgyysR
         K9JvZN0x9tqAUFJ6PfQVe+n8AC/KkjW+62JBg28aJOwyOdZ7FLQe6Czb9ifCHSIJg+rW
         JOH4ubxhW3KpZALE+7zm65DHBNW6a6PTtpzfOPniIoKnMVms7Kxm2ifZ4Q6cvQvXrTh/
         ujBgql11fIoyBxBLLQGNqfC+U8nDDxdp32aKxUIzjct+6FblkF6uSDipih3FKjzFkUnU
         vanYnDayObu3w2Tg0E1JSYuM4ft9wWIAqoAnl28kbbo1tWqWNcA3WAKSo3nZjUesyzzP
         VofA==
X-Gm-Message-State: ABy/qLYNNRgy5ZPliqk01G38WVFnrCS5j39wxSBegLohwVC1R4vpZbPO
        RbtB3JE9JtAd1lDKf5Dtg65ZAw==
X-Google-Smtp-Source: APBJJlEjY62aR6eUpwBN6FjTaX14zPhrcQ7k6aIg1dZBoRF9vUfb3XIfKktTWtBpZChaqYbEu/YzfA==
X-Received: by 2002:a05:6512:2344:b0:4fb:8574:a9c6 with SMTP id p4-20020a056512234400b004fb8574a9c6mr18519564lfu.10.1689168185304;
        Wed, 12 Jul 2023 06:23:05 -0700 (PDT)
Received: from localhost (h-46-59-89-207.A463.priv.bahnhof.se. [46.59.89.207])
        by smtp.gmail.com with ESMTPSA id f11-20020ac2532b000000b004fb76438a83sm709467lfh.171.2023.07.12.06.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 06:23:04 -0700 (PDT)
Date:   Wed, 12 Jul 2023 15:23:04 +0200
From:   Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/27] thermal/drivers/rcar_thermal: Convert to platform
 remove callback returning void
Message-ID: <ZK6pOIET7MnkkP-d@oden.dyn.berto.se>
References: <20230712081258.29254-1-frank.li@vivo.com>
 <20230712081258.29254-21-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712081258.29254-21-frank.li@vivo.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-12 16:12:52 +0800, Yangtao Li wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>

> ---
>  drivers/thermal/rcar_thermal.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index b8571f7090aa..b4c58c5f6f6d 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -371,7 +371,7 @@ static irqreturn_t rcar_thermal_irq(int irq, void *data)
>  /*
>   *		platform functions
>   */
> -static int rcar_thermal_remove(struct platform_device *pdev)
> +static void rcar_thermal_remove(struct platform_device *pdev)
>  {
>  	struct rcar_thermal_common *common = platform_get_drvdata(pdev);
>  	struct device *dev = &pdev->dev;
> @@ -388,8 +388,6 @@ static int rcar_thermal_remove(struct platform_device *pdev)
>  
>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
> -
> -	return 0;
>  }
>  
>  static int rcar_thermal_probe(struct platform_device *pdev)
> @@ -581,7 +579,7 @@ static struct platform_driver rcar_thermal_driver = {
>  		.of_match_table = rcar_thermal_dt_ids,
>  	},
>  	.probe		= rcar_thermal_probe,
> -	.remove		= rcar_thermal_remove,
> +	.remove_new	= rcar_thermal_remove,
>  };
>  module_platform_driver(rcar_thermal_driver);
>  
> -- 
> 2.39.0
> 

-- 
Kind Regards,
Niklas Söderlund
