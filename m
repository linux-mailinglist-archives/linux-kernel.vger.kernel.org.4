Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7815636594
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbiKWQU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237693AbiKWQUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:20:23 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B3B8B861
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:20:18 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-14286d5ebc3so18042152fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYbQqRG19ssSJjAnC8LyFdc+iA79g7OKJroOWVugZCY=;
        b=Nm9vji+QEpKSyI0RcIo69Sh8Af4qlzhD0uy5CS8zw9gYWVTnpRUfXoNMwZynYXcvvx
         wTlk+gZBIim5Bfv8x1Hev7f4c3lm8Cz5Pjfk+dNcPyZS5ds4OcLFmN4tL90g8blGffS2
         9SxxUO+jP1sBicA+4rZC2bM9/PHYLX9NaiVB3sj4tQU6a97tQVesir3Osjq/sBeCjDE5
         uSTpcgv08YU8kR2KU7mWp7gCmUNOlSlWT8MO5jwG8UPkReFdxsxseix9OnBK56am3T4n
         /AwOyojxTzRN1daeMKADD7vqu9ZTQ4Z7fn2AS9by8A66dsvtrt0RnnqfG1q82pTWr/8v
         IP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYbQqRG19ssSJjAnC8LyFdc+iA79g7OKJroOWVugZCY=;
        b=hSbEWvGY9eatXScoSrK9t8QJNnG+RYp6qVcwo6aQbtQUswnr2DS7JTPaD6rgxWzUNF
         ZnMA6jgajoTZXoDXjLR9NfLqZNyzPER+Fv9M4xZJmHJZ/IHR0hzF4ZEGxwtrE6YGE5Sg
         J3iXYRSPPJw/hJYYBxbyXXuEVVD+YFK7aC0B7JsXw/2dw1kzMwIm8xFV7e+B+fcXt5fd
         44XxPPRVZ6iTYVcWM+DR4lMASRriDL0HzzZr43FwY7QViPa7LzGhu+jEIMOkCQTHdzpe
         Pz9KqWUNUSf5peOfYNx1dmac4dGcDflBkOpfa6uSukIwGnQSk4VHKkDb7BQtYZvhkX7f
         i5vA==
X-Gm-Message-State: ANoB5pls2FrurXILClUWLuF5K1N4pkwHQaYsgm6gj5ztGu8S0VkXISam
        HIte/WyYEnF7drjbiUNAMnlM0dE7868=
X-Google-Smtp-Source: AA0mqf6iRO9U9e/s4mp4giVnHFneYyqGqa6KnGJlVr15d50kHLBDMqNrqfyVleHpToUZUBNThB9wTA==
X-Received: by 2002:a05:6870:d611:b0:13c:3fbb:5954 with SMTP id a17-20020a056870d61100b0013c3fbb5954mr6837394oaq.0.1669220418150;
        Wed, 23 Nov 2022 08:20:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c126-20020aca3584000000b00354948e04e4sm6723117oia.2.2022.11.23.08.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 08:20:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 23 Nov 2022 08:20:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        yangyingliang@huawei.com
Subject: Re: [PATCH] watchdog: sp5100_tco: Fix PCI device refcount leak
Message-ID: <20221123162016.GB2374110@roeck-us.net>
References: <20221122115651.33877-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122115651.33877-1-wangxiongfeng2@huawei.com>
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

On Tue, Nov 22, 2022 at 07:56:51PM +0800, Xiongfeng Wang wrote:
> for_each_pci_dev() is implemented by pci_get_device(). The comment of
> pci_get_device() says that it will increase the reference count for the
> returned pci_dev and also decrease the reference count for the input
> pci_dev @from if it is not NULL.
> 
> If we break out for_each_pci_dev() loop with pdev not NULL, we need to
> call pci_dev_put() to decrease the reference count. Add the missing
> pci_dev_put() in error path of sp5100_tco_init() and also when we unload
> module.
> 
> Fixes: 15e28bf13008 ("watchdog: Add support for sp5100 chipset TCO")
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sp5100_tco.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> index fb426b7d81da..f00f26f90444 100644
> --- a/drivers/watchdog/sp5100_tco.c
> +++ b/drivers/watchdog/sp5100_tco.c
> @@ -599,7 +599,7 @@ static int __init sp5100_tco_init(void)
>  
>  	err = platform_driver_register(&sp5100_tco_driver);
>  	if (err)
> -		return err;
> +		goto put_dev;
>  
>  	sp5100_tco_platform_device =
>  		platform_device_register_simple(TCO_DRIVER_NAME, -1, NULL, 0);
> @@ -612,6 +612,8 @@ static int __init sp5100_tco_init(void)
>  
>  unreg_platform_driver:
>  	platform_driver_unregister(&sp5100_tco_driver);
> +put_dev:
> +	pci_dev_put(sp5100_tco_pci);
>  	return err;
>  }
>  
> @@ -619,6 +621,7 @@ static void __exit sp5100_tco_exit(void)
>  {
>  	platform_device_unregister(sp5100_tco_platform_device);
>  	platform_driver_unregister(&sp5100_tco_driver);
> +	pci_dev_put(sp5100_tco_pci);
>  }
>  
>  module_init(sp5100_tco_init);
> -- 
> 2.20.1
> 
