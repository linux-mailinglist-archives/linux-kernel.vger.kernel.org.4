Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100DD6982C4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjBOR6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjBOR6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:58:15 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A580D27995
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 09:58:13 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id m2so21015514plg.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 09:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mvUpuCK8Tw5hHOSWhrZqksRfIU8qxKAVlgjJMcbm0j0=;
        b=ya9g4lr3OV6BuPLEn75AHWCHCRucPy5++bt8uYHJLCpr2Ko/wjr1Qd3uzOGIcx7fFo
         6S7DOZbUllcratjAjMEQz8Q6Z7nbwzkhCy9UkRKzSTzvHczQ5NTH7TwOf4hXRT/7gY7m
         fXxxi3bVZ+orqdjuXmSG3B+Nv2OJEPkhaknSh4dYH/90fSBldG/bQ7McV2UFjLLbXc1r
         FCwUyHiz+TPIkWVfJgE/1zWM2MbKUQ3Nj7kVMrk2ueV2LPYEpXvQTb87Bq+HZhGXLlgJ
         tqOQA+HLr1H8wFRWmjbDHGuVINcTCOWNb2kY8YOm2TgpdT7lTt4y2YQbRKlSe2YgmRFa
         tGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvUpuCK8Tw5hHOSWhrZqksRfIU8qxKAVlgjJMcbm0j0=;
        b=466+2w5G8PFEoYVpImkSh6O0r1baWVQZI6bx+qhieRpsYAKWR4rbUaztwiNT4qvZTx
         8HCydIzOCZCgOW/f0VLLWeOkI9/f5Fp7TCQoxZ0Xi0HBLoWpULb4/BOSlf8J8Q05FtPV
         RkMW/CgAoiP0HS306duxRmFIk2ooPt8c4llsxcnx1rLECaJ5viMxHgqsmDDMieVAXtnv
         +ayqGi5Osi1M4hkUFzCC1YjNJmsJT7MgZMg146o8e9lVGV665Y46XJqv0YAlnDjVDQ7q
         Fdiz1DO5IHg4dtAuOICnfm4jj06QZAzdpbFM5hhR38vdLfJDpWCOOMwb14WLHJSfIR4C
         U2ag==
X-Gm-Message-State: AO0yUKXkguCbIIg4ivghlE4mPVgOHElKrXzOJj1qBgObz5GTPDupFJZV
        FVU6T3M1faIURa/MF9CQFOOsEg==
X-Google-Smtp-Source: AK7set8D+TytfU0ZJ503p0kYOBYVjOwgean4hwMM4Ov3LCJJq1ZmLCifc0uWW8eKFUV2yirvj1GhDA==
X-Received: by 2002:a17:903:41ca:b0:19a:6f28:ec2c with SMTP id u10-20020a17090341ca00b0019a6f28ec2cmr3772871ple.62.1676483893101;
        Wed, 15 Feb 2023 09:58:13 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:c457:7ba1:9c53:7a14])
        by smtp.gmail.com with ESMTPSA id p6-20020a170903248600b0019949fd956bsm12435867plw.178.2023.02.15.09.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 09:58:12 -0800 (PST)
Date:   Wed, 15 Feb 2023 10:58:10 -0700
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
Subject: Re: [RESEND PATCH v4] remoteproc: imx_dsp_rproc: add module
 parameter to ignore ready flag from remote processor
Message-ID: <20230215175810.GA441246@p14s>
References: <20230214163744.16377-1-iuliana.prodan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214163744.16377-1-iuliana.prodan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Iuliana,

First and foremost, you were correct to remind me of this patch - it had slipped
through.  I got mixed up with your other patch[1], which has the same title
preprend and the same revision.  That one is on my list of patches to review and
I should get to it later this week or early next week.

Please see below for comments on this patch.

[1]. [PATCH v4] remoteproc: imx_dsp_rproc: add custom memory copy implementation for i.MX DSP Cores

