Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D58B731E29
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjFOQtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjFOQs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:48:29 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6BF3ABF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:48:03 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53482b44007so4477237a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686847683; x=1689439683;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JV6IWWmfJwTNThP5380grMDG7rHqreUUwv0wwOmUg9Q=;
        b=B0Ck2sWhAezPDMPNonxT/CUVxE+8vZtquI2inOXnClFzu616wygQs923c1WBmZHsd9
         tLiG3nBiy1wUO7XcrXVTFM8RSR8jcdg3ehIjTCiAcaqqYx+5MVPyzIGvU0XNa4hu0tev
         F9Wz+rTKrMBA916U6QXmTFwJGuCnmF/eGn1ZoBwrjXewXjGaMUNe3h0531qK9z5vyE8T
         tAgVpa+OCJQnLAQkhEXk4qyffltQrpyfzITyWKsrQ8NdHz8TXI0SPjkUnNhmWHacTVGb
         1Wjg448PdIh+4u4GBztO75cu3ILT0OlJF38YbtwEIfCHrEcDl+R7aFqNNkTh84P8YQkB
         e06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686847683; x=1689439683;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JV6IWWmfJwTNThP5380grMDG7rHqreUUwv0wwOmUg9Q=;
        b=KhgwxsH4oQnH6RAMW/T/aNe+ql5tXbcHd1ECCOOgLoETipkVkvoOVAk8JiJkBHNmyD
         fbrFkNbagxJcoSNKx/X6I0nA9EwaGIbcSvK4R69Ei5PNrG0oN0+GcoRft1bR18T6PEgY
         LDPUbaHwQDtCzpOXBkeD8MISyLF6wvUV0bEuAP0Lb9pj0lw+mDjTALF9AsIU8dSHyF9P
         xZuUIFJkoU4ifeVQtquJ7SDuEcmw0bNtk6VCyX4Pa3zDaq7iHuNFxz5q0K4pczRUP9oT
         nl7GnebrJXR/U54erOiNJl5kcv+IMdyH53Bxm+F12Ij2HPGnXPptvAT19E3Ko7G3zyah
         33GQ==
X-Gm-Message-State: AC+VfDzfoXBIewXm3oY9GG1G8pxJHOc42aiicVCxZ1lbRGcXgpX3ODmr
        sa9bWBQExxy0yD8fcfpG3TcGiQ==
X-Google-Smtp-Source: ACHHUZ5t+K5BTdkfhoLr7nL3vpvHzqDFmbtRqs5wV//HlZInwup6qGbbpjesqa3TP0RSPx6iYfI6Og==
X-Received: by 2002:a17:90b:286:b0:25b:d0c9:9f00 with SMTP id az6-20020a17090b028600b0025bd0c99f00mr4096911pjb.9.1686847683328;
        Thu, 15 Jun 2023 09:48:03 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:af20:8a90:5e7d:9e63])
        by smtp.gmail.com with ESMTPSA id in15-20020a17090b438f00b0025e9d16f95bsm1357250pjb.28.2023.06.15.09.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 09:48:02 -0700 (PDT)
Date:   Thu, 15 Jun 2023 10:48:00 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     TingHan Shen =?utf-8?B?KOayiOW7t+e/sCk=?= 
        <TingHan.Shen@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v13 05/11] remoteproc: mediatek: Introduce cluster on
 single-core SCP
Message-ID: <ZItAwNiXkoF8qLDt@p14s>
References: <20230607072222.8628-1-tinghan.shen@mediatek.com>
 <20230607072222.8628-6-tinghan.shen@mediatek.com>
 <ZIdVGoeMH91kamAI@p14s>
 <0668bbfc732db80ad12703c1c4906cb4348b5730.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0668bbfc732db80ad12703c1c4906cb4348b5730.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 08:13:18AM +0000, TingHan Shen (沈廷翰) wrote:
> Hi Mathieu,
> 
> On Mon, 2023-06-12 at 11:25 -0600, Mathieu Poirier wrote:
> > On Wed, Jun 07, 2023 at 03:22:16PM +0800, Tinghan Shen wrote:
> > > This is the preliminary step for probing multi-core SCP.
> > > The initialization procedure for remoteproc is similar for both
> > > single-core and multi-core architectures and is reusing to avoid
> > > redundant code.
> > > 
> > > Rewrite the probing flow of single-core SCP to adapt with the 'cluster'
> > > concept needed by probing the multi-core SCP. The main differences
> > > are,
> > > - the SCP core object(s) is maintained at the cluster list instead of at
> > >   the platofmr device driver data property.
> > > - save the cluster information at the platofmr device driver data property.
> > > - In order to keep the compatibility of exported SCP APIs which getting
> > >   the SCP core object by SCP node phandle, move the SCP core object
> > >   pointers to the platform device platform data property.
> > > 
> > > The registers of config and l1tcm are shared for multi-core
> > > SCP. Reuse the mapped addresses for all cores.
> > > 
> > > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > > ---
> > >  drivers/remoteproc/mtk_common.h |   2 +
> > >  drivers/remoteproc/mtk_scp.c    | 151 +++++++++++++++++++++++---------
> > >  2 files changed, 112 insertions(+), 41 deletions(-)
> > > 
> > > diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> > > index c0905aec3b4b..56395e8664cb 100644
> > > --- a/drivers/remoteproc/mtk_common.h
> > > +++ b/drivers/remoteproc/mtk_common.h
> > > @@ -128,6 +128,8 @@ struct mtk_scp {
> > >  	size_t dram_size;
> > >  
> > >  	struct rproc_subdev *rpmsg_subdev;
> > > +
> > > +	struct list_head elem;
> > >  };
> > >  
> > >  /**
> > > diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> > > index d66822dad943..c8fc6b46f82b 100644
> > > --- a/drivers/remoteproc/mtk_scp.c
> > > +++ b/drivers/remoteproc/mtk_scp.c
> > > @@ -23,6 +23,14 @@
> > >  #define MAX_CODE_SIZE 0x500000
> > >  #define SECTION_NAME_IPI_BUFFER ".ipi_buffer"
> > >  
> > > +struct mtk_scp_of_cluster {
> > > +	void __iomem *reg_base;
> > > +	void __iomem *l1tcm_base;
> > > +	size_t l1tcm_size;
> > > +	phys_addr_t l1tcm_phys;
> > > +	struct list_head mtk_scp_list;
> > > +};
> > > +
> > >  /**
> > >   * scp_get() - get a reference to SCP.
> > >   *
> > > @@ -51,7 +59,7 @@ struct mtk_scp *scp_get(struct platform_device *pdev)
> > >  		return NULL;
> > >  	}
> > >  
> > > -	return platform_get_drvdata(scp_pdev);
> > > +	return *(struct mtk_scp **)dev_get_platdata(&scp_pdev->dev);
> > >  }
> > >  EXPORT_SYMBOL_GPL(scp_get);
> > >  
> > > @@ -810,14 +818,14 @@ static void scp_unmap_memory_region(struct mtk_scp *scp)
> > >  static int scp_register_ipi(struct platform_device *pdev, u32 id,
> > >  			    ipi_handler_t handler, void *priv)
> > >  {
> > > -	struct mtk_scp *scp = platform_get_drvdata(pdev);
> > > +	struct mtk_scp *scp = *(struct mtk_scp **)dev_get_platdata(&pdev->dev);
> > >  
> > >  	return scp_ipi_register(scp, id, handler, priv);
> > >  }
> > >  
> > >  static void scp_unregister_ipi(struct platform_device *pdev, u32 id)
> > >  {
> > > -	struct mtk_scp *scp = platform_get_drvdata(pdev);
> > > +	struct mtk_scp *scp = *(struct mtk_scp **)dev_get_platdata(&pdev->dev);
> > >  
> > >  	scp_ipi_unregister(scp, id);
> > >  }
> > > @@ -825,7 +833,7 @@ static void scp_unregister_ipi(struct platform_device *pdev, u32 id)
> > >  static int scp_send_ipi(struct platform_device *pdev, u32 id, void *buf,
> > >  			unsigned int len, unsigned int wait)
> > >  {
> > > -	struct mtk_scp *scp = platform_get_drvdata(pdev);
> > > +	struct mtk_scp *scp = *(struct mtk_scp **)dev_get_platdata(&pdev->dev);
> > >  
> > >  	return scp_ipi_send(scp, id, buf, len, wait);
> > >  }
> > > @@ -855,7 +863,8 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
> > >  	}
> > >  }
> > >  
> > > -static int scp_probe(struct platform_device *pdev)
> > > +static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
> > > +				      struct mtk_scp_of_cluster *scp_cluster)
> > >  {
> > >  	struct device *dev = &pdev->dev;
> > >  	struct device_node *np = dev->of_node;
> > > @@ -867,52 +876,42 @@ static int scp_probe(struct platform_device *pdev)
> > >  
> > >  	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
> > >  	if (ret < 0 && ret != -EINVAL)
> > > -		return ret;
> > > +		return ERR_PTR(ret);
> > >  
> > >  	rproc = devm_rproc_alloc(dev, np->name, &scp_ops, fw_name, sizeof(*scp));
> > > -	if (!rproc)
> > > -		return dev_err_probe(dev, -ENOMEM, "unable to allocate remoteproc\n");
> > > +	if (!rproc) {
> > > +		dev_err(dev, "unable to allocate remoteproc\n");
> > > +		return ERR_PTR(-ENOMEM);
> > > +	}
> > >  
> > >  	scp = rproc->priv;
> > >  	scp->rproc = rproc;
> > >  	scp->dev = dev;
> > >  	scp->data = of_device_get_match_data(dev);
> > > -	platform_set_drvdata(pdev, scp);
> > > +	platform_device_add_data(pdev, &scp, sizeof(scp));
> > > +
> > > +	scp->reg_base = scp_cluster->reg_base;
> > > +	scp->l1tcm_base = scp_cluster->l1tcm_base;
> > > +	scp->l1tcm_size = scp_cluster->l1tcm_size;
> > > +	scp->l1tcm_phys = scp_cluster->l1tcm_phys;
> > >  
> > >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
> > >  	scp->sram_base = devm_ioremap_resource(dev, res);
> > > -	if (IS_ERR(scp->sram_base))
> > > -		return dev_err_probe(dev, PTR_ERR(scp->sram_base),
> > > -				     "Failed to parse and map sram memory\n");
> > > +	if (IS_ERR(scp->sram_base)) {
> > > +		dev_err(dev, "Failed to parse and map sram memory\n");
> > > +		return ERR_PTR(PTR_ERR(scp->sram_base));
> > 
> > Can you spot what is wrong here?
> 
> After look around of the header, I thought that I should use the ERR_CAST instead.
> It fix the sparse warning and prevent the weired double type casting.
> If this is ok, I will fix it this way in the next version.
>

Yes, the double casting is what got my attention.  ERR_CAST() was introduced to
address those kind of problems.

> 
> Best regards,
> TingHan
> 
> > 
> > > +	}
> > >  
> > >  	scp->sram_size = resource_size(res);
> > >  	scp->sram_phys = res->start;
> > >  
> > > -	/* l1tcm is an optional memory region */
> > > -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "l1tcm");
> > > -	scp->l1tcm_base = devm_ioremap_resource(dev, res);
> > > -	if (IS_ERR(scp->l1tcm_base)) {
> > > -		ret = PTR_ERR(scp->l1tcm_base);
> > > -		if (ret != -EINVAL) {
> > > -			return dev_err_probe(dev, ret, "Failed to map l1tcm memory\n");
> > > -		}
> > > -	} else {
> > > -		scp->l1tcm_size = resource_size(res);
> > > -		scp->l1tcm_phys = res->start;
> > > -	}
> > > -
> > > -	scp->reg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
> > > -	if (IS_ERR(scp->reg_base))
> > > -		return dev_err_probe(dev, PTR_ERR(scp->reg_base),
> > > -				     "Failed to parse and map cfg memory\n");
> > > -
> > >  	ret = scp->data->scp_clk_get(scp);
> > >  	if (ret)
> > > -		return ret;
> > > +		return ERR_PTR(ret);
> > >  
> > >  	ret = scp_map_memory_region(scp);
> > >  	if (ret)
> > > -		return ret;
> > > +		return ERR_PTR(ret);
> > >  
> > >  	mutex_init(&scp->send_lock);
> > >  	for (i = 0; i < SCP_IPI_MAX; i++)
> > > @@ -939,11 +938,7 @@ static int scp_probe(struct platform_device *pdev)
> > >  		goto remove_subdev;
> > >  	}
> > >  
> > > -	ret = rproc_add(rproc);
> > > -	if (ret)
> > > -		goto remove_subdev;
> > > -
> > > -	return 0;
> > > +	return scp;
> > >  
> > >  remove_subdev:
> > >  	scp_remove_rpmsg_subdev(scp);
> > > @@ -954,15 +949,13 @@ static int scp_probe(struct platform_device *pdev)
> > >  		mutex_destroy(&scp->ipi_desc[i].lock);
> > >  	mutex_destroy(&scp->send_lock);
> > >  
> > > -	return ret;
> > > +	return ERR_PTR(ret);
> > >  }
> > >  
> > > -static void scp_remove(struct platform_device *pdev)
> > > +static void scp_free(struct mtk_scp *scp)
> > >  {
> > > -	struct mtk_scp *scp = platform_get_drvdata(pdev);
> > >  	int i;
> > >  
> > > -	rproc_del(scp->rproc);
> > >  	scp_remove_rpmsg_subdev(scp);
> > >  	scp_ipi_unregister(scp, SCP_IPI_INIT);
> > >  	scp_unmap_memory_region(scp);
> > > @@ -971,6 +964,82 @@ static void scp_remove(struct platform_device *pdev)
> > >  	mutex_destroy(&scp->send_lock);
> > >  }
> > >  
> > > +static int scp_cluster_init(struct platform_device *pdev)
> > > +{
> > > +	struct mtk_scp_of_cluster *scp_cluster = platform_get_drvdata(pdev);
> > > +	struct list_head *cluster = &scp_cluster->mtk_scp_list;
> > > +	struct mtk_scp *scp;
> > > +	int ret;
> > > +
> > > +	scp = scp_rproc_init(pdev, scp_cluster);
> > > +	if (IS_ERR(scp))
> > > +		return PTR_ERR(scp);
> > > +
> > > +	ret = rproc_add(scp->rproc);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to add rproc\n");
> > > +		scp_free(scp);
> > > +		return ret;
> > > +	}
> > > +
> > > +	list_add_tail(&scp->elem, cluster);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int scp_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	struct mtk_scp_of_cluster *scp_cluster;
> > > +	struct resource *res;
> > > +	int ret;
> > > +
> > > +	scp_cluster = devm_kzalloc(dev, sizeof(*scp_cluster), GFP_KERNEL);
> > > +	if (!scp_cluster)
> > > +		return -ENOMEM;
> > > +
> > > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> > > +	scp_cluster->reg_base = devm_ioremap_resource(dev, res);
> > > +	if (IS_ERR(scp_cluster->reg_base))
> > > +		return dev_err_probe(dev, PTR_ERR(scp_cluster->reg_base),
> > > +				     "Failed to parse and map cfg memory\n");
> > > +
> > > +	/* l1tcm is an optional memory region */
> > > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "l1tcm");
> > > +	scp_cluster->l1tcm_base = devm_ioremap_resource(dev, res);
> > > +	if (IS_ERR(scp_cluster->l1tcm_base)) {
> > > +		ret = PTR_ERR(scp_cluster->l1tcm_base);
> > > +		if (ret != -EINVAL)
> > > +			return dev_err_probe(dev, ret, "Failed to map l1tcm memory\n");
> > > +
> > > +		scp_cluster->l1tcm_base = NULL;
> > > +	} else {
> > > +		scp_cluster->l1tcm_size = resource_size(res);
> > > +		scp_cluster->l1tcm_phys = res->start;
> > > +	}
> > > +
> > > +	INIT_LIST_HEAD(&scp_cluster->mtk_scp_list);
> > > +	platform_set_drvdata(pdev, scp_cluster);
> > > +
> > > +	ret = scp_cluster_init(pdev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void scp_remove(struct platform_device *pdev)
> > > +{
> > > +	struct mtk_scp_of_cluster *scp_cluster = platform_get_drvdata(pdev);
> > > +	struct mtk_scp *scp, *temp;
> > > +
> > > +	list_for_each_entry_safe_reverse(scp, temp, &scp_cluster->mtk_scp_list, elem) {
> > > +		list_del(&scp->elem);
> > > +		rproc_del(scp->rproc);
> > > +		scp_free(scp);
> > > +	}
> > > +}
> > > +
> > >  static const struct mtk_scp_of_data mt8183_of_data = {
> > >  	.scp_clk_get = mt8183_scp_clk_get,
> > >  	.scp_before_load = mt8183_scp_before_load,
> > > -- 
> > > 2.18.0
> 
> 
