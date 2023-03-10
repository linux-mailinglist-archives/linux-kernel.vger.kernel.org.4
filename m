Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7AD6B4D27
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCJQhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCJQg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:36:26 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C435511A2EF;
        Fri, 10 Mar 2023 08:34:30 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-17671fb717cso6415211fac.8;
        Fri, 10 Mar 2023 08:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678466070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPJxiCRlQW/W48kByDBhimvQnyU3C5JNlIoFKiJIKsY=;
        b=I9hW2rHEbSHl/El+QE/fJYhZuX4ngiNfGCVohLu1ytEasDqTDiDoqHvTGFDNqHTwif
         bAKx+WxnUIzlUGnAQZ4KCkzxHLeAwExFjAJe2HWhYST4u17aPF5Huw0rpc2do/ZAFX6j
         tNM85NC26RzFu7JDW5H/sZ2y6EcDi7QKybKzuDWS7lI4I8Tm8LJ0M1d0jUwWs1roQE51
         4BFHty0H4e9M3cbgALyKgtmcmlS8Bnm0f+Bo3RG00l3SMG+Luo4eCDGpEIJx0ECSsyca
         pAVWxoVySVfa6loVxqKTiHw0KG2uQuiWUhx4f13pKQYCRVISiwvEY09v3kd9BVMXT5OB
         jHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678466070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPJxiCRlQW/W48kByDBhimvQnyU3C5JNlIoFKiJIKsY=;
        b=EuXoMn5K9FAk4NeDIttkQ8KAV+LBHGfwQP612bI71MhBtueP21p8BO/0IMtFErNpbI
         EF7NLc1YEMLCTXDh5lu77m1FJYQmIp8E9CnxCpvzDlLyEfB14uyG5vEWMX8sdfN3fLYw
         /lVfOH8PtRPIOEdqC1Yan7YPLMrgASAxpmwL4le/J1zq3e+f2hnYiipwpWKL7U13vTZ8
         nYkVkbVlsT5B1xzOucesbAYdX/rCMOp87NHA0e+AHJrZDR10a2gbJ2pJm0G8UCougIb2
         /ICNwktq8dhbDnC2GzOnurerpbfuWemN1asldcRjSF5KBbejs+AOnenLeeiUuAdhg4dU
         Qtrg==
X-Gm-Message-State: AO0yUKWuaiU7vFAkKwsrxwudZCYs2t98bfhKBguSQcNof3lbN0o4gZk9
        W72hRo84lGtqycfTmXLOhtcZgVjIfw0=
X-Google-Smtp-Source: AK7set8eONhgxwikN6SJ1cfNKEg3V62ib8kLAFMsc33wZIBpBBWnsdGWDQECMhKDwvEFshE1fCeZkA==
X-Received: by 2002:a05:6870:5709:b0:172:6d0c:e98c with SMTP id k9-20020a056870570900b001726d0ce98cmr14222316oap.29.1678466069925;
        Fri, 10 Mar 2023 08:34:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v18-20020a056870e49200b0017243e98ce9sm166730oag.54.2023.03.10.08.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 08:34:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 10 Mar 2023 08:34:28 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ina3221) return prober error code
Message-ID: <cfbf7f59-6f93-4e21-8a1b-88a769fcec0d@roeck-us.net>
References: <20230310075035.246083-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310075035.246083-1-marcus.folkesson@gmail.com>
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

On Fri, Mar 10, 2023 at 08:50:35AM +0100, Marcus Folkesson wrote:
> ret is set to 0 which do not indicate an error.
> Return -EINVAL instead.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/ina3221.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index e06186986444..f3a4c5633b1e 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -772,7 +772,7 @@ static int ina3221_probe_child_from_dt(struct device *dev,
>  		return ret;
>  	} else if (val > INA3221_CHANNEL3) {
>  		dev_err(dev, "invalid reg %d of %pOFn\n", val, child);
> -		return ret;
> +		return -EINVAL;
>  	}
>  
>  	input = &ina->inputs[val];
