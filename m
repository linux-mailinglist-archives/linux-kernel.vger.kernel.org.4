Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5396DFC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDLRAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjDLRAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:00:42 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAAB86A2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:00:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id kh6so10463425plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681318808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+oanG2L1no3cfGxUr2f5jC5PPLghnpHBRMM+yz7rcqg=;
        b=ETda2EF8CeXNpRP+t6JDEdQjQy9SuS5w1CFty3glJHeryif4TOjMLgsh61/0aNSX3l
         WY1ZA7XUoVt89GbEf1jgCheNGw9MaytQLgyFBlcuxrJ+BaaNq6YZC3nyYAPwracjWBIX
         AP7RHR/Gh4cWRg0sf645I9NV8n3Mjoxl6J3uaTWZzNxymh/wVr5dZ+jXvjqqYLj0x6/O
         sJI4IlQoXsviOEiFA0c0IoPYmF1Yu5VmihBQsL/2pIJqwIIKXT1R6D+9wgANE3BD+Bku
         nt9FbMEFzgJRnu08QofJrkWn+NBu7u5GbQ14Tqu+fUahxwRLIEX/5KBfYqjrytmtvEOB
         MpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681318808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oanG2L1no3cfGxUr2f5jC5PPLghnpHBRMM+yz7rcqg=;
        b=AEDc6ZTRgX1Ku6clA1QnQQDZETsO2s5VtM8IzbW+1QQMTGtuHhamfn8m2bpXGhGg6X
         Y6D6Ptw7wHzBqiQLS/Miz79JmkRuS/fNsQmmnI/VJWZbYAJTWwVSV2u6I5VW85V37Gts
         /y8UenizvrmI6G3pN8SRF2l8q0aupczqA+gYmCVl+b2hPa711QFuMyVCDGRgQh/6FzOv
         E5wm2AWFjEuZZikjbpsrNnfEKHDsC3zvleUGfB9JMw+PDZfUB+BYZ/fpNeypZ5eP1fiD
         4xlz3VBzfc4X1wom/TzROiFNPPFbz7TywEeGTAf8InxO9H5WEmsrl89Bfvh++Cnz5h8Z
         9rFw==
X-Gm-Message-State: AAQBX9fckFA1fmj/+ixH5qdqnONGQ6ePc47t3BFWxFctxa1E5SBpczJ2
        nSRH2ELDczN/ptMkAahfWXxMqQ==
X-Google-Smtp-Source: AKy350ZyGAHpWAWIglbbCQpXeWBI+mmZnj2uqsJASDPZg4pKPfpA1jxJzKxrtxsUWwfHCkGWCv9/MA==
X-Received: by 2002:a17:90a:b294:b0:246:fdad:28ca with SMTP id c20-20020a17090ab29400b00246fdad28camr2727902pjr.38.1681318807683;
        Wed, 12 Apr 2023 10:00:07 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:1cd7:1135:5e45:5f77])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902eb1100b001a52dd51ff6sm7800419plb.269.2023.04.12.10.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 10:00:07 -0700 (PDT)
Date:   Wed, 12 Apr 2023 11:00:04 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     "Andrew F. Davis" <afd@ti.com>, Suman Anna <s-anna@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Nishanth Menon <nm@ti.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, srk@ti.com, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v8 1/4] soc: ti: pruss: Add pruss_get()/put() API
Message-ID: <20230412170004.GA86761@p14s>
References: <20230412103012.1754161-1-danishanwar@ti.com>
 <20230412103012.1754161-2-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412103012.1754161-2-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 04:00:09PM +0530, MD Danish Anwar wrote:
