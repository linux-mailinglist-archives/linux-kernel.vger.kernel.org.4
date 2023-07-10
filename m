Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1056A74CF68
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjGJIF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGJIFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:05:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0DCA6;
        Mon, 10 Jul 2023 01:05:18 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 36B9866028F5;
        Mon, 10 Jul 2023 09:05:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688976316;
        bh=2DjoZdLJ0+hIuE/CqtvGGTHozeIlajnCG/PuxnMbmNU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TCgvXq9kyG4/pED3IXY6vz1IQTqIZI0thMB2tD1r9pOVzC9/WTcA6xIRSJwtmK6VC
         gGBn5Zj0xq+oI93rx97Ler0VvQVSDxbBZiEatgLfyYFulBrWnRE3HsYxWuc+kL07d+
         D5VS8DCPuRxTd1/c+VcukF3iV4cYFLtVdOF/DueDGvRSZiu3a4K70oGtBcPhU7RhOd
         OprkZVWVbu55EgBJrgpko3iaFHakrKkCOU2orQNs1BNozfqVSH+nkb3O6aaTu1LfSx
         LZqDWKtTOvJrNSj7+wauKLavRaqNhJbVETKTljXyCH3x7nT0vGzG5Ku2IUeLHiiY+Y
         cTMasXvOcHmLw==
Message-ID: <c41f96be-b728-4c06-76c5-7f7febc50e3e@collabora.com>
Date:   Mon, 10 Jul 2023 10:05:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] media: mtk-jpeg: Set platform driver data earlier
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Bin Liu <bin.liu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kyrie.wu@mediatek.com,
        irui.wang@mediatek.com
References: <20230710065139.1763695-1-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230710065139.1763695-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/07/23 08:51, Chen-Yu Tsai ha scritto:
> In the multi-core JPEG encoder/decoder setup, the driver for the
> individual cores references the parent device's platform driver data.
> However, in the parent driver, this is only set at the end of the probe
> function, way later than devm_of_platform_populate(), which triggers
> the probe of the cores. This causes a kernel splat in the sub-device
> probe function.
> 
> Move platform_set_drvdata() to before devm_of_platform_populate() to
> fix this.
> 
> Fixes: 934e8bccac95 ("mtk-jpegenc: support jpegenc multi-hardware")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> Not sure what caused this to surface just now, given that the driver
> changes were merged in v6.2-rc1, and the corresponding dts entries
> in v6.3-rc1.
> 
> This fixes boot failures on MT8195. Please apply and send to Linus ASAP.
> 
>   drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index 4768156181c9..6a8eea9dde67 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> @@ -1312,6 +1312,8 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
>   	jpeg->dev = &pdev->dev;
>   	jpeg->variant = of_device_get_match_data(jpeg->dev);
>   
> +	platform_set_drvdata(pdev, jpeg);
> +
>   	ret = devm_of_platform_populate(&pdev->dev);
>   	if (ret) {
>   		v4l2_err(&jpeg->v4l2_dev, "Master of platform populate failed.");
> @@ -1383,8 +1385,6 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
>   		  jpeg->variant->dev_name, jpeg->vdev->num,
>   		  VIDEO_MAJOR, jpeg->vdev->minor);
>   
> -	platform_set_drvdata(pdev, jpeg);
> -
>   	pm_runtime_enable(&pdev->dev);
>   
>   	return 0;

