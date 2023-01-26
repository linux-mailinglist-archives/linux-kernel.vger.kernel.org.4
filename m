Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7912867CC0E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbjAZN1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbjAZN1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:27:23 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4C76C54F;
        Thu, 26 Jan 2023 05:26:50 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id bj29so802471qkb.9;
        Thu, 26 Jan 2023 05:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iS5gLAw/H6/fWLmGuUysv3SJVS506G2gVAortGqtf4A=;
        b=LgsH1UP33hyJB7BztyI3/0Su7D8u3LyyIqofTCvByh9kkRYTsKCH+PNlZXyDji8xUp
         wO885SfFOYPld6sXcvHlAf2TfjsWFx90RvMXDajdYwokRu89ciZlxbcizvVwvx7NieFy
         NxE7KPa8H2Tb7QRrt7Erh51ZXGv/Tz4HxG8gKa4b9iRm1MPEJlHJt7ADjsFn8uRcu03L
         oN6Ul5Y4UN6Us3mS3fkTUmI5YQmZErDWhzgKKvMFqbQV72zzOokP5ZwkeP/7eFDrmXLO
         2W4JOMXofKUTilILLEvaJrmFUvUHRrNJKcwmPR3R4r5yZJboqEplSvLJRtYQXzH0+CSg
         MQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iS5gLAw/H6/fWLmGuUysv3SJVS506G2gVAortGqtf4A=;
        b=LL6VJnM0A8KtwVccaaaQHm4XXMmR02Dh3aqmmZPVwBgtItAktqWuVj3Pi4iPxH7D/T
         0AENxOCe3jl+Ez+bAfXMqyolxmRzyJMpaIIu9+ipV38XL+k3rRJ1VviMAN3fR1juTKOI
         bTffN6+pcGCSy+QBWAWMc04addLBFrOZykorEE1VOjCGESgAxIc9pDosMKRK0p3FEyi1
         RNY4PS2xrklE852MWiLixNVAp0OfUjRaG7x31+gCN5S76w6fNB8/ynJGiZVa5qUYh9JJ
         nMhKQjOwYWwoToXxft9CPmBLiUicKB2ZdWy8ThGdB0IL5w85iWaQT96z3hFlzAWYyP+C
         ChVQ==
X-Gm-Message-State: AFqh2koMRL5UQWOIfPNqIQW918iof6aWwsCE0kjem0tV8MeMVCvDuUAu
        +6jUSMsvVTou3Of0cqnSHkJoGE4gixrgVpv+j7Gd39c7sDEyeA==
X-Google-Smtp-Source: AMrXdXs6uUd3T/BHbcdaOVm+BVLBSoZevf9xCbAghuT8tW4+LkTo0Z2SFBAL2oGqENb/B9BRpYnGGSLKYQBCjEkrNX0=
X-Received: by 2002:a05:620a:999:b0:706:72ba:9f22 with SMTP id
 x25-20020a05620a099900b0070672ba9f22mr2484795qkx.401.1674739609372; Thu, 26
 Jan 2023 05:26:49 -0800 (PST)
MIME-Version: 1.0
References: <20230126131033.23011-1-ivoshopov@gmail.com>
In-Reply-To: <20230126131033.23011-1-ivoshopov@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 26 Jan 2023 15:26:13 +0200
Message-ID: <CAHp75VcsdPfYt9O8GFDa1r8EzUy9dTDH09ttb50qBWPNkJuokQ@mail.gmail.com>
Subject: Re: [PATCH] tools: gpio: fix -c option of gpio-event-mon
To:     Ivo Borisov Shopov <ivoshopov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 3:11 PM Ivo Borisov Shopov <ivoshopov@gmail.com> wrote:
>
> Following line should listen for a rising edge and exit after the first
> one since '-c 1' is provided.
>
>     # gpio-event-mon -n gpiochip1 -o 0 -r -c 1
>
> It works with kernel 4.19 but it doesn't work with 5.10. In 5.10 the
> above command doesn't exit after the first rising edge it keep listening
> for an event forever. The '-c 1' is not taken into an account.
> The problem is in commit 62757c32d5db ("tools: gpio: add multi-line
> monitoring to gpio-event-mon").
> Before this commit the iterator 'i' in monitor_device() is used for
> counting of the events (loops). In the case of the above command (-c 1)
> we should start from 0 and increment 'i' only ones and hit the 'break'
> statement and exit the process. But after the above commit counting
> doesn't start from 0, it start from 1 when we listen on one line.
> It is because 'i' is used from one more purpose, counting of lines
> (num_lines) and it isn't restore to 0 after following code
>
>     for (i = 0; i < num_lines; i++)
>         gpiotools_set_bit(&values.mask, i);
>
> This patch just restore the initial value of the iterator to 0 in

s/This patch just restore/Restore/

> order to allow counting of loops to work for any cases.

Very good explanation for the issue, thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

P.S. No need to resend to address above, I think Bart can amend that
when applying.

> Fixes: 62757c32d5db ("tools: gpio: add multi-line monitoring to gpio-event-mon")
> Signed-off-by: Ivo Borisov Shopov <ivoshopov@gmail.com>
> ---
>  tools/gpio/gpio-event-mon.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/gpio/gpio-event-mon.c b/tools/gpio/gpio-event-mon.c
> index 6c122952c589..5dee2b98ab60 100644
> --- a/tools/gpio/gpio-event-mon.c
> +++ b/tools/gpio/gpio-event-mon.c
> @@ -86,6 +86,7 @@ int monitor_device(const char *device_name,
>                         gpiotools_test_bit(values.bits, i));
>         }
>
> +       i = 0;
>         while (1) {
>                 struct gpio_v2_line_event event;
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
