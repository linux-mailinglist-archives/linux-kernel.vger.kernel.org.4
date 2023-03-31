Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75336D2719
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjCaRxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjCaRxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:53:34 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1608593FD
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:53:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so24148251pjl.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680285212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3tEktp50z5OMhXRW9SNYjYqWNkmvczFNJ/sAacmBgNw=;
        b=YeaIKhiOIfIf81d4dOfVMNWPNEmcSLfxKlmkJ+87CfpwsyaALW99qVkVhkT4OKOlx1
         125L1NPqavL58rVvEZGtfXmQ481Xsj/rqKoOymD5QSFaE437kHegDRUq1mYFtouqZNUI
         PFdwYiT2nhdm6MMJfmp84MRXxBrhFA/6ie9236A6+swuwC9jzSYrdHnwU/jZZVObuaVa
         CHqrMszPx1SzehpPdxihv70ASVR3XkULvORz/cwVSt0C8prNDXggeQlHCEVtvXEWOm0O
         AErhJdvQ3flPgtbSF32++lZPhS/fiwkLpfMgYCDFd5mMfqWSoy+TG3/bO1xWW9KUZTU2
         G97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680285212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tEktp50z5OMhXRW9SNYjYqWNkmvczFNJ/sAacmBgNw=;
        b=W+LjUKEdCquMiku8Oolz3THE8FhKJn+orivQBDSI8SGGLhJwa9afCmCyB62xVQgOvd
         ttQrAr1h39NabxEdIARn74xFdJMmqhatmTjglB4lbiMzumPV96ioXG9yXZRP0Vyy92pJ
         rXjV62NeBSl7BDCErKvIsWmCWcGrryrlqRnd2qGzT/kEMnggwBBbpD2+xqnNaet6vVPx
         6gGp72j/gk7GZg3qP5Lk+Yv1VTtqiFS3gIAWkSmD4zFo8rVbQ7vm/x/NSk38dnSeCk3S
         NsMAS08ubniwTUYfoRBP4hPPjd0SOjW2G2o4CYmrWB5Ej2V1cZ3Ev1IX6YCKXFnkR77A
         Nzzg==
X-Gm-Message-State: AAQBX9de/yL3MTmCY75/Ica+ZcYeoavUQPDLqt52qUKV6BNIgMF5//Vr
        AQodhPsXUuPKkChtVWqPEiJNvA==
X-Google-Smtp-Source: AKy350amj54siiArL/Sgznr9XeqMujU10xZGC6SESoQx2OXpo9oa94ypJI8wkpAUgCpDJ1FYEI7x/Q==
X-Received: by 2002:a17:902:f906:b0:1a1:a7b6:e31e with SMTP id kw6-20020a170902f90600b001a1a7b6e31emr24430751plb.7.1680285212371;
        Fri, 31 Mar 2023 10:53:32 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:f19d:e1b1:6a5d:8ade])
        by smtp.gmail.com with ESMTPSA id e1-20020a170902d38100b0019ee0ad15b4sm1838121pld.191.2023.03.31.10.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:53:32 -0700 (PDT)
Date:   Fri, 31 Mar 2023 11:53:29 -0600
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
Subject: Re: [PATCH v9 06/11] remoteproc: mediatek: Probe multi-core SCP
Message-ID: <20230331175329.GB3504605@p14s>
References: <20230328022733.29910-1-tinghan.shen@mediatek.com>
 <20230328022733.29910-7-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328022733.29910-7-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:27:28AM +0800, Tinghan Shen wrote:
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
>  drivers/remoteproc/mtk_scp.c    | 150 ++++++++++++++++++++++++++++----
>  2 files changed, 137 insertions(+), 16 deletions(-)
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
> index 32ecd1450c6f..71882ed31e16 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -30,6 +30,8 @@ struct mtk_scp_of_regs {
>  	phys_addr_t l1tcm_phys;
>  };
>  
> +static struct list_head cluster_cores;
> +

See my comment in the previous patch about this.

