Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF45629C78
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbiKOOoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238510AbiKOOn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:43:57 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28BB2EF5A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:42:21 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id t14so14842256vsr.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=84ckuklXks9HDjrkjMUEdy8dxhQSVXrlasgbqbXw1SM=;
        b=hgUxmimdIPmB+4nNGYIJ9EdfOw9q+yFbT/NQFg3dHBOhblRrcqIQqhEEe/Z+nc60z2
         +38wv6QLa5IcwpbYhGSbbiwsA4nVplmuGpZ8mG55oBC5VyZnOlPtpXS/+YIQCyqgU53c
         udt6lVY4pPw3DWWmKOkiSUWUK2DJSNq4DQahxBuv5kYNb6B72sQvbccO2RY7GIROgvZI
         3/UzWGJS6u4LfbTM8gjZYEbUIozPsPm5ucgAPfTovxj1Ru3phDypn15hV/g6w4KatfwU
         MP+nXZQF8qAW8ovZmJ8Tx7Ry/e1DkHJ76bwr8ss8SUOCO6zFUrCmRVqwPbITO68g+dnG
         6lVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84ckuklXks9HDjrkjMUEdy8dxhQSVXrlasgbqbXw1SM=;
        b=1PWry2tyfa5XiekhwNq96Z2AzhBJ868IqbuO0caPMlrCOQQK2R78mUisUrN00odQjQ
         NLREecuSrmE/37lo1G6lTnAngWSmdCtVEZJYPMkThFC92cjSdnscfnofMVzmYhjntl5v
         rNpwO69hYHowN1LgbejU7jtzyLMJ1KRtH5/6Se6CvdpLfxXL/moNgooZXt1LNQX231ki
         vonbGg6TcLsezk1NLHq0yLKAI5XKw6MjNe+SDqiTjZy53S5T+Z5bu5NsFurljz6fy+hF
         HJs6HGuml4PMbTR2uT1pIyO9LPue+e5k88EyDEKGNYMeENBVdh86kydDQUoLlnQi0fzY
         wPxA==
X-Gm-Message-State: ANoB5pmECj75QWyu7QOMyjhwAeWGnyaSHJvI+mBJSZ6V0VbNMjWS7Au+
        LK4EUoDhD8MNGpL8vCSrGKOESVryfZSroJwieYO+aV/zrcg=
X-Google-Smtp-Source: AA0mqf5RcHXLxh4wClwTJ+sdCRhxHg6wKKdKXlFyBmeMuQBZMb6iWnNvGMAHZvmHMvjFHk9vIJ7Vs0S9Whvpr/9nPxg=
X-Received: by 2002:a05:6102:4187:b0:3aa:c58:66 with SMTP id
 cd7-20020a056102418700b003aa0c580066mr8989589vsb.47.1668523340865; Tue, 15
 Nov 2022 06:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20221112152928.42204-1-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221112152928.42204-1-aidanmacdonald.0x0@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 15 Nov 2022 15:42:09 +0100
Message-ID: <CAMRc=MeE97YAzow7MX5380_ucLdUONYqMd3+Nvd6YW_h9oHPJQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: sl28cpld: Replace irqchip mask_invert with unmask_base
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     michael@walle.cc, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 4:29 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> Remove use of the deprecated mask_invert flag. Inverted mask
> registers (where a '1' bit enables an IRQ) can be described more
> directly as an unmask register.
>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/gpio/gpio-sl28cpld.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-sl28cpld.c b/drivers/gpio/gpio-sl28cpld.c
> index 52404736ac86..2195f88c2048 100644
> --- a/drivers/gpio/gpio-sl28cpld.c
> +++ b/drivers/gpio/gpio-sl28cpld.c
> @@ -70,8 +70,7 @@ static int sl28cpld_gpio_irq_init(struct platform_device *pdev,
>         irq_chip->num_irqs = ARRAY_SIZE(sl28cpld_gpio_irqs);
>         irq_chip->num_regs = 1;
>         irq_chip->status_base = base + GPIO_REG_IP;
> -       irq_chip->mask_base = base + GPIO_REG_IE;
> -       irq_chip->mask_invert = true;
> +       irq_chip->unmask_base = base + GPIO_REG_IE;
>         irq_chip->ack_base = base + GPIO_REG_IP;
>
>         ret = devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev),
> --
> 2.38.1
>

Applied, thanks!

Bartosz
