Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A9969B25F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 19:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjBQS36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 13:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQS35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 13:29:57 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601CF60FBB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 10:29:54 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id ay25so1050494pfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 10:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbrN/wtqaLP+762+fL1BSuVTDl18qAdomxpq221PnGA=;
        b=CLH8BrYtdo+HFeDqBo6ECWp7h8IqocBPKFAQ92ku6OSDeeNKoEt28tmutSJZslL6ib
         WwAEHOlm7li0xrHHZ306Hqkn6Zmqni02+izqd6RlK5SNGM8qH9qzOnFjVZG3QIUwBJw1
         DCP7zU8GgALgWrIrxK3NW90YZ2+9l/N5Eg4POe3nTTNc72sDuoLFHIHX11WeyejN6ihR
         HQuPjY4t2Mz8depH1lPI6KXySN3wltGidqRKBqLJp6m56OrhV1oVzBBILEUgGTtIYHb7
         IpNOo80buSz4cmvpVeNPv4AIM5XndamZ+YouLE0+v9CU2YP/fqX3tXWxt8vw8Ediylgv
         2qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbrN/wtqaLP+762+fL1BSuVTDl18qAdomxpq221PnGA=;
        b=5S+/+99MvSZijKXvmJ0LrOzp786DUxCG69hLiD+zUJr2799Moa6y8iJhyP0uJjlWsD
         wH2tYEZX65LPZNuQhip49w/q3laIw6bfsvg5C9trIx4VIRx3qJWMGOsuFhXiGJLbbr1g
         sn+rqm+bQtguAGD8rHhnpSKFcNtPEn1KT3OgTmszQ9T4W4dMj+I85o8ytJEYsD4a9eOa
         NM/mFkkmHLd4xmRYRr4IkW7WvqWfNbwEduDUxV3xg61pdrib/rqfyC/GPOAUcIYCIevJ
         ENIwzZo8vMXUDSCQKsj8Apq3TkMGxyPL+PHUgy4u/VPI8GvD0xEGXt9pw1/Qqx18sBWm
         Lepg==
X-Gm-Message-State: AO0yUKXqSB1Ey8VV2tjsdRFFztiormKNyFOwCmZBuniYFJWPTkOjLRXs
        yn6qr5hz8yU3qv58OEo/btDj8A==
X-Google-Smtp-Source: AK7set97CeB2IXS5TthkfDUlCh14fu8UEJl1CYVdlUy/CZKjrPzYPCKYQcH5cb7tkaELIW/vJtBykQ==
X-Received: by 2002:a62:3207:0:b0:5a8:f259:21ff with SMTP id y7-20020a623207000000b005a8f25921ffmr1458995pfy.14.1676658593791;
        Fri, 17 Feb 2023 10:29:53 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:e03d:a736:2176:868f])
        by smtp.gmail.com with ESMTPSA id e24-20020aa78c58000000b00581c741f95csm3361347pfd.46.2023.02.17.10.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 10:29:53 -0800 (PST)
Date:   Fri, 17 Feb 2023 11:29:50 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v5] remoteproc: imx_dsp_rproc: add module parameter to
 ignore ready flag from remote processor
Message-ID: <20230217182950.GA585964@p14s>
References: <20230217094124.9440-1-iuliana.prodan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217094124.9440-1-iuliana.prodan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Iuliana,

