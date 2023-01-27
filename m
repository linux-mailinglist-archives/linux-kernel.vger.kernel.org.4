Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F1667E215
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjA0Koh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjA0KoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:44:23 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDB079210
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:44:08 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so5105305wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AkW+isBb5a4L8sXPP80M2oupV7/HDncbrHTy0pBpxso=;
        b=dDfJbi1aBUhuqqT8X2mY+HRAQt75ovhKiMAWZ0nAXCMfU7MrI9D8WJIU6Cv55OmNYZ
         r7um7oaOYrKiW/zUKXhoc2COViRPF8Ra8Vtt1uC7r8Xj2azwzLX6l5riLJ/GAcfjMfjR
         SGdpd9vUmyI8l5UGkCN76t4ly4fFIDN2aU0uPRUMJA6MsHRANg5ggKywiHn0YatDwPpp
         pSkpLtxehLFIu/afyDWocpkiLZMY56EA2aHEYK3GRAO2WfzzhctjiICPuDsFp2Ymyv9+
         fvmnSSi1BvrkJkNFpn5Vj3KZ8WzGiJS8ZwF0ahSyPjwTGqPROSSpsgQ0FD/OR/5yNn1M
         2pZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkW+isBb5a4L8sXPP80M2oupV7/HDncbrHTy0pBpxso=;
        b=VgI6NuUvWEFNRtjS5bwPmhCFf+LlwBCvZGi0YcxGaNd0JJPtLdyO0iaZWec25pRJpp
         OuDpaPi5pl4xjqCNJ4LTS6VjsHYvriPb5PvIW2Yo++LAcz4MzIIuN+LmsTi+8Unpx+8s
         RRPuzPCaBIGcL1/6nOd0QRdHWI+3E74WCJhqbTiXETB5e/Juxon6pk3uiaclHXdRcTmL
         XMX3+QvF6V57+4YeI/kTa+rmBrqXS/DXdvfuxNywK+oRJImeygqVqDPm0FfJiLEQ7BcS
         YgjLrAwVFsCCUrlXGVNFiUk+P14hy2g4BImcNVnxplAncBfo9ePu+9kF2kD+fxtCygFl
         /tIA==
X-Gm-Message-State: AFqh2koNco9DvtPRHWrMQLX7/h1UfX6Cod0IgWJQhUiDxYdDYPSnlkfX
        WWGHJmOadLQ1rVrPIhi49+AqHA==
X-Google-Smtp-Source: AMrXdXt0Mvi4+KEHGy6hm4OEafsyenG7wbOGszWwYqJji+sJPQeK/taITq8Wn0jA9ObTlqT/gSx9cw==
X-Received: by 2002:a05:600c:2e51:b0:3da:632:a8d with SMTP id q17-20020a05600c2e5100b003da06320a8dmr38440855wmf.10.1674816247195;
        Fri, 27 Jan 2023 02:44:07 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id j38-20020a05600c1c2600b003daff80f16esm10418913wms.27.2023.01.27.02.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:44:06 -0800 (PST)
Date:   Fri, 27 Jan 2023 12:44:05 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC] PM: domains: Skip disabling unused domains if provider has
 sync_state
Message-ID: <Y9Oq9Z4s8oqrIG6m@linaro.org>
References: <20230126234013.3638425-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126234013.3638425-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-27 01:40:13, Abel Vesa wrote:
> Currently, there are cases when a domain needs to remain enabled until
> the consumer driver probes. Sometimes such consumer drivers may be built
> as modules. Since the genpd_power_off_unused is called too early for
> such consumer driver modules to get a chance to probe, the domain, since
> it is unused, will get disabled. On the other hand, the best time for
> an unused domain to be disabled is on the provider's sync_state
> callback. So, if the provider has registered a sync_state callback,
> assume the unused domains for that provider will be disabled on its
> sync_state callback.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Please ignore this version as it is only part of the solution.

Have a look at v2 here:
https://lore.kernel.org/lkml/20230127104054.895129-1-abel.vesa@linaro.org/

> ---
> 
> This approach has been applied for unused clocks as well.
> With this patch merged in, all the providers that have sync_state
> callback registered will leave the domains enabled unless the provider's
> sync_state callback explicitly disables them. So those providers will
> need to add the disabling part to their sync_state callback. On the
> other hand, the platforms that have cases where domains need to remain
> enabled (even if unused) until the consumer driver probes, will be able,
> with this patch in, to run without the pd_ignore_unused kernel argument,
> which seems to be the case for most Qualcomm platforms, at this moment.
> 
>  drivers/base/power/domain.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 84662d338188..8e72e8e38c77 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1099,7 +1099,8 @@ static int __init genpd_power_off_unused(void)
>  	mutex_lock(&gpd_list_lock);
>  
>  	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
> -		genpd_queue_power_off_work(genpd);
> +		if (!dev_has_sync_state(genpd->provider->dev))
> +			genpd_queue_power_off_work(genpd);
>  
>  	mutex_unlock(&gpd_list_lock);
>  
> -- 
> 2.34.1
> 
