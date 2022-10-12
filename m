Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124AC5FCD76
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJLVp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJLVpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:45:24 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ADC29367
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:45:22 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g28so206226pfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XnSNmVn3ksCv9S8MOdNsWwpNq6AQ/Pcm1KHOD5G+EMY=;
        b=MGsnnOGYTmmJRtA8umlAumAHrBbfsJN0AzQcAOW94b1F1EZyLaMrEapXfxR+MbLt1F
         W2dt3XXHj0SG4HooyYMQ9meAu/G8kNck5O2VrATPQ2cGiCcbfelZXmZx7q9pZXhrLgRd
         IaBflRnpcnLpOFjCPjOR/w1kgyhbDdQPHbZko4MGBD5MyAVlVf2dG03HSSImTJSC/i9S
         jCZWDLNzif5W+2yjoxkfY2WHUGV5rhNAHCDAvB+LWqLgdoicKE2bZkCabXNfDu2TyszF
         jUbvzs7DEtjoSPUKBfYdNk3Q9L+iGArIxaCeNPJan3kmlNQbF0IkuahIa8meBvSEwLi6
         D63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnSNmVn3ksCv9S8MOdNsWwpNq6AQ/Pcm1KHOD5G+EMY=;
        b=J2cKrKbM21eVoULDcfVWW6aVeSTaij/KkkTbTuZ0sT9Rm8wWkQELNrYuF8Egzt3u4H
         ahnigT6WpiRyy22YAblvYLntGVexnj3NzDCdaPpr0O3b2XQ6Uz03CLFBf3JY9HxeVBXl
         9jJO4XPPwR0HqAMEZsHopixiD003sY1AZye6YOPF5piYZ0hG/+R6y03Nj3X2yp3dfFkf
         Mbl9av+LZRgwWIyvoJgb1OnIQ67SQsXat9oSacdct1FkwxjFEIkcifJDNmkJ7zjvuWUn
         1XzI67KwJNe5V5zLo13JEllC9LLJ4dzi4GRN4jOUn/iLm4ekGO+LpS6hA7l+rdj2ScSH
         rkwQ==
X-Gm-Message-State: ACrzQf221dKwMbltWmXMacv6iLDYeyJuMNk5uoEj+9s7LpoSLek2oFyE
        TwD9TQ8YIWxwsY+hJWj+bbdXLw==
X-Google-Smtp-Source: AMsMyM6HbXJvvwCvGKgvg48z9e4cYGEm947nwbG/SYEqqcBQ9dDCX+0Mato1F438T8S1GJHJ2ZdJxQ==
X-Received: by 2002:a63:4b4c:0:b0:45a:5f8:b49d with SMTP id k12-20020a634b4c000000b0045a05f8b49dmr26997295pgl.490.1665611121849;
        Wed, 12 Oct 2022 14:45:21 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id ik7-20020a170902ab0700b0016f8e8032c4sm11006457plb.129.2022.10.12.14.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:45:20 -0700 (PDT)
Date:   Wed, 12 Oct 2022 15:45:18 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V6 4/7] remoteproc: imx_rproc: support kicking Mcore from
 Linux for i.MX8QXP
Message-ID: <20221012214518.GB1196937@p14s>
References: <20220929061704.1571746-1-peng.fan@oss.nxp.com>
 <20220929061704.1571746-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929061704.1571746-5-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 02:17:01PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When M4 is in the same hardware partition with Cortex-A, it
