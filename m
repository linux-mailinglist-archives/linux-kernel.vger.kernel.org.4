Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F72C6F3A72
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 00:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjEAWbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 18:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjEAWbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 18:31:11 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA84935B0
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 15:31:06 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-24de9c66559so1523452a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 15:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682980266; x=1685572266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2mbpKRY/IaHURPbi8xdkp6Ux75t8HAEwDPxIJfytoY=;
        b=MydnFHypJbySOooSNZ9ETF/1six5mxjw+FHQ/I0otqcS1LXMwfEvVXYaQ84i5fkAHQ
         mIOXyOYXsS53MNOAMHN4W27MqHBITLQpmtr6GE+UoofZVIPqMfrC+P0l+HJ2maZ6YrjK
         xoTJuPWVM8p8d4jiwCPNIeWShoFKXuKJWx0D9Vq59m6C/IvKIhEKDjWfXzIADkq3GEiN
         HEX62ptt5RPbRgwl49ncfXRC26rWw1WJVdblIw4dFUE0+PJB/VyOnrnCV/TeaP6Iz1np
         6z2bPR/6HNftXXyudyR7nKPh0CxerIyZg6TsNLxxmbqeV8KV4yKCdUlBOj/AhOacGO2P
         Xttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682980266; x=1685572266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2mbpKRY/IaHURPbi8xdkp6Ux75t8HAEwDPxIJfytoY=;
        b=QWMnduqKkAP87FYZe/YDrRFvnUozfN8tcTM+B8ofirNwgmnbnxVXub4yDavxaa8tIM
         kZ+HBhDCnf3GpoXpQcL2yGZx5SDtLS08pjxwFYXefIpzWDChYfnMcIgfGrcCXJaqmwAA
         EikNmO/nDUDOroB/R1g4XWVzc8gIDQY+atKqYtsrAgZr5h68YtQfIOTQ4I3vancs38hW
         gU/qdatPQ/3nYVwNYVR85HM+6zy/1EeNMxa521Z5KJbQr1lQqK5yaglhGTKBtihspgW7
         kIBv7A8OJu2OM135qLYJkiwqzzB0hjjst5vL+YvE8fP8DVkolROEY/FtIxd6Jg1rmOz+
         3jWg==
X-Gm-Message-State: AC+VfDwm/FqVSUwNttwEup18FByCGO2cZNdplJZ11W/ayKzLXVVZxR6A
        becSHlfpr4AdfmLdN0j4ZedgSA==
X-Google-Smtp-Source: ACHHUZ4pCZfkOETLVMCNCYFPb2sUFVmgge5RUxvMRnpMtAoB0d+G3DquSEMud4Mw95ryPYROdal3lg==
X-Received: by 2002:a17:90a:bd02:b0:23d:1143:c664 with SMTP id y2-20020a17090abd0200b0023d1143c664mr15870863pjr.31.1682980266099;
        Mon, 01 May 2023 15:31:06 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:2609:c92d:9942:6f79])
        by smtp.gmail.com with ESMTPSA id gw13-20020a17090b0a4d00b002470b9503desm19672979pjb.55.2023.05.01.15.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 15:31:05 -0700 (PDT)
Date:   Mon, 1 May 2023 16:31:03 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v10 06/11] remoteproc: mediatek: Probe multi-core SCP
Message-ID: <ZFA9p2feS7Kiwkqh@p14s>
References: <20230426091211.21557-1-tinghan.shen@mediatek.com>
 <20230426091211.21557-7-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426091211.21557-7-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 05:12:06PM +0800, Tinghan Shen wrote:
