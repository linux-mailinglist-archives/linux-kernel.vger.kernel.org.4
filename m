Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A4C62893A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbiKNTWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbiKNTWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:22:08 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A364127CCE;
        Mon, 14 Nov 2022 11:22:07 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so14764987pji.1;
        Mon, 14 Nov 2022 11:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=53BI+CPgUrrzTQEc/6H5DDbmcd2GnS4RSmYFxg2h73o=;
        b=bAcRs7viz+6dG+r2Qu2aT/3RiAh1ih9NOmQow9TLGfBYw2XU5my/PiKQztmx5tIQWX
         G1uqdX+tzNcKZFjFTWfKRWGw3B/8fhE77fVGDuetJ/h9tmyMbyHTEQ16GuMPo5yZq5n7
         gZSQQBvHOYcqhjwBqB5ILERA/wG5GD7Q5KrlvUzQy7EuZWFsI/MRo4SY0qVy55ibQevX
         CQaCoPac/qiVzLzoNLf/Wxte0WHfLDtay18MCC3ZlpUWoTfSBC4UP1I2TD15a+qu1Vd1
         GLwpAIbVhGsX/RxoGS5Mb64jBPcMxgcmqrQLD0MtAMulTa+ZxzOhb4pqDVvW23BOmknw
         xSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53BI+CPgUrrzTQEc/6H5DDbmcd2GnS4RSmYFxg2h73o=;
        b=Cyl6WtHbIMSngaAbPeGLEUuxHY0YcTgJTCP2aWK+45uXZDuugZ0zMixXM+ZeOVsDjr
         H6Kq8xfCZq6l/t+shWE5RVWWhBH6G4aoBgxgnJeyiZDrwPoA9Mj5OVpwM+S5Cv8o5+G7
         eQ68k3jVQR2XF+dDXpCkXE1ylowUqqtJkcUrkTTdORZgKNM/+E1TNlnpWr8W1blxt0XV
         3ej2mA4/nhIM5yxtPXINCmZQCkcnEAOyV45xpSO1XrvD6eamxCA9iC6qtrxPlqIfOr7p
         RsIDW230PuLPlb/QHVqjXaEfe2jkXy6/qD/jo7cUYVjWCbEHr3zKY/WHE3f5mC2a2o/y
         8s6w==
X-Gm-Message-State: ANoB5pkPjoBIZkmFSfe0W1nzrR63GUM9+QE0tuUe+p+EhcW9fa3tMYqa
        OH1r7FqLCJSeciMy309TBKA2q+ZkhyU=
X-Google-Smtp-Source: AA0mqf4LeWk4H0EeCXGHY/cn7Tf3Q83UN2Pdgjs0z8sPYbOXY+bzXBjpubvi7XRZFIaayb1CH1XtGg==
X-Received: by 2002:a17:902:b609:b0:17f:6758:6904 with SMTP id b9-20020a170902b60900b0017f67586904mr672927pls.61.1668453727035;
        Mon, 14 Nov 2022 11:22:07 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:718:95ee:2678:497])
        by smtp.gmail.com with ESMTPSA id s19-20020a17090a441300b0020af2bab83fsm6904059pjg.23.2022.11.14.11.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:22:06 -0800 (PST)
Date:   Mon, 14 Nov 2022 11:22:03 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/2] gpiolib: of: Prepare of_mm_gpiochip_add_data()
 for fwnode
Message-ID: <Y3KVW7OLedkdsVhC@google.com>
References: <20221114184626.64214-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114184626.64214-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 08:46:25PM +0200, Andy Shevchenko wrote:
> GPIO library is getting rid of of_node, fwnode should be utilized instead.
> Prepare of_mm_gpiochip_add_data() for fwnode.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

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
>  	if (mm_gc->save_regs)
>  		mm_gc->save_regs(mm_gc);
>  
> -	of_node_put(mm_gc->gc.of_node);
> -	mm_gc->gc.of_node = of_node_get(np);
> +	fwnode_handle_put(mm_gc->gc.fwnode);
> +	mm_gc->gc.fwnode = fwnode_handle_get(of_fwnode_handle(np));
>  
>  	ret = gpiochip_add_data(gc, data);
>  	if (ret)
> 
> base-commit: 8dab99c9eab3162bfb4326c35579a3388dbf68f2
> -- 
> 2.35.1
> 

Thanks.

-- 
Dmitry
