Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E9F6DD7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjDKKcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDKKcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:32:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE70E9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:32:06 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f080f4fbe1so2777635e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681209125; x=1683801125;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWlYQX4Y1ZrzJyCNGQSUMnvOvpF/Z/nFIdYNxxNfrEg=;
        b=czHW7oszK57m41YR1u+rD3WPMSqPt6wloedBSlnzaMzPEUQ/AHMXNTewQNCzs/8uUD
         IFEphUmtf6E4QUbYANlkCNzJe1Mknn9tNbRgPUXAABh8MhWaBbw1CR71cEdupmHjjTAh
         elfhAUeAnv6GIjWOC7PEKocqH2pcKofnzo9K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681209125; x=1683801125;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWlYQX4Y1ZrzJyCNGQSUMnvOvpF/Z/nFIdYNxxNfrEg=;
        b=Do9Jfjb8zfRNtkBe9lpJG9r3yfba4bT4mQ+0rG3NzG7LszmM8Z96CYWtG7xujhSGo+
         hBsbpcXQRD+ybXQ1aX1JBSRIHbsRCYygyfgCExjoxdLPp723nNVWTIf1YcmSO4fG0mBM
         tIJLBRFZ8nByS59S0yRH66SGvnUnxQGl1y4XHyhcTL3RpGJv5EZkv+HtxMkN76ZPCTPY
         lh5lwaW2kNWrr52yb3LCoFB4tc9MmMmVHeiHV+Fma4+wi/TEEjS512/csejlqKTvFm5R
         JB5GY6RZVj3w5UXPRl9TCWlxqvjgGqi0PE9KMZvPMNYkUyIdIVx+wh7TZTrr+58dc/Qv
         3e8Q==
X-Gm-Message-State: AAQBX9dCx2AOVgyvLVda8lJ4PJr1D2W5KrtNh5AOBL+p5uAsq6bSuJHv
        1CFUSs8xg1GbtLV1QaIAIwTWGQ==
X-Google-Smtp-Source: AKy350YHW26EoAnUgqXxjoecjfwc/bqx2pfSiH62+M+X8xHeutLKJ3Eqi5SeePtTr8IKBvV/huRCow==
X-Received: by 2002:a5d:50c5:0:b0:2f0:244c:2780 with SMTP id f5-20020a5d50c5000000b002f0244c2780mr4057657wrt.7.1681209125018;
        Tue, 11 Apr 2023 03:32:05 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id r10-20020adfe68a000000b002c7b229b1basm14182353wrm.15.2023.04.11.03.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 03:32:04 -0700 (PDT)
Date:   Tue, 11 Apr 2023 12:32:02 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Nancy.Lin" <nancy.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        singo.chang@mediatek.com, shawn.sung@mediatek.com
Subject: Re: [PATCH v3 1/2] drm/mediatek: Add mdp_rdma get format function
Message-ID: <ZDU3IiewmLW1pDyn@phenom.ffwll.local>
Mail-Followup-To: "Nancy.Lin" <nancy.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        singo.chang@mediatek.com, shawn.sung@mediatek.com
References: <20230330032614.18837-1-nancy.lin@mediatek.com>
 <20230330032614.18837-2-nancy.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330032614.18837-2-nancy.lin@mediatek.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 11:26:13AM +0800, Nancy.Lin wrote:
> Add mdp_rdma get_format and get_num_formats function.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>

The mtk get_formats stuff seems like a lot of midlayering for not much
reasons? Is that really needed?

Just a drive-by questions I had while merging the pr.
-Daniel

> ---
>  drivers/gpu/drm/mediatek/mtk_disp_drv.h |  3 +++
>  drivers/gpu/drm/mediatek/mtk_mdp_rdma.c | 24 ++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> index 0d28b2e2069c..17b169530beb 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> @@ -152,4 +152,7 @@ void mtk_mdp_rdma_start(struct device *dev, struct cmdq_pkt *cmdq_pkt);
>  void mtk_mdp_rdma_stop(struct device *dev, struct cmdq_pkt *cmdq_pkt);
>  void mtk_mdp_rdma_config(struct device *dev, struct mtk_mdp_rdma_cfg *cfg,
>  			 struct cmdq_pkt *cmdq_pkt);
> +const u32 *mtk_mdp_rdma_get_formats(struct device *dev);
> +size_t mtk_mdp_rdma_get_num_formats(struct device *dev);
> +
>  #endif
> diff --git a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
> index eecfa98ff52e..e06db6e56b5f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
> @@ -62,6 +62,20 @@
>  #define RDMA_CSC_FULL709_TO_RGB			5
>  #define RDMA_CSC_BT601_TO_RGB			6
>  
> +static const u32 formats[] = {
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_BGRX8888,
> +	DRM_FORMAT_BGRA8888,
> +	DRM_FORMAT_ABGR8888,
> +	DRM_FORMAT_XBGR8888,
> +	DRM_FORMAT_RGB888,
> +	DRM_FORMAT_BGR888,
> +	DRM_FORMAT_RGB565,
> +	DRM_FORMAT_UYVY,
> +	DRM_FORMAT_YUYV,
> +};
> +
>  enum rdma_format {
>  	RDMA_INPUT_FORMAT_RGB565 = 0,
>  	RDMA_INPUT_FORMAT_RGB888 = 1,
> @@ -219,6 +233,16 @@ void mtk_mdp_rdma_config(struct device *dev, struct mtk_mdp_rdma_cfg *cfg,
>  			   MDP_RDMA_MF_CLIP_SIZE, FLD_MF_CLIP_H);
>  }
>  
> +const u32 *mtk_mdp_rdma_get_formats(struct device *dev)
> +{
> +	return formats;
> +}
> +
> +size_t mtk_mdp_rdma_get_num_formats(struct device *dev)
> +{
> +	return ARRAY_SIZE(formats);
> +}
> +
>  int mtk_mdp_rdma_clk_enable(struct device *dev)
>  {
>  	struct mtk_mdp_rdma *rdma = dev_get_drvdata(dev);
> -- 
> 2.18.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
