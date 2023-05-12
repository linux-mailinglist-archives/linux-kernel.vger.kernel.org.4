Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC02700E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbjELR4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbjELR42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:56:28 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBD193F8
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 10:56:26 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-644d9bf05b7so5501236b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 10:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683914186; x=1686506186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R9N7oS6jr5I1eNsTOfVL37WjNOJubQs2HqUtyANMDP0=;
        b=e8VeAJis7BiGB80fGC9OA2dXjFxJ84RYh+orJsPRquyiCWeb/YOnxgvRH4NQ5DN+Sz
         K8zIePNL37kmIZi3LujOHN95Q4j9j8pag4WDkr/9Ztd6IeVl/mq+FLwLgzRaF5FuYYOC
         taL3EkI2ffVatTtsWqvJNfxXEuGQiP4igFIaapo2GOWDQqgdPHe0EON7ABVsRcah/pap
         NaqDMAxkgs7zK/IuYeqXLx/QNiG+AC+GgRXA/FoGxG+Bk1ZMm/DplIYxXUg7WMEXR0Sj
         OfTN2cHkaYiHjfM6BSVcJO0hylb4gfOgX8LD8q+mcs63ID5+gvWXFz2/UKg51aSuspwn
         0LEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683914186; x=1686506186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9N7oS6jr5I1eNsTOfVL37WjNOJubQs2HqUtyANMDP0=;
        b=QjjpkT478KlQiCEqwWlO6MSFsaZ4Mx86EZLXnqtMHYyli6rAFaVHjlr3KnJ84PV/LM
         cQHuGFuuYLEqAe+ojpzxRyT697S728tAFT/5XqOM2olvnQE9eZtaHg9i/WvChjTRt10W
         Od6BaHXBjAlOldxJi92NlDIgNucRLRHFkbLNWypy2efnOXf1Mj259R1TILTPikBFZFRK
         fOxQcjSwdkXUWhFMGQlWr7vjU5FtnswfsePg1qGOPLINiU12/NjbxZhMwmIl/hORz4HC
         7q5ZNG3dvPRWlEdlSeasGC/fosaQWaIhYNeAKmi9jkXWJWQQbbEt9gIOygqI4L0OV/n+
         3How==
X-Gm-Message-State: AC+VfDx6nVO67scDYDEbp+jIgRKpzbzAJp2JI9HiWrM+aYik4yV6dSTE
        aJjARa93KiwglKDKSt73CVfzWw==
X-Google-Smtp-Source: ACHHUZ7PynoPsqxQ9BaRx3LZvfa6R+SwPfo3isHwZ5NUP1XZZEDFDgjXygEj5DaDyxccAYzMaBXPHw==
X-Received: by 2002:a05:6a20:9153:b0:101:3600:6aa5 with SMTP id x19-20020a056a20915300b0010136006aa5mr16881734pzc.3.1683914185675;
        Fri, 12 May 2023 10:56:25 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:3c53:c331:6276:810])
        by smtp.gmail.com with ESMTPSA id o4-20020a63f144000000b00513973a7014sm6946408pgk.12.2023.05.12.10.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 10:56:25 -0700 (PDT)
Date:   Fri, 12 May 2023 11:56:22 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v11 06/11] remoteproc: mediatek: Probe multi-core SCP
Message-ID: <ZF59xilzufy69RZh@p14s>
References: <20230510063749.5127-1-tinghan.shen@mediatek.com>
 <20230510063749.5127-7-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510063749.5127-7-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 02:37:44PM +0800, Tinghan Shen wrote:
> The difference of single-core SCP and multi-core SCP device tree is
> the presence of child device nodes described SCP cores. The SCP
> driver populates the platform device and checks the child nodes
> to identify whether it's a single-core SCP or a multi-core SCP.
> 
> Add the remoteproc instances of multi-core SCP to the SCP cluster list.
> When the SCP driver is removed, it cleanup resources by walking
> through the cluster list.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  drivers/remoteproc/mtk_scp.c | 135 ++++++++++++++++++++++++++++++-----
>  1 file changed, 117 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index ff73c6dd9637..87215a0e145e 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -864,7 +864,8 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
>  }
>  
>  static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
> -				      struct mtk_scp_of_cluster *scp_cluster)
> +				      struct mtk_scp_of_cluster *scp_cluster,
> +				      const struct mtk_scp_of_data *of_data)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
> @@ -887,7 +888,7 @@ static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
>  	scp = rproc->priv;
>  	scp->rproc = rproc;
>  	scp->dev = dev;
> -	scp->data = of_device_get_match_data(dev);
> +	scp->data = of_data;
>  	platform_device_add_data(pdev, &scp, sizeof(scp));
>  
>  	scp->reg_base = scp_cluster->reg_base;
> @@ -938,10 +939,6 @@ static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
>  		goto remove_subdev;
>  	}
>  
> -	ret = rproc_add(rproc);
> -	if (ret)
> -		goto remove_subdev;
> -

