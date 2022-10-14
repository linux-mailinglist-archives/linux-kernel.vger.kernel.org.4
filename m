Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2524E5FF321
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJNRtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiJNRtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:49:10 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC7D1D443A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 10:49:08 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r18so4899722pgr.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 10:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fgg+Z6tz1c5hzcpV+3M0EHGrTn1Q32r1s7UqtR7H4Z4=;
        b=rKjysMoEJFnKsWxo+azU9/r8jB6dgiRWKOI8YL8DIkT2T9zE8kVZiWLxz5Pz/jSj8Y
         VKJB7wkhAtpSK6/p6LY7kLTa7zc5bR07bnpTpS52iijrkxu18j5UCRlg8YAx8IgBFTsx
         KfIX4cQLEqHu4H6hyyhWY2j15oROMF4D0KsMZMWyJ+lvMwasjrLjsYMQUpGrL30/rLes
         bErMpL+IUW2vkIkFZUtVCPTvRZYvlGiZDhgwMmo6w+z4ZrOLnhhJ/L9VlqF0uQocZK+/
         Q7UXhqPlI+zzPlLCf9GimHw6afKOLJksc9zC2GzC5Ywq0plkyA4Q25RzOCBn3UI241s3
         JJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgg+Z6tz1c5hzcpV+3M0EHGrTn1Q32r1s7UqtR7H4Z4=;
        b=zMUNdfNiYUxg0pxRJuWVLoIoNtKLkQ++caq85lt4FW5QMitdakpmsN4alNt5z6jqv6
         FpFSgi9xU1ln9bHpWgK95B5rBjm4L7zRAxbn/L82B49I0Kd3buaKlklDbMttcCJmAazc
         wOLTewms7xPkzh4G1cruQlgTLmm+Jes2Ha+FAoNIXTNYeDhGP7mRfK9VBGSRz7soqVEA
         GIATmlfaNpKBZ7DDR4ub9NdOG/S250QwsYETWN+NlzDuDuQU0QGyxvSoxt1v14tafiwF
         tl6EitbCjo1zjcOTuU6luh+OWSume6A7Q/v4gTn3hG1zvpLk/0dE+R9sSMnOYCAPqkXj
         M7hw==
X-Gm-Message-State: ACrzQf0DL0F4P9Zrzf/zXakxYvkqsqhtGLahzbAMIrrLjY0W5kImCUuM
        rw4FeHocAxFZgS7lLcVhosdHIx4NFUYm4w==
X-Google-Smtp-Source: AMsMyM5k06dMy4xiWzMMmiotkK9Vymdbnd2tx2iRdvjq+IUO+YtCCjKShj3wY2w9FnmFvqz1erWZ/w==
X-Received: by 2002:a63:450c:0:b0:443:94a1:3703 with SMTP id s12-20020a63450c000000b0044394a13703mr5406312pga.565.1665769747842;
        Fri, 14 Oct 2022 10:49:07 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b00180cf894b67sm2001776plh.130.2022.10.14.10.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 10:49:06 -0700 (PDT)
Date:   Fri, 14 Oct 2022 11:49:03 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V7 6/7] remoteproc: imx_rproc: request mbox channel later
Message-ID: <20221014174903.GA4125124@p14s>
References: <20221014031037.1070424-1-peng.fan@oss.nxp.com>
 <20221014031037.1070424-7-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014031037.1070424-7-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 11:10:36AM +0800, Peng Fan (OSS) wrote:
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
>  drivers/remoteproc/imx_rproc.c | 39 ++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 917e6db39572..1183de84a4c0 100644
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
> @@ -592,6 +600,22 @@ static void imx_rproc_kick(struct rproc *rproc, int vqid)
>  
>  static int imx_rproc_attach(struct rproc *rproc)
>  {
> +	return imx_rproc_xtr_mbox_init(rproc);
> +}
> +
> +static int imx_rproc_detach(struct rproc *rproc)
> +{
> +	struct imx_rproc *priv = rproc->priv;
> +	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
> +
> +	if (dcfg->method != IMX_RPROC_SCU_API)
> +		return -EOPNOTSUPP;
> +
> +	if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
> +		return -EOPNOTSUPP;
> +
> +	imx_rproc_free_mbox(rproc);
> +
>  	return 0;
>  }
>  
> @@ -610,6 +634,7 @@ static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc
>  static const struct rproc_ops imx_rproc_ops = {
>  	.prepare	= imx_rproc_prepare,
>  	.attach		= imx_rproc_attach,
> +	.detach		= imx_rproc_detach,
>  	.start		= imx_rproc_start,
>  	.stop		= imx_rproc_stop,
>  	.kick		= imx_rproc_kick,
> @@ -720,6 +745,9 @@ static int imx_rproc_xtr_mbox_init(struct rproc *rproc)
>  	struct device *dev = priv->dev;
>  	struct mbox_client *cl;
>  
> +	if (priv->tx_ch && priv->rx_ch)
> +		return 0;
> +

You did exactly the same things as in V6.  I asked you why this is needed and
all you did is point me to the code in _probe(), which I can read on my own.

Again - why is this needed when we know it will be done in start() and attach()?


>  	if (!of_get_property(dev->of_node, "mbox-names", NULL))
>  		return 0;
>  
> @@ -749,8 +777,15 @@ static void imx_rproc_free_mbox(struct rproc *rproc)
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
> -- 
> 2.37.1
> 