> The difference of single-core SCP and multi-core SCP device tree is
> the presence of child device nodes described SCP cores. The SCP
> driver populates the platform device and checks the child nodes
> to identify whether it's a single-core SCP or a multi-core SCP.
> 
> Add the remoteproc instances for single-core SCP and multi-core SCP to
> the new added SCP cluster list. When the SCP driver is removed, it
> cleanup resources by walking through the cluster list.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  drivers/remoteproc/mtk_common.h |   3 +
>  drivers/remoteproc/mtk_scp.c    | 188 ++++++++++++++++++++++++++++----
>  2 files changed, 172 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> index c0905aec3b4b..b73b60c22ea1 100644
> --- a/drivers/remoteproc/mtk_common.h
> +++ b/drivers/remoteproc/mtk_common.h
> @@ -128,6 +128,9 @@ struct mtk_scp {
>  	size_t dram_size;
>  
>  	struct rproc_subdev *rpmsg_subdev;
> +
> +	struct list_head elem;
> +	struct list_head *cluster;
>  };
>  
>  /**
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index 5e4982f4d5dc..0b052b0acf2e 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -28,6 +28,7 @@ struct mtk_scp_of_cluster {
>  	void __iomem *l1tcm_base;
>  	size_t l1tcm_size;
>  	phys_addr_t l1tcm_phys;
> +	struct list_head mtk_scp_cluster;
>  };
>  
>  /**
> @@ -862,21 +863,31 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
>  	}
>  }
>  
> -static int scp_rproc_init(struct platform_device *pdev)
> +static int scp_rproc_init(struct platform_device *cluster_pdev,
> +			  struct platform_device *core_pdev,
> +			  const struct mtk_scp_of_data *of_data)
>  {
> -	struct device *dev = &pdev->dev;
> -	struct device_node *np = dev->of_node;
> -	struct mtk_scp_of_cluster *of_cluster = platform_get_drvdata(pdev);
> +	struct platform_device *pdev;
> +	struct device *dev;
> +	struct device_node *np;
> +	struct mtk_scp_of_cluster *of_cluster = platform_get_drvdata(cluster_pdev);
>  	struct mtk_scp *scp;
>  	struct rproc *rproc;
>  	struct resource *res;
>  	const char *fw_name = "scp.img";
>  	int ret, i;
>  
> +	if (core_pdev)
> +		pdev = core_pdev;
> +	else
> +		pdev = cluster_pdev;

After following my comment from the previous patch, there won't be a need to do
this.  

> +
> +	dev = &pdev->dev;
>  	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
>  	if (ret < 0 && ret != -EINVAL)
>  		return ret;
>  
> +	np = dev->of_node;
>  	rproc = devm_rproc_alloc(dev, np->name, &scp_ops, fw_name, sizeof(*scp));
>  	if (!rproc)
>  		return dev_err_probe(dev, -ENOMEM, "unable to allocate remoteproc\n");
> @@ -884,7 +895,7 @@ static int scp_rproc_init(struct platform_device *pdev)
>  	scp = rproc->priv;
>  	scp->rproc = rproc;
>  	scp->dev = dev;
> -	scp->data = of_device_get_match_data(dev);
> +	scp->data = of_data;
>  	platform_set_drvdata(pdev, scp);
>  
>  	scp->reg_base = of_cluster->reg_base;
> @@ -934,10 +945,6 @@ static int scp_rproc_init(struct platform_device *pdev)
>  		goto remove_subdev;
>  	}
>  
> -	ret = rproc_add(rproc);
> -	if (ret)
> -		goto remove_subdev;
> -
>  	return 0;
>  
>  remove_subdev:
> @@ -952,6 +959,121 @@ static int scp_rproc_init(struct platform_device *pdev)
>  	return ret;
>  }
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
> +static int scp_is_single_core(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev_of_node(dev);
> +	struct device_node *child;
> +
> +	child = of_get_next_available_child(np, NULL);
> +	if (!child)
> +		return dev_err_probe(dev, -ENODEV, "No child node\n");
> +
> +	of_node_put(child);
> +	return of_node_name_eq(child, "cros-ec-rpmsg");
> +}
> +
> +static int scp_cluster_init(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev_of_node(dev);
> +	struct platform_device *cpdev;
> +	struct device_node *child;
> +	struct mtk_scp_of_cluster *of_cluster = platform_get_drvdata(pdev);
> +	const struct mtk_scp_of_data **cluster_of_data;
> +	struct list_head *cluster = &of_cluster->mtk_scp_cluster;
> +	struct mtk_scp *scp, *temp;
> +	int core_id = 0;
> +	int ret;
> +
> +	ret = scp_is_single_core(pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret) {
> +		dev_dbg(dev, "single-core scp\n");
> +
> +		/* When using the SCP node phandle on exported SCP APIs, the drvdata
> +		 * is expected to be the mtk_scp object, and as a result, it is intended
> +		 * to be overwritten for single-core SCP usage.
> +		 */
> +		ret = scp_rproc_init(pdev, NULL, of_device_get_match_data(dev));
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to initialize single-core scp\n");
> +
> +		scp = platform_get_drvdata(pdev);
> +		list_add_tail(&scp->elem, cluster);
> +		scp->cluster = cluster;
> +	} else {
> +		dev_dbg(dev, "multi-core scp\n");
> +
> +		cluster_of_data = (const struct mtk_scp_of_data **)of_device_get_match_data(dev);
> +
> +		for_each_available_child_of_node(np, child) {
> +			if (!cluster_of_data[core_id]) {
> +				ret = -EINVAL;
> +				dev_err(dev, "Not support core %d\n", core_id);
> +				of_node_put(child);
> +				goto init_fail;
> +			}
> +
> +			cpdev = of_find_device_by_node(child);
> +			if (!cpdev) {
> +				ret = -ENODEV;
> +				dev_err(dev, "Not found platform device for core %d\n", core_id);
> +				of_node_put(child);
> +				goto init_fail;
> +			}
> +
> +			ret = scp_rproc_init(pdev, cpdev, cluster_of_data[core_id]);
> +			if (ret) {
> +				dev_err(dev, "Failed to initialize core %d rproc\n", core_id);
> +				put_device(&cpdev->dev);
> +				of_node_put(child);
> +				goto init_fail;
> +			}
> +			scp = platform_get_drvdata(cpdev);
> +			list_add_tail(&scp->elem, cluster);
> +			scp->cluster = cluster;
> +			put_device(&cpdev->dev);
> +
> +			core_id++;
> +		}
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
> +	list_for_each_entry_safe_reverse(scp, temp, cluster, elem) {
> +		list_del(&scp->elem);
> +		scp_rproc_free(scp);
> +	}
> +
> +	return ret;
> +}
> +
>  static int scp_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -983,23 +1105,44 @@ static int scp_probe(struct platform_device *pdev)
>  		of_cluster->l1tcm_phys = res->start;
>  	}
>  
> +	INIT_LIST_HEAD(&of_cluster->mtk_scp_cluster);
>  	platform_set_drvdata(pdev, of_cluster);
>  
> -	return scp_rproc_init(pdev);
> +	ret = devm_of_platform_populate(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to populate platform devices\n");
> +
> +	ret = scp_cluster_init(pdev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize scp cluster\n");
> +
> +	return 0;
>  }
>  
>  static int scp_remove(struct platform_device *pdev)
>  {
> -	struct mtk_scp *scp = platform_get_drvdata(pdev);
> -	int i;
> +	struct mtk_scp *scp, *temp;
> +	struct mtk_scp_of_cluster *of_cluster;
> +	struct list_head *cluster;
> +	int ret;
>  
> -	rproc_del(scp->rproc);
> -	scp_remove_rpmsg_subdev(scp);
> -	scp_ipi_unregister(scp, SCP_IPI_INIT);
> -	scp_unmap_memory_region(scp);
> -	for (i = 0; i < SCP_IPI_MAX; i++)
> -		mutex_destroy(&scp->ipi_desc[i].lock);
> -	mutex_destroy(&scp->send_lock);
> +	ret = scp_is_single_core(pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret) {
> +		scp = platform_get_drvdata(pdev);
> +		cluster = scp->cluster;
> +	} else {
> +		of_cluster = platform_get_drvdata(pdev);
> +		cluster = &of_cluster->mtk_scp_cluster;
> +	}

If single and multi core systems were presented the same way, i.e with a cluster
and a list of SCPs, you wouldn't have to do this.  I will stop here for this
revision.

Thanks,
Mathieu

> +
> +	list_for_each_entry_safe_reverse(scp, temp, cluster, elem) {
> +		list_del(&scp->elem);
> +		rproc_del(scp->rproc);
> +		scp_rproc_free(scp);
> +	}
>  
>  	return 0;
>  }
> @@ -1078,12 +1221,19 @@ static const struct mtk_scp_of_data mt8195_of_data_c1 = {
>  	.host_to_scp_int_bit = MT8195_CORE1_HOST_IPC_INT_BIT,
>  };
>  
> +static const struct mtk_scp_of_data *mt8195_of_data_cores[] = {
> +	&mt8195_of_data,
> +	&mt8195_of_data_c1,
> +	NULL
> +};
> +
>  static const struct of_device_id mtk_scp_of_match[] = {
>  	{ .compatible = "mediatek,mt8183-scp", .data = &mt8183_of_data },
>  	{ .compatible = "mediatek,mt8186-scp", .data = &mt8186_of_data },
>  	{ .compatible = "mediatek,mt8188-scp", .data = &mt8188_of_data },
>  	{ .compatible = "mediatek,mt8192-scp", .data = &mt8192_of_data },
>  	{ .compatible = "mediatek,mt8195-scp", .data = &mt8195_of_data },
> +	{ .compatible = "mediatek,mt8195-scp-dual", .data = &mt8195_of_data_cores },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_scp_of_match);
> -- 
> 2.18.0
> 
