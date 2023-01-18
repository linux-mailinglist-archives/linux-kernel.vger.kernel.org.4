Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16B16724CB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjARRYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjARRYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:24:21 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B50117CEE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:24:20 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id v23so32669888plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/85bp1vP3MXzWpfyCclueqY4UFzXVuo4Z5G90xwNDEM=;
        b=oeQXKrGvKYFACksCj40O6ZOV+KsKYJTJcM15HKNJi2nGzi8DOXHzkQNmZAavcl1Zdr
         Nl9RNhA4kekUTTnQ7BntkiLaM946I2WRsNS6OeMgQBkpr6CqZ3Jo7njS8trzAz+OobJO
         R89kFIJOdngL4Bw3xngUPHhUQ/xsLCzJt8asUpWzNzuLYT8lwUUicK4InXO1Pu2DpzWm
         nzJALoexrT2nz568WkEl6I0OA0uLlH8yHJHNG7zpqJCin2ovij3MJQwQaUl65nDHEp2q
         6T9UIvIPu7+oe8iQNx5H3QXxtSSxMf+BjJzELJ8O7aNBBD8x+TFyUXpBhke8Pg5DQ2hI
         k0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/85bp1vP3MXzWpfyCclueqY4UFzXVuo4Z5G90xwNDEM=;
        b=itQk8v9naxU/cTREgiBFs8C31aW4uGYtghras0/X95/bFIZA7ynqMrefVZIQt7HAIk
         uyi4nwDRTvhdf7ptNtAPGhRRRseh1q76mmzG5b1oQ3Z4sEsa5p8Agb3UdDLyKjBXWwaj
         xAf43naOj++zoqr+hemaJF0g5cSnpKxvSs0JOArypAUoMoOPrxbTqvlqI/O1LtyvAUFk
         A1d8LA0Bqt/UsjfP0ZVWoCmsv+baCSvDWju1cOgTFrNfepLZvyomXUKsRyeY+6N+uC8y
         Cc3jPFb1jcLICzRlpgZhas71hjw4068wuxMAkLOrnko6gyyHjpdY39GCmPy6hL5ZKHgj
         p+9w==
X-Gm-Message-State: AFqh2kpTfGXsttB81hiRHNQZVwg58vQo1+qCC7ZP4kA+N3koED2wl2Rx
        1RrXsdh/UhrKlUGQlorM8ZYWRjMyBtZJTwbq
X-Google-Smtp-Source: AMrXdXtiocEKCjs8eTcEsQA32wuVtG465QX3tzHebeE/Is8RJXfNhsdVvaN/MEfsH7q73N8hC/wbxQ==
X-Received: by 2002:a05:6a21:3294:b0:a4:414c:84c5 with SMTP id yt20-20020a056a21329400b000a4414c84c5mr10069900pzb.12.1674062659386;
        Wed, 18 Jan 2023 09:24:19 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:4866:b240:c533:54ae])
        by smtp.gmail.com with ESMTPSA id z7-20020a63e547000000b00476d1385265sm19156114pgj.25.2023.01.18.09.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 09:24:18 -0800 (PST)
Date:   Wed, 18 Jan 2023 10:24:16 -0700
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
Subject: Re: [PATCH v3] remoteproc: imx_dsp_rproc: add module parameter to
 ignore ready flag from remote processor
Message-ID: <20230118172416.GB3394216@p14s>
References: <20230117110357.15091-1-iuliana.prodan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117110357.15091-1-iuliana.prodan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Iuliana,

On Tue, Jan 17, 2023 at 01:03:57PM +0200, Iuliana Prodan (OSS) wrote:
> From: Iuliana Prodan <iuliana.prodan@nxp.com>
> 
> There are cases when we want to test a simple "hello world"
> application on the DSP and we don't have IPC between the cores.
> Therefore, skip the wait for remote processor to start.
> 
> Added "ignore_dsp_ready" flag while inserting the module to ignore
> remote processor reply after start.
> By default, this is off - do not ignore reply from rproc.
> 
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> 
> ---
> Changes since v2
> - s/ignoreready/ignore_dsp_ready
> 
> Changes since v1
> - change BIT(31) to BIT(1) for REMOTE_SKIP_WAIT
> 
> ---
>  drivers/remoteproc/imx_dsp_rproc.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index 95da1cbefacf..22e2ef068c67 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -26,9 +26,20 @@
>  #include "remoteproc_elf_helpers.h"
>  #include "remoteproc_internal.h"
>  
> +#define IMX_DSP_IGNORE_REMOTE_READY		0
> +
> +/*
> + * Module parameters
> + */
> +static unsigned int imx_dsp_rproc_ignore_ready = IMX_DSP_IGNORE_REMOTE_READY;

Static variables are initialised to '0' and as such this is not needed.

> +module_param_named(ignore_dsp_ready, imx_dsp_rproc_ignore_ready, int, 0644);
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
> @@ -285,6 +296,9 @@ static int imx_dsp_rproc_ready(struct rproc *rproc)
>  	if (!priv->rxdb_ch)
>  		return 0;
>  
> +	if (priv->flags & REMOTE_SKIP_WAIT)
> +		return 0;
> +

This looks very hackish to me...

Here priv->rxdb_ch is valid and as such the DB mailbox has been setup, which
contradicts the commit log where it is stated that "we don't have IPC between
cores".  Moreover, the commit log mentions to "skip the wait for remote
processor to start".  How can the remote processor executed an sample
application if it is not ready?

Lastly, is there even a need to call imx_dsp_rproc_mbox_init() if an IPC is not
needed?

I'm fine with the module parameter but would much rather see a solution that
does not configure any kind of IPC related mechanic when it is not needed.

Thanks,
Mathieu

>  	for (i = 0; i < REMOTE_READY_WAIT_MAX_RETRIES; i++) {
>  		if (priv->flags & REMOTE_IS_READY)
>  			return 0;
> @@ -903,6 +917,9 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
>  	priv->rproc = rproc;
>  	priv->dsp_dcfg = dsp_dcfg;
>  
> +	if (imx_dsp_rproc_ignore_ready)
> +		priv->flags |= REMOTE_SKIP_WAIT;
> +
>  	dev_set_drvdata(dev, rproc);
>  
>  	INIT_WORK(&priv->rproc_work, imx_dsp_rproc_vq_work);
> -- 
> 2.17.1
> 
