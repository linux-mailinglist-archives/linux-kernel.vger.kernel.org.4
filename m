Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C843761FD52
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiKGSVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiKGSUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:20:45 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6669A21807;
        Mon,  7 Nov 2022 10:20:41 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id j12so11813889plj.5;
        Mon, 07 Nov 2022 10:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+sExAIMPm8JVwLFwxn9Pnq9+FhCqg+vP9t+InwRKjk=;
        b=pvzmlaQSsxRGxYF+GSOVMzNmf2OkKboBvX9lypKkoh7Aom7YLogOemd0nP+dS0CM1l
         cJE5dd4fz0HCkzL0dayrjk7mmoL2zqY+V6TQbduTB0yN/LteCyumTkB3WXog9VDCm9Ul
         J13CptBzNS0QR0s1yyoQ9EHDAGdcpaFOyEVQGtptaIXbSwOKBEJAcW0xm8MrTHWwPQY4
         GWviAEhS+8oU0UUErHyDcTl/I4XlFf0AVG5QCeG+NHSvabsIBU5WUfos4efyOxjePuLq
         BrqqBG2sjbMSAXLavzmyKjvMRE6WKrN+F801BNAYVPx4yDaeT3K4w6b1JK025kvnfQY3
         MPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+sExAIMPm8JVwLFwxn9Pnq9+FhCqg+vP9t+InwRKjk=;
        b=pet0IdGhA9gsDhKZgnIJnD0oQB3DJ8vAo2fzY2HKZswi3F/p1Us1hG5stJ4JgJ3hG4
         hAe+KOEDbCA9lBqUFNDGWOai2niidNSWA+XedMdzOoKBrF+AzyQu92+DXbAeWXHduZwm
         KPlsOYRiOx+4QhUHNNw9TNCAwu/ZOIMBc7y7QJzqj9PSWllSpWAZF6c9GloBMb6xYRNi
         vC52IpUpBebCPyRkX6LzjV3vJPlTJZfzLC4OOEgfMSu94Gi9osVErQoQbVbmYOm5HPOL
         nEstWN0Q8PWU6uTV/3Lp52tyoIWM7Nat6xvc7hBpz1raap5Lp0HlUSZMbSun8sNJgkjT
         2sbg==
X-Gm-Message-State: ACrzQf3p08+cPz9IjotPy9saE7w7ioUM9M1ZwDvBeiWO+dwyd267dlsS
        OFE9pyqpclBPTYPWbBJ7dC0=
X-Google-Smtp-Source: AMsMyM5GDv5ONtCfzW9yrRQvFPu79hbsAam3PpSV/9dUsyMvxCStgNdulK+oqTf2zIlHmfiENy0Vqw==
X-Received: by 2002:a17:90b:4b09:b0:213:655c:158b with SMTP id lx9-20020a17090b4b0900b00213655c158bmr53296180pjb.119.1667845240692;
        Mon, 07 Nov 2022 10:20:40 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:626:eb80:9eb9:1fd7])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902ce8e00b00180033438a0sm5300654plg.106.2022.11.07.10.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:20:40 -0800 (PST)
Date:   Mon, 7 Nov 2022 10:20:37 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 2/2] gpiolib: of: Integrate
 of_gpiochip_init_valid_mask() into gpiochip_init_valid_mask()
Message-ID: <Y2lMdQ/bE2w4skOO@google.com>
References: <20221107161027.43384-1-andriy.shevchenko@linux.intel.com>
 <20221107161027.43384-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107161027.43384-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Nov 07, 2022 at 06:10:27PM +0200, Andy Shevchenko wrote:
> +static unsigned int gpiochip_count_reserved_ranges(struct gpio_chip *gc)
> +{
> +	int size;
> +
> +	size = fwnode_property_count_u32(gc->fwnode, "gpio-reserved-ranges");

I wonder if a comment why we need even size would not be helpful.

> +	if (size > 0 && size % 2 == 0)
> +		return size;
> +
> +	return 0;
> +}
> +
>  static int gpiochip_alloc_valid_mask(struct gpio_chip *gc)
>  {
> -	if (!(of_gpio_need_valid_mask(gc) || gc->init_valid_mask))
> +	if (!(gpiochip_count_reserved_ranges(gc) || gc->init_valid_mask))
>  		return 0;
>  
>  	gc->valid_mask = gpiochip_allocate_mask(gc);
> @@ -457,8 +468,47 @@ static int gpiochip_alloc_valid_mask(struct gpio_chip *gc)
>  	return 0;
>  }
>  
> +static int gpiochip_apply_reserved_ranges(struct gpio_chip *gc, unsigned int sz)
> +{
> +	u32 *ranges;
> +	int ret;
> +
> +	ranges = kmalloc_array(sz, sizeof(*ranges), GFP_KERNEL);
> +	if (!ranges)
> +		return -ENOMEM;
> +
> +	ret = fwnode_property_read_u32_array(gc->fwnode, "gpio-reserved-ranges", ranges, sz);
> +	if (ret) {
> +		kfree(ranges);
> +		return ret;
> +	}
> +
> +	while (sz) {
> +		u32 count = ranges[--sz];
> +		u32 start = ranges[--sz];

I know we checked sz validity, but I wonder if re-checking it in this
function would not insulate us from errors creeping in after some other
code refactoring.

In any case,

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
