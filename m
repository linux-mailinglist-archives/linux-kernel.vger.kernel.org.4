Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A133C690916
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjBIMmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjBIMmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:42:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C695BA7C;
        Thu,  9 Feb 2023 04:41:58 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1561166020BA;
        Thu,  9 Feb 2023 12:41:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675946516;
        bh=9ZiZO6TQy+6UG16GtB4iYGKykwkEi6tuqIO9D0PiM+A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OGx/LlK/ICf1fItu4WhsFtk9Jk6bVEF7ZUvj5+EU/KXrkWt2Q52OaUSVA83TQGh9X
         sNtFLRFi+Hg0UN7LDNKKgw9pCz4V68Mq9lldnaGO/cBG1G6FTIB/dBOWaTIHdp11sc
         5BuVdLqCe9xhXu09inmLAyaPjE9Gp7RX+vg2YTw+NfJXjQB6wZy0mYI+AUamvLyBgu
         rMRQp9HXO2PIUxcRf6Uo2tEB8Qd8QhoJBLBb5+HqmjrSeKU1SN4YbSlZ6c1eGJy/ab
         udkvTJbMJdI/ILvYIexMzNfFdGrPdYJq+PWT4ddPh6amRozvC9siZl3nvc7WdT2EMR
         7wKMlrWpCak2g==
Message-ID: <a4aa8595-fc7a-06de-ef2d-804dfe2137e2@collabora.com>
Date:   Thu, 9 Feb 2023 13:41:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 07/12] remoteproc: mediatek: Probe multi-core SCP
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
References: <20230209074021.13936-1-tinghan.shen@mediatek.com>
 <20230209074021.13936-8-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230209074021.13936-8-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/02/23 08:40, Tinghan Shen ha scritto:
