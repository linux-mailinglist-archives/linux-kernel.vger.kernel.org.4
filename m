Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E466172554B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbjFGHUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjFGHUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:20:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D3AE6B;
        Wed,  7 Jun 2023 00:20:47 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AB9656606EB0;
        Wed,  7 Jun 2023 08:20:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686122446;
        bh=+R9Eac8qL+CkGEomVQfd5/Ibupum86jE8cJumdRnAOY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Vb5AkpuRvQ9Ss/kInfEA5e1k11US368QrGPYd+tckDeaikPdqNhF0ME5gFks83360
         kuqrcTTPml8LZVQdwewNqv8rScSMwt1j+gedz0peJGIz5S2oOWmgM+7O+W3VyhOfsJ
         jpkx5krGWL0kRIOnvHW2IqQUYRFTBt4Dlo5aAThmM6Ymt7KOt2RqzbgXlU1kkseBiF
         DthxNtBJ7k8+G/DRTW+HbPeGb3PI3oynm0mnyq/Nh1182ewUoTVcr0E4Fy2baY5kqJ
         fpV+pXL/rRKPYAkaHVjzx+hs6+CLUoO5nKTQotX/2+9Wt3AuL1xcOFNJX9/iR6i0/C
         2qt0HfetMYV5Q==
Message-ID: <30c082f5-b367-f782-8080-d64423098f5c@collabora.com>
Date:   Wed, 7 Jun 2023 09:20:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 4/6] drm/mediatek: mt8188: Modify display driver for
 VDOSYS1
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Fei Shao <fshao@google.com>
References: <20230607061121.6732-1-shawn.sung@mediatek.com>
 <20230607061121.6732-5-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230607061121.6732-5-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/06/23 08:11, Hsiao Chien Sung ha scritto:
> - Modify MUTEX and component preparation logic for better compatibility
> - Adjust display module probe sequence to avoid probe deferral

Please split this in two commits, one modifying mutex/component preparation
logic, and one optimizing the probe sequence.

Also, you're adding MT8188 compatible strings without mentioning that anywhere.

Thanks,
Angelo

> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_disp_merge.c     |   3 +-
>   .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 100 ++++++++++--------
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  28 ++++-
>   drivers/gpu/drm/mediatek/mtk_ethdr.c          |   1 +
>   drivers/gpu/drm/mediatek/mtk_mdp_rdma.c       |   1 +
>   5 files changed, 84 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_merge.c b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
> index 6428b6203ffe..2a30e41c246f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_merge.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
> @@ -104,7 +104,7 @@ void mtk_merge_stop_cmdq(struct device *dev, struct cmdq_pkt *cmdq_pkt)
>   	mtk_ddp_write(cmdq_pkt, 0, &priv->cmdq_reg, priv->regs,
>   		      DISP_REG_MERGE_CTRL);
> 
> -	if (priv->async_clk)
> +	if (!cmdq_pkt && priv->async_clk)
>   		reset_control_reset(priv->reset_ctl);
>   }
> 
> @@ -303,6 +303,7 @@ static int mtk_disp_merge_remove(struct platform_device *pdev)
>   }
> 
>   static const struct of_device_id mtk_disp_merge_driver_dt_match[] = {
> +	{ .compatible = "mediatek,mt8188-disp-merge", },
>   	{ .compatible = "mediatek,mt8195-disp-merge", },
>   	{},
>   };
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> index c0a38f5217ee..e1d8d4765af8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> @@ -51,6 +51,7 @@ enum mtk_ovl_adaptor_comp_id {
> 
>   struct ovl_adaptor_comp_match {
>   	enum mtk_ovl_adaptor_comp_type type;
> +	enum mtk_ddp_comp_id comp_id;
>   	int alias_id;
>   };
> 
> @@ -67,19 +68,19 @@ static const char * const private_comp_stem[OVL_ADAPTOR_TYPE_NUM] = {
>   };
> 
>   static const struct ovl_adaptor_comp_match comp_matches[OVL_ADAPTOR_ID_MAX] = {
> -	[OVL_ADAPTOR_MDP_RDMA0]	= { OVL_ADAPTOR_TYPE_RDMA, 0 },
> -	[OVL_ADAPTOR_MDP_RDMA1]	= { OVL_ADAPTOR_TYPE_RDMA, 1 },
> -	[OVL_ADAPTOR_MDP_RDMA2]	= { OVL_ADAPTOR_TYPE_RDMA, 2 },
> -	[OVL_ADAPTOR_MDP_RDMA3]	= { OVL_ADAPTOR_TYPE_RDMA, 3 },
> -	[OVL_ADAPTOR_MDP_RDMA4]	= { OVL_ADAPTOR_TYPE_RDMA, 4 },
> -	[OVL_ADAPTOR_MDP_RDMA5]	= { OVL_ADAPTOR_TYPE_RDMA, 5 },
> -	[OVL_ADAPTOR_MDP_RDMA6]	= { OVL_ADAPTOR_TYPE_RDMA, 6 },
> -	[OVL_ADAPTOR_MDP_RDMA7]	= { OVL_ADAPTOR_TYPE_RDMA, 7 },
> -	[OVL_ADAPTOR_MERGE0]	= { OVL_ADAPTOR_TYPE_MERGE, 1 },
> -	[OVL_ADAPTOR_MERGE1]	= { OVL_ADAPTOR_TYPE_MERGE, 2 },
> -	[OVL_ADAPTOR_MERGE2]	= { OVL_ADAPTOR_TYPE_MERGE, 3 },
> -	[OVL_ADAPTOR_MERGE3]	= { OVL_ADAPTOR_TYPE_MERGE, 4 },
> -	[OVL_ADAPTOR_ETHDR0]	= { OVL_ADAPTOR_TYPE_ETHDR, 0 },
> +	[OVL_ADAPTOR_MDP_RDMA0] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA0, 0 },
> +	[OVL_ADAPTOR_MDP_RDMA1] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA1, 1 },
> +	[OVL_ADAPTOR_MDP_RDMA2] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA2, 2 },
> +	[OVL_ADAPTOR_MDP_RDMA3] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA3, 3 },
> +	[OVL_ADAPTOR_MDP_RDMA4] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA4, 4 },
> +	[OVL_ADAPTOR_MDP_RDMA5] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA5, 5 },
> +	[OVL_ADAPTOR_MDP_RDMA6] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA6, 6 },
> +	[OVL_ADAPTOR_MDP_RDMA7] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA7, 7 },
> +	[OVL_ADAPTOR_MERGE0] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE1, 1 },
> +	[OVL_ADAPTOR_MERGE1] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE2, 2 },
> +	[OVL_ADAPTOR_MERGE2] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE3, 3 },
> +	[OVL_ADAPTOR_MERGE3] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE4, 4 },
> +	[OVL_ADAPTOR_ETHDR0] = { OVL_ADAPTOR_TYPE_ETHDR, DDP_COMPONENT_ETHDR_MIXER, 0 },
>   };
> 
>   void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
> @@ -192,6 +193,8 @@ int mtk_ovl_adaptor_clk_enable(struct device *dev)
> 
>   	for (i = 0; i < OVL_ADAPTOR_MERGE0; i++) {
>   		comp = ovl_adaptor->ovl_adaptor_comp[i];
> +		if (!comp)
> +			continue;
>   		ret = pm_runtime_get_sync(comp);
>   		if (ret < 0) {
>   			dev_err(dev, "Failed to enable power domain %d, err %d\n", i, ret);
> @@ -201,7 +204,8 @@ int mtk_ovl_adaptor_clk_enable(struct device *dev)
> 
>   	for (i = 0; i < OVL_ADAPTOR_ID_MAX; i++) {
>   		comp = ovl_adaptor->ovl_adaptor_comp[i];
> -
> +		if (!comp)
> +			continue;
>   		if (i < OVL_ADAPTOR_MERGE0)
>   			ret = mtk_mdp_rdma_clk_enable(comp);
>   		else if (i < OVL_ADAPTOR_ETHDR0)
> @@ -219,6 +223,8 @@ int mtk_ovl_adaptor_clk_enable(struct device *dev)
>   clk_err:
>   	while (--i >= 0) {
>   		comp = ovl_adaptor->ovl_adaptor_comp[i];
> +		if (!comp)
> +			continue;
>   		if (i < OVL_ADAPTOR_MERGE0)
>   			mtk_mdp_rdma_clk_disable(comp);
>   		else if (i < OVL_ADAPTOR_ETHDR0)
> @@ -229,8 +235,12 @@ int mtk_ovl_adaptor_clk_enable(struct device *dev)
>   	i = OVL_ADAPTOR_MERGE0;
> 
>   pwr_err:
> -	while (--i >= 0)
> -		pm_runtime_put(ovl_adaptor->ovl_adaptor_comp[i]);
> +	while (--i >= 0) {
> +		comp = ovl_adaptor->ovl_adaptor_comp[i];
> +		if (!comp)
> +			continue;
> +		pm_runtime_put(comp);
> +	}
> 
>   	return ret;
>   }
> @@ -243,7 +253,8 @@ void mtk_ovl_adaptor_clk_disable(struct device *dev)
> 
>   	for (i = 0; i < OVL_ADAPTOR_ID_MAX; i++) {
>   		comp = ovl_adaptor->ovl_adaptor_comp[i];
> -
> +		if (!comp)
> +			continue;
>   		if (i < OVL_ADAPTOR_MERGE0) {
>   			mtk_mdp_rdma_clk_disable(comp);
>   			pm_runtime_put(comp);
> @@ -313,36 +324,26 @@ size_t mtk_ovl_adaptor_get_num_formats(struct device *dev)
> 
>   void mtk_ovl_adaptor_add_comp(struct device *dev, struct mtk_mutex *mutex)
>   {
> -	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA0);
> -	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA1);
> -	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA2);
> -	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA3);
> -	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA4);
> -	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA5);
> -	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA6);
> -	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA7);
> -	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MERGE1);
> -	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MERGE2);
> -	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MERGE3);
> -	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MERGE4);
> -	mtk_mutex_add_comp(mutex, DDP_COMPONENT_ETHDR_MIXER);
> +	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
> +	int i;
> +
> +	for (i = 0; i < OVL_ADAPTOR_ID_MAX; i++) {
> +		if (!ovl_adaptor->ovl_adaptor_comp[i])
> +			continue;
> +		mtk_mutex_add_comp(mutex, comp_matches[i].comp_id);
> +	}
>   }
> 
>   void mtk_ovl_adaptor_remove_comp(struct device *dev, struct mtk_mutex *mutex)
>   {
> -	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA0);
> -	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA1);
> -	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA2);
> -	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA3);
> -	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA4);
> -	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA5);
> -	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA6);
> -	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA7);
> -	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MERGE1);
> -	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MERGE2);
> -	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MERGE3);
> -	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MERGE4);
> -	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_ETHDR_MIXER);
> +	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
> +	int i;
> +
> +	for (i = 0; i < OVL_ADAPTOR_ID_MAX; i++) {
> +		if (!ovl_adaptor->ovl_adaptor_comp[i])
> +			continue;
> +		mtk_mutex_remove_comp(mutex, comp_matches[i].comp_id);
> +	}
>   }
> 
>   void mtk_ovl_adaptor_connect(struct device *dev, struct device *mmsys_dev, unsigned int next)
> @@ -386,6 +387,15 @@ static int ovl_adaptor_comp_get_id(struct device *dev, struct device_node *node,
> 
>   static const struct of_device_id mtk_ovl_adaptor_comp_dt_ids[] = {
>   	{
> +		.compatible = "mediatek,mt8188-vdo1-rdma",
> +		.data = (void *)OVL_ADAPTOR_TYPE_RDMA,
> +	}, {
> +		.compatible = "mediatek,mt8188-disp-merge",
> +		.data = (void *)OVL_ADAPTOR_TYPE_MERGE,
> +	}, {
> +		.compatible = "mediatek,mt8188-disp-ethdr",
> +		.data = (void *)OVL_ADAPTOR_TYPE_ETHDR,
> +	}, {
>   		.compatible = "mediatek,mt8195-vdo1-rdma",
>   		.data = (void *)OVL_ADAPTOR_TYPE_RDMA,
>   	}, {
> @@ -466,6 +476,9 @@ static int mtk_disp_ovl_adaptor_comp_bind(struct device *dev, struct device *mas
>   static void mtk_disp_ovl_adaptor_comp_unbind(struct device *dev, struct device *master,
>   					     void *data)
>   {
> +	struct mtk_disp_ovl_adaptor *priv = dev_get_drvdata(dev);
> +
> +	priv->children_bound = false;
>   }
> 
>   static const struct component_ops mtk_disp_ovl_adaptor_comp_ops = {
> @@ -483,6 +496,7 @@ static int mtk_disp_ovl_adaptor_master_bind(struct device *dev)
>   		return dev_err_probe(dev, ret, "component_bind_all failed!\n");
> 
>   	priv->children_bound = true;
> +
>   	return 0;
>   }
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 6dcb4ba2466c..87dadd129c22 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -188,6 +188,12 @@ static const unsigned int mt8188_mtk_ddp_main[] = {
>   	DDP_COMPONENT_DP_INTF0,
>   };
> 
> +static const unsigned int mt8188_mtk_ddp_ext[] = {
> +	DDP_COMPONENT_DRM_OVL_ADAPTOR,
> +	DDP_COMPONENT_MERGE5,
> +	DDP_COMPONENT_DP_INTF1,
> +};
> +
>   static const unsigned int mt8192_mtk_ddp_main[] = {
>   	DDP_COMPONENT_OVL0,
>   	DDP_COMPONENT_OVL_2L0,
> @@ -287,6 +293,14 @@ static const struct mtk_mmsys_driver_data mt8186_mmsys_driver_data = {
>   static const struct mtk_mmsys_driver_data mt8188_vdosys0_driver_data = {
>   	.main_path = mt8188_mtk_ddp_main,
>   	.main_len = ARRAY_SIZE(mt8188_mtk_ddp_main),
> +	.mmsys_dev_num = 2,
> +};
> +
> +static const struct mtk_mmsys_driver_data mt8188_vdosys1_driver_data = {
> +	.ext_path = mt8188_mtk_ddp_ext,
> +	.ext_len = ARRAY_SIZE(mt8188_mtk_ddp_ext),
> +	.mmsys_id = 1,
> +	.mmsys_dev_num = 2,
>   };
> 
>   static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
> @@ -327,6 +341,8 @@ static const struct of_device_id mtk_drm_of_ids[] = {
>   	  .data = &mt8186_mmsys_driver_data},
>   	{ .compatible = "mediatek,mt8188-vdosys0",
>   	  .data = &mt8188_vdosys0_driver_data},
> +	{ .compatible = "mediatek,mt8188-vdosys1",
> +	  .data = &mt8188_vdosys1_driver_data},
>   	{ .compatible = "mediatek,mt8192-mmsys",
>   	  .data = &mt8192_mmsys_driver_data},
>   	{ .compatible = "mediatek,mt8195-mmsys",
> @@ -682,6 +698,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
>   	  .data = (void *)MTK_DISP_GAMMA, },
>   	{ .compatible = "mediatek,mt8183-disp-gamma",
>   	  .data = (void *)MTK_DISP_GAMMA, },
> +	{ .compatible = "mediatek,mt8188-disp-merge",
> +	  .data = (void *)MTK_DISP_MERGE },
>   	{ .compatible = "mediatek,mt8195-disp-merge",
>   	  .data = (void *)MTK_DISP_MERGE },
>   	{ .compatible = "mediatek,mt2701-disp-mutex",
> @@ -965,15 +983,15 @@ static struct platform_driver * const mtk_drm_drivers[] = {
>   	&mtk_disp_ccorr_driver,
>   	&mtk_disp_color_driver,
>   	&mtk_disp_gamma_driver,
> +	&mtk_disp_rdma_driver,
> +	&mtk_mdp_rdma_driver,
>   	&mtk_disp_merge_driver,
> -	&mtk_disp_ovl_adaptor_driver,
> +	&mtk_ethdr_driver,
>   	&mtk_disp_ovl_driver,
> -	&mtk_disp_rdma_driver,
> +	&mtk_disp_ovl_adaptor_driver,
> +	&mtk_dsi_driver,
>   	&mtk_dpi_driver,
>   	&mtk_drm_platform_driver,
> -	&mtk_dsi_driver,
> -	&mtk_ethdr_driver,
> -	&mtk_mdp_rdma_driver,
>   };
> 
>   static int __init mtk_drm_init(void)
> diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
> index 73dc4da3ba3b..b5a6b67f2db9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
> +++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
> @@ -353,6 +353,7 @@ static int mtk_ethdr_remove(struct platform_device *pdev)
>   }
> 
>   static const struct of_device_id mtk_ethdr_driver_dt_match[] = {
> +	{ .compatible = "mediatek,mt8188-disp-ethdr"},
>   	{ .compatible = "mediatek,mt8195-disp-ethdr"},
>   	{},
>   };
> diff --git a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
> index e06db6e56b5f..06d5c9abb515 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
> @@ -323,6 +323,7 @@ static int mtk_mdp_rdma_remove(struct platform_device *pdev)
>   }
> 
>   static const struct of_device_id mtk_mdp_rdma_driver_dt_match[] = {
> +	{ .compatible = "mediatek,mt8188-vdo1-rdma", },
>   	{ .compatible = "mediatek,mt8195-vdo1-rdma", },
>   	{},
>   };
> --
> 2.18.0
> 

