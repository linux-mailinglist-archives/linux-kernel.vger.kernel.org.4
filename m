Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA835F0195
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 01:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiI2X5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 19:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiI2X5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:57:08 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9911BDD342
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:57:07 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id h8-20020a17090a054800b00205ccbae31eso7417771pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=0hiOmFNw3vUr1qIQOZ1iJJ1qBvLhM6j/K3PWxBaYczc=;
        b=5l3Wz8QGzNmFy1Pdo3QEYdmZHKvSz0I8lPVAQYxa2tj4jdOPky5i7z91BpVenP6MRM
         SXiIG1t1GDDtp7grWn/nqd8gNvsm7aMgO4+lKFbuY+z/sJOeN9yUZmPz7oocGz25EpzJ
         zWep0/7AFMcsPGoVC1f0ksBWjsg8kbSY4QvmJ95O//dgruZS9oedRbqOdY0J6iK48EAh
         Tchl6UNBsN1Ma/EbxonpSPefeS9/rl1RKZqFvXBHcVBWOUATM+XYjCpv+TOqTaNDCxdL
         7pVseHvIqlRTCVUBQSQ4POJMzAK7y66HCvrC1VFj4NJHq4edNbR3NSxBSKKiu0KeLTPh
         dtYA==
X-Gm-Message-State: ACrzQf1nddSH+FdK2f//QjUwxKrrme2kcDP1Do/nPc5TPRFE1hvZKIZQ
        /1rNrlQCxk8+kLht8uFmC0JKYQ==
X-Google-Smtp-Source: AMsMyM7RickZmWvA5nYIbma/BzAEICuH8mn9KHWobs8Qk2wZLETHH9DVEjzYRV8475r2zCKl7GjRzg==
X-Received: by 2002:a17:90a:fd8c:b0:200:8cf9:63f4 with SMTP id cx12-20020a17090afd8c00b002008cf963f4mr6362140pjb.201.1664495827086;
        Thu, 29 Sep 2022 16:57:07 -0700 (PDT)
Received: from localhost ([75.172.140.17])
        by smtp.gmail.com with ESMTPSA id v6-20020a17090a0c8600b001fd9c63e56bsm4035477pja.32.2022.09.29.16.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 16:57:06 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH] PM: domains: log failures to register always-on domains
In-Reply-To: <20220929154214.7305-1-johan+linaro@kernel.org>
References: <20220929154214.7305-1-johan+linaro@kernel.org>
Date:   Thu, 29 Sep 2022 16:57:05 -0700
Message-ID: <7h7d1lwx7y.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Hovold <johan+linaro@kernel.org> writes:

> Always-on PM domains must be on during initialisation or the domain is
> currently silently rejected.
>
> Print an error message in case an always-on domain is not on to make it
> easier to debug drivers getting this wrong (e.g. by setting an always-on
> genpd flag without making sure that the state matches).
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/base/power/domain.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
>
> Both myself and Matthias have hit this with the Qualcomm GCC drivers
> when updating static genpd flags directly instead of using/adding driver
> specific flags to propagate the setting.
>
> Johan
>
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index bbfbf05b3446..7200e307effb 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2087,8 +2087,10 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>  
>  	/* Always-on domains must be powered on at initialization. */
>  	if ((genpd_is_always_on(genpd) || genpd_is_rpm_always_on(genpd)) &&
> -			!genpd_status_on(genpd))
> +			!genpd_status_on(genpd)) {
> +		pr_err("always-on PM domain %s is not on\n", genpd->name);
>  		return -EINVAL;
> +	}
>  
>  	/* Multiple states but no governor doesn't make sense. */
>  	if (!gov && genpd->state_count > 1)
> -- 
> 2.35.1
