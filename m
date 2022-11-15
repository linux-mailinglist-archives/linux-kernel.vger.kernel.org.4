Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5796296AD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbiKOLCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238275AbiKOLBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:01:49 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9FA62D9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:01:16 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id i2so9854874vsc.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3GpXLJE7XWPa3z0Eh6vApuFsIkuRF+XGpozyyNRWwzY=;
        b=26o34GWBfUIiqpuLc/xTHrlYYldMNCaqik4cgtWfM7Gn9nvxTy7nf7WSCqLXPbhH3c
         oF7vVTq2x2OxdquLz+dwE+OxpNSLhBvFSreNZ4c59Cg+UES/iYXiN4iHuxxxQ0GgNyPB
         MHIuKPkdmT+HUBOEhK6NVxUujCIau14h7oVzD1hEu1GrzSo/DOKj+YwrRvJAZJhvdn/P
         fdC4BEgbm3KTNCMpBoh00jutsosKgXjr2LlRnU+MqSzBlSrNBoZRP1slVI4k3db9EOZl
         +/d4CFUdbmL+Dujhn7dgvHAKVOFt1gPNljO5Lu9FetTR2pmahdJUDCIZKWOIHl6YfP+/
         PQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GpXLJE7XWPa3z0Eh6vApuFsIkuRF+XGpozyyNRWwzY=;
        b=3aasLivayyKumAvslLTiyDGt+rKG+XWsAvamSB2xe7KJuyc9u2vPq+1iELl5jC2Cnf
         2lWKpfWmnc5cdWGL8KpbolZYGR+3BadXbNIP3jxvyfEMQur0hhpUqjk7PR6dN9tvGOn0
         +q7SgY7YOZioc/q/xcwaqP2LhhMysCiyD2FQ8Koo306bJIVNu6aEQhnL+wCaLeJ6E9cV
         LKBvVKuie892s17jHFpEaprWlJF0U+ZbNOtLpOkucF7Jtc5o1eAigIOYW29OrOfN52/+
         5BLS8q/KkdBrkePPK0jkBXvRaH4udX0OSoCxY5+5vtenCGdDdNCABirxWdIVMW72nxvo
         I7oQ==
X-Gm-Message-State: ANoB5plp1vxpISou4oBktdnQxFkiPtFxQRd5zvCk6OejeGgk45ygFF5e
        /X6Z8zcN1A7QKRYNZQMjkM+/xuzACFvx0DoXPjLgog==
X-Google-Smtp-Source: AA0mqf7qS1tG58i68RSXsH5Aa4l2015jfFgmckfP6lPX/XfrOTq9W9ZSf0ojB/0bdTl/c3kV8s2VQ1eghwog2FZPWis=
X-Received: by 2002:a67:fb81:0:b0:3a9:afe1:eef6 with SMTP id
 n1-20020a67fb81000000b003a9afe1eef6mr8358643vsr.61.1668510075698; Tue, 15 Nov
 2022 03:01:15 -0800 (PST)
MIME-Version: 1.0
References: <20221114184626.64214-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221114184626.64214-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 15 Nov 2022 12:01:04 +0100
Message-ID: <CAMRc=McXcKxnqYonaxLYK5cvMDaZDHYdiCXkJiBq+nZRJ0vF2A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpiolib: of: Prepare of_mm_gpiochip_add_data() for fwnode
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 7:46 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> GPIO library is getting rid of of_node, fwnode should be utilized instead.
> Prepare of_mm_gpiochip_add_data() for fwnode.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> v2: added tag (Linus), modified according to Dmitry's suggestion
>  drivers/gpio/gpiolib-of.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 4be3c21aa718..d30a5210dfdd 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -935,8 +935,8 @@ int of_mm_gpiochip_add_data(struct device_node *np,
>         if (mm_gc->save_regs)
>                 mm_gc->save_regs(mm_gc);
>
> -       of_node_put(mm_gc->gc.of_node);
> -       mm_gc->gc.of_node = of_node_get(np);
> +       fwnode_handle_put(mm_gc->gc.fwnode);
> +       mm_gc->gc.fwnode = fwnode_handle_get(of_fwnode_handle(np));
>
>         ret = gpiochip_add_data(gc, data);
>         if (ret)
>
> base-commit: 8dab99c9eab3162bfb4326c35579a3388dbf68f2
> --
> 2.35.1
>

Both applied, thanks!

Bart
