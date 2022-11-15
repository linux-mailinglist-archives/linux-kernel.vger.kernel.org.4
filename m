Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29A46295CE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbiKOK2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238296AbiKOK2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:28:30 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8031A05F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:28:29 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id s204so6337987vkb.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=owVSiCo0xTiIjg+S7LE7MNcpjpqKTahyg6ebxtf7fi4=;
        b=iszNePxr4+6OULyAq0+jPMg5itpWKP30bqSzfoRXUltzE9AgLE80qLrkdCWkrwANV/
         qxQHJX7xsDXrvYSS+8iz+RIiXto6NXF89UUlmmmm9R4/tn3DvtA9Pc7Ux2/5LyJl/nyT
         y+Dj4TygzJbXibhvr8Z0p8AWF3KP5rddtxBjiyDElHkiXCtayd3wnB2kkPz5BfvOS9oT
         TbwaPqvNNsJETy7ut27UFc+7TDFCABqlsrvYYiOP0mGZ2eXo69W2iF4SxsR4JRb4Nlb4
         nLWbdpxBbORKqPfECl+6WOnpIS8ksPCHoZOr4rktlPmnx+sHK3cWCX0U+0hLqy88muNk
         Edsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owVSiCo0xTiIjg+S7LE7MNcpjpqKTahyg6ebxtf7fi4=;
        b=4TSFVGuYFlqklS2paTw8Gqla+cswgocY7mt1+ULwlB55zLY44eLUuCvC69aGrrl6nz
         RPDsAXCe9s7Z1kZMXLTX+agSLY9gLBU/YKP3OY+Lk8at9n7qWksoR0b8Z+EWO60xZ3I3
         4BUlb10B2qd37dSmwhjCCpuzcahcmw+8fWAsacRbzS2CScJAGKsECdokRyosvcbcF9R9
         +qpk9BOtg8nCPPk8ki+Ou0xHJOOqxFkXgJh48YEdWZ6rYft9nRSANxGVLvWwTG4zO0os
         JKnMgtpEcVmtyoOKZ+vi/cxoC21YVXwSd6nRcPmmPwnLpZOGlxnz2nS1vspxk5BhjHb/
         Hlxg==
X-Gm-Message-State: ANoB5pl+kd8/zAZpU4HTv/fvjAesUbfZKKTHY0vabIrkEcXuzdZyd05Y
        PfagB/sWSd9klkG2/vCz7rJWfDJe2+waEH0j5xPx2A==
X-Google-Smtp-Source: AA0mqf5pgRlnwBXZmzHSzvSNJ0lZhazKM56aYr1xj6lzRytjZxFpUNw/z31FQd98R0hQFFA9oBtyuzwaGkiV5tGxU/Q=
X-Received: by 2002:a1f:27c6:0:b0:3ab:85c0:e1e8 with SMTP id
 n189-20020a1f27c6000000b003ab85c0e1e8mr9462160vkn.1.1668508108278; Tue, 15
 Nov 2022 02:28:28 -0800 (PST)
MIME-Version: 1.0
References: <20221031-gpiolib-swnode-v4-0-6c1671890027@gmail.com>
In-Reply-To: <20221031-gpiolib-swnode-v4-0-6c1671890027@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 15 Nov 2022 11:28:17 +0100
Message-ID: <CAMRc=Mf+FFyx7Mkw-nLMaoayJUjZbkEHDkVCsa_L+XkX6sEQDQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Add support for software nodes to gpiolib
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 11:19 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> This series attempts to add support for software nodes to gpiolib, using
> software node references. This allows us to convert more drivers to the
> generic device properties and drop support for custom platform data.
>
> To describe a GPIO via software nodes we can create the following data
> items:
>
> /* Node representing the GPIO controller/GPIO bank */
> static const struct software_node gpio_bank_b_node = {
>         .name = "B",
> };
>
> /*
>  * Properties that will be assigned to a software node assigned to
>  * the device that used platform data.
>  */
> static const struct property_entry simone_key_enter_props[] = {
>         PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
>         PROPERTY_ENTRY_STRING("label", "enter"),
>         PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
>         { }
> };
>
> The code in gpiolib handling software nodes uses the name in the
> software node representing GPIO controller to locate the actual instance
> of GPIO controller.
>
> To: Linus Walleij <linus.walleij@linaro.org>
> To: Bartosz Golaszewski <brgl@bgdev.pl>
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
>
> ---
> Changes in v4:
> - Rebased on top of next-20221111
> - Added Andy's reviewed-by for patch #6
> - Link to v3: https://lore.kernel.org/r/20221031-gpiolib-swnode-v3-0-0282162b0fa4@gmail.com
>
> Changes in v3:
> - Addressed more Andy's comments
> - Link to v2: https://lore.kernel.org/r/20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com
>
> Changes in v2:
> - reworked the series to be independent of other in-flight patches.
>   That meant keeping devm_gpiod_get_from_of_node() for now.
> - removed handling of secondary nodes, it deserves a separate patch
>   series
> - fixed refcounting when handling swnodes (Andy)
> - added include/linux/gpio/property.h with PROPERTY_ENTRY_GPIO (Andy)
> - addressed most of the rest of Andy's comments
> - collected reviewed-by and acked-by
> - Link to v1: https://lore.kernel.org/r/20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com
>
> ---
> Dmitry Torokhov (6):
>       gpiolib: of: change of_find_gpio() to accept device node
>       gpiolib: acpi: change acpi_find_gpio() to accept firmware node
>       gpiolib: acpi: teach acpi_find_gpio() to handle data-only nodes
>       gpiolib: acpi: avoid leaking ACPI details into upper gpiolib layers
>       gpiolib: consolidate GPIO lookups
>       gpiolib: add support for software nodes
>
>  drivers/gpio/Makefile         |   1 +
>  drivers/gpio/gpiolib-acpi.c   | 132 +++++++++++++++-----------
>  drivers/gpio/gpiolib-acpi.h   |  54 +----------
>  drivers/gpio/gpiolib-of.c     |   7 +-
>  drivers/gpio/gpiolib-of.h     |   4 +-
>  drivers/gpio/gpiolib-swnode.c | 123 +++++++++++++++++++++++++
>  drivers/gpio/gpiolib-swnode.h |  14 +++
>  drivers/gpio/gpiolib.c        | 209 ++++++++++++++++--------------------------
>  include/linux/gpio/property.h |  11 +++
>  9 files changed, 315 insertions(+), 240 deletions(-)
> ---
> base-commit: f8f60f322f0640c8edda2942ca5f84b7a27c417a
> change-id: 20221031-gpiolib-swnode-948203f49b23
>
> --
> Dmitry
>

I still had some fuzz when applying, can you for the future rebase on
top of the GPIO for-next branch?

Anyway: series applied.

Bart