This should have been done in the previous patch.

>  	return scp;
>  
>  remove_subdev:
> @@ -956,19 +953,116 @@ static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
>  	return ERR_PTR(ret);
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
>  static int scp_cluster_init(struct platform_device *pdev)
>  {
> -	struct mtk_scp *scp;
> +	struct mtk_scp *scp, *temp;
>  	struct mtk_scp_of_cluster *scp_cluster = platform_get_drvdata(pdev);
>  	struct list_head *cluster = &scp_cluster->mtk_scp_cluster;
>  
> -	scp = scp_rproc_init(pdev, scp_cluster);
> -	if (IS_ERR(scp))
> -		return PTR_ERR(scp);
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev_of_node(dev);
> +	struct platform_device *cpdev;
> +	struct device_node *child;
> +	const struct mtk_scp_of_data **cluster_of_data;
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

Is this comment still relevant?

> +		scp = scp_rproc_init(pdev, scp_cluster, of_device_get_match_data(dev));
> +		if (IS_ERR(scp))
> +			return PTR_ERR(scp);
> +
> +		list_add_tail(&scp->elem, cluster);

This is getting messy.  Please add two new functions, i.e scp_add_single_core()
and scp_add_multi_core().

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
> +			scp = scp_rproc_init(cpdev, scp_cluster, cluster_of_data[core_id]);
> +			if (IS_ERR(scp)) {
> +				dev_err(dev, "Failed to initialize core %d rproc\n", core_id);
> +				put_device(&cpdev->dev);
> +				of_node_put(child);
> +				goto init_fail;
> +			}
> +			list_add_tail(&scp->elem, cluster);
> +			put_device(&cpdev->dev);
> +
> +			core_id++;
> +		}
> +	}
>  
> -	list_add_tail(&scp->elem, cluster);
> +	list_for_each_entry_safe_reverse(scp, temp, cluster, elem) {
> +		ret = rproc_add(scp->rproc);

Call rproc_add() in the for_each_available_child_of_node() loop above.  That way
it if fails you can call scp_rproc_free() right away and jump to init_fail to
deal with the other cores on the list.

> +		if (ret)
> +			goto add_fail;
> +	}
>  
>  	return 0;
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

There are a serious problems with the code in both labels above.  I will let you
think about that and I will stop here for this revision.

Mathieu

> +	return ret;
>  }
>  
>  static int scp_probe(struct platform_device *pdev)
> @@ -1005,6 +1099,10 @@ static int scp_probe(struct platform_device *pdev)
>  	INIT_LIST_HEAD(&scp_cluster->mtk_scp_cluster);
>  	platform_set_drvdata(pdev, scp_cluster);
>  
> +	ret = devm_of_platform_populate(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to populate platform devices\n");
> +
>  	ret = scp_cluster_init(pdev);
>  	if (ret)
>  		return ret;
> @@ -1016,17 +1114,11 @@ static int scp_remove(struct platform_device *pdev)
>  {
>  	struct mtk_scp_of_cluster *scp_cluster = platform_get_drvdata(pdev);
>  	struct mtk_scp *scp, *temp;
> -	int i;
>  
>  	list_for_each_entry_safe_reverse(scp, temp, &scp_cluster->mtk_scp_cluster, elem) {
>  		list_del(&scp->elem);
>  		rproc_del(scp->rproc);
> -		scp_remove_rpmsg_subdev(scp);
> -		scp_ipi_unregister(scp, SCP_IPI_INIT);
> -		scp_unmap_memory_region(scp);
> -		for (i = 0; i < SCP_IPI_MAX; i++)
> -			mutex_destroy(&scp->ipi_desc[i].lock);
> -		mutex_destroy(&scp->send_lock);
> +		scp_rproc_free(scp);
>  	}
>  
>  	return 0;
> @@ -1106,12 +1198,19 @@ static const struct mtk_scp_of_data mt8195_of_data_c1 = {
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
