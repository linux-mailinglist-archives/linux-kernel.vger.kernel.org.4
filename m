Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E867665C8C0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbjACVPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237846AbjACVPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:15:15 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7C112A9F;
        Tue,  3 Jan 2023 13:15:15 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id v15-20020a9d69cf000000b006709b5a534aso19789510oto.11;
        Tue, 03 Jan 2023 13:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LVZJYsvTSNhT+L3m3CfYNGAUDlE19+ZqTv+piXDIqw=;
        b=M9AWIawFkysZb72rErgJ0vvoz/xkTUtR22D+SE+2lphIswibvX7pfpQL9AJxhPTGcH
         H/0rLJwfhK4oe4Af6u2OCa6YCPFrFK8s+mOfU7aDLpukR/iC+vTT2AXrFTZCPshltz6A
         XK2EGJ+YzAjwqxTLim/puH70Svy2MMTH1KDKkfKEYsg0sBk+Igle1vxdAc0TKPJEg/nw
         9h0rXwaC1fhTvp/JgKHeBP+nfm/StBfRTkBn+3RIT7dNAmM1rdeFEEmbG/7+VwRykIrO
         kKvwLjXKghPLrTe+WLbcI/3JK5AISuBOaNkx+sfosy9U5aCTuKJtgmJgMYbJN3vBUNDt
         zF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LVZJYsvTSNhT+L3m3CfYNGAUDlE19+ZqTv+piXDIqw=;
        b=0TUAvRyThHfYz0IfihTUXRAMXAhyiXE2uFUtBH836qMXkr0c0/+tkGv/lm8jEm3jMY
         eqkp+svHr6JjPYlMJNkPCAjszvKDBN8VhHkG4Ci5uIAyhSpQOQAqIf+RQC1+b18PhEtK
         mL1lZnXOxK346A+t1nbORiHyLxZVSlLMNiXB/P9zww8zi8lb7wFrZAtEk7DtbPI0G+Bi
         omiCa1a47LYQovsgXwX0FlOKL5q0yrwLJMA/tuqRpSXQZH63T+jGEPsKQzYK0Pr0S8uL
         8MTogMUYlO2YG0C22djlK/WVzA53Z4pQb6CjAgrUjBmaDs14fV6E9Y8cT+iMNkILyocA
         f2rw==
X-Gm-Message-State: AFqh2krNgOI9JuH4tnsxWUATId9/uv4rxre+7HmnkJwZPXBptMMOllmI
        5syXwNkRMUUMmdekJdk067rduEOCByQ=
X-Google-Smtp-Source: AMrXdXu2cHRzMmhzsRL42vE/BVJMZAbQG2er07lmivi9B4Q/7hS3feNNDdhcoPJAjNt+njV0u/vMsQ==
X-Received: by 2002:a9d:73ca:0:b0:670:5da6:7f02 with SMTP id m10-20020a9d73ca000000b006705da67f02mr25909128otk.33.1672780514521;
        Tue, 03 Jan 2023 13:15:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d12-20020a0568301b6c00b006391adb6034sm15190897ote.72.2023.01.03.13.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 13:15:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 3 Jan 2023 13:15:12 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: pic32-dmt: Use devm_clk_get_enabled() helper
Message-ID: <20230103211512.GD212337@roeck-us.net>
References: <f9a4dcfc6d31bd9c1417e2d97a40cc2c1dbc6f30.1672496405.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9a4dcfc6d31bd9c1417e2d97a40cc2c1dbc6f30.1672496405.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 03:20:29PM +0100, Christophe JAILLET wrote:
> The devm_clk_get_enabled() helper:
>    - calls devm_clk_get()
>    - calls clk_prepare_enable() and registers what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the need of a dedicated function used
> with devm_add_action_or_reset().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/pic32-dmt.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/watchdog/pic32-dmt.c b/drivers/watchdog/pic32-dmt.c
> index f43062b3c4c8..bc4ccddc75a3 100644
> --- a/drivers/watchdog/pic32-dmt.c
> +++ b/drivers/watchdog/pic32-dmt.c
> @@ -164,11 +164,6 @@ static struct watchdog_device pic32_dmt_wdd = {
>  	.ops		= &pic32_dmt_fops,
>  };
>  
> -static void pic32_clk_disable_unprepare(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static int pic32_dmt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -184,20 +179,12 @@ static int pic32_dmt_probe(struct platform_device *pdev)
>  	if (IS_ERR(dmt->regs))
>  		return PTR_ERR(dmt->regs);
>  
> -	dmt->clk = devm_clk_get(dev, NULL);
> +	dmt->clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(dmt->clk)) {
>  		dev_err(dev, "clk not found\n");
>  		return PTR_ERR(dmt->clk);
>  	}
>  
> -	ret = clk_prepare_enable(dmt->clk);
> -	if (ret)
> -		return ret;
> -	ret = devm_add_action_or_reset(dev, pic32_clk_disable_unprepare,
> -				       dmt->clk);
> -	if (ret)
> -		return ret;
> -
>  	wdd->timeout = pic32_dmt_get_timeout_secs(dmt);
>  	if (!wdd->timeout) {
>  		dev_err(dev, "failed to read watchdog register timeout\n");
> -- 
> 2.34.1
> 