On Fri, Feb 17, 2023 at 11:41:24AM +0200, Iuliana Prodan (OSS) wrote:
> From: Iuliana Prodan <iuliana.prodan@nxp.com>
> 
> There are cases when we want to test a simple "hello world"
> application on the DSP and we don't have IPC between the cores.
> Therefore, do not wait for a confirmation from the remote processor
> at start.
> 
> Added "no_mailboxes" flag while inserting the module to not initialize
> any mailboxes, and so ignore remote processor reply after start.
> By default, this is off - do not ignore reply from rproc.
> 
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
> Changes since v4
> - s/ignore_dsp_ready/no_mailboxes
> - make imx_dsp_rproc_mbox_init() a function pointer which,
> based on the no_mailboxes module parameter, can initialize
> the mailboxes (= imx_dsp_rproc_mbox_alloc()), in case they exists,
> otherwise does nothing (= imx_dsp_rproc_mbox_no_alloc()).
> 
> Changes since v3
> - do not instantiate static var to 0, this is done by default
> - do not initialize mailbox if not IPC between the core
> 
> Changes since v2
> - s/ignoreready/ignore_dsp_ready
> 
> Changes since v1
> - change BIT(31) to BIT(1) for REMOTE_SKIP_WAIT
> ---
>  drivers/remoteproc/imx_dsp_rproc.c | 33 ++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index 95da1cbefacf..85eea85b1655 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -28,6 +28,15 @@
>  
>  #define DSP_RPROC_CLK_MAX			5
>  
> +/*
> + * Module parameters
> + */
> +static unsigned int no_mailboxes;
> +module_param_named(no_mailboxes, no_mailboxes, int, 0644);
> +MODULE_PARM_DESC(no_mailboxes,
> +		 "There is no mailbox between cores, so ignore remote proc "
> +		 "reply after start, default is 0 (off).");
> +
>  #define REMOTE_IS_READY				BIT(0)
>  #define REMOTE_READY_WAIT_MAX_RETRIES		500
>  
> @@ -172,6 +181,9 @@ static const struct imx_rproc_att imx_dsp_rproc_att_imx8ulp[] = {
>  	{ 0x30000000, 0x90000000, 0x10000000, 0},
>  };
>  
> +/* Initialize the mailboxes between cores, if exists */
> +static int (*imx_dsp_rproc_mbox_init)(struct imx_dsp_rproc *priv);
> +
>  /* Reset function for DSP on i.MX8MP */
>  static int imx8mp_dsp_reset(struct imx_dsp_rproc *priv)
>  {
> @@ -492,12 +504,12 @@ static void imx_dsp_rproc_rxdb_callback(struct mbox_client *cl, void *data)
>  }
>  
>  /**
> - * imx_dsp_rproc_mbox_init() - request mailbox channels
> + * imx_dsp_rproc_mbox_alloc() - request mailbox channels
>   * @priv: private data pointer
>   *
>   * Request three mailbox channels (tx, rx, rxdb).
>   */
> -static int imx_dsp_rproc_mbox_init(struct imx_dsp_rproc *priv)
> +static int imx_dsp_rproc_mbox_alloc(struct imx_dsp_rproc *priv)
>  {
>  	struct device *dev = priv->rproc->dev.parent;
>  	struct mbox_client *cl;
> @@ -560,6 +572,18 @@ static int imx_dsp_rproc_mbox_init(struct imx_dsp_rproc *priv)
>  	return ret;
>  }
>  
> +/**
> + * imx_dsp_rproc_mbox_no_alloc()
> + *
> + * Empty function for no mailbox between cores
> + *
> + * Always return 0
> + */
> +static int imx_dsp_rproc_mbox_no_alloc(struct imx_dsp_rproc *priv)
> +{
> +	return 0;
> +}
> +
>  static void imx_dsp_rproc_free_mbox(struct imx_dsp_rproc *priv)
>  {
>  	mbox_free_channel(priv->tx_ch);
> @@ -903,6 +927,11 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
>  	priv->rproc = rproc;
>  	priv->dsp_dcfg = dsp_dcfg;
>  
> +	if (no_mailboxes)
> +		imx_dsp_rproc_mbox_init = imx_dsp_rproc_mbox_no_alloc;
> +	else
> +		imx_dsp_rproc_mbox_init = imx_dsp_rproc_mbox_alloc;
> +

This looks good now.  The merge window for the 6.3 cycle opens on Sunday, which
I find too close to start adding new things.  As such I will apply your patch to
my local branch and publish it in three weeks when v6.3-rc2 comes out.

Thanks,
Mathieu

>  	dev_set_drvdata(dev, rproc);
>  
>  	INIT_WORK(&priv->rproc_work, imx_dsp_rproc_vq_work);
> -- 
> 2.17.1
> 
