Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302F96CF8C3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 03:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjC3BfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 21:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjC3Be7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:34:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52BC4C07
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 18:34:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id iw3so16689000plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 18:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680140097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+s3/7avJ4jXfEL/EcHu+vdSVHrfTZ0GFVAw0Oijq+5s=;
        b=Fvg2Ut9YmRIdGmiIGn0vAOuc+ZHU1m8fZpC4dHiKI+1SK3oXa61qaRx2rkr1rYJkz7
         i71lQU96Xbnmo3P8Dm2QC5r4YMCmnyhURdPljQ0WbKGuIg5TjeepcD9nwIs+AyWbls4Z
         dOUZJxDUKTwc7uYxe5h4TO9zFvALEqUiriR8Vqw8frJhrO2ByWApDe4Rnhngohf619Tw
         jd0wN9xKEJE+8QkMXbMmmzFZ8npJ36rxqt/Y2GSc3kSpURapwoo871F6ib3hpTujXKKz
         ONoDrfZ+S6fDV7zxFpxXPghWFE5b/HvloxI9WCxYdjk/KyNrDY1rm+sDl3KblEKSNSi0
         zMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680140097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+s3/7avJ4jXfEL/EcHu+vdSVHrfTZ0GFVAw0Oijq+5s=;
        b=Djf/wMh75PKJH9kO7NIEN3KbKcs2wX2U6USeGmz9ui1P8m/OCluv+azaJJujzxRFJt
         xt0+kF6veJYZfp0d9r8b94jwWMM9H+bV+vm0CHQezdqPKthgK5KS6fOmrAWgc0sermg3
         CwoalCmu89uCtlKNURIspmRUztIz1UoaaCKzAj5HkDfGW7woHbiz/fVSMxrqDD45UVbt
         73DbVn970NF2NgoT6v31fgwpSGXWZl0VcNzXY/I/GbvUa9BstHQkDs+AfbUqf+eb1Xva
         KrkfqYccXk6d4/OoCxXPy2dO87RiQQK7osV+fX5DyZKKi/avHkLdMcGFISdaGp8M8GfI
         KagA==
X-Gm-Message-State: AAQBX9fOJLmlDQEnCrtqqIUOyoTuta11VMEdhdDqjSwxxVm4Blc4h3If
        4TmGRtFd9KDZxkZUNfOUwVc3yA==
X-Google-Smtp-Source: AKy350byhc7BcOIWgRDGMh3ui2tHi24Dd3KnN1ayQaCGu36TkkQY/yVUP2ZTbD6kyTEXIQN2psP5VA==
X-Received: by 2002:a17:90a:198e:b0:237:9cc7:28a4 with SMTP id 14-20020a17090a198e00b002379cc728a4mr23166855pji.14.1680140097081;
        Wed, 29 Mar 2023 18:34:57 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id ij21-20020a17090af81500b0023b3d80c76csm2081346pjb.4.2023.03.29.18.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 18:34:56 -0700 (PDT)
Date:   Thu, 30 Mar 2023 09:34:49 +0800
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
Message-ID: <20230330013449.GB3590215@dragon>
References: <20230328-topic-msgram_mpm-v1-0-1b788a5f5a33@linaro.org>
 <20230328-topic-msgram_mpm-v1-2-1b788a5f5a33@linaro.org>
 <20230329034958.GC3554086@dragon>
 <c42b8c24-2159-64ae-d36c-92c69274f24f@linaro.org>
 <20230329132819.GA3590215@dragon>
 <14350eba-edb6-0243-5451-2e2b7d1bd3fd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14350eba-edb6-0243-5451-2e2b7d1bd3fd@linaro.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 03:30:12PM +0200, Konrad Dybcio wrote:
> >>>> @@ -374,9 +377,21 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
> >>>>  
> >>>>  	raw_spin_lock_init(&priv->lock);
> >>>>  
> >>>> -	priv->base = devm_platform_ioremap_resource(pdev, 0);
> >>>> -	if (IS_ERR(priv->base))
> >>>> -		return PTR_ERR(priv->base);
> >>>> +	/* If we have a handle to an RPM message ram partition, use it. */
> >>>> +	msgram_np = of_parse_phandle(np, "qcom,rpm-msg-ram", 0);
> >>>> +	if (msgram_np) {
> >>>> +		ret = of_address_to_resource(msgram_np, 0, &res);
> >>>> +		/* Don't use devm_ioremap_resource, as we're accessing a shared region. */
> >>>> +		priv->base = ioremap(res.start, resource_size(&res));
> >>>
> >>> Are you suggesting that other cores/drivers will also need to access
> >>> the mpm slice below?
> >>>
> >>> 	apss_mpm: sram@1b8 {
> >>> 		reg = <0x1b8 0x48>;
> >>> 	};
> >> Yes, the RPM M3 core. Other slices may be accessed
> >> by any core at any time.
> > 
> > Hmm, let me reword my question.  Other than irq-qcom-mpm, is there any
> > other Linux drivers that also need to request this slice region?
> No.
> 
> > Otherwise, I do not understand why devm_ioremap_resource() cannot be
> > used.
> drivers/rpmsg/qcom_glink_rpm.c calls devm_ioremap on the entire
> RPM MSG RAM.

Can we use devm_ioremap() too instead of ioremap() here?

Shawn
