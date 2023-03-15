Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087FD6BBAF7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjCOReP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjCOReN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:34:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EF31E5D5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:34:11 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso3919153pjf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678901651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4RksfPONkCdlIzGWCI4gEmQh2PUbMXq0YFoK8rSx6E=;
        b=ALLgMueiI4TdIzfTHW2Rn0pxzSF5Hg74eyv0v6DvLaJrYmL81uzLko1Xi+IdFFbH4r
         d2wIOD8VxqSPX1DAJ8LZLVB6NpvqaW+cUaaMTVU5IQTdNDNNsC6+5dlZTil7XL1+Vs6/
         GCsbaXj7owb7YxqZrRoeeKfYbf+c0MuT8m/nT1xHwwyK5G0uAIl8GNAs/2yrxqtOQk0t
         pYB/vgUHRWAgGWq+TvqavP1Z3JArvQJCiHo3si8vPOSA8Q1OUX9W6hl4BJtcfP9L9PKq
         Wst/e1697jinwVOhhj8K3ap7XwCfaJftZq1WQIPSbgh4ayPz7KryEa6U6Pw1HaYmuZYm
         ZBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678901651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4RksfPONkCdlIzGWCI4gEmQh2PUbMXq0YFoK8rSx6E=;
        b=vwikKtAr7Nz7E/wLRhrvucRuc2kiSWV2rU71GbQDI8qCxSGKtO8i18v09Lz0CS+O5g
         /rOKBpf9RLhAMHXLXGzy8bqBbGKTgFd5NKo3rDE34ZFFP/V7sKIDqbmn9/v57E2Grp6M
         rrq8QD8XWpTCMSSYTFASg3QHAhFHZKnUocvfTZGsknucG4+QEw5nTzWRBZ9Az+AiEpSW
         INSFfwhcTcfQZzhMYp3ZnSZvUppDAL2aopm7DxgH7RV01HYRQ6pLyzyPUa8OG/ILh31z
         Zvk71aqbkcpHAR5smdfkx6MGbwy5WGYY00cZl/vBX5n/Pk+7yKGjVReZV86yQd5hCXmr
         TzGA==
X-Gm-Message-State: AO0yUKUfI61BC6DhKViRQqTT7se/Di7aYmfRwn0BcRime301iYRder+n
        KfMbK+j1M8mwwGCDq73T0SM/KQ==
X-Google-Smtp-Source: AK7set9x7hqjnN6KvkKgVfidPa131/IDdJPRASJD+jji6O92VQMV1e3hnubtncWiTLiBrYRoBg6eVg==
X-Received: by 2002:a17:90a:1913:b0:237:659a:a456 with SMTP id 19-20020a17090a191300b00237659aa456mr410281pjg.49.1678901650925;
        Wed, 15 Mar 2023 10:34:10 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:c20b:6fb4:a029:ed06])
        by smtp.gmail.com with ESMTPSA id y72-20020a638a4b000000b005030a00085asm3669025pgd.46.2023.03.15.10.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:34:10 -0700 (PDT)
Date:   Wed, 15 Mar 2023 11:34:08 -0600
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
Subject: Re: [PATCH v8 05/11] remoteproc: mediatek: Extract remoteproc
 initialization flow
Message-ID: <20230315173408.GA2357129@p14s>
References: <20230303083355.3378-1-tinghan.shen@mediatek.com>
 <20230303083355.3378-6-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303083355.3378-6-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shen,

On Fri, Mar 03, 2023 at 04:33:49PM +0800, Tinghan Shen wrote:
> This is the preparation for probing multi-core SCP. The remoteproc
> initialization flow is similar on cores and is reuesd to avoid

s/reuesd/reused

