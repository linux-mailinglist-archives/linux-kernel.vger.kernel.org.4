Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA91A706F96
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjEQRhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjEQRhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:37:10 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B6283FA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:36:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ae557aaf1dso7683105ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684345018; x=1686937018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dC+WhwakdcOIZn4GauWplVKtCXgrq9G2TslZKCjOezM=;
        b=A+q3f0JjFmDJZ+fUXVTUlYRHZ7ens+mv/aYBblUwv0RAngu3blV1FZrXFqjmdD2bCV
         jjND6m6kZuhAH4RGmfokvYy/mvg6lDOU3M7S1imovIthmYHn1mfiWu5bo6oq6Rp6Z+0h
         f0ssAVQDQCm3yshPaJ5PE/MrQplRazfRLw+nTKOoOOikzbwbAVwPcLAQJc8ii1FNFN3W
         sof2nBX+BWw2kvdJ+U+i99hCx6PLTCXMVHa4C9IwEM5pgUSDLZWl3pCNcKDq7QIvrRkc
         s3H2epoyazlTtRJ6cN+EfYQj0mQCwwZ5AueOZ25geBm+mXbqGsrpJCFcMOTegKOodTia
         EnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684345018; x=1686937018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dC+WhwakdcOIZn4GauWplVKtCXgrq9G2TslZKCjOezM=;
        b=Bsnz0iU9TQxF/PE5pNDlO8wi0bJ5A2hf4Ffm+yLH3QiJyim7X+oTHNChv/8XqyE6X2
         nuYEZNA+mqds4xQb1zV3Oe3oG1gGjfG8ZBZDtfUt340vcd6oWrLG7lmDUebZyun4V3w+
         umu0dg2hvizzCYdTGzAnYC+4PY54TESeeUsF8k0jnc44p7/KBkpZUJ7LGTiQWyhQ5cJH
         GKManODi2Y0eOUk6/L+4JnjmKT1YdnvFY6tij2jgrf76aADMfZ9jXhbo0QEtggi6eqXb
         f3yR97cql2IRF2pw7HmNgqTyVqlcKnR5802roLD1A2/ynV3SEaT8HCF3ss//aFUECvhk
         sC2Q==
X-Gm-Message-State: AC+VfDwT7pjlrM8c0Qm4QFXoWzaicHePIbjOpuH7qv9yRPThvW3qTDsz
        jTKkLZvldqpsKlXbs3oNW/Ys9Q==
X-Google-Smtp-Source: ACHHUZ4LXfMM8a+bUsf49YRamvtKAdelst75eA7v19LjROK98TkKU4mvFK74tJ0oApIvk9MnnFZkZA==
X-Received: by 2002:a17:902:d304:b0:1ad:de16:66d with SMTP id b4-20020a170902d30400b001adde16066dmr21980950plc.39.1684345017915;
        Wed, 17 May 2023 10:36:57 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:fd0b:2592:d377:e4e3])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b001a6ff7bd4d9sm17905163plj.15.2023.05.17.10.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:36:57 -0700 (PDT)
Date:   Wed, 17 May 2023 11:36:55 -0600
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
Subject: Re: [PATCH v12 06/11] remoteproc: mediatek: Probe multi-core SCP
Message-ID: <ZGUQt2EN59yDo8JA@p14s>
References: <20230517043449.26352-1-tinghan.shen@mediatek.com>
 <20230517043449.26352-7-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517043449.26352-7-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 12:34:44PM +0800, Tinghan Shen wrote:
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
>  drivers/remoteproc/mtk_scp.c | 115 +++++++++++++++++++++++++++++++++--
>  1 file changed, 111 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index c8fc6b46f82b..d644e232dfec 100644
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
> @@ -964,14 +965,15 @@ static void scp_free(struct mtk_scp *scp)
>  	mutex_destroy(&scp->send_lock);
>  }
>  
> -static int scp_cluster_init(struct platform_device *pdev)
> +static int scp_add_single_core(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	struct mtk_scp_of_cluster *scp_cluster = platform_get_drvdata(pdev);
>  	struct list_head *cluster = &scp_cluster->mtk_scp_list;
>  	struct mtk_scp *scp;
>  	int ret;
>  
> -	scp = scp_rproc_init(pdev, scp_cluster);
> +	scp = scp_rproc_init(pdev, scp_cluster, of_device_get_match_data(dev));
>  	if (IS_ERR(scp))
>  		return PTR_ERR(scp);
>  
> @@ -987,6 +989,100 @@ static int scp_cluster_init(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int scp_add_multi_core(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev_of_node(dev);
> +	struct platform_device *cpdev;
> +	struct device_node *child;
> +	struct mtk_scp_of_cluster *scp_cluster = platform_get_drvdata(pdev);
> +	struct list_head *cluster = &scp_cluster->mtk_scp_list;
> +	const struct mtk_scp_of_data **cluster_of_data;
> +	struct mtk_scp *scp, *temp;
> +	int core_id = 0;
> +	int ret;
> +
> +	cluster_of_data = (const struct mtk_scp_of_data **)of_device_get_match_data(dev);
> +
> +	for_each_available_child_of_node(np, child) {
> +		if (!cluster_of_data[core_id]) {
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
> +		scp = scp_rproc_init(cpdev, scp_cluster, cluster_of_data[core_id]);
> +		put_device(&cpdev->dev);
> +		if (IS_ERR(scp)) {
> +			ret = PTR_ERR(scp);
> +			dev_err(dev, "Failed to initialize core %d rproc\n", core_id);
> +			of_node_put(child);
> +			goto init_fail;
> +		}
> +
> +		ret = rproc_add(scp->rproc);
> +		if (ret) {
> +			dev_err(dev, "Failed to add rproc of core %d\n", core_id);
> +			of_node_put(child);
> +			scp_free(scp);
> +			goto init_fail;
> +		}
> +
> +		list_add_tail(&scp->elem, cluster);
> +		core_id++;
> +	}
> +
> +	return 0;
> +
> +init_fail:
> +	list_for_each_entry_safe_reverse(scp, temp, cluster, elem) {
> +		list_del(&scp->elem);
> +		rproc_del(scp->rproc);
> +		scp_free(scp);
> +	}
> +
> +	return ret;
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
> +	int ret;
> +
> +	ret = scp_is_single_core(pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret)
> +		ret = scp_add_single_core(pdev);
> +	else
> +		ret = scp_add_multi_core(pdev);
> +
> +	return ret;
> +}
> +
>  static int scp_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1021,6 +1117,10 @@ static int scp_probe(struct platform_device *pdev)
>  	INIT_LIST_HEAD(&scp_cluster->mtk_scp_list);
>  	platform_set_drvdata(pdev, scp_cluster);
>  
> +	ret = devm_of_platform_populate(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to populate platform devices\n");
> +
>  	ret = scp_cluster_init(pdev);
>  	if (ret)
>  		return ret;
> @@ -1114,12 +1214,19 @@ static const struct mtk_scp_of_data mt8195_of_data_c1 = {
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

I am happy with the refactoring work.  Please do not change anything in patches
05 and 06 unless I ask for it.

>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_scp_of_match);
> -- 
> 2.18.0
> 
