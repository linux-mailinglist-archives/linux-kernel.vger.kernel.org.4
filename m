Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D6B6B4D15
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjCJQeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjCJQeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:34:03 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AFA132BC4;
        Fri, 10 Mar 2023 08:31:26 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-17638494edbso6388863fac.10;
        Fri, 10 Mar 2023 08:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678465861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QypCNI2xqCoN0xaoFVsXgji/AUwaoG1YEw85Z1r0/mI=;
        b=IlfuaYSXwkAWxEL7j8TvdE+63Sskt8XoCMhqfUsEGHsn6v5qRj2PEPKd0B1uqqIBCb
         AIMv/3XMqkjYq5HXn8s8SmCcm8m8ZQxVLh/lvQuUcP7U6HEwnR7aXXyOUyzZHenrT/EV
         4+vgQlIjyLcxAn2qGXL57spa7DIxlwiOWh2NdfpdnfaoeoX5rzbRq5hPEu5IitBUfedW
         dvWxRFBdPNKJ1jOC0aOtyNddHgLXbVN42kHSuigMfCRbA9h6jpd6TN46GhKwu/DthtWp
         +vUKUdPYRQN6uG9YknRpyYwKSzIQn5razXcOHOV8DCz0yOebb00i/KHEPLrKtR/6Kctt
         srsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678465861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QypCNI2xqCoN0xaoFVsXgji/AUwaoG1YEw85Z1r0/mI=;
        b=or7B0UseSiuHKZDQDOVXSI2TxIm74vfkPmprf7E5YYQvTwSOXHBtDpQ4D+Sxr3Oiti
         pMw74tHlO4EsjxIb4WNhZeVYID1IKKsnmzSGOhLxa5YS+4vN0sZOkMcF82hAaMNPWQz/
         DRgtOvRJgOugFUvVIzf49Lj5AN24TAIUOCyUrvLE33fSmTFMOe3LJxQOlwVOxuzeNeL8
         LFE+Fn9+P5H1Cxu+TDQWv3ojBxGx6dQdvG8EBF4EehcDCXbL7r7UEskkAzTuCQy68inS
         ULdH10rBkgydkPavQZRP55+HvWSGyhSl3pplaS1+qtHjTxLRDn93sNEHIFRfYmKf9xXa
         PfLw==
X-Gm-Message-State: AO0yUKVcmGw0lgMvicaKah3NcoR/vFngt94YQd5eK79PMDbV9Btb5qYv
        gHjPeRBEtqFBH7UjY1Jk7q8=
X-Google-Smtp-Source: AK7set/UqV3JOpSMORrqKUDvtpLbjybiIH6IyJL8CUv3QLXGBh/2WpKYvMJ/nXO5UbAEZwsOg/qdYQ==
X-Received: by 2002:a05:6870:3907:b0:172:3d66:c428 with SMTP id b7-20020a056870390700b001723d66c428mr16574711oap.25.1678465861445;
        Fri, 10 Mar 2023 08:31:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c7-20020a4a4f07000000b0051763d6497fsm69564oob.38.2023.03.10.08.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 08:31:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 10 Mar 2023 08:30:59 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: Use of_property_present() for testing DT property
 presence
Message-ID: <3fd0857e-8198-4412-9f82-c768207338d2@roeck-us.net>
References: <20230310144706.1542434-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144706.1542434-1-robh@kernel.org>
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

On Fri, Mar 10, 2023 at 08:47:06AM -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/ibmpowernv.c | 4 ++--
>  drivers/hwmon/pwm-fan.c    | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index 8e3724728cce..594254d6a72d 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -456,9 +456,9 @@ static int populate_attr_groups(struct platform_device *pdev)
>  		 */
>  		if (!of_property_read_string(np, "label", &label))
>  			sensor_groups[type].attr_count++;
> -		if (of_find_property(np, "sensor-data-min", NULL))
> +		if (of_property_present(np, "sensor-data-min"))
>  			sensor_groups[type].attr_count++;
> -		if (of_find_property(np, "sensor-data-max", NULL))
> +		if (of_property_present(np, "sensor-data-max"))
>  			sensor_groups[type].attr_count++;
>  	}
>  
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 83a347ca35da..57928d270015 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -427,7 +427,7 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
>  	struct device_node *np = dev->of_node;
>  	int num, i, ret;
>  
> -	if (!of_find_property(np, "cooling-levels", NULL))
> +	if (!of_property_present(np, "cooling-levels"))
>  		return 0;
>  
>  	ret = of_property_count_u32_elems(np, "cooling-levels");
