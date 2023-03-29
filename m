Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC79B6CD0DB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjC2DuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjC2DuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:50:08 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41262D5E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 20:50:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d13so12885906pjh.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 20:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680061805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wC/Ye1bpw03sXj/B+KMS+XtSXrPtzZfQh7aSp7cQCRc=;
        b=PZ5/DAXdhhrlw/3i5XEyyJ/3ggz4/Ow3xqBgKMIBuhgdKKdl3erVoiLam8XCz2CaYR
         zYUZ6/CDxEo+dTM0DB8Xo7XPyuoLNzuf4ovD6JNO2OpiM3HEwUaj0cXXOCm1yaUpfsaQ
         AwbVzC1T8E9goDtTQGtkBo5P3tZ2EuQm+3mLYytxoUsVDlkEvDlCA54umtbAVdqE5hDB
         Z0CoXuj3djCLkCxjdZx2kv/8dSI1viBYneknRYPii+01coTRFPnw9NUlg2MOoj6/4ICT
         8qNZnsLmgv5Gy0+DowXt2rfgou8VP0NWun2dG+KKPJgxPH0KPtpblpbtgLK63qe2G02H
         ZahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680061805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wC/Ye1bpw03sXj/B+KMS+XtSXrPtzZfQh7aSp7cQCRc=;
        b=OMrqlwDmziCjwIKGBJ9Dcm/bsbvNziAdZpzcbLODfbcuWKkWmVjdYKhowZhyqpHOcP
         ViiTn9rEiHiSqA312PUiTIr0wiQcNAsTo9BiEqkbNVRCh/Rgf6XG1GFnFfwTbNQZ4yXP
         zKwH0rZEHbDet0u5qVIe6CI+64gk9AnJcmiAIEz0fTkXEtE/zkP89yInJtLcHk2dujo4
         Qz7EQiIfVMosKX4kPmgIPQTeC0CLR4vkuwkbsdht0XuAVcz/NGtqgNdEQftN2ek6H7ko
         zM273ka7A78YFx8KpKskuKfSZBRGRJHBtBtvYN5bBb0Db6CopTUOIKLHpeDNph1HjXg1
         H9pA==
X-Gm-Message-State: AAQBX9cvNN29SKEFX7DNGrLjfts6Vesn4MrSujRj+pPHunMiGSpzBZpU
        7vCcVh98Qf8QbzBaL1xsb6MOrg==
X-Google-Smtp-Source: AKy350asoNwJSTgVvdCnbLiJmekNA9xGSrJQiNP2xLCGbZyD2WlY7AMonNPxHcu6inb+DhvgyMLWjw==
X-Received: by 2002:a17:90b:3b90:b0:23d:500f:e826 with SMTP id pc16-20020a17090b3b9000b0023d500fe826mr18967833pjb.14.1680061805127;
        Tue, 28 Mar 2023 20:50:05 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id g11-20020a17090a300b00b0023fcece8067sm341124pjb.2.2023.03.28.20.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 20:50:04 -0700 (PDT)
Date:   Wed, 29 Mar 2023 11:49:58 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] irqchip: irq-qcom-mpm: Support passing a slice of
 SRAM as reg space
Message-ID: <20230329034958.GC3554086@dragon>
References: <20230328-topic-msgram_mpm-v1-0-1b788a5f5a33@linaro.org>
 <20230328-topic-msgram_mpm-v1-2-1b788a5f5a33@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328-topic-msgram_mpm-v1-2-1b788a5f5a33@linaro.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 12:02:53PM +0200, Konrad Dybcio wrote:
> The MPM hardware is accessible to us from the ARM CPUs through a shared
> memory region (RPM MSG RAM) that's also concurrently accessed by other
> kinds of cores on the system (like modem, ADSP etc.). Modeling this
> relation in a (somewhat) sane manner in the device tree basically
> requires us to either present the MPM as a child of said memory region
> (which makes little sense, as a mapped memory carveout is not a bus),
> define nodes which bleed their register spaces into one another, or
> passing their slice of the MSG RAM through some kind of a property.
> 
> Go with the third option and add a way to map a region passed through
> the "qcom,rpm-msg-ram" property as our register space.
> 
> The current way of using 'reg' is preserved for ABI reasons.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/irqchip/irq-qcom-mpm.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
> index d30614661eea..6fe59f4deef4 100644
> --- a/drivers/irqchip/irq-qcom-mpm.c
> +++ b/drivers/irqchip/irq-qcom-mpm.c
> @@ -14,6 +14,7 @@
>  #include <linux/mailbox_client.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> @@ -322,8 +323,10 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
>  	struct device *dev = &pdev->dev;
>  	struct irq_domain *parent_domain;
>  	struct generic_pm_domain *genpd;
> +	struct device_node *msgram_np;
>  	struct qcom_mpm_priv *priv;
>  	unsigned int pin_cnt;
> +	struct resource res;
>  	int i, irq;
>  	int ret;
>  
> @@ -374,9 +377,21 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
>  
>  	raw_spin_lock_init(&priv->lock);
>  
> -	priv->base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(priv->base))
> -		return PTR_ERR(priv->base);
> +	/* If we have a handle to an RPM message ram partition, use it. */
> +	msgram_np = of_parse_phandle(np, "qcom,rpm-msg-ram", 0);
> +	if (msgram_np) {
> +		ret = of_address_to_resource(msgram_np, 0, &res);
> +		/* Don't use devm_ioremap_resource, as we're accessing a shared region. */
> +		priv->base = ioremap(res.start, resource_size(&res));

Are you suggesting that other cores/drivers will also need to access
the mpm slice below?

	apss_mpm: sram@1b8 {
		reg = <0x1b8 0x48>;
	};

Shawn

> +		of_node_put(msgram_np);
> +		if (IS_ERR(priv->base))
> +			return PTR_ERR(priv->base);
> +	} else {
> +		/* Otherwise, fall back to simple MMIO. */
> +		priv->base = devm_platform_ioremap_resource(pdev, 0);
> +		if (IS_ERR(priv->base))
> +			return PTR_ERR(priv->base);
> +	}
>  
>  	for (i = 0; i < priv->reg_stride; i++) {
>  		qcom_mpm_write(priv, MPM_REG_ENABLE, i, 0);
> @@ -387,8 +402,10 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0)
> -		return irq;
> +	if (irq < 0) {
> +		ret = irq;
> +		goto unmap_base;
> +	}
>  
>  	genpd = &priv->genpd;
>  	genpd->flags = GENPD_FLAG_IRQ_SAFE;
> @@ -451,6 +468,9 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
>  	mbox_free_channel(priv->mbox_chan);
>  remove_genpd:
>  	pm_genpd_remove(genpd);
> +unmap_base:
> +	if (res.start)
> +		iounmap(priv->base);
>  	return ret;
>  }
>  
> 
> -- 
> 2.40.0
> 
