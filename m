Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5EB72563F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbjFGHqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239816AbjFGHpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:45:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11F026A0;
        Wed,  7 Jun 2023 00:44:22 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E840F6606EF8;
        Wed,  7 Jun 2023 08:43:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686123861;
        bh=7dPWa7Ho4xBDIwK8t0uY7p+Ufp8fjYMMkz9g433WDdc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=it66zNf05C0WbUEo45SO0n+cYnBFkdVr9T/1cae9pXO81lGueWIqtO8kd6e2XLmjn
         5uS2a5NtfQCBaUAlv+nknmaQxEPqmogbGOZnn6mYGuX7OpmPsJHnnu2gqp/xgZgv9V
         SvwVKJkUW3m5jBA2yoSbSWLkaCVx4QjlOpupkVanGB7gbd5AFelGqV/wRM8eLnxG7q
         +Nujz30NWI0900wGvIVMYSuR6/bbl2MhQ+MCQ2g2+qXoa/LjV5LZBM/4l5HK3cKAWC
         avFLm7DEzdYZ51S/+cPdjXVyDVubl+vz9kS5jizsP8g6XMRiBj9nEB0q1N7GF0hHi7
         WtLDzsDBJDWjA==
Message-ID: <d8053fc1-cace-b14b-57c6-387c0d664837@collabora.com>
Date:   Wed, 7 Jun 2023 09:43:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v13 05/11] remoteproc: mediatek: Introduce cluster on
 single-core SCP
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230607072222.8628-1-tinghan.shen@mediatek.com>
 <20230607072222.8628-6-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230607072222.8628-6-tinghan.shen@mediatek.com>
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

Il 07/06/23 09:22, Tinghan Shen ha scritto:
> This is the preliminary step for probing multi-core SCP.
> The initialization procedure for remoteproc is similar for both
> single-core and multi-core architectures and is reusing to avoid
> redundant code.
> 
> Rewrite the probing flow of single-core SCP to adapt with the 'cluster'
> concept needed by probing the multi-core SCP. The main differences
> are,
> - the SCP core object(s) is maintained at the cluster list instead of at
>    the platofmr device driver data property.

s/platofmr/platform/g

> - save the cluster information at the platofmr device driver data property.
> - In order to keep the compatibility of exported SCP APIs which getting
>    the SCP core object by SCP node phandle, move the SCP core object
>    pointers to the platform device platform data property.
> 
> The registers of config and l1tcm are shared for multi-core
> SCP. Reuse the mapped addresses for all cores.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   drivers/remoteproc/mtk_common.h |   2 +
>   drivers/remoteproc/mtk_scp.c    | 151 +++++++++++++++++++++++---------
>   2 files changed, 112 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> index c0905aec3b4b..56395e8664cb 100644
> --- a/drivers/remoteproc/mtk_common.h
> +++ b/drivers/remoteproc/mtk_common.h
> @@ -128,6 +128,8 @@ struct mtk_scp {
>   	size_t dram_size;
>   
>   	struct rproc_subdev *rpmsg_subdev;
> +
> +	struct list_head elem;
>   };
>   
>   /**
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index d66822dad943..c8fc6b46f82b 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -23,6 +23,14 @@
>   #define MAX_CODE_SIZE 0x500000
>   #define SECTION_NAME_IPI_BUFFER ".ipi_buffer"
>   
> +struct mtk_scp_of_cluster {
> +	void __iomem *reg_base;
> +	void __iomem *l1tcm_base;
> +	size_t l1tcm_size;
> +	phys_addr_t l1tcm_phys;
> +	struct list_head mtk_scp_list;
> +};
> +
>   /**
>    * scp_get() - get a reference to SCP.
>    *
> @@ -51,7 +59,7 @@ struct mtk_scp *scp_get(struct platform_device *pdev)
>   		return NULL;
>   	}
>   
> -	return platform_get_drvdata(scp_pdev);
> +	return *(struct mtk_scp **)dev_get_platdata(&scp_pdev->dev);
>   }
>   EXPORT_SYMBOL_GPL(scp_get);
>   
> @@ -810,14 +818,14 @@ static void scp_unmap_memory_region(struct mtk_scp *scp)
>   static int scp_register_ipi(struct platform_device *pdev, u32 id,
>   			    ipi_handler_t handler, void *priv)
>   {
> -	struct mtk_scp *scp = platform_get_drvdata(pdev);
> +	struct mtk_scp *scp = *(struct mtk_scp **)dev_get_platdata(&pdev->dev);
>   
>   	return scp_ipi_register(scp, id, handler, priv);
>   }
>   
>   static void scp_unregister_ipi(struct platform_device *pdev, u32 id)
>   {
> -	struct mtk_scp *scp = platform_get_drvdata(pdev);
> +	struct mtk_scp *scp = *(struct mtk_scp **)dev_get_platdata(&pdev->dev);
>   
>   	scp_ipi_unregister(scp, id);
>   }
> @@ -825,7 +833,7 @@ static void scp_unregister_ipi(struct platform_device *pdev, u32 id)
>   static int scp_send_ipi(struct platform_device *pdev, u32 id, void *buf,
>   			unsigned int len, unsigned int wait)
>   {
> -	struct mtk_scp *scp = platform_get_drvdata(pdev);
> +	struct mtk_scp *scp = *(struct mtk_scp **)dev_get_platdata(&pdev->dev);
>   
>   	return scp_ipi_send(scp, id, buf, len, wait);
>   }
> @@ -855,7 +863,8 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
>   	}
>   }
>   
> -static int scp_probe(struct platform_device *pdev)
> +static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
> +				      struct mtk_scp_of_cluster *scp_cluster)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct device_node *np = dev->of_node;
> @@ -867,52 +876,42 @@ static int scp_probe(struct platform_device *pdev)
>   
>   	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
>   	if (ret < 0 && ret != -EINVAL)
> -		return ret;
> +		return ERR_PTR(ret);
>   
>   	rproc = devm_rproc_alloc(dev, np->name, &scp_ops, fw_name, sizeof(*scp));
> -	if (!rproc)
> -		return dev_err_probe(dev, -ENOMEM, "unable to allocate remoteproc\n");
> +	if (!rproc) {
> +		dev_err(dev, "unable to allocate remoteproc\n");
> +		return ERR_PTR(-ENOMEM);

Why are you converting those dev_err_probe to dev_err->return?!

Regards,
Angelo

