Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9258697BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjBOM3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBOM3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:29:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1B336446;
        Wed, 15 Feb 2023 04:29:05 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DC18C6602193;
        Wed, 15 Feb 2023 12:29:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676464143;
        bh=WN5KFfVxspp0n9FETRjSp4FseprWdAvg7PmlHOmIOx0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OahlZnfc5QdgrlNeNrP8UDreZQCHyTo5ZWNrC9nQ6k9yY0AAt49dB7xNaPt+4r67d
         HGYr75yHOu1XEJDPUXheAilFVYXXKbPhjbjZ7MLQShoApbp5cpm879FUXacIwHyyNo
         KCDqVTOgKmsbmp45ETotMF+kaizptGg4NxDwyYU/vAuV2aopLm6XaTL4bsz/n4M2RU
         WzwsFkBHzr1+njff/cN+j537ftmgkfY9cVEd6Bo6wL7/bc8CzaGGD3QCAxPtKVAxbe
         SkROXRzR8YxCrJSCbbp3zwrmrOt8FlQuUjQ0uwPaGEqUWX1B5oYn2pjWdp4w8+0BBw
         YsqrOIcAR4fVw==
Message-ID: <1fb45a25-38e9-d9cf-6c69-0ba0dac83824@collabora.com>
Date:   Wed, 15 Feb 2023 13:29:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v7 07/12] remoteproc: mediatek: Probe multi-core SCP
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230215041257.14548-1-tinghan.shen@mediatek.com>
 <20230215041257.14548-8-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230215041257.14548-8-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/02/23 05:12, Tinghan Shen ha scritto:
> The difference of single-core SCP and multi-core SCP device tree is
> the presence of child device nodes described SCP cores. The SCP
> driver populates the platform device and checks the child nodes
> to identify whether it's a single-core SCP or a multi-core SCP.
> 
> The resource structure of the multi-core SCP is a list of remoteproc
> instances which is different to the single-core SCP. The corresponding
> resource releasing action is based on the type of SCP.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   drivers/remoteproc/mtk_common.h |   4 +
>   drivers/remoteproc/mtk_scp.c    | 179 +++++++++++++++++++++++++++++---
>   2 files changed, 168 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> index 3778894c96f3..7821cb15d6fd 100644
> --- a/drivers/remoteproc/mtk_common.h
> +++ b/drivers/remoteproc/mtk_common.h
> @@ -140,6 +140,10 @@ struct mtk_scp {
>   	size_t dram_size;
>   
>   	struct rproc_subdev *rpmsg_subdev;
> +
> +	struct list_head elem;
> +	struct list_head cluster_cores;
> +	struct list_head *cluster;

I don't understand why you need both `cluster_cores` and `cluster`... check below.

>   };
>   
>   /**
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index 6270c388727a..6588e5acb159 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -862,7 +862,9 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
>   }
>   
>   static int scp_rproc_init(struct platform_device *pdev,
> -			  struct mtk_scp_of_regs *of_regs)
> +			  struct mtk_scp_of_regs *of_regs,
> +			  const struct mtk_scp_of_data *of_data,
> +			  bool is_multi_core)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct device_node *np = dev->of_node;
> @@ -883,7 +885,7 @@ static int scp_rproc_init(struct platform_device *pdev,
>   	scp = (struct mtk_scp *)rproc->priv;
>   	scp->rproc = rproc;
>   	scp->dev = dev;
> -	scp->data = of_device_get_match_data(dev);
> +	scp->data = of_data;
>   	platform_set_drvdata(pdev, scp);
>   
>   	scp->reg_base = of_regs->reg_base;
> @@ -932,9 +934,11 @@ static int scp_rproc_init(struct platform_device *pdev,
>   		goto remove_subdev;
>   	}
>   
> -	ret = rproc_add(rproc);
> -	if (ret)
> -		goto remove_subdev;
> +	if (!is_multi_core) {
> +		ret = rproc_add(rproc);
> +		if (ret)
> +			goto remove_subdev;
> +	}
>   
>   	return 0;
>   
> @@ -950,9 +954,125 @@ static int scp_rproc_init(struct platform_device *pdev,
>   	return ret;
>   }
>   
> +static void scp_rproc_free(struct mtk_scp *scp)
> +{
> +	int i;
> +
> +	scp_remove_rpmsg_subdev(scp);
> +	scp_ipi_unregister(scp, SCP_IPI_INIT);
> +	scp_unmap_memory_region(scp);
> +	for (i = 0; i < SCP_IPI_MAX; i++)
> +		mutex_destroy(&scp->ipi_desc[i].lock);
> +	mutex_destroy(&scp->send_lock);
> +}
> +
> +static void scp_rproc_exit(struct platform_device *pdev)
> +{
> +	struct mtk_scp *scp = platform_get_drvdata(pdev);
> +
> +	rproc_del(scp->rproc);
> +	scp_rproc_free(scp);
> +}
> +
> +static int scp_cluster_init(struct platform_device *pdev,
> +			    struct mtk_scp_of_regs *of_regs)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev_of_node(dev);
> +	struct platform_device *cpdev;
> +	struct device_node *child;
> +	const struct mtk_scp_of_data **cluster_of_data;
> +	struct list_head *cluster;

Here you have a local `cluster` pointer.....

> +	struct mtk_scp *scp, *temp;
> +	int core_id, num_cores;
> +	int ret;
> +
> +	cluster_of_data = (const struct mtk_scp_of_data **)of_device_get_match_data(dev);
> +
> +	for (num_cores = 0; cluster_of_data[num_cores]; num_cores++)
> +		;
> +
> +	cluster = NULL;

(unrelated: please initialize cluster and core_id on the declaration, not here)

> +	core_id = 0;
> +	for_each_available_child_of_node(np, child) {
> +		if (core_id >= num_cores) {
> +			ret = -EINVAL;
> +			dev_err(dev, "Not support core %d\n", core_id);
> +			of_node_put(child);
> +			goto init_fail;
> +		}
> +
> +		cpdev = of_find_device_by_node(child);
> +		if (!cpdev) {
> +			ret = -ENODEV;
> +			dev_err(dev, "Not found platform device for core %d\n", core_id);
> +			of_node_put(child);
> +			goto init_fail;
> +		}
> +
> +		ret = scp_rproc_init(cpdev, of_regs, cluster_of_data[core_id], true);
> +		if (ret) {
> +			dev_err(dev, "Failed to initialize core %d rproc\n", core_id);
> +			put_device(&cpdev->dev);
> +			of_node_put(child);
> +			goto init_fail;
> +		}
> +
> +		scp = platform_get_drvdata(cpdev);
> +		put_device(&cpdev->dev);
> +		if (core_id == 0) {
> +			INIT_LIST_HEAD(&scp->cluster_cores);

...then here you initialize cluster_cores,

> +			cluster = &scp->cluster_cores;

and assign to your local `cluster` pointer and even set it

> +			platform_set_drvdata(pdev, cluster);

as platform drvdata.

> +		}
> +
> +		list_add_tail(&scp->elem, cluster);

Still using the local `cluster` pointer, which is `scp->cluster_cores`

> +		scp->cluster = cluster;

...and here, `scp->cluster` effectively points to local `cluster`, which is
anyway `scp->cluster_cores`.

As far as I understand, `scp->cluster` is EITHER `scp->cluster_cores` or NULL,
hence the question: why do you need both scp->cluster and scp->cluster_cores,
if they're always pointing to the same list?

P.S.: I won't cut the rest of the patch so that the readers of this reply won't
       have to click around to see the whole code; comments end here!

Regards,
Angelo

> +
> +		of_node_put(child);
> +		core_id++;
> +	}
> +
> +	list_for_each_entry_safe_reverse(scp, temp, cluster, elem) {
> +		ret = rproc_add(scp->rproc);
> +		if (ret)
> +			goto add_fail;
> +	}
> +
> +	return 0;
> +
> +add_fail:
> +	list_for_each_entry_continue(scp, cluster, elem) {
> +		rproc_del(scp->rproc);
> +	}
> +init_fail:
> +	if (cluster) {
> +		list_for_each_entry_safe_reverse(scp, temp, cluster, elem) {
> +			list_del(&scp->elem);
> +			scp_rproc_free(scp);
> +		}
> +	}
> +	return ret;
> +}
> +
> +static void scp_cluster_exit(struct platform_device *pdev)
> +{
> +	struct list_head *cluster = platform_get_drvdata(pdev);
> +	struct platform_device *cpdev;
> +	struct mtk_scp *scp, *temp;
> +
> +	list_for_each_entry_safe_reverse(scp, temp, cluster, elem) {
> +		list_del(&scp->elem);
> +		cpdev = to_platform_device(scp->dev);
> +		scp_rproc_exit(cpdev);
> +	}
> +}
> +
>   static int scp_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *core_node;
>   	struct resource *res;
>   	struct mtk_scp_of_regs scp_regs;
>   	int ret;
> @@ -975,21 +1095,43 @@ static int scp_probe(struct platform_device *pdev)
>   		scp_regs.l1tcm_phys = res->start;
>   	}
>   
> -	return scp_rproc_init(pdev, &scp_regs);
> +	ret = devm_of_platform_populate(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to populate platform devices\n");
> +
> +	core_node = of_get_child_by_name(np, "scp");
> +	of_node_put(core_node);
> +
> +	if (!core_node) {
> +		dev_info(dev, "single-core scp\n");
> +
> +		ret = scp_rproc_init(pdev, &scp_regs, of_device_get_match_data(dev), false);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to initialize single-core scp\n");
> +	} else {
> +		dev_info(dev, "multi-core scp\n");
> +
> +		ret = scp_cluster_init(pdev, &scp_regs);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to initialize scp cluster\n");
> +	}
> +
> +	return 0;
>   }
>   
>   static int scp_remove(struct platform_device *pdev)
>   {
> -	struct mtk_scp *scp = platform_get_drvdata(pdev);
> -	int i;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *core_node;
>   
> -	rproc_del(scp->rproc);
> -	scp_remove_rpmsg_subdev(scp);
> -	scp_ipi_unregister(scp, SCP_IPI_INIT);
> -	scp_unmap_memory_region(scp);
> -	for (i = 0; i < SCP_IPI_MAX; i++)
> -		mutex_destroy(&scp->ipi_desc[i].lock);
> -	mutex_destroy(&scp->send_lock);
> +	core_node = of_get_child_by_name(np, "scp");
> +	of_node_put(core_node);
> +
> +	if (!core_node)
> +		scp_rproc_exit(pdev);
> +	else
> +		scp_cluster_exit(pdev);
>   
>   	return 0;
>   }
> @@ -1068,12 +1210,19 @@ static const struct mtk_scp_of_data mt8195_of_data_c1 = {
>   	.host_to_scp_int_bit = MT8195_CORE1_HOST_IPC_INT_BIT,
>   };
>   
> +static const struct mtk_scp_of_data *mt8195_of_data_cores[] = {
> +	&mt8195_of_data,
> +	&mt8195_of_data_c1,
> +	NULL
> +};
> +
>   static const struct of_device_id mtk_scp_of_match[] = {
>   	{ .compatible = "mediatek,mt8183-scp", .data = &mt8183_of_data },
>   	{ .compatible = "mediatek,mt8186-scp", .data = &mt8186_of_data },
>   	{ .compatible = "mediatek,mt8188-scp", .data = &mt8188_of_data },
>   	{ .compatible = "mediatek,mt8192-scp", .data = &mt8192_of_data },
>   	{ .compatible = "mediatek,mt8195-scp", .data = &mt8195_of_data },
> +	{ .compatible = "mediatek,mt8195-scp-dual", .data = &mt8195_of_data_cores },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, mtk_scp_of_match);