> redundant code.
> 
> The registers of config and l1tcm are shared for multi-core
> SCP. Reuse the mapped addresses for all cores.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/remoteproc/mtk_scp.c | 62 ++++++++++++++++++++++++------------
>  1 file changed, 42 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index a3b9bc158cd9..bdb5d87eeaa3 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -23,6 +23,13 @@
>  #define MAX_CODE_SIZE 0x500000
>  #define SECTION_NAME_IPI_BUFFER ".ipi_buffer"
>  
> +struct mtk_scp_of_regs {
> +	void __iomem *reg_base;
> +	void __iomem *l1tcm_base;
> +	size_t l1tcm_size;
> +	phys_addr_t l1tcm_phys;
> +};
> +
>  /**
>   * scp_get() - get a reference to SCP.
>   *
> @@ -855,7 +862,8 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
>  	}
>  }
>  
> -static int scp_probe(struct platform_device *pdev)
> +static int scp_rproc_init(struct platform_device *pdev,
> +			  struct mtk_scp_of_regs *of_regs)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
> @@ -879,6 +887,11 @@ static int scp_probe(struct platform_device *pdev)
>  	scp->data = of_device_get_match_data(dev);
>  	platform_set_drvdata(pdev, scp);
>  
> +	scp->reg_base = of_regs->reg_base;
> +	scp->l1tcm_base = of_regs->l1tcm_base;
> +	scp->l1tcm_size = of_regs->l1tcm_size;
> +	scp->l1tcm_phys = of_regs->l1tcm_phys;
> +
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
>  	scp->sram_base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(scp->sram_base))
> @@ -888,24 +901,6 @@ static int scp_probe(struct platform_device *pdev)
>  	scp->sram_size = resource_size(res);
>  	scp->sram_phys = res->start;
>  
> -	/* l1tcm is an optional memory region */
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "l1tcm");
> -	scp->l1tcm_base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(scp->l1tcm_base)) {
> -		ret = PTR_ERR(scp->l1tcm_base);
> -		if (ret != -EINVAL) {
> -			return dev_err_probe(dev, ret, "Failed to map l1tcm memory\n");
> -		}
> -	} else {
> -		scp->l1tcm_size = resource_size(res);
> -		scp->l1tcm_phys = res->start;
> -	}
> -
> -	scp->reg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
> -	if (IS_ERR(scp->reg_base))
> -		return dev_err_probe(dev, PTR_ERR(scp->reg_base),
> -				     "Failed to parse and map cfg memory\n");
> -
>  	ret = scp->data->scp_clk_get(scp);
>  	if (ret)
>  		return ret;
> @@ -933,7 +928,6 @@ static int scp_probe(struct platform_device *pdev)
>  	ret = devm_request_threaded_irq(dev, platform_get_irq(pdev, 0), NULL,
>  					scp_irq_handler, IRQF_ONESHOT,
>  					pdev->name, scp);
> -

Spurious change

>  	if (ret) {
>  		dev_err(dev, "failed to request irq\n");
>  		goto remove_subdev;
> @@ -957,6 +951,34 @@ static int scp_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int scp_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	struct mtk_scp_of_regs scp_regs;
> +	int ret;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> +	scp_regs.reg_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(scp_regs.reg_base))
> +		return dev_err_probe(dev, PTR_ERR(scp_regs.reg_base),
> +				     "Failed to parse and map cfg memory\n");
> +
> +	/* l1tcm is an optional memory region */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "l1tcm");
> +	scp_regs.l1tcm_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(scp_regs.l1tcm_base)) {
> +		ret = PTR_ERR(scp_regs.l1tcm_base);
> +		if (ret != -EINVAL)
> +			return dev_err_probe(dev, ret, "Failed to map l1tcm memory\n");
> +	} else {
> +		scp_regs.l1tcm_size = resource_size(res);
> +		scp_regs.l1tcm_phys = res->start;
> +	}

If l1tcm is not specified scp_regs::[l1tcm_size, l1tcm_phys] contains garbage
that is then communicated to scp_rproc_init().  It seems to be the case in the
original code as well.

More comments to come.

> +
> +	return scp_rproc_init(pdev, &scp_regs);
> +}
> +
>  static int scp_remove(struct platform_device *pdev)
>  {
>  	struct mtk_scp *scp = platform_get_drvdata(pdev);
> -- 
> 2.18.0
> 
