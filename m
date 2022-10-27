Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C516360F1CB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiJ0IFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbiJ0IF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:05:27 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D339038454
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 01:05:24 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m2so804375pjr.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 01:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sql+Rr6DrOQzxcxiEzDTWhDssE9ABXcq2lRpWcbPbWI=;
        b=wmtMoHhM7uspTGMQFmqR0TSsTvi8olpJcfGv3QmnI7VkoQppvutu22gulZguTxBaqo
         bp1A19eJq1XK0NXfSKyjkwDK/9iLZBcdcLLIBOKLU48su51D27MLsTyxHGnB9j/+sVCq
         1Ak+9bn8icFC3cm69+GS5lvuiNmJrcOYXF77IfwsNcz+PIHtXDt6KMBYLvGznmaIDJir
         eviCsgEuD2znZrRvWvNAoikvJ4aFxr4USltgUeZfo22RHof/R3w4+ylSH2TeBm4YMLyX
         BzevUk5vw/7L7ulOExe2mLo9DvSTPL+DDxFBucivfIOYTILwDp2RK/YdfJWERD58/oI7
         2HXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sql+Rr6DrOQzxcxiEzDTWhDssE9ABXcq2lRpWcbPbWI=;
        b=YEs8PmNebYXp/OSs1iwXxrEZ8XQuIDw+FdYDUNoR0T6YTiBwZbtR9x7ZmURUaH3w+K
         bcV3o3FTnQCPoi11I9y7sUmS6csyVbcqbDmPm/kIi7M6UrL6tR06+vv5VYqaLIjIH/R8
         NueE11SbyFq7KYMZSU1kj0f/95KPgA+ySzoIil40xbxsc/8kQ4y6Tnf8gYgQ0UapFdv2
         Hk6ECsQtmG/JaSZbe8FkIEFp9tptWlRwNm3Icuc5CKv2mJlQ6Ip5QF2U/5QYVVYQS7U+
         BgppIrhW1drkwuJA624ELhWwmRtf0ECji56k5wETSEVfOQKuHMoEALfuV2TuVLtXG6LL
         6fyw==
X-Gm-Message-State: ACrzQf081Y81E8dojQJng89/6gDUFdLgFVafGARFSO/g4tBuGujcL9QW
        vsBGZZXCpanKnGGiKSjyHQmOnw==
X-Google-Smtp-Source: AMsMyM71ps0bazOq0Z7yGgKMJqS6PEa1XhxiHHFqdfKJA1fG9M1vZM01GCryVNs97C/2vDe4jz/jwQ==
X-Received: by 2002:a17:902:ea02:b0:181:f8d2:1c2b with SMTP id s2-20020a170902ea0200b00181f8d21c2bmr49049802plg.107.1666857924316;
        Thu, 27 Oct 2022 01:05:24 -0700 (PDT)
Received: from localhost ([122.172.87.26])
        by smtp.gmail.com with ESMTPSA id q34-20020a635062000000b0044ba7b39c2asm531976pgl.60.2022.10.27.01.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 01:05:23 -0700 (PDT)
Date:   Thu, 27 Oct 2022 13:35:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Erico Nunes <nunes.erico@gmail.com>
Cc:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/lima: Fix opp clkname setting in case of missing
 regulator
Message-ID: <20221027080519.lfpduyt7jcwh3b4k@vireshk-i7>
References: <20221027073200.3885839-1-nunes.erico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027073200.3885839-1-nunes.erico@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-10-22, 09:32, Erico Nunes wrote:
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
> v2: revert back to using devm_pm_opp_set_clkname and
> devm_pm_opp_set_regulators
> ---
>  drivers/gpu/drm/lima/lima_devfreq.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
> index 011be7ff51e1..bc8fb4e38d0a 100644
> --- a/drivers/gpu/drm/lima/lima_devfreq.c
> +++ b/drivers/gpu/drm/lima/lima_devfreq.c
> @@ -112,11 +112,6 @@ int lima_devfreq_init(struct lima_device *ldev)
>  	unsigned long cur_freq;
>  	int ret;
>  	const char *regulator_names[] = { "mali", NULL };
> -	const char *clk_names[] = { "core", NULL };
> -	struct dev_pm_opp_config config = {
> -		.regulator_names = regulator_names,
> -		.clk_names = clk_names,
> -	};
>  
>  	if (!device_property_present(dev, "operating-points-v2"))
>  		/* Optional, continue without devfreq */
> @@ -124,7 +119,15 @@ int lima_devfreq_init(struct lima_device *ldev)
>  
>  	spin_lock_init(&ldevfreq->lock);
>  
> -	ret = devm_pm_opp_set_config(dev, &config);
> +	/*
> +	 * clkname is set separately so it is not affected by the optional
> +	 * regulator setting which may return error.
> +	 */
> +	ret = devm_pm_opp_set_clkname(dev, "core");
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_pm_opp_set_regulators(dev, regulator_names);
>  	if (ret) {
>  		/* Continue if the optional regulator is missing */
>  		if (ret != -ENODEV)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
