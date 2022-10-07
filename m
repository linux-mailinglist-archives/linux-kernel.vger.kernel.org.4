Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322865F7B68
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiJGQ1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiJGQ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:27:21 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65BF12BB9F;
        Fri,  7 Oct 2022 09:27:20 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id i9so3416879qvo.0;
        Fri, 07 Oct 2022 09:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rv1RyPQRKBD5gQsueT4Um5of6W7PIDtW7ZzPJrLZ/0U=;
        b=mhvdu9R4OSJAmuL4ryfTsbUj85Rlj5e7y3DtKuO+tdM4dFzozUN6Sa50bx8HJSV3vt
         4XJEs1mgfJqd9zTnWMxuGilYCBTumHSOCItHRrcqnxieOaPI0Ksf3kAPUpIS0rB/q67U
         ZzjqGElgMXqWH5ZgTkN81Gw8Xfh5jurPavkc9WJyF8TUGUE9YY8GTp4xomxKnyXNWYTE
         hZr6Lto3un5qD3zB8fnK+c9Busa6K6qbcUTnh8WE8HNrGxVj+5ibbf0Tm3D4Yn/8/dsS
         M2XOqmnaYyp2QOqjzmtZkYo6puj0QhblsEtT0h2hWbtqaEqzZqd03rfU9pnl6k7Ueo3R
         45SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rv1RyPQRKBD5gQsueT4Um5of6W7PIDtW7ZzPJrLZ/0U=;
        b=aek3VfyV75vgqmvDo8w8NMX2KsyuOwtmYC9cHdvybblvzC86LzW+FLc9D7C/X0bDIv
         ELgmgizvme67vCwVgVKapCqvKskO0l40Nm7RVcyp97JaYpeiForfzR+vg7UlgomZfOMC
         k+Lt8tYcrxY/xdSH6/KBzy9+QYrypy/CzzFcC+PzeVU8ig+ERrVsmFbpR9y03QJr8s/Q
         JPivH2DpM5XpiwlkHmFHlzIYPBCgi/V1rjQIbiguCtdGo6TG9FM2evxkcCJHp4Sy2qqN
         jedn1HgrYaRIcJl/005yD73LXx5KWQ6X6FNiFUVT3dYVL2WuzoBmG/yR3zuKVY7m8fg8
         UxCQ==
X-Gm-Message-State: ACrzQf0JbScLMmU1a9M9ZHaLOOlq40zfIM80l6FQ22/EWOCtyorUqDCZ
        ympbtixu3hDy3jH19QihxSJiTlkI/mnW6cGCR0o=
X-Google-Smtp-Source: AMsMyM7kGPffcldw0lkzc4fVpS1Uvw1UqFYRJ2j7bvsr/2xuqOW6EKpraeCo01vxjqu4AjStmZG1ELYXMfcm7kMoqdw=
X-Received: by 2002:a05:6214:19cf:b0:4a9:4241:2399 with SMTP id
 j15-20020a05621419cf00b004a942412399mr4896091qvc.64.1665160039173; Fri, 07
 Oct 2022 09:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221007145641.3307075-1-jjhiblot@traphandler.com> <20221007145641.3307075-5-jjhiblot@traphandler.com>
In-Reply-To: <20221007145641.3307075-5-jjhiblot@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 7 Oct 2022 19:26:43 +0300
Message-ID: <CAHp75Vc=4zyRUpeZ_-P4VZpSyX5tRbw6Bj6iKR0FHgOM=vic9g@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] leds: class: store the color index in struct led_classdev
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     lee.jones@linaro.org, pavel@ucw.cz, robh+dt@kernel.org,
        sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        marijn.suijten@somainline.org, bjorn.andersson@linaro.org,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Oct 7, 2022 at 6:03 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> This information might be useful for more than only deriving the led's
> name.
> And since we have this information, we can expose it in the sysfs.

Not sure why you haven't continued a new sentence on the previous line.

...

> +static ssize_t color_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       const char *color_text = "invalid";
> +       struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +
> +       if (led_cdev->color < LED_COLOR_ID_MAX)
> +               color_text = led_colors[led_cdev->color];

> +       return sprintf(buf, "%s\n", color_text);

According to the Documentation you must use sysfs_emit() here. It
might be good to update existing code as well (as a separate change).

> +}
> +static DEVICE_ATTR_RO(color);


-- 
With Best Regards,
Andy Shevchenko
