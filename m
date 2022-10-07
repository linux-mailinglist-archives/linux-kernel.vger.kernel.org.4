Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEC55F7B81
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJGQcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJGQcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:32:35 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED3F102DE8;
        Fri,  7 Oct 2022 09:32:33 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id de14so3394968qvb.5;
        Fri, 07 Oct 2022 09:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QqBD3ksm/42W3ZOFARVPpcH3gaO+fK+GYGFaj+UPlDI=;
        b=h8LZ7ri8UcgOJHgobw3oPpAa4rlYp4LWGdqt/eYl4Pl7EFSv+cgBTP0Slsz8mnuF/e
         3ffTnLA5Y56rRQRO1p/ymA0XPK/bNeRVkAVRid2y8BjWpAKkvszaYFZtwM5iax1NUsFl
         /SQK7RsL99oGAxMYld4xhQ4Kp7Cyh9EuTbyXxTlj0B9yGbLUjPBL6cjD2GL0niL8I9aO
         aEkIhXe6kWWGjWv75xvsUQ5+Ekl3auCZY0xgGSnxcfNXcszUeIOQJbnLF0Sx7HEdrp9B
         uKJMXx/6YBOOdNKQ8/s8E129r8NFt5h3grqUZqXNuhd4PbyrWLY61Ymbk/+jA+IYbHpK
         tKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqBD3ksm/42W3ZOFARVPpcH3gaO+fK+GYGFaj+UPlDI=;
        b=jlFWafOXZEIQekRd0RznVI2NR5STTYCl0oj+E9Wo6LwzkxL91ldAzyVXHOw9DUECzs
         UcbLZaDMgRMvSM1Bxn/V51KM3GBs88fibbo8tmezJu65XrEd0cLTeUzUG9mC10s8/4wG
         A7J/yKiVGeGtWRESDS9OpwcObtcI1KeAwMrzWNSb/gv3A2Mtkt1EArpngt7kqWmSV0+B
         80lJpPLmWMg/G+duLKrpZbD6HwnjAhtXvwHrklrqYGBdhFqwEGIZD4DBqg44/mhYN20r
         aeSIX8qacui8NhXtmUTuldxzemFrzCX34UQY7L9I28HNYf13FH8OATPh06XnWKioiTSw
         e1Dg==
X-Gm-Message-State: ACrzQf1SnMszRDwdxZaG4EDdsj6srrnNuq9ejn7MNM9UPmAZnLLo/4L3
        2AfGNdf9e2+zqYOaE0nKQjfPElJ3GCi195lUmSU=
X-Google-Smtp-Source: AMsMyM4FrN/lLzBMdXd6EEVNCo60otuO1WIl9EytSx8UsuYUcHVCyRwaUVrQdaNHZjtkwlB62cmyl4Otb7WMHqX0xzg=
X-Received: by 2002:a05:6214:762:b0:4b1:c5d2:3fd0 with SMTP id
 f2-20020a056214076200b004b1c5d23fd0mr4873243qvz.97.1665160352745; Fri, 07 Oct
 2022 09:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221007145641.3307075-1-jjhiblot@traphandler.com> <20221007145641.3307075-7-jjhiblot@traphandler.com>
In-Reply-To: <20221007145641.3307075-7-jjhiblot@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 7 Oct 2022 19:31:56 +0300
Message-ID: <CAHp75VcwcOqz_8yCYL09Nh7vqw5ZWOUR+1EJjpiNEz_tis-s+A@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] leds: Add a multicolor LED driver to group
 monochromatic LEDs
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

On Fri, Oct 7, 2022 at 5:56 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> By allowing to group multiple monochrome LED into multicolor LEDs,
> all involved LEDs can be controlled in-sync. This enables using effects
> using triggers, etc.

...

> +config LEDS_GRP_MULTICOLOR
> +       tristate "Multi-color LED grouping support"

> +       depends on OF

But there is no compilation requirement for that.
If you want to tell that this is functional requirement, you may use

    depends on COMPILE_TEST || OF

pattern

...

> +       struct device *dev = &pdev->dev;
> +       struct led_init_data init_data = {};
> +       struct led_classdev *cdev;
> +       struct mc_subled *subled;
> +       struct led_mcg_priv *priv;

> +       int i, count, ret;

> +       unsigned int max_brightness;

Perhaps keep it before previous line?

> +       count = 0;
> +       max_brightness = 0;
> +       for (;;) {
> +               struct led_classdev *led_cdev;
> +
> +               led_cdev = devm_of_led_get_optional(dev, count);

> +               if (!led_cdev)

> +                       /* Reached the end of the list */
> +                       break;

This will require {} according to the style guide. Maybe move the
comment on top of the if (!led_cdev) check?

> +               if (IS_ERR(led_cdev))
> +                       return dev_err_probe(dev, PTR_ERR(led_cdev),
> +                                            "Unable to get led #%d", count);

I would check for an error first, this is a common pattern in the Linux kernel.

> +               count++;
> +
> +               priv->monochromatics = devm_krealloc_array(dev, priv->monochromatics,
> +                                       count, sizeof(*priv->monochromatics),
> +                                       GFP_KERNEL);
> +               if (!priv->monochromatics)
> +                       return -ENOMEM;
> +
> +               priv->monochromatics[count - 1] = led_cdev;
> +
> +               max_brightness = max(max_brightness, led_cdev->max_brightness);
> +       }
> +
> +       subled = devm_kcalloc(dev, count, sizeof(*subled), GFP_KERNEL);
> +       if (!subled)
> +               return -ENOMEM;
> +       priv->mc_cdev.subled_info = subled;
> +
> +       for (i = 0; i < count; i++) {
> +               struct led_classdev *led_cdev = priv->monochromatics[i];
> +
> +               subled[i].color_index = led_cdev->color;
> +               /* configure the LED intensity to its maximum */
> +               subled[i].intensity = max_brightness;
> +       }
> +
> +       /* init the multicolor's LED class device */
> +       cdev = &priv->mc_cdev.led_cdev;
> +       cdev->flags = LED_CORE_SUSPENDRESUME;
> +       cdev->brightness_set_blocking = led_mcg_set;
> +       cdev->max_brightness = max_brightness;
> +       cdev->color = LED_COLOR_ID_MULTI;
> +       priv->mc_cdev.num_colors = count;
> +
> +       init_data.fwnode = dev_fwnode(dev);
> +       ret = devm_led_classdev_multicolor_register_ext(dev, &priv->mc_cdev,
> +                                                       &init_data);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                       "failed to register multicolor led for %s.\n",
> +                       cdev->name);
> +
> +       ret = led_mcg_set(cdev, cdev->brightness);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "failed to set led value for %s.",
> +                                    cdev->name);
> +
> +       for (i = 0; i < count; i++) {
> +               struct led_classdev *led_cdev = priv->monochromatics[i];
> +
> +               /* Make the sysfs of the monochromatic LED read-only */
> +               led_cdev->flags |= LED_SYSFS_DISABLE;
> +       }
> +
> +       return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko
