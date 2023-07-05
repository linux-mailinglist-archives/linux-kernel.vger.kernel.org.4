Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B7C74829A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjGEK6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjGEK57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:57:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F341709;
        Wed,  5 Jul 2023 03:57:58 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b88e5b3834so15379735ad.3;
        Wed, 05 Jul 2023 03:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688554678; x=1691146678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qPTKXl1aJsHmp8owaaSiyX/oNh3UudkopoKZFeZM6UM=;
        b=bVrHiQCYQpVog/rm4dYppG0XjEg2EjLOua96nws2LuMEalaCPOJAyPH/NgzjP4Xk21
         gZg2izVWQQL2CpV3uYjH1P6N79vKXLnQ3gZxTkw2xGFm3UKeJGA7dkawVPReiQjxlN4h
         glJMl0VF92WrllOf/pMyZpRNw4OcgtEBD4POkNqgSAeUTNLZXtqpt2mQdyakhzxmOIC9
         C5m0gInoyrG5naULtGlgp/+boetGfI3JG0mxO8s92fFoEN/9DeseJMRPYznFPb9wZRQz
         yvLSJxS9kp64pX8EENbHXPIR5VC9J2KoNFH1up+XLf5HD2JKYAZpWUeKTJjR7HeBShnD
         wTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688554678; x=1691146678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPTKXl1aJsHmp8owaaSiyX/oNh3UudkopoKZFeZM6UM=;
        b=JHojaTe3P2Ab5nY6j+JOP0+/CZp5M3rUbU5iUwjs/IUV1iH4WTTfEM06xHMKVJ+Yzt
         GFXD2ewWk1JUKTSL4d42sEyXjkuoi/b36Xrie+wQQ8rILReyh75J4wjhITD0TE5U/KJx
         ecynCiRH75DI7HsW+EfaOEWffODem1boE4HMmg3tLCE2gF/UaMpar+Tua42Ifw9Nn4bX
         4zvRsDubTQTfv9UNMmLQjeVCWqQxh23WIw5n0qng2c3PvmuDWXMYTIvlHLqvBNXniHUT
         finm8Tg6R5qV4KHI2pQlr1pqWbzSPFKX/vwVxw0uAHOrll3SRSgsM9wVa1Bigopt7Et1
         wBZg==
X-Gm-Message-State: ABy/qLY8SzraQhFX9kKTgzcnUyJsdmGHzgaZKnAth2FM7BlskexEmENw
        FTQUCPEvnNYBbC881NE5HDtlpywWBAU=
X-Google-Smtp-Source: APBJJlFU1GygyDvdi/ZLn4Vq996QW/+vQb57QqlHGuAc/y+s8w/3XnSkciywi+VC0ifSL0zDn4xwJg==
X-Received: by 2002:a17:902:c246:b0:1b3:cf98:a20b with SMTP id 6-20020a170902c24600b001b3cf98a20bmr11824056plg.54.1688554677720;
        Wed, 05 Jul 2023 03:57:57 -0700 (PDT)
Received: from sol (194-223-178-180.tpgi.com.au. [194.223.178.180])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709028eca00b001b85bb5fd77sm10455497plo.119.2023.07.05.03.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 03:57:57 -0700 (PDT)
Date:   Wed, 5 Jul 2023 18:57:51 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: add missing include
Message-ID: <ZKVMr9yrL2JavqhF@sol>
References: <20230705074219.8321-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705074219.8321-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 09:42:19AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> gpiolib.h uses notifiers but doesn't include <linux/notifier.h>.
> 

Fair enough.

Reviewed-by: Kent Gibson <warthog618@gmail.com>

Same is true for gpiolib-cdev, btw.
You want to touch that one up as well?

Cheers,
Kent.

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpiolib.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> index cca81375f127..1409d52487c0 100644
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@ -14,6 +14,7 @@
>  #include <linux/err.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/notifier.h>
>  #include <linux/cdev.h>
>  #include <linux/rwsem.h>
>  
> -- 
> 2.39.2
> 
