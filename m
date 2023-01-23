Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7EA677E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjAWPBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjAWPBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:01:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2027DB5;
        Mon, 23 Jan 2023 07:01:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B19460F52;
        Mon, 23 Jan 2023 15:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FE9C433D2;
        Mon, 23 Jan 2023 15:01:30 +0000 (UTC)
Message-ID: <068ee5ec-6863-2c1d-39a9-b18156d4e57d@xs4all.nl>
Date:   Mon, 23 Jan 2023 16:01:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 02/12] media: platform: mtk-mdp3: add chip
 configuration header file
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230113064104.22402-1-moudy.ho@mediatek.com>
 <20230113064104.22402-3-moudy.ho@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230113064104.22402-3-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 07:40, Moudy Ho wrote:
> In order to be compatible with more MDP3 chip settings in the future,
> move the chip-related configuration to a separate header file.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  .../mediatek/mdp3/mt8183/mdp3-plat-mt8183.h   | 35 +++++++++++++++++++
>  .../platform/mediatek/mdp3/mtk-mdp3-core.c    | 27 ++------------
>  2 files changed, 37 insertions(+), 25 deletions(-)
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h
> 
> diff --git a/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h b/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h
> new file mode 100644
> index 000000000000..3084f62e7df5
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#ifndef __MDP3_PLAT_MT8183_H__
> +#define __MDP3_PLAT_MT8183_H__
> +
> +static const struct mdp_platform_config mt8183_plat_cfg = {
> +	.rdma_support_10bit		= true,
> +	.rdma_rsz1_sram_sharing		= true,
> +	.rdma_upsample_repeat_only	= true,
> +	.rsz_disable_dcm_small_sample	= false,
> +	.wrot_filter_constraint		= false,
> +};
> +
> +static const struct of_device_id mt8183_mdp_probe_infra[MDP_INFRA_MAX] = {
> +	[MDP_INFRA_MMSYS] = { .compatible = "mediatek,mt8183-mmsys" },
> +	[MDP_INFRA_MUTEX] = { .compatible = "mediatek,mt8183-disp-mutex" },
> +	[MDP_INFRA_SCP] = { .compatible = "mediatek,mt8183-scp" }
> +};
> +
> +static const u32 mt8183_mutex_idx[MDP_MAX_COMP_COUNT] = {
> +	[MDP_COMP_RDMA0] = MUTEX_MOD_IDX_MDP_RDMA0,
> +	[MDP_COMP_RSZ0] = MUTEX_MOD_IDX_MDP_RSZ0,
> +	[MDP_COMP_RSZ1] = MUTEX_MOD_IDX_MDP_RSZ1,
> +	[MDP_COMP_TDSHP0] = MUTEX_MOD_IDX_MDP_TDSHP0,
> +	[MDP_COMP_WROT0] = MUTEX_MOD_IDX_MDP_WROT0,
> +	[MDP_COMP_WDMA] = MUTEX_MOD_IDX_MDP_WDMA,
> +	[MDP_COMP_AAL0] = MUTEX_MOD_IDX_MDP_AAL0,
> +	[MDP_COMP_CCORR0] = MUTEX_MOD_IDX_MDP_CCORR0,
> +};

I am really not keen on storing variable declarations in a header. This belongs
in a source.

What you typically do is put this in a source together with the declaration
of the mt8183_mdp_driver_data struct for the chip config, and just export that
top-level struct as an extern.

An example of how to do this is drivers/media/platform/verisilicon/imx8m_vpu_hw.c.

Regards,

	Hans

> +
> +#endif  /* __MDP3_PLAT_MT8183_H__ */
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
> index 2d1f6ae9f080..658037d06250 100644
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
> @@ -12,33 +12,10 @@
>  #include <linux/remoteproc.h>
>  #include <linux/remoteproc/mtk_scp.h>
>  #include <media/videobuf2-dma-contig.h>
> +
>  #include "mtk-mdp3-core.h"
>  #include "mtk-mdp3-m2m.h"
> -
> -static const struct mdp_platform_config mt8183_plat_cfg = {
> -	.rdma_support_10bit		= true,
> -	.rdma_rsz1_sram_sharing		= true,
> -	.rdma_upsample_repeat_only	= true,
> -	.rsz_disable_dcm_small_sample	= false,
> -	.wrot_filter_constraint		= false,
> -};
> -
> -static const struct of_device_id mt8183_mdp_probe_infra[MDP_INFRA_MAX] = {
> -	[MDP_INFRA_MMSYS] = { .compatible = "mediatek,mt8183-mmsys" },
> -	[MDP_INFRA_MUTEX] = { .compatible = "mediatek,mt8183-disp-mutex" },
> -	[MDP_INFRA_SCP] = { .compatible = "mediatek,mt8183-scp" }
> -};
> -
> -static const u32 mt8183_mutex_idx[MDP_MAX_COMP_COUNT] = {
> -	[MDP_COMP_RDMA0] = MUTEX_MOD_IDX_MDP_RDMA0,
> -	[MDP_COMP_RSZ0] = MUTEX_MOD_IDX_MDP_RSZ0,
> -	[MDP_COMP_RSZ1] = MUTEX_MOD_IDX_MDP_RSZ1,
> -	[MDP_COMP_TDSHP0] = MUTEX_MOD_IDX_MDP_TDSHP0,
> -	[MDP_COMP_WROT0] = MUTEX_MOD_IDX_MDP_WROT0,
> -	[MDP_COMP_WDMA] = MUTEX_MOD_IDX_MDP_WDMA,
> -	[MDP_COMP_AAL0] = MUTEX_MOD_IDX_MDP_AAL0,
> -	[MDP_COMP_CCORR0] = MUTEX_MOD_IDX_MDP_CCORR0,
> -};
> +#include "mt8183/mdp3-plat-mt8183.h"
>  
>  static const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
>  	.mdp_probe_infra = mt8183_mdp_probe_infra,

