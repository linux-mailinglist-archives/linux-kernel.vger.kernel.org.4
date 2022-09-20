Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40195BDD55
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiITGdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiITGcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:32:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1671D5F105
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:31:51 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r18so3661040eja.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=s+frRaEwA/RcGyGjnXK24dJJkfvLXboQ7giFAMb+z7M=;
        b=jvM671HyEZOVyWKMOI30kui1DWMvx+kxpa3CgpGwdhBC7DWCtMs3QpB28xrkvwHJhs
         rcohXPItBIcdFAEeVVZFrOlOowUYDzc/JwBamQAiSY8kAsFG4FEVk/bc4cwWL4oF/fF7
         GDfFACSMbwG0jrATh6IivQ5RZ0daHAF7gaSvVMKRUy1k0fkRC4mhk96ePDFXaf1JUfLJ
         5ePiRdYtH9lXk3DMwvOt2C4DEeQ0avVHlp+SB2zD7eeHlVIc7Npi/Cs9Pu27FlZg/UDu
         HvklTP4M//HPyXeKbPKrJyKhD4Dw462gBxLWuGbZTzN6ouf2nUVLhh/NoDxm2wTXDh9i
         1zBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=s+frRaEwA/RcGyGjnXK24dJJkfvLXboQ7giFAMb+z7M=;
        b=FoFffm9KfFB4oPQQDs4I0jJbZ332lFW5fhPIJBYqCBFpoSDrDHq+a+rWxW3WhT8XbE
         V8NT2kKWim+5dDVuDV6d2liKwloCFheYF5po5+Sls8+cZXixCm9ArNjE0pVLY+v66Hzd
         2C28T/nNCglf+6meHjxMDsBVvdltJ4POjD0dESRfleGa54bfoJWgajpKuMSEoY69ulYs
         CuzewoFY335+tmoHR04V10FsJ0iWxmJjI7m3zkAYw9ddqKXykAI5kotxvtSVVAcjH1b3
         tI3l+5BVCAgsBrYLj5ZFAWxWtRywel5dKG/B1J9ix7g8pBBuDOnmR+qQc0Cd446COhwV
         7REA==
X-Gm-Message-State: ACrzQf1eWpt/E/4PKkM0WyOqHsEYOqQYzWI7OASi8s4qO2ucbiFlCCVg
        KlKx5ZDXVdqMEw56u75LIuhXHyNruLgt+1CSixUO6Q==
X-Google-Smtp-Source: AMsMyM4w6Js+/UlQYzaeExWs1x5yTNUooqiKcZDhmQv03gdezE9pqIm4LpSBl9zt59u3tweBchHlF0L3Zq/8741zz4k=
X-Received: by 2002:a17:907:3da9:b0:77b:9672:3f7f with SMTP id
 he41-20020a1709073da900b0077b96723f7fmr15657862ejc.636.1663655510114; Mon, 19
 Sep 2022 23:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220916110118.446132-1-michael@walle.cc>
In-Reply-To: <20220916110118.446132-1-michael@walle.cc>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 20 Sep 2022 08:31:39 +0200
Message-ID: <CAMRc=MeF-81yottUqqYdHmuFokysyNsXTgU+FOFWv7bL=QMJOg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix OOB access in quirk callbacks
To:     Michael Walle <michael@walle.cc>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 1:01 PM Michael Walle <michael@walle.cc> wrote:
>
> Commit a2b5e207cade ("gpiolib: rework quirk handling in of_find_gpio()")
> introduced an array of quirk functions which get iterated over. But a
> sentinal value is missing. Add it.
>
> Fixes: a2b5e207cade ("gpiolib: rework quirk handling in of_find_gpio()")
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> FWIW here is the kernel oops backtrace:
> [    4.108706] Internal error: SP/PC alignment exception: 8a000000 [#1] SMP
> [    4.115470] Modules linked in:
> [    4.118549] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc5-next-20220916-00091-g6cae0fcbd5e7 #1821
> [    4.128033] Hardware name: Kontron KBox A-230-LS (DT)
> [    4.133127] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    4.140154] pc : 0x61722d6f697067
> [    4.143495] lr : of_find_gpio+0x138/0x174
> [    4.147546] sp : ffff80000a24b680
> [    4.150884] x29: ffff80000a24b680 x28: 0000000000000000 x27: ffff80000996044c
> [    4.158090] x26: 0000000000000001 x25: ffff80000970f588 x24: ffff800009297968
> [    4.165295] x23: ffff80000a24b770 x22: 0000000000000000 x21: ffff0020009a7010
> [    4.172500] x20: ffff8000097752f8 x19: fffffffffffffffe x18: 0000000000000000
> [    4.179703] x17: ffff8000085fb9d0 x16: ffff8000085fb264 x15: ffff8000085f96ac
> [    4.186907] x14: 0000000000000000 x13: ffff80000884b3e8 x12: ffff80000884ab04
> [    4.194111] x11: ffff80000884aa54 x10: 0000000000025080 x9 : ffff8000085fce78
> [    4.201316] x8 : 0101010101010101 x7 : ffff800009750268 x6 : 051f521459491b57
> [    4.208520] x5 : 571b495914521f05 x4 : 6e61722d6f697067 x3 : ffff80000a24b6d4
> [    4.215724] x2 : 0000000000000000 x1 : ffff8000097752f8 x0 : ffff00207f7e4b20
> [    4.222928] Call trace:
> [    4.225389]  0x61722d6f697067
> [    4.228377]  gpiod_get_index+0x12c/0x440
> [    4.232334]  devm_gpiod_get_index+0x34/0xf0
> [    4.236553]  devm_gpiod_get_optional+0x20/0x40
> [    4.241036]  uart_get_rs485_mode+0x104/0x180
> [    4.245345]  serial8250_register_8250_port+0x198/0x484
> [    4.250532]  of_platform_serial_probe+0x358/0x640
> [    4.255279]  platform_probe+0x70/0xe0
> [    4.258973]  really_probe+0xc4/0x2e4
> [    4.262577]  __driver_probe_device+0x80/0xec
> [    4.266882]  driver_probe_device+0x44/0x150
> [    4.271100]  __driver_attach+0x88/0x1a0
> [    4.274967]  bus_for_each_dev+0x78/0xdc
> [    4.278833]  driver_attach+0x2c/0x40
> [    4.282437]  bus_add_driver+0x15c/0x210
> [    4.286303]  driver_register+0x80/0x13c
> [    4.290170]  __platform_driver_register+0x30/0x3c
> [    4.294915]  of_platform_serial_driver_init+0x24/0x30
> [    4.300013]  do_one_initcall+0x4c/0x240
> [    4.303882]  kernel_init_freeable+0x29c/0x30c
> [    4.308276]  kernel_init+0x2c/0x140
> [    4.311793]  ret_from_fork+0x10/0x20
> [    4.315401] Code: bad PC value
>
>  drivers/gpio/gpiolib-of.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 95be5f0d2623..0e4e1291604d 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -498,6 +498,7 @@ static const of_find_gpio_quirk of_find_gpio_quirks[] = {
>         of_find_regulator_gpio,
>         of_find_arizona_gpio,
>         of_find_usb_gpio,
> +       NULL
>  };
>
>  struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
> --
> 2.30.2
>

Applied, thanks!

Bartosz
