Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36482737D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjFUIPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjFUIP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:15:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B37170D;
        Wed, 21 Jun 2023 01:15:24 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7BCE566028F5;
        Wed, 21 Jun 2023 09:15:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687335323;
        bh=J5+6n5TNhUkGKqSQjVla6pRqh5pugN4fdqYwLgyx+/I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gRy6R3NXbwlRJ7/zTLGBgql+fU1KFe8NjzpTesAxI7C+7PCP+sq0gPejpuSkQWpSP
         6oY5OJrezvn+yeGhsqjrcOAf5x7p67YFUDujj1fSHMukPsp0sTeHWMkF6RfLkQ8f/V
         sJjLkGZMGOrg77wJvJdVXf4qkhqnaVHP4s9lriDX1H7CVrGS9bC12CKfWbcOB6hfvx
         1TGIEhiXPhDPbrsT6yzP+h4ehizua1Nsif8qqbkC3l90hZ3frfTE/0c369rr8aTEoH
         qUi6pZmo4ypylXt7g1EwighX83XZymaB9DezZ1yocTZ4/ulSFOuNDpT2NjqO65HsDy
         PeoBtQYlNvJSw==
Message-ID: <13bd0198-457f-e0fb-89bd-fd6b6954b8b3@collabora.com>
Date:   Wed, 21 Jun 2023 10:15:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 12/14] drm/mediatek: Improve compatibility of display
 driver
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230621031938.5884-1-shawn.sung@mediatek.com>
 <20230621031938.5884-13-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230621031938.5884-13-shawn.sung@mediatek.com>
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

Il 21/06/23 05:19, Hsiao Chien Sung ha scritto:
> - Add new functions to enable/disable components, and
>    reuse them when clock enable/disable
> - Check if the component is defined before using it since
>    some modules are MT8188 only (ex. PADDING)
> - Control components according to its type rather than ID
> - Use a for-loop to add/remove components in an arrays,
>    so we can only maintain this array to make sure every
>    component will be initialized properly
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>   .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 186 +++++++++---------
>   1 file changed, 96 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> index c0a38f5217ee..69ae531294ff 100644
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
> @@ -67,21 +68,78 @@ static const char * const private_comp_stem[OVL_ADAPTOR_TYPE_NUM] = {
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
> +	[OVL_ADAPTOR_ETHDR0] = { OVL_ADAPTOR_TYPE_ETHDR, DDP_COMPONENT_ETHDR_MIXER, 0 },
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
>   };
>   
> +static int mtk_ovl_adaptor_enable(struct device *dev, enum mtk_ovl_adaptor_comp_type type)
> +{
> +	int ret = 0;

int ret;

> +
> +	if (!dev)

if (!dev)
	return -ENODEV;

> +		goto end;
> +
> +	switch (type) {
> +	case OVL_ADAPTOR_TYPE_ETHDR:
> +		ret = mtk_ethdr_clk_enable(dev);
> +		break;
> +	case OVL_ADAPTOR_TYPE_MERGE:
> +		ret = mtk_merge_clk_enable(dev);

We already have a .clk_enable() callback in struct mtk_ddp_comp_funcs: to
greatly enhance your nice cleanup, you could use that instead, which basically
eliminates the need of having any if branch and/or switch.

> +		break;
> +	case OVL_ADAPTOR_TYPE_RDMA:
> +		// only LARB users need to do this

Please, C-style comments only.

> +		ret = pm_runtime_get_sync(dev);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to enable power domain, error(%d)\n", ret);
> +			goto end;
> +		}
> +		ret = mtk_mdp_rdma_clk_enable(dev);
> +		if (ret)
> +			pm_runtime_put(dev);
> +		break;
> +	default:
> +		dev_err(dev, "Unknown type: %d\n", type);

Are we supposed to return 0 for unknown type?!

> +	}
> +
> +	if (ret)
> +		dev_err(dev, "Failed to enable clock: error(%d)\n", ret);

if (ret) {
	dev_err(...)
	return ret;
}

return 0;

> +
> +end:
> +	return ret;
> +}
> +
> +static void mtk_ovl_adaptor_disable(struct device *dev, enum mtk_ovl_adaptor_comp_type type)
> +{
> +	if (!dev)
> +		return;
> +
> +	switch (type) {
> +	case OVL_ADAPTOR_TYPE_ETHDR:
> +		mtk_ethdr_clk_disable(dev);
> +		break;
> +	case OVL_ADAPTOR_TYPE_MERGE:
> +		mtk_merge_clk_disable(dev);
> +		break;
> +	case OVL_ADAPTOR_TYPE_RDMA:
> +		mtk_mdp_rdma_clk_disable(dev);
> +		pm_runtime_put(dev);
> +		break;
> +	default:
> +		dev_err(dev, "Unknown type: %d\n", type);
> +	}
> +}
> +
>   void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
>   				  struct mtk_plane_state *state,
>   				  struct cmdq_pkt *cmdq_pkt)
> @@ -186,72 +244,30 @@ void mtk_ovl_adaptor_stop(struct device *dev)
>   int mtk_ovl_adaptor_clk_enable(struct device *dev)
>   {
>   	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
> -	struct device *comp;
> -	int ret;
> +	int ret = 0;

Keep `int ret;`

>   	int i;
>   
> -	for (i = 0; i < OVL_ADAPTOR_MERGE0; i++) {
> -		comp = ovl_adaptor->ovl_adaptor_comp[i];
> -		ret = pm_runtime_get_sync(comp);
> -		if (ret < 0) {
> -			dev_err(dev, "Failed to enable power domain %d, err %d\n", i, ret);
> -			goto pwr_err;
> -		}
> -	}
> -
>   	for (i = 0; i < OVL_ADAPTOR_ID_MAX; i++) {
> -		comp = ovl_adaptor->ovl_adaptor_comp[i];
> -
> -		if (i < OVL_ADAPTOR_MERGE0)
> -			ret = mtk_mdp_rdma_clk_enable(comp);
> -		else if (i < OVL_ADAPTOR_ETHDR0)
> -			ret = mtk_merge_clk_enable(comp);
> -		else
> -			ret = mtk_ethdr_clk_enable(comp);
> +		ret = mtk_ovl_adaptor_enable(ovl_adaptor->ovl_adaptor_comp[i],
> +					     comp_matches[i].type);
>   		if (ret) {
> -			dev_err(dev, "Failed to enable clock %d, err %d\n", i, ret);
> -			goto clk_err;
> +			while (--i >= 0)
> +				mtk_ovl_adaptor_disable(ovl_adaptor->ovl_adaptor_comp[i],
> +							comp_matches[i].type);
> +			break;

Instead of a break here, just return ret?

>   		}
>   	}
> -
> -	return ret;
> -
> -clk_err:
> -	while (--i >= 0) {
> -		comp = ovl_adaptor->ovl_adaptor_comp[i];
> -		if (i < OVL_ADAPTOR_MERGE0)
> -			mtk_mdp_rdma_clk_disable(comp);
> -		else if (i < OVL_ADAPTOR_ETHDR0)
> -			mtk_merge_clk_disable(comp);
> -		else
> -			mtk_ethdr_clk_disable(comp);
> -	}
> -	i = OVL_ADAPTOR_MERGE0;
> -
> -pwr_err:
> -	while (--i >= 0)
> -		pm_runtime_put(ovl_adaptor->ovl_adaptor_comp[i]);
> -
>   	return ret;

...and return 0 here.

>   }
>   

Regards,
Angelo

