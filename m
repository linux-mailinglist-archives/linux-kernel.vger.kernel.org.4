Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244F85E848B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 23:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiIWVEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 17:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiIWVEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 17:04:16 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121EF10F73D;
        Fri, 23 Sep 2022 14:04:16 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id 13so3144940ejn.3;
        Fri, 23 Sep 2022 14:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Zn8iXtJzLQTfvlg1B5Ug66alU1b6v54dZuHDSVAJ4uw=;
        b=abTOyeMgwoVVViLhF9zBe/P1TKCgJptRY4q9nZDgqolSgXjZa+sj6rY2CgxuMuWxI5
         vvCsuPflwFRUloZo4apZ06j+dnsQrItS8mzQQPk+ksgE5DOpPwpClftwj5oPym38Po6e
         aaza4J202EnXPYQi/FEM6VrKuH+ohaRFR1awnPraLdIZOO7XFWYFry/Ht/0Pcs4GSvEY
         O+XpQ0VyqWo+2r8/WPlQM0wPhgapYhE0ZSLfw4gFW0zAhxKv3ry7vWEDVhKKDu8Wlpc3
         xXN2reFUUKCtSGmjjWqG6JsCsQ2nUKGR7bDezoTYwS1WRsQTfGkZJvntsWL2bfgWql8Q
         rhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Zn8iXtJzLQTfvlg1B5Ug66alU1b6v54dZuHDSVAJ4uw=;
        b=a8L6OtegCYwsJo0wnP3Ts1JkwxuyhUcZNSbv4Ha64c6ZOjrQbx6Rtm6uKMu+5cvriF
         UTyvH7hbXhP4mAu+zem8OIg1Ga+VR7IpqY4cS6nhFWjPCLF9C0bXT/YGHXQ+ZyrLOROQ
         XCGTOT73V07q9cnbmG7zUQ0HqRyKeZh+9rALhibEPpeSkM7Lsoq/muUgYU0QlzNH6F+I
         Wor0m/8viWFZZwqkP8feSveb2j0kytGRUDDMDB9QwF7rCZlR0M8X+7K3UzfJPAr+ueK6
         kx8F7InxqouFEuj4LLufwxc7iLWtIyR/MUohY7p+Yx1/jeDvRBl6TfhGs6Y27Xlv+hoH
         c5Og==
X-Gm-Message-State: ACrzQf00lcbP5bzM7QlaKSV8SakBrUrqQMWXu2eTzlS8X2pAhh1PNshF
        NknTlIIrqp85seefxHmmfJe2lTkmYdWrqE83Iy5E60c9pfBLRg==
X-Google-Smtp-Source: AMsMyM6PiF+Y8BuBaQcDsMNwSbvvz8XbL0YwfcucOn9VHklzV9G4GmE7QCaBNCXvP2nzr1ZNxCBRmMbPbO3Yw4x9O4I=
X-Received: by 2002:a17:907:7fa2:b0:781:ca3d:b385 with SMTP id
 qk34-20020a1709077fa200b00781ca3db385mr8926425ejc.641.1663967054564; Fri, 23
 Sep 2022 14:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220923063448.239259-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220923063448.239259-1-ye.xingchen@zte.com.cn>
From:   Han Jingoo <jingoohan1@gmail.com>
Date:   Fri, 23 Sep 2022 14:04:03 -0700
Message-ID: <CAPOBaE5FHNUCND1zOr3H7sBw_H7fK8Pvfi+Y=6SQHmkGSt9wUg@mail.gmail.com>
Subject: Re: [PATCH linux-next] backlight: use sysfs_emit() to instead of scnprintf()
To:     cgel.zte@gmail.com
Cc:     lee@kernel.org, daniel.thompson@linaro.org, deller@gmx.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Replace the open-code with sysfs_emit() to simplify the code.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
>  drivers/video/backlight/lm3533_bl.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
> index 1df1b6643c0b..5e2ce9285245 100644
> --- a/drivers/video/backlight/lm3533_bl.c
> +++ b/drivers/video/backlight/lm3533_bl.c
> @@ -66,7 +66,7 @@ static ssize_t show_id(struct device *dev,
>  {
>         struct lm3533_bl *bl = dev_get_drvdata(dev);
>
> -       return scnprintf(buf, PAGE_SIZE, "%d\n", bl->id);
> +       return sysfs_emit(buf, "%d\n", bl->id);
>  }
>
>  static ssize_t show_als_channel(struct device *dev,
> @@ -75,7 +75,7 @@ static ssize_t show_als_channel(struct device *dev,
>         struct lm3533_bl *bl = dev_get_drvdata(dev);
>         unsigned channel = lm3533_bl_get_ctrlbank_id(bl);
>
> -       return scnprintf(buf, PAGE_SIZE, "%u\n", channel);
> +       return sysfs_emit(buf, "%u\n", channel);
>  }
>
>  static ssize_t show_als_en(struct device *dev,
> @@ -95,7 +95,7 @@ static ssize_t show_als_en(struct device *dev,
>         mask = 1 << (2 * ctrlbank);
>         enable = val & mask;
>
> -       return scnprintf(buf, PAGE_SIZE, "%d\n", enable);
> +       return sysfs_emit(buf, "%d\n", enable);
>  }
>
>  static ssize_t store_als_en(struct device *dev,
> @@ -147,7 +147,7 @@ static ssize_t show_linear(struct device *dev,
>         else
>                 linear = 0;
>
> -       return scnprintf(buf, PAGE_SIZE, "%x\n", linear);
> +       return sysfs_emit(buf, "%x\n", linear);
>  }
>
>  static ssize_t store_linear(struct device *dev,
> @@ -190,7 +190,7 @@ static ssize_t show_pwm(struct device *dev,
>         if (ret)
>                 return ret;
>
> -       return scnprintf(buf, PAGE_SIZE, "%u\n", val);
> +       return sysfs_emit(buf, "%u\n", val);
>  }
>
>  static ssize_t store_pwm(struct device *dev,
> --
> 2.25.1
