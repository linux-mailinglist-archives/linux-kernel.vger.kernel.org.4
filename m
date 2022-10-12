Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AEA5FCD15
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJLVX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiJLVXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:23:48 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8575C1204C7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:23:46 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p14so178398pfq.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0fllDq8R/NvidLJEwlTuoSMCemziS6TmBihyBD8m3EI=;
        b=cWwFxm6DmOiGZap3PT8dYQAohuNvYbEGf7VSZLYHHJF9PzC/CH71sq387h96sl5aPp
         wdp/igfGWvmgF/ZRmraJy5nV7bXzCWSRduokNKi4U6VhLfhvu30nZJbB+Oh+ON2Mxl/t
         Z/AIZToLGF7IQUD7PJw7Rv4uRwe+Nrh5N+dEuNXOUUbkvnfe7aaN4/DRyaKxLYCcjEeP
         H7PATNL6mQEh9iXE5PNftE42agvfC0ztFJkiEpUAjvIqxGOFlMdImpd1kcDUVoJY6AkU
         Bzzgm8Ht1/zsB/2tOgtvAC9uqIlhYvgicEdR90VI9Ji4iyfKgeEXUngyz6eYeDxrOWyj
         dlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fllDq8R/NvidLJEwlTuoSMCemziS6TmBihyBD8m3EI=;
        b=sZmaLY8iuRxmarjvF9CGjpqeyoCB/zllnWwPlhqOV/Lj5ac9zrO3Ged20MF2b8q1O6
         Bvmu8AKLgwEItUc4g6CCUzbsU8lGrjkK+goJQZpjzuf5HhM6+4E6rhwU8se2yvk0aaN/
         cYeUJdDOPLwIckyEarxonuIp7/rCZEUzkAqiL9dckhhwQfE0mu8p2uAY5JNuOvISLHuQ
         54nJIyt2hRpQCU7Ffpvj5chmlRadVIEsz3qbYdybLoD/EAUPIzZmHDnKGyaPmotOicUv
         o6KZqDnL+jjrAki6Mx5yTxVVRo0XLuwRYoavJv4bdTDaJRzLCefiuiXslCrJCLuqa1I6
         bTiQ==
X-Gm-Message-State: ACrzQf1iDA6qA23ZDUGFrHD7Zabo1wO8fwt3abVCPKiQ4SHv94QfYiji
        zUqaKOIZDfuVV5aOByOPqkl8jQ==
X-Google-Smtp-Source: AMsMyM710vyGLYDDZjZmX/UXLk0efqPqSLGAtM7v2nEtet8TeeOpKf8blV2uniBgjkhh52iU2rDl9A==
X-Received: by 2002:a05:6a00:181c:b0:563:2c6c:2a7a with SMTP id y28-20020a056a00181c00b005632c6c2a7amr21625965pfa.28.1665609824478;
        Wed, 12 Oct 2022 14:23:44 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090abb0f00b0020d51aefb82sm1889902pjr.19.2022.10.12.14.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:23:43 -0700 (PDT)
Date:   Wed, 12 Oct 2022 15:23:41 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V6 3/7] remoteproc: imx_rproc: support attaching to
 i.MX8QXP M4
Message-ID: <20221012212341.GA1196937@p14s>
References: <20220929061704.1571746-1-peng.fan@oss.nxp.com>
 <20220929061704.1571746-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929061704.1571746-4-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 02:17:00PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When M4 is kicked by SCFW, M4 runs in its own hardware partition, Linux
