Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A35E62F0FE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241878AbiKRJVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241106AbiKRJVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:21:35 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF26634E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:21:34 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p12so4059194plq.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JSBtVRBPThiOCt4OMqW5r2eP8fJ3PlRZv8a9mbCR2ng=;
        b=QGCZaALPcWWUDY0hBvTPNUkgwbyNMJMi9Kdc9y83HpjRJR773UQs4u5aAfNli3E/t1
         dbqdfsJdJ0EU4Pdbuw04uLe6gBRy2Jl9m/ED8CnVis7I3eHMsNf+o6Fo7Z0pixYaAJyg
         2BFsbYNWQ9S85+up3JEFcPiCPe7nI22uZNZc8lOjn9FJaOBZUWY1fn6aEWsDdcRzhQzg
         gRebIYEVZVAyrHsouXRx1pMno3PRk9Bm2i36EpplkLdV1cwmpmQ0/if+6W3IcLipCjEv
         /0hJCmsJ8dawFX4irkxbBJ29VGBsXiQCfgBQZV9NXO7zbu9zFM4n62KttlbfHFzPNkOP
         WeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSBtVRBPThiOCt4OMqW5r2eP8fJ3PlRZv8a9mbCR2ng=;
        b=QtXHXDu9dkQuufaHWFgGcnOSz/29NyaIj/agLkdMnKM2xb4BO3GfdTqlTRPHNPlmbx
         lAfAIuQDSrbSRyJq8PNPTVRQ8wzaTC6joch9EK9Hjqg6oWpKZRiUERGoVNY5jbbj6GDp
         0HmAUkNKFBdwv3FKQ/qbj18qurV0bzHb+qE/hmoCU/lqTFyLs0EBIl7bE+RAAm8/Lmqw
         /i7lHFQxwks+wtv4poz99iFo+3mW8sV0oddP8XDT9xn0wpUesfO0CSPnoTcIMayiI5lr
         nLTwhJWSarDRl0pqzo+LFPR/B/+FwwQUTWANdWEXKRkICa5l6jxP/+pevEqqhq6uGXaD
         opmw==
X-Gm-Message-State: ANoB5pmXqCtovLnA2kvvldYPiwpPT9D6n8fKIBW4UK07g6TJIPREYehm
        sTPeKr3kbvZk+KLDckJpR8cGE93/6yfmiFgxgPm6IQ==
X-Google-Smtp-Source: AA0mqf6z7qH4IIvdEP5gTVy/4UVbBAxcThGSsew1HQ8xP49N/7Q1LCA94tIOcd//mwzUzQBWZKHLXD2sDpdvcva3sW0=
X-Received: by 2002:a17:902:6bc5:b0:188:6baf:2011 with SMTP id
 m5-20020a1709026bc500b001886baf2011mr6376704plt.165.1668763294188; Fri, 18
 Nov 2022 01:21:34 -0800 (PST)
MIME-Version: 1.0
References: <20221117041430.9108-1-balamanikandan.gunasundar@microchip.com> <20221117041430.9108-2-balamanikandan.gunasundar@microchip.com>
In-Reply-To: <20221117041430.9108-2-balamanikandan.gunasundar@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Nov 2022 10:20:57 +0100
Message-ID: <CAPDyKFppRq1Zo4t6uZiJuRLFR-Om1-52=OUJaEQKZ1SNdVyWAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: atmel-mci: Convert to gpio descriptors
To:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
Cc:     ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linus.walleij@linaro.org, hari.prasathge@microchip.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- trimmed cc-list, + Dmitry

On Thu, 17 Nov 2022 at 05:15, Balamanikandan Gunasundar
<balamanikandan.gunasundar@microchip.com> wrote:
>
> Replace the legacy GPIO APIs with gpio descriptor consumer interface.
>
> To maintain backward compatibility, we rely on the "cd-inverted"
> property to manage the invertion flag instead of GPIO property.
>
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>

Looks like you didn't make the conversion from
devm_gpiod_get_from_of_node() into devm_fwnode_gpiod_get(), that
Dmitry suggested [1]. Please re-spin and add Dmitry to the cc-list
next time, to allow him to complete the review.

Kind regards
Uffe

[1]
https://lore.kernel.org/all/Y21+L01BcPQ35FYi@google.com/

