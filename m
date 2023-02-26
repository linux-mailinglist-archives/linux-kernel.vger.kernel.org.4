Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37C36A3534
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 00:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBZXAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 18:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjBZXAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 18:00:38 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8567C1A4A2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:59:56 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id y10so300394qtj.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuxVktP8ly6XYuWVV4eBaobSoUkGl5I6o/QFWMFqZ4U=;
        b=MDWGB4/Ivj5Q9bj67cpTq7udIQdS1WirVd6PJlCOAR4N/wq6G7FZQYl6CAyCg4b3/3
         bCWOqPK0/soz4Ennv5NMA4a/A1S5EcFy6rkC2FNII0mRzikypnk5YKuO8kJ5zRdDZtlA
         rbWnmDIgwiMW7bUWazrNMA7d3oKFt6i2w1jNJk9vl6r3Cyzuoub9iAzujgYb4+WpR5J7
         xpI0h/TC3KPsJUHVgTSFwnmPvSQ2h9MGV85P1AvfQfdcHkKgDWsBB/mYo/NJJ6d/uXBw
         Fp7r5zQtpc4bBUB3cKg1xsSnqORrILn+I6TXy+ZdR5Uu9mrYmP6BiB2DKSDRRiKKlHAj
         ZQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PuxVktP8ly6XYuWVV4eBaobSoUkGl5I6o/QFWMFqZ4U=;
        b=l1UAO1286+IIHvF+mtfS56Srow23gl+G7cHuIKXV7udz2qi4DoboINJK7eX3c+FZML
         ITy9q9Ej2DGVxtBhmQg08ExUgBVoObWNw7Hc3XVyh1KxY38fir1eyNRSix+kflIIHGwp
         93dbenwP2Khkbi9iu0Jkd+AwEb5940BhkNkn8/EPi5gzADahl4OH4X/8A6MPgIoL5dpH
         KrW2ug1gYHm0IsvozX0Mbq/sAxS1UOeivwwWGuK9hgwUZKkDDGXUZXkVyRdcIafi7BR/
         jegXYXHsAk02U28c2aBeu89LX6QFtXhvXYw6rAxZaMdYiRNITidhQqcent2gyPUTu0Qh
         tvbw==
X-Gm-Message-State: AO0yUKXI4FHbnNHPKL5h58hbJupEsTpWGbDy1GIo9+PL0blxd1CqER0V
        +jplYEUBvefI9iJcxcNxBKhdx/R00w==
X-Google-Smtp-Source: AK7set8050Smi8oXXAQzH/O20B7tO2/f1YvHXizbD1pzfvqNoXw1qRvF1SP7ncxm4J/UP4XN73iyOA==
X-Received: by 2002:ac8:5d8f:0:b0:3bf:d87d:4948 with SMTP id d15-20020ac85d8f000000b003bfd87d4948mr3711209qtx.14.1677452347322;
        Sun, 26 Feb 2023 14:59:07 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id x15-20020a05620a098f00b0073b929d0371sm3808644qkx.4.2023.02.26.14.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 14:59:06 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:35b5:7210:c525:93a0])
        by serve.minyard.net (Postfix) with ESMTPSA id B469A1800BD;
        Sun, 26 Feb 2023 22:59:05 +0000 (UTC)
Date:   Sun, 26 Feb 2023 16:59:04 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        openipmi-developer@lists.sourceforge.net,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/8] ipmi: ASPEED_BT_IPMI_BMC: select REGMAP_MMIO instead
 of depending on it
Message-ID: <Y/vkOCLCeubl6B34@minyard.net>
Reply-To: minyard@acm.org
References: <20230226053953.4681-1-rdunlap@infradead.org>
 <20230226053953.4681-2-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226053953.4681-2-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 09:39:46PM -0800, Randy Dunlap wrote:
> REGMAP is a hidden (not user visible) symbol. Users cannot set it
> directly thru "make *config", so drivers should select it instead of
> depending on it if they need it.
> 
> Consistently using "select" or "depends on" can also help reduce
> Kconfig circular dependency issues.
> 
> Therefore, change the use of "depends on REGMAP_MMIO" to
> "select REGMAP_MMIO", which will also set REGMAP.

This seems reasonable.  I can take it into my tree, or..

Acked-by: Corey Minyard <cminyard@mvista.com>

> 
> Fixes: eb994594bc22 ("ipmi: bt-bmc: Use a regmap for register access")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Corey Minyard <minyard@acm.org>
> Cc: openipmi-developer@lists.sourceforge.net
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/char/ipmi/Kconfig |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff -- a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
> --- a/drivers/char/ipmi/Kconfig
> +++ b/drivers/char/ipmi/Kconfig
> @@ -162,7 +162,8 @@ config IPMI_KCS_BMC_SERIO
>  
>  config ASPEED_BT_IPMI_BMC
>  	depends on ARCH_ASPEED || COMPILE_TEST
> -	depends on REGMAP && REGMAP_MMIO && MFD_SYSCON
> +	depends on MFD_SYSCON
> +	select REGMAP_MMIO
>  	tristate "BT IPMI bmc driver"
>  	help
>  	  Provides a driver for the BT (Block Transfer) IPMI interface
