Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D163B734503
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 07:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjFRF4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 01:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRF4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 01:56:06 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A184310D0;
        Sat, 17 Jun 2023 22:56:04 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so2260807f8f.2;
        Sat, 17 Jun 2023 22:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687067762; x=1689659762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NX5ZV664S/3sQaZAuC+xeosJghTMxUMI70alZxPa5Y=;
        b=paCHA7pjmnWe/IxKblZOvVLJCQMFIcAb2uKzUfv6t5CZ3G1g9hXPWQ58MUXkuXmstv
         O6R1T7qbyg22aeMnmfS9GKuJZkCptCgv8gl02U7bx3vOy2jTgX9WGMkbt+o0JvCUs+kW
         bA+mts79t+1rkGlZnKT8v1xPOjTDI1mljmSht/lqTrAYza1MktBdvcCYHnJBJ3J90SAU
         firfpBvpMPctU6fXBfPySyg6YIq2gUqqEkiphtZ3ZvVVDwpz2lqwWwcsITHzvTMXTJzj
         W+8jF/PwHqlykUASb2AVCXVaYe1soMWghMN1QCjmmR0zFF3GU948sIjFP62ppXVd7WfZ
         ffYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687067762; x=1689659762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NX5ZV664S/3sQaZAuC+xeosJghTMxUMI70alZxPa5Y=;
        b=XTEPlWfZmGQJqteKwDhh3yd9fDvZKL6BlNYC7dZbN9tG3GPSZbyyL+aGJMyFtIGg4o
         3RDNpWAteFnrXJ5yLDVcORZO2fKTjXjIEY5dt2bho042NxNGhvH2eCejxh9fK/yeXu9j
         I01H5wQRVp4ClgIl0SmZBYjdNkJuhtOHuE8tHpokWKeTLTJM+HWpdq8wLTdABoY8ZZ2R
         ojSHqojuEOwWfGfjKlmjAtPpGF1edcCjNngvqSCqEn8bGvSGiO/pukV5lDUrz1s3KeNB
         1REGn6k22jzap3BCWqiWaleRlJLZKzlI9jMhcZAM5WNHtor2dixkhOQscSa1fqauB+q7
         L0pQ==
X-Gm-Message-State: AC+VfDydmw0oDciI9oFayGSNQis3NpHBTMGZICbezHJn5aXzMlHxxdAl
        2gsRd3//jKXH7vav6MRsN24=
X-Google-Smtp-Source: ACHHUZ6BOZ2LQ6J+Y8YIuDzGK/TfPStSIUARP0Kxc41zdevAjVxrE87pnYjBbRb1udZcUfffG4tAww==
X-Received: by 2002:adf:f5c8:0:b0:307:9473:fe26 with SMTP id k8-20020adff5c8000000b003079473fe26mr4901839wrp.26.1687067762314;
        Sat, 17 Jun 2023 22:56:02 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id s14-20020a170906354e00b009888b71c368sm154616eja.152.2023.06.17.22.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 22:56:01 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     glaroque@baylibre.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, thara.gopinath@gmail.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        anarsoul@gmail.com, tiny.windzz@gmail.com, wens@csie.org,
        samuel@sholland.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, edubezval@gmail.com, j-keerthy@ti.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, niklas.soderlund+renesas@ragnatech.se,
        wenst@chromium.org, Yangtao Li <frank.li@vivo.com>
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH v3 02/12] thermal/drivers/sun8i: remove redundant msg in
 sun8i_ths_register()
Date:   Sun, 18 Jun 2023 07:55:59 +0200
Message-ID: <2684470.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20230613114904.15749-2-frank.li@vivo.com>
References: <20230613114904.15749-1-frank.li@vivo.com>
 <20230613114904.15749-2-frank.li@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 13. junij 2023 ob 13:48:54 CEST je Yangtao Li napisal(a):
> The upper-layer devm_thermal_add_hwmon_sysfs() function can directly
> print error information.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/thermal/sun8i_thermal.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> index 793ddce72132..066f9fed9b86 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -475,9 +475,7 @@ static int sun8i_ths_register(struct ths_device *tmdev)
>  		if (IS_ERR(tmdev->sensor[i].tzd))
>  			return PTR_ERR(tmdev->sensor[i].tzd);
>  
> -		if (devm_thermal_add_hwmon_sysfs(tmdev->dev, tmdev->sensor[i].tzd))
> -			dev_warn(tmdev->dev,
> -				 "Failed to add hwmon sysfs attributes\n");
> +		devm_thermal_add_hwmon_sysfs(tmdev->dev, tmdev->sensor[i].tzd);
>  	}
>  
>  	return 0;
> 




