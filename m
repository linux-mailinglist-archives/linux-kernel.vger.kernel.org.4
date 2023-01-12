Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBE0667F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbjALTsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjALTr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:47:27 -0500
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Jan 2023 11:43:26 PST
Received: from mail.tkos.co.il (golan.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FD6F1F;
        Thu, 12 Jan 2023 11:43:26 -0800 (PST)
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 7AC07440319;
        Thu, 12 Jan 2023 21:27:39 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1673551659;
        bh=vS60k0tj2u3HznO7yKB7DChKrzNTg3akDjVjvbv3vuk=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=TUl8PMGUNUxB8+l+k2S3hmtX10rrsh5tMMfu/21WnMrXVGKnJYmVODXOJ6rQN6aCV
         GknJ0ELuEmIa1HdsS5aG+eTtC21AG6OHPdV2Zf83W0Ltg4z4uJoNjcGeDDraAPihAu
         PjPeAvvq7hDGLLMhxg+iPokOd2S0JQw0u4hnaxxQrlfYTzHPeIIMisrKBcwROEyGmi
         S8mlRrpHeJ0fiUW0dx09hBe7qvdreGg2UuPsqK7l47BoAb0U+oRGkdhpze+Nt4/tnX
         YYuQQZE4faHIlU9nZ13LRcF/XRV3HHyT/Isn4GnXB10INMO9MWIJc8xeJv1dvCIHFe
         7ub0pap/FaHGA==
References: <20230112184823.80349-1-andriy.shevchenko@linux.intel.com>
 <20230112184823.80349-2-andriy.shevchenko@linux.intel.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 2/2] pinctrl: digicolor: Use proper headers and drop
 OF dependency
Date:   Thu, 12 Jan 2023 21:30:46 +0200
In-reply-to: <20230112184823.80349-2-andriy.shevchenko@linux.intel.com>
Message-ID: <87v8lbpn24.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, Jan 12 2023, Andy Shevchenko wrote:

> The driver doesn't depend on the OF to be complied. Hence
> the proper header to use is mod_devicetable.h. Replace of*.h with
> the above mentioned and drop redundant dependency.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Baruch Siach <baruch@tkos.co.il>

baruch

> ---
>  drivers/pinctrl/Kconfig             | 2 +-
>  drivers/pinctrl/pinctrl-digicolor.c | 9 +++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 476f3cbbdce0..1e44708201ad 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -170,7 +170,7 @@ config PINCTRL_DA9062
>  
>  config PINCTRL_DIGICOLOR
>  	bool
> -	depends on OF && (ARCH_DIGICOLOR || COMPILE_TEST)
> +	depends on ARCH_DIGICOLOR || COMPILE_TEST
>  	select PINMUX
>  	select GENERIC_PINCONF
>  
> diff --git a/drivers/pinctrl/pinctrl-digicolor.c b/drivers/pinctrl/pinctrl-digicolor.c
> index 05213261b8a4..a0423172bdd6 100644
> --- a/drivers/pinctrl/pinctrl-digicolor.c
> +++ b/drivers/pinctrl/pinctrl-digicolor.c
> @@ -11,18 +11,19 @@
>   * - Pin pad configuration (pull up/down, strength)
>   */
>  
> +#include <linux/gpio/driver.h>
>  #include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/io.h>
> -#include <linux/gpio/driver.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
>  #include <linux/spinlock.h>
> +
>  #include <linux/pinctrl/machine.h>
>  #include <linux/pinctrl/pinconf.h>
>  #include <linux/pinctrl/pinconf-generic.h>
>  #include <linux/pinctrl/pinctrl.h>
>  #include <linux/pinctrl/pinmux.h>
> +
>  #include "pinctrl-utils.h"
>  
>  #define DRIVER_NAME	"pinctrl-digicolor"


-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
