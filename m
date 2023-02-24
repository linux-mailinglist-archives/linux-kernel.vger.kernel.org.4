Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F446A2344
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjBXUtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBXUtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:49:15 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60985168BD;
        Fri, 24 Feb 2023 12:49:14 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id ay37so132829qkb.1;
        Fri, 24 Feb 2023 12:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kvN0hLuCEsR9Vd2UCL7IKP8VbOyMpbeDrq81GUHoJwA=;
        b=GqfB/gdry0rQFbWqA4I7frasJkabRvYO51A7qKOKC8hNrXPS6ocH5LW2aAHrSfAiLk
         Zmlw3I5xkA8lrfLiclkrS8OuLZyn+e9rxwvbaECQtA8QprIa/YJ6SWo9+ovfwNrSAYJ7
         wgiomVnsB3cS2Ox/1idwQTVLb9jBfaaC+UavUE0tSM+f5PUit3GzS4l7RgzyI0uYi5B1
         1RobFo2Cm1skShJxBsbbVBG2RjIPLL7sOswtJLFnkINh34MOCD8QxFbn0Tg5NE2TOmYz
         pzaQRcWb8JNvEu3TTEgsN67qvc4XdgRpTbF1tLrdT5BTdvqsWk2y+kdkPtihzZgggLt4
         TH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvN0hLuCEsR9Vd2UCL7IKP8VbOyMpbeDrq81GUHoJwA=;
        b=Nvu0jNXGY2wn/EsbdkEPgIytmvS5Rl2lBdl5PCDF/eNOUrBRRDd1zhAW6iTvzh/1b5
         QDBHXwk1S/WAmjQwt59/xU5Zbm9YnzFrgqCAuRgcjcGEUEyFrI6Jnt04lTxrfKVOTYpz
         XCCW41C9o7+h9A0vBp+8qFL9h+33/UNa0gzKn5Zcbq0ETKV6qf9AVolACxWCw2rT+5q/
         gimo4/dbbTlYs1OLuP1IEotQ26IjB7Cu2QZvYkLZHfK6YvQu/jhKBRp/jwtvHQHsVtrL
         G5hLpofDViMAIsgPZ6N4YIDYLja6SQH9Mm1nXNe+EOohdet2NumlQZNDxuZ0U2lpU4QC
         K+TA==
X-Gm-Message-State: AO0yUKXzM2Vw0K12LbMe44cjZiaCU2SuB8bKya+WuZ6rxQraoesxj8ZD
        JO47bgI5LqvnVlmIWNZLDVa9cf/VBCQA67Thcj0=
X-Google-Smtp-Source: AK7set+EeVvLHVy65mCkYp8oeMahekDSmvMS7T9rS7mRcJjSFOJ4zCxukkHG2BOF15E88wWliM70YXZoykBz+QU4ySs=
X-Received: by 2002:a05:620a:13cd:b0:742:7e5a:4cee with SMTP id
 g13-20020a05620a13cd00b007427e5a4ceemr510882qkl.10.1677271753490; Fri, 24 Feb
 2023 12:49:13 -0800 (PST)
MIME-Version: 1.0
References: <20230224192021.22591-1-asmaa@nvidia.com>
In-Reply-To: <20230224192021.22591-1-asmaa@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 Feb 2023 22:48:37 +0200
Message-ID: <CAHp75Vdz=P=HrjyhT=dQFJt0LmqzBG2Cmw=sCBmU-RCwkQ3uUw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: mmio: handle "ngpios" properly in bgpio_init()
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
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

On Fri, Feb 24, 2023 at 9:20 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:
>
> bgpio_init() uses "sz" argument to populate ngpio, which is not
> accurate. Instead, read the "ngpios" property from the DT and if it
> doesn't exist, use the "sz" argument. With this change, drivers no
> longer need to overwrite the ngpio variable after calling bgpio_init.

...

> +       ret = device_property_present(dev, "ngpios");
> +       if (!ret)

ret is not of the correct type for this call.

Why not simply

    if (!device_property_present(dev, "ngpios"))

> +               gc->ngpio = gc->bgpio_bits;

...

The problem with this change is that you need to provide bgpio_bits.

So, if there is a property when bgpio_bits will be updated?

That's said what you need is something like this:
1) split "ngpios" handling code (lines ~718-744 in gpiolib.c)  into a
helper function that is available inside drivers/gpio;
2) use it in bgpio_init() by overriding bgpio_bits.

ret = new_helper();
if (ret)
    gc->bgpio_bits = sz * 8;
else
    ... = gc->ngpio;


-- 
With Best Regards,
Andy Shevchenko