> From: Tero Kristo <t-kristo@ti.com>
> 
> Add two new get and put API, pruss_get() and pruss_put() to the
> PRUSS platform driver to allow client drivers to request a handle
> to a PRUSS device. This handle will be used by client drivers to
> request various operations of the PRUSS platform driver through
> additional API that will be added in the following patches.
> 
> The pruss_get() function returns the pruss handle corresponding
> to a PRUSS device referenced by a PRU remoteproc instance. The
> pruss_put() is the complimentary function to pruss_get().
> 
> Co-developed-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/soc/ti/pruss.c       | 62 ++++++++++++++++++++++++++++++++++++
>  include/linux/pruss_driver.h | 18 +++++++++++
>  2 files changed, 80 insertions(+)
> 

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
> index 6882c86b3ce5..3fac92df8790 100644
> --- a/drivers/soc/ti/pruss.c
> +++ b/drivers/soc/ti/pruss.c
> @@ -6,6 +6,7 @@
>   * Author(s):
>   *	Suman Anna <s-anna@ti.com>
>   *	Andrew F. Davis <afd@ti.com>
> + *	Tero Kristo <t-kristo@ti.com>
>   */
>  
>  #include <linux/clk-provider.h>
> @@ -18,6 +19,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/pruss_driver.h>
>  #include <linux/regmap.h>
> +#include <linux/remoteproc.h>
>  #include <linux/slab.h>
>  
>  /**
> @@ -30,6 +32,66 @@ struct pruss_private_data {
>  	bool has_core_mux_clock;
>  };
>  
> +/**
> + * pruss_get() - get the pruss for a given PRU remoteproc
> + * @rproc: remoteproc handle of a PRU instance
> + *
> + * Finds the parent pruss device for a PRU given the @rproc handle of the
> + * PRU remote processor. This function increments the pruss device's refcount,
> + * so always use pruss_put() to decrement it back once pruss isn't needed
> + * anymore.
> + *
> + * This API doesn't check if @rproc is valid or not. It is expected the caller
> + * will have done a pru_rproc_get() on @rproc, before calling this API to make
> + * sure that @rproc is valid.
> + *
> + * Return: pruss handle on success, and an ERR_PTR on failure using one
> + * of the following error values
> + *    -EINVAL if invalid parameter
> + *    -ENODEV if PRU device or PRUSS device is not found
> + */
> +struct pruss *pruss_get(struct rproc *rproc)
> +{
> +	struct pruss *pruss;
> +	struct device *dev;
> +	struct platform_device *ppdev;
> +
> +	if (IS_ERR_OR_NULL(rproc))
> +		return ERR_PTR(-EINVAL);
> +
> +	dev = &rproc->dev;
> +
> +	/* make sure it is PRU rproc */
> +	if (!dev->parent || !is_pru_rproc(dev->parent))
> +		return ERR_PTR(-ENODEV);
> +
> +	ppdev = to_platform_device(dev->parent->parent);
> +	pruss = platform_get_drvdata(ppdev);
> +	if (!pruss)
> +		return ERR_PTR(-ENODEV);
> +
> +	get_device(pruss->dev);
> +
> +	return pruss;
> +}
> +EXPORT_SYMBOL_GPL(pruss_get);
> +
> +/**
> + * pruss_put() - decrement pruss device's usecount
> + * @pruss: pruss handle
> + *
> + * Complimentary function for pruss_get(). Needs to be called
> + * after the PRUSS is used, and only if the pruss_get() succeeds.
> + */
> +void pruss_put(struct pruss *pruss)
> +{
> +	if (IS_ERR_OR_NULL(pruss))
> +		return;
> +
> +	put_device(pruss->dev);
> +}
> +EXPORT_SYMBOL_GPL(pruss_put);
> +
>  static void pruss_of_free_clk_provider(void *data)
>  {
>  	struct device_node *clk_mux_np = data;
> diff --git a/include/linux/pruss_driver.h b/include/linux/pruss_driver.h
> index ecfded30ed05..cb40c2b31045 100644
> --- a/include/linux/pruss_driver.h
> +++ b/include/linux/pruss_driver.h
> @@ -9,7 +9,9 @@
>  #ifndef _PRUSS_DRIVER_H_
>  #define _PRUSS_DRIVER_H_
>  
> +#include <linux/remoteproc/pruss.h>
>  #include <linux/types.h>
> +#include <linux/err.h>
>  
>  /*
>   * enum pruss_mem - PRUSS memory range identifiers
> @@ -51,4 +53,20 @@ struct pruss {
>  	struct clk *iep_clk_mux;
>  };
>  
> +#if IS_ENABLED(CONFIG_TI_PRUSS)
> +
> +struct pruss *pruss_get(struct rproc *rproc);
> +void pruss_put(struct pruss *pruss);
> +
> +#else
> +
> +static inline struct pruss *pruss_get(struct rproc *rproc)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static inline void pruss_put(struct pruss *pruss) { }
> +
> +#endif /* CONFIG_TI_PRUSS */
> +
>  #endif	/* _PRUSS_DRIVER_H_ */
> -- 
> 2.34.1
> 
