Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84B96685CB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjALVrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240128AbjALVrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:47:12 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D29DE99
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:39:56 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b17so14020729pld.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p1iROqIkYhjnh8TCzOffzpktAibiBtkkjcmbNup9a5A=;
        b=O0sdmW5qaH75hEhrzOIUsjf/5Xh6JHONnwGfgbZfg0WWDk07nxvsOsUFxOXelLN7pP
         1XLJOHpnkX3VE64m14qNKWkQ3RCS4Wp7B7pZ85FVfDMXXpGsdzHBjcRuRU0vLbWcdhl7
         SYM58sc0T9jGu7q8VJI0FL5TmkBSIa/YJruu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1iROqIkYhjnh8TCzOffzpktAibiBtkkjcmbNup9a5A=;
        b=IkO8fxP7MAOQlXdqliaxN6y/3XObGJGoJXOfETGeL8ITbI/H5OTxrx+8L7EsnD9fq2
         UALWZYZ6QuyGVpL3wPbDA+5Z+5GhLfY3F7mz0Yr41tkG4qCSzsWZsCuQiJkTTNbpksBl
         Qfu49XsW2UHIqTweUSwlehKmpTEhhQJCsBlSd1rMyf2OvS8UI7yIu5HZ37TY7s3OxJ+V
         7plFO8jN65Nvh5YTLWdQney+kYeF0sTFeh1H9a6NiydXilGryHkofrcqjSxDYMmogUQp
         arTdI+Mcaq88AWiwXg3gu1RXvuoSLaVD04+CxcIFHhAqJAtxcui+UF27B2LmjZb0oAS9
         WNAw==
X-Gm-Message-State: AFqh2kphAz03GUFlxYe9y0O4XadPxhc6tTkPSLQdePb+sTodCBoc5DzD
        sUoadGIZgUJ3ObuYuZntcMOxzw==
X-Google-Smtp-Source: AMrXdXtnU8DSemdsMHGm4Li6ynIxcbtngqZhvSOKD9uqzQUwCm/QNhgo+9C3rCBq4HA+9Lkdw9RrkA==
X-Received: by 2002:a17:903:22c5:b0:193:2ed4:5615 with SMTP id y5-20020a17090322c500b001932ed45615mr22618472plg.29.1673559596172;
        Thu, 12 Jan 2023 13:39:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b00192d9b86318sm12589777plp.137.2023.01.12.13.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 13:39:55 -0800 (PST)
Date:   Thu, 12 Jan 2023 13:39:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     tony.luck@intel.com, gpiccoli@igalia.com,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore/ram: Rework logic for detecting ramoops
Message-ID: <202301121337.B8CCCB6@keescook>
References: <1673428065-22356-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1673428065-22356-1-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 02:37:45PM +0530, Mukesh Ojha wrote:
> The reserved memory region for ramoops is assumed to be at a fixed
> and known location when read from the devicetree. This is not desirable
> in environments where it is preferred the region to be dynamically
> allocated at runtime, as opposed to being fixed at compile time.
> 
> Also, Some of the platforms might be still expecting dedicated
> memory region for ramoops node where the region is known
> beforehand and platform_get_resource() is used in that case.
> 
> So, Add logic to detect the start and size of the ramoops memory
> region by looking up reserved memory region with
> of_reserved_mem_lookup() when platform_get_resource() failed.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>

Thanks for the patch! Notes below...

> ---
>  fs/pstore/ram.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index ade66db..e4bbba1 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -20,6 +20,7 @@
>  #include <linux/compiler.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_reserved_mem.h>
>  
>  #include "internal.h"
>  #include "ram_internal.h"
> @@ -643,6 +644,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>  {
>  	struct device_node *of_node = pdev->dev.of_node;
>  	struct device_node *parent_node;
> +	struct reserved_mem *rmem;
>  	struct resource *res;
>  	u32 value;
>  	int ret;
> @@ -651,13 +653,20 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
> -		dev_err(&pdev->dev,
> -			"failed to locate DT /reserved-memory resource\n");
> -		return -EINVAL;
> +		rmem = of_reserved_mem_lookup(of_node);
> +		if (rmem) {
> +			pdata->mem_size = rmem->size;
> +			pdata->mem_address = rmem->base;
> +		} else {
> +			dev_err(&pdev->dev,
> +				"failed to locate DT /reserved-memory resource\n");
> +			return -EINVAL;
> +		}

Since the "else" case returns, the traditional code pattern is to leave
the other case "inline" (an indented), like so:

		if (!rmem) {
			dev_err(&pdev->dev,
				"failed to locate DT /reserved-memory resource\n");
			return -EINVAL;
		}
		pdata->mem_size = rmem->size;
		pdata->mem_address = rmem->base;


> +	} else {
> +		pdata->mem_size = resource_size(res);
> +		pdata->mem_address = res->start;
>  	}

Since this change the potential interface with DT, can you also update
the documentation in:

Documentation/devicetree/bindings/reserved-memory/ramoops.yaml

Or maybe my understanding of DT parsing is lacking and this change is
doing something slightly different?

-Kees

>  
> -	pdata->mem_size = resource_size(res);
> -	pdata->mem_address = res->start;
>  	/*
>  	 * Setting "unbuffered" is deprecated and will be ignored if
>  	 * "mem_type" is also specified.
> -- 
> 2.7.4
> 

-- 
Kees Cook