On Tue, Feb 14, 2023 at 06:37:44PM +0200, Iuliana Prodan (OSS) wrote:
> From: Iuliana Prodan <iuliana.prodan@nxp.com>
> 
> There are cases when we want to test a simple "hello world"
> application on the DSP and we don't have IPC between the cores.
> Therefore, do not wait for a confirmation from the remote processor
> at start.
> 
> Added "ignore_dsp_ready" flag while inserting the module to ignore
> remote processor reply after start.
> By default, this is off - do not ignore reply from rproc.
> 
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
> Changes since v3
> - do not instantiate static var to 0, this is done by default
> - do not initialize mailbox if not IPC between the core
> 
> Changes since v2
> - s/ignoreready/ignore_dsp_ready
> 
> Changes since v1
> - change BIT(31) to BIT(1) for REMOTE_SKIP_WAIT
> 
> ---
>  drivers/remoteproc/imx_dsp_rproc.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index 95da1cbefacf..fb69f4e8ee96 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -26,9 +26,18 @@
>  #include "remoteproc_elf_helpers.h"
>  #include "remoteproc_internal.h"
>  
> +/*
> + * Module parameters
> + */
> +static unsigned int imx_dsp_rproc_ignore_ready;
> +module_param_named(ignore_dsp_ready, imx_dsp_rproc_ignore_ready, int, 0644);

This patch is about introducing a mode where the mailboxes aren't used... Why
not simply name the parameter "no_mailboxes"?

> +MODULE_PARM_DESC(ignore_dsp_ready,
> +		 "Ignore remote proc reply after start, default is 0 (off).");
> +
>  #define DSP_RPROC_CLK_MAX			5
>  
>  #define REMOTE_IS_READY				BIT(0)
> +#define REMOTE_SKIP_WAIT			BIT(1)
>  #define REMOTE_READY_WAIT_MAX_RETRIES		500
>  
>  /* att flags */
> @@ -282,6 +291,10 @@ static int imx_dsp_rproc_ready(struct rproc *rproc)
>  	struct imx_dsp_rproc *priv = rproc->priv;
>  	int i;
>  
> +	/* No IPC between the cores */
> +	if (priv->flags & REMOTE_SKIP_WAIT)
> +		return 0;
> +

This isn't needed since priv->rxdb_ch is NULL when mailboxes have not been
initialized.

>  	if (!priv->rxdb_ch)
>  		return 0;
>  
> @@ -503,6 +516,13 @@ static int imx_dsp_rproc_mbox_init(struct imx_dsp_rproc *priv)
>  	struct mbox_client *cl;
>  	int ret;

I suggest to rename imx_dsp_rproc_mbox_init() to imx_dsp_rproc_mbox_alloc(),
introduce a new function called imx_dsp_rproc_mbox_no_alloc() that simply
returns 0 and make imx_dsp_rproc_mbox_init() a function pointer.

See imx_dsp_rproc_probe() for the rest of the solution...

>  
> +	/*
> +	 * If there is no IPC between the cores,
> +	 * then no need to initialize mailbox.
> +	 */
> +	if (priv->flags & REMOTE_SKIP_WAIT)
> +		return 0;

Remove this.

> +
>  	if (!of_get_property(dev->of_node, "mbox-names", NULL))
>  		return 0;
>  
> @@ -562,6 +582,10 @@ static int imx_dsp_rproc_mbox_init(struct imx_dsp_rproc *priv)
>  
>  static void imx_dsp_rproc_free_mbox(struct imx_dsp_rproc *priv)
>  {
> +	/* No IPC between the cores */
> +	if (priv->flags & REMOTE_SKIP_WAIT)
> +		return;
> +

This isn't needed since mbox_free_channel() is able to handle a NULL parameter,
which is the case when imx_dsp_rproc_mbox_init() hasn't been called.

>  	mbox_free_channel(priv->tx_ch);
>  	mbox_free_channel(priv->rx_ch);
>  	mbox_free_channel(priv->rxdb_ch);
> @@ -903,6 +927,9 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
>  	priv->rproc = rproc;
>  	priv->dsp_dcfg = dsp_dcfg;
>  
> +	if (imx_dsp_rproc_ignore_ready)
> +		priv->flags |= REMOTE_SKIP_WAIT;
> +

        if (no_mailboxes)
                imx_dsp_rproc_mbox_init = imx_dsp_rproc_mbox_no_alloc;
        else
                imx_dsp_rproc_mbox_init = imx_dsp_rproc_mbox_alloc;

That way we don't introduce a new flag, there is no new conditionals peppered
throughout the code and calls to imx_dsp_rproc_mbox_init() remain unchainged.

Thanks,
Mathieu

>  	dev_set_drvdata(dev, rproc);
>  
>  	INIT_WORK(&priv->rproc_work, imx_dsp_rproc_vq_work);
> -- 
> 2.17.1
> 
