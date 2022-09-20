Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F12B5BE814
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiITOI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiITOI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:08:26 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD7B57274
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:08:25 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lc7so6598129ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4/EOkuG3eGHjcfwrA2aPAw/aBzExdZ1IoqjKPSgH/pA=;
        b=CSVHd/QW8IDv+qUlYftjoDmRPj4vB7KIwvE1uuWmQvbQ/EFMdjdxmCerfevK6YR9vM
         qxgxaQvjo8rucEnZWoheRkGePUV9NVh8s9yshLQkyvXx2HFaEo6v2VREb5igzL+rKf8g
         zu9fvpCyK+BE4up7krJSrCm0p6uJe+YhHXCEBtVZLhBXVgNZqhaM9apQ6OLkoWjj/pV8
         bxL3oJOOR7dDtgBYBH/wPQSV3sn479eRdXBvy9tB3QcI39vw3VPn51NCz8WIcN90rkip
         fRLHBQ0Afzc1ZCObytPl+bA605Vf4FZ0t4w6g3695n/W5aL1cvRoQ7ZPBw4qKMWtqFLN
         73ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4/EOkuG3eGHjcfwrA2aPAw/aBzExdZ1IoqjKPSgH/pA=;
        b=EX911skyRwFcxYaIxaZGfJL6Aa/XE+LjO12BlYNsiGygveVPx4/oU1XzWO12Ij7mpq
         /8fijM5LQNKqbVH179HaPnr1u8SuOoEHn659+Rw+qVCc2UsgUTmHyTjXYI+Sg700egfC
         n8f0KRqrC6esnoJ8wXcX0KuMojy4n+s0AeTXuosYeXSMBRjimEyEBjJ+bs2Mz6d7kwlO
         hOxq/4lT/suljBqStiE/YbkTNpaJKvfKVvXWiAFpsITBkl1RcQKp5Q/uzv4rGpdDgCkF
         Do99wtYWb/Xm6yM5+vN6zIr3YrLs19zvbQltZJ+ghcBq8PwIuHjkJe/RaH7IR3Zofmtd
         VzCg==
X-Gm-Message-State: ACrzQf0XTDxQi4LA9wTN8eF5lOoM6yedcSr/m48nLyoNNOyJsHcu0RK/
        Xqm6noVipDMkZIEwknYJ/PkD1h/FCdYnsME7Va/cHg==
X-Google-Smtp-Source: AMsMyM7hwMSRE0D9zj/cfDeu273mNpuoNldoYT/E2BnpszwdVKcb8TZHjiF6BEemn1zIrDHay0qxzwJUanrQptJV3i4=
X-Received: by 2002:a17:907:3da9:b0:77b:9672:3f7f with SMTP id
 he41-20020a1709073da900b0077b96723f7fmr17048089ejc.636.1663682904293; Tue, 20
 Sep 2022 07:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220920133031.30031-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220920133031.30031-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 20 Sep 2022 16:08:13 +0200
Message-ID: <CAMRc=Mf_c==vuF6w36XptOKxaV2bdf-PY0BXs-WCiwUZ01tBgQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: mockup: Fix potential resource leakage when
 register a chip
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
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

On Tue, Sep 20, 2022 at 3:30 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> If creation of software node fails, the locally allocated string
> array is left unfreed. Free it on error path.
>
> Fixes: 6fda593f3082 ("gpio: mockup: Convert to use software nodes")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-mockup.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> index a2e505a7545c..d6e42159fe44 100644
> --- a/drivers/gpio/gpio-mockup.c
> +++ b/drivers/gpio/gpio-mockup.c
> @@ -533,8 +533,10 @@ static int __init gpio_mockup_register_chip(int idx)
>         }
>
>         fwnode = fwnode_create_software_node(properties, NULL);
> -       if (IS_ERR(fwnode))
> +       if (IS_ERR(fwnode)) {
> +               kfree_strarray(line_names, ngpio);
>                 return PTR_ERR(fwnode);
> +       }
>
>         pdevinfo.name = "gpio-mockup";
>         pdevinfo.id = idx;
> --
> 2.35.1
>

Queued for fixes.

Bart
