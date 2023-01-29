Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1604B680145
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 20:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjA2Tze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 14:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjA2Tzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 14:55:31 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C27A1CF47;
        Sun, 29 Jan 2023 11:55:30 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1636eae256cso8478225fac.0;
        Sun, 29 Jan 2023 11:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLbGoONm+xqkc97+A+Zml853XMzw+B9pcYL8n8StFtc=;
        b=glgR4Glc5nCL8S38ROz9Eol5ou+EwE88pZMvzmg9G0C0UFLvFS9zx2l9qX35HD8X0c
         Lt3jYr7P7Sim+CwD3YTqTRjQOTVZBYoRdp0K+fOV6NPvIuMoB6L3i2gn8glZF6vrkBp7
         Kwr9/NNeqXlnrgJCq2Gnj30mG562pjU30JJn43C8wgjBh8O5MODomLHYaz1YFO4oZpPK
         kAuVguFXqwmUnX1gKcp0FuAYAO3GlzNdZolhhxQ9TWLVQQs9sOPI68miGGt+oUGbyo+Z
         dGwEqbxyWOyNbXsrr6EWoXo9pTknyxFz0Dcg58iTmOwRNI7BZHdW4wIfEIIOms2t1PER
         h1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLbGoONm+xqkc97+A+Zml853XMzw+B9pcYL8n8StFtc=;
        b=4F/KeiAaVt7ap6w9kdcG5sJ39NrGPTXiTzHi+RSEMywynD9mjTciBOBQp/9Dumy0W7
         GGSyXV3mqAArB4ZdDis3GD5H/HAlDdP1e/sprlxJYAPkGnu7MZoZwL/9CyfL6JrxK+2W
         puBCB+q3IIzYjkVoU5Br6MdsOgf9dVWdIx5Ue2ztzbi4UohKd4lP+VWe9Z1nm1xSPCQm
         U11tZuZqXLFSp4gsP7/+8iKSRJeZ+Yf1eS36FKp5MKWclRcyD60WQEQpI4p09aHpPI69
         uCRpgOJrMJbnY4ldYE+GpztFY/YBhLJbwBV9R5fhvv6xWga0uzYdyy4oyafkyd9oN/TD
         IQGg==
X-Gm-Message-State: AO0yUKUOGp7PhP6saYOu8LAG+vfJnKd2sS4ZkoS1bMXggb7q6jszTbRg
        xlS8Nn/pA1b95UkKtui9Zt+vxSpLlH8=
X-Google-Smtp-Source: AK7set+okvx2usDN7KXb0eVoAYP+qVRqZ2yWIGMLR8EbD4Cr34aPvBS58WDLuGaWP1Mj3KYRBCcvZQ==
X-Received: by 2002:a05:6870:42cc:b0:163:1568:bdc9 with SMTP id z12-20020a05687042cc00b001631568bdc9mr11214890oah.2.1675022129681;
        Sun, 29 Jan 2023 11:55:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l11-20020a4ab2cb000000b004a3527e8279sm4206123ooo.0.2023.01.29.11.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 11:55:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 29 Jan 2023 11:55:28 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jonathan Cormier <jcormier@criticallink.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>
Subject: Re: [PATCH v4 5/5] hwmon: ltc2945: Convert division to
 DIV_ROUND_CLOSEST_ULL
Message-ID: <20230129195528.GA1418977@roeck-us.net>
References: <20230126-b4-ltc2945_shunt_resistor-v4-0-bb913470d8da@criticallink.com>
 <20230126-b4-ltc2945_shunt_resistor-v4-5-bb913470d8da@criticallink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126-b4-ltc2945_shunt_resistor-v4-5-bb913470d8da@criticallink.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 05:32:27PM -0500, Jonathan Cormier wrote:
> Convert division to DIV_ROUND_CLOSEST_ULL to match code
> in same function.
> 
> Signed-off-by: Jonathan Cormier <jcormier@criticallink.comi
> ---
>  drivers/hwmon/ltc2945.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
> index 0b5e448b4f12..33341d01f1f7 100644
> --- a/drivers/hwmon/ltc2945.c
> +++ b/drivers/hwmon/ltc2945.c
> @@ -212,7 +212,7 @@ static long long ltc2945_val_to_reg(struct device *dev, u8 reg,
>  	case LTC2945_MAX_VIN_THRES_H:
>  	case LTC2945_MIN_VIN_THRES_H:
>  		/* 25 mV resolution. */
> -		val /= 25;
> +		val = DIV_ROUND_CLOSEST_ULL(val, 25);

This needs to be combined with the previous patch since that patch changes
'val' from unsigned long to unsigned long long, causing a compile failure
on 32-bit builds.

I'll do that unless some other 32 bit build failure shows up.

Guenter

>  		break;
>  	case LTC2945_ADIN_H:
>  	case LTC2945_MAX_ADIN_H:
> 
> -- 
> 2.25.1
> 
