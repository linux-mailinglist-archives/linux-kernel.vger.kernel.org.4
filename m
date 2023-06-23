Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD6273B8CB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjFWN3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjFWN33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:29:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02AF19AF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:29:28 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 38A836607135;
        Fri, 23 Jun 2023 14:29:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687526966;
        bh=f25KcXi6OI+LncvpOIXHkVRpkniDYC2VeUuLYp3b3hU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GLoJELngos//bZbPLg0c9rK5fE1moLGbuBfaJuukcPv1OZHhXtJXzQnO0p0SuSOSF
         YflGSif3EVcWaJZPQ/Ss7JdCihtzPiVnNyq+OC26k7ddMYw7tZ/MUbSoetTk0UXqhi
         z+e892o09ky/Aokfifx2YsCjZetTknHB+KY/NQHuba0upMz6yD0oqxMFENcShbyNNj
         UchGt5ZzYuaboFhGI7oKokhZLWtUqkYXbOoQn6aUl3MWWSBvTi2iTX7LAkNT35qi7e
         Dv6a5IT46JGNvrCfhXDp5b0Hk/i5kngBTBrhUXKw8vNCSoKG7FWEah0ylUhmSVxIhc
         CWsdwwA/U3w5w==
Date:   Fri, 23 Jun 2023 09:29:21 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
        daniel@ffwll.ch, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: Re: [PATCH v3 9/9] drm/mediatek: dp: Add support for embedded
 DisplayPort aux-bus
Message-ID: <d7d8db9c-a646-46f7-ab88-d41184b51f26@notapiano>
References: <20230404104800.301150-1-angelogioacchino.delregno@collabora.com>
 <20230404104800.301150-10-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230404104800.301150-10-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 12:48:00PM +0200, AngeloGioacchino Del Regno wrote:
> For the eDP case we can support using aux-bus on MediaTek DP: this
> gives us the possibility to declare our panel as generic "panel-edp"
> which will automatically configure the timings and available modes
> via the EDID that we read from it.
> 
> To do this, move the panel parsing at the end of the probe function
> so that the hardware is initialized beforehand and also initialize
> the DPTX AUX block and power both on as, when we populate the
> aux-bus, the panel driver will trigger an EDID read to perform
> panel detection.
> 
> Last but not least, since now the AUX transfers can happen in the
> separated aux-bus, it was necessary to add an exclusion for the
> cable_plugged_in check in `mtk_dp_aux_transfer()` and the easiest
> way to do this is to simply ignore checking that when the bridge
> type is eDP.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dp.c | 61 ++++++++++++++++++++++++++-----
>  1 file changed, 51 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
> index a67143c22024..8109f5b4392b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
[..]
> @@ -2571,6 +2585,33 @@ static int mtk_dp_probe(struct platform_device *pdev)
>  	mtk_dp->need_debounce = true;
>  	timer_setup(&mtk_dp->debounce_timer, mtk_dp_debounce_timer, 0);
>  
> +	if (mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP) {
> +		/* Initialize, reset and poweron the DPTX AUX block */
> +		mtk_dp_initialize_aux_settings(mtk_dp);
> +		mtk_dp_power_enable(mtk_dp);
> +
> +		/* Power on the panel to allow EDID read from aux-bus */
> +		mtk_dp_aux_panel_poweron(mtk_dp, true);
> +
> +		ret = devm_of_dp_aux_populate_bus(&mtk_dp->aux, NULL);

This patch causes

.../bin/aarch64-none-linux-gnu-ld: Unexpected GOT/PLT entries detected!
.../bin/aarch64-none-linux-gnu-ld: Unexpected run-time procedure linkages detected!
.../bin/aarch64-none-linux-gnu-ld: drivers/gpu/drm/mediatek/mtk_dp.o: in function `mtk_dp_probe':
.../drivers/gpu/drm/mediatek/mtk_dp.c:2595: undefined reference to `devm_of_dp_aux_populate_bus'

You need

diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
index b451dee64d34..76cab28e010c 100644
--- a/drivers/gpu/drm/mediatek/Kconfig
+++ b/drivers/gpu/drm/mediatek/Kconfig
@@ -26,6 +26,7 @@ config DRM_MEDIATEK_DP
        select PHY_MTK_DP
        select DRM_DISPLAY_HELPER
        select DRM_DISPLAY_DP_HELPER
+       select DRM_DP_AUX_BUS
        help
          DRM/KMS Display Port driver for MediaTek SoCs.

Thanks,
Nícolas