>  /**
>   * scp_get() - get a reference to SCP.
>   *
> @@ -863,7 +865,8 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
>  }
>  
>  static int scp_rproc_init(struct platform_device *pdev,
> -			  struct mtk_scp_of_regs *of_regs)
> +			  struct mtk_scp_of_regs *of_regs,
> +			  const struct mtk_scp_of_data *of_data)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
> @@ -884,7 +887,7 @@ static int scp_rproc_init(struct platform_device *pdev,
>  	scp = (struct mtk_scp *)rproc->priv;
>  	scp->rproc = rproc;
>  	scp->dev = dev;
> -	scp->data = of_device_get_match_data(dev);
> +	scp->data = of_data;
>  	platform_set_drvdata(pdev, scp);
>  
>  	scp->reg_base = of_regs->reg_base;
> @@ -934,10 +937,6 @@ static int scp_rproc_init(struct platform_device *pdev,
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
> @@ -952,6 +951,109 @@ static int scp_rproc_init(struct platform_device *pdev,
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
> +static int scp_cluster_init(struct platform_device *pdev,
> +			    struct mtk_scp_of_regs *of_regs)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev_of_node(dev);
> +	struct platform_device *cpdev;
> +	struct device_node *child;
> +	const struct mtk_scp_of_data **cluster_of_data;
> +	struct list_head *cluster = &cluster_cores;
> +	struct mtk_scp *scp, *temp;
> +	int core_id = 0, num_cores;
> +	int ret;
> +
> +	child = of_get_next_available_child(np, NULL);
> +	if (!child)
> +		return dev_err_probe(dev, -ENODEV, "No child node\n");
> +
> +	of_node_put(child);
> +	if (of_node_name_eq(child, "cros-ec-rpmsg")) {
> +		dev_dbg(dev, "single-core scp\n");
> +
> +		ret = scp_rproc_init(pdev, of_regs, of_device_get_match_data(dev));
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to initialize single-core scp\n");
> +
> +		/* the single-core drvdata is intended to be the mtk_scp object.
> +		 * the mtk_scp object is used by APIs in mtk_scp_rpmsg_info.
> +		 */
> +		scp = platform_get_drvdata(pdev);
> +		list_add_tail(&scp->elem, cluster);
> +		scp->cluster = cluster;
> +	} else {
> +		dev_dbg(dev, "multi-core scp\n");
> +
> +		cluster_of_data = (const struct mtk_scp_of_data **)of_device_get_match_data(dev);
> +
> +		num_cores = of_get_available_child_count(np);
> +
> +		for_each_available_child_of_node(np, child) {
> +			if (core_id >= num_cores || !cluster_of_data[core_id]) {

The first part of the if() condition is not needed - please remove.

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
> +			ret = scp_rproc_init(cpdev, of_regs, cluster_of_data[core_id]);
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
> @@ -980,21 +1082,30 @@ static int scp_probe(struct platform_device *pdev)
>  		scp_regs.l1tcm_phys = res->start;
>  	}
>  
> -	return scp_rproc_init(pdev, &scp_regs);
> +	ret = devm_of_platform_populate(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to populate platform devices\n");
> +
> +	INIT_LIST_HEAD(&cluster_cores);
> +	platform_set_drvdata(pdev, &cluster_cores);

Why is this needed when @cluster_cores is a global variable???

The drvdata should be the cluster I talked about in the previous patch.  Doing
this will greatly simplify this patchset.

I will stop here for this revision.

Thanks,
Mathieu

> +
> +	ret = scp_cluster_init(pdev, &scp_regs);
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
> +	struct list_head *cluster = &cluster_cores;
> +	struct mtk_scp *scp, *temp;
>  
> -	rproc_del(scp->rproc);
> -	scp_remove_rpmsg_subdev(scp);
> -	scp_ipi_unregister(scp, SCP_IPI_INIT);
> -	scp_unmap_memory_region(scp);
> -	for (i = 0; i < SCP_IPI_MAX; i++)
> -		mutex_destroy(&scp->ipi_desc[i].lock);
> -	mutex_destroy(&scp->send_lock);
> +	list_for_each_entry_safe_reverse(scp, temp, cluster, elem) {
> +		list_del(&scp->elem);
> +		rproc_del(scp->rproc);
> +		scp_rproc_free(scp);
> +	}
>  
>  	return 0;
>  }
> @@ -1073,12 +1184,19 @@ static const struct mtk_scp_of_data mt8195_of_data_c1 = {
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
