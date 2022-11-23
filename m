Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C18C63551F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbiKWJPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237287AbiKWJPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:15:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E074E107E41
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:15:29 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 834646602A65;
        Wed, 23 Nov 2022 09:15:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669194928;
        bh=4dlMANCcWyhN3x6ntNDLGRNwp8BpM4nQM3TDNFtBdfw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ow7d1owJRJkE2pacH5cEMLBc2rKlw90cJG1YccvOwGKSzLKNdADVUkel2QGmQuHXF
         027zKZa25m5a1qRMqzO/Dz6mJs/9YnLmmf1VybqGG1lYAi/tcJs4TcCt2qnsXV1u8q
         3jIQIepgAZfGinKWunqb3ilM2I76ujcJhhglMLTsmOirEm7HyCsrBb4F9nIKDxeN6+
         i+f86bICPbPXJ8TO4w8ZAlsJVmHg9ChT4KOTqkOdIx5NpwCejhFyVigDc3wwADVioU
         WeRvvWNhEDJV1S2rSxiOT7bVLJRz/BQCQRWlK9fAnjbtERqjzR0bEf32H2enEgLM7S
         H1cEfIRp9L7gQ==
Message-ID: <a67594cf-eb7f-873f-1c11-ccb4317b6bdf@collabora.com>
Date:   Wed, 23 Nov 2022 10:15:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] drm/mediatek: Clean dangling pointer on bind error
 path
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     kernel@collabora.com, "Nancy . Lin" <nancy.lin@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Mao Huang <littlecvr@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20221122143949.3493104-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221122143949.3493104-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/11/22 15:39, Nícolas F. R. A. Prado ha scritto:
> mtk_drm_bind() can fail, in which case drm_dev_put() is called,
> destroying the drm_device object. However a pointer to it was still
> being held in the private object, and that pointer would be passed along
> to DRM in mtk_drm_sys_prepare() if a suspend were triggered at that
> point, resulting in a panic. Clean the pointer when destroying the
> object in the error path to prevent this from happening.
> 
> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
> Changes in v2:
> - Added Fixes tag
> 
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 39a42dc8fb85..a21ff1b3258c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -514,6 +514,7 @@ static int mtk_drm_bind(struct device *dev)
>   err_deinit:
>   	mtk_drm_kms_deinit(drm);
>   err_free:
> +	private->drm = NULL;

Sorry for not noticing that in v1, but I've rechecked this function and, while this
commit does indeed actually solve the described issue, I think it's incomplete.

A few lines before, we have a loop that sets

		private->all_drm_private[i]->drm = drm;

...so here you should do...

	private->drm = NULL;

	while (i--) /* a for loop will also do, your choice */
		private->all_drm_private[i]->drm = NULL;
		
That makes sure that you cleanup *everything* :-)

Cheers,
Angelo

