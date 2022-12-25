Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D446655D56
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 15:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiLYOHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 09:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLYOHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 09:07:12 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5071F62DA;
        Sun, 25 Dec 2022 06:07:11 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1p9ReY-0002Hy-1h;
        Sun, 25 Dec 2022 15:07:02 +0100
Date:   Sun, 25 Dec 2022 14:06:59 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: mediatek: Enable irq before the spi registration
Message-ID: <Y6hZA19rWuDkGJa2@makrotopia.org>
References: <20221225-mtk-spi-fixes-v1-0-bb6c14c232f8@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221225-mtk-spi-fixes-v1-0-bb6c14c232f8@chromium.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 25, 2022 at 09:37:12AM +0100, Ricardo Ribalda wrote:
> If the irq is enabled after the spi si registered, there can be a race
> with the initialization of the devices on the spi bus.
> 
> Eg:
> mtk-spi 1100a000.spi: spi-mem transfer timeout
> spi-nor: probe of spi0.0 failed with error -110
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000010
> ...
> Call trace:
>  mtk_spi_can_dma+0x0/0x2c
> 
> Fixes: c6f7874687f7 ("spi: mediatek: Enable irq when pdata is ready")
> Reported-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> spi: mediatek: Fix init order (again)
> 
> Hi Mark
> 
> Here is a fixup of the previous patch. Daniel, can you confirm that it
> works on your hardware? 

Yes, this fixes the issue and SPI now works fine on MT7986 with the
patch applied.

Tested-by: Daniel Golle <daniel@makrotopia.org>

> 
> Thanks and sorry for annoyance. 
> 
> To: Mark Brown <broonie@kernel.org>
> To: Matthias Brugger <matthias.bgg@gmail.com>
> To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: linux-spi@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/spi/spi-mt65xx.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index 6de8360e5c2a..9eab6c20dbc5 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -1253,6 +1253,11 @@ static int mtk_spi_probe(struct platform_device *pdev)
>  		dev_notice(dev, "SPI dma_set_mask(%d) failed, ret:%d\n",
>  			   addr_bits, ret);
>  
> +	ret = devm_request_irq(dev, irq, mtk_spi_interrupt,
> +			       IRQF_TRIGGER_NONE, dev_name(dev), master);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register irq\n");
> +
>  	pm_runtime_enable(dev);
>  
>  	ret = devm_spi_register_master(dev, master);
> @@ -1261,13 +1266,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, ret, "failed to register master\n");
>  	}
>  
> -	ret = devm_request_irq(dev, irq, mtk_spi_interrupt,
> -			       IRQF_TRIGGER_NONE, dev_name(dev), master);
> -	if (ret) {
> -		pm_runtime_disable(dev);
> -		return dev_err_probe(dev, ret, "failed to register irq\n");
> -	}
> -
>  	return 0;
>  }
>  
> 
> ---
> base-commit: 45b3cd900bf8d1a3cd7cf48361df8c09ae5b4009
> change-id: 20221225-mtk-spi-fixes-99c863a6fdf1
> 
> Best regards,
> -- 
> Ricardo Ribalda <ribalda@chromium.org>
