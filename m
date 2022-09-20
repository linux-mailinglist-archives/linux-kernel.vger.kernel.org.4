Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E895BE8F8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiITO35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiITO3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:29:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5495FDFF9;
        Tue, 20 Sep 2022 07:29:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 29so4148543edv.2;
        Tue, 20 Sep 2022 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=RszqQLsUVQfAFJeEQ7hoI8g4RH+WeWcEr+tv0BYlD1w=;
        b=oUCdR2MByfag2AceIhidd4X0VO+EXvXQSVE80gvHh1j65Ep+rsNtuF/pRRCSVGqQez
         IF/zxdC/28zBNcQgKJJurMTp6qbA2m+bUSxan2c8YD88inPzcHsNFMpjX8TeuFY11loU
         xulHV/KGUDA+oHmzJZ5OL/c8rXfcVmsv9whNbc9fiBtj3VgIqP/9s4Q+mIYVbry4Twwl
         XnQgI5M0NWgaJowIkPCu8zr5g89q6XeUp6MblDYbUJ1aVQdkykK5hAB2dFe0+nntU8Y0
         XvrAj00ngQIr1aZ1YNzLHodbDiIkvy9lChURy4FoBSqCIGgKd62pP2r1S1uLG6Gt8TVi
         WVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RszqQLsUVQfAFJeEQ7hoI8g4RH+WeWcEr+tv0BYlD1w=;
        b=5j6V3jkIQOdZB49s/UYps/8+uh2ys2KPxbhHJAYO+gpNaso3AM3yBwbypDIa8bPKbE
         ALYBkYspRIykWkD0EgekS5w4RgpdPoNATm8GXb7VOTzOaZ/9NjKJT+r4J2UCrz6OU0aO
         qRtMlZLd7WOqf+r15+IzJyT27asrFEzvwZSt+Zzz4bWi/41JfgVdM9VHnxk04N70QM1n
         khnWVzKDD9dIfpc5ODno3KofrLipoPqJToEOxEfPm+qKW2YPTHhoUcVIPcK5Mkjr8Gg+
         BB/dykYPpb8Fy4Sk9deGpPeGPfcclpgq5BGPDaXHs4QTNV6MPC1VuEa/isnBNoEQmavU
         60lw==
X-Gm-Message-State: ACrzQf3bfOiFKPHUrAceWj/1/kdCXBV/Ol0b+sZqxOb8Ug76ZKOtWRng
        Shw/uhqddr8/V9kjOGDrgAs=
X-Google-Smtp-Source: AMsMyM5P7uqGDuNXhYe992hJ7Y9aGbbJF+AsbKLgx2u0/TNRdjaBvJ3twieALQPOshBvixLHCvSx1Q==
X-Received: by 2002:a05:6402:156:b0:440:b458:93df with SMTP id s22-20020a056402015600b00440b45893dfmr21271644edu.337.1663684190299;
        Tue, 20 Sep 2022 07:29:50 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709064e8b00b0073d87068042sm943378eju.110.2022.09.20.07.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:29:49 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: Fix missing array end sentinel in quirks array
Date:   Tue, 20 Sep 2022 16:29:48 +0200
Message-ID: <2041321.FWP5BukD0m@archbook>
In-Reply-To: <20220920142718.633062-1-frattaroli.nicolas@gmail.com>
References: <20220920142718.633062-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 20. September 2022 16:27:18 CEST Nicolas Frattaroli wrote:
> Without the sentinel, the loop never actually terminates if there
> are no quirks, and wreaks havoc across the kernel resulting in a
> juicy panic.
> 
> Fix this by adding a NULL at the end.
> 
> Fixes: a2b5e207cade ("gpiolib: rework quirk handling in of_find_gpio()")
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>  drivers/gpio/gpiolib-of.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 95be5f0d2623..1b60cd04883f 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -498,6 +498,7 @@ static const of_find_gpio_quirk of_find_gpio_quirks[] = {
>  	of_find_regulator_gpio,
>  	of_find_arizona_gpio,
>  	of_find_usb_gpio,
> +	NULL,
>  };
>  
>  struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
> 

Disregard this, just saw it was already fixed[1].

Regards,
Nicolas Frattaroli

[1]: https://lore.kernel.org/linux-gpio/CAMRc=MeF-81yottUqqYdHmuFokysyNsXTgU+FOFWv7bL=QMJOg@mail.gmail.com/T/