> could only do IPC with M4, it could not start, stop, update image.
> 
> We disable recovery reboot when M4 is managed by SCFW, because
> remoteproc core still not support M4 auto-recovery without loading
> image.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 108 ++++++++++++++++++++++++++++++++-
>  1 file changed, 107 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 7cc4fd207e2d..a56aecae00c6 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -6,6 +6,7 @@
>  #include <linux/arm-smccc.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> +#include <linux/firmware/imx/sci.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/mailbox_client.h>
> @@ -59,6 +60,8 @@
>  #define IMX_SIP_RPROC_STARTED		0x01
>  #define IMX_SIP_RPROC_STOP		0x02
>  
> +#define IMX_SC_IRQ_GROUP_REBOOTED	5
> +
>  /**
>   * struct imx_rproc_mem - slim internal memory structure
>   * @cpu_addr: MPU virtual address of the memory region
> @@ -89,6 +92,10 @@ struct imx_rproc {
>  	struct work_struct		rproc_work;
>  	struct workqueue_struct		*workqueue;
>  	void __iomem			*rsc_table;
> +	struct imx_sc_ipc		*ipc_handle;
> +	struct notifier_block		rproc_nb;
> +	u32				rproc_pt;	/* partition id */
> +	u32				rsrc_id;	/* resource id */
>  };
>  
>  static const struct imx_rproc_att imx_rproc_att_imx93[] = {
> @@ -117,6 +124,18 @@ static const struct imx_rproc_att imx_rproc_att_imx93[] = {
>  	{ 0xD0000000, 0xa0000000, 0x10000000, 0 },
>  };
>  
> +static const struct imx_rproc_att imx_rproc_att_imx8qxp[] = {
> +	{ 0x08000000, 0x08000000, 0x10000000, 0 },
> +	/* TCML/U */
> +	{ 0x1FFE0000, 0x34FE0000, 0x00040000, ATT_OWN | ATT_IOMEM },
> +	/* OCRAM(Low 96KB) */
> +	{ 0x21000000, 0x00100000, 0x00018000, 0 },
> +	/* OCRAM */
> +	{ 0x21100000, 0x00100000, 0x00040000, 0 },
> +	/* DDR (Data) */
> +	{ 0x80000000, 0x80000000, 0x60000000, 0 },
> +};
> +
>  static const struct imx_rproc_att imx_rproc_att_imx8mn[] = {
>  	/* dev addr , sys addr  , size	    , flags */
>  	/* ITCM   */
> @@ -255,6 +274,12 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8mq = {
>  	.method		= IMX_RPROC_MMIO,
>  };
>  
> +static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp = {
> +	.att		= imx_rproc_att_imx8qxp,
> +	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8qxp),
> +	.method		= IMX_RPROC_SCU_API,
> +};
> +
>  static const struct imx_rproc_dcfg imx_rproc_cfg_imx8ulp = {
>  	.att		= imx_rproc_att_imx8ulp,
>  	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8ulp),
> @@ -680,6 +705,37 @@ static void imx_rproc_free_mbox(struct rproc *rproc)
>  	mbox_free_channel(priv->rx_ch);
>  }
>  
> +static void imx_rproc_put_scu(struct rproc *rproc)
> +{
> +	struct imx_rproc *priv = rproc->priv;
> +	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
> +
> +	if (dcfg->method != IMX_RPROC_SCU_API)
> +		return;
> +
> +	if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))

Yes, now it makes sense.

