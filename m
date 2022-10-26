Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AE460DE31
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiJZJgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 05:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiJZJgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:36:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F418B7F4A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 02:36:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b29so10294642pfp.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 02:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A9mSjdRb9KM4dYC9nqa6mNw2Qysra6o5S2BSbupDfSU=;
        b=lgGeskGbrG8neak0/Y8yJ0WctjcOjrXUgIyL81LVrtR7XQVIdxGyF7+fgpUxDWT04f
         PzAueKh+XaMUAxMFGDdRiOQB/xPcF4tNWQ34ZR/YD2qVLHwP9pCDTmuJ+vX/wkfN5FMv
         a3a0Aq6hDZ3oVkHhk/N8Mumdvp2DqAYy/6f1LHqghRBpURqL3kmFZKpbuVGyzw3ERXGG
         cmzj+5aXtCqIw9uJ9J6ZwGmR499OABiEeHBFETpI+cjdnSvrgMAj2/tlCMO1dPpUbfyt
         q+XZmI+VobE+6TnPMl4CmYe2L/PE0WUCSlv31OBlO8bZi/KiWXluTviIn+eyQ1ugLFRn
         8wYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9mSjdRb9KM4dYC9nqa6mNw2Qysra6o5S2BSbupDfSU=;
        b=1keoSL8/sdt9NyMsfJ1djouflFm/r6keJk6UTEVexGMd8i8UMamYpK91ON3/4o/Gj4
         alaYCMAFxohORIunehZjrAZDGoFn5kJstiyfYd7ZhnWiFAif2vEEGqLzIh3md9S7G1s3
         ZHcJMUDvAJHYYe2VuYSugc0zcIfugLdlit0VwK8PG9bnGzPfAVQtnRYwV1N5tWr7dT8R
         jMeEy6KWawqe6QaR3jYi/385azdCt+Lo1pvgOjdvosMxPLV2Mz1iVqGjNS+SOkVX93Im
         NDKc+JUxjzfNWa8Xd4NrZ7SKgRsOxRs7UD8lXBFyPaPCrmiFXaUffc84VGBKsAA7RZYz
         X9Zw==
X-Gm-Message-State: ACrzQf1XdlsCt3m7PtN1YYgmwO8OA2rcffViyV8VgtKO62gs2QWbMPbJ
        xdJDEuxBz2vLjEfaXlkwCzJaPQ==
X-Google-Smtp-Source: AMsMyM6LdL6b5vGvszw5b9WpCHKp6mKcUTgbL+6jq+23PKynOXObS5JWUrmfpyfbH0Potsx5n/ILiA==
X-Received: by 2002:a63:6942:0:b0:41c:9261:54fd with SMTP id e63-20020a636942000000b0041c926154fdmr37618341pgc.34.1666776966919;
        Wed, 26 Oct 2022 02:36:06 -0700 (PDT)
Received: from localhost ([122.172.87.26])
        by smtp.gmail.com with ESMTPSA id d7-20020a17090a498700b0021134a19ae2sm807871pjh.50.2022.10.26.02.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 02:36:06 -0700 (PDT)
Date:   Wed, 26 Oct 2022 15:06:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Erico Nunes <nunes.erico@gmail.com>
Cc:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/lima: Fix dev_pm_opp_set_config in case of missing
 regulator
Message-ID: <20221026093604.nuielehywjtxe2mn@vireshk-i7>
References: <20221026083950.3712598-1-nunes.erico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026083950.3712598-1-nunes.erico@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-10-22, 10:39, Erico Nunes wrote:
> Commit d8c32d3971e4 ("drm/lima: Migrate to dev_pm_opp_set_config()")
> introduced a regression as it may undo the clk_names setting in case
> the optional regulator is missing. This resulted in test and performance
> regressions with lima.
> 
> Restore the old behavior where clk_names is set separately so it is not
> undone in case of a missing optional regulator.
> 
> Fixes: d8c32d3971e4 ("drm/lima: Migrate to dev_pm_opp_set_config()")
> Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
> ---
>  drivers/gpu/drm/lima/lima_devfreq.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
> index 011be7ff51e1..9c8654934fea 100644
> --- a/drivers/gpu/drm/lima/lima_devfreq.c
> +++ b/drivers/gpu/drm/lima/lima_devfreq.c
> @@ -113,10 +113,12 @@ int lima_devfreq_init(struct lima_device *ldev)
>  	int ret;
>  	const char *regulator_names[] = { "mali", NULL };
>  	const char *clk_names[] = { "core", NULL };
> -	struct dev_pm_opp_config config = {
> -		.regulator_names = regulator_names,
> +	struct dev_pm_opp_config config_clk_names = {
>  		.clk_names = clk_names,
>  	};
> +	struct dev_pm_opp_config config_regulator_names = {
> +		.regulator_names = regulator_names,
> +	};
>  
>  	if (!device_property_present(dev, "operating-points-v2"))
>  		/* Optional, continue without devfreq */
> @@ -124,7 +126,15 @@ int lima_devfreq_init(struct lima_device *ldev)
>  
>  	spin_lock_init(&ldevfreq->lock);
>  
> -	ret = devm_pm_opp_set_config(dev, &config);
> +	/*
> +	 * Set clk_names separately so it is not undone in case of
> +	 * a missing optional regulator.
> +	 */
> +	ret = devm_pm_opp_set_config(dev, &config_clk_names);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_pm_opp_set_config(dev, &config_regulator_names);

You can directly call devm_pm_opp_set_clkname() and
devm_pm_opp_set_regulators(), like it was done before my patch, for
single configurations. So basically a simple revert of my commit, with
additional comments you added above.

>  	if (ret) {
>  		/* Continue if the optional regulator is missing */
>  		if (ret != -ENODEV)
> -- 
> 2.37.3

-- 
viresh
