Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2615F606601
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiJTQkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiJTQkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:40:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB82F1382CA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:40:29 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7DDA8660247C;
        Thu, 20 Oct 2022 17:40:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666284028;
        bh=cvM3djFXmy7wP9TkTQGsL5CnoFlBKYQJZrVbENrbUJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HxVPgP72xkk5pXDKB0rWnF5v2W6J0ELdMBK2J5ULgnVIuKkL2msmdQeA51+5tWcmv
         Y8ZLEkBLMdkWlLl7UgQk+O09ljGPdB2h7qcnrvuURew/O36BvfyMKDlzNnHrSLSYyE
         Mi+Qp43rg1cXDRw9I8Dhi7da8bAK7nGxmlM4r7fM756rjS85u9kkzTRqAA7w+XxZnk
         O9LR0hBz6LcXtw688DI8MrPsIT/oGudBYtRZ3/LGol0Jv4LnuR3Ez8sHprNzN2qd+U
         uFKskEaJDFlIe1TqaDgUMsg9tO+5lr1PjG5BlwD0EJfjUzzYn6A0xxF3ppxX0FYWgd
         Z2bKZRHhol5Ow==
Date:   Thu, 20 Oct 2022 12:40:22 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     xinlei.lee@mediatek.com
Cc:     matthias.bgg@gmail.com, rex-bc.chen@mediatek.com,
        angelogioacchino.delregno@collabora.com, jason-jh.lin@mediatek.com,
        chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [PATCH v12,2/3] drm: mediatek: Set dpi format in mmsys
Message-ID: <20221020164022.vtnumo3fob2sh54w@notapiano>
References: <1666147936-27368-1-git-send-email-xinlei.lee@mediatek.com>
 <1666147936-27368-3-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1666147936-27368-3-git-send-email-xinlei.lee@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:52:15AM +0800, xinlei.lee@mediatek.com wrote:
[..]
> @@ -134,6 +137,7 @@ struct mtk_dpi_yc_limit {
>   * @yuv422_en_bit: Enable bit of yuv422.
>   * @csc_enable_bit: Enable bit of CSC.
>   * @pixels_per_iter: Quantity of transferred pixels per iteration.
> + * @edge_cfg_in_mmsys: If the edge configuration for DPI's output needs to be set in MMSYS.

As Angelo suggested previously, this could be written slightly shorter as 

  * @edge_cfg_in_mmsys: Edge configuration for DPI output has to be set in MMSYS.

>   */
[..]
> @@ -448,8 +453,12 @@ static void mtk_dpi_dual_edge(struct mtk_dpi *dpi)
>  		mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING,
>  			     dpi->output_fmt == MEDIA_BUS_FMT_RGB888_2X12_LE ?
>  			     EDGE_SEL : 0, EDGE_SEL);
> +		if (dpi->conf->edge_cfg_in_mmsys)
> +			mtk_mmsys_ddp_dpi_fmt_config(dpi->mmsys_dev, MTK_DPI_RGB888_DDR_CON);
>  	} else {
>  		mtk_dpi_mask(dpi, DPI_DDR_SETTING, DDR_EN | DDR_4PHASE, 0);
> +		if (dpi->conf->edge_cfg_in_mmsys)
> +			mtk_mmsys_ddp_dpi_fmt_config(dpi->mmsys_dev, MTK_DPI_RGB888_SDR_CON);

I know this isn't one of the formats supported by MT8186, but since we're using
platform-agnostic formats now... This else branch in theory could also run for a
format like MEDIA_BUS_FMT_YUYV8_1X16. Would it make sense to set
MTK_DPI_RGB888_SDR_CON in that case?

Thanks,
Nícolas

>  	}
[..]