> ---
>  drivers/mmc/host/atmel-mci.c | 80 ++++++++++++++++++------------------
>  include/linux/atmel-mci.h    |  4 +-
>  2 files changed, 41 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 67b2cd166e56..f6194aab17df 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -11,7 +11,6 @@
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
> -#include <linux/gpio.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -19,7 +18,8 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> -#include <linux/of_gpio.h>
> +#include <linux/irq.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/scatterlist.h>
>  #include <linux/seq_file.h>
> @@ -389,8 +389,8 @@ struct atmel_mci_slot {
>  #define ATMCI_CARD_NEED_INIT   1
>  #define ATMCI_SHUTDOWN         2
>
> -       int                     detect_pin;
> -       int                     wp_pin;
> +       struct gpio_desc        *detect_pin;
> +       struct gpio_desc        *wp_pin;
>         bool                    detect_is_active_high;
>
>         struct timer_list       detect_timer;
> @@ -638,7 +638,11 @@ atmci_of_init(struct platform_device *pdev)
>                         pdata->slot[slot_id].bus_width = 1;
>
>                 pdata->slot[slot_id].detect_pin =
> -                       of_get_named_gpio(cnp, "cd-gpios", 0);
> +                       devm_gpiod_get_from_of_node(&pdev->dev, cnp,
> +                                                   "cd-gpios",
> +                                                   0, GPIOD_IN, "cd-gpios");
> +               if (IS_ERR(pdata->slot[slot_id].detect_pin))
> +                       pdata->slot[slot_id].detect_pin = NULL;
>
>                 pdata->slot[slot_id].detect_is_active_high =
>                         of_property_read_bool(cnp, "cd-inverted");
> @@ -647,7 +651,11 @@ atmci_of_init(struct platform_device *pdev)
>                         of_property_read_bool(cnp, "non-removable");
>
>                 pdata->slot[slot_id].wp_pin =
> -                       of_get_named_gpio(cnp, "wp-gpios", 0);
> +                       devm_gpiod_get_from_of_node(&pdev->dev, cnp,
> +                                                   "wp-gpios",
> +                                                   0, GPIOD_IN, "wp-gpios");
> +               if (IS_ERR(pdata->slot[slot_id].wp_pin))
> +                       pdata->slot[slot_id].wp_pin = NULL;
>         }
>
>         return pdata;
> @@ -1511,8 +1519,8 @@ static int atmci_get_ro(struct mmc_host *mmc)
>         int                     read_only = -ENOSYS;
>         struct atmel_mci_slot   *slot = mmc_priv(mmc);
>
> -       if (gpio_is_valid(slot->wp_pin)) {
> -               read_only = gpio_get_value(slot->wp_pin);
> +       if (slot->wp_pin) {
> +               read_only = gpiod_get_value(slot->wp_pin);
>                 dev_dbg(&mmc->class_dev, "card is %s\n",
>                                 read_only ? "read-only" : "read-write");
>         }
> @@ -1525,8 +1533,8 @@ static int atmci_get_cd(struct mmc_host *mmc)
>         int                     present = -ENOSYS;
>         struct atmel_mci_slot   *slot = mmc_priv(mmc);
>
> -       if (gpio_is_valid(slot->detect_pin)) {
> -               present = !(gpio_get_value(slot->detect_pin) ^
> +       if (slot->detect_pin) {
> +               present = !(gpiod_get_raw_value(slot->detect_pin) ^
>                             slot->detect_is_active_high);
>                 dev_dbg(&mmc->class_dev, "card is %spresent\n",
>                                 present ? "" : "not ");
> @@ -1639,8 +1647,8 @@ static void atmci_detect_change(struct timer_list *t)
>         if (test_bit(ATMCI_SHUTDOWN, &slot->flags))
>                 return;
>
> -       enable_irq(gpio_to_irq(slot->detect_pin));
> -       present = !(gpio_get_value(slot->detect_pin) ^
> +       enable_irq(gpiod_to_irq(slot->detect_pin));
> +       present = !(gpiod_get_raw_value(slot->detect_pin) ^
>                     slot->detect_is_active_high);
>         present_old = test_bit(ATMCI_CARD_PRESENT, &slot->flags);
>
> @@ -2241,9 +2249,9 @@ static int atmci_init_slot(struct atmel_mci *host,
>         dev_dbg(&mmc->class_dev,
>                 "slot[%u]: bus_width=%u, detect_pin=%d, "
>                 "detect_is_active_high=%s, wp_pin=%d\n",
> -               id, slot_data->bus_width, slot_data->detect_pin,
> +               id, slot_data->bus_width, desc_to_gpio(slot_data->detect_pin),
>                 slot_data->detect_is_active_high ? "true" : "false",
> -               slot_data->wp_pin);
> +               desc_to_gpio(slot_data->wp_pin));
>
>         mmc->ops = &atmci_ops;
>         mmc->f_min = DIV_ROUND_UP(host->bus_hz, 512);
> @@ -2279,51 +2287,43 @@ static int atmci_init_slot(struct atmel_mci *host,
>
>         /* Assume card is present initially */
>         set_bit(ATMCI_CARD_PRESENT, &slot->flags);
> -       if (gpio_is_valid(slot->detect_pin)) {
> -               if (devm_gpio_request(&host->pdev->dev, slot->detect_pin,
> -                                     "mmc_detect")) {
> -                       dev_dbg(&mmc->class_dev, "no detect pin available\n");
> -                       slot->detect_pin = -EBUSY;
> -               } else if (gpio_get_value(slot->detect_pin) ^
> -                               slot->detect_is_active_high) {
> +       if (slot->detect_pin) {
> +               if (gpiod_get_raw_value(slot->detect_pin) ^
> +                   slot->detect_is_active_high) {
>                         clear_bit(ATMCI_CARD_PRESENT, &slot->flags);
>                 }
> +       } else {
> +               dev_dbg(&mmc->class_dev, "no detect pin available\n");
>         }
>
> -       if (!gpio_is_valid(slot->detect_pin)) {
> +       if (!slot->detect_pin) {
>                 if (slot_data->non_removable)
>                         mmc->caps |= MMC_CAP_NONREMOVABLE;
>                 else
>                         mmc->caps |= MMC_CAP_NEEDS_POLL;
>         }
>
> -       if (gpio_is_valid(slot->wp_pin)) {
> -               if (devm_gpio_request(&host->pdev->dev, slot->wp_pin,
> -                                     "mmc_wp")) {
> -                       dev_dbg(&mmc->class_dev, "no WP pin available\n");
> -                       slot->wp_pin = -EBUSY;
> -               }
> -       }
> +       if (!slot->wp_pin)
> +               dev_dbg(&mmc->class_dev, "no WP pin available\n");
>
>         host->slot[id] = slot;
>         mmc_regulator_get_supply(mmc);
> -       mmc_pwrseq_alloc(slot->mmc);
>         mmc_add_host(mmc);
>
> -       if (gpio_is_valid(slot->detect_pin)) {
> +       if (slot->detect_pin) {
>                 int ret;
>
>                 timer_setup(&slot->detect_timer, atmci_detect_change, 0);
>
> -               ret = request_irq(gpio_to_irq(slot->detect_pin),
> -                               atmci_detect_interrupt,
> -                               IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
> -                               "mmc-detect", slot);
> +               ret = request_irq(gpiod_to_irq(slot->detect_pin),
> +                                 atmci_detect_interrupt,
> +                                 IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
> +                                 "mmc-detect", slot);
>                 if (ret) {
>                         dev_dbg(&mmc->class_dev,
>                                 "could not request IRQ %d for detect pin\n",
> -                               gpio_to_irq(slot->detect_pin));
> -                       slot->detect_pin = -EBUSY;
> +                               gpiod_to_irq(slot->detect_pin));
> +                       slot->detect_pin = NULL;
>                 }
>         }
>
> @@ -2342,10 +2342,8 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
>
>         mmc_remove_host(slot->mmc);
>
> -       if (gpio_is_valid(slot->detect_pin)) {
> -               int pin = slot->detect_pin;
> -
> -               free_irq(gpio_to_irq(pin), slot);
> +       if (slot->detect_pin) {
> +               free_irq(gpiod_to_irq(slot->detect_pin), slot);
>                 del_timer_sync(&slot->detect_timer);
>         }
>
> diff --git a/include/linux/atmel-mci.h b/include/linux/atmel-mci.h
> index 1491af38cc6e..017e7d8f6126 100644
> --- a/include/linux/atmel-mci.h
> +++ b/include/linux/atmel-mci.h
> @@ -26,8 +26,8 @@
>   */
>  struct mci_slot_pdata {
>         unsigned int            bus_width;
> -       int                     detect_pin;
> -       int                     wp_pin;
> +       struct gpio_desc        *detect_pin;
> +       struct gpio_desc        *wp_pin;
>         bool                    detect_is_active_high;
>         bool                    non_removable;
>  };
> --
> 2.25.1
>