> +		return;
> +
> +	imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED, BIT(priv->rproc_pt), false);
> +	imx_scu_irq_unregister_notifier(&priv->rproc_nb);
> +}
> +
> +static int imx_rproc_partition_notify(struct notifier_block *nb,
> +				      unsigned long event, void *group)
> +{
> +	struct imx_rproc *priv = container_of(nb, struct imx_rproc, rproc_nb);
> +
> +	/* Ignore other irqs */
> +	if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group == IMX_SC_IRQ_GROUP_REBOOTED)))
> +		return 0;
> +
> +	rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
> +
> +	pr_info("Partition%d reset!\n", priv->rproc_pt);
> +
> +	return 0;
> +}
> +
>  static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  {
>  	struct regmap_config config = { .name = "imx-rproc" };
> @@ -689,6 +745,7 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  	struct arm_smccc_res res;
>  	int ret;
>  	u32 val;
> +	u8 pt;
>  
>  	switch (dcfg->method) {
>  	case IMX_RPROC_NONE:
> @@ -699,6 +756,51 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  		if (res.a0)
>  			priv->rproc->state = RPROC_DETACHED;
>  		return 0;
> +	case IMX_RPROC_SCU_API:
> +		ret = imx_scu_get_handle(&priv->ipc_handle);
> +		if (ret)
> +			return ret;
> +		ret = of_property_read_u32(dev->of_node, "fsl,resource-id", &priv->rsrc_id);
> +		if (ret) {
> +			dev_err(dev, "No fsl,resource-id property\n");
> +			return ret;
> +		}
> +
> +		/*
> +		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
> +		 * and Linux could only do IPC with Mcore and nothing else.
> +		 */
> +		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
> +			return 0;
> +
> +		priv->rproc->state = RPROC_DETACHED;
> +		priv->rproc->recovery_disabled = true;
> +
> +		/* Get partition id and enable irq in SCFW */
> +		ret = imx_sc_rm_get_resource_owner(priv->ipc_handle, priv->rsrc_id, &pt);
> +		if (ret) {
> +			dev_err(dev, "not able to get resource owner\n");
> +			return ret;
> +		}
> +
> +		priv->rproc_pt = pt;
> +		priv->rproc_nb.notifier_call = imx_rproc_partition_notify;
> +
> +		ret = imx_scu_irq_register_notifier(&priv->rproc_nb);
> +		if (ret) {
> +			dev_warn(dev, "register scu notifier failed.\n");

Either make this a dev_err() or remove entirely.

> +			return ret;
> +		}
> +
> +		ret = imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED, BIT(priv->rproc_pt),
> +					       true);
> +		if (ret) {
> +			imx_scu_irq_unregister_notifier(&priv->rproc_nb);
> +			dev_warn(dev, "Enable irq failed.\n");

Same here.

With the above:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>


> +			return ret;
> +		}
> +
> +		return 0;
>  	default:
>  		break;
>  	}
> @@ -803,7 +905,7 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  
>  	ret = imx_rproc_clk_enable(priv);
>  	if (ret)
> -		goto err_put_mbox;
> +		goto err_put_scu;
>  
>  	INIT_WORK(&priv->rproc_work, imx_rproc_vq_work);
>  
> @@ -820,6 +922,8 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  
>  err_put_clk:
>  	clk_disable_unprepare(priv->clk);
> +err_put_scu:
> +	imx_rproc_put_scu(rproc);
>  err_put_mbox:
>  	imx_rproc_free_mbox(rproc);
>  err_put_wkq:
> @@ -837,6 +941,7 @@ static int imx_rproc_remove(struct platform_device *pdev)
>  
>  	clk_disable_unprepare(priv->clk);
>  	rproc_del(rproc);
> +	imx_rproc_put_scu(rproc);
>  	imx_rproc_free_mbox(rproc);
>  	destroy_workqueue(priv->workqueue);
>  	rproc_free(rproc);
> @@ -852,6 +957,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
>  	{ .compatible = "fsl,imx8mm-cm4", .data = &imx_rproc_cfg_imx8mq },
>  	{ .compatible = "fsl,imx8mn-cm7", .data = &imx_rproc_cfg_imx8mn },
>  	{ .compatible = "fsl,imx8mp-cm7", .data = &imx_rproc_cfg_imx8mn },
> +	{ .compatible = "fsl,imx8qxp-cm4", .data = &imx_rproc_cfg_imx8qxp },
>  	{ .compatible = "fsl,imx8ulp-cm33", .data = &imx_rproc_cfg_imx8ulp },
>  	{ .compatible = "fsl,imx93-cm33", .data = &imx_rproc_cfg_imx93 },
>  	{},
> -- 
> 2.37.1
> 