> The difference of single-core SCP and multi-core SCP device tree is
> the presence of child device nodes described SCP cores. The SCP
> driver populates the platform device and checks the child nodes
> to identify whether it's a single-core SCP or a multi-core SCP.
> 
> The resource structure of the multi-core SCP is a list of remoteproc
> instances which is different to the single-core SCP. The corresponding
> resource releasing action is added based on the type of SCP.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   drivers/remoteproc/mtk_common.h |   7 ++
>   drivers/remoteproc/mtk_scp.c    | 173 ++++++++++++++++++++++++++++----
>   2 files changed, 160 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> index 20c1a90be77d..0b2c4bbb55f0 100644
> --- a/drivers/remoteproc/mtk_common.h
> +++ b/drivers/remoteproc/mtk_common.h
> @@ -119,6 +119,10 @@ struct mtk_scp_of_regs {
>   	phys_addr_t l1tcm_phys;
>   };
>   
> +struct mtk_scp_cluster {
> +	struct list_head cores;
> +};
> +
>   struct mtk_scp {
>   	struct device *dev;
>   	struct rproc *rproc;
> @@ -147,6 +151,9 @@ struct mtk_scp {
>   	size_t dram_size;
>   
>   	struct rproc_subdev *rpmsg_subdev;
> +
> +	struct list_head elem;
> +	struct mtk_scp_cluster *cluster;
>   };
>   
>   /**
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index feebcadd56cd..a25141c6c4cb 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -855,7 +855,9 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
>   }
>   
>   static int scp_rproc_init(struct platform_device *pdev,
> -			  struct mtk_scp_of_regs *of_regs)
> +			  struct mtk_scp_of_regs *of_regs,
> +			  const struct mtk_scp_of_data *of_data,
> +			  struct mtk_scp_cluster *cluster)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct device_node *np = dev->of_node;
> @@ -876,7 +878,8 @@ static int scp_rproc_init(struct platform_device *pdev,
>   	scp = (struct mtk_scp *)rproc->priv;
>   	scp->rproc = rproc;
>   	scp->dev = dev;
> -	scp->data = of_device_get_match_data(dev);
> +	scp->data = of_data;
> +	scp->cluster = cluster;
>   	platform_set_drvdata(pdev, scp);
>   
>   	scp->reg_base = of_regs->reg_base;
> @@ -925,9 +928,13 @@ static int scp_rproc_init(struct platform_device *pdev,
>   		goto remove_subdev;
>   	}
>   
> -	ret = rproc_add(rproc);
> -	if (ret)
> -		goto remove_subdev;
> +	if (scp->cluster) {
> +		list_add_tail(&scp->elem, &scp->cluster->cores);
> +	} else {
> +		ret = rproc_add(rproc);
> +		if (ret)
> +			goto remove_subdev;
> +	}
>   
>   	return 0;
>   
> @@ -943,11 +950,115 @@ static int scp_rproc_init(struct platform_device *pdev,
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
> +static void scp_rproc_exit(void *data)
> +{
> +	struct mtk_scp *scp = platform_get_drvdata(data);
> +
> +	rproc_del(scp->rproc);
> +	scp_rproc_free(scp);
> +}
> +
> +static int scp_cluster_init(struct platform_device *pdev,
> +			    struct mtk_scp_of_regs *of_regs)
> +{
> +	struct mtk_scp_cluster *cluster = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev_of_node(dev);
> +	struct platform_device *cpdev;
> +	struct device_node *child;
> +	const struct mtk_scp_of_data **cluster_of_data;
> +	struct mtk_scp *scp, *temp;
> +	int core_id, num_cores;
> +	int ret;
> +
> +	cluster_of_data = (const struct mtk_scp_of_data **)of_device_get_match_data(dev);
> +
> +	for (num_cores = 0; cluster_of_data[num_cores]; num_cores++)
> +		;
> +
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
> +		ret = scp_rproc_init(cpdev, of_regs, cluster_of_data[core_id], cluster);
> +		put_device(&cpdev->dev);
> +		if (ret) {
> +			dev_err(dev, "Failed to initialize core %d rproc\n", core_id);
> +			of_node_put(child);
> +			goto init_fail;
> +		}
> +
> +		of_node_put(child);
> +		core_id++;
> +	}
> +
> +	list_for_each_entry_safe_reverse(scp, temp, &cluster->cores, elem) {
> +		ret = rproc_add(scp->rproc);
> +		if (ret)
> +			goto add_fail;
> +	}
> +
> +	return 0;
> +
> +add_fail:
> +	list_for_each_entry_continue(scp, &cluster->cores, elem) {
> +		rproc_del(scp->rproc);
> +	}
> +init_fail:
> +	list_for_each_entry_safe_reverse(scp, temp, &cluster->cores, elem) {
> +		list_del(&scp->elem);
> +		cpdev = to_platform_device(scp->dev);
> +		scp_rproc_free(scp);
> +	}
> +	return ret;
> +}
> +
> +static void scp_cluster_exit(void *data)
> +{
> +	struct mtk_scp_cluster *cluster = platform_get_drvdata(data);
> +	struct platform_device *cpdev;
> +	struct mtk_scp *scp, *temp;
> +
> +	list_for_each_entry_safe_reverse(scp, temp, &cluster->cores, elem) {
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
> +	struct mtk_scp_cluster *cluster;
>   	int ret;
>   
>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> @@ -968,23 +1079,39 @@ static int scp_probe(struct platform_device *pdev)
>   		scp_regs.l1tcm_phys = res->start;
>   	}
>   
> -	return scp_rproc_init(pdev, of_device_get_match_data(dev), &scp_regs);
> -}
> +	ret = devm_of_platform_populate(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to populate platform devices\n");
>   
> -static int scp_remove(struct platform_device *pdev)
> -{
> -	struct mtk_scp *scp = platform_get_drvdata(pdev);
> -	int i;
> +	core_node = of_get_child_by_name(np, "scp");
> +	of_node_put(core_node);
>   
> -	rproc_del(scp->rproc);
> -	scp_remove_rpmsg_subdev(scp);
> -	scp_ipi_unregister(scp, SCP_IPI_INIT);
> -	scp_unmap_memory_region(scp);
> -	for (i = 0; i < SCP_IPI_MAX; i++)
> -		mutex_destroy(&scp->ipi_desc[i].lock);
> -	mutex_destroy(&scp->send_lock);
> +	if (!core_node) {
> +		dev_info(dev, "single-core scp\n");
>   
> -	return 0;
> +		ret = scp_rproc_init(pdev, &scp_regs, of_device_get_match_data(dev), NULL);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to init single core scp\n");
> +
> +		ret = devm_add_action_or_reset(dev, scp_rproc_exit, pdev);
> +	} else {
> +		dev_info(dev, "multi-core scp\n");
> +
> +		cluster = devm_kzalloc(dev, sizeof(*cluster), GFP_KERNEL);
> +		if (!cluster)
> +			return dev_err_probe(dev, -ENOMEM, "Unable to allocate scp cluster\n");
> +
> +		INIT_LIST_HEAD(&cluster->cores);
> +		platform_set_drvdata(pdev, cluster);
> +
> +		ret = scp_cluster_init(pdev, &scp_regs);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to initialize scp cluster\n");
> +
> +		ret = devm_add_action_or_reset(dev, scp_cluster_exit, pdev);
> +	}
> +
> +	return ret;
>   }
>   
>   static const struct mtk_scp_of_data mt8183_of_data = {
> @@ -1061,19 +1188,25 @@ static const struct mtk_scp_of_data mt8195_of_data_c1 = {
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
>   
>   static struct platform_driver mtk_scp_driver = {
>   	.probe = scp_probe,
> -	.remove = scp_remove,

I'm sorry, but this is unacceptable: you're removing any ability to remove this
device (read: to unload, if module, or to remove from sysfs, if builtin).

Please fix that.

Regards,
Angelo

>   	.driver = {
>   		.name = "mtk-scp",
>   		.of_match_table = mtk_scp_of_match,

