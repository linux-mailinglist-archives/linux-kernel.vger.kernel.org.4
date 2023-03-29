Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC366CDAD1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjC2N2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjC2N2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:28:30 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DAE1982
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:28:28 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id z19so14925599plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680096508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XO9PMGgyv7xlqOFpmdl/UFzdqhUbqRNV9CPyu+R+Ji0=;
        b=MkWqzUtq79Ugx9ENsPBsqoWiluHKABfzOBjJ3rgd5SE7hPKt4Wejem3mCOKuXnZMr+
         ueYUNOslkFWoiYsDPro/Lmr25V9LIG8ow5WVqmVCgtE+d6C1Qdk72eLeUXQ7w238kBNM
         jNIF9ZbbM9yFoxEpDIOhA9FWzeAXHKEuO77YfPGvieWnBLsCfj4aJzza6mLjZY+Pq/yP
         eAJftMxXfxoioUbhVLqA+adr+/pjglEWBZeTotFLUra1MXptMxle96LHwVWHFR15fYdm
         b/QduyQ0jP36bZcXabmodoJOm17Rd+RJlAgZZLqsH176NE5Marmwz9jcVZywPnSeo/5q
         uo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680096508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XO9PMGgyv7xlqOFpmdl/UFzdqhUbqRNV9CPyu+R+Ji0=;
        b=z8MKntK0zDHOXJKepSHRvQwt27/Z8hl6qHr4+ufOD0bgUwsSoxNOYiT+VD3wW/To9S
         Ey/XDXxOncQou65nKk2SKNad9p02G0LxYMmO5Lyqi0Uh5Mgy1RMSHnMI3MveB6DDaD/a
         Bcq+65XBF+US+Fv/J2B8S70P7uxG6n8MofZRFv6cyR0GfHDYnhVNSLLpHBYzFNbFtwYO
         BznfUBGmX9rsEo7INzlhn7fULkwsuVzSdzOMV0YPMjFxMMg9oSWBEaC7Rllcu48qZUM/
         ysCqMKvUBy5Rqmq0FdWXFdV27xN79SbsLj/+sFLyXdbsSLvcnNqXABzcxXxeTamtxRSY
         7uhA==
X-Gm-Message-State: AAQBX9ddcC7zlIKfzqWhVqOc9ZGOlRCcNbgxG5TU3LfSxQcsEzP/wwxo
        efRziiD1lfC6m/Eo8z5wD/JjNg==
X-Google-Smtp-Source: AKy350arSJgZHcU4mFfCt2qojdNxJymORNH3nNOpqEYXNeDYs2Yg68qaCVOOBIoZXOZOppAzYTujqQ==
X-Received: by 2002:a17:90b:1b49:b0:23d:1fc0:dd20 with SMTP id nv9-20020a17090b1b4900b0023d1fc0dd20mr20241188pjb.17.1680096508109;
        Wed, 29 Mar 2023 06:28:28 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902bb8300b0019a7d58e595sm22979348pls.143.2023.03.29.06.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 06:28:27 -0700 (PDT)
Date:   Wed, 29 Mar 2023 21:28:19 +0800
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
Message-ID: <20230329132819.GA3590215@dragon>
References: <20230328-topic-msgram_mpm-v1-0-1b788a5f5a33@linaro.org>
 <20230328-topic-msgram_mpm-v1-2-1b788a5f5a33@linaro.org>
 <20230329034958.GC3554086@dragon>
 <c42b8c24-2159-64ae-d36c-92c69274f24f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c42b8c24-2159-64ae-d36c-92c69274f24f@linaro.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 01:06:11PM +0200, Konrad Dybcio wrote:
> 
> 
> On 29.03.2023 05:49, Shawn Guo wrote:
> > On Tue, Mar 28, 2023 at 12:02:53PM +0200, Konrad Dybcio wrote:
> >> The MPM hardware is accessible to us from the ARM CPUs through a shared
> >> memory region (RPM MSG RAM) that's also concurrently accessed by other
> >> kinds of cores on the system (like modem, ADSP etc.). Modeling this
> >> relation in a (somewhat) sane manner in the device tree basically
> >> requires us to either present the MPM as a child of said memory region
> >> (which makes little sense, as a mapped memory carveout is not a bus),
> >> define nodes which bleed their register spaces into one another, or
> >> passing their slice of the MSG RAM through some kind of a property.
> >>
> >> Go with the third option and add a way to map a region passed through
> >> the "qcom,rpm-msg-ram" property as our register space.
> >>
> >> The current way of using 'reg' is preserved for ABI reasons.
> >>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >>  drivers/irqchip/irq-qcom-mpm.c | 30 +++++++++++++++++++++++++-----
> >>  1 file changed, 25 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
> >> index d30614661eea..6fe59f4deef4 100644
> >> --- a/drivers/irqchip/irq-qcom-mpm.c
> >> +++ b/drivers/irqchip/irq-qcom-mpm.c
> >> @@ -14,6 +14,7 @@
> >>  #include <linux/mailbox_client.h>
> >>  #include <linux/module.h>
> >>  #include <linux/of.h>
> >> +#include <linux/of_address.h>
> >>  #include <linux/of_device.h>
> >>  #include <linux/platform_device.h>
> >>  #include <linux/pm_domain.h>
> >> @@ -322,8 +323,10 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
> >>  	struct device *dev = &pdev->dev;
> >>  	struct irq_domain *parent_domain;
> >>  	struct generic_pm_domain *genpd;
> >> +	struct device_node *msgram_np;
> >>  	struct qcom_mpm_priv *priv;
> >>  	unsigned int pin_cnt;
> >> +	struct resource res;
> >>  	int i, irq;
> >>  	int ret;
> >>  
> >> @@ -374,9 +377,21 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
> >>  
> >>  	raw_spin_lock_init(&priv->lock);
> >>  
> >> -	priv->base = devm_platform_ioremap_resource(pdev, 0);
> >> -	if (IS_ERR(priv->base))
> >> -		return PTR_ERR(priv->base);
> >> +	/* If we have a handle to an RPM message ram partition, use it. */
> >> +	msgram_np = of_parse_phandle(np, "qcom,rpm-msg-ram", 0);
> >> +	if (msgram_np) {
> >> +		ret = of_address_to_resource(msgram_np, 0, &res);
> >> +		/* Don't use devm_ioremap_resource, as we're accessing a shared region. */
> >> +		priv->base = ioremap(res.start, resource_size(&res));
> > 
> > Are you suggesting that other cores/drivers will also need to access
> > the mpm slice below?
> > 
> > 	apss_mpm: sram@1b8 {
> > 		reg = <0x1b8 0x48>;
> > 	};
> Yes, the RPM M3 core. Other slices may be accessed
> by any core at any time.

Hmm, let me reword my question.  Other than irq-qcom-mpm, is there any
other Linux drivers that also need to request this slice region?
Otherwise, I do not understand why devm_ioremap_resource() cannot be
used.

Shawn
