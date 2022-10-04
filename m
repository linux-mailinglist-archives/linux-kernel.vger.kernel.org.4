Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43855F40B6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJDKWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiJDKWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:22:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B1D31DF3;
        Tue,  4 Oct 2022 03:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664878921; x=1696414921;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tYiX0livaZV54Tpug1MQVrKJH6mQ7IQHkmnz80pYNMc=;
  b=Lx5ecCpvJADqj4mBwKve/+zRtT8lrCSHkScQay4RtXTFEuj0ElXeZumR
   mBnLziFdN8WFsqbdKUbm18Zl1b6ZM9+ecBpe4YYxONlzXafxDju3YM0q4
   UM+HLpkOuVgLp/53bQlp1qjlONGwlDkdrO99fknFpWBzGmoQdBtNuKJkb
   fM3JAn57/iwwWyQ1ex8shEuO3u3K+8ftpholn5j3EnR+W0Otp45ecz231
   A8jNcZ5vjgzGNiIRtwM9QAfflN24NtAQtJ08JKJSesp9gQeNNcJfRGkHY
   B3PgIwQL7+a/Ust9rf9lxXeGRgaKxW8vPy8n2kpSBISrTD8dX0vRDdlR/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="389167470"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="389167470"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 03:22:00 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="657081017"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="657081017"
Received: from kmreisi-mobl.ger.corp.intel.com ([10.252.39.196])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 03:21:55 -0700
Date:   Tue, 4 Oct 2022 13:21:52 +0300 (EEST)
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
Subject: Re: [PATCH v6, 6/8] media: mediatek: vcodec: Refactor encoder clock
 on/off function
In-Reply-To: <20221001031737.18266-7-irui.wang@mediatek.com>
Message-ID: <3645b24f-436e-d6a5-27cd-287712eab22@linux.intel.com>
References: <20221001031737.18266-1-irui.wang@mediatek.com> <20221001031737.18266-7-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2022, Irui Wang wrote:

> when enable multi-core encoding, encoder cores use their own clock,
> refactor clock management functions with used encoder hardware id.
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> ---
>  .../mediatek/vcodec/mtk_vcodec_enc_pm.c       | 89 ++++++++++++++++---
>  .../mediatek/vcodec/mtk_vcodec_enc_pm.h       |  6 +-
>  .../platform/mediatek/vcodec/venc_drv_if.c    |  4 +-
>  3 files changed, 84 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
> index 213c3f50e9eb..2f83aade779a 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
> @@ -60,7 +60,9 @@ EXPORT_SYMBOL_GPL(mtk_vcodec_init_enc_clk);
>  static int mtk_enc_core_power_on(struct mtk_vcodec_ctx *ctx)
>  {
>  	struct mtk_venc_hw_dev *sub_core;
> +	struct mtk_vcodec_clk *clk;
>  	int ret, i;
> +	int j = 0;
>  
>  	/* multi-core encoding need power on all available cores */
>  	for (i = 0; i < MTK_VENC_HW_MAX; i++) {
> @@ -73,12 +75,27 @@ static int mtk_enc_core_power_on(struct mtk_vcodec_ctx *ctx)
>  			mtk_v4l2_err("power on sub_core[%d] fail %d", i, ret);
>  			goto pm_on_fail;
>  		}
> +
> +		clk = &sub_core->pm.venc_clk;
> +		for (j = 0; j < clk->clk_num; j++) {
> +			ret = clk_prepare(clk->clk_info[j].vcodec_clk);
> +			if (ret) {
> +				mtk_v4l2_err("prepare clk [%s] fail %d",
> +					     clk->clk_info[j].clk_name, ret);
> +				goto pm_on_fail;
> +			}
> +		}
>  	}
>  	return ret;
>  
>  pm_on_fail:
>  	for (i -= 1; i >= 0; i--) {
>  		sub_core = (struct mtk_venc_hw_dev *)ctx->dev->enc_hw_dev[i];
> +
> +		clk = &sub_core->pm.venc_clk;
> +		for (j -= 1; j >= 0; j--)
> +			clk_unprepare(clk->clk_info[j].vcodec_clk);
> +
>  		pm_runtime_put_sync(&sub_core->plat_dev->dev);

There's more than one thing wrong here.

pm_runtime_put_sync() won't be called for the ith entry when the later 
goto pm_on_fail is taken because the loop decrements i right at the 
start.

Similarly, i and j will mismatch for the ith entry because i was 
decremented.

Third, j does not start from clk->clk_num - 1 for the other entries 
(for those lower "i"s).


-- 
 i.