> could be start/stop by Linux.
> 
> Added power domain to make sure M4 could run, it requires several power
> domains to work. Make clk always optional for i.MX8QXP, because
> SCFW handles it when power up M4 core.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 88 ++++++++++++++++++++++++++++++++--
>  1 file changed, 85 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index a56aecae00c6..7d2e11aed0aa 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -16,6 +16,7 @@
>  #include <linux/of_reserved_mem.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/regmap.h>
>  #include <linux/remoteproc.h>
>  #include <linux/workqueue.h>
> @@ -79,6 +80,8 @@ struct imx_rproc_mem {
>  #define ATT_OWN		BIT(1)
>  #define ATT_IOMEM	BIT(2)
>  
> +static int imx_rproc_detach_pd(struct rproc *rproc);
> +
>  struct imx_rproc {
>  	struct device			*dev;
>  	struct regmap			*regmap;
> @@ -96,6 +99,10 @@ struct imx_rproc {
>  	struct notifier_block		rproc_nb;
>  	u32				rproc_pt;	/* partition id */
>  	u32				rsrc_id;	/* resource id */
> +	u32				entry;		/* cpu start address */
> +	int                             num_pd;
> +	struct device                   **pd_dev;
> +	struct device_link              **pd_dev_link;
>  };
>  
>  static const struct imx_rproc_att imx_rproc_att_imx93[] = {
> @@ -335,6 +342,9 @@ static int imx_rproc_start(struct rproc *rproc)
>  		arm_smccc_smc(IMX_SIP_RPROC, IMX_SIP_RPROC_START, 0, 0, 0, 0, 0, 0, &res);
>  		ret = res.a0;
>  		break;
> +	case IMX_RPROC_SCU_API:
> +		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc_id, true, priv->entry);
> +		break;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -364,6 +374,9 @@ static int imx_rproc_stop(struct rproc *rproc)
>  		if (res.a1)
>  			dev_info(dev, "Not in wfi, force stopped\n");
>  		break;
> +	case IMX_RPROC_SCU_API:
> +		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc_id, false, priv->entry);
> +		break;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -713,8 +726,10 @@ static void imx_rproc_put_scu(struct rproc *rproc)
>  	if (dcfg->method != IMX_RPROC_SCU_API)
>  		return;
>  
> -	if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
> +	if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id)) {
> +		imx_rproc_detach_pd(rproc);
>  		return;
> +	}
>  
>  	imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED, BIT(priv->rproc_pt), false);
>  	imx_scu_irq_unregister_notifier(&priv->rproc_nb);
> @@ -736,6 +751,69 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
>  	return 0;
>  }
>  
> +static int imx_rproc_attach_pd(struct imx_rproc *priv)
> +{
> +	struct device *dev = priv->dev;
> +	int ret, i;
> +
> +	priv->num_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
> +						  "#power-domain-cells");
> +	if (priv->num_pd <= 1)

What happens if we get 1 power domains?  How is it handled?  There should be a
comment explaining what is happening here.

> +		return 0;
> +
> +	priv->pd_dev = devm_kmalloc_array(dev, priv->num_pd, sizeof(*priv->pd_dev), GFP_KERNEL);
> +	if (!priv->pd_dev)
> +		return -ENOMEM;
> +
> +	priv->pd_dev_link = devm_kmalloc_array(dev, priv->num_pd, sizeof(*priv->pd_dev_link),
> +					       GFP_KERNEL);
> +
> +	if (!priv->pd_dev_link)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < priv->num_pd; i++) {
> +		priv->pd_dev[i] = dev_pm_domain_attach_by_id(dev, i);
> +		if (IS_ERR(priv->pd_dev[i])) {
> +			ret = PTR_ERR(priv->pd_dev[i]);
> +			goto detach_pd;
> +		}
> +
> +		priv->pd_dev_link[i] = device_link_add(dev, priv->pd_dev[i], DL_FLAG_STATELESS |
> +						       DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
> +		if (!priv->pd_dev_link[i]) {
> +			dev_pm_domain_detach(priv->pd_dev[i], false);
> +			ret = -EINVAL;
> +			goto detach_pd;
> +		}
> +	}
> +
> +	return 0;
> +
> +detach_pd:
> +	while (--i >= 0) {
> +		device_link_del(priv->pd_dev_link[i]);
> +		dev_pm_domain_detach(priv->pd_dev[i], false);
> +	}
> +
> +	return ret;
> +}
> +
> +static int imx_rproc_detach_pd(struct rproc *rproc)
> +{
> +	struct imx_rproc *priv = rproc->priv;
> +	int i;
> +
> +	if (priv->num_pd <= 1)

Same here.

With the above:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> +		return 0;
> +
> +	for (i = 0; i < priv->num_pd; i++) {
> +		device_link_del(priv->pd_dev_link[i]);
> +		dev_pm_domain_detach(priv->pd_dev[i], false);
> +	}
> +
> +	return 0;
> +}
> +
>  static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  {
>  	struct regmap_config config = { .name = "imx-rproc" };
> @@ -770,8 +848,12 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
>  		 * and Linux could only do IPC with Mcore and nothing else.
>  		 */
> -		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
> -			return 0;
> +		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id)) {
> +			if (of_property_read_u32(dev->of_node, "fsl,entry-address", &priv->entry))
> +				return -EINVAL;
> +
> +			return imx_rproc_attach_pd(priv);
> +		}
>  
>  		priv->rproc->state = RPROC_DETACHED;
>  		priv->rproc->recovery_disabled = true;
> -- 
> 2.37.1
> 
