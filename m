Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF39B5FCE59
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJLW1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJLW07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:26:59 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772B1FFFA7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:26:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so351416pjl.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mrwQdR2J8kS9YrTypYBLGFaW0FqAVl4WDkZETl33NyE=;
        b=IKH22IEO21lTKuX8aklrYd7w++sTqX3f8bKrH2bjo6YI5/j26QHdO2MHNsvOtj3WvX
         vQ6nTedWMoSdSSa29Fz9rtWCo3ZMiMcVOf2QEU//f9H6SBgS6T0Bz9PjNXTsZOQ4Pj3q
         ExOV0P1yFy7P7LOpPvgq7RzfskEVWbQkkp0gmECBscW78crY/TPXCAgOcVs3yyw1hh47
         Oh1Bv5/9OXMFEPHNF0+wLfwVEMDYUZVw/DiQNeZ6UdIBVKpdzcKUCUId5GZSb7I1AsYY
         Eyne/oJQ/EaVIPxbYZRHsIUVULXGjReby1HefodJR+5MQfPsnW8KtuVy8mXBBhUpHbXY
         YK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrwQdR2J8kS9YrTypYBLGFaW0FqAVl4WDkZETl33NyE=;
        b=sW/wi/Cofn7DJ1cD9owKxCiW0REa8ckRcj21rMPh4Fs0iFWEqT0s7ukwecBioF4o6f
         rK1i1I0gEc6JLNvWBqEhJVNLX/4+a+0El95QOp4WnoqneNH8cSyswaIJrmnyivyl2/ee
         HeXnJ4dhpbcKjiySKyZJ4qGSRZbMpIHV7TjAcErAVR1JxYF06W8EINz5prAefiDn+Sxm
         LsJFJCCW8tOTgd9TmWTzHZ5z/HTSvyhkf+mRnAxEBLuGHajisEQ/UjLqIwDuwHUNGbQz
         dxH4+90zAanyXcsYWTpz+EUPgaNC5FALsk+a3YfLq7w1hpgx2/QD4OoaxSZ7CWJdn9Nj
         1BsA==
X-Gm-Message-State: ACrzQf0UbyML0B73YP22L/hzkyUUvoe8rGDd8eFNQOSsmFkLXbn2FxfG
        Y1/XSbzCHCTrXRyJyPm6KhCZMw==
X-Google-Smtp-Source: AMsMyM7ykg5eMlyJbgoPj9EL5AVwiYlzwLezl5l8NDMMJg7qtk+unmE5+72wFFWKujBiWr11TGM/Dg==
X-Received: by 2002:a17:903:1003:b0:181:6c26:1114 with SMTP id a3-20020a170903100300b001816c261114mr23422321plb.75.1665613617531;
        Wed, 12 Oct 2022 15:26:57 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z17-20020aa79911000000b00562a90f9875sm347658pff.167.2022.10.12.15.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 15:26:56 -0700 (PDT)
Date:   Wed, 12 Oct 2022 16:26:54 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V6 6/7] remoteproc: imx_rproc: request mbox channel later
Message-ID: <20221012222654.GD1196937@p14s>
References: <20220929061704.1571746-1-peng.fan@oss.nxp.com>
 <20220929061704.1571746-7-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929061704.1571746-7-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 02:17:03PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> It is possible that when remote processor crash, the communication
> channel will be broken with garbage value in mailbox, such as
> when Linux is issuing a message through mailbox, remote processor
> crashes, we need free & rebuild the mailbox channels to make sure
> no garbage value in mailbox channels.
> 
> So move the request/free to start/stop for managing remote procesosr in
> Linux, move to attach/detach for remote processor is out of control of
> Linux.
> 
> Previous, we just request mbox when attach for CM4 boot early before
> Linux, but if mbox defer probe, remoteproc core will do resource cleanup
> and corrupt resource table for later probe.
> 
> So move request mbox ealier and still keep mbox request when attach
> for self recovery case, but keep a check when request/free mbox.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 8175c4c9aa22..bece44b46719 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -84,6 +84,8 @@ struct imx_rproc_mem {
>  #define ATT_CORE_MASK   0xffff
>  #define ATT_CORE(I)     BIT((I))
>  
> +static int imx_rproc_xtr_mbox_init(struct rproc *rproc);
> +static void imx_rproc_free_mbox(struct rproc *rproc);
>  static int imx_rproc_detach_pd(struct rproc *rproc);
>  
>  struct imx_rproc {
> @@ -357,6 +359,10 @@ static int imx_rproc_start(struct rproc *rproc)
>  	struct arm_smccc_res res;
>  	int ret;
>  
> +	ret = imx_rproc_xtr_mbox_init(rproc);
> +	if (ret)
> +		return ret;
> +
>  	switch (dcfg->method) {
>  	case IMX_RPROC_MMIO:
>  		ret = regmap_update_bits(priv->regmap, dcfg->src_reg, dcfg->src_mask,
> @@ -407,6 +413,8 @@ static int imx_rproc_stop(struct rproc *rproc)
>  
>  	if (ret)
>  		dev_err(dev, "Failed to stop remote core\n");
> +	else
> +		imx_rproc_free_mbox(rproc);
>  
>  	return ret;
>  }
> @@ -592,7 +600,7 @@ static void imx_rproc_kick(struct rproc *rproc, int vqid)
>  
>  static int imx_rproc_attach(struct rproc *rproc)
>  {
> -	return 0;
> +	return imx_rproc_xtr_mbox_init(rproc);
>  }
>  
>  static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
> @@ -720,6 +728,9 @@ static int imx_rproc_xtr_mbox_init(struct rproc *rproc)
>  	struct device *dev = priv->dev;
>  	struct mbox_client *cl;
>  
> +	if (priv->tx_ch && priv->rx_ch)
> +		return 0;
> +

Why is this needed?  The remoteproc core's state machine driven by rproc->state
guarantees that imx_rproc_start(), imx_rproc_stop() and imx_rproc_attach are not
called more than once.

And why is imx_rproc_xtr_mbox_init() in imx_rproc_probe() not removed?

>  	if (!of_get_property(dev->of_node, "mbox-names", NULL))
>  		return 0;
>  
> @@ -749,8 +760,15 @@ static void imx_rproc_free_mbox(struct rproc *rproc)
>  {
>  	struct imx_rproc *priv = rproc->priv;
>  
> -	mbox_free_channel(priv->tx_ch);
> -	mbox_free_channel(priv->rx_ch);
> +	if (priv->tx_ch) {
> +		mbox_free_channel(priv->tx_ch);
> +		priv->tx_ch = NULL;
> +	}
> +
> +	if (priv->rx_ch) {
> +		mbox_free_channel(priv->rx_ch);
> +		priv->rx_ch = NULL;
> +	}
>  }
>  
>  static void imx_rproc_put_scu(struct rproc *rproc)
> @@ -779,6 +797,8 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
>  	if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group == IMX_SC_IRQ_GROUP_REBOOTED)))
>  		return 0;
>  
> +	imx_rproc_free_mbox(priv->rproc);

Why putting this here when it will be called again in imx_rproc_stop()?  If you
need it for the attached scenario, create imx_rproc_detach() and add it there.

> +
>  	rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
>  
>  	pr_info("Partition%d reset!\n", priv->rproc_pt);
> -- 
> 2.37.1
> 
