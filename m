Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91B37019EF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 23:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjEMVAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 17:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEMVA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 17:00:28 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0AB2D62;
        Sat, 13 May 2023 14:00:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f13ef4ad91so13161194e87.3;
        Sat, 13 May 2023 14:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684011625; x=1686603625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zV8NgaKI21AYQDcwSfLTQKxLM+XHKCDcxx81oVOTUWw=;
        b=Jytbx05Cm4hRTOEvxNhKpkt2EycSPOAApYX5iEcq1PaJuvy6ICXIOO9Db6B51iIxY4
         VY5Yqc35txmob86hBt2gP1ryznD2AQ4DiAkSqscaosGywE9/Ph9/tRXfFMd/Qs1SHfOR
         YETIirJvPgjmShxeiMhmTNAAKbSrBOgWuVoC63XvbrHsV76QKFzjXG8E7wkTmdrBAb0J
         mSBE5PrfXG1/f+Ode8WFbFkNDeZeREiXMrkaYfChmihjannARS01AbzBkJHAAH9Ny4W4
         VYAe4lgrla69MbHTPurn3FzG80xSLa7GdVzjHEd364HSVJCITe9a0CNEuIQPtOJD3vUt
         LimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684011625; x=1686603625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zV8NgaKI21AYQDcwSfLTQKxLM+XHKCDcxx81oVOTUWw=;
        b=a24D8R6ZtleWxqbyYu060snWsH0mdwHmIiN355WdnwMKAAJEdKnhFt/S03nUbdoJuT
         TBZwBwcZxH5aakQsKelGIqh5wf1qbQ7DksXXU+RmB+6a5AdUrAf+09sUi2M8FfEZ724J
         lXUGfuWiDJy6xbrs2f1oglesT9N8DG2iY1TPYg6T9har3GJq3bN435Z0NhfwAF3L4NI6
         ZmkhuTxpxoEtdy85w3/9942qVKqHFi7elOcoTJZ7TaqcsvM6iyAv1W33jQnYYi6WNWES
         nPIrGMY7yqyp8CRI+U4jeeP3EmHqLwsOvdUGxC3NT9/DLWkNx43iLpNQllDu9ewF+2yg
         B3Eg==
X-Gm-Message-State: AC+VfDyZksvA9MpWELaECvqJy/zEn51Y4mDc3H7QVuT8gujSrYFVlWYL
        K+gZLcT7RXEMbPjGFcl+q5c=
X-Google-Smtp-Source: ACHHUZ490C1IMSfYMBIJPIBdjHu0hQd16yeY8REgzrulETc0r/zO1YtaBnR0pzf3SHx8vnFcg/YI2Q==
X-Received: by 2002:ac2:5d2d:0:b0:4e9:bf83:11a4 with SMTP id i13-20020ac25d2d000000b004e9bf8311a4mr4392216lfb.7.1684011624891;
        Sat, 13 May 2023 14:00:24 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id o1-20020a05651238a100b004d8546456c6sm1927815lft.195.2023.05.13.14.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 14:00:24 -0700 (PDT)
Date:   Sun, 14 May 2023 00:00:21 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "open list:LIBATA SUBSYSTEM" <linux-ide@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] ata: libata: Make ata_platform_remove_one return void
Message-ID: <20230513210021.gver7ibozrmmbm4j@mobilestation>
References: <20230512204646.137746-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230512204646.137746-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 10:46:46PM +0200, Uwe Kleine-König wrote:
> The function returned zero unconditionally, so the function returning an
> int is something between useless and irritating. With the goal to make
> platform drivers' remove function return void, it's helpful to convert
> the function accordingly. This converts several drivers to the new
> .remove_new callback that was introduced to smoothen the platform driver
> conversion.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

[...]

>  drivers/ata/ahci_dwc.c         | 2 +-

[...]

> diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
> index 4bfbb09cdc02..9604a2f6ed48 100644
> --- a/drivers/ata/ahci_dwc.c
> +++ b/drivers/ata/ahci_dwc.c
> @@ -478,7 +478,7 @@ MODULE_DEVICE_TABLE(of, ahci_dwc_of_match);
>  
>  static struct platform_driver ahci_dwc_driver = {
>  	.probe = ahci_dwc_probe,
> -	.remove = ata_platform_remove_one,
> +	.remove_new = ata_platform_remove_one,
>  	.shutdown = ahci_platform_shutdown,
>  	.driver = {
>  		.name = DRV_NAME,

For DWC AHCI SATA
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

[...]

> -- 
> 2.39.2
> 
