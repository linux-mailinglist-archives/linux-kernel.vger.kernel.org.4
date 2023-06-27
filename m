Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A86274068B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 00:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjF0Wje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 18:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjF0Wja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 18:39:30 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFA92102
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:39:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666e916b880so2944500b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687905563; x=1690497563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JZGhAhIzfGUZ5jvLLPvwW9bXE1PlUJT6q1LYW9RbmeA=;
        b=K2tQkI6tJeFmedSnKnrAERFOE4bgmBgdliT3OeCdnrGIVgejVCv6UIq9RuljmPtdc5
         ryTYQ48f4vKrxx2p40gw+z+wb58ai720OZZM5bik4nqGdX2G28WofbJ3Qv7OltUnLEU+
         aVif9LwDbrFcOJoan44HwewjTk0Kpqv9GgXDhNA5MsN0KKBp0fzauGPuipOuCiy0xvS6
         TPCff7d76LBMrtXfiMYR66112kfv14AoSbbfg6kJNy5PTLwvx+sTcVMHSrdi4mt6qCi9
         AnMIGcRzf04VxH8HL7xTZL8C60XAuNhMS45S9Nt4lwiSrkIYCEZ7HrfHvl13cqNyvskx
         fhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687905563; x=1690497563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZGhAhIzfGUZ5jvLLPvwW9bXE1PlUJT6q1LYW9RbmeA=;
        b=V3Ugoc1MHqw+Njc2cTFMOwwM9HX8ttYiorr5cyFf+Olw7G3f+kms7HUI+DfMTKlLlm
         zeWOMcIsZ+hJxb6HmvtKvMzNfTF7GzfY2/NYJSrYWSnxNbK8IBTI9blekwVUihNxaP+g
         a9liykPpTngQYLoZg7LZ+d4eaGJTI8J7PYq74UWt0J+ih+kKhZM3JXXhAaf4k5i4Qvzr
         WD5osloFy2JHfH6cXUbKjyQL+Z7XN76SYsUseLw2gWjLZdWaD70BTEtPweewcmG1wy0x
         UA5H4XH5BfBc16FXKE9z+7R1RHcWRXmX984DJsmmGKsdAsjtCewGNo51F1hEK/Q0LPCG
         aJaw==
X-Gm-Message-State: AC+VfDw0VCudN9tkVqyrRkdkMGAjm7D+UWXzQE3iI+Y1V9zXp++6Xc6D
        gAQ1Mg9DmxTyDWtxhRzFEUUivw==
X-Google-Smtp-Source: ACHHUZ6Xwb8IGGHXUoDYmFFsvDwbFCwlXN4ISODmV7ztXiDgFDCZ+xk6Xe77dJLDaH8lFxIeuKmPRA==
X-Received: by 2002:a05:6a00:2394:b0:668:73f5:dce0 with SMTP id f20-20020a056a00239400b0066873f5dce0mr21935921pfc.29.1687905562787;
        Tue, 27 Jun 2023 15:39:22 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:144c:51f7:d15:64a2])
        by smtp.gmail.com with ESMTPSA id j2-20020aa783c2000000b0066a36d7ce9bsm6058415pfn.171.2023.06.27.15.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 15:39:22 -0700 (PDT)
Date:   Tue, 27 Jun 2023 16:39:19 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     andersson@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        daniel.baluta@nxp.com, iuliana.prodan@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] remoteproc: imx_rproc: iterate all notifiyids in rx
 callback
Message-ID: <ZJtlF/tzh0ZMXji4@p14s>
References: <20230625123514.4069724-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625123514.4069724-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 08:35:14PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The current code has an assumption that there is one tx and one rx
> vring, but it is not always true. There maybe more vrings. So iterate
> all notifyids to not miss any vring events.

Can you be more specific on the use case where more than 2 virqueues are
allocated?  The remoteproc core can handle more than 2 but right now the only
configuration I see doesn't support more than that.

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index f9874fc5a80f..e3f40d0e9f3d 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -725,13 +725,23 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
>  	return 0;
>  }
>  
> +static int imx_rproc_notified_idr_cb(int id, void *ptr, void *data)
> +{
> +	struct rproc *rproc = data;
> +
> +	if (rproc_vq_interrupt(rproc, id) == IRQ_NONE)
> +		dev_dbg(&rproc->dev, "no message in vqid: %d\n", id);
> +
> +	return 0;
> +}
> +
>  static void imx_rproc_vq_work(struct work_struct *work)
>  {
>  	struct imx_rproc *priv = container_of(work, struct imx_rproc,
>  					      rproc_work);
> +	struct rproc *rproc = priv->rproc;
>  
> -	rproc_vq_interrupt(priv->rproc, 0);
> -	rproc_vq_interrupt(priv->rproc, 1);
> +	idr_for_each(&rproc->notifyids, imx_rproc_notified_idr_cb, rproc);
>  }
>  
>  static void imx_rproc_rx_callback(struct mbox_client *cl, void *msg)
> -- 
> 2.37.1
> 
