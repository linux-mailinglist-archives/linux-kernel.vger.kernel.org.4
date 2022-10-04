Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8645F4099
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJDKNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJDKNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:13:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED9228E02;
        Tue,  4 Oct 2022 03:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664878398; x=1696414398;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=unSBrfZWWQiaWR5VmWYGXL4IstFzYLo18uQjnoBzJyQ=;
  b=ScrgRUdrsA4otFfZ6Jyu/mtiH4FZ0NqkBAc6zMRRp98cyHKkbWKans9Q
   QHjKQxjcLPka78qbH1HkMQ5X5kxZbi6CGlkp7izW5oH7V2c3Z6Z06nt21
   uCBPJmnBdznIXeyHfe4EfYCYrRPp4mlHDyVFVHR4tt3LPtJq6TNvo/6iS
   l9nh3zlRYCAj0m9CEXFX1zeTzq4kgVsMaC1Fl29iYB3U7cq795n3ZdtcG
   zgvLCzD8YeG/kHs1Wkb3JpgOQAalOAQnD70jjFAtnKQIMjp4U7HNXVhJ5
   A3GoaRDBZrMreJ82owWapeshukLxXWxj9biN/QZkuk43pd+bGAoDiQaOo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="303833888"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="303833888"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 03:13:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="619053782"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="619053782"
Received: from kmreisi-mobl.ger.corp.intel.com ([10.252.39.196])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 03:13:13 -0700
Date:   Tue, 4 Oct 2022 13:13:10 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Irui Wang <irui.wang@mediatek.com>
cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        angelogioacchino.delregno@collabora.com,
        nicolas.dufresne@collabora.com,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v6, 5/8] media: mediatek: vcodec: Add venc power on/off
 function
In-Reply-To: <20221001031737.18266-6-irui.wang@mediatek.com>
Message-ID: <8a19febc-8662-b9f7-8250-44c23af06f91@linux.intel.com>
References: <20221001031737.18266-1-irui.wang@mediatek.com> <20221001031737.18266-6-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2022, Irui Wang wrote:

> when enable multi-core encoding, all available encoder cores' power need
> to be on/off, add new functions for encoder cores' power management.
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> ---

> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
> index 75de5031d292..213c3f50e9eb 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
> @@ -9,6 +9,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/pm_runtime.h>
>  
> +#include "mtk_vcodec_enc_hw.h"
>  #include "mtk_vcodec_enc_pm.h"
>  #include "mtk_vcodec_util.h"
>  
> @@ -56,6 +57,88 @@ int mtk_vcodec_init_enc_clk(struct platform_device *pdev,
>  }
>  EXPORT_SYMBOL_GPL(mtk_vcodec_init_enc_clk);
>  
> +static int mtk_enc_core_power_on(struct mtk_vcodec_ctx *ctx)
> +{
> +	struct mtk_venc_hw_dev *sub_core;
> +	int ret, i;
> +
> +	/* multi-core encoding need power on all available cores */
> +	for (i = 0; i < MTK_VENC_HW_MAX; i++) {
> +		sub_core = (struct mtk_venc_hw_dev *)ctx->dev->enc_hw_dev[i];
> +		if (!sub_core)
> +			continue;
> +
> +		ret = pm_runtime_resume_and_get(&sub_core->plat_dev->dev);
> +		if (ret) {
> +			mtk_v4l2_err("power on sub_core[%d] fail %d", i, ret);
> +			goto pm_on_fail;
> +		}
> +	}
> +	return ret;
> +
> +pm_on_fail:
> +	for (i -= 1; i >= 0; i--) {

while (i--) {

achieves the same.

> +		sub_core = (struct mtk_venc_hw_dev *)ctx->dev->enc_hw_dev[i];
> +		pm_runtime_put_sync(&sub_core->plat_dev->dev);
> +	}
> +	return ret;
> +}


-- 
 i.

